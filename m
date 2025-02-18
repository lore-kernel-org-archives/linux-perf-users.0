Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDA3232368;
	Tue, 18 Feb 2025 08:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866464; cv=none; b=Ve2UPtqQoEV2FoZWA4Eo9me7LtPOUF+0NWzO5+fLFKFZ635JaWTbw3KwSgJtbhr6gwkZ95Y4iR2pAWVkNXb4I7TmL/bcK9Nt7VtDto5HcUqCvpCtERLVl/fQAXf4tgSrcKsJzn59MJBi/lqyVGo52iU8r2rDw2ePDzkXJ3agYqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866464; c=relaxed/simple;
	bh=xQJEpweseMPj3YwO7pKFvHAPuemB+0y1/CSlui6Yliw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dj/yhIbtPI6cF7iuqlP8v+bgSkESS6vkpALFaiqJS9SKhaZMa9A5rtomjkKQV99TigCujyCHXHABPPBBPIDtgUKRrdiOigi8PLyymYarc0LuIhBg+LiFgCw7es0PFju2cR/mBLwVOakHYm1vGAVG8S3oUDBdJKf+n3ix2V1LH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Di7+9aZu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Di7+9aZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866464; x=1771402464;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xQJEpweseMPj3YwO7pKFvHAPuemB+0y1/CSlui6Yliw=;
  b=Di7+9aZuGeadhwhj644XvHNhIsSj7ftZzT3C2NV8n51CbD8cP4njzNe3
   uGf65DU+4CJrCxFjdwrFQxbdNfYd7ZpsoRvWH+g+Q8xOlH+yGz1wra/jx
   2+1VGqhk3tkzEHHKznHVyaPPuYEqb9G7NzYJ6F621r78YcbCHeAg5IImr
   TDzDiCuFzs4UkdKNekVhYnJ/ktsfQABabC/z/6qqIeE5oliDolRMNjCAX
   06nmpDg9RTEVBTPb5RyqsqlTNbjL6sfUYRlN3D8t03Yu8RTbBmEjgN1ax
   qIkL+x67MStPnDPbbqVjmABLEo78SCT6cwvpvf1L8hvA2cHOigoHZxPfb
   w==;
X-CSE-ConnectionGUID: Iw821hbnSFq7MSIIkMxxIg==
X-CSE-MsgGUID: LBS3x1s0RBGY/LHTAmUgpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200796"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200796"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:23 -0800
X-CSE-ConnectionGUID: uaSFIhMLSLGZ3EtFCrz67g==
X-CSE-MsgGUID: Mho5E98RSteG8I5IRGiYcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166218"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:18 -0800
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
Subject: [Patch v2 10/24] perf/x86/intel: Process arch-PEBS records or record fragments
Date: Tue, 18 Feb 2025 15:28:04 +0000
Message-Id: <20250218152818.158614-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/core.c      |   9 ++
 arch/x86/events/intel/ds.c        | 219 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/msr-index.h  |   6 +
 arch/x86/include/asm/perf_event.h | 100 ++++++++++++++
 4 files changed, 334 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 37540eb80029..184f69afde08 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3124,6 +3124,15 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 			wrmsrl(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
 	}
 
+	/*
+	 * Arch PEBS sets bit 54 in the global status register
+	 */
+	if (__test_and_clear_bit(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT,
+				 (unsigned long *)&status)) {
+		handled++;
+		x86_pmu.drain_pebs(regs, &data);
+	}
+
 	/*
 	 * Intel PT
 	 */
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 94865745e997..f3c0e509c531 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2229,6 +2229,153 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
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
+	struct arch_pebs_header *header = NULL;
+	struct arch_pebs_aux *meminfo = NULL;
+	struct arch_pebs_gprs *gprs = NULL;
+	struct x86_perf_regs *perf_regs;
+	void *next_record;
+	void *at = __pebs;
+	u64 sample_type;
+
+	if (at == NULL)
+		return;
+
+	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	perf_regs->xmm_regs = NULL;
+
+	sample_type = event->attr.sample_type;
+	perf_sample_data_init(data, 0, event->hw.last_period);
+	data->period = event->hw.last_period;
+
+	/*
+	 * We must however always use iregs for the unwinder to stay sane; the
+	 * record BP,SP,IP can point into thin air when the record is from a
+	 * previous PMI context or an (I)RET happened between the record and
+	 * PMI.
+	 */
+	if (sample_type & PERF_SAMPLE_CALLCHAIN)
+		perf_sample_save_callchain(data, event, iregs);
+
+	*regs = *iregs;
+
+again:
+	header = at;
+	next_record = at + sizeof(struct arch_pebs_header);
+	if (header->basic) {
+		struct arch_pebs_basic *basic = next_record;
+
+		/* The ip in basic is EventingIP */
+		set_linear_ip(regs, basic->ip);
+		regs->flags = PERF_EFLAGS_EXACT;
+		setup_pebs_time(event, data, basic->tsc);
+
+		if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT)
+			data->weight.var3_w = basic->valid ? basic->retire : 0;
+
+		next_record = basic + 1;
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
+		if (event->attr.precise_ip < 2) {
+			set_linear_ip(regs, gprs->ip);
+			regs->flags &= ~PERF_EFLAGS_EXACT;
+		}
+
+		if (sample_type & PERF_SAMPLE_REGS_INTR)
+			adaptive_pebs_save_regs(regs, (struct pebs_gprs *)gprs);
+	}
+
+	if (header->aux) {
+		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE) {
+			u16 latency = meminfo->cache_latency;
+			u64 tsx_latency = intel_get_tsx_weight(meminfo->tsx_tuning);
+
+			data->weight.var2_w = meminfo->instr_latency;
+
+			if (sample_type & PERF_SAMPLE_WEIGHT)
+				data->weight.full = latency ?: tsx_latency;
+			else
+				data->weight.var1_dw = latency ?: (u32)tsx_latency;
+			data->sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
+		}
+
+		if (sample_type & PERF_SAMPLE_DATA_SRC) {
+			data->data_src.val = get_data_src(event, meminfo->aux);
+			data->sample_flags |= PERF_SAMPLE_DATA_SRC;
+		}
+
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE) {
+			data->addr = meminfo->address;
+			data->sample_flags |= PERF_SAMPLE_ADDR;
+		}
+
+		if (sample_type & PERF_SAMPLE_TRANSACTION) {
+			data->txn = intel_get_tsx_transaction(meminfo->tsx_tuning,
+							  gprs ? gprs->ax : 0);
+			data->sample_flags |= PERF_SAMPLE_TRANSACTION;
+		}
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
@@ -2692,6 +2839,77 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
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
@@ -2701,6 +2919,7 @@ static void __init intel_arch_pebs_init(void)
 	 */
 	x86_pmu.arch_pebs = 1;
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
+	x86_pmu.drain_pebs = intel_pmu_drain_arch_pebs;
 	x86_pmu.pebs_capable = ~0ULL;
 
 	x86_pmu.pebs_enable = __intel_pmu_pebs_enable;
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 9a71880eec07..dd09ae9752a7 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -312,6 +312,12 @@
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
index 4f0c01610175..4103cc745e86 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -432,6 +432,8 @@ static inline bool is_topdown_idx(int idx)
 #define GLOBAL_STATUS_LBRS_FROZEN		BIT_ULL(GLOBAL_STATUS_LBRS_FROZEN_BIT)
 #define GLOBAL_STATUS_TRACE_TOPAPMI_BIT		55
 #define GLOBAL_STATUS_TRACE_TOPAPMI		BIT_ULL(GLOBAL_STATUS_TRACE_TOPAPMI_BIT)
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT	54
+#define GLOBAL_STATUS_ARCH_PEBS_THRESHOLD	BIT_ULL(GLOBAL_STATUS_ARCH_PEBS_THRESHOLD_BIT)
 #define GLOBAL_STATUS_PERF_METRICS_OVF_BIT	48
 
 #define GLOBAL_CTRL_EN_PERF_METRICS		48
@@ -502,6 +504,104 @@ struct pebs_cntr_header {
 
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

