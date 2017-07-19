From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 86/86] perf report: Show branch type in callchain entry
Date: Wed, 19 Jul 2017 11:29:50 -0300
Message-ID: <20170719142950.3747-87-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Show branch type in callchain entry. The branch type is printed
with other LBR information (such as cycles/abort/...).

For example:

  perf record -g -j any,save_type
  perf report --branch-history --stdio --no-children

  38.50%  div.c:45                [.] main                    div
          |
          ---main div.c:42 (RET CROSS_2M cycles:2)
             compute_flag div.c:28 (cycles:2)
             compute_flag div.c:27 (RET CROSS_2M cycles:1)
             rand rand.c:28 (cycles:1)
             rand rand.c:28 (RET CROSS_2M cycles:1)
             __random random.c:298 (cycles:1)
             __random random.c:297 (COND_BWD CROSS_2M cycles:1)
             __random random.c:295 (cycles:1)
             __random random.c:295 (COND_BWD CROSS_2M cycles:1)
             __random random.c:295 (cycles:1)
             __random random.c:295 (RET CROSS_2M cycles:9)

Change log

v6: Remove the branch_type_str() since it's moved to branch.c.

v5: Rewrite the branch info print code in util/callchain.c.

v4: Comparing to previous version, the major changes are:

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500379995-6449-8-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/callchain.c | 38 +++++++++++++++++++++++++++++---------
 tools/perf/util/callchain.h |  5 ++++-
 tools/perf/util/machine.c   | 26 +++++++++++++++++---------
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 917f4d6510ae..22d413ae6025 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -23,6 +23,7 @@
 #include "sort.h"
 #include "machine.h"
 #include "callchain.h"
+#include "branch.h"
 
 #define CALLCHAIN_PARAM_DEFAULT			\
 	.mode		= CHAIN_GRAPH_ABS,	\
@@ -571,6 +572,11 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 			call->cycles_count = cursor_node->branch_flags.cycles;
 			call->iter_count = cursor_node->nr_loop_iter;
 			call->samples_count = cursor_node->samples;
+
+			branch_type_count(&call->brtype_stat,
+					  &cursor_node->branch_flags,
+					  cursor_node->branch_from,
+					  cursor_node->ip);
 		}
 
 		list_add_tail(&call->list, &node->val);
@@ -688,6 +694,11 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 			cnode->cycles_count += node->branch_flags.cycles;
 			cnode->iter_count += node->nr_loop_iter;
 			cnode->samples_count += node->samples;
+
+			branch_type_count(&cnode->brtype_stat,
+					  &node->branch_flags,
+					  node->branch_from,
+					  node->ip);
 		}
 
 		return MATCH_EQ;
@@ -922,7 +933,7 @@ merge_chain_branch(struct callchain_cursor *cursor,
 	list_for_each_entry_safe(list, next_list, &src->val, list) {
 		callchain_cursor_append(cursor, list->ip,
 					list->ms.map, list->ms.sym,
-					false, NULL, 0, 0);
+					false, NULL, 0, 0, 0);
 		list_del(&list->list);
 		map__zput(list->ms.map);
 		free(list);
@@ -962,7 +973,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples)
+			    int nr_loop_iter, int samples, u64 branch_from)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -986,6 +997,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 		memcpy(&node->branch_flags, flags,
 			sizeof(struct branch_flags));
 
+	node->branch_from = branch_from;
 	cursor->nr++;
 
 	cursor->last = &node->next;
@@ -1235,14 +1247,19 @@ static int count_float_printf(int idx, const char *str, float value, char *bf, i
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
-			     u64 iter_count, u64 samples_count)
+			     u64 iter_count, u64 samples_count,
+			     struct branch_type_stat *brtype_stat)
 {
 	u64 cycles;
-	int printed = 0, i = 0;
+	int printed, i = 0;
 
 	if (branch_count == 0)
 		return scnprintf(bf, bfsize, " (calltrace)");
 
+	printed = branch_type_str(brtype_stat, bf, bfsize);
+	if (printed)
+		i++;
+
 	if (predicted_count < branch_count) {
 		printed += count_float_printf(i++, "predicted",
 				predicted_count * 100.0 / branch_count,
@@ -1278,13 +1295,14 @@ static int counts_str_build(char *bf, int bfsize,
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
-				   u64 iter_count, u64 samples_count)
+				   u64 iter_count, u64 samples_count,
+				   struct branch_type_stat *brtype_stat)
 {
-	char str[128];
+	char str[256];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, samples_count);
+			 iter_count, samples_count, brtype_stat);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1316,7 +1334,8 @@ int callchain_list_counts__printf_value(struct callchain_node *node,
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
-				       cycles_count, iter_count, samples_count);
+				       cycles_count, iter_count, samples_count,
+				       &clist->brtype_stat);
 }
 
 static void free_callchain_node(struct callchain_node *node)
@@ -1441,7 +1460,8 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
-					     node->nr_loop_iter, node->samples);
+					     node->nr_loop_iter, node->samples,
+					     node->branch_from);
 		if (rc)
 			break;
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index c56c23dbbf72..97738201464a 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -7,6 +7,7 @@
 #include "event.h"
 #include "map.h"
 #include "symbol.h"
+#include "branch.h"
 
 #define HELP_PAD "\t\t\t\t"
 
@@ -119,6 +120,7 @@ struct callchain_list {
 	u64			cycles_count;
 	u64			iter_count;
 	u64			samples_count;
+	struct branch_type_stat brtype_stat;
 	char		       *srcline;
 	struct list_head	list;
 };
@@ -135,6 +137,7 @@ struct callchain_cursor_node {
 	struct symbol			*sym;
 	bool				branch;
 	struct branch_flags		branch_flags;
+	u64				branch_from;
 	int				nr_loop_iter;
 	int				samples;
 	struct callchain_cursor_node	*next;
@@ -198,7 +201,7 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples);
+			    int nr_loop_iter, int samples, u64 branch_from);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index a54a2be5eda4..79d08ea694da 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1682,7 +1682,8 @@ static int add_callchain_ip(struct thread *thread,
 			    bool branch,
 			    struct branch_flags *flags,
 			    int nr_loop_iter,
-			    int samples)
+			    int samples,
+			    u64 branch_from)
 {
 	struct addr_location al;
 
@@ -1735,7 +1736,8 @@ static int add_callchain_ip(struct thread *thread,
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
-				       branch, flags, nr_loop_iter, samples);
+				       branch, flags, nr_loop_iter, samples,
+				       branch_from);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -1814,7 +1816,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = min(max_stack, (int)chain->nr), i;
 	u8 cpumode = PERF_RECORD_MISC_USER;
-	u64 ip;
+	u64 ip, branch_from = 0;
 
 	for (i = 0; i < chain_nr; i++) {
 		if (chain->ips[i] == PERF_CONTEXT_USER)
@@ -1856,6 +1858,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = lbr_stack->entries[0].to;
 					branch = true;
 					flags = &lbr_stack->entries[0].flags;
+					branch_from =
+						lbr_stack->entries[0].from;
 				}
 			} else {
 				if (j < lbr_nr) {
@@ -1870,12 +1874,15 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 					ip = lbr_stack->entries[0].to;
 					branch = true;
 					flags = &lbr_stack->entries[0].flags;
+					branch_from =
+						lbr_stack->entries[0].from;
 				}
 			}
 
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
-					       branch, flags, 0, 0);
+					       branch, flags, 0, 0,
+					       branch_from);
 			if (err)
 				return (err < 0) ? err : 0;
 		}
@@ -1974,19 +1981,20 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 						       root_al,
 						       NULL, be[i].to,
 						       true, &be[i].flags,
-						       nr_loop_iter, 1);
+						       nr_loop_iter, 1,
+						       be[i].from);
 			else
 				err = add_callchain_ip(thread, cursor, parent,
 						       root_al,
 						       NULL, be[i].to,
 						       true, &be[i].flags,
-						       0, 0);
+						       0, 0, be[i].from);
 
 			if (!err)
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       0, 0);
+						       0, 0, 0);
 			if (err == -EINVAL)
 				break;
 			if (err)
@@ -2016,7 +2024,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 
 		if (err)
 			return (err < 0) ? err : 0;
@@ -2033,7 +2041,7 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
 		return 0;
 	return callchain_cursor_append(cursor, entry->ip,
 				       entry->map, entry->sym,
-				       false, NULL, 0, 0);
+				       false, NULL, 0, 0, 0);
 }
 
 static int thread__resolve_callchain_unwind(struct thread *thread,
-- 
2.9.4
