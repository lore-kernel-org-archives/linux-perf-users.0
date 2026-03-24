Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29CC350A10;
	Tue, 24 Mar 2026 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313223; cv=none; b=LBkfyXzba4/QNCSW4ocwLr+zEnI18csDDM3sG6EC8eLAJbhqlOtnuM+bZPcopSSclIVbNhiuDRRTfYq+rWFzG14z9WmhynpVITBoCu6gKx5/ES1nxbq83/otTJFXnDVJsdqPWH66xgKT1cSDGnzZLx7fX5GjoQ3yHOsvO/3jM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313223; c=relaxed/simple;
	bh=hgvap5aS9xwKqhgpYNVLDdl6QyKRzu0zU+wBaYxYo2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGOXZUB14kSJ2r3B4H367FTeaqWDWlR7Ox0mpo3EOUMm6AtcwLtKqFVD6KTQdewZakum4q07p5wMt5mSG6qQgj5x3yUSW/X2FOE1mMQdy11NNZyH1pslNLvaDlvpdDKmihKqBr8dxxJvWOxTdtqk2oBsRzRu4cC7uhgGuj1gkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=axqUUCNP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="axqUUCNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313222; x=1805849222;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hgvap5aS9xwKqhgpYNVLDdl6QyKRzu0zU+wBaYxYo2Q=;
  b=axqUUCNPMCI2KnSdQkwK5W9aNC9GMurMujJjBKGmKc5vpsTgXKdGXeU8
   cBYP6imb5lIGiuM6m42nB+TmgLuyuOrg1JKP8OuuOKEt5klMjMbOD3I9i
   EWoeeSfNMfmAjRmNpyCt1jj0nSBVkz7niF3FHH0WfrKJR3EPKPJz7ksOK
   kpYJAY8o0zzJjOMPcw7ypiELT+rEy/8e1eQWneZpebOeVSO4qiZrSJuRF
   MKUp/FD8AWd+QZclQncRepx8hi5wYNwjrUT5FPar+shGdY5AqsPzvTo0E
   eeL2PGBDSVqJjilqJ2dIIwNZFs/ih1FpMZGpnWMpL2nIDy1W6xsZDjehh
   A==;
X-CSE-ConnectionGUID: 6uvIrcXHTZOoC8uCcNyKkw==
X-CSE-MsgGUID: noc2FcwpQ+2EpK0wN6N1ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397184"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397184"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:02 -0700
X-CSE-ConnectionGUID: 3XZWCqwlQCa9rxJcdqSzhA==
X-CSE-MsgGUID: 8pTIBboUSTCeNba9UvaHew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322854"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:46:58 -0700
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
Subject: [Patch v7 15/24] perf/x86: Enable YMM sampling using sample_simd_vec_reg_* fields
Date: Tue, 24 Mar 2026 08:41:09 +0800
Message-Id: <20260324004118.3772171-16-dapeng1.mi@linux.intel.com>
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
index 3c9b79b46a66..cdea5a10ec9f 100644
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
 
 static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
@@ -1859,6 +1863,8 @@ static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
 
 	if (mask & XFEATURE_MASK_SSE)
 		perf_regs->xmm_space = xsave->i387.xmm_space;
+	if (mask & XFEATURE_MASK_YMM)
+		perf_regs->ymmh = get_xsave_addr(xsave, XFEATURE_YMM);
 }
 
 /*
@@ -1914,6 +1920,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 
 	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
+	if (event_needs_ymm(event))
+		mask |= XFEATURE_MASK_YMM;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.abi)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 26d162794a36..8d5484462f75 100644
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
index e54d21c13494..1d03b86be65d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -731,6 +731,10 @@ struct x86_perf_regs {
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
index c5c1b3930df1..42d53978ea72 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -57,7 +57,8 @@ enum perf_event_x86_regs {
 
 enum {
 	PERF_X86_SIMD_XMM_REGS      = 16,
-	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_XMM_REGS,
+	PERF_X86_SIMD_YMM_REGS      = 16,
+	PERF_X86_SIMD_VEC_REGS_MAX  = PERF_X86_SIMD_YMM_REGS,
 };
 
 #define PERF_X86_SIMD_VEC_MASK	GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
@@ -65,7 +66,8 @@ enum {
 enum {
 	/* 1 qword = 8 bytes */
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

