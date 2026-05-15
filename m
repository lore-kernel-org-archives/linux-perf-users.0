Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E452381AFE;
	Fri, 15 May 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825833; cv=none; b=uPLNAmcIPqadMKu+cbP+4WI+NY4Rbcb5tp6GIwF4kNJne9c6WTCIHWsRWDIxVDrXU7vdngi0sZpKGQKdyx9mXui1tz3hYXojXKyD9X+BXOKzCJObq2+YR8DsPJXCy5zBQwPnrQys6IirfcnHGIGPFfEu0zQFFICq5qEalTclTpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825833; c=relaxed/simple;
	bh=klmNZhYOi0bgb3HQQRUQRlEGV+ObqwSw2ooMQpRRfAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jbUEKCjpODHdUTFG5docaDoMeD5qHRVBw7aFMARRtEaLY7JfKKIimtjbKRaBCLFK12xoLYQPbAUdrd0bI9WvANgw3WinITCU8lVqmlHt9jFFX9BIuCKQ5XgTfVCte9G3TXVjokvFKd0SSZeaD8ib5CRjz1atKWDq1qiqwlVxpYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TA51LmU4; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TA51LmU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825832; x=1810361832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=klmNZhYOi0bgb3HQQRUQRlEGV+ObqwSw2ooMQpRRfAo=;
  b=TA51LmU4LZiPAHOc3XS6AT9K1hxE58AWuHEJZE8FOrpVfj5LXwR6/yaE
   nb6mhlDF97+QLTvAmpYFUN+xieC/QgiyJfzlwNqNOvtDdHGQCYHCpvjkt
   +RO69qNbK9xid68L9wA/emsQE1Z0ifTdd+POt2vYf95NyhG+nQF1j+VXS
   8koXLYUOpzWwCm0dqWWZfaNECBHN0Ak9BdAN4mVdnbw9QNpo6ICe/JDXr
   o8Jz5Ex8EftWfIJ/tI5pduEuX6kRGC45QPiwVHSkgggA3i80or1dVJh+8
   sXtmBIxEHPz0kErs1seaawGlVJDGJ/DZNimkhN0giTthBuJXEJIzd6gJP
   g==;
X-CSE-ConnectionGUID: tMl/MCD7R1i/1mE2IGEtxA==
X-CSE-MsgGUID: eUJ7vMN8RK2v32KbHqJuXQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635957"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635957"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:12 -0700
X-CSE-ConnectionGUID: NDBnyoD4Sk2m/5WVlrf7LA==
X-CSE-MsgGUID: ed11YiNuSp+/+VrOlMUiGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968492"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:17:09 -0700
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
Subject: [PATCH 09/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for NVL
Date: Fri, 15 May 2026 14:11:41 +0800
Message-Id: <20260515061143.338553-10-dapeng1.mi@linux.intel.com>
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
Novalake according to the latest NVL perfmon events.

The 4 PRECISE_OMR events (0xd4) are broken on Arcticwolf and would be
removed from upcoming released event list, so delete them from event
constraints and extra_regs array accordingly.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 55 +++++++++++++++++++++++-------------
 arch/x86/events/intel/ds.c   | 11 --------
 arch/x86/events/perf_event.h |  2 --
 3 files changed, 36 insertions(+), 32 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b281402c3753..587167dbb98f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -241,20 +241,21 @@ static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
 
 static struct event_constraint intel_arw_event_constraints[] __read_mostly = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0), /* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0), /* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1), /* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1), /* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2), /* pseudo CPU_CLK_UNHALTED.REF_TSC */
 	FIXED_EVENT_CONSTRAINT(0x013c, 2), /* CPU_CLK_UNHALTED.REF_TSC_P */
 	FIXED_EVENT_CONSTRAINT(0x0073, 4), /* TOPDOWN_BAD_SPECULATION.ALL */
+	FIXED_EVENT_CONSTRAINT(0x0500, 4), /* pseudo TOPDOWN_BAD_SPECULATION.ALL */
 	FIXED_EVENT_CONSTRAINT(0x019c, 5), /* TOPDOWN_FE_BOUND.ALL */
+	FIXED_EVENT_CONSTRAINT(0x0600, 5), /* pseudo TOPDOWN_FE_BOUND.ALL */
 	FIXED_EVENT_CONSTRAINT(0x02c2, 6), /* TOPDOWN_RETIRING.ALL */
+	FIXED_EVENT_CONSTRAINT(0x0700, 6), /* pseudo TOPDOWN_RETIRING.ALL */
 	INTEL_UEVENT_CONSTRAINT(0x01b7, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x02b7, 0x2),
 	INTEL_UEVENT_CONSTRAINT(0x04b7, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x08b7, 0x8),
-	INTEL_UEVENT_CONSTRAINT(0x01d4, 0x1),
-	INTEL_UEVENT_CONSTRAINT(0x02d4, 0x2),
-	INTEL_UEVENT_CONSTRAINT(0x04d4, 0x4),
-	INTEL_UEVENT_CONSTRAINT(0x08d4, 0x8),
 	INTEL_UEVENT_CONSTRAINT(0x0175, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x0275, 0x2),
 	INTEL_UEVENT_CONSTRAINT(0x21d3, 0x1),
@@ -964,6 +965,23 @@ static __initconst const u64 pnc_hw_cache_extra_regs
  },
 };
 
+static __initconst const u64 cyc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4000000000000001,	/* OMR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFF03F000000001,	/* OMR.DEMAND_DATA_RD.L3_MISS */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4000000000000002, 	/* OMR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0xFF03F000000002,	/* OMR.DEMAND_RFO.L3_MISS */
+	},
+ },
+};
+
 /*
  * Notes on the events:
  * - data reads do not include code reads (comparable to earlier tables)
@@ -2570,16 +2588,12 @@ static __initconst const u64 arw_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
 	[C(LL)] = {
 		[C(OP_READ)] = {
-			[C(RESULT_ACCESS)]	= 0x4000000000000001,
-			[C(RESULT_MISS)]	= 0xFFFFF000000001,
+			[C(RESULT_ACCESS)]	= 0x4000000000000009,	/* OMR.DEMAND_DATA_RD.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0xFF03F000000009,	/* OMR.DEMAND_DATA_RD.L3_MISS */
 		},
 		[C(OP_WRITE)] = {
-			[C(RESULT_ACCESS)]	= 0x4000000000000002,
-			[C(RESULT_MISS)]	= 0xFFFFF000000002,
-		},
-		[C(OP_PREFETCH)] = {
-			[C(RESULT_ACCESS)]	= 0x0,
-			[C(RESULT_MISS)]	= 0x0,
+			[C(RESULT_ACCESS)]	= 0x400000000000000A,	/* OMR.DEMAND_RFO.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0xFF03F00000000A,	/* OMR.DEMAND_RFO.L3_MISS */
 		},
 	},
 };
@@ -2651,10 +2665,6 @@ static struct extra_reg intel_arw_extra_regs[] __read_mostly = {
 	INTEL_UEVENT_EXTRA_REG(0x02b7, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
 	INTEL_UEVENT_EXTRA_REG(0x04b7, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
 	INTEL_UEVENT_EXTRA_REG(0x08b7, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
-	INTEL_UEVENT_EXTRA_REG(0x01d4, MSR_OMR_0, 0xc0ffffffffffffffull, OMR_0),
-	INTEL_UEVENT_EXTRA_REG(0x02d4, MSR_OMR_1, 0xc0ffffffffffffffull, OMR_1),
-	INTEL_UEVENT_EXTRA_REG(0x04d4, MSR_OMR_2, 0xc0ffffffffffffffull, OMR_2),
-	INTEL_UEVENT_EXTRA_REG(0x08d4, MSR_OMR_3, 0xc0ffffffffffffffull, OMR_3),
 	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x5d0),
 	INTEL_UEVENT_EXTRA_REG(0x0127, MSR_SNOOP_RSP_0, 0xffffffffffffffffull, SNOOP_0),
 	INTEL_UEVENT_EXTRA_REG(0x0227, MSR_SNOOP_RSP_1, 0xffffffffffffffffull, SNOOP_1),
@@ -7746,6 +7756,13 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
 }
 
+static __always_inline void intel_pmu_init_cyc(struct pmu *pmu)
+{
+	intel_pmu_init_pnc(pmu);
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       cyc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+}
+
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 {
 	intel_pmu_init_cmt(pmu);
@@ -7770,7 +7787,7 @@ static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
 	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
 	       arw_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	hybrid(pmu, event_constraints) = intel_arw_event_constraints;
-	hybrid(pmu, pebs_constraints) = intel_arw_pebs_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_dkt_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_arw_extra_regs;
 	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
@@ -8661,7 +8678,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
-		intel_pmu_init_pnc(&pmu->pmu);
+		intel_pmu_init_cyc(&pmu->pmu);
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5159adabb9a2..cb72af9b61ce 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1310,17 +1310,6 @@ struct event_constraint intel_dkt_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-struct event_constraint intel_arw_pebs_event_constraints[] = {
-	/* Allow all events as PEBS with no flags */
-	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
-	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x01d4, 0x1),
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x02d4, 0x2),
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04d4, 0x4),
-	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08d4, 0x8),
-	EVENT_CONSTRAINT_END
-};
-
 struct event_constraint intel_nehalem_pebs_event_constraints[] = {
 	INTEL_PLD_CONSTRAINT(0x100b, 0xf),      /* MEM_INST_RETIRED.* */
 	INTEL_FLAGS_EVENT_CONSTRAINT(0x0f, 0xf),    /* MEM_UNCORE_RETIRED.* */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f9ea07d60930..a4525589bec1 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1706,8 +1706,6 @@ extern struct event_constraint intel_cmt_pebs_event_constraints[];
 
 extern struct event_constraint intel_dkt_pebs_event_constraints[];
 
-extern struct event_constraint intel_arw_pebs_event_constraints[];
-
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
 
 extern struct event_constraint intel_westmere_pebs_event_constraints[];
-- 
2.34.1

