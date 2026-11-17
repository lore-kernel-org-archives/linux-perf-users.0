Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916402;
	b=hlQAUgvVNVV7T19syg6tswMVpifeo75Ii6ASvmvB3XK3TCf31WRcMVtYPM0cob9ruJH0
	 srqq/Hj2XvmTvKzwjMLJb1wFelUqn2SG00Aaa46B2w7saYur2LgEr8xpeLLnrBXk5VgyR
	 AUesrJf9eisENG7SJRzkTlAIZVGHrC5HUcdRRv4PxHS5tAkgvwRpeEqHK3+rpvF9YWWj8
	 3On9iAgll4xBxuN53ntE1uNUVbn9zjq9bXMC1+Sb9vZj9R0v14uF3zP2X6L/koLeAz+Dq
	 K10vw5DChzvvH1E4ByiFQy0xO80ptMjO0+2aSF1Mbp/TUJhlK1+88NDMid/fJ6ZRQcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916402;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5s7vheyCjRb/Pxl4938rIQLlnjSlQ/TdLVc+mBhMKGk=;
	b=5s1HA2GjQOkjEqBq8N0i77qP+2EJKXZ+uoo3BJBYZtkFgzfwt8pP9BNDbE72jnvvXbK4
	 QeSl/Of2na5NxgW0L96BQRK3D4nvHQml1X9YxVRu6CQcDaJEdZ9cUuKyqNW74I0b+jBWb
	 lG0DfGdEENY62LV5ZRxRFziYLmU0r8ttX8Bzdads94GQioDbXit86rantD6irXqaI3q7/
	 lhLv1IddtPGTOss72Wpj4yotB1XTLvinejqUxsUDMjnV/970I8RVwl9mijBSOoozqxR3P
	 kv0dhWQWtw9udHzj1Df68LAmUY2kVgdeAL+t6gn79HCqLVpQo/ueS1LvwJMjjdtIdng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD+UuuiB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E3D606A32A
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 11:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lD+UuuiB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CEC1F000C5;
	Tue, 17 Nov 2026 11:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794916402;
	bh=5s7vheyCjRb/Pxl4938rIQLlnjSlQ/TdLVc+mBhMKGk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lD+UuuiBTk9XpmH6JrXv/mP47ECp8CXHQYUyv4OeyvPRT0mq+//BL59upGNxKDah9
	 Fdms7b160KzHOJzU4YmkQuKfCYbqp1X54SlfdiU9rgjLv7dCBMftu2BHB577fck/Bk
	 smyI8d/aucdKkTcyzGxIMB/aU/Jh3t0m8qDA/fBH2p83fdklZNeH6C/aF5CjV9rS6q
	 Usg7Td294MfH7YbwrzXYRAVh51fQAZtg9Cdq9FX5uffu7X/vxFZdOP1SbTjx8XOd6A
	 fhlyM05QYH94F5IGotbHIiNq02Et3S2ZR9VrB5klTvMkrYo2sFj4eVHj2arc1FZvqE
	 pBOgyZw/67hQQ==
Message-ID: <sashiko-outbox-218736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
References: <cover.1794914794.git.wutengda@huaweicloud.com>
 <cff9b939758dad9f16bb4eb0483c63b7787e62bb.1794914794.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 11:53:21 +0000
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
- [Medium] perf/core: list_del_event() drops nr_no_switch_fast before
  perf_pending_task()
--

commit a5820a5e4b514a31e08f42157caca3b1bf8abed1
Author: Tengda Wu <wutengda@huaweicloud.com>

perf/core: Disable context fast-swap for sigtrap events

This commit disables the context switch fast-swap path for contexts contain=
ing
sigtrap events by accounting attr->sigtrap in nr_no_switch_fast during
list_add_event() and list_del_event() instead of __perf_event_overflow() and
perf_pending_task().

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index da86bc6e8be94..9fc8db14c6b83 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1999,7 +1999,7 @@ list_add_event(struct perf_event *event, struct per=
f_event_context *ctx)
>  		ctx->nr_user++;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat++;
> -	if (has_inherit_and_sample_read(&event->attr))
> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>  		local_inc(&ctx->nr_no_switch_fast);
> =20
>  	if (event->state > PERF_EVENT_STATE_OFF)
> @@ -2225,7 +2225,7 @@ list_del_event(struct perf_event *event, struct per=
f_event_context *ctx)
>  		ctx->nr_user--;
>  	if (event->attr.inherit_stat)
>  		ctx->nr_stat--;
> -	if (has_inherit_and_sample_read(&event->attr))
> +	if (has_inherit_and_sample_read(&event->attr) || event->attr.sigtrap)
>  		local_dec(&ctx->nr_no_switch_fast);
> =20
>  	list_del_rcu(&event->event_entry);

[ ... ]

> @@ -7758,7 +7763,6 @@ static void perf_pending_task(struct callback_head =
*head)
> =20
>  	if (smp_load_acquire(&event->pending_work)) {
>  		perf_sigtrap(event);
> -		local_dec(&event->ctx->nr_no_switch_fast);
>  		/*
>  		 * Ensure the pending work is fully handled before allowing
>  		 * another overflow to queue it. See __perf_event_overflow().
> @@ -10935,7 +10939,6 @@ static int __perf_event_overflow(struct perf_even=
t *event,
>  		 */
>  		if (cmpxchg_acquire(&event->pending_work, 0, pending_id) =3D=3D 0) {
>  			if (!task_work_add(current, &event->pending_task, notify_mode)) {
> -				local_inc(&event->ctx->nr_no_switch_fast);
>  				WARN_ON_ONCE(!atomic_long_inc_not_zero(&event->refcount));
> =20
>  				event->pending_addr =3D 0;

[Severity: Medium]
Can ctx->nr_no_switch_fast drop to zero while event->pending_task is still
queued if the sigtrap event is detached before perf_pending_task() runs?

Detaching an event does not cancel or flush event->pending_task; instead,
pending_task holds a reference to the event until the task returns to user
space.  When a parent event with attr.inherit and attr.sigtrap is closed wh=
ile
a child event has pending_task queued, perf_event_release_kernel() detaches=
 the
child events from their cloned contexts without uncloning them:

CPU0 (task A)                     CPU1
__perf_event_overflow(child_A)
  task_work_add(A, &child_A->pending_task)
                                  perf_event_release_kernel(parent)
                                    perf_remove_from_context(child_A, ...)
                                      list_del_event(child_A, ctx_A)
                                        local_dec(&ctx_A->nr_no_switch_fast)
                                    perf_remove_from_context(child_B, ...)
                                      list_del_event(child_B, ctx_B)
                                        local_dec(&ctx_B->nr_no_switch_fast)
schedule() (A -> B)
  perf_event_context_sched_out(A, B)
    /* context_equiv(ctx_A, ctx_B) && nr_no_switch_fast =3D=3D 0 */
    WRITE_ONCE(ctx_A->task, B)
...
perf_pending_task(&child_A->pending_task)
  perf_sigtrap(child_A)
    WARN_ON_ONCE(event->ctx->task !=3D current)  <-- trips WARN, drops SIGT=
RAP

Keeping the increment in __perf_event_overflow() and decrement in
perf_pending_task() alongside list_add_event() and list_del_event() would k=
eep
nr_no_switch_fast elevated until pending_task completes.  Note that because
list_add_event() and list_del_event() can run on a remote CPU under ctx->lo=
ck
while __perf_event_overflow() or perf_pending_task() runs on ctx->task's CPU
without ctx->lock, nr_no_switch_fast would also need to be atomic_t rather =
than
CPU-local local_t.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794914794.gi=
t.wutengda@huaweicloud.com?part=3D2
