From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/77] perf trace: Show comm and tid for tracepoint events
Date: Wed,  5 Sep 2018 19:03:48 -0300
Message-ID: <20180905220440.20256-26-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that all events have that info, improving reading by having
information better aligned, etc.

Before:

  # echo 1 > /proc/sys/vm/drop_caches
  # perf trace -e block:*,ext4:*,tools/perf/examples/bpf/augmented_syscalls.c,close cat tools/perf/examples/bpf/hello.c
       0.000 (         ): #include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);
  cat/2731 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)
       0.025 (         ): syscalls:sys_exit_openat:0x3
       0.063 ( 0.022 ms): cat/2731 close(fd: 3) = 0
       0.110 (         ): cat/2731 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
       0.123 (         ): syscalls:sys_exit_openat:0x3
       0.243 ( 0.008 ms): cat/2731 close(fd: 3) = 0
       0.485 (         ): cat/2731 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
       0.500 (         ): syscalls:sys_exit_open:0x3
       0.531 ( 0.017 ms): cat/2731 close(fd: 3) = 0
       0.587 (         ): cat/2731 openat(dfd: CWD, filename: tools/perf/examples/bpf/hello.c)
       0.601 (         ): syscalls:sys_exit_openat:0x3
       0.631 (         ): ext4:ext4_es_lookup_extent_enter:dev 253,2 ino 1311399 lblk 0
       0.639 (         ): ext4:ext4_es_lookup_extent_exit:dev 253,2 ino 1311399 found 1 [0/1) 5276651 W0x10
       0.654 (         ): block:block_bio_queue:253,2 R 42213208 + 8 [cat]
       0.663 (         ): block:block_bio_remap:8,0 R 58206040 + 8 <- (253,2) 42213208
       0.671 (         ): block:block_bio_remap:8,0 R 175570776 + 8 <- (8,6) 58206040
       0.678 (         ): block:block_bio_queue:8,0 R 175570776 + 8 [cat]
       0.692 (         ): block:block_getrq:8,0 R 175570776 + 8 [cat]
       0.700 (         ): block:block_plug:[cat]
       0.708 (         ): block:block_rq_insert:8,0 R 4096 () 175570776 + 8 [cat]
       0.713 (         ): block:block_unplug:[cat] 1
       0.716 (         ): block:block_rq_issue:8,0 R 4096 () 175570776 + 8 [cat]
       0.949 ( 0.007 ms): cat/2731 close(fd: 3) = 0
       0.969 ( 0.006 ms): cat/2731 close(fd: 1) = 0
       0.982 ( 0.006 ms): cat/2731 close(fd: 2) = 0
  #

After:

  # echo 1 > /proc/sys/vm/drop_caches
  # perf trace -e block:*,ext4:*,tools/perf/examples/bpf/augmented_syscalls.c,close cat tools/perf/examples/bpf/hello.c
       0.000 (         ): cat/1380 openat(dfd: CWD, filename: /etc/ld.so.cache, flags: CLOEXEC)#include <stdio.h>

  int syscall_enter(openat)(void *args)
  {
  	puts("Hello, world\n");
  	return 0;
  }

  license(GPL);

       0.024 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.063 ( 0.024 ms): cat/1380 close(fd: 3) = 0
       0.114 (         ): cat/1380 openat(dfd: CWD, filename: /lib64/libc.so.6, flags: CLOEXEC)
       0.127 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.247 ( 0.009 ms): cat/1380 close(fd: 3) = 0
       0.484 (         ): cat/1380 open(filename: /usr/lib/locale/locale-archive, flags: CLOEXEC)
       0.499 (         ): cat/1380 syscalls:sys_exit_open:0x3
       0.613 ( 0.010 ms): cat/1380 close(fd: 3) = 0
       0.662 (         ): cat/1380 openat(dfd: CWD, filename: tools/perf/examples/bpf/hello.c)
       0.678 (         ): cat/1380 syscalls:sys_exit_openat:0x3
       0.712 (         ): cat/1380 ext4:ext4_es_lookup_extent_enter:dev 253,2 ino 1311399 lblk 0
       0.721 (         ): cat/1380 ext4:ext4_es_lookup_extent_exit:dev 253,2 ino 1311399 found 1 [0/1) 5276651 W0x10
       0.734 (         ): cat/1380 block:block_bio_queue:253,2 R 42213208 + 8 [cat]
       0.745 (         ): cat/1380 block:block_bio_remap:8,0 R 58206040 + 8 <- (253,2) 42213208
       0.754 (         ): cat/1380 block:block_bio_remap:8,0 R 175570776 + 8 <- (8,6) 58206040
       0.761 (         ): cat/1380 block:block_bio_queue:8,0 R 175570776 + 8 [cat]
       0.780 (         ): cat/1380 block:block_getrq:8,0 R 175570776 + 8 [cat]
       0.791 (         ): cat/1380 block:block_plug:[cat]
       0.802 (         ): cat/1380 block:block_rq_insert:8,0 R 4096 () 175570776 + 8 [cat]
       0.806 (         ): cat/1380 block:block_unplug:[cat] 1
       0.810 (         ): cat/1380 block:block_rq_issue:8,0 R 4096 () 175570776 + 8 [cat]
       1.005 ( 0.011 ms): cat/1380 close(fd: 3) = 0
       1.031 ( 0.008 ms): cat/1380 close(fd: 1) = 0
       1.048 ( 0.008 ms): cat/1380 close(fd: 2) = 0
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-us1mwsupxffs4jlm3uqm5dvj@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 759d14e3fe6b..97ace635bed8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2049,6 +2049,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 				union perf_event *event __maybe_unused,
 				struct perf_sample *sample)
 {
+	struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 	int callchain_ret = 0;
 
 	if (sample->callchain) {
@@ -2066,21 +2067,18 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	if (trace->trace_syscalls)
 		fprintf(trace->output, "(         ): ");
 
+	if (thread)
+		trace__fprintf_comm_tid(trace, thread, trace->output);
+
 	if (evsel == trace->syscalls.events.augmented) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
 		struct syscall *sc = trace__syscall_info(trace, evsel, id);
 
 		if (sc) {
-			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
-
-			if (thread) {
-				trace__fprintf_comm_tid(trace, thread, trace->output);
-				fprintf(trace->output, "%s(", sc->name);
-				trace__fprintf_sys_enter(trace, evsel, sample);
-				fputc(')', trace->output);
-				thread__put(thread);
-				goto newline;
-			}
+			fprintf(trace->output, "%s(", sc->name);
+			trace__fprintf_sys_enter(trace, evsel, sample);
+			fputc(')', trace->output);
+			goto newline;
 		}
 
 		/*
@@ -2110,6 +2108,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
 		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+	thread__put(thread);
 out:
 	return 0;
 }
-- 
2.14.4
