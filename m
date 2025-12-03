Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E42BEC2D;
	Wed,  3 Dec 2025 06:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745147; cv=none; b=gkX1zVPsOcVOFrEJ153HWJY0txTZ3BBkRFofvWMttc4W0JlG+WCITBvTirN609/AmJ8sQn0Owx6vWEJ2EhzBgmyD2zQ7banVS5PvAGmpTIcVcVtwC2mqSEMTE/37OCxNoXMf39Hu4SMAFLNgPW4ZYLcJsxoLyPBwTjH+rwquXTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745147; c=relaxed/simple;
	bh=ddcjsAcklFdcJaV67NJqKAAOjXOKDQnf4Nq6bNtJcPA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bn15agXwBO0s2fJ3DbAIU6NJ1DkMptMKYxXxSY+2DbpuGvVml5cbrS7dysKYeq3UaT+OCNrlPmjy4YDAyGLbBwGhE2ZOhwDOtH7doDj71jUpFXHe2KbXzB36Ma96kY84vZKWY1tOChPfRdUdJKYh3m6v/19LcuMNBpH/snNjdlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YRUKqUbz; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YRUKqUbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745144; x=1796281144;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ddcjsAcklFdcJaV67NJqKAAOjXOKDQnf4Nq6bNtJcPA=;
  b=YRUKqUbzB2aoWb7TWG5OpEIis6g+K9w2/RDyA/WrBifmCcgfKzWi4fx7
   3IywFmoWZSaDlycwb7otyoGytV5AZRiiTwRQN7ukCgtg895X73txoKmGY
   DvT100h8wE6mH6Wj3wodD4mR8A1ZJcqPXq79BKc19DIHyFyfGRKnTQVfX
   Lwiw/gm1oxuPzVXTNo1bi8SaJotujlJjLlJrtPOi291n1aP1+YkcM8nLO
   IuN4E45NYz0JRdiiGKhZTLwhClkJKRjlbBLEE1bVDFj+CpKzLQGOO82lz
   HJKuQfAuHdmk4cXH3FiI75oIIePACY87KkRKlJ3q4jJLytVcXol6iylDF
   w==;
X-CSE-ConnectionGUID: Y2A8PAMDSDepXCBwb2hjhA==
X-CSE-MsgGUID: qaHwHEGdQMipDZBJSzQqoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324880"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324880"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:03 -0800
X-CSE-ConnectionGUID: Dp9ZGSN2R0ipUiu3QH4xCA==
X-CSE-MsgGUID: YU83Uc/JTHWhivAi0zkJAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003988"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:57 -0800
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
Subject: [Patch v5 12/19] perf/x86: Enable eGPRs sampling using sample_regs_* fields
Date: Wed,  3 Dec 2025 14:54:53 +0800
Message-Id: <20251203065500.2597594-13-dapeng1.mi@linux.intel.com>
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

This patch enables sampling of APX eGPRs (R16 ~ R31) via the
sample_regs_* fields.

To sample eGPRs, the sample_simd_regs_enabled field must be set. This
allows the spare space (reclaimed from the original XMM space) in the
sample_regs_* fields to be used for representing eGPRs.

The perf_reg_value() function needs to check if the
PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then determine whether
to output eGPRs or legacy XMM registers to userspace.

The perf_reg_validate() function is enhanced to validate the eGPRs bitmap
by adding a new argument, "simd_enabled".

Currently, eGPRs sampling is only supported on the x86_64 architecture, as
APX is only available on x86_64 platforms.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/arm/kernel/perf_regs.c           |  2 +-
 arch/arm64/kernel/perf_regs.c         |  2 +-
 arch/csky/kernel/perf_regs.c          |  2 +-
 arch/loongarch/kernel/perf_regs.c     |  2 +-
 arch/mips/kernel/perf_regs.c          |  2 +-
 arch/parisc/kernel/perf_regs.c        |  2 +-
 arch/powerpc/perf/perf_regs.c         |  2 +-
 arch/riscv/kernel/perf_regs.c         |  2 +-
 arch/s390/kernel/perf_regs.c          |  2 +-
 arch/x86/events/core.c                | 41 +++++++++++++++-------
 arch/x86/events/perf_event.h          | 10 ++++++
 arch/x86/include/asm/perf_event.h     |  4 +++
 arch/x86/include/uapi/asm/perf_regs.h | 25 ++++++++++++++
 arch/x86/kernel/perf_regs.c           | 49 +++++++++++++++------------
 include/linux/perf_regs.h             |  2 +-
 kernel/events/core.c                  |  8 +++--
 16 files changed, 110 insertions(+), 47 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index d575a4c3ca56..838d701adf4d 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_ARM_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 70e2f13f587f..71a3e0238de4 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -77,7 +77,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_ARM64_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	u64 reserved_mask = REG_RESERVED;
 
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index 94601f37b596..c932a96afc56 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_CSKY_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/loongarch/kernel/perf_regs.c b/arch/loongarch/kernel/perf_regs.c
index 8dd604f01745..164514f40ae0 100644
--- a/arch/loongarch/kernel/perf_regs.c
+++ b/arch/loongarch/kernel/perf_regs.c
@@ -25,7 +25,7 @@ u64 perf_reg_abi(struct task_struct *tsk)
 }
 #endif /* CONFIG_32BIT */
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask)
 		return -EINVAL;
diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
index 7736d3c5ebd2..00a5201dbd5d 100644
--- a/arch/mips/kernel/perf_regs.c
+++ b/arch/mips/kernel/perf_regs.c
@@ -28,7 +28,7 @@ u64 perf_reg_abi(struct task_struct *tsk)
 }
 #endif /* CONFIG_32BIT */
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask)
 		return -EINVAL;
diff --git a/arch/parisc/kernel/perf_regs.c b/arch/parisc/kernel/perf_regs.c
index 87e6990569a7..169c25c054b2 100644
--- a/arch/parisc/kernel/perf_regs.c
+++ b/arch/parisc/kernel/perf_regs.c
@@ -34,7 +34,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_PARISC_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 350dccb0143c..a01d8a903640 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -125,7 +125,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index 3bba8deababb..1ecc8760b88b 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -18,7 +18,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1ULL << PERF_REG_RISCV_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index a6b058ee4a36..c5ad9e2f489b 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -34,7 +34,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 #define REG_RESERVED (~((1UL << PERF_REG_S390_MAX) - 1))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || mask & REG_RESERVED)
 		return -EINVAL;
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3a4144ee0b7b..ec0838469cae 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -432,6 +432,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 	if (valid_mask & XFEATURE_MASK_OPMASK)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
+	if (valid_mask & XFEATURE_MASK_APX)
+		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
 }
 
 static void release_ext_regs_buffers(void)
@@ -719,22 +721,21 @@ int x86_pmu_hw_config(struct perf_event *event)
 	}
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
-		/*
-		 * Besides the general purpose registers, XMM registers may
-		 * be collected as well.
-		 */
-		if (event_has_extended_regs(event)) {
-			if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
-				return -EINVAL;
-			if (!event->attr.precise_ip)
-				return -EINVAL;
-			if (event->attr.sample_simd_regs_enabled)
-				return -EINVAL;
-		}
-
 		if (event_has_simd_regs(event)) {
+			u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
+
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
+			/*
+			 * The XMM space in the perf_event_x86_regs is reclaimed
+			 * for eGPRs and other general registers.
+			 */
+			if (event->attr.sample_regs_user & reserved ||
+			    event->attr.sample_regs_intr & reserved)
+				return -EINVAL;
+			if (event_needs_egprs(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
+				return -EINVAL;
 			/* Not require any vector registers but set width */
 			if (event->attr.sample_simd_vec_reg_qwords &&
 			    !event->attr.sample_simd_vec_reg_intr &&
@@ -756,6 +757,17 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_opmask(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
 				return -EINVAL;
+		} else {
+			/*
+			 * Besides the general purpose registers, XMM registers may
+			 * be collected as well.
+			 */
+			if (event_has_extended_regs(event)) {
+				if (!(event->pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS))
+					return -EINVAL;
+				if (!event->attr.precise_ip)
+					return -EINVAL;
+			}
 		}
 	}
 
@@ -1839,6 +1851,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
+	perf_regs->egpr_regs = NULL;
 }
 
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
@@ -1916,6 +1929,8 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_Hi16_ZMM;
 	if (event_needs_opmask(event))
 		mask |= XFEATURE_MASK_OPMASK;
+	if (event_needs_egprs(event))
+		mask |= XFEATURE_MASK_APX;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7e081a392ff8..9fb1cbbc1b76 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -183,6 +183,16 @@ static inline bool event_needs_opmask(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_egprs(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
+	     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index caa6df8ac1cd..ca242db3720f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -725,6 +725,10 @@ struct x86_perf_regs {
 		u64	*opmask_regs;
 		struct avx_512_opmask_state *opmask;
 	};
+	union {
+		u64	*egpr_regs;
+		struct apx_state *egpr;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 6f29fd9495a2..f145e3b78426 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -27,9 +27,33 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R13,
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
+	/*
+	 * The EGPRs and XMM have overlaps. Only one can be used
+	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
+	 * utilize EGPRs. For the other ABI type, XMM is used.
+	 *
+	 * Extended GPRs (EGPRs)
+	 */
+	PERF_REG_X86_R16,
+	PERF_REG_X86_R17,
+	PERF_REG_X86_R18,
+	PERF_REG_X86_R19,
+	PERF_REG_X86_R20,
+	PERF_REG_X86_R21,
+	PERF_REG_X86_R22,
+	PERF_REG_X86_R23,
+	PERF_REG_X86_R24,
+	PERF_REG_X86_R25,
+	PERF_REG_X86_R26,
+	PERF_REG_X86_R27,
+	PERF_REG_X86_R28,
+	PERF_REG_X86_R29,
+	PERF_REG_X86_R30,
+	PERF_REG_X86_R31,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
+	PERF_REG_MISC_MAX = PERF_REG_X86_R31 + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
@@ -54,6 +78,7 @@ enum perf_event_x86_regs {
 };
 
 #define PERF_REG_EXTENDED_MASK	(~((1ULL << PERF_REG_X86_XMM0) - 1))
+#define PERF_X86_EGPRS_MASK	GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R16)
 
 enum {
 	PERF_REG_X86_XMM,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 1ca24e2a6aa0..e76de39e1385 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -61,14 +61,22 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
 	struct x86_perf_regs *perf_regs;
 
-	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+	if (idx > PERF_REG_X86_R15) {
 		perf_regs = container_of(regs, struct x86_perf_regs, regs);
-		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
-		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
-			return 0;
-		if (!perf_regs->xmm_regs)
-			return 0;
-		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+
+		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
+			if (idx <= PERF_REG_X86_R31) {
+				if (!perf_regs->egpr_regs)
+					return 0;
+				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
+			}
+		} else {
+			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
+				if (!perf_regs->xmm_regs)
+					return 0;
+				return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
+			}
+		}
 	}
 
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(pt_regs_offset)))
@@ -150,20 +158,14 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 	return 0;
 }
 
-#define PERF_REG_X86_RESERVED	(((1ULL << PERF_REG_X86_XMM0) - 1) & \
-				 ~((1ULL << PERF_REG_X86_MAX) - 1))
+#define PERF_REG_X86_RESERVED	(GENMASK_ULL(PERF_REG_X86_XMM0 - 1, PERF_REG_X86_AX) & \
+				 ~GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_AX))
+#define PERF_REG_X86_EXT_RESERVED	(~GENMASK_ULL(PERF_REG_MISC_MAX - 1, PERF_REG_X86_AX))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
-		       (1ULL << PERF_REG_X86_R9) | \
-		       (1ULL << PERF_REG_X86_R10) | \
-		       (1ULL << PERF_REG_X86_R11) | \
-		       (1ULL << PERF_REG_X86_R12) | \
-		       (1ULL << PERF_REG_X86_R13) | \
-		       (1ULL << PERF_REG_X86_R14) | \
-		       (1ULL << PERF_REG_X86_R15))
-
-int perf_reg_validate(u64 mask)
+#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_R8)
+
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	if (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
 		return -EINVAL;
@@ -182,10 +184,15 @@ u64 perf_reg_abi(struct task_struct *task)
 		       (1ULL << PERF_REG_X86_FS) | \
 		       (1ULL << PERF_REG_X86_GS))
 
-int perf_reg_validate(u64 mask)
+int perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	/* The mask could be 0 if only the SIMD registers are interested */
-	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
+	if (!simd_enabled &&
+	    (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED)))
+		return -EINVAL;
+
+	if (simd_enabled &&
+	    (mask & (REG_NOSUPPORT | PERF_REG_X86_EXT_RESERVED)))
 		return -EINVAL;
 
 	return 0;
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 518f28c6a7d4..09dbc2fc3859 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -10,7 +10,7 @@ struct perf_regs {
 };
 
 u64 perf_reg_value(struct pt_regs *regs, int idx);
-int perf_reg_validate(u64 mask);
+int perf_reg_validate(u64 mask, bool simd_enabled);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b19de038979e..428ff39e03c5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7436,7 +7436,7 @@ u64 __weak perf_reg_value(struct pt_regs *regs, int idx)
 	return 0;
 }
 
-int __weak perf_reg_validate(u64 mask)
+int __weak perf_reg_validate(u64 mask, bool simd_enabled)
 {
 	return mask ? -ENOSYS : 0;
 }
@@ -13310,7 +13310,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	}
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_USER) {
-		ret = perf_reg_validate(attr->sample_regs_user);
+		ret = perf_reg_validate(attr->sample_regs_user,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
@@ -13340,7 +13341,8 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 		attr->sample_max_stack = sysctl_perf_event_max_stack;
 
 	if (attr->sample_type & PERF_SAMPLE_REGS_INTR) {
-		ret = perf_reg_validate(attr->sample_regs_intr);
+		ret = perf_reg_validate(attr->sample_regs_intr,
+					attr->sample_simd_regs_enabled);
 		if (ret)
 			return ret;
 		ret = perf_simd_reg_validate(attr->sample_simd_vec_reg_qwords,
-- 
2.34.1

