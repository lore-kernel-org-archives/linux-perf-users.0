Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B850A27707
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493079; cv=none; b=dJ7U7TK3S/vxDg1ivfL+MfKTE8yvviRJoFTRTxd7vVM+dRW6olmmmxbVrkXhFvKkeZN0ii4ckQTyikZdLumZrC/JGgkI9CaW2bbRpL/rjpLWVRwilhbVYzqJkvV+oz4SfaCDbgUYE2LQ1cNYvnjJsMxabbBKVmSkTap/YJ4kMP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493079; c=relaxed/simple;
	bh=nxwRa4VfIF4NYy6WYg3i4IzPKqA44rsYT/Ygyoy5zK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S428QzeEFz60x7xy9At+bUklSMnidZcDPHmzh/+33bSn88YfkdNE1R/DSIRPglZv9e6g/Y3NEPzMs2OZ9hfDBE3aoeZbeB/lsBZtTGt74AQPkVGZZq5EtlpjhL8h6SbVU9X6N8AD6vDpFZJ1ZBf+Lu50JcEyJu6PtsO4xlk4FLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgEhnwj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgEhnwj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369881F000E9;
	Wed, 12 Aug 2026 00:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493077;
	bh=ZI28Fk1QqvALcn8VNLO3hEdYoUgK1K6cl7m7A2KQWhM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgEhnwj0rne8gLgxuQ0RVDenTQVQE7mC0txEIlqqEZDi3PEOMMXx8sDfIQ73EZZ74
	 Ve2733e57LQ2FsrV5npK/sLfzihpPojCu79llUtjzsaWSTZ/b7HeSkntwK/H/uWwjM
	 NHS0yreJDguuu8jmshhiAbBl3TzI5WqrthtzuQYd+he/BJ1Y4L4QPWdl2TVsvfOi+a
	 M85D9BF/f66oZ3ZPErpin8Vpm+x9iv8yRcjwgAfthHjW0TZ5kdilmAPShnklMOmKQb
	 A9jv1G9zRH60vBHSaadewosHDwz6ft8uxP3OMd1nqZdvx7xB5PAo1qrVYanhwdriY1
	 WZdnPZR+usSFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260811235112.2267241-2-irogers@google.com>
References: <20260811083828.2057695-1-irogers@google.com>
 <20260811235112.2267241-1-irogers@google.com>
 <20260811235112.2267241-2-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:04:36 +0000
Message-Id: <20260812000437.369881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [High] The probe function ignores a missing 'firmware' device tree phandl=
e, leaving `pmu->firmware` NULL but leaving the VPU monitor enabled, causin=
g a later NULL pointer dereference in the mailbox IPC.
- [High] The driver fails to prevent sysfs unbinding (`.suppress_bind_attrs=
 =3D true`), leading to a Use-After-Free if unbound while perf events are a=
ctive.
- [High] Incorrect manual parsing of the 'reg' property assumes fixed addre=
ss and size cells, breaking on 64-bit platforms.
- [High] Incorrect PMU teardown ordering in `rpi_axi_pmu__exit` and missing=
 cleanup in probe error paths cause Use-After-Free vulnerabilities.
- [High] The PMU driver uses a `spinlock_t` in a hardirq hrtimer callback, =
causing lockdep splats and sleeping in atomic context on PREEMPT_RT.
- [Medium] An unprotected write to `hw_events.enabled[idx]` creates a race =
condition with event deletion, which can silently break hardware configurat=
ion for recycled bus watcher slots.
- [Medium] The CPU hotplug offline callback erroneously restarts the pollin=
g hrtimer pinned to the dying CPU, sabotaging PMU migration.
- [Low] Raspberry Pi 5 (BCM2712) support is partially implemented but compl=
etely unreachable because the chip type is hardcoded to BCM2835 and the dev=
ice tree match table lacks BCM2712.
--

--- Patch [1]: [PATCH v2 1/2] perf: Add Raspberry Pi BCM2835 AXI PMU driver=
 ---
commit 3567c05975da01f684191bbbfa826e0e8d8e9927
Author: Ian Rogers <irogers@google.com>
Subject: perf: Add Raspberry Pi BCM2835 AXI PMU driver

This commit introduces a new uncore PMU driver for Broadcom BCM2835-BCM2711=
=20
AXI system monitors. It supports tracking AXI traffic via MMIO for the syst=
em=20
monitor and via mailbox IPC for the VPU monitor.

> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> new file mode 100644
> index 0000000000000..cdf7d9a74f13e
> --- /dev/null
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> +static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_de=
vice *pdev)
> +{
[ ... ]
> +	pmu->chip =3D CHIP_BCM2835;

[Severity: Low]
Is BCM2712 hardware meant to be supported here?

The chip type is unconditionally hardcoded to CHIP_BCM2835, which appears to
make the BCM2712 definitions unreachable.

> +
> +	pmu->pmu =3D (struct pmu) {
[ ... ]
> +	if (pmu->chip =3D=3D CHIP_BCM2835) {
> +		pmu->monitor[MON__SYSTEM].use_mailbox_interface =3D false;
> +		pmu->monitor[MON__VPU].use_mailbox_interface =3D true;
> +		fw_node =3D of_parse_phandle(dev->of_node, "firmware", 0);
> +		if (fw_node) {
> +			pmu->firmware =3D rpi_firmware_get(fw_node);
> +			of_node_put(fw_node);
> +			if (!pmu->firmware)
> +				return -EPROBE_DEFER;
> +		}

[Severity: High]
Can this lead to a NULL pointer dereference in the mailbox IPC?

If the device tree lacks the firmware property, fw_node is NULL and
the driver continues with pmu->firmware left as NULL.

Later, set_monitor_control() will call rpi_firmware_property() using this
NULL pointer when VPU events are started.

> +	} else {
[ ... ]
> +	for (int i =3D 0; i < MON__MAX; i++) {
> +		rpi_axi_hw_events__init(&pmu->monitor[i].hw_events);
> +
> +		if (pmu->monitor[i].use_mailbox_interface) {
> +			ret =3D of_property_read_u32_index(dev->of_node, "reg", i * 2,
> +							 &pmu->monitor[i].mailbox);

[Severity: High]
Does this correctly parse the reg property on 64-bit platforms?

Using of_property_read_u32_index() with a fixed index of i * 2 assumes that
address and size cells are exactly 1.

On platforms with 64-bit device tree layouts, could this fetch the wrong
word and corrupt the mailbox address?

> +			if (ret) {
[ ... ]
> +	ret =3D cpuhp_state_add_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_n=
ode);
> +	if (ret) {
> +		dev_err(dev, "Failed to add cpuhp instance %d\n", ret);
> +		goto err_pmu_unregister;
> +	}
> +	return 0;
> +
> +err_pmu_unregister:
> +	perf_pmu_unregister(&pmu->pmu);
> +err_firmware_put:
> +	if (pmu->firmware)
> +		rpi_firmware_put(pmu->firmware);
> +	return ret;
> +}

[Severity: High]
Could this regression cause a use-after-free if probe fails here?

If cpuhp_state_add_instance() fails, the error path unregisters the PMU but
does not cancel the hrtimer or vpu_work.

Since the PMU is briefly visible in sysfs, might userspace race to open an
event and arm the timer before the context is freed by devres?

> +static void rpi_axi_pmu__exit(struct rpi_axi_pmu *pmu)
> +{
> +	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);
> +	hrtimer_cancel(&pmu->hrtimer);
> +	cancel_work_sync(&pmu->vpu_work);
> +	if (pmu->firmware)
> +		rpi_firmware_put(pmu->firmware);
> +	perf_pmu_unregister(&pmu->pmu);
> +}

[Severity: High]
Does this teardown ordering allow new events to race with driver removal?

By cancelling the timer and workqueue before unregistering the PMU, there
appears to be a window where new events can be scheduled that restart the
timers while the context is being torn down.

[ ... ]
> +static void rpi_axi_pmu_enable_bus_watcher(struct rpi_axi_pmu *pmu, enum=
 monitor mon,
> +					    int idx, int bus, int filter)
> +{
[ ... ]
> +	pmu->monitor[mon].hw_events.enabled[idx] =3D true;
> +}

[Severity: Medium]
Is this state update safe from concurrent deletion?

The array element is modified without holding pmu->lock.

When rpi_axi_pmu_vpu_work_handler() drops the lock to call this function:

rpi_axi_pmu_vpu_work_handler()
   spin_unlock_irq(&pmu->lock);
   rpi_axi_pmu_enable_bus_watcher(pmu, MON__VPU, idx, bus, filter);
   spin_lock_irq(&pmu->lock);

A concurrent rpi_axi_pmu_del() could clear the slot and set enabled to fals=
e.

If a new event immediately reuses this slot, wouldn't the unlocked write to
true overwrite the hardware configuration state for the new event?

[ ... ]
> +static enum hrtimer_restart rpi_axi_pmu_timer_handler(struct hrtimer *ti=
mer)
> +{
> +	struct rpi_axi_pmu *pmu =3D container_of(timer, struct rpi_axi_pmu, hrt=
imer);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pmu->lock, flags);

[Severity: High]
Will this lock acquisition panic on PREEMPT_RT kernels?

The timer defaults to hardirq context, where acquiring a sleepable lock like
spinlock_t triggers a panic on PREEMPT_RT.

[ ... ]
> +static int rpi_axi_pmu_offline_cpu(unsigned int cpu, struct hlist_node *=
node)
> +{
[ ... ]
> +	spin_lock_irqsave(&pmu->lock, spinflags);
> +	if (pmu->active_events > 0) {
> +		spin_unlock_irqrestore(&pmu->lock, spinflags);
> +		hrtimer_cancel(&pmu->hrtimer);
> +		spin_lock_irqsave(&pmu->lock, spinflags);
> +		if (pmu->active_events > 0)
> +			hrtimer_start(&pmu->hrtimer, RPI_AXI_PMU_TIMER_INTERVAL,
> +				      HRTIMER_MODE_REL_PINNED);
> +	}
> +	spin_unlock_irqrestore(&pmu->lock, spinflags);
> +
> +	return 0;
> +}

[Severity: Medium]
Does this logic unintentionally sabotage PMU migration during CPU offline?

This callback runs in the context of the dying CPU.

By passing HRTIMER_MODE_REL_PINNED here, the timer seems to be pinned to the
offlining CPU instead of being successfully migrated to the target CPU.

[ ... ]
> +static int rpi_axi_pmu_probe(struct platform_device *pdev)
> +{
> +	struct rpi_axi_pmu *pmu;
> +
> +	pmu =3D devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);

[ ... ]
> +static const struct of_device_id rpi_axi_pmu_match[] =3D {
> +	{
> +		.compatible =3D "brcm,bcm2835-axiperf",
> +		.data =3D (void *)CHIP_BCM2835,
> +	},
> +	{
> +		.compatible =3D "brcm,bcm2711-axiperf",
> +		.data =3D (void *)CHIP_BCM2835,
> +	},
> +	{ }
> +};

[Severity: Low]
Could this device tree match table be missing a compatible string for
BCM2712 hardware, preventing it from probing entirely?

> +MODULE_DEVICE_TABLE(of, rpi_axi_pmu_match);
> +
> +static struct platform_driver rpi_axi_pmu_driver  =3D {
> +	.probe =3D	rpi_axi_pmu_probe,
> +	.remove =3D	rpi_axi_pmu_remove,
> +	.driver =3D {
> +		.name   =3D PMU_NAME,
> +		.of_match_table =3D of_match_ptr(rpi_axi_pmu_match),
> +	},
> +};

[Severity: High]
Can an administrator unbinding this driver via sysfs trigger a use-after-fr=
ee?

The pmu context is allocated with devm_kzalloc(), tying its memory lifetime
to the device bind state.

Since .suppress_bind_attrs =3D true is omitted, a sysfs unbind will free the
memory while active perf events might still exist and try to access the
freed context.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811235112.2267=
241-1-irogers@google.com?part=3D1
