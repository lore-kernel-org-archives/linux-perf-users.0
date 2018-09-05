From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 54/77] perf stat: Pass 'struct perf_stat_config' to first_shadow_cpu()
Date: Wed,  5 Sep 2018 19:04:17 -0300
Message-ID: <20180905220440.20256-55-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Pass a 'struct perf_stat_config' arg to first_shadow_cpu(), so that the
function does not depend on the 'perf stat' command object local
'stat_config' variable and can then be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-30-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e96cef526ef0..f5ac6545af34 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -919,17 +919,18 @@ static void print_metric_header(struct perf_stat_config *config,
 		fprintf(os->fh, "%*s ", config->metric_only_len, unit);
 }
 
-static int first_shadow_cpu(struct perf_evsel *evsel, int id)
+static int first_shadow_cpu(struct perf_stat_config *config,
+			    struct perf_evsel *evsel, int id)
 {
 	int i;
 
 	if (!aggr_get_id)
 		return 0;
 
-	if (stat_config.aggr_mode == AGGR_NONE)
+	if (config->aggr_mode == AGGR_NONE)
 		return id;
 
-	if (stat_config.aggr_mode == AGGR_GLOBAL)
+	if (config->aggr_mode == AGGR_GLOBAL)
 		return 0;
 
 	for (i = 0; i < perf_evsel__nr_cpus(evsel); i++) {
@@ -1090,7 +1091,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 
 	perf_stat__print_shadow_stats(config, counter, uval,
-				first_shadow_cpu(counter, id),
+				first_shadow_cpu(config, counter, id),
 				&out, &metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
@@ -1098,7 +1099,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 	}
 }
 
-static void aggr_update_shadow(void)
+static void aggr_update_shadow(struct perf_stat_config *config)
 {
 	int cpu, s2, id, s;
 	u64 val;
@@ -1115,7 +1116,7 @@ static void aggr_update_shadow(void)
 				val += perf_counts(counter->counts, cpu, 0)->val;
 			}
 			perf_stat__update_shadow_stats(counter, val,
-					first_shadow_cpu(counter, id),
+					first_shadow_cpu(config, counter, id),
 					&rt_stat);
 		}
 	}
@@ -1237,7 +1238,7 @@ static void print_aggr(struct perf_stat_config *config,
 	if (!(aggr_map || aggr_get_id))
 		return;
 
-	aggr_update_shadow();
+	aggr_update_shadow(config);
 
 	/*
 	 * With metric_only everything is on a single line.
-- 
2.14.4
