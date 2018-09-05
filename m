From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 56/77] perf stat: Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:19 -0300
Message-ID: <20180905220440.20256-57-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'walltime_nsecs_stats' pointer to 'struct perf_stat_config', so that
it can be passed around and used outside the 'perf stat' command.

It's initialized to point to stat's walltime_nsecs_stats value.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-32-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 15 ++++++++-------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 2711d8f6e4b8..381549a989b4 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -195,11 +195,12 @@ static struct perf_stat		perf_stat;
 static volatile int done = 0;
 
 static struct perf_stat_config stat_config = {
-	.aggr_mode	= AGGR_GLOBAL,
-	.scale		= true,
-	.unit_width	= 4, /* strlen("unit") */
-	.run_count	= 1,
-	.metric_only_len = METRIC_ONLY_LEN,
+	.aggr_mode		= AGGR_GLOBAL,
+	.scale			= true,
+	.unit_width		= 4, /* strlen("unit") */
+	.run_count		= 1,
+	.metric_only_len	= METRIC_ONLY_LEN,
+	.walltime_nsecs_stats	= &walltime_nsecs_stats,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -1671,7 +1672,7 @@ static double timeval2double(struct timeval *t)
 
 static void print_footer(struct perf_stat_config *config)
 {
-	double avg = avg_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
 	int n;
 
@@ -1690,7 +1691,7 @@ static void print_footer(struct perf_stat_config *config)
 			fprintf(output, " %17.9f seconds sys\n", ru_stime);
 		}
 	} else {
-		double sd = stddev_stats(&walltime_nsecs_stats) / NSEC_PER_SEC;
+		double sd = stddev_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 		/*
 		 * Display at most 2 more significant
 		 * digits than the stddev inaccuracy.
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index e70e6d93ee1b..35550e3efd81 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -105,6 +105,7 @@ struct perf_stat_config {
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
+	struct stats		*walltime_nsecs_stats;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4
