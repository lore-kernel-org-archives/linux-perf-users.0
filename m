From: ufo19890607 <ufo19890607@gmail.com>
Subject: [PATCH v3 1/2] perf stat: Add support to print counts for fixed times
Date: Fri, 26 Jan 2018 10:06:56 +0100
Message-ID: <1516957617-23985-2-git-send-email-ufo19890607@gmail.com>
References: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516957617-23985-1-git-send-email-ufo19890607@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, Kan.liang@intel.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com
List-Id: linux-perf-users.vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

Introduce a new option to print counts for fixed number of times
and update perf-stat documentation accordingly.

Show below is the output of the new option for perf stat.

        $ perf stat -I 1000 --interval-count 2 -e cycles -a
        #           time             counts unit events
             1.002827089         93,884,870      cycles
             2.004231506         56,573,446      cycles

We can just print the counts for several times with this newly introduced
option. The usage of it is a little like vmstat, and it should be used
together with "-I" option.

        $ vmstat -n 1 2
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 0  0      0 78270544 547484 51732076    0    0     0    20    1    1  1  0 99  0  0
 0  0      0 78270512 547484 51732080    0    0     0    16  477 1555  0  0 100  0  0

Changes since v2:
- none.

Changes since v1:
- change the name of the new option "times-print" to "interval-count".
- keep the new option interval specifically.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
---
 tools/perf/Documentation/perf-stat.txt |  5 +++++
 tools/perf/builtin-stat.c              | 26 +++++++++++++++++++++++++-
 tools/perf/util/stat.h                 |  1 +
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
index 823fce7674bb..47a21645f60c 100644
--- a/tools/perf/Documentation/perf-stat.txt
+++ b/tools/perf/Documentation/perf-stat.txt
@@ -146,6 +146,11 @@ Print count deltas every N milliseconds (minimum: 10ms)
 The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
 	example: 'perf stat -I 1000 -e cycles -a sleep 5'
 
+--interval-count times::
+Print count deltas for fixed number of times.
+This option should be used together with "-I" option.
+	example: 'perf stat -I 1000 --interval-count 2 -e cycles -a'
+
 --metric-only::
 Only print computed metrics. Print them in a single line.
 Don't show any raw values. Not supported with --per-thread.
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 98bf9d32f222..406f546ad74c 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -168,6 +168,7 @@ static struct timespec		ref_time;
 static struct cpu_map		*aggr_map;
 static aggr_get_id_t		aggr_get_id;
 static bool			append_file;
+static bool			interval_count;
 static const char		*output_name;
 static int			output_fd;
 static int			print_free_counters_hint;
@@ -571,6 +572,7 @@ static struct perf_evsel *perf_evsel__reset_weak_group(struct perf_evsel *evsel)
 static int __run_perf_stat(int argc, const char **argv)
 {
 	int interval = stat_config.interval;
+	int times = stat_config.times;
 	char msg[BUFSIZ];
 	unsigned long long t0, t1;
 	struct perf_evsel *counter;
@@ -700,6 +702,10 @@ static int __run_perf_stat(int argc, const char **argv)
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
 				process_interval();
+				if (interval_count == true) {
+					if (--times == 0)
+						break;
+				}
 			}
 		}
 		waitpid(child_pid, &status, 0);
@@ -716,8 +722,13 @@ static int __run_perf_stat(int argc, const char **argv)
 		enable_counters();
 		while (!done) {
 			nanosleep(&ts, NULL);
-			if (interval)
+			if (interval) {
 				process_interval();
+				if (interval_count == true) {
+					if (--times == 0)
+						break;
+				}
+			}
 		}
 	}
 
@@ -1891,6 +1902,8 @@ static const struct option stat_options[] = {
 			"command to run after to the measured command"),
 	OPT_UINTEGER('I', "interval-print", &stat_config.interval,
 		    "print counts at regular interval in ms (>= 10)"),
+	OPT_INTEGER(0, "interval-count", &stat_config.times,
+		    "print counts for fixed number of times"),
 	OPT_SET_UINT(0, "per-socket", &stat_config.aggr_mode,
 		     "aggregate counts per processor socket", AGGR_SOCKET),
 	OPT_SET_UINT(0, "per-core", &stat_config.aggr_mode,
@@ -2689,6 +2702,7 @@ int cmd_stat(int argc, const char **argv)
 	const char *mode;
 	FILE *output = stderr;
 	unsigned int interval;
+	int times;
 	const char * const stat_subcommands[] = { "record", "report" };
 
 	setlocale(LC_ALL, "");
@@ -2719,6 +2733,7 @@ int cmd_stat(int argc, const char **argv)
 		return __cmd_report(argc, argv);
 
 	interval = stat_config.interval;
+	times = stat_config.times;
 
 	/*
 	 * For record command the -o is already taken care of.
@@ -2870,6 +2885,15 @@ int cmd_stat(int argc, const char **argv)
 				   "The overhead percentage could be high in some cases. "
 				   "Please proceed with caution.\n");
 	}
+	if (times && interval)
+		interval_count = true;
+	else if (times && !interval) {
+		pr_err("interval-count option should be used together with "
+				"interval-print.\n");
+		parse_options_usage(stat_usage, stat_options, "interval-count", 0);
+		parse_options_usage(stat_usage, stat_options, "I", 1);
+		goto out;
+	}
 
 	if (perf_evlist__alloc_stats(evsel_list, interval))
 		goto out;
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index dbc6f7134f61..b2f8a347d358 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -90,6 +90,7 @@ struct perf_stat_config {
 	bool		scale;
 	FILE		*output;
 	unsigned int	interval;
+	int				times;
 	struct runtime_stat *stats;
 	int		stats_num;
 };
-- 
2.14.1
