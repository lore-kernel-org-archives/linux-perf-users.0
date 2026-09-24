Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9523B7769
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228876; cv=none; b=BedXxhfCIXoEya1eIuJpct+nWFXBGkL13tiotoHMBeGkHzVi/0HSo/Bzm0pcoY4BVrDmM4lzRvPWg3GrchRj8fxLS88JssSf6OHDhJAsKUh91njliE+QJKHsQ0dcwsPf2xxXSwT5qIpLppxhaZReeOMIhCQnTwgPJ/I5Vy6dZr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228876; c=relaxed/simple;
	bh=r8m19T+56QFCLdt08UBc/65Fs1Bbigq56sR9HoqSg/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uzRLg6u7sAe7F7XiCAqp6uyzP/SdukrtLsmKTkrV/lIz6cjTW2INjYeZcYEWMIVlEMCRoFahZD2cEyp4LU1h44k3yGSaYlMrVH/ubRfT812W3vsN1LauwYxMLbgD1SZ6I0f9qtU4JTxUGNJ5wBQX/O6ANTBpawWu9W5nnxmZh8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1Vganjt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1Vganjt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D9ED1F000FF;
	Thu, 24 Sep 2026 05:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228874;
	bh=LjCka4rlmg6VKmZCNZSdTYIjTKNkhF0i8CRAOISd4fg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B1VganjtcN/GgnrsaFGXKVrTfuWqU9CDeVkAVC8DcvrXrLlodTF/thLBRVzM+D0xI
	 p69C5iY0uxOFmhApsOa5Ye+P8tS8iOnQLxu/gawsFAiuvUgxg59ZNq6+wGAUbJT3Ao
	 yEh9rE9KDgOU0xwQ6eyfBQHGUhj90RqgL27jxh2/K0wE7iR4RS1ZBt1VQx1TSjQQBQ
	 MS4SvMdG75fr0VWMxSXPxoHLqBAuHCHwXI4VQK2CVxvXekEQfTcyxcHdRzP4YrzgnJ
	 r2mtglL0e5oQb634qMNHVYz8HiKrpED7HUDrpJP0a1rxvVhRIN0JCoDRRcFfEqS3k1
	 eC25modNKAf8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 13/21] perf vendor events intel: Update jaketown
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-14-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:47:54 +0000
Message-Id: <20260924054754.7D9ED1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] perf metrics: missing NO_GROUP_EVENTS_SMT for tma_l3_miss_bound
--

commit b6a94b133ee628d16532e78da446a1ec3a1e7b5a
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update jaketown metrics to TMA 5.2

The updated TMA metrics were published in:

  https://github.com/intel/perfmon/commit/f9358e8da04bec945d8023e3f9b20a887=
ad46c45

> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> index 250c73b213854..79000eb55dd85 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json

[ ... ]

> @@ -452,7 +436,16 @@
>          "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
>          "MetricName": "tma_l3_bound",
>          "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to loads accesses to L3 cache or contended with a sibling Cor=
e.  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency =
and increase performance. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to loads accesses to L3 cache or contended with a sibling Cor=
e.  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency =
and increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.LLC_HIT / (MEM_LOAD_UO=
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_RETIRED.LLC_MISS)) * CYCLE_ACTIVITY.=
STALLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Should this new tma_l3_miss_bound metric include the "MetricConstraint":
"NO_GROUP_EVENTS_SMT" property?

When SMT is enabled on Jaketown processors, missing this constraint can cau=
se
perf stat to attempt grouping these hardware events. Due to PMU limitations,
this can fail scheduling or produce incorrectly multiplexed counts.

The previous metric it seemingly replaces, tma_dram_bound, had this
constraint.

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D13
