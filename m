From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 10/25] perf intel-pt: Add XMM registers to synthesized PEBS sample
Date: Fri, 21 Jun 2019 14:38:16 -0300
Message-ID: <20190621173831.13780-11-acme@kernel.org>
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

Add XMM register information from PEBS data in the Intel PT trace to the
synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 00c2c96bb805..f83dd10bb7d0 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1603,6 +1603,31 @@ static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
 	return pos;
 }
 
+#ifndef PERF_REG_X86_XMM0
+#define PERF_REG_X86_XMM0 32
+#endif
+
+static void intel_pt_add_xmm(struct regs_dump *intr_regs, u64 *pos,
+			     const struct intel_pt_blk_items *items,
+			     u64 regs_mask)
+{
+	u32 mask = items->has_xmm & (regs_mask >> PERF_REG_X86_XMM0);
+	const u64 *xmm = items->xmm;
+
+	/*
+	 * If there are any XMM registers, then there should be all of them.
+	 * Nevertheless, follow the logic to add only registers that were
+	 * requested (i.e. 'regs_mask') and that were provided (i.e. 'mask'),
+	 * and update the resulting mask (i.e. 'intr_regs->mask') accordingly.
+	 */
+	intr_regs->mask |= (u64)mask << PERF_REG_X86_XMM0;
+
+	for (; mask; mask >>= 1, xmm++) {
+		if (mask & 1)
+			*pos++ = *xmm;
+	}
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1657,13 +1682,16 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 	    items->mask[INTEL_PT_GP_REGS_POS]) {
 		u64 regs[sizeof(sample.intr_regs.mask)];
 		u64 regs_mask = evsel->attr.sample_regs_intr;
+		u64 *pos;
 
 		sample.intr_regs.abi = items->is_32_bit ?
 				       PERF_SAMPLE_REGS_ABI_32 :
 				       PERF_SAMPLE_REGS_ABI_64;
 		sample.intr_regs.regs = regs;
 
-		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+		pos = intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+
+		intel_pt_add_xmm(&sample.intr_regs, pos, items, regs_mask);
 	}
 
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
-- 
2.20.1
