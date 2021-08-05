Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAD3C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 05:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE626104F
	for <linux-perf-users@archiver.kernel.org>; Thu,  5 Aug 2021 05:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhHEFKH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 01:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhHEFKH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 5 Aug 2021 01:10:07 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064AC0613C1
        for <linux-perf-users@vger.kernel.org>; Wed,  4 Aug 2021 22:09:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i9so3896562ilk.9
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Aug 2021 22:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLfHCBzhWspSz89yEd2d6Yhkofxn0jaZYYRAohcSOnU=;
        b=ke+GMeIplRY147dLOKHD03hrKNbDWCcBb2mKNtB8u+7fpOtiXp5oWfXLBpyaHE8Dve
         TGkVr412GMkfR2NhR+bPfYVx5D1xt9g3kCXl5GpgH2JamPlsSn6vKyTh4DPZ2kauFcyg
         sglKpztKkkumZJVoDe7aF7OpzJoylPL/Q8P/p2MsPocTfjusaCqIQZV+mx2GVRJoda6a
         KLDcYdo7z8LcCwkoS7mQ71FX6ZMEmuqjs7snoom9zo6FXRN6PtbM/K2SZnabyp3x2y+S
         2U4rV2LeEnzizoT7TE7fAn/9F5t6bwzjKGOgsz7SntZWvMD+HzDTTG657rFYI8Q5QYpw
         yOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLfHCBzhWspSz89yEd2d6Yhkofxn0jaZYYRAohcSOnU=;
        b=uV4UjWdxb4H4rj4oZ9IqqoO/4249WpiTEYaZbcWiz3B6hxwmePpm0v3kO6PmxcsJzd
         QQUSxSEX1AVkpozqqQvLxwwyCsCS2bH5cBMzQepf0qiHCqqORgaX7gA0UJXV39BiBhiJ
         qJ0+lPCL8NwG+/t4TKK1s6KjioAg2ZeIUNbdPx5nH/lOusDYARcgfK0T3yC7nLiz4Z/O
         zOJKJLbSifZuQNmtpXzFwD1wMyoFwZD3hufDgrwJ7m5q2+BLTVDMXqcktDWqK0RuyOIJ
         zbtSs6AfkdBSPFKYz7dMNcxsQgR6gtlFgt4ok5OT8HGqmWS5OK2ep7qb6l4WsE82ED1F
         vEpw==
X-Gm-Message-State: AOAM530q4VaLosz7j93EpFTfHqhiY7aYn7PSIudfwENyNGSDktgwYEVC
        qCRJX6xzbgH8wsiNxuJKl/g2A5Ouu5sTUy/7H9wDcQ==
X-Google-Smtp-Source: ABdhPJyZL7Q8FbEicRvTBjlpym8fABfeCPDTidsCNIRuAxvLJR+20V9COKw+bnv1Pl79rjuFtLnWQpijs5C2Y1CCMT0=
X-Received: by 2002:a92:4a0d:: with SMTP id m13mr40062ilf.129.1628140192078;
 Wed, 04 Aug 2021 22:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210721070702.2075-1-yao.jin@linux.intel.com>
 <2811bea3-4589-2f76-83b4-83b91f4db1c6@linux.intel.com> <85e07b9a-c826-b4cc-188a-4e735d7342bc@linux.intel.com>
In-Reply-To: <85e07b9a-c826-b4cc-188a-4e735d7342bc@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 Aug 2021 22:09:40 -0700
Message-ID: <CAP-5=fUGzso7f2rGG5_YkuOr72qY5EmkckDsayb47vLHxhJ9FQ@mail.gmail.com>
Subject: Re: [PATCH v3] perf vendor events: Add metrics for Icelake Server
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Content-Type: multipart/mixed; boundary="000000000000cba27505c8c8ed3b"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

--000000000000cba27505c8c8ed3b
Content-Type: text/plain; charset="UTF-8"

On Wed, Aug 4, 2021 at 6:18 PM Jin, Yao <yao.jin@linux.intel.com> wrote:
>
> Hi Andi,
>
> I guess Arnaldo needs your ACK before consider picking up this patch.
>
> Can you give an ACK for this patch?
>
> Thanks
> Jin Yao
>
> On 7/29/2021 3:11 PM, Jin, Yao wrote:
> > Hi Arnaldo,
> >
> > Can you kindly pick up this patch?
> >
> > Thanks
> > Jin Yao
> >
> > On 7/21/2021 3:07 PM, Jin Yao wrote:
> >> Add JSON metrics for Icelake Server to perf.
> >>
> >> Based on TMA metrics 4.21 at 01.org.
> >> https://download.01.org/perfmon/
> >>
> >> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> >> ---
> >> v3:
> >>   - PMU cstate_core and cstate_pkg are supported for ICX since 5.14-rc1,
> >>     add cstate metrics for Core C1/C6 and Package C2/C6.
> >>
> >> v2:
> >>   - Fix perf test 10 error.
> >>
> >>     # ./perf test 10
> >>     10: PMU events                                                      :
> >>     10.1: PMU event table sanity                                        : Ok
> >>     10.2: PMU event map aliases                                         : Ok
> >>     10.3: Parsing of PMU event table metrics                            : Ok
> >>     10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
> >>
> >>   - Remove cstate metrics because the kernel has not supported
> >>     cstate_core and cstate_core for Icelake server.
> >>
> >>   - Remove the topdown L1/L2 metrics.
> >>
> >>   .../arch/x86/icelakex/icx-metrics.json        | 315 ++++++++++++++++++
> >>   1 file changed, 315 insertions(+)
> >>   create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >>
> >> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> new file mode 100644
> >> index 000000000000..0731459cdded
> >> --- /dev/null
> >> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> >> @@ -0,0 +1,315 @@
> >> +[
> >> +    {
> >> +        "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
> >> +        "MetricGroup": "Summary",
> >> +        "MetricName": "IPC"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Uops Per Instruction",
> >> +        "MetricExpr": "UOPS_RETIRED.SLOTS / INST_RETIRED.ANY",
> >> +        "MetricGroup": "Pipeline;Retire",
> >> +        "MetricName": "UPI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instruction per taken branch",
> >> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_TAKEN",
> >> +        "MetricGroup": "Branches;FetchBW;PGO",
> >> +        "MetricName": "IpTB"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Cycles Per Instruction (per Logical Processor)",
> >> +        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)",

Hi,

I'm not sure what's happening but when I generate this using:
https://github.com/intel/event-converter-for-linux-perf

I see here:
        "MetricExpr": "1 / IPC",

There are various other differences and so I've included the generated file.

Thanks,
Ian


> >> +        "MetricGroup": "Pipeline",
> >> +        "MetricName": "CPI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Per-Logical Processor actual clocks when the Logical Processor is
> >> active.",
> >> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> >> +        "MetricGroup": "Pipeline",
> >> +        "MetricName": "CLKS"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions Per Cycle (per physical core)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
> >> +        "MetricGroup": "SMT;TmaL1",
> >> +        "MetricName": "CoreIPC"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Floating Point Operations Per Cycle",
> >> +        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
> >> FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * (
> >> FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * (
> >> FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 *
> >> FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
> >> +        "MetricGroup": "Flops",
> >> +        "MetricName": "FLOPc"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instruction-Level-Parallelism (average number of uops executed when
> >> there is at least 1 uop executed)",
> >> +        "MetricExpr": "UOPS_EXECUTED.THREAD / ( UOPS_EXECUTED.CORE_CYCLES_GE_1 / 2 )",
> >> +        "MetricGroup": "Pipeline;PortsUtil",
> >> +        "MetricName": "ILP"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Number of Instructions per non-speculative Branch Misprediction
> >> (JEClear)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> >> +        "MetricGroup": "BrMispredicts",
> >> +        "MetricName": "IpMispredict"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Core actual clocks when any Logical Processor is active on the
> >> Physical Core",
> >> +        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> >> +        "MetricGroup": "SMT",
> >> +        "MetricName": "CORE_CLKS"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per Load (lower number means higher occurrence rate)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> >> +        "MetricGroup": "InsType",
> >> +        "MetricName": "IpLoad"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per Store (lower number means higher occurrence rate)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> >> +        "MetricGroup": "InsType",
> >> +        "MetricName": "IpStore"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per Branch (lower number means higher occurrence rate)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> >> +        "MetricGroup": "Branches;InsType",
> >> +        "MetricName": "IpBranch"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per (near) call (lower number means higher occurrence
> >> rate)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> >> +        "MetricGroup": "Branches",
> >> +        "MetricName": "IpCall"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Branch instructions per taken branch. ",
> >> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NEAR_TAKEN",
> >> +        "MetricGroup": "Branches;PGO",
> >> +        "MetricName": "BpTkBranch"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per Floating Point (FP) Operation (lower number means
> >> higher occurrence rate)",
> >> +        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
> >> FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * (
> >> FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * (
> >> FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 *
> >> FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE )",
> >> +        "MetricGroup": "Flops;FpArith;InsType",
> >> +        "MetricName": "IpFLOP"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Total number of retired Instructions, Sample with:
> >> INST_RETIRED.PREC_DIST",
> >> +        "MetricExpr": "INST_RETIRED.ANY",
> >> +        "MetricGroup": "Summary;TmaL1",
> >> +        "MetricName": "Instructions"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop Stream Detector; aka
> >> Loop Cache)",
> >> +        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
> >> +        "MetricGroup": "LSD",
> >> +        "MetricName": "LSD_Coverage"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka Decoded ICache; or Uop
> >> Cache)",
> >> +        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UOPS + IDQ.MS_UOPS)",
> >> +        "MetricGroup": "DSB;FetchBW",
> >> +        "MetricName": "DSB_Coverage"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Actual Average Latency for L1 data-cache miss demand loads (in core
> >> cycles)",
> >> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MISS +
> >> MEM_LOAD_RETIRED.FB_HIT )",
> >> +        "MetricGroup": "MemoryBound;MemoryLat",
> >> +        "MetricName": "Load_Miss_Real_Latency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Memory-Level-Parallelism (average number of L1 miss demand load when
> >> there is at least one such miss. Per-Logical Processor)",
> >> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYCLES",
> >> +        "MetricGroup": "MemoryBound;MemoryBW",
> >> +        "MetricName": "MLP"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Utilization of the core's Page Walker(s) serving STLB misses
> >> triggered by instruction/Load/Store accesses",
> >> +        "MetricConstraint": "NO_NMI_WATCHDOG",
> >> +        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WALK_PENDING +
> >> DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTRIBUTED )",
> >> +        "MetricGroup": "MemoryTLB",
> >> +        "MetricName": "Page_Walks_Utilization"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average data fill bandwidth to the L1 data cache [GB / sec]",
> >> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time",
> >> +        "MetricGroup": "MemoryBW",
> >> +        "MetricName": "L1D_Cache_Fill_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average data fill bandwidth to the L2 cache [GB / sec]",
> >> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time",
> >> +        "MetricGroup": "MemoryBW",
> >> +        "MetricName": "L2_Cache_Fill_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average per-core data fill bandwidth to the L3 cache [GB / sec]",
> >> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / duration_time",
> >> +        "MetricGroup": "MemoryBW",
> >> +        "MetricName": "L3_Cache_Fill_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average per-core data access bandwidth to the L3 cache [GB / sec]",
> >> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 / duration_time",
> >> +        "MetricGroup": "MemoryBW;Offcore",
> >> +        "MetricName": "L3_Cache_Access_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "L1 cache true misses per kilo instruction for retired demand loads",
> >> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.ANY",
> >> +        "MetricGroup": "CacheMisses",
> >> +        "MetricName": "L1MPKI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "L2 cache true misses per kilo instruction for retired demand loads",
> >> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.ANY",
> >> +        "MetricGroup": "CacheMisses",
> >> +        "MetricName": "L2MPKI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "L2 cache misses per kilo instruction for all request types
> >> (including speculative)",
> >> +        "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE_REQUESTS.DEMAND_DATA_RD
> >> ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS ) / INST_RETIRED.ANY",
> >> +        "MetricGroup": "CacheMisses;Offcore",
> >> +        "MetricName": "L2MPKI_All"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "L3 cache true misses per kilo instruction for retired demand loads",
> >> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.ANY",
> >> +        "MetricGroup": "CacheMisses",
> >> +        "MetricName": "L3MPKI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Rate of silent evictions from the L2 cache per Kilo instruction
> >> where the evicted lines are dropped (no writeback to L3 or memory)",
> >> +        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
> >> +        "MetricGroup": "L2Evicts;Server",
> >> +        "MetricName": "L2_Evictions_Silent_PKI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Rate of non silent evictions from the L2 cache per Kilo instruction",
> >> +        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY",
> >> +        "MetricGroup": "L2Evicts;Server",
> >> +        "MetricName": "L2_Evictions_NonSilent_PKI"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average CPU Utilization",
> >> +        "MetricExpr": "CPU_CLK_UNHALTED.REF_TSC / msr@tsc@",
> >> +        "MetricGroup": "HPC;Summary",
> >> +        "MetricName": "CPU_Utilization"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Measured Average Frequency for unhalted processors [GHz]",
> >> +        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC) * msr@tsc@ /
> >> 1000000000 / duration_time",
> >> +        "MetricGroup": "Summary;Power",
> >> +        "MetricName": "Average_Frequency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> >> +        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE +
> >> FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE + 4 * (
> >> FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * (
> >> FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 *
> >> FP_ARITH_INST_RETIRED.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
> >> +        "MetricGroup": "Flops;HPC",
> >> +        "MetricName": "GFLOPs"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average Frequency Utilization relative nominal frequency",
> >> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TSC",
> >> +        "MetricGroup": "Power",
> >> +        "MetricName": "Turbo_Utilization"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Fraction of cycles where both hardware Logical Processors were active",
> >> +        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_UNHALTED.REF_DISTRIBUTED",
> >> +        "MetricGroup": "SMT",
> >> +        "MetricName": "SMT_2T_Utilization"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Fraction of cycles spent in the Operating System (OS) Kernel mode",
> >> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.THREAD",
> >> +        "MetricGroup": "OS",
> >> +        "MetricName": "Kernel_Utilization"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average external Memory Bandwidth Use for reads and writes [GB / sec]",
> >> +        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@cas_count_write@ ) /
> >> 1000000000 ) / duration_time",
> >> +        "MetricGroup": "HPC;MemoryBW;SoC",
> >> +        "MetricName": "DRAM_BW_Use"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average latency of data read request to external memory (in
> >> nanoseconds). Accounts for demand loads and L1/L2 prefetches",
> >> +        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD /
> >> UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( cha_0@event\\=0x0@ / duration_time )",
> >> +        "MetricGroup": "MemoryLat;SoC",
> >> +        "MetricName": "MEM_Read_Latency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average number of parallel data read requests to external memory.
> >> Accounts for demand loads and L1/L2 prefetches",
> >> +        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD /
> >> cha@event\\=0x36\\,umask\\=0xC817FE01\\,thresh\\=1@",
> >> +        "MetricGroup": "MemoryBW;SoC",
> >> +        "MetricName": "MEM_Parallel_Reads"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average latency of data read request to external 3D X-Point memory
> >> [in nanoseconds]. Accounts for demand loads and L1/L2 data-read prefetches",
> >> +        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD_PMM /
> >> UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / cha_0@event\\=0x0@ )",
> >> +        "MetricGroup": "MemoryLat;SoC;Server",
> >> +        "MetricName": "MEM_PMM_Read_Latency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads [GB / sec]",
> >> +        "MetricExpr": "( ( 64 * imc@event\\=0xe3@ / 1000000000 ) / duration_time )",
> >> +        "MetricGroup": "MemoryBW;SoC;Server",
> >> +        "MetricName": "PMM_Read_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Writes [GB / sec]",
> >> +        "MetricExpr": "( ( 64 * imc@event\\=0xe7@ / 1000000000 ) / duration_time )",
> >> +        "MetricGroup": "MemoryBW;SoC;Server",
> >> +        "MetricName": "PMM_Write_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Writes [GB / sec]",
> >> +        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000 / duration_time",
> >> +        "MetricGroup": "IoBW;SoC;Server",
> >> +        "MetricName": "IO_Write_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use for Reads [GB / sec]",
> >> +        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_INSERTS.IO_MISS_ITOM +
> >> UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TOR_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 /
> >> 1000000000 / duration_time",
> >> +        "MetricGroup": "IoBW;SoC;Server",
> >> +        "MetricName": "IO_Read_BW"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Socket actual clocks when any core is active on that socket",
> >> +        "MetricExpr": "cha_0@event\\=0x0@",
> >> +        "MetricGroup": "SoC",
> >> +        "MetricName": "Socket_CLKS"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "Instructions per Far Branch ( Far Branches apply upon transition
> >> from application to operating system, handling interrupts, exceptions) [lower number means higher
> >> occurrence rate]",
> >> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.FAR_BRANCH:u",
> >> +        "MetricGroup": "Branches;OS",
> >> +        "MetricName": "IpFarBranch"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "C1 residency percent per core",
> >> +        "MetricExpr": "(cstate_core@c1\\-residency@ / msr@tsc@) * 100",
> >> +        "MetricGroup": "Power",
> >> +        "MetricName": "C1_Core_Residency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "C6 residency percent per core",
> >> +        "MetricExpr": "(cstate_core@c6\\-residency@ / msr@tsc@) * 100",
> >> +        "MetricGroup": "Power",
> >> +        "MetricName": "C6_Core_Residency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "C2 residency percent per package",
> >> +        "MetricExpr": "(cstate_pkg@c2\\-residency@ / msr@tsc@) * 100",
> >> +        "MetricGroup": "Power",
> >> +        "MetricName": "C2_Pkg_Residency"
> >> +    },
> >> +    {
> >> +        "BriefDescription": "C6 residency percent per package",
> >> +        "MetricExpr": "(cstate_pkg@c6\\-residency@ / msr@tsc@) * 100",
> >> +        "MetricGroup": "Power",
> >> +        "MetricName": "C6_Pkg_Residency"
> >> +    },
> >> +]
> >>

--000000000000cba27505c8c8ed3b
Content-Type: application/json; name="icx-metrics.json"
Content-Disposition: attachment; filename="icx-metrics.json"
Content-Transfer-Encoding: base64
Content-ID: <f_kryglr9s0>
X-Attachment-Id: f_kryglr9s0

WwogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIklQQyIsCiAgICAgICAgIk1ldHJpY0V4cHIi
OiAiSU5TVF9SRVRJUkVELkFOWSAvIENQVV9DTEtfVU5IQUxURUQuVEhSRUFEIiwKICAgICAgICAi
TWV0cmljR3JvdXAiOiAiU3VtbWFyeSIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiSW5z
dHJ1Y3Rpb25zIFBlciBDeWNsZSAocGVyIExvZ2ljYWwgUHJvY2Vzc29yKSIKICAgIH0sCiAgICB7
CiAgICAgICAgIk1ldHJpY05hbWUiOiAiVVBJIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJVT1BT
X1JFVElSRUQuU0xPVFMgLyBJTlNUX1JFVElSRUQuQU5ZIiwKICAgICAgICAiTWV0cmljR3JvdXAi
OiAiUGlwZWxpbmU7UmV0aXJlIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJVb3BzIFBl
ciBJbnN0cnVjdGlvbiIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiSXBUQiIs
CiAgICAgICAgIk1ldHJpY0V4cHIiOiAiSU5TVF9SRVRJUkVELkFOWSAvIEJSX0lOU1RfUkVUSVJF
RC5ORUFSX1RBS0VOIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiQnJhbmNoZXM7RmV0Y2hCVztQ
R08iLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkluc3RydWN0aW9uIHBlciB0YWtlbiBi
cmFuY2giCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIkNQSSIsCiAgICAgICAg
Ik1ldHJpY0V4cHIiOiAiMSAvIElQQyIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlBpcGVsaW5l
IiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJDeWNsZXMgUGVyIEluc3RydWN0aW9uIChw
ZXIgTG9naWNhbCBQcm9jZXNzb3IpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6
ICJDTEtTIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJDUFVfQ0xLX1VOSEFMVEVELlRIUkVBRCIs
CiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlBpcGVsaW5lIiwKICAgICAgICAiQnJpZWZEZXNjcmlw
dGlvbiI6ICJQZXItTG9naWNhbCBQcm9jZXNzb3IgYWN0dWFsIGNsb2NrcyB3aGVuIHRoZSBMb2dp
Y2FsIFByb2Nlc3NvciBpcyBhY3RpdmUuIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFt
ZSI6ICJDb3JlSVBDIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJJTlNUX1JFVElSRUQuQU5ZIC8g
Q1BVX0NMS19VTkhBTFRFRC5ESVNUUklCVVRFRCIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlNN
VDtUbWFMMSIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiSW5zdHJ1Y3Rpb25zIFBlciBD
eWNsZSAocGVyIHBoeXNpY2FsIGNvcmUpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFt
ZSI6ICJGTE9QYyIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiKCAxICogKCBGUF9BUklUSF9JTlNU
X1JFVElSRUQuU0NBTEFSX1NJTkdMRSArIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC5TQ0FMQVJfRE9V
QkxFICkgKyAyICogRlBfQVJJVEhfSU5TVF9SRVRJUkVELjEyOEJfUEFDS0VEX0RPVUJMRSArIDQg
KiAoIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC4xMjhCX1BBQ0tFRF9TSU5HTEUgKyBGUF9BUklUSF9J
TlNUX1JFVElSRUQuMjU2Ql9QQUNLRURfRE9VQkxFICkgKyA4ICogKCBGUF9BUklUSF9JTlNUX1JF
VElSRUQuMjU2Ql9QQUNLRURfU0lOR0xFICsgRlBfQVJJVEhfSU5TVF9SRVRJUkVELjUxMkJfUEFD
S0VEX0RPVUJMRSApICsgMTYgKiBGUF9BUklUSF9JTlNUX1JFVElSRUQuNTEyQl9QQUNLRURfU0lO
R0xFICkgLyBDUFVfQ0xLX1VOSEFMVEVELkRJU1RSSUJVVEVEIiwKICAgICAgICAiTWV0cmljR3Jv
dXAiOiAiRmxvcHMiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkZsb2F0aW5nIFBvaW50
IE9wZXJhdGlvbnMgUGVyIEN5Y2xlIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6
ICJJTFAiLAogICAgICAgICJNZXRyaWNFeHByIjogIlVPUFNfRVhFQ1VURUQuVEhSRUFEIC8gKCgg
VU9QU19FWEVDVVRFRC5DT1JFX0NZQ0xFU19HRV8xIC8gMiApIGlmICNTTVRfb24gZWxzZSBVT1BT
X0VYRUNVVEVELkNPUkVfQ1lDTEVTX0dFXzEpIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiUGlw
ZWxpbmU7UG9ydHNVdGlsIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJJbnN0cnVjdGlv
bi1MZXZlbC1QYXJhbGxlbGlzbSAoYXZlcmFnZSBudW1iZXIgb2YgdW9wcyBleGVjdXRlZCB3aGVu
IHRoZXJlIGlzIGF0IGxlYXN0IDEgdW9wIGV4ZWN1dGVkKSIKICAgIH0sCiAgICB7CiAgICAgICAg
Ik1ldHJpY05hbWUiOiAiSXBNaXNwcmVkaWN0IiwKICAgICAgICAiTWV0cmljRXhwciI6ICJJTlNU
X1JFVElSRUQuQU5ZIC8gQlJfTUlTUF9SRVRJUkVELkFMTF9CUkFOQ0hFUyIsCiAgICAgICAgIk1l
dHJpY0dyb3VwIjogIkJyTWlzcHJlZGljdHMiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjog
Ik51bWJlciBvZiBJbnN0cnVjdGlvbnMgcGVyIG5vbi1zcGVjdWxhdGl2ZSBCcmFuY2ggTWlzcHJl
ZGljdGlvbiAoSkVDbGVhcikiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIkNP
UkVfQ0xLUyIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiQ1BVX0NMS19VTkhBTFRFRC5ESVNUUklC
VVRFRCIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlNNVCIsCiAgICAgICAgIkJyaWVmRGVzY3Jp
cHRpb24iOiAiQ29yZSBhY3R1YWwgY2xvY2tzIHdoZW4gYW55IExvZ2ljYWwgUHJvY2Vzc29yIGlz
IGFjdGl2ZSBvbiB0aGUgUGh5c2ljYWwgQ29yZSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJp
Y05hbWUiOiAiSXBMb2FkIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJJTlNUX1JFVElSRUQuQU5Z
IC8gTUVNX0lOU1RfUkVUSVJFRC5BTExfTE9BRFMiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJJ
bnNUeXBlIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJJbnN0cnVjdGlvbnMgcGVyIExv
YWQgKGxvd2VyIG51bWJlciBtZWFucyBoaWdoZXIgb2NjdXJyZW5jZSByYXRlKSIKICAgIH0sCiAg
ICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiSXBTdG9yZSIsCiAgICAgICAgIk1ldHJpY0V4cHIi
OiAiSU5TVF9SRVRJUkVELkFOWSAvIE1FTV9JTlNUX1JFVElSRUQuQUxMX1NUT1JFUyIsCiAgICAg
ICAgIk1ldHJpY0dyb3VwIjogIkluc1R5cGUiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjog
Ikluc3RydWN0aW9ucyBwZXIgU3RvcmUgKGxvd2VyIG51bWJlciBtZWFucyBoaWdoZXIgb2NjdXJy
ZW5jZSByYXRlKSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiSXBCcmFuY2gi
LAogICAgICAgICJNZXRyaWNFeHByIjogIklOU1RfUkVUSVJFRC5BTlkgLyBCUl9JTlNUX1JFVElS
RUQuQUxMX0JSQU5DSEVTIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiQnJhbmNoZXM7SW5zVHlw
ZSIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiSW5zdHJ1Y3Rpb25zIHBlciBCcmFuY2gg
KGxvd2VyIG51bWJlciBtZWFucyBoaWdoZXIgb2NjdXJyZW5jZSByYXRlKSIKICAgIH0sCiAgICB7
CiAgICAgICAgIk1ldHJpY05hbWUiOiAiSXBDYWxsIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJJ
TlNUX1JFVElSRUQuQU5ZIC8gQlJfSU5TVF9SRVRJUkVELk5FQVJfQ0FMTCIsCiAgICAgICAgIk1l
dHJpY0dyb3VwIjogIkJyYW5jaGVzIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJJbnN0
cnVjdGlvbnMgcGVyIChuZWFyKSBjYWxsIChsb3dlciBudW1iZXIgbWVhbnMgaGlnaGVyIG9jY3Vy
cmVuY2UgcmF0ZSkiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIkJwVGtCcmFu
Y2giLAogICAgICAgICJNZXRyaWNFeHByIjogIkJSX0lOU1RfUkVUSVJFRC5BTExfQlJBTkNIRVMg
LyBCUl9JTlNUX1JFVElSRUQuTkVBUl9UQUtFTiIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIkJy
YW5jaGVzO1BHTyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiQnJhbmNoIGluc3RydWN0
aW9ucyBwZXIgdGFrZW4gYnJhbmNoLiAiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1l
IjogIklwRkxPUCIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiSU5TVF9SRVRJUkVELkFOWSAvICgg
MSAqICggRlBfQVJJVEhfSU5TVF9SRVRJUkVELlNDQUxBUl9TSU5HTEUgKyBGUF9BUklUSF9JTlNU
X1JFVElSRUQuU0NBTEFSX0RPVUJMRSApICsgMiAqIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC4xMjhC
X1BBQ0tFRF9ET1VCTEUgKyA0ICogKCBGUF9BUklUSF9JTlNUX1JFVElSRUQuMTI4Ql9QQUNLRURf
U0lOR0xFICsgRlBfQVJJVEhfSU5TVF9SRVRJUkVELjI1NkJfUEFDS0VEX0RPVUJMRSApICsgOCAq
ICggRlBfQVJJVEhfSU5TVF9SRVRJUkVELjI1NkJfUEFDS0VEX1NJTkdMRSArIEZQX0FSSVRIX0lO
U1RfUkVUSVJFRC41MTJCX1BBQ0tFRF9ET1VCTEUgKSArIDE2ICogRlBfQVJJVEhfSU5TVF9SRVRJ
UkVELjUxMkJfUEFDS0VEX1NJTkdMRSApIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiRmxvcHM7
RnBBcml0aDtJbnNUeXBlIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJJbnN0cnVjdGlv
bnMgcGVyIEZsb2F0aW5nIFBvaW50IChGUCkgT3BlcmF0aW9uIChsb3dlciBudW1iZXIgbWVhbnMg
aGlnaGVyIG9jY3VycmVuY2UgcmF0ZSkiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1l
IjogIkluc3RydWN0aW9ucyIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiSU5TVF9SRVRJUkVELkFO
WSIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlN1bW1hcnk7VG1hTDEiLAogICAgICAgICJCcmll
ZkRlc2NyaXB0aW9uIjogIlRvdGFsIG51bWJlciBvZiByZXRpcmVkIEluc3RydWN0aW9ucywgU2Ft
cGxlIHdpdGg6IElOU1RfUkVUSVJFRC5QUkVDX0RJU1QiCiAgICB9LAogICAgewogICAgICAgICJN
ZXRyaWNOYW1lIjogIkxTRF9Db3ZlcmFnZSIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiTFNELlVP
UFMgLyAoSURRLkRTQl9VT1BTICsgTFNELlVPUFMgKyBJRFEuTUlURV9VT1BTICsgSURRLk1TX1VP
UFMpIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTFNEIiwKICAgICAgICAiQnJpZWZEZXNjcmlw
dGlvbiI6ICJGcmFjdGlvbiBvZiBVb3BzIGRlbGl2ZXJlZCBieSB0aGUgTFNEIChMb29wIFN0cmVh
bSBEZXRlY3RvcjsgYWthIExvb3AgQ2FjaGUpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmlj
TmFtZSI6ICJEU0JfQ292ZXJhZ2UiLAogICAgICAgICJNZXRyaWNFeHByIjogIklEUS5EU0JfVU9Q
UyAvIChJRFEuRFNCX1VPUFMgKyBMU0QuVU9QUyArIElEUS5NSVRFX1VPUFMgKyBJRFEuTVNfVU9Q
UykiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJEU0I7RmV0Y2hCVyIsCiAgICAgICAgIkJyaWVm
RGVzY3JpcHRpb24iOiAiRnJhY3Rpb24gb2YgVW9wcyBkZWxpdmVyZWQgYnkgdGhlIERTQiAoYWth
IERlY29kZWQgSUNhY2hlOyBvciBVb3AgQ2FjaGUpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0
cmljTmFtZSI6ICJMb2FkX01pc3NfUmVhbF9MYXRlbmN5IiwKICAgICAgICAiTWV0cmljRXhwciI6
ICJMMURfUEVORF9NSVNTLlBFTkRJTkcgLyAoIE1FTV9MT0FEX1JFVElSRUQuTDFfTUlTUyArIE1F
TV9MT0FEX1JFVElSRUQuRkJfSElUICkiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJNZW1vcnlC
b3VuZDtNZW1vcnlMYXQiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkFjdHVhbCBBdmVy
YWdlIExhdGVuY3kgZm9yIEwxIGRhdGEtY2FjaGUgbWlzcyBkZW1hbmQgbG9hZHMgKGluIGNvcmUg
Y3ljbGVzKSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiTUxQIiwKICAgICAg
ICAiTWV0cmljRXhwciI6ICJMMURfUEVORF9NSVNTLlBFTkRJTkcgLyBMMURfUEVORF9NSVNTLlBF
TkRJTkdfQ1lDTEVTIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTWVtb3J5Qm91bmQ7TWVtb3J5
QlciLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIk1lbW9yeS1MZXZlbC1QYXJhbGxlbGlz
bSAoYXZlcmFnZSBudW1iZXIgb2YgTDEgbWlzcyBkZW1hbmQgbG9hZCB3aGVuIHRoZXJlIGlzIGF0
IGxlYXN0IG9uZSBzdWNoIG1pc3MuIFBlci1Mb2dpY2FsIFByb2Nlc3NvcikiCiAgICB9LAogICAg
ewogICAgICAgICJNZXRyaWNOYW1lIjogIlBhZ2VfV2Fsa3NfVXRpbGl6YXRpb24iLAogICAgICAg
ICJNZXRyaWNFeHByIjogIiggSVRMQl9NSVNTRVMuV0FMS19QRU5ESU5HICsgRFRMQl9MT0FEX01J
U1NFUy5XQUxLX1BFTkRJTkcgKyBEVExCX1NUT1JFX01JU1NFUy5XQUxLX1BFTkRJTkcgKSAvICgg
MiAqIENPUkVfQ0xLUyApIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTWVtb3J5VExCIiwKICAg
ICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJVdGlsaXphdGlvbiBvZiB0aGUgY29yZSdzIFBhZ2Ug
V2Fsa2VyKHMpIHNlcnZpbmcgU1RMQiBtaXNzZXMgdHJpZ2dlcmVkIGJ5IGluc3RydWN0aW9uL0xv
YWQvU3RvcmUgYWNjZXNzZXMiLAogICAgICAgICJNZXRyaWNDb25zdHJhaW50IjogIk5PX05NSV9X
QVRDSERPRyIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiTDFEX0NhY2hlX0Zp
bGxfQlciLAogICAgICAgICJNZXRyaWNFeHByIjogIjY0ICogTDFELlJFUExBQ0VNRU5UIC8gMTAw
MDAwMDAwMCAvIGR1cmF0aW9uX3RpbWUiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJNZW1vcnlC
VyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiQXZlcmFnZSBkYXRhIGZpbGwgYmFuZHdp
ZHRoIHRvIHRoZSBMMSBkYXRhIGNhY2hlIFtHQiAvIHNlY10iCiAgICB9LAogICAgewogICAgICAg
ICJNZXRyaWNOYW1lIjogIkwyX0NhY2hlX0ZpbGxfQlciLAogICAgICAgICJNZXRyaWNFeHByIjog
IjY0ICogTDJfTElORVNfSU4uQUxMIC8gMTAwMDAwMDAwMCAvIGR1cmF0aW9uX3RpbWUiLAogICAg
ICAgICJNZXRyaWNHcm91cCI6ICJNZW1vcnlCVyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24i
OiAiQXZlcmFnZSBkYXRhIGZpbGwgYmFuZHdpZHRoIHRvIHRoZSBMMiBjYWNoZSBbR0IgLyBzZWNd
IgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJMM19DYWNoZV9GaWxsX0JXIiwK
ICAgICAgICAiTWV0cmljRXhwciI6ICI2NCAqIExPTkdFU1RfTEFUX0NBQ0hFLk1JU1MgLyAxMDAw
MDAwMDAwIC8gZHVyYXRpb25fdGltZSIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIk1lbW9yeUJX
IiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJBdmVyYWdlIHBlci1jb3JlIGRhdGEgZmls
bCBiYW5kd2lkdGggdG8gdGhlIEwzIGNhY2hlIFtHQiAvIHNlY10iCiAgICB9LAogICAgewogICAg
ICAgICJNZXRyaWNOYW1lIjogIkwzX0NhY2hlX0FjY2Vzc19CVyIsCiAgICAgICAgIk1ldHJpY0V4
cHIiOiAiNjQgKiBPRkZDT1JFX1JFUVVFU1RTLkFMTF9SRVFVRVNUUyAvIDEwMDAwMDAwMDAgLyBk
dXJhdGlvbl90aW1lIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTWVtb3J5Qlc7T2ZmY29yZSIs
CiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiQXZlcmFnZSBwZXItY29yZSBkYXRhIGFjY2Vz
cyBiYW5kd2lkdGggdG8gdGhlIEwzIGNhY2hlIFtHQiAvIHNlY10iCiAgICB9LAogICAgewogICAg
ICAgICJNZXRyaWNOYW1lIjogIkwxTVBLSSIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiMTAwMCAq
IE1FTV9MT0FEX1JFVElSRUQuTDFfTUlTUyAvIElOU1RfUkVUSVJFRC5BTlkiLAogICAgICAgICJN
ZXRyaWNHcm91cCI6ICJDYWNoZU1pc3NlcyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAi
TDEgY2FjaGUgdHJ1ZSBtaXNzZXMgcGVyIGtpbG8gaW5zdHJ1Y3Rpb24gZm9yIHJldGlyZWQgZGVt
YW5kIGxvYWRzIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJMMk1QS0kiLAog
ICAgICAgICJNZXRyaWNFeHByIjogIjEwMDAgKiBNRU1fTE9BRF9SRVRJUkVELkwyX01JU1MgLyBJ
TlNUX1JFVElSRUQuQU5ZIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiQ2FjaGVNaXNzZXMiLAog
ICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkwyIGNhY2hlIHRydWUgbWlzc2VzIHBlciBraWxv
IGluc3RydWN0aW9uIGZvciByZXRpcmVkIGRlbWFuZCBsb2FkcyIKICAgIH0sCiAgICB7CiAgICAg
ICAgIk1ldHJpY05hbWUiOiAiTDJNUEtJX0FsbCIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiMTAw
MCAqICggKCBPRkZDT1JFX1JFUVVFU1RTLkFMTF9EQVRBX1JEIC0gT0ZGQ09SRV9SRVFVRVNUUy5E
RU1BTkRfREFUQV9SRCApICsgTDJfUlFTVFMuQUxMX0RFTUFORF9NSVNTICsgTDJfUlFTVFMuU1dQ
Rl9NSVNTICkgLyBJbnN0cnVjdGlvbnMiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJDYWNoZU1p
c3NlcztPZmZjb3JlIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJMMiBjYWNoZSBtaXNz
ZXMgcGVyIGtpbG8gaW5zdHJ1Y3Rpb24gZm9yIGFsbCByZXF1ZXN0IHR5cGVzIChpbmNsdWRpbmcg
c3BlY3VsYXRpdmUpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJMM01QS0ki
LAogICAgICAgICJNZXRyaWNFeHByIjogIjEwMDAgKiBNRU1fTE9BRF9SRVRJUkVELkwzX01JU1Mg
LyBJTlNUX1JFVElSRUQuQU5ZIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiQ2FjaGVNaXNzZXMi
LAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkwzIGNhY2hlIHRydWUgbWlzc2VzIHBlciBr
aWxvIGluc3RydWN0aW9uIGZvciByZXRpcmVkIGRlbWFuZCBsb2FkcyIKICAgIH0sCiAgICB7CiAg
ICAgICAgIk1ldHJpY05hbWUiOiAiTDJfRXZpY3Rpb25zX1NpbGVudF9QS0kiLAogICAgICAgICJN
ZXRyaWNFeHByIjogIjEwMDAgKiBMMl9MSU5FU19PVVQuU0lMRU5UIC8gSW5zdHJ1Y3Rpb25zIiwK
ICAgICAgICAiTWV0cmljR3JvdXAiOiAiTDJFdmljdHM7U2VydmVyIiwKICAgICAgICAiQnJpZWZE
ZXNjcmlwdGlvbiI6ICJSYXRlIG9mIHNpbGVudCBldmljdGlvbnMgZnJvbSB0aGUgTDIgY2FjaGUg
cGVyIEtpbG8gaW5zdHJ1Y3Rpb24gd2hlcmUgdGhlIGV2aWN0ZWQgbGluZXMgYXJlIGRyb3BwZWQg
KG5vIHdyaXRlYmFjayB0byBMMyBvciBtZW1vcnkpIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0
cmljTmFtZSI6ICJMMl9FdmljdGlvbnNfTm9uU2lsZW50X1BLSSIsCiAgICAgICAgIk1ldHJpY0V4
cHIiOiAiMTAwMCAqIEwyX0xJTkVTX09VVC5OT05fU0lMRU5UIC8gSW5zdHJ1Y3Rpb25zIiwKICAg
ICAgICAiTWV0cmljR3JvdXAiOiAiTDJFdmljdHM7U2VydmVyIiwKICAgICAgICAiQnJpZWZEZXNj
cmlwdGlvbiI6ICJSYXRlIG9mIG5vbiBzaWxlbnQgZXZpY3Rpb25zIGZyb20gdGhlIEwyIGNhY2hl
IHBlciBLaWxvIGluc3RydWN0aW9uIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6
ICJDUFVfVXRpbGl6YXRpb24iLAogICAgICAgICJNZXRyaWNFeHByIjogIkNQVV9DTEtfVU5IQUxU
RUQuUkVGX1RTQyAvIG1zckB0c2NAIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiSFBDO1N1bW1h
cnkiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkF2ZXJhZ2UgQ1BVIFV0aWxpemF0aW9u
IgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJBdmVyYWdlX0ZyZXF1ZW5jeSIs
CiAgICAgICAgIk1ldHJpY0V4cHIiOiAiKENQVV9DTEtfVU5IQUxURUQuVEhSRUFEIC8gQ1BVX0NM
S19VTkhBTFRFRC5SRUZfVFNDKSAqIG1zckB0c2NAIC8gMTAwMDAwMDAwMCAvIGR1cmF0aW9uX3Rp
bWUiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJTdW1tYXJ5O1Bvd2VyIiwKICAgICAgICAiQnJp
ZWZEZXNjcmlwdGlvbiI6ICJNZWFzdXJlZCBBdmVyYWdlIEZyZXF1ZW5jeSBmb3IgdW5oYWx0ZWQg
cHJvY2Vzc29ycyBbR0h6XSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiR0ZM
T1BzIiwKICAgICAgICAiTWV0cmljRXhwciI6ICIoICggMSAqICggRlBfQVJJVEhfSU5TVF9SRVRJ
UkVELlNDQUxBUl9TSU5HTEUgKyBGUF9BUklUSF9JTlNUX1JFVElSRUQuU0NBTEFSX0RPVUJMRSAp
ICsgMiAqIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC4xMjhCX1BBQ0tFRF9ET1VCTEUgKyA0ICogKCBG
UF9BUklUSF9JTlNUX1JFVElSRUQuMTI4Ql9QQUNLRURfU0lOR0xFICsgRlBfQVJJVEhfSU5TVF9S
RVRJUkVELjI1NkJfUEFDS0VEX0RPVUJMRSApICsgOCAqICggRlBfQVJJVEhfSU5TVF9SRVRJUkVE
LjI1NkJfUEFDS0VEX1NJTkdMRSArIEZQX0FSSVRIX0lOU1RfUkVUSVJFRC41MTJCX1BBQ0tFRF9E
T1VCTEUgKSArIDE2ICogRlBfQVJJVEhfSU5TVF9SRVRJUkVELjUxMkJfUEFDS0VEX1NJTkdMRSAp
IC8gMTAwMDAwMDAwMCApIC8gZHVyYXRpb25fdGltZSIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjog
IkZsb3BzO0hQQyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiR2lnYSBGbG9hdGluZyBQ
b2ludCBPcGVyYXRpb25zIFBlciBTZWNvbmQiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNO
YW1lIjogIlR1cmJvX1V0aWxpemF0aW9uIiwKICAgICAgICAiTWV0cmljRXhwciI6ICJDUFVfQ0xL
X1VOSEFMVEVELlRIUkVBRCAvIENQVV9DTEtfVU5IQUxURUQuUkVGX1RTQyIsCiAgICAgICAgIk1l
dHJpY0dyb3VwIjogIlBvd2VyIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJBdmVyYWdl
IEZyZXF1ZW5jeSBVdGlsaXphdGlvbiByZWxhdGl2ZSBub21pbmFsIGZyZXF1ZW5jeSIKICAgIH0s
CiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAiU01UXzJUX1V0aWxpemF0aW9uIiwKICAgICAg
ICAiTWV0cmljRXhwciI6ICIxIC0gQ1BVX0NMS19VTkhBTFRFRC5PTkVfVEhSRUFEX0FDVElWRSAv
IENQVV9DTEtfVU5IQUxURUQuUkVGX0RJU1RSSUJVVEVEIGlmICNTTVRfb24gZWxzZSAwIiwKICAg
ICAgICAiTWV0cmljR3JvdXAiOiAiU01UIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJG
cmFjdGlvbiBvZiBjeWNsZXMgd2hlcmUgYm90aCBoYXJkd2FyZSBMb2dpY2FsIFByb2Nlc3NvcnMg
d2VyZSBhY3RpdmUiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIktlcm5lbF9V
dGlsaXphdGlvbiIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiQ1BVX0NMS19VTkhBTFRFRC5USFJF
QURfUDprIC8gQ1BVX0NMS19VTkhBTFRFRC5USFJFQUQiLAogICAgICAgICJNZXRyaWNHcm91cCI6
ICJPUyIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiRnJhY3Rpb24gb2YgY3ljbGVzIHNw
ZW50IGluIHRoZSBPcGVyYXRpbmcgU3lzdGVtIChPUykgS2VybmVsIG1vZGUiCiAgICB9LAogICAg
ewogICAgICAgICJNZXRyaWNOYW1lIjogIkRSQU1fQldfVXNlIiwKICAgICAgICAiTWV0cmljRXhw
ciI6ICIoIDY0ICogKCB1bmNvcmVfaW1jQGNhc19jb3VudF9yZWFkQCArIHVuY29yZV9pbWNAY2Fz
X2NvdW50X3dyaXRlQCApIC8gMTAwMDAwMDAwMCApIC8gZHVyYXRpb25fdGltZSIsCiAgICAgICAg
Ik1ldHJpY0dyb3VwIjogIkhQQztNZW1vcnlCVztTb0MiLAogICAgICAgICJCcmllZkRlc2NyaXB0
aW9uIjogIkF2ZXJhZ2UgZXh0ZXJuYWwgTWVtb3J5IEJhbmR3aWR0aCBVc2UgZm9yIHJlYWRzIGFu
ZCB3cml0ZXMgW0dCIC8gc2VjXSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY05hbWUiOiAi
TUVNX1JlYWRfTGF0ZW5jeSIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiMTAwMDAwMDAwMCAqICgg
VU5DX0NIQV9UT1JfT0NDVVBBTkNZLklBX01JU1NfRFJEIC8gVU5DX0NIQV9UT1JfSU5TRVJUUy5J
QV9NSVNTX0RSRCApIC8gKCBjaGFfMEBldmVudFxcPTB4MEAgLyBkdXJhdGlvbl90aW1lICkiLAog
ICAgICAgICJNZXRyaWNHcm91cCI6ICJNZW1vcnlMYXQ7U29DIiwKICAgICAgICAiQnJpZWZEZXNj
cmlwdGlvbiI6ICJBdmVyYWdlIGxhdGVuY3kgb2YgZGF0YSByZWFkIHJlcXVlc3QgdG8gZXh0ZXJu
YWwgbWVtb3J5IChpbiBuYW5vc2Vjb25kcykuIEFjY291bnRzIGZvciBkZW1hbmQgbG9hZHMgYW5k
IEwxL0wyIHByZWZldGNoZXMiCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIk1F
TV9QYXJhbGxlbF9SZWFkcyIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiVU5DX0NIQV9UT1JfT0ND
VVBBTkNZLklBX01JU1NfRFJEIC8gY2hhQGV2ZW50XFw9MHgzNlxcLHVtYXNrXFw9MHhDODE3RkUw
MVxcLHRocmVzaFxcPTFAIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTWVtb3J5Qlc7U29DIiwK
ICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJBdmVyYWdlIG51bWJlciBvZiBwYXJhbGxlbCBk
YXRhIHJlYWQgcmVxdWVzdHMgdG8gZXh0ZXJuYWwgbWVtb3J5LiBBY2NvdW50cyBmb3IgZGVtYW5k
IGxvYWRzIGFuZCBMMS9MMiBwcmVmZXRjaGVzIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmlj
TmFtZSI6ICJNRU1fUE1NX1JlYWRfTGF0ZW5jeSIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiMCIs
CiAgICAgICAgIk1ldHJpY0dyb3VwIjogIk1lbW9yeUxhdDtTb0M7U2VydmVyIiwKICAgICAgICAi
QnJpZWZEZXNjcmlwdGlvbiI6ICJBdmVyYWdlIGxhdGVuY3kgb2YgZGF0YSByZWFkIHJlcXVlc3Qg
dG8gZXh0ZXJuYWwgM0QgWC1Qb2ludCBtZW1vcnkgW2luIG5hbm9zZWNvbmRzXS4gQWNjb3VudHMg
Zm9yIGRlbWFuZCBsb2FkcyBhbmQgTDEvTDIgZGF0YS1yZWFkIHByZWZldGNoZXMiCiAgICB9LAog
ICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIlBNTV9SZWFkX0JXIiwKICAgICAgICAiTWV0cmlj
RXhwciI6ICIwIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiTWVtb3J5Qlc7U29DO1NlcnZlciIs
CiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiQXZlcmFnZSAzRFhQIE1lbW9yeSBCYW5kd2lk
dGggVXNlIGZvciByZWFkcyBbR0IgLyBzZWNdIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmlj
TmFtZSI6ICJQTU1fV3JpdGVfQlciLAogICAgICAgICJNZXRyaWNFeHByIjogIjAiLAogICAgICAg
ICJNZXRyaWNHcm91cCI6ICJNZW1vcnlCVztTb0M7U2VydmVyIiwKICAgICAgICAiQnJpZWZEZXNj
cmlwdGlvbiI6ICJBdmVyYWdlIDNEWFAgTWVtb3J5IEJhbmR3aWR0aCBVc2UgZm9yIFdyaXRlcyBb
R0IgLyBzZWNdIgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJJT19Xcml0ZV9C
VyIsCiAgICAgICAgIk1ldHJpY0V4cHIiOiAiVU5DX0NIQV9UT1JfSU5TRVJUUy5JT19QQ0lSRENV
UiAqIDY0IC8gMTAwMDAwMDAwMCAvIGR1cmF0aW9uX3RpbWUiLAogICAgICAgICJNZXRyaWNHcm91
cCI6ICJJb0JXO1NvQztTZXJ2ZXIiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkF2ZXJh
Z2UgSU8gKG5ldHdvcmsgb3IgZGlzaykgQmFuZHdpZHRoIFVzZSBmb3IgV3JpdGVzIFtHQiAvIHNl
Y10iCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIklPX1JlYWRfQlciLAogICAg
ICAgICJNZXRyaWNFeHByIjogIiggVU5DX0NIQV9UT1JfSU5TRVJUUy5JT19ISVRfSVRPTSArIFVO
Q19DSEFfVE9SX0lOU0VSVFMuSU9fTUlTU19JVE9NICsgVU5DX0NIQV9UT1JfSU5TRVJUUy5JT19I
SVRfSVRPTUNBQ0hFTkVBUiArIFVOQ19DSEFfVE9SX0lOU0VSVFMuSU9fTUlTU19JVE9NQ0FDSEVO
RUFSICkgKiA2NCAvIDEwMDAwMDAwMDAgLyBkdXJhdGlvbl90aW1lIiwKICAgICAgICAiTWV0cmlj
R3JvdXAiOiAiSW9CVztTb0M7U2VydmVyIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJB
dmVyYWdlIElPIChuZXR3b3JrIG9yIGRpc2spIEJhbmR3aWR0aCBVc2UgZm9yIFJlYWRzIFtHQiAv
IHNlY10iCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNOYW1lIjogIlNvY2tldF9DTEtTIiwK
ICAgICAgICAiTWV0cmljRXhwciI6ICJjaGFfMEBldmVudFxcPTB4MEAiLAogICAgICAgICJNZXRy
aWNHcm91cCI6ICJTb0MiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIlNvY2tldCBhY3R1
YWwgY2xvY2tzIHdoZW4gYW55IGNvcmUgaXMgYWN0aXZlIG9uIHRoYXQgc29ja2V0IgogICAgfSwK
ICAgIHsKICAgICAgICAiTWV0cmljTmFtZSI6ICJJcEZhckJyYW5jaCIsCiAgICAgICAgIk1ldHJp
Y0V4cHIiOiAiSU5TVF9SRVRJUkVELkFOWSAvIEJSX0lOU1RfUkVUSVJFRC5GQVJfQlJBTkNIOnUi
LAogICAgICAgICJNZXRyaWNHcm91cCI6ICJCcmFuY2hlcztPUyIsCiAgICAgICAgIkJyaWVmRGVz
Y3JpcHRpb24iOiAiSW5zdHJ1Y3Rpb25zIHBlciBGYXIgQnJhbmNoICggRmFyIEJyYW5jaGVzIGFw
cGx5IHVwb24gdHJhbnNpdGlvbiBmcm9tIGFwcGxpY2F0aW9uIHRvIG9wZXJhdGluZyBzeXN0ZW0s
IGhhbmRsaW5nIGludGVycnVwdHMsIGV4Y2VwdGlvbnMpIFtsb3dlciBudW1iZXIgbWVhbnMgaGln
aGVyIG9jY3VycmVuY2UgcmF0ZV0iCiAgICB9LAogICAgewogICAgICAgICJNZXRyaWNFeHByIjog
Iihjc3RhdGVfY29yZUBjM1xcLXJlc2lkZW5jeUAgLyBtc3JAdHNjQCkgKiAxMDAiLAogICAgICAg
ICJNZXRyaWNHcm91cCI6ICJQb3dlciIsCiAgICAgICAgIkJyaWVmRGVzY3JpcHRpb24iOiAiQzMg
cmVzaWRlbmN5IHBlcmNlbnQgcGVyIGNvcmUiLAogICAgICAgICJNZXRyaWNOYW1lIjogIkMzX0Nv
cmVfUmVzaWRlbmN5IgogICAgfSwKICAgIHsKICAgICAgICAiTWV0cmljRXhwciI6ICIoY3N0YXRl
X2NvcmVAYzZcXC1yZXNpZGVuY3lAIC8gbXNyQHRzY0ApICogMTAwIiwKICAgICAgICAiTWV0cmlj
R3JvdXAiOiAiUG93ZXIiLAogICAgICAgICJCcmllZkRlc2NyaXB0aW9uIjogIkM2IHJlc2lkZW5j
eSBwZXJjZW50IHBlciBjb3JlIiwKICAgICAgICAiTWV0cmljTmFtZSI6ICJDNl9Db3JlX1Jlc2lk
ZW5jeSIKICAgIH0sCiAgICB7CiAgICAgICAgIk1ldHJpY0V4cHIiOiAiKGNzdGF0ZV9jb3JlQGM3
XFwtcmVzaWRlbmN5QCAvIG1zckB0c2NAKSAqIDEwMCIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjog
IlBvd2VyIiwKICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJDNyByZXNpZGVuY3kgcGVyY2Vu
dCBwZXIgY29yZSIsCiAgICAgICAgIk1ldHJpY05hbWUiOiAiQzdfQ29yZV9SZXNpZGVuY3kiCiAg
ICB9LAogICAgewogICAgICAgICJNZXRyaWNFeHByIjogIihjc3RhdGVfcGtnQGMyXFwtcmVzaWRl
bmN5QCAvIG1zckB0c2NAKSAqIDEwMCIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlBvd2VyIiwK
ICAgICAgICAiQnJpZWZEZXNjcmlwdGlvbiI6ICJDMiByZXNpZGVuY3kgcGVyY2VudCBwZXIgcGFj
a2FnZSIsCiAgICAgICAgIk1ldHJpY05hbWUiOiAiQzJfUGtnX1Jlc2lkZW5jeSIKICAgIH0sCiAg
ICB7CiAgICAgICAgIk1ldHJpY0V4cHIiOiAiKGNzdGF0ZV9wa2dAYzNcXC1yZXNpZGVuY3lAIC8g
bXNyQHRzY0ApICogMTAwIiwKICAgICAgICAiTWV0cmljR3JvdXAiOiAiUG93ZXIiLAogICAgICAg
ICJCcmllZkRlc2NyaXB0aW9uIjogIkMzIHJlc2lkZW5jeSBwZXJjZW50IHBlciBwYWNrYWdlIiwK
ICAgICAgICAiTWV0cmljTmFtZSI6ICJDM19Qa2dfUmVzaWRlbmN5IgogICAgfSwKICAgIHsKICAg
ICAgICAiTWV0cmljRXhwciI6ICIoY3N0YXRlX3BrZ0BjNlxcLXJlc2lkZW5jeUAgLyBtc3JAdHNj
QCkgKiAxMDAiLAogICAgICAgICJNZXRyaWNHcm91cCI6ICJQb3dlciIsCiAgICAgICAgIkJyaWVm
RGVzY3JpcHRpb24iOiAiQzYgcmVzaWRlbmN5IHBlcmNlbnQgcGVyIHBhY2thZ2UiLAogICAgICAg
ICJNZXRyaWNOYW1lIjogIkM2X1BrZ19SZXNpZGVuY3kiCiAgICB9LAogICAgewogICAgICAgICJN
ZXRyaWNFeHByIjogIihjc3RhdGVfcGtnQGM3XFwtcmVzaWRlbmN5QCAvIG1zckB0c2NAKSAqIDEw
MCIsCiAgICAgICAgIk1ldHJpY0dyb3VwIjogIlBvd2VyIiwKICAgICAgICAiQnJpZWZEZXNjcmlw
dGlvbiI6ICJDNyByZXNpZGVuY3kgcGVyY2VudCBwZXIgcGFja2FnZSIsCiAgICAgICAgIk1ldHJp
Y05hbWUiOiAiQzdfUGtnX1Jlc2lkZW5jeSIKICAgIH0KXQo=
--000000000000cba27505c8c8ed3b--
