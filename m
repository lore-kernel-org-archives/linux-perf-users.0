From: Milian Wolff <milian.wolff@kdab.com>
Subject: [PATCH v5 05/16] perf report: create real callchain entries for inlined frames
Date: Mon,  9 Oct 2017 22:32:59 +0200
Message-ID: <20171009203310.17362-6-milian.wolff@kdab.com>
References: <20171009203310.17362-1-milian.wolff@kdab.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:48574 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754982AbdJIUd3 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Oct 2017 16:33:29 -0400
In-Reply-To: <20171009203310.17362-1-milian.wolff@kdab.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: acme@kernel.org, jolsa@kernel.org, Jin Yao <yao.jin@linux.intel.com>
Cc: Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>

The inline_node structs are maintained by the new dso->inlines
tree. This in turn keeps ownership of the fake symbols and
srcline string representing an inline frame.

This tree is sorted by address to allow quick lookups. All other
entries of the symbol beside the function name are unused for inline
frames. The advantage of this approach is that all existing users
of the callchain API can now transparently display inlined frames
without having to patch their code.

Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Yao Jin <yao.jin@linux.intel.com>
Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
---
 tools/perf/util/dso.c     |  5 +++++
 tools/perf/util/dso.h     |  1 +
 tools/perf/util/machine.c | 37 ++++++++++++++++++++++++++++++++++
 tools/perf/util/srcline.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/srcline.h |  9 +++++++++
 5 files changed, 103 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 339e52971380..75c8250b3b8a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -10,6 +10,7 @@
 #include "compress.h"
 #include "path.h"
 #include "symbol.h"
+#include "srcline.h"
 #include "dso.h"
 #include "machine.h"
 #include "auxtrace.h"
@@ -1201,6 +1202,7 @@ struct dso *dso__new(const char *name)
 		for (i = 0; i < MAP__NR_TYPES; ++i)
 			dso->symbols[i] = dso->symbol_names[i] = RB_ROOT;
 		dso->data.cache = RB_ROOT;
+		dso->inlined_nodes = RB_ROOT;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
@@ -1232,6 +1234,9 @@ void dso__delete(struct dso *dso)
 	if (!RB_EMPTY_NODE(&dso->rb_node))
 		pr_err("DSO %s is still in rbtree when being deleted!\n",
 		       dso->long_name);
+
+	/* free inlines first, as they reference symbols */
+	inlines__tree_delete(&dso->inlined_nodes);
 	for (i = 0; i < MAP__NR_TYPES; ++i)
 		symbols__delete(&dso->symbols[i]);
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index a2bbb21f301c..122eca0d242d 100644
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
index a37e1c056415..3d049cb313ac 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2109,6 +2109,40 @@ static int thread__resolve_callchain_sample(struct thread *thread,
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
@@ -2117,6 +2151,9 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
 
+	if (append_inlines(cursor, entry->map, entry->sym, entry->ip) == 0)
+		return 0;
+
 	srcline = callchain_srcline(entry->map, entry->sym, entry->ip);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index f202fc7827df..8bea6621d657 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -583,3 +583,54 @@ void inline_node__delete(struct inline_node *node)
 
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
index 0201ed2c0b9c..ebe38cd22294 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -2,6 +2,7 @@
 #define PERF_SRCLINE_H
 
 #include <linux/list.h>
+#include <linux/rbtree.h>
 #include <linux/types.h>
 
 struct dso;
@@ -25,6 +26,7 @@ struct inline_list {
 struct inline_node {
 	u64			addr;
 	struct list_head	val;
+	struct rb_node		rb_node;
 };
 
 /* parse inlined frames for the given address */
@@ -33,4 +35,11 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 /* free resources associated to the inline node list */
 void inline_node__delete(struct inline_node *node);
 
+/* insert the inline node list into the DSO, which will take ownership */
+void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines);
+/* find previously inserted inline node list */
+struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
+/* delete all nodes within the tree of inline_node s */
+void inlines__tree_delete(struct rb_root *tree);
+
 #endif /* PERF_SRCLINE_H */
-- 
2.14.2
