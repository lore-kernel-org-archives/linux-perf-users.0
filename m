Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6EC37BE7D;
	Mon,  6 Jul 2026 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303331; cv=none; b=iJrSW++xo3Bfevw32Xeym+N0+mNVSq6/qvSi7JKZ671vZakr9Gm5eJPmYw7e7URl3dRCX2njvffh6BM6pJ4qX/v5PjGl9824KK4dKliPAcvpGNjz8xrC7EqwKCmlb988ij0B3/F8SQsZhs9x0UsimyPheDi1rgLndhGvukO9I1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303331; c=relaxed/simple;
	bh=h+10s2Wg1N+H7G3lW+cTsVsrMgwyR+dKDzk3EnOpvgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HqKub9T8FkCjYcXf2LIlG/RxXm0IBdtTGuJvlcof3NRLwtOcvrovLCMGBlEj2z9/2KuuSCqUrloeYDMMTB+ZnptIx738/V5qb2V/AhIAIunJNDJRWhXeZF7LhIAgy45SoNBhzwpcrSG5QEhLRe89M96sYDeW8KvTho49Iv1FP3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SojLsaUV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SojLsaUV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303330; x=1814839330;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h+10s2Wg1N+H7G3lW+cTsVsrMgwyR+dKDzk3EnOpvgo=;
  b=SojLsaUVC8o88GevaAbdDzqmKAWVTtw4soCP86qY9Fe2N5M3yuXzPKUe
   AlxpVW5hoEH+/b4IZymtWrqyTW+pr3RYQ7CfBelpBoeJoP8dUIjIoGNzN
   wm9Ut19S8cOgStsmjhFtGAvt87hZwU/SEWO9+gXbSYZiYehS1xuQVC3Wg
   Lmm2zB2R9Nezh8howTvqLbqWKftt2CnP8UENXsJIrw0k2u0tJZHuPo/3k
   r2KQeDFEW6xcCZ4DE0GutPwlNLg6aa2Jvxpno6m6UX0hJ2reijemqorMh
   81+/0YqfPtLdQU9E475Ct79Vbvlys0T4dULxrA6AWrcTFsbbEXs3l/tNb
   g==;
X-CSE-ConnectionGUID: 2hiZXlJ1TYmLTWM9/ZkqNw==
X-CSE-MsgGUID: wGsdVElkTZus11ONL/KMAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911661"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911661"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:02:10 -0700
X-CSE-ConnectionGUID: p79cyn1PRuWIhzdcQqxoAw==
X-CSE-MsgGUID: u0qLYKwFQ9aXmPhp6TKLFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191371"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:02 -0700
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
Subject: [Patch v9 12/24] perf/x86: Enable XMM register sampling for REGS_USER case
Date: Mon,  6 Jul 2026 09:54:27 +0800
Message-Id: <20260706015439.3040804-13-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support XMM register sampling for the REGS_USER case.

To handle simultaneous sampling of XMM registers for both REGS_INTR and
REGS_USER cases, a per-CPU `x86_user_regs` is introduced to store
REGS_USER-specific XMM registers. This prevents REGS_USER-specific XMM
register data from being overwritten by REGS_INTR-specific data if they
share the same `x86_perf_regs` structure.

To sample user-space XMM registers, the `x86_pmu_update_user_xregs()`
helper function is added. It checks if the `TIF_NEED_FPU_LOAD` flag is
set. If so, the user-space XMM register data can be directly retrieved
from the cached task FPU state, as the corresponding hardware registers
have been cleared or switched to kernel-space data. Otherwise, the data
must be read from the hardware registers using the `xsaves` instruction.

For PEBS events, `x86_pmu_update_user_xregs()` checks if the PEBS-sampled
XMM register data belongs to user-space. If so, no further action is
needed. Otherwise, the user-space XMM register data needs to be
re-sampled using the same method as for non-PEBS events.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 157 +++++++++++++++++++++++++++++++----
 arch/x86/events/intel/core.c |   6 +-
 arch/x86/events/intel/ds.c   |   5 +-
 3 files changed, 148 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3e52610510cd..0d42c51761f9 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -707,23 +707,17 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		/*
 		 * Besides the general purpose registers, XMM registers may
 		 * be collected as well.
 		 */
-		if (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK) {
+		if (event_has_extended_regs(event)) {
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
 				return -EINVAL;
 		}
 	}
 
-	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
-		/* XMM registers sampling for REGS_USER is not supported yet. */
-		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
-			return -EINVAL;
-	}
-
 	return x86_setup_perfctr(event);
 }
 
@@ -1812,33 +1806,165 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
 	data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 }
 
+/*
+ * When both PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER are set,
+ * an additional x86_perf_regs is required to save user-space registers.
+ * Without this, user-space register data may be overwritten by kernel-space
+ * registers.
+ */
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
+static void x86_pmu_get_regs_user(struct perf_sample_data *data,
+				  struct pt_regs *regs)
+{
+	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
+	struct perf_regs regs_user;
+
+	x86_pmu_clear_perf_regs(&x86_regs_user->regs);
+
+	perf_get_regs_user(&regs_user, regs);
+	data->regs_user.abi = regs_user.abi;
+	if (regs_user.regs) {
+		x86_regs_user->regs = *regs_user.regs;
+		data->regs_user.regs = &x86_regs_user->regs;
+	} else
+		data->regs_user.regs = NULL;
+}
+
+/*
+ * The x86 specific variant of perf_sample_regs_user().
+ * Update data->regs_user fields for extended registers (e.g., SIMD).
+ */
+static void x86_pmu_update_regs_user(struct perf_event *event,
+				     struct perf_sample_data *data,
+				     struct pt_regs *regs)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	if (user_mode(regs)) {
+		data->regs_user.abi = perf_reg_abi(current);
+		data->regs_user.regs = regs;
+	} else if (is_user_task(current)) {
+		/*
+		 * It cannot guarantee that the kernel will never
+		 * touch the registers outside of the pt_regs,
+		 * especially when more and more registers
+		 * (e.g., SIMD, eGPR) are added. The live data
+		 * cannot be used.
+		 */
+		x86_pmu_get_regs_user(data, regs);
+	} else {
+		data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
+		data->regs_user.regs = NULL;
+	}
+
+	data->dyn_size += sizeof(u64);
+	if (data->regs_user.regs)
+		data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+
+	/*
+	 * Set PERF_SAMPLE_REGS_USER to bypass perf_sample_regs_user() call
+	 * in perf_prepare_sample() function.
+	 */
+	data->sample_flags |= PERF_SAMPLE_REGS_USER;
+}
+
+/*
+ * This function retrieves cached user-space fpu registers (XMM/YMM/ZMM).
+ * If TIF_NEED_FPU_LOAD is set, it indicates that the user-space FPU state
+ * is cached. Otherwise, the data should be read directly from the hardware
+ * registers.
+ */
+static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
+					    struct pt_regs *regs,
+					    u64 mask, u64 ignore_mask)
+{
+	struct x86_perf_regs *perf_regs;
+	struct xregs_state *xsave;
+	unsigned int guest_state;
+	struct fpu *fpu;
+	struct fpstate *fps;
+	u64 user_mask = mask;
+
+	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
+		return 0;
+
+	/*
+	 * If PEBS hits kernel space, need to re-sample extended
+	 * registers for user space.
+	 */
+	if (user_mode(regs))
+		user_mask &= ~ignore_mask;
+
+	if (user_mask && test_thread_flag(TIF_NEED_FPU_LOAD)) {
+		perf_regs = container_of(data->regs_user.regs,
+				 struct x86_perf_regs, regs);
+		fpu = x86_task_fpu(current);
+		/*
+		 * If __task_fpstate is set, it holds the right pointer,
+		 * otherwise fpstate will.
+		 */
+		fps = READ_ONCE(fpu->__task_fpstate);
+		if (!fps)
+			fps = fpu->fpstate;
+		xsave = &fps->regs.xsave;
+
+		update_perf_regs(perf_regs, xsave, user_mask);
+		return 0;
+	}
+
+	guest_state = perf_guest_state();
+	/*
+	 * Skip SIMD register sampling if a PMI hits while guest kernel
+	 * state is still active.
+	 */
+	if (user_mask && (guest_state & PERF_GUEST_ACTIVE) &&
+	    !(guest_state & PERF_GUEST_USER))
+		return 0;
+
+	return user_mask;
+}
+
 static void x86_pmu_sample_xregs(struct perf_event *event,
 				 struct perf_sample_data *data,
+				 struct pt_regs *regs,
 				 u64 ignore_mask)
 {
 	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
 	u64 sample_type = event->attr.sample_type;
 	struct x86_perf_regs *perf_regs;
+	u64 user_mask = 0;
 	u64 intr_mask = 0;
 	u64 mask = 0;
 
 	if (WARN_ON_ONCE(!xsave) || !in_nmi())
 		return;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= x86_pmu.ext_regs_mask;
+	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.regs) {
+		user_mask = x86_pmu_update_user_xregs(data, regs,
+						      mask, ignore_mask);
+	}
 
 	if ((sample_type & PERF_SAMPLE_REGS_INTR) && data->regs_intr.regs)
 		intr_mask = mask & ~ignore_mask;
 
+	if (user_mask | intr_mask) {
+		xsave->header.xfeatures = 0;
+		xsaves_nmi(xsave, user_mask | intr_mask);
+	}
+
+	if (user_mask) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
+		update_perf_regs(perf_regs, xsave, user_mask);
+	}
+
 	if (intr_mask) {
 		perf_regs = container_of(data->regs_intr.regs,
 					 struct x86_perf_regs, regs);
-		xsave->header.xfeatures = 0;
-		xsaves_nmi(xsave, mask);
 		update_perf_regs(perf_regs, xsave, intr_mask);
 	}
 }
@@ -1850,20 +1976,21 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 {
 	u64 sample_type = event->attr.sample_type;
 
-	if (!((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	      (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)))
+	if (!event_has_extended_regs(event))
 		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		x86_pmu_update_regs_intr(event, data, regs,
 					 event->attr.exclude_kernel);
 	}
+	if (sample_type & PERF_SAMPLE_REGS_USER)
+		x86_pmu_update_regs_user(event, data, regs);
 
 	/*
 	 * ignore_mask indicates the PEBS sampled extended regs
 	 * which are unnecessary to sample again.
 	 */
-	x86_pmu_sample_xregs(event, data, ignore_mask);
+	x86_pmu_sample_xregs(event, data, regs, ignore_mask);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 93ac6591cb3e..69294bc57225 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4697,15 +4697,15 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
+	u64 gprs_mask = PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~PEBS_GP_REGS)
+	if (event->attr.sample_regs_user & ~gprs_mask)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr &
-	    ~(PEBS_GP_REGS | PERF_REG_EXTENDED_MASK))
+	if (event->attr.sample_regs_intr & ~gprs_mask)
 		flags &= ~PERF_SAMPLE_REGS_INTR;
 	return flags;
 }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index e2bb53f138ee..2f5e732d2c95 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1733,8 +1733,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2941,6 +2940,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
+	x86_pmu_clear_perf_regs(regs);
+
 	if (!iregs)
 		iregs = &dummy_iregs;
 
-- 
2.34.1

