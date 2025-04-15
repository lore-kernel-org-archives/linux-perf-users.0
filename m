Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B840028469B;
	Tue, 15 Apr 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705428; cv=none; b=qzKFFDPIdBqlzAV0qKBK+tSa9v/FUl9cT6NsqLsrabBfotkvySHN8fNz++CpfReIzyEu7zBd+4eTQSkhIL+1IQmHgtVtV6Amiajm8szx9IhZ1y9pN9MIj+yF4+bffSHx6D1xHWYH66/KKBShNmHSqsd/keErYas5YWtfltChtVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705428; c=relaxed/simple;
	bh=MD6Ch380jgoWZZj3Q4YLRh4W6kcQ6jXtLsCcyCXXTjA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PF6cc40gFp+5rEgtCLgN2RFElEfnFmgQ+1o0uaPQjlBxOQ+Z0OhJ4PtxjY41lMwGCRNL3RkGmN3/tXT9NO229IWNd++0qa2S/EZa5noTMUfqE2PyDT/PBvbDD7N82HTnYMtb9vWKWFp0rkrp/zPKyhYF15VKjRU0yPNvrteRDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JtLTFiei; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JtLTFiei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705427; x=1776241427;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MD6Ch380jgoWZZj3Q4YLRh4W6kcQ6jXtLsCcyCXXTjA=;
  b=JtLTFieiCYWa74y92Df378744ovm+Ry+MhZxfnHxCHEE1ilGwHOlE3jq
   SVG1IGiIUQgKF1FJm7sMgTDbxtqklxhqmfOVyESBEDk+/E9vCCnjtuY1T
   kJH9aC3JB4eL9dUruutyvBufmO64yBGjbGwrcA5LdrBSwc93LTObWzmHq
   7G9jluNtV+UGtGymezJn/UHu8QD6CDxhOHal3DUyX9bmZ4PzQ67wGHz9E
   k4+17t8Ie65qhRdqzFn2cqsfd40e3jlNR2qbBeZElaOg/mHXIrojaHlzf
   kTGeJBPqsvoG6kzZ7gOMPAFsAk0ZEUmqg5OrykCTdmwnjBCbiLbkZL8w2
   Q==;
X-CSE-ConnectionGUID: cfYPtfKYSqOX44FYPY2TeA==
X-CSE-MsgGUID: Oi/vAg8YTwmeEUwkpxajIw==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46115978"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46115978"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:23:47 -0700
X-CSE-ConnectionGUID: SYTPN5ZpRAeZNLm+NkYAJQ==
X-CSE-MsgGUID: q7zIDoJgSEeHQw8/z9hlrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055601"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:23:43 -0700
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
Subject: [Patch v3 10/22] perf/x86/intel: Process arch-PEBS records or record fragments
Date: Tue, 15 Apr 2025 11:44:16 +0000
Message-Id: <20250415114428.341182-11-dapeng1.mi@linux.intel.com>
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

A significant difference with adaptive PEBS is that arch-PEBS record
supports fragments which means an arch-PEBS record could be split into
several independent fragments which have its own arch-PEBS header in
each fragment.

This patch defines architectural PEBS record layout structures and add
helpers to process arch-PEBS records or fragments. Only legacy PEBS
groups like basic, GPR, XMM and LBR groups are supported in this patch,
the new added YMM/ZMM/OPMASK vector registers capturing would be
supported in subsequent patches.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      |  15 ++-
 arch/x86/events/intel/ds.c        | 180 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h  |   6 +
 arch/x86/include/asm/perf_event.h | 100 +++++++++++++++++
 4 files changed, 300 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 09e2a23f9bcc..0f911e974e02 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3216,6 +3216,19 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
 	}
 
+	/*
+	 * Arch PEBS sets bit 54 in the global status register
+	 */
+	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
+				 (unsigned long *)&status)) {
+		handled++;
+		static_call(x86_pmu_drain_pebs)(regs, &data);
+
+		if (cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS] &&
+		    is_pebs_counter_event_group(cpuc->events[INTEL_PMC_IDX_FIXED_SLOTS]))
+			status &= ~GLOBAL_STATUS_PERF_METRICS_OVF_BIT;
+	}
+
 	/*
 	 * Intel PT
 	 */
@@ -3270,7 +3283,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		last_period = event->hw.last_period;
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 6c872bf2e916..ed0bccb04b95 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2272,6 +2272,114 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			format_group);
 }
 
+static inline bool arch_pebs_record_continued(struct arch_pebs_header *header)
+{
+	/* Continue bit or null PEBS record indicates fragment follows. */
+	return header->cont || !(header->format & GENMASK_ULL(63, 16));
+}
+
+static void setup_arch_pebs_sample_data(struct perf_event *event,
+					struct pt_regs *iregs, void *__pebs,
+					struct perf_sample_data *data,
+					struct pt_regs *regs)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	u64 sample_type = event->attr.sample_type;
+	struct arch_pebs_header *header = NULL;
+	struct arch_pebs_aux *meminfo = NULL;
+	struct arch_pebs_gprs *gprs = NULL;
+	struct x86_perf_regs *perf_regs;
+	void *next_record;
+	void *at = __pebs;
+
+	if (at == NULL)
+		return;
+
+	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	perf_regs->xmm_regs = NULL;
+
+	__setup_perf_sample_data(event, iregs, data);
+
+	*regs = *iregs;
+
+again:
+	header = at;
+	next_record = at + sizeof(struct arch_pebs_header);
+	if (header->basic) {
+		struct arch_pebs_basic *basic = next_record;
+		u16 retire = 0;
+
+		next_record = basic + 1;
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
+			retire = basic->valid ? basic->retire : 0;
+		__setup_pebs_basic_group(event, regs, data, sample_type,
+				 basic->ip, basic->tsc, retire);
+	}
+
+	/*
+	 * The record for MEMINFO is in front of GP
+	 * But PERF_SAMPLE_TRANSACTION needs gprs->ax.
+	 * Save the pointer here but process later.
+	 */
+	if (header->aux) {
+		meminfo = next_record;
+		next_record = meminfo + 1;
+	}
+
+	if (header->gpr) {
+		gprs = next_record;
+		next_record = gprs + 1;
+
+		__setup_pebs_gpr_group(event, regs, (struct pebs_gprs *)gprs,
+				       sample_type);
+	}
+
+	if (header->aux) {
+		u64 ax = gprs ? gprs->ax : 0;
+
+		__setup_pebs_meminfo_group(event, data, sample_type,
+					   meminfo->cache_latency,
+					   meminfo->instr_latency,
+					   meminfo->address, meminfo->aux,
+					   meminfo->tsx_tuning, ax);
+	}
+
+	if (header->xmm) {
+		struct arch_pebs_xmm *xmm;
+
+		next_record += sizeof(struct arch_pebs_xer_header);
+
+		xmm = next_record;
+		perf_regs->xmm_regs = xmm->xmm;
+		next_record = xmm + 1;
+	}
+
+	if (header->lbr) {
+		struct arch_pebs_lbr_header *lbr_header = next_record;
+		struct lbr_entry *lbr;
+		int num_lbr;
+
+		next_record = lbr_header + 1;
+		lbr = next_record;
+
+		num_lbr = header->lbr == ARCH_PEBS_LBR_NUM_VAR ? lbr_header->depth :
+					 header->lbr * ARCH_PEBS_BASE_LBR_ENTRIES;
+		next_record += num_lbr * sizeof(struct lbr_entry);
+
+		if (has_branch_stack(event)) {
+			intel_pmu_store_pebs_lbrs(lbr);
+			intel_pmu_lbr_save_brstack(data, cpuc, event);
+		}
+	}
+
+	/* Parse followed fragments if there are. */
+	if (arch_pebs_record_continued(header)) {
+		at = at + header->size;
+		goto again;
+	}
+}
+
 static inline void *
 get_next_pebs_record_by_bit(void *base, void *top, int bit)
 {
@@ -2735,6 +2843,77 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 					    setup_pebs_adaptive_sample_data);
 }
 
+static void intel_pmu_drain_arch_pebs(struct pt_regs *iregs,
+				      struct perf_sample_data *data)
+{
+	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+	union arch_pebs_index index;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	void *base, *at, *top;
+	u64 mask;
+
+	rdmsrl(MSR_IA32_PEBS_INDEX, index.full);
+
+	if (unlikely(!index.split.wr)) {
+		intel_pmu_pebs_event_update_no_drain(cpuc, X86_PMC_IDX_MAX);
+		return;
+	}
+
+	base = cpuc->ds_pebs_vaddr;
+	top = (void *)((u64)cpuc->ds_pebs_vaddr +
+		       (index.split.wr << ARCH_PEBS_INDEX_WR_SHIFT));
+
+	mask = hybrid(cpuc->pmu, arch_pebs_cap).counters & cpuc->pebs_enabled;
+
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/* Process all but the last event for each counter. */
+	for (at = base; at < top;) {
+		struct arch_pebs_header *header;
+		struct arch_pebs_basic *basic;
+		u64 pebs_status;
+
+		header = at;
+
+		if (WARN_ON_ONCE(!header->size))
+			break;
+
+		/* 1st fragment or single record must have basic group */
+		if (!header->basic) {
+			at += header->size;
+			continue;
+		}
+
+		basic = at + sizeof(struct arch_pebs_header);
+		pebs_status = mask & basic->applicable_counters;
+		__intel_pmu_handle_pebs_record(iregs, regs, data, at,
+					       pebs_status, counts, last,
+					       setup_arch_pebs_sample_data);
+
+		/* Skip non-last fragments */
+		while (arch_pebs_record_continued(header)) {
+			if (!header->size)
+				break;
+			at += header->size;
+			header = at;
+		}
+
+		/* Skip last fragment or the single record */
+		at += header->size;
+	}
+
+	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask, counts,
+					    last, setup_arch_pebs_sample_data);
+
+	index.split.wr = 0;
+	index.split.full = 0;
+	wrmsrl(MSR_IA32_PEBS_INDEX, index.full);
+}
+
 static void __init intel_arch_pebs_init(void)
 {
 	/*
@@ -2744,6 +2923,7 @@ static void __init intel_arch_pebs_init(void)
 	 */
 	x86_pmu.arch_pebs = 1;
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
+	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 53da787b9326..d77048df8e72 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -314,6 +314,12 @@
 #define PERF_CAP_PEBS_MASK	(PERF_CAP_PEBS_TRAP | PERF_CAP_ARCH_REG | \
 				 PERF_CAP_PEBS_FORMAT | PERF_CAP_PEBS_BASELINE)
 
+/* Arch PEBS */
+#define MSR_IA32_PEBS_BASE		0x000003f4
+#define MSR_IA32_PEBS_INDEX		0x000003f5
+#define ARCH_PEBS_OFFSET_MASK		0x7fffff
+#define ARCH_PEBS_INDEX_WR_SHIFT	4
+
 #define MSR_IA32_RTIT_CTL		0x00000570
 #define RTIT_CTL_TRACEEN		BIT(0)
 #define RTIT_CTL_CYCLEACC		BIT(1)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 7fca9494aae9..7f9d8e6577f0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -433,6 +433,8 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		48
@@ -503,6 +505,104 @@ struct pebs_cntr_header {
 
 #define INTEL_CNTR_METRICS		0x3
 
+/*
+ * Arch PEBS
+ */
+union arch_pebs_index {
+	struct {
+		u64 rsvd:4,
+		    wr:23,
+		    rsvd2:4,
+		    full:1,
+		    en:1,
+		    rsvd3:3,
+		    thresh:23,
+		    rsvd4:5;
+	} split;
+	u64 full;
+};
+
+struct arch_pebs_header {
+	union {
+		u64 format;
+		struct {
+			u64 size:16,	/* Record size */
+			    rsvd:14,
+			    mode:1,	/* 64BIT_MODE */
+			    cont:1,
+			    rsvd2:3,
+			    cntr:5,
+			    lbr:2,
+			    rsvd3:7,
+			    xmm:1,
+			    ymmh:1,
+			    rsvd4:2,
+			    opmask:1,
+			    zmmh:1,
+			    h16zmm:1,
+			    rsvd5:5,
+			    gpr:1,
+			    aux:1,
+			    basic:1;
+		};
+	};
+	u64 rsvd6;
+};
+
+struct arch_pebs_basic {
+	u64 ip;
+	u64 applicable_counters;
+	u64 tsc;
+	u64 retire	:16,	/* Retire Latency */
+	    valid	:1,
+	    rsvd	:47;
+	u64 rsvd2;
+	u64 rsvd3;
+};
+
+struct arch_pebs_aux {
+	u64 address;
+	u64 rsvd;
+	u64 rsvd2;
+	u64 rsvd3;
+	u64 rsvd4;
+	u64 aux;
+	u64 instr_latency	:16,
+	    pad2		:16,
+	    cache_latency	:16,
+	    pad3		:16;
+	u64 tsx_tuning;
+};
+
+struct arch_pebs_gprs {
+	u64 flags, ip, ax, cx, dx, bx, sp, bp, si, di;
+	u64 r8, r9, r10, r11, r12, r13, r14, r15, ssp;
+	u64 rsvd;
+};
+
+struct arch_pebs_xer_header {
+	u64 xstate;
+	u64 rsvd;
+};
+
+struct arch_pebs_xmm {
+	u64 xmm[16*2];		/* two entries for each register */
+};
+
+#define ARCH_PEBS_LBR_NAN		0x0
+#define ARCH_PEBS_LBR_NUM_8		0x1
+#define ARCH_PEBS_LBR_NUM_16		0x2
+#define ARCH_PEBS_LBR_NUM_VAR		0x3
+#define ARCH_PEBS_BASE_LBR_ENTRIES	8
+struct arch_pebs_lbr_header {
+	u64 rsvd;
+	u64 ctl;
+	u64 depth;
+	u64 ler_from;
+	u64 ler_to;
+	u64 ler_info;
+};
+
 /*
  * AMD Extended Performance Monitoring and Debug cpuid feature detection
  */
-- 
2.40.1

