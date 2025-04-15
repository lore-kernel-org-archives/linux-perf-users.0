Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672B521348;
	Tue, 15 Apr 2025 08:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744705453; cv=none; b=e43KiTSwtvzdGHjaKlYLqXNg3sU8YcWNlVMJC2lAwBM6oJMCP2vbYmxN/5vWkz8an7mrXJhAt3tMRGqJ/0a6ATmP0yz8V4xcBPfuV4s4xRiB56jMswjbX64wEHXqP+MNLsH3K4oFvWfTohKnjRuoDStJYA9e5jsQdulsQA+8qgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744705453; c=relaxed/simple;
	bh=SDnBVN5iRq8yfd8DXONLFO4QH16pPwUoYjJQqkRNOxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gdHsih4srMt+MZU/HKcDgwe/Za8CmunFXg+2qxsUchukzASAcMXQM3nc1zUKChz6CZo7MXOJovtaHEL4gFZcbENFAqZOagNi0APn43RhYm5Dswihg8Y1EKBgg2MgvWmKLobA/o/vqBM4S9/rzzDbU3KzPK0ZDxGbx5M+b7Qh1Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzdAmdBc; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzdAmdBc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744705452; x=1776241452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDnBVN5iRq8yfd8DXONLFO4QH16pPwUoYjJQqkRNOxQ=;
  b=kzdAmdBczlxAm6uLTRFjDyBitwlv83wG3frN5YkSdJdxIINeysIxMefB
   1zFMLgMYBufvGp1fpzIg7W0it6dNU7BFl9aTgPiyjvsEsuxOkyMfrWuQL
   HCqoUB6fFZlOhcYF7KB1vv+e79KxwSKibIXNj3kr5XPZv3DQpqN/N/bDx
   F3arC8+XTh1PN9lP3m7U+I5zdFZzI9l6zuIEzKQxlw7pdQZUhrwD3sIzz
   zMPes5IxyPw7j4QfG77VImVDbG9d/gK7/iwIH8DeyFHZGpQG9Sy+d8vlT
   s1o+QMYI1TtJvIxLCVH8cholf44Ngy0QaGDPccuNI+ScwxZu/KRp0P5tB
   Q==;
X-CSE-ConnectionGUID: /wi+RzIpQDW01ky0S5yVAw==
X-CSE-MsgGUID: Ze8bV6y4TOSE9ka/at6yfQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="46116102"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="46116102"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 01:24:12 -0700
X-CSE-ConnectionGUID: vpqzoh33R2CedmuJU2OW7Q==
X-CSE-MsgGUID: pgzA67D4TY6SOkPhOtiaIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="130055663"
Received: from emr.sh.intel.com ([10.112.229.56])
  by fmviesa007.fm.intel.com with ESMTP; 15 Apr 2025 01:24:07 -0700
From: Dapeng Mi <dapeng1.mi@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dapeng Mi <dapeng1.mi@intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v3 17/22] perf/x86/intel: Support arch-PEBS vector registers group capturing
Date: Tue, 15 Apr 2025 11:44:23 +0000
Message-Id: <20250415114428.341182-18-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add x86/intel specific vector register (VECR) group capturing for
arch-PEBS. Enable corresponding VECR group bits in
GPx_CFG_C/FX0_CFG_C MSRs if users configures these vector registers
bitmap in perf_event_attr and parse VECR group in arch-PEBS record.

Currently vector registers capturing is only supported by PEBS based
sampling, PMU driver would return error if PMI based sampling tries to
capture these vector registers.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 90 +++++++++++++++++++++++++++++-
 arch/x86/events/intel/core.c      | 15 +++++
 arch/x86/events/intel/ds.c        | 93 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  6 ++
 arch/x86/include/asm/perf_event.h | 20 +++++++
 5 files changed, 214 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0ccbe8385c7f..16f019ff44f1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -580,6 +580,73 @@ int x86_pmu_max_precise(struct pmu *pmu)
 	return precise;
 }
 
+static bool has_vec_regs(struct perf_event *event, bool user,
+			 int start, int end)
+{
+	int idx = (start - PERF_REG_EXTENDED_OFFSET) / 64;
+	int s = start % 64;
+	int e = end % 64;
+	u64 regs_mask;
+
+	if (user)
+		regs_mask = event->attr.sample_regs_user_ext[idx];
+	else
+		regs_mask = event->attr.sample_regs_intr_ext[idx];
+
+	return regs_mask & GENMASK_ULL(e, s);
+}
+
+static inline bool has_ymm_regs(struct perf_event *event, bool user)
+{
+	return has_vec_regs(event, user, PERF_REG_X86_YMM0, PERF_REG_X86_YMM_MAX - 1);
+}
+
+static inline bool has_zmm_regs(struct perf_event *event, bool user)
+{
+	return has_vec_regs(event, user, PERF_REG_X86_ZMM0, PERF_REG_X86_ZMM8 - 1) ||
+	       has_vec_regs(event, user, PERF_REG_X86_ZMM8, PERF_REG_X86_ZMM16 - 1);
+}
+
+static inline bool has_h16zmm_regs(struct perf_event *event, bool user)
+{
+	return has_vec_regs(event, user, PERF_REG_X86_ZMM16, PERF_REG_X86_ZMM24 - 1) ||
+	       has_vec_regs(event, user, PERF_REG_X86_ZMM24, PERF_REG_X86_ZMM_MAX - 1);
+}
+
+static inline bool has_opmask_regs(struct perf_event *event, bool user)
+{
+	return has_vec_regs(event, user, PERF_REG_X86_OPMASK0, PERF_REG_X86_OPMASK7);
+}
+
+static bool ext_vec_regs_supported(struct perf_event *event, bool user)
+{
+	u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
+
+	if (!(event->pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS))
+		return false;
+
+	if (has_opmask_regs(event, user) && !(caps & ARCH_PEBS_VECR_OPMASK))
+		return false;
+
+	if (has_ymm_regs(event, user) && !(caps & ARCH_PEBS_VECR_YMMH))
+		return false;
+
+	if (has_zmm_regs(event, user) && !(caps & ARCH_PEBS_VECR_ZMMH))
+		return false;
+
+	if (has_h16zmm_regs(event, user) && !(caps & ARCH_PEBS_VECR_H16ZMM))
+		return false;
+
+	if (!event->attr.precise_ip)
+		return false;
+
+	/* Only user space sampling is allowed for extended vector registers. */
+	if (user && !event->attr.exclude_kernel)
+		return false;
+
+	return true;
+}
+
 int x86_pmu_hw_config(struct perf_event *event)
 {
 	if (event->attr.precise_ip) {
@@ -665,9 +732,12 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
-	/* sample_regs_user never support XMM registers */
-	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK))
-		return -EINVAL;
+	if (unlikely(event->attr.sample_regs_user & PERF_REG_EXTENDED_MASK)) {
+		/* Only user space sampling is allowed for XMM registers. */
+		if (!event->attr.exclude_kernel)
+			return -EINVAL;
+	}
+
 	/*
 	 * Besides the general purpose registers, XMM registers may
 	 * be collected in PEBS on some platforms, e.g. Icelake
@@ -680,6 +750,20 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/*
+	 * Architectural PEBS supports to capture more vector registers besides
+	 * XMM registers, like YMM, OPMASK and ZMM registers.
+	 */
+	if (unlikely(has_more_extended_user_regs(event))) {
+		if (!ext_vec_regs_supported(event, true))
+			return -EINVAL;
+	}
+
+	if (unlikely(has_more_extended_intr_regs(event))) {
+		if (!ext_vec_regs_supported(event, false))
+			return -EINVAL;
+	}
+
 	return x86_setup_perfctr(event);
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index b6416535f84d..9bd77974d83b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3007,6 +3007,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
 
+			if (pebs_data_cfg & PEBS_DATACFG_YMMHS)
+				ext |= ARCH_PEBS_VECR_YMMH & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_OPMASKS)
+				ext |= ARCH_PEBS_VECR_OPMASK & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_ZMMHS)
+				ext |= ARCH_PEBS_VECR_ZMMH & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_H16ZMMS)
+				ext |= ARCH_PEBS_VECR_H16ZMM & cap.caps;
+
 			if (pebs_data_cfg & PEBS_DATACFG_LBRS)
 				ext |= ARCH_PEBS_LBR & cap.caps;
 
@@ -5426,6 +5438,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
 
 	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
+		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 91a093cba11f..26220bfbe885 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1425,6 +1425,34 @@ void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc)
 				PERF_SAMPLE_TRANSACTION |		     \
 				PERF_SAMPLE_DATA_PAGE_SIZE)
 
+static u64 pebs_get_ext_reg_data_cfg(unsigned long *ext_reg)
+{
+	u64 pebs_data_cfg = 0;
+	int bit;
+
+	for_each_set_bit(bit, ext_reg, PERF_NUM_EXT_REGS) {
+		switch (bit + PERF_REG_EXTENDED_OFFSET) {
+		case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
+			pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+			break;
+		case PERF_REG_X86_YMM0 ... PERF_REG_X86_YMM_MAX - 1:
+			pebs_data_cfg |= PEBS_DATACFG_YMMHS | PEBS_DATACFG_XMMS;
+			break;
+		case PERF_REG_X86_ZMM0 ... PERF_REG_X86_ZMM16 - 1:
+			pebs_data_cfg |= PEBS_DATACFG_ZMMHS | PEBS_DATACFG_YMMHS |
+					 PEBS_DATACFG_XMMS;
+			break;
+		case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
+			pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return pebs_data_cfg;
+}
+
 static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 {
 	struct perf_event_attr *attr = &event->attr;
@@ -1459,9 +1487,21 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
-		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK)
+			pebs_data_cfg |= PEBS_DATACFG_XMMS;
+
+		pebs_data_cfg |= pebs_get_ext_reg_data_cfg(
+			(unsigned long *)event->attr.sample_regs_intr_ext);
+	}
+
+	if (sample_type & PERF_SAMPLE_REGS_USER) {
+		if (attr->sample_regs_user & PERF_REG_EXTENDED_MASK)
+			pebs_data_cfg |= PEBS_DATACFG_XMMS;
+
+		pebs_data_cfg |= pebs_get_ext_reg_data_cfg(
+			(unsigned long *)event->attr.sample_regs_user_ext);
+	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
@@ -2245,6 +2285,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
@@ -2362,6 +2406,10 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
@@ -2412,14 +2460,45 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 					   meminfo->tsx_tuning, ax);
 	}
 
-	if (header->xmm) {
+	if (header->xmm || header->ymmh || header->opmask ||
+	    header->zmmh || header->h16zmm) {
 		struct arch_pebs_xmm *xmm;
+		struct arch_pebs_ymmh *ymmh;
+		struct arch_pebs_zmmh *zmmh;
+		struct arch_pebs_h16zmm *h16zmm;
+		struct arch_pebs_opmask *opmask;
 
 		next_record += sizeof(struct arch_pebs_xer_header);
 
-		xmm = next_record;
-		perf_regs->xmm_regs = xmm->xmm;
-		next_record = xmm + 1;
+		if (header->xmm) {
+			xmm = next_record;
+			perf_regs->xmm_regs = xmm->xmm;
+			next_record = xmm + 1;
+		}
+
+		if (header->ymmh) {
+			ymmh = next_record;
+			perf_regs->ymmh_regs = ymmh->ymmh;
+			next_record = ymmh + 1;
+		}
+
+		if (header->opmask) {
+			opmask = next_record;
+			perf_regs->opmask_regs = opmask->opmask;
+			next_record = opmask + 1;
+		}
+
+		if (header->zmmh) {
+			zmmh = next_record;
+			perf_regs->zmmh_regs = zmmh->zmmh;
+			next_record = zmmh + 1;
+		}
+
+		if (header->h16zmm) {
+			h16zmm = next_record;
+			perf_regs->h16zmm_regs = h16zmm->h16zmm;
+			next_record = h16zmm + 1;
+		}
 	}
 
 	if (header->lbr) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index c971ac09d881..93193eb6ff94 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -328,6 +328,12 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
+#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
+#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
+#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
+#define ARCH_PEBS_VECR_EXT_SHIFT	50
+#define ARCH_PEBS_VECR_EXT		(0x3full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 560eb218868c..a7b2548bf7b4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -142,6 +142,10 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
 #define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_YMMHS	BIT_ULL(6)
+#define PEBS_DATACFG_OPMASKS	BIT_ULL(7)
+#define PEBS_DATACFG_ZMMHS	BIT_ULL(8)
+#define PEBS_DATACFG_H16ZMMS	BIT_ULL(9)
 #define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
@@ -589,6 +593,22 @@ struct arch_pebs_xmm {
 	u64 xmm[16*2];		/* two entries for each register */
 };
 
+struct arch_pebs_ymmh {
+	u64 ymmh[16*2];		/* two entries for each register */
+};
+
+struct arch_pebs_opmask {
+	u64 opmask[8];
+};
+
+struct arch_pebs_zmmh {
+	u64 zmmh[16*4];		/* four entries for each register */
+};
+
+struct arch_pebs_h16zmm {
+	u64 h16zmm[16*8];	/* eight entries for each register */
+};
+
 #define ARCH_PEBS_LBR_NAN		0x0
 #define ARCH_PEBS_LBR_NUM_8		0x1
 #define ARCH_PEBS_LBR_NUM_16		0x2
-- 
2.40.1

