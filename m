Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792659594;
	b=kAbZTih6Lml04uHeBJI/irR69h0Ql6wU4Fg26g3haaUxw5igmUYuTbDu6lwJ+9TY1XTn
	 gM4CRpJy0TYH6eTqdutUSsZveauPX5hzF8/Qq2evjDMzk/BZhafQ/+MPvhjNORs1GBShj
	 GGcuCBjqUjtB2JTznIfg4M9NfMBxWepdNczqzZg9cYkkO/W24gkz9/El2udWmefhnccY8
	 7CKu2Omi3tIaXetkIiRCImwu6ze+bAkyglJ7ny9B6BCsNAmJLEdn01V1UMYeIe9f3HeuO
	 /n6MCPqjPhyFJize7MKKWH9WmAbP14RqktUNaj4qMfH41ZTq/vopDo8UuG1qpyoIWPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792659594;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=13heUonPIF6dmSpiSeOuPIIXkhUew54Ba9lRWd7DIro=;
	b=CJ+yta79WaoE6UcLsMavPiFP+IRggVQA7WUe2itfZR2seXyK81IBgenLTmrUdP7Z+/ZS
	 Ge3np4TEQyTdjUTHroXT6WzYBuSWh/Ad/O1QFNR8O7ycIknOXNhwgruKDXVIpLilmHVVQ
	 qub2BzXAio1hLYo1b56MZ+UZfCFfAqvWbc9RjUl8U2xqpMvawtH+xHGsZjDgBeSbTtFAd
	 zdEEzW0eIRH9hDsm1KspZDUf5dplEoHjPf7UGisrevdxR+9LA96QIn9TH8VZG35jWdZPn
	 ZOO9hVCGwhuoV6MrGjfZiRvmvUQCVBJOQXbm48nx1Dmpjv8vQ9m/Dm0Y5t4L2ZyaW1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cQy+p/sF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C98606A31A
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Oct 2026 08:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cQy+p/sF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7651F000C1;
	Thu, 22 Oct 2026 08:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792659593;
	bh=13heUonPIF6dmSpiSeOuPIIXkhUew54Ba9lRWd7DIro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cQy+p/sFzSPONhdEgfMC1Gic/E8raCmaHCJbCnaT7kB+C1H0isLBB4gg5bpkkxAo0
	 Gp/ieIS9XdFzJs01/Q6TAe4ox4PtzYyriUv8CN2WxBuk8PDfpbqgRM2QLlAZlgX3Oa
	 Na2plv9YOBqw/r9ZDMGRYCslcHeSr04aqNKW16sKnc4owE5PrKNV9epm58lVCCSzwf
	 8t+nZrPufcNGyMtlkeAoy96i+UuyhPRHa80F/3bV/Mvr6seFn+qTOgGTIORRCkUSt7
	 bf1Q6d7oNt5CBNiIv1UeWStgaK3gc53PMSZM/Nm+Yu2ETvutz7+iYtK/aw1kv5zkj7
	 hI3xOw99OQjow==
Message-ID: <sashiko-outbox-181223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Remove group siblings before the leader in
 move_group
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jun Yang" <juny24602@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261022083849.90948-1-juny24602@gmail.com>
References: <20261022083849.90948-1-juny24602@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 08:59:52 +0000
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
- [Critical] perf/core: use-after-free of sibling->pmu_ctx in perf_event_op=
en()
--

commit dae4cdd7da7aed3ce65185b981d41f47553d78fb
Author: Jun Yang <junvyyang@tencent.com>

perf/core: Remove group siblings before the leader in move_group

This commit changes the group migration path in perf_event_open() to remove
sibling events from the context before removing the group leader, so that a
concurrent context switch can still schedule active siblings out through the
leader.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index c180b174bac7c..d16178f3f53e6 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14335,14 +14335,15 @@ SYSCALL_DEFINE5(perf_event_open,
>  	 */
> =20
>  	if (move_group) {
> -		perf_remove_from_context(group_leader, 0);
> -		put_pmu_ctx(group_leader->pmu_ctx);
> -
> +		/* Keep siblings reachable by group_sched_out(). */
>  		for_each_sibling_event(sibling, group_leader) {
>  			perf_remove_from_context(sibling, 0);
>  			put_pmu_ctx(sibling->pmu_ctx);
>  		}
> =20
> +		perf_remove_from_context(group_leader, 0);
> +		put_pmu_ctx(group_leader->pmu_ctx);

[Severity: Critical]
Can calling put_pmu_ctx(sibling->pmu_ctx) before removing group_leader cause
a use-after-free of sibling->pmu_ctx during a concurrent context switch?

In a pure software group, a software sibling backed by a different software
PMU from group_leader (for example, perf_task_clock or perf_tracepoint pair=
ed
with a perf_swevent leader) keeps its own PMU because
in_software_context(group_leader) is true, and gets a separate
perf_event_pmu_context via find_get_pmu_context():

kernel/events/core.c:SYSCALL_DEFINE5(perf_event_open) {
    ...
    if (is_software_event(event) &&
        !in_software_context(group_leader)) {
        pmu =3D group_leader->pmu_ctx->pmu;
    }
    ...
    pmu_ctx =3D find_get_pmu_context(pmu, ctx, event);
    ...
    event->pmu_ctx =3D pmu_ctx;
}

When migrating that group to a hardware context (move_group =3D=3D 1),
perf_remove_from_context(sibling, 0) leaves sibling on
group_leader->sibling_list, and put_pmu_ctx(sibling->pmu_ctx) is now called
while group_leader is still active in ctx and before sibling->pmu_ctx is
reassigned to the new pmu_ctx.

If sibling holds the sole reference to its perf_event_pmu_context,
put_pmu_ctx() drops epc->refcount to zero and queues free_epc_rcu() via
call_rcu(). Because perf_event_open() runs in preemptible process context
holding only pmus_srcu and ctx->mutex, and subsequent
perf_remove_from_context() calls invoke event_function_call() ->
task_function_call(), an RCU grace period can elapse and free
sibling->pmu_ctx before perf_remove_from_context(group_leader, 0) completes.

If a concurrent context switch or reschedule on the target task's CPU invok=
es
group_sched_out() -> event_sched_out() or group_sched_in() ->
event_sched_in() for group_leader, both functions walk
group_leader->sibling_list and dereference event->pmu_ctx->pmu via
this_cpc(epc->pmu) before checking event->state:

kernel/events/core.c:event_sched_out() {
    struct perf_event_pmu_context *epc =3D event->pmu_ctx;
    struct perf_cpu_pmu_context *cpc =3D this_cpc(epc->pmu);
    enum perf_event_state state =3D PERF_EVENT_STATE_INACTIVE;
    ...
    if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
        return;
}

kernel/events/core.c:event_sched_in() {
    struct perf_event_pmu_context *epc =3D event->pmu_ctx;
    struct perf_cpu_pmu_context *cpc =3D this_cpc(epc->pmu);
    int ret =3D 0;
    ...
    if (event->state <=3D PERF_EVENT_STATE_OFF)
        return 0;
}

Should put_pmu_ctx(sibling->pmu_ctx) be deferred until after group_leader h=
as
been removed from ctx?

> +
>  		/*
>  		 * Install the group siblings before the group leader.
>  		 *

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022083849.9094=
8-1-juny24602@gmail.com?part=3D1
