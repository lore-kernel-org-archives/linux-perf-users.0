From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 31/54] perf intel-pt: Fix sync_switch
Date: Thu,  8 Mar 2018 16:50:06 -0300
Message-ID: <20180308195029.14991-32-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, stable@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

sync_switch is a facility to synchronize decoding more closely with the
point in the kernel when the context actually switched.

The flag when sync_switch is enabled was global to the decoding, whereas
it is really specific to the CPU.

The trace data for different CPUs is put on different queues, so add
sync_switch to the intel_pt_queue structure and use that in preference
to the global setting in the intel_pt structure.

That fixes problems decoding one CPU's trace because sync_switch was
disabled on a different CPU's queue.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/1520431349-30689-3-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 4a7746249999..0979a6e8b2b7 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -143,6 +143,7 @@ struct intel_pt_queue {
 	bool stop;
 	bool step_through_buffers;
 	bool use_buffer_pid_tid;
+	bool sync_switch;
 	pid_t pid, tid;
 	int cpu;
 	int switch_state;
@@ -963,10 +964,12 @@ static int intel_pt_setup_queue(struct intel_pt *pt,
 			if (pt->timeless_decoding || !pt->have_sched_switch)
 				ptq->use_buffer_pid_tid = true;
 		}
+
+		ptq->sync_switch = pt->sync_switch;
 	}
 
 	if (!ptq->on_heap &&
-	    (!pt->sync_switch ||
+	    (!ptq->sync_switch ||
 	     ptq->switch_state != INTEL_PT_SS_EXPECTING_SWITCH_EVENT)) {
 		const struct intel_pt_state *state;
 		int ret;
@@ -1549,7 +1552,7 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 	if (pt->synth_opts.last_branch)
 		intel_pt_update_last_branch_rb(ptq);
 
-	if (!pt->sync_switch)
+	if (!ptq->sync_switch)
 		return 0;
 
 	if (intel_pt_is_switch_ip(ptq, state->to_ip)) {
@@ -1630,6 +1633,21 @@ static u64 intel_pt_switch_ip(struct intel_pt *pt, u64 *ptss_ip)
 	return switch_ip;
 }
 
+static void intel_pt_enable_sync_switch(struct intel_pt *pt)
+{
+	unsigned int i;
+
+	pt->sync_switch = true;
+
+	for (i = 0; i < pt->queues.nr_queues; i++) {
+		struct auxtrace_queue *queue = &pt->queues.queue_array[i];
+		struct intel_pt_queue *ptq = queue->priv;
+
+		if (ptq)
+			ptq->sync_switch = true;
+	}
+}
+
 static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 {
 	const struct intel_pt_state *state = ptq->state;
@@ -1646,7 +1664,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 			if (pt->switch_ip) {
 				intel_pt_log("switch_ip: %"PRIx64" ptss_ip: %"PRIx64"\n",
 					     pt->switch_ip, pt->ptss_ip);
-				pt->sync_switch = true;
+				intel_pt_enable_sync_switch(pt);
 			}
 		}
 	}
@@ -1662,9 +1680,9 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 		if (state->err) {
 			if (state->err == INTEL_PT_ERR_NODATA)
 				return 1;
-			if (pt->sync_switch &&
+			if (ptq->sync_switch &&
 			    state->from_ip >= pt->kernel_start) {
-				pt->sync_switch = false;
+				ptq->sync_switch = false;
 				intel_pt_next_tid(pt, ptq);
 			}
 			if (pt->synth_opts.errors) {
@@ -1690,7 +1708,7 @@ static int intel_pt_run_decoder(struct intel_pt_queue *ptq, u64 *timestamp)
 				     state->timestamp, state->est_timestamp);
 			ptq->timestamp = state->est_timestamp;
 		/* Use estimated TSC in unknown switch state */
-		} else if (pt->sync_switch &&
+		} else if (ptq->sync_switch &&
 			   ptq->switch_state == INTEL_PT_SS_UNKNOWN &&
 			   intel_pt_is_switch_ip(ptq, state->to_ip) &&
 			   ptq->next_tid == -1) {
@@ -1837,7 +1855,7 @@ static int intel_pt_sync_switch(struct intel_pt *pt, int cpu, pid_t tid,
 		return 1;
 
 	ptq = intel_pt_cpu_to_ptq(pt, cpu);
-	if (!ptq)
+	if (!ptq || !ptq->sync_switch)
 		return 1;
 
 	switch (ptq->switch_state) {
-- 
2.14.3
