Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F437184A
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228850; cv=none; b=gTGmm3v+jxdQMwtlGAxvoeUEiwo8zO5zv+pDkOgXQHKPFT6Ak2f4jA5Zi29z8ZRoU3vEnmpCwfvuTmmyGmWgfO0g33ZO/VBm6TA2CEQz0PJYP++q1DeuMpZjQnOetbyT0Se4wqxdEEjGzVn/ICLymOgpvK4oyBwcWM+XS8w0unM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228850; c=relaxed/simple;
	bh=aBHHuNeOpCANk63c20paICARa8pbNcOHO7tuK++WAUg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u0QjmnpKmpR7YBeI5Sc3/lIqt5GZj2UEJGN2Oas6xrs0Yv8VIfxPwqBalUvqjD5CA3zvXPGMXM0MjCfwSbDlIWZcgLQWNlNMVnQQi3Ae5KLbKD+EQGSj+x7i8WkfBgKQSoGG7txN2ghs95pNchP1WyB3M4Mh3lxO9/qvFU06xlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oozeGwe2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oozeGwe2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7901F000FF;
	Thu, 24 Sep 2026 05:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228848;
	bh=OnM1dMAhcLFTLHhELnVgeUFvp8Vj0nJ2/ewoZQBJbyA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oozeGwe2tl3H/Or9f0OyxiOfDceBgJDc+006iyhs529+4m7fQKTiOrkTm1GzP+S18
	 xDpNnz3oq/GbIko6tYCnrv9VybEbplUoZ+bQEnjAAmWVuTAJMC80EpW12t/Ig+UOyZ
	 Q8h/oJ+ybPTatLlGs4bJSXPSzQilCe5roDjewiWCcZ1gSxw9RxAhOfevTSlgnnoJti
	 /ctfZBGPG/x9dK8adbRgj9HtSvpC6kgIC9t2JlPxzE5Khe68xrDNArrzY8d3JYHIRO
	 SSFxDMbYhni/TSSklxzSR4PWmZwMk3FWNy1/DeQ+L5Go8pSaTxdSusTGRkERLDPisM
	 86CA6jgcd1olA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 18/21] perf vendor events intel: Update sandybridge
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-19-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-19-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:47:28 +0000
Message-Id: <20260924054728.BD7901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint in tma_l3_miss_boun=
d metric
- [Low] perf: dangling metric references in PublicDescription on Sandybridge
--

commit 1084156951c4d64330b35bda1bdc7630ed3bc441
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update sandybridge metrics to TMA 5.2

This commit updates the Intel Sandybridge metrics to TopDown Microarchitect=
ure
Analysis (TMA) version 5.2. The update incorporates new metric groups, adds
new metrics, and modifies existing metric expressions and descriptions.

> diff --git a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json =
b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> index d407619034292..48f9ccc0a7275 100644
> --- a/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json

[ ... ]

> @@ -316,7 +306,7 @@
>          "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_=
REQUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
>          "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
>          "MetricName": "tma_info_system_dram_bw_use",
> -        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
> +        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_mem_bandwidth, tma_uc_bou=
nd"

[Severity: Low]
Does this description introduce a dangling reference? The PublicDescription
adds a reference to tma_uc_bound, but this metric does not appear to be
defined for the Sandybridge architecture, which could result in dead metric
links when users query it in the perf tool.

>      },
>      {
>          "BriefDescription": "Giga Floating Point Operations Per Second",

[ ... ]

> @@ -431,7 +421,16 @@
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
PS_RETIRED.LLC_HIT + 7 * MEM_LOAD_UOPS_MISC_RETIRED.LLC_MISS)) * CYCLE_ACTI=
VITY.STALLS_L2_PENDING / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Is the "MetricConstraint": "NO_GROUP_EVENTS_SMT" attribute missing here?

The replaced tma_dram_bound metric included this constraint because the
underlying hardware events (like MEM_LOAD_UOPS_RETIRED.LLC_HIT and
CYCLE_ACTIVITY.STALLS_L2_PENDING) have PMU grouping restrictions on
Sandybridge when SMT is enabled.

Without this constraint, will perf stat attempt to group these events and
cause PMU scheduling failures?

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
>          "ScaleUnit": "100%"
>      },
>      {

[ ... ]

> @@ -508,7 +507,7 @@
>          "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fet=
ch_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
>          "MetricName": "tma_ms_switches",
>          "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric estimates the fraction of cycl=
es when the CPU was stalled due to switches of uop delivery to the Microcod=
e Sequencer (MS). Commonly used instructions are optimized for delivery by =
the DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Ce=
rtain operations cannot be handled natively by the execution pipeline; and =
must be performed by microcode (small programs injected into the execution =
stream). Switching to the MS too often can negatively impact performance. T=
he MS is designated to deliver long uop flows required by CISC instructions=
 like CPUID; or uncommon conditions like Floating Point Assists when dealin=
g with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears=
_resteers, tma_l1_bound, tma_machine_clears, tma_microcode_sequencer, tma_m=
ixing_vectors, tma_serializing_operation",
> +        "PublicDescription": "This metric estimates the fraction of cycl=
es when the CPU was stalled due to switches of uop delivery to the Microcod=
e Sequencer (MS). Commonly used instructions are optimized for delivery by =
the DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Ce=
rtain operations cannot be handled natively by the execution pipeline; and =
must be performed by microcode (small programs injected into the execution =
stream). Switching to the MS too often can negatively impact performance. T=
he MS is designated to deliver long uop flows required by CISC instructions=
 like CPUID; or uncommon conditions like Floating Point Assists when dealin=
g with Denormals. Sample with: IDQ.MS_SWITCHES. Related metrics: tma_clears=
_resteers, tma_info_inst_mix_vectormixpki, tma_l1_bound, tma_machine_clears=
, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing_operation",

[Severity: Low]
Could this description introduce another missing metric reference?

The related metrics list in the PublicDescription adds
tma_info_inst_mix_vectormixpki, which is absent from the Sandybridge metric
definitions.

>          "ScaleUnit": "100%"
>      },
>      {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D18
