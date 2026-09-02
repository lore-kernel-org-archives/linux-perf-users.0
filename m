Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D943D647E
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Sep 2026 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334636; cv=none; b=CFApFm65nXm2uYHl52HbNSQ2RI8/40+RnSok6r5sCFFSNrNL8a4FHja57Nt6wIb8DIUJcrPtKjvFv3wkE/6E8xj42qRnltPuzL40IW7MfjAh8Vixmm6Wt0qj2rcgaPXfJ7jT6y432tD2qlKcP8UuiAYm00fzm+WxkUMqhB09Fyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334636; c=relaxed/simple;
	bh=V5AJKEAF0dDh1yK0odJC/zyLqEn2ZouSb1O+9SWj8rc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4QTMSPVlHr5eGs1O4ItaJtG8EKg04/Ea/IkeyE/4XMhGMgaTXxND6fNJmtQ8Pf3PIWqqlQdp8dPkMog+KAKWtYaXCGkSe4RKs9UFEwV5mOzuA0toB5xWmjqM5rI5QGDC/FdCvNjxEdcTGXVLayYDoBei332WS5C7WhhPSFKEr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcGMEoi2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcGMEoi2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C4D1F000E9;
	Wed,  2 Sep 2026 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334634;
	bh=JCscU41muTJQAgH7zBf4NV8AX30A8t3tEVax0Hx7EOc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HcGMEoi2gMyEysiXkCGHt4TEXSk7tpfZ6Hw2PeppVmD9oeL0xwh7cDU/lP8leJF1T
	 vY8l7gYdZv50HJWjUnfQIE06aDPJUvpjfq2mFxcgZL/xGTtU0sKfOcwed/Mf0I/5U9
	 pnvQJ5bxuo3oM1E9zusqB+GTAM9xomXA7DZxjza7MzZbZPDYAXrHt3Hrb75IOPbHFx
	 l/JFem9OsTHIsPPGGkjuoqQ4d5x8tiddwp/ufog2MalWLzCQ3iaZVy6yiM7LGcZKQj
	 evGL8c1Q5XfZkK4c798xebn5PBOvmyX27/loH99OxEDdZPrBJjfyEgVM7W3EQokfUu
	 hQO21ITDleMCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: xgene: initialize lock before requesting IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260902072241.3489222-1-runyu.xiao@seu.edu.cn>
References: <20260902072241.3489222-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:37:14 +0000
Message-Id: <20260902073714.77C4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent traversal and lockless modification of PMU device lists=
 during initialization.
- [High] If ACPI or FDT PMU device discovery fails, successfully registered=
 perf PMUs are not unregistered, leading to a Use-After-Free.
- [High] Early interrupt delivery before PMU list population causes an unre=
coverable interrupt storm.
- [High] Registering a static CPU hotplug state globally without proper tea=
rdown causes subsequent probes and driver rebinds to fail permanently.
--

commit c30a076393fbb32657447ba93f8e3397354b3ffa
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

perf: xgene: initialize lock before requesting IRQ

This commit fixes an issue in xgene_pmu_probe() where the PMU IRQ is reques=
ted
before the xgene_pmu->lock is initialized. By moving the raw_spin_lock_init=
()
call before devm_request_irq(), it ensures that xgene_pmu_isr() will always=
 see
a valid lock if it runs immediately.

> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index ab3623fab914c..0aa2b605fd53d 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -1873,6 +1873,8 @@ static int xgene_pmu_probe(struct platform_device *=
pdev)
>  	if (irq < 0)
>  		return -EINVAL;
> =20
> +	raw_spin_lock_init(&xgene_pmu->lock);
> +
>  	rc =3D devm_request_irq(&pdev->dev, irq, xgene_pmu_isr,
>  				IRQF_NOBALANCING | IRQF_NO_THREAD,
>  				dev_name(&pdev->dev), xgene_pmu);

[Severity: High]
This is a pre-existing issue, but is there a data race when modifying PMU d=
evice
lists during initialization?

The IRQ is requested and enabled here, and the CPU hotplug instance is
registered shortly after, before the PMU lists are fully initialized:

drivers/perf/xgene_pmu.c:fdt_pmu_probe_pmu_dev() {
    ...
    list_add(&ctx->next, &xgene_pmu->l3cpmus);
    ...
}

If an interrupt fires immediately or a CPU offline event occurs, xgene_pmu_=
isr()
or xgene_pmu_offline_cpu() could traverse the lists concurrently without lo=
cks:

drivers/perf/xgene_pmu.c:xgene_pmu_isr() {
    ...
    list_for_each_entry(ctx, &xgene_pmu->mcpmus, next) {
    ...
}

Can this lead to list pointer corruption and a kernel panic?

[Severity: High]
This is a pre-existing issue, but can early interrupt delivery before PMU l=
ist
population cause an unrecoverable interrupt storm?

The IRQ is requested and enabled at the interrupt controller level here, be=
fore
child PMU devices are added to internal lists. Additionally, the PMU is exp=
osed
to userspace, allowing events to be scheduled before list population:

drivers/perf/xgene_pmu.c:xgene_init_perf() {
    ...
    return perf_pmu_register(&pmu_dev->pmu, name, -1);
    ...
}

Hardware interrupts are cleared in _xgene_pmu_isr(), but this is unreachabl=
e if
the internal lists are empty:

drivers/perf/xgene_pmu.c:_xgene_pmu_isr() {
    ...
    writel(pmovsr, csr + PMU_PMOVSCLR);
    ...
}

If an interrupt is pending or triggered early by userspace, xgene_pmu_isr()=
 will
iterate over empty lists, fail to clear the hardware interrupt source, and
unconditionally return IRQ_HANDLED:

drivers/perf/xgene_pmu.c:xgene_pmu_isr() {
    ...
    return IRQ_HANDLED;
}

Does this bypass the core kernel spurious IRQ protection and cause a hard l=
ockup?

>  	if (rc)
>  		return rc;
> =20
>  	xgene_pmu->irq =3D irq;
> =20
> -	raw_spin_lock_init(&xgene_pmu->lock);
> -
>  	/* Check for active MCBs and MCUs */
>  	rc =3D xgene_pmu_probe_active_mcb_mcu_l3c(xgene_pmu, pdev);

[Severity: High]
This is a pre-existing issue, but if ACPI or FDT PMU device discovery fails=
, are
successfully registered perf PMUs leaked, leading to a Use-After-Free?

If acpi_pmu_probe_pmu_dev() returns an error after potentially registering
several PMUs:

drivers/perf/xgene_pmu.c:acpi_pmu_probe_pmu_dev() {
    ...
    if (ACPI_FAILURE(status)) {
        dev_err(dev, "failed to probe PMU devices\n");
        return -ENODEV;
    }
    ...
}

The error path fails to unregister the PMUs from the perf subsystem before =
returning:

drivers/perf/xgene_pmu.c:xgene_pmu_probe() {
    ...
out_unregister:
    cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
                                &xgene_pmu->node);
    return rc;
}

Since the device contexts are devm-allocated, will they be freed upon probe=
 failure
while leaving dangling pointers in the perf core?

[Severity: High]
This is a pre-existing issue, but does registering a static CPU hotplug sta=
te
globally without proper teardown cause subsequent probes and driver rebinds=
 to
fail permanently?

xgene_pmu_probe() registers the static CPU hotplug state earlier during pro=
be:

drivers/perf/xgene_pmu.c:xgene_pmu_probe() {
    ...
    rc =3D cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
                                 "CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE",
    ...
}

However, xgene_pmu_remove() only calls cpuhp_state_remove_instance(), and d=
oes not
call cpuhp_remove_multi_state():

drivers/perf/xgene_pmu.c:xgene_pmu_remove() {
    ...
    cpuhp_state_remove_instance(CPUHP_AP_PERF_ARM_APM_XGENE_ONLINE,
                                &xgene_pmu->node);
    ...
}

If the driver is unbound and rebound, will a subsequent probe attempt try to
register the same static state and fail with -EBUSY permanently?

>  	if (rc) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072241.3489=
222-1-runyu.xiao@seu.edu.cn?part=3D1
