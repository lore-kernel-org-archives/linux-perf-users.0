From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 66/77] perf stat: Move 'walltime_*' data to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:29 -0300
Message-ID: <20180905220440.20256-67-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static variables 'walltime_*' to 'struct perf_stat_config', so
that it can be passed around and used outside 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-42-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 22 ++++++++++------------
 tools/perf/util/stat.h    |  2 ++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 486b0cf7818d..8a4979748cbb 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -158,13 +158,11 @@ static const char		*post_cmd			= NULL;
 static bool			sync_run			= false;
 static bool			forever				= false;
 static bool			force_metric_only		= false;
-static bool			walltime_run_table		= false;
 static struct timespec		ref_time;
 static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static u64			*walltime_run;
 
 struct perf_stat {
 	bool			 record;
@@ -604,8 +602,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 
 	t1 = rdclock();
 
-	if (walltime_run_table)
-		walltime_run[run_idx] = t1 - t0;
+	if (stat_config.walltime_run_table)
+		stat_config.walltime_run[run_idx] = t1 - t0;
 
 	update_stats(&walltime_nsecs_stats, t1 - t0);
 
@@ -1646,7 +1644,7 @@ static void print_table(struct perf_stat_config *config,
 	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
 
 	for (idx = 0; idx < config->run_count; idx++) {
-		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
+		double run = (double) config->walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
 		fprintf(output, " %17.*f (%+.*f) ",
@@ -1694,7 +1692,7 @@ static void print_footer(struct perf_stat_config *config)
 		 */
 		int precision = get_precision(sd) + 2;
 
-		if (walltime_run_table)
+		if (config->walltime_run_table)
 			print_table(config, output, precision, avg);
 
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
@@ -1888,7 +1886,7 @@ static const struct option stat_options[] = {
 		    "be more verbose (show counter open errors, etc)"),
 	OPT_INTEGER('r', "repeat", &stat_config.run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
-	OPT_BOOLEAN(0, "table", &walltime_run_table,
+	OPT_BOOLEAN(0, "table", &stat_config.walltime_run_table,
 		    "display details about each run (only with -r option)"),
 	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
@@ -2802,7 +2800,7 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (walltime_run_table && stat_config.run_count <= 1) {
+	if (stat_config.walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		parse_options_usage(NULL, stat_options, "table", 0);
@@ -2870,9 +2868,9 @@ int cmd_stat(int argc, const char **argv)
 		stat_config.run_count = 1;
 	}
 
-	if (walltime_run_table) {
-		walltime_run = zalloc(stat_config.run_count * sizeof(walltime_run[0]));
-		if (!walltime_run) {
+	if (stat_config.walltime_run_table) {
+		stat_config.walltime_run = zalloc(stat_config.run_count * sizeof(stat_config.walltime_run[0]));
+		if (!stat_config.walltime_run) {
 			pr_err("failed to setup -r option");
 			goto out;
 		}
@@ -3052,7 +3050,7 @@ int cmd_stat(int argc, const char **argv)
 	perf_stat__exit_aggr_mode();
 	perf_evlist__free_stats(evsel_list);
 out:
-	free(walltime_run);
+	free(stat_config.walltime_run);
 
 	if (smi_cost && smi_reset)
 		sysfs__write_int(FREEZE_ON_SMI_PATH, 0);
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 0758107fe56f..5193cbf6e4c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -105,6 +105,7 @@ struct perf_stat_config {
 	bool			 ru_display;
 	bool			 big_num;
 	bool			 no_merge;
+	bool			 walltime_run_table;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -123,6 +124,7 @@ struct perf_stat_config {
 	struct cpu_map		*aggr_map;
 	aggr_get_id_t		 aggr_get_id;
 	struct cpu_map		*cpus_aggr_map;
+	u64			*walltime_run;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4
