Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFFD3749FD;
	Wed,  5 Aug 2026 16:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785946572; cv=none; b=KLyP94UwXj8lBd2cmjpfxhRXwta5phoSeN6l1A6D3jVdpDoDz8FdE++07rPBVZsNXkx4hPFK+W54SzOvZOJE6YXNKPb4wvkOm43cgzoxoKK0/mxNk9X+rzqKTbNqxbSXZVAHcsLTQDbMBipiFQf3Fm7GQOnn1/tBqDhnG4wKouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785946572; c=relaxed/simple;
	bh=B3ZkGkcnh0RBVH8W0vJhVkwutWxrIwNlXWOtt+I0CvI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Lo2kSCdXgzQ0qbqHvXuRUprHbSpOgi+09sLcVQAqHTAbRbhFQLJZD6yJ2dVjk9K2EqYMYwQ1klxTzQFKnFyEBPXtsp4D+QeWeKwB/MiZPb8xc33s1oeUL0/DAS9oiCutZ5UgZ6kldAXP8c9YkXJ7E9qpMl3VBldUDsMwGXSJwno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bI4ZQVc7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bI4ZQVc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C471F000E9;
	Wed,  5 Aug 2026 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785946559;
	bh=ABWY/GBV2SU0e8/xE/fPWBCW40OOqlHexv6AO9TWJ2Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bI4ZQVc71Z3T0uYIUO9M7fI7uEzd0jL/lbF6HFfjm1+tZu7canPrZo2u4QGeCp3hd
	 ATy6onDXKzEK3ZIcgxUUvysRxj6uxSDZIgXuJxdB7n1snzPCn1dcjFkpsdb51Cw3yD
	 rDnhZa5wvhgWY+YeZupf9pOuL0qmTlnZ/4q2bobjTIelnYZZTosDssmjj5Pnn3RJ/5
	 pskMU9+sRlVVkGDSHMcVxKG3xNfPsOxbjyPzfL4TJnhd2FMjWRw+9Wq2Mvomep9AV5
	 I3cQxX6I55hdAczbBR1fW9tJR3Xe2s3oR/rBsnhXzW0PcbZc9BS+dpPbRtm6sAY+Wc
	 I/yA6pmsFZoSQ==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 08/11] perf/cxl: Unfreeze counters after
 handling an overflow interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dave Jiang" <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <20260805155911.1304807-9-dave.jiang@intel.com>
References: <20260805155911.1304807-1-dave.jiang@intel.com>
 <20260805155911.1304807-9-dave.jiang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 16:15:57 +0000
Message-Id: <20260805161558.D1C471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] A cross-CPU TOCTOU race condition during CPU migration can leave t=
he PMU permanently unfrozen when it is supposed to be disabled, leading to =
a specification violation where a running counter is written to.

Pre-existing issues:
- [High] `__cxl_pmu_read` is vulnerable to a cross-CPU data race on `hwc->p=
rev_count` during CPU migration because it relies on `local64_cmpxchg`.
- [High] Pending overflow interrupts can be incorrectly attributed to newly=
 scheduled events on the same counter, corrupting their counts by adding a =
spurious full period.
- [High] Writing 1s to RsvdZ (Reserved, must be zero) bits in the Freeze re=
gister violates the CXL specification and risks fatal hardware errors.
- [High] Concurrent PMU reads and overflows cause massive double-counting o=
r loss of events due to stateless overflow handling.
--

--- Patch [8]: [RESEND PATCH v4 08/11] perf/cxl: Unfreeze counters after ha=
ndling an overflow interrupt ---
commit 77054eb72889cfc4fca68e72d632bb6f5cfbe02d
Author: Dave Jiang <dave.jiang@intel.com>

perf/cxl: Unfreeze counters after handling an overflow interrupt

The counters run with Freeze on Overflow set, so one overflow freezes every
counter in the block. cxl_pmu_irq() reads the overflowed counters and clears
the overflow status but never unfreezes, so everything stays frozen until t=
he
next pmu_enable(). This patch unfreezes after clearing the status, unless t=
he
PMU has been disabled in the meantime.

Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stgolab=
s.net?part=3D1

> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 448e1da3d59f9..a081fcba69917 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c

[ ... ]

> @@ -604,6 +607,7 @@ static void cxl_pmu_disable(struct pmu *pmu)
>  	struct cxl_pmu_info *info =3D pmu_to_cxl_pmu_info(pmu);
>  	void __iomem *base =3D info->base;
> =20
> +	WRITE_ONCE(info->enabled, false);
>  	/*
>  	 * Whilst bits above number of counters are RsvdZ
>  	 * they are unlikely to be repurposed given
>  	 * number of counters is allowed to be 64 leaving
>  	 * no reserved bits.  Hence this is only slightly
>  	 * naughty.
>  	 */
>  	writeq(GENMASK_ULL(63, 0), base + CXL_PMU_FREEZE_REG);

[Severity: High]
This isn't a bug introduced by this patch, but does writing a full 64-bit m=
ask
to the freeze register risk fatal hardware errors on strict CXL implementat=
ions?

In cxl_pmu_disable(), the driver writes GENMASK_ULL(63, 0) to
CXL_PMU_FREEZE_REG to freeze all counters.

According to the CXL 3.0 specification, bits above the implemented number
of counters (info->num_counters) are RsvdZ, and software is strictly
required to write 0 to these fields.

Writing 1s to reserved fields could cause AER faults or Poisoned transactio=
ns.

[ ... ]

> @@ -802,6 +806,21 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> =20
>  	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
> =20
> +	/*
> +	 * An overflow freezes every counter in the CPMU, so unfreeze once the
> +	 * overflowed ones have been read and their status cleared. Otherwise
> +	 * they stay frozen until the next pmu_enable() and events are lost.
> +	 *
> +	 * Not while the PMU is disabled, so as not to undo an intentional free=
ze.
> +	 * The check is advisory, not exclusive: pmu_disable() normally runs on
> +	 * info->on_cpu with interrupts off, where the pinned handler cannot
> +	 * preempt it. In the one window where it does not - the migration in
> +	 * cxl_pmu_offline_cpu() - the counters are legitimately running again,
> +	 * so unfreezing is correct there anyway.
> +	 */
> +	if (READ_ONCE(info->enabled))

[Severity: High]
Could this advisory check on info->enabled cause a cross-CPU race condition
during CPU migration?

During CPU hotplug migration, perf_pmu_migrate_context() in
cxl_pmu_offline_cpu() moves events to the target CPU, but the IRQ
affinity is not updated until afterwards.

If the IRQ fires on the old CPU, it can read a stale true for info->enabled
concurrently with the target CPU executing cxl_pmu_disable(), which sets
it to false and freezes the PMU.

The old CPU would then write 0 to unfreeze the PMU here. The target CPU,
expecting the PMU to be frozen, proceeds to cxl_pmu_event_start(), enabling
the counter via CXL_PMU_COUNTER_CFG_ENABLE and writing 0 to
CXL_PMU_COUNTER_REG.

Because the PMU was incorrectly unfrozen, the counter starts immediately,
leading to a write to a running counter, which violates the CXL 3.0 spec.

> +		writeq(0, base + CXL_PMU_FREEZE_REG);
> +
>  	return IRQ_HANDLED;
>  }

I also noticed a few other pre-existing issues in this file while reviewing.

[Severity: High]
This isn't a bug introduced by this patch, but is the use of local64_cmpxchg
in __cxl_pmu_read() safe across multiple CPUs?

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
    do {
        prev_cnt =3D local64_read(&hwc->prev_count);
        new_cnt =3D cxl_pmu_read_counter(event);
    } while (local64_cmpxchg(&hwc->prev_count, prev_cnt, new_cnt) !=3D prev=
_cnt);
    ...
}

During the CPU hotplug migration window in cxl_pmu_offline_cpu(), events
are migrated to the target CPU before IRQ affinity is updated via
irq_set_affinity().

If an overflow IRQ fires in this window, it runs on the old CPU while the
target CPU can concurrently execute cxl_pmu_read().

Since local64_t only guarantees atomicity for local CPU accesses, both CPUs
iterating over the same event and concurrently executing local64_cmpxchg()
could cause a data race and silent counter corruption.

[Severity: High]
This isn't a bug introduced by this patch, but can pending overflow interru=
pts
be incorrectly attributed to newly scheduled events?

When a counter overflows, the hardware asserts an interrupt and sets the
corresponding bit in CXL_PMU_OVERFLOW_REG.

If the current event is deleted before the IRQ is serviced, neither
cxl_pmu_event_del() nor cxl_pmu_event_start() clears the overflow bit:

drivers/perf/cxl_pmu.c:cxl_pmu_event_start() {
    ...
    local64_set(&hwc->prev_count, 0);
    writeq(0, base + CXL_PMU_COUNTER_REG(hwc->idx));
    ...
}

When cxl_pmu_event_add() maps a new event to the same counter index, and
the pending IRQ is serviced, cxl_pmu_irq() calls __cxl_pmu_read(event, true=
).

For the new event, both new_cnt and prev_cnt are near 0, meaning the
following check is satisfied:

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
    if (overflow && new_cnt >=3D prev_cnt)
        delta +=3D mask + 1;
    ...
}

Could this cause the driver to falsely believe a wrap occurred and corrupt
the count by adding a spurious full period?

[Severity: High]
This isn't a bug introduced by this patch, but does the stateless overflow
handling in __cxl_pmu_read() cause double-counting or lost events?

drivers/perf/cxl_pmu.c:__cxl_pmu_read() {
    ...
    delta =3D (new_cnt - prev_cnt) & mask;
    if (overflow && new_cnt >=3D prev_cnt)
        delta +=3D mask + 1;
    ...
}

If a polled read (overflow =3D false) occurs after the counter wraps and
freezes, but before the IRQ handler runs, it adds the correct delta and
updates prev_cnt.

When the IRQ handler subsequently runs, new_cnt and prev_cnt will be equal,
satisfying new_cnt >=3D prev_cnt.

Wouldn't the IRQ handler then erroneously add a full period on top of the
already correct count? Conversely, if the event is deleted before the IRQ
handler runs, could the full period be permanently lost?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805155911.1304=
807-1-dave.jiang@intel.com?part=3D8
