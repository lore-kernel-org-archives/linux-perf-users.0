Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E44EB64D9
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 11:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjGLLA7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 07:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjGLLA7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 07:00:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5077611D
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 04:00:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AB27D75;
        Wed, 12 Jul 2023 04:01:39 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AEE443F73F;
        Wed, 12 Jul 2023 04:00:55 -0700 (PDT)
Message-ID: <d0317185-4880-5504-2ca6-bab3fe30faff@arm.com>
Date:   Wed, 12 Jul 2023 12:00:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, irogers@google.com,
        renyu.zj@linux.alibaba.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
 <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
 <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
 <16699c8a-1b68-f34d-770c-d1a1283f9603@oracle.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <16699c8a-1b68-f34d-770c-d1a1283f9603@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/07/2023 10:22, John Garry wrote:
> On 11/07/2023 11:18, James Clark wrote:
>>>> The highest valid version of json files should be used,
>>> What exactly does that mean?
>>>
>>> So it seems that you have CPUs with matching MIDR except variant and
>>> revision, but have different events, right?
>> Yes. In this case we changed how a metric is calculated in N2-r0p3
>> because the workaround that was needed for r0p0 is no longer needed
>> (CPU_CYCLES should not subtracted from stalls for topdown metrics
>> anymore).
> 
> If there are only very subtle differences, then could we solve with
> metric expression function? We already do something else like this for
> literal #slots for arm64

Possibly, but I'd have to add a new mechanism to expose the version
numbers to the metrics so it can be used in an expression. And I think
it could get very messy quite quickly and make the expression hard to
read. In fact in this specific case I'm not even sure how it would look.
Something like this (where #p is the p in r0p3)?

 {
 "ArchStdEvent": "bad_speculation",
 "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 -
((STALL_SLOT - (CPU_CYCLES if (#p >= 3) else 0) / (CPU_CYCLES *
#slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
 },

In this case it's not so bad because we don't need to compare r as well,
but I think it could get worse if r was non 0 or there were more
significant differences to the metric.

It also doesn't scale in the same way when we're using auto generated
metrics with the data that Arm is publishing. We're going to treat CPU
versions as a completely new set of JSONs if there are any
differences/fixes in the PMU stuff and just publish a whole new set.
That way any tool that's consuming these can just check the MIDR and use
whichever JSONS are most appropriate. In theory this shouldn't require
any manual intervention or re-writing of expressions. And it saves every
tool having to solve the same problem.

It's possible in the future that there are also small changes to the
description text or availability of the events between versions. It
hasn't happened yet, but it gives us the flexibility to do that too.

> 
>> But it would also support the case where the event list was
>> slightly different between versions.
> 
> I am diff'ing folders ../arm64/arm/neoverse-n2r0p3-v2 and
> ../arm64/arm/neoverse-n2r0p0, and all the events are the same - am I
> correct? It only seems like metric json is different.
> 

Yes that's correct, just the topdown metrics where CPU_CYCLES was
subtracted as a workaround have been removed. N2 r0p3 no longer needs
that workaround. But everything else is the same.

I also used it as an opportunity to remove #slots from N2-r0p0. That set
of metrics will only be used in one place where slots is always 5. It's
better to hard code it so that it also has a chance to work on kernels
that don't have the change to expose slots yet.

>>
>>> Then to solve that are you saying that the highest version of the JSONs
>>> should used, upto and including the same CPU version (???) - correct?
>> Yeah pretty much. It's highest version of JSONs starting from
>> (including) the same CPU version, up to and not including the next
>> version of JSON files provided. If only r0p0 is provided then all CPU
>> versions match.
>>
>> So if these JSONs were provided:
>>
>>   r0p0  -  r0p4  -  r1p1
>>
>> Would match these CPUs:
>>
>>   CPU   |  JSON matched
>>   ------|---------------
>>   r0p0  |  r0p0
>>   r0p3  |  r0p0
>>   r0p4  |  r0p4
>>   r1p0  |  r0p4
>>   r1p1+ |  r1p1
>>
>>> The cover letter doesn't mention anything relevant 🙁
>>>
>> Hopefully I expanded more in the v3 cover letter.
> 
> Thanks,
> John
> 
