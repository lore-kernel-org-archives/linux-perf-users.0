Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D335201F
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Jun 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782809780; cv=none; b=KKSoxkvVJTxAflRVLBdcOLgA2OQ/1JKevm8R65SA8MecUwHh6Hzayvl+WrP6mCI4fheZpowlqsAgPiVY3LqBs/4mp0y21zhyTtQaTKpiUQHhreW6lO5nyPt0bngF06DUaCGvNkYmCLUElcTtwaH3uczTwL8zpTVttO3o9lzyJIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782809780; c=relaxed/simple;
	bh=vcEBg3CaBnA6gnQ+zu9tUooAvEfeZoUZrLzAJA/Hf1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OtbEkYl9ATdL+WuN2T34d9538dDX8A24As4K9dM8tw6ObAwkZoEldL6fvNDcgxQ9Q3VdvA+hjQhmK952HzOy224oF9Hgs/H8+ji8dg7wRS3zZaAFq+oJfYYgqgPvMCdQOlIJ0tPkdojlOVJzGhf1YqdhTn+vRVqeiKf3wsWd4J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMpPdY3C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMpPdY3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F961F000E9;
	Tue, 30 Jun 2026 08:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782809778;
	bh=7i3iH8rvKoiYaeO5nCpAkz8Psqe3Vk/icRwG0rsAw3I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IMpPdY3CDRqciTPGr+xVhnXY5ZqqUEfWKL8KyfqG3+ljFWSFmxeremzZzpvDDuhh+
	 0mm4fz8J4iI/E5K7lXzCJxdyhcqElkKxFAMGK/9n0Ax2KziqsBiFsoQ6nnUVMA+yen
	 +kvPBbv7zjZeNk9SkMMS86fO6TiW/FFhSfblS3yZTpkLGNAoXcgUAUlwQTUunExQNs
	 EwizVxKpx5IdMRYiejE7YrEo89KtQrOUeLRK/I5ALXE1QHTW/uEQlAlTbBFD9odbYD
	 xFLuq0adyB8vQnyAV74V11q/MZC9MIYlGfYsKeRt7ajUoXfci9s/MLW5j0kuGQVUsd
	 SJaGv+vEr0wBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260630083833.1275837-2-zong.li@sifive.com>
References: <20260630083833.1275837-1-zong.li@sifive.com>
 <20260630083833.1275837-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:56:18 +0000
Message-Id: <20260630085618.71F961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 12 potential issue=
(s) to consider:
- [High] Missing `.remove` callback in the auxiliary driver leads to Use-Af=
ter-Free of PMU and CPU hotplug instances.
- [High] PMU IRQ is requested on the parent device instead of the auxiliary=
 device, causing Use-After-Free on unbind.
- [High] Missing spinlocks and IRQ CPU affinity results in data races on sh=
ared MMIO and software state.
- [High] Passing a 32-bit `u32` pointer to `for_each_set_bit` causes KASAN =
stack-out-of-bounds reads and failure on big-endian architectures.
- [High] Failure to clear the event counter overflow (OF) bit causes a perm=
anent interrupt storm.
- [High] Flawed cycle event check in `riscv_iommu_pmu_set_event` leads to a=
n out-of-bounds 64-bit MMIO write.
- [High] Undefined behavior from shifting `icvec` by a bitmask causes the w=
rong IRQ vector to be mapped.
- [Medium] Unmanaged `free_irq` paired with `devm_request_irq` causes a dev=
res leak and WARN on teardown.
- [Medium] Requesting `IRQF_ONESHOT` without a threaded handler triggers an=
 unconditional `WARN_ON_ONCE` in the IRQ core.
- [Medium] Broken perf group validation logic enables the creation of overs=
ized event groups.
- [Medium] Incorrect counter topology discovery using `hweight32` misses no=
n-contiguous hardware counters and causes UB.
- [Medium] Race condition clearing the Write-1-to-Clear (W1C) pending bit l=
oses new PMU interrupts.
--

commit d9f0a1344a5b91b6021c1f8b59b255eb9fdf5355
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
device driver created by the parent RISC-V IOMMU driver.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..2e856289ddc95
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static bool is_cycle_event(u64 event)
> +{
> +	return event =3D=3D RISCV_IOMMU_HPMEVENT_CYCLE;
> +}
> +
> +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 i=
dx,
> +				      u64 value)
> +{
> +	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> +	if (is_cycle_event(value))
> +		return;
> +
> +	/* Event counter start from idx 1 */
> +	writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
> +	       pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
> +}

[Severity: High]
What happens if a user configures a cycle event but sets filter bits
(e.g., pid_pscid)?

Because is_cycle_event() compares the raw 64-bit config to 0 instead of mas=
king
the event ID, it would return false. The code would then execute a write to
IOHPMEVT(idx - 1).

Since idx is 0 for the cycle counter, idx - 1 underflows, which might cause=
 an
out-of-bounds 64-bit MMIO write.

> +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, =
u32 idx)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value =3D readl(addr);
> +
> +	writel(value & ~BIT(idx), addr);
> +}

[Severity: High]
Could this lockless read-modify-write race with the IRQ handler?

Since the driver pins all perf events to a specific CPU but requests the sh=
ared
IRQ without setting CPU affinity, the hardirq handler can run concurrently =
on
any CPU.

Without spinlocks, the handler might race with perf core operations on MMIO
registers here, as well as shared state like the pmu->events array.

[ ... ]
> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
[ ... ]
> +	if (is_cycle_event(get_event(event->group_leader)))
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (is_cycle_event(get_event(sibling)))
> +			continue;
> +
> +		if (sibling->pmu !=3D event->pmu && !is_software_event(sibling))
> +			return -EINVAL;
> +
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[Severity: Medium]
Does this group validation logic tally the counters correctly?

It appears to skip counting the new event itself, increments the event count
if the leader is a cycle event (which does not consume an event counter), a=
nd
skips counting non-cycle leaders entirely.

Could this allow the creation of oversized event groups that exceed hardware
constraints, causing them to fail late during scheduling?

[ ... ]
> +static irqreturn_t riscv_iommu_pmu_handle_irq(struct riscv_iommu_pmu *pm=
u)
> +{
> +	u32 ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> +	int idx;
> +
> +	if (!ovf)
> +		return IRQ_NONE;
> +
> +	riscv_iommu_pmu_stop_all(pmu);
> +
> +	for_each_set_bit(idx, (unsigned long *)&ovf, pmu->num_counters) {

[Severity: High]
Can casting this 32-bit u32 variable to an unsigned long pointer cause KASAN
stack-out-of-bounds reads on 64-bit architectures?

Since unsigned long is 8 bytes on 64-bit platforms, passing it to
for_each_set_bit() might evaluate uninitialized stack memory past the ovf
variable, and also misbehave on big-endian architectures.

> +		struct perf_event *event =3D pmu->events[idx];
> +
> +		if (WARN_ON_ONCE(!event))
> +			continue;
> +
> +		riscv_iommu_pmu_update(event);
> +		riscv_iommu_pmu_set_period(event);
> +	}

[Severity: High]
Does the handler need to clear the overflow (OF) bit in the IOHPMEVT regist=
er?

The handler recalculates the period and resets the counter, but without wri=
ting
back to IOHPMEVT to clear the OF bit, the interrupt pending condition might
never be resolved.

Could this result in an infinite PMU interrupt storm?

> +
> +	riscv_iommu_pmu_start_all(pmu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> +	irqreturn_t ret;
> +
> +	/* Check whether this interrupt is for PMU */
> +	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR=
_PMIP))
> +		return IRQ_NONE;
> +
> +	/* Process PMU IRQ */
> +	ret =3D riscv_iommu_pmu_handle_irq(pmu);
> +
> +	/* Clear performance monitoring interrupt pending bit */
> +	writel_relaxed(RISCV_IOMMU_IPSR_PMIP, pmu->reg + RISCV_IOMMU_REG_IPSR);

[Severity: Medium]
Is there a race condition when clearing the Write-1-to-Clear pending bit he=
re?

The bit is cleared after the hardware counters are uninhibited by
riscv_iommu_pmu_start_all(). If a counter overflows very rapidly right after
being started, it will assert the interrupt again.

Clearing the pending bit at this point would wipe out that new pending state
before it can be handled, potentially losing PMU interrupts.

> +
> +	return ret;
> +}
> +
> +static unsigned int riscv_iommu_pmu_get_irq_num(struct riscv_iommu_devic=
e *iommu)
> +{
> +	/* Reuse ICVEC.CIV mask for all interrupt vectors mapping */
> +	int vec =3D (iommu->icvec >> (RISCV_IOMMU_IPSR_PMIP * 4)) & RISCV_IOMMU=
_ICVEC_CIV;

[Severity: High]
Does shifting icvec by a bitmask value cause undefined behavior?

RISCV_IOMMU_IPSR_PMIP is BIT(3) (which is 8). Shifting by (8 * 4 =3D 32) bi=
ts
on a 32-bit unsigned int is undefined in C.

Should this shift use the raw bit index (RISCV_IOMMU_INTR_PM) instead?

> +
> +	return iommu->irqs[vec];
> +}
> +
> +static int riscv_iommu_pmu_request_irq(struct riscv_iommu_device *iommu,
> +				       struct riscv_iommu_pmu *pmu)
> +{
> +	unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> +
> +	/*
> +	 * Set the IRQF_ONESHOT flag because this IRQ can be shared with
> +	 * other threaded IRQs by other queues.
> +	 */
> +	return devm_request_irq(iommu->dev, irq, riscv_iommu_pmu_irq_handler,
> +				IRQF_ONESHOT | IRQF_SHARED, dev_name(iommu->dev), pmu);
> +}

[Severity: High]
Since this uses devm_request_irq() against the parent iommu->dev instead of
the auxiliary device, could this lead to a use-after-free on unbind?

If the auxiliary device is unbound, devres would free the pmu dev_id, but t=
he
IRQ would remain active on the parent. A subsequent interrupt would then
dereference the freed pmu pointer.

[Severity: Medium]
Also, does passing IRQF_ONESHOT without a threaded handler trigger a
WARN_ON_ONCE() in the IRQ core? __setup_irq() typically enforces that
IRQF_ONESHOT is only used when a thread_fn is provided.

> +
> +static void riscv_iommu_pmu_free_irq(struct riscv_iommu_device *iommu,
> +				     struct riscv_iommu_pmu *pmu)
> +{
> +	unsigned int irq =3D riscv_iommu_pmu_get_irq_num(iommu);
> +
> +	free_irq(irq, pmu);
> +}

[Severity: Medium]
Does using the unmanaged free_irq() to release an IRQ requested via
devm_request_irq() cause a devres memory leak?

This removes the IRQ action but leaves the devres record intact. When the
parent device is eventually destroyed, devres might attempt to free the IRQ
again, triggering a warning.

> +
> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{
[ ... ]
> +	/* Counter number and width are hardware-implemented. Detect them by wr=
ite 1s */
> +	addr =3D iommu_pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	writel(RISCV_IOMMU_IOCOUNTINH_HPM, addr);
> +	iommu_pmu->num_counters =3D hweight32(readl(addr));

[Severity: Medium]
If the hardware has non-contiguous counters, will using hweight32() miss the
valid upper bounds?

For example, if the cycle counter is absent, the population count would be
lower than the highest valid index, which might clip valid upper-index
counters when iterating.

Additionally, if hweight32() evaluates to 0, could GENMASK_ULL(-1, 0)
subsequently generate an undefined negative bitwise shift?

[ ... ]
> +static struct auxiliary_driver iommu_pmu_driver =3D {
> +	.probe		=3D riscv_iommu_pmu_probe,
> +	.id_table	=3D riscv_iommu_pmu_id_table,
> +};

[Severity: High]
Since the auxiliary driver lacks a .remove callback, are the PMU and CPU
hotplug instances left dangling if the driver is unbound?

If the driver is unbound via sysfs or parent IOMMU removal, devres will free
the iommu_pmu structure, which might leave dangling pointers in the perf co=
re
and cpuhp subsystems.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630083833.1275=
837-1-zong.li@sifive.com?part=3D1
