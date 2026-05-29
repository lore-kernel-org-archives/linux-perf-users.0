Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813773B585F;
	Fri, 29 May 2026 08:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041856; cv=none; b=ZJt2C4tbNTl2vrn8XWqEx+3EhyFPu8quE3Ts3m76iS1w/wzaP1j1v+comLAMmo+SqD1GzQUOTTjKCox+goUsz9HRAdivlLIKinPRi9ULB6948Fbn/83H2awx/EK3N4Jwf+SEUZgJArlJMacN3sb9lKCl6y9RM3Yq6spIRB7pGhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041856; c=relaxed/simple;
	bh=CPFIJX+N0i4wombRjgO3CWBDUMt5tp0qbmkDhohEaJA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zc0xZoUDKqhXeflRnsGT6BxRAeQllA7JjJvDwwGqWKW6Nytq+ggJx+foYDP+pQA0PUCFeSkLi1vQzlyPPsVSkdjmL9QYfcu4gZbUUKIu/zLfqJK8fvLHTautwB7YkOFlKN+GpG5vsr6amcTNKwIclw2FVc0+koCu9WRRvIGFcVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A7nRotMl; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A7nRotMl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041854; x=1811577854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CPFIJX+N0i4wombRjgO3CWBDUMt5tp0qbmkDhohEaJA=;
  b=A7nRotMl9bM/KQ1dOWK7CU+3HOcIs6q3OavC2xzCDfZPfGpaAOqjUFgD
   UuYG9AjsVXkLCKP53HVKTrWUbn+XtqoiyBQfz7F5XvWP4x+80lqovHB1/
   R04SgFpqYNxBCt8ggFkXh8zpfPuI27B/EijPm+nU8gRGLhs5nqZi4VqC3
   cFU+cA5a84S9ePCJhzpg8OhRnDYXVQODq+hCCOgIIcWI6UvIwKmUAuru7
   tXW2oxL7BP1eOuHm7Vao1Ln2TZhQr8SfGGSJrYdrqNJ1+g6zWfE99ByKZ
   LtmDxku8DmX6FMNEfHQYf1kKxMHsQwrpmEKEveEOp+qgBvx+qJYWkE4xf
   g==;
X-CSE-ConnectionGUID: G3P9tl0QQUKKrWk6ikh4fQ==
X-CSE-MsgGUID: E1/oXJRtTx+iPxEwfahhUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342136"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342136"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:14 -0700
X-CSE-ConnectionGUID: KNuC5qCEQc2oYieT2np7Zg==
X-CSE-MsgGUID: /UlGFx/VRrycOCh0dTEnog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802501"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:04:09 -0700
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
Subject: [Patch v8 19/23] perf/x86: Support SSP sampling using sample_regs_* fields
Date: Fri, 29 May 2026 15:56:41 +0800
Message-Id: <20260529075645.580362-20-dapeng1.mi@linux.intel.com>
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

This patch supports sampling of CET SSP register via the sample_regs_*
fields.

To sample SSP, the sample_simd_regs_enabled field must be set. This
allows the spare space (reclaimed from the original XMM space) in the
sample_regs_* fields to be used for representing SSP.

Similar with eGPRs sampling, the perf_reg_value() function needs to
check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
determine whether to output SSP or legacy XMM registers to userspace.

Additionally, arch-PEBS supports sampling SSP, which is placed into the
GPRs group. This patch also enables arch-PEBS-based SSP sampling.

Currently, SSP sampling is only supported on the x86_64 architecture, as
CET is only available on x86_64 platforms.

Please note SSP sampling is not enabled yet, it will be enabled in a later
patch when PERF_PMU_CAP_SIMD_REGS is set.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 11 +++++++++++
 arch/x86/events/intel/ds.c            | 15 +++++++++++++--
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h |  7 ++++---
 arch/x86/kernel/perf_regs.c           |  5 +++++
 6 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index af874ff3d048..f990256fb2ff 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -726,6 +726,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_egprs(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 				return -EINVAL;
+			if (event_needs_ssp(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_CET_USER))
+				return -EINVAL;
 			/* The vector registers set is not supported */
 			if (event_needs_xmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
@@ -1803,11 +1806,13 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
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
@@ -1828,6 +1833,10 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (mask & XFEATURE_MASK_CET_USER) {
+		cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
+		perf_regs->ssp = cet ? &cet->user_ssp : NULL;
+	}
 }
 
 /*
@@ -2014,6 +2023,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_OPMASK;
 	if (event_needs_egprs(event))
 		mask |= XFEATURE_MASK_APX;
+	if (event_needs_ssp(event))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 609d4a83115d..fb393be13fcb 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1723,6 +1723,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	u64 sample_type = attr->sample_type;
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
+	u64 xgprs_mask;
 
 	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
 	    attr->precise_ip > 1)
@@ -1737,10 +1738,13 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
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
@@ -2690,6 +2694,13 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		__setup_pebs_gpr_group(event, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
+
+		/* Currently only user space mode enables SSP. */
+		if (user_mode(regs) && (sample_type &
+		    (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))) {
+			perf_regs->ssp = &gprs->ssp;
+			ignore_mask |= XFEATURE_MASK_CET_USER;
+		}
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4cc490aa04fc..c521a7fbe9c6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -207,6 +207,16 @@ static inline bool event_needs_egprs(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_ssp(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP) ||
+	     event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a54ea8fa6a04..2769ec3030e5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -751,6 +751,7 @@ struct x86_perf_regs {
 		u64	*egpr_regs;
 		struct apx_state *egpr;
 	};
+	u64	*ssp;
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 8774a1290fbe..31a025cb9dba 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,10 +28,10 @@ enum perf_event_x86_regs {
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
@@ -51,10 +51,11 @@ enum perf_event_x86_regs {
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
index 006883ad443d..6f0970ed60db 100644
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

