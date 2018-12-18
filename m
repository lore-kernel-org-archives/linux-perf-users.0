From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 21/63] perf trace: Avoid using raw_syscalls in duplicity with eBPF augmentation
Date: Tue, 18 Dec 2018 19:06:51 -0300
Message-ID: <20181218220733.15839-22-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So when we do something like:

   # perf trace -e open*,augmented_raw_syscalls.o

We need to set trace->trace_syscalls because there is logic that use
that when mixing strace-like output with other events, such as scheduler
tracepoints, but with that set we ended up having multiple
raw_syscalls:sys_{enter,exit} setup, which garbled the output, so
check if trace->augmented_raw_syscalls is set and avoid the two extra
tracepoints.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kjmnbrlgu0c38co1ye8egbsb@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 76e4fa04d824..f9eb5bc4fefb 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2721,11 +2721,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 
 	trace->live = true;
 
-	if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
-		goto out_error_raw_syscalls;
+	if (!trace->raw_augmented_syscalls) {
+		if (trace->trace_syscalls && trace__add_syscall_newtp(trace))
+			goto out_error_raw_syscalls;
 
-	if (trace->trace_syscalls)
-		trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+		if (trace->trace_syscalls)
+			trace->vfs_getname = perf_evlist__add_vfs_getname(evlist);
+	}
 
 	if ((trace->trace_pgfaults & TRACE_PFMAJ)) {
 		pgfault_maj = perf_evsel__new_pgfault(PERF_COUNT_SW_PAGE_FAULTS_MAJ);
@@ -2825,8 +2827,10 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		if (err < 0)
 			goto out_errno;
 
-		pr_debug("event qualifier tracepoint filter: %s\n",
-			 trace->syscalls.events.sys_exit->filter);
+		if (trace->syscalls.events.sys_exit) {
+			pr_debug("event qualifier tracepoint filter: %s\n",
+				 trace->syscalls.events.sys_exit->filter);
+		}
 	}
 
 	err = perf_evlist__apply_filters(evlist, &evsel);
-- 
2.19.2
