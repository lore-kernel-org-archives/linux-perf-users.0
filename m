From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 37/77] perf stat: Add 'struct perf_evlist' argument to perf_stat_synthesize_config()
Date: Wed,  5 Sep 2018 19:04:00 -0300
Message-ID: <20180905220440.20256-38-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Get rid of the 'evsel_list' global variable dependency, here in
perf_stat_synthesize_config() we are adding the 'evlist' arg.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-13-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index ae5029875e87..cb36344c25b7 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -404,12 +404,13 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 
 static int perf_stat_synthesize_config(struct perf_stat_config *config,
 				       struct perf_tool *tool,
+				       struct perf_evlist *evlist,
 				       bool attrs)
 {
 	int err;
 
 	if (attrs) {
-		err = perf_event__synthesize_attrs(tool, evsel_list,
+		err = perf_event__synthesize_attrs(tool, evlist,
 						   process_synthesized_event);
 		if (err < 0) {
 			pr_err("Couldn't synthesize attrs.\n");
@@ -417,12 +418,11 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		}
 	}
 
-	err = perf_event__synthesize_extra_attr(tool,
-						evsel_list,
+	err = perf_event__synthesize_extra_attr(tool, evlist,
 						process_synthesized_event,
 						attrs);
 
-	err = perf_event__synthesize_thread_map2(tool, evsel_list->threads,
+	err = perf_event__synthesize_thread_map2(tool, evlist->threads,
 						process_synthesized_event,
 						NULL);
 	if (err < 0) {
@@ -430,7 +430,7 @@ static int perf_stat_synthesize_config(struct perf_stat_config *config,
 		return err;
 	}
 
-	err = perf_event__synthesize_cpu_map(tool, evsel_list->cpus,
+	err = perf_event__synthesize_cpu_map(tool, evlist->cpus,
 					     process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize thread map.\n");
@@ -608,7 +608,8 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(&stat_config, NULL, is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, NULL, evsel_list,
+						  is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4
