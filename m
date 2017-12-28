From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/35] perf stat: Print per-thread shadow stats
Date: Thu, 28 Dec 2017 11:29:57 -0300
Message-ID: <20171228143027.30547-6-acme@kernel.org>
References: <20171228143027.30547-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171228143027.30547-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

The function perf_stat__print_shadow_stats() is called to print the
shadow stats on a set of static variables.

But the static variables are the limitations to support
per-thread shadow stats.

This patch lets the perf_stat__print_shadow_stats() support
to print the shadow stats from a input parameter 'st'.

It will not directly get value from static variable. Instead,
it now uses runtime_stat_avg() and runtime_stat_n() to get and
compute the values.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1512482591-4646-6-git-send-email-yao.jin@linux.intel.com
[ Rename 'stat' variables to 'st' to build on centos:{5,6} and others where it shadows a global declaration ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c   |   3 +-
 tools/perf/builtin-stat.c     |  23 +++--
 tools/perf/util/stat-shadow.c | 209 ++++++++++++++++++++++++++----------------
 tools/perf/util/stat.h        |   3 +-
 4 files changed, 151 insertions(+), 87 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 81b395040298..fac6f053e4da 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1557,7 +1557,8 @@ static void perf_sample__fprint_metric(struct perf_script *script,
 						      evsel_script(ev2)->val,
 						      sample->cpu,
 						      &ctx,
-						      NULL);
+						      NULL,
+						      &rt_stat);
 		}
 		evsel_script(evsel->leader)->gnum = 0;
 	}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f4a2c21b824..097a694d16f2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1097,7 +1097,8 @@ static void abs_printout(int id, int nr, struct perf_evsel *evsel, double avg)
 }
 
 static void printout(int id, int nr, struct perf_evsel *counter, double uval,
-		     char *prefix, u64 run, u64 ena, double noise)
+		     char *prefix, u64 run, u64 ena, double noise,
+		     struct runtime_stat *st)
 {
 	struct perf_stat_output_ctx out;
 	struct outstate os = {
@@ -1190,7 +1191,7 @@ static void printout(int id, int nr, struct perf_evsel *counter, double uval,
 
 	perf_stat__print_shadow_stats(counter, uval,
 				first_shadow_cpu(counter, id),
-				&out, &metric_events);
+				&out, &metric_events, st);
 	if (!csv_output && !metric_only) {
 		print_noise(counter, noise);
 		print_running(run, ena);
@@ -1335,7 +1336,8 @@ static void print_aggr(char *prefix)
 				fprintf(output, "%s", prefix);
 
 			uval = val * counter->scale;
-			printout(id, nr, counter, uval, prefix, run, ena, 1.0);
+			printout(id, nr, counter, uval, prefix, run, ena, 1.0,
+				 &rt_stat);
 			if (!metric_only)
 				fputc('\n', output);
 		}
@@ -1365,7 +1367,8 @@ static void print_aggr_thread(struct perf_evsel *counter, char *prefix)
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		printout(thread, 0, counter, uval, prefix, run, ena, 1.0);
+		printout(thread, 0, counter, uval, prefix, run, ena, 1.0,
+			 &rt_stat);
 		fputc('\n', output);
 	}
 }
@@ -1402,7 +1405,8 @@ static void print_counter_aggr(struct perf_evsel *counter, char *prefix)
 		fprintf(output, "%s", prefix);
 
 	uval = cd.avg * counter->scale;
-	printout(-1, 0, counter, uval, prefix, cd.avg_running, cd.avg_enabled, cd.avg);
+	printout(-1, 0, counter, uval, prefix, cd.avg_running, cd.avg_enabled,
+		 cd.avg, &rt_stat);
 	if (!metric_only)
 		fprintf(output, "\n");
 }
@@ -1441,7 +1445,8 @@ static void print_counter(struct perf_evsel *counter, char *prefix)
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		printout(cpu, 0, counter, uval, prefix, run, ena, 1.0);
+		printout(cpu, 0, counter, uval, prefix, run, ena, 1.0,
+			 &rt_stat);
 
 		fputc('\n', output);
 	}
@@ -1473,7 +1478,8 @@ static void print_no_aggr_metric(char *prefix)
 			run = perf_counts(counter->counts, cpu, 0)->run;
 
 			uval = val * counter->scale;
-			printout(cpu, 0, counter, uval, prefix, run, ena, 1.0);
+			printout(cpu, 0, counter, uval, prefix, run, ena, 1.0,
+				 &rt_stat);
 		}
 		fputc('\n', stat_config.output);
 	}
@@ -1529,7 +1535,8 @@ static void print_metric_headers(const char *prefix, bool no_indent)
 		perf_stat__print_shadow_stats(counter, 0,
 					      0,
 					      &out,
-					      &metric_events);
+					      &metric_events,
+					      &rt_stat);
 	}
 	fputc('\n', stat_config.output);
 }
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 4b28c40de927..a95c4fe991aa 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -424,15 +424,40 @@ void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 	}
 }
 
+static double runtime_stat_avg(struct runtime_stat *st,
+			       enum stat_type type, int ctx, int cpu)
+{
+	struct saved_value *v;
+
+	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	if (!v)
+		return 0.0;
+
+	return avg_stats(&v->stats);
+}
+
+static double runtime_stat_n(struct runtime_stat *st,
+			     enum stat_type type, int ctx, int cpu)
+{
+	struct saved_value *v;
+
+	v = saved_value_lookup(NULL, cpu, false, type, ctx, st);
+	if (!v)
+		return 0.0;
+
+	return v->stats.n;
+}
+
 static void print_stalled_cycles_frontend(int cpu,
 					  struct perf_evsel *evsel, double avg,
-					  struct perf_stat_output_ctx *out)
+					  struct perf_stat_output_ctx *out,
+					  struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_cycles_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -448,13 +473,14 @@ static void print_stalled_cycles_frontend(int cpu,
 
 static void print_stalled_cycles_backend(int cpu,
 					 struct perf_evsel *evsel, double avg,
-					 struct perf_stat_output_ctx *out)
+					 struct perf_stat_output_ctx *out,
+					 struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_cycles_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -467,13 +493,14 @@ static void print_stalled_cycles_backend(int cpu,
 static void print_branch_misses(int cpu,
 				struct perf_evsel *evsel,
 				double avg,
-				struct perf_stat_output_ctx *out)
+				struct perf_stat_output_ctx *out,
+				struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_branches_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_BRANCHES, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -486,13 +513,15 @@ static void print_branch_misses(int cpu,
 static void print_l1_dcache_misses(int cpu,
 				   struct perf_evsel *evsel,
 				   double avg,
-				   struct perf_stat_output_ctx *out)
+				   struct perf_stat_output_ctx *out,
+				   struct runtime_stat *st)
+
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_l1_dcache_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_L1_DCACHE, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -505,13 +534,15 @@ static void print_l1_dcache_misses(int cpu,
 static void print_l1_icache_misses(int cpu,
 				   struct perf_evsel *evsel,
 				   double avg,
-				   struct perf_stat_output_ctx *out)
+				   struct perf_stat_output_ctx *out,
+				   struct runtime_stat *st)
+
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_l1_icache_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_L1_ICACHE, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -523,13 +554,14 @@ static void print_l1_icache_misses(int cpu,
 static void print_dtlb_cache_misses(int cpu,
 				    struct perf_evsel *evsel,
 				    double avg,
-				    struct perf_stat_output_ctx *out)
+				    struct perf_stat_output_ctx *out,
+				    struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_dtlb_cache_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_DTLB_CACHE, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -541,13 +573,14 @@ static void print_dtlb_cache_misses(int cpu,
 static void print_itlb_cache_misses(int cpu,
 				    struct perf_evsel *evsel,
 				    double avg,
-				    struct perf_stat_output_ctx *out)
+				    struct perf_stat_output_ctx *out,
+				    struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_itlb_cache_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_ITLB_CACHE, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -559,13 +592,14 @@ static void print_itlb_cache_misses(int cpu,
 static void print_ll_cache_misses(int cpu,
 				  struct perf_evsel *evsel,
 				  double avg,
-				  struct perf_stat_output_ctx *out)
+				  struct perf_stat_output_ctx *out,
+				  struct runtime_stat *st)
 {
 	double total, ratio = 0.0;
 	const char *color;
 	int ctx = evsel_context(evsel);
 
-	total = avg_stats(&runtime_ll_cache_stats[ctx][cpu]);
+	total = runtime_stat_avg(st, STAT_LL_CACHE, ctx, cpu);
 
 	if (total)
 		ratio = avg / total * 100.0;
@@ -623,68 +657,72 @@ static double sanitize_val(double x)
 	return x;
 }
 
-static double td_total_slots(int ctx, int cpu)
+static double td_total_slots(int ctx, int cpu, struct runtime_stat *st)
 {
-	return avg_stats(&runtime_topdown_total_slots[ctx][cpu]);
+	return runtime_stat_avg(st, STAT_TOPDOWN_TOTAL_SLOTS, ctx, cpu);
 }
 
-static double td_bad_spec(int ctx, int cpu)
+static double td_bad_spec(int ctx, int cpu, struct runtime_stat *st)
 {
 	double bad_spec = 0;
 	double total_slots;
 	double total;
 
-	total = avg_stats(&runtime_topdown_slots_issued[ctx][cpu]) -
-		avg_stats(&runtime_topdown_slots_retired[ctx][cpu]) +
-		avg_stats(&runtime_topdown_recovery_bubbles[ctx][cpu]);
-	total_slots = td_total_slots(ctx, cpu);
+	total = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_ISSUED, ctx, cpu) -
+		runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED, ctx, cpu) +
+		runtime_stat_avg(st, STAT_TOPDOWN_RECOVERY_BUBBLES, ctx, cpu);
+
+	total_slots = td_total_slots(ctx, cpu, st);
 	if (total_slots)
 		bad_spec = total / total_slots;
 	return sanitize_val(bad_spec);
 }
 
-static double td_retiring(int ctx, int cpu)
+static double td_retiring(int ctx, int cpu, struct runtime_stat *st)
 {
 	double retiring = 0;
-	double total_slots = td_total_slots(ctx, cpu);
-	double ret_slots = avg_stats(&runtime_topdown_slots_retired[ctx][cpu]);
+	double total_slots = td_total_slots(ctx, cpu, st);
+	double ret_slots = runtime_stat_avg(st, STAT_TOPDOWN_SLOTS_RETIRED,
+					    ctx, cpu);
 
 	if (total_slots)
 		retiring = ret_slots / total_slots;
 	return retiring;
 }
 
-static double td_fe_bound(int ctx, int cpu)
+static double td_fe_bound(int ctx, int cpu, struct runtime_stat *st)
 {
 	double fe_bound = 0;
-	double total_slots = td_total_slots(ctx, cpu);
-	double fetch_bub = avg_stats(&runtime_topdown_fetch_bubbles[ctx][cpu]);
+	double total_slots = td_total_slots(ctx, cpu, st);
+	double fetch_bub = runtime_stat_avg(st, STAT_TOPDOWN_FETCH_BUBBLES,
+					    ctx, cpu);
 
 	if (total_slots)
 		fe_bound = fetch_bub / total_slots;
 	return fe_bound;
 }
 
-static double td_be_bound(int ctx, int cpu)
+static double td_be_bound(int ctx, int cpu, struct runtime_stat *st)
 {
-	double sum = (td_fe_bound(ctx, cpu) +
-		      td_bad_spec(ctx, cpu) +
-		      td_retiring(ctx, cpu));
+	double sum = (td_fe_bound(ctx, cpu, st) +
+		      td_bad_spec(ctx, cpu, st) +
+		      td_retiring(ctx, cpu, st));
 	if (sum == 0)
 		return 0;
 	return sanitize_val(1.0 - sum);
 }
 
 static void print_smi_cost(int cpu, struct perf_evsel *evsel,
-			   struct perf_stat_output_ctx *out)
+			   struct perf_stat_output_ctx *out,
+			   struct runtime_stat *st)
 {
 	double smi_num, aperf, cycles, cost = 0.0;
 	int ctx = evsel_context(evsel);
 	const char *color = NULL;
 
-	smi_num = avg_stats(&runtime_smi_num_stats[ctx][cpu]);
-	aperf = avg_stats(&runtime_aperf_stats[ctx][cpu]);
-	cycles = avg_stats(&runtime_cycles_stats[ctx][cpu]);
+	smi_num = runtime_stat_avg(st, STAT_SMI_NUM, ctx, cpu);
+	aperf = runtime_stat_avg(st, STAT_APERF, ctx, cpu);
+	cycles = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
 
 	if ((cycles == 0) || (aperf == 0))
 		return;
@@ -704,7 +742,8 @@ static void generic_metric(const char *metric_expr,
 			   const char *metric_name,
 			   double avg,
 			   int cpu,
-			   struct perf_stat_output_ctx *out)
+			   struct perf_stat_output_ctx *out,
+			   struct runtime_stat *st)
 {
 	print_metric_t print_metric = out->print_metric;
 	struct parse_ctx pctx;
@@ -724,7 +763,7 @@ static void generic_metric(const char *metric_expr,
 			scale = 1e-9;
 		} else {
 			v = saved_value_lookup(metric_events[i], cpu, false,
-					       STAT_NONE, 0, &rt_stat);
+					       STAT_NONE, 0, st);
 			if (!v)
 				break;
 			stats = &v->stats;
@@ -752,7 +791,8 @@ static void generic_metric(const char *metric_expr,
 void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events)
+				   struct rblist *metric_events,
+				   struct runtime_stat *st)
 {
 	void *ctxp = out->ctx;
 	print_metric_t print_metric = out->print_metric;
@@ -763,7 +803,8 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 	int num = 1;
 
 	if (perf_evsel__match(evsel, HARDWARE, HW_INSTRUCTIONS)) {
-		total = avg_stats(&runtime_cycles_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+
 		if (total) {
 			ratio = avg / total;
 			print_metric(ctxp, NULL, "%7.2f ",
@@ -771,8 +812,13 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		} else {
 			print_metric(ctxp, NULL, NULL, "insn per cycle", 0);
 		}
-		total = avg_stats(&runtime_stalled_cycles_front_stats[ctx][cpu]);
-		total = max(total, avg_stats(&runtime_stalled_cycles_back_stats[ctx][cpu]));
+
+		total = runtime_stat_avg(st, STAT_STALLED_CYCLES_FRONT,
+					 ctx, cpu);
+
+		total = max(total, runtime_stat_avg(st,
+						    STAT_STALLED_CYCLES_BACK,
+						    ctx, cpu));
 
 		if (total && avg) {
 			out->new_line(ctxp);
@@ -785,8 +831,8 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
-		if (runtime_branches_stats[ctx][cpu].n != 0)
-			print_branch_misses(cpu, evsel, avg, out);
+		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
+			print_branch_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all branches", 0);
 	} else if (
@@ -794,8 +840,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1D |
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-		if (runtime_l1_dcache_stats[ctx][cpu].n != 0)
-			print_l1_dcache_misses(cpu, evsel, avg, out);
+
+		if (runtime_stat_n(st, STAT_L1_DCACHE, ctx, cpu) != 0)
+			print_l1_dcache_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all L1-dcache hits", 0);
 	} else if (
@@ -803,8 +850,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_L1I |
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-		if (runtime_l1_icache_stats[ctx][cpu].n != 0)
-			print_l1_icache_misses(cpu, evsel, avg, out);
+
+		if (runtime_stat_n(st, STAT_L1_ICACHE, ctx, cpu) != 0)
+			print_l1_icache_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all L1-icache hits", 0);
 	} else if (
@@ -812,8 +860,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_DTLB |
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-		if (runtime_dtlb_cache_stats[ctx][cpu].n != 0)
-			print_dtlb_cache_misses(cpu, evsel, avg, out);
+
+		if (runtime_stat_n(st, STAT_DTLB_CACHE, ctx, cpu) != 0)
+			print_dtlb_cache_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all dTLB cache hits", 0);
 	} else if (
@@ -821,8 +870,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_ITLB |
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-		if (runtime_itlb_cache_stats[ctx][cpu].n != 0)
-			print_itlb_cache_misses(cpu, evsel, avg, out);
+
+		if (runtime_stat_n(st, STAT_ITLB_CACHE, ctx, cpu) != 0)
+			print_itlb_cache_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all iTLB cache hits", 0);
 	} else if (
@@ -830,27 +880,28 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		evsel->attr.config ==  ( PERF_COUNT_HW_CACHE_LL |
 					((PERF_COUNT_HW_CACHE_OP_READ) << 8) |
 					 ((PERF_COUNT_HW_CACHE_RESULT_MISS) << 16))) {
-		if (runtime_ll_cache_stats[ctx][cpu].n != 0)
-			print_ll_cache_misses(cpu, evsel, avg, out);
+
+		if (runtime_stat_n(st, STAT_LL_CACHE, ctx, cpu) != 0)
+			print_ll_cache_misses(cpu, evsel, avg, out, st);
 		else
 			print_metric(ctxp, NULL, NULL, "of all LL-cache hits", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CACHE_MISSES)) {
-		total = avg_stats(&runtime_cacherefs_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CACHEREFS, ctx, cpu);
 
 		if (total)
 			ratio = avg * 100 / total;
 
-		if (runtime_cacherefs_stats[ctx][cpu].n != 0)
+		if (runtime_stat_n(st, STAT_CACHEREFS, ctx, cpu) != 0)
 			print_metric(ctxp, NULL, "%8.3f %%",
 				     "of all cache refs", ratio);
 		else
 			print_metric(ctxp, NULL, NULL, "of all cache refs", 0);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_FRONTEND)) {
-		print_stalled_cycles_frontend(cpu, evsel, avg, out);
+		print_stalled_cycles_frontend(cpu, evsel, avg, out, st);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_STALLED_CYCLES_BACKEND)) {
-		print_stalled_cycles_backend(cpu, evsel, avg, out);
+		print_stalled_cycles_backend(cpu, evsel, avg, out, st);
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_CPU_CYCLES)) {
-		total = avg_stats(&runtime_nsecs_stats[cpu]);
+		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
 
 		if (total) {
 			ratio = avg / total;
@@ -859,7 +910,8 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			print_metric(ctxp, NULL, NULL, "Ghz", 0);
 		}
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX)) {
-		total = avg_stats(&runtime_cycles_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+
 		if (total)
 			print_metric(ctxp, NULL,
 					"%7.2f%%", "transactional cycles",
@@ -868,8 +920,9 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			print_metric(ctxp, NULL, NULL, "transactional cycles",
 				     0);
 	} else if (perf_stat_evsel__is(evsel, CYCLES_IN_TX_CP)) {
-		total = avg_stats(&runtime_cycles_stats[ctx][cpu]);
-		total2 = avg_stats(&runtime_cycles_in_tx_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CYCLES, ctx, cpu);
+		total2 = runtime_stat_avg(st, STAT_CYCLES_IN_TX, ctx, cpu);
+
 		if (total2 < avg)
 			total2 = avg;
 		if (total)
@@ -878,19 +931,21 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		else
 			print_metric(ctxp, NULL, NULL, "aborted cycles", 0);
 	} else if (perf_stat_evsel__is(evsel, TRANSACTION_START)) {
-		total = avg_stats(&runtime_cycles_in_tx_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
+					 ctx, cpu);
 
 		if (avg)
 			ratio = total / avg;
 
-		if (runtime_cycles_in_tx_stats[ctx][cpu].n != 0)
+		if (runtime_stat_n(st, STAT_CYCLES_IN_TX, ctx, cpu) != 0)
 			print_metric(ctxp, NULL, "%8.0f",
 				     "cycles / transaction", ratio);
 		else
 			print_metric(ctxp, NULL, NULL, "cycles / transaction",
-				     0);
+				      0);
 	} else if (perf_stat_evsel__is(evsel, ELISION_START)) {
-		total = avg_stats(&runtime_cycles_in_tx_stats[ctx][cpu]);
+		total = runtime_stat_avg(st, STAT_CYCLES_IN_TX,
+					 ctx, cpu);
 
 		if (avg)
 			ratio = total / avg;
@@ -904,28 +959,28 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		else
 			print_metric(ctxp, NULL, NULL, "CPUs utilized", 0);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_FETCH_BUBBLES)) {
-		double fe_bound = td_fe_bound(ctx, cpu);
+		double fe_bound = td_fe_bound(ctx, cpu, st);
 
 		if (fe_bound > 0.2)
 			color = PERF_COLOR_RED;
 		print_metric(ctxp, color, "%8.1f%%", "frontend bound",
 				fe_bound * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_RETIRED)) {
-		double retiring = td_retiring(ctx, cpu);
+		double retiring = td_retiring(ctx, cpu, st);
 
 		if (retiring > 0.7)
 			color = PERF_COLOR_GREEN;
 		print_metric(ctxp, color, "%8.1f%%", "retiring",
 				retiring * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_RECOVERY_BUBBLES)) {
-		double bad_spec = td_bad_spec(ctx, cpu);
+		double bad_spec = td_bad_spec(ctx, cpu, st);
 
 		if (bad_spec > 0.1)
 			color = PERF_COLOR_RED;
 		print_metric(ctxp, color, "%8.1f%%", "bad speculation",
 				bad_spec * 100.);
 	} else if (perf_stat_evsel__is(evsel, TOPDOWN_SLOTS_ISSUED)) {
-		double be_bound = td_be_bound(ctx, cpu);
+		double be_bound = td_be_bound(ctx, cpu, st);
 		const char *name = "backend bound";
 		static int have_recovery_bubbles = -1;
 
@@ -938,19 +993,19 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 
 		if (be_bound > 0.2)
 			color = PERF_COLOR_RED;
-		if (td_total_slots(ctx, cpu) > 0)
+		if (td_total_slots(ctx, cpu, st) > 0)
 			print_metric(ctxp, color, "%8.1f%%", name,
 					be_bound * 100.);
 		else
 			print_metric(ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
 		generic_metric(evsel->metric_expr, evsel->metric_events, evsel->name,
-				evsel->metric_name, avg, cpu, out);
-	} else if (runtime_nsecs_stats[cpu].n != 0) {
+				evsel->metric_name, avg, cpu, out, st);
+	} else if (runtime_stat_n(st, STAT_NSECS, 0, cpu) != 0) {
 		char unit = 'M';
 		char unit_buf[10];
 
-		total = avg_stats(&runtime_nsecs_stats[cpu]);
+		total = runtime_stat_avg(st, STAT_NSECS, 0, cpu);
 
 		if (total)
 			ratio = 1000.0 * avg / total;
@@ -961,7 +1016,7 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		snprintf(unit_buf, sizeof(unit_buf), "%c/sec", unit);
 		print_metric(ctxp, NULL, "%8.3f", unit_buf, ratio);
 	} else if (perf_stat_evsel__is(evsel, SMI_NUM)) {
-		print_smi_cost(cpu, evsel, out);
+		print_smi_cost(cpu, evsel, out, st);
 	} else {
 		num = 0;
 	}
@@ -974,7 +1029,7 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				out->new_line(ctxp);
 			generic_metric(mexp->metric_expr, mexp->metric_events,
 					evsel->name, mexp->metric_name,
-					avg, cpu, out);
+					avg, cpu, out, st);
 		}
 	}
 	if (num == 0)
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index bb9902ad3a79..76b322a2d293 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -140,7 +140,8 @@ struct perf_stat_output_ctx {
 void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out,
-				   struct rblist *metric_events);
+				   struct rblist *metric_events,
+				   struct runtime_stat *st);
 void perf_stat__collect_metric_expr(struct perf_evlist *);
 
 int perf_evlist__alloc_stats(struct perf_evlist *evlist, bool alloc_raw);
-- 
2.13.6
