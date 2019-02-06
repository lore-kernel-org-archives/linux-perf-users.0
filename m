From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 46/53] perf thread-stack: Tidy thread_stack__push_cp() usage
Date: Wed,  6 Feb 2019 15:48:56 -0300
Message-ID: <20190206184903.24054-47-acme@kernel.org>
References: <20190206184903.24054-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190206184903.24054-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

If 'cp' is checked in thread_stack__push_cp() a number of error checks
can be removed, reducing code size and improving readability.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d52f27f373ce..93ba3ab6a602 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -493,6 +493,9 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	struct thread_stack_entry *tse;
 	int err;
 
+	if (!cp)
+		return -ENOMEM;
+
 	if (ts->cnt == ts->sz) {
 		err = thread_stack__grow(ts);
 		if (err)
@@ -576,8 +579,6 @@ static int thread_stack__bottom(struct thread_stack *ts,
 
 	cp = call_path__findnew(cpr, &cpr->call_path, sym, ip,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	return thread_stack__push_cp(ts, ip, sample->time, ref, cp,
 				     true, false);
@@ -609,8 +610,6 @@ static int thread_stack__no_call_return(struct thread *thread,
 			cp = call_path__findnew(cpr, &cpr->call_path,
 						to_al->sym, sample->addr,
 						ts->kernel_start);
-			if (!cp)
-				return -ENOMEM;
 			return thread_stack__push_cp(ts, 0, sample->time, ref,
 						     cp, true, false);
 		}
@@ -633,8 +632,6 @@ static int thread_stack__no_call_return(struct thread *thread,
 	/* This 'return' had no 'call', so push and pop top of stack */
 	cp = call_path__findnew(cpr, parent, from_al->sym, sample->ip,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
 				    true, false);
@@ -680,8 +677,6 @@ static int thread_stack__trace_end(struct thread_stack *ts,
 
 	cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp, NULL, 0,
 				ts->kernel_start);
-	if (!cp)
-		return -ENOMEM;
 
 	ret_addr = sample->ip + sample->insn_len;
 
@@ -745,8 +740,6 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 		cp = call_path__findnew(cpr, ts->stack[ts->cnt - 1].cp,
 					to_al->sym, sample->addr,
 					ts->kernel_start);
-		if (!cp)
-			return -ENOMEM;
 		err = thread_stack__push_cp(ts, ret_addr, sample->time, ref,
 					    cp, false, trace_end);
 	} else if (sample->flags & PERF_IP_FLAG_RETURN) {
-- 
2.20.1
