From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/85] perf intel-pt: Add support for samples to contain IPC ratio
Date: Tue, 11 Jun 2019 15:57:56 -0300
Message-ID: <20190611185911.11645-11-acme@kernel.org>
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

Copy the incremental instruction count and cycle count onto 'instructions'
and 'branches' samples.

Because Intel PT does not update the cycle count on every branch or
instruction, the incremental values will often be zero.

When there are values, they will be the number of instructions and
number of cycles since the last update, and thus represent the average
IPC since the last IPC value.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190520113728.14389-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 7a70693c1b91..3cff8fe2eaa0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -157,6 +157,12 @@ struct intel_pt_queue {
 	u32 flags;
 	u16 insn_len;
 	u64 last_insn_cnt;
+	u64 ipc_insn_cnt;
+	u64 ipc_cyc_cnt;
+	u64 last_in_insn_cnt;
+	u64 last_in_cyc_cnt;
+	u64 last_br_insn_cnt;
+	u64 last_br_cyc_cnt;
 	char insn[INTEL_PT_INSN_BUF_SZ];
 };
 
@@ -1162,6 +1168,13 @@ static int intel_pt_synth_branch_sample(struct intel_pt_queue *ptq)
 		sample.branch_stack = (struct branch_stack *)&dummy_bs;
 	}
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_br_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_br_insn_cnt;
+		ptq->last_br_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_br_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	return intel_pt_deliver_synth_b_event(pt, event, &sample,
 					      pt->branches_sample_type);
 }
@@ -1217,6 +1230,13 @@ static int intel_pt_synth_instruction_sample(struct intel_pt_queue *ptq)
 	sample.stream_id = ptq->pt->instructions_id;
 	sample.period = ptq->state->tot_insn_cnt - ptq->last_insn_cnt;
 
+	sample.cyc_cnt = ptq->ipc_cyc_cnt - ptq->last_in_cyc_cnt;
+	if (sample.cyc_cnt) {
+		sample.insn_cnt = ptq->ipc_insn_cnt - ptq->last_in_insn_cnt;
+		ptq->last_in_insn_cnt = ptq->ipc_insn_cnt;
+		ptq->last_in_cyc_cnt = ptq->ipc_cyc_cnt;
+	}
+
 	ptq->last_insn_cnt = ptq->state->tot_insn_cnt;
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample,
@@ -1488,6 +1508,15 @@ static int intel_pt_sample(struct intel_pt_queue *ptq)
 
 	ptq->have_sample = false;
 
+	if (ptq->state->tot_cyc_cnt > ptq->ipc_cyc_cnt) {
+		/*
+		 * Cycle count and instruction count only go together to create
+		 * a valid IPC ratio when the cycle count changes.
+		 */
+		ptq->ipc_insn_cnt = ptq->state->tot_insn_cnt;
+		ptq->ipc_cyc_cnt = ptq->state->tot_cyc_cnt;
+	}
+
 	if (pt->sample_pwr_events && (state->type & INTEL_PT_PWR_EVT)) {
 		if (state->type & INTEL_PT_CBR_CHG) {
 			err = intel_pt_synth_cbr_sample(ptq);
-- 
2.20.1
