Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970E0C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A14A60F5A
	for <linux-perf-users@archiver.kernel.org>; Wed, 27 Oct 2021 15:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhJ0PM6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 27 Oct 2021 11:12:58 -0400
Received: from foss.arm.com ([217.140.110.172]:44342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234446AbhJ0PM6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 27 Oct 2021 11:12:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B11ED1;
        Wed, 27 Oct 2021 08:10:32 -0700 (PDT)
Received: from [10.57.25.122] (unknown [10.57.25.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED5B03F70D;
        Wed, 27 Oct 2021 08:10:30 -0700 (PDT)
Subject: Re: [PATCH] perf symbol: ignore $a/$d symbols for ARM modules
To:     Lexi Shao <shaolexi@huawei.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@redhat.com, namhyung@kernel.org, nixiaoming@huawei.com,
        peterz@infradead.org, qiuxi1@huawei.com, wangbing6@huawei.com
References: <1b7fa65a-7587-b7c4-2dc0-d0f389200671@arm.com>
 <20211027123108.126944-1-shaolexi@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <c7dfbd17-85fd-b914-b90f-082abc64c9d1@arm.com>
Date:   Wed, 27 Oct 2021 16:10:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211027123108.126944-1-shaolexi@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 27/10/2021 13:31, Lexi Shao wrote:
> On 27/10/2021 18:24, James Clark wrote:
>> On 27/10/2021 10:52, Lexi Shao wrote:
>>> On ARM machine, kernel symbols from modules can be resolved to $a
>>> instead of printing the actual symbol name. Ignore symbols starting with
>>> "$" when building kallsyms rbtree.
>>>
>>> A sample stacktrace is shown as follows:
>>>
>>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>>> bf4a66d8 $a+0x78 ([test_module])
>>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>>>
>>> On ARM machine, $a/$d symbols are used by the compiler to mark the
>>> beginning of code/data part in code section. These symbols are filtered
>>> out when linking vmlinux(see scripts/kallsyms.c ignored_prefixes), but
>>> are left on modules. So there are $a symbols in /proc/kallsyms which
>>> share the same addresses with the actual module symbols and confuses perf
>>> when resolving symbols.
>>
>> Hi Lexi,
>>
>> Is it worth using or re-implementing the entire is_ignored_symbol() function
>>from scripts/kallsyms.c? It seems like this change only fixes one occurrence,
>> but is_ignored_symbol() has a big list of other cases.
>>
>> Unless those cases are different?
>>
>> Thanks
>> James
> 
> Hi James,
> 
> I don't think it's necessary to cover all the cases listed in
> is_ignored_symbol(). As long as the symbols are unique and not overlapping
> with each other, they should't cause problems in resolving symbols. So most
> of the cases in is_ignored_symbol() should be irrelevant.

Is it possible to do the filtering of the module symbols somewhere else like
in kernel/kallsyms.c? I'm not that familiar with it but it seems like
at one point when populating kallsyms '$...' functions are filtered out, but
when modules are loaded the symbols are not filtered because another code path is
used?

If kallsyms has some duplicate addresses in there then isn't the bug in kallsyms
rather than perf? And another tool could get confused too.

James

> 
> Lexi
> 
>>
>>>
>>> After this patch, the module symbol name is printed:
>>>
>>> c0f2e39c schedule_hrtimeout+0x14 ([kernel.kallsyms])
>>> bf4a66d8 test_func+0x78 ([test_module])
>>> c0a4f5f4 kthread+0x15c ([kernel.kallsyms])
>>> c0a001f8 ret_from_fork+0x14 ([kernel.kallsyms])
>>>
>>> Signed-off-by: Lexi Shao <shaolexi@huawei.com>
>>> ---
>>>  tools/perf/util/symbol.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
>>> index 0fc9a5410739..35116aed74eb 100644
>>> --- a/tools/perf/util/symbol.c
>>> +++ b/tools/perf/util/symbol.c
>>> @@ -702,6 +702,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>>>  	if (!symbol_type__filter(type))
>>>  		return 0;
>>>  
>>> +	/* Ignore local symbols for ARM modules */
>>> +	if (name[0] == '$')
>>> +		return 0;
>>> +
>>>  	/*
>>>  	 * module symbols are not sorted so we add all
>>>  	 * symbols, setting length to 0, and rely on
>>>
>>
