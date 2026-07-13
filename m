Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6543B2FE6;
	Mon, 13 Jul 2026 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931631; cv=none; b=seFbPUzZ+oJztn9zHZavOy5v4E5X48rH26LnyZiXD3xkmg7VD38A2pm6xair2RogQijGmPSD6EoyLvFzPh0/zsszwItkCpKij2YzuUMpl0ydY6hVDr1XiWPZl1XYvsmJ5OmCUYesz7q5eQjzuAfd09xIhY5UMvGvh3G3FYyAuvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931631; c=relaxed/simple;
	bh=FVSd+tb0+rC2LBuXM1YWEFpMUX0O9+RztOH4QA0tP+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0ms8lsi65PNmJB1yYrJQ0GshV7Ya15xdHp8VrUU8wr2UoBNasYfIbfVYJs3sJvHOabEU7Zo2CZIa5rpMpTWya7WB35OlIePtN9hcJkcR5I4KIq4yTS7056y6BoBh6UjOPVnQTCOGz6j4rdIBZDL9faDv4cJyYSw0d6EgkJqNJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nTHG6L4w; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nTHG6L4w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783931626; x=1815467626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FVSd+tb0+rC2LBuXM1YWEFpMUX0O9+RztOH4QA0tP+8=;
  b=nTHG6L4wprJtnK8ng0GCZ/U6GluWbuu54CQ8H/RVXgpSdzVgCOJLZqXn
   R+rqlsxK6+TCIg1Zb054vIw/VcpiY/ARLfqJWybHTkipAwPkAtqpFHrFE
   M8GPkOCGRGN3DhcmHyseQVNZxt/k/nbQKabNt+GMY0GLHHmdNVfQ3iGLd
   iJWo4Cb3+WWxSR9NV5rzNcWM5CCPDt3AEX+FluLf/cbvKY4nLACqEI7YL
   TucxDxiPDpIl96xGTu+2jhUUQIfn3n5A52Akd7BT/W3wKHwrIq52CKPi9
   +FaOn9Jx0HCrdhivCaSSdeaxW/VESRkJwqn4r5oy+1u3cwIR12ki8iCgV
   w==;
X-CSE-ConnectionGUID: s3ko5d4jRZ26xUKAGOzUEg==
X-CSE-MsgGUID: eC/oQs/lTwCsKZJbf+NIwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84390114"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84390114"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 01:33:44 -0700
X-CSE-ConnectionGUID: FxRI+ogHRWmVy4dOCv78kQ==
X-CSE-MsgGUID: iVftmzRjTUWMaAouJFKDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255560769"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 01:33:40 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v2 6/7] perf/x86/intel: Fix intel_cap handling on hybrid PMUs
Date: Mon, 13 Jul 2026 16:27:33 +0800
Message-Id: <20260713082734.3162099-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
References: <20260713082734.3162099-1-dapeng1.mi@linux.intel.com>
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
index c418176065f6..bec92163a09f 100644
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

