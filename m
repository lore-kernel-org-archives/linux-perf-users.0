Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A211A8F7B
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 05:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790228942; cv=none; b=ggULvTdd4jC9L3XCA2wZYiWCurMFX3Y5aWne4H9XL4amXlvYNXxc0eyQOwUKxLTLnoB3bjMxhGunF8Dxg6M/HlVXfU1OC5MV38mY2c89iPETdM7q8BrNL/W/zFlLqoJAvA9lyEjzfYxlkT7zqIBBaOj/Tb3MDlT5TrL9K5jn0Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790228942; c=relaxed/simple;
	bh=LS7UYlszUohSZch/TUKVyk8BONZD4yHVO/NhyswaCIg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B2KqOrPN32xnznmNSzFyq3fPE3QAMPj84Scl58+pXwVIr8mtZIVOBqqgTEN6I7OzrTj0wgZYNhD8O3VtZdAL+hHatsSVGyqRHLM5fFIXKwWYpls/c2ksKz9+7uqHHfHtHNZJHNAC13aLlhQw60o3m3SYYVysoXkteD8eSPj2m6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe49oFUa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe49oFUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F61F000FF;
	Thu, 24 Sep 2026 05:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790228940;
	bh=8Jw9zfxRXLbLxDxXjOeFQpMnDbwbAPrAGE7Wn4PQ/v4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pe49oFUaaDpEIG/X7e7XyfVgfGVzNfjuQNCVZQ7c6/eSI4OFOeL/Mv/aPURYvcOeR
	 RyLIxteUi8gVz3jmY6NGW0l/H2K3cyiq8acRNFBH8RSeUoF4VjHDAI+1wa8/ZvVlOU
	 xf6eGJWcn8RlU+Hfra2QIuUERgEmIFm8MXdXiM8OhuldI9PVHZhd2jcYEdrYyz8p88
	 w0hNVE8Hiqx6ZDEb0t4Nv5p9F07lgsL4nmsBHU5moG3nPMWKQiWN4PHWQ0/u7vh9Fz
	 iemID0RoKpGwZw1nGHoTSKuYle97cuC1A3N3YdEjl0HJxujci9oNNSOFcRj/gHj2wc
	 1v4oU8kzWEgqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 04/21] perf vendor events intel: Update broadwell
 metrics to TMA 5.2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260924053645.3555041-5-irogers@google.com>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924053645.3555041-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 05:49:00 +0000
Message-Id: <20260924054900.959F61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] perf: invalid event references in broadwell TMA metrics
- [Low] perf: dangling metric references in broadwell 'Related metrics'
--

commit c0c2967e366a8baed1a9336ee9569a4da8ff973c
Author: Ian Rogers <irogers@google.com>

perf vendor events intel: Update broadwell metrics to TMA 5.2
   =20
This commit updates the TMA metrics for Broadwell architectures to version =
5.2
based on the intel/perfmon repository.

> diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/=
tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> index 1d8e910f59613..cd59e4a666b21 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> @@ -160,7 +160,7 @@
>          "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_contested_accesses",
>          "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_boun=
d > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM_PS;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS_PS. =
Related metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, t=
ma_remote_cache",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related=
 metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remo=
te_cache",

[Severity: Low]
Does the MEM_LOAD_L3_HIT_RETIRED event support the XSNP_FWD modifier on
Broadwell?

If users follow the "Sample with:" recommendation and try to use these even=
ts
with perf record, won't it fail with an 'invalid event' error?

[ ... ]

> @@ -255,7 +245,7 @@
>          "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW=
;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
>          "MetricName": "tma_fb_full",
>          "MetricThreshold": "tma_fb_full > 0.3",
> -        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_=
bandwidth, tma_sq_full, tma_store_latency, tma_streaming_stores",
> +        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_info_system_dram_bw_use, tma_mem_=
bandwidth, tma_sq_full, tma_store_latency, tma_streaming_stores, tma_uc_bou=
nd",

[Severity: Low]
Is the tma_uc_bound metric actually defined for Broadwell architectures?

Referencing a missing metric in "Related metrics" creates a dead documentat=
ion
link for users inspecting metrics via perf list.

[ ... ]

> @@ -941,7 +940,7 @@
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
Does the tma_info_inst_mix_vectormixpki metric exist for Broadwell?

Similar to tma_uc_bound above, referencing it here results in a dangling
documentation link if it is undefined.

[ ... ]

> diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.jso=
n b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> index a5e408ca46a7e..a3e6835f4f847 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> @@ -160,7 +160,7 @@
>          "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_contested_accesses",
>          "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_boun=
d > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD;MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Related=
 metrics: tma_data_sharing, tma_false_sharing, tma_machine_clears, tma_remo=
te_cache",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L2_MISS_RETIRED.L3.SAME_CBB.HIT_ESF.SNP_MISS;MEM_LOAD_L2_MISS_RETI=
RED.OTHER_MODULE_L2.SAME_CBB.HIT_M.SNP_FWD. Related metrics: tma_data_shari=
ng, tma_false_sharing, tma_machine_clears, tma_remote_cache",

[Severity: Low]
Are these MEM_LOAD_L2_MISS_RETIRED events valid for Broadwell-DE?

It appears these specific events might belong to newer architectures (like
Novalake or Arrowlake). Recommending them here could cause perf record to
fail with an 'invalid event' error.

[ ... ]

> diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b=
/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> index 5b83b040060c3..6b914b29bff95 100644
> --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> @@ -447,7 +437,7 @@
>          "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
>          "MetricName": "tma_false_sharing",
>          "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates how often CP=
U was handling synchronizations due to False Sharing. False Sharing is a mu=
ltithreading hiccup; where multiple Logical Processors contend on different=
 data-elements mapped into the same cache line. Sample with: MEM_LOAD_L3_HI=
T_RETIRED.XSNP_HITM_PS;OFFCORE_RESPONSE.DEMAND_RFO.L3_HIT.SNOOP_HITM. Relat=
ed metrics: tma_contested_accesses, tma_data_sharing, tma_machine_clears, t=
ma_remote_cache",
> +        "PublicDescription": "This metric roughly estimates how often CP=
U was handling synchronizations due to False Sharing. False Sharing is a mu=
ltithreading hiccup; where multiple Logical Processors contend on different=
 data-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO=
.L3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_shari=
ng, tma_machine_clears, tma_remote_cache",

[Severity: Low]
Does Broadwell-X use the 'OCR' prefix?

It seems 'OFFCORE_RESPONSE' is the expected prefix for this architecture,
meaning the suggested 'OCR' event might not be recognized by perf.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924053645.3555=
041-1-irogers@google.com?part=3D4
