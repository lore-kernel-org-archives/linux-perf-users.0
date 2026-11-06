Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793940162;
	b=d71l5oypDHILFQIblNSQsh6cVIX+YiMsZr+Vc9czWgIPN8Fi6z5bbyUeoQ0NmQGj8N0b
	 40uTjpWdeJg/MYlA0HaWKl+WOC6HTgcOV1++lzLIy+DCr8Za3gRBCYvj5L5HBz/g94mhU
	 aq+zzNQSOu07Aleo4OIIk/UYex705fY025nZe9qXXlKijTZK8Afz2txhgnPw9pGhnY01i
	 hdP3LfztOxTarhcp8UBtZazltMsU9noK8IfLl1TJ5qoIroTkLcViIeY6i9BF9Wd2vnlM6
	 ka+w1wNybCJgkycO44+LQifq+o1kjdk5K5+fEZNxcuaAfEUX8WeU5dG8IFl8BRif7nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793940162;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QSuZAcND6CRIrH+2P+yg14xieba6yG5kQ09tpvqXW/U=;
	b=rnsvFRvVdHWg7mfYBwjT4DqkbjPqYD6fhUAlav4/rUd+qjeDG1qjL4TRwekiRJJUhYD7
	 aopyew+cclk410bGYv+sC6cdFwlN8NEuS8AQqdua3VI7Qio0jAKJrbuKleemQEV84laHP
	 kqUEYaIcxJAc9BgV97+DxyYh1n6w9DuqVBb0Tkz6f8JFksmEKx7EdQ5kL5xKNiLYXDisS
	 /X5xgb4Ux+myj0Rodlfi6c+2VwYXGPqsAhP2nQ8hHu8GX+Rz2n7iJlBPy3tvcDJXLuts6
	 GpJYP+U//fqHAI7whaZGppN/dZ1M/vweh5l+6EpsSj33pVQXR9kgNTDG+lEx7RcFjaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="l1xx/Jl5";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAD4606D810;
	Fri,  6 Nov 2026 04:42:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DAD4606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l1xx/Jl5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793940159; x=1825476159;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dzed3trsulKPAA9qFH6VVcChqW2tIK5NkF4zOpRKHDY=;
  b=l1xx/Jl5KfpqsvL5fm5tXhpdrFq2y5nFvEamwW9aMI6mXggzjg0UeP39
   +dKCQOln08LKhzwSBrj14MRUpcldj01E0vQXcUPi8UDVcuctn6T/hM3Md
   fXwgTmcHZon6JqY7fzMtx9XvTR7iN4Swp/uJ6k7RgHE/KWWpRPMV63xkf
   KX4/N6sWo5hF9sWYlj7P6CCyT0ABYcilN1P5V+/vOxAMjpE9my4hZzssj
   QIRRbaGgs3fC62KYPi27f5Ft3K6JJYxjpxmN5Zn0BzeGlzHLhZoJAxubC
   kG8vlEb0K5y06zOeIeV8VUY4lgxwSRyRAbUvUIzM9mBaXtFiQBdh2SD1Q
   w==;
X-CSE-ConnectionGUID: l5TwOlQhT1SW02jdfn8NoQ==
X-CSE-MsgGUID: GpM/L2gcT8yDAVgcDFYvlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2780966"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2780966"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 20:42:08 -0800
X-CSE-ConnectionGUID: e/R5InKgQXS1r8SolDQ2Og==
X-CSE-MsgGUID: Ub6kMsumTUGgqOrsg7EkMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7223037"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa001.jf.intel.com with ESMTP; 05 Nov 2026 20:42:03 -0800
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
Subject: [Patch v6 19/20] perf/x86/intel: Pass LBR stack size into store_lbr()
Date: Fri,  6 Nov 2026 12:32:56 +0800
Message-Id: <20261106043257.842864-20-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
References: <20261106043257.842864-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/lbr.c  | 18 ++++++++++--------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 332754e1da4f..95a2166f5a47 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2595,12 +2595,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
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
@@ -2781,7 +2781,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	if (header->lbr) {
 		struct arch_pebs_lbr_header *lbr_header = next_record;
 		struct lbr_entry *lbr;
-		int num_lbr;
+		unsigned int num_lbr;
 
 		next_record = lbr_header + 1;
 		lbr = next_record;
@@ -2792,7 +2792,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		next_record += num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
-			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_store_pebs_lbrs(lbr, num_lbr);
 			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index fbc053ebbeaf..ce6aa35e20fb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -902,7 +902,7 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
 static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
 
-static void intel_pmu_store_lbr(struct lbr_entry *entries,
+static void intel_pmu_store_lbr(struct lbr_entry *entries, int lbr_nr,
 				struct perf_branch_stack *lbr_stack)
 {
 	struct perf_branch_entry *e;
@@ -911,8 +911,8 @@ static void intel_pmu_store_lbr(struct lbr_entry *entries,
 	bool mispred;
 	int i;
 
-	cpu_init_lbr_stack(lbr_stack, x86_pmu.lbr_nr);
-	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+	cpu_init_lbr_stack(lbr_stack, lbr_nr);
+	for (i = 0; i < lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
 		e = &lbr_stack->entries[i];
 
@@ -1016,7 +1016,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc,
 				    struct perf_branch_stack *lbr_stack)
 {
-	intel_pmu_store_lbr(NULL, lbr_stack);
+	intel_pmu_store_lbr(NULL, x86_pmu.lbr_nr, lbr_stack);
 }
 
 static void
@@ -1026,14 +1026,15 @@ intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc,
 	struct x86_perf_task_context_arch_lbr_xsave *xsave = cpuc->lbr_xsave;
 
 	if (!xsave) {
-		intel_pmu_store_lbr(NULL, lbr_stack);
+		intel_pmu_store_lbr(NULL, x86_pmu.lbr_nr, lbr_stack);
 		return;
 	}
 	xsave->header.xfeatures = 0;
 	xsaves(&xsave->xsave, XFEATURE_MASK_LBR);
 
 	if (xsave->header.xfeatures & XFEATURE_MASK_LBR) {
-		intel_pmu_store_lbr(xsave->lbr.entries, lbr_stack);
+		intel_pmu_store_lbr(xsave->lbr.entries,
+				    x86_pmu.lbr_nr, lbr_stack);
 	} else {
 		/* Clear the LBR stack to avoid leaking stale entries. */
 		lbr_stack->nr = 0;
@@ -1313,7 +1314,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
 	lbr_stack->nr = lbr_nr;
 }
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -1324,7 +1325,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(lbr, cpu_lbr_stack(cpuc));
+	intel_pmu_store_lbr(lbr, min(lbr_nr, x86_pmu.lbr_nr),
+			    cpu_lbr_stack(cpuc));
 	intel_pmu_lbr_filter(cpuc, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a4e53c99eaf5..1b3fa997d89d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1980,7 +1980,7 @@ void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc);
 
 void intel_pmu_drain_pebs_buffer(void);
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr);
 
 void intel_pebs_init(void);
 
-- 
2.34.1

