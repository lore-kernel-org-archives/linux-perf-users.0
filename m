From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 35/77] perf stat: Add 'struct perf_stat_config' argument to perf_stat_synthesize_config()
Date: Wed,  5 Sep 2018 19:03:58 -0300
Message-ID: <20180905220440.20256-36-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a 'struct perf_stat_config' argument to perf_stat_synthesize_config(),
so we could synthesize arbitrary config.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-11-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 0a358c2e1a93..d0d19a5ffa85 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,7 +402,8 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(bool attrs)
+static int perf_stat_synthesize_config(struct perf_stat_config *config,
+				       bool attrs)
 {
 	int err;
 
@@ -435,7 +436,7 @@ static int perf_stat_synthesize_config(bool attrs)
 		return err;
 	}
 
-	err = perf_event__synthesize_stat_config(NULL, &stat_config,
+	err = perf_event__synthesize_stat_config(NULL, config,
 						 process_synthesized_event, NULL);
 	if (err < 0) {
 		pr_err("Couldn't synthesize config.\n");
@@ -606,7 +607,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (err < 0)
 			return err;
 
-		err = perf_stat_synthesize_config(is_pipe);
+		err = perf_stat_synthesize_config(&stat_config, is_pipe);
 		if (err < 0)
 			return err;
 	}
-- 
2.14.4
