Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795112265;
	b=XGA2Kcr41LPnc98HKsiqnDin4RmyrRIG+c9k43llUrokVjOsY7agOhXzcn580+hQDgza
	 lRuZ/InqXmlhyzlXuCIEPR7gA0rmSzUPlOMDEoTaOP3Ift+GyQyGkGgxyAxA64jiM5t+R
	 s0oPqn+vU5UgIeLoNX6QzZD10TKkFNAwz9uS11oFx2zoSFPg7wZWVvm3rRMfX7FSlnN7L
	 WtgyYAyhfe5cTOvaaFZEbRn1RfhBHroC22dWuecN/1BzN+ZjEHHLKFpLDDUuKNVwjbnm9
	 WmsBR9o64JXrRN6TtG1lOa2Frgy3awwRSHKb2pz7nasMeM4Aeon/1S5Y6KqFZIHKkdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795112265;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e+AX9yzcvXvTArcpWr8bJrqXCoCx5CQaHwc1HEsiISk=;
	b=PRKUWbdiEB57U99fu2Sj8m3Gu5BQrfmSOL4aFBhAES8RxjG2AEtiYwGyRqW946lCLmvw
	 6+DvZtagyvwx0/iyQwqwdKWtZN95pg+XJqTeHbmo4KCPKgvRS8h0K+6TJjK9/sj4DDB1E
	 42GTcGWIYNYdqrrwFOeytsteXSxWtmdrz+PRturixQyuUa9l7ypF42ri5KiD2JGThjMJr
	 6BlvBPKlTSmqOkuCcH7mm8KrPWyAgzuK5VUQzPS8ryqYFaHD73CuwATam4bm5zWXDf9TB
	 lmoKmEtpGcKbTHhJHoUYhj9+kH5woctOUY7y50BzU39/ZlXx7jIbzytCOpAj3KAR37Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPQcy0SO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D39606A33C;
	Thu, 19 Nov 2026 18:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPQcy0SO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E351F000C7;
	Thu, 19 Nov 2026 18:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795112265;
	bh=e+AX9yzcvXvTArcpWr8bJrqXCoCx5CQaHwc1HEsiISk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OPQcy0SORt3QYZ+79bAYyITbCrhdx/hDnYZzAPsVMvWNvXZYFTgb+HdySPjUzkMgZ
	 ZfyEJf238yzUGRqcQ5tokhUlQCxXsm1m7X+uOmPumjCpRJY65OXaDwxaBs3cWC/AhX
	 4tWbh/zAGHyuMkv1cyYL+Xbl1BvjYLIQJ6h5EiqGOiYq2ubgHgKgvDE0i8FshWY0Pd
	 cEulgOzEERD2BcyTsP1L+irnvAkNTR7542TLU91+5QDQ7InvFyDuhnL9AKKIU5stxe
	 7G67F2DRGeNqvLx7ye5KZcj0l1PHwNNDZR+bPu6rTRHLYM2xKVZoFaheqQc1Tu+D7N
	 x7iVtXFuE81PQ==
Message-ID: <sashiko-outbox-223763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/7] perf: add MIPS Coherence Manager 3 (CM3) PMU
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261119-i6500-cm3-pmu-v3-5-c86410934b51@mobileye.com>
References: <20261119-i6500-cm3-pmu-v3-0-c86410934b51@mobileye.com>
 <20261119-i6500-cm3-pmu-v3-5-c86410934b51@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 18:17:44 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf: mips_cm3_pmu: counter overflow double-counting in
  cm3_pmu_update()
- [Low] perf: mips_cm3_pmu: WARN_ON() in cm3_pmu_online_cpu() when
  !CONFIG_SMP
--

commit 51299d17e3e40c4c71d192990c0a48a22c2de2cb
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

perf: add MIPS Coherence Manager 3 (CM3) PMU driver

This commit adds an uncore PMU driver and documentation for the MIPS
Coherence Manager 3 (CM3) performance counters.

> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 245e7bb763b99..2dbed2fc7b030 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -75,6 +75,18 @@ config ARM_XSCALE_PMU
>  	depends on ARM_PMU && CPU_XSCALE
>  	def_bool y
> =20
> +config MIPS_CM3_PMU
> +	tristate "MIPS Coherence Manager 3 (CM3) PMU"
> +	depends on MIPS_CM

[Severity: Low]
Should MIPS_CM3_PMU depend on MIPS_CPS (or SMP) rather than just MIPS_CM?

MIPS_GIC selects MIPS_CM even when CONFIG_SMP=3Dn and CONFIG_MIPS_CPS=3Dn.
On a !CONFIG_SMP build, cpuhp_state_add_instance() still invokes
cm3_pmu_online_cpu() on the boot CPU, where the !CONFIG_SMP stub for
irq_set_affinity() returns -EINVAL and triggers WARN_ON() whenever an
overflow IRQ is present.  Without CONFIG_MIPS_CPS, cps_smp_setup() also
never populates the cluster ID in cpu_data[].globalnumber.

> diff --git a/drivers/perf/mips_cm3_pmu.c b/drivers/perf/mips_cm3_pmu.c
> new file mode 100644
> index 0000000000000..6d53535473b96
> --- /dev/null
> +++ b/drivers/perf/mips_cm3_pmu.c
[ ... ]
> +static void cm3_pmu_update(struct perf_event *event)
> +{
> +	struct cm3_pmu *cm3_pmu =3D to_cm3_pmu(event->pmu);
> +	struct hw_perf_event *hwc =3D &event->hw;
> +	u32 ov_bit =3D cm3_pmu_overflow_bit(hwc->idx);
> +	u64 delta, prev, new;
> +	bool overflowed =3D false;
> +
> +	/* Counts were harvested when the cluster went down, nothing since */
> +	if (READ_ONCE(cm3_pmu->paused))
> +		return;
> +
> +	/*
> +	 * When polling, the counter cannot wrap twice between two reads and
> +	 * the 32-bit difference tells the whole story. With the overflow
> +	 * interrupt the counter is only read on demand and may have made a
> +	 * full turn since the last read, which the overflow status tells.
> +	 * It is read and cleared before the counter so that a wrap seen
> +	 * here is also reflected in the counter value; a wrap happening in
> +	 * between is accounted by the next update, which the interrupt it
> +	 * raises makes sure happens. In interrupt mode every access to the
> +	 * event runs on cm3_pmu->on_cpu with interrupts disabled, so the
> +	 * status and the counter are read consistently.
> +	 */
> +	if (cm3_pmu->irq > 0) {
> +		overflowed =3D CM3_PMU_READ(cm3_pmu, pc_ov) & ov_bit;
> +		if (overflowed)
> +			CM3_PMU_WRITE(cm3_pmu, pc_ov, ov_bit);
> +	}
> +
> +	do {
> +		prev =3D local64_read(&hwc->prev_count);
> +		new =3D cm3_pmu_read_counter(cm3_pmu, hwc->idx);
> +	} while (local64_cmpxchg(&hwc->prev_count, prev, new) !=3D prev);
> +
> +	/*
> +	 * If the counter wrapped and now shows a value not below the
> +	 * previous one, it made a full turn on top of the 32-bit difference.
> +	 */
> +	delta =3D (new - prev) & CM3_PMU_COUNTER_MASK;
> +	if (overflowed && new >=3D prev)
> +		delta +=3D CM3_PMU_COUNTER_MASK + 1;
> +
> +	local64_add(delta, &event->count);
> +}

[Severity: Medium]
Can cm3_pmu_update() double-count a counter wrap in interrupt mode and
add an extra 2^32 to event->count?

If hwc->prev_count holds a non-zero value prev (from an earlier read) and
the counter wraps past 0xffffffff to a small value new < prev right after
pc_ov is read as 0 but before cm3_pmu_read_counter() runs, then:

1. This call sees overflowed =3D=3D false and new < prev, so
   delta =3D (new - prev) & CM3_PMU_COUNTER_MASK already accounts for the
   wrap across 0xffffffff -> 0, and hwc->prev_count becomes new.
2. Because the wrap happened after reading pc_ov, ov_bit remains latched
   in pc_ov and the overflow interrupt fires next.
3. cm3_pmu_handle_irq() -> cm3_pmu_update() now sees overflowed =3D=3D true
   and new >=3D prev (relative to the already post-wrap prev), so
   if (overflowed && new >=3D prev) adds CM3_PMU_COUNTER_MASK + 1 a second
   time for the same wrap.

Also, Documentation/admin-guide/perf/mips_cm3_pmu.rst notes that the CM3
asserts so_cm_perf_cnt_int when a counter reaches 0xffffffff.  If
cm3_pmu_update() reads the counter while it is still at 0xffffffff with
overflowed =3D=3D true, new =3D=3D 0xffffffff satisfies new >=3D prev for a=
ny
32-bit prev, adding 2^32 before the counter actually wraps to 0 on the
next event.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-i6500-cm3-=
pmu-v3-0-c86410934b51@mobileye.com?part=3D5
