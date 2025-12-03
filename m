Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E962BDC0C;
	Wed,  3 Dec 2025 06:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745160; cv=none; b=ete63sUiqZ5sQIn/7BaU2mOicvDICsxOcABT822/CwhDjafioYaw97UjtXhuTxFh2FDt2btfa+4JzyIs4W2fmfhMh+b3E7who7ctulvEA5MNVW/qrOJGLDYULhuNmRYKy72JJmWKzILTQK4PrgghL/cDb9buyTY7AZjwGRGPsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745160; c=relaxed/simple;
	bh=yQIVHyWq+rfqSCxN0Vb6rsLLcDoEQHDLR5H2ydDIFbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiYT9/JN250uv4hGVzb6IHUZO3XJG5LacYFBjNcKAZtbJSxeJTkAUVe3DzL1cCKGyIONErZG5UWUvawD/Y23XT6vQtjmNgNpSiRxKgNZKa+y6/abL+vfMn6SiWOySc186uD2NseByU0jMTw2jmL+yoT2K22S+4wND/XV0W3QeDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TBnZvJRT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TBnZvJRT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745158; x=1796281158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yQIVHyWq+rfqSCxN0Vb6rsLLcDoEQHDLR5H2ydDIFbw=;
  b=TBnZvJRTEJi0k58CCGtF8UIARGa5VxsBTpuQpS1dtsx7BbkDi0lEj728
   Nl1Hm3phBNPvx38XC8/swXyzROQUndnBl723DchjJhwPlk0u4wP50FGiZ
   zteSYb8W5XgBsCINxPyqkkpa7QrdpsbuUw9Ev2csvUW3whmMwYHYsQql4
   0JWB7ghWyQ4I0nBvBx0i3ubQ58dLG7A8M/V5DN3LvUC5TNI/XuumPCn4n
   7eTDv5k778w72/sGg9sKZgpLdFDBFSFf91Y65XY1xJrD1y/8aMIXdnZKq
   yLX3x40Lmoh0sAPq6jcWXpQI6PtxMKGJuPfpgpP+Ydf++ySB0K1zDUwUz
   g==;
X-CSE-ConnectionGUID: znRRxnbfT8uaFkiuedwCNw==
X-CSE-MsgGUID: r+YUpa4SRjiPXY8IztpKVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324912"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324912"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:18 -0800
X-CSE-ConnectionGUID: QvWXJJwiR8K2DoHGJBRv9A==
X-CSE-MsgGUID: tMxiLfCPS9i8QcJnyQpkHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199004017"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:59:13 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v5 15/19] perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling
Date: Wed,  3 Dec 2025 14:54:56 +0800
Message-Id: <20251203065500.2597594-16-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables arch-PEBS based SIMD/eGPRs/SSP registers sampling.

Arch-PEBS supports sampling of these registers, with all except SSP
placed into the XSAVE-Enabled Registers (XER) group with the layout
described below.

Field Name 	Registers Used 			Size
----------------------------------------------------------------------
XSTATE_BV	XINUSE for groups		8 B
----------------------------------------------------------------------
Reserved 	Reserved 			8 B
----------------------------------------------------------------------
SSER 		XMM0-XMM15 			16 regs * 16 B = 256 B
----------------------------------------------------------------------
YMMHIR 		Upper 128 bits of YMM0-YMM15 	16 regs * 16 B = 256 B
----------------------------------------------------------------------
EGPR 		R16-R31 			16 regs * 8 B = 128 B
----------------------------------------------------------------------
OPMASKR 	K0-K7 				8 regs * 8 B = 64 B
----------------------------------------------------------------------
ZMMHIR 		Upper 256 bits of ZMM0-ZMM15 	16 regs * 32 B = 512 B
----------------------------------------------------------------------
Hi16ZMMR 	ZMM16-ZMM31 			16 regs * 64 B = 1024 B
----------------------------------------------------------------------

Memory space in the output buffer is allocated for these sub-groups as
long as the corresponding Format.XER[55:49] bits in the PEBS record
header are set. However, the arch-PEBS hardware engine does not write
the sub-group if it is not used (in INIT state). In such cases, the
corresponding bit in the XSTATE_BV bitmap is set to 0. Therefore, the
XSTATE_BV field is checked to determine if the register data is actually
written for each PEBS record. If not, the register data is not outputted
to userspace.

The SSP register is sampled and placed into the GPRs group by arch-PEBS.

Additionally, the MSRs IA32_PMC_{GPn|FXm}_CFG_C.[55:49] bits are used to
manage which types of these registers need to be sampled.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 71 +++++++++++++++++++++--------
 arch/x86/events/intel/ds.c        | 76 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  7 +++
 arch/x86/include/asm/perf_event.h |  8 +++-
 4 files changed, 137 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d8cc7abfcdc6..da48bcde8fce 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3008,6 +3008,21 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
 
+			if (pebs_data_cfg & PEBS_DATACFG_YMMHS)
+				ext |= ARCH_PEBS_VECR_YMMH & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_EGPRS)
+				ext |= ARCH_PEBS_VECR_EGPRS & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_OPMASKS)
+				ext |= ARCH_PEBS_VECR_OPMASK & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_ZMMHS)
+				ext |= ARCH_PEBS_VECR_ZMMH & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_H16ZMMS)
+				ext |= ARCH_PEBS_VECR_H16ZMM & cap.caps;
+
 			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 				ext |= ARCH_PEBS_LBR & cap.caps;
 
@@ -4152,6 +4167,30 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
+static inline bool intel_pebs_support_regs(struct perf_event *event, u64 regs)
+{
+	struct arch_pebs_cap cap = hybrid(event->pmu, arch_pebs_cap);
+	bool supported = true;
+
+	/* SSP */
+	if (regs & PEBS_DATACFG_GP)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_GPR & cap.caps);
+	if (regs & PEBS_DATACFG_XMMS)
+		supported &= x86_pmu.intel_cap.pebs_format > 3;
+	if (regs & PEBS_DATACFG_YMMHS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_YMMH & cap.caps);
+	if (regs & PEBS_DATACFG_EGPRS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_EGPRS & cap.caps);
+	if (regs & PEBS_DATACFG_OPMASKS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_OPMASK & cap.caps);
+	if (regs & PEBS_DATACFG_ZMMHS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_ZMMH & cap.caps);
+	if (regs & PEBS_DATACFG_H16ZMMS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_H16ZMM & cap.caps);
+
+	return supported;
+}
+
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
@@ -4161,24 +4200,20 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
 	if (event->attr.sample_simd_regs_enabled) {
-		u64 nolarge = PERF_X86_EGPRS_MASK | BIT_ULL(PERF_REG_X86_SSP);
-
-		/*
-		 * PEBS HW can only collect the XMM0-XMM15 for now.
-		 * Disable large PEBS for other vector registers, predicate
-		 * registers, eGPRs, and SSP.
-		 */
-		if (event->attr.sample_regs_user & nolarge ||
-		    fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE ||
-		    event->attr.sample_simd_pred_reg_user)
-			flags &= ~PERF_SAMPLE_REGS_USER;
-
-		if (event->attr.sample_regs_intr & nolarge ||
-		    fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
-		    event->attr.sample_simd_pred_reg_intr)
-			flags &= ~PERF_SAMPLE_REGS_INTR;
-
-		if (event->attr.sample_simd_vec_reg_qwords > PERF_X86_XMM_QWORDS)
+		if ((event_needs_ssp(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_GP)) ||
+		    (event_needs_xmm(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_XMMS)) ||
+		    (event_needs_ymm(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_YMMHS)) ||
+		    (event_needs_egprs(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_EGPRS)) ||
+		    (event_needs_opmask(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_OPMASKS)) ||
+		    (event_needs_low16_zmm(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_ZMMHS)) ||
+		    (event_needs_high16_zmm(event) &&
+		     !intel_pebs_support_regs(event, PEBS_DATACFG_H16ZMMS)))
 			flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
 	} else {
 		if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3212259d1a16..a01c72c03bd6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1470,11 +1470,21 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
 		      x86_pmu.rtm_abort_event);
 
-	if (gprs || (attr->precise_ip < 2) || tsx_weight)
+	if (gprs || (attr->precise_ip < 2) || tsx_weight || event_needs_ssp(event))
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+	if (event_needs_ymm(event))
+		pebs_data_cfg |= PEBS_DATACFG_YMMHS;
+	if (event_needs_low16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
+	if (event_needs_high16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+	if (event_needs_opmask(event))
+		pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+	if (event_needs_egprs(event))
+		pebs_data_cfg |= PEBS_DATACFG_EGPRS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
@@ -2430,15 +2440,69 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 					   meminfo->tsx_tuning, ax);
 	}
 
-	if (header->xmm) {
+	if (header->xmm || header->ymmh || header->egpr ||
+	    header->opmask || header->zmmh || header->h16zmm) {
+		struct arch_pebs_xer_header *xer_header = next_record;
 		struct pebs_xmm *xmm;
+		struct ymmh_struct *ymmh;
+		struct avx_512_zmm_uppers_state *zmmh;
+		struct avx_512_hi16_state *h16zmm;
+		struct avx_512_opmask_state *opmask;
+		struct apx_state *egpr;
 
 		next_record += sizeof(struct arch_pebs_xer_header);
 
-		ignore_mask |= XFEATURE_MASK_SSE;
-		xmm = next_record;
-		perf_regs->xmm_regs = xmm->xmm;
-		next_record = xmm + 1;
+		if (header->xmm) {
+			ignore_mask |= XFEATURE_MASK_SSE;
+			xmm = next_record;
+			/*
+			 * Only output XMM regs to user space when arch-PEBS
+			 * really writes data into xstate area.
+			 */
+			if (xer_header->xstate & XFEATURE_MASK_SSE)
+				perf_regs->xmm_regs = xmm->xmm;
+			next_record = xmm + 1;
+		}
+
+		if (header->ymmh) {
+			ignore_mask |= XFEATURE_MASK_YMM;
+			ymmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_YMM)
+				perf_regs->ymmh = ymmh;
+			next_record = ymmh + 1;
+		}
+
+		if (header->egpr) {
+			ignore_mask |= XFEATURE_MASK_APX;
+			egpr = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_APX)
+				perf_regs->egpr = egpr;
+			next_record = egpr + 1;
+		}
+
+		if (header->opmask) {
+			ignore_mask |= XFEATURE_MASK_OPMASK;
+			opmask = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_OPMASK)
+				perf_regs->opmask = opmask;
+			next_record = opmask + 1;
+		}
+
+		if (header->zmmh) {
+			ignore_mask |= XFEATURE_MASK_ZMM_Hi256;
+			zmmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_ZMM_Hi256)
+				perf_regs->zmmh = zmmh;
+			next_record = zmmh + 1;
+		}
+
+		if (header->h16zmm) {
+			ignore_mask |= XFEATURE_MASK_Hi16_ZMM;
+			h16zmm = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_Hi16_ZMM)
+				perf_regs->h16zmm = h16zmm;
+			next_record = h16zmm + 1;
+		}
 	}
 
 	if (header->lbr) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 65cc528fbad8..3f1cc294b1e9 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -341,6 +341,13 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
+#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
+#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
+#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
+#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
+#define ARCH_PEBS_VECR_EXT_SHIFT	50
+#define ARCH_PEBS_VECR_EXT		(0x3full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index c925af4160ad..41668a4633df 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -146,6 +146,11 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
 #define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_YMMHS	BIT_ULL(6)
+#define PEBS_DATACFG_OPMASKS	BIT_ULL(7)
+#define PEBS_DATACFG_ZMMHS	BIT_ULL(8)
+#define PEBS_DATACFG_H16ZMMS	BIT_ULL(9)
+#define PEBS_DATACFG_EGPRS	BIT_ULL(10)
 #define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
@@ -540,7 +545,8 @@ struct arch_pebs_header {
 			    rsvd3:7,
 			    xmm:1,
 			    ymmh:1,
-			    rsvd4:2,
+			    egpr:1,
+			    rsvd4:1,
 			    opmask:1,
 			    zmmh:1,
 			    h16zmm:1,
-- 
2.34.1

