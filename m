Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD015B99E;
	Wed,  8 Jan 2025 14:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736347884; cv=none; b=AYuepjSuOvyj4l/C2XJ1gbGlSXw49n+R4B8V2IHtE0RZsaczFhjqre55QOZY3rSeItKE8KtEJgUDJsn6iDNVP2Nq64OT5vEhZzk3HWKskQvJlABhD46zTt4RELQy5ydl30z7kp6SNnhhK0xwBUePYAI80tR5bWfvY91ljnwLvG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736347884; c=relaxed/simple;
	bh=T6OG8dPNR4zJuxjwfLgp4LNOXDRnQ6DmSpwz4grorrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9TFScJQdbBioCZ/hUDrgxCVoyBnkaWgDY6ZOm6ExHAnXrqwD+ROsRNNUeNBRvN/HtriqeC7B2Z61dlkxq8Sms8ss7Zse0cJNGvLKg55crIkraSxrdM5HoAWQg+tRJRvZ86SuDaxTIE8nLlq+gAkuGkmnIIcAwta+8IXIxKSpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3J7Vey/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3J7Vey/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BEBC4CED3;
	Wed,  8 Jan 2025 14:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736347883;
	bh=T6OG8dPNR4zJuxjwfLgp4LNOXDRnQ6DmSpwz4grorrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j3J7Vey/kf29XgzxyVk1XCeFalWXJEpr39CKYjd/L9V/87x3Ij7Ed4owsbwizVJ+Z
	 +apHtNCpxFoS0SfLjoZMqRl5YDZksLIZbBCuKhBKV7egG5ZYnBePnFRIxugDrZPV6V
	 GgddcArKnxmC1UXC9TFJ6fPF/sEh+9sYvY6V/WOM3BpK2x6eOn2egeU+NfZjbJXBr3
	 89n/eM3TFZSKYn5Yt6AApJfdqcykFsHM0JpdwxEOjxXTECI/yZ7iTRVVgRSm8GOePY
	 /r4pUuw1qtp6tM+wT20PmhJwNQU9gfaMxFLhwskZpUQcHn3uhRydOcT2KoyEu8Tepj
	 NyuPsmyJNAjcQ==
Date: Wed, 8 Jan 2025 11:51:19 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Edward Baker <edward.baker@intel.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH v1 01/22] perf vendor events: Update Alderlake
 events/metrics
Message-ID: <Z36Q5yGApnfCKsBq@x1>
References: <20241209222800.296000-1-irogers@google.com>
 <20241209222800.296000-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241209222800.296000-2-irogers@google.com>

On Mon, Dec 09, 2024 at 02:27:38PM -0800, Ian Rogers wrote:
> Update events from v1.27 to v1.28.
> Update TMA metrics from 4.8 to 5.01.
>=20
> Bring in the event updates v1.28:
> https://github.com/intel/perfmon/commit/801f43f22ec6bd23fbb5d18860f395d61=
e7f4081
>=20
> The TMA 5.01 update is from (with subsequent fixes):
> https://github.com/intel/perfmon/commit/1d72913b2d938781fb28f3cc3507aaec5=
c22d782

On my workstation this patch is causing:

=E2=AC=A2 [acme@toolbox perf-tools-next]$ perf stat sleep 1
event syntax error: '..ED.L3_HIT/,cpu/DTLB_LOAD_MISSES.STLB_HIT,cmask=3D0x1=
,metric-id=3Dcpu!3DTLB_LOAD_MISSES.STLB_HIT!0cmask!20x1!3/,topdown-mem-boun=
d/metric-id=3Dtopdown!1mem!1bound/,cpu/UOPS_..'
                                  \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu'

 Performance counter stats for 'sleep 1':

              0.79 msec task-clock:u                     #    0.001 CPUs ut=
ilized            =20
                 0      context-switches:u               #    0.000 /sec   =
                  =20
                 0      cpu-migrations:u                 #    0.000 /sec   =
                  =20
                68      page-faults:u                    #   86.026 K/sec  =
                  =20
           381,023      cpu_atom/instructions/u          #    0.36  insn pe=
r cycle              (60.24%)
            92,367      cpu_core/instructions/u          #    0.44  insn pe=
r cycle              (39.76%)
         1,064,063      cpu_atom/cycles/u                #    1.346 GHz    =
                     (60.24%)
           209,521      cpu_core/cycles/u                #    0.265 GHz    =
                     (39.76%)
            82,585      cpu_atom/branches/u              #  104.477 M/sec  =
                     (60.24%)
            19,921      cpu_core/branches/u              #   25.202 M/sec  =
                     (39.76%)
             6,049      cpu_atom/branch-misses/u         #    7.32% of all =
branches             (60.24%)
             1,685      cpu_core/branch-misses/u         #    8.46% of all =
branches             (39.76%)

       1.001365193 seconds time elapsed

       0.000000000 seconds user
       0.001284000 seconds sys


=E2=AC=A2 [acme@toolbox perf-tools-next]$ grep -m1 'model name' /proc/cpuin=
fo=20
model name	: Intel(R) Core(TM) i7-14700K
=E2=AC=A2 [acme@toolbox perf-tools-next]$

And on the notebook, that is also hybrid:

acme@x1:~$ grep -m1 'model name' /proc/cpuinfo
model name	: 13th Gen Intel(R) Core(TM) i7-1365U

=E2=AC=A2 [acme@toolbox perf-tools-next]$ perf stat sleep 0.1
event syntax error: '..ED.L3_HIT/,cpu/DTLB_LOAD_MISSES.STLB_HIT,cmask=3D0x1=
,metric-id=3Dcpu!3DTLB_LOAD_MISSES.STLB_HIT!0cmask!20x1!3/,topdown-mem-boun=
d/metric-id=3Dtopdown!1mem!1bound/,cpu/UOPS_..'
                                  \___ Bad event or PMU

Unable to find PMU or event on a PMU of 'cpu'

 Performance counter stats for 'sleep 0.1':

              0.94 msec task-clock:u                     #    0.009 CPUs ut=
ilized            =20
                 0      context-switches:u               #    0.000 /sec   =
                  =20
                 0      cpu-migrations:u                 #    0.000 /sec   =
                  =20
                66      page-faults:u                    #   70.334 K/sec  =
                  =20
           308,869      cpu_atom/instructions/u          #    0.50  insn pe=
r cycle              (51.07%)
           209,685      cpu_core/instructions/u          #    0.75  insn pe=
r cycle              (48.93%)
           616,738      cpu_atom/cycles/u                #    0.657 GHz    =
                     (51.07%)
           281,210      cpu_core/cycles/u                #    0.300 GHz    =
                     (48.93%)
            63,094      cpu_atom/branches/u              #   67.237 M/sec  =
                     (51.07%)
            48,598      cpu_core/branches/u              #   51.789 M/sec  =
                     (48.93%)
             5,086      cpu_atom/branch-misses/u         #    8.06% of all =
branches             (51.07%)
             2,653      cpu_core/branch-misses/u         #    5.46% of all =
branches             (48.93%)

       0.102117022 seconds time elapsed

       0.001682000 seconds user
       0.000000000 seconds sys

=E2=AC=A2 [acme@toolbox perf-tools-next]$

- Arnaldo
=20
> Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/x86/alderlake/adl-metrics.json       | 3637 +++++++++++++----
>  .../pmu-events/arch/x86/alderlake/cache.json  |  292 +-
>  .../arch/x86/alderlake/floating-point.json    |   19 +-
>  .../arch/x86/alderlake/frontend.json          |   19 -
>  .../pmu-events/arch/x86/alderlake/memory.json |   32 +-
>  .../arch/x86/alderlake/metricgroups.json      |   10 +-
>  .../pmu-events/arch/x86/alderlake/other.json  |   92 +-
>  .../arch/x86/alderlake/pipeline.json          |  127 +-
>  .../arch/x86/alderlake/virtual-memory.json    |   33 +
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
>  10 files changed, 3361 insertions(+), 902 deletions(-)
>=20
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json b/=
tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> index 8fdf4a4225de..99d8e86a7ca0 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json
> @@ -48,13 +48,6 @@
>          "MetricName": "C7_Core_Residency",
>          "ScaleUnit": "100%"
>      },
> -    {
> -        "BriefDescription": "C7 residency percent per package",
> -        "MetricExpr": "cstate_pkg@c7\\-residency@ / TSC",
> -        "MetricGroup": "Power",
> -        "MetricName": "C7_Pkg_Residency",
> -        "ScaleUnit": "100%"
> -    },
>      {
>          "BriefDescription": "C8 residency percent per package",
>          "MetricExpr": "cstate_pkg@c8\\-residency@ / TSC",
> @@ -62,13 +55,6 @@
>          "MetricName": "C8_Pkg_Residency",
>          "ScaleUnit": "100%"
>      },
> -    {
> -        "BriefDescription": "C9 residency percent per package",
> -        "MetricExpr": "cstate_pkg@c9\\-residency@ / TSC",
> -        "MetricGroup": "Power",
> -        "MetricName": "C9_Pkg_Residency",
> -        "ScaleUnit": "100%"
> -    },
>      {
>          "BriefDescription": "Percentage of cycles spent in System Manage=
ment Interrupts.",
>          "MetricExpr": "((msr@aperf@ - cycles) / msr@aperf@ if msr@smi@ >=
 0 else 0)",
> @@ -112,56 +98,221 @@
>          "MetricName": "tsx_transactional_cycles",
>          "ScaleUnit": "100%"
>      },
> +    {
> +        "BriefDescription": "Uncore frequency per die [GHZ]",
> +        "MetricExpr": "tma_info_system_socket_clks / #num_dies / duratio=
n_time / 1e9",
> +        "MetricGroup": "SoC",
> +        "MetricName": "UNCORE_FREQ",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to certain allocation restrictions",
> -        "MetricExpr": "tma_core_bound",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (=
5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
>          "MetricGroup": "TopdownL3;tma_L3_group;tma_core_bound_group",
>          "MetricName": "tma_allocation_restriction",
> -        "MetricThreshold": "tma_allocation_restriction > 0.1 & (tma_core=
_bound > 0.1 & tma_backend_bound > 0.1)",
> +        "MetricThreshold": "(tma_allocation_restriction >0.10) & ((tma_c=
ore_bound >0.10) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution ports for ALU operations",
> +        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 =
+ UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_=
core_clks)",
> +        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_=
utilized_3m_group",
> +        "MetricName": "tma_alu_op_utilization",
> +        "MetricThreshold": "tma_alu_op_utilization > 0.4",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops delivered by the Microcode_Sequencer as a result of Assis=
ts",
> +        "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
> +        "MetricGroup": "BvIO;Slots_Estimated;TopdownL4;tma_L4_group;tma_=
microcode_sequencer_group",
> +        "MetricName": "tma_assists",
> +        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer =
> 0.05 & tma_heavy_operations > 0.1",
> +        "PublicDescription": "This metric estimates fraction of slots th=
e CPU retired uops delivered by the Microcode_Sequencer as a result of Assi=
sts. Assists are long sequences of uops that are required in certain corner=
-cases for operations that cannot be handled natively by the execution pipe=
line. For example; when working with very small floating point values (so-c=
alled Denormals); the FP units are not set up to perform these operations n=
atively. Instead; a sequence of instructions to perform the computation on =
the Denormals is injected into the pipeline. Since these microcode sequence=
s might be dozens of uops long; Assists can be extremely deleterious to per=
formance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops as a result of handing SSE to AVX* or AVX* to SSE transit=
ion Assists",
> +        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_thread_slots",
> +        "MetricGroup": "HPC;Slots_Estimated;TopdownL5;tma_L5_group;tma_a=
ssists_group",
> +        "MetricName": "tma_avx_assists",
> +        "MetricThreshold": "tma_avx_assists > 0.1",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend due to backend stalls",
> +        "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
>          "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
> +        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots=
",
>          "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
> -        "MetricThreshold": "tma_backend_bound > 0.1",
> +        "MetricThreshold": "tma_backend_bound > 0.2",
>          "MetricgroupNoGroup": "TopdownL1;Default",
> -        "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend due to backend stalls. Note that uops mu=
st be available for consumption in order for this event to count. If a uop =
is not available (IQ is empty), this event will not count",
> +        "PublicDescription": "This category represents fraction of slots=
 where no uops are being delivered due to a lack of required resources for =
accepting new uops in the Backend. Backend is the portion of the processor =
core where the out-of-order scheduler dispatches ready uops into their resp=
ective execution units; and once completed these uops get retired according=
 to program order. For example; stalls due to data-cache misses or stalls d=
ue to the divider unit being overloaded are both categorized under Backend =
Bound. Backend Bound is further divided into two main categories: Memory Bo=
und and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a mi=
spredicted jump or a machine clear",
> +        "BriefDescription": "This category represents fraction of slots =
wasted due to incorrect speculations",
>          "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "(5 * cpu_atom@CPU_CLK_UNHALTED.CORE@ - (cpu_atom@=
TOPDOWN_FE_BOUND.ALL@ + cpu_atom@TOPDOWN_BE_BOUND.ALL@ + cpu_atom@TOPDOWN_R=
ETIRING.ALL@)) / (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricExpr": "max(1 - (tma_frontend_bound + tma_backend_bound +=
 tma_retiring), 0)",
>          "MetricGroup": "Default;TopdownL1;tma_L1_group",
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "MetricgroupNoGroup": "TopdownL1;Default",
> -        "PublicDescription": "Counts the total number of issue slots tha=
t were not consumed by the backend because allocation is stalled due to a m=
ispredicted jump or a machine clear. Only issue slots wasted due to fast nu=
kes such as memory ordering nukes are counted. Other nukes are not accounte=
d for. Counts all issue slots blocked during this recovery window including=
 relevant microcode flows and while uops are not yet available in the instr=
uction queue (IQ). Also includes the issue slots that were consumed by the =
backend but were thrown away because they were younger than the mispredict =
or machine clear.",
> +        "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Total pipeline cost of instruction fetch re=
lated bottlenecks by large code footprint programs (i-side cache; TLB and B=
TB misses)",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_=
icache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misse=
s + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
> +        "MetricGroup": "BigFootprint;BvBC;Default;Fed;Frontend;IcMiss;Me=
moryTLB;Scaled_Slots;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_bottleneck_big_code",
> +        "MetricThreshold": "tma_bottleneck_big_code > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of instructions used fo=
r program control-flow - a subset of the Retiring category in TMA",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INS=
T_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
> +        "MetricGroup": "BvBO;Default;Ret;Scaled_Slots;TopdownL1;tma_L1_g=
roup",
> +        "MetricName": "tma_bottleneck_branching_overhead",
> +        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of instructions used f=
or program control-flow - a subset of the Retiring category in TMA. Example=
s include function calls; loops and alignments. (A lower bound)",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Bandwidth related bottlenecks",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound))=
 * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory=
_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
dram_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + t=
ma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (=
tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound=
 + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + =
tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_ful=
l)))",
> +        "MetricGroup": "BvMB;Default;Mem;MemoryBW;Offcore;Scaled_Slots;T=
opdownL1;tma_L1_group;tma_issueBW",
> +        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
> +        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_inf=
o_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Latency related bottlenecks",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound))=
 * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesse=
s + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_boun=
d * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_b=
ound + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound =
+ tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l=
1_latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_=
dependency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memor=
y_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_dram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tm=
a_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split=
_loads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + t=
ma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma=
_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound=
 + tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_s=
haring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_m=
emory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_boun=
d + tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_la=
tency + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_d=
tlb_store)))",
> +        "MetricGroup": "BvML;Default;Mem;MemoryLat;Offcore;Scaled_Slots;=
TopdownL1;tma_L1_group;tma_issueLat",
> +        "MetricName": "tma_bottleneck_cache_memory_latency",
> +        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tm=
a_mem_latency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost when the execution is c=
ompute-bound - an estimation",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divide=
r + tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (=
tma_ports_utilization / (tma_divider + tma_serializing_operation + tma_port=
s_utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_port=
s_utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
> +        "MetricGroup": "BvCB;Cor;Default;Scaled_Slots;TopdownL1;tma_L1_g=
roup;tma_issueComp",
> +        "MetricName": "tma_bottleneck_compute_bound_est",
> +        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost when the execution is =
compute-bound - an estimation. Covers Core Bound when High ILP as well as w=
hen long-latency execution units are busy",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of instruction fetch ba=
ndwidth related bottlenecks (when the front-end could not sustain operation=
s delivery to the back-end)",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microco=
de_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_=
latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses +=
 tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 -=
 INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_=
fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_restee=
rs + tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredi=
cts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_branch=
es)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_=
switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms / (tm=
a_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_code",
> +        "MetricGroup": "BvFB;Default;Fed;FetchBW;Frontend;Scaled_Slots;T=
opdownL1;tma_L1_group",
> +        "MetricName": "tma_bottleneck_instruction_fetch_bw",
> +        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of irregular execution =
(e.g",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS=
_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_switches + tma=
_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_ot=
her_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_resteers + tma=
_clears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_itlb_m=
isses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)=
 + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms)) =
+ 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_mispred=
icts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes / tma_=
other_nukes + tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOUR=
CE / tma_info_thread_clks * tma_ports_utilized_0) / (tma_divider + tma_seri=
alizing_operation + tma_ports_utilization) + tma_microcode_sequencer / (tma=
_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_micr=
ocode_sequencer) * tma_heavy_operations)",
> +        "MetricGroup": "Bad;BvIO;Cor;Default;Ret;Scaled_Slots;TopdownL1;=
tma_L1_group;tma_issueMS",
> +        "MetricName": "tma_bottleneck_irregular_overhead",
> +        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of irregular execution=
 (e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workl=
oads, overhead in system services or virtualized environments). Related met=
rics: tma_microcode_sequencer, tma_ms_switches",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Memory Address Trans=
lation related bottlenecks (data-side TLBs)",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma=
_memory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound =
+ tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tm=
a_store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound=
 + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_=
dtlb_store / (tma_store_latency + tma_false_sharing + tma_split_stores + tm=
a_streaming_stores + tma_dtlb_store)))",
> +        "MetricGroup": "BvMT;Default;Mem;MemoryTLB;Offcore;Scaled_Slots;=
TopdownL1;tma_L1_group;tma_issueTLB",
> +        "MetricName": "tma_bottleneck_memory_data_tlbs",
> +        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of Memory Address Tran=
slation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_loa=
d, tma_dtlb_store",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Memory Synchronizati=
on related bottlenecks (data transfers and coherency updates across process=
ors)",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) =
* tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_st=
ores + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_ma=
chine_clears * (1 - tma_other_nukes / tma_other_nukes))",
> +        "MetricGroup": "BvMS;Default;LockCont;Mem;Offcore;Scaled_Slots;T=
opdownL1;tma_L1_group;tma_issueSyncxn",
> +        "MetricName": "tma_bottleneck_memory_synchronization",
> +        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of Memory Synchronizat=
ion related bottlenecks (data transfers and coherency updates across proces=
sors). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Branch Misprediction=
 related bottlenecks",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_oth=
er_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fe=
tch_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_miss=
es + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
> +        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;Default;Scaled_Sl=
ots;TopdownL1;tma_L1_group;tma_issueBM",
> +        "MetricName": "tma_bottleneck_mispredictions",
> +        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of Branch Mispredictio=
n related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_ba=
d_spec_branch_misprediction_cost, tma_mispredicts_resteers",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of remaining bottleneck=
s in the back-end",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_i=
nstruction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_=
memory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_mem=
ory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comp=
ute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branchin=
g_overhead + tma_bottleneck_useful_work)",
> +        "MetricGroup": "BvOB;Cor;Default;Offcore;Scaled_Slots;TopdownL1;=
tma_L1_group",
> +        "MetricName": "tma_bottleneck_other_bottlenecks",
> +        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "Total pipeline cost of remaining bottlenec=
ks in the back-end. Examples include data-dependencies (Core Bound when Low=
 ILP) and other unlisted memory-related stalls",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of \"useful operations\=
" - the portion of Retiring category not covered by Branching_Overhead nor =
Irregular_Overhead",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCH=
ES + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_sl=
ots - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_=
sequencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations=
)",
> +        "MetricGroup": "BvUW;Default;Ret;Scaled_Slots;TopdownL1;tma_L1_g=
roup",
> +        "MetricName": "tma_bottleneck_useful_work",
> +        "MetricThreshold": "tma_bottleneck_useful_work > 20",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to BACLEARS, which occurs when the Branch=
 Target Buffer (BTB) prediction or lack thereof, was corrected by a later b=
ranch predictor in the frontend",
>          "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_DETECT@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
>          "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
>          "MetricName": "tma_branch_detect",
> -        "MetricThreshold": "tma_branch_detect > 0.05 & (tma_ifetch_laten=
cy > 0.15 & tma_frontend_bound > 0.2)",
> +        "MetricThreshold": "(tma_branch_detect >0.05) & ((tma_ifetch_lat=
ency >0.15) & ((tma_frontend_bound >0.20)))",
>          "PublicDescription": "Counts the number of issue slots that were=
 not delivered by the frontend due to BACLEARS, which occurs when the Branc=
h Target Buffer (BTB) prediction or lack thereof, was corrected by a later =
branch predictor in the frontend. Includes BACLEARS due to all branch types=
 including conditional and unconditional jumps, returns, and indirect branc=
hes.",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to branch mispredicts",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MISPREDICT@ / (5=
 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Branch Misprediction",
> +        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound=
 + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * =
slots",
>          "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group=
",
>          "MetricName": "tma_branch_mispredicts",
> -        "MetricThreshold": "tma_branch_mispredicts > 0.05 & tma_bad_spec=
ulation > 0.15",
> +        "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specu=
lation > 0.15",
>          "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Branch Misprediction.  These slots are either wast=
ed by uops fetched from an incorrectly speculated program path; or stalls w=
hen the out-of-order part of the machine needs to recover its state from a =
speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics=
: tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cos=
t, tma_mispredicts_resteers",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -170,456 +321,1919 @@
>          "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.BRANCH_RESTEER@ / (5 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
>          "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
>          "MetricName": "tma_branch_resteer",
> -        "MetricThreshold": "tma_branch_resteer > 0.05 & (tma_ifetch_late=
ncy > 0.15 & tma_frontend_bound > 0.2)",
> +        "MetricThreshold": "(tma_branch_resteer >0.05) & ((tma_ifetch_la=
tency >0.15) & ((tma_frontend_bound >0.20)))",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to the microcode sequencer (MS).",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.CISC@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> -        "MetricName": "tma_cisc",
> -        "MetricThreshold": "tma_cisc > 0.05 & (tma_ifetch_bandwidth > 0.=
1 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers",
> +        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_c=
lks + tma_unknown_branches",
> +        "MetricGroup": "Clocks;FetchLat;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_overlap",
> +        "MetricName": "tma_branch_resteers",
> +        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_laten=
cy > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers. Branch Resteers estimates the F=
rontend delay in fetching operations from corrected path; following all sor=
ts of miss-predicted branches. For example; branchy code with lots of miss-=
predictions might get categorized under Branch Resteers. Note the value of =
this node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_B=
RANCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of cycles due to backend =
bound stalls that are bounded by core restrictions and not attributed to an=
 outstanding load or stores, or resource limitation",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALLOC_RESTRICTIONS@ / (=
5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> -        "MetricName": "tma_core_bound",
> -        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0=
=2E1",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.1 power-performance optimized state (F=
aster wakeup time; Smaller power savings)",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
> +        "MetricGroup": "C0Wait;Clocks;TopdownL4;tma_L4_group;tma_seriali=
zing_operation_group",
> +        "MetricName": "tma_c01_wait",
> +        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to decode stalls.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> -        "MetricName": "tma_decode",
> -        "MetricThreshold": "tma_decode > 0.05 & (tma_ifetch_bandwidth > =
0.1 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.2 power-performance optimized state (S=
lower wakeup time; Larger power savings)",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
> +        "MetricGroup": "C0Wait;Clocks;TopdownL4;tma_L4_group;tma_seriali=
zing_operation_group",
> +        "MetricName": "tma_c02_wait",
> +        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to a machine clear that does not require th=
e use of microcode, classified as a fast nuke, due to memory ordering, memo=
ry disambiguation and memory renaming",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
> -        "MetricName": "tma_fast_nuke",
> -        "MetricThreshold": "tma_fast_nuke > 0.05 & (tma_machine_clears >=
 0.05 & tma_bad_speculation > 0.15)",
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU retired uops originated from CISC (complex instruction set computer) =
instruction",
> +        "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> +        "MetricName": "tma_cisc",
> +        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0=
=2E05 & tma_heavy_operations > 0.1",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU retired uops originated from CISC (complex instruction set computer)=
 instruction. A CISC instruction has multiple uops that are required to per=
form the instruction's functionality as in the case of read-modify-write as=
 an example. Since these instructions require multiple uops they may or may=
 not imply sub-optimal use of machine resources. Sample with: FRONTEND_RETI=
RED.MS_FLOWS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to frontend stalls.",
> -        "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ALL@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "Default;TopdownL1;tma_L1_group",
> -        "MetricName": "tma_frontend_bound",
> -        "MetricThreshold": "tma_frontend_bound > 0.2",
> -        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers as a result of Machine Clears",
> +        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation=
) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
> +        "MetricGroup": "BadSpec;Clocks;MachineClears;TopdownL4;tma_L4_gr=
oup;tma_branch_resteers_group;tma_issueMC",
> +        "MetricName": "tma_clears_resteers",
> +        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_rest=
eers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Machine Clears. S=
ample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, t=
ma_machine_clears, tma_microcode_sequencer, tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to instruction cache misses.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ICACHE@ / (5 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
> -        "MetricName": "tma_icache_misses",
> -        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_ifetch_laten=
cy > 0.15 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU was stalled due to instruction cache misses that hit in the L2 cache",
> +        "MetricExpr": "max(0, tma_icache_misses - tma_code_l2_miss)",
> +        "MetricGroup": "Clocks_Retired;FetchLat;IcMiss;Offcore;TopdownL4=
;tma_L4_group;tma_icache_misses_group",
> +        "MetricName": "tma_code_l2_hit",
> +        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses >=
 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to frontend bandwidth restrictions due to=
 decode, predecode, cisc, and other limitations.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (=
5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> -        "MetricName": "tma_ifetch_bandwidth",
> -        "MetricThreshold": "tma_ifetch_bandwidth > 0.1 & tma_frontend_bo=
und > 0.2",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU was stalled due to instruction cache misses that miss in the L2 cache=
",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_C=
ODE_RD / tma_info_thread_clks",
> +        "MetricGroup": "Clocks_Retired;FetchLat;IcMiss;Offcore;TopdownL4=
;tma_L4_group;tma_icache_misses_group",
> +        "MetricName": "tma_code_l2_miss",
> +        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses =
> 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to frontend latency restrictions due to i=
cache misses, itlb misses, branch detection, and resteer limitations.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> -        "MetricName": "tma_ifetch_latency",
> -        "MetricThreshold": "tma_ifetch_latency > 0.15 & tma_frontend_bou=
nd > 0.2",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the (first level) ITLB was missed by instructions fetches, =
that later on hit in second-level TLB (STLB)",
> +        "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
> +        "MetricGroup": "Clocks_Retired;FetchLat;MemoryTLB;TopdownL4;tma_=
L4_group;tma_itlb_misses_group",
> +        "MetricName": "tma_code_stlb_hit",
> +        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses >=
 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that retirement is stall=
ed due to a first level data TLB miss",
> -        "MetricExpr": "100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_a=
tom@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
> -        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s where the Second-level TLB (STLB) was missed by instruction fetches, perf=
orming a hardware page walk",
> +        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks",
> +        "MetricGroup": "Clocks_Retired;FetchLat;MemoryTLB;TopdownL4;tma_=
L4_group;tma_itlb_misses_group",
> +        "MetricName": "tma_code_stlb_miss",
> +        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses =
> 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that allocation and reti=
rement is stalled by the Frontend Cluster due to an Ifetch Miss, either Ica=
che or ITLB Miss",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "Ifetch",
> -        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
> -        "PublicDescription": "Percentage of time that allocation and ret=
irement is stalled by the Frontend Cluster due to an Ifetch Miss, either Ic=
ache or ITLB Miss. See Info.Ifetch_Bound",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for (instruction) code accesses",
> +        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_2=
M_4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
> +        "MetricGroup": "Clocks_Estimated;FetchLat;MemoryTLB;TopdownL5;tm=
a_L5_group;tma_code_stlb_miss_group",
> +        "MetricName": "tma_code_stlb_miss_2m",
> +        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb=
_miss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_front=
end_bound > 0.15",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that retirement is stall=
ed due to an L1 miss",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "Load_Store_Miss",
> -        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
> -        "PublicDescription": "Percentage of time that retirement is stal=
led due to an L1 miss. See Info.Load_Miss_Bound",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or (instruction) code accesses",
> +        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_4=
K / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
> +        "MetricGroup": "Clocks_Estimated;FetchLat;MemoryTLB;TopdownL5;tm=
a_L5_group;tma_code_stlb_miss_group",
> +        "MetricName": "tma_code_stlb_miss_4k",
> +        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb=
_miss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_front=
end_bound > 0.15",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that retirement is stall=
ed by the Memory Cluster due to a pipeline stall",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU=
_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "Mem_Exec",
> -        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
> -        "PublicDescription": "Percentage of time that retirement is stal=
led by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to contested acc=
esses",
> +        "MetricExpr": "((28 * tma_info_system_core_frequency - 3 * tma_i=
nfo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (27 * tma_info_system_core_fre=
quency - 3 * tma_info_system_core_frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP=
_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma=
_info_thread_clks",
> +        "MetricGroup": "BvMS;Clocks_Estimated;DataSharing;LockCont;Offco=
re;Snoop;TopdownL4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
> +        "MetricName": "tma_contested_accesses",
> +        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound=
 > 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Relate=
d metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_fal=
se_sharing, tma_machine_clears",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.ALL_BRANCHES@",
> -        "MetricName": "tma_info_br_inst_mix_ipbranch",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere Core non-memory issues were of a bottleneck",
> +        "MetricExpr": "max(0, tma_backend_bound - tma_memory_bound)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> +        "MetricName": "tma_core_bound",
> +        "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0=
=2E2",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "This metric represents fraction of slots w=
here Core non-memory issues were of a bottleneck.  Shortage in hardware com=
pute resources; or dependencies in software's instructions are both categor=
ized under Core Bound. Hence it may indicate the machine ran out of an out-=
of-order resource; certain execution units are overloaded or dependencies i=
n program's data- or instruction-flow are limiting the performance (e.g. FP=
-chained long-latency arithmetic operations)",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.CALL@",
> -        "MetricName": "tma_info_br_inst_mix_ipcall",
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to data-sharing =
accesses",
> +        "MetricExpr": "(27 * tma_info_system_core_frequency - 3 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD=
_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR=
=2EDEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_W=
ITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) /=
 tma_info_thread_clks",
> +        "MetricGroup": "BvMS;Clocks_Estimated;Offcore;Snoop;TopdownL4;tm=
a_L4_group;tma_issueSyncxn;tma_l3_bound_group",
> +        "MetricName": "tma_data_sharing",
> +        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to data-sharing=
 accesses. Data shared by multiple Logical Processors (even just read share=
d) may cause increased access latency due to cache coherency. Excessive dat=
a sharing can drastically harm multithreaded performance. Sample with: MEM_=
LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_syn=
chronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears=
",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.FAR_BRANCH@u",
> -        "MetricName": "tma_info_br_inst_mix_ipfarbranch",
> +        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to decode stalls.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.DECODE@ / (5 * cpu_atom=
@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> +        "MetricName": "tma_decode",
> +        "MetricThreshold": "(tma_decode >0.05) & ((tma_ifetch_bandwidth =
>0.10) & ((tma_frontend_bound >0.20)))",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was not taken",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RE=
TIRED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
> -        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken",
> +        "BriefDescription": "This metric represents fraction of cycles w=
here decoder-0 was the only active decoder",
> +        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu=
@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
> +        "MetricGroup": "DSBmiss;FetchBW;Slots_Estimated;TopdownL4;tma_L4=
_group;tma_issueD0;tma_mite_group",
> +        "MetricName": "tma_decoder0_alone",
> +        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & =
tma_fetch_bandwidth > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
where decoder-0 was the only active decoder. Related metrics: tma_few_uops_=
instructions",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was taken",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.COND_TAKEN@",
> -        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken",
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the Divider unit was active",
> +        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
> +        "MetricGroup": "BvCB;Clocks;TopdownL3;tma_L3_group;tma_core_boun=
d_group",
> +        "MetricName": "tma_divider",
> +        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
where the Divider unit was active. Divide and square root instructions are =
performed by the Divider unit and can take considerably longer latency than=
 integer or Floating Point addition; subtraction; or multiplication. Sample=
 with: ARITH.DIVIDER_ACTIVE",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per retired indirect call or j=
ump Branch Misprediction",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.INDIRECT@",
> -        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect",
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> +        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_=
clks",
> +        "MetricGroup": "MemoryBound;Stalls;TmaL3mem;TopdownL3;tma_L3_gro=
up;tma_memory_bound_group",
> +        "MetricName": "tma_dram_bound",
> +        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per retired return Branch Misp=
rediction",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.RETURN@",
> -        "MetricName": "tma_info_br_inst_mix_ipmisp_ret",
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to DSB (decoded uop cache) fetch pi=
peline",
> +        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
> +        "MetricGroup": "DSB;FetchBW;Slots_Estimated;TopdownL3;tma_L3_gro=
up;tma_fetch_bandwidth_group",
> +        "MetricName": "tma_dsb",
> +        "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to DSB (decoded uop cache) fetch p=
ipeline.  For example; inefficient utilization of the DSB cache structure o=
r bank conflict when reading from it; are categorized here",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per retired Branch Mispredicti=
on",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.ALL_BRANCHES@",
> -        "MetricName": "tma_info_br_inst_mix_ipmispredict",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to switches from DSB to MITE pipelines",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_threa=
d_clks",
> +        "MetricGroup": "Clocks;DSBmiss;FetchLat;TopdownL3;tma_L3_group;t=
ma_fetch_latency_group;tma_issueFB",
> +        "MetricName": "tma_dsb_switches",
> +        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to switches from DSB to MITE pipelines. The DSB (de=
coded i-cache) is a Uop Cache where the front-end directly delivers Uops (m=
icro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter =
latency and delivered higher bandwidth than the MITE (legacy instruction de=
code pipeline). Switching between the two pipelines can cause penalties hen=
ce this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.=
DSB_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_band=
width, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_i=
nfo_inst_mix_iptb, tma_lcp",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Ratio of all branches which mispredict",
> -        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom=
@BR_INST_RETIRED.ALL_BRANCHES@",
> -        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_ra=
tio",
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the Data TLB (DTLB) was missed by load accesses",
> +        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=
=3D0x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY -=
 MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
> +        "MetricGroup": "BvMT;Clocks_Estimated;MemoryTLB;TopdownL4;tma_L4=
_group;tma_issueTLB;tma_l1_bound_group",
> +        "MetricName": "tma_dtlb_load",
> +        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Tra=
nslation Look-aside Buffers) are processor caches for recently used entries=
 out of the Page Tables that are used to map virtual- to physical-addresses=
 by the operating system. This metric approximates the potential delay of d=
emand loads missing the first-level data TLB (assuming worst case scenario =
with back to back misses to different pages). This includes hitting in the =
second-level TLB (STLB) as well as performing a hardware page walk on an ST=
LB miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tm=
a_bottleneck_memory_data_tlbs, tma_dtlb_store",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Ratio between Mispredicted branches and unk=
nown branches",
> -        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom=
@BACLEARS.ANY@",
> -        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to=
_unknown_branch_ratio",
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles spent handling first-level data TLB store misses",
> +        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
> +        "MetricGroup": "BvMT;Clocks_Estimated;MemoryTLB;TopdownL4;tma_L4=
_group;tma_issueTLB;tma_store_bound_group",
> +        "MetricName": "tma_dtlb_store",
> +        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles spent handling first-level data TLB store misses.  As with ordin=
ary data caching; focus on improving data locality and reducing working-set=
 size to reduce DTLB overhead.  Additionally; consider using profile-guided=
 optimization (PGO) to collocate frequently-used data on the same page.  Tr=
y using larger page sizes for large amounts of frequently-used data. Sample=
 with: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_m=
emory_data_tlbs, tma_dtlb_load",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that allocation is stall=
ed due to load buffer full",
> -        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_=
atom@CPU_CLK_UNHALTED.CORE@",
> -        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles=
",
> +        "BriefDescription": "This metric roughly estimates how often CPU=
 was handling synchronizations due to False Sharing",
> +        "MetricExpr": "28 * tma_info_system_core_frequency * OCR.DEMAND_=
RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
> +        "MetricGroup": "BvMS;Clocks_Estimated;DataSharing;LockCont;Offco=
re;Snoop;TopdownL4;tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
> +        "MetricName": "tma_false_sharing",
> +        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates how often CP=
U was handling synchronizations due to False Sharing. False Sharing is a mu=
ltithreading hiccup; where multiple Logical Processors contend on different=
 data-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO=
=2EL3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronizatio=
n, tma_contested_accesses, tma_data_sharing, tma_machine_clears",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that allocation is stall=
ed due to memory reservation stations full",
> -        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> -        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles",
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to a machine clear that does not require th=
e use of microcode, classified as a fast nuke, due to memory ordering, memo=
ry disambiguation and memory renaming",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.FASTNUKE@ / (5 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
> +        "MetricName": "tma_fast_nuke",
> +        "MetricThreshold": "(tma_fast_nuke >0.05) & ((tma_machine_clears=
 >0.05) & ((tma_bad_speculation >0.15)))",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that allocation is stall=
ed due to store buffer full",
> -        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_=
atom@CPU_CLK_UNHALTED.CORE@",
> -        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycle=
s",
> +        "BriefDescription": "This metric does a *rough estimation* of ho=
w often L1D Fill Buffer unavailability limited additional L1D miss memory a=
ccess requests to proceed",
> +        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
> +        "MetricGroup": "BvMB;Clocks_Calculated;MemoryBW;TopdownL4;tma_L4=
_group;tma_issueBW;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
> +        "MetricName": "tma_fb_full",
> +        "MetricThreshold": "tma_fb_full > 0.3",
> +        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth=
, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_la=
tency, tma_streaming_stores",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Cycles Per Instruction",
> -        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_R=
ETIRED.ANY@",
> -        "MetricName": "tma_info_core_cpi",
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU was stalled due to Frontend bandwidth issues",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "max(0, tma_frontend_bound - tma_fetch_latency)",
> +        "MetricGroup": "Default;FetchBW;Frontend;Slots;TmaL2;TopdownL2;t=
ma_L2_group;tma_frontend_bound_group;tma_issueFB",
> +        "MetricName": "tma_fetch_bandwidth",
> +        "MetricThreshold": "tma_fetch_bandwidth > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend bandwidth issues.  For example; ineffici=
encies at the instruction decoders; or restrictions for caching in the DSB =
(decoded uops cache) are categorized under Fetch Bandwidth. In such cases; =
the Frontend typically delivers suboptimal amount of uops to the Backend. S=
ample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LA=
TENCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switche=
s, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_inf=
o_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions Per Cycle",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNH=
ALTED.CORE@",
> -        "MetricName": "tma_info_core_ipc",
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU was stalled due to Frontend latency issues",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC=
=2EUOP_DROPPING / tma_info_thread_slots",
> +        "MetricGroup": "Default;Frontend;Slots;TmaL2;TopdownL2;tma_L2_gr=
oup;tma_frontend_bound_group",
> +        "MetricName": "tma_fetch_latency",
> +        "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound=
 > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend latency issues.  For example; instructio=
n-cache misses; iTLB misses or fetch stalls after a branch misprediction ar=
e categorized under Frontend Latency. In such cases; the Frontend eventuall=
y delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_G=
E_16, FRONTEND_RETIRED.LATENCY_GE_8",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Uops Per Instruction",
> -        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ / cpu_atom@INST_RETIRE=
D.ANY@",
> -        "MetricName": "tma_info_core_upi",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring instructions that that are decoder into two or mor=
e uops",
> +        "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_seque=
ncer)",
> +        "MetricGroup": "Slots;TopdownL3;tma_L3_group;tma_heavy_operation=
s_group;tma_issueD0",
> +        "MetricName": "tma_few_uops_instructions",
> +        "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy=
_operations > 0.1",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring instructions that that are decoder into two or mo=
re uops. This highly-correlates with the number of uops in such instruction=
s. Related metrics: tma_decoder0_alone",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss hits in the L2",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> -        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l2hit",
> +        "BriefDescription": "This metric represents overall arithmetic f=
loating-point (FP) operations fraction the CPU has executed (retired)",
> +        "MetricExpr": "tma_x87_use + tma_fp_scalar + tma_fp_vector",
> +        "MetricGroup": "HPC;TopdownL3;Uops;tma_L3_group;tma_light_operat=
ions_group",
> +        "MetricName": "tma_fp_arith",
> +        "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > =
0.6",
> +        "PublicDescription": "This metric represents overall arithmetic =
floating-point (FP) operations fraction the CPU has executed (retired). Not=
e this metric's value may exceed its parent due to use of \"Uops\" CountDom=
ain and FMA double-counting",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss hits in the L3",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ /=
 cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> -        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l3hit",
> +        "BriefDescription": "This metric roughly estimates fraction of s=
lots the CPU retired uops as a result of handing Floating Point (FP) Assist=
s",
> +        "MetricExpr": "30 * ASSISTS.FP / tma_info_thread_slots",
> +        "MetricGroup": "HPC;Slots_Estimated;TopdownL5;tma_L5_group;tma_a=
ssists_group",
> +        "MetricName": "tma_fp_assists",
> +        "MetricThreshold": "tma_fp_assists > 0.1",
> +        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Floating Point (FP) Assis=
ts. FP Assist may apply when working with very small floating point values =
(so-called Denormals)",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss subsequently misses in the L3",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ =
/ cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> -        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l3miss",
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the Floating-Point Divider unit was active",
> +        "MetricExpr": "ARITH.FPDIV_ACTIVE / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_divider_group",
> +        "MetricName": "tma_fp_divider",
> +        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & t=
ma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that hit the L2",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.LOAD@",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2h=
it",
> +        "BriefDescription": "This metric approximates arithmetic floatin=
g-point (FP) scalar uops fraction the CPU has retired",
> +        "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / (tma_retiring * tm=
a_info_thread_slots)",
> +        "MetricGroup": "Compute;Flops;TopdownL4;Uops;tma_L4_group;tma_fp=
_arith_group;tma_issue2P",
> +        "MetricName": "tma_fp_scalar",
> +        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & t=
ma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) scalar uops fraction the CPU has retired. May overcount due t=
o FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, =
tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, t=
ma_port_1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that hit the L3",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.LOAD@",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3h=
it",
> +        "BriefDescription": "This metric approximates arithmetic floatin=
g-point (FP) vector uops fraction the CPU has retired aggregated across all=
 vector widths",
> +        "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / (tma_retiring * tm=
a_info_thread_slots)",
> +        "MetricGroup": "Compute;Flops;TopdownL4;Uops;tma_L4_group;tma_fp=
_arith_group;tma_issue2P",
> +        "MetricName": "tma_fp_vector",
> +        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & t=
ma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) vector uops fraction the CPU has retired aggregated across al=
l vector widths. May overcount due to FMA double counting. Related metrics:=
 tma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b=
, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utiliz=
ed_2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that subsequently misses the L3",
> -        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.LOAD@",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3m=
iss",
> +        "BriefDescription": "This metric approximates arithmetic FP vect=
or uops fraction the CPU has retired for 128-bit wide vectors",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slot=
s)",
> +        "MetricGroup": "Compute;Flops;TopdownL5;Uops;tma_L5_group;tma_fp=
_vector_group;tma_issue2P",
> +        "MetricName": "tma_fp_vector_128b",
> +        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0=
=2E1 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 128-bit wide vectors. May overcou=
nt due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256=
b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a pipeline block",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_store_bound_l1_bound",
> +        "BriefDescription": "This metric approximates arithmetic FP vect=
or uops fraction the CPU has retired for 256-bit wide vectors",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slot=
s)",
> +        "MetricGroup": "Compute;Flops;TopdownL5;Uops;tma_L5_group;tma_fp=
_vector_group;tma_issue2P",
> +        "MetricName": "tma_fp_vector_256b",
> +        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0=
=2E1 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 256-bit wide vectors. May overcou=
nt due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256=
b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement",
> -        "MetricExpr": "100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_at=
om@MEM_BOUND_STALLS.LOAD@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_store_bound_load_bound",
> +        "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_frontend_bound",
> +        "MetricThreshold": "tma_frontend_bound > 0.15",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to store buffer full",
> -        "MetricExpr": "100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu=
_atom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler",
> -        "MetricGroup": "load_store_bound",
> -        "MetricName": "tma_info_load_store_bound_store_bound",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring fused instructions , where one uop can represent m=
ultiple contiguous instructions",
> +        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED /=
 (tma_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "Branches;BvBO;Pipeline;Slots;TopdownL3;tma_L3_gr=
oup;tma_light_operations_group",
> +        "MetricName": "tma_fused_instructions",
> +        "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_ope=
rations > 0.6",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring fused instructions , where one uop can represent =
multiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of=
 legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under O=
ther_Light_Ops in MTL!)}",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory disambiguation",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ / c=
pu_atom@INST_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_disam=
b_pki",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring heavy-weight operations , instructions that requir=
e two or more uops or micro-coded sequences",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slot=
s",
> +        "MetricGroup": "Default;Retire;Slots;TmaL2;TopdownL2;tma_L2_grou=
p;tma_retiring_group",
> +        "MetricName": "tma_heavy_operations",
> +        "MetricThreshold": "tma_heavy_operations > 0.1",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring heavy-weight operations , instructions that requi=
re two or more uops or micro-coded sequences. This highly-correlates with t=
he uop length of these instructions/sequences.([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+]). Sample with: UOPS_R=
ETIRED.HEAVY",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to floating point assists",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_at=
om@INST_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_as=
sist_pki",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to instruction cache misses",
> +        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
> +        "MetricName": "tma_icache_misses",
> +        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to instruction cache misses. Sample with: FRONTEND_=
RETIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory ordering",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ / =
cpu_atom@INST_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_monuk=
e_pki",
> +        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to frontend bandwidth restrictions due to=
 decode, predecode, cisc, and other limitations.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_BANDWIDTH@ / (=
5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> +        "MetricName": "tma_ifetch_bandwidth",
> +        "MetricThreshold": "(tma_ifetch_bandwidth >0.10) & ((tma_fronten=
d_bound >0.20))",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory renaming",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MRN_NUKE@ / cpu_ato=
m@INST_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_mrn_p=
ki",
> +        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to frontend latency restrictions due to i=
cache misses, itlb misses, branch detection, and resteer limitations.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.FRONTEND_LATENCY@ / (5 =
* cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_frontend_bound_group",
> +        "MetricName": "tma_ifetch_latency",
> +        "MetricThreshold": "(tma_ifetch_latency >0.15) & ((tma_frontend_=
bound >0.20))",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to page faults",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_a=
tom@INST_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_=
fault_pki",
> +        "BriefDescription": "Branch Misprediction Cost: Cycles represent=
ing fraction of TMA slots wasted per non-speculative branch misprediction (=
retired JEClear)",
> +        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_s=
lots / 6 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
> +        "MetricGroup": "Bad;BrMispredicts;Core_Metric;tma_issueBM",
> +        "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
> +        "PublicDescription": "Branch Misprediction Cost: Cycles represen=
ting fraction of TMA slots wasted per non-speculative branch misprediction =
(retired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_bran=
ch_mispredicts, tma_mispredicts_resteers",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to self-modifying code",
> -        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INS=
T_RETIRED.ANY@",
> -        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_p=
ki",
> +        "BriefDescription": "Instructions per retired Mispredicts for co=
nditional non-taken branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
> +        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
> +        "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
> +        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of total non-speculative loads w=
ith an address aliasing block",
> -        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / cpu_atom@MEM=
_UOPS_RETIRED.ALL_LOADS@",
> -        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressalias=
ing",
> +        "BriefDescription": "Instructions per retired Mispredicts for co=
nditional taken branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
> +        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
> +        "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
> +        "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of total non-speculative loads w=
ith a store forward or unknown store address block",
> -        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom=
@MEM_UOPS_RETIRED.ALL_LOADS@",
> -        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk=
",
> +        "BriefDescription": "Instructions per retired Mispredicts for in=
direct CALL or JMP branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
> +        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
> +        "MetricName": "tma_info_bad_spec_ipmisp_indirect",
> +        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a first level data cache miss",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
> -        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss",
> +        "BriefDescription": "Instructions per retired Mispredicts for re=
turn branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
> +        "MetricGroup": "Bad;BrMispredicts;Inst_Metric",
> +        "MetricName": "tma_info_bad_spec_ipmisp_ret",
> +        "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of Memory Execution Bound due to=
 other block cases, such as pipeline conflicts, fences, etc",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
> -        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipe=
lineblks",
> +        "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear) (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;BadSpec;BrMispredicts;Inst_Metric",
> +        "MetricName": "tma_info_bad_spec_ipmispredict",
> +        "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a pagewalk",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@=
LD_HEAD.ANY_AT_RET@",
> -        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk",
> +        "BriefDescription": "Speculative to Retired ratio of all clears =
(covering Mispredicts and nukes)",
> +        "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRAN=
CHES + MACHINE_CLEARS.COUNT)",
> +        "MetricGroup": "BrMispredicts;Metric",
> +        "MetricName": "tma_info_bad_spec_spec_clears_ratio",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a second level TLB miss",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_at=
om@LD_HEAD.ANY_AT_RET@",
> -        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit",
> +        "BriefDescription": "Probability of Core Bound bottleneck hidden=
 by SMT-profiling artifacts",
> +        "MetricExpr": "(100 * (1 - tma_core_bound / tma_ports_utilizatio=
n if tma_core_bound < tma_ports_utilization else 1) if tma_info_system_smt_=
2t_utilization > 0.5 else 0)",
> +        "MetricGroup": "Cor;Metric;SMT",
> +        "MetricName": "tma_info_botlnk_l0_core_bound_likely",
> +        "MetricThreshold": "tma_info_botlnk_l0_core_bound_likely > 0.5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a store forward address match",
> -        "MetricExpr": "100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
> -        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwdi=
ng",
> +        "BriefDescription": "Total pipeline cost of DSB (uop cache) hits=
 - subset of the Instruction_Fetch_BW Bottleneck",
> +        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth =
/ (tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_d=
sb + tma_lsd + tma_ms)))",
> +        "MetricGroup": "DSB;Fed;FetchBW;Scaled_Slots;tma_issueFB",
> +        "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
> +        "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
> +        "PublicDescription": "Total pipeline cost of DSB (uop cache) hit=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_fro=
ntend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Load",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RE=
TIRED.ALL_LOADS@",
> -        "MetricName": "tma_info_mem_mix_ipload",
> +        "BriefDescription": "Total pipeline cost of DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck",
> +        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tm=
a_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches +=
 tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite +=
 tma_dsb + tma_lsd + tma_ms))",
> +        "MetricGroup": "DSBmiss;Fed;Scaled_Slots;tma_issueFB",
> +        "MetricName": "tma_info_botlnk_l2_dsb_misses",
> +        "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
> +        "PublicDescription": "Total pipeline cost of DSB (uop cache) mis=
ses - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_d=
sb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_inf=
o_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Instructions per Store",
> -        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RE=
TIRED.ALL_STORES@",
> -        "MetricName": "tma_info_mem_mix_ipstore",
> +        "BriefDescription": "Total pipeline cost of Instruction Cache mi=
sses - subset of the Big_Code Bottleneck",
> +        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (t=
ma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches =
+ tma_lcp + tma_dsb_switches))",
> +        "MetricGroup": "Fed;FetchLat;IcMiss;Scaled_Slots;tma_issueFL",
> +        "MetricName": "tma_info_botlnk_l2_ic_misses",
> +        "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of total non-speculative loads t=
hat perform one or more locks",
> -        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu=
_atom@MEM_UOPS_RETIRED.ALL_LOADS@",
> -        "MetricName": "tma_info_mem_mix_load_locks_ratio",
> +        "BriefDescription": "Percentage of time that retirement is stall=
ed due to a first level data TLB miss",
> +        "MetricExpr": "100 * (cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ + cpu_a=
tom@LD_HEAD.PGWALK_AT_RET@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
> +        "MetricName": "tma_info_bottleneck_%_dtlb_miss_bound_cycles",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of total non-speculative loads t=
hat are splits",
> -        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cp=
u_atom@MEM_UOPS_RETIRED.ALL_LOADS@",
> -        "MetricName": "tma_info_mem_mix_load_splits_ratio",
> +        "BriefDescription": "Percentage of time that allocation and reti=
rement is stalled by the Frontend Cluster due to an Ifetch Miss, either Ica=
che or ITLB Miss",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> +        "MetricGroup": "Ifetch",
> +        "MetricName": "tma_info_bottleneck_%_ifetch_miss_bound_cycles",
> +        "PublicDescription": "Percentage of time that allocation and ret=
irement is stalled by the Frontend Cluster due to an Ifetch Miss, either Ic=
ache or ITLB Miss. See Info.Ifetch_Bound",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Ratio of mem load uops to all uops",
> -        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_=
atom@UOPS_RETIRED.ALL@",
> -        "MetricName": "tma_info_mem_mix_memload_ratio",
> +        "BriefDescription": "Percentage of time that retirement is stall=
ed due to an L1 miss",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD@ / cpu_atom@=
CPU_CLK_UNHALTED.CORE@",
> +        "MetricGroup": "Load_Store_Miss",
> +        "MetricName": "tma_info_bottleneck_%_load_miss_bound_cycles",
> +        "PublicDescription": "Percentage of time that retirement is stal=
led due to an L1 miss. See Info.Load_Miss_Bound",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of time that the core is stalled=
 due to a TPAUSE or UMWAIT instruction",
> -        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricName": "tma_info_serialization _%_tpause_cycles",
> +        "BriefDescription": "Percentage of time that retirement is stall=
ed by the Memory Cluster due to a pipeline stall",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.ANY_AT_RET@ / cpu_atom@CPU=
_CLK_UNHALTED.CORE@",
> +        "MetricGroup": "Mem_Exec",
> +        "MetricName": "tma_info_bottleneck_%_mem_exec_bound_cycles",
> +        "PublicDescription": "Percentage of time that retirement is stal=
led by the Memory Cluster due to a pipeline stall. See Info.Mem_Exec_Bound",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Average CPU Utilization",
> -        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
> -        "MetricName": "tma_info_system_cpu_utilization",
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.ALL_BRANCHES@",
> +        "MetricName": "tma_info_br_inst_mix_ipbranch",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Fraction of cycles spent in Kernel mode",
> -        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE_P@k / cpu_atom@CPU=
_CLK_UNHALTED.CORE@",
> -        "MetricGroup": "Summary",
> -        "MetricName": "tma_info_system_kernel_utilization",
> +        "BriefDescription": "Instruction per (near) call (lower number m=
eans higher occurrence rate)",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.CALL@",
> +        "MetricName": "tma_info_br_inst_mix_ipcall",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> -        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@CPU_CL=
K_UNHALTED.REF_TSC@",
> -        "MetricGroup": "Power",
> -        "MetricName": "tma_info_system_turbo_utilization",
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_INST_RET=
IRED.FAR_BRANCH@u",
> +        "MetricName": "tma_info_br_inst_mix_ipfarbranch",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of all uops which are FPDiv uops=
",
> -        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / cpu_atom@UOP=
S_RETIRED.ALL@",
> -        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio",
> +        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was not taken",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / (cpu_atom@BR_MISP_RE=
TIRED.COND@ - cpu_atom@BR_MISP_RETIRED.COND_TAKEN@)",
> +        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_ntaken",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of all uops which are IDiv uops",
> -        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / cpu_atom@UOPS=
_RETIRED.ALL@",
> -        "MetricName": "tma_info_uop_mix_idiv_uop_ratio",
> +        "BriefDescription": "Instructions per retired conditional Branch=
 Misprediction where the branch was taken",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.COND_TAKEN@",
> +        "MetricName": "tma_info_br_inst_mix_ipmisp_cond_taken",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of all uops which are microcode =
ops",
> -        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / cpu_atom@UOPS_R=
ETIRED.ALL@",
> -        "MetricName": "tma_info_uop_mix_microcode_uop_ratio",
> +        "BriefDescription": "Instructions per retired indirect call or j=
ump Branch Misprediction",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.INDIRECT@",
> +        "MetricName": "tma_info_br_inst_mix_ipmisp_indirect",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired return Branch Misp=
rediction",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.RETURN@",
> +        "MetricName": "tma_info_br_inst_mix_ipmisp_ret",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per retired Branch Mispredicti=
on",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@BR_MISP_RET=
IRED.ALL_BRANCHES@",
> +        "MetricName": "tma_info_br_inst_mix_ipmispredict",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Ratio of all branches which mispredict",
> +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom=
@BR_INST_RETIRED.ALL_BRANCHES@",
> +        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_ra=
tio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Ratio between Mispredicted branches and unk=
nown branches",
> +        "MetricExpr": "cpu_atom@BR_MISP_RETIRED.ALL_BRANCHES@ / cpu_atom=
@BACLEARS.ANY@",
> +        "MetricName": "tma_info_br_mispredict_bound_branch_mispredict_to=
_unknown_branch_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are CALL or RET",
> +        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR=
_RETURN) / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;Branches;Fraction",
> +        "MetricName": "tma_info_branches_callret",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are non-taken con=
ditionals",
> +        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL=
_BRANCHES",
> +        "MetricGroup": "Bad;Branches;CodeGen;Fraction;PGO",
> +        "MetricName": "tma_info_branches_cond_nt",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are taken conditi=
onals",
> +        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_=
BRANCHES",
> +        "MetricGroup": "Bad;Branches;CodeGen;Fraction;PGO",
> +        "MetricName": "tma_info_branches_cond_tk",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches that are unconditional=
 (direct or indirect) jumps",
> +        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.CON=
D_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Bad;Branches;Fraction",
> +        "MetricName": "tma_info_branches_jump",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of branches of other types (not in=
dividually covered by other metrics in Info.Branches group)",
> +        "MetricExpr": "1 - (tma_info_branches_cond_nt + tma_info_branche=
s_cond_tk + tma_info_branches_callret + tma_info_branches_jump)",
> +        "MetricGroup": "Bad;Branches;Fraction",
> +        "MetricName": "tma_info_branches_other_branches",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of time that allocation is stall=
ed due to load buffer full",
> +        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.LD_BUF@ / cpu_=
atom@CPU_CLK_UNHALTED.CORE@",
> +        "MetricName": "tma_info_buffer_stalls_%_load_buffer_stall_cycles=
",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of time that allocation is stall=
ed due to memory reservation stations full",
> +        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.RSV@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> +        "MetricName": "tma_info_buffer_stalls_%_mem_rsv_stall_cycles",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of time that allocation is stall=
ed due to store buffer full",
> +        "MetricExpr": "100 * cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu_=
atom@CPU_CLK_UNHALTED.CORE@",
> +        "MetricName": "tma_info_buffer_stalls_%_store_buffer_stall_cycle=
s",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
> +        "MetricExpr": "(CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else tma=
_info_thread_clks)",
> +        "MetricGroup": "Count;SMT",
> +        "MetricName": "tma_info_core_core_clks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle across hyper-threads=
 (per physical core)",
> +        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
> +        "MetricGroup": "Core_Metric;Ret;SMT;TmaL1;TopdownL1;tma_L1_group=
",
> +        "MetricName": "tma_info_core_coreipc",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction",
> +        "MetricExpr": "cpu_atom@CPU_CLK_UNHALTED.CORE@ / cpu_atom@INST_R=
ETIRED.ANY@",
> +        "MetricName": "tma_info_core_cpi",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "uops Executed per Cycle",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / tma_info_thread_clks",
> +        "MetricGroup": "Metric;Power",
> +        "MetricName": "tma_info_core_epc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Floating Point Operations Per Cycle",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST=
_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_core_core_clks",
> +        "MetricGroup": "Core_Metric;Flops;Ret",
> +        "MetricName": "tma_info_core_flopc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Actual per-core usage of the Floating Point=
 non-X87 execution units (regardless of precision or vector-width)",
> +        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED=
=2EPORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
> +        "MetricGroup": "Cor;Core_Metric;Flops;HPC",
> +        "MetricName": "tma_info_core_fp_arith_utilization",
> +        "PublicDescription": "Actual per-core usage of the Floating Poin=
t non-X87 execution units (regardless of precision or vector-width). Values=
 > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common=
; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less com=
mon)",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per thread (logical-processor)=
",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@",
> +        "MetricGroup": "Backend;Cor;Metric;Pipeline;PortsUtil",
> +        "MetricName": "tma_info_core_ilp",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@CPU_CLK_UNH=
ALTED.CORE@",
> +        "MetricName": "tma_info_core_ipc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Uops Per Instruction",
> +        "MetricExpr": "cpu_atom@UOPS_RETIRED.ALL@ / cpu_atom@INST_RETIRE=
D.ANY@",
> +        "MetricName": "tma_info_core_upi",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
> +        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
> +        "MetricGroup": "DSB;Fed;FetchBW;Metric;tma_issueFB",
> +        "MetricName": "tma_info_frontend_dsb_coverage",
> +        "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_i=
nfo_thread_ipc / 6 > 0.35",
> +        "PublicDescription": "Fraction of Uops delivered by the DSB (aka=
 Decoded ICache; or Uop Cache). Related metrics: tma_dsb_switches, tma_fetc=
h_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misse=
s, tma_info_inst_mix_iptb, tma_lcp",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of cycles of a switch from t=
he DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for detai=
ls",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_S=
WITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
> +        "MetricGroup": "DSBmiss;Metric",
> +        "MetricName": "tma_info_frontend_dsb_switch_cost",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of Uops issued by front-end =
when it issued something",
> +        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=
=3D0x1@",
> +        "MetricGroup": "Fed;FetchBW;Metric",
> +        "MetricName": "tma_info_frontend_fetch_upc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Latency for L1 instruction cache mi=
sses",
> +        "MetricExpr": "ICACHE_DATA.STALLS / cpu@ICACHE_DATA.STALLS\\,cma=
sk\\=3D0x1\\,edge\\=3D0x1@",
> +        "MetricGroup": "Fed;FetchLat;IcMiss;Metric",
> +        "MetricName": "tma_info_frontend_icache_miss_latency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per non-speculative DSB miss (=
lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
> +        "MetricGroup": "DSBmiss;Fed;Inst_Metric",
> +        "MetricName": "tma_info_frontend_ipdsb_miss_ret",
> +        "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per speculative Unknown Branch=
 Misprediction (BAClear) (lower number means higher occurrence rate)",
> +        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
> +        "MetricGroup": "Fed;Metric",
> +        "MetricName": "tma_info_frontend_ipunknown_branch",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache true code cacheline misses per kil=
o instruction",
> +        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY=
",
> +        "MetricGroup": "IcMiss;Metric",
> +        "MetricName": "tma_info_frontend_l2mpki_code",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache speculative code cacheline misses =
per kilo instruction",
> +        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "IcMiss;Metric",
> +        "MetricName": "tma_info_frontend_l2mpki_code_all",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop=
 Stream Detector; aka Loop Cache)",
> +        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
> +        "MetricGroup": "Fed;LSD;Metric",
> +        "MetricName": "tma_info_frontend_lsd_coverage",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Taken Branches retired Per Cycle",
> +        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks=
",
> +        "MetricGroup": "Branches;FetchBW;Metric",
> +        "MetricName": "tma_info_frontend_tbpc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of cycles the front-end was =
delayed due to an Unknown Branch detection",
> +        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNK=
NOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
> +        "MetricGroup": "Fed;Metric",
> +        "MetricName": "tma_info_frontend_unknown_branch_cost",
> +        "PublicDescription": "Average number of cycles the front-end was=
 delayed due to an Unknown Branch detection. See Unknown_Branches node",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss hits in the L2",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_L2_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> +        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l2hit",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss doesn't hit in the L2",
> +        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ =
+ cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.I=
FETCH@",
> +        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l2miss",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss hits in the L3",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_LLC_HIT@ /=
 cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> +        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l3hit",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of ifetch miss bound stalls, whe=
re the ifetch miss subsequently misses in the L3",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.IFETCH_DRAM_HIT@ =
/ cpu_atom@MEM_BOUND_STALLS.IFETCH@",
> +        "MetricName": "tma_info_ifetch_miss_bound_%_ifetchmissbound_with=
_l3miss",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Branch instructions per taken branch",
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NE=
AR_TAKEN",
> +        "MetricGroup": "Branches;Fed;Metric;PGO",
> +        "MetricName": "tma_info_inst_mix_bptkbranch",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total number of retired Instructions",
> +        "MetricExpr": "INST_RETIRED.ANY",
> +        "MetricGroup": "Count;Summary;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_info_inst_mix_instructions",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "PublicDescription": "Total number of retired Instructions. Samp=
le with: INST_RETIRED.PREC_DIST",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic instruction =
(lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR =
+ FP_ARITH_INST_RETIRED.VECTOR)",
> +        "MetricGroup": "Flops;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith",
> +        "MetricThreshold": "tma_info_inst_mix_iparith < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic instruction=
 (lower number means higher occurrence rate). Values < 1 are possible due t=
o intentional FMA double counting. Approximated prior to BDW",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-=
bit instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
> +        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith_avx128",
> +        "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128=
-bit instruction (lower number means higher occurrence rate). Values < 1 ar=
e possible due to intentional FMA double counting",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit=
 instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
> +        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith_avx256",
> +        "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bi=
t instruction (lower number means higher occurrence rate). Values < 1 are p=
ossible due to intentional FMA double counting",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic Scalar Doubl=
e-Precision instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_D=
OUBLE",
> +        "MetricGroup": "Flops;FpScalar;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
> +        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Doub=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per FP Arithmetic Scalar Singl=
e-Precision instruction (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE",
> +        "MetricGroup": "Flops;FpScalar;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
> +        "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Sing=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Branches;Fed;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_ipbranch",
> +        "MetricThreshold": "tma_info_inst_mix_ipbranch < 8",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per (near) call (lower number =
means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> +        "MetricGroup": "Branches;Fed;Inst_Metric;PGO",
> +        "MetricName": "tma_info_inst_mix_ipcall",
> +        "MetricThreshold": "tma_info_inst_mix_ipcall < 200",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Floating Point (FP) Operat=
ion (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR =
+ 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.=
4_FLOPS + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
> +        "MetricGroup": "Flops;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_ipflop",
> +        "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load (lower number means h=
igher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> +        "MetricGroup": "InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_ipload",
> +        "MetricThreshold": "tma_info_inst_mix_ipload < 3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per PAUSE (lower number means =
higher occurrence rate)",
> +        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED=
=2EPAUSE_INST",
> +        "MetricGroup": "Flops;FpVector;InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_ippause",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store (lower number means =
higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> +        "MetricGroup": "InsType;Inst_Metric",
> +        "MetricName": "tma_info_inst_mix_ipstore",
> +        "MetricThreshold": "tma_info_inst_mix_ipstore < 8",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Software prefetch instruct=
ion (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurre=
nce rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / SW_PREFETCH_ACCESS.ANY",
> +        "MetricGroup": "Inst_Metric;Prefetches",
> +        "MetricName": "tma_info_inst_mix_ipswpf",
> +        "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per taken branch",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
> +        "MetricGroup": "Branches;Fed;FetchBW;Frontend;Inst_Metric;PGO;tm=
a_issueFB",
> +        "MetricName": "tma_info_inst_mix_iptb",
> +        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
> +        "PublicDescription": "Instructions per taken branch. Related met=
rics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwid=
th, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that hit the L2",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_L2_HIT@ / cp=
u_atom@MEM_BOUND_STALLS.LOAD@",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2h=
it",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that subsequently misses in the L2",
> +        "MetricExpr": "100 * (cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ + =
cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@) / cpu_atom@MEM_BOUND_STALLS.LOAD@=
",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l2m=
iss",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that hit the L3",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_LLC_HIT@ / c=
pu_atom@MEM_BOUND_STALLS.LOAD@",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3h=
it",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of memory bound stalls where ret=
irement is stalled due to an L1 miss that subsequently misses the L3",
> +        "MetricExpr": "100 * cpu_atom@MEM_BOUND_STALLS.LOAD_DRAM_HIT@ / =
cpu_atom@MEM_BOUND_STALLS.LOAD@",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_miss_bound_%_loadmissbound_with_l3m=
iss",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement due to a pipeline block",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ / cpu_ato=
m@CPU_CLK_UNHALTED.CORE@",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_store_bound_l1_bound",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles that the oldest=
 load of the load buffer is stalled at retirement",
> +        "MetricExpr": "100 * (cpu_atom@LD_HEAD.L1_BOUND_AT_RET@ + cpu_at=
om@MEM_BOUND_STALLS.LOAD@) / cpu_atom@CPU_CLK_UNHALTED.CORE@",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_store_bound_load_bound",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to store buffer full",
> +        "MetricExpr": "100 * (cpu_atom@MEM_SCHEDULER_BLOCK.ST_BUF@ / cpu=
_atom@MEM_SCHEDULER_BLOCK.ALL@) * tma_mem_scheduler",
> +        "MetricGroup": "load_store_bound",
> +        "MetricName": "tma_info_load_store_bound_store_bound",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory disambiguation",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.DISAMBIGUATION@ / c=
pu_atom@INST_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_disam=
b_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to floating point assists",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.FP_ASSIST@ / cpu_at=
om@INST_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_fp_as=
sist_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory ordering",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MEMORY_ORDERING@ / =
cpu_atom@INST_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_monuk=
e_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to memory renaming",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.MRN_NUKE@ / cpu_ato=
m@INST_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_mrn_p=
ki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to page faults",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.PAGE_FAULT@ / cpu_a=
tom@INST_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_page_=
fault_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of machine clears relativ=
e to thousands of instructions retired, due to self-modifying code",
> +        "MetricExpr": "1e3 * cpu_atom@MACHINE_CLEARS.SMC@ / cpu_atom@INS=
T_RETIRED.ANY@",
> +        "MetricName": "tma_info_machine_clear_bound_machine_clears_smc_p=
ki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads w=
ith an address aliasing block",
> +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.4K_ALIAS@ / cpu_atom@MEM=
_UOPS_RETIRED.ALL_LOADS@",
> +        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_adressalias=
ing",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads w=
ith a store forward or unknown store address block",
> +        "MetricExpr": "100 * cpu_atom@LD_BLOCKS.DATA_UNKNOWN@ / cpu_atom=
@MEM_UOPS_RETIRED.ALL_LOADS@",
> +        "MetricName": "tma_info_mem_exec_blocks_%_loads_with_storefwdblk=
",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a first level data cache miss",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.L1_MISS_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
> +        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_l1miss",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of Memory Execution Bound due to=
 other block cases, such as pipeline conflicts, fences, etc",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.OTHER_AT_RET@ / cpu_atom@L=
D_HEAD.ANY_AT_RET@",
> +        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_otherpipe=
lineblks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a pagewalk",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.PGWALK_AT_RET@ / cpu_atom@=
LD_HEAD.ANY_AT_RET@",
> +        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_pagewalk",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a second level TLB miss",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.DTLB_MISS_AT_RET@ / cpu_at=
om@LD_HEAD.ANY_AT_RET@",
> +        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_stlbhit",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of Memory Execution Bound due to=
 a store forward address match",
> +        "MetricExpr": "100 * cpu_atom@LD_HEAD.ST_ADDR_AT_RET@ / cpu_atom=
@LD_HEAD.ANY_AT_RET@",
> +        "MetricName": "tma_info_mem_exec_bound_%_loadhead_with_storefwdi=
ng",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RE=
TIRED.ALL_LOADS@",
> +        "MetricName": "tma_info_mem_mix_ipload",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store",
> +        "MetricExpr": "cpu_atom@INST_RETIRED.ANY@ / cpu_atom@MEM_UOPS_RE=
TIRED.ALL_STORES@",
> +        "MetricName": "tma_info_mem_mix_ipstore",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads t=
hat perform one or more locks",
> +        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.LOCK_LOADS@ / cpu=
_atom@MEM_UOPS_RETIRED.ALL_LOADS@",
> +        "MetricName": "tma_info_mem_mix_load_locks_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of total non-speculative loads t=
hat are splits",
> +        "MetricExpr": "100 * cpu_atom@MEM_UOPS_RETIRED.SPLIT_LOADS@ / cp=
u_atom@MEM_UOPS_RETIRED.ALL_LOADS@",
> +        "MetricName": "tma_info_mem_mix_load_splits_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Ratio of mem load uops to all uops",
> +        "MetricExpr": "1e3 * cpu_atom@MEM_UOPS_RETIRED.ALL_LOADS@ / cpu_=
atom@UOPS_RETIRED.ALL@",
> +        "MetricName": "tma_info_mem_mix_memload_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L1 data cache [GB / sec]",
> +        "MetricExpr": "tma_info_memory_l1d_cache_fill_bw",
> +        "MetricGroup": "Core_Metric;Mem;MemoryBW",
> +        "MetricName": "tma_info_memory_core_l1d_cache_fill_bw_2t",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L2 cache [GB / sec]",
> +        "MetricExpr": "tma_info_memory_l2_cache_fill_bw",
> +        "MetricGroup": "Core_Metric;Mem;MemoryBW",
> +        "MetricName": "tma_info_memory_core_l2_cache_fill_bw_2t",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "tma_info_memory_l3_cache_access_bw",
> +        "MetricGroup": "Core_Metric;Mem;MemoryBW;Offcore",
> +        "MetricName": "tma_info_memory_core_l3_cache_access_bw_2t",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> +        "MetricExpr": "tma_info_memory_l3_cache_fill_bw",
> +        "MetricGroup": "Core_Metric;Mem;MemoryBW",
> +        "MetricName": "tma_info_memory_core_l3_cache_fill_bw_2t",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fill Buffer (FB) hits per kilo instructions=
 for retired demand loads (L1D misses that merge into ongoing miss-handling=
 entries)",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_fb_hpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L1 data cache [GB / sec]",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time=
",
> +        "MetricGroup": "Mem;MemoryBW;Metric",
> +        "MetricName": "tma_info_memory_l1d_cache_fill_bw",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY=
",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l1mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or all demand loads (including speculative)",
> +        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.=
ANY",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l1mpki_load",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L2 cache [GB / sec]",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time=
",
> +        "MetricGroup": "Mem;MemoryBW;Metric",
> +        "MetricName": "tma_info_memory_l2_cache_fill_bw",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache hits per kilo instruction for all =
request types (including speculative)",
> +        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INS=
T_RETIRED.ANY",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l2hpki_all",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache hits per kilo instruction for all =
demand loads  (including speculative)",
> +        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.=
ANY",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l2hpki_load",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY=
",
> +        "MetricGroup": "Backend;CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l2mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all request types (including speculative)",
> +        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheHits;Mem;Metric;Offcore",
> +        "MetricName": "tma_info_memory_l2mpki_all",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all demand loads  (including speculative)",
> +        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED=
=2EANY",
> +        "MetricGroup": "CacheHits;Mem;Metric",
> +        "MetricName": "tma_info_memory_l2mpki_load",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Offcore requests (L2 cache miss) per kilo i=
nstruction for demand RFOs",
> +        "MetricExpr": "1e3 * L2_RQSTS.RFO_MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses;Metric;Offcore",
> +        "MetricName": "tma_info_memory_l2mpki_rfo",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data access bandwidth to=
 the L3 cache [GB / sec]",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / tma_in=
fo_system_time",
> +        "MetricGroup": "Mem;MemoryBW;Metric;Offcore",
> +        "MetricName": "tma_info_memory_l3_cache_access_bw",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average per-thread data fill bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_syst=
em_time",
> +        "MetricGroup": "Mem;MemoryBW;Metric",
> +        "MetricName": "tma_info_memory_l3_cache_fill_bw",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "L3 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY=
",
> +        "MetricGroup": "Mem;Metric",
> +        "MetricName": "tma_info_memory_l3mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Parallel L2 cache miss data reads",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD / OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
> +        "MetricGroup": "Memory_BW;Metric;Offcore",
> +        "MetricName": "tma_info_memory_latency_data_l2_mlp",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Latency for L2 cache miss demand Lo=
ads",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFF=
CORE_REQUESTS.DEMAND_DATA_RD",
> +        "MetricGroup": "Clocks_Latency;LockCont;Memory_Lat;Offcore",
> +        "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Parallel L2 cache miss demand Loads=
",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu=
@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
> +        "MetricGroup": "Memory_BW;Metric;Offcore",
> +        "MetricName": "tma_info_memory_latency_load_l2_mlp",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Latency for L3 cache miss demand Lo=
ads",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_=
RD / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
> +        "MetricGroup": "Clocks_Latency;Memory_Lat;Offcore",
> +        "MetricName": "tma_info_memory_latency_load_l3_miss_latency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand load operations (in core cycles)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MIS=
S_ANY",
> +        "MetricGroup": "Clocks_Latency;Mem;MemoryBound;MemoryLat",
> +        "MetricName": "tma_info_memory_load_miss_real_latency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "\"Bus lock\" per kilo instruction",
> +        "MetricExpr": "1e3 * SQ_MISC.BUS_LOCK / INST_RETIRED.ANY",
> +        "MetricGroup": "Mem;Metric",
> +        "MetricName": "tma_info_memory_mix_bus_lock_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Un-cacheable retired load per kilo instruct=
ion",
> +        "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY=
",
> +        "MetricGroup": "Mem;Metric",
> +        "MetricName": "tma_info_memory_mix_uc_load_pki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Memory-Level-Parallelism (average number of=
 L1 miss demand load when there is at least one such miss",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYC=
LES",
> +        "MetricGroup": "Mem;MemoryBW;MemoryBound;Metric",
> +        "MetricName": "tma_info_memory_mlp",
> +        "PublicDescription": "Memory-Level-Parallelism (average number o=
f L1 miss demand load when there is at least one such miss. Per-Logical Pro=
cessor)",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Rate of L2 HW prefetched lines that were no=
t used by demand accesses",
> +        "MetricExpr": "L2_LINES_OUT.USELESS_HWPF / (L2_LINES_OUT.SILENT =
+ L2_LINES_OUT.NON_SILENT)",
> +        "MetricGroup": "Metric;Prefetches",
> +        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
> +        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.=
15",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "STLB (2nd level TLB) code speculative misse=
s per kilo instruction (misses of any page-size that complete the page walk=
)",
> +        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.A=
NY",
> +        "MetricGroup": "Fed;MemoryTLB;Metric",
> +        "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "STLB (2nd level TLB) data load speculative =
misses per kilo instruction (misses of any page-size that complete the page=
 walk)",
> +        "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETI=
RED.ANY",
> +        "MetricGroup": "Mem;MemoryTLB;Metric",
> +        "MetricName": "tma_info_memory_tlb_load_stlb_mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Utilization of the core's Page Walker(s) se=
rving STLB misses triggered by instruction/Load/Store accesses",
> +        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK=
_PENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * tma_info_core_core_clks)",
> +        "MetricGroup": "Core_Metric;Mem;MemoryTLB",
> +        "MetricName": "tma_info_memory_tlb_page_walks_utilization",
> +        "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization >=
 0.5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "STLB (2nd level TLB) data store speculative=
 misses per kilo instruction (misses of any page-size that complete the pag=
e walk)",
> +        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RET=
IRED.ANY",
> +        "MetricGroup": "Mem;MemoryTLB;Metric",
> +        "MetricName": "tma_info_memory_tlb_store_stlb_mpki",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
> +        "MetricGroup": "Cor;Metric;Pipeline;PortsUtil;SMT",
> +        "MetricName": "tma_info_pipeline_execute",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of uops fetched from DSB per=
 cycle",
> +        "MetricExpr": "IDQ.DSB_UOPS / IDQ.DSB_CYCLES_ANY",
> +        "MetricGroup": "Fed;FetchBW;Metric",
> +        "MetricName": "tma_info_pipeline_fetch_dsb",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of uops fetched from LSD per=
 cycle",
> +        "MetricExpr": "LSD.UOPS / LSD.CYCLES_ACTIVE",
> +        "MetricGroup": "Fed;FetchBW;Metric",
> +        "MetricName": "tma_info_pipeline_fetch_lsd",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of uops fetched from MITE pe=
r cycle",
> +        "MetricExpr": "IDQ.MITE_UOPS / IDQ.MITE_CYCLES_ANY",
> +        "MetricGroup": "Fed;FetchBW;Metric",
> +        "MetricName": "tma_info_pipeline_fetch_mite",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per a microcode Assist invocat=
ion",
> +        "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
> +        "MetricGroup": "Inst_Metric;MicroSeq;Pipeline;Ret;Retire",
> +        "MetricName": "tma_info_pipeline_ipassist",
> +        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
> +        "PublicDescription": "Instructions per a microcode Assist invoca=
tion. See Assists tree node for details (lower number means higher occurren=
ce rate)",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of Uops retired in cycles wh=
ere at least one uop has retired",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_R=
ETIRED.SLOTS\\,cmask\\=3D0x1@",
> +        "MetricGroup": "Metric;Pipeline;Ret",
> +        "MetricName": "tma_info_pipeline_retire",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Estimated fraction of retirement-cycles dea=
ling with repeat instructions",
> +        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLO=
TS\\,cmask\\=3D0x1@",
> +        "MetricGroup": "Metric;MicroSeq;Pipeline;Ret",
> +        "MetricName": "tma_info_pipeline_strings_cycles",
> +        "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of time that the core is stalled=
 due to a TPAUSE or UMWAIT instruction",
> +        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricName": "tma_info_serialization _%_tpause_cycles",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles the processor is waiting=
 yet unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 po=
wer-performance optimized states",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C0_WAIT / tma_info_thread_clks",
> +        "MetricGroup": "C0Wait;Metric",
> +        "MetricName": "tma_info_system_c0_wait",
> +        "MetricThreshold": "tma_info_system_c0_wait > 0.05",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Measured Average Core Frequency for unhalte=
d processors [GHz]",
> +        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / t=
ma_info_system_time",
> +        "MetricGroup": "Power;Summary;System_Metric",
> +        "MetricName": "tma_info_system_core_frequency",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average CPU Utilization (percentage)",
> +        "MetricExpr": "tma_info_system_cpus_utilized / #num_cpus_online",
> +        "MetricGroup": "HPC;Metric;Summary",
> +        "MetricName": "tma_info_system_cpu_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average number of utilized CPUs",
> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
> +        "MetricGroup": "Metric;Summary",
> +        "MetricName": "tma_info_system_cpus_utilized",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average external Memory Bandwidth Use for r=
eads and writes [GB / sec]",
> +        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_=
REQUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
> +        "MetricGroup": "GB/sec;HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
> +        "MetricName": "tma_info_system_dram_bw_use",
> +        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_b=
andwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST=
_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / tma_info_system_time",
> +        "MetricGroup": "Cor;Flops;HPC;Metric",
> +        "MetricName": "tma_info_system_gflops",
> +        "PublicDescription": "Giga Floating Point Operations Per Second.=
 Aggregate across all supported options of: FP precisions, scalar and vecto=
r instructions, vector-width",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
> +        "MetricGroup": "Branches;Inst_Metric;OS",
> +        "MetricName": "tma_info_system_ipfarbranch",
> +        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction for the Operating Sy=
stem (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:=
k",
> +        "MetricGroup": "Metric;OS",
> +        "MetricName": "tma_info_system_kernel_cpi",
> +        "ScaleUnit": "1per_instr",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles spent in the Operating S=
ystem (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.TH=
READ",
> +        "MetricGroup": "Summary",
> +        "MetricName": "tma_info_system_kernel_utilization",
> +        "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "PerfMon Event Multiplexing accuracy indicat=
or",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THRE=
AD",
> +        "MetricGroup": "Clocks;Summary",
> +        "MetricName": "tma_info_system_mux",
> +        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_=
mux < 0.9",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total package Power in Watts",
> +        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time =
* 1e6)",
> +        "MetricGroup": "Power;SoC;System_Metric",
> +        "MetricName": "tma_info_system_power",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles where both hardware Logi=
cal Processors were active",
> +        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK=
_UNHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
> +        "MetricGroup": "Core_Metric;SMT",
> +        "MetricName": "tma_info_system_smt_2t_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Socket actual clocks when any core is activ=
e on that socket",
> +        "MetricExpr": "UNC_CLOCK.SOCKET",
> +        "MetricGroup": "Count;SoC",
> +        "MetricName": "tma_info_system_socket_clks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Run duration time in seconds",
> +        "MetricExpr": "duration_time",
> +        "MetricGroup": "Seconds;Summary",
> +        "MetricName": "tma_info_system_time",
> +        "MetricThreshold": "tma_info_system_time < 1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> +        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "tma_info_system_turbo_utilization",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Count;Pipeline",
> +        "MetricName": "tma_info_thread_clks",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction (per Logical Process=
or)",
> +        "MetricExpr": "1 / tma_info_thread_ipc",
> +        "MetricGroup": "Mem;Metric;Pipeline",
> +        "MetricName": "tma_info_thread_cpi",
> +        "ScaleUnit": "1per_instr",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "The ratio of Executed- by Issued-Uops",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
> +        "MetricGroup": "Cor;Metric;Pipeline",
> +        "MetricName": "tma_info_thread_execute_per_issue",
> +        "PublicDescription": "The ratio of Executed- by Issued-Uops. Rat=
io > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate=
 of \"execute\" at rename stage",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per Logical Process=
or)",
> +        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
> +        "MetricGroup": "Metric;Ret;Summary",
> +        "MetricName": "tma_info_thread_ipc",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Total issue-pipeline slots (per-Physical Co=
re till ICL; per-Logical Processor ICL onward)",
> +        "MetricExpr": "slots",
> +        "MetricGroup": "Count;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_info_thread_slots",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Physical Core issue-slots utili=
zed by this Logical Processor",
> +        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on e=
lse 1)",
> +        "MetricGroup": "Metric;SMT;TmaL1;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_info_thread_slots_utilization",
> +        "MetricgroupNoGroup": "TopdownL1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Uops Per Instruction",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIR=
ED.ANY",
> +        "MetricGroup": "Metric;Pipeline;Ret;Retire",
> +        "MetricName": "tma_info_thread_uoppi",
> +        "MetricThreshold": "tma_info_thread_uoppi > 1.05",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Uops per taken branch",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RE=
TIRED.NEAR_TAKEN",
> +        "MetricGroup": "Branches;Fed;FetchBW;Metric",
> +        "MetricName": "tma_info_thread_uptb",
> +        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are FPDiv uops=
",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.FPDIV@ / cpu_atom@UOP=
S_RETIRED.ALL@",
> +        "MetricName": "tma_info_uop_mix_fpdiv_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are IDiv uops",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.IDIV@ / cpu_atom@UOPS=
_RETIRED.ALL@",
> +        "MetricName": "tma_info_uop_mix_idiv_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are microcode =
ops",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.MS@ / cpu_atom@UOPS_R=
ETIRED.ALL@",
> +        "MetricName": "tma_info_uop_mix_microcode_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Percentage of all uops which are x87 uops",
> +        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / cpu_atom@UOPS_=
RETIRED.ALL@",
> +        "MetricName": "tma_info_uop_mix_x87_uop_ratio",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the Integer Divider unit was active",
> +        "MetricExpr": "tma_divider - tma_fp_divider",
> +        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_divider_group",
> +        "MetricName": "tma_int_divider",
> +        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & =
tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents overall Integer (Int=
) select operations fraction the CPU has executed (retired)",
> +        "MetricExpr": "tma_int_vector_128b + tma_int_vector_256b",
> +        "MetricGroup": "Pipeline;TopdownL3;Uops;tma_L3_group;tma_light_o=
perations_group",
> +        "MetricName": "tma_int_operations",
> +        "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operati=
ons > 0.6",
> +        "PublicDescription": "This metric represents overall Integer (In=
t) select operations fraction the CPU has executed (retired). Vector/Matrix=
 Int operations and shuffles are counted. Note this metric's value may exce=
ed its parent due to use of \"Uops\" CountDomain",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents 128-bit vector Integ=
er ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction t=
he CPU has retired",
> +        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_1=
28) / (tma_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;Uops;tma_L4=
_group;tma_int_operations_group;tma_issue2P",
> +        "MetricName": "tma_int_vector_128b",
> +        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operatio=
ns > 0.1 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents 128-bit vector Inte=
ger ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction =
the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_=
vector_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_=
1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents 256-bit vector Integ=
er ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fracti=
on the CPU has retired",
> +        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_25=
6 + INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;Uops;tma_L4=
_group;tma_int_operations_group;tma_issue2P",
> +        "MetricName": "tma_int_vector_256b",
> +        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operatio=
ns > 0.1 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents 256-bit vector Inte=
ger ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fract=
ion the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma=
_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_p=
ort_1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Instruction TLB (ITLB) misses",
> +        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
> +        "MetricName": "tma_itlb_misses",
> +        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRON=
TEND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled without loads missing the L1 Data (L1D) cache",
> +        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVIT=
Y.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
> +        "MetricGroup": "CacheHits;MemoryBound;Stalls;TmaL3mem;TopdownL3;=
tma_L3_group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
> +        "MetricName": "tma_l1_bound",
> +        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typ=
ically has the shortest latency.  However; in certain cases like loads bloc=
ked on older stores; a load might suffer due to high latency even though it=
 is being satisfied by the L1D. Another example is loads who miss in the TL=
B. These cases are characterized by execution unit stalls; while some non-c=
ompleted demand load lives in the machine without having that demand load m=
issing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics:=
 tma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_s=
witches, tma_ports_utilized_1",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimate=
s fraction of cycles with demand load accesses that hit the L1D cache",
> +        "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RE=
TIRED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYC=
LES_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
> +        "MetricGroup": "BvML;Clocks_Estimated;MemoryLat;TopdownL4;tma_L4=
_group;tma_l1_bound_group",
> +        "MetricName": "tma_l1_latency_dependency",
> +        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bou=
nd > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimat=
es fraction of cycles with demand load accesses that hit the L1D cache. The=
 short latency of the L1D cache may be exposed in pointer-chasing memory ac=
cess patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled due to L2 cache accesses by loads",
> +        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVIT=
Y.STALLS_L2_MISS) / tma_info_thread_clks",
> +        "MetricGroup": "BvML;CacheHits;MemoryBound;Stalls;TmaL3mem;Topdo=
wnL3;tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_l2_bound",
> +        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L=
1 misses/L2 hits) can improve the latency and increase performance. Sample =
with: MEM_LOAD_RETIRED.L2_HIT",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
ith demand load accesses that hit the L2 cache under unloaded scenarios (po=
ssibly L2 latency limited)",
> +        "MetricExpr": "3 * tma_info_system_core_frequency * MEM_LOAD_RET=
IRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
> +        "MetricGroup": "Clocks_Retired;MemoryLat;TopdownL4;tma_L4_group;=
tma_l2_bound_group",
> +        "MetricName": "tma_l2_hit_latency",
> +        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0=
=2E05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
with demand load accesses that hit the L2 cache under unloaded scenarios (p=
ossibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 h=
its) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled due to loads accesses to L3 cache or contended with a sibling Core=
",
> +        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY=
=2ESTALLS_L3_MISS) / tma_info_thread_clks",
> +        "MetricGroup": "CacheHits;MemoryBound;Stalls;TmaL3mem;TopdownL3;=
tma_L3_group;tma_memory_bound_group",
> +        "MetricName": "tma_l3_bound",
> +        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to loads accesses to L3 cache or contended with a sibling Cor=
e.  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency =
and increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited)",
> +        "MetricExpr": "(12 * tma_info_system_core_frequency - 3 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_RETIRE=
D.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)) / tma_info_thread_clks",
> +        "MetricGroup": "BvML;Clocks_Estimated;MemoryLat;TopdownL4;tma_L4=
_group;tma_issueLat;tma_l3_bound_group;tma_overlap",
> +        "MetricName": "tma_l3_hit_latency",
> +        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.=
05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma=
_bottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma=
_store_latency",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles C=
PU was stalled due to Length Changing Prefixes (LCPs)",
> +        "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;FetchLat;TopdownL3;tma_L3_group;tma_fetch=
_latency_group;tma_issueFB",
> +        "MetricName": "tma_lcp",
> +        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & t=
ma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU was stalled due to Length Changing Prefixes (LCPs). Using proper compil=
er flags or Intel Compiler by default will certainly avoid this. Related me=
trics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring light-weight operations , instructions that requir=
e no more than one uop (micro-operation)",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
> +        "MetricGroup": "Default;Retire;Slots;TmaL2;TopdownL2;tma_L2_grou=
p;tma_retiring_group",
> +        "MetricName": "tma_light_operations",
> +        "MetricThreshold": "tma_light_operations > 0.6",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring light-weight operations , instructions that requi=
re no more than one uop (micro-operation). This correlates with total numbe=
r of instructions used by the program. A uops-per-instruction (see UopPI me=
tric) ratio of 1 or less should be expected for decently optimized code run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved. ([ICL+] Note this may undercount due to approx=
imation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DI=
ST",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port for Load operations",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_=
core_clks)",
> +        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_=
utilized_3m_group",
> +        "MetricName": "tma_load_op_utilization",
> +        "MetricThreshold": "tma_load_op_utilization > 0.6",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port for Load operations. Sample with=
: UOPS_DISPATCHED.PORT_2_3_10",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the (first level) DTLB was missed by load accesses, that la=
ter on hit in second-level TLB (STLB)",
> +        "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL5;tma_L5_grou=
p;tma_dtlb_load_group",
> +        "MetricName": "tma_load_stlb_hit",
> +        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0=
=2E1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s where the Second-level TLB (STLB) was missed by load accesses, performing=
 a hardware page walk",
> +        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_cl=
ks",
> +        "MetricGroup": "Clocks_Calculated;MemoryTLB;TopdownL5;tma_L5_gro=
up;tma_dtlb_load_group",
> +        "MetricName": "tma_load_stlb_miss",
> +        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > =
0.1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 1 GB pages f=
or data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_load_stlb_miss_group",
> +        "MetricName": "tma_load_stlb_miss_1g",
> +        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COM=
PLETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_load_stlb_miss_group",
> +        "MetricName": "tma_load_stlb_miss_2m",
> +        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_load_stlb_miss_group",
> +        "MetricName": "tma_load_stlb_miss_4k",
> +        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU spent handling cache misses due to lock operations",
> +        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQS=
TS.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (=
10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;LockCont;Offcore;TopdownL4;tma_L4_group;t=
ma_issueRFO;tma_l1_bound_group",
> +        "MetricName": "tma_lock_latency",
> +        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU spent handling cache misses due to lock operations. Due to the micr=
oarchitecture handling of locks; they are classified as L1_Bound regardless=
 of what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_L=
OADS. Related metrics: tma_store_latency",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
> +        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_co=
re_core_clks / 2",
> +        "MetricGroup": "FetchBW;LSD;Slots_Estimated;TopdownL3;tma_L3_gro=
up;tma_fetch_bandwidth_group",
> +        "MetricName": "tma_lsd",
> +        "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to LSD (Loop Stream Detector) unit=
=2E  LSD typically does well sustaining Uop supply. However; in some rare c=
ases; optimal uop-delivery could not be reached for small loops whose size =
(in terms of number of uops) does not suit well the LSD structure",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Machine Clears",
> +        "MetricExpr": "max(0, tma_bad_speculation - tma_branch_mispredic=
ts)",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group=
",
> +        "MetricName": "tma_machine_clears",
> +        "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculati=
on > 0.15",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Machine Clears.  These slots are either wasted by =
uops fetched prior to the clear; or stalls the out-of-order portion of the =
machine needs to recover its state after the clear. For example; this can h=
appen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Mod=
ifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics=
: tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested=
_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode=
_sequencer, tma_ms_switches",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ere the core's performance was likely hurt due to approaching bandwidth lim=
its of external memory - DRAM ([SPR-HBM] and/or HBM)",
> +        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS=
_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
> +        "MetricGroup": "BvMB;Clocks;MemoryBW;Offcore;TopdownL4;tma_L4_gr=
oup;tma_dram_bound_group;tma_issueBW",
> +        "MetricName": "tma_mem_bandwidth",
> +        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0=
=2E1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
here the core's performance was likely hurt due to approaching bandwidth li=
mits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heur=
istic assumes that a similar off-core traffic is generated by all IA cores.=
 This metric does not aggregate non-data-read requests by this logical proc=
essor; requests from other IA Logical Processors/Physical Cores/sockets; or=
 other non-IA devices like GPU; hence the maximum external memory bandwidth=
 limits may or may not be approached when this metric is flagged (see Uncor=
e counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidt=
h, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles wh=
ere the performance was likely hurt due to latency from external memory - D=
RAM ([SPR-HBM] and/or HBM)",
> +        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUT=
STANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
> +        "MetricGroup": "BvML;Clocks;MemoryLat;Offcore;TopdownL4;tma_L4_g=
roup;tma_dram_bound_group;tma_issueLat",
> +        "MetricName": "tma_mem_latency",
> +        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
here the performance was likely hurt due to latency from external memory - =
DRAM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from =
other Logical Processors/Physical Cores/sockets (see Uncore counters for th=
at). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_laten=
cy",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to memory reservation stalls in which a sch=
eduler is not able to accept uops",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> +        "MetricName": "tma_mem_scheduler",
> +        "MetricThreshold": "(tma_mem_scheduler >0.10) & ((tma_resource_b=
ound >0.20) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots th=
e Memory subsystem within the Backend was a bottleneck",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slot=
s",
> +        "MetricGroup": "Backend;Default;Slots;TmaL2;TopdownL2;tma_L2_gro=
up;tma_backend_bound_group",
> +        "MetricName": "tma_memory_bound",
> +        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots t=
he Memory subsystem within the Backend was a bottleneck.  Memory Bound esti=
mates fraction of slots where pipeline is likely stalled due to demand load=
 or store instructions. This accounts mainly for (1) non-completed in-fligh=
t memory demand loads which coincides with execution units starvation; in a=
ddition to (2) cases where stores could impose backpressure on the pipeline=
 when many of them get buffered at the same time (less common out of the tw=
o)",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to LFENCE Instructions",
> +        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> +        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
> +        "MetricName": "tma_memory_fence",
> +        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_op=
eration > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring memory operations , uops for memory load or store =
accesses",
> +        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma=
_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "Pipeline;Slots;TopdownL3;tma_L3_group;tma_light_=
operations_group",
> +        "MetricName": "tma_memory_operations",
> +        "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_oper=
ations > 0.6",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
> +        "MetricExpr": "UOPS_RETIRED.MS / tma_info_thread_slots",
> +        "MetricGroup": "MicroSeq;Slots;TopdownL3;tma_L3_group;tma_heavy_=
operations_group;tma_issueMC;tma_issueMS",
> +        "MetricName": "tma_microcode_sequencer",
> +        "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_o=
perations > 0.1",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The=
 MS is used for CISC instructions not supported by the default decoders (li=
ke repeat move strings; or CPUID); or by microcode assists used to address =
some operation modes (like in Floating Point assists). These cases can ofte=
n be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck=
_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears,=
 tma_ms_switches",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Percentage of all uops which are x87 uops",
> -        "MetricExpr": "100 * cpu_atom@UOPS_RETIRED.X87@ / cpu_atom@UOPS_=
RETIRED.ALL@",
> -        "MetricName": "tma_info_uop_mix_x87_uop_ratio",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers as a result of Branch Mispredicti=
on at execution stage",
> +        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * IN=
T_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
> +        "MetricGroup": "BadSpec;BrMispredicts;BvMP;Clocks;TopdownL4;tma_=
L4_group;tma_branch_resteers_group;tma_issueBM",
> +        "MetricName": "tma_mispredicts_resteers",
> +        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch=
_resteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Branch Mispredict=
ion at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related=
 metrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_b=
ad_spec_branch_misprediction_cost",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to Instruction Table Lookaside Buffer (IT=
LB) misses.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.ITLB@ / (5 * cpu_atom@C=
PU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_latency_group",
> -        "MetricName": "tma_itlb_misses",
> -        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_ifetch_latency=
 > 0.15 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to the MITE pipeline (the legacy de=
code pipeline)",
> +        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_=
info_core_core_clks / 2",
> +        "MetricGroup": "DSBmiss;FetchBW;Slots_Estimated;TopdownL3;tma_L3=
_group;tma_fetch_bandwidth_group",
> +        "MetricName": "tma_mite",
> +        "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to the MITE pipeline (the legacy d=
ecode pipeline). This pipeline is used for code that was not pre-cached in =
the DSB or LSD. For example; inefficiencies due to asymmetric decoders; use=
 of long immediate or LCP can manifest as MITE fetch bandwidth bottleneck. =
Sample with: FRONTEND_RETIRED.ANY_DSB_MISS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the total number of issue slots that=
 were not consumed by the backend because allocation is stalled due to a ma=
chine clear (nuke) of any kind including memory ordering and memory disambi=
guation",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.MACHINE_CLEARS@ =
/ (5 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL2;tma_L2_group;tma_bad_speculation_group=
",
> -        "MetricName": "tma_machine_clears",
> -        "MetricThreshold": "tma_machine_clears > 0.05 & tma_bad_speculat=
ion > 0.15",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "BriefDescription": "This metric estimates penalty in terms of p=
ercentage of([SKL+] injected blend uops out of all Uops Issued , the Count =
Domain; [ADL+] cycles)",
> +        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;TopdownL5;tma_L5_group;tma_issueMV;tma_po=
rts_utilized_0_group",
> +        "MetricName": "tma_mixing_vectors",
> +        "MetricThreshold": "tma_mixing_vectors > 0.05",
> +        "PublicDescription": "This metric estimates penalty in terms of =
percentage of([SKL+] injected blend uops out of all Uops Issued , the Count=
 Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investig=
ating. Read more in Appendix B1 of the Optimizations Guide for this topic. =
Related metrics: tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to memory reservation stalls in which a sch=
eduler is not able to accept uops",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.MEM_SCHEDULER@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> -        "MetricName": "tma_mem_scheduler",
> -        "MetricThreshold": "tma_mem_scheduler > 0.1 & (tma_resource_boun=
d > 0.2 & tma_backend_bound > 0.1)",
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to the Microcode Sequencer (MS) uni=
t - see Microcode_Sequencer node for details",
> +        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmas=
k\\=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_c=
lks / 2",
> +        "MetricGroup": "MicroSeq;Slots_Estimated;TopdownL3;tma_L3_group;=
tma_fetch_bandwidth_group",
> +        "MetricName": "tma_ms",
> +        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s when the CPU was stalled due to switches of uop delivery to the Microcode=
 Sequencer (MS)",
> +        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=
=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
> +        "MetricGroup": "Clocks_Estimated;FetchLat;MicroSeq;TopdownL3;tma=
_L3_group;tma_fetch_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_i=
ssueSO",
> +        "MetricName": "tma_ms_switches",
> +        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric estimates the fraction of cycl=
es when the CPU was stalled due to switches of uop delivery to the Microcod=
e Sequencer (MS). Commonly used instructions are optimized for delivery by =
the DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Ce=
rtain operations cannot be handled natively by the execution pipeline; and =
must be performed by microcode (small programs injected into the execution =
stream). Switching to the MS too often can negatively impact performance. T=
he MS is designated to deliver long uop flows required by CISC instructions=
 like CPUID; or uncommon conditions like Floating Point Assists when dealin=
g with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: =
tma_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_m=
achine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing=
_operation",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring branch instructions that were not fused",
> +        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANC=
HES - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "Branches;BvBO;Pipeline;Slots;TopdownL3;tma_L3_gr=
oup;tma_light_operations_group",
> +        "MetricName": "tma_non_fused_branches",
> +        "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_ope=
rations > 0.6",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring branch instructions that were not fused. Non-cond=
itional branches like direct JMP or CALL would count here. Can be used to e=
xamine fusible conditional jumps that were not fused",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -628,82 +2242,389 @@
>          "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.NON_MEM_SCHEDULER@ / (5=
 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
>          "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
>          "MetricName": "tma_non_mem_scheduler",
> -        "MetricThreshold": "tma_non_mem_scheduler > 0.1 & (tma_resource_=
bound > 0.2 & tma_backend_bound > 0.1)",
> +        "MetricThreshold": "(tma_non_mem_scheduler >0.10) & ((tma_resour=
ce_bound >0.20) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring NOP (no op) instructions",
> +        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_re=
tiring * tma_info_thread_slots)",
> +        "MetricGroup": "BvBO;Pipeline;Slots;TopdownL4;tma_L4_group;tma_o=
ther_light_ops_group",
> +        "MetricName": "tma_nop_instructions",
> +        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light=
_ops > 0.3 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring NOP (no op) instructions. Compilers often use NOP=
s for certain address alignments - e.g. start address of a function or loop=
 body. Sample with: INST_RETIRED.NOP",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to a machine clear that requires the use of=
 microcode (slow nuke)",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
> +        "MetricName": "tma_nuke",
> +        "MetricThreshold": "(tma_nuke >0.05) & ((tma_machine_clears >0.0=
5) & ((tma_bad_speculation >0.15)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to other common frontend stalls not categ=
orized.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (5 * cpu_atom@=
CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> +        "MetricName": "tma_other_fb",
> +        "MetricThreshold": "(tma_other_fb >0.05) & ((tma_ifetch_bandwidt=
h >0.10) & ((tma_frontend_bound >0.20)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents the remaining light =
uops fraction the CPU has executed - remaining means not covered by other s=
ibling nodes",
> +        "MetricExpr": "max(0, tma_light_operations - (tma_fp_arith + tma=
_int_operations + tma_memory_operations + tma_fused_instructions + tma_non_=
fused_branches))",
> +        "MetricGroup": "Pipeline;Slots;TopdownL3;tma_L3_group;tma_light_=
operations_group",
> +        "MetricName": "tma_other_light_ops",
> +        "MetricThreshold": "tma_other_light_ops > 0.3 & tma_light_operat=
ions > 0.6",
> +        "PublicDescription": "This metric represents the remaining light=
 uops fraction the CPU has executed - remaining means not covered by other =
sibling nodes. May undercount due to FMA double counting",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU was stalled due to other cases of misprediction (non-retired x86 branc=
hes or other types)",
> +        "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED=
=2EALL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
> +        "MetricGroup": "BrMispredicts;BvIO;Slots;TopdownL3;tma_L3_group;=
tma_branch_mispredicts_group",
> +        "MetricName": "tma_other_mispredicts",
> +        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Nukes (Machine Clears) not related to memory orderi=
ng",
> +        "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMO=
RY_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
> +        "MetricGroup": "BvIO;Machine_Clears;Slots;TopdownL3;tma_L3_group=
;tma_machine_clears_group",
> +        "MetricName": "tma_other_nukes",
> +        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears =
> 0.1 & tma_bad_speculation > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric roughly estimates fraction of s=
lots the CPU retired uops as a result of handing Page Faults",
> +        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_thread_slots",
> +        "MetricGroup": "Slots_Estimated;TopdownL5;tma_L5_group;tma_assis=
ts_group",
> +        "MetricName": "tma_page_faults",
> +        "MetricThreshold": "tma_page_faults > 0.05",
> +        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Page Faults. A Page Fault=
 may apply on first application access to a memory page. Note operating sys=
tem handling of page faults accounts for the majority of its cost",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd=
 branch)",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
> +        "MetricGroup": "Compute;Core_Clocks;TopdownL6;tma_L6_group;tma_a=
lu_op_utilization_group;tma_issue2P",
> +        "MetricName": "tma_port_0",
> +        "MetricThreshold": "tma_port_0 > 0.6",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2n=
d branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_sca=
lar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_=
128b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 1 (ALU)",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
> +        "MetricGroup": "Core_Clocks;TopdownL6;tma_L6_group;tma_alu_op_ut=
ilization_group;tma_issue2P",
> +        "MetricName": "tma_port_1",
> +        "MetricThreshold": "tma_port_1 > 0.6",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPA=
TCHED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_=
128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_por=
t_0, tma_port_6, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simp=
le ALU)",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
> +        "MetricGroup": "Core_Clocks;TopdownL6;tma_L6_group;tma_alu_op_ut=
ilization_group;tma_issue2P",
> +        "MetricName": "tma_port_6",
> +        "MetricThreshold": "tma_port_6 > 0.6",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and sim=
ple ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scal=
ar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_1=
28b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU performance was potentially limited due to Core computation issues (n=
on divider-related)",
> +        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (=
EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / =
tma_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EX=
E_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * =
EXE_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
> +        "MetricGroup": "Clocks;PortsUtil;TopdownL3;tma_L3_group;tma_core=
_bound_group",
> +        "MetricName": "tma_ports_utilization",
> +        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_boun=
d > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU performance was potentially limited due to Core computation issues (=
non divider-related).  Two distinct categories can be attributed into this =
metric: (1) heavy data-dependency among contiguous instructions would manif=
est in this metric - such cases are often referred to as low Instruction Le=
vel Parallelism (ILP). (2) Contention on some hardware execution unit other=
 than Divider. For example; when there are too many multiply operations",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles C=
PU executed no uops on any execution port (Logical Processor cycles since I=
CL, Physical Core cycles otherwise)",
> +        "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + max(RS.EMPTY_RE=
SOURCE - RESOURCE_STALLS.SCOREBOARD, 0)) / tma_info_thread_clks * (CYCLE_AC=
TIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_port=
s_utilization_group",
> +        "MetricName": "tma_ports_utilized_0",
> +        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utili=
zation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU executed no uops on any execution port (Logical Processor cycles since =
ICL, Physical Core cycles otherwise). Long-latency instructions like divide=
s may contribute to this metric",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the CPU executed total of 1 uop per cycle on all execution ports (Logi=
cal Processor cycles since ICL, Physical Core cycles otherwise)",
> +        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_issu=
eL1;tma_ports_utilization_group",
> +        "MetricName": "tma_ports_utilized_1",
> +        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utili=
zation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
where the CPU executed total of 1 uop per cycle on all execution ports (Log=
ical Processor cycles since ICL, Physical Core cycles otherwise). This can =
be due to heavy data-dependency among software instructions; or over oversu=
bscribing a particular hardware resource. In some other cases with high 1_P=
ort_Utilized and L1_Bound; this metric can point to L1 data-cache latency b=
ottleneck that may not necessarily manifest with complete execution starvat=
ion (due to the short L1 latency e.g. walking a linked list) - looking at t=
he assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related=
 metrics: tma_l1_bound",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles C=
PU executed total of 2 uops per cycle on all execution ports (Logical Proce=
ssor cycles since ICL, Physical Core cycles otherwise)",
> +        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> +        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;PortsUtil;TopdownL4;tma_L4_group;tma_issu=
e2P;tma_ports_utilization_group",
> +        "MetricName": "tma_ports_utilized_2",
> +        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_util=
ization > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU executed total of 2 uops per cycle on all execution ports (Logical Proc=
essor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorizatio=
n -most compilers feature auto-Vectorization options today- reduces pressur=
e on the execution ports as multiple elements are calculated with same uop.=
 Sample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tm=
a_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, t=
ma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles C=
PU executed total of 3 or more uops per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise)",
> +        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> +        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
> +        "MetricGroup": "BvCB;Clocks;PortsUtil;TopdownL4;tma_L4_group;tma=
_ports_utilization_group",
> +        "MetricName": "tma_ports_utilized_3m",
> +        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_util=
ization > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU executed total of 3 or more uops per cycle on all execution ports (Logi=
cal Processor cycles since ICL, Physical Core cycles otherwise). Sample wit=
h: UOPS_EXECUTED.CYCLES_GE_3",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to wrong predecodes.",
> +        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (5 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> +        "MetricName": "tma_predecode",
> +        "MetricThreshold": "(tma_predecode >0.05) & ((tma_ifetch_bandwid=
th >0.10) & ((tma_frontend_bound >0.20)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to the physical register file unable to acc=
ept an entry (marble stalls)",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (5 * cpu_at=
om@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> +        "MetricName": "tma_register",
> +        "MetricThreshold": "(tma_register >0.10) & ((tma_resource_bound =
>0.20) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to the reorder buffer being full (ROB stall=
s)",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (5 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> +        "MetricName": "tma_reorder_buffer",
> +        "MetricThreshold": "(tma_reorder_buffer >0.10) & ((tma_resource_=
bound >0.20) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a resource limitation",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.ALL@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@) - tma_core_bound",
> +        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> +        "MetricName": "tma_resource_bound",
> +        "MetricThreshold": "(tma_resource_bound >0.20) & ((tma_backend_b=
ound >0.10))",
> +        "MetricgroupNoGroup": "TopdownL2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
> +        "DefaultMetricgroupName": "TopdownL1",
> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
> +        "MetricGroup": "Default;TopdownL1;tma_L1_group",
> +        "MetricName": "tma_retiring",
> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> +        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "PublicDescription": "This category represents fraction of slots=
 utilized by useful work i.e. issued uops that eventually get retired. Idea=
lly; all pipeline slots would be attributed to the Retiring category.  Reti=
ring of 100% would indicate the maximum Pipeline_Width throughput was achie=
ved.  Maximizing Retiring typically increases the Instructions-per-cycle (s=
ee IPC metric). Note that a high Retiring value does not necessary mean the=
re is no room for more performance.  For example; Heavy-operations or Micro=
code Assists are categorized under Retiring. They often indicate suboptimal=
 performance and can often be optimized or avoided. Sample with: UOPS_RETIR=
ED.SLOTS",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to scoreboards from the instruction queue (=
IQ), jump execution unit (JEU), or microcode sequencer (MS)",
> +        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> +        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> +        "MetricName": "tma_serialization",
> +        "MetricThreshold": "(tma_serialization >0.10) & ((tma_resource_b=
ound >0.20) & ((tma_backend_bound >0.10)))",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU issue-pipeline was stalled due to serializing operations",
> +        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks=
 + tma_c02_wait",
> +        "MetricGroup": "BvIO;Clocks;PortsUtil;TopdownL3;tma_L3_group;tma=
_core_bound_group;tma_issueSO",
> +        "MetricName": "tma_serializing_operation",
> +        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_b=
ound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU issue-pipeline was stalled due to serializing operations. Instructi=
ons like CPUID; WRMSR or LFENCE serialize the out-of-order execution which =
may limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related met=
rics: tma_ms_switches",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring Shuffle operations of 256-bit vector size (FP or I=
nteger)",
> +        "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES /=
 (tma_retiring * tma_info_thread_slots)",
> +        "MetricGroup": "HPC;Pipeline;Slots;TopdownL4;tma_L4_group;tma_ot=
her_light_ops_group",
> +        "MetricName": "tma_shuffles_256b",
> +        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_op=
s > 0.3 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring Shuffle operations of 256-bit vector size (FP or =
Integer). Shuffles may incur slow cross \"vector lane\" data transfers",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to PAUSE Instructions",
> +        "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> +        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
> +        "MetricGroup": "Clocks;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
> +        "MetricName": "tma_slow_pause",
> +        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTE=
D.PAUSE_INST",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles ha=
ndling memory load split accesses - load that cross 64-byte cache line boun=
dary",
> +        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCK=
S.NO_SR / tma_info_thread_clks",
> +        "MetricGroup": "Clocks_Calculated;TopdownL4;tma_L4_group;tma_l1_=
bound_group",
> +        "MetricName": "tma_split_loads",
> +        "MetricThreshold": "tma_split_loads > 0.3",
> +        "PublicDescription": "This metric estimates fraction of cycles h=
andling memory load split accesses - load that cross 64-byte cache line bou=
ndary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents rate of split store =
accesses",
> +        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_cor=
e_clks",
> +        "MetricGroup": "Core_Utilization;TopdownL4;tma_L4_group;tma_issu=
eSpSt;tma_store_bound_group",
> +        "MetricName": "tma_split_stores",
> +        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0=
=2E2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents rate of split store=
 accesses.  Consider aligning your data to the 64-byte cache line granulari=
ty. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric measures fraction of cycles whe=
re the Super Queue (SQ) was full taking into account all request-types and =
both hardware SMT threads (Logical Processors)",
> +        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_=
info_thread_clks",
> +        "MetricGroup": "BvMB;Clocks;MemoryBW;Offcore;TopdownL4;tma_L4_gr=
oup;tma_issueBW;tma_l3_bound_group",
> +        "MetricName": "tma_sq_full",
> +        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric measures fraction of cycles wh=
ere the Super Queue (SQ) was full taking into account all request-types and=
 both hardware SMT threads (Logical Processors). Related metrics: tma_bottl=
eneck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma=
_mem_bandwidth",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates how often CPU was sta=
lled  due to RFO store memory accesses; RFO store issue a read-for-ownershi=
p request before the write",
> +        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_cl=
ks",
> +        "MetricGroup": "MemoryBound;Stalls;TmaL3mem;TopdownL3;tma_L3_gro=
up;tma_memory_bound_group",
> +        "MetricName": "tma_store_bound",
> +        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0=
=2E2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often CPU was st=
alled  due to RFO store memory accesses; RFO store issue a read-for-ownersh=
ip request before the write. Even though store accesses do not typically st=
all out-of-order CPUs; there are few cases where stores can lead to actual =
stalls. This metric will be flagged should RFO stores be a bottleneck. Samp=
le with: MEM_INST_RETIRED.ALL_STORES",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric roughly estimates fraction of c=
ycles when the memory subsystem had loads blocked since they could not forw=
ard data from earlier (in program order) overlapping stores",
> +        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_cl=
ks",
> +        "MetricGroup": "Clocks_Estimated;TopdownL4;tma_L4_group;tma_l1_b=
ound_group",
> +        "MetricName": "tma_store_fwd_blk",
> +        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates fraction of =
cycles when the memory subsystem had loads blocked since they could not for=
ward data from earlier (in program order) overlapping stores. To streamline=
 memory operations in the pipeline; a load can avoid waiting for memory if =
a prior in-flight store is writing the data that the load wants to read (st=
ore forwarding process). However; in some cases the load may be blocked for=
 a significant time pending the store forward. For example; when the prior =
store is writing a smaller region than the load is reading",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU spent handling L1D store misses",
> +        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RE=
TIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOC=
K_LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
> +        "MetricGroup": "BvML;Clocks_Estimated;LockCont;MemoryLat;Offcore=
;TopdownL4;tma_L4_group;tma_issueRFO;tma_issueSL;tma_overlap;tma_store_boun=
d_group",
> +        "MetricName": "tma_store_latency",
> +        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > =
0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU spent handling L1D store misses. Store accesses usually less impact =
out-of-order core performance; however; holding resources for longer time c=
an lead into undesired implications (e.g. contention on L1D fill-buffer ent=
ries - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma=
_l3_hit_latency, tma_lock_latency",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port for Store operations",
> +        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_=
7_8) / (4 * tma_info_core_core_clks)",
> +        "MetricGroup": "Core_Execution;TopdownL5;tma_L5_group;tma_ports_=
utilized_3m_group",
> +        "MetricName": "tma_store_op_utilization",
> +        "MetricThreshold": "tma_store_op_utilization > 0.6",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port for Store operations. Sample wit=
h: UOPS_DISPATCHED.PORT_7_8",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to a machine clear that requires the use of=
 microcode (slow nuke)",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BAD_SPECULATION.NUKE@ / (5 * cpu=
_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_machine_clears_group",
> -        "MetricName": "tma_nuke",
> -        "MetricThreshold": "tma_nuke > 0.05 & (tma_machine_clears > 0.05=
 & tma_bad_speculation > 0.15)",
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the TLB was missed by store accesses, hitting in the second=
-level TLB (STLB)",
> +        "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL5;tma_L5_grou=
p;tma_dtlb_store_group",
> +        "MetricName": "tma_store_stlb_hit",
> +        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store >=
 0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound =
> 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to other common frontend stalls not categ=
orized.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.OTHER@ / (5 * cpu_atom@=
CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> -        "MetricName": "tma_other_fb",
> -        "MetricThreshold": "tma_other_fb > 0.05 & (tma_ifetch_bandwidth =
> 0.1 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s where the STLB was missed by store accesses, performing a hardware page w=
alk",
> +        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_cor=
e_clks",
> +        "MetricGroup": "Clocks_Calculated;MemoryTLB;TopdownL5;tma_L5_gro=
up;tma_dtlb_store_group",
> +        "MetricName": "tma_store_stlb_miss",
> +        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store =
> 0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not delivered by the frontend due to wrong predecodes.",
> -        "MetricExpr": "cpu_atom@TOPDOWN_FE_BOUND.PREDECODE@ / (5 * cpu_a=
tom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_ifetch_bandwidth_grou=
p",
> -        "MetricName": "tma_predecode",
> -        "MetricThreshold": "tma_predecode > 0.05 & (tma_ifetch_bandwidth=
 > 0.1 & tma_frontend_bound > 0.2)",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 1 GB pages f=
or data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_CO=
MPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_store_stlb_miss_group",
> +        "MetricName": "tma_store_stlb_miss_1g",
> +        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to the physical register file unable to acc=
ept an entry (marble stalls)",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REGISTER@ / (5 * cpu_at=
om@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> -        "MetricName": "tma_register",
> -        "MetricThreshold": "tma_register > 0.1 & (tma_resource_bound > 0=
=2E2 & tma_backend_bound > 0.1)",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK=
_COMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_store_stlb_miss_group",
> +        "MetricName": "tma_store_stlb_miss_2m",
> +        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to the reorder buffer being full (ROB stall=
s)",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.REORDER_BUFFER@ / (5 * =
cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> -        "MetricName": "tma_reorder_buffer",
> -        "MetricThreshold": "tma_reorder_buffer > 0.1 & (tma_resource_bou=
nd > 0.2 & tma_backend_bound > 0.1)",
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_CO=
MPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "Clocks_Estimated;MemoryTLB;TopdownL6;tma_L6_grou=
p;tma_store_stlb_miss_group",
> +        "MetricName": "tma_store_stlb_miss_4k",
> +        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of cycles the core is sta=
lled due to a resource limitation",
> -        "MetricExpr": "tma_backend_bound - tma_core_bound",
> -        "MetricGroup": "TopdownL2;tma_L2_group;tma_backend_bound_group",
> -        "MetricName": "tma_resource_bound",
> -        "MetricThreshold": "tma_resource_bound > 0.2 & tma_backend_bound=
 > 0.1",
> -        "MetricgroupNoGroup": "TopdownL2",
> +        "BriefDescription": "This metric estimates how often CPU was sta=
lled  due to Streaming store memory accesses; Streaming store optimize out =
a read request required by RFO stores",
> +        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thre=
ad_clks",
> +        "MetricGroup": "Clocks_Estimated;MemoryBW;Offcore;TopdownL4;tma_=
L4_group;tma_issueSmSt;tma_store_bound_group",
> +        "MetricName": "tma_streaming_stores",
> +        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound=
 > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often CPU was st=
alled  due to Streaming store memory accesses; Streaming store optimize out=
 a read request required by RFO stores. Even though store accesses do not t=
ypically stall out-of-order CPUs; there are few cases where stores can lead=
 to actual stalls. This metric will be flagged should Streaming stores be a=
 bottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: t=
ma_fb_full",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that resul=
t in retirement slots",
> -        "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_atom@TOPDOWN_RETIRING.ALL@ / (5 * cpu_atom@CP=
U_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "Default;TopdownL1;tma_L1_group",
> -        "MetricName": "tma_retiring",
> -        "MetricThreshold": "tma_retiring > 0.75",
> -        "MetricgroupNoGroup": "TopdownL1;Default",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to new branch address clears",
> +        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_=
clks",
> +        "MetricGroup": "BigFootprint;BvBC;Clocks;FetchLat;TopdownL4;tma_=
L4_group;tma_branch_resteers_group",
> +        "MetricName": "tma_unknown_branches",
> +        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_res=
teers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to new branch address clears. These are fetched bra=
nches the Branch Prediction Unit was unable to recognize (e.g. first time t=
he branch is fetched or hitting BTB capacity limit) hence called Unknown Br=
anches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
>      {
> -        "BriefDescription": "Counts the number of issue slots that were =
not consumed by the backend due to scoreboards from the instruction queue (=
IQ), jump execution unit (JEU), or microcode sequencer (MS)",
> -        "MetricExpr": "cpu_atom@TOPDOWN_BE_BOUND.SERIALIZATION@ / (5 * c=
pu_atom@CPU_CLK_UNHALTED.CORE@)",
> -        "MetricGroup": "TopdownL3;tma_L3_group;tma_resource_bound_group",
> -        "MetricName": "tma_serialization",
> -        "MetricThreshold": "tma_serialization > 0.1 & (tma_resource_boun=
d > 0.2 & tma_backend_bound > 0.1)",
> +        "BriefDescription": "This metric serves as an approximation of l=
egacy x87 usage",
> +        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.=
THREAD",
> +        "MetricGroup": "Compute;TopdownL4;Uops;tma_L4_group;tma_fp_arith=
_group",
> +        "MetricName": "tma_x87_use",
> +        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
> +        "PublicDescription": "This metric serves as an approximation of =
legacy x87 usage. It accounts for instructions beyond X87 FP arithmetic ope=
rations; hence may be used as a thermometer to avoid X87 high usage and pre=
ferably upgrade to modern ISA. See Tip under Tuning Hint",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_atom"
>      },
> @@ -715,8 +2636,8 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution ports for ALU operations.",
> -        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_0@ + cpu_core@UOPS=
_DISPATCHED.PORT_1@ + cpu_core@UOPS_DISPATCHED.PORT_5_11@ + cpu_core@UOPS_D=
ISPATCHED.PORT_6@) / (5 * tma_info_core_core_clks)",
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution ports for ALU operations",
> +        "MetricExpr": "(UOPS_DISPATCHED.PORT_0 + UOPS_DISPATCHED.PORT_1 =
+ UOPS_DISPATCHED.PORT_5_11 + UOPS_DISPATCHED.PORT_6) / (5 * tma_info_core_=
core_clks)",
>          "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_gro=
up",
>          "MetricName": "tma_alu_op_utilization",
>          "MetricThreshold": "tma_alu_op_utilization > 0.4",
> @@ -725,17 +2646,17 @@
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops delivered by the Microcode_Sequencer as a result of Assis=
ts",
> -        "MetricExpr": "78 * cpu_core@ASSISTS.ANY@ / tma_info_thread_slot=
s",
> +        "MetricExpr": "78 * ASSISTS.ANY / tma_info_thread_slots",
>          "MetricGroup": "BvIO;TopdownL4;tma_L4_group;tma_microcode_sequen=
cer_group",
>          "MetricName": "tma_assists",
> -        "MetricThreshold": "tma_assists > 0.1 & (tma_microcode_sequencer=
 > 0.05 & tma_heavy_operations > 0.1)",
> +        "MetricThreshold": "tma_assists > 0.1 & tma_microcode_sequencer =
> 0.05 & tma_heavy_operations > 0.1",
>          "PublicDescription": "This metric estimates fraction of slots th=
e CPU retired uops delivered by the Microcode_Sequencer as a result of Assi=
sts. Assists are long sequences of uops that are required in certain corner=
-cases for operations that cannot be handled natively by the execution pipe=
line. For example; when working with very small floating point values (so-c=
alled Denormals); the FP units are not set up to perform these operations n=
atively. Instead; a sequence of instructions to perform the computation on =
the Denormals is injected into the pipeline. Since these microcode sequence=
s might be dozens of uops long; Assists can be extremely deleterious to per=
formance and they can be avoided in many cases. Sample with: ASSISTS.ANY",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops as a result of handing SSE to AVX* or AVX* to SSE transit=
ion Assists.",
> -        "MetricExpr": "63 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_thr=
ead_slots",
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU retired uops as a result of handing SSE to AVX* or AVX* to SSE transit=
ion Assists",
> +        "MetricExpr": "63 * ASSISTS.SSE_AVX_MIX / tma_info_thread_slots",
>          "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
>          "MetricName": "tma_avx_assists",
>          "MetricThreshold": "tma_avx_assists > 0.1",
> @@ -745,7 +2666,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots =
where no uops are being delivered due to a lack of required resources for a=
ccepting new uops in the Backend",
>          "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_core@topdown\\-be\\-bound@ / (cpu_core@topdow=
n\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retir=
ing@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots=
",
>          "MetricGroup": "BvOB;Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_backend_bound",
>          "MetricThreshold": "tma_backend_bound > 0.2",
> @@ -762,46 +2683,151 @@
>          "MetricName": "tma_bad_speculation",
>          "MetricThreshold": "tma_bad_speculation > 0.15",
>          "MetricgroupNoGroup": "TopdownL1;Default",
> -        "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example.",
> +        "PublicDescription": "This category represents fraction of slots=
 wasted due to incorrect speculations. This include slots used to issue uop=
s that do not eventually get retired and slots for which the issue-pipeline=
 was blocked due to recovery from earlier incorrect speculation. For exampl=
e; wasted work due to miss-predicted branches are categorized under Bad Spe=
culation category. Incorrect data speculation followed by Memory Ordering N=
ukes is another example",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Total pipeline cost of instruction fetch re=
lated bottlenecks by large code footprint programs (i-side cache; TLB and B=
TB misses)",
> +        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_=
icache_misses + tma_unknown_branches) / (tma_icache_misses + tma_itlb_misse=
s + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)",
> +        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
> +        "MetricName": "tma_bottleneck_big_code",
> +        "MetricThreshold": "tma_bottleneck_big_code > 20",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of instructions used fo=
r program control-flow - a subset of the Retiring category in TMA",
> +        "MetricExpr": "100 * ((BR_INST_RETIRED.ALL_BRANCHES + 2 * BR_INS=
T_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_slots)",
> +        "MetricGroup": "BvBO;Ret",
> +        "MetricName": "tma_bottleneck_branching_overhead",
> +        "MetricThreshold": "tma_bottleneck_branching_overhead > 5",
> +        "PublicDescription": "Total pipeline cost of instructions used f=
or program control-flow - a subset of the Retiring category in TMA. Example=
s include function calls; loops and alignments. (A lower bound)",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Bandwidth related bottlenecks",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound))=
 * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory=
_bound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_=
dram_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + t=
ma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (=
tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound=
 + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_store_fwd_blk + =
tma_l1_latency_dependency + tma_lock_latency + tma_split_loads + tma_fb_ful=
l)))",
> +        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
> +        "MetricName": "tma_bottleneck_cache_memory_bandwidth",
> +        "MetricThreshold": "tma_bottleneck_cache_memory_bandwidth > 20",
> +        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_inf=
o_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Latency related bottlenecks",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound))=
 * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dr=
am_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesse=
s + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_boun=
d * tma_l2_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_b=
ound + tma_store_bound) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound =
+ tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_l=
1_latency_dependency / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_=
dependency + tma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memor=
y_bound * (tma_l1_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma=
_dram_bound + tma_store_bound)) * (tma_lock_latency / (tma_dtlb_load + tma_=
store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_lo=
ads + tma_fb_full)) + tma_memory_bound * (tma_l1_bound / (tma_l1_bound + tm=
a_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_split=
_loads / (tma_dtlb_load + tma_store_fwd_blk + tma_l1_latency_dependency + t=
ma_lock_latency + tma_split_loads + tma_fb_full)) + tma_memory_bound * (tma=
_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound=
 + tma_store_bound)) * (tma_split_stores / (tma_store_latency + tma_false_s=
haring + tma_split_stores + tma_streaming_stores + tma_dtlb_store)) + tma_m=
emory_bound * (tma_store_bound / (tma_l1_bound + tma_l2_bound + tma_l3_boun=
d + tma_dram_bound + tma_store_bound)) * (tma_store_latency / (tma_store_la=
tency + tma_false_sharing + tma_split_stores + tma_streaming_stores + tma_d=
tlb_store)))",
> +        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
> +        "MetricName": "tma_bottleneck_cache_memory_latency",
> +        "MetricThreshold": "tma_bottleneck_cache_memory_latency > 20",
> +        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tm=
a_mem_latency",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost when the execution is c=
ompute-bound - an estimation",
> +        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divide=
r + tma_serializing_operation + tma_ports_utilization) + tma_core_bound * (=
tma_ports_utilization / (tma_divider + tma_serializing_operation + tma_port=
s_utilization)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_port=
s_utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
> +        "MetricGroup": "BvCB;Cor;tma_issueComp",
> +        "MetricName": "tma_bottleneck_compute_bound_est",
> +        "MetricThreshold": "tma_bottleneck_compute_bound_est > 20",
> +        "PublicDescription": "Total pipeline cost when the execution is =
compute-bound - an estimation. Covers Core Bound when High ILP as well as w=
hen long-latency execution units are busy",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of instruction fetch ba=
ndwidth related bottlenecks (when the front-end could not sustain operation=
s delivery to the back-end)",
> +        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microco=
de_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_=
latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_misses +=
 tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches) - (1 -=
 INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_=
fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma_clears_restee=
rs + tma_mispredicts_resteers * tma_other_mispredicts / tma_branch_mispredi=
cts) / (tma_mispredicts_resteers + tma_clears_resteers + tma_unknown_branch=
es)) / (tma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_=
switches + tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_ms / (tm=
a_mite + tma_dsb + tma_lsd + tma_ms))) - tma_bottleneck_big_code",
> +        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
> +        "MetricName": "tma_bottleneck_instruction_fetch_bw",
> +        "MetricThreshold": "tma_bottleneck_instruction_fetch_bw > 20",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of irregular execution =
(e.g",
> +        "MetricExpr": "100 * ((1 - INST_RETIRED.REP_ITERATION / cpu@UOPS=
_RETIRED.MS\\,cmask\\=3D0x1@) * (tma_fetch_latency * (tma_ms_switches + tma=
_branch_resteers * (tma_clears_resteers + tma_mispredicts_resteers * tma_ot=
her_mispredicts / tma_branch_mispredicts) / (tma_mispredicts_resteers + tma=
_clears_resteers + tma_unknown_branches)) / (tma_icache_misses + tma_itlb_m=
isses + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches)=
 + tma_fetch_bandwidth * tma_ms / (tma_mite + tma_dsb + tma_lsd + tma_ms)) =
+ 10 * tma_microcode_sequencer * tma_other_mispredicts / tma_branch_mispred=
icts * tma_branch_mispredicts + tma_machine_clears * tma_other_nukes / tma_=
other_nukes + tma_core_bound * (tma_serializing_operation + RS.EMPTY_RESOUR=
CE / tma_info_thread_clks * tma_ports_utilized_0) / (tma_divider + tma_seri=
alizing_operation + tma_ports_utilization) + tma_microcode_sequencer / (tma=
_few_uops_instructions + tma_microcode_sequencer) * (tma_assists / tma_micr=
ocode_sequencer) * tma_heavy_operations)",
> +        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
> +        "MetricName": "tma_bottleneck_irregular_overhead",
> +        "MetricThreshold": "tma_bottleneck_irregular_overhead > 10",
> +        "PublicDescription": "Total pipeline cost of irregular execution=
 (e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workl=
oads, overhead in system services or virtualized environments). Related met=
rics: tma_microcode_sequencer, tma_ms_switches",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Memory Address Trans=
lation related bottlenecks (data-side TLBs)",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma=
_memory_bound, tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound =
+ tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tm=
a_store_fwd_blk + tma_l1_latency_dependency + tma_lock_latency + tma_split_=
loads + tma_fb_full)) + tma_memory_bound * (tma_store_bound / (tma_l1_bound=
 + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound)) * (tma_=
dtlb_store / (tma_store_latency + tma_false_sharing + tma_split_stores + tm=
a_streaming_stores + tma_dtlb_store)))",
> +        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
> +        "MetricName": "tma_bottleneck_memory_data_tlbs",
> +        "MetricThreshold": "tma_bottleneck_memory_data_tlbs > 20",
> +        "PublicDescription": "Total pipeline cost of Memory Address Tran=
slation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_loa=
d, tma_dtlb_store",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Memory Synchronizati=
on related bottlenecks (data transfers and coherency updates across process=
ors)",
> +        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_l1=
_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) * =
(tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_=
l1_bound + tma_l2_bound + tma_l3_bound + tma_dram_bound + tma_store_bound) =
* tma_false_sharing / (tma_store_latency + tma_false_sharing + tma_split_st=
ores + tma_streaming_stores + tma_dtlb_store - tma_store_latency)) + tma_ma=
chine_clears * (1 - tma_other_nukes / tma_other_nukes))",
> +        "MetricGroup": "BvMS;LockCont;Mem;Offcore;tma_issueSyncxn",
> +        "MetricName": "tma_bottleneck_memory_synchronization",
> +        "MetricThreshold": "tma_bottleneck_memory_synchronization > 10",
> +        "PublicDescription": "Total pipeline cost of Memory Synchronizat=
ion related bottlenecks (data transfers and coherency updates across proces=
sors). Related metrics: tma_contested_accesses, tma_data_sharing, tma_false=
_sharing, tma_machine_clears",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of Branch Misprediction=
 related bottlenecks",
> +        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_oth=
er_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fe=
tch_latency * tma_mispredicts_resteers / (tma_icache_misses + tma_itlb_miss=
es + tma_branch_resteers + tma_ms_switches + tma_lcp + tma_dsb_switches))",
> +        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
> +        "MetricName": "tma_bottleneck_mispredictions",
> +        "MetricThreshold": "tma_bottleneck_mispredictions > 20",
> +        "PublicDescription": "Total pipeline cost of Branch Mispredictio=
n related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_ba=
d_spec_branch_misprediction_cost, tma_mispredicts_resteers",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of remaining bottleneck=
s in the back-end",
> +        "MetricExpr": "100 - (tma_bottleneck_big_code + tma_bottleneck_i=
nstruction_fetch_bw + tma_bottleneck_mispredictions + tma_bottleneck_cache_=
memory_bandwidth + tma_bottleneck_cache_memory_latency + tma_bottleneck_mem=
ory_data_tlbs + tma_bottleneck_memory_synchronization + tma_bottleneck_comp=
ute_bound_est + tma_bottleneck_irregular_overhead + tma_bottleneck_branchin=
g_overhead + tma_bottleneck_useful_work)",
> +        "MetricGroup": "BvOB;Cor;Offcore",
> +        "MetricName": "tma_bottleneck_other_bottlenecks",
> +        "MetricThreshold": "tma_bottleneck_other_bottlenecks > 20",
> +        "PublicDescription": "Total pipeline cost of remaining bottlenec=
ks in the back-end. Examples include data-dependencies (Core Bound when Low=
 ILP) and other unlisted memory-related stalls",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total pipeline cost of \"useful operations\=
" - the portion of Retiring category not covered by Branching_Overhead nor =
Irregular_Overhead",
> +        "MetricExpr": "100 * (tma_retiring - (BR_INST_RETIRED.ALL_BRANCH=
ES + 2 * BR_INST_RETIRED.NEAR_CALL + INST_RETIRED.NOP) / tma_info_thread_sl=
ots - tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_=
sequencer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations=
)",
> +        "MetricGroup": "BvUW;Ret",
> +        "MetricName": "tma_bottleneck_useful_work",
> +        "MetricThreshold": "tma_bottleneck_useful_work > 20",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Branch Misprediction",
> -        "MetricExpr": "cpu_core@topdown\\-br\\-mispredict@ / (cpu_core@t=
opdown\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-=
retiring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-br\\-mispredict / (topdown\\-fe\\-bound=
 + topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * =
slots",
>          "MetricGroup": "BadSpec;BrMispredicts;BvMP;TmaL2;TopdownL2;tma_L=
2_group;tma_bad_speculation_group;tma_issueBM",
>          "MetricName": "tma_branch_mispredicts",
>          "MetricThreshold": "tma_branch_mispredicts > 0.1 & tma_bad_specu=
lation > 0.15",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Branch Misprediction.  These slots are either wast=
ed by uops fetched from an incorrectly speculated program path; or stalls w=
hen the out-of-order part of the machine needs to recover its state from a =
speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics=
: tma_info_bad_spec_branch_misprediction_cost, tma_info_bottleneck_mispredi=
ctions, tma_mispredicts_resteers",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Branch Misprediction.  These slots are either wast=
ed by uops fetched from an incorrectly speculated program path; or stalls w=
hen the out-of-order part of the machine needs to recover its state from a =
speculative path. Sample with: TOPDOWN.BR_MISPREDICT_SLOTS. Related metrics=
: tma_bottleneck_mispredictions, tma_info_bad_spec_branch_misprediction_cos=
t, tma_mispredicts_resteers",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers",
> -        "MetricExpr": "cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_inf=
o_thread_clks + tma_unknown_branches",
> +        "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_c=
lks + tma_unknown_branches",
>          "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latenc=
y_group",
>          "MetricName": "tma_branch_resteers",
> -        "MetricThreshold": "tma_branch_resteers > 0.05 & (tma_fetch_late=
ncy > 0.1 & tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers. Branch Resteers estimates the F=
rontend delay in fetching operations from corrected path; following all sor=
ts of miss-predicted branches. For example; branchy code with lots of miss-=
predictions might get categorized under Branch Resteers. Note the value of =
this node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_B=
RANCHES",
> +        "MetricThreshold": "tma_branch_resteers > 0.05 & tma_fetch_laten=
cy > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers. Branch Resteers estimates the F=
rontend delay in fetching operations from corrected path; following all sor=
ts of miss-predicted branches. For example; branchy code with lots of miss-=
predictions might get categorized under Branch Resteers. Note the value of =
this node may overlap with its siblings. Sample with: BR_MISP_RETIRED.ALL_B=
RANCHES. Related metrics: tma_l3_hit_latency, tma_store_latency",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.1 power-performance optimized state (F=
aster wakeup time; Smaller power savings).",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C01@ / tma_info_thread_=
clks",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.1 power-performance optimized state (F=
aster wakeup time; Smaller power savings)",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C01 / tma_info_thread_clks",
>          "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
>          "MetricName": "tma_c01_wait",
> -        "MetricThreshold": "tma_c01_wait > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_c01_wait > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.2 power-performance optimized state (S=
lower wakeup time; Larger power savings).",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C02@ / tma_info_thread_=
clks",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due staying in C0.2 power-performance optimized state (S=
lower wakeup time; Larger power savings)",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C02 / tma_info_thread_clks",
>          "MetricGroup": "C0Wait;TopdownL4;tma_L4_group;tma_serializing_op=
eration_group",
>          "MetricName": "tma_c02_wait",
> -        "MetricThreshold": "tma_c02_wait > 0.05 & (tma_serializing_opera=
tion > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_c02_wait > 0.05 & tma_serializing_operat=
ion > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> @@ -810,28 +2836,82 @@
>          "MetricExpr": "max(0, tma_microcode_sequencer - tma_assists)",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_microcode_sequencer_g=
roup",
>          "MetricName": "tma_cisc",
> -        "MetricThreshold": "tma_cisc > 0.1 & (tma_microcode_sequencer > =
0.05 & tma_heavy_operations > 0.1)",
> +        "MetricThreshold": "tma_cisc > 0.1 & tma_microcode_sequencer > 0=
=2E05 & tma_heavy_operations > 0.1",
>          "PublicDescription": "This metric estimates fraction of cycles t=
he CPU retired uops originated from CISC (complex instruction set computer)=
 instruction. A CISC instruction has multiple uops that are required to per=
form the instruction's functionality as in the case of read-modify-write as=
 an example. Since these instructions require multiple uops they may or may=
 not imply sub-optimal use of machine resources. Sample with: FRONTEND_RETI=
RED.MS_FLOWS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers as a result of Machine Clears",
> -        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation=
) * cpu_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
> +        "MetricExpr": "(1 - tma_branch_mispredicts / tma_bad_speculation=
) * INT_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
>          "MetricGroup": "BadSpec;MachineClears;TopdownL4;tma_L4_group;tma=
_branch_resteers_group;tma_issueMC",
>          "MetricName": "tma_clears_resteers",
> -        "MetricThreshold": "tma_clears_resteers > 0.05 & (tma_branch_res=
teers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
> +        "MetricThreshold": "tma_clears_resteers > 0.05 & tma_branch_rest=
eers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>          "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Machine Clears. S=
ample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related metrics: tma_l1_bound, t=
ma_machine_clears, tma_microcode_sequencer, tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU was stalled due to instruction cache misses that hit in the L2 cache",
> +        "MetricExpr": "max(0, tma_icache_misses - tma_code_l2_miss)",
> +        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;t=
ma_icache_misses_group",
> +        "MetricName": "tma_code_l2_hit",
> +        "MetricThreshold": "tma_code_l2_hit > 0.05 & tma_icache_misses >=
 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates fraction of cycles th=
e CPU was stalled due to instruction cache misses that miss in the L2 cache=
",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_C=
ODE_RD / tma_info_thread_clks",
> +        "MetricGroup": "FetchLat;IcMiss;Offcore;TopdownL4;tma_L4_group;t=
ma_icache_misses_group",
> +        "MetricName": "tma_code_l2_miss",
> +        "MetricThreshold": "tma_code_l2_miss > 0.05 & tma_icache_misses =
> 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the (first level) ITLB was missed by instructions fetches, =
that later on hit in second-level TLB (STLB)",
> +        "MetricExpr": "max(0, tma_itlb_misses - tma_code_stlb_miss)",
> +        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_it=
lb_misses_group",
> +        "MetricName": "tma_code_stlb_hit",
> +        "MetricThreshold": "tma_code_stlb_hit > 0.05 & tma_itlb_misses >=
 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s where the Second-level TLB (STLB) was missed by instruction fetches, perf=
orming a hardware page walk",
> +        "MetricExpr": "ITLB_MISSES.WALK_ACTIVE / tma_info_thread_clks",
> +        "MetricGroup": "FetchLat;MemoryTLB;TopdownL4;tma_L4_group;tma_it=
lb_misses_group",
> +        "MetricName": "tma_code_stlb_miss",
> +        "MetricThreshold": "tma_code_stlb_miss > 0.05 & tma_itlb_misses =
> 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for (instruction) code accesses",
> +        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_2=
M_4M / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
> +        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_co=
de_stlb_miss_group",
> +        "MetricName": "tma_code_stlb_miss_2m",
> +        "MetricThreshold": "tma_code_stlb_miss_2m > 0.05 & tma_code_stlb=
_miss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_front=
end_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or (instruction) code accesses",
> +        "MetricExpr": "tma_code_stlb_miss * ITLB_MISSES.WALK_COMPLETED_4=
K / (ITLB_MISSES.WALK_COMPLETED_4K + ITLB_MISSES.WALK_COMPLETED_2M_4M)",
> +        "MetricGroup": "FetchLat;MemoryTLB;TopdownL5;tma_L5_group;tma_co=
de_stlb_miss_group",
> +        "MetricName": "tma_code_stlb_miss_4k",
> +        "MetricThreshold": "tma_code_stlb_miss_4k > 0.05 & tma_code_stlb=
_miss > 0.05 & tma_itlb_misses > 0.05 & tma_fetch_latency > 0.1 & tma_front=
end_bound > 0.15",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to contested acc=
esses",
> -        "MetricExpr": "(25 * tma_info_system_core_frequency * (cpu_core@=
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD@ * (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNO=
OP_HITM@ / (cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD@))) + 24 * tma_info_system_core_fre=
quency * cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS@) * (1 + cpu_core@MEM_L=
OAD_RETIRED.FB_HIT@ / cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_th=
read_clks",
> -        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_=
group;tma_issueSyncxn;tma_l3_bound_group",
> +        "MetricExpr": "((28 * tma_info_system_core_frequency - 3 * tma_i=
nfo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD * (OCR.DEMAN=
D_DATA_RD.L3_HIT.SNOOP_HITM / (OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.D=
EMAND_DATA_RD.L3_HIT.SNOOP_HIT_WITH_FWD))) + (27 * tma_info_system_core_fre=
quency - 3 * tma_info_system_core_frequency) * MEM_LOAD_L3_HIT_RETIRED.XSNP=
_MISS) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) / tma=
_info_thread_clks",
> +        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_contested_accesses",
> -        "MetricThreshold": "tma_contested_accesses > 0.05 & (tma_l3_boun=
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
> +        "MetricThreshold": "tma_contested_accesses > 0.05 & tma_l3_bound=
 > 0.05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to contested ac=
cesses. Contested accesses occur when data written by one Logical Processor=
 are read by another Logical Processor on a different Physical Core. Exampl=
es of contested accesses include synchronizations such as locks; true data =
sharing such as modified locked variables; and false sharing. Sample with: =
MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD, MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS. Relate=
d metrics: tma_bottleneck_memory_synchronization, tma_data_sharing, tma_fal=
se_sharing, tma_machine_clears",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> @@ -842,107 +2922,107 @@
>          "MetricName": "tma_core_bound",
>          "MetricThreshold": "tma_core_bound > 0.1 & tma_backend_bound > 0=
=2E2",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots w=
here Core non-memory issues were of a bottleneck.  Shortage in hardware com=
pute resources; or dependencies in software's instructions are both categor=
ized under Core Bound. Hence it may indicate the machine ran out of an out-=
of-order resource; certain execution units are overloaded or dependencies i=
n program's data- or instruction-flow are limiting the performance (e.g. FP=
-chained long-latency arithmetic operations).",
> +        "PublicDescription": "This metric represents fraction of slots w=
here Core non-memory issues were of a bottleneck.  Shortage in hardware com=
pute resources; or dependencies in software's instructions are both categor=
ized under Core Bound. Hence it may indicate the machine ran out of an out-=
of-order resource; certain execution units are overloaded or dependencies i=
n program's data- or instruction-flow are limiting the performance (e.g. FP=
-chained long-latency arithmetic operations)",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wh=
ile the memory subsystem was handling synchronizations due to data-sharing =
accesses",
> -        "MetricExpr": "24 * tma_info_system_core_frequency * (cpu_core@M=
EM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD@ + cpu_core@MEM_LOAD_L3_HIT_RETIRED.XSNP=
_FWD@ * (1 - cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ / (cpu_core@OCR=
=2EDEMAND_DATA_RD.L3_HIT.SNOOP_HITM@ + cpu_core@OCR.DEMAND_DATA_RD.L3_HIT.S=
NOOP_HIT_WITH_FWD@))) * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@M=
EM_LOAD_RETIRED.L1_MISS@ / 2) / tma_info_thread_clks",
> +        "MetricExpr": "(27 * tma_info_system_core_frequency - 3 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD + MEM_LOAD=
_L3_HIT_RETIRED.XSNP_FWD * (1 - OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HITM / (OCR=
=2EDEMAND_DATA_RD.L3_HIT.SNOOP_HITM + OCR.DEMAND_DATA_RD.L3_HIT.SNOOP_HIT_W=
ITH_FWD))) * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) /=
 tma_info_thread_clks",
>          "MetricGroup": "BvMS;Offcore;Snoop;TopdownL4;tma_L4_group;tma_is=
sueSyncxn;tma_l3_bound_group",
>          "MetricName": "tma_data_sharing",
> -        "MetricThreshold": "tma_data_sharing > 0.05 & (tma_l3_bound > 0.=
05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to data-sharing=
 accesses. Data shared by multiple Logical Processors (even just read share=
d) may cause increased access latency due to cache coherency. Excessive dat=
a sharing can drastically harm multithreaded performance. Sample with: MEM_=
LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_contested_accesses, t=
ma_false_sharing, tma_machine_clears, tma_remote_cache",
> +        "MetricThreshold": "tma_data_sharing > 0.05 & tma_l3_bound > 0.0=
5 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
hile the memory subsystem was handling synchronizations due to data-sharing=
 accesses. Data shared by multiple Logical Processors (even just read share=
d) may cause increased access latency due to cache coherency. Excessive dat=
a sharing can drastically harm multithreaded performance. Sample with: MEM_=
LOAD_L3_HIT_RETIRED.XSNP_NO_FWD. Related metrics: tma_bottleneck_memory_syn=
chronization, tma_contested_accesses, tma_false_sharing, tma_machine_clears=
",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles w=
here decoder-0 was the only active decoder",
> -        "MetricExpr": "(cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D1@ - =
cpu_core@INST_DECODED.DECODERS\\,cmask\\=3D2@) / tma_info_core_core_clks / =
2",
> +        "MetricExpr": "(cpu@INST_DECODED.DECODERS\\,cmask\\=3D0x1@ - cpu=
@INST_DECODED.DECODERS\\,cmask\\=3D0x2@) / tma_info_core_core_clks / 2",
>          "MetricGroup": "DSBmiss;FetchBW;TopdownL4;tma_L4_group;tma_issue=
D0;tma_mite_group",
>          "MetricName": "tma_decoder0_alone",
> -        "MetricThreshold": "tma_decoder0_alone > 0.1 & (tma_mite > 0.1 &=
 tma_fetch_bandwidth > 0.2)",
> +        "MetricThreshold": "tma_decoder0_alone > 0.1 & tma_mite > 0.1 & =
tma_fetch_bandwidth > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
where decoder-0 was the only active decoder. Related metrics: tma_few_uops_=
instructions",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles w=
here the Divider unit was active",
> -        "MetricExpr": "cpu_core@ARITH.DIV_ACTIVE@ / tma_info_thread_clks=
",
> +        "MetricExpr": "ARITH.DIV_ACTIVE / tma_info_thread_clks",
>          "MetricGroup": "BvCB;TopdownL3;tma_L3_group;tma_core_bound_group=
",
>          "MetricName": "tma_divider",
> -        "MetricThreshold": "tma_divider > 0.2 & (tma_core_bound > 0.1 & =
tma_backend_bound > 0.2)",
> +        "MetricThreshold": "tma_divider > 0.2 & tma_core_bound > 0.1 & t=
ma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
where the Divider unit was active. Divide and square root instructions are =
performed by the Divider unit and can take considerably longer latency than=
 integer or Floating Point addition; subtraction; or multiplication. Sample=
 with: ARITH.DIVIDER_ACTIVE",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates how often the CPU was=
 stalled on accesses to external memory (DRAM) by loads",
> -        "MetricExpr": "cpu_core@MEMORY_ACTIVITY.STALLS_L3_MISS@ / tma_in=
fo_thread_clks",
> +        "MetricExpr": "MEMORY_ACTIVITY.STALLS_L3_MISS / tma_info_thread_=
clks",
>          "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_=
memory_bound_group",
>          "MetricName": "tma_dram_bound",
> -        "MetricThreshold": "tma_dram_bound > 0.1 & (tma_memory_bound > 0=
=2E2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS_PS",
> +        "MetricThreshold": "tma_dram_bound > 0.1 & tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled on accesses to external memory (DRAM) by loads. Better caching ca=
n improve the latency and increase performance. Sample with: MEM_LOAD_RETIR=
ED.L3_MISS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to DSB (decoded uop cache) fetch pi=
peline",
> -        "MetricExpr": "(cpu_core@IDQ.DSB_CYCLES_ANY@ - cpu_core@IDQ.DSB_=
CYCLES_OK@) / tma_info_core_core_clks / 2",
> +        "MetricExpr": "(IDQ.DSB_CYCLES_ANY - IDQ.DSB_CYCLES_OK) / tma_in=
fo_core_core_clks / 2",
>          "MetricGroup": "DSB;FetchBW;TopdownL3;tma_L3_group;tma_fetch_ban=
dwidth_group",
>          "MetricName": "tma_dsb",
>          "MetricThreshold": "tma_dsb > 0.15 & tma_fetch_bandwidth > 0.2",
> -        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to DSB (decoded uop cache) fetch p=
ipeline.  For example; inefficient utilization of the DSB cache structure o=
r bank conflict when reading from it; are categorized here.",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to DSB (decoded uop cache) fetch p=
ipeline.  For example; inefficient utilization of the DSB cache structure o=
r bank conflict when reading from it; are categorized here",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to switches from DSB to MITE pipelines",
> -        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / tma_=
info_thread_clks",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / tma_info_threa=
d_clks",
>          "MetricGroup": "DSBmiss;FetchLat;TopdownL3;tma_L3_group;tma_fetc=
h_latency_group;tma_issueFB",
>          "MetricName": "tma_dsb_switches",
> -        "MetricThreshold": "tma_dsb_switches > 0.05 & (tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to switches from DSB to MITE pipelines. The DSB (de=
coded i-cache) is a Uop Cache where the front-end directly delivers Uops (m=
icro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter =
latency and delivered higher bandwidth than the MITE (legacy instruction de=
code pipeline). Switching between the two pipelines can cause penalties hen=
ce this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.=
DSB_MISS_PS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_b=
andwidth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tm=
a_info_inst_mix_iptb, tma_lcp",
> +        "MetricThreshold": "tma_dsb_switches > 0.05 & tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to switches from DSB to MITE pipelines. The DSB (de=
coded i-cache) is a Uop Cache where the front-end directly delivers Uops (m=
icro operations) avoiding heavy x86 decoding. The DSB pipeline has shorter =
latency and delivered higher bandwidth than the MITE (legacy instruction de=
code pipeline). Switching between the two pipelines can cause penalties hen=
ce this metric measures the exposed penalty. Sample with: FRONTEND_RETIRED.=
DSB_MISS. Related metrics: tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_band=
width, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_i=
nfo_inst_mix_iptb, tma_lcp",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates the fraction =
of cycles where the Data TLB (DTLB) was missed by load accesses",
> -        "MetricExpr": "min(7 * cpu_core@DTLB_LOAD_MISSES.STLB_HIT\\,cmas=
k\\=3D1@ + cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@, max(cpu_core@CYCLE_ACTIV=
ITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIVITY.CYCLES_L1D_MISS@, 0)) / tma_=
info_thread_clks",
> +        "MetricExpr": "min(7 * cpu@DTLB_LOAD_MISSES.STLB_HIT\\,cmask\\=
=3D0x1@ + DTLB_LOAD_MISSES.WALK_ACTIVE, max(CYCLE_ACTIVITY.CYCLES_MEM_ANY -=
 MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
>          "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueT=
LB;tma_l1_bound_group",
>          "MetricName": "tma_dtlb_load",
> -        "MetricThreshold": "tma_dtlb_load > 0.1 & (tma_l1_bound > 0.1 & =
(tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Tra=
nslation Look-aside Buffers) are processor caches for recently used entries=
 out of the Page Tables that are used to map virtual- to physical-addresses=
 by the operating system. This metric approximates the potential delay of d=
emand loads missing the first-level data TLB (assuming worst case scenario =
with back to back misses to different pages). This includes hitting in the =
second-level TLB (STLB) as well as performing a hardware page walk on an ST=
LB miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS_PS. Related metrics:=
 tma_dtlb_store, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_=
memory_synchronization",
> +        "MetricThreshold": "tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & t=
ma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles where the Data TLB (DTLB) was missed by load accesses. TLBs (Tra=
nslation Look-aside Buffers) are processor caches for recently used entries=
 out of the Page Tables that are used to map virtual- to physical-addresses=
 by the operating system. This metric approximates the potential delay of d=
emand loads missing the first-level data TLB (assuming worst case scenario =
with back to back misses to different pages). This includes hitting in the =
second-level TLB (STLB) as well as performing a hardware page walk on an ST=
LB miss. Sample with: MEM_INST_RETIRED.STLB_MISS_LOADS. Related metrics: tm=
a_bottleneck_memory_data_tlbs, tma_dtlb_store",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates the fraction =
of cycles spent handling first-level data TLB store misses",
> -        "MetricExpr": "(7 * cpu_core@DTLB_STORE_MISSES.STLB_HIT\\,cmask\=
\=3D1@ + cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@) / tma_info_core_core_clks=
",
> +        "MetricExpr": "(7 * cpu@DTLB_STORE_MISSES.STLB_HIT\\,cmask\\=3D0=
x1@ + DTLB_STORE_MISSES.WALK_ACTIVE) / tma_info_core_core_clks",
>          "MetricGroup": "BvMT;MemoryTLB;TopdownL4;tma_L4_group;tma_issueT=
LB;tma_store_bound_group",
>          "MetricName": "tma_dtlb_store",
> -        "MetricThreshold": "tma_dtlb_store > 0.05 & (tma_store_bound > 0=
=2E2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles spent handling first-level data TLB store misses.  As with ordin=
ary data caching; focus on improving data locality and reducing working-set=
 size to reduce DTLB overhead.  Additionally; consider using profile-guided=
 optimization (PGO) to collocate frequently-used data on the same page.  Tr=
y using larger page sizes for large amounts of frequently-used data. Sample=
 with: MEM_INST_RETIRED.STLB_MISS_STORES_PS. Related metrics: tma_dtlb_load=
, tma_info_bottleneck_memory_data_tlbs, tma_info_bottleneck_memory_synchron=
ization",
> +        "MetricThreshold": "tma_dtlb_store > 0.05 & tma_store_bound > 0.=
2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates the fraction=
 of cycles spent handling first-level data TLB store misses.  As with ordin=
ary data caching; focus on improving data locality and reducing working-set=
 size to reduce DTLB overhead.  Additionally; consider using profile-guided=
 optimization (PGO) to collocate frequently-used data on the same page.  Tr=
y using larger page sizes for large amounts of frequently-used data. Sample=
 with: MEM_INST_RETIRED.STLB_MISS_STORES. Related metrics: tma_bottleneck_m=
emory_data_tlbs, tma_dtlb_load",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates how often CPU=
 was handling synchronizations due to False Sharing",
> -        "MetricExpr": "28 * tma_info_system_core_frequency * cpu_core@OC=
R.DEMAND_RFO.L3_HIT.SNOOP_HITM@ / tma_info_thread_clks",
> -        "MetricGroup": "BvMS;DataSharing;Offcore;Snoop;TopdownL4;tma_L4_=
group;tma_issueSyncxn;tma_store_bound_group",
> +        "MetricExpr": "28 * tma_info_system_core_frequency * OCR.DEMAND_=
RFO.L3_HIT.SNOOP_HITM / tma_info_thread_clks",
> +        "MetricGroup": "BvMS;DataSharing;LockCont;Offcore;Snoop;TopdownL=
4;tma_L4_group;tma_issueSyncxn;tma_store_bound_group",
>          "MetricName": "tma_false_sharing",
> -        "MetricThreshold": "tma_false_sharing > 0.05 & (tma_store_bound =
> 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates how often CP=
U was handling synchronizations due to False Sharing. False Sharing is a mu=
ltithreading hiccup; where multiple Logical Processors contend on different=
 data-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO=
=2EL3_HIT.SNOOP_HITM. Related metrics: tma_contested_accesses, tma_data_sha=
ring, tma_machine_clears, tma_remote_cache",
> +        "MetricThreshold": "tma_false_sharing > 0.05 & tma_store_bound >=
 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates how often CP=
U was handling synchronizations due to False Sharing. False Sharing is a mu=
ltithreading hiccup; where multiple Logical Processors contend on different=
 data-elements mapped into the same cache line. Sample with: OCR.DEMAND_RFO=
=2EL3_HIT.SNOOP_HITM. Related metrics: tma_bottleneck_memory_synchronizatio=
n, tma_contested_accesses, tma_data_sharing, tma_machine_clears",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric does a *rough estimation* of ho=
w often L1D Fill Buffer unavailability limited additional L1D miss memory a=
ccess requests to proceed",
> -        "MetricExpr": "cpu_core@L1D_PEND_MISS.FB_FULL@ / tma_info_thread=
_clks",
> -        "MetricGroup": "BvMS;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW=
;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
> +        "MetricExpr": "L1D_PEND_MISS.FB_FULL / tma_info_thread_clks",
> +        "MetricGroup": "BvMB;MemoryBW;TopdownL4;tma_L4_group;tma_issueBW=
;tma_issueSL;tma_issueSmSt;tma_l1_bound_group",
>          "MetricName": "tma_fb_full",
>          "MetricThreshold": "tma_fb_full > 0.3",
> -        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_info_bottleneck_cache_memory_band=
width, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_sto=
re_latency, tma_streaming_stores",
> +        "PublicDescription": "This metric does a *rough estimation* of h=
ow often L1D Fill Buffer unavailability limited additional L1D miss memory =
access requests to proceed. The higher the metric value; the deeper the mem=
ory hierarchy level the misses are satisfied from (metric values >1 are val=
id). Often it hints on approaching bandwidth limits (to L2 cache; L3 cache =
or external memory). Related metrics: tma_bottleneck_cache_memory_bandwidth=
, tma_info_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full, tma_store_la=
tency, tma_streaming_stores",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> @@ -953,28 +3033,28 @@
>          "MetricName": "tma_fetch_bandwidth",
>          "MetricThreshold": "tma_fetch_bandwidth > 0.2",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend bandwidth issues.  For example; ineffici=
encies at the instruction decoders; or restrictions for caching in the DSB =
(decoded uops cache) are categorized under Fetch Bandwidth. In such cases; =
the Frontend typically delivers suboptimal amount of uops to the Backend. S=
ample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1_PS;FRONTEND_RETIRED.=
LATENCY_GE_1_PS;FRONTEND_RETIRED.LATENCY_GE_2_PS. Related metrics: tma_dsb_=
switches, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, =
tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend bandwidth issues.  For example; ineffici=
encies at the instruction decoders; or restrictions for caching in the DSB =
(decoded uops cache) are categorized under Fetch Bandwidth. In such cases; =
the Frontend typically delivers suboptimal amount of uops to the Backend. S=
ample with: FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1, FRONTEND_RETIRED.LA=
TENCY_GE_1, FRONTEND_RETIRED.LATENCY_GE_2. Related metrics: tma_dsb_switche=
s, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_inf=
o_frontend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU was stalled due to Frontend latency issues",
> -        "MetricExpr": "cpu_core@topdown\\-fetch\\-lat@ / (cpu_core@topdo=
wn\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-reti=
ring@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ /=
 tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-fetch\\-lat / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC=
=2EUOP_DROPPING / tma_info_thread_slots",
>          "MetricGroup": "Frontend;TmaL2;TopdownL2;tma_L2_group;tma_fronte=
nd_bound_group",
>          "MetricName": "tma_fetch_latency",
>          "MetricThreshold": "tma_fetch_latency > 0.1 & tma_frontend_bound=
 > 0.15",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend latency issues.  For example; instructio=
n-cache misses; iTLB misses or fetch stalls after a branch misprediction ar=
e categorized under Frontend Latency. In such cases; the Frontend eventuall=
y delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_G=
E_16_PS;FRONTEND_RETIRED.LATENCY_GE_8_PS",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was stalled due to Frontend latency issues.  For example; instructio=
n-cache misses; iTLB misses or fetch stalls after a branch misprediction ar=
e categorized under Frontend Latency. In such cases; the Frontend eventuall=
y delivers no uops for some period. Sample with: FRONTEND_RETIRED.LATENCY_G=
E_16, FRONTEND_RETIRED.LATENCY_GE_8",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring instructions that that are decoder into two or up =
to ([SNB+] four; [ADL+] five) uops",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring instructions that that are decoder into two or mor=
e uops",
>          "MetricExpr": "max(0, tma_heavy_operations - tma_microcode_seque=
ncer)",
>          "MetricGroup": "TopdownL3;tma_L3_group;tma_heavy_operations_grou=
p;tma_issueD0",
>          "MetricName": "tma_few_uops_instructions",
>          "MetricThreshold": "tma_few_uops_instructions > 0.05 & tma_heavy=
_operations > 0.1",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring instructions that that are decoder into two or up=
 to ([SNB+] four; [ADL+] five) uops. This highly-correlates with the number=
 of uops in such instructions. Related metrics: tma_decoder0_alone",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring instructions that that are decoder into two or mo=
re uops. This highly-correlates with the number of uops in such instruction=
s. Related metrics: tma_decoder0_alone",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> @@ -984,138 +3064,147 @@
>          "MetricGroup": "HPC;TopdownL3;tma_L3_group;tma_light_operations_=
group",
>          "MetricName": "tma_fp_arith",
>          "MetricThreshold": "tma_fp_arith > 0.2 & tma_light_operations > =
0.6",
> -        "PublicDescription": "This metric represents overall arithmetic =
floating-point (FP) operations fraction the CPU has executed (retired). Not=
e this metric's value may exceed its parent due to use of \"Uops\" CountDom=
ain and FMA double-counting.",
> +        "PublicDescription": "This metric represents overall arithmetic =
floating-point (FP) operations fraction the CPU has executed (retired). Not=
e this metric's value may exceed its parent due to use of \"Uops\" CountDom=
ain and FMA double-counting",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates fraction of s=
lots the CPU retired uops as a result of handing Floating Point (FP) Assist=
s",
> -        "MetricExpr": "30 * cpu_core@ASSISTS.FP@ / tma_info_thread_slots=
",
> +        "MetricExpr": "30 * ASSISTS.FP / tma_info_thread_slots",
>          "MetricGroup": "HPC;TopdownL5;tma_L5_group;tma_assists_group",
>          "MetricName": "tma_fp_assists",
>          "MetricThreshold": "tma_fp_assists > 0.1",
> -        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Floating Point (FP) Assis=
ts. FP Assist may apply when working with very small floating point values =
(so-called Denormals).",
> +        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Floating Point (FP) Assis=
ts. FP Assist may apply when working with very small floating point values =
(so-called Denormals)",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the Floating-Point Divider unit was active",
> +        "MetricExpr": "ARITH.FPDIV_ACTIVE / tma_info_thread_clks",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
> +        "MetricName": "tma_fp_divider",
> +        "MetricThreshold": "tma_fp_divider > 0.2 & tma_divider > 0.2 & t=
ma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric approximates arithmetic floatin=
g-point (FP) scalar uops fraction the CPU has retired",
> -        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ / (tma_ret=
iring * tma_info_thread_slots)",
> +        "MetricExpr": "FP_ARITH_INST_RETIRED.SCALAR / (tma_retiring * tm=
a_info_thread_slots)",
>          "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arit=
h_group;tma_issue2P",
>          "MetricName": "tma_fp_scalar",
> -        "MetricThreshold": "tma_fp_scalar > 0.1 & (tma_fp_arith > 0.2 & =
tma_light_operations > 0.6)",
> -        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) scalar uops fraction the CPU has retired. May overcount due t=
o FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, =
tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vector=
_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2=
",
> +        "MetricThreshold": "tma_fp_scalar > 0.1 & tma_fp_arith > 0.2 & t=
ma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) scalar uops fraction the CPU has retired. May overcount due t=
o FMA double counting. Related metrics: tma_fp_vector, tma_fp_vector_128b, =
tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, t=
ma_port_1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric approximates arithmetic floatin=
g-point (FP) vector uops fraction the CPU has retired aggregated across all=
 vector widths",
> -        "MetricExpr": "cpu_core@FP_ARITH_INST_RETIRED.VECTOR@ / (tma_ret=
iring * tma_info_thread_slots)",
> +        "MetricExpr": "FP_ARITH_INST_RETIRED.VECTOR / (tma_retiring * tm=
a_info_thread_slots)",
>          "MetricGroup": "Compute;Flops;TopdownL4;tma_L4_group;tma_fp_arit=
h_group;tma_issue2P",
>          "MetricName": "tma_fp_vector",
> -        "MetricThreshold": "tma_fp_vector > 0.1 & (tma_fp_arith > 0.2 & =
tma_light_operations > 0.6)",
> -        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) vector uops fraction the CPU has retired aggregated across al=
l vector widths. May overcount due to FMA double counting. Related metrics:=
 tma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b,=
 tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port=
_5, tma_port_6, tma_ports_utilized_2",
> +        "MetricThreshold": "tma_fp_vector > 0.1 & tma_fp_arith > 0.2 & t=
ma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic floati=
ng-point (FP) vector uops fraction the CPU has retired aggregated across al=
l vector widths. May overcount due to FMA double counting. Related metrics:=
 tma_fp_scalar, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b=
, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utiliz=
ed_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric approximates arithmetic FP vect=
or uops fraction the CPU has retired for 128-bit wide vectors",
> -        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBL=
E@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@) / (tma_retiring * =
tma_info_thread_slots)",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.128B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slot=
s)",
>          "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vect=
or_group;tma_issue2P",
>          "MetricName": "tma_fp_vector_128b",
> -        "MetricThreshold": "tma_fp_vector_128b > 0.1 & (tma_fp_vector > =
0.1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
> -        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 128-bit wide vectors. May overcou=
nt due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vecto=
r, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vec=
tor_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilize=
d_2",
> +        "MetricThreshold": "tma_fp_vector_128b > 0.1 & tma_fp_vector > 0=
=2E1 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 128-bit wide vectors. May overcou=
nt due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256=
b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric approximates arithmetic FP vect=
or uops fraction the CPU has retired for 256-bit wide vectors",
> -        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBL=
E@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@) / (tma_retiring * =
tma_info_thread_slots)",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE + FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / (tma_retiring * tma_info_thread_slot=
s)",
>          "MetricGroup": "Compute;Flops;TopdownL5;tma_L5_group;tma_fp_vect=
or_group;tma_issue2P",
>          "MetricName": "tma_fp_vector_256b",
> -        "MetricThreshold": "tma_fp_vector_256b > 0.1 & (tma_fp_vector > =
0.1 & (tma_fp_arith > 0.2 & tma_light_operations > 0.6))",
> -        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 256-bit wide vectors. May overcou=
nt due to FMA double counting. Related metrics: tma_fp_scalar, tma_fp_vecto=
r, tma_fp_vector_128b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_vec=
tor_256b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilize=
d_2",
> +        "MetricThreshold": "tma_fp_vector_256b > 0.1 & tma_fp_vector > 0=
=2E1 & tma_fp_arith > 0.2 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric approximates arithmetic FP vec=
tor uops fraction the CPU has retired for 256-bit wide vectors. May overcou=
nt due to FMA double counting prior to LNL. Related metrics: tma_fp_scalar,=
 tma_fp_vector, tma_fp_vector_128b, tma_int_vector_128b, tma_int_vector_256=
b, tma_port_0, tma_port_1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This category represents fraction of slots =
where the processor's Frontend undersupplies its Backend",
>          "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_core@topdown\\-fe\\-bound@ / (cpu_core@topdow=
n\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retir=
ing@ + cpu_core@topdown\\-be\\-bound@) - cpu_core@INT_MISC.UOP_DROPPING@ / =
tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-fe\\-bound / (topdown\\-fe\\-bound + to=
pdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) - INT_MISC.=
UOP_DROPPING / tma_info_thread_slots",
>          "MetricGroup": "BvFB;BvIO;Default;PGO;TmaL1;TopdownL1;tma_L1_gro=
up",
>          "MetricName": "tma_frontend_bound",
>          "MetricThreshold": "tma_frontend_bound > 0.15",
>          "MetricgroupNoGroup": "TopdownL1;Default",
> -        "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4_PS",
> +        "PublicDescription": "This category represents fraction of slots=
 where the processor's Frontend undersupplies its Backend. Frontend denotes=
 the first part of the processor core responsible to fetch operations that =
are executed later on by the Backend part. Within the Frontend; a branch pr=
edictor predicts the next address to fetch; cache-lines are fetched from th=
e memory subsystem; parsed into instructions; and lastly decoded into micro=
-operations (uops). Ideally the Frontend can issue Pipeline_Width uops ever=
y cycle to the Backend. Frontend Bound denotes unutilized issue-slots when =
there is no Backend stall; i.e. bubbles where Frontend delivered no uops wh=
ile Backend could have accepted them. For example; stalls due to instructio=
n-cache misses would be categorized under Frontend Bound. Sample with: FRON=
TEND_RETIRED.LATENCY_GE_4",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring fused instructions -- where one uop can represent =
multiple contiguous instructions",
> -        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.MACR=
O_FUSED@ / (tma_retiring * tma_info_thread_slots)",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring fused instructions , where one uop can represent m=
ultiple contiguous instructions",
> +        "MetricExpr": "tma_light_operations * INST_RETIRED.MACRO_FUSED /=
 (tma_retiring * tma_info_thread_slots)",
>          "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tm=
a_light_operations_group",
>          "MetricName": "tma_fused_instructions",
>          "MetricThreshold": "tma_fused_instructions > 0.1 & tma_light_ope=
rations > 0.6",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring fused instructions -- where one uop can represent=
 multiple contiguous instructions. CMP+JCC or DEC+JCC are common examples o=
f legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under =
Other_Light_Ops in MTL!)}",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring fused instructions , where one uop can represent =
multiple contiguous instructions. CMP+JCC or DEC+JCC are common examples of=
 legacy fusions. {([MTL] Note new MOV+OP and Load+OP fusions appear under O=
ther_Light_Ops in MTL!)}",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring heavy-weight operations -- instructions that requi=
re two or more uops or micro-coded sequences",
> -        "MetricExpr": "cpu_core@topdown\\-heavy\\-ops@ / (cpu_core@topdo=
wn\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-reti=
ring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring heavy-weight operations , instructions that requir=
e two or more uops or micro-coded sequences",
> +        "MetricExpr": "topdown\\-heavy\\-ops / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slot=
s",
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring=
_group",
>          "MetricName": "tma_heavy_operations",
>          "MetricThreshold": "tma_heavy_operations > 0.1",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring heavy-weight operations -- instructions that requ=
ire two or more uops or micro-coded sequences. This highly-correlates with =
the uop length of these instructions/sequences. ([ICL+] Note this may overc=
ount due to approximation using indirect events; [ADL+] .). Sample with: UO=
PS_RETIRED.HEAVY",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring heavy-weight operations , instructions that requi=
re two or more uops or micro-coded sequences. This highly-correlates with t=
he uop length of these instructions/sequences.([ICL+] Note this may overcou=
nt due to approximation using indirect events; [ADL+]). Sample with: UOPS_R=
ETIRED.HEAVY",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to instruction cache misses",
> -        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / tma_info_thread_cl=
ks",
> +        "MetricExpr": "ICACHE_DATA.STALLS / tma_info_thread_clks",
>          "MetricGroup": "BigFootprint;BvBC;FetchLat;IcMiss;TopdownL3;tma_=
L3_group;tma_fetch_latency_group",
>          "MetricName": "tma_icache_misses",
> -        "MetricThreshold": "tma_icache_misses > 0.05 & (tma_fetch_latenc=
y > 0.1 & tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to instruction cache misses. Sample with: FRONTEND_=
RETIRED.L2_MISS_PS;FRONTEND_RETIRED.L1I_MISS_PS",
> +        "MetricThreshold": "tma_icache_misses > 0.05 & tma_fetch_latency=
 > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to instruction cache misses. Sample with: FRONTEND_=
RETIRED.L2_MISS, FRONTEND_RETIRED.L1I_MISS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Branch Misprediction Cost: Fraction of TMA =
slots wasted per non-speculative branch misprediction (retired JEClear)",
> -        "MetricExpr": "tma_info_bottleneck_mispredictions * tma_info_thr=
ead_slots / cpu_core@BR_MISP_RETIRED.ALL_BRANCHES@ / 100",
> +        "BriefDescription": "Branch Misprediction Cost: Cycles represent=
ing fraction of TMA slots wasted per non-speculative branch misprediction (=
retired JEClear)",
> +        "MetricExpr": "tma_bottleneck_mispredictions * tma_info_thread_s=
lots / 6 / BR_MISP_RETIRED.ALL_BRANCHES / 100",
>          "MetricGroup": "Bad;BrMispredicts;tma_issueBM",
>          "MetricName": "tma_info_bad_spec_branch_misprediction_cost",
> -        "PublicDescription": "Branch Misprediction Cost: Fraction of TMA=
 slots wasted per non-speculative branch misprediction (retired JEClear). R=
elated metrics: tma_branch_mispredicts, tma_info_bottleneck_mispredictions,=
 tma_mispredicts_resteers",
> +        "PublicDescription": "Branch Misprediction Cost: Cycles represen=
ting fraction of TMA slots wasted per non-speculative branch misprediction =
(retired JEClear). Related metrics: tma_bottleneck_mispredictions, tma_bran=
ch_mispredicts, tma_mispredicts_resteers",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instructions per retired mispredicts for co=
nditional non-taken branches (lower number means higher occurrence rate).",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RET=
IRED.COND_NTAKEN@",
> +        "BriefDescription": "Instructions per retired Mispredicts for co=
nditional non-taken branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_NTAKEN",
>          "MetricGroup": "Bad;BrMispredicts",
>          "MetricName": "tma_info_bad_spec_ipmisp_cond_ntaken",
>          "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_ntaken < 200",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instructions per retired mispredicts for co=
nditional taken branches (lower number means higher occurrence rate).",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RET=
IRED.COND_TAKEN@",
> +        "BriefDescription": "Instructions per retired Mispredicts for co=
nditional taken branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.COND_TAKEN",
>          "MetricGroup": "Bad;BrMispredicts",
>          "MetricName": "tma_info_bad_spec_ipmisp_cond_taken",
>          "MetricThreshold": "tma_info_bad_spec_ipmisp_cond_taken < 200",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instructions per retired mispredicts for in=
direct CALL or JMP branches (lower number means higher occurrence rate).",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RET=
IRED.INDIRECT@",
> +        "BriefDescription": "Instructions per retired Mispredicts for in=
direct CALL or JMP branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.INDIRECT",
>          "MetricGroup": "Bad;BrMispredicts",
>          "MetricName": "tma_info_bad_spec_ipmisp_indirect",
> -        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1e3",
> +        "MetricThreshold": "tma_info_bad_spec_ipmisp_indirect < 1000",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instructions per retired mispredicts for re=
turn branches (lower number means higher occurrence rate).",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RET=
IRED.RET@",
> +        "BriefDescription": "Instructions per retired Mispredicts for re=
turn branches (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.RET",
>          "MetricGroup": "Bad;BrMispredicts",
>          "MetricName": "tma_info_bad_spec_ipmisp_ret",
>          "MetricThreshold": "tma_info_bad_spec_ipmisp_ret < 500",
> @@ -1123,15 +3212,15 @@
>      },
>      {
>          "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear) (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_MISP_RET=
IRED.ALL_BRANCHES@",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
>          "MetricGroup": "Bad;BadSpec;BrMispredicts",
>          "MetricName": "tma_info_bad_spec_ipmispredict",
>          "MetricThreshold": "tma_info_bad_spec_ipmispredict < 200",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Speculative to Retired ratio of all clears =
(covering mispredicts and nukes)",
> -        "MetricExpr": "cpu_core@INT_MISC.CLEARS_COUNT@ / (cpu_core@BR_MI=
SP_RETIRED.ALL_BRANCHES@ + cpu_core@MACHINE_CLEARS.COUNT@)",
> +        "BriefDescription": "Speculative to Retired ratio of all clears =
(covering Mispredicts and nukes)",
> +        "MetricExpr": "INT_MISC.CLEARS_COUNT / (BR_MISP_RETIRED.ALL_BRAN=
CHES + MACHINE_CLEARS.COUNT)",
>          "MetricGroup": "BrMispredicts",
>          "MetricName": "tma_info_bad_spec_spec_clears_ratio",
>          "Unit": "cpu_core"
> @@ -1146,8 +3235,8 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of DSB (uop cache) hits=
 - subset of the Instruction_Fetch_BW Bottleneck",
> -        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth =
/ (tma_fetch_bandwidth + tma_fetch_latency)) * (tma_dsb / (tma_dsb + tma_ls=
d + tma_mite)))",
> -        "MetricGroup": "DSB;FetchBW;tma_issueFB",
> +        "MetricExpr": "100 * (tma_frontend_bound * (tma_fetch_bandwidth =
/ (tma_fetch_latency + tma_fetch_bandwidth)) * (tma_dsb / (tma_mite + tma_d=
sb + tma_lsd + tma_ms)))",
> +        "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
>          "MetricName": "tma_info_botlnk_l2_dsb_bandwidth",
>          "MetricThreshold": "tma_info_botlnk_l2_dsb_bandwidth > 10",
>          "PublicDescription": "Total pipeline cost of DSB (uop cache) hit=
s - subset of the Instruction_Fetch_BW Bottleneck. Related metrics: tma_dsb=
_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_misses, tma_info_fro=
ntend_dsb_coverage, tma_info_inst_mix_iptb, tma_lcp",
> @@ -1155,7 +3244,7 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of DSB (uop cache) miss=
es - subset of the Instruction_Fetch_BW Bottleneck",
> -        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tm=
a_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses =
+ tma_lcp + tma_ms_switches) + tma_fetch_bandwidth * tma_mite / (tma_dsb + =
tma_lsd + tma_mite))",
> +        "MetricExpr": "100 * (tma_fetch_latency * tma_dsb_switches / (tm=
a_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches +=
 tma_lcp + tma_dsb_switches) + tma_fetch_bandwidth * tma_mite / (tma_mite +=
 tma_dsb + tma_lsd + tma_ms))",
>          "MetricGroup": "DSBmiss;Fed;tma_issueFB",
>          "MetricName": "tma_info_botlnk_l2_dsb_misses",
>          "MetricThreshold": "tma_info_botlnk_l2_dsb_misses > 10",
> @@ -1164,142 +3253,36 @@
>      },
>      {
>          "BriefDescription": "Total pipeline cost of Instruction Cache mi=
sses - subset of the Big_Code Bottleneck",
> -        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (t=
ma_branch_resteers + tma_dsb_switches + tma_icache_misses + tma_itlb_misses=
 + tma_lcp + tma_ms_switches))",
> +        "MetricExpr": "100 * (tma_fetch_latency * tma_icache_misses / (t=
ma_icache_misses + tma_itlb_misses + tma_branch_resteers + tma_ms_switches =
+ tma_lcp + tma_dsb_switches))",
>          "MetricGroup": "Fed;FetchLat;IcMiss;tma_issueFL",
>          "MetricName": "tma_info_botlnk_l2_ic_misses",
>          "MetricThreshold": "tma_info_botlnk_l2_ic_misses > 5",
> -        "PublicDescription": "Total pipeline cost of Instruction Cache m=
isses - subset of the Big_Code Bottleneck. Related metrics: ",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of instruction fetch re=
lated bottlenecks by large code footprint programs (i-side cache; TLB and B=
TB misses)",
> -        "MetricExpr": "100 * tma_fetch_latency * (tma_itlb_misses + tma_=
icache_misses + tma_unknown_branches) / (tma_branch_resteers + tma_dsb_swit=
ches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches)",
> -        "MetricGroup": "BigFootprint;BvBC;Fed;Frontend;IcMiss;MemoryTLB",
> -        "MetricName": "tma_info_bottleneck_big_code",
> -        "MetricThreshold": "tma_info_bottleneck_big_code > 20",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of instructions used fo=
r program control-flow - a subset of the Retiring category in TMA",
> -        "MetricExpr": "100 * ((cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ + =
2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETIRED.NOP@) / tma=
_info_thread_slots)",
> -        "MetricGroup": "BvBO;Ret",
> -        "MetricName": "tma_info_bottleneck_branching_overhead",
> -        "MetricThreshold": "tma_info_bottleneck_branching_overhead > 5",
> -        "PublicDescription": "Total pipeline cost of instructions used f=
or program control-flow - a subset of the Retiring category in TMA. Example=
s include function calls; loops and alignments. (A lower bound)",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Bandwidth related bottlenecks",
> -        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))=
 * (tma_mem_bandwidth / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory=
_bound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tm=
a_l3_bound + tma_store_bound)) * (tma_sq_full / (tma_contested_accesses + t=
ma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_bound * (=
tma_l1_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound=
 + tma_store_bound)) * (tma_fb_full / (tma_dtlb_load + tma_fb_full + tma_l1=
_hit_latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
> -        "MetricGroup": "BvMB;Mem;MemoryBW;Offcore;tma_issueBW",
> -        "MetricName": "tma_info_bottleneck_cache_memory_bandwidth",
> -        "MetricThreshold": "tma_info_bottleneck_cache_memory_bandwidth >=
 20",
> -        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Bandwidth related bottlenecks. Related metrics: tma_fb_full, tma_inf=
o_system_dram_bw_use, tma_mem_bandwidth, tma_sq_full",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of external Memory- or =
Cache-Latency related bottlenecks",
> -        "MetricExpr": "100 * (tma_memory_bound * (tma_dram_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound))=
 * (tma_mem_latency / (tma_mem_bandwidth + tma_mem_latency)) + tma_memory_b=
ound * (tma_l3_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_=
l3_bound + tma_store_bound)) * (tma_l3_hit_latency / (tma_contested_accesse=
s + tma_data_sharing + tma_l3_hit_latency + tma_sq_full)) + tma_memory_boun=
d * tma_l2_bound / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_b=
ound + tma_store_bound) + tma_memory_bound * (tma_store_bound / (tma_dram_b=
ound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tm=
a_store_latency / (tma_dtlb_store + tma_false_sharing + tma_split_stores + =
tma_store_latency + tma_streaming_stores)) + tma_memory_bound * (tma_l1_bou=
nd / (tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_sto=
re_bound)) * (tma_l1_hit_latency / (tma_dtlb_load + tma_fb_full + tma_l1_hi=
t_latency + tma_lock_latency + tma_split_loads + tma_store_fwd_blk)))",
> -        "MetricGroup": "BvML;Mem;MemoryLat;Offcore;tma_issueLat",
> -        "MetricName": "tma_info_bottleneck_cache_memory_latency",
> -        "MetricThreshold": "tma_info_bottleneck_cache_memory_latency > 2=
0",
> -        "PublicDescription": "Total pipeline cost of external Memory- or=
 Cache-Latency related bottlenecks. Related metrics: tma_l3_hit_latency, tm=
a_mem_latency",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost when the execution is c=
ompute-bound - an estimation",
> -        "MetricExpr": "100 * (tma_core_bound * tma_divider / (tma_divide=
r + tma_ports_utilization + tma_serializing_operation) + tma_core_bound * (=
tma_ports_utilization / (tma_divider + tma_ports_utilization + tma_serializ=
ing_operation)) * (tma_ports_utilized_3m / (tma_ports_utilized_0 + tma_port=
s_utilized_1 + tma_ports_utilized_2 + tma_ports_utilized_3m)))",
> -        "MetricGroup": "BvCB;Cor;tma_issueComp",
> -        "MetricName": "tma_info_bottleneck_compute_bound_est",
> -        "MetricThreshold": "tma_info_bottleneck_compute_bound_est > 20",
> -        "PublicDescription": "Total pipeline cost when the execution is =
compute-bound - an estimation. Covers Core Bound when High ILP as well as w=
hen long-latency execution units are busy. Related metrics: ",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of instruction fetch ba=
ndwidth related bottlenecks (when the front-end could not sustain operation=
s delivery to the back-end)",
> -        "MetricExpr": "100 * (tma_frontend_bound - (1 - 10 * tma_microco=
de_sequencer * tma_other_mispredicts / tma_branch_mispredicts) * tma_fetch_=
latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_switche=
s + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches) - (1 -=
 cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@UOPS_RETIRED.MS\\,cmask\\=
=3D1@) * (tma_fetch_latency * (tma_ms_switches + tma_branch_resteers * (tma=
_clears_resteers + tma_mispredicts_resteers * tma_other_mispredicts / tma_b=
ranch_mispredicts) / (tma_clears_resteers + tma_mispredicts_resteers + tma_=
unknown_branches)) / (tma_branch_resteers + tma_dsb_switches + tma_icache_m=
isses + tma_itlb_misses + tma_lcp + tma_ms_switches))) - tma_info_bottlenec=
k_big_code",
> -        "MetricGroup": "BvFB;Fed;FetchBW;Frontend",
> -        "MetricName": "tma_info_bottleneck_instruction_fetch_bw",
> -        "MetricThreshold": "tma_info_bottleneck_instruction_fetch_bw > 2=
0",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of irregular execution =
(e.g",
> -        "MetricExpr": "100 * ((1 - cpu_core@INST_RETIRED.REP_ITERATION@ =
/ cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1@) * (tma_fetch_latency * (tma_ms_s=
witches + tma_branch_resteers * (tma_clears_resteers + tma_mispredicts_rest=
eers * tma_other_mispredicts / tma_branch_mispredicts) / (tma_clears_restee=
rs + tma_mispredicts_resteers + tma_unknown_branches)) / (tma_branch_restee=
rs + tma_dsb_switches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma=
_ms_switches)) + 10 * tma_microcode_sequencer * tma_other_mispredicts / tma=
_branch_mispredicts * tma_branch_mispredicts + tma_machine_clears * tma_oth=
er_nukes / tma_other_nukes + tma_core_bound * (tma_serializing_operation + =
cpu_core@RS.EMPTY\\,umask\\=3D1@ / tma_info_thread_clks * tma_ports_utilize=
d_0) / (tma_divider + tma_ports_utilization + tma_serializing_operation) + =
tma_microcode_sequencer / (tma_few_uops_instructions + tma_microcode_sequen=
cer) * (tma_assists / tma_microcode_sequencer) * tma_heavy_operations)",
> -        "MetricGroup": "Bad;BvIO;Cor;Ret;tma_issueMS",
> -        "MetricName": "tma_info_bottleneck_irregular_overhead",
> -        "MetricThreshold": "tma_info_bottleneck_irregular_overhead > 10",
> -        "PublicDescription": "Total pipeline cost of irregular execution=
 (e.g. FP-assists in HPC, Wait time with work imbalance multithreaded workl=
oads, overhead in system services or virtualized environments). Related met=
rics: tma_microcode_sequencer, tma_ms_switches",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of Memory Address Trans=
lation related bottlenecks (data-side TLBs)",
> -        "MetricExpr": "100 * (tma_memory_bound * (tma_l1_bound / max(tma=
_memory_bound, tma_dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound =
+ tma_store_bound)) * (tma_dtlb_load / max(tma_l1_bound, tma_dtlb_load + tm=
a_fb_full + tma_l1_hit_latency + tma_lock_latency + tma_split_loads + tma_s=
tore_fwd_blk)) + tma_memory_bound * (tma_store_bound / (tma_dram_bound + tm=
a_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound)) * (tma_dtlb_st=
ore / (tma_dtlb_store + tma_false_sharing + tma_split_stores + tma_store_la=
tency + tma_streaming_stores)))",
> -        "MetricGroup": "BvMT;Mem;MemoryTLB;Offcore;tma_issueTLB",
> -        "MetricName": "tma_info_bottleneck_memory_data_tlbs",
> -        "MetricThreshold": "tma_info_bottleneck_memory_data_tlbs > 20",
> -        "PublicDescription": "Total pipeline cost of Memory Address Tran=
slation related bottlenecks (data-side TLBs). Related metrics: tma_dtlb_loa=
d, tma_dtlb_store, tma_info_bottleneck_memory_synchronization",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of Memory Synchronizati=
on related bottlenecks (data transfers and coherency updates across process=
ors)",
> -        "MetricExpr": "100 * (tma_memory_bound * (tma_l3_bound / (tma_dr=
am_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) * =
(tma_contested_accesses + tma_data_sharing) / (tma_contested_accesses + tma=
_data_sharing + tma_l3_hit_latency + tma_sq_full) + tma_store_bound / (tma_=
dram_bound + tma_l1_bound + tma_l2_bound + tma_l3_bound + tma_store_bound) =
* tma_false_sharing / (tma_dtlb_store + tma_false_sharing + tma_split_store=
s + tma_store_latency + tma_streaming_stores - tma_store_latency)) + tma_ma=
chine_clears * (1 - tma_other_nukes / tma_other_nukes))",
> -        "MetricGroup": "BvMS;Mem;Offcore;tma_issueTLB",
> -        "MetricName": "tma_info_bottleneck_memory_synchronization",
> -        "MetricThreshold": "tma_info_bottleneck_memory_synchronization >=
 10",
> -        "PublicDescription": "Total pipeline cost of Memory Synchronizat=
ion related bottlenecks (data transfers and coherency updates across proces=
sors). Related metrics: tma_dtlb_load, tma_dtlb_store, tma_info_bottleneck_=
memory_data_tlbs",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of Branch Misprediction=
 related bottlenecks",
> -        "MetricExpr": "100 * (1 - 10 * tma_microcode_sequencer * tma_oth=
er_mispredicts / tma_branch_mispredicts) * (tma_branch_mispredicts + tma_fe=
tch_latency * tma_mispredicts_resteers / (tma_branch_resteers + tma_dsb_swi=
tches + tma_icache_misses + tma_itlb_misses + tma_lcp + tma_ms_switches))",
> -        "MetricGroup": "Bad;BadSpec;BrMispredicts;BvMP;tma_issueBM",
> -        "MetricName": "tma_info_bottleneck_mispredictions",
> -        "MetricThreshold": "tma_info_bottleneck_mispredictions > 20",
> -        "PublicDescription": "Total pipeline cost of Branch Mispredictio=
n related bottlenecks. Related metrics: tma_branch_mispredicts, tma_info_ba=
d_spec_branch_misprediction_cost, tma_mispredicts_resteers",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of remaining bottleneck=
s in the back-end",
> -        "MetricExpr": "100 - (tma_info_bottleneck_big_code + tma_info_bo=
ttleneck_instruction_fetch_bw + tma_info_bottleneck_mispredictions + tma_in=
fo_bottleneck_cache_memory_bandwidth + tma_info_bottleneck_cache_memory_lat=
ency + tma_info_bottleneck_memory_data_tlbs + tma_info_bottleneck_memory_sy=
nchronization + tma_info_bottleneck_compute_bound_est + tma_info_bottleneck=
_irregular_overhead + tma_info_bottleneck_branching_overhead + tma_info_bot=
tleneck_useful_work)",
> -        "MetricGroup": "BvOB;Cor;Offcore",
> -        "MetricName": "tma_info_bottleneck_other_bottlenecks",
> -        "MetricThreshold": "tma_info_bottleneck_other_bottlenecks > 20",
> -        "PublicDescription": "Total pipeline cost of remaining bottlenec=
ks in the back-end. Examples include data-dependencies (Core Bound when Low=
 ILP) and other unlisted memory-related stalls.",
> -        "Unit": "cpu_core"
> -    },
> -    {
> -        "BriefDescription": "Total pipeline cost of \"useful operations\=
" - the portion of Retiring category not covered by Branching_Overhead nor =
Irregular_Overhead.",
> -        "MetricExpr": "100 * (tma_retiring - (cpu_core@BR_INST_RETIRED.A=
LL_BRANCHES@ + 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@INST_RETI=
RED.NOP@) / tma_info_thread_slots - tma_microcode_sequencer / (tma_few_uops=
_instructions + tma_microcode_sequencer) * (tma_assists / tma_microcode_seq=
uencer) * tma_heavy_operations)",
> -        "MetricGroup": "BvUW;Ret",
> -        "MetricName": "tma_info_bottleneck_useful_work",
> -        "MetricThreshold": "tma_info_bottleneck_useful_work > 20",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of branches that are CALL or RET",
> -        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_CALL@ + cpu_core@B=
R_INST_RETIRED.NEAR_RETURN@) / cpu_core@BR_INST_RETIRED.ALL_BRANCHES@",
> +        "MetricExpr": "(BR_INST_RETIRED.NEAR_CALL + BR_INST_RETIRED.NEAR=
_RETURN) / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricGroup": "Bad;Branches",
>          "MetricName": "tma_info_branches_callret",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of branches that are non-taken con=
ditionals",
> -        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_NTAKEN@ / cpu_core@=
BR_INST_RETIRED.ALL_BRANCHES@",
> +        "MetricExpr": "BR_INST_RETIRED.COND_NTAKEN / BR_INST_RETIRED.ALL=
_BRANCHES",
>          "MetricGroup": "Bad;Branches;CodeGen;PGO",
>          "MetricName": "tma_info_branches_cond_nt",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of branches that are taken conditi=
onals",
> -        "MetricExpr": "cpu_core@BR_INST_RETIRED.COND_TAKEN@ / cpu_core@B=
R_INST_RETIRED.ALL_BRANCHES@",
> +        "MetricExpr": "BR_INST_RETIRED.COND_TAKEN / BR_INST_RETIRED.ALL_=
BRANCHES",
>          "MetricGroup": "Bad;Branches;CodeGen;PGO",
>          "MetricName": "tma_info_branches_cond_tk",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of branches that are unconditional=
 (direct or indirect) jumps",
> -        "MetricExpr": "(cpu_core@BR_INST_RETIRED.NEAR_TAKEN@ - cpu_core@=
BR_INST_RETIRED.COND_TAKEN@ - 2 * cpu_core@BR_INST_RETIRED.NEAR_CALL@) / cp=
u_core@BR_INST_RETIRED.ALL_BRANCHES@",
> +        "MetricExpr": "(BR_INST_RETIRED.NEAR_TAKEN - BR_INST_RETIRED.CON=
D_TAKEN - 2 * BR_INST_RETIRED.NEAR_CALL) / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricGroup": "Bad;Branches",
>          "MetricName": "tma_info_branches_jump",
>          "Unit": "cpu_core"
> @@ -1313,50 +3296,50 @@
>      },
>      {
>          "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
> -        "MetricExpr": "(cpu_core@CPU_CLK_UNHALTED.DISTRIBUTED@ if #SMT_o=
n else tma_info_thread_clks)",
> +        "MetricExpr": "(CPU_CLK_UNHALTED.DISTRIBUTED if #SMT_on else tma=
_info_thread_clks)",
>          "MetricGroup": "SMT",
>          "MetricName": "tma_info_core_core_clks",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions Per Cycle across hyper-threads=
 (per physical core)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / tma_info_core_core_c=
lks",
> +        "MetricExpr": "INST_RETIRED.ANY / tma_info_core_core_clks",
>          "MetricGroup": "Ret;SMT;TmaL1;tma_L1_group",
>          "MetricName": "tma_info_core_coreipc",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "uops Executed per Cycle",
> -        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / tma_info_thread_=
clks",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / tma_info_thread_clks",
>          "MetricGroup": "Power",
>          "MetricName": "tma_info_core_epc",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Floating Point Operations Per Cycle",
> -        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu=
_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INS=
T_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@=
) / tma_info_core_core_clks",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST=
_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / tma_info_core_core_clks",
>          "MetricGroup": "Flops;Ret",
>          "MetricName": "tma_info_core_flopc",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Actual per-core usage of the Floating Point=
 non-X87 execution units (regardless of precision or vector-width)",
> -        "MetricExpr": "(cpu_core@FP_ARITH_DISPATCHED.PORT_0@ + cpu_core@=
FP_ARITH_DISPATCHED.PORT_1@ + cpu_core@FP_ARITH_DISPATCHED.PORT_5@) / (2 * =
tma_info_core_core_clks)",
> +        "MetricExpr": "(FP_ARITH_DISPATCHED.PORT_0 + FP_ARITH_DISPATCHED=
=2EPORT_1 + FP_ARITH_DISPATCHED.PORT_5) / (2 * tma_info_core_core_clks)",
>          "MetricGroup": "Cor;Flops;HPC",
>          "MetricName": "tma_info_core_fp_arith_utilization",
> -        "PublicDescription": "Actual per-core usage of the Floating Poin=
t non-X87 execution units (regardless of precision or vector-width). Values=
 > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common=
; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less com=
mon).",
> +        "PublicDescription": "Actual per-core usage of the Floating Poin=
t non-X87 execution units (regardless of precision or vector-width). Values=
 > 1 are possible due to ([BDW+] Fused-Multiply Add (FMA) counting - common=
; [ADL+] use all of ADD/MUL/FMA in Scalar or 128/256-bit vectors - less com=
mon)",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per thread (logical-processor)=
",
> -        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_EX=
ECUTED.THREAD\\,cmask\\=3D1@",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / cpu@UOPS_EXECUTED.THREAD\\=
,cmask\\=3D0x1@",
>          "MetricGroup": "Backend;Cor;Pipeline;PortsUtil",
>          "MetricName": "tma_info_core_ilp",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
> -        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@UOPS_ISSUED.ANY=
@",
> +        "MetricExpr": "IDQ.DSB_UOPS / UOPS_ISSUED.ANY",
>          "MetricGroup": "DSB;Fed;FetchBW;tma_issueFB",
>          "MetricName": "tma_info_frontend_dsb_coverage",
>          "MetricThreshold": "tma_info_frontend_dsb_coverage < 0.7 & tma_i=
nfo_thread_ipc / 6 > 0.35",
> @@ -1364,29 +3347,29 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Average number of cycles of a switch from t=
he DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for detai=
ls.",
> -        "MetricExpr": "cpu_core@DSB2MITE_SWITCHES.PENALTY_CYCLES@ / cpu_=
core@DSB2MITE_SWITCHES.PENALTY_CYCLES\\,cmask\\=3D1\\,edge@",
> +        "BriefDescription": "Average number of cycles of a switch from t=
he DSB fetch-unit to MITE fetch unit - see DSB_Switches tree node for detai=
ls",
> +        "MetricExpr": "DSB2MITE_SWITCHES.PENALTY_CYCLES / cpu@DSB2MITE_S=
WITCHES.PENALTY_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
>          "MetricGroup": "DSBmiss",
>          "MetricName": "tma_info_frontend_dsb_switch_cost",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average number of Uops issued by front-end =
when it issued something",
> -        "MetricExpr": "cpu_core@UOPS_ISSUED.ANY@ / cpu_core@UOPS_ISSUED.=
ANY\\,cmask\\=3D1@",
> +        "MetricExpr": "UOPS_ISSUED.ANY / cpu@UOPS_ISSUED.ANY\\,cmask\\=
=3D0x1@",
>          "MetricGroup": "Fed;FetchBW",
>          "MetricName": "tma_info_frontend_fetch_upc",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average Latency for L1 instruction cache mi=
sses",
> -        "MetricExpr": "cpu_core@ICACHE_DATA.STALLS@ / cpu_core@ICACHE_DA=
TA.STALLS\\,cmask\\=3D1\\,edge@",
> +        "MetricExpr": "ICACHE_DATA.STALLS / cpu@ICACHE_DATA.STALLS\\,cma=
sk\\=3D0x1\\,edge\\=3D0x1@",
>          "MetricGroup": "Fed;FetchLat;IcMiss",
>          "MetricName": "tma_info_frontend_icache_miss_latency",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per non-speculative DSB miss (=
lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FRONTEND_RE=
TIRED.ANY_DSB_MISS@",
> +        "MetricExpr": "INST_RETIRED.ANY / FRONTEND_RETIRED.ANY_DSB_MISS",
>          "MetricGroup": "DSBmiss;Fed",
>          "MetricName": "tma_info_frontend_ipdsb_miss_ret",
>          "MetricThreshold": "tma_info_frontend_ipdsb_miss_ret < 50",
> @@ -1394,50 +3377,57 @@
>      },
>      {
>          "BriefDescription": "Instructions per speculative Unknown Branch=
 Misprediction (BAClear) (lower number means higher occurrence rate)",
> -        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@BACLEAR=
S.ANY@",
> +        "MetricExpr": "tma_info_inst_mix_instructions / BACLEARS.ANY",
>          "MetricGroup": "Fed",
>          "MetricName": "tma_info_frontend_ipunknown_branch",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache true code cacheline misses per kil=
o instruction",
> -        "MetricExpr": "1e3 * cpu_core@FRONTEND_RETIRED.L2_MISS@ / cpu_co=
re@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * FRONTEND_RETIRED.L2_MISS / INST_RETIRED.ANY=
",
>          "MetricGroup": "IcMiss",
>          "MetricName": "tma_info_frontend_l2mpki_code",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache speculative code cacheline misses =
per kilo instruction",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.CODE_RD_MISS@ / cpu_core@=
INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.CODE_RD_MISS / INST_RETIRED.ANY",
>          "MetricGroup": "IcMiss",
>          "MetricName": "tma_info_frontend_l2mpki_code_all",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of Uops delivered by the LSD (Loop=
 Stream Detector; aka Loop Cache)",
> -        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@UOPS_ISSUED.ANY@",
> +        "MetricExpr": "LSD.UOPS / UOPS_ISSUED.ANY",
>          "MetricGroup": "Fed;LSD",
>          "MetricName": "tma_info_frontend_lsd_coverage",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Taken Branches retired Per Cycle",
> +        "MetricExpr": "BR_INST_RETIRED.NEAR_TAKEN / tma_info_thread_clks=
",
> +        "MetricGroup": "Branches;FetchBW",
> +        "MetricName": "tma_info_frontend_tbpc",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Average number of cycles the front-end was =
delayed due to an Unknown Branch detection",
> -        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / cpu_co=
re@INT_MISC.UNKNOWN_BRANCH_CYCLES\\,cmask\\=3D1\\,edge@",
> +        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / cpu@INT_MISC.UNK=
NOWN_BRANCH_CYCLES\\,cmask\\=3D0x1\\,edge\\=3D0x1@",
>          "MetricGroup": "Fed",
>          "MetricName": "tma_info_frontend_unknown_branch_cost",
> -        "PublicDescription": "Average number of cycles the front-end was=
 delayed due to an Unknown Branch detection. See Unknown_Branches node.",
> +        "PublicDescription": "Average number of cycles the front-end was=
 delayed due to an Unknown Branch detection. See Unknown_Branches node",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Branch instructions per taken branch.",
> -        "MetricExpr": "cpu_core@BR_INST_RETIRED.ALL_BRANCHES@ / cpu_core=
@BR_INST_RETIRED.NEAR_TAKEN@",
> +        "BriefDescription": "Branch instructions per taken branch",
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NE=
AR_TAKEN",
>          "MetricGroup": "Branches;Fed;PGO",
>          "MetricName": "tma_info_inst_mix_bptkbranch",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Total number of retired Instructions",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "INST_RETIRED.ANY",
>          "MetricGroup": "Summary;TmaL1;tma_L1_group",
>          "MetricName": "tma_info_inst_mix_instructions",
>          "PublicDescription": "Total number of retired Instructions. Samp=
le with: INST_RETIRED.PREC_DIST",
> @@ -1445,52 +3435,52 @@
>      },
>      {
>          "BriefDescription": "Instructions per FP Arithmetic instruction =
(lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_I=
NST_RETIRED.SCALAR@ + cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR =
+ FP_ARITH_INST_RETIRED.VECTOR)",
>          "MetricGroup": "Flops;InsType",
>          "MetricName": "tma_info_inst_mix_iparith",
>          "MetricThreshold": "tma_info_inst_mix_iparith < 10",
> -        "PublicDescription": "Instructions per FP Arithmetic instruction=
 (lower number means higher occurrence rate). Values < 1 are possible due t=
o intentional FMA double counting. Approximated prior to BDW.",
> +        "PublicDescription": "Instructions per FP Arithmetic instruction=
 (lower number means higher occurrence rate). Values < 1 are possible due t=
o intentional FMA double counting. Approximated prior to BDW",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per FP Arithmetic AVX/SSE 128-=
bit instruction (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_I=
NST_RETIRED.128B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.128B_PACKE=
D_SINGLE@)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.128B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE)",
>          "MetricGroup": "Flops;FpVector;InsType",
>          "MetricName": "tma_info_inst_mix_iparith_avx128",
>          "MetricThreshold": "tma_info_inst_mix_iparith_avx128 < 10",
> -        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128=
-bit instruction (lower number means higher occurrence rate). Values < 1 ar=
e possible due to intentional FMA double counting.",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX/SSE 128=
-bit instruction (lower number means higher occurrence rate). Values < 1 ar=
e possible due to intentional FMA double counting",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per FP Arithmetic AVX* 256-bit=
 instruction (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_I=
NST_RETIRED.256B_PACKED_DOUBLE@ + cpu_core@FP_ARITH_INST_RETIRED.256B_PACKE=
D_SINGLE@)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.256B_PA=
CKED_DOUBLE + FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
>          "MetricGroup": "Flops;FpVector;InsType",
>          "MetricName": "tma_info_inst_mix_iparith_avx256",
>          "MetricThreshold": "tma_info_inst_mix_iparith_avx256 < 10",
> -        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bi=
t instruction (lower number means higher occurrence rate). Values < 1 are p=
ossible due to intentional FMA double counting.",
> +        "PublicDescription": "Instructions per FP Arithmetic AVX* 256-bi=
t instruction (lower number means higher occurrence rate). Values < 1 are p=
ossible due to intentional FMA double counting",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per FP Arithmetic Scalar Doubl=
e-Precision instruction (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_IN=
ST_RETIRED.SCALAR_DOUBLE@",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_D=
OUBLE",
>          "MetricGroup": "Flops;FpScalar;InsType",
>          "MetricName": "tma_info_inst_mix_iparith_scalar_dp",
>          "MetricThreshold": "tma_info_inst_mix_iparith_scalar_dp < 10",
> -        "PublicDescription": "Instructions per FP Arithmetic Scalar Doub=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting.",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Doub=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per FP Arithmetic Scalar Singl=
e-Precision instruction (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@FP_ARITH_IN=
ST_RETIRED.SCALAR_SINGLE@",
> +        "MetricExpr": "INST_RETIRED.ANY / FP_ARITH_INST_RETIRED.SCALAR_S=
INGLE",
>          "MetricGroup": "Flops;FpScalar;InsType",
>          "MetricName": "tma_info_inst_mix_iparith_scalar_sp",
>          "MetricThreshold": "tma_info_inst_mix_iparith_scalar_sp < 10",
> -        "PublicDescription": "Instructions per FP Arithmetic Scalar Sing=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting.",
> +        "PublicDescription": "Instructions per FP Arithmetic Scalar Sing=
le-Precision instruction (lower number means higher occurrence rate). Value=
s < 1 are possible due to intentional FMA double counting",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RET=
IRED.ALL_BRANCHES@",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
>          "MetricGroup": "Branches;Fed;InsType",
>          "MetricName": "tma_info_inst_mix_ipbranch",
>          "MetricThreshold": "tma_info_inst_mix_ipbranch < 8",
> @@ -1498,7 +3488,7 @@
>      },
>      {
>          "BriefDescription": "Instructions per (near) call (lower number =
means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RET=
IRED.NEAR_CALL@",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
>          "MetricGroup": "Branches;Fed;PGO",
>          "MetricName": "tma_info_inst_mix_ipcall",
>          "MetricThreshold": "tma_info_inst_mix_ipcall < 200",
> @@ -1506,7 +3496,7 @@
>      },
>      {
>          "BriefDescription": "Instructions per Floating Point (FP) Operat=
ion (lower number means higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_I=
NST_RETIRED.SCALAR@ + 2 * cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE=
@ + 4 * cpu_core@FP_ARITH_INST_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INS=
T_RETIRED.256B_PACKED_SINGLE@)",
> +        "MetricExpr": "INST_RETIRED.ANY / (FP_ARITH_INST_RETIRED.SCALAR =
+ 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.=
4_FLOPS + 8 * FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE)",
>          "MetricGroup": "Flops;InsType",
>          "MetricName": "tma_info_inst_mix_ipflop",
>          "MetricThreshold": "tma_info_inst_mix_ipflop < 10",
> @@ -1514,7 +3504,7 @@
>      },
>      {
>          "BriefDescription": "Instructions per Load (lower number means h=
igher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RE=
TIRED.ALL_LOADS@",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
>          "MetricGroup": "InsType",
>          "MetricName": "tma_info_inst_mix_ipload",
>          "MetricThreshold": "tma_info_inst_mix_ipload < 3",
> @@ -1522,14 +3512,14 @@
>      },
>      {
>          "BriefDescription": "Instructions per PAUSE (lower number means =
higher occurrence rate)",
> -        "MetricExpr": "tma_info_inst_mix_instructions / cpu_core@CPU_CLK=
_UNHALTED.PAUSE_INST@",
> +        "MetricExpr": "tma_info_inst_mix_instructions / CPU_CLK_UNHALTED=
=2EPAUSE_INST",
>          "MetricGroup": "Flops;FpVector;InsType",
>          "MetricName": "tma_info_inst_mix_ippause",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per Store (lower number means =
higher occurrence rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@MEM_INST_RE=
TIRED.ALL_STORES@",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
>          "MetricGroup": "InsType",
>          "MetricName": "tma_info_inst_mix_ipstore",
>          "MetricThreshold": "tma_info_inst_mix_ipstore < 8",
> @@ -1537,7 +3527,7 @@
>      },
>      {
>          "BriefDescription": "Instructions per Software prefetch instruct=
ion (of any type: NTA/T0/T1/T2/Prefetch) (lower number means higher occurre=
nce rate)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@SW_PREFETCH=
_ACCESS.T0\\,umask\\=3D0xF@",
> +        "MetricExpr": "INST_RETIRED.ANY / SW_PREFETCH_ACCESS.ANY",
>          "MetricGroup": "Prefetches",
>          "MetricName": "tma_info_inst_mix_ipswpf",
>          "MetricThreshold": "tma_info_inst_mix_ipswpf < 100",
> @@ -1545,10 +3535,10 @@
>      },
>      {
>          "BriefDescription": "Instructions per taken branch",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RET=
IRED.NEAR_TAKEN@",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
>          "MetricGroup": "Branches;Fed;FetchBW;Frontend;PGO;tma_issueFB",
>          "MetricName": "tma_info_inst_mix_iptb",
> -        "MetricThreshold": "tma_info_inst_mix_iptb < 13",
> +        "MetricThreshold": "tma_info_inst_mix_iptb < 6 * 2 + 1",
>          "PublicDescription": "Instructions per taken branch. Related met=
rics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwid=
th, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_lcp",
>          "Unit": "cpu_core"
>      },
> @@ -1582,176 +3572,184 @@
>      },
>      {
>          "BriefDescription": "Fill Buffer (FB) hits per kilo instructions=
 for retired demand loads (L1D misses that merge into ongoing miss-handling=
 entries)",
> -        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_cor=
e@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.FB_HIT / INST_RETIRED.ANY",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_fb_hpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average per-thread data fill bandwidth to t=
he L1 data cache [GB / sec]",
> -        "MetricExpr": "64 * cpu_core@L1D.REPLACEMENT@ / 1e9 / duration_t=
ime",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1e9 / tma_info_system_time=
",
>          "MetricGroup": "Mem;MemoryBW",
>          "MetricName": "tma_info_memory_l1d_cache_fill_bw",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
> -        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L1_MISS@ / cpu_co=
re@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY=
",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_l1mpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L1 cache true misses per kilo instruction f=
or all demand loads (including speculative)",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.ALL_DEMAND_DATA_RD@ / cpu=
_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.ALL_DEMAND_DATA_RD / INST_RETIRED.=
ANY",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_l1mpki_load",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average per-thread data fill bandwidth to t=
he L2 cache [GB / sec]",
> -        "MetricExpr": "64 * cpu_core@L2_LINES_IN.ALL@ / 1e9 / duration_t=
ime",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1e9 / tma_info_system_time=
",
>          "MetricGroup": "Mem;MemoryBW",
>          "MetricName": "tma_info_memory_l2_cache_fill_bw",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache hits per kilo instruction for all =
request types (including speculative)",
> -        "MetricExpr": "1e3 * (cpu_core@L2_RQSTS.REFERENCES@ - cpu_core@L=
2_RQSTS.MISS@) / cpu_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * (L2_RQSTS.REFERENCES - L2_RQSTS.MISS) / INS=
T_RETIRED.ANY",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_l2hpki_all",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache hits per kilo instruction for all =
demand loads  (including speculative)",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_HIT@ / cpu=
_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_HIT / INST_RETIRED.=
ANY",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_l2hpki_load",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache true misses per kilo instruction f=
or retired demand loads",
> -        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L2_MISS@ / cpu_co=
re@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY=
",
>          "MetricGroup": "Backend;CacheHits;Mem",
>          "MetricName": "tma_info_memory_l2mpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all request types (including speculative)",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.MISS@ / cpu_core@INST_RET=
IRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.MISS / INST_RETIRED.ANY",
>          "MetricGroup": "CacheHits;Mem;Offcore",
>          "MetricName": "tma_info_memory_l2mpki_all",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L2 cache ([RKL+] true) misses per kilo inst=
ruction for all demand loads  (including speculative)",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.DEMAND_DATA_RD_MISS@ / cp=
u_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.DEMAND_DATA_RD_MISS / INST_RETIRED=
=2EANY",
>          "MetricGroup": "CacheHits;Mem",
>          "MetricName": "tma_info_memory_l2mpki_load",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Offcore requests (L2 cache miss) per kilo i=
nstruction for demand RFOs",
> -        "MetricExpr": "1e3 * cpu_core@L2_RQSTS.RFO_MISS@ / cpu_core@INST=
_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * L2_RQSTS.RFO_MISS / INST_RETIRED.ANY",
>          "MetricGroup": "CacheMisses;Offcore",
>          "MetricName": "tma_info_memory_l2mpki_rfo",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average per-thread data access bandwidth to=
 the L3 cache [GB / sec]",
> -        "MetricExpr": "64 * cpu_core@OFFCORE_REQUESTS.ALL_REQUESTS@ / 1e=
9 / duration_time",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1e9 / tma_in=
fo_system_time",
>          "MetricGroup": "Mem;MemoryBW;Offcore",
>          "MetricName": "tma_info_memory_l3_cache_access_bw",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average per-thread data fill bandwidth to t=
he L3 cache [GB / sec]",
> -        "MetricExpr": "64 * cpu_core@LONGEST_LAT_CACHE.MISS@ / 1e9 / dur=
ation_time",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1e9 / tma_info_syst=
em_time",
>          "MetricGroup": "Mem;MemoryBW",
>          "MetricName": "tma_info_memory_l3_cache_fill_bw",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "L3 cache true misses per kilo instruction f=
or retired demand loads",
> -        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_RETIRED.L3_MISS@ / cpu_co=
re@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY=
",
>          "MetricGroup": "Mem",
>          "MetricName": "tma_info_memory_l3mpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average Parallel L2 cache miss data reads",
> -        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DATA_RD@ / =
cpu_core@OFFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DATA_RD / OFFCORE_RE=
QUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD",
>          "MetricGroup": "Memory_BW;Offcore",
>          "MetricName": "tma_info_memory_latency_data_l2_mlp",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average Latency for L2 cache miss demand Lo=
ads",
> -        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA=
_RD@ / cpu_core@OFFCORE_REQUESTS.DEMAND_DATA_RD@",
> -        "MetricGroup": "Memory_Lat;Offcore",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / OFF=
CORE_REQUESTS.DEMAND_DATA_RD",
> +        "MetricGroup": "LockCont;Memory_Lat;Offcore",
>          "MetricName": "tma_info_memory_latency_load_l2_miss_latency",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average Parallel L2 cache miss demand Loads=
",
> -        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA=
_RD@ / cpu_core@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D1@",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD / cpu=
@OFFCORE_REQUESTS_OUTSTANDING.DEMAND_DATA_RD\\,cmask\\=3D0x1@",
>          "MetricGroup": "Memory_BW;Offcore",
>          "MetricName": "tma_info_memory_latency_load_l2_mlp",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average Latency for L3 cache miss demand Lo=
ads",
> -        "MetricExpr": "cpu_core@OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEM=
AND_DATA_RD@ / cpu_core@OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD@",
> +        "MetricExpr": "OFFCORE_REQUESTS_OUTSTANDING.L3_MISS_DEMAND_DATA_=
RD / OFFCORE_REQUESTS.L3_MISS_DEMAND_DATA_RD",
>          "MetricGroup": "Memory_Lat;Offcore",
>          "MetricName": "tma_info_memory_latency_load_l3_miss_latency",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand load operations (in core cycles)",
> -        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@MEM_LO=
AD_COMPLETED.L1_MISS_ANY@",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / MEM_LOAD_COMPLETED.L1_MIS=
S_ANY",
>          "MetricGroup": "Mem;MemoryBound;MemoryLat",
>          "MetricName": "tma_info_memory_load_miss_real_latency",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "\"Bus lock\" per kilo instruction",
> -        "MetricExpr": "1e3 * cpu_core@SQ_MISC.BUS_LOCK@ / cpu_core@INST_=
RETIRED.ANY@",
> +        "MetricExpr": "1e3 * SQ_MISC.BUS_LOCK / INST_RETIRED.ANY",
>          "MetricGroup": "Mem",
>          "MetricName": "tma_info_memory_mix_bus_lock_pki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Un-cacheable retired load per kilo instruct=
ion",
> -        "MetricExpr": "1e3 * cpu_core@MEM_LOAD_MISC_RETIRED.UC@ / cpu_co=
re@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * MEM_LOAD_MISC_RETIRED.UC / INST_RETIRED.ANY=
",
>          "MetricGroup": "Mem",
>          "MetricName": "tma_info_memory_mix_uc_load_pki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Memory-Level-Parallelism (average number of=
 L1 miss demand load when there is at least one such miss",
> -        "MetricExpr": "cpu_core@L1D_PEND_MISS.PENDING@ / cpu_core@L1D_PE=
ND_MISS.PENDING_CYCLES@",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYC=
LES",
>          "MetricGroup": "Mem;MemoryBW;MemoryBound",
>          "MetricName": "tma_info_memory_mlp",
>          "PublicDescription": "Memory-Level-Parallelism (average number o=
f L1 miss demand load when there is at least one such miss. Per-Logical Pro=
cessor)",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Rate of L2 HW prefetched lines that were no=
t used by demand accesses",
> +        "MetricExpr": "L2_LINES_OUT.USELESS_HWPF / (L2_LINES_OUT.SILENT =
+ L2_LINES_OUT.NON_SILENT)",
> +        "MetricGroup": "Prefetches",
> +        "MetricName": "tma_info_memory_prefetches_useless_hwpf",
> +        "MetricThreshold": "tma_info_memory_prefetches_useless_hwpf > 0.=
15",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "STLB (2nd level TLB) code speculative misse=
s per kilo instruction (misses of any page-size that complete the page walk=
)",
> -        "MetricExpr": "1e3 * cpu_core@ITLB_MISSES.WALK_COMPLETED@ / cpu_=
core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * ITLB_MISSES.WALK_COMPLETED / INST_RETIRED.A=
NY",
>          "MetricGroup": "Fed;MemoryTLB",
>          "MetricName": "tma_info_memory_tlb_code_stlb_mpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "STLB (2nd level TLB) data load speculative =
misses per kilo instruction (misses of any page-size that complete the page=
 walk)",
> -        "MetricExpr": "1e3 * cpu_core@DTLB_LOAD_MISSES.WALK_COMPLETED@ /=
 cpu_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * DTLB_LOAD_MISSES.WALK_COMPLETED / INST_RETI=
RED.ANY",
>          "MetricGroup": "Mem;MemoryTLB",
>          "MetricName": "tma_info_memory_tlb_load_stlb_mpki",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Utilization of the core's Page Walker(s) se=
rving STLB misses triggered by instruction/Load/Store accesses",
> -        "MetricExpr": "(cpu_core@ITLB_MISSES.WALK_PENDING@ + cpu_core@DT=
LB_LOAD_MISSES.WALK_PENDING@ + cpu_core@DTLB_STORE_MISSES.WALK_PENDING@) / =
(4 * tma_info_core_core_clks)",
> +        "MetricExpr": "(ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK=
_PENDING + DTLB_STORE_MISSES.WALK_PENDING) / (4 * tma_info_core_core_clks)",
>          "MetricGroup": "Mem;MemoryTLB",
>          "MetricName": "tma_info_memory_tlb_page_walks_utilization",
>          "MetricThreshold": "tma_info_memory_tlb_page_walks_utilization >=
 0.5",
> @@ -1759,58 +3757,58 @@
>      },
>      {
>          "BriefDescription": "STLB (2nd level TLB) data store speculative=
 misses per kilo instruction (misses of any page-size that complete the pag=
e walk)",
> -        "MetricExpr": "1e3 * cpu_core@DTLB_STORE_MISSES.WALK_COMPLETED@ =
/ cpu_core@INST_RETIRED.ANY@",
> +        "MetricExpr": "1e3 * DTLB_STORE_MISSES.WALK_COMPLETED / INST_RET=
IRED.ANY",
>          "MetricGroup": "Mem;MemoryTLB",
>          "MetricName": "tma_info_memory_tlb_store_stlb_mpki",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is execution) per core",
> -        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / (cpu_core@UOPS_E=
XECUTED.CORE_CYCLES_GE_1@ / 2 if #SMT_on else cpu_core@UOPS_EXECUTED.THREAD=
\\,cmask\\=3D1@)",
> +        "BriefDescription": "",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / (UOPS_EXECUTED.CORE_CYCLES=
_GE_1 / 2 if #SMT_on else cpu@UOPS_EXECUTED.THREAD\\,cmask\\=3D0x1@)",
>          "MetricGroup": "Cor;Pipeline;PortsUtil;SMT",
>          "MetricName": "tma_info_pipeline_execute",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average number of uops fetched from DSB per=
 cycle",
> -        "MetricExpr": "cpu_core@IDQ.DSB_UOPS@ / cpu_core@IDQ.DSB_CYCLES_=
ANY@",
> +        "MetricExpr": "IDQ.DSB_UOPS / IDQ.DSB_CYCLES_ANY",
>          "MetricGroup": "Fed;FetchBW",
>          "MetricName": "tma_info_pipeline_fetch_dsb",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average number of uops fetched from LSD per=
 cycle",
> -        "MetricExpr": "cpu_core@LSD.UOPS@ / cpu_core@LSD.CYCLES_ACTIVE@",
> +        "MetricExpr": "LSD.UOPS / LSD.CYCLES_ACTIVE",
>          "MetricGroup": "Fed;FetchBW",
>          "MetricName": "tma_info_pipeline_fetch_lsd",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average number of uops fetched from MITE pe=
r cycle",
> -        "MetricExpr": "cpu_core@IDQ.MITE_UOPS@ / cpu_core@IDQ.MITE_CYCLE=
S_ANY@",
> +        "MetricExpr": "IDQ.MITE_UOPS / IDQ.MITE_CYCLES_ANY",
>          "MetricGroup": "Fed;FetchBW",
>          "MetricName": "tma_info_pipeline_fetch_mite",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions per a microcode Assist invocat=
ion",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@ASSISTS.ANY=
@",
> +        "MetricExpr": "INST_RETIRED.ANY / ASSISTS.ANY",
>          "MetricGroup": "MicroSeq;Pipeline;Ret;Retire",
>          "MetricName": "tma_info_pipeline_ipassist",
> -        "MetricThreshold": "tma_info_pipeline_ipassist < 100e3",
> +        "MetricThreshold": "tma_info_pipeline_ipassist < 100000",
>          "PublicDescription": "Instructions per a microcode Assist invoca=
tion. See Assists tree node for details (lower number means higher occurren=
ce rate)",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Average number of Uops retired in cycles wh=
ere at least one uop has retired.",
> -        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@U=
OPS_RETIRED.SLOTS\\,cmask\\=3D1@",
> +        "BriefDescription": "Average number of Uops retired in cycles wh=
ere at least one uop has retired",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu@UOPS_R=
ETIRED.SLOTS\\,cmask\\=3D0x1@",
>          "MetricGroup": "Pipeline;Ret",
>          "MetricName": "tma_info_pipeline_retire",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Estimated fraction of retirement-cycles dea=
ling with repeat instructions",
> -        "MetricExpr": "cpu_core@INST_RETIRED.REP_ITERATION@ / cpu_core@U=
OPS_RETIRED.SLOTS\\,cmask\\=3D1@",
> +        "MetricExpr": "INST_RETIRED.REP_ITERATION / cpu@UOPS_RETIRED.SLO=
TS\\,cmask\\=3D0x1@",
>          "MetricGroup": "MicroSeq;Pipeline;Ret",
>          "MetricName": "tma_info_pipeline_strings_cycles",
>          "MetricThreshold": "tma_info_pipeline_strings_cycles > 0.1",
> @@ -1818,7 +3816,7 @@
>      },
>      {
>          "BriefDescription": "Fraction of cycles the processor is waiting=
 yet unhalted; covering legacy PAUSE instruction, as well as C0.1 / C0.2 po=
wer-performance optimized states",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.C0_WAIT@ / tma_info_thr=
ead_clks",
> +        "MetricExpr": "CPU_CLK_UNHALTED.C0_WAIT / tma_info_thread_clks",
>          "MetricGroup": "C0Wait",
>          "MetricName": "tma_info_system_c0_wait",
>          "MetricThreshold": "tma_info_system_c0_wait > 0.05",
> @@ -1826,7 +3824,7 @@
>      },
>      {
>          "BriefDescription": "Measured Average Core Frequency for unhalte=
d processors [GHz]",
> -        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / d=
uration_time",
> +        "MetricExpr": "tma_info_system_turbo_utilization * TSC / 1e9 / t=
ma_info_system_time",
>          "MetricGroup": "Power;Summary",
>          "MetricName": "tma_info_system_core_frequency",
>          "Unit": "cpu_core"
> @@ -1840,22 +3838,22 @@
>      },
>      {
>          "BriefDescription": "Average number of utilized CPUs",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.REF_TSC@ / TSC",
> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / TSC",
>          "MetricGroup": "Summary",
>          "MetricName": "tma_info_system_cpus_utilized",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Average external Memory Bandwidth Use for r=
eads and writes [GB / sec]",
> -        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_=
REQUESTS.ALL) / 1e6 / duration_time / 1e3",
> +        "MetricExpr": "64 * (UNC_ARB_TRK_REQUESTS.ALL + UNC_ARB_COH_TRK_=
REQUESTS.ALL) / 1e6 / tma_info_system_time / 1e3",
>          "MetricGroup": "HPC;MemOffcore;MemoryBW;SoC;tma_issueBW",
>          "MetricName": "tma_info_system_dram_bw_use",
> -        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_fb_full, tma_info_bottlen=
eck_cache_memory_bandwidth, tma_mem_bandwidth, tma_sq_full",
> +        "PublicDescription": "Average external Memory Bandwidth Use for =
reads and writes [GB / sec]. Related metrics: tma_bottleneck_cache_memory_b=
andwidth, tma_fb_full, tma_mem_bandwidth, tma_sq_full",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Giga Floating Point Operations Per Second",
> -        "MetricExpr": "(cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ + 2 * cpu=
_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ + 4 * cpu_core@FP_ARITH_INS=
T_RETIRED.4_FLOPS@ + 8 * cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@=
) / 1e9 / duration_time",
> +        "MetricExpr": "(FP_ARITH_INST_RETIRED.SCALAR + 2 * FP_ARITH_INST=
_RETIRED.128B_PACKED_DOUBLE + 4 * FP_ARITH_INST_RETIRED.4_FLOPS + 8 * FP_AR=
ITH_INST_RETIRED.256B_PACKED_SINGLE) / 1e9 / tma_info_system_time",
>          "MetricGroup": "Cor;Flops;HPC",
>          "MetricName": "tma_info_system_gflops",
>          "PublicDescription": "Giga Floating Point Operations Per Second.=
 Aggregate across all supported options of: FP precisions, scalar and vecto=
r instructions, vector-width",
> @@ -1863,22 +3861,23 @@
>      },
>      {
>          "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / cpu_core@BR_INST_RET=
IRED.FAR_BRANCH@u",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
>          "MetricGroup": "Branches;OS",
>          "MetricName": "tma_info_system_ipfarbranch",
> -        "MetricThreshold": "tma_info_system_ipfarbranch < 1e6",
> +        "MetricThreshold": "tma_info_system_ipfarbranch < 1000000",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Cycles Per Instruction for the Operating Sy=
stem (OS) Kernel mode",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@I=
NST_RETIRED.ANY_P@k",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / INST_RETIRED.ANY_P:=
k",
>          "MetricGroup": "OS",
>          "MetricName": "tma_info_system_kernel_cpi",
> +        "ScaleUnit": "1per_instr",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of cycles spent in the Operating S=
ystem (OS) Kernel mode",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD_P@k / cpu_core@C=
PU_CLK_UNHALTED.THREAD@",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.TH=
READ",
>          "MetricGroup": "OS",
>          "MetricName": "tma_info_system_kernel_utilization",
>          "MetricThreshold": "tma_info_system_kernel_utilization > 0.05",
> @@ -1901,9 +3900,24 @@
>          "PublicDescription": "Average latency of data read request to ex=
ternal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetc=
hes. ([RKL+]memory-controller only)",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "PerfMon Event Multiplexing accuracy indicat=
or",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P / CPU_CLK_UNHALTED.THRE=
AD",
> +        "MetricGroup": "Summary",
> +        "MetricName": "tma_info_system_mux",
> +        "MetricThreshold": "tma_info_system_mux > 1.1 | tma_info_system_=
mux < 0.9",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Total package Power in Watts",
> +        "MetricExpr": "power@energy\\-pkg@ * 61 / (tma_info_system_time =
* 1e6)",
> +        "MetricGroup": "Power;SoC",
> +        "MetricName": "tma_info_system_power",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Fraction of cycles where both hardware Logi=
cal Processors were active",
> -        "MetricExpr": "(1 - cpu_core@CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE@=
 / cpu_core@CPU_CLK_UNHALTED.REF_DISTRIBUTED@ if #SMT_on else 0)",
> +        "MetricExpr": "(1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK=
_UNHALTED.REF_DISTRIBUTED if #SMT_on else 0)",
>          "MetricGroup": "SMT",
>          "MetricName": "tma_info_system_smt_2t_utilization",
>          "Unit": "cpu_core"
> @@ -1915,16 +3929,24 @@
>          "MetricName": "tma_info_system_socket_clks",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Run duration time in seconds",
> +        "MetricExpr": "duration_time",
> +        "MetricGroup": "Summary",
> +        "MetricName": "tma_info_system_time",
> +        "MetricThreshold": "tma_info_system_time < 1",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> -        "MetricExpr": "tma_info_thread_clks / cpu_core@CPU_CLK_UNHALTED.=
REF_TSC@",
> +        "MetricExpr": "tma_info_thread_clks / CPU_CLK_UNHALTED.REF_TSC",
>          "MetricGroup": "Power",
>          "MetricName": "tma_info_system_turbo_utilization",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active.",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.THREAD@",
> +        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
>          "MetricGroup": "Pipeline",
>          "MetricName": "tma_info_thread_clks",
>          "Unit": "cpu_core"
> @@ -1934,40 +3956,41 @@
>          "MetricExpr": "1 / tma_info_thread_ipc",
>          "MetricGroup": "Mem;Pipeline",
>          "MetricName": "tma_info_thread_cpi",
> +        "ScaleUnit": "1per_instr",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "The ratio of Executed- by Issued-Uops",
> -        "MetricExpr": "cpu_core@UOPS_EXECUTED.THREAD@ / cpu_core@UOPS_IS=
SUED.ANY@",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / UOPS_ISSUED.ANY",
>          "MetricGroup": "Cor;Pipeline",
>          "MetricName": "tma_info_thread_execute_per_issue",
> -        "PublicDescription": "The ratio of Executed- by Issued-Uops. Rat=
io > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate=
 of \"execute\" at rename stage.",
> +        "PublicDescription": "The ratio of Executed- by Issued-Uops. Rat=
io > 1 suggests high rate of uop micro-fusions. Ratio < 1 suggest high rate=
 of \"execute\" at rename stage",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Instructions Per Cycle (per Logical Process=
or)",
> -        "MetricExpr": "cpu_core@INST_RETIRED.ANY@ / tma_info_thread_clks=
",
> +        "MetricExpr": "INST_RETIRED.ANY / tma_info_thread_clks",
>          "MetricGroup": "Ret;Summary",
>          "MetricName": "tma_info_thread_ipc",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Total issue-pipeline slots (per-Physical Co=
re till ICL; per-Logical Processor ICL onward)",
> -        "MetricExpr": "cpu_core@TOPDOWN.SLOTS@",
> +        "MetricExpr": "slots",
>          "MetricGroup": "TmaL1;tma_L1_group",
>          "MetricName": "tma_info_thread_slots",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Fraction of Physical Core issue-slots utili=
zed by this Logical Processor",
> -        "MetricExpr": "(tma_info_thread_slots / (cpu_core@TOPDOWN.SLOTS@=
 / 2) if #SMT_on else 1)",
> +        "MetricExpr": "(tma_info_thread_slots / (slots / 2) if #SMT_on e=
lse 1)",
>          "MetricGroup": "SMT;TmaL1;tma_L1_group",
>          "MetricName": "tma_info_thread_slots_utilization",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "Uops Per Instruction",
> -        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@I=
NST_RETIRED.ANY@",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / INST_RETIR=
ED.ANY",
>          "MetricGroup": "Pipeline;Ret;Retire",
>          "MetricName": "tma_info_thread_uoppi",
>          "MetricThreshold": "tma_info_thread_uoppi > 1.05",
> @@ -1975,10 +3998,19 @@
>      },
>      {
>          "BriefDescription": "Uops per taken branch",
> -        "MetricExpr": "tma_retiring * tma_info_thread_slots / cpu_core@B=
R_INST_RETIRED.NEAR_TAKEN@",
> +        "MetricExpr": "tma_retiring * tma_info_thread_slots / BR_INST_RE=
TIRED.NEAR_TAKEN",
>          "MetricGroup": "Branches;Fed;FetchBW",
>          "MetricName": "tma_info_thread_uptb",
> -        "MetricThreshold": "tma_info_thread_uptb < 9",
> +        "MetricThreshold": "tma_info_thread_uptb < 6 * 1.5",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
here the Integer Divider unit was active",
> +        "MetricExpr": "tma_divider - tma_fp_divider",
> +        "MetricGroup": "TopdownL4;tma_L4_group;tma_divider_group",
> +        "MetricName": "tma_int_divider",
> +        "MetricThreshold": "tma_int_divider > 0.2 & tma_divider > 0.2 & =
tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> @@ -1987,114 +4019,124 @@
>          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operat=
ions_group",
>          "MetricName": "tma_int_operations",
>          "MetricThreshold": "tma_int_operations > 0.1 & tma_light_operati=
ons > 0.6",
> -        "PublicDescription": "This metric represents overall Integer (In=
t) select operations fraction the CPU has executed (retired). Vector/Matrix=
 Int operations and shuffles are counted. Note this metric's value may exce=
ed its parent due to use of \"Uops\" CountDomain.",
> +        "PublicDescription": "This metric represents overall Integer (In=
t) select operations fraction the CPU has executed (retired). Vector/Matrix=
 Int operations and shuffles are counted. Note this metric's value may exce=
ed its parent due to use of \"Uops\" CountDomain",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents 128-bit vector Integ=
er ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction t=
he CPU has retired",
> -        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_128@ + cpu_core@INT=
_VEC_RETIRED.VNNI_128@) / (tma_retiring * tma_info_thread_slots)",
> +        "MetricExpr": "(INT_VEC_RETIRED.ADD_128 + INT_VEC_RETIRED.VNNI_1=
28) / (tma_retiring * tma_info_thread_slots)",
>          "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_grou=
p;tma_int_operations_group;tma_issue2P",
>          "MetricName": "tma_int_vector_128b",
> -        "MetricThreshold": "tma_int_vector_128b > 0.1 & (tma_int_operati=
ons > 0.1 & tma_light_operations > 0.6)",
> -        "PublicDescription": "This metric represents 128-bit vector Inte=
ger ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction =
the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_=
vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_256b, t=
ma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
> +        "MetricThreshold": "tma_int_vector_128b > 0.1 & tma_int_operatio=
ns > 0.1 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents 128-bit vector Inte=
ger ADD/SUB/SAD or VNNI (Vector Neural Network Instructions) uops fraction =
the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_=
vector_128b, tma_fp_vector_256b, tma_int_vector_256b, tma_port_0, tma_port_=
1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents 256-bit vector Integ=
er ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fracti=
on the CPU has retired",
> -        "MetricExpr": "(cpu_core@INT_VEC_RETIRED.ADD_256@ + cpu_core@INT=
_VEC_RETIRED.MUL_256@ + cpu_core@INT_VEC_RETIRED.VNNI_256@) / (tma_retiring=
 * tma_info_thread_slots)",
> +        "MetricExpr": "(INT_VEC_RETIRED.ADD_256 + INT_VEC_RETIRED.MUL_25=
6 + INT_VEC_RETIRED.VNNI_256) / (tma_retiring * tma_info_thread_slots)",
>          "MetricGroup": "Compute;IntVector;Pipeline;TopdownL4;tma_L4_grou=
p;tma_int_operations_group;tma_issue2P",
>          "MetricName": "tma_int_vector_256b",
> -        "MetricThreshold": "tma_int_vector_256b > 0.1 & (tma_int_operati=
ons > 0.1 & tma_light_operations > 0.6)",
> -        "PublicDescription": "This metric represents 256-bit vector Inte=
ger ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fract=
ion the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma=
_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128=
b, tma_port_0, tma_port_1, tma_port_5, tma_port_6, tma_ports_utilized_2",
> +        "MetricThreshold": "tma_int_vector_256b > 0.1 & tma_int_operatio=
ns > 0.1 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents 256-bit vector Inte=
ger ADD/SUB/SAD/MUL or VNNI (Vector Neural Network Instructions) uops fract=
ion the CPU has retired. Related metrics: tma_fp_scalar, tma_fp_vector, tma=
_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, tma_port_0, tma_p=
ort_1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Instruction TLB (ITLB) misses",
> -        "MetricExpr": "cpu_core@ICACHE_TAG.STALLS@ / tma_info_thread_clk=
s",
> +        "MetricExpr": "ICACHE_TAG.STALLS / tma_info_thread_clks",
>          "MetricGroup": "BigFootprint;BvBC;FetchLat;MemoryTLB;TopdownL3;t=
ma_L3_group;tma_fetch_latency_group",
>          "MetricName": "tma_itlb_misses",
> -        "MetricThreshold": "tma_itlb_misses > 0.05 & (tma_fetch_latency =
> 0.1 & tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRON=
TEND_RETIRED.STLB_MISS_PS;FRONTEND_RETIRED.ITLB_MISS_PS",
> +        "MetricThreshold": "tma_itlb_misses > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Instruction TLB (ITLB) misses. Sample with: FRON=
TEND_RETIRED.STLB_MISS, FRONTEND_RETIRED.ITLB_MISS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric estimates how often the CPU was=
 stalled without loads missing the L1 data cache",
> -        "MetricExpr": "max((cpu_core@EXE_ACTIVITY.BOUND_ON_LOADS@ - cpu_=
core@MEMORY_ACTIVITY.STALLS_L1D_MISS@) / tma_info_thread_clks, 0)",
> +        "BriefDescription": "This metric estimates how often the CPU was=
 stalled without loads missing the L1 Data (L1D) cache",
> +        "MetricExpr": "max((EXE_ACTIVITY.BOUND_ON_LOADS - MEMORY_ACTIVIT=
Y.STALLS_L1D_MISS) / tma_info_thread_clks, 0)",
>          "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_issueL1;tma_issueMC;tma_memory_bound_group",
>          "MetricName": "tma_l1_bound",
> -        "MetricThreshold": "tma_l1_bound > 0.1 & (tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled without loads missing the L1 data cache.  The L1 data cache typic=
ally has the shortest latency.  However; in certain cases like loads blocke=
d on older stores; a load might suffer due to high latency even though it i=
s being satisfied by the L1. Another example is loads who miss in the TLB. =
These cases are characterized by execution unit stalls; while some non-comp=
leted demand load lives in the machine without having that demand load miss=
ing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT_PS;MEM_LOAD_RETIRED.=
FB_HIT_PS. Related metrics: tma_clears_resteers, tma_machine_clears, tma_mi=
crocode_sequencer, tma_ms_switches, tma_ports_utilized_1",
> +        "MetricThreshold": "tma_l1_bound > 0.1 & tma_memory_bound > 0.2 =
& tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled without loads missing the L1 Data (L1D) cache.  The L1D cache typ=
ically has the shortest latency.  However; in certain cases like loads bloc=
ked on older stores; a load might suffer due to high latency even though it=
 is being satisfied by the L1D. Another example is loads who miss in the TL=
B. These cases are characterized by execution unit stalls; while some non-c=
ompleted demand load lives in the machine without having that demand load m=
issing the L1 cache. Sample with: MEM_LOAD_RETIRED.L1_HIT. Related metrics:=
 tma_clears_resteers, tma_machine_clears, tma_microcode_sequencer, tma_ms_s=
witches, tma_ports_utilized_1",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric roughly estimates fraction of c=
ycles with demand load accesses that hit the L1 cache",
> -        "MetricExpr": "min(2 * (cpu_core@MEM_INST_RETIRED.ALL_LOADS@ - c=
pu_core@MEM_LOAD_RETIRED.FB_HIT@ - cpu_core@MEM_LOAD_RETIRED.L1_MISS@) * 20=
 / 100, max(cpu_core@CYCLE_ACTIVITY.CYCLES_MEM_ANY@ - cpu_core@MEMORY_ACTIV=
ITY.CYCLES_L1D_MISS@, 0)) / tma_info_thread_clks",
> +        "BriefDescription": "This metric([SKL+] roughly; [LNL]) estimate=
s fraction of cycles with demand load accesses that hit the L1D cache",
> +        "MetricExpr": "min(2 * (MEM_INST_RETIRED.ALL_LOADS - MEM_LOAD_RE=
TIRED.FB_HIT - MEM_LOAD_RETIRED.L1_MISS) * 20 / 100, max(CYCLE_ACTIVITY.CYC=
LES_MEM_ANY - MEMORY_ACTIVITY.CYCLES_L1D_MISS, 0)) / tma_info_thread_clks",
>          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_l1_bou=
nd_group",
> -        "MetricName": "tma_l1_hit_latency",
> -        "MetricThreshold": "tma_l1_hit_latency > 0.1 & (tma_l1_bound > 0=
=2E1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates fraction of =
cycles with demand load accesses that hit the L1 cache. The short latency o=
f the L1 data cache may be exposed in pointer-chasing memory access pattern=
s as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
> +        "MetricName": "tma_l1_latency_dependency",
> +        "MetricThreshold": "tma_l1_latency_dependency > 0.1 & tma_l1_bou=
nd > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric([SKL+] roughly; [LNL]) estimat=
es fraction of cycles with demand load accesses that hit the L1D cache. The=
 short latency of the L1D cache may be exposed in pointer-chasing memory ac=
cess patterns as an example. Sample with: MEM_LOAD_RETIRED.L1_HIT",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates how often the CPU was=
 stalled due to L2 cache accesses by loads",
> -        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L1D_MISS@ - cpu_=
core@MEMORY_ACTIVITY.STALLS_L2_MISS@) / tma_info_thread_clks",
> +        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L1D_MISS - MEMORY_ACTIVIT=
Y.STALLS_L2_MISS) / tma_info_thread_clks",
>          "MetricGroup": "BvML;CacheHits;MemoryBound;TmaL3mem;TopdownL3;tm=
a_L3_group;tma_memory_bound_group",
>          "MetricName": "tma_l2_bound",
> -        "MetricThreshold": "tma_l2_bound > 0.05 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L=
1 misses/L2 hits) can improve the latency and increase performance. Sample =
with: MEM_LOAD_RETIRED.L2_HIT_PS",
> +        "MetricThreshold": "tma_l2_bound > 0.05 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to L2 cache accesses by loads.  Avoiding cache misses (i.e. L=
1 misses/L2 hits) can improve the latency and increase performance. Sample =
with: MEM_LOAD_RETIRED.L2_HIT",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents fraction of cycles w=
ith demand load accesses that hit the L2 cache under unloaded scenarios (po=
ssibly L2 latency limited)",
> +        "MetricExpr": "3 * tma_info_system_core_frequency * MEM_LOAD_RET=
IRED.L2_HIT * (1 + MEM_LOAD_RETIRED.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2) =
/ tma_info_thread_clks",
> +        "MetricGroup": "MemoryLat;TopdownL4;tma_L4_group;tma_l2_bound_gr=
oup",
> +        "MetricName": "tma_l2_hit_latency",
> +        "MetricThreshold": "tma_l2_hit_latency > 0.05 & tma_l2_bound > 0=
=2E05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
with demand load accesses that hit the L2 cache under unloaded scenarios (p=
ossibly L2 latency limited).  Avoiding L1 cache misses (i.e. L1 misses/L2 h=
its) will improve the latency. Sample with: MEM_LOAD_RETIRED.L2_HIT",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates how often the CPU was=
 stalled due to loads accesses to L3 cache or contended with a sibling Core=
",
> -        "MetricExpr": "(cpu_core@MEMORY_ACTIVITY.STALLS_L2_MISS@ - cpu_c=
ore@MEMORY_ACTIVITY.STALLS_L3_MISS@) / tma_info_thread_clks",
> +        "MetricExpr": "(MEMORY_ACTIVITY.STALLS_L2_MISS - MEMORY_ACTIVITY=
=2ESTALLS_L3_MISS) / tma_info_thread_clks",
>          "MetricGroup": "CacheHits;MemoryBound;TmaL3mem;TopdownL3;tma_L3_=
group;tma_memory_bound_group",
>          "MetricName": "tma_l3_bound",
> -        "MetricThreshold": "tma_l3_bound > 0.05 & (tma_memory_bound > 0.=
2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to loads accesses to L3 cache or contended with a sibling Cor=
e.  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency =
and increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS",
> +        "MetricThreshold": "tma_l3_bound > 0.05 & tma_memory_bound > 0.2=
 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often the CPU wa=
s stalled due to loads accesses to L3 cache or contended with a sibling Cor=
e.  Avoiding cache misses (i.e. L2 misses/L3 hits) can improve the latency =
and increase performance. Sample with: MEM_LOAD_RETIRED.L3_HIT",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wi=
th demand load accesses that hit the L3 cache under unloaded scenarios (pos=
sibly L3 latency limited)",
> -        "MetricExpr": "9 * tma_info_system_core_frequency * (cpu_core@ME=
M_LOAD_RETIRED.L3_HIT@ * (1 + cpu_core@MEM_LOAD_RETIRED.FB_HIT@ / cpu_core@=
MEM_LOAD_RETIRED.L1_MISS@ / 2)) / tma_info_thread_clks",
> +        "MetricExpr": "(12 * tma_info_system_core_frequency - 3 * tma_in=
fo_system_core_frequency) * (MEM_LOAD_RETIRED.L3_HIT * (1 + MEM_LOAD_RETIRE=
D.FB_HIT / MEM_LOAD_RETIRED.L1_MISS / 2)) / tma_info_thread_clks",
>          "MetricGroup": "BvML;MemoryLat;TopdownL4;tma_L4_group;tma_issueL=
at;tma_l3_bound_group",
>          "MetricName": "tma_l3_hit_latency",
> -        "MetricThreshold": "tma_l3_hit_latency > 0.1 & (tma_l3_bound > 0=
=2E05 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT_PS. Related metrics: =
tma_info_bottleneck_cache_memory_latency, tma_mem_latency",
> +        "MetricThreshold": "tma_l3_hit_latency > 0.1 & tma_l3_bound > 0.=
05 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
ith demand load accesses that hit the L3 cache under unloaded scenarios (po=
ssibly L3 latency limited).  Avoiding private cache misses (i.e. L2 misses/=
L3 hits) will improve the latency; reduce contention with sibling physical =
cores and increase performance.  Note the value of this node may overlap wi=
th its siblings. Sample with: MEM_LOAD_RETIRED.L3_HIT. Related metrics: tma=
_bottleneck_cache_memory_latency, tma_branch_resteers, tma_mem_latency, tma=
_store_latency",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles C=
PU was stalled due to Length Changing Prefixes (LCPs)",
> -        "MetricExpr": "cpu_core@DECODE.LCP@ / tma_info_thread_clks",
> +        "MetricExpr": "DECODE.LCP / tma_info_thread_clks",
>          "MetricGroup": "FetchLat;TopdownL3;tma_L3_group;tma_fetch_latenc=
y_group;tma_issueFB",
>          "MetricName": "tma_lcp",
> -        "MetricThreshold": "tma_lcp > 0.05 & (tma_fetch_latency > 0.1 & =
tma_frontend_bound > 0.15)",
> -        "PublicDescription": "This metric represents fraction of cycles =
CPU was stalled due to Length Changing Prefixes (LCPs). Using proper compil=
er flags or Intel Compiler by default will certainly avoid this. #Link: Opt=
imization Guide about LCP BKMs. Related metrics: tma_dsb_switches, tma_fetc=
h_bandwidth, tma_info_botlnk_l2_dsb_bandwidth, tma_info_botlnk_l2_dsb_misse=
s, tma_info_frontend_dsb_coverage, tma_info_inst_mix_iptb",
> +        "MetricThreshold": "tma_lcp > 0.05 & tma_fetch_latency > 0.1 & t=
ma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU was stalled due to Length Changing Prefixes (LCPs). Using proper compil=
er flags or Intel Compiler by default will certainly avoid this. Related me=
trics: tma_dsb_switches, tma_fetch_bandwidth, tma_info_botlnk_l2_dsb_bandwi=
dth, tma_info_botlnk_l2_dsb_misses, tma_info_frontend_dsb_coverage, tma_inf=
o_inst_mix_iptb",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring light-weight operations -- instructions that requi=
re no more than one uop (micro-operation)",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring light-weight operations , instructions that requir=
e no more than one uop (micro-operation)",
>          "MetricExpr": "max(0, tma_retiring - tma_heavy_operations)",
>          "MetricGroup": "Retire;TmaL2;TopdownL2;tma_L2_group;tma_retiring=
_group",
>          "MetricName": "tma_light_operations",
>          "MetricThreshold": "tma_light_operations > 0.6",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring light-weight operations -- instructions that requ=
ire no more than one uop (micro-operation). This correlates with total numb=
er of instructions used by the program. A uops-per-instruction (see UopPI m=
etric) ratio of 1 or less should be expected for decently optimized code ru=
nning on Intel Core/Xeon products. While this often indicates efficient X86=
 instructions were executed; high value does not necessarily mean better pe=
rformance cannot be achieved. ([ICL+] Note this may undercount due to appro=
ximation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_D=
IST",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring light-weight operations , instructions that requi=
re no more than one uop (micro-operation). This correlates with total numbe=
r of instructions used by the program. A uops-per-instruction (see UopPI me=
tric) ratio of 1 or less should be expected for decently optimized code run=
ning on Intel Core/Xeon products. While this often indicates efficient X86 =
instructions were executed; high value does not necessarily mean better per=
formance cannot be achieved. ([ICL+] Note this may undercount due to approx=
imation using indirect events; [ADL+] .). Sample with: INST_RETIRED.PREC_DI=
ST",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port for Load operations",
> -        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_2_3_10@ / (3 * tma_=
info_core_core_clks)",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_2_3_10 / (3 * tma_info_core_=
core_clks)",
>          "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_gro=
up",
>          "MetricName": "tma_load_op_utilization",
>          "MetricThreshold": "tma_load_op_utilization > 0.6",
> @@ -2107,36 +4149,63 @@
>          "MetricExpr": "tma_dtlb_load - tma_load_stlb_miss",
>          "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_g=
roup",
>          "MetricName": "tma_load_stlb_hit",
> -        "MetricThreshold": "tma_load_stlb_hit > 0.05 & (tma_dtlb_load > =
0.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0=
=2E2)))",
> +        "MetricThreshold": "tma_load_stlb_hit > 0.05 & tma_dtlb_load > 0=
=2E1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.=
2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates the fraction of cycle=
s where the Second-level TLB (STLB) was missed by load accesses, performing=
 a hardware page walk",
> -        "MetricExpr": "cpu_core@DTLB_LOAD_MISSES.WALK_ACTIVE@ / tma_info=
_thread_clks",
> +        "MetricExpr": "DTLB_LOAD_MISSES.WALK_ACTIVE / tma_info_thread_cl=
ks",
>          "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_load_g=
roup",
>          "MetricName": "tma_load_stlb_miss",
> -        "MetricThreshold": "tma_load_stlb_miss > 0.05 & (tma_dtlb_load >=
 0.1 & (tma_l1_bound > 0.1 & (tma_memory_bound > 0.2 & tma_backend_bound > =
0.2)))",
> +        "MetricThreshold": "tma_load_stlb_miss > 0.05 & tma_dtlb_load > =
0.1 & tma_l1_bound > 0.1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2=
",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 1 GB pages f=
or data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_1G / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_m=
iss_group",
> +        "MetricName": "tma_load_stlb_miss_1g",
> +        "MetricThreshold": "tma_load_stlb_miss_1g > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COM=
PLETED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_m=
iss_group",
> +        "MetricName": "tma_load_stlb_miss_2m",
> +        "MetricThreshold": "tma_load_stlb_miss_2m > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or data load accesses",
> +        "MetricExpr": "tma_load_stlb_miss * DTLB_LOAD_MISSES.WALK_COMPLE=
TED_4K / (DTLB_LOAD_MISSES.WALK_COMPLETED_4K + DTLB_LOAD_MISSES.WALK_COMPLE=
TED_2M_4M + DTLB_LOAD_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_load_stlb_m=
iss_group",
> +        "MetricName": "tma_load_stlb_miss_4k",
> +        "MetricThreshold": "tma_load_stlb_miss_4k > 0.05 & tma_load_stlb=
_miss > 0.05 & tma_dtlb_load > 0.1 & tma_l1_bound > 0.1 & tma_memory_bound =
> 0.2 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU spent handling cache misses due to lock operations",
> -        "MetricExpr": "(16 * max(0, cpu_core@MEM_INST_RETIRED.LOCK_LOADS=
@ - cpu_core@L2_RQSTS.ALL_RFO@) + cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / c=
pu_core@MEM_INST_RETIRED.ALL_STORES@ * (10 * cpu_core@L2_RQSTS.RFO_HIT@ + m=
in(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_REQUESTS_OUTSTANDING=
=2ECYCLES_WITH_DEMAND_RFO@))) / tma_info_thread_clks",
> -        "MetricGroup": "Offcore;TopdownL4;tma_L4_group;tma_issueRFO;tma_=
l1_bound_group",
> +        "MetricExpr": "(16 * max(0, MEM_INST_RETIRED.LOCK_LOADS - L2_RQS=
TS.ALL_RFO) + MEM_INST_RETIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES * (=
10 * L2_RQSTS.RFO_HIT + min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUTST=
ANDING.CYCLES_WITH_DEMAND_RFO))) / tma_info_thread_clks",
> +        "MetricGroup": "LockCont;Offcore;TopdownL4;tma_L4_group;tma_issu=
eRFO;tma_l1_bound_group",
>          "MetricName": "tma_lock_latency",
> -        "MetricThreshold": "tma_lock_latency > 0.2 & (tma_l1_bound > 0.1=
 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_lock_latency > 0.2 & tma_l1_bound > 0.1 =
& tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
the CPU spent handling cache misses due to lock operations. Due to the micr=
oarchitecture handling of locks; they are classified as L1_Bound regardless=
 of what memory source satisfied them. Sample with: MEM_INST_RETIRED.LOCK_L=
OADS. Related metrics: tma_store_latency",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to LSD (Loop Stream Detector) unit",
> -        "MetricExpr": "(cpu_core@LSD.CYCLES_ACTIVE@ - cpu_core@LSD.CYCLE=
S_OK@) / tma_info_core_core_clks / 2",
> +        "MetricExpr": "(LSD.CYCLES_ACTIVE - LSD.CYCLES_OK) / tma_info_co=
re_core_clks / 2",
>          "MetricGroup": "FetchBW;LSD;TopdownL3;tma_L3_group;tma_fetch_ban=
dwidth_group",
>          "MetricName": "tma_lsd",
>          "MetricThreshold": "tma_lsd > 0.15 & tma_fetch_bandwidth > 0.2",
> -        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to LSD (Loop Stream Detector) unit=
=2E  LSD typically does well sustaining Uop supply. However; in some rare c=
ases; optimal uop-delivery could not be reached for small loops whose size =
(in terms of number of uops) does not suit well the LSD structure.",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles in which CPU was likely limited due to LSD (Loop Stream Detector) unit=
=2E  LSD typically does well sustaining Uop supply. However; in some rare c=
ases; optimal uop-delivery could not be reached for small loops whose size =
(in terms of number of uops) does not suit well the LSD structure",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
> @@ -2147,54 +4216,54 @@
>          "MetricName": "tma_machine_clears",
>          "MetricThreshold": "tma_machine_clears > 0.1 & tma_bad_speculati=
on > 0.15",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Machine Clears.  These slots are either wasted by =
uops fetched prior to the clear; or stalls the out-of-order portion of the =
machine needs to recover its state after the clear. For example; this can h=
appen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Mod=
ifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics=
: tma_clears_resteers, tma_contested_accesses, tma_data_sharing, tma_false_=
sharing, tma_l1_bound, tma_microcode_sequencer, tma_ms_switches, tma_remote=
_cache",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU has wasted due to Machine Clears.  These slots are either wasted by =
uops fetched prior to the clear; or stalls the out-of-order portion of the =
machine needs to recover its state after the clear. For example; this can h=
appen due to memory ordering Nukes (e.g. Memory Disambiguation) or Self-Mod=
ifying-Code (SMC) nukes. Sample with: MACHINE_CLEARS.COUNT. Related metrics=
: tma_bottleneck_memory_synchronization, tma_clears_resteers, tma_contested=
_accesses, tma_data_sharing, tma_false_sharing, tma_l1_bound, tma_microcode=
_sequencer, tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wh=
ere the core's performance was likely hurt due to approaching bandwidth lim=
its of external memory - DRAM ([SPR-HBM] and/or HBM)",
> -        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@O=
FFCORE_REQUESTS_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D4@) / tma_info_thread_c=
lks",
> -        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_dram_bound_group;tma_issueBW",
> +        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, cpu@OFFCORE_REQUESTS=
_OUTSTANDING.ALL_DATA_RD\\,cmask\\=3D0x4@) / tma_info_thread_clks",
> +        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_dram_bound_group;tma_issueBW",
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
e counters for that). Related metrics: tma_fb_full, tma_info_bottleneck_cac=
he_memory_bandwidth, tma_info_system_dram_bw_use, tma_sq_full",
> +        "MetricThreshold": "tma_mem_bandwidth > 0.2 & tma_dram_bound > 0=
=2E1 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
here the core's performance was likely hurt due to approaching bandwidth li=
mits of external memory - DRAM ([SPR-HBM] and/or HBM).  The underlying heur=
istic assumes that a similar off-core traffic is generated by all IA cores.=
 This metric does not aggregate non-data-read requests by this logical proc=
essor; requests from other IA Logical Processors/Physical Cores/sockets; or=
 other non-IA devices like GPU; hence the maximum external memory bandwidth=
 limits may or may not be approached when this metric is flagged (see Uncor=
e counters for that). Related metrics: tma_bottleneck_cache_memory_bandwidt=
h, tma_fb_full, tma_info_system_dram_bw_use, tma_sq_full",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles wh=
ere the performance was likely hurt due to latency from external memory - D=
RAM ([SPR-HBM] and/or HBM)",
> -        "MetricExpr": "min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@O=
FFCORE_REQUESTS_OUTSTANDING.CYCLES_WITH_DATA_RD@) / tma_info_thread_clks - =
tma_mem_bandwidth",
> +        "MetricExpr": "min(CPU_CLK_UNHALTED.THREAD, OFFCORE_REQUESTS_OUT=
STANDING.CYCLES_WITH_DATA_RD) / tma_info_thread_clks - tma_mem_bandwidth",
>          "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tm=
a_dram_bound_group;tma_issueLat",
>          "MetricName": "tma_mem_latency",
> -        "MetricThreshold": "tma_mem_latency > 0.1 & (tma_dram_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles w=
here the performance was likely hurt due to latency from external memory - =
DRAM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from =
other Logical Processors/Physical Cores/sockets (see Uncore counters for th=
at). Related metrics: tma_info_bottleneck_cache_memory_latency, tma_l3_hit_=
latency",
> +        "MetricThreshold": "tma_mem_latency > 0.1 & tma_dram_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles w=
here the performance was likely hurt due to latency from external memory - =
DRAM ([SPR-HBM] and/or HBM).  This metric does not aggregate requests from =
other Logical Processors/Physical Cores/sockets (see Uncore counters for th=
at). Related metrics: tma_bottleneck_cache_memory_latency, tma_l3_hit_laten=
cy",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e Memory subsystem within the Backend was a bottleneck",
> -        "MetricExpr": "cpu_core@topdown\\-mem\\-bound@ / (cpu_core@topdo=
wn\\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-reti=
ring@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound + t=
opdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slot=
s",
>          "MetricGroup": "Backend;TmaL2;TopdownL2;tma_L2_group;tma_backend=
_bound_group",
>          "MetricName": "tma_memory_bound",
>          "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound >=
 0.2",
>          "MetricgroupNoGroup": "TopdownL2",
> -        "PublicDescription": "This metric represents fraction of slots t=
he Memory subsystem within the Backend was a bottleneck.  Memory Bound esti=
mates fraction of slots where pipeline is likely stalled due to demand load=
 or store instructions. This accounts mainly for (1) non-completed in-fligh=
t memory demand loads which coincides with execution units starvation; in a=
ddition to (2) cases where stores could impose backpressure on the pipeline=
 when many of them get buffered at the same time (less common out of the tw=
o).",
> +        "PublicDescription": "This metric represents fraction of slots t=
he Memory subsystem within the Backend was a bottleneck.  Memory Bound esti=
mates fraction of slots where pipeline is likely stalled due to demand load=
 or store instructions. This accounts mainly for (1) non-completed in-fligh=
t memory demand loads which coincides with execution units starvation; in a=
ddition to (2) cases where stores could impose backpressure on the pipeline=
 when many of them get buffered at the same time (less common out of the tw=
o)",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to LFENCE Instructions.",
> +        "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to LFENCE Instructions",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> -        "MetricExpr": "13 * cpu_core@MISC2_RETIRED.LFENCE@ / tma_info_th=
read_clks",
> +        "MetricExpr": "13 * MISC2_RETIRED.LFENCE / tma_info_thread_clks",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation=
_group",
>          "MetricName": "tma_memory_fence",
> -        "MetricThreshold": "tma_memory_fence > 0.05 & (tma_serializing_o=
peration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_memory_fence > 0.05 & tma_serializing_op=
eration > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring memory operations -- uops for memory load or store=
 accesses.",
> -        "MetricExpr": "tma_light_operations * cpu_core@MEM_UOP_RETIRED.A=
NY@ / (tma_retiring * tma_info_thread_slots)",
> +        "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring memory operations , uops for memory load or store =
accesses",
> +        "MetricExpr": "tma_light_operations * MEM_UOP_RETIRED.ANY / (tma=
_retiring * tma_info_thread_slots)",
>          "MetricGroup": "Pipeline;TopdownL3;tma_L3_group;tma_light_operat=
ions_group",
>          "MetricName": "tma_memory_operations",
>          "MetricThreshold": "tma_memory_operations > 0.1 & tma_light_oper=
ations > 0.6",
> @@ -2203,27 +4272,27 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots th=
e CPU was retiring uops fetched by the Microcode Sequencer (MS) unit",
> -        "MetricExpr": "cpu_core@UOPS_RETIRED.MS@ / tma_info_thread_slots=
",
> +        "MetricExpr": "UOPS_RETIRED.MS / tma_info_thread_slots",
>          "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_heavy_operat=
ions_group;tma_issueMC;tma_issueMS",
>          "MetricName": "tma_microcode_sequencer",
>          "MetricThreshold": "tma_microcode_sequencer > 0.05 & tma_heavy_o=
perations > 0.1",
> -        "PublicDescription": "This metric represents fraction of slots t=
he CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The=
 MS is used for CISC instructions not supported by the default decoders (li=
ke repeat move strings; or CPUID); or by microcode assists used to address =
some operation modes (like in Floating Point assists). These cases can ofte=
n be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_clears_res=
teers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, tma_machine_cl=
ears, tma_ms_switches",
> +        "PublicDescription": "This metric represents fraction of slots t=
he CPU was retiring uops fetched by the Microcode Sequencer (MS) unit.  The=
 MS is used for CISC instructions not supported by the default decoders (li=
ke repeat move strings; or CPUID); or by microcode assists used to address =
some operation modes (like in Floating Point assists). These cases can ofte=
n be avoided. Sample with: UOPS_RETIRED.MS. Related metrics: tma_bottleneck=
_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_machine_clears,=
 tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to Branch Resteers as a result of Branch Mispredicti=
on at execution stage",
> -        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * cp=
u_core@INT_MISC.CLEAR_RESTEER_CYCLES@ / tma_info_thread_clks",
> +        "MetricExpr": "tma_branch_mispredicts / tma_bad_speculation * IN=
T_MISC.CLEAR_RESTEER_CYCLES / tma_info_thread_clks",
>          "MetricGroup": "BadSpec;BrMispredicts;BvMP;TopdownL4;tma_L4_grou=
p;tma_branch_resteers_group;tma_issueBM",
>          "MetricName": "tma_mispredicts_resteers",
> -        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & (tma_branc=
h_resteers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
> -        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Branch Mispredict=
ion at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related=
 metrics: tma_branch_mispredicts, tma_info_bad_spec_branch_misprediction_co=
st, tma_info_bottleneck_mispredictions",
> +        "MetricThreshold": "tma_mispredicts_resteers > 0.05 & tma_branch=
_resteers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to Branch Resteers as a result of Branch Mispredict=
ion at execution stage. Sample with: INT_MISC.CLEAR_RESTEER_CYCLES. Related=
 metrics: tma_bottleneck_mispredictions, tma_branch_mispredicts, tma_info_b=
ad_spec_branch_misprediction_cost",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to the MITE pipeline (the legacy de=
code pipeline)",
> -        "MetricExpr": "(cpu_core@IDQ.MITE_CYCLES_ANY@ - cpu_core@IDQ.MIT=
E_CYCLES_OK@) / tma_info_core_core_clks / 2",
> +        "MetricExpr": "(IDQ.MITE_CYCLES_ANY - IDQ.MITE_CYCLES_OK) / tma_=
info_core_core_clks / 2",
>          "MetricGroup": "DSBmiss;FetchBW;TopdownL3;tma_L3_group;tma_fetch=
_bandwidth_group",
>          "MetricName": "tma_mite",
>          "MetricThreshold": "tma_mite > 0.1 & tma_fetch_bandwidth > 0.2",
> @@ -2232,41 +4301,50 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric estimates penalty in terms of p=
ercentage of([SKL+] injected blend uops out of all Uops Issued -- the Count=
 Domain; [ADL+] cycles)",
> -        "MetricExpr": "160 * cpu_core@ASSISTS.SSE_AVX_MIX@ / tma_info_th=
read_clks",
> +        "BriefDescription": "This metric estimates penalty in terms of p=
ercentage of([SKL+] injected blend uops out of all Uops Issued , the Count =
Domain; [ADL+] cycles)",
> +        "MetricExpr": "160 * ASSISTS.SSE_AVX_MIX / tma_info_thread_clks",
>          "MetricGroup": "TopdownL5;tma_L5_group;tma_issueMV;tma_ports_uti=
lized_0_group",
>          "MetricName": "tma_mixing_vectors",
>          "MetricThreshold": "tma_mixing_vectors > 0.05",
> -        "PublicDescription": "This metric estimates penalty in terms of =
percentage of([SKL+] injected blend uops out of all Uops Issued -- the Coun=
t Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investi=
gating. Read more in Appendix B1 of the Optimizations Guide for this topic.=
 Related metrics: tma_ms_switches",
> +        "PublicDescription": "This metric estimates penalty in terms of =
percentage of([SKL+] injected blend uops out of all Uops Issued , the Count=
 Domain; [ADL+] cycles). Usually a Mixing_Vectors over 5% is worth investig=
ating. Read more in Appendix B1 of the Optimizations Guide for this topic. =
Related metrics: tma_ms_switches",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric represents Core fraction of cyc=
les in which CPU was likely limited due to the Microcode Sequencer (MS) uni=
t - see Microcode_Sequencer node for details",
> +        "MetricExpr": "max(IDQ.MS_CYCLES_ANY, cpu@UOPS_RETIRED.MS\\,cmas=
k\\=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY)) / tma_info_core_core_c=
lks / 2",
> +        "MetricGroup": "MicroSeq;TopdownL3;tma_L3_group;tma_fetch_bandwi=
dth_group",
> +        "MetricName": "tma_ms",
> +        "MetricThreshold": "tma_ms > 0.05 & tma_fetch_bandwidth > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates the fraction of cycle=
s when the CPU was stalled due to switches of uop delivery to the Microcode=
 Sequencer (MS)",
> -        "MetricExpr": "3 * cpu_core@UOPS_RETIRED.MS\\,cmask\\=3D1\\,edge=
@ / (cpu_core@UOPS_RETIRED.SLOTS@ / cpu_core@UOPS_ISSUED.ANY@) / tma_info_t=
hread_clks",
> +        "MetricExpr": "3 * cpu@UOPS_RETIRED.MS\\,cmask\\=3D0x1\\,edge\\=
=3D0x1@ / (UOPS_RETIRED.SLOTS / UOPS_ISSUED.ANY) / tma_info_thread_clks",
>          "MetricGroup": "FetchLat;MicroSeq;TopdownL3;tma_L3_group;tma_fet=
ch_latency_group;tma_issueMC;tma_issueMS;tma_issueMV;tma_issueSO",
>          "MetricName": "tma_ms_switches",
> -        "MetricThreshold": "tma_ms_switches > 0.05 & (tma_fetch_latency =
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
g with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: =
tma_clears_resteers, tma_info_bottleneck_irregular_overhead, tma_l1_bound, =
tma_machine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serial=
izing_operation",
> +        "MetricThreshold": "tma_ms_switches > 0.05 & tma_fetch_latency >=
 0.1 & tma_frontend_bound > 0.15",
> +        "PublicDescription": "This metric estimates the fraction of cycl=
es when the CPU was stalled due to switches of uop delivery to the Microcod=
e Sequencer (MS). Commonly used instructions are optimized for delivery by =
the DSB (decoded i-cache) or MITE (legacy instruction decode) pipelines. Ce=
rtain operations cannot be handled natively by the execution pipeline; and =
must be performed by microcode (small programs injected into the execution =
stream). Switching to the MS too often can negatively impact performance. T=
he MS is designated to deliver long uop flows required by CISC instructions=
 like CPUID; or uncommon conditions like Floating Point Assists when dealin=
g with Denormals. Sample with: FRONTEND_RETIRED.MS_FLOWS. Related metrics: =
tma_bottleneck_irregular_overhead, tma_clears_resteers, tma_l1_bound, tma_m=
achine_clears, tma_microcode_sequencer, tma_mixing_vectors, tma_serializing=
_operation",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring branch instructions that were not fused",
> -        "MetricExpr": "tma_light_operations * (cpu_core@BR_INST_RETIRED.=
ALL_BRANCHES@ - cpu_core@INST_RETIRED.MACRO_FUSED@) / (tma_retiring * tma_i=
nfo_thread_slots)",
> +        "MetricExpr": "tma_light_operations * (BR_INST_RETIRED.ALL_BRANC=
HES - INST_RETIRED.MACRO_FUSED) / (tma_retiring * tma_info_thread_slots)",
>          "MetricGroup": "Branches;BvBO;Pipeline;TopdownL3;tma_L3_group;tm=
a_light_operations_group",
>          "MetricName": "tma_non_fused_branches",
>          "MetricThreshold": "tma_non_fused_branches > 0.1 & tma_light_ope=
rations > 0.6",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring branch instructions that were not fused. Non-cond=
itional branches like direct JMP or CALL would count here. Can be used to e=
xamine fusible conditional jumps that were not fused.",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring branch instructions that were not fused. Non-cond=
itional branches like direct JMP or CALL would count here. Can be used to e=
xamine fusible conditional jumps that were not fused",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring NOP (no op) instructions",
> -        "MetricExpr": "tma_light_operations * cpu_core@INST_RETIRED.NOP@=
 / (tma_retiring * tma_info_thread_slots)",
> +        "MetricExpr": "tma_light_operations * INST_RETIRED.NOP / (tma_re=
tiring * tma_info_thread_slots)",
>          "MetricGroup": "BvBO;Pipeline;TopdownL4;tma_L4_group;tma_other_l=
ight_ops_group",
>          "MetricName": "tma_nop_instructions",
> -        "MetricThreshold": "tma_nop_instructions > 0.1 & (tma_other_ligh=
t_ops > 0.3 & tma_light_operations > 0.6)",
> +        "MetricThreshold": "tma_nop_instructions > 0.1 & tma_other_light=
_ops > 0.3 & tma_light_operations > 0.6",
>          "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring NOP (no op) instructions. Compilers often use NOP=
s for certain address alignments - e.g. start address of a function or loop=
 body. Sample with: INST_RETIRED.NOP",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2282,89 +4360,89 @@
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric estimates fraction of slots the=
 CPU was stalled due to other cases of misprediction (non-retired x86 branc=
hes or other types).",
> -        "MetricExpr": "max(tma_branch_mispredicts * (1 - cpu_core@BR_MIS=
P_RETIRED.ALL_BRANCHES@ / (cpu_core@INT_MISC.CLEARS_COUNT@ - cpu_core@MACHI=
NE_CLEARS.COUNT@)), 0.0001)",
> +        "BriefDescription": "This metric estimates fraction of slots the=
 CPU was stalled due to other cases of misprediction (non-retired x86 branc=
hes or other types)",
> +        "MetricExpr": "max(tma_branch_mispredicts * (1 - BR_MISP_RETIRED=
=2EALL_BRANCHES / (INT_MISC.CLEARS_COUNT - MACHINE_CLEARS.COUNT)), 0.0001)",
>          "MetricGroup": "BrMispredicts;BvIO;TopdownL3;tma_L3_group;tma_br=
anch_mispredicts_group",
>          "MetricName": "tma_other_mispredicts",
> -        "MetricThreshold": "tma_other_mispredicts > 0.05 & (tma_branch_m=
ispredicts > 0.1 & tma_bad_speculation > 0.15)",
> +        "MetricThreshold": "tma_other_mispredicts > 0.05 & tma_branch_mi=
spredicts > 0.1 & tma_bad_speculation > 0.15",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
> -        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Nukes (Machine Clears) not related to memory orderi=
ng.",
> -        "MetricExpr": "max(tma_machine_clears * (1 - cpu_core@MACHINE_CL=
EARS.MEMORY_ORDERING@ / cpu_core@MACHINE_CLEARS.COUNT@), 0.0001)",
> +        "BriefDescription": "This metric represents fraction of slots th=
e CPU has wasted due to Nukes (Machine Clears) not related to memory orderi=
ng",
> +        "MetricExpr": "max(tma_machine_clears * (1 - MACHINE_CLEARS.MEMO=
RY_ORDERING / MACHINE_CLEARS.COUNT), 0.0001)",
>          "MetricGroup": "BvIO;Machine_Clears;TopdownL3;tma_L3_group;tma_m=
achine_clears_group",
>          "MetricName": "tma_other_nukes",
> -        "MetricThreshold": "tma_other_nukes > 0.05 & (tma_machine_clears=
 > 0.1 & tma_bad_speculation > 0.15)",
> +        "MetricThreshold": "tma_other_nukes > 0.05 & tma_machine_clears =
> 0.1 & tma_bad_speculation > 0.15",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates fraction of s=
lots the CPU retired uops as a result of handing Page Faults",
> -        "MetricExpr": "99 * cpu_core@ASSISTS.PAGE_FAULT@ / tma_info_thre=
ad_slots",
> +        "MetricExpr": "99 * ASSISTS.PAGE_FAULT / tma_info_thread_slots",
>          "MetricGroup": "TopdownL5;tma_L5_group;tma_assists_group",
>          "MetricName": "tma_page_faults",
>          "MetricThreshold": "tma_page_faults > 0.05",
> -        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Page Faults. A Page Fault=
 may apply on first application access to a memory page. Note operating sys=
tem handling of page faults accounts for the majority of its cost.",
> +        "PublicDescription": "This metric roughly estimates fraction of =
slots the CPU retired uops as a result of handing Page Faults. A Page Fault=
 may apply on first application access to a memory page. Note operating sys=
tem handling of page faults accounts for the majority of its cost",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2nd=
 branch)",
> -        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_0@ / tma_info_core_=
core_clks",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_0 / tma_info_core_core_clks",
>          "MetricGroup": "Compute;TopdownL6;tma_L6_group;tma_alu_op_utiliz=
ation_group;tma_issue2P",
>          "MetricName": "tma_port_0",
>          "MetricThreshold": "tma_port_0 > 0.6",
> -        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2n=
d branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_sca=
lar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_5=
12b, tma_int_vector_128b, tma_int_vector_256b, tma_port_1, tma_port_5, tma_=
port_6, tma_ports_utilized_2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 0 ([SNB+] ALU; [HSW+] ALU and 2n=
d branch). Sample with: UOPS_DISPATCHED.PORT_0. Related metrics: tma_fp_sca=
lar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_=
128b, tma_int_vector_256b, tma_port_1, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 1 (ALU)",
> -        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_1@ / tma_info_core_=
core_clks",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_1 / tma_info_core_core_clks",
>          "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_gr=
oup;tma_issue2P",
>          "MetricName": "tma_port_1",
>          "MetricThreshold": "tma_port_1 > 0.6",
> -        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPA=
TCHED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_=
128b, tma_fp_vector_256b, tma_fp_vector_512b, tma_int_vector_128b, tma_int_=
vector_256b, tma_port_0, tma_port_5, tma_port_6, tma_ports_utilized_2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 1 (ALU). Sample with: UOPS_DISPA=
TCHED.PORT_1. Related metrics: tma_fp_scalar, tma_fp_vector, tma_fp_vector_=
128b, tma_fp_vector_256b, tma_int_vector_128b, tma_int_vector_256b, tma_por=
t_0, tma_port_6, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and simp=
le ALU)",
> -        "MetricExpr": "cpu_core@UOPS_DISPATCHED.PORT_6@ / tma_info_core_=
core_clks",
> +        "MetricExpr": "UOPS_DISPATCHED.PORT_6 / tma_info_core_core_clks",
>          "MetricGroup": "TopdownL6;tma_L6_group;tma_alu_op_utilization_gr=
oup;tma_issue2P",
>          "MetricName": "tma_port_6",
>          "MetricThreshold": "tma_port_6 > 0.6",
> -        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and sim=
ple ALU). Sample with: UOPS_DISPATCHED.PORT_6. Related metrics: tma_fp_scal=
ar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_51=
2b, tma_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_p=
ort_5, tma_ports_utilized_2",
> +        "PublicDescription": "This metric represents Core fraction of cy=
cles CPU dispatched uops on execution port 6 ([HSW+] Primary Branch and sim=
ple ALU). Sample with: UOPS_DISPATCHED.PORT_1. Related metrics: tma_fp_scal=
ar, tma_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_1=
28b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_ports_utilized_2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles th=
e CPU performance was potentially limited due to Core computation issues (n=
on divider-related)",
> -        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (=
cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * cpu_core@EXE_ACTIVITY.=
2_PORTS_UTIL\\,umask\\=3D0xc@)) / tma_info_thread_clks if cpu_core@ARITH.DI=
V_ACTIVE@ < cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core@EXE_ACTIVITY.B=
OUND_ON_LOADS@ else (cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ + tma_retiring * c=
pu_core@EXE_ACTIVITY.2_PORTS_UTIL\\,umask\\=3D0xc@) / tma_info_thread_clks)=
",
> +        "MetricExpr": "((tma_ports_utilized_0 * tma_info_thread_clks + (=
EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * EXE_ACTIVITY.2_3_PORTS_UTIL)) / =
tma_info_thread_clks if ARITH.DIV_ACTIVE < CYCLE_ACTIVITY.STALLS_TOTAL - EX=
E_ACTIVITY.BOUND_ON_LOADS else (EXE_ACTIVITY.1_PORTS_UTIL + tma_retiring * =
EXE_ACTIVITY.2_3_PORTS_UTIL) / tma_info_thread_clks)",
>          "MetricGroup": "PortsUtil;TopdownL3;tma_L3_group;tma_core_bound_=
group",
>          "MetricName": "tma_ports_utilization",
> -        "MetricThreshold": "tma_ports_utilization > 0.15 & (tma_core_bou=
nd > 0.1 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU performance was potentially limited due to Core computation issues (=
non divider-related).  Two distinct categories can be attributed into this =
metric: (1) heavy data-dependency among contiguous instructions would manif=
est in this metric - such cases are often referred to as low Instruction Le=
vel Parallelism (ILP). (2) Contention on some hardware execution unit other=
 than Divider. For example; when there are too many multiply operations.",
> +        "MetricThreshold": "tma_ports_utilization > 0.15 & tma_core_boun=
d > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU performance was potentially limited due to Core computation issues (=
non divider-related).  Two distinct categories can be attributed into this =
metric: (1) heavy data-dependency among contiguous instructions would manif=
est in this metric - such cases are often referred to as low Instruction Le=
vel Parallelism (ILP). (2) Contention on some hardware execution unit other=
 than Divider. For example; when there are too many multiply operations",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles C=
PU executed no uops on any execution port (Logical Processor cycles since I=
CL, Physical Core cycles otherwise)",
> -        "MetricExpr": "(cpu_core@EXE_ACTIVITY.EXE_BOUND_0_PORTS@ + max(c=
pu_core@RS.EMPTY\\,umask\\=3D1@ - cpu_core@RESOURCE_STALLS.SCOREBOARD@, 0))=
 / tma_info_thread_clks * (cpu_core@CYCLE_ACTIVITY.STALLS_TOTAL@ - cpu_core=
@EXE_ACTIVITY.BOUND_ON_LOADS@) / tma_info_thread_clks",
> +        "MetricExpr": "(EXE_ACTIVITY.EXE_BOUND_0_PORTS + max(RS.EMPTY_RE=
SOURCE - RESOURCE_STALLS.SCOREBOARD, 0)) / tma_info_thread_clks * (CYCLE_AC=
TIVITY.STALLS_TOTAL - EXE_ACTIVITY.BOUND_ON_LOADS) / tma_info_thread_clks",
>          "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_ports_utili=
zation_group",
>          "MetricName": "tma_ports_utilized_0",
> -        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & (tma_ports_util=
ization > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric represents fraction of cycles =
CPU executed no uops on any execution port (Logical Processor cycles since =
ICL, Physical Core cycles otherwise). Long-latency instructions like divide=
s may contribute to this metric.",
> +        "MetricThreshold": "tma_ports_utilized_0 > 0.2 & tma_ports_utili=
zation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU executed no uops on any execution port (Logical Processor cycles since =
ICL, Physical Core cycles otherwise). Long-latency instructions like divide=
s may contribute to this metric",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles w=
here the CPU executed total of 1 uop per cycle on all execution ports (Logi=
cal Processor cycles since ICL, Physical Core cycles otherwise)",
> -        "MetricExpr": "cpu_core@EXE_ACTIVITY.1_PORTS_UTIL@ / tma_info_th=
read_clks",
> +        "MetricExpr": "EXE_ACTIVITY.1_PORTS_UTIL / tma_info_thread_clks",
>          "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issueL1;tma=
_ports_utilization_group",
>          "MetricName": "tma_ports_utilized_1",
> -        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & (tma_ports_util=
ization > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_ports_utilized_1 > 0.2 & tma_ports_utili=
zation > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
where the CPU executed total of 1 uop per cycle on all execution ports (Log=
ical Processor cycles since ICL, Physical Core cycles otherwise). This can =
be due to heavy data-dependency among software instructions; or over oversu=
bscribing a particular hardware resource. In some other cases with high 1_P=
ort_Utilized and L1_Bound; this metric can point to L1 data-cache latency b=
ottleneck that may not necessarily manifest with complete execution starvat=
ion (due to the short L1 latency e.g. walking a linked list) - looking at t=
he assembly can be helpful. Sample with: EXE_ACTIVITY.1_PORTS_UTIL. Related=
 metrics: tma_l1_bound",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2372,21 +4450,21 @@
>      {
>          "BriefDescription": "This metric represents fraction of cycles C=
PU executed total of 2 uops per cycle on all execution ports (Logical Proce=
ssor cycles since ICL, Physical Core cycles otherwise)",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> -        "MetricExpr": "cpu_core@EXE_ACTIVITY.2_PORTS_UTIL@ / tma_info_th=
read_clks",
> +        "MetricExpr": "EXE_ACTIVITY.2_PORTS_UTIL / tma_info_thread_clks",
>          "MetricGroup": "PortsUtil;TopdownL4;tma_L4_group;tma_issue2P;tma=
_ports_utilization_group",
>          "MetricName": "tma_ports_utilized_2",
> -        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & (tma_ports_uti=
lization > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric represents fraction of cycles =
CPU executed total of 2 uops per cycle on all execution ports (Logical Proc=
essor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorizatio=
n -most compilers feature auto-Vectorization options today- reduces pressur=
e on the execution ports as multiple elements are calculated with same uop.=
 Sample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tm=
a_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_fp_vector_512b, tm=
a_int_vector_128b, tma_int_vector_256b, tma_port_0, tma_port_1, tma_port_5,=
 tma_port_6",
> +        "MetricThreshold": "tma_ports_utilized_2 > 0.15 & tma_ports_util=
ization > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents fraction of cycles =
CPU executed total of 2 uops per cycle on all execution ports (Logical Proc=
essor cycles since ICL, Physical Core cycles otherwise).  Loop Vectorizatio=
n -most compilers feature auto-Vectorization options today- reduces pressur=
e on the execution ports as multiple elements are calculated with same uop.=
 Sample with: EXE_ACTIVITY.2_PORTS_UTIL. Related metrics: tma_fp_scalar, tm=
a_fp_vector, tma_fp_vector_128b, tma_fp_vector_256b, tma_int_vector_128b, t=
ma_int_vector_256b, tma_port_0, tma_port_1, tma_port_6",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles C=
PU executed total of 3 or more uops per cycle on all execution ports (Logic=
al Processor cycles since ICL, Physical Core cycles otherwise)",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> -        "MetricExpr": "cpu_core@UOPS_EXECUTED.CYCLES_GE_3@ / tma_info_th=
read_clks",
> +        "MetricExpr": "UOPS_EXECUTED.CYCLES_GE_3 / tma_info_thread_clks",
>          "MetricGroup": "BvCB;PortsUtil;TopdownL4;tma_L4_group;tma_ports_=
utilization_group",
>          "MetricName": "tma_ports_utilized_3m",
> -        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & (tma_ports_uti=
lization > 0.15 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_ports_utilized_3m > 0.4 & tma_ports_util=
ization > 0.15 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
CPU executed total of 3 or more uops per cycle on all execution ports (Logi=
cal Processor cycles since ICL, Physical Core cycles otherwise). Sample wit=
h: UOPS_EXECUTED.CYCLES_GE_3",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
> @@ -2394,7 +4472,7 @@
>      {
>          "BriefDescription": "This category represents fraction of slots =
utilized by useful work i.e. issued uops that eventually get retired",
>          "DefaultMetricgroupName": "TopdownL1",
> -        "MetricExpr": "cpu_core@topdown\\-retiring@ / (cpu_core@topdown\=
\-fe\\-bound@ + cpu_core@topdown\\-bad\\-spec@ + cpu_core@topdown\\-retirin=
g@ + cpu_core@topdown\\-be\\-bound@) + 0 * tma_info_thread_slots",
> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + topd=
own\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slots",
>          "MetricGroup": "BvUW;Default;TmaL1;TopdownL1;tma_L1_group",
>          "MetricName": "tma_retiring",
>          "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operations > =
0.1",
> @@ -2405,98 +4483,98 @@
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU issue-pipeline was stalled due to serializing operations",
> -        "MetricExpr": "cpu_core@RESOURCE_STALLS.SCOREBOARD@ / tma_info_t=
hread_clks + tma_c02_wait",
> +        "MetricExpr": "RESOURCE_STALLS.SCOREBOARD / tma_info_thread_clks=
 + tma_c02_wait",
>          "MetricGroup": "BvIO;PortsUtil;TopdownL3;tma_L3_group;tma_core_b=
ound_group;tma_issueSO",
>          "MetricName": "tma_serializing_operation",
> -        "MetricThreshold": "tma_serializing_operation > 0.1 & (tma_core_=
bound > 0.1 & tma_backend_bound > 0.2)",
> +        "MetricThreshold": "tma_serializing_operation > 0.1 & tma_core_b=
ound > 0.1 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
the CPU issue-pipeline was stalled due to serializing operations. Instructi=
ons like CPUID; WRMSR or LFENCE serialize the out-of-order execution which =
may limit performance. Sample with: RESOURCE_STALLS.SCOREBOARD. Related met=
rics: tma_ms_switches",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of slots wh=
ere the CPU was retiring Shuffle operations of 256-bit vector size (FP or I=
nteger)",
> -        "MetricExpr": "tma_light_operations * cpu_core@INT_VEC_RETIRED.S=
HUFFLES@ / (tma_retiring * tma_info_thread_slots)",
> +        "MetricExpr": "tma_light_operations * INT_VEC_RETIRED.SHUFFLES /=
 (tma_retiring * tma_info_thread_slots)",
>          "MetricGroup": "HPC;Pipeline;TopdownL4;tma_L4_group;tma_other_li=
ght_ops_group",
>          "MetricName": "tma_shuffles_256b",
> -        "MetricThreshold": "tma_shuffles_256b > 0.1 & (tma_other_light_o=
ps > 0.3 & tma_light_operations > 0.6)",
> -        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring Shuffle operations of 256-bit vector size (FP or =
Integer). Shuffles may incur slow cross \"vector lane\" data transfers.",
> +        "MetricThreshold": "tma_shuffles_256b > 0.1 & tma_other_light_op=
s > 0.3 & tma_light_operations > 0.6",
> +        "PublicDescription": "This metric represents fraction of slots w=
here the CPU was retiring Shuffle operations of 256-bit vector size (FP or =
Integer). Shuffles may incur slow cross \"vector lane\" data transfers",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to PAUSE Instructions",
>          "MetricConstraint": "NO_GROUP_EVENTS_NMI",
> -        "MetricExpr": "cpu_core@CPU_CLK_UNHALTED.PAUSE@ / tma_info_threa=
d_clks",
> +        "MetricExpr": "CPU_CLK_UNHALTED.PAUSE / tma_info_thread_clks",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_serializing_operation=
_group",
>          "MetricName": "tma_slow_pause",
> -        "MetricThreshold": "tma_slow_pause > 0.05 & (tma_serializing_ope=
ration > 0.1 & (tma_core_bound > 0.1 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_slow_pause > 0.05 & tma_serializing_oper=
ation > 0.1 & tma_core_bound > 0.1 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to PAUSE Instructions. Sample with: CPU_CLK_UNHALTE=
D.PAUSE_INST",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles ha=
ndling memory load split accesses - load that cross 64-byte cache line boun=
dary",
> -        "MetricExpr": "tma_info_memory_load_miss_real_latency * cpu_core=
@LD_BLOCKS.NO_SR@ / tma_info_thread_clks",
> +        "MetricExpr": "tma_info_memory_load_miss_real_latency * LD_BLOCK=
S.NO_SR / tma_info_thread_clks",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
>          "MetricName": "tma_split_loads",
> -        "MetricThreshold": "tma_split_loads > 0.2 & (tma_l1_bound > 0.1 =
& (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles h=
andling memory load split accesses - load that cross 64-byte cache line bou=
ndary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS_PS",
> +        "MetricThreshold": "tma_split_loads > 0.3",
> +        "PublicDescription": "This metric estimates fraction of cycles h=
andling memory load split accesses - load that cross 64-byte cache line bou=
ndary. Sample with: MEM_INST_RETIRED.SPLIT_LOADS",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents rate of split store =
accesses",
> -        "MetricExpr": "cpu_core@MEM_INST_RETIRED.SPLIT_STORES@ / tma_inf=
o_core_core_clks",
> +        "MetricExpr": "MEM_INST_RETIRED.SPLIT_STORES / tma_info_core_cor=
e_clks",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_issueSpSt;tma_store_b=
ound_group",
>          "MetricName": "tma_split_stores",
> -        "MetricThreshold": "tma_split_stores > 0.2 & (tma_store_bound > =
0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric represents rate of split store=
 accesses.  Consider aligning your data to the 64-byte cache line granulari=
ty. Sample with: MEM_INST_RETIRED.SPLIT_STORES_PS. Related metrics: tma_por=
t_4",
> +        "MetricThreshold": "tma_split_stores > 0.2 & tma_store_bound > 0=
=2E2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric represents rate of split store=
 accesses.  Consider aligning your data to the 64-byte cache line granulari=
ty. Sample with: MEM_INST_RETIRED.SPLIT_STORES",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric measures fraction of cycles whe=
re the Super Queue (SQ) was full taking into account all request-types and =
both hardware SMT threads (Logical Processors)",
> -        "MetricExpr": "(cpu_core@XQ.FULL_CYCLES@ + cpu_core@L1D_PEND_MIS=
S.L2_STALLS@) / tma_info_thread_clks",
> -        "MetricGroup": "BvMS;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_issueBW;tma_l3_bound_group",
> +        "MetricExpr": "(XQ.FULL_CYCLES + L1D_PEND_MISS.L2_STALLS) / tma_=
info_thread_clks",
> +        "MetricGroup": "BvMB;MemoryBW;Offcore;TopdownL4;tma_L4_group;tma=
_issueBW;tma_l3_bound_group",
>          "MetricName": "tma_sq_full",
> -        "MetricThreshold": "tma_sq_full > 0.3 & (tma_l3_bound > 0.05 & (=
tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric measures fraction of cycles wh=
ere the Super Queue (SQ) was full taking into account all request-types and=
 both hardware SMT threads (Logical Processors). Related metrics: tma_fb_fu=
ll, tma_info_bottleneck_cache_memory_bandwidth, tma_info_system_dram_bw_use=
, tma_mem_bandwidth",
> +        "MetricThreshold": "tma_sq_full > 0.3 & tma_l3_bound > 0.05 & tm=
a_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric measures fraction of cycles wh=
ere the Super Queue (SQ) was full taking into account all request-types and=
 both hardware SMT threads (Logical Processors). Related metrics: tma_bottl=
eneck_cache_memory_bandwidth, tma_fb_full, tma_info_system_dram_bw_use, tma=
_mem_bandwidth",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates how often CPU was sta=
lled  due to RFO store memory accesses; RFO store issue a read-for-ownershi=
p request before the write",
> -        "MetricExpr": "cpu_core@EXE_ACTIVITY.BOUND_ON_STORES@ / tma_info=
_thread_clks",
> +        "MetricExpr": "EXE_ACTIVITY.BOUND_ON_STORES / tma_info_thread_cl=
ks",
>          "MetricGroup": "MemoryBound;TmaL3mem;TopdownL3;tma_L3_group;tma_=
memory_bound_group",
>          "MetricName": "tma_store_bound",
> -        "MetricThreshold": "tma_store_bound > 0.2 & (tma_memory_bound > =
0.2 & tma_backend_bound > 0.2)",
> -        "PublicDescription": "This metric estimates how often CPU was st=
alled  due to RFO store memory accesses; RFO store issue a read-for-ownersh=
ip request before the write. Even though store accesses do not typically st=
all out-of-order CPUs; there are few cases where stores can lead to actual =
stalls. This metric will be flagged should RFO stores be a bottleneck. Samp=
le with: MEM_INST_RETIRED.ALL_STORES_PS",
> +        "MetricThreshold": "tma_store_bound > 0.2 & tma_memory_bound > 0=
=2E2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates how often CPU was st=
alled  due to RFO store memory accesses; RFO store issue a read-for-ownersh=
ip request before the write. Even though store accesses do not typically st=
all out-of-order CPUs; there are few cases where stores can lead to actual =
stalls. This metric will be flagged should RFO stores be a bottleneck. Samp=
le with: MEM_INST_RETIRED.ALL_STORES",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric roughly estimates fraction of c=
ycles when the memory subsystem had loads blocked since they could not forw=
ard data from earlier (in program order) overlapping stores",
> -        "MetricExpr": "13 * cpu_core@LD_BLOCKS.STORE_FORWARD@ / tma_info=
_thread_clks",
> +        "MetricExpr": "13 * LD_BLOCKS.STORE_FORWARD / tma_info_thread_cl=
ks",
>          "MetricGroup": "TopdownL4;tma_L4_group;tma_l1_bound_group",
>          "MetricName": "tma_store_fwd_blk",
> -        "MetricThreshold": "tma_store_fwd_blk > 0.1 & (tma_l1_bound > 0.=
1 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric roughly estimates fraction of =
cycles when the memory subsystem had loads blocked since they could not for=
ward data from earlier (in program order) overlapping stores. To streamline=
 memory operations in the pipeline; a load can avoid waiting for memory if =
a prior in-flight store is writing the data that the load wants to read (st=
ore forwarding process). However; in some cases the load may be blocked for=
 a significant time pending the store forward. For example; when the prior =
store is writing a smaller region than the load is reading.",
> +        "MetricThreshold": "tma_store_fwd_blk > 0.1 & tma_l1_bound > 0.1=
 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric roughly estimates fraction of =
cycles when the memory subsystem had loads blocked since they could not for=
ward data from earlier (in program order) overlapping stores. To streamline=
 memory operations in the pipeline; a load can avoid waiting for memory if =
a prior in-flight store is writing the data that the load wants to read (st=
ore forwarding process). However; in some cases the load may be blocked for=
 a significant time pending the store forward. For example; when the prior =
store is writing a smaller region than the load is reading",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates fraction of cycles th=
e CPU spent handling L1D store misses",
> -        "MetricExpr": "(cpu_core@MEM_STORE_RETIRED.L2_HIT@ * 10 * (1 - c=
pu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED.ALL_STORES=
@) + (1 - cpu_core@MEM_INST_RETIRED.LOCK_LOADS@ / cpu_core@MEM_INST_RETIRED=
=2EALL_STORES@) * min(cpu_core@CPU_CLK_UNHALTED.THREAD@, cpu_core@OFFCORE_R=
EQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO@)) / tma_info_thread_clks",
> -        "MetricGroup": "BvML;MemoryLat;Offcore;TopdownL4;tma_L4_group;tm=
a_issueRFO;tma_issueSL;tma_store_bound_group",
> +        "MetricExpr": "(MEM_STORE_RETIRED.L2_HIT * 10 * (1 - MEM_INST_RE=
TIRED.LOCK_LOADS / MEM_INST_RETIRED.ALL_STORES) + (1 - MEM_INST_RETIRED.LOC=
K_LOADS / MEM_INST_RETIRED.ALL_STORES) * min(CPU_CLK_UNHALTED.THREAD, OFFCO=
RE_REQUESTS_OUTSTANDING.CYCLES_WITH_DEMAND_RFO)) / tma_info_thread_clks",
> +        "MetricGroup": "BvML;LockCont;MemoryLat;Offcore;TopdownL4;tma_L4=
_group;tma_issueRFO;tma_issueSL;tma_store_bound_group",
>          "MetricName": "tma_store_latency",
> -        "MetricThreshold": "tma_store_latency > 0.1 & (tma_store_bound >=
 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> -        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU spent handling L1D store misses. Store accesses usually less impact =
out-of-order core performance; however; holding resources for longer time c=
an lead into undesired implications (e.g. contention on L1D fill-buffer ent=
ries - see FB_Full). Related metrics: tma_fb_full, tma_lock_latency",
> +        "MetricThreshold": "tma_store_latency > 0.1 & tma_store_bound > =
0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
> +        "PublicDescription": "This metric estimates fraction of cycles t=
he CPU spent handling L1D store misses. Store accesses usually less impact =
out-of-order core performance; however; holding resources for longer time c=
an lead into undesired implications (e.g. contention on L1D fill-buffer ent=
ries - see FB_Full). Related metrics: tma_branch_resteers, tma_fb_full, tma=
_l3_hit_latency, tma_lock_latency",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents Core fraction of cyc=
les CPU dispatched uops on execution port for Store operations",
> -        "MetricExpr": "(cpu_core@UOPS_DISPATCHED.PORT_4_9@ + cpu_core@UO=
PS_DISPATCHED.PORT_7_8@) / (4 * tma_info_core_core_clks)",
> +        "MetricExpr": "(UOPS_DISPATCHED.PORT_4_9 + UOPS_DISPATCHED.PORT_=
7_8) / (4 * tma_info_core_core_clks)",
>          "MetricGroup": "TopdownL5;tma_L5_group;tma_ports_utilized_3m_gro=
up",
>          "MetricName": "tma_store_op_utilization",
>          "MetricThreshold": "tma_store_op_utilization > 0.6",
> @@ -2509,46 +4587,73 @@
>          "MetricExpr": "tma_dtlb_store - tma_store_stlb_miss",
>          "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_=
group",
>          "MetricName": "tma_store_stlb_hit",
> -        "MetricThreshold": "tma_store_stlb_hit > 0.05 & (tma_dtlb_store =
> 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bou=
nd > 0.2)))",
> +        "MetricThreshold": "tma_store_stlb_hit > 0.05 & tma_dtlb_store >=
 0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound =
> 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates the fraction of cycle=
s where the STLB was missed by store accesses, performing a hardware page w=
alk",
> -        "MetricExpr": "cpu_core@DTLB_STORE_MISSES.WALK_ACTIVE@ / tma_inf=
o_core_core_clks",
> +        "MetricExpr": "DTLB_STORE_MISSES.WALK_ACTIVE / tma_info_core_cor=
e_clks",
>          "MetricGroup": "MemoryTLB;TopdownL5;tma_L5_group;tma_dtlb_store_=
group",
>          "MetricName": "tma_store_stlb_miss",
> -        "MetricThreshold": "tma_store_stlb_miss > 0.05 & (tma_dtlb_store=
 > 0.05 & (tma_store_bound > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bo=
und > 0.2)))",
> +        "MetricThreshold": "tma_store_stlb_miss > 0.05 & tma_dtlb_store =
> 0.05 & tma_store_bound > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound=
 > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 1 GB pages f=
or data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_1G / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_CO=
MPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_=
miss_group",
> +        "MetricName": "tma_store_stlb_miss_1g",
> +        "MetricThreshold": "tma_store_stlb_miss_1g > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 2 or 4 MB pa=
ges for data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_2M_4M / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK=
_COMPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_=
miss_group",
> +        "MetricName": "tma_store_stlb_miss_2m",
> +        "MetricThreshold": "tma_store_stlb_miss_2m > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "This metric estimates the fraction of cycle=
s to walk the memory paging structures to cache translation of 4 KB pages f=
or data store accesses",
> +        "MetricExpr": "tma_store_stlb_miss * DTLB_STORE_MISSES.WALK_COMP=
LETED_4K / (DTLB_STORE_MISSES.WALK_COMPLETED_4K + DTLB_STORE_MISSES.WALK_CO=
MPLETED_2M_4M + DTLB_STORE_MISSES.WALK_COMPLETED_1G)",
> +        "MetricGroup": "MemoryTLB;TopdownL6;tma_L6_group;tma_store_stlb_=
miss_group",
> +        "MetricName": "tma_store_stlb_miss_4k",
> +        "MetricThreshold": "tma_store_stlb_miss_4k > 0.05 & tma_store_st=
lb_miss > 0.05 & tma_dtlb_store > 0.05 & tma_store_bound > 0.2 & tma_memory=
_bound > 0.2 & tma_backend_bound > 0.2",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric estimates how often CPU was sta=
lled  due to Streaming store memory accesses; Streaming store optimize out =
a read request required by RFO stores",
> -        "MetricExpr": "9 * cpu_core@OCR.STREAMING_WR.ANY_RESPONSE@ / tma=
_info_thread_clks",
> +        "MetricExpr": "9 * OCR.STREAMING_WR.ANY_RESPONSE / tma_info_thre=
ad_clks",
>          "MetricGroup": "MemoryBW;Offcore;TopdownL4;tma_L4_group;tma_issu=
eSmSt;tma_store_bound_group",
>          "MetricName": "tma_streaming_stores",
> -        "MetricThreshold": "tma_streaming_stores > 0.2 & (tma_store_boun=
d > 0.2 & (tma_memory_bound > 0.2 & tma_backend_bound > 0.2))",
> +        "MetricThreshold": "tma_streaming_stores > 0.2 & tma_store_bound=
 > 0.2 & tma_memory_bound > 0.2 & tma_backend_bound > 0.2",
>          "PublicDescription": "This metric estimates how often CPU was st=
alled  due to Streaming store memory accesses; Streaming store optimize out=
 a read request required by RFO stores. Even though store accesses do not t=
ypically stall out-of-order CPUs; there are few cases where stores can lead=
 to actual stalls. This metric will be flagged should Streaming stores be a=
 bottleneck. Sample with: OCR.STREAMING_WR.ANY_RESPONSE. Related metrics: t=
ma_fb_full",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric represents fraction of cycles t=
he CPU was stalled due to new branch address clears",
> -        "MetricExpr": "cpu_core@INT_MISC.UNKNOWN_BRANCH_CYCLES@ / tma_in=
fo_thread_clks",
> +        "MetricExpr": "INT_MISC.UNKNOWN_BRANCH_CYCLES / tma_info_thread_=
clks",
>          "MetricGroup": "BigFootprint;BvBC;FetchLat;TopdownL4;tma_L4_grou=
p;tma_branch_resteers_group",
>          "MetricName": "tma_unknown_branches",
> -        "MetricThreshold": "tma_unknown_branches > 0.05 & (tma_branch_re=
steers > 0.05 & (tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15))",
> +        "MetricThreshold": "tma_unknown_branches > 0.05 & tma_branch_res=
teers > 0.05 & tma_fetch_latency > 0.1 & tma_frontend_bound > 0.15",
>          "PublicDescription": "This metric represents fraction of cycles =
the CPU was stalled due to new branch address clears. These are fetched bra=
nches the Branch Prediction Unit was unable to recognize (e.g. first time t=
he branch is fetched or hitting BTB capacity limit) hence called Unknown Br=
anches. Sample with: FRONTEND_RETIRED.UNKNOWN_BRANCH",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      },
>      {
>          "BriefDescription": "This metric serves as an approximation of l=
egacy x87 usage",
> -        "MetricExpr": "tma_retiring * cpu_core@UOPS_EXECUTED.X87@ / cpu_=
core@UOPS_EXECUTED.THREAD@",
> +        "MetricExpr": "tma_retiring * UOPS_EXECUTED.X87 / UOPS_EXECUTED.=
THREAD",
>          "MetricGroup": "Compute;TopdownL4;tma_L4_group;tma_fp_arith_grou=
p",
>          "MetricName": "tma_x87_use",
> -        "MetricThreshold": "tma_x87_use > 0.1 & (tma_fp_arith > 0.2 & tm=
a_light_operations > 0.6)",
> -        "PublicDescription": "This metric serves as an approximation of =
legacy x87 usage. It accounts for instructions beyond X87 FP arithmetic ope=
rations; hence may be used as a thermometer to avoid X87 high usage and pre=
ferably upgrade to modern ISA. See Tip under Tuning Hint.",
> +        "MetricThreshold": "tma_x87_use > 0.1 & tma_fp_arith > 0.2 & tma=
_light_operations > 0.6",
> +        "PublicDescription": "This metric serves as an approximation of =
legacy x87 usage. It accounts for instructions beyond X87 FP arithmetic ope=
rations; hence may be used as a thermometer to avoid X87 high usage and pre=
ferably upgrade to modern ISA. See Tip under Tuning Hint",
>          "ScaleUnit": "100%",
>          "Unit": "cpu_core"
>      }
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/cache.json b/tools/=
perf/pmu-events/arch/x86/alderlake/cache.json
> index 3f51686fe7a8..a20e19738046 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/cache.json
> @@ -91,6 +91,26 @@
>          "UMask": "0x1f",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Modified cache lines that are evicted by L2=
 cache when triggered by an L2 cache fill.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x26",
> +        "EventName": "L2_LINES_OUT.NON_SILENT",
> +        "PublicDescription": "Counts the number of lines that are evicte=
d by L2 cache when triggered by an L2 cache fill. Those lines are in Modifi=
ed state. Modified lines are written back to L3",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_core"
> +    },
> +    {
> +        "BriefDescription": "Non-modified cache lines that are silently =
dropped by L2 cache.",
> +        "Counter": "0,1,2,3",
> +        "EventCode": "0x26",
> +        "EventName": "L2_LINES_OUT.SILENT",
> +        "PublicDescription": "Counts the number of lines that are silent=
ly dropped by L2 cache. These lines are typically in Shared or Exclusive st=
ate. A non-threaded event.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_core"
> +    },
>      {
>          "BriefDescription": "Cache lines that have been L2 hardware pref=
etched but not used by demand accesses",
>          "Counter": "0,1,2,3",
> @@ -101,6 +121,15 @@
>          "UMask": "0x4",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the total number of L2 Cache accesse=
s. Counts on a per core basis.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.ALL",
> +        "PublicDescription": "Counts the total number of L2 Cache Access=
es, includes hits, misses, rejects  front door requests for CRd/DRd/RFO/Ito=
M/L2 Prefetches only.  Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "All accesses to L2 cache [This event is ali=
as to L2_RQSTS.REFERENCES]",
>          "Counter": "0,1,2,3",
> @@ -111,6 +140,26 @@
>          "UMask": "0xff",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache accesses that=
 resulted in a hit. Counts on a per core basis.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.HIT",
> +        "PublicDescription": "Counts the number of L2 Cache accesses tha=
t resulted in a hit from a front door request only (does not include reject=
s or recycles), Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of L2 Cache accesses that=
 resulted in a miss. Counts on a per core basis.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0x24",
> +        "EventName": "L2_REQUEST.MISS",
> +        "PublicDescription": "Counts the number of L2 Cache accesses tha=
t resulted in a miss from a front door request only (does not include rejec=
ts or recycles). Counts on a per core basis.",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Read requests with true-miss in L2 cache. [=
This event is alias to L2_RQSTS.MISS]",
>          "Counter": "0,1,2,3",
> @@ -412,7 +461,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ALL_LOADS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all retired load instructions. This=
 event accounts for SW prefetch instructions of PREFETCHNTA or PREFETCHT0/1=
/2 or PREFETCHW.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x81",
> @@ -424,7 +472,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ALL_STORES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all retired store instructions.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x82",
> @@ -436,7 +483,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.ANY",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all retired memory instructions - l=
oads and stores.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x83",
> @@ -448,7 +494,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.LOCK_LOADS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with lock=
ed access.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x21",
> @@ -460,7 +505,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.SPLIT_LOADS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions that spli=
t across a cacheline boundary.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x41",
> @@ -472,7 +516,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.SPLIT_STORES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired store instructions that spl=
it across a cacheline boundary.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x42",
> @@ -484,7 +527,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.STLB_MISS_LOADS",
> -        "PEBS": "1",
>          "PublicDescription": "Number of retired load instructions that (=
start a) miss in the 2nd-level TLB (STLB).",
>          "SampleAfterValue": "100003",
>          "UMask": "0x11",
> @@ -496,7 +538,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_INST_RETIRED.STLB_MISS_STORES",
> -        "PEBS": "1",
>          "PublicDescription": "Number of retired store instructions that =
(start a) miss in the 2nd-level TLB (STLB).",
>          "SampleAfterValue": "100003",
>          "UMask": "0x12",
> @@ -518,7 +559,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_FWD",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions whose dat=
a sources were HitM responses from shared L3.",
>          "SampleAfterValue": "20011",
>          "UMask": "0x4",
> @@ -530,7 +570,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HIT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions whose dat=
a sources were L3 and cross-core snoop hits in on-pkg core cache.",
>          "SampleAfterValue": "20011",
>          "UMask": "0x2",
> @@ -542,7 +581,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_HITM",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions whose dat=
a sources were HitM responses from shared L3.",
>          "SampleAfterValue": "20011",
>          "UMask": "0x4",
> @@ -554,7 +592,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_MISS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the retired load instructions whose=
 data sources were L3 hit and cross-core snoop missed in on-pkg core cache.=
",
>          "SampleAfterValue": "20011",
>          "UMask": "0x1",
> @@ -566,7 +603,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NONE",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions whose dat=
a sources were hits in L3 without snoops required.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x8",
> @@ -578,7 +614,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd2",
>          "EventName": "MEM_LOAD_L3_HIT_RETIRED.XSNP_NO_FWD",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions whose dat=
a sources were L3 and cross-core snoop hits in on-pkg core cache.",
>          "SampleAfterValue": "20011",
>          "UMask": "0x2",
> @@ -590,7 +625,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd3",
>          "EventName": "MEM_LOAD_L3_MISS_RETIRED.LOCAL_DRAM",
> -        "PEBS": "1",
>          "PublicDescription": "Retired load instructions which data sourc=
es missed L3 but serviced from local DRAM.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -602,7 +636,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd4",
>          "EventName": "MEM_LOAD_MISC_RETIRED.UC",
> -        "PEBS": "1",
>          "PublicDescription": "Retired instructions with at least one loa=
d to uncacheable memory-type, or at least one cache-line split locked acces=
s (Bus Lock).",
>          "SampleAfterValue": "100007",
>          "UMask": "0x4",
> @@ -614,7 +647,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.FB_HIT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with at l=
east one uop was load missed in L1 but hit FB (Fill Buffers) due to precedi=
ng miss to the same cache line with data not ready.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x40",
> @@ -626,7 +658,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L1_HIT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with at l=
east one uop that hit in the L1 data cache. This event includes all SW pref=
etches and lock instructions regardless of the data source.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
> @@ -638,7 +669,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L1_MISS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with at l=
east one uop that missed in the L1 cache.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x8",
> @@ -650,7 +680,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L2_HIT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with L2 c=
ache hits as data sources.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x2",
> @@ -662,7 +691,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L2_MISS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions missed L2=
 cache as data sources.",
>          "SampleAfterValue": "100021",
>          "UMask": "0x10",
> @@ -674,7 +702,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L3_HIT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with at l=
east one uop that hit in the L3 cache.",
>          "SampleAfterValue": "100021",
>          "UMask": "0x4",
> @@ -686,7 +713,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_RETIRED.L3_MISS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired load instructions with at l=
east one uop that missed in the L3 cache.",
>          "SampleAfterValue": "50021",
>          "UMask": "0x20",
> @@ -698,33 +724,90 @@
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_UOPS_RETIRED.DRAM_HIT",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x80",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in the L3 cache, in which a snoop was required and modified data was f=
orwarded from another core or module.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.HITM",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x20",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in the L1 data cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_HIT",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 miss in the L1 data cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.L1_MISS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x8",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of load uops retired that=
 hit in the L2 cache.",
>          "Counter": "0,1,2,3,4,5",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_UOPS_RETIRED.L2_HIT",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x2",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 miss in the L2 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd1",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED.L2_MISS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x10",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of load uops retired that=
 hit in the L3 cache.",
>          "Counter": "0,1,2,3,4,5",
>          "Data_LA": "1",
>          "EventCode": "0xd1",
>          "EventName": "MEM_LOAD_UOPS_RETIRED.L3_HIT",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x4",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 hit in the L3 cache, in which a snoop was required, and non-modified data =
was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.HIT_E_F",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x40",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load uops retired that=
 miss in the L3 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd2",
> +        "EventName": "MEM_LOAD_UOPS_RETIRED_MISC.L3_MISS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x20",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of cycles that uops are b=
locked for any of the following reasons:  load buffer, store buffer or RSV =
full.",
>          "Counter": "0,1,2,3,4,5",
> @@ -776,7 +859,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.ALL_LOADS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of load uops retir=
ed.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x81",
> @@ -788,7 +870,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.ALL_STORES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of store uops reti=
red.",
>          "SampleAfterValue": "200003",
>          "UMask": "0x82",
> @@ -802,7 +883,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_128",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x80",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 128 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -816,7 +896,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_16",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x10",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 16 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
=2E If a PEBS record is generated, will populate the PEBS Latency and PEBS =
Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -830,7 +909,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_256",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x100",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 256 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -844,7 +922,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_32",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x20",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 32 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
=2E If a PEBS record is generated, will populate the PEBS Latency and PEBS =
Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -858,7 +935,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_4",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x4",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 4 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -872,7 +948,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_512",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x200",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 512 cycles as d=
efined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enable=
d. If a PEBS record is generated, will populate the PEBS Latency and PEBS D=
ata Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -886,7 +961,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_64",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x40",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 64 cycles as de=
fined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled=
=2E If a PEBS record is generated, will populate the PEBS Latency and PEBS =
Data Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -900,7 +974,6 @@
>          "EventName": "MEM_UOPS_RETIRED.LOAD_LATENCY_GT_8",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x8",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of tagged loads with an =
instruction latency that exceeds or equals the threshold of 8 cycles as def=
ined in MEC_CR_PEBS_LD_LAT_THRESHOLD (3F6H). Only counts with PEBS enabled.=
 If a PEBS record is generated, will populate the PEBS Latency and PEBS Dat=
a Source fields accordingly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x5",
> @@ -912,7 +985,6 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.LOCK_LOADS",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x21",
>          "Unit": "cpu_atom"
> @@ -923,18 +995,46 @@
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.SPLIT_LOADS",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x41",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts the total number of load and store u=
ops retired that missed in the second level TLB.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STLB_MISS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x13",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of load ops retired that =
miss in the second Level TLB.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_LOADS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x11",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of store ops retired that=
 miss in the second level TLB.",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.STLB_MISS_STORES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x12",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts the number of stores uops retired. C=
ounts with or without PEBS enabled.",
>          "Counter": "0,1,2,3,4,5",
>          "Data_LA": "1",
>          "EventCode": "0xd0",
>          "EventName": "MEM_UOPS_RETIRED.STORE_LATENCY",
> -        "PEBS": "2",
>          "PublicDescription": "Counts the number of stores uops retired. =
Counts with or without PEBS enabled. If PEBS is enabled and a PEBS record i=
s generated, will populate PEBS Latency and PEBS Data Source fields accordi=
ngly.",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x6",
> @@ -950,13 +1050,57 @@
>          "UMask": "0x3",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were supplied by the L3 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C0004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were supplied by the L3 cache where a snoop=
 was sent, the snoop hit, and modified data was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C0004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were supplied by the L3 cache where a snoop=
 was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were supplied by the L3 cache where a snoop=
 was sent, the snoop hit, and non-modified data was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts demand data reads that were supplied=
 by the L3 cache.",
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_DATA_RD.L3_HIT",
>          "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0001",
> +        "MSRValue": "0x1F803C0001",
>          "SampleAfterValue": "100003",
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
> @@ -1022,7 +1166,7 @@
>          "EventCode": "0xB7",
>          "EventName": "OCR.DEMAND_RFO.L3_HIT",
>          "MSRIndex": "0x1a6,0x1a7",
> -        "MSRValue": "0x3F803C0002",
> +        "MSRValue": "0x1F803C0002",
>          "SampleAfterValue": "100003",
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
> @@ -1049,6 +1193,72 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, but no data was for=
warded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C0002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were supplied=
 by the L3 cache where a snoop was sent, the snoop hit, and non-modified da=
ta was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C0002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L=
3 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.L3_HIT",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x1F803C4000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L=
3 cache where a snoop was sent, the snoop hit, and modified data was forwar=
ded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HITM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10003C4000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L=
3 cache where a snoop was sent, the snoop hit, but no data was forwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_NO_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x4003C4000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by the L=
3 cache where a snoop was sent, the snoop hit, and non-modified data was fo=
rwarded.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.L3_HIT.SNOOP_HIT_WITH_FWD",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x8003C4000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "OFFCORE_REQUESTS.ALL_REQUESTS",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json=
 b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
> index b4621c221f58..62fd70f220e5 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/floating-point.json
> @@ -1,4 +1,13 @@
>  [
> +    {
> +        "BriefDescription": "Counts the number of cycles the floating po=
int divider is in the loop stage.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.FPDIV_ACTIVE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x2",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "ARITH.FPDIV_ACTIVE",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -9,6 +18,15 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of floating point divider=
 uops executed per cycle.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.FPDIV_UOPS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x8",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts all microcode FP assists.",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -187,7 +205,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.FPDIV",
> -        "PEBS": "1",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x8",
>          "Unit": "cpu_atom"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json b/too=
ls/perf/pmu-events/arch/x86/alderlake/frontend.json
> index 66735a612ebd..c5b3818ad479 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/frontend.json
> @@ -55,7 +55,6 @@
>          "EventName": "FRONTEND_RETIRED.ANY_DSB_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x1",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experienc=
ed DSB (Decode stream buffer i.e. the decoded instruction-cache) miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -68,7 +67,6 @@
>          "EventName": "FRONTEND_RETIRED.DSB_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x11",
> -        "PEBS": "1",
>          "PublicDescription": "Number of retired Instructions that experi=
enced a critical DSB (Decode stream buffer i.e. the decoded instruction-cac=
he) miss. Critical means stalls were exposed to the back-end as a result of=
 the DSB miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -81,7 +79,6 @@
>          "EventName": "FRONTEND_RETIRED.ITLB_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x14",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experienc=
ed iTLB (Instruction TLB) true miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -94,7 +91,6 @@
>          "EventName": "FRONTEND_RETIRED.L1I_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x12",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions who experience=
d Instruction L1 Cache true miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -107,7 +103,6 @@
>          "EventName": "FRONTEND_RETIRED.L2_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x13",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions who experience=
d Instruction L2 Cache true miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -120,7 +115,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_1",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x600106",
> -        "PEBS": "1",
>          "PublicDescription": "Retired instructions that are fetched afte=
r an interval where the front-end delivered no uops for a period of at leas=
t 1 cycle which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -133,7 +127,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_128",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x608006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
128 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -146,7 +139,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_16",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x601006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 16 cycles. During =
this period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -159,7 +151,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_2",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x600206",
> -        "PEBS": "1",
>          "PublicDescription": "Retired instructions that are fetched afte=
r an interval where the front-end delivered no uops for a period of at leas=
t 2 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -172,7 +163,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_256",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x610006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
256 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -185,7 +175,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_2_BUBBLES_GE_1",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x100206",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after the front-end had at least 1 bubble-slot for a p=
eriod of 2 cycles. A bubble-slot is an empty issue-pipeline slot while ther=
e was no RAT stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -198,7 +187,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_32",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x602006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 32 cycles. During =
this period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -211,7 +199,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_4",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x600406",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
4 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -224,7 +211,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_512",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x620006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
512 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -237,7 +223,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_64",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x604006",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are fetch=
ed after an interval where the front-end delivered no uops for a period of =
64 cycles which was not interrupted by a back-end stall.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -250,7 +235,6 @@
>          "EventName": "FRONTEND_RETIRED.LATENCY_GE_8",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x600806",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired instructions that are deliv=
ered to the back-end after a front-end stall of at least 8 cycles. During t=
his period the front-end delivered no uops.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -263,7 +247,6 @@
>          "EventName": "FRONTEND_RETIRED.MS_FLOWS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x8",
> -        "PEBS": "1",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
>          "Unit": "cpu_core"
> @@ -275,7 +258,6 @@
>          "EventName": "FRONTEND_RETIRED.STLB_MISS",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x15",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired Instructions that experienc=
ed STLB (2nd level TLB) true miss.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -288,7 +270,6 @@
>          "EventName": "FRONTEND_RETIRED.UNKNOWN_BRANCH",
>          "MSRIndex": "0x3F7",
>          "MSRValue": "0x17",
> -        "PEBS": "1",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
>          "Unit": "cpu_core"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/memory.json b/tools=
/perf/pmu-events/arch/x86/alderlake/memory.json
> index 81a03f53aadc..fa15f5797bed 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/memory.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/memory.json
> @@ -133,7 +133,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_1024",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x400",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 1024 cycles.  Repor=
ted latency may be longer than just the memory latency.",
>          "SampleAfterValue": "53",
>          "UMask": "0x1",
> @@ -147,7 +146,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_128",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x80",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 128 cycles.  Report=
ed latency may be longer than just the memory latency.",
>          "SampleAfterValue": "1009",
>          "UMask": "0x1",
> @@ -161,7 +159,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_16",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x10",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 16 cycles.  Reporte=
d latency may be longer than just the memory latency.",
>          "SampleAfterValue": "20011",
>          "UMask": "0x1",
> @@ -175,7 +172,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_256",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x100",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 256 cycles.  Report=
ed latency may be longer than just the memory latency.",
>          "SampleAfterValue": "503",
>          "UMask": "0x1",
> @@ -189,7 +185,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_32",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x20",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 32 cycles.  Reporte=
d latency may be longer than just the memory latency.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x1",
> @@ -203,7 +198,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_4",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x4",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 4 cycles.  Reported=
 latency may be longer than just the memory latency.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x1",
> @@ -217,7 +211,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_512",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x200",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 512 cycles.  Report=
ed latency may be longer than just the memory latency.",
>          "SampleAfterValue": "101",
>          "UMask": "0x1",
> @@ -231,7 +224,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_64",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x40",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 64 cycles.  Reporte=
d latency may be longer than just the memory latency.",
>          "SampleAfterValue": "2003",
>          "UMask": "0x1",
> @@ -245,7 +237,6 @@
>          "EventName": "MEM_TRANS_RETIRED.LOAD_LATENCY_GT_8",
>          "MSRIndex": "0x3F6",
>          "MSRValue": "0x8",
> -        "PEBS": "2",
>          "PublicDescription": "Counts randomly selected loads when the la=
tency from first dispatch to completion is greater than 8 cycles.  Reported=
 latency may be longer than just the memory latency.",
>          "SampleAfterValue": "50021",
>          "UMask": "0x1",
> @@ -257,12 +248,22 @@
>          "Data_LA": "1",
>          "EventCode": "0xcd",
>          "EventName": "MEM_TRANS_RETIRED.STORE_SAMPLE",
> -        "PEBS": "2",
>          "PublicDescription": "Counts Retired memory accesses with at lea=
st 1 store operation. This PEBS event is the precisely-distributed (PDist) =
trigger covering all stores uops for sampling by the PEBS Store Latency Fac=
ility. The facility is described in Intel SDM Volume 3 section 19.9.8",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x2",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were not supplied by the L3 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84400004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts demand data reads that were not supp=
lied by the L3 cache.",
>          "Counter": "0,1,2,3,4,5",
> @@ -329,6 +330,17 @@
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were not supplied by t=
he L3 cache.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.L3_MISS",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x3F84404000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts demand data read requests that miss =
the L3 cache.",
>          "Counter": "0,1,2,3",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json b=
/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> index b54a5fc0861f..855585fe6fae 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/metricgroups.json
> @@ -41,6 +41,7 @@
>      "L2Evicts": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
>      "LSD": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
>      "Load_Store_Miss": "Grouping from Top-down Microarchitecture Analysi=
s Metrics spreadsheet",
> +    "LockCont": "Grouping from Top-down Microarchitecture Analysis Metri=
cs spreadsheet",
>      "MachineClears": "Grouping from Top-down Microarchitecture Analysis =
Metrics spreadsheet",
>      "Machine_Clears": "Grouping from Top-down Microarchitecture Analysis=
 Metrics spreadsheet",
>      "Mem": "Grouping from Top-down Microarchitecture Analysis Metrics sp=
readsheet",
> @@ -89,7 +90,9 @@
>      "tma_bad_speculation_group": "Metrics contributing to tma_bad_specul=
ation category",
>      "tma_branch_mispredicts_group": "Metrics contributing to tma_branch_=
mispredicts category",
>      "tma_branch_resteers_group": "Metrics contributing to tma_branch_res=
teers category",
> +    "tma_code_stlb_miss_group": "Metrics contributing to tma_code_stlb_m=
iss category",
>      "tma_core_bound_group": "Metrics contributing to tma_core_bound cate=
gory",
> +    "tma_divider_group": "Metrics contributing to tma_divider category",
>      "tma_dram_bound_group": "Metrics contributing to tma_dram_bound cate=
gory",
>      "tma_dtlb_load_group": "Metrics contributing to tma_dtlb_load catego=
ry",
>      "tma_dtlb_store_group": "Metrics contributing to tma_dtlb_store cate=
gory",
> @@ -99,6 +102,7 @@
>      "tma_fp_vector_group": "Metrics contributing to tma_fp_vector catego=
ry",
>      "tma_frontend_bound_group": "Metrics contributing to tma_frontend_bo=
und category",
>      "tma_heavy_operations_group": "Metrics contributing to tma_heavy_ope=
rations category",
> +    "tma_icache_misses_group": "Metrics contributing to tma_icache_misse=
s category",
>      "tma_ifetch_bandwidth_group": "Metrics contributing to tma_ifetch_ba=
ndwidth category",
>      "tma_ifetch_latency_group": "Metrics contributing to tma_ifetch_late=
ncy category",
>      "tma_int_operations_group": "Metrics contributing to tma_int_operati=
ons category",
> @@ -121,10 +125,13 @@
>      "tma_issueSpSt": "Metrics related by the issue $issueSpSt",
>      "tma_issueSyncxn": "Metrics related by the issue $issueSyncxn",
>      "tma_issueTLB": "Metrics related by the issue $issueTLB",
> +    "tma_itlb_misses_group": "Metrics contributing to tma_itlb_misses ca=
tegory",
>      "tma_l1_bound_group": "Metrics contributing to tma_l1_bound category=
",
> +    "tma_l2_bound_group": "Metrics contributing to tma_l2_bound category=
",
>      "tma_l3_bound_group": "Metrics contributing to tma_l3_bound category=
",
>      "tma_light_operations_group": "Metrics contributing to tma_light_ope=
rations category",
>      "tma_load_op_utilization_group": "Metrics contributing to tma_load_o=
p_utilization category",
> +    "tma_load_stlb_miss_group": "Metrics contributing to tma_load_stlb_m=
iss category",
>      "tma_machine_clears_group": "Metrics contributing to tma_machine_cle=
ars category",
>      "tma_mem_latency_group": "Metrics contributing to tma_mem_latency ca=
tegory",
>      "tma_memory_bound_group": "Metrics contributing to tma_memory_bound =
category",
> @@ -138,5 +145,6 @@
>      "tma_retiring_group": "Metrics contributing to tma_retiring category=
",
>      "tma_serializing_operation_group": "Metrics contributing to tma_seri=
alizing_operation category",
>      "tma_store_bound_group": "Metrics contributing to tma_store_bound ca=
tegory",
> -    "tma_store_op_utilization_group": "Metrics contributing to tma_store=
_op_utilization category"
> +    "tma_store_op_utilization_group": "Metrics contributing to tma_store=
_op_utilization category",
> +    "tma_store_stlb_miss_group": "Metrics contributing to tma_store_stlb=
_miss category"
>  }
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/other.json b/tools/=
perf/pmu-events/arch/x86/alderlake/other.json
> index f95e093f8fcf..a8b23e92408c 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/other.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/other.json
> @@ -1,9 +1,10 @@
>  [
>      {
> -        "BriefDescription": "ASSISTS.HARDWARE",
> +        "BriefDescription": "Count all other hardware assists or traps t=
hat are not necessarily architecturally exposed (through a software handler=
) beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-e=
vents. the event also counts for Machine Ordering count.",
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc1",
>          "EventName": "ASSISTS.HARDWARE",
> +        "PublicDescription": "Count all other hardware assists or traps =
that are not necessarily architecturally exposed (through a software handle=
r) beyond FP; SSE-AVX mix and A/D assists who are counted by dedicated sub-=
events.  This includes, but not limited to, assists at EXE or MEM uop write=
back like AVX* load/store/gather/scatter (non-FP GSSE-assist ) , assists ge=
nerated by ROB like PEBS and RTIT, Uncore trap, RAR (Remote Action Request)=
 and CET (Control flow Enforcement Technology) assists. the event also coun=
ts for Machine Ordering count.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x4",
>          "Unit": "cpu_core"
> @@ -50,7 +51,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xe4",
>          "EventName": "LBR_INSERTS.ANY",
> -        "PEBS": "1",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
> @@ -66,6 +66,28 @@
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
>      },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that have any type of response.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x10004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts demand instruction fetches and L1 in=
struction cache prefetches that were supplied by DRAM.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_CODE_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x784000004",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts demand data reads that have any type=
 of response.",
>          "Counter": "0,1,2,3,4,5",
> @@ -88,6 +110,17 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts demand data reads that were supplied=
 by DRAM.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_DATA_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x784000001",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts demand data reads that were supplied=
 by DRAM.",
>          "Counter": "0,1,2,3",
> @@ -121,6 +154,39 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts demand reads for ownership (RFO) and=
 software prefetches for exclusive ownership (PREFETCHW) that were supplied=
 by DRAM.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.DEMAND_RFO.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x784000002",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores which modify a full=
 64 byte cacheline that have any type of response.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.FULL_STREAMING_WR.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x800000010000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts streaming stores which modify only p=
art of a 64 byte cacheline that have any type of response.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.PARTIAL_STREAMING_WR.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x400000010000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Counts streaming stores that have any type =
of response.",
>          "Counter": "0,1,2,3,4,5",
> @@ -143,6 +209,28 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that have any type of respo=
nse.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.ANY_RESPONSE",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x14000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts L1 data cache software prefetches wh=
ich include T0/T1/T2 and NTA (except PREFETCHW) that were supplied by DRAM.=
",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xB7",
> +        "EventName": "OCR.SWPF_RD.DRAM",
> +        "MSRIndex": "0x1a6,0x1a7",
> +        "MSRValue": "0x784004000",
> +        "SampleAfterValue": "100003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Cycles when Reservation Station (RS) is emp=
ty for the thread.",
>          "Counter": "0,1,2,3,4,5,6,7",
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json b/too=
ls/perf/pmu-events/arch/x86/alderlake/pipeline.json
> index b7656f77dee9..f5bf0816f190 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/pipeline.json
> @@ -10,6 +10,16 @@
>          "UMask": "0x9",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of cycles when any of the=
 floating point or integer dividers are active.",
> +        "Counter": "0,1,2,3,4,5",
> +        "CounterMask": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.DIV_ACTIVE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Cycles when divide unit is busy executing d=
ivide or square root operations.",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -21,6 +31,24 @@
>          "UMask": "0x9",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of active floating point =
and integer dividers per cycle.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.DIV_OCCUPANCY",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x3",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of floating point and int=
eger divider uops executed per cycle.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.DIV_UOPS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0xc",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new even=
t ARITH.FPDIV_ACTIVE",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -32,6 +60,16 @@
>          "UMask": "0x1",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of cycles any of the two =
integer dividers are active.",
> +        "Counter": "0,1,2,3,4,5",
> +        "CounterMask": "1",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.IDIV_ACTIVE",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "This event counts the cycles the integer di=
vider is busy.",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -42,6 +80,24 @@
>          "UMask": "0x8",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "Counts the number of active integer divider=
s per cycle.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.IDIV_OCCUPANCY",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of integer divider uops e=
xecuted per cycle.",
> +        "Counter": "0,1,2,3,4,5",
> +        "EventCode": "0xcd",
> +        "EventName": "ARITH.IDIV_UOPS",
> +        "SampleAfterValue": "1000003",
> +        "UMask": "0x4",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "This event is deprecated. Refer to new even=
t ARITH.IDIV_ACTIVE",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -68,7 +124,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions in=
 which the instruction pointer (IP) of the processor is resteered due to a =
branch instruction and the branch instruction successfully retires.  All br=
anch type instructions are accounted for.",
>          "SampleAfterValue": "200003",
>          "Unit": "cpu_atom"
> @@ -78,7 +133,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.ALL_BRANCHES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all branch instructions retired.",
>          "SampleAfterValue": "400009",
>          "Unit": "cpu_core"
> @@ -89,7 +143,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xf9",
>          "Unit": "cpu_atom"
> @@ -99,7 +152,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x7e",
>          "Unit": "cpu_atom"
> @@ -109,7 +161,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND",
> -        "PEBS": "1",
>          "PublicDescription": "Counts conditional branch instructions ret=
ired.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x11",
> @@ -120,7 +171,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND_NTAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts not taken branch instructions retir=
ed.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x10",
> @@ -131,7 +181,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND_TAKEN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfe",
>          "Unit": "cpu_atom"
> @@ -141,7 +190,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.COND_TAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts taken conditional branch instructio=
ns retired.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x1",
> @@ -152,7 +200,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xbf",
>          "Unit": "cpu_atom"
> @@ -162,7 +209,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.FAR_BRANCH",
> -        "PEBS": "1",
>          "PublicDescription": "Counts far branch instructions retired.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x40",
> @@ -173,7 +219,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.INDIRECT",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xeb",
>          "Unit": "cpu_atom"
> @@ -183,7 +228,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.INDIRECT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts near indirect branch instructions r=
etired excluding returns. TSX abort is an indirect branch.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x80",
> @@ -194,7 +238,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.INDIRECT_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb",
>          "Unit": "cpu_atom"
> @@ -205,7 +248,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.IND_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb",
>          "Unit": "cpu_atom"
> @@ -216,7 +258,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.JCC",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x7e",
>          "Unit": "cpu_atom"
> @@ -226,7 +267,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xf9",
>          "Unit": "cpu_atom"
> @@ -236,7 +276,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_CALL",
> -        "PEBS": "1",
>          "PublicDescription": "Counts both direct and indirect near call =
instructions retired.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x2",
> @@ -247,7 +286,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_RETURN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xf7",
>          "Unit": "cpu_atom"
> @@ -257,7 +295,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_RETURN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts return instructions retired.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x8",
> @@ -268,7 +305,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xc0",
>          "Unit": "cpu_atom"
> @@ -278,7 +314,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NEAR_TAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts taken branch instructions retired.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x20",
> @@ -290,7 +325,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.NON_RETURN_IND",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xeb",
>          "Unit": "cpu_atom"
> @@ -300,7 +334,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.REL_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfd",
>          "Unit": "cpu_atom"
> @@ -311,7 +344,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.RETURN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xf7",
>          "Unit": "cpu_atom"
> @@ -322,7 +354,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc4",
>          "EventName": "BR_INST_RETIRED.TAKEN_JCC",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfe",
>          "Unit": "cpu_atom"
> @@ -332,7 +363,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of mispredicted br=
anch instructions retired.  All branch type instructions are accounted for.=
  Prediction of the branch target address enables the processor to begin ex=
ecuting instructions before the non-speculative execution path is known. Th=
e branch prediction unit (BPU) predicts the target address based on the ins=
truction pointer (IP) of the branch and on the execution path through which=
 execution reached this IP.    A branch misprediction occurs when the predi=
ction is wrong, and results in discarding all instructions executed in the =
speculative path and re-fetching from the correct path.",
>          "SampleAfterValue": "200003",
>          "Unit": "cpu_atom"
> @@ -342,7 +372,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.ALL_BRANCHES",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all the retired branch instructions=
 that were mispredicted by the processor. A branch misprediction occurs whe=
n the processor incorrectly predicts the destination of the branch.  When t=
he misprediction is discovered at execution, all the instructions executed =
in the wrong (speculative) path must be discarded, and the processor must s=
tart fetching from the correct path.",
>          "SampleAfterValue": "400009",
>          "Unit": "cpu_core"
> @@ -352,7 +381,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x7e",
>          "Unit": "cpu_atom"
> @@ -362,7 +390,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND",
> -        "PEBS": "1",
>          "PublicDescription": "Counts mispredicted conditional branch ins=
tructions retired.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x11",
> @@ -373,7 +400,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND_NTAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the number of conditional branch in=
structions retired that were mispredicted and the branch direction was not =
taken.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x10",
> @@ -384,7 +410,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND_TAKEN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfe",
>          "Unit": "cpu_atom"
> @@ -394,7 +419,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.COND_TAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts taken conditional mispredicted bran=
ch instructions retired.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x1",
> @@ -405,7 +429,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xeb",
>          "Unit": "cpu_atom"
> @@ -415,7 +438,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT",
> -        "PEBS": "1",
>          "PublicDescription": "Counts miss-predicted near indirect branch=
 instructions retired excluding returns. TSX abort is an indirect branch.",
>          "SampleAfterValue": "100003",
>          "UMask": "0x80",
> @@ -426,7 +448,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb",
>          "Unit": "cpu_atom"
> @@ -436,7 +457,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.INDIRECT_CALL",
> -        "PEBS": "1",
>          "PublicDescription": "Counts retired mispredicted indirect (near=
 taken) CALL instructions, including both register and memory indirect.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x2",
> @@ -448,7 +468,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.IND_CALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfb",
>          "Unit": "cpu_atom"
> @@ -459,7 +478,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.JCC",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x7e",
>          "Unit": "cpu_atom"
> @@ -469,7 +487,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0x80",
>          "Unit": "cpu_atom"
> @@ -479,7 +496,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.NEAR_TAKEN",
> -        "PEBS": "1",
>          "PublicDescription": "Counts number of near branch instructions =
retired that were mispredicted and taken.",
>          "SampleAfterValue": "400009",
>          "UMask": "0x20",
> @@ -491,7 +507,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.NON_RETURN_IND",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xeb",
>          "Unit": "cpu_atom"
> @@ -501,7 +516,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.RET",
> -        "PEBS": "1",
>          "PublicDescription": "This is a non-precise version (that is, do=
es not use PEBS) of the event that counts mispredicted return instructions =
retired.",
>          "SampleAfterValue": "100007",
>          "UMask": "0x8",
> @@ -512,7 +526,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.RETURN",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xf7",
>          "Unit": "cpu_atom"
> @@ -523,7 +536,6 @@
>          "Deprecated": "1",
>          "EventCode": "0xc5",
>          "EventName": "BR_MISP_RETIRED.TAKEN_JCC",
> -        "PEBS": "1",
>          "SampleAfterValue": "200003",
>          "UMask": "0xfe",
>          "Unit": "cpu_atom"
> @@ -616,6 +628,16 @@
>          "UMask": "0x40",
>          "Unit": "cpu_core"
>      },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t CPU_CLK_UNHALTED.REF_TSC_P",
> +        "Counter": "0,1,2,3,4,5",
> +        "Deprecated": "1",
> +        "EventCode": "0x3c",
> +        "EventName": "CPU_CLK_UNHALTED.REF",
> +        "SampleAfterValue": "2000003",
> +        "UMask": "0x1",
> +        "Unit": "cpu_atom"
> +    },
>      {
>          "BriefDescription": "Core crystal clock cycles. Cycle counts are=
 evenly distributed between active threads in the Core.",
>          "Counter": "0,1,2,3,4,5,6,7",
> @@ -854,7 +876,6 @@
>          "BriefDescription": "Counts the total number of instructions ret=
ired. (Fixed event)",
>          "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.ANY",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses fixed counter 0.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1",
> @@ -864,7 +885,6 @@
>          "BriefDescription": "Number of instructions retired. Fixed Count=
er - architectural event",
>          "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.ANY",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1",
> @@ -875,7 +895,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.ANY_P",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the total number of instructions th=
at retired. For instructions that consist of multiple uops, this event coun=
ts the retirement of the last uop of the instruction. This event continues =
counting during hardware interrupts, traps, and inside interrupt handlers. =
This event uses a programmable general purpose performance counter.",
>          "SampleAfterValue": "2000003",
>          "Unit": "cpu_atom"
> @@ -885,7 +904,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.ANY_P",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the number of X86 instructions reti=
red - an Architectural PerfMon event. Counting continues during hardware in=
terrupts, traps, and inside interrupt handlers. Notes: INST_RETIRED.ANY is =
counted by a designated fixed counter freeing up programmable counters to c=
ount other events. INST_RETIRED.ANY_P is counted by a programmable counter.=
",
>          "SampleAfterValue": "2000003",
>          "Unit": "cpu_core"
> @@ -895,7 +913,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.MACRO_FUSED",
> -        "PEBS": "1",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x10",
>          "Unit": "cpu_core"
> @@ -905,7 +922,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.NOP",
> -        "PEBS": "1",
>          "PublicDescription": "Counts all retired NOP or ENDBR32/64 instr=
uctions",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2",
> @@ -915,7 +931,6 @@
>          "BriefDescription": "Precise instruction retired with PEBS preci=
se-distribution",
>          "Counter": "Fixed counter 0",
>          "EventName": "INST_RETIRED.PREC_DIST",
> -        "PEBS": "1",
>          "PublicDescription": "A version of INST_RETIRED that allows for =
a precise distribution of samples across instructions retired. It utilizes =
the Precise Distribution of Instructions Retired (PDIR++) feature to fix bi=
as in how retired instructions get sampled. Use on Fixed Counter 0.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1",
> @@ -926,7 +941,6 @@
>          "Counter": "0,1,2,3,4,5,6,7",
>          "EventCode": "0xc0",
>          "EventName": "INST_RETIRED.REP_ITERATION",
> -        "PEBS": "1",
>          "PublicDescription": "Number of iterations of Repeat (REP) strin=
g retired instructions such as MOVS, CMPS, and SCAS. Each has a byte, word,=
 and doubleword version and string instructions can be repeated using a rep=
etition prefix, REP, that allows their architectural execution to be repeat=
ed a number of times as specified by the RCX register. Note the number of i=
terations is implementation-dependent.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x8",
> @@ -1065,7 +1079,6 @@
>          "Deprecated": "1",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.4K_ALIAS",
> -        "PEBS": "1",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x4",
>          "Unit": "cpu_atom"
> @@ -1075,7 +1088,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.ADDRESS_ALIAS",
> -        "PEBS": "1",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x4",
>          "Unit": "cpu_atom"
> @@ -1095,7 +1107,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0x03",
>          "EventName": "LD_BLOCKS.DATA_UNKNOWN",
> -        "PEBS": "1",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
>          "Unit": "cpu_atom"
> @@ -1244,7 +1255,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xe4",
>          "EventName": "MISC_RETIRED.LBR_INSERTS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the number of LBR entries recorded.=
 Requires LBRs to be enabled in IA32_LBR_CTL. This event is PDIR on GP0 and=
 NPEBS on all other GPs [This event is alias to LBR_INSERTS.ANY]",
>          "SampleAfterValue": "1000003",
>          "UMask": "0x1",
> @@ -1551,7 +1561,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "TOPDOWN_RETIRING.ALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "1000003",
>          "Unit": "cpu_atom"
>      },
> @@ -1799,7 +1808,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.ALL",
> -        "PEBS": "1",
>          "SampleAfterValue": "2000003",
>          "Unit": "cpu_atom"
>      },
> @@ -1829,7 +1837,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.IDIV",
> -        "PEBS": "1",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x10",
>          "Unit": "cpu_atom"
> @@ -1839,7 +1846,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.MS",
> -        "PEBS": "1",
>          "PublicDescription": "Counts the number of uops that are from co=
mplex flows issued by the Microcode Sequencer (MS). This includes uops from=
 flows due to complex instructions, faults, assists, and inserted flows.",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x1",
> @@ -1895,7 +1901,6 @@
>          "Counter": "0,1,2,3,4,5",
>          "EventCode": "0xc2",
>          "EventName": "UOPS_RETIRED.X87",
> -        "PEBS": "1",
>          "SampleAfterValue": "2000003",
>          "UMask": "0x2",
>          "Unit": "cpu_atom"
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json=
 b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
> index e0d8f3070778..132ce48af6d9 100644
> --- a/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/virtual-memory.json
> @@ -258,5 +258,38 @@
>          "SampleAfterValue": "1000003",
>          "UMask": "0x90",
>          "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t MEM_UOPS_RETIRED.STLB_MISS",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "Deprecated": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x13",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t MEM_UOPS_RETIRED.STLB_MISS_LOADS",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "Deprecated": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_LOADS",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x11",
> +        "Unit": "cpu_atom"
> +    },
> +    {
> +        "BriefDescription": "This event is deprecated. Refer to new even=
t MEM_UOPS_RETIRED.STLB_MISS_STORES",
> +        "Counter": "0,1,2,3,4,5",
> +        "Data_LA": "1",
> +        "Deprecated": "1",
> +        "EventCode": "0xd0",
> +        "EventName": "MEM_UOPS_RETIRED.DTLB_MISS_STORES",
> +        "SampleAfterValue": "200003",
> +        "UMask": "0x12",
> +        "Unit": "cpu_atom"
>      }
>  ]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index d503aa7e3594..d9538723927b 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -1,5 +1,5 @@
>  Family-model,Version,Filename,EventType
> -GenuineIntel-6-(97|9A|B7|BA|BF),v1.27,alderlake,core
> +GenuineIntel-6-(97|9A|B7|BA|BF),v1.28,alderlake,core
>  GenuineIntel-6-BE,v1.27,alderlaken,core
>  GenuineIntel-6-(1C|26|27|35|36),v5,bonnell,core
>  GenuineIntel-6-(3D|47),v29,broadwell,core
> --=20
> 2.47.1.545.g3c1d2e2a6a-goog
>=20
