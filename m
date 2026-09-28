Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B824B95BF;
	Mon, 28 Sep 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614191; cv=none; b=pUSVQ+XgZtCcauBN7bAJv6DWd2M5+6mN2owOoTSewB9nKiaAF0WWfjGDXw2272Rr3v2wqYpZ4KOI0qZQVfiwWfst+/K+VWa+lojXrCahvI3s8D1Thb5SqUKM2WgNL+rznn7gMZuenCJlWXlXV7Cf2927hq2uCmyY/CFG21l31ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614191; c=relaxed/simple;
	bh=0KYh2oDwTxkzoh/rQFaoEj+Q7zGlBiNIWJ2yEwYu0Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7vwO+ucYTiXRtuEgT620IasxEWoLL0PZb8wCmdfQJeOlad8Hsxndli8tstB6afqPmw9hCU/KOrLQNMDOFZW9gFCN99qTgaSYJMf2xRD6Opz5337yZC7lB/8ToDkl6t+loq9vNNSVIiUtk1zld8NUDbvMTacT1cTO36IcgwMoPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pe6WSsBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pe6WSsBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D64C1F000FF;
	Mon, 28 Sep 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614190;
	bh=BQeJcLQNbWveR9npJRPmEsZ7K6CXoKDK1YnhcW3ghok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pe6WSsBcGkH9yM9YOs+OWoDMLjtd7qV3z+xX3BYK3k54r1CH0gb/aIVRXFWobiEjL
	 r1yjM69cek7uTWg9Ah2EqfQMKK8S2Z0ZAPiAs7qy+p0+nn2/Y1EVUBxfw1BG+0l3aJ
	 6bcP815KmyP+HtwVgLv7oiR0XRD+6K1kWyZDph8uWOCcsXjpvYOp809v3VfTjx3C9p
	 O42Z/wqMoD2QDUmarPsdIgh5mPYaS45ftl2bJgvyvGg6YcVaAQ1dNp2zkS0EYuaCQ9
	 2/yVD/R5AKjreaytJmVdaUhLGblOtlz9cU1eEO+zoJkPLtHuuS3N+31fonpCmN6umA
	 mmN2gm8aOO4jw==
Date: Mon, 28 Sep 2026 18:49:47 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: sashiko-reviews@lists.linux.dev,
	"Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 04/26] perf vendor events intel: Update broadwell
 metrics to TMA 5.2
Message-ID: <arqaq6ulLswHEQyg@x2>
References: <20260924053645.3555041-1-irogers@google.com>
 <20260924170346.3872848-1-irogers@google.com>
 <20260924170346.3872848-5-irogers@google.com>
 <20260924171457.7626C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924171457.7626C1F00893@smtp.kernel.org>

On Thu, Sep 24, 2026 at 05:14:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf: missing NO_GROUP_EVENTS_SMT constraint for tma_l3_miss_bound
> - [Low] perf: invalid event and metric references in broadwell TMA descriptions
> --

Hi Ian,

	I just saw Mi thanking you for addressing an issue in this
series, will you address these Sashiko comments?

Mi,
	Can I have your reviewed-by for the series?

- Arnaldo
	
 
> commit 9dd8d107153bd9a839dac0461130818443958cb7
> Author: Ian Rogers <irogers@google.com>
> 
> perf vendor events intel: Update broadwell metrics to TMA 5.2
> 
> This commit updates the Telemetry Metric Architecture (TMA) metrics for
> Intel Broadwell platforms to version 5.2.
> 
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > index 1d8e910f59613..cd59e4a666b21 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
> [ ... ]
> > @@ -175,13 +175,13 @@
> >          "ScaleUnit": "100%"
> >      },
> >      {
> > -        "BriefDescription": "This metric estimates fraction of cycles while the memory subsystem was handling synchronizations due to data-sharing accesses",
> > +        "BriefDescription": "This metric estimates fraction of cycles while the memory subsystem was handling synchronizations due to L3 data-sharing accesses",
> >          "MetricConstraint": "NO_GROUP_EVENTS",
> >          "MetricExpr": "43 * (MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT * (1 + MEM_LOAD_UOPS_RETIRED.HIT_LFB / (MEM_LOAD_UOPS_RETIRED.L2_HIT + MEM_LOAD_UOPS_RETIRED.L3_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HIT + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_HITM + MEM_LOAD_UOPS_L3_HIT_RETIRED.XSNP_MISS + MEM_LOAD_UOPS_RETIRED.L3_MISS))) / tma_info_thread_clks",
> >          "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
> >          "MetricName": "tma_data_sharing",
> >          "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > -        "PublicDescription": "This metric estimates fraction of cycles while the memory subsystem was handling synchronizations due to data-sharing accesses. Data shared by multiple Logical Processors (even just read shared) may cause increased access latency due to cache coherency. Excessive data sharing can drastically harm multithreaded performance. Sample with: MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT_PS. Related metrics: tma_contested_accesses, tma_false_sharing, tma_machine_clears, tma_remote_cache",
> > +        "PublicDescription": "This metric estimates fraction of cycles while the memory subsystem was handling synchronizations due to L3 data-sharing accesses. Data shared by multiple Logical Processors (even just read shared) may cause increased access latency due to cache coherency. Excessive data sharing can drastically harm multithreaded performance. Sample with: MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, tma_false_sharing, tma_machine_clears, tma_remote_cache",
> 
> [Severity: Low]
> Is this sample event correct? The updated description suggests sampling with
> MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD, but this event does not exist on
> Broadwell processors. Should this be XSNP_HIT instead?
> 
> [ ... ]
> > @@ -827,7 +817,16 @@
> >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_l3_bound_group",
> >          "MetricName": "tma_l3_hit_latency",
> >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > -        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metrics: tma_mem_latency",
> > +        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tma_mem_latency",
> > +        "ScaleUnit": "100%"
> > +    },
> > +    {
> > +        "BriefDescription": "This metric estimates how often the CPU was stalled on accesses to external memory (DRAM) by loads",
> > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2_MISS / tma_info_thread_clks",
> > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_group;tma_memory_bound_group",
> > +        "MetricName": "tma_l3_miss_bound",
> 
> [Severity: Medium]
> Does this metric need the NO_GROUP_EVENTS_SMT constraint like the old
> tma_dram_bound metric it replaces?
> 
> The expression uses CYCLE_ACTIVITY.STALLS_L2_MISS which has multiplexing
> limitations when SMT is enabled on older architectures like Broadwell.
> Without this constraint, hardware PMU events might fail to schedule or yield
> invalid results when SMT is enabled.
> 
> > +        "MetricThreshold": "tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2)",
> > +        "PublicDescription": "This metric estimates how often the CPU was stalled on accesses to external memory (DRAM) by loads. Better caching can improve the latency and increase performance. Sample with: MEM_LOAD_RETIRED.L3_MISS",
> 
> [Severity: Low]
> Is this sample event correct? The new tma_l3_miss_bound metric suggests
> MEM_LOAD_RETIRED.L3_MISS, but this event doesn't exist on Broadwell. Should
> this be MEM_LOAD_UOPS_RETIRED.L3_MISS_PS?
> 
> > +        "ScaleUnit": "100%"
> >      },
> >      {
> > @@ -882,18 +881,18 @@
> >      {
> >          "BriefDescription": "This metric estimates fraction of cycles where the core's performance was likely hurt due to approaching bandwidth limits of external memory - DRAM ([SPR-HBM] and/or HBM)",
> >          "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=4@) / tma_info_thread_clks",
> > -        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_dram_bound_group;tma_issueBW",
> > +        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issueBW;tma_l3_miss_bound_group",
> >          "MetricName": "tma_mem_bandwidth",
> > -        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_dram_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > -        "PublicDescription": "This metric estimates fraction of cycles where the core's performance was likely hurt due to approaching bandwidth limits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuristic assumes that a similar off-core traffic is generated by all IA cores. This metric does not aggregate non-data-read requests by this logical processor; requests from other IA Logical Processors/Physical Cores/sockets; or other non-IA devices like GPU; hence the maximum external memory bandwidth limits may or may not be approached when this metric is flagged (see Uncore counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
> > +        "MetricThreshold": "tma_mem_bandwidth > 0.2 & (tma_l3_miss_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > +        "PublicDescription": "This metric estimates fraction of cycles where the core's performance was likely hurt due to approaching bandwidth limits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heuristic assumes that a similar off-core traffic is generated by all IA cores. This metric does not aggregate non-data-read requests by this logical processor; requests from other IA Logical Processors/Physical Cores/sockets; or other non-IA devices like GPU; hence the maximum external memory bandwidth limits may or may not be approached when this metric is flagged (see Uncore counters for that). Related metrics: tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full, tma_uc_bound",
> 
> [Severity: Low]
> Does this description reference an undefined metric? The related metrics list
> adds tma_uc_bound, but that metric isn't defined in the Broadwell events.
> 
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > index a5e408ca46a7e..a3e6835f4f847 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
> [ ... ]
> > @@ -819,7 +809,16 @@
> >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_l3_bound_group",
> >          "MetricName": "tma_l3_hit_latency",
> >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > -        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tma_mem_latency",
> > +        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_L2_MISS_RETIRED.L3_HIT_SAME_CBB. Related metrics: tma_mem_latency",
> > +        "ScaleUnit": "100%"
> > +    },
> > +    {
> > +        "BriefDescription": "This metric estimates how often the CPU was stalled on accesses to external memory (DRAM) by loads",
> > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2_MISS / tma_info_thread_clks",
> > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_group;tma_memory_bound_group",
> > +        "MetricName": "tma_l3_miss_bound",
> 
> [Severity: Medium]
> Just like the Broadwell metric above, should this also include the
> NO_GROUP_EVENTS_SMT constraint to prevent SMT scheduling failures for
> CYCLE_ACTIVITY.STALLS_L2_MISS?
> 
> > diff --git a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > index 5b83b040060c3..6b914b29bff95 100644
> > --- a/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> > +++ b/tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
> [ ... ]
> > @@ -1050,7 +1034,16 @@
> >          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueLat;tma_l3_bound_group",
> >          "MetricName": "tma_l3_hit_latency",
> >          "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0.05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> > -        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_UOPS_RETIRED.L3_HIT_PS. Related metrics: tma_mem_latency",
> > +        "PublicDescription": "This metric estimates fraction of cycles with demand load accesses that hit the L3 cache under unloaded scenarios (possibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/L3 hits) will improve the latency; reduce contention with sibling physical cores and increase performance.  Note the value of this node may overlap with its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: tma_mem_latency",
> > +        "ScaleUnit": "100%"
> > +    },
> > +    {
> > +        "BriefDescription": "This metric estimates how often the CPU was stalled on accesses to external memory (DRAM) by loads",
> > +        "MetricExpr": "(1 - MEM_LOAD_UOPS_RETIRED.L3_HIT / (MEM_LOAD_UOPS_RETIRED.L3_HIT + 7 * MEM_LOAD_UOPS_RETIRED.L3_MISS)) * CYCLE_ACTIVITY.STALLS_L2_MISS / tma_info_thread_clks",
> > +        "MetricGroup": "MemoryBound;Offcore;TmaL3mem;TopdownL3;tma_L3_group;tma_memory_bound_group",
> > +        "MetricName": "tma_l3_miss_bound",
> 
> [Severity: Medium]
> This appears to be missing the NO_GROUP_EVENTS_SMT constraint here as well
> for the broadwellx architecture.
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260924170346.3872848-1-irogers@google.com?part=4
