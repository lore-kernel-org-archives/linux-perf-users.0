Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869103B3C03;
	Fri, 29 May 2026 08:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041871; cv=none; b=nqIQritwfbntAe8Ozw+jydUx48LkSsWVXTvXoo5WYgpYcmHX6eHgSfD57b8Ym9x3Pw9JClyGHOAx63yaAQGZkgqqHRYRUUNxKD2+/HnhJB0oGr5Husn5ULoVj4UXr52yxgSL3uTcPn3gnHyEANx26Kms8s3lvVAIM4K7BBAIrwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041871; c=relaxed/simple;
	bh=7oSm4pPQG6wRIGgpGdgeEKhIyxfI1BVG9xwOosyn5q4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LAElZDT2GjDJKQetzau6xXb0mkinQocMYqjFu8wxG0bDsoHmC/TybsGgNKQ20egHqvM5u+vFx4YorzgEypl/0xE8waoQOCWPTv5T87CO9WhMVlQmep68wyiy584HhqDCGjYwJZELtWUj/iLw8dE49tujJL9HTdhHAibYF6gIRSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjxmvhxX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjxmvhxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041869; x=1811577869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7oSm4pPQG6wRIGgpGdgeEKhIyxfI1BVG9xwOosyn5q4=;
  b=XjxmvhxXC6+cy2GcQpMSyfdkTqsxjyBx9ZaVzX4W9yWAJSvTP5AM4gyu
   YMHHPk+Slz2dMZIGXMVtigmVe6grdo8GlvNUbS0tDoN4PwehWhNI3FeXk
   7eLkIlFkvcgYhVy7RIhD2mV5jHtPhRSE3CDQsc0xSGBR4PbL0pudtrdB8
   7jFZprlxnzpBMwJc4FPXxhx4wDrNYaEBOBe68qoYrtIhqXaHqj+b1yf6t
   2YxACdxNdE5qtzSeJtf5JXD3L6JK28Yi0gMqxF+VT+ki+/SaHvx/ywi4h
   cNGqiDN0gTKy2fg5Y8OSHgwnozgMhLvyK48jP39q5+vg3+aUVnvICBuux
   w==;
X-CSE-ConnectionGUID: MZO96pfzSdKWF7Vz3AmDTA==
X-CSE-MsgGUID: 4okE6tRrTeuo4KlLtp1D7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342246"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342246"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:29 -0700
X-CSE-ConnectionGUID: MSmAlwP/QDeYrfZ472/fHQ==
X-CSE-MsgGUID: 4DASNmacS9y3eBPvU0ymCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802605"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:04:24 -0700
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
Subject: [Patch v8 22/23] perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
Date: Fri, 29 May 2026 15:56:44 +0800
Message-Id: <20260529075645.580362-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c | 29 +++++++++++++++++---------
 arch/x86/events/intel/ds.c   | 40 ++++++++++++++++++++++++------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index eef5d116aa06..4546b20429ba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3763,7 +3763,7 @@ static void intel_pmu_reset(void)
  *
  * The contents and other behavior of the guest event do not matter.
  */
-static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
+static int x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 				      struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3772,11 +3772,11 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
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
@@ -3786,9 +3786,14 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
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
@@ -3837,9 +3842,11 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
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
@@ -3866,8 +3873,10 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
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
index 8a653edce392..e0d307627702 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3047,7 +3047,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3056,7 +3056,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 	int n;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
@@ -3067,22 +3067,24 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
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
@@ -3105,7 +3107,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -3114,11 +3116,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3134,7 +3137,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
@@ -3198,6 +3201,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
+		events_bitmap |= BIT(bit);
 		event = cpuc->events[bit];
 		if (WARN_ON_ONCE(!event))
 			continue;
@@ -3219,6 +3223,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 						setup_pebs_fixed_sample_data);
 		}
 	}
+
+	return hweight64(events_bitmap);
 }
 
 static __always_inline void
@@ -3272,7 +3278,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
@@ -3282,10 +3288,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -3298,7 +3305,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	if (!iregs)
@@ -3313,6 +3320,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 			continue;
 
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_pebs_adaptive_sample_data);
@@ -3320,9 +3328,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
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
@@ -3332,13 +3342,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
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
@@ -3377,6 +3388,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		basic = at + sizeof(struct arch_pebs_header);
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_arch_pebs_sample_data);
@@ -3396,6 +3408,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
 					    counts, last,
 					    setup_arch_pebs_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
 static void __init intel_arch_pebs_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index c521a7fbe9c6..77bc42f8a070 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1022,7 +1022,7 @@ struct x86_pmu {
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

