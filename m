From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 39/43] perf trace: Add --print-sample
Date: Tue, 23 Jan 2018 10:12:47 -0300
Message-ID: <20180123131251.28197-40-acme@kernel.org>
References: <20180123131251.28197-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751738AbeAWNOj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 08:14:39 -0500
In-Reply-To: <20180123131251.28197-1-acme@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To help with debugging, like the interrupted out of order issue that
will be dealt with in the next patch in this series, changing the code
to deal with:

raw_syscalls:sys_enter 411967179.269 Timer 9609/9626 [2]
raw_syscalls:sys_enter 411967179.213 file:// Content 9609/9609 [3]
   328.038 (18446744073709.496 ms): Timer/9626 futex(uaddr: 0x7fc0d4027044, op: WAIT|PRIV, utime: 0x7fc0b0ffdb50     ) ...
 raw_syscalls:sys_exit 411967179.225 file:// Content 9609/9609 [3]
   327.982 ( 0.012 ms): file:// Conten/9609 futex(uaddr: 0x7fc0d4027040, op: WAKE|PRIV, val: 1                    ) = 1

That long duration is the bug.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-fljqiibjn7wet24jd1ed7abc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-trace.txt |  4 ++++
 tools/perf/builtin-trace.c              | 24 ++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 6909cf1e0eea..33a88e984e66 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -163,6 +163,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
         Implies '--call-graph dwarf' when --call-graph not present on the
         command line, on systems where DWARF unwinding was built in.
 
+--print-sample::
+	Print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info for the
+	raw_syscalls:sys_{enter,exit} tracepoints, for debugging.
+
 --proc-map-timeout::
 	When processing pre-existing threads /proc/XXX/mmap, it may take a long time,
 	because the file may be huge. A time out is needed in such cases.
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7dece5e0cdbb..322c2b15e407 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -110,6 +110,7 @@ struct trace {
 	bool			summary;
 	bool			summary_only;
 	bool			show_comm;
+	bool			print_sample;
 	bool			show_tool_stats;
 	bool			trace_syscalls;
 	bool			kernel_syscallchains;
@@ -1578,6 +1579,23 @@ static int trace__printf_interrupted_entry(struct trace *trace, struct perf_samp
 	return printed;
 }
 
+static int trace__fprintf_sample(struct trace *trace, struct perf_evsel *evsel,
+				 struct perf_sample *sample, struct thread *thread)
+{
+	int printed = 0;
+
+	if (trace->print_sample) {
+		double ts = (double)sample->time / NSEC_PER_MSEC;
+
+		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
+				   perf_evsel__name(evsel), ts,
+				   thread__comm_str(thread),
+				   sample->pid, sample->tid, sample->cpu);
+	}
+
+	return printed;
+}
+
 static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 			    union perf_event *event __maybe_unused,
 			    struct perf_sample *sample)
@@ -1598,6 +1616,8 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
+	trace__fprintf_sample(trace, evsel, sample, thread);
+
 	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
 
 	if (ttrace->entry_str == NULL) {
@@ -1688,6 +1708,8 @@ static int trace__sys_exit(struct trace *trace, struct perf_evsel *evsel,
 	if (ttrace == NULL)
 		goto out_put;
 
+	trace__fprintf_sample(trace, evsel, sample, thread);
+
 	if (trace->summary)
 		thread__update_stats(ttrace, id, sample);
 
@@ -3034,6 +3056,8 @@ int cmd_trace(int argc, const char **argv)
 		     "Set the maximum stack depth when parsing the callchain, "
 		     "anything beyond the specified depth will be ignored. "
 		     "Default: kernel.perf_event_max_stack or " __stringify(PERF_MAX_STACK_DEPTH)),
+	OPT_BOOLEAN(0, "print-sample", &trace.print_sample,
+			"print the PERF_RECORD_SAMPLE PERF_SAMPLE_ info, for debugging"),
 	OPT_UINTEGER(0, "proc-map-timeout", &trace.opts.proc_map_timeout,
 			"per thread proc mmap processing timeout in ms"),
 	OPT_UINTEGER('D', "delay", &trace.opts.initial_delay,
-- 
2.14.3
