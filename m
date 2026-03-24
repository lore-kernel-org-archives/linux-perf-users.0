Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB3370D7D;
	Tue, 24 Mar 2026 00:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313233; cv=none; b=rXMUYAq5DTpttlEPXqiFW7Lq0WgqRTgQqrCWP1kPgsZjjyitWnEwwxIDQ16ctIwsM7yRT0GTow1dzSe2ZCe7c6po/4a4y2Ij/6klq4Vi6Gv5BMiQxK4XEK5m/5LtJV7pBpTXYF+fUwzkNHmYOYncBNBUFyA06YO4G6xparXLwtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313233; c=relaxed/simple;
	bh=t7ntPNrYl+47KNOOHyFIWOVc+HUTcEEeepncneeWUGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IcgNFqPby/lqPMJ09N5D+GAo5Y5VF8qoYdzMKKzRfnuPVSPhlufumqbxtlnh9XlGtkA/Di2si+hWBltZ9+iynTpbaKaNhFO8gD1PLOzkN79CNoWRGYP+s8ESQKWYPwGNdStwfuKxGzAUDfHuuVdeHL+MrGRH67JE0f64amx681M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaHD4Ksv; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaHD4Ksv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313232; x=1805849232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7ntPNrYl+47KNOOHyFIWOVc+HUTcEEeepncneeWUGY=;
  b=SaHD4KsvIsIm/S88oX46eYaKgLHJMtefjvX4Kfpfz0ghGd2Nh4d1tRdJ
   Rt9/a3WmVRundYHT/y1QO3BL8lD/uDM5stHCLNH85nQUPO6xEdZfZvYD/
   m6mYnJsrB8tK3lQ/EsejMMRlNNt4181GgkpEdPRMGuI0biSSeHZDJHjri
   2/vKuiWvx+vF9ktuCws/ENIuKqvPDXcdpn0r2zmjcpm3c/oD3b95zXVXs
   D8Rnh2B19RIRa+nAAkvU63BGSj8iCYQ2WrBaRBr8zZEOGuqdUlhYOAA3P
   JJBNjs9gNpMfAhNKMr3p9fwSWeF0iKGEd6Arr/qjLJX/p89OrO7T5ASTN
   A==;
X-CSE-ConnectionGUID: XGrzsR6HSaiCxcgo7I2q/g==
X-CSE-MsgGUID: rnh3YUsyTDSCjX6tf0O0VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397222"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397222"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:12 -0700
X-CSE-ConnectionGUID: jMTAVDrdRJW4B3QpCLMKWw==
X-CSE-MsgGUID: h8d07cRZTVKdZ39udYAXJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322925"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:07 -0700
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
Subject: [Patch v7 17/24] perf/x86: Enable OPMASK sampling using sample_simd_pred_reg_* fields
Date: Tue, 24 Mar 2026 08:41:11 +0800
Message-Id: <20260324004118.3772171-18-dapeng1.mi@linux.intel.com>
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

This patch adds support for sampling OPAMSK registers via the
sample_simd_pred_reg_* fields.

Each OPMASK register consists of 1 u64 word. Current x86 hardware
supports 8 OPMASK registers. The perf_simd_reg_value() function is
responsible for outputting OPMASK value to userspace.

Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
OPMASK sampling.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  5 +++++
 arch/x86/kernel/perf_regs.c           | 15 ++++++++++++---
 5 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index e5f5a6971d72..d86a4fbea1ed 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -729,6 +729,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1856,6 +1859,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
@@ -1877,6 +1881,8 @@ static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 /*
@@ -1938,6 +1944,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.abi)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 841c8880e6fd..00f436f5840b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -177,6 +177,16 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_opmask(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_simd_pred_reg_intr ||
+	     event->attr.sample_simd_pred_reg_user))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 273840bd7b33..7e8b60bddd5a 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -743,6 +743,10 @@ struct x86_perf_regs {
 		u64	*h16zmm_regs;
 		struct avx_512_hi16_state *h16zmm;
 	};
+	union {
+		u64	*opmask_regs;
+		struct avx_512_opmask_state *opmask;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index a889fd92f2f0..f4a1630c1928 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -60,14 +60,19 @@ enum {
 	PERF_X86_SIMD_YMM_REGS      = 16,
 	PERF_X86_SIMD_ZMM_REGS      = 32,
 	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
 };
 
+#define PERF_X86_SIMD_PRED_MASK	GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		16
 
 enum {
 	/* 1 qword = 8 bytes */
+	PERF_X86_OPMASK_QWORDS   = 1,
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
 	PERF_X86_ZMM_QWORDS      = 8,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index fe4ff4d2de88..2e3c10dffb35 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -86,8 +86,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 	struct x86_perf_regs *perf_regs =
 			container_of(regs, struct x86_perf_regs, regs);
 
-	if (pred)
-		return 0;
+	if (pred) {
+		if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_PRED_REGS_MAX ||
+				 qwords_idx >= PERF_X86_OPMASK_QWORDS))
+			return 0;
+		if (!perf_regs->opmask_regs)
+			return 0;
+		return perf_regs->opmask_regs[idx];
+	}
 
 	if (WARN_ON_ONCE(idx >= PERF_X86_SIMD_VEC_REGS_MAX ||
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
@@ -138,7 +144,10 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
 	}
-	if (pred_mask)
+
+	if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+		return -EINVAL;
+	if (pred_mask & ~PERF_X86_SIMD_PRED_MASK)
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

