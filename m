Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6034F37475D;
	Tue, 24 Mar 2026 00:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313261; cv=none; b=dP2J36rJVLt5pUiQO6SYXUYwR7RsnraRTqPQN+X00DZ3zL0JquKpTlfELr5BsDYHjfTBFbcArsbEYgQZHXjHCFcjK5ooSFDKPUsGW0out2boUwmRDMKcUcVlxa0URpWNUl8XTgIS0GuhMv0lA6vrQHYXEYGEY+ew4vubn6fWCZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313261; c=relaxed/simple;
	bh=Bk+t7ou2YxiDymnxt3TXKek3Ry7JWKhHuCyo00BxO5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VqNk/IIim/pvSre0ugFCxZLF0MtRDyjd6SJ3qUwAFt3RxbqOOjNVWGkEgXuJ8SGs97WyR/XHJ2lYy8vOMleDrJFbPIXyaRBVUfcPTR0z+/x6MVQSFdTgG2xTIHX6HQrzfnheoljwyUTnKXQTT6iWsGP33q+HuRg6xAqP18JVRVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwNZ/2iY; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwNZ/2iY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313260; x=1805849260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Bk+t7ou2YxiDymnxt3TXKek3Ry7JWKhHuCyo00BxO5Y=;
  b=iwNZ/2iYp91VFW1LxJowA/vRROwNxotUg1/l+h/mh8hFgGHJELVm0avr
   8+j5BuGgUUtu5k6dETgr4nKnIOh6P7Xq9Uu6+L3TnNHHphHmKpu6ozsGc
   khA5kbvMlPxMDf90YwxvJWmc6/yfdcXUgZEus9eg77dlhgVMD5KWzKQ7R
   RP2KigPSPem2tElXjR8P1Djml4njDUPigMCfPBgXamDKq68NLBTo6MObz
   u487C7ivCuPYk8CGHERRiJzQZDA3aFQHMCEoscEsTpJuXE9TjQrDb1PRJ
   NOS6zU2fz1b5RilwLgrnbrTms7W5ZvTy8XgS5xEuDOE07aGvjULOd0gtv
   w==;
X-CSE-ConnectionGUID: GEWldV6WRkiwEyfRKAjlgQ==
X-CSE-MsgGUID: 5KkMgPTGQYKN7BTHK6kzVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397302"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397302"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:40 -0700
X-CSE-ConnectionGUID: +j4k8gH/TWu+TbIERBrKSg==
X-CSE-MsgGUID: h7wwNzvgQ6ai9OOq7i6Atw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221323008"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:36 -0700
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
Subject: [Patch v7 23/24] perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
Date: Tue, 24 Mar 2026 08:41:17 +0800
Message-Id: <20260324004118.3772171-24-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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

This patch modifies the PEBS handlers to return the count of actually
processed events, thereby activating back-to-back NMI detection and
avoiding the "suspicious NMI" warning.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  6 ++----
 arch/x86/events/intel/ds.c   | 40 ++++++++++++++++++++++++------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e0dd57906bca..9da0a1354045 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3558,9 +3558,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	if (__test_and_clear_bit(GLOBAL_STATUS_BUFFER_OVF_BIT, (unsigned long *)&status)) {
 		u64 pebs_enabled = cpuc->pebs_enabled;
 
-		handled++;
 		x86_pmu_handle_guest_pebs(regs, &data);
-		static_call(x86_pmu_drain_pebs)(regs, &data);
+		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		/*
 		 * PMI throttle may be triggered, which stops the PEBS event.
@@ -3587,8 +3586,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
 				 (unsigned long *)&status)) {
-		handled++;
-		static_call(x86_pmu_drain_pebs)(regs, &data);
+		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4743bdfb4ed4..6e1c516122c0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3035,7 +3035,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3044,7 +3044,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 	int n;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
@@ -3055,22 +3055,24 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
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
+	return 1; /* PMC0 only*/
 }
 
 static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
@@ -3093,7 +3095,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3102,11 +3104,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3122,7 +3125,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
@@ -3186,6 +3189,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
+		events_bitmap |= bit;
 		event = cpuc->events[bit];
 		if (WARN_ON_ONCE(!event))
 			continue;
@@ -3207,6 +3211,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 						setup_pebs_fixed_sample_data);
 		}
 	}
+
+	return hweight64(events_bitmap);
 }
 
 static __always_inline void
@@ -3262,7 +3268,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 static DEFINE_PER_CPU(struct x86_perf_regs, x86_pebs_regs);
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
@@ -3272,10 +3278,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3288,7 +3295,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	if (!iregs)
@@ -3303,6 +3310,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_pebs_adaptive_sample_data);
@@ -3310,9 +3318,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
 					    setup_pebs_adaptive_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
-static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
+static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 				      struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
@@ -3322,13 +3332,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
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
@@ -3367,6 +3378,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		basic = at + sizeof(struct arch_pebs_header);
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_arch_pebs_sample_data);
@@ -3386,6 +3398,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
 					    counts, last,
 					    setup_arch_pebs_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
 static void __init intel_arch_pebs_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 36688d28407f..e6bf786728eb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1014,7 +1014,7 @@ struct x86_pmu {
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

