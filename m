Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989E72EAB68;
	Thu, 25 Sep 2025 06:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780906; cv=none; b=EQG806UYfnVzeCFM8NX9/lhJsPqC0IBx0KYBRrU5WAmW5SiLrB1zD03aeFV74Y/JacHP3uwOJagLaWImJCVhkbDM2IMqtXIg75WC2BTV+OjVLHJgSek3OFHFb2XnvJpvaVJ/MIzCMSpn/STQIi+HTOxBvfZYv1NJX6yImQYg15E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780906; c=relaxed/simple;
	bh=M8JaimxDYWWw9Jlp45CK/a74cGwOklbYeikdlLiazOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mll9npAnCY0n+Fc2ttKKnjPmzcBaN0jOFOFLuPN+WUl79F5ye/HEc2kMePXBS92tx46DLYVsz5L0/ZSIcnzUgjqpurj7l727TdIiXVTG6FzZmWnTIjkI5a7N+o6Vyxy6IlW0d1NAJsk9sAPdAuXQaHMcKxZBfs66f3lw0TsUhbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jnOXbPyZ; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jnOXbPyZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780905; x=1790316905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M8JaimxDYWWw9Jlp45CK/a74cGwOklbYeikdlLiazOU=;
  b=jnOXbPyZDFHUv/I9j4Rl/mVfKE+qQKujciGK3V/C5fpkSRbscoc9cDv/
   C4MjQUun54aRJe820vH/RoInuw+Fe7RDwcyLwKmtUtnnCV6JsR3GfIMRr
   y5yMv2Z/GS0HTw0eMMy7HxGq+fnnTl6MT1idIdKIm0hwl78BHGVDga/YM
   D9HYN1+J9bDD+sbDOZj7sbO6+TdFH5hFANmQbwFcvaO0x4Flh/v+1xjyT
   e3r++nm2wOWmGCqfzAuiGp5l+sLlhrhKqnblGo/BCMaGfrqZickr1+lt9
   SsvBc8VssIGJTJhUqM2L7EW/fuuqqdWSKRkLl3X8lCm2oDAyysNM8LBD0
   Q==;
X-CSE-ConnectionGUID: Yf2PesecS4KPr/aBUTvcUw==
X-CSE-MsgGUID: OkHsuZGmTeCB73Llo7QJ2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139581"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139581"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:04 -0700
X-CSE-ConnectionGUID: +1p/oXYxSGCAjwZunjmAGw==
X-CSE-MsgGUID: XtwOr4YkRX6Wxy3JVqTfZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528473"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:14:59 -0700
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
Subject: [Patch v4 10/17] perf/x86: Add OPMASK into sample_simd_pred_reg
Date: Thu, 25 Sep 2025 14:12:06 +0800
Message-Id: <20250925061213.178796-11-dapeng1.mi@linux.intel.com>
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

The OPMASK is the SIMD's predicate registers. Add them into
sample_simd_pred_reg. The qwords of OPMASK is 1. There are 8 registers.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          |  9 +++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  8 ++++++++
 arch/x86/kernel/perf_regs.c           | 19 +++++++++++++++----
 5 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 87572b85d234..c942c6f808ca 100644
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
@@ -741,6 +743,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1900,6 +1905,9 @@ static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
 	perf_regs->h16zmm_regs = NULL;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	perf_regs->opmask_regs = NULL;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3d6a5739d86e..4584de1c79a3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -173,6 +173,15 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_opmask(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_simd_pred_reg_intr || event->attr.sample_simd_pred_reg_user))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 44e89adedc61..d8cac3f9f8df 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -613,6 +613,10 @@ struct x86_perf_regs {
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
index 8d877b2be957..f6e9cde11ba1 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -83,7 +83,9 @@ void perf_simd_reg_check(struct pt_regs *regs, u64 ignore,
 	    !perf_regs->h16zmm_regs)
 		*nr_vectors = PERF_X86_H16ZMM_BASE;
 
-	*nr_pred = 0;
+	if (!(ignore & XFEATURE_MASK_OPMASK) &&
+	    *nr_pred && !perf_regs->opmask_regs)
+		*nr_pred = 0;
 }
 
 u64 perf_reg_value(struct pt_regs *regs, int idx)
@@ -112,8 +114,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 	int index;
 
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
@@ -162,7 +170,10 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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

