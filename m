Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8473803E3;
	Fri, 15 May 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825826; cv=none; b=dy024fauAgVsCEOR9LkCgEPTjRnbORe+dPwHglbfiWVCLZ7BqJCbiljVq9B6TD/w8U5ocXVyJhrBEbg3FlMCWpHZ9ruIMaD0o16rIuNhgx9RQfkxgiJZeQj90Vig/jOf9dlNQV5aBIXVdSKMjfzJdKfRECioMbpf39tAA0OWDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825826; c=relaxed/simple;
	bh=hHap+wM1eQRzzULDKb2nkg5lBd4s0v+6fxdjT5lPSW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EjMVcQSDSF0NbGfD9jnzqAb1bN/Dz7HgvSNHI44DqLAxjJpG+pyFn+qdI1EcqRTBkl9kDNQxvriUGscQC7Ir5dUqlDzQr0bWSS3gWGInY3clwcxrpZi27F/sqPpByBRiugcBdtZf+hJMAVrOYXAktgx+PHwdyp70sDdMx+j9KqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GoI/ekhL; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GoI/ekhL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825826; x=1810361826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hHap+wM1eQRzzULDKb2nkg5lBd4s0v+6fxdjT5lPSW8=;
  b=GoI/ekhLbhV+OpSO/BvhgK18I1NWdXzqC5tOfFb6ELfpGDaKW61BO4F2
   oERAc57I4IfN49nlIxqztQrV+aiyUVDhCW6QlDsolswIJCDBLhaZqwZde
   a0ht8+/ozx6EEHFO/r5CEbqXm17rnoxp2B8ZP1H4V8HtCREFQ1vTX+6qm
   aYxf/AUyHTVjyGQvOnimsnNkOj5YrYfvzETCQodYdmyklWRe2/JRUzQQH
   L9ZOA6b+dArulb1eMabbzB4TTttYy+XmUMQB6J7xHLDvFNC4tCynh8Tip
   //j/uLeqO7Cd7/TrSOBEZ6qX9uoSJUsaVaj4XMh7CKr1G5h+TTQMSfgew
   w==;
X-CSE-ConnectionGUID: bcO/3CYhS4C8vsiXBE7ufQ==
X-CSE-MsgGUID: 7YJeu+jTQxGdCwxXlX1dmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635945"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635945"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:05 -0700
X-CSE-ConnectionGUID: AJ1vfvCwR1+uDUkYPlnN2Q==
X-CSE-MsgGUID: QW0QTeN0TXWWk8m4dZGTkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968456"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:17:02 -0700
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
Subject: [PATCH 07/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for ARL
Date: Fri, 15 May 2026 14:11:39 +0800
Message-Id: <20260515061143.338553-8-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
References: <20260515061143.338553-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update perf hard-coded event constraints and cache_extra_regs[] for
Arrowlake according to the latest ARL perfmon events (V1.17).

ARL shares almost same event constraints and extra MSR configuration
with LNL except 2 differences.
- ARL P-core has different extra MSR value for OCR.DEMAND_DATA_RD.L3_MISS
  and OCR.DEMAND_RFO.L3_MISS. So introduce arl_lnc_hw_cache_extra_regs[]
  to reflect the difference.
- ARL-H has extra LPE cores which use crestmont architectures. Add
  crestmont specific event constraints and hw_cache_extra_regs[] for LPE
  cores.

ARL perfmon events:
https://github.com/intel/perfmon/blob/main/ARL/events/arrowlake_lioncove_core.json
https://github.com/intel/perfmon/blob/main/ARL/events/arrowlake_skymont_core.json
https://github.com/intel/perfmon/blob/main/ARL/events/arrowlake_crestmont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 56 ++++++++++++++++++++++++++++++------
 1 file changed, 48 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d9e421d4b3ed..dc5ab18888ea 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -850,6 +850,24 @@ static __initconst const u64 lnc_hw_cache_extra_regs
  },
 };
 
+/* ARL specific lioncove hw_cache_extra_regs[] variant. */
+static __initconst const u64 arl_lnc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFE7F8000001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFE7F8000002,	/* OCR.DEMAND_RFO.L3_MISS */
+	},
+ },
+};
+
 static __initconst const u64 pnc_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -8529,16 +8547,41 @@ __init int intel_pmu_init(void)
 	case INTEL_WILDCATLAKE_L:
 		pr_cont("Pantherlake Hybrid events, ");
 		name = "pantherlake_hybrid";
+
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
 		goto lnl_common;
 
-	case INTEL_LUNARLAKE_M:
 	case INTEL_ARROWLAKE:
+		pr_cont("Arrowlake Hybrid events, ");
+		name = "arrowlake_hybrid";
+
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+		memcpy(hybrid_var(&pmu->pmu, hw_cache_extra_regs),
+		       arl_lnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+
+		goto lnl_common;
+
+	case INTEL_LUNARLAKE_M:
 		pr_cont("Lunarlake Hybrid events, ");
 		name = "lunarlake_hybrid";
 
-	lnl_common:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_lnc(&pmu->pmu);
+
+	lnl_common:
+
 		x86_pmu.pebs_latency_data = lnl_latency_data;
 		x86_pmu.get_event_constraints = mtl_get_event_constraints;
 		x86_pmu.hw_config = adl_hw_config;
@@ -8549,10 +8592,6 @@ __init int intel_pmu_init(void)
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
 
-		/* Initialize big core specific PerfMon capabilities.*/
-		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-		intel_pmu_init_lnc(&pmu->pmu);
-
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
 		intel_pmu_init_skt(&pmu->pmu);
@@ -8576,6 +8615,8 @@ __init int intel_pmu_init(void)
 		/* Initialize big core specific PerfMon capabilities. */
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		intel_pmu_init_lnc(&pmu->pmu);
+		memcpy(hybrid_var(&pmu->pmu, hw_cache_extra_regs),
+		       arl_lnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 
 		/* Initialize Atom core specific PerfMon capabilities. */
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
@@ -8583,8 +8624,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize Lower Power Atom specific PerfMon capabilities. */
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_TINY_IDX];
-		intel_pmu_init_grt(&pmu->pmu);
-		pmu->extra_regs = intel_cmt_extra_regs;
+		intel_pmu_init_cmt(&pmu->pmu);
 
 		intel_pmu_pebs_data_source_arl_h();
 		pr_cont("ArrowLake-H Hybrid events, ");
-- 
2.34.1

