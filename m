Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4D3AE712;
	Mon, 24 Aug 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560503; cv=none; b=BhYIQusElexjgU0u9PZloMp8C4cqJMZjvaP0ph87aNa7t3t0ezUoEmjHGoS8LzY8QwpXjXlRaWld2vtHtXLwP/PCzJ4CcIQQreoAlQP+CsatuGRD0p0NvUyYx60bT/OD00PBeeRtuF+RRlTZVW+v3BQBiXu3jOMvRv5GF7hz1Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560503; c=relaxed/simple;
	bh=/NsXxFng9sgzgj7iP+2cjlUPwPGI3lwmVXFXy4zcZG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u+3QcoR88NUD6U/MeVdoEtZUrsGicQtlgR+9wN/A5m13B41NgTgFRueL6drKTiqtGGRBpGkWsIYRiTG/d4F43z9gOsVkw2TF8PNPZT+u9epvdxAvonq1Ol4G/tuBZP4tOJwVKQ7pNICSL2mm0xz34fc1zhpnu3py8o2xV8fUx00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PE71QCTI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PE71QCTI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560501; x=1819096501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/NsXxFng9sgzgj7iP+2cjlUPwPGI3lwmVXFXy4zcZG0=;
  b=PE71QCTIOCpFVpbTE30bAplBqsYp1+L3vY11OIduZ6X0FtqudyV2GDhG
   d409wLENERMIKE/MR+Tc1yOno9kf5RsHVObAnq4xE3ZuhS6XtnpSlWTf8
   IDcoYBKo0BscgU/EO3PUsRzwgm6BCmH+zlgwyLorBZHOhmWoU9tNxhirg
   1hADFXC1Tg77tmAo4HVpNj3VrjJcoHBS9IB4IjJ/BcqBsRXSL9v3mAtdg
   Q2HouqtcTrNC2nTrBP47mSs/C0OdRgyRkiU+cTgWGoPLWoLVyIbhhN3xh
   AhUyUhthP4Yb8O/nBNtsSSMh5TO6towmS8npz5T5NqWsstnnknDNhQ5NZ
   A==;
X-CSE-ConnectionGUID: VZvAAq+iTpu7O6PkRgzdlw==
X-CSE-MsgGUID: +1FMJmbaRFmkHBwKiPNxqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598792"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598792"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:01 -0700
X-CSE-ConnectionGUID: 8WPpHz14S8iLJ120C5d04w==
X-CSE-MsgGUID: slwTq8PmR7+pj0uiAvT0nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326286"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:34:56 -0700
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
Subject: [RESEND Patch v10 10/23] perf/x86: Enable XMM register sampling for non-PEBS events
Date: Mon, 24 Aug 2026 16:27:18 +0800
Message-Id: <20260824082731.1013973-11-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
References: <20260824082731.1013973-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previously, XMM register sampling was only available for PEBS events
starting from Icelake. Extend the support to non-PEBS events using
the xsaves instruction, thereby completing the feature set.

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
planned. An ext_regs_mask is added to track the supported vector
register groups.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 185 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/core.c      |  24 +++-
 arch/x86/events/intel/ds.c        |   8 +-
 arch/x86/events/perf_event.h      |  13 +++
 arch/x86/include/asm/fpu/xstate.h |   2 +
 arch/x86/include/asm/perf_event.h |   5 +-
 arch/x86/kernel/fpu/xstate.c      |   2 +-
 7 files changed, 219 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3368270c0ad1..1c3e2bfa2673 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -408,6 +408,53 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
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
+	/* Add 64 bytes to satisfy the XSAVE area's 64-byte alignment. */
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
+
+	return buf ? PTR_ALIGN(buf, 64) : NULL;
+}
+
 int x86_reserve_hardware(void)
 {
 	int err = 0;
@@ -420,6 +467,7 @@ int x86_reserve_hardware(void)
 			} else {
 				reserve_ds_buffers();
 				reserve_lbr_buffers();
+				reserve_ext_regs_buffers();
 			}
 		}
 		if (!err)
@@ -436,6 +484,7 @@ void x86_release_hardware(void)
 		release_pmc_hardware();
 		release_ds_buffers();
 		release_lbr_buffers();
+		release_ext_regs_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
@@ -653,18 +702,31 @@ int x86_pmu_hw_config(struct perf_event *event)
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
+
+			if (event->attr.precise_ip) {
+				u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
 
-		if (!event->attr.precise_ip)
+				if (x86_pmu.arch_pebs && !(caps & ARCH_PEBS_VECR_XMM))
+					return -EINVAL;
+				if (!x86_pmu.arch_pebs && !x86_pmu.intel_cap.pebs_baseline)
+					return -EINVAL;
+			}
+			if (!get_ext_regs_buf(raw_smp_processor_id()))
+				return -ENOMEM;
+		}
+	}
+
+	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
+		/* XMM registers sampling for REGS_USER is not supported yet. */
+		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
 			return -EINVAL;
 	}
 
@@ -1717,6 +1779,107 @@ static void x86_pmu_del(struct perf_event *event, int flags)
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
+	/* Restrict to features actually saved by XSAVES */
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
+				     struct pt_regs *regs,
+				     bool exclude_kernel)
+{
+	if (exclude_kernel && !user_mode(regs)) {
+		data->regs_intr.regs = NULL;
+		data->regs_intr.abi = PERF_SAMPLE_REGS_ABI_NONE;
+	} else {
+		data->regs_intr.regs = regs;
+		data->regs_intr.abi = perf_reg_abi(current);
+	}
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
+				 bool from_pebs)
+{
+	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
+	u64 sample_type = event->attr.sample_type;
+	struct x86_perf_regs *perf_regs;
+	u64 intr_mask = 0;
+
+	if (WARN_ON_ONCE(!xsave) || !in_nmi())
+		return;
+
+	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.regs) {
+		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)
+			intr_mask |= XFEATURE_MASK_SSE;
+
+		intr_mask &= x86_pmu.ext_regs_mask;
+		intr_mask = from_pebs ? 0 : intr_mask;
+	}
+
+	if (intr_mask) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		xsave->header.xfeatures = 0;
+		xsaves_nmi(xsave, intr_mask);
+		update_perf_regs(perf_regs, xsave, intr_mask);
+	}
+}
+
+void x86_pmu_update_perf_regs(struct perf_event *event,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs,
+			      bool from_pebs)
+{
+	u64 sample_type = event->attr.sample_type;
+
+	if (!((sample_type & PERF_SAMPLE_REGS_INTR) &&
+	      (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)))
+		return;
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		x86_pmu_update_regs_intr(event, data, regs,
+					 event->attr.exclude_kernel);
+	}
+
+	x86_pmu_sample_xregs(event, data, from_pebs);
+}
+
 int x86_pmu_handle_irq(struct pt_regs *regs)
 {
 	struct perf_sample_data data;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7ad5aa5316e3..1db185f1fbd0 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3925,6 +3925,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
+		x86_pmu_clear_perf_regs(regs);
+		x86_pmu_update_perf_regs(event, &data, regs, false);
+
 		perf_event_overflow(event, &data, regs);
 	}
 
@@ -6165,12 +6168,23 @@ static inline bool intel_pmu_broken_perf_cap(void)
 static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
 {
 	struct pmu *dest_pmu = pmu ? pmu : x86_get_pmu(smp_processor_id());
-	u64 caps = hybrid(pmu, arch_pebs_cap).caps;
 
-	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
-	    (!x86_pmu.arch_pebs && x86_pmu.intel_cap.pebs_format >= 4 &&
-	     x86_pmu.intel_cap.pebs_baseline))
-		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+	/* Only support the extension when XSAVES is available. */
+	if (!boot_cpu_has(X86_FEATURE_XSAVES))
+		return;
+
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
+
+	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 78b9c0dcb14d..cd7ec09833ca 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2515,7 +2515,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	format_group = basic->format_group;
 
@@ -2600,6 +2600,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		next_record += nr * sizeof(u64);
 	}
 
+	x86_pmu_update_perf_regs(event, data, regs, true);
+
 	WARN_ONCE(next_record != __pebs + basic->format_size,
 			"PEBS record size %u, expected %llu, config %llx\n",
 			basic->format_size,
@@ -2632,7 +2634,7 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		return;
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
-	perf_regs->xmm_regs = NULL;
+	x86_pmu_clear_perf_regs(regs);
 
 	__setup_perf_sample_data(event, iregs, data);
 
@@ -2734,6 +2736,8 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		at = at + header->size;
 		goto again;
 	}
+
+	x86_pmu_update_perf_regs(event, data, regs, true);
 }
 
 static inline void *
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fa381110f7a7..c2b0df0051b8 100644
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
@@ -1315,6 +1321,13 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_clear_perf_regs(struct pt_regs *regs);
+
+void x86_pmu_update_perf_regs(struct perf_event *event,
+			      struct perf_sample_data *data,
+			      struct pt_regs *regs,
+			      bool from_pebs);
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
index 1eb13673e889..619e0ae915e1 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -728,7 +728,10 @@ extern void perf_events_lapic_init(void);
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
index d39c01546dee..3e7f5fb5bfaf 100644
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

