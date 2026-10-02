Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B89480321
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932475; cv=none; b=QoIB4Xw4ieaGXZvk3BMj5vPFlG0wiWDb15X5LMvzsZroGrkZ43bSarApEN6fX4yr3f+laN6jJWtqvWqkV9GwM4WAV/+yf+nhBdwue/VNdtqzz4s60MZmc6icFY4COHe4/TYVrgIP5I/LkpoW2HAj56ChguaDQQtM35jHh/SMuuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932475; c=relaxed/simple;
	bh=c0nuETVdg3ui9KQq8cwDKlL3Km1rP9nQhibwyD7OJI8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iiwu+RJWLgdoo/WLa/6Qp3iCVgElSEcDV1jL8zUn71ckROIbqUVCLPG/GjGYiLFM0qnBoZVwt1+dhohcZRYE2xi2kPGNjKg0VIq2dhjTEMx2bJ4ABAnhf8YjPWxbmFxsgzpRef2xZzJky8TvIppdqyCYHLXYwIaXDLp0pGoA14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIf8KvsM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIf8KvsM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A32D1F000FF;
	Fri,  2 Oct 2026 09:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932474;
	bh=kdI3hVZeeR1u+gXqQmMiC4tMbxToqiwI96evEgg/0U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TIf8KvsMnaaA89zOtiOCzOqbPe/C+R1Q4tYpht/WTFkJBcuH0Y3pxHPa0vSDqNS/Z
	 3NJ5EWp6JNKfTh6iob8X7wqxxPX+qlZ7fsRvuWU4Gu6Yp85Ag6p2STshsf1RGR0wkd
	 DRwQ9ff8ndeap0abyONLvCMnvG3PCMiKZazwPGuqJRwbG6qdVMY8WvCAPo3DYwii++
	 gkZz2dpvQy1MeDZn2zSQxWf5kxr2x4hVX3JmC8TC/EfRR0/UIrNx/QqbNAlMQe7pWi
	 SOZwi4acp+gb5BM3VVTGNcRqR4RX66UWTpOm6nep92w6yFk/dmAoelrpI4yN6s/fSO
	 BZEoFQTpWdANg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002063315.1535817-2-zong.li@sifive.com>
References: <20261002063315.1535817-1-zong.li@sifive.com>
 <20261002063315.1535817-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:33 +0000
Message-Id: <20261002091434.1A32D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] perf/riscv: Torn read race between PMU read and IRQ handler corrup=
ts event count
- [Medium] perf/riscv: UAF in CPU hotplug callback during PMU probe error p=
ath
--

commit 472769839e43688676e3929143858e4d52f609c7
Author: Zong Li <zong.li@sifive.com>

    drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This commit introduces a new driver for the RISC-V IOMMU PMU, created as an
auxiliary device by the parent RISC-V IOMMU driver. The PMU provides event
and cycle counters with filtering support to collect performance metrics.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> index 0000000000000..25f217ac97e7f
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c

[ ... ]

> +static void riscv_iommu_pmu_set_period(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u64 counter_mask =3D pmu->cntr_mask[hwc->idx];
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
> +}

[ ... ]

> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx =3D hwc->idx;
> +	u64 counter_mask =3D pmu->cntr_mask[idx];
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
> +}

[Severity: High]
Does this code allow a lockless read to calculate a torn update delta?

The commit message notes that IRQCHIP_MOVE_DEFERRED can cause the PMU inter=
rupt
to be routed to a different CPU than the event is bound to.

If riscv_iommu_pmu_read() is called locklessly on CPU B, it can race with
riscv_iommu_pmu_irq_handler() running on CPU A. In riscv_iommu_pmu_set_peri=
od(),
the hardware counter is written before the shadow copy prev_count.

If CPU B reads the old near-overflow prev_count, and then CPU A resets the
hardware counter, CPU B could read the new reset hardware counter. Because
CPU A hasn't reset the software prev_count yet, CPU B's loop validation
(prev =3D=3D local64_read()) would succeed, producing a massive wrap-around=
 spike
in the event count.

[ ... ]

> +static int riscv_iommu_pmu_probe(struct auxiliary_device *auxdev,
> +				 const struct auxiliary_device_id *id)
> +{

[ ... ]

> +	ret =3D devm_add_action_or_reset(&auxdev->dev,
> +				       riscv_iommu_pmu_do_unregister,
> +				       iommu_pmu);
> +	if (ret) {
> +		/*
> +		 * The action above has already run, so the pmu is unregistered
> +		 * and pmu->cpu_pmu_context is freed. Drop the cpuhp instance
> +		 * with _nocalls() so the teardown callback cannot reach it, and
> +		 * so it does not outlive iommu_pmu on the global cpuhp list.
> +		 */
> +		cpuhp_state_remove_instance_nocalls(cpuhp_state, &iommu_pmu->node);
> +		return ret;
> +	}

[Severity: Medium]
Can this sequence result in a use-after-free during a concurrent CPU offline
event?

If devm_add_action_or_reset() fails to allocate a devres node, it will
immediately execute riscv_iommu_pmu_do_unregister(), which calls
perf_pmu_unregister() and frees the PMU per-CPU contexts.

Because the CPU hotplug instance is not removed before the teardown action
executes, a concurrent CPU hotplug callback (riscv_iommu_pmu_offline_cpu)
might be invoked in this window. Could this cause perf_pmu_migrate_context()
to be called on the already-freed contexts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002063315.1535=
817-1-zong.li@sifive.com?part=3D1
