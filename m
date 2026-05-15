Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9837F8B5;
	Fri, 15 May 2026 06:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825816; cv=none; b=U1GFCXbiD6PJVWbUhhISJv8f43OKj47Ez9rsJpOz+2isCUlFBynJWUy87456TTHYpCAycXPh6gb5hJzwL03CYMS1vGaKix5RV/lNI2BThvfijYJNBld2disyt5oM4x+YBrZ5N7U698B9DtNy136KSzHakmWcSO/slaHi5bNnZlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825816; c=relaxed/simple;
	bh=psWd1r1DwA5qsyEADiCZYH147K6Ud6n3+mPTAVSIFTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kY5U9CMtiHlQamFwHx8fxqfcfDnN4GKIcElG34IQ/kqCjKDI/VGcid8pVs/FM0ytJpPlG4Tjo2TSUwhWWtAN5TLTzykrunVIf3KLx3i21LND4jTYkjOs7PpR/Du9WOhLoXmMuYfmlMLsVwSQKihhJ3j1FRjeu1MJd53pcK0cTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kQbzdMjG; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kQbzdMjG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825815; x=1810361815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=psWd1r1DwA5qsyEADiCZYH147K6Ud6n3+mPTAVSIFTw=;
  b=kQbzdMjGQconT5ff+nBpkUzf1r1zaxJtV1II6VHJSQ7FPV82Zj7IP+0G
   b7SFo3r6YbxBU1mHKgtZzreYdZg59hm8YNxKxr+eZ/sKnVGpvu7Ub6ZAQ
   ukDAxF5W3s2qpN/9xU8ZDzcPGd1/Dq5AxsclN4FUIju+soEtwRWjDqt+l
   dB++tOp4dK+ji0MmiotmjlkbWKk6Y1Fbpf3bma3TKwHPe5WgWGuRzPWb/
   CD6EMy9Wytn5ZTmeGfwBlnlQOI+70LtdZ54CfyUwJEK6ZS5rwbRCLYyMM
   h5u6Fy8lFfukBj5EAcjh++dFu11PS8DMMRm+bqZcWc61l1ARzgNQUa8ZS
   w==;
X-CSE-ConnectionGUID: 7BuMYUd/RQKUrqD6c21K3Q==
X-CSE-MsgGUID: u7uvPEYDTUm+54Hjw0TvgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635925"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635925"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:55 -0700
X-CSE-ConnectionGUID: 4S9Ss/FSTry3lqK5aBbC5g==
X-CSE-MsgGUID: 6JJezmJtTYOuHvdIy//uTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968434"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:51 -0700
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
Subject: [PATCH 04/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for ADL
Date: Fri, 15 May 2026 14:11:36 +0800
Message-Id: <20260515061143.338553-5-dapeng1.mi@linux.intel.com>
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
Alderlake according to the latest ADL perfmon events (V1.39).

One important note is that ADL has differences on the L3/node related
OCR events although it shares same uarch with SPR server, e.g.,
ADL has different extra MSR values and no node events. So some variants
of structures and functions are introduced to reflect these
differences, like adl_glc_hw_cache_event_ids[],
adl_glc_hw_cache_extra_regs[] and intel_pmu_init_glc_hybrid(), etc.

Please note these changes would temporarily impact other platforms like
MTL/ARL-U which shares hard-coded event structures, but it would be
fixed soon in subsequent patches.

ADL perfmon events:
https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_goldencove_core.json
https://github.com/intel/perfmon/blob/main/ADL/events/alderlake_gracemont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 137 +++++++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c   |   2 +-
 2 files changed, 131 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0d0edc2d1b90..7948e3afc291 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -215,8 +215,10 @@ static struct event_constraint intel_slm_event_constraints[] __read_mostly =
 
 static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0), /* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1), /* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF_TSC */
 	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
 	EVENT_CONSTRAINT_END
 };
@@ -713,6 +715,80 @@ static __initconst const u64 glc_hw_cache_event_ids
  },
 };
 
+/* ADL P-core (Golden cove) specific event code. */
+static __initconst const u64 adl_glc_hw_cache_event_ids
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(L1D ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x81d0,
+		[ C(RESULT_MISS)   ] = 0xe124,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x82d0,
+	},
+ },
+ [ C(L1I ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_MISS)   ] = 0xe424,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x12a,
+		[ C(RESULT_MISS)   ] = 0x12a,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x12a,
+		[ C(RESULT_MISS)   ] = 0x12a,
+	},
+ },
+ [ C(DTLB) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x81d0,
+		[ C(RESULT_MISS)   ] = 0xe12,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x82d0,
+		[ C(RESULT_MISS)   ] = 0xe13,
+	},
+ },
+ [ C(ITLB) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = 0xe11,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+ [ C(BPU ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4c4,
+		[ C(RESULT_MISS)   ] = 0x4c5,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+};
+
 static __initconst const u64 glc_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -736,6 +812,24 @@ static __initconst const u64 glc_hw_cache_extra_regs
  },
 };
 
+/* ADL P-core (Golden cove) specific extra regs value. */
+static __initconst const u64 adl_glc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3fbfc00002,	/* OCR.DEMAND_RFO.L3_MISS */
+	},
+ },
+};
+
 static __initconst const u64 pnc_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -2384,6 +2478,23 @@ static __initconst const u64 tnt_hw_cache_extra_regs
 	},
 };
 
+static __initconst const u64 grt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x10001,	/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x3F84400001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x10002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x3F84400002,	/* OCR.DEMAND_RFO.L3_MISS */
+		},
+	},
+};
+
+
 static __initconst const u64 arw_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -2434,9 +2545,12 @@ static struct attribute *grt_mem_attrs[] = {
 };
 
 static struct extra_reg intel_grt_extra_regs[] __read_mostly = {
-	/* must define OFFCORE_RSP_X first, see intel_fixup_er() */
-	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x3fffffffffull, RSP_0),
-	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3fffffffffull, RSP_1),
+	/*
+	 * Must define OFFCORE_RSP_X first, see intel_fixup_er().
+	 * Bit 63 only valid on OFFCORE_RSP_0 MSR.
+	 */
+	INTEL_UEVENT_EXTRA_REG(0x01b7, MSR_OFFCORE_RSP_0, 0x8003f03fffffffffull, RSP_0),
+	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OFFCORE_RSP_1, 0x3f03fffffffffull, RSP_1),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
 	EVENT_EXTRA_END
 };
@@ -7499,6 +7613,15 @@ static __always_inline void intel_pmu_init_glc(struct pmu *pmu)
 	intel_pmu_ref_cycles_ext();
 }
 
+static __always_inline void intel_pmu_init_glc_hybrid(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+
+	/* ADL has different extra MSR values from Server for the L3 or node OCR/OMR events. */
+	memcpy(hybrid_var(pmu, hw_cache_event_ids), adl_glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs), adl_glc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+}
+
 static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 {
 	x86_pmu.mid_ack = true;
@@ -7511,7 +7634,7 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	x86_pmu.flags |= PMU_FL_INSTR_LATENCY;
 
 	memcpy(hybrid_var(pmu, hw_cache_event_ids), glp_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-	memcpy(hybrid_var(pmu, hw_cache_extra_regs), tnt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs), grt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid_var(pmu, hw_cache_event_ids)[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
 	hybrid(pmu, event_constraints) = intel_grt_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_grt_pebs_event_constraints;
@@ -8269,7 +8392,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-		intel_pmu_init_glc(&pmu->pmu);
+		intel_pmu_init_glc_hybrid(&pmu->pmu);
 		if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU)) {
 			pmu->cntr_mask64 <<= 2;
 			pmu->cntr_mask64 |= 0x3;
@@ -8326,7 +8449,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-		intel_pmu_init_glc(&pmu->pmu);
+		intel_pmu_init_glc_hybrid(&pmu->pmu);
 		pmu->extra_regs = intel_rwc_extra_regs;
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7f0d515c07c5..efab3cb47885 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1292,7 +1292,7 @@ struct event_constraint intel_glm_pebs_event_constraints[] = {
 struct event_constraint intel_grt_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
 	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xf),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0x3f),
 	EVENT_CONSTRAINT_END
 };
 
-- 
2.34.1

