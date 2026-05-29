Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44763B47CC;
	Fri, 29 May 2026 08:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041827; cv=none; b=tHLuFJneHwBzQ++AkdOB5HEsBR8dqFvGWE3JbBiuBb+1LyUb3vpgyjgAnSU/GuugAvanLbAiqMLLVt9hsFUvNlFwiXatXnkdV/KbxsWSZS8zKmcp2p4z3icBWEIpsdLIT6znIJVnI7k7Iaj0zi3/p4moHF65XBI8r6kqH9OKzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041827; c=relaxed/simple;
	bh=zy8r1RiNCfCqkY9KBrsV+6CjNaBSXhkaNAfGvfzHd4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qbMtipgxkns71HiikkSWCTqNMt8Sru0clEFOQhyDUqWVa1NZEVzv5VmPz9g/STqg0863j6Ptu+oTkhvqML5M8H9NgaRdzV9kTeb6qu4pnXaniSNPaGRV2n8Y+X620S4SdE23r4q7n4R1Sh5gBx5PeR2//7O0jR3eEdHM8aY694o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MwStkMHv; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MwStkMHv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041826; x=1811577826;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zy8r1RiNCfCqkY9KBrsV+6CjNaBSXhkaNAfGvfzHd4k=;
  b=MwStkMHvBltyPe50SnEHebbnHVzfuqd1OuO0UIkJQ9OMgiX38WDjLJXJ
   7QbzCJ1oM6RwcJZKtv/l5/Q85B+4Qw26NITcodqeNzyNKuQWFaDLhkCNr
   GgSsrijbfMp/cubBFdCIYI8ty2xyzsJvM8rmESSyBtN4R75PmW2vLt+66
   fi38+Hh+E/vDNxDWz+IBgLQ6JXY+lULvAbkZp/66GQy8pvpMCNDAhDLsY
   AeCqUzaXHrtKPTuhv8L1TrZwgvv6+ctWUMNUoFJ2csg+xU0S75MWMAso8
   /GNh0/Qi7C7+PUQULUB0T8O065Dp5P8uJ7lMMsleukPnq6xlNDYhHccoh
   A==;
X-CSE-ConnectionGUID: 6kXyLjPcTNKSN7FAHgs64g==
X-CSE-MsgGUID: hNTRgKHgQdyK/ngs7LgGnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342033"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342033"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:45 -0700
X-CSE-ConnectionGUID: rQ0vGAviRRea3mS/m3duqA==
X-CSE-MsgGUID: fPofIxdCQD+uNfmYfOnbkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802352"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:36 -0700
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
Subject: [Patch v8 13/23] perf/x86: Support XMM sampling using sample_simd_vec_reg_* fields
Date: Fri, 29 May 2026 15:56:35 +0800
Message-Id: <20260529075645.580362-14-dapeng1.mi@linux.intel.com>
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

This patch adds support for sampling XMM registers using the
sample_simd_vec_reg_* fields.

When sample_simd_regs_enabled is set, the original XMM space in the
sample_regs_* field is treated as reserved. An INVAL error will be
reported to user space if any bit is set in the original XMM space while
sample_simd_regs_enabled is set.

The perf_reg_value function requires ABI information to understand the
layout of sample_regs. To accommodate this, a new abi field is introduced
in the struct x86_perf_regs to represent ABI information.

Additionally, the X86-specific perf_simd_reg_value function is implemented
to retrieve the XMM register values.

Please note XMM sampling is not enabled yet, it will be enabled in a later
patch when PERF_PMU_CAP_SIMD_REGS is set.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 48 +++++++++++++++--
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/perf_event.h          | 12 +++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h | 13 +++++
 arch/x86/kernel/perf_regs.c           | 74 ++++++++++++++++++++++++++-
 include/linux/perf_event.h            |  1 +
 kernel/events/core.c                  |  2 +-
 8 files changed, 145 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f9e3f349b69a..5a4760a1716b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -718,6 +718,20 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (is_sampling_event(event) && !event->attr.precise_ip &&
 			    !this_cpu_has(X86_FEATURE_XSAVES))
 				return -EINVAL;
+			if (event->attr.sample_simd_regs_enabled)
+				return -EINVAL;
+		}
+
+		if (event_has_simd_regs(event)) {
+			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
+				return -EINVAL;
+			if (is_sampling_event(event) && !event->attr.precise_ip &&
+			    !this_cpu_has(X86_FEATURE_XSAVES))
+				return -EINVAL;
+			/* The vector registers set is not supported */
+			if (event_needs_xmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+				return -EINVAL;
 		}
 	}
 
@@ -1760,6 +1774,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 {
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 
+	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
 }
 
@@ -1780,13 +1795,14 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 
 /*
  * The x86 specific variant of perf_sample_regs_intr().
- * It would be extended to add more SIMD registers sampling support
- * in later patches.
+ * Update data->regs_intr fields for extended registers (e.g., SIMD).
  */
 static void x86_pmu_update_regs_intr(struct perf_event *event,
 				     struct perf_sample_data *data,
 				     struct pt_regs *regs)
 {
+	struct x86_perf_regs *perf_regs;
+
 	data->regs_intr.regs = regs;
 	data->regs_intr.abi  = perf_reg_abi(current);
 
@@ -1796,6 +1812,17 @@ static void x86_pmu_update_regs_intr(struct perf_event *event,
 				  sizeof(u64);
 	}
 
+	if (data->regs_intr.abi && event_has_simd_regs(event)) {
+		data->dyn_size += perf_update_xregs_size(event, true);
+		data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+	}
+
+	if (data->regs_intr.abi) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi = data->regs_intr.abi;
+	}
+
 	/*
 	 * Set PERF_SAMPLE_REGS_INTR to bypass perf_sample_regs_intr() call
 	 * in perf_prepare_sample() function.
@@ -1836,6 +1863,7 @@ static void x86_pmu_update_regs_user(struct perf_event *event,
 				     struct pt_regs *regs)
 {
 	struct perf_event_attr *attr = &event->attr;
+	struct x86_perf_regs *perf_regs;
 
 	if (user_mode(regs)) {
 		data->regs_user.abi = perf_reg_abi(current);
@@ -1858,6 +1886,17 @@ static void x86_pmu_update_regs_user(struct perf_event *event,
 	if (data->regs_user.regs)
 		data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
 
+	if (data->regs_user.abi && event_has_simd_regs(event)) {
+		data->dyn_size += perf_update_xregs_size(event, false);
+		data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+	}
+
+	if (data->regs_user.abi) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi = data->regs_user.abi;
+	}
+
 	/*
 	 * Set PERF_SAMPLE_REGS_USER to bypass perf_sample_regs_user() call
 	 * in perf_prepare_sample() function.
@@ -1926,7 +1965,7 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 	if (WARN_ON_ONCE(!xsave) || !in_nmi())
 		return;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= x86_pmu.ext_regs_mask;
@@ -1963,7 +2002,8 @@ void x86_pmu_update_perf_regs(struct perf_event *event,
 {
 	u64 sample_type = event->attr.sample_type;
 
-	if (!event_has_extended_regs(event))
+	if (!event_needs_xmm(event) &&
+	    !event_has_simd_regs(event))
 		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index bd43bf26e6bf..609d4a83115d 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1749,7 +1749,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index cff5fbac000b..b04f5ba3294a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -147,6 +147,18 @@ static inline bool is_acr_self_reload_event(struct perf_event *event)
 	return test_bit(hwc->idx, (unsigned long *)&hwc->config1);
 }
 
+static inline bool event_needs_xmm(struct perf_event *event)
+{
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
index e47a963a7cf0..e54d21c13494 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -726,6 +726,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		abi;
 	union {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..5b7d5216f0bd 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,4 +55,17 @@ enum perf_event_x86_regs {
 
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
index 81204cb7f723..7b9b38c189de 100644
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
@@ -74,6 +77,71 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
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
+int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
+			   u64 vec_mask_intr, u64 vec_mask_user,
+			   u16 pred_qwords, u32 pred_mask_intr,
+			   u32 pred_mask_user)
+{
+	u64 size;
+
+	if (!simd_enabled) {
+		if (vec_qwords || vec_mask_intr || vec_mask_user ||
+		    pred_qwords || pred_mask_intr || pred_mask_user)
+			return -EINVAL;
+		return 0;
+	}
+
+	if (!vec_qwords) {
+		if (vec_mask_intr || vec_mask_user)
+			return -EINVAL;
+	} else {
+		if (vec_qwords != PERF_X86_XMM_QWORDS)
+			return -EINVAL;
+		if ((!vec_mask_intr && !vec_mask_user) ||
+		    (vec_mask_intr & ~PERF_X86_SIMD_VEC_MASK) ||
+		    (vec_mask_user & ~PERF_X86_SIMD_VEC_MASK))
+			return -EINVAL;
+	}
+
+	if (pred_qwords || pred_mask_intr || pred_mask_user)
+		return -EINVAL;
+
+	size = ((vec_qwords * hweight64(vec_mask_intr)) +
+		(vec_qwords * hweight64(vec_mask_user)) +
+		(pred_qwords * hweight32(pred_mask_intr)) +
+		(pred_qwords * hweight32(pred_mask_user))) * sizeof(u64);
+	if (size > U16_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
@@ -89,7 +157,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
@@ -108,7 +177,8 @@ u64 perf_reg_abi(struct task_struct *task)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5f0642ef4fd2..baf694203d23 100644
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
index 94bb034da9b9..afd5b1408231 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8664,7 +8664,7 @@ static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
 	return d * !!(flags & s);
 }
 
-static u64 perf_update_xregs_size(struct perf_event *event, bool intr)
+u64 perf_update_xregs_size(struct perf_event *event, bool intr)
 {
 	u16 pred_qwords = event->attr.sample_simd_pred_reg_qwords;
 	u16 vec_qwords = event->attr.sample_simd_vec_reg_qwords;
-- 
2.34.1

