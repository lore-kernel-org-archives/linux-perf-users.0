Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986FB2E8E0B;
	Thu, 25 Sep 2025 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780880; cv=none; b=oTKHO2Db3Ytb8yCvIe1jBjWf8yZf5bxju96k85NNuONDGiPOrhspPrViAW3AI4vtvQmptjoetoTSWGUx6lhmW0g4ctE529c1OmxcYYeFl7MeKesErbWqlCQ47Mp0Dmb5xo6qJcDnhwt4gwktoVYTqShYk8wKF+3SZyt/4jjSYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780880; c=relaxed/simple;
	bh=Fn1qEDrdI4AOAi1A8MSyw/SkBq4pedz9ADP1Hl4me6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tk3lRxQsLHZWaduQMFglzOjNfL77+Z7z9U3H9tigAj8gVUwGVbj97xpPDxOntCe0wDe0+oHER/fkB2rC+emfz1DaB55WviRordSen3jdoF9aL0IbYtjVjBPorfcC0gMZsXdMlQt1At64xeNXhDv8uRwGooo8bQauWncZrZwDndY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YLyWSQ5L; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YLyWSQ5L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780879; x=1790316879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fn1qEDrdI4AOAi1A8MSyw/SkBq4pedz9ADP1Hl4me6A=;
  b=YLyWSQ5LX2juSYW2mTzymKl25vSzQPh8ZwyJJqFx1Og1g0NKxmgPkhFF
   hbPL1NBRi8yiBJqxPrEeFb+i/yYfsEWiZYAG5vm3maGEFzEkJuTLZIlU/
   qr2/Y0darOkAYh7dpyl+ltzHPsKZQvcK7OTYjOGM06Ej7NY9PGvsc8U9/
   OsXVzCZv6qU12lUBENk5rBPMrD6P9l7AyGKqMfWrPoB04OkZvfJYWtvRa
   c7jBFUe36eJNafiClTq7A2dvkwM3kCjWGzleCu2gRdtJjfLro7rN6dPWh
   3w6l6l9wWCFhmv/p7Pv8bo2ZPylgKQnKM/odJnkspHTc6iVfEx+h+OuRo
   g==;
X-CSE-ConnectionGUID: vzQ1xCBFTSSJnRrTWsQxtQ==
X-CSE-MsgGUID: s/uGPOkLTEGy7+/90t3EMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139539"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:38 -0700
X-CSE-ConnectionGUID: dhHvhAYISMm4+Ebcpapw9A==
X-CSE-MsgGUID: 6ReHZ6wATUuLd4d/xGDjag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528347"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:32 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	broonie@kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v4 05/17] perf/x86: Support XMM register for non-PEBS and REGS_USER
Date: Thu, 25 Sep 2025 14:12:01 +0800
Message-Id: <20250925061213.178796-6-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
References: <20250925061213.178796-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

Collecting the XMM registers in a PEBS record has been supported since
the Icelake. But non-PEBS events don't support the feature. It's
possible to retrieve the XMM registers from the XSAVE for non-PEBS.
Add it to make the feature complete.

To utilize the XSAVE, a 64-byte aligned buffer is required. Add a
per-CPU ext_regs_buf to store the vector registers. The size of the
buffer is ~2K. kzalloc_node() is used because there's a _guarantee_
that all kmalloc()'s with powers of 2 are naturally aligned and also
64b aligned.

Extend the support for both REGS_USER and REGS_INTR. For REGS_USER, the
perf_get_regs_user() returns the regs from the task_pt_regs(current),
which is struct pt_regs. Need to move it to local struct x86_perf_regs
x86_user_regs.
For PEBS, the HW support is still preferred. The XMM should be retrieved
from PEBS records.

It's possible that a userspace application enters the kernel mode, e.g.,
syscall, when an NMI is triggered. The pt_regs information can still be
retrieved from task_pt_regs(). But, the SIMD registers cannot.
The SIMD registers are dropped for this case. Because,
- To profile a userspace application which requires SIMD/eGPR regs, the
  NMI usually hits the usersapce. It's not common to hit the kernel mode.
- Although it's possible to retrieve the values when the
  TIF_NEED_FPU_LOAD flag is set, it's not worth introducing such
  complexity to handle an uncommon case in the critical path.
- Furthermore, only checking the TIF_NEED_FPU_LOAD flag cannot cure
  everything. Some corner cases cannot be handled either. For example,
  an NMI can happen when the flag just switched, but still in the kernel
  mode.

There could be more vector registers supported later. Add ext_regs_mask
to track the supported vector register group.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 142 ++++++++++++++++++++++++++----
 arch/x86/events/intel/core.c      |  27 ++++++
 arch/x86/events/intel/ds.c        |  10 ++-
 arch/x86/events/perf_event.h      |   9 +-
 arch/x86/include/asm/fpu/xstate.h |   2 +
 arch/x86/include/asm/perf_event.h |   5 +-
 arch/x86/kernel/fpu/xstate.c      |   2 +-
 7 files changed, 172 insertions(+), 25 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 92678f61f819..e363f5f2b37d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -406,6 +406,61 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 	return x86_pmu_extra_regs(val, event);
 }
 
+static DEFINE_PER_CPU(struct xregs_state *, ext_regs_buf);
+
+static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
+{
+	struct xregs_state *xsave = per_cpu(ext_regs_buf, smp_processor_id());
+	u64 valid_mask = x86_pmu.ext_regs_mask & mask;
+
+	if (WARN_ON_ONCE(!xsave))
+		return;
+
+	xsaves_nmi(xsave, valid_mask);
+
+	/* Filtered by what XSAVE really gives */
+	valid_mask &= xsave->header.xfeatures;
+
+	if (valid_mask & XFEATURE_MASK_SSE)
+		perf_regs->xmm_space = xsave->i387.xmm_space;
+}
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
+	unsigned int size;
+	int cpu;
+
+	if (!x86_pmu.ext_regs_mask)
+		return;
+
+	size = xstate_calculate_size(x86_pmu.ext_regs_mask, true);
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
@@ -418,6 +473,7 @@ int x86_reserve_hardware(void)
 			} else {
 				reserve_ds_buffers();
 				reserve_lbr_buffers();
+				reserve_ext_regs_buffers();
 			}
 		}
 		if (!err)
@@ -434,6 +490,7 @@ void x86_release_hardware(void)
 		release_pmc_hardware();
 		release_ds_buffers();
 		release_lbr_buffers();
+		release_ext_regs_buffers();
 		mutex_unlock(&pmc_reserve_mutex);
 	}
 }
@@ -642,19 +699,17 @@ int x86_pmu_hw_config(struct perf_event *event)
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
-
-		if (!event->attr.precise_ip)
-			return -EINVAL;
+	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
+		/*
+		 * Besides the general purpose registers, XMM registers may
+		 * be collected as well.
+		 */
+		if (event_has_extended_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+				return -EINVAL;
+			if (!event->attr.precise_ip)
+				return -EINVAL;
+		}
 	}
 
 	return x86_setup_perfctr(event);
@@ -1685,25 +1740,65 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
+
+static struct x86_perf_regs *
+x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
+			   struct pt_regs *regs)
+{
+	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
+	struct perf_regs regs_user;
+
+	perf_get_regs_user(&regs_user, regs);
+	data->regs_user.abi = regs_user.abi;
+	if (regs_user.regs) {
+		x86_regs_user->regs = *regs_user.regs;
+		data->regs_user.regs = &x86_regs_user->regs;
+	} else
+		data->regs_user.regs = NULL;
+	return x86_regs_user;
+}
+
+static bool x86_pmu_user_req_pt_regs_only(struct perf_event *event)
+{
+	return !(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK);
+}
+
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
-			     struct pt_regs *regs)
+			     struct pt_regs *regs,
+			     u64 ignore_mask)
 {
-	u64 sample_type = event->attr.sample_type;
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+	u64 mask = 0;
+
+	if (!(attr->sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		if (user_mode(regs)) {
 			data->regs_user.abi = perf_reg_abi(current);
 			data->regs_user.regs = regs;
-		} else if (!(current->flags & PF_KTHREAD)) {
-			perf_get_regs_user(&data->regs_user, regs);
+		} else if (!(current->flags & PF_KTHREAD) &&
+			   x86_pmu_user_req_pt_regs_only(event)) {
+			/*
+			 * It cannot guarantee that the kernel will never
+			 * touch the registers outside of the pt_regs,
+			 * especially when more and more registers
+			 * (e.g., SIMD, eGPR) are added. The live data
+			 * cannot be used.
+			 * Dump the registers when only pt_regs are required.
+			 */
+			perf_regs = x86_pmu_perf_get_regs_user(data, regs);
 		} else {
 			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
 			data->regs_user.regs = NULL;
 		}
 		data->dyn_size += sizeof(u64);
 		if (data->regs_user.regs)
-			data->dyn_size += hweight64(event->attr.sample_regs_user) * sizeof(u64);
+			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
@@ -1712,9 +1807,18 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		data->regs_intr.abi = perf_reg_abi(current);
 		data->dyn_size += sizeof(u64);
 		if (data->regs_intr.regs)
-			data->dyn_size += hweight64(event->attr.sample_regs_intr) * sizeof(u64);
+			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
+
+	if (event_has_extended_regs(event)) {
+		perf_regs->xmm_regs = NULL;
+		mask |= XFEATURE_MASK_SSE;
+	}
+
+	mask &= ~ignore_mask;
+	if (mask)
+		x86_pmu_get_ext_regs(perf_regs, mask);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea3..2575ec0d2b77 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3281,6 +3281,8 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
+		x86_pmu_setup_regs_data(event, &data, regs, 0);
+
 		perf_event_overflow(event, &data, regs);
 	}
 
@@ -5269,6 +5271,29 @@ static inline bool intel_pmu_broken_perf_cap(void)
 	return false;
 }
 
+static void intel_extended_regs_init(struct pmu *pmu)
+{
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
+
+	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
+	x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+}
+
 static void update_pmu_cap(struct pmu *pmu)
 {
 	unsigned int cntr, fixed_cntr, ecx, edx;
@@ -5303,6 +5328,8 @@ static void update_pmu_cap(struct pmu *pmu)
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
 	}
+
+	intel_extended_regs_init(pmu);
 }
 
 static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e67d8a03ddfe..f95dfee6adb2 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1415,8 +1415,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2127,8 +2126,12 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		}
 
 		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
+			u64 ignore_mask = 0;
+
+			if (format_group & PEBS_DATACFG_XMMS)
+				ignore_mask |= XFEATURE_MASK_SSE;
 			adaptive_pebs_save_regs(regs, gprs);
-			x86_pmu_setup_regs_data(event, data, regs);
+			x86_pmu_setup_regs_data(event, data, regs, ignore_mask);
 		}
 	}
 
@@ -2755,6 +2758,7 @@ void __init intel_pebs_init(void)
 				x86_pmu.flags |= PMU_FL_PEBS_ALL;
 				x86_pmu.pebs_capable = ~0ULL;
 				pebs_qual = "-baseline";
+				x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 			} else {
 				/* Only basic record supported */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 12682a059608..7bf24842b1dc 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -992,6 +992,12 @@ struct x86_pmu {
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
@@ -1280,7 +1286,8 @@ int x86_pmu_handle_irq(struct pt_regs *regs);
 
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
index 49a4d442f3fc..8f18903ea9d0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -596,7 +596,10 @@ extern void perf_events_lapic_init(void);
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
index 1ef62a137769..1b6e761dcf04 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -586,7 +586,7 @@ static bool __init check_xstate_against_struct(int nr)
 	return true;
 }
 
-static unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
+unsigned int xstate_calculate_size(u64 xfeatures, bool compacted)
 {
 	unsigned int topmost = fls64(xfeatures) -  1;
 	unsigned int offset, i;
-- 
2.34.1

