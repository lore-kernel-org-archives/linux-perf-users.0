Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253419B5AA;
	Mon, 24 Jun 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242861; cv=none; b=RCpSFL9iFWMyigi9SDbbjbrdbkYNQzCupukNsCHLCvkl9dLTTumhdAVQFwf4W4L3jPt0kQRCGAR8ezLRbxtd5pLUc7gtMf9uhh3rB4b82lDhK6lb4dX8UjqD2L+WTAnh2cMdvKSncQQCWIUGNOoveHTlrV2OUJhO4RAQkHggy50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242861; c=relaxed/simple;
	bh=W8z1M30YTNFFf1unU9Yf1sBCRXmAExyUCe/qYLJPfm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bE1WuhkJJYPF+7F1wLgasUkBfPr9V+Mken7TBDDwCd85vtYp0ItIiJz3OJVX673TsUqKa0uQitEexKxJq43lu2b0KuN1c/HM7MTPnpBL/ePkGgfr0v4FDG5agKR6E0FS5glcdwrVIEi3+DRCqSKv0BEus8Hx+LdmSgKEAVZs+P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q1YoTxMD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qB8oFL22; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q1YoTxMD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qB8oFL22"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dl6TCnLAxo924LJNzlZpsS2eoCMgyhzA3J0zNzcmQnI=;
	b=q1YoTxMDqWv7BxRziKVe9+hFV2CvOjNiKEG4PAW6ylNudnymdcqTl2KfRe5Bfhj9XZPjAu
	53A5Dc2v+/dVVCioPmmHriIeIpg8z3/DSQO6VbzlRhhuTNI0YT2xFfg3ovrG4WwWdF1mnw
	LniFylIJMdY05oG1fBHxMUQKqhpOrsAytp1qpg9lji6T4I7VqBV8emhIHOczNf5bzT+tuG
	Z+YtUj4/eJ3p8VXbB20o++5FIM4T5ZFDrISR7EoWk0bMATllcyCqlrmRAWw1FHll2z8m6J
	F07HaXKmXP4u5hDOOy+Bp1mZmv7jCdt6mAzEVc++eRCIV97tE74QUO/66UzROg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dl6TCnLAxo924LJNzlZpsS2eoCMgyhzA3J0zNzcmQnI=;
	b=qB8oFL221LfRSsPlrxob8jJF4cuP7g0nNQw85RApItPhJy495NeFiY+WQa0dP04mQewUIq
	Ap5HQGBMLK11x/Cw==
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
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
Subject: [PATCH v4 4/6] perf: Move swevent_htable::recursion into task_struct.
Date: Mon, 24 Jun 2024 17:15:17 +0200
Message-ID: <20240624152732.1231678-5-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
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
index f48ce05907042..fc9a78e1fb4aa 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9779,11 +9779,7 @@ struct swevent_htable {
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
@@ -9981,17 +9977,13 @@ DEFINE_PER_CPU(struct pt_regs, __perf_regs[4]);
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
@@ -13658,6 +13650,7 @@ int perf_event_init_task(struct task_struct *child,=
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

