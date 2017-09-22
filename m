From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/44] perf stat: Support duration_time for metrics
Date: Fri, 22 Sep 2017 11:41:46 -0300
Message-ID: <20170922144220.9411-11-acme@kernel.org>
References: <20170922144220.9411-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170922144220.9411-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

Some of the metrics formulas (like GFLOPs) need to know how long the
measurement period is. Support an internal event called duration_time,
which reports time in second. It maps to the dummy event, but is special
cased for statistics to report the walltime duration.

So far it is not printed, but only used internally for metrics.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20170831194036.30146-10-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/parse-events.l |  1 +
 tools/perf/util/stat-shadow.c  | 17 +++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
index fdb5bb52f01f..ea2426daf7e8 100644
--- a/tools/perf/util/parse-events.l
+++ b/tools/perf/util/parse-events.l
@@ -288,6 +288,7 @@ cpu-migrations|migrations			{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COU
 alignment-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_ALIGNMENT_FAULTS); }
 emulation-faults				{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_EMULATION_FAULTS); }
 dummy						{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
+duration_time					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_DUMMY); }
 bpf-output					{ return sym(yyscanner, PERF_TYPE_SOFTWARE, PERF_COUNT_SW_BPF_OUTPUT); }
 
 	/*
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 664f49a9b012..a2c12d1ef32a 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -641,11 +641,20 @@ static void generic_metric(const char *metric_expr,
 	expr__add_id(&pctx, name, avg);
 	for (i = 0; metric_events[i]; i++) {
 		struct saved_value *v;
+		struct stats *stats;
+		double scale;
 
-		v = saved_value_lookup(metric_events[i], cpu, false);
-		if (!v)
-			break;
-		expr__add_id(&pctx, metric_events[i]->name, avg_stats(&v->stats));
+		if (!strcmp(metric_events[i]->name, "duration_time")) {
+			stats = &walltime_nsecs_stats;
+			scale = 1e-9;
+		} else {
+			v = saved_value_lookup(metric_events[i], cpu, false);
+			if (!v)
+				break;
+			stats = &v->stats;
+			scale = 1.0;
+		}
+		expr__add_id(&pctx, metric_events[i]->name, avg_stats(stats)*scale);
 	}
 	if (!metric_events[i]) {
 		const char *p = metric_expr;
-- 
2.13.5
