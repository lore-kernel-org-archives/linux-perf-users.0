Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6D51D63F5;
	Mon,  6 Jan 2025 07:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736147494; cv=none; b=Io1veKR/px7bAF5wAfKAYTxPAvNf5+qrVo7CCPF+Gdaey+ZWiSMUi0zZSV0pObLLZ6c//Q7L1aPZfN4/Nkr/gFdBI3wy2qACvyuFy9BZUdqCWwK74bo0tFluXRQKPRDjzp7n6nFiEVeegoLu6m26bqtSQYaq1PVjxC5Q1l8MjYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736147494; c=relaxed/simple;
	bh=5lhneQP8cS1astWGORHzpojAcmqjPfSGXb0ZA8OVBQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O38dn+nGTVVnWuHfIvFi+LZenRYq9NxGj0SVoWtjvNqEV1jsRUMathYvDhvDaXX3zDKuRHAAne9c/koROQwXf9QkInyZqecN7laLiSFvLefyOgA2OTqJKzfJdSb09NGQqR3CMKbwafEbsVkdyQY6HIZ8zsKC6/HFX7MwIkJrD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=R7UE49X4; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="R7UE49X4"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 50677RpA3211026
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 5 Jan 2025 23:07:33 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 50677RpA3211026
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024121701; t=1736147253;
	bh=0IXB2jBiJPz8ByNPP/BjmChXzReQlc5twftE/TJErz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7UE49X4YgYaKL/LbQ0HGfD0MPs5QkbgqKyJqYt1TmttyFBFpxXuah40MW2/gOAi/
	 l9WQZZNt8czLuFxCmZn44j4Sau+W26WICUmWWLjzOYW5GD0Wa7jbfTvIok0hbNDfwa
	 DKSj9ahNwe608VJOPQILc//AmUQtbRp9U3WNEzh6uJrrcPT64cCXVyXVH65P1QLL2c
	 yqnUgTPm96QpAut/v6lZdzFMUIeuhUPmExHqJ1n1b+fQFvPFotAhKTrYxoZ9MAZg6F
	 UB6+w1Af9kkz2iqtx/3X2vrE9nhCVjPfs6wv5lhic6XWsqnMYsyOOhIs8/Kld8gBFy
	 gLTvQcf3nF3aQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v5 1/5] x86/cpufeatures: Add {required,disabled} feature configs
Date: Sun,  5 Jan 2025 23:07:23 -0800
Message-ID: <20250106070727.3211006-2-xin@zytor.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106070727.3211006-1-xin@zytor.com>
References: <20250106070727.3211006-1-xin@zytor.com>
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

Changes since v1:
* Keep the X86_{REQUIRED,DISABLED}_FEATURE_ prefixes solely in
  arch/x86/Kconfig.cpufeatures (Borislav Petkov).
* Explain how config option names X86_{REQUIRED,DISABLED}_FEATURE_<name>
  are formed (Borislav Petkov).
---
 arch/x86/Kconfig                              |   4 +-
 arch/x86/Kconfig.cpu                          |  12 +-
 arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
 arch/x86/include/asm/asm-prototypes.h         |   2 +-
 arch/x86/include/asm/atomic64_32.h            |   2 +-
 arch/x86/include/asm/bitops.h                 |   4 +-
 arch/x86/include/asm/cmpxchg_32.h             |   2 +-
 arch/x86/include/asm/required-features.h      |   4 +-
 arch/x86/lib/Makefile                         |   2 +-
 arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
 lib/atomic64_test.c                           |   2 +-
 .../arch/x86/include/asm/required-features.h  |   4 +-
 12 files changed, 213 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/Kconfig.cpufeatures

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e4e27d44dc2b..1c1f73202903 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -131,7 +131,7 @@ config X86
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_REQUIRED_FEATURE_CX8
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
@@ -3191,4 +3191,6 @@ config HAVE_ATOMIC_IOMAP
 
 source "arch/x86/kvm/Kconfig"
 
+source "arch/x86/Kconfig.cpufeatures"
+
 source "arch/x86/Kconfig.assembler"
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 2a7279d80460..c439f9c61101 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -366,21 +366,11 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
 
-config X86_CMPXCHG64
-	def_bool y
-	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
-
-# this should be set for all -march=.. options where the compiler
-# generates cmov.
-config X86_CMOV
-	def_bool y
-	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
-
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
index 000000000000..5ed24e45df87
--- /dev/null
+++ b/arch/x86/Kconfig.cpufeatures
@@ -0,0 +1,197 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# x86 feature bits (see arch/x86/include/asm/cpufeatures.h) that are
+# either REQUIRED to be enabled, or DISABLED (always ignored) for this
+# particular compile-time configuration.  The tests for these features
+# are turned into compile-time constants via the generated
+# <asm/featuremasks.h>.
+#
+# The naming of these variables *must* match asm/cpufeatures.h, e.g.,
+#     X86_FEATURE_ALWAYS <==> X86_REQUIRED_FEATURE_ALWAYS
+#     X86_FEATURE_FRED   <==> X86_DISABLED_FEATURE_FRED
+#
+# And these REQUIRED and DISABLED config options are manipulated in an
+# AWK script as the following example:
+#
+#                          +----------------------+
+#                          |    X86_FRED = y ?    |
+#                          +----------------------+
+#                              /             \
+#                           Y /               \ N
+#  +-------------------------------------+   +-------------------------------+
+#  | X86_DISABLED_FEATURE_FRED undefined |   | X86_DISABLED_FEATURE_FRED = y |
+#  +-------------------------------------+   +-------------------------------+
+#                                                        |
+#                                                        |
+#     +-------------------------------------------+      |
+#     | X86_FEATURE_FRED: feature word 12, bit 17 | ---->|
+#     +-------------------------------------------+      |
+#                                                        |
+#                                                        |
+#                                     +-------------------------------+
+#                                     | set bit 17 of DISABLED_MASK12 |
+#                                     +-------------------------------+
+#
+
+config X86_REQUIRED_FEATURE_ALWAYS
+	def_bool y
+
+config X86_REQUIRED_FEATURE_NOPL
+	def_bool y
+	depends on X86_64 || X86_P6_NOP
+
+config X86_REQUIRED_FEATURE_CX8
+	def_bool y
+	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7
+
+# this should be set for all -march=.. options where the compiler
+# generates cmov.
+config X86_REQUIRED_FEATURE_CMOV
+	def_bool y
+	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
+
+# this should be set for all -march= options where the compiler
+# generates movbe.
+config X86_REQUIRED_FEATURE_MOVBE
+	def_bool y
+	depends on MATOM
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
index 3674006e3974..66fe5009830e 100644
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
index 6c6e9b9f98a4..3dca0f13b59f 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,7 +48,7 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_REQUIRED_FEATURE_CX8
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
 		     : ALT_OUTPUT_SP(out) \
diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index b96d45944c59..ff6444311704 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -321,7 +321,7 @@ static __always_inline int variable_ffs(int x)
 	asm("bsfl %1,%0"
 	    : "=r" (r)
 	    : ASM_INPUT_RM (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsfl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "r" (-1));
@@ -378,7 +378,7 @@ static __always_inline int fls(unsigned int x)
 	asm("bsrl %1,%0"
 	    : "=r" (r)
 	    : ASM_INPUT_RM (x), "0" (-1));
-#elif defined(CONFIG_X86_CMOV)
+#elif defined(CONFIG_X86_REQUIRED_FEATURE_CMOV)
 	asm("bsrl %1,%0\n\t"
 	    "cmovzl %2,%0"
 	    : "=&r" (r) : "rm" (x), "rm" (-1));
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index fd1282a783dd..633ca915644a 100644
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
index 98583a9dbab3..9d4e96157e81 100644
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
index 759ea1783cc5..c85e8ab3f67d 100644
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
2.47.1

