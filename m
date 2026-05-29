Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAEB3B38AA;
	Fri, 29 May 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780041840; cv=none; b=uqo9xZn2wn4qtaDG2iALViobRelk6pJvKu+jAdr24h4w7m8MgnrAJAbknjGD5hg7IH1APimpUUzN/a5W47nnKLN7hfyCj4b7R52kS4lqpUTKyRqGBwZp/TrDy+JZm/AlB0N7/FpWn1+ryX00ZEkInO5PcsQlBB8/xx/FPD4/IAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780041840; c=relaxed/simple;
	bh=rZBr9qflDrLN/WbZSugLXTx8IysHRIo0zqEmyduN7y0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z6ZuFS4ihV3hjaVhBEED+olTKfm6PDr4eEZI03QSRui7RqSEWvNARTxylBZZ4JUgXurRTQRoPwQhkUkruQU4oIPXFgb5G1UxiK79c58BcL5p0NGSYo9qFw564tmQUR2AerJzks8D2dbAnvjynSb74+TdEib8vHVW0sPt0P8PUus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mb2YtgGr; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mb2YtgGr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780041839; x=1811577839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rZBr9qflDrLN/WbZSugLXTx8IysHRIo0zqEmyduN7y0=;
  b=Mb2YtgGrbZjNFliCyCG9zOv2z7sRrJvRGVHshcedOfQnz4NK9j6CmtCM
   saNzWuJ/TzH9cqDTwuheLkRJAeaDajtk92S8doNEKxeoNVBw+PbuE9Cnt
   +vXTaE63ctq31BP4IUdiTdcHX/sATrLHkfpFBRECsczs6600wyFzDL1i3
   8YisPQLJkeRXdF3jr57xY8tGr+D+X7ZFqTPej1GRpQPiLmF/tPxY8ux4X
   U8q4+I52uk2G7hdGofrgqWzexssxF8yrqrNsF/0qhYx5A7wW1d5IsiIq3
   qmDB43hxX+S64Ttd6cc11JHkML2oUA6bxt/lujtKUC6FBUNz4EtlVJfTV
   Q==;
X-CSE-ConnectionGUID: 5I9eQNwGQw+phzBr+7imyg==
X-CSE-MsgGUID: W+ioE4C+S/KcPBx3i28P/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="106342079"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="106342079"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 01:03:59 -0700
X-CSE-ConnectionGUID: e+l6Y8/pTEy+rn/H7ojV7Q==
X-CSE-MsgGUID: TuvHjGh3RWKRUpdXDMaUWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="246802418"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa003.jf.intel.com with ESMTP; 29 May 2026 01:03:54 -0700
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
Subject: [Patch v8 16/23] perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
Date: Fri, 29 May 2026 15:56:38 +0800
Message-Id: <20260529075645.580362-17-dapeng1.mi@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
References: <20260529075645.580362-1-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds support for sampling OPMASK registers via the
sample_simd_pred_reg_* fields.

Each OPMASK register consists of 1 u64 word. Current x86 hardware
supports 8 OPMASK registers. The perf_simd_reg_value() function is
responsible for outputting OPMASK value to userspace.

Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
OPMASK sampling.

Please note OPMASK sampling is not enabled yet, it will be enabled in a
later patch when PERF_PMU_CAP_SIMD_REGS is set.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  5 +++++
 arch/x86/kernel/perf_regs.c           | 23 +++++++++++++++++++----
 5 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3051a53232c8..d4516d3b5d5a 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -741,6 +741,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1788,6 +1791,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1809,6 +1813,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 /*
@@ -1991,6 +1997,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 53c5802317bb..22b846999cfa 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -187,6 +187,16 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
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
index 3aacdd4e2764..24c981ba8bae 100644
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
 
+#define PERF_X86_SIMD_PRED_MASK	__GENMASK(PERF_X86_SIMD_PRED_REGS_MAX - 1, 0)
 #define PERF_X86_SIMD_VEC_MASK	__GENMASK_ULL(PERF_X86_SIMD_VEC_REGS_MAX - 1, 0)
 
 #define PERF_X86_H16ZMM_BASE		16
 
 enum {
 	/* 1 qword = 8 bytes */
+	PERF_X86_OPMASK_QWORDS   = 1,
 	PERF_X86_XMM_QWORDS      = 2,
 	PERF_X86_YMM_QWORDS      = 4,
 	PERF_X86_ZMM_QWORDS      = 8,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index 3c28f28de1e6..21b282be8ab9 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -89,8 +89,14 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
 	if (!(perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD))
 		return 0;
 
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
@@ -151,8 +157,17 @@ int perf_simd_reg_validate(u16 simd_enabled, u16 vec_qwords,
 			return -EINVAL;
 	}
 
-	if (pred_qwords || pred_mask_intr || pred_mask_user)
-		return -EINVAL;
+	if (!pred_qwords) {
+		if (pred_mask_intr || pred_mask_user)
+			return -EINVAL;
+	} else {
+		if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+			return -EINVAL;
+		if ((!pred_mask_intr && !pred_mask_user) ||
+		    (pred_mask_intr & ~PERF_X86_SIMD_PRED_MASK) ||
+		    (pred_mask_user & ~PERF_X86_SIMD_PRED_MASK))
+			return -EINVAL;
+	}
 
 	size = ((vec_qwords * hweight64(vec_mask_intr)) +
 		(vec_qwords * hweight64(vec_mask_user)) +
-- 
2.34.1

