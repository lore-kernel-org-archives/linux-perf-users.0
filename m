Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EAC3F4DDA
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270098; cv=none; b=GAL0QNaskFTDL3t6AWY7rHDEY3pWZmnFTUiH1ink85J5t80m8wP/VdaOulLtpoOi56x4vFOC6QaEokY+vqvsDnyv2w88GoZp2USS3qK49IOUBBx7Z7+JgTd98CW55Hg5fhOjV/KqHv7NIR0bDRsmvZOAZz2zCHMjNZ0cZ9UbkOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270098; c=relaxed/simple;
	bh=PBR5Q/601tMcLkfMBkKfSIdkArnyXAEfDulaTX+llGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dm6adFk6VLO/cZq4Q9qJBH2VReRp86DFVz2ysKcHo4/r2+1Vu+ZH0bjZtVLZOK6Lj+p6IInTNwJbCEVK5L35vT6SpX+1IQv3AFXIEgecAfDB857LUMwTvHgR2C7InPVphNwks7ekns5btTDQKVbT4ACI9WbUPt7K6rEAEQDMJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpVlxeDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpVlxeDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76521F000FF;
	Thu, 24 Sep 2026 17:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270096;
	bh=M2IlCizizzta0mEvOq6BZHiPweG2EbE6MSIpgVVjWak=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpVlxeDw68Rz/b+xCs8UYJ9Am5uAtCTXaab2nSLO9I5V+K8l6FuHIonc6zgOd0UFa
	 Y8XTIqpQjwcZswB0PJpLjQ/+eTSLOqw2dTia2EMf7hzoGRhWrI2699vT5Vb81nIppm
	 EUNAU/dPRA04jX6VxDVVvkz3YHMDQQhyf35rTw21Jx9bLutFpIYvqIrZOdypFCw5eV
	 c2qPqkxD9Iz+iV0TdnONGNuWK0bRCvD0gcqnzZqNm9/I4D6VTIov+7Jc3zP05JjeG5
	 MLshE1/4DNnOIk3E6Gg/anjMaeuzMep8WwiYcgedhFJ8PNZ8UvYwM2L/18yUbD9Uvu
	 Lh19Z9n2yLcvg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/26] perf vendor events intel: Update haswell
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-9-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-9-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:14:55 +0000
Message-Id: <20260924171456.C76521F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint in tma_l3_miss_boun=
d on Haswell
--

commit e9f96bf30aae3b71b40593d38b7093237a60c426
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update haswell metrics to TMA 5.2

This patch updates the Haswell and Haswell-X metrics to TMA 5.2. It replaces
several older metrics, including the tma_dram_bound metric, with the new
tma_l3_miss_bound metric.

> diff --git a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json b/to=
ols/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> index aebd82ced1cff..ab4ec55602235 100644
> --- a/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json

[ ... ]

> @@ -669,7 +659,16 @@
>          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueL=
at;tma_l3_bound_group",
>          "MetricName": "tma_l3_hit_latency",
>          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0=
.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metr=
ics: tma_mem_latency",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: =
tma_mem_latency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOP=
S_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STA=
LLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Does this new metric need the "MetricConstraint": "NO_GROUP_EVENTS_SMT"
entry?

The tma_l3_miss_bound metric uses MEM_LOAD_UOPS_RETIRED.* events that are
affected by an HT bug on Haswell and require exclusive hardware counter acc=
ess.

If they are grouped together while SMT is enabled, perf stat group scheduli=
ng
can fail, resulting in <not counted> instead of metric results.

The previous metric it replaced (tma_dram_bound) correctly specified this
constraint to prevent this grouping failure, and a sibling metric
(tma_l3_bound) using the same events still retains it.

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
>          "ScaleUnit": "100%"
>      },
>      {

> diff --git a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> index b8845f8a28b95..b8eb27da46ccf 100644
> --- a/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json

[ ... ]

> @@ -892,7 +876,16 @@
>          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueL=
at;tma_l3_bound_group",
>          "MetricName": "tma_l3_hit_latency",
>          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0=
.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metr=
ics: tma_mem_latency",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: =
tma_mem_latency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOP=
S_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STA=
LLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Would this metric also need the "MetricConstraint": "NO_GROUP_EVENTS_SMT"
entry for the same reason?

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
>          "ScaleUnit": "100%"
>      },
>      {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D8
