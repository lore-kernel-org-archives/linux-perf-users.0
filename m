Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4829E0FD;
	Wed,  3 Dec 2025 06:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764745128; cv=none; b=eWeB/5/ZxeUT5E6J0G99xxgSUHjfy/tU7sQRGWS9fOPH7kuHWVnavrDaSvqmaDQAKuZm6d212/g5FVdFiWgP36FJzccqa2gKYjzTGYj+uDDB8F7FSXCe3Q6SEXCjsB4VO2PIfy7TmP1QqfL5DJJnuvgYeiJAGeC5Cc2OgGBj7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764745128; c=relaxed/simple;
	bh=yWFkDmGsO1F+usNu+ZQBoVZd63Fqq6a7CZENuW/Dyc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwIXn6ubGnwXAkDx8yFuuy7txVCbOsEtblDgOBHbsBouj/6dwM5n9SxPlNWLZCZDxpVqvVoz86AwkLWCMvhs+jKH+hSljNKaBTfJDPM7ZswVDUPE/2MMUqwqIcQj8SmLcJbnnlZh2xTh002PyxnXXV6ijJAfNFAwW107mK/EwZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oKrf6w5I; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oKrf6w5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764745127; x=1796281127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yWFkDmGsO1F+usNu+ZQBoVZd63Fqq6a7CZENuW/Dyc0=;
  b=oKrf6w5IfBxaH5oMVIOdV5TzcxbdNL6ylRTjEdtA20Xotj2gE+uJOwDe
   H1dlw4KQNgg4T0+q9gXgu3UnAUZjb503RLbBsglOMoTnaFHiDLRrFDHk5
   QROisb41urMdtodRj6lqDvNtAilIi8dLadQvN1Ke0g7Scadw0g5HEauoh
   rBq1bP5I15QONYJ8pU7NHLPnEwb1tBOqbOFo7PVjO/2ZEx9KNSULtSf5y
   +XngsLCdexUo9JTK0Fpff6yqhWeWGSYo+ZM2taMTyY+oDQdlOpc6jvNwI
   IcfCEV3R9npvsDbhm/kQqXqn6yKzfsePLJ2ntgucKHATPvbe3eV/lec7S
   Q==;
X-CSE-ConnectionGUID: AeeIlagZTv+ZbhKCAWyl/Q==
X-CSE-MsgGUID: I8ck9QmqQ8664FgLeezUhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="84324850"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="84324850"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2025 22:58:47 -0800
X-CSE-ConnectionGUID: 7UUljBYgQiqkj2iJIvfOHw==
X-CSE-MsgGUID: I8bRBN8MSt+lTXFohYovyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="199003899"
Received: from spr.sh.intel.com ([10.112.229.196])
  by fmviesa005.fm.intel.com with ESMTP; 02 Dec 2025 22:58:42 -0800
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
Subject: [Patch v5 09/19] perf/x86: Enable YMM sampling using sample_simd_vec_reg_* fields
Date: Wed,  3 Dec 2025 14:54:50 +0800
Message-Id: <20251203065500.2597594-10-dapeng1.mi@linux.intel.com>
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
 arch/x86/events/core.c                | 9 +++++++++
 arch/x86/events/perf_event.h          | 9 +++++++++
 arch/x86/include/asm/perf_event.h     | 4 ++++
 arch/x86/include/uapi/asm/perf_regs.h | 8 ++++++--
 arch/x86/kernel/perf_regs.c           | 8 +++++++-
 5 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 8f7e7e81daaf..b1e62c061d9e 100644
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
@@ -735,6 +738,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 			if (event_needs_xmm(event) &&
 			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_SSE))
 				return -EINVAL;
+			if (event_needs_ymm(event) &&
+			    !(x86_pmu.ext_regs_mask & XFEATURE_MASK_YMM))
+				return -EINVAL;
 		}
 	}
 
@@ -1814,6 +1820,7 @@ inline void x86_pmu_clear_perf_regs(struct pt_regs *regs)
 	struct x86_perf_regs *perf_regs = container_of(regs, struct x86_perf_regs, regs);
 
 	perf_regs->xmm_regs = NULL;
+	perf_regs->ymmh_regs = NULL;
 }
 
 static void x86_pmu_setup_basic_regs_data(struct perf_event *event,
@@ -1883,6 +1890,8 @@ static void x86_pmu_sample_ext_regs(struct perf_event *event,
 
 	if (event_needs_xmm(event))
 		mask |= XFEATURE_MASK_SSE;
+	if (event_needs_ymm(event))
+		mask |= XFEATURE_MASK_YMM;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e5d8ad024553..3d4577a1bb7d 100644
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
index 5d623805bf87..25f5ae60f72f 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -709,6 +709,10 @@ struct x86_perf_regs {
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
index 9947a6b5c260..8aa61a18fd71 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -95,6 +95,11 @@ u64 perf_simd_reg_value(struct pt_regs *regs, int idx,
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
@@ -111,7 +116,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
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

