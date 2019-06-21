From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 11/25] perf intel-pt: Add LBR information to synthesized PEBS sample
Date: Fri, 21 Jun 2019 14:38:17 -0300
Message-ID: <20190621173831.13780-12-acme@kernel.org>
References: <20190621173831.13780-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190621173831.13780-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Add LBR information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index f83dd10bb7d0..db00c13dc36f 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1628,6 +1628,58 @@ static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
 	}
 }
 
+#define LBR_INFO_MISPRED	(1ULL << 63)
+#define LBR_INFO_IN_TX		(1ULL << 62)
+#define LBR_INFO_ABORT		(1ULL << 61)
+#define LBR_INFO_CYCLES		0xffff
+
+/* Refer kernel's intel_pmu_store_pebs_lbrs() */
+static u64 intel_pt_lbr_flags(u64 info)
+{
+	union {
+		struct branch_flags flags;
+		u64 result;
+	} u = {
+		.flags = {
+			.mispred	= !!(info & LBR_INFO_MISPRED),
+			.predicted	= !(info & LBR_INFO_MISPRED),
+			.in_tx		= !!(info & LBR_INFO_IN_TX),
+			.abort		= !!(info & LBR_INFO_ABORT),
+			.cycles		= info & LBR_INFO_CYCLES,
+		}
+	};
+
+	return u.result;
+}
+
+static void intel_pt_add_lbrs(struct branch_stack *br_stack,
+			      const struct intel_pt_blk_items *items)
+{
+	u64 *to;
+	int i;
+
+	br_stack->nr = 0;
+
+	to = &br_stack->entries[0].from;
+
+	for (i = INTEL_PT_LBR_0_POS; i <= INTEL_PT_LBR_2_POS; i++) {
+		u32 mask = items->mask[i];
+		const u64 *from = items->val[i];
+
+		for (; mask; mask >>= 3, from += 3) {
+			if ((mask & 7) == 7) {
+				*to++ = from[0];
+				*to++ = from[1];
+				*to++ = intel_pt_lbr_flags(from[2]);
+				br_stack->nr += 1;
+			}
+		}
+	}
+}
+
+/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
+#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3)
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1694,6 +1746,26 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 		intel_pt_add_xmm(&sample.intr_regs, pos, items, regs_mask);
 	}
 
+	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+		struct {
+			struct branch_stack br_stack;
+			struct branch_entry entries[LBRS_MAX];
+		} br;
+
+		if (items->mask[INTEL_PT_LBR_0_POS] ||
+		    items->mask[INTEL_PT_LBR_1_POS] ||
+		    items->mask[INTEL_PT_LBR_2_POS]) {
+			intel_pt_add_lbrs(&br.br_stack, items);
+			sample.branch_stack = &br.br_stack;
+		} else if (pt->synth_opts.last_branch) {
+			intel_pt_copy_last_branch_rb(ptq);
+			sample.branch_stack = ptq->last_branch;
+		} else {
+			br.br_stack.nr = 0;
+			sample.branch_stack = &br.br_stack;
+		}
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.20.1
