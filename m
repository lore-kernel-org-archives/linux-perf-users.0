Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67360D26D;
	Thu,  7 Nov 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990781; cv=none; b=sXnC61e6CHdu4w9POW4UG7+66+OAtyDuITZDnlcJ/znfiuJo4pnwUUoZgHgrkzBq0xQ3EEnFp79S4XqLQBDZDrtozVM/0wSc518OYFTvR/BTNkNfBUIEo+oUd5OYqJ3QGRt5J7Gvk7iiPwJq2un2iHDttVuecMl032Sdsj7XKug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990781; c=relaxed/simple;
	bh=xnrJGvrF0iJtEcPBf+JqnEvTtjZFpCqmwFqaKDKfi7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXVigewfDk2rOshOWZvdSwo3H8qVFty3t7mZbbDnyH4os4K4ronaGH8RLWpYE+byaIYWlw8I7KJBeAcyUvAF0SplUKJU5dwO2DnVtU51nHLv5U5OJULaT2cCRRwp7ObBdyjR54utXFRiOWiOO7N2wyA0sXhjOEdEUDWPL08qR18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v+IPHwEv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t9KPoXuB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v+IPHwEv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t9KPoXuB"
Date: Thu, 7 Nov 2024 15:46:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730990778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf8IFW1Zxm4tPan11xYmLhqPW8h4IUX94lDCVbtrDPs=;
	b=v+IPHwEvnCie7SbcViLFuNRQ4M2kuJaGTF9XRybuxDvob5QjTdkbvnqqwOrBT+HwsSYrph
	CxZOp596XvjPvYmn7x6AWSJu8nd0G5EFqwaMXHeukwN8CPduge3VRkb7nvIufdKP5rQksg
	FmqIG87RK0pawjvjpLUiZfbR8XnKf0qJUpZ8PqT5C9JFmEAFzyHBLY6BxTKRM6/ZsNqCcz
	kUyIguaQDzae5AAGv+uiQJJeLNLvRio5VOdF+Au6rN3BaNYXMIafyvFGZNkvzrmbi2Dfve
	eTqe7sbnd1HXk57CR8cff5U8qhsEImbZaO/U960S8b/n0ujyHaU8qekFm1n3Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730990778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lf8IFW1Zxm4tPan11xYmLhqPW8h4IUX94lDCVbtrDPs=;
	b=t9KPoXuBGnSfUeP/SDa6MKN+xfXZb3TJo8BZ9K40MhNTeaDYlWvkn78bxA0iP/LxdG7/Oy
	npOd2K9sD0s1iwAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Lai, Yi" <yi1.lai@linux.intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Marco Elver <elver@google.com>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>, yi1.lai@intel.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 2/6] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <20241107144617.MjCWysud@linutronix.de>
References: <20240624152732.1231678-1-bigeasy@linutronix.de>
 <20240624152732.1231678-3-bigeasy@linutronix.de>
 <Zx9Losv4YcJowaP/@ly-workstation>
 <Zx-B0wK3xqRQsCOS@localhost.localdomain>
 <20241029172126.5XY8vLBH@linutronix.de>
 <20241030140721.pZzb9D-u@linutronix.de>
 <ZyJUzhzHGDu5CLdi@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZyJUzhzHGDu5CLdi@localhost.localdomain>

On 2024-10-30 16:46:22 [+0100], Frederic Weisbecker wrote:
> This needs more thoughts. We must make sure that the parent is put _after_
> the child because it's dereferenced on release, for example:
=E2=80=A6
> put_event()
>    free_event()
>       irq_work_sync(&event->pending_irq);
>       =3D=3D=3D=3D> IRQ or irq_workd
>       perf_event_wakeup()
>          ring_buffer_wakeup()
> 	    event =3D event->parent;
> 	    rcu_dereference(event->rb);
>=20
> And now after this patch it's possible that this happens after
> the parent has been released.
>=20
> We could put the parent from the child's free_event() but some
> places (inherit_event()) may call free_event() on a child without
> having held a reference to the parent.
>=20
> Also note that with this patch the task may receive late irrelevant
> signals after the event is removed. It's probably not that bad but
> still... This could be a concern for exec(), is there a missing
> task_work_run() there before flush_signal_handlers()?

So if this causes so much pain, what about taking only one item at a
item? The following passes the test, too:

diff --git a/kernel/task_work.c b/kernel/task_work.c
index c969f1f26be58..fc796ffddfc74 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -206,7 +206,7 @@ bool task_work_cancel(struct task_struct *task, struct =
callback_head *cb)
 void task_work_run(void)
 {
 	struct task_struct *task =3D current;
-	struct callback_head *work, *head, *next;
+	struct callback_head *work, *head;
=20
 	for (;;) {
 		/*
@@ -214,17 +214,7 @@ void task_work_run(void)
 		 * work_exited unless the list is empty.
 		 */
 		work =3D READ_ONCE(task->task_works);
-		do {
-			head =3D NULL;
-			if (!work) {
-				if (task->flags & PF_EXITING)
-					head =3D &work_exited;
-				else
-					break;
-			}
-		} while (!try_cmpxchg(&task->task_works, &work, head));
-
-		if (!work)
+		if (!work && !(task->flags & PF_EXITING))
 			break;
 		/*
 		 * Synchronize with task_work_cancel_match(). It can not remove
@@ -232,13 +222,24 @@ void task_work_run(void)
 		 * But it can remove another entry from the ->next list.
 		 */
 		raw_spin_lock_irq(&task->pi_lock);
+		do {
+			head =3D NULL;
+			if (work) {
+				head =3D READ_ONCE(work->next);
+			} else {
+				if (task->flags & PF_EXITING)
+					head =3D &work_exited;
+				else
+					break;
+			}
+		} while (!try_cmpxchg(&task->task_works, &work, head));
 		raw_spin_unlock_irq(&task->pi_lock);
=20
-		do {
-			next =3D work->next;
-			work->func(work);
-			work =3D next;
+		if (!work)
+			break;
+		work->func(work);
+
+		if (head)
 			cond_resched();
-		} while (work);
 	}
 }

Sebastian
