Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16E429BDA4;
	Wed,  3 Dec 2025 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745124; cv=none; b=WW+5raMPFZiMz6MCrKG+8+gpUMkyy0wLSBrTBQV8ajCRRWQ2159PrWCPLgSdtKtB0lBJzrVzRS7SG+lA1Df7/J9f+gKu13O7ytrg6xqEYiXQ4zqF/MCbUQh2jO9r0ICZYl05PLic3Sl6cS3jzFWDTi3vofYiDPGUCnQQo5Lz8sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745124; c=relaxed/simple;
	bh=QX/6ttqqehObHamaXaK/DPkxSTJWNicXOzbxdnXd70U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ao+h4gP8Mt2RqQWRrNtzOQ2hOcaK1ajG2Npi10kb3VJBOGMq4hZqBOxuwseBljlTzDu+bGldd87xfxwA6BPKJrFFOESsQS6qTB0QyWLb3BGRYwbvTnYtGjetz4C/RZLpttiRLlukwdS2Vijm5IuaJshY52XDuabzIks4tOrET+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZi1lsGJ; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZi1lsGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745122; x=1796281122;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QX/6ttqqehObHamaXaK/DPkxSTJWNicXOzbxdnXd70U=;
  b=FZi1lsGJrH8kyT77NOTxMBzE9SOsb+1cBTmYSbnZo3sOvBGvpM6rmMdH
   9tvGYB4UK+leT0szF6GNQuSTXqhydtCvvHZ7MRUuTyLoKVQa4lZnAcnJf
   GIBrL/pkY03L8/x9FcnhYvVHpLKlvgTmfyPKQwT5Ra3u8718Ffun3JX1N
   Ty/NkjByF5L34CtK2+iqecBZkauSVXFrACz65giCD0J3a+zHxSp0L5P7d
   +jwAPJjuMMhQj60sYSNQNmmWvY8vyqFR6J7FNaucjNPpxJlYU+Cd6hJAR
   6FEiEvxns8CLsRERfDwPkynCmsnKh4vgIaIWH600JjqSbnu16ES/brwOg
   Q==;
X-CSE-ConnectionGUID: PL2YICfGTQqDXT2gpVcKqA==
X-CSE-MsgGUID: YlOLm01+QQGUVQiT9/skeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324838"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324838"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:42 -0800
X-CSE-ConnectionGUID: 2v1UHBwZSrKLMk1TzZhKog==
X-CSE-MsgGUID: kk2oR39gT+SVwSugaXFp3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003884"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:36 -0800
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
Subject: [Patch v5 08/19] perf/x86: Enable XMM sampling using sample_simd_vec_reg_* fields
Date: Wed,  3 Dec 2025 14:54:49 +0800
Message-Id: <20251203065500.2597594-9-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c                | 78 ++++++++++++++++++++++++++-
 arch/x86/events/intel/ds.c            |  2 +-
 arch/x86/events/perf_event.h          | 12 +++++
 arch/x86/include/asm/perf_event.h     |  1 +
 arch/x86/include/uapi/asm/perf_regs.h | 17 ++++++
 arch/x86/kernel/perf_regs.c           | 51 +++++++++++++++++-
 6 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0d33668b1927..8f7e7e81daaf 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -719,6 +719,22 @@ int x86_pmu_hw_config(struct perf_event *event)
 				return -EINVAL;
 			if (!event->attr.precise_ip)
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
 
@@ -1760,6 +1776,7 @@ x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
 	struct perf_regs regs_user;
 
+	x86_regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_get_regs_user(&regs_user, regs);
 	data->regs_user.abi = regs_user.abi;
 	if (regs_user.regs) {
@@ -1772,9 +1789,26 @@ x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 
 static bool x86_pmu_user_req_pt_regs_only(struct perf_event *event)
 {
+	if (event->attr.sample_simd_regs_enabled)
+		return false;
 	return !(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK);
 }
 
+static inline void
+x86_pmu_update_ext_regs_size(struct perf_event_attr *attr,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs,
+			     u64 mask, u16 pred_mask)
+{
+	u16 pred_qwords = attr->sample_simd_pred_reg_qwords;
+	u16 vec_qwords = attr->sample_simd_vec_reg_qwords;
+	u64 pred_bitmap = pred_mask;
+	u64 bitmap = mask;
+
+	data->dyn_size += (hweight64(bitmap) * vec_qwords +
+			   hweight64(pred_bitmap) * pred_qwords) * sizeof(u64);
+}
+
 inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 {
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
@@ -1795,6 +1829,7 @@ static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 
 		if (user_mode(regs)) {
 			data->regs_user.abi = perf_reg_abi(current);
@@ -1817,17 +1852,24 @@ static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
 		data->dyn_size += sizeof(u64);
 		if (data->regs_user.regs)
 			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		perf_regs->abi |= data->regs_user.abi;
+		if (attr->sample_simd_regs_enabled)
+			perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 
 		data->regs_intr.regs = regs;
 		data->regs_intr.abi = perf_reg_abi(current);
 		data->dyn_size += sizeof(u64);
 		if (data->regs_intr.regs)
 			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
+		perf_regs->abi |= data->regs_intr.abi;
+		if (attr->sample_simd_regs_enabled)
+			perf_regs->abi |= PERF_SAMPLE_REGS_ABI_SIMD;
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
 }
@@ -1839,7 +1881,7 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	u64 mask = 0;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
 
 	mask &= ~ignore_mask;
@@ -1847,6 +1889,39 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 		x86_pmu_get_ext_regs(perf_regs, mask);
 }
 
+static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
+					     struct perf_sample_data *data,
+					     struct pt_regs *regs)
+{
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+
+	if (!attr->sample_simd_regs_enabled)
+		return;
+
+	if (!(attr->sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return;
+
+	/* Update the data[] size */
+	if (sample_type & PERF_SAMPLE_REGS_USER && data->regs_user.abi) {
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_ext_regs_size(attr, data, data->regs_user.regs,
+					     attr->sample_simd_vec_reg_user,
+					     attr->sample_simd_pred_reg_user);
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR && data->regs_intr.abi) {
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_ext_regs_size(attr, data, data->regs_intr.regs,
+					     attr->sample_simd_vec_reg_intr,
+					     attr->sample_simd_pred_reg_intr);
+	}
+}
+
 void x86_pmu_setup_regs_data(struct perf_event *event,
 			     struct perf_sample_data *data,
 			     struct pt_regs *regs,
@@ -1858,6 +1933,7 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 	 * which is unnessary to sample again.
 	 */
 	x86_pmu_sample_ext_regs(event, regs, ignore_mask);
+	x86_pmu_setup_extended_regs_data(event, data, regs);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index af462f69cd1c..79cba323eeb1 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1473,7 +1473,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3c470d79aa65..e5d8ad024553 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -133,6 +133,18 @@ static inline bool is_acr_event_group(struct perf_event *event)
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
index 3b368de9f803..5d623805bf87 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -704,6 +704,7 @@ extern void perf_events_lapic_init(void);
 struct pt_regs;
 struct x86_perf_regs {
 	struct pt_regs	regs;
+	u64		abi;
 	union {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 7c9d2bb3833b..c3862e5fdd6d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -55,4 +55,21 @@ enum perf_event_x86_regs {
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
 
+enum {
+	PERF_REG_X86_XMM,
+	PERF_REG_X86_MAX_SIMD_REGS,
+};
+
+enum {
+	PERF_X86_SIMD_XMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+};
+
+#define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
+
+enum {
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

