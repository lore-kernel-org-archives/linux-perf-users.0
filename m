From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/14] perf stat: Fix --interval_clear option
Date: Wed, 11 Jul 2018 16:43:03 -0400
Message-ID: <20180711204305.12924-13-acme@kernel.org>
References: <20180711204305.12924-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180711204305.12924-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Currently we display extra header line, like:

  # perf stat -I 1000 -a --interval-clear
  #           time             counts unit events
         insn per cycle branch-misses of all branches
       2.964917103        3855.349912      cpu-clock (msec)          #    3.855 CPUs utilized
       2.964917103             23,993      context-switches          #    0.006 M/sec
       2.964917103              1,301      cpu-migrations            #    0.329 K/sec
       ...

Fixing the condition and getting proper:

  # perf stat -I 1000 -a --interval-clear
  #           time             counts unit events
       2.359048938        1432.492228      cpu-clock (msec)          #    1.432 CPUs utilized
       2.359048938              7,613      context-switches          #    0.002 M/sec
       2.359048938                419      cpu-migrations            #    0.133 K/sec
       ...

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9660e08ee8cb ("perf stat: Add --interval-clear option")
Link: http://lkml.kernel.org/r/20180702134202.17745-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 22547a490e1f..05be023c3f0e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1742,7 +1742,7 @@ static void print_interval(char *prefix, struct timespec *ts)
 		}
 	}
 
-	if ((num_print_interval == 0 && metric_only) || interval_clear)
+	if ((num_print_interval == 0 || interval_clear) && metric_only)
 		print_metric_headers(" ", true);
 	if (++num_print_interval == 25)
 		num_print_interval = 0;
-- 
2.14.4
