Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE7C54EF0
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Jan 2023 17:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjACRPO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Jan 2023 12:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbjACROb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Jan 2023 12:14:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54CC12AE8
        for <linux-perf-users@vger.kernel.org>; Tue,  3 Jan 2023 09:14:14 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h16so30197796wrz.12
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Jan 2023 09:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dILjtW+se+RiTAd73OiqiYVJH+pudeVFB34b0QFvmTo=;
        b=G0TX9GscmCJ4p3E2X0uu3KGl3FDTV929IWyw+lWUCJP3cosCm1XxD1bdnCL6f8AiQk
         mWqmvpyK/ytpjatqtfOe1BvO8cY1SV+B8HbpaWJMaIxbj9nXFikDkFSojfQmPx7iyjn3
         g6K2czhs3OIdLRA8K8yhc4kBZDX/7zTKPAVFVvsBMrWUYuXnOQxK2KvCa0+r6rwXNrxN
         nVT564l3FyOcmfWdT3lIMzJTdn+R3f8EQboseYdsH9/pvcihk5sliuewWVLeSa7a/wW0
         STa42bgmYplpr7fPybo9U8AQ6XY8UIUMRRqj67ZQcztXx42CVPXE/ekaiXGBoIY7AGYK
         xBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dILjtW+se+RiTAd73OiqiYVJH+pudeVFB34b0QFvmTo=;
        b=AsXFZ+G5CQWZ8lIr+bEwp/9Mzmjh2Dm3c34wWosJmbF65niXXmVPMUCHBXqZPT+/jk
         6RsL+UUe0r4DhkyDaKfFdpEXljzbjvbi2wO1FxMeHcrFX93LUfyh2920EMtFzjuHr3BY
         LE2VQe6ZjWt9UJLjA3II0/Z/EMXGwpj/jN1AiIaUk97P7I0BD2R1mdL7Kd1LWgfJy6ic
         7/d7tftu1uU73PlQWFClMFZl0SG0GOc/5mO68pHGuNbQopQFR1r4hTZzv0JEc002qIg9
         v8vRSM9OW8/78ii758LWbhmn7hsjiUfTH6Lo9yyVNSPNU5yUabJ3vzvAhVt+JBbSHauo
         rdIQ==
X-Gm-Message-State: AFqh2kqF5vSEuWgJw977vW15b8ZRUQ+R1NFiT0PpF3s3hTpbci8gcgpA
        wjsy0P7yUtHngtlPiaCFM7SuE4o6QMb0L7ICdEJCMQ==
X-Google-Smtp-Source: AMrXdXs8g7K9ljIylzMgBDfqvKOLj3TMJKq6JLOfSQP7yrLmL26s40KO8qPPaLLXQiIePrkfDLVgEDvHEyzhV0PPQdE=
X-Received: by 2002:a5d:45d0:0:b0:29c:52c7:3dce with SMTP id
 b16-20020a5d45d0000000b0029c52c73dcemr164450wrs.375.1672766053196; Tue, 03
 Jan 2023 09:14:13 -0800 (PST)
MIME-Version: 1.0
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com> <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 Jan 2023 09:14:01 -0800
Message-ID: <CAP-5=fVP_=FcEQChQwVpis9iyZsdb6NrVJQUo4GJA4_j=knfcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] perf vendor events arm64: Add TLB metrics for neoverse-n2
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

On Tue, Jan 3, 2023 at 3:39 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>
> Add TLB related metrics.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> Acked-by: Ian Rogers <irogers@google.com>
> ---
>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> index c126f1bc..8a74e07 100644
> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
> @@ -26,5 +26,54 @@
>          "MetricGroup": "TopdownL1",
>          "MetricName": "backend_bound",
>          "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
> +        "BriefDescription": "The rate of L1D TLB refill to the overall L1D TLB lookups",
> +        "MetricGroup": "TLB",
> +        "MetricName": "l1d_tlb_miss_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
> +        "BriefDescription": "The rate of L1I TLB refill to the overall L1I TLB lookups",
> +        "MetricGroup": "TLB",
> +        "MetricName": "l1i_tlb_miss_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
> +        "BriefDescription": "The rate of L2D TLB refill to the overall L2D TLB lookups",
> +        "MetricGroup": "TLB",
> +        "MetricName": "l2_tlb_miss_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
> +        "MetricGroup": "TLB",
> +        "MetricName": "dtlb_mpki",
> +        "ScaleUnit": "MPKI"
> +    },
> +    {
> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
> +        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
> +        "MetricGroup": "TLB",
> +        "MetricName": "dtlb_walk_rate",
> +        "ScaleUnit": "100%"
> +    },
> +    {
> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for instruction accesses",
> +        "MetricGroup": "TLB",
> +        "MetricName": "itlb_mpki",
> +        "ScaleUnit": "MPKI"

Did you test this? IIRC if there is no number in the ScaleUnit then
the scale factor becomes 0 and the metric value is always multiplied
by zero. Perhaps:

"MetricName": "itlb_miss_rate",
"MetricExpr": "ITLB / INST_RETIRED"
"ScaleUnit": "1000MPKI"

Thanks,
Ian

> +    },
> +    {
> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
> +        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
> +        "MetricGroup": "TLB",
> +        "MetricName": "itlb_walk_rate",
> +        "ScaleUnit": "100%"
>      }
>  ]
> --
> 1.8.3.1
>
