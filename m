Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5796CC433FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Nov 2022 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiK3S64 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Nov 2022 13:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiK3S6v (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Nov 2022 13:58:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF094092D
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 10:58:50 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f18so6569894wrj.5
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Nov 2022 10:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=87ENfYXIDebjZ9OJXAGQbQFZb77jhLjiCr56B3zGCYY=;
        b=awR/NO0ZrJmArjac1OjpJ/hysKu0BXmmhK8kas2lLXQ+lsZruBp/T+e8hBth93qQrB
         d7rk8OH4vXzbf56ZmY4FgdUQ2SHYRoh2mNK64pFP3pqZf9WZtrdKJFyeU8Ku4xTNrJ3E
         flLan7iV9TCIELgZkoDeTCLcslMoavpnvel7apsXmboEtZ/maaQMY3yPlmhrPcfPKZ8N
         a1uJ518MPpe+qGw7dfbOQD7WaRRgoNFax++FUY5/7vH4VykzKmLN/EG6T7kGN9RnuT53
         3+EYKu30lgSfSFDH238akOIpU//OgoPq3P/KWU27lenRibpXgP84HvhlT/Lhyk/e4cjW
         Nz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=87ENfYXIDebjZ9OJXAGQbQFZb77jhLjiCr56B3zGCYY=;
        b=XkzgQBRYPI+y+fB4qFfNBTyC/uiaPL1k3eSdpMixPyty+ZRd7GLHQS5XMUH6opgC5c
         Wv7nPYQXI0qoB+2eYPa001rnyHvYmFBhX36Zwz9B2EF0PO0NsHVt7mNJtQNNYDlNTJKt
         SenDCKDjvamBp0uJv/jKXDBn870dVk3KHyVEmijKwcjGnGsdQXANE18DtKBVXR5GkVGe
         zLJDBwL8PMV9iJ1AAX68CqoosDDCF2432P7bTORVqdgAhhzujhizj3laMnZdM28YJe2Q
         DNNc/TLcIbPEEuzawTp7O+PLB/csCTusnCqJCLt6vjdfzxFZkIoRX/DvaYqBf1GxGlq7
         nl8Q==
X-Gm-Message-State: ANoB5pm40yXso7nFsBCEkJPc2+kY9fG2cEuhLE/JtXrJRJzU9TdRRkMN
        h1hle6FiRRlYXl+WcpIBAN3R8PzQDlmLZxFgTqS5AA==
X-Google-Smtp-Source: AA0mqf6pNJJwFRwvQ9Nbbx/FXqmlOjbohE6MouQre6Ex1OPGnWlI+tSuTGt1dEi3R3LZe0wMGhbdS/xShyGraTWY2ls=
X-Received: by 2002:adf:e2c9:0:b0:241:db86:176d with SMTP id
 d9-20020adfe2c9000000b00241db86176dmr28759168wrj.40.1669834729092; Wed, 30
 Nov 2022 10:58:49 -0800 (PST)
MIME-Version: 1.0
References: <1668411720-3581-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1669310088-13482-1-git-send-email-renyu.zj@linux.alibaba.com> <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1669310088-13482-6-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 30 Nov 2022 10:58:37 -0800
Message-ID: <CAP-5=fV0WSTK=MT6K2nqsqYT6xCTg7Pv_rXahHFeRhV0ZHCiEQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] perf vendor events arm64: Add PE utilization
 metrics for neoverse-n2
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Nov 24, 2022 at 9:15 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> Add PE utilization related metrics.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> index 23c7d62..7b54819 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -189,5 +189,50 @@
>          "MetricGroup": "Branch",
>          "MetricName": "branch_miss_pred_rate",
>          "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "instructions / CPU_CYCLES",
> +        "PublicDescription": "The average number of instructions executed for each cycle.",
> +        "BriefDescription": "Instructions per cycle",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "ipc"
> +    },

A related useful metric is percentage of peak, so if the peak IPC is 8
(usually a constant related to the number of functional units) then
you can just compute the ratio of IPC with this.

> +    {
> +        "MetricExpr": "INST_RETIRED / CPU_CYCLES",
> +        "PublicDescription": "Architecturally executed Instructions Per Cycle (IPC)",
> +        "BriefDescription": "Architecturally executed Instructions Per Cycle (IPC)",


The duplicated descriptions are unnecessary. Drop the public one for
consistency with what we do for Intel:
https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py#L299

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "retired_ipc"
> +    },
> +    {
> +        "MetricExpr": "INST_SPEC / CPU_CYCLES",
> +        "PublicDescription": "Speculatively executed Instructions Per Cycle (IPC)",
> +        "BriefDescription": "Speculatively executed Instructions Per Cycle (IPC)",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "spec_ipc"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / OP_SPEC",
> +        "PublicDescription": "Fraction of operations retired",
> +        "BriefDescription": "Fraction of operations retired",

Would instructions be clearer than operations here?

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "retired_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "1 - OP_RETIRED / OP_SPEC",

Should OP_RETIRED be greater than OP_SPEC? In which case won't this
metric be negative?

> +        "PublicDescription": "Fraction of operations wasted",
> +        "BriefDescription": "Fraction of operations wasted",
> +        "MetricGroup": "PEutilization",
> +        "MetricName": "wasted_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "OP_RETIRED / OP_SPEC * (1 - (STALL_SLOT - CPU_CYCLES) / (CPU_CYCLES * 5))",
> +        "PublicDescription": "Utilization of CPU",
> +        "BriefDescription": "Utilization of CPU",

Some more detail in the description would be useful.

> +        "MetricGroup": "PEutilization",
> +        "MetricName": "cpu_utilization",
> +        "ScaleUnit": "100%"
>      }
>  ]
> --
> 1.8.3.1
>
