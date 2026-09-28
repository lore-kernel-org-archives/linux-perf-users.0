Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A637468C29;
	Mon, 28 Sep 2026 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790581867; cv=none; b=oQEo+9o49jiBIWc/89xfHcEL3T2THRQSE0JwwhIu8f2EvErS+gFLEMyKtllJ7VyM2xYGAQXabCKM327tHAGW7jklGA0yJiqezTWwqOBAXTR8vn6O9P1OiUGtKw0Y+//qpchz1a18WYScS2juzXaGGW88jSEKQT2ChjjfO6azgm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790581867; c=relaxed/simple;
	bh=P9h8kUN8sJYL7uCqWS60J5c0sEV4VoBON+38ALTUaGk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L7tio678XG8hB6XMJ8vGcbySSwYpxdu3nV/r/sJg+tx0PgrKWVcQ/RqCWIOq2Fis5nGKMHH/upjqNbvCkD/siBb38TNZKcfOW8kl7u6Qt+GYUPcijOr9alAXzmbo507Ao2f6pkaqW2QRP913fikrPii8B0FS+9bjGlX1X7qZFnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NOEmfH9W; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NOEmfH9W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790581866; x=1822117866;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P9h8kUN8sJYL7uCqWS60J5c0sEV4VoBON+38ALTUaGk=;
  b=NOEmfH9WW4LN8jbQty0HIwwlDs5altRmp6HDc2OkWiAm81Vevzvood0l
   Q9D5BUA/fyarBq/pdGXKDdExa8ZF6C58LYXTry7FwfUorvxmwkGeP089Y
   upZaYFxh1kwFZvzpmEvND/2efu+ZrCRi9fhYV97c9vRWrt0UnQPSP43Ph
   JED8qyCzBbSa5D+5KjYtZVxjonykmnS6G4jytlj960fbn2HMfOYrtDj8x
   EI0mODtZ52rriXENfONpHVyzQ7YESs0gMk+T3s+OtyKmwhQikahhRl5md
   xGe39eN9ltGkXJWBTpEWWDxyM3SEgNzhvgf+TfrBcSw77eApgtahPAUzb
   w==;
X-CSE-ConnectionGUID: DwFzw5hjTzW5gBw2k9QmFg==
X-CSE-MsgGUID: DJ72wEXbTTGQPYiHsz4TMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90141448"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90141448"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 00:51:06 -0700
X-CSE-ConnectionGUID: umuejwfiSZqkYDMmMJa47w==
X-CSE-MsgGUID: L9gjs3H/TlOD54agtcGbVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="275024958"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa009.jf.intel.com with ESMTP; 28 Sep 2026 00:51:03 -0700
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
Subject: [PATCH 09/15] perf/x86/intel: Refactor intel_pmu_drain_arch_pebs()
Date: Mon, 28 Sep 2026 15:43:03 +0800
Message-Id: <20260928074309.898043-10-dapeng1.mi@linux.intel.com>
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

intel_pmu_drain_arch_pebs() and intel_pmu_drain_pebs_icl() use the same
high-level PEBS drain flow. To reduce duplication, extract the shared
logic into a common helper, intel_pmu_handle_pebs_records(), and have
the arch-PEBS path use it.

Add small helper wrappers, including get_pebs_cntr_mask(),
get_pebs_cntr_status(), and find_next_pebs_record(), to hide
record-layout differences between ICL adaptive PEBS and arch PEBS.

This patch refactors only intel_pmu_drain_arch_pebs(); converting
intel_pmu_drain_pebs_icl() to the same helper is done in the next patch.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c | 163 ++++++++++++++++++++++---------------
 1 file changed, 96 insertions(+), 67 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1a32f4168a84..961f7138387a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -3267,7 +3267,6 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
-	bool handled = false;
 	int bit;
 
 	for_each_set_bit(bit, (unsigned long *)&mask,
@@ -3275,15 +3274,101 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 		if (!counts[bit])
 			continue;
 
-		handled = true;
 		event = cpuc->events[bit];
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
 					    counts[bit], corrupted, setup_sample);
 	}
+}
+
+static inline u64 get_pebs_cntr_mask(struct cpu_hw_events *cpuc)
+{
+	return hybrid(cpuc->pmu, arch_pebs_cap).counters &
+	       cpuc->pebs_enabled;
+}
+
+static inline u64 get_pebs_cntr_status(void *at)
+{
+	struct arch_pebs_basic *basic;
+
+	basic = at + sizeof(struct arch_pebs_header);
+	return basic->applicable_counters;
+}
+
+static void *find_next_pebs_record(void *at, void *top)
+{
+	struct arch_pebs_header *header;
+
+	header = at;
+	if (WARN_ON_ONCE(!header->size))
+		return NULL;
+
+	/* 1st fragment or single record must have basic group */
+	if (WARN_ON_ONCE(!header->basic))
+		return NULL;
+
+	/* Skip non-last fragments */
+	while (arch_pebs_record_continued(header)) {
+		if (!header->size)
+			return NULL;
+		at += header->size;
+		if (WARN_ON_ONCE(at >= top))
+			return NULL;
+		header = at;
+	}
+
+	/* Skip last fragment or the single record */
+	at += header->size;
+	if (WARN_ON_ONCE(at > top))
+		return NULL;
+
+	return at;
+}
+
+static __always_inline int
+intel_pmu_handle_pebs_records(struct pt_regs *iregs,
+			      struct perf_sample_data *data,
+			      void *base, void *top,
+			      setup_fn setup_sample)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
+	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
+	struct pt_regs *regs = &perf_regs->regs;
+	u64 mask = get_pebs_cntr_mask(cpuc);
+	u64 events_bitmap = 0;
+	bool corrupted = false;
+	void *at, *next;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/* Process all but the last event for each counter. */
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
+		events_bitmap |= pebs_status;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_sample);
+		at = next;
+	}
+
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
+					    counts, last, corrupted,
+					    setup_sample);
 
-	/* All records are corrupted, reset sampling period. */
-	if (!handled)
+	if (!events_bitmap)
 		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
+
+	return hweight64(events_bitmap);
 }
 
 static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
@@ -3342,22 +3427,19 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
 					    corrupted, setup_pebs_adaptive_sample_data);
 
+	if (!events_bitmap)
+		intel_pmu_pebs_event_update_no_drain(cpuc, mask);
+
 	return hweight64(events_bitmap);
 }
 
 static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 				     struct perf_sample_data *data)
 {
-	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
-	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 mask = get_pebs_cntr_mask(cpuc);
 	union arch_pebs_index index;
-	struct x86_perf_regs *perf_regs = this_cpu_ptr(&x86_pebs_regs);
-	struct pt_regs *regs = &perf_regs->regs;
-	void *base, *at, *top;
-	u64 events_bitmap = 0;
-	bool corrupted = false;
-	u64 mask;
+	void *base, *top;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
@@ -3379,61 +3461,8 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		index.thresh = ARCH_PEBS_THRESH_SINGLE;
 	wrmsrq(MSR_IA32_PEBS_INDEX, index.whole);
 
-	if (!iregs)
-		iregs = &dummy_iregs;
-
-	/* Process all but the last event for each counter. */
-	for (at = base; at < top;) {
-		struct arch_pebs_header *header;
-		struct arch_pebs_basic *basic;
-		u64 pebs_status;
-
-		header = at;
-
-		if (WARN_ON_ONCE(!header->size)) {
-			corrupted = true;
-			goto done;
-		}
-
-		/* 1st fragment or single record must have basic group */
-		if (!header->basic) {
-			at += header->size;
-			continue;
-		}
-
-		basic = at + sizeof(struct arch_pebs_header);
-		pebs_status = mask & basic->applicable_counters;
-		events_bitmap |= pebs_status;
-		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
-					       pebs_status, counts, last,
-					       setup_arch_pebs_sample_data);
-
-		/* Skip non-last fragments */
-		while (arch_pebs_record_continued(header)) {
-			if (!header->size)
-				break;
-			at += header->size;
-			if (WARN_ON_ONCE(at >= top)) {
-				corrupted = true;
-				goto done;
-			}
-			header = at;
-		}
-
-		/* Skip last fragment or the single record */
-		at += header->size;
-		if (WARN_ON_ONCE(at > top)) {
-			corrupted = true;
-			goto done;
-		}
-	}
-
-done:
-	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
-					    counts, last, corrupted,
-					    setup_arch_pebs_sample_data);
-
-	return hweight64(events_bitmap);
+	return intel_pmu_handle_pebs_records(iregs, data, base, top,
+					     setup_arch_pebs_sample_data);
 }
 
 static void __init intel_arch_pebs_init(void)
-- 
2.34.1

