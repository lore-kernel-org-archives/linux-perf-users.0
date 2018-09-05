From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 74/77] perf trace: Setup augmented_args in the raw_syscalls:sys_enter handler
Date: Wed,  5 Sep 2018 19:04:37 -0300
Message-ID: <20180905220440.20256-75-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Without using something to augment the raw_syscalls:sys_enter tracepoint
payload with the pointer contents, this will work just like before, i.e.
the augmented_args arg will be NULL and the augmented_args_size will be
0.

This just paves the way for the next cset where we will associate the
trace__sys_enter tracepoint handler with the augmented "bpf-output"
event named "__augmented_args__".

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-p8uvt2a6ug3uwlhja3cno4la@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 12356deb6046..2b99a02355cf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1697,6 +1697,8 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	size_t printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	int augmented_args_size = 0;
+	void *augmented_args = NULL;
 	struct syscall *sc = trace__syscall_info(trace, evsel, id);
 	struct thread_trace *ttrace;
 
@@ -1720,13 +1722,24 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 
 	if (!(trace->duration_filter || trace->summary_only || trace->min_stack))
 		trace__printf_interrupted_entry(trace);
-
+	/*
+	 * If this is raw_syscalls.sys_enter, then it always comes with the 6 possible
+	 * arguments, even if the syscall being handled, say "openat", uses only 4 arguments
+	 * this breaks syscall__augmented_args() check for augmented args, as we calculate
+	 * syscall->args_size using each syscalls:sys_enter_NAME tracefs format file,
+	 * so when handling, say the openat syscall, we end up getting 6 args for the
+	 * raw_syscalls:sys_enter event, when we expected just 4, we end up mistakenly
+	 * thinking that the extra 2 u64 args are the augmented filename, so just check
+	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
+	 */
+	if (evsel != trace->syscalls.events.sys_enter)
+		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size);
 	ttrace->entry_time = sample->time;
 	msg = ttrace->entry_str;
 	printed += scnprintf(msg + printed, trace__entry_str_size - printed, "%s(", sc->name);
 
 	printed += syscall__scnprintf_args(sc, msg + printed, trace__entry_str_size - printed,
-					   args, NULL, 0, trace, thread);
+					   args, augmented_args, augmented_args_size, trace, thread);
 
 	if (sc->is_exit) {
 		if (!(trace->duration_filter || trace->summary_only || trace->failure_only || trace->min_stack)) {
-- 
2.14.4
