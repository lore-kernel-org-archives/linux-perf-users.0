Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36E53783A0;
	Tue, 24 Mar 2026 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313266; cv=none; b=EW7x9H3rb5FUpqfNLEZGOTXAcVO0Wa99DlJaI9OpBlZK9BoyLWEwfOjWQD/5hFGRO46BgOoalhXaLkHBolTX+5QcEtxzNnfid8TCNnaxZeVOPrtmLmKemuamjnveMUzu42reBxsDwW4IxUEy0kINVwySp/Gm6/AWCdmSAskNGVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313266; c=relaxed/simple;
	bh=SVdbexuW8xfUfof3mVmaw/4W1T03yLxP8hI+atdxO6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2KKd6gz1GAVjt6Umn5+IkeN/U/ZG70M+6mcDcrRHwZ5wSk3LDK8O1vAEfnXdLIZHA0APg5Bt3tb68Y4ZKJ0ftKS9vwBC6extWxsuHId2slgPXwdtOHOVxFTw1/ie4ptDbkSO+gCy4CGYy7zOV5SgW1FaCqICd2HSJUkxchlsGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DnGkCjgX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DnGkCjgX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313265; x=1805849265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SVdbexuW8xfUfof3mVmaw/4W1T03yLxP8hI+atdxO6U=;
  b=DnGkCjgXN3OV6L4Juk950q8zPXNWyaq8kobq54lhYNZZhtWD7FIjftYQ
   Tue0JRcGsyoU8guxGaiVLw8ontEKumNIdWdoTV2cQ1pPeABN4JQIHO3Hf
   ujodaFS+kM4XrdheTnae8rOhJb6m5X4XSwiTCPpN21ABBxZDlPlBlls8G
   6sttZy+PS+8a3nY0x85v7oWUX6pMY9Y6rnYuDV/6/aLp45WJfhq4Avaqz
   rGgLGn57f817s/4+nPx79dX5ITngqDyng81KeUBChyQJjlzklh5Z6dCzH
   mi7US1yP2pvAS5D9Wl5h9hmVJU72NAnW50lNEz73wKWy+1Dbq805WXmZp
   w==;
X-CSE-ConnectionGUID: uNVzS98uRc6hmbEVIzVPzQ==
X-CSE-MsgGUID: 1wcfnyEPT4+zj6LMBO2uNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397312"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397312"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:44 -0700
X-CSE-ConnectionGUID: hKvA7PhdTxqxBfypwO5Yfg==
X-CSE-MsgGUID: dg+u2ZPKTkOyqZIuiPkITw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221323027"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:40 -0700
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
Subject: [Patch v7 24/24] perf/x86/intel: Add sanity check for PEBS fragment size
Date: Tue, 24 Mar 2026 08:41:18 +0800
Message-Id: <20260324004118.3772171-25-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-1-dapeng1.mi@linux.intel.com>
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
including the fragment and all subsequent records will be discarded.
This ensures the integrity of PEBS data and prevents infinite loops
in setup_arch_pebs_sample_data() again.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: new patch.

 arch/x86/events/intel/ds.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6e1c516122c0..4b0dd8379737 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2819,7 +2819,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	}
 
 	/* Parse followed fragments if there are. */
-	if (arch_pebs_record_continued(header)) {
+	if (arch_pebs_record_continued(header) && header->size) {
 		at = at + header->size;
 		goto again;
 	}
@@ -2948,13 +2948,17 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
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
+	if (corrupted)
+		perf_sample_data_init(data, 0, event->hw.last_period);
+	else
+		setup_sample(event, iregs, at, data, regs);
+
 	if (iregs == &dummy_iregs) {
 		/*
 		 * The PEBS records may be drained in the non-overflow context,
@@ -3026,13 +3030,15 @@ __intel_pmu_pebs_events(struct perf_event *event,
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
@@ -3247,7 +3253,8 @@ static __always_inline void
 __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 				    struct pt_regs *regs,
 				    struct perf_sample_data *data,
-				    u64 mask, short *counts, void **last,
+				    u64 mask, short *counts,
+				    void **last, bool corrupted,
 				    setup_fn setup_sample)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -3261,7 +3268,7 @@ __intel_pmu_handle_last_pebs_record(struct pt_regs *iregs,
 		event = cpuc->events[bit];
 
 		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
-					    counts[bit], setup_sample);
+					    counts[bit], corrupted, setup_sample);
 	}
 
 }
@@ -3317,7 +3324,7 @@ static int intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_da
 	}
 
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts, last,
-					    setup_pebs_adaptive_sample_data);
+					    false, setup_pebs_adaptive_sample_data);
 
 	return hweight64(events_bitmap);
 }
@@ -3333,6 +3340,7 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 	struct pt_regs *regs = &perf_regs->regs;
 	void *base, *at, *top;
 	u64 events_bitmap = 0;
+	bool corrupted = false;
 	u64 mask;
 
 	rdmsrq(MSR_IA32_PEBS_INDEX, index.whole);
@@ -3388,6 +3396,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 			if (!header->size)
 				break;
 			at += header->size;
+			if (WARN_ON_ONCE(at >= top)) {
+				corrupted = true;
+				goto done;
+			}
 			header = at;
 		}
 
@@ -3395,8 +3407,9 @@ static int intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
 		at += header->size;
 	}
 
+done:
 	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
-					    counts, last,
+					    counts, last, corrupted,
 					    setup_arch_pebs_sample_data);
 
 	return hweight64(events_bitmap);
-- 
2.34.1

