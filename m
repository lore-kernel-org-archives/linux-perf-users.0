Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D5A3EF0AC;
	Mon, 24 Aug 2026 08:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560574; cv=none; b=LNioDprB4Xk9Rf9RszRogWiXujponGJiM2RQVQl8+XE8VwDVAMAHmEtJoGKFixV9o6yymIyLldjagDCLZ2lzaUQZ6SM1MMSi2CfBOtqXc8jJr0DsUDRhs8rzvvG8Oy2/x65TVgpyyNlpzuqTVUnCExfHyzVeF1YYOLrlWKhz0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560574; c=relaxed/simple;
	bh=VY9jYcAMcoSVag8fA3K4Xe36/6niioO2bB21zgZVQVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bCSHlqobNcCm+1hKqg7XPY88LeJIqgGJWPmWuqV4XE1wN2mppCogVYY8ZABVKc1AilXY6kgmNYH+AsDWwG+vuE5oNetTRsLpdkJEfzCIQuUGJC+Dy+nc7R15GHV2Nut4Txc2cqB7m5+gl6brfS+XtBTJwn02grtQYZ9EdTi8vbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N1LCOwB5; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N1LCOwB5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560571; x=1819096571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VY9jYcAMcoSVag8fA3K4Xe36/6niioO2bB21zgZVQVM=;
  b=N1LCOwB5Ndjz2g+E9omjWhvn5uW2Uk8DuudDTwbKnZS9NQY2AvC3C62v
   icgiprYSo3RXZU8iUN82JR25No8YOm6Obo1RxklxaLp+k00RXcCCgAemX
   TwPHx45q2jMZGkJ/nOiR4MnBHCaQbpM0chLFamoHfIHhrDgrXoroYfvdq
   aY9ItKDz+T1hMZ6MOau2arzpIJIb0m8XMf6/sEV/p1b9M4N0+DPd8gJGu
   mUZKL0mEmzzhIqG2SN1nWajth5SNAlax389hmLk61hTo3troxzBDUnjRs
   FEXV7/CojkEUta++xl2DBxtZVViU+TDa2pZ5pilUcau9ytNNm3lZvHCMR
   g==;
X-CSE-ConnectionGUID: nDezDM74SYSKZ9939JXkkg==
X-CSE-MsgGUID: SVxsXdHrR7KAX7sNkipW2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598958"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598958"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:36:11 -0700
X-CSE-ConnectionGUID: tZWENzjQRP+OSXnahKrs3g==
X-CSE-MsgGUID: CYGgv+GnTYGjgs0pUFVFAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326789"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:36:06 -0700
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
Subject: [RESEND Patch v10 23/23] perf/x86/intel: Add sanity check for PEBS record/fragment size
Date: Mon, 24 Aug 2026 16:27:31 +0800
Message-Id: <20260824082731.1013973-24-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prevent potential infinite loops by adding a sanity check for the
corrupted PEBS record or fragment size which could happen in theory.

If a corrupted PEBS fragment is detected, the entire PEBS record
including the corrupted fragment and all subsequent records will be
dropped and a NULL PEBS record is reported to user space. This ensures
the integrity of PEBS data and prevents infinite loops in
setup_arch_pebs_sample_data() again.

Please note software has no way to figure out which events are impacted
by the corrupted record, so the last record of each event would be
discarded for all events if corrupted record is detected even though
it may be a well-formed record for some events.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 77 ++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 39028de75e4f..444814438715 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2657,6 +2657,9 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 again:
 	header = at;
+	if (!header->size)
+		return;
+
 	next_record = at + sizeof(struct arch_pebs_header);
 	if (header->basic) {
 		struct arch_pebs_basic *basic = next_record;
@@ -2930,13 +2933,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 			    struct pt_regs *iregs,
 			    struct pt_regs *regs,
 			    struct perf_sample_data *data,
-			    void *at,
-			    int count,
+			    void *at, int count, bool corrupted,
 			    setup_fn setup_sample)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	setup_sample(event, iregs, at, data, regs);
+	/* Skip parsing corrupted PEBS record. */
+	if (corrupted) {
+		/* Clear stale register states in previous records. */
+		memset(regs, 0, sizeof(*regs));
+		x86_pmu_clear_perf_regs(regs);
+		perf_sample_data_init(data, 0, event->hw.last_period);
+	} else {
+		setup_sample(event, iregs, at, data, regs);
+	}
+
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -2954,12 +2965,16 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		if ((is_pebs_counter_event_group(event))) {
-			/*
-			 * The value of each sample has been updated when setup
-			 * the corresponding sample data.
-			 */
-			perf_event_update_userpage(event);
+		if (is_pebs_counter_event_group(event)) {
+			if (corrupted) {
+				intel_pmu_save_and_restart_reload(event, 1);
+			} else {
+				/*
+				 * The value of each sample has been updated
+				 * when setup the corresponding sample data.
+				 */
+				perf_event_update_userpage(event);
+			}
 		} else {
 			/*
 			 * Now, auto-reload is only enabled in fixed period mode.
@@ -2983,7 +2998,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * counters-snapshotting record, only needs to set the new
 		 * period for the counter.
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event) && !corrupted)
 			static_call(x86_pmu_set_period)(event);
 		else
 			intel_pmu_save_and_restart(event);
@@ -3012,13 +3027,15 @@ __intel_pmu_pebs_events(struct perf_event *event,
 		iregs = &dummy_iregs;
 
 	while (cnt > 1) {
-		__intel_pmu_pebs_event(event, iregs, regs, data, at, setup_sample);
+		__intel_pmu_pebs_event(event, iregs, regs, data,
+				       at, setup_sample);
 		at += cpuc->pebs_record_size;
 		at = get_next_pebs_record_by_bit(at, top, bit);
 		cnt--;
 	}
 
-	__intel_pmu_pebs_last_event(event, iregs, regs, data, at, count, setup_sample);
+	__intel_pmu_pebs_last_event(event, iregs, regs, data, at,
+				    count, false, setup_sample);
 }
 
 static int intel_pmu_drain_pebs_core(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -3234,23 +3251,28 @@ static __always_inline void
 __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 				    struct pt_regs *regs,
 				    struct perf_sample_data *data,
-				    u64 mask, short *counts, void **last,
+				    u64 mask, short *counts,
+				    void **last, bool corrupted,
 				    setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
+	bool handled = false;
 	int bit;
 
 	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
 		if (!counts[bit])
 			continue;
 
+		handled = true;
 		event = cpuc->events[bit];
-
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_sample);
+					    counts[bit], corrupted, setup_sample);
 	}
 
+	/* All records are corrupted, reset sampling period. */
+	if (!handled)
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 }
 
 static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -3264,6 +3286,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	struct pebs_basic *basic;
 	void *base, *at, *top;
 	u64 events_bitmap = 0;
+	bool corrupted = false;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -3291,6 +3314,10 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 		u64 pebs_status;
 
 		basic = at;
+		if (WARN_ON_ONCE(!basic->format_size)) {
+			corrupted = true;
+			break;
+		}
 		if (basic->format_size != cpuc->pebs_record_size)
 			continue;
 
@@ -3302,7 +3329,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	}
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
-					    setup_pebs_adaptive_sample_data);
+					    corrupted, setup_pebs_adaptive_sample_data);
 
 	return hweight64(events_bitmap);
 }
@@ -3318,6 +3345,7 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 events_bitmap = 0;
+	bool corrupted = false;
 	u64 mask;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
@@ -3352,8 +3380,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		header = at;
 
-		if (WARN_ON_ONCE(!header->size))
-			break;
+		if (WARN_ON_ONCE(!header->size)) {
+			corrupted = true;
+			goto done;
+		}
 
 		/* 1st fragment or single record must have basic group */
 		if (!header->basic) {
@@ -3373,15 +3403,24 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 			if (!header->size)
 				break;
 			at += header->size;
+			if (WARN_ON_ONCE(at >= top)) {
+				corrupted = true;
+				goto done;
+			}
 			header = at;
 		}
 
 		/* Skip last fragment or the single record */
 		at += header->size;
+		if (WARN_ON_ONCE(at > top)) {
+			corrupted = true;
+			goto done;
+		}
 	}
 
+done:
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
-					    counts, last,
+					    counts, last, corrupted,
 					    setup_arch_pebs_sample_data);
 
 	return hweight64(events_bitmap);
-- 
2.34.1

