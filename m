From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/77] perf stat: Introduce perf_evlist__print_counters()
Date: Wed,  5 Sep 2018 19:04:03 -0300
Message-ID: <20180905220440.20256-41-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

To be in charge of printing out the stat output. It will be moved out of
the 'perf stat' command in the following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-16-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 54768ec15dbc..db11832bbdbc 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1692,7 +1692,10 @@ static void print_footer(void)
 			"the same PMU. Try reorganizing the group.\n");
 }
 
-static void print_counters(struct timespec *ts, int argc, const char **argv)
+static void
+perf_evlist__print_counters(struct perf_evlist *evlist,
+			    struct timespec *ts,
+			    int argc, const char **argv)
 {
 	int interval = stat_config.interval;
 	struct perf_evsel *counter;
@@ -1724,14 +1727,14 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		print_aggr(prefix);
 		break;
 	case AGGR_THREAD:
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			print_aggr_thread(counter, prefix);
 		}
 		break;
 	case AGGR_GLOBAL:
-		evlist__for_each_entry(evsel_list, counter) {
+		evlist__for_each_entry(evlist, counter) {
 			if (is_duration_time(counter))
 				continue;
 			print_counter_aggr(counter, prefix);
@@ -1743,7 +1746,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 		if (metric_only)
 			print_no_aggr_metric(prefix);
 		else {
-			evlist__for_each_entry(evsel_list, counter) {
+			evlist__for_each_entry(evlist, counter) {
 				if (is_duration_time(counter))
 					continue;
 				print_counter(counter, prefix);
@@ -1761,6 +1764,11 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	fflush(stat_config.output);
 }
 
+static void print_counters(struct timespec *ts, int argc, const char **argv)
+{
+	perf_evlist__print_counters(evsel_list, ts, argc, argv);
+}
+
 static volatile int signr = -1;
 
 static void skip_signal(int signo)
-- 
2.14.4
