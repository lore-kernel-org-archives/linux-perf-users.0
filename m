Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793301056;
	b=XQL8uXiCZG2lHT+DidlwFW/UZyfYdlVDSU6zEScBR9cPtl6fQdvZTsnNYasDF+Mmt6AY
	 cJqc9yiWLpDXfOe4HmJHcfF17x8et1vkYCfkn4UT4OPPyXN5cQ8Ec5ORgz6AcUtfoXqgq
	 vnTJmkpNGhyJc1suNKuSnvv/YUHd6bns+ZmDG20tj4v1d3wiU0TgAqnz2h22WV3zhQBPb
	 2GeLr7TP6Ztb2ss1ZuDJAwiT4EAJ8SnfxP1Jw6zjkRqy++xEX/AbcyUcsWE4K+hD3gOYo
	 wWMK5H+9W0ilLPcmkEor4GRy+3ed4F+/afUioTGeLq6e+Zo2v6cR4FYk1AUhdso75wA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793301056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sZtt94BuKRrMa0m2eyIL+OjBeHwHwul0io3fCHfTqyU=;
	b=g14EUcQD7VZLs/f9WkxEJVWpMx3DqGsb10v3UvBgnx+Dcg+gtMUSjT3y6JDixYQ+Wuxm
	 i7ngxchB78zbKVN3HfdXVecP0dkKJY7kneWWqCuvYTuPdkpAKnTme7n/7Ki8oNLd9G/hZ
	 0aoMIcKtHIXVIzHlgo/brZzibijtG0WGnSx8BG6tDsm1NKrQqsY5mpgmQrWUG+jPqOEyX
	 EKg0BbkAvaBCm68sbJh9lUlmpjvjbZZAmImJ8ALTN+55STAvOmeENx4CIlskyxxyhY+OG
	 hTyVBFAkdupLpgYdVrySPAjhbkijp+m5KX7av/fovLp2cxnDW4bW+gwo8mhfPfM8V/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpIvXitJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205C606A31F
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 19:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JpIvXitJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778031F01824;
	Thu, 29 Oct 2026 19:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793301055;
	bh=sZtt94BuKRrMa0m2eyIL+OjBeHwHwul0io3fCHfTqyU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JpIvXitJ1EKvqW9IGwyAk70MUpOqhf0bG0uWJ18jMZgmPHfDglGvVTcMjFXFN1HZj
	 4vPTmgfoH/JVwz3r8KlK6rTmHmla/2V19zabHPbi0C3mw2+iUZWMgHu/4l2sRLa8N1
	 X/DZ8vMTfVVOXhFagu6KVKXqlknk3cAzMd4kDp9Lzaw/wcqrgmJpUCuBgiE6QZfU7f
	 Z2K9JmVrMTR/o+O5sdxQGPQdgT6wGWXbOQJBl0U++3M55XPAqqYFsBAHyh3DSVz8R8
	 OV01gvmB9vtz3LxiIv15QH4gOAc0mIFGQKwJhloMl34kKpHiyJV8NG9OvmQPqH/W+8
	 o6YqFpBevZryw==
Message-ID: <sashiko-outbox-189848@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] perf jevents: add amd specific device table entry
 metrics
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jacob Lefkowitz" <jlefkowi@akamai.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261029-perf-tools-next-v1-2-a75a2b64a15e@akamai.com>
References: <20261029-perf-tools-next-v1-0-a75a2b64a15e@akamai.com>
 <20261029-perf-tools-next-v1-2-a75a2b64a15e@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 19:10:55 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf jevents: min() in AmdIommudte() and AmdIommuptw() turns NaN=
 into 100%
- [Low] perf jevents: wrong description for lpm_iommu_dte_lookups in AmdIom=
mudte()
--

commit da475f803a7d9ff1e625186fc6cc682762bf1c80
Author: Jacob Lefkowitz <jlefkowi@akamai.com>

perf jevents: add amd specific device table entry metrics

This commit adds the iommudte metric group (lpm_iommu_dte_miss_rate and
lpm_iommu_dte_lookups) for AMD Zen 2+ processors using amd_iommu PMU events.

> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events=
/amd_metrics.py
> index dcffd6e268fad..912bceb57d67b 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -318,6 +318,37 @@ def AmdIotlb() -> Optional[MetricGroup]:
>      )
> =20
> =20
> +def AmdIommudte() -> Optional[MetricGroup]:
> +    global _zen_model
> +
> +    if _zen_model < 2:
> +        return None
> +
> +    dte_hit =3D Event("amd_iommu/mem_dte_hit/")
> +    dte_mis =3D Event("amd_iommu/mem_dte_mis/")
> +    lookups =3D dte_hit + dte_mis
> +
> +    return MetricGroup(
> +        "iommudte",
> +        [
> +            Metric(
> +                "lpm_iommu_dte_miss_rate",
> +                "IOMMU device table cache miss rate",
> +                min(d_ratio(dte_mis, lookups), 1),
> +                "100%"
> +            ),

[Severity: Medium]
In AmdIommudte(), does wrapping d_ratio(dte_mis, lookups) in min(..., 1)
cause lpm_iommu_dte_miss_rate to report 100.0% instead of "none" on sockets
where no amd_iommu counters are scheduled?

Because the amd_iommu PMU exposes a cpumask containing only CPU 0, running
perf stat with --per-socket schedules 0 counters on other sockets (such as
S1 in the commit message's test output), causing dte_hit, dte_mis, and
d_ratio(dte_mis, lookups) to evaluate to NAN.

In tools/perf/util/expr.y, MIN evaluates:

    | MIN '(' expr ',' expr ')'
    {
            if (!compute_ids) {
                    $$.val =3D $3.val < $5.val ? $3.val : $5.val;
                    $$.ids =3D NULL;
            } else {
                    $$ =3D union_expr($3, $5);
            }
    }

Since NAN < 1 is false in IEEE 754 floating-point arithmetic, min(NAN, 1)
returns 1.0 (100.0%) instead of propagating NAN, as seen in the commit
message's output for S1:

    {"socket" : "S1", "counters" : 0,
    "lookups/s  lpm_iommu_dte_lookups" : "none",
    "%  lpm_iommu_dte_miss_rate" : "100.0"}

Since lookups is dte_hit + dte_mis, d_ratio(dte_mis, lookups) cannot exceed
1.0 for valid counter readings. Should lpm_iommu_dte_miss_rate in
AmdIommudte() (as well as lpm_iommu_ptw_nested_read_ratio and
lpm_iommu_ptw_guest_read_ratio in AmdIommuptw()) use d_ratio() directly
without min(..., 1), matching AmdIotlb()?

> +            Metric(
> +                "lpm_iommu_dte_lookups",
> +                "IOMMU device table cache miss rate",
> +                d_ratio(lookups, interval_sec),
> +                "lookups/s"
> +            )

[Severity: Low]
In AmdIommudte(), is the description for lpm_iommu_dte_lookups copy-pasted
from lpm_iommu_dte_miss_rate? It currently says "IOMMU device table cache
miss rate" instead of describing IOMMU device table cache lookups.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-perf-tools=
-next-v1-0-a75a2b64a15e@akamai.com?part=3D2
