Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193371EB5F8;
	Mon,  9 Feb 2026 07:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621965; cv=none; b=dxkXu8alyA4f5DRG+YdNJrLMCZdMwaLXsJ1++E5wAdSY/sbb0HNwSMak6I+Df1EjZjtxGBg0x1atQc5iGVdsg0T5St46anAfXuKqRCu7KzFzNitOFs8fx9eD51Attu2r9mv9zBrJ8Cw8oltpHoLy4UrNUSR7bKR4tISLJIr9mhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621965; c=relaxed/simple;
	bh=o13rjsc6azcBrTyJhYV2gAHNmsQeWLjyELcP8IiTzzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0hV3dx98rPj2lsjbD6wzm1cviKyst13y17+HKGS+XDdk2tmemFjfEi1cyr6vUWOl1yK+RN766edVlwlxtj9whOXf3+hcqlC1y/P/32dGwxbA2ifH8zoglwLKZJTPMGcnT+Y6vqoKIvQlKd77P29oTGQJaD+glt5sMB/Vl1nE0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kcaa2kew; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kcaa2kew"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621965; x=1802157965;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o13rjsc6azcBrTyJhYV2gAHNmsQeWLjyELcP8IiTzzQ=;
  b=Kcaa2kewlra5Jwho9mdVXvOZd7OutX2OUmHTp+zgrJhAY/x+K98EDqrw
   vcPd3XaHFX0n5b+rbxKLVOqQDrMWKpEoMWh+5weCeT7eh527cFvB1aoPb
   Ns/jaag6ZFqgHiRbxSylUGOPerO44gWUQdwAhDIa3MrwNpS14sXor6ArV
   7yK0irbONSHeaVhj36+ONZU8RCtE/KIEz5OMZYAwmJl8GlCuH2UO1nSBd
   okxN5oVpiNzJ8kZAAlYhLekZzqvVK4jKRm3cEtThiM7JTysjgibbJlrOU
   /DUJCtJONfnOLE4eI86Gw45EruwRIwmZ5fzTJoFnu91XS4oKWfN7iHcpg
   g==;
X-CSE-ConnectionGUID: jAbeGcA6SYa0TQHYyukypQ==
X-CSE-MsgGUID: rODv33nTTWa0HVod56rvHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098495"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098495"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:05 -0800
X-CSE-ConnectionGUID: GPt/w7q8R+yINL8riLTRRg==
X-CSE-MsgGUID: Hbf5OymLQ1q53CRC2Nkh+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694763"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:00 -0800
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
Subject: [Patch v6 15/22] perf/x86: Enable ZMM sampling using sample_simd_vec_reg_* fields
Date: Mon,  9 Feb 2026 15:20:40 +0800
Message-Id: <20260209072047.2180332-16-dapeng1.mi@linux.intel.com>
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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 16 ++++++++++++++++
 arch/x86/events/perf_event.h          | 19 +++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  8 ++++++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++--
 arch/x86/kernel/perf_regs.c           | 16 +++++++++++++++-
 5 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e80a392e30b0..b279dfc1c97f 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -723,6 +723,12 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 
@@ -1848,6 +1854,8 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 
 	perf_regs->xmm_regs = NULL;
 	perf_regs->ymmh_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 }
 
 static inline void __x86_pmu_sample_ext_regs(u64 mask)
@@ -1875,6 +1883,10 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->xmm_space = xsave->i387.xmm_space;
 	if (mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 /*
@@ -1936,6 +1948,10 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
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
index 4f18ba6ef0c4..f6379adb8e83 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -158,6 +158,25 @@ static inline bool event_needs_ymm(struct perf_event *event)
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
index bffe47851676..a57386ae70d9 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -718,6 +718,14 @@ struct x86_perf_regs {
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
index eac11a29fce6..d6362bc8d125 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -58,15 +58,19 @@ enum perf_event_x86_regs {
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
 	PERF_X86_SIMD_YMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
+#define PERF_X86_H16ZMM_BASE		16
+
 enum {
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 4062a679cc5b..fe4ff4d2de88 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -78,6 +78,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 }
 
 #define PERF_X86_YMMH_QWORDS	(PERF_X86_YMM_QWORDS / 2)
+#define PERF_X86_ZMMH_QWORDS	(PERF_X86_ZMM_QWORDS / 2)
 
 u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			u16 qwords_idx, bool pred)
@@ -92,6 +93,13 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -102,6 +110,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -119,7 +132,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 			return -EINVAL;
 	} else {
 		if (vec_qwords != PERF_X86_XMM_QWORDS &&
-		    vec_qwords != PERF_X86_YMM_QWORDS)
+		    vec_qwords != PERF_X86_YMM_QWORDS &&
+		    vec_qwords != PERF_X86_ZMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
-- 
2.34.1

