Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA537F8A9;
	Fri, 15 May 2026 06:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825823; cv=none; b=b961KweN1IjjNTMjgbRhB6v9zoDUjYP1ChlViHexfjti8cK3HrI9ciJ2hy3KzksrXfFMMoSPAQz6KssFh3u0ESZnWShNdrE0TJSdGhNxopQ5pOfuoWbi3brAdg8a+2fMFIZLBOAaQ7cxnEVrH4yEoZW31tivpReWi3nJUsin+8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825823; c=relaxed/simple;
	bh=OrnBJs2YcP4mlJZFXIBiK26Z6ULAaXjYoU44Abo17YI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qT+vG5KXWG3h3WXJhvwBEKERmZlHL3hELAadaagE+oVlbLL1ZLrBwll8tMmnJ4DdL7vhTme4aIOA4+Ay1sen9GngFenD34x0oVKC/IyZ3JNz8IoMuydRB55hJK3KCzDIGEvnetLkqtZvUO8o+whtX/a0FZcQNAqNv3EZ1kXdMDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X9bQ2o2L; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X9bQ2o2L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825822; x=1810361822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OrnBJs2YcP4mlJZFXIBiK26Z6ULAaXjYoU44Abo17YI=;
  b=X9bQ2o2L7Ltb2A1/owyqZPNmLOGgE6ooX0F+uCJYLf3UjnZnAyrF3WuD
   d/YnbXoMdfb+weFjCKJfbwV2aQBkEBXICM2Yx0iildY4Q4qubc7qxYddz
   7t9dQofyPoIHEXR7bnaZMir/vB5ejJ6N0wS0jJvcr1OMi0bUnQvh9ucpg
   XPVKd5sjEljbj2yScdpiB/Dj81jR+OAI1UCCUQo5Ktm1FJs+fJO4SMhf0
   8wF/mLxq93SMQ6KkjjqY6GEW5fA8IFGgeH12G58bOjXlqnbpZaDYEsI1X
   7jbKhZe8/ygfr4pkKey/DZlgONcwiDUhxec+IsHmcomXAZ1cVTM6KGa3B
   g==;
X-CSE-ConnectionGUID: Axq5X6qIRp61yEoS2D/iOg==
X-CSE-MsgGUID: 6na8WCmGQAGQEEp99HFF7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635939"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635939"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:02 -0700
X-CSE-ConnectionGUID: yLuzW40zRECeTX0OL4Y8zQ==
X-CSE-MsgGUID: Puf86xozSMyiB68ve6W6xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968450"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:58 -0700
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
Subject: [PATCH 06/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for LNL
Date: Fri, 15 May 2026 14:11:38 +0800
Message-Id: <20260515061143.338553-7-dapeng1.mi@linux.intel.com>
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
Lunarlake according to the latest LNL perfmon events (V1.22).

LNL introduces new extra register values for the OCR L3 cache events,
so introduce lnc_hw_cache_extra_regs[] and skt_hw_cache_extra_regs[] to
reflect the changes.

LNL perfmon events:
https://github.com/intel/perfmon/blob/main/LNL/events/lunarlake_lioncove_core.json
https://github.com/intel/perfmon/blob/main/LNL/events/lunarlake_skymont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 62 +++++++++++++++++++++++++++++-------
 arch/x86/events/intel/ds.c   |  8 +++++
 2 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5d99cfd7e701..d9e421d4b3ed 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -225,12 +225,17 @@ static struct event_constraint intel_grt_event_constraints[] __read_mostly = {
 
 static struct event_constraint intel_skt_event_constraints[] __read_mostly = {
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
 	EVENT_CONSTRAINT_END
 };
 
@@ -415,11 +420,12 @@ static struct extra_reg intel_rwc_extra_regs[] __read_mostly = {
 
 static struct event_constraint intel_lnc_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
-	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
 	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
-	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
@@ -431,8 +437,6 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 
 	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
 
-	INTEL_UEVENT_CONSTRAINT(0x012a, 0xf),
-	INTEL_UEVENT_CONSTRAINT(0x012b, 0xf),
 	INTEL_UEVENT_CONSTRAINT(0x0148, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x0175, 0x4),
 
@@ -443,15 +447,14 @@ static struct event_constraint intel_lnc_event_constraints[] = {
 	INTEL_UEVENT_CONSTRAINT(0x0ca3, 0x4),
 	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
 	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
-	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x10a4, 0x8),
 	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
 	INTEL_UEVENT_CONSTRAINT(0x01cd, 0x3fc),
 	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
 
+	INTEL_UEVENT_CONSTRAINT(0x87d0, 0x3ff),
 	INTEL_EVENT_CONSTRAINT_RANGE(0xd0, 0xdf, 0xf),
 
-	INTEL_UEVENT_CONSTRAINT(0x00e0, 0xf),
-
 	EVENT_CONSTRAINT_END
 };
 
@@ -830,6 +833,23 @@ static __initconst const u64 adl_glc_hw_cache_extra_regs
  },
 };
 
+static __initconst const u64 lnc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x9E7FA000001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x9E7FA000002,	/* OCR.DEMAND_RFO.L3_MISS */
+	},
+ },
+};
+
 static __initconst const u64 pnc_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -2510,6 +2530,22 @@ static __initconst const u64 cmt_hw_cache_extra_regs
 	},
 };
 
+static __initconst const u64 skt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x13FBFC00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x10002,		/* OCR.DEMAND_RFO.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x13FBFC00002,	/* OCR.DEMAND_RFO.L3_MISS */
+		},
+	},
+};
+
 static __initconst const u64 arw_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -7673,6 +7709,9 @@ static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
 	hybrid(pmu, event_constraints) = intel_lnc_event_constraints;
 	hybrid(pmu, pebs_constraints) = intel_lnc_pebs_event_constraints;
 	hybrid(pmu, extra_regs) = intel_lnc_extra_regs;
+
+	memcpy(hybrid_var(pmu, hw_cache_event_ids), adl_glc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs), lnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 }
 
 static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
@@ -7691,9 +7730,10 @@ static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
 
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 {
-	intel_pmu_init_grt(pmu);
+	intel_pmu_init_cmt(pmu);
 	hybrid(pmu, event_constraints) = intel_skt_event_constraints;
-	hybrid(pmu, extra_regs) = intel_cmt_extra_regs;
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       skt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 75b7f6f6d8bc..ce23b50f449a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1507,6 +1507,13 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
 	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
 
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012a, 0x1),		/* OCR.* events */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x012b, 0x1),		/* OCR.* events */
+
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x04a4, 0x1),		/* TOPDOWN.BAD_SPEC_SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x08a4, 0x1),		/* TOPDOWN.BR_MISPREDICT_SLOTS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x10a4, 0x8),		/* TOPDOWN.MEMORY_BOUND_SLOTS */
+
 	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0x3fc),
 	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
@@ -1516,6 +1523,7 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
 	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x87d0, 0x3ff),		/* MEM_INST_RETIRED.ANY */
 
 	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
 
-- 
2.34.1

