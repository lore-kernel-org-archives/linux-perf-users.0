Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220163AD507;
	Fri, 29 May 2026 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041812; cv=none; b=neKcdMoKKwdIJY7uiyVJSZF+zpmKLzAH26Bm614ljGr91cEDXv29YBUY5HzXN895u+/MxyNikQBcnrsLqEWUfe5kCzgNkKp76UOYkzGMrECgFzMPMgpkUZg1do9yCAsECXImZZGjOl0FQaTHANBUcMulAIYLnDXP6OoPrNJwKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041812; c=relaxed/simple;
	bh=RCv/pZl8i9VQu4VE3AsBhUxG5YGrOk0qfxx6RmMXF/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eu2GAIoid/mMYvLWscky1/uANAFVobUL3Jj7kpbZ6CUSkdyGPoS2WMB2Oy6IZwLGJypt3nWPI5Cyde3BpTGV5Kuvk+FrpFyiu0GECAoiKJlPXwVxO3KXGdC/ceIhaBQNJ3QEyQ6fOWXcbQZuz11IeHhqSH3IPhGC1WE3HODSzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nf6TtNa/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nf6TtNa/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041811; x=1811577811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RCv/pZl8i9VQu4VE3AsBhUxG5YGrOk0qfxx6RmMXF/0=;
  b=Nf6TtNa/adIc0G7gQ0BNRf+rw202wNelevjjUzlvRfqOLmxungHOHyOD
   zqzqQq48n9QQOqLYOuMKbJxNc69sGKMNyzO+rrc9xBldejEWVC+1/FY7J
   VDIXcoNcZAr6DyAAjY5rjnputAY6TM9myPqD8LcB5OZApdPENK22E8dNl
   nEyuNpKeDkln3oyXxZaDFEbsjl2iuK97ykFVzwBMGwFWUSahM5MLKghe2
   FBnFv6DRfoaM+lP/3+SEk7RL2jg+Vx2hoTBzG+eMhHxD8vtVMrlEK8++2
   2mDeHWp24IsnRAarZcRzvmYJQhp/sdI0YcNsxGHC8OlNYcP73+Vyz4iNe
   g==;
X-CSE-ConnectionGUID: 3NSUI2KYQ/uzaFPgUC2bIg==
X-CSE-MsgGUID: 2l07Muo8Qeak8GolzUq54A==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106341979"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106341979"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:31 -0700
X-CSE-ConnectionGUID: hucRXOpwQ02kii4OG1TwjQ==
X-CSE-MsgGUID: EJPbeZB0Td+4wmZpArolKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802256"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:26 -0700
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
Subject: [Patch v8 11/23] perf/x86: Enable XMM register sampling for REGS_USER case
Date: Fri, 29 May 2026 15:56:33 +0800
Message-Id: <20260529075645.580362-12-dapeng1.mi@linux.intel.com>
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

This patch adds support for XMM register sampling in the REGS_USER case.

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
 arch/x86/events/core.c       | 150 ++++++++++++++++++++++++++++++-----
 arch/x86/events/intel/core.c |   6 +-
 arch/x86/events/intel/ds.c   |   5 +-
 3 files changed, 138 insertions(+), 23 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c219a563434d..f9e3f349b69a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -707,12 +707,12 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 			if (is_sampling_event(event) && !event->attr.precise_ip &&
@@ -721,15 +721,6 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
-		/*
-		 * Currently XMM registers sampling for REGS_USER is not
-		 * supported yet.
-		 */
-		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
-			return -EINVAL;
-	}
-
 	return x86_setup_perfctr(event);
 }
 
@@ -1812,33 +1803,155 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
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
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		user_mask = x86_pmu_update_user_xregs(data, regs,
+						      mask, ignore_mask);
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
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
@@ -1850,18 +1963,19 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 {
 	u64 sample_type = event->attr.sample_type;
 
-	if (!((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	      (event->attr.sample_regs_intr & PERF_REG_EXTENDED_MASK)))
+	if (!event_has_extended_regs(event))
 		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
 		x86_pmu_update_regs_intr(event, data, regs);
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
index f5d458e3ba3f..6c06558c416f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4698,15 +4698,15 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
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
index 4f72ce6a9585..bd43bf26e6bf 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1749,8 +1749,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
+	if (event_has_extended_regs(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2957,6 +2956,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
+	x86_pmu_clear_perf_regs(regs);
+
 	if (!iregs)
 		iregs = &dummy_iregs;
 
-- 
2.34.1

