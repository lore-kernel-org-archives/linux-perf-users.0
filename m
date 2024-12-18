Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B721BEF60;
	Wed, 18 Dec 2024 15:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534975; cv=none; b=K2hLGVsVZXbmX3l6NQHDpvLYvbchCcHDGfjsMpnrUtyB0R57mPiqA3N9KQ8VvzljU+GH1rsRrv5Zc1O6MdQ6MJWnjuSVB95GSfaiTDtEjGFHtajc39HWeffjjed5wWhK/Tvgt9MEG6Tt9sATzp3/n7sM/VKtf42/L9RALDKDPGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534975; c=relaxed/simple;
	bh=Ccaarkbt3n0iQ39p/TERhKRRRhbpcy7LQmjMcPRhw98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oIG0dlsMfFATtu0g8y4f0XyKAGlHUke39N8GZ1DYcH3endTbQwIqxPRMId7TEU0Z+2xeTLMN5L/Nxf00tZwI0r1ths+obqzm1gt3K0UUEzJnDF6tkKzjgBFfEFqWmir9GrZ/a4zZen50HRL/dafUIC4T34Ne3d45rE/Jd2EuJK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T4UxwNPo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T4UxwNPo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734534972; x=1766070972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ccaarkbt3n0iQ39p/TERhKRRRhbpcy7LQmjMcPRhw98=;
  b=T4UxwNPoju4WyI0CIsaHz7aC+PnIhjQ2CjKb6Ime8s3examBKoSCq9F8
   wN82zGNl91ojJltfG4TvmuGvpPc9rAr4u3psnhjyfvjGJ17p62ojozZPu
   Q2Iu3GIRmdZyQE95+DnaShL6+86sPSgJs8Ziw5pIHJbqrsVVSU7HOBb6E
   rEXVAdLXv9RwMvfxEV5eVK/z0Mdzeq97KPr1KmrRzeDifC+HZ23AOup5S
   TSiulXysDtHnlTYvdQ9gxlZB0wj+7qG/yAvyCWyi5yIOhw6f3Dcxxk/BV
   IdnFZ62mfKKqRnoezzgZv7YadKS0JPUenRTzDVjL5jm8FTUbyHYnyxZw8
   g==;
X-CSE-ConnectionGUID: A8JPcg12R2me/qjWjiEvMg==
X-CSE-MsgGUID: ljYixpo9Sk+3kxZWZWf+VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="35047715"
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="35047715"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2024 07:16:08 -0800
X-CSE-ConnectionGUID: +JtEXtczSIOK8OsIc5hhZA==
X-CSE-MsgGUID: KfAlQ2TLQFiiB9Gkrq5Q2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,244,1728975600"; 
   d="scan'208";a="97687795"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa006.fm.intel.com with ESMTP; 18 Dec 2024 07:16:09 -0800
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: ak@linux.intel.com,
	eranian@google.com,
	dapeng1.mi@linux.intel.com,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V6 3/3] perf/x86/intel: Support PEBS counters snapshotting
Date: Wed, 18 Dec 2024 07:16:43 -0800
Message-Id: <20241218151643.1031659-3-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20241218151643.1031659-1-kan.liang@linux.intel.com>
References: <20241218151643.1031659-1-kan.liang@linux.intel.com>
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

The current Linux perf sample read feature intends to read the counters
of other member events when the leader event is overflowing. But the
current read is in the NMI handler, which may has a small gap from
overflow. Using the counters snapshotting feature for the sample read.

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
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V5:
- Drop the extension for the x86_pmu_update(). Only extend
  intel_pmu_update_topdown_event()
- Add dedicated intel_perf_event_pmc_to_count() to update the
  event->count from a PEBS record
- Always drain the PEBS buffer before updating the corresponding
  event->count and update an example in the comments.

 arch/x86/events/intel/core.c       |  95 ++++++++++++++++----
 arch/x86/events/intel/ds.c         | 137 ++++++++++++++++++++++++++---
 arch/x86/events/perf_event.h       |  15 +++-
 arch/x86/events/perf_event_flags.h |   2 +-
 arch/x86/include/asm/perf_event.h  |  15 ++++
 5 files changed, 235 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 2e1e26846050..403eea444b71 100644
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
@@ -2718,13 +2718,18 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
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
+	}
 
 	for_each_set_bit(idx, cpuc->active_mask, metric_end + 1) {
 		if (!is_topdown_idx(idx))
@@ -2767,13 +2772,14 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end)
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
@@ -2785,14 +2791,15 @@ static void intel_pmu_read_topdown_event(struct perf_event *event)
 		return;
 
 	perf_pmu_disable(event->pmu);
-	static_call(intel_pmu_update_topdown_event)(event);
+	static_call(intel_pmu_update_topdown_event)(event, NULL);
 	perf_pmu_enable(event->pmu);
 }
 
 static void intel_pmu_read_event(struct perf_event *event)
 {
-	if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
-		intel_pmu_auto_reload_read(event);
+	if ((event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD) ||
+	    is_pebs_counter_event(event))
+		intel_pmu_pebs_read(event);
 	else if (is_topdown_count(event))
 		intel_pmu_read_topdown_event(event);
 	else
@@ -2925,7 +2932,7 @@ static int intel_pmu_set_period(struct perf_event *event)
 static u64 intel_pmu_update(struct perf_event *event)
 {
 	if (unlikely(is_topdown_count(event)))
-		return static_call(intel_pmu_update_topdown_event)(event);
+		return static_call(intel_pmu_update_topdown_event)(event, NULL);
 
 	return x86_perf_event_update(event);
 }
@@ -3091,7 +3098,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_PERF_METRICS_OVF_BIT, (unsigned long *)&status)) {
 		handled++;
-		static_call(intel_pmu_update_topdown_event)(NULL);
+		static_call(intel_pmu_update_topdown_event)(NULL, NULL);
 	}
 
 	/*
@@ -3109,6 +3116,27 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
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
+		if (is_pebs_counter_event(event))
+			x86_pmu.drain_pebs(regs, &data);
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;
 
@@ -4056,6 +4084,23 @@ static int intel_pmu_hw_config(struct perf_event *event)
 		event->hw.flags |= PERF_X86_EVENT_PEBS_VIA_PT;
 	}
 
+	if ((event->attr.sample_type & PERF_SAMPLE_READ) &&
+	    (x86_pmu.intel_cap.pebs_format >= 6)) {
+		struct perf_event *leader = event->group_leader;
+		bool slots_leader = is_slots_event(leader);
+
+		if (slots_leader)
+			leader = list_next_entry(leader, sibling_list);
+
+		if (leader->attr.precise_ip) {
+			event->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+			if (slots_leader) {
+				leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+				event->group_leader->hw.flags |= PERF_X86_EVENT_PEBS_CNTR;
+			}
+		}
+	}
+
 	if ((event->attr.type == PERF_TYPE_HARDWARE) ||
 	    (event->attr.type == PERF_TYPE_HW_CACHE))
 		return 0;
@@ -4159,6 +4204,24 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	return 0;
 }
 
+static int intel_pmu_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *event;
+	int ret = x86_schedule_events(cpuc, n, assign);
+
+	if (ret)
+		return ret;
+
+	if (cpuc->is_fake)
+		return ret;
+
+	event = cpuc->event_list[n - 1];
+	if (event && (event->group_leader->hw.flags & PERF_X86_EVENT_PEBS_CNTR))
+		intel_pmu_pebs_update_cfg(cpuc, n, assign);
+
+	return 0;
+}
+
 /*
  * Currently, the only caller of this function is the atomic_switch_perf_msrs().
  * The host perf context helps to prepare the values of the real hardware for
@@ -5292,7 +5355,7 @@ static __initconst const struct x86_pmu intel_pmu = {
 	.set_period		= intel_pmu_set_period,
 	.update			= intel_pmu_update,
 	.hw_config		= intel_pmu_hw_config,
-	.schedule_events	= x86_schedule_events,
+	.schedule_events	= intel_pmu_schedule_events,
 	.eventsel		= MSR_ARCH_PERFMON_EVENTSEL0,
 	.perfctr		= MSR_ARCH_PERFMON_PERFCTR0,
 	.fixedctr		= MSR_ARCH_PERFMON_FIXED_CTR0,
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e1198328..11bd97c6e582 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1308,10 +1308,63 @@ static void adaptive_pebs_record_size_update(void)
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
+			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_CNTR_SHIFT) & PEBS_DATACFG_CNTR_MASK)
+			      * sizeof(u64);
+			sz += hweight64((pebs_data_cfg >> PEBS_DATACFG_FIX_SHIFT) & PEBS_DATACFG_FIX_MASK)
+			      * sizeof(u64);
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
+	if (idx >= INTEL_PMC_IDX_FIXED) {
+		*pebs_data_cfg |= ((1ULL << (idx - INTEL_PMC_IDX_FIXED)) & PEBS_DATACFG_FIX_MASK)
+				  << PEBS_DATACFG_FIX_SHIFT;
+	} else {
+		*pebs_data_cfg |= ((1ULL << idx) & PEBS_DATACFG_CNTR_MASK)
+				  << PEBS_DATACFG_CNTR_SHIFT;
+	}
+}
+
+void intel_pmu_pebs_update_cfg(struct cpu_hw_events *cpuc, int n, int *assign)
+{
+	struct perf_event *leader, *event;
+	u64 pebs_data_cfg = 0;
+	int i = n - 1;
+
+	leader = cpuc->event_list[i]->group_leader;
+	for (; i >= 0; i--) {
+		event = cpuc->event_list[i];
+		if (!is_pebs_counter_event(event))
+			continue;
+		if (leader != event->group_leader)
+			break;
+		__intel_pmu_pebs_update_cfg(event, assign[i], &pebs_data_cfg);
+	}
+
+	if (pebs_data_cfg & ~cpuc->pebs_data_cfg)
+		cpuc->pebs_data_cfg |= pebs_data_cfg | PEBS_UPDATE_DS_SW;
+}
+
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR |			     \
 				PERF_SAMPLE_WEIGHT_TYPE |		     \
@@ -1914,6 +1967,24 @@ static void adaptive_pebs_save_regs(struct pt_regs *regs,
 #endif
 }
 
+static void intel_perf_event_pmc_to_count(struct perf_event *event, u64 pmc)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 prev_pmc = local64_read(&hwc->prev_count);
+	int shift = 64 - x86_pmu.cntval_bits;
+	u64 delta;
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
@@ -2049,6 +2120,41 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 	}
 
+	if (format_group & (PEBS_DATACFG_CNTR | PEBS_DATACFG_METRICS)) {
+		struct pebs_cntr_header *cntr = next_record;
+		int bit;
+
+		next_record += sizeof(struct pebs_cntr_header);
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->cntr, INTEL_PMC_MAX_GENERIC) {
+			intel_perf_event_pmc_to_count(cpuc->events[bit], *(u64 *)next_record);
+			next_record += sizeof(u64);
+		}
+
+		for_each_set_bit(bit, (unsigned long *)&cntr->fixed, INTEL_PMC_MAX_FIXED) {
+			/* The slots event will be handled with perf_metric later */
+			if ((cntr->metrics == INTEL_CNTR_METRICS) &&
+			    (INTEL_PMC_IDX_FIXED_SLOTS == bit + INTEL_PMC_IDX_FIXED)) {
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
+				   (event->group_leader, (u64 *)next_record);
+			next_record += 2 * sizeof(u64);
+		}
+		data->sample_flags |= PERF_SAMPLE_READ;
+	}
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2094,10 +2200,8 @@ get_next_pebs_record_by_bit(void *base, void *top, int bit)
 	return NULL;
 }
 
-void intel_pmu_auto_reload_read(struct perf_event *event)
+void intel_pmu_pebs_read(struct perf_event *event)
 {
-	WARN_ON(!(event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD));
-
 	perf_pmu_disable(event->pmu);
 	intel_pmu_drain_pebs_buffer();
 	perf_pmu_enable(event->pmu);
@@ -2211,13 +2315,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		/*
-		 * Now, auto-reload is only enabled in fixed period mode.
-		 * The reload value is always hwc->sample_period.
-		 * May need to change it, if auto-reload is enabled in
-		 * freq mode later.
-		 */
-		intel_pmu_save_and_restart_reload(event, count);
+		if ((is_pebs_counter_event(event))) {
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
@@ -2552,6 +2664,9 @@ void __init intel_ds_init(void)
 			break;
 
 		case 6:
+			if (x86_pmu.intel_cap.pebs_baseline)
+				x86_pmu.large_pebs_flags |= PERF_SAMPLE_READ;
+			fallthrough;
 		case 5:
 			x86_pmu.pebs_ept = 1;
 			fallthrough;
@@ -2576,7 +2691,7 @@ void __init intel_ds_init(void)
 					  PERF_SAMPLE_REGS_USER |
 					  PERF_SAMPLE_REGS_INTR);
 			}
-			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
+			pr_cont("PEBS fmt%d%c%s, ", format, pebs_type, pebs_qual);
 
 			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 82c6f45ce975..8545c779b61e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -115,6 +115,11 @@ static inline bool is_branch_counters_group(struct perf_event *event)
 	return event->group_leader->hw.flags & PERF_X86_EVENT_BRANCH_COUNTERS;
 }
 
+static inline bool is_pebs_counter_event(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_PEBS_CNTR;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
@@ -1147,6 +1152,12 @@ extern u64 __read_mostly hw_cache_extra_regs
 
 u64 x86_perf_event_update(struct perf_event *event);
 
+static inline u64 intel_pmu_topdown_event_update(struct perf_event *event, u64 *val)
+{
+	return x86_perf_event_update(event);
+}
+DECLARE_STATIC_CALL(intel_pmu_update_topdown_event, intel_pmu_topdown_event_update);
+
 static inline unsigned int x86_pmu_config_addr(int index)
 {
 	return x86_pmu.eventsel + (x86_pmu.addr_offset ?
@@ -1642,7 +1653,9 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
-void intel_pmu_auto_reload_read(struct perf_event *event);
+void intel_pmu_pebs_update_cfg(struct cpu_hw_events *cpuc, int n, int *assign);
+
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
index cd8023d5ea46..4e28ee0f2f3e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -140,6 +140,12 @@
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
@@ -467,6 +473,15 @@ struct pebs_xmm {
 
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

