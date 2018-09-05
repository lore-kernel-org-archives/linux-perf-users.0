From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 59/77] perf stat: Move 'print_mixed_hw_group_error' to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:22 -0300
Message-ID: <20180905220440.20256-60-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'print_mixed_hw_group_error' global variable to 'struct perf_stat_config',
so that it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-35-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 5 ++---
 tools/perf/util/stat.h    | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 8748bb5e5403..f61c2dc8c7e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -170,7 +170,6 @@ static bool			append_file;
 static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
-static int			print_mixed_hw_group_error;
 static u64			*walltime_run;
 static bool			ru_display			= false;
 static struct rusage		ru_data;
@@ -1052,7 +1051,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 		if (counter->supported) {
 			config->print_free_counters_hint = 1;
 			if (is_mixed_hw_group(counter))
-				print_mixed_hw_group_error = 1;
+				config->print_mixed_hw_group_error = 1;
 		}
 
 		fprintf(config->output, "%-*s%s",
@@ -1715,7 +1714,7 @@ static void print_footer(struct perf_stat_config *config)
 "	perf stat ...\n"
 "	echo 1 > /proc/sys/kernel/nmi_watchdog\n");
 
-	if (print_mixed_hw_group_error)
+	if (config->print_mixed_hw_group_error)
 		fprintf(output,
 			"The events in group usually have to be from "
 			"the same PMU. Try reorganizing the group.\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 8cad17363e90..6fb4dac26ccc 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -104,6 +104,7 @@ struct perf_stat_config {
 	int			 times;
 	int			 run_count;
 	int			 print_free_counters_hint;
+	int			 print_mixed_hw_group_error;
 	struct runtime_stat	*stats;
 	int			 stats_num;
 	const char		*csv_sep;
-- 
2.14.4
