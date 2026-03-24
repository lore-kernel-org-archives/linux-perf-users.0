Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C655036C0CB;
	Tue, 24 Mar 2026 00:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313219; cv=none; b=LS4A1mxNgdQjThGEBmk7YJ6/bhSf8WZljvKkhRWjrVmiFB1tnMc9qcgpUfpnHTp87561jZaDC19u01Wr02hRuCisQmImRyMDC2d+MYhSyWWy/fsRR6WDAln6R2srSMbuTdtPKnLvmyE0+NP5Doeceff8eSARoSB2gJ9iJ8uJErM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313219; c=relaxed/simple;
	bh=Kk+WXC3xpTdQHWn1C/1CBJVVcyZsrWG4vk8UnETlIak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TPJR+rPxf9+b5c8QryfCaMBX9Zq9uBO9czwdO9UYxt5KMaG4FYGsF61vl8pOKvZeDotcowgl+LV24zP1rOgOY+/hdJofGX1t+RVYsWRs875BAGHmM0TwGz7Q63oCcTzK2jNrjNP2xNvdBDUoCNzwX0833p5x3+l3PJo/HcnrxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O329OxDx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O329OxDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313218; x=1805849218;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kk+WXC3xpTdQHWn1C/1CBJVVcyZsrWG4vk8UnETlIak=;
  b=O329OxDxKzt1ixvhNLmruCSioAuOrz/9dFqaQyho32Nkbz+n9jlRe7r/
   xjS/BklB52CetvY0mOHvx5Qcv99EhajT2j35wIIzBARnoPDVBrrnjuStE
   hFDFKHaNX4c6TPdACb/Y/uGScSHyElA8Ew5qr/fxSDs7xPb/CCvTf+6bp
   9LbBLhhpjzPTjxFTJfncLzH9jvPDMyRfj5YxxIbuwFHXS5QtZd3S/eUtu
   KfNfcJl3uogB7ofD2BMCJwv5m//25oN09TEgWqYfAAOGdBTuJZVshfTL8
   yxyoZPHj180tDoGDciQkycQpZPMEL4jiXdsMMTBX5lZyXMc9+h8/f5sk2
   g==;
X-CSE-ConnectionGUID: UrLSnzwUQzGuQN9LKKFivQ==
X-CSE-MsgGUID: 9JEi/mEISKGb/DGJqq6Tng==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397172"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397172"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:46:57 -0700
X-CSE-ConnectionGUID: 2CCRRNM1TlO3Be2YvN4ydw==
X-CSE-MsgGUID: 4wLST9clRsqDLkzL5VAwhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322843"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:53 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v7 14/24] perf/x86: Enable XMM sampling using sample_simd_vec_reg_* fields
Date: Tue, 24 Mar 2026 08:41:08 +0800
Message-Id: <20260324004118.3772171-15-dapeng1.mi@linux.intel.com>
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

From: Kan Liang <kan.liang@linux.intel.com>

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

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 89 +++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/perf_event.h          | 12 ++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h | 13 ++++
 arch/x86/kernel/perf_regs.c           | 51 ++++++++++++++-
 6 files changed, 161 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a5643c875190..3c9b79b46a66 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -704,6 +704,22 @@ int x86_pmu_hw_config(struct perf_event *event)
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
+			/* Not require any vector registers but set width */
+			if (event->attr.sample_simd_vec_reg_qwords &&
+			    !event->attr.sample_simd_vec_reg_intr &&
+			    !event->attr.sample_simd_vec_reg_user)
+				return -EINVAL;
+			/* The vector registers set is not supported */
+			if (event_needs_xmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
+				return -EINVAL;
 		}
 	}
 
@@ -1749,6 +1765,7 @@ static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
 	struct perf_regs regs_user;
 
+	x86_regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_get_regs_user(&regs_user, regs);
 	data->regs_user.abi = regs_user.abi;
 	if (regs_user.regs) {
@@ -1758,12 +1775,26 @@ static void x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 		data->regs_user.regs = NULL;
 }
 
+static inline void
+x86_pmu_update_xregs_size(struct perf_event_attr *attr,
+			  struct perf_sample_data *data,
+			  struct pt_regs *regs,
+			  u64 mask, u64 pred_mask)
+{
+	u16 pred_qwords = attr->sample_simd_pred_reg_qwords;
+	u16 vec_qwords = attr->sample_simd_vec_reg_qwords;
+
+	data->dyn_size += (hweight64(mask) * vec_qwords +
+			   hweight64(pred_mask) * pred_qwords) * sizeof(u64);
+}
+
 static void x86_pmu_setup_gpregs_data(struct perf_event *event,
 				      struct perf_sample_data *data,
 				      struct pt_regs *regs)
 {
 	struct perf_event_attr *attr = &event->attr;
 	u64 sample_type = attr->sample_type;
+	struct x86_perf_regs *perf_regs;
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		if (user_mode(regs)) {
@@ -1783,8 +1814,13 @@ static void x86_pmu_setup_gpregs_data(struct perf_event *event,
 			data->regs_user.regs = NULL;
 		}
 		data->dyn_size += sizeof(u64);
-		if (data->regs_user.regs)
-			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		if (data->regs_user.regs) {
+			data->dyn_size +=
+				hweight64(attr->sample_regs_user) * sizeof(u64);
+			perf_regs = container_of(data->regs_user.regs,
+						 struct x86_perf_regs, regs);
+			perf_regs->abi = data->regs_user.abi;
+		}
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
@@ -1792,8 +1828,13 @@ static void x86_pmu_setup_gpregs_data(struct perf_event *event,
 		data->regs_intr.regs = regs;
 		data->regs_intr.abi = perf_reg_abi(current);
 		data->dyn_size += sizeof(u64);
-		if (data->regs_intr.regs)
-			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
+		if (data->regs_intr.regs) {
+			data->dyn_size +=
+				hweight64(attr->sample_regs_intr) * sizeof(u64);
+			perf_regs = container_of(data->regs_intr.regs,
+						 struct x86_perf_regs, regs);
+			perf_regs->abi = data->regs_intr.abi;
+		}
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 }
@@ -1871,7 +1912,7 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 	if (WARN_ON_ONCE(!xsave))
 		return;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= x86_pmu.ext_regs_mask;
@@ -1899,6 +1940,43 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 	}
 }
 
+static void x86_pmu_setup_xregs_data(struct perf_event *event,
+					     struct perf_sample_data *data)
+{
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+	struct x86_perf_regs *perf_regs;
+
+	if (!attr->sample_simd_regs_enabled)
+		return;
+
+	if (sample_type & PERF_SAMPLE_REGS_USER && data->regs_user.abi) {
+		perf_regs = container_of(data->regs_user.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_xregs_size(attr, data, data->regs_user.regs,
+					  attr->sample_simd_vec_reg_user,
+					  attr->sample_simd_pred_reg_user);
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR && data->regs_intr.abi) {
+		perf_regs = container_of(data->regs_intr.regs,
+					 struct x86_perf_regs, regs);
+		perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_xregs_size(attr, data, data->regs_intr.regs,
+					  attr->sample_simd_vec_reg_intr,
+					  attr->sample_simd_pred_reg_intr);
+	}
+}
+
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
 			     struct pt_regs *regs,
@@ -1910,6 +1988,7 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 	 * which are unnecessary to sample again.
 	 */
 	x86_pmu_sample_xregs(event, data, ignore_mask);
+	x86_pmu_setup_xregs_data(event, data);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 74a41dae8a62..ac9a1c2f0177 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1743,7 +1743,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index a5e5bffb711e..26d162794a36 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -137,6 +137,18 @@ static inline bool is_acr_event_group(struct perf_event *event)
 	return check_leader_group(event->group_leader, PERF_X86_EVENT_ACR);
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
index 7c9d2bb3833b..c5c1b3930df1 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,4 +55,17 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+enum {
+	PERF_X86_SIMD_XMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+};
+
+#define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+enum {
+	/* 1 qword = 8 bytes */
+	PERF_X86_XMM_QWORDS      = 2,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+};
+
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 81204cb7f723..9947a6b5c260 100644
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
@@ -74,6 +77,51 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred)
+{
+	struct x86_perf_regs *perf_regs =
+			container_of(regs, struct x86_perf_regs, regs);
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
+int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
+			   u16 pred_qwords, u32 pred_mask)
+{
+	/* pred_qwords implies sample_simd_{pred,vec}_reg_* are supported */
+	if (!pred_qwords)
+		return 0;
+
+	if (!vec_qwords) {
+		if (vec_mask)
+			return -EINVAL;
+	} else {
+		if (vec_qwords != PERF_X86_XMM_QWORDS)
+			return -EINVAL;
+		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
+			return -EINVAL;
+	}
+	if (pred_mask)
+		return -EINVAL;
+
+	return 0;
+}
+
 #define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
@@ -108,7 +156,8 @@ u64 perf_reg_abi(struct task_struct *task)
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

