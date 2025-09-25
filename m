Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5992EAB98;
	Thu, 25 Sep 2025 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758780917; cv=none; b=BUJH9q0o2ATp9XmBQirwLP1hW44fH8+mwe0rmYHrJxePHc8iXKtujZ+jOwXcdPejEQ1jWxqU/t9LlfyLdU9kqeujDRiBRiJheQzQHF2ir+UfG+VrcDye0SMp9Flz17o+CXNeJtfL2xD+6D3YWOWo2MsmOjlu4p8p+y+AGHauKxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758780917; c=relaxed/simple;
	bh=+52y98fi8l1olYVy8Vrdlk/GcgEgYRfWth9llSZqgtc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lJORmvsfuYDT1JUKvEGhYgYhNLpKH1Z2V2kj6LzA7uyL6K+VsGBAHVCwvCbtkjnOvU4R3TVeZfkkxyfctSMX0e1tm/gVM6hXQzObQcbZNIYH8zVzL4v6GeZC7M9uknZH2lZJGnx9q2kavFW8XVgHnooZ5Ye3pPXtbcVNdVXQwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=efU9m9D6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efU9m9D6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758780915; x=1790316915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+52y98fi8l1olYVy8Vrdlk/GcgEgYRfWth9llSZqgtc=;
  b=efU9m9D6QrSZUGe9PF776GblcxEJn2iKKEGQ7DwBdM9bGp7lLUY5CLMt
   PHNVRu5WXc91Rr+aAK5G2EMPPPfmC+mB0Zfi8pvuNHniexfhvvpKpLvZj
   N13C1ZjsI0yZ8eSGJ3dEM9yYnOl2z0mupy+CIHRGYFxF+1584nTgLiB98
   AIyTYtuRcQeBHOy1CQYKjw8fqxvul0+kpIvXyMHOcku+2opLiRzu272Us
   2mGIPU1Tf/ItYyctvYR0Y4E+IrBKagFVA6cyoA4o24nnxEGAjo9slyJel
   paoVHEmTC+md0CwccCAqQNAVmf/g+emr/icp30rPd3UkpMuKB4fUYgOnY
   w==;
X-CSE-ConnectionGUID: IJk16da3RjeBqSQ9IWk9Ew==
X-CSE-MsgGUID: fNUJoXBhQ0WkKP5pNqVoZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11563"; a="61139606"
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="61139606"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2025 23:15:15 -0700
X-CSE-ConnectionGUID: RTKrTcYUQKK0h6qGOmf+PQ==
X-CSE-MsgGUID: zIU8ii0+TcG9Finj1v0org==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,292,1751266800"; 
   d="scan'208";a="181528526"
Received: from spr.sh.intel.com ([10.112.230.239])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2025 23:15:09 -0700
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
Subject: [Patch v4 12/17] perf/x86: Add SSP into sample_regs
Date: Thu, 25 Sep 2025 14:12:08 +0800
Message-Id: <20250925061213.178796-13-dapeng1.mi@linux.intel.com>
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

The SSP is only supported when the new SIMD registers configuration
method is used, which moves the XMM to sample_simd_vec_regs. So the
space can be reclaimed for the SSP.

The SSP is retrieved by XSAVE. Only support the SSP for X86_64.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
 arch/x86/events/core.c                | 11 ++++++++++-
 arch/x86/events/perf_event.h          | 10 ++++++++++
 arch/x86/include/asm/perf_event.h     |  4 ++++
 arch/x86/include/uapi/asm/perf_regs.h |  7 +++++--
 arch/x86/kernel/perf_regs.c           |  8 +++++++-
 5 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a435610f4d4a..7c29c9029379 100644
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
@@ -712,7 +714,7 @@ int x86_pmu_hw_config(struct perf_event *event)
 
 	if (event->attr.sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)) {
 		if (event_has_simd_regs(event)) {
-			u64 reserved = ~GENMASK_ULL(PERF_REG_X86_64_MAX - 1, 0);
+			u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
 
 			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
 				return -EINVAL;
@@ -726,6 +728,10 @@ int x86_pmu_hw_config(struct perf_event *event)
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
@@ -1923,6 +1929,9 @@ static void x86_pmu_setup_extended_regs_data(struct perf_event *event,
 	perf_regs->egpr_regs = NULL;
 	if (event_needs_egprs(event))
 		mask |= XFEATURE_MASK_APX;
+	perf_regs->cet_regs = NULL;
+	if (event_needs_ssp(event))
+		mask |= XFEATURE_MASK_CET_USER;
 
 	mask &= ~ignore_mask;
 	if (mask)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3dd0e669ddd4..6ff4aa23833f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -192,6 +192,16 @@ static inline bool event_needs_egprs(struct perf_event *event)
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
index 73c2064c13f9..9d10299355c5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -621,6 +621,10 @@ struct x86_perf_regs {
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
index 38644de89815..0cf0490c47b2 100644
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
@@ -54,6 +54,9 @@ enum perf_event_x86_regs {
 	PERF_REG_X86_32_MAX = PERF_REG_X86_GS + 1,
 	PERF_REG_X86_64_MAX = PERF_REG_X86_R31 + 1,
 
+	PERF_REG_X86_SSP,
+	PERF_REG_MISC_MAX = PERF_REG_X86_SSP + 1,
+
 	/* These all need two bits set because they are 128bit */
 	PERF_REG_X86_XMM0  = 32,
 	PERF_REG_X86_XMM1  = 34,
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index b98b47a79d02..4d519867a3ef 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -101,6 +101,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
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
@@ -191,7 +196,8 @@ int perf_simd_reg_validate(u16 vec_qwords, u64 vec_mask,
 				 ~((1ULL << PERF_REG_X86_MAX) - 1))
 
 #ifdef CONFIG_X86_32
-#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8)
+#define REG_NOSUPPORT (GENMASK_ULL(PERF_REG_X86_R31, PERF_REG_X86_R8) | \
+		       BIT_ULL(PERF_REG_X86_SSP))
 
 int perf_reg_validate(u64 mask)
 {
-- 
2.34.1

