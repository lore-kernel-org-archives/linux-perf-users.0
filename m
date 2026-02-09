Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E668B31B810;
	Mon,  9 Feb 2026 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621970; cv=none; b=dgVnRmS/cvgwGmKFnvuRJ/nLES+gjut/y+kPrW0ZG/GFnE495n7uaIUnBqGNIJP8o9W8IB4FXsYVzMfNjoKovOnp2rkAwFHajBKYbe8tew7ZS9kJ4PuS4dLk8BvAFxBOgI5d04oEiXI23sNWcccrdIv1JyT4ixMdea689gI8bxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621970; c=relaxed/simple;
	bh=PHKbcMfar062pK5khryyeDK66m32OOkgPaAuNjwnWRE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h8jGVoYZ+yWF4JpGOLeko7i5qaHoBeiOCPgxu4BHhZAzMuGMnFLSiTB8Fo/qTZMTkIsFFq9S84jqSyGgzsv/ndDEQ539dGCNxKSwY5JJ3dmEs4x+J9j5KgQMQuvzJlMGtcOewqm6F1VWRxm2wMKfQ86IUhx0CijC9Pm9essM0+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gp7BcsRm; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gp7BcsRm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621970; x=1802157970;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PHKbcMfar062pK5khryyeDK66m32OOkgPaAuNjwnWRE=;
  b=Gp7BcsRmXNvQLqOnkbbKXQ31weRqNTwP4kVeAWnb9JaE0Kk1x1ilQ/yZ
   L/H6JHZ5O6I1OidHgzmZfuS7wRU+nmLKnEB5afAaR9WamC7nR+KMtZD3J
   aDUki/czVHaNGhlHLRkv2KcWoWaWmzyVlLCaGfplh5FHhZNWYM9IF+MbV
   /AxCJQosHOaYP3uVne5nQqONjq6+PXLy0ipFNz33HqNAWOLD0f5bV3Be0
   QhafkDIwWddOiw3A/ECV+cPkbL+wvGksbowSzvI5mBMfoohVvb4tREfbR
   Kb7Vk22kahmAWI86RFMvhFE7ykIL5F0Il+mI05IJ9ET732tgyW+1yiVum
   A==;
X-CSE-ConnectionGUID: st0bM7bsSYCnXFee1rFqmg==
X-CSE-MsgGUID: ZmdZ33y+T++sXWkiprWlOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098509"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098509"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:10 -0800
X-CSE-ConnectionGUID: 3v0V3odgR0SPEIUWvNdLBQ==
X-CSE-MsgGUID: OW7cLhz0T1Ctx6ekvtq6oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694770"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:05 -0800
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
Subject: [Patch v6 16/22] perf/x86: Enable OPMASK sampling using sample_simd_pred_reg_* fields
Date: Mon,  9 Feb 2026 15:20:41 +0800
Message-Id: <20260209072047.2180332-17-dapeng1.mi@linux.intel.com>
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

This patch adds support for sampling OPAMSK registers via the
sample_simd_pred_reg_* fields.

Each OPMASK register consists of 1 u64 word. Current x86 hardware
supports 8 OPMASK registers. The perf_simd_reg_value() function is
responsible for outputting OPMASK value to userspace.

Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
OPMASK sampling.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  5 +++++
 arch/x86/kernel/perf_regs.c           | 15 ++++++++++++---
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b279dfc1c97f..2a674436f07e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -729,6 +729,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1856,6 +1859,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static inline void __x86_pmu_sample_ext_regs(u64 mask)
@@ -1887,6 +1891,8 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 /*
@@ -1952,6 +1958,8 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f6379adb8e83..c9d6379c4ddb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -177,6 +177,16 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_opmask(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_simd_pred_reg_intr ||
+	     event->attr.sample_simd_pred_reg_user))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a57386ae70d9..6c5a34e0dfc8 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -726,6 +726,10 @@ struct x86_perf_regs {
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
index d6362bc8d125..dae39df134ec 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -60,13 +60,18 @@ enum {
 	PERF_X86_SIMD_YMM_REGS      = 16,
 	PERF_X86_SIMD_ZMM_REGS      = 32,
 	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
 };
 
+#define PERF_X86_SIMD_PRED_MASK	GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		16
 
 enum {
+	PERF_X86_OPMASK_QWORDS   = 1,
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
 	PERF_X86_ZMM_QWORDS      = 8,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index fe4ff4d2de88..2e3c10dffb35 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -86,8 +86,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 	struct x86_perf_regs *perf_regs =
 			container_of(regs, struct x86_perf_regs, regs);
 
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
@@ -138,7 +144,10 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
 	}
-	if (pred_mask)
+
+	if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+		return -EINVAL;
+	if (pred_mask & ~PERF_X86_SIMD_PRED_MASK)
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

