Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C13E363C6C
	for <linux-perf-users@vger.kernel.org>; Mon,  4 May 2026 21:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931710; cv=none; b=kG2LziAm94x5l1N8IZEkp6GUEnEATRXv+unyNgX5LNv4KI4YXD1mgxkvjspRwWjs9M+m4CIlE+GElmr0e1VaqmTQBF/7/dRLJPwW2cy8/jTBfjIAyWLBwjaf9sP3z2cCd53RptBbyW9Z8dOyStYKLAju0ioWbZqgWeTvTYTFdnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931710; c=relaxed/simple;
	bh=469haBsdyrPgaf9pD8AJadG4gskAKb0W8vCI8rXFe08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U3VJhq0YEGjxD2tcnzWWCUk9B7XMS7AKP8KDnE6qNt6nrZXhfnUjWJUwC81e/TFDd/tXH+eVLliB0t0xT9/AMWrquOUM5MOiAEzqKY5gatfqi5eMFMM93IIWjhvSdViGzu6164f+6c7fCcovP2ORpHAOlB26VoJXE0kApFbTf2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e0wRbdwn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e0wRbdwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9EF0C2BCB8;
	Mon,  4 May 2026 21:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931710;
	bh=469haBsdyrPgaf9pD8AJadG4gskAKb0W8vCI8rXFe08=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=e0wRbdwnUwthU6UczSffsJMI1OyO9yx7gQ93yjd/LMZaXwBydVOIgBgbUy6gINMQy
	 d+fFnWOp15YnvFx0t5DYKIM+ppTWvNrVTBBMcTrZp0Uw5BgDgNEZrpHjoxGNTmuJYs
	 yMbTUSivBXOqutSuwaHCR1q+p09Y1qRFCu7Uvinjh1/eq6cdV8DnvOhoBHOnJoiTap
	 7x/4BIDFEb1hOxWD13x+8KPNur7yW20l8nCl78MeCQFu5ULc13vLKvx1soGEZpYi4x
	 VcusoFSHIdTRKVO4Y6j7Yl1upN/9SBtXBQ/o7zn3OT5SJYYPSltLSjbTZiC1So/kNL
	 VBwJEDkuZ/AKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/20] perf: Add perf_pmu_resched_update()
Reply-To: sashiko@lists.linux.dev
To: "Colton Lewis" <coltonlewis@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260504211813.1804997-13-coltonlewis@google.com>
References: <20260504211813.1804997-13-coltonlewis@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 04 May 2026 21:55:08 +0000
Message-Id: <20260504215509.C9EF0C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Deadlock vulnerability in exported perf_pmu_resched_update() API d=
ue to missing interrupt disablement
- [Medium] Undocumented strict atomic context constraints for the update ca=
llback risk PREEMPT_RT lock inversion
--

commit bfd872050e6147889915de2de8e49972cd31d5f4
Author: Colton Lewis <coltonlewis@google.com>

perf: Add perf_pmu_resched_update()

This commit introduces perf_pmu_resched_update() to allow dynamic modificat=
ion
of PMU guest counter reservations safely. It takes a callback that is execu=
ted
between scheduling perf events out and back in.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 89b40e4397177..62fec73caabad 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -3021,6 +3022,9 @@ static void ctx_resched(struct perf_cpu_context *cp=
uctx,
>  	else if (event_type & EVENT_PINNED)
>  		ctx_sched_out(&cpuctx->ctx, pmu, EVENT_FLEXIBLE);
> =20
> +	if (update)
> +		update(pmu, data);

Are there restrictions on what this update callback can do?

Because the callback is synchronously invoked while holding the perf context
raw_spinlock_t locks, any attempt to acquire a standard spinlock_t, allocate
memory, or block will trigger a sleeping while atomic bug or a lock inversi=
on
panic on PREEMPT_RT kernels.

Could we document these strict atomic context requirements so future callers
using this exported API do not inadvertently crash the kernel?

> +
>  	perf_event_sched_in(cpuctx, task_ctx, pmu, 0);
> =20
>  	for_each_epc(epc, &cpuctx->ctx, pmu, 0)

[ ... ]

> @@ -3032,6 +3036,24 @@ static void ctx_resched(struct perf_cpu_context *c=
puctx,
>  	}
>  }
> =20
> +static void ctx_resched(struct perf_cpu_context *cpuctx,
> +			struct perf_event_context *task_ctx,
> +			struct pmu *pmu, enum event_type_t event_type)
> +{
> +	__ctx_resched(cpuctx, task_ctx, pmu, event_type, NULL, NULL);
> +}
> +
> +void perf_pmu_resched_update(struct pmu *pmu, void (*update)(struct pmu =
*, void *), void *data)
> +{
> +	struct perf_cpu_context *cpuctx =3D this_cpu_ptr(&perf_cpu_context);
> +	struct perf_event_context *task_ctx =3D cpuctx->task_ctx;
> +
> +	perf_ctx_lock(cpuctx, task_ctx);

Can this cause a deadlock if a hardware interrupt fires?

Looking at perf_ctx_lock(), it uses raw_spin_lock(&ctx->lock) which disables
preemption but leaves local interrupts enabled. If a Performance Monitoring
Interrupt or a timer tick executing perf_event_task_tick() fires on this CPU
while the lock is held, the interrupt handler will attempt to acquire the
same raw spinlock.

Should this function disable local interrupts (e.g., using local_irq_save())
before retrieving the CPU pointer and acquiring the locks?

> +	__ctx_resched(cpuctx, task_ctx, pmu, EVENT_ALL|EVENT_CPU, update, data);
> +	perf_ctx_unlock(cpuctx, task_ctx);
> +}
> +EXPORT_SYMBOL_GPL(perf_pmu_resched_update);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504211813.1804=
997-1-coltonlewis@google.com?part=3D12
