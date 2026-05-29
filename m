Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687DE3B38AA;
	Fri, 29 May 2026 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041835; cv=none; b=IXCN8cPo036kZOFxJ0rI6/rG0+6HKzAQhx6fGNKGQS9GFY3uxsubHsx9Dqzouvqhegki5tOsn39lo/zL+OGJWnyh3Mr0vbH4XD5wSvdp68gnKY52jByTzb1NvL9MeQT9SbENFex/v7jfvKrCOXTFKin5/FeX+XfWOX6zOk6oWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041835; c=relaxed/simple;
	bh=sqvdVX88bcOElntzs4UI27D+S9vsqjVJa4hVSgNR1yU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PZJiwqNJHz4QXd0xMZM9X/C2F/KEeR0uM4JbU45jX9yEHF5kXxIbSSpeEUD6GWHOaZzF1TbWEbT6XSVNy//l3TAiuVKovKfFVXZKD+YbWPLtLisumWGqhKL71nf6eGQxvSm8RvQWUFNBB85uOtL/ULymR5wrEdnxbMVjc5wyds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wnv54rfW; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wnv54rfW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041834; x=1811577834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sqvdVX88bcOElntzs4UI27D+S9vsqjVJa4hVSgNR1yU=;
  b=Wnv54rfWscrIpSVn7Wgw1OqAWfb2WSdBb0z3F/ZE1RdzUdt6uABLY2tD
   pR59AZ+Uhc6wL06l6Aj0x54FdBkcMNpMPKjHdEaqFl0IAlabnAkWAMrGa
   6ABXzTepvDLdS1IrlwrlgAFpQUGkQ/MGePbbWb31TsZUMzzn3iFl69Z3A
   B2KLbfD4ARqhia5laOj2mQZPb7/+bPQIIlPEExTs6t4Q34XU8/gR5B9t4
   JnY3oZjjaK+Lb9ygCjOiII5/AB1GtTjJvb+iODrPgKL2SkfhcuprQ7pVi
   abrtwlbNxzPtHEvtrmp/hqaqCeZ3X5Jvv3/xleGymYsVKgOIYW/WUbI/o
   Q==;
X-CSE-ConnectionGUID: b44J/0vVSUOki0D32cfPBw==
X-CSE-MsgGUID: MUI9HggGQquruSl+/r0IIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342061"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342061"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:54 -0700
X-CSE-ConnectionGUID: 00zmCkjgScqgCGiOAybqyw==
X-CSE-MsgGUID: urCE0KETQPKnTCyB40G3Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802399"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:49 -0700
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
Subject: [Patch v8 15/23] perf/x86: Support ZMM sampling using sample_simd_vec_reg_* fields
Date: Fri, 29 May 2026 15:56:37 +0800
Message-Id: <20260529075645.580362-16-dapeng1.mi@linux.intel.com>
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

This patch adds support for sampling ZMM registers via the
sample_simd_vec_reg_* fields.

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

Please note ZMM sampling is not enabled yet, it will be enabled in a later
patch when PERF_PMU_CAP_SIMD_REGS is set.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 16 ++++++++++++++++
 arch/x86/events/perf_event.h          | 19 +++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  8 ++++++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++--
 arch/x86/kernel/perf_regs.c           | 16 +++++++++++++++-
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d39710f42ca0..3051a53232c8 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -735,6 +735,12 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_ymm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
 				return -EINVAL;
+			if (event_needs_low16_zmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_ZMM_Hi256))
+				return -EINVAL;
+			if (event_needs_high16_zmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1780,6 +1786,8 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
 	perf_regs->ymmh_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1797,6 +1805,10 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->xmm_space = xsave->i387.xmm_space;
 	if (mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 /*
@@ -1975,6 +1987,10 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_SSE;
 	if (event_needs_ymm(event))
 		mask |= XFEATURE_MASK_YMM;
+	if (event_needs_low16_zmm(event))
+		mask |= XFEATURE_MASK_ZMM_Hi256;
+	if (event_needs_high16_zmm(event))
+		mask |= XFEATURE_MASK_Hi16_ZMM;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 5111eaf8b12a..53c5802317bb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -168,6 +168,25 @@ static inline bool event_needs_ymm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_low16_zmm(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_ZMM_QWORDS)
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_high16_zmm(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+	     fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1d03b86be65d..273840bd7b33 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -735,6 +735,14 @@ struct x86_perf_regs {
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
index 8f513229fbb8..3aacdd4e2764 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -58,16 +58,20 @@ enum perf_event_x86_regs {
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
index 9792483360c7..3c28f28de1e6 100644
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
@@ -129,7 +142,8 @@ int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
 			return -EINVAL;
 	} else {
 		if (vec_qwords != PERF_X86_XMM_QWORDS &&
-		    vec_qwords != PERF_X86_YMM_QWORDS)
+		    vec_qwords != PERF_X86_YMM_QWORDS &&
+		    vec_qwords != PERF_X86_ZMM_QWORDS)
 			return -EINVAL;
 		if ((!vec_mask_intr && !vec_mask_user) ||
 		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK) ||
-- 
2.34.1

