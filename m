Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA932FA3C
	for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994652; cv=pass; b=DKq0KRBje4JphV+R7EsF/sskrwCV8L9phfw9J0hXP8yHTbyLv3EbqYaZXJPqIWQ5JxYREeGLRtD3hISR4ZC6xWCLa2AeVQasGGbXdCgNgUCoeEBZnGEaUaUo8CNCz47RyUGR4gMt+oOxfGdc5Euu/vUuBw15vUvmQePpdCD6VQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994652; c=relaxed/simple;
	bh=1vmu/Bfvp2W1SJ+AdIKbaoKE21e74Zlyc14lOgqsKQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CT9Bn490nTb7oyCrFCWa08F7ehH7a3CiC98HPuL3BtWb4aYFy1TDmCk5tKP1rlc05YWcCpWHj8mCM4skabZi/y/u6fE/qXuOXLmjr1gHLN43gHEV9TUWP8E+FANjRXo1EZ1MSE3Pf5/bzrB2chHYJjZq0SsCFl5NGNnmOiZa1Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fV0tGhEF; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fV0tGhEF"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ba180a022dso685ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 28 May 2026 11:57:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779994650; cv=none;
        d=google.com; s=arc-20240605;
        b=h9dxgLjfjTzBUEz3v3NCHeYx7UUTfzmIHxPhKF3ZsWd2+7eEs2GQyNcwiYs19nK/Fc
         On0GCErYqx2JHhFDWjXJtJYveJXrImnWP3ZwLLKIK0IBxlRaP4o5YYzIQthjtiVJdtJI
         iNGaf0LcrQVII1WvPROnT0hdhiUgEVW+xM8uaDotR5ii31ggrS+KCpM9HK1f3SfqdPqO
         tU+XBKEnpNedDQy8JnIc43SgqEb5cebtftdseStCaQ+SaBgLeDjFGVqtI0rYHEGftQa9
         zm0Qm4HN9l9onlyYwhGoY6ImWpdwWAhv3eFIWzDPAoKsbPQODpZa4+bg6Po8ZuqRyuns
         s7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CjdDq7vYHR8fX0qtYCUiCkr7KhheLzVgFpHo15St/kY=;
        fh=dQbUi58L6axqHT1MbgZjZaZTiiBBFuseb65TAiOV+H0=;
        b=Yw49g3P7z3UAflUUPAkIsHPQGB9+joBZRE/GvM4IH3DCi+mUH5yHKBR3rDx1XQ+pfu
         FHCw94iDoLKez7xX1CuN8Apd+on9eHSxeOdFbaoMWzJHZXr+duT8Sw5Fllu73nQ2FOda
         nqulJMAchu/78Y3GzpOnIBUDPjkaDuJPj8kFCxlPk8wzIyfXj7k/4XXGEaOx7JzPya3a
         Jtzvo5s5yHYR8vkYoAgoMlIp2u0uWJwOqgVu7cVpbkc/lmPREx1pUmWym7yqEAFBADBa
         0W0Y1g6VFHc0Hl/WS5KEHC6jlfuE+zqs6Rq1gXVkwofkIvPg28Jmmwwg80QLGap8uODq
         4oQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779994650; x=1780599450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjdDq7vYHR8fX0qtYCUiCkr7KhheLzVgFpHo15St/kY=;
        b=fV0tGhEFihyGGou0W/i2Xdrso4/WiMyRMJjjGSzWF5T1h/wS/SV6htwYzIvqGql30p
         x6UM0TcXwUB6y/e0XqLCaOOjh7EeUvk8Mgd+LoWQg6QX/tSpkCp/plnbVlKV/GL6lVZx
         UHTQKPM/9CtPJikUMYO7h0u/lPqSG2P9cEgPi4pUARbfAtB5jz04vqVabFbg5aDJ5e0B
         2F8053SYjAwLKWahHCnO3LHJpcBUJKeKqxaWvGMP9bfRq8UbLBu4qfm5KoWRIfPCX9Rs
         QQsI3x8tgEBqhELZ5hq5bhi/QDZQF1uXT/S9mPtPzOn30cBXu8LSppvZ8vBW3eT7ggTB
         lNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779994650; x=1780599450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CjdDq7vYHR8fX0qtYCUiCkr7KhheLzVgFpHo15St/kY=;
        b=H7YDC5xHyGPeejfMANlm7h9l80deYZXl0c33oT64ZE25UmeX7bL/LXJ6M4a6nAqxeH
         pyJT0lU/tkogAZ//fgroMYP2sRnpHGghcRWzKzQ/0fXg4cU9RuqbypQgEzNlKdsMZIF6
         YUCp31y4uo4EIZYeRgtfEhDly3JOHxqlgBNiY/exqlzbvSBSWLVIX62iwQ4LXW3ALIX0
         uANK6Qq9wGdlNSFUe/nLCJjROcpc1t4Ow+DQusCCBhF9MyWjJCJsr9nhkMWaGYzTuQev
         kYG2xJljP55thyfeRIPs+pE2Rl3IXDpm9S5Oyy2N4aOPeRgHMazsQNUDWxO/KnUcTOsu
         +nlQ==
X-Forwarded-Encrypted: i=1; AFNElJ9s4qr2jB0gwIjQWbIlbPauBEVdazS01NmxVEVNCnk86qUcSQfeFH+rLKie1dctbKtvun5Qgp8HadaCP95NhUuM@vger.kernel.org
X-Gm-Message-State: AOJu0YzUlUjrIjmyKcdyU0yIQl1rNmER17jv1OZFwY2doiiPK5Sq1zx1
	b6JV+7EsP0OuGkOh5ZJ7KhJHATKRJallLAIrbrlpev0essHG5O+bsA5R95tEJMs1qFhAFpxbbo5
	jPe0h8mTLK6enB06XIfPU2C0L3WADrBEPm6jGcFLTL6YNS2nSDjw7tev3
X-Gm-Gg: Acq92OHqdwsp116WZu9pnUH2xvsupGT0lp+789qm49ARX5LPBxqzKPBNQffWiDCq5c3
	/jHGZyg5LmsBUUU0FQIx97QziXGPKtd5vF1s2kLLujXPTGaFGtvLn9n76s6/mJV55xl57fFJn6i
	QTHtz6GsNB5NUYpm2MAs50HtHz+qZnKxUgh2k8vLMJ18+pHoYswyerGzdB06wtsccLNfBh5HnvA
	xOtRgtCch7ASbwFYlzrY8yMl5k5LwL4qbQjvhtUDP5Qz/9XqyCnnKbZHK3MCFDtTACYvahoMjde
	5lemsOetUwGnb9RHFmw=
X-Received: by 2002:a17:903:2383:b0:2bf:1153:54a0 with SMTP id
 d9443c01a7336-2bf1f0886edmr28855ad.23.1779994649766; Thu, 28 May 2026
 11:57:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260527223917.3845056-1-ctshao@google.com>
In-Reply-To: <20260527223917.3845056-1-ctshao@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 28 May 2026 11:57:18 -0700
X-Gm-Features: AVHnY4LUs1ZNpyG9vEUpVykCxGK2gYZZvyO2YPSMs5Ajp4wXs-oFjy816YkF1_s
Message-ID: <CAP-5=fXTRo=nYoue-e-UvFvm3DD=B=sd0VDm1m0PtxaKo=77yg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Add IOMMU metrics for AMD and Intel
To: Chun-Tse Shao <ctshao@google.com>
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

On Wed, May 27, 2026 at 3:39=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Add IOMMU Translation Lookaside Buffer (TLB) and interrupt cache metrics
> to perf jevents for both AMD and Intel platforms. This enhances I/O
> performance observability, allowing fleet-wide monitoring of IOMMU
> overhead.
>
> For AMD, these metrics are supported on Zen 2 and newer processors and
> are implemented using the standard `amd_iommu` PMU events. The
> implementation uses the existing `_zen_model` helper to ensure these are
> only generated for Zen 2+.
>
> For Intel, these metrics are supported on platforms that expose the
> required uncore IIO IOMMU events (such as Emerald Rapids and Granite
> Rapids). The Intel implementation dynamically detects event availability
> at generation time. It requires at least the TLB events to expose the
> metric group, while the interrupt cache events are optional. This allows
> platforms like Emerald Rapids, which lack IOMMU interrupt cache events,
> to still expose the IOMMU TLB metrics.
>
> The following metrics are added:
> - iotlb_total_hit: Total IOTLB hits (4K, 2M, 1G pages).
> - iotlb_total_miss: Total IOTLB misses.
> - iotlb_miss_rate: IOTLB miss rate.
> - iotlb_interrupt_cache_hit: Interrupt cache hits.
> - iotlb_interrupt_cache_miss: Interrupt cache misses (calculated for
>   Intel as lookup - hit, clamped to zero).
> - iotlb_interrupt_cache_lookup: Interrupt cache lookups.
> - iotlb_interrupt_cache_miss_rate: Interrupt cache miss rate.
>
> Tested:
>   # perf stat -M iotlb_total_hit,iotlb_total_miss,iotlb_miss_rate --per-s=
ocket --metric-only -a -j -- sleep 10
>   {"socket" : "S0", "counters" : 10, "hits  iotlb_total_hit" : "3579249.0=
", "%  iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "3.0"}
>   {"socket" : "S1", "counters" : 10, "hits  iotlb_total_hit" : "0.0", "% =
 iotlb_miss_rate" : "0.0", "misses  iotlb_total_miss" : "0.0"}
>
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview

+Taylor, Perry, +Mi, Dapeng1

Reviewed-by: Ian Rogers <irogers@google.com>

Nit: It may be better to have 2 patches, 1 for Intel and 1 for AMD.

Thanks,
Ian

> ---
>  tools/perf/pmu-events/amd_metrics.py   | 56 +++++++++++++++++++++++
>  tools/perf/pmu-events/intel_metrics.py | 62 ++++++++++++++++++++++++++
>  2 files changed, 118 insertions(+)
>
> diff --git a/tools/perf/pmu-events/amd_metrics.py b/tools/perf/pmu-events=
/amd_metrics.py
> index 971f6e7af1f8..4558e7ce20f2 100755
> --- a/tools/perf/pmu-events/amd_metrics.py
> +++ b/tools/perf/pmu-events/amd_metrics.py
> @@ -265,6 +265,61 @@ def AmdDtlb() -> Optional[MetricGroup]:
>      ], description=3D"Data TLB metrics")
>
>
> +def AmdIotlb() -> Optional[MetricGroup]:
> +  global _zen_model
> +  if _zen_model < 2:
> +    return None
> +
> +  total_hit =3D Event("amd_iommu/mem_iommu_tlb_pte_hit/") + Event(
> +      "amd_iommu/mem_iommu_tlb_pde_hit/"
> +  )
> +  total_miss =3D Event("amd_iommu/mem_iommu_tlb_pte_mis/") + Event(
> +      "amd_iommu/mem_iommu_tlb_pde_mis/"
> +  )
> +  miss_rate =3D d_ratio(total_miss, total_miss + total_hit)
> +
> +  interrupt_cache_hit =3D Event("amd_iommu/int_dte_hit/")
> +  interrupt_cache_miss =3D Event("amd_iommu/int_dte_mis/")
> +  interrupt_cache_lookup =3D interrupt_cache_hit + interrupt_cache_miss
> +  interrupt_cache_miss_rate =3D d_ratio(
> +      interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
> +  )
> +
> +  return MetricGroup(
> +      "iotlb",
> +      [
> +          Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"=
),
> +          Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "mi=
sses"),
> +          Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"=
),
> +          Metric(
> +              "iotlb_interrupt_cache_hit",
> +              "IOTLB interrupt cache hit",
> +              interrupt_cache_hit,
> +              "hits",
> +          ),
> +          Metric(
> +              "iotlb_interrupt_cache_miss",
> +              "IOTLB interrupt cache miss",
> +              interrupt_cache_miss,
> +              "misses",
> +          ),
> +          Metric(
> +              "iotlb_interrupt_cache_lookup",
> +              "IOTLB interrupt cache lookup",
> +              interrupt_cache_lookup,
> +              "lookups",
> +          ),
> +          Metric(
> +              "iotlb_interrupt_cache_miss_rate",
> +              "IOTLB interrupt cache miss rate",
> +              interrupt_cache_miss_rate,
> +              "100%",
> +          ),
> +      ],
> +      description=3D"IOMMU TLB metrics",
> +  )
> +
> +
>  def AmdItlb():
>      global _zen_model
>      l2h =3D Event("bp_l1_tlb_miss_l2_tlb_hit", "bp_l1_tlb_miss_l2_hit")
> @@ -473,6 +528,7 @@ def main() -> None:
>          AmdBr(),
>          AmdCtxSw(),
>          AmdDtlb(),
> +        AmdIotlb(),
>          AmdItlb(),
>          AmdLdSt(),
>          AmdUpc(),
> diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-even=
ts/intel_metrics.py
> index 52035433b505..c3a5c2965f74 100755
> --- a/tools/perf/pmu-events/intel_metrics.py
> +++ b/tools/perf/pmu-events/intel_metrics.py
> @@ -457,6 +457,67 @@ def IntelIlp() -> MetricGroup:
>      ])
>
>
> +def IntelIotlb() -> Optional[MetricGroup]:
> +  try:
> +    total_hit =3D (
> +        Event("UNC_IIO_IOMMU0.4K_HITS")
> +        + Event("UNC_IIO_IOMMU0.2M_HITS")
> +        + Event("UNC_IIO_IOMMU0.1G_HITS")
> +    )
> +    total_miss =3D Event("UNC_IIO_IOMMU0.MISSES")
> +  except:
> +    return None
> +
> +  miss_rate =3D d_ratio(total_miss, total_miss + total_hit)
> +  metrics =3D [
> +      Metric("iotlb_total_hit", "IOTLB total hit", total_hit, "hits"),
> +      Metric("iotlb_total_miss", "IOTLB total miss", total_miss, "misses=
"),
> +      Metric("iotlb_miss_rate", "IOTLB miss rate", miss_rate, "100%"),
> +  ]
> +
> +  try:
> +    interrupt_cache_hit =3D Event("UNC_IIO_IOMMU3.INT_CACHE_HITS")
> +    interrupt_cache_lookup =3D Event("UNC_IIO_IOMMU3.INT_CACHE_LOOKUPS")
> +    interrupt_cache_miss =3D max(interrupt_cache_lookup - interrupt_cach=
e_hit, 0)
> +    interrupt_cache_miss_rate =3D d_ratio(
> +        interrupt_cache_miss, interrupt_cache_miss + interrupt_cache_hit
> +    )
> +    metrics +=3D [
> +        Metric(
> +            "iotlb_interrupt_cache_hit",
> +            "IOTLB interrupt cache hit",
> +            interrupt_cache_hit,
> +            "hits",
> +        ),
> +        Metric(
> +            "iotlb_interrupt_cache_miss",
> +            "IOTLB interrupt cache miss",
> +            interrupt_cache_miss,
> +            "misses",
> +        ),
> +        Metric(
> +            "iotlb_interrupt_cache_lookup",
> +            "IOTLB interrupt cache lookup",
> +            interrupt_cache_lookup,
> +            "lookups",
> +        ),
> +        Metric(
> +            "iotlb_interrupt_cache_miss_rate",
> +            "IOTLB interrupt cache miss rate",
> +            interrupt_cache_miss_rate,
> +            "100%",
> +        ),
> +    ]
> +  except:
> +    pass
> +
> +  return MetricGroup(
> +      "iotlb",
> +      metrics,
> +      description=3D"IOMMU TLB metrics",
> +  )
> +
> +
>  def IntelL2() -> Optional[MetricGroup]:
>      try:
>          DC_HIT =3D Event("L2_RQSTS.DEMAND_DATA_RD_HIT")
> @@ -1105,6 +1166,7 @@ def main() -> None:
>          IntelCtxSw(),
>          IntelFpu(),
>          IntelIlp(),
> +        IntelIotlb(),
>          IntelL2(),
>          IntelLdSt(),
>          IntelMissLat(),
> --
> 2.54.0.823.g6e5bcc1fc9-goog
>
