Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFB22E7F3D;
	Thu, 21 Aug 2025 03:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748776; cv=none; b=qq8bsErq09pQCT19NC1kMMs5yntMwQ3zsrCIU33NerkCODp/j4GA++krzcbz/mPVJDtrJyW3PGmqRdxzN6NDmrW1XXq/Bi98zSCGQIDXL54LIc/BaIA5FAKNmh6winKfQ/XzF573mwVloj8V+xi6REgDreZeWys2ze1If6J/zTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748776; c=relaxed/simple;
	bh=/xpNiCs1Ut9Z0VhW/5J0PjLqkjQLjMoSWsqk7nZfjF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aqNE2Lq9bcxuXp31HnWVRvU6Qq4XbTMPNqo3vE+0/KyPGdUtxztgToNVv+UrQl2aSjw8/nkL1Jo6j47qCe8mbaVOojHRX2y3ppvJXdLLVJH9Ki9I5lFIJ0kxqF24b1JPklrbgEmoJVdpkxLBVUE+yqWiqorr/rVBn0enXmUW/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B9VkcTim; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B9VkcTim"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755748775; x=1787284775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/xpNiCs1Ut9Z0VhW/5J0PjLqkjQLjMoSWsqk7nZfjF4=;
  b=B9VkcTimRWu738Tl13tU/OrWa1Od+8koqd65fUXYXkor1N5I5KXyfTOh
   Pu5bULacdJLSZc2TWLarh5YYTCfSLHY8abTMR8hrH8YSjENTSeBNxpbHg
   I8M4uePu4sCnWqMumr7wkXS2SvrQRiCfupUXBKucdrGzqknB8KRj72w/v
   JnedmfW8g8OOmZ0M6DDuZfFo3L8VZO4TyDnwJ6itNHyqW6UQN2uqkP6gF
   NVXohu47/XOQdxeSAuFiGm/DRGDHMjIoHwZlyzXhvyBTN+VQ2nX8xi7+m
   EvRYzb+BtNWgxOSal4At1gbi107In8AtYy9lw9/KbQB/h99/+GTltMNXi
   Q==;
X-CSE-ConnectionGUID: LYA2GhGYQBqMXXZ0w9BKjA==
X-CSE-MsgGUID: MlC7u18ESaCfjm+Pl7io5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="68731969"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="68731969"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 20:59:34 -0700
X-CSE-ConnectionGUID: QbBHj1x0Rimyy4ogS0xRuA==
X-CSE-MsgGUID: QDyTiFy+Tk6KsIYu/6QkVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="168713056"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 20 Aug 2025 20:59:31 -0700
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
Subject: [Patch v6 04/10] perf/x86/intel/ds: Factor out PEBS record processing code to functions
Date: Thu, 21 Aug 2025 11:57:59 +0800
Message-Id: <20250821035805.159494-5-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
References: <20250821035805.159494-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/ds.c | 100 ++++++++++++++++++++++++-------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 276e98e5a4dd..7fe631da3334 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2614,6 +2614,64 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 	}
 }
 
+static inline void __intel_pmu_handle_pebs_record(struct pt_regs *iregs,
+						  struct pt_regs *regs,
+						  struct perf_sample_data *data,
+						  void *at, u64 pebs_status,
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
+	}
+}
+
+static inline void
+__intel_pmu_handle_last_pebs_record(struct pt_regs *iregs, struct pt_regs *regs,
+				    struct perf_sample_data *data, u64 mask,
+				    short *counts, void **last,
+				    setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct perf_event *event;
+	int bit;
+
+	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
+		if (!counts[bit])
+			continue;
+
+		event = cpuc->events[bit];
+		/*
+		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
+		 * could trigger interrupt throttle and clear all event pointers of the
+		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
+		 * is NULL, if so it indicates the event has been throttled (stopped) and
+		 * the corresponding last PEBS records have been processed in stopping
+		 * event, don't need to process it again.
+		 */
+		if (!event)
+			continue;
+
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_sample);
+	}
+
+}
+
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
@@ -2623,9 +2681,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	struct pebs_basic *basic;
-	struct perf_event *event;
 	void *base, *at, *top;
-	int bit;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -2638,6 +2694,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
+	mask &= cpuc->pebs_enabled;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
@@ -2655,41 +2712,14 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
-		}
+		pebs_status = mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_pebs_adaptive_sample_data);
 	}
 
-	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (!counts[bit])
-			continue;
-
-		event = cpuc->events[bit];
-		/*
-		 * perf_event_overflow() called by below __intel_pmu_pebs_last_event()
-		 * could trigger interrupt throttle and clear all event pointers of the
-		 * group in cpuc->events[] to NULL. So need to re-check if cpuc->events[*]
-		 * is NULL, if so it indicates the event has been throttled (stopped) and
-		 * the corresponding last PEBS records have been processed in stopping
-		 * event, don't need to process it again.
-		 */
-		if (!event)
-			continue;
-
-		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_pebs_adaptive_sample_data);
-	}
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
+					    setup_pebs_adaptive_sample_data);
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.34.1

