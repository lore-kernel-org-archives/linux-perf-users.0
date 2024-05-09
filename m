Received: from terminus.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500385273;
	Thu,  9 May 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715289482; cv=none; b=IH2igFGkV2gFOvJUiEOE2s5D9MK20UDOmmeScpM7hFPXZEZVfzrim8bveDlGvA0LZnhTajiOrTmqTV0kHmMKacmpl8h27acTHSCLnPlsZdOnP3cdqQ7dZmgPAHYTLtGFniTUJVq8MmfixujSUNibCm5sA1bd4GX/M09GajKfibM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715289482; c=relaxed/simple;
	bh=qLww9nsDByPGTX0tYdtuIPFTF9/lqtzyOEapQJaOvDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjG0z61RHgQlNr8Bwivo9iWfAwVZHVlxEyWFkleKBaDqlLqhTo3aTZLE/qExOvfJyBFTnsqE+/r+EUsOIoPMkfxCwWi9CcwNgfsJw0KFXa49PcSZZykJRfqSoWx6gHvUXa/3QT72KeLcVuO1mJO9NQhSpzrc4XOzVveIs4xSyAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CpnQV6kK; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CpnQV6kK"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 449KrevS275586
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 9 May 2024 13:53:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 449KrevS275586
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1715288026;
	bh=FJhLdB7aUywcyyYtR8k7AyzB7Qd/+pPMTyt+YgUCHhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CpnQV6kK3lTSOaAseqH/Nz7em6RRiswf1Z99UoU/aHsJ+PkuGcqEPfst0BEtxI0KK
	 9r7MfXfltphvGQMU5tJGuhFdUrdOZSOTsawaovlvNp28SaBMvH2IClQ/jXee6jOO/C
	 fe9H4KpNZFfvWA4+fjAG3XrNRszTDN+Bz4c+f/NllcRFE2c0aTmAyh1KeN67RBe2Fl
	 Nh0cB3AeYdEMB0onCf3BC/3cV00VkWDmiKFY7BdbYd68c/h4ExGZKllMwyZL5E2sh5
	 6PsqEW+Xg4G7PRcN4M+8hCrjjpiYKilQk4RsHgzAR9mbXtD3ylAtlnAlrvjxhk9hI+
	 Idai2CR7j2suA==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        acme@kernel.org, namhyung@kernel.org
Subject: [RESEND v1 1/3] x86/cpufeatures: Add {required,disabled} feature configs
Date: Thu,  9 May 2024 13:53:38 -0700
Message-ID: <20240509205340.275568-2-xin@zytor.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240509205340.275568-1-xin@zytor.com>
References: <20240509205340.275568-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Required and disabled feature masks completely rely on build configs,
i.e., once a build config is fixed, so are the feature masks. To prepare
for auto-generating a header with required and disabled feature masks
based on a build config, add feature Kconfig items:
  - X86_REQUIRED_FEATURE_x
  - X86_DISABLED_FEATURE_x
each of which may be set to "y" if and only if its preconditions from
current build config are met.

X86_CMPXCHG64 and X86_CMOV are required features, thus rename them to
X86_REQUIRED_FEATURE_CX8 and X86_REQUIRED_FEATURE_CMOV.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---
 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  16 +-
 arch/x86/Kconfig.cpufeatures                  | 153 ++++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   2 +-
 arch/x86/include/asm/required-features.h      |   4 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 lib/atomic64_test.c                           |   2 +-
 .../arch/x86/include/asm/required-features.h  |   4 +-
 12 files changed, 181 insertions(+), 16 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9d16fee6bdb8..9bbbc9224578 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -121,7 +121,7 @@ config X86
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_REQUIRED_FEATURE_CX8
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -3081,4 +3081,6 @@ config HAVE_ATOMIC_IOMAP
 
 source "arch/x86/kvm/Kconfig"
 
+source "arch/x86/Kconfig.cpufeatures"
+
 source "arch/x86/Kconfig.assembler"
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..719302d37053 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -358,6 +358,10 @@ config X86_P6_NOP
 	depends on X86_64
 	depends on (MCORE2 || MPENTIUM4 || MPSC)
 
+config X86_REQUIRED_FEATURE_NOPL
+	def_bool y
+	depends on X86_64 || X86_P6_NOP
+
 config X86_TSC
 	def_bool y
 	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
@@ -366,21 +370,27 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
 
-config X86_CMPXCHG64
+config X86_REQUIRED_FEATURE_CX8
 	def_bool y
 	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
 
 # this should be set for all -march=.. options where the compiler
 # generates cmov.
-config X86_CMOV
+config X86_REQUIRED_FEATURE_CMOV
 	def_bool y
 	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
 
+# this should be set for all -march= options where the compiler
+# generates movbe.
+config X86_REQUIRED_FEATURE_MOVBE
+	def_bool y
+	depends on MATOM
+
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
 	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
-	default "5" if X86_32 && X86_CMPXCHG64
+	default "5" if X86_32 && X86_REQUIRED_FEATURE_CX8
 	default "4"
 
 config X86_DEBUGCTLMSR
diff --git a/arch/x86/Kconfig.cpufeatures b/arch/x86/Kconfig.cpufeatures
new file mode 100644
index 000000000000..326a8410ff06
--- /dev/null
+++ b/arch/x86/Kconfig.cpufeatures
@@ -0,0 +1,153 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
+# particular compile-time configuration.  The tests for these features
+# are turned into compile-time constants via the generated
+# <asm/featuremasks.h>.
+#
+# The naming of these variables *must* match asm/cpufeatures.h.
+#
+
+config X86_REQUIRED_FEATURE_ALWAYS
+	def_bool y
+
+config X86_REQUIRED_FEATURE_CPUID
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_UP
+	def_bool y
+	depends on !SMP
+
+config X86_REQUIRED_FEATURE_FPU
+	def_bool y
+	depends on !MATH_EMULATION
+
+config X86_REQUIRED_FEATURE_PAE
+	def_bool y
+	depends on X86_64 || X86_PAE
+
+config X86_REQUIRED_FEATURE_PSE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_PGE
+	def_bool y
+	depends on X86_64 && !PARAVIRT_XXL
+
+config X86_REQUIRED_FEATURE_MSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_FXSR
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_XMM2
+	def_bool y
+	depends on X86_64
+
+config X86_REQUIRED_FEATURE_LM
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_UMIP
+	def_bool y
+	depends on !X86_UMIP
+
+config X86_DISABLED_FEATURE_VME
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_K6_MTRR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CYRIX_ARR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_CENTAUR_MCR
+	def_bool y
+	depends on X86_64
+
+config X86_DISABLED_FEATURE_PCID
+	def_bool y
+	depends on !X86_64
+
+config X86_DISABLED_FEATURE_PKU
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_OSPKE
+	def_bool y
+	depends on !X86_INTEL_MEMORY_PROTECTION_KEYS
+
+config X86_DISABLED_FEATURE_LA57
+	def_bool y
+	depends on !X86_5LEVEL
+
+config X86_DISABLED_FEATURE_PTI
+	def_bool y
+	depends on !MITIGATION_PAGE_TABLE_ISOLATION
+
+config X86_DISABLED_FEATURE_RETPOLINE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETPOLINE_LFENCE
+	def_bool y
+	depends on !MITIGATION_RETPOLINE
+
+config X86_DISABLED_FEATURE_RETHUNK
+	def_bool y
+	depends on !MITIGATION_RETHUNK
+
+config X86_DISABLED_FEATURE_UNRET
+	def_bool y
+	depends on !MITIGATION_UNRET_ENTRY
+
+config X86_DISABLED_FEATURE_CALL_DEPTH
+	def_bool y
+	depends on !MITIGATION_CALL_DEPTH_TRACKING
+
+config X86_DISABLED_FEATURE_LAM
+	def_bool y
+	depends on !ADDRESS_MASKING
+
+config X86_DISABLED_FEATURE_ENQCMD
+	def_bool y
+	depends on !INTEL_IOMMU_SVM
+
+config X86_DISABLED_FEATURE_SGX
+	def_bool y
+	depends on !X86_SGX
+
+config X86_DISABLED_FEATURE_XENPV
+	def_bool y
+	depends on !XEN_PV
+
+config X86_DISABLED_FEATURE_TDX_GUEST
+	def_bool y
+	depends on !INTEL_TDX_GUEST
+
+config X86_DISABLED_FEATURE_USER_SHSTK
+	def_bool y
+	depends on !X86_USER_SHADOW_STACK
+
+config X86_DISABLED_FEATURE_IBT
+	def_bool y
+	depends on !X86_KERNEL_IBT
+
+config X86_DISABLED_FEATURE_FRED
+	def_bool y
+	depends on !X86_FRED
+
+config X86_DISABLED_FEATURE_SEV_SNP
+	def_bool y
+	depends on !KVM_AMD_SEV
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 25466c4d2134..7fbb52143b13 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -16,7 +16,7 @@
 #include <asm/gsseg.h>
 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 extern void cmpxchg8b_emu(void);
 #endif
 
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 8db2ec4d6cda..f3438f8709bb 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,7 +48,7 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
 		     : out : [func] "i" (atomic64_##g##_cx8), ## in)
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index 990eb686ca67..e3e69dca8edb 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -321,7 +321,7 @@ static __always_inline int variable_ffs(int x)
 	asm("bsfl %1,%0"
 	    : "=r" (r)
 	    : "rm" (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsfl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "r" (-1));
@@ -378,7 +378,7 @@ static __always_inline int fls(unsigned int x)
 	asm("bsrl %1,%0"
 	    : "=r" (r)
 	    : "rm" (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsrl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "rm" (-1));
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index ed2797f132ce..2d875a8dbbb2 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -69,7 +69,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	return __arch_try_cmpxchg64(ptr, oldp, new,);
 }
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 
 #define arch_cmpxchg64 __cmpxchg64
 
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index e9187ddd3d1f..cef8104c103c 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -23,13 +23,13 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
 #endif
 
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
 # define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
 #else
 # define NEED_CMOV	0
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index 6da73513f026..6bf720cabef5 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -49,7 +49,7 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += string_32.o
         lib-y += memmove_32.o
         lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CMPXCHG64),y)
+ifneq ($(CONFIG_X86_REQUIRED_FEATURE_CX8),y)
         lib-y += atomic64_386_32.o
 endif
 else
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 1c96be769adc..4bc06bd1aee1 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -7,7 +7,7 @@
 
 .text
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_REQUIRED_FEATURE_CX8
 
 /*
  * Emulate 'cmpxchg8b (%esi)' on UP
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index d9d170238165..e68bde45b962 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -254,7 +254,7 @@ static __init int test_atomics_init(void)
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CMPXCHG64)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CX8)
 		"i586+",
 #else
 		"i386+",
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index e9187ddd3d1f..cef8104c103c 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -23,13 +23,13 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
 #endif
 
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_REQUIRED_FEATURE_CMOV) || defined(CONFIG_X86_64)
 # define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
 #else
 # define NEED_CMOV	0
-- 
2.45.0

