Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3F81FDA8C
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756009; cv=none; b=i2KqgZVNruv5CEpXBidsmKZBqcAVoAgDztONUmEPawW3KwFHem1DsE3tT367t8VO0jaWOzIUvSji08HBQ3LyqS7Q6wzvu6Xw6E70BrW5OVnIqxOcO0WB79f5gokmhYZR8fxQpbSUWiu3jgyJXQyZPNQVSpj7y2C9BZAEycrc8r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756009; c=relaxed/simple;
	bh=XsIbEo1QAt0OSwO87c3wfNo0TeJaG8VRy1MC8xgy3HE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=gNuLo83fcP04JxDRXpZFm92cZpY432hjTXW55Wwo2e/G6MyyNWe72rI+CfoUJLq4Ek5FJ2fI08jq+A7xQ17L1Rl1Jcux+Gj5CbJwOePHyEXb+dSPpE+a+YjGsEpirGVsUjwD17g/GyLHKbuQW+EuK+mdqTc5quwWZS/yxO66CkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOsJjeAO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOsJjeAO"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b39280167fdso4197756a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756007; x=1754360807; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CpvVVuC6XWA9ztMyuKPQWMesncLZVwr6fWvq0ZdAuns=;
        b=TOsJjeAOIOtSUkoDOYMbzQHDB3nUPUoHIVEyvPFTVxgXBPN0TYgkJOKmiwAUz0aj66
         +0ODGfMhxS915EAvQ7ILZE9ciGH/9RFwu+pgIkbJjKNkeYdkJjJ4Ibn0JtL4f8XprWFj
         TgQsqAiwHW/0EXioWrihzZM4zn34BuF+tUt1B+M19rgE+RvFiTFMn1GsOIT3gaDonDv4
         iopwNCLxqTqkBT36mV7dEtCpiNXvtTz/KZdfO+7Dk9NWSHxdqbOxooHCGaVrMtD6u8jS
         oWL9LKSMuecKyJUsmTfeIDksgvzn9Te6EfSguXrNcrY4hbUczwC5FqmyzxyIVC3/84fW
         5zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756007; x=1754360807;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpvVVuC6XWA9ztMyuKPQWMesncLZVwr6fWvq0ZdAuns=;
        b=m+HSd/EJ9QGGkdmnrrTwrQ7QEckQyQGhCiHDYn94x/aoaL9mvX3vNvtIf6W/MZMFyx
         +UW/kXCGA5SHDCUy3J+CmCmSR65rmELuJtBJ1geZV8kO1Q3j7cv4/UJnFm3LyqclC78w
         ZlIOWE74CgjRDGOoPHHbB7fFcyuMquHnOzICkVIoEGCy7nQTQ/QYDyiMH2uncZcoQA2+
         /yVqpImqHFSqKmxRz0ZU2j3GKuoyG79/gmddWK84gmVnOsd8UDMz6Tjd0gqiZJ0ewLng
         L5mOhP0fgw7+DvJyNeg9vBlgPZRAIhWrYZSAcehfCOigtUBKZ0r7s5oeE7zk8omJ/57K
         P3GA==
X-Forwarded-Encrypted: i=1; AJvYcCUvSff9V6b5OKg/0WIaV1kBSoA+EF4akjRmUIVZ9gLVXH54mIFG7FKeQM3o6JGOt9LWcuVHkQ4pWfDXNrytoSfp@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6xOnHpiUZrDHJtfmTGqWJcaZaLnqEDOOeOIg7ilF0lObAAkGU
	RGAQnqGdttHnDFs5ViRg+fK5iFp6pVTnDGZGQR1jmnXALe2IEF04Ed0X4yhDIwcSCfpziWm9q/U
	NAn/pJw==
X-Google-Smtp-Source: AGHT+IFt6+m168wx8T76kfzjdkF7E2tdg8yvH2KSyyNcVARAGAS5oWA8BSfGsd1blfwQzInw+l51kjZ6qRQ=
X-Received: from pfqr16.prod.google.com ([2002:aa7:9ed0:0:b0:749:42ec:b4bd])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748e:b0:233:d85e:a698
 with SMTP id adf61e73a8af0-23d701bdfb7mr20813996637.32.1753756006616; Mon, 28
 Jul 2025 19:26:46 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:34 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-2-yuzhuo@google.com>
Subject: [PATCH v1 1/7] tools: Import cmpxchg and xchg functions
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Yuzhuo Jing <yzj@umich.edu>, 
	Yuzhuo Jing <yuzhuo@google.com>, Andrea Parri <parri.andrea@gmail.com>, 
	Palmer Dabbelt <palmer@rivosinc.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Barret Rhoden <brho@google.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Guo Ren <guoren@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Import necessary atomic functions used by qspinlock.  Copied x86
implementation verbatim, and used compiler builtin for generic
implementation.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/arch/x86/include/asm/atomic.h    |  14 +++
 tools/arch/x86/include/asm/cmpxchg.h   | 113 +++++++++++++++++++++++++
 tools/include/asm-generic/atomic-gcc.h |  47 ++++++++++
 tools/include/linux/atomic.h           |  24 ++++++
 tools/include/linux/compiler_types.h   |  24 ++++++
 5 files changed, 222 insertions(+)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index 365cf182df12..a55ffd4eb5f1 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -71,6 +71,20 @@ static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 	return cmpxchg(&v->counter, old, new);
 }
 
+static __always_inline bool atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	return try_cmpxchg(&v->counter, old, new);
+}
+
+static __always_inline int atomic_fetch_or(int i, atomic_t *v)
+{
+	int val = atomic_read(v);
+
+	do { } while (!atomic_try_cmpxchg(v, &val, val | i));
+
+	return val;
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 0ed9ca2766ad..5372da8b27fc 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -8,6 +8,8 @@
  * Non-existant functions to indicate usage errors at link time
  * (or compile-time if the compiler implements __compiletime_error().
  */
+extern void __xchg_wrong_size(void)
+	__compiletime_error("Bad argument size for xchg");
 extern void __cmpxchg_wrong_size(void)
 	__compiletime_error("Bad argument size for cmpxchg");
 
@@ -27,6 +29,49 @@ extern void __cmpxchg_wrong_size(void)
 #define	__X86_CASE_Q	-1		/* sizeof will never return -1 */
 #endif
 
+/* 
+ * An exchange-type operation, which takes a value and a pointer, and
+ * returns the old value.
+ */
+#define __xchg_op(ptr, arg, op, lock)					\
+	({								\
+	        __typeof__ (*(ptr)) __ret = (arg);			\
+		switch (sizeof(*(ptr))) {				\
+		case __X86_CASE_B:					\
+			asm_inline volatile (lock #op "b %b0, %1"	\
+				      : "+q" (__ret), "+m" (*(ptr))	\
+				      : : "memory", "cc");		\
+			break;						\
+		case __X86_CASE_W:					\
+			asm_inline volatile (lock #op "w %w0, %1"	\
+				      : "+r" (__ret), "+m" (*(ptr))	\
+				      : : "memory", "cc");		\
+			break;						\
+		case __X86_CASE_L:					\
+			asm_inline volatile (lock #op "l %0, %1"	\
+				      : "+r" (__ret), "+m" (*(ptr))	\
+				      : : "memory", "cc");		\
+			break;						\
+		case __X86_CASE_Q:					\
+			asm_inline volatile (lock #op "q %q0, %1"	\
+				      : "+r" (__ret), "+m" (*(ptr))	\
+				      : : "memory", "cc");		\
+			break;						\
+		default:						\
+			__ ## op ## _wrong_size();			\
+		__cmpxchg_wrong_size();					\
+		}							\
+		__ret;							\
+	})
+
+/*
+ * Note: no "lock" prefix even on SMP: xchg always implies lock anyway.
+ * Since this is generally used to protect other memory information, we
+ * use "asm volatile" and "memory" clobbers to prevent gcc from moving
+ * information around.
+ */
+#define xchg(ptr, v)	__xchg_op((ptr), (v), xchg, "")
+
 /*
  * Atomic compare and exchange.  Compare OLD with MEM, if identical,
  * store NEW in MEM.  Return the initial value in MEM.  Success is
@@ -86,5 +131,73 @@ extern void __cmpxchg_wrong_size(void)
 #define cmpxchg(ptr, old, new)						\
 	__cmpxchg(ptr, old, new, sizeof(*(ptr)))
 
+#define __raw_try_cmpxchg(_ptr, _pold, _new, size, lock)		\
+({									\
+	bool success;							\
+	__typeof__(_ptr) _old = (__typeof__(_ptr))(_pold);		\
+	__typeof__(*(_ptr)) __old = *_old;				\
+	__typeof__(*(_ptr)) __new = (_new);				\
+	switch (size) {							\
+	case __X86_CASE_B:						\
+	{								\
+		volatile u8 *__ptr = (volatile u8 *)(_ptr);		\
+		asm_inline volatile(lock "cmpxchgb %[new], %[ptr]"	\
+			     CC_SET(z)					\
+			     : CC_OUT(z) (success),			\
+			       [ptr] "+m" (*__ptr),			\
+			       [old] "+a" (__old)			\
+			     : [new] "q" (__new)			\
+			     : "memory");				\
+		break;							\
+	}								\
+	case __X86_CASE_W:						\
+	{								\
+		volatile u16 *__ptr = (volatile u16 *)(_ptr);		\
+		asm_inline volatile(lock "cmpxchgw %[new], %[ptr]"	\
+			     CC_SET(z)					\
+			     : CC_OUT(z) (success),			\
+			       [ptr] "+m" (*__ptr),			\
+			       [old] "+a" (__old)			\
+			     : [new] "r" (__new)			\
+			     : "memory");				\
+		break;							\
+	}								\
+	case __X86_CASE_L:						\
+	{								\
+		volatile u32 *__ptr = (volatile u32 *)(_ptr);		\
+		asm_inline volatile(lock "cmpxchgl %[new], %[ptr]"	\
+			     CC_SET(z)					\
+			     : CC_OUT(z) (success),			\
+			       [ptr] "+m" (*__ptr),			\
+			       [old] "+a" (__old)			\
+			     : [new] "r" (__new)			\
+			     : "memory");				\
+		break;							\
+	}								\
+	case __X86_CASE_Q:						\
+	{								\
+		volatile u64 *__ptr = (volatile u64 *)(_ptr);		\
+		asm_inline volatile(lock "cmpxchgq %[new], %[ptr]"	\
+			     CC_SET(z)					\
+			     : CC_OUT(z) (success),			\
+			       [ptr] "+m" (*__ptr),			\
+			       [old] "+a" (__old)			\
+			     : [new] "r" (__new)			\
+			     : "memory");				\
+		break;							\
+	}								\
+	default:							\
+		__cmpxchg_wrong_size();					\
+	}								\
+	if (unlikely(!success))						\
+		*_old = __old;						\
+	likely(success);						\
+})
+
+#define __try_cmpxchg(ptr, pold, new, size)				\
+	__raw_try_cmpxchg((ptr), (pold), (new), (size), LOCK_PREFIX)
+
+#define try_cmpxchg(ptr, pold, new) 				\
+	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
 #endif	/* TOOLS_ASM_X86_CMPXCHG_H */
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 9b3c528bab92..08b7b3b36873 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -62,6 +62,12 @@ static inline int atomic_dec_and_test(atomic_t *v)
 	return __sync_sub_and_fetch(&v->counter, 1) == 0;
 }
 
+#define xchg(ptr, v) \
+	__atomic_exchange_n(ptr, v, __ATOMIC_SEQ_CST)
+
+#define xchg_relaxed(ptr, v) \
+	__atomic_exchange_n(ptr, v, __ATOMIC_RELAXED)
+
 #define cmpxchg(ptr, oldval, newval) \
 	__sync_val_compare_and_swap(ptr, oldval, newval)
 
@@ -70,6 +76,47 @@ static inline int atomic_cmpxchg(atomic_t *v, int oldval, int newval)
 	return cmpxchg(&(v)->counter, oldval, newval);
 }
 
+/**
+ * atomic_try_cmpxchg() - atomic compare and exchange with full ordering
+ * @v: pointer to atomic_t
+ * @old: pointer to int value to compare with
+ * @new: int value to assign
+ *
+ * If (@v == @old), atomically updates @v to @new with full ordering.
+ * Otherwise, @v is not modified, @old is updated to the current value of @v,
+ * and relaxed ordering is provided.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_try_cmpxchg() there.
+ *
+ * Return: @true if the exchange occured, @false otherwise.
+ */
+static __always_inline bool
+atomic_try_cmpxchg(atomic_t *v, int *old, int new)
+{
+	int r, o = *old;
+	r = atomic_cmpxchg(v, o, new);
+	if (unlikely(r != o))
+		*old = r;
+	return likely(r == o);
+}
+
+/**
+ * atomic_fetch_or() - atomic bitwise OR with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v | @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_or() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_or(int i, atomic_t *v)
+{
+	return __sync_fetch_and_or(&v->counter, i);
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 01907b33537e..332a34177995 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -12,4 +12,28 @@ void atomic_long_set(atomic_long_t *v, long i);
 #define  atomic_cmpxchg_release         atomic_cmpxchg
 #endif /* atomic_cmpxchg_relaxed */
 
+#ifndef atomic_cmpxchg_acquire
+#define atomic_cmpxchg_acquire		atomic_cmpxchg
+#endif
+
+#ifndef atomic_try_cmpxchg_acquire
+#define atomic_try_cmpxchg_acquire	atomic_try_cmpxchg
+#endif
+
+#ifndef atomic_try_cmpxchg_relaxed
+#define atomic_try_cmpxchg_relaxed	atomic_try_cmpxchg
+#endif
+
+#ifndef atomic_fetch_or_acquire
+#define atomic_fetch_or_acquire		atomic_fetch_or
+#endif
+
+#ifndef xchg_relaxed
+#define xchg_relaxed		xchg
+#endif
+
+#ifndef cmpxchg_release
+#define cmpxchg_release		cmpxchg
+#endif
+
 #endif /* __TOOLS_LINUX_ATOMIC_H */
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index d09f9dc172a4..9a2a2f8d7b6c 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -31,6 +31,28 @@
 # define __cond_lock(x,c) (c)
 #endif /* __CHECKER__ */
 
+/*
+ * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
+ *			       non-scalar types unchanged.
+ */
+/*
+ * Prefer C11 _Generic for better compile-times and simpler code. Note: 'char'
+ * is not type-compatible with 'signed char', and we define a separate case.
+ */
+#define __scalar_type_to_expr_cases(type)				\
+		unsigned type:	(unsigned type)0,			\
+		signed type:	(signed type)0
+
+#define __unqual_scalar_typeof(x) typeof(				\
+		_Generic((x),						\
+			 char:	(char)0,				\
+			 __scalar_type_to_expr_cases(char),		\
+			 __scalar_type_to_expr_cases(short),		\
+			 __scalar_type_to_expr_cases(int),		\
+			 __scalar_type_to_expr_cases(long),		\
+			 __scalar_type_to_expr_cases(long long),	\
+			 default: (x)))
+
 /* Compiler specific macros. */
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
@@ -40,4 +62,6 @@
 #define asm_goto_output(x...) asm goto(x)
 #endif
 
+#define asm_inline asm
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.50.1.487.gc89ff58d15-goog

