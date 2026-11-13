Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609247;
	b=IRIw6BLrnnwYzIAkUzq0dDwEGoEZdrxXHR49vMhRw9VeTtte1DReZHBVoPfH6V4XbzZ0
	 MKIJqPTTwSE1H+LynFWngXNGe0nKqMSYAuU+misRiccdgxA9y7KaUILXp2LIDpX5Hgljc
	 qwMbuykdyiIJBehkINFVra1dgtWbF0v0BrV2pP1BcYOQXVmSf+W3gP25SW15UN+OB5dva
	 Dh97ss3w3Ava/o6iTnWGTEQJQet+LWjPsRsqxS77wEhIGOEyIZBOyaU3RcAmdpVZX4+hX
	 /vcnpwWNPL2AO9LMenNeEEKVMjEgwzKFy5i2mPiUPsUOWE5BU/NjhgHrahnEPkE+nwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ydeUcZA8onzweMVPzz2bfy1XcinKCiipi7mkuZFybkI=;
	b=EWkW3tlxLuMwK+NfM8sVeY6CbWdLKy7HLNZ60C7Fha7ShDPeqctuVE8RNJCkNCW4wFik
	 CUkijCxexCTe43V5F1dspE09BvBg5njNg5AN/mb061iQ6UQ+H0eLY2HFPCICWtfVdTJKr
	 qvRsXsoPsXzTBS4Ecvmo39UiAItBZrNRJNSmZ2WPyzcpDJuvXSAu1wVFL2mb1EjB5OV7v
	 MBeqIacSV9o42RqeU3s2/ipCMhObXpTgG/p8qEwIqZYOB9VsNOGV5VH+IWMnrxVxysFAd
	 rt30D5SH+FzfLPE9rv8nUam1G4juuCkFPi7UtuIqQg8XAhgBbSpEswzR5biiLp5xhkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaT7fZff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76945606A887
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 22:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gaT7fZff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347761F000C4;
	Fri, 13 Nov 2026 22:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609247;
	bh=ydeUcZA8onzweMVPzz2bfy1XcinKCiipi7mkuZFybkI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=gaT7fZffhSE9GdbbMgZo4RK75zZcJyek0VOAPC7Bb9EW9LDiiJzVh5p+IQjU9RPyA
	 0m2l+ehudZ8sz6kBLE4c+re860Xo83QrzkNB0f85lrn+HKJl4Ej0c51YjJ0yFVlnlj
	 Zo7liSVN209J/bhAZoNWAUAYZzMui/BAt4NJ4Vjy6AT23U1DmGN1b+7LdZq3VuIQw0
	 TutN+drDedVeprR5hYb/XEeGyD9Ll6X+M9p9mQ/tWyotMpJY2Lhz7IKejNdTMqsjeW
	 vpfENv+hz8g50VHIvgpT9bbhWjw6xxnV6BtVgIBZkab7CGk68s9bbZklrxnz1gAJPr
	 AhJF/JltXSZ+Q==
Message-ID: <sashiko-outbox-213814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: Hold exec lock until owner-list publication
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Hoffmann" <f3lix.dev@gmx.de>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261113221220.162338-1-f3lix.dev@gmx.de>
References: <20261113221220.162338-1-f3lix.dev@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 22:34:06 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] perf: incomplete fix in perf_event_open() races on fork and
  context swap
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] perf: ABBA deadlock in perf_remove_from_owner() [1]
--

commit edd7543b84d380d1d23aa263c8f4c123c4e044c9
Author: Felix Hoffmann <f3lix.dev@gmx.de>

perf: Hold exec lock until owner-list publication

This commit keeps task->signal->exec_update_lock held in perf_event_open()
until the new event is added to current->perf_event_list, preventing a
concurrent target exec from calling perf_remove_from_owner() before
event->owner_entry is initialized.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 614f9f0e65005..315edee9bf3c3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14428,15 +14428,15 @@ SYSCALL_DEFINE5(perf_event_open,
> =20
>  	mutex_unlock(&ctx->mutex);
> =20
> +	mutex_lock(&current->perf_event_mutex);
> +	list_add_tail(&event->owner_entry, &current->perf_event_list);
> +	mutex_unlock(&current->perf_event_mutex);
> +
>  	if (task) {
>  		up_read(&task->signal->exec_update_lock);
>  		put_task_struct(task);
>  	}
> =20
> -	mutex_lock(&current->perf_event_mutex);
> -	list_add_tail(&event->owner_entry, &current->perf_event_list);
> -	mutex_unlock(&current->perf_event_mutex);
> -
>  	/*
>  	 * File reference in group guarantees that group_leader has been
>  	 * kept alive until we place the new event on the sibling_list.

[Severity: High]
Can perf_remove_from_owner() still reach an uninitialized
event->owner_entry if the target task forks and swaps contexts before
perf_event_open() acquires current->perf_event_mutex?

Holding task->signal->exec_update_lock blocks execve() on the target task,
but does not block fork().  When an event has both inherit and
remove_on_exec set, the target task can fork right after perf_unpin_context=
()
and mutex_unlock(&ctx->mutex), swap ctx into the child during context
switch via perf_event_context_sched_out(), and let the child exec under its
own signal->exec_update_lock:

CPU0 (opener)                     CPU1 (target task -> child)
perf_event_open()
  event->owner =3D current
  perf_install_in_context(ctx, event, ...)
  perf_unpin_context(ctx)
  mutex_unlock(&ctx->mutex)
                                  copy_process()
                                    perf_event_init_context()
                                  perf_event_context_sched_out()
                                    /* swaps ctx into child */
                                  execve() [in child]
                                    ...
                                      perf_event_remove_on_exec()
                                        perf_remove_from_owner(event)
                                          list_del_init(&event->owner_entry)
                                            <-- NULL dereference
                                          event->owner =3D NULL
  mutex_lock(&current->perf_event_mutex)
  list_add_tail(&event->owner_entry,
                &current->perf_event_list)

In addition to the NULL pointer dereference in list_del_init() on the
zeroed owner_entry, perf_remove_from_owner() clears event->owner before
list_add_tail() runs, so perf_event_release_kernel() later skips unlinking
the event and leaves a freed event on current->perf_event_list.

[Severity: High]
This problem wasn't introduced by this patch, but can
perf_remove_from_owner() and perf_event_task_enable() cause an ABBA
deadlock [1] between ctx->mutex and perf_event_mutex?

When Task A opens a remove_on_exec event on Task B and calls
prctl(PR_TASK_PERF_EVENTS_ENABLE) while Task B calls execve(), the two
paths take perf_event_mutex and ctx->mutex in opposite orders:

CPU0 (Task A)                     CPU1 (Task B)
----                              ----
lock(&Task_A->perf_event_mutex)
                                  lock(&Task_B_ctx->mutex)
lock(&Task_B_ctx->mutex)
                                  lock(&Task_A->perf_event_mutex)

 *** DEADLOCK ***

CPU0: perf_event_task_enable() -> perf_event_ctx_lock()
CPU1: perf_event_exec() -> perf_event_remove_on_exec() ->
      perf_remove_from_owner()

The SINGLE_DEPTH_NESTING annotation on mutex_lock_nested() in
perf_remove_from_owner() places owner->perf_event_mutex in subclass 1,
which also hides this cycle from lockdep.

[1] https://sashiko.dev/#/bug/linux-342ff44b-cc35-4e1e-a35b-b682a94d40dd

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113221220.1623=
38-1-f3lix.dev@gmx.de?part=3D1
