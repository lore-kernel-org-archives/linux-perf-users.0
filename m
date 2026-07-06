Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EF737C0FB;
	Mon,  6 Jul 2026 02:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303346; cv=none; b=ZH36XgTBham7O0DXY9A3ndNIdYYQXkKVu8TC4vHQNgl87w1nWV8lIDVI5+RpSh6l7iGaIPoGRgFe+fUiptmBx2wdZmzHuyVejtcYqNJmxV1dlp/8iuo7P428xD9MbNPL94EHLB2HTZ+0Z0WcaAZIbMYzbNejaT9OpJhc8Ax473o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303346; c=relaxed/simple;
	bh=DVyFzbslNjaNIRJ9OOm7ndMGktzehfZCAKFu++OT2Xo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fk5sYlZ/JtvzObHNr8SIKeoBF1muf6Qo2I/7UvuEIS6lv/eB7CMYT4O2uVAmMxMgTLBJKt8haMjoYsoEpVLhA0SToHH7bPBrU99UvPpB6Oi+YreVQ0KU28wdKFnJAy/SU1VT2fb7k3Zn67Yhd2m8uuqMNOz368f0nIRCtLpmphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mH3wL2J7; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mH3wL2J7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303345; x=1814839345;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DVyFzbslNjaNIRJ9OOm7ndMGktzehfZCAKFu++OT2Xo=;
  b=mH3wL2J7fmIslIeWb2nLrKqK+f9s7TGu3X+y4D7SZEd6xidFA/YlTn+v
   DKNDWZLoSuDNTBr5GaLpty4cRdr/PpBBM1o4gcNgwa6772sGGmXHfQBHo
   N3Iqj44Q7FDcATeSnlEN/c1Bu2DwmM/jHS+1nr1yJeBQC3okLPr4sijyI
   imrvoNeFaB3M7Q/UpaL+g/R64vgHIDkgiH9whIgibdyUb62+d0Ua6jvC8
   zJeDhyLt/cPhbA5CuEsmB6ypmIsAj9/vvpXnMyv3qu7wjh3CatlE777qY
   VTAa09cC42etXemwPIDPopqeagqh12gIrGB7E0dAspMyDoTD1NqnDlB5B
   A==;
X-CSE-ConnectionGUID: FYaYiS+XQDSOSeXl5mR/Jw==
X-CSE-MsgGUID: fRTexaV4REmvyZfkIH194g==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911701"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911701"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:02:25 -0700
X-CSE-ConnectionGUID: FIpqcsVgSq2UeGZOXR7OIg==
X-CSE-MsgGUID: auT2EHmHT5Gk3w3/1bpR6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191425"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:19 -0700
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
Subject: [Patch v9 15/24] perf/x86: Support YMM sampling using sample_simd_vec_reg_* fields
Date: Mon,  6 Jul 2026 09:54:30 +0800
Message-Id: <20260706015439.3040804-16-dapeng1.mi@linux.intel.com>
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

Support sampling of YMM registers via the sample_simd_vec_reg_* fields.

Each YMM register consists of 4 u64 words, assembled from two halves:
XMM (the lower 2 u64 words) and YMMH (the upper 2 u64 words). Although
both XMM and YMMH data can be retrieved with a single xsaves instruction,
they are stored in separate locations. The perf_simd_reg_value() function
is responsible for assembling these halves into a complete YMM register
for output to userspace.

Additionally, sample_simd_vec_reg_qwords should be set to 4 to indicate
YMM sampling.

YMM sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          | 13 +++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  6 ++++--
 arch/x86/kernel/perf_regs.c           | 10 +++++++++-
 5 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 117d09fb9a05..10d90050def3 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -726,6 +726,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_xmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event_needs_ymm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1770,6 +1773,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 
 	perf_regs->abi = PERF_SAMPLE_REGS_ABI_NONE;
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1785,6 +1789,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 
 	if (mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+	if (mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 /*
@@ -1976,6 +1982,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 
 	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
+	if (event_needs_ymm(event))
+		mask |= XFEATURE_MASK_YMM;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.regs) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6b1b83c906eb..13f1f34ff8b0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -163,6 +163,19 @@ static inline bool event_needs_xmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_ymm(struct perf_event *event)
+{
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return false;
+
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_YMM_QWORDS)
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index a2b2123d008e..da77845e1f02 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -733,6 +733,10 @@ struct x86_perf_regs {
 		u64	*xmm_regs;
 		u32	*xmm_space;	/* for xsaves */
 	};
+	union {
+		u64	*ymmh_regs;
+		struct ymmh_struct *ymmh;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index edb35408e4cc..d544f6d79871 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -59,7 +59,8 @@ enum perf_event_x86_regs {
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
@@ -67,7 +68,8 @@ enum {
 enum {
 	/* 1 qword = 8 bytes */
 	PERF_X86_XMM_QWORDS      = 2,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 8514baefb400..316d18c13c02 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -77,6 +77,8 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
+#define PERF_X86_YMMH_QWORDS	(PERF_X86_YMM_QWORDS / 2)
+
 u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			u16 qwords_idx, bool pred)
 {
@@ -98,6 +100,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			return 0;
 		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS +
 					   qwords_idx];
+	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
+		if (!perf_regs->ymmh_regs)
+			return 0;
+		return perf_regs->ymmh_regs[idx * PERF_X86_YMMH_QWORDS +
+					    qwords_idx - PERF_X86_XMM_QWORDS];
 	}
 
 	return 0;
@@ -118,7 +125,8 @@ int perf_simd_reg_validate(u64 sample_type, u16 simd_enabled,
 		return 0;
 
 	if (vec_qwords) {
-		if (vec_qwords != PERF_X86_XMM_QWORDS)
+		if (vec_qwords != PERF_X86_XMM_QWORDS &&
+		    vec_qwords != PERF_X86_YMM_QWORDS)
 			return -EINVAL;
 		if (!vec_mask_intr && !vec_mask_user)
 			return -EINVAL;
-- 
2.34.1

