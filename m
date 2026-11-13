Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559491;
	b=kMt/bFnkDRB9mBb4WAyHpGiZH31cqtEjI3rv7W4Mm6B06vXvmxGqB4lnfTENqEFpAB7L
	 xjFtGGdhQHLM//2hRGsnCqOlQLgkREIbVoufFAToJRi5F7D+4p7Szp+7sHb1ZithqLBGU
	 EsMUQiJwElLZDhCYw0bELbkufXE2bE4iFguqivBhkmVyAfMRjCnJE2xjEZtoWCPv0FWS1
	 fx5QvMi63CALAsOKKmaDwJkgt73X1jfn1Hq0UcDb+KMvQfJn6Ibzwye751wBfYGxaMjI8
	 esaxzkcBiPCmiB4aWXXjmkD3Irj4ixxELUIEGAsMFJCA/48JP7OyRluI6sxlzKTDy4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559491;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNw4s9r03DY+d5Udn3teVQmi+fqb84gJA+VxUut8tFE=;
	b=l32LdobTHBE5QYAi+4wBZ7IQhqZE1amrTzrAn69B/xUIHi4PDr7FDR3YXeRnZBcQevTF
	 hwk84ZyHsyHqvJzGc2VGIzYMQjB2q2gcv18zQx/EzlBFQeugUsP/P7pzd7c8g5dwQsP43
	 7BXhwHe6W3taQyQf2Wwd3RQ5t2Pc0sf1FdVfQCtGfHkEAwfq0hd2IxQEOC7y0ahvmVR5l
	 TsE7PnCdh6hkaSm7Q4EQTDp+41YeyvFsAQbIFljvdF3L7K6scGeaZgjtUOQTBC+QdIEql
	 lsCyuQ1WZeXQe13gPHlckaTADU1fnPfwB7YlBUoErT7tt36AEqa1ay3uIQ+AvO8vPOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6PuWXMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F710606A8A2
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Nov 2026 08:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6PuWXMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF571F000C9;
	Fri, 13 Nov 2026 08:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794559491;
	bh=zNw4s9r03DY+d5Udn3teVQmi+fqb84gJA+VxUut8tFE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b6PuWXMXLgaGoZdBupQ8s252D64HJyGTe68X1U3a4k0rCDXfXhWWvM31YldCeEkQF
	 sZ0Plm8D4B4ASerHT5y4y84+ceW8sSFlgwuv8h9gT+JkxAUB43Z82gjmHK2fqKcs98
	 nQgPp9A7DTk13SwmJlJom+KvBqfHVenEIZqAkFIKrHO+fXmZcvJ4eAGci3itoskR7o
	 eewQxfKU1Bw49rX/QynHkofrr8ZwAanUVeFsQUKbhyUn3jspEb/SRABMHUdv5y1TQF
	 xbabDf7RPVp7lZlUt40Mz7MgwTj8m9XVDguAEPG+QITlowvyPYd3Wb0IxW8XqwbFpt
	 nLluifHn++d+w==
Message-ID: <sashiko-outbox-212454@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf/arm-ccn: Set up the DT base before requesting the
 IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: hu.shengming@zte.com.cn
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261113163430071vxN-ZVM94Ib9cZ18HMyHa@zte.com.cn>
References: <20261113163430071vxN-ZVM94Ib9cZ18HMyHa@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 08:44:50 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf/arm-ccn: pending event overflow in arm_ccn_probe() hits
  WARN_ON_ONCE()
--

commit bd2c94bb4323c8419a6bdf342c08aa582e84af55
Author: Qifeng He <he.qifeng1@zte.com.cn>

perf/arm-ccn: Set up the DT base before requesting the IRQ

This commit initializes ccn->dt.base in arm_ccn_probe() before requesting
the CCN interrupt so that a pending overflow interrupt does not dereference
a NULL dt->base.

> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
> index 0c69165e00418..3cbdda843b591 100644
> --- a/drivers/perf/arm-ccn.c
> +++ b/drivers/perf/arm-ccn.c
> @@ -1213,8 +1213,10 @@ static int arm_ccn_pmu_init(struct arm_ccn *ccn)
>  	char *name;
>  	int err;
> =20
> -	/* Initialize DT subsystem */
> -	ccn->dt.base =3D ccn->base + CCN_REGION_SIZE;
> +	/*
> +	 * Initialize the DT subsystem; dt.base was set up in
> +	 * arm_ccn_probe() before the IRQ was requested.
> +	 */
>  	spin_lock_init(&ccn->dt.config_lock);
>  	writel(CCN_DT_PMOVSR_CLR__MASK, ccn->dt.base + CCN_DT_PMOVSR_CLR);
>  	writel(CCN_DT_CTL__DT_EN, ccn->dt.base + CCN_DT_CTL);
> @@ -1463,6 +1465,14 @@ static int arm_ccn_probe(struct platform_device *p=
dev)
>  	if (IS_ERR(ccn->base))
>  		return PTR_ERR(ccn->base);
> =20
> +	/*
> +	 * The CCN interrupt is level-triggered and may already be pending,
> +	 * e.g. an overflow left by a previous kernel across kexec.  The
> +	 * handler can run as soon as devm_request_irq() below installs it,
> +	 * and it dereferences dt->base, so set it up before that.
> +	 */
> +	ccn->dt.base =3D ccn->base + CCN_REGION_SIZE;
> +
>  	irq =3D platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;

[Severity: Medium]
Can a pending overflow on an event counter still trigger the WARN_ON_ONCE()
in arm_ccn_pmu_overflow_handler() when devm_request_irq() unmasks the
interrupt?

When devm_request_irq() runs in arm_ccn_probe(), CCN_DT_PMOVSR has not yet
been cleared (commit fa637bf0595e ("bus: arm-ccn: Fix spurious warning
message") added the CCN_DT_PMOVSR_CLR write in arm_ccn_pmu_init() to avoid
warnings on pre-existing overflows), CCN_DT_PMCR is still enabled from the
previous kernel, and dt->pmu_counters[].event are all NULL:

drivers/perf/arm-ccn.c:arm_ccn_pmu_overflow_handler() {
	...
	for (idx =3D 0; idx < CCN_NUM_PMU_EVENT_COUNTERS + 1; idx++) {
		struct perf_event *event =3D dt->pmu_counters[idx].event;
		int overflowed =3D pmovsr & BIT(idx);

		WARN_ON_ONCE(overflowed && !event &&
				idx !=3D CCN_IDX_PMU_CYCLE_COUNTER);
	...
}

If the previous kernel left a pending overflow on any of the event counters
(indices 0..7) rather than only the cycle counter, or an active counter
overflows before arm_ccn_pmu_init() runs, the handler hits WARN_ON_ONCE().
Disabling CCN_DT_PMCR and clearing CCN_DT_PMOVSR_CLR before requesting the
IRQ (or requesting the IRQ after the hardware state is reset) would avoid
taking a stale interrupt with uninitialized counter state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113163430071vx=
N-ZVM94Ib9cZ18HMyHa@zte.com.cn?part=3D1
