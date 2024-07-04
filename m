Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14531B1503;
	Thu,  4 Jul 2024 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112674; cv=none; b=GpEcMu8lweD8h4x1DbWDBI4hDqUDlLeuMoV3CGqS0J2BPJnobc1l/4MO+ZMzcfXGPWh5LoFFWnMwxLFheCVJ1fGnQ28HwB/rQuuEl1EBpSeDod+Jh4XemB5A7OmDuWOw/XE6O2qgfkIjRbjoyQDF1n1LOZPFgX8w3Bhsrowsns4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112674; c=relaxed/simple;
	bh=OA6APz55wxezTyURWBrPGfOxP5hAQYOf9p8p58/aQ8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iVDEnlBA/zs9XjdKbe7Kfkorjnxyb5S4B1422ByHUFYWCTibM80Syo7PMcYPf/C2I2ba1M43waH7tZ2Mzw+kyIAysygPBiL/IU+de4CgtosmsUdc2EDfo+0oDetwRYKLPxZLC/Pv8fvULMlbrACDF8637WosfG1zHcCjX/PComI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swxatZHP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RKcm5xQj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swxatZHP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RKcm5xQj"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9glYCDIwd40nFYbMHkkHdjoLHTy0aSJSEXjHjzWcsA=;
	b=swxatZHPBWAC+IG+qiXlFT1TWc/LWGNiZPC++0/wxCWGHerqVHyG2Keje3q59YVdK1Tqqd
	+k0syISI5uQ0h45yOiLHUuaEcpzYQOGX2QzxolVfQchRWa40UxuPgiDSMHxNTdSE7wqXo6
	sxjO73dIjiViKivNoixrlTzMd3uNz7apPU66zLXKilddTH/iN4UAstOns6qQ6GjZCeE2RE
	tM7gs6JCddRIZ2z8daM88IqhldzgaQx+Ph/VBPtOGscNHeF7zftBRPsMcryUlYY6QGTNGC
	xF8BKfh+EBvcOkNzh+eYl8SQTFZtejribcesMRUxIqMiW3G6nw4fydgSSOdHsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q9glYCDIwd40nFYbMHkkHdjoLHTy0aSJSEXjHjzWcsA=;
	b=RKcm5xQjFNPnSeS8C/Z+uy3aOZJrsa4NN8fvWe3rHmxN8V54uEwgijxJJZkKSCZsLiByUo
	MrQoCspWbspl7fDA==
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
Subject: [PATCH v5 3/7] perf: Enqueue SIGTRAP always via task_work.
Date: Thu,  4 Jul 2024 19:03:37 +0200
Message-ID: <20240704170424.1466941-4-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
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
return path to userland.

Queue signal via task_work and consider possible NMI context. Remove
perf_event::pending_sigtrap and and use perf_event::pending_work
instead.

Tested-by: Marco Elver <elver@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lore.kernel.org/all/ZMAtZ2t43GXoF6tM@kernel.org/
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/perf_event.h |  3 +--
 kernel/events/core.c       | 31 ++++++++++---------------------
 2 files changed, 11 insertions(+), 23 deletions(-)

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
index 647abeeaeeb02..c278aefa94e76 100644
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
@@ -9732,21 +9716,26 @@ static int __perf_event_overflow(struct perf_event =
*event,
 		 */
 		bool valid_sample =3D sample_is_allowed(event, regs);
 		unsigned int pending_id =3D 1;
+		enum task_work_notify_mode notify_mode;
=20
 		if (regs)
 			pending_id =3D hash32_ptr((void *)instruction_pointer(regs)) ?: 1;
-		if (!event->pending_sigtrap) {
-			event->pending_sigtrap =3D pending_id;
+
+		notify_mode =3D in_nmi() ? TWA_NMI_CURRENT : TWA_RESUME;
+
+		if (!event->pending_work &&
+		    !task_work_add(current, &event->pending_task, notify_mode)) {
+			event->pending_work =3D pending_id;
 			local_inc(&event->ctx->nr_pending);
=20
 			event->pending_addr =3D 0;
 			if (valid_sample && (data->sample_flags & PERF_SAMPLE_ADDR))
 				event->pending_addr =3D data->addr;
-			irq_work_queue(&event->pending_irq);
+
 		} else if (event->attr.exclude_kernel && valid_sample) {
 			/*
 			 * Should not be able to return to user space without
-			 * consuming pending_sigtrap; with exceptions:
+			 * consuming pending_work; with exceptions:
 			 *
 			 *  1. Where !exclude_kernel, events can overflow again
 			 *     in the kernel without returning to user space.
@@ -9756,7 +9745,7 @@ static int __perf_event_overflow(struct perf_event *e=
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

