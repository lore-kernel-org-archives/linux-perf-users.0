Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249283;
	b=Yx7U3z14PFdGkDJrwqo23BWS6x63DQJWIovHRINYD4MW7FNFkIxOqyPajlY3mTPt0c07
	 strJLOk4J+k6OZDPc+0DcagjtwhH5ujYyeEEfzO7C1EwrD+uM0993Z0eVw63LT8IDamPH
	 pgaWnqIiMlP7lbvYWesAMyorL1bEaRii4uHtLFnFvDJIdyR0Ldf6eyFn5KJEoJM9eUv/6
	 nJfHajf25YqbLUhSR8IPjxaFwGCj27zDzv+1hAz/uNRgPpqbojywDvl4+TZiHx3XRAtib
	 vaHFEZ07t3TKnVTnwC8Orf6kE7+OYkhirsT9kZ0TAtrbHbRocYKxZoy5urdA1ZZrjeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249283;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=25peop1wfSbobktwl7RFmdHAyz3FkU2oKwCc47uPiHU=;
	b=cysII2w5oIboBVbfL3jzt/hwSwj+FOrfauMF4a2UJD5YqXjQf7uunx+q68zof3Y99k9I
	 HGyDrrO2yhTkHUMnhmGAQxbrRQr6Cb3QAhcVmHcwblRZKnS6XY1S8Hz+IcuLoE4ATetK7
	 BWak2CFp9rgt4wUJU99qgRB4Ye4/CFNOvRsnUYY3Tz657e3jGBGSDBGFgnyPEoI4XjzTR
	 7b9Yne1Nn/rTXTJjOA1lAIrpEQEzpR7AVMt3l5yPhpwYD83VcH0ZhQcLY3klbJ1Lvxh7K
	 KWdhdj8aIXpCJGXZck6db4/Auc92nH2eb3olbqUYz+4Zu1HatxW4sEfAlfzbp795RxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Fv09t/c+";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01768606A31C;
	Thu, 29 Oct 2026 04:48:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01768606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Fv09t/c+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793249283; x=1824785283;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sdYdLCDQjxisnCLD3SLLgq1nsObdB3B8boo/CwOp84c=;
  b=Fv09t/c+v1anF4qy4xJDsEfTft1w9nELlHYrXRTAu+3FQzBZRSQi/d41
   da/BVo3qSeU+lBq769x2qmnZSU3Q8Be2/huU/faDaeADSTeeBYkw67SWL
   30qhDyfnBQeVfnch46nxIgvA2LWBasGC0NbQasJ8tVXqDybB5NtMV3we1
   Jh4WMJRx6EF9lmEEAqJw/4Levi+yIqYmWztFsYb1L15ALM07MjcfDs1/v
   h8cqLK1xGECcxGUxFUmbX0tRLbmxDzZL4PnsjWlopmNXWJwVhhAeSR26o
   969MvN28Hpjza5tjehK93hXlw24EjmY2vfHrXWz9SDL1fe/eo9YzanPd1
   g==;
X-CSE-ConnectionGUID: zG+z3oVeRSChXkhQLZizwA==
X-CSE-MsgGUID: 3Ese8y4KQqKkCaYGM+wn4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1986355"
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="1986355"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 21:48:03 -0700
X-CSE-ConnectionGUID: Q/jY8TOaQ8+j1ORQhBz9dw==
X-CSE-MsgGUID: m6fQYz6MTwyuvZiux8dY2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,183,1787036400"; 
   d="scan'208";a="5420624"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa007.fm.intel.com with ESMTP; 28 Oct 2026 21:47:58 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [Patch v5 17/18] perf/x86/intel: Pass LBR stack size into store_lbr()
Date: Thu, 29 Oct 2026 12:39:13 +0800
Message-Id: <20261029043914.1395147-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_pmu_store_lbr() assumes the LBR stack always contains
x86_pmu.lbr_nr entries, but arch-PEBS can use a smaller configured depth.
This can result in out-of-bounds reads when the stack is shallower than
the hardware maximum.

Add a lbr_nr parameter to the helper so the code only processes the
available entries and avoids overrunning the LBR buffer.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c   |  8 ++++----
 arch/x86/events/intel/lbr.c  | 16 +++++++++-------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 8444670cee4a..ac452083de7a 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2591,12 +2591,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	if (format_group & PEBS_DATACFG_LBRS) {
 		struct lbr_entry *lbr = next_record;
-		int num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT)
+		unsigned int num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT)
 					& 0xff) + 1;
 		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
-			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_store_pebs_lbrs(lbr, num_lbr);
 			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
@@ -2777,7 +2777,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	if (header->lbr) {
 		struct arch_pebs_lbr_header *lbr_header = next_record;
 		struct lbr_entry *lbr;
-		int num_lbr;
+		unsigned int num_lbr;
 
 		next_record = lbr_header + 1;
 		lbr = next_record;
@@ -2788,7 +2788,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		next_record += num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
-			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_store_pebs_lbrs(lbr, num_lbr);
 			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index e9336d570242..f0098b0f16d3 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -911,7 +911,7 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
 static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
 
-static void intel_pmu_store_lbr(struct lbr_entry *entries,
+static void intel_pmu_store_lbr(struct lbr_entry *entries, int lbr_nr,
 				struct perf_branch_stack *lbr_stack,
 				struct perf_branch_entry *lbr_entries)
 {
@@ -921,7 +921,7 @@ static void intel_pmu_store_lbr(struct lbr_entry *entries,
 	bool mispred;
 	int i;
 
-	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+	for (i = 0; i < lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
 		e = &lbr_entries[i];
 
@@ -1027,7 +1027,7 @@ static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc,
 				    struct perf_branch_stack *lbr_stack,
 				    struct perf_branch_entry *lbr_entries)
 {
-	intel_pmu_store_lbr(NULL, lbr_stack, lbr_entries);
+	intel_pmu_store_lbr(NULL, x86_pmu.lbr_nr, lbr_stack, lbr_entries);
 }
 
 static void
@@ -1038,14 +1038,15 @@ intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc,
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(NULL, lbr_stack, lbr_entries);
+		intel_pmu_store_lbr(NULL, x86_pmu.lbr_nr, lbr_stack, lbr_entries);
 		return;
 	}
 	xsave->header.xfeatures = 0;
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
-		intel_pmu_store_lbr(xsave->lbr.entries, lbr_stack, lbr_entries);
+		intel_pmu_store_lbr(xsave->lbr.entries, x86_pmu.lbr_nr,
+				    lbr_stack, lbr_entries);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
 		lbr_stack->nr = 0;
@@ -1323,7 +1324,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
 	}
 }
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -1334,7 +1335,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(lbr, &cpuc->lbr_stack, cpuc->lbr_entries);
+	intel_pmu_store_lbr(lbr, min(lbr_nr, x86_pmu.lbr_nr),
+			    &cpuc->lbr_stack, cpuc->lbr_entries);
 	intel_pmu_lbr_filter(cpuc, &cpuc->lbr_stack,
 			     cpuc->lbr_entries, cpuc->lbr_counters);
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 160df7b99621..feceeebf0d06 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1967,7 +1967,7 @@ void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc);
 
 void intel_pmu_drain_pebs_buffer(void);
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr);
 
 void intel_pebs_init(void);
 
-- 
2.34.1

