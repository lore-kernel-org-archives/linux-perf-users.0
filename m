Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE673313293;
	Wed, 15 Oct 2025 06:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510780; cv=none; b=uPNfQWdmipqGUNXXvHwHUuNKofrz/dhdUIA39x3gQ5RaaY/w/Q9L6hQram78OnFLJKMZ4TaghaG+20gLVMhu/lBb2B4HlWSmhO2sUQKfxZl/3qV3B2xw4paEYL8TUCXekoV0AL8Uv9+zfK8AG+tUHZ2L9oVd9Yw6ERscFUI7fAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510780; c=relaxed/simple;
	bh=PKOvLA1nOJSddxzqXGtRq7POOj0ei/pXhYyYAX3aUaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O25gIWYeuHGKXc3OB0XAUcbo/MVhG6e7Qj0e5vEhIQd+yP3HOiN1MmnaD6w05JGT+2HSNl4jF0F8Y6TaWymRH+I3BORQXtOEsMxMSyJcis4i/DbQC6zt5FllbKqH9K7xGLX5VYbbN72Qd7BFuXNQhtTyLOgjtiU7BBQKGoAZRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n8cOtCDz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n8cOtCDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760510779; x=1792046779;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PKOvLA1nOJSddxzqXGtRq7POOj0ei/pXhYyYAX3aUaw=;
  b=n8cOtCDzips3/gswZxd8oyT86JeIRb9tEGfmJ7vo7XN8uFuKJLWUBffQ
   29WtoW+xVkIXMSGiMJA9JGjk+AVEbVFphILqQF+PTT/P4RCgeG1qpXmLu
   lCVEXXBCa6VeIgGq6O0hN+5VQ12ur5fuIUKspfuDCch/huYBu+FVFS48u
   rk6/HoQbNpU7SCYiZImGtmWxxcCeAZmkyO/CpKGRx2/v6o2wdpuXdyrHP
   Gn/sZnbjJZ4W2Tp/qg/WIPBWCDNS87NNgkIwOZ+vCHvpT7s0HnvW9zrAm
   2KXMN0e4IDFT7S5+f4mE28jovLBHR3sQdhEYPKevzMCgP5I4+PD4FyEmM
   Q==;
X-CSE-ConnectionGUID: b8mPwlawQmSmPho7shfQ9A==
X-CSE-MsgGUID: /3mL3C8PRyyhI519F0hliA==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="50242457"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="50242457"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 23:46:18 -0700
X-CSE-ConnectionGUID: Iv32JucjRP6UgisB1+q87g==
X-CSE-MsgGUID: WlF3FDn7Tz+f67PV2g5+fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; 
   d="scan'208";a="182029891"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa006.fm.intel.com with ESMTP; 14 Oct 2025 23:46:14 -0700
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
	kernel test robot <oliver.sang@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v8 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss
Date: Wed, 15 Oct 2025 14:44:12 +0800
Message-Id: <20251015064422.47437-3-dapeng1.mi@linux.intel.com>
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

When intel_pmu_drain_pebs_icl() is called to drain PEBS records, the
perf_event_overflow() could be called to process the last PEBS record.

While perf_event_overflow() could trigger the interrupt throttle and
stop all events of the group, like what the below call-chain shows.

perf_event_overflow()
  -> __perf_event_overflow()
    ->__perf_event_account_interrupt()
      -> perf_event_throttle_group()
        -> perf_event_throttle()
          -> event->pmu->stop()
            -> x86_pmu_stop()

The side effect of stopping the events is that all corresponding event
pointers in cpuc->events[] array are cleared to NULL.

Assume there are two PEBS events (event a and event b) in a group. When
intel_pmu_drain_pebs_icl() calls perf_event_overflow() to process the
last PEBS record of PEBS event a, interrupt throttle is triggered and
all pointers of event a and event b are cleared to NULL. Then
intel_pmu_drain_pebs_icl() tries to process the last PEBS record of
event b and encounters NULL pointer access.

To avoid this NULL event access and potential PEBS record loss, snapshot
cpuc->events[] into a local events[] before drian_pebs() helper calling
perf_event_overflow() and then use the local events[] to process the
left PEBS records.

Besides intel_pmu_drain_pebs_nhm() has similar issue and fix it as well.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202507042103.a15d2923-lkp@intel.com
Fixes: 9734e25fbf5a ("perf: Fix the throttle logic for a group")
Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..259a0ff807eb 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2487,6 +2487,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 
 static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
+	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
@@ -2526,9 +2527,11 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 		/* PEBS v3 has more accurate status bits */
 		if (x86_pmu.intel_cap.pebs_format >= 3) {
-			for_each_set_bit(bit, (unsigned long *)&pebs_status, size)
+			for_each_set_bit(bit, (unsigned long *)&pebs_status, size) {
 				counts[bit]++;
-
+				if (counts[bit] && !events[bit])
+					events[bit] = cpuc->events[bit];
+			}
 			continue;
 		}
 
@@ -2566,19 +2569,31 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		 * If collision happened, the record will be dropped.
 		 */
 		if (pebs_status != (1ULL << bit)) {
-			for_each_set_bit(i, (unsigned long *)&pebs_status, size)
+			for_each_set_bit(i, (unsigned long *)&pebs_status, size) {
 				error[i]++;
+				if (error[i] && !events[i])
+					events[i] = cpuc->events[i];
+			}
 			continue;
 		}
 
 		counts[bit]++;
+		/*
+		 * perf_event_overflow() called by below __intel_pmu_pebs_events()
+		 * could trigger interrupt throttle and clear all event pointers of
+		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
+		 * it could be cleared. This avoids the possible NULL event pointer
+		 * access and PEBS record loss.
+		 */
+		if (counts[bit] && !events[bit])
+			events[bit] = cpuc->events[bit];
 	}
 
 	for_each_set_bit(bit, (unsigned long *)&mask, size) {
 		if ((counts[bit] == 0) && (error[bit] == 0))
 			continue;
 
-		event = cpuc->events[bit];
+		event = events[bit];
 		if (WARN_ON_ONCE(!event))
 			continue;
 
@@ -2603,6 +2618,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
+	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2655,6 +2671,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 						       setup_pebs_adaptive_sample_data);
 			}
 			last[bit] = at;
+
+			/*
+			 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
+			 * could trigger interrupt throttle and clear all event pointers of
+			 * the group in cpuc->events[] to NULL. So snapshot the event[] before
+			 * it could be cleared. This avoids the possible NULL event pointer
+			 * access and PEBS record loss.
+			 */
+			if (counts[bit] && !events[bit])
+				events[bit] = cpuc->events[bit];
 		}
 	}
 
@@ -2662,7 +2688,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (!counts[bit])
 			continue;
 
-		event = cpuc->events[bit];
+		event = events[bit];
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
 					    counts[bit], setup_pebs_adaptive_sample_data);
-- 
2.34.1

