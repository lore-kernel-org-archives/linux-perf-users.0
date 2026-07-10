Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4F3B27CD;
	Fri, 10 Jul 2026 06:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783666687; cv=none; b=RDjo0UPpu4kIw8kKWIm3Nowqo5yfKTf9VbUTc+0uKfLPRfWIVXZm0siHa9zSMVJ5g1hnkvmE2k9uiIENU00PBOHRqHQkcyxAsLZ6XboCK7lag2HM8KqsiLHY2gFWoVzBMZNZmaey7VLAfTBwFaut6zaRqoJ8AWHDf9eOg3lxbMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783666687; c=relaxed/simple;
	bh=n0Fae5Rj+3md9tmmvWVa18spRFGOar03Ygxdg0l4BRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GQR72YuwX2li3Wwo/uVacGkmG2loZ1K2jxLCU1q6K/myuBb8AkUqbcqOZdqWCB4zIer61sbU9F4Uno+EpUgmxY6O5UUosybgYZr/M9l7e9xlbkR7eneY/Q1TV8Pg1AehK4en94J0DUGm6PMVyjHx5AjF5PT6hPs/e0LCBE02vM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHAOrzzG; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHAOrzzG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783666683; x=1815202683;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=n0Fae5Rj+3md9tmmvWVa18spRFGOar03Ygxdg0l4BRY=;
  b=EHAOrzzG/bHWfqnxZ42SYxDYF7RYSwYNOm7KF9dxKAZdv+Cxsrb8Zm/x
   7KU7V+xWm56UO238DccVxVIMgzmRiPgCTnin18VPGbmZVtISz/k/iDKej
   aqPcvmZQTBmIKaDHnplbwY7YGYqz8dKMirXPiPwkkVwy6dsJS0dkeNeeY
   diVGjEYatrt+vEr3GsBHa5WoenR71OMqsthSsp92kPH0rbD5gjSAokbCu
   49FS99b8E1kmoX1NHx91WAwpbU89t5uIcfmTRzpzGe2Ah43xj0Mjkraiq
   ZtXFgCFaR/ojC0rz8967pSAtsdHRXlJeRNKpJFOmxE5DBk9/DlQG6UB9F
   g==;
X-CSE-ConnectionGUID: LF3tQTnfQEm4TgAWOtOV7Q==
X-CSE-MsgGUID: VjtVGGK6S9KEMxUv7K9bPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84554233"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84554233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2026 23:58:00 -0700
X-CSE-ConnectionGUID: M75OH8A+RT6KElYFuxDrbQ==
X-CSE-MsgGUID: 2L9b/ZPMQjmRw/a8j85wiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="252159252"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 09 Jul 2026 23:57:55 -0700
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
Subject: [PATCH 6/7] perf/x86/intel: Fix intel_cap handling on hybrid PMUs
Date: Fri, 10 Jul 2026 14:51:27 +0800
Message-Id: <20260710065128.1799838-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
References: <20260710065128.1799838-1-dapeng1.mi@linux.intel.com>
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
---
 arch/x86/events/intel/core.c | 41 ++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 83c60ad00085..36de21484ada 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6147,8 +6147,15 @@ static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs);
 
 static inline bool intel_pmu_broken_perf_cap(void)
 {
-	/* The Perf Metric (Bit 15) is always cleared */
-	if (boot_cpu_data.x86_vfm == INTEL_METEORLAKE ||
+	/*
+	 * The Perf Metric (Bit 15) is always cleared on P-core of
+	 * PRL and MTL. Details can be found in RPL018 Errata Details.
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
@@ -8827,8 +8846,8 @@ __init int intel_pmu_init(void)
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

