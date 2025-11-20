Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F063019D6;
	Thu, 20 Nov 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617036; cv=none; b=LAfP2MGbexX5wphcNSpWgqsiRtSIeXo9QCZ0IqMvzepUfw9UsFkWBiS+jTcBXWaZNyPjIlRbcGr2UDFXEc94hdQI7evAiFHifJb8EE12CsT3M7tE7lF2Z/GG1VB6HdOJL816lBmf8m/YVoAe7BwjcwGPeMypp24gTBMCW4/Ab0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617036; c=relaxed/simple;
	bh=1SG+Nk7fXs6Rhn29C77LsyulCmsbSDBPK13bQ2VEsqY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Au85sm3qme7XSfgANJqi/DJHZ6dripOGnSUuW4psD0jddaY2rf4qkkBQzb0EdUVGXxLiKnV6Vdyo6WH8jc8pqlqudp5ri7y4ubzjJ1/DG7DAwVvViBuWfIwvg/U+AntuluX7yHfV0rGjxEWIUh6BoboGGaKDnhoD7Qxuot8xvfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwW0xjnA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwW0xjnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763617035; x=1795153035;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1SG+Nk7fXs6Rhn29C77LsyulCmsbSDBPK13bQ2VEsqY=;
  b=JwW0xjnAJkolIpuzO2jpNvHKcGR2/yZg6/nm0JoL3v2s7Cg07TwqSvti
   G+23wpudb+5FmKf3/2cJisJ9veyStjPeivQDzLHpAVhSSmOj+54p+/k7R
   OoJHKqr+tDN3wWrHd4sot9kj0z+tbBVesYhVN8zyrJh4WZ/FeM1wcAX7V
   SF0sGcwCKf6bOQpuKzKYUkHMxJrAXDyV2jDN3LJ8FFLrIYUc9NisIxjxn
   fqbpYY85wd44HrveP+oKzDF/Qq8vQB7otq7hnvVBwhXrQRYB6f3RPtCs3
   klpxIbJFy4VcsQpEhUeCZ+Ry56Uz7nvnqhLfM3m0kjtGufCCypD05VRs6
   w==;
X-CSE-ConnectionGUID: ougvEyaCTF6lWfKjw7E7CA==
X-CSE-MsgGUID: 9wU0CmJUTPa/eVupdaS5vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65710164"
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="65710164"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 21:37:14 -0800
X-CSE-ConnectionGUID: zR72d1gSSzaiVQpuN3wQIw==
X-CSE-MsgGUID: aqCKP1gCQOeDfJq+gr+Elg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,317,1754982000"; 
   d="scan'208";a="191055552"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2025 21:37:10 -0800
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
Subject: [PATCH 3/7] perf/x86/intel: Add core PMU support for DMR
Date: Thu, 20 Nov 2025 13:34:27 +0800
Message-Id: <20251120053431.491677-4-dapeng1.mi@linux.intel.com>
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

This patch enables core PMU features for DMR (PatherCove uarch) which
includes PNC specific counter and PEBS constraints, new cache events ID
and OMR registers table.

For detailed information about counter constraints, please refer to
section 16.3 "COUNTER RESTRICTIONS" in the ISE documentation.

ISE: https://www.intel.com/content/www/us/en/content-details/869288/intel-architecture-instruction-set-extensions-programming-reference.html

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 182 +++++++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c   |  27 ++++++
 arch/x86/events/perf_event.h |   2 +
 3 files changed, 211 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5970f7c20101..9f2a93fe23df 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -435,6 +435,62 @@ static struct extra_reg intel_lnc_extra_regs[] __read_mostly = {
 	EVENT_EXTRA_END
 };
 
+static struct event_constraint intel_pnc_event_constraints[] = {
+	FIXED_EVENT_CONSTRAINT(0x00c0, 0),	/* INST_RETIRED.ANY */
+	FIXED_EVENT_CONSTRAINT(0x0100, 0),	/* INST_RETIRED.PREC_DIST */
+	FIXED_EVENT_CONSTRAINT(0x003c, 1),	/* CPU_CLK_UNHALTED.CORE */
+	FIXED_EVENT_CONSTRAINT(0x0300, 2),	/* CPU_CLK_UNHALTED.REF */
+	FIXED_EVENT_CONSTRAINT(0x013c, 2),	/* CPU_CLK_UNHALTED.REF_TSC_P */
+	FIXED_EVENT_CONSTRAINT(0x0400, 3),	/* SLOTS */
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_RETIRING, 0),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BAD_SPEC, 1),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FE_BOUND, 2),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BE_BOUND, 3),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_HEAVY_OPS, 4),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_BR_MISPREDICT, 5),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_FETCH_LAT, 6),
+	METRIC_EVENT_CONSTRAINT(INTEL_TD_METRIC_MEM_BOUND, 7),
+
+	INTEL_EVENT_CONSTRAINT(0x20, 0xf),
+	INTEL_EVENT_CONSTRAINT(0x79, 0xf),
+
+	INTEL_UEVENT_CONSTRAINT(0x0275, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0176, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x04a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x08a4, 0x1),
+	INTEL_UEVENT_CONSTRAINT(0x01cd, 0xfc),
+	INTEL_UEVENT_CONSTRAINT(0x02cd, 0x3),
+
+	INTEL_EVENT_CONSTRAINT(0xd0, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd1, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd4, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xd6, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xdf, 0xf),
+	INTEL_EVENT_CONSTRAINT(0xce, 0x1),
+
+	INTEL_UEVENT_CONSTRAINT(0x01b1, 0x8),
+	INTEL_UEVENT_CONSTRAINT(0x0847, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0446, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0846, 0xf),
+	INTEL_UEVENT_CONSTRAINT(0x0148, 0xf),
+
+	EVENT_CONSTRAINT_END
+};
+
+static struct extra_reg intel_pnc_extra_regs[] __read_mostly = {
+	/* must define OMR_X first, see intel_alt_er() */
+	INTEL_UEVENT_EXTRA_REG(0x012a, MSR_OMR_0, 0x40ffffff0000ffffull, OMR_0),
+	INTEL_UEVENT_EXTRA_REG(0x022a, MSR_OMR_1, 0x40ffffff0000ffffull, OMR_1),
+	INTEL_UEVENT_EXTRA_REG(0x042a, MSR_OMR_2, 0x40ffffff0000ffffull, OMR_2),
+	INTEL_UEVENT_EXTRA_REG(0x082a, MSR_OMR_3, 0x40ffffff0000ffffull, OMR_3),
+	INTEL_UEVENT_PEBS_LDLAT_EXTRA_REG(0x01cd),
+	INTEL_UEVENT_EXTRA_REG(0x02c6, MSR_PEBS_FRONTEND, 0x9, FE),
+	INTEL_UEVENT_EXTRA_REG(0x03c6, MSR_PEBS_FRONTEND, 0x7fff1f, FE),
+	INTEL_UEVENT_EXTRA_REG(0x40ad, MSR_PEBS_FRONTEND, 0xf, FE),
+	INTEL_UEVENT_EXTRA_REG(0x04c2, MSR_PEBS_FRONTEND, 0x8, FE),
+	EVENT_EXTRA_END
+};
+
 EVENT_ATTR_STR(mem-loads,	mem_ld_nhm,	"event=0x0b,umask=0x10,ldlat=3");
 EVENT_ATTR_STR(mem-loads,	mem_ld_snb,	"event=0xcd,umask=0x1,ldlat=3");
 EVENT_ATTR_STR(mem-stores,	mem_st_snb,	"event=0xcd,umask=0x2");
@@ -650,6 +706,102 @@ static __initconst const u64 glc_hw_cache_extra_regs
  },
 };
 
+static __initconst const u64 pnc_hw_cache_event_ids
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
+ [ C(NODE) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = -1,
+		[ C(RESULT_MISS)   ] = -1,
+	},
+ },
+};
+
+static __initconst const u64 pnc_hw_cache_extra_regs
+				[PERF_COUNT_HW_CACHE_MAX]
+				[PERF_COUNT_HW_CACHE_OP_MAX]
+				[PERF_COUNT_HW_CACHE_RESULT_MAX] =
+{
+ [ C(LL  ) ] = {
+	[ C(OP_READ) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4000000000000001,
+		[ C(RESULT_MISS)   ] = 0xFFFFF000000001,
+	},
+	[ C(OP_WRITE) ] = {
+		[ C(RESULT_ACCESS) ] = 0x4000000000000002,
+		[ C(RESULT_MISS)   ] = 0xFFFFF000000002,
+	},
+ },
+};
+
 /*
  * Notes on the events:
  * - data reads do not include code reads (comparable to earlier tables)
@@ -7225,6 +7377,20 @@ static __always_inline void intel_pmu_init_lnc(struct pmu *pmu)
 	hybrid(pmu, extra_regs) = intel_lnc_extra_regs;
 }
 
+static __always_inline void intel_pmu_init_pnc(struct pmu *pmu)
+{
+	intel_pmu_init_glc(pmu);
+	x86_pmu.flags &= ~PMU_FL_HAS_RSP_1;
+	x86_pmu.flags |= PMU_FL_HAS_OMR;
+	memcpy(hybrid_var(pmu, hw_cache_event_ids),
+	       pnc_hw_cache_event_ids, sizeof(hw_cache_event_ids));
+	memcpy(hybrid_var(pmu, hw_cache_extra_regs),
+	       pnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+	hybrid(pmu, event_constraints) = intel_pnc_event_constraints;
+	hybrid(pmu, pebs_constraints) = intel_pnc_pebs_event_constraints;
+	hybrid(pmu, extra_regs) = intel_pnc_extra_regs;
+}
+
 static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 {
 	intel_pmu_init_grt(pmu);
@@ -7897,6 +8063,22 @@ __init int intel_pmu_init(void)
 		intel_pmu_pebs_data_source_skl(true);
 		break;
 
+	case INTEL_DIAMONDRAPIDS_X:
+		intel_pmu_init_pnc(NULL);
+		x86_pmu.pebs_ept = 1;
+		x86_pmu.hw_config = hsw_hw_config;
+		x86_pmu.pebs_latency_data = pnc_latency_data;
+		x86_pmu.get_event_constraints = glc_get_event_constraints;
+		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
+			hsw_format_attr : nhm_format_attr;
+		extra_skl_attr = skl_format_attr;
+		mem_attr = glc_events_attrs;
+		td_attr = glc_td_events_attrs;
+		tsx_attr = glc_tsx_events_attrs;
+		pr_cont("Panthercove events, ");
+		name = "panthercove";
+		break;
+
 	case INTEL_ALDERLAKE:
 	case INTEL_ALDERLAKE_L:
 	case INTEL_RAPTORLAKE:
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 0b62e1f64f33..0db6ffc7007e 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1424,6 +1424,33 @@ struct event_constraint intel_lnc_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_pnc_pebs_event_constraints[] = {
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x100, 0x100000000ULL),	/* INST_RETIRED.PREC_DIST */
+	INTEL_FLAGS_UEVENT_CONSTRAINT(0x0400, 0x800000000ULL),
+
+	INTEL_HYBRID_LDLAT_CONSTRAINT(0x1cd, 0xfc),
+	INTEL_HYBRID_STLAT_CONSTRAINT(0x2cd, 0x3),
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x11d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x12d0, 0xf),	/* MEM_INST_RETIRED.STLB_MISS_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x21d0, 0xf),	/* MEM_INST_RETIRED.LOCK_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x41d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x42d0, 0xf),	/* MEM_INST_RETIRED.SPLIT_STORES */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_LD(0x81d0, 0xf),	/* MEM_INST_RETIRED.ALL_LOADS */
+	INTEL_FLAGS_UEVENT_CONSTRAINT_DATALA_ST(0x82d0, 0xf),	/* MEM_INST_RETIRED.ALL_STORES */
+
+	INTEL_FLAGS_EVENT_CONSTRAINT_DATALA_LD_RANGE(0xd1, 0xd4, 0xf),
+
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd0, 0xf),
+	INTEL_FLAGS_EVENT_CONSTRAINT(0xd6, 0xf),
+
+	/*
+	 * Everything else is handled by PMU_FL_PEBS_ALL, because we
+	 * need the full constraints from the main table.
+	 */
+
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event)
 {
 	struct event_constraint *pebs_constraints = hybrid(event->pmu, pebs_constraints);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index bd501c2a0f73..cbca1888e8f7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1698,6 +1698,8 @@ extern struct event_constraint intel_glc_pebs_event_constraints[];
 
 extern struct event_constraint intel_lnc_pebs_event_constraints[];
 
+extern struct event_constraint intel_pnc_pebs_event_constraints[];
+
 struct event_constraint *intel_pebs_constraints(struct perf_event *event);
 
 void intel_pmu_pebs_add(struct perf_event *event);
-- 
2.34.1

