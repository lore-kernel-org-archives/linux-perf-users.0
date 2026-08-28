Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393BD3451A6
	for <linux-perf-users@vger.kernel.org>; Fri, 28 Aug 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908246; cv=none; b=TT36casKE2rTLb93MmT6WelhyY/h+IApcR9CwjUmJGZGr0eE51y3+1kVbmqH7JfC3sCdC8Wg5MIyLa8O6EyOEUedipedFjdtjASwY3iAH5xC+xEiCf4DupnO71hf2h9HwoAlbcSpUijTHZ4qdi3A3pYPiC1rkzlMjpoWjN+ACMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908246; c=relaxed/simple;
	bh=kJ0ZJCIpF1gJhkthFkfxfwZXh/4/J7Hrp0goFZKgkUI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ihUkjoKXFltmzPX9xmxf4qWDpc5NciYdSFTsDXmlLvXz77L8TRvtoURe7rhJCoIDGHjvS+c3YYIvwVTr4Jes/gLZk/hMcL/KkfqN+Bd8BBgmyiBDD0iykoRgj2EKaaNmQdyDHGH+T4Plse9URcZvVIR1okY7r0+KgzJ7/f74XAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJUPjoN2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJUPjoN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0DF1F000E9;
	Fri, 28 Aug 2026 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787908244;
	bh=FHkHUrIpkE32IgpdOCdfaqjY9mPnrkxUYVUxCVQDVCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJUPjoN20QaguABd4/6O0pAKOg0y2PUzqDHRiEvHwWGiurzgXB82HVz6zIeL2MQhz
	 0WKQEgVJv6vf7RTPglsqSYsRIXK/V6UAipLsS2kmYzn+rWtgebNvOwBcH3h6wipUbw
	 +D8IAq38JzOisLzjgj5WvNSD3Lye+Moa6BEO1oP8dvbTEf5FF68JhrwqxIcHFvrTmu
	 u4utFLTSrYLn3kvIjM4CKA4PTKo++ML7zvTS/duAHCgGGYrj426VX6RUmtA9mlfwMU
	 9MazBb0BYq96NzFBCGi3ROHA30BT/Qt3CQYtijxlj+hvtIkk/4MWjtwS3VCZIbV73t
	 tbt7fgx9ALbhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v7 1/3] drivers/perf: riscv-iommu: add risc-v
 iommu pmu driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260828085819.4076449-2-zong.li@sifive.com>
References: <20260828085819.4076449-1-zong.li@sifive.com>
 <20260828085819.4076449-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 09:10:44 +0000
Message-Id: <20260828091044.AE0DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unconditional event update in PMU IRQ handler corrupts stopped e=
vents
--

commit 9e07a4e349b75961d81fbcf21e24a523435b3ee8
Author: Zong Li <zong.li@sifive.com>
Subject: drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit adds a new driver to support the RISC-V IOMMU PMU. The driver is
created as an auxiliary device by the parent RISC-V IOMMU driver and
implements the standard perf hardware performance monitor callbacks.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..f6acd56f2f616
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static int riscv_iommu_pmu_add(struct perf_event *event, int flags)
> +{
[ ... ]
> +	pmu->events[idx] =3D event;
> +	hwc->idx =3D idx;
> +	hwc->state =3D PERF_HES_STOPPED | PERF_HES_UPTODATE;
> +	local64_set(&hwc->prev_count, 0);

[Severity: Medium]
Will this lead to a spurious massive count delta if an interrupt occurs bef=
ore
the event is started?

A newly added event has its state set to PERF_HES_STOPPED and prev_count
initialized to 0 here. If the event is not immediately started (i.e.
PERF_EF_START is not set), it remains stopped but visible in pmu->events[id=
x].

[ ... ]
> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
[ ... ]
> +	ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> +	if (ovf) {
> +		bitmap_from_u64(ovf_bitmap, ovf);
> +		for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
> +			struct perf_event *event =3D pmu->events[idx];
> +
> +			/*
> +			 * A counter may overflow just before its event is
> +			 * removed by riscv_iommu_pmu_del(), which leaves the
> +			 * overflow bit set with no event bound to the counter.
> +			 * There is nothing to update in that case, but the
> +			 * overflow bit still has to be cleared below, otherwise
> +			 * the interrupt would stay pending forever.
> +			 */
> +			if (event) {
> +				riscv_iommu_pmu_update(event);
> +				riscv_iommu_pmu_set_period(event);
> +			}

[Severity: Medium]
Does this code update events even if they are in a stopped state?

When a hardware overflow interrupt occurs (e.g. from another active counter=
 or
a stale overflow bit left from a deleted event), the IRQ handler unconditio=
nally
calls riscv_iommu_pmu_update() and riscv_iommu_pmu_set_period() for any map=
ped
event.

If the event mapped in pmu->events[idx] was added but is currently stopped
(as initialized in riscv_iommu_pmu_add()), this unconditional update calcul=
ates
a delta using the hardware counter and a prev_count of 0, adding a large
spurious delta to event->count and reprogramming the hardware period unexpe=
ctedly.

Should there be a check like if (!(event->hw.state & PERF_HES_STOPPED)) bef=
ore
updating?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828085819.4076=
449-1-zong.li@sifive.com?part=3D1
