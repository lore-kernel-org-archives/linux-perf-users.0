From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/41] perf stat: Factor out generic metric printing
Date: Tue, 12 Sep 2017 12:09:52 -0300
Message-ID: <20170912151029.6612-5-acme@kernel.org>
References: <20170912151029.6612-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170912151029.6612-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The 'perf stat' shadow metric printing already supports generic metrics.
Factor out the code doing that into a separate function that can be
re-used in a later patch.

No behavior changes.

v2: Fix indentation

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 69 ++++++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index a04cf56d3517..96aa6cbf24d6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -627,6 +627,46 @@ static void print_smi_cost(int cpu, struct perf_evsel *evsel,
 	out->print_metric(out->ctx, NULL, "%4.0f", "SMI#", smi_num);
 }
 
+static void generic_metric(const char *metric_expr,
+			   struct perf_evsel **metric_events,
+			   char *name,
+			   const char *metric_name,
+			   double avg,
+			   int cpu,
+			   int ctx,
+			   struct perf_stat_output_ctx *out)
+{
+	print_metric_t print_metric = out->print_metric;
+	struct parse_ctx pctx;
+	double ratio;
+	int i;
+	void *ctxp = out->ctx;
+
+	expr__ctx_init(&pctx);
+	expr__add_id(&pctx, name, avg);
+	for (i = 0; metric_events[i]; i++) {
+		struct saved_value *v;
+
+		v = saved_value_lookup(metric_events[i], cpu, ctx, false);
+		if (!v)
+			break;
+		expr__add_id(&pctx, metric_events[i]->name, avg_stats(&v->stats));
+	}
+	if (!metric_events[i]) {
+		const char *p = metric_expr;
+
+		if (expr__parse(&ratio, &pctx, &p) == 0)
+			print_metric(ctxp, NULL, "%8.1f",
+				metric_name ?
+				metric_name :
+				out->force_header ?  name : "",
+				ratio);
+		else
+			print_metric(ctxp, NULL, NULL, "", 0);
+	} else
+		print_metric(ctxp, NULL, NULL, "", 0);
+}
+
 void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				   double avg, int cpu,
 				   struct perf_stat_output_ctx *out)
@@ -819,33 +859,8 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 		else
 			print_metric(ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
-		struct parse_ctx pctx;
-		int i;
-
-		expr__ctx_init(&pctx);
-		expr__add_id(&pctx, evsel->name, avg);
-		for (i = 0; evsel->metric_events[i]; i++) {
-			struct saved_value *v;
-
-			v = saved_value_lookup(evsel->metric_events[i], cpu, ctx, false);
-			if (!v)
-				break;
-			expr__add_id(&pctx, evsel->metric_events[i]->name,
-					     avg_stats(&v->stats));
-		}
-		if (!evsel->metric_events[i]) {
-			const char *p = evsel->metric_expr;
-
-			if (expr__parse(&ratio, &pctx, &p) == 0)
-				print_metric(ctxp, NULL, "%8.1f",
-					evsel->metric_name ?
-					evsel->metric_name :
-					out->force_header ?  evsel->name : "",
-					ratio);
-			else
-				print_metric(ctxp, NULL, NULL, "", 0);
-		} else
-			print_metric(ctxp, NULL, NULL, "", 0);
+		generic_metric(evsel->metric_expr, evsel->metric_events, evsel->name,
+				evsel->metric_name, avg, cpu, ctx, out);
 	} else if (runtime_nsecs_stats[cpu].n != 0) {
 		char unit = 'M';
 		char unit_buf[10];
-- 
2.13.5
