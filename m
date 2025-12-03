Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66597275AFF;
	Wed,  3 Dec 2025 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745157; cv=none; b=VSZH/uEWl76+u5sgUnl1CgKLgxKsQ4VJQc6ukeRgRavBYGJSJ7o1e2puRpZRnDsQw0lzy455lkKg3zg2aDBxCb2PqDAJC0EO08dn9u8tGt9JOd64P7xI/332Zt+BweJaczelh8q/hemQbiZVD5z8WTzzDf7RNsh2H/jTXwmmT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745157; c=relaxed/simple;
	bh=LP8XvBQArCn/RHlcBCgIs9eVBDldJeFN+PWTqovSrwo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f3Ft3/PoDYRmx8u7p4czzVZZt5fCYCQg44V0KUIR1a8f9vga1b6XQiJjB8NNblt120AkmQ8e/W52CFr1R05qamLgvqXjVfu++V/zcX/U4QSplUR7gSKhCX6Wu37esG+1CNrNg7385aKWrpENZKTqtFD73GAR42ZCy7epV8nVZyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T8RX8IDW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T8RX8IDW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745155; x=1796281155;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LP8XvBQArCn/RHlcBCgIs9eVBDldJeFN+PWTqovSrwo=;
  b=T8RX8IDWfqTNvwTUmHr5XseLvFXtcRp1zKUYKaLjKhhuqlkfVVIoJBXc
   0jdTuIeEFPp27hkMm1c9lQ/P8ey200b3bz/1Fw7jpOXPeOdl2ivJ0Qi5s
   Xv/EWzKPx1hq3DaYEivfAXLYMeVG+0lrfH7mExX56vUM8Nmxy66Sb047j
   /1TlOl4ZvV/+8cOXp8OMusZdz8BZXuBaw+crxAVOqYV3rIqzUxhdLA1WS
   uDg0yuxHC3Wk9Z3trQlUzRz2SG74tvkeYO+5ol0DVmYbBjuTzxu7cNkLF
   zWQr4nrFUsDeLIeuMrKA6aKKCDwWYH9y9zRtRzkqd0vXdclxYiaYv8Pj+
   g==;
X-CSE-ConnectionGUID: UUv4TWMBQoSEOPXm+G8HRg==
X-CSE-MsgGUID: m6hZM0cFRFeG9RUpRL7L0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324904"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324904"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:13 -0800
X-CSE-ConnectionGUID: CRzGbckPSIKCfbWCYPX8Kw==
X-CSE-MsgGUID: YPkz25gyRKeTzvUplq7ENg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199004008"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:59:08 -0800
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
Subject: [Patch v5 14/19] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
Date: Wed,  3 Dec 2025 14:54:55 +0800
Message-Id: <20251203065500.2597594-15-dapeng1.mi@linux.intel.com>
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

Enable the PERF_PMU_CAP_SIMD_REGS capability if XSAVES support is
available for YMM, ZMM, OPMASK, eGPRs, or SSP.

Temporarily disable large PEBS sampling for these registers, as the
current arch-PEBS sampling code does not support them yet. Large PEBS
sampling for these registers will be enabled in subsequent patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 50 +++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b5c89e8eabb2..d8cc7abfcdc6 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4160,10 +4160,32 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~PEBS_GP_REGS)
-		flags &= ~PERF_SAMPLE_REGS_INTR;
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
 
@@ -5643,6 +5665,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 
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
 
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
-- 
2.34.1

