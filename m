Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648383BB68B;
	Fri, 29 May 2026 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041861; cv=none; b=FBUArZpgVijUDzVRAUqn0EfS+33jgu6D51b/03KQK6lZjeJYram42S6mAza+YgvSKAt3tqzOc3Gc/PBBHQGitE/FdMuhxhJjZGGXe9W253JNdFm2vJFNezFJKOb/8p1Qo4W4goAjCOuTs+bCjQVLPTsHtE4fsknoM2TZyFRGRVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041861; c=relaxed/simple;
	bh=WZ1HBHoN2EzGxfxaKEd2JQqxxNX25CUAJ680lUlOWO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EAjxe7Ue2YjL3lfmx4UWD6APebbCxLKD48tDhrH9sg+bBkztUaQZT6vyFKFiOd9kUPmp225g5+aYUFfEV5NO+5ThQ33AunXTw661KNdkYdoeJ+tvsc64mLY0k/h4935qgturl4kBVMpdeEAtSy1efLostjwRQXdYi1w7RWPZu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F0Htizk2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F0Htizk2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041859; x=1811577859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WZ1HBHoN2EzGxfxaKEd2JQqxxNX25CUAJ680lUlOWO0=;
  b=F0Htizk2c6q7W2sOvD3dr1XEO2odRzVLXFr41jWJq47roetTa0gntPNV
   SDJtaUWFCeu33l/2WDvB3X9Wp1zDwDRoRPN7BeIxRS053/b7lRy4kp+d+
   NXmxYd+ScK96EFfRdWQB+yOC6BinnFAcNb1unWt/wAQeEDCMieHfo4uGl
   ITgHqNR31ZbgHqc3IeNPGc+bP8K41Pu34JPYRfkmZmqI4fUqh0aEEFk8S
   qayWv4hYRsk1dg9DC0y7nblC0ynnWC2dkKQ0vSRxFwdlzJ4xTng9AHKZW
   LeeJn8IC1Fws92CK9uY0nqhMGRPLbaiYT0bL9krJWpVzrLKbfvltquWRF
   A==;
X-CSE-ConnectionGUID: 2ZeNfhGQRhqerZs3+3Yd+g==
X-CSE-MsgGUID: h6WriYtwRyqXBHkjmAzw6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342167"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342167"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:19 -0700
X-CSE-ConnectionGUID: xYYbCsoLSo6L+ZVCxU4r4g==
X-CSE-MsgGUID: 8tIGK3raTm6NQ4MW3zva7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802535"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:04:14 -0700
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
Subject: [Patch v8 20/23] perf/x86/intel: Support arch-PEBS based SIMD/eGPRs/SSP sampling
Date: Fri, 29 May 2026 15:56:42 +0800
Message-Id: <20260529075645.580362-21-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch supports arch-PEBS based SIMD/eGPRs/SSP registers sampling.

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

Please note arch-PEBS based SIMD/eGPRs/SSP sampling is not enabled yet,
it will be enabled in a later patch when PERF_PMU_CAP_SIMD_REGS is set.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 121 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c        |  77 +++++++++++++++++--
 arch/x86/include/asm/msr-index.h  |   7 ++
 arch/x86/include/asm/perf_event.h |   8 +-
 4 files changed, 199 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index a2473f962681..679781519f8c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3473,6 +3473,21 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
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
 
@@ -4695,21 +4710,113 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
+static inline bool intel_pebs_support_regs(struct perf_event *event, u64 regs)
+{
+	struct arch_pebs_cap cap = hybrid(event->pmu, arch_pebs_cap);
+	int pebs_format = x86_pmu.intel_cap.pebs_format;
+	bool supported = true;
+
+	if (regs & PEBS_DATACFG_GP) {
+		/* Legacy PEBS always supports GPRs sampling. */
+		supported &= x86_pmu.arch_pebs ?
+			     !!(ARCH_PEBS_GPR & cap.caps) : true;
+	}
+	if (regs & PEBS_DATACFG_XMMS) {
+		supported &= x86_pmu.arch_pebs ?
+			     !!(ARCH_PEBS_VECR_XMM & cap.caps) :
+			     pebs_format > 3 && x86_pmu.intel_cap.pebs_baseline;
+	}
+	/* Legacy PEBS doesn't support OPMASK/YMM+ and eGPRs sampling. */
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
+static bool __regs_support_large_pebs(struct perf_event *event, bool intr)
+{
+	u64 regs = intr ? event->attr.sample_regs_intr :
+			  event->attr.sample_regs_user;
+	u64 vec_regs = intr ? event->attr.sample_simd_vec_reg_intr :
+			      event->attr.sample_simd_vec_reg_user;
+	u64 pred_regs = intr ? event->attr.sample_simd_pred_reg_intr :
+			       event->attr.sample_simd_pred_reg_user;
+	u64 xregs_mask = PEBS_GP_REGS | PERF_X86_EGPRS_MASK |
+			 BIT_ULL(PERF_REG_X86_SSP);
+
+	if (regs & ~xregs_mask)
+		return false;
+
+	if ((regs & (PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP))) &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_GP))
+		return false;
+
+	if ((regs & PERF_X86_EGPRS_MASK) &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_EGPRS))
+		return false;
+
+	if (event_needs_opmask(event) && pred_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_OPMASKS))
+		return false;
+
+	if (event_needs_xmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_XMMS))
+		return false;
+
+	if (event_needs_ymm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_YMMHS))
+		return false;
+
+	if (event_needs_low16_zmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_ZMMHS))
+		return false;
+
+	if (event_needs_high16_zmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_H16ZMMS))
+		return false;
+
+	return true;
+}
+
+static inline bool intr_regs_support_large_pebs(struct perf_event *event)
+{
+	return __regs_support_large_pebs(event, /*intr=*/true);
+}
+
+static inline bool user_regs_support_large_pebs(struct perf_event *event)
+{
+	return __regs_support_large_pebs(event, /*intr=*/false);
+}
+
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
-	u64 gprs_mask = event->attr.sample_simd_regs_enabled ?
-			PEBS_GP_REGS :
-			PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~gprs_mask)
-		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~gprs_mask)
-		flags &= ~PERF_SAMPLE_REGS_INTR;
+	if (event->attr.sample_simd_regs_enabled) {
+		if (!user_regs_support_large_pebs(event))
+			flags &= ~PERF_SAMPLE_REGS_USER;
+		if (!intr_regs_support_large_pebs(event))
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	} else {
+		u64 gprs_mask = PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
+
+		if (event->attr.sample_regs_user & ~gprs_mask)
+			flags &= ~PERF_SAMPLE_REGS_USER;
+		if (event->attr.sample_regs_intr & ~gprs_mask)
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	}
 	return flags;
 }
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fb393be13fcb..8a653edce392 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1750,11 +1750,22 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
 		      x86_pmu.rtm_abort_event);
 
-	if (gprs || (attr->precise_ip < 2) || tsx_weight)
+	if (gprs || (attr->precise_ip < 2) ||
+	    tsx_weight || event_needs_ssp(event))
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+	if (x86_pmu.arch_pebs && event_needs_ymm(event))
+		pebs_data_cfg |= PEBS_DATACFG_YMMHS;
+	if (x86_pmu.arch_pebs && event_needs_low16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
+	if (x86_pmu.arch_pebs && event_needs_high16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+	if (x86_pmu.arch_pebs && event_needs_opmask(event))
+		pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+	if (x86_pmu.arch_pebs && event_needs_egprs(event))
+		pebs_data_cfg |= PEBS_DATACFG_EGPRS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
@@ -2713,15 +2724,69 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
index a14a0f43e04a..e3b3293aa87f 100644
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
index 2769ec3030e5..bbbe0835ac55 100644
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

