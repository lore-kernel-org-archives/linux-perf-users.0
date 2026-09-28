Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8AC46EF6A;
	Mon, 28 Sep 2026 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581875; cv=none; b=tLvXCpvni46MGCNYHCuik8Q3uguluwSeBWiMmwj1PR/+FEx+sYkuZ6a5Eq1f8pEwX3FLMnuIs5Pcb8cCTNP0qrUsCIWWuD6Q14g2NE9gapYTGaeGnChBx2ZPpoM9QTkkDQpzbIWu050esIVWFsxADkC1bX/GLGWnY6zLhAp1v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581875; c=relaxed/simple;
	bh=pPPctFcN7CeyRvru3KnUA5lzBnAoutvzhORmbnyPsRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U0HpsXCVZlUXG+aUSUVsyHJsMjFGFeSudDlQwbYBVfbsfYpw00jQ8NfTGZUApJKjJmkrikxkk0hKMwgpwpOiaBwUA5yelEbQZ4oiA4KjfNUIeqZ+FokcbS+ELgnO/CX/5En216K2F4seypXJk+kwr0at9zXKRbxYoLu+9EADAJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kw1ouQJN; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kw1ouQJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581874; x=1822117874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPPctFcN7CeyRvru3KnUA5lzBnAoutvzhORmbnyPsRw=;
  b=Kw1ouQJNk/4PF5TGxfu1dYNYHeTde25jFbWTJupFa+bGUZOoq2ehxIcq
   tkdC6euWkHNST+11mgqgOxkWyEUVwKhhs1cuuzaAbPrbW0VnYr2FEcIwd
   SjPoP8YM6fCmefx9u6wseIAPUwit8H2BmdOfoeTQa3aEKouhrrEXwFPiY
   XFK5M1fkE/4n/ZZqa5fl/8Wqmh4Pmm/wd5QSUPoeoRQNAPf/HBM57M0Ym
   R86a6FwU+jwL3k1UYiGHDN2UVquWppSMDbl2jZePBdW9U1M+qu6vi1Usu
   5ipstNoLq87wVe1s3hy6zuCfdGkYkhTOAiZX76WpZKrcHaO7QbNQov/UL
   A==;
X-CSE-ConnectionGUID: ckH4R4SnR0OziahkwkOkEQ==
X-CSE-MsgGUID: UviqdfhERCuVrc1LytfIwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141466"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141466"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:13 -0700
X-CSE-ConnectionGUID: weDpZP96SlCpxf1EhR12fw==
X-CSE-MsgGUID: 0BaGu+hWRIiOeIEa2XQfFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275025007"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:10 -0700
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
Subject: [PATCH 11/15] perf/x86/intel: Fix invalid PEBS counts with counter-group support
Date: Mon, 28 Sep 2026 15:43:05 +0800
Message-Id: <20260928074309.898043-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
References: <20260928074309.898043-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On platforms with PEBS counter-group support (for example ARL and NVL),
running mixed PEBS events can occasionally produce an invalidly large
count for the instructions event, even exceeding the hardware counter
width (48 bits).

$ perf record -e '{cpu_core/instructions,period=100000/u,\
	cpu_core/l1-icache-load-misses,period=100000/u}:pS' -- ./foo

The issue is caused by PEBS drain ordering. To avoid scanning the PEBS
buffer twice, current drain helpers defer each event's last PEBS record
and do not process all records strictly in sampling order. That is safe
when no counter-group PEBS event is involved, but it can corrupt PEBS
count updates when two or more active PEBS events use counter-group
snapshotting.

Add intel_pmu_handle_pebs_records_in_order() and use it when two or more
counter-group PEBS events are active, so records are processed strictly in
sampling order for both adaptive PEBS and arch PEBS. This preserves
correct count updates and prevents invalid PEBS counts.

Fixes: 8807d922705f ("perf/x86/intel/ds: Factor out PEBS record processing code to functions")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 131 +++++++++++++++++++++++++++++++++++--
 1 file changed, 127 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1562d4cb1903..06ce3129e4a9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3413,6 +3413,113 @@ intel_pmu_handle_pebs_records(struct pt_regs *iregs,
 	return hweight64(events_bitmap);
 }
 
+static __always_inline int
+intel_pmu_handle_pebs_records_in_order(struct pt_regs *iregs,
+				       struct perf_sample_data *data,
+				       void *base, void *top,
+				       setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
+	u64 mask = get_pebs_cntr_mask(cpuc);
+	u64 events_bitmap = 0;
+	bool corrupted = false;
+	void *at, *next;
+	int bit;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/* Find the last PEBS record for each PEBS event. */
+	for (at = base; at < top;) {
+		u64 pebs_status;
+
+		next = find_next_pebs_record(at, top);
+		if (!next) {
+			corrupted = true;
+			break;
+		}
+
+		pebs_status = mask & get_pebs_cntr_status(at);
+		for_each_set_bit(bit, (unsigned long *)&pebs_status,
+				 INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS) {
+			struct perf_event *event = cpuc->events[bit];
+
+			if (WARN_ON_ONCE(!event) ||
+			    WARN_ON_ONCE(!event->attr.precise_ip))
+				continue;
+
+			last[bit] = at;
+		}
+		at = next;
+	}
+
+	/* Process all PEBS records in sampling order. */
+	for (at = base; at < top;) {
+		u64 pebs_status;
+
+		next = find_next_pebs_record(at, top);
+		if (!next)
+			break;
+
+		pebs_status = mask & get_pebs_cntr_status(at);
+		events_bitmap |= pebs_status;
+
+		for_each_set_bit(bit, (unsigned long *)&pebs_status,
+				 INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS) {
+			struct perf_event *event = cpuc->events[bit];
+
+			if (WARN_ON_ONCE(!event) ||
+			    WARN_ON_ONCE(!event->attr.precise_ip))
+				continue;
+
+			if (last[bit] && (at != last[bit])) {
+				counts[bit]++;
+				__intel_pmu_pebs_event(event, iregs, regs, data,
+						       at, setup_sample);
+			} else {
+				__intel_pmu_pebs_last_event(event, iregs, regs, data,
+							    at, counts[bit] + 1,
+							    corrupted,
+							    setup_sample);
+			}
+		}
+		at = next;
+	}
+
+	if (!events_bitmap)
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
+
+	return hweight64(events_bitmap);
+}
+
+static bool must_process_pebs_in_order(struct cpu_hw_events *cpuc)
+{
+	int count = 0;
+	int bit;
+
+	/*
+	 * When multiple PEBS events with counter-group are active, PEBS
+	 * records must be processed in sampling order; otherwise counter-group
+	 * updates can corrupt PEBS event counts.
+	 */
+	for_each_set_bit(bit, (unsigned long *)&cpuc->pebs_enabled, X86_PMC_IDX_MAX) {
+		struct perf_event *event = cpuc->events[bit];
+
+		if (!event || !event->attr.precise_ip)
+			continue;
+		if (is_pebs_counter_event_group(event))
+			count++;
+		if (count > 1)
+			return true;
+	}
+
+	return false;
+}
+
 static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs,
 				    struct perf_sample_data *data)
 {
@@ -3420,6 +3527,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs,
 	u64 mask = get_pebs_cntr_mask(cpuc);
 	struct debug_store *ds = cpuc->ds;
 	void *base, *top;
+	int handled;
 
 	if (!x86_pmu.pebs_active)
 		return 0;
@@ -3433,8 +3541,15 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs,
 		return 0;
 	}
 
-	return intel_pmu_handle_pebs_records(iregs, data, base, top,
-					     setup_pebs_adaptive_sample_data);
+	if (must_process_pebs_in_order(cpuc)) {
+		handled = intel_pmu_handle_pebs_records_in_order(iregs, data,
+				base, top, setup_pebs_adaptive_sample_data);
+	} else {
+		handled = intel_pmu_handle_pebs_records(iregs, data,
+				base, top, setup_pebs_adaptive_sample_data);
+	}
+
+	return handled;
 }
 
 static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
@@ -3444,6 +3559,7 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	u64 mask = get_pebs_cntr_mask(cpuc);
 	union arch_pebs_index index;
 	void *base, *top;
+	int handled;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
@@ -3465,8 +3581,15 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		index.thresh = ARCH_PEBS_THRESH_SINGLE;
 	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
-	return intel_pmu_handle_pebs_records(iregs, data, base, top,
-					     setup_arch_pebs_sample_data);
+	if (must_process_pebs_in_order(cpuc)) {
+		handled = intel_pmu_handle_pebs_records_in_order(iregs, data,
+					base, top, setup_arch_pebs_sample_data);
+	} else {
+		handled = intel_pmu_handle_pebs_records(iregs, data,
+					base, top, setup_arch_pebs_sample_data);
+	}
+
+	return handled;
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.34.1

