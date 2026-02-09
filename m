Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13F31DDB8;
	Mon,  9 Feb 2026 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621980; cv=none; b=q2lw47kPhg6Ik/GwfMthv0DCoeCVyZVlAiT37702qBnhLp5eMeGnwC1bFOqOvkT8QhgJvvtsIeATRQXMPT8g7PfEbVfCFDFZ8HCrcZK+KCB3KOBolAaEPeEI5XDbyb/X4E+KTGReosliGBheT5P0ynZgsc5a8otcQy+wJAfNfXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621980; c=relaxed/simple;
	bh=mmAWlcFDxm7sO2Ed3RNtwxAhiK9H8IWOinGZzb5eyxY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kPuDwezYegly60KTeOMGz6o4sNw+erfHXWHcuOkU2PwEpNBK3/7sJbWjOw3adBLCcOxNB2/dTOCnV0edBhNQMOQdk60eAYdeP+Pwx6wqhuD1M6ONZMDBdIWCUeUm43N2QOaviN/FiAldxDtCzzg+xfakGrEOLRZsGvT7T6JgnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PTIbzS1w; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PTIbzS1w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621980; x=1802157980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mmAWlcFDxm7sO2Ed3RNtwxAhiK9H8IWOinGZzb5eyxY=;
  b=PTIbzS1wl4MvS2g0Vi0PIbd7dloqrOi36T2mGTY4bCH6DLCCE9JNVVDw
   wtj07u0HAUzHw5s6ugqbidZUeLEFHDj5UTqb+ePxXbxr38a5TRb65rLrH
   98G2Zg+XSD1qVn6jpKqmg3KCMn4PkdrLRuam3E8BSMrYJPpiUZd3TWFku
   1yHXI92ad3K/Syhh7TnkOdgqOHhsKU4xxdB5N0ebQw+OmYVM2ieX199tl
   X5FwgmlOqexTy9EtTGEvBRG2zruM5vNFRbhbJmhnc21YAdAvf2HUa2Z5r
   ID0OX02n5X+galhZxwxX9RBuQcs3pDSvrFai74iaIa9e8PDdRltuHwRd5
   A==;
X-CSE-ConnectionGUID: yBFiVSQ+SWO2vXmn5xj2EA==
X-CSE-MsgGUID: xFudsm0LRTWDxjJwZVJtdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098532"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098532"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:20 -0800
X-CSE-ConnectionGUID: qUf5GqscS4aJcdKFXMat8g==
X-CSE-MsgGUID: pVcYfgMnScOHppZqzuF2Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694781"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:15 -0800
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v6 18/22] perf/x86: Enable eGPRs sampling using sample_regs_* fields
Date: Mon,  9 Feb 2026 15:20:43 +0800
Message-Id: <20260209072047.2180332-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

This patch enables sampling of APX eGPRs (R16 ~ R31) via the
sample_regs_* fields.

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

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 37 ++++++++++++++++-------
 arch/x86/events/perf_event.h          | 10 +++++++
 arch/x86/include/asm/perf_event.h     |  4 +++
 arch/x86/include/uapi/asm/perf_regs.h | 25 ++++++++++++++++
 arch/x86/kernel/perf_regs.c           | 43 ++++++++++++++++-----------
 5 files changed, 90 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a674436f07e..b320a58ede3f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -697,20 +697,21 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
-		/*
-		 * Besides the general purpose registers, XMM registers may
-		 * be collected as well.
-		 */
-		if (event_has_extended_regs(event)) {
-			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
-				return -EINVAL;
-			if (event->attr.sample_simd_regs_enabled)
-				return -EINVAL;
-		}
-
 		if (event_has_simd_regs(event)) {
+			u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
+
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
+			/*
+			 * The XMM space in the perf_event_x86_regs is reclaimed
+			 * for eGPRs and other general registers.
+			 */
+			if (event->attr.sample_regs_user & reserved ||
+			    event->attr.sample_regs_intr & reserved)
+				return -EINVAL;
+			if (event_needs_egprs(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
+				return -EINVAL;
 			/* Not require any vector registers but set width */
 			if (event->attr.sample_simd_vec_reg_qwords &&
 			    !event->attr.sample_simd_vec_reg_intr &&
@@ -732,6 +733,15 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_opmask(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
 				return -EINVAL;
+		} else {
+			/*
+			 * Besides the general purpose registers, XMM registers may
+			 * be collected as well.
+			 */
+			if (event_has_extended_regs(event)) {
+				if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+					return -EINVAL;
+			}
 		}
 	}
 
@@ -1860,6 +1870,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
+	perf_regs->egpr_regs = NULL;
 }
 
 static inline void __x86_pmu_sample_ext_regs(u64 mask)
@@ -1893,6 +1904,8 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 /*
@@ -1960,6 +1973,8 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_Hi16_ZMM;
 	if (event_needs_opmask(event))
 		mask |= XFEATURE_MASK_OPMASK;
+	if (event_needs_egprs(event))
+		mask |= XFEATURE_MASK_APX;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c9d6379c4ddb..33c187f9b7ab 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,16 @@ static inline bool event_needs_opmask(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_egprs(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
+	     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 6c5a34e0dfc8..cecf1e8d002f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -730,6 +730,10 @@ struct x86_perf_regs {
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
index dae39df134ec..f9b4086085bc 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,33 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The EGPRs and XMM have overlaps. Only one can be used
+	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
+	 * utilize EGPRs. For the other ABI type, XMM is used.
+	 *
+	 * Extended GPRs (EGPRs)
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
@@ -54,6 +78,7 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 9b3134220b3e..1c2a8c2c7bf1 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -61,14 +61,22 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
-	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+	if (idx > PERF_REG_X86_R15) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
-		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
-		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
-			return 0;
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
@@ -153,18 +161,12 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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
@@ -188,7 +190,12 @@ u64 perf_reg_abi(struct task_struct *task)
 int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
-	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
+	if (!simd_enabled &&
+	    (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+		return -EINVAL;
+
+	if (simd_enabled &&
+	    (mask & (REG_NOSUPPORT | PERF_REG_X86_EXT_RESERVED)))
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

