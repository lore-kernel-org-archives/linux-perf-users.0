Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B08F43FD21
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789109118; cv=none; b=VC6QDy06CnLWeOh+vcJMDSTZSYWC0lEA97nRTcCqYzyEnTT44g5ldzfL96mOSPTd3R4+6ypuZeUBnRRMexEAAf9HYI9MmmTCqLZy8rOfNcA7M5EIkIwrNMFBLTrskXExcOlKxu4dxJ3TdTLQdPAoGpEYE72A8q6G2QE4tZ2YFWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789109118; c=relaxed/simple;
	bh=u1zb/Xh8PTOPja0z3Pwl2QeYwBOt79SVUPe0fB2KNuk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NVt2mzKWo1RS4eaAlahCtkeZ4VfAtGFhm1A6T0D0qEuSUjVG4yI+2RhRYNaOh8UsXN8P1bFNQ9BdjCwKEo+QGbvIrLBDFxnFLhouW8suCKwDMjFvZrbhD2xUcAZ/KBaBbDhHqgr3oU97mMDyD52pqzJuut4Ct47UYE3RhghqKNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eyTWZpc2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eyTWZpc2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26ED51F00898;
	Fri, 11 Sep 2026 06:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789109106;
	bh=4Ce2IS3o8SNMara/+MJq6wG+uS+XayseyS5U9/NGLJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eyTWZpc2rWb6Czq6Zeduo/H3QODAoOMaSLDYVO47e1Hvy2XDf6qZt/X7BCVejwQ+h
	 YUGWR/KTYhzIcHtwjSGmAk9Q5STfpLTiZjuOiNwvl7q0gCmEm43U+1quUFwpko466P
	 yn8f5VHaOl2DfqlSE9sg6IRE1sXm6vVm/ot8NxnnB3yBhIZXXt08KbZlUW7GnfE8ep
	 Xf3XvWVulegpLn43Pp87J8HSHKO3ilnuYecnxi7OcgrMTHtj22gC7EaEjhsPEtA1eP
	 Vumeyt+kBTnsOuubg26XVtx8o2EGV4XBmpLaXRepsIfXe6wgPpxGmogHRDxLs+jb2I
	 rlFqMTF0oWZPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260911063043.916844-2-zong.li@sifive.com>
References: <20260911063043.916844-1-zong.li@sifive.com>
 <20260911063043.916844-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 06:45:05 +0000
Message-Id: <20260911064506.26ED51F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The driver calls `disable_irq()` on an `IRQF_SHARED` interrupt lin=
e during CPU hotplug, temporarily disabling all shared IOMMU queues.
- [High] Data race during CPU hotplug due to a lack of PMU locking and miss=
ing `event->cpu` verification, leading to concurrent modification of shared=
 driver state.
- [Medium] Unsafe implementation of the hi-lo-hi 64-bit counter read patter=
n, failing to account for hypervisor preemption.
--

commit e130176f91889d6666fe335957e972183fc64e1f
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new auxiliary device driver for the RISC-V IOMMU PMU.
The performance monitor provides counters with filtering support and separa=
tes
the cycle counter from the event counters.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static u64 riscv_iommu_pmu_get_counter(struct riscv_iommu_pmu *pmu, u32 =
idx)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOHPMCTR(idx);
> +	u64 value, counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cnt=
r_mask;
> +	u32 hi, lo, hi_again;
> +
> +	hi =3D readl(addr + 4);
> +	lo =3D readl(addr);
> +	hi_again =3D readl(addr + 4);
> +
> +	if (hi_again !=3D hi) {
> +		hi =3D hi_again;
> +		lo =3D readl(addr);
> +	}

[Severity: Medium]
Could a hypervisor preempt the vCPU inside this if block before lo is re-re=
ad?

In a virtualized environment, if the vCPU is scheduled out for an extended
period before reading the low word again, the hardware counter might wrap
a second time. This would pair a deeply stale high word with a newly wrapped
low word, resulting in a corrupted counter value being returned.

Would a standard do-while loop prevent this issue?

[ ... ]
> +static void riscv_iommu_pmu_disable_counter(struct riscv_iommu_pmu *pmu,=
 u32 idx)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value =3D readl(addr);
> +
> +	writel(value | BIT(idx), addr);
> +}

[Severity: High]
Can this lockless read-modify-write of the IOCOUNTINH register corrupt the
hardware counter enables?

If this is executed concurrently across multiple CPUs during a hotplug race,
concurrent modifications to the shared driver state could be lost.

[ ... ]
> +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	unsigned int num_counters =3D pmu->num_counters;
> +	unsigned int idx;
> +
> +	/* Reserve index zero for iohpmcycles */
> +	if (is_cycle_event(event->attr.config))
> +		idx =3D RISCV_IOMMU_HPM_CYCLE_IDX;
> +	else
> +		idx =3D find_next_zero_bit(pmu->used_counters, num_counters, 1);
> +
> +	/* All event counters or cycle counter are in use */
> +	if (idx =3D=3D num_counters || pmu->events[idx])
> +		return -EAGAIN;
> +
> +	set_bit(idx, pmu->used_counters);
> +
> +	pmu->events[idx] =3D event;

[Severity: High]
Does this code safely handle concurrent allocations during CPU hotplug?

Since the driver appears to rely exclusively on the per-CPU perf_event_cont=
ext
lock without a PMU-level spinlock or event->cpu verification,
riscv_iommu_pmu_add() might execute on two CPUs simultaneously during a hot=
plug
window.

If task A is preempted before installation and migrated, while task B opens=
 an
event on the new CPU, these lockless find_next_zero_bit() and set_bit()
operations could race. This would allow two different events to allocate the
same hardware counter.

[ ... ]
> +static int riscv_iommu_pmu_offline_cpu(unsigned int cpu, struct hlist_no=
de *node)
> +{
> +	struct riscv_iommu_pmu *iommu_pmu;
> +	unsigned int target_cpu;
> +
> +	iommu_pmu =3D hlist_entry_safe(node, struct riscv_iommu_pmu, node);
> +
> +	if (READ_ONCE(iommu_pmu->on_cpu) !=3D (int)cpu)
> +		return 0;
> +
> +	/*
> +	 * Masking the irq for the whole selection + migration sequence below
> +	 * removes the need to reason about exactly when in that window an
> +	 * interrupt could fire - none can, until enable_irq() at the end.
> +	 * This also avoid CPU hotplug race condition
> +	 */
> +	disable_irq(iommu_pmu->irq);

[Severity: High]
Is it safe to call disable_irq() on this interrupt line?

Because the PMU driver requests this interrupt with IRQF_SHARED, it shares =
the
hardware vector with the main RISC-V IOMMU driver's fault and command queue=
s.

Calling disable_irq() physically masks the interrupt at the interrupt contr=
oller
level, which will stop all critical IOMMU interrupts from being delivered d=
uring
CPU hotplug. This could stall IOMMU command completions and device page fau=
lts,
potentially leading to severe I/O timeouts for attached PCIe devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911063043.9168=
44-1-zong.li@sifive.com?part=3D1
