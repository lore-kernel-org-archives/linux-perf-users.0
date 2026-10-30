Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793334588;
	b=fyakXdpVYxadSQDcMZHf+IIwk0AnxrRJerSBjatK6KfB2WqyysSUnQieSWScbw6maUj2
	 SdjtNtbVr8UEUklPv03q/wcO56WLAkEUIwi9wB20R0P27wvlAeta5WfJK/9YHysp43Vw9
	 mEwYCDyAJ1cYj41+KERsAoEDuUHWUGvl9lm2U+WDGjfPmCKkOlG6JkHPOWNe/ysupx2tR
	 5gNFvoGb7YZly/5M3j73PyNDyIruS7HJQEOugv/bDdLWk2eHIyP3ojwODILssrbgQaQF4
	 0Xwrh9IWyyN4X+aYTK8LLBt777a/bqeY5PND/WT+Vr9kNCrMfUH5RWslD+CMfhI6qeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793334588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IYims4Zwriz42DEKJms/5Pdy5P4ZEji09+6q+40yVc8=;
	b=APCxxQabtzcxlQ55p9KyYmGKBNlv5lB8P2u+5/gQMGVEG2J+IfQ1Dj4112u+wS+uP35m
	 UBJXoi1BeLynPatBW3h8ot4wJfIRIBsTEzRwikzJBYOqOeEHwk7NnOOFrIXM9joDUn1E+
	 Q9vU0xMJcAYJONIcBvfFVw3CPWdP68SRmaGKBtKPbS19Q3JzFbDhT4RXFRy/jv5ODr2Dq
	 qzz1DpBAnO/Uwm2bPKv1fU4s4g2mg3U4RNoVREkL0XnkjjjBMTPs3h/QcLW0dPslxMaz6
	 JrRXlQ/W9SabKN8HHLK1gmwx2+mtFptSC0G27sHOaw+rkg2/WIewAUM2qCZnBFibzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggDaYxzj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F601606A322
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 04:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggDaYxzj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3EA1F00A02;
	Fri, 30 Oct 2026 04:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793334587;
	bh=IYims4Zwriz42DEKJms/5Pdy5P4ZEji09+6q+40yVc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ggDaYxzj5DAdBZSicW2cJuno+NBHfD1INiDHxXUEX0Q/04GAAjeKFXfwY4RQUKS3R
	 2UOq1sUKvfwI5tOc1SwafnFogf5Kpj2ZiFlOQwqRh2URWr5m54McfG8jfpQuyJGJka
	 Qry8Ze154wQXNtcRRHwJBgawUYINl/R41c6MXCocKJySmwvuVuy5AjxpNWcUa/0UvI
	 hzlHAhq8lL/PwPl+GwFmp5M8/pwy923EyiOUrzkA/U3ktvPlb+b7h1G8jqY7QEK8g3
	 zzAoO68+ToMolPZhHmRQwXjL5HmcnB38HXy3YOM1I47N1yJAN3wwOoYQk7CCS48Icu
	 qJDRzebkF7gww==
Message-ID: <sashiko-outbox-190300@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] alpha/perf: implement ProfileMe sampling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Turner" <mattst88@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261030-alpha-profileme-v2-3-c702f1c65272@gmail.com>
References: <20261030-alpha-profileme-v2-0-c702f1c65272@gmail.com>
 <20261030-alpha-profileme-v2-3-c702f1c65272@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:29:47 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] alpha/perf: missing ProfileMe overflow reset in alpha_pmu_del()
- [Medium] alpha/perf: stale PERF_HES_UPTODATE in alpha_pmu_stop() drops co=
unts
--

commit 52cd21b0cc0eea12519bbbab88ca2330695b853a
Author: Matt Turner <mattst88@gmail.com>

alpha/perf: implement ProfileMe sampling

This commit implements ProfileMe sampling mode on Alpha EV67 and later
processors, selectable via the profileme config bit or precise_ip. It
attributes samples to the instruction address latched in PMPC and handles
EV67 PALcode restrictions around stopped counters near overflow.

> diff --git a/arch/alpha/kernel/perf_event.c b/arch/alpha/kernel/perf_even=
t.c
> index 70840c05d39bf..c7f0ccf8ec804 100644
> --- a/arch/alpha/kernel/perf_event.c
> +++ b/arch/alpha/kernel/perf_event.c

[ ... ]

> @@ -457,7 +519,8 @@ static void maybe_change_configuration(struct cpu_hw_=
events *cpuc)
>  		}
> =20
>  		if (!(hwc->state & PERF_HES_STOPPED))
> -			cpuc->idx_mask |=3D (1<<cpuc->current_idx[j]);
> +			cpuc->idx_mask |=3D alpha_event_idx_mask(hwc,
> +							cpuc->current_idx[j]);
>  	}
>  	cpuc->config =3D cpuc->event[0]->hw.config_base;
>  }
> @@ -548,7 +611,7 @@ static void alpha_pmu_del(struct perf_event *event, i=
nt flags)
>  			alpha_perf_event_update(event, hwc, idx, 0);
>  			perf_event_update_userpage(event);
> =20
> -			cpuc->idx_mask &=3D ~(1UL<<idx);
> +			cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, idx);
>  			cpuc->n_events--;
>  			break;
>  		}

[Severity: High]
Can scheduling out a ProfileMe event via alpha_pmu_del() leave PCTR0 stopped
near overflow without clearing its overflow state?

In kernel/events/core.c, event_sched_out() removes an active event by calli=
ng
perf_pmu_disable() -> alpha_pmu_disable() followed directly by
event->pmu->del() -> alpha_pmu_del(), without calling alpha_pmu_stop():

  event_sched_out()
    perf_pmu_disable(event->pmu)
    event->pmu->del(event, 0) -> alpha_pmu_del()

Because alpha_pmu_del() does not call alpha_pmu_stop() or
alpha_write_pmc_profileme(), it looks like PCTR0 is not moved away from
overflow in several cases:

1. If a ProfileMe event is scheduled out via alpha_pmu_del() while a
   ProfileMe window is open (so PCTR0 has overflowed and stopped, before the
   window closes to generate a PMI) and no subsequent event rewrites PCTR0
   twice (for example, when cpuc->n_events becomes 0 on context switch or
   task exit, or when an Aggregate event on PCTR1 is scheduled in), PCTR0 is
   left disabled near overflow, which can block interrupts under EV67 PALco=
de
   restrictions 32 and 38.

2. During multiplexing in perf_rotate_context() or a context switch (which
   runs ctx_sched_out() and ctx_sched_in() with hardirqs disabled), if a
   ProfileMe window closes while IRQs are disabled, alpha_pmu_del() removes
   the ProfileMe event and ctx_sched_in() -> alpha_pmu_enable() ->
   maybe_change_configuration() schedules in an Aggregate event and overwri=
tes
   cpuc->config:

   arch/alpha/kernel/perf_event.c:maybe_change_configuration() {
       ...
       cpuc->config =3D cpuc->event[0]->hw.config_base;
   }

   If the new Aggregate event is on PCTR1, cpuc->config no longer has
   EV67_PCTR_MODE_PROFILEME set when IRQs are re-enabled and the pending
   PCTR0 interrupt reaches alpha_perf_event_irq_handler():

   arch/alpha/kernel/perf_event.c:alpha_perf_event_irq_handler() {
       ...
       if (unlikely(j =3D=3D cpuc->n_events)) {
           if (cpuc->config & EV67_PCTR_MODE_PROFILEME)
               alpha_write_pmc_profileme(-alpha_pmu->pmc_max_period[0]);
           wrperfmon(PERFMON_CMD_ENABLE, cpuc->idx_mask);
           return;
       }
   }

   And if the new Aggregate event is on PCTR0, alpha_write_pmc() only writes
   PCTR0 once and the pending PMI matches current_idx[0] =3D=3D 0, attribut=
ing
   an overflow to the new Aggregate event.

3. Similarly, if alpha_pmu_stop() is called with flags =3D=3D 0 (such as fr=
om
   perf_event_throttle()) after alpha_pmu_start() has cleared hwc->state to
   0, PERF_HES_UPTODATE is not set in hwc->state, so alpha_pmu_stop() also
   skips alpha_write_pmc_profileme().

Should alpha_pmu_del() (or a shared helper in alpha_pmu_stop() called from
alpha_pmu_del()) unconditionally clear PCTR0's overflow state when stopping
or removing a ProfileMe event?

> @@ -573,7 +636,7 @@ static void alpha_pmu_stop(struct perf_event *event, =
int flags)
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> =20
>  	if (!(hwc->state & PERF_HES_STOPPED)) {
> -		cpuc->idx_mask &=3D ~(1UL<<hwc->idx);
> +		cpuc->idx_mask &=3D ~alpha_event_idx_mask(hwc, hwc->idx);
>  		hwc->state |=3D PERF_HES_STOPPED;
>  	}
> =20
> @@ -583,7 +646,23 @@ static void alpha_pmu_stop(struct perf_event *event,=
 int flags)
>  	}
> =20
>  	if (cpuc->enabled)
> -		wrperfmon(PERFMON_CMD_DISABLE, (1UL<<hwc->idx));
> +		wrperfmon(PERFMON_CMD_DISABLE, alpha_event_idx_mask(hwc, hwc->idx));
> +
> +	/*
> +	 * A ProfileMe event can be stopped with a window open and PCTR0 just
> +	 * past overflow. Do not leave it there while it is disabled, see
> +	 * alpha_write_pmc_profileme(). The count was read above, so rebase
> +	 * prev_count on the value written.
> +	 */
> +	if ((hwc->flags & ALPHA_PERF_FLAG_PROFILEME) &&
> +	    (hwc->state & PERF_HES_UPTODATE)) {
> +		long left =3D local64_read(&hwc->period_left);
> +
> +		left =3D clamp(left, alpha_pmu->pmc_left[0],
> +			     (long)alpha_pmu->pmc_max_period[0]);
> +		local64_set(&hwc->prev_count, (unsigned long)(-left));
> +		alpha_write_pmc_profileme((unsigned long)(-left));
> +	}
>  }

[Severity: Medium]
Does alpha_pmu_stop() overwrite PCTR0 and hwc->prev_count with a stale
period_left when an event was started via alpha_pmu_add()?

When an event is scheduled in via event_sched_in() ->
alpha_pmu_add(event, PERF_EF_START), alpha_pmu_add() sets:

arch/alpha/kernel/perf_event.c:alpha_pmu_add() {
    ...
    hwc->state =3D PERF_HES_UPTODATE;
    if (!(flags & PERF_EF_START))
        hwc->state |=3D PERF_HES_STOPPED;
    ...
}

When alpha_pmu_enable() subsequently calls maybe_change_configuration() to
program the counter, PERF_HES_UPTODATE is never cleared from hwc->state:

arch/alpha/kernel/perf_event.c:maybe_change_configuration() {
    ...
    if (cpuc->current_idx[j] =3D=3D PMC_NO_INDEX) {
        alpha_perf_event_set_period(pe, hwc, idx);
        cpuc->current_idx[j] =3D idx;
    }

    if (!(hwc->state & PERF_HES_STOPPED))
        cpuc->idx_mask |=3D alpha_event_idx_mask(hwc,
                        cpuc->current_idx[j]);
}

If alpha_pmu_stop(event, PERF_EF_UPDATE) is then called (for example, from
perf_adjust_freq_unthr_events() on the scheduler tick):

arch/alpha/kernel/perf_event.c:alpha_pmu_stop() {
    ...
    if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE)) {
        alpha_perf_event_update(event, hwc, hwc->idx, 0);
        hwc->state |=3D PERF_HES_UPTODATE;
    }
}

Because PERF_HES_UPTODATE is already set in hwc->state,
alpha_perf_event_update() is skipped, but the ProfileMe block right below it
sees hwc->state & PERF_HES_UPTODATE as true and rewrites hwc->prev_count and
PCTR0 with the un-updated hwc->period_left, discarding the counts accumulat=
ed
in PCTR0 since the event was added or last updated.

Should maybe_change_configuration() clear PERF_HES_UPTODATE when starting an
event (or should alpha_pmu_add() use alpha_pmu_start() like other PMU
drivers)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-alpha-prof=
ileme-v2-0-c702f1c65272@gmail.com?part=3D3
