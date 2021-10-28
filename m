Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C3FC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F60F610C7
	for <linux-perf-users@archiver.kernel.org>; Thu, 28 Oct 2021 08:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1Ip1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 28 Oct 2021 04:45:27 -0400
Received: from foss.arm.com ([217.140.110.172]:52330 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229626AbhJ1Ip0 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 28 Oct 2021 04:45:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91E321FB;
        Thu, 28 Oct 2021 01:42:59 -0700 (PDT)
Received: from [10.32.36.26] (e121896.Emea.Arm.com [10.32.36.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8987D3F70D;
        Thu, 28 Oct 2021 01:42:57 -0700 (PDT)
Subject: Re: [PATCH] perf symbol: ignore $a/$d symbols for ARM modules
To:     Lexi Shao <shaolexi@huawei.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, nixiaoming@huawei.com,
        peterz@infradead.org, qiuxi1@huawei.com, wangbing6@huawei.com
References: <c7dfbd17-85fd-b914-b90f-082abc64c9d1@arm.com>
 <20211028020509.39082-1-shaolexi@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <cb7e9ef7-eda4-b197-df8a-0b54f9b56181@arm.com>
Date:   Thu, 28 Oct 2021 09:42:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211028020509.39082-1-shaolexi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 28/10/2021 03:05, Lexi Shao wrote:
> On 27/10/2021 23:10, James Clark wrote:
>> On 27/10/2021 13:31, Lexi Shao wrote:
>>> On 27/10/2021 18:24, James Clark wrote:
>>>> On 27/10/2021 10:52, Lexi Shao wrote:
>>>>> On ARM machine, kernel symbols from modules can be resolved to $a
>>>>> instead of printing the actual symbol name. Ignore symbols starting with
>>>>> "$" when building kallsyms rbtree.
>>>>>
>>>>> A sample stacktrace is shown as follows:
>>>>>
>>>>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>>>>> bf4a66d8 $a+0x78 ([test_module])
>>>>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>>>>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>>>>>
>>>>> On ARM machine, $a/$d symbols are used by the compiler to mark the
>>>>> beginning of code/data part in code section. These symbols are filtered
>>>>> out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
>>>>> are left on modules. So there are $a symbols in /proc/kallsyms which
>>>>> share the same addresses with the actual module symbols and confuses perf
>>>>> when resolving symbols.
>>>>
>>>> Hi Lexi,
>>>>
>>>> Is it worth using or re-implementing the entire is_ignored_symbol() function
>>> >from scripts/kallsyms.c? It seems like this change only fixes one occurrence,
>>>> but is_ignored_symbol() has a big list of other cases.
>>>>
>>>> Unless those cases are different?
>>>>
>>>> Thanks
>>>> James
>>>
>>> Hi James,
>>>
>>> I don't think it's necessary to cover all the cases listed in
>>> is_ignored_symbol(). As long as the symbols are unique and not overlapping
>>> with each other, they should't cause problems in resolving symbols. So most
>>> of the cases in is_ignored_symbol() should be irrelevant.
>>
>> Is it possible to do the filtering of the module symbols somewhere else like
>> in kernel/kallsyms.c? I'm not that familiar with it but it seems like
>> at one point when populating kallsyms '$...' functions are filtered out, but
>> when modules are loaded the symbols are not filtered because another code path is
>> used?
>>
>> If kallsyms has some duplicate addresses in there then isn't the bug in kallsyms
>> rather than perf? And another tool could get confused too.
>>
>> James
> 
> Yes we can filter these symbols out when adding module symbols to the kallsyms
> list. I will send another patch that modifies module.c to ignore '$' symbols
> when loading module.
> 

That sounds great thanks.

> I think it's worth applying this patch in the sense that perf userspace tool
> can be used on all 5.x kernels, and people don't have to update the kernel
> to fix it.

Yes you are right. In that case I will add a review tag to this change.

Thanks
James

> 
> Lexi
> 
>>
>>>
>>> Lexi
>>>
>>>>
>>>>>
>>>>> After this patch, the module symbol name is printed:
>>>>>
>>>>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>>>>> bf4a66d8 test_func+0x78 ([test_module])
>>>>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>>>>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>>>>>
>>>>> Signed-off-by: Lexi Shao <shaolexi@huawei.com>
>>>>> ---
>>>>>  tools/perf/util/symbol.c | 4 ++++
>>>>>  1 file changed, 4 insertions(+)
>>>>>
>>>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>>>> index 0fc9a5410739..35116aed74eb 100644
>>>>> --- a/tools/perf/util/symbol.c
>>>>> +++ b/tools/perf/util/symbol.c
>>>>> @@ -702,6 +702,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>>>>>  	if (!symbol_type__filter(type))
>>>>>  		return 0;
>>>>>  
>>>>> +	/* Ignore local symbols for ARM modules */
>>>>> +	if (name[0] == '$')
>>>>> +		return 0;
>>>>> +
>>>>>  	/*
>>>>>  	 * module symbols are not sorted so we add all
>>>>>  	 * symbols, setting length to 0, and rely on
>>>>>
>>>>
> 
