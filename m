Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DF42BEFF6;
	Mon, 25 Aug 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756159149; cv=none; b=i02yChhPZ5DXV+PIpqvCiDqVp5tDCdfFe2BhMM6jZT2RHPv0z+uXUSMp9I644Qvr3/nj9qc5iSYs7aRTwPiSBZMDBzREZ1NiYLJAEhCW4E5zjO9dU/gPayrhgDwi5HSm0XmYh8mdz/WMYObZo8xyJEg/S3vqiXwXwlGMht4p/OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756159149; c=relaxed/simple;
	bh=pD+lPI0iZb5rQ98dmlP5O5UzeUNVYlKLD7BPo7tm2Ik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WhT+Rjn/AR8ydxJSlA6Me0MJM3AsmoTiM+NSmUGglxo98TiVFdh9+IUFGf/vAuOUZ/Aop8VliIs3Ghk4N+9nkYwhnAqJi+EaJcyn9l+clJecWEC1IFg1NKDIYvGrmsTotqLuORBA2CvJcDGW95NQMafEx61LagRWAj3112B7nDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLPLFSmq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLPLFSmq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8B5C113D0;
	Mon, 25 Aug 2025 21:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756159149;
	bh=pD+lPI0iZb5rQ98dmlP5O5UzeUNVYlKLD7BPo7tm2Ik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLPLFSmqbHuYMXGri+NddmypXct676+L+FNUmUl1/MRHDNyHQIK7Kj48B78Rc/NBL
	 wOBgEHS6nYVgIEl9Hw6OJCp+MC4M9VWIZEKqSuqaaXGTTBYah/U4fvCiTu63WYkQYH
	 fRe1ROyjsfeelBtMYAdA+KjN+hsBzU6kTBfICC33FuKugEm89SFZ7ixHJYOuyn+cME
	 DWQrfd/t3GIZTKUmRgDnFhndW1CmeY7G64rIpnmQN7DXPcmpU13F+7n61B8Afeq73u
	 qFBwQNMbDsvJs1+3fKx5s77ofL2k+PiZcAEiOvPKF3v5U9nJGgnyyLAbOhKzo/X+HT
	 evMuuB4xbGd2g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 04/11] tools headers: Sync x86 headers with the kernel source
Date: Mon, 25 Aug 2025 14:58:56 -0700
Message-ID: <20250825215904.2594216-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
In-Reply-To: <20250825215904.2594216-1-namhyung@kernel.org>
References: <20250825215904.2594216-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes in this cset:

  7b306dfa326f7011 x86/sev: Evict cache lines during SNP memory validation
  65f55a30176662ee x86/CPU/AMD: Add CPUID faulting support
  d8010d4ba43e9f79 x86/bugs: Add a Transient Scheduler Attacks mitigation
  a3c4f3396b82849a x86/msr-index: Add AMD workload classification MSRs
  17ec2f965344ee3f KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG if RTM is supported

This addresses these perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/cpufeatures.h arch/x86/include/asm/cpufeatures.h
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Please see tools/include/uapi/README for further details.

Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/cpufeatures.h | 10 +++++++++-
 tools/arch/x86/include/asm/msr-index.h   |  7 +++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index ee176236c2be9908..06fc0479a23f01e5 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -218,6 +218,7 @@
 #define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* "flexpriority" Intel FlexPriority */
 #define X86_FEATURE_EPT			( 8*32+ 2) /* "ept" Intel Extended Page Table */
 #define X86_FEATURE_VPID		( 8*32+ 3) /* "vpid" Intel Virtual Processor ID */
+#define X86_FEATURE_COHERENCY_SFW_NO	( 8*32+ 4) /* SNP cache coherency software work around not needed */
 
 #define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
 #define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
@@ -456,10 +457,14 @@
 #define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
 #define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
 #define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_VERW_CLEAR		(20*32+ 5) /* The memory form of VERW mitigates TSA */
 #define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
+
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
 
+#define X86_FEATURE_GP_ON_USER_CPUID	(20*32+17) /* User CPUID faulting */
+
 #define X86_FEATURE_PREFETCHI		(20*32+20) /* Prefetch Data/Instruction to Cache Level */
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
@@ -487,6 +492,9 @@
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_TSA_SQ_NO		(21*32+11) /* AMD CPU not vulnerable to TSA-SQ */
+#define X86_FEATURE_TSA_L1_NO		(21*32+12) /* AMD CPU not vulnerable to TSA-L1 */
+#define X86_FEATURE_CLEAR_CPU_BUF_VM	(21*32+13) /* Clear CPU buffers using VERW before VMRUN */
 
 /*
  * BUG word(s)
@@ -542,5 +550,5 @@
 #define X86_BUG_OLD_MICROCODE		X86_BUG( 1*32+ 6) /* "old_microcode" CPU has old microcode, it is surely vulnerable to something */
 #define X86_BUG_ITS			X86_BUG( 1*32+ 7) /* "its" CPU is affected by Indirect Target Selection */
 #define X86_BUG_ITS_NATIVE_ONLY		X86_BUG( 1*32+ 8) /* "its_native_only" CPU is affected by ITS, VMX is not affected */
-
+#define X86_BUG_TSA			X86_BUG( 1*32+ 9) /* "tsa" CPU is affected by Transient Scheduler Attacks */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 5cfb5d74dd5f58b3..b65c3ba5fa1410bb 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -419,6 +419,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
@@ -733,6 +734,11 @@
 #define MSR_AMD64_PERF_CNTR_GLOBAL_CTL		0xc0000301
 #define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR	0xc0000302
 
+/* AMD Hardware Feedback Support MSRs */
+#define MSR_AMD_WORKLOAD_CLASS_CONFIG		0xc0000500
+#define MSR_AMD_WORKLOAD_CLASS_ID		0xc0000501
+#define MSR_AMD_WORKLOAD_HRST			0xc0000502
+
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
@@ -831,6 +837,7 @@
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
 #define MSR_K7_HWCR_IRPERF_EN_BIT	30
 #define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
+#define MSR_K7_HWCR_CPUID_USER_DIS_BIT	35
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 #define MSR_K7_HWCR_CPB_DIS_BIT		25
-- 
2.51.0.261.g7ce5a0a67e-goog

