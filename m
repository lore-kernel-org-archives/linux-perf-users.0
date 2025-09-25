Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAF2EB867;
	Thu, 25 Sep 2025 06:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780922; cv=none; b=jNZJP2T5S1zIwE7Jt/8QATSz+6xTB0WME3guS5+xxjZyu8eR4iy9gaNSR0hk5Y5wyAMe9tYX8P2L0cBKJQ/8CRdVmdlFpAQTs5u1fsKG6dEGOgQMt34dI9Pv4/77DRqM8JuwoPEGU7IlVy+1AiCX7Iwj5CIPpX9AHfEIKq5FFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780922; c=relaxed/simple;
	bh=dzaVzf0VWF7QFCSucOyugF7gQNVMYoUu1dd3b2VbUds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cyjTfkGyJE7INiDBg2PEQI0HcnlvRfc63Jx0lZVoWV0MjNl0abEXg91opMDW/I4B4I1Ggkx40Pz2BpFdRG09ynUTiznLAKDBT0UKp9WLLUuJN8Cg9IfO+f5M3l1B82ggunkRz0GDwwN2sxdnOGbxlh9BTSGPTvwqkiv9z8OUg/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B58Tbvbu; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B58Tbvbu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780921; x=1790316921;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dzaVzf0VWF7QFCSucOyugF7gQNVMYoUu1dd3b2VbUds=;
  b=B58TbvbuSR/nAafgtdpJtBgVAIKmIvs8w5dp5EsPKNZvk3x9Uq8Ph19b
   d0LY4YLHKJ/E7BydPbvASdCBab2MifDklBaPaiP6chaqZBqFYvcXavH+L
   3CXaEoTXUUzhb5g8wW9qcfha8gNSSAUoQS4SWCQVv12izdT/SdW+p0Yg6
   t8WhMvrnIB7QmLoe5pQSULljuZWceXPsPbqvOZUoYeurvF8OH0fr7m26c
   +s2k1cMLosab/u1T7pyXV5zEeIrzW+ntwQgjpCQx8mQuqgHBtt9vZElUq
   K6/tATau9CDQAP1RwctVqinYL2LksZtmdoH4hQ45qxiJ0zWQ+xKsn7FFv
   g==;
X-CSE-ConnectionGUID: 0ZXl6DT5SCqReBx3F2dYfQ==
X-CSE-MsgGUID: aP9OW7ptSM6fN66Su6/XkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139617"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139617"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:20 -0700
X-CSE-ConnectionGUID: UyMYGmJ+QG25W1Kvvzcalg==
X-CSE-MsgGUID: nug1ccoJRSyZQ60Zp6vTCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528590"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:15 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 13/17] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
Date: Thu, 25 Sep 2025 14:12:09 +0800
Message-Id: <20250925061213.178796-14-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Enable PERF_PMU_CAP_SIMD_REGS if there is XSAVES support for YMM, ZMM,
OPMASK, eGPRs, or SSP.

Disable large PEBS for these registers since PEBS HW doesn't support
them yet.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 48 ++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2575ec0d2b77..dd46629c1ce6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4030,8 +4030,32 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+	if (event->attr.sample_simd_regs_enabled) {
+		u64 nolarge = PERF_X86_EGPRS_MASK | BIT_ULL(PERF_REG_X86_SSP);
+
+		/*
+		 * PEBS HW can only collect the XMM0-XMM15 for now.
+		 * Disable large PEBS for other vector registers, predicate
+		 * registers, eGPRs, and SSP.
+		 */
+		if (event->attr.sample_regs_user & nolarge ||
+		    fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE ||
+		    event->attr.sample_simd_pred_reg_user)
+			flags &= ~PERF_SAMPLE_REGS_USER;
+
+		if (event->attr.sample_regs_intr & nolarge ||
+		    fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+		    event->attr.sample_simd_pred_reg_intr)
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+
+		if (event->attr.sample_simd_vec_reg_qwords > PERF_X86_XMM_QWORDS)
+			flags &= ~(PERF_SAMPLE_REGS_USER | PERF_SAMPLE_REGS_INTR);
+	} else {
+		if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
+			flags &= ~PERF_SAMPLE_REGS_USER;
+		if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	}
 	return flags;
 }
 
@@ -5292,6 +5316,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 
 	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+
+	if (boot_cpu_has(X86_FEATURE_AVX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_YMM;
+	if (boot_cpu_has(X86_FEATURE_APX) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_APX;
+	if (boot_cpu_has(X86_FEATURE_AVX512F)) {
+		if (cpu_has_xfeatures(XFEATURE_MASK_OPMASK, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_OPMASK;
+		if (cpu_has_xfeatures(XFEATURE_MASK_ZMM_Hi256, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_ZMM_Hi256;
+		if (cpu_has_xfeatures(XFEATURE_MASK_Hi16_ZMM, NULL))
+			x86_pmu.ext_regs_mask |= XFEATURE_MASK_Hi16_ZMM;
+	}
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
+
+	if (x86_pmu.ext_regs_mask != XFEATURE_MASK_SSE)
+		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_SIMD_REGS;
 }
 
 static void update_pmu_cap(struct pmu *pmu)
-- 
2.34.1

