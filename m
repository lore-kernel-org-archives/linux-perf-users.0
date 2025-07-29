Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45189279351
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 08:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776799; cv=none; b=TOuTU1df4IW3A7tP7j2wphbJ/7sqY1mjP0mEUrwyovgHUqWqigBT35cF+iuz23coYwpJdOR8ZuJk6qLAwvOcoeASJT3SLUSeR2iVqoMjE6XNuze5TXp0pD/jx7QaGVDTNw6ziAM8bRlWqt65xrDijnLYZ3sZd7Y2OxITWtdgpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776799; c=relaxed/simple;
	bh=G9Y0WTqgPEP/0PUyf6rRBrHpWFUxSCuG/ZYeAAHbSBU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BOg3eKoettm2U4aCHv0wfTrBp8VvHXQ3Ima1z3fo2c+rKjCfioGxaMjmlx0KwZh0iiUqIJrzLPTZKMzCezP0y2AZ5z9jEutpL9yPZfMJCL8QsZNGJWev9JJQ8EE9SoHGZbjeWEHS2en3g+2aTsTb1amQDIBVomAOAAY2nPY1eXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xIsSTIQ6; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xIsSTIQ6"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ce2491c0fso8451661b3a.0
        for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 01:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753776796; x=1754381596; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7yGmakvlGT634aR11Csz05fa+gmD+2vIJ9rH8M6yTyo=;
        b=xIsSTIQ6lmj6KUcXfutoPP/TfBlWngcrvFH4JWhAkb9G23Xh0TZNZiWx8Xzgj+ZHY7
         lNvqopSbKKNV+OXzhZzm8w9w8orOyGof0ktI9Q3G9f79BQwD99Os3A1gvpptqRwFCute
         VcC1QqGn+mcV5uJjmHYZbvMA+dWCeaxfiMIKLIdn6NHij8xJtuFr0F83sfLiGqzfWcDW
         gjcAade8G7bWV+AjmTda7YUyg70egsSFe1WB0oE/WOcVJm9cwcySnAP6L/FwO2RjTzZ0
         GWxvxGKIYYywMZoS9JzI3ZsHSKO3SX2mBYHZBKh67oqY99Bg2JWBT9zBW60P9zVAyuJ4
         IE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753776796; x=1754381596;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7yGmakvlGT634aR11Csz05fa+gmD+2vIJ9rH8M6yTyo=;
        b=Y5HMSRjGnvKrHhPljFFJgTni8ERQaWl/CjHZse3ZW73WxlnzK/JSClwtK0/FGfnKPl
         2ZASsWc6+n9DPg1buxZBFggZ69hhDyKJFcdF/MisPwK+vw6oiBFPvGY0D1PlDnCUTni5
         oANewf6+2ljE68I587vOOCKsLmt/EzMry1TauEmDVUCBLROSIR4Y2JyJVxHzQd2g4BsY
         fytGjqzJGNIA2/NNBoK0dsLGIusG6wZjg0MPZyguo0lAkM88zzfvNhlbH9qaz67WuAnS
         Mp1dpmn9pLJdSxeXlVuKpyIrguOSbaW87J5vz3gDdj+hkfQiEFOET1nTA79e7bS71zPy
         ZxKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUq6azEG0RYIhH68heKA04Am1yucRVOvCiKLPNcidBRsbSuphynOwfcKhw1a7PWGLjkoJpjJdHR11z20CiKJtCh@vger.kernel.org
X-Gm-Message-State: AOJu0Yzybnx3o2zO3/F7S8vCpgIOBJ8sRIYExuZ6MN035xnXBf3Qlzw7
	gd76JMdj8v9uDkTQ1z3ZG8BV1RQOQdH9pyV7tpXJRXhPqkZ2c/5MXwnwyBp9h50C/hWS0bZHH6H
	nUbiNuw==
X-Google-Smtp-Source: AGHT+IFNuMReO/chIStJlUvvk+LkUMhF7qnFNrzRzITSnP2mlhqW0sOsowPwW0OTBaOmH6EkTjLF3fwLlmk=
X-Received: from pfmm16.prod.google.com ([2002:a05:6a00:2490:b0:746:3185:144e])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:c96:b0:749:464a:a77b
 with SMTP id d2e1a72fcca58-763349b95e7mr20176257b3a.18.1753776796333; Tue, 29
 Jul 2025 01:13:16 -0700 (PDT)
Date: Tue, 29 Jul 2025 01:12:54 -0700
In-Reply-To: <20250729081256.3433892-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729081256.3433892-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729081256.3433892-2-yuzhuo@google.com>
Subject: [PATCH v1 1/3] tools: Import atomic_fetch_{and,add,sub}
From: Yuzhuo Jing <yuzhuo@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Liang Kan <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yuzhuo Jing <yzj@umich.edu>, Yuzhuo Jing <yuzhuo@google.com>, 
	Guo Ren <guoren@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Import necessary function (atomic_fetch_add) for ticket spinlock
Implementation.  In addition, also import those that pair with the
imported ones (atomic_fetch_sub, atomic_fetch_and).

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/arch/x86/include/asm/atomic.h    | 17 +++++++++
 tools/arch/x86/include/asm/cmpxchg.h   | 11 ++++++
 tools/include/asm-generic/atomic-gcc.h | 51 ++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)

diff --git a/tools/arch/x86/include/asm/atomic.h b/tools/arch/x86/include/asm/atomic.h
index a55ffd4eb5f1..1fb7711ebbd7 100644
--- a/tools/arch/x86/include/asm/atomic.h
+++ b/tools/arch/x86/include/asm/atomic.h
@@ -66,6 +66,14 @@ static inline int atomic_dec_and_test(atomic_t *v)
 	GEN_UNARY_RMWcc(LOCK_PREFIX "decl", v->counter, "%0", "e");
 }
 
+static __always_inline int atomic_fetch_add(int i, atomic_t *v)
+{
+	return xadd(&v->counter, i);
+}
+#define atomic_fetch_add atomic_fetch_add
+
+#define atomic_fetch_sub(i, v) atomic_fetch_add(-(i), v)
+
 static __always_inline int atomic_cmpxchg(atomic_t *v, int old, int new)
 {
 	return cmpxchg(&v->counter, old, new);
@@ -85,6 +93,15 @@ static __always_inline int atomic_fetch_or(int i, atomic_t *v)
 	return val;
 }
 
+static __always_inline int atomic_fetch_and(int i, atomic_t *v)
+{
+	int val = atomic_read(v);
+
+	do { } while (!atomic_try_cmpxchg(v, &val, val & i));
+
+	return val;
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	GEN_BINARY_RMWcc(LOCK_PREFIX __ASM_SIZE(bts), *addr, "Ir", nr, "%0", "c");
diff --git a/tools/arch/x86/include/asm/cmpxchg.h b/tools/arch/x86/include/asm/cmpxchg.h
index 5372da8b27fc..2d89f150badf 100644
--- a/tools/arch/x86/include/asm/cmpxchg.h
+++ b/tools/arch/x86/include/asm/cmpxchg.h
@@ -12,6 +12,8 @@ extern void __xchg_wrong_size(void)
 	__compiletime_error("Bad argument size for xchg");
 extern void __cmpxchg_wrong_size(void)
 	__compiletime_error("Bad argument size for cmpxchg");
+extern void __xadd_wrong_size(void)
+	__compiletime_error("Bad argument size for xadd");
 
 /*
  * Constants for operation sizes. On 32-bit, the 64-bit size it set to
@@ -200,4 +202,13 @@ extern void __cmpxchg_wrong_size(void)
 #define try_cmpxchg(ptr, pold, new) 				\
 	__try_cmpxchg((ptr), (pold), (new), sizeof(*(ptr)))
 
+/*
+ * xadd() adds "inc" to "*ptr" and atomically returns the previous
+ * value of "*ptr".
+ *
+ * xadd() is locked when multiple CPUs are online
+ */
+#define __xadd(ptr, inc, lock)	__xchg_op((ptr), (inc), xadd, lock)
+#define xadd(ptr, inc)		__xadd((ptr), (inc), LOCK_PREFIX)
+
 #endif	/* TOOLS_ASM_X86_CMPXCHG_H */
diff --git a/tools/include/asm-generic/atomic-gcc.h b/tools/include/asm-generic/atomic-gcc.h
index 08b7b3b36873..cc146b82bb34 100644
--- a/tools/include/asm-generic/atomic-gcc.h
+++ b/tools/include/asm-generic/atomic-gcc.h
@@ -100,6 +100,23 @@ atomic_try_cmpxchg(atomic_t *v, int *old, int new)
 	return likely(r == o);
 }
 
+/**
+ * atomic_fetch_and() - atomic bitwise AND with full ordering
+ * @i: int value
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v & @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_and() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_and(int i, atomic_t *v)
+{
+	return __sync_fetch_and_and(&v->counter, i);
+}
+
 /**
  * atomic_fetch_or() - atomic bitwise OR with full ordering
  * @i: int value
@@ -117,6 +134,40 @@ atomic_fetch_or(int i, atomic_t *v)
 	return __sync_fetch_and_or(&v->counter, i);
 }
 
+/**
+ * atomic_fetch_add() - atomic add with full ordering
+ * @i: int value to add
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v + @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_add() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_add(int i, atomic_t *v)
+{
+	return __sync_fetch_and_add(&v->counter, i);
+}
+
+/**
+ * atomic_fetch_sub() - atomic subtract with full ordering
+ * @i: int value to subtract
+ * @v: pointer to atomic_t
+ *
+ * Atomically updates @v to (@v - @i) with full ordering.
+ *
+ * Unsafe to use in noinstr code; use raw_atomic_fetch_sub() there.
+ *
+ * Return: The original value of @v.
+ */
+static __always_inline int
+atomic_fetch_sub(int i, atomic_t *v)
+{
+	return __sync_fetch_and_sub(&v->counter, i);
+}
+
 static inline int test_and_set_bit(long nr, unsigned long *addr)
 {
 	unsigned long mask = BIT_MASK(nr);
-- 
2.50.1.487.gc89ff58d15-goog

