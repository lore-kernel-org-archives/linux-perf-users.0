From: Kim Phillips <kim.phillips@amd.com>
Subject: Re: [PATCH v3 2/3] perf vendor events amd: add Zen2 events
Date: Mon, 2 Mar 2020 17:12:48 -0600
Message-ID: <0963807c-6df7-60a6-2601-580150a0b0d0@amd.com>
References: <20200228175639.39171-1-vijaythakkar@me.com>
 <20200228175639.39171-3-vijaythakkar@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200228175639.39171-3-vijaythakkar@me.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>, Jon Grimm <jon.grimm@amd.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

On 2/28/20 11:56 AM, Vijay Thakkar wrote:
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/branch.json
> @@ -0,0 +1,52 @@
> +[
> +  {
> +    "EventName": "bp_l1_btb_correct",
> +    "EventCode": "0x8a",
> +    "BriefDescription": "L1 BTB Correction."

I don't see any "L1 BTB Correction" text in the docs.  There, I see:

"L1 Branch Prediction Overrides Existing Prediction (speculative)"

> +  },
> +  {
> +    "EventName": "bp_l2_btb_correct",
> +    "EventCode": "0x8b",
> +    "BriefDescription": "L2 BTB Correction."
> +  },

"L2 Branch Prediction Overrides Existing Prediction (speculative)"

> +  {
> +    "EventName": "l2_latency.l2_cycles_waiting_on_fills",
> +    "EventCode": "0x62",
> +    "BriefDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",
> +    "PublicDescription": "Total cycles spent waiting for L2 fills to complete from L3 or memory, divided by four. Event counts are for both threads. To calculate average latency, the number of fills from both threads must be used.",

Remove the redundant PublicDescription.

> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "l2_wcb_req.wcb_write",
> +    "EventCode": "0x63",
> +    "PublicDescription": "LS (Load/Store unit) to L2 WCB (Write Combining Buffer) write requests.",
> +    "BriefDescription": "LS to L2 WCB write requests.",

I'd merge/consolidate the PublicDescription into the BriefDescription and only keep the Briefdescription.

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

That last comment applies to all the above events.

> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Data cache shared read hit in L2",
> +    "UMask": "0x80"
> +  },

Space(s) needed between Prefetch). and Data.

> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Data cache read hit in L2.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Data cache read hit on shared line in L2.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Data cache store or state change hit in L2.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Data cache request miss in L2 (all types).",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Instruction cache hit modifiable line in L2.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache hit clean line in L2.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "l2_cache_req_stat.ic_fill_miss",
> +    "EventCode": "0x64",
> +    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch).Instruction cache request miss in L2.",
> +    "UMask": "0x1"
> +  },

That last comment applies to all the above events, too.

> +  {
> +    "EventName": "ic_fetch_stall.ic_stall_any",
> +    "EventCode": "0x87",
> +    "BriefDescription": "IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",
> +    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle for any reason (nothing valid in pipe ICM1).",

I'd merge/consolidate the PublicDescription into the BriefDescription and only keep the Briefdescription.

> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ic_fetch_stall.ic_stall_dq_empty",
> +    "EventCode": "0x87",
> +    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
> +    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to DQ empty.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ic_fetch_stall.ic_stall_back_pressure",
> +    "EventCode": "0x87",
> +    "BriefDescription": "IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
> +    "PublicDescription": "Instruction Pipe Stall. IC pipe was stalled during this clock cycle (including IC to OC fetches) due to back-pressure.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ic_cache_inval.l2_invalidating_probe",
> +    "EventCode": "0x8c",
> +    "BriefDescription": "IC line invalidated due to L2 invalidating probe (external or LS).",
> +    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to L2 invalidating probe (external or LS).",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ic_cache_inval.fill_invalidated",
> +    "EventCode": "0x8c",
> +    "BriefDescription": "IC line invalidated due to overwriting fill response.",
> +    "PublicDescription": "The number of instruction cache lines invalidated. A non-SMC event is CMC (cross modifying code), either from the other thread of the core or another core. IC line invalidated due to overwriting fill response.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ic_oc_mode_switch.oc_ic_mode_switch",
> +    "EventCode": "0x28a",
> +    "BriefDescription": "OC to IC mode switch.",
> +    "PublicDescription": "OC Mode Switch. OC to IC mode switch.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ic_oc_mode_switch.ic_oc_mode_switch",
> +    "EventCode": "0x28a",
> +    "BriefDescription": "IC to OC mode switch.",
> +    "PublicDescription": "OC Mode Switch. IC to OC mode switch.",
> +    "UMask": "0x1"
> +  },

That last comment applies to all the above events, too.

> +  {
> +    "EventName": "l3_request_g1.caching_l3_cache_accesses",
> +    "EventCode": "0x01",
> +    "BriefDescription": "Caching: L3 cache accesses",
> +    "UMask": "0x80",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_lookup_state.all_l3_req_typs",
> +    "EventCode": "0x04",
> +    "BriefDescription": "All L3 Request Types",
> +    "UMask": "0xff",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_comb_clstr_state.other_l3_miss_typs",
> +    "EventCode": "0x06",
> +    "BriefDescription": "Other L3 Miss Request Types",
> +    "UMask": "0xfe",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "l3_comb_clstr_state.request_miss",
> +    "EventCode": "0x06",
> +    "BriefDescription": "L3 cache misses",
> +    "UMask": "0x01",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "xi_sys_fill_latency",
> +    "EventCode": "0x90",
> +    "BriefDescription": "L3 Cache Miss Latency. Total cycles for all transactions divided by 16. Ignores SliceMask and ThreadMask.",
> +    "UMask": "0x00",
> +    "Unit": "L3PMC"
> +  },
> +  {
> +    "EventName": "xi_ccx_sdp_req1.all_l3_miss_req_typs",
> +    "EventCode": "0x9A",
> +    "BriefDescription": "All L3 Miss Request Types. Ignores SliceMask and ThreadMask.",
> +    "UMask": "0x3f",
> +    "Unit": "L3PMC"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/core.json b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> new file mode 100644
> index 000000000000..ded32a2293a2
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/core.json
> @@ -0,0 +1,135 @@
> +[
> +  {
> +    "EventName": "ex_ret_instr",
> +    "EventCode": "0xc0",
> +    "BriefDescription": "Retired Instructions."
> +  },
> +  {
> +    "EventName": "ex_ret_cops",
> +    "EventCode": "0xc1",
> +    "BriefDescription": "Retired Uops.",
> +    "PublicDescription": "The number of micro-ops retired. This count includes all processor activity (instructions, exceptions, interrupts, microcode assists, etc.). The number of events logged per cycle can vary from 0 to 8."
> +  },
> +  {
> +    "EventName": "ex_ret_brn",
> +    "EventCode": "0xc2",
> +    "BriefDescription": "Retired Branch Instructions.",
> +    "PublicDescription": "The number of branch instructions retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_misp",
> +    "EventCode": "0xc3",
> +    "BriefDescription": "Retired Branch Instructions Mispredicted.",
> +    "PublicDescription": "The number of branch instructions retired, of any type, that were not correctly predicted. This includes those for which prediction is not attempted (far control transfers, exceptions and interrupts)."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_tkn",
> +    "EventCode": "0xc4",
> +    "BriefDescription": "Retired Taken Branch Instructions.",
> +    "PublicDescription": "The number of taken branches that were retired. This includes all types of architectural control flow changes, including exceptions and interrupts."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_tkn_misp",
> +    "EventCode": "0xc5",
> +    "BriefDescription": "Retired Taken Branch Instructions Mispredicted.",
> +    "PublicDescription": "The number of retired taken branch instructions that were mispredicted."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_far",
> +    "EventCode": "0xc6",
> +    "BriefDescription": "Retired Far Control Transfers.",
> +    "PublicDescription": "The number of far control transfers retired including far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts. Far control transfers are not subject to branch prediction."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_resync",
> +    "EventCode": "0xc7",
> +    "BriefDescription": "Retired Branch Resyncs.",
> +    "PublicDescription": "The number of resync branches. These reflect pipeline restarts due to certain microcode assists and events such as writes to the active instruction stream, among other things. Each occurrence reflects a restart penalty similar to a branch mispredict. This is relatively rare."
> +  },
> +  {
> +    "EventName": "ex_ret_near_ret",
> +    "EventCode": "0xc8",
> +    "BriefDescription": "Retired Near Returns.",
> +    "PublicDescription": "The number of near return instructions (RET or RET Iw) retired."
> +  },
> +  {
> +    "EventName": "ex_ret_near_ret_mispred",
> +    "EventCode": "0xc9",
> +    "BriefDescription": "Retired Near Returns Mispredicted.",
> +    "PublicDescription": "The number of near returns retired that were not correctly predicted by the return address predictor. Each such mispredict incurs the same penalty as a mispredicted conditional branch instruction."
> +  },
> +  {
> +    "EventName": "ex_ret_brn_ind_misp",
> +    "EventCode": "0xca",
> +    "BriefDescription": "Retired Indirect Branch Instructions Mispredicted.",
> +    "PublicDescription": "Retired Indirect Branch Instructions Mispredicted."

Please remove the redundant PublicDescription.

> +  },
> +  {
> +    "EventName": "ex_ret_mmx_fp_instr.sse_instr",
> +    "EventCode": "0xcb",
> +    "BriefDescription": "SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
> +    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. SSE instructions (SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42, AVX).",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ex_ret_mmx_fp_instr.mmx_instr",
> +    "EventCode": "0xcb",
> +    "BriefDescription": "MMX instructions.",
> +    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. MMX instructions.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ex_ret_mmx_fp_instr.x87_instr",
> +    "EventCode": "0xcb",
> +    "BriefDescription": "x87 instructions.",
> +    "PublicDescription": "The number of MMX, SSE or x87 instructions retired. The UnitMask allows the selection of the individual classes of instructions as given in the table. Each increment represents one complete instruction. Since this event includes non-numeric instructions it is not suitable for measuring MFLOPS. x87 instructions.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ex_ret_cond",
> +    "EventCode": "0xd1",
> +    "BriefDescription": "Retired Conditional Branch Instructions."
> +  },
> +  {
> +    "EventName": "ex_ret_cond_misp",
> +    "EventCode": "0xd2",
> +    "BriefDescription": "Retired Conditional Branch Instructions Mispredicted."
> +  },
> +  {
> +    "EventName": "ex_div_busy",
> +    "EventCode": "0xd3",
> +    "BriefDescription": "Div Cycles Busy count."
> +  },
> +  {
> +    "EventName": "ex_div_count",
> +    "EventCode": "0xd4",
> +    "BriefDescription": "Div Op Count."
> +  },
> +  {
> +    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
> +    "EventCode": "0x1cf",
> +    "BriefDescription": "Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
> +    "PublicDescription": "Tagged IBS Ops. Number of times an op could not be tagged by IBS because of a previous tagged op that has not retired.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
> +    "EventCode": "0x1cf",
> +    "BriefDescription": "Number of Ops tagged by IBS that retired.",
> +    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS that retired.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
> +    "EventCode": "0x1cf",
> +    "BriefDescription": "Number of Ops tagged by IBS.",
> +    "PublicDescription": "Tagged IBS Ops. Number of Ops tagged by IBS.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ex_ret_fus_brnch_inst",
> +    "EventCode": "0x1d0",
> +    "BriefDescription": "Retired Fused Instructions.",
> +    "PublicDescription": "The number of fuse-branch instructions retired per cycle. The number of events logged per cycle can vary from 0-8."
> +  }

I'd merge/consolidate the PublicDescription into the BriefDescription and only keep the Briefdescription, in these four events.

> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
> new file mode 100644
> index 000000000000..bee9e5488efb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
> @@ -0,0 +1,128 @@
> +[
> +  {
> +    "EventName": "fpu_pipe_assignment.total",
> +    "EventCode": "0x00",
> +    "BriefDescription": "Total number of fp uOps.",
> +    "PublicDescription": "Total number of fp uOps. The number of operations (uOps) dispatched to each of the 4 FPU execution pipelines. This event reflects how busy the FPU pipelines are and may be used for workload characterization. This includes all operations performed by x87, MMX, and SSE instructions, including moves. Each increment represents a one- cycle dispatch event. This event is a speculative event. Since this event includes non-numeric operations it is not suitable for measuring MFLOPS.",
> +    "UMask": "0xf"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.all",
> +    "EventCode": "0x03",
> +    "BriefDescription": "All FLOPS.",
> +    "PublicDescription": "All FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.mac_flops",
> +    "EventCode": "0x03",
> +    "BriefDescription": "Multiply-add FLOPS. Multiply-add counts as 2 FLOPS.",
> +    "PublicDescription": "This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.Multiply-add counts as 2 FLOPS.",

Need a space(s) after '15.', and the public description doesn't have
a "Multiply-add FLOPS." in it.  Pretty sure I'd do the consolidation
trick here, too.

> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.div_flops",
> +    "EventCode": "0x03",
> +    "BriefDescription": "Divide/square root FLOPS.",
> +    "PublicDescription": "Divide/square root FLOPS.This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",

Needs a space after that first "FLOPS."

Also the before/after concatentation convention changed between here
and the last one: pick one and be consistent across the board.

> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.mult_flops",
> +    "EventCode": "0x03",
> +    "BriefDescription": "Multiply FLOPS.",
> +    "PublicDescription": "Multiply FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
> +    "EventCode": "0x03",
> +    "BriefDescription": "Add/subtract FLOPS.",
> +    "PublicDescription": "Add/subtract FLOPS. This is a retire-based event. The number of retired SSE/AVX FLOPS. The number of events logged per cycle can vary from 0 to 64. This event can count above 15.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "fp_num_mov_elim_scal_op.optimized",
> +    "EventCode": "0x04",
> +    "BriefDescription": "Number of Scalar Ops optimized.",
> +    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Scalar Ops optimized.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fp_num_mov_elim_scal_op.opt_potential",
> +    "EventCode": "0x04",
> +    "BriefDescription": "Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
> +    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of Ops that are candidates for optimization (have Z-bit either set or pass).",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops_elim",
> +    "EventCode": "0x04",
> +    "BriefDescription": "Number of SSE Move Ops eliminated.",
> +    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops eliminated.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fp_num_mov_elim_scal_op.sse_mov_ops",
> +    "EventCode": "0x04",
> +    "BriefDescription": "Number of SSE Move Ops.",
> +    "PublicDescription": "This is a dispatch based speculative event, and is useful for measuring the effectiveness of the Move elimination and Scalar code optimization schemes. Number of SSE Move Ops.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "fp_retired_ser_ops.sse_bot_ret",
> +    "EventCode": "0x05",
> +    "BriefDescription": "SSE bottom-executing uOps retired.",
> +    "PublicDescription": "The number of serializing Ops retired. SSE bottom-executing uOps retired.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fp_retired_ser_ops.sse_ctrl_ret",
> +    "EventCode": "0x05",
> +    "BriefDescription": "SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
> +    "PublicDescription": "The number of serializing Ops retired. SSE control word mispredict traps due to mispredictions in RC, FTZ or DAZ, or changes in mask bits.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fp_retired_ser_ops.x87_bot_ret",
> +    "EventCode": "0x05",
> +    "BriefDescription": "x87 bottom-executing uOps retired.",
> +    "PublicDescription": "The number of serializing Ops retired. x87 bottom-executing uOps retired.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fp_retired_ser_ops.x87_ctrl_ret",
> +    "EventCode": "0x05",
> +    "BriefDescription": "x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
> +    "PublicDescription": "The number of serializing Ops retired. x87 control word mispredict traps due to mispredictions in RC or PC, or changes in mask bits.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "fp_disp_faults.ymm_spill_fault",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "YMM spill fault.",
> +    "PublicDescription": "Floating Point Dispatch Faults.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "fp_disp_faults.ymm_fill_fault",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "YMM fill fault.",
> +    "PublicDescription": "Floating Point Dispatch Faults.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "fp_disp_faults.xmm_fill_fault",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "XMM fill fault.",
> +    "PublicDescription": "Floating Point Dispatch Faults.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "fp_disp_faults.x87_fill_fault",
> +    "EventCode": "0x0e",
> +    "BriefDescription": "x87 fill fault.",
> +    "PublicDescription": "Floating Point Dispatch Faults.",
> +    "UMask": "0x1"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/memory.json b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
> new file mode 100644
> index 000000000000..cde7ded41232
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/memory.json
> @@ -0,0 +1,343 @@
> +[
> +  {
> +    "EventName": "ls_bad_status2.stli_other",
> +    "EventCode": "0x24",
> +    "BriefDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons.",
> +    "PublicDescription": "Non-forwardable conflict; used to reduce STLI's via software. All reasons. Store To Load Interlock (STLI) are loads that were unable to complete because of a possible match with an older store, and the older store could not do STLF for some reason. There are a number of reasons why this occurs, and this perfmon organizes them into three major groups. ",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_locks.spec_lock_hi_spec",
> +    "EventCode": "0x25",
> +    "BriefDescription": "High speculative cacheable lock speculation succeeded.",
> +    "PublicDescription": "Retired lock instructions. High speculative cacheable lock speculation succeeded.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_locks.spec_lock_lo_spec",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Low speculative cacheable lock speculation succeeded.",
> +    "PublicDescription": "Retired lock instructions. Low speculative cacheable lock speculation succeeded.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_locks.non_spec_lock",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Non-speculative lock succeeded.",
> +    "PublicDescription": "Retired lock instructions. Non-speculative lock succeeded.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_locks.bus_lock",
> +    "EventCode": "0x25",
> +    "BriefDescription": "Comparable to legacy bus lock.",
> +    "PublicDescription": "Retired lock instructions. Bus lock when a locked operations crosses a cache boundary or is done on an uncacheable memory type. Comparable to legacy bus lock.",
> +    "UMask": "0x1"
> +  },

Consolidation could occur for all the above events, too.

> +  {
> +    "EventName": "ls_ret_cl_flush",
> +    "EventCode": "0x26",
> +    "BriefDescription": "Number of retired CLFLUSH instructions."
> +  },
> +  {
> +    "EventName": "ls_ret_cpuid",
> +    "EventCode": "0x27",
> +    "BriefDescription": "Number of retired CPUID instructions."
> +  },
> +  {
> +    "EventName": "ls_dispatch.ld_st_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of single ops that do load/store to an address.",
> +    "PublicDescription": "Dispatch of a single op that performs a load from and store to the same memory address. Number of single ops that do load/store to an address.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_dispatch.store_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of stores dispatched.",
> +    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Number of stores dispatched.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_dispatch.ld_dispatch",
> +    "EventCode": "0x29",
> +    "BriefDescription": "Number of loads dispatched.",
> +    "PublicDescription": "Counts the number of operations dispatched to the LS unit. Unit Masks ADDed. Number of loads dispatched.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_smi_rx",
> +    "EventCode": "0x2B",
> +    "BriefDescription": "Number of SMIs received."
> +  },
> +  {
> +    "EventName": "ls_int_taken",
> +    "EventCode": "0x2C",
> +    "BriefDescription": "Number of interrupts taken."
> +  },
> +  {
> +    "EventName": "ls_rdtsc",
> +    "EventCode": "0x2D",
> +    "BriefDescription": "Number of reads of the TSC (RDTSC instructions). The count is speculative."
> +  },
> +  {
> +    "EventName": "ls_stlf",
> +    "EventCode": "0x35",
> +    "BriefDescription": "Number of STLF hits."
> +  },
> +  {
> +    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
> +    "EventCode": "0x37",
> +    "BriefDescription": "A non-cacheable store and the non-cacheable commit buffer is full."
> +  },
> +  {
> +    "EventName": "ls_dc_accesses",
> +    "EventCode": "0x40",
> +    "BriefDescription": "Number of accesses to the dcache for load/store references.",
> +    "PublicDescription": "The number of accesses to the data cache for load and store references. This may include certain microcode scratchpad accesses, although these are generally rare. Each increment represents an eight-byte access, although the instruction may only be accessing a portion of that. This event is a speculative event."
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.dc_prefetcher",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache prefetcher miss.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.stores",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache store miss.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_mab_alloc.loads",
> +    "EventCode": "0x41",
> +    "BriefDescription": "Data cache load miss.",
> +    "UMask": "0x1"
> +  },

I thought we agreed to call these LS MAB Allocates by Type", like the text in the
later PPR for AMD Family 17h Model 31h B0 - 55803 Rev 0.54 - Sep 12, 2019?

DC Miss By Type is probably less correct given the MAB != DC, and the name of
the event is "LsMabAlloc".

FWIW, a MAB is a Miss address buffer (seen in the Model 71h PPR's MCA_CTL_LS
register definition).

> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from different die.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_rmt_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_dram",
> +    "EventCode": "0x43",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_cache",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_refills_from_sys.ls_mabresp_lcl_l2",
> +    "EventCode": "0x43",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Demand Data Cache Fills by Data Source. Local L2 hit.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.all",
> +    "EventCode": "0x45",
> +    "BriefDescription": "All L1 DTLB Misses or Reloads.",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that miss in the L2 TLB.",
> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that miss in the L2 TLB.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload coalesced page miss.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that miss the L2 TLB.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 1G page that hit in the L2 TLB.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 2M page that hit in the L2 TLB.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload hit a coalesced page.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
> +    "EventCode": "0x45",
> +    "BriefDescription": "L1 DTLB Miss. DTLB reload to a 4K page that hit in the L2 TLB.",
> +    "UMask": "0x1"
> +  },

Good job fixing those up!

> +  {
> +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_iside",
> +    "EventCode": "0x46",
> +    "BriefDescription": "Tablewalker allocation.",
> +    "PublicDescription": "Tablewalker allocation.",
> +    "UMask": "0xc"
> +  },
> +  {
> +    "EventName": "ls_tablewalker.perf_mon_tablewalk_alloc_dside",
> +    "EventCode": "0x46",
> +    "BriefDescription": "Tablewalker allocation.",
> +    "PublicDescription": "Tablewalker allocation.",
> +    "UMask": "0x3"
> +  },

I see each of the two tablewalkers got consolidated into their own
unit mask groups?  Any reason we couldn't leave the original
instances there, and add these in addition?  In any case we'd need
clarification of which 'side' are the both counting - I or D - in
a single BriefDescription here.

> +  {
> +    "EventName": "ls_misal_accesses",
> +    "EventCode": "0x47",
> +    "BriefDescription": "Misaligned loads."
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative).",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp.prefetch_nta",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). PrefetchNTA instruction. See docAPM3 PREFETCHlevel.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp.prefetch_w",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). See docAPM3 PREFETCHW.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_pref_instr_disp.prefetch",
> +    "EventCode": "0x4b",
> +    "BriefDescription": "Software Prefetch Instructions Dispatched (Speculative). Prefetch_T0_T1_T2. PrefetchT0, T1 and T2 instructions. See docAPM3 PREFETCHlevel.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
> +    "EventCode": "0x52",
> +    "BriefDescription": "Ineffective Software Prefetches. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
> +    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a match on an already-allocated miss request buffer.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
> +    "EventCode": "0x52",
> +    "BriefDescription": "Ineffective Software Prefetches. Software PREFETCH instruction saw a DC hit.",
> +    "PublicDescription": "The number of software prefetches that did not fetch data outside of the processor core. Software PREFETCH instruction saw a DC hit.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_dram",
> +    "EventCode": "0x59",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source. DRAM or IO from different die.",

Can we make this one BriefDescription with PublicDescription's content?  Same for all these:

> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_rmt_cache",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_dram",
> +    "EventCode": "0x59",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_cache",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_sw_pf_dc_fill.ls_mabresp_lcl_l2",
> +    "EventCode": "0x59",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Software Prefetch Data Cache Fills by Data Source. Local L2 hit.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_dram",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "DRAM or IO from different die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source. DRAM or IO from different die.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_rmt_cache",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source. Hit in cache; Remote CCX and the address's Home Node is on a different die.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_dram",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "DRAM or IO from this thread's die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source. DRAM or IO from this thread's die.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_cache",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source. Hit in cache; local CCX (not Local L2), or Remote CCX and the address's Home Node is on this thread's die.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "ls_hw_pf_dc_fill.ls_mabresp_lcl_l2",
> +    "EventCode": "0x5A",
> +    "BriefDescription": "Local L2 hit.",
> +    "PublicDescription": "Hardware Prefetch Data Cache Fills by Data Source. Local L2 hit.",
> +    "UMask": "0x1"
> +  },

Up to here.

> +  {
> +    "EventName": "ls_not_halted_cyc",
> +    "EventCode": "0x76",
> +    "BriefDescription": "Cycles not in Halt."
> +  },
> +  {
> +    "EventName": "ls_tlb_flush",
> +    "EventCode": "0x78",
> +    "BriefDescription": "All TLB Flushes"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/other.json b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
> new file mode 100644
> index 000000000000..565f140e10eb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/amdzen2/other.json
> @@ -0,0 +1,129 @@
> +[
> +  {
> +    "EventName": "de_dis_uop_queue_empty_di0",
> +    "EventCode": "0xa9",
> +    "BriefDescription": "Cycles where the Micro-Op Queue is empty."
> +  },
> +  {
> +    "EventName": "de_dis_uops_from_decoder",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Ops dispatched from either the decoders, OpCache or both.",
> +    "UMask": "0xff"
> +  },
> +  {
> +    "EventName": "de_dis_uops_from_decoder.opcache_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Count of dispatched Ops from OpCache.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "de_dis_uops_from_decoder.decoder_dispatched",
> +    "EventCode": "0xaa",
> +    "BriefDescription": "Count of dispatched Ops from Decoder.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_misc_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "FP Miscellaneous resource unavailable. Applies to the recovery of mispredicts with FP ops",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP Miscellaneous resource unavailable. Applies to the recovery of mispredicts with FP ops",

Another case where it's hard to make out what the event is counting
in general: Make its PublicDescription a single Breifdescription?
This comment applies to the group:

> +    "UMask": "0x80"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_sch_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "FP scheduler resource stall. Applies to ops that use the FP scheduler.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. FP scheduler resource stall. Applies to ops that use the FP scheduler.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.fp_reg_file_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Floating point register file resource stall. Applies to all FP ops that have a destination register.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Floating point register file resource stall. Applies to all FP ops that have a destination register.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.taken_branch_buffer_rsrc_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Taken branch buffer resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Taken branch buffer resource stall.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.int_sched_misc_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Integer Scheduler miscellaneous resource stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Scheduler miscellaneous resource stall.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.store_queue_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Store queue resource stall. Applies to all ops with store semantics.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Store queue resource stall. Applies to all ops with store semantics.",
> +    "UMask": "0x4"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.load_queue_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Load queue resource stall. Applies to all ops with load semantics.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Load queue resource stall. Applies to all ops with load semantics.",
> +    "UMask": "0x2"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls1.int_phy_reg_file_token_stall",
> +    "EventCode": "0xae",
> +    "BriefDescription": "Integer Physical Register File resource stall. Applies to all ops that have an integer destination register.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. Integer Physical Register File resource stall. Applies to all ops that have an integer destination register.",
> +    "UMask": "0x1"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.sc_agu_dispatch_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "SC AGU dispatch stall.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. SC AGU dispatch stall.",
> +    "UMask": "0x40"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.retire_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "RETIRE Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. RETIRE Tokens unavailable.",
> +    "UMask": "0x20"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.agsq_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "AGSQ Tokens unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. AGSQ Tokens unavailable.",
> +    "UMask": "0x10"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alu_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "ALU tokens total unavailable.",
> +    "PublicDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALU tokens total unavailable.",
> +    "UMask": "0x8"
> +  },
> +  {
> +    "EventName": "de_dis_dispatch_token_stalls0.alsq3_0_token_stall",
> +    "EventCode": "0xaf",
> +    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a token stall. ALSQ3_0_TokenStall.",
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
> +]

I'll take a look at the other two tomorrow.

Thanks,

Kim
