From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/15] perf callchain: Store srcline in callchain_cursor_node
Date: Wed, 25 Oct 2017 13:00:00 -0300
Message-ID: <20171025160013.11136-3-acme@kernel.org>
References: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932209AbdJYQAg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:36 -0400
In-Reply-To: <20171025160013.11136-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Milian Wolff <milian.wolff@kdab.com>, David Ahern <dsahern@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Milian Wolff <milian.wolff@kdab.com>

This is mostly a preparation to enable the creation of full callchain
nodes for inline frames. Such frames will reference the IP of the
non-inlined frame, but hold the symbol and srcline for an inlined
location. As such, we won't be able to query the srcline on-demand based
on the IP alone. Instead, we will leverage the functionality provided by
this patch here, and store the srcline for the inlined nodes in the new
srcline member of callchain_cursor_node.

Note that this patch on its own leaks the srcline, as there is no
free_callchain_cursor_node or similar. A future patch will add caching
of the srcline and handle deletion properly.

Signed-off-by: Milian Wolff <milian.wolff@kdab.com>
Reviewed-by: Jiri Olsa <jolsa@redhat.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Yao Jin <yao.jin@linux.intel.com>
Link: http://lkml.kernel.org/r/20171009203310.17362-3-milian.wolff@kdab.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 31 +++++++++----------------------
 tools/perf/util/callchain.h |  6 ++++--
 tools/perf/util/machine.c   | 18 ++++++++++++++++--
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index a971caf3759d..e7ee794d1e5b 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -566,6 +566,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		call->ip = cursor_node->ip;
 		call->ms.sym = cursor_node->sym;
 		call->ms.map = map__get(cursor_node->map);
+		call->srcline = cursor_node->srcline;
 
 		if (cursor_node->branch) {
 			call->branch_count = 1;
@@ -647,20 +648,11 @@ enum match_result {
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
@@ -675,8 +667,6 @@ static enum match_result match_chain_srcline(struct callchain_cursor_node *node,
 	if (cmp != 0)
 		ret = cmp < 0 ? MATCH_LT : MATCH_GT;
 
-	free_srcline(left);
-	free_srcline(right);
 	return ret;
 }
 
@@ -969,7 +959,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0, 0);
+					false, NULL, 0, 0, 0, list->srcline);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -1009,7 +999,8 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, u64 iter_cycles, u64 branch_from)
+			    int nr_loop_iter, u64 iter_cycles, u64 branch_from,
+			    const char *srcline)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -1028,6 +1019,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
 	node->iter_cycles = iter_cycles;
+	node->srcline = srcline;
 
 	if (flags)
 		memcpy(&node->branch_flags, flags,
@@ -1115,12 +1107,7 @@ char *callchain_list__sym_name(struct callchain_list *cl,
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
@@ -1532,7 +1519,7 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 					     node->branch, &node->branch_flags,
 					     node->nr_loop_iter,
 					     node->iter_cycles,
-					     node->branch_from);
+					     node->branch_from, node->srcline);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 1ed6fc61d0a5..8f67b681cde9 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -121,7 +121,7 @@ struct callchain_list {
 	u64			iter_count;
 	u64			iter_cycles;
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
-			    int nr_loop_iter, u64 iter_cycles, u64 branch_from);
+			    int nr_loop_iter, u64 iter_cycles, u64 branch_from,
+			    const char *srcline);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7c3aa479201a..a37e1c056415 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1709,6 +1709,15 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
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
 struct iterations {
 	int nr_loop_iter;
 	u64 cycles;
@@ -1728,6 +1737,7 @@ static int add_callchain_ip(struct thread *thread,
 	struct addr_location al;
 	int nr_loop_iter = 0;
 	u64 iter_cycles = 0;
+	const char *srcline = NULL;
 
 	al.filtered = 0;
 	al.sym = NULL;
@@ -1783,9 +1793,10 @@ static int add_callchain_ip(struct thread *thread,
 		iter_cycles = iter->cycles;
 	}
 
+	srcline = callchain_srcline(al.map, al.sym, al.addr);
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
 				       branch, flags, nr_loop_iter,
-				       iter_cycles, branch_from);
+				       iter_cycles, branch_from, srcline);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -2101,12 +2112,15 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 static int unwind_entry(struct unwind_entry *entry, void *arg)
 {
 	struct callchain_cursor *cursor = arg;
+	const char *srcline = NULL;
 
 	if (symbol_conf.hide_unresolved && entry->sym == NULL)
 		return 0;
+
+	srcline = callchain_srcline(entry->map, entry->sym, entry->ip);
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0, 0);
+				       false, NULL, 0, 0, 0, srcline);
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
-- 
2.13.6
