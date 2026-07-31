Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6C917A314
	for <linux-perf-users@vger.kernel.org>; Fri, 31 Jul 2026 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785509287; cv=none; b=B4ZnDIynU83OJONcwkek6XVK6jpjCbvOw9p7uNUhqh//17wvbJW7fJzajSrwXvULK0G3eZRJ4FEqKmEoRxsj2T9k+q/WOZltO9BoDv15J1QdhJ4qEqBYA5h9eBSXbe0+COdNte8s9g6CaytNfPomYBHveayLToBxnFMirmXbYZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785509287; c=relaxed/simple;
	bh=z6SGRdIa3PmCCn3km/y3Zl0cxUPJjK76DvCe8f5ZAu4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oeOJsBbtkclbGO/bJSVtA5Ujme8te30P+ypZgRs6dUYhb/BnJXw4qlSOJxHH826w4J/keZh89pfyfR0xde45rz6khWve14eiAWqSfoo4qEE0p4nB8g+6bxZcZQBUFV8HWag5/3Vz7jhRTCyXsIvdug4wocUVt+YLg9u+8Var9ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8m66qoh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8m66qoh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783EC1F000E9;
	Fri, 31 Jul 2026 14:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785509285;
	bh=wQoPa8Bou7s5KdsY0FvUdqKVm3AvW9fGuLKtTdEKMbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R8m66qohkUC5GNLq7oSfdnKpxkbdTiI41dcjPQrWSb2dz9WfcWUPsmY7846Dca7v1
	 FrvX10pg5f0y/iMgmbN+WNMJY+gca2+QAnvP6jNQ8RLSIu93N+iAgyaeBpr1xgaEsm
	 qg9wzez4lJX6UaJXPwRICNP/2g4r7nGoRX5/W2mLU3wL3e5gnJ7QQDnpMmObbpmGH8
	 cBzTOU2rXHzTqAHdk8Zl795tHc5oDT8yZa4/E/c1wdmw/HxsC88ExTVl7kzRNlSx8I
	 +zKiIiJ1dvPWuquxSI33lV5q0DJ6ygxwoehlVw+RgcpGnSlnR4J6tUrttFA4b+XTOd
	 aKru67SI9LOUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm_cspmu: Support 64-bit programmers' model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Robin Murphy" <robin.murphy@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <df1d5eba590bcb12a3bab401ee47e172c51c9515.1785507788.git.robin.murphy@arm.com>
References: <df1d5eba590bcb12a3bab401ee47e172c51c9515.1785507788.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:48:04 +0000
Message-Id: <20260731144805.783EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Unconditional call to `is_cycle_counter_event` in `nvidia_cspmu.c`=
 can lead to a NULL pointer dereference when `has_ext64` is true.
- [High] Unconditional 64-bit MMIO accesses (`writeq`) to EXT64 configurati=
on registers can cause bus faults on systems lacking 64-bit atomic access s=
upport.
- [High] The sysfs format definition for 'event' incorrectly truncates to 3=
2 bits (config:0-31) on 32-bit PMUs, breaking the default 'cycles' event pa=
rsing.
- [Medium] Writing `0` to `PMCNTEN` fails to clear the counter enables duri=
ng EXT64 detection.
--

--- Patch [1]: [PATCH] perf/arm_cspmu: Support 64-bit programmers' model ---
commit 3d99db99686e79c818d79a1c86a0485ea652a357
Author: Robin Murphy <robin.murphy@arm.com>

perf/arm_cspmu: Support 64-bit programmers' model

This commit adds support for the FEAT_CSPMU_EXT64 extension, making all
non-counter registers 64-bit. It omits generic fixed cycle counter support
for 64-bit events and updates event configuration fields accordingly.

> diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/=
arm_cspmu.c
> index e6292021f653e..f71a0030625e2 100644
> --- a/drivers/perf/arm_cspmu/arm_cspmu.c
> +++ b/drivers/perf/arm_cspmu/arm_cspmu.c
[ ... ]
> @@ -173,13 +173,28 @@ arm_cspmu_event_attr_is_visible(struct kobject *kob=
j,
>  	eattr =3D container_of(attr, typeof(*eattr), attr.attr);
> =20
>  	/* Hide cycle event if not supported */
> -	if (!supports_cycle_counter(cspmu) &&
> +	if ((cspmu->has_ext64 || !supports_cycle_counter(cspmu)) &&
>  	    eattr->id =3D=3D ARM_CSPMU_EVT_CYCLES_DEFAULT)
>  		return 0;
> =20
>  	return attr->mode;
>  }
> =20
> +ssize_t arm_cspmu_default_format_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct perf_pmu_events_attr *fmt =3D container_of(attr, typeof(*fmt), a=
ttr);
> +	struct arm_cspmu *cspmu =3D to_arm_cspmu(dev_get_drvdata(dev));
> +	u64 field =3D cspmu->has_ext64 ? U64_MAX : U32_MAX;
> +	DECLARE_BITMAP(bits, 64) =3D { BITMAP_FROM_U64(field) };

[Severity: High]
Will this truncate the event format definition on 32-bit PMUs?

Prior to this patch, the format was defined as config:0-32. Since the hardw=
are
cycle counter event uses bit 32, using U32_MAX restricts the bitmap to bits
0-31, which might cause tools like perf to reject the default cycles event.

[ ... ]
> @@ -412,6 +437,17 @@ static int arm_cspmu_init_impl_ops(struct arm_cspmu =
*cspmu)
>  		DEFAULT_IMPL_OP(event_attr_is_visible),
>  	};
> =20
> +	/*
> +	 * With 64-bit events, since our default "cycles" encoding won't work,
> +	 * and the architecture recommends against implementing it anyway, we
> +	 * choose to effectively ignore FEAT_CSPMU_CCNTR, unless a vendor
> +	 * module really wants to provide its own encoding and ops.
> +	 */
> +	if (cspmu->has_ext64) {
> +		cspmu->impl.ops.is_cycle_counter_event =3D NULL;
> +		cspmu->impl.ops.set_cc_filter =3D NULL;
> +	}

[Severity: High]
Could this lead to a NULL pointer dereference in vendor drivers?

Looking at pcie_v2_pmu_validate_event() in nvidia_cspmu.c, it makes an
unconditional call to cspmu->impl.ops.is_cycle_counter_event().
If has_ext64 evaluates to true, opening a perf event on that PMU might trig=
ger
a panic.

[ ... ]
> @@ -797,26 +839,33 @@ static void arm_cspmu_event_update(struct perf_even=
t *event)
>  static inline void arm_cspmu_set_event(struct arm_cspmu *cspmu,
>  					struct hw_perf_event *hwc)
>  {
> -	u32 offset =3D PMEVTYPER + (4 * hwc->idx);
> -
> -	writel(hwc->config, cspmu->base0 + offset);
> +	if (cspmu->has_ext64)
> +		writeq(hwc->config, cspmu->base0 + PMEVTYPER + (8 * hwc->idx));

[Severity: High]
Does this writeq() need to be guarded by a check for has_atomic_dword?

The driver correctly falls back to lo_hi_writeq() for 64-bit counter access=
es
on systems lacking atomic 64-bit support. On systems with 32-bit buses that
don't split 64-bit transactions automatically, this writeq() might generate=
 a
bus fault.

> +	else
> +		writel(hwc->config, cspmu->base0 + PMEVTYPER + (4 * hwc->idx));
>  }
> =20
>  static void arm_cspmu_set_ev_filter(struct arm_cspmu *cspmu,
>  				    const struct perf_event *event)
>  {
> -	u32 filter =3D event->attr.config1 & ARM_CSPMU_FILTER_MASK;
> -	u32 filter2 =3D event->attr.config2 & ARM_CSPMU_FILTER_MASK;
> -	u32 offset =3D 4 * event->hw.idx;
> +	u64 filter =3D arm_cspmu_filter(event);
> +	u64 filter2 =3D arm_cspmu_filter2(event);
> +	int n =3D event->hw.idx;
> =20
> -	writel(filter, cspmu->base0 + PMEVFILTR + offset);
> -	writel(filter2, cspmu->base0 + PMEVFILT2R + offset);
> +	if (cspmu->has_ext64) {
> +		writeq(filter, cspmu->base0 + PMEVFILTR + (8 * n));
> +		writeq(filter2, cspmu->base0 + PMEVFILT2R + (8 * n));

[Severity: High]
Similarly, do these configuration register writes also need to respect
has_atomic_dword to prevent external aborts on 32-bit APB buses?

[ ... ]
> @@ -969,6 +1018,30 @@ static int arm_cspmu_init_mmio(struct arm_cspmu *cs=
pmu)
>  		}
>  	}
> =20
> +	/*
> +	 * We can infer FEAT_CSPMU_EXT64 from PMCNTEN, or hope that anything
> +	 * that failed to get that right has at least implemented the optional
> +	 * PMDEVARCH correctly...
> +	 *
> +	 * Note that architecturally, has_ext64 *should* imply has_atomic_dword,
> +	 * but enough implementations have ignored that already that we'll just
> +	 * have to still rely on the firmware flag.
> +	 */
> +	writel(~0U, cspmu->base0 + PMCNTENCLR);
> +	writel(~0U, cspmu->base0 + PMCNTEN);
> +	if (readl(cspmu->base0 + PMCNTENCLR)) {
> +		cspmu->has_ext64 =3D true;
> +		writel(0, cspmu->base0 + PMCNTEN);

[Severity: Medium]
Is writel(0) sufficient to clear the enable bits here?

Since ARM PMU counter enable registers generally function as set registers
where writing 0 has no effect, would it be better to write ~0U to
PMCNTENCLR instead, to avoid leaving the counters unintentionally enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/df1d5eba590bcb12a3b=
ab401ee47e172c51c9515.1785507788.git.robin.murphy@arm.com?part=3D1
