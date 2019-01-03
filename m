From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 25/29] perf thread-stack: Allow for a thread stack array
Date: Thu,  3 Jan 2019 09:46:05 -0300
Message-ID: <20190103124609.29672-26-acme@kernel.org>
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
allow for a thread stack array.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20181221120620.9659-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread-stack.c | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index d93cd286b048..a5f7b9d8fc23 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -60,6 +60,7 @@ struct thread_stack_entry {
  * @last_time: last timestamp
  * @crp: call/return processor
  * @comm: current comm
+ * @arr_sz: size of array if this is the first element of an array
  */
 struct thread_stack {
 	struct thread_stack_entry *stack;
@@ -71,6 +72,7 @@ struct thread_stack {
 	u64 last_time;
 	struct call_return_processor *crp;
 	struct comm *comm;
+	unsigned int arr_sz;
 };
 
 static int thread_stack__grow(struct thread_stack *ts)
@@ -100,6 +102,8 @@ static struct thread_stack *thread_stack__new(struct thread *thread,
 	if (!ts)
 		return NULL;
 
+	ts->arr_sz = 1;
+
 	if (thread_stack__grow(ts)) {
 		free(ts);
 		return NULL;
@@ -234,11 +238,19 @@ static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
 int thread_stack__flush(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
+	int err = 0;
 
-	if (ts)
-		return __thread_stack__flush(thread, ts);
+	if (ts) {
+		for (pos = 0; pos < ts->arr_sz; pos++) {
+			int ret = __thread_stack__flush(thread, ts + pos);
 
-	return 0;
+			if (ret)
+				err = ret;
+		}
+	}
+
+	return err;
 }
 
 int thread_stack__event(struct thread *thread, u32 flags, u64 from_ip,
@@ -314,13 +326,29 @@ void thread_stack__set_trace_nr(struct thread *thread, u64 trace_nr)
 	}
 }
 
+static void __thread_stack__free(struct thread *thread, struct thread_stack *ts)
+{
+	__thread_stack__flush(thread, ts);
+	zfree(&ts->stack);
+}
+
+static void thread_stack__reset(struct thread *thread, struct thread_stack *ts)
+{
+	unsigned int arr_sz = ts->arr_sz;
+
+	__thread_stack__free(thread, ts);
+	memset(ts, 0, sizeof(*ts));
+	ts->arr_sz = arr_sz;
+}
+
 void thread_stack__free(struct thread *thread)
 {
 	struct thread_stack *ts = thread->ts;
+	unsigned int pos;
 
 	if (ts) {
-		__thread_stack__flush(thread, ts);
-		zfree(&ts->stack);
+		for (pos = 0; pos < ts->arr_sz; pos++)
+			__thread_stack__free(thread, ts + pos);
 		zfree(&thread->ts);
 	}
 }
@@ -611,7 +639,7 @@ int thread_stack__process(struct thread *thread, struct comm *comm,
 
 	if (ts && !ts->crp) {
 		/* Supersede thread_stack__event() */
-		thread_stack__free(thread);
+		thread_stack__reset(thread, ts);
 		ts = NULL;
 	}
 
-- 
2.19.2
