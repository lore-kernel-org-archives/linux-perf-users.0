Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD53ACF1E;
	Fri, 29 May 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041809; cv=none; b=PBjFjiteZjRtMW9/ahh1vLJY4/jB/jsZYAg7hcPJuSVmwcKkzVJLhL4AVdbZZkbDb4AdD0+LpYBVFKvRVJdbXvn2HnpFXiRWQjxQ77YXabiKeIm2S2V2ArQSQfi+Gpgxs6rIgZ1P7f9jgjW8DiRFlzRxtczcoq+CFOjN+MKxhbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041809; c=relaxed/simple;
	bh=iwKXwAGrV1yvP2eoGd3UgKQ1x/hGBjKKhT57vhLMLRo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YRdI75xoqspKVLTuUozfr3YPMVY3r3eDdQAmhqVUp4+SLkdlx+eep1kbJXXJuTxnTLs6RkhsqVWLHOJH5jF1osxBau2WLLaIppm356Y2FdxhoMzIfht5a3f1s/lp6cI3wJEJkaV0O5rlcNUSJmXubF3IO0WlgHorgcV6AFVnW6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ByNX6/re; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ByNX6/re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041808; x=1811577808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwKXwAGrV1yvP2eoGd3UgKQ1x/hGBjKKhT57vhLMLRo=;
  b=ByNX6/re9al9PuP0r1W40nBmgBCyURFfGmfsg2EOoFoTcT+NzzS2kIpA
   7qGP6Omlcg2GKddlYRgndV5LVerxVQG6s+ptUeK/Uy2MasqNfvGtzvtQl
   NTlOzWF4oZ3TJ/REBeoyUtPzHsRn6mDYEkzcjlt9mBWkCrpMp9H5Hvus7
   wZY4Qoo+M641FOiFICdZfiQgeBbx9FDJ3+kQOKBhKJ1xCNhZkafWawjyK
   bx9zJWoVtKvkffnJB+sFqK8ghrvT2xqe2gTA5HybI0xdr21N0F5JJ9g13
   LX/2tTxVa2D9VnaAEUi2GyibeN/g9+PS2rrsns6gebgX3HvMJs1yA2v3f
   g==;
X-CSE-ConnectionGUID: +Hhop1LFTGmxH/pwpVWFjw==
X-CSE-MsgGUID: CpElpEufTn2OrV880Qq/Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341970"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341970"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:27 -0700
X-CSE-ConnectionGUID: i1JGtnOfRQ2QYWOoW9VQzA==
X-CSE-MsgGUID: uSi5ZjqpR1KolpzmSKSe/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802220"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:20 -0700
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
Subject: [Patch v8 10/23] perf/x86: Enable XMM Register Sampling for Non-PEBS Events
Date: Fri, 29 May 2026 15:56:32 +0800
Message-Id: <20260529075645.580362-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c            | 181 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/core.c      |  36 +++++-
 arch/x86/events/intel/ds.c        |  18 ++-
 arch/x86/events/perf_event.h      |  13 +++
 arch/x86/include/asm/fpu/xstate.h |   2 +
 arch/x86/include/asm/perf_event.h |   5 +-
 arch/x86/kernel/fpu/xstate.c      |   2 +-
 7 files changed, 240 insertions(+), 17 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 17c8f44ee43b..c219a563434d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -410,6 +410,56 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
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
+	/* +64 bytes for the 64 bytes alignment request of xsave area. */
+	size = xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) + 64;
+
+	for_each_possible_cpu(cpu) {
+		per_cpu(ext_regs_buf, cpu) = kzalloc_node(size, GFP_KERNEL,
+							  cpu_to_node(cpu));
+		if (WARN_ON_ONCE(!per_cpu(ext_regs_buf, cpu)))
+			goto err;
+	}
+
+	return;
+
+err:
+	release_ext_regs_buffers();
+}
+
+static inline struct xregs_state *get_ext_regs_buf(int cpu)
+{
+	void *buf = per_cpu(ext_regs_buf, cpu);
+	struct xregs_state *xsave;
+
+	xsave = buf ? PTR_ALIGN(buf, 64) : NULL;
+
+	return xsave;
+}
+
 int x86_reserve_hardware(void)
 {
 	int err = 0;
@@ -422,6 +472,7 @@ int x86_reserve_hardware(void)
 			} else {
 				reserve_ds_buffers();
 				reserve_lbr_buffers();
+				reserve_ext_regs_buffers();
 			}
 		}
 		if (!err)
@@ -438,6 +489,7 @@ void x86_release_hardware(void)
 		release_pmc_hardware();
 		release_ds_buffers();
 		release_lbr_buffers();
+		release_ext_regs_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
@@ -655,18 +707,26 @@ int x86_pmu_hw_config(struct perf_event *event)
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
+		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+				return -EINVAL;
+			if (is_sampling_event(event) && !event->attr.precise_ip &&
+			    !this_cpu_has(X86_FEATURE_XSAVES))
+				return -EINVAL;
+		}
+	}
 
-		if (!event->attr.precise_ip)
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
+		/*
+		 * Currently XMM registers sampling for REGS_USER is not
+		 * supported yet.
+		 */
+		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
 			return -EINVAL;
 	}
 
@@ -1705,6 +1765,105 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+void x86_pmu_clear_perf_regs(struct pt_regs *regs)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	perf_regs->xmm_regs = NULL;
+}
+
+static void update_perf_regs(struct x86_perf_regs *perf_regs,
+			     struct xregs_state *xsave, u64 bitmap)
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
+/*
+ * The x86 specific variant of perf_sample_regs_intr().
+ * It would be extended to add more SIMD registers sampling support
+ * in later patches.
+ */
+static void x86_pmu_update_regs_intr(struct perf_event *event,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	data->regs_intr.regs = regs;
+	data->regs_intr.abi  = perf_reg_abi(current);
+
+	data->dyn_size += sizeof(u64);
+	if (data->regs_intr.regs) {
+		data->dyn_size += hweight64(event->attr.sample_regs_intr) *
+				  sizeof(u64);
+	}
+
+	/*
+	 * Set PERF_SAMPLE_REGS_INTR to bypass perf_sample_regs_intr() call
+	 * in perf_prepare_sample() function.
+	 */
+	data->sample_flags |= PERF_SAMPLE_REGS_INTR;
+}
+
+static void x86_pmu_sample_xregs(struct perf_event *event,
+				 struct perf_sample_data *data,
+				 u64 ignore_mask)
+{
+	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
+	u64 sample_type = event->attr.sample_type;
+	struct x86_perf_regs *perf_regs;
+	u64 intr_mask = 0;
+	u64 mask = 0;
+
+	if (WARN_ON_ONCE(!xsave) || !in_nmi())
+		return;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	    (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK))
+		mask |= XFEATURE_MASK_SSE;
+
+	mask &= x86_pmu.ext_regs_mask;
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR)
+		intr_mask = mask & ~ignore_mask;
+
+	if (intr_mask) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		xsave->header.xfeatures = 0;
+		xsaves_nmi(xsave, mask);
+		update_perf_regs(perf_regs, xsave, intr_mask);
+	}
+}
+
+void x86_pmu_update_perf_regs(struct perf_event *event,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs,
+			      u64 ignore_mask)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	if (!((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	      (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)))
+		return;
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR)
+		x86_pmu_update_regs_intr(event, data, regs);
+
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
index 92cb9a716e83..f5d458e3ba3f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3928,6 +3928,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
+		x86_pmu_clear_perf_regs(regs);
+		x86_pmu_update_perf_regs(event, &data, regs, 0);
+
 		perf_event_overflow(event, &data, regs);
 	}
 
@@ -6176,8 +6179,37 @@ static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
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
 
+	if (!boot_cpu_has(X86_FEATURE_XMM) ||
+	    !cpu_has_xfeatures(XFEATURE_MASK_SSE, NULL))
+		return;
+
+	/*
+	 * On current hybrid platforms, P-cores and E-cores expose the same
+	 * XSAVE feature set. Therefore, using the global x86_pmu.ext_regs_mask
+	 * is sufficient to represent the hardware-supported XSAVE features.
+	 */
+	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
+	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+}
+
+#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int eax, ebx, ecx, edx;
@@ -6241,6 +6273,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
+
+	intel_extended_regs_init(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index a31648d2adb1..4f72ce6a9585 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2524,6 +2524,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	struct pebs_meminfo *meminfo = NULL;
 	struct pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 ignore_mask = 0;
 	u64 format_group;
 	u16 retire;
 
@@ -2531,7 +2532,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	format_group = basic->format_group;
 
@@ -2578,6 +2579,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	if (format_group & PEBS_DATACFG_XMMS) {
 		struct pebs_xmm *xmm = next_record;
 
+		ignore_mask |= XFEATURE_MASK_SSE;
 		next_record = xmm + 1;
 		perf_regs->xmm_regs = xmm->xmm;
 	}
@@ -2616,6 +2618,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		next_record += nr * sizeof(u64);
 	}
 
+	x86_pmu_update_perf_regs(event, data, regs, ignore_mask);
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2641,6 +2645,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	struct arch_pebs_aux *meminfo = NULL;
 	struct arch_pebs_gprs *gprs = NULL;
 	struct x86_perf_regs *perf_regs;
+	u64 ignore_mask = 0;
 	void *next_record;
 	void *at = __pebs;
 
@@ -2648,7 +2653,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2703,6 +2708,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 		next_record += sizeof(struct arch_pebs_xer_header);
 
+		ignore_mask |= XFEATURE_MASK_SSE;
 		xmm = next_record;
 		perf_regs->xmm_regs = xmm->xmm;
 		next_record = xmm + 1;
@@ -2750,6 +2756,8 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		at = at + header->size;
 		goto again;
 	}
+
+	x86_pmu_update_perf_regs(event, data, regs, ignore_mask);
 }
 
 static inline void *
@@ -3412,7 +3420,11 @@ static void __init intel_ds_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
-				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+				if (boot_cpu_has(X86_FEATURE_XSAVES)) {
+					x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
+					x86_get_pmu(smp_processor_id())->capabilities |=
+							PERF_PMU_CAP_EXTENDED_REGS;
+				}
 			} else {
 				/* Only basic record supported */
 				x86_pmu.large_pebs_flags &=
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index eae24bb35dc1..cff5fbac000b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1028,6 +1028,12 @@ struct x86_pmu {
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
@@ -1314,6 +1320,13 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_clear_perf_regs(struct pt_regs *regs);
+
+void x86_pmu_update_perf_regs(struct perf_event *event,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs,
+			      u64 ignore_mask);
+
 void x86_pmu_show_pmu_cap(struct pmu *pmu);
 
 static inline int x86_pmu_num_counters(struct pmu *pmu)
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
index 4394091c4791..4cef802c2e02 100644
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

