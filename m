Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAD23B058B;
	Mon, 24 Aug 2026 08:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560526; cv=none; b=F1jUbiZd0pdCHyFYAIFGrXXyc1+reC7R5Raxdi38tPyM5WslDKg6eErUDe1DuYLUhVDMTSiR8vpIgIjs/pfGXCLaxMF2iIlD0eRUtgdPthHCTMQYickXLsStL4T8PMEUxbCblRZDme5N+3AdFlV2Q0kyqQl05hKTLAHGtehgEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560526; c=relaxed/simple;
	bh=N8X3dFNKXCrsuVRTXjtyz/tr6AKJiycMVMdHieYv8QA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nT82ugkUJDMiGmk0ATwqSJPkg7bFWXCftxM1AOsRRbahOZXJ55kvFlJPMGPOPT6fa9rPSlDpjfu74t6Z0+dmIWH1W5NyF5yE/yBUtAK77puCN7ByE/Z4CMM1D+epOGK9vfe7Jch9NEiW5sdE45tCLeJ1dElWA8h9PYn1HbHCEps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tv6GcDwd; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tv6GcDwd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560524; x=1819096524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N8X3dFNKXCrsuVRTXjtyz/tr6AKJiycMVMdHieYv8QA=;
  b=Tv6GcDwd61M4eCcdA53kbOyl2cSaxyAoY10YB9hek/EFHVY+etVvf1sR
   8SvO9njdKqZGmVFz9gDp8stIDwHqek/X+o1E4MGA66RzQTBFQg9mybExn
   fJqUbcEt9z2cTO37leZ56qe48+c17k61w/fVb9X215CNwYnQeQoHz9SuK
   uk9VxMutqFBaZ7rl1nJ9iUchnTqn/6mMYp3WMK6G9yQ6Ay5OSjIkqZ1Wl
   /GLg/87uDpA5CpD3xtrSzGahQncZBzd88zudsKM3AZjsu1RuKYSxkzK/X
   a56lG0w4HLX+jyoEsFKZIU1SP4Gr5yXHCuE88h7mE0inEA2eUkU949zz+
   g==;
X-CSE-ConnectionGUID: T/D0g7HmQgCza6aCKwC2eQ==
X-CSE-MsgGUID: FBoJT+H4TvShl8Eap6WmAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598840"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:24 -0700
X-CSE-ConnectionGUID: NgYyX5lXQBmfrAf+aNlw9g==
X-CSE-MsgGUID: zyqYL9b6TwyP1XQx1QIFaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326560"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:19 -0700
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
Subject: [RESEND Patch v10 14/23] perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields
Date: Mon, 24 Aug 2026 16:27:22 +0800
Message-Id: <20260824082731.1013973-15-dapeng1.mi@linux.intel.com>
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

Support sampling of YMM registers via the sample_simd_vec_reg_* fields.

Each YMM register consists of 4 u64 words, assembled from two halves:
XMM (the lower 2 u64 words) and YMMH (the upper 2 u64 words). Although
both XMM and YMMH data can be retrieved with a single xsaves instruction,
they are stored in separate locations. The perf_simd_reg_value() function
is responsible for assembling these halves into a complete YMM register
for output to userspace.

Additionally, sample_simd_vec_reg_qwords should be set to 4 to indicate
YMM sampling.

YMM sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 29 +++++++++++++++++++++------
 arch/x86/events/perf_event.h          | 26 ++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  6 ++++--
 arch/x86/kernel/perf_regs.c           | 13 +++++++++++-
 5 files changed, 69 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f85163b95cfc..3039a311e733 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -642,6 +642,9 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
 		return -EINVAL;
+	/* PEBS does not support YMM registers sampling yet. */
+	if (event_needs_ymm(event))
+		return -EINVAL;
 
 	return 0;
 }
@@ -656,6 +659,9 @@ static int event_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 		return -EINVAL;
+	if (event_needs_ymm(event) &&
+	   !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+		return -EINVAL;
 
 	return 0;
 }
@@ -1819,6 +1825,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 
 	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1834,6 +1841,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 
 	if (mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+	if (mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 /*
@@ -1996,6 +2005,18 @@ static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
 	return user_mask;
 }
 
+static u64 get_simd_sample_mask(struct perf_event *event, u64 sample_type)
+{
+	u64 mask = 0;
+
+	if (__event_needs_xmm(event, sample_type))
+		mask |= XFEATURE_MASK_SSE;
+	if (__event_needs_ymm(event, sample_type))
+		mask |= XFEATURE_MASK_YMM;
+
+	return mask;
+}
+
 static void x86_pmu_sample_xregs(struct perf_event *event,
 				 struct perf_sample_data *data,
 				 struct pt_regs *regs,
@@ -2011,17 +2032,13 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		return;
 
 	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.regs) {
-		if (__event_needs_xmm(event, PERF_SAMPLE_REGS_INTR))
-			intr_mask |= XFEATURE_MASK_SSE;
-
+		intr_mask |= get_simd_sample_mask(event, PERF_SAMPLE_REGS_INTR);
 		intr_mask &= x86_pmu.ext_regs_mask;
 		intr_mask = from_pebs ? 0 : intr_mask;
 	}
 
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.regs) {
-		if (__event_needs_xmm(event, PERF_SAMPLE_REGS_USER))
-			user_mask |= XFEATURE_MASK_SSE;
-
+		user_mask |= get_simd_sample_mask(event, PERF_SAMPLE_REGS_USER);
 		user_mask &= x86_pmu.ext_regs_mask;
 		user_mask = x86_pmu_update_user_xregs(data, regs,
 						      user_mask, from_pebs);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 23c5907e8b85..01de7799f907 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -183,6 +183,32 @@ static inline bool event_needs_xmm(struct perf_event *event)
 			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
 }
 
+static inline bool __event_needs_ymm(struct perf_event *event, u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+	if (event->attr.sample_simd_vec_reg_qwords < PERF_X86_YMM_QWORDS)
+		return false;
+
+	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_simd_vec_reg_user > 0))
+		return true;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_simd_vec_reg_intr > 0))
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_ymm(struct perf_event *event)
+{
+	return __event_needs_ymm(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a2b2123d008e..da77845e1f02 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -733,6 +733,10 @@ struct x86_perf_regs {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
 	};
+	union {
+		u64	*ymmh_regs;
+		struct ymmh_struct *ymmh;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index edb35408e4cc..d544f6d79871 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -59,7 +59,8 @@ enum perf_event_x86_regs {
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
@@ -67,7 +68,8 @@ enum {
 enum {
 	/* 1 qword = 8 bytes */
 	PERF_X86_XMM_QWORDS      = 2,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bccf0fc27511..0076974498ee 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -77,6 +77,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define PERF_X86_YMMH_QWORDS	(PERF_X86_YMM_QWORDS / 2)
+
 u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			u16 qwords_idx, bool pred)
 {
@@ -98,6 +100,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			return 0;
 		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS +
 					   qwords_idx];
+	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
+		if (!perf_regs->ymmh_regs)
+			return 0;
+		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS +
+					    qwords_idx - PERF_X86_XMM_QWORDS];
 	}
 
 	return 0;
@@ -115,7 +122,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 	}
 
 	if (vec_qwords) {
-		if (vec_qwords != PERF_X86_XMM_QWORDS)
+		if (vec_qwords != PERF_X86_XMM_QWORDS &&
+		    vec_qwords != PERF_X86_YMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
@@ -124,6 +132,9 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_qwords == PERF_X86_XMM_QWORDS && mask &&
 		    !bitmap_full(&mask, PERF_X86_SIMD_XMM_REGS))
 			return -EINVAL;
+		if (vec_qwords == PERF_X86_YMM_QWORDS && mask &&
+		    !bitmap_full(&mask, PERF_X86_SIMD_YMM_REGS))
+			return -EINVAL;
 	}
 
 	/* PRED registers are not supported yet. */
-- 
2.34.1

