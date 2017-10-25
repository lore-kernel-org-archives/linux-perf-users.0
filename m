From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/15] perf callchain: Refactor inline_list to operate on symbols
Date: Wed, 25 Oct 2017 13:00:01 -0300
Message-ID: <20171025160013.11136-4-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Milian Wolff <milian.wolff@kdab.com>

This is a requirement to create real callchain entries for inlined
frames.

Since the list of inlines usually contains the target symbol too, i.e.
the location where the frames get inlined to, we alias that symbol and
reuse it as-is is. This ensures that other dependent functionality keeps
working, most notably annotation of the target frames.

For all other entries in the inline_list, a fake symbol is created.
These are marked by new 'inlined' member which is set to true. Only
those symbols are managed by the inline_list and get freed when the
inline_list is deleted from within inline_node__delete.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-4-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/srcline.c | 93 ++++++++++++++++++++++++++++++++---------------
 tools/perf/util/srcline.h |  7 +++-
 tools/perf/util/symbol.h  |  1 +
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index ed8e8d2de942..c0af61b355ed 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -33,29 +33,19 @@ static const char *dso__name(struct dso *dso)
 	return dso_name;
 }
 
-static int inline_list__append(char *filename, char *funcname, int line_nr,
-			       struct inline_node *node, struct dso *dso)
+static int inline_list__append(struct symbol *symbol, char *filename,
+			       int line_nr, struct inline_node *node)
 {
 	struct inline_list *ilist;
-	char *demangled;
 
 	ilist = zalloc(sizeof(*ilist));
 	if (ilist == NULL)
 		return -1;
 
+	ilist->symbol = symbol;
 	ilist->filename = filename;
 	ilist->line_nr = line_nr;
 
-	if (dso != NULL) {
-		demangled = dso__demangle_sym(dso, 0, funcname);
-		if (demangled == NULL) {
-			ilist->funcname = funcname;
-		} else {
-			ilist->funcname = demangled;
-			free(funcname);
-		}
-	}
-
 	if (callchain_param.order == ORDER_CALLEE)
 		list_add_tail(&ilist->list, &node->val);
 	else
@@ -206,19 +196,56 @@ static void addr2line_cleanup(struct a2l_data *a2l)
 
 #define MAX_INLINE_NEST 1024
 
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
 static int inline_list__append_dso_a2l(struct dso *dso,
-				       struct inline_node *node)
+				       struct inline_node *node,
+				       struct symbol *sym)
 {
 	struct a2l_data *a2l = dso->a2l;
-	char *funcname = a2l->funcname ? strdup(a2l->funcname) : NULL;
-	char *filename = a2l->filename ? strdup(a2l->filename) : NULL;
+	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
 
-	return inline_list__append(filename, funcname, a2l->line, node, dso);
+	return inline_list__append(inline_sym, strdup(a2l->filename),
+				   a2l->line, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
-		     bool unwind_inlines, struct inline_node *node)
+		     bool unwind_inlines, struct inline_node *node,
+		     struct symbol *sym)
 {
 	int ret = 0;
 	struct a2l_data *a2l = dso->a2l;
@@ -244,7 +271,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	if (unwind_inlines) {
 		int cnt = 0;
 
-		if (node && inline_list__append_dso_a2l(dso, node))
+		if (node && inline_list__append_dso_a2l(dso, node, sym))
 			return 0;
 
 		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
@@ -255,7 +282,7 @@ static int addr2line(const char *dso_name, u64 addr,
 				a2l->filename = NULL;
 
 			if (node != NULL) {
-				if (inline_list__append_dso_a2l(dso, node))
+				if (inline_list__append_dso_a2l(dso, node, sym))
 					return 0;
 				// found at least one inline frame
 				ret = 1;
@@ -287,7 +314,7 @@ void dso__free_a2l(struct dso *dso)
 }
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-	struct dso *dso)
+					struct dso *dso, struct symbol *sym)
 {
 	struct inline_node *node;
 
@@ -300,7 +327,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node))
+	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym))
 		goto out_free_inline_node;
 
 	if (list_empty(&node->val))
@@ -340,7 +367,8 @@ static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line_nr,
 		     struct dso *dso __maybe_unused,
 		     bool unwind_inlines __maybe_unused,
-		     struct inline_node *node __maybe_unused)
+		     struct inline_node *node __maybe_unused,
+		     struct symbol *sym __maybe_unused)
 {
 	FILE *fp;
 	char cmd[PATH_MAX];
@@ -380,7 +408,8 @@ void dso__free_a2l(struct dso *dso __maybe_unused)
 }
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-	struct dso *dso __maybe_unused)
+					struct dso *dso __maybe_unused,
+					struct symbol *sym)
 {
 	FILE *fp;
 	char cmd[PATH_MAX];
@@ -408,13 +437,13 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	node->addr = addr;
 
 	while (getline(&filename, &len, fp) != -1) {
+
 		if (filename_split(filename, &line_nr) != 1) {
 			free(filename);
 			goto out;
 		}
 
-		if (inline_list__append(filename, NULL, line_nr, node,
-					NULL) != 0)
+		if (inline_list__append(sym, filename, line_nr, node) != 0)
 			goto out;
 
 		filename = NULL;
@@ -454,7 +483,8 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (dso_name == NULL)
 		goto out;
 
-	if (!addr2line(dso_name, addr, &file, &line, dso, unwind_inlines, NULL))
+	if (!addr2line(dso_name, addr, &file, &line, dso,
+		       unwind_inlines, NULL, sym))
 		goto out;
 
 	if (asprintf(&srcline, "%s:%u",
@@ -500,7 +530,8 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
 }
 
-struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
+struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
+					    struct symbol *sym)
 {
 	const char *dso_name;
 
@@ -508,7 +539,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
 	if (dso_name == NULL)
 		return NULL;
 
-	return addr2inlines(dso_name, addr, dso);
+	return addr2inlines(dso_name, addr, dso, sym);
 }
 
 void inline_node__delete(struct inline_node *node)
@@ -518,7 +549,9 @@ void inline_node__delete(struct inline_node *node)
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
 		zfree(&ilist->filename);
-		zfree(&ilist->funcname);
+		/* only the inlined symbols are owned by the list */
+		if (ilist->symbol && ilist->symbol->inlined)
+			symbol__delete(ilist->symbol);
 		free(ilist);
 	}
 
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 7b52ba88676e..730bfd6926d7 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -17,8 +17,8 @@ void free_srcline(char *srcline);
 #define SRCLINE_UNKNOWN  ((char *) "??:0")
 
 struct inline_list {
+	struct symbol		*symbol;
 	char			*filename;
-	char			*funcname;
 	unsigned int		line_nr;
 	struct list_head	list;
 };
@@ -28,7 +28,10 @@ struct inline_node {
 	struct list_head	val;
 };
 
-struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr);
+/* parse inlined frames for the given address */
+struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
+					    struct symbol *sym);
+/* free resources associated to the inline node list */
 void inline_node__delete(struct inline_node *node);
 
 #endif /* PERF_SRCLINE_H */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index aad99e7e179b..d880a059babb 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -59,6 +59,7 @@ struct symbol {
 	u8		binding;
 	u8		idle:1;
 	u8		ignore:1;
+	u8		inlined:1;
 	u8		arch_sym;
 	char		name[0];
 };
-- 
2.13.6
