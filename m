Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E223B8BB6;
	Fri, 29 May 2026 08:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041866; cv=none; b=inihsyy0v3VsSQdDNvyt/kxfE220wTo30T57Ma0iwP/7xkueNsiFwfQAJ9fL6m7ovH1QtmGIJ2tI8yBNIbBvGY8hB9MLfpkE5HhVKg4DQuhH+qRwj+lFJnyB4+Q2xDPSDZkE6hMk8ZKhdnIWcYRiyPKasSRQD8A2phKnyzbJDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041866; c=relaxed/simple;
	bh=iw9fsApi5+CdPLB3kDC+sPXSUN/gnfbdEGcLHqHLaN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rktcszYm0hHR4jTA0QS6ihhdLNSwRwLAluaxbbCd5LPWvezI3p3oAvkxKWBB5w1dZP+zKYrlcooxHfxPO4U6QTsKRB0N0i8Xr8wBPb5wm1/2s+V++Nfuehxj/1wN71cGO2ipUpEm4bQAzY7qEz3YdBRsQP2sDezmu9x8Zo6VJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+ihK5Gh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+ihK5Gh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041865; x=1811577865;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iw9fsApi5+CdPLB3kDC+sPXSUN/gnfbdEGcLHqHLaN8=;
  b=d+ihK5GhERy5Nrr8JNS7CjR8z5mH5ltC97hMtdiZdoCX2Cn87QrPQnOW
   zR5KLhoXGFIRdYWNhPdKmGEnhYblSap/7Eu7y6+gCaWwkXV4D/c6gDWH5
   pMlugetynLeFBaiTnue0by5wEq3UO9Ve8C5jeMhd6ik1D2HiFxelS9/AT
   kNQaY/Yblb4EOVhFNegSg7ekOZ+7ri966zRoPXEqqtYSEmt+axCSrR1jX
   gjt9RLjOJcBOrpHIG30mbBaTTBzqoHcR/qI4w0n0vOK8JArr1cAmf7Mws
   nDyWyHGtOJ9St9g/JHp94E6zRThRqIdIl3AoN0yyZ0gqnfZtQWhhBDnmH
   g==;
X-CSE-ConnectionGUID: tkxZS4rpRxGuXHrEs+ARow==
X-CSE-MsgGUID: MKw8E5thT5qombUlK7Ti5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342231"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342231"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:24 -0700
X-CSE-ConnectionGUID: 81VQ2tqtSl6h5SChSmh7KQ==
X-CSE-MsgGUID: wk73pliHSp277tk8ghePBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802579"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:04:19 -0700
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
Subject: [Patch v8 21/23] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
Date: Fri, 29 May 2026 15:56:43 +0800
Message-Id: <20260529075645.580362-22-dapeng1.mi@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

Enable the PERF_PMU_CAP_SIMD_REGS capability if XSAVES support is
available for YMM, ZMM, OPMASK, eGPRs, or SSP.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 679781519f8c..eef5d116aa06 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6316,6 +6316,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
 	 */
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

