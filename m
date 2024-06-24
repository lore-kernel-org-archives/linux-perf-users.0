Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9019D8A6;
	Mon, 24 Jun 2024 15:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242863; cv=none; b=VF8a1bZOx38T/x4wElYgYdu9FvL+BSJ0cUs8UWdNpmKQMQJo/jCkwrkH0cyCTd3I7/hZy/eSCVw5Az6osZK/LTtx1KTHPbk4SYtz2wYfCJS4M4wpebvyhxyMvXwAcnUo52Z1UtWnd/okblZtslPI+umKn1mp3ESVqZzW0X4xwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242863; c=relaxed/simple;
	bh=bvo/lpGRvbF3WWnb+rVZuJyzxfj90xjeHxN0eiTEoms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qv/gGBM5v9aqhoELvVJaPKTAs+zqTI2kAPAflv6WGIXGte2va4DTcqr3U/ftXMeqUKsFZpxaP5xWa5eIL1wQ70D6LMKjjQLhXnOeosNMGsFgfJQbRMIFhDi3iCyliMfkdjrmtex0HioJF0cpFd/bK1pDSgXCfyKIHmJdrzXOlyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0iBgufD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JsaLTd0r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0iBgufD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JsaLTd0r"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHgQQtbqN3zK19tb9I6f8KrfnGMC54dQwVOa6Td0Tyo=;
	b=e0iBgufDeySo0z0BWC7TPcjQjDYiPR0SZOa/f2+Hdg3sIkhWpgRMDfM/HTWik037Tv59c/
	W81QJNmOaMVNqYuJiRNt++rTyCQcOgU7KVplvZEoqzO6q7SN0YgVBnlVOU5DXdlsRcOoki
	g+II/pWpF2sltgoWB6iXQbMdz1Wa35aX0WAC0LVVoJctEaZuvo6jmvEhjZe4vWfU8CtGVl
	CogY+UWcOu0J6R2f0jn7tXz8QHOcGx94aI70eEFbG6M+jZrcgOMGqsJL03EcBpkoDipDkE
	+iO+pUuT3OKoeaEmND6XpQbEY5oEvgTrHvAB//o79tLAeu0eoAwR3rjnerpTxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719242858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oHgQQtbqN3zK19tb9I6f8KrfnGMC54dQwVOa6Td0Tyo=;
	b=JsaLTd0r1Z0+Dy8LfMOIamfn/0Y0jRpz+RJeKfkpBIOkDZCyyEyFx+eKK4t++BzOnnz5T0
	WOCSnOYY8IfO0CBg==
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
Subject: [PATCH v4 5/6] perf: Don't disable preemption in perf_pending_task().
Date: Mon, 24 Jun 2024 17:15:18 +0200
Message-ID: <20240624152732.1231678-6-bigeasy@linutronix.de>
In-Reply-To: <20240624152732.1231678-1-bigeasy@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

perf_pending_task() is invoked in task context and disables preemption
because perf_swevent_get_recursion_context() used to access per-CPU
variables. The other reason is to create a RCU read section while
accessing the perf_event.

The recursion counter is no longer a per-CPU accounter so disabling
preemption is no longer required. The RCU section is needed and must be
created explicit.

Replace the preemption-disable section with a explicit RCU-read section.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fc9a78e1fb4aa..f75aa9f14c979 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5208,10 +5208,9 @@ static void perf_pending_task_sync(struct perf_event=
 *event)
 	}
=20
 	/*
-	 * All accesses related to the event are within the same
-	 * non-preemptible section in perf_pending_task(). The RCU
-	 * grace period before the event is freed will make sure all
-	 * those accesses are complete by then.
+	 * All accesses related to the event are within the same RCU section in
+	 * perf_pending_task(). The RCU grace period before the event is freed
+	 * will make sure all those accesses are complete by then.
 	 */
 	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_=
UNINTERRUPTIBLE);
 }
@@ -6842,7 +6841,7 @@ static void perf_pending_task(struct callback_head *h=
ead)
 	 * critical section as the ->pending_work reset. See comment in
 	 * perf_pending_task_sync().
 	 */
-	preempt_disable_notrace();
+	rcu_read_lock();
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6855,10 +6854,10 @@ static void perf_pending_task(struct callback_head =
*head)
 		local_dec(&event->ctx->nr_pending);
 		rcuwait_wake_up(&event->pending_work_wait);
 	}
+	rcu_read_unlock();
=20
 	if (rctx >=3D 0)
 		perf_swevent_put_recursion_context(rctx);
-	preempt_enable_notrace();
 }
=20
 #ifdef CONFIG_GUEST_PERF_EVENTS
--=20
2.45.2

