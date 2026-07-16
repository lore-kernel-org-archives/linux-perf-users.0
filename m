Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D27D33AD88;
	Thu, 16 Jul 2026 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215477; cv=none; b=IL9JuZPT+OvZ2UCqREht6MfisK5dNiBuOs0ICPz+I0DWO9OlP43VhG7yWBil2SuRjudNGNKQvDyEVBYv6D/cAaUv34vH2yRSHc7R+QAF7nPE2r79PwNjjT1fnVogcaE3TWfnv5D/BiBfzAJiqry+FXcm+FX2yjM0nh2odm4WXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215477; c=relaxed/simple;
	bh=nBFmUWIHjdP2Tnyx3fFEh2gQw7gLomwe5mh1rfUoP4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R82KEQHPpFbq1PPCHKk7cTmxc+X+q01y/CyZgD1ZkvgmUqhs7z8UWBKeg3YPRdKyL2GAMzV8yUDFsg8xzyM7UY06x5Nf6J3+LZd6JlI7fdn1S79OMOzGMI68vIvnivX4l0eAN2p6DQnHSMraDv96r9ohsunFCZ7c7jOXmP/4AB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TOSbqa9M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TOSbqa9M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1499D1F000E9;
	Thu, 16 Jul 2026 15:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215476;
	bh=bN8gHacLd72I4vbGCmCrU9QFeSGwhJ/k9I6GaGCIYSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TOSbqa9M6whG0OHHd6fKWf1txlQK3MJbgyBc/3BDIhS2clG8MXLUj2Uu36DoY71F2
	 0D23cVqIEy8q9ss/yqjm8+Vop87u9Mwlpze0t5wHvwm6ZHkGM4WZRjvOKzjRVwrfgj
	 53ir2033IhQwfGPqUryixW4RD2A69I5BSHuUo0S0sO6GmvV6Ik3zfBGYlJPnfN1B6D
	 d6TF9gNaHVQRl9EMKrv2ebMQI1HjzkWT5tmnJBc3Am29cb1ZJQlXmhVqwVCAy00fQB
	 WXy65iIAaWFadiq418v+LoKlLQmAHRe60CK4upwJmskNAIVuEM3agZYrxg6nnUTJSk
	 YkGi7DJkt/3Dg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: perf: Add Arm Bus Monitor Unit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <1cc6acae06fb4910e27cc89e2270a52e80e310ef.1784214112.git.robin.murphy@arm.com>
References: <cover.1784214112.git.robin.murphy@arm.com>
 <1cc6acae06fb4910e27cc89e2270a52e80e310ef.1784214112.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:24:35 +0000
Message-Id: <20260716152436.1499D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The driver calculates an offset from hardware configuration regist=
ers and accesses memory within an ioremapped region without bounds checking=
, which can lead to out-of-bounds MMIO accesses.
- [High] The CPU hotplug instance is added before PMU registration complete=
s, exposing a race condition where a CPU hotplug event will cause a NULL po=
inter dereference.
- [Medium] A pending overflow interrupt will trigger a spurious `WARN_ON` w=
hen an event is deleted because the hardware interrupt flag is not cleared.
--

--- Patch [2]: [PATCH v2 2/3] dt-bindings: perf: Add Arm Bus Monitor Unit -=
--
commit 46bae7b04d539138ea677d6d9ef5697dcb457c20
Author: Robin Murphy <robin.murphy@arm.com>

perf: Add Arm Bus Monitor Unit driver

This commit introduces the Arm Bus Monitor Unit (BMU) driver, which provides
a low-level performance analysis tool for matching and counting transactions
at interconnect interfaces. It supports multiple Interface Monitoring Units
(IMUs) by exposing them as perf PMU instances.

> diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/ar=
m-bmu.c
> new file mode 100644
> index 0000000000000..c829a0728e9b2
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm-bmu.c

[ ... ]

> +static void arm_bmu_event_del(struct perf_event *event, int flags)
> +{
> +	struct arm_bmu_pmu *pmu =3D to_bmu_pmu(event);
> +
> +	arm_bmu_event_stop(event, PERF_EF_UPDATE);
> +	pmu->evcnt[event->hw.idx] =3D NULL;
> +}

[Severity: Medium]
Will an unhandled pending overflow interrupt trigger a spurious warning her=
e?

If a performance counter overflows right before or during arm_bmu_event_del=
(),
local interrupts are disabled by the perf core, leaving the interrupt pendi=
ng.
Since arm_bmu_event_del() stops the counter and sets the evcnt pointer to
NULL but doesn't clear the pending overflow interrupt from the PMOVSCLR
register, this pending interrupt will be processed when interrupts are
re-enabled.

This leads to arm_bmu_handle_irq() executing and reading the uncleared bit
from PMOVSCLR, which evaluates to true in the following WARN_ON():

[ ... ]

> +static void arm_bmu_pmu_irq(struct arm_bmu_pmu *pmu)
> +{
> +	u32 reg =3D readl_relaxed(pmu->base + PMOVSCLR);
> +	u64 __iomem *pmevcnt =3D pmu->base + PMEVCNTR_LO;
> +
> +	for (int i =3D 0; i < PMU_MAX_COUNTERS; i++) {
> +		if (!(reg & (1U << i)))
> +			continue;
> +		if (WARN_ON(!pmu->evcnt[i]))
> +			continue;

[ ... ]

> +static int arm_bmu_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	const struct resource *res;
> +	struct arm_bmu *bmu;

[ ... ]

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
> +	/* We don't expect to have dual-page complications to worry about */
> +	sz =3D FIELD_GET(MCUCFG_PMU_ELEMENT_SIZE, cfg);
> +	if (sz !=3D 1)
> +		return dev_err_probe(dev, -EINVAL, "PMU_ELEMENT_SIZE 0x%x not supporte=
d\n", sz);
> +
> +	/* The PMU pages *are* exclusively ours */
> +	off =3D SZ_4K * FIELD_GET(MCUCFG_PMU_ELEMENT_START, cfg);
> +	if (!devm_request_mem_region(dev, res->start + off, num * SZ_4K, dev_na=
me(dev)))
> +		return dev_err_probe(dev, -EADDRINUSE, "Unable to request PMU region\n=
");

[Severity: High]
Does this calculation permit an out-of-bounds MMIO access if the offset from
the hardware configuration register is unexpectedly large?

The off and num values are read from the MCU_CONFIG hardware register and
used to calculate an offset into an ioremapped memory region that was mapped
to resource_size(res). There does not appear to be a check verifying that
off + num * SZ_4K does not exceed resource_size(res).=20

If the hardware registers provide an unexpectedly large offset, accessing
memory outside the ioremapped bounds will trigger a synchronous external
abort when the driver attempts to read the PMCFGR register below:

> +
> +	bmu =3D devm_kzalloc(dev, struct_size(bmu, imus, num), GFP_KERNEL);
> +	if (!bmu)
> +		return -ENOMEM;
> +
> +	bmu->dev =3D dev;
> +	bmu->base =3D base;
> +	bmu->num_imus =3D num;
> +	platform_set_drvdata(pdev, bmu);
> +
> +	base +=3D off;
> +	for (int i =3D 0; i < bmu->num_imus; i++, base +=3D SZ_4K) {
> +		/* At least PMCFGR.SIZE should always be nonzero if visible */
> +		reg =3D readl_relaxed(base + PMCFGR);

[ ... ]

> +	err =3D cpuhp_state_add_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpu=
hp_node);
> +	if (err)
> +		return err;
> +
> +	err =3D perf_pmu_register(&bmu->pmu, name, -1);

[Severity: High]
Could a CPU hotplug event during this narrow window cause a NULL pointer
dereference?

The cpuhp_state_add_instance_nocalls() function is invoked before
perf_pmu_register(). If the assigned CPU goes offline during this exact
window, the hotplug state machine invokes arm_bmu_offline_cpu() which in
turn calls arm_bmu_migrate().=20

This leads to perf_pmu_migrate_context() being called. Because
perf_pmu_register() has not yet executed, the core context pointer is still
NULL, resulting in a dereference of an invalid pointer at the start of the
percpu offset region.

> +	if (err)
> +		cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_n=
ode);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784214112.gi=
t.robin.murphy@arm.com?part=3D2
