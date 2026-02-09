Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356031DDB8;
	Mon,  9 Feb 2026 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621984; cv=none; b=QWKbpw0XYBDw++rh4f3GQAolMdkLvo0uQ2XE0smknu6pEAxj5lJ5oPQLw8xt0mIeJllE1GgwSWHw8ix6eVW0ujgqCr8rWECqHeM8BTKlWLiUjUXpJryvf2iCgOf/v9jcto0ZmRH/GLU/Mt+oW+M6K+NVsOtVMpK7QSduzmQRSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621984; c=relaxed/simple;
	bh=XgZZZ4T0KpfHHjZiIOCBWCnQIN87HiMDsdekYOW/siA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIdtWoD+7CUgdaEpKG0Nn2fx99W6H77GwJoWo6ROjZAOzGgw42FMc8+nSEQ+I7z33Wyni8HJjuRv5YYxZQ0HfQuDte7fFZZLpltB03sRM3MGZCqF+4k1g8j+LhzLHMlHCO4PUZ9ShhT/mQWNxb1uEZ771YbqAcDxHDAu6mFtGU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XPjwTE3K; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XPjwTE3K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621985; x=1802157985;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XgZZZ4T0KpfHHjZiIOCBWCnQIN87HiMDsdekYOW/siA=;
  b=XPjwTE3KnlcpWTCzH4GioIMetzW2xTuhUbX8Iiy4dGgbY6/N9tTwxm7P
   6xzgIEoa4XqaPguMvDzvp118b18RT8Te0Ow07ofSvh3iqT8VjAAg2goFi
   HKrDHDCHBiXhWFvTM4AjblCVWWImK19n0B+p2LuWF2wnLKKcN7jxpD1Xe
   U1wa4vIJkPnB/RceSNeItBBuOWz8kvGLsJF0ZnqamYOMxudLPQkIfGTF9
   /lOQD9j+FuiBb5XgFMQxEF5meKgLCH1ejaOjKQUphkOEoeRkNkv07ZrVA
   CUveaThpX1iSahFm4NNr0ZoTfdAW4cQpLiZ0tolmt6kZPe8AZPyfuJBwF
   A==;
X-CSE-ConnectionGUID: EOOmoJxSRwSIUZZXaE/Crg==
X-CSE-MsgGUID: MUuqz73gSPGSCMLr34O3Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098546"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098546"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:25 -0800
X-CSE-ConnectionGUID: xIcptw0XTrGRRyPsv2GKYQ==
X-CSE-MsgGUID: 23r/P1pLR1acQfHwb/zj4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694788"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:20 -0800
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
Subject: [Patch v6 19/22] perf/x86: Enable SSP sampling using sample_regs_* fields
Date: Mon,  9 Feb 2026 15:20:44 +0800
Message-Id: <20260209072047.2180332-20-dapeng1.mi@linux.intel.com>
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

This patch enables sampling of CET SSP register via the sample_regs_*
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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V6: Ensure SSP value is 0 for non-user-space sampling since currently
SSP is only enabled for user space.

 arch/x86/events/core.c                |  9 +++++++++
 arch/x86/events/intel/ds.c            |  7 +++++++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  7 ++++---
 arch/x86/kernel/perf_regs.c           |  5 +++++
 6 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b320a58ede3f..81dc23e658f2 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -712,6 +712,10 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_egprs(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 				return -EINVAL;
+			if (event_needs_ssp(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_CET_USER))
+				return -EINVAL;
+
 			/* Not require any vector registers but set width */
 			if (event->attr.sample_simd_vec_reg_qwords &&
 			    !event->attr.sample_simd_vec_reg_intr &&
@@ -1871,6 +1875,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
 	perf_regs->egpr_regs = NULL;
+	perf_regs->cet_regs = NULL;
 }
 
 static inline void __x86_pmu_sample_ext_regs(u64 mask)
@@ -1906,6 +1911,8 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (mask & XFEATURE_MASK_CET_USER)
+		perf_regs->cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
 }
 
 /*
@@ -1975,6 +1982,8 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_OPMASK;
 	if (event_needs_egprs(event))
 		mask |= XFEATURE_MASK_APX;
+	if (event_needs_ssp(event))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 272725d749df..ff8707885f74 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2680,6 +2680,13 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
+
+		/* Currently only user space mode enables SSP. */
+		if (user_mode(regs) && (sample_type &
+		    (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))) {
+			perf_regs->cet_regs = &gprs->r15;
+			ignore_mask = XFEATURE_MASK_CET_USER;
+		}
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 33c187f9b7ab..fdfb34d7b1d2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -197,6 +197,16 @@ static inline bool event_needs_egprs(struct perf_event *event)
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
index cecf1e8d002f..98fef9db0aa3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -734,6 +734,10 @@ struct x86_perf_regs {
 		u64	*egpr_regs;
 		struct apx_state *egpr;
 	};
+	union {
+		u64	*cet_regs;
+		struct cet_user_state *cet;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f9b4086085bc..6da63e1dbb40 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,9 +28,9 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
 	/*
-	 * The EGPRs and XMM have overlaps. Only one can be used
+	 * The EGPRs/SSP and XMM have overlaps. Only one can be used
 	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
-	 * utilize EGPRs. For the other ABI type, XMM is used.
+	 * utilize EGPRs/SSP. For the other ABI type, XMM is used.
 	 *
 	 * Extended GPRs (EGPRs)
 	 */
@@ -50,10 +50,11 @@ enum perf_event_x86_regs {
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
index 1c2a8c2c7bf1..2e7d83f26cc0 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -70,6 +70,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 					return 0;
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
+			if (idx == PERF_REG_X86_SSP) {
+				if (!perf_regs->cet_regs)
+					return 0;
+				return perf_regs->cet_regs[1];
+			}
 		} else {
 			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 				if (!perf_regs->xmm_regs)
-- 
2.34.1

