Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B4D346AFD
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 22:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415047; cv=none; b=SS8VlL6yYgoSnVBBmMpxhVFP7VHbK98HDP8ZWDwh++K8MD9gRvOq6rskv0IZZMTnHKt9Sy3ZKCwLLt/I7dkPHsRecu9x9r31LCHk6YHpf1ACGQuOHz/eajV9Wc8FcqixlB8e14xloB6DKH5Iit1HULrmOKd4JBL6GSqwhFk/pGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415047; c=relaxed/simple;
	bh=BO6A9JcLgLUlm4aI+kohvIw6SBLIKdrNhDm3992p8XA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Q7XXC8d9Ryocyo41Y0H64xLI8Vumpf4yb/tV1g6qk/XOHJTIWwvySxmlLRkAw+Pec8QtJ/hUvHyLo9871q5+iC+FIQbpETepLjcwRL6YjGnOADs2EXpUEEEX6Wlxvu1dYHrNa8Q424xvGJrwV/xF0i5j8kUwGTDzUILQkNBJHO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfyrKxbk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfyrKxbk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DAC2BCAF;
	Tue, 28 Apr 2026 22:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777415046;
	bh=BO6A9JcLgLUlm4aI+kohvIw6SBLIKdrNhDm3992p8XA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=bfyrKxbkN5WRodRBoeFoRvoQQSfuEvk0n7I0Ueb3mY0RcXX4K2dFCuRQq0MYwhuhD
	 VH2QxDpnee6YuyOVXFHDIreXoN7Mu7JoUmYDjAM6Udceu/m4GS1Cu9gS5z/B5hhLj5
	 IovsdbbVJ/uSzAilfXMY7E9dOJJ3QNweNQ9rszl3tt45WAMXuFSwn03an+Nwc+S2YF
	 VqVEkYkFAIzHzzdHTt7dlySDDXIQ59mYe/HTl752o0YSba8ie1FbQnMkgR6yHvBLE4
	 z5z4WFOrHThVHX6NxIsab7+dlSKU35MQfxv/ZM2CMiwc0gwNx5vuxFNB70BN9zUoUE
	 20TxS1L5Hbz3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Fix sampling period inconsistency across CPU
 migration
Reply-To: sashiko@lists.linux.dev
To: "Minwoo Ahn" <mwahn402@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260428115317.22839-1-mwahn402@gmail.com>
References: <20260428115317.22839-1-mwahn402@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 22:24:06 +0000
Message-Id: <20260428222406.B68DAC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Use-After-Free of perf_event_context in perf_get_task_ctxp() d=
ue to lockless task->perf_event_ctxp access.
- [High] IRQ inversion deadlock in perf_get_task_ctxp() due to raw_spin_loc=
k() without disabling interrupts.
- [High] State corruption and logic flaw due to missing event type validati=
on in perf_event_equal_task_ctx().
--

commit 9f612ffa1ab8888251bf71b52ebf7bdaadacbb11
Author: Minwoo Ahn <mwahn402@gmail.com>

perf/core: Fix sampling period inconsistency across CPU migration

This commit introduces a per-task container to preserve period_left across
CPU migrations for software sampling events. The context is shared across
multiple per-CPU perf_event instances originating from the same caller via
refcounting.

> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..84827f81cc9c 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
[ ... ]
> @@ -1148,6 +1151,21 @@ struct perf_cpu_context {
>  	struct perf_event		*heap_default[2];
>  };
> =20
> +#define perf_event_equal_task_ctx(a1, a2)	\
> +	((a1)->config =3D=3D (a2)->config &&	\
> +	 (a1)->sample_period =3D=3D (a2)->sample_period)

Should this macro also compare attr.type? Since it only compares config
and sample_period, unrelated events with small config IDs (such as an
inherited hardware event and a software CPU-clock event that both have a
config of 0) could erroneously match. This would cause independent sampling
sessions to share state and overwrite each other's period_left.

> +
> +/**
> + * struct perf_task_context - per-task software event context
> + *
> + * Shared across per-CPU perf_event instances of the same task to
> + * preserve period_left across CPU migrations.
> + */
> +struct perf_task_context {
> +	refcount_t			refcount;
> +	local64_t			period_left;
> +};
[ ... ]
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6d1f8bad7e1c..bd106e0b854a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -13259,6 +13291,40 @@ static void account_event(struct perf_event *eve=
nt)
>  	account_pmu_sb_event(event);
>  }
> =20
> +static struct perf_task_context *
> +perf_get_task_ctxp(struct perf_event *event, struct task_struct *task,
> +		   bool inherit)
> +{
> +	struct perf_task_context *ctxp =3D NULL;
> +	struct perf_event_context *ctx =3D task->perf_event_ctxp;

Does this code risk a use-after-free of the perf_event_context?

The task->perf_event_ctxp pointer is read directly into the local ctx
variable without holding rcu_read_lock() or using the safe
perf_lock_task_context() helper.

Although the target task_struct is pinned by get_task_struct(), the
perf_event_context it points to is dynamically managed. If the target task
exits concurrently, perf_event_exit_task() could set task->perf_event_ctxp
to NULL and schedule the context for destruction.

Because this accesses the context outside an RCU read-side critical section,
the allocating thread could be preempted while the RCU grace period elapses,
allowing the context memory to be freed before the lock is acquired below.

> +	struct perf_event *iter;
> +
> +	if (ctx) {
> +		raw_spin_lock(&ctx->lock);

Could this cause an IRQ inversion deadlock?

perf_get_task_ctxp() is called from perf_event_alloc() during the
sys_perf_event_open syscall, which executes in a sleepable process context
with hardware interrupts enabled.

ctx->lock is an IRQ-safe raw spinlock heavily used in hardirq contexts.
If a timer or PMU interrupt fires on the local CPU while this lock is held,
the interrupt handler could attempt to acquire the same ctx->lock, resulting
in an immediate IRQ inversion deadlock that hangs the CPU.

> +		list_for_each_entry(iter, &ctx->event_list, event_entry) {
> +			if (iter->perf_task_ctxp &&
> +			    (iter->owner =3D=3D current ||
> +			     (inherit && !iter->owner)) &&
> +			    perf_event_equal_task_ctx(&iter->attr,
> +						     &event->attr)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260428115317.2283=
9-1-mwahn402@gmail.com?part=3D1
