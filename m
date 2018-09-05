From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 57/77] perf stat: Move 'null_run' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:20 -0300
Message-ID: <20180905220440.20256-58-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'null_run' variable to 'struct perf_stat_config', so
that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-33-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 +++----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 381549a989b4..844c755564e3 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -148,7 +148,6 @@ typedef int (*aggr_get_id_t)(struct cpu_map *m, int cpu);
 #define METRIC_ONLY_LEN 20
 
 static volatile pid_t		child_pid			= -1;
-static bool			null_run			=  false;
 static int			detailed_run			=  0;
 static bool			transaction_run;
 static bool			topdown_run			= false;
@@ -1676,7 +1675,7 @@ static void print_footer(struct perf_stat_config *config)
 	FILE *output = config->output;
 	int n;
 
-	if (!null_run)
+	if (!config->null_run)
 		fprintf(output, "\n");
 
 	if (config->run_count == 1) {
@@ -1894,7 +1893,7 @@ static const struct option stat_options[] = {
 		    "repeat command and print average + stddev (max: 100, forever: 0)"),
 	OPT_BOOLEAN(0, "table", &walltime_run_table,
 		    "display details about each run (only with -r option)"),
-	OPT_BOOLEAN('n', "null", &null_run,
+	OPT_BOOLEAN('n', "null", &stat_config.null_run,
 		    "null run - dont start any counters"),
 	OPT_INCR('d', "detailed", &detailed_run,
 		    "detailed run - start a lot of events"),
@@ -2309,7 +2308,7 @@ static int add_default_attributes(void)
 	struct parse_events_error errinfo;
 
 	/* Set attrs if no event is selected and !null_run: */
-	if (null_run)
+	if (stat_config.null_run)
 		return 0;
 
 	if (transaction_run) {
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 35550e3efd81..c198926c0e27 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -94,6 +94,7 @@ struct perf_stat_config {
 	bool			 csv_output;
 	bool			 interval_clear;
 	bool			 metric_only;
+	bool			 null_run;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
