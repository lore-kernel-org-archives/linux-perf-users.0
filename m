Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872098;
	b=B5hCM4xYi65QJf8JlX+ufy723cnV94E/VtomMfS8XZOgVK3OoV1z8mOzkkPUwosMCYZC
	 ShiRJGGHxooI3VN6sdtDYM7WjvwvUhWxRJ/T2PHeUFVW0ulhbYxNlgfLqbqGk5T99qBuV
	 +LHEM53yXTqeWBokYhlyhJabkIQOEJQX3ts8QzZnEJNl+e1xUgjqXrjWraXPQC5etNDwF
	 QCaFNSkqWV/MfCO4ds1nIHG4YRQu0Rq1Rnq5okl2f11aMILgYk6uDoEB51YhReljRrRGE
	 mC5R1j1FjjAiCplp/Xs5WcUG8oPOZdUQtwbDg4z/ZiBhdSrlRrUNXBiIf5pHR2Cdodg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872098;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eGTBP4n3clgiIuhFp+cC01zQtjKRkmbMswY62P9v/40=;
	b=Ki7ieUXW3q6Z3yZCl8vOYqhvBxu6rgbNA9mXf2kP1yT4W160Ylzg+MqiPPk+z4CoXVf/
	 umoogvbqbk7DEU1m5DaOw1hwuZj5FbCKkvuxHVH3RZMsm0aOSkspIJbSinuWeBZ5rfC3v
	 Xiiogp1cS3zouq4Im7zVQ+q1kIPGihuYmZ0isBK83cyiJGp+2jtpDLTn1VoOKPw8vn7/j
	 4RzwuDYBpEHAdX11Ew1tiZgn4PpsQM2k6cnvDtmh5REroKmnRE47KALDzdhL9ZV7tZp8o
	 kVy7LDu3y65t3+DHqSlFnzY06ehhAIlOXdTX7mvOAtIGfFSNsHTZp8RdrWGtezM3JDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J53wDJim;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD29B606A32D
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Nov 2026 09:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J53wDJim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE661F000C1;
	Thu,  5 Nov 2026 09:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793872097;
	bh=eGTBP4n3clgiIuhFp+cC01zQtjKRkmbMswY62P9v/40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J53wDJimlZzb0Y2yWdHGFtgu0gzME4tKtmZ+29byvCEp/MPbXkZkHO2oHlgkBwDJl
	 fTxJcfFGNDYL+09H8bV28x2yKWCZBbCZUmXVO0bSM7LDKhwHfqS5xh1GBLsbFQ2l+O
	 ku9CXnv/Weleu8S6PUO25fIAOr8txU9vecjqIY7nHdr/SpDPiosLGKRGkHYaffR3F0
	 BFISKj74ufVwEhooQDO8nLgPLBl1wZdaZvFxEGx9TV+52VntXWA/zB84RI0jwFoq6X
	 QrRPGxKfan5hDGNjsttfvnzX6IMI3gTvzINpsJwxIy4kgS7mCMstw5PFIgDFVFoT1u
	 X4rkuZwRAsiDg==
Message-ID: <sashiko-outbox-198777@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] perf/core: Disable context fast-swap for sigtrap
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tengda Wu" <wutengda@huaweicloud.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
References: <cover.1793870900.git.wutengda@huaweicloud.com>
 <f19b29b90fe1d0126fa8f5cd0e7c8d7da07e5a34.1793870900.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 09:48:16 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf/core: non-SMP-atomic local_t race on ctx->nr_no_switch_fast
--

commit 6723e8dad1dd2932a4b047f419d5e1deb0db8c7c
Author: Tengda Wu <wutengda@huaweicloud.com>

perf/core: Disable context fast-swap for sigtrap events

This commit excludes events with attr.sigtrap from the context switch
fast-swap path by incrementing and decrementing ctx->nr_no_switch_fast in
list_add_event() and list_del_event(). This prevents ctx->task from being
swapped to another task while a sigtrap event is attached to the context.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 5842552294c19..1d4b16dc190db 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1067,10 +1067,8 @@ struct perf_event_context {
>  	 * should be avoided.
>  	 *
>  	 * Sum (event->pending_work + events with
> -	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)))
> -	 *
> -	 * The SIGTRAP is targeted at ctx->task, as such it won't do changing
> -	 * that until the signal is delivered.
> +	 *    (attr->inherit && (attr->sample_type & PERF_SAMPLE_READ)) +
> +	 *    events with attr->sigtrap)
>  	 */
>  	local_t				nr_no_switch_fast;
>  };
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7aac14663c80c..6964cd1e6bfec 100644
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

[Severity: High]
Can incrementing and decrementing ctx->nr_no_switch_fast here race across
CPUs because nr_no_switch_fast is a local_t rather than an atomic_t?

In struct perf_event_context, nr_no_switch_fast is declared as local_t,
where local_inc() and local_dec() are only CPU-local atomic (for example,
unlocked incq/decq on x86) and do not serialize concurrent read-modify-write
updates across different CPUs.

When installing a disabled sigtrap event into a non-empty task context,
perf_install_in_context() takes the fast path on the caller's CPU without
sending an IPI to the CPU running ctx->task:

kernel/events/core.c:perf_install_in_context() {
	...
	if (__perf_effective_state(event) =3D=3D PERF_EVENT_STATE_OFF &&
	    ctx->nr_events && !is_cgroup_event(event)) {
		raw_spin_lock_irq(&ctx->lock);
		if (ctx->task =3D=3D TASK_TOMBSTONE) {
			raw_spin_unlock_irq(&ctx->lock);
			return;
		}
		add_event_to_ctx(event, ctx);
		raw_spin_unlock_irq(&ctx->lock);
		return;
	}
	...
}

This runs add_event_to_ctx() -> list_add_event() ->
local_inc(&ctx->nr_no_switch_fast) on the installer CPU under ctx->lock.

Concurrently, on the CPU where ctx->task is running, an already-active
sigtrap event in the same context can overflow in __perf_event_overflow() or
complete task_work in perf_pending_task(), both of which modify
ctx->nr_no_switch_fast without holding ctx->lock:

kernel/events/core.c:__perf_event_overflow() {
	...
			if (!task_work_add(current, &event->pending_task, notify_mode)) {
				local_inc(&event->ctx->nr_no_switch_fast);
	...
}

kernel/events/core.c:perf_pending_task() {
	...
	if (event->pending_work) {
		event->pending_work =3D 0;
		perf_sigtrap(event);
		local_dec(&event->ctx->nr_no_switch_fast);
	}
	...
}

Similarly, if ctx becomes inactive (!ctx->is_active) while ctx->task still
has pending task_work in flight, perf_remove_from_context() ->
__perf_remove_from_context() -> list_del_event() can execute
local_dec(&ctx->nr_no_switch_fast) on a remote CPU concurrently with
perf_pending_task() executing local_dec(&event->ctx->nr_no_switch_fast) on
ctx->task's CPU.

Could these concurrent cross-CPU local_inc() and local_dec() operations lose
updates to ctx->nr_no_switch_fast, allowing the counter to drop to zero
while a sigtrap event is still attached and re-enabling the fast-swap path?
Should nr_no_switch_fast be converted from local_t to atomic_t?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793870900.gi=
t.wutengda@huaweicloud.com?part=3D2
