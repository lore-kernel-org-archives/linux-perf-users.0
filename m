Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4E72617
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493134; cv=none; b=foEME1ESuJVeaj2/YV0KJGF5V/m8FNjgtIOR7C+j2iG+qoORYrT1Xs+pZgNSD4l0ieRkMGWGfsNMizaMRbnOWjsNLswLyAnlDXKIGiDZnBxYSi58pzE5NPw1WZa/5dpkZ27NL2CgodDPOEYSqbJr61Yy9/c1t+iJNuu3wSTnpRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493134; c=relaxed/simple;
	bh=UkMC3k+SgOH2h/C5QvKcFg2lGyMdq5DQSbJcVMr8cRA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aZDFVmG8db1gPz5dUHuMDjy9OXb5ca5BcoA37dcIT8UqL7J1V6jeIA91XYy4FF0M0rKLgJSUQaQWHu8wsbsQWpFWAg5M7M4j96FQhC2qYQgTxTb3qPiEsqAWvc382C3gv7oWanTlKExovbZHi/Y4yQcFtn0ukx1WKRA5cneETDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvuvWkEG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvuvWkEG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230D01F000E9;
	Wed, 12 Aug 2026 00:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493133;
	bh=jqzLsnrcBfjBknORbkjSHyHBS327O/VyS416V/NrLe4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AvuvWkEGKvyIB00J7rSh81rb/tMYXO/7aOeM8lphhOnLRpo9Ug25c9lklngoAnIpE
	 iFb2X9EY5p1ko7xbnhtSOufbu4Yi80yZDMvCPOipiKxyrRJYAlYNQQjueza6mG8730
	 voi7sLQ4/p6qvbt4Is6QtKumCco4nXy+mzpYa0HefJ9uf1cLB0JYQggjSlSF6WSIgZ
	 H2Y1ll16MwIHJXaNlibRDf3TEJyzoPOXPBlCA4lWwyliAagoXOf5kS/S7L2k15rN0l
	 DVq6+CBU68MpBmdsezn3rYCc4WVqFfIfJJbQ75QnkHwQlG8oYiuGkKqcEEHPpBrwam
	 VIeVU4x1GrpqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260811235112.2267241-3-irogers@google.com>
References: <20260811083828.2057695-1-irogers@google.com>
 <20260811235112.2267241-1-irogers@google.com>
 <20260811235112.2267241-3-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:05:32 +0000
Message-Id: <20260812000533.230D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Incorrect subsystem teardown ordering in both the exit and init er=
ror paths fails to cancel background tasks, leading to Use-After-Free.
- [Medium] Incomplete hiding of legacy BCM2835-specific sysfs event aliases=
 on BCM2712.
- [Medium] Dropping the spinlock in the VPU work handler causes a TOCTOU ra=
ce that corrupts hardware configurations.
- [Low] Invalid Kconfig dependency on non-existent symbol `ARCH_BCM2712`.
--

--- Patch [2]: [PATCH v2 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU su=
pport ---
commit c6c37f9c3fb56c6bdbc0982c7918061dbe1d45cb
Author: Ian Rogers <irogers@google.com>

perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support

Expand the Raspberry Pi AXI PMU driver to support Broadcom BCM2712
(Raspberry Pi 5) system monitors, PCIe RP1 Southbridge links, HEVC decoder,
and Cortex-A76 DSU L3 interconnects.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 97c8bf34f4633..b0c4eb0748dd3 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -327,11 +327,11 @@ config NVIDIA_TEGRA410_C2C_PMU
> =20
>  config RASPBERRYPI_AXI_PMU
>  	tristate "Raspberry Pi AXI PMU support"
> -	depends on ARCH_BCM2835 || ARCH_BRCMSTB || COMPILE_TEST
> +	depends on ARCH_BCM2835 || ARCH_BCM2712 || ARCH_BRCMSTB || COMPILE_TEST

[Severity: Low]
Does this code add a dependency on an undefined symbol?

ARCH_BCM2712 does not appear to be defined anywhere in the kernel tree.

>  	select RASPBERRYPI_FIRMWARE if ARCH_BCM2835
>  	help
>  	  Support for the AXI Performance Monitoring Unit (PMU) found on Broadc=
om
> -	  SoCs used in Raspberry Pi platforms (BCM2835, BCM2836, BCM2837, BCM27=
11).
> +	  SoCs used in Raspberry Pi platforms (BCM2835, BCM2836, BCM2837, BCM27=
11, BCM2712).
> =20
>  	  If compiled as a module, it will be called rpi_axi_pmu.
> =20
> diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
> index cdf7d9a74f13e..b13632fa8f84c 100644
> --- a/drivers/perf/rpi_axi_pmu.c
> +++ b/drivers/perf/rpi_axi_pmu.c
[ ... ]
> @@ -867,12 +1043,94 @@ static struct attribute *rpi_axi_pmu_events_attrs[=
] =3D {
[ ... ]
> +static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
> +					      struct attribute *attr, int unused)
> +{
> +	struct device *dev =3D kobj_to_dev(kobj);
> +	struct rpi_axi_pmu *pmu =3D dev_get_drvdata(dev);
> +	struct perf_pmu_events_attr *pmu_attr;
> +
> +	pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr.attr);
> +
> +	if (pmu->chip =3D=3D CHIP_BCM2712) {
> +		/*
> +		 * On RPi 5 (BCM2712), hide legacy VPU Mailbox IPC events (monitor=3D1)
> +		 * and RPi 1-4 aliases
> +		 */
> +		if (strstr(pmu_attr->event_str, "monitor=3D1") ||
> +		    strstr(attr->name, "cpu0_") ||
> +		    strstr(attr->name, "cpu1_") ||
> +		    strstr(attr->name, "dma0_") ||
> +		    strstr(attr->name, "dma1_") ||
> +		    strstr(attr->name, "v3d0_") ||
> +		    strstr(attr->name, "v3d1_") ||
> +		    strstr(attr->name, "hvs_system") ||
> +		    strstr(attr->name, "isp_system") ||
> +		    strstr(attr->name, "usb_system"))
> +			return 0;

[Severity: Medium]
Are there missing legacy aliases that should be hidden here?

This hides VPU IPC events on RPi 5, but it looks like several legacy System
Monitor aliases for diverged buses (such as ccp2tx, mphi_rx, h264, v3d,=20
peripheral, cpu_uc, cpu_l2) are not included in this check.

Opening them might measure the wrong hardware unit or fail with -EINVAL sin=
ce=20
their hardcoded bus indices exceed BCM2712_SB__MAX.

> +	} else {
> +		/* On RPi 1-4 (BCM2835-BCM2711), hide RPi 5 specific events */
> +		if (strstr(attr->name, "pcie_rp1") ||
> +		    strstr(attr->name, "a76_") ||
> +		    strstr(attr->name, "v3d7_") ||
> +		    strstr(attr->name, "hevc_dec") ||
> +		    strstr(attr->name, "arm_") ||
> +		    strstr(attr->name, "pcie0_") ||
> +		    strstr(attr->name, "hvs_filtered") ||
> +		    strstr(attr->name, "emmc0_"))
> +			return 0;
> +	}
> +
> +	return attr->mode;
> +}
[ ... ]
> @@ -1549,7 +1807,7 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pm=
u, struct platform_device *pd
>  	spin_lock_init(&pmu->lock);
>  	mutex_init(&pmu->vpu_mutex);
> =20
> -	pmu->chip =3D CHIP_BCM2835;
> +	pmu->chip =3D (enum rpi_axi_chip)(uintptr_t)of_device_get_match_data(de=
v);
> =20
>  	pmu->pmu =3D (struct pmu) {
>  		.module =3D THIS_MODULE,

[Severity: High]
Can the error paths in rpi_axi_pmu__init() and the teardown in=20
rpi_axi_pmu__exit() lead to a use-after-free?

If cpuhp_state_add_instance() fails in rpi_axi_pmu__init(), the driver call=
s=20
perf_pmu_unregister() but doesn't cancel the background tasks:

rpi_axi_pmu__init() {
    ...
err_pmu_unregister:
	perf_pmu_unregister(&pmu->pmu);
err_firmware_put:
	if (pmu->firmware)
		rpi_firmware_put(pmu->firmware);
	return ret;
}

Since PMU memory is freed via devres upon returning the error, an active ti=
mer
or workqueue (started by an event opened during the registration window) co=
uld=20
fire and access freed memory.=20

Similarly, in rpi_axi_pmu__exit(), the background tasks are cancelled befor=
e=20
unregistering the PMU subsystem:

rpi_axi_pmu__exit() {
	cpuhp_state_remove_instance(rpi_axi_pmu_cpuhp_state, &pmu->cpuhp_node);
	hrtimer_cancel(&pmu->hrtimer);
	cancel_work_sync(&pmu->vpu_work);
    ...
	perf_pmu_unregister(&pmu->pmu);
}

A concurrent userspace action could start a new event in this window,
restarting the timer and causing a use-after-free when the memory is
subsequently freed.

[Severity: Medium]
Is there a time-of-check to time-of-use race condition in=20
rpi_axi_pmu_vpu_work_handler()?

When the lock is dropped, a concurrent event deletion and addition could=20
potentially misconfigure the PMU watcher:

rpi_axi_pmu_vpu_work_handler() {
    ...
		if (!pmu->monitor[MON__VPU].hw_events.enabled[idx]) {
			int bus =3D pmu->monitor[MON__VPU].hw_events.monitored_bus[idx];
			int filter =3D pmu->monitor[MON__VPU].hw_events.filter[idx];

			spin_unlock_irq(&pmu->lock);
			rpi_axi_pmu_enable_bus_watcher(pmu, MON__VPU, idx, bus, filter);
			spin_lock_irq(&pmu->lock);
		}
    ...
}

Concurrently, rpi_axi_pmu_del() can delete the event and free the idx slot,=
=20
which rpi_axi_pmu_add() can then reuse for a new event with different=20
configurations.=20

Because the old values were cached before dropping the lock, they might be=
=20
forcefully written to the hardware, and enabled[idx] is modified outside th=
e=20
lock:

rpi_axi_pmu_enable_bus_watcher() {
    ...
	pmu->monitor[mon].hw_events.enabled[idx] =3D true;
    ...
}

Could this silently misconfigure the PMU watcher for the new event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811235112.2267=
241-1-irogers@google.com?part=3D2
