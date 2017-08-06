From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v2 03/14] perf report: create real callchain entries for inlined frames
Date: Sun,  6 Aug 2017 23:24:35 +0200
Message-ID: <20170806212446.24925-4-milian.wolff@kdab.com>
References: <20170806212446.24925-1-milian.wolff@kdab.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170806212446.24925-1-milian.wolff@kdab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: linux-perf-users.vger.kernel.org

The inlined frames use a fake symbol that is tracked in a special
map inside the dso, which is always sorted by name. All other
entries of the symbol beside the function name are unused for
inline frames. The advantage of this approach is that all existing
users of the callchain API can now transparently display inlined
frames without having to patch their code.

Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/callchain.c |  31 +++-----
 tools/perf/util/callchain.h |   6 +-
 tools/perf/util/dso.c       |   2 +
 tools/perf/util/dso.h       |   1 +
 tools/perf/util/machine.c   |  56 +++++++++++++-
 tools/perf/util/srcline.c   | 183 ++++++++++++++++++++++++++++++++++----------
 tools/perf/util/srcline.h   |  19 ++++-
 tools/perf/util/symbol.h    |   1 +
 8 files changed, 230 insertions(+), 69 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index f320b0777e0d..9854adb06ac1 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -559,6 +559,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call->ip = cursor_node->ip;
 		call->ms.sym = cursor_node->sym;
 		call->ms.map = map__get(cursor_node->map);
+		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
 			call->branch_count = 1;
@@ -640,20 +641,11 @@ enum match_result {
 static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 					     struct callchain_list *cnode)
 {
-	char *left = NULL;
-	char *right = NULL;
+	const char *left = cnode->srcline;
+	const char *right = node->srcline;
 	enum match_result ret = MATCH_EQ;
 	int cmp;
 
-	if (cnode->ms.map)
-		left = get_srcline(cnode->ms.map->dso,
-				 map__rip_2objdump(cnode->ms.map, cnode->ip),
-				 cnode->ms.sym, true, false);
-	if (node->map)
-		right = get_srcline(node->map->dso,
-				  map__rip_2objdump(node->map, node->ip),
-				  node->sym, true, false);
-
 	if (left && right)
 		cmp = strcmp(left, right);
 	else if (!left && right)
@@ -668,8 +660,6 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 	if (cmp != 0)
 		ret = cmp < 0 ? MATCH_LT : MATCH_GT;
 
-	free_srcline(left);
-	free_srcline(right);
 	return ret;
 }
 
@@ -958,7 +948,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0, 0);
+					false, NULL, 0, 0, 0, list->srcline);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -998,7 +988,8 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples, u64 branch_from)
+			    int nr_loop_iter, int samples, u64 branch_from,
+			    const char *srcline)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -1017,6 +1008,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->samples = samples;
+	node->srcline = srcline;
 
 	if (flags)
 		memcpy(&node->branch_flags, flags,
@@ -1104,12 +1096,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
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
@@ -1524,7 +1511,7 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
 					     node->nr_loop_iter, node->samples,
-					     node->branch_from);
+					     node->branch_from, node->srcline);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 97738201464a..bf81b56f34c3 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -121,7 +121,7 @@ struct callchain_list {
 	u64			iter_count;
 	u64			samples_count;
 	struct branch_type_stat brtype_stat;
-	char		       *srcline;
+	const char		*srcline;
 	struct list_head	list;
 };
 
@@ -135,6 +135,7 @@ struct callchain_cursor_node {
 	u64				ip;
 	struct map			*map;
 	struct symbol			*sym;
+	const char			*srcline;
 	bool				branch;
 	struct branch_flags		branch_flags;
 	u64				branch_from;
@@ -201,7 +202,8 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples, u64 branch_from);
+			    int nr_loop_iter, int samples, u64 branch_from,
+			    const char *srcline);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index b9e087fb8247..72e6e390fd26 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -9,6 +9,7 @@
 #include "compress.h"
 #include "path.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "dso.h"
 #include "machine.h"
 #include "auxtrace.h"
@@ -1233,6 +1234,7 @@ void dso__delete(struct dso *dso)
 		       dso->long_name);
 	for (i = 0; i < MAP__NR_TYPES; ++i)
 		symbols__delete(&dso->symbols[i]);
+	inlines__tree_delete(&dso->inlined_nodes);
 
 	if (dso->short_name_allocated) {
 		zfree((char **)&dso->short_name);
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f886141678eb..7d1e2b3c1f10 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -141,6 +141,7 @@ struct dso {
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
 	struct rb_root	 symbols[MAP__NR_TYPES];
 	struct rb_root	 symbol_names[MAP__NR_TYPES];
+	struct rb_root	 inlined_nodes;
 	struct {
 		u64		addr;
 		struct symbol	*symbol;
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index d4df353051af..a7f8499c8756 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1673,6 +1673,15 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
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
@@ -1686,6 +1695,7 @@ static int add_callchain_ip(struct thread *thread,
 			    u64 branch_from)
 {
 	struct addr_location al;
+	const char *srcline = NULL;
 
 	al.filtered = 0;
 	al.sym = NULL;
@@ -1735,9 +1745,11 @@ static int add_callchain_ip(struct thread *thread,
 
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
+
+	srcline = callchain_srcline(al.map, al.sym, al.addr);
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
 				       branch, flags, nr_loop_iter, samples,
-				       branch_from);
+				       branch_from, srcline);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -2044,15 +2056,55 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	return 0;
 }
 
+static int append_inlines(struct callchain_cursor *cursor,
+			  struct map *map, struct symbol *sym, u64 ip)
+{
+	struct inline_node *inline_node;
+	struct inline_list *ilist;
+	u64 addr;
+
+	if (!symbol_conf.inline_name || !map || !sym)
+		return 1;
+
+	addr = map__rip_2objdump(map, ip);
+
+	inline_node = inlines__tree_find(&map->dso->inlined_nodes, addr);
+	if (!inline_node) {
+		inline_node = dso__parse_addr_inlines(map->dso, addr, sym);
+		if (!inline_node)
+			return 1;
+
+		inlines__tree_insert(&map->dso->inlined_nodes, inline_node);
+	}
+
+	list_for_each_entry(ilist, &inline_node->val, list) {
+		int ret = callchain_cursor_append(cursor, ip, map,
+						  ilist->symbol, false,
+						  NULL, 0, 0, 0,
+						  ilist->srcline);
+
+		if (ret != 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
+	const char *srcline = NULL;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
+
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+		return 0;
+
+	srcline = callchain_srcline(entry->map, entry->sym, entry->ip);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0, 0);
+				       false, NULL, 0, 0, 0, srcline);
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index ebc88a74e67b..a1fdf035d1dd 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -33,28 +33,17 @@ static const char *dso__name(struct dso *dso)
 	return dso_name;
 }
 
-static int inline_list__append(char *filename, char *funcname, int line_nr,
-			       struct inline_node *node, struct dso *dso)
+static int inline_list__append(struct symbol *symbol, char *srcline,
+			       struct inline_node *node)
 {
 	struct inline_list *ilist;
-	char *demangled;
 
 	ilist = zalloc(sizeof(*ilist));
 	if (ilist == NULL)
 		return -1;
 
-	ilist->filename = filename;
-	ilist->line_nr = line_nr;
-
-	if (dso != NULL) {
-		demangled = dso__demangle_sym(dso, 0, funcname);
-		if (demangled == NULL) {
-			ilist->funcname = funcname;
-		} else {
-			ilist->funcname = demangled;
-			free(funcname);
-		}
-	}
+	ilist->symbol = symbol;
+	ilist->srcline = srcline;
 
 	if (callchain_param.order == ORDER_CALLEE)
 		list_add_tail(&ilist->list, &node->val);
@@ -64,6 +53,30 @@ static int inline_list__append(char *filename, char *funcname, int line_nr,
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
@@ -203,19 +216,55 @@ static void addr2line_cleanup(struct a2l_data *a2l)
 
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
+	if (strcmp(funcname, base_sym->name) == 0) {
+		// reuse the real, existing symbol
+		inline_sym = base_sym;
+	} else {
+		// create a fake symbol for the inline frame
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
+	char *srcline = NULL;
+
+	if (a2l->filename)
+		srcline = srcline_from_fileline(a2l->filename, a2l->line);
 
-	return inline_list__append(filename, funcname, a2l->line, node, dso);
+	return inline_list__append(inline_sym, srcline, node);
 }
 
 static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line, struct dso *dso,
-		     bool unwind_inlines, struct inline_node *node)
+		     bool unwind_inlines, struct inline_node *node,
+		     struct symbol *sym)
 {
 	int ret = 0;
 	struct a2l_data *a2l = dso->a2l;
@@ -241,7 +290,7 @@ static int addr2line(const char *dso_name, u64 addr,
 	if (unwind_inlines) {
 		int cnt = 0;
 
-		if (node && inline_list__append_dso_a2l(dso, node))
+		if (node && inline_list__append_dso_a2l(dso, node, sym))
 			return 0;
 
 		while (bfd_find_inliner_info(a2l->abfd, &a2l->filename,
@@ -249,7 +298,7 @@ static int addr2line(const char *dso_name, u64 addr,
 		       cnt++ < MAX_INLINE_NEST) {
 
 			if (node != NULL) {
-				if (inline_list__append_dso_a2l(dso, node))
+				if (inline_list__append_dso_a2l(dso, node, sym))
 					return 0;
 				// found at least one inline frame
 				ret = 1;
@@ -281,7 +330,7 @@ void dso__free_a2l(struct dso *dso)
 }
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-	struct dso *dso)
+	struct dso *dso, struct symbol *sym)
 {
 	struct inline_node *node;
 
@@ -294,7 +343,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	INIT_LIST_HEAD(&node->val);
 	node->addr = addr;
 
-	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node))
+	if (!addr2line(dso_name, addr, NULL, NULL, dso, TRUE, node, sym))
 		goto out_free_inline_node;
 
 	if (list_empty(&node->val))
@@ -334,7 +383,8 @@ static int addr2line(const char *dso_name, u64 addr,
 		     char **file, unsigned int *line_nr,
 		     struct dso *dso __maybe_unused,
 		     bool unwind_inlines __maybe_unused,
-		     struct inline_node *node __maybe_unused)
+		     struct inline_node *node __maybe_unused,
+		     struct symbol *sym __maybe_unused)
 {
 	FILE *fp;
 	char cmd[PATH_MAX];
@@ -374,7 +424,7 @@ void dso__free_a2l(struct dso *dso __maybe_unused)
 }
 
 static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
-	struct dso *dso __maybe_unused)
+	struct dso *dso __maybe_unused, struct symbol *sym)
 {
 	FILE *fp;
 	char cmd[PATH_MAX];
@@ -402,13 +452,15 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 	node->addr = addr;
 
 	while (getline(&filename, &len, fp) != -1) {
+		char *srcline;
+
 		if (filename_split(filename, &line_nr) != 1) {
 			free(filename);
 			goto out;
 		}
 
-		if (inline_list__append(filename, NULL, line_nr, node,
-					NULL) != 0)
+		srcline = srcline_from_fileline(filename, line_nr);
+		if (inline_list__append(sym, srcline, node) != 0)
 			goto out;
 
 		filename = NULL;
@@ -448,19 +500,18 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	if (dso_name == NULL)
 		goto out;
 
-	if (!addr2line(dso_name, addr, &file, &line, dso, unwind_inlines, NULL))
+	if (!addr2line(dso_name, addr, &file, &line, dso,
+		       unwind_inlines, NULL, sym))
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
@@ -494,7 +545,8 @@ char *get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 	return __get_srcline(dso, addr, sym, show_sym, show_addr, false);
 }
 
-struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
+struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
+					    struct symbol *sym)
 {
 	const char *dso_name;
 
@@ -502,7 +554,7 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr)
 	if (dso_name == NULL)
 		return NULL;
 
-	return addr2inlines(dso_name, addr, dso);
+	return addr2inlines(dso_name, addr, dso, sym);
 }
 
 void inline_node__delete(struct inline_node *node)
@@ -511,10 +563,63 @@ void inline_node__delete(struct inline_node *node)
 
 	list_for_each_entry_safe(ilist, tmp, &node->val, list) {
 		list_del_init(&ilist->list);
-		zfree(&ilist->filename);
-		zfree(&ilist->funcname);
+		zfree(&ilist->srcline);
+		// only the inlined symbols are owned by the list
+		if (ilist->symbol && ilist->symbol->inlined)
+			symbol__delete(ilist->symbol);
 		free(ilist);
 	}
 
 	free(node);
 }
+
+void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines)
+{
+	struct rb_node **p = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	const u64 addr = inlines->addr;
+	struct inline_node *i;
+
+	while (*p != NULL) {
+		parent = *p;
+		i = rb_entry(parent, struct inline_node, rb_node);
+		if (addr < i->addr)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+	rb_link_node(&inlines->rb_node, parent, p);
+	rb_insert_color(&inlines->rb_node, tree);
+}
+
+struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
+{
+	struct rb_node *n = tree->rb_node;
+
+	while (n) {
+		struct inline_node *i = rb_entry(n, struct inline_node,
+						 rb_node);
+
+		if (addr < i->addr)
+			n = n->rb_left;
+		else if (addr > i->addr)
+			n = n->rb_right;
+		else
+			return i;
+	}
+
+	return NULL;
+}
+
+void inlines__tree_delete(struct rb_root *tree)
+{
+	struct inline_node *pos;
+	struct rb_node *next = rb_first(tree);
+
+	while (next) {
+		pos = rb_entry(next, struct inline_node, rb_node);
+		next = rb_next(&pos->rb_node);
+		rb_erase(&pos->rb_node, tree);
+		inline_node__delete(pos);
+	}
+}
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index 7b52ba88676e..0d2aca92e8c7 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -2,6 +2,7 @@
 #define PERF_SRCLINE_H
 
 #include <linux/list.h>
+#include <linux/rbtree.h>
 #include <linux/types.h>
 
 struct dso;
@@ -17,18 +18,28 @@ void free_srcline(char *srcline);
 #define SRCLINE_UNKNOWN  ((char *) "??:0")
 
 struct inline_list {
-	char			*filename;
-	char			*funcname;
-	unsigned int		line_nr;
+	struct symbol		*symbol;
+	char			*srcline;
 	struct list_head	list;
 };
 
 struct inline_node {
 	u64			addr;
 	struct list_head	val;
+	struct rb_node		rb_node;
 };
 
-struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr);
+// parse inlined frames for the given address
+struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
+					    struct symbol *sym);
+// free resources associated to the inline node list
 void inline_node__delete(struct inline_node *node);
 
+// insert the inline node list into the DSO, which will take ownership
+void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines);
+// find previously inserted inline node list
+struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
+// delete all nodes within the tree of inline_node s
+void inlines__tree_delete(struct rb_root *tree);
+
 #endif /* PERF_SRCLINE_H */
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index f0b08810d7fa..b358570ce615 100644
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
2.13.3
