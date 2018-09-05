From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 52/77] perf stat: Move 'run_count' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:15 -0300
Message-ID: <20180905220440.20256-53-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'run_count' variable to 'struct perf_stat_config', so
that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-28-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 39 ++++++++++++++++++++-------------------
 tools/perf/util/stat.h    |  1 +
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 11741f3a8342..1276596840c9 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -147,7 +147,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 
 #define METRIC_ONLY_LEN 20
 
-static int			run_count			=  1;
 static volatile pid_t		child_pid			= -1;
 static bool			null_run			=  false;
 static int			detailed_run			=  0;
@@ -200,6 +199,7 @@ static struct perf_stat_config stat_config = {
 	.aggr_mode	= AGGR_GLOBAL,
 	.scale		= true,
 	.unit_width	= 4, /* strlen("unit") */
+	.run_count	= 1,
 };
 
 static bool is_duration_time(struct perf_evsel *evsel)
@@ -686,7 +686,7 @@ static void print_noise(struct perf_stat_config *config,
 {
 	struct perf_stat_evsel *ps;
 
-	if (run_count == 1)
+	if (config->run_count == 1)
 		return;
 
 	ps = evsel->stats;
@@ -1620,8 +1620,8 @@ static void print_header(struct perf_stat_config *config,
 			fprintf(output, "thread id \'%s", _target->tid);
 
 		fprintf(output, "\'");
-		if (run_count > 1)
-			fprintf(output, " (%d runs)", run_count);
+		if (config->run_count > 1)
+			fprintf(output, " (%d runs)", config->run_count);
 		fprintf(output, ":\n\n");
 	}
 }
@@ -1634,7 +1634,8 @@ static int get_precision(double num)
 	return lround(ceil(-log10(num)));
 }
 
-static void print_table(FILE *output, int precision, double avg)
+static void print_table(struct perf_stat_config *config,
+			FILE *output, int precision, double avg)
 {
 	char tmp[64];
 	int idx, indent = 0;
@@ -1645,7 +1646,7 @@ static void print_table(FILE *output, int precision, double avg)
 
 	fprintf(output, "%*s# Table of individual measurements:\n", indent, "");
 
-	for (idx = 0; idx < run_count; idx++) {
+	for (idx = 0; idx < config->run_count; idx++) {
 		double run = (double) walltime_run[idx] / NSEC_PER_SEC;
 		int h, n = 1 + abs((int) (100.0 * (run - avg)/run) / 5);
 
@@ -1675,7 +1676,7 @@ static void print_footer(struct perf_stat_config *config)
 	if (!null_run)
 		fprintf(output, "\n");
 
-	if (run_count == 1) {
+	if (config->run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
 
 		if (ru_display) {
@@ -1695,7 +1696,7 @@ static void print_footer(struct perf_stat_config *config)
 		int precision = get_precision(sd) + 2;
 
 		if (walltime_run_table)
-			print_table(output, precision, avg);
+			print_table(config, output, precision, avg);
 
 		fprintf(output, " %17.*f +- %.*f seconds time elapsed",
 			precision, avg, precision, sd);
@@ -1886,7 +1887,7 @@ static const struct option stat_options[] = {
 	OPT_BOOLEAN('c', "scale", &stat_config.scale, "scale/normalize counters"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
-	OPT_INTEGER('r', "repeat", &run_count,
+	OPT_INTEGER('r', "repeat", &stat_config.run_count,
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
@@ -2484,7 +2485,7 @@ static int __cmd_record(int argc, const char **argv)
 	if (output_name)
 		data->file.path = output_name;
 
-	if (run_count != 1 || forever) {
+	if (stat_config.run_count != 1 || forever) {
 		pr_err("Cannot use -r option with perf stat record.\n");
 		return -1;
 	}
@@ -2792,12 +2793,12 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
-	if (stat_config.metric_only && run_count > 1) {
+	if (stat_config.metric_only && stat_config.run_count > 1) {
 		fprintf(stderr, "--metric-only is not supported with -r\n");
 		goto out;
 	}
 
-	if (walltime_run_table && run_count <= 1) {
+	if (walltime_run_table && stat_config.run_count <= 1) {
 		fprintf(stderr, "--table is only supported with -r\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		parse_options_usage(NULL, stat_options, "table", 0);
@@ -2853,20 +2854,20 @@ int cmd_stat(int argc, const char **argv)
 	 * Display user/system times only for single
 	 * run and when there's specified tracee.
 	 */
-	if ((run_count == 1) && target__none(&target))
+	if ((stat_config.run_count == 1) && target__none(&target))
 		ru_display = true;
 
-	if (run_count < 0) {
+	if (stat_config.run_count < 0) {
 		pr_err("Run count must be a positive number\n");
 		parse_options_usage(stat_usage, stat_options, "r", 1);
 		goto out;
-	} else if (run_count == 0) {
+	} else if (stat_config.run_count == 0) {
 		forever = true;
-		run_count = 1;
+		stat_config.run_count = 1;
 	}
 
 	if (walltime_run_table) {
-		walltime_run = zalloc(run_count * sizeof(walltime_run[0]));
+		walltime_run = zalloc(stat_config.run_count * sizeof(walltime_run[0]));
 		if (!walltime_run) {
 			pr_err("failed to setup -r option");
 			goto out;
@@ -2994,8 +2995,8 @@ int cmd_stat(int argc, const char **argv)
 	signal(SIGABRT, skip_signal);
 
 	status = 0;
-	for (run_idx = 0; forever || run_idx < run_count; run_idx++) {
-		if (run_count != 1 && verbose > 0)
+	for (run_idx = 0; forever || run_idx < stat_config.run_count; run_idx++) {
+		if (stat_config.run_count != 1 && verbose > 0)
 			fprintf(output, "[ perf stat: executing run #%d ... ]\n",
 				run_idx + 1);
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 2dc66e0ba4b8..351a36f5f5b0 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -100,6 +100,7 @@ struct perf_stat_config {
 	unsigned int		 initial_delay;
 	unsigned int		 unit_width;
 	int			 times;
+	int			 run_count;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.14.4
