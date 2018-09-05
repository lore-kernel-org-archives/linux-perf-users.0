From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 03/77] perf trace: Print the syscall name for augmented_syscalls
Date: Wed,  5 Sep 2018 19:03:26 -0300
Message-ID: <20180905220440.20256-4-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since we copy all the payload for raw_syscalls:sys_enter plus add
expanded pointers, we can use the syscall id to get its name, etc:

  # grep 'field:.* id' /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/format
	field:long id;	offset:8;	size:8;	signed:1;
  #

Before:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xec9f9da8, flags: CLOEXEC
     0.006 ( 0.006 ms): cat/2395 openat(dfd: CWD, filename: 0xec9f9da8, flags: CLOEXEC) = 3
     0.041 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xecc01ce0, flags: CLOEXEC
     0.042 ( 0.007 ms): cat/2395 openat(dfd: CWD, filename: 0xecc01ce0, flags: CLOEXEC) = 3
     0.376 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xac0a806b
     0.379 ( 0.006 ms): cat/2395 openat(dfd: CWD, filename: 0xac0a806b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC)
     0.009 ( 0.009 ms): cat/3619 openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC) = 3
     0.051 (         ): openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC)
     0.054 ( 0.010 ms): cat/3619 openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC) = 3
     0.539 (         ): openat(dfd: CWD, filename: 0xca71506b)
     0.543 ( 0.115 ms): cat/3619 openat(dfd: CWD, filename: 0xca71506b) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-epz6y9i0eavmerc5ha98t7gn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7deae6c8cb25..bcf882afd6d0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2055,13 +2055,33 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (trace->trace_syscalls)
 		fprintf(trace->output, "(         ): ");
 
+	if (evsel == trace->syscalls.events.augmented) {
+		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		struct syscall *sc = trace__syscall_info(trace, evsel, id);
+
+		if (sc) {
+			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+
+			if (thread) {
+				fprintf(trace->output, "%s(", sc->name);
+				trace__fprintf_sys_enter(trace, evsel, sample);
+				fputc(')', trace->output);
+				thread__put(thread);
+				goto newline;
+			}
+		}
+
+		/*
+		 * XXX: Not having the associated syscall info or not finding/adding
+		 * 	the thread should never happen, but if it does...
+		 * 	fall thru and print it as a bpf_output event.
+		 */
+	}
+
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		if (evsel == trace->syscalls.events.augmented)
-			trace__fprintf_sys_enter(trace, evsel, sample);
-		else
-			bpf_output__fprintf(trace, sample);
+		bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
@@ -2071,6 +2091,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		}
 	}
 
+newline:
 	fprintf(trace->output, "\n");
 
 	if (callchain_ret > 0)
-- 
2.14.4
