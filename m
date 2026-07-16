Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29378285CBC;
	Thu, 16 Jul 2026 15:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784215905; cv=none; b=CvmMpPxd1cf95oOrqtncD7qWTSfoBCaM/F+Ow3hXs12mORTb+ZflNAm3aNUAA6YOX1heLX96xl/VmLrjI7svf3jkf8uorP2eN9XtRBqAfTcSPDLwUzySyGaUbymXKhtAR9EiZ/kWaMNewPqb+RTjkMHBtrY9iSE3k0JXSlIBjMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784215905; c=relaxed/simple;
	bh=/aKD5P9ldzbflKlZq17LYg/OiqJ1hCqlguUdWv2fQtc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oEqz7ipfEvHqg4w/ey/EZnVQSd5WGhqwLzdMiltjdLOsAWxP0KLFdLeyYCnRpK18DrlHi+zlVwIVAJXBZTYGTyArXQBgC8PCndIwp0zoJ4JnJz7RQuE6wNc6QwjGadmRMQcFVjkX0IAjwaO6CqJYgwWatOufoabAwVXbiAi5qAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx7s7dya; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx7s7dya"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A471F000E9;
	Thu, 16 Jul 2026 15:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784215903;
	bh=cbPgB6IT7dVE0prhfdllz7GmFXMWmMYbsByAjbaeqKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lx7s7dyaK3fVwwsTMDOb8M0GXjonGiT9FJFnNjkkHTTKZUhy7A1IGsZpvxC1Sq1xN
	 dogbGAf+1r4LS0Onlgrd9fMA7raEF57OFV7vHqCJMPPQ/8+VM/f/gxs7a3ifFZ4uPB
	 nRtYlbI2PKNCrC5DVc5sC7hXQ2pPXNJvhmiRstaCF1anM/QTZPoHWQp9NjDUzSzdIU
	 e1AIw6IelrWcQFBwlRv9ofq9Z9e7bT18yNkq9HBN6ZVVtz3xPVw/yrX4zwnn8SL/3D
	 TDpPtefI9ps3CvCHp8j5UwSvSuoo/Xuhz7pWdlMJYgJ+uSMplZMJUQLTKcJJbsso+o
	 tY8lC4EN8SpPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] perf: Add Arm Bus Monitor Unit driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: robh@kernel.org, linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <b0b0dc140673b0c8ead56117b3d551c6b48b2089.1784214112.git.robin.murphy@arm.com>
References: <cover.1784214112.git.robin.murphy@arm.com>
 <b0b0dc140673b0c8ead56117b3d551c6b48b2089.1784214112.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 15:31:43 +0000
Message-Id: <20260716153143.83A471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Unconditional use of `ACPI_COMPANION()` and `acpi_device_uid()` ca=
uses a NULL pointer dereference or build failure.
- [High] Missing `continue` when Non-Secure access is disabled leads to wri=
tes to inaccessible PMU registers.
- [High] ABA vulnerability and NMI torn state in lockless `prev_count` upda=
te causes massive PMU count corruption.
- [High] Missing bounds check on the computed PMU region offset against the=
 actual ioremapped memory resource size.
- [High] Missing cleanup of hardware interrupt state on probe error paths c=
auses an unhandled interrupt storm.
- [Medium] TOCTOU race in PMU CPU assignment during probe can bind the PMU =
to an offline CPU, leaving it non-functional.
- [Medium] Ignoring `-EPROBE_DEFER` for the interrupt permanently breaks IR=
Q functionality.
- [Medium] False-positive `WARN_ON` triggered by a race between event delet=
ion and pending PMU interrupts.
- [Low] Format string type mismatch passing a 32-bit `resource_size_t` / `p=
hys_addr_t` to a 64-bit `%llx` specifier.
--

--- Patch [1]: [PATCH v2 1/3] perf: Add Arm Bus Monitor Unit driver ---
commit 46bae7b04d539138ea677d6d9ef5697dcb457c20
Author: Robin Murphy <robin.murphy@arm.com>

perf: Add Arm Bus Monitor Unit driver

Arm's Bus Monitor Unit is a low-level performance analysis tool for
matching and counting transactions at interconnect interfaces. Each
BMU consists of a number of "interface monitoring units", with some
global controls to synchronise them and so permit accurate calculation
of cross-interface metrics.

> diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/ar=
m-bmu.c
> new file mode 100644
> index 0000000000000..c829a0728e9b2
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm-bmu.c
[ ... ]
> +static void arm_bmu_event_read(struct perf_event *event)
> +{
> +	struct hw_perf_event *hw =3D &event->hw;
> +	u64 count, prev;
> +
> +	do {
> +		prev =3D local64_read(&hw->prev_count);
> +		count =3D arm_bmu_read_evcnt(event);
> +	} while (local64_cmpxchg(&hw->prev_count, prev, count) !=3D prev);
> +
> +	count -=3D prev;
> +	local64_add(count, &event->count);
> +}
> +
> +static void arm_bmu_event_start(struct perf_event *event, int flags)
> +{
> +	struct arm_bmu_pmu *pmu =3D to_bmu_pmu(event);
> +
> +	writel_relaxed(1ULL << event->hw.idx, pmu->base + PMCNTENSET);
> +}
> +
> +static void arm_bmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct arm_bmu_pmu *pmu =3D to_bmu_pmu(event);
> +
> +	writel_relaxed(1ULL << event->hw.idx, pmu->base + PMCNTENCLR);

[Severity: Medium]
Should the hardware overflow state (PMOVSCLR) be cleared here when stopping
the event?

If an overflow occurs right before stopping, the pending interrupt bit
remains set. When arm_bmu_event_del() completes, it clears the event pointe=
r.
When the interrupt is finally delivered, wouldn't the interrupt handler see
the overflow bit set and incorrectly trigger the WARN_ON for a NULL event
pointer?

> +	if (flags & PERF_EF_UPDATE)
> +		arm_bmu_event_read(event);
> +}
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
> +		arm_bmu_event_read(pmu->evcnt[i]);
> +		local64_set(&pmu->evcnt[i]->hw.prev_count, S64_MIN);
> +		lo_hi_writeq_relaxed(S64_MIN, pmevcnt + i);

[Severity: High]
Is the lockless compare-and-exchange logic in arm_bmu_event_read() vulnerab=
le
to the ABA problem when resetting prev_count here?

If an NMI interrupts this IRQ handler right after prev_count is set to S64_=
MIN
but before the hardware register is written, arm_bmu_event_read() could read
the old wrapped hardware value and falsely succeed in the cmpxchg because
prev_count is S64_MIN.

This would save the wrapped value as prev_count. When the IRQ handler resum=
es
and resets the hardware to S64_MIN, wouldn't subsequent delta calculations
underflow and cause massive permanent counter corruption?

> +	}
> +	writel_relaxed(reg, pmu->base + PMOVSCLR);
> +}
[ ... ]
> +static int arm_bmu_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/* The PMU pages *are* exclusively ours */
> +	off =3D SZ_4K * FIELD_GET(MCUCFG_PMU_ELEMENT_START, cfg);
> +	if (!devm_request_mem_region(dev, res->start + off, num * SZ_4K, dev_na=
me(dev)))

[Severity: High]
Does this compute the PMU region offset without verifying it fits within the
originally mapped memory resource size?

If the hardware provides an offset such that the new region exceeds
resource_size(res), applying this unvalidated offset to the virtual base po=
inter
and dereferencing it later will access memory outside the mapped virtual
memory area, potentially causing a kernel page fault or panic.

> +		return dev_err_probe(dev, -EADDRINUSE, "Unable to request PMU region\n=
");
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
> +		if (!reg) {
> +			dev_warn(dev, "Non-Secure access to PMU %d not enabled?\n", i);
> +			num =3D 0;
> +		} else {

[Severity: High]
Should there be a continue statement when Non-Secure access is disabled?

Without a continue, the code proceeds to unconditionally write to BMU_PMCR =
and
other registers for this PMU below. Writing to inaccessible secure hardware
from EL1 typically triggers a Synchronous External Abort (SError), resulting
in an immediate kernel panic.

> +			num =3D 1 + FIELD_GET(PMCFGR_N, reg);
> +		}
> +		if (num > PMU_MAX_COUNTERS) {
> +			dev_notice(dev, "PMU %d has %d counters, only using %d\n",
> +				   i, num, PMU_MAX_COUNTERS);
> +			num =3D PMU_MAX_COUNTERS;
> +		}
> +		bmu->imus[i].base =3D base;
> +		bmu->imus[i].num_counters =3D num;
> +
> +		writel_relaxed(PMCR_P | PMCR_E, base + BMU_PMCR);
> +		writel_relaxed(U32_MAX, base + PMCNTENCLR);
> +		writel_relaxed(U32_MAX, base + PMOVSCLR);
> +		writel_relaxed(U32_MAX, base + PMINTENSET);
> +	}

[Severity: High]
Are hardware interrupts left enabled if an error occurs later in the probe
function?

If cpuhp_state_add_instance_nocalls() or perf_pmu_register() fails, the err=
or
path exits without clearing PMINTENCLR. If the hardware asserts the IRQ lin=
e,
the kernel would receive an interrupt without a registered handler, leading=
 to
an unhandled interrupt storm.

> +
> +	bmu->cpu =3D cpumask_local_spread(atomic_fetch_inc(&n), dev_to_node(dev=
));

[Severity: Medium]
Is there a race in assigning the target CPU without holding the CPU hotplug
read lock?

If the selected CPU goes offline before the hotplug registration, the
arm_bmu_offline_cpu callback will not be invoked retroactively because
cpuhp_state_add_instance_nocalls() is used below. Could this leave the PMU
bound to an offline CPU, rendering it non-functional?

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
Does this completely ignore -EPROBE_DEFER from platform_get_irq()?

If platform_get_irq() returns -EPROBE_DEFER, the probe simply succeeds and
falls back to polling mode. This permanently breaks deferred probing for the
interrupt, preventing the driver from retrying when the interrupt controller
is ready.

> +
> +	bmu->pmu =3D (struct pmu) {
> +		.module =3D THIS_MODULE,
> +		.parent =3D dev,
> +		.attr_groups =3D arm_bmu_attr_groups,
> +		.capabilities =3D PERF_PMU_CAP_NO_EXCLUDE,
> +		.task_ctx_nr =3D perf_invalid_context,
> +		.pmu_enable =3D arm_bmu_enable,
> +		.pmu_disable =3D arm_bmu_disable,
> +		.event_init =3D arm_bmu_event_init,
> +		.add =3D arm_bmu_event_add,
> +		.del =3D arm_bmu_event_del,
> +		.start =3D arm_bmu_event_start,
> +		.stop =3D arm_bmu_event_stop,
> +		.read =3D arm_bmu_event_read,
> +	};
> +
> +	name =3D acpi_device_uid(ACPI_COMPANION(dev));

[Severity: High]
Will this cause a NULL pointer dereference if the device has no ACPI compan=
ion
or if CONFIG_ACPI is disabled?

ACPI_COMPANION() returns NULL in these cases, and acpi_device_uid() directly
dereferences it. This would lead to a kernel panic during driver probe on
such configurations.

> +
> +	if (name)
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
> +	else
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%llx", res->start >>=
 12);

[Severity: Low]
Is there a format string type mismatch here?

When CONFIG_PHYS_ADDR_T_64BIT is not enabled, resource_size_t is 32-bit.
Passing a 32-bit integer to a %llx specifier causes undefined behavior,
which can read garbage from the stack for the upper 32 bits.

> +	if (!name)
> +		return -ENOMEM;
> +
> +	err =3D cpuhp_state_add_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpu=
hp_node);
> +	if (err)
> +		return err;
> +
> +	err =3D perf_pmu_register(&bmu->pmu, name, -1);
> +	if (err)
> +		cpuhp_state_remove_instance_nocalls(arm_bmu_cpuhp_state, &bmu->cpuhp_n=
ode);
> +
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1784214112.gi=
t.robin.murphy@arm.com?part=3D1
