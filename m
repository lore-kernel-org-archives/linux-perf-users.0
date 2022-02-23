Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71B6C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 16:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239054AbiBWQtD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 11:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbiBWQtB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 11:49:01 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C47D2409E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 08:48:33 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2d79394434dso75147677b3.5
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 08:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GLyN3TRZPlqJ5RwOtJrQLG6H3Ss7auyjkJskhRZNtj4=;
        b=b76slybem1Fn/0Dv+dTvp9xRx5aXkmajcuqYCQDwPeHcWYWVIZqMcvkHdDGPXYYYYL
         E0mAd3gR/HZJRFxT2sHbkSOhY1pqjk91n5R30x7EX0hM5QrF876qWoA3q0PCXu/tUJXL
         VamqZfcemmSf+9ivicuS4F8+6O279UZto1Jm1thVODdrapOYftUsA4SAKLtRQwBLLulD
         JgGwmq5OJuKnMjPm57uPT9v9v4Mks5vDETykwXKY/Zbz3BbhN+PV7Lu3UuC0yTWcHLfT
         BQFFDMVJ245zafHtj9x12xnr0ZhxICIQkCOt58NP9YLKAfYKyw3aY5N5G1f9LVE1kYhR
         9Kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GLyN3TRZPlqJ5RwOtJrQLG6H3Ss7auyjkJskhRZNtj4=;
        b=ImSkOlTHaVOyrUEI+hg3pNl5mMeOgy4Pc4lwrvk7vocptzolQRikwBqnT/YAYhl955
         sTRtj8tnBjdLJVLsA1rBkGHirKOdpzJ4YGpPXOmojqI5ozoTSWN0RjOaRVbsQ7YpHjeF
         8m/xwEujCuxIV/FjgBeaEJqWO/2bea0a97ZA7e0eMcDLE+NoMFg8/uz1qWLhmcBKDWnv
         HA7nYkefVBzG6e2B87ZIDudempn+77/mzfZLuHHPSr3G01lTR1hehCfHtFTbfG2YlAGC
         2wy1uc5Riluw+eu3HE8eizbpogy/BV3O8VcfXGKeAt+XA72vBp5fWd/LxivvW/93vDHS
         rcKQ==
X-Gm-Message-State: AOAM533QhxLTUFQ3Rbz+CrCGNSp9Econ+OqxXCy2tQM32Wt/Gbcutj7I
        gDPG77tDT6xBID6nJk0Y/5ShlmMdThaFPb4MmLzdyg==
X-Google-Smtp-Source: ABdhPJwgSVsCB2stPxsXkzt3E/eFSLY1Ukwn5NVLWhMpEDekfQnDELF8ivALo2R2H3M/Tt10RAjk52I/cAzF9PdA/cg=
X-Received: by 2002:a81:57d0:0:b0:2d0:cd0d:6007 with SMTP id
 l199-20020a8157d0000000b002d0cd0d6007mr472771ywb.454.1645634911839; Wed, 23
 Feb 2022 08:48:31 -0800 (PST)
MIME-Version: 1.0
References: <20220223110135.1943210-1-zhengjun.xing@linux.intel.com>
In-Reply-To: <20220223110135.1943210-1-zhengjun.xing@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 23 Feb 2022 08:48:19 -0800
Message-ID: <CAP-5=fXWZ1vJqfU4TXedGVYNpj-RjVsQsrtggnGMZQR9C0-Yew@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf vendor events intel: Add uncore event list for Alderlake
To:     zhengjun.xing@linux.intel.com
Cc:     acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@intel.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 22, 2022 at 7:02 PM <zhengjun.xing@linux.intel.com> wrote:
>
> From: Zhengjun Xing <zhengjun.xing@linux.intel.com>
>
> Add JSON uncore events for Alderlake to perf.
>
> Based on JSON list v1.06:
>
> https://download.01.org/perfmon/ADL/

Acked-by: Ian Rogers <irogers@google.com>

Could you post the uncore csv file on:
https://github.com/intel/event-converter-for-linux-perf
For example, the skylakex one is:
https://github.com/intel/event-converter-for-linux-perf/blob/master/perf-un=
core-events-skx.csv

Thanks,
Ian

> Signed-off-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> ---
>  .../arch/x86/alderlake/uncore-memory.json     | 222 ++++++++++++++++++
>  .../arch/x86/alderlake/uncore-other.json      |  40 ++++
>  2 files changed, 262 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-memor=
y.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/alderlake/uncore-other=
.json
>
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json =
b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
> new file mode 100644
> index 000000000000..d82d6f62a6fb
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-memory.json
> @@ -0,0 +1,222 @@
> +[
> +    {
> +        "BriefDescription": "Number of clocks",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x01",
> +        "EventName": "UNC_M_CLOCKTICKS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC0 read request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x02",
> +        "EventName": "UNC_M_VC0_REQUESTS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC0 write request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x03",
> +        "EventName": "UNC_M_VC0_REQUESTS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC1 read request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x04",
> +        "EventName": "UNC_M_VC1_REQUESTS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming VC1 write request",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x05",
> +        "EventName": "UNC_M_VC1_REQUESTS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Incoming read prefetch request from IA",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x0A",
> +        "EventName": "UNC_M_PREFETCH_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Any Rank at Hot state",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x19",
> +        "EventName": "UNC_M_DRAM_THERMAL_HOT",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Any Rank at Warm state",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1A",
> +        "EventName": "UNC_M_DRAM_THERMAL_WARM",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page H=
it",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1C",
> +        "EventName": "UNC_M_DRAM_PAGE_HIT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page E=
mpty",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1D",
> +        "EventName": "UNC_M_DRAM_PAGE_EMPTY_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming read request page status is Page M=
iss",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1E",
> +        "EventName": "UNC_M_DRAM_PAGE_MISS_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Hit",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x1F",
> +        "EventName": "UNC_M_DRAM_PAGE_HIT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Empty",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x20",
> +        "EventName": "UNC_M_DRAM_PAGE_EMPTY_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "incoming write request page status is Page =
Miss",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x21",
> +        "EventName": "UNC_M_DRAM_PAGE_MISS_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Read CAS command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x22",
> +        "EventName": "UNC_M_CAS_COUNT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Write CAS command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x23",
> +        "EventName": "UNC_M_CAS_COUNT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command for a read request sent to DRAM=
",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x24",
> +        "EventName": "UNC_M_ACT_COUNT_RD",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command for a write request sent to DRA=
M",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x25",
> +        "EventName": "UNC_M_ACT_COUNT_WR",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "ACT command sent to DRAM",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x26",
> +        "EventName": "UNC_M_ACT_COUNT_TOTAL",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "PRE command sent to DRAM for a read/write r=
equest",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x27",
> +        "EventName": "UNC_M_PRE_COUNT_PAGE_MISS",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "PRE command sent to DRAM due to page table =
idle timer expiration",
> +        "Counter": "0,1,2,3,4",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x28",
> +        "EventName": "UNC_M_PRE_COUNT_IDLE",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B read  request entering the=
 Memory Controller 0 to DRAM (sum of all channels)",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC0_RDCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B read request entering the =
Memory Controller 1 to DRAM (sum of all channels)",
> +        "Counter": "3",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC1_RDCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B write request entering the=
 Memory Controller 0 to DRAM (sum of all channels). Each write request coun=
ts as a new request incrementing this counter. However, same cache line wri=
te requests (both full and partial) are combined to a single 64 byte data t=
ransfer to DRAM",
> +        "Counter": "1",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC0_WRCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    },
> +    {
> +        "BriefDescription": "Counts every 64B write request entering the=
 Memory Controller 1 to DRAM (sum of all channels). Each write request coun=
ts as a new request incrementing this counter. However, same cache line wri=
te requests (both full and partial) are combined to a single 64 byte data t=
ransfer to DRAM",
> +        "Counter": "4",
> +        "CounterType": "FREERUN",
> +        "EventName": "UNC_MC1_WRCAS_COUNT_FREERUN",
> +        "PerPkg": "1",
> +        "Unit": "iMC"
> +    }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json b=
/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
> new file mode 100644
> index 000000000000..50de82c29944
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/alderlake/uncore-other.json
> @@ -0,0 +1,40 @@
> +[
> +    {
> +        "BriefDescription": "This 48-bit fixed counter counts the UCLK c=
ycles",
> +        "Counter": "Fixed",
> +        "CounterType": "PGMABLE",
> +       "EventCode": "0xff",
> +        "EventName": "UNC_CLOCK.SOCKET",
> +        "PerPkg": "1",
> +        "Unit": "CLOCK"
> +    },
> +    {
> +        "BriefDescription": "Counts the number of coherent and in-cohere=
nt requests initiated by IA cores, processor graphic units, or LLC",
> +        "Counter": "0,1",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x81",
> +        "EventName": "UNC_ARB_TRK_REQUESTS.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Number of requests allocated in Coherency T=
racker",
> +        "Counter": "0,1",
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x84",
> +        "EventName": "UNC_ARB_COH_TRK_REQUESTS.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    },
> +    {
> +        "BriefDescription": "Each cycle counts number of all outgoing va=
lid entries in ReqTrk. Such entry is defined as valid from its allocation i=
n ReqTrk till deallocation. Accounts for Coherent and non-coherent traffic"=
,
> +        "CounterType": "PGMABLE",
> +        "EventCode": "0x80",
> +        "EventName": "UNC_ARB_TRK_OCCUPANCY.ALL",
> +        "PerPkg": "1",
> +        "UMask": "0x01",
> +        "Unit": "ARB"
> +    }
> +]
> --
> 2.25.1
>
