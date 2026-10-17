Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D625A375F80
	for <linux-perf-users@vger.kernel.org>; Sat, 17 Oct 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250730; cv=none; b=i/GUT+pchEuIOkpSCfhxq8+wTUiv6RF8Gsaiszhpfnng7dKSxEl8P/DKal2PsSi3HCGalgka8KCW3N0W5Glkjcs1Kh/sMXR3DvpPR7xejDVemPO7c+7vlerbGUOM2MsO/cBNi3CeriqqOKV5u0vtpSKXvXsxl4NkTDOUchMqN4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250730; c=relaxed/simple;
	bh=HLmvtTSHT8vWIqh8BL2SaTqVeUVpCysaJmIhAqtifXY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PU1L4Iiu8kFfWXpRLGPsxLEs+meWniZdC9gj/kSY6t/RnryF9f7LlUt4LuWvEebUrXmMMCfJ0BZocOHGt8T1USWip65z0TZvy/CCcnM+liynfpWDvkgsbP2OW6faDtNzM7EtLT09M9eU/+NgPxSk8hSccY1LVoisnesOfGE++eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT2D3J1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT2D3J1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519141F000C4;
	Sat, 17 Oct 2026 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792250729;
	bh=z5iMnu3sG7ag60IyJGL1xhZwrCmR0runEmYzEeoknxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hT2D3J1FBkS3GChCxzXLtTzeORgKRVv2smpYihP8/DZ7Xu/iTWnKf1s5Bl7k7W12e
	 UsTOEbd9Ge1UrUmZR2/8u+Pr/nv+NCvviOvB4xousCO6R+qnQDT1Wz/OztFfONb3l7
	 BNYQmvBwzik5i+fQmgKkdFA/fbbwD/goWToHhjUkiZmISoaU3V0UrlV2fwIy1EZI02
	 7uSAuxi8glvzijiBEhBom/9bvKMoArKUcUbUVgYH/1VlzNCARkA8tFt5jwQCczzENx
	 x7gjWDOd9li/0orXMQbtC2sDnVlUsMVDivfnJa2oUFNPValqsJ2mHvZ/0Q6+P8GJUS
	 ftezAUqzPEYwA==
Message-ID: <sashiko-outbox-175581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] perf/core: Close owner-list publication race with
 remove-on-exec
Reply-To: sashiko-reviews@lists.linux.dev
To: "Daehyeon Ko" <4ncienth@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261017150747.1119197-1-4ncienth@gmail.com>
References: <20261015123416.795008-1-4ncienth@gmail.com>
 <20261016084508.GQ2009045@noisy.programming.kicks-ass.net>
 <20261017150747.1119197-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 15:25:28 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] perf/core: unpinning ctx before owner_entry link allows fork/s=
wap exec race
--

commit 32e21b1610ca28e8fe922d31bdbd5f0a4a31607c
Author: Daehyeon Ko <4ncienth@gmail.com>

perf/core: Close owner-list publication race with remove-on-exec

This commit keeps the target task's exec_update_lock held in perf_event_ope=
n()
until event->owner_entry is added to current->perf_event_list, preventing a
concurrent target exec from running perf_remove_from_owner() on an unlinked
owner_entry.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7846d70be57f6..2fdd8d71dcd55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14246,15 +14246,15 @@ SYSCALL_DEFINE5(perf_event_open,
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

[Severity: Critical]
Can the same owner_entry race still happen if the target task forks and the
child execs before list_add_tail() runs?

In SYSCALL_DEFINE5(perf_event_open) in kernel/events/core.c, ctx is unpinned
and ctx->mutex is unlocked before event->owner_entry is linked onto
current->perf_event_list:

	event->owner =3D current;

	perf_install_in_context(ctx, event, event->cpu);
	perf_unpin_context(ctx);

	mutex_unlock(&ctx->mutex);

	mutex_lock(&current->perf_event_mutex);
	list_add_tail(&event->owner_entry, &current->perf_event_list);
	mutex_unlock(&current->perf_event_mutex);

Holding task->signal->exec_update_lock only blocks execve() on task's own
signal_struct. It does not prevent task from calling fork(), which runs
copy_process() -> perf_event_init_task() -> perf_event_init_context() witho=
ut
taking task->signal->exec_update_lock and allocates a new signal_struct wit=
h a
separate unlocked exec_update_lock for the child.

When an event is opened with attr.remove_on_exec =3D 1 and attr.inherit =3D=
 1,
perf_event_init_context() acquires ctx->mutex, inherits the event into
child_ctx, and marks child_ctx as a clone of ctx. Because perf_unpin_contex=
t()
already dropped ctx->pin_count to 0, context_equiv() allows the context swap
optimization:

kernel/events/core.c:context_equiv() {
	/* Pinning disables the swap optimization */
	if (ctx1->pin_count || ctx2->pin_count)
		return 0;
}

When switching from task to the newly forked child,
perf_event_context_sched_out() can then swap the unpinned original ctx onto=
 the
child task:

kernel/events/core.c:perf_event_context_sched_out() {
			WRITE_ONCE(ctx->task, next);
			WRITE_ONCE(next_ctx->task, task);

			perf_ctx_sched_task_cb(ctx, task, false);

			perf_ctx_enable(ctx, 0);

			RCU_INIT_POINTER(task->perf_event_ctxp, next_ctx);
			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
}

At that point, the original ctx containing the parent event (with
event->owner =3D=3D current and event->owner_entry still {NULL, NULL}) belo=
ngs to
the child process. If the child immediately calls execve() under its own
child->signal->exec_update_lock, begin_new_exec() -> perf_event_exec() ->
perf_event_remove_on_exec() iterates the swapped ctx->event_list:

kernel/events/core.c:perf_event_remove_on_exec() {
	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry) {
		if (!event->attr.remove_on_exec)
			continue;

		if (!is_kernel_event(event))
			perf_remove_from_owner(event);
}

Wouldn't this allow perf_remove_from_owner(event) to run before the opener
executes list_add_tail(&event->owner_entry, &current->perf_event_list), hit=
ting
the same list_del_init() corruption or use-after-free on
current->perf_event_list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017150747.1119=
197-1-4ncienth@gmail.com?part=3D1
