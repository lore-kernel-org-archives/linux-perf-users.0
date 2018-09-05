From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/77] perf stat: Move 'interval_clear' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:09 -0300
Message-ID: <20180905220440.20256-47-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the static 'interval_clear' variable to 'struct perf_stat_config',
so it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 9 ++++-----
 tools/perf/util/stat.h    | 1 +
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4c29e5065e02..89297ab77d21 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -172,7 +172,6 @@ static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
 static bool			interval_count;
-static bool			interval_clear;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -1544,12 +1543,12 @@ static void print_interval(struct perf_stat_config *config,
 	FILE *output = config->output;
 	static int num_print_interval;
 
-	if (interval_clear)
+	if (config->interval_clear)
 		puts(CONSOLE_CLEAR);
 
 	sprintf(prefix, "%6lu.%09lu%s", ts->tv_sec, ts->tv_nsec, config->csv_sep);
 
-	if ((num_print_interval == 0 && !config->csv_output) || interval_clear) {
+	if ((num_print_interval == 0 && !config->csv_output) || config->interval_clear) {
 		switch (config->aggr_mode) {
 		case AGGR_SOCKET:
 			fprintf(output, "#           time socket cpus");
@@ -1581,7 +1580,7 @@ static void print_interval(struct perf_stat_config *config,
 		}
 	}
 
-	if ((num_print_interval == 0 || interval_clear) && metric_only)
+	if ((num_print_interval == 0 || config->interval_clear) && metric_only)
 		print_metric_headers(config, " ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
@@ -1911,7 +1910,7 @@ static const struct option stat_options[] = {
 		    "(overhead is possible for values <= 100ms)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
-	OPT_BOOLEAN(0, "interval-clear", &interval_clear,
+	OPT_BOOLEAN(0, "interval-clear", &stat_config.interval_clear,
 		    "clear screen in between new interval"),
 	OPT_UINTEGER(0, "timeout", &stat_config.timeout,
 		    "stop workload and print counts after a timeout period in ms (>= 10ms)"),
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 18546d8b0279..470ab37601be 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -92,6 +92,7 @@ struct perf_stat_config {
 	bool			 no_inherit;
 	bool			 identifier;
 	bool			 csv_output;
+	bool			 interval_clear;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
-- 
2.14.4
