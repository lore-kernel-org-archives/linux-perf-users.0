Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC762EA49A;
	Thu, 25 Sep 2025 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780901; cv=none; b=t0hdv5ysq7hJzxFBk3Un4Ny+mdqjY6ZhaaIxPs5pn3P6w+qgoUEuOjloT+a+bPy79MXBLTetTLHLucwbNjN3dd6Sna/E8+zeob53SHkbA3rc4GGblptTEim7mvPtR9UZ+uok58rzcpr+PWl7bTuaP+e6ozdAxq1FW4GdCqSu8jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780901; c=relaxed/simple;
	bh=OeKJMfhaX4ccEIAW6Ni6cEkDJIXQXfNDgC/0YRbO58k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZpAuLW04wDYZ427BLFHzMqso+GhMErdFJoXCnh/E18PPw7NLkbHuN4osWUxtFaFN9R4QOlr2g2sJ84aa7n09fvboUIQYRBtEWpQ1nUIlbk3B7pDnqbs47rhmWG3Rjmb7X2VF8rv+e6OMteQsk5iYYA8aWm3/HMoola/yovuPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTo6Ff84; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTo6Ff84"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780900; x=1790316900;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeKJMfhaX4ccEIAW6Ni6cEkDJIXQXfNDgC/0YRbO58k=;
  b=FTo6Ff84rACrkyDD99zZZtfgtK+Jj5z4/YpCdx/Ud77EoehvQiyT/5a9
   6VQBC9AlsnjBamF3hOPYq1t2xblTXmbyh6S1b/aa6+kvbSEp3m2zgRNH5
   bp1ltxadLRtXZz3VVPvDt9T2iaql78S41licJpHPgRrDcGS8wLd2cct/C
   jNYQVz2CENEG6eJLVR0UryWXWmJ5k1hkbSYnYY64OWRjXVFc9EVVgXJer
   K3nsWInMofgQHWO1JgiMvpW43GlNR7wvq6tCbYzZrEbFE3GTO76AVbQTH
   AQols9NOKednJ+QrKr2/iohCyv2D7Dyld2XhjPFPAwOXxbHFszJKcn71V
   w==;
X-CSE-ConnectionGUID: vkXdC8OdSs6yQzcWNfpbBA==
X-CSE-MsgGUID: TB0kZrQ6QXGegbHOWCaBag==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139578"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139578"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:59 -0700
X-CSE-ConnectionGUID: M9otfPhdS+iLM1KJx5sYcg==
X-CSE-MsgGUID: Rw2pUq5iR7K+cLI9OO0d0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528414"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:54 -0700
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
Subject: [Patch v4 09/17] perf/x86: Add ZMM into sample_simd_vec_regs
Date: Thu, 25 Sep 2025 14:12:05 +0800
Message-Id: <20250925061213.178796-10-dapeng1.mi@linux.intel.com>
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

The ZMM0-15 is composed of XMM, YMMH, and ZMMH. It requires 3 XSAVE
commands to get the complete value.
The ZMM16-31/YMM16-31/XMM16-31 are also supported, which only require
the XSAVE Hi16_ZMM.

Internally, the XMM, YMMH, ZMMH and Hi16_ZMM are stored in different
structures, which follow the XSAVE format. But the output dumps the ZMM
or Hi16 XMM/YMM/ZMM as a whole.

The qwords 8 imply ZMM.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 16 ++++++++++++++++
 arch/x86/events/perf_event.h          | 19 +++++++++++++++++++
 arch/x86/include/asm/perf_event.h     |  8 ++++++++
 arch/x86/include/uapi/asm/perf_regs.h | 11 +++++++++--
 arch/x86/kernel/perf_regs.c           | 24 +++++++++++++++++++++++-
 5 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8543b96eeb58..87572b85d234 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -426,6 +426,10 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 
 	if (valid_mask & XFEATURE_MASK_YMM)
 		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
+	if (valid_mask & XFEATURE_MASK_ZMM_Hi256)
+		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
+	if (valid_mask & XFEATURE_MASK_Hi16_ZMM)
+		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
 }
 
 static void release_ext_regs_buffers(void)
@@ -731,6 +735,12 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_ymm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
 				return -EINVAL;
+			if (event_needs_low16_zmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_ZMM_Hi256))
+				return -EINVAL;
+			if (event_needs_high16_zmm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1884,6 +1894,12 @@ static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
 	perf_regs->ymmh_regs = NULL;
 	if (event_needs_ymm(event))
 		mask |= XFEATURE_MASK_YMM;
+	perf_regs->zmmh_regs = NULL;
+	if (event_needs_low16_zmm(event))
+		mask |= XFEATURE_MASK_ZMM_Hi256;
+	perf_regs->h16zmm_regs = NULL;
+	if (event_needs_high16_zmm(event))
+		mask |= XFEATURE_MASK_Hi16_ZMM;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3196191791a7..3d6a5739d86e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -154,6 +154,25 @@ static inline bool event_needs_ymm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_low16_zmm(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_vec_reg_qwords >= PERF_X86_ZMM_QWORDS)
+		return true;
+
+	return false;
+}
+
+static inline bool event_needs_high16_zmm(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (fls64(event->attr.sample_simd_vec_reg_intr) > PERF_X86_H16ZMM_BASE ||
+	     fls64(event->attr.sample_simd_vec_reg_user) > PERF_X86_H16ZMM_BASE))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fd5338a89ba3..44e89adedc61 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -605,6 +605,14 @@ struct x86_perf_regs {
 		u64	*ymmh_regs;
 		struct ymmh_struct *ymmh;
 	};
+	union {
+		u64	*zmmh_regs;
+		struct avx_512_zmm_uppers_state *zmmh;
+	};
+	union {
+		u64	*h16zmm_regs;
+		struct avx_512_hi16_state *h16zmm;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index 4fd598785f6d..96db454c7923 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -58,22 +58,29 @@ enum perf_event_x86_regs {
 enum {
 	PERF_REG_X86_XMM,
 	PERF_REG_X86_YMM,
+	PERF_REG_X86_ZMM,
 	PERF_REG_X86_MAX_SIMD_REGS,
 };
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
 	PERF_X86_SIMD_YMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
+	PERF_X86_SIMD_ZMMH_REGS     = 16,
+	PERF_X86_SIMD_ZMM_REGS      = 32,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_ZMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
+#define PERF_X86_H16ZMM_BASE		PERF_X86_SIMD_ZMMH_REGS
+
 enum {
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMMH_QWORDS     = 2,
 	PERF_X86_YMM_QWORDS      = 4,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
+	PERF_X86_ZMMH_QWORDS     = 4,
+	PERF_X86_ZMM_QWORDS      = 8,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_ZMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 1fcf8fa76607..8d877b2be957 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -73,6 +73,16 @@ void perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
 	    !perf_regs->ymmh_regs)
 		*vec_qwords = PERF_X86_XMM_QWORDS;
 
+	if (!(ignore & XFEATURE_MASK_ZMM_Hi256) &&
+	    *vec_qwords >= PERF_X86_ZMM_QWORDS &&
+	    !perf_regs->zmmh_regs)
+		*vec_qwords = PERF_X86_YMM_QWORDS;
+
+	if (!(ignore & XFEATURE_MASK_Hi16_ZMM) &&
+	    *nr_vectors > PERF_X86_H16ZMM_BASE &&
+	    !perf_regs->h16zmm_regs)
+		*nr_vectors = PERF_X86_H16ZMM_BASE;
+
 	*nr_pred = 0;
 }
 
@@ -109,6 +119,12 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			 qwords_idx >= PERF_X86_SIMD_QWORDS_MAX))
 		return 0;
 
+	if (idx >= PERF_X86_H16ZMM_BASE) {
+		if (!perf_regs->h16zmm_regs)
+			return 0;
+		return perf_regs->h16zmm_regs[idx * PERF_X86_ZMM_QWORDS + qwords_idx];
+	}
+
 	if (qwords_idx < PERF_X86_XMM_QWORDS) {
 		if (!perf_regs->xmm_regs)
 			return 0;
@@ -118,6 +134,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			return 0;
 		index = idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS;
 		return perf_regs->ymmh_regs[index];
+	} else if (qwords_idx < PERF_X86_ZMM_QWORDS) {
+		if (!perf_regs->zmmh_regs)
+			return 0;
+		index = idx * PERF_X86_ZMMH_QWORDS + qwords_idx - PERF_X86_YMM_QWORDS;
+		return perf_regs->zmmh_regs[index];
 	}
 
 	return 0;
@@ -135,7 +156,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 			return -EINVAL;
 	} else {
 		if (vec_qwords != PERF_X86_XMM_QWORDS &&
-		    vec_qwords != PERF_X86_YMM_QWORDS)
+		    vec_qwords != PERF_X86_YMM_QWORDS &&
+		    vec_qwords != PERF_X86_ZMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
-- 
2.34.1

