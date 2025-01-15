Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7E91D6DA9;
	Wed, 15 Jan 2025 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966575; cv=none; b=u1oU+B8cpWifHE/6Fy9nlFn3dxNtbu6BTKWiO5g4OIfrFnWD2jJ1tUuIz8OKBGF+TOJLXwpR6DgDtvbQHfevQEqj8+Ump/R9ZMis7tsvKlKrIaqPS9aAYCRQjp7GpfKlJXqkZIXVgvUy0UOuvRz0jebMBQoWFEatjQaI0f8JSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966575; c=relaxed/simple;
	bh=5Mf1npsijRvbJ5pSLppLxNr0wB0kKPNQ2XqNoOsImsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S7W4XuNMIWaS83xn3S7rb1YpiRXyu/UXkjPYiPnUX14jjA/dq0E4A8BSjuUk8Caaq9sIJiyfCMKgzP6RpTGxguuUAko8NB/pzUBm6TIiRC2GEVyThwg+MTICiWUXEOPMV3ICgkLlimpiSGJlY8mH2ylbIBUa544Gp1qgFR2YrY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwwnoGds; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwwnoGds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736966574; x=1768502574;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Mf1npsijRvbJ5pSLppLxNr0wB0kKPNQ2XqNoOsImsk=;
  b=GwwnoGds1wyFuBb7xa21e8rQkMxAgVq7/NR6cyo7At/KtOIH3iLldb4X
   20/NLk+ICr8jVgVaj82sC2p9s2f5NsblLaF0qbPiH8YqXcJw9F/y+DJEJ
   j5WydOFjRwXCu2iF0cMVEModziz1TmVGwxsRsRzQp52RpuTWp0NBVBqh7
   hBDAoRaPqIWDUoNDOAXIKdWzgD9o2DislU7SSih/Yyqnh3RbQZ1yXGnop
   ePMT+ZhuPzmIlhnw+gzy9x8dLshs4YbEvWoLZzYJVb0ekPxIV6xwfKklD
   t2pOeVxh+ubzcsHiFU5slL+2GFE+ysU2NruEw2laefCOvOMspayprhWAb
   g==;
X-CSE-ConnectionGUID: ji8MankeRImZJ/c3JQzB2w==
X-CSE-MsgGUID: UWfuJxkjQ9eWm123Su/g/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="48733358"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="48733358"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 10:42:50 -0800
X-CSE-ConnectionGUID: /L172vZDSZWoiGNsXnR7Cw==
X-CSE-MsgGUID: k4B/QLr7QPOv+yYsChI6YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="105278513"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa006.jf.intel.com with ESMTP; 15 Jan 2025 10:42:49 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V9 3/3] perf/x86/intel: Support PEBS counters snapshotting
Date: Wed, 15 Jan 2025 10:43:18 -0800
Message-Id: <20250115184318.2854459-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250115184318.2854459-1-kan.liang@linux.intel.com>
References: <20250115184318.2854459-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The counters snapshotting is a new adaptive PEBS extension, which can
capture programmable counters, fixed-function counters, and performance
metrics in a PEBS record. The feature is available in the PEBS format
V6.

The target counters can be configured in the new fields of MSR_PEBS_CFG.
Then the PEBS HW will generate the bit mask of counters (Counters Group
Header) followed by the content of all the requested counters into a
PEBS record.

The current Linux perf sample read feature can read all events in the
group when any event in the group is overflowed. But the rdpmc in the
NMI/overflow handler has a small gap from overflow. Also, there is some
overhead for each rdpmc read. The counters snapshotting feature can be
used as an accurate and low-overhead replacement.

Extend intel_update_topdown_event() to accept the value from PEBS
records.

Add a new PEBS_CNTR flag to indicate a sample read group that utilizes
the counters snapshotting feature. When the group is scheduled, the
PEBS configure can be updated accordingly.

To prevent the case that a PEBS record value might be in the past
relative to what is already in the event, perf always stops the PMU and
drains the PEBS buffer before updating the corresponding event->count.

Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V8:
- Move the configuration update from schedule_events() to
  x86_pmu_enable()
- Fix an issue caused by running one sample read group and
  multiple PEBS groups at the same time. The counter snapshot fields
  should be ignored for the non-sample-read group.
- Shorten several long lines as suggested

 arch/x86/events/core.c             |  13 ++-
 arch/x86/events/intel/core.c       |  71 +++++++++---
 arch/x86/events/intel/ds.c         | 177 +++++++++++++++++++++++++++--
 arch/x86/events/perf_event.h       |  18 ++-
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/perf_event.h  |  15 +++
 6 files changed, 268 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f218ac0d445..79a4aad5a0a3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -94,6 +94,8 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
 
+DEFINE_STATIC_CALL_NULL(x86_pmu_late_config, x86_pmu_late_config);
+
 /*
  * This one is magic, it will get called even when PMU init fails (because
  * there is no PMU), in which case it should simply return NULL.
@@ -1329,7 +1331,16 @@ static void x86_pmu_enable(struct pmu *pmu)
 		}
 
 		/*
-		 * step2: reprogram moved events into new counters
+		 * step2:
+		 * The late config (after counters are scheduled)
+		 * is required for some cases, e.g., PEBS counters
+		 * snapshotting. Because an accurate counter index
+		 * is needed.
+		 */
+		static_call_cond(x86_pmu_late_config)();
+
+		/*
+		 * step3: reprogram moved events into new counters
 		 */
 		for (i = 0; i < cpuc->n_events; i++) {
 			event = cpuc->event_list[i];
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bce423ad3fad..ac532519344a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2710,7 +2710,7 @@ static void update_saved_topdown_regs(struct perf_event *event, u64 slots,
  * modify by a NMI. PMU has to be disabled before calling this function.
  */
 
-static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
+static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, u64 *val)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *other;
@@ -2718,13 +2718,24 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	bool reset = true;
 	int idx;
 
-	/* read Fixed counter 3 */
-	rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
-	if (!slots)
-		return 0;
+	if (!val) {
+		/* read Fixed counter 3 */
+		rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+		if (!slots)
+			return 0;
 
-	/* read PERF_METRICS */
-	rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+		/* read PERF_METRICS */
+		rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+	} else {
+		slots = val[0];
+		metrics = val[1];
+		/*
+		 * Don't reset the PERF_METRICS and Fixed counter 3
+		 * for each PEBS record read. Utilize the RDPMC metrics
+		 * clear mode.
+		 */
+		reset = false;
+	}
 
 	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
@@ -2767,13 +2778,14 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
 	return slots;
 }
 
-static u64 icl_update_topdown_event(struct perf_event *event)
+static u64 icl_update_topdown_event(struct perf_event *event, u64 *val)
 {
 	return intel_update_topdown_event(event, INTEL_PMC_IDX_METRIC_BASE +
-						 x86_pmu.num_topdown_events - 1);
+						 x86_pmu.num_topdown_events - 1,
+					  val);
 }
 
-DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, x86_perf_event_update);
+DEFINE_STATIC_CALL(intel_pmu_update_topdown_event, intel_pmu_topdown_event_update);
 
 static void intel_pmu_read_topdown_event(struct perf_event *event)
 {
@@ -2787,15 +2799,16 @@ static void intel_pmu_read_topdown_event(struct perf_event *event)
 
 	if (pmu_enabled)
 		perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
+	static_call(intel_pmu_update_topdown_event)(event, NULL);
 	if (pmu_enabled)
 		perf_pmu_enable(event->pmu);
 }
 
 static void intel_pmu_read_event(struct perf_event *event)
 {
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-		intel_pmu_auto_reload_read(event);
+	if ((event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) ||
+	    is_pebs_counter_event_group(event))
+		intel_pmu_pebs_read(event);
 	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
@@ -2931,7 +2944,7 @@ static int intel_pmu_set_period(struct perf_event *event)
 static u64 intel_pmu_update(struct perf_event *event)
 {
 	if (unlikely(is_topdown_count(event)))
-		return static_call(intel_pmu_update_topdown_event)(event);
+		return static_call(intel_pmu_update_topdown_event)(event, NULL);
 
 	return x86_perf_event_update(event);
 }
@@ -3097,7 +3110,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		static_call(intel_pmu_update_topdown_event)(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
 	/*
@@ -3115,6 +3128,27 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
 
+		/*
+		 * There may be unprocessed PEBS records in the PEBS buffer,
+		 * which still stores the previous values.
+		 * Process those records first before handling the latest value.
+		 * For example,
+		 * A is a regular counter
+		 * B is a PEBS event which reads A
+		 * C is a PEBS event
+		 *
+		 * The following can happen:
+		 * B-assist			A=1
+		 * C				A=2
+		 * B-assist			A=3
+		 * A-overflow-PMI		A=4
+		 * C-assist-PMI (PEBS buffer)	A=5
+		 *
+		 * The PEBS buffer has to be drained before handling the A-PMI
+		 */
+		if (is_pebs_counter_event_group(event))
+			x86_pmu.drain_pebs(regs, &data);
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;
 
@@ -4062,6 +4096,13 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
+	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
+	    (x86_pmu.intel_cap.pebs_format >= 6) &&
+	    x86_pmu.intel_cap.pebs_baseline &&
+	    is_sampling_event(event) &&
+	    event->attr.precise_ip)
+		event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 81b6ec8e824e..10ce80230ad3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1294,6 +1294,19 @@ static inline void pebs_update_threshold(struct cpu_hw_events *cpuc)
 	ds->pebs_interrupt_threshold = threshold;
 }
 
+#define PEBS_DATACFG_CNTRS(x)						\
+	((x >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
+
+#define PEBS_DATACFG_CNTR_BIT(x)					\
+	(((1ULL << x) & PEBS_DATACFG_CNTR_MASK) << PEBS_DATACFG_CNTR_SHIFT)
+
+#define PEBS_DATACFG_FIX(x)						\
+	((x >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
+
+#define PEBS_DATACFG_FIX_BIT(x)						\
+	(((1ULL << (x - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)	\
+	 << PEBS_DATACFG_FIX_SHIFT)
+
 static void adaptive_pebs_record_size_update(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1308,10 +1321,58 @@ static void adaptive_pebs_record_size_update(void)
 		sz += sizeof(struct pebs_xmm);
 	if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 		sz += x86_pmu.lbr_nr * sizeof(struct lbr_entry);
+	if (pebs_data_cfg & (PEBS_DATACFG_METRICS | PEBS_DATACFG_CNTR)) {
+		sz += sizeof(struct pebs_cntr_header);
+
+		/* Metrics base and Metrics Data */
+		if (pebs_data_cfg & PEBS_DATACFG_METRICS)
+			sz += 2 * sizeof(u64);
+
+		if (pebs_data_cfg & PEBS_DATACFG_CNTR) {
+			sz += (hweight64(PEBS_DATACFG_CNTRS(pebs_data_cfg)) +
+			       hweight64(PEBS_DATACFG_FIX(pebs_data_cfg))) *
+			      sizeof(u64);
+		}
+	}
 
 	cpuc->pebs_record_size = sz;
 }
 
+static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
+					int idx, u64 *pebs_data_cfg)
+{
+	if (is_metric_event(event)) {
+		*pebs_data_cfg |= PEBS_DATACFG_METRICS;
+		return;
+	}
+
+	*pebs_data_cfg |= PEBS_DATACFG_CNTR;
+
+	if (idx >= INTEL_PMC_IDX_FIXED)
+		*pebs_data_cfg |= PEBS_DATACFG_FIX_BIT(idx);
+	else
+		*pebs_data_cfg |= PEBS_DATACFG_CNTR_BIT(idx);
+}
+
+
+static void intel_pmu_late_config(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	u64 pebs_data_cfg = 0;
+	int i;
+
+	for (i = 0; i < cpuc->n_events; i++) {
+		event = cpuc->event_list[i];
+		if (!is_pebs_counter_event_group(event))
+			continue;
+		__intel_pmu_pebs_update_cfg(event, cpuc->assign[i], &pebs_data_cfg);
+	}
+
+	if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
+		cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
+}
+
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR |			     \
 				PERF_SAMPLE_WEIGHT_TYPE |		     \
@@ -1914,6 +1975,34 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 #endif
 }
 
+static void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
+{
+	int shift = 64 - x86_pmu.cntval_bits;
+	struct hw_perf_event *hwc;
+	u64 delta, prev_pmc;
+
+	/*
+	 * The PEBS record doesn't shrink on pmu::del().
+	 * See pebs_update_state().
+	 * Ignore the non-exist event.
+	 */
+	if (!event)
+		return;
+
+	hwc = &event->hw;
+	prev_pmc = local64_read(&hwc->prev_count);
+
+	/* Only update the count when the PMU is disabled */
+	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
+	local64_set(&hwc->prev_count, pmc);
+
+	delta = (pmc << shift) - (prev_pmc << shift);
+	delta >>= shift;
+
+	local64_add(delta, &event->count);
+	local64_sub(delta, &hwc->period_left);
+}
+
 #define PEBS_LATENCY_MASK			0xffff
 
 /*
@@ -2049,6 +2138,61 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
+	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
+		struct pebs_cntr_header *cntr = next_record;
+		int bit;
+
+		next_record += sizeof(struct pebs_cntr_header);
+
+		/*
+		 * The PEBS_DATA_CFG is a global register, which is the
+		 * superset configuration for all PEBS events.
+		 * For the PEBS record of non-sample-read group, ignore
+		 * the counter snapshot fields.
+		 */
+		if (!is_pebs_counter_event_group(event)) {
+			unsigned int nr;
+
+			nr = bitmap_weight((unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) +
+			     bitmap_weight((unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED);
+			if (cntr->metrics == INTEL_CNTR_METRICS)
+				nr += 2;
+			next_record += nr * sizeof(u64);
+			goto end_cntr;
+		}
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
+			intel_perf_event_pmc_to_count(cpuc->events[bit], *(u64 *)next_record);
+			next_record += sizeof(u64);
+		}
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED) {
+			/* The slots event will be handled with perf_metric later */
+			if ((cntr->metrics == INTEL_CNTR_METRICS) &&
+			    (bit + INTEL_PMC_IDX_FIXED == INTEL_PMC_IDX_FIXED_SLOTS)) {
+				next_record += sizeof(u64);
+				continue;
+			}
+			intel_perf_event_pmc_to_count(cpuc->events[bit + INTEL_PMC_IDX_FIXED],
+						      *(u64 *)next_record);
+			next_record += sizeof(u64);
+		}
+
+		/* HW will reload the value right after the overflow. */
+		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
+			local64_set(&event->hw.prev_count, (u64)-event->hw.sample_period);
+
+		if (cntr->metrics == INTEL_CNTR_METRICS) {
+			static_call(intel_pmu_update_topdown_event)
+				   (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS],
+				    (u64 *)next_record);
+			next_record += 2 * sizeof(u64);
+		}
+		data->sample_flags |= PERF_SAMPLE_READ;
+	}
+
+end_cntr:
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2094,11 +2238,10 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	return NULL;
 }
 
-void intel_pmu_auto_reload_read(struct perf_event *event)
+void intel_pmu_pebs_read(struct perf_event *event)
 {
 	int pmu_enabled = this_cpu_read(cpu_hw_events.enabled);
 
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
 	if (pmu_enabled)
 		perf_pmu_disable(event->pmu);
 	intel_pmu_drain_pebs_buffer();
@@ -2214,13 +2357,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
+		if ((is_pebs_counter_event_group(event))) {
+			/*
+			 * The value of each sample has been updated when setup
+			 * the corresponding sample data.
+			 */
+			perf_event_update_userpage(event);
+		} else {
+			/*
+			 * Now, auto-reload is only enabled in fixed period mode.
+			 * The reload value is always hwc->sample_period.
+			 * May need to change it, if auto-reload is enabled in
+			 * freq mode later.
+			 */
+			intel_pmu_save_and_restart_reload(event, count);
+		}
 	} else
 		intel_pmu_save_and_restart(event);
 }
@@ -2555,6 +2706,12 @@ void __init intel_ds_init(void)
 			break;
 
 		case 6:
+			if (x86_pmu.intel_cap.pebs_baseline) {
+				x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
+				static_call_update(x86_pmu_late_config,
+						   &intel_pmu_late_config);
+			}
+			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
@@ -2579,7 +2736,7 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_USER |
 					  PERF_SAMPLE_REGS_INTR);
 			}
-			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+			pr_cont("PEBS fmt%d%c%s, ", format, pebs_type, pebs_qual);
 
 			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771545a6..c9c6ba49a926 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,6 +115,11 @@ static inline bool is_branch_counters_group(struct perf_event *event)
 	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
 }
 
+static inline bool is_pebs_counter_event_group(struct perf_event *event)
+{
+	return event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -1148,6 +1153,17 @@ extern u64 __read_mostly hw_cache_extra_regs
 
 u64 x86_perf_event_update(struct perf_event *event);
 
+static inline u64 intel_pmu_topdown_event_update(struct perf_event *event, u64 *val)
+{
+	return x86_perf_event_update(event);
+}
+DECLARE_STATIC_CALL(intel_pmu_update_topdown_event, intel_pmu_topdown_event_update);
+
+static inline void x86_pmu_late_config(void)
+{
+}
+DECLARE_STATIC_CALL(x86_pmu_late_config, x86_pmu_late_config);
+
 static inline unsigned int x86_pmu_config_addr(int index)
 {
 	return x86_pmu.eventsel + (x86_pmu.addr_offset ?
@@ -1643,7 +1659,7 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_pebs_read(struct perf_event *event);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 6c977c19f2cd..1d9e385649b5 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -9,7 +9,7 @@ PERF_ARCH(PEBS_LD_HSW,		0x00008) /* haswell style datala, load */
 PERF_ARCH(PEBS_NA_HSW,		0x00010) /* haswell style datala, unknown */
 PERF_ARCH(EXCL,			0x00020) /* HT exclusivity on counter */
 PERF_ARCH(DYNAMIC,		0x00040) /* dynamic alloc'd constraint */
-			/*	0x00080	*/
+PERF_ARCH(PEBS_CNTR,		0x00080) /* PEBS counters snapshot */
 PERF_ARCH(EXCL_ACCT,		0x00100) /* accounted EXCL event */
 PERF_ARCH(AUTO_RELOAD,		0x00200) /* use PEBS auto-reload */
 PERF_ARCH(LARGE_PEBS,		0x00400) /* use large PEBS */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 1ac79f361645..adaeb8ca3a8a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -141,6 +141,12 @@
 #define PEBS_DATACFG_XMMS	BIT_ULL(2)
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_LBR_SHIFT	24
+#define PEBS_DATACFG_CNTR	BIT_ULL(4)
+#define PEBS_DATACFG_CNTR_SHIFT	32
+#define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
+#define PEBS_DATACFG_FIX_SHIFT	48
+#define PEBS_DATACFG_FIX_MASK	GENMASK_ULL(7, 0)
+#define PEBS_DATACFG_METRICS	BIT_ULL(5)
 
 /* Steal the highest bit of pebs_data_cfg for SW usage */
 #define PEBS_UPDATE_DS_SW	BIT_ULL(63)
@@ -471,6 +477,15 @@ struct pebs_xmm {
 
 #define IBS_CPUID_FEATURES		0x8000001b
 
+struct pebs_cntr_header {
+	u32 cntr;
+	u32 fixed;
+	u32 metrics;
+	u32 reserved;
+};
+
+#define INTEL_CNTR_METRICS		0x3
+
 /*
  * Same bit mask as for IBS cpuid feature flags (Fn8000_001B_EAX), but
  * bit 0 is used to indicate the existence of IBS.
-- 
2.38.1

