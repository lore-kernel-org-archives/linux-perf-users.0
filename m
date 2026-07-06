Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2991837BE7C;
	Mon,  6 Jul 2026 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783303362; cv=none; b=Wx0JhScmPOnrUzeLlAyk5YJXLmiry+/fOnJc/fY08eXsrpMn66UOuEMxa5j1cs1XQIfx+SgPha+UNPxe3id9AzkmwDtQboZOuzRoJ12Woc10JOV+E6gVYrMPBY7D6DDbdZFH3XNXeGLD/EXk6HRj6n8bN7k+nOKixoXEWE2Ovvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783303362; c=relaxed/simple;
	bh=gIXGHKriF1WKD0AWB2VEhsvt+TPOQvaLK/QE56oUXxo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NcUCIx3Yami2g4ttsUEenRFQ7fTBtMYQLpKHLUtxtq5MUizpEQXhwNX5p+p85Bhel6xF0TsYHCMIciEHy70GXv8E8C56JQiYKUEtRmBKlsOJnc4oovvbWtg1ZIjDUerrlfCcIVqVEW59gR0aIjawzgntEkM5FQaJkmK1AUYhnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXBP01Xo; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXBP01Xo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783303362; x=1814839362;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gIXGHKriF1WKD0AWB2VEhsvt+TPOQvaLK/QE56oUXxo=;
  b=eXBP01XohCJbSXnG30ZXijHp6qPSg7mRhvpUM+6LjB3NY9bvOBj3vW9g
   YvYo5857cr40cTTaFz8dNSKeDtGHMbtVKDd5HxI7peNJacXZ23Ax36RJW
   qk52ugqod1cWQZ5ZyRxyD/M0IvjE5FXTpWYyipaiKW1le/9bF1Jx3rg9R
   fmWjUS4ywcov4hiLFQVcn2E9jzrbxlim+Go87MusqaeMYaW854rxzeDsq
   nn37dw+lZNHxY+UOGGCVzOeujSdVGmnoUj7oGMTmoAHK83h9hrXTUN1uN
   3tLjqehzIzSWxIEj/vr2ZEVJHZLPGzQO9ritJe9HmhicE9967auLFO2Pz
   g==;
X-CSE-ConnectionGUID: hnYsNLZqRq6ZF8CO3Eh3NQ==
X-CSE-MsgGUID: A7sxZBD5S3qdF8xBdEd4VA==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="83911731"
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="83911731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2026 19:02:36 -0700
X-CSE-ConnectionGUID: V0F8CEsKTQCDnP5lVjJITA==
X-CSE-MsgGUID: VM51l3cSQwuDEj22/t3lzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,149,1779174000"; 
   d="scan'208";a="247191463"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa009.fm.intel.com with ESMTP; 05 Jul 2026 19:02:30 -0700
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
Subject: [Patch v9 17/24] perf/x86: Support OPMASK sampling using sample_simd_pred_reg_* fields
Date: Mon,  6 Jul 2026 09:54:32 +0800
Message-Id: <20260706015439.3040804-18-dapeng1.mi@linux.intel.com>
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

Support sampling of OPMASK registers via the sample_simd_pred_reg_*
fields.

Each OPMASK register consists of 1 u64 word. Current x86 hardware
supports 8 OPMASK registers. The perf_simd_reg_value() function is
responsible for outputting OPMASK value to userspace.

Additionally, sample_simd_pred_reg_qwords should be set to 1 to indicate
OPMASK sampling.

OPMASK sampling will be enabled in a subsequent patch that sets
PERF_PMU_CAP_SIMD_REGS.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  8 ++++++++
 arch/x86/events/perf_event.h          | 13 +++++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  5 +++++
 arch/x86/kernel/perf_regs.c           | 24 ++++++++++++++++++++----
 5 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ef0e238a4678..de07747e939e 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -735,6 +735,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_high16_zmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_Hi16_ZMM))
 				return -EINVAL;
+			if (event_needs_opmask(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_OPMASK))
+				return -EINVAL;
 		}
 	}
 
@@ -1782,6 +1785,7 @@ void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->ymmh_regs = NULL;
 	perf_regs->zmmh_regs = NULL;
 	perf_regs->h16zmm_regs = NULL;
+	perf_regs->opmask_regs = NULL;
 }
 
 static void update_perf_regs(struct x86_perf_regs *perf_regs,
@@ -1803,6 +1807,8 @@ static void update_perf_regs(struct x86_perf_regs *perf_regs,
 		perf_regs->zmmh = get_xsave_addr(xsave, XFEATURE_ZMM_Hi256);
 	if (mask & XFEATURE_MASK_Hi16_ZMM)
 		perf_regs->h16zmm = get_xsave_addr(xsave, XFEATURE_Hi16_ZMM);
+	if (mask & XFEATURE_MASK_OPMASK)
+		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 }
 
 /*
@@ -2000,6 +2006,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_ZMM_Hi256;
 	if (event_needs_high16_zmm(event))
 		mask |= XFEATURE_MASK_Hi16_ZMM;
+	if (event_needs_opmask(event))
+		mask |= XFEATURE_MASK_OPMASK;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.regs) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 01414b3a88fd..f15dc414c57a 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -209,6 +209,19 @@ static inline bool event_needs_high16_zmm(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_opmask(struct perf_event *event)
+{
+	if (!(event->attr.sample_type &
+	      (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)))
+		return false;
+
+	if (event->attr.sample_simd_regs_enabled &&
+	    event->attr.sample_simd_pred_reg_qwords == PERF_X86_OPMASK_QWORDS)
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 75394c4e8bc3..49112e097e99 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -745,6 +745,10 @@ struct x86_perf_regs {
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
index b88d0b6822fd..61aec60623f1 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -62,14 +62,19 @@ enum {
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
index b4a584057fe4..83e22f63cef4 100644
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
@@ -152,8 +158,18 @@ int perf_simd_reg_validate(u64 sample_type, u16 simd_enabled,
 			return -EINVAL;
 	}
 
-	if (pred_qwords || pred_mask_intr || pred_mask_user)
-		return -EINVAL;
+	if (pred_qwords) {
+		if (pred_qwords != PERF_X86_OPMASK_QWORDS)
+			return -EINVAL;
+		if (!pred_mask_intr && !pred_mask_user)
+			return -EINVAL;
+		if ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		    (pred_mask_intr & ~PERF_X86_SIMD_PRED_MASK))
+			return -EINVAL;
+		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		    (pred_mask_user & ~PERF_X86_SIMD_PRED_MASK))
+			return -EINVAL;
+	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		size = (vec_qwords * hweight64(vec_mask_intr) +
-- 
2.34.1

