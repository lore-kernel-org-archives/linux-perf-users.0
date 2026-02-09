Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF90331DDB8;
	Mon,  9 Feb 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621989; cv=none; b=Z0yPHRprzYPTLjsB+Fc5j6k99w+vtZ46EbdonzdnfSinwAbKXi0JW6IBq2PN5URg9EuCfXmYOheVRZMXuWC+zqd2T6BzslHZiMG6/FMXH965ru58xuVNJfCYfb81v30bPzQ/Fl1rq1VO43jp6ZnbrekA9U5DLRGvoiR2ZwtRM5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621989; c=relaxed/simple;
	bh=OmJR/F8UAnx/9Y7nOixVwWgYpVft3qqpR2tZE0MZBzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U6U01FJFwjYZvQavJTT/KeADFV9GRhFA/26/3h7E3HS5N4b3q7wSllLTxEi2DRYOx0Xq0XSR0kTeugC41Hjdl2NgAsZVayjO8l7UNdxaUtc0n3zvoLdAgPIL77/O/fcN6AsedAJ7gGAFNpRGdsI4yAo7MjG5b8LBTXM96YB5v58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8ctwHsg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8ctwHsg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621990; x=1802157990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OmJR/F8UAnx/9Y7nOixVwWgYpVft3qqpR2tZE0MZBzw=;
  b=N8ctwHsgEfAm0cp9ykrwLtaBrIi5ztXNj/g+RCR379yM/XINdjSZGnmW
   uETDBIUL7BqwytOOOohwmAtEtjux/IVolou0rJVP0uwGZG5dnCV/IHxQY
   RbDsVnt3bk4FQ26rbg6s9aIhKRrUvX5NHm2+uRmxUyKzJPTXx1WCl12Lk
   PLhgD0cEOwlvWLbQIknvYpjRmzWmfr1ucQy9bOACPIN8yO473q9Byl9qD
   t09b7dkaCRfDdPsN4LritcCj3dYXcCD3zvhP57uhsu6FIdwIO8a8sU+Rb
   WtBBgQ/g5P44e7zUyJRhIPPdPI0SJmemwBLHySiiwRU1skdCFodz98EyX
   w==;
X-CSE-ConnectionGUID: UXWAIUc1SS+BXyzDH1Q+fg==
X-CSE-MsgGUID: INe1A2oLQCyG+sUmdUModQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098556"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098556"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:30 -0800
X-CSE-ConnectionGUID: DVkajciHQ+C0TvvKD2ZErQ==
X-CSE-MsgGUID: ytUSz/27RGmYO0NTMoYPMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694793"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:26:25 -0800
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
Subject: [Patch v6 20/22] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
Date: Mon,  9 Feb 2026 15:20:45 +0800
Message-Id: <20260209072047.2180332-21-dapeng1.mi@linux.intel.com>
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
index ae7693e586d3..1f063a1418fb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4426,11 +4426,33 @@ static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
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
 
@@ -5904,6 +5926,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 
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

