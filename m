Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793960884;
	b=UM6gtgLsLjRwDEvO5lke/aYvRg8b32Y9Sv4ifYKS4Bu21MS4qZL9TlywFXXu8glUp8BJ
	 xKR1j6bQQCzvyKl7Cz8StKJ9LL9NpPMpiH/VozbasCBiZdlcImHZ2LhP78Gope1txtNTj
	 RvR3U+ZQFZxc13Ti7L6PzdkCm9GMY06HqZTAS4TBmAnlrMG8wVFIZ04vnA3BnBI+CfAoK
	 /ZytYivqn+4n4QRyOgpQyTg4B0vylpgWc6oSsdFqpa+5baTSKl6o93uAyjjhBOmxQVcHP
	 m0YHD/9txSIZ6e5hNXCIbNjeen70tzgnIodkvfenIYW/t9AQQD+qPvRc5GNwsLl+wNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793960884;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hkpzJXQ6NymbygvGbFVAsi1wFloIUtO9ytHgpuFkPrI=;
	b=w6gjdQPONjlM9RWGUeJbCDmzZCseDvwDhBfCJbzKdKtkR8zWkD9ll1iHx4ZAChR3yi/8
	 M6rDmg6a0LajDHJzAUSwO96gfc4gyi6FYXse4X6GcPVR7WTHp68I+SR81SPnAFzGt/xj7
	 ZOx8wPQGJlYOzMIr16a2OZkH7+u0fa0IGnp+6eu8bucHmKsgQ+t7B0kS5w0UWsxYR2Mci
	 ug3XiATpo7YSMolrZjfmf+8k1P5IgcCiyr89lyepcJdqptp0dcjDh4IOG/PGthEAP+ZEZ
	 33ecp05cJvP8lET5kaMYLxbqbnYruLRxIPVK19J+BB40U/4wEx8xceeL5zEmE0Z0LtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWyXAMmw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715E606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWyXAMmw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C79F1F0089F;
	Fri,  6 Nov 2026 10:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793960883;
	bh=hkpzJXQ6NymbygvGbFVAsi1wFloIUtO9ytHgpuFkPrI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GWyXAMmwudyemVza6RIFBai9yLG9xYWYzAPwurc5eyNkW/OBU7T6SxO3LqpeE3QeV
	 BZ1zcsJReq7D96a2wOMsFotP0EYQa6Hli9SZYd0ei1UVn5dvuK5Q1vmZtR5Y+5vBlh
	 xINerfExZV3t2pCzza2dpOY6XwDjq7NygbfCZsTkP6egIb1u0yYv/Fl+tYEYB2i2B0
	 M2pTGy9I5L3H2zppOap0A12TMAbQ4eEa/2SysEHA+UoETsAPEwQgfb6Ex2ShhLrzsW
	 v7xQRrS9QaeUz4RT86R07rVrpLRydeC+rUT4VZ98pPgxUCUBE8kxPL56CHdcZLpGBl
	 xwlMz4iwmBeYw==
Message-ID: <sashiko-outbox-201217@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Do not resurrect cpuctx->cgrp after last
 cgroup event exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Phat Dinh" <phatdt1116@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261106101642.494674-1-phatdt1116@gmail.com>
References: <20261106101642.494674-1-phatdt1116@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 10:28:02 +0000
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
- [High] perf/core: perf_cgroup_switch() skips pmu_ctx after last cgroup
  event disable
--

commit 16552da1b5b468a49aa24ce4ee62d6e477839323
Author: Phat Dinh <phatdt1116@gmail.com>

perf/core: Do not resurrect cpuctx->cgrp after last cgroup event exit

This commit avoids setting cpuctx->cgrp in perf_cgroup_switch() if
ctx_sched_out() disabled the last cgroup event on the CPU context.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f36a3bbaa33cf..54b87584c752e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1072,8 +1072,13 @@ static void perf_cgroup_switch(struct task_struct =
*task)
>  	 * must not be done before ctxswout due
>  	 * to update_cgrp_time_from_cpuctx() in
>  	 * ctx_sched_out()
> +	 *
> +	 * ctx_sched_out() can consume a pending disable and drop the last cgro=
up
> +	 * event, which clear the cpuctx->cgrp. Cgroup tracking follow active c=
group
> +	 * event, so do not resurrect it
>  	 */
> -	cpuctx->cgrp =3D cgrp;
> +	if (cpuctx->ctx.nr_cgroups)
> +		cpuctx->cgrp =3D cgrp;
>  	/*
>  	 * set cgrp before ctxsw in to allow
>  	 * perf_cgroup_set_timestamp() in ctx_sched_in()

[Severity: High]
Does perf_cgroup_switch() still leak pmu_disable_count and leave
non-cgroup per-CPU events unscheduled when ctx_sched_out() consumes a
pending_disable on the last cgroup event of a pmu_ctx?

Before ctx_sched_out(), perf_ctx_disable(&cpuctx->ctx, EVENT_CGROUP)
calls perf_pmu_disable(pmu_ctx->pmu) for each pmu_ctx with
pmu_ctx->nr_cgroups > 0, and ctx_sched_out() schedules out all events on
that pmu_ctx.  When event_sched_out() consumes event->pending_disable on
the last cgroup event of that pmu_ctx, perf_cgroup_event_disable()
decrements event->pmu_ctx->nr_cgroups to 0 alongside ctx->nr_cgroups.

The subsequent ctx_sched_in() and perf_ctx_enable() calls pass
EVENT_CGROUP to for_each_epc(), which skips the pmu_ctx:

kernel/events/core.c:perf_skip_pmu_ctx() {
	if ((event_type & EVENT_CGROUP) && !pmu_ctx->nr_cgroups)
		return true;
	...
}

As a result, perf_ctx_enable() never calls perf_pmu_enable(pmu_ctx->pmu),
leaving pmu_disable_count elevated and the PMU permanently disabled on
that CPU.  ctx_sched_in() also skips __pmu_ctx_sched_in() for that
pmu_ctx while setting cpuctx->ctx.is_active back to EVENT_ALL |
EVENT_TIME, leaving any non-cgroup per-CPU events on that PMU stuck in
PERF_EVENT_STATE_INACTIVE.  On x86 hardware PMUs, because x86_pmu_enable()
no longer runs to assign event->hw.idx, scheduling in and then scheduling
out a later hardware event calls x86_pmu_del() with event->hw.idx =3D=3D -1,
writing out of bounds to cpuc->dirty and cpuc->events[-1].

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106101642.4946=
74-1-phatdt1116@gmail.com?part=3D1
