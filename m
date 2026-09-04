Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E50145A2BD
	for <linux-perf-users@vger.kernel.org>; Fri,  4 Sep 2026 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514508; cv=none; b=puR8FtlbTc0c7mV/0mUFk//mQVqZnotvP0+4I8CwVmTznCHl30jzUSnHiYq+/CH8NG/voP3houoeGpS2o0XDUbtOYY1kJjXQ4dZiiBbFC0Ek/Rk1kBO5bIjOw0fpKiEUGXj90u1VLIzQjbvAIThLVuaTdq0tee+ra88ImIZQ52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514508; c=relaxed/simple;
	bh=0NrQqsJof9o0pf9lWtMm2VjP4xIBSPZst9ZSMxCFYIk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TIAHA5jyr7QnI3peJSRRRhbi8QD7oZ761NWBK39CTqC2W3hMjriOmlS2P9jJwv8gXOO5UdOf1gj3IJQX7rNr7StUJn0N/UKwLTTXc1iHTzjl6HX8y4m96EyJZenyiR0uZLPmCr2XPAgG4gAnxNpUIYmXQudfrL2+WYIs+bUuBVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmPqx+CZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmPqx+CZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4D91F00A3D;
	Fri,  4 Sep 2026 09:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788514506;
	bh=nTUt68fKER5SoIC38AAJF5IDhr2MQF8of6nWX9MbYxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mmPqx+CZcURJNtQ5AOksU2IvyiYJrk8FcaPTZNnFx6CBlhB3zd+nL3EfxTKhXCPuj
	 o3fHtqr7bt96WbknKtUachshxJ/Z+/i3ilvJP9rXXx+P/dj9m/1yQpAu5Pwdr7zJcN
	 cARgjnKj5i69YngM36eBQBuXYn+02Eier/Thp0bgbz8vGxXVCysITFrOlPqyjdhES2
	 CapPogk9LdPbwztkt2vQTU0Kf0TLx8dFVY/8Zdg4VMp1feUyacqHVpwFdBYr1YpN7t
	 UZ1HcGQQ3Q+N5cS8P74GfvXzANg95DBfLEnQSjqM4gvSCVtQPbxrk4+Q77LYL10+53
	 7rpeoaXp9WNfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260904092136.113321-2-zong.li@sifive.com>
References: <20260904092136.113321-1-zong.li@sifive.com>
 <20260904092136.113321-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 09:35:05 +0000
Message-Id: <20260904093506.2D4D91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PMU interrupt handler returns IRQ_HANDLED on CPU mismatch without =
clearing the device-level interrupt pending bit, leading to permanently los=
t MSIs or IRQ storms.
- [Medium] event_init() accepts event groups with multiple cycle events, wh=
ich can never be scheduled.
--

commit 20eb6219411a8b8c6c0492ff1ba61f7e29cbb9b0
Author: Zong Li <zong.li@sifive.com>

    drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This patch adds a new auxiliary device driver to support the RISC-V IOMMU
Performance Monitor Unit (PMU). The driver manages PMU event counters,
handles counter detection at runtime, and exposes standard perf interfaces
for counting events like translated requests, TLB misses, and clock cycles.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..0c30e26c1f0ce
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
[ ... ]
> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
[ ... ]
> +	/*
> +	 * Account for this event itself first. It has to be done before the
> +	 * check below, otherwise an event which is on its own would never be
> +	 * matched against the number of counters the hardware implements.
> +	 */
> +	if (!is_cycle_event(event->attr.config))
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +
> +	if (event->group_leader =3D=3D event)
> +		return 0;
> +
> +	if (!is_software_event(event->group_leader)) {
> +		if (event->group_leader->pmu !=3D event->pmu)
> +			return -EINVAL;
> +
> +		if (!is_cycle_event(event->group_leader->attr.config))
> +			if (++counters > total_event_counters)
> +				return -EINVAL;
> +	}
> +
> +	for_each_sibling_event(sibling, event->group_leader) {
> +		if (is_software_event(sibling))
> +			continue;
> +
> +		if (sibling->pmu !=3D event->pmu)
> +			return -EINVAL;
> +
> +		if (is_cycle_event(sibling->attr.config))
> +			continue;

[Severity: Medium]
Does this logic allow event groups to be created with multiple cycle events?

Because ++counters is explicitly skipped for cycle events, we don't verify =
if
more than one cycle event is present in the group. Since the hardware only
has one cycle counter (index 0), a group with two cycle events will continu=
ally
fail with -EAGAIN in riscv_iommu_pmu_add() and can never be successfully
scheduled.=20

Should we track the total number of cycle events in the group to reject
unsatisfiable groups at creation time here in riscv_iommu_pmu_event_init()?

> +
> +		if (++counters > total_event_counters)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> +	DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> +	u32 ovf, idx, inhibit;
> +
> +	/*
> +	 * PCI MSI/MSI-X on IMSIC will set IRQCHIP_MOVE_DEFERRED, so
> +	 * irq_set_affinity() reports success while only recording the request,
> +	 * and the move is applied in interrupt context upon the next device
> +	 * interrupt. Until then the interrupt is still routed to the CPU IMSIC
> +	 * picked initially, so the first overflow interrupt can run concurrent=
ly
> +	 * with the perf callbacks on the CPU the events are bound to
> +	 *
> +	 * A mismatch means the irqchip still had an affinity change pending for
> +	 * this line. However, handle_edge_irq() has just completed it through
> +	 * ->irq_ack(), so leave the overflow and PMIP bits alone and let the
> +	 * interrupt be redelivered on the right CPU.
> +	 *
> +	 * IRQ_HANDLED rather than IRQ_NONE: the latter feeds the spurious
> +	 * detector in note_interrupt(), which disables the whole line once
> +	 * enough interrupts go unhandled, and this line may be shared with the
> +	 * iommu command and fault queues.
> +	 */
> +	if (smp_processor_id() !=3D READ_ONCE(pmu->on_cpu))
> +		return IRQ_HANDLED;

[Severity: High]
Will returning IRQ_HANDLED here without clearing the PMIP bit in the device
leave the hardware interrupt permanently pending?

If the PMU interrupt fires while smp_processor_id() !=3D pmu->on_cpu (which
could happen during an IRQ affinity change or from a shared device), this
early return bypasses the device-level interrupt clearing.=20

For edge-triggered MSIs, the device might never send another interrupt beca=
use
the pending bit remains asserted, permanently killing the PMU. If
level-triggered, it could cause an infinite IRQ storm on the wrong CPU.

Should we check and clear the PMIP bit even when bouncing the interrupt?

> +
> +	/* Check whether this interrupt is for PMU */
> +	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR=
_PMIP))
> +		return IRQ_NONE;
> +
> +	/* Process PMU IRQ */
> +	inhibit =3D riscv_iommu_pmu_stop_all(pmu);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904092136.1133=
21-1-zong.li@sifive.com?part=3D1
