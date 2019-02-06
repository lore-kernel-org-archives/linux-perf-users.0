From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 47/53] perf thread-stack: Tidy thread_stack__no_call_return() by adding more local variables
Date: Wed,  6 Feb 2019 15:48:57 -0300
Message-ID: <20190206184903.24054-48-acme@kernel.org>
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

Make thread_stack__no_call_return() more readable by adding more local
variables.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20190109091835.5570-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 35 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 93ba3ab6a602..7f8eff018c16 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -591,34 +591,36 @@ static int thread_stack__no_call_return(struct thread *thread,
 					struct addr_location *to_al, u64 ref)
 {
 	struct call_path_root *cpr = ts->crp->cpr;
+	struct call_path *root = &cpr->call_path;
+	struct symbol *fsym = from_al->sym;
+	struct symbol *tsym = to_al->sym;
 	struct call_path *cp, *parent;
 	u64 ks = ts->kernel_start;
+	u64 addr = sample->addr;
+	u64 tm = sample->time;
+	u64 ip = sample->ip;
 	int err;
 
-	if (sample->ip >= ks && sample->addr < ks) {
+	if (ip >= ks && addr < ks) {
 		/* Return to userspace, so pop all kernel addresses */
 		while (thread_stack__in_kernel(ts)) {
 			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							sample->time, ref,
-							true);
+							tm, ref, true);
 			if (err)
 				return err;
 		}
 
 		/* If the stack is empty, push the userspace address */
 		if (!ts->cnt) {
-			cp = call_path__findnew(cpr, &cpr->call_path,
-						to_al->sym, sample->addr,
-						ts->kernel_start);
-			return thread_stack__push_cp(ts, 0, sample->time, ref,
-						     cp, true, false);
+			cp = call_path__findnew(cpr, root, tsym, addr, ks);
+			return thread_stack__push_cp(ts, 0, tm, ref, cp, true,
+						     false);
 		}
-	} else if (thread_stack__in_kernel(ts) && sample->ip < ks) {
+	} else if (thread_stack__in_kernel(ts) && ip < ks) {
 		/* Return to userspace, so pop all kernel addresses */
 		while (thread_stack__in_kernel(ts)) {
 			err = thread_stack__call_return(thread, ts, --ts->cnt,
-							sample->time, ref,
-							true);
+							tm, ref, true);
 			if (err)
 				return err;
 		}
@@ -627,19 +629,16 @@ static int thread_stack__no_call_return(struct thread *thread,
 	if (ts->cnt)
 		parent = ts->stack[ts->cnt - 1].cp;
 	else
-		parent = &cpr->call_path;
+		parent = root;
 
 	/* This 'return' had no 'call', so push and pop top of stack */
-	cp = call_path__findnew(cpr, parent, from_al->sym, sample->ip,
-				ts->kernel_start);
+	cp = call_path__findnew(cpr, parent, fsym, ip, ks);
 
-	err = thread_stack__push_cp(ts, sample->addr, sample->time, ref, cp,
-				    true, false);
+	err = thread_stack__push_cp(ts, addr, tm, ref, cp, true, false);
 	if (err)
 		return err;
 
-	return thread_stack__pop_cp(thread, ts, sample->addr, sample->time, ref,
-				    to_al->sym);
+	return thread_stack__pop_cp(thread, ts, addr, tm, ref, tsym);
 }
 
 static int thread_stack__trace_begin(struct thread *thread,
-- 
2.20.1
