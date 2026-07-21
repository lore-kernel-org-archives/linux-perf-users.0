Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6A435ABA;
	Tue, 21 Jul 2026 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615660; cv=none; b=rYRXYWgrAM7LL/3nc+V9VpijtWu9yGThvSJ+aHnMAUHNwx4cHzxB61elzLG7nsqq45dDr7PuCWxxGWRLfD+xRbe7TwdGKcb0dm6swjUv2yprS5UauqSMguGSK4OmnwEugaSAZ9xmc4o2pLZgzW5Mw7Fo7/zsLW28WhrGrP+WJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615660; c=relaxed/simple;
	bh=Q9c4BHV0NUJdSfMdMHMBJssvnrGsC8DjAYXoaKPixXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=um/mdF9W8siXN5CEUwgF+WVDojD7mMAJwADy46mn85oldzbTtu1ZKh3Qv3SpEfcPEhh3ufPQRrcHyGqQ+G056+ZqsKKC7PoDkS25Jrm8/6ut1T5xhInevZgE4GrBjE3BmSpqJeO4ZRSsm4zyYFO+e8H0PPd0yHRN8Zos5lgH8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YpvqZBJy; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YpvqZBJy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615659; x=1816151659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q9c4BHV0NUJdSfMdMHMBJssvnrGsC8DjAYXoaKPixXY=;
  b=YpvqZBJytsmxdFhjvjJTYdGxG3w4pDc+YhGtcH4U8IA/deSyjsqMxf7h
   a6MgzMWjfczB1Ol5U2Haanz0t7zpDmJFU0KTjfySbMn/gNElELz6QtVJ8
   qiORhbvRgqQYi1030Mwmr3O7LTyZELRtqg6kx6LXt0I9Jy64x9yzp7Ppi
   RtQTz3hX+uRDHqfk6p9xObJCDFxdRksShDr/5BPjqBnjGmyu8G7uiz5h4
   DOrwyRv7rHcPEcoaoznhgfa0eM7Y+2RFLQCIocXoGX3AmyzQNfhUfROao
   tYmAouBhnSJubOyrgvks2DRNEbg3RZA5yzj4W1XAn0fcBnD9e3ni0DwbH
   Q==;
X-CSE-ConnectionGUID: 5Yp0eIZKRLSJHCxhSeeDZA==
X-CSE-MsgGUID: hIPYWpyURKu24xqit7Retw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565566"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565566"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:34:18 -0700
X-CSE-ConnectionGUID: 9iNbYuVDTH+ttcZMgXY1hg==
X-CSE-MsgGUID: UlIruHJeQe6dtI5lmlze4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656217"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:34:10 -0700
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
Subject: [Patch v10 19/23] perf/x86: Support SSP sampling using sample_regs_* fields
Date: Tue, 21 Jul 2026 14:25:02 +0800
Message-Id: <20260721062506.3745816-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support sampling of CET SSP register via the sample_regs_* fields.

To sample SSP, the sample_simd_regs_enabled field must be set. This
allows the spare space (reclaimed from the original XMM space) in the
sample_regs_* fields to be used for representing SSP.

Similar to eGPRs sampling, the perf_reg_value() function needs to
check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
determine whether to output SSP or legacy XMM registers to userspace.

Additionally, arch-PEBS supports sampling SSP, which is placed into the
GPRs group. Also enables arch-PEBS-based SSP sampling.

Currently, SSP sampling is only supported on the x86_64 architecture, as
CET is only available on x86_64 platforms.

SSP sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 15 +++++++++++++++
 arch/x86/events/intel/core.c          |  3 ++-
 arch/x86/events/intel/ds.c            | 13 +++++++++++--
 arch/x86/events/perf_event.h          | 25 +++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  7 ++++---
 arch/x86/kernel/perf_regs.c           |  5 +++++
 7 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 9cd79ac5570e..caa5a0fb3ed8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -642,6 +642,10 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
 		return -EINVAL;
+
+	if (event_needs_ssp(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_GPR)))
+		return -EINVAL;
 	/* PEBS does not support YMM/ZMM/OPMASK/eGPR registers sampling yet. */
 	if (event_needs_ymm(event) ||
 	    event_needs_low16_zmm(event) ||
@@ -671,6 +675,9 @@ static int event_simd_regs_validate(struct perf_event *event)
 	if (event_needs_egprs(event) &&
 	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 		return -EINVAL;
+	if (event_needs_ssp(event) &&
+	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_CET_USER))
+		return -EINVAL;
 	if (event_needs_xmm(event) &&
 	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 		return -EINVAL;
@@ -1854,11 +1861,13 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
 	perf_regs->egpr_regs = NULL;
+	perf_regs->ssp = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
 			     struct xregs_state *xsave, u64 bitmap)
 {
+	struct cet_user_state *cet;
 	u64 mask;
 
 	if (!xsave)
@@ -1879,6 +1888,10 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (mask & XFEATURE_MASK_CET_USER) {
+		cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
+		perf_regs->ssp = cet ? &cet->user_ssp : NULL;
+	}
 }
 
 /*
@@ -2057,6 +2070,8 @@ static u64 get_simd_sample_mask(struct perf_event *event, u64 sample_type)
 		mask |= XFEATURE_MASK_OPMASK;
 	if (__event_needs_egprs(event, sample_type))
 		mask |= XFEATURE_MASK_APX;
+	if (__event_needs_ssp(event, sample_type))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	return mask;
 }
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index fd6d20db4dc7..809ef2515b10 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4720,7 +4720,8 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
 	u64 gprs_mask = event->attr.sample_simd_regs_enabled ?
-			PEBS_GP_REGS | PERF_X86_EGPRS_MASK :
+			PEBS_GP_REGS | PERF_X86_EGPRS_MASK |
+			BIT_ULL(PERF_REG_X86_SSP) :
 			PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
 
 	if (event->attr.use_clockid)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index eb61eae9226d..3277bd72e0a8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1700,6 +1700,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	u64 sample_type = attr->sample_type;
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
+	u64 xgprs_mask;
 
 	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
 	    attr->precise_ip > 1)
@@ -1714,10 +1715,13 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
+	xgprs_mask = event->attr.sample_simd_regs_enabled ?
+		     PEBS_GP_REGS | BIT_ULL(PERF_REG_X86_SSP) :
+		     PEBS_GP_REGS;
 	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+		(attr->sample_regs_intr & xgprs_mask)) ||
 	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
-		(attr->sample_regs_user & PEBS_GP_REGS));
+		(attr->sample_regs_user & xgprs_mask));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -2666,6 +2670,11 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		__setup_pebs_gpr_group(event, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
+
+		/* Currently only user space mode enables SSP. */
+		if (user_mode(regs) && (sample_type &
+		    (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+			perf_regs->ssp = &gprs->ssp;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 899584cdbdd3..eca7fab86b9b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -315,6 +315,31 @@ static inline bool event_needs_egprs(struct perf_event *event)
 			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
 }
 
+static inline bool __event_needs_ssp(struct perf_event *event,
+				     u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+
+	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP)))
+		return true;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)))
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_ssp(struct perf_event *event)
+{
+	return __event_needs_ssp(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index bc05f8c17464..4302ef39c42e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -753,6 +753,7 @@ struct x86_perf_regs {
 		u64	*egpr_regs;
 		struct apx_state *egpr;
 	};
+	u64	*ssp;
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 977831bd7a9d..faaa82df688d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -30,10 +30,10 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
 	/*
-	 * The eGPRs and XMM have overlaps. Only one can be used
+	 * The eGPRs/SSP and XMM have overlaps. Only one can be used
 	 * at a time. The ABI PERF_SAMPLE_REGS_ABI_SIMD is used to
 	 * distinguish which one is used. If PERF_SAMPLE_REGS_ABI_SIMD
-	 * is set, then eGPRs is used, otherwise, XMM is used.
+	 * is set, then eGPRs/SSP is used, otherwise, XMM is used.
 	 *
 	 * Extended GPRs (eGPRs)
 	 */
@@ -53,10 +53,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R29,
 	PERF_REG_X86_R30,
 	PERF_REG_X86_R31,
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
-	PERF_REG_MISC_MAX = PERF_REG_X86_R31 + 1,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 7d4233ed859c..f8952f7c36cc 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -72,6 +72,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 					return 0;
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
+			if (idx == PERF_REG_X86_SSP) {
+				if (!perf_regs->ssp)
+					return 0;
+				return *perf_regs->ssp;
+			}
 		} else {
 			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 				if (!perf_regs->xmm_regs)
-- 
2.34.1

