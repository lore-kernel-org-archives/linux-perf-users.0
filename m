Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151FD37D113;
	Fri, 15 May 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825805; cv=none; b=XFteV0c2livuMLZxJpXzzuCdwupRTPtZxhc9B7UNB3K8mB6sr/udSkhGmgid2PoQt6OteeuJ7CA0m2MOyTbDUXTYTQG5ets5q8mM0qVMJ+IbENJWFg1DR/CCuUfJSD+Om2f8YfdzVDBADJ8tH1VyWV/5c+OaaiOpvGi/XVClBJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825805; c=relaxed/simple;
	bh=q78U6SG+fKDeY8FFP20QaKJWGUCoDD5Fcusg3biJUUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtBL1CZfoO5y4oAvCcuBK4pftUs/iORlGHZ2k3OB3C3KC13Ny9vQ6qRH0dJwOxh2goxm9claxthrrznU/Bu6dlpnW23whetoN8+rnwhDuRduk315o7Mc44FPbgj6Pz3jrFYw9zZhylnEY68EUIw1KHrZ+kB1H1UC0RT6ALtZVQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hs5naMCF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hs5naMCF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825804; x=1810361804;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q78U6SG+fKDeY8FFP20QaKJWGUCoDD5Fcusg3biJUUo=;
  b=Hs5naMCFu9xUAyZgwMyhFsinKXS95JbtU8NnGAQb1Zr04ith62JtCSRv
   DozRG/9B6gXlQqnVoomhBhhc6erPypwTJLPHFqlfzy9HdDyPo0yg2a4js
   HM/TmVUmn7gfU20xIRBmPMnFbRUoljlSGQ6cSbd4PqJejYk4Q00kQKQZs
   vQGf0yKWN3Xij4epdQZl0l0BEZSG+0WifQ/K+mkE/P6YwHabmvNDiKM24
   4VbZ8g9TQOO5UX3wbqoHdqaPTU5tqJanNzLg/kpPg/hJuP36KEzfBgT7i
   5Y02VlRZ4lagJbN9yvle2O1xpj+eVijcxuzmdg6VrR6qTFa8GrZYntzlg
   Q==;
X-CSE-ConnectionGUID: DIOs8URFRLKRhU27RPVb8w==
X-CSE-MsgGUID: jg5mOzIyRdeg9ozowX+3XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635903"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:44 -0700
X-CSE-ConnectionGUID: LLoAHXbdTAWL3QH9A1GjtQ==
X-CSE-MsgGUID: hK7Livk3SFaMmkEP/VKYVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968404"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:41 -0700
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
Subject: [PATCH 01/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for ICX
Date: Fri, 15 May 2026 14:11:33 +0800
Message-Id: <20260515061143.338553-2-dapeng1.mi@linux.intel.com>
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
Icelake server according to the latest ICX perfmon events (v1.30).

Since the value of cache extra registers differs with previous
generations, introduce new snc_hw_cache_extra_regs[] to represent the
value of extra registers on ICX.

ICX perfmon events:
https://github.com/intel/perfmon/blob/main/ICX/events/icelakex_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 48 ++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 793335c3ce78..1390d1da985b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -310,10 +310,11 @@ static struct extra_reg intel_skl_extra_regs[] __read_mostly = {
 static struct event_constraint intel_icl_event_constraints[] = {
 	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x01c0, 0),	/* old INST_RETIRED.PREC_DIST */
-	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* pseudo INST_RETIRED.ANY */
 	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
-	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
-	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	FIXED_EVENT_CONSTRAINT(0x0200, 1),	/* pseudo CPU_CLK_UNHALTED.THREAD */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* pseudo CPU_CLK_UNHALTED.REF_TSC */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* pseudo TOPDOWN.SLOTS */
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
 	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
@@ -1019,6 +1020,41 @@ static __initconst const u64 skl_hw_cache_extra_regs
  },
 };
 
+static __initconst const u64 snc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x10001,		/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3FBFC00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x3F3FFC0002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
+		[ C(RESULT_MISS)   ] = 0x3F3FC00002,	/* OCR.DEMAND_RFO.L3_MISS */
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = 0x0,
+		[ C(RESULT_MISS)   ] = 0x0,
+	},
+ },
+ [ C(NODE) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x104000001,	/* OCR.DEMAND_DATA_RD.LOCAL_DRAM */
+		[ C(RESULT_MISS)   ] = 0x730000001,	/* OCR.DEMAND_DATA_RD.REMOTE_DRAM */
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x104000002,	/* OCR.DEMAND_RFO.LOCAL_DRAM */
+		[ C(RESULT_MISS)   ] = 0x730000002,	/* OCR.DEMAND_RFO.REMOTE_DRAM */
+	},
+	[ C(OP_PREFETCH) ] = {
+		[ C(RESULT_ACCESS) ] = 0x0,
+		[ C(RESULT_MISS)   ] = 0x0,
+	},
+ },
+};
+
 #define SNB_DMND_DATA_RD	(1ULL << 0)
 #define SNB_DMND_RFO		(1ULL << 1)
 #define SNB_DMND_IFETCH		(1ULL << 2)
@@ -8119,17 +8155,19 @@ __init int intel_pmu_init(void)
 
 	case INTEL_ICELAKE_X:
 	case INTEL_ICELAKE_D:
+		memcpy(hw_cache_extra_regs, snc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 		x86_pmu.pebs_ept = 1;
 		pmem = true;
-		fallthrough;
+		goto snc_common;
 	case INTEL_ICELAKE_L:
 	case INTEL_ICELAKE:
 	case INTEL_TIGERLAKE_L:
 	case INTEL_TIGERLAKE:
 	case INTEL_ROCKETLAKE:
+		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	snc_common:
 		x86_pmu.late_ack = true;
 		memcpy(hw_cache_event_ids, skl_hw_cache_event_ids, sizeof(hw_cache_event_ids));
-		memcpy(hw_cache_extra_regs, skl_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
 		hw_cache_event_ids[C(ITLB)][C(OP_READ)][C(RESULT_ACCESS)] = -1;
 		intel_pmu_lbr_init_skl();
 
-- 
2.34.1

