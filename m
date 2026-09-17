Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF089560AB1
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653731; cv=none; b=bMilF0nXBN78yeJnSix3g8edTfZB72w9qE2TDSJkGe/XSuOsKzsabuCt8SdMz2HKopD09zSHEqiOkb+IXLocQwdv1Uaqv0XamG+3dPXZiOTpznMSRrtiGTbKDpiq0bfl0sc1bp0f7ZkLuBgb6SFCoyfjw4QByW2LDMoXATTCb74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653731; c=relaxed/simple;
	bh=NxhWI5Vjvsj4WVlQzOKOT796wBvVxzCyaAPNjUdckdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TA6QTiWv/wJXLTdQMUzFOTjsx8Ur54vMPgYsW0Kdy2+79yG2CP40vV7kco8DFtqtmKeRJnwvyU1Ch6N58wsT1CfRDMefcWTwpPWJhOxXGO75DKbb6u3vAkyKoB1i4zqaVKE6t7I3mKXvU7XJ/L7o3Ud3bUQIzZ4mI8SbaptWpgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYHntzLb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYHntzLb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B3C1F000FF;
	Thu, 17 Sep 2026 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653729;
	bh=MJiyfA3QeGWGraJJ91VdzV3/HeFguZWZsOnBdBdf248=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mYHntzLbfS3lIuhY06lMqvCMlwZFZojsz03guz6sfwZWPKw1LsiqkWfojrMA+/QS2
	 +8XommgMTfrjB0LjmCjHt1FXPt9qvEsn2opR2kwWMQXdXfEGpaftXPLAQKZkaXjg/k
	 nagGdZ2ukv7dxM19pFyIYN6us+WsV/47adGcne22Ad/75RYLC+l5isMHcjiFNxKKB0
	 UTo/jV9vwlUhG5DzJ1oftUQjnXqDEap/mmXK8WoQRxK5bdhuyjO0u8Ht6PcavaBiid
	 oZVnpaumaI888vQR1+95Fq37Z4MiBC/IarorLtuKIZQzgiQDmB83joL6IwjKlFaJfz
	 b9pRJW7vvUIDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] perf: Add Arm Bus Monitor Unit driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com>
References: <c936505c43275f434bce924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 14:02:09 +0000
Message-Id: <20260917140209.A4B3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] arm-bmu: out-of-bounds MMIO access when calculating PMU base addre=
sses
- [High] arm-bmu: race condition in CPU hotplug instance registration cause=
s UAF/NULL deref
- [High] acpi: NULL pointer dereference when accessing ACPI_COMPANION(dev)
- [Medium] arm-bmu: hardware interrupts remain enabled on probe error paths=
 and when missing IRQ
- [Medium] arm-bmu: hardware counter events are lost during overflow handli=
ng
- [Low] acpi: implicit declaration of acpi_device_uid() causes build failur=
e when !CONFIG_ACPI
--

commit 7371a9609aa611a01ae74feaaad4d9c2b61e0cd7
Author: Robin Murphy <robin.murphy@arm.com>

perf: Add Arm Bus Monitor Unit driver
   =20
Arm's Bus Monitor Unit is a low-level performance analysis tool for matching
and counting transactions at interconnect interfaces. This commit adds a
driver for the BMU PMU architecture under arm_cspmu/.

> diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/ar=
m-bmu.c
> index 0000000000000..fe25954ac8361
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm-bmu.c
[ ... ]
> +static void arm_bmu_pmu_irq(struct arm_bmu *bmu, int imu)
> +{
> +	struct arm_bmu_pmu *pmu =3D bmu->imus + imu;
> +	u32 reg =3D readl_relaxed(pmu->base + PMOVSCLR);
> +	u64 __iomem *pmevcnt =3D pmu->base + PMEVCNTR_LO;
> +
> +	for (int i =3D 0; i < PMU_MAX_COUNTERS; i++) {
> +		if (!(reg & (1U << i)))
> +			continue;
> +		if (!pmu->evcnt[i]) {
> +			dev_dbg(bmu->dev, "Spurious oveflow on IMU %d counter %d?\n", imu, i);
> +			continue;
> +		}
> +		arm_bmu_event_read(pmu->evcnt[i]);
> +		local64_set(&pmu->evcnt[i]->hw.prev_count, S64_MIN);
> +		lo_hi_writeq_relaxed(S64_MIN, pmevcnt + i);

[Severity: Medium]
Will hardware events occurring between arm_bmu_event_read() and this
lo_hi_writeq_relaxed() be lost since the actively running counter is
overwritten without being paused?

[ ... ]
> +static int arm_bmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	const struct resource *res;
> +	struct arm_bmu *bmu;
> +	const char *name =3D NULL;
> +	void __iomem *base;
> +	static atomic_t n;
> +	int err, num, sz, off;
> +	u64 cfg;
> +	u32 reg;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	/* PMUs and MPAM monitors are intermingled so we can't claim the whole =
resource */
> +	base =3D devm_ioremap(dev, res->start, resource_size(res));
> +	if (!base)
> +		return -ENOMEM;
[ ... ]
> +	cfg =3D lo_hi_readq_relaxed(base + MCU_CONFIG);
> +	num =3D 1 + FIELD_GET(MCUCFG_NUM_IMU_MONITORS, cfg);
[ ... ]
> +	/* The PMU pages *are* exclusively ours */
> +	off =3D SZ_4K * FIELD_GET(MCUCFG_PMU_ELEMENT_START, cfg);
> +	if (!devm_request_mem_region(dev, res->start + off, num * SZ_4K, dev_na=
me(dev)))
> +		return dev_err_probe(dev, -EADDRINUSE, "Unable to request PMU region\n=
");
[ ... ]
> +	base +=3D off;
> +	for (int i =3D 0; i < bmu->num_imus; i++, base +=3D SZ_4K) {
> +		/* At least PMCFGR.SIZE should always be nonzero if visible */
> +		reg =3D readl_relaxed(base + PMCFGR);

[Severity: High]
Could this result in an out-of-bounds MMIO read/write if the hardware repor=
ts
off and num values such that off + num * SZ_4K exceeds the mapped
resource_size(res)? It doesn't appear the calculated offset and size are
validated against the ioremap region size before being dereferenced.

[ ... ]
> +		writel_relaxed(U32_MAX, base + PMCNTENCLR);
> +		writel_relaxed(U32_MAX, base + PMOVSCLR);
> +		writel_relaxed(U32_MAX, base + PMINTENSET);
> +	}
> +
> +	bmu->cpu =3D cpumask_local_spread(atomic_fetch_inc(&n), dev_to_node(dev=
));
> +	bmu->irq =3D platform_get_irq(pdev, 0);
> +	if (bmu->irq > 0) {
> +		err =3D devm_request_irq(dev, bmu->irq, arm_bmu_handle_irq,
> +				       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				       dev_name(dev), bmu);
> +		if (err)
> +			bmu->irq =3D err;
> +		else
> +			irq_set_affinity(bmu->irq, cpumask_of(bmu->cpu));
> +	}
> +	if (bmu->irq < 0)
> +		dev_info(dev, "Continuing without IRQ\n");

[Severity: Medium]
Do hardware interrupts remain enabled if the driver proceeds here without an
IRQ handler? It looks like PMINTENSET was written earlier in the loop, but
the flags aren't cleared via PMINTENCLR when an IRQ isn't provided.

[ ... ]
> +	bmu->pmu =3D (struct pmu) {
> +		.module =3D THIS_MODULE,
> +		.parent =3D dev,
[ ... ]
> +	};
> +
> +	name =3D acpi_device_uid(ACPI_COMPANION(dev));

[Severity: High]
Can this cause a NULL pointer dereference if the driver binds to a device
without an ACPI companion? The pointer from ACPI_COMPANION(dev) appears to
be fed directly into acpi_device_uid() without being checked first.

[Severity: Low]
Additionally, since Kconfig allows building with CONFIG_COMPILE_TEST=3Dy and
CONFIG_ACPI=3Dn:

drivers/perf/arm_cspmu/Kconfig:ARM_BMU
        depends on (ARM64 && ACPI) || COMPILE_TEST

Does this unconditional call to acpi_device_uid() cause a build failure due
to an implicit declaration when !CONFIG_ACPI?

> +
> +	if (name)
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
> +	else
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%llx", (u64)(res->st=
art >> 12));
> +	if (!name)
> +		return -ENOMEM;
> +
> +	err =3D cpuhp_state_add_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpu=
hp_node);
> +	if (err)
> +		return err;

[Severity: Medium]
If this returns err, are hardware interrupts left enabled because PMINTENCLR
is not called on the error path?

> +
> +	err =3D perf_pmu_register(&bmu->pmu, name, -1);
> +	if (err)
> +		cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_n=
ode);
> +
> +	return err;
> +}

[Severity: High]
Can adding the hotplug instance before perf_pmu_register() completes cause a
race condition where a concurrent hotplug event triggers arm_bmu_offline_cp=
u()
and dereferences an uninitialized context?

> +
> +static void arm_bmu_remove(struct platform_device *pdev)
> +{
> +	struct arm_bmu *bmu =3D platform_get_drvdata(pdev);
> +
> +	for (int i =3D 0; i < bmu->num_imus; i++)
> +		writel_relaxed(U32_MAX, bmu->imus[i].base + PMINTENCLR);
> +
> +	perf_pmu_unregister(&bmu->pmu);
> +	cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_no=
de);

[Severity: High]
Does removing the instance after perf_pmu_unregister() leave a window open =
for
a use-after-free during teardown?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/c936505c43275f434bc=
e924b7657e42bfb25579c.1789652832.git.robin.murphy@arm.com?part=3D1
