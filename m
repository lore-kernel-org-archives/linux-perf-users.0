From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 23/27] perf tools: Improve thread_stack__event() for trace begin / end
Date: Mon, 24 Sep 2018 12:02:38 -0300
Message-ID: <20180924150242.14235-24-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

thread_stack__event() is used to create call stacks, by keeping track of
calls and returns. Improve the handling of trace begin / end to allow
for a trace that ends in a call.

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, enhance the thread stack
so that it does not expect to see the 'return' for a 'call' that ends
the trace.

Committer notes:

Added this:

                return thread_stack__push(thread->ts, ret_addr,
-                                         flags && PERF_IP_FLAG_TRACE_END);
+                                         flags & PERF_IP_FLAG_TRACE_END);

To fix problem spotted by:

debian:9:            clang version 3.8.1-24 (tags/RELEASE_381/final)
debian:experimental: clang version 6.0.1-6 (tags/RELEASE_601/final)

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index dd17d6a38d3a..e3f7dfecafa9 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -36,6 +36,7 @@
  * @branch_count: the branch count when the entry was created
  * @cp: call path
  * @no_call: a 'call' was not seen
+ * @trace_end: a 'call' but trace ended
  */
 struct thread_stack_entry {
 	u64 ret_addr;
@@ -44,6 +45,7 @@ struct thread_stack_entry {
 	u64 branch_count;
 	struct call_path *cp;
 	bool no_call;
+	bool trace_end;
 };
 
 /**
@@ -112,7 +114,8 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	return ts;
 }
 
-static int thread_stack__push(struct thread_stack *ts, u64 ret_addr)
+static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
+			      bool trace_end)
 {
 	int err = 0;
 
@@ -124,6 +127,7 @@ static int thread_stack__push(struct thread_stack *ts, u64 ret_addr)
 		}
 	}
 
+	ts->stack[ts->cnt].trace_end = trace_end;
 	ts->stack[ts->cnt++].ret_addr = ret_addr;
 
 	return err;
@@ -150,6 +154,18 @@ static void thread_stack__pop(struct thread_stack *ts, u64 ret_addr)
 	}
 }
 
+static void thread_stack__pop_trace_end(struct thread_stack *ts)
+{
+	size_t i;
+
+	for (i = ts->cnt; i; ) {
+		if (ts->stack[--i].trace_end)
+			ts->cnt = i;
+		else
+			return;
+	}
+}
+
 static bool thread_stack__in_kernel(struct thread_stack *ts)
 {
 	if (!ts->cnt)
@@ -254,10 +270,19 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		ret_addr = from_ip + insn_len;
 		if (ret_addr == to_ip)
 			return 0; /* Zero-length calls are excluded */
-		return thread_stack__push(thread->ts, ret_addr);
-	} else if (flags & PERF_IP_FLAG_RETURN) {
-		if (!from_ip)
-			return 0;
+		return thread_stack__push(thread->ts, ret_addr,
+					  flags & PERF_IP_FLAG_TRACE_END);
+	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
+		/*
+		 * If the caller did not change the trace number (which would
+		 * have flushed the stack) then try to make sense of the stack.
+		 * Possibly, tracing began after returning to the current
+		 * address, so try to pop that. Also, do not expect a call made
+		 * when the trace ended, to return, so pop that.
+		 */
+		thread_stack__pop(thread->ts, to_ip);
+		thread_stack__pop_trace_end(thread->ts);
+	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
 		thread_stack__pop(thread->ts, to_ip);
 	}
 
-- 
2.14.4
