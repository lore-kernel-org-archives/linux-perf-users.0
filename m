Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A20439913;
	Tue, 21 Jul 2026 06:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615682; cv=none; b=nAVsKkUPcgXPgIlCbHm1Nr4jICpn3TTvG/WcfpMKvZBxEBWaVj8hJ64wERT8Lsspr64d3Cd/3O24nuzfGFcH7y/B4gIe7THQankafmzpHbg5IoJjwM7cew2FR52SjRcadvqx/VgzD0CUgYcKXfSNDwmfA5Zakm5bicuzH1XCohw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615682; c=relaxed/simple;
	bh=8TW4qwTvwYEa4MxsNbLzjjnPUu+MFlCf8o4ZYkG1tCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfr9PKLaXQugfsMMSLPrijxx4MyXPXlIy3q44LECi6maXpsFGa6RqGnj6DinmdCluiNcEe1xQh12fmk/k6cxu4MvT7vjch049WVSsxoZEgwaOLsuyJU4DrvUuZX2ngiDkAPa0DI3H8u4axjpLF35WFUWiWgPZ0t8X3RPlvPmff0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB/g25cg; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB/g25cg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615677; x=1816151677;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8TW4qwTvwYEa4MxsNbLzjjnPUu+MFlCf8o4ZYkG1tCs=;
  b=EB/g25cgNt0VcFKEAFeurfJe5srVKTRo1NrdDucO15WUQ0In+RtSoqpF
   MZXeE+g3/kqS0cWwftBfOq5HvTP17VqFhvFWUxQOxMsoxt1z7rkiF6v59
   j1HvSpLoFiRAuDkUP3pmaoDFIkX0A/qxyc2nqMzTsHL8uCj7hYBypeTCm
   DpC7ke0KGGr8o3esXmUTlcc5wJM/OojGqhmzbEk5loz1QT3QzqU5BWeWK
   9CwhxoadePG939uaDlbVLz5bj0uQdRHgiNpWrK+wKpn5aNYyqPGuksVVM
   7+IY+2S6opvBmUWcu48c1u5oc821kx88SnjEMXvkxLtS7gnmaTDZQvNAT
   w==;
X-CSE-ConnectionGUID: yt9WWC8USXuhd61thUqbJA==
X-CSE-MsgGUID: yEjKz1IcQ4uCpgCcTw69Bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565587"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565587"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:34:36 -0700
X-CSE-ConnectionGUID: 9Z6ZThrHTKCSpZJvL6kTkQ==
X-CSE-MsgGUID: XLxfkoqyTveeFnVCzmF0vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656267"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:34:30 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v10 22/23] perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
Date: Tue, 21 Jul 2026 14:25:05 +0800
Message-Id: <20260721062506.3745816-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When two or more identical PEBS events with the same sampling period are
programmed on a mix of PDIST and non-PDIST counters, multiple
back-to-back NMIs can be triggered.

The Linux PMI handler processes the first NMI and clears the
GLOBAL_STATUS MSR. If a second NMI is triggered immediately after
the first, it is recognized as a "suspicious NMI" because no bits are set
in the GLOBAL_STATUS MSR (cleared by the first NMI).

This issue does not lead to PEBS data corruption or data loss, but it
does result in an annoying warning message.

The current NMI handler supports back-to-back NMI detection, but it
requires the PMI handler to return the count of actually processed events,
which the PEBS handler does not currently do.

Thus, modify the PEBS handlers to return the count of actually processed
events, thereby activating back-to-back NMI detection and avoiding the
"suspicious NMI" warning.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       |  2 +-
 arch/x86/events/intel/core.c | 31 +++++++++++++++++---------
 arch/x86/events/intel/ds.c   | 43 ++++++++++++++++++++++++------------
 arch/x86/events/perf_event.h |  2 +-
 4 files changed, 51 insertions(+), 27 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 11799acd8c54..ef9b8df2e1f7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -93,7 +93,7 @@ DEFINE_STATIC_CALL_NULL(x86_pmu_stop_scheduling,   *x86_pmu.stop_scheduling);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_sched_task,    *x86_pmu.sched_task);
 
-DEFINE_STATIC_CALL_NULL(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
+DEFINE_STATIC_CALL_RET0(x86_pmu_drain_pebs,   *x86_pmu.drain_pebs);
 DEFINE_STATIC_CALL_NULL(x86_pmu_pebs_aliases, *x86_pmu.pebs_aliases);
 
 DEFINE_STATIC_CALL_NULL(x86_pmu_filter, *x86_pmu.filter);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5d1f00f3aa47..2d2bbadbfc9f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3784,8 +3784,8 @@ static void intel_pmu_reset(void)
  *
  * The contents and other behavior of the guest event do not matter.
  */
-static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
-				      struct perf_sample_data *data)
+static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
+				     struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	u64 guest_pebs_idxs = cpuc->pebs_enabled & ~cpuc->intel_ctrl_host_mask;
@@ -3793,11 +3793,11 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 	int bit;
 
 	if (!unlikely(perf_guest_state()))
-		return;
+		return 0;
 
 	if (!x86_pmu.pebs_ept || !x86_pmu.pebs_active ||
 	    !guest_pebs_idxs)
-		return;
+		return 0;
 
 	for_each_set_bit(bit, (unsigned long *)&guest_pebs_idxs, X86_PMC_IDX_MAX) {
 		event = cpuc->events[bit];
@@ -3807,9 +3807,14 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 		perf_sample_data_init(data, 0, event->hw.last_period);
 		perf_event_overflow(event, data, regs);
 
-		/* Inject one fake event is enough. */
-		break;
+		/*
+		 * Inject one fake event is enough.
+		 * Returning 1 to inform PMI is handled.
+		 */
+		return 1;
 	}
+
+	return 0;
 }
 
 static int handle_pmi_common(struct pt_regs *regs, u64 status)
@@ -3858,9 +3863,11 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
-		handled++;
-		x86_pmu_handle_guest_pebs(regs, &data);
-		static_call(x86_pmu_drain_pebs)(regs, &data);
+		handled += x86_pmu_handle_guest_pebs(regs, &data);
+		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
+		/* Ensure no "suspicious NMI" warning for empty PEBS buffer. */
+		if (!handled)
+			handled++;
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3887,8 +3894,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
 				 (unsigned long *)&status)) {
-		handled++;
-		static_call(x86_pmu_drain_pebs)(regs, &data);
+		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
+		/* Ensure no "suspicious NMI" warning for empty PEBS buffer. */
+		if (!handled)
+			handled++;
 
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ff6125ec8458..d830a3fdd964 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3014,7 +3014,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3023,7 +3023,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 	int n;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
@@ -3034,22 +3034,25 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 	ds->pebs_index = ds->pebs_buffer_base;
 
 	if (!test_bit(0, cpuc->active_mask))
-		return;
+		return 0;
 
 	WARN_ON_ONCE(!event);
 
 	if (!event->attr.precise_ip)
-		return;
+		return 0;
 
 	n = top - at;
 	if (n <= 0) {
 		if (event->hw.flags & PERF_X86_EVENT_AUTO_RELOAD)
 			intel_pmu_save_and_restart_reload(event, 0);
-		return;
+		return 0;
 	}
 
 	__intel_pmu_pebs_events(event, iregs, data, at, top, 0, n,
 				setup_pebs_fixed_sample_data);
+
+	/* PMC0 only */
+	return 1;
 }
 
 static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
@@ -3072,7 +3075,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3081,11 +3084,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	short error[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	int max_pebs_events = intel_pmu_max_num_pebs(NULL);
+	u64 events_bitmap = 0;
 	int bit, i, size;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	base = (struct pebs_record_nhm *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_nhm *)(unsigned long)ds->pebs_index;
@@ -3101,7 +3105,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
@@ -3165,6 +3169,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
+		events_bitmap |= BIT_ULL(bit);
 		event = cpuc->events[bit];
 		if (WARN_ON_ONCE(!event))
 			continue;
@@ -3186,6 +3191,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 						setup_pebs_fixed_sample_data);
 		}
 	}
+
+	return hweight64(events_bitmap);
 }
 
 static __always_inline void
@@ -3239,7 +3246,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
@@ -3249,10 +3256,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	struct pt_regs *regs = &perf_regs->regs;
 	struct pebs_basic *basic;
 	void *base, *at, *top;
+	u64 events_bitmap = 0;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
@@ -3265,7 +3273,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	if (!iregs)
@@ -3280,6 +3288,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_pebs_adaptive_sample_data);
@@ -3287,10 +3296,12 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
 					    setup_pebs_adaptive_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
-static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
-				      struct perf_sample_data *data)
+static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
+				     struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
@@ -3299,13 +3310,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
 	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
+	u64 events_bitmap = 0;
 	u64 mask;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
 	if (unlikely(!index.wr)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
-		return;
+		return 0;
 	}
 
 	base = cpuc->pebs_vaddr;
@@ -3344,6 +3356,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		basic = at + sizeof(struct arch_pebs_header);
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_arch_pebs_sample_data);
@@ -3363,6 +3376,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
 					    counts, last,
 					    setup_arch_pebs_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
 static void __init intel_arch_pebs_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eca7fab86b9b..bb34aab53d05 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1145,7 +1145,7 @@ struct x86_pmu {
 	int		pebs_record_size;
 	int		pebs_buffer_size;
 	u64		pebs_events_mask;
-	void		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
+	int		(*drain_pebs)(struct pt_regs *regs, struct perf_sample_data *data);
 	struct event_constraint *pebs_constraints;
 	void		(*pebs_aliases)(struct perf_event *event);
 	u64		(*pebs_latency_data)(struct perf_event *event, u64 status);
-- 
2.34.1

