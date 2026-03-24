Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6748F369219;
	Tue, 24 Mar 2026 00:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774313247; cv=none; b=NRN1Zi/2CNHhan1sYxvaqjcdjXa4EEJSXh2MAWs6BkGA64asDoE6IBGo87CVZNncOnW5S/ER30HWYGU6fEdv5AYS6E2Ggum3BIfgkFC24PDRPkt4vBZ9A1FtVwGs74ERYCIF5DiThZuXcBtPlyXoiXtJAesDdigHzmpIxPrlalo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774313247; c=relaxed/simple;
	bh=QtLR/fz9qPFZ4UPHdPr2QzXqegSCHOhG8wWpER1udAw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hi1NVon+Df7AOCqt/q3zjMCf8sz8h/f1ju7yO4dxS2/VxLd40QxiSh8iPxbKzUlDXN31+XbLw72duv1TNghSuDyVd4/x0SPK1hLjYexIWmYh08utwkdt/lzLYfwTZEn3RH0JNkcNFdVcbIIph0oeFWaqjnUjDALGDTCgzD2a/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X6FlARsT; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X6FlARsT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774313246; x=1805849246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QtLR/fz9qPFZ4UPHdPr2QzXqegSCHOhG8wWpER1udAw=;
  b=X6FlARsTim5wLDz7Ri8RvWJeMpA7sFoJ1OareIBC2JljRNWUIMNlDzYP
   Qby4frEk5A0Uh0dTCOEjA3Rdch0C9Gwtpsfwaci2fd+2lyskPVP3deTUm
   XOIcT+Yck5a1gQ6ecWMkUF+25aMIlwKnDhxD4/C989Vjo6H/5N89KpEWo
   vPx6MREiYUsy3+z+ezbAhZE2JEEp8wWWlFJXVdoRsiWh6kQKNYPdlmBqG
   gwutax1riW9tyE3mxDr2J9rPEB3VnjxweqB7rHt9vfsrEYBFntcWJgmew
   Q8cLc+LWMnriszgJOlJL1dkX5HNQUHw+9Bs4zsGa7ORiuXNoETENA/G4r
   Q==;
X-CSE-ConnectionGUID: 5AwNhy5NRZa3NYGrsUAKxg==
X-CSE-MsgGUID: jFZN4He4TLGlYRarHsAgqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11738"; a="86397268"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86397268"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 17:47:26 -0700
X-CSE-ConnectionGUID: R4P5CQXcQTa9qGbHWDAvjg==
X-CSE-MsgGUID: IQvaBVMUQ92SWI2JsnHBXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="221322970"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa008.fm.intel.com with ESMTP; 23 Mar 2026 17:47:21 -0700
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
Subject: [Patch v7 20/24] perf/x86: Enable SSP sampling using sample_regs_* fields
Date: Tue, 24 Mar 2026 08:41:14 +0800
Message-Id: <20260324004118.3772171-21-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/intel/ds.c            |  8 ++++++++
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  7 ++++---
 arch/x86/kernel/perf_regs.c           |  5 +++++
 6 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index d33cfbe38573..ea451b48b9d6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -712,6 +712,10 @@ int x86_pmu_hw_config(struct perf_event *event)
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
@@ -1871,6 +1875,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	perf_regs->h16zmm_regs = NULL;
 	perf_regs->opmask_regs = NULL;
 	perf_regs->egpr_regs = NULL;
+	perf_regs->cet_regs = NULL;
 }
 
 static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
@@ -1896,6 +1901,8 @@ static inline void x86_pmu_update_xregs(struct x86_perf_regs *perf_regs,
 		perf_regs->opmask = get_xsave_addr(xsave, XFEATURE_OPMASK);
 	if (mask & XFEATURE_MASK_APX)
 		perf_regs->egpr = get_xsave_addr(xsave, XFEATURE_APX);
+	if (mask & XFEATURE_MASK_CET_USER)
+		perf_regs->cet = get_xsave_addr(xsave, XFEATURE_CET_USER);
 }
 
 /*
@@ -1961,6 +1968,8 @@ static void x86_pmu_sample_xregs(struct perf_event *event,
 		mask |= XFEATURE_MASK_OPMASK;
 	if (event_needs_egprs(event))
 		mask |= XFEATURE_MASK_APX;
+	if (event_needs_ssp(event))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	mask &= x86_pmu.ext_regs_mask;
 	if ((sample_type & PERF_SAMPLE_REGS_USER) && data->regs_user.abi)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ac9a1c2f0177..3a2fb623e0ab 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2685,6 +2685,14 @@ static void setup_arch_pebs_sample_data(struct perf_event *event,
 		__setup_pebs_gpr_group(event, data, regs,
 				       (struct pebs_gprs *)gprs,
 				       sample_type);
+
+		/* Currently only user space mode enables SSP. */
+		if (user_mode(regs) && (sample_type &
+		    (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))) {
+			/* Point to r15 so that cet_regs[1] = ssp. */
+			perf_regs->cet_regs = &gprs->r15;
+			ignore_mask = XFEATURE_MASK_CET_USER;
+		}
 	}
 
 	if (header->aux) {
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0974fd8b0e20..36688d28407f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -197,6 +197,16 @@ static inline bool event_needs_egprs(struct perf_event *event)
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
index a54ea8fa6a04..0c6d58e6c98f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -751,6 +751,10 @@ struct x86_perf_regs {
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
index e721a47556d4..98a5b6c8e24c 100644
--- a/arch/x86/include/uapi/asm/perf_regs.h
+++ b/arch/x86/include/uapi/asm/perf_regs.h
@@ -28,10 +28,10 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_R14,
 	PERF_REG_X86_R15,
 	/*
-	 * The eGPRs and XMM have overlaps. Only one can be used
+	 * The eGPRs/SSP and XMM have overlaps. Only one can be used
 	 * at a time. The ABI PERF_SAMPLE_REGS_ABI_SIMD is used to
 	 * distinguish which one is used. If PERF_SAMPLE_REGS_ABI_SIMD
-	 * is set, then eGPRs is used, otherwise, XMM is used.
+	 * is set, then eGPRs/SSP is used, otherwise, XMM is used.
 	 *
 	 * Extended GPRs (eGPRs)
 	 */
@@ -51,10 +51,11 @@ enum perf_event_x86_regs {
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
index a34cc52dbbeb..9715d1f90313 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -70,6 +70,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 					return 0;
 				return perf_regs->egpr_regs[idx - PERF_REG_X86_R16];
 			}
+			if (idx == PERF_REG_X86_SSP) {
+				if (!perf_regs->cet_regs)
+					return 0;
+				return perf_regs->cet_regs[1];
+			}
 		} else {
 			if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
 				if (!perf_regs->xmm_regs)
-- 
2.34.1

