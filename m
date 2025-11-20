Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE76301472;
	Thu, 20 Nov 2025 05:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617054; cv=none; b=CiMFb0E8TYArxn2Cawmx6VWWcD0YIxuXX4ndwg3R5XP7HkKnFsEeWlwemvR1MNlJ7UwzFI5qsz/5st6rg5/0iCs8S9jJLWOSAYb54BAV52oSBlyg56Tf0Aj8oHxAwP3w++Bwje4XUlpKhEI8emPFtA/rNpaYD2Acs2ubPTRIXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617054; c=relaxed/simple;
	bh=lZBbp+H21/A2cYsJZkoGZbNA1rryNfZ+cMVHMwgGU6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LSn5DIG0CYwEoGR/2GQsRoNEu7N/0dpP1Dh7N4PwegX+EP58+ez9gVNarv9JGuRCj5KWilIA9uhjkbAtdsqGqyIA4T3BA2k4+gCHPmL7LQF9uNRvchcAs62IT/e7l8Lac51EvAycRrIZUyZlYOZ83gbYEGW3/1luUoVO7ljvDnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCZzNBnv; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCZzNBnv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617052; x=1795153052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lZBbp+H21/A2cYsJZkoGZbNA1rryNfZ+cMVHMwgGU6k=;
  b=HCZzNBnvMJLhDtF33+h6JbftAx2PRJkd5rKZEIifs8EKVzJWmJVJcpp4
   AZyLEZ+TpnLQAiB3c/FqN8nIosHPetFPTXOQwnoFspt8AfMA5q0C37qmk
   TRly2I2TgxqyQ66I1jV0/9ps0SzbQsyg676+5gKaINJbejp7Nsjuo5yPq
   grYwVTRqbBAB8SXEa0BqzyfrE2IN5vKmtmQl7Gwex0Wg0vsNoG70JzsaD
   8vM48YaxBM3nZhzwaLL+gxCkMudjJordo60K/2JQh5WsOlpP6g81UGP/d
   eMCLoBgCsAd0VIhkLlrNphNVQUlsvIRztkt3wWnuUsZs2LXg9X8+KYFIr
   w==;
X-CSE-ConnectionGUID: kgOjhIDASrGDAJIt7EBjIg==
X-CSE-MsgGUID: UmE0cpLsQfOHbLIxKDjARw==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710198"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710198"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:22 -0800
X-CSE-ConnectionGUID: iFQbWkp8TVaqJL64cOypsA==
X-CSE-MsgGUID: fki4ppnORdyfLXSXJmDEHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055563"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:37:19 -0800
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
Subject: [PATCH 5/7] perf/x86/intel: Add core PMU support for Novalake
Date: Thu, 20 Nov 2025 13:34:29 +0800
Message-Id: <20251120053431.491677-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
References: <20251120053431.491677-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch enables core PMU support for Novalake, covering both P-core
and E-core. It includes Arctic Wolf-specific counters, PEBS constraints,
and the OMR registers table.

Since Coyote Cove shares the same PMU capabilities as Panther Cove, the
existing Panther Cove PMU enabling functions are reused for Coyote Cove.

For detailed information about counter constraints, please refer to
section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.

ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 99 ++++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   | 11 ++++
 arch/x86/events/perf_event.h |  2 +
 3 files changed, 112 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9f2a93fe23df..a3a1e6e670f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -232,6 +232,29 @@ static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
 	EVENT_CONSTRAINT_END
 };
 
+static struct event_constraint intel_arw_event_constraints[] __read_mostly = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	INTEL_UEVENT_CONSTRAINT(0x01b7, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x02b7, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x04b7, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x08b7, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x01d4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x02d4, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x04d4, 0x4),
+	INTEL_UEVENT_CONSTRAINT(0x08d4, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x0175, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x0275, 0x2),
+	INTEL_UEVENT_CONSTRAINT(0x21d3, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x22d3, 0x1),
+	EVENT_CONSTRAINT_END
+};
+
 static struct event_constraint intel_skl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
@@ -2319,6 +2342,26 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
 
+static __initconst const u64 arw_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x4000000000000001,
+			[C(RESULT_MISS)]	= 0xFFFFF000000001,
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x4000000000000002,
+			[C(RESULT_MISS)]	= 0xFFFFF000000002,
+		},
+		[C(OP_PREFETCH)] = {
+			[C(RESULT_ACCESS)]	= 0x0,
+			[C(RESULT_MISS)]	= 0x0,
+		},
+	},
+};
+
 EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_tnt,        "event=0x71,umask=0x0");
 EVENT_ATTR_STR(topdown-retiring,       td_retiring_tnt,        "event=0xc2,umask=0x0");
 EVENT_ATTR_STR(topdown-bad-spec,       td_bad_spec_tnt,        "event=0x73,umask=0x6");
@@ -2377,6 +2420,22 @@ static struct extra_reg intel_cmt_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct extra_reg intel_arw_extra_regs[] __read_mostly = {
+	/* must define OMR_X first, see intel_alt_er() */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OMR_0, 0xc0ffffffffffffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x04b7, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x08b7, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
+	INTEL_UEVENT_EXTRA_REG(0x01d4, MSR_OMR_0, 0xc0ffffffffffffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x02d4, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x04d4, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x08d4, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
+	INTEL_UEVENT_EXTRA_REG(0x0127, MSR_SNOOP_RSP_0, 0xffffffffffffffffull, SNOOP_0),
+	INTEL_UEVENT_EXTRA_REG(0x0227, MSR_SNOOP_RSP_1, 0xffffffffffffffffull, SNOOP_1),
+	EVENT_EXTRA_END
+};
+
 EVENT_ATTR_STR(topdown-fe-bound,       td_fe_bound_skt,        "event=0x9c,umask=0x01");
 EVENT_ATTR_STR(topdown-retiring,       td_retiring_skt,        "event=0xc2,umask=0x02");
 EVENT_ATTR_STR(topdown-be-bound,       td_be_bound_skt,        "event=0xa4,umask=0x02");
@@ -7399,6 +7458,19 @@ static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
+static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	x86_pmu.flags &= ~PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |= PMU_FL_HAS_OMR;
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       arw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, event_constraints) = intel_arw_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_arw_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_arw_extra_regs;
+	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -8239,6 +8311,33 @@ __init int intel_pmu_init(void)
 		name = "arrowlake_h_hybrid";
 		break;
 
+	case INTEL_NOVALAKE:
+	case INTEL_NOVALAKE_L:
+		pr_cont("Novalake Hybrid events, ");
+		name = "novalake_hybrid";
+		intel_pmu_init_hybrid(hybrid_big_small);
+
+		x86_pmu.pebs_latency_data = nvl_latency_data;
+		x86_pmu.get_event_constraints = mtl_get_event_constraints;
+		x86_pmu.hw_config = adl_hw_config;
+
+		td_attr = lnl_hybrid_events_attrs;
+		mem_attr = mtl_hybrid_mem_attrs;
+		tsx_attr = adl_hybrid_tsx_attrs;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
+
+		/* Initialize big core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
+		intel_pmu_init_pnc(&pmu->pmu);
+
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_arw(&pmu->pmu);
+
+		intel_pmu_pebs_data_source_lnl();
+		break;
+
 	default:
 		switch (x86_pmu.version) {
 		case 1:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index d082eb160a10..c6aec7765c02 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1292,6 +1292,17 @@ struct event_constraint intel_grt_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_arw_pebs_event_constraints[] = {
+	/* Allow all events as PEBS with no flags */
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01d4, 0x1),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x02d4, 0x2),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04d4, 0x4),
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08d4, 0x8),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index aedc1a7762c2..f7caabc5d487 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1680,6 +1680,8 @@ extern struct event_constraint intel_glp_pebs_event_constraints[];
 
 extern struct event_constraint intel_grt_pebs_event_constraints[];
 
+extern struct event_constraint intel_arw_pebs_event_constraints[];
+
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
 
 extern struct event_constraint intel_westmere_pebs_event_constraints[];
-- 
2.34.1

