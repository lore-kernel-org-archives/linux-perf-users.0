From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/19] perf stat: Move the shadow stats scale computation in perf_stat__update_shadow_stats
Date: Fri,  3 Nov 2017 10:54:56 -0300
Message-ID: <20171103135503.4921-13-acme@kernel.org>
References: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171103135503.4921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Andi Kleen <andi@firstfloor.org>, Changbin Du <changbin.du@intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the shadow stats scale computation to the
perf_stat__update_shadow_stats() function, so it's centralized and we
don't forget to do it. It also saves few lines of code.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/n/tip-htg7mmyxv6pcrf57qyo6msid@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     |  3 +--
 tools/perf/util/stat-shadow.c | 48 ++++++++++++++++++++++---------------------
 tools/perf/util/stat.c        |  6 ++----
 tools/perf/util/stat.h        |  2 +-
 4 files changed, 29 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fa5896270022..59af5a8419e2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1267,8 +1267,7 @@ static void aggr_update_shadow(void)
 					continue;
 				val += perf_counts(counter->counts, cpu, 0)->val;
 			}
-			val = val * counter->scale;
-			perf_stat__update_shadow_stats(counter, &val,
+			perf_stat__update_shadow_stats(counter, val,
 						       first_shadow_cpu(counter, id));
 		}
 	}
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a2c12d1ef32a..51ad03a799ec 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -178,58 +178,60 @@ void perf_stat__reset_shadow_stats(void)
  * more semantic information such as miss/hit ratios,
  * instruction rates, etc:
  */
-void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 *count,
+void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu)
 {
 	int ctx = evsel_context(counter);
 
+	count *= counter->scale;
+
 	if (perf_evsel__match(counter, SOFTWARE, SW_TASK_CLOCK) ||
 	    perf_evsel__match(counter, SOFTWARE, SW_CPU_CLOCK))
-		update_stats(&runtime_nsecs_stats[cpu], count[0]);
+		update_stats(&runtime_nsecs_stats[cpu], count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CPU_CYCLES))
-		update_stats(&runtime_cycles_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_cycles_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, CYCLES_IN_TX))
-		update_stats(&runtime_cycles_in_tx_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_cycles_in_tx_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TRANSACTION_START))
-		update_stats(&runtime_transaction_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_transaction_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, ELISION_START))
-		update_stats(&runtime_elision_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_elision_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_TOTAL_SLOTS))
-		update_stats(&runtime_topdown_total_slots[ctx][cpu], count[0]);
+		update_stats(&runtime_topdown_total_slots[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_ISSUED))
-		update_stats(&runtime_topdown_slots_issued[ctx][cpu], count[0]);
+		update_stats(&runtime_topdown_slots_issued[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_SLOTS_RETIRED))
-		update_stats(&runtime_topdown_slots_retired[ctx][cpu], count[0]);
+		update_stats(&runtime_topdown_slots_retired[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_FETCH_BUBBLES))
-		update_stats(&runtime_topdown_fetch_bubbles[ctx][cpu],count[0]);
+		update_stats(&runtime_topdown_fetch_bubbles[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, TOPDOWN_RECOVERY_BUBBLES))
-		update_stats(&runtime_topdown_recovery_bubbles[ctx][cpu], count[0]);
+		update_stats(&runtime_topdown_recovery_bubbles[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_FRONTEND))
-		update_stats(&runtime_stalled_cycles_front_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_stalled_cycles_front_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_STALLED_CYCLES_BACKEND))
-		update_stats(&runtime_stalled_cycles_back_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_stalled_cycles_back_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_BRANCH_INSTRUCTIONS))
-		update_stats(&runtime_branches_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_branches_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HARDWARE, HW_CACHE_REFERENCES))
-		update_stats(&runtime_cacherefs_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_cacherefs_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1D))
-		update_stats(&runtime_l1_dcache_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_l1_dcache_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_L1I))
-		update_stats(&runtime_ll_cache_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_ll_cache_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_LL))
-		update_stats(&runtime_ll_cache_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_ll_cache_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_DTLB))
-		update_stats(&runtime_dtlb_cache_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_dtlb_cache_stats[ctx][cpu], count);
 	else if (perf_evsel__match(counter, HW_CACHE, HW_CACHE_ITLB))
-		update_stats(&runtime_itlb_cache_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_itlb_cache_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, SMI_NUM))
-		update_stats(&runtime_smi_num_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_smi_num_stats[ctx][cpu], count);
 	else if (perf_stat_evsel__is(counter, APERF))
-		update_stats(&runtime_aperf_stats[ctx][cpu], count[0]);
+		update_stats(&runtime_aperf_stats[ctx][cpu], count);
 
 	if (counter->collect_stat) {
 		struct saved_value *v = saved_value_lookup(counter, cpu, true);
-		update_stats(&v->stats, count[0]);
+		update_stats(&v->stats, count);
 	}
 }
 
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 933de91831fa..ef00c91e2553 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -277,7 +277,7 @@ process_counter_values(struct perf_stat_config *config, struct perf_evsel *evsel
 			perf_evsel__compute_deltas(evsel, cpu, thread, count);
 		perf_counts_values__scale(count, config->scale, NULL);
 		if (config->aggr_mode == AGGR_NONE)
-			perf_stat__update_shadow_stats(evsel, count->values, cpu);
+			perf_stat__update_shadow_stats(evsel, count->val, cpu);
 		break;
 	case AGGR_GLOBAL:
 		aggr->val += count->val;
@@ -320,7 +320,6 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	struct perf_counts_values *aggr = &counter->counts->aggr;
 	struct perf_stat_evsel *ps = counter->stats;
 	u64 *count = counter->counts->aggr.values;
-	u64 val;
 	int i, ret;
 
 	aggr->val = aggr->ena = aggr->run = 0;
@@ -360,8 +359,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 	/*
 	 * Save the full runtime - to allow normalization during printout:
 	 */
-	val = counter->scale * *count;
-	perf_stat__update_shadow_stats(counter, &val, 0);
+	perf_stat__update_shadow_stats(counter, *count, 0);
 
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 47915df346fb..490b78aa7230 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -82,7 +82,7 @@ typedef void (*new_line_t )(void *ctx);
 
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
-void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 *count,
+void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu);
 struct perf_stat_output_ctx {
 	void *ctx;
-- 
2.13.6
