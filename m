From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 05/77] perf trace: Show comm/tid for augmented_syscalls
Date: Wed,  5 Sep 2018 19:03:28 -0300
Message-ID: <20180905220440.20256-6-acme@kernel.org>
References: <20180905220440.20256-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180905220440.20256-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To get us a bit more like the sys_enter + sys_exit combo:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC)
     0.009 ( 0.009 ms): cat/3619 openat(dfd: CWD, filename: 0x31b6dda8, flags: CLOEXEC) = 3
     0.051 (         ): openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC)
     0.054 ( 0.010 ms): cat/3619 openat(dfd: CWD, filename: 0x31d75ce0, flags: CLOEXEC) = 3
     0.539 (         ): openat(dfd: CWD, filename: 0xca71506b)
     0.543 ( 0.115 ms): cat/3619 openat(dfd: CWD, filename: 0xca71506b) = 3
  #

After:

  # perf trace -e tools/perf/examples/bpf/augmented_syscalls.c,openat cat /etc/passwd > /dev/null
     0.000 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC)
     0.007 ( 0.005 ms): cat/4919 openat(dfd: CWD, filename: 0xc8358da8, flags: CLOEXEC) = 3
     0.032 (         ): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC)
     0.033 ( 0.006 ms): cat/4919 openat(dfd: CWD, filename: 0xc8560ce0, flags: CLOEXEC) = 3
     0.301 (         ): cat/4919 openat(dfd: CWD, filename: 0x91fa306b)
     0.304 ( 0.004 ms): cat/4919 openat(dfd: CWD, filename: 0x91fa306b) = 3
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6w8ytyo5y655a1hsyfpfily6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 92488edd00eb..e46ac9009172 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2069,6 +2069,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
 			struct thread *thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
 
 			if (thread) {
+				trace__fprintf_comm_tid(trace, thread, trace->output);
 				fprintf(trace->output, "%s(", sc->name);
 				trace__fprintf_sys_enter(trace, evsel, sample);
 				fputc(')', trace->output);
-- 
2.14.4
