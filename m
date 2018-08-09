From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/44] perf trace: Wire up the augmented syscalls with the syscalls:sys_enter_FOO beautifier
Date: Thu,  9 Aug 2018 11:58:20 -0300
Message-ID: <20180809145822.21391-43-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We just check that the evsel is the one we associated with the
bpf-output event associated with the "__augmented_syscalls__" eBPF map,
to show that the formatting is done properly:

  # perf trace -e perf/tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.006 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC
     0.007 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x43e06da8, flags: CLOEXEC                 ) = 3
     0.029 (         ): __augmented_syscalls__:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.030 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC
     0.031 ( 0.004 ms): cat/11486 openat(dfd: CWD, filename: 0x4400ece0, flags: CLOEXEC                 ) = 3
     0.249 (         ): __augmented_syscalls__:dfd: CWD, filename: 0xc3700d6
     0.250 (         ): syscalls:sys_enter_openat:dfd: CWD, filename: 0xc3700d6
     0.252 ( 0.003 ms): cat/11486 openat(dfd: CWD, filename: 0xc3700d6                                  ) = 3
  #

Now we just need to get the full blown enter/exit handlers to check if the
evsel being processed is the augmented_syscalls one to go pick the pointer
payloads from the end of the payload.

We also need to state somehow what is the layout for multi pointer arg syscalls.

Also handy would be to have a BTF file with the struct definitions used in
syscalls, compact, generated at kernel built time and available for use in eBPF
programs.

Till we get there we can go on doing some manual coupling of the most relevant
syscalls with some hand built beautifiers.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-r6ba5izrml82nwfmwcp7jpkm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 06215acb1481..22ab8e67c760 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2042,7 +2042,10 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 	fprintf(trace->output, "%s:", evsel->name);
 
 	if (perf_evsel__is_bpf_output(evsel)) {
-		bpf_output__fprintf(trace, sample);
+		if (evsel == trace->syscalls.events.augmented)
+			trace__fprintf_sys_enter(trace, evsel, sample);
+		else
+			bpf_output__fprintf(trace, sample);
 	} else if (evsel->tp_format) {
 		if (strncmp(evsel->tp_format->name, "sys_enter_", 10) ||
 		    trace__fprintf_sys_enter(trace, evsel, sample)) {
-- 
2.14.4
