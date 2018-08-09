From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 02/44] perf trace: Use beautifiers on syscalls:sys_enter_ handlers
Date: Thu,  9 Aug 2018 11:57:40 -0300
Message-ID: <20180809145822.21391-3-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We were using the beautifiers only when processing the
raw_syscalls:sys_enter events, but we can as well use them for the
syscalls:sys_enter_NAME events, as the layout is the same.

Some more tweaking is needed as we're processing them straight away,
i.e. there is no buffering in the sys_enter_NAME event to wait for
things like vfs_getname to provide pointer contents and then flushing
at sys_exit_NAME, so we need to state in the syscall_arg that this
is unbuffered, just print the pointer values, beautifying just
non-pointer syscall args.

This just shows an alternative way of processing tracepoints, that we
will end up using when creating "tracepoint" payloads that already copy
pointer contents (or chunks of it, i.e. not the whole filename, but just
the end of it, not all the bf for a read/write, but just the start,
etc), directly in the kernel using eBPF.

E.g.:

  # perf trace -e syscalls:*enter*sleep,*sleep sleep 1
     0.303 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffc93d5ecc0
     0.305 (1000.229 ms): sleep/8746 nanosleep(rqtp: 0x7ffc93d5ecc0) = 0
  # perf trace -e syscalls:*_*sleep,*sleep sleep 1
     0.288 (         ): syscalls:sys_enter_nanosleep:rqtp: 0x7ffecde87e40
     0.289 (         ): sleep/8748 nanosleep(rqtp: 0x7ffecde87e40) ...
  1000.479 (         ): syscalls:sys_exit_nanosleep:0x0
     0.289 (1000.208 ms): sleep/8748  ... [continued]: nanosleep()) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jehyd2zwhw00z3p7v7mg9632@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 47 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2a85f5198da0..7336552c22cf 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1666,6 +1666,44 @@ static int trace__sys_enter(struct trace *trace, struct perf_evsel *evsel,
 	return err;
 }
 
+static int trace__fprintf_sys_enter(struct trace *trace, struct perf_evsel *evsel,
+				    struct perf_sample *sample)
+{
+	struct format_field *field = perf_evsel__field(evsel, "__syscall_nr");
+	struct thread_trace *ttrace;
+	struct thread *thread;
+	struct syscall *sc;
+	char msg[1024];
+	int id, err = -1;
+	void *args;
+
+	if (field == NULL)
+		return -1;
+
+	id = format_field__intval(field, sample, evsel->needs_swap);
+	sc = trace__syscall_info(trace, evsel, id);
+
+	if (sc == NULL)
+		return -1;
+
+	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	ttrace = thread__trace(thread, trace->output);
+	/*
+	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
+	 * and the rest of the beautifiers accessing it via struct syscall_arg touches it.
+	 */
+	if (ttrace == NULL)
+		goto out_put;
+
+	args = sample->raw_data + field->offset + sizeof(u64); /* skip __syscall_nr, there is where args are */
+	syscall__scnprintf_args(sc, msg, sizeof(msg), args, trace, thread);
+	fprintf(trace->output, "%s", msg);
+	err = 0;
+out_put:
+	thread__put(thread);
+	return err;
+}
+
 static int trace__resolve_callchain(struct trace *trace, struct perf_evsel *evsel,
 				    struct perf_sample *sample,
 				    struct callchain_cursor *cursor)
@@ -1964,9 +2002,12 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (perf_evsel__is_bpf_output(evsel)) {
 		bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
-		event_format__fprintf(evsel->tp_format, sample->cpu,
-				      sample->raw_data, sample->raw_size,
-				      trace->output);
+		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
+		    trace__fprintf_sys_enter(trace, evsel, sample)) {
+			event_format__fprintf(evsel->tp_format, sample->cpu,
+					      sample->raw_data, sample->raw_size,
+					      trace->output);
+		}
 	}
 
 	fprintf(trace->output, "\n");
-- 
2.14.4
