From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v3 2/2] perf stat: Add support to print counts after a period of time
Date: Fri, 26 Jan 2018 10:06:57 +0100
Message-ID: <1516957617-23985-3-git-send-email-ufo19890607@gmail.com>
References: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce a new option to print counts after N milliseconds
and update perf-stat documentation accordingly.

Show below is the output of the new option for perf stat.

        $ perf stat --time 2000 -e cycles -a
        Performance counter stats for 'system wide':

                157,260,423      cycles

                2.003060766 seconds time elapsed

We can print the count deltas after N milliseconds with this new
introduced option. This option is not supported with "-I" option.
In addition, according to Kangliang's patch(19afd10410957), the
monitoring overhead for system-wide core event could be very high
if the interval-print parameter was below 100ms, and the limitation
value is 10ms. So the same warning will be displayed when the time
is set between 10ms to 100ms, and the minimal time is limited to
10ms. Users can make a decision according to their spcific cases.

Changes since v2:
- modify the time check in __run_perf_stat func to keep some consistency
  with the workload case.
- add the warning when the time is set between 10ms to 100ms.
- add the pr_err when the time is set below 10ms.

Changes since v1:
- none.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 33 +++++++++++++++++++++++++++++++--
 tools/perf/util/stat.h                 |  1 +
 3 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 47a21645f60c..c822f374c99a 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -151,6 +151,11 @@ Print count deltas for fixed number of times.
 This option should be used together with "-I" option.
 	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
 
+--time msecs::
+Print count deltas after N milliseconds (minimum: 10 ms).
+This option is not supported with "-I" option.
+	example: 'perf stat --time 2000 -e cycles -a'
+
 --metric-only::
 Only print computed metrics. Print them in a single line.
 Don't show any raw values. Not supported with --per-thread.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 406f546ad74c..73c011acf92a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -573,6 +573,7 @@ static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
 	int times = stat_config.times;
+	int time = stat_config.time;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct perf_evsel *counter;
@@ -586,6 +587,9 @@ static int __run_perf_stat(int argc, const char **argv)
 	if (interval) {
 		ts.tv_sec  = interval / USEC_PER_MSEC;
 		ts.tv_nsec = (interval % USEC_PER_MSEC) * NSEC_PER_MSEC;
+	} else if (time) {
+		ts.tv_sec  = time / USEC_PER_MSEC;
+		ts.tv_nsec = (time % USEC_PER_MSEC) * NSEC_PER_MSEC;
 	} else {
 		ts.tv_sec  = 1;
 		ts.tv_nsec = 0;
@@ -698,9 +702,11 @@ static int __run_perf_stat(int argc, const char **argv)
 		perf_evlist__start_workload(evsel_list);
 		enable_counters();
 
-		if (interval) {
+		if (interval || time) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
+				if (time)
+					break;
 				process_interval();
 				if (interval_count == true) {
 					if (--times == 0)
@@ -722,6 +728,8 @@ static int __run_perf_stat(int argc, const char **argv)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
+			if (time)
+				break;
 			if (interval) {
 				process_interval();
 				if (interval_count == true) {
@@ -1904,6 +1912,8 @@ static const struct option stat_options[] = {
 		    "print counts at regular interval in ms (>= 10)"),
 	OPT_INTEGER(0, "interval-count", &stat_config.times,
 		    "print counts for fixed number of times"),
+	OPT_UINTEGER(0, "time", &stat_config.time,
+		    "print counts after a period of time in ms (>= 10)"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
@@ -2701,7 +2711,7 @@ int cmd_stat(int argc, const char **argv)
 	int status = -EINVAL, run_idx;
 	const char *mode;
 	FILE *output = stderr;
-	unsigned int interval;
+	unsigned int interval, time;
 	int times;
 	const char * const stat_subcommands[] = { "record", "report" };
 
@@ -2734,6 +2744,7 @@ int cmd_stat(int argc, const char **argv)
 
 	interval = stat_config.interval;
 	times = stat_config.times;
+	time = stat_config.time;
 
 	/*
 	 * For record command the -o is already taken care of.
@@ -2885,6 +2896,7 @@ int cmd_stat(int argc, const char **argv)
 				   "The overhead percentage could be high in some cases. "
 				   "Please proceed with caution.\n");
 	}
+
 	if (times && interval)
 		interval_count = true;
 	else if (times && !interval) {
@@ -2895,6 +2907,23 @@ int cmd_stat(int argc, const char **argv)
 		goto out;
 	}
 
+	if (time && time < 100) {
+		if (time < 10) {
+			pr_err("time must be >= 10ms.\n");
+			parse_options_usage(stat_usage, stat_options, "time", 0);
+			goto out;
+		} else
+			pr_warning("time < 100ms. "
+				   "The overhead percentage could be high in some cases. "
+				   "Please proceed with caution.\n");
+	}
+	if (time && interval) {
+		pr_err("time option is not supported with interval-print.\n");
+		parse_options_usage(stat_usage, stat_options, "time", 0);
+		parse_options_usage(stat_usage, stat_options, "I", 1);
+		goto out;
+	}
+
 	if (perf_evlist__alloc_stats(evsel_list, interval))
 		goto out;
 
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index b2f8a347d358..6c621951fda8 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,7 @@ struct perf_stat_config {
 	bool		scale;
 	FILE		*output;
 	unsigned int	interval;
+	unsigned int	time;
 	int				times;
 	struct runtime_stat *stats;
 	int		stats_num;
-- 
2.14.1
