Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB5B39DBD0;
	Fri, 12 Jun 2026 09:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781255220; cv=none; b=AkH36MZghoy1sVlQACp+X3fCsbIXs6u2iLc4xRsHlQ1MtWKZ6JqOT651up32RoAIlg1hFwbHDiGFG0V/B9WmNOzeWjx0pPw50CVZkrRjqmuy67QIHhrXtXccb3jAO47+sCjAAfGyS2eRD8r3/gs0ik1Z4A+1JdWpcp656th3pos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781255220; c=relaxed/simple;
	bh=munxebFNtFDwdpJpoPU2r1zi10sjBPxG+uHD7QU8TWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kFNlLT70FFHIUdoh8plJ/QEyhrHUmFKkscfoQbvhF2XbxpNLk0OeTbHPw4Y79gmuvRoQIEFhjE0TMuZbjQTty9ZNDyX3OxvNdo+xu0YrFUfpRXZ7fXO24ZJRzmlpcNPLFoy7Im7sOWszPfuPmknu9i7OzDEYWGS9a+hwpwtVyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pnh0ifv1; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pnh0ifv1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781255211; x=1812791211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=munxebFNtFDwdpJpoPU2r1zi10sjBPxG+uHD7QU8TWM=;
  b=Pnh0ifv1vWf9KbIZG3MQrD9xjaj/U6tsqiuYnovG7sGOEgZfqh09Wj23
   p5bA5SRfVqjhHv8np/S3UytDrY7PdU/RQZMtP0IDjdsQFiWJoPA9DGF0C
   dqmOrlEYecKxAvjCCmOusQwuzt8a2AD0UenF1QVoxyBbCtpRyCb+XWt+I
   niW9CIkfYTDLdXcr+OI4tRPGuC6mkTPp/nu0KzEO6h1uD13iRdkz54jai
   nfVg5KmcWsZZgcEY/95l4Fjt5HCuwy+ODMr5RVbbV0A2GLyawkuyQTRmb
   W/ia4NpGOsuXMa2gfQ7qEBaMTE8tYzm/Jq+K8gynzom9TOXXo6tX/k+Ju
   A==;
X-CSE-ConnectionGUID: 0HwJ+IiOTny//AN1jR/Fhw==
X-CSE-MsgGUID: iEy2+bcrTN28D3oA2+B65Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85714461"
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="85714461"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2026 02:06:50 -0700
X-CSE-ConnectionGUID: lKF3qXyaSvWqBpocDw57ZQ==
X-CSE-MsgGUID: OZPBP2hhRT2/uBEo8Hd9gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,200,1774335600"; 
   d="scan'208";a="246838748"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa007.jf.intel.com with ESMTP; 12 Jun 2026 02:06:46 -0700
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
Subject: [Patch v3 5/8] perf/x86/intel: Validate the return value of intel_pmu_init_hybrid()
Date: Fri, 12 Jun 2026 17:01:11 +0800
Message-Id: <20260612090114.3188886-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
References: <20260612090114.3188886-1-dapeng1.mi@linux.intel.com>
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
index db52e7e53a6c..74dbf24b0ab6 100644
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
@@ -8829,6 +8842,9 @@ __init int intel_pmu_init(void)
 
 	intel_pmu_check_event_constraints_all(NULL);
 
+	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
+		intel_pmu_arch_lbr_init();
+
 	/*
 	 * Access LBR MSR may cause #GP under certain circumstances.
 	 * Check all LBR MSR here.
-- 
2.34.1

