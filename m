Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB6D3CC313;
	Tue, 16 Jun 2026 04:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585568; cv=none; b=MOWvbeKGyuL8Cx5bVIHGksND31n/2vi+jzKcmMpZHoY1g8dJPKNQ7Dzk8aGHYRTwXL6r9wWk3B6B01ok3lNTQlHLCtDRGamhUUF8zwfRL1Vjs7pJXyPVaoBonmKKt8aSQj+I+0XPj+tflME17hlwaOsxb/qaxB6ywksWSHkYAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585568; c=relaxed/simple;
	bh=ogf9/luB2/8LSMWwg/TuzGp2sXmJQ4z0smPqvSmicHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QBCE84GDnC60E4KoAUkyvnf259GHqgH3BJYr9tXcHMy6vVobQA0mWK/NPe5ljiIPPcaVJTFvWY7IsKWkNBORIcgB0dS962OVtvZD2LEa+uffb6HBPca/3F7YKvd2mlwAdbJ0avwmOnG+rtvm2g2LlXTDRJpjdY4AVG7Ida+K6bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DftKRlJR; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DftKRlJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781585567; x=1813121567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ogf9/luB2/8LSMWwg/TuzGp2sXmJQ4z0smPqvSmicHo=;
  b=DftKRlJRzB8r5dsixUtVv+WXwXUJnJO9CljEt5SUgX9RFsMC9q2fn8Zo
   U7pr9ku75r0N4Dx3J+uNwFNQMmOJR8GBYBxTp9104N6P0h/Lg3Kn1IXyz
   7/otRFP5sTTApvjMdIDbAZS6+ZQOfI+e/6rutj07zFf2pcF0RvZUvStG2
   1uLNYs+VVi9wFrGGGmcNes6ypRI4/yV+FxzUUzHxV03qZiabCHwixIVqy
   a8FokahZpLv1eKRixyLLXJBCHi9NCwENUyIhYVtHpjs67ajMQnagu8lKd
   +fqWvPdkaQJvw08FTNNzHZj6M3JoH7EpUIX3aXaFsnVN0S1/D5lvXHi2L
   g==;
X-CSE-ConnectionGUID: +3zzi9ijTwK6K2WGLqnpEA==
X-CSE-MsgGUID: GWcLYLBWSRqEmFeRi3RpoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82445441"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82445441"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 21:52:46 -0700
X-CSE-ConnectionGUID: J8zSNza2QfSzaqHvzArOVw==
X-CSE-MsgGUID: V9a1tn4HRP6P2fQP5a3pSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="271726446"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa001.fm.intel.com with ESMTP; 15 Jun 2026 21:52:42 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 5/8] perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()
Date: Tue, 16 Jun 2026 12:46:51 +0800
Message-Id: <20260616044654.3468742-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
References: <20260616044654.3468742-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intel_pmu_init_hybrid() function allocates memory for the
x86_pmu.hybrid_pmu[] array. If this allocation fails under memory
pressure, hybrid PMU initialization will fail.

Currently, the caller does not check the return value of
intel_pmu_init_hybrid(). This can lead to a null-pointer dereference or
invalid memory access when attempting to use the uninitialized array,
potentially triggering a system panic.

Fix this by validating the return value of intel_pmu_init_hybrid().
Additionally, reset x86_pmu.num_hybrid_pmus to 0 on failure, and defer
intel_pmu_arch_lbr_init() until after hybrid PMU initialization
succeeds. This reordering avoids the need to explicitly destroy the
kmem cache if the memory allocation fails.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 44 ++++++++++++++++++++++++------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index db52e7e53a6c..edf6f8732234 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7678,8 +7678,10 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 	x86_pmu.num_hybrid_pmus = hweight_long(pmus_mask);
 	x86_pmu.hybrid_pmu = kzalloc_objs(struct x86_hybrid_pmu,
 					  x86_pmu.num_hybrid_pmus);
-	if (!x86_pmu.hybrid_pmu)
+	if (!x86_pmu.hybrid_pmu) {
+		x86_pmu.num_hybrid_pmus = 0;
 		return -ENOMEM;
+	}
 
 	static_branch_enable(&perf_is_hybrid);
 	x86_pmu.filter = intel_pmu_filter;
@@ -7862,14 +7864,14 @@ __init int intel_pmu_init(void)
 	struct attribute **td_attr    = &empty_attrs;
 	struct attribute **mem_attr   = &empty_attrs;
 	struct attribute **tsx_attr   = &empty_attrs;
+	struct x86_hybrid_pmu *pmu;
+	unsigned int fixed_mask;
 	union cpuid10_edx edx;
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
-	unsigned int fixed_mask;
+	int version, i, ret;
 	bool pmem = false;
-	int version, i;
 	char *name;
-	struct x86_hybrid_pmu *pmu;
 
 	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -7939,9 +7941,6 @@ __init int intel_pmu_init(void)
 		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
 	}
 
-	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
-		intel_pmu_arch_lbr_init();
-
 	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
@@ -8539,7 +8538,9 @@ __init int intel_pmu_init(void)
 		 *
 		 * Initialize the common PerfMon capabilities here.
 		 */
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
@@ -8597,7 +8598,9 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
 	case INTEL_ARROWLAKE_U:
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8628,7 +8631,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8643,7 +8648,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Arrowlake Hybrid events, ");
 		name = "arrowlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8660,7 +8667,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8685,7 +8694,9 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_ARROWLAKE_H:
-		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = arl_h_latency_data;
 		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
@@ -8720,7 +8731,9 @@ __init int intel_pmu_init(void)
 	case INTEL_NOVALAKE_L:
 		pr_cont("Novalake Hybrid events, ");
 		name = "novalake_hybrid";
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret)
+			return ret;
 
 		x86_pmu.pebs_latency_data = nvl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8827,6 +8840,9 @@ __init int intel_pmu_init(void)
 		pr_cont("AnyThread deprecated, ");
 	}
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	intel_pmu_check_event_constraints_all(NULL);
 
 	/*
-- 
2.34.1

