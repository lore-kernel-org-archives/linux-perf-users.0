Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E820D374E7F
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 17:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270099; cv=none; b=IuY/DF2NDEiLUb5OqM+Xuv8XBw+yfk0/1xh2locB2jxa5x3xZWno2+8xg4E9p7tThr7JcBE3waCPU9Bo0iCrmsIsExew8f6TO2jrizEWf4zkayVUg/i+/GtPJ2NTpPIu4ddGD9gSbf+olO2tIgfdT5pKX7Nh2MFzchmJ3D66qU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270099; c=relaxed/simple;
	bh=4OEb0OsotkwzpbkEOjckQavExbaw78MN/W8dHwFqBG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NeLYGxMlAi20fcGNKjShqRvhqlMylqOdi8HFjoOVSEU881sV5dYRu+oViRBZYiv153yg5YHWP+TECgjByDjD6/2bfNXx2Cba4h9BQAzWG9WArHK/Ej3yYe3ZXG7MbBydi056IQwAMny58JtazUIP1qlzSkM4d7+flzofu3a/ppQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAfDHFmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAfDHFmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7626C1F00893;
	Thu, 24 Sep 2026 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270097;
	bh=O6dg0CSKpIjDXkmFt28k+yiZts/Tb8pMupc69o4Z9Vs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HAfDHFmtHh6SO+orEbAChBMVJaqsBkfVyAocJgjMO7oFVXo4ELGOpvAhY9Im4jgZK
	 9RFahc01uwNvppRtVBvZ0XyfEqkamBZcMr5Rz+dYPZdx0KGNvR1R/XmDQTUVnEO3Tm
	 HuttgaHBIhNR4RjefpcMfHgx4H1oCFO7Ww71WKJLkn/hB9UbL0oxJzuRoSdWnFpTEk
	 BiI2NNHB7+mWOTeZB3vBAn7cu1CI7rKC1b4SeGjX1u2J/NGLTdIqyySB2jLSd+JDqD
	 h6TjRtgIGZ8GIoD0Oytt1u3UzeJajB1LCcUZDBlc4ZRAwwM32HrDxmMHmiVJP7Cu2G
	 bUKbSUmVkUHYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/26] perf vendor events intel: Update broadwell
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924170346.3872848-5-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:14:57 +0000
Message-Id: <20260924171457.7626C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss_bou=
nd
- [Low] perf: invalid event and metric references in broadwell TMA descript=
ions
--

commit 9dd8d107153bd9a839dac0461130818443958cb7
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update broadwell metrics to TMA 5.2

This commit updates the Telemetry Metric Architecture (TMA) metrics for
Intel Broadwell platforms to version 5.2.

> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/=
tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 1d8e910f59613..cd59e4a666b21 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
[ ... ]
> @@ -175,13 +175,13 @@
>          "ScaleUnit": "100%"
>      },
>      {
> -        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to data-sharing =
accesses",
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to L3 data-shari=
ng accesses",
>          "MetricConstraint": "NO_GROUP_EVENTS",
>          "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 =
+ MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_=
UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS=
_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LO=
AD_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
>          "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_is=
sueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_data_sharing",
>          "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to data-sharing=
 accesses. Data shared by multiple Logical Processors (even just read share=
d) may cause increased access latency due to cache coherency. Excessive dat=
a sharing can drastically harm multithreaded performance. Sample with: MEM_=
LOAD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, t=
ma_false_sharing, tma_machine_clears, tma_remote_cache",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to L3 data-shar=
ing accesses. Data shared by multiple Logical Processors (even just read sh=
ared) may cause increased access latency due to cache coherency. Excessive =
data sharing can drastically harm multithreaded performance. Sample with: M=
EM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses=
, tma_false_sharing, tma_machine_clears, tma_remote_cache",

[Severity: Low]
Is this sample event correct? The updated description suggests sampling with
MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD, but this event does not exist on
Broadwell processors. Should this be XSNP_HIT instead?

[ ... ]
> @@ -827,7 +817,16 @@
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
LLS_L2_MISS / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Does this metric need the NO_GROUP_EVENTS_SMT constraint like the old
tma_dram_bound metric it replaces?

The expression uses CYCLE_ACTIVITY.STALLS_L2_MISS which has multiplexing
limitations when SMT is enabled on older architectures like Broadwell.
Without this constraint, hardware PMU events might fail to schedule or yield
invalid results when SMT is enabled.

> +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2)",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",

[Severity: Low]
Is this sample event correct? The new tma_l3_miss_bound metric suggests
MEM_LOAD_RETIRED.L3_MISS, but this event doesn't exist on Broadwell. Should
this be MEM_LOAD_UOPS_RETIRED.L3_MISS_PS?

> +        "ScaleUnit": "100%"
>      },
>      {
> @@ -882,18 +881,18 @@
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wh=
ere the core's performance was likely hurt due to approaching bandwidth lim=
its of external memory - DRAM ([SPR-HBM] and/or HBM)",
>          "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS=
_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_clks",
> -        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_dram_bound_group;tma_issueBW",
> +        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_issueBW;tma_l3_miss_bound_group",
>          "MetricName": "tma_mem_bandwidth",
> -        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > =
0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
here the core's performance was likely hurt due to approaching bandwidth li=
mits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heur=
istic assumes that a similar off-core traffic is generated by all IA cores.=
 This metric does not aggregate non-data-read requests by this logical proc=
essor; requests from other IA Logical Processors/Physical Cores/sockets; or=
 other non-IA devices like GPU; hence the maximum external memory bandwidth=
 limits may or may not be approached when this metric is flagged (see Uncor=
e counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw=
_use, tma_sq_full",
> +        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_l3_miss_bound=
 > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
here the core's performance was likely hurt due to approaching bandwidth li=
mits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heur=
istic assumes that a similar off-core traffic is generated by all IA cores.=
 This metric does not aggregate non-data-read requests by this logical proc=
essor; requests from other IA Logical Processors/Physical Cores/sockets; or=
 other non-IA devices like GPU; hence the maximum external memory bandwidth=
 limits may or may not be approached when this metric is flagged (see Uncor=
e counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw=
_use, tma_sq_full, tma_uc_bound",

[Severity: Low]
Does this description reference an undefined metric? The related metrics li=
st
adds tma_uc_bound, but that metric isn't defined in the Broadwell events.

> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.jso=
n b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index a5e408ca46a7e..a3e6835f4f847 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
[ ... ]
> @@ -819,7 +809,16 @@
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
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: =
tma_mem_latency",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB. Rel=
ated metrics: tma_mem_latency",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOP=
S_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STA=
LLS_L2_MISS / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
Just like the Broadwell metric above, should this also include the
NO_GROUP_EVENTS_SMT constraint to prevent SMT scheduling failures for
CYCLE_ACTIVITY.STALLS_L2_MISS?

> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b=
/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> index 5b83b040060c3..6b914b29bff95 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
[ ... ]
> @@ -1050,7 +1034,16 @@
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
LLS_L2_MISS / tma_info_thread_clks",
> +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_gr=
oup;tma_memory_bound_group",
> +        "MetricName": "tma_l3_miss_bound",

[Severity: Medium]
This appears to be missing the NO_GROUP_EVENTS_SMT constraint here as well
for the broadwellx architecture.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924170346.3872=
848-1-irogers@google.com?part=3D4
