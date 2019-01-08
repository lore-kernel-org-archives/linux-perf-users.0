From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/16] perf trace: Fix ')' placement in "interrupted" syscall lines
Date: Tue,  8 Jan 2019 16:58:55 -0300
Message-ID: <20190108195910.17726-2-acme@kernel.org>
References: <20190108195910.17726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190108195910.17726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When we get the sys_enter for a syscall we check if the last one is
still waiting for its matching sys_exit, if so we print this:

   468.753 (         ): firefox/32382 poll(ufds: 0x7f3988d3dd00, nfds: 7, timeout_msecs: 4294967295)     ...
   449.575 ( 0.004 ms): Softwar~cThrea/32434 futex(uaddr: 0x7f39a18a9b70, op: WAKE|PRIVATE_FLAG, val: 1)           = 0

At some point we'll get that poll sys_exit event and will print a "[continued]" line.

While making the sizing of the alignment after the syscall arg list and
its result configurable, so that we can mimic strace, which uses a
smaller alingment by default, a bug was introduced where the closing
parens appeared before the syscall name and its arg list, fix it.

Fixes: 4b8a240ed5e0 ("perf trace: Add alignment spaces after the closing parens")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-oi45i54s59h1w1kmgpzrfuum@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index adbf28183560..b8bf5d025563 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1758,6 +1758,7 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 {
 	struct thread_trace *ttrace;
 	size_t printed;
+	int len;
 
 	if (trace->failure_only || trace->current == NULL)
 		return 0;
@@ -1768,9 +1769,14 @@ static int trace__printf_interrupted_entry(struct trace *trace)
 		return 0;
 
 	printed  = trace__fprintf_entry_head(trace, trace->current, 0, false, ttrace->entry_time, trace->output);
-	printed += fprintf(trace->output, ")%-*s ...\n", trace->args_alignment, ttrace->entry_str);
-	ttrace->entry_pending = false;
+	printed += len = fprintf(trace->output, "%s)", ttrace->entry_str);
+
+	if (len < trace->args_alignment - 4)
+		printed += fprintf(trace->output, "%-*s", trace->args_alignment - 4 - len, " ");
 
+	printed += fprintf(trace->output, " ...\n");
+
+	ttrace->entry_pending = false;
 	++trace->nr_events_printed;
 
 	return printed;
-- 
2.20.1
