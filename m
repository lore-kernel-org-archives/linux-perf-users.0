Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F7D29ACFD;
	Wed,  3 Dec 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745165; cv=none; b=bZ+T0rAzUGATCTA7CKSRxyVfzEBCeFu51lOx3EAx1Kie2aufLrgwLcUEF3TfjPy4TgKXsZAJVtPHupit6/exczl9j1NQnMoZT3O+mO03gpXYgZtvkHhVYnxNisyHDiG9LPOsF7S/Thoqab4a7QhzuJxP6VVVsTe28xqp/6iy/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745165; c=relaxed/simple;
	bh=8ilMXUbou99UFi5xd5SgbrbDnffWXIZoPGVykXimAHk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MgJ1MBDidrSa5myaNkyWIlStp1s9vHRPlDyoKqeXxTTT483sVhrf5+qU6Wn3cI26CIM7Z0ReZ1wIB/GhsZ6FdTqYarmiqajdnBsBgVE6UTxhyBoPrTTNxW8WGNRlxVQlXbOQe/0A2F6A0hVXUlP7eFZb4AwMwbn+9H3RimIBAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AV72ILd5; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AV72ILd5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745163; x=1796281163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ilMXUbou99UFi5xd5SgbrbDnffWXIZoPGVykXimAHk=;
  b=AV72ILd5JCkhOO5Fgrarr0H2G/tyjbZRK0gTeASpkP6hp3eAL+SCT2eU
   N21MlPdybfeidZmXyacEBxqIGey92KlugmiXqipgSjQ/EX7Itb3NBdFQB
   MI2MJeGfVqlW31TuDUCMnOxVQpJVLsZ8PqvzyLRI+B8q1n9bJtdx/0q6J
   old3nUfM506mrrg0gyg/S7YxqosL+WLsvNXUatj3ja85V5B6DWFzemfq0
   Sr0/w227mHMOBSWksNzHUy9SppJ0G2lXvrFvgX2KjtmiaxKtPJZjKSa78
   VaX+UMbbqaeelms+mbctevsw3Rld6+KOJ4tc2wgTgTlHYvZivtCx5fIZl
   g==;
X-CSE-ConnectionGUID: xLyKewleS+6w7VeV2UNmyQ==
X-CSE-MsgGUID: 0FZ6EHm9Rtq5yVuc2/HOfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324920"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324920"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:23 -0800
X-CSE-ConnectionGUID: YrLKPjoRROO17TUb7gKoFQ==
X-CSE-MsgGUID: 1W/kNWa8TsKCTIVzwSYNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199004024"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:59:18 -0800
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
Subject: [Patch v5 16/19] perf/x86: Activate back-to-back NMI detection for arch-PEBS induced NMIs
Date: Wed,  3 Dec 2025 14:54:57 +0800
Message-Id: <20251203065500.2597594-17-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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

This patch modifies the PEBS handler to return the count of actually
processed events, thereby activating back-to-back NMI detection and
avoiding the "suspicious NMI" warning.

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c |  3 +--
 arch/x86/events/intel/ds.c   | 36 +++++++++++++++++++++++-------------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index da48bcde8fce..a130d3f14844 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3351,8 +3351,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 	 */
 	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
 				 (unsigned long *)&status)) {
-		handled++;
-		static_call(x86_pmu_drain_pebs)(regs, &data);
+		handled += static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
 		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a01c72c03bd6..c7cdcd585574 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2759,7 +2759,7 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
 }
 
-static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -2768,7 +2768,7 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
 	int n;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	at  = (struct pebs_record_core *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_core *)(unsigned long)ds->pebs_index;
@@ -2779,22 +2779,24 @@ static void intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_
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
+	return 0;
 }
 
 static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64 mask)
@@ -2817,7 +2819,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 	}
 }
 
-static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
@@ -2830,7 +2832,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	base = (struct pebs_record_nhm *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_record_nhm *)(unsigned long)ds->pebs_index;
@@ -2846,7 +2848,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	for (at = base; at < top; at += x86_pmu.pebs_record_size) {
@@ -2931,6 +2933,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 						setup_pebs_fixed_sample_data);
 		}
 	}
+
+	return 0;
 }
 
 static __always_inline void
@@ -2984,7 +2988,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 }
 
-static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
@@ -2997,7 +3001,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
-		return;
+		return 0;
 
 	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
 	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
@@ -3010,7 +3014,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-		return;
+		return 0;
 	}
 
 	if (!iregs)
@@ -3032,9 +3036,11 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
 					    setup_pebs_adaptive_sample_data);
+
+	return 0;
 }
 
-static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
+static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 				      struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
@@ -3044,13 +3050,14 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
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
@@ -3089,6 +3096,7 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		basic = at + sizeof(struct arch_pebs_header);
 		pebs_status = mask & basic->applicable_counters;
+		events_bitmap |= pebs_status;
 		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
 					       pebs_status, counts, last,
 					       setup_arch_pebs_sample_data);
@@ -3108,6 +3116,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
 					    counts, last,
 					    setup_arch_pebs_sample_data);
+
+	return hweight64(events_bitmap);
 }
 
 static void __init intel_arch_pebs_init(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 35a1837d0b77..98958f6d29b6 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1003,7 +1003,7 @@ struct x86_pmu {
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

