Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490882820CE;
	Tue, 15 Apr 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705421; cv=none; b=UBfYnxM3QNlP3OEdapKSTVO5G+E+5gWQgVIc9rTxG5Xn9iW8rz5qtFtB6xSyVbitB5b82UpjDfzJwVGV8T/TDbFnWfC77NWXGt1HkzXb5ZkY126RuQbZgxoy3DQLoaM3+nWNDGPBwkYHmoJwlBpzMOKtDTSeIWnomenH6IXrOZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705421; c=relaxed/simple;
	bh=yfmqerRJ8gN/xI2pyqS617K+aks9MjMLGdKd7NNdMgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bk12X/BezBTkcQ5Yk1dAxWnz4hQwOKh+DlARtXkzIfXK8MljQdpvGWvDqHrAATCJTHLkudb459IQ8oEDjhf+MxMXzv1m+Fkh8xZP4CeyfuC5sXqrY/f0VsyYVRX+iPE2VayZt0JeWR6MlPHslrrC5isFwuVR2gYD2ve7c3ILIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCSwIrKk; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCSwIrKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705421; x=1776241421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yfmqerRJ8gN/xI2pyqS617K+aks9MjMLGdKd7NNdMgI=;
  b=HCSwIrKk+twX5MbcyEFZDwM2F/T1C+PAHj5s1f5+BqiV+8+zDiGaGabI
   cKNjDsFpFJWSKdt/rWUO7y3I40YUGXbIeINvEihR5RbNuDZ6bGH7opWtx
   ZCYZ4IzGiarrNAk3ZMDJZ6ECAKIUWV6oXjK9DbSBgQkBFIeOcww/VJwAV
   SoXq8OREsuLqXXTqFj6PYwM/sAdWNlosZwyDmO1yWeImg8xPQ0DjPypyG
   00DOVy678Yxy8dMTmQSKgb2OBwR14OmQc9Pj3wlX0owXFMe8PxXVrWo5X
   yY5IDkjFuy7IOEewkdBenS00YdEQ2S7kQ1WwUQnQOJCgH2raq5mY+Mb/a
   Q==;
X-CSE-ConnectionGUID: PZvePO4STzmmEFkb57hNRg==
X-CSE-MsgGUID: 9ufjGxq0TXWDYXc8tUF8Qg==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115948"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115948"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:40 -0700
X-CSE-ConnectionGUID: TVzuCOWWQ56ogSsb3MdslA==
X-CSE-MsgGUID: ALku7Qj5Tzq4RrsyPXFYcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055574"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:35 -0700
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
Subject: [Patch v3 08/22] perf/x86/intel/ds: Factor out PEBS record processing code to functions
Date: Tue, 15 Apr 2025 11:44:14 +0000
Message-Id: <20250415114428.341182-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/ds.c | 80 ++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4597b5c48d8a..22831ef003d0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2599,6 +2599,54 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
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
@@ -2608,9 +2656,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 	struct x86_perf_regs perf_regs;
 	struct pt_regs *regs = &perf_regs.regs;
 	struct pebs_basic *basic;
-	struct perf_event *event;
 	void *base, *at, *top;
-	int bit;
 	u64 mask;
 
 	if (!x86_pmu.pebs_active)
@@ -2623,6 +2669,7 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 
 	mask = hybrid(cpuc->pmu, pebs_events_mask) |
 	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
+	mask &= cpuc->pebs_enabled;
 
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
@@ -2640,31 +2687,14 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
-
-		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_pebs_adaptive_sample_data);
-	}
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
+					    setup_pebs_adaptive_sample_data);
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.40.1

