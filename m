Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B85F3A8759;
	Mon, 24 Aug 2026 08:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787560508; cv=none; b=undiiiByUJUhUhPwCpdPHGO5uPgZS2VTm/ZFJwSFuI9aaiDarrZpgMrZSHIzhSOOOfH2gUsI+2dV+Aue+zI4zRdg9kBVZ/NyLDmSuSAQ1MRN+T4hrAfglk5pDI25MeFmOnPAJmTAgEDQqVmfcHVrhTrv3yfJF3Pcm1xin7KK3xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787560508; c=relaxed/simple;
	bh=PqB43htOKEj7wCsImRgOpqxbb0lcWkfen4+IVe/nOOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BOcCuwD6gtHE2J7pBSPd0nefeZD/BY/dFHO1RQdk2cpamxtLhxkHIBJ0lmg76YF8JWQZxtwiTiDBCq+UdjLsdkwaXHNSC8s/jAwImRE9WTcovVNzAokDVe9YP/divzUiNUWzyH51NMsi11QYV3om8Q9zjicJ25K44QpLJoPa5a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhuoEEX4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhuoEEX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787560507; x=1819096507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PqB43htOKEj7wCsImRgOpqxbb0lcWkfen4+IVe/nOOI=;
  b=RhuoEEX4ECvkbxbbnQrcwZDJblZzeeeS1VbdfiDRemlmKSPT2g9AnzVo
   PjEnUKvm+PXWTkIUMY6pwNVTFsoPIC6yc8kNrusIBBIdb7Ot9kzu2XDZs
   cNXkRE/yb9NS7gZU5A7rATgl+/jecuhUVlAPoQvWtaMnwBL6gIcYGLR1/
   AKQZ3JfkOoxlkSSVQQvbnzSKNisRJcIEKvJJKQwxy+RM9MumDZyf5DIVD
   Zt5y/ckuStcMKdL6YnrvCvbNiCYKoGMHa/Yvc7j+ESUM62IEX4V86d/aR
   VTEOBuKlI65zUHUond4IBQLvJxiPBD9pkQ5501EiCQrnBgRW9QuthmQI3
   g==;
X-CSE-ConnectionGUID: dDbLkfnpQBm6QS/cHK9F/w==
X-CSE-MsgGUID: OKUMAgyoSGS/9t6rAyvbEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="98598803"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="98598803"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 01:35:07 -0700
X-CSE-ConnectionGUID: zIogc0KoQKWQoAF0uD/YLg==
X-CSE-MsgGUID: 0xR7Gc+ERWWSb6nhOc9+bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="264326388"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 24 Aug 2026 01:35:01 -0700
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
Subject: [RESEND Patch v10 11/23] perf/x86: Enable XMM register sampling for REGS_USER case
Date: Mon, 24 Aug 2026 16:27:19 +0800
Message-Id: <20260824082731.1013973-12-dapeng1.mi@linux.intel.com>
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

Support XMM register sampling for the REGS_USER case.

To handle simultaneous sampling of XMM registers for both REGS_INTR and
REGS_USER cases, a per-CPU x86_user_regs is introduced to store
REGS_USER-specific XMM registers. This prevents REGS_USER-specific XMM
register data from being overwritten by REGS_INTR-specific data if they
share the same x86_perf_regs structure.

To sample user-space XMM registers, the x86_pmu_update_user_xregs()
helper function is added. It checks if the user-space FPU state has been
cached into task FPU state. If so, the user-space XMM register data
can be directly retrieved from the cached task FPU state, as the
corresponding hardware registers have been cleared or switched to
kernel-space state or guest state. Otherwise, the data could be read
from the hardware registers using the xsaves instruction.

For PEBS events, x86_pmu_update_user_xregs() checks if the PEBS-sampled
XMM register data belongs to user-space. If so, no further action is
needed. Otherwise, the user-space XMM register data needs to be
re-sampled using the same method as for non-PEBS events.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c       | 154 ++++++++++++++++++++++++++++++++---
 arch/x86/events/intel/core.c |   6 +-
 arch/x86/events/intel/ds.c   |   5 +-
 3 files changed, 147 insertions(+), 18 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1c3e2bfa2673..20140643e21c 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -702,12 +702,12 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 
@@ -724,12 +724,6 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 
@@ -1832,14 +1826,129 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
 	data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 }
 
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
+
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
+	} else {
+		data->regs_user.regs = NULL;
+	}
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
+	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
+	struct perf_event_attr *attr = &event->attr;
+	struct x86_perf_regs *perf_regs;
+
+	/*
+	 * PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER can both be
+	 * requested for one event. Keep user regs in a separate x86_perf_regs
+	 * instance, so intr-reg collection does not overwrite user-reg data.
+	 */
+	if (user_mode(regs)) {
+		x86_pmu_clear_perf_regs(&x86_regs_user->regs);
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		/* Copy all sampled regs data to x86_regs_user. */
+		*x86_regs_user = *perf_regs;
+		data->regs_user.regs = &x86_regs_user->regs;
+		data->regs_user.abi = perf_reg_abi(current);
+	} else if (is_user_task(current)) {
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
+ * If TIF_NEED_FPU_LOAD is set or PMI hits into guest, it indicates that
+ * the user-space FPU state is cached. Otherwise, the data should be read
+ * directly from the hardware registers.
+ */
+static inline u64 x86_pmu_update_user_xregs(struct perf_sample_data *data,
+					    struct pt_regs *regs,
+					    u64 mask, bool from_pebs)
+{
+	struct x86_perf_regs *perf_regs;
+	struct xregs_state *xsave;
+	struct fpu *fpu;
+	struct fpstate *fps;
+	u64 user_mask = mask;
+
+	if (!is_user_task(current))
+		return 0;
+
+	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
+		return 0;
+
+	/*
+	 * If PEBS hits kernel space, need to re-sample extended
+	 * registers for user space.
+	 */
+	if (user_mode(regs))
+		user_mask = from_pebs ? 0 : mask;
+
+	fpu = x86_task_fpu(current);
+	fps = READ_ONCE(fpu->__task_fpstate);
+	/*
+	 * If fpu->__task_fpstate is set, it points to the cached user
+	 * FPU state (e.g. with KVM guest-state swapping). Otherwise,
+	 * when TIF_NEED_FPU_LOAD is set, fpu->fpstate holds the cached
+	 * user state. If neither is true, the user state is live in hardware.
+	 */
+	if (user_mask && (test_thread_flag(TIF_NEED_FPU_LOAD) || fps)) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
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
 				 bool from_pebs)
 {
 	struct xregs_state *xsave = get_ext_regs_buf(smp_processor_id());
 	u64 sample_type = event->attr.sample_type;
 	struct x86_perf_regs *perf_regs;
 	u64 intr_mask = 0;
+	u64 user_mask = 0;
 
 	if (WARN_ON_ONCE(!xsave) || !in_nmi())
 		return;
@@ -1852,13 +1961,31 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		intr_mask = from_pebs ? 0 : intr_mask;
 	}
 
+	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.regs) {
+		if (event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)
+			user_mask |= XFEATURE_MASK_SSE;
+
+		user_mask &= x86_pmu.ext_regs_mask;
+		user_mask = x86_pmu_update_user_xregs(data, regs,
+						      user_mask, from_pebs);
+	}
+
+	if (user_mask | intr_mask) {
+		xsave->header.xfeatures = 0;
+		xsaves_nmi(xsave, user_mask | intr_mask);
+	}
+
 	if (intr_mask) {
 		perf_regs = container_of(data->regs_intr.regs,
 					 struct x86_perf_regs, regs);
-		xsave->header.xfeatures = 0;
-		xsaves_nmi(xsave, intr_mask);
 		update_perf_regs(perf_regs, xsave, intr_mask);
 	}
+
+	if (user_mask) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
+		update_perf_regs(perf_regs, xsave, user_mask);
+	}
 }
 
 void x86_pmu_update_perf_regs(struct perf_event *event,
@@ -1868,16 +1995,17 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
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
 
-	x86_pmu_sample_xregs(event, data, from_pebs);
+	x86_pmu_sample_xregs(event, data, regs, from_pebs);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 1db185f1fbd0..1f4a61710bbd 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4695,15 +4695,15 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
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
index cd7ec09833ca..b1bca4a390d0 100644
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
@@ -2937,6 +2936,8 @@ __intel_pmu_pebs_events(struct perf_event *event,
 	void *at = get_next_pebs_record_by_bit(base, top, bit);
 	int cnt = count;
 
+	x86_pmu_clear_perf_regs(regs);
+
 	if (!iregs)
 		iregs = &dummy_iregs;
 
-- 
2.34.1

