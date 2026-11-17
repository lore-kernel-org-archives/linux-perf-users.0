Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941349;
	b=kb2lh3loHr7cpIo6DkqJjn7rx5cAMBztR+pX7QacgjWcVSAce6O5Z/NLbsjNOBQQQPdE
	 uzFvVzZ8tN+cyLz+DvHEc8t6uKOfaXknyyFeBPf3Oiv1zSLrVr+Qg2lIfgOjHy5GFMh6q
	 T1VUc0qJKf+CfxtfUQ1G0qzHPDSdN5UYFZz7btQ+LW4IpPS4eOv8fjgnv64onPwa0Q6kt
	 P6HGT1i0nyRitjXrDyAjiBFn2TdGapr+byI6sUJqHnfRasUcSw8C4I2mrKRIFMbZhsuca
	 FN6ZQh5Z0dgP7Z1+R/0azjR3YiP4i1GFEIolb1+jAHZBihQzk+JINL8AQbIwH/3tS+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=g5ljl/gAQ9Egsc8XsRi8qYapj3WwMVjISzTiKbfvJcs=;
	b=I5kVcPkgsNKN7F0icijv7l44PwxqXk7jTWnyXzb7RTQhzKcV8sl6JO4yxq6ggCUgBvYg
	 DEs1UPuKYgh7PXGG2xMxZhhK7OyoqPhy0QdE5UCZq1JRbZqoPe/p2nFGHxljCduvW1frO
	 8eNsmcC8gg4dZO7Gyb1CCGhu3r7bU4fyv0YcW5HwWp7JgCLKMIoqfRS5XubDgiVTjJEiA
	 OuxQqwxd5/jiQnN4xmhEZfdRnafvGySFuT/zh7lMSehknWufiid1mlFviNWvhOUTqWjhb
	 QxXpz7E3PNHGal+C5OngLOefKG7bJunYgsLVaMus1RMWxtug4fN4XkMEaKhRFYn4w/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Y+A/XirX";
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37EE606A32F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 18:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37EE606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y+A/XirX
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-381dc4b8f40so209564eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 10:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794941348; x=1795546148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g5ljl/gAQ9Egsc8XsRi8qYapj3WwMVjISzTiKbfvJcs=;
        b=Y+A/XirXLfPBH1HQp8eSGVHQJKGOrTFXx2NNhHOX/FTzHPnudtzY+fPw67H6a/Cg+y
         fjVi9vG1nIHbxmvege2N4fhB0JfRz3YisQ6z/DNE275w/fGsB9b2i4zJizeGnNtqExfG
         5yMDsOzM1FlMJ+aEBgAye+Fmr2nP05TyuYqS9eFoJifFpSB8rx1qMDY+UHVWyXnPHaWF
         aKuuqYEcPwcM5g3+O57EmnhWgl6StL/DnKGeeroHNJ0Jr7qTnrArjHOTrWAQ6xmlFJRi
         DfM0JfqhG0yvFPd1Z2VFH/5ixFmE02K15ISMEwhcbDnc33vsee0nBapV6w2uqdT+dBW0
         iLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794941348; x=1795546148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g5ljl/gAQ9Egsc8XsRi8qYapj3WwMVjISzTiKbfvJcs=;
        b=AaY8TQoN1U0YWC8yXNz2wgwb07wNr1Y5OtXKSkqHI0bbwcjEPk3d0pluux11MjhtXn
         KMLmE8CwPYQ8Rl3nxEq6kg5rBmYoX9niazfmaH6uUfGzsaY1bHUE7sksw2or2U1kH6ZK
         QBDYdbALwEr0toM4WS5DVIW8gTzN4qaIVtc50FqjlqYEKyirF2s883PtiYOzKgAWnTqE
         w2HNNItHuDQnaROiwhYyoxFvnti5LDd+hwbLJ2t4AeoatxZ5BnwT5DiAoiLwFpPApV/a
         xNclAE9+g/RX4xeCl3CSQZ+dVo88GdbYJjIjVjN/UmrRg7tGlAv7scuAfWAnzSFuD6Vm
         e7TA==
X-Forwarded-Encrypted: i=1; AL+hErGxp8kt8W2HBjp/UOVdYpMKv7OFBsisBNfB5VFDKfQ9sBen31ryNKZtFEHTWyZJHupnZYT8a2ZHs5pdXU04qTkj@vger.kernel.org
X-Gm-Message-State: APuU4Z+7WldpB3fZ+pcBEG0WXXvJP7nd/1zK+Va9NdKnJsXNTD4J5Uz/
	rsVnWxY+MYFerQSIp4pJVBR4KndXiUbQ8aEswebugYw500rZJjth1VOYnj8CKklgI70pSMSOwvL
	NcA2v8pdSJQ==
X-Received: from dldnz13.prod.google.com ([2002:a05:701a:ca0d:b0:163:a42e:b837])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2056:b0:144:eaa7:2763
 with SMTP id a92af1059eb24-1b543cf2a7amr331436c88.16.1794941347321; Tue, 17
 Nov 2026 10:49:07 -0800 (PST)
Date: Tue, 17 Nov 2026 10:48:23 -0800
In-Reply-To: <20261117184844.99889-1-irogers@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261117184844.99889-1-irogers@google.com>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261117184844.99889-3-irogers@google.com>
Subject: [PATCH v14 02/23] tools headers compiler: Synchronize
 compiler_types.h with the kernel sources
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	llvm@lists.linux.dev, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
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
2.56.1.703.gf848ed807c-goog

