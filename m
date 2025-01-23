Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620A01C9B7A;
	Thu, 23 Jan 2025 06:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613220; cv=none; b=tD9VpYhBYdKO5dQLl2B+EuzpvRNKSRaEkgfpHgx846NR1CiZPyopfOonW/C7mU/tzj9gjQoL6/VZCnRkbDFepPYW9pEF2J8PZ4nE5/Ft8lFBjSqei0kHlEYQllhb/y4lG45yCYyak3AK/EUt/AqnCk+B7l8G4aIGYWLAn4MwSb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613220; c=relaxed/simple;
	bh=EEZpU4/D2b6pihCbiAMkHaPnvVQe+3/e33M0t/sr3v0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JQZxMI66EArT4cslHf7Hxk8g/RE8RZpNWfa9/VZJ9Fs5ubqrgOPwX4XUo7C0dME9zSdkD6Azyvfq8YDWw75SfNdXIJ8pmjVY1uZGMw4WlsrvqMl2LWZX5gmwkI00Xl/wT/sPdEvCvqIARd7nckjR5bZ12XjkjN4r/0fXaq0ZEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/lXsbHr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/lXsbHr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613220; x=1769149220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EEZpU4/D2b6pihCbiAMkHaPnvVQe+3/e33M0t/sr3v0=;
  b=D/lXsbHr9rr2CfKaoaeC4hfcy/TpQmvmdQ4Dh1+BiTi0Ecxrla01sQaO
   T059NwAh6ekO95z8R+naEpEDaRpay2E1W6m1mVL/PHKI/tf+hoyn7W0GG
   K7H3kElgru7PqnGZE9JDJ5PTL2WXCOJYif2s/VL/Ja5opO8BvKmdcij1n
   9fmUKMU852IEnv85keaNMk//tXLh40DfwrZtJXEpoibaDv+o8I4/PEIzu
   ZXhjCaXlAjFzXm0a74ka8excgbRAyJoGJWZpAghqwDYpx76DbhDDD0y1e
   cd+79FNJ8JbUQc/Cd2jMVJHHSc15IdPhB5smIFMtdeT49S2G4zkNJbChn
   w==;
X-CSE-ConnectionGUID: w+agh3vzTBaevURG7ab4Ew==
X-CSE-MsgGUID: QhJouVw4Tua2Zlt/w6eb4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513045"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513045"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:20 -0800
X-CSE-ConnectionGUID: WU26d5LhQ1mrJGrJnEguJg==
X-CSE-MsgGUID: ws4VBgnDSquZ8HA1Mkg2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334452"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:15 -0800
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
Subject: [PATCH 03/20] perf/x86/intel: Parse CPUID archPerfmonExt leaves for non-hybrid CPUs
Date: Thu, 23 Jan 2025 14:07:04 +0000
Message-Id: <20250123140721.2496639-4-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
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
index 12eb96219740..d29e7ada96aa 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4955,27 +4955,27 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
-static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
+static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
 
 	cpuid(ARCH_PERFMON_EXT_LEAF, &sub_bitmaps, &ebx, &ecx, &edx);
 
 	if (ebx & ARCH_PERFMON_EXT_UMASK2)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_UMASK2;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
 	if (ebx & ARCH_PERFMON_EXT_EQ)
-		pmu->config_mask |= ARCH_PERFMON_EVENTSEL_EQ;
+		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
 
 	if (sub_bitmaps & ARCH_PERFMON_NUM_COUNTER_LEAF) {
 		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF_BIT,
 			    &eax, &ebx, &ecx, &edx);
-		pmu->cntr_mask64 = eax;
-		pmu->fixed_cntr_mask64 = ebx;
+		hybrid(pmu, cntr_mask64) = eax;
+		hybrid(pmu, fixed_cntr_mask64) = ebx;
 	}
 
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
 }
 
@@ -5066,7 +5066,7 @@ static bool init_hybrid_pmu(int cpu)
 		goto end;
 
 	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(pmu);
+		update_pmu_cap(&pmu->pmu);
 
 	intel_pmu_check_hybrid_pmus(pmu);
 
@@ -6564,6 +6564,7 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.pebs_events_mask	= intel_pmu_pebs_mask(x86_pmu.cntr_mask64);
 	x86_pmu.pebs_capable		= PEBS_COUNTER_MASK;
+	x86_pmu.config_mask		= X86_RAW_EVENT_MASK;
 
 	/*
 	 * Quirk: v2 perfmon does not report fixed-purpose events, so
@@ -7374,6 +7375,18 @@ __init int intel_pmu_init(void)
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

