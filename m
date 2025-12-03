Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F62BE7A7;
	Wed,  3 Dec 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745139; cv=none; b=U2dwerL6brNYjwdAHswK+4sTCVkKzPPFnaNr+pcIAyVpFnJKonQUKuiRka3na9xZxp4j0j+SaRUr19ARRcumkjEBWxtIVs+h/droqS2OtXMTZWqCBicNQ12FakaU1AHxLdl6u0Dcrb3WM3EUCp/z8I7Seyzwu/+WXk28l6euwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745139; c=relaxed/simple;
	bh=QeTVpFSlvbyMhrMYMIPPCJXoPq4f/BngnZbhnxX0n2M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2cp89oxKT6fH3Ratzrd+dPh/JsT24K16/GTEs/NaSltuT2WHSs9mHrv/8JN02Bu7D3P3z+QZekQr+oXagVwuFwbIOt1IzKpa8g+vdiBnZMJLThNS+pLzP9TIlOrgCsvFjJsFUgkhyPMC5wOSB1WiihVQ2jUsLXTbqab0kXx3Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hC7b7Y6T; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hC7b7Y6T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745137; x=1796281137;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QeTVpFSlvbyMhrMYMIPPCJXoPq4f/BngnZbhnxX0n2M=;
  b=hC7b7Y6T/oqfaRg25/gJLsGg2Me4jvDo3dC5OmX49oc3AxK4fPzM/0rA
   ZQz4EUcQqK93XJY/nQGeoHAu9l0GRbjDkhH6RnTAuwuZxWYSMBqVMgGM5
   eUrd9Q7r6s6EN2nPSpTL7O6Oy7pkUq5UoKtXc2b2y/Xi5+ANX2MlEZkyd
   i6jeUJHwTD4vN2DKdZBX/k2cQ+t4EwSA1rEQ92WE0xVNMifAw47ihVF8r
   4CNzvbU+ADFckB1jjed3+Zd9gW1BCt4fUEo8CkAK4PL/eJSgxHZEI3eqO
   +CFJ0DeBpdX9tL7YO7HtC3cqLF1awjUlcjsZOn1dUyBF7lWymqATMN35/
   w==;
X-CSE-ConnectionGUID: UUb36myYR1qkBAJGKNxL9A==
X-CSE-MsgGUID: HOxtSOG9RHSASs1YnizlMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324869"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324869"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:57 -0800
X-CSE-ConnectionGUID: LXwPhZZQQn61oPuJtILq8Q==
X-CSE-MsgGUID: z1lz8/QUQQ6LJJH65DK5aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003956"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:52 -0800
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
Subject: [Patch v5 11/19] perf/x86: Enable OPMASK sampling using sample_simd_pred_reg_* fields
Date: Wed,  3 Dec 2025 14:54:52 +0800
Message-Id: <20251203065500.2597594-12-dapeng1.mi@linux.intel.com>
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
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++++
 arch/x86/kernel/perf_regs.c           | 15 ++++++++++++---
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d9c2cab5dcb9..3a4144ee0b7b 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -430,6 +430,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (valid_mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (valid_mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 static void release_ext_regs_buffers(void)
@@ -751,6 +753,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1833,6 +1838,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
@@ -1908,6 +1914,8 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9a871809a4aa..7e081a392ff8 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -173,6 +173,16 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
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
index e4d9a8ba3e95..caa6df8ac1cd 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -721,6 +721,10 @@ struct x86_perf_regs {
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
index 96db454c7923..6f29fd9495a2 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -60,6 +60,9 @@ enum {
 	PERF_REG_X86_YMM,
 	PERF_REG_X86_ZMM,
 	PERF_REG_X86_MAX_SIMD_REGS,
+
+	PERF_REG_X86_OPMASK = 0,
+	PERF_REG_X86_MAX_PRED_REGS = 1,
 };
 
 enum {
@@ -68,13 +71,18 @@ enum {
 	PERF_X86_SIMD_ZMMH_REGS     = 16,
 	PERF_X86_SIMD_ZMM_REGS      = 32,
 	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
+
+	PERF_X86_SIMD_OPMASK_REGS   = 8,
+	PERF_X86_SIMD_PRED_REGS_MAX = PERF_X86_SIMD_OPMASK_REGS,
 };
 
+#define PERF_X86_SIMD_PRED_MASK		GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		PERF_X86_SIMD_ZMMH_REGS
 
 enum {
+	PERF_X86_OPMASK_QWORDS   = 1,
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMMH_QWORDS     = 2,
 	PERF_X86_YMM_QWORDS      = 4,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 0a3ffaaea3aa..1ca24e2a6aa0 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -83,8 +83,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -135,7 +141,10 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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

