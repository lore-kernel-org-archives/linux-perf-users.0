From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 67/77] perf stat: Move 'metric_events' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:30 -0300
Message-ID: <20180905220440.20256-68-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variable 'metric_events' to 'struct perf_stat_config',
so that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-43-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 10 ++++------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8a4979748cbb..f4ddedc8619b 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -137,8 +137,6 @@ static const char *smi_cost_attrs = {
 
 static struct perf_evlist	*evsel_list;
 
-static struct rblist		 metric_events;
-
 static struct target target = {
 	.uid	= UINT_MAX,
 };
@@ -1082,7 +1080,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 
 	perf_stat__print_shadow_stats(config, counter, uval,
 				first_shadow_cpu(config, counter, id),
-				&out, &metric_events, st);
+				&out, &config->metric_events, st);
 	if (!config->csv_output && !config->metric_only) {
 		print_noise(config, counter, noise);
 		print_running(config, run, ena);
@@ -1533,7 +1531,7 @@ static void print_metric_headers(struct perf_stat_config *config,
 		perf_stat__print_shadow_stats(config, counter, 0,
 					      0,
 					      &out,
-					      &metric_events,
+					      &config->metric_events,
 					      &rt_stat);
 	}
 	fputc('\n', config->output);
@@ -1860,7 +1858,7 @@ static int parse_metric_groups(const struct option *opt,
 			       const char *str,
 			       int unset __maybe_unused)
 {
-	return metricgroup__parse_groups(opt, str, &metric_events);
+	return metricgroup__parse_groups(opt, str, &stat_config.metric_events);
 }
 
 static const struct option stat_options[] = {
@@ -2321,7 +2319,7 @@ static int add_default_attributes(void)
 			struct option opt = { .value = &evsel_list };
 
 			return metricgroup__parse_groups(&opt, "transaction",
-							 &metric_events);
+							 &stat_config.metric_events);
 		}
 
 		if (pmu_have_event("cpu", "cycles-ct") &&
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 5193cbf6e4c6..8d3354e21e19 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -125,6 +125,7 @@ struct perf_stat_config {
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_map		*cpus_aggr_map;
 	u64			*walltime_run;
+	struct rblist		 metric_events;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4
