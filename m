Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C753ED5CD;
	Mon, 24 Aug 2026 08:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560531; cv=none; b=YSqn4CVGpOHstJlugyBZiJC78g0+xu/504C/aLRdNEapPyf3E20ExtT78dZwouJ8eaCgSqn91WRLykaKvuORceXkdsLYTF9/X5xvEgfvGHPonaz4u33LEtKqnz8AHoWNrxeODGzty9EQt1mph3EM+blQMZOnp1tpIreS3ux6z1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560531; c=relaxed/simple;
	bh=9ePV5Z6b+35fNuJr5NUdWv0cAnC0DEeQTKMQFKJxwQc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXqJQqhDaZEJgwqEdl/6yrUuC9DRKQW6nKPJX8qRhviO1XM4j87eDjLfrVNETx9SL31sTlRQuXLMevJD3ZhfgEY3/iWl1ogWzgMs84900XrRAE0ybmJ1sLAa9+5vnINe4ikANUYWMouAMbBHKc+AmDreCD8hJ/Lwis1okWNcRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QciBY0MH; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QciBY0MH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560530; x=1819096530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ePV5Z6b+35fNuJr5NUdWv0cAnC0DEeQTKMQFKJxwQc=;
  b=QciBY0MHtCj6MefuoYp949EdmfR/l2BV1q/o/0SLJhWiIxIdtvtgBrHx
   Jsw/u2JrZQqlXnYZIiVLkrjzRA8VfJ3srzGzeCVZKd2bmwuxvqJ+PCfD1
   cl3UzUN2XN6b96qaCrvtkF0ADXWmzPf/yZvA669Gh3AiyrtYaeRWeC/2F
   75lx4htbpBxqXUpWWUmt0hDYoMq8YBT+AEvmvCcP/UJGV99E4VNeNvFUF
   H6DcjnOlpixP86gsAT5xyKUqK6kC+4mMIAaMg0ssrfop93TBGpLNBTr4k
   8M5DIj9BNLW3PdxBkaNzewTy3cQOfi2hvQV+hVvA8JGnH8+2cip1hNF5T
   g==;
X-CSE-ConnectionGUID: Fk6N5FlIRNKsR1iq2qnjUQ==
X-CSE-MsgGUID: sOHahsNIToqNSYZknlx/AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598846"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598846"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:29 -0700
X-CSE-ConnectionGUID: D0gSIWcFQ/qfDhAZ6ajdmg==
X-CSE-MsgGUID: JbqIamDpTMmGvKRHxrzD7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326579"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:24 -0700
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
Subject: [RESEND Patch v10 15/23] perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields
Date: Mon, 24 Aug 2026 16:27:23 +0800
Message-Id: <20260824082731.1013973-16-dapeng1.mi@linux.intel.com>
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

Support sampling of ZMM registers via the sample_simd_vec_reg_* fields.

Each ZMM register consists of 8 u64 words. Current x86 hardware supports
up to 32 ZMM registers. For ZMM registers from ZMM0 to ZMM15, they are
assembled from three parts: XMM (the lower 2 u64 words),
YMMH (the middle 2 u64 words), and ZMMH (the upper 4 u64 words). The
perf_simd_reg_value() function is responsible for assembling these three
parts into a complete ZMM register for output to userspace.

For ZMM registers ZMM16 to ZMM31, each register can be read as a whole
and directly outputted to userspace.

Additionally, sample_simd_vec_reg_qwords should be set to 8 to indicate
ZMM sampling.

ZMM sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 22 ++++++++++-
 arch/x86/events/perf_event.h          | 54 +++++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  8 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 +++-
 arch/x86/kernel/perf_regs.c           | 19 +++++++++-
 5 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3039a311e733..b0e3f1b9fa19 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -642,8 +642,10 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
 		return -EINVAL;
-	/* PEBS does not support YMM registers sampling yet. */
-	if (event_needs_ymm(event))
+	/* PEBS does not support YMM/ZMM registers sampling yet. */
+	if (event_needs_ymm(event) ||
+	    event_needs_low16_zmm(event) ||
+	    event_needs_high16_zmm(event))
 		return -EINVAL;
 
 	return 0;
@@ -662,6 +664,12 @@ static int event_simd_regs_validate(struct perf_event *event)
 	if (event_needs_ymm(event) &&
 	   !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
 		return -EINVAL;
+	if (event_needs_low16_zmm(event) &&
+	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_ZMM_Hi256))
+		return -EINVAL;
+	if (event_needs_high16_zmm(event) &&
+	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
+		return -EINVAL;
 
 	return 0;
 }
@@ -1826,6 +1834,8 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
 	perf_regs->ymmh_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1843,6 +1853,10 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->xmm_space = xsave->i387.xmm_space;
 	if (mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 /*
@@ -2013,6 +2027,10 @@ static u64 get_simd_sample_mask(struct perf_event *event, u64 sample_type)
 		mask |= XFEATURE_MASK_SSE;
 	if (__event_needs_ymm(event, sample_type))
 		mask |= XFEATURE_MASK_YMM;
+	if (__event_needs_low16_zmm(event, sample_type))
+		mask |= XFEATURE_MASK_ZMM_Hi256;
+	if (__event_needs_high16_zmm(event, sample_type))
+		mask |= XFEATURE_MASK_Hi16_ZMM;
 
 	return mask;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 01de7799f907..f59551200f18 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -209,6 +209,60 @@ static inline bool event_needs_ymm(struct perf_event *event)
 			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
 }
 
+static inline bool __event_needs_low16_zmm(struct perf_event *event,
+					   u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+	if (event->attr.sample_simd_vec_reg_qwords < PERF_X86_ZMM_QWORDS)
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
+static inline bool event_needs_low16_zmm(struct perf_event *event)
+{
+	return __event_needs_low16_zmm(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
+static inline bool __event_needs_high16_zmm(struct perf_event *event,
+					    u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+	if (event->attr.sample_simd_vec_reg_qwords < PERF_X86_ZMM_QWORDS)
+		return false;
+
+	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE))
+		return true;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE))
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_high16_zmm(struct perf_event *event)
+{
+	return __event_needs_high16_zmm(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index da77845e1f02..75394c4e8bc3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -737,6 +737,14 @@ struct x86_perf_regs {
 		u64	*ymmh_regs;
 		struct ymmh_struct *ymmh;
 	};
+	union {
+		u64	*zmmh_regs;
+		struct avx_512_zmm_uppers_state *zmmh;
+	};
+	union {
+		u64	*h16zmm_regs;
+		struct avx_512_hi16_state *h16zmm;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index d544f6d79871..b88d0b6822fd 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -60,16 +60,20 @@ enum perf_event_x86_regs {
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
 	PERF_X86_SIMD_YMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
+#define PERF_X86_H16ZMM_BASE		16
+
 enum {
 	/* 1 qword = 8 bytes */
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 0076974498ee..93370d465786 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -78,6 +78,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 }
 
 #define PERF_X86_YMMH_QWORDS	(PERF_X86_YMM_QWORDS / 2)
+#define PERF_X86_ZMMH_QWORDS	(PERF_X86_ZMM_QWORDS / 2)
 
 u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			u16 qwords_idx, bool pred)
@@ -95,6 +96,13 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
 		return 0;
 
+	if (idx >= PERF_X86_H16ZMM_BASE) {
+		if (!perf_regs->h16zmm_regs)
+			return 0;
+		return perf_regs->h16zmm_regs[(idx - PERF_X86_H16ZMM_BASE) *
+					PERF_X86_ZMM_QWORDS + qwords_idx];
+	}
+
 	if (qwords_idx < PERF_X86_XMM_QWORDS) {
 		if (!perf_regs->xmm_regs)
 			return 0;
@@ -105,6 +113,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			return 0;
 		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS +
 					    qwords_idx - PERF_X86_XMM_QWORDS];
+	} else if (qwords_idx < PERF_X86_ZMM_QWORDS) {
+		if (!perf_regs->zmmh_regs)
+			return 0;
+		return perf_regs->zmmh_regs[idx * PERF_X86_ZMMH_QWORDS +
+					    qwords_idx - PERF_X86_YMM_QWORDS];
 	}
 
 	return 0;
@@ -123,7 +136,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 
 	if (vec_qwords) {
 		if (vec_qwords != PERF_X86_XMM_QWORDS &&
-		    vec_qwords != PERF_X86_YMM_QWORDS)
+		    vec_qwords != PERF_X86_YMM_QWORDS &&
+		    vec_qwords != PERF_X86_ZMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
@@ -135,6 +149,9 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_qwords == PERF_X86_YMM_QWORDS && mask &&
 		    !bitmap_full(&mask, PERF_X86_SIMD_YMM_REGS))
 			return -EINVAL;
+		if (vec_qwords == PERF_X86_ZMM_QWORDS && mask &&
+		    !bitmap_full(&mask, PERF_X86_SIMD_ZMM_REGS))
+			return -EINVAL;
 	}
 
 	/* PRED registers are not supported yet. */
-- 
2.34.1

