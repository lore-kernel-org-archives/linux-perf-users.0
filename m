From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 40/41] perf intel-pt: Improve sync_switch by processing PERF_RECORD_SWITCH* in events
Date: Wed, 29 May 2019 10:36:04 -0300
Message-ID: <20190529133605.21118-41-acme@kernel.org>
References: <20190529133605.21118-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190529133605.21118-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

Improve it by processing "context switch in" events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 40 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 03b1da6d1da4..6aaba1146fc8 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1914,6 +1914,44 @@ static int intel_pt_process_switch(struct intel_pt *pt,
 	return machine__set_current_tid(pt->machine, cpu, -1, tid);
 }
 
+static int intel_pt_context_switch_in(struct intel_pt *pt,
+				      struct perf_sample *sample)
+{
+	pid_t pid = sample->pid;
+	pid_t tid = sample->tid;
+	int cpu = sample->cpu;
+
+	if (pt->sync_switch) {
+		struct intel_pt_queue *ptq;
+
+		ptq = intel_pt_cpu_to_ptq(pt, cpu);
+		if (ptq && ptq->sync_switch) {
+			ptq->next_tid = -1;
+			switch (ptq->switch_state) {
+			case INTEL_PT_SS_NOT_TRACING:
+			case INTEL_PT_SS_UNKNOWN:
+			case INTEL_PT_SS_TRACING:
+				break;
+			case INTEL_PT_SS_EXPECTING_SWITCH_EVENT:
+			case INTEL_PT_SS_EXPECTING_SWITCH_IP:
+				ptq->switch_state = INTEL_PT_SS_TRACING;
+				break;
+			default:
+				break;
+			}
+		}
+	}
+
+	/*
+	 * If the current tid has not been updated yet, ensure it is now that
+	 * a "switch in" event has occurred.
+	 */
+	if (machine__get_current_tid(pt->machine, cpu) == tid)
+		return 0;
+
+	return machine__set_current_tid(pt->machine, cpu, pid, tid);
+}
+
 static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 				   struct perf_sample *sample)
 {
@@ -1925,7 +1963,7 @@ static int intel_pt_context_switch(struct intel_pt *pt, union perf_event *event,
 
 	if (pt->have_sched_switch == 3) {
 		if (!out)
-			return 0;
+			return intel_pt_context_switch_in(pt, sample);
 		if (event->header.type != PERF_RECORD_SWITCH_CPU_WIDE) {
 			pr_err("Expecting CPU-wide context switch event\n");
 			return -EINVAL;
-- 
2.20.1
