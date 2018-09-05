From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 49/77] perf stat: Add 'target' argument to perf_evlist__print_counters()
Date: Wed,  5 Sep 2018 19:04:12 -0300
Message-ID: <20180905220440.20256-50-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add 'struct target' argument to perf_evlist__print_counters(), so the
function does not depend on the 'perf stat' command object local target
and can be moved out.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-25-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 24171aa6c41f..528f85146b59 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1590,6 +1590,7 @@ static void print_interval(struct perf_stat_config *config,
 }
 
 static void print_header(struct perf_stat_config *config,
+			 struct target *_target,
 			 int argc, const char **argv)
 {
 	FILE *output = config->output;
@@ -1600,18 +1601,18 @@ static void print_header(struct perf_stat_config *config,
 	if (!config->csv_output) {
 		fprintf(output, "\n");
 		fprintf(output, " Performance counter stats for ");
-		if (target.system_wide)
+		if (_target->system_wide)
 			fprintf(output, "\'system wide");
-		else if (target.cpu_list)
-			fprintf(output, "\'CPU(s) %s", target.cpu_list);
-		else if (!target__has_task(&target)) {
+		else if (_target->cpu_list)
+			fprintf(output, "\'CPU(s) %s", _target->cpu_list);
+		else if (!target__has_task(_target)) {
 			fprintf(output, "\'%s", argv ? argv[0] : "pipe");
 			for (i = 1; argv && (i < argc); i++)
 				fprintf(output, " %s", argv[i]);
-		} else if (target.pid)
-			fprintf(output, "process id \'%s", target.pid);
+		} else if (_target->pid)
+			fprintf(output, "process id \'%s", _target->pid);
 		else
-			fprintf(output, "thread id \'%s", target.tid);
+			fprintf(output, "thread id \'%s", _target->tid);
 
 		fprintf(output, "\'");
 		if (run_count > 1)
@@ -1716,6 +1717,7 @@ static void print_footer(struct perf_stat_config *config)
 static void
 perf_evlist__print_counters(struct perf_evlist *evlist,
 			    struct perf_stat_config *config,
+			    struct target *_target,
 			    struct timespec *ts,
 			    int argc, const char **argv)
 {
@@ -1727,7 +1729,7 @@ perf_evlist__print_counters(struct perf_evlist *evlist,
 	if (interval)
 		print_interval(config, prefix = buf, ts);
 	else
-		print_header(config, argc, argv);
+		print_header(config, _target, argc, argv);
 
 	if (metric_only) {
 		static int num_print_iv;
@@ -1789,7 +1791,7 @@ static void print_counters(struct timespec *ts, int argc, const char **argv)
 	if (STAT_RECORD && perf_stat.data.is_pipe)
 		return;
 
-	perf_evlist__print_counters(evsel_list, &stat_config,
+	perf_evlist__print_counters(evsel_list, &stat_config, &target,
 				    ts, argc, argv);
 }
 
-- 
2.14.4
