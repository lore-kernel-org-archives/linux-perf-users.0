Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA9429B781
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780012006; cv=pass; b=MrUlVX5fOOYOvFWEmBkH74wgJ//mIcOgsU7kEypdC5WSy1Kas+rLag03bCLsOqVlXFFgxBxZZ+fBqDnHongYyO+vY0k8Eh11gzDRvuqG/A7uNDnf1fp9Xhj5NEzn776LJfPRXCYYpAlvPnNbBuysSkqQP0DLkfg32MGkf1Pac9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780012006; c=relaxed/simple;
	bh=8pmo/8kQdRrk8T8hnIEZyGo7CPEt1FuriNVqO2uJs1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdkdVGF5lu4TOALuhTlMreX1woP6MEJRgFguSeI+nzLX7JTSK77HkWNO7Ofr4z1N7BfuCxRYmeJGOKgiFgpcAv1PnQpeF+ArkFFJPHeF6v23U1IDogl0751v2DenwK8OS+gi+MjGs9SZnoSm9eD9cS9kQDR+z/Do7nAl/3z1lDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pbW/trWJ; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pbW/trWJ"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1331e851faaso7389709c88.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 16:46:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780012003; cv=none;
        d=google.com; s=arc-20240605;
        b=IswXUcGvhqXqehKeNJXVr14o/KUBtKn6C6hpQGcGRf55GYtkUzJdvMgxdayIQrMuE7
         qmv1i5e380oz8Gik6zbETrAQO1acUsO/FRW/kYgNe5lDM5+/UlcNwtoaOb73gqqNvZNg
         nwUwyPFBsw4ZuCJlumwDUFXkojtI0E32Nut3hfaFqTIwe9Z0AMRGuR3DwzYaGfWzwU9j
         xzXN5CoodrzEg9DYzV0LZjwUvGLBdaopuslC6p44T4U1Q1cwpbh/Lm5Tram4K0Jk98yZ
         ++nwoDrIesBExmWACtpE1UfIEFcxPgPA6VlVLb35dJuvwdNTkRpt3YDanIT7VCC0PB1s
         fY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JVZhcpL4dd4AUsQyiUs+OBHR6AicAL8HJbXJzFJ4ZfY=;
        fh=0QJBEhWzdU0fmCno0NlKWdJF4NajQ3/jHf0vJ2f4yss=;
        b=Tx31PHl5WVI8DZh5OvozE1NijIvEvPVK4Lp4hYxxf7hsnp3enCniWjwg6SVHiKQl83
         p1SW+xL7y9Rhd3EjzvOYfalEigufOVCkGteGIivn9dmXuaLn0fNLetCE+FPuw/XF0dCv
         zNsBG+GS6duiQ4PiwhEf6gLw5eqfMBsPuJzsBcUpzxYOrijxnAVICwrMyUQppmfxg/MZ
         4fkYAmcxqyMHEaRyvb32x4a5zAOgzQnPe5RYNUmTcvWDSBp74ZdZXAKnv49a9jPngkKd
         TAEmnU0Dgi3JnpRgQXJnGp+6AHk2bNtNLhW9DyQ6VYyfLR1lM5JgXBP3FpjczI+ehP/5
         BKmA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780012003; x=1780616803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVZhcpL4dd4AUsQyiUs+OBHR6AicAL8HJbXJzFJ4ZfY=;
        b=pbW/trWJtYNteXL6w7NO+txURBds8L3yev173LpxCX/YPdhmTxuJAaAB2odFMcHq9H
         YOpzO/FEHBWI0MtiJCn1sPXBTb1Xu8AOEmYFiVGM/8/sg6Jun2+SyyOIl4ZZfVutUDKw
         ok5RL04q+G96Nk2QoLrgiZfXloUFozLDTmkR8NEaMY3MIm9OBZUuoxYlSJN8yroPze6K
         Ab8u0yow4g8shfUsrABZCjOQO0e2GVY6bIMidIZYWCTM7jzbBfyeJMThZXS/fZnRYYuI
         uTs231WhogKp2n+Ibk4svin6KFJb+VXoWZ0rIFQeiRlTmXVxLzlCa9aaDG5wV1yT1ieA
         vQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780012003; x=1780616803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVZhcpL4dd4AUsQyiUs+OBHR6AicAL8HJbXJzFJ4ZfY=;
        b=jXRNygKPiV4rR+a2oZI/tJ9pDuWWmSA3y2j8njXd/TSDpFNhx3mMD4ZUQkOh+HAtBT
         abMQUpVUQXAEPNme85l/L5U3Qx9lNFDmVWdDvEunuHcFS+2s58v4VV+DtOG2ZcURwNTu
         hIuOKA5Lg8+P+86Fri2X4Oy2jEXCjwjzdeyMeWPh3kprvTc0DBPVsVlpPsZ5PqthRNIB
         6su26tY96E85iLnMnnhqes8RgOg2FzzI9Ee5lMMxaBc05xCaBRWvGa2xxdb7zrPiz2sF
         GSEjjNyG2UOxrBj6kDZsknGvoqqBLgTio4o5E0khSj/I0soFIyVV+1B99FKkZv0+D6uY
         HE5g==
X-Forwarded-Encrypted: i=1; AFNElJ+dyICYmtwTY1/juSYL9Gt5A0A3xfF+KHLoRddGxBPXRJZMIWadVde++S6fZEyhXjl1fQMV3AZzwA8Dk8/t790M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Wn+E92q3rI87JlF6IeEH/jiM3KZlYvPvbwuLhTpA/qS4ze09
	GCEEPOUY7nSxjwK0pyEV1P0qI9CdsbsfsP+H56J6cNjHejAYl4CLJzKx2dny4jy10SSuzQFPJ9t
	tmEITwdfbmUwRR7GwvxPiXYlcX0v8q8dCRnUIFfN5
X-Gm-Gg: Acq92OEzgOPXjaDlUcQfpl81Cak8n704ghpNFTeWF4rSMqcHNNdDaJRPWQJKMAidHot
	OtQQlLcqdgpZ9RIRZfzlMzt5EXcLc95o8rfVpOglyJMcWctg0TjAO3PiZxlPL5H3rHPC3/OhEmI
	TUrjhw5Gc0UeRDE2wD4GLb5gYoXoFmjt3CEfmQsXvbjDajv5Kv8IOioHkydFE2Fnm9mxg70AgXv
	e1b8Ec4OG58KQLES2WKT/2RpQ8BU6RN0C2kc3faZAcCdepY+77+kC9ClZO5lDAXduY+VafyZwed
	EuB0xPeP/+hhaNSY
X-Received: by 2002:a05:7022:221a:b0:135:3983:2131 with SMTP id
 a92af1059eb24-137aea886efmr232950c88.21.1780012001954; Thu, 28 May 2026
 16:46:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527223917.3845056-1-ctshao@google.com> <CAP-5=fXTRo=nYoue-e-UvFvm3DD=B=sd0VDm1m0PtxaKo=77yg@mail.gmail.com>
In-Reply-To: <CAP-5=fXTRo=nYoue-e-UvFvm3DD=B=sd0VDm1m0PtxaKo=77yg@mail.gmail.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 28 May 2026 16:46:30 -0700
X-Gm-Features: AVHnY4KubczBXRHAGwNpRZzSgDgxpjNRnJn8M53WCsfTuIPNYpXFEnCes_yqNqI
Message-ID: <CAJpZYjUtLA3PxRH06mopEk2y=FMAjMj0JXvneh7HomjeO0+MwA@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Add IOMMU metrics for AMD and Intel
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Taylor, Perry" <perry.taylor@intel.com>, 
	"Mi, Dapeng1" <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 11:57=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, May 27, 2026 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com>=
 wrote:
> >
> > Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metric=
s
> > to perf jevents for both AMD and Intel platforms. This enhances I/O
> > performance observability, allowing fleet-wide monitoring of IOMMU
> > overhead.
> >
> > For AMD, these metrics are supported on Zen 2 and newer processors and
> > are implemented using the standard `amd_iommu` PMU events. The
> > implementation uses the existing `_zen_model` helper to ensure these ar=
e
> > only generated for Zen 2+.
> >
> > For Intel, these metrics are supported on platforms that expose the
> > required uncore IIO IOMMU events (such as Emerald Rapids and Granite
> > Rapids). The Intel implementation dynamically detects event availabilit=
y
> > at generation time. It requires at least the TLB events to expose the
> > metric group, while the interrupt cache events are optional. This allow=
s
> > platforms like Emerald Rapids, which lack IOMMU interrupt cache events,
> > to still expose the IOMMU TLB metrics.
> >
> > The following metrics are added:
> > - iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
> > - iotlb_total_miss: Total IOTLB misses.
> > - iotlb_miss_rate: IOTLB miss rate.
> > - iotlb_interrupt_cache_hit: Interrupt cache hits.
> > - iotlb_interrupt_cache_miss: Interrupt cache misses (calculated for
> >   Intel as lookup - hit, clamped to zero).
> > - iotlb_interrupt_cache_lookup: Interrupt cache lookups.
> > - iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.
> >
> > Tested:
> >   # perf stat -M iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate --per=
-socket --metric-only -a -j -- sleep 10
> >   {"socket" : "S0", "counters" : 10, "hits  iotlb_total_hit" : "3579249=
.0", "%  iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "3.0"}
> >   {"socket" : "S1", "counters" : 10, "hits  iotlb_total_hit" : "0.0", "=
%  iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "0.0"}
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
>
> +Taylor, Perry, +Mi, Dapeng1
>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> Nit: It may be better to have 2 patches, 1 for Intel and 1 for AMD.

Thanks for the suggestion, please check the v2 patchset in:
lore.kernel.org/20260528234455.434027-1-ctshao@google.com

-CT

>
> Thanks,
> Ian
>
> > ---
> >  tools/perf/pmu-events/amd_metrics.py   | 56 +++++++++++++++++++++++
> >  tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
> >  2 files changed, 118 insertions(+)
> >
> > diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-even=
ts/amd_metrics.py
> > index 971f6e7af1f8..4558e7ce20f2 100755
> > --- a/tools/perf/pmu-events/amd_metrics.py
> > +++ b/tools/perf/pmu-events/amd_metrics.py
> > @@ -265,6 +265,61 @@ def AmdDtlb() -> Optional[MetricGroup]:
> >      ], description=3D"Data TLB metrics")
> >
> >
> > +def AmdIotlb() -> Optional[MetricGroup]:
> > +  global _zen_model
> > +  if _zen_model < 2:
> > +    return None
> > +
> > +  total_hit =3D Event("amd_iommu/mem_iommu_tlb_pte_hit/") + Event(
> > +      "amd_iommu/mem_iommu_tlb_pde_hit/"
> > +  )
> > +  total_miss =3D Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
> > +      "amd_iommu/mem_iommu_tlb_pde_mis/"
> > +  )
> > +  miss_rate =3D d_ratio(total_miss, total_miss + total_hit)
> > +
> > +  interrupt_cache_hit =3D Event("amd_iommu/int_dte_hit/")
> > +  interrupt_cache_miss =3D Event("amd_iommu/int_dte_mis/")
> > +  interrupt_cache_lookup =3D interrupt_cache_hit + interrupt_cache_mis=
s
> > +  interrupt_cache_miss_rate =3D d_ratio(
> > +      interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
> > +  )
> > +
> > +  return MetricGroup(
> > +      "iotlb",
> > +      [
> > +          Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hit=
s"),
> > +          Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "=
misses"),
> > +          Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100=
%"),
> > +          Metric(
> > +              "iotlb_interrupt_cache_hit",
> > +              "IOTLB interrupt cache hit",
> > +              interrupt_cache_hit,
> > +              "hits",
> > +          ),
> > +          Metric(
> > +              "iotlb_interrupt_cache_miss",
> > +              "IOTLB interrupt cache miss",
> > +              interrupt_cache_miss,
> > +              "misses",
> > +          ),
> > +          Metric(
> > +              "iotlb_interrupt_cache_lookup",
> > +              "IOTLB interrupt cache lookup",
> > +              interrupt_cache_lookup,
> > +              "lookups",
> > +          ),
> > +          Metric(
> > +              "iotlb_interrupt_cache_miss_rate",
> > +              "IOTLB interrupt cache miss rate",
> > +              interrupt_cache_miss_rate,
> > +              "100%",
> > +          ),
> > +      ],
> > +      description=3D"IOMMU TLB metrics",
> > +  )
> > +
> > +
> >  def AmdItlb():
> >      global _zen_model
> >      l2h =3D Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit"=
)
> > @@ -473,6 +528,7 @@ def main() -> None:
> >          AmdBr(),
> >          AmdCtxSw(),
> >          AmdDtlb(),
> > +        AmdIotlb(),
> >          AmdItlb(),
> >          AmdLdSt(),
> >          AmdUpc(),
> > diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-ev=
ents/intel_metrics.py
> > index 52035433b505..c3a5c2965f74 100755
> > --- a/tools/perf/pmu-events/intel_metrics.py
> > +++ b/tools/perf/pmu-events/intel_metrics.py
> > @@ -457,6 +457,67 @@ def IntelIlp() -> MetricGroup:
> >      ])
> >
> >
> > +def IntelIotlb() -> Optional[MetricGroup]:
> > +  try:
> > +    total_hit =3D (
> > +        Event("UNC_IIO_IOMMU0.4K_HITS")
> > +        + Event("UNC_IIO_IOMMU0.2M_HITS")
> > +        + Event("UNC_IIO_IOMMU0.1G_HITS")
> > +    )
> > +    total_miss =3D Event("UNC_IIO_IOMMU0.MISSES")
> > +  except:
> > +    return None
> > +
> > +  miss_rate =3D d_ratio(total_miss, total_miss + total_hit)
> > +  metrics =3D [
> > +      Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
> > +      Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "miss=
es"),
> > +      Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
> > +  ]
> > +
> > +  try:
> > +    interrupt_cache_hit =3D Event("UNC_IIO_IOMMU3.INT_CACHE_HITS")
> > +    interrupt_cache_lookup =3D Event("UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS=
")
> > +    interrupt_cache_miss =3D max(interrupt_cache_lookup - interrupt_ca=
che_hit, 0)
> > +    interrupt_cache_miss_rate =3D d_ratio(
> > +        interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_h=
it
> > +    )
> > +    metrics +=3D [
> > +        Metric(
> > +            "iotlb_interrupt_cache_hit",
> > +            "IOTLB interrupt cache hit",
> > +            interrupt_cache_hit,
> > +            "hits",
> > +        ),
> > +        Metric(
> > +            "iotlb_interrupt_cache_miss",
> > +            "IOTLB interrupt cache miss",
> > +            interrupt_cache_miss,
> > +            "misses",
> > +        ),
> > +        Metric(
> > +            "iotlb_interrupt_cache_lookup",
> > +            "IOTLB interrupt cache lookup",
> > +            interrupt_cache_lookup,
> > +            "lookups",
> > +        ),
> > +        Metric(
> > +            "iotlb_interrupt_cache_miss_rate",
> > +            "IOTLB interrupt cache miss rate",
> > +            interrupt_cache_miss_rate,
> > +            "100%",
> > +        ),
> > +    ]
> > +  except:
> > +    pass
> > +
> > +  return MetricGroup(
> > +      "iotlb",
> > +      metrics,
> > +      description=3D"IOMMU TLB metrics",
> > +  )
> > +
> > +
> >  def IntelL2() -> Optional[MetricGroup]:
> >      try:
> >          DC_HIT =3D Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
> > @@ -1105,6 +1166,7 @@ def main() -> None:
> >          IntelCtxSw(),
> >          IntelFpu(),
> >          IntelIlp(),
> > +        IntelIotlb(),
> >          IntelL2(),
> >          IntelLdSt(),
> >          IntelMissLat(),
> > --
> > 2.54.0.823.g6e5bcc1fc9-goog
> >
