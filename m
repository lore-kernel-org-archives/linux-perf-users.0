Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4001EB5F8;
	Mon,  9 Feb 2026 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770621960; cv=none; b=B9hsagKK6IcpgcSPLCU9K+wFXmuVsfUa++7cVcZmIN5Fd27BG8oPRx37V36wSydWzy7f14KLlvNqgPfKdmX+YDptplcNCQCgknXP40RkLeV3kJCKtmVieaiKp18ugLEvs3US+hb7u+cM4a4Rba4WMwXvZX9tQCm4QnwemUPUA58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770621960; c=relaxed/simple;
	bh=jriykwEad+iBDY2GTzkb2a5ufWlBGyPXfBTLdGWy+Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aoZWU9IaoKNRVlK96P0+VLPs1Bg0Jw9HhrWBa0hVXmjDsjU8gd72OyIQ+I57Wy1mliQq6YwEOW2tK7ZZ9fkP99FtNNBY1wx2ixUFVWp5nciu2bZxXOzOI48xVuaR7PntnFryEYtg2T+ZOUvh76NnYE3aEKiyN1QsDUDZ5udzcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKBhcfC3; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKBhcfC3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770621960; x=1802157960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jriykwEad+iBDY2GTzkb2a5ufWlBGyPXfBTLdGWy+Dc=;
  b=mKBhcfC3LgJV4scGE4Sy2t5UgEbPjk+oYeQoemVDr7L9nqWTsoy0bkXE
   eWg6F7rQGoiKShWql63n6ZBj71SGB1KU4Q0bfTTf3Z/5QR6FuzItYYr0V
   QLGGIERHlP+kAmrd4UJrFvv7DnobHR4Dn8d6+gxcQSu6zz+iUmKG8Q9pR
   WqR74cMhsnhcr0PQPOqaOP7Q4zwY3gpAjdIcyZF1kKBRagO5+SlCcsxl9
   PhqUU/bKCDNrCsKcilWvDm01tipVyaFBZW2uhIQROxvgAjBTivtJO6kTx
   1Vjy37PJYEtoo3XJlsoRKLm+roRrLIhScnHi7fXY+UCMxztmqqxt13Lp1
   g==;
X-CSE-ConnectionGUID: 97cvdIzCTnq9OHjBpL17Wg==
X-CSE-MsgGUID: chlU0PxSRbWw1zZAxMF6+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83098480"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="83098480"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 23:26:00 -0800
X-CSE-ConnectionGUID: XCuM8O1dTTuVHXMgc5hXCw==
X-CSE-MsgGUID: 3BCDDvdqTiikwGYemdM1Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="241694751"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa001.fm.intel.com with ESMTP; 08 Feb 2026 23:25:55 -0800
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
Subject: [Patch v6 14/22] perf/x86: Enable YMM sampling using sample_simd_vec_reg_* fields
Date: Mon,  9 Feb 2026 15:20:39 +0800
Message-Id: <20260209072047.2180332-15-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
References: <20260209072047.2180332-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

This patch introduces support for sampling YMM registers via the
sample_simd_vec_reg_* fields.

Each YMM register consists of 4 u64 words, assembled from two halves:
XMM (the lower 2 u64 words) and YMMH (the upper 2 u64 words). Although
both XMM and YMMH data can be retrieved with a single xsaves instruction,
they are stored in separate locations. The perf_simd_reg_value() function
is responsible for assembling these halves into a complete YMM register
for output to userspace.

Additionally, sample_simd_vec_reg_qwords should be set to 4 to indicate
YMM sampling.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          |  9 +++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  6 ++++--
 arch/x86/kernel/perf_regs.c           | 10 +++++++++-
 5 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index bd47127fb84d..e80a392e30b0 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -720,6 +720,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_xmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event_needs_ymm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1844,6 +1847,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
 }
 
 static inline void __x86_pmu_sample_ext_regs(u64 mask)
@@ -1869,6 +1873,8 @@ static inline void x86_pmu_update_ext_regs(struct x86_perf_regs *perf_regs,
 
 	if (mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+	if (mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 /*
@@ -1928,6 +1934,8 @@ static void x86_pmu_sample_extended_regs(struct perf_event *event,
 
 	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
+	if (event_needs_ymm(event))
+		mask |= XFEATURE_MASK_YMM;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 02eea137e261..4f18ba6ef0c4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -149,6 +149,15 @@ static inline bool event_needs_xmm(struct perf_event *event)
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
index 1f172740916c..bffe47851676 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -714,6 +714,10 @@ struct x86_perf_regs {
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
index 342b08448138..eac11a29fce6 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -57,14 +57,16 @@ enum perf_event_x86_regs {
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 enum {
 	PERF_X86_XMM_QWORDS      = 2,
-	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_XMM_QWORDS,
+	PERF_X86_YMM_QWORDS      = 4,
+	PERF_X86_SIMD_QWORDS_MAX = PERF_X86_YMM_QWORDS,
 };
 
 #endif /* _ASM_X86_PERF_REGS_H */
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 9947a6b5c260..4062a679cc5b 100644
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
@@ -95,6 +97,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -111,7 +118,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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

