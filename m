Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DA3F413B
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 21:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793049; cv=none; b=Ej+QzGnwPUUx4gYLosLXIvc1YSV81ahnfpd9hjNSJUhSYhuwSbQzQSTt00NYpo/c7SUqwAhxNZtPFpXd32fH5yIcLKFsB4tiaE7dFhoiKatBwOUITO9iNHYul73GbBS52MDnHo1aMFGnAeaf65wlcafBujURclJ+MwdKCu7uUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793049; c=relaxed/simple;
	bh=2H8EZNJvsnG5ZMbZBuyfGRIeAXQeDqmZVEhgvzaZJV8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jsvhRd2SrRNgNQs8EzsRCu1fQQHZGAbbetgIRj9s71YBAt7fCRM8nrgz09U6rEGi+0j9/5/SHQHPH09F8dMVTQ1V2WekqIBSsVYgTk3XKqbGLKnLyOx7u5qs2GXq0uKrlOzCp1wTj6dsrkeZ/k7ANNQS+INH+OMBPLF18IYy2NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iBkusTlY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iBkusTlY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB21C2BCB3;
	Thu, 14 May 2026 21:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778793048;
	bh=2H8EZNJvsnG5ZMbZBuyfGRIeAXQeDqmZVEhgvzaZJV8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=iBkusTlYRKfT0oE5ZAOc/1TsJEKBbJtfGaNMpmaV1IlJxwmRulISxtJyh6jrJe+Re
	 q7URd0g/+Ljuw6iFpmAct0qA59lKgxUL40Q5CU8jLnC1tlXL9QXDQMGwVOE8tEn4mR
	 z/BRbrUZx/aRSUvfxVGe455A8VTo1QpyM54zzS0n1vfX8R4V+YgU8kOr2g6BhX7DIg
	 mS1V0kIj4vX8YW3KJRoiIY5741A892CUpIJPXltcRJhrkzMyCK/yvQutJ84PJ3QfbW
	 rKSwV0XaYYIAbuo239wQgBPmWxz71PRFeA1wOm/4g+F8/j3fO7AVhwebLloxnVMDaQ
	 exS+2kJbHhk4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/core: Use AUX pause/resume for throttling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leo Yan" <leo.yan@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514-aux-throttle-fix-v1-1-92bdc84f5922@arm.com>
References: <20260514-aux-throttle-fix-v1-1-92bdc84f5922@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 21:10:48 +0000
Message-Id: <20260514211048.BFB21C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] The event->hw.aux_paused flag is permanently leaked when an event =
is unthrottled during a context switch, leaving the event paused forever.
- [High] Throttling overwrites and breaks the user-configured aux-action=3D=
pause state, overriding user intent.
- [High] Throttle requests from NMIs can be silently dropped due to the rec=
ursion guard in perf_event_aux_pause().
- [High] Throttling silently fails to stop the PMU if the event does not ha=
ve a mapped ring buffer.
- [High] The commit restricts its fix to PMUs with PERF_PMU_CAP_AUX_PAUSE, =
leaving other AUX PMUs broken and vulnerable to the same WARN_ON_ONCE(nest).
--

commit 1ca7736295ce051e131ce2cca7c64a9e4d034b68
Author: Leo Yan <leo.yan@arm.com>

perf/core: Use AUX pause/resume for throttling

Since commit 9734e25fbf5a ("perf: Fix the throttle logic for a group"), perf
throttles events in a group with pmu->stop(event, 0) and unthrottles them
with pmu->start(event, 0). For AUX trace PMUs, these callbacks also manage
AUX output state, which can trigger a kernel warning. This commit uses
perf_event_aux_pause() for throttling when the PMU supports it.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 7935d5663944e..33d049b9cccfa 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> @@ -2763,8 +2764,14 @@ static void perf_event_unthrottle(struct perf_even=
t *event, bool start)
>  		return;
> =20
>  	event->hw.interrupts =3D 0;
> -	if (start)
> -		event->pmu->start(event, 0);
> +
> +	if (start) {
> +		if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)
> +			perf_event_aux_pause(event, false);

If a task is scheduled out, the throttled event is stopped. When scheduled
back in, event_sched_in() detects the throttle state and calls
perf_event_unthrottle(event, false). Because start is false, the call to
perf_event_aux_pause(event, false) is skipped, meaning event->hw.aux_paused
is never cleared.

When event_sched_in() subsequently calls event->pmu->add(event, PERF_EF_STA=
RT),
PMU drivers check the leaked event->hw.aux_paused flag. Seeing it as 1, does
this cause a regression where the hardware starts in a paused state and nev=
er
resumes tracing?

Additionally, if a user or BPF program explicitly pauses an AUX event (e.g.,
via aux-action=3Dpause), event->hw.aux_paused is set to 1. If a sibling eve=
nt
overflows, the kernel throttles the group.

When the group is subsequently unthrottled, this calls
perf_event_aux_pause(event, false) which clears hw.aux_paused and resumes t=
he
PMU. Could this unconditionally override the user's explicit pause request,
starting tracing when it was intentionally halted?

> +		else
> +			event->pmu->start(event, 0);

This isn't a bug introduced by this patch, but doesn't restricting this fix=
 to
PMUs with PERF_PMU_CAP_AUX_PAUSE leave other AUX PMUs broken?

They still fall back to the original event->pmu->stop(event, 0) logic and w=
ill
suffer from the exact same unmatched perf_aux_output_begin() cycle and
subsequent kernel warning when unthrottled.

> +	}
> +
>  	if (event =3D=3D event->group_leader)
>  		perf_log_throttle(event, 1);
>  }

[ ... ]

> @@ -2775,7 +2782,12 @@ static void perf_event_throttle(struct perf_event =
*event)
>  		return;
> =20
>  	event->hw.interrupts =3D MAX_INTERRUPTS;
> -	event->pmu->stop(event, 0);
> +
> +	if (event->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)
> +		perf_event_aux_pause(event, true);

If an event group is unthrottled in timer context (e.g., sched_tick()) and =
is
executing perf_event_aux_pause(), an NMI from a sibling event overflow can
interrupt it.

The NMI handler attempts to throttle the group and calls
perf_event_aux_pause(). Looking at perf_event_aux_pause(), it has a recursi=
on
guard:

    if (READ_ONCE(rb->aux_in_pause_resume))
        break;

Since this breaks out early without pausing the hardware, and the fallback =
to
pmu->stop() was removed here, does the hardware event continue running desp=
ite
hw.interrupts =3D=3D MAX_INTERRUPTS? Could this defeat the throttling mecha=
nism
and cause NMI storms?

Furthermore, if an AUX event is active but has no mapped ring buffer
(event->rb =3D=3D NULL), perf_event_aux_pause() immediately returns early.

Since the unconditional call to event->pmu->stop(event, 0) was removed, does
this silently fail to stop the PMU if there's no mapped ring buffer?

> +	else
> +		event->pmu->stop(event, 0);
> +
>  	if (event =3D=3D event->group_leader)
>  		perf_log_throttle(event, 0);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514-aux-thrott=
le-fix-v1-1-92bdc84f5922@arm.com?part=3D1
