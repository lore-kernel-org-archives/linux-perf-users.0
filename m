From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 34/77] perf stat: Rename 'is_pipe' argument to 'attrs' in perf_stat_synthesize_config()
Date: Wed,  5 Sep 2018 19:03:57 -0300
Message-ID: <20180905220440.20256-35-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The attrs name makes more sense.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180830063252.23729-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 142cff8eb12b..0a358c2e1a93 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -402,11 +402,11 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static int perf_stat_synthesize_config(bool is_pipe)
+static int perf_stat_synthesize_config(bool attrs)
 {
 	int err;
 
-	if (is_pipe) {
+	if (attrs) {
 		err = perf_event__synthesize_attrs(NULL, evsel_list,
 						   process_synthesized_event);
 		if (err < 0) {
@@ -418,7 +418,7 @@ static int perf_stat_synthesize_config(bool is_pipe)
 	err = perf_event__synthesize_extra_attr(NULL,
 						evsel_list,
 						process_synthesized_event,
-						is_pipe);
+						attrs);
 
 	err = perf_event__synthesize_thread_map2(NULL, evsel_list->threads,
 						process_synthesized_event,
-- 
2.14.4
