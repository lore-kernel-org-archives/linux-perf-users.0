Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794488534;
	b=EG2kxYmtcP+TCR0sR84H5jbYMa/WWFnbvJaSdOwaLb6v3/maXr04C7cPdIWGJefcMCgh
	 etiWG9uJ5RXq6d2wcYsXRE8mLzNmWWoJIoBYdcb5jOYTimHroFtOniiXMMY7obHLwgFhX
	 L1v2XYRAkC6XCvtpPdU015btVtX+9PuXxe/PJtWtaNDS90vZOV47O8FiTPJOgy56BGQhX
	 BHcKbMVpTwjpCpkr/tbcBRAPyTWA7IYvR2SVYxBI/sDaQTqJm8Mc1dPu0v1BVu4ZD/7MS
	 L6eW52hVmHsudRizT6sP7H4yEvBOto83Q6hvPwNYBFiXBGXKrNKxClfKDlz+NUmGECQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794488534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=KYusxYP1bJCA82Agudj5Yk62dkc+vZ4npVPLPLyCVJY=;
	b=vNAoe8wt9ge5W75ZrgWDf/1uGH8vmgSUwyjP9jrraqhzXbL0xXauW4AJMhyJdzMpGM6T
	 CuAQ+J6SRDqIG3/eMYZVLjR3fnG00mPH+m6dG31TbI8diANtUGaZVMsX4RGoq9msLPl2n
	 x0XWPyjPUdLnoOPKRd1ZAMKEC1oeLFoF/Yrant2CDyz8GPXfzbGiVj9Rx3YtIGdJFoB4b
	 7Go7Iu3q6orcM2RVO28sfkkOmAS76Ez0P2D9zx43EdA4Xmi5yDQmsR7TLz62+7Z3mrsDU
	 bLNHhVrvWzNliU15m5bY8RmyWQT2JPPWE+e6jqc5rM+2fL9zvjANZp7cCx3AUrPN0Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SMs4/KN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972FF606A321;
	Thu, 12 Nov 2026 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SMs4/KN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE401F00A05;
	Thu, 12 Nov 2026 13:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794488534;
	bh=KYusxYP1bJCA82Agudj5Yk62dkc+vZ4npVPLPLyCVJY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMs4/KN/eiCn7BHQ63CG/6s/8VCH/u+KLjduSqHZr1LtaiAeMJYqyN5m8Ui6TQN4h
	 MnhnFbOJGaxTcpwznRharfRlE7U1tbPixQX90oUpd133QX+39cAYaZMZWrAWqgN15x
	 /Yi8M2nFEbWVSEtYaI2EZPSe3nvlTW9x1zh1TRpfhAnxb3u9RSnCxw7T/ftmssXKui
	 B9yRenIPrjVreQm2iy9T7LGIojP0KoN+2g+Ap86VM4v5zVLLFyS/s/3X/e/jfRUBD2
	 y3uIl6Co9ZYPpn1zKy1NO7xnQrrtJ4jEXJ1iF+0C0IRR6AYm2gtgEj4Vop0jp83vtH
	 16vRycYrOaLBg==
Message-ID: <sashiko-outbox-211133@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] perf: add MIPS Coherence Manager 3 (CM3) PMU
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Kondratiev" <vladimir.kondratiev@mobileye.com>
Cc: linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-perf-users@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261112-i6500-cm3-pmu-v2-5-cd2569571819@mobileye.com>
References: <20261112-i6500-cm3-pmu-v2-0-cd2569571819@mobileye.com>
 <20261112-i6500-cm3-pmu-v2-5-cd2569571819@mobileye.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:02:13 +0000
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
- [Low] perf: mips_cm3_pmu: broken !MIPS_CPS / !SMP configuration
--

commit 272d1a9241643c479b7f4cabbd1c40edccbe1b16
Author: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

perf: add MIPS Coherence Manager 3 (CM3) PMU driver

This commit adds an uncore PMU driver and documentation for the MIPS
Coherence Manager 3 (CM3) performance and cycle counters.

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
Should MIPS_CM3_PMU depend on MIPS_CPS rather than MIPS_CM?

MIPS_GIC selects MIPS_CM even when CONFIG_MIPS_CPS=3Dn and CONFIG_SMP=3Dn.
On a !CONFIG_SMP build, irq_set_affinity() is a stub returning -EINVAL, so
cm3_pmu_online_cpu() unconditionally triggers WARN_ON() when an overflow
IRQ is present; without CONFIG_MIPS_CPS, cps_smp_setup() also never
populates the cluster ID in cpu_data[].globalnumber.

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
inflate event->count by 2^32?

If hwc->prev_count holds a non-zero value prev and the counter wraps to a
small value (new < prev) between reading pc_ov and reading the counter,
the first cm3_pmu_update() sees overflowed =3D=3D false, updates prev_count=
 to
new, and already accounts for the wrap in (new - prev) &
CM3_PMU_COUNTER_MASK while leaving ov_bit set in pc_ov.  When the pending
overflow interrupt then runs cm3_pmu_update(), it sees overflowed =3D=3D tr=
ue
with the counter >=3D the new prev_count and adds CM3_PMU_COUNTER_MASK + 1 a
second time.

Similarly, because the hardware sets ov_bit when the counter reaches
0xffffffff rather than when it wraps to 0, handling the interrupt or
reading the event while the counter is still at 0xffffffff satisfies
overflowed && new >=3D prev, adding 2^32 before the wrap to 0 adds 1 on the
next update.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-i6500-cm3-=
pmu-v2-0-cd2569571819@mobileye.com?part=3D5
