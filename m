Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609982;
	b=1b73vBwTiN7PaRPBNvdBU8CgYnzPhxroBHNwJN1KIaDYe+6vS0NhjxVpHzR8FQWVCu/4
	 r4NwCCllTOF+QgY8TGh4loszsiIs+f7kPlEMq3PCOCdsL396Zz3qyMq1jDO7t2e7qe19q
	 Yf3/Cp5DoKvZiJ0FGYuRRp/NSFUOLZnogYdpjXKAFDsvkZFzoqFaG8hcn93uhX9/EHKkm
	 jDhpovP3x/IGyiXQjC/yUnYbR7aAetINGC2FMN/PDdlOUqT5tfCzVl5armjHJABQi1aGc
	 jdCF3fGYmIC0ED8HOTDuFtpkjnHuobhn5PjOoP0R53u21xlLMvy04f/2JtLUsIfQEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609982;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+EidTOa8qxsbm0+1zJkA3r1uSNhUgkOtgBf+M+uJ/w=;
	b=B1ZFt49NxOtMfC+3M7Vb1zwzhH2HlUPmchNW319IcIv1dZcB4nfxpIsVBsDnrb4z9nLi
	 AudOd5guMiID3Jzce444HjIGsxbiHHGtfP+f5EOnAm84rhXKkbP09SRJJOW2Rd1Y8Qapn
	 Qr11vgJiUwByI6ShNrLGEQ3a4IsnkbXIFSijB5N4jmt4tKn+A4fKdNS+n4JARcn4dUEEI
	 L96coTUxANCp5TKvhasKqDlKzBaFPrZ3CuwGaduNQ+2zdbWBmXzVSjnsUu01lizo1GPGt
	 du5z+t90JaayaIxcAFjPEBlARlreFYljw9yz7l+asoy7DWJNBMnTZbj5iBDZ5y2zL3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Auj4Mnn5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00F606A32F
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 08:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Auj4Mnn5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559A61F00A17;
	Mon,  2 Nov 2026 08:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793609981;
	bh=5+EidTOa8qxsbm0+1zJkA3r1uSNhUgkOtgBf+M+uJ/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Auj4Mnn554yJMuJQksffeKgECcfMRxS4tUKeJLpmlKLdDALE69rebtFoYx1HduIKk
	 ZK+2W3S0aRIftJb7Otsu71la2Eb1z4bbyOS8cfiNegul6c82ksi0RpZkQopUgeglMx
	 xXzflM9Pr3hotFea5s7fiDSGNAnoR2WBZEIFc24dP5jtq5Rj3ewwIx+PlqCpo/7F67
	 Qb47erHIzGgU+PL7KUc8RUFEfHD3x8fuKbbRjbO9jV1P1du2V1WDG7tnKFkeTia/57
	 JVSyX1uu4Ha0H4/cxLYSF7L2uNVfSmFItTvGd3XAx/OQEDD6c48OKqYL0ztm70cyRl
	 deryD407eg/ww==
Message-ID: <sashiko-outbox-193146@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] perf/x86/intel/pt: Stop tracing across system
 suspend
Reply-To: sashiko-reviews@lists.linux.dev
To: "Adrian Hunter" <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261102074039.26983-7-adrian.hunter@intel.com>
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-7-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:59:39 +0000
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
- [High] perf/x86/intel/pt: pt_syscore_resume() restarts throttled Intel PT=
 events
--

commit ec625eb052a829ee0305912ebebc209a35b2be35
Author: Adrian Hunter <adrian.hunter@intel.com>

perf/x86/intel/pt: Stop tracing across system suspend

This commit adds syscore suspend and resume callbacks to stop the active
Intel PT event on the online CPU before system suspend and restart it
on resume after PT MSRs have been reset. For snapshot mode, it saves the
output offsets before suspend so the output MSRs can be reprogrammed on
resume without reading reset MSR values.

> diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
> index 272808f2b483b..1d304ba6d9c6a 100644
> --- a/arch/x86/events/intel/pt.c
> +++ b/arch/x86/events/intel/pt.c

[ ... ]

> @@ -1659,6 +1665,11 @@ static void pt_event_start(struct perf_event *even=
t, int mode)
>  	 */
>  	if (!(hwc->state & PERF_HES_UPTODATE)) {
>  		hwc->state &=3D ~PERF_HES_STOPPED;
> +		/* After suspend, need to fully re-configure */
> +		if (READ_ONCE(pt_suspended_event)) {
> +			buf =3D perf_get_aux(&pt->handle);
> +			goto fully_configure;
> +		}
>  		pt_config_enable(event);
>  		return;
>  	}
> @@ -1675,7 +1686,11 @@ static void pt_event_start(struct perf_event *even=
t, int mode)
> =20
>  	hwc->state &=3D ~(PERF_HES_STOPPED | PERF_HES_UPTODATE);
> =20
> +fully_configure:
>  	pt_config_buffer(buf);
> +	/* Output MSRs are valid again, so pt_read_offset() may read them */
> +	if (unlikely(READ_ONCE(pt_suspended_event)))
> +		WRITE_ONCE(pt_suspended_event, NULL);
>  	pt_config(event);
> =20
>  	return;
> @@ -1866,6 +1881,49 @@ static int pt_event_init(struct perf_event *event)
>  	return 0;
>  }
> =20
> +/*
> + * The CPU that stays online during system suspend may lose its PT state=
, so
> + * stop its event beforehand and start it again afterwards. The other CP=
Us
> + * were taken offline, which stopped their events.
> + */
> +static int pt_syscore_suspend(void *data)
> +{
> +	struct pt *pt =3D this_cpu_ptr(&pt_ctx);
> +	struct perf_event *event =3D pt->handle.event;
> +	struct pt_buffer *buf;
> +
> +	if (!event)
> +		return 0;
> +
> +	pt_event_stop(event, 0);
> +
> +	/*
> +	 * Save the output offsets while the MSRs are still valid, for
> +	 * pt_event_snapshot_aux() and for reprogramming them on resume.
> +	 */
> +	buf =3D perf_get_aux(&pt->handle);
> +	if (buf && buf->snapshot)
> +		pt_read_offset(buf);
> +
> +	WRITE_ONCE(pt_suspended_event, event);
> +
> +	return 0;
> +}
> +
> +static void pt_syscore_resume(void *data)
> +{
> +	struct perf_event *event =3D pt_suspended_event;
> +
> +	if (!event)
> +		return;
> +
> +	/* Guard against perf core having scheduled the event out meanwhile */
> +	if (event->state =3D=3D PERF_EVENT_STATE_ACTIVE)
> +		pt_event_start(event, 0);
> +
> +	WRITE_ONCE(pt_suspended_event, NULL);
> +}

[Severity: High]
Can pt_syscore_resume() prematurely restart an Intel PT event that has been
throttled by perf_event_throttle(), leading to a duplicate pt_event_start()
call when the event is unthrottled on the next timer tick?

When an Intel PT event is grouped with a sampling event (for example,
perf record -C 0 --aux-sample -c100000 -e '{intel_pt//,cycles}') and the
sibling sampling event overflows max_samples_per_tick times in NMI context,
__perf_event_account_interrupt() -> perf_event_throttle_group() calls
perf_event_throttle():

kernel/events/core.c:perf_event_throttle() {
	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
		return;

	event->hw.interrupts =3D MAX_INTERRUPTS;
	event->pmu->stop(event, 0);
	if (event =3D=3D event->group_leader)
		perf_log_throttle(event, 0);
}

This stops the event via pt_event_stop(event, 0) and sets
event->hw.interrupts =3D MAX_INTERRUPTS while leaving event->state set to
PERF_EVENT_STATE_ACTIVE.

This can happen in two ways across suspend:

1. In snapshot mode before pt_syscore_suspend() runs: pt_event_stop(event, =
0)
sets PERF_HES_STOPPED without calling perf_aux_output_end(), so
pt->handle.event remains non-NULL and PERF_HES_UPTODATE remains clear.
pt_syscore_suspend() then sees pt->handle.event !=3D NULL and records
pt_suspended_event =3D event even though the event was already stopped by
throttling.

2. In either normal or snapshot mode between pt_syscore_suspend() and
pt_syscore_resume(): the sibling hardware PMU counter on the online CPU
remains active while local IRQs and timer ticks are disabled (for instance,
during hibernation image creation in swsusp_arch_suspend()), and can overfl=
ow
in NMI context and call perf_event_throttle_group().

In both cases, pt_syscore_resume() only checks whether event->state is
PERF_EVENT_STATE_ACTIVE, so it calls pt_event_start(event, 0) on the
throttled event, clearing PERF_HES_STOPPED and PERF_HES_UPTODATE and enabli=
ng
RTIT_CTL_TRACEEN while event->hw.interrupts is still MAX_INTERRUPTS.

Once interrupts are re-enabled after syscore_resume(), the next timer tick
runs perf_adjust_freq_unthr_context() -> perf_adjust_freq_unthr_events() ->
perf_event_unthrottle_group() -> perf_event_unthrottle():

kernel/events/core.c:perf_event_unthrottle() {
	if (event->state !=3D PERF_EVENT_STATE_ACTIVE)
		return;

	event->hw.interrupts =3D 0;
	if (start)
		event->pmu->start(event, 0);
    ...
}

Because pt_syscore_resume() already started the event and cleared
PERF_HES_UPTODATE, this second pt_event_start(event, 0) call enters the
!(hwc->state & PERF_HES_UPTODATE) branch on an already-running event (even
in non-snapshot mode) and calls pt_config_enable() -> pt_config_start()
concurrently with active tracing and PT PMIs. If intel_pt_interrupt() fires
in that window and stops the event because the AUX buffer is full (setting
pt->handle.event =3D NULL and PERF_HES_STOPPED), pt_config_start() can then
write MSR_IA32_RTIT_CTL with RTIT_CTL_TRACEEN set while no AUX transaction
is open.

Also, if pt_syscore_resume() skips calling pt_event_start() when the event =
is
throttled, wouldn't clearing pt_suspended_event in pt_syscore_resume() befo=
re
perf_event_unthrottle() later calls pt_event_start() cause a throttled
snapshot event to read reset PT MSRs in pt_read_offset() and take the
pt_config_enable() path without reprogramming the output MSRs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102074039.2698=
3-1-adrian.hunter@intel.com?part=3D6
