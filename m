Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F2C432BE
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 07:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DADB60E09
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 07:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbhG2HMG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 03:12:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:59735 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhG2HMG (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 03:12:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="199998390"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="199998390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 00:12:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="518075784"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 00:12:01 -0700
Subject: Re: [PATCH v3] perf vendor events: Add metrics for Icelake Server
To:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
References: <20210721070702.2075-1-yao.jin@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <2811bea3-4589-2f76-83b4-83b91f4db1c6@linux.intel.com>
Date:   Thu, 29 Jul 2021 15:11:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210721070702.2075-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

Can you kindly pick up this patch?

Thanks
Jin Yao

On 7/21/2021 3:07 PM, Jin Yao wrote:
> Add JSON metrics for Icelake Server to perf.
> 
> Based on TMA metrics 4.21 at 01.org.
> https://download.01.org/perfmon/
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v3:
>   - PMU cstate_core and cstate_pkg are supported for ICX since 5.14-rc1,
>     add cstate metrics for Core C1/C6 and Package C2/C6.
> 
> v2:
>   - Fix perf test 10 error.
> 
>     # ./perf test 10
>     10: PMU events                                                      :
>     10.1: PMU event table sanity                                        : Ok
>     10.2: PMU event map aliases                                         : Ok
>     10.3: Parsing of PMU event table metrics                            : Ok
>     10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> 
>   - Remove cstate metrics because the kernel has not supported
>     cstate_core and cstate_core for Icelake server.
> 
>   - Remove the topdown L1/L2 metrics.
> 
>   .../arch/x86/icelakex/icx-metrics.json        | 315 ++++++++++++++++++
>   1 file changed, 315 insertions(+)
>   create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> 
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> new file mode 100644
> index 000000000000..0731459cdded
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -0,0 +1,315 @@
> +[
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Summary",
> +        "MetricName": "IPC"
> +    },
> +    {
> +        "BriefDescription": "Uops Per Instruction",
> +        "MetricExpr": "UOPS_RETIRED.SLOTS / INST_RETIRED.ANY",
> +        "MetricGroup": "Pipeline;Retire",
> +        "MetricName": "UPI"
> +    },
> +    {
> +        "BriefDescription": "Instruction per taken branch",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
> +        "MetricGroup": "Branches;FetchBW;PGO",
> +        "MetricName": "IpTB"
> +    },
> +    {
> +        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
> +        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CPI"
> +    },
> +    {
> +        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is active.",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per physical core)",
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "SMT;TmaL1",
> +        "MetricName": "CoreIPC"
> +    },
> +    {
> +        "BriefDescription": "Floating Point Operations Per Cycle",
> +        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "Flops",
> +        "MetricName": "FLOPc"
> +    },
> +    {
> +        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when there is at least 1 uop executed)",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 )",
> +        "MetricGroup": "Pipeline;PortsUtil",
> +        "MetricName": "ILP"
> +    },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction (JEClear)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "BrMispredicts",
> +        "MetricName": "IpMispredict"
> +    },
> +    {
> +        "BriefDescription": "Core actual clocks when any Logical Processor is active on the Physical Core",
> +        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "SMT",
> +        "MetricName": "CORE_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpLoad"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpStore"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Branches;InsType",
> +        "MetricName": "IpBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per (near) call (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> +        "MetricGroup": "Branches",
> +        "MetricName": "IpCall"
> +    },
> +    {
> +        "BriefDescription": "Branch instructions per taken branch. ",
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
> +        "MetricGroup": "Branches;PGO",
> +        "MetricName": "BpTkBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Floating Point (FP) Operation (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
> +        "MetricGroup": "Flops;FpArith;InsType",
> +        "MetricName": "IpFLOP"
> +    },
> +    {
> +        "BriefDescription": "Total number of retired Instructions, Sample with: INST_RETIRED.PREC_DIST",
> +        "MetricExpr": "INST_RETIRED.ANY",
> +        "MetricGroup": "Summary;TmaL1",
> +        "MetricName": "Instructions"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop Stream Detector; aka Loop Cache)",
> +        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
> +        "MetricGroup": "LSD",
> +        "MetricName": "LSD_Coverage"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop Cache)",
> +        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
> +        "MetricGroup": "DSB;FetchBW",
> +        "MetricName": "DSB_Coverage"
> +    },
> +    {
> +        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core cycles)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS + MEM_LOAD_RETIRED.FB_HIT )",
> +        "MetricGroup": "MemoryBound;MemoryLat",
> +        "MetricName": "Load_Miss_Real_Latency"
> +    },
> +    {
> +        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when there is at least one such miss. Per-Logical Processor)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
> +        "MetricGroup": "MemoryBound;MemoryBW",
> +        "MetricName": "MLP"
> +    },
> +    {
> +        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses triggered by instruction/Load/Store accesses",
> +        "MetricConstraint": "NO_NMI_WATCHDOG",
> +        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED )",
> +        "MetricGroup": "MemoryTLB",
> +        "MetricName": "Page_Walks_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
> +        "MetricGroup": "MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L1MPKI"
> +    },
> +    {
> +        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L2MPKI"
> +    },
> +    {
> +        "BriefDescription": "L2 cache misses per kilo instruction for all request types (including speculative)",
> +        "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUESTS.DEMAND_DATA_RD ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS ) / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses;Offcore",
> +        "MetricName": "L2MPKI_All"
> +    },
> +    {
> +        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L3MPKI"
> +    },
> +    {
> +        "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction where the evicted lines are dropped (no writeback to L3 or memory)",
> +        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
> +        "MetricGroup": "L2Evicts;Server",
> +        "MetricName": "L2_Evictions_Silent_PKI"
> +    },
> +    {
> +        "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
> +        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
> +        "MetricGroup": "L2Evicts;Server",
> +        "MetricName": "L2_Evictions_NonSilent_PKI"
> +    },
> +    {
> +        "BriefDescription": "Average CPU Utilization",
> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
> +        "MetricGroup": "HPC;Summary",
> +        "MetricName": "CPU_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
> +        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ / 1000000000 / duration_time",
> +        "MetricGroup": "Summary;Power",
> +        "MetricName": "Average_Frequency"
> +    },
> +    {
> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> +        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
> +        "MetricGroup": "Flops;HPC",
> +        "MetricName": "GFLOPs"
> +    },
> +    {
> +        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
> +        "MetricGroup": "Power",
> +        "MetricName": "Turbo_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
> +        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_DISTRIBUTED",
> +        "MetricGroup": "SMT",
> +        "MetricName": "SMT_2T_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "OS",
> +        "MetricName": "Kernel_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> +        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "MetricGroup": "HPC;MemoryBW;SoC",
> +        "MetricName": "DRAM_BW_Use"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
> +        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( cha_0@event\\=0x0@ / duration_time )",
> +        "MetricGroup": "MemoryLat;SoC",
> +        "MetricName": "MEM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
> +        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@event\\=0x36\\,umask\\=0xC817FE01\\,thresh\\=1@",
> +        "MetricGroup": "MemoryBW;SoC",
> +        "MetricName": "MEM_Parallel_Reads"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to external 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
> +        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / cha_0@event\\=0x0@ )",
> +        "MetricGroup": "MemoryLat;SoC;Server",
> +        "MetricName": "MEM_PMM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
> +        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Read_BW"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
> +        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Writes [GB / sec]",
> +        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000 / duration_time",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Reads [GB / sec]",
> +        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 / 1000000000 / duration_time",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Read_BW"
> +    },
> +    {
> +        "BriefDescription": "Socket actual clocks when any core is active on that socket",
> +        "MetricExpr": "cha_0@event\\=0x0@",
> +        "MetricGroup": "SoC",
> +        "MetricName": "Socket_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition from application to operating system, handling interrupts, exceptions) [lower number means higher occurrence rate]",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
> +        "MetricGroup": "Branches;OS",
> +        "MetricName": "IpFarBranch"
> +    },
> +    {
> +        "BriefDescription": "C1 residency percent per core",
> +        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C1_Core_Residency"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per core",
> +        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Core_Residency"
> +    },
> +    {
> +        "BriefDescription": "C2 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C2_Pkg_Residency"
> +    },
> +    {
> +        "BriefDescription": "C6 residency percent per package",
> +        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
> +        "MetricGroup": "Power",
> +        "MetricName": "C6_Pkg_Residency"
> +    },
> +]
> 
