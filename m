Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5932E5B02
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789716742; cv=none; b=uIyOjw9U8luyRNUkK5EiN3M/MZMGshTksg0zk1Vd0aq245luguQ9uHX2imAenMJ3W48EwvOYtL9kVogTkydfSNHVatR4NKYwdGxszU2YHaRYYMrMS3V5qSug92zS/wSEOqaMol4taWVRhY8DnPZDweM2JDuGQkuB/lkd5Yi8Rsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789716742; c=relaxed/simple;
	bh=RyE9hSq5G/mQnRvr9/uieFfrjja4jVc60DhLDWsZpHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SCs/BLZDWNPThEbQW7sRYWOvcXI48Y1RMVL4WM2eXvBg1WnuDzmOG1aT3o5/mIOFguEvJ9mM85/IdgoRt8UpnB1UkbRbUhTk/8VFssT5nLfeWHzg9HWSOFpj9xaUbsa4zQWAAkIrp42hWaZykpaWSyVZsUjRpe7CeNvh7onUg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXBaUJhv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXBaUJhv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999291F000FF;
	Fri, 18 Sep 2026 07:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789716740;
	bh=Fja9/04GiNT33YTJ5ZHFOs6EOKhcAL7Jpw6oZ+9mY5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VXBaUJhvFPjt24bZEviE8zFprV+9XauqE3AuPbxvexWpxj4r2Cv+snaDIbhH/EcPo
	 NXHq+M1BIGJoBaMRPBAqwkXPoWRY2oesBda/omuhmOsnZbvTRHo2r5eNsfnMR3GILC
	 0TVOeXpmuLfuscYDp5mimwG9Q6reODEVMWANLpbX9zygiQoYwj5Q/wqE/9TJgU79VU
	 bnHG+q5i+q00VamFlPDwMwcZuzUBR5ixk4JqF2/Ckhw48Ewa5AHbieW2ALZ0d9aLYd
	 FYL99tCHQ9pz7lwPsH+1UJB4WxPLZSHJ2sgWgBUIXiJxOmf3olfB+1PRu6lrNdnq1l
	 xq1xPcLLCP5qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260918072027.639239-2-zong.li@sifive.com>
References: <20260918072027.639239-1-zong.li@sifive.com>
 <20260918072027.639239-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 07:32:20 +0000
Message-Id: <20260918073220.999291F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] perf: data corruption due to missing lock in pmu->read()
--

commit 7fd0bb502a12a89e86b91b6b0afc0e10a1763701
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new driver to support the RISC-V IOMMU PMU, an auxiliary
device driver created by the parent RISC-V IOMMU driver. It implements
hardware counter detection and separates the cycle counter from event
counters. Raw spin locks are used to avoid CPU hotplug races and
IRQCHIP_MOVE_DEFERRED issues.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..ac4d225cca85f
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c

[ ... ]

> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx =3D hwc->idx;
> +	u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +
> +	/*
> +	 * riscv_iommu_pmu_set_period() resets the hardware counter and
> +	 * prev_count as two separate writes.
> +	 * Pairing a "prev" read from before that reset with a "now" read from
> +	 * after it would produce a nonsensical, possibly huge, delta.
> +	 * Re-checking prev_count after the hardware read detects that torn
> +	 * pairing and retries.
> +	 */
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> +	} while (prev !=3D local64_read(&hwc->prev_count) ||
> +		 local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);
> +
> +	delta =3D (now - prev) & counter_mask;
> +	local64_add(delta, &event->count);
> +}

[ ... ]

> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	riscv_iommu_pmu_update(event);

[Severity: High]
Does this missing pmu->lock expose the lockless update loop to a race with
the IRQ handler?

The commit message explicitly notes that due to PCI MSI/MSI-X on IMSIC
setting IRQCHIP_MOVE_DEFERRED, the IRQ handler can run on a different CPU
than the CPU the events are bound to.

If the IRQ handler on CPU A calls riscv_iommu_pmu_set_period() concurrently,
it writes the new hardware counter value and then updates prev_count. If an
unprivileged user reads the perf event fd on CPU B, triggering this
riscv_iommu_pmu_read() call without holding pmu->lock, the lockless loop in
riscv_iommu_pmu_update() can read the old prev_count and the newly updated
hardware counter.

This would allow the cmpxchg to succeed before the IRQ handler updates
prev_count, resulting in a massive bogus delta being calculated and added
to the performance event count.

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918072027.6392=
39-1-zong.li@sifive.com?part=3D1
