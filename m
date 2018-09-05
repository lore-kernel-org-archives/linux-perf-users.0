From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 58/77] perf stat: Move 'print_free_counters_hint' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:21 -0300
Message-ID: <20180905220440.20256-59-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'print_free_counters_hint' variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-34-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 844c755564e3..8748bb5e5403 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_free_counters_hint;
 static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
@@ -1051,7 +1050,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			config->csv_sep);
 
 		if (counter->supported) {
-			print_free_counters_hint = 1;
+			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
 				print_mixed_hw_group_error = 1;
 		}
@@ -1707,7 +1706,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (print_free_counters_hint &&
+	if (config->print_free_counters_hint &&
 	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
 	    n > 0)
 		fprintf(output,
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index c198926c0e27..8cad17363e90 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -103,6 +103,7 @@ struct perf_stat_config {
 	unsigned int		 metric_only_len;
 	int			 times;
 	int			 run_count;
+	int			 print_free_counters_hint;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.14.4
