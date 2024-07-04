Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A055F1B3F22;
	Thu,  4 Jul 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112675; cv=none; b=rAOA8+mzrRmRBkbrGJdjU4iYB19uJ7Kp2dZYFEo1qG9pft8Cuo99BDVS5fuPvdFopjyzQSQwF8QNy3m66PIcctGnhA8SqvHyE5kJTwWMTuSbMbNowV3u823rnOxHfSISnIO9vLgzWmYn/q/1+ejpoRU/Vu6ulAygiih1s7MZqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112675; c=relaxed/simple;
	bh=7Qm+cOVAwIQaBTwwWubJEe9rJl3c3MGGBcBHZMgHC68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4yQrN3rTlF22ou+e3DjGTD7KdWaNHD0zPbCHuvj6WqoBDZr/cKZNXPIC9aWwErGODS5mosDsMseRWq+p2y3qTt9rdWa2R9aLn7hChjA0y1Een3EeK+fEaT3eFs6jX/3jGc/2zloxk9oWn2U77a8GsW8hRjeRYA5p5BVSfdmOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qczxi2jD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+0cLXatt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qczxi2jD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+0cLXatt"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BmoEiKHdjgFDrhp3mcuYFn54BZ+zNx9uZzc00KIUtM=;
	b=Qczxi2jDFOjvCDvHvage20Ub2s719/uPdRXZmz2FgqI/tkNfilq/IIx3FZbW7cJTdbAWHN
	uwkpTLdVW60UljVISBmfgSmDJxI9lmvYswYIPy7b9pBZmLRvWbudfKEMS+rgWwRJHgPcqI
	5tDFzuIGDpgNRb/omxmeveXCqlJsOEu1MkW3kl93emk8aX2HTV6oTLSjSr1J2TD/5fzzo3
	LvYnpLFl4OPkQGhvsJZy4ByCWnw9t9wHZuxXT8xERSId0IQSyOnmcvXkuaUgTb0iavFeVO
	ygT7WUcvUtZ5v/SEHmtMjw5OZtZbNuPP2VQz3sjoy5C/vM2iyg9cD7fjtX8YPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BmoEiKHdjgFDrhp3mcuYFn54BZ+zNx9uZzc00KIUtM=;
	b=+0cLXatt4AzL2iRwmfoOr9T2FKYm49DfTFZysv07N/QNTS/lEPFENg6yIofvXtXlL7NLYw
	nFGCSRg/RwfmGYCQ==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Kan Liang  <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 5/7] perf: Move swevent_htable::recursion into task_struct.
Date: Thu,  4 Jul 2024 19:03:39 +0200
Message-ID: <20240704170424.1466941-6-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The swevent_htable::recursion counter is used to avoid creating an
swevent while an event is processed to avoid recursion. The counter is
per-CPU and preemption must be disabled to have a stable counter.
perf_pending_task() disables preemption to access the counter and then
signal. This is problematic on PREEMPT_RT because sending a signal uses
a spinlock_t which must not be acquired in atomic on PREEMPT_RT because
it becomes a sleeping lock.

The atomic context can be avoided by moving the counter into the
task_struct. There is a 4 byte hole between futex_state (usually always
on) and the following perf pointer (perf_event_ctxp). After the
recursion lost some weight it fits perfectly.

Move swevent_htable::recursion into task_struct.

Tested-by: Marco Elver <elver@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  6 ------
 include/linux/sched.h      |  7 +++++++
 kernel/events/core.c       | 13 +++----------
 kernel/events/internal.h   |  2 +-
 4 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index ea0d82418d854..99a7ea1d29ed5 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -970,12 +970,6 @@ struct perf_event_context {
 	local_t				nr_pending;
 };
=20
-/*
- * Number of contexts where an event can trigger:
- *	task, softirq, hardirq, nmi.
- */
-#define PERF_NR_CONTEXTS	4
-
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 61591ac6eab6d..afb1087f5831b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -734,6 +734,12 @@ enum perf_event_task_context {
 	perf_nr_task_contexts,
 };
=20
+/*
+ * Number of contexts where an event can trigger:
+ *      task, softirq, hardirq, nmi.
+ */
+#define PERF_NR_CONTEXTS	4
+
 struct wake_q_node {
 	struct wake_q_node *next;
 };
@@ -1256,6 +1262,7 @@ struct task_struct {
 	unsigned int			futex_state;
 #endif
 #ifdef CONFIG_PERF_EVENTS
+	u8				perf_recursion[PERF_NR_CONTEXTS];
 	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bd4b81bf63b6d..1a26a9c33306a 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9774,11 +9774,7 @@ struct swevent_htable {
 	struct swevent_hlist		*swevent_hlist;
 	struct mutex			hlist_mutex;
 	int				hlist_refcount;
-
-	/* Recursion avoidance in each contexts */
-	u8				recursion[PERF_NR_CONTEXTS];
 };
-
 static DEFINE_PER_CPU(struct swevent_htable, swevent_htable);
=20
 /*
@@ -9976,17 +9972,13 @@ DEFINE_PER_CPU(struct pt_regs, __perf_regs[4]);
=20
 int perf_swevent_get_recursion_context(void)
 {
-	struct swevent_htable *swhash =3D this_cpu_ptr(&swevent_htable);
-
-	return get_recursion_context(swhash->recursion);
+	return get_recursion_context(current->perf_recursion);
 }
 EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
=20
 void perf_swevent_put_recursion_context(int rctx)
 {
-	struct swevent_htable *swhash =3D this_cpu_ptr(&swevent_htable);
-
-	put_recursion_context(swhash->recursion, rctx);
+	put_recursion_context(current->perf_recursion, rctx);
 }
=20
 void ___perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
@@ -13653,6 +13645,7 @@ int perf_event_init_task(struct task_struct *child,=
 u64 clone_flags)
 {
 	int ret;
=20
+	memset(child->perf_recursion, 0, sizeof(child->perf_recursion));
 	child->perf_event_ctxp =3D NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index f9a3244206b20..f0daaa6f2a33b 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -221,7 +221,7 @@ static inline int get_recursion_context(u8 *recursion)
 	return rctx;
 }
=20
-static inline void put_recursion_context(u8 *recursion, int rctx)
+static inline void put_recursion_context(u8 *recursion, unsigned char rctx)
 {
 	barrier();
 	recursion[rctx]--;
--=20
2.45.2

