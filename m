From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 09/25] perf intel-pt: Add gp registers to synthesized PEBS sample
Date: Fri, 21 Jun 2019 14:38:15 -0300
Message-ID: <20190621173831.13780-10-acme@kernel.org>
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

Add general purpose register information from PEBS data in the Intel PT
trace to the synthesized PEBS sample.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190610072803.10456-8-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-pt.c | 69 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 979519b00a74..00c2c96bb805 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -35,6 +35,8 @@
 #include "config.h"
 #include "time-utils.h"
 
+#include "../arch/x86/include/uapi/asm/perf_regs.h"
+
 #include "intel-pt-decoder/intel-pt-log.h"
 #include "intel-pt-decoder/intel-pt-decoder.h"
 #include "intel-pt-decoder/intel-pt-insn-decoder.h"
@@ -1547,6 +1549,60 @@ static int intel_pt_synth_pwrx_sample(struct intel_pt_queue *ptq)
 					    pt->pwr_events_sample_type);
 }
 
+/*
+ * PEBS gp_regs array indexes plus 1 so that 0 means not present. Refer
+ * intel_pt_add_gp_regs().
+ */
+static const int pebs_gp_regs[] = {
+	[PERF_REG_X86_FLAGS]	= 1,
+	[PERF_REG_X86_IP]	= 2,
+	[PERF_REG_X86_AX]	= 3,
+	[PERF_REG_X86_CX]	= 4,
+	[PERF_REG_X86_DX]	= 5,
+	[PERF_REG_X86_BX]	= 6,
+	[PERF_REG_X86_SP]	= 7,
+	[PERF_REG_X86_BP]	= 8,
+	[PERF_REG_X86_SI]	= 9,
+	[PERF_REG_X86_DI]	= 10,
+	[PERF_REG_X86_R8]	= 11,
+	[PERF_REG_X86_R9]	= 12,
+	[PERF_REG_X86_R10]	= 13,
+	[PERF_REG_X86_R11]	= 14,
+	[PERF_REG_X86_R12]	= 15,
+	[PERF_REG_X86_R13]	= 16,
+	[PERF_REG_X86_R14]	= 17,
+	[PERF_REG_X86_R15]	= 18,
+};
+
+static u64 *intel_pt_add_gp_regs(struct regs_dump *intr_regs, u64 *pos,
+				 const struct intel_pt_blk_items *items,
+				 u64 regs_mask)
+{
+	const u64 *gp_regs = items->val[INTEL_PT_GP_REGS_POS];
+	u32 mask = items->mask[INTEL_PT_GP_REGS_POS];
+	u32 bit;
+	int i;
+
+	for (i = 0, bit = 1; i < PERF_REG_X86_64_MAX; i++, bit <<= 1) {
+		/* Get the PEBS gp_regs array index */
+		int n = pebs_gp_regs[i] - 1;
+
+		if (n < 0)
+			continue;
+		/*
+		 * Add only registers that were requested (i.e. 'regs_mask') and
+		 * that were provided (i.e. 'mask'), and update the resulting
+		 * mask (i.e. 'intr_regs->mask') accordingly.
+		 */
+		if (mask & 1 << n && regs_mask & bit) {
+			intr_regs->mask |= bit;
+			*pos++ = gp_regs[n];
+		}
+	}
+
+	return pos;
+}
+
 static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 {
 	const struct intel_pt_blk_items *items = &ptq->state->items;
@@ -1597,6 +1653,19 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
 			sample.time = tsc_to_perf_time(timestamp, &pt->tc);
 	}
 
+	if (sample_type & PERF_SAMPLE_REGS_INTR &&
+	    items->mask[INTEL_PT_GP_REGS_POS]) {
+		u64 regs[sizeof(sample.intr_regs.mask)];
+		u64 regs_mask = evsel->attr.sample_regs_intr;
+
+		sample.intr_regs.abi = items->is_32_bit ?
+				       PERF_SAMPLE_REGS_ABI_32 :
+				       PERF_SAMPLE_REGS_ABI_64;
+		sample.intr_regs.regs = regs;
+
+		intel_pt_add_gp_regs(&sample.intr_regs, regs, items, regs_mask);
+	}
+
 	return intel_pt_deliver_synth_event(pt, ptq, event, &sample, sample_type);
 }
 
-- 
2.20.1
