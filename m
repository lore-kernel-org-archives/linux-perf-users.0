From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 60/77] perf stat: Move ru_* data to 'struct perf_stat_config'
Date: Wed,  5 Sep 2018 19:04:23 -0300
Message-ID: <20180905220440.20256-61-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Move the 'ru_*' global variables to 'struct perf_stat_config', so that
it can be passed around and used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-36-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 12 +++++-------
 tools/perf/util/stat.h    |  6 ++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index f61c2dc8c7e8..942ebfd8ef2e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -171,8 +171,6 @@ static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static u64			*walltime_run;
-static bool			ru_display			= false;
-static struct rusage		ru_data;
 
 struct perf_stat {
 	bool			 record;
@@ -583,7 +581,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 					break;
 			}
 		}
-		wait4(child_pid, &status, 0, &ru_data);
+		wait4(child_pid, &status, 0, &stat_config.ru_data);
 
 		if (workload_exec_errno) {
 			const char *emsg = str_error_r(workload_exec_errno, msg, sizeof(msg));
@@ -1679,9 +1677,9 @@ static void print_footer(struct perf_stat_config *config)
 	if (config->run_count == 1) {
 		fprintf(output, " %17.9f seconds time elapsed", avg);
 
-		if (ru_display) {
-			double ru_utime = timeval2double(&ru_data.ru_utime);
-			double ru_stime = timeval2double(&ru_data.ru_stime);
+		if (config->ru_display) {
+			double ru_utime = timeval2double(&config->ru_data.ru_utime);
+			double ru_stime = timeval2double(&config->ru_data.ru_stime);
 
 			fprintf(output, "\n\n");
 			fprintf(output, " %17.9f seconds user\n", ru_utime);
@@ -2855,7 +2853,7 @@ int cmd_stat(int argc, const char **argv)
 	 * run and when there's specified tracee.
 	 */
 	if ((stat_config.run_count == 1) && target__none(&target))
-		ru_display = true;
+		stat_config.ru_display = true;
 
 	if (stat_config.run_count < 0) {
 		pr_err("Run count must be a positive number\n");
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 6fb4dac26ccc..1fd0b7e196c6 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -4,6 +4,10 @@
 
 #include <linux/types.h>
 #include <stdio.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/resource.h>
+#include <sys/wait.h>
 #include "xyarray.h"
 #include "rblist.h"
 #include "perf.h"
@@ -95,6 +99,7 @@ struct perf_stat_config {
 	bool			 interval_clear;
 	bool			 metric_only;
 	bool			 null_run;
+	bool			 ru_display;
 	FILE			*output;
 	unsigned int		 interval;
 	unsigned int		 timeout;
@@ -109,6 +114,7 @@ struct perf_stat_config {
 	int			 stats_num;
 	const char		*csv_sep;
 	struct stats		*walltime_nsecs_stats;
+	struct rusage		 ru_data;
 };
 
 void update_stats(struct stats *stats, u64 val);
-- 
2.14.4
