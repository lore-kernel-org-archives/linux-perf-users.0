Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0134C61DA4
	for <linux-perf-users@archiver.kernel.org>; Mon, 13 Mar 2023 15:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjCMPWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 13 Mar 2023 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCMPWK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 13 Mar 2023 11:22:10 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773A16F49C
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:22:09 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-53916ab0c6bso248467277b3.7
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Mar 2023 08:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678720928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KIirSw/hZG6Knd8g/0d8FTYdGwbw04UvbKt8SdtEMds=;
        b=pUqoI8n2FFvSJ75U0mQW3hso4d0ccj6gO7Nm+PMEbXV7srmwpvUx/Z8mmcal49/bqu
         76xTnZFme9MJqpvgT/DJFGm945aZMkDR9h3uepcRVjC5scANlW61V3Y1oP4wJAmQ+E77
         S65SrsisT1gXNbHL/pGqAzIbmpEVykrXVvh4LxJuSdJCEGNlxisfABLzvYD6NDV/p2bN
         c95i/WTYhgNwGHBLVjXPdjuugIkVlc8uhAMQOKGaJ7XNYDxJo4PCq3C9KJdGtW11jsdS
         GIYJQegJaJ+T0pBk9F5WbD6UDQEidMVjyuP+x6Wwo48HT04J8wPFGBFG+IzBSdw6XgZo
         XUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678720928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KIirSw/hZG6Knd8g/0d8FTYdGwbw04UvbKt8SdtEMds=;
        b=sW9DGbqScDgShoAATdMWS0/nl44AmWoTMPDoHu79BHPF7ihiPOOntbmq/4i4gwnpgs
         WT1P1bytzTci2C8qPyDp39IuJbtD/CSyqdEBW5b52P7gPHkUEOeRXS5zcYAomhGWf7Zt
         2zc5KP96khsQdnvFwBZ9Sq07Cel0reboxa0In1660P2jAYAxoALjeZY0uTOTHDtSvKwF
         i+NmIt29Bj2kShElCd6O4TYmCMgyw+CM9gIZd4A3c1J6XnPJTzbiuIspvl67ZILHDgGw
         Ld2p1ArY0D4DhhV/KoaoGBJQN95usHVcCjUGWCl/qzmxMHM7iZLhSKBuTtwU6FjKkSO6
         u+qw==
X-Gm-Message-State: AO0yUKVoA5zrM44RLWKNX0ska3fDBwxR8zpS29TyQz7LCLCxD5h2i6+p
        Fv1ttmeOocAu+w4JS261gLekSbN6cfc+IaXkMb+xMA==
X-Google-Smtp-Source: AK7set88EOorTCYe0sYEPjHrkUPLEBaOHMfN+ZIo+EM4OklcrE+1pw9HL4mP61K3jpnERWaDwA9ZtIhdL9jUpT2DXME=
X-Received: by 2002:a81:af5c:0:b0:540:e6c6:31e7 with SMTP id
 x28-20020a81af5c000000b00540e6c631e7mr5873887ywj.2.1678720928477; Mon, 13 Mar
 2023 08:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230313080201.2440201-1-tmricht@linux.ibm.com>
In-Reply-To: <20230313080201.2440201-1-tmricht@linux.ibm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 13 Mar 2023 08:21:56 -0700
Message-ID: <CAP-5=fUN=ZVmG6Ryv3QUxcxBfUOw4HURtfcTsi+X9c73QWJPnw@mail.gmail.com>
Subject: Re: [PATCH 1/6] tools/perf/json: Add common metrics for s390
To:     Thomas Richter <tmricht@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, sumanthk@linux.ibm.com, svens@linux.ibm.com,
        gor@linux.ibm.com, hca@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 13, 2023 at 1:06=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Add 3 metrics for s390 machines:
> - Cycles per instruction: Amount of CPU cycles used per instructions,
>   named cpi.
> - Problem state ratio: Ratio of instructions executed in problem state
>   compared to total number of instructions, named prbstate.
> - Level one instruction and data cache misses per 100 instructions,
>   named l1mp.
>
> For details about the formulas see this documentation:
> https://www.ibm.com/support/pages/system/files/inline-files/CPU%20MF%20Fo=
rmulas%20including%20z16%20-%20May%202022_1.pdf
>
> Outpuf after:
>  # ./perf stat -M cpi -- dd if=3D/dev/zero of=3D/dev/null bs=3D1M count=
=3D10K
>  10240+0 records in
>  10240+0 records out
>  10737418240 bytes (11 GB, 10 GiB) copied, 1.30151 s, 8.2 GB/s
>
> Performance counter stats for 'dd if=3D/dev/zero of=3D/dev/null .....':
>
>   6,779,778,802      CPU_CYCLES              #     1.96 cpi
>   3,461,975,090      INSTRUCTIONS
>
>   1.306873021 seconds time elapsed
>
>   0.001034000 seconds user
>   1.305677000 seconds sys
>  #
>
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-By: Sumanth Korikkar <sumanthk@linux.ibm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  .../pmu-events/arch/s390/cf_z13/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z14/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z15/transaction.json  | 15 +++++++++++++++
>  .../pmu-events/arch/s390/cf_z16/transaction.json  | 15 +++++++++++++++
>  4 files changed, 60 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z13/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z13/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z14/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z14/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z15/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z15/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> diff --git a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json b/to=
ols/perf/pmu-events/arch/s390/cf_z16/transaction.json
> index 1a0034f79f73..86bf83b4504e 100644
> --- a/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> +++ b/tools/perf/pmu-events/arch/s390/cf_z16/transaction.json
> @@ -3,5 +3,20 @@
>      "BriefDescription": "Transaction count",
>      "MetricName": "transaction",
>      "MetricExpr": "TX_C_TEND + TX_NC_TEND + TX_NC_TABORT + TX_C_TABORT_S=
PECIAL + TX_C_TABORT_NO_SPECIAL"
> +  },
> +  {
> +    "BriefDescription": "Cycles per Instruction",
> +    "MetricName": "cpi",
> +    "MetricExpr": "CPU_CYCLES / INSTRUCTIONS"
> +  },
> +  {
> +    "BriefDescription": "Problem State Instruction Ratio",
> +    "MetricName": "prbstate",
> +    "MetricExpr": "(PROBLEM_STATE_INSTRUCTIONS / INSTRUCTIONS) * 100"
> +  },
> +  {
> +    "BriefDescription": "Level One Miss per 100 Instructions",
> +    "MetricName": "l1mp",
> +    "MetricExpr": "((L1I_DIR_WRITES + L1D_DIR_WRITES) / INSTRUCTIONS) * =
100"
>    }
>  ]
> --
> 2.39.1
>
