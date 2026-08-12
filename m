Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716D420488
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576509; cv=none; b=AUk3Ls2tTg0bWhA+kX5ah4GsFqJ3V+KzyzOww6vVHYSZEkMEeWdYiEvh7nYpWXGdEpwA7hvQKLn+OeyhZwmM+CrLVB4/EHljbzzW4+99BGuHsHqTQS6VlHWV20sMKjNlt+j4eJyPG9tnQId62c84NLzVAOB7yxxajP+/uk8PKpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576509; c=relaxed/simple;
	bh=97jdPaY8AAHefaYs1uvMcX7niZF3/GfLecroR7LwMwM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PqqI2cswHwwqJ3IMk6DxWTL+6DtToE6LmOQkP0BnHy7XkHs//jEUp6tHmO15UboENxiHFzdm372m0EM7uQjOeafNh+P0q9H9ku1sGcLfjhPPcxYSA5BW4sQR13yO5Poe2Hr5C8pSGiItHPpSurb8Ab0ft+GRjRrE+jSA8HkUwxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b755vf8o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b755vf8o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0821F00A3A;
	Wed, 12 Aug 2026 23:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786576507;
	bh=5KJC0ntaveiaKSATJEm4rbqF5Rr4QS+/QwKq06f6Vco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b755vf8omAKM4Y1KFUVpIBPoR4fw7owc8hTBrMs/AZmqv7SMKx5rZimQZ4b+E0e7V
	 0eQ48WQgb1+F7xh4DXVsFXwiD9pX8Jhe5Dax+wqRsaEa1gd87lTs4iZ4qIPycrg07g
	 x4kaefmpKC+WxshMQlRR/bapP3CRXomQ5y7GY1pX1xVRD0uid29308UyXh6iEAr2oi
	 EaknOD+8Mc8O6EeSX6jodF3Zmkgpidu1QJTExOy7cryWUwLC8UytMC6vbk/8WgCZNe
	 y2ZhV7cLi0GE/SxIRsvMz88+xVWHuZW5EX64/4wY13oqO8bJ0wgYPMauLX00ZfZUxU
	 9lztoufzRqleA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260812230145.2644281-2-irogers@google.com>
References: <20260812052417.2361040-1-irogers@google.com>
 <20260812230145.2644281-1-irogers@google.com>
 <20260812230145.2644281-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 23:15:06 +0000
Message-Id: <20260812231507.1A0821F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Use-After-Free during CPU context migration because cpuhp instance=
 is removed after PMU unregistration.
- [Medium] Hardware VPU bus watchers are never disabled due to dead code in=
 the deferred teardown logic.
- [Low] Compilation error due to undeclared 'monitor_running' field in 'str=
uct rpi_axi_hw_events'.
--

--- Patch [1]: [PATCH v5 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit 5c4597457ab7a1a4ae244f1e321c00bd28692a8a
Author: Ian Rogers <irogers@google.com>
Date:   Wed Aug 12 23:01:44 2026 +0000

    perf: Add Raspberry Pi BCM2835 AXI PMU driver

    This commit adds an uncore performance monitoring unit (PMU) driver
    for Broadcom BCM2835-BCM2711 AXI system monitors and VideoCore VPU firm=
ware
    mailbox monitors found on Raspberry Pi 1 through 4.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..e5cc86fc78b25
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +struct rpi_axi_hw_events {
> +	int monitored_bus[NUM_BUS_WATCHERS_PER_MONITOR];
> +	int filter[NUM_BUS_WATCHERS_PER_MONITOR];
> +	int refcount[NUM_BUS_WATCHERS_PER_MONITOR];
> +	int num_monitored;
> +	int num_started;
> +	bool enabled[NUM_BUS_WATCHERS_PER_MONITOR];
> +};

[Severity: Low]
Does this code fail to compile? It looks like the monitor_running field is
accessed in rpi_axi_hw_events__init() and rpi_axi_pmu_enable_bus_watcher(),
but it is missing from the definition of struct rpi_axi_hw_events here.

> +
> +static void rpi_axi_hw_events__init(struct rpi_axi_hw_events *hw_events)
> +{
> +	hw_events->num_monitored =3D 0;
> +	hw_events->num_started =3D 0;
> +	hw_events->monitor_running =3D false;

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

[Severity: Medium]
Will this leave hardware VPU bus watchers running indefinitely?

When a VPU perf event is deleted, rpi_axi_pmu_del() synchronously sets
enabled[idx] =3D false. The background rpi_axi_pmu_vpu_work_handler() relie=
s on
checking both refcount[idx] =3D=3D 0 and enabled[idx] to perform the actual=
=20
hardware teardown over the mailbox.

Because enabled[idx] is cleared here first, that condition becomes impossib=
le
to satisfy in the work handler. Could this lead to the VPU monitor being le=
ft=20
running when no events are active, wasting power and bus bandwidth?

> +			pmu->monitor[mon].hw_events.num_monitored--;
> +			if (mon =3D=3D MON__SYSTEM && pmu->monitor[mon].hw_events.num_monitor=
ed =3D=3D 0) {
> +				set_monitor_control(pmu, mon, GEN_CTL_RESET_BIT);
> +				pmu->monitor[mon].hw_events.monitor_running =3D false;
> +			}
> +		}
> +	}
[ ... ]
> +static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_de=
vice *pdev)
> +{
[ ... ]
> +	ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_n=
ode);
> +	if (ret) {
> +		dev_err(dev, "Failed to add cpuhp instance %d\n", ret);
> +		goto err_teardown;
> +	}
> +
> +	ret =3D perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=3D*/-1);
> +	if (ret) {
> +		dev_err(dev, "PMU register failed %d\n", ret);
> +		goto err_cpuhp_remove;
> +	}
> +
> +	return 0;
> +
> +err_cpuhp_remove:
> +	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);

[Severity: High]
Does this error path trigger a use-after-free or panic during CPU context
migration?

If perf_pmu_register() fails, calling cpuhp_state_remove_instance() will
trigger the rpi_axi_pmu_offline_cpu() callback for online CPUs. That
callback executes perf_pmu_migrate_context(), which will attempt to migrate
a PMU that was never successfully registered and has a NULL context pointer.

> +err_teardown:
> +	hrtimer_cancel(&pmu->hrtimer);
> +	cancel_work_sync(&pmu->vpu_work);
> +err_firmware_put:
> +	if (pmu->firmware)
> +		rpi_firmware_put(pmu->firmware);
> +	return ret;
> +}
> +
> +/**
> + * rpi_axi_pmu__exit() - Internal PMU teardown called during remove
> + * @pmu: Pointer to PMU context
> + */
> +static void rpi_axi_pmu__exit(struct rpi_axi_pmu *pmu)
> +{
> +	perf_pmu_unregister(&pmu->pmu);
> +	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);

[Severity: High]
Can unregistering the PMU before removing the cpuhp instance cause a
use-after-free?

perf_pmu_unregister() frees the PMU's CPU context allocations. The subseque=
nt
call to cpuhp_state_remove_instance() triggers the rpi_axi_pmu_offline_cpu()
callback for online CPUs.

This callback will then call perf_pmu_migrate_context(), which dereferences
the now-freed cpu_pmu_context, leading to a UAF. Should
cpuhp_state_remove_instance() be called before perf_pmu_unregister() to
ensure the PMU context remains valid during migration?

> +	hrtimer_cancel(&pmu->hrtimer);
> +	cancel_work_sync(&pmu->vpu_work);
> +	if (pmu->firmware)
> +		rpi_firmware_put(pmu->firmware);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812230145.2644=
281-1-irogers@google.com?part=3D1
