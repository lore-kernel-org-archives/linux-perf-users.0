Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3AD468C04;
	Mon, 28 Sep 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581849; cv=none; b=WyfzT70brdTTd3FD6QVcQuYbEnMu7I50cD5mKvTgRiKLNyb9qeH4QG8vT/6zyiae/pSKjZnzkyKDrAD9TOxLcJNA7+YgRr6wBlvM/8pt3lkOOJMnZXEvhp/xX7dYRTgM3+j1C9OMJRFIQkXYsSdZy2ZjGeCxgWuWTMT/JdSIwP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581849; c=relaxed/simple;
	bh=yaoPQDAnpHbN7S1Z5ijKn3DEO4Igp1pWGk2SV0o5HWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzofIVkFaQLVTjonIveD6LCvHHyDn2E0pH/nB9Xn7vSWjpbuSHSXTNs7vppS2Ve/CLqI1KbAHVVQ1BQHZCCf/zZsjwNSCp2gHjhpBj5PDQ2lmbtftS6Z7qRVe0gDjc1xl8xvQkNISWMcoKww2iRwutJkIO7EQwjur5C1lHryjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V5ilkSae; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V5ilkSae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581848; x=1822117848;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yaoPQDAnpHbN7S1Z5ijKn3DEO4Igp1pWGk2SV0o5HWg=;
  b=V5ilkSaez377WzZ/YNVd1viMrrOZmgON3E2Rz5Pi8ANls3vSu5Wg6oCh
   VtEqhatD5WN/COqhjX3x1gGYmCBojV3CsPM2yzYSviVGM5LWLchJMn8P6
   QBXwG/TA2tyUXqxGM+JPO0tgO0o27SLPMwRQQ+fTvaJdeWmaDagyPe6aL
   juWeRCS0YfuQSKYIkiKuX4VhtED2hsS/1q6b+k9TEqL1RJ1BvgvpkNIFG
   amLcClosyNdHsUINubyjtIPUfdxHW4H2P2CeRRuHtmlVBZ91croftqwaQ
   msCa3+Q9sySX5hhYY4W6HebPJYAN36aygYJK+7iWARCxYDKbSmEluC6TQ
   Q==;
X-CSE-ConnectionGUID: gdTuZ7bnSySBfadkrv5JnQ==
X-CSE-MsgGUID: 9Pryr4upQVuvsksaG2zC5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141404"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141404"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:50:48 -0700
X-CSE-ConnectionGUID: wVT7X3OwRO6+nNCPgoo+wQ==
X-CSE-MsgGUID: TyTXyobuSXGgmhp+bXo8/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024905"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:50:44 -0700
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
Subject: [PATCH 04/15] perf/x86/intel: Reset cached acr_cfg_b[] and cfg_c_val[] on CPU teardown
Date: Mon, 28 Sep 2026 15:42:58 +0800
Message-Id: <20260928074309.898043-5-dapeng1.mi@linux.intel.com>
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

Reset cpuc->acr_cfg_b[] and cpuc->cfg_c_val[] and corresponding MSRs in
the CPU offline path.

These arrays cache the last programmed values for the *_CFG_B and
*_CFG_C MSRs, and matching values can cause reprogramming to be skipped.
After CPU hotplug, those MSRs may return to reset defaults, but the cached
values may still reflect the pre-offline state. This can incorrectly
skip MSR writes when events are enabled again, leaving the hardware with
reset MSR contents.

Clear both caches and corresponding *_CFG_B/*_CFG_C MSRs on CPU teardown,
so *_CFG_B and *_CFG_C are always reprogrammed after CPU online.

Fixes: 52448a0a7390 ("perf/x86/intel: Setup PEBS data configuration and enable legacy groups")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 38 ++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2f3eaf96daf5..377ff3912420 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6623,9 +6623,47 @@ static void fini_adaptive_pebs_on_cpu(int cpu)
 	wrmsrq_on_cpu(cpu, MSR_PEBS_DATA_CFG, 0);
 }
 
+#define clear_pmu_ext_msrs_on_cpu(cpu, mask, gp_base, fixed_base)		\
+do {										\
+	int idx, msr;								\
+										\
+	for_each_set_bit(idx, (unsigned long *)&(mask), X86_PMC_IDX_MAX) {	\
+		if (idx < INTEL_PMC_IDX_FIXED) {				\
+			msr = (gp_base) + x86_pmu.addr_offset(idx, false);	\
+		} else {							\
+			msr = (fixed_base) +					\
+			       x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false); \
+		}								\
+		wrmsrq_on_cpu((cpu), msr, 0);					\
+	}									\
+} while (0)
+
+static void fini_pmu_ext_msrs_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
+	u64 cfg_b_mask = hybrid(cpuc->pmu, acr_cntr_mask64);
+	u64 cfg_c_mask = cfg_b_mask |
+			 hybrid(cpuc->pmu, arch_pebs_cap).counters;
+
+	if (x86_pmu.version < 6)
+		return;
+
+	/*
+	 * Clear cached acr_cfg_b[] and cfg_c_val[] so *_CFG_B and
+	 *_CFG_C MSRs can always be reprogrammed after CPU online.
+	 */
+	memset(cpuc->acr_cfg_b, 0, sizeof(cpuc->acr_cfg_b));
+	memset(cpuc->cfg_c_val, 0, sizeof(cpuc->cfg_c_val));
+	clear_pmu_ext_msrs_on_cpu(cpu, cfg_b_mask, MSR_IA32_PMC_V6_GP0_CFG_B,
+				  MSR_IA32_PMC_V6_FX0_CFG_B);
+	clear_pmu_ext_msrs_on_cpu(cpu, cfg_c_mask, MSR_IA32_PMC_V6_GP0_CFG_C,
+				  MSR_IA32_PMC_V6_FX0_CFG_C);
+}
+
 static void intel_pmu_cpu_dying(int cpu)
 {
 	fini_fixed_cntrs_on_cpu(cpu);
+	fini_pmu_ext_msrs_on_cpu(cpu);
 	fini_adaptive_pebs_on_cpu(cpu);
 	fini_debug_store_on_cpu(cpu);
 	fini_arch_pebs_on_cpu(cpu);
-- 
2.34.1

