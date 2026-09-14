Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03849371067
	for <linux-perf-users@vger.kernel.org>; Mon, 14 Sep 2026 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359010; cv=none; b=VT0w9P594u2/80uZJ9nB02LSnxh86vgkT+3TsWcTXVtanz/Y+dIfmAMxuGWDTVenFC7KhlFBryUiig/h7/9at2V4gYLRpVN3POCU8ml2v1LL5/0xYMjKXU3YjciSOPWX7lzYR5AEDkwHLbK5LkAhs9GIzBAFR0qhhc+K2488yDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359010; c=relaxed/simple;
	bh=/ghEcT29F/Tbt7h8XAYTuaat2EMxyQMQ1RsfGmZ0yTg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OYDIsvhupfaPNKJ/fbxmI8sfo/ZqOgDPAqISRjaFelWVveaLLVljdT6E1j9gklmpranAqQ1AtcD9rnn/zaNVBzYYlXUttpTheSiMNrmxIOpxB4+uPKJeeJlCivkV9T15C1GLfT3J9WU5C/ey/dB5anqglQsGavEcXBiaLNK9bTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eB9Td6NT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eB9Td6NT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6591F000FF;
	Mon, 14 Sep 2026 04:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789359008;
	bh=wGMmruimwIPQlz2BWJ0iBC+FYeQ94ZCkOzpTiK+aQfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eB9Td6NT3LzbJ6cTZTvDLk2SiVUt+LAh21CKEwtk8Ai++I+3kk8SqZYnLznCFkDo1
	 24w+kK6T9MtVb0sOVrh+bIG1AOvo9tJZuVT2u1nkWOUqsPpG+EN7GRcYUj27FQsk3a
	 IkXQNjKFjcbXJF9u/5huKwrAEshQTXb5EBOjsHC9MzoRsYoLdHr6e7Aqfyy1NnkoTM
	 TXEH7gAuqXKOcMPagnycO+H7i8cc6RYbHJEGsBMU3tHf+Bk5NwpGFU+eIq23qbrmUP
	 MMR4rIwnfMjg870EHk0+OgA8rgOWA0g2arwQawfbkl8xc7z4HiqN8fXqcRDMIvjF98
	 FnaEdtZXhkxow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260914035723.2922057-2-zong.li@sifive.com>
References: <20260914035723.2922057-1-zong.li@sifive.com>
 <20260914035723.2922057-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 04:10:08 +0000
Message-Id: <20260914041008.6B6591F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing lock in riscv_iommu_pmu_read() causes an ABA problem lea=
ding to PMU counter corruption.
- [Medium] Race condition between riscv_iommu_pmu_stop() and the PMU interr=
upt handler corrupts the event count.
--

commit b8d3941b5b291aa94d0cd6d3586fcdf47a4951e6
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

Add a new driver to support the RISC-V IOMMU PMU. This is an auxiliary
device driver created by the parent RISC-V IOMMU driver.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..b4906c44d2a08
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static void riscv_iommu_pmu_set_period(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 counter_mask =3D hwc->idx ? pmu->event_cntr_mask : pmu->cycle_cntr_=
mask;
> +	u64 period;
> +
> +	/*
> +	 * Limit the maximum period to prevent the counter value
> +	 * from overtaking the one we are about to program.
> +	 * In effect we are reducing max_period to account for
> +	 * interrupt latency (and we are being very conservative).
> +	 */
> +	period =3D counter_mask >> 1;
> +	riscv_iommu_pmu_set_counter(pmu, hwc->idx, period);
> +	local64_set(&hwc->prev_count, period);

[Severity: Medium]
If riscv_iommu_pmu_stop()'s update executes concurrently with this, can it
compute a spurious massive delta?

This appears to be a vulnerability window for a race condition. If an overf=
low
interrupt occurs just before or during riscv_iommu_pmu_stop(), the IRQ hand=
ler
running on another CPU could execute this concurrently with the unprotected
riscv_iommu_pmu_update() in riscv_iommu_pmu_stop(). This would cause an ABA
data corruption on prev_count, breaking the counter statistics for userspace
applications.

> +}
[ ... ]
> +static void riscv_iommu_pmu_stop(struct perf_event *event, int flags)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	unsigned long irqflags;
> +	int idx =3D hwc->idx;
> +
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return;
> +
> +	raw_spin_lock_irqsave(&pmu->lock, irqflags);
> +	riscv_iommu_pmu_disable_counter(pmu, idx);
> +	raw_spin_unlock_irqrestore(&pmu->lock, irqflags);
> +
> +	if ((flags & PERF_EF_UPDATE) && !(hwc->state & PERF_HES_UPTODATE))
> +		riscv_iommu_pmu_update(event);
> +
> +	hwc->state |=3D PERF_HES_STOPPED | PERF_HES_UPTODATE;

[Severity: Medium]
Could this state update cause a race condition with the PMU interrupt handl=
er?

The hwc->state is updated outside the pmu->lock critical section in
riscv_iommu_pmu_stop(). This creates a vulnerability window where a concurr=
ent
ISR running on another CPU still sees the event as active.

> +}
[ ... ]
> +static void riscv_iommu_pmu_read(struct perf_event *event)
> +{
> +	riscv_iommu_pmu_update(event);

[Severity: Medium]
Is it possible to expose the local64_cmpxchg() loop in riscv_iommu_pmu_upda=
te()
to a cross-CPU ABA race condition here?

Because riscv_iommu_pmu_read() does not hold pmu->lock, and because of
IRQCHIP_MOVE_DEFERRED, the PMU interrupt can fire on a different CPU than t=
he
one handling the perf read.

If the IRQ handler processes an overflow concurrently, it resets hwc->prev_=
count
to the period. The concurrent cmpxchg in riscv_iommu_pmu_read() could see t=
he
period as unchanged and succeed, double-counting the overflow. The subseque=
nt
read would then see a massive spurious delta, resulting in incorrect statis=
tics
for perf userspace tools.

> +}
[ ... ]
> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
[ ... ]
> +			/*
> +			 * pmu->events[idx] only means the counter is allocated,
> +			 * not that it is counting. A counter which has not been
> +			 * started has no valid prev_count to compute a delta
> +			 * against, and one which has been stopped must not be
> +			 * reprogrammed here. The overflow bit still has to be
> +			 * cleared below in either case, including when the event
> +			 * was already removed by riscv_iommu_pmu_del(),
> +			 * otherwise the interrupt would stay pending forever.
> +			 */
> +			if (event && !(event->hw.state & PERF_HES_STOPPED)) {
> +				riscv_iommu_pmu_update(event);
> +				riscv_iommu_pmu_set_period(event);
> +			}

[Severity: Medium]
Since PERF_HES_STOPPED is set outside the lock in riscv_iommu_pmu_stop(),
can the ISR incorrectly enter this block and mutate the hardware counter?

The ISR relies on PERF_HES_STOPPED to avoid touching a counter being stoppe=
d.
Because the flag is set too late in riscv_iommu_pmu_stop(), it might enter
this block and mutate the hardware counter while it is actively being stopp=
ed.

> +
> +			riscv_iommu_pmu_clear_ovf(pmu, idx);
> +		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914035723.2922=
057-1-zong.li@sifive.com?part=3D1
