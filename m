Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3A1B3F23;
	Thu,  4 Jul 2024 17:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112675; cv=none; b=XRvQ8kPZwKj2vU+QR8/QaI7vYiBbc7JectsyjVR5jLjfG3uTnKwSvBpw/gfjtUHKKl+ky1GMW1xzuizIRqiCaTuPCczjsgpjRmMmS+h4Uqy24ukihTCjSOlSqmOXbvYfFNFRsmfZuGs7dIT0LEHMy9IqUnq3cCv46EsuNTXyhJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112675; c=relaxed/simple;
	bh=S8OVgI+z3/1TkjlEzzhcY/BKekKcyxSOhl+MLCQeg/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqoRLBcBDRHBmOswiSOMjaR/kl5tF9NYs8UVIHIaqNFk8wcIQuYJEOq08vKDU3q1cQ77sNsvpR6foc1kAZCCBB6LJ2SMJb658TZKHGlGhBwlY3Y7wB9+v6on4yNtfVj3QvHsC8NZ55WfvVCOxNoBcPr48HB+6LgehgujD3simhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Ff73+0i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IwnVUIFC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Ff73+0i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IwnVUIFC"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720112671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGqrJgSvPRRSLcKLNJWunSQ8rRcOGjf/kJDwlFzATiA=;
	b=2Ff73+0iE5zoEOsuJ5v51gM5a/HAbvf/m1LM7H1Hydlqx3CMfN4FHiYXorP67T0LVNA3pz
	rAzvLITwlhNBHvOc8e3uqEmIchgtihOF98HBGXHj80pc54GLSUG/ECv8lESIHgszNUntLZ
	tFrnGMeElA+YO8CE2vAVHhDrD5jPY+6QokQJjlyDtaJvRiL3/sV25IAxcRHSJX3pldh6Kj
	6PYPV1NUdhl6ArsobA8/RPJ3+YlqQ7TE3vE2/d0TZFULlEn4uH8iZg7aMcdBgx5d+27v83
	HCS5WEMmr83XQ30XZ0tBz7djv5Y4ceMha0iGk3pW+IW+na9Vzi3YlbgAkNSnPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720112671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGqrJgSvPRRSLcKLNJWunSQ8rRcOGjf/kJDwlFzATiA=;
	b=IwnVUIFCuSkY5wwfIZMyb7+D9CCI+cUZ0cpkJBStoGKFJls6kj63n7D7d89tJKCOM0Hujp
	Xd16soKsvp6+jGCQ==
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
Subject: [PATCH v5 6/7] perf: Don't disable preemption in perf_pending_task().
Date: Thu,  4 Jul 2024 19:03:40 +0200
Message-ID: <20240704170424.1466941-7-bigeasy@linutronix.de>
In-Reply-To: <20240704170424.1466941-1-bigeasy@linutronix.de>
References: <20240704170424.1466941-1-bigeasy@linutronix.de>
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

Tested-by: Marco Elver <elver@google.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/events/core.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1a26a9c33306a..67f5aab933c81 100644
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

