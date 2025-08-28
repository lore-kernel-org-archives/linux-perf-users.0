Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268921FBCA1;
	Thu, 28 Aug 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756344963; cv=none; b=TNFPwyHGyC+zKGOaMTnJeScn/XzHBH9C0AeCf8WTz7TnWmngllLTQ8FmYoXMZat98c6X7JMxfXluyTVYLU2V3kBL+ZGy+CXvs9X0IuOrwtwJ1afXXepkGkV6rH00WUOd+mpCLZwByYbPTMxMby3Bl1oPjVAAF14xi1f6zE46K98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756344963; c=relaxed/simple;
	bh=7WTNy50u3thvqISbJ7HVFiHrzL/gkN6z60LQs4/ASc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+9sI9fm0zQc2vxGRKAcAsHN3xQQdw4771WIO9flWQlYeF/NdOKITddsnmQ/GEFoifvNBjxBf/1TaW6zo8PRUoe/D09wp0OYLiuQLtHDaMdWph/qfDasxNNAemq6IxJ4QYN4WBJb6PBMjllIqEBbhjCOWcJ5wRvrKGkxCQbxSfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NyH8cfqN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NyH8cfqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756344961; x=1787880961;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7WTNy50u3thvqISbJ7HVFiHrzL/gkN6z60LQs4/ASc4=;
  b=NyH8cfqN1PEQk+RF9nXQ1UJ1ddocyTwVXVuyKazQtkUvB75mR2wenH1h
   dVxOuKLVnAxlbABHCXZtOJYOytQViHmtPhWLZJY61pCsv/9PsYvrBgEsI
   +pTWsVVFKxn9VoxKIB+gAXL4Hugu8hlcWDIqh6T+2+VfPhomPFgmX4YU1
   IEnYo5sk+avQHW+5VOPlcu4aSNF9eNC/6YDbvuq+2gr+OkiMmvE/QWfq3
   R9Oe/d0GAqM3y1ByGh+fzOb81dazqAMyn3iX1bkmPX0Y60Wi47WQZrtIL
   yH95Xrh31dYZXnQO9mLzAcsMjTjsTI6KI7CakuYla09H0yGuyhtIrLfII
   w==;
X-CSE-ConnectionGUID: Ky+ZSuXyRVS1OUAAePVHQw==
X-CSE-MsgGUID: B70PhO2rTZqUvxdeXdzFcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="61240823"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="61240823"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2025 18:35:59 -0700
X-CSE-ConnectionGUID: haRwVmoOQWGPrdcQPAmswg==
X-CSE-MsgGUID: U1W7bWhHRx6GsrxlbwaknQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170372464"
Received: from spr.sh.intel.com ([10.112.230.239])
  by fmviesa008.fm.intel.com with ESMTP; 27 Aug 2025 18:35:56 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [Patch v7 02/12] perf/x86/intel: Fix NULL event access and potential PEBS record loss
Date: Thu, 28 Aug 2025 09:34:25 +0800
Message-Id: <20250828013435.1528459-3-dapeng1.mi@linux.intel.com>
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
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index c0b7ac1c7594..b71973e140c2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2487,6 +2487,7 @@ static void intel_pmu_pebs_event_update_no_drain(struct cpu_hw_events *cpuc, u64
 
 static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_data *data)
 {
+	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
 	struct perf_event *event;
@@ -2572,13 +2573,22 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
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
 
@@ -2603,6 +2613,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
+	struct perf_event *events[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {NULL};
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
 	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -2655,6 +2666,16 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
 
@@ -2662,7 +2683,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		if (!counts[bit])
 			continue;
 
-		event = cpuc->events[bit];
+		event = events[bit];
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
 					    counts[bit], setup_pebs_adaptive_sample_data);
-- 
2.34.1

