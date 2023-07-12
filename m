Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131E8EB64DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Jul 2023 14:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjGLOPV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 10:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjGLOPT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Jul 2023 10:15:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 341141995
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Jul 2023 07:15:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68330D75;
        Wed, 12 Jul 2023 07:16:00 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC4513F67D;
        Wed, 12 Jul 2023 07:15:16 -0700 (PDT)
Message-ID: <dfca1655-39ca-b9f0-1212-cd468758cbb6@arm.com>
Date:   Wed, 12 Jul 2023 15:15:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/5] perf jevents: Match on highest version of Arm json
 file available
Content-Language: en-US
From:   James Clark <james.clark@arm.com>
To:     John Garry <john.g.garry@oracle.com>, irogers@google.com
Cc:     namhyung@kernel.org, acme@kernel.org,
        linux-perf-users@vger.kernel.org, renyu.zj@linux.alibaba.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com
References: <20230710141903.1595312-1-james.clark@arm.com>
 <20230710141903.1595312-3-james.clark@arm.com>
 <a35179ad-bb62-113d-3a7e-da4d2ec3c0b0@oracle.com>
 <1eb50ae1-8c7c-7108-d9e7-0422752c4d9d@arm.com>
 <16699c8a-1b68-f34d-770c-d1a1283f9603@oracle.com>
 <d0317185-4880-5504-2ca6-bab3fe30faff@arm.com>
 <034c775e-c0f1-9bda-df6b-80c068dfd69a@oracle.com>
 <e9f088d0-e19a-fe1f-e7c5-bf2141b95868@arm.com>
In-Reply-To: <e9f088d0-e19a-fe1f-e7c5-bf2141b95868@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/07/2023 15:06, James Clark wrote:
> 
> 
> On 12/07/2023 12:33, John Garry wrote:
>> On 12/07/2023 12:00, James Clark wrote:
>>>
>>>
>>> On 12/07/2023 10:22, John Garry wrote:
>>>> On 11/07/2023 11:18, James Clark wrote:
>>>>>>> The highest valid version of json files should be used,
>>>>>> What exactly does that mean?
>>>>>>
>>>>>> So it seems that you have CPUs with matching MIDR except variant and
>>>>>> revision, but have different events, right?
>>>>> Yes. In this case we changed how a metric is calculated in N2-r0p3
>>>>> because the workaround that was needed for r0p0 is no longer needed
>>>>> (CPU_CYCLES should not subtracted from stalls for topdown metrics
>>>>> anymore).
>>>>
>>>> If there are only very subtle differences, then could we solve with
>>>> metric expression function? We already do something else like this for
>>>> literal #slots for arm64
>>>
>>> Possibly, but I'd have to add a new mechanism to expose the version
>>> numbers to the metrics so it can be used in an expression. And I think
>>> it could get very messy quite quickly and make the expression hard to
>>> read. In fact in this specific case I'm not even sure how it would look.
>>> Something like this (where #p is the p in r0p3)?
>>>
>>>   {
>>>   "ArchStdEvent": "bad_speculation",
>>>   "MetricExpr": "(100 * (((1 - (OP_RETIRED / OP_SPEC)) * (1 -
>>> ((STALL_SLOT - (CPU_CYCLES if (#p >= 3) else 0) / (CPU_CYCLES *
>>> #slots)))) + ((BR_MIS_PRED * 4) / CPU_CYCLES)))"
>>
>> Could this formula for "CPU_CYCLES if (#p >= 3) else 0" be generalised
>> with a literal (like what we do for #slots)?
>>
> 
> Yes that could work, then we wouldn't need the logic inside the formula.
> 
>>>   },
>>>
>>> In this case it's not so bad because we don't need to compare r as well,
>>> but I think it could get worse if r was non 0 or there were more
>>> significant differences to the metric.
>>>
>>> It also doesn't scale in the same way when we're using auto generated
>>> metrics with the data that Arm is publishing. We're going to treat CPU
>>> versions as a completely new set of JSONs if there are any
>>> differences/fixes in the PMU stuff and just publish a whole new set.
>>> That way any tool that's consuming these can just check the MIDR and use
>>> whichever JSONS are most appropriate.
>>
>> So far we have got away with ignoring revision and variant - why change
>> this now just for these arm parts is a good question..
>>
>>> In theory this shouldn't require
>>> any manual intervention or re-writing of expressions. And it saves every
>>> tool having to solve the same problem.
>>
>> Sure, but we have tried to reduce duplication as much as possible, and
>> example would be ArchStdEvents
>>
> 
> What's the end goal of reducing duplication? Is it to reduce the binary
> size or to reduce human input?
> 
> For the binary size if most of these strings are the same then they are
> de-duplicated and the impact on the binary size is very small.
> 
> If it's to save on human input, then not doing it this way has the
> potential to be more work in the long run. At the moment we can just run
> a script and generate the Arm JSONs using what Arm is publishing. We
> might understand all these subtle de-duplication efforts, but anyone
> coming in the future is going to have a hard time understanding.
> Especially if they just want to re-run the script to update some text,
> then there is a big risk of making a mistake when re-applying the manual
> changes.
> 
> I'm not completely opposed to the idea of re-working this expression
> this time so that it works in both places, but I think we should be sure
> that we do it for the right reasons.
> 
> As an example for comparison, I tried a build with a single set of
> events and both sets (from this change) and the difference in size is
> 1760 bytes. Is it really worth starting to edit formulas just to save
> that much space?
> 

I re-ran the test with a clean build and the difference is actually 4888
bytes. Still quite small but not as suspiciously small as 1760.

>>>
>>> It's possible in the future that there are also small changes to the
>>> description text or availability of the events between versions. It
>>> hasn't happened yet, but it gives us the flexibility to do that too.
>>
>> Here the (handful of) metrics are subtly different between these
>> rev/variant, but all the events are the same. It's hard to justify
>> duplicating almost everything just for that.
>>
> 
> If it saves time and reduces the chance of making mistakes then
> personally I don't see an issue with the duplication.
> 
>>>
>>
>> I am not sure on how to handle this, since we might be bombarded with
>> support for more CPUs with the same MIDR issue and having quirks for all
>> becomes unworkable.
>>
> 
> I really don't see this being used very often. And it will always be
> used much less often than the task of adding entirely new CPUs, so it
> won't cause the number of JSONs to grow faster than that already
> existing work. To be honest there is a non-zero chance that it never
> gets used again.
> 
> Although even if we never use it again we still might want to
> re-generate the JSONS because of a typo fix or something so that task is
> just a script run rather than script run, and then re-applying the
> expression fixes.
> 
>> Can you just give the idea above on literals/functions in the metricexpr
>> a go, to see how it looks? Maybe Ian has a good idea on similar solutions.
>>
>> Thanks,
>> John
> 
> Yes I can give it a go. Also interested to see what Ian thinks as well.
> 
> Thanks
> James
