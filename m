From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 36/77] perf stat: Add 'struct perf_tool' argument to perf_stat_synthesize_config()
Date: Wed,  5 Sep 2018 19:03:59 -0300
Message-ID: <20180905220440.20256-37-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So that we can use the function outside the 'perf stat' command with standard
synthesize functions, that take 'struct perf_tool *' argument.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-12-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d0d19a5ffa85..ae5029875e87 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -403,12 +403,13 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 }
 
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
+				       struct perf_tool *tool,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(NULL, evsel_list,
+		err = perf_event__synthesize_attrs(tool, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
@@ -416,12 +417,12 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(NULL,
+	err = perf_event__synthesize_extra_attr(tool,
 						evsel_list,
 						process_synthesized_event,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(NULL, evsel_list->threads,
+	err = perf_event__synthesize_thread_map2(tool, evsel_list->threads,
 						process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -429,14 +430,14 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(NULL, evsel_list->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evsel_list->cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(NULL, config,
+	err = perf_event__synthesize_stat_config(tool, config,
 						 process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
@@ -607,7 +608,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, NULL, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4
