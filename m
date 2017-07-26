From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/40] perf report: Tag branch type/flag on "to" and tag cycles on "from"
Date: Wed, 26 Jul 2017 11:17:27 -0300
Message-ID: <20170726141730.30750-38-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Current --branch-history LBR annotation displays confused data. For
example, each cycles report is duplicated on both "from" and "to"
entries.

For example:

  perf report --branch-history --no-children --stdio

  --2.32%--main div.c:39 (COND_BWD CROSS_2M predicted:49.7% cycles:1)
            main div.c:44 (predicted:49.7% cycles:1)
            main div.c:42 (RET CROSS_2M cycles:2)
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

The cycles should be tagged only on the "from". It's for the code block
that ends with "from", not for "to".

Another issue is the "predicted:49.7%" is duplicated too (tag on both
"from" and "to").

This patch tags the branch type/flag on "to" and tag the cycles on
"from".

For example:

  --2.32%--main div.c:39 (COND_BWD CROSS_2M predicted:49.7%)
            main div.c:44 (cycles:1)
            main div.c:42 (RET CROSS_2M)
            compute_flag div.c:28 (cycles:2)
            compute_flag div.c:27 (RET CROSS_2M)
            rand rand.c:28 (cycles:1)
            rand rand.c:28 (RET CROSS_2M)
            __random random.c:298 (cycles:1)
            __random random.c:297 (COND_BWD CROSS_2M)
            __random random.c:295 (cycles:1)
            __random random.c:295 (COND_BWD CROSS_2M)
            __random random.c:295 (cycles:1)
            __random random.c:295 (RET CROSS_2M)
            |
             --2.23%--__random_r random_r.c:392 (cycles:9)

In this example, The "main div.c:39 (COND_BWD CROSS_2M predicted:49.7%)"
is "to" of branch and "main div.c:44 (cycles:1)" is "from" of branch.
It should be easier for understanding than before.

Signed-off-by: Yao Jin <yao.jin@linux.intel.com>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1500894547-18411-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/branch.h    |  11 ++--
 tools/perf/util/callchain.c | 148 +++++++++++++++++++++++++++++++-------------
 2 files changed, 111 insertions(+), 48 deletions(-)

diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 686f2b65ba84..1e3c7c5cdc63 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -5,11 +5,12 @@
 #include "../perf.h"
 
 struct branch_type_stat {
-	u64 counts[PERF_BR_MAX];
-	u64 cond_fwd;
-	u64 cond_bwd;
-	u64 cross_4k;
-	u64 cross_2m;
+	bool	branch_to;
+	u64	counts[PERF_BR_MAX];
+	u64	cond_fwd;
+	u64	cond_bwd;
+	u64	cross_4k;
+	u64	cross_2m;
 };
 
 struct branch_flags;
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 1f536418dfb5..f320b0777e0d 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -563,20 +563,33 @@ fill_node(struct callchain_node *node, struct callchain_cursor *cursor)
 		if (cursor_node->branch) {
 			call->branch_count = 1;
 
-			if (cursor_node->branch_flags.predicted)
-				call->predicted_count = 1;
-
-			if (cursor_node->branch_flags.abort)
-				call->abort_count = 1;
-
-			call->cycles_count = cursor_node->branch_flags.cycles;
-			call->iter_count = cursor_node->nr_loop_iter;
-			call->samples_count = cursor_node->samples;
-
-			branch_type_count(&call->brtype_stat,
-					  &cursor_node->branch_flags,
-					  cursor_node->branch_from,
-					  cursor_node->ip);
+			if (cursor_node->branch_from) {
+				/*
+				 * branch_from is set with value somewhere else
+				 * to imply it's "to" of a branch.
+				 */
+				call->brtype_stat.branch_to = true;
+
+				if (cursor_node->branch_flags.predicted)
+					call->predicted_count = 1;
+
+				if (cursor_node->branch_flags.abort)
+					call->abort_count = 1;
+
+				branch_type_count(&call->brtype_stat,
+						  &cursor_node->branch_flags,
+						  cursor_node->branch_from,
+						  cursor_node->ip);
+			} else {
+				/*
+				 * It's "from" of a branch
+				 */
+				call->brtype_stat.branch_to = false;
+				call->cycles_count =
+					cursor_node->branch_flags.cycles;
+				call->iter_count = cursor_node->nr_loop_iter;
+				call->samples_count = cursor_node->samples;
+			}
 		}
 
 		list_add_tail(&call->list, &node->val);
@@ -685,20 +698,32 @@ static enum match_result match_chain(struct callchain_cursor_node *node,
 		if (node->branch) {
 			cnode->branch_count++;
 
-			if (node->branch_flags.predicted)
-				cnode->predicted_count++;
-
-			if (node->branch_flags.abort)
-				cnode->abort_count++;
-
-			cnode->cycles_count += node->branch_flags.cycles;
-			cnode->iter_count += node->nr_loop_iter;
-			cnode->samples_count += node->samples;
-
-			branch_type_count(&cnode->brtype_stat,
-					  &node->branch_flags,
-					  node->branch_from,
-					  node->ip);
+			if (node->branch_from) {
+				/*
+				 * It's "to" of a branch
+				 */
+				cnode->brtype_stat.branch_to = true;
+
+				if (node->branch_flags.predicted)
+					cnode->predicted_count++;
+
+				if (node->branch_flags.abort)
+					cnode->abort_count++;
+
+				branch_type_count(&cnode->brtype_stat,
+						  &node->branch_flags,
+						  node->branch_from,
+						  node->ip);
+			} else {
+				/*
+				 * It's "from" of a branch
+				 */
+				cnode->brtype_stat.branch_to = false;
+				cnode->cycles_count +=
+					node->branch_flags.cycles;
+				cnode->iter_count += node->nr_loop_iter;
+				cnode->samples_count += node->samples;
+			}
 		}
 
 		return MATCH_EQ;
@@ -1236,27 +1261,26 @@ static int count_pri64_printf(int idx, const char *str, u64 value, char *bf, int
 	return printed;
 }
 
-static int count_float_printf(int idx, const char *str, float value, char *bf, int bfsize)
+static int count_float_printf(int idx, const char *str, float value,
+			      char *bf, int bfsize, float threshold)
 {
 	int printed;
 
+	if (threshold != 0.0 && value < threshold)
+		return 0;
+
 	printed = scnprintf(bf, bfsize, "%s%s:%.1f%%", (idx) ? " " : " (", str, value);
 
 	return printed;
 }
 
-static int counts_str_build(char *bf, int bfsize,
-			     u64 branch_count, u64 predicted_count,
-			     u64 abort_count, u64 cycles_count,
-			     u64 iter_count, u64 samples_count,
-			     struct branch_type_stat *brtype_stat)
+static int branch_to_str(char *bf, int bfsize,
+			 u64 branch_count, u64 predicted_count,
+			 u64 abort_count,
+			 struct branch_type_stat *brtype_stat)
 {
-	u64 cycles;
 	int printed, i = 0;
 
-	if (branch_count == 0)
-		return scnprintf(bf, bfsize, " (calltrace)");
-
 	printed = branch_type_str(brtype_stat, bf, bfsize);
 	if (printed)
 		i++;
@@ -1264,15 +1288,29 @@ static int counts_str_build(char *bf, int bfsize,
 	if (predicted_count < branch_count) {
 		printed += count_float_printf(i++, "predicted",
 				predicted_count * 100.0 / branch_count,
-				bf + printed, bfsize - printed);
+				bf + printed, bfsize - printed, 0.0);
 	}
 
 	if (abort_count) {
 		printed += count_float_printf(i++, "abort",
 				abort_count * 100.0 / branch_count,
-				bf + printed, bfsize - printed);
+				bf + printed, bfsize - printed, 0.1);
 	}
 
+	if (i)
+		printed += scnprintf(bf + printed, bfsize - printed, ")");
+
+	return printed;
+}
+
+static int branch_from_str(char *bf, int bfsize,
+			   u64 branch_count,
+			   u64 cycles_count, u64 iter_count,
+			   u64 samples_count)
+{
+	int printed = 0, i = 0;
+	u64 cycles;
+
 	cycles = cycles_count / branch_count;
 	if (cycles) {
 		printed += count_pri64_printf(i++, "cycles",
@@ -1287,10 +1325,34 @@ static int counts_str_build(char *bf, int bfsize,
 	}
 
 	if (i)
-		return scnprintf(bf + printed, bfsize - printed, ")");
+		printed += scnprintf(bf + printed, bfsize - printed, ")");
 
-	bf[0] = 0;
-	return 0;
+	return printed;
+}
+
+static int counts_str_build(char *bf, int bfsize,
+			     u64 branch_count, u64 predicted_count,
+			     u64 abort_count, u64 cycles_count,
+			     u64 iter_count, u64 samples_count,
+			     struct branch_type_stat *brtype_stat)
+{
+	int printed;
+
+	if (branch_count == 0)
+		return scnprintf(bf, bfsize, " (calltrace)");
+
+	if (brtype_stat->branch_to) {
+		printed = branch_to_str(bf, bfsize, branch_count,
+				predicted_count, abort_count, brtype_stat);
+	} else {
+		printed = branch_from_str(bf, bfsize, branch_count,
+				cycles_count, iter_count, samples_count);
+	}
+
+	if (!printed)
+		bf[0] = 0;
+
+	return printed;
 }
 
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
-- 
2.9.4
