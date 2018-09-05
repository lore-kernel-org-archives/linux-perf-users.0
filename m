From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/77] perf stat: Add 'struct perf_stat_config' argument to perf_evlist__print_counters()
Date: Wed,  5 Sep 2018 19:04:05 -0300
Message-ID: <20180905220440.20256-43-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a 'struct perf_stat_config' argument to perf_evlist__print_counters(),
so that it can be moved out of the 'perf stat' command to generic object
in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 4ffbb6594eb6..f340641fe63a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1694,10 +1694,11 @@ static void print_footer(void)
 
 static void
 perf_evlist__print_counters(struct perf_evlist *evlist,
+			    struct perf_stat_config *config,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
-	int interval = stat_config.interval;
+	int interval = config->interval;
 	struct perf_evsel *counter;
 	char buf[64], *prefix = NULL;
 
@@ -1713,11 +1714,11 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_metric_headers(prefix, false);
 		if (num_print_iv++ == 25)
 			num_print_iv = 0;
-		if (stat_config.aggr_mode == AGGR_GLOBAL && prefix)
-			fprintf(stat_config.output, "%s", prefix);
+		if (config->aggr_mode == AGGR_GLOBAL && prefix)
+			fprintf(config->output, "%s", prefix);
 	}
 
-	switch (stat_config.aggr_mode) {
+	switch (config->aggr_mode) {
 	case AGGR_CORE:
 	case AGGR_SOCKET:
 		print_aggr(prefix);
@@ -1736,7 +1737,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 			print_counter_aggr(counter, prefix);
 		}
 		if (metric_only)
-			fputc('\n', stat_config.output);
+			fputc('\n', config->output);
 		break;
 	case AGGR_NONE:
 		if (metric_only)
@@ -1757,7 +1758,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	if (!interval && !csv_output)
 		print_footer();
 
-	fflush(stat_config.output);
+	fflush(config->output);
 }
 
 static void print_counters(struct timespec *ts, int argc, const char **argv)
@@ -1766,7 +1767,8 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
 
-	perf_evlist__print_counters(evsel_list, ts, argc, argv);
+	perf_evlist__print_counters(evsel_list, &stat_config,
+				    ts, argc, argv);
 }
 
 static volatile int signr = -1;
-- 
2.14.4
