Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FAD372EE3;
	Tue, 24 Mar 2026 00:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313243; cv=none; b=NKWUkUz9EiabpcdZu+GBuUPlEQYYOf2FSK46SMwfIBQum6awXuUWjQGg8osDZfgQdXpeiNubGORS/O58dwDKgBawJVHIU+c1Ux+Lp+pmKQRiQwh+oGJGIRZXYmpNyODrg1zhdQkixgxs4YCG7VIh1zWnurTzy7fNsq0/WvmD63w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313243; c=relaxed/simple;
	bh=lM9ou+xaSTN5Lj+3m2apmkVvZzG2xUKXKiyEiqsvYqU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TIfVIlQ10ajof1Al7WK8uxE2dqLb8iPGx4pUGJlGckWN+Ne1QnqLwdHI/2YEQvCUUTZ5Vnfcos9H+BMqOdlTXQaohJuR8onf5ffqb7+uYqhYet2BI0NhGeZw+L2IpboT/cy9TsTl1KgKA+k5LQ6A7pt91JPEaFQFUr3V2vEj0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nU1PY9eP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nU1PY9eP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313241; x=1805849241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lM9ou+xaSTN5Lj+3m2apmkVvZzG2xUKXKiyEiqsvYqU=;
  b=nU1PY9eP3Gr/Vz7SRQ8EnSIdPnj2l7wRiyukTDNTT7O0g/nSbYQxqKCb
   GYWPND1NTEmA7DyoAN69NmfGystJ6lpt1F21ic9jz4MY2mm/MweVoMKGX
   aareggb1khN1An8okPtQQvyGMlgEiH2nVmo8T98v8RPgfJmmNBHMd+340
   Hy4Nm2AVRdhrz0D76k3txmRsCv6Jt6KSiyzhSl+PJ21H5MOU9LvJ9F/I0
   o4POdnO9ZDvZBOHtGtIk81tCRx1JrvwlkCqXiJhV13x2mvmEgnNPoNNWe
   l5VOiZGAgs63PvcwkSyFgk+asEYX2U6+DVwZcjnK7VhwU9ohtSyYQifPU
   Q==;
X-CSE-ConnectionGUID: uVhz3wLOQASS/CTC7Efwhg==
X-CSE-MsgGUID: lHN+wjxlQrS2cbg3Gxkk+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397251"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397251"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:21 -0700
X-CSE-ConnectionGUID: 4cUAkmsXQ/yulQUuTG2LWA==
X-CSE-MsgGUID: UZIhFURyQQe5Bnr7L67JaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322959"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:17 -0700
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
Subject: [Patch v7 19/24] perf/x86: Enable eGPRs sampling using sample_regs_* fields
Date: Tue, 24 Mar 2026 08:41:13 +0800
Message-Id: <20260324004118.3772171-20-dapeng1.mi@linux.intel.com>
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
 arch/x86/include/uapi/asm/perf_regs.h | 26 ++++++++++++++++
 arch/x86/kernel/perf_regs.c           | 43 ++++++++++++++++-----------
 5 files changed, 91 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d86a4fbea1ed..d33cfbe38573 100644
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
 
 static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
@@ -1883,6 +1894,8 @@ static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 /*
@@ -1946,6 +1959,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_Hi16_ZMM;
 	if (event_needs_opmask(event))
 		mask |= XFEATURE_MASK_OPMASK;
+	if (event_needs_egprs(event))
+		mask |= XFEATURE_MASK_APX;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.abi)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 00f436f5840b..0974fd8b0e20 100644
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
index 7e8b60bddd5a..a54ea8fa6a04 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -747,6 +747,10 @@ struct x86_perf_regs {
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
index f4a1630c1928..e721a47556d4 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,34 @@ enum perf_event_x86_regs {
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
@@ -54,6 +79,7 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 9b3134220b3e..a34cc52dbbeb 100644
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
@@ -187,8 +189,13 @@ u64 perf_reg_abi(struct task_struct *task)
 
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

