Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F91A681A;
	Tue, 24 Mar 2026 00:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313258; cv=none; b=babchKJRPXigyg4x63Elfb18JuP6LJyE6cM6BXPGSiUFBOZlGgtl8BxFbGHLMB6NG8NCVmsZ/6HoncjiufZihhu6SXdwvSFFddOTLHMFPWBJe723OhoXEwGA+/R0GeIECqjFQGvaiRqwRD2srFHlZBhqtS8RgntnPLyWXylEFLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313258; c=relaxed/simple;
	bh=+TVpe+C1qqKgkjupJ92EWRpzHCu3FZPt8miWHwqHMYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PsQ1L2pDkTCw3LWs61bL2zZNEzi3tfVfMdmct92xmt8i6w101NOFtoHR41/YZSpzcJfHwG0+s7uT6AxnafnoUVDrwEvM0nI7rpvZw7oJLMDh0LuJ3Dl2/YMAIM3AIZvedmfjG+9VjItRddVTUG9bDGROmNl9qBilSmtQyhW0aC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEsVI5iD; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEsVI5iD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313255; x=1805849255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+TVpe+C1qqKgkjupJ92EWRpzHCu3FZPt8miWHwqHMYE=;
  b=kEsVI5iD2Wqb64QVI7qeOXvgZwQyIP+Ct8GOrLXu6AFg1LkoKftXIS4w
   qlaE6JCgrCQw7dC8Oun8N02aoxbJ8FhOSKUM04HXdEFOjdh4YIL1vIl1T
   Ew2CBHsgVrwBD4MvOdcBKa5sPdG8YIIs+3GOduk92XFGuKviAh2m4cg09
   zSxVYuH6TgXjUfwM8tWLJkKcGVu3SQ7Jol4hS0rvydb7wiUK7XJEKhHKq
   iXnZMzobMb848Lr2cL3ZAMCVY/0+jkqIMuuLR4/JTaJKBDxCj7W+b1Gs0
   ek2wOsTlYX67hVTZe5U536bgQ64ImROL3Xfx5KwQRc1G5s/g+7s4e+p5U
   g==;
X-CSE-ConnectionGUID: og2fgQGlSjOhn6jRIRdFHA==
X-CSE-MsgGUID: QR7PAEU6TUqUeFUpLAgG3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397292"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397292"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:35 -0700
X-CSE-ConnectionGUID: tuT1evskTP2vzN7aMCIOqQ==
X-CSE-MsgGUID: gW6HBIXhSSS57PYxWf2Bxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322990"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:31 -0700
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
Subject: [Patch v7 22/24] perf/x86/intel: Enable arch-PEBS based SIMD/eGPRs/SSP sampling
Date: Tue, 24 Mar 2026 08:41:16 +0800
Message-Id: <20260324004118.3772171-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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

XSTATE_BV	XINUSE for groups		8 B
Reserved 	Reserved 			8 B
SSER 		XMM0-XMM15 			16 regs * 16 B = 256 B
YMMHIR 		Upper 128 bits of YMM0-YMM15 	16 regs * 16 B = 256 B
EGPR 		R16-R31 			16 regs *  8 B = 128 B
OPMASKR 	K0-K7 				 8 regs *  8 B = 64 B
ZMMHIR 		Upper 256 bits of ZMM0-ZMM15 	16 regs * 32 B = 512 B
Hi16ZMMR 	ZMM16-ZMM31 			16 regs * 64 B = 1024 B

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
 arch/x86/events/intel/core.c      | 75 ++++++++++++++++++++++--------
 arch/x86/events/intel/ds.c        | 77 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  7 +++
 arch/x86/include/asm/perf_event.h |  8 +++-
 4 files changed, 142 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0a32a0367647..e0dd57906bca 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3221,6 +3221,21 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
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
 
@@ -4416,6 +4431,34 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
+static inline bool intel_pebs_support_regs(struct perf_event *event, u64 regs)
+{
+	struct arch_pebs_cap cap = hybrid(event->pmu, arch_pebs_cap);
+	int pebs_format = x86_pmu.intel_cap.pebs_format;
+	bool supported = true;
+
+	/* SSP */
+	if (regs & PEBS_DATACFG_GP)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_GPR & cap.caps);
+	if (regs & PEBS_DATACFG_XMMS) {
+		supported &= x86_pmu.arch_pebs ?
+			     ARCH_PEBS_VECR_XMM & cap.caps :
+			     pebs_format > 3 && x86_pmu.intel_cap.pebs_baseline;
+	}
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
@@ -4425,24 +4468,20 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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
index 3a2fb623e0ab..4743bdfb4ed4 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1740,11 +1740,22 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
 		      x86_pmu.rtm_abort_event);
 
-	if (gprs || (attr->precise_ip < 2) || tsx_weight)
+	if (gprs || (attr->precise_ip < 2) ||
+	    tsx_weight || event_needs_ssp(event))
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
@@ -2705,15 +2716,69 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
index e25434d21159..4fe796993c97 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -350,6 +350,13 @@
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
index 0c6d58e6c98f..db8bba43401c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -148,6 +148,11 @@
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
@@ -545,7 +550,8 @@ struct arch_pebs_header {
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

