Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87FF46D55C;
	Mon, 28 Sep 2026 07:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581871; cv=none; b=ItNv6acJM3Vz+wJvNxG1iThUn3RYuSz9jZjUIdLmlb/XKaoDkEbTV/MDbfmbTUEZutDAnHJOtaO3/8gVTK/jScFfTDUUc4RDMqqTfLRAMxqAFt9AcEUS+hewbDAmKfaDpC+IU5qyGq8ZV7W3LbwBsvslwpNmXJtfTQHoans+lsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581871; c=relaxed/simple;
	bh=yg7V1nh3gQM/R7Bm1sm7SkgFXTr8TQE1DlWE/B3qwI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ez39tKNToqr/R5TraaCngJf7RklqWWc/nW2QSL3BKM6lB6Xchf/U1i46nMAZkJFa6cTQKEWBH1bQg4yC5mgNSIbyU8rN7ksRd1ECdhKZTR6Ujpd2E1vn8WaLnuXktj8INYhiOWkIzHcGMkVvb9zD630dPkEbRVCRUtRg4PwQ4Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jq71DUwE; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jq71DUwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581870; x=1822117870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yg7V1nh3gQM/R7Bm1sm7SkgFXTr8TQE1DlWE/B3qwI8=;
  b=jq71DUwEL26wn54ZHZGGDJutGjm2Nh3iXexNVVMeJmZ3JJp+R59ZbMlm
   pH22Owg+tV3Z12b8Usgbx4aoEE5SqTjZT+H1s2p+/6VWxN7naXRahyVCC
   cr9G7nzaLnmkC84m98XX1xDMK36GQrahSlbINTVbU7BPDIKA2gtkzt5og
   lC6zIC7M/rhuqKjfjZ/H62cwqFQeTQTlTOQTpozrCv8YzJPFSXRLaAhWu
   gAiwLUG8cV5dmIQpLPrTT1Nv2wEc6m5zXjYo7N9WnC6ZSX0U38n4Sh2X+
   EvPtrsGzNqV6EQAfB8Mhv9W/V4Fopsg5C6FFNL+V+DfTUYDiAyGQfk54X
   A==;
X-CSE-ConnectionGUID: ydJaq24oSWKo/+bS2eSKVQ==
X-CSE-MsgGUID: P93F/oOvSfCWmgwJjgd5SA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141459"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141459"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:10 -0700
X-CSE-ConnectionGUID: RclS1v89S+GEI+iI/MpzvQ==
X-CSE-MsgGUID: az9bMAIBQ2y0hC485fwOuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024972"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:06 -0700
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
Subject: [PATCH 10/15] perf/x86/intel: Refactor intel_pmu_drain_pebs_icl()
Date: Mon, 28 Sep 2026 15:43:04 +0800
Message-Id: <20260928074309.898043-11-dapeng1.mi@linux.intel.com>
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

Switch intel_pmu_drain_pebs_icl() to the common PEBS drain path provided
by intel_pmu_handle_pebs_records(), reducing duplicated logic between
PEBS drain implementations.

Extend the helper layer, including get_pebs_cntr_mask(),
get_pebs_cntr_status(), and find_next_pebs_record(), so it also handles
the ICL adaptive PEBS record layout.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 108 +++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 52 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 961f7138387a..1562d4cb1903 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3282,19 +3282,53 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 
 static inline u64 get_pebs_cntr_mask(struct cpu_hw_events *cpuc)
 {
-	return hybrid(cpuc->pmu, arch_pebs_cap).counters &
-	       cpuc->pebs_enabled;
+	u64 mask;
+
+	if (x86_pmu.arch_pebs)
+		mask = hybrid(cpuc->pmu, arch_pebs_cap).counters;
+	else {
+		mask = hybrid(cpuc->pmu, pebs_events_mask) |
+		       hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED;
+	}
+
+	return mask & cpuc->pebs_enabled;
 }
 
 static inline u64 get_pebs_cntr_status(void *at)
 {
-	struct arch_pebs_basic *basic;
+	u64 status;
+
+	if (x86_pmu.arch_pebs) {
+		struct arch_pebs_basic *basic;
+
+		basic = at + sizeof(struct arch_pebs_header);
+		status = basic->applicable_counters;
+	} else {
+		struct pebs_basic *basic = at;
 
-	basic = at + sizeof(struct arch_pebs_header);
-	return basic->applicable_counters;
+		status = basic->applicable_counters;
+	}
+
+	return status;
 }
 
-static void *find_next_pebs_record(void *at, void *top)
+static void *icl_pebs_find_next_pebs_record(void *at, void *top)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	struct pebs_basic *basic = at;
+
+	if (WARN_ON_ONCE(!basic->format_size))
+		return NULL;
+
+	if (WARN_ON_ONCE(basic->format_size != cpuc->pebs_record_size))
+		return NULL;
+
+	at += basic->format_size;
+
+	return at;
+}
+
+static void *arch_pebs_find_next_pebs_record(void *at, void *top)
 {
 	struct arch_pebs_header *header;
 
@@ -3324,6 +3358,14 @@ static void *find_next_pebs_record(void *at, void *top)
 	return at;
 }
 
+static void *find_next_pebs_record(void *at, void *top)
+{
+	if (x86_pmu.arch_pebs)
+		return arch_pebs_find_next_pebs_record(at, top);
+	else
+		return icl_pebs_find_next_pebs_record(at, top);
+}
+
 static __always_inline int
 intel_pmu_handle_pebs_records(struct pt_regs *iregs,
 			      struct perf_sample_data *data,
@@ -3371,66 +3413,28 @@ intel_pmu_handle_pebs_records(struct pt_regs *iregs,
 	return hweight64(events_bitmap);
 }
 
-static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
+static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs,
+				    struct perf_sample_data *data)
 {
-	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
-	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 mask = get_pebs_cntr_mask(cpuc);
 	struct debug_store *ds = cpuc->ds;
-	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
-	struct pt_regs *regs = &perf_regs->regs;
-	struct pebs_basic *basic;
-	void *base, *at, *top;
-	u64 events_bitmap = 0;
-	bool corrupted = false;
-	u64 mask;
+	void *base, *top;
 
 	if (!x86_pmu.pebs_active)
 		return 0;
 
-	base = (struct pebs_basic *)(unsigned long)ds->pebs_buffer_base;
-	top = (struct pebs_basic *)(unsigned long)ds->pebs_index;
-
+	base = (void *)(unsigned long)ds->pebs_buffer_base;
+	top = (void *)(unsigned long)ds->pebs_index;
 	ds->pebs_index = ds->pebs_buffer_base;
 
-	mask = hybrid(cpuc->pmu, pebs_events_mask) |
-	       (hybrid(cpuc->pmu, fixed_cntr_mask64) << INTEL_PMC_IDX_FIXED);
-	mask &= cpuc->pebs_enabled;
-
 	if (unlikely(base >= top)) {
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
 		return 0;
 	}
 
-	if (!iregs)
-		iregs = &dummy_iregs;
-
-	/* Process all but the last event for each counter. */
-	for (at = base; at < top; at += basic->format_size) {
-		u64 pebs_status;
-
-		basic = at;
-		if (WARN_ON_ONCE(!basic->format_size)) {
-			corrupted = true;
-			break;
-		}
-		if (basic->format_size != cpuc->pebs_record_size)
-			continue;
-
-		pebs_status = mask & basic->applicable_counters;
-		events_bitmap |= pebs_status;
-		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
-					       pebs_status, counts, last,
-					       setup_pebs_adaptive_sample_data);
-	}
-
-	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
-					    corrupted, setup_pebs_adaptive_sample_data);
-
-	if (!events_bitmap)
-		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
-
-	return hweight64(events_bitmap);
+	return intel_pmu_handle_pebs_records(iregs, data, base, top,
+					     setup_pebs_adaptive_sample_data);
 }
 
 static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
-- 
2.34.1

