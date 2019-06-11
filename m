From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/85] perf thread-stack: Accumulate IPC information
Date: Tue, 11 Jun 2019 15:58:02 -0300
Message-ID: <20190611185911.11645-17-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Cycle and instruction counts are added to the stack. The IPC of a
function and all functions it calls, is also recorded.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-14-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 14 ++++++++++++++
 tools/perf/util/thread-stack.h |  4 ++++
 2 files changed, 18 insertions(+)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index 41942c2aaa18..8e390f78486f 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -49,6 +49,8 @@ enum retpoline_state_t {
  * @timestamp: timestamp (if known)
  * @ref: external reference (e.g. db_id of sample)
  * @branch_count: the branch count when the entry was created
+ * @insn_count: the instruction count when the entry was created
+ * @cyc_count the cycle count when the entry was created
  * @db_id: id used for db-export
  * @cp: call path
  * @no_call: a 'call' was not seen
@@ -60,6 +62,8 @@ struct thread_stack_entry {
 	u64 timestamp;
 	u64 ref;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 db_id;
 	struct call_path *cp;
 	bool no_call;
@@ -75,6 +79,8 @@ struct thread_stack_entry {
  * @sz: current maximum stack size
  * @trace_nr: current trace number
  * @branch_count: running branch count
+ * @insn_count: running  instruction count
+ * @cyc_count running  cycle count
  * @kernel_start: kernel start address
  * @last_time: last timestamp
  * @crp: call/return processor
@@ -88,6 +94,8 @@ struct thread_stack {
 	size_t sz;
 	u64 trace_nr;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 kernel_start;
 	u64 last_time;
 	struct call_return_processor *crp;
@@ -289,6 +297,8 @@ static int thread_stack__call_return(struct thread *thread,
 	cr.call_time = tse->timestamp;
 	cr.return_time = timestamp;
 	cr.branch_count = ts->branch_count - tse->branch_count;
+	cr.insn_count = ts->insn_count - tse->insn_count;
+	cr.cyc_count = ts->cyc_count - tse->cyc_count;
 	cr.db_id = tse->db_id;
 	cr.call_ref = tse->ref;
 	cr.return_ref = ref;
@@ -544,6 +554,8 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->timestamp = timestamp;
 	tse->ref = ref;
 	tse->branch_count = ts->branch_count;
+	tse->insn_count = ts->insn_count;
+	tse->cyc_count = ts->cyc_count;
 	tse->cp = cp;
 	tse->no_call = no_call;
 	tse->trace_end = trace_end;
@@ -874,6 +886,8 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 	}
 
 	ts->branch_count += 1;
+	ts->insn_count += sample->insn_cnt;
+	ts->cyc_count += sample->cyc_cnt;
 	ts->last_time = sample->time;
 
 	if (sample->flags & PERF_IP_FLAG_CALL) {
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index 9c45f947f5a9..bddb1daf6453 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -52,6 +52,8 @@ enum {
  * @call_time: timestamp of call (if known)
  * @return_time: timestamp of return (if known)
  * @branch_count: number of branches seen between call and return
+ * @insn_count: approx. number of instructions between call and return
+ * @cyc_count: approx. number of cycles between call and return
  * @call_ref: external reference to 'call' sample (e.g. db_id)
  * @return_ref:  external reference to 'return' sample (e.g. db_id)
  * @db_id: id used for db-export
@@ -65,6 +67,8 @@ struct call_return {
 	u64 call_time;
 	u64 return_time;
 	u64 branch_count;
+	u64 insn_count;
+	u64 cyc_count;
 	u64 call_ref;
 	u64 return_ref;
 	u64 db_id;
-- 
2.20.1
