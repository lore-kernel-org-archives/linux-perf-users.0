Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E464291160;
	Tue, 15 Apr 2025 08:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705463; cv=none; b=cXTRY5Y56YoJObXZqYRYk46ej2dLXEe39aNPm8eAXpc0AKIvrbW5dUGl5D8jzCVBCiqTaCJN5K6GadI2qi4tYEj9B3OhkdQaFFGpwpSrIbM5tkNYhRVrxMDpgvpEFxMmGOJ1qAPk+bHy0wYj1JbuNJ4B39Cqk1AMi5PmChIExos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705463; c=relaxed/simple;
	bh=w3cvApiihyqxnckGt3CNiYtqSyQdTpFdKg4IdjtAT9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VPZ63a2jbFl3umAh+o00wLxF79h9vP9xHq0Inwebrj1782WWtwWaiz4SEk7cv4Bucu7c+P+zrulXnHTIrytXiKzw4fGWQBBYPtVnO/lSGxH6+8szLUKUAXWSyqU8OEw5O4Vo0eRhbjHZieTGvjzvffGS2J1qwlH/I9fnUIU0Kuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VZYKJgYG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VZYKJgYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705462; x=1776241462;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w3cvApiihyqxnckGt3CNiYtqSyQdTpFdKg4IdjtAT9M=;
  b=VZYKJgYGFA+FjrRxTYc8b2b1I8hZ+2iJX0KTk7LhrgyC3j9vb1bcyiIE
   CchJVHrhE7gh5/Rbwum61gErvRHSf1/WbnMglMenAr8QBmeyW69aNdNhv
   XglGyZnyZ1yJu2u2M/o7KxGNnoQRGFnbqA0VRbdAfD0Osbf8ursCFx5iP
   PCctW2pr/kBaAKZ3dLbGf4sTo97uakgT64WMnWKnaf3bhlYZBf/4EAYqa
   Zx834uCUif228PvgpH/iYl2WmYfHQlNcsXb49jj5wPQINPeo0n0mSlAMU
   aoHWiKUZzqS3Uw+CBaE+IxpEKRzW6Q1H1cYYA0NfNoj4G4J6zSd82f1Cs
   w==;
X-CSE-ConnectionGUID: 5EjfvxOGRgOk8R35e0pq4g==
X-CSE-MsgGUID: jknZ1fT+QMC049brVc+/lQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115861"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115861"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:20 -0700
X-CSE-ConnectionGUID: bs1KenWVSpi88Cwd2Nznig==
X-CSE-MsgGUID: /LpM3HTZQPGsAEiAbxgBmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055459"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:16 -0700
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
Subject: [Patch v3 03/22] perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
Date: Tue, 15 Apr 2025 11:44:09 +0000
Message-Id: <20250415114428.341182-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index adc0187a81a0..c7937b872348 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5271,7 +5271,7 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int cntr, fixed_cntr, ecx, edx;
 	union cpuid35_eax eax;
@@ -5280,30 +5280,30 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
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
 
 	if (eax.split.acr_subleaf) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
 			    &cntr, &fixed_cntr, &ecx, &edx);
 		/* The mask of the counters which can be reloaded */
-		pmu->acr_cntr_mask64 = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
 
 		/* The mask of the counters which can cause a reload of reloadable counters */
-		pmu->acr_cause_mask64 = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
 }
 
@@ -5390,7 +5390,7 @@ static bool init_hybrid_pmu(int cpu)
 		goto end;
 
 	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(pmu);
+		update_pmu_cap(&pmu->pmu);
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
@@ -6899,6 +6899,7 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(x86_pmu.cntr_mask64);
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
+	x86_pmu.config_mask		= X86_RAW_EVENT_MASK;
 
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
@@ -7715,6 +7716,18 @@ __init int intel_pmu_init(void)
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

