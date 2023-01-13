Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3C1C54EBD
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 Jan 2023 16:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjAMQha (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAMQhG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 Jan 2023 11:37:06 -0500
Received: from out30-1.freemail.mail.aliyun.com (out30-1.freemail.mail.aliyun.com [115.124.30.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F14EAB;
        Fri, 13 Jan 2023 08:32:56 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=renyu.zj@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VZVSZBb_1673627569;
Received: from 30.15.250.25(mailfrom:renyu.zj@linux.alibaba.com fp:SMTPD_---0VZVSZBb_1673627569)
          by smtp.aliyun-inc.com;
          Sat, 14 Jan 2023 00:32:51 +0800
Message-ID: <7498a6b1-01d0-0e12-82d3-c75250e09161@linux.alibaba.com>
Date:   Sat, 14 Jan 2023 00:32:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v7 0/9] Add metrics for neoverse-n2-v2
To:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
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
References: <1673601740-122788-1-git-send-email-renyu.zj@linux.alibaba.com>
 <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com>
From:   Jing Zhang <renyu.zj@linux.alibaba.com>
In-Reply-To: <d33086a5-233f-f591-c9da-5f1a2e8aaf54@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



在 2023/1/13 下午5:59, John Garry 写道:
> On 13/01/2023 09:22, Jing Zhang wrote:
>> Changes since v6:
>> - Split patch #1 into 3 smaller patches as suggested by Ian.
>> - Change perf_pmu__get_slots into perf_pmu__cpu_slots_per_cycle,
>>    per John's suggestion;
>> - Return NAN instead of 0 in perf_pmu__cpu_slots_per_cycle weak
>>    function, per John's suggestion;
>> - Factor out pmu_core__find_same function, per John's suggestion.
>> - Link:https://urldefense.com/v3/__https://lore.kernel.org/all/1673017529-1429208-1-git-send-email-renyu.zj@linux.alibaba.com/__;!!ACWV5N9M2RV99hQ!LhBq67uDCOsz1k7ZF4aQPHF0Bp8FsMr-ZNgCnBSUKF4qJTFODfnkId7lw_NXqB4qZUCpu-jbY8z8LTckoqFGz2Q8bA$  
> 
> This looks fine. But for this code:
> 
> On 13/01/2023 09:22, Jing Zhang wrote:
>> +double perf_pmu__cpu_slots_per_cycle(void)
>> +{
>> +    char path[PATH_MAX];
>> +    unsigned long long slots = 0;
> 
> I would prefer if this returned NAN (and not 0) for when we can't find a pmu or the value from ./caps/slots is zero, but I am not going to get too hung up on that.
> 

Ok, I like this way too.

> For series:
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>

Thank you very much indeed!
