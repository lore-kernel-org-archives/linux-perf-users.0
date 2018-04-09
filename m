From: Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH v5 1/3] perf/core: store context switch out type into Perf
 trace
Date: Mon, 9 Apr 2018 10:25:32 +0300
Message-ID: <9ff84e83-a0ca-dd82-a6d0-cb951689be74@linux.intel.com>
References: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ff228fc5-5742-a5fe-8cad-79704742672c@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


Store preempting context switch out event into Perf trace as a part of 
PERF_RECORD_SWITCH[_CPU_WIDE] record.

Percentage of preempting and non-preempting context switches help 
understanding the nature of workloads (CPU or IO bound) that are running 
on a machine;

The event is treated as preemption one when task->state value of the 
thread being switched out is TASK_RUNNING. Event type encoding is 
implemented using PERF_RECORD_MISC_SWITCH_OUT_PREEMPT bit;
	
Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 include/uapi/linux/perf_event.h       | 18 +++++++++++++++---
 kernel/events/core.c                  |  4 ++++
 tools/include/uapi/linux/perf_event.h | 18 +++++++++++++++---
 3 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc1c330c6bd6..872a5aaa77eb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7584,6 +7584,10 @@ static void perf_event_switch(struct task_struct *task,
 		},
 	};
 
+	if (!sched_in && task->state == TASK_RUNNING)
+		switch_event.event_id.header.misc |=
+				PERF_RECORD_MISC_SWITCH_OUT_PREEMPT;
+
 	perf_iterate_sb(perf_event_switch_output,
 		       &switch_event,
 		       NULL);
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 912b85b52344..b8e288a1f740 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -650,11 +650,23 @@ struct perf_event_mmap_page {
 #define PERF_RECORD_MISC_COMM_EXEC		(1 << 13)
 #define PERF_RECORD_MISC_SWITCH_OUT		(1 << 13)
 /*
- * Indicates that the content of PERF_SAMPLE_IP points to
- * the actual instruction that triggered the event. See also
- * perf_event_attr::precise_ip.
+ * These PERF_RECORD_MISC_* flags below are safely reused
+ * for the following events:
+ *
+ *   PERF_RECORD_MISC_EXACT_IP           - PERF_RECORD_SAMPLE of precise events
+ *   PERF_RECORD_MISC_SWITCH_OUT_PREEMPT - PERF_RECORD_SWITCH* events
+ *
+ *
+ * PERF_RECORD_MISC_EXACT_IP:
+ *   Indicates that the content of PERF_SAMPLE_IP points to
+ *   the actual instruction that triggered the event. See also
+ *   perf_event_attr::precise_ip.
+ *
+ * PERF_RECORD_MISC_SWITCH_OUT_PREEMPT:
+ *   Indicates that thread was preempted in TASK_RUNNING state.
  */
 #define PERF_RECORD_MISC_EXACT_IP		(1 << 14)
+#define PERF_RECORD_MISC_SWITCH_OUT_PREEMPT	(1 << 14)
 /*
  * Reserve the last bit to indicate some extended misc field
  */
