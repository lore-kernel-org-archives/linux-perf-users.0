From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 19/19] perf srcline: Show correct function name for srcline of callchains
Date: Fri,  3 Nov 2017 10:55:03 -0300
Message-ID: <20171103135503.4921-20-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, kernel-team@lge.com, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

When libbfd is not used, it doesn't show proper function name and reuse
the original symbol of the sample.  That's because it passes the
original sym to inline_list__append().  As `addr2line -f` returns
function names as well, use that to create an inline_sym and pass it to
inline_list__append().

For example, following data shows that inlined entries of main have same
name (main).

Before:
  $ perf report -g srcline -q | head
      45.22%  inlining     libm-2.26.so      [.] __hypot_finite
              |
              ---__hypot_finite ??:0
                 |
                 |--44.15%--hypot ??:0
                 |          main complex:589
                 |          main complex:597
                 |          main complex:654
                 |          main complex:664
                 |          main inlining.cpp:14

After:
  $ perf report -g srcline -q | head
      45.22%  inlining     libm-2.26.so      [.] __hypot_finite
              |
              ---__hypot_finite
                 |
                 |--44.15%--hypot
                 |          std::__complex_abs complex:589 (inlined)
                 |          std::abs<double> complex:597 (inlined)
                 |          std::_Norm_helper<true>::_S_do_it<double> complex:654 (inlined)
                 |          std::norm<double> complex:664 (inlined)
                 |          main inlining.cpp:14

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Milian Wolff <milian.wolff@kdab.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-team@lge.com
Link: http://lkml.kernel.org/r/20171031020654.31163-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 95 +++++++++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 40 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 51dc49c65476..ad1b46f1f2cf 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -10,7 +10,7 @@
 #include "util/debug.h"
 #include "util/callchain.h"
 #include "srcline.h"
-
+#include "string2.h"
 #include "symbol.h"
 
 bool srcline_full_filename;
@@ -77,6 +77,41 @@ static char *srcline_from_fileline(const char *file, unsigned int line)
 	return srcline;
 }
 
+static struct symbol *new_inline_sym(struct dso *dso,
+				     struct symbol *base_sym,
+				     const char *funcname)
+{
+	struct symbol *inline_sym;
+	char *demangled = NULL;
+
+	if (dso) {
+		demangled = dso__demangle_sym(dso, 0, funcname);
+		if (demangled)
+			funcname = demangled;
+	}
+
+	if (base_sym && strcmp(funcname, base_sym->name) == 0) {
+		/* reuse the real, existing symbol */
+		inline_sym = base_sym;
+		/* ensure that we don't alias an inlined symbol, which could
+		 * lead to double frees in inline_node__delete
+		 */
+		assert(!base_sym->inlined);
+	} else {
+		/* create a fake symbol for the inline frame */
+		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
+					 base_sym ? base_sym->end : 0,
+					 base_sym ? base_sym->binding : 0,
+					 funcname);
+		if (inline_sym)
+			inline_sym->inlined = 1;
+	}
+
+	free(demangled);
+
+	return inline_sym;
+}
+
 #ifdef HAVE_LIBBFD_SUPPORT
 
 /*
@@ -219,41 +254,6 @@ static void addr2line_cleanup(struct a2l_data *a2l)
 
 #define MAX_INLINE_NEST 1024
 
-static struct symbol *new_inline_sym(struct dso *dso,
-				     struct symbol *base_sym,
-				     const char *funcname)
-{
-	struct symbol *inline_sym;
-	char *demangled = NULL;
-
-	if (dso) {
-		demangled = dso__demangle_sym(dso, 0, funcname);
-		if (demangled)
-			funcname = demangled;
-	}
-
-	if (base_sym && strcmp(funcname, base_sym->name) == 0) {
-		/* reuse the real, existing symbol */
-		inline_sym = base_sym;
-		/* ensure that we don't alias an inlined symbol, which could
-		 * lead to double frees in inline_node__delete
-		 */
-		assert(!base_sym->inlined);
-	} else {
-		/* create a fake symbol for the inline frame */
-		inline_sym = symbol__new(base_sym ? base_sym->start : 0,
-					 base_sym ? base_sym->end : 0,
-					 base_sym ? base_sym->binding : 0,
-					 funcname);
-		if (inline_sym)
-			inline_sym->inlined = 1;
-	}
-
-	free(demangled);
-
-	return inline_sym;
-}
-
 static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct inline_node *node,
 				       struct symbol *sym)
@@ -432,10 +432,11 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	char cmd[PATH_MAX];
 	struct inline_node *node;
 	char *filename = NULL;
-	size_t len;
+	char *funcname = NULL;
+	size_t filelen, funclen;
 	unsigned int line_nr = 0;
 
-	scnprintf(cmd, sizeof(cmd), "addr2line -e %s -i %016"PRIx64,
+	scnprintf(cmd, sizeof(cmd), "addr2line -e %s -i -f %016"PRIx64,
 		  dso_name, addr);
 
 	fp = popen(cmd, "r");
@@ -453,20 +454,34 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	while (getline(&filename, &len, fp) != -1) {
+	/* addr2line -f generates two lines for each inlined functions */
+	while (getline(&funcname, &funclen, fp) != -1) {
 		char *srcline;
+		struct symbol *inline_sym;
+
+		rtrim(funcname);
+
+		if (getline(&filename, &filelen, fp) == -1)
+			goto out;
 
 		if (filename_split(filename, &line_nr) != 1)
 			goto out;
 
 		srcline = srcline_from_fileline(filename, line_nr);
-		if (inline_list__append(sym, srcline, node) != 0)
+		inline_sym = new_inline_sym(dso, sym, funcname);
+
+		if (inline_list__append(inline_sym, srcline, node) != 0) {
+			free(srcline);
+			if (inline_sym && inline_sym->inlined)
+				symbol__delete(inline_sym);
 			goto out;
+		}
 	}
 
 out:
 	pclose(fp);
 	free(filename);
+	free(funcname);
 
 	return node;
 }
-- 
2.13.6
