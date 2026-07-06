Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49137B41F;
	Mon,  6 Jul 2026 02:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303341; cv=none; b=ra9WfQ6x03TVLjmtpacitYEUtIWAl+v0bpNfM5bdW8q8nRjP9WJ/EQ0O5dOGgKUYonoSdxcy6Mr2QkcLY+qw81Tpmasy944XN+pRmbAOI5ADpJp0hLEHuSrYF29ks1HsS8iVd0P9lw8BIjpmjdPzgQB8umRbnS5vq7b8xtc8kyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303341; c=relaxed/simple;
	bh=AaQSIydysp/w/rmr12vwoeZCNVnx3cQHQJhif5WVWzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brVYdte8dpIQguXbhO12uEh/U1/PpYElVaopeniIkIkNk3/hcODaUg9ecC/Ncw7iNTliEZhO/bKdXn8NkcBHLeghdlV6yY5dR6bf4T0D9czE5w/3MCkGImtLzdjVphNV80Ek3qj49uadlEYEyZtTMwC5z7XLcAqcXpJJZ3jMp9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HmuAmBTe; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HmuAmBTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303340; x=1814839340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AaQSIydysp/w/rmr12vwoeZCNVnx3cQHQJhif5WVWzU=;
  b=HmuAmBTeYpS00BdXfwYRHiPUoQxBiJEGgCE+xIb/ESZyMnErZMmQywKw
   uAjjqVj4HuN2Liu5a/yS+iqpJMPCUa2ciP1cQfSgpvYSljuzKH6P9erwR
   39c2xe1A0U+EqeSiSASKBKncKndX2uYSE4DzK87g7Z2t0Q29r6jvlJnJ4
   nIlQkPVE3eQe4d4H21Mujv0HDybgLRz59BU5NpbmqjXk8ewjFdPryeyNq
   FrCkgbF9LlTs8rYjvJkeXEq3yI1bhkZuEIJ0eTXcVc2p2IlFhJQADtSwz
   3zxGCqXMP20Vx6D+ClinTavVw0JeAzKdWxOxk8DlVNO5Cgq3lDy00shTv
   w==;
X-CSE-ConnectionGUID: lchsdNelTomU3y1rFUVviQ==
X-CSE-MsgGUID: lA1gbMEaStG/hEORy1Wggg==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911683"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911683"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:02:20 -0700
X-CSE-ConnectionGUID: nSS+aHZQTO+4kZO5dqkeyQ==
X-CSE-MsgGUID: 1K7TNj9/Sgi1c/3pQjiWSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191408"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:14 -0700
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
Subject: [Patch v9 14/24] perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
Date: Mon,  6 Jul 2026 09:54:29 +0800
Message-Id: <20260706015439.3040804-15-dapeng1.mi@linux.intel.com>
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

Support sampling of XMM registers using the sample_simd_vec_reg_* fields.

When sample_simd_regs_enabled is set, the original XMM space in the
sample_regs_* field is treated as reserved. An INVAL error will be
reported to user space if any bit is set in the original XMM space while
sample_simd_regs_enabled is set.

The perf_reg_value function requires ABI information to understand the
layout of sample_regs. To accommodate this, a new abi field is introduced
in the struct x86_perf_regs to represent ABI information.

Additionally, the X86-specific perf_simd_reg_value function is implemented
to retrieve the XMM register values.

XMM sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 50 +++++++++++++++--
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/perf_event.h          | 16 ++++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h | 15 +++++
 arch/x86/kernel/perf_regs.c           | 80 ++++++++++++++++++++++++++-
 include/linux/perf_event.h            |  1 +
 kernel/events/core.c                  |  2 +-
 8 files changed, 158 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0d42c51761f9..117d09fb9a05 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -715,6 +715,17 @@ int x86_pmu_hw_config(struct perf_event *event)
 		if (event_has_extended_regs(event)) {
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
 				return -EINVAL;
+			if (event->attr.sample_simd_regs_enabled)
+				return -EINVAL;
+		}
+
+		if (event_has_simd_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
+				return -EINVAL;
+			/* The vector registers set is not supported */
+			if (event_needs_xmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+				return -EINVAL;
 		}
 	}
 
@@ -1757,6 +1768,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 {
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 
+	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
 }
 
@@ -1777,14 +1789,15 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 
 /*
  * The x86 specific variant of perf_sample_regs_intr().
- * It would be extended to add more SIMD registers sampling support
- * in later patches.
+ * Update data->regs_intr fields for extended registers (e.g., SIMD).
  */
 static void x86_pmu_update_regs_intr(struct perf_event *event,
 				     struct perf_sample_data *data,
 				     struct pt_regs *regs,
 				     bool exclude_kernel)
 {
+	struct x86_perf_regs *perf_regs;
+
 	if (exclude_kernel && !user_mode(regs)) {
 		data->regs_intr.regs = NULL;
 		data->regs_intr.abi = PERF_SAMPLE_REGS_ABI_NONE;
@@ -1797,6 +1810,16 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
 	if (data->regs_intr.regs) {
 		data->dyn_size += hweight64(event->attr.sample_regs_intr) *
 				  sizeof(u64);
+		if (event_has_simd_regs(event)) {
+			data->dyn_size += perf_update_xregs_size(event, true);
+			data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		}
+	}
+
+	if (data->regs_intr.abi) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi = data->regs_intr.abi;
 	}
 
 	/*
@@ -1839,6 +1862,7 @@ static void x86_pmu_update_regs_user(struct perf_event *event,
 				     struct pt_regs *regs)
 {
 	struct perf_event_attr *attr = &event->attr;
+	struct x86_perf_regs *perf_regs;
 
 	if (user_mode(regs)) {
 		data->regs_user.abi = perf_reg_abi(current);
@@ -1858,8 +1882,19 @@ static void x86_pmu_update_regs_user(struct perf_event *event,
 	}
 
 	data->dyn_size += sizeof(u64);
-	if (data->regs_user.regs)
+	if (data->regs_user.regs) {
 		data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		if (event_has_simd_regs(event)) {
+			data->dyn_size += perf_update_xregs_size(event, false);
+			data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		}
+	}
+
+	if (data->regs_user.abi) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi = data->regs_user.abi;
+	}
 
 	/*
 	 * Set PERF_SAMPLE_REGS_USER to bypass perf_sample_regs_user() call
@@ -1939,7 +1974,7 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 	if (WARN_ON_ONCE(!xsave) || !in_nmi())
 		return;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= x86_pmu.ext_regs_mask;
@@ -1976,7 +2011,12 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 {
 	u64 sample_type = event->attr.sample_type;
 
-	if (!event_has_extended_regs(event))
+	if (!(sample_type &
+	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return;
+
+	if (!event_needs_xmm(event) &&
+	    !event_has_simd_regs(event))
 		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 2f5e732d2c95..24bfc3fb6060 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1733,7 +1733,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 70fa7ec21673..6b1b83c906eb 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -147,6 +147,22 @@ static inline bool is_acr_self_reload_event(struct perf_event *event)
 	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
 }
 
+static inline bool event_needs_xmm(struct perf_event *event)
+{
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return false;
+
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_XMM_QWORDS)
+		return true;
+
+	if (!event->attr.sample_simd_regs_enabled &&
+	    event_has_extended_regs(event))
+		return true;
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 619e0ae915e1..a2b2123d008e 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -728,6 +728,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		abi;
 	union {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..edb35408e4cc 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PERF_REGS_H
 #define _ASM_X86_PERF_REGS_H
 
+#include <linux/bits.h>
+
 enum perf_event_x86_regs {
 	PERF_REG_X86_AX,
 	PERF_REG_X86_BX,
@@ -55,4 +57,17 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+enum {
+	PERF_X86_SIMD_XMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+};
+
+#define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+enum {
+	/* 1 qword = 8 bytes */
+	PERF_X86_XMM_QWORDS      = 2,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+};
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 81204cb7f723..8514baefb400 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -63,6 +63,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			return 0;
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
@@ -74,6 +77,77 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred)
+{
+	struct x86_perf_regs *perf_regs =
+			container_of(regs, struct x86_perf_regs, regs);
+
+	if (!(perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
+		return 0;
+
+	if (pred)
+		return 0;
+
+	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
+			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
+		return 0;
+
+	if (qwords_idx < PERF_X86_XMM_QWORDS) {
+		if (!perf_regs->xmm_regs)
+			return 0;
+		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS +
+					   qwords_idx];
+	}
+
+	return 0;
+}
+
+int perf_simd_reg_validate(u64 sample_type, u16 simd_enabled,
+			   u16 vec_qwords, u64 vec_mask_intr,
+			   u64 vec_mask_user, u16 pred_qwords,
+			   u32 pred_mask_intr, u32 pred_mask_user)
+{
+	u64 size = 0;
+
+	if (!(sample_type &
+	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return 0;
+
+	if (!simd_enabled)
+		return 0;
+
+	if (vec_qwords) {
+		if (vec_qwords != PERF_X86_XMM_QWORDS)
+			return -EINVAL;
+		if (!vec_mask_intr && !vec_mask_user)
+			return -EINVAL;
+		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK))
+			return -EINVAL;
+		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		    (vec_mask_user & ~PERF_X86_SIMD_VEC_MASK))
+			return -EINVAL;
+	}
+
+	if (pred_qwords || pred_mask_intr || pred_mask_user)
+		return -EINVAL;
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		size = (vec_qwords * hweight64(vec_mask_intr) +
+			pred_qwords * hweight32(pred_mask_intr)) * sizeof(u64);
+	}
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		size += (vec_qwords * hweight64(vec_mask_user) +
+			 pred_qwords * hweight32(pred_mask_user)) * sizeof(u64);
+	}
+
+	if (size > U16_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
@@ -89,7 +163,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
@@ -108,7 +183,8 @@ u64 perf_reg_abi(struct task_struct *task)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c4e330c121d2..e40d60ccab9e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1485,6 +1485,7 @@ static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *b
 	br->reserved	= 0;
 }
 
+extern u64 perf_update_xregs_size(struct perf_event *event, bool intr);
 extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ce93c23b3a33..2ce8c3cd6824 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8718,7 +8718,7 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
-static u64 perf_update_xregs_size(struct perf_event *event, bool intr)
+u64 perf_update_xregs_size(struct perf_event *event, bool intr)
 {
 	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
 	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
-- 
2.34.1

