Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B03BD64C;
	Fri, 29 May 2026 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041876; cv=none; b=ljJxCWAsWmNMwDsnp5wGL/Y/zzc76gLIkeHS/Ix80mu4g5azQC7pSw9babASHrguUCKengW459MDdJd2oFF9F9hZWYxvC6x9iO8+tHaYPj5gmhjRvd6pr41e+kOhFA9qKCGNEhMBNC2pA4GQXbkXzaw48oAkm99MP0bF5zNLiMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041876; c=relaxed/simple;
	bh=ejHAjMXmlgnoWHSKQWwwp11JhfD8ttmuEBIljZim/xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djTMAsNJ59zz0pABejE679hRhZTVH4zOMfZPUjGEQ6C4zz20mMfP/5Wd9tiwh+gOfrnxjN7ymZzlyHn3wtWOZNf08BZlAMJ9ocMTPfbNy+hfGlu3eysXeIf9GJ13H68yN7jGT+yIcM+AFP1qKbjN6tZXMWJhinL5PTQ00BuiiOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jC+/PK5W; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jC+/PK5W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041874; x=1811577874;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ejHAjMXmlgnoWHSKQWwwp11JhfD8ttmuEBIljZim/xc=;
  b=jC+/PK5WRgISHkFJzHPP6UDAFdZrkmsDhi77OOjJGnEglyuRMtI6IyeF
   GFT1M/oKI26DUDu8wXRikAG+1FQvdNxMRXF7b7Czuqw4BNOwhEsZ0JUZy
   Ix+1C7Vg7Z07uJHZTNvZgWBkj5S4i5H7ic7It8P6jBfAVxcGNO39q5f3A
   QPuNl6CVEPOPIh3LmNaD4L/6TVDCjtVC3gAwvc6C2U61DEiLbCYS5TmnR
   e0LKxfdKkPAdyYKgneW8zZov7zZmxW4meI8Gda1ZF/JvaIVezFmJTZYfU
   lZbKQJ9UNHuO/mE0ZFJ/UD3qcWXFONZacj9CeeWNhidr7W805y86Q4dIv
   A==;
X-CSE-ConnectionGUID: aA96FwAoQdaf74Ha4LEfvQ==
X-CSE-MsgGUID: 1zfv8Gq3QdmiVvCKg52XlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342271"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342271"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:04:34 -0700
X-CSE-ConnectionGUID: hjHTdM+eTf6PL95phwVvpg==
X-CSE-MsgGUID: CFjwm1agQeawR70ntITtdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802627"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:04:29 -0700
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
Subject: [Patch v8 23/23] perf/x86/intel: Add sanity check for PEBS fragment size
Date: Fri, 29 May 2026 15:56:45 +0800
Message-Id: <20260529075645.580362-24-dapeng1.mi@linux.intel.com>
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

Prevent potential infinite loops by adding a sanity check for the
corrupted PEBS fragment sizes which could happen in theory.

If a corrupted PEBS fragment is detected, the entire PEBS record
including the corrupted fragment and all subsequent records will be
dropped and a NULL PEBS record is reported to user space. This ensures
the integrity of PEBS data and prevents infinite loops in
setup_arch_pebs_sample_data() again.

Please note software has no way to figure out which events are impacted
from the corrupted record, so the last record of each event would be
discarded for all events if corrupted record is detected even though
it may be a well-formed record for some events.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 68 +++++++++++++++++++++++++++-----------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e0d307627702..3e100cb206a8 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2675,6 +2675,9 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 again:
 	header = at;
+	if (!header->size)
+		return;
+
 	next_record = at + sizeof(struct arch_pebs_header);
 	if (header->basic) {
 		struct arch_pebs_basic *basic = next_record;
@@ -2827,7 +2830,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	}
 
 	/* Parse followed fragments if there are. */
-	if (arch_pebs_record_continued(header)) {
+	if (arch_pebs_record_continued(header) && header->size) {
 		at = at + header->size;
 		goto again;
 	}
@@ -2956,13 +2959,21 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
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
@@ -2980,12 +2991,16 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
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
@@ -3009,7 +3024,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * counters-snapshotting record, only needs to set the new
 		 * period for the counter.
 		 */
-		if (is_pebs_counter_event_group(event))
+		if (is_pebs_counter_event_group(event) && !corrupted)
 			static_call(x86_pmu_set_period)(event);
 		else
 			intel_pmu_save_and_restart(event);
@@ -3038,13 +3053,15 @@ __intel_pmu_pebs_events(struct perf_event *event,
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
@@ -3259,7 +3276,8 @@ static __always_inline void
 __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 				    struct pt_regs *regs,
 				    struct perf_sample_data *data,
-				    u64 mask, short *counts, void **last,
+				    u64 mask, short *counts,
+				    void **last, bool corrupted,
 				    setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3273,7 +3291,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 		event = cpuc->events[bit];
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_sample);
+					    counts[bit], corrupted, setup_sample);
 	}
 
 }
@@ -3327,7 +3345,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	}
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
-					    setup_pebs_adaptive_sample_data);
+					    false, setup_pebs_adaptive_sample_data);
 
 	return hweight64(events_bitmap);
 }
@@ -3343,6 +3361,7 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 events_bitmap = 0;
+	bool corrupted = false;
 	u64 mask;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
@@ -3377,8 +3396,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 
 		header = at;
 
-		if (WARN_ON_ONCE(!header->size))
-			break;
+		if (WARN_ON_ONCE(!header->size)) {
+			corrupted = true;
+			goto done;
+		}
 
 		/* 1st fragment or single record must have basic group */
 		if (!header->basic) {
@@ -3398,15 +3419,24 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
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

