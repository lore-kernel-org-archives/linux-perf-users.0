Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420082;
	b=1MRpO5UcN51d5y84ksTkDrdlyVXVJKRhiCwmIbYXGDdJHIxOJjrTIGDSukt8I1Shsc2M
	 f1n+NFycDqQznInFj9wNIZpjEN8quJaWaynfymfLLdoa7LmbJ/WHuCiMJsBRRLJTjulP5
	 HGib2wK7PGDMxQK8+1oiFdPuhSLHvNlCf44+FM6a5zbUBS10iKUOZMyQra3bHygFAQ/gr
	 qwj/GxZASGAEDvSgU5GhlBc/nqy3A5cir07CXNs9ttWdcqyg19LkIVa7NVkjsWZyjlOXL
	 b5LwVHncC++6RIINeZhnUMPfmVOr242K3mn+L0AMd+/C7GXxnk4Yrtlo6fnnFEFZyfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420082;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dSdAkgM9/ohkcvtrgQ5KQb2Uxbw10r4LgRUYb8VCwyM=;
	b=FeVyRiw7W54T/d3LtBsa4x87pmUTY4awjZD3jcwgC0UY30mZ6neqv+xpuWSeKHzV96MD
	 TfBT1rdC36SCjfuVSQaFieCwyxpCHt5+xVH6sT5jNWpb35y/JTbip2dO6HIWD5aMwNWGy
	 0XyJpXQYhnCZjm5rXftF8aRs6II46r8w6aISlfUvt1iSun8i2nuJlvy1WEzBc4Bf5b9nX
	 6xk6sx9KsdDZLKUA7q4RpqYjkgTzCVOy50AaqxqW3xFHZJr17hVGAXpU5ADthQebgQyIn
	 0y6HKEu1Frp/tt2XLiKdy+rwS/AxX9c/JWYscalK+a51OVEsx5h2e7NMganHYRgzOUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnbTy++h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCB6606A31A
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MnbTy++h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0763E1F000D0;
	Mon, 23 Nov 2026 07:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420082;
	bh=dSdAkgM9/ohkcvtrgQ5KQb2Uxbw10r4LgRUYb8VCwyM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MnbTy++hXqVAmTLDHOmfIHq6sUFc6WiWa4Hl5zAlGqN2FO2tLuWfkqT7G6qj6Evjq
	 h3TAE/btDMSq0t7GpXzyfi9+o7/DsHkGztrBSVvIqqcMAz5ZOEWMJvx4Fkp2ZnFjZh
	 aklYKlfhIQfC16j3UMH8VACiJ8KyIwoQ2L9lOIz6DeETQ9S7pk8FRXOZXGh7w4wq5p
	 MTzJnX/QgWbMbEGmTaYILaeSDykjUfjYvy0R7dzVzbPrfZOvFJTSv8diirgGjwFGdq
	 bp6N6vgISpOH1vo70toKRAZPC0m9XkKRl61hDXOsl5dEC0pZvYcxI9wPPlDIys/2br
	 UNjuEPTkQH1Qw==
Message-ID: <sashiko-outbox-228838@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: arm_spe: Probe PMSNEVFR and PMSDSFR filter bits
 independently
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ping Li" <leeonion.muyu@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261123073719.3190149-1-leeonion.muyu@gmail.com>
References: <20261123073719.3190149-1-leeonion.muyu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:48:01 +0000
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
- [High] perf: arm_spe: inverted pmsdsfr_res0 check in
  arm_spe_pmu_event_init()
--

commit 3f0a782ec38224bd78fe15f8095fc1100ecbb217
Author: Ping Li <leeonion.muyu@gmail.com>

perf: arm_spe: Probe PMSNEVFR and PMSDSFR filter bits independently

This commit probes the supported filter bits of PMSNEVFR_EL1 and
PMSDSFR_EL1 independently and validates inverse event filters and data
source filters against their respective RES0 masks.

> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index 707778c67dab5..00d54202c59bc 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c

[ ... ]

> @@ -818,13 +820,22 @@ static int arm_spe_pmu_event_init(struct perf_event=
 *event)
>  	if (arm_spe_event_to_pmsevfr(event) & spe_pmu->pmsevfr_res0)
>  		return -EOPNOTSUPP;
> =20
> -	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsevfr_res0)
> +	if (arm_spe_event_to_pmsnevfr(event) & spe_pmu->pmsnevfr_res0)
>  		return -EOPNOTSUPP;
> =20
>  	if (arm_spe_event_to_pmsdsfr(event) !=3D U64_MAX &&
>  	    !(spe_pmu->features & SPE_PMU_FEAT_FDS))
>  		return -EOPNOTSUPP;
> =20
> +	/*
> +	 * The data source filter is exposed inverted, so validate the
> +	 * value written to PMSDSFR_EL1 (~config4) rather than config4
> +	 * itself.
> +	 */
> +	if (ATTR_CFG_GET_FLD(attr, inv_data_src_filter) &&
> +	    (arm_spe_event_to_pmsdsfr(event) & spe_pmu->pmsdsfr_res0))
> +		return -EOPNOTSUPP;

[Severity: High]
Does validating arm_spe_event_to_pmsdsfr(event) (~config4) against
spe_pmu->pmsdsfr_res0 reject valid exclusion masks whenever PMSDSFR_EL1
has any unimplemented RAZ/WI bits?

Because arm_spe_event_to_pmsdsfr() bitwise-inverts inv_data_src_filter,
every bit left at its default of 0 in config4 becomes 1 in
arm_spe_event_to_pmsdsfr(event).  If a user passes inv_data_src_filter=3D0x1
to exclude data source 0 while leaving all other bits at 0, any
unimplemented bit position in spe_pmu->pmsdsfr_res0 is 1 in both
arm_spe_event_to_pmsdsfr(event) and spe_pmu->pmsdsfr_res0, so
arm_spe_pmu_event_init() fails with -EOPNOTSUPP unless userspace sets
every unimplemented RES0 bit in config4 (which is not exposed in sysfs
caps/).  Conversely, a config4 value that sets only unimplemented bits in
spe_pmu->pmsdsfr_res0 clears those bits in ~config4 and is accepted.

Should this check ATTR_CFG_GET_FLD(attr, inv_data_src_filter) &
spe_pmu->pmsdsfr_res0 instead, or expose the supported mask in caps/ if
userspace is expected to clear unimplemented bits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123073719.3190=
149-1-leeonion.muyu@gmail.com?part=3D1
