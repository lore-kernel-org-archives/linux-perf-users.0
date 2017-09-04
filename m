From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/13] perf report: Calculate the average cycles of iterations
Date: Mon,  4 Sep 2017 11:00:32 -0300
Message-ID: <20170904140044.22912-2-acme@kernel.org>
References: <20170904140044.22912-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753566AbdIDOBB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 4 Sep 2017 10:01:01 -0400
In-Reply-To: <20170904140044.22912-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>

From: Jin Yao <yao.jin@linux.intel.com>

The branch history code has a loop detection function. With this, we can
get the number of iterations by calculating the removed loops.

While it would be nice for knowing the average cycles of iterations.
This patch adds up the cycles in branch entries of removed loops and
save the result to the next branch entry (e.g. branch entry A).

Finally it will display the iteration number and average cycles at the
"from" of branch entry A.

For example:
perf record -g -j any,save_type ./div
perf report --branch-history --no-children --stdio

--22.63%--main div.c:42 (RET CROSS_2M)
          compute_flag div.c:28 (cycles:2 iter:173115 avg_cycles:2)
          |
           --10.73%--compute_flag div.c:27 (RET CROSS_2M)
                     rand rand.c:28 (cycles:1)
                     rand rand.c:28 (RET CROSS_2M)
                     __random random.c:298 (cycles:1)
                     __random random.c:297 (COND_BWD CROSS_2M)
                     __random random.c:295 (cycles:1)
                     __random random.c:295 (COND_BWD CROSS_2M)
                     __random random.c:295 (cycles:1)
                     __random random.c:295 (RET CROSS_2M)

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1502111115-18305-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c |  8 +---
 tools/perf/ui/stdio/hist.c     | 10 ++---
 tools/perf/util/callchain.c    | 49 +++++++++++------------
 tools/perf/util/callchain.h    |  9 ++---
 tools/perf/util/machine.c      | 88 +++++++++++++++++++++++++-----------------
 5 files changed, 85 insertions(+), 79 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index f4bc2462bc2c..13dfb0a0bdeb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -931,12 +931,8 @@ static int hist_browser__show_callchain_list(struct hist_browser *browser,
 				       browser->show_dso);
 
 	if (symbol_conf.show_branchflag_count) {
-		if (need_percent)
-			callchain_list_counts__printf_value(node, chain, NULL,
-							    buf, sizeof(buf));
-		else
-			callchain_list_counts__printf_value(NULL, chain, NULL,
-							    buf, sizeof(buf));
+		callchain_list_counts__printf_value(chain, NULL,
+						    buf, sizeof(buf));
 
 		if (asprintf(&alloc_str2, "%s%s", str, buf) < 0)
 			str = "Not enough memory!";
diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 5c95b8301c67..8bdb7a500181 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -124,12 +124,8 @@ static size_t ipchain__fprintf_graph(FILE *fp, struct callchain_node *node,
 	str = callchain_list__sym_name(chain, bf, sizeof(bf), false);
 
 	if (symbol_conf.show_branchflag_count) {
-		if (!period)
-			callchain_list_counts__printf_value(node, chain, NULL,
-							    buf, sizeof(buf));
-		else
-			callchain_list_counts__printf_value(NULL, chain, NULL,
-							    buf, sizeof(buf));
+		callchain_list_counts__printf_value(chain, NULL,
+						    buf, sizeof(buf));
 
 		if (asprintf(&alloc_str, "%s%s", str, buf) < 0)
 			str = "Not enough memory!";
@@ -313,7 +309,7 @@ static size_t callchain__fprintf_graph(FILE *fp, struct rb_root *root,
 
 			if (symbol_conf.show_branchflag_count)
 				ret += callchain_list_counts__printf_value(
-						NULL, chain, fp, NULL, 0);
+						chain, fp, NULL, 0);
 			ret += fprintf(fp, "\n");
 
 			if (++entries_printed == callchain_param.print_limit)
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index f320b0777e0d..510b513e0f01 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -588,7 +588,7 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 				call->cycles_count =
 					cursor_node->branch_flags.cycles;
 				call->iter_count = cursor_node->nr_loop_iter;
-				call->samples_count = cursor_node->samples;
+				call->iter_cycles = cursor_node->iter_cycles;
 			}
 		}
 
@@ -722,7 +722,7 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 				cnode->cycles_count +=
 					node->branch_flags.cycles;
 				cnode->iter_count += node->nr_loop_iter;
-				cnode->samples_count += node->samples;
+				cnode->iter_cycles += node->iter_cycles;
 			}
 		}
 
@@ -998,7 +998,7 @@ int callchain_merge(struct callchain_cursor *cursor,
 int callchain_cursor_append(struct callchain_cursor *cursor,
 			    u64 ip, struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples, u64 branch_from)
+			    int nr_loop_iter, u64 iter_cycles, u64 branch_from)
 {
 	struct callchain_cursor_node *node = *cursor->last;
 
@@ -1016,7 +1016,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
 	node->sym = sym;
 	node->branch = branch;
 	node->nr_loop_iter = nr_loop_iter;
-	node->samples = samples;
+	node->iter_cycles = iter_cycles;
 
 	if (flags)
 		memcpy(&node->branch_flags, flags,
@@ -1306,7 +1306,7 @@ static int branch_to_str(char *bf, int bfsize,
 static int branch_from_str(char *bf, int bfsize,
 			   u64 branch_count,
 			   u64 cycles_count, u64 iter_count,
-			   u64 samples_count)
+			   u64 iter_cycles)
 {
 	int printed = 0, i = 0;
 	u64 cycles;
@@ -1318,9 +1318,13 @@ static int branch_from_str(char *bf, int bfsize,
 				bf + printed, bfsize - printed);
 	}
 
-	if (iter_count && samples_count) {
-		printed += count_pri64_printf(i++, "iterations",
-				iter_count / samples_count,
+	if (iter_count) {
+		printed += count_pri64_printf(i++, "iter",
+				iter_count,
+				bf + printed, bfsize - printed);
+
+		printed += count_pri64_printf(i++, "avg_cycles",
+				iter_cycles / iter_count,
 				bf + printed, bfsize - printed);
 	}
 
@@ -1333,7 +1337,7 @@ static int branch_from_str(char *bf, int bfsize,
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
-			     u64 iter_count, u64 samples_count,
+			     u64 iter_count, u64 iter_cycles,
 			     struct branch_type_stat *brtype_stat)
 {
 	int printed;
@@ -1346,7 +1350,7 @@ static int counts_str_build(char *bf, int bfsize,
 				predicted_count, abort_count, brtype_stat);
 	} else {
 		printed = branch_from_str(bf, bfsize, branch_count,
-				cycles_count, iter_count, samples_count);
+				cycles_count, iter_count, iter_cycles);
 	}
 
 	if (!printed)
@@ -1358,14 +1362,14 @@ static int counts_str_build(char *bf, int bfsize,
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 				   u64 branch_count, u64 predicted_count,
 				   u64 abort_count, u64 cycles_count,
-				   u64 iter_count, u64 samples_count,
+				   u64 iter_count, u64 iter_cycles,
 				   struct branch_type_stat *brtype_stat)
 {
 	char str[256];
 
 	counts_str_build(str, sizeof(str), branch_count,
 			 predicted_count, abort_count, cycles_count,
-			 iter_count, samples_count, brtype_stat);
+			 iter_count, iter_cycles, brtype_stat);
 
 	if (fp)
 		return fprintf(fp, "%s", str);
@@ -1373,31 +1377,23 @@ static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
 	return scnprintf(bf, bfsize, "%s", str);
 }
 
-int callchain_list_counts__printf_value(struct callchain_node *node,
-					struct callchain_list *clist,
+int callchain_list_counts__printf_value(struct callchain_list *clist,
 					FILE *fp, char *bf, int bfsize)
 {
 	u64 branch_count, predicted_count;
 	u64 abort_count, cycles_count;
-	u64 iter_count = 0, samples_count = 0;
+	u64 iter_count, iter_cycles;
 
 	branch_count = clist->branch_count;
 	predicted_count = clist->predicted_count;
 	abort_count = clist->abort_count;
 	cycles_count = clist->cycles_count;
-
-	if (node) {
-		struct callchain_list *call;
-
-		list_for_each_entry(call, &node->val, list) {
-			iter_count += call->iter_count;
-			samples_count += call->samples_count;
-		}
-	}
+	iter_count = clist->iter_count;
+	iter_cycles = clist->iter_cycles;
 
 	return callchain_counts_printf(fp, bf, bfsize, branch_count,
 				       predicted_count, abort_count,
-				       cycles_count, iter_count, samples_count,
+				       cycles_count, iter_count, iter_cycles,
 				       &clist->brtype_stat);
 }
 
@@ -1523,7 +1519,8 @@ int callchain_cursor__copy(struct callchain_cursor *dst,
 
 		rc = callchain_cursor_append(dst, node->ip, node->map, node->sym,
 					     node->branch, &node->branch_flags,
-					     node->nr_loop_iter, node->samples,
+					     node->nr_loop_iter,
+					     node->iter_cycles,
 					     node->branch_from);
 		if (rc)
 			break;
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 97738201464a..1ed6fc61d0a5 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -119,7 +119,7 @@ struct callchain_list {
 	u64			abort_count;
 	u64			cycles_count;
 	u64			iter_count;
-	u64			samples_count;
+	u64			iter_cycles;
 	struct branch_type_stat brtype_stat;
 	char		       *srcline;
 	struct list_head	list;
@@ -139,7 +139,7 @@ struct callchain_cursor_node {
 	struct branch_flags		branch_flags;
 	u64				branch_from;
 	int				nr_loop_iter;
-	int				samples;
+	u64				iter_cycles;
 	struct callchain_cursor_node	*next;
 };
 
@@ -201,7 +201,7 @@ static inline void callchain_cursor_reset(struct callchain_cursor *cursor)
 int callchain_cursor_append(struct callchain_cursor *cursor, u64 ip,
 			    struct map *map, struct symbol *sym,
 			    bool branch, struct branch_flags *flags,
-			    int nr_loop_iter, int samples, u64 branch_from);
+			    int nr_loop_iter, u64 iter_cycles, u64 branch_from);
 
 /* Close a cursor writing session. Initialize for the reader */
 static inline void callchain_cursor_commit(struct callchain_cursor *cursor)
@@ -282,8 +282,7 @@ char *callchain_node__scnprintf_value(struct callchain_node *node,
 int callchain_node__fprintf_value(struct callchain_node *node,
 				  FILE *fp, u64 total);
 
-int callchain_list_counts__printf_value(struct callchain_node *node,
-					struct callchain_list *clist,
+int callchain_list_counts__printf_value(struct callchain_list *clist,
 					FILE *fp, char *bf, int bfsize);
 
 void free_callchain(struct callchain_root *root);
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5c8eacaca4f4..9eaa95302c86 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1675,6 +1675,11 @@ struct mem_info *sample__resolve_mem(struct perf_sample *sample,
 	return mi;
 }
 
+struct iterations {
+	int nr_loop_iter;
+	u64 cycles;
+};
+
 static int add_callchain_ip(struct thread *thread,
 			    struct callchain_cursor *cursor,
 			    struct symbol **parent,
@@ -1683,11 +1688,12 @@ static int add_callchain_ip(struct thread *thread,
 			    u64 ip,
 			    bool branch,
 			    struct branch_flags *flags,
-			    int nr_loop_iter,
-			    int samples,
+			    struct iterations *iter,
 			    u64 branch_from)
 {
 	struct addr_location al;
+	int nr_loop_iter = 0;
+	u64 iter_cycles = 0;
 
 	al.filtered = 0;
 	al.sym = NULL;
@@ -1737,9 +1743,15 @@ static int add_callchain_ip(struct thread *thread,
 
 	if (symbol_conf.hide_unresolved && al.sym == NULL)
 		return 0;
+
+	if (iter) {
+		nr_loop_iter = iter->nr_loop_iter;
+		iter_cycles = iter->cycles;
+	}
+
 	return callchain_cursor_append(cursor, al.addr, al.map, al.sym,
-				       branch, flags, nr_loop_iter, samples,
-				       branch_from);
+				       branch, flags, nr_loop_iter,
+				       iter_cycles, branch_from);
 }
 
 struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
@@ -1760,6 +1772,18 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 	return bi;
 }
 
+static void save_iterations(struct iterations *iter,
+			    struct branch_entry *be, int nr)
+{
+	int i;
+
+	iter->nr_loop_iter = nr;
+	iter->cycles = 0;
+
+	for (i = 0; i < nr; i++)
+		iter->cycles += be[i].flags.cycles;
+}
+
 #define CHASHSZ 127
 #define CHASHBITS 7
 #define NO_ENTRY 0xff
@@ -1767,7 +1791,8 @@ struct branch_info *sample__resolve_bstack(struct perf_sample *sample,
 #define PERF_MAX_BRANCH_DEPTH 127
 
 /* Remove loops. */
-static int remove_loops(struct branch_entry *l, int nr)
+static int remove_loops(struct branch_entry *l, int nr,
+			struct iterations *iter)
 {
 	int i, j, off;
 	unsigned char chash[CHASHSZ];
@@ -1792,8 +1817,18 @@ static int remove_loops(struct branch_entry *l, int nr)
 					break;
 				}
 			if (is_loop) {
-				memmove(l + i, l + i + off,
-					(nr - (i + off)) * sizeof(*l));
+				j = nr - (i + off);
+				if (j > 0) {
+					save_iterations(iter + i + off,
+						l + i, off);
+
+					memmove(iter + i, iter + i + off,
+						j * sizeof(*iter));
+
+					memmove(l + i, l + i + off,
+						j * sizeof(*l));
+				}
+
 				nr -= off;
 			}
 		}
@@ -1883,7 +1918,7 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 
 			err = add_callchain_ip(thread, cursor, parent,
 					       root_al, &cpumode, ip,
-					       branch, flags, 0, 0,
+					       branch, flags, NULL,
 					       branch_from);
 			if (err)
 				return (err < 0) ? err : 0;
@@ -1909,7 +1944,6 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	int i, j, err, nr_entries;
 	int skip_idx = -1;
 	int first_call = 0;
-	int nr_loop_iter;
 
 	if (chain)
 		chain_nr = chain->nr;
@@ -1942,6 +1976,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (branch && callchain_param.branch_callstack) {
 		int nr = min(max_stack, (int)branch->nr);
 		struct branch_entry be[nr];
+		struct iterations iter[nr];
 
 		if (branch->nr > PERF_MAX_BRANCH_DEPTH) {
 			pr_warning("corrupted branch chain. skipping...\n");
@@ -1972,38 +2007,21 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 				be[i] = branch->entries[branch->nr - i - 1];
 		}
 
-		nr_loop_iter = nr;
-		nr = remove_loops(be, nr);
-
-		/*
-		 * Get the number of iterations.
-		 * It's only approximation, but good enough in practice.
-		 */
-		if (nr_loop_iter > nr)
-			nr_loop_iter = nr_loop_iter - nr + 1;
-		else
-			nr_loop_iter = 0;
+		memset(iter, 0, sizeof(struct iterations) * nr);
+		nr = remove_loops(be, nr, iter);
 
 		for (i = 0; i < nr; i++) {
-			if (i == nr - 1)
-				err = add_callchain_ip(thread, cursor, parent,
-						       root_al,
-						       NULL, be[i].to,
-						       true, &be[i].flags,
-						       nr_loop_iter, 1,
-						       be[i].from);
-			else
-				err = add_callchain_ip(thread, cursor, parent,
-						       root_al,
-						       NULL, be[i].to,
-						       true, &be[i].flags,
-						       0, 0, be[i].from);
+			err = add_callchain_ip(thread, cursor, parent,
+					       root_al,
+					       NULL, be[i].to,
+					       true, &be[i].flags,
+					       NULL, be[i].from);
 
 			if (!err)
 				err = add_callchain_ip(thread, cursor, parent, root_al,
 						       NULL, be[i].from,
 						       true, &be[i].flags,
-						       0, 0, 0);
+						       &iter[i], 0);
 			if (err == -EINVAL)
 				break;
 			if (err)
@@ -2037,7 +2055,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
-				       false, NULL, 0, 0, 0);
+				       false, NULL, NULL, 0);
 
 		if (err)
 			return (err < 0) ? err : 0;
-- 
2.13.5
