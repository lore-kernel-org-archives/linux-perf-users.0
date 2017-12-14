From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/34] perf stat: Remove a set of shadow stats static variables
Date: Thu, 14 Dec 2017 14:42:19 -0300
Message-ID: <20171214174247.16841-7-acme@kernel.org>
References: <20171214174247.16841-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171214174247.16841-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

In previous patches, we have reconstructed the code and let it not
access the static variables directly.

This patch removes these static variables.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-7-git-send-email-yao.jin@linux.intel.com
[ Rename 'stat' variables to 'st' to build on centos:{5,6} and others where it shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 68 ++++++++++---------------------------------
 tools/perf/util/stat.h        |  1 +
 2 files changed, 16 insertions(+), 53 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a95c4fe991aa..594d14a02b67 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -16,28 +16,6 @@
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
  */
-static struct stats runtime_nsecs_stats[MAX_NR_CPUS];
-static struct stats runtime_cycles_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_stalled_cycles_front_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_stalled_cycles_back_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_branches_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_cacherefs_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_l1_dcache_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_l1_icache_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_ll_cache_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_itlb_cache_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_dtlb_cache_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_cycles_in_tx_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_transaction_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_elision_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_topdown_total_slots[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_topdown_slots_issued[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_topdown_slots_retired[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_topdown_fetch_bubbles[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_topdown_recovery_bubbles[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_smi_num_stats[NUM_CTX][MAX_NR_CPUS];
-static struct stats runtime_aperf_stats[NUM_CTX][MAX_NR_CPUS];
-static struct rblist runtime_saved_values;
 static bool have_frontend_stalled;
 
 struct runtime_stat rt_stat;
@@ -163,10 +141,6 @@ void runtime_stat__exit(struct runtime_stat *st)
 void perf_stat__init_shadow_stats(void)
 {
 	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
-	rblist__init(&runtime_saved_values);
-	runtime_saved_values.node_cmp = saved_value_cmp;
-	runtime_saved_values.node_new = saved_value_new;
-	runtime_saved_values.node_delete = saved_value_delete;
 	runtime_stat__init(&rt_stat);
 }
 
@@ -188,36 +162,13 @@ static int evsel_context(struct perf_evsel *evsel)
 	return ctx;
 }
 
-void perf_stat__reset_shadow_stats(void)
+static void reset_stat(struct runtime_stat *st)
 {
+	struct rblist *rblist;
 	struct rb_node *pos, *next;
 
-	memset(runtime_nsecs_stats, 0, sizeof(runtime_nsecs_stats));
-	memset(runtime_cycles_stats, 0, sizeof(runtime_cycles_stats));
-	memset(runtime_stalled_cycles_front_stats, 0, sizeof(runtime_stalled_cycles_front_stats));
-	memset(runtime_stalled_cycles_back_stats, 0, sizeof(runtime_stalled_cycles_back_stats));
-	memset(runtime_branches_stats, 0, sizeof(runtime_branches_stats));
-	memset(runtime_cacherefs_stats, 0, sizeof(runtime_cacherefs_stats));
-	memset(runtime_l1_dcache_stats, 0, sizeof(runtime_l1_dcache_stats));
-	memset(runtime_l1_icache_stats, 0, sizeof(runtime_l1_icache_stats));
-	memset(runtime_ll_cache_stats, 0, sizeof(runtime_ll_cache_stats));
-	memset(runtime_itlb_cache_stats, 0, sizeof(runtime_itlb_cache_stats));
-	memset(runtime_dtlb_cache_stats, 0, sizeof(runtime_dtlb_cache_stats));
-	memset(runtime_cycles_in_tx_stats, 0,
-			sizeof(runtime_cycles_in_tx_stats));
-	memset(runtime_transaction_stats, 0,
-		sizeof(runtime_transaction_stats));
-	memset(runtime_elision_stats, 0, sizeof(runtime_elision_stats));
-	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
-	memset(runtime_topdown_total_slots, 0, sizeof(runtime_topdown_total_slots));
-	memset(runtime_topdown_slots_retired, 0, sizeof(runtime_topdown_slots_retired));
-	memset(runtime_topdown_slots_issued, 0, sizeof(runtime_topdown_slots_issued));
-	memset(runtime_topdown_fetch_bubbles, 0, sizeof(runtime_topdown_fetch_bubbles));
-	memset(runtime_topdown_recovery_bubbles, 0, sizeof(runtime_topdown_recovery_bubbles));
-	memset(runtime_smi_num_stats, 0, sizeof(runtime_smi_num_stats));
-	memset(runtime_aperf_stats, 0, sizeof(runtime_aperf_stats));
-
-	next = rb_first(&runtime_saved_values.entries);
+	rblist = &st->value_list;
+	next = rb_first(&rblist->entries);
 	while (next) {
 		pos = next;
 		next = rb_next(pos);
@@ -227,6 +178,17 @@ void perf_stat__reset_shadow_stats(void)
 	}
 }
 
+void perf_stat__reset_shadow_stats(void)
+{
+	reset_stat(&rt_stat);
+	memset(&walltime_nsecs_stats, 0, sizeof(walltime_nsecs_stats));
+}
+
+void perf_stat__reset_shadow_per_stat(struct runtime_stat *st)
+{
+	reset_stat(st);
+}
+
 static void update_runtime_stat(struct runtime_stat *st,
 				enum stat_type type,
 				int ctx, int cpu, u64 count)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 76b322a2d293..cfe4fb899633 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -128,6 +128,7 @@ void runtime_stat__init(struct runtime_stat *st);
 void runtime_stat__exit(struct runtime_stat *st);
 void perf_stat__init_shadow_stats(void);
 void perf_stat__reset_shadow_stats(void);
+void perf_stat__reset_shadow_per_stat(struct runtime_stat *st);
 void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 count,
 				    int cpu, struct runtime_stat *st);
 struct perf_stat_output_ctx {
-- 
2.13.6
