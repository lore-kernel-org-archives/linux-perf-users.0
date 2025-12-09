Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51A12D73B6;
	Tue,  9 Dec 2025 09:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765272219; cv=none; b=QYaIwE+fyYVWtJILLDT9goCwA3mTw2CYIw5tEOUUFr3pEDWDjFj8x9BzdWSZD3B/C2lTQj1r3+heUXCmz2gOfQQCbBYb/an0Gnqe9aiQVyKfJAZB9yk/7C7DMbylZU3w9kOUZh4CFTFjt+zSc0hFsSshQetLW8TUIJpGkxLLUOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765272219; c=relaxed/simple;
	bh=dqdsWE183cI7d+SEXdKExZZO3tHyNmFzchc1209IyaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DhWmA1FkbpBnCeNr5QZTg2pdBMwnsYXGQLqVrBLwfAhiFOFismVKcoHX3cZ7fRIldzHkawPPXLCP3+49fJIyxSzKc3XuSpU/JmuSK2PHPJigNJi4SzoQSKdSfENwfjDez+9xkI7/ghHp18sZnCCmeF3L/agsOUTlSLwXot2UPvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N7/+jbVN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HuM7DQut; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N7/+jbVN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HuM7DQut"
Date: Tue, 09 Dec 2025 09:23:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765272216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Md+WNQ/WdVW8QSKfhaCDFYCDKdikzeHLVw1KGvueQOk=;
	b=N7/+jbVN4L1ePg1KyGj9yI+fRhTIQ/LD6qapbOmwn8RXRqsdsWQCEyi2kpr3Z91cccwe91
	JomdeysUvrni+iVKm297ZIU9wHjI7eVqHzWZrFSuKCcoThv8oGnqGUmpK46TRSt1p3aOv3
	5xWVSCZmReDAyIUwdmPqn9dzoPmzoHzeGaGXj/dNg2xpAsOmBGZ4zA4y1e2D7/fCGScYYH
	9UFDyy1aN1nASF4PfM1kJseaOv4D4adS1QxRYTL9FqA11NZFA5Ftzu0gRc4wmj8j0/D20R
	UP5Fw9Hx+CDFZH7tirJAQgmIulRgyaX241Zmb6RNY/7qbBlgm423P+xHM9sS6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765272216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Md+WNQ/WdVW8QSKfhaCDFYCDKdikzeHLVw1KGvueQOk=;
	b=HuM7DQutsolyrZ4512jZR7b2BiiQWkZq5dmbgPQ7Cc/2TZBcWywKfFEDgtBuvNU+HuggUO
	fI2tiOHjuM1p9xDg==
From: "tip-bot2 for Thaumy Cheng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/core: Fix missing read event generation on task exit
Cc: Thaumy Cheng <thaumy.love@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251209041600.963586-1-thaumy.love@gmail.com>
References: <20251209041600.963586-1-thaumy.love@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176527221485.498.8891566699674685713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     02a4984a359633d45b0926eb2a9c6d7bfb71b2e2
Gitweb:        https://git.kernel.org/tip/02a4984a359633d45b0926eb2a9c6d7bfb7=
1b2e2
Author:        Thaumy Cheng <thaumy.love@gmail.com>
AuthorDate:    Tue, 09 Dec 2025 12:16:00 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 09 Dec 2025 09:57:45 +01:00

perf/core: Fix missing read event generation on task exit

For events with inherit_stat enabled, a "read" event will be generated
to collect per task event counts on task exit.

The call chain is as follows:

do_exit
  -> perf_event_exit_task
    -> perf_event_exit_task_context
      -> perf_event_exit_event
        -> perf_remove_from_context
          -> perf_child_detach
            -> sync_child_event
              -> perf_event_read_event

However, the child event context detaches the task too early in
perf_event_exit_task_context, which causes sync_child_event to never
generate the read event in this case, since child_event->ctx->task is
always set to TASK_TOMBSTONE. Fix that by moving context lock section
backward to ensure ctx->task is not set to TASK_TOMBSTONE before
generating the read event.

Because perf_event_free_task calls perf_event_exit_task_context with
exit =3D false to tear down all child events from the context, and the
task never lived, accessing the task PID can lead to a use-after-free.

To fix that, let sync_child_event read task from argument and move the
call to the only place it should be triggered to avoid the effect of
setting ctx->task to TASK_TOMESTONE, and add a task parameter to
perf_event_exit_event to trigger the sync_child_event properly when
needed.

This bug can be reproduced by running "perf record -s" and attaching to
any program that generates perf events in its child tasks. If we check
the result with "perf report -T", the last line of the report will leave
an empty table like "# PID  TID", which is expected to contain the
per-task event counts by design.

Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
Link: https://patch.msgid.link/20251209041600.963586-1-thaumy.love@gmail.com
---
 kernel/events/core.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ece7168..47d5dc4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2317,7 +2317,8 @@ out:
 	perf_event__header_size(leader);
 }
=20
-static void sync_child_event(struct perf_event *child_event);
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task);
=20
 static void perf_child_detach(struct perf_event *event)
 {
@@ -2337,7 +2338,6 @@ static void perf_child_detach(struct perf_event *event)
 	lockdep_assert_held(&parent_event->child_mutex);
 	 */
=20
-	sync_child_event(event);
 	list_del_init(&event->child_list);
 }
=20
@@ -4588,6 +4588,7 @@ out:
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
 				  struct perf_event_context *ctx,
+				  struct task_struct *task,
 				  bool revoke);
=20
 /*
@@ -4615,7 +4616,7 @@ static void perf_event_remove_on_exec(struct perf_event=
_context *ctx)
=20
 		modified =3D true;
=20
-		perf_event_exit_event(event, ctx, false);
+		perf_event_exit_event(event, ctx, ctx->task, false);
 	}
=20
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -12518,7 +12519,7 @@ static void __pmu_detach_event(struct pmu *pmu, struc=
t perf_event *event,
 	/*
 	 * De-schedule the event and mark it REVOKED.
 	 */
-	perf_event_exit_event(event, ctx, true);
+	perf_event_exit_event(event, ctx, ctx->task, true);
=20
 	/*
 	 * All _free_event() bits that rely on event->pmu:
@@ -14075,14 +14076,13 @@ void perf_pmu_migrate_context(struct pmu *pmu, int =
src_cpu, int dst_cpu)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
=20
-static void sync_child_event(struct perf_event *child_event)
+static void sync_child_event(struct perf_event *child_event,
+			     struct task_struct *task)
 {
 	struct perf_event *parent_event =3D child_event->parent;
 	u64 child_val;
=20
 	if (child_event->attr.inherit_stat) {
-		struct task_struct *task =3D child_event->ctx->task;
-
 		if (task && task !=3D TASK_TOMBSTONE)
 			perf_event_read_event(child_event, task);
 	}
@@ -14101,7 +14101,9 @@ static void sync_child_event(struct perf_event *child=
_event)
=20
 static void
 perf_event_exit_event(struct perf_event *event,
-		      struct perf_event_context *ctx, bool revoke)
+		      struct perf_event_context *ctx,
+		      struct task_struct *task,
+		      bool revoke)
 {
 	struct perf_event *parent_event =3D event->parent;
 	unsigned long detach_flags =3D DETACH_EXIT;
@@ -14124,6 +14126,9 @@ perf_event_exit_event(struct perf_event *event,
 		mutex_lock(&parent_event->child_mutex);
 		/* PERF_ATTACH_ITRACE might be set concurrently */
 		attach_state =3D READ_ONCE(event->attach_state);
+
+		if (attach_state & PERF_ATTACH_CHILD)
+			sync_child_event(event, task);
 	}
=20
 	if (revoke)
@@ -14215,7 +14220,7 @@ static void perf_event_exit_task_context(struct task_=
struct *task, bool exit)
 		perf_event_task(task, ctx, 0);
=20
 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx, false);
+		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
=20
 	mutex_unlock(&ctx->mutex);
=20
