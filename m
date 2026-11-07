Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794026472;
	b=iwCMhktGPcHk2llmrXZwVny+eRs3XTMnsiCW0QVcvqBkfuu5GKm1mZm/SMININgooPod
	 ZscQJTAsS2hqehnGPUO2xlTAWDnNq2CVXHMxdflZZRng1R4JYsqBA1BQ4Xsasn6xkZn3w
	 ZnzV0mvidX2rlsm5RFk2jA7XAg0uZzl5Cygy4VVvm2MXR2tZYVhIqNDubrX9wW4Ea32hY
	 NSW0ufa45nomkKL8WM62yy37qT4B+kPaY3uI9gK5bB2lkbmaWGsJLvl3OJPugVxE83fFm
	 rTWtmUIMf2LjY9cK9YTs8NVqfCAfB0f3dclYkdF+izAXKHHas8CWD96gs8Vnxmamnig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=agR2Maj+nLlCFUT8WqDaPicUpRJX2+6iDrjUBeggcFs=;
	b=GmWwq7CckMGbl/xUSeTxy95GHkevXmKonIwtb8Cf7j97+oSzttQDmDrswsNEdx94MmxT
	 7m0W4hN6/EKMpnWqeWkvdPxrQVeXnGD+Ei0ifwzrsQTUy70jbYtTzqHyhkLFaTJKu/nD5
	 5nZhtaaKMlURygwb+uw1Exu1ufrovUJBLdYZihKn00rZFpqNQzexTgiGYtTIUdxdLm3yI
	 ut0k45G6PYKPbSNhAXGS4JzSVA4+b/yxaUJjmiEMHDfVNhoiIm9UuT2qcnTkBrOiePn56
	 yvs2P7VLUuRvcTq6RdfU3v51v5GXqkioxvutciCOFbE0TuECLvplYucJs5fmMOvF/fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Clb89QJk;
	arc=none smtp.remote-ip=209.85.161.72
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3BF606A32F
	for <linux-perf-users@vger.kernel.org>; Sat,  7 Nov 2026 04:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF3BF606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Clb89QJk
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-70b8894d6c1so472170eaf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Nov 2026 20:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794026471; x=1794631271; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=agR2Maj+nLlCFUT8WqDaPicUpRJX2+6iDrjUBeggcFs=;
        b=Clb89QJk0bJOUVcfwzd+yRO7psUKFo3gyf8ALwrEtLKGFtpkK7LZs70Q4SLPkRbc2E
         whr23NzpMDz0Qcnf4kd2N8Z/v1hegZG+ZnJMY+t0ZXeb6n+AKbL6flwOKrGzVUAEuBID
         WUoYRcMSac9jenX7pVQ+H0zt05v/UByvkM8V/f+mGRlwTu+dmiS9ykRACaTZqvAHHvz6
         8D64A1HJBZlmMwB38AfFEoV5A6gXVZ+9lv1duzY/lqdS0l9HnFaBRQSjzKX0DIXyZqNm
         lhS2ftdn03d5XzHKJiL2IV0Amu0U7IE2JQDxq6APkFYxlpFMLekGXuzxtcUW+fXBLCtb
         9oDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026471; x=1794631271;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=agR2Maj+nLlCFUT8WqDaPicUpRJX2+6iDrjUBeggcFs=;
        b=0NAkLcuVab1D96WMfBCI6MioqVh5Kb3i3AzOra3fz9/kz6s8okkDeDf8OXxpjJ3eVs
         4XRKgzCFC6l7KIMUBmqzJTW25pJTJrFnICnRXTpPnA1DdgptQVwRDuF0VosbA6e/VCme
         7lUzDIL2IYapCOxFKlFEFEs/p1Svx+mohWsB0uv8nNWH3DisnKE+WR6+XVG3ARVvEvA5
         hxqfYVTUS526tH/nIiQMYN+pjiGUYng4ESm1eytZHmkZe+H/CG/WiYivmN7tQO2kNzaF
         aAhY75ET8U2RUh8j/gLeTyI7yjkKToorm69Q3AUk/5RBUrnFUAJGZhJW6v0Wts2al6Yb
         YM9A==
X-Forwarded-Encrypted: i=1; AKwUvByuBHaFohE6urcJgDjyX3+FweEzyWfkYu5x+jSIeiaV8bIuT+XbP1DaXoob+8a4nAP+J1jbj8B4TlQ3hLE2d96/@vger.kernel.org
X-Gm-Message-State: APuU4Z/PPV/pcPa1kEFpcRPifEddqRXQKsBgST8clKVfwPaxe7vJeGAZ
	qguGc76vHpRRTVL2232YfGycHKGAlnBWGjBtuKfzLMzMcE1bwG59ZrDNxKpSv5sl3EecHiS0C0L
	K8GsSzZ4Ffw==
X-Received: from oobej14.prod.google.com ([2002:a05:6820:d0e:b0:70b:8ae3:8a12])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6820:2206:b0:6cd:3fdc:2668
 with SMTP id 006d021491bc7-71700c6075fmr509773eaf.41.1794026470447; Fri, 06
 Nov 2026 20:41:10 -0800 (PST)
Date: Fri,  6 Nov 2026 20:40:43 -0800
In-Reply-To: <20261107044102.1506626-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261107044102.1506626-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261107044102.1506626-3-irogers@google.com>
Subject: [PATCH v11 02/20] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, bvanassche@acm.org, elver@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com, nathan@kernel.org, 
	ndesaulniers@google.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

Synchronize the non-__KERNEL__ sections of
tools/include/linux/compiler_types.h and
tools/include/linux/compiler-gcc.h with the kernel sources (including
___PASTE/__PASTE, BTF_TYPE_TAG, object-size helpers, asm_goto_output,
ASM_INPUT_*, asm_inline, __typeof_unqual__/__unqual_scalar_typeof,
__signed_scalar_typeof, __native_word, compiletime_assert, and the
__diag pragma helpers required by compiler-context-analysis.h), and
remove the duplicated definitions from tools/include/linux/compiler.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/linux/compiler-gcc.h   |  72 +++++++++-
 tools/include/linux/compiler.h       |  50 +------
 tools/include/linux/compiler_types.h | 206 ++++++++++++++++++++++++++-
 3 files changed, 275 insertions(+), 53 deletions(-)

diff --git a/tools/include/linux/compiler-gcc.h b/tools/include/linux/compiler-gcc.h
index e20f98e14e81..e005e8d5dfda 100644
--- a/tools/include/linux/compiler-gcc.h
+++ b/tools/include/linux/compiler-gcc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TOOLS_LINUX_COMPILER_H_
+#ifndef __LINUX_COMPILER_TYPES_H
 #error "Please do not include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
-#endif
+#endif /* __LINUX_COMPILER_TYPES_H */
 
 /*
  * Common definitions for all gcc versions go here.
@@ -33,10 +33,76 @@
 #define __packed	__attribute__((packed))
 #endif
 #ifndef __noreturn
-#define __noreturn	__attribute__((noreturn))
+#define __noreturn	__attribute__((__noreturn__))
 #endif
 #ifndef __aligned
 #define __aligned(x)	__attribute__((aligned(x)))
 #endif
 #define __printf(a, b)	__attribute__((format(printf, a, b)))
 #define __scanf(a, b)	__attribute__((format(scanf, a, b)))
+
+/*
+ * Turn individual warnings and errors on and off locally, depending
+ * on version.
+ */
+#define __diag_str1(s)		#s
+#define __diag_str(s)		__diag_str1(s)
+
+#ifdef __clang__
+#define __diag_clang(version, severity, s) \
+	__diag_clang_ ## version(__diag_clang_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_clang_ignore	ignored
+#define __diag_clang_warn	warning
+#define __diag_clang_error	error
+
+#define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
+
+#if __clang_major__ >= 23
+#define __diag_clang_23(s)	__diag(s)
+#else
+#define __diag_clang_23(s)
+#endif
+
+#define __diag_clang_all(s)	__diag(s)
+
+#define __diag_ignore_all(option, comment) \
+	__diag_clang(all, ignore, option)
+
+/*
+ * clang has horrible behavior with "g" or "rm" constraints for asm
+ * inputs, turning them into something worse than "m". Avoid using
+ * constraints with multiple possible uses (but "ir" seems to be ok):
+ *
+ *	https://github.com/llvm/llvm-project/issues/20571
+ */
+#define ASM_INPUT_G "ir"
+#define ASM_INPUT_RM "r"
+#define ASM_OUTPUT_RM "=r"
+
+#define CC_HAS_TYPEOF_UNQUAL (__clang_major__ > 19 || (__clang_major__ == 19 && __clang_minor__ > 0))
+#else /* !__clang__ */
+#define __diag_GCC(version, severity, s) \
+	__diag_GCC_ ## version(__diag_GCC_ ## severity s)
+
+/* Severity used in pragma directives */
+#define __diag_GCC_ignore	ignored
+#define __diag_GCC_warn		warning
+#define __diag_GCC_error	error
+
+#define __diag(s)		_Pragma(__diag_str(GCC diagnostic s))
+
+#if GCC_VERSION >= 80000
+#define __diag_GCC_8(s)		__diag(s)
+#else
+#define __diag_GCC_8(s)
+#endif
+
+#define __diag_GCC_all(s)	__diag(s)
+
+#define __diag_ignore_all(option, comment) \
+	__diag(__diag_GCC_ignore option)
+
+#define CC_HAS_TYPEOF_UNQUAL (__GNUC__ >= 14)
+#endif /* __clang__ */
diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index 03ecf9086643..505fbb0080d0 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -1,41 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TOOLS_LINUX_COMPILER_H_
-#define _TOOLS_LINUX_COMPILER_H_
+#ifndef __LINUX_COMPILER_H
+#define __LINUX_COMPILER_H
 
 #ifndef __ASSEMBLY__
 
 #include <linux/compiler_types.h>
 
-#ifndef __compiletime_error
-# define __compiletime_error(message)
-#endif
-
-#ifdef __OPTIMIZE__
-# define __compiletime_assert(condition, msg, prefix, suffix)		\
-	do {								\
-		extern void prefix ## suffix(void) __compiletime_error(msg); \
-		if (!(condition))					\
-			prefix ## suffix();				\
-	} while (0)
-#else
-# define __compiletime_assert(condition, msg, prefix, suffix) do { } while (0)
-#endif
-
-#define _compiletime_assert(condition, msg, prefix, suffix) \
-	__compiletime_assert(condition, msg, prefix, suffix)
-
-/**
- * compiletime_assert - break build and emit msg if condition is false
- * @condition: a compile-time constant condition to check
- * @msg:       a message to emit if condition is false
- *
- * In tradition of POSIX assert, this macro will break the build if the
- * supplied condition is *false*, emitting the supplied error message if the
- * compiler has support to do so.
- */
-#define compiletime_assert(condition, msg) \
-	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
-
 /* Optimization barrier */
 /* The "volatile" is due to gcc bugs */
 #define barrier() __asm__ __volatile__("": : :"memory")
@@ -48,10 +18,6 @@
 #define __always_unused __attribute__((__unused__))
 #endif
 
-#ifndef __noreturn
-#define __noreturn __attribute__((__noreturn__))
-#endif
-
 #ifndef unreachable
 #define unreachable() __builtin_unreachable()
 #endif
@@ -68,11 +34,6 @@
 #define __naked __attribute__((__naked__))
 #endif
 
-/* Are two types/vars the same type (ignoring qualifiers)? */
-#ifndef __same_type
-# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
-#endif
-
 /* Enforce static storage duration. */
 #define ASSERT_STATIC_STORAGE(name) \
 	static typeof(name) * const __always_unused \
@@ -242,11 +203,6 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 	__u.__val;					\
 })
 
-
-/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
-#define ___PASTE(a, b) a##b
-#define __PASTE(a, b) ___PASTE(a, b)
-
 #ifndef OPTIMIZER_HIDE_VAR
 /* Make the optimizer believe the variable can be manipulated arbitrarily. */
 #define OPTIMIZER_HIDE_VAR(var)						\
@@ -263,4 +219,4 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
 
 #endif /* __ASSEMBLY__ */
 
-#endif /* _TOOLS_LINUX_COMPILER_H */
+#endif /* __LINUX_COMPILER_H */
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index b3adbf5682f0..31e9f7d2a466 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -2,8 +2,6 @@
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
-/* Builtins */
-
 /*
  * __has_builtin is supported on gcc >= 10, clang >= 3 and icc >= 21.
  * In the meantime, to support gcc < 10, we implement __has_builtin
@@ -13,6 +11,23 @@
 #define __has_builtin(x) (0)
 #endif
 
+/* Indirect macros required for expanded argument pasting, eg. __LINE__. */
+#define ___PASTE(a, b) a##b
+#define __PASTE(a, b) ___PASTE(a, b)
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Skipped when running bindgen due to a libclang issue;
+ * see https://github.com/rust-lang/rust-bindgen/issues/2244.
+ */
+#if defined(CONFIG_DEBUG_INFO_BTF) && defined(CONFIG_PAHOLE_HAS_BTF_TAG) && \
+	__has_attribute(btf_type_tag) && !defined(__BINDGEN__)
+# define BTF_TYPE_TAG(value) __attribute__((btf_type_tag(#value)))
+#else
+# define BTF_TYPE_TAG(value) /* nothing */
+#endif
+
 #include <linux/compiler-context-analysis.h>
 
 /* Compiler specific macros. */
@@ -20,14 +35,101 @@
 #include <linux/compiler-gcc.h>
 #endif
 
+#ifndef __compiletime_error
+# define __compiletime_error(message)
+#endif
+
+#ifndef __noreturn
+# define __noreturn __attribute__((__noreturn__))
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+/*
+ * When the size of an allocated object is needed, use the best available
+ * mechanism to find it. (For cases where sizeof() cannot be used.)
+ *
+ * Optional: only supported since gcc >= 12
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Object-Size-Checking.html
+ * clang: https://clang.llvm.org/docs/LanguageExtensions.html#evaluating-object-size
+ */
+#if __has_builtin(__builtin_dynamic_object_size)
+#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
+#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
+#else
+#define __struct_size(p)	__builtin_object_size(p, 0)
+#define __member_size(p)	__builtin_object_size(p, 1)
+#endif
+
+/*
+ * Determine if an attribute has been applied to a variable.
+ * Using __annotated needs to check for __annotated being available,
+ * or negative tests may fail when annotation cannot be checked. For
+ * example, see the definition of __is_cstr().
+ */
+#if __has_builtin(__builtin_has_attribute)
+#define __annotated(var, attr)	__builtin_has_attribute(var, attr)
+#endif
+
+/*
+ * Optional: only supported since gcc >= 15, clang >= 19
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html#index-_005f_005fbuiltin_005fcounted_005fby_005fref
+ * clang: https://clang.llvm.org/docs/LanguageExtensions.html#builtin-counted-by-ref
+ */
+#if __has_builtin(__builtin_counted_by_ref) && \
+    !defined(CONFIG_CC_HAS_BROKEN_COUNTED_BY_REF)
+#define __flex_counter(FAM)	__builtin_counted_by_ref(FAM)
+#else
+#define __flex_counter(FAM)	((void *)NULL)
+#endif
+
+/*
+ * Some versions of gcc do not mark 'asm goto' volatile:
+ *
+ *  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103979
+ *
+ * We do it here by hand, because it doesn't hurt.
+ */
 #ifndef asm_goto_output
-#define asm_goto_output(x...) asm goto(x)
+#define asm_goto_output(x...) asm volatile goto(x)
+#endif
+
+/*
+ * Clang has trouble with constraints with multiple
+ * alternative behaviors ("g" , "rm" and "=rm").
+ */
+#ifndef ASM_INPUT_G
+  #define ASM_INPUT_G "g"
+  #define ASM_INPUT_RM "rm"
+  #define ASM_OUTPUT_RM "=rm"
+#endif
+
+#ifdef CONFIG_CC_HAS_ASM_INLINE
+#define asm_inline asm __inline
+#else
+#define asm_inline asm
+#endif
+
+#ifndef __ASSEMBLY__
+/*
+ * Use __typeof_unqual__() when available.
+ */
+#if (defined(CC_HAS_TYPEOF_UNQUAL) && CC_HAS_TYPEOF_UNQUAL) || defined(__CHECKER__)
+# define USE_TYPEOF_UNQUAL 1
+#endif
+
+/* Are two types/vars the same type (ignoring qualifiers)? */
+#ifndef __same_type
+# define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 #endif
 
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
  */
+#ifndef USE_TYPEOF_UNQUAL
 /*
  * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
  * is not type-compatible with 'signed char', and we define a separate case.
@@ -45,5 +147,103 @@
 			 __scalar_type_to_expr_cases(long),		\
 			 __scalar_type_to_expr_cases(long long),	\
 			 default: (x)))
+#else
+#define __unqual_scalar_typeof(x) __typeof_unqual__(x)
+#endif
+
+#endif /* !__ASSEMBLY__ */
+
+/*
+ * __signed_scalar_typeof(x) - Declare a signed scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+
+#define __scalar_type_to_signed_cases(type)				\
+		unsigned type:	(signed type)0,				\
+		signed type:	(signed type)0
+
+#define __signed_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(signed char)0,				\
+			 __scalar_type_to_signed_cases(char),		\
+			 __scalar_type_to_signed_cases(short),		\
+			 __scalar_type_to_signed_cases(int),		\
+			 __scalar_type_to_signed_cases(long),		\
+			 __scalar_type_to_signed_cases(long long),	\
+			 default: (x)))
+
+/* Is this type a native word size -- useful for atomic operations */
+#define __native_word(t) \
+	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
+	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
+
+#ifdef __OPTIMIZE__
+/*
+ * #ifdef __OPTIMIZE__ is only a good approximation; for instance "make
+ * CFLAGS_foo.o=-Og" defines __OPTIMIZE__, does not elide the conditional code
+ * and can break compilation with wrong error message(s). Combine with
+ * -U__OPTIMIZE__ when needed.
+ */
+# define __compiletime_assert(condition, msg, prefix, suffix)		\
+	do {								\
+		/*							\
+		 * __noreturn is needed to give the compiler enough	\
+		 * information to avoid certain possibly-uninitialized	\
+		 * warnings (regardless of the build failing).		\
+		 */							\
+		__noreturn extern void prefix ## suffix(void)		\
+			__compiletime_error(msg);			\
+		if (!(condition))					\
+			prefix ## suffix();				\
+	} while (0)
+#else
+# define __compiletime_assert(condition, msg, prefix, suffix) ((void)(condition))
+#endif
+
+#define _compiletime_assert(condition, msg, prefix, suffix) \
+	__compiletime_assert(condition, msg, prefix, suffix)
+
+/**
+ * compiletime_assert - break build and emit msg if condition is false
+ * @condition: a compile-time constant condition to check
+ * @msg:       a message to emit if condition is false
+ *
+ * In tradition of POSIX assert, this macro will break the build if the
+ * supplied condition is *false*, emitting the supplied error message if the
+ * compiler has support to do so.
+ */
+#define compiletime_assert(condition, msg) \
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
+
+#define compiletime_assert_atomic_type(t)				\
+	compiletime_assert(__native_word(t),				\
+		"Need native word sized stores/loads for atomicity.")
+
+/* Helpers for emitting diagnostics in pragmas. */
+#ifndef __diag
+#define __diag(string)
+#endif
+
+#ifndef __diag_GCC
+#define __diag_GCC(version, severity, string)
+#endif
+
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
+#define __diag_push()	__diag(push)
+#define __diag_pop()	__diag(pop)
+
+#define __diag_ignore(compiler, version, option, comment) \
+	__diag_ ## compiler(version, ignore, option)
+#define __diag_warn(compiler, version, option, comment) \
+	__diag_ ## compiler(version, warn, option)
+#define __diag_error(compiler, version, option, comment) \
+	__diag_ ## compiler(version, error, option)
+
+#ifndef __diag_ignore_all
+#define __diag_ignore_all(option, comment)
+#endif
 
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.56.0.455.g6c5a503b38-goog

