From: Yuanfang Chen <cheny@udel.edu>
Subject: [PATCH] perf/x86/intel: Make L1D_PEND_MISS.FB_FULL not constrained on Haswell
Date: Tue, 24 Nov 2015 12:05:01 -0500
Message-ID: <1448384701-9110-1-git-send-email-cheny@udel.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, peterz@infradead.org
Cc: linux-perf-users@vger.kernel.org, Yuanfang Chen <cheny@udel.edu>
List-Id: linux-perf-users.vger.kernel.org

Signed-off-by: Yuanfang Chen <cheny@udel.edu>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/kernel/cpu/perf_event_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/perf_event_intel.c b/arch/x86/kernel/cpu/perf_event_intel.c
index 61f2577..33b4b67 100644
--- a/arch/x86/kernel/cpu/perf_event_intel.c
+++ b/arch/x86/kernel/cpu/perf_event_intel.c
@@ -232,7 +232,7 @@ static struct event_constraint intel_hsw_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
 	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* CPU_CLK_UNHALTED.REF */
-	INTEL_EVENT_CONSTRAINT(0x48, 0x4), /* L1D_PEND_MISS.* */
+	INTEL_UEVENT_CONSTRAINT(0x148, 0x4),	/* L1D_PEND_MISS.PENDING */
 	INTEL_UEVENT_CONSTRAINT(0x01c0, 0x2), /* INST_RETIRED.PREC_DIST */
 	INTEL_EVENT_CONSTRAINT(0xcd, 0x8), /* MEM_TRANS_RETIRED.LOAD_LATENCY */
 	/* CYCLE_ACTIVITY.CYCLES_L1D_PENDING */
-- 
1.9.1
