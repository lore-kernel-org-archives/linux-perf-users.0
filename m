Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDEF37FF5A;
	Fri, 15 May 2026 06:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825819; cv=none; b=EU/cezdntw0inQHWdofSfYyKDr5u0UnNRgnN4wjo9EebgNEJ20QfUN+2DKTEirtxm3fbteehGv/z8O0K4yDe+tJaSoyBP33GjAenJLe3boS17Ga7ky52aL/KAZB7giSJGyYqGmMBjgCnS/AwVz55aAWxHpNr2yFZwo0tn5rLSFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825819; c=relaxed/simple;
	bh=vd0ti1kv4xOGj/X27M8zqbXavkTXQHSVlktzCBHNdHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Su4R/h+p8objAg1jUcazVJFMseZUXheKMKZyO+dF8pc0rAfXVQPp4AyvS6bkCxCH9FVWutDc4wZ/UwHq/t4kofe4JSbHcFnB+EcRp2NEx/fdka5xBUexoxmfoUnWThEkMawxO9PcOvAk3AxowfQdIMwG1U5sJL0W3yeegX3jXE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fJ+3jtVo; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fJ+3jtVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825819; x=1810361819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vd0ti1kv4xOGj/X27M8zqbXavkTXQHSVlktzCBHNdHo=;
  b=fJ+3jtVoHWhx/CP3hM5L8Z3bmyJHqJlCRlHFD1j/ztK7NtapyPt3fbeH
   eD1vaOAhiIC5tBO6J15JylB77pqrkI1fo63xQi0/MgTyofZ8KKs3X3Wdu
   ClucEDRkd31ombandH7mTFMUHDGko1yim9bmtNx0kKIvnf80u0mpCv9h1
   Eg5tPBGBGpARX4lE5v4gLQX7DqzOTH9X9TYCO2oqRLCIbwurg1+5veyhJ
   uX2Js3W42oYpy+3X8ltuNNXojdTxTPKJxMyzmMy2vnpulgZho0/eldoSn
   Q1clF7iXS82Cxo+Lp/JwL4UfWbufUVLLcsdWrpM0q9OuWriMkrbPFYief
   g==;
X-CSE-ConnectionGUID: 273mHXayQSunkaApXuZjFA==
X-CSE-MsgGUID: gIkZo+qKRK2EOLUR6un4Wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635932"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635932"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:16:58 -0700
X-CSE-ConnectionGUID: tCxYwuPPQueNxd639Crhsw==
X-CSE-MsgGUID: 48LkMw1xRfmf0DbS8ct/IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968443"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:16:55 -0700
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
Subject: [PATCH 05/11] perf/x86/intel: Update event constraints and cache_extra_regs[] for MTL
Date: Fri, 15 May 2026 14:11:37 +0800
Message-Id: <20260515061143.338553-6-dapeng1.mi@linux.intel.com>
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
Meteor Lake according to the latest MTL perfmon events (V1.21).

MTL P-core (redwoodcove) inherits same perf events list from previous
generation (Goldencove), but the E-core (Crestmont) brings some
difference on the perf event list comparing with Gracemont. So apply
the changes for Crestmont core.

MTL perfmon events:
https://github.com/intel/perfmon/blob/main/MTL/events/meteorlake_redwoodcove_core.json
https://github.com/intel/perfmon/blob/main/MTL/events/meteorlake_crestmont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 27 +++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c   |  7 +++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7948e3afc291..5d99cfd7e701 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2494,6 +2494,21 @@ static __initconst const u64 grt_hw_cache_extra_regs
 	},
 };
 
+static __initconst const u64 cmt_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
+	[C(LL)] = {
+		[C(OP_READ)] = {
+			[C(RESULT_ACCESS)]	= 0x10001,	/* OCR.DEMAND_DATA_RD.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x3fbfc00001,	/* OCR.DEMAND_DATA_RD.L3_MISS */
+		},
+		[C(OP_WRITE)] = {
+			[C(RESULT_ACCESS)]	= 0x10002,	/* OCR.DEMAND_RFO.ANY_RESPONSE */
+			[C(RESULT_MISS)]	= 0x3fbfc00002,	/* OCR.DEMAND_RFO.L3_MISS */
+		},
+	},
+};
 
 static __initconst const u64 arw_hw_cache_extra_regs
 				[PERF_COUNT_HW_CACHE_MAX]
@@ -7643,6 +7658,15 @@ static __always_inline void intel_pmu_init_grt(struct pmu *pmu)
 	intel_pmu_ref_cycles_ext();
 }
 
+static __always_inline void intel_pmu_init_cmt(struct pmu *pmu)
+{
+	intel_pmu_init_grt(pmu);
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       cmt_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, pebs_constraints) = intel_cmt_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_cmt_extra_regs;
+}
+
 static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
 {
 	intel_pmu_init_glc(pmu);
@@ -8454,8 +8478,7 @@ __init int intel_pmu_init(void)
 
 		/* Initialize Atom core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
-		intel_pmu_init_grt(&pmu->pmu);
-		pmu->extra_regs = intel_cmt_extra_regs;
+		intel_pmu_init_cmt(&pmu->pmu);
 
 		intel_pmu_pebs_data_source_mtl();
 		pr_cont("Meteorlake Hybrid events, ");
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index efab3cb47885..75b7f6f6d8bc 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1296,6 +1296,13 @@ struct event_constraint intel_grt_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_cmt_pebs_event_constraints[] = {
+	/* Allow all events as PEBS with no flags */
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0x3),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_arw_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
 	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..fad99183f4d8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1702,6 +1702,8 @@ extern struct event_constraint intel_glp_pebs_event_constraints[];
 
 extern struct event_constraint intel_grt_pebs_event_constraints[];
 
+extern struct event_constraint intel_cmt_pebs_event_constraints[];
+
 extern struct event_constraint intel_arw_pebs_event_constraints[];
 
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
-- 
2.34.1

