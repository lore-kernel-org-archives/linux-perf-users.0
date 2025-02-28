Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAE02475F7;
	Fri, 28 Feb 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740731071; cv=none; b=LsAmshfQQcZAMEnfVx9jn87P4tpL7sRWjBsWVqc//nHQbjYQKMfzOLa30A08QGPXABEbpKiaYImScSAT8+NfTsZEqEjxdqWqg/hFV7YjJ8mjkMEb2y6DJCRZZ3cnauMc2/bR77wbutkCcF2KThYgTRCijf3hAychSOu1lR4ql38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740731071; c=relaxed/simple;
	bh=4zIHaCMZS0hDa4OtHqr9qgMpS7AF52W84a6XPqM1u7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I6AnKzEF27E95Ak0yTFXxZILTSRDO+cWzWDGB3LuLKjioz8QCGHU7zb037IHIdHWd5UfIbgdiTNA2UI4MpLn8sK9UvgX+Az9vT+aKc6MlEovio8RhpZHa6F3I1YjtR3Hc2XNyM1W7lGgKCRfJUzet87oubD+GmezVcT4zOIDSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Hl8oK6dU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Hl8oK6dU"
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2607:7c80:54:3:0:0:0:136])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 51S8NdZW073880
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 28 Feb 2025 00:23:45 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 51S8NdZW073880
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025021701; t=1740731026;
	bh=ycQixJeuBOEDa8QWxTSMTADnqo3HaIk9wTod1ikqI0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hl8oK6dUoF5ZhTOEckvsPfLSRfBwM2ScuFFySPAEXNTyBXVWX32T1wGOcqce0m3ou
	 Zym7QcXHviIcfjgSkauVF49bml99mMSSP57aLhxEVM8RJSX7loJVclQQIruRp0ggHe
	 1n5S5wxZg4f4pjFxpgJ80q84+fhs/5vzFyQBa68XLGc/xuYCuR3cfJwAyVZpS1c9hp
	 iP43pEHVRC2j/r8n70z9T+2nGCjZds7RYn11hKBfYrhy4MbB5dMguyzh5yfHoHnMXJ
	 2estFv6z3KyTJHtEsIKbfCqSGoqbpqX/0dhmGC0+5NDfN558qdGSA9H4UwEaSHBQma
	 hTHq8wTYzCsDQ==
From: "Xin Li (Intel)" <xin@zytor.com>
To: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        will@kernel.org, peterz@infradead.org, yury.norov@gmail.com,
        akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
        brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: [PATCH v6 1/5] x86/cpufeatures: Rename X86_CMPXCHG64 to X86_CX8
Date: Fri, 28 Feb 2025 00:23:34 -0800
Message-ID: <20250228082338.73859-2-xin@zytor.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228082338.73859-1-xin@zytor.com>
References: <20250228082338.73859-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

Replace X86_CMPXCHG64 with X86_CX8, as CX8 is the name of the CPUID
flag, thus to make it consistent with X86_FEATURE_CX8 defined in
<asm/cpufeatures.h>.

No functional change intended.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Xin Li (Intel) <xin@zytor.com>
---

Change in v6:
* Rename X86_CMPXCHG64 in a separate patch (Borislav Petkov).
---
 arch/x86/Kconfig                               | 2 +-
 arch/x86/Kconfig.cpu                           | 4 ++--
 arch/x86/include/asm/asm-prototypes.h          | 2 +-
 arch/x86/include/asm/atomic64_32.h             | 2 +-
 arch/x86/include/asm/cmpxchg_32.h              | 2 +-
 arch/x86/include/asm/required-features.h       | 2 +-
 arch/x86/lib/Makefile                          | 2 +-
 arch/x86/lib/cmpxchg8b_emu.S                   | 2 +-
 lib/atomic64_test.c                            | 2 +-
 tools/arch/x86/include/asm/required-features.h | 2 +-
 10 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 60c2a16c7801..1e50da06ffc4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -133,7 +133,7 @@ config X86
 	select ARCH_SUPPORTS_AUTOFDO_CLANG
 	select ARCH_SUPPORTS_PROPELLER_CLANG    if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
-	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CMPXCHG64
+	select ARCH_USE_CMPXCHG_LOCKREF		if X86_CX8
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 8fcb8ccee44b..f8b3296fe2e1 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -299,7 +299,7 @@ config X86_HAVE_PAE
 	def_bool y
 	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
-config X86_CMPXCHG64
+config X86_CX8
 	def_bool y
 	depends on X86_HAVE_PAE || M586TSC || M586MMX || MK6 || MK7 || MGEODEGX1 || MGEODE_LX
 
@@ -313,7 +313,7 @@ config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
 	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MK7)
-	default "5" if X86_32 && X86_CMPXCHG64
+	default "5" if X86_32 && X86_CX8
 	default "4"
 
 config X86_DEBUGCTLMSR
diff --git a/arch/x86/include/asm/asm-prototypes.h b/arch/x86/include/asm/asm-prototypes.h
index 3674006e3974..8d9e62725202 100644
--- a/arch/x86/include/asm/asm-prototypes.h
+++ b/arch/x86/include/asm/asm-prototypes.h
@@ -16,7 +16,7 @@
 #include <asm/gsseg.h>
 #include <asm/nospec-branch.h>
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_CX8
 extern void cmpxchg8b_emu(void);
 #endif
 
diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index 6c6e9b9f98a4..797085ecaaa4 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -48,7 +48,7 @@ static __always_inline s64 arch_atomic64_read_nonatomic(const atomic64_t *v)
 	ATOMIC64_EXPORT(atomic64_##sym)
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 #define __alternative_atomic64(f, g, out, in...) \
 	asm volatile("call %c[func]" \
 		     : ALT_OUTPUT_SP(out) \
diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 95b5f990ca88..ee89fbc4dd4b 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -69,7 +69,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	return __arch_try_cmpxchg64(ptr, oldp, new,);
 }
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 
 #define arch_cmpxchg64 __cmpxchg64
 
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index e9187ddd3d1f..0068133cb622 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -23,7 +23,7 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index f453507649d4..64ccecedc9f8 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -56,7 +56,7 @@ ifeq ($(CONFIG_X86_32),y)
         lib-y += string_32.o
         lib-y += memmove_32.o
         lib-y += cmpxchg8b_emu.o
-ifneq ($(CONFIG_X86_CMPXCHG64),y)
+ifneq ($(CONFIG_X86_CX8),y)
         lib-y += atomic64_386_32.o
 endif
 else
diff --git a/arch/x86/lib/cmpxchg8b_emu.S b/arch/x86/lib/cmpxchg8b_emu.S
index 1c96be769adc..d4bb24347ff8 100644
--- a/arch/x86/lib/cmpxchg8b_emu.S
+++ b/arch/x86/lib/cmpxchg8b_emu.S
@@ -7,7 +7,7 @@
 
 .text
 
-#ifndef CONFIG_X86_CMPXCHG64
+#ifndef CONFIG_X86_CX8
 
 /*
  * Emulate 'cmpxchg8b (%esi)' on UP
diff --git a/lib/atomic64_test.c b/lib/atomic64_test.c
index 759ea1783cc5..d726068358c7 100644
--- a/lib/atomic64_test.c
+++ b/lib/atomic64_test.c
@@ -254,7 +254,7 @@ static __init int test_atomics_init(void)
 	pr_info("passed for %s platform %s CX8 and %s SSE\n",
 #ifdef CONFIG_X86_64
 		"x86-64",
-#elif defined(CONFIG_X86_CMPXCHG64)
+#elif defined(CONFIG_X86_CX8)
 		"i586+",
 #else
 		"i386+",
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
index e9187ddd3d1f..0068133cb622 100644
--- a/tools/arch/x86/include/asm/required-features.h
+++ b/tools/arch/x86/include/asm/required-features.h
@@ -23,7 +23,7 @@
 # define NEED_PAE	0
 #endif
 
-#ifdef CONFIG_X86_CMPXCHG64
+#ifdef CONFIG_X86_CX8
 # define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
 #else
 # define NEED_CX8	0
-- 
2.48.1

