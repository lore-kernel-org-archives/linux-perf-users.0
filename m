Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B5D19B5A5;
	Mon, 24 Jun 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242861; cv=none; b=dKNoO0fNg6BqtgZDN+80OsmNupPbIvYh/Dzig4tgN5wynM0DxpdsIuvUjRcxaFgo06jBpa8HxgWOI5jBUH9RR2K2tC6wkActHT/+BJVLuiq05xmin7w21x4Ysl7TCJnso5Vm+rCBBBaWLcFFhdkxVlas01055OG/oY3oHeLHIKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242861; c=relaxed/simple;
	bh=wfrZOAkXJz9f9Lfg42t9i9udnKgxHzF8ML/6Tpd7HJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTO2MUQaHt6kuekqAZrJlsrEcIFBX/jq/YuTYKbcm8OBuKE++AeOqJbiuFS1dGd1p/tF7hcHXrx7UYIU9Xsu/ZeLRxFgBvW/aDWOhxjB/j4HmDg/HO/ieUgd3rFxvyt44pHJR68kw5R4DvnxecR97UQTneQ0OOb42pSC5sEQaKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ipLTj0pf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j3IKRUKL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ipLTj0pf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j3IKRUKL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxZaiy3N5qW+TR11v/Lgl5tgIwAatTer0ZvBOD6wEk4=;
	b=ipLTj0pfs6Tgsf2A0QftwMz8aZxQ1P7tbKzrit+YCNUZEZnjthMgbvonRy7nMNr4SBOgFh
	FRvhNRkSTZSmJAP3p92gqylbmxVQQ21fv5RjdV+uEpvzMR9LtGiAZV7N+0vnB1ZHqTowXM
	+lEd2qI/BJSki3xgpnNxnx7/7qFXygYysqnjoh1F/j1MhFkGnRDDLU7iNMJIvSOkYnTBas
	2oz18E1TOwL3xyOEViFKEat57+eBLpd6kbeLO8dQhPDel1g6HSYDIDoodrKXd7Jr7XbbmG
	dwuFOw8GAj58rXUY+mnTiMFvUzJRxFVmHM7e/xireMi/pTQxa63gg6Hyp7vKkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lxZaiy3N5qW+TR11v/Lgl5tgIwAatTer0ZvBOD6wEk4=;
	b=j3IKRUKLgfoVmBj3IodqxBCgMnHcdoqA9pWr9PjFQuomqiQfc/lX0s55ASwZp/42Y4XhwG
	7rDarw9OjQUUlTBg==
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
Subject: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Date: Mon, 24 Jun 2024 17:15:15 +0200
Message-ID: <20240624152732.1231678-3-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

A signal is delivered by raising irq_work() which works from any context
including NMI. irq_work() can be delayed if the architecture does not
provide an interrupt vector. In order not to lose a signal, the signal
is injected via task_work during event_sched_out().

Instead going via irq_work, the signal could be added directly via
task_work. The signal is sent to current and can be enqueued on its
return path to userland instead of triggering irq_work. A dummy IRQ is
required in the NMI case to ensure the task_work is handled before
returning to user land. For this irq_work is used. An alternative would
be just raising an interrupt like arch_send_call_function_single_ipi().

During testing with `remove_on_exec' it become visible that the event
can be enqueued via NMI during execve(). The task_work must not be kept
because free_event() will complain later. Also the new task will not
have a sighandler installed.

Queue signal via task_work. Remove perf_event::pending_sigtrap and
and use perf_event::pending_work instead. Raise irq_work in the NMI case
for a dummy interrupt. Remove the task_work if the event is freed.

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  3 +--
 kernel/events/core.c       | 36 +++++++++++++++---------------------
 2 files changed, 16 insertions(+), 23 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 393fb13733b02..ea0d82418d854 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -781,7 +781,6 @@ struct perf_event {
 	unsigned int			pending_wakeup;
 	unsigned int			pending_kill;
 	unsigned int			pending_disable;
-	unsigned int			pending_sigtrap;
 	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
@@ -963,7 +962,7 @@ struct perf_event_context {
 	struct rcu_head			rcu_head;
=20
 	/*
-	 * Sum (event->pending_sigtrap + event->pending_work)
+	 * Sum (event->pending_work + event->pending_work)
 	 *
 	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
 	 * that until the signal is delivered.
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 647abeeaeeb02..6256a9593c3da 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2283,17 +2283,6 @@ event_sched_out(struct perf_event *event, struct per=
f_event_context *ctx)
 		state =3D PERF_EVENT_STATE_OFF;
 	}
=20
-	if (event->pending_sigtrap) {
-		event->pending_sigtrap =3D 0;
-		if (state !=3D PERF_EVENT_STATE_OFF &&
-		    !event->pending_work &&
-		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
-			event->pending_work =3D 1;
-		} else {
-			local_dec(&event->ctx->nr_pending);
-		}
-	}
-
 	perf_event_set_state(event, state);
=20
 	if (!is_software_event(event))
@@ -6787,11 +6776,6 @@ static void __perf_pending_irq(struct perf_event *ev=
ent)
 	 * Yay, we hit home and are in the context of the event.
 	 */
 	if (cpu =3D=3D smp_processor_id()) {
-		if (event->pending_sigtrap) {
-			event->pending_sigtrap =3D 0;
-			perf_sigtrap(event);
-			local_dec(&event->ctx->nr_pending);
-		}
 		if (event->pending_disable) {
 			event->pending_disable =3D 0;
 			perf_event_disable_local(event);
@@ -9735,18 +9719,28 @@ static int __perf_event_overflow(struct perf_event =
*event,
=20
 		if (regs)
 			pending_id =3D hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_sigtrap) {
-			event->pending_sigtrap =3D pending_id;
+
+		if (!event->pending_work &&
+		    !task_work_add(current, &event->pending_task, TWA_RESUME)) {
+			event->pending_work =3D pending_id;
 			local_inc(&event->ctx->nr_pending);
=20
 			event->pending_addr =3D 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 				event->pending_addr =3D data->addr;
-			irq_work_queue(&event->pending_irq);
+			/*
+			 * The NMI path returns directly to userland. The
+			 * irq_work is raised as a dummy interrupt to ensure
+			 * regular return path to user is taken and task_work
+			 * is processed.
+			 */
+			if (in_nmi())
+				irq_work_queue(&event->pending_irq);
+
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9756,7 +9750,7 @@ static int __perf_event_overflow(struct perf_event *e=
vent,
 			 *     To approximate progress (with false negatives),
 			 *     check 32-bit hash of the current IP.
 			 */
-			WARN_ON_ONCE(event->pending_sigtrap !=3D pending_id);
+			WARN_ON_ONCE(event->pending_work !=3D pending_id);
 		}
 	}
=20
--=20
2.45.2

