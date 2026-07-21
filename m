Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA82FF669;
	Tue, 21 Jul 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615676; cv=none; b=Zdam1zYErsqJCF2vmrldUXa63nadzPaV4m4E0xT1VK2F1x/jHlE8nlPuHfqgwKiGkZeGLEAHPCqV19XWLA+G/A8Av4abg7Ec+qQTH+NH7hnCi1RcgANgOtA4oR+enDUbSnyXnQ+XIxKsZ5H/mTr8frmhTvSg57ohQk/AVbGEotQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615676; c=relaxed/simple;
	bh=UwLDz3og7P9oeQnFXqwNrNhI6ciuTdzOaGMUIbiB5Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GTbblStsdgbosAzwmast8xRNrLYj374LdCdzaSkvgEox+8Y/2jRdakjfsgad7X+S3GiXnPUNxYmYi/njB/08U2OpRhj9pu6v1zxQKOrGlfpSU7RDSYk2pHWyFX8JTjSOnk5ggFzBgG6CfvcIfVjnE0m3hxqjWfGG8CJJ8WXZNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjK1tyMj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjK1tyMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615673; x=1816151673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UwLDz3og7P9oeQnFXqwNrNhI6ciuTdzOaGMUIbiB5Ys=;
  b=jjK1tyMjkqy64poDOFDuiCFXqwXIQ3zAwiCX6nsFvtEEWpneecUqgpn/
   sKmXOMa0RemxCdbadudNrPPK5oM2WNx4QwOMRSL22I/05pZGwHNfN0C1X
   4a5Lkvg4nevLUqjtHqD6MiGfibhvyQsOQJob3H5yrBNY3hjy1uBmjOAxO
   hdfqWnR3wbFPQZfJga7vlceIYH3tTPHwG5g0L4zsFKFjp5uTPX3NPRlQ9
   hM98u2epC4warUue7nDAt6CN2xLOI+Zxbxo2uQgjzD4XbobnBqQrPZgHr
   W6TeuhOi6sV9E8b1yy3wHrfogKNbO4prKCQgUY7NVMgCh+3uCc1UFJ27N
   A==;
X-CSE-ConnectionGUID: hpoyR9QMRra6aVGHAmye+Q==
X-CSE-MsgGUID: +DLTHaLHTbqtp1hmUlCb3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565580"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:34:30 -0700
X-CSE-ConnectionGUID: ZWeuz6cFQu6CMcN3QgCxYQ==
X-CSE-MsgGUID: SAEHvIi1SeexTiyqi9Fiyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656250"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:34:25 -0700
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
Subject: [Patch v10 21/23] perf/x86/intel: Advertise PERF_PMU_CAP_SIMD_REGS capability
Date: Tue, 21 Jul 2026 14:25:04 +0800
Message-Id: <20260721062506.3745816-22-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set PERF_PMU_CAP_SIMD_REGS once XSAVES-backed extended state beyond XMM
is available for sampling, e.g. YMM, ZMM, OPMASK, eGPRs, or SSP.

Keep backward compatibility unchanged. When only XMM sampling is
available, continue to expose only PERF_PMU_CAP_EXTENDED_REGS. Expose
PERF_PMU_CAP_SIMD_REGS only when additional SIMD/predicate register state
is supported.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4eeb08352f4c..5d1f00f3aa47 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6229,7 +6229,27 @@ static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 	 */
 	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 
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
+	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK) &&
+	    cpu_has_xfeatures(XFEATURE_MASK_CET_USER, NULL))
+		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
+
 	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+	if (x86_pmu.ext_regs_mask > XFEATURE_MASK_SSE)
+		dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
-- 
2.34.1

