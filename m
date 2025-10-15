Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0745E314D37;
	Wed, 15 Oct 2025 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510810; cv=none; b=Vijn9zXr7pCSss+UB63m3hK++yPvCn6o8C12FsLg6qsoIKxroLshOeDI9DQQWui6btetPk16XUi5XASUV5n9GvofLVGVqyY/Juz5QWKqOb69VhMpAAqpLKitGJIDek+FgYuZkzCODZXVfj2T39I4RSPibEI9n96l2WaccA9dfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510810; c=relaxed/simple;
	bh=dQrBLK5Nv49o6+M2SdgrRGc+3ZviuhXqgX1zUsuBO3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HXrxBG3AyjXBtEIE1whAQpipqn0pz7+kdXyr5c1ngAbTKlQkWl72kfik10ahTiMRDyg0J4bWfi5kroNE52AX73lMHC09TTNaYV9J8TpuUhAvPFzXcPlVw4yxZfr4XyfdsSn+KBWRamES6EfykAO0k0g4yPrptMz/NTJQ2xR8qmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIcp4COv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIcp4COv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510808; x=1792046808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dQrBLK5Nv49o6+M2SdgrRGc+3ZviuhXqgX1zUsuBO3s=;
  b=dIcp4COvIXtBe6t9NivLhqaORONsFLUtudaDIt7qp5jp4LmSUpo2t0jD
   qBoC3WmL5SkeS7rmETlrZRs+incX3PgwQiqbsqWq+zsH4R20cdjixAAOI
   gtu4H0HGQvNNxnfkF3zCm0oGwg1YPP9hgO0yQGulWV70F77/Zjwy7niO4
   gf9yeW11LPjCymcy9XK5BnIuNcE9V7ca76Vuqt84EyVRctiVvqCpOl24R
   7is5dCACfwIqZF5bRlQ5qAi9d5s3t7z5Hu7HmtdJOCbMXospXtDQGXEtO
   SKbF3GJ8jkIdM+wnDsXlaeZgLR2tpDas4XrRJC5cKCMYbeuzApS/Qfn4z
   Q==;
X-CSE-ConnectionGUID: LLjc1AUPR1GEQBvSbqsl5A==
X-CSE-MsgGUID: urvQOnG+Ro2XU81eOKhhFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242524"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242524"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:48 -0700
X-CSE-ConnectionGUID: zd1qUlgJQH+CnO6CQ1DBgA==
X-CSE-MsgGUID: Gj7pR/EoQ/u3UKfd78zSBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029980"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:44 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v8 11/12] perf/x86/intel: Setup PEBS data configuration and enable legacy groups
Date: Wed, 15 Oct 2025 14:44:21 +0800
Message-Id: <20251015064422.47437-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
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

Please notice this patch only enables XMM SIMD regs sampling for
arch-PEBS, the other SIMD regs (OPMASK/YMM/ZMM) sampling on arch-PEBS
would be supported after PMI based SIMD regs (OPMASK/YMM/ZMM) sampling
is supported.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c     | 136 ++++++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c       |  17 ++++
 arch/x86/events/perf_event.h     |   4 +
 arch/x86/include/asm/intel_ds.h  |   7 ++
 arch/x86/include/asm/msr-index.h |   8 ++
 5 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 818c197585c6..c8cd490aa539 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2563,6 +2563,45 @@ static void intel_pmu_disable_fixed(struct perf_event *event)
 	cpuc->fixed_ctrl_val &= ~mask;
 }
 
+static inline void __intel_pmu_update_event_ext(int idx, u64 ext)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u32 msr;
+
+	if (idx < INTEL_PMC_IDX_FIXED) {
+		msr = MSR_IA32_PMC_V6_GP0_CFG_C +
+		      x86_pmu.addr_offset(idx, false);
+	} else {
+		msr = MSR_IA32_PMC_V6_FX0_CFG_C +
+		      x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false);
+	}
+
+	cpuc->cfg_c_val[idx] = ext;
+	wrmsrq(msr, ext);
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
@@ -2571,9 +2610,12 @@ static void intel_pmu_disable_event(struct perf_event *event)
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
@@ -2940,6 +2982,66 @@ static void intel_pmu_enable_acr(struct perf_event *event)
 
 DEFINE_STATIC_CALL_NULL(intel_pmu_enable_acr_event, intel_pmu_enable_acr);
 
+static void intel_pmu_enable_event_ext(struct perf_event *event)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct hw_perf_event *hwc = &event->hw;
+	union arch_pebs_index old, new;
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
+		if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD)
+			ext |= (-hwc->sample_period) & ARCH_PEBS_RELOAD;
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
+			new.thresh = ARCH_PEBS_THRESH_MULTI;
+		else
+			new.thresh = ARCH_PEBS_THRESH_SINGLE;
+
+		rdmsrq(MSR_IA32_PEBS_INDEX, old.whole);
+		if (new.thresh != old.thresh || !old.en) {
+			if (old.thresh == ARCH_PEBS_THRESH_MULTI && old.wr > 0) {
+				/*
+				 * Large PEBS was enabled.
+				 * Drain PEBS buffer before applying the single PEBS.
+				 */
+				intel_pmu_drain_pebs_buffer();
+			} else {
+				new.wr = 0;
+				new.full = 0;
+				new.en = 1;
+				wrmsrq(MSR_IA32_PEBS_INDEX, new.whole);
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
@@ -2955,10 +3057,12 @@ static void intel_pmu_enable_event(struct perf_event *event)
 			enable_mask |= ARCH_PERFMON_EVENTSEL_BR_CNTR;
 		intel_set_masks(event, idx);
 		static_call_cond(intel_pmu_enable_acr_event)(event);
+		intel_pmu_enable_event_ext(event);
 		__x86_pmu_enable_event(hwc, enable_mask);
 		break;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS - 1:
 		static_call_cond(intel_pmu_enable_acr_event)(event);
+		intel_pmu_enable_event_ext(event);
 		fallthrough;
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		intel_pmu_enable_fixed(event);
@@ -5301,6 +5405,30 @@ static inline bool intel_pmu_broken_perf_cap(void)
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
+	if (!(caps & ARCH_PEBS_GPR)) {
+		x86_pmu.large_pebs_flags &=
+			~(PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER);
+	}
+}
+
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -5348,8 +5476,12 @@ static void update_pmu_cap(struct pmu *pmu)
 		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
 		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
 
-		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
+		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask)) {
 			x86_pmu.arch_pebs = 0;
+		} else {
+			__intel_update_pmu_caps(pmu);
+			__intel_update_large_pebs_flags(pmu);
+		}
 	} else {
 		WARN_ON(x86_pmu.arch_pebs == 1);
 		x86_pmu.arch_pebs = 0;
@@ -5513,6 +5645,8 @@ static void intel_pmu_cpu_starting(int cpu)
 		}
 	}
 
+	__intel_update_pmu_caps(cpuc->pmu);
+
 	if (!cpuc->shared_regs)
 		return;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 759eff6aa83e..becdc9a53d10 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1528,6 +1528,18 @@ pebs_update_state(bool needed_cb, struct cpu_hw_events *cpuc,
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
@@ -2969,6 +2981,11 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 	index.wr = 0;
 	index.full = 0;
+	index.en = 1;
+	if (cpuc->n_pebs == cpuc->n_large_pebs)
+		index.thresh = ARCH_PEBS_THRESH_MULTI;
+	else
+		index.thresh = ARCH_PEBS_THRESH_SINGLE;
 	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
 	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 13f411bca6bc..3161ec0a3416 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -304,6 +304,8 @@ struct cpu_hw_events {
 	/* Intel ACR configuration */
 	u64			acr_cfg_b[X86_PMC_IDX_MAX];
 	u64			acr_cfg_c[X86_PMC_IDX_MAX];
+	/* Cached CFG_C values */
+	u64			cfg_c_val[X86_PMC_IDX_MAX];
 
 	/*
 	 * Intel LBR bits
@@ -1782,6 +1784,8 @@ void intel_pmu_pebs_data_source_cmt(void);
 
 void intel_pmu_pebs_data_source_lnl(void);
 
+u64 intel_get_arch_pebs_data_config(struct perf_event *event);
+
 int intel_pmu_setup_lbr_filter(struct perf_event *event);
 
 void intel_pt_interrupt(void);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 023c2883f9f3..695f87efbeb8 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -7,6 +7,13 @@
 #define PEBS_BUFFER_SHIFT	4
 #define PEBS_BUFFER_SIZE	(PAGE_SIZE << PEBS_BUFFER_SHIFT)
 
+/*
+ * The largest PEBS record could consume a page, ensure
+ * a record at least can be written after triggering PMI.
+ */
+#define ARCH_PEBS_THRESH_MULTI	((PEBS_BUFFER_SIZE - PAGE_SIZE) >> PEBS_BUFFER_SHIFT)
+#define ARCH_PEBS_THRESH_SINGLE	1
+
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8
 #define MAX_PEBS_EVENTS		32
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index fc7a4e7c718d..f1ef9ac38bfb 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -333,6 +333,14 @@
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
-- 
2.34.1

