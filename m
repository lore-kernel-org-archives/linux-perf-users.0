Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7C4347BC9;
	Tue, 24 Mar 2026 00:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313205; cv=none; b=psw2nAG4hPW9guSU4Y1UfHDz5+OIzqwWM+jbC7VAR4hDu2NjNPXWfw/nF206le9/la+L3thKMMeAXOKojoQVYfGIWEimqskGG/gTXz9Fh62j5oLMcVXFdcur1cLkyDMo5OTrMiVGP/SwxfrqnWAerXQS0crKX9plW9kKUzhsYog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313205; c=relaxed/simple;
	bh=9z2p/meVfGGS6GXkuTEUiRK3VDy1nKu6DCXfAZ/AUlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OnO5VWX8wPjFEA36Gr9O4vqz3gpBa6UVyc8vJqTTflPGzpvW7yzHh5iXUv6R+PnR8HodmRiPNW75YWHQkutWdpAz/6TgkGDJjLyXbgXMuFImq9ZkTJZTb+ol3izBccGeEgkjkXD1dya38HNzULsVb7kXyK3hxNPAJdXont1WH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggycG7C7; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggycG7C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313203; x=1805849203;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9z2p/meVfGGS6GXkuTEUiRK3VDy1nKu6DCXfAZ/AUlA=;
  b=ggycG7C7E4RzbJOOfkvFbEfpCAoH1PFr+Qh+1UHhpgLgbR4CuUWMpLLF
   NKaLu9eELDVxwYj5mnQGwsyWN4bbJUdE1mHfSD/vIY+l43thqocaS/NuW
   Pxk8eJnRMeuZIrml6NIyT5e0sxWTYNHqbt2q2Wah6c75SCJXyMkKTEELW
   HihaFjzIk32y6TlBA0xCJf/7mxYXwA7fn7VEJocVKKFjPFtldHqGvxxdH
   Qmg7EdjWcvQr+LqrZ4D4X0mRpybjq+RMx9GS9p5PBrxdFEvvS2KxG55bH
   efZvMD32veim1i40MOW8NV/Ub8fnsOxEu2JThXBpeK9CqkHi3qCS3qJ+f
   g==;
X-CSE-ConnectionGUID: //mg4bWXS9yNbBkTxMu51A==
X-CSE-MsgGUID: d9rJxgLhSGq1k6HkUdS7BA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397119"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397119"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:43 -0700
X-CSE-ConnectionGUID: 17L2CAGTRoiFK2DbV39q/Q==
X-CSE-MsgGUID: zpcKFWxgRq6u251zl2iDyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322792"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:38 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [Patch v7 11/24] perf/x86: Enable XMM Register Sampling for Non-PEBS Events
Date: Tue, 24 Mar 2026 08:41:05 +0800
Message-Id: <20260324004118.3772171-12-dapeng1.mi@linux.intel.com>
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

Previously, XMM register sampling was only available for PEBS events
starting from Icelake. Currently the support is now extended to non-PEBS
events by utilizing the xsaves instruction, thereby completing the
feature set.

To implement this, a 64-byte aligned buffer is required. A per-CPU
ext_regs_buf is introduced to store SIMD and other registers, with an
approximate size of 2K. The buffer is allocated using kzalloc_node(),
ensuring natural and 64-byte alignment for all kmalloc() allocations
with powers of 2.

XMM sampling for non-PEBS events is supported in the REGS_INTR case.
Support for REGS_USER will be added in a subsequent patch. For PEBS
events, XMM register sampling data is directly retrieved from PEBS
records.

Future support for additional vector registers (YMM/ZMM/OPMASK) is
planned. An `ext_regs_mask` is added to track the supported vector
register groups.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V7: Optimize and simplify x86_pmu_sample_xregs(), etc. No functional
change.

 arch/x86/events/core.c            | 139 +++++++++++++++++++++++++++---
 arch/x86/events/intel/core.c      |  31 ++++++-
 arch/x86/events/intel/ds.c        |  20 +++--
 arch/x86/events/perf_event.h      |  11 ++-
 arch/x86/include/asm/fpu/xstate.h |   2 +
 arch/x86/include/asm/perf_event.h |   5 +-
 arch/x86/kernel/fpu/xstate.c      |   2 +-
 7 files changed, 185 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0a6c51e86e9b..22965a8a22b3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -410,6 +410,45 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 	return x86_pmu_extra_regs(val, event);
 }
 
+static DEFINE_PER_CPU(struct xregs_state *, ext_regs_buf);
+
+static void release_ext_regs_buffers(void)
+{
+	int cpu;
+
+	if (!x86_pmu.ext_regs_mask)
+		return;
+
+	for_each_possible_cpu(cpu) {
+		kfree(per_cpu(ext_regs_buf, cpu));
+		per_cpu(ext_regs_buf, cpu) = NULL;
+	}
+}
+
+static void reserve_ext_regs_buffers(void)
+{
+	bool compacted = cpu_feature_enabled(X86_FEATURE_XCOMPACTED);
+	unsigned int size;
+	int cpu;
+
+	if (!x86_pmu.ext_regs_mask)
+		return;
+
+	size = xstate_calculate_size(x86_pmu.ext_regs_mask, compacted);
+
+	for_each_possible_cpu(cpu) {
+		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
+							  cpu_to_node(cpu));
+		if (!per_cpu(ext_regs_buf, cpu))
+			goto err;
+	}
+
+	return;
+
+err:
+	release_ext_regs_buffers();
+}
+
 int x86_reserve_hardware(void)
 {
 	int err = 0;
@@ -422,6 +461,7 @@ int x86_reserve_hardware(void)
 			} else {
 				reserve_ds_buffers();
 				reserve_lbr_buffers();
+				reserve_ext_regs_buffers();
 			}
 		}
 		if (!err)
@@ -438,6 +478,7 @@ void x86_release_hardware(void)
 		release_pmc_hardware();
 		release_ds_buffers();
 		release_lbr_buffers();
+		release_ext_regs_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
@@ -655,18 +696,23 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
-		return -EINVAL;
-	/*
-	 * Besides the general purpose registers, XMM registers may
-	 * be collected in PEBS on some platforms, e.g. Icelake
-	 */
-	if (unlikely(event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)) {
-		if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
-			return -EINVAL;
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+		/*
+		 * Besides the general purpose registers, XMM registers may
+		 * be collected as well.
+		 */
+		if (event_has_extended_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+				return -EINVAL;
+		}
+	}
 
-		if (!event->attr.precise_ip)
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
+		/*
+		 * Currently XMM registers sampling for REGS_USER is not
+		 * supported yet.
+		 */
+		if (event_has_extended_regs(event))
 			return -EINVAL;
 	}
 
@@ -1699,9 +1745,9 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
-void x86_pmu_setup_regs_data(struct perf_event *event,
-			     struct perf_sample_data *data,
-			     struct pt_regs *regs)
+static void x86_pmu_setup_gpregs_data(struct perf_event *event,
+				      struct perf_sample_data *data,
+				      struct pt_regs *regs)
 {
 	struct perf_event_attr *attr = &event->attr;
 	u64 sample_type = attr->sample_type;
@@ -1732,6 +1778,71 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 	}
 }
 
+inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	perf_regs->xmm_regs = NULL;
+}
+
+static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
+					struct xregs_state *xsave, u64 bitmap)
+{
+	u64 mask;
+
+	if (!xsave)
+		return;
+
+	/* Filtered by what XSAVE really gives */
+	mask = bitmap & xsave->header.xfeatures;
+
+	if (mask & XFEATURE_MASK_SSE)
+		perf_regs->xmm_space = xsave->i387.xmm_space;
+}
+
+static void x86_pmu_sample_xregs(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 u64 ignore_mask)
+{
+	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
+	u64 sample_type = event->attr.sample_type;
+	struct x86_perf_regs *perf_regs;
+	u64 intr_mask = 0;
+	u64 mask = 0;
+
+	if (WARN_ON_ONCE(!xsave))
+		return;
+
+	if (event_has_extended_regs(event))
+		mask |= XFEATURE_MASK_SSE;
+
+	mask &= x86_pmu.ext_regs_mask;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.abi)
+		intr_mask = mask & ~ignore_mask;
+
+	if (intr_mask) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		xsave->header.xfeatures = 0;
+		xsaves_nmi(xsave, mask);
+		x86_pmu_update_xregs(perf_regs, xsave, intr_mask);
+	}
+}
+
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs,
+			     u64 ignore_mask)
+{
+	x86_pmu_setup_gpregs_data(event, data, regs);
+	/*
+	 * ignore_mask indicates the PEBS sampled extended regs
+	 * which are unnecessary to sample again.
+	 */
+	x86_pmu_sample_xregs(event, data, ignore_mask);
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5a2b1503b6a5..5772dcc3bcbd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3649,6 +3649,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
+		x86_pmu_clear_perf_regs(regs);
+		x86_pmu_setup_regs_data(event, &data, regs, 0);
+
 		perf_event_overflow(event, &data, regs);
 	}
 
@@ -5884,8 +5887,32 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
 	}
 }
 
-#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
+static void intel_extended_regs_init(struct pmu *pmu)
+{
+	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
+
+	/*
+	 * Extend the vector registers support to non-PEBS.
+	 * The feature is limited to newer Intel machines with
+	 * PEBS V4+ or archPerfmonExt (0x23) enabled for now.
+	 * In theory, the vector registers can be retrieved as
+	 * long as the CPU supports. The support for the old
+	 * generations may be added later if there is a
+	 * requirement.
+	 * Only support the extension when XSAVES is available.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_XSAVES))
+		return;
+
+	if (!boot_cpu_has(X86_FEATURE_XMM) ||
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
+		return;
 
+	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
+	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+}
+
+#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -5949,6 +5976,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
+
+	intel_extended_regs_init(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index b045297c02d0..74a41dae8a62 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1743,8 +1743,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2460,10 +2459,8 @@ static inline void __setup_pebs_gpr_group(struct perf_event *event,
 		regs->flags &= ~PERF_EFLAGS_EXACT;
 	}
 
-	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
+	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 		adaptive_pebs_save_regs(regs, gprs);
-		x86_pmu_setup_regs_data(event, data, regs);
-	}
 }
 
 static inline void __setup_pebs_meminfo_group(struct perf_event *event,
@@ -2521,6 +2518,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	struct pebs_meminfo *meminfo = NULL;
 	struct pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 ignore_mask = 0;
 	u64 format_group;
 	u16 retire;
 
@@ -2528,7 +2526,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	format_group = basic->format_group;
 
@@ -2575,6 +2573,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	if (format_group & PEBS_DATACFG_XMMS) {
 		struct pebs_xmm *xmm = next_record;
 
+		ignore_mask |= XFEATURE_MASK_SSE;
 		next_record = xmm + 1;
 		perf_regs->xmm_regs = xmm->xmm;
 	}
@@ -2613,6 +2612,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		next_record += nr * sizeof(u64);
 	}
 
+	x86_pmu_setup_regs_data(event, data, regs, ignore_mask);
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2638,6 +2639,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	struct arch_pebs_aux *meminfo = NULL;
 	struct arch_pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 ignore_mask = 0;
 	void *next_record;
 	void *at = __pebs;
 
@@ -2645,7 +2647,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2700,6 +2702,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		next_record += sizeof(struct arch_pebs_xer_header);
 
+		ignore_mask |= XFEATURE_MASK_SSE;
 		xmm = next_record;
 		perf_regs->xmm_regs = xmm->xmm;
 		next_record = xmm + 1;
@@ -2747,6 +2750,8 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		at = at + header->size;
 		goto again;
 	}
+
+	x86_pmu_setup_regs_data(event, data, regs, ignore_mask);
 }
 
 static inline void *
@@ -3409,6 +3414,7 @@ static void __init intel_ds_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
+				x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 39c41947c70d..a5e5bffb711e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1020,6 +1020,12 @@ struct x86_pmu {
 	struct extra_reg *extra_regs;
 	unsigned int flags;
 
+	/*
+	 * Extended regs, e.g., vector registers
+	 * Utilize the same format as the XFEATURE_MASK_*
+	 */
+	u64		ext_regs_mask;
+
 	/*
 	 * Intel host/guest support (KVM)
 	 */
@@ -1306,9 +1312,12 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_clear_perf_regs(struct pt_regs *regs);
+
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
-			     struct pt_regs *regs);
+			     struct pt_regs *regs,
+			     u64 ignore_mask);
 
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 38fa8ff26559..19dec5f0b1c7 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -112,6 +112,8 @@ void xsaves(struct xregs_state *xsave, u64 mask);
 void xrstors(struct xregs_state *xsave, u64 mask);
 void xsaves_nmi(struct xregs_state *xsave, u64 mask);
 
+unsigned int xstate_calculate_size(u64 xfeatures, bool compacted);
+
 int xfd_enable_feature(u64 xfd_err);
 
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 752cb319d5ea..e47a963a7cf0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -726,7 +726,10 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
-	u64		*xmm_regs;
+	union {
+		u64	*xmm_regs;
+		u32	*xmm_space;	/* for xsaves */
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 39e5f9e79a4c..93631f7a638e 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -587,7 +587,7 @@ static bool __init check_xstate_against_struct(int nr)
 	return true;
 }
 
-static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
 	unsigned int offset, i;
-- 
2.34.1

