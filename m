Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D092374198
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 09:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908453; cv=none; b=SwxR2u+tDZFLNm3oXOH71TiNH8v8GsAPq1zDWir02MX2lh+t0F9b/IOrKHGcWAi42HvlYTe1fHrFzELIfC1fw0yvocMDTVjCH277EO4QcU39ZK7X70k7sKD0VTuTqOoPFPmz8Is7fF8flwtonkHL47oOMrcJ5eJc8NPWbPXaTUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908453; c=relaxed/simple;
	bh=LNPHDUSFzrNTQwibYVF78askbifv109VF7q0bi6FL7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGDCzAxLQ6WdSm/QyCYG1eWgBbxwqHa0E7c4ZqtRlj6KUadd+FrKC8QkyWXLkxRibAmAA+Aj4BVmvv86TquTU9qteaxBhRXis8sripUHdE98J4iF/AvTvAQbr++wCcoQ91qbMl7pDsfHCpaZxEU6ayEHIOfKbVm/DTEuiVEVT+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/6OsOqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/6OsOqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1DC21F000E9;
	Fri, 28 Aug 2026 09:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908451;
	bh=N5ZNSY/HXJ1EkfPJ9PobtTVzjhmNih1zmfoi5NZF8J4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N/6OsOqJvps8GDiEwQ/NEOcdVHWRWvTWw20ZD6EkmYXf3+sQIIaZUeelpc6tdqu4G
	 bl1zXY3JyO9PhOXifVvBKL1FyFwX8JXzfVwA5NHjaRHlffI/G1tioEgwQ4Z1NTrCGV
	 Y8mYcWqCaASsGpN/d9FaDDsO+gwvlirX8yTQPoUkDbM6HmUC9UFG5HWkNt8b04ryk+
	 pVMIMm3GTbFS73pE3FliWi/wGx2sXP3Yt80zIaIiiPEKQWAvGisOl7cMg1Fw+b56xM
	 NgGue6+pbf+BQmwNSpWfQhikC2N4QPdCAKwMzAn4CAJ+JShypo0O5RhlJsD8+FhpxU
	 4H5WP8fAtdlIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 3/3] drivers/perf: riscv-iommu: protect shared
 state with a raw spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828085819.4076449-4-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
 <20260828085819.4076449-4-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:14:11 +0000
Message-Id: <20260828091411.C1DC21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Taking a raw spinlock in a PMU's read callback can lead to an NMI =
deadlock.

Pre-existing issues:
- [High] The IRQ handler updates the count for newly added but stopped even=
ts, leading to massive data corruption.
--

commit 1a00f5bb6a14fe9e1b35b9a9aa789a513bd04f90
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: protect shared state with a raw spinlock

This commit introduces a raw spinlock to protect shared PMU state, ensuring
that the interrupt handler doesn't conflict with perf callbacks on the same
CPU.

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> index f6acd56f2f616..ee2f6d1fbece4 100644
> --- a/drivers/perf/riscv_iommu_pmu.c
> +++ b/drivers/perf/riscv_iommu_pmu.c

[ ... ]

> @@ -556,18 +586,26 @@ static int riscv_iommu_pmu_add(struct perf_event *e=
vent, int flags)
> =20
>  static void riscv_iommu_pmu_read(struct perf_event *event)
>  {
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	unsigned long irqflags;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
>  	riscv_iommu_pmu_update(event);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
>  }

[Severity: High]
Can taking a raw spinlock in a PMU's read callback lead to an NMI deadlock?

If a user puts an IOMMU PMU event in a BPF perf event array map, a BPF prog=
ram
attached to NMI-context events (like hardware perf counter overflows) can c=
all
bpf_perf_event_read(), which invokes this pmu->read() callback from within =
the
NMI context.

If this NMI interrupts the same CPU while it is executing another PMU funct=
ion
that already holds pmu->lock (such as riscv_iommu_pmu_irq_handler() or
riscv_iommu_pmu_add()), the read callback will spin forever attempting to
acquire the same lock.

Since riscv_iommu_pmu_update() already uses a lock-free local64_cmpxchg() to
handle reentrancy, does this function need the spinlock?

[ ... ]

> @@ -672,6 +722,8 @@ static irqreturn_t riscv_iommu_pmu_irq_handler(int ir=
q, void *dev_id)
> =20
>  	riscv_iommu_pmu_start_all(pmu, inhibit);
> =20
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +
>  	return IRQ_HANDLED;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does the IRQ handler update
the count for newly added but stopped events, leading to data corruption?

Inside riscv_iommu_pmu_irq_handler(), if an overflow bit is set, the handler
updates the event:

	if (ovf) {
		bitmap_from_u64(ovf_bitmap, ovf);
		for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
			struct perf_event *event =3D pmu->events[idx];

			if (event) {
				riscv_iommu_pmu_update(event);
				riscv_iommu_pmu_set_period(event);
			}

If Event A on counter X overflows and is then deleted via
riscv_iommu_pmu_del(), the counter is disabled but its OF bit remains set.

If Event B is subsequently added via riscv_iommu_pmu_add() without
PERF_EF_START, it is assigned the same counter X with prev_count
initialized to 0.

When the delayed interrupt is handled, the handler reads the set overflow b=
it
for counter X, retrieves Event B, and blindly updates it since there is no
check for whether the event is stopped (e.g., !(event->hw.state &
PERF_HES_STOPPED)).

Because prev_count is 0, riscv_iommu_pmu_update() computes delta =3D now - =
prev,
applying the full hardware counter value to Event B's count.

Should this sequence check if the event is stopped before updating?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828085819.4076=
449-1-zong.li@sifive.com?part=3D3
