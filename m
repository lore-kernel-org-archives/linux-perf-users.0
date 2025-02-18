Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8013D22F152;
	Tue, 18 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866438; cv=none; b=deWnkVFDUX0VPCGqlKol5VAifZJ6fPlTnq/eJH5/YjwJlAKE6AIqQg1t9sCg3AdMcuSDiGCbzFsPy/CQx9G1ZfSPzX8rG8PWl5180V/VUPWPxE27ot9sAedMEKW90LoIE77Wt40xwJww4dG/3Z8uCspXhX5Kgu+rg49knxuldxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866438; c=relaxed/simple;
	bh=Oljdb8yBE9U9IIdw7gWzTTVYt1jfySXv1NEKxX/rN08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W47ASP+6HVjdjduKlQqVOGwduT6SMEX3KYk3F5V0yZb8XUfPlFAs2lTMYKenbn7nAg7tOI/Eu4M8BOpvWvwfEc3bZwrj1fIWI+gCarj0ECGWZ8f/LaiH7Q7UY+/dc6hy3G9Rq07x2HzOCXS54gdkIV1gEoDIN9EBmxUxZ/uDwv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DrYJaDsQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DrYJaDsQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866437; x=1771402437;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Oljdb8yBE9U9IIdw7gWzTTVYt1jfySXv1NEKxX/rN08=;
  b=DrYJaDsQUECZOZ5h9wi7YghMTdZyfohWpYZdxLoIVgooAD2rTUD4Miom
   5pOtts5MO65Ei4ECprom+76t2kq10kau5WqtgLzbM7BYpSvhEPT8j29wP
   NuU3Nb+LeMDel39f4xCA8sE15yYZGWQSF1Hd6o+QtO5PXGrMcfHxMvI44
   FzddULSxpr7+hiayph5WqXA6MasX+30fLTSzDGNm8T0xg7DostGu3Zlnp
   0xMvslc/H3SGbxoCdtpiIXIc421sDLOORsFzX6DuU6eewEhSq7/QIY4Vn
   sixeKPyl+BvmGt7QROjyuyaopXyUJGOc+9LTTN5213RTXvaYazHW7JRmi
   g==;
X-CSE-ConnectionGUID: 4OkY/StwSgqdng12Xzz/uw==
X-CSE-MsgGUID: oc8I87dxQ/+Y4UQvLG8XmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200738"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200738"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:13:57 -0800
X-CSE-ConnectionGUID: 1Hk8XW8EREKdlJOz8EpFPQ==
X-CSE-MsgGUID: 8QKleuf1R4qNltIYcUoE+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166121"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:13:54 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 04/24] perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
Date: Tue, 18 Feb 2025 15:27:58 +0000
Message-Id: <20250218152818.158614-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPUID archPerfmonExt (0x23) leaves are supported to enumerate CPU
level's PMU capabilities on non-hybrid processors as well.

This patch supports to parse archPerfmonExt leaves on non-hybrid
processors. Architectural PEBS leverages archPerfmonExt sub-leaves 0x4
and 0x5 to enumerate the PEBS capabilities as well. This patch is a
precursor of the subsequent arch-PEBS enabling patches.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7521e1e55c0e..e1383a905cdc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4968,7 +4968,7 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int cntr, fixed_cntr, ecx, edx;
 	union cpuid35_eax eax;
@@ -4977,20 +4977,20 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
 
 	if (ebx.split.umask2)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
 	if (ebx.split.eq)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (eax.split.cntr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
 			    &cntr, &fixed_cntr, &ecx, &edx);
-		pmu->cntr_mask64 = cntr;
-		pmu->fixed_cntr_mask64 = fixed_cntr;
+		hybrid(pmu, cntr_mask64) = cntr;
+		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
 }
 
@@ -5076,7 +5076,7 @@ static bool init_hybrid_pmu(int cpu)
 		goto end;
 
 	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(pmu);
+		update_pmu_cap(&pmu->pmu);
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
@@ -6559,6 +6559,7 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(x86_pmu.cntr_mask64);
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
+	x86_pmu.config_mask		= X86_RAW_EVENT_MASK;
 
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
@@ -7375,6 +7376,18 @@ __init int intel_pmu_init(void)
 		x86_pmu.attr_update = hybrid_attr_update;
 	}
 
+	/*
+	 * The archPerfmonExt (0x23) includes an enhanced enumeration of
+	 * PMU architectural features with a per-core view. For non-hybrid,
+	 * each core has the same PMU capabilities. It's good enough to
+	 * update the x86_pmu from the booting CPU. For hybrid, the x86_pmu
+	 * is used to keep the common capabilities. Still keep the values
+	 * from the leaf 0xa. The core specific update will be done later
+	 * when a new type is online.
+	 */
+	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap(NULL);
+
 	intel_pmu_check_counters_mask(&x86_pmu.cntr_mask64,
 				      &x86_pmu.fixed_cntr_mask64,
 				      &x86_pmu.intel_ctrl);
-- 
2.40.1

