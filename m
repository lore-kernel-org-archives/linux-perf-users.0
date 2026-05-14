Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D25A39EF39
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778794591; cv=none; b=X2QHyJz960ifO0QTXNCf8G9o9SEH7of6D7EG9G5bA4GvC1J2USrRVNOfNIqlDLMOpZNfC1xFacJiBa9R4OzKCRWJPRAN0LvhlLj9il+0Rzbz5AhJSWRGq0u5Mzg5iLUj9O/TvLYhrenmroRk3qOE7alAUQ1XkHLvn81fLd+dbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778794591; c=relaxed/simple;
	bh=/x8p3sgkCx85CzU/WPAgl+3i/5AkvCfR3slDqjGXEZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MjFmH9Vfd1WPuR65/1lL3LAqaVQsbCNmT6UF5GOJs3dJwN456x0I+YzmtDdTGoeVhWIk5rBcWjOmcT6TwxAtC7jxLJXb5Dxol8uR/N1NDDnVaJDd0m568rR+hEtPVwlugvlTsdeRLpYhf5jKWnYED27i5LKiYd92huWrI8NlApg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujFoVeqJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujFoVeqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF2B0C2BCB3;
	Thu, 14 May 2026 21:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778794590;
	bh=/x8p3sgkCx85CzU/WPAgl+3i/5AkvCfR3slDqjGXEZk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ujFoVeqJx7EhH5W2OAHsce+6jFumM54+X8NLzwez/o3R9AxdX6p8LLfD5m+vtMC1q
	 CHo9y5w41JYEZDtUx2U1nM9CNpNAL1vuOqD7VbahnB0o+miaOM1vSqAa4Dph30hMPQ
	 uc4JOzMH7HXewRpb7SxaxSrzMJ0wOVFqLoLVWP9QOtZfg+83LZcl0P4OjGCNeUNuYL
	 gU+5gJnJl+BJNl2KlJBsv7Jnzv/abt4134AWkfYhxoFcghhXygnNkSk/OJ/cIIgdew
	 YD1THPw9EinZsz1JeNoZcYLERIXfXT9Al2NCVm/xdD42I4+q7YpuGq/ogZCEIZKOZ5
	 ZvaiCOYrhMz+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf/core: Ignore overflows while disable is
 pending
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514-arm_cs_clean_perf_handle-v2-2-cbb29c3b3661@arm.com>
References: <20260514-arm_cs_clean_perf_handle-v2-2-cbb29c3b3661@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:36:30 +0000
Message-Id: <20260514213630.BF2B0C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Removing the synchronous PMU stop causes an NMI storm and temporar=
y CPU livelocks when an event reaches its limit.
- [High] Spurious execution of BPF programs and AUX handlers thousands of t=
imes beyond the requested event limit.
- [High] A Time-of-Check to Time-of-Use (TOCTOU) race clobbers POLL_HUP and=
 allows sample recording beyond the limit.
--

commit 17c3cee582aa984c752ecbdcaf9da672f9cf95c3
Author: Leo Yan <leo.yan@arm.com>
perf/core: Ignore overflows while disable is pending

This commit removes the direct PMU stop when an event reaches its limit,
relying instead on the irq_work queued by perf_event_disable_inatomic().
It also adds a check for pending_disable to skip further overflow processin=
g.

Link: https://lore.kernel.org/lkml/aICYAqM5EQUlTqtX@li-2b55cdcc-350b-11b2-a=
85c-a78bff51fc11.ibm.com/

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
[ ... ]
> @@ -10745,12 +10745,18 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
>  	 * events
>  	 */
> =20
> +	/*
> +	 * Disable is pending, skip further overflow processing so the pending
> +	 * POLL_HUP is preserved and no samples are recorded beyond the limit.
> +	 */
> +	if (event->pending_disable)
> +		goto out;
> +

Looking at __perf_event_overflow(), this pending_disable check is placed af=
ter
the executions of perf_event_aux_pause() and bpf_overflow_handler().

Since removing the synchronous PMU stop delays hardware stopping until the
irq_work runs, could this cause the attached BPF programs and AUX handlers =
to
be spuriously invoked thousands of times beyond the event limit before this
check skips the rest of the function?

>  	event->pending_kill =3D POLL_IN;
>  	if (events && atomic_dec_and_test(&event->event_limit)) {
>  		ret =3D 1;
>  		event->pending_kill =3D POLL_HUP;
>  		perf_event_disable_inatomic(event);
> -		event->pmu->stop(event, 0);

Does removing the direct PMU stop here cause an NMI storm?

Because NMIs have higher priority than standard interrupts used for irq_wor=
k,
it appears a high-frequency PMU event could immediately generate another NMI
upon returning from the interrupt handler. Architecture-specific handlers
typically re-arm the counter, potentially creating a tight NMI loop that
starves the irq_work until __perf_event_account_interrupt() forces throttli=
ng
by reaching max_samples_per_tick.

Additionally, can a race condition occur when the irq_work eventually runs?

__perf_pending_disable() clears the flag before stopping the hardware:

__perf_pending_disable()
    if (event->pending_disable) {
        event->pending_disable =3D 0;
        perf_event_disable_local(event);
    }

If an NMI fires in the exact window between clearing the flag and the PMU
being disabled, __perf_event_overflow() would see pending_disable =3D=3D 0.
It would then bypass the new goto out check, unconditionally set
event->pending_kill =3D POLL_IN, clobber the previously set POLL_HUP, and
record a sample beyond the requested limit.

>  	}
> =20
>  	if (event->attr.sigtrap) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-arm_cs_cle=
an_perf_handle-v2-0-cbb29c3b3661@arm.com?part=3D2
