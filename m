Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5754B46AA85;
	Mon, 28 Sep 2026 07:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581878; cv=none; b=nkhWovn5lxrsPVf8R2UaZyRxIBpntAFjirdGBcatI7DO8/9piUCbo1HMCa7Q7K9WALHoh+Qq7JFpkDmCYHVYfb1oC1poScAX0bpMltjsaWTHz+OSrK4drOl+bL5k0lYm5RULajZk4m6eh8WLkuvs7W4RpSqi6N7MXJGfnpe9bxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581878; c=relaxed/simple;
	bh=IXW0DEVPzXu922Ez4zq3r/dDJAJrBf/1rFZkmYRaQgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=svk/xaThzQuj5qBfB4J00/19ny+lT62P38QSbDDIdHynUR2kpxniiAlWtCbw8GXa7L9LoxeH9IJDkgZtHHidZtfpUPYP16R606xVac+9kzYhR2Wl7jhzz2NbAK45DS5IGHSUw4s7agYAR8jATc5L0VPL3apT/bwkMccjYz8kX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzagDJX9; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzagDJX9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581877; x=1822117877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IXW0DEVPzXu922Ez4zq3r/dDJAJrBf/1rFZkmYRaQgc=;
  b=lzagDJX9h8lI2ToirKkm3970SQ2rlZjb3Hekigel/oK4OJ1NGnbKlN5/
   wzwOPVxcee/5B5EKx6wPl0DmIMMX1SWMU2sBX+OlYtEgtrbecgvm1gEHK
   O+yMGwki7FofB3h3/ZIwXgq7hzeFApEuLmmeH50CsCN5hrv657Tn709I6
   eHMSBSimdgyvvmiVylGtcr1utMUS50/FZY42HBJ0sPsCmrdSlNmDG71l7
   d3HxX8p5+oksjPTbzpA/FRw4hsKh0KSYOtJnDXgUF2JwhuzAcRuaYCu8a
   eB/HOWwKlEJq18+EECJegu2TYSoJcDBOB7R2p1gmKUP3JmNM/na7Dc+oB
   g==;
X-CSE-ConnectionGUID: pvldd4EKTge6LDBBvGkkZQ==
X-CSE-MsgGUID: srmw6ShYQO2c5jzeEo9dCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141482"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141482"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:17 -0700
X-CSE-ConnectionGUID: EGM/3sD3SZWxfr4Ess/4Lw==
X-CSE-MsgGUID: HT1yI4GWTHGre0odGoZoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275025031"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:14 -0700
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
Subject: [PATCH 12/15] perf/x86/intel: Make ACR static_call update architectural
Date: Mon, 28 Sep 2026 15:43:06 +0800
Message-Id: <20260928074309.898043-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Auto counter reload (ACR) is an architectural feature, but the
intel_pmu_enable_acr_event() static_call update is currently done in a
model-specific way.

This is only necessary because older platforms such as PTL/WCL only
support ACR on E-core, which made the boot-time capability check on
P-core impossible in the generic init path. Later platforms such as
DMR/NVL support ACR on booting P-core and can detect it architecturally.

Make the intel_pmu_enable_acr_event() static_call update architectural
so ACR can be enabled correctly on supported CPUs without relying on
model-specific setup.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3fc3795534bf..0d360fba4b79 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6365,6 +6365,25 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 
 #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
 
+static bool intel_pmu_support_acr(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	union cpuid35_eax eax_0;
+	union cpuid35_ebx ebx_0;
+
+	if (!this_cpu_has(X86_FEATURE_ARCH_PERFMON_EXT))
+		return false;
+
+	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
+	if (eax_0.split.acr_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
+			    &eax, &ebx, &ecx, &edx);
+		return !!counter_mask(eax, ebx);
+	}
+
+	return false;
+}
+
 static void update_pmu_cap_from_perfmonext(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -8112,7 +8131,6 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
-	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 static __always_inline void intel_pmu_init_cyc(struct pmu *pmu)
@@ -8160,7 +8178,6 @@ static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_arw_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_dkt_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_arw_extra_regs;
-	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
 __init int intel_pmu_init(void)
@@ -9127,6 +9144,12 @@ __init int intel_pmu_init(void)
 	if (!is_hybrid())
 		intel_update_pmu_caps(NULL);
 
+	if (x86_pmu.acr_cntr_mask64 || intel_pmu_support_acr()) {
+		static_call_update(intel_pmu_enable_acr_event,
+				   intel_pmu_enable_acr);
+		pr_cont("Auto counter reload, ");
+	}
+
 	if (x86_pmu.arch_pebs) {
 		static_call_update(intel_pmu_disable_event_ext,
 				   intel_pmu_disable_event_ext);
-- 
2.34.1

