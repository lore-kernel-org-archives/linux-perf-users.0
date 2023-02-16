Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE15FC636CC
	for <linux-perf-users@archiver.kernel.org>; Thu, 16 Feb 2023 18:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjBPSKY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjBPSKY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 16 Feb 2023 13:10:24 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBF0505F8
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Feb 2023 10:10:19 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id m10so2695906wrn.4
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Feb 2023 10:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u8BJ4MZYvude2UfZX0aEIl06W6KmazdVPxZc2eo82sw=;
        b=Lud5LhA8U1dXNoiIn8jCNMmTT0210E774uSxoedxEsUzgDC7JM+2mtD82zyRHl6IQk
         2Qw92Uz6TzegRzpxELyal1f179LIc07qWwreJ9vYphJLDdf9wzXbZYw+hvmjlb0tkeJN
         FhnNYO7MygtP9WAuP5teQNIWit0XHvqHLIHjf3gjHYeAxeWIAipGtb8LmpFOZ29m4Bji
         plzfiQb7DdtM5x2nhG0eJEOfr8TsaaGPS0RUKI71T/R7y8DsU6EkN2tD8b2iiprghZ+2
         tdwcRj23Xk/Za0ocnO8pexKw4+qWPY8l6TblXwYRCxzdS6lJkCvQQCiZp18uJoHw58Lf
         SBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8BJ4MZYvude2UfZX0aEIl06W6KmazdVPxZc2eo82sw=;
        b=UhMq4PVZyFHnvELZD5R0HnrlYfLn93XH1ahwFzUQVlZU7seNNzdQ+0GHVXWIBLyLJt
         OIO7W1AVhNMUBqk0E1m2hoic10jL2w5XmXSXRqifjZ6ONkXxqEUrd6KetHfRPWLUSESJ
         PP1IWN9RaqPIRjuGv32CSZSkoPiNg9bBk8al1SpZC6Oh+DpNzfmzUplvDbqWWaTDy7TN
         8F8/ZAXF6m7QPQElcoBEt2r9I2K8EHhTM04oxbZTcRfO4p9842Fh4nFSCeXaLlEva8hd
         jin3L7NRiJSzwLp+KoFD2CMQfrNr8XdTWkayHCGHh4OI9D8NCSiZ6z5XW+s27iB90Wuy
         nFJA==
X-Gm-Message-State: AO0yUKWQG8qqYGlvFRHcnSaPrdoOnhbedIMKgbU4wbwL5o7QqP1dIU98
        NIpy4FRPdmfMiTlcpMSxVEBezgNPrUR6O8czhPpUBA==
X-Google-Smtp-Source: AK7set8PFbTgnLUl+6xDV2jNK1je3uSP5oF36um1IU6MeHsSb+AkUme5G/OUYIQ0ITW0qySBLXOE3eEYR/fCQOy53kc=
X-Received: by 2002:a5d:6544:0:b0:2c5:4d9c:d206 with SMTP id
 z4-20020a5d6544000000b002c54d9cd206mr152633wrv.733.1676571017231; Thu, 16 Feb
 2023 10:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20230216061240.18067-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230216061240.18067-1-atrajeev@linux.vnet.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Feb 2023 10:10:05 -0800
Message-ID: <CAP-5=fWBb2=g82uVTkUbENThsnZyhzU+BHWVpuM7iYWDuA_TqA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/perf: Add json metric events to present CPI stall
 cycles in powerpc
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     mpe@ellerman.id.au, acme@kernel.org, jolsa@kernel.org,
        ak@linux.intel.com, namhyung@kernel.org, james.clark@arm.com,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.vnet.ibm.com, rnsastry@linux.ibm.com,
        kjain@linux.ibm.com, disgoel@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 15, 2023 at 10:12 PM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Power10 Performance Monitoring Unit (PMU) provides events
> to understand stall cycles of different pipeline stages.
> These events along with completed instructions provides
> useful metrics for application tuning.
>
> Patch implements the json changes to collect counter statistics
> to present the high level CPI stall breakdown metrics. New metric
> group is named as "CPI_STALL_RATIO" and this new metric group
> presents these stall metrics:
> - DISPATCHED_CPI ( Dispatch stall cycles per insn )
> - ISSUE_STALL_CPI ( Issue stall cycles per insn )
> - EXECUTION_STALL_CPI ( Execution stall cycles per insn )
> - COMPLETION_STALL_CPI ( Completition stall cycles per insn )
>
> To avoid multipling of events, PM_RUN_INST_CMPL event has been
> modified to use PMC5(performance monitoring counter5) instead
> of PMC4. This change is needed, since completion stall event
> is using PMC4.
>
> Usage example:
>
>  ./perf stat --metric-no-group -M CPI_STALL_RATIO <workload>
>
>  Performance counter stats for 'workload':
>
>     63,056,817,982      PM_CMPL_STALL                    #     0.28 COMPLETION_STALL_CPI
>  1,743,988,038,896      PM_ISSUE_STALL                   #     7.73 ISSUE_STALL_CPI
>    225,597,495,030      PM_RUN_INST_CMPL                 #     6.18 DISPATCHED_CPI
>                                                   #    37.48 EXECUTION_STALL_CPI
>  1,393,916,546,654      PM_DISP_STALL_CYC
>  8,455,376,836,463      PM_EXEC_STALL
>
> "--metric-no-group" is used for forcing PM_RUN_INST_CMPL to be scheduled
> in all group for more accuracy.
>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/powerpc/power10/metrics.json | 8 ++++----
>  tools/perf/pmu-events/arch/powerpc/power10/others.json  | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/metrics.json b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
> index b57526fa44f2..6f53583a0c62 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/metrics.json
> @@ -15,7 +15,7 @@
>      {
>          "BriefDescription": "Average cycles per completed instruction when dispatch was stalled for any reason",
>          "MetricExpr": "PM_DISP_STALL_CYC / PM_RUN_INST_CMPL",
> -        "MetricGroup": "CPI",
> +        "MetricGroup": "CPI;CPI_STALL_RATIO",
>          "MetricName": "DISPATCHED_CPI"
>      },
>      {
> @@ -147,13 +147,13 @@
>      {
>          "BriefDescription": "Average cycles per completed instruction when the NTC instruction has been dispatched but not issued for any reason",
>          "MetricExpr": "PM_ISSUE_STALL / PM_RUN_INST_CMPL",
> -        "MetricGroup": "CPI",
> +        "MetricGroup": "CPI;CPI_STALL_RATIO",
>          "MetricName": "ISSUE_STALL_CPI"
>      },
>      {
>          "BriefDescription": "Average cycles per completed instruction when the NTC instruction is waiting to be finished in one of the execution units",
>          "MetricExpr": "PM_EXEC_STALL / PM_RUN_INST_CMPL",
> -        "MetricGroup": "CPI",
> +        "MetricGroup": "CPI;CPI_STALL_RATIO",
>          "MetricName": "EXECUTION_STALL_CPI"
>      },
>      {
> @@ -309,7 +309,7 @@
>      {
>          "BriefDescription": "Average cycles per completed instruction when the NTC instruction cannot complete because the thread was blocked",
>          "MetricExpr": "PM_CMPL_STALL / PM_RUN_INST_CMPL",
> -        "MetricGroup": "CPI",
> +        "MetricGroup": "CPI;CPI_STALL_RATIO",
>          "MetricName": "COMPLETION_STALL_CPI"
>      },
>      {
> diff --git a/tools/perf/pmu-events/arch/powerpc/power10/others.json b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> index 7d0de1a2860b..a771e4b6bec5 100644
> --- a/tools/perf/pmu-events/arch/powerpc/power10/others.json
> +++ b/tools/perf/pmu-events/arch/powerpc/power10/others.json
> @@ -265,7 +265,7 @@
>      "BriefDescription": "Load Missed L1, counted at finish time."
>    },
>    {
> -    "EventCode": "0x400FA",
> +    "EventCode": "0x500FA",
>      "EventName": "PM_RUN_INST_CMPL",
>      "BriefDescription": "Completed PowerPC instructions gated by the run latch."
>    }
> --
> 2.31.1
>
