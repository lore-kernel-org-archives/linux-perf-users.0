From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v2 2/3] perf vendor events amd: add Zen2 events
Date: Wed, 26 Feb 2020 16:09:35 -0600
Message-ID: <6f2a1097-a656-8226-1be3-36a337539412@amd.com>
References: <20200225192815.50388-1-vijaythakkar@me.com>
 <20200225192815.50388-3-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200225192815.50388-3-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2/25/20 1:28 PM, Vijay Thakkar wrote:
<snip>
> +  {
> +    "EventName": "bp_l1_tlb_fetch_hit",
> +    "EventCode": "0x94",
> +    "BriefDescription": "All instruction fetches.",

Nit picking here, but "All instruction fetches" doesn't occur in
PMCx094's description.  I'm looking at both Model 71h and 31h
documentation.  This event specifically calls out the context of
the L1 ITLB and its *hits*, i.e., specifically this text:

> +    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",

So this is the text that should probably be in the BriefDescription
as well, but if both BriefDescription and PublicDescription are going
to be equal, just provide the BriefDescription version, since it
shows with and without the -v and --details flags to perf list.

> +    "UMask": "0xFF"
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_fetch_hit.if1g",
> +    "EventCode": "0x94",
> +    "BriefDescription": "Instuction fetches to a 1GB page.",
                            ^^^^^^^^^^ Instruction

> +    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",

"The number of instruction fetches that hit in the L1 ITLB.  Instruction fetches to a 1 GB page."

> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_fetch_hit.if2m",
> +    "EventCode": "0x94",
> +    "BriefDescription": "Instuction fetches to a 2MB page.",
                            ^^^^^^^^^^ Instruction

> +    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",

Concatenate the BriefDescription text here.

> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_fetch_hit.if4k",
> +    "EventCode": "0x94",
> +    "BriefDescription": "Instuction fetches to a 4KB page.",
                            ^^^^^^^^^^ Instruction

> +    "PublicDescription": "The number of instruction fetches that hit in the L1 ITLB.",

Concatenate the BriefDescription text here.

<snip>

> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> new file mode 100644
> index 000000000000..aee22537b711
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
> @@ -0,0 +1,375 @@
> +[
> +  {
> +    "EventName": "l2_request_g1.rd_blk_l",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x80"
> +  },

Where is the "Data Cache Reads (including hardware and software prefetch)."
text from the document(s)?

> +  {
> +    "EventName": "l2_request_g1.rd_blk_x",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x40"
> +  },

Here too: missing unit mask description text.

> +  {
> +    "EventName": "l2_request_g1.ls_rd_blk_c_s",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "l2_request_g1.cacheable_ic_read",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_request_g1.change_to_x",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "l2_request_g1.prefetch_l2",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "l2_request_g1.l2_hw_pf",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Requests to L2 Group1.",
> +    "PublicDescription": "Requests to L2 Group1.",
> +    "UMask": "0x2"
> +  },

same with all the above.

> +  {
> +    "EventName": "l2_request_g1.other_requests",
> +    "EventCode": "0x60",
> +    "BriefDescription": "Events covered by l2_request_g2.",
> +    "PublicDescription": "Requests to L2 Group1. Events covered by l2_request_g2.",
> +    "UMask": "0x1"
> +  },

This text doesn't match the text in either of these:

PPR for AMD Family 17h Model 71h B0 - 56176 Rev 3.06 - Jul 17, 2019
PPR for AMD Family 17h Model 31h B0 - 55803 Rev 0.54 - Sep 12, 2019

The text in the above is an improved version from the Zen 1 variants.
Care to use the text from these documents?

> +  {
> +    "EventName": "l2_request_g2.group1",
> +    "EventCode": "0x61",
> +    "BriefDescription": "All Group 1 commands not in unit0.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. All Group 1 commands not in unit0.",
> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "l2_request_g2.ls_rd_sized",
> +    "EventCode": "0x61",
> +    "BriefDescription": "RdSized, RdSized32, RdSized64.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSized, RdSized32, RdSized64.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "l2_request_g2.ls_rd_sized_nc",
> +    "EventCode": "0x61",
> +    "BriefDescription": "RdSizedNC, RdSized32NC, RdSized64NC.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous. RdSizedNC, RdSized32NC, RdSized64NC.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "l2_request_g2.ic_rd_sized",
> +    "EventCode": "0x61",
> +    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_request_g2.ic_rd_sized_nc",
> +    "EventCode": "0x61",
> +    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "l2_request_g2.smc_inval",
> +    "EventCode": "0x61",
> +    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "l2_request_g2.bus_locks_originator",
> +    "EventCode": "0x61",
> +    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "l2_request_g2.bus_locks_responses",
> +    "EventCode": "0x61",
> +    "BriefDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "PublicDescription": "Multi-events in that LS and IF requests can be received simultaneous.",
> +    "UMask": "0x1"
> +  },

that last comment applies to all the above.

> +  {
> +    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
> +    "EventCode": "0x62",
> +    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
> +    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "l2_wcb_req.wcb_write",
> +    "EventCode": "0x63",
> +    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
> +    "BriefDescription": "LS to L2 WCB write requests.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "l2_wcb_req.wcb_close",
> +    "EventCode": "0x63",
> +    "BriefDescription": "LS to L2 WCB close requests.",
> +    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) close requests.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "l2_wcb_req.zero_byte_store",
> +    "EventCode": "0x63",
> +    "BriefDescription": "LS to L2 WCB zero byte store requests.",
> +    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) zero byte store requests.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "l2_wcb_req.cl_zero",
> +    "EventCode": "0x63",
> +    "PublicDescription": "LS to L2 WCB cache line zeroing requests.",
> +    "BriefDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) cache line zeroing requests.",
> +    "UMask": "0x1"
> +  },


> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
> +    "EventCode": "0x64",
> +    "BriefDescription": "LS ReadBlock C/S Hit.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS ReadBlock C/S Hit.",
> +    "UMask": "0x80"
> +  },

This text doesn't match that of the updated documents: please update it.

> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "LS Read Block L Hit X.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block L Hit X.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
> +    "EventCode": "0x64",
> +    "BriefDescription": "LsRdBlkL Hit Shared.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkL Hit Shared.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LsRdBlkX/ChgToX Hit X.  Count RdBlkX finding Shared as a Miss.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
> +    "EventCode": "0x64",
> +    "BriefDescription": "LS Read Block C S L X Change to X Miss.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. LS Read Block C S L X Change to X Miss.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "IC Fill Hit Exclusive Stale.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Exclusive Stale.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
> +    "EventCode": "0x64",
> +    "BriefDescription": "IC Fill Hit Shared.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Hit Shared.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "IC Fill Miss.",
> +    "PublicDescription": "This event does not count accesses to the L2 cache by the L2 prefetcher, but it does count accesses by the L1 prefetcher. IC Fill Miss.",
> +    "UMask": "0x1"
> +  },

that last comment applies to all unit masks until here.

> +  {
> +    "EventName": "l2_pf_hit_l2",
> +    "EventCode": "0x70",
> +    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which hit the L2."
> +  },
> +  {
> +    "EventName": "l2_pf_miss_l2_hit_l3",
> +    "EventCode": "0x71",
> +    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which miss the L2 cache and hit the L3."
> +  },
> +  {
> +    "EventName": "l2_pf_miss_l2_l3",
> +    "EventCode": "0x72",
> +    "BriefDescription": "All L2 prefetches accepted by the L2 pipeline which miss the L2 and the L3 caches."
> +  },

These events produce zero counts on Zen 2;
they need a "UMask": "0xff".

<snip>

> +  {
> +    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
> +    "EventCode": "0x85",
> +    "BriefDescription": "Instruction fetches to a 1GB page.",
> +    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
> +    "EventCode": "0x85",
> +    "BriefDescription": "Instruction fetches to a 2MB page.",
> +    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
> +    "EventCode": "0x85",
> +    "BriefDescription": "Instruction fetches to a 4KB page.",
> +    "PublicDescription": "The number of instruction fetches that miss in both the L1 and L2 TLBs.",
> +    "UMask": "0x1"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

<snip>

> +  {
> +    "EventName": "ex_ret_cops",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Retired Uops.",
> +    "PublicDescription": "The number of uOps retired. This includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 4."
> +  },

This text is not up to date with the latest documents.

> +  {
> +    "EventName": "ex_ret_fus_brnch_inst",
> +    "EventCode": "0x1d0",
> +    "BriefDescription": "The number of fused retired branch instructions retired per cycle. The number of events logged per cycle can vary from 0 to 3."
> +  }

This event's description text has been updated in the
latest documents; please use that text instead.

> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
> new file mode 100644
> index 000000000000..df530b398f9d
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
> @@ -0,0 +1,128 @@
> +[
> +  {
> +    "EventName": "fpu_pipe_assignment.total",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps.",
> +    "PublicDescription": "The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
> +    "UMask": "0xf"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.all",
> +    "EventCode": "0x03",
> +    "BriefDescription": "All FLOPS.",
> +    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
> +    "UMask": "0xff"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

<snip>
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
> new file mode 100644
> index 000000000000..5c0f80588c61
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
> @@ -0,0 +1,349 @@
> +[
> +  {
> +    "EventName": "ls_bad_status2.stli_other",
> +    "EventCode": "0x24",
> +    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons.",
> +    "PublicDescription": "Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason. There are a number of reasons why this occurs, and this perfmon organizes them into three major groups. ",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_locks.spec_lock_hi_spec",
> +    "EventCode": "0x25",
> +    "BriefDescription": "High speculative cacheable lock speculation succeeded.",
> +    "PublicDescription": "Retired lock instructions.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_locks.spec_lock_lo_spec",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Low speculative cacheable lock speculation succeeded.",
> +    "PublicDescription": "Retired lock instructions.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_locks.non_spec_lock",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Non-speculative lock succeeded.",
> +    "PublicDescription": "Retired lock instructions.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_locks.bus_lock",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Comparable to legacy bus lock.",
> +    "PublicDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type.",
> +    "UMask": "0x1"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

> +  {
> +    "EventName": "ls_ret_cl_flush",
> +    "EventCode": "0x26",
> +    "BriefDescription": "Number of retired CLFLUSH instructions."
> +  },
> +  {
> +    "EventName": "ls_ret_cpuid",
> +    "EventCode": "0x27",
> +    "BriefDescription": "Number of retired CLFLUSH instructions."

This text should read "The number of CPUID instructions retired."

> +  },
> +  {
> +    "EventName": "ls_dispatch.ld_st_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of single ops that do load/store to an address.",
> +    "PublicDescription": "Dispatch of a single op that performs a load from and store to the same memory address.",
> +    "UMask": "0x4"
> +  },> +  {
> +    "EventName": "ls_dispatch.store_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of stores dispatched.",
> +    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_dispatch.ld_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of loads dispatched.",
> +    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed.",
> +    "UMask": "0x1"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

<snip>

> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source.",
> +    "UMask": "0x1"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

> +  {
> +    "EventName": "ls_l1_d_tlb_miss.all",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss or Reload off all sizes.",
> +    "PublicDescription": "L1 DTLB Miss or Reload off all sizes.",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss of a page of 1G size.",
> +    "PublicDescription": "L1 DTLB Miss of a page of 1G size.",
> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss of a page of 2M size.",
> +    "PublicDescription": "L1 DTLB Miss of a page of 2M size.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss of a page of 32K size.",
> +    "PublicDescription": "L1 DTLB Miss of a page of 32K size.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss of a page of 4K size.",
> +    "PublicDescription": "L1 DTLB Miss of a page of 4K size.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Reload of a page of 1G size.",
> +    "PublicDescription": "L1 DTLB Reload of a page of 1G size.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Reload of a page of 2M size.",
> +    "PublicDescription": "L1 DTLB Reload of a page of 2M size.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_32k_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Reload of a page of 32K size.",
> +    "PublicDescription": "L1 DTLB Reload of a page of 32K size.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Reload of a page of 4K size.",
> +    "PublicDescription": "L1 DTLB Reload of a page of 4K size.",
> +    "UMask": "0x1"
> +  },

The above are not up to date, e.g., unit mask 0x2 is now
TlbReloadCoalescedPageHit.

Also, wherever BriefDescription equals PublicDescription, 
please only provide the BriefDescription.

> +  {
> +    "EventName": "ls_pref_instr_disp.prefetch_nta",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
> +    "PublicDescription": "Software Prefetch Instructions (PREFETCHNTA instruction) Dispatched.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp.store_prefetch_w",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
> +    "PublicDescription": "Software Prefetch Instructions (3DNow PREFETCHW instruction) Dispatched.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp.load_prefetch_w",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Prefetch, Prefetch_T0_T1_T2.",
> +    "PublicDescription": "Software Prefetch Instructions Dispatched. Prefetch, Prefetch_T0_T1_T2.",
> +    "UMask": "0x1"
> +  },

The text for the above events has been updated in the documents;
please update it here, too.

> +  {
> +    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
> +    "EventCode": "0x52",
> +    "BriefDescription": "Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
> +    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
> +    "EventCode": "0x52",
> +    "BriefDescription": "Software PREFETCH instruction saw a DC hit.",
> +    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
> +    "EventCode": "0x59",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
> +    "EventCode": "0x59",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source.",
> +    "UMask": "0x1"
> +  },

The BriefDescription text needs to be concatenated to the
PublicDescription text for all of the above events.

> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "FP Miscellaneous resource unavailable",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "FP scheduler resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Floating point register file resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.taken_branch_buffer_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Integer Scheduler miscellaneous resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Store queue resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Load queue resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Integer Physical Register File resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "SC AGU dispatch stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x80"
> +  },

All the above Public descriptions have "RETIRE Tokens unavailable." 
yet their BriefDescriptions are different.  Please fix.

> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "AGSQ Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "ALU tokens total unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alsq3_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "ALSQ 3 Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 3 Tokens unavailable.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alsq2_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "ALSQ 2 Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 2 Tokens unavailable.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alsq1_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "ALSQ 1 Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ 1 Tokens unavailable.",
> +    "UMask": "0x1"
> +  }

All the above events have updated text in the documents; please
update the text here too.

Patch 1 of 3 looks OK to me.  Assuming there are no further
comments to this version, please make the requested changes
to patches 2 and 3 of the series, and resend as a v3.

Thanks!

Kim
