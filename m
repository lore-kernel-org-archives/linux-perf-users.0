Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3933ED132;
	Mon, 24 Aug 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560547; cv=none; b=EMnVsZMlS4oa0nXYXU+7JrH93UpWeQSOiqPpcvk4iipL+sbZwektEPcHAjIFvzXjGw6Ygqy35Zx6qyAoEp6LY9og1UnnO8bBRvGJuhD3K8XgbHradr5GoF90gzeKHHeg4zxBZB8PjtWo8M5Vr+UDaZpXU9pKePGQkSR1FnfpRP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560547; c=relaxed/simple;
	bh=oP4nTR3aY9BycHESfsjGCqMx+CJjoOuyWFS35glzIxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TmsdGvDcB4loIkQlm7hnul9UF31x4y2YHBIS9qTdpOgLRmmsMK9RuQNZ6aNXf+eNaLcxAzjzPQPMbC2wRNSUXJxLE9Rx29tY1pzBH8gVBaoYQ/Vwb65biCIDvlYReaWDVaZXMZ6HKC9rSbMbC07ZQ53RPUQDP5UTArRPavgB1Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rk6iGnXR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rk6iGnXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560545; x=1819096545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oP4nTR3aY9BycHESfsjGCqMx+CJjoOuyWFS35glzIxw=;
  b=Rk6iGnXR4uj/DxCHuzSIihGhH45JflcPrXNjZf50weQiShkOqETHhAc/
   twzbBlIMLvXQnrqun0p5dxg4wuWPbCVRSJnSnfcpNORkJwpKYNEBkICNu
   mV9TY2z+DUIDZX1dyHE5Hfwb6C0pGOtreqC/DjdVV1kkGKtcw/GO0fkoA
   4yauPJa1QeqgrLdqjqR3VkdCFTwhSa8gL6WhMfyI3Ppiocd6fSWbaQ8S3
   p35JZfTA+rxoZjtBXKDMwSlO30zp3OZHWA7tWJ65MOV6USJ97RilmULsm
   2GjlTNN7UgAI6ckM0cp8whe6ra6IVFJk+PP579VTFJITY98eyT8501BHd
   w==;
X-CSE-ConnectionGUID: j2NWz8vwRAG+WLiaePQZ7A==
X-CSE-MsgGUID: dZus/7PXQAaB0QtCGp61RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598885"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598885"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:45 -0700
X-CSE-ConnectionGUID: ty0bNHIPSti3zqbGPQ2O+Q==
X-CSE-MsgGUID: ae8oz0pjSjKQA1zIkjYHjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326680"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:39 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [RESEND Patch v10 18/23] perf/x86: Support eGPRs sampling using sample_regs_* fields
Date: Mon, 24 Aug 2026 16:27:26 +0800
Message-Id: <20260824082731.1013973-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sampling of APX eGPRs (R16 ~ R31) via the sample_regs_* fields.

To sample eGPRs, the sample_simd_regs_enabled field must be set. This
allows the spare space (reclaimed from the original XMM space) in the
sample_regs_* fields to be used for representing eGPRs.

The perf_reg_value() function needs to check if the
PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then determine whether
to output eGPRs or legacy XMM registers to userspace.

The perf_reg_validate() function first checks the simd_enabled argument
to determine if the eGPRs bitmap is represented in sample_regs_* fields.
It then validates the eGPRs bitmap accordingly.

Currently, eGPRs sampling is only supported on the x86_64 architecture, as
APX is only available on x86_64 platforms.

APX eGPRs sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 25 +++++++++++---
 arch/x86/events/intel/core.c          | 10 ++++--
 arch/x86/events/perf_event.h          | 25 ++++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 +++
 arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++
 arch/x86/kernel/perf_regs.c           | 50 +++++++++++++++++----------
 6 files changed, 115 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9bfb1810a9fe..9cd79ac5570e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -642,11 +642,12 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
 		return -EINVAL;
-	/* PEBS does not support YMM/ZMM/OPMASK registers sampling yet. */
+	/* PEBS does not support YMM/ZMM/OPMASK/eGPR registers sampling yet. */
 	if (event_needs_ymm(event) ||
 	    event_needs_low16_zmm(event) ||
 	    event_needs_high16_zmm(event) ||
-	    event_needs_opmask(event))
+	    event_needs_opmask(event) ||
+	    event_needs_egprs(event))
 		return -EINVAL;
 
 	return 0;
@@ -654,10 +655,21 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 
 static int event_simd_regs_validate(struct perf_event *event)
 {
+	u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
+
 	if (!get_ext_regs_buf(raw_smp_processor_id()))
 		return -ENOMEM;
-	/* sample_simd_regs_enabled repurposes legacy XMM reg-mask slots. */
-	if (event_has_extended_regs(event))
+	/*
+	 * The XMM space in the perf_event_x86_regs is reclaimed
+	 * for eGPRs and other general registers.
+	 */
+	if (((event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	     (event->attr.sample_regs_intr & reserved)) ||
+	    ((event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	     (event->attr.sample_regs_user & reserved)))
+		return -EINVAL;
+	if (event_needs_egprs(event) &&
+	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 		return -EINVAL;
 	if (event_needs_xmm(event) &&
 	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
@@ -1841,6 +1853,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
+	perf_regs->egpr_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1864,6 +1877,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 /*
@@ -2040,6 +2055,8 @@ static u64 get_simd_sample_mask(struct perf_event *event, u64 sample_type)
 		mask |= XFEATURE_MASK_Hi16_ZMM;
 	if (__event_needs_opmask(event, sample_type))
 		mask |= XFEATURE_MASK_OPMASK;
+	if (__event_needs_egprs(event, sample_type))
+		mask |= XFEATURE_MASK_APX;
 
 	return mask;
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1f4a61710bbd..8920bb5a231a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4695,15 +4695,19 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
-	u64 gprs_mask = PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
+	u64 gprs_mask = event->attr.sample_simd_regs_enabled ?
+			PEBS_GP_REGS | PERF_X86_EGPRS_MASK :
+			PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~gprs_mask)
+	if ((event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_regs_user & ~gprs_mask))
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~gprs_mask)
+	if ((event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_regs_intr & ~gprs_mask))
 		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e6365438bb3d..899584cdbdd3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -290,6 +290,31 @@ static inline bool event_needs_opmask(struct perf_event *event)
 			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
 }
 
+static inline bool __event_needs_egprs(struct perf_event *event,
+				       u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+
+	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK))
+		return true;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_egprs(struct perf_event *event)
+{
+	return __event_needs_egprs(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 49112e097e99..bc05f8c17464 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -749,6 +749,10 @@ struct x86_perf_regs {
 		u64	*opmask_regs;
 		struct avx_512_opmask_state *opmask;
 	};
+	union {
+		u64	*egpr_regs;
+		struct apx_state *egpr;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 61aec60623f1..977831bd7a9d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -29,9 +29,34 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The eGPRs and XMM have overlaps. Only one can be used
+	 * at a time. The ABI PERF_SAMPLE_REGS_ABI_SIMD is used to
+	 * distinguish which one is used. If PERF_SAMPLE_REGS_ABI_SIMD
+	 * is set, then eGPRs is used, otherwise, XMM is used.
+	 *
+	 * Extended GPRs (eGPRs)
+	 */
+	PERF_REG_X86_R16,
+	PERF_REG_X86_R17,
+	PERF_REG_X86_R18,
+	PERF_REG_X86_R19,
+	PERF_REG_X86_R20,
+	PERF_REG_X86_R21,
+	PERF_REG_X86_R22,
+	PERF_REG_X86_R23,
+	PERF_REG_X86_R24,
+	PERF_REG_X86_R25,
+	PERF_REG_X86_R26,
+	PERF_REG_X86_R27,
+	PERF_REG_X86_R28,
+	PERF_REG_X86_R29,
+	PERF_REG_X86_R30,
+	PERF_REG_X86_R31,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_MISC_MAX = PERF_REG_X86_R31 + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
@@ -56,6 +81,7 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	__GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 494e06501210..7d4233ed859c 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -61,14 +61,24 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
-	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+	if (idx > PERF_REG_X86_R15) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
-		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
-		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+		if (perf_regs->abi == PERF_SAMPLE_REGS_ABI_NONE)
 			return 0;
-		if (!perf_regs->xmm_regs)
-			return 0;
-		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+			if (idx <= PERF_REG_X86_R31) {
+				if (!perf_regs->egpr_regs)
+					return 0;
+				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
+			}
+		} else {
+			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+				if (!perf_regs->xmm_regs)
+					return 0;
+				return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+			}
+		}
 	}
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
@@ -185,23 +195,22 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 	return 0;
 }
 
-#define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
-				 ~((1ULL << PERF_REG_X86_MAX) - 1))
+#define PERF_REG_X86_RESERVED	(GENMASK_ULL(PERF_REG_X86_XMM0 - 1, PERF_REG_X86_AX) & \
+				 ~GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_AX))
+#define PERF_REG_X86_EXT_RESERVED	(~GENMASK_ULL(PERF_REG_MISC_MAX - 1, PERF_REG_X86_AX))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
-		       (1ULL << PERF_REG_X86_R9) | \
-		       (1ULL << PERF_REG_X86_R10) | \
-		       (1ULL << PERF_REG_X86_R11) | \
-		       (1ULL << PERF_REG_X86_R12) | \
-		       (1ULL << PERF_REG_X86_R13) | \
-		       (1ULL << PERF_REG_X86_R14) | \
-		       (1ULL << PERF_REG_X86_R15))
+#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_R8)
 
 int perf_reg_validate(u64 mask, bool simd_enabled)
 {
+	if (!simd_enabled &&
+	    (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))))
+		return -EINVAL;
+
 	/* The mask could be 0 if only the SIMD registers are interested */
-	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
+	if (simd_enabled &&
+	    (mask & ~GENMASK_ULL(PERF_REG_X86_GS, PERF_REG_X86_AX)))
 		return -EINVAL;
 
 	return 0;
@@ -220,8 +229,13 @@ u64 perf_reg_abi(struct task_struct *task)
 
 int perf_reg_validate(u64 mask, bool simd_enabled)
 {
+	if (!simd_enabled &&
+	    (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))))
+		return -EINVAL;
+
 	/* The mask could be 0 if only the SIMD registers are interested */
-	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
+	if (simd_enabled &&
+	    (mask & (REG_NOSUPPORT | PERF_REG_X86_EXT_RESERVED)))
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

