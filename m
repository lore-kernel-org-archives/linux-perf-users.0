Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B26F2EA173;
	Thu, 25 Sep 2025 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780891; cv=none; b=JuI+ZVkXB3jNrwYsRLs+AMGZik+BTrQHFXGDvWzPsil2xTdh4rw1URpOJyNcX2aeozR4zKj0+yNUa238eUIGmlzu8sagXAyVlB8EktoPlbBufQxBpCcPg8A5JiPSBHrrIEd2LMRNlr5EgwUyYAvNIqHqOCy7ibxi830T9n02T4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780891; c=relaxed/simple;
	bh=aq1En6e8G9BICHal3Zv5h+EUtGQ5o79GFQz8ly/BUwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fD4z72LXqs9p5lLohxPWghbW6iBIPgCYH03EwuBEUPKyYfmi0x6xkshL83QMm0mq+yXF9k0OpqrW1kOv8EzYtG5AMWVRiN8KfAVsAs0E4ZSx39fCdylNNLi+wVm2vnnJrFeVjxDHdzYSXbSoaSTPwdYA6VfxQHxpjeWOzNvC82U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ih1EgjJA; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ih1EgjJA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780889; x=1790316889;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aq1En6e8G9BICHal3Zv5h+EUtGQ5o79GFQz8ly/BUwQ=;
  b=ih1EgjJA3Kg1wwWSUBq+//9uzZ1d+AFg53y7l2tbdhziUFjY8pOggscJ
   Yo7F+MJueAZeH2f+aDBqnm5DhFbbl+dL7qypt2qtarhvDAMAzm0AQrjh9
   DfbqXr4Ij2saTbgqrIvnCzVbkC2PP5sxYRuO0OdzGH+qCy4uQq+BrJapn
   1XIjrpZf1j5rbTw5vqv8luy+VSTRwac1/zUmx6DEP+QvxfsmpzGzdK2yt
   MrUp0XjAwou2Qol/TRkjTPsSEU5MIzwxvo6zSUE6jlOtsNkYAW/mdLaI0
   UvuwKZIl9lFC4N8XdV2G91es3wWUkeTnVqIogP5TvzTYpL5Ji3ImPoUAE
   A==;
X-CSE-ConnectionGUID: lHV8CPv7RxCY8Mewya3Wfw==
X-CSE-MsgGUID: YN+zJAy8TJ+VrYthW+BHlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139556"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139556"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:49 -0700
X-CSE-ConnectionGUID: G8ntLm0PSNqmtKpKpfrrtA==
X-CSE-MsgGUID: CUN2VAKaTpuo308Sqb9j6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528380"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:43 -0700
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
Subject: [Patch v4 07/17] perf/x86: Move XMM to sample_simd_vec_regs
Date: Thu, 25 Sep 2025 14:12:03 +0800
Message-Id: <20250925061213.178796-8-dapeng1.mi@linux.intel.com>
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

The XMM0-15 are SIMD registers. Move them from sample_regs to
sample_simd_vec_regs. Reject access to the extended space of the
sample_regs if the new sample_simd_vec_regs is used.

The perf_reg_value requires the abi to understand the layout of the
sample_regs. Add the abi information in the struct x86_perf_regs.

Implement the X86-specific perf_simd_reg_validate to validate the SIMD
registers configuration from the user tool. Only the XMM0-15 is
supported now. More registers will be added in the following patches.
Implement the X86-specific perf_simd_reg_value to retrieve the XMM
value.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 110 ++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c            |   2 +-
 arch/x86/events/perf_event.h          |  12 +++
 arch/x86/include/asm/perf_event.h     |   1 +
 arch/x86/include/uapi/asm/perf_regs.h |  17 ++++
 arch/x86/kernel/perf_regs.c           |  63 ++++++++++++++-
 6 files changed, 195 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e363f5f2b37d..7b1b3eb80aa7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -709,6 +709,22 @@ int x86_pmu_hw_config(struct perf_event *event)
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
 
@@ -1749,6 +1765,7 @@ x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 	struct x86_perf_regs *x86_regs_user = this_cpu_ptr(&x86_user_regs);
 	struct perf_regs regs_user;
 
+	x86_regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_get_regs_user(&regs_user, regs);
 	data->regs_user.abi = regs_user.abi;
 	if (regs_user.regs) {
@@ -1761,23 +1778,43 @@ x86_pmu_perf_get_regs_user(struct perf_sample_data *data,
 
 static bool x86_pmu_user_req_pt_regs_only(struct perf_event *event)
 {
+	if (event->attr.sample_simd_regs_enabled)
+		return false;
 	return !(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK);
 }
 
-void x86_pmu_setup_regs_data(struct perf_event *event,
+static inline void
+x86_pmu_update_ext_regs_size(struct perf_event_attr *attr,
 			     struct perf_sample_data *data,
-			     struct pt_regs *regs,
-			     u64 ignore_mask)
+			     u64 ignore, struct pt_regs *regs,
+			     u64 mask, u16 pred_mask)
+{
+	u16 pred_qwords = attr->sample_simd_pred_reg_qwords;
+	u16 vec_qwords = attr->sample_simd_vec_reg_qwords;
+	u16 nr_pred = hweight16(pred_mask);
+	u16 nr_vectors = hweight64(mask);
+
+	perf_simd_reg_check(regs, ignore,
+			    mask, &nr_vectors, &vec_qwords,
+			    pred_mask, &nr_pred, &pred_qwords);
+	data->dyn_size += (nr_vectors * vec_qwords + nr_pred * pred_qwords) * sizeof(u64);
+}
+
+static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
+					  struct perf_sample_data *data,
+					  struct pt_regs *regs)
 {
-	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	struct perf_event_attr *attr = &event->attr;
 	u64 sample_type = attr->sample_type;
-	u64 mask = 0;
+	struct x86_perf_regs *perf_regs;
 
 	if (!(attr->sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
 		return;
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
+
 		if (user_mode(regs)) {
 			data->regs_user.abi = perf_reg_abi(current);
 			data->regs_user.regs = regs;
@@ -1799,26 +1836,83 @@ void x86_pmu_setup_regs_data(struct perf_event *event,
 		data->dyn_size += sizeof(u64);
 		if (data->regs_user.regs)
 			data->dyn_size += hweight64(attr->sample_regs_user) * sizeof(u64);
+		perf_regs->abi |= data->regs_user.abi;
 		data->sample_flags |= PERF_SAMPLE_REGS_USER;
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
+
 		data->regs_intr.regs = regs;
 		data->regs_intr.abi = perf_reg_abi(current);
 		data->dyn_size += sizeof(u64);
 		if (data->regs_intr.regs)
 			data->dyn_size += hweight64(attr->sample_regs_intr) * sizeof(u64);
+		perf_regs->abi |= data->regs_intr.abi;
 		data->sample_flags |= PERF_SAMPLE_REGS_INTR;
 	}
+}
+
+static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
+					     struct perf_sample_data *data,
+					     struct pt_regs *regs,
+					     u64 ignore_mask)
+{
+	struct perf_event_attr *attr = &event->attr;
+	u64 sample_type = attr->sample_type;
+	struct x86_perf_regs *perf_regs;
+	u64 mask = 0;
 
-	if (event_has_extended_regs(event)) {
-		perf_regs->xmm_regs = NULL;
+	if (!attr->sample_simd_regs_enabled)
+		return;
+
+	if (!(attr->sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return;
+
+	perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	perf_regs->xmm_regs = NULL;
+	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
-	}
 
 	mask &= ~ignore_mask;
 	if (mask)
 		x86_pmu_get_ext_regs(perf_regs, mask);
+
+	/* Update the data[] size */
+	if (sample_type & PERF_SAMPLE_REGS_USER && data->regs_user.abi) {
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_user.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_ext_regs_size(attr, data, ignore_mask,
+					     data->regs_user.regs,
+					     attr->sample_simd_vec_reg_user,
+					     attr->sample_simd_pred_reg_user);
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_INTR && data->regs_intr.abi) {
+		/* num and qwords of vector and pred registers */
+		data->dyn_size += sizeof(u64);
+		data->regs_intr.abi |= PERF_SAMPLE_REGS_ABI_SIMD;
+		x86_pmu_update_ext_regs_size(attr, data, ignore_mask,
+					     data->regs_intr.regs,
+					     attr->sample_simd_vec_reg_intr,
+					     attr->sample_simd_pred_reg_intr);
+	}
+}
+
+void x86_pmu_setup_regs_data(struct perf_event *event,
+			     struct perf_sample_data *data,
+			     struct pt_regs *regs,
+			     u64 ignore_mask)
+{
+	x86_pmu_setup_basic_regs_data(event, data, regs);
+	/*
+	 * ignore_mask indicates the PEBS sampled extended regs which is unnessary
+	 * to sample again.
+	 */
+	x86_pmu_setup_extended_regs_data(event, data, regs, ignore_mask);
 }
 
 int x86_pmu_handle_irq(struct pt_regs *regs)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index f95dfee6adb2..59dbbc1c9968 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1415,7 +1415,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if (event_has_extended_regs(event))
+	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7bf24842b1dc..6f22ed718a75 100644
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
index 8f18903ea9d0..fd4fe31e510b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -596,6 +596,7 @@ extern void perf_events_lapic_init(void);
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
index 624703af80a1..6fd691cb7e64 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -57,12 +57,29 @@ static unsigned int pt_regs_offset[PERF_REG_X86_MAX] = {
 #endif
 };
 
+void perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
+			 u64 mask, u16 *nr_vectors, u16 *vec_qwords,
+			 u16 pred_mask, u16 *nr_pred, u16 *pred_qwords)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+
+	if (!(ignore & XFEATURE_MASK_SSE) &&
+	    *vec_qwords >= PERF_X86_XMM_QWORDS &&
+	    !perf_regs->xmm_regs)
+		*nr_vectors = 0;
+
+	*nr_pred = 0;
+}
+
 u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
 	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
+		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
+			return 0;
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
@@ -74,6 +91,49 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
+			u16 qwords_idx, bool pred)
+{
+	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
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
+		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
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
 
@@ -114,7 +174,8 @@ void perf_get_regs_user(struct perf_regs *regs_user,
 
 int perf_reg_validate(u64 mask)
 {
-	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+	/* The mask could be 0 if only the SIMD registers are interested */
+	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

