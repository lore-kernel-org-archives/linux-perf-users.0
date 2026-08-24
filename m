Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30107363C6F
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539128; cv=none; b=KFNra3TKKXa6tzH/Y3/Ckn/x0yLNuF9iyz960vYGIzDuqkJ/vkxjknHaL7whKp5bW7/xZ0JxgkOsQEWU4jDoZrm1m/OHVeaf3Mnj5cCju+Fj/sdWW5qazBMtbF6Qkk3pnYwjBrWPb7uVt7tm3X3WfZHxJg7T0fW6SBSpI3al8M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539128; c=relaxed/simple;
	bh=fLd3rCON2p2MoFfOWquFhUtrdc6Mx7ITJE45k7lZjCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VBiKXRAjejPphoziKH3yh8B4bC0xTw8fYv/kC0W/J/7RxwiS1nuFbFENbhPTW2lXzk5msUf8ruNfH3wTmomnp17di1qPkEYrE48tPUwJ/i+wbvdwWAgRq0APmUCFuRPOUoFPSmkgrgqTR8aPaJUkTZh6Xqf1wKexyMTLNMIPZE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fk7UMAzq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fk7UMAzq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9511F1F000E9;
	Mon, 24 Aug 2026 02:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787539124;
	bh=JGqlWAFI4nABDnwGI5rvJG8GlO8apa8EuweLxeHTiX8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fk7UMAzqAWnOQamDrGxnGZFiZGBPblMQQZVxb1FiHVU3WLvZok4eHh44n8E+7Dimc
	 CsIHkN+DdMPsT2z6Xo12+HIUC6Rb3FyoJLrJfrM3+mrqYAPTaUWHSS8O3aRFu+f6t2
	 cIfbLNEZp4+OfnxnjUSlPLlMctJr4p2GDdDYYTLVd4jULB7Ja/wmo0kJe0S22Ptc+w
	 IwSUpdsUJq1N3rH70IRyN3gFVxxtH/tajSKzdy8iA22n3xBJnVsDPOCx528SuUx+OM
	 7vfvGPXwCOk1l6idzy8cR6rYeyvlHmRaOU3YASTAKNQRoLk5b8W1dSVvPqCW6pol3l
	 EPncVAo6jQbvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/2] drivers/perf: riscv-iommu: add risc-v iommu pmu
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zong Li" <zong.li@sifive.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260824022034.3916570-2-zong.li@sifive.com>
References: <20260824022034.3916570-1-zong.li@sifive.com>
 <20260824022034.3916570-2-zong.li@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 02:38:44 +0000
Message-Id: <20260824023844.9511F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Missing spinlock to protect shared PMU state and hardware register=
s from concurrent IRQ handler execution.
- [Medium] Cycle event filter configurations are silently ignored.
- [Medium] Missing validation for `num_counters =3D=3D 0` leads to undefine=
d behavior in GENMASK_ULL.
- [Low] Type confusion in `is_cycle_event()` parameters leads to double-ext=
raction of event IDs.
--

--- Patch [1]: [PATCH v6 1/2] drivers/perf: riscv-iommu: add risc-v iommu p=
mu driver ---
commit c7845a25e4e2953e42707a05131529dc059de52f
Author: Zong Li <zong.li@sifive.com>

drivers/perf: riscv-iommu: add risc-v iommu pmu driver

This patch adds a new auxiliary device driver for the RISC-V IOMMU PMU.
It enables the perf subsystem to read and configure hardware-implemented
performance monitoring and cycle counters.

Link: https://lore.kernel.org/linux-riscv/20260618143634.7f3dd6c5@pumpkin/

> diff --git a/drivers/perf/riscv_iommu_pmu.c b/drivers/perf/riscv_iommu_pm=
u.c
> new file mode 100644
> index 0000000000000..f81e5bb323364
> --- /dev/null
> +++ b/drivers/perf/riscv_iommu_pmu.c
> @@ -0,0 +1,813 @@

[ ... ]

> +static bool is_cycle_event(u64 event)
> +{
> +	return FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENTID, event) =3D=3D
> +	       RISCV_IOMMU_HPMEVENT_CYCLE;
> +}
> +
> +static void riscv_iommu_pmu_set_event(struct riscv_iommu_pmu *pmu, u32 i=
dx,
> +				      u64 value)
> +{
> +	/* There is no associtated IOHPMEVT0 for IOHPMCYCLES */
> +	if (is_cycle_event(value))
> +		return;

[Severity: Medium]
Will this silently ignore filter configurations requested for the cycle
event?

When userspace invokes perf stat with filter configurations applied to
the cycle event, riscv_iommu_pmu_event_init() accepts them, but this code
completely ignores the configuration since the hardware does not support
filtering for cycle counters.

Should the driver reject unsupported filter configurations with -EINVAL=20
instead of silently returning here?

> +
> +	/* Event counter start from idx 1 */
> +	riscv_iommu_pmu_writeq(FIELD_GET(RISCV_IOMMU_IOHPMEVT_EVENT, value),
> +			       pmu->reg + RISCV_IOMMU_REG_IOHPMEVT(idx - 1));
> +}
> +
> +static void riscv_iommu_pmu_enable_counter(struct riscv_iommu_pmu *pmu, =
u32 idx)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 value =3D readl(addr);
> +
> +	writel(value & ~BIT(idx), addr);

[Severity: High]
Can this lockless read-modify-write on IOCOUNTINH race with the IRQ handler
updating the same register in riscv_iommu_pmu_stop_all()?

The driver ignores failures from irq_set_affinity() with just a dev_dbg log=
,=20
so the IRQ handler might run on a different CPU, allowing=20
riscv_iommu_pmu_stop_all() to preempt or run concurrently with these state=
=20
updates.

Would it be safer to add a spinlock to protect shared PMU state and hardware
registers?

> +}

[ ... ]

> +static u32 riscv_iommu_pmu_stop_all(struct riscv_iommu_pmu *pmu)
> +{
> +	void __iomem *addr =3D pmu->reg + RISCV_IOMMU_REG_IOCOUNTINH;
> +	u32 inhibit =3D readl(addr);
> +
> +	writel(GENMASK_ULL(pmu->num_counters - 1, 0), addr);

[Severity: Medium]
Is there a risk of undefined behavior if this evaluates to GENMASK_ULL(-1, =
0)?

If the hardware implements the HPM capability but reports 0 counters,
num_counters is initialized to 0 in riscv_iommu_pmu_probe() without
validation.

If an interrupt fires, num_counters - 1 becomes -1, violating the macro's
internal upper bound checks.

> +
> +	return inhibit;
> +}

[ ... ]

> +static int riscv_iommu_pmu_event_init(struct perf_event *event)
> +{
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct perf_event *sibling;
> +	int total_event_counters =3D pmu->num_counters - 1;
> +	int counters =3D 0;

[ ... ]

> +	if (!is_cycle_event(get_event(event)))

[Severity: Low]
Could this result in double-extraction of the event ID?

is_cycle_event() applies FIELD_GET to extract the event ID from a raw confi=
g,
but get_event() also applies FIELD_GET. While this might accidentally work =
if
the bitmask starts at bit 0, it could break if the mask layout changes.

> +		if (++counters > total_event_counters)
> +			return -EINVAL;

[ ... ]

> +static void riscv_iommu_pmu_update(struct perf_event *event)
> +{
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	struct riscv_iommu_pmu *pmu =3D to_riscv_iommu_pmu(event->pmu);
> +	u64 delta, prev, now;
> +	u32 idx =3D hwc->idx;
> +	u64 counter_mask =3D idx ? pmu->event_cntr_mask : pmu->cycle_cntr_mask;
> +
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		now =3D riscv_iommu_pmu_get_counter(pmu, idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, now) !=3D prev);

[Severity: High]
How is this data protected from concurrent accesses by the IRQ handler?

local64_cmpxchg() is not multi-CPU atomic. If irq_set_affinity() fails,
riscv_iommu_pmu_irq_handler() could execute concurrently on another CPU,
racing with this update.

> +
> +	delta =3D (now - prev) & counter_mask;
> +	local64_add(delta, &event->count);
> +}

[ ... ]

> +static irqreturn_t riscv_iommu_pmu_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_pmu *pmu =3D (struct riscv_iommu_pmu *)dev_id;
> +	DECLARE_BITMAP(ovf_bitmap, BITS_PER_TYPE(u64));
> +	u32 ovf, idx, inhibit;
> +
> +	/* Check whether this interrupt is for PMU */
> +	if (!(readl_relaxed(pmu->reg + RISCV_IOMMU_REG_IPSR) & RISCV_IOMMU_IPSR=
_PMIP))
> +		return IRQ_NONE;
> +
> +	/* Process PMU IRQ */
> +	inhibit =3D riscv_iommu_pmu_stop_all(pmu);
> +
> +	ovf =3D readl(pmu->reg + RISCV_IOMMU_REG_IOCOUNTOVF);
> +	if (ovf) {
> +		bitmap_from_u64(ovf_bitmap, ovf);
> +		for_each_set_bit(idx, ovf_bitmap, pmu->num_counters) {
> +			struct perf_event *event =3D pmu->events[idx];

[Severity: High]
Are accesses to the pmu->events array synchronized against event removal?

If the IRQ handler runs concurrently with riscv_iommu_pmu_del() because
irq_set_affinity() failed to restrict it to a single CPU, this could result
in a use-after-free of the event structures.

> +
> +			/*

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824022034.3916=
570-1-zong.li@sifive.com?part=3D1
