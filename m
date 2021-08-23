Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD18C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F31613D1
	for <linux-perf-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhHWQBC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:01:02 -0400
Received: from foss.arm.com ([217.140.110.172]:54852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231272AbhHWQBB (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Aug 2021 12:01:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8720911D4;
        Mon, 23 Aug 2021 09:00:18 -0700 (PDT)
Received: from [10.57.42.141] (unknown [10.57.42.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63FDD3F5A1;
        Mon, 23 Aug 2021 09:00:15 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] perf auxtrace: Add
 compat_auxtrace_mmap__{read_head|write_tail}
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Li Huafei <lihuafei1@huawei.com>, coresight@lists.linaro.org
References: <20210809112727.596876-1-leo.yan@linaro.org>
 <20210809112727.596876-3-leo.yan@linaro.org>
 <2b4e0c07-a8df-cca6-6a94-328560f4b0c6@arm.com>
 <20210823095155.GC100516@leoy-ThinkPad-X240s>
 <319ee11a-06f7-abde-6495-d2175928b9fe@arm.com>
 <20210823121348.GE100516@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <1c0101fd-2ca6-4741-5d72-82d3e00bfeb6@arm.com>
Date:   Mon, 23 Aug 2021 17:00:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823121348.GE100516@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 23/08/2021 13:13, Leo Yan wrote:
> On Mon, Aug 23, 2021 at 11:57:52AM +0100, James Clark wrote:
> 
> [...]
> 
>> Ok thanks for the explanation, that makes sense now. I do have one other
>> point about the documentation for the function:
> 
> Welcome!
> 
>>> + * When update the AUX tail and detects any carrying in the high 32 bits, it
>>> + * means there have two store operations in user space and it cannot promise
>>> + * the atomicity for 64-bit write, so return '-1' in this case to tell the
>>> + * caller an overflow error has happened.
>>> + */
>>
>> I couldn't see how it can ever return -1, it seems like it would loop forever
>> until it reads the correct value.
> 
> I use this chunk comment to address the function
> compat_auxtrace_mmap__write_tail():
> 
> +int __weak compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
> +{
> +	struct perf_event_mmap_page *pc = mm->userpg;
> +	u64 mask = (u64)(UINT32_MAX) << 32;
> +
> +	if (tail & mask)
> +		return -1;
> +
> +	/* Ensure all reads are done before we write the tail out */
> +	smp_mb();
> +	WRITE_ONCE(pc->aux_tail, tail);
> +	return 0;
> +}
> 
> Please let me know if this is okay or not?  Otherwise, if you think
> the format can cause confusion, I'd like to split the comments into
> two sections, one section for reading AUX head and another is for
> writing AUX tail.

I see what you mean now, I think keeping it in one section is fine, I would just
replace "When update the AUX tail and detects" with "When
compat_auxtrace_mmap__write_tail() detects". If the function name is there then
it's clear that it's not the return value of compat_auxtrace_mmap__read_head()

Thanks
James

> 
> Thanks,
> Leo
> 
