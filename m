From: Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 3/4] perf vendor events amd: Add recommended events
Date: Wed, 2 Sep 2020 23:19:47 -0700
Message-ID: <CAP-5=fVwuKOACD++6UyBVW_fgbTXrOwuOJHSYenD87dwVJk0OA@mail.gmail.com>
References: <20200901220944.277505-1-kim.phillips@amd.com> <20200901220944.277505-3-kim.phillips@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200901220944.277505-3-kim.phillips@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@amd.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Vijay Thakkar <vijaythakkar@me.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, Yunfeng Ye <yeyunfeng@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>, Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>, Martin Jambor <mjambor@suse.cz>, Michael Petlan <mpetlan@redhat.com>, William Cohen <wcohen@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

On Tue, Sep 1, 2020 at 3:10 PM Kim Phillips <kim.phillips@amd.com> wrote:
>
> Add support for events listed in Section 2.1.15.2 "Performance
> Measurement" of "PPR for AMD Family 17h Model 31h B0 - 55803
> Rev 0.54 - Sep 12, 2019".
>
> perf now supports these new events (-e):
>
>   all_dc_accesses
>   all_tlbs_flushed
>   l1_dtlb_misses
>   l2_cache_accesses_from_dc_misses
>   l2_cache_accesses_from_ic_misses
>   l2_cache_hits_from_dc_misses
>   l2_cache_hits_from_ic_misses
>   l2_cache_misses_from_dc_misses
>   l2_cache_misses_from_ic_miss
>   l2_dtlb_misses
>   l2_itlb_misses
>   sse_avx_stalls
>   uops_dispatched
>   uops_retired
>   l3_accesses
>   l3_misses
>
> and these metrics (-M):
>
>   branch_misprediction_ratio
>   all_l2_cache_accesses
>   all_l2_cache_hits
>   all_l2_cache_misses
>   ic_fetch_miss_ratio
>   l2_cache_accesses_from_l2_hwpf
>   l2_cache_hits_from_l2_hwpf
>   l2_cache_misses_from_l2_hwpf
>   l3_read_miss_latency
>   l1_itlb_misses
>   all_remote_links_outbound
>   nps1_die_to_dram
>
> The nps1_die_to_dram event may need perf stat's --metric-no-group
> switch if the number of available data fabric counters is less
> than the number it uses (8).

These are really excellent additions! Does:
"MetricConstraint": "NO_NMI_WATCHDOG"
solve the grouping issue? Perhaps the MetricConstraint needs to be
named more generically to cover this case as it seems sub-optimal to
require the use of --metric-no-group.

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Vijay Thakkar <vijaythakkar@me.com>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Yunfeng Ye <yeyunfeng@huawei.com>
> Cc: Jin Yao <yao.jin@linux.intel.com>
> Cc: "Martin Li=C5=A1ka" <mliska@suse.cz>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Jon Grimm <jon.grimm@amd.com>
> Cc: Martin Jambor <mjambor@suse.cz>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: William Cohen <wcohen@redhat.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: linux-perf-users@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  .../pmu-events/arch/x86/amdzen1/cache.json    |  23 +++
>  .../arch/x86/amdzen1/data-fabric.json         |  98 ++++++++++
>  .../arch/x86/amdzen1/recommended.json         | 178 ++++++++++++++++++
>  .../pmu-events/arch/x86/amdzen2/cache.json    |  23 +++
>  .../arch/x86/amdzen2/data-fabric.json         |  98 ++++++++++
>  .../arch/x86/amdzen2/recommended.json         | 178 ++++++++++++++++++
>  tools/perf/pmu-events/jevents.c               |   1 +
>  7 files changed, 599 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/recommended.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/recommended.js=
on
>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen1/cache.json
> index 695ed3ffa3a6..4ea7ec4f496e 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
> @@ -117,6 +117,11 @@
>      "BriefDescription": "Miscellaneous events covered in more detail by =
l2_request_g2 (PMCx061).",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_request_g1.all_no_prefetch",
> +    "EventCode": "0x60",
> +    "UMask": "0xf9"
> +  },

Would it be possible to have a BriefDescription here?

>    {
>      "EventName": "l2_request_g2.group1",
>      "EventCode": "0x61",
> @@ -243,6 +248,24 @@
>      "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2.",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_access_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache requests in L2.",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2 and Data cach=
e request miss in L2 (all types).",
> +    "UMask": "0x9"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request hit in L2 and Data cache=
 request hit in L2 (all types).",
> +    "UMask": "0xf6"
> +  },
>    {
>      "EventName": "l2_fill_pending.l2_fill_busy",
>      "EventCode": "0x6d",
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
> new file mode 100644
> index 000000000000..40271df40015
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "EventName": "remote_outbound_data_controller_0",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 0",
> +    "EventCode": "0x7c7",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_1",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 1",
> +    "EventCode": "0x807",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_2",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 2",
> +    "EventCode": "0x847",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_3",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 3",
> +    "EventCode": "0x887",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_0",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x07",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_1",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x47",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_2",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x87",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_3",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0xc7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_4",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x107",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_5",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x147",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_6",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x187",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_7",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x1c7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen1/recommended.json
> new file mode 100644
> index 000000000000..2cfe2d2f3bfd
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
> @@ -0,0 +1,178 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-=
Speculative)",
> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "EventName": "all_dc_accesses",
> +    "EventCode": "0x29",
> +    "BriefDescription": "All L1 Data Cache Accesses",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses",
> +    "BriefDescription": "All L2 Cache Accesses",
> +    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_=
miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_ic_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Mis=
ses (including prefetch)",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_dc_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (in=
cluding prefetch)",
> +    "UMask": "0xc8"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses",
> +    "BriefDescription": "All L2 Cache Misses",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hi=
t_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_ic_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misse=
s",
> +    "UMask": "0x01"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
> +    "UMask": "0x08"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Misses from L2 HWPF",
> +    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits",
> +    "BriefDescription": "All L2 Cache Hits",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_ic_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses"=
,
> +    "UMask": "0x06"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
> +    "UMask": "0x70"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Hits from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l3_accesses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Accesses",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_misses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Misses (includes Chg2X)",

Would it be possible to add a slightly more expanded description of
what Chg2X means? I don't see it in the PPR either :-(

> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
> +    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_m=
iss_req_typs",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
> +    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_=
fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss)",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses",
> +    "BriefDescription": "L1 ITLB Misses",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "EventName": "l2_itlb_misses",
> +    "EventCode": "0x85",
> +    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
> +    "UMask": "0x07"
> +  },
> +  {
> +    "EventName": "l1_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Misses",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "l2_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L2 DTLB Misses & Data page walks",
> +    "UMask": "0xf0"
> +  },
> +  {
> +    "EventName": "all_tlbs_flushed",
> +    "EventCode": "0x78",
> +    "BriefDescription": "All TLBs Flushed",
> +    "UMask": "0xdf"
> +  },
> +  {
> +    "EventName": "uops_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Micro-ops Dispatched",
> +    "UMask": "0x03"
> +  },
> +  {
> +    "EventName": "sse_avx_stalls",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "Mixed SSE/AVX Stalls",
> +    "UMask": "0x0e"
> +  },
> +  {
> +    "EventName": "uops_retired",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Micro-ops Retired"
> +  },
> +  {
> +    "MetricName": "all_remote_links_outbound",
> +    "BriefDescription": "Approximate: Outbound data bytes for all Remote=
 Links for a node (die)",
> +    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_d=
ata_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data=
_controller_3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3e-5MiB"
> +  },
> +  {
> +    "MetricName": "nps1_die_to_dram",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.1e-5MiB"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/pe=
rf/pmu-events/arch/x86/amdzen2/cache.json
> index 1c60bfa0f00b..f61b982f83ca 100644
> --- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> @@ -47,6 +47,11 @@
>      "BriefDescription": "Miscellaneous events covered in more detail by =
l2_request_g2 (PMCx061).",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_request_g1.all_no_prefetch",
> +    "EventCode": "0x60",
> +    "UMask": "0xf9"
> +  },

Possible BriefDescription?

>    {
>      "EventName": "l2_request_g2.group1",
>      "EventCode": "0x61",
> @@ -173,6 +178,24 @@
>      "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2.",
>      "UMask": "0x1"
>    },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_access_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache requests in L2.",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request miss in L2 and Data cach=
e request miss in L2 (all types).",
> +    "UMask": "0x9"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not=
 including L2 Prefetch). Instruction cache request hit in L2 and Data cache=
 request hit in L2 (all types).",
> +    "UMask": "0xf6"
> +  },
>    {
>      "EventName": "l2_fill_pending.l2_fill_busy",
>      "EventCode": "0x6d",
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
> new file mode 100644
> index 000000000000..40271df40015
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
> @@ -0,0 +1,98 @@
> +[
> +  {
> +    "EventName": "remote_outbound_data_controller_0",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 0",
> +    "EventCode": "0x7c7",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_1",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 1",
> +    "EventCode": "0x807",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_2",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 2",
> +    "EventCode": "0x847",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "remote_outbound_data_controller_3",
> +    "PublicDescription": "Remote Link Controller Outbound Packet Types: =
Data (32B): Remote Link Controller 3",
> +    "EventCode": "0x887",
> +    "UMask": "0x02",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_0",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x07",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_1",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x47",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_2",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x87",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_3",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0xc7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_4",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x107",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_5",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x147",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_6",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x187",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  },
> +  {
> +    "EventName": "dram_channel_data_controller_7",
> +    "PublicDescription": "DRAM Channel Controller Request Types: Request=
s with Data (64B): DRAM Channel Controller 0",
> +    "EventCode": "0x1c7",
> +    "UMask": "0x38",
> +    "PerPkg": "1",
> +    "Unit": "DFPMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/to=
ols/perf/pmu-events/arch/x86/amdzen2/recommended.json
> new file mode 100644
> index 000000000000..2ef91e25e661
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
> @@ -0,0 +1,178 @@
> +[
> +  {
> +    "MetricName": "branch_misprediction_ratio",
> +    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-=
Speculative)",
> +    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
> +    "MetricGroup": "branch_prediction",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "EventName": "all_dc_accesses",
> +    "EventCode": "0x29",
> +    "BriefDescription": "All L1 Data Cache Accesses",
> +    "UMask": "0x7"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_accesses",
> +    "BriefDescription": "All L2 Cache Accesses",
> +    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_=
miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_ic_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Mis=
ses (including prefetch)",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_accesses_from_dc_misses",
> +    "EventCode": "0x60",
> +    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (in=
cluding prefetch)",
> +    "UMask": "0xc8"
> +  },
> +  {
> +    "MetricName": "l2_cache_accesses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_misses",
> +    "BriefDescription": "All L2 Cache Misses",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hi=
t_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_ic_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misse=
s",
> +    "UMask": "0x01"
> +  },
> +  {
> +    "EventName": "l2_cache_misses_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
> +    "UMask": "0x08"
> +  },
> +  {
> +    "MetricName": "l2_cache_misses_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Misses from L2 HWPF",
> +    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "MetricName": "all_l2_cache_hits",
> +    "BriefDescription": "All L2 Cache Hits",
> +    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_ic_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses"=
,
> +    "UMask": "0x06"
> +  },
> +  {
> +    "EventName": "l2_cache_hits_from_dc_misses",
> +    "EventCode": "0x64",
> +    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
> +    "UMask": "0x70"
> +  },
> +  {
> +    "MetricName": "l2_cache_hits_from_l2_hwpf",
> +    "BriefDescription": "L2 Cache Hits from L2 HWPF",
> +    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l=
3",
> +    "MetricGroup": "l2_cache"
> +  },
> +  {
> +    "EventName": "l3_accesses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Accesses",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_misses",
> +    "EventCode": "0x04",
> +    "BriefDescription": "L3 Misses (includes Chg2X)",
> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "MetricName": "l3_read_miss_latency",
> +    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
> +    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_m=
iss_req_typs",
> +    "MetricGroup": "l3_cache",
> +    "ScaleUnit": "1core clocks"
> +  },
> +  {
> +    "MetricName": "ic_fetch_miss_ratio",
> +    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
> +    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_=
fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss)",
> +    "MetricGroup": "l2_cache",
> +    "ScaleUnit": "100%"
> +  },
> +  {
> +    "MetricName": "l1_itlb_misses",
> +    "BriefDescription": "L1 ITLB Misses",
> +    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss",
> +    "MetricGroup": "tlb"
> +  },
> +  {
> +    "EventName": "l2_itlb_misses",
> +    "EventCode": "0x85",
> +    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
> +    "UMask": "0x07"
> +  },
> +  {
> +    "EventName": "l1_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Misses",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "l2_dtlb_misses",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L2 DTLB Misses & Data page walks",
> +    "UMask": "0xf0"
> +  },
> +  {
> +    "EventName": "all_tlbs_flushed",
> +    "EventCode": "0x78",
> +    "BriefDescription": "All TLBs Flushed",
> +    "UMask": "0xdf"
> +  },
> +  {
> +    "EventName": "uops_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Micro-ops Dispatched",
> +    "UMask": "0x03"
> +  },
> +  {
> +    "EventName": "sse_avx_stalls",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "Mixed SSE/AVX Stalls",
> +    "UMask": "0x0e"
> +  },
> +  {
> +    "EventName": "uops_retired",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Micro-ops Retired"
> +  },
> +  {
> +    "MetricName": "all_remote_links_outbound",
> +    "BriefDescription": "Approximate: Outbound data bytes for all Remote=
 Links for a node (die)",
> +    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_d=
ata_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data=
_controller_3",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "3e-5MiB"
> +  },
> +  {
> +    "MetricName": "nps1_die_to_dram",
> +    "BriefDescription": "Approximate: Combined DRAM B/bytes of all chann=
els on a NPS1 node (die) (may need --metric-no-group)",
> +    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_co=
ntroller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_=
3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_=
channel_data_controller_6 + dram_channel_data_controller_7",
> +    "MetricGroup": "data_fabric",
> +    "PerPkg": "1",
> +    "ScaleUnit": "6.1e-5MiB"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jeve=
nts.c
> index fa86c5f997cc..5984906b6893 100644
> --- a/tools/perf/pmu-events/jevents.c
> +++ b/tools/perf/pmu-events/jevents.c
> @@ -240,6 +240,7 @@ static struct map {
>         { "hisi_sccl,hha", "hisi_sccl,hha" },
>         { "hisi_sccl,l3c", "hisi_sccl,l3c" },
>         { "L3PMC", "amd_l3" },
> +       { "DFPMC", "amd_df" },
>         {}
>  };
>
> --
> 2.27.0
>
