From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/29] perf thread-stack: Avoid direct reference to the thread's stack
Date: Thu,  3 Jan 2019 09:46:04 -0300
Message-ID: <20190103124609.29672-25-acme@kernel.org>
References: <20190103124609.29672-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103124609.29672-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

In preparation for fixing thread stack processing for the idle task,
avoid direct reference to the thread's stack. The thread stack will
change to an array of thread stacks, at which point the meaning of the
direct reference will change.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-4-adrian.hunter@intel.com
[ Rename thread_stack__ts() to thread__stack() since this operates on a 'thread' struct ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 81 ++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 068c7c8db4be..d93cd286b048 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -111,9 +111,16 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 		ts->kernel_start = 1ULL << 63;
 	ts->crp = crp;
 
+	thread->ts = ts;
+
 	return ts;
 }
 
+static inline struct thread_stack *thread__stack(struct thread *thread)
+{
+	return thread ? thread->ts : NULL;
+}
+
 static int thread_stack__push(struct thread_stack *ts, u64 ret_addr,
 			      bool trace_end)
 {
@@ -226,8 +233,10 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 
 int thread_stack__flush(struct thread *thread)
 {
-	if (thread->ts)
-		return __thread_stack__flush(thread, thread->ts);
+	struct thread_stack *ts = thread->ts;
+
+	if (ts)
+		return __thread_stack__flush(thread, ts);
 
 	return 0;
 }
@@ -235,16 +244,18 @@ int thread_stack__flush(struct thread *thread)
 int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 			u64 to_ip, u16 insn_len, u64 trace_nr)
 {
+	struct thread_stack *ts = thread__stack(thread);
+
 	if (!thread)
 		return -EINVAL;
 
-	if (!thread->ts) {
-		thread->ts = thread_stack__new(thread, NULL);
-		if (!thread->ts) {
+	if (!ts) {
+		ts = thread_stack__new(thread, NULL);
+		if (!ts) {
 			pr_warning("Out of memory: no thread stack\n");
 			return -ENOMEM;
 		}
-		thread->ts->trace_nr = trace_nr;
+		ts->trace_nr = trace_nr;
 	}
 
 	/*
@@ -252,14 +263,14 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 	 * the stack might be completely invalid.  Better to report nothing than
 	 * to report something misleading, so flush the stack.
 	 */
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 
 	/* Stop here if thread_stack__process() is in use */
-	if (thread->ts->crp)
+	if (ts->crp)
 		return 0;
 
 	if (flags & PERF_IP_FLAG_CALL) {
@@ -270,7 +281,7 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		ret_addr = from_ip + insn_len;
 		if (ret_addr == to_ip)
 			return 0; /* Zero-length calls are excluded */
-		return thread_stack__push(thread->ts, ret_addr,
+		return thread_stack__push(ts, ret_addr,
 					  flags & PERF_IP_FLAG_TRACE_END);
 	} else if (flags & PERF_IP_FLAG_TRACE_BEGIN) {
 		/*
@@ -280,10 +291,10 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 		 * address, so try to pop that. Also, do not expect a call made
 		 * when the trace ended, to return, so pop that.
 		 */
-		thread_stack__pop(thread->ts, to_ip);
-		thread_stack__pop_trace_end(thread->ts);
+		thread_stack__pop(ts, to_ip);
+		thread_stack__pop_trace_end(ts);
 	} else if ((flags & PERF_IP_FLAG_RETURN) && from_ip) {
-		thread_stack__pop(thread->ts, to_ip);
+		thread_stack__pop(ts, to_ip);
 	}
 
 	return 0;
@@ -291,21 +302,25 @@ int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
 
 void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
 {
-	if (!thread || !thread->ts)
+	struct thread_stack *ts = thread__stack(thread);
+
+	if (!ts)
 		return;
 
-	if (trace_nr != thread->ts->trace_nr) {
-		if (thread->ts->trace_nr)
-			__thread_stack__flush(thread, thread->ts);
-		thread->ts->trace_nr = trace_nr;
+	if (trace_nr != ts->trace_nr) {
+		if (ts->trace_nr)
+			__thread_stack__flush(thread, ts);
+		ts->trace_nr = trace_nr;
 	}
 }
 
 void thread_stack__free(struct thread *thread)
 {
-	if (thread->ts) {
-		__thread_stack__flush(thread, thread->ts);
-		zfree(&thread->ts->stack);
+	struct thread_stack *ts = thread->ts;
+
+	if (ts) {
+		__thread_stack__flush(thread, ts);
+		zfree(&ts->stack);
 		zfree(&thread->ts);
 	}
 }
@@ -318,6 +333,7 @@ static inline u64 callchain_context(u64 ip, u64 kernel_start)
 void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
 			  size_t sz, u64 ip, u64 kernel_start)
 {
+	struct thread_stack *ts = thread__stack(thread);
 	u64 context = callchain_context(ip, kernel_start);
 	u64 last_context;
 	size_t i, j;
@@ -330,15 +346,15 @@ void thread_stack__sample(struct thread *thread, struct ip_callchain *chain,
 	chain->ips[0] = context;
 	chain->ips[1] = ip;
 
-	if (!thread || !thread->ts) {
+	if (!ts) {
 		chain->nr = 2;
 		return;
 	}
 
 	last_context = context;
 
-	for (i = 2, j = 1; i < sz && j <= thread->ts->cnt; i++, j++) {
-		ip = thread->ts->stack[thread->ts->cnt - j].ret_addr;
+	for (i = 2, j = 1; i < sz && j <= ts->cnt; i++, j++) {
+		ip = ts->stack[ts->cnt - j].ret_addr;
 		context = callchain_context(ip, kernel_start);
 		if (context != last_context) {
 			if (i >= sz - 1)
@@ -590,7 +606,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 			  struct addr_location *to_al, u64 ref,
 			  struct call_return_processor *crp)
 {
-	struct thread_stack *ts = thread->ts;
+	struct thread_stack *ts = thread__stack(thread);
 	int err = 0;
 
 	if (ts && !ts->crp) {
@@ -600,10 +616,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	if (!ts) {
-		thread->ts = thread_stack__new(thread, crp);
-		if (!thread->ts)
+		ts = thread_stack__new(thread, crp);
+		if (!ts)
 			return -ENOMEM;
-		ts = thread->ts;
 		ts->comm = comm;
 	}
 
@@ -668,7 +683,9 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 size_t thread_stack__depth(struct thread *thread)
 {
-	if (!thread->ts)
+	struct thread_stack *ts = thread__stack(thread);
+
+	if (!ts)
 		return 0;
-	return thread->ts->cnt;
+	return ts->cnt;
 }
-- 
2.19.2
