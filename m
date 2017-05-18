From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH 4/7] perf report: use srcline from inlined frames
Date: Thu, 18 May 2017 21:34:08 +0200
Message-ID: <20170518193411.22380-5-milian.wolff@kdab.com>
References: <20170518193411.22380-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170518193411.22380-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

Instead of looking up the srcline based on the IP associated with
a given callchain entry, add a new srcline member and use that.
This member is set either based on the IP for non-inlined frames,
or uses the DWARF data for inlined frames.

To ensure we don't duplicate the work for inlined frames, and also
to ensure we properly free the allocated resources, the srcline
strings are associated with the inlined_list entries cached by the
DSO.

To enable this patch, we put the existing code to merge a fileline
pair into a srcline string. This function honors the global
srcline_full_filename setting, and displays only the basename if
this is set to true (the default). Because we want to be able to
get the basename for a `const char*` we get fro a2l, a GNU-like
implementation of basename is added (the posix version requires
a non-const `char*` input argument).

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c | 26 ++++++++--------------
 tools/perf/util/callchain.h |  5 +++--
 tools/perf/util/machine.c   | 19 +++++++++++++---
 tools/perf/util/srcline.c   | 53 ++++++++++++++++++++++++++++++++++-----------
 tools/perf/util/srcline.h   |  3 +--
 5 files changed, 69 insertions(+), 37 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 81fc29ac798f..3a349530fee1 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -558,6 +558,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call->ip = cursor_node->ip;
 		call->ms.sym = cursor_node->sym;
 		call->ms.map = map__get(cursor_node->map);
+		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
 			call->branch_count = 1;
@@ -621,12 +622,8 @@ enum match_result {
 static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 					     struct callchain_list *cnode)
 {
-	char *left = get_srcline(cnode->ms.map->dso,
-				 map__rip_2objdump(cnode->ms.map, cnode->ip),
-				 cnode->ms.sym, true, false);
-	char *right = get_srcline(node->map->dso,
-				  map__rip_2objdump(node->map, node->ip),
-				  node->sym, true, false);
+	const char *left = cnode->srcline;
+	const char *right = node->srcline;
 	enum match_result ret = MATCH_EQ;
 	int cmp;
 
@@ -644,8 +641,6 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 	if (cmp != 0)
 		ret = cmp < 0 ? MATCH_LT : MATCH_GT;
 
-	free_srcline(left);
-	free_srcline(right);
 	return ret;
 }
 
@@ -917,7 +912,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0);
+					false, NULL, 0, 0, list->srcline);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -957,7 +952,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples)
+			    int nr_loop_iter, int samples, const char *srcline)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -976,6 +971,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->samples = samples;
+	node->srcline = srcline;
 
 	if (flags)
 		memcpy(&node->branch_flags, flags,
@@ -1061,12 +1057,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
 	int printed;
 
 	if (cl->ms.sym) {
-		if (show_srcline && cl->ms.map && !cl->srcline)
-			cl->srcline = get_srcline(cl->ms.map->dso,
-						  map__rip_2objdump(cl->ms.map,
-								    cl->ip),
-						  cl->ms.sym, false, show_addr);
-		if (cl->srcline)
+		if (show_srcline && cl->srcline)
 			printed = scnprintf(bf, bfsize, "%s %s",
 					cl->ms.sym->name, cl->srcline);
 		else
@@ -1454,7 +1445,8 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
-					     node->nr_loop_iter, node->samples);
+					     node->nr_loop_iter, node->samples,
+					     node->srcline);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c56c23dbbf72..16f51a20df6a 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -119,7 +119,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			samples_count;
-	char		       *srcline;
+	const char		*srcline;
 	struct list_head	list;
 };
 
@@ -133,6 +133,7 @@ struct callchain_cursor_node {
 	u64				ip;
 	struct map			*map;
 	struct symbol			*sym;
+	const char			*srcline;
 	bool				branch;
 	struct branch_flags		branch_flags;
 	int				nr_loop_iter;
@@ -198,7 +199,7 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples);
+			    int nr_loop_iter, int samples, const char *srcline);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 64bfa8b43706..df2f1e618360 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1679,6 +1679,15 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 	return mi;
 }
 
+static char *callchain_srcline(struct map *map, struct symbol *sym, u64 ip)
+{
+	if (!map || callchain_param.key == CCKEY_FUNCTION)
+		return NULL;
+
+	return get_srcline(map->dso, map__rip_2objdump(map, ip),
+			   sym, false, callchain_param.key == CCKEY_ADDRESS);
+}
+
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
 			    struct symbol **parent,
@@ -1741,7 +1750,9 @@ static int add_callchain_ip(struct thread *thread,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
-				       branch, flags, nr_loop_iter, samples);
+				       branch, flags, nr_loop_iter, samples,
+				       callchain_srcline(al.map, al.sym,
+							 al.addr));
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -2055,7 +2066,7 @@ static int append_inlines(struct callchain_cursor *cursor,
 	list_for_each_entry(ilist, &inline_node->val, list) {
 		int ret = callchain_cursor_append(cursor, ip, map,
 						  ilist->symbol, false,
-						  NULL, 0, 0);
+						  NULL, 0, 0, ilist->srcline);
 
 		if (ret != 0)
 			return ret;
@@ -2076,7 +2087,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0,
+				       callchain_srcline(entry->map, entry->sym,
+							 entry->ip));
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 25ceed8eb790..a1fdf035d1dd 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -33,7 +33,7 @@ static const char *dso__name(struct dso *dso)
 	return dso_name;
 }
 
-static int inline_list__append(struct symbol *symbol, char *filename, int line_nr,
+static int inline_list__append(struct symbol *symbol, char *srcline,
 			       struct inline_node *node)
 {
 	struct inline_list *ilist;
@@ -43,8 +43,7 @@ static int inline_list__append(struct symbol *symbol, char *filename, int line_n
 		return -1;
 
 	ilist->symbol = symbol;
-	ilist->filename = filename;
-	ilist->line_nr = line_nr;
+	ilist->srcline = srcline;
 
 	if (callchain_param.order == ORDER_CALLEE)
 		list_add_tail(&ilist->list, &node->val);
@@ -54,6 +53,30 @@ static int inline_list__append(struct symbol *symbol, char *filename, int line_n
 	return 0;
 }
 
+// basename version that takes a const input string
+static const char *gnu_basename(const char *path)
+{
+	const char *base = strrchr(path, '/');
+
+	return base ? base + 1 : path;
+}
+
+static char *srcline_from_fileline(const char *file, unsigned int line)
+{
+	char *srcline;
+
+	if (!file)
+		return NULL;
+
+	if (!srcline_full_filename)
+		file = gnu_basename(file);
+
+	if (asprintf(&srcline, "%s:%u", file, line) < 0)
+		return NULL;
+
+	return srcline;
+}
+
 #ifdef HAVE_LIBBFD_SUPPORT
 
 /*
@@ -229,10 +252,13 @@ static int inline_list__append_dso_a2l(struct dso *dso,
 				       struct symbol *sym)
 {
 	struct a2l_data *a2l = dso->a2l;
-	char *filename = a2l->filename ? strdup(a2l->filename) : NULL;
 	struct symbol *inline_sym = new_inline_sym(dso, sym, a2l->funcname);
+	char *srcline = NULL;
+
+	if (a2l->filename)
+		srcline = srcline_from_fileline(a2l->filename, a2l->line);
 
-	return inline_list__append(inline_sym, filename, a2l->line, node);
+	return inline_list__append(inline_sym, srcline, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
@@ -426,12 +452,15 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	node->addr = addr;
 
 	while (getline(&filename, &len, fp) != -1) {
+		char *srcline;
+
 		if (filename_split(filename, &line_nr) != 1) {
 			free(filename);
 			goto out;
 		}
 
-		if (inline_list__append(sym, filename, line_nr, node) != 0)
+		srcline = srcline_from_fileline(filename, line_nr);
+		if (inline_list__append(sym, srcline, node) != 0)
 			goto out;
 
 		filename = NULL;
@@ -475,16 +504,14 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 		       unwind_inlines, NULL, sym))
 		goto out;
 
-	if (asprintf(&srcline, "%s:%u",
-				srcline_full_filename ? file : basename(file),
-				line) < 0) {
-		free(file);
+	srcline = srcline_from_fileline(file, line);
+	free(file);
+
+	if (!srcline)
 		goto out;
-	}
 
 	dso->a2l_fails = 0;
 
-	free(file);
 	return srcline;
 
 out:
@@ -536,7 +563,7 @@ void inline_node__delete(struct inline_node *node)
 
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
-		zfree(&ilist->filename);
+		zfree(&ilist->srcline);
 		// only the inlined symbols are owned by the list
 		if (ilist->symbol && ilist->symbol->inlined)
 			symbol__delete(ilist->symbol);
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index ad9726987b80..0d2aca92e8c7 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -19,8 +19,7 @@ void free_srcline(char *srcline);
 
 struct inline_list {
 	struct symbol		*symbol;
-	char			*filename;
-	unsigned int		line_nr;
+	char			*srcline;
 	struct list_head	list;
 };
 
-- 
2.13.0
