Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72A37C4332F
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 Jan 2023 05:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjADFV3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 Jan 2023 00:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjADFV0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 Jan 2023 00:21:26 -0500
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBDDDEE2;
        Tue,  3 Jan 2023 21:21:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VYqBg3p_1672809679;
Received: from 30.221.147.98(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VYqBg3p_1672809679)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 13:21:20 +0800
Message-ID: <14a2ca08-e946-f319-e2a8-f5f91e1eb8e6@linux.alibaba.com>
Date:   Wed, 4 Jan 2023 13:21:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/6] perf vendor events arm64: Add TLB metrics for
 neoverse-n2
To:     Ian Rogers <irogers@google.com>
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
References: <1672745976-2800146-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1672745976-2800146-3-git-send-email-renyu.zj@linux.alibaba.com>
 <CAP-5=fVP_=FcEQChQwVpis9iyZsdb6NrVJQUo4GJA4_j=knfcA@mail.gmail.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <CAP-5=fVP_=FcEQChQwVpis9iyZsdb6NrVJQUo4GJA4_j=knfcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



在 2023/1/4 上午1:14, Ian Rogers 写道:
> On Tue, Jan 3, 2023 at 3:39 AM Jing Zhang <renyu.zj@linux.alibaba.com> wrote:
>>
>> Add TLB related metrics.
>>
>> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
>> Acked-by: Ian Rogers <irogers@google.com>
>> ---
>>  .../arch/arm64/arm/neoverse-n2/metrics.json        | 49 ++++++++++++++++++++++
>>  1 file changed, 49 insertions(+)
>>
>> diff --git a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> index c126f1bc..8a74e07 100644
>> --- a/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/neoverse-n2/metrics.json
>> @@ -26,5 +26,54 @@
>>          "MetricGroup": "TopdownL1",
>>          "MetricName": "backend_bound",
>>          "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "L1D_TLB_REFILL / L1D_TLB",
>> +        "BriefDescription": "The rate of L1D TLB refill to the overall L1D TLB lookups",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "l1d_tlb_miss_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "L1I_TLB_REFILL / L1I_TLB",
>> +        "BriefDescription": "The rate of L1I TLB refill to the overall L1I TLB lookups",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "l1i_tlb_miss_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "L2D_TLB_REFILL / L2D_TLB",
>> +        "BriefDescription": "The rate of L2D TLB refill to the overall L2D TLB lookups",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "l2_tlb_miss_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "DTLB_WALK / INST_RETIRED * 1000",
>> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for data accesses",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "dtlb_mpki",
>> +        "ScaleUnit": "MPKI"
>> +    },
>> +    {
>> +        "MetricExpr": "DTLB_WALK / L1D_TLB",
>> +        "BriefDescription": "The rate of DTLB Walks to the overall L1D TLB lookups",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "dtlb_walk_rate",
>> +        "ScaleUnit": "100%"
>> +    },
>> +    {
>> +        "MetricExpr": "ITLB_WALK / INST_RETIRED * 1000",
>> +        "BriefDescription": "The rate of TLB Walks per kilo instructions for instruction accesses",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "itlb_mpki",
>> +        "ScaleUnit": "MPKI"
> 
> Did you test this? IIRC if there is no number in the ScaleUnit then
> the scale factor becomes 0 and the metric value is always multiplied
> by zero. Perhaps:
> 
> "MetricName": "itlb_miss_rate",
> "MetricExpr": "ITLB / INST_RETIRED"
> "ScaleUnit": "1000MPKI"
> 
> Thanks,
> Ian
> 

You are absolutely right, I only tested TLB metrics. Sorry for not double checking. I will repost the corrected patches.

>> +    },
>> +    {
>> +        "MetricExpr": "ITLB_WALK / L1I_TLB",
>> +        "BriefDescription": "The rate of ITLB Walks to the overall L1I TLB lookups",
>> +        "MetricGroup": "TLB",
>> +        "MetricName": "itlb_walk_rate",
>> +        "ScaleUnit": "100%"
>>      }
>>  ]
>> --
>> 1.8.3.1
>>
