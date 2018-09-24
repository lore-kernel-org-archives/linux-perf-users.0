From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 24/27] perf tools: Improve thread_stack__process() for trace begin / end
Date: Mon, 24 Sep 2018 12:02:39 -0300
Message-ID: <20180924150242.14235-25-acme@kernel.org>
References: <20180924150242.14235-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180924150242.14235-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

thread_stack__process() is used to create call paths for database
export.  Improve the handling of trace begin / end to allow for a trace
that ends in a call.

Previously, the Intel PT decoder would indicate begin / end by a branch
from / to zero. That hides useful information, in particular when a
trace ends with a call. Before remedying that, enhance the thread stack
so that it identifies the trace end by the flag instead of by ip == 0.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20180920130048.31432-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index e3f7dfecafa9..c091635bf7dc 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -357,7 +357,7 @@ void call_return_processor__free(struct call_return_processor *crp)
 
 static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 				 u64 timestamp, u64 ref, struct call_path *cp,
-				 bool no_call)
+				 bool no_call, bool trace_end)
 {
 	struct thread_stack_entry *tse;
 	int err;
@@ -375,6 +375,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->branch_count = ts->branch_count;
 	tse->cp = cp;
 	tse->no_call = no_call;
+	tse->trace_end = trace_end;
 
 	return 0;
 }
@@ -448,7 +449,7 @@ static int thread_stack__bottom(struct thread *thread, struct thread_stack *ts,
 		return -ENOMEM;
 
 	return thread_stack__push_cp(thread->ts, ip, sample->time, ref, cp,
-				     true);
+				     true, false);
 }
 
 static int thread_stack__no_call_return(struct thread *thread,
@@ -480,7 +481,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 			if (!cp)
 				return -ENOMEM;
 			return thread_stack__push_cp(ts, 0, sample->time, ref,
-						     cp, true);
+						     cp, true, false);
 		}
 	} else if (thread_stack__in_kernel(ts) && sample->ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
@@ -505,7 +506,7 @@ static int thread_stack__no_call_return(struct thread *thread,
 		return -ENOMEM;
 
 	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
-				    true);
+				    true, false);
 	if (err)
 		return err;
 
@@ -525,7 +526,7 @@ static int thread_stack__trace_begin(struct thread *thread,
 
 	/* Pop trace end */
 	tse = &ts->stack[ts->cnt - 1];
-	if (tse->cp->sym == NULL && tse->cp->ip == 0) {
+	if (tse->trace_end) {
 		err = thread_stack__call_return(thread, ts, --ts->cnt,
 						timestamp, ref, false);
 		if (err)
@@ -554,7 +555,7 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 	ret_addr = sample->ip + sample->insn_len;
 
 	return thread_stack__push_cp(ts, ret_addr, sample->time, ref, cp,
-				     false);
+				     false, true);
 }
 
 int thread_stack__process(struct thread *thread, struct comm *comm,
@@ -604,6 +605,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	ts->last_time = sample->time;
 
 	if (sample->flags & PERF_IP_FLAG_CALL) {
+		bool trace_end = sample->flags & PERF_IP_FLAG_TRACE_END;
 		struct call_path_root *cpr = ts->crp->cpr;
 		struct call_path *cp;
 		u64 ret_addr;
@@ -621,7 +623,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		if (!cp)
 			return -ENOMEM;
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
-					    cp, false);
+					    cp, false, trace_end);
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
 		if (!sample->ip || !sample->addr)
 			return 0;
-- 
2.14.4
