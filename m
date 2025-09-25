Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8D72E8E0B;
	Thu, 25 Sep 2025 06:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780896; cv=none; b=PVMHsmslM3rb782JZOuKFiNw5b1x8sjz0l9diGsngrXnSiZ54S5RpywqZwdd42Z2wten7OxHcZaLE7/C3vfRZgEUFMeG8uIKGcZhePcMkx0AR63d3TMx4ELzf2OgBSeVfP5ZUGwBqC05lfSvLzlpOQFG1cXeFwVGiBQbFgEuKfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780896; c=relaxed/simple;
	bh=X3mDoHNgyY4P/PnSclDATS2I3DTrQS8+WKvEuaLwY24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cp++Iw+BWpBu1dQ1JmQgrC4t6txyXEDvFBd6LFzPFdFidYZ6XS+ub7Jmt18PgkklmXn9VVNzGTf3tBbY+1PeLJ3UVBJiwmLQlWT2SmV/MrpsDzES8FO+npMpW/D3y67mhupCKXKE/kNegv71u0qJ6he6mtNr54YNg6QHRQIRrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOLTPG8N; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOLTPG8N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780894; x=1790316894;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X3mDoHNgyY4P/PnSclDATS2I3DTrQS8+WKvEuaLwY24=;
  b=FOLTPG8NZVQZ+zMtct2Qy5TTfElqqutwCURQqxQf0gwRDiAvZyactSEH
   GK0X9eFcB8RmI1ugh4vbGsDNGzpAkJVsOxealseErzi18L6K2HKWN/pqv
   vxTYk7etwTPWGt0MaeT90ui9U1bv0gIqSXb2PPAeWY+qY949DU8g/CVz8
   9tnlAUelXPfyaGrYqg9wdJImJ5wUPZTuck3OdyCw/C1ZbbYVXG/YDv4dA
   0Q4A/NMmm0vVqKV89LEQJtD/ic66MpxL8gQx3AI3SuP2FRqAAwefDSolg
   31UvLHDga/13qRqinYolqO9Npa+VjJBZLsrDy0RCarRVLkebazEr4xS4r
   Q==;
X-CSE-ConnectionGUID: aUi2UeT1S7qWUVlKRrn+fQ==
X-CSE-MsgGUID: lwVEPv8PS/q/LCtoqhc3uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139562"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139562"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:14:54 -0700
X-CSE-ConnectionGUID: wJCFkXR2Q5uNcmycJHZLLQ==
X-CSE-MsgGUID: 0eb7SxQiT+C3/iLpjjge8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528395"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:49 -0700
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
Subject: [Patch v4 08/17] perf/x86: Add YMM into sample_simd_vec_regs
Date: Thu, 25 Sep 2025 14:12:04 +0800
Message-Id: <20250925061213.178796-9-dapeng1.mi@linux.intel.com>
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

The YMM0-15 is composed of XMM and YMMH. It requires 2 XSAVE commands to
get the complete value. Internally, the XMM and YMMH are stored in
different structures, which follow the XSAVE format. But the output
dumps the YMM as a whole.

The qwords 4 imply YMM.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  9 +++++++++
 arch/x86/events/perf_event.h          |  9 +++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++--
 arch/x86/kernel/perf_regs.c           | 14 +++++++++++++-
 5 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7b1b3eb80aa7..8543b96eeb58 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -423,6 +423,9 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 
 	if (valid_mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+
+	if (valid_mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 static void release_ext_regs_buffers(void)
@@ -725,6 +728,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_xmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event_needs_ymm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1875,6 +1881,9 @@ static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
 	perf_regs->xmm_regs = NULL;
 	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
+	perf_regs->ymmh_regs = NULL;
+	if (event_needs_ymm(event))
+		mask |= XFEATURE_MASK_YMM;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 6f22ed718a75..3196191791a7 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -145,6 +145,15 @@ static inline bool event_needs_xmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_ymm(struct perf_event *event)
+{
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
index fd4fe31e510b..fd5338a89ba3 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -601,6 +601,10 @@ struct x86_perf_regs {
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
index c3862e5fdd6d..4fd598785f6d 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -57,19 +57,23 @@ enum perf_event_x86_regs {
 
 enum {
 	PERF_REG_X86_XMM,
+	PERF_REG_X86_YMM,
 	PERF_REG_X86_MAX_SIMD_REGS,
 };
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK		GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 enum {
 	PERF_X86_XMM_QWORDS      = 2,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+	PERF_X86_YMMH_QWORDS     = 2,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 6fd691cb7e64..1fcf8fa76607 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -68,6 +68,11 @@ void perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
 	    !perf_regs->xmm_regs)
 		*nr_vectors = 0;
 
+	if (!(ignore & XFEATURE_MASK_YMM) &&
+	    *vec_qwords >= PERF_X86_YMM_QWORDS &&
+	    !perf_regs->ymmh_regs)
+		*vec_qwords = PERF_X86_XMM_QWORDS;
+
 	*nr_pred = 0;
 }
 
@@ -95,6 +100,7 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 			u16 qwords_idx, bool pred)
 {
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
+	int index;
 
 	if (pred)
 		return 0;
@@ -107,6 +113,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 		if (!perf_regs->xmm_regs)
 			return 0;
 		return perf_regs->xmm_regs[idx * PERF_X86_XMM_QWORDS + qwords_idx];
+	} else if (qwords_idx < PERF_X86_YMM_QWORDS) {
+		if (!perf_regs->ymmh_regs)
+			return 0;
+		index = idx * PERF_X86_YMMH_QWORDS + qwords_idx - PERF_X86_XMM_QWORDS;
+		return perf_regs->ymmh_regs[index];
 	}
 
 	return 0;
@@ -123,7 +134,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 		if (vec_mask)
 			return -EINVAL;
 	} else {
-		if (vec_qwords != PERF_X86_XMM_QWORDS)
+		if (vec_qwords != PERF_X86_XMM_QWORDS &&
+		    vec_qwords != PERF_X86_YMM_QWORDS)
 			return -EINVAL;
 		if (vec_mask & ~PERF_X86_SIMD_VEC_MASK)
 			return -EINVAL;
-- 
2.34.1

