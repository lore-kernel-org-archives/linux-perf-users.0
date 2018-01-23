From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/43] perf trace: Do not print from time delta for interrupted syscall lines
Date: Tue, 23 Jan 2018 10:12:48 -0300
Message-ID: <20180123131251.28197-41-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were calculating the delta from a in-flight syscall that got its
output interrupted by another syscall, which doesn't seem like useful
information, we will print the syscall duration (sys_exit - sys_enter)
when the raw_syscalls:sys_exit event happens.

The problem here is how we're consuming the multiple ring buffers,
without using the ordered_events code used by perf_session, which may
cause some reordering of syscalls for diferent CPUs, so just stop
printing that delta, to avoid things like:

  # trace --print-sample -p 9626 -e futex
  raw_syscalls:sys_enter 411967179.269 Timer 9609/9626 [2]
  raw_syscalls:sys_enter 411967179.213 file:// Content 9609/9609 [3]
     328.038 (18446744073709.496 ms): Timer/9626 futex(uaddr: 0x7fc0d4027044, op: WAIT|PRIV, utime: 0x7fc0b0ffdb50     ) ...
   raw_syscalls:sys_exit 411967179.225 file:// Content 9609/9609 [3]
     327.982 ( 0.012 ms): file:// Conten/9609 futex(uaddr: 0x7fc0d4027040, op: WAKE|PRIV, val: 1                    ) = 1

This is a bandaid, we should better try and use the ordered_events code,
possibly with some refactoring prep work, but for now at least we don't
show those false long deltas for the lines ending in '...'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-q6xgsqrju1sr6ltud9kjjhmb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 322c2b15e407..ab00096328e4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -821,7 +821,7 @@ static size_t fprintf_duration(unsigned long t, bool calculated, FILE *fp)
 	size_t printed = fprintf(fp, "(");
 
 	if (!calculated)
-		printed += fprintf(fp, "     ?   ");
+		printed += fprintf(fp, "         ");
 	else if (duration >= 1.0)
 		printed += color_fprintf(fp, PERF_COLOR_RED, "%6.3f ms", duration);
 	else if (duration >= 0.01)
@@ -1556,10 +1556,9 @@ static void thread__update_stats(struct thread_trace *ttrace,
 	update_stats(stats, duration);
 }
 
-static int trace__printf_interrupted_entry(struct trace *trace, struct perf_sample *sample)
+static int trace__printf_interrupted_entry(struct trace *trace)
 {
 	struct thread_trace *ttrace;
-	u64 duration;
 	size_t printed;
 
 	if (trace->current == NULL)
@@ -1570,9 +1569,7 @@ static int trace__printf_interrupted_entry(struct trace *trace, struct perf_samp
 	if (!ttrace->entry_pending)
 		return 0;
 
-	duration = sample->time - ttrace->entry_time;
-
-	printed  = trace__fprintf_entry_head(trace, trace->current, duration, true, ttrace->entry_time, trace->output);
+	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
 	printed += fprintf(trace->output, "%-70s) ...\n", ttrace->entry_str);
 	ttrace->entry_pending = false;
 
@@ -1627,7 +1624,7 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	}
 
 	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
-		trace__printf_interrupted_entry(trace, sample);
+		trace__printf_interrupted_entry(trace);
 
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
@@ -1941,7 +1938,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		}
 	}
 
-	trace__printf_interrupted_entry(trace, sample);
+	trace__printf_interrupted_entry(trace);
 	trace__fprintf_tstamp(trace, sample->time, trace->output);
 
 	if (trace->trace_syscalls)
-- 
2.14.3
