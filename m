From: Paul Clarke <pc@us.ibm.com>
Subject: [PATCH v5] Allow user probes on versioned symbols.
Date: Wed, 12 Apr 2017 09:41:51 -0500
Message-ID: <967814e0-0d5a-4970-38d8-04d7dae9d5b1@us.ibm.com>
Reply-To: pc@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Symbol versioning, as in glibc, results in symbols being defined as:
<real symbol>@[@]<version>
(Note that "@@" identifies a default symbol, if the symbol name
is repeated.)

perf is currently unable to deal with this, and is unable to create
user probes at such symbols:
--
$ nm /lib/powerpc64le-linux-gnu/libpthread.so.0 | grep pthread_create
0000000000008d30 t __pthread_create_2_1
0000000000008d30 T pthread_create@@GLIBC_2.17
$ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
probe-definition(0): pthread_create
symbol:pthread_create file:(null) line:0 offset:0 return:0 lazy:(null)
0 arguments
Open Debuginfo file: /usr/lib/debug/lib/powerpc64le-linux-gnu/libpthread-2.19.so
Try to find probe point from debuginfo.
Probe point 'pthread_create' not found.
    Error: Failed to add events. Reason: No such file or directory (Code: -2)
--

One is not able to specify the fully versioned symbol, either, due to
syntactic conflicts with other uses of "@" by perf:
--
$ /usr/bin/sudo perf probe -v -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create@@GLIBC_2.17
probe-definition(0): pthread_create@@GLIBC_2.17
Semantic error :SRC@SRC is not allowed.
0 arguments
    Error: Command Parse Error. Reason: Invalid argument (Code: -22)
--

This patch ignores versioning for default symbols, thus
allowing probes to be created for these symbols:
--
$ /usr/bin/sudo ./perf probe -x /lib/powerpc64le-linux-gnu/libpthread.so.0 pthread_create
Added new event:
    probe_libpthread:pthread_create (on pthread_create in /lib/powerpc64le-linux-gnu/libpthread-2.19.so)

You can now use it in all perf tools, such as:

          perf record -e probe_libpthread:pthread_create -aR sleep 1

$ /usr/bin/sudo ./perf record -e probe_libpthread:pthread_create -aR ./test 2
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.052 MB perf.data (2 samples) ]
$ /usr/bin/sudo ./perf script
              test  2915 [000] 19124.260729: probe_libpthread:pthread_create: (3fff99248d38)
              test  2916 [000] 19124.260962: probe_libpthread:pthread_create: (3fff99248d38)
$ /usr/bin/sudo ./perf probe --del=probe_libpthread:pthread_create
Removed event: probe_libpthread:pthread_create
--

Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
---
v5:
- now using new enum to specify matching semantics (per Masami Hiramatsu)

v4:
- rebased to acme/perf/core
- moved changes from "map" namespace to "symbol" namespace,
- rewrote symbol__compare (now *match) to avoid need for strdup
- new symbol__match_symbol_name to support versioned symbols, ignoring default
    tags
- new arch__compare_symbol_names_n to map to strncmp
- dso__find_symbol_by_name: now tries exact match (as before), then tries
     also adding symbols tagged as default (@@)
- symbols__find_by_name: new parameter to support finding with or without default
    tags
- does NOT handle setting probes using the tagged symbol name (symbol@[@]tag)

v3:
- code style fixes per David Ahern

v2:
- move logic from arch__compare_symbol_names to new map__compare_symbol_names
- call through from map__compare_symbol_names to arch__compare_symbol_names
- redirect uses of arch__compare_symbol_names
- send patch to LKML

  tools/perf/arch/powerpc/util/sym-handling.c | 12 ++++++
  tools/perf/util/map.c                       |  5 ---
  tools/perf/util/map.h                       |  5 ++-
  tools/perf/util/symbol.c                    | 62 +++++++++++++++++++++++------
  tools/perf/util/symbol.h                    | 11 +++++
  5 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 39dbe51..0d40e17 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -52,6 +52,18 @@ int arch__compare_symbol_names(const char *namea, const char *nameb)
  
  	return strcmp(namea, nameb);
  }
+
+int arch__compare_symbol_names_n(const char *namea, const char *nameb,
+	unsigned int n)
+{
+	/* Skip over initial dot */
+	if (*namea == '.')
+		namea++;
+	if (*nameb == '.')
+		nameb++;
+
+	return strncmp(namea, nameb, n);
+}
  #endif
  
  #if defined(_CALL_ELF) && _CALL_ELF == 2
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index c1870ac..f4d8272 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -325,11 +325,6 @@ int map__load(struct map *map)
  	return 0;
  }
  
-int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
-{
-	return strcmp(namea, nameb);
-}
-
  struct symbol *map__find_symbol(struct map *map, u64 addr)
  {
  	if (map__load(map) < 0)
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index c8a5a64..04b7238 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -130,13 +130,14 @@ struct thread;
   */
  #define __map__for_each_symbol_by_name(map, sym_name, pos)	\
  	for (pos = map__find_symbol_by_name(map, sym_name);	\
-	     pos && arch__compare_symbol_names(pos->name, sym_name) == 0;	\
+	     pos &&						\
+	     symbol__match_symbol_name(pos->name, sym_name,	\
+				       SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY) == 0;	\
  	     pos = symbol__next_by_name(pos))
  
  #define map__for_each_symbol_by_name(map, sym_name, pos)		\
  	__map__for_each_symbol_by_name(map, sym_name, (pos))
  
-int arch__compare_symbol_names(const char *namea, const char *nameb);
  void map__init(struct map *map, enum map_type type,
  	       u64 start, u64 end, u64 pgoff, struct dso *dso);
  struct map *map__new(struct machine *machine, u64 start, u64 len,
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 9b4d8ba..24d69f1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -87,6 +87,17 @@ static int prefix_underscores_count(const char *str)
  	return tail - str;
  }
  
+int __weak arch__compare_symbol_names(const char *namea, const char *nameb)
+{
+	return strcmp(namea, nameb);
+}
+
+int __weak arch__compare_symbol_names_n(const char *namea, const char *nameb,
+					unsigned int n)
+{
+	return strncmp(namea, nameb, n);
+}
+
  int __weak arch__choose_best_symbol(struct symbol *syma,
  				    struct symbol *symb __maybe_unused)
  {
@@ -396,8 +407,26 @@ static void symbols__sort_by_name(struct rb_root *symbols,
  	}
  }
  
+int symbol__match_symbol_name(const char *name, const char *str,
+	enum symbols_tag_includes includes)
+{
+	const char *versioning;
+
+	if (includes == SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY &&
+	    (versioning = strstr(name,"@@"))) {
+
+		unsigned int len = strlen(str);
+		if (len < versioning - name)
+			len = versioning - name;
+
+		return arch__compare_symbol_names_n(name, str, len);
+	} else
+		return arch__compare_symbol_names(name, str);
+}
+
  static struct symbol *symbols__find_by_name(struct rb_root *symbols,
-					    const char *name)
+					    const char *name,
+					    unsigned int includes)
  {
  	struct rb_node *n;
  	struct symbol_name_rb_node *s = NULL;
@@ -411,11 +440,12 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
  		int cmp;
  
  		s = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		cmp = arch__compare_symbol_names(name, s->sym.name);
+		cmp = symbol__match_symbol_name(s->sym.name, name,
+						 includes);
  
-		if (cmp < 0)
+		if (cmp > 0)
  			n = n->rb_left;
-		else if (cmp > 0)
+		else if (cmp < 0)
  			n = n->rb_right;
  		else
  			break;
@@ -424,16 +454,17 @@ static struct symbol *symbols__find_by_name(struct rb_root *symbols,
  	if (n == NULL)
  		return NULL;
  
-	/* return first symbol that has same name (if any) */
-	for (n = rb_prev(n); n; n = rb_prev(n)) {
-		struct symbol_name_rb_node *tmp;
+	if (includes != SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY)
+		/* return first symbol that has same name (if any) */
+		for (n = rb_prev(n); n; n = rb_prev(n)) {
+			struct symbol_name_rb_node *tmp;
  
-		tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
-		if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
-			break;
+			tmp = rb_entry(n, struct symbol_name_rb_node, rb_node);
+			if (arch__compare_symbol_names(tmp->sym.name, s->sym.name))
+				break;
  
-		s = tmp;
-	}
+			s = tmp;
+		}
  
  	return &s->sym;
  }
@@ -500,7 +531,12 @@ struct symbol *symbol__next_by_name(struct symbol *sym)
  struct symbol *dso__find_symbol_by_name(struct dso *dso, enum map_type type,
  					const char *name)
  {
-	return symbols__find_by_name(&dso->symbol_names[type], name);
+	struct symbol *s = symbols__find_by_name(&dso->symbol_names[type], name,
+						 SYMBOLS_TAG__INCLUDE_NONE);
+	if (!s)
+		s = symbols__find_by_name(&dso->symbol_names[type], name,
+					  SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY);
+	return s;
  }
  
  void dso__sort_by_name(struct dso *dso, enum map_type type)
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 5245d2f..67b017e 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -348,8 +348,19 @@ void arch__sym_update(struct symbol *s, GElf_Sym *sym);
  #define SYMBOL_A 0
  #define SYMBOL_B 1
  
+int arch__compare_symbol_names(const char *namea, const char *nameb);
+int arch__compare_symbol_names_n(const char *namea, const char *nameb,
+				 unsigned int n);
  int arch__choose_best_symbol(struct symbol *syma, struct symbol *symb);
  
+enum symbols_tag_includes {
+	SYMBOLS_TAG__INCLUDE_NONE,
+	SYMBOLS_TAG__INCLUDE_DEFAULT_ONLY
+};
+
+int symbol__match_symbol_name(const char *namea, const char *nameb,
+			      enum symbols_tag_includes includes);
+
  /* structure containing an SDT note's info */
  struct sdt_note {
  	char *name;			/* name of the note*/
-- 
2.1.4

Regards,
PC
