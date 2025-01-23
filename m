Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2441D54D6;
	Thu, 23 Jan 2025 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613253; cv=none; b=JMbYpzEtN9X4XkwSIkMsFGRllskY1/9+BVdZywRLPDAcjUn3FD+L8OyDd7za2RPqiLdsyz6+zSGHhdZoWnL/9Buo/mdceGngekUbWL6v/k2DzJKuzVLJ8fSPXZB1L3cvG9FTA2WzzSS4+VhCYF8jOJfMHAasCOLWzhgQtSAbpm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613253; c=relaxed/simple;
	bh=uKbxzypOc6jQBbD7toLrmn0LamajvZKSwLA8cDKtZf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X/iogv/mhNwxyYMlrs91cLuNP9kQ0u/Quf1X2Z73mCp0/R/Y19l1QzYY+P4CpPHqjB+KGxTHdqGF5y8s+TbMGULzS8YfdzN3rzVBMBic9bOeIpdtr+yV0e/eGq1g3AddBJUQikGBoV12gwhpSy81M/T8uqAQBqwHBvlB5aTL9i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cNWRqnH2; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cNWRqnH2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613252; x=1769149252;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uKbxzypOc6jQBbD7toLrmn0LamajvZKSwLA8cDKtZf8=;
  b=cNWRqnH2akuVILkFgF4bQd4JSp5Ikc5pObz8VRy6sA5hqevODWJ1KKR8
   mWd4I+ju8PHD2Q0rJVKPK9NbL83ipqN0PJavbsnKUNPJmzSM5t8UB61ju
   /wOnSIjVIrZ45ECydB7eOsHCp7ksljzqe4knRnHkPjhuJxOQEnQd+yKtB
   avsqdAaoK0pI55QENdMDuqY16Tc1wk9gqTkAcf1qHkkLSsTi0DJcJ5pEU
   PPCYUvgNniPtxgeS2KiSSQftkHlENAcPB7KF36aKzz076yy1VHsPdRm0z
   gfHU11EBvptYPGEAJ6U6BTSATgm3j33wKJ61hb8qEe+O9Lw00gxPvlsHq
   A==;
X-CSE-ConnectionGUID: sLujh3OMQNCgqKNJxURwVQ==
X-CSE-MsgGUID: 5XNmVSo8SzqIjg5oFtBNrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513143"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513143"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:20:52 -0800
X-CSE-ConnectionGUID: pJJMc7MQSg6i6k8/excbQw==
X-CSE-MsgGUID: Q7iRz6NORB+250nVf2aksA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334641"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:20:48 -0800
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [PATCH 12/20] perf/x86/intel: Setup PEBS data configuration and enable legacy groups
Date: Thu, 23 Jan 2025 14:07:13 +0000
Message-Id: <20250123140721.2496639-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Different with legacy PEBS, arch-PEBS provides per-counter PEBS data
configuration by programing MSR IA32_PMC_GPx/FXx_CFG_C MSRs.

This patch obtains PEBS data configuration from event attribute and then
writes the PEBS data configuration to MSR IA32_PMC_GPx/FXx_CFG_C and
enable corresponding PEBS groups.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c     | 127 +++++++++++++++++++++++++++++++
 arch/x86/events/intel/ds.c       |  17 +++++
 arch/x86/events/perf_event.h     |  15 ++++
 arch/x86/include/asm/intel_ds.h  |   7 ++
 arch/x86/include/asm/msr-index.h |  10 +++
 5 files changed, 176 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0f1be36113fa..cb88ae60de8e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2558,6 +2558,39 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 	cpuc->fixed_ctrl_val &= ~mask;
 }
 
+static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u32 msr = idx < INTEL_PMC_IDX_FIXED ?
+		  x86_pmu_cfg_c_addr(idx, true) :
+		  x86_pmu_cfg_c_addr(idx - INTEL_PMC_IDX_FIXED, false);
+
+	cpuc->cfg_c_val[idx] = ext;
+	wrmsrl(msr, ext);
+}
+
+static void intel_pmu_disable_event_ext(struct perf_event *event)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	/*
+	 * Only clear CFG_C MSR for PEBS counter group events,
+	 * it avoids the HW counter's value to be added into
+	 * other PEBS records incorrectly after PEBS counter
+	 * group events are disabled.
+	 *
+	 * For other events, it's unnecessary to clear CFG_C MSRs
+	 * since CFG_C doesn't take effect if counter is in
+	 * disabled state. That helps to reduce the WRMSR overhead
+	 * in context switches.
+	 */
+	if (!is_pebs_counter_event_group(event))
+		return;
+
+	__intel_pmu_update_event_ext(event->hw.idx, 0);
+}
+
 static void intel_pmu_disable_event(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -2566,9 +2599,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
 	switch (idx) {
 	case 0 ... INTEL_PMC_IDX_FIXED - 1:
 		intel_clear_masks(event, idx);
+		intel_pmu_disable_event_ext(event);
 		x86_pmu_disable_event(event);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
+		intel_pmu_disable_event_ext(event);
+		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_disable_fixed(event);
 		break;
@@ -2888,6 +2924,66 @@ static void intel_pmu_enable_fixed(struct perf_event *event)
 	cpuc->fixed_ctrl_val |= bits;
 }
 
+static void intel_pmu_enable_event_ext(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	union arch_pebs_index cached, index;
+	struct arch_pebs_cap cap;
+	u64 ext = 0;
+
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	cap = hybrid(cpuc->pmu, arch_pebs_cap);
+
+	if (event->attr.precise_ip) {
+		u64 pebs_data_cfg = intel_get_arch_pebs_data_config(event);
+
+		ext |= ARCH_PEBS_EN;
+		ext |= (-hwc->sample_period) & ARCH_PEBS_RELOAD;
+
+		if (pebs_data_cfg && cap.caps) {
+			if (pebs_data_cfg & PEBS_DATACFG_MEMINFO)
+				ext |= ARCH_PEBS_AUX & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_GP)
+				ext |= ARCH_PEBS_GPR & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
+				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
+				ext |= ARCH_PEBS_LBR & cap.caps;
+		}
+
+		if (cpuc->n_pebs == cpuc->n_large_pebs)
+			index.split.thresh = ARCH_PEBS_THRESH_MUL;
+		else
+			index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
+
+		rdmsrl(MSR_IA32_PEBS_INDEX, cached.full);
+		if (index.split.thresh != cached.split.thresh || !cached.split.en) {
+			if (cached.split.thresh == ARCH_PEBS_THRESH_MUL &&
+			    cached.split.wr > 0) {
+				/*
+				 * Large PEBS was enabled.
+				 * Drain PEBS buffer before applying the single PEBS.
+				 */
+				intel_pmu_drain_pebs_buffer();
+			} else {
+				index.split.wr = 0;
+				index.split.full = 0;
+				index.split.en = 1;
+				wrmsrl(MSR_IA32_PEBS_INDEX, index.full);
+			}
+		}
+	}
+
+	if (cpuc->cfg_c_val[hwc->idx] != ext)
+		__intel_pmu_update_event_ext(hwc->idx, ext);
+}
+
 static void intel_pmu_enable_event(struct perf_event *event)
 {
 	u64 enable_mask = ARCH_PERFMON_EVENTSEL_ENABLE;
@@ -2902,9 +2998,12 @@ static void intel_pmu_enable_event(struct perf_event *event)
 		if (branch_sample_counters(event))
 			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
+		intel_pmu_enable_event_ext(event);
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
+		intel_pmu_enable_event_ext(event);
+		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
 		break;
@@ -4984,6 +5083,29 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
+static inline void __intel_update_pmu_caps(struct pmu *pmu)
+{
+	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
+
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
+		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+}
+
+static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
+{
+	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
+
+	x86_pmu.large_pebs_flags |= PERF_SAMPLE_TIME;
+	if (caps & ARCH_PEBS_LBR)
+		x86_pmu.large_pebs_flags |= PERF_SAMPLE_BRANCH_STACK;
+
+	if (!(caps & ARCH_PEBS_AUX))
+		x86_pmu.large_pebs_flags &= ~PERF_SAMPLE_DATA_SRC;
+	if (!(caps & ARCH_PEBS_GPR))
+		x86_pmu.large_pebs_flags &=
+			~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+}
+
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int sub_bitmaps, eax, ebx, ecx, edx;
@@ -5012,6 +5134,9 @@ static void update_pmu_cap(struct pmu *pmu)
 			    &eax, &ebx, &ecx, &edx);
 		hybrid(pmu, arch_pebs_cap).counters = ((u64)ecx << 32) | eax;
 		hybrid(pmu, arch_pebs_cap).pdists = ((u64)edx << 32) | ebx;
+
+		__intel_update_pmu_caps(pmu);
+		__intel_update_large_pebs_flags(pmu);
 	} else {
 		WARN_ON(x86_pmu.arch_pebs == 1);
 		x86_pmu.arch_pebs = 0;
@@ -5178,6 +5303,8 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
 
+	__intel_update_pmu_caps(cpuc->pmu);
+
 	if (!cpuc->shared_regs)
 		return;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a573ce0e576a..5d8c5c8d5e24 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1492,6 +1492,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
 	}
 }
 
+u64 intel_get_arch_pebs_data_config(struct perf_event *event)
+{
+	u64 pebs_data_cfg = 0;
+
+	if (WARN_ON(event->hw.idx < 0 || event->hw.idx >= X86_PMC_IDX_MAX))
+		return 0;
+
+	pebs_data_cfg |= pebs_update_adaptive_cfg(event);
+
+	return pebs_data_cfg;
+}
+
 void intel_pmu_pebs_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2927,6 +2939,11 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 	index.split.wr = 0;
 	index.split.full = 0;
+	index.split.en = 1;
+	if (cpuc->n_pebs == cpuc->n_large_pebs)
+		index.split.thresh = ARCH_PEBS_THRESH_MUL;
+	else
+		index.split.thresh = ARCH_PEBS_THRESH_SINGLE;
 	wrmsrl(MSR_IA32_PEBS_INDEX, index.full);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a3c4374fe7f3..3acb03a5c214 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -286,6 +286,9 @@ struct cpu_hw_events {
 	u64			fixed_ctrl_val;
 	u64			active_fixed_ctrl_val;
 
+	/* Cached CFG_C values */
+	u64			cfg_c_val[X86_PMC_IDX_MAX];
+
 	/*
 	 * Intel LBR bits
 	 */
@@ -1194,6 +1197,14 @@ static inline unsigned int x86_pmu_fixed_ctr_addr(int index)
 				   x86_pmu.addr_offset(index, false) : index);
 }
 
+static inline unsigned int x86_pmu_cfg_c_addr(int index, bool gp)
+{
+	u32 base = gp ? MSR_IA32_PMC_V6_GP0_CFG_C : MSR_IA32_PMC_V6_FX0_CFG_C;
+
+	return base + (x86_pmu.addr_offset ? x86_pmu.addr_offset(index, false) :
+					     index * MSR_IA32_PMC_V6_STEP);
+}
+
 static inline int x86_pmu_rdpmc_index(int index)
 {
 	return x86_pmu.rdpmc_index ? x86_pmu.rdpmc_index(index) : index;
@@ -1615,6 +1626,8 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
+void intel_pmu_drain_pebs_buffer(void);
+
 u64 grt_latency_data(struct perf_event *event, u64 status);
 
 u64 cmt_latency_data(struct perf_event *event, u64 status);
@@ -1748,6 +1761,8 @@ void intel_pmu_pebs_data_source_cmt(void);
 
 void intel_pmu_pebs_data_source_lnl(void);
 
+u64 intel_get_arch_pebs_data_config(struct perf_event *event);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 023c2883f9f3..7bb80c993bef 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -7,6 +7,13 @@
 #define PEBS_BUFFER_SHIFT	4
 #define PEBS_BUFFER_SIZE	(PAGE_SIZE << PEBS_BUFFER_SHIFT)
 
+/*
+ * The largest PEBS record could consume a page, ensure
+ * a record at least can be written after triggering PMI.
+ */
+#define ARCH_PEBS_THRESH_MUL	((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_BUFFER_SHIFT)
+#define ARCH_PEBS_THRESH_SINGLE	1
+
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 59d3a050985e..a3fad7e910eb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -318,6 +318,14 @@
 #define ARCH_PEBS_OFFSET_MASK		0x7fffff
 #define ARCH_PEBS_INDEX_WR_SHIFT	4
 
+#define ARCH_PEBS_RELOAD		0xffffffff
+#define ARCH_PEBS_LBR_SHIFT		40
+#define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
+#define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_GPR			BIT_ULL(61)
+#define ARCH_PEBS_AUX			BIT_ULL(62)
+#define ARCH_PEBS_EN			BIT_ULL(63)
+
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
 #define RTIT_CTL_CYCLEACC		BIT(1)
@@ -597,7 +605,9 @@
 /* V6 PMON MSR range */
 #define MSR_IA32_PMC_V6_GP0_CTR		0x1900
 #define MSR_IA32_PMC_V6_GP0_CFG_A	0x1901
+#define MSR_IA32_PMC_V6_GP0_CFG_C	0x1903
 #define MSR_IA32_PMC_V6_FX0_CTR		0x1980
+#define MSR_IA32_PMC_V6_FX0_CFG_C	0x1983
 #define MSR_IA32_PMC_V6_STEP		4
 
 /* KeyID partitioning between MKTME and TDX */
-- 
2.40.1

