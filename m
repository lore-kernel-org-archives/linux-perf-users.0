From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 38/77] perf stat: Add 'perf_event__handler_t' argument to perf_stat_synthesize_config()
Date: Wed,  5 Sep 2018 19:04:01 -0300
Message-ID: <20180905220440.20256-39-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that it's completely independent and can be used outside the 'perf stat' command.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-14-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index cb36344c25b7..1171d4e00276 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -405,40 +405,37 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
 				       struct perf_tool *tool,
 				       struct perf_evlist *evlist,
+				       perf_event__handler_t process,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evlist,
-						   process_synthesized_event);
+		err = perf_event__synthesize_attrs(tool, evlist, process);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
 			return err;
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(tool, evlist,
-						process_synthesized_event,
+	err = perf_event__synthesize_extra_attr(tool, evlist, process,
 						attrs);
 
 	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
-						process_synthesized_event,
-						NULL);
+						 process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
 	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
-					     process_synthesized_event, NULL);
+					     process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(tool, config,
-						 process_synthesized_event, NULL);
+	err = perf_event__synthesize_stat_config(tool, config, process, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
 		return err;
@@ -609,7 +606,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 			return err;
 
 		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
-						  is_pipe);
+						  process_synthesized_event, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4
