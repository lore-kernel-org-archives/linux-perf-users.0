Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F812C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 13:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C98A60EB6
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Oct 2021 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbhJLNc5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:32:57 -0400
Received: from foss.arm.com ([217.140.110.172]:42520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233296AbhJLNc4 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Oct 2021 09:32:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F2EB91063;
        Tue, 12 Oct 2021 06:30:54 -0700 (PDT)
Received: from [10.57.21.6] (unknown [10.57.21.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D0A593F66F;
        Tue, 12 Oct 2021 06:30:52 -0700 (PDT)
Subject: Re: [PATCH 0/3] perf tools: Enable strict JSON parsing
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        kajoljain <kjain@linux.ibm.com>
Cc:     john.garry@huawei.com, ak@linux.intel.com,
        linux-perf-users@vger.kernel.org, Nick.Forrington@arm.com,
        Andrew.Kilroy@arm.com, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20211007110543.564963-1-james.clark@arm.com>
 <c15fd2bf-104e-6ab0-6496-7e5cf77a218f@linux.ibm.com>
 <e8752b2d-65a7-1ed8-3c68-30d9006261ba@arm.com>
 <5947c093-cff9-f70e-af20-75bc053edf5f@linux.ibm.com>
 <YWCVTnOUM2P4FRPi@kernel.org>
From:   James Clark <james.clark@arm.com>
Message-ID: <0d73d04f-925c-4c97-9a07-18cc64a9c68b@arm.com>
Date:   Tue, 12 Oct 2021 14:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YWCVTnOUM2P4FRPi@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/10/2021 20:00, Arnaldo Carvalho de Melo wrote:
> Em Fri, Oct 08, 2021 at 04:56:55PM +0530, kajoljain escreveu:
>>
>>
>> On 10/8/21 3:32 PM, James Clark wrote:
>>>
>>>
>>> On 08/10/2021 08:43, kajoljain wrote:
>>>>
>>>>
>>>> On 10/7/21 4:35 PM, James Clark wrote:
>>>>> After a discussion on "[PATCH 1/4] perf vendor events: Syntax corrections in Neoverse N1 json",
>>>>> John Garry suggested that we can just modify the parser to make it more strict. Hopefully this will
>>>>> remove the need to apply any future JSON comma fixup commits.
>>>>>
>>>>> Applies on top of "[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" on
>>>>> perf/core.
>>>>>
>>>>> Also available at:
>>>>>   git clone --branch james-json-parse-fix git@git.gitlab.arm.com:linux-arm/linux-jc.git
>>>>
>>>> Hi James,
>>>>    Do we have any dependency patches on top of this patch series. I am
>>>> reviewing and testing it, but in both powerpc and x86 system I am
>>>> getting build issue. Not sure if I am missing something> 
>>>> I am trying your changes on top of upstream perf.
>>>>
>>>> pmu-events/arch/test/test_soc/sys/uncore.json: json error Invalid
>>>> character inside JSON string
>>>
>>> Hi Kajol,
>>>
>>> A trailing comma was fixed in this file 3 weeks ago at b8b350a. Can you
>>> confirm if you have updated to get this commit on perf core?
>>>
>>> Alternately you could pull from my branch above which is up to date enough
>>> to include it.
>>
>> Hi James,
>>    Thanks for pointing it. Not getting build issue now.
>>>
>>> The file is in pmu-events/arch/test/ so I would expect it to fail on all platforms.
>>>
>>>> make[3]: *** [pmu-events/Build:18: pmu-events/pmu-events.c] Error 1
>>>> make[3]: *** Deleting file 'pmu-events/pmu-events.c'
>>>> make[2]: *** [Makefile.perf:667: pmu-events/pmu-events-in.o] Error 2
>>>> make[2]: *** Waiting for unfinished jobs....
>>>> make[1]: *** [Makefile.perf:238: sub-make] Error 2
>>>> make: *** [Makefile:70: all] Error 2
>>>>
>>>> Also, Is it possible to add line number along with file name while
>>>> showing this error `json error Invalid character inside JSON string`.
>>>> It might make it easy to fix.
>>>
>>> I can add a character number with the following fix if you think that would
>>> be good enough? A line number might be a bigger change and involve keeping
>>> track of newline characters.
>>
>> Sure. I think then we can skip this change. Not sure if character
>> number will be helpful.
>>
>> Patch-set looks good to me.
>>
>> Reviewed-by Kajol Jain<kjain@linux.ibm.com>
> 
> Applied ok as-is to my perf/core branch, applied and added your
> Reviewed-by, thanks.
> 

Thanks Arnaldo. This does mean that the arm64 build will fail until
"[PATCH v2 1/3] perf vendor events: Syntax corrections in Neoverse N1 json" is
applied. I think there is also an arm64 build issue with "[PATCH 02/21] perf
pmu: Add const to pmu_events_map." which Andrew Kilroy has replied to.

James

