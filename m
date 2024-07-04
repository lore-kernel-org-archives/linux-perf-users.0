Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B911B3F2A;
	Thu,  4 Jul 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112675; cv=none; b=kmwWAC3aLCjwIX8yiY2iQxLlwo4pN/nFhBs5UzCvhnVhuCLodELqsuDJAEF0uFU+mbk3kFdUsy6m5VFMdFaxIv7qvi9s162ThCgG5yZRbz0L6fyeOOJIX7jhHcQ0w2zt1tQGPWoCXZRtlj0Al1yGOG7otBfO5vXPdNtNdxjLcOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112675; c=relaxed/simple;
	bh=PMXajY0yYWqHBFxHNSd9Xq7MdsGEj5g/AqG2BowAAMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWp/gXS7B2xcR2faZYHvehvsyX5v2mEBosvaKVItKZiIMatOBhXyLmvHIlPX2hagrY0oo8Se30zMiyz/82wLksFa/8OvMgV1NO0NXVDn9Lr3AUymLw6THFZyDnWA8CBkH4w9YS0rVdSCjmYImb4PdkYjIkO78gdA/7bnZb6nkRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdYEBRiK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+VcvC5wc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdYEBRiK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+VcvC5wc"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LOnoc+dfeuSsOqavqeqWNmyyI3wODKhBqm5Wu987To=;
	b=RdYEBRiKB+jJiBSybOyVNnvFMFZFm/LzJNKdRFzJOnvYA8YjncYOY2l/Ab/TE9WqjbrtVL
	+xS3D2avhqvuygqgHkclko5+Tb2+ALhal+ahTMX8mvWXLt20FwXzPXPrveFE7ISSEiiIv6
	+4deqdOnTyJ1bCjPZSiQpRDBZSRXKbIRJNIr6EbX9HlIc4apEpr6DbIjGHizZmsQ6M1qrX
	GWik52rSL7DOFzJoz9DIbkt7yX1oGWaCeQdvcXvGoHPxkytqRTr5RlEMt2TDvS/3/fCVq3
	qw2t18dXk/9jDM91u94+wkz6u3aja3sDPDKtQKGO54x4UklyckzfVHmMjzrAbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LOnoc+dfeuSsOqavqeqWNmyyI3wODKhBqm5Wu987To=;
	b=+VcvC5wcVkf/zi8ndISmb19eBQSz49NGSOXupiI9DdOQDPMUGZOzGUhg2GqPvjpNjaLRUs
	MjcSXvGKhDbTqQCg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v5 7/7] perf: Split __perf_pending_irq() out of perf_pending_irq()
Date: Thu,  4 Jul 2024 19:03:41 +0200
Message-ID: <20240704170424.1466941-8-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

perf_pending_irq() invokes perf_event_wakeup() and __perf_pending_irq().
The former is in charge of waking any tasks which waits to be woken up
while the latter disables perf-events.

The irq_work perf_pending_irq(), while this an irq_work, the callback
is invoked in thread context on PREEMPT_RT. This is needed because all
the waking functions (wake_up_all(), kill_fasync()) acquire sleep locks
which must not be used with disabled interrupts.
Disabling events, as done by __perf_pending_irq(), expects a hardirq
context and disabled interrupts. This requirement is not fulfilled on
PREEMPT_RT.

Split functionality based on perf_event::pending_disable into irq_work
named `pending_disable_irq' and invoke it in hardirq context on
PREEMPT_RT. Rename the split out callback to perf_pending_disable().

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/all/ZMAtZ2t43GXoF6tM@kernel.org/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 99a7ea1d29ed5..65ece0d5b4b6d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -783,6 +783,7 @@ struct perf_event {
 	unsigned int			pending_disable;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
+	struct irq_work			pending_disable_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
 	struct rcuwait			pending_work_wait;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 67f5aab933c81..0acf6ee4df528 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2451,7 +2451,7 @@ static void __perf_event_disable(struct perf_event *e=
vent,
  * hold the top-level event's child_mutex, so any descendant that
  * goes to exit will block in perf_event_exit_event().
  *
- * When called from perf_pending_irq it's OK because event->ctx
+ * When called from perf_pending_disable it's OK because event->ctx
  * is the current context on this CPU and preemption is disabled,
  * hence we can't get into perf_event_task_sched_out for this context.
  */
@@ -2491,7 +2491,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
 void perf_event_disable_inatomic(struct perf_event *event)
 {
 	event->pending_disable =3D 1;
-	irq_work_queue(&event->pending_irq);
+	irq_work_queue(&event->pending_disable_irq);
 }
=20
 #define MAX_INTERRUPTS (~0ULL)
@@ -5218,6 +5218,7 @@ static void perf_pending_task_sync(struct perf_event =
*event)
 static void _free_event(struct perf_event *event)
 {
 	irq_work_sync(&event->pending_irq);
+	irq_work_sync(&event->pending_disable_irq);
 	perf_pending_task_sync(event);
=20
 	unaccount_event(event);
@@ -6760,7 +6761,7 @@ static void perf_sigtrap(struct perf_event *event)
 /*
  * Deliver the pending work in-event-context or follow the context.
  */
-static void __perf_pending_irq(struct perf_event *event)
+static void __perf_pending_disable(struct perf_event *event)
 {
 	int cpu =3D READ_ONCE(event->oncpu);
=20
@@ -6798,11 +6799,26 @@ static void __perf_pending_irq(struct perf_event *e=
vent)
 	 *				  irq_work_queue(); // FAILS
 	 *
 	 *  irq_work_run()
-	 *    perf_pending_irq()
+	 *    perf_pending_disable()
 	 *
 	 * But the event runs on CPU-B and wants disabling there.
 	 */
-	irq_work_queue_on(&event->pending_irq, cpu);
+	irq_work_queue_on(&event->pending_disable_irq, cpu);
+}
+
+static void perf_pending_disable(struct irq_work *entry)
+{
+	struct perf_event *event =3D container_of(entry, struct perf_event, pendi=
ng_disable_irq);
+	int rctx;
+
+	/*
+	 * If we 'fail' here, that's OK, it means recursion is already disabled
+	 * and we won't recurse 'further'.
+	 */
+	rctx =3D perf_swevent_get_recursion_context();
+	__perf_pending_disable(event);
+	if (rctx >=3D 0)
+		perf_swevent_put_recursion_context(rctx);
 }
=20
 static void perf_pending_irq(struct irq_work *entry)
@@ -6825,8 +6841,6 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_event_wakeup(event);
 	}
=20
-	__perf_pending_irq(event);
-
 	if (rctx >=3D 0)
 		perf_swevent_put_recursion_context(rctx);
 }
@@ -11967,6 +11981,7 @@ perf_event_alloc(struct perf_event_attr *attr, int =
cpu,
=20
 	init_waitqueue_head(&event->waitq);
 	init_irq_work(&event->pending_irq, perf_pending_irq);
+	event->pending_disable_irq =3D IRQ_WORK_INIT_HARD(perf_pending_disable);
 	init_task_work(&event->pending_task, perf_pending_task);
 	rcuwait_init(&event->pending_work_wait);
=20
--=20
2.45.2

