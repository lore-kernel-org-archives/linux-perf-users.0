Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B16436997A;
	Tue, 24 Mar 2026 00:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313252; cv=none; b=OqZOf8RSSGOgEFNCckoHSpDmpt9tM34nHzax5myBos4HGg+DqM60EK7Doh1hPrXVRhKgHAOL9lT4F8jz8rivFOZeqdY3Mu68aaTkT+CQRFyAlr+7j6cc+5AWqh5+9YojSI6rfhdQIasxmgyMBe9kb0buB7HEy80LntcQmOGX3GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313252; c=relaxed/simple;
	bh=hP+ozp4ouWavIle7cZwBH6bgjvITk/iTGJu6EIZP7nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCna+Ns4Jqy3V9EfQQlLF+WHHBStlPim1Zshke3y0MmQRYCaLKQfqhRvtXze6CkJ3Ec+r+1As/LkKYXNqHAgN2H0nbVuZ8cn7I5eLPWNsTyE86RvSp9oupz+ttv4xdUvC0U/tV242j+m8v5BWtsjpaxUMnLBQR/LdKwJ6pO+mnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xtojd2Ri; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xtojd2Ri"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313251; x=1805849251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hP+ozp4ouWavIle7cZwBH6bgjvITk/iTGJu6EIZP7nc=;
  b=Xtojd2Ricf1iiZDg37yEPA2UoQu3I7I44mYa/nfj7Ry6Ibc8FkVAGkJr
   Jr/zsgHKeeaSAiZktdO3lyM1Muvqj+rlKIQmp/TjSY1hQEacyvs8wTp0f
   5TJLdlIIxQ4i/7bYrqGZOXfp3Y6HmkvXdMvcez6+MVh9G0ZX600Jz7yAJ
   otXiohe/wXvEE3zXbRrGHO7vsH2Zi2G4ei9+UtlRtBLJ3qim53qtd+CTd
   DlyGxa6yzpyhXrGnEDJKIro3hAT3S3RLRVQe5ymGy7d5MWv7kKJh71leV
   FwaOS12MaeKdTJeq5e87OmGsE4Q6SUc79JpNfRwTWeMZQIYPEe4T4/p8j
   w==;
X-CSE-ConnectionGUID: tsGEwdzgR1ao0c0UMTD25w==
X-CSE-MsgGUID: q0ZFaNGyQGOCwBQdZOsLQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397278"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397278"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:31 -0700
X-CSE-ConnectionGUID: uyucCZd0TNmoFuNZHiVRZA==
X-CSE-MsgGUID: dkRZGSouRp65HupN2Tja3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322977"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:26 -0700
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
Subject: [Patch v7 21/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
Date: Tue, 24 Mar 2026 08:41:15 +0800
Message-Id: <20260324004118.3772171-22-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c | 52 ++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5772dcc3bcbd..0a32a0367647 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4424,11 +4424,33 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
-		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr &
-	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
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
+		if (event->attr.sample_regs_intr &
+		    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	}
 	return flags;
 }
 
@@ -5910,6 +5932,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 
 	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
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
+		dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
 }
 
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
-- 
2.34.1

