Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3033C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Nov 2021 20:39:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhK2Umk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:42:40 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38056 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231368AbhK2Ukk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Nov 2021 15:40:40 -0500
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 25A0BC1620;
        Mon, 29 Nov 2021 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1638218242; bh=6ZxhTYsRGp5j9cuTySOH2waK/dfMvJq+e3ruVeOEP2w=;
        h=From:To:Cc:Subject:Date:From;
        b=JCBfWCw1eE1zl431AimqR0UUdoZ1CZXHPO2krSiKi13M7H55Otz7m1xhfibLgjHUO
         OfbKeXUCzul5CznsL7HTcLNmcXU6L8rN6tRZ3kCfj1IPuEK/l4H2cezWZrF5jA/M1i
         bilPtQCvyiev2Y540eOR7AiZL2eCoWsZJLoQFalrDN9k2mqbPvIov/FSayXEfglTyU
         oofTdUAGEL3jZRw5gTdtwCtElBnSP3OEZDH6tZf4XtvVDpujfff3lRYF72G0Ml6emF
         AVMp3h3il4weNTy75pMVfjyZoW1yevqqpRfbKQRnrQsX0Jrz74tFI9mFYSNWAj8rpM
         gG7jzieU6WBTQ==
Received: from us01odcres-abrodkin-0009.internal.synopsys.com (us01odcres-abrodkin-0009.sg.us01-p01.synopsys.com [10.195.24.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id A42ECA0063;
        Mon, 29 Nov 2021 20:37:17 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-perf-users@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mischa Jonker <Mischa.Jonker@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH] arc: perf: Move static structs to where they're really used
Date:   Mon, 29 Nov 2021 12:37:07 -0800
Message-Id: <20211129203707.28510-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

It is all well described by Stephen Rothwell who initially spotted that:
----------------------------->8----------------------------
After merging the origin tree, today's linux-next build (arc
haps_hs_smp_defconfig+kselftest) produced these warnings:

arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]

Introduced by commit 0dd450fe13da ("ARC: Add perf support for ARC700 cores")

The 2 static arrays should be moved into arch/arc/kernel/perf_event.c
(the only place that uses them). We get the warning because perf_event.h
is also included by arch/arc/kernel/unaligned.c.
----------------------------->8----------------------------

Could be easily reproduced by running make with "W=1" on any up-to-date
sources, when extra warnings get enabled (in particular
"-Wunused-const-variable"), otherwise disabled by default in the top-level
Makefile as "These warnings generated too much noise in a regular build".

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Mischa Jonker <mjonker@synopsys.com>
Cc: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/include/asm/perf_event.h | 162 --------------------------------------
 arch/arc/kernel/perf_event.c      | 162 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 162 insertions(+), 162 deletions(-)

diff --git a/arch/arc/include/asm/perf_event.h b/arch/arc/include/asm/perf_event.h
index e1971d34ef30..4c919c0f4b30 100644
--- a/arch/arc/include/asm/perf_event.h
+++ b/arch/arc/include/asm/perf_event.h
@@ -63,166 +63,4 @@ struct arc_reg_cc_build {
 
 #define PERF_COUNT_ARC_HW_MAX	(PERF_COUNT_HW_MAX + 8)
 
-/*
- * Some ARC pct quirks:
- *
- * PERF_COUNT_HW_STALLED_CYCLES_BACKEND
- * PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
- *	The ARC 700 can either measure stalls per pipeline stage, or all stalls
- *	combined; for now we assign all stalls to STALLED_CYCLES_BACKEND
- *	and all pipeline flushes (e.g. caused by mispredicts, etc.) to
- *	STALLED_CYCLES_FRONTEND.
- *
- *	We could start multiple performance counters and combine everything
- *	afterwards, but that makes it complicated.
- *
- *	Note that I$ cache misses aren't counted by either of the two!
- */
-
-/*
- * ARC PCT has hardware conditions with fixed "names" but variable "indexes"
- * (based on a specific RTL build)
- * Below is the static map between perf generic/arc specific event_id and
- * h/w condition names.
- * At the time of probe, we loop thru each index and find it's name to
- * complete the mapping of perf event_id to h/w index as latter is needed
- * to program the counter really
- */
-static const char * const arc_pmu_ev_hw_map[] = {
-	/* count cycles */
-	[PERF_COUNT_HW_CPU_CYCLES] = "crun",
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = "crun",
-	[PERF_COUNT_HW_BUS_CYCLES] = "crun",
-
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = "bflush",
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = "bstall",
-
-	/* counts condition */
-	[PERF_COUNT_HW_INSTRUCTIONS] = "iall",
-	/* All jump instructions that are taken */
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmptak",
-#ifdef CONFIG_ISA_ARCV2
-	[PERF_COUNT_HW_BRANCH_MISSES] = "bpmp",
-#else
-	[PERF_COUNT_ARC_BPOK]         = "bpok",	  /* NP-NT, PT-T, PNT-NT */
-	[PERF_COUNT_HW_BRANCH_MISSES] = "bpfail", /* NP-T, PT-NT, PNT-T */
-#endif
-	[PERF_COUNT_ARC_LDC] = "imemrdc",	/* Instr: mem read cached */
-	[PERF_COUNT_ARC_STC] = "imemwrc",	/* Instr: mem write cached */
-
-	[PERF_COUNT_ARC_DCLM] = "dclm",		/* D-cache Load Miss */
-	[PERF_COUNT_ARC_DCSM] = "dcsm",		/* D-cache Store Miss */
-	[PERF_COUNT_ARC_ICM] = "icm",		/* I-cache Miss */
-	[PERF_COUNT_ARC_EDTLB] = "edtlb",	/* D-TLB Miss */
-	[PERF_COUNT_ARC_EITLB] = "eitlb",	/* I-TLB Miss */
-
-	[PERF_COUNT_HW_CACHE_REFERENCES] = "imemrdc",	/* Instr: mem read cached */
-	[PERF_COUNT_HW_CACHE_MISSES] = "dclm",		/* D-cache Load Miss */
-};
-
-#define C(_x)			PERF_COUNT_HW_CACHE_##_x
-#define CACHE_OP_UNSUPPORTED	0xffff
-
-static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
-	[C(L1D)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_LDC,
-			[C(RESULT_MISS)]	= PERF_COUNT_ARC_DCLM,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_STC,
-			[C(RESULT_MISS)]	= PERF_COUNT_ARC_DCSM,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(L1I)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= PERF_COUNT_HW_INSTRUCTIONS,
-			[C(RESULT_MISS)]	= PERF_COUNT_ARC_ICM,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(LL)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(DTLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_LDC,
-			[C(RESULT_MISS)]	= PERF_COUNT_ARC_EDTLB,
-		},
-			/* DTLB LD/ST Miss not segregated by h/w*/
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(ITLB)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= PERF_COUNT_ARC_EITLB,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(BPU)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)] = PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
-			[C(RESULT_MISS)]	= PERF_COUNT_HW_BRANCH_MISSES,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-	[C(NODE)] = {
-		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
-			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
-		},
-	},
-};
-
 #endif /* __ASM_PERF_EVENT_H */
diff --git a/arch/arc/kernel/perf_event.c b/arch/arc/kernel/perf_event.c
index 145722f80c9b..07c93ce67774 100644
--- a/arch/arc/kernel/perf_event.c
+++ b/arch/arc/kernel/perf_event.c
@@ -17,6 +17,168 @@
 /* HW holds 8 symbols + one for null terminator */
 #define ARCPMU_EVENT_NAME_LEN	9
 
+/*
+ * Some ARC pct quirks:
+ *
+ * PERF_COUNT_HW_STALLED_CYCLES_BACKEND
+ * PERF_COUNT_HW_STALLED_CYCLES_FRONTEND
+ *	The ARC 700 can either measure stalls per pipeline stage, or all stalls
+ *	combined; for now we assign all stalls to STALLED_CYCLES_BACKEND
+ *	and all pipeline flushes (e.g. caused by mispredicts, etc.) to
+ *	STALLED_CYCLES_FRONTEND.
+ *
+ *	We could start multiple performance counters and combine everything
+ *	afterwards, but that makes it complicated.
+ *
+ *	Note that I$ cache misses aren't counted by either of the two!
+ */
+
+/*
+ * ARC PCT has hardware conditions with fixed "names" but variable "indexes"
+ * (based on a specific RTL build)
+ * Below is the static map between perf generic/arc specific event_id and
+ * h/w condition names.
+ * At the time of probe, we loop thru each index and find it's name to
+ * complete the mapping of perf event_id to h/w index as latter is needed
+ * to program the counter really
+ */
+static const char * const arc_pmu_ev_hw_map[] = {
+	/* count cycles */
+	[PERF_COUNT_HW_CPU_CYCLES] = "crun",
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = "crun",
+	[PERF_COUNT_HW_BUS_CYCLES] = "crun",
+
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = "bflush",
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = "bstall",
+
+	/* counts condition */
+	[PERF_COUNT_HW_INSTRUCTIONS] = "iall",
+	/* All jump instructions that are taken */
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = "ijmptak",
+#ifdef CONFIG_ISA_ARCV2
+	[PERF_COUNT_HW_BRANCH_MISSES] = "bpmp",
+#else
+	[PERF_COUNT_ARC_BPOK]         = "bpok",	  /* NP-NT, PT-T, PNT-NT */
+	[PERF_COUNT_HW_BRANCH_MISSES] = "bpfail", /* NP-T, PT-NT, PNT-T */
+#endif
+	[PERF_COUNT_ARC_LDC] = "imemrdc",	/* Instr: mem read cached */
+	[PERF_COUNT_ARC_STC] = "imemwrc",	/* Instr: mem write cached */
+
+	[PERF_COUNT_ARC_DCLM] = "dclm",		/* D-cache Load Miss */
+	[PERF_COUNT_ARC_DCSM] = "dcsm",		/* D-cache Store Miss */
+	[PERF_COUNT_ARC_ICM] = "icm",		/* I-cache Miss */
+	[PERF_COUNT_ARC_EDTLB] = "edtlb",	/* D-TLB Miss */
+	[PERF_COUNT_ARC_EITLB] = "eitlb",	/* I-TLB Miss */
+
+	[PERF_COUNT_HW_CACHE_REFERENCES] = "imemrdc",	/* Instr: mem read cached */
+	[PERF_COUNT_HW_CACHE_MISSES] = "dclm",		/* D-cache Load Miss */
+};
+
+#define C(_x)			PERF_COUNT_HW_CACHE_##_x
+#define CACHE_OP_UNSUPPORTED	0xffff
+
+static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
+	[C(L1D)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_LDC,
+			[C(RESULT_MISS)]	= PERF_COUNT_ARC_DCLM,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_STC,
+			[C(RESULT_MISS)]	= PERF_COUNT_ARC_DCSM,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(L1I)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= PERF_COUNT_HW_INSTRUCTIONS,
+			[C(RESULT_MISS)]	= PERF_COUNT_ARC_ICM,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(DTLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= PERF_COUNT_ARC_LDC,
+			[C(RESULT_MISS)]	= PERF_COUNT_ARC_EDTLB,
+		},
+			/* DTLB LD/ST Miss not segregated by h/w*/
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(ITLB)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= PERF_COUNT_ARC_EITLB,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(BPU)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)] = PERF_COUNT_HW_BRANCH_INSTRUCTIONS,
+			[C(RESULT_MISS)]	= PERF_COUNT_HW_BRANCH_MISSES,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+	[C(NODE)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= CACHE_OP_UNSUPPORTED,
+			[C(RESULT_MISS)]	= CACHE_OP_UNSUPPORTED,
+		},
+	},
+};
+
 enum arc_pmu_attr_groups {
 	ARCPMU_ATTR_GR_EVENTS,
 	ARCPMU_ATTR_GR_FORMATS,
-- 
2.16.2

