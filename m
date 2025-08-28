Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329CE239E8B;
	Thu, 28 Aug 2025 01:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344975; cv=none; b=ry3DDQQecFhyeaL8Q4f/CWfsQ5hyUXQSWXCdROHacvuru7QH9PT678p0pfKNk85fQ6S+61jpskIK0MnG/Vkd9C3cUMURVCvbyauR7zfT+LU1eYBpHXuO2aPMRV1nF9Jos/SsyDQP4p/dNtXZShF87ujOrra1xq8HnGgsRbeUKp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344975; c=relaxed/simple;
	bh=BKIqVkClGU/ZywKLr620dQ6fpWZ8bbSBrVr5mesWXO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ddDF63gf5w8KCBQ8VgD1kcxlm36n9tPBEJr2/Is1/XMgY+yqERgPQzOevF931jHVg7y/ZZh2KemwHDEc6qrkkVhcMxnAqd4g/VqYyWq1EKbJjyWcICy2ZxxCop9KT/3EyoYMXCwNpAE+IraCFg7yC/0PCAWvcHSeijYSygxAJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNQbGR1U; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNQbGR1U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344974; x=1787880974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKIqVkClGU/ZywKLr620dQ6fpWZ8bbSBrVr5mesWXO8=;
  b=nNQbGR1UdJyET3MWdYdqh4AHVwIDAvVyTFO2ZvriUCD06uYzz3ZpsbYh
   SQx9BBwja4FfHxeBZlals4gb+ptLzlXqal6xh4EBW932iRtkqLwG2MwgY
   uVzW1SC8wYD2RWNKRPFNMCvXKaBchjS95XkRJgmWyQ2M65/SnTh6EmKe0
   8h9u9srqMOc0b3Wfie8wj0GO3mbeI8xeMhYEIreKFYe8+/tWza03An+eJ
   8cCfaJhp1un/dDfkQSomTJtN6D68UJKx+F0lbkzwmgQ2LVFQmgKIPQVak
   uKObaNsdesNO/AVS/2IVK8y9cUfVBnPaxgBKsGD4vdvUsAqM/1TPeg9Gt
   g==;
X-CSE-ConnectionGUID: eUCzp+a4Re6ldiZ2VVf81g==
X-CSE-MsgGUID: iosODL2iQc+Zy4rpsa9a/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240885"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240885"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:36:12 -0700
X-CSE-ConnectionGUID: llpyvuawR7CBPbzXIbtbtA==
X-CSE-MsgGUID: hK58adI/RR23i7tNPoJvzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372547"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:36:10 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 06/12] perf/x86/intel/ds: Factor out PEBS record processing code to functions
Date: Thu, 28 Aug 2025 09:34:29 +0800
Message-Id: <20250828013435.1528459-7-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
References: <20250828013435.1528459-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Beside some PEBS record layout difference, arch-PEBS can share most of
PEBS record processing code with adaptive PEBS. Thus, factor out these
common processing code to independent inline functions, so they can be
reused by subsequent arch-PEBS handler.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 101 ++++++++++++++++++++++++-------------
 1 file changed, 66 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index cd3d2752e32b..7a100467d635 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2624,6 +2624,64 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
+						  struct pt_regs *regs,
+						  struct perf_sample_data *data,
+						  void *at, u64 pebs_status,
+						  struct perf_event *events[],
+						  short *counts, void **last,
+						  setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+		event = cpuc->events[bit];
+
+		if (WARN_ON_ONCE(!event) ||
+		    WARN_ON_ONCE(!event->attr.precise_ip))
+			continue;
+
+		if (counts[bit]++)
+			__intel_pmu_pebs_event(event, iregs, regs, data,
+					       last[bit], setup_sample);
+
+		last[bit] = at;
+		/*
+		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
+		 * could trigger interrupt throttle and clear all event pointers of
+		 * the group in cpuc->events[] to NULL. So snapshot the event[] before
+		 * it could be cleared. This avoids the possible NULL event pointer
+		 * access and PEBS record loss.
+		 */
+		if (counts[bit] && !events[bit])
+			events[bit] = cpuc->events[bit];
+	}
+}
+
+static inline void
+__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs, struct pt_regs *regs,
+				    struct perf_sample_data *data, u64 mask,
+				    struct perf_event *events[],
+				    short *counts, void **last,
+				    setup_fn setup_sample)
+{
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
+		if (!counts[bit])
+			continue;
+
+		event = events[bit];
+
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_sample);
+	}
+
+}
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
@@ -2634,9 +2692,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	struct pebs_basic *basic;
-	struct perf_event *event;
 	void *base, *at, *top;
-	int bit;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -2649,6 +2705,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
+	mask &= cpuc->pebs_enabled;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
@@ -2666,41 +2723,15 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (basic->format_size != cpuc->pebs_record_size)
 			continue;
 
-		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
-			event = cpuc->events[bit];
-
-			if (WARN_ON_ONCE(!event) ||
-			    WARN_ON_ONCE(!event->attr.precise_ip))
-				continue;
-
-			if (counts[bit]++) {
-				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
-						       setup_pebs_adaptive_sample_data);
-			}
-			last[bit] = at;
-
-			/*
-			 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
-			 * could trigger interrupt throttle and clear all event pointers of
-			 * the group in cpuc->events[] to NULL. So snapshot the event[] before
-			 * it could be cleared. This avoids the possible NULL event pointer
-			 * access and PEBS record loss.
-			 */
-			if (counts[bit] && !events[bit])
-				events[bit] = cpuc->events[bit];
-		}
+		pebs_status = mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, events, counts, last,
+					       setup_pebs_adaptive_sample_data);
 	}
 
-	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (!counts[bit])
-			continue;
-
-		event = events[bit];
-
-		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_pebs_adaptive_sample_data);
-	}
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, events,
+					    counts, last,
+					    setup_pebs_adaptive_sample_data);
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.34.1

