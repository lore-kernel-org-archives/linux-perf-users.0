Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D00731813A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Jul 2026 07:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784965550; cv=none; b=bOUxNvOt+uGd7cGATKRkwEx4Q+7+qvWouvp+NulQ/f0S7mfeR0Ln6FgYRZNeib1dD0k0x3NxwmFTRW8SRDsVJPIJ1XW1Rh5Le7135leDUVMxKXm0lY3mcvskw9F/7UbMQDNj5SfAL8YNH7GfUbq+4tuBEqPf6JEK4fRLZib0Bvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784965550; c=relaxed/simple;
	bh=OHwDQJNJuT/rfMkW+PQPEFOsZf6H42lTr4nB7I/dA/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bnmzRYWB4rqyq3ncA/eIVeF/sJ+q2EJbR8HkPWoY5VqH8hWXuohJ/hJ+ACfvvagO+nwjDMakeyvGX0CR3utLILc8iCVZiwzxeIibh4GfHbmx/ywmvTTXqLeJhu52xK0Q185xwxlNUsIGoBIh9EcT+AaurhycnzlOMQXByeWg7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LyV1Ofah; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LyV1Ofah"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8B21F000E9;
	Sat, 25 Jul 2026 07:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784965548;
	bh=eqKB2mGMNYYGsRQ/6ztuAVXuHbD8ZF4Bzt9z+fb7R4Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LyV1OfahVOzIlxdcyJ6aVjTi/H0P9DtK1/hzb5M/fWGqt+MElou1V/vHuw6wr4Vtk
	 TijK7LIlfObY/9gEq/DgDHOApwUixud4a2VVvyS5BafDxjJneCblJAeIfuHrZaK1vb
	 xvgjmm8yYpXO5vAbfrF+loe5PiWSWREhRX4/NNQUYGgv7PXpgrbNugWT9z8hFI+wvj
	 QPwnkhsHQvnCicIV0ZNbQYdFno3lC5a8MBcFmlWDtw5VA+N/Mn/FHlvG4pQpesBZHN
	 SuvUzWsY6HL3d2pOVo4Dgzq8sx0Cq7nr0zwjiXtvWraPojflGiJMLoxM9ZlVmQrGCC
	 H66XSUHAdNhfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 1/6] powerpc/perf: Add HTM PMU driver to expose
 Hardware Trace Macro data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Athira Rajeev" <atrajeev@linux.ibm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260725065942.78839-2-atrajeev@linux.ibm.com>
References: <20260725065942.78839-1-atrajeev@linux.ibm.com>
 <20260725065942.78839-2-atrajeev@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 07:45:47 +0000
Message-Id: <20260725074548.2B8B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Returning -ENODEV from pmu->add() does not act as a hard failure, =
causing a continuous retry loop that floods the hypervisor.
- [Medium] Ignored PERF_EF_RELOAD and PERF_EF_UPDATE flags break frequency-=
based unthrottling and fail to prevent context-switch interruption.
--

--- Patch [1]: [PATCH V3 1/6] powerpc/perf: Add HTM PMU driver to expose Ha=
rdware Trace Macro data ---
commit e3070ea34290d3e6db9f94435894d38b1866fb0b
Author: Athira Rajeev <atrajeev@linux.ibm.com>

powerpc/perf: Add HTM PMU driver to expose Hardware Trace Macro data

This commit adds a new "htm" Performance Monitoring Unit (PMU) driver to
expose Hardware Trace Macro (HTM) control via the perf interface. It
configures the trace using the H_HTM hypervisor call with a 28-bit packed
event configuration. The driver tracks tracing state to manage start, stop,
add, and del operations and attempts to handle hypervisor errors.

> diff --git a/arch/powerpc/perf/htm-perf.c b/arch/powerpc/perf/htm-perf.c
> new file mode 100644
> index 0000000000000..4e4c924ecfd05
> --- /dev/null
> +++ b/arch/powerpc/perf/htm-perf.c

[ ... ]

> @@ -201,15 +201,6 @@ static int htm_event_init(struct perf_event *event)
> =20
>  static void htm_event_start(struct perf_event *event, int flags)
>  {
> 	int rc, ret, retries =3D 0;
> 	struct htm_config cfg;
> 	struct htm_target_id *target =3D event->pmu_private;
>=20
> 	/*
> 	 * Ignore context-switch re-enables. The perf core passes
> 	 * PERF_EF_RELOAD on context-switch-in. HTM tracing is
> 	 * continuous at hardware level, no hcall needed.
> 	 */
> 	if (flags & PERF_EF_RELOAD)
> 		return;

[Severity: Medium]
Does ignoring PERF_EF_RELOAD here break unthrottling for frequency-based
events?

When an event opened in frequency mode is unthrottled, the core restarts it
by calling event->pmu->start(event, PERF_EF_RELOAD). Will ignoring this flag
leave the hardware trace permanently halted?

Also, does ignoring this flag actually prevent context switches from stoppi=
ng
the hardware? Context-switch-in calls pmu->add(event, PERF_EF_START), which
this driver translates to htm_event_start(event, 0), and context-switch-out
calls pmu->del(event, 0), translated to htm_event_stop(event, 0). Will the
hardware still be interrupted on every context switch despite these checks?

[ ... ]

> @@ -235,15 +235,6 @@ static void htm_event_start(struct perf_event *event=
, int flags)
>  static void htm_event_stop(struct perf_event *event, int flags)
>  {
> 	int rc, ret, retries =3D 0;
> 	struct htm_config cfg;
> 	struct htm_target_id *target =3D event->pmu_private;
>=20
> 	/*
> 	 * Ignore context-switch-out stops. The perf core passes
> 	 * PERF_EF_UPDATE on context-switch-out. Do not stop the hcall.
> 	 */
> 	if (flags & PERF_EF_UPDATE)
> 		return;

[Severity: Medium]
Does ignoring PERF_EF_UPDATE here prevent the core from correctly stopping
the event during dynamic frequency adjustments?

[ ... ]

> @@ -275,15 +275,6 @@ static void htm_event_stop(struct perf_event *event,=
 int flags)
>  static int htm_event_add(struct perf_event *event, int flags)
>  {
> 	int rc, ret, retries =3D 0;
> 	unsigned long param1 =3D -1, param2 =3D -1;
> 	struct htm_target_id *target =3D event->pmu_private;
> 	struct htm_config cfg =3D target->cfg;
>=20
> 	/*
> 	 * pmu->add() is invoked in an atomic context with interrupts disabled
> 	 * and hardware context locks held. sleeping is impossible.  Only retry
> 	 * on transient H_BUSY. On H_LONG_BUSY_* (-EAGAIN) and other errors, the
> 	 * loop exits and we return -ENODEV, which is a hard failure: the perf
> 	 * core will not reschedule the event. Returning -EAGAIN here would cause
> 	 * the perf core to re-queue the event and call pmu->add() again on every
> 	 * context switch, flooding the hypervisor with H_HTM_OP_CONFIGURE hcalls
> 	 * exactly when it has requested a long backoff delay.
> 	 */
> 	do {
> 		rc =3D htm_hcall_wrapper(htmflags, cfg.nodeindex, cfg.nodalchipindex,
> 				       cfg.coreindexonchip, cfg.htmtype,
> 				       H_HTM_OP_CONFIGURE, param1, param2, 0);
> 		ret =3D htm_return_check(rc);
> 	} while (ret =3D=3D -EBUSY && ++retries < MAX_RETRIES);
>=20
> 	if (ret <=3D 0)
> 		return -ENODEV;

[Severity: High]
Does returning -ENODEV here actually prevent the core from rescheduling the
event?

Looking at event_sched_in() in kernel/events/core.c, any non-zero return
code from pmu->add() is overridden to -EAGAIN and the event state is set to
inactive:

kernel/events/core.c:event_sched_in() {
    ...
    if (event->pmu->add(event, PERF_EF_START)) {
        perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
        event->oncpu =3D -1;
        ret =3D -EAGAIN;
        goto out;
    }
    ...
}

Will this cause the multiplexing logic to retry scheduling on the next timer
tick, creating an infinite loop that floods the hypervisor with configure
hcalls exactly when it requested a long backoff delay?

Should this instead return 0 and call perf_event_disable_inatomic() so the
core processes the disable request and marks it PERF_EVENT_STATE_OFF?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725065942.7883=
9-1-atrajeev@linux.ibm.com?part=3D1
