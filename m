Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B4305693
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577135; cv=none; b=XoVmW3uZLnLGJxGA+pDti3I8aJDspVZWB0aNFbhoGaPlho6xZO3668nroMrgu5uWN+V7Wr9M79KXEijfMV2bENB8Zm88t5IuW3yXBJZSeBWwRXEVHAFJQOtVAKPE+u2hWcd7s37G7qeFiVLAqXEXcFODe4tRSa2MNGNBV30EWlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577135; c=relaxed/simple;
	bh=NQ9XOFnsz8qhijakEIH1nuAJv7O+KIwDrPtvj6t4OUQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dmg+nQK/HN4GA/nJ0Dy3fIfrhQmcINaGbOkfxPixKnsrXuYiFs72Hy2Bqkwi1x6IkE7YlE4H1tGBifTLWMYrjVv75+bS8BGGmGwJGqqhrregBG/2UsJGDBviQEjdF+isMcgmHxKLD1c3St9PVyJ6IJsn32APnR0sFP+i5VRUB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvIoARkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvIoARkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A4F1F000E9;
	Wed, 12 Aug 2026 23:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786577134;
	bh=3zkRF63G3zm+yLdoChDCqzmjRNF1PPWya2+R0DpbevU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvIoARkNI1Oe6gmxk+wA/Tvy0Np7Ln9iy4GxYfoVaYD8xoI5DBlmn6dCzzEbL/4ur
	 MJlG03RxQa7qxJ7RcEmiZJB3OmykTGnDNsY4L/lasEl+BlAeVJ6wuPBmAJLbcw0TPY
	 PuoA6LxZEheI6OqNyG++ZDWq6e36syq0I7Qf0L7I+4Db6BgiuWd0AkqNudwBvvJqIE
	 OBi/oFYMmXXA4giosdCS/Mrb9q8V9J9PtOAWxGTY5xz8OVgCbIk5kH4lNWIUMS6lyc
	 NPmKt3BIuBvyDFpOQWDHaAQP3t5FupYUJsGDKn6AxnL8ZKlEpJmxTFH7yK6/aB2CQ5
	 ftvJA6zu2nGYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812230800.2646749-2-irogers@google.com>
References: <20260812230145.2644281-1-irogers@google.com>
 <20260812230800.2646749-1-irogers@google.com>
 <20260812230800.2646749-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:25:33 +0000
Message-Id: <20260812232533.C0A4F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] rpi_axi_pmu_del() calls hrtimer_cancel() while holding the per=
f core's ctx->lock (a raw spinlock) and with IRQs disabled, leading to dead=
locks.
- [High] VPU hardware bus watchers are never disabled when their associated=
 perf events are deleted, resulting in a permanent hardware resource leak.
- [Medium] Final VPU event counts are lost when an event is stopped, leadin=
g to silent under-reporting.
- [Low] RASPBERRYPI_AXI_PMU conditionally selects RASPBERRYPI_FIRMWARE with=
out ensuring its dependencies are met, causing Kconfig warnings.
--

--- Patch [1]: [PATCH v5 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit cadc1bb2e8b72c5287e86258dff1cee13436365d
Author: Ian Rogers <irogers@google.com>
Date:   Wed Aug 12 23:07:59 2026 +0000

    perf: Add Raspberry Pi BCM2835 AXI PMU driver
   =20
    This commit adds an uncore performance monitoring unit (PMU) driver
    for Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firm=
ware
    mailbox monitors found on Raspberry Pi 1 through 4.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b99..97c8bf34f4633 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -325,4 +325,14 @@ config NVIDIA_TEGRA410_C2C_PMU
>  	  Enable perf support for counters in NVIDIA C2C interface of NVIDIA
>  	  Tegra410 SoC.
> =20
> +config RASPBERRYPI_AXI_PMU
> +	tristate "Raspberry Pi AXI PMU support"
> +	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
> +	select RASPBERRYPI_FIRMWARE if ARCH_BCM2835

[Severity: Low]
Does this conditionally select RASPBERRYPI_FIRMWARE without ensuring its
dependencies are met? If a user configures ARCH_BCM2835=3Dy but MAILBOX=3Dn,
could this cause Kconfig unmet dependency warnings and silent build failure=
s?

[ ... ]

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..e5cc86fc78b25
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c

[ ... ]

> +static void rpi_axi_pmu_read(struct perf_event *event)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	enum counter counter =3D config_to_counter(event->attr.config);
> +	u64 prev_count, new_count;
> +	unsigned long flags;
> +	u32 delta;
> +
> +	/* Mailbox VPU counters are polled asynchronously in background vpu_wor=
k.
> +	 * MMIO monitors (System and BCM2712 VPU) are read synchronously.
> +	 */
> +	if (pmu->monitor[mon].use_mailbox_interface || event->hw.idx < 0)
> +		return;

[Severity: Medium]
When a VPU event is stopped, it looks like rpi_axi_pmu_read() bails out here
without capturing the final delta.

Additionally, in rpi_axi_pmu_vpu_work_handler():

        if (!event || (event->hw.state & PERF_HES_STOPPED) ||
            config_to_monitor(event->attr.config) !=3D MON__VPU)
                continue;

The background poller skips stopped events. If rpi_axi_pmu_stop() marks the
event as stopped, does this result in the final VPU counts being completely
discarded? Could short-lived processes consistently report zero events beca=
use
of this?

[ ... ]

> +static void rpi_axi_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct rpi_axi_pmu *pmu =3D pmu_to_rpi_axi_pmu(event->pmu);
> +	enum monitor mon =3D config_to_monitor(event->attr.config);
> +	unsigned long spinflags;
> +	int idx =3D event->hw.idx;
> +
> +	if (idx < 0)
> +		return;
> +
> +	rpi_axi_pmu_stop(event, PERF_EF_UPDATE);
> +
> +	spin_lock_irqsave(&pmu->lock, spinflags);
> +	for (int i =3D 0; i < RPI_AXI_MAX_EVENTS; i++) {
> +		if (pmu->events[i] =3D=3D event) {
> +			pmu->events[i] =3D NULL;
> +			pmu->event_gen[i]++;
> +			break;
> +		}
> +	}
> +
> +	if (pmu->monitor[mon].hw_events.monitored_bus[idx] >=3D 0) {
> +		pmu->monitor[mon].hw_events.refcount[idx]--;
> +		if (pmu->monitor[mon].hw_events.refcount[idx] =3D=3D 0) {
> +			if (mon =3D=3D MON__SYSTEM)
> +				rpi_axi_pmu_disable_bus_watcher(pmu, mon, idx);
> +			pmu->monitor[mon].hw_events.monitored_bus[idx] =3D -1;
> +			pmu->monitor[mon].hw_events.filter[idx] =3D BCM2835_FLT__NONE;
> +			pmu->monitor[mon].hw_events.enabled[idx] =3D false;

[Severity: High]
Does this cause a permanent hardware resource leak for VPU events? Since
rpi_axi_pmu_disable_bus_watcher() is only called for MON__SYSTEM, the VPU
bus watchers are never disabled. Furthermore, because enabled[idx] is set to
false, the hardware is left running indefinitely with no way for any backgr=
ound
polling logic to track or disable it later.

> +			pmu->monitor[mon].hw_events.num_monitored--;
> +			if (mon =3D=3D MON__SYSTEM && pmu->monitor[mon].hw_events.num_monitor=
ed =3D=3D 0) {
> +				set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> +				pmu->monitor[mon].hw_events.monitor_running =3D false;
> +			}
> +		}
> +	}
> +
> +	event->hw.idx =3D -1;
> +	pmu->active_events--;
> +	if (mon =3D=3D MON__VPU)
> +		pmu->active_vpu_events--;
> +
> +	if (pmu->active_events =3D=3D 0) {
> +		spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		if (in_hardirq())
> +			hrtimer_try_to_cancel(&pmu->hrtimer);
> +		else
> +			hrtimer_cancel(&pmu->hrtimer);

[Severity: Critical]
Can this lead to deadlocks or scheduling while atomic panics?=20

rpi_axi_pmu_del() is called with the perf core's ctx->lock held (a raw spin=
lock)=20
and local IRQs disabled. If in_hardirq() is false, this branch calls=20
hrtimer_cancel().=20

Because this is a SOFT hrtimer (HRTIMER_MODE_REL_SOFT), hrtimer_cancel()=20
can sleep on PREEMPT_RT, causing an immediate panic. Even without PREEMPT_R=
T,=20
if the user thread preempted ksoftirqd on the same CPU, spin-waiting for=20
the timer to finish while preemption is disabled causes a permanent=20
self-deadlock.

> +		spin_lock_irqsave(&pmu->lock, spinflags);
> +		if (pmu->active_events > 0)
> +			hrtimer_start(&pmu->hrtimer, RPI_AXI_PMU_TIMER_INTERVAL,
> +				      HRTIMER_MODE_REL_SOFT);
> +		spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		return;
> +	}
> +	spin_unlock_irqrestore(&pmu->lock, spinflags);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812230800.2646=
749-1-irogers@google.com?part=3D1
