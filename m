Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43D33EC6A0;
	Mon, 24 Aug 2026 08:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560536; cv=none; b=JwJXrkMgSvNjQsg+2nDiShfMGjBQ4IuT8Gcp4Les822Vl0M1qwRX9OA5LZVOdU0ZBPyDDfHti5gPUMw23XDhqnwAfg7hx7ciswVD9WMv6ejGOyMNyEzXXdwhSc85FWXO4SZhVmaZ+gOO+4aJZ411SxWWN/eXkvq21ONGc9gdmSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560536; c=relaxed/simple;
	bh=dJYR2H6e+XdgfQGiTqTbV4LwDrKwVzXz8Oa7pfbTFug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KqEpOWA6+0IJlcMXekRiavKEOIZ5vCJzrU4yHls4tgWUfZs5tiIoWkQj5YejY4zV58zuBREejkLKQl7gsdPaMLu9+H39T6ahdYHMiSrb3yOLwoO6crkboVIYOKA/9nws2LfR4GpicsQ6IywD7vSazyaznLXvn2plZOGuTsvdC0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ToROb4qo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ToROb4qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560535; x=1819096535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dJYR2H6e+XdgfQGiTqTbV4LwDrKwVzXz8Oa7pfbTFug=;
  b=ToROb4qoModFdxlRiIZPm8UFwEaiyh4kMzhjPHTXKGzi+RuRTq3A2w4K
   EEjURGZWtYrMh2mJFJXCiI9fdUzq+n/M+L9AviSS3wZOEF8cmFunWptRL
   cem0FSDieFDu6UkWjyg7qUifhp0nF7WUSItdr5EOylavR8wJPD0xhzZ3M
   RK0MfUp9KwOJrCnNrO0t4cpItUXAlpn34EHAcn3L4J0MDex/krzuYa2A/
   9wxw2JV21mbyvdmuyNfoawRagpwMA8m9bf7HPM8TWzw3EsECsXjdAtQsC
   rNv91y2CmWJREE7kQ6fUYBGj9fUnnoEitzgG6/AJiHlkVeZnRMeli7GR8
   A==;
X-CSE-ConnectionGUID: noydn7c5TUGjE1cTeEHEzA==
X-CSE-MsgGUID: h5rRVv0oQzqvq6/scr9N5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598861"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598861"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:34 -0700
X-CSE-ConnectionGUID: 9/LA25cFQMqfrvhvZrGwUQ==
X-CSE-MsgGUID: ZdLgapnKRIqZOEEijqbOgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326608"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:29 -0700
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
Subject: [RESEND Patch v10 16/23] perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
Date: Mon, 24 Aug 2026 16:27:24 +0800
Message-Id: <20260824082731.1013973-17-dapeng1.mi@linux.intel.com>
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

Support sampling of OPMASK registers via the sample_simd_pred_reg_*
fields.

Each OPMASK register consists of 1 u64 word. Current x86 hardware
supports 8 OPMASK registers. The perf_simd_reg_value() function is
responsible for outputting OPMASK value to userspace.

Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
OPMASK sampling.

OPMASK sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 13 +++++++++++--
 arch/x86/events/perf_event.h          | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  5 +++++
 arch/x86/kernel/perf_regs.c           | 24 +++++++++++++++++++-----
 5 files changed, 66 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b0e3f1b9fa19..9bfb1810a9fe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -642,10 +642,11 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_xmm(event) &&
 	    x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
 		return -EINVAL;
-	/* PEBS does not support YMM/ZMM registers sampling yet. */
+	/* PEBS does not support YMM/ZMM/OPMASK registers sampling yet. */
 	if (event_needs_ymm(event) ||
 	    event_needs_low16_zmm(event) ||
-	    event_needs_high16_zmm(event))
+	    event_needs_high16_zmm(event) ||
+	    event_needs_opmask(event))
 		return -EINVAL;
 
 	return 0;
@@ -670,6 +671,9 @@ static int event_simd_regs_validate(struct perf_event *event)
 	if (event_needs_high16_zmm(event) &&
 	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 		return -EINVAL;
+	if (event_needs_opmask(event) &&
+	    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+		return -EINVAL;
 
 	return 0;
 }
@@ -1836,6 +1840,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1857,6 +1862,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 /*
@@ -2031,6 +2038,8 @@ static u64 get_simd_sample_mask(struct perf_event *event, u64 sample_type)
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (__event_needs_high16_zmm(event, sample_type))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (__event_needs_opmask(event, sample_type))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	return mask;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f59551200f18..e6365438bb3d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -263,6 +263,33 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
 			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
 }
 
+static inline bool __event_needs_opmask(struct perf_event *event,
+					u64 sample_type)
+{
+	if (!event->attr.sample_simd_regs_enabled)
+		return false;
+	if (event->attr.sample_simd_pred_reg_qwords != PERF_X86_OPMASK_QWORDS)
+		return false;
+
+	if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_USER) &&
+	    (event->attr.sample_simd_pred_reg_user > 0))
+		return true;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_simd_pred_reg_intr > 0))
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_opmask(struct perf_event *event)
+{
+	return __event_needs_opmask(event,
+			PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 75394c4e8bc3..49112e097e99 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -745,6 +745,10 @@ struct x86_perf_regs {
 		u64	*h16zmm_regs;
 		struct avx_512_hi16_state *h16zmm;
 	};
+	union {
+		u64	*opmask_regs;
+		struct avx_512_opmask_state *opmask;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index b88d0b6822fd..61aec60623f1 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -62,14 +62,19 @@ enum {
 	PERF_X86_SIMD_YMM_REGS      = 16,
 	PERF_X86_SIMD_ZMM_REGS      = 32,
 	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
 };
 
+#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		16
 
 enum {
 	/* 1 qword = 8 bytes */
+	PERF_X86_OPMASK_QWORDS   = 1,
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
 	PERF_X86_ZMM_QWORDS      = 8,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 93370d465786..87297da5e44b 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -89,8 +89,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 	if (!(perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
 		return 0;
 
-	if (pred)
-		return 0;
+	if (pred) {
+		if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_PRED_REGS_MAX ||
+				 qwords_idx >= PERF_X86_OPMASK_QWORDS))
+			return 0;
+		if (!perf_regs->opmask_regs)
+			return 0;
+		return perf_regs->opmask_regs[idx];
+	}
 
 	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
@@ -154,9 +160,17 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 			return -EINVAL;
 	}
 
-	/* PRED registers are not supported yet. */
-	if (pred_qwords)
-		return -EINVAL;
+	if (pred_qwords) {
+		if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+			return -EINVAL;
+		if (pred_mask & ~PERF_X86_SIMD_PRED_MASK)
+			return -EINVAL;
+		/* Only full-register sampling is allowed. */
+		mask = pred_mask;
+		if (pred_qwords == PERF_X86_OPMASK_QWORDS && mask &&
+		    !bitmap_full(&mask, PERF_X86_SIMD_OPMASK_REGS))
+			return -EINVAL;
+	}
 
 	size = sizeof(u64) * 4;
 	size += (hweight64(vec_mask) * vec_qwords +
-- 
2.34.1

