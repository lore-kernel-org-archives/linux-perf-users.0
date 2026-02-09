Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B782DD60F;
	Mon,  9 Feb 2026 07:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621944; cv=none; b=ZS9QPfLTs9rc0akhVr+29lc7fM6YRnX8jsfD6n9GOjg12Brih0gsicAssl5lUUr2YtJhFBKFLegiEYHLnenlBwKttQWvMK83fHEvpdi0hL+Rz5+SOgnE872vLSAJCjTCw6UOrtuWAExypZ0e7tucGLtm+1LofLnMhKT5PAISl5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621944; c=relaxed/simple;
	bh=YGt7Le9WtZ0UzK3leN4S+kdMPPfdpgbxaEzyWjtoKWI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyPkaZFZqN9gnP5Z40diocKP8/qBX2hkySQFXj9MXo4Cqd4+X9Nf82xNtwskFNRC4mWrdJ801aBEbqajzIl03TZ07gz23Y9Rib7wp/7gGSr/dE8VJDZ4qD1gEzPzEI6xP4HJT7AMZSghsHcnQI8EnwzBVF/BW8Yv9UwUl+MuOM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZtK8jtP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZtK8jtP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621945; x=1802157945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YGt7Le9WtZ0UzK3leN4S+kdMPPfdpgbxaEzyWjtoKWI=;
  b=HZtK8jtPmOU0+yjAO5KK4fRru9IisFunWCE0/FdhG0WL/mwChqZHAqXo
   kbWG07NnNd14ZUS5ga3WENXGdi3jeyWZXCyt0Z9xkQeB/MRUcTx/4Sio3
   8HtD7PPt3KBHsvPRdRBQZucBN++Hq2N44iuAFS7jArgfkz2LBukuPEBkt
   eiEC+tHLlmsZAU4SJ8eE/7VuAFX+01CtXAZy+XrwjbEkk+6tejLEr6xLx
   400SymYDnMHgN3135XIgJ3/15YiOMHl01HJc23ygU3Ud6/3dqZrKHoeig
   PQCyY1vZ5w1Avh6ab+76CeC56Bc6/t0Qipokic5HgN22f2K+P68CVyd0U
   Q==;
X-CSE-ConnectionGUID: 4OgW6ZSyRgCCHK1HA8d9zA==
X-CSE-MsgGUID: XcvULaGvQ7WuHZ5nHiNagQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098415"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098415"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:25:45 -0800
X-CSE-ConnectionGUID: XD84p1oNReWJMzVKcGClDA==
X-CSE-MsgGUID: rC8JH2IPTaeVcmz/l3cNYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694685"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:40 -0800
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
Subject: [Patch v6 11/22] perf/x86: Enable XMM register sampling for REGS_USER case
Date: Mon,  9 Feb 2026 15:20:36 +0800
Message-Id: <20260209072047.2180332-12-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
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

To sample user-space XMM registers, the `x86_pmu_update_user_ext_regs()`
helper function is added. It checks if the `TIF_NEED_FPU_LOAD` flag is
set. If so, the user-space XMM register data can be directly retrieved
from the cached task FPU state, as the corresponding hardware registers
have been cleared or switched to kernel-space data. Otherwise, the data
must be read from the hardware registers using the `xsaves` instruction.

For PEBS events, `x86_pmu_update_user_ext_regs()` checks if the
PEBS-sampled XMM register data belongs to user-space. If so, no further
action is needed. Otherwise, the user-space XMM register data needs to be
re-sampled using the same method as for non-PEBS events.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---

V6: New patch, partly split from previous patch. Fully support user-regs
    sampling for SIMD regsiters as Peter suggested.

 arch/x86/events/core.c | 99 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3c0987e13edc..36b4bc413938 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -696,7 +696,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	if (event->attr.sample_type & PERF_SAMPLE_REGS_INTR) {
+	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		/*
 		 * Besides the general purpose registers, XMM registers may
 		 * be collected as well.
@@ -707,15 +707,6 @@ int x86_pmu_hw_config(struct perf_event *event)
 		}
 	}
 
-	if (event->attr.sample_type & PERF_SAMPLE_REGS_USER) {
-		/*
-		 * Currently XMM registers sampling for REGS_USER is not
-		 * supported yet.
-		 */
-		if (event_has_extended_regs(event))
-			return -EINVAL;
-	}
-
 	return x86_setup_perfctr(event);
 }
 
@@ -1745,6 +1736,28 @@ static void x86_pmu_del(struct perf_event *event, int flags)
 	static_call_cond(x86_pmu_del)(event);
 }
 
+/*
+ * When both PERF_SAMPLE_REGS_INTR and PERF_SAMPLE_REGS_USER are set,
+ * an additional x86_perf_regs is required to save user-space registers.
+ * Without this, user-space register data may be overwritten by kernel-space
+ * registers.
+ */
+static DEFINE_PER_CPU(struct x86_perf_regs, x86_user_regs);
+static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
+				       struct pt_regs *regs)
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
+}
+
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
 					  struct perf_sample_data *data,
 					  struct pt_regs *regs)
@@ -1757,7 +1770,14 @@ static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
 			data->regs_user.abi = perf_reg_abi(current);
 			data->regs_user.regs = regs;
 		} else if (!(current->flags & PF_KTHREAD)) {
-			perf_get_regs_user(&data->regs_user, regs);
+			/*
+			 * It cannot guarantee that the kernel will never
+			 * touch the registers outside of the pt_regs,
+			 * especially when more and more registers
+			 * (e.g., SIMD, eGPR) are added. The live data
+			 * cannot be used.
+			 */
+			x86_pmu_perf_get_regs_user(data, regs);
 		} else {
 			data->regs_user.abi = PERF_SAMPLE_REGS_ABI_NONE;
 			data->regs_user.regs = NULL;
@@ -1810,6 +1830,47 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->xmm_space = xsave->i387.xmm_space;
 }
 
+/*
+ * This function retrieves cached user-space fpu registers (XMM/YMM/ZMM).
+ * If TIF_NEED_FPU_LOAD is set, it indicates that the user-space FPU state
+ * Otherwise, the data should be read directly from the hardware registers.
+ */
+static inline u64 x86_pmu_update_user_ext_regs(struct perf_sample_data *data,
+					       struct pt_regs *regs,
+					       u64 mask, u64 ignore_mask)
+{
+	struct x86_perf_regs *perf_regs;
+	struct xregs_state *xsave;
+	struct fpu *fpu;
+	struct fpstate *fps;
+	u64 sample_mask = 0;
+
+	if (data->regs_user.abi == PERF_SAMPLE_REGS_ABI_NONE)
+		return 0;
+
+	if (user_mode(regs))
+		sample_mask = mask & ~ignore_mask;
+
+	if (test_thread_flag(TIF_NEED_FPU_LOAD)) {
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
+		x86_pmu_update_ext_regs(perf_regs, xsave, mask);
+		sample_mask = 0;
+	}
+
+	return sample_mask;
+}
+
 static void x86_pmu_sample_extended_regs(struct perf_event *event,
 					 struct perf_sample_data *data,
 					 struct pt_regs *regs,
@@ -1818,6 +1879,7 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 	u64 sample_type = event->attr.sample_type;
 	struct x86_perf_regs *perf_regs;
 	struct xregs_state *xsave;
+	u64 user_mask = 0;
 	u64 intr_mask = 0;
 	u64 mask = 0;
 
@@ -1827,15 +1889,24 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= x86_pmu.ext_regs_mask;
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		user_mask = x86_pmu_update_user_ext_regs(data, regs,
+							 mask, ignore_mask);
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
 		intr_mask = mask & ~ignore_mask;
 
-	if (intr_mask) {
-		__x86_pmu_sample_ext_regs(intr_mask);
+	if (user_mask | intr_mask) {
+		__x86_pmu_sample_ext_regs(user_mask | intr_mask);
 		xsave = per_cpu(ext_regs_buf, smp_processor_id());
-		x86_pmu_update_ext_regs(perf_regs, xsave, intr_mask);
 	}
+
+	if (user_mask)
+		x86_pmu_update_ext_regs(perf_regs, xsave, user_mask);
+
+	if (intr_mask)
+		x86_pmu_update_ext_regs(perf_regs, xsave, intr_mask);
 }
 
 void x86_pmu_setup_regs_data(struct perf_event *event,
-- 
2.34.1

