Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DB53E3C5A;
	Fri, 17 Jul 2026 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275817; cv=none; b=VzWQ3C745z+GfFkA+gOa3/ZGEsG/aSPe9lzweuLvW/RW/tIfLE1VplTiOS0Ux9P2UiJKNgfTXwR4gL7GBSEqLWgt1dhbL20EV8kvIhwJgjiSeO3N1p3IJxv+6nCtbTWR90hvFvnV7ZvG9cWIvf8yyUnTKM1BLKIXOvgAxrhUul8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275817; c=relaxed/simple;
	bh=x0SRUQAN5Hb36s0gbXv08/7UvwF8Otz4PJRFUl96dFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hhi1K0+TuapFvr4FCfvlbWsBLEi/3upWGB5nUzck6FjGWKgjxeawLGIpK1WMsUjLb6msKBmzb7Ahv9vjMotWH//gC5+bsG0CtoQcVlZmDEPfst1u5uvunb7u04BnQZa2m54/FZpOD7eD7I33iGjqIJ4inqKyp/J4witMUnR8C2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hX2kJr8J; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hX2kJr8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784275816; x=1815811816;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x0SRUQAN5Hb36s0gbXv08/7UvwF8Otz4PJRFUl96dFU=;
  b=hX2kJr8JXZYYCFPektk0iDSQSI6UKZA1nsS8rHg8cMKqMxYN2WBROz1u
   JSBcTzTNi2ce7LOurI+3KujMz83iOqqmPwr2mxC4mF911hl5IJXpgNRva
   9QIL3IwpQNJI4x/+elLOa+gY5YBBb+W2nTqWQDpnlUofjzdo+YsSXPIbb
   PeGzsKHwEVFoPqxrieQAtIdZ+IAULIIi/oFSPoYBJqtLwah6/H+RKtqFD
   N3ubFyDVRskGEwmmKX+plFlWX4HLr5goEXMexyP3kHXVmbACqrpkom3UB
   0006kXU2J9UZf63VsntFemwT7s2gcccUW2s0UvPBpgYQxv85fD/0TVQlN
   w==;
X-CSE-ConnectionGUID: vd6Ram+RR6O+dP4/AFevnw==
X-CSE-MsgGUID: Xc0kBWVkRzywv+/yo9PSKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="84065562"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="84065562"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 01:10:16 -0700
X-CSE-ConnectionGUID: Gpi0miEWQKizsQ6dL+b7lg==
X-CSE-MsgGUID: jhZDm7JIS3ql+UPE5m7Kxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="253315479"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 17 Jul 2026 01:10:12 -0700
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
Subject: [Patch v3 6/8] perf/x86/intel: Fix intel_cap handling on hybrid PMUs
Date: Fri, 17 Jul 2026 16:03:40 +0800
Message-Id: <20260717080342.1879573-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_cap (IA32_PERF_CAPABILITIES) updates are currently tied to
X86_FEATURE_ARCH_PERFMON_EXT, but these are independent feature paths.
As a result, hybrid PMU capability state can be updated under the wrong
condition.

Also, intel_pmu_broken_perf_cap() is too narrow. Per RPL018, the missing
PERF_METRICS_AVAILABLE bit affects both Raptor Lake and Meteor Lake
parts, not only the currently covered subset.

Move intel_cap updates out of the ARCH_PERFMON_EXT-gated path, extend
intel_pmu_broken_perf_cap() coverage to both RPL and MTL families, and
introduce intel_update_pmu_caps() to centralize PMU capability updates.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Thomas Falcon <thomas.falcon@intel.com>
---
 arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c418176065f6..361f8e0ab36c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6147,8 +6147,15 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
 
 static inline bool intel_pmu_broken_perf_cap(void)
 {
-	/* The Perf Metric (Bit 15) is always cleared */
-	if (boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
+	/*
+	 * The Perf Metric (Bit 15) is always cleared on P-core of
+	 * RPL and MTL. Details can be found in RPL018 erratum.
+	 * https://edc.intel.com/content/www/us/en/design/products/platforms/details/raptor-lake-s/13th-generation-core-processor-specification-update/errata-details/
+	 */
+	if (boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE ||
+	    boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE_P ||
+	    boot_cpu_data.x86_vfm == INTEL_RAPTORLAKE_S ||
+	    boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
 	    boot_cpu_data.x86_vfm == INTEL_METEORLAKE_L)
 		return true;
 
@@ -6183,7 +6190,7 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
 
-static void update_pmu_cap(struct pmu *pmu)
+static void update_pmu_cap_from_perfmonext(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
 	union cpuid35_eax eax_0;
@@ -6241,10 +6248,24 @@ static void update_pmu_cap(struct pmu *pmu)
 		WARN_ON(x86_pmu.arch_pebs == 1);
 		x86_pmu.arch_pebs = 0;
 	}
+}
+
+static void intel_update_pmu_caps(struct pmu *pmu)
+{
+	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		update_pmu_cap_from_perfmonext(pmu);
 
-	if (!intel_pmu_broken_perf_cap()) {
-		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
-		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
+	if (is_hybrid() && this_cpu_has(X86_FEATURE_PDCM)) {
+		rdmsrq(MSR_IA32_PERF_CAPABILITIES,
+		       hybrid(pmu, intel_cap).capabilities);
+
+		/*
+		 * Restore perf_metrics on platforms with broken
+		 * perf_capablities.
+		 */
+		if (intel_pmu_broken_perf_cap() &&
+		    hybrid_pmu(pmu)->pmu_type == hybrid_big)
+			hybrid(pmu, intel_cap).perf_metrics = 1;
 	}
 }
 
@@ -6329,9 +6350,7 @@ static bool init_hybrid_pmu(int cpu)
 	if (!cpumask_empty(&pmu->supported_cpus))
 		goto end;
 
-	if (this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(&pmu->pmu);
-
+	intel_update_pmu_caps(&pmu->pmu);
 	intel_pmu_check_hybrid_pmus(pmu);
 
 	if (!check_hw_exists(pmu->cntr_mask, pmu->fixed_cntr_mask)) {
@@ -8828,8 +8847,8 @@ __init int intel_pmu_init(void)
 	 * from the leaf 0xa. The core specific update will be done later
 	 * when a new type is online.
 	 */
-	if (!is_hybrid() && boot_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
-		update_pmu_cap(NULL);
+	if (!is_hybrid())
+		intel_update_pmu_caps(NULL);
 
 	if (x86_pmu.arch_pebs) {
 		static_call_update(intel_pmu_disable_event_ext,
-- 
2.34.1

