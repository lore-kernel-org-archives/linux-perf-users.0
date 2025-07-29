Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3CF21CA13
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Jul 2025 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753756017; cv=none; b=e2rr5ExIjCwNEIh1XDwfyMK5yiSTJgd9USiRalcwzGXUQw+qDbFCD9x0dQv4hBKjPEnGNP21F8C5wPUv7x2RwEpdNxHRkmoluz3Mghoi785UptQXbvIdL25LtztxxJcm9O9LYy4er60cTdTUyv+g3DXsu6lUmvXlhcMhEh4lmJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753756017; c=relaxed/simple;
	bh=aTizRNpiVqfl4GjPCDh5g3qb75q8oeXtZoPQIbo24no=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=It4VzofCSRUkIhWdIUDVPf47eHq7/odr7OKnxnykIH9qIIGK2tH7Y4PzdSvBft1Y2CescNe4bYFvQnFb7iEm3L+AoXErurIMhcJZYnh/m7vzxvenmYva99Scot76JWDQgGW1tFdL1Ik93lAE2FRR97wL/DfFiNi3V4Ndjr6vomA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUUR5aLN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUUR5aLN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b2fa1a84566so4181536a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Jul 2025 19:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753756013; x=1754360813; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Spz5It1QJWoWrn1v3EPBOJi/HDbSwdDv1z5ubqFy+w=;
        b=wUUR5aLNPRt1A0D4viMdu76XxripHbF042/33c3Gg2HeAJhlu6kCWgCbv43MBYW9F3
         qluQY0VUYJ5YdhbDzxRQhQdpF5KXgUD6hVmTNpyQJuLWOOIUCfnzmG0RDxdCJRrsIdzs
         7XlT/L/vJMbHI+9SbsVDay9qsddU6CT9K8dv/1u5sn7L10wk4qAbktGKqVET3bOAezM6
         V57Qr3yHOtF51tBigDNo6TDTmEguEosIEb8x/Izh2dmkyawPEbKDT+5jf4rrnlO++h2e
         5jK0qpOR84jk2lxEgOdJpdMeosdItslgzwH1Gsf6Kwcg+cHa4DCapT9GmJHetoJoPtJU
         jXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753756013; x=1754360813;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Spz5It1QJWoWrn1v3EPBOJi/HDbSwdDv1z5ubqFy+w=;
        b=EFEQPu2Qb0fj9rTRUp0SnEMRdgPGgVhvbhFfOkNfztJy26cEUH+LIF3RuNJEp9s9Kz
         +hzaEEt5d9zTErBfm2IJPrRaDlzZopOQ74xFpdHls8M/36JLM0qYGm+lnRLQGUZUJkqm
         VXPE/7eMsgkrQoAyWZ2LOsDOvvcV1RxCcukl59SpNvKzO1a2P9O2zVVuJveRiZPI6+T/
         flpvw1SyBxYg6wzL4JrCZS3warnFNVpyClJFhJuJwnWUQBRU1wiWytZivDePUjmlds6R
         7W0BA9CxAh63BElvnqKFw/X5au99ar8mVneaaNnOxEu7HbhIam/e6uPIC3Q/IF9citce
         ii4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU0F5hRZ0UoZW0T9Bz08lgAQd8w0zTBSrz5zP5OUriYxfTcOMuu308abGqWH85zNRB74PpBotHrLajaHcZnrQh8@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOshIg1G6De2M7WKTRd5+VZtRqluL5blUCAHsTsPidpmsxTTM
	/SG+mUEIHxDjYw4Ag5VIUvkStNZwtxOU4YGsilFlIemtJml7pXhgWZIj6ANdxgZAG0VP2e/fjtg
	dMEhWpg==
X-Google-Smtp-Source: AGHT+IEdGaAV1jTffTDfV72LV49nNGl5UBLoYE649qAQR8v15K/pM5MNc8kjrrTcjum/HzqqoHbYQSbR4Hk=
X-Received: from pfbmy24-n2.prod.google.com ([2002:a05:6a00:6d58:20b0:748:df52:fdc5])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a104:b0:1f5:7ba7:69d8
 with SMTP id adf61e73a8af0-23d700480c8mr23190933637.15.1753756013401; Mon, 28
 Jul 2025 19:26:53 -0700 (PDT)
Date: Mon, 28 Jul 2025 19:26:38 -0700
In-Reply-To: <20250729022640.3134066-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729022640.3134066-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250729022640.3134066-6-yuzhuo@google.com>
Subject: [PATCH v1 5/7] perf bench: Import qspinlock from kernel
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

Import the qspinlock implementation from kernel with userland-specific
adaption.  Updated tools/perf/check-headers.sh file to detect kernel file
changes in the future.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 tools/include/linux/compiler_types.h          |   3 +
 .../perf/bench/include/mcs_spinlock-private.h | 115 +++++
 tools/perf/bench/include/mcs_spinlock.h       |  19 +
 tools/perf/bench/include/qspinlock-private.h  | 204 +++++++++
 tools/perf/bench/include/qspinlock.h          | 153 +++++++
 tools/perf/bench/include/qspinlock_types.h    |  98 +++++
 tools/perf/bench/qspinlock.c                  | 411 ++++++++++++++++++
 tools/perf/check-headers.sh                   |  32 ++
 8 files changed, 1035 insertions(+)
 create mode 100644 tools/perf/bench/include/mcs_spinlock-private.h
 create mode 100644 tools/perf/bench/include/mcs_spinlock.h
 create mode 100644 tools/perf/bench/include/qspinlock-private.h
 create mode 100644 tools/perf/bench/include/qspinlock.h
 create mode 100644 tools/perf/bench/include/qspinlock_types.h
 create mode 100644 tools/perf/bench/qspinlock.c

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index 46550c500b8c..261a508ef5bd 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -34,6 +34,9 @@
 /* Per-cpu checker flag does not use address space attribute in userspace */
 #define __percpu
 
+/* Do not change lock sections in user space */
+#define __lockfunc
+
 /*
  * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
  *			       non-scalar types unchanged.
diff --git a/tools/perf/bench/include/mcs_spinlock-private.h b/tools/perf/bench/include/mcs_spinlock-private.h
new file mode 100644
index 000000000000..f9e4bab804db
--- /dev/null
+++ b/tools/perf/bench/include/mcs_spinlock-private.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * MCS lock defines
+ *
+ * This file contains the main data structure and API definitions of MCS lock.
+ *
+ * The MCS lock (proposed by Mellor-Crummey and Scott) is a simple spin-lock
+ * with the desirable properties of being fair, and with each cpu trying
+ * to acquire the lock spinning on a local variable.
+ * It avoids expensive cache bounces that common test-and-set spin-lock
+ * implementations incur.
+ */
+#ifndef __LINUX_MCS_SPINLOCK_H
+#define __LINUX_MCS_SPINLOCK_H
+
+#include <stddef.h>
+#include <linux/atomic.h>
+#include "mcs_spinlock.h"
+
+#ifndef arch_mcs_spin_lock_contended
+/*
+ * Using smp_cond_load_acquire() provides the acquire semantics
+ * required so that subsequent operations happen after the
+ * lock is acquired. Additionally, some architectures such as
+ * ARM64 would like to do spin-waiting instead of purely
+ * spinning, and smp_cond_load_acquire() provides that behavior.
+ */
+#define arch_mcs_spin_lock_contended(l)					\
+	smp_cond_load_acquire(l, VAL)
+#endif
+
+#ifndef arch_mcs_spin_unlock_contended
+/*
+ * smp_store_release() provides a memory barrier to ensure all
+ * operations in the critical section has been completed before
+ * unlocking.
+ */
+#define arch_mcs_spin_unlock_contended(l)				\
+	smp_store_release((l), 1)
+#endif
+
+/*
+ * Note: the smp_load_acquire/smp_store_release pair is not
+ * sufficient to form a full memory barrier across
+ * cpus for many architectures (except x86) for mcs_unlock and mcs_lock.
+ * For applications that need a full barrier across multiple cpus
+ * with mcs_unlock and mcs_lock pair, smp_mb__after_unlock_lock() should be
+ * used after mcs_lock.
+ */
+
+/*
+ * In order to acquire the lock, the caller should declare a local node and
+ * pass a reference of the node to this function in addition to the lock.
+ * If the lock has already been acquired, then this will proceed to spin
+ * on this node->locked until the previous lock holder sets the node->locked
+ * in mcs_spin_unlock().
+ */
+static inline
+void mcs_spin_lock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *prev;
+
+	/* Init node */
+	node->locked = 0;
+	node->next   = NULL;
+
+	/*
+	 * We rely on the full barrier with global transitivity implied by the
+	 * below xchg() to order the initialization stores above against any
+	 * observation of @node. And to provide the ACQUIRE ordering associated
+	 * with a LOCK primitive.
+	 */
+	prev = xchg(lock, node);
+	if (likely(prev == NULL)) {
+		/*
+		 * Lock acquired, don't need to set node->locked to 1. Threads
+		 * only spin on its own node->locked value for lock acquisition.
+		 * However, since this thread can immediately acquire the lock
+		 * and does not proceed to spin on its own node->locked, this
+		 * value won't be used. If a debug mode is needed to
+		 * audit lock status, then set node->locked value here.
+		 */
+		return;
+	}
+	WRITE_ONCE(prev->next, node);
+
+	/* Wait until the lock holder passes the lock down. */
+	arch_mcs_spin_lock_contended(&node->locked);
+}
+
+/*
+ * Releases the lock. The caller should pass in the corresponding node that
+ * was used to acquire the lock.
+ */
+static inline
+void mcs_spin_unlock(struct mcs_spinlock **lock, struct mcs_spinlock *node)
+{
+	struct mcs_spinlock *next = READ_ONCE(node->next);
+
+	if (likely(!next)) {
+		/*
+		 * Release the lock by setting it to NULL
+		 */
+		if (likely(cmpxchg_release(lock, node, NULL) == node))
+			return;
+		/* Wait until the next pointer is set */
+		while (!(next = READ_ONCE(node->next)))
+			cpu_relax();
+	}
+
+	/* Pass lock to next waiter. */
+	arch_mcs_spin_unlock_contended(&next->locked);
+}
+
+#endif /* __LINUX_MCS_SPINLOCK_H */
diff --git a/tools/perf/bench/include/mcs_spinlock.h b/tools/perf/bench/include/mcs_spinlock.h
new file mode 100644
index 000000000000..39c94012b88a
--- /dev/null
+++ b/tools/perf/bench/include/mcs_spinlock.h
@@ -0,0 +1,19 @@
+#ifndef __ASM_MCS_SPINLOCK_H
+#define __ASM_MCS_SPINLOCK_H
+
+struct mcs_spinlock {
+	struct mcs_spinlock *next;
+	int locked; /* 1 if lock acquired */
+	int count;  /* nesting count, see qspinlock.c */
+};
+
+/*
+ * Architectures can define their own:
+ *
+ *   arch_mcs_spin_lock_contended(l)
+ *   arch_mcs_spin_unlock_contended(l)
+ *
+ * See kernel/locking/mcs_spinlock.c.
+ */
+
+#endif /* __ASM_MCS_SPINLOCK_H */
diff --git a/tools/perf/bench/include/qspinlock-private.h b/tools/perf/bench/include/qspinlock-private.h
new file mode 100644
index 000000000000..699f70bac980
--- /dev/null
+++ b/tools/perf/bench/include/qspinlock-private.h
@@ -0,0 +1,204 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Queued spinlock defines
+ *
+ * This file contains macro definitions and functions shared between different
+ * qspinlock slow path implementations.
+ */
+#ifndef __LINUX_QSPINLOCK_H
+#define __LINUX_QSPINLOCK_H
+
+#include <linux/percpu-simulate.h>
+#include <linux/compiler.h>
+#include <linux/compiler_types.h>
+#include <linux/atomic.h>
+#include "qspinlock_types.h"
+#include "mcs_spinlock.h"
+
+#define _Q_MAX_NODES	4
+
+/*
+ * The pending bit spinning loop count.
+ * This heuristic is used to limit the number of lockword accesses
+ * made by atomic_cond_read_relaxed when waiting for the lock to
+ * transition out of the "== _Q_PENDING_VAL" state. We don't spin
+ * indefinitely because there's no guarantee that we'll make forward
+ * progress.
+ */
+#ifndef _Q_PENDING_LOOPS
+#define _Q_PENDING_LOOPS	1
+#endif
+
+/*
+ * On 64-bit architectures, the mcs_spinlock structure will be 16 bytes in
+ * size and four of them will fit nicely in one 64-byte cacheline. For
+ * pvqspinlock, however, we need more space for extra data. To accommodate
+ * that, we insert two more long words to pad it up to 32 bytes. IOW, only
+ * two of them can fit in a cacheline in this case. That is OK as it is rare
+ * to have more than 2 levels of slowpath nesting in actual use. We don't
+ * want to penalize pvqspinlocks to optimize for a rare case in native
+ * qspinlocks.
+ */
+struct qnode {
+	struct mcs_spinlock mcs;
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+	long reserved[2];
+#endif
+};
+
+DECLARE_PER_CPU_ALIGNED(qnodes, struct qnode, qnodes[_Q_MAX_NODES]);
+
+/*
+ * We must be able to distinguish between no-tail and the tail at 0:0,
+ * therefore increment the cpu number by one.
+ */
+
+static inline __pure u32 encode_tail(int cpu, int idx)
+{
+	u32 tail;
+
+	tail  = (cpu + 1) << _Q_TAIL_CPU_OFFSET;
+	tail |= idx << _Q_TAIL_IDX_OFFSET; /* assume < 4 */
+
+	return tail;
+}
+
+static inline __pure struct mcs_spinlock *decode_tail(u32 tail)
+{
+	int cpu = (tail >> _Q_TAIL_CPU_OFFSET) - 1;
+	int idx = (tail &  _Q_TAIL_IDX_MASK) >> _Q_TAIL_IDX_OFFSET;
+
+	return per_cpu_ptr(qnodes, qnodes[idx].mcs, cpu);
+}
+
+static inline __pure
+struct mcs_spinlock *grab_mcs_node(struct mcs_spinlock *base, int idx)
+{
+	return &((struct qnode *)base + idx)->mcs;
+}
+
+#define _Q_LOCKED_PENDING_MASK (_Q_LOCKED_MASK | _Q_PENDING_MASK)
+
+#if _Q_PENDING_BITS == 8
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->pending, 0);
+}
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,0 -> *,0,1
+ *
+ * Lock stealing is not allowed if this function is used.
+ */
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
+}
+
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else /* _Q_PENDING_BITS == 8 */
+
+/**
+ * clear_pending - clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,* -> *,0,*
+ */
+static __always_inline void clear_pending(struct qspinlock *lock)
+{
+	atomic_andnot(_Q_PENDING_VAL, &lock->val);
+}
+
+/**
+ * clear_pending_set_locked - take ownership and clear the pending bit.
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,1,0 -> *,0,1
+ */
+static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
+{
+	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
+}
+
+/**
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail)
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	u32 old, new;
+
+	old = atomic_read(&lock->val);
+	do {
+		new = (old & _Q_LOCKED_PENDING_MASK) | tail;
+		/*
+		 * We can use relaxed semantics since the caller ensures that
+		 * the MCS node is properly initialized before updating the
+		 * tail.
+		 */
+	} while (!atomic_try_cmpxchg_relaxed(&lock->val, &old, new));
+
+	return old;
+}
+#endif /* _Q_PENDING_BITS == 8 */
+
+/**
+ * queued_fetch_set_pending_acquire - fetch the whole lock value and set pending
+ * @lock : Pointer to queued spinlock structure
+ * Return: The previous lock value
+ *
+ * *,*,* -> *,1,*
+ */
+#ifndef queued_fetch_set_pending_acquire
+static __always_inline u32 queued_fetch_set_pending_acquire(struct qspinlock *lock)
+{
+	return atomic_fetch_or_acquire(_Q_PENDING_VAL, &lock->val);
+}
+#endif
+
+/**
+ * set_locked - Set the lock bit and own the lock
+ * @lock: Pointer to queued spinlock structure
+ *
+ * *,*,0 -> *,0,1
+ */
+static __always_inline void set_locked(struct qspinlock *lock)
+{
+	WRITE_ONCE(lock->locked, _Q_LOCKED_VAL);
+}
+
+#endif /* __LINUX_QSPINLOCK_H */
diff --git a/tools/perf/bench/include/qspinlock.h b/tools/perf/bench/include/qspinlock.h
new file mode 100644
index 000000000000..2c5b00121929
--- /dev/null
+++ b/tools/perf/bench/include/qspinlock.h
@@ -0,0 +1,153 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Queued spinlock
+ *
+ * A 'generic' spinlock implementation that is based on MCS locks. For an
+ * architecture that's looking for a 'generic' spinlock, please first consider
+ * ticket-lock.h and only come looking here when you've considered all the
+ * constraints below and can show your hardware does actually perform better
+ * with qspinlock.
+ *
+ * qspinlock relies on atomic_*_release()/atomic_*_acquire() to be RCsc (or no
+ * weaker than RCtso if you're power), where regular code only expects atomic_t
+ * to be RCpc.
+ *
+ * qspinlock relies on a far greater (compared to asm-generic/spinlock.h) set
+ * of atomic operations to behave well together, please audit them carefully to
+ * ensure they all have forward progress. Many atomic operations may default to
+ * cmpxchg() loops which will not have good forward progress properties on
+ * LL/SC architectures.
+ *
+ * One notable example is atomic_fetch_or_acquire(), which x86 cannot (cheaply)
+ * do. Carefully read the patches that introduced
+ * queued_fetch_set_pending_acquire().
+ *
+ * qspinlock also heavily relies on mixed size atomic operations, in specific
+ * it requires architectures to have xchg16; something which many LL/SC
+ * architectures need to implement as a 32bit and+or in order to satisfy the
+ * forward progress guarantees mentioned above.
+ *
+ * Further reading on mixed size atomics that might be relevant:
+ *
+ *   http://www.cl.cam.ac.uk/~pes20/popl17/mixed-size.pdf
+ *
+ * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
+ * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
+ *
+ * Authors: Waiman Long <waiman.long@hpe.com>
+ */
+#ifndef __ASM_GENERIC_QSPINLOCK_H
+#define __ASM_GENERIC_QSPINLOCK_H
+
+#include "qspinlock_types.h"
+#include <linux/atomic.h>
+#include <asm/barrier.h>
+
+#ifndef queued_spin_is_locked
+/**
+ * queued_spin_is_locked - is the spinlock locked?
+ * @lock: Pointer to queued spinlock structure
+ * Return: 1 if it is locked, 0 otherwise
+ */
+static __always_inline int queued_spin_is_locked(struct qspinlock *lock)
+{
+	/*
+	 * Any !0 state indicates it is locked, even if _Q_LOCKED_VAL
+	 * isn't immediately observable.
+	 */
+	return atomic_read(&lock->val);
+}
+#endif
+
+/**
+ * queued_spin_value_unlocked - is the spinlock structure unlocked?
+ * @lock: queued spinlock structure
+ * Return: 1 if it is unlocked, 0 otherwise
+ *
+ * N.B. Whenever there are tasks waiting for the lock, it is considered
+ *      locked wrt the lockref code to avoid lock stealing by the lockref
+ *      code and change things underneath the lock. This also allows some
+ *      optimizations to be applied without conflict with lockref.
+ */
+static __always_inline int queued_spin_value_unlocked(struct qspinlock lock)
+{
+	return !lock.val.counter;
+}
+
+/**
+ * queued_spin_is_contended - check if the lock is contended
+ * @lock : Pointer to queued spinlock structure
+ * Return: 1 if lock contended, 0 otherwise
+ */
+static __always_inline int queued_spin_is_contended(struct qspinlock *lock)
+{
+	return atomic_read(&lock->val) & ~_Q_LOCKED_MASK;
+}
+/**
+ * queued_spin_trylock - try to acquire the queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ * Return: 1 if lock acquired, 0 if failed
+ */
+static __always_inline int queued_spin_trylock(struct qspinlock *lock)
+{
+	int val = atomic_read(&lock->val);
+
+	if (unlikely(val))
+		return 0;
+
+	return likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL));
+}
+
+extern void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val);
+
+#ifndef queued_spin_lock
+/**
+ * queued_spin_lock - acquire a queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ */
+static __always_inline void queued_spin_lock(struct qspinlock *lock)
+{
+	int val = 0;
+
+	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
+		return;
+
+	queued_spin_lock_slowpath(lock, val);
+}
+#endif
+
+#ifndef queued_spin_unlock
+/**
+ * queued_spin_unlock - release a queued spinlock
+ * @lock : Pointer to queued spinlock structure
+ */
+static __always_inline void queued_spin_unlock(struct qspinlock *lock)
+{
+	/*
+	 * unlock() needs release semantics:
+	 */
+	smp_store_release(&lock->locked, 0);
+}
+#endif
+
+#ifndef virt_spin_lock
+static __always_inline bool virt_spin_lock(struct qspinlock *lock __maybe_unused)
+{
+	return false;
+}
+#endif
+
+#ifndef __no_arch_spinlock_redefine
+/*
+ * Remapping spinlock architecture specific functions to the corresponding
+ * queued spinlock functions.
+ */
+#define arch_spin_is_locked(l)		queued_spin_is_locked(l)
+#define arch_spin_is_contended(l)	queued_spin_is_contended(l)
+#define arch_spin_value_unlocked(l)	queued_spin_value_unlocked(l)
+#define arch_spin_lock(l)		queued_spin_lock(l)
+#define arch_spin_trylock(l)		queued_spin_trylock(l)
+#define arch_spin_unlock(l)		queued_spin_unlock(l)
+#endif
+
+#endif /* __ASM_GENERIC_QSPINLOCK_H */
diff --git a/tools/perf/bench/include/qspinlock_types.h b/tools/perf/bench/include/qspinlock_types.h
new file mode 100644
index 000000000000..93a959689070
--- /dev/null
+++ b/tools/perf/bench/include/qspinlock_types.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Queued spinlock
+ *
+ * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
+ *
+ * Authors: Waiman Long <waiman.long@hp.com>
+ */
+#ifndef __ASM_GENERIC_QSPINLOCK_TYPES_H
+#define __ASM_GENERIC_QSPINLOCK_TYPES_H
+
+#include <linux/percpu-simulate.h>
+#include <linux/types.h>
+
+#define CONFIG_NR_CPUS PERCPU_MAX
+
+typedef struct qspinlock {
+	union {
+		atomic_t val;
+
+		/*
+		 * By using the whole 2nd least significant byte for the
+		 * pending bit, we can allow better optimization of the lock
+		 * acquisition for the pending bit holder.
+		 */
+#ifdef __LITTLE_ENDIAN
+		struct {
+			u8	locked;
+			u8	pending;
+		};
+		struct {
+			u16	locked_pending;
+			u16	tail;
+		};
+#else
+		struct {
+			u16	tail;
+			u16	locked_pending;
+		};
+		struct {
+			u8	reserved[2];
+			u8	pending;
+			u8	locked;
+		};
+#endif
+	};
+} arch_spinlock_t;
+
+/*
+ * Initializier
+ */
+#define	__ARCH_SPIN_LOCK_UNLOCKED	{ { .val = ATOMIC_INIT(0) } }
+
+/*
+ * Bitfields in the atomic value:
+ *
+ * When NR_CPUS < 16K
+ *  0- 7: locked byte
+ *     8: pending
+ *  9-15: not used
+ * 16-17: tail index
+ * 18-31: tail cpu (+1)
+ *
+ * When NR_CPUS >= 16K
+ *  0- 7: locked byte
+ *     8: pending
+ *  9-10: tail index
+ * 11-31: tail cpu (+1)
+ */
+#define	_Q_SET_MASK(type)	(((1U << _Q_ ## type ## _BITS) - 1)\
+				      << _Q_ ## type ## _OFFSET)
+#define _Q_LOCKED_OFFSET	0
+#define _Q_LOCKED_BITS		8
+#define _Q_LOCKED_MASK		_Q_SET_MASK(LOCKED)
+
+#define _Q_PENDING_OFFSET	(_Q_LOCKED_OFFSET + _Q_LOCKED_BITS)
+#if CONFIG_NR_CPUS < (1U << 14)
+#define _Q_PENDING_BITS		8
+#else
+#define _Q_PENDING_BITS		1
+#endif
+#define _Q_PENDING_MASK		_Q_SET_MASK(PENDING)
+
+#define _Q_TAIL_IDX_OFFSET	(_Q_PENDING_OFFSET + _Q_PENDING_BITS)
+#define _Q_TAIL_IDX_BITS	2
+#define _Q_TAIL_IDX_MASK	_Q_SET_MASK(TAIL_IDX)
+
+#define _Q_TAIL_CPU_OFFSET	(_Q_TAIL_IDX_OFFSET + _Q_TAIL_IDX_BITS)
+#define _Q_TAIL_CPU_BITS	(32 - _Q_TAIL_CPU_OFFSET)
+#define _Q_TAIL_CPU_MASK	_Q_SET_MASK(TAIL_CPU)
+
+#define _Q_TAIL_OFFSET		_Q_TAIL_IDX_OFFSET
+#define _Q_TAIL_MASK		(_Q_TAIL_IDX_MASK | _Q_TAIL_CPU_MASK)
+
+#define _Q_LOCKED_VAL		(1U << _Q_LOCKED_OFFSET)
+#define _Q_PENDING_VAL		(1U << _Q_PENDING_OFFSET)
+
+#endif /* __ASM_GENERIC_QSPINLOCK_TYPES_H */
diff --git a/tools/perf/bench/qspinlock.c b/tools/perf/bench/qspinlock.c
new file mode 100644
index 000000000000..b678dd16b059
--- /dev/null
+++ b/tools/perf/bench/qspinlock.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Queued spinlock
+ *
+ * (C) Copyright 2013-2015 Hewlett-Packard Development Company, L.P.
+ * (C) Copyright 2013-2014,2018 Red Hat, Inc.
+ * (C) Copyright 2015 Intel Corp.
+ * (C) Copyright 2015 Hewlett-Packard Enterprise Development LP
+ *
+ * Authors: Waiman Long <longman@redhat.com>
+ *          Peter Zijlstra <peterz@infradead.org>
+ */
+
+#ifndef _GEN_PV_LOCK_SLOWPATH
+
+#include <linux/build_bug.h>
+#include <linux/percpu-simulate.h>
+#include <linux/atomic.h>
+#include <linux/prefetch.h>
+#include <asm/byteorder.h>
+#include "include/qspinlock.h"
+
+#define lockevent_inc(x) ({})
+#define lockevent_cond_inc(x, y) ({})
+#define trace_contention_begin(x, y) ({})
+#define trace_contention_end(x, y) ({})
+
+#define smp_processor_id get_this_cpu_id
+
+/*
+ * Include queued spinlock definitions and statistics code
+ */
+#include "include/qspinlock-private.h"
+
+/*
+ * The basic principle of a queue-based spinlock can best be understood
+ * by studying a classic queue-based spinlock implementation called the
+ * MCS lock. A copy of the original MCS lock paper ("Algorithms for Scalable
+ * Synchronization on Shared-Memory Multiprocessors by Mellor-Crummey and
+ * Scott") is available at
+ *
+ * https://bugzilla.kernel.org/show_bug.cgi?id=206115
+ *
+ * This queued spinlock implementation is based on the MCS lock, however to
+ * make it fit the 4 bytes we assume spinlock_t to be, and preserve its
+ * existing API, we must modify it somehow.
+ *
+ * In particular; where the traditional MCS lock consists of a tail pointer
+ * (8 bytes) and needs the next pointer (another 8 bytes) of its own node to
+ * unlock the next pending (next->locked), we compress both these: {tail,
+ * next->locked} into a single u32 value.
+ *
+ * Since a spinlock disables recursion of its own context and there is a limit
+ * to the contexts that can nest; namely: task, softirq, hardirq, nmi. As there
+ * are at most 4 nesting levels, it can be encoded by a 2-bit number. Now
+ * we can encode the tail by combining the 2-bit nesting level with the cpu
+ * number. With one byte for the lock value and 3 bytes for the tail, only a
+ * 32-bit word is now needed. Even though we only need 1 bit for the lock,
+ * we extend it to a full byte to achieve better performance for architectures
+ * that support atomic byte write.
+ *
+ * We also change the first spinner to spin on the lock bit instead of its
+ * node; whereby avoiding the need to carry a node from lock to unlock, and
+ * preserving existing lock API. This also makes the unlock code simpler and
+ * faster.
+ *
+ * N.B. The current implementation only supports architectures that allow
+ *      atomic operations on smaller 8-bit and 16-bit data types.
+ *
+ */
+
+#include "include/mcs_spinlock-private.h"
+
+/*
+ * Per-CPU queue node structures; we can never have more than 4 nested
+ * contexts: task, softirq, hardirq, nmi.
+ *
+ * Exactly fits one 64-byte cacheline on a 64-bit architecture.
+ *
+ * PV doubles the storage and uses the second cacheline for PV state.
+ */
+DEFINE_PER_CPU_ALIGNED(qnodes);
+
+/*
+ * Generate the native code for queued_spin_unlock_slowpath(); provide NOPs for
+ * all the PV callbacks.
+ */
+
+static __always_inline void __pv_init_node(struct mcs_spinlock *node __maybe_unused) { }
+static __always_inline void __pv_wait_node(struct mcs_spinlock *node __maybe_unused,
+					   struct mcs_spinlock *prev __maybe_unused) { }
+static __always_inline void __pv_kick_node(struct qspinlock *lock __maybe_unused,
+					   struct mcs_spinlock *node __maybe_unused) { }
+static __always_inline u32  __pv_wait_head_or_lock(struct qspinlock *lock __maybe_unused,
+						   struct mcs_spinlock *node __maybe_unused)
+						   { return 0; }
+
+#define pv_enabled()		false
+
+#define pv_init_node		__pv_init_node
+#define pv_wait_node		__pv_wait_node
+#define pv_kick_node		__pv_kick_node
+#define pv_wait_head_or_lock	__pv_wait_head_or_lock
+
+#ifdef CONFIG_PARAVIRT_SPINLOCKS
+#define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
+#endif
+
+#endif /* _GEN_PV_LOCK_SLOWPATH */
+
+/**
+ * queued_spin_lock_slowpath - acquire the queued spinlock
+ * @lock: Pointer to queued spinlock structure
+ * @val: Current value of the queued spinlock 32-bit word
+ *
+ * (queue tail, pending bit, lock value)
+ *
+ *              fast     :    slow                                  :    unlock
+ *                       :                                          :
+ * uncontended  (0,0,0) -:--> (0,0,1) ------------------------------:--> (*,*,0)
+ *                       :       | ^--------.------.             /  :
+ *                       :       v           \      \            |  :
+ * pending               :    (0,1,1) +--> (0,1,0)   \           |  :
+ *                       :       | ^--'              |           |  :
+ *                       :       v                   |           |  :
+ * uncontended           :    (n,x,y) +--> (n,0,0) --'           |  :
+ *   queue               :       | ^--'                          |  :
+ *                       :       v                               |  :
+ * contended             :    (*,x,y) +--> (*,0,0) ---> (*,0,1) -'  :
+ *   queue               :         ^--'                             :
+ */
+void __lockfunc queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
+{
+	struct mcs_spinlock *prev, *next, *node;
+	u32 old, tail;
+	int idx;
+
+	BUILD_BUG_ON(CONFIG_NR_CPUS >= (1U << _Q_TAIL_CPU_BITS));
+
+	if (pv_enabled())
+		goto pv_queue;
+
+	if (virt_spin_lock(lock))
+		return;
+
+	/*
+	 * Wait for in-progress pending->locked hand-overs with a bounded
+	 * number of spins so that we guarantee forward progress.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	if (val == _Q_PENDING_VAL) {
+		int cnt = _Q_PENDING_LOOPS;
+		val = atomic_cond_read_relaxed(&lock->val,
+					       (VAL != _Q_PENDING_VAL) || !cnt--);
+	}
+
+	/*
+	 * If we observe any contention; queue.
+	 */
+	if (val & ~_Q_LOCKED_MASK)
+		goto queue;
+
+	/*
+	 * trylock || pending
+	 *
+	 * 0,0,* -> 0,1,* -> 0,0,1 pending, trylock
+	 */
+	val = queued_fetch_set_pending_acquire(lock);
+
+	/*
+	 * If we observe contention, there is a concurrent locker.
+	 *
+	 * Undo and queue; our setting of PENDING might have made the
+	 * n,0,0 -> 0,0,0 transition fail and it will now be waiting
+	 * on @next to become !NULL.
+	 */
+	if (unlikely(val & ~_Q_LOCKED_MASK)) {
+
+		/* Undo PENDING if we set it. */
+		if (!(val & _Q_PENDING_MASK))
+			clear_pending(lock);
+
+		goto queue;
+	}
+
+	/*
+	 * We're pending, wait for the owner to go away.
+	 *
+	 * 0,1,1 -> *,1,0
+	 *
+	 * this wait loop must be a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because not all
+	 * clear_pending_set_locked() implementations imply full
+	 * barriers.
+	 */
+	if (val & _Q_LOCKED_MASK)
+		smp_cond_load_acquire(&lock->locked, !VAL);
+
+	/*
+	 * take ownership and clear the pending bit.
+	 *
+	 * 0,1,0 -> 0,0,1
+	 */
+	clear_pending_set_locked(lock);
+	lockevent_inc(lock_pending);
+	return;
+
+	/*
+	 * End of pending bit optimistic spinning and beginning of MCS
+	 * queuing.
+	 */
+queue:
+	lockevent_inc(lock_slowpath);
+pv_queue:
+	node = this_cpu_ptr(qnodes, qnodes[0].mcs);
+	idx = node->count++;
+	tail = encode_tail(smp_processor_id(), idx);
+
+	trace_contention_begin(lock, LCB_F_SPIN);
+
+	/*
+	 * 4 nodes are allocated based on the assumption that there will
+	 * not be nested NMIs taking spinlocks. That may not be true in
+	 * some architectures even though the chance of needing more than
+	 * 4 nodes will still be extremely unlikely. When that happens,
+	 * we fall back to spinning on the lock directly without using
+	 * any MCS node. This is not the most elegant solution, but is
+	 * simple enough.
+	 */
+	if (unlikely(idx >= _Q_MAX_NODES)) {
+		lockevent_inc(lock_no_node);
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		goto release;
+	}
+
+	node = grab_mcs_node(node, idx);
+
+	/*
+	 * Keep counts of non-zero index values:
+	 */
+	lockevent_cond_inc(lock_use_node2 + idx - 1, idx);
+
+	/*
+	 * Ensure that we increment the head node->count before initialising
+	 * the actual node. If the compiler is kind enough to reorder these
+	 * stores, then an IRQ could overwrite our assignments.
+	 */
+	barrier();
+
+	node->locked = 0;
+	node->next = NULL;
+	pv_init_node(node);
+
+	/*
+	 * We touched a (possibly) cold cacheline in the per-cpu queue node;
+	 * attempt the trylock once more in the hope someone let go while we
+	 * weren't watching.
+	 */
+	if (queued_spin_trylock(lock))
+		goto release;
+
+	/*
+	 * Ensure that the initialisation of @node is complete before we
+	 * publish the updated tail via xchg_tail() and potentially link
+	 * @node into the waitqueue via WRITE_ONCE(prev->next, node) below.
+	 */
+	smp_wmb();
+
+	/*
+	 * Publish the updated tail.
+	 * We have already touched the queueing cacheline; don't bother with
+	 * pending stuff.
+	 *
+	 * p,*,* -> n,*,*
+	 */
+	old = xchg_tail(lock, tail);
+	next = NULL;
+
+	/*
+	 * if there was a previous node; link it and wait until reaching the
+	 * head of the waitqueue.
+	 */
+	if (old & _Q_TAIL_MASK) {
+		prev = decode_tail(old);
+
+		/* Link @node into the waitqueue. */
+		WRITE_ONCE(prev->next, node);
+
+		pv_wait_node(node, prev);
+		arch_mcs_spin_lock_contended(&node->locked);
+
+		/*
+		 * While waiting for the MCS lock, the next pointer may have
+		 * been set by another lock waiter. We optimistically load
+		 * the next pointer & prefetch the cacheline for writing
+		 * to reduce latency in the upcoming MCS unlock operation.
+		 */
+		next = READ_ONCE(node->next);
+		if (next)
+			prefetchw(next);
+	}
+
+	/*
+	 * we're at the head of the waitqueue, wait for the owner & pending to
+	 * go away.
+	 *
+	 * *,x,y -> *,0,0
+	 *
+	 * this wait loop must use a load-acquire such that we match the
+	 * store-release that clears the locked bit and create lock
+	 * sequentiality; this is because the set_locked() function below
+	 * does not imply a full barrier.
+	 *
+	 * The PV pv_wait_head_or_lock function, if active, will acquire
+	 * the lock and return a non-zero value. So we have to skip the
+	 * atomic_cond_read_acquire() call. As the next PV queue head hasn't
+	 * been designated yet, there is no way for the locked value to become
+	 * _Q_SLOW_VAL. So both the set_locked() and the
+	 * atomic_cmpxchg_relaxed() calls will be safe.
+	 *
+	 * If PV isn't active, 0 will be returned instead.
+	 *
+	 */
+	if ((val = pv_wait_head_or_lock(lock, node)))
+		goto locked;
+
+	val = atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK));
+
+locked:
+	/*
+	 * claim the lock:
+	 *
+	 * n,0,0 -> 0,0,1 : lock, uncontended
+	 * *,*,0 -> *,*,1 : lock, contended
+	 *
+	 * If the queue head is the only one in the queue (lock value == tail)
+	 * and nobody is pending, clear the tail code and grab the lock.
+	 * Otherwise, we only need to grab the lock.
+	 */
+
+	/*
+	 * In the PV case we might already have _Q_LOCKED_VAL set, because
+	 * of lock stealing; therefore we must also allow:
+	 *
+	 * n,0,1 -> 0,0,1
+	 *
+	 * Note: at this point: (val & _Q_PENDING_MASK) == 0, because of the
+	 *       above wait condition, therefore any concurrent setting of
+	 *       PENDING will make the uncontended transition fail.
+	 */
+	if ((val & _Q_TAIL_MASK) == tail) {
+		if (atomic_try_cmpxchg_relaxed(&lock->val, (int *)&val, _Q_LOCKED_VAL))
+			goto release; /* No contention */
+	}
+
+	/*
+	 * Either somebody is queued behind us or _Q_PENDING_VAL got set
+	 * which will then detect the remaining tail and queue behind us
+	 * ensuring we'll see a @next.
+	 */
+	set_locked(lock);
+
+	/*
+	 * contended path; wait for next if not observed yet, release.
+	 */
+	if (!next)
+		next = smp_cond_load_relaxed(&node->next, (VAL));
+
+	arch_mcs_spin_unlock_contended(&next->locked);
+	pv_kick_node(lock, next);
+
+release:
+	trace_contention_end(lock, 0);
+
+	/*
+	 * release the node
+	 */
+	__this_cpu_dec(qnodes, qnodes[0].mcs.count);
+}
+
+/*
+ * Generate the paravirt code for queued_spin_unlock_slowpath().
+ */
+#if !defined(_GEN_PV_LOCK_SLOWPATH) && defined(CONFIG_PARAVIRT_SPINLOCKS)
+#define _GEN_PV_LOCK_SLOWPATH
+
+#undef  pv_enabled
+#define pv_enabled()	true
+
+#undef pv_init_node
+#undef pv_wait_node
+#undef pv_kick_node
+#undef pv_wait_head_or_lock
+
+#undef  queued_spin_lock_slowpath
+#define queued_spin_lock_slowpath	__pv_queued_spin_lock_slowpath
+
+#include "qspinlock_paravirt.h"
+#include "qspinlock.c"
+
+bool nopvspin;
+static __init int parse_nopvspin(char *arg)
+{
+	nopvspin = true;
+	return 0;
+}
+early_param("nopvspin", parse_nopvspin);
+#endif
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index be519c433ce4..b827b10e19c1 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -118,6 +118,25 @@ check_2 () {
   fi
 }
 
+check_2_sed () {
+  tools_file=$1
+  orig_file=$2
+  sed_cmd="$3"
+
+  shift
+  shift
+  shift
+
+  cmd="diff $* <(sed '$sed_cmd' $tools_file) $orig_file > /dev/null"
+
+  if [ -f "$orig_file" ] && ! eval "$cmd"
+  then
+    FAILURES+=(
+      "$tools_file $orig_file"
+    )
+  fi
+}
+
 check () {
   file=$1
 
@@ -207,6 +226,19 @@ check_2 tools/perf/arch/parisc/entry/syscalls/syscall.tbl arch/parisc/entry/sysc
 check_2 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl arch/arm64/entry/syscalls/syscall_32.tbl
 check_2 tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl arch/arm64/entry/syscalls/syscall_64.tbl
 
+# diff qspinlock files
+qsl_sed='s/ __maybe_unused//'
+qsl_common='-I "^#include" -I __percpu -I this_cpu_ -I per_cpu_ -I decode_tail \
+	-I DECLARE_PER_CPU_ALIGNED -I DEFINE_PER_CPU_ALIGNED -I CONFIG_NR_CPUS -B'
+check_2_sed tools/perf/bench/include/qspinlock.h	include/asm-generic/qspinlock.h "$qsl_sed" "$qsl_common"
+check_2 tools/perf/bench/include/qspinlock_types.h	include/asm-generic/qspinlock_types.h "$qsl_common"
+check_2 tools/perf/bench/include/mcs_spinlock.h		include/asm-generic/mcs_spinlock.h
+check_2 tools/perf/bench/include/qspinlock-private.h	kernel/locking/qspinlock.h	"$qsl_common"
+check_2 tools/perf/bench/include/mcs_spinlock-private.h	kernel/locking/mcs_spinlock.h	"$qsl_common"
+check_2_sed tools/perf/bench/qspinlock.c		kernel/locking/qspinlock.c	"$qsl_sed" \
+	"$qsl_common"' -I EXPORT_SYMBOL -I "^#define lockevent_" -I "^#define trace_" \
+        -I smp_processor_id -I atomic_try_cmpxchg_relaxed'
+
 for i in "${BEAUTY_FILES[@]}"
 do
   beauty_check "$i" -B
-- 
2.50.1.487.gc89ff58d15-goog

