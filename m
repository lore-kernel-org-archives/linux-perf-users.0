Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88582BDC17;
	Wed,  3 Dec 2025 06:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745154; cv=none; b=hkmKpAY79JLNgyjXKmIhugazQGBI9Mgsh+Ig3nzE6O6DKhGI3SgnqBb6W0XKAsChSCqFK4AqB59q3I9UisMIaBCibT+dre3Zv6wbrhglzAuFtTcHhAZSZtVCaNnKWtGmCbGJJb1XgiQJnMLootKbPLNfDqOSzJp58Op4l2f/FV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745154; c=relaxed/simple;
	bh=VjQIha2opesHaPJpF9OXfmPv2ooba3kDbd3TwPvcPuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aN3460JpbLki1kYaBWQT508ff0Z8pg1dat6BbgFk/rf5y+7Vwx+lkHV6gASYe6YRcTAQcdANhwDbSEJYeFkHkh/kquntmA3u3QWl94BtRziUGVee6VghWkX69hDiZbD/oPfF6M0R8wzbtkxsOrvcRQLVrekfXPeXtiknnkdMbB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJZ1uwZj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJZ1uwZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745149; x=1796281149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VjQIha2opesHaPJpF9OXfmPv2ooba3kDbd3TwPvcPuw=;
  b=eJZ1uwZjDxLEGagM9l9J842kL9KsLHLOmrC9KWtrl2xNFAHUdaliB3NA
   9TO/92FpCXmN+hoiVqx9MKJpzQQuLwRX6wxUp1Acq3V8BobV4SJT9CvQj
   MXgTePqcsGCN2fL/aaf4j5thrFlUqOokwk3gBJAruLutvL4MP1NdOhQGN
   Qx6kMF6Krpw50u5GhIAu+ipagH3THNX+16/X17ssTHgV6hzbKFOWS7b+i
   j9Qwl9Dbtkpg3q5mvr/M0kDTTcgywiBG+4mU9T9aH/pju1R62HfyYGK0b
   MTeQJDjeaYaMS3nFsue4Pn4w5PbdvIaF6ZaSrJ84/RX8ZCHn5fcgoIl76
   w==;
X-CSE-ConnectionGUID: kStG+wHAStqBuxqMg/buMg==
X-CSE-MsgGUID: eZuEmwy+T3WxRDE2WhWMbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324893"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:59:08 -0800
X-CSE-ConnectionGUID: QFQ+0iA6Q2yb5jlbD/+idQ==
X-CSE-MsgGUID: MP+cTNCZSU2JWqL/GSoN9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003998"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:59:03 -0800
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
Subject: [Patch v5 13/19] perf/x86: Enable SSP sampling using sample_regs_* fields
Date: Wed,  3 Dec 2025 14:54:54 +0800
Message-Id: <20251203065500.2597594-14-dapeng1.mi@linux.intel.com>
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

This patch enables sampling of CET SSP register via the sample_regs_*
fields.

To sample SSP, the sample_simd_regs_enabled field must be set. This
allows the spare space (reclaimed from the original XMM space) in the
sample_regs_* fields to be used for representing SSP.

Similar with eGPRs sampling, the perf_reg_value() function needs to
check if the PERF_SAMPLE_REGS_ABI_SIMD flag is set first, and then
determine whether to output SSP or legacy XMM registers to userspace.

Additionally, arch-PEBS supports sampling SSP, which is placed into the
GPRs group. This patch also enables arch-PEBS-based SSP sampling.

Currently, SSP sampling is only supported on the x86_64 architecture, as
CET is only available on x86_64 platforms.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                |  9 +++++++++
 arch/x86/events/intel/ds.c            |  3 +++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  7 ++++---
 arch/x86/kernel/perf_regs.c           |  5 +++++
 6 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ec0838469cae..b6030dae561d 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -434,6 +434,8 @@ static void x86_pmu_get_ext_regs(struct x86_perf_regs *perf_regs, u64 mask)
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (valid_mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (valid_mask & XFEATURE_MASK_CET_USER)
+		perf_regs->cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
 }
 
 static void release_ext_regs_buffers(void)
@@ -736,6 +738,10 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_egprs(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_APX))
 				return -EINVAL;
+			if (event_needs_ssp(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_CET_USER))
+				return -EINVAL;
+
 			/* Not require any vector registers but set width */
 			if (event->attr.sample_simd_vec_reg_qwords &&
 			    !event->attr.sample_simd_vec_reg_intr &&
@@ -1852,6 +1858,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
 	perf_regs->egpr_regs = NULL;
+	perf_regs->cet_regs = NULL;
 }
 
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
@@ -1931,6 +1938,8 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 		mask |= XFEATURE_MASK_OPMASK;
 	if (event_needs_egprs(event))
 		mask |= XFEATURE_MASK_APX;
+	if (event_needs_ssp(event))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 79cba323eeb1..3212259d1a16 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2409,12 +2409,15 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 	}
 
 	if (header->gpr) {
+		ignore_mask = XFEATURE_MASK_CET_USER;
+
 		gprs = next_record;
 		next_record = gprs + 1;
 
 		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
+		perf_regs->cet_regs = &gprs->r15;
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9fb1cbbc1b76..35a1837d0b77 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -193,6 +193,16 @@ static inline bool event_needs_egprs(struct perf_event *event)
 	return false;
 }
 
+static inline bool event_needs_ssp(struct perf_event *event)
+{
+	if (event->attr.sample_simd_regs_enabled &&
+	    (event->attr.sample_regs_user & BIT_ULL(PERF_REG_X86_SSP) ||
+	     event->attr.sample_regs_intr & BIT_ULL(PERF_REG_X86_SSP)))
+		return true;
+
+	return false;
+}
+
 struct amd_nb {
 	int nb_id;  /* NorthBridge id */
 	int refcnt; /* reference count */
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index ca242db3720f..c925af4160ad 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -729,6 +729,10 @@ struct x86_perf_regs {
 		u64	*egpr_regs;
 		struct apx_state *egpr;
 	};
+	union {
+		u64	*cet_regs;
+		struct cet_user_state *cet;
+	};
 };
 
 extern unsigned long perf_arch_instruction_pointer(struct pt_regs *regs);
diff --git a/arch/x86/include/uapi/asm/perf_regs.h b/arch/x86/include/uapi/asm/perf_regs.h
index f145e3b78426..f3561ed10041 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,9 +28,9 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
 	/*
-	 * The EGPRs and XMM have overlaps. Only one can be used
+	 * The EGPRs/SSP and XMM have overlaps. Only one can be used
 	 * at a time. For the ABI type PERF_SAMPLE_REGS_ABI_SIMD,
-	 * utilize EGPRs. For the other ABI type, XMM is used.
+	 * utilize EGPRs/SSP. For the other ABI type, XMM is used.
 	 *
 	 * Extended GPRs (EGPRs)
 	 */
@@ -50,10 +50,11 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R29,
 	PERF_REG_X86_R30,
 	PERF_REG_X86_R31,
+	PERF_REG_X86_SSP,
 	/* These are the limits for the GPRs. */
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R15 + 1,
-	PERF_REG_MISC_MAX = PERF_REG_X86_R31 + 1,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
 
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index e76de39e1385..518bbe577ee8 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -70,6 +70,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 					return 0;
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
+			if (idx == PERF_REG_X86_SSP) {
+				if (!perf_regs->cet)
+					return 0;
+				return perf_regs->cet->user_ssp;
+			}
 		} else {
 			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 				if (!perf_regs->xmm_regs)
-- 
2.34.1

