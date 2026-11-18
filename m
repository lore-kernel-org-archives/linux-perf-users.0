Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794972273;
	b=ZYXoDz9edKFTGX3+/7TufB2tpw6ibLSTtn0Jp5/SbTq8iQpVPtMjeMSAkjR/xVWTSw36
	 T792Fqe+xClQ+GE6NFv+38GI4uz8Hs0L6zl9PDv8CAltjFiWQ4gJdNK59Zd9vf4V7A7vB
	 R5qco5JqZU2RXQvuLIvPBQqnrSgjxrG0Rjy3nVhIRLv4tn47FlYtmDCEgU5iWH1LINQld
	 TF9waf95JNW3RFfPxL8LXv3aKPdJYpAshrxZZcMij/1cMZhNe+BpUWdNtbeq43zuKNGL0
	 2Eacm43UwLNjXVQExDtIbi6MppA0WtNdx+11THXkwf7+Q1HjM5ZcgcM6IOo1aCFf77Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794972273;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fNXazWtX1DVFXmLPP4gklFhtIMQR3vVTK4fBZjQWf9I=;
	b=uQ2P3UevpmQY0whiuD6ze0O/SyGOrvjdwv+ISR8+PnNo/sDblsDmoooGIC5yUvCbD6ij
	 8bBCLZTtB3qsMG3agK4r07n7bRI16LWcAeVCavoSH8AVD5y73eMkDxDJJfscBECw14OS9
	 kxBrFZ97Mift/PQjEnpchkP6bdUnE2YPd/LpVR7e4dcbtYD+iyKZOajIRwBMAgpf7xcLS
	 a3cmxzdoKzoIpdH5Dcl2SnugBN7rI65Niwt4CEyCN9aC74D7+L1tq/+kCQ+1Bi+S39JJJ
	 DkvXSuh1IVMZ28+UzfLgBo+LHEm5RU0xHxTYR7613m5b+yTLSBqE1QE1XtR7edEIKVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JEbskoD1;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC65606A331;
	Wed, 18 Nov 2026 03:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AC65606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JEbskoD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794972273; x=1826508273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XGqbGZ50ay5uVX5FRH1ZOv55kNmrS0+XiuLw5IjNzv0=;
  b=JEbskoD1Zw6dsL5uhhcCaRHWC4MfWjdZpqRNaeQvDbrcISBqbAnnRIqK
   Q/kxRfiDHxPydY8Hv0n8IQBjrrmN+EwIwe3iVLSFRK/OXc8JVbpLC5rlT
   gb3zAcP/MwFc3VDSUGVUip5mn42ZesYkh1CYGjuGEQmJ5rijuAOsmSGNM
   K+GtK3aOQM+hV2H0zhANTnJMGUOgkpGJDb7ZwkSkYqZbUC/htRgYnVf61
   tU+y8F7SlO8n0LiaAbJF3R1oX0ycPp2jk1vB72Z/z8bB0Zr2/rrwOf2VH
   1uZiZe2x6flkyFl9WZbzx8FkxYKR+O8RE12biw4LLFUWnFxpRI/SBjeqb
   Q==;
X-CSE-ConnectionGUID: 7E2XExhoTEu7wzHUZHJFmw==
X-CSE-MsgGUID: XFiLmccDTPmALir3R1En8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3630050"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3630050"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 19:24:33 -0800
X-CSE-ConnectionGUID: BPBcyWrhQF6cDO9as2oJaQ==
X-CSE-MsgGUID: XPLSVo+hROqv0kvyUAUiqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="9894389"
Received: from spr.sh.intel.com ([10.112.229.196])
  by orviesa004.jf.intel.com with ESMTP; 17 Nov 2026 19:24:28 -0800
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
Subject: [Patch v7 22/24] perf/x86/intel: Pass LBR stack size into intel_pmu_store_lbr()
Date: Wed, 18 Nov 2026 11:14:51 +0800
Message-Id: <20261118031453.1353625-23-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
References: <20261118031453.1353625-1-dapeng1.mi@linux.intel.com>
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

Fixes: d21954c8a0ff ("perf/x86/intel: Process arch-PEBS records or record fragments")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/ds.c   | 11 ++++++-----
 arch/x86/events/intel/lbr.c  | 18 ++++++++++--------
 arch/x86/events/perf_event.h |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 9fe84e4880d9..1bf9e9b4a8c9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2603,12 +2603,13 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	if (format_group & PEBS_DATACFG_LBRS) {
 		struct lbr_entry *lbr = next_record;
-		int num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT)
-					& 0xff) + 1;
+		unsigned int num_lbr;
+
+		num_lbr = ((format_group >> PEBS_DATACFG_LBR_SHIFT) & 0xff) + 1;
 		next_record = next_record + num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
-			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_store_pebs_lbrs(lbr, num_lbr);
 			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
@@ -2789,7 +2790,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	if (header->lbr) {
 		struct arch_pebs_lbr_header *lbr_header = next_record;
 		struct lbr_entry *lbr;
-		int num_lbr;
+		unsigned int num_lbr;
 
 		next_record = lbr_header + 1;
 		lbr = next_record;
@@ -2800,7 +2801,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		next_record += num_lbr * sizeof(struct lbr_entry);
 
 		if (has_branch_stack(event)) {
-			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_store_pebs_lbrs(lbr, num_lbr);
 			intel_pmu_lbr_save_brstack(data, cpuc, event);
 		}
 	}
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 4736debffb0b..73b3fbb3b823 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -906,7 +906,7 @@ static __always_inline u16 get_lbr_cycles(u64 info)
 
 static_assert((64 - PERF_BRANCH_ENTRY_INFO_BITS_MAX) > LBR_INFO_BR_CNTR_NUM * LBR_INFO_BR_CNTR_BITS);
 
-static void intel_pmu_store_lbr(struct lbr_entry *entries,
+static void intel_pmu_store_lbr(struct lbr_entry *entries, unsigned int lbr_nr,
 				struct perf_branch_stack *lbr_stack)
 {
 	struct perf_branch_entry *e;
@@ -915,8 +915,8 @@ static void intel_pmu_store_lbr(struct lbr_entry *entries,
 	bool mispred;
 	int i;
 
-	cpu_init_lbr_stack(lbr_stack, x86_pmu.lbr_nr);
-	for (i = 0; i < x86_pmu.lbr_nr; i++) {
+	cpu_init_lbr_stack(lbr_stack, lbr_nr);
+	for (i = 0; i < lbr_nr; i++) {
 		lbr = entries ? &entries[i] : NULL;
 		e = &lbr_stack->entries[i];
 
@@ -1020,7 +1020,7 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc,
 				    struct perf_branch_stack *lbr_stack)
 {
-	intel_pmu_store_lbr(NULL, lbr_stack);
+	intel_pmu_store_lbr(NULL, x86_pmu.lbr_nr, lbr_stack);
 }
 
 static void
@@ -1030,14 +1030,15 @@ intel_pmu_arch_lbr_read_xsave(struct cpu_hw_events *cpuc,
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
@@ -1317,7 +1318,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
 	lbr_stack->nr = lbr_nr;
 }
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
@@ -1328,7 +1329,8 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	else
 		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
 
-	intel_pmu_store_lbr(lbr, cpu_lbr_stack(cpuc));
+	intel_pmu_store_lbr(lbr, min(lbr_nr, x86_pmu.lbr_nr),
+			    cpu_lbr_stack(cpuc));
 	intel_pmu_lbr_filter(cpuc, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 	cpuc->lbr_stack_live = false;
 }
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 733123fc4ffe..4269a47ee47e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1982,7 +1982,7 @@ void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc);
 
 void intel_pmu_drain_pebs_buffer(void);
 
-void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
+void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr, unsigned int lbr_nr);
 
 void intel_pebs_init(void);
 
-- 
2.34.1

