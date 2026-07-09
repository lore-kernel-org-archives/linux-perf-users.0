Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306773033CB;
	Thu,  9 Jul 2026 19:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625777; cv=none; b=pwjQhr4J08NmSxH/FnQFiPACfxKC87trdh7NYxiOfjWQ+TWPFk8edjnGxqccXcNHVh2kl+A/AkU4ZTrDzjpyvUyFZyk6ECD2YQFp7OQFEPswNE8bcrkgL4oiKJpMtWAwSGDeD5wNYrdsuLyX4D4LQMztvRmvdaR1bBglq1P1TGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625777; c=relaxed/simple;
	bh=j2YgczC1FZSqFFNy5uzhwAEdbC8aJllpA4aHNmuhgrg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hXjI8yUPm22zBkoE64rkKgZ4BN7DI0NCNVW0wBf+Fph8jWb6bh/WEtMcfd8QmSxM6Q8BXi7dYTwiIRZDr2HpWvrHMirGVBLTwUyoMepcjRFSX1WbpfrZNQOp/rCasGKRRKDkqn6K3YM0HRlEQFl2H/KkCst6Gh9PT8tKsnBaRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z621rvKP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z621rvKP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 854C51F00A3A;
	Thu,  9 Jul 2026 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783625775;
	bh=i9iV01k9ziMP3XSBiiNS8Mi8cRNY/Qwn2OOKpHuWkgY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z621rvKPSwwezB/OhcS5wkzHiP/sprH9wjrtj3g6lakQbSjcIQ8OtBNjD+pYjT9lE
	 xwYhg9rQJndY1wpdDKhwWcwcM82aG8ueKL+E0C11ULH9SCAnZ1S5WufHm1Q/ri1pzy
	 ki0phBJeyg2il6kyPD/rTMEkW3X0tgAzFQZP1SEZ/41/XllmzpbzeMvw24l99LLWfo
	 6y+pWubTvt+Gnew0k3rlNk1ox11L7pyL43I5fQIDPALqpBrh1YU0F+3wchpl2/bPze
	 xDh6RO5LKwx45zZ9guVM03aGzdQWY8ZUo+6BK1hb7VokZ9Aei2+hqY5/F0jUUc0W1W
	 1g7hQhBxvsHiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf: Add Arm Bus Monitor Unit driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <a09eacfd687649c5e97eeb60876cbcbe3efde912.1783439341.git.robin.murphy@arm.com>
References: <cover.1783439341.git.robin.murphy@arm.com>
 <a09eacfd687649c5e97eeb60876cbcbe3efde912.1783439341.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 19:36:14 +0000
Message-Id: <20260709193615.854C51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 11 potential issue=
(s) to consider:
- [High] Uninitialized variable `err` is returned when `devm_request_mem_re=
gion` fails.
- [High] Event validation erroneously pre-increments the event count for al=
l IMUs in `arm_bmu_validate_group()`, rejecting valid groups.
- [High] Improper error checking of `devm_ioremap` return value causes NULL=
 pointer dereference on failure.
- [High] Incorrect CPU hotplug registration order causes NULL pointer deref=
erence or Use-After-Free.
- [High] The driver fails to verify that the hardware-provided PMU offsets =
and sizes fall within the mapped MMIO resource boundary.
- [Medium] Negative IRQ error code from `platform_get_irq()` is stored and =
later passed to `irq_set_affinity()`.
- [Medium] The PMU IRQ handler resets the running hardware counter, permane=
ntly losing events.
- [Medium] Spurious `WARN_ON` triggers if an event is deleted while an over=
flow is pending.
- [Medium] CPU selection races with CPU hotplug because `cpus_read_lock()` =
is not held.
- [Low] Format string type mismatch passing 32-bit `resource_size_t` to `%l=
lx` specifier.
- [Low] Using `%*pbl` format specifier with a pointer to `u64` reads incorr=
ectly on 32-bit architectures.
--

--- Patch [2]: [PATCH 2/2] perf: Add Arm Bus Monitor Unit driver ---
commit 2a4c03f8d2ffe5343511aa668d1b1b9f0e2a6b53
Author: Robin Murphy <robin.murphy@arm.com>
Subject: perf: Add Arm Bus Monitor Unit driver

This commit introduces the Arm Bus Monitor Unit (BMU) driver to support=20
performance event counting on Arm BMU devices, placing it under arm_cspmu=20
to share common register definitions.

> diff --git a/drivers/perf/arm_cspmu/arm-bmu.c b/drivers/perf/arm_cspmu/ar=
m-bmu.c
> new file mode 100644
> index 0000000000000..0ed9e34857ff8
> --- /dev/null
> +++ b/drivers/perf/arm_cspmu/arm-bmu.c
[ ... ]
> +static ssize_t arm_bmu_format_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct arm_bmu_format_attr *fmt =3D container_of(attr, typeof(*fmt), at=
tr);
> +
> +	if (!fmt->config)
> +		return sysfs_emit(buf, "config:%*pbl\n", 64, &fmt->field);
> +
> +	return sysfs_emit(buf, "config%d:%*pbl\n", fmt->config, 64, &fmt->field=
);
> +}

[Severity: Low]
Does passing a pointer to a u64 variable into the %*pbl format specifier re=
ad
incorrectly on 32-bit architectures?=20

The %*pbl specifier expects a pointer to an array of unsigned longs. On 32-=
bit
big-endian systems under COMPILE_TEST, this might result in reversed words.

[ ... ]
> +static int arm_bmu_validate_group(struct perf_event *event)
> +{
> +	struct arm_bmu *bmu =3D to_bmu(event->pmu);
> +	struct perf_event *sibling, *leader =3D event->group_leader;
> +	int num[MAX_IMUS] =3D { 0 };
[ ... ]
> +	for (int i =3D 0; i < bmu->num_imus; i++) {
> +		if (++num[i] > bmu->imus[i].num_counters)
> +			return -EINVAL;
> +	}
> +	return 0;
> +}

[Severity: High]
Does this loop unconditionally increment the event count requirement for ev=
ery
IMU on the device? It appears `++num[i]` will be evaluated for all iteratio=
ns,
meaning valid groups might be rejected if they don't use all available IMUs.

[ ... ]
> +static void arm_bmu_event_stop(struct perf_event *event, int flags)
> +{
> +	struct arm_bmu_pmu *pmu =3D to_bmu_pmu(event);
> +
> +	writel_relaxed(1ULL << event->hw.idx, pmu->base + PMCNTENCLR);
> +	if (flags & PERF_EF_UPDATE)
> +		arm_bmu_event_read(event);
> +}
[ ... ]
> +static void arm_bmu_event_del(struct perf_event *event, int flags)
> +{
> +	struct arm_bmu_pmu *pmu =3D to_bmu_pmu(event);
> +
> +	arm_bmu_event_stop(event, PERF_EF_UPDATE);
> +	pmu->evcnt[event->hw.idx] =3D NULL;
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

[Severity: Medium]
Could an uncleared overflow interrupt trigger this WARN_ON spuriously?

When an event is stopped, the hardware counter is halted, but pending overf=
low
interrupts in PMOVSCLR are not cleared. If an overflow fires just before the
counter is stopped and deleted, the IRQ handler might observe a NULL pointer
here and unnecessarily spam the logs.

> +		arm_bmu_event_read(pmu->evcnt[i]);
> +		local64_set(&pmu->evcnt[i]->hw.prev_count, S64_MIN);
> +		lo_hi_writeq_relaxed(S64_MIN, pmevcnt + i);
> +	}
> +	writel_relaxed(reg, pmu->base + PMOVSCLR);
> +}

[Severity: Medium]
Does writing S64_MIN back to the hardware counter permanently lose events?

The hardware counter is still running while it is being read in the handler.
Blindly resetting it without first disabling it via PMCNTENCLR might overwr=
ite
and drop any counts that accumulated between the read and this reset.

[ ... ]
> +static int arm_bmu_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	/* PMUs and MPAM MSCs are intermingled so we can't claim the whole reso=
urce */
> +	base =3D devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

[Severity: High]
Will IS_ERR(base) ever evaluate to true here?=20

devm_ioremap() returns NULL on failure, not an ERR_PTR. Checking it with
IS_ERR() means allocation failures are silently ignored, leading to a NULL
pointer dereference on the subsequent writel_relaxed().

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

[Severity: High]
Should the hardware-provided offset be validated against the mapped MMIO
resource boundary?=20

Adding `off` to `base` without verifying that the resulting region falls wi=
thin
resource_size(res) could lead to an out-of-bounds memory read if the hardwa=
re
reports an unexpectedly large value.

> +	if (!devm_request_mem_region(dev, res->start + off, num * SZ_4K, dev_na=
me(dev)))
> +		return dev_err_probe(dev, err, "Unable to request PMU region\n");

[Severity: High]
Is `err` uninitialized in this error path?=20

If devm_request_mem_region() fails, it returns NULL and doesn't modify `err=
`.
This might cause the probe function to return random stack garbage, or 0
(success), leaving the driver only partially initialized.

[ ... ]
> +	bmu->cpu =3D cpumask_local_spread(atomic_fetch_inc(&n), dev_to_node(dev=
));

[Severity: Medium]
Could the selected CPU go offline before the PMU's hotplug state is registe=
red?

Since cpus_read_lock() is not held around this selection, a race could leave
the driver permanently bound to an offline CPU if a hotplug event occurs ri=
ght
after this assignment.

> +	bmu->irq =3D platform_get_irq(pdev, 0);
> +	if (bmu->irq > 0) {
> +		err =3D devm_request_irq(dev, bmu->irq, arm_bmu_handle_irq,
> +				       IRQF_NOBALANCING | IRQF_NO_THREAD,
> +				       dev_name(dev), bmu);
> +		if (err)
> +			bmu->irq =3D 0;
> +		else
> +			irq_set_affinity(bmu->irq, cpumask_of(bmu->cpu));
> +	}
> +	if (!bmu->irq)
> +		dev_info(dev, "Continuing without IRQ\n");

[Severity: Medium]
If platform_get_irq() fails and returns a negative error code, will it bypa=
ss
the `!bmu->irq` check and retain the negative value?

Later during a CPU hotplug migration, arm_bmu_migrate() checks `if (bmu->ir=
q)`
and might pass this negative error code directly into irq_set_affinity().

[ ... ]
> +	if (name)
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%s", name);
> +	else
> +		name =3D devm_kasprintf(dev, GFP_KERNEL, "arm_bmu_%llx", res->start >>=
 12);

[Severity: Low]
Could using %llx here cause format string corruption on 32-bit builds?=20

Under COMPILE_TEST, `res->start` is a resource_size_t, which is a 32-bit
integer on 32-bit architectures. Passing a 32-bit integer to a 64-bit format
specifier will consume extra bits from the variadic arguments.

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

[Severity: High]
Does registering with CPU hotplug before perf_pmu_register() create a race
window?=20

If a hotplug event fires between these two calls, it would trigger
perf_pmu_migrate_context() on an uninitialized PMU context, which might res=
ult
in a NULL pointer dereference.

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
> +}

[Severity: High]
Similarly, does unregistering the PMU before removing the hotplug instance
create a use-after-free window if a hotplug event occurs right after
perf_pmu_unregister() returns?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1783439341.gi=
t.robin.murphy@arm.com?part=3D2
