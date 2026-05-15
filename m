Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8003812EE;
	Fri, 15 May 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778825830; cv=none; b=XCyWo0GiHemaLzK/SPWwnl/xBc4IwwfbIzwYGFdpMzeLU6nnwMFq5iij9ygT6Arl/0NYak5kkeawtpzqsha0pAolbjlqiwoL+5KLxCPHElcH2RYJYo2iisLFxif5HO+ASM0KP1pGp9ZhxT0zkocrwjDUjd4tmgxmtE+dOXBC9W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778825830; c=relaxed/simple;
	bh=+MdzKGRYsndd85tupfJh7Q5PU8IGkMbaNw1sd6kM8Ko=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SEr+8m6ewP6dDspFQbADEZrzpRhnOALneEH1NGM+ME8czqxAlWBMgYP1lWiFQsvY2UdV9KhADPrCsBrq7G6ShBA5hRGbzxCLYg4WXSUbbVQsihsgOcHzmW5+xCMmC7/VBCZwgEOpsgnSwG+EPRetBuj+uHRxUImEM4LaJUIgx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NNF5wXRI; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NNF5wXRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778825829; x=1810361829;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+MdzKGRYsndd85tupfJh7Q5PU8IGkMbaNw1sd6kM8Ko=;
  b=NNF5wXRIdKwl9XG9NzHYI34fK0S1qq7dYhAIYO2cORjNMF0/sGgC5oXf
   Ph4qq0b2Lw4dBiZIdJiWcfSmXqWHorrkZ1ZVKIIRY7PAgxL7+4XgUMjp5
   CQN1vcBrFZzlkRGR0pBf4ENtIEd7MuyLtcseEGQyGDq2sDg7n1j82cwXM
   XC1VOv9K6xIykw2HEwETgEVIJ7L6Y8N1apSwB/gGSzdcdtkbTf5FNI0e+
   pa7+0tkcEY8MmEgnmvoMZTM8tk3LRszFkXBRIJmv93/o5Lu5K8ETD0C7q
   uLlG892U6fBY005lUCsdqiTKyYpIggZeMrJ/73KgIzypcsCILpJHEA1UT
   Q==;
X-CSE-ConnectionGUID: w2wkXpM0Ro+LV5hB3BJY7Q==
X-CSE-MsgGUID: cbnl/13eTw2d2OSyqKms7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="79635951"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="79635951"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2026 23:17:09 -0700
X-CSE-ConnectionGUID: 2KpZV4WnTMiatjB9/5pAXw==
X-CSE-MsgGUID: W+XArBmUSQe798dZRBD5Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="235968477"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 14 May 2026 23:17:05 -0700
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
Subject: [PATCH 08/11] perf/x86/intel: Update event constraints for PTL
Date: Fri, 15 May 2026 14:11:40 +0800
Message-Id: <20260515061143.338553-9-dapeng1.mi@linux.intel.com>
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

Update perf hard-coded event constraints for Pantherlake according to
the latest PTL perfmon events (V1.05).

PTL has almost same perf event list as LNL except some PEBS event
constraints of E-core (exactly same on P-core). Define
intel_dkt_pebs_event_constraints[] to reflect the PTL E-core specific
PEBS event constraints.

PTL perfmon events:
https://github.com/intel/perfmon/blob/main/PTL/events/pantherlake_cougarcove_core.json
https://github.com/intel/perfmon/blob/main/PTL/events/pantherlake_darkmont_core.json

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c | 20 ++++++++++++++++----
 arch/x86/events/intel/ds.c   |  7 +++++++
 arch/x86/events/perf_event.h |  2 ++
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index dc5ab18888ea..b281402c3753 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7755,6 +7755,13 @@ static __always_inline void intel_pmu_init_skt(struct pmu *pmu)
 	static_call_update(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 }
 
+/* Hybrid client variant. */
+static __always_inline void intel_pmu_init_dkt_hybrid(struct pmu *pmu)
+{
+	intel_pmu_init_skt(pmu);
+	hybrid(pmu, pebs_constraints) = intel_dkt_pebs_event_constraints;
+}
+
 static __always_inline void intel_pmu_init_arw(struct pmu *pmu)
 {
 	intel_pmu_init_grt(pmu);
@@ -8553,6 +8560,9 @@ __init int intel_pmu_init(void)
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		intel_pmu_init_lnc(&pmu->pmu);
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_dkt_hybrid(&pmu->pmu);
 
 		goto lnl_common;
 
@@ -8567,6 +8577,9 @@ __init int intel_pmu_init(void)
 		intel_pmu_init_lnc(&pmu->pmu);
 		memcpy(hybrid_var(&pmu->pmu, hw_cache_extra_regs),
 		       arl_lnc_hw_cache_extra_regs, sizeof(hw_cache_extra_regs));
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
 
 		goto lnl_common;
 
@@ -8579,6 +8592,9 @@ __init int intel_pmu_init(void)
 		/* Initialize big core specific PerfMon capabilities.*/
 		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
 		intel_pmu_init_lnc(&pmu->pmu);
+		/* Initialize Atom core specific PerfMon capabilities.*/
+		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
+		intel_pmu_init_skt(&pmu->pmu);
 
 	lnl_common:
 
@@ -8592,10 +8608,6 @@ __init int intel_pmu_init(void)
 		extra_attr = boot_cpu_has(X86_FEATURE_RTM) ?
 			mtl_hybrid_extra_attr_rtm : mtl_hybrid_extra_attr;
 
-		/* Initialize Atom core specific PerfMon capabilities.*/
-		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_ATOM_IDX];
-		intel_pmu_init_skt(&pmu->pmu);
-
 		intel_pmu_pebs_data_source_lnl();
 		break;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ce23b50f449a..5159adabb9a2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1303,6 +1303,13 @@ struct event_constraint intel_cmt_pebs_event_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
+struct event_constraint intel_dkt_pebs_event_constraints[] = {
+	/* Allow all events as PEBS with no flags */
+	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
+	INTEL_HYBRID_LAT_CONSTRAINT(0x6d0, 0xff),
+	EVENT_CONSTRAINT_END
+};
+
 struct event_constraint intel_arw_pebs_event_constraints[] = {
 	/* Allow all events as PEBS with no flags */
 	INTEL_HYBRID_LAT_CONSTRAINT(0x5d0, 0xff),
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad99183f4d8..f9ea07d60930 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1704,6 +1704,8 @@ extern struct event_constraint intel_grt_pebs_event_constraints[];
 
 extern struct event_constraint intel_cmt_pebs_event_constraints[];
 
+extern struct event_constraint intel_dkt_pebs_event_constraints[];
+
 extern struct event_constraint intel_arw_pebs_event_constraints[];
 
 extern struct event_constraint intel_nehalem_pebs_event_constraints[];
-- 
2.34.1

