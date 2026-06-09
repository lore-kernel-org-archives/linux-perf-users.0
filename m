Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E73363C77;
	Tue,  9 Jun 2026 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780981686; cv=none; b=CZBMRIkn2Oqq8OjRIYbXs9/XKL847CJtBt0wVIdmwwHgplMB+92TU2vsr7UKUNyFYCTZL7PHiz4E33oTQVuGAz5RbwlyNEtoUjLXnE/BXkonOYvZ0jSNiRRNdBcAMpGPzyMvCaiNDCMWjHmK29PmES07m51PPMzZaoykwQEJcYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780981686; c=relaxed/simple;
	bh=4sIYgzJW4BcyHYrhWFHyGjGQl7u6u+lPP5rsi98/OEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FYDPOZgBLik2/rJK1TjdUPV5GISgiS9bXE6PID1yuuOkxD2J8jhhW11rAn6/tyrLDOALu/kfXt/ZEiyQ/3wyG7sdcZNGLlAl8ERnyaiqzsop4PQxjYadTWfGCghhf8+YkBNXzmMVelmlZMSMX7utgdeFFLYuuQRfWyIwqN3VDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A4i+FzXl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A4i+FzXl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780981686; x=1812517686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4sIYgzJW4BcyHYrhWFHyGjGQl7u6u+lPP5rsi98/OEg=;
  b=A4i+FzXl50nreWSpJ6dhq7ggOVhfp9HXnju7yo8mGClCU/Rm1a9M3jB+
   EXDS2GHPuAyYqPA1s5ax42wQWo5BbO9/ZM7gqXdGith5/WM8TQ8DKzN83
   8Oez7pBCPVThcY+fklxYuXZCHWz+j51LuWDvXArggpridom/f59NhDXd3
   JKAUM1kOfkmN4WUpgGLNn0pWyl63uXrjteV8f+QcOElyAhdPtb8gtL6T/
   zAtUhKztDZgRRoD6mVKKGil9wzsUUE5HxAn+rdW3Qz2glzSJdGeWNi3hL
   l9JE73eC+a0bomw62Q+GeLbO+xKoiLmh0CZHEkBNOR7W8yqI9K1gq0mR0
   w==;
X-CSE-ConnectionGUID: WSlkhJesSNySfqVKqgVitw==
X-CSE-MsgGUID: kqwmnjQ9R5WOjE931ER/tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="81586184"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="81586184"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 22:08:05 -0700
X-CSE-ConnectionGUID: 2Gh0npIpS2iRW3XYC+yRzA==
X-CSE-MsgGUID: j6ZynCVoQpqNFd5NvRIfmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="283838923"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa001.jf.intel.com with ESMTP; 08 Jun 2026 22:08:02 -0700
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
Subject: [Patch v2 6/9] perf/x86/intel: Validate return value of intel_pmu_init_hybrid()
Date: Tue,  9 Jun 2026 13:02:19 +0800
Message-Id: <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The memory allocation for the x86_pmu.hybrid_pmu[] array in
intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
If this occurs, the initialization of the x86 hybrid PMU would fail.

Currently, the code does not check the return value of the
intel_pmu_init_hybrid() function, which could lead to attempts to access
the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
system panic.

So, add a check for the return value of intel_pmu_init_hybrid() to
prevent invalid memory access in such scenarios. Besides, free the
created kmem cache when error occurs.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index ea3ab3050a3b..efd9caa3502c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
 	int version, i;
 	char *name;
 	struct x86_hybrid_pmu *pmu;
+	int ret;
 
 	/* Architectural Perfmon was introduced starting with Core "Yonah" */
 	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
@@ -8539,7 +8540,9 @@ __init int intel_pmu_init(void)
 		 *
 		 * Initialize the common PerfMon capabilities here.
 		 */
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		x86_pmu.pebs_latency_data = grt_latency_data;
 		x86_pmu.get_event_constraints = adl_get_event_constraints;
@@ -8597,7 +8600,9 @@ __init int intel_pmu_init(void)
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
 	case INTEL_ARROWLAKE_U:
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8628,7 +8633,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8643,7 +8650,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Arrowlake Hybrid events, ");
 		name = "arrowlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8660,7 +8669,9 @@ __init int intel_pmu_init(void)
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
@@ -8685,7 +8696,9 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_ARROWLAKE_H:
-		intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
+		if (ret < 0)
+			goto err;
 
 		x86_pmu.pebs_latency_data = arl_h_latency_data;
 		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
@@ -8720,7 +8733,9 @@ __init int intel_pmu_init(void)
 	case INTEL_NOVALAKE_L:
 		pr_cont("Novalake Hybrid events, ");
 		name = "novalake_hybrid";
-		intel_pmu_init_hybrid(hybrid_big_small);
+		ret = intel_pmu_init_hybrid(hybrid_big_small);
+		if (ret < 0)
+			goto err;
 
 		x86_pmu.pebs_latency_data = nvl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
@@ -8885,6 +8900,10 @@ __init int intel_pmu_init(void)
 	intel_aux_output_init();
 
 	return 0;
+
+err:
+	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
+	return ret;
 }
 
 /*
-- 
2.34.1

