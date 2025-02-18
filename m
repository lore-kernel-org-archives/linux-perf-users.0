Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7382C239589;
	Tue, 18 Feb 2025 08:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866495; cv=none; b=lyKv2agLHhqTB6RLcIiArYZq57We+GlBi3caLSnmROBYL7QDWrC8dpBBvnUAPgZP48dhzXFKZrw2rq8kIjhbxPuFXMC5yWU4o11w7Dr2CqXGFR6vnqkNSc4g1OCoKg4gpAqBKSmY9eVL1e+JnM6Q3VTEaExWzSKTxgs4JTl3X2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866495; c=relaxed/simple;
	bh=GTrYE0UhuT2XNJGVxz2LpbCo4i+AhIymIjn8ZUNcynk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cst/tZtGATZrcyIMwAeCynirUNGqUizvsYrCf3bV3awdhXkkrHixxAEdErlt+5RaOkG72Jk1sCd+H5PHispm46VDQrCing9TM/lQjTST+hGRpdfc82qCkLb36U8P/02bcg0iueQYqjnx/6IAlLevMwxvCH1ON3geVmneXXsEVpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEV5toMm; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEV5toMm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739866494; x=1771402494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GTrYE0UhuT2XNJGVxz2LpbCo4i+AhIymIjn8ZUNcynk=;
  b=fEV5toMmoyiA7/wMnYtL8QI2EZzOliQpIr06nkCcOR/l5n6Fq7c6Ok2u
   VDwOwexiHjt+Lw9OrtzDaPGrngIcn+mXRhmDpNYjpB4m6aqIGkLYjI0Q6
   Cw0GFPo6prU1FuQnPckmMg0L3C+yBbIMsNBO5gCDEVHEJea5y+m82gTjC
   mo3dXmoJYcQP1r9YYzM9Vg0QiFW9Ksfez1XRYWOm+Uspqq0fU/5ffPHBr
   4Zf3NBs4ExmTmR3BJ/ocB6Et32DIqgpLt66z6gzZHSlTG4pj4TZWIitJE
   pMYGKpXT+w/O5K6zUgo+WImGWbCI/D+/NgegaUlLZD9RX1kiEq1lQMvKY
   A==;
X-CSE-ConnectionGUID: yngDeBlfR3ye5zWiLrKEVQ==
X-CSE-MsgGUID: NSqif1qvRmuPDwQ9EjoRIg==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="44200852"
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="44200852"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 00:14:54 -0800
X-CSE-ConnectionGUID: rtJlEDvmS3iB8DWnWZ5CqQ==
X-CSE-MsgGUID: jE4/+i+TT0SFw7fUcS4iww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,295,1732608000"; 
   d="scan'208";a="145166296"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa002.jf.intel.com with ESMTP; 18 Feb 2025 00:14:49 -0800
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
Subject: [Patch v2 18/24] perf/x86/intel: Support arch-PEBS vector registers group capturing
Date: Tue, 18 Feb 2025 15:28:12 +0000
Message-Id: <20250218152818.158614-19-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
References: <20250218152818.158614-1-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c            | 59 ++++++++++++++++++++++
 arch/x86/events/intel/core.c      | 15 ++++++
 arch/x86/events/intel/ds.c        | 82 ++++++++++++++++++++++++++++---
 arch/x86/include/asm/msr-index.h  |  6 +++
 arch/x86/include/asm/perf_event.h | 20 ++++++++
 5 files changed, 175 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d5609c0756c2..4d4b92b78e2d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -581,6 +581,39 @@ int x86_pmu_max_precise(struct pmu *pmu)
 	return precise;
 }
 
+static bool has_vec_regs(struct perf_event *event, int start, int end)
+{
+	/* -1 to subtract PERF_REG_EXTENDED_OFFSET */
+	int idx = start / 64 - 1;
+	int s = start % 64;
+	int e = end % 64;
+
+	return event->attr.sample_regs_intr_ext[idx] & GENMASK_ULL(e, s);
+}
+
+static inline bool has_ymmh_regs(struct perf_event *event)
+{
+	return has_vec_regs(event, PERF_REG_X86_YMMH0, PERF_REG_X86_YMMH15 + 1);
+}
+
+static inline bool has_zmmh_regs(struct perf_event *event)
+{
+	return has_vec_regs(event, PERF_REG_X86_ZMMH0, PERF_REG_X86_ZMMH7 + 3) ||
+	       has_vec_regs(event, PERF_REG_X86_ZMMH8, PERF_REG_X86_ZMMH15 + 3);
+}
+
+static inline bool has_h16zmm_regs(struct perf_event *event)
+{
+	return has_vec_regs(event, PERF_REG_X86_ZMM16, PERF_REG_X86_ZMM19 + 7) ||
+	       has_vec_regs(event, PERF_REG_X86_ZMM20, PERF_REG_X86_ZMM27 + 7) ||
+	       has_vec_regs(event, PERF_REG_X86_ZMM28, PERF_REG_X86_ZMM31 + 7);
+}
+
+static inline bool has_opmask_regs(struct perf_event *event)
+{
+	return has_vec_regs(event, PERF_REG_X86_OPMASK0, PERF_REG_X86_OPMASK7);
+}
+
 int x86_pmu_hw_config(struct perf_event *event)
 {
 	if (event->attr.precise_ip) {
@@ -676,6 +709,32 @@ int x86_pmu_hw_config(struct perf_event *event)
 			return -EINVAL;
 	}
 
+	/*
+	 * Architectural PEBS supports to capture more vector registers besides
+	 * XMM registers, like YMM, OPMASK and ZMM registers.
+	 */
+	if (unlikely(has_more_extended_regs(event))) {
+		u64 caps = hybrid(event->pmu, arch_pebs_cap).caps;
+
+		if (!(event->pmu->capabilities & PERF_PMU_CAP_MORE_EXT_REGS))
+			return -EINVAL;
+
+		if (has_opmask_regs(event) && !(caps & ARCH_PEBS_VECR_OPMASK))
+			return -EINVAL;
+
+		if (has_ymmh_regs(event) && !(caps & ARCH_PEBS_VECR_YMM))
+			return -EINVAL;
+
+		if (has_zmmh_regs(event) && !(caps & ARCH_PEBS_VECR_ZMMH))
+			return -EINVAL;
+
+		if (has_h16zmm_regs(event) && !(caps & ARCH_PEBS_VECR_H16ZMM))
+			return -EINVAL;
+
+		if (!event->attr.precise_ip)
+			return -EINVAL;
+	}
+
 	return x86_setup_perfctr(event);
 }
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f21d9f283445..8ef5b9a05fcc 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2963,6 +2963,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
 
+			if (pebs_data_cfg & PEBS_DATACFG_YMMS)
+				ext |= ARCH_PEBS_VECR_YMM & cap.caps;
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
 
@@ -5115,6 +5127,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
 
 	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
+
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
+		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
 }
 
 static inline void __intel_update_large_pebs_flags(struct pmu *pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 4b01beee15f4..7e5a4202de37 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1413,6 +1413,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	u64 sample_type = attr->sample_type;
 	u64 pebs_data_cfg = 0;
 	bool gprs, tsx_weight;
+	int bit = 0;
 
 	if (!(sample_type & ~(PERF_SAMPLE_IP|PERF_SAMPLE_TIME)) &&
 	    attr->precise_ip > 1)
@@ -1437,9 +1438,37 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (gprs || (attr->precise_ip < 2) || tsx_weight)
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
-	if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
-	    (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK))
-		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+	if (sample_type & PERF_SAMPLE_REGS_INTR) {
+		if (attr->sample_regs_intr & PERF_REG_EXTENDED_MASK)
+			pebs_data_cfg |= PEBS_DATACFG_XMMS;
+
+		for_each_set_bit_from(bit,
+			(unsigned long *)event->attr.sample_regs_intr_ext,
+			PERF_NUM_EXT_REGS) {
+			switch (bit + PERF_REG_EXTENDED_OFFSET) {
+			case PERF_REG_X86_OPMASK0 ... PERF_REG_X86_OPMASK7:
+				pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+				bit = PERF_REG_X86_YMMH0 -
+				      PERF_REG_EXTENDED_OFFSET - 1;
+				break;
+			case PERF_REG_X86_YMMH0 ... PERF_REG_X86_ZMMH0 - 1:
+				pebs_data_cfg |= PEBS_DATACFG_YMMS;
+				bit = PERF_REG_X86_ZMMH0 -
+				      PERF_REG_EXTENDED_OFFSET - 1;
+				break;
+			case PERF_REG_X86_ZMMH0 ... PERF_REG_X86_ZMM16 - 1:
+				pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
+				bit = PERF_REG_X86_ZMM16 -
+				      PERF_REG_EXTENDED_OFFSET - 1;
+				break;
+			case PERF_REG_X86_ZMM16 ... PERF_REG_X86_ZMM_MAX - 1:
+				pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+				bit = PERF_REG_X86_ZMM_MAX -
+				      PERF_REG_EXTENDED_OFFSET - 1;
+				break;
+			}
+		}
+	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
@@ -2223,6 +2252,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
@@ -2340,6 +2373,10 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
@@ -2390,14 +2427,45 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
+			perf_regs->zmmh_regs = (u64 **)zmmh->zmmh;
+			next_record = zmmh + 1;
+		}
+
+		if (header->h16zmm) {
+			h16zmm = next_record;
+			perf_regs->h16zmm_regs = (u64 **)h16zmm->h16zmm;
+			next_record = h16zmm + 1;
+		}
 	}
 
 	if (header->lbr) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 0ca84deb2396..973f875cec27 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -326,6 +326,12 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_VECR_YMM		BIT_ULL(50)
+#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
+#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
+#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
+#define ARCH_PEBS_VECR_EXT_SHIFT	50
+#define ARCH_PEBS_VECR_EXT		(0x3full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 3bf8dcaa72ca..5f4f30ce6c4c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -142,6 +142,10 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
 #define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_YMMS	BIT_ULL(6)
+#define PEBS_DATACFG_OPMASKS	BIT_ULL(7)
+#define PEBS_DATACFG_ZMMHS	BIT_ULL(8)
+#define PEBS_DATACFG_H16ZMMS	BIT_ULL(9)
 #define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
@@ -588,6 +592,22 @@ struct arch_pebs_xmm {
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
+	u64 zmmh[16][4];	/* four entries for each register */
+};
+
+struct arch_pebs_h16zmm {
+	u64 h16zmm[16][8];	/* eight entries for each register */
+};
+
 #define ARCH_PEBS_LBR_NAN		0x0
 #define ARCH_PEBS_LBR_NUM_8		0x1
 #define ARCH_PEBS_LBR_NUM_16		0x2
-- 
2.40.1

