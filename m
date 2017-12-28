From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/35] perf stat: Update per-thread shadow stats
Date: Thu, 28 Dec 2017 11:29:56 -0300
Message-ID: <20171228143027.30547-5-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The functions perf_stat__update_shadow_stats() is called to update the
shadow stats on a set of static variables.

But the static variables are the limitations to be extended to support
per-thread shadow stats.

This patch lets the perf_stat__update_shadow_stats() support to update
the shadow stats on a input parameter 'st' and uses
update_runtime_stat() to update the stats. It will not directly update
the static variables as before.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-5-git-send-email-yao.jin@linux.intel.com
[ Rename 'stat' variables to 'st' to build on centos:{5,6} and others where it shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c   |  3 +-
 tools/perf/builtin-stat.c     |  3 +-
 tools/perf/util/stat-shadow.c | 86 +++++++++++++++++++++++++++++--------------
 tools/perf/util/stat.c        |  8 ++--
 tools/perf/util/stat.h        |  2 +-
 5 files changed, 68 insertions(+), 34 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 39d8b55f0db3..81b395040298 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1548,7 +1548,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 	val = sample->period * evsel->scale;
 	perf_stat__update_shadow_stats(evsel,
 				       val,
-				       sample->cpu);
+				       sample->cpu,
+				       &rt_stat);
 	evsel_script(evsel)->val = val;
 	if (evsel_script(evsel->leader)->gnum == evsel->leader->nr_members) {
 		for_each_group_member (ev2, evsel->leader) {
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index a027b4712e48..3f4a2c21b824 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1214,7 +1214,8 @@ static void aggr_update_shadow(void)
 				val += perf_counts(counter->counts, cpu, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-						       first_shadow_cpu(counter, id));
+					first_shadow_cpu(counter, id),
+					&rt_stat);
 		}
 	}
 }
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 07cfbf613bdc..4b28c40de927 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -116,19 +116,29 @@ static void saved_value_delete(struct rblist *rblist __maybe_unused,
 
 static struct saved_value *saved_value_lookup(struct perf_evsel *evsel,
 					      int cpu,
-					      bool create)
+					      bool create,
+					      enum stat_type type,
+					      int ctx,
+					      struct runtime_stat *st)
 {
+	struct rblist *rblist;
 	struct rb_node *nd;
 	struct saved_value dm = {
 		.cpu = cpu,
 		.evsel = evsel,
+		.type = type,
+		.ctx = ctx,
+		.stat = st,
 	};
-	nd = rblist__find(&runtime_saved_values, &dm);
+
+	rblist = &st->value_list;
+
+	nd = rblist__find(rblist, &dm);
 	if (nd)
 		return container_of(nd, struct saved_value, rb_node);
 	if (create) {
-		rblist__add_node(&runtime_saved_values, &dm);
-		nd = rblist__find(&runtime_saved_values, &dm);
+		rblist__add_node(rblist, &dm);
+		nd = rblist__find(rblist, &dm);
 		if (nd)
 			return container_of(nd, struct saved_value, rb_node);
 	}
@@ -217,13 +227,24 @@ void perf_stat__reset_shadow_stats(void)
 	}
 }
 
+static void update_runtime_stat(struct runtime_stat *st,
+				enum stat_type type,
+				int ctx, int cpu, u64 count)
+{
+	struct saved_value *v = saved_value_lookup(NULL, cpu, true,
+						   type, ctx, st);
+
+	if (v)
+		update_stats(&v->stats, count);
+}
+
 /*
  * Update various tracking values we maintain to print
  * more semantic information such as miss/hit ratios,
  * instruction rates, etc:
  */
 void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
-				    int cpu)
+				    int cpu, struct runtime_stat *st)
 {
 	int ctx = evsel_context(counter);
 
@@ -231,50 +252,58 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 
 	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
 	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
-		update_stats(&runtime_nsecs_stats[cpu], count);
+		update_runtime_stat(st, STAT_NSECS, 0, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_stats(&runtime_cycles_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_CYCLES, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_stats(&runtime_cycles_in_tx_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_CYCLES_IN_TX, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_stats(&runtime_transaction_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TRANSACTION, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_stats(&runtime_elision_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_ELISION, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
-		update_stats(&runtime_topdown_total_slots[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TOPDOWN_TOTAL_SLOTS,
+				    ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
-		update_stats(&runtime_topdown_slots_issued[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_ISSUED,
+				    ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
-		update_stats(&runtime_topdown_slots_retired[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TOPDOWN_SLOTS_RETIRED,
+				    ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
-		update_stats(&runtime_topdown_fetch_bubbles[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TOPDOWN_FETCH_BUBBLES,
+				    ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
-		update_stats(&runtime_topdown_recovery_bubbles[ctx][cpu], count);
+		update_runtime_stat(st, STAT_TOPDOWN_RECOVERY_BUBBLES,
+				    ctx, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
-		update_stats(&runtime_stalled_cycles_front_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_STALLED_CYCLES_FRONT,
+				    ctx, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
-		update_stats(&runtime_stalled_cycles_back_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_STALLED_CYCLES_BACK,
+				    ctx, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_stats(&runtime_branches_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_BRANCHES, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_stats(&runtime_cacherefs_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_CACHEREFS, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_stats(&runtime_l1_dcache_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_L1_DCACHE, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_stats(&runtime_ll_cache_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_L1_ICACHE, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_stats(&runtime_ll_cache_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_LL_CACHE, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_stats(&runtime_dtlb_cache_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_DTLB_CACHE, ctx, cpu, count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_stats(&runtime_itlb_cache_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_ITLB_CACHE, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_stats(&runtime_smi_num_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_SMI_NUM, ctx, cpu, count);
 	else if (perf_stat_evsel__is(counter, APERF))
-		update_stats(&runtime_aperf_stats[ctx][cpu], count);
+		update_runtime_stat(st, STAT_APERF, ctx, cpu, count);
 
 	if (counter->collect_stat) {
-		struct saved_value *v = saved_value_lookup(counter, cpu, true);
+		struct saved_value *v = saved_value_lookup(counter, cpu, true,
+							   STAT_NONE, 0, st);
 		update_stats(&v->stats, count);
 	}
 }
@@ -694,7 +723,8 @@ static void generic_metric(const char *metric_expr,
 			stats = &walltime_nsecs_stats;
 			scale = 1e-9;
 		} else {
-			v = saved_value_lookup(metric_events[i], cpu, false);
+			v = saved_value_lookup(metric_events[i], cpu, false,
+					       STAT_NONE, 0, &rt_stat);
 			if (!v)
 				break;
 			stats = &v->stats;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 151e9efd7286..78abfd40b135 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -278,9 +278,11 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
 		if (config->aggr_mode == AGGR_NONE)
-			perf_stat__update_shadow_stats(evsel, count->val, cpu);
+			perf_stat__update_shadow_stats(evsel, count->val, cpu,
+						       &rt_stat);
 		if (config->aggr_mode == AGGR_THREAD)
-			perf_stat__update_shadow_stats(evsel, count->val, 0);
+			perf_stat__update_shadow_stats(evsel, count->val, 0,
+						       &rt_stat);
 		break;
 	case AGGR_GLOBAL:
 		aggr->val += count->val;
@@ -362,7 +364,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	/*
 	 * Save the full runtime - to allow normalization during printout:
 	 */
-	perf_stat__update_shadow_stats(counter, *count, 0);
+	perf_stat__update_shadow_stats(counter, *count, 0, &rt_stat);
 
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index f20240037377..bb9902ad3a79 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -129,7 +129,7 @@ void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
 void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
-				    int cpu);
+				    int cpu, struct runtime_stat *st);
 struct perf_stat_output_ctx {
 	void *ctx;
 	print_metric_t print_metric;
-- 
2.13.6
