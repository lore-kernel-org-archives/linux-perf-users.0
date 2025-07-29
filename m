Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F87202998
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756010; cv=none; b=u2WHm0jrAraeNG7JWhBMiiM66NXeCO6OTUcN/yvM8fvWAKe6uWUIcmVIr8RI0qpSBmOu3/2V//hpamlUVE0Rk6q7u1ROOIhsHEEC9EeTSk/cP0UUPCSRmWnAyPRU6VQZXkElipaM0rGbFhRpe/zv8VKyNeR4ZMaQBktF0OX0G/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756010; c=relaxed/simple;
	bh=4ISGW0qCLPw0BM53+WZj1UO7Eu/DiHDQi040hwtDTro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=d2o2a1QtuktGsGSCwbquI5OcpDtmh92Ho6hKVXVq6ASYYkc9GyQoz3iGyQtPsUNwEY++hRFLsLy8nLmK+qShc1T5PuVkKKRcyEJBT2chk6piShKspJtS0VfVz2SMi4FY7/DSuaxrwbNok6+b9bRZXaHcFFsQpukzKdy2NenJnDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvy3uJGj; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvy3uJGj"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23ffd934201so19792385ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756008; x=1754360808; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZDFdixHdB12wePHGCdlmdShiJsvmZbe+2EaeGSxRAI=;
        b=yvy3uJGjVeSFxfka0z1c0zQiLzmtMvwka3ld+dW61JGQdNKt+rPtw2RRh0s5zkj7vB
         TBiB2Wkdp7NlJv0AwYrY8jby+27RbFo6+QsLLaBQu2BL4Sr3axPH6F8WuG2vyEZr2Ze6
         leFFoYnXCNCcMUe4j1dSPmZYx+qtDvYMn0UQepywD+Dt0zI2BJROOGC1dUUGuT36GnKN
         9xyTVl0q3pTGTjg+W8ODZbLVUJVYPDBYqipjkCJisMLnl66wlT9L7GLcjXgS5uVavXQV
         JggyLiBGICQHWGtSPSmyAA3wKYcCc0ri9yaSW3McrCdgmZK8JFd6PDFGkEMky/MkxKSY
         oB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756008; x=1754360808;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZDFdixHdB12wePHGCdlmdShiJsvmZbe+2EaeGSxRAI=;
        b=VrcXSHKEpslVhloDyuD4XnNDLx9yY911Klm1v0orcMxUC1GjEzQbMcu5GT072f/Ro3
         FGNPar2vJa10AU6KsnYm8bQ9qm2XHFfIIMQ5rkbd+c17RbdCvl/ady6tIZJF3A082ykb
         4Iya0Gfa4zg9hkk0h3yGqsCiw/nEV26CY+7tbmAWOv1FJ0ZB+ylaKlUP7Jjv9CZ9XjuW
         I8BBQYVUVx/LA7Hfj8VoCfcinHusZBbxZFUswg+Sxb8pP0kRB05oIgAnf2AkQvsuliEO
         8TI9UD32kPAyXSllefhfO+AzdoIbbLxoYNIDdS/oO6yPSJ5EXQnPkL0Sz3yBqw4mxyaY
         qCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3IBGZkA8sWYBSqDloTRLVtPJtbR/9uStTCFawhYygPWjMen8IiKroLF3MbvvxaJbaqrN9XsEHaAYW8ZoZKAvX@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TfGDm2tuL8Q/0qeXq2EnMS7B1eleblWCj9W44MX2MXgKEig4
	AryvrlPXk5Q3hmmMMkOugu3l3gWNQ+gKmLf8dfr1K+mEBj2F0zlJNkuQn4MHoS81YHTfbGJWAh4
	uNeyscg==
X-Google-Smtp-Source: AGHT+IGT/z+KJFAljNSW6NANlfZq/RIKeylnOweKpxXQz/9KYWN22xeESvB+lMHSNFQTjy3lnaZ3WI8wSiY=
X-Received: from plbme16.prod.google.com ([2002:a17:902:fc50:b0:23f:8c3f:e0fc])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f54c:b0:240:71a5:f30
 with SMTP id d9443c01a7336-24071a51d35mr8329275ad.22.1753756008099; Mon, 28
 Jul 2025 19:26:48 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:35 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-3-yuzhuo@google.com>
Subject: [PATCH v1 2/7] tools: Import smp_cond_load and atomic_cond_read
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

Import generic barrier implementation of smp_cond_load_{acquire,relaxed}
and import macro definitions of atomic_cond_read_{acquire,relaxed}.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/asm/barrier.h  | 58 ++++++++++++++++++++++++++++++++++++
 tools/include/linux/atomic.h |  3 ++
 2 files changed, 61 insertions(+)

diff --git a/tools/include/asm/barrier.h b/tools/include/asm/barrier.h
index 0c21678ac5e6..5150c955c1c9 100644
--- a/tools/include/asm/barrier.h
+++ b/tools/include/asm/barrier.h
@@ -63,3 +63,61 @@ do {						\
 	___p1;					\
 })
 #endif
+
+#ifndef cpu_relax
+#define cpu_relax() ({})
+#endif
+
+/**
+ * smp_acquire__after_ctrl_dep() - Provide ACQUIRE ordering after a control dependency
+ *
+ * A control dependency provides a LOAD->STORE order, the additional RMB
+ * provides LOAD->LOAD order, together they provide LOAD->{LOAD,STORE} order,
+ * aka. (load)-ACQUIRE.
+ *
+ * Architectures that do not do load speculation can have this be barrier().
+ */
+#ifndef smp_acquire__after_ctrl_dep
+#define smp_acquire__after_ctrl_dep()		smp_rmb()
+#endif
+
+/**
+ * smp_cond_load_relaxed() - (Spin) wait for cond with no ordering guarantees
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ *
+ * Due to C lacking lambda expressions we load the value of *ptr into a
+ * pre-named variable @VAL to be used in @cond.
+ */
+#ifndef smp_cond_load_relaxed
+#define smp_cond_load_relaxed(ptr, cond_expr) ({		\
+	typeof(ptr) __PTR = (ptr);				\
+	__unqual_scalar_typeof(*ptr) VAL;			\
+	for (;;) {						\
+		VAL = READ_ONCE(*__PTR);			\
+		if (cond_expr)					\
+			break;					\
+		cpu_relax();					\
+	}							\
+	(typeof(*ptr))VAL;					\
+})
+#endif
+
+/**
+ * smp_cond_load_acquire() - (Spin) wait for cond with ACQUIRE ordering
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ *
+ * Equivalent to using smp_load_acquire() on the condition variable but employs
+ * the control dependency of the wait to reduce the barrier on many platforms.
+ */
+#ifndef smp_cond_load_acquire
+#define smp_cond_load_acquire(ptr, cond_expr) ({		\
+	__unqual_scalar_typeof(*ptr) _val;			\
+	_val = smp_cond_load_relaxed(ptr, cond_expr);		\
+	smp_acquire__after_ctrl_dep();				\
+	(typeof(*ptr))_val;					\
+})
+#endif
diff --git a/tools/include/linux/atomic.h b/tools/include/linux/atomic.h
index 332a34177995..6baee2c41b55 100644
--- a/tools/include/linux/atomic.h
+++ b/tools/include/linux/atomic.h
@@ -36,4 +36,7 @@ void atomic_long_set(atomic_long_t *v, long i);
 #define cmpxchg_release		cmpxchg
 #endif
 
+#define atomic_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
+#define atomic_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
+
 #endif /* __TOOLS_LINUX_ATOMIC_H */
-- 
2.50.1.487.gc89ff58d15-goog

