Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDA435A8A;
	Tue, 21 Jul 2026 06:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615668; cv=none; b=f6ZraKz+pdVjvyhOgGt4sZfE0p9UCBu+0EWk6ztVVO5DM3X5ZtXv3/UmTa/NDODM6hnupLJb+SncW98poBQNEJxQiek5ygw7fcmWjpotuCMb9c0w8IXIPituYf7njkh85cjhmdme08Sx21PC/iHUfn0KcpECezaKf9R6j+bOSmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615668; c=relaxed/simple;
	bh=83r90lwv+qO87IZJ94rtwC/rZxsSNb/CRtSZIamGDRM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hLkbEADLpsOxome5q/RAahj60XibJ9Ald0M79HBumy2RbBhiB663kuz1RWWqkV7lrCFgE+7qKoTdIPnqXIogP7tl3JJUnmSs/3qCKptbn/i0e59b3487NvDiAxSilORmO1KYyDlVzKaHv5HWxU35U4SjDlHDTjINh/9PDNFXIkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YfcDEHQp; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YfcDEHQp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784615665; x=1816151665;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=83r90lwv+qO87IZJ94rtwC/rZxsSNb/CRtSZIamGDRM=;
  b=YfcDEHQpdkRxiWVCbwjilj6yrTVFkXYyWJBZ8SLiZrppJubXKLcmwPfn
   Q/fPIJ9+MNNVuXZfTz58na1Xerfr3uYKsAZMB+HdB63YtbXd0/wpFEX81
   mj1hv68mZ/sXQIkfSblUI8JGhj4BeD/cXa+zXUbLlzM9SREtItlyYN8fR
   /tgXdeL8JbMEvr69iYnzxpfccmwyq415C2cclXPW5KXZye0rfCSWLmon6
   N8mbj3j7xdI624XvJWxhN9iHBaJVS1c3ycwfnG/glmhKBKYiZ/k3t+Ybt
   0em9c1Iz7E24fp3bn8UlVcTvvKcjHbZw596fCnX9JDLN9qkuASqPzM2iq
   w==;
X-CSE-ConnectionGUID: OpM90qI7RFqtb+8GKnnCnw==
X-CSE-MsgGUID: odBklry5QRmHMfElYC6bIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="95565574"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="95565574"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 23:34:25 -0700
X-CSE-ConnectionGUID: y2TgCjdtQb+KkD+MfTCAHw==
X-CSE-MsgGUID: jS5WDHu8Spu1DA3udmIGTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="259656236"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa004.fm.intel.com with ESMTP; 20 Jul 2026 23:34:18 -0700
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
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: [Patch v10 20/23] perf/x86/intel: Support arch-PEBS based SIMD/eGPRs sampling
Date: Tue, 21 Jul 2026 14:25:03 +0800
Message-Id: <20260721062506.3745816-21-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
References: <20260721062506.3745816-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support arch-PEBS based SIMD/eGPRs/SSP registers sampling.

Arch-PEBS supports sampling all of these registers. SIMD and eGPR
registers are placed into the XSAVE-Enabled Registers (XER) group with
the layout described below.

Field Name 	Registers Used 			Size

XSTATE_BV	XINUSE for groups		8 B
Reserved 	Reserved 			8 B
SSER 		XMM0-XMM15 			16 regs * 16 B = 256 B
YMMHIR 		Upper 128 bits of YMM0-YMM15 	16 regs * 16 B = 256 B
EGPR 		R16-R31 			16 regs *  8 B = 128 B
OPMASKR 	K0-K7 				 8 regs *  8 B = 64 B
ZMMHIR 		Upper 256 bits of ZMM0-ZMM15 	16 regs * 32 B = 512 B
Hi16ZMMR 	ZMM16-ZMM31 			16 regs * 64 B = 1024 B

Memory space in the output buffer is allocated for these sub-groups as
long as the corresponding Format.XER[55:49] bits in the PEBS record
header are set. However, the arch-PEBS hardware engine does not write
the sub-group if it is not used (in INIT state). In such cases, the
corresponding bit in the XSTATE_BV bitmap is set to 0. Therefore, the
XSTATE_BV field is checked to determine if the register data is actually
written for each PEBS record. If not, the register data is not outputted
to userspace.

Additionally, the MSRs IA32_PMC_{GPn|FXm}_CFG_C.[55:49] bits are used to
manage which types of these registers need to be sampled.

Arch-PEBS based SIMD/eGPRs sampling will be enabled in a subsequent
patch that sets PERF_PMU_CAP_SIMD_REGS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c            | 20 ++++++---
 arch/x86/events/intel/core.c      | 15 +++++++
 arch/x86/events/intel/ds.c        | 67 +++++++++++++++++++++++++++++--
 arch/x86/include/asm/msr-index.h  |  7 ++++
 arch/x86/include/asm/perf_event.h |  8 +++-
 5 files changed, 106 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index caa5a0fb3ed8..11799acd8c54 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -646,12 +646,20 @@ static int pebs_simd_regs_validate(struct perf_event *event)
 	if (event_needs_ssp(event) &&
 	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_GPR)))
 		return -EINVAL;
-	/* PEBS does not support YMM/ZMM/OPMASK/eGPR registers sampling yet. */
-	if (event_needs_ymm(event) ||
-	    event_needs_low16_zmm(event) ||
-	    event_needs_high16_zmm(event) ||
-	    event_needs_opmask(event) ||
-	    event_needs_egprs(event))
+	if (event_needs_ymm(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_YMMH)))
+		return -EINVAL;
+	if (event_needs_egprs(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_EGPRS)))
+		return -EINVAL;
+	if (event_needs_opmask(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_OPMASK)))
+		return -EINVAL;
+	if (event_needs_low16_zmm(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_ZMMH)))
+		return -EINVAL;
+	if (event_needs_high16_zmm(event) &&
+	    !(x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_H16ZMM)))
 		return -EINVAL;
 
 	return 0;
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 809ef2515b10..4eeb08352f4c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3498,6 +3498,21 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
 			if (pebs_data_cfg & PEBS_DATACFG_XMMS)
 				ext |= ARCH_PEBS_VECR_XMM & cap.caps;
 
+			if (pebs_data_cfg & PEBS_DATACFG_YMMHS)
+				ext |= ARCH_PEBS_VECR_YMMH & cap.caps;
+
+			if (pebs_data_cfg & PEBS_DATACFG_EGPRS)
+				ext |= ARCH_PEBS_VECR_EGPRS & cap.caps;
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
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 3277bd72e0a8..ff6125ec8458 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1733,6 +1733,16 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		if (event_needs_xmm(event))
 			pebs_data_cfg |= PEBS_DATACFG_XMMS;
+		if (x86_pmu.arch_pebs && event_needs_ymm(event))
+			pebs_data_cfg |= PEBS_DATACFG_YMMHS;
+		if (x86_pmu.arch_pebs && event_needs_low16_zmm(event))
+			pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
+		if (x86_pmu.arch_pebs && event_needs_high16_zmm(event))
+			pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+		if (x86_pmu.arch_pebs && event_needs_opmask(event))
+			pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+		if (x86_pmu.arch_pebs && event_needs_egprs(event))
+			pebs_data_cfg |= PEBS_DATACFG_EGPRS;
 	}
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
@@ -2687,14 +2697,63 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 					   meminfo->tsx_tuning, ax);
 	}
 
-	if (header->xmm) {
+	if (header->xmm || header->ymmh || header->egpr ||
+	    header->opmask || header->zmmh || header->h16zmm) {
+		struct arch_pebs_xer_header *xer_header = next_record;
 		struct pebs_xmm *xmm;
+		struct ymmh_struct *ymmh;
+		struct avx_512_zmm_uppers_state *zmmh;
+		struct avx_512_hi16_state *h16zmm;
+		struct avx_512_opmask_state *opmask;
+		struct apx_state *egpr;
 
 		next_record += sizeof(struct arch_pebs_xer_header);
 
-		xmm = next_record;
-		perf_regs->xmm_regs = xmm->xmm;
-		next_record = xmm + 1;
+		if (header->xmm) {
+			xmm = next_record;
+			/*
+			 * Only output XMM regs to user space when arch-PEBS
+			 * really writes data into xstate area.
+			 */
+			if (xer_header->xstate & XFEATURE_MASK_SSE)
+				perf_regs->xmm_regs = xmm->xmm;
+			next_record = xmm + 1;
+		}
+
+		if (header->ymmh) {
+			ymmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_YMM)
+				perf_regs->ymmh = ymmh;
+			next_record = ymmh + 1;
+		}
+
+		if (header->egpr) {
+			egpr = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_APX)
+				perf_regs->egpr = egpr;
+			next_record = egpr + 1;
+		}
+
+		if (header->opmask) {
+			opmask = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_OPMASK)
+				perf_regs->opmask = opmask;
+			next_record = opmask + 1;
+		}
+
+		if (header->zmmh) {
+			zmmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_ZMM_Hi256)
+				perf_regs->zmmh = zmmh;
+			next_record = zmmh + 1;
+		}
+
+		if (header->h16zmm) {
+			h16zmm = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_Hi16_ZMM)
+				perf_regs->h16zmm = h16zmm;
+			next_record = h16zmm + 1;
+		}
 	}
 
 	if (header->lbr) {
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 18c4be75e927..9c26d4075c5f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -350,6 +350,13 @@
 #define ARCH_PEBS_LBR_SHIFT		40
 #define ARCH_PEBS_LBR			(0x3ull << ARCH_PEBS_LBR_SHIFT)
 #define ARCH_PEBS_VECR_XMM		BIT_ULL(49)
+#define ARCH_PEBS_VECR_YMMH		BIT_ULL(50)
+#define ARCH_PEBS_VECR_EGPRS		BIT_ULL(51)
+#define ARCH_PEBS_VECR_OPMASK		BIT_ULL(53)
+#define ARCH_PEBS_VECR_ZMMH		BIT_ULL(54)
+#define ARCH_PEBS_VECR_H16ZMM		BIT_ULL(55)
+#define ARCH_PEBS_VECR_EXT_SHIFT	49
+#define ARCH_PEBS_VECR_EXT		(0x7full << ARCH_PEBS_VECR_EXT_SHIFT)
 #define ARCH_PEBS_GPR			BIT_ULL(61)
 #define ARCH_PEBS_AUX			BIT_ULL(62)
 #define ARCH_PEBS_EN			BIT_ULL(63)
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 4302ef39c42e..12f7db8c57b4 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -150,6 +150,11 @@
 #define PEBS_DATACFG_LBRS	BIT_ULL(3)
 #define PEBS_DATACFG_CNTR	BIT_ULL(4)
 #define PEBS_DATACFG_METRICS	BIT_ULL(5)
+#define PEBS_DATACFG_YMMHS	BIT_ULL(6)
+#define PEBS_DATACFG_OPMASKS	BIT_ULL(7)
+#define PEBS_DATACFG_ZMMHS	BIT_ULL(8)
+#define PEBS_DATACFG_H16ZMMS	BIT_ULL(9)
+#define PEBS_DATACFG_EGPRS	BIT_ULL(10)
 #define PEBS_DATACFG_LBR_SHIFT	24
 #define PEBS_DATACFG_CNTR_SHIFT	32
 #define PEBS_DATACFG_CNTR_MASK	GENMASK_ULL(15, 0)
@@ -547,7 +552,8 @@ struct arch_pebs_header {
 			    rsvd3:7,
 			    xmm:1,
 			    ymmh:1,
-			    rsvd4:2,
+			    egpr:1,
+			    rsvd4:1,
 			    opmask:1,
 			    zmmh:1,
 			    h16zmm:1,
-- 
2.34.1

