Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4E19D8AA;
	Mon, 24 Jun 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242864; cv=none; b=krTjlqwclpYTVTRCvkCbIJbO0jMK4uWJiT6EW5NVwDonxLmuF1lsadoyY30pMd+5mc+cv5XyIrn+Mo86xZ9Varlq2zn6Ka2RJCGD709T6PTctEYcDNARx6tkH973atsdA6vE4EhTFl6zdaoLmilC6QOIOZdE6e/dmFCXhHu9nHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242864; c=relaxed/simple;
	bh=OVQCYTW4L9yu0EDueyCBAY4a89Jd+rzlyMa52xLOMps=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfLDgESflsSCW782OsRVYuYOm9xcdbLAWlNRluolMKATCQnGCe4QNBtcvZt5N9SfEKXvMbu44OtC4/899QbTgA1e/L5FQRzFpqrO3KT3UI8MC3LH7lugvtOfGwEqzBp9hENh+ovz+7eAn6q9EPi3sFwv0h42qhQvBa3pXFOKPZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1VW3jWei; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEhsb9Kv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1VW3jWei";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEhsb9Kv"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLt0LLfVcMa9a+gilIPNXUQswi86xUZORdJUsd8+HOo=;
	b=1VW3jWeiz7NTiwDQyDjfCBLU79UznLlW3fIYX2vtm/5EPNKLmO0vNAP303ZZjCc7d00Whl
	t5rFSOtUwFHSQ3VBewZMohJaeqH46MF5kTz6jriyA0KzYhRSdyNLS2JmOoxnUDACoV1MQZ
	jVcaE7bj3DHkq5BTMKg3HI7HI5XtMNPdqEv3cT6opKux/bh9VjcgTgsfHZjHsYQ5XopVrT
	/HJN+rd3WwsAXJDJB3qG3h+Pv/q2A0UUzd4g3dUVtxJBKuIzQl3c1mKluSIulqE8xKaoBd
	7pb0X8a0TPUOvS2+fa4B6vqS9esmI4Vpit1Er+V8hab/UeUlMOl+2BtFzaO+cA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLt0LLfVcMa9a+gilIPNXUQswi86xUZORdJUsd8+HOo=;
	b=aEhsb9Kv+WZm8yWFi3PZ0NpKtcEJYhzfgkt2ZKfFfYinb3Y7eltunTYTGvDt6THjXA2/+2
	elJFV18Ha+WgPDBg==
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v4 6/6] perf: Split __perf_pending_irq() out of perf_pending_irq()
Date: Mon, 24 Jun 2024 17:15:19 +0200
Message-ID: <20240624152732.1231678-7-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

perf_pending_irq() invokes perf_event_wakeup() and __perf_pending_irq().
The former is in charge of waking any tasks which wait to be woken up
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
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 31 +++++++++++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

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
index f75aa9f14c979..8bba63ea9c686 100644
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
@@ -9734,7 +9748,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 * is processed.
 			 */
 			if (in_nmi())
-				irq_work_queue(&event->pending_irq);
+				irq_work_queue(&event->pending_disable_irq);
=20
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
@@ -11972,6 +11986,7 @@ perf_event_alloc(struct perf_event_attr *attr, int =
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

