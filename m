Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120D9C43214
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07BF61181
	for <linux-perf-users@archiver.kernel.org>; Fri,  6 Aug 2021 08:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244433AbhHFIWN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244295AbhHFIU5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 04:20:57 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D7C0619EF
        for <linux-perf-users@vger.kernel.org>; Fri,  6 Aug 2021 01:17:10 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id c3so7983872ilh.3
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Aug 2021 01:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SG0mHtsctF1XNC0sZeVuquJ/uUchP+vlY+vsJ1zn9t0=;
        b=YWiw34wL1ztXfjPVNCf8kZz5wo2eFdi4oBhN4rl6ic92UILltexAuWxo1kG/DyMJc3
         3bByzeHeFYIJ3dVArvKh9X+J2baWv0/21/ZaUgeZOsfipxEQumcU95+eH+sAYm+k+8ST
         G5ewRVVeeHgdgp2ZMaKoFCn1/Ul9cm7auYlhAQSSF3a8OB+5kB7CESSiEjNWCMEmCuV/
         d6Q4abRLwMdG+hCTgHmgoJMtn8Ik21YYmHYDSeg/CETyAair00ZkmcV5ovEK4Po5jmTG
         HewI0i3tnpDGIliwkYELlvVse5H9ytLBVfmlI4QLjWj09T65PhqFAGzSoGjk59/5AapE
         O5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SG0mHtsctF1XNC0sZeVuquJ/uUchP+vlY+vsJ1zn9t0=;
        b=qMc5uszohPPK2h23dtrpcJ9YCx6fRsVcPBX+E+6P9Tqo8HxNpKw0vM/iNr+rSybi6U
         ztoEN2VkQ9Uk88i6OzuN+CHGuDrychYTWXkB3fjPiBkejNZVF+n0jcGn6lJyfyMOoEbx
         BC2YM9aBw5OrNWszw1I9DFhEg7aWT+LPBCDmohriq4HUtMJF9b74yrtT2fyufJ23Anvq
         UAkupP4zVcD9tUckrI2RNJhN7MMRjETBduMAKtLfpGlu2qGNk1ClXwJa+lODvRgV1fm1
         WkyES4fIh6a1RF3WFM19r3W6YHvcjuO5oWBx4ffSwF0vZxXTuY3tt48AYAjFzpt+961P
         2xJg==
X-Gm-Message-State: AOAM530nh62M9zyRfWvTto59A+xF4UZxBFzlF2RgrGeAfawM97UJ9mDM
        4bhNqFOy6gJB62F4XBXcrdLK27WAPv5avCECtWvxxQ==
X-Google-Smtp-Source: ABdhPJwGb0V+XhDmlIrLKSZTLbt3VclfvF2imkgy6vP6RPOhZoczkbPqummnTn4SM73rr3KPhGpWzZCRz+O+EBOQzYI=
X-Received: by 2002:a05:6e02:d09:: with SMTP id g9mr845520ilj.153.1628237829572;
 Fri, 06 Aug 2021 01:17:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210806075404.31209-1-yao.jin@linux.intel.com>
In-Reply-To: <20210806075404.31209-1-yao.jin@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 6 Aug 2021 01:16:57 -0700
Message-ID: <CAP-5=fVQBDtt4aDVvbB+u663QGihMcajePAMh+rTk_sRFvd32A@mail.gmail.com>
Subject: Re: [PATCH v4] perf vendor events: Add metrics for Icelake Server
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>, "Jin, Yao" <yao.jin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Aug 6, 2021, 12:55 AM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> Add JSON metrics for Icelake Server to perf.
>
> Based on TMA metrics 4.21 at 01.org.
> https://download.01.org/perfmon/
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> v4:
>  - Since now perf tool can support #SMT_on in metric expression as a toke=
n,
>    support #SMT_on in 'ILP' and 'SMT_2T_Utilization'.
>
> v3:
>  - PMU cstate_core and cstate_pkg are supported for ICX since 5.14-rc1,
>    add cstate metrics for Core C1/C6 and Package C2/C6.
>
> v2:
>  - Fix perf test 10 error.
>
>    # ./perf test 10
>    10: PMU events                                                      :
>    10.1: PMU event table sanity                                        : =
Ok
>    10.2: PMU event map aliases                                         : =
Ok
>    10.3: Parsing of PMU event table metrics                            : =
Ok
>    10.4: Parsing of PMU event table metrics with fake PMUs             : =
Ok
>
>  - Remove cstate metrics because the kernel has not supported
>    cstate_core and cstate_core for Icelake server.
>
>  - Remove the topdown L1/L2 metrics.
>
>  .../arch/x86/icelakex/icx-metrics.json        | 315 ++++++++++++++++++
>  1 file changed, 315 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.j=
son
>
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> new file mode 100644
> index 000000000000..57ddbb9f9b31
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -0,0 +1,315 @@
> +[
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per Logical Process=
or)",
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
> +        "BriefDescription": "Cycles Per Instruction (per Logical Process=
or)",
> +        "MetricExpr": "1 / (INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD)"=
,
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CPI"
> +    },
> +    {
> +        "BriefDescription": "Per-Logical Processor actual clocks when th=
e Logical Processor is active.",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD",
> +        "MetricGroup": "Pipeline",
> +        "MetricName": "CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions Per Cycle (per physical core)"=
,
> +        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "SMT;TmaL1",
> +        "MetricName": "CoreIPC"
> +    },
> +    {
> +        "BriefDescription": "Floating Point Operations Per Cycle",
> +        "MetricExpr": "( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + FP_=
ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKED_=
DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_RET=
IRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED.5=
12B_PACKED_SINGLE ) / CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "Flops",
> +        "MetricName": "FLOPc"
> +    },
> +    {
> +        "BriefDescription": "Instruction-Level-Parallelism (average numb=
er of uops executed when there is at least 1 uop executed)",
> +        "MetricExpr": "UOPS_EXECUTED.THREAD / (( UOPS_EXECUTED.CORE_CYCL=
ES_GE_1 / 2 ) if #SMT_on else UOPS_EXECUTED.CORE_CYCLES_GE_1)",
> +        "MetricGroup": "Pipeline;PortsUtil",
> +        "MetricName": "ILP"
> +    },
> +    {
> +        "BriefDescription": "Number of Instructions per non-speculative =
Branch Misprediction (JEClear)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_MISP_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "BrMispredicts",
> +        "MetricName": "IpMispredict"
> +    },
> +    {
> +        "BriefDescription": "Core actual clocks when any Logical Process=
or is active on the Physical Core",
> +        "MetricExpr": "CPU_CLK_UNHALTED.DISTRIBUTED",
> +        "MetricGroup": "SMT",
> +        "MetricName": "CORE_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Load (lower number means h=
igher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_LOADS",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpLoad"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Store (lower number means =
higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / MEM_INST_RETIRED.ALL_STORES",
> +        "MetricGroup": "InsType",
> +        "MetricName": "IpStore"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Branch (lower number means=
 higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.ALL_BRANCHES",
> +        "MetricGroup": "Branches;InsType",
> +        "MetricName": "IpBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per (near) call (lower number =
means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / BR_INST_RETIRED.NEAR_CALL",
> +        "MetricGroup": "Branches",
> +        "MetricName": "IpCall"
> +    },
> +    {
> +        "BriefDescription": "Branch instructions per taken branch. ",
> +        "MetricExpr": "BR_INST_RETIRED.ALL_BRANCHES / BR_INST_RETIRED.NE=
AR_TAKEN",
> +        "MetricGroup": "Branches;PGO",
> +        "MetricName": "BpTkBranch"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Floating Point (FP) Operat=
ion (lower number means higher occurrence rate)",
> +        "MetricExpr": "INST_RETIRED.ANY / ( 1 * ( FP_ARITH_INST_RETIRED.=
SCALAR_SINGLE + FP_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_R=
ETIRED.128B_PACKED_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE =
+ FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.=
256B_PACKED_SINGLE + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_A=
RITH_INST_RETIRED.512B_PACKED_SINGLE )",
> +        "MetricGroup": "Flops;FpArith;InsType",
> +        "MetricName": "IpFLOP"
> +    },
> +    {
> +        "BriefDescription": "Total number of retired Instructions, Sampl=
e with: INST_RETIRED.PREC_DIST",
> +        "MetricExpr": "INST_RETIRED.ANY",
> +        "MetricGroup": "Summary;TmaL1",
> +        "MetricName": "Instructions"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the LSD (Loop=
 Stream Detector; aka Loop Cache)",
> +        "MetricExpr": "LSD.UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MITE_UO=
PS + IDQ.MS_UOPS)",
> +        "MetricGroup": "LSD",
> +        "MetricName": "LSD_Coverage"
> +    },
> +    {
> +        "BriefDescription": "Fraction of Uops delivered by the DSB (aka =
Decoded ICache; or Uop Cache)",
> +        "MetricExpr": "IDQ.DSB_UOPS / (IDQ.DSB_UOPS + LSD.UOPS + IDQ.MIT=
E_UOPS + IDQ.MS_UOPS)",
> +        "MetricGroup": "DSB;FetchBW",
> +        "MetricName": "DSB_Coverage"
> +    },
> +    {
> +        "BriefDescription": "Actual Average Latency for L1 data-cache mi=
ss demand loads (in core cycles)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / ( MEM_LOAD_RETIRED.L1_MIS=
S + MEM_LOAD_RETIRED.FB_HIT )",
> +        "MetricGroup": "MemoryBound;MemoryLat",
> +        "MetricName": "Load_Miss_Real_Latency"
> +    },
> +    {
> +        "BriefDescription": "Memory-Level-Parallelism (average number of=
 L1 miss demand load when there is at least one such miss. Per-Logical Proc=
essor)",
> +        "MetricExpr": "L1D_PEND_MISS.PENDING / L1D_PEND_MISS.PENDING_CYC=
LES",
> +        "MetricGroup": "MemoryBound;MemoryBW",
> +        "MetricName": "MLP"
> +    },
> +    {
> +        "BriefDescription": "Utilization of the core's Page Walker(s) se=
rving STLB misses triggered by instruction/Load/Store accesses",
> +        "MetricConstraint": "NO_NMI_WATCHDOG",
> +        "MetricExpr": "( ITLB_MISSES.WALK_PENDING + DTLB_LOAD_MISSES.WAL=
K_PENDING + DTLB_STORE_MISSES.WALK_PENDING ) / ( 2 * CPU_CLK_UNHALTED.DISTR=
IBUTED )",
> +        "MetricGroup": "MemoryTLB",
> +        "MetricName": "Page_Walks_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Average data fill bandwidth to the L1 data =
cache [GB / sec]",
> +        "MetricExpr": "64 * L1D.REPLACEMENT / 1000000000 / duration_time=
",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L1D_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average data fill bandwidth to the L2 cache=
 [GB / sec]",
> +        "MetricExpr": "64 * L2_LINES_IN.ALL / 1000000000 / duration_time=
",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L2_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data fill bandwidth to the=
 L3 cache [GB / sec]",
> +        "MetricExpr": "64 * LONGEST_LAT_CACHE.MISS / 1000000000 / durati=
on_time",
> +        "MetricGroup": "MemoryBW",
> +        "MetricName": "L3_Cache_Fill_BW"
> +    },
> +    {
> +        "BriefDescription": "Average per-core data access bandwidth to t=
he L3 cache [GB / sec]",
> +        "MetricExpr": "64 * OFFCORE_REQUESTS.ALL_REQUESTS / 1000000000 /=
 duration_time",
> +        "MetricGroup": "MemoryBW;Offcore",
> +        "MetricName": "L3_Cache_Access_BW"
> +    },
> +    {
> +        "BriefDescription": "L1 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L1_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L1MPKI"
> +    },
> +    {
> +        "BriefDescription": "L2 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L2_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L2MPKI"
> +    },
> +    {
> +        "BriefDescription": "L2 cache misses per kilo instruction for al=
l request types (including speculative)",
> +        "MetricExpr": "1000 * ( ( OFFCORE_REQUESTS.ALL_DATA_RD - OFFCORE=
_REQUESTS.DEMAND_DATA_RD ) + L2_RQSTS.ALL_DEMAND_MISS + L2_RQSTS.SWPF_MISS =
) / INST_RETIRED.ANY",
> +        "MetricGroup": "CacheMisses;Offcore",
> +        "MetricName": "L2MPKI_All"
> +    },
> +    {
> +        "BriefDescription": "L3 cache true misses per kilo instruction f=
or retired demand loads",
> +        "MetricExpr": "1000 * MEM_LOAD_RETIRED.L3_MISS / INST_RETIRED.AN=
Y",
> +        "MetricGroup": "CacheMisses",
> +        "MetricName": "L3MPKI"
> +    },
> +    {
> +        "BriefDescription": "Rate of silent evictions from the L2 cache =
per Kilo instruction where the evicted lines are dropped (no writeback to L=
3 or memory)",
> +        "MetricExpr": "1000 * L2_LINES_OUT.SILENT / INST_RETIRED.ANY",
> +        "MetricGroup": "L2Evicts;Server",
> +        "MetricName": "L2_Evictions_Silent_PKI"
> +    },
> +    {
> +        "BriefDescription": "Rate of non silent evictions from the L2 ca=
che per Kilo instruction",
> +        "MetricExpr": "1000 * L2_LINES_OUT.NON_SILENT / INST_RETIRED.ANY=
",
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
> +        "BriefDescription": "Measured Average Frequency for unhalted pro=
cessors [GHz]",
> +        "MetricExpr": "(CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_T=
SC) * msr@tsc@ / 1000000000 / duration_time",
> +        "MetricGroup": "Summary;Power",
> +        "MetricName": "Average_Frequency"
> +    },
> +    {
> +        "BriefDescription": "Giga Floating Point Operations Per Second",
> +        "MetricExpr": "( ( 1 * ( FP_ARITH_INST_RETIRED.SCALAR_SINGLE + F=
P_ARITH_INST_RETIRED.SCALAR_DOUBLE ) + 2 * FP_ARITH_INST_RETIRED.128B_PACKE=
D_DOUBLE + 4 * ( FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE + FP_ARITH_INST_R=
ETIRED.256B_PACKED_DOUBLE ) + 8 * ( FP_ARITH_INST_RETIRED.256B_PACKED_SINGL=
E + FP_ARITH_INST_RETIRED.512B_PACKED_DOUBLE ) + 16 * FP_ARITH_INST_RETIRED=
.512B_PACKED_SINGLE ) / 1000000000 ) / duration_time",
> +        "MetricGroup": "Flops;HPC",
> +        "MetricName": "GFLOPs"
> +    },
> +    {
> +        "BriefDescription": "Average Frequency Utilization relative nomi=
nal frequency",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD / CPU_CLK_UNHALTED.REF_TS=
C",
> +        "MetricGroup": "Power",
> +        "MetricName": "Turbo_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles where both hardware Logi=
cal Processors were active",
> +        "MetricExpr": "1 - CPU_CLK_UNHALTED.ONE_THREAD_ACTIVE / CPU_CLK_=
UNHALTED.REF_DISTRIBUTED if #SMT_on else 0",
> +        "MetricGroup": "SMT",
> +        "MetricName": "SMT_2T_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Fraction of cycles spent in the Operating S=
ystem (OS) Kernel mode",
> +        "MetricExpr": "CPU_CLK_UNHALTED.THREAD_P:k / CPU_CLK_UNHALTED.TH=
READ",
> +        "MetricGroup": "OS",
> +        "MetricName": "Kernel_Utilization"
> +    },
> +    {
> +        "BriefDescription": "Average external Memory Bandwidth Use for r=
eads and writes [GB / sec]",
> +        "MetricExpr": "( 64 * ( uncore_imc@cas_count_read@ + uncore_imc@=
cas_count_write@ ) / 1000000000 ) / duration_time",
> +        "MetricGroup": "HPC;MemoryBW;SoC",
> +        "MetricName": "DRAM_BW_Use"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to ext=
ernal memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetch=
es",
> +        "MetricExpr": "1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD =
/ UNC_CHA_TOR_INSERTS.IA_MISS_DRD ) / ( cha_0@event\\=3D0x0@ / duration_tim=
e )",
> +        "MetricGroup": "MemoryLat;SoC",
> +        "MetricName": "MEM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average number of parallel data read reques=
ts to external memory. Accounts for demand loads and L1/L2 prefetches",
> +        "MetricExpr": "UNC_CHA_TOR_OCCUPANCY.IA_MISS_DRD / cha@event\\=
=3D0x36\\,umask\\=3D0xC817FE01\\,thresh\\=3D1@",
> +        "MetricGroup": "MemoryBW;SoC",
> +        "MetricName": "MEM_Parallel_Reads"
> +    },
> +    {
> +        "BriefDescription": "Average latency of data read request to ext=
ernal 3D X-Point memory [in nanoseconds]. Accounts for demand loads and L1/=
L2 data-read prefetches",
> +        "MetricExpr": "( 1000000000 * ( UNC_CHA_TOR_OCCUPANCY.IA_MISS_DR=
D_PMM / UNC_CHA_TOR_INSERTS.IA_MISS_DRD_PMM ) / cha_0@event\\=3D0x0@ )",
> +        "MetricGroup": "MemoryLat;SoC;Server",
> +        "MetricName": "MEM_PMM_Read_Latency"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for reads=
 [GB / sec]",
> +        "MetricExpr": "( ( 64 * imc@event\\=3D0xe3@ / 1000000000 ) / dur=
ation_time )",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Read_BW"
> +    },
> +    {
> +        "BriefDescription": "Average 3DXP Memory Bandwidth Use for Write=
s [GB / sec]",
> +        "MetricExpr": "( ( 64 * imc@event\\=3D0xe7@ / 1000000000 ) / dur=
ation_time )",
> +        "MetricGroup": "MemoryBW;SoC;Server",
> +        "MetricName": "PMM_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use =
for Writes [GB / sec]",
> +        "MetricExpr": "UNC_CHA_TOR_INSERTS.IO_PCIRDCUR * 64 / 1000000000=
 / duration_time",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Write_BW"
> +    },
> +    {
> +        "BriefDescription": "Average IO (network or disk) Bandwidth Use =
for Reads [GB / sec]",
> +        "MetricExpr": "( UNC_CHA_TOR_INSERTS.IO_HIT_ITOM + UNC_CHA_TOR_I=
NSERTS.IO_MISS_ITOM + UNC_CHA_TOR_INSERTS.IO_HIT_ITOMCACHENEAR + UNC_CHA_TO=
R_INSERTS.IO_MISS_ITOMCACHENEAR ) * 64 / 1000000000 / duration_time",
> +        "MetricGroup": "IoBW;SoC;Server",
> +        "MetricName": "IO_Read_BW"
> +    },
> +    {
> +        "BriefDescription": "Socket actual clocks when any core is activ=
e on that socket",
> +        "MetricExpr": "cha_0@event\\=3D0x0@",
> +        "MetricGroup": "SoC",
> +        "MetricName": "Socket_CLKS"
> +    },
> +    {
> +        "BriefDescription": "Instructions per Far Branch ( Far Branches =
apply upon transition from application to operating system, handling interr=
upts, exceptions) [lower number means higher occurrence rate]",
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
> --
> 2.17.1
>
