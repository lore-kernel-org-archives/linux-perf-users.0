Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6E5C001DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjHNRsU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 13:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbjHNRsN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 13:48:13 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B5A8
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:48:11 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-40c72caec5cso31371cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692035290; x=1692640090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wx27/VYPTMxAxjaAN9DEXK9qNiPz4ryX9R5OjaawKuc=;
        b=5NQR4eDLIij018+IoyG6mW0krvPlsG9Dkt6CNQzut5095IJdZ49sAvKj12It3tKnW/
         i3phu+yVlyHQWHTQdoEGm4rMuZuaXL9PY8tN4SA+gjoXWDJCJOvEhyiol+qGYxNLQHne
         45+HMnfbwwDIOYydtG0u6YVJYyohEvz4PSIwiL3N1YL09xZ1MwZSXravOG5YiFVv0nCh
         awtUZqiBN+yo7/1zQzyvClRmpHbbUDsN4P4aAbSv6Sut4eHBSA5dFm+/ORxWkA13xKL/
         /YDYlSvzg7csojr9zPQvTDs5Gu/llY1lZXadg4iu2DwwTTghL1jQIzldBGWMWfJZ5XgZ
         ToDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692035290; x=1692640090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wx27/VYPTMxAxjaAN9DEXK9qNiPz4ryX9R5OjaawKuc=;
        b=h0gn585VJTRB4mR66GpdTpy+mTIlScF7b9Yyx+diFPGIhWtjgMHSIIBtvo3CJ1B7Kd
         To9vwuFZzNmGW7iZiPrNU5mQszUCarB9BDFTWt0l+3wXR89nyI4kuoLmLvdWXbTBsRGf
         s5oEmidUNXKo/B9gCvKg1NvxJCS5adMJCrGEb8a+u20EojzcNMmK7WVE5BLM/7N9PKzv
         Vu72ENej2oC8tBJlYQ/rWfz8Wa6d/V9PMaHkBASl3ehcBhzp9zad7qwGuMUbBckyVhpH
         c287MKwsgWtWGyTiT3SpQr+/n/bmMyewI+0hNIa4mXnpVHnDTgJJmpGt7eTSCrtlgUnc
         Jqzw==
X-Gm-Message-State: AOJu0Yx/wQjOMppg89kqOos7WjzEGXVFcC4+Glvqy8OS2sIo7qbGgUja
        oBEel+XAYV/mhZAZth+b6mWv4PZupTP1IoQ3blHRLA==
X-Google-Smtp-Source: AGHT+IFskiRM+QltVsVTo7a6VgCm2iDzDRAYY38QirSfGp44om9TkgCOXS05pKBps2JEZbJUSeVW9ToM791yF6OWqbA=
X-Received: by 2002:ac8:58c2:0:b0:403:a43d:bd7d with SMTP id
 u2-20020ac858c2000000b00403a43dbd7dmr699439qta.4.1692035290434; Mon, 14 Aug
 2023 10:48:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230803211331.140553-1-ilkka@os.amperecomputing.com> <20230803211331.140553-4-ilkka@os.amperecomputing.com>
In-Reply-To: <20230803211331.140553-4-ilkka@os.amperecomputing.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 10:47:59 -0700
Message-ID: <CAP-5=fXYyt8EYMh4SLb3xSokUW0-pOtDo_HK+jbUoTFcvbyrqw@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf vendor events arm64: Add AmpereOne metrics
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 3, 2023 at 2:14=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> This patch adds AmpereOne metrics. The metrics also work around
> the issue related to some of the events.
>
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> ---
>  .../arch/arm64/ampere/ampereone/metrics.json  | 362 ++++++++++++++++++
>  1 file changed, 362 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/ampere/ampereone/met=
rics.json
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> new file mode 100644
> index 000000000000..1e7e8901a445
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -0,0 +1,362 @@
> +[
> +    {
> +       "MetricExpr": "BR_MIS_PRED / BR_PRED",
> +       "BriefDescription": "Branch predictor misprediction rate. May not=
 count branches that are never resolved because they are in the mispredicti=
on shadow of an earlier branch",
> +       "MetricGroup": "Branch Prediction",
> +       "MetricName": "Misprediction"
> +    },
> +    {
> +       "MetricExpr": "BR_MIS_PRED_RETIRED / BR_RETIRED",
> +       "BriefDescription": "Branch predictor misprediction rate",
> +       "MetricGroup": "Branch Prediction",
> +       "MetricName": "Misprediction (retired)"
> +    },
> +    {
> +       "MetricExpr": "BUS_ACCESS / ( BUS_CYCLES * 1)",
> +       "BriefDescription": "Core-to-uncore bus utilization",
> +       "MetricGroup": "Bus",
> +       "MetricName": "Bus utilization"
> +    },
> +    {
> +       "MetricExpr": "L1D_CACHE_REFILL / L1D_CACHE",
> +       "BriefDescription": "L1D cache miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L1D cache miss"
> +    },
> +    {
> +       "MetricExpr": "L1D_CACHE_LMISS_RD / L1D_CACHE_RD",
> +       "BriefDescription": "L1D cache read miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L1D cache read miss"
> +    },
> +    {
> +       "MetricExpr": "L1I_CACHE_REFILL / L1I_CACHE",
> +       "BriefDescription": "L1I cache miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L1I cache miss"
> +    },
> +    {
> +       "MetricExpr": "L2D_CACHE_REFILL / L2D_CACHE",
> +       "BriefDescription": "L2 cache miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L2 cache miss"

I'm a bit concerned with spaces in metric names. There's logic to
replace/rewrite metrics in terms of each other:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/metric.py?h=3Dperf-tools-next#n561
but spaces in rewritten metric name would break this as spaces are separato=
rs.

Thanks,
Ian

> +    },
> +    {
> +       "MetricExpr": "L1I_CACHE_LMISS / L1I_CACHE",
> +       "BriefDescription": "L1I cache read miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L1I cache read miss"
> +    },
> +    {
> +       "MetricExpr": "L2D_CACHE_LMISS_RD / L2D_CACHE_RD",
> +       "BriefDescription": "L2 cache read miss rate",
> +       "MetricGroup": "Cache",
> +       "MetricName": "L2 cache read miss"
> +    },
> +    {
> +       "MetricExpr": "(L1D_CACHE_LMISS_RD * 1000) / INST_RETIRED",
> +       "BriefDescription": "Misses per thousand instructions (data)",
> +       "MetricGroup": "Cache",
> +       "MetricName": "MPKI data"
> +    },
> +    {
> +       "MetricExpr": "(L1I_CACHE_LMISS * 1000) / INST_RETIRED",
> +       "BriefDescription": "Misses per thousand instructions (instructio=
n)",
> +       "MetricGroup": "Cache",
> +       "MetricName": "MPKI instruction"
> +    },
> +    {
> +       "MetricExpr": "ASE_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of advanced SIMD data processing =
operations (excluding DP_SPEC/LD_SPEC) operations",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "ASE mix"
> +    },
> +    {
> +       "MetricExpr": "CRYPTO_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of crypto data processing operati=
ons",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "Crypto mix"
> +    },
> +    {
> +       "MetricExpr": "VFP_SPEC / (duration_time *1000000000)",
> +       "BriefDescription": "Giga-floating point operations per second",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "GFLOPS_ISSUED"
> +    },
> +    {
> +       "MetricExpr": "DP_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of integer data processing operat=
ions",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "Integer mix"
> +    },
> +    {
> +       "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> +       "BriefDescription": "Instructions per cycle",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "IPC"
> +    },
> +    {
> +       "MetricExpr": "LD_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of load operations",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "Load mix"
> +    },
> +    {
> +       "MetricExpr": "LDST_SPEC/ OP_SPEC",
> +       "BriefDescription": "Proportion of load & store operations",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "Load-store mix"
> +    },
> +    {
> +       "MetricExpr": "INST_RETIRED / (duration_time * 1000000)",
> +       "BriefDescription": "Millions of instructions per second",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "MIPS_RETIRED"
> +    },
> +    {
> +       "MetricExpr": "INST_SPEC / (duration_time * 1000000)",
> +       "BriefDescription": "Millions of instructions per second",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "MIPS_UTILIZATION"
> +    },
> +    {
> +       "MetricExpr": "PC_WRITE_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of software change of PC operatio=
ns",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "PC write mix"
> +    },
> +    {
> +       "MetricExpr": "ST_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of store operations",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "Store mix"
> +    },
> +    {
> +       "MetricExpr": "VFP_SPEC / OP_SPEC",
> +       "BriefDescription": "Proportion of FP operations",
> +       "MetricGroup": "Instruction",
> +       "MetricName": "VFP mix"
> +    },
> +    {
> +       "MetricExpr": "1 - (OP_RETIRED/ (CPU_CYCLES * 4))",
> +       "BriefDescription": "Proportion of slots lost",
> +       "MetricGroup": "Speculation / TDA",
> +       "MetricName": "CPU lost"
> +    },
> +    {
> +       "MetricExpr": "OP_RETIRED/ (CPU_CYCLES * 4)",
> +       "BriefDescription": "Proportion of slots retiring",
> +       "MetricGroup": "Speculation / TDA",
> +       "MetricName": "CPU utilization"
> +    },
> +    {
> +       "MetricExpr": "OP_RETIRED - OP_SPEC",
> +       "BriefDescription": "Operations lost due to misspeculation",
> +       "MetricGroup": "Speculation / TDA",
> +       "MetricName": "Operations lost"
> +    },
> +    {
> +       "MetricExpr": "1 - (OP_RETIRED / OP_SPEC)",
> +       "BriefDescription": "Proportion of operations lost",
> +       "MetricGroup": "Speculation / TDA",
> +       "MetricName": "Operations lost (ratio)"
> +    },
> +    {
> +       "MetricExpr": "OP_RETIRED / OP_SPEC",
> +       "BriefDescription": "Proportion of operations retired",
> +       "MetricGroup": "Speculation / TDA",
> +       "MetricName": "Operations retired"
> +    },
> +    {
> +       "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
> +       "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and cache miss",
> +       "MetricGroup": "Stall",
> +       "MetricName": "Stall backend cache cycles"
> +    },
> +    {
> +       "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
> +       "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and resource full",
> +       "MetricGroup": "Stall",
> +       "MetricName": "Stall backend resource cycles"
> +    },
> +    {
> +       "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
> +       "BriefDescription": "Proportion of cycles stalled and no operatio=
ns issued to backend and TLB miss",
> +       "MetricGroup": "Stall",
> +       "MetricName": "Stall backend tlb cycles"
> +    },
> +    {
> +       "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> +       "BriefDescription": "Proportion of cycles stalled and no ops deli=
vered from frontend and cache miss",
> +       "MetricGroup": "Stall",
> +       "MetricName": "Stall frontend cache cycles"
> +    },
> +    {
> +       "MetricExpr": "STALL_FRONTEND_TLB / CPU_CYCLES",
> +       "BriefDescription": "Proportion of cycles stalled and no ops deli=
vered from frontend and TLB miss",
> +       "MetricGroup": "Stall",
> +       "MetricName": "Stall frontend tlb cycles"
> +    },
> +    {
> +       "MetricExpr": "DTLB_WALK / L1D_TLB",
> +       "BriefDescription": "D-side walk per d-side translation request",
> +       "MetricGroup": "TLB",
> +       "MetricName": "DTLB walks"
> +    },
> +    {
> +       "MetricExpr": "ITLB_WALK / L1I_TLB",
> +       "BriefDescription": "I-side walk per i-side translation request",
> +       "MetricGroup": "TLB",
> +       "MetricName": "ITLB walks"
> +    },
> +    {
> +        "MetricExpr": "STALL_SLOT_BACKEND / (CPU_CYCLES * 4)",
> +        "BriefDescription": "Fraction of slots backend bound",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "backend"
> +    },
> +    {
> +        "MetricExpr": "1 - (retiring + lost + backend)",
> +        "BriefDescription": "Fraction of slots frontend bound",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "frontend"
> +    },
> +    {
> +        "MetricExpr": "((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * 4))",
> +        "BriefDescription": "Fraction of slots lost due to misspeculatio=
n",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "lost"
> +    },
> +    {
> +        "MetricExpr": "(OP_RETIRED / (CPU_CYCLES * 4))",
> +        "BriefDescription": "Fraction of slots retiring, useful work",
> +        "MetricGroup": "TopDownL1",
> +        "MetricName": "retiring"
> +    },
> +    {
> +        "MetricExpr": "backend - backend_memory",
> +        "BriefDescription": "Fraction of slots the CPU was stalled due t=
o backend non-memory subsystem issues",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "backend_core"
> +    },
> +    {
> +        "MetricExpr": "(STALL_BACKEND_TLB + STALL_BACKEND_CACHE + STALL_=
BACKEND_MEM) / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of slots the CPU was stalled due t=
o backend memory subsystem issues (cache/tlb miss)",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "backend_memory"
> +    },
> +    {
> +        "MetricExpr": " (BR_MIS_PRED_RETIRED / GPC_FLUSH) * lost",
> +        "BriefDescription": "Fraction of slots lost due to branch mispre=
diciton",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "branch_mispredict"
> +    },
> +    {
> +        "MetricExpr": "frontend - frontend_latency",
> +        "BriefDescription": "Fraction of slots the CPU did not dispatch =
at full bandwidth - able to dispatch partial slots only (1, 2, or 3 uops)",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "frontend_bandwidth"
> +    },
> +    {
> +        "MetricExpr": "(STALL_FRONTEND - ((STALL_SLOT_FRONTEND - (fronte=
nd * CPU_CYCLES * 4)) / 4)) / CPU_CYCLES",
> +        "BriefDescription": "Fraction of slots the CPU was stalled due t=
o frontend latency issues (cache/tlb miss); nothing to dispatch",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "frontend_latency"
> +    },
> +    {
> +        "MetricExpr": "lost - branch_mispredict",
> +        "BriefDescription": "Fraction of slots lost due to other/non-bra=
nch misprediction misspeculation",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "other_clears"
> +    },
> +    {
> +        "MetricExpr": "(IXU_NUM_UOPS_ISSUED + FSU_ISSUED) / (CPU_CYCLES =
* 6)",
> +        "BriefDescription": "Fraction of execute slots utilized",
> +        "MetricGroup": "TopDownL2",
> +        "MetricName": "pipe_utilization"
> +    },
> +    {
> +        "MetricExpr": "STALL_BACKEND_MEM / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data L2 cache miss",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "d_cache_l2_miss"
> +    },
> +    {
> +        "MetricExpr": "STALL_BACKEND_CACHE / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data cache miss",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "d_cache_miss"
> +    },
> +    {
> +        "MetricExpr": "STALL_BACKEND_TLB / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to data TLB miss",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "d_tlb_miss"
> +    },
> +    {
> +        "MetricExpr": "FSU_ISSUED / (CPU_CYCLES * 2)",
> +        "BriefDescription": "Fraction of FSU execute slots utilized",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "fsu_pipe_utilization"
> +    },
> +    {
> +        "MetricExpr": "STALL_FRONTEND_CACHE / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to instruction cache miss",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "i_cache_miss"
> +    },
> +    {
> +        "MetricExpr": " STALL_FRONTEND_TLB / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to instruction TLB miss",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "i_tlb_miss"
> +    },
> +    {
> +        "MetricExpr": "IXU_NUM_UOPS_ISSUED / (CPU_CYCLES / 4)",
> +        "BriefDescription": "Fraction of IXU execute slots utilized",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "ixu_pipe_utilization"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_FLUSH / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to flush recovery",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "recovery"
> +    },
> +    {
> +        "MetricExpr": "STALL_BACKEND_RESOURCE / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled due =
to core resource shortage",
> +        "MetricGroup": "TopDownL3",
> +        "MetricName": "resource"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_FSU_SCHED / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled and =
FSU was full",
> +        "MetricGroup": "TopDownL4",
> +        "MetricName": "stall_fsu_sched"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_IXU_SCHED / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled and =
IXU was full",
> +        "MetricGroup": "TopDownL4",
> +        "MetricName": "stall_ixu_sched"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_LOB_ID / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled and =
LOB was full",
> +        "MetricGroup": "TopDownL4",
> +        "MetricName": "stall_lob_id"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_ROB_ID / CPU_CYCLES",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled and =
ROB was full",
> +        "MetricGroup": "TopDownL4",
> +        "MetricName": "stall_rob_id"
> +    },
> +    {
> +        "MetricExpr": "IDR_STALL_SOB_ID / CPU_CYCLES ",
> +        "BriefDescription": "Fraction of cycles the CPU was stalled and =
SOB was full",
> +        "MetricGroup": "TopDownL4",
> +        "MetricName": "stall_sob_id"
> +    }
> +]
> --
> 2.40.1
>
