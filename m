Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0375192B90;
	Thu, 10 Apr 2025 00:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243892; cv=none; b=PTvfGLLONlETj7OUoWRBjFX2amOy60Zzhx/i64H1qIIn9KSF1p8bN0/FsDMRk6APBTRRNI9LSi4NE6n5uY9DxB2VVOXvZ5jAtDLB8bZzHMpHAzWlgGakf2JOQeixXCsA6Nc6IDOllqLYNAtvURjZDe/fCsZVTJrS/CUlUdfAORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243892; c=relaxed/simple;
	bh=hGfEZ5zzmZX1BJMLzXHaSYb5/okcl8lHhopN/b6c//A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JVEhoOguO8mQyLjnQ/6iHAJi7ovx7BwbE3+FkZgS1DhiSKfQe4rQsZNhmsGqtyFyfiM5d2KKs70Ufu1R5H93GRDjoaTEXH+8QoaTxS/TNsWnDUif+CrJsexFolEARhFCxIlp3pAmrlqPzZy+UKvn951e+QZI3ThgVRU4JlcQa0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhEDlz7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhEDlz7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16CBC4CEE2;
	Thu, 10 Apr 2025 00:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243892;
	bh=hGfEZ5zzmZX1BJMLzXHaSYb5/okcl8lHhopN/b6c//A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhEDlz7FAB5JIwhqexPqa+fZcOiC5+6LTHwya68LYlJzQSCJKEyLPqQvRTBn1Kpaf
	 LGLT9hZwaK1IU3MiBTuo8Yiq556/SWkT7b79PDzdLyQDcmv8uac9IkTTc4YUJy6WHF
	 Rvm8pSGnTBmqw37DuMmzpk0Fz2Gezp/eWkX7d0D0drBCv/fCtoKUTvhEQC6PAI4ThR
	 9TKtmQvX8q25qOZqqMCMzIaileQ/0vcHrcjPA2jmSOkabCSVvU9kmSG7BdhnXd9cRt
	 GbRm3dX5DiuHKIeDltuZqhRduuEirNSbXf/kXZepmH+YHqsMMYmk6XL41PREfBg3yZ
	 zjks92CesZmHA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 09/10] tools headers: Update the x86 headers with the kernel sources
Date: Wed,  9 Apr 2025 17:11:24 -0700
Message-ID: <20250410001125.391820-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
In-Reply-To: <20250410001125.391820-1-namhyung@kernel.org>
References: <20250410001125.391820-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in:

  841326332bcb13ae x86/cpufeatures: Generate the <asm/cpufeaturemasks.h> header based on build config
  440a65b7d25fb06f x86/mm: Enable AMD translation cache extensions
  767ae437a32d6447 x86/mm: Add INVLPGB feature and Kconfig entry
  b4cc466b97359011 cpufreq/amd-pstate: Replace all AMD_CPPC_* macros with masks
  98c7a713db91c5a9 x86/bugs: Add X86_BUG_SPECTRE_V2_USER
  8f64eee70cdd3bb8 x86/bugs: Remove X86_FEATURE_USE_IBPB
  8442df2b49ed9bcd x86/bugs: KVM: Add support for SRSO_MSR_FIX
  70792aed14551e31 x86/cpufeatures: Add CPUID feature bit for Idle HLT intercept
  968e9bc4cef87054 x86: move ZMM exclusion list into CPU feature flag
  c631a2de7ae48d50 perf/x86/intel: Ensure LBRs are disabled when a CPU is starting
  38cc6495cdec18a4 x86/sev: Prevent GUEST_TSC_FREQ MSR interception for Secure TSC enabled guests
  288bba2f4c8be1e1 x86/cpufeatures: Remove "AMD" from the comments to the AMD-specific leaf
  877818802c3e970f x86/bugs: Add SRSO_USER_KERNEL_NO support
  8ae3291f773befee x86/sev: Add full support for a segmented RMP table
  0cbc0258415814c8 x86/sev: Add support for the RMPREAD instruction
  7a470e826d7521be x86/cpufeatures: Free up unused feature bits

Addressing this perf tools build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/cpufeatures.h | 28 +++++++++++++++------
 tools/arch/x86/include/asm/msr-index.h   | 31 +++++++++++++++---------
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 9e3fa7942e7d3f24..6c2c152d8a67b9bf 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -75,8 +75,8 @@
 #define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
 #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
 #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
-#define X86_FEATURE_P3			( 3*32+ 6) /* P3 */
-#define X86_FEATURE_P4			( 3*32+ 7) /* P4 */
+/* Free                                 ( 3*32+ 6) */
+/* Free                                 ( 3*32+ 7) */
 #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
 #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
 #define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
@@ -329,6 +329,7 @@
 #define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
 #define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
 #define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_INVLPGB		(13*32+ 3) /* INVLPGB and TLBSYNC instructions supported */
 #define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
 #define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
 #define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
@@ -377,6 +378,7 @@
 #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
 #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
 #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
+#define X86_FEATURE_IDLE_HLT		(15*32+30) /* IDLE HLT intercept */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
 #define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/
@@ -434,15 +436,18 @@
 #define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* Speculative Store Bypass Disable */
 
 /* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
-#define X86_FEATURE_SME			(19*32+ 0) /* "sme" AMD Secure Memory Encryption */
-#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_SME			(19*32+ 0) /* "sme" Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" Secure Encrypted Virtualization */
 #define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is supported */
-#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" AMD Secure Encrypted Virtualization - Encrypted State */
-#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" AMD Secure Encrypted Virtualization - Secure Nested Paging */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" Secure Encrypted Virtualization - Secure Nested Paging */
 #define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
-#define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
-#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* hardware-enforced cache coherency */
+#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" SEV-ES full debug state swap support */
+#define X86_FEATURE_RMPREAD		(19*32+21) /* RMPREAD instruction */
+#define X86_FEATURE_SEGMENTED_RMP	(19*32+23) /* Segmented RMP support */
 #define X86_FEATURE_SVSM		(19*32+28) /* "svsm" SVSM present */
+#define X86_FEATURE_HV_INUSE_WR_ALLOWED	(19*32+30) /* Allow Write to in-use hypervisor-owned pages */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
@@ -455,6 +460,11 @@
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
+#define X86_FEATURE_SRSO_USER_KERNEL_NO	(20*32+30) /* CPU is not affected by SRSO across user/kernel boundaries */
+#define X86_FEATURE_SRSO_BP_SPEC_REDUCE	(20*32+31) /*
+						    * BP_CFG[BpSpecReduce] can be used to mitigate SRSO for VMs.
+						    * (SRSO_MSR_FIX in the official doc).
+						    */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
@@ -470,6 +480,7 @@
 #define X86_FEATURE_AMD_FAST_CPPC	(21*32 + 5) /* Fast CPPC */
 #define X86_FEATURE_AMD_HETEROGENEOUS_CORES (21*32 + 6) /* Heterogeneous Core Topology */
 #define X86_FEATURE_AMD_WORKLOAD_CLASS	(21*32 + 7) /* Workload Classification */
+#define X86_FEATURE_PREFER_YMM		(21*32 + 8) /* Avoid ZMM registers due to downclocking */
 
 /*
  * BUG word(s)
@@ -521,4 +532,5 @@
 #define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
 #define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #define X86_BUG_IBPB_NO_RET	   	X86_BUG(1*32 + 4) /* "ibpb_no_ret" IBPB omits return target predictions */
+#define X86_BUG_SPECTRE_V2_USER		X86_BUG(1*32 + 5) /* "spectre_v2_user" CPU is affected by Spectre variant 2 attack between user processes */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index dc1c1057f26e45a8..e6134ef2263d50d1 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -397,7 +397,8 @@
 #define MSR_IA32_PASID_VALID		BIT_ULL(31)
 
 /* DEBUGCTLMSR bits (others vary by model): */
-#define DEBUGCTLMSR_LBR			(1UL <<  0) /* last branch recording */
+#define DEBUGCTLMSR_LBR_BIT		0	     /* last branch recording */
+#define DEBUGCTLMSR_LBR			(1UL <<  DEBUGCTLMSR_LBR_BIT)
 #define DEBUGCTLMSR_BTF_SHIFT		1
 #define DEBUGCTLMSR_BTF			(1UL <<  1) /* single-step on branches */
 #define DEBUGCTLMSR_BUS_LOCK_DETECT	(1UL <<  2)
@@ -610,6 +611,7 @@
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
+#define MSR_AMD64_GUEST_TSC_FREQ	0xc0010134
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
 #define MSR_AMD_PPIN_CTL		0xc00102f0
@@ -646,6 +648,7 @@
 #define MSR_AMD64_IBS_REG_COUNT_MAX	8 /* includes MSR_AMD64_IBSBRTARGET */
 #define MSR_AMD64_SVM_AVIC_DOORBELL	0xc001011b
 #define MSR_AMD64_VM_PAGE_FLUSH		0xc001011e
+#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
 #define MSR_AMD64_SEV_ES_GHCB		0xc0010130
 #define MSR_AMD64_SEV			0xc0010131
 #define MSR_AMD64_SEV_ENABLED_BIT	0
@@ -684,11 +687,12 @@
 #define MSR_AMD64_SNP_SMT_PROT		BIT_ULL(MSR_AMD64_SNP_SMT_PROT_BIT)
 #define MSR_AMD64_SNP_RESV_BIT		18
 #define MSR_AMD64_SNP_RESERVED_MASK	GENMASK_ULL(63, MSR_AMD64_SNP_RESV_BIT)
-
-#define MSR_AMD64_VIRT_SPEC_CTRL	0xc001011f
-
 #define MSR_AMD64_RMP_BASE		0xc0010132
 #define MSR_AMD64_RMP_END		0xc0010133
+#define MSR_AMD64_RMP_CFG		0xc0010136
+#define MSR_AMD64_SEG_RMP_ENABLED_BIT	0
+#define MSR_AMD64_SEG_RMP_ENABLED	BIT_ULL(MSR_AMD64_SEG_RMP_ENABLED_BIT)
+#define MSR_AMD64_RMP_SEGMENT_SHIFT(x)	(((x) & GENMASK_ULL(13, 8)) >> 8)
 
 #define MSR_SVSM_CAA			0xc001f000
 
@@ -699,15 +703,17 @@
 #define MSR_AMD_CPPC_REQ		0xc00102b3
 #define MSR_AMD_CPPC_STATUS		0xc00102b4
 
-#define AMD_CPPC_LOWEST_PERF(x)		(((x) >> 0) & 0xff)
-#define AMD_CPPC_LOWNONLIN_PERF(x)	(((x) >> 8) & 0xff)
-#define AMD_CPPC_NOMINAL_PERF(x)	(((x) >> 16) & 0xff)
-#define AMD_CPPC_HIGHEST_PERF(x)	(((x) >> 24) & 0xff)
+/* Masks for use with MSR_AMD_CPPC_CAP1 */
+#define AMD_CPPC_LOWEST_PERF_MASK	GENMASK(7, 0)
+#define AMD_CPPC_LOWNONLIN_PERF_MASK	GENMASK(15, 8)
+#define AMD_CPPC_NOMINAL_PERF_MASK	GENMASK(23, 16)
+#define AMD_CPPC_HIGHEST_PERF_MASK	GENMASK(31, 24)
 
-#define AMD_CPPC_MAX_PERF(x)		(((x) & 0xff) << 0)
-#define AMD_CPPC_MIN_PERF(x)		(((x) & 0xff) << 8)
-#define AMD_CPPC_DES_PERF(x)		(((x) & 0xff) << 16)
-#define AMD_CPPC_ENERGY_PERF_PREF(x)	(((x) & 0xff) << 24)
+/* Masks for use with MSR_AMD_CPPC_REQ */
+#define AMD_CPPC_MAX_PERF_MASK		GENMASK(7, 0)
+#define AMD_CPPC_MIN_PERF_MASK		GENMASK(15, 8)
+#define AMD_CPPC_DES_PERF_MASK		GENMASK(23, 16)
+#define AMD_CPPC_EPP_PERF_MASK		GENMASK(31, 24)
 
 /* AMD Performance Counter Global Status and Control MSRs */
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS	0xc0000300
@@ -719,6 +725,7 @@
 
 /* Zen4 */
 #define MSR_ZEN4_BP_CFG                 0xc001102e
+#define MSR_ZEN4_BP_CFG_BP_SPEC_REDUCE_BIT 4
 #define MSR_ZEN4_BP_CFG_SHARED_BTB_FIX_BIT 5
 
 /* Fam 19h MSRs */
-- 
2.49.0.504.g3bcea36a83-goog

