Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7205312825
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 02:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787281017; cv=none; b=LDEtJaZ0P7P6NfYT5woEKxrDGoRAOlgmTU8VzP3hCmmTknVHQlCcxYRgGu/eySsBTk2nFLuXaGH3Z5yOTGVWsGkAsQygoNa0kT7yoIrdMgnjMNfnLPS60aoghSbW/YLN8YUNacRIv8ZPOHPcgVi+0/mOhtg9mEV5bHZU9ve2VGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787281017; c=relaxed/simple;
	bh=Pq9uGYRuc4+5oqAMByILuI9JYQuwQ/fEpys4AxODvTQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDJWpDjqAKjogPePq/cz4C2Iwi5f1X5gwmwoBJ4YybQH9042JpNkwF5vOAgc6kB04Cm1jxdZUu0zcdRGKNIFiNy7drYiTir0/L+h6vy0s3VCM0F3mMS3y7g1cZMVzOqZALqdhP9MM6d/0ESVjO4rZGxZ0pFf8RYyrqwm6WJDJQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6tF3DZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6tF3DZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9911F000E9;
	Fri, 21 Aug 2026 02:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787281015;
	bh=GuTpQXvrmMWVdzknDVOTrX3ku9cfUV8MtRvO0kbmIhU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6tF3DZK9Xn1jPbFxR61cSozKq2tE6L7bMyXC/HbqRA9G+oNTP1rnpTrh2VU0gprh
	 7E3RIl+XF8cra658TlIQ3ffCsadsnomEY90PEa5zhQ92TrOy8ZtFXlxagBuL6ecanJ
	 A+T/AT0OET5zT3VRdT/WeXAO9IBiKFvsb4oR+zKwKmACnIkw7hmxLfXul9RLpXGyax
	 2soji0GVOUaH85/1Uy2fE135db0UMy6m8r/tGSOiDSm9IM/AVhz69eip+rmQBx4r42
	 GyTIGAZnPRjrzSL5X5DOOQFZAk6MC/JzyLZLaHX6c/byA+LQSjjmqlxPRZXTYPfe0g
	 GuXohOjnhZQoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260821023854.2746349-2-zong.li@sifive.com>
References: <20260821023854.2746349-1-zong.li@sifive.com>
 <20260821023854.2746349-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 02:56:54 +0000
Message-Id: <20260821025655.3C9911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] The auxiliary driver lacks a `.remove` callback, permanently leaki=
ng the registered PMU and CPU hotplug state, and leading to a use-after-fre=
e upon device removal.
- [High] The IRQ is requested on the parent IOMMU device instead of the aux=
iliary device, causing the IRQ lifecycle to outlive the `pmu` pointer passe=
d as `dev_id`.
- [High] The custom hi-lo-hi 64-bit counter read logic fails to detect wrap=
s if `lo_prev` was sampled at a small value.
- [High] The PMU driver requests its interrupt without `IRQF_SHARED`, which=
 will fail and break the PMU on systems where the IOMMU shares a single int=
errupt vector.
- [Medium] The driver assigns the PMU's CPU and registers the CPU hotplug i=
nstance without holding `cpus_read_lock()`, which can permanently pin the P=
MU to an offline CPU.
- [Medium] Software group leaders incorrectly consume a hardware counter sl=
ot during event initialization.
- [Medium] Deleting a PMU event does not clear pending hardware overflows, =
leading to a teardown race that triggers a spurious `WARN_ON_ONCE`.
--

--- Patch [1]: [PATCH v5 1/2] drivers/perf: riscv-iommu: add risc-v iommu p=
mu driver ---
commit 76e5b588d50530adc2e8af05625ed2c20f89b431
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new driver to support the RISC-V IOMMU PMU. It is
implemented as an auxiliary device driver created by the parent IOMMU
driver.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..984ddb1c7f399
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 =
idx)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx);
> +	u64 value, counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cnt=
r_mask;
> +	u32 hi, lo;
> +
> +	hi =3D readl(addr + 4);
> +	lo =3D readl(addr);
> +
> +	if (lo <=3D pmu->lo_prev[idx] || hi !=3D pmu->hi_prev[idx]) {

[Severity: High]
Can this miss a wrap if lo_prev was sampled at a small value?

If the counter wraps between reading the high and low halves, but the new
low value is still greater than a stale lo_prev, wouldn't the wrap check
evaluate to false and return a torn read?

> +		u32 hi_tmp =3D readl(addr + 4);
[ ... ]
> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
[ ... ]
> +	if (!is_cycle_event(get_event(event)))
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +
> +	if (!is_cycle_event(get_event(event->group_leader)))
> +		if (++counters > total_event_counters)
> +			return -EINVAL;

[Severity: Medium]
Does this incorrectly consume a hardware counter slot if the group leader
is a software event?

Should this check is_software_event() for the group leader before
incrementing the counter requirement?

> +
> +	for_each_sibling_event(sibling, event->group_leader) {
[ ... ]
> +static void riscv_iommu_pmu_del(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	int idx =3D hwc->idx;
> +
> +	riscv_iommu_pmu_stop(event, PERF_EF_UPDATE);
> +	pmu->events[idx] =3D NULL;

[Severity: Medium]
Can this trigger the WARN_ON_ONCE() in the IRQ handler?

If an event overflows and is immediately deleted, the hardware overflow bit
is left set while the event pointer is cleared to NULL here. When the
pending interrupt is subsequently handled, wouldn't it detect the overflow,
find a NULL event, and trigger the WARN_ON_ONCE(!event)?

> +	clear_bit(idx, pmu->used_counters);
> +
> +	perf_event_update_userpage(event);
> +}
[ ... ]
> +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iommu,
> +				       struct riscv_iommu_pmu *pmu)
> +{
> +	return devm_request_irq(iommu->dev, pmu->irq, riscv_iommu_pmu_irq_handl=
er,
> +				IRQF_NOBALANCING, dev_name(iommu->dev), pmu);

[Severity: High]
Is it safe to request the IRQ on the parent iommu->dev instead of the
auxiliary device?

If probe fails later, the auxiliary device memory for the pmu object will
be freed, but the IRQ handler would remain registered on the parent device,
potentially leading to a use-after-free on the next interrupt.

[Severity: High]
Will this fail to probe on systems that share a single interrupt vector?

The parent IOMMU driver likely requests the IRQ with IRQF_SHARED.
Shouldn't this request also include IRQF_SHARED to avoid a flag mismatch
rejection?

> +}
> +
> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{
[ ... ]
> +	/*
> +	 * Bind all events to the same cpu context to avoid race enabling.
> +	 * Pick a local CPU from the numa node of this iommu for the locality.
> +	 */
> +	iommu_pmu->numa_node =3D dev_to_node(iommu_dev->dev);
> +	iommu_pmu->on_cpu =3D cpumask_local_spread(0, iommu_pmu->numa_node);
> +	iommu_pmu->irq =3D riscv_iommu_pmu_get_irq_num(iommu_dev);
> +	ret =3D irq_set_affinity(iommu_pmu->irq, cpumask_of(iommu_pmu->on_cpu));
> +	if (ret)
> +		dev_dbg(&auxdev->dev, "failed to set irq %u affinity to cpu %u: %d\n",
> +			iommu_pmu->irq, iommu_pmu->on_cpu, ret);
> +
> +	ret =3D riscv_iommu_pmu_request_irq(iommu_dev, iommu_pmu);
> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to request irq %s: %d\n", name, ret);
> +		return ret;
> +	}
> +
> +	ret =3D cpuhp_state_add_instance_nocalls(cpuhp_state, &iommu_pmu->node);

[Severity: Medium]
Can the selected CPU go offline right before the hotplug instance is
registered?

Since cpus_read_lock() is not held around the CPU selection and
cpuhp_state_add_instance_nocalls() registration, the selected CPU could
potentially go offline in between. Wouldn't this permanently pin the PMU to
an offline CPU?

> +	if (ret) {
> +		dev_err(&auxdev->dev, "Failed to register hotplug %s: %d\n", name, ret=
);
> +		return ret;
> +	}
[ ... ]
> +static struct auxiliary_driver iommu_pmu_driver =3D {
> +	.driver =3D {
> +		.suppress_bind_attrs =3D true,
> +	},
> +	.probe		=3D riscv_iommu_pmu_probe,
> +	.id_table	=3D riscv_iommu_pmu_id_table,
> +};

[Severity: High]
Does this auxiliary driver need a .remove callback?

The probe function registers with the perf and cpuhp subsystems using
non-devm APIs. Without a remove function to unregister them, unbinding the
parent driver could leave active subsystem references to freed memory.

> +
> +static int __init riscv_iommu_pmu_init(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821023854.2746=
349-1-zong.li@sifive.com?part=3D1
