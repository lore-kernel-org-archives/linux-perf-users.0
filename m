Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C88237D114;
	Mon,  6 Jul 2026 02:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303376; cv=none; b=kq9+fsCD5VR1kgoMZK9j5bnWu7IP64YmUygb2eiz0JVJxzXIGo4+uUlStVmjgTuU8jcgUc1j3+2v8TbtV9L4fRtSUd0v/ALZgTqB/nYmAR7RvUCanN+NY9tSjZyK8nuvhU1+RpjFY5vZcKGUtpivV41jbyGz3kDIwpFEPSHaceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303376; c=relaxed/simple;
	bh=kgiz4JWRMhoVpbEg3FjLfs/51KJm0XX7l6ItbacVugE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RL2Wr6ZALiQrbkqcwKxP3eBeCrzMfcsIwjQqPbJeL+9gNDTEfcugPC2xQSqnzQOt3kMkVB0ym/AHk5UHeba/iVV7DJqAivJnT2m8kNzaVh2DzHkuZqYxt9lb8vIBa2vpx546HUmtFj4ObixifVNDraU/5wM0TcRm3z895Qu+0N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bqREl5cU; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bqREl5cU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303376; x=1814839376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kgiz4JWRMhoVpbEg3FjLfs/51KJm0XX7l6ItbacVugE=;
  b=bqREl5cU72sodalQNqrVWp89JYawsrs6EeEyX3Z+ta9if1iBgNTPlSRX
   nQFRS0QP75LqL+F5W0QrPkAO+FIwRLF8KWnWShQbN+x2ZFpBjM3zk3LR/
   7F1ONxI/bpFqUjXiKyhSdYIBo3huB7Aj1G/6kD1xJKQRIdhqLbrhcyScW
   k0bZxbfFMC//WvsY89EDealWJ41RVY6E3qQl8UksJRFxyjQWl0xQ/e2ep
   WwCGYYVzE43CPgBTb3SFh7TFF+g2WgAQFpsVm4i5TY8Oe56wMW06oZ6pN
   LW5j5+nAdr6n1LnymLA5+RDh37Azm8xyhoXcyEDzKmYe7Ae8/mXn3hM3C
   Q==;
X-CSE-ConnectionGUID: 3mwz5COzRsmzZy+pqK1WZw==
X-CSE-MsgGUID: FRGKQQZySn2oVlyC80FlEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911781"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911781"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:02:55 -0700
X-CSE-ConnectionGUID: B+JYHBi9SdSh3xP051+dkA==
X-CSE-MsgGUID: UZj7RpjRSiaNbOxftbezNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191504"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:50 -0700
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
Subject: [Patch v9 21/24] perf/x86/intel: Support arch-PEBS based SIMD/eGPRs/SSP sampling
Date: Mon,  6 Jul 2026 09:54:36 +0800
Message-Id: <20260706015439.3040804-22-dapeng1.mi@linux.intel.com>
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

Support arch-PEBS based SIMD/eGPRs/SSP registers sampling.

Arch-PEBS supports sampling of these registers, with all except SSP
placed into the XSAVE-Enabled Registers (XER) group with the layout
described below.

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

The SSP register is sampled and placed into the GPRs group by arch-PEBS.

Additionally, the MSRs IA32_PMC_{GPn|FXm}_CFG_C.[55:49] bits are used to
manage which types of these registers need to be sampled.

Arch-PEBS based SIMD/eGPRs/SSP sampling will be enabled in a subsequent
patch that sets PERF_PMU_CAP_SIMD_REGS.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/intel/core.c      | 126 ++++++++++++++++++++++++++++--
 arch/x86/events/intel/ds.c        |  77 ++++++++++++++++--
 arch/x86/include/asm/msr-index.h  |   7 ++
 arch/x86/include/asm/perf_event.h |   8 +-
 4 files changed, 204 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cfe5478aa5a4..15962a3457ee 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3474,6 +3474,21 @@ static void intel_pmu_enable_event_ext(struct perf_event *event)
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
 
@@ -4694,21 +4709,118 @@ static void intel_pebs_aliases_skl(struct perf_event *event)
 	return intel_pebs_aliases_precdist(event);
 }
 
+static inline bool intel_pebs_support_regs(struct perf_event *event, u64 regs)
+{
+	struct arch_pebs_cap cap = hybrid(event->pmu, arch_pebs_cap);
+	int pebs_format = x86_pmu.intel_cap.pebs_format;
+	bool supported = true;
+
+	if (regs & PEBS_DATACFG_GP) {
+		/* Legacy PEBS always supports GPRs sampling. */
+		supported &= x86_pmu.arch_pebs ?
+			     !!(ARCH_PEBS_GPR & cap.caps) : true;
+	}
+	if (regs & PEBS_DATACFG_XMMS) {
+		supported &= x86_pmu.arch_pebs ?
+			     !!(ARCH_PEBS_VECR_XMM & cap.caps) :
+			     pebs_format > 3 && x86_pmu.intel_cap.pebs_baseline;
+	}
+	/* Legacy PEBS doesn't support OPMASK/YMM+ and eGPRs sampling. */
+	if (regs & PEBS_DATACFG_YMMHS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_YMMH & cap.caps);
+	if (regs & PEBS_DATACFG_EGPRS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_EGPRS & cap.caps);
+	if (regs & PEBS_DATACFG_OPMASKS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_OPMASK & cap.caps);
+	if (regs & PEBS_DATACFG_ZMMHS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_ZMMH & cap.caps);
+	if (regs & PEBS_DATACFG_H16ZMMS)
+		supported &= x86_pmu.arch_pebs && (ARCH_PEBS_VECR_H16ZMM & cap.caps);
+
+	return supported;
+}
+
+static bool __regs_support_large_pebs(struct perf_event *event, bool intr)
+{
+	u64 regs = intr ? event->attr.sample_regs_intr :
+			  event->attr.sample_regs_user;
+	u64 vec_regs = intr ? event->attr.sample_simd_vec_reg_intr :
+			      event->attr.sample_simd_vec_reg_user;
+	u64 pred_regs = intr ? event->attr.sample_simd_pred_reg_intr :
+			       event->attr.sample_simd_pred_reg_user;
+	u64 xregs_mask = PEBS_GP_REGS | PERF_X86_EGPRS_MASK |
+			 BIT_ULL(PERF_REG_X86_SSP);
+
+	if (regs & ~xregs_mask)
+		return false;
+
+	if ((regs & PEBS_GP_REGS) &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_GP))
+		return false;
+
+	if ((regs & PERF_X86_EGPRS_MASK) &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_EGPRS))
+		return false;
+
+	if ((regs & BIT_ULL(PERF_REG_X86_SSP)) &&
+	    (!x86_pmu.arch_pebs ||
+	     !intel_pebs_support_regs(event, PEBS_DATACFG_GP)))
+		return false;
+
+	if (event_needs_opmask(event) && pred_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_OPMASKS))
+		return false;
+
+	if (event_needs_xmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_XMMS))
+		return false;
+
+	if (event_needs_ymm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_YMMHS))
+		return false;
+
+	if (event_needs_low16_zmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_ZMMHS))
+		return false;
+
+	if (event_needs_high16_zmm(event) && vec_regs &&
+	    !intel_pebs_support_regs(event, PEBS_DATACFG_H16ZMMS))
+		return false;
+
+	return true;
+}
+
+static inline bool intr_regs_support_large_pebs(struct perf_event *event)
+{
+	return __regs_support_large_pebs(event, true);
+}
+
+static inline bool user_regs_support_large_pebs(struct perf_event *event)
+{
+	return __regs_support_large_pebs(event, false);
+}
+
 static unsigned long intel_pmu_large_pebs_flags(struct perf_event *event)
 {
 	unsigned long flags = x86_pmu.large_pebs_flags;
-	u64 gprs_mask = event->attr.sample_simd_regs_enabled ?
-			PEBS_GP_REGS :
-			PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
 
 	if (event->attr.use_clockid)
 		flags &= ~PERF_SAMPLE_TIME;
 	if (!event->attr.exclude_kernel)
 		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_user & ~gprs_mask)
-		flags &= ~PERF_SAMPLE_REGS_USER;
-	if (event->attr.sample_regs_intr & ~gprs_mask)
-		flags &= ~PERF_SAMPLE_REGS_INTR;
+	if (event->attr.sample_simd_regs_enabled) {
+		if (!user_regs_support_large_pebs(event))
+			flags &= ~PERF_SAMPLE_REGS_USER;
+		if (!intr_regs_support_large_pebs(event))
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	} else {
+		u64 gprs_mask = PEBS_GP_REGS | PERF_REG_EXTENDED_MASK;
+
+		if (event->attr.sample_regs_user & ~gprs_mask)
+			flags &= ~PERF_SAMPLE_REGS_USER;
+		if (event->attr.sample_regs_intr & ~gprs_mask)
+			flags &= ~PERF_SAMPLE_REGS_INTR;
+	}
 	return flags;
 }
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 54e6f73ffde4..c42c6f575a21 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1734,11 +1734,22 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
 		      x86_pmu.rtm_abort_event);
 
-	if (gprs || (attr->precise_ip < 2) || tsx_weight)
+	if (gprs || (attr->precise_ip < 2) ||
+	    tsx_weight || event_needs_ssp(event))
 		pebs_data_cfg |= PEBS_DATACFG_GP;
 
 	if (event_needs_xmm(event))
 		pebs_data_cfg |= PEBS_DATACFG_XMMS;
+	if (x86_pmu.arch_pebs && event_needs_ymm(event))
+		pebs_data_cfg |= PEBS_DATACFG_YMMHS;
+	if (x86_pmu.arch_pebs && event_needs_low16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_ZMMHS;
+	if (x86_pmu.arch_pebs && event_needs_high16_zmm(event))
+		pebs_data_cfg |= PEBS_DATACFG_H16ZMMS;
+	if (x86_pmu.arch_pebs && event_needs_opmask(event))
+		pebs_data_cfg |= PEBS_DATACFG_OPMASKS;
+	if (x86_pmu.arch_pebs && event_needs_egprs(event))
+		pebs_data_cfg |= PEBS_DATACFG_EGPRS;
 
 	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
 		/*
@@ -2697,15 +2708,69 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
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
 
-		ignore_mask |= XFEATURE_MASK_SSE;
-		xmm = next_record;
-		perf_regs->xmm_regs = xmm->xmm;
-		next_record = xmm + 1;
+		if (header->xmm) {
+			ignore_mask |= XFEATURE_MASK_SSE;
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
+			ignore_mask |= XFEATURE_MASK_YMM;
+			ymmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_YMM)
+				perf_regs->ymmh = ymmh;
+			next_record = ymmh + 1;
+		}
+
+		if (header->egpr) {
+			ignore_mask |= XFEATURE_MASK_APX;
+			egpr = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_APX)
+				perf_regs->egpr = egpr;
+			next_record = egpr + 1;
+		}
+
+		if (header->opmask) {
+			ignore_mask |= XFEATURE_MASK_OPMASK;
+			opmask = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_OPMASK)
+				perf_regs->opmask = opmask;
+			next_record = opmask + 1;
+		}
+
+		if (header->zmmh) {
+			ignore_mask |= XFEATURE_MASK_ZMM_Hi256;
+			zmmh = next_record;
+			if (xer_header->xstate & XFEATURE_MASK_ZMM_Hi256)
+				perf_regs->zmmh = zmmh;
+			next_record = zmmh + 1;
+		}
+
+		if (header->h16zmm) {
+			ignore_mask |= XFEATURE_MASK_Hi16_ZMM;
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

