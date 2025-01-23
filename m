Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC31CAA9D;
	Thu, 23 Jan 2025 06:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737613268; cv=none; b=bwgNRgiVvAaCenuVdMqHDkBQjm+hsRAWl35QrQxz+w7o94ZdRUVSg+I/pNXU6ktLqh0gNWY7X0kLXtNTZXd9QELwL3gJtEBgqSlFB1isDAyqaRryUcg7zxNKQRsMh1GRGVmtSKhLbt0fEgQ9L1SkgMho0Qy1rysjobz3uDDnsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737613268; c=relaxed/simple;
	bh=x/QRPgrDF27N+5NAeSUVqZhq0/Y5in74j2wHi+e/LfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fg5YsDg8JwHtpgw/3GUgNBwRmVEiNA7dLZmOKabO3trxPPCnkKYKyW4/XKYdYgN4yV7Uq5iOMlgF/tk7iAB6AYbywNA1ysoUJAITxJj7HMGaeD70f+9QFIQtHxxrFUWSVQWFkGZ+bgetu5vUiQurKm3gdbtDjMzzkLrxAgYCdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FaUw8rS3; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FaUw8rS3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737613267; x=1769149267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x/QRPgrDF27N+5NAeSUVqZhq0/Y5in74j2wHi+e/LfA=;
  b=FaUw8rS3i+y6bOaZ4um4bLJPIG6n6lTWIFXtj1eEcflvtLanRx5dYQq2
   YBhGxEVTHR930qXlJXvLpz5eWeNav7LH+K9apy120ZY8QgHK3+PdnMuIp
   60cG8mnvs9LdBkQf+yX3DqYqOGXsHHEY0grXC3PLeqm4XvCYM27ZQkbCk
   0Y1859fP76oYx8osghTgvbZvSNnpQktxlGN1YAcGBqo5Hzta6Tu0DbvFZ
   2Zr/s3jsxTZltd0YkVaKG21DYdPt3q0aPx+ABbPLxNr2ElqhdTwC0QgA8
   d3reBP/FGldO5QotUJI6gp0gohsS8inZS4PddWy/6OX7sKagNUiCQOto1
   A==;
X-CSE-ConnectionGUID: D7QQtRpZQ06YYOUj6Hi8/w==
X-CSE-MsgGUID: ROSo+ZhoSZWzO2nXIaPhuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="55513209"
X-IronPort-AV: E=Sophos;i="6.13,227,1732608000"; 
   d="scan'208";a="55513209"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2025 22:21:07 -0800
X-CSE-ConnectionGUID: OgIWIOdZSuWEhAyg8LiugA==
X-CSE-MsgGUID: 7zEXgXKsSJ+bKWr4w1fWgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="112334764"
Received: from emr.sh.intel.com ([10.112.229.56])
  by orviesa003.jf.intel.com with ESMTP; 22 Jan 2025 22:21:03 -0800
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
Subject: [PATCH 16/20] perf/x86/intel: Support arch-PEBS vector registers group capturing
Date: Thu, 23 Jan 2025 14:07:17 +0000
Message-Id: <20250123140721.2496639-17-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
References: <20250123140721.2496639-1-dapeng1.mi@linux.intel.com>
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
index 7ed80f01f15d..f17a8c9c6391 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -576,6 +576,39 @@ int x86_pmu_max_precise(struct pmu *pmu)
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
@@ -671,6 +704,32 @@ int x86_pmu_hw_config(struct perf_event *event)
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
index 9c5b44a73ca2..0c828a42b1ad 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2953,6 +2953,18 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
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
 
@@ -5117,6 +5129,9 @@ static inline void __intel_update_pmu_caps(struct pmu *pmu)
 	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_XMM)
 		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
 
+	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_VECR_EXT)
+		dest_pmu->capabilities |= PERF_PMU_CAP_MORE_EXT_REGS;
+
 	if (hybrid(pmu, arch_pebs_cap).caps & ARCH_PEBS_CNTR_MASK)
 		x86_pmu.late_setup = intel_pmu_late_setup;
 }
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 32a44e3571cb..fc5716b257d7 100644
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
@@ -2216,6 +2245,10 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	format_group = basic->format_group;
@@ -2333,6 +2366,10 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 
 	perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
+	perf_regs->opmask_regs = NULL;
+	perf_regs->zmmh_regs = NULL;
+	perf_regs->h16zmm_regs = NULL;
 	perf_regs->ssp = 0;
 
 	__setup_perf_sample_data(event, iregs, data);
@@ -2383,14 +2420,45 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
index 6235df132ee0..e017ee8556e5 100644
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
index 54125b344b2b..79368ece2bf9 100644
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
@@ -559,6 +563,22 @@ struct arch_pebs_xmm {
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

