Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC5929B766;
	Wed,  3 Dec 2025 06:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745133; cv=none; b=sGRCPO1Gq6gOFdh6PqyazHFhrO8ConF5UN8hqjNd+Kip04SdTqdxV0aK9S3mxZgNpwD2sMP6T0kFpn2zZzExiOpaJAntspyQoLFOhlP9dUP3AxL/J1g6O9pMabUg3JanxXzeqj9PC3ytB1Rirbs9HSekPVDD7H8ogmgQ9WiIFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745133; c=relaxed/simple;
	bh=5baxVJIuW2bmEUDAuOVJ1r4h89h+uSYhiPFa7r9dWvw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HoEjRrt4uCIY2sPrAmE+iC8waTLsjyMvbXLdBvS0s42nk2BbpPKTKgUZ97suZviLVgE/dgn/rXdDEcPWEran0u3y39ElAuANL15p+H06ABbMcrh9EisqOzn+elQyQ6xe1VN7A7sNRUzv2DEtEujnzChs/twaNwTY/dnqTlqY94M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n3b1nlxD; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n3b1nlxD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745132; x=1796281132;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5baxVJIuW2bmEUDAuOVJ1r4h89h+uSYhiPFa7r9dWvw=;
  b=n3b1nlxDBGqle5nHVFaJXpn+RCNV8yad13P66s1sXrrTUQj8yp2yXF92
   s9LMhXiKLg8o7J5ui+j+hCPVD/Q/9Y9j0cGZCw/GnG3YCJ9plepWVobyN
   0bqnqID/KI7erPZtPWs0hpCfkV1Uz/VsBQfq7pxk8IywVtbI/jz+R1oXb
   bGUf3Mp12qLEENTfIryOcGG0z9wOTrbe2axntHPG3j4WWDFosL/Rk70+o
   5hk+aqcG8J2i8Ukr7XSM1d1YhnCIh+4B+OZrKF71IuNANp9xIpWpn/fcy
   ari8pyU9dh2nuJMfiAg0p3Z3JYKZD9d0j2SiMn3GJigcXjlU7a2jUbgx6
   w==;
X-CSE-ConnectionGUID: o9zkXKS4QO6zgz00B9gKPg==
X-CSE-MsgGUID: +dKbn14OTt+Wyo1iYUjFNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324859"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324859"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:52 -0800
X-CSE-ConnectionGUID: ux7fYehoThGmgj2I8SSxqQ==
X-CSE-MsgGUID: pRG5YlaAS1WbJ2Y/GFejrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003925"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:47 -0800
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
Subject: [Patch v5 10/19] perf/x86: Enable ZMM sampling using sample_simd_vec_reg_* fields
Date: Wed,  3 Dec 2025 14:54:51 +0800
Message-Id: <20251203065500.2597594-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/include/uapi/asm/perf_regs.h | 11 +++++++++--
 arch/x86/kernel/perf_regs.c           | 15 ++++++++++++++-
 5 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b1e62c061d9e..d9c2cab5dcb9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -426,6 +426,10 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 
 	if (valid_mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (valid_mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (valid_mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 static void release_ext_regs_buffers(void)
@@ -741,6 +745,12 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 
@@ -1821,6 +1831,8 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 
 	perf_regs->xmm_regs = NULL;
 	perf_regs->ymmh_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 }
 
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
@@ -1892,6 +1904,10 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_SSE;
 	if (event_needs_ymm(event))
 		mask |= XFEATURE_MASK_YMM;
+	if (event_needs_low16_zmm(event))
+		mask |= XFEATURE_MASK_ZMM_Hi256;
+	if (event_needs_high16_zmm(event))
+		mask |= XFEATURE_MASK_Hi16_ZMM;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3d4577a1bb7d..9a871809a4aa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -154,6 +154,25 @@ static inline bool event_needs_ymm(struct perf_event *event)
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
index 25f5ae60f72f..e4d9a8ba3e95 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -713,6 +713,14 @@ struct x86_perf_regs {
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
index 4fd598785f6d..96db454c7923 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -58,22 +58,29 @@ enum perf_event_x86_regs {
 enum {
 	PERF_REG_X86_XMM,
 	PERF_REG_X86_YMM,
+	PERF_REG_X86_ZMM,
 	PERF_REG_X86_MAX_SIMD_REGS,
 };
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
 	PERF_X86_SIMD_YMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
+	PERF_X86_SIMD_ZMMH_REGS     = 16,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
+#define PERF_X86_H16ZMM_BASE		PERF_X86_SIMD_ZMMH_REGS
+
 enum {
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMMH_QWORDS     = 2,
 	PERF_X86_YMM_QWORDS      = 4,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
+	PERF_X86_ZMMH_QWORDS     = 4,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 8aa61a18fd71..0a3ffaaea3aa 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -90,6 +90,13 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -100,6 +107,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -117,7 +129,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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

