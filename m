Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB00371D1F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269985; cv=none; b=nAIv5F4dwv2KVzr9TZehxytZduPCO6MsyPawAiIkvUfn5CA1ftwVqFWGmk/oyQj2RcAdt1NIxND/uespJGEFBy4Finmi73sNws3p3TqvDrswo556UKkxAzTqYHxbynQAnozgMoxrfpS3giE8c1IppD1JNr1rmEks6EhzYXw2f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269985; c=relaxed/simple;
	bh=wW2izc6hwuIUVBa6taKnnCyhGSh7zTdlIjcZYd7Nzgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWY78viZDsTEA3lSlqCcyBcB1/FhZUGSgNjncrHoqRwf0IVBElmXR5PSVx47ChABnl5d5MmEAy5yPOMLFSX7LzqF+qfd/7zjt73Z9Gu1HIloOCM+E51mcRV7oegFKKgXEwE7Sob85GhpoXVG+QnIV9psdc5i9a/jq+jdasrTOUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/Jjk4WS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/Jjk4WS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E682C1F000FF;
	Thu, 24 Sep 2026 17:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790269984;
	bh=wf+clukzxa3IH1GGLhDfVPxQcUddOlutNjG9t98hEBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/Jjk4WS9gG2WcCTkEFFoU7MKjQr6dGu+hu9qmWdnhCQG1cG+9uhBiVJ3ezTaErHP
	 l5Eimb/3MKHLG/bajJvlu+YifG2B3J5/9kSyxFvJOPNvFGKwWixw2+7G6YqOgNIbqR
	 okBkcUbc11UR9f8LrEKevjol/Z/7I0MmyT28Q/Ov6YLD7lhMg8QvKj71wHzFyFJpHW
	 qsncgBwavFNqsMil8RHoLpcvRZk/xYABG4/4jI554tfSouqslVZMKftsQRjAsBfdGS
	 ruwwPQTE6ZR61vzGVhauoGz0VSvO6coY0AiSGnOSdQ/mBO+YPnScJG+OgfRurxsrx5
	 rytyY/3DyW7Yw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/26] perf vendor events intel: Update jaketown
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-14-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:13:03 +0000
Message-Id: <20260924171303.E682C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss_bou=
nd
- [Low] perf: metric Sample with documentation references invalid events
- [Low] perf: dangling metric and metric group references in Jaketown
--

commit 2ec93750ef45abe8da656d3529a32a0709b570c7
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update jaketown metrics to TMA 5.2

This commit updates the Jaketown metrics to TMA 5.2. It replaces and=20
adjusts several metrics, thresholds, and descriptions to align with the
latest Intel perfmon definitions.

> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json b/t=
ools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> index 250c73b213854..79000eb55dd85 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json

[ ... ]

> @@ -316,7 +306,7 @@
>          "MetricExpr": "64 * (UNC_M_CAS_COUNT.RD + UNC_M_CAS_COUNT.WR) / =
1e9 / tma_info_system_time",
>          "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
>          "MetricName": "tma_info_system_dram_bw_use",
> -        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_mem_bandwidth"
> +        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_mem_bandwidth, tma_uc_bou=
nd"

[Severity: Low]
Does this documentation refer to a dangling metric?

The newly added related metric tma_uc_bound is not defined for the Jaketown
architecture, which will create a broken documentation link within the tool.

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

[Severity: Low]
Does this Sample with string direct users to a non-existent event?

The suggested command uses MEM_LOAD_RETIRED.L3_HIT_PS, but the Jaketown PMU
does not define events with the MEM_LOAD_RETIRED prefix (they use
MEM_LOAD_UOPS_RETIRED.*). This will cause perf record errors if a user
attempts to copy-paste the suggested command.

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
Is the NO_GROUP_EVENTS_SMT constraint missing for tma_l3_miss_bound?

When profiling with SMT enabled on Jaketown, perf will attempt to group the
event. Without this constraint, this causes PMU event scheduling failures or
0 counts. This metric uses CYCLE_ACTIVITY.STALLS_L2_PENDING, which requires
the constraint that was previously enforced in the replaced tma_dram_bound
metric.

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",

[Severity: Low]
Does this Sample with string direct users to a non-existent event?

The suggested command uses MEM_LOAD_RETIRED.L3_MISS, but the Jaketown PMU
uses the MEM_LOAD_UOPS_RETIRED.* prefix.

> +        "ScaleUnit": "100%"
> +    },

[ ... ]

> @@ -529,7 +522,7 @@
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
>          "ScaleUnit": "100%"
>      },

[Severity: Low]
Does this documentation refer to a dangling metric?

The added metric tma_info_inst_mix_vectormixpki is not defined for the
Jaketown architecture, creating a broken documentation link.

> diff --git a/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json b/=
tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
> index eb8fbd14138a8..e527c8c5c4430 100644
> --- a/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json
> +++ b/tools/perf/pmu-events/arch/x86/jaketown/metricgroups.json

[ ... ]

> @@ -88,6 +87,7 @@
>      "tma_fp_vector_group": "Metrics contributing to tma_fp_vector catego=
ry",
>      "tma_frontend_bound_group": "Metrics contributing to tma_frontend_bo=
und category",
>      "tma_heavy_operations_group": "Metrics contributing to tma_heavy_ope=
rations category",
> +    "tma_icache_misses_group": "Metrics contributing to tma_icache_misse=
s category",

[Severity: Low]
Is this metric group utilized anywhere in this architecture?

The tma_icache_misses_group is defined here but appears to be never
referenced by any metric in the Jaketown architecture.

>      "tma_issue2P": "Metrics related by the issue $issue2P",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D13
