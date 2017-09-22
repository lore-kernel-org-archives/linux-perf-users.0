From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/44] perf stat: Don't use ctx for saved values lookup
Date: Fri, 22 Sep 2017 11:41:45 -0300
Message-ID: <20170922144220.9411-10-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

We don't need to use ctx to look up events for saved values.  The
context is already part of the evsel pointer, which is the primary key.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-9-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 42e6c17be7ff..664f49a9b012 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -56,7 +56,6 @@ struct saved_value {
 	struct rb_node rb_node;
 	struct perf_evsel *evsel;
 	int cpu;
-	int ctx;
 	struct stats stats;
 };
 
@@ -67,8 +66,6 @@ static int saved_value_cmp(struct rb_node *rb_node, const void *entry)
 					     rb_node);
 	const struct saved_value *b = entry;
 
-	if (a->ctx != b->ctx)
-		return a->ctx - b->ctx;
 	if (a->cpu != b->cpu)
 		return a->cpu - b->cpu;
 	if (a->evsel == b->evsel)
@@ -90,13 +87,12 @@ static struct rb_node *saved_value_new(struct rblist *rblist __maybe_unused,
 }
 
 static struct saved_value *saved_value_lookup(struct perf_evsel *evsel,
-					      int cpu, int ctx,
+					      int cpu,
 					      bool create)
 {
 	struct rb_node *nd;
 	struct saved_value dm = {
 		.cpu = cpu,
-		.ctx = ctx,
 		.evsel = evsel,
 	};
 	nd = rblist__find(&runtime_saved_values, &dm);
@@ -232,8 +228,7 @@ void perf_stat__update_shadow_stats(struct perf_evsel *counter, u64 *count,
 		update_stats(&runtime_aperf_stats[ctx][cpu], count[0]);
 
 	if (counter->collect_stat) {
-		struct saved_value *v = saved_value_lookup(counter, cpu, ctx,
-							   true);
+		struct saved_value *v = saved_value_lookup(counter, cpu, true);
 		update_stats(&v->stats, count[0]);
 	}
 }
@@ -634,7 +629,6 @@ static void generic_metric(const char *metric_expr,
 			   const char *metric_name,
 			   double avg,
 			   int cpu,
-			   int ctx,
 			   struct perf_stat_output_ctx *out)
 {
 	print_metric_t print_metric = out->print_metric;
@@ -648,7 +642,7 @@ static void generic_metric(const char *metric_expr,
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
 
-		v = saved_value_lookup(metric_events[i], cpu, ctx, false);
+		v = saved_value_lookup(metric_events[i], cpu, false);
 		if (!v)
 			break;
 		expr__add_id(&pctx, metric_events[i]->name, avg_stats(&v->stats));
@@ -866,7 +860,7 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 			print_metric(ctxp, NULL, NULL, name, 0);
 	} else if (evsel->metric_expr) {
 		generic_metric(evsel->metric_expr, evsel->metric_events, evsel->name,
-				evsel->metric_name, avg, cpu, ctx, out);
+				evsel->metric_name, avg, cpu, out);
 	} else if (runtime_nsecs_stats[cpu].n != 0) {
 		char unit = 'M';
 		char unit_buf[10];
@@ -895,7 +889,7 @@ void perf_stat__print_shadow_stats(struct perf_evsel *evsel,
 				out->new_line(ctxp);
 			generic_metric(mexp->metric_expr, mexp->metric_events,
 					evsel->name, mexp->metric_name,
-					avg, cpu, ctx, out);
+					avg, cpu, out);
 		}
 	}
 	if (num == 0)
-- 
2.13.5
