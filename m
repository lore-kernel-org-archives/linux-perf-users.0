Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840F1C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6841F610EA
	for <linux-perf-users@archiver.kernel.org>; Wed,  6 Oct 2021 08:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237551AbhJFIcX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 6 Oct 2021 04:32:23 -0400
Received: from foss.arm.com ([217.140.110.172]:59594 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237411AbhJFIcX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 6 Oct 2021 04:32:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7DFA86D;
        Wed,  6 Oct 2021 01:30:31 -0700 (PDT)
Received: from [10.57.43.98] (unknown [10.57.43.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 052F43F766;
        Wed,  6 Oct 2021 01:30:28 -0700 (PDT)
Subject: Re: [PATCH 4/4] perf vendor events: Add the Neoverse V1 to arm64
 mapfile
From:   Andrew Kilroy <andrew.kilroy@arm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20211004160008.21645-1-andrew.kilroy@arm.com>
 <20211004160008.21645-4-andrew.kilroy@arm.com>
 <424d066b-30d5-4512-bd8c-15b700af2864@huawei.com>
 <YVySPe1LRz4bGZFy@kernel.org> <2db0d2b9-a234-2117-a6f3-67428bc3a820@arm.com>
Message-ID: <d51c82c9-a01e-187c-87ca-bce957618e75@arm.com>
Date:   Wed, 6 Oct 2021 09:29:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2db0d2b9-a234-2117-a6f3-67428bc3a820@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 06/10/2021 09:20, Andrew Kilroy wrote:
> Hi Arnaldo + John,
> 
> On 05/10/2021 18:58, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Oct 05, 2021 at 10:33:49AM +0100, John Garry escreveu:
>>> On 04/10/2021 17:00, Andrew Kilroy wrote:
>>>> This is so that performance counters for the Neoverse V1 appear
>>>> categorised upon running 'perf list' on the CPU.
>>>>
>>>
>>> this really belongs with the previous patch
>>
>> Waiting for a resolution on this one.
>>
>> - Arnaldo
>>> Thanks,
>>> John
>>>
> 
> Sent a v2 of these patches
> 
> Andrew

I forgot to add, thanks for the review!

Andrew


> 
> 
> 
>>>> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
>>>> ---
>>>>    tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv 
>>>> b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> index c43591d831b8..31d8b57ca9bb 100644
>>>> --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
>>>> @@ -18,6 +18,7 @@
>>>>    0x00000000410fd080,v1,arm/cortex-a57-a72,core
>>>>    0x00000000410fd0b0,v1,arm/cortex-a76-n1,core
>>>>    0x00000000410fd0c0,v1,arm/cortex-a76-n1,core
>>>> +0x00000000410fd400,v1,arm/neoverse-v1,core
>>>>    0x00000000420f5160,v1,cavium/thunderx2,core
>>>>    0x00000000430f0af0,v1,cavium/thunderx2,core
>>>>    0x00000000460f0010,v1,fujitsu/a64fx,core
>>>>
>>
