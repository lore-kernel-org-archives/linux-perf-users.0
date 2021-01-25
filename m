Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FBEC4361B
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AECFC230FC
	for <linux-perf-users@archiver.kernel.org>; Tue, 26 Jan 2021 17:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbhAZGEf (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 01:04:35 -0500
Received: from foss.arm.com ([217.140.110.172]:44366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727024AbhAYJlB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 04:41:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E0891042;
        Mon, 25 Jan 2021 01:39:55 -0800 (PST)
Received: from [10.57.36.35] (unknown [10.57.36.35])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B80653F66B;
        Mon, 25 Jan 2021 01:39:50 -0800 (PST)
Subject: Re: [PATCH 4/4] perf tools: determine if LR is the return address
To:     Jiri Olsa <jolsa@redhat.com>,
        Alexandre Truong <alexandre.truong@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Al Grant <al.grant@arm.com>,
        Wilco Dijkstra <wilco.dijkstra@arm.com>
References: <20210122161854.5289-1-alexandre.truong@arm.com>
 <20210122161854.5289-4-alexandre.truong@arm.com>
 <20210124000526.GE138414@krava>
From:   James Clark <james.clark@arm.com>
Message-ID: <9e2907dd-98ec-a187-a52c-0da07409b91b@arm.com>
Date:   Mon, 25 Jan 2021 11:39:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210124000526.GE138414@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 24/01/2021 02:05, Jiri Olsa wrote:
> On Fri, Jan 22, 2021 at 04:18:54PM +0000, Alexandre Truong wrote:
>> On arm64 and frame pointer mode (e.g: perf record --callgraph fp),
>> use dwarf unwind info to check if the link register is the return
>> address in order to inject it to the frame pointer stack.
>>
>> Write the following application:
>>
>> 	int a = 10;
>>
>> 	void f2(void)
>> 	{
>> 		for (int i = 0; i < 1000000; i++)
>> 			a *= a;
>> 	}
>>
>> 	void f1()
>> 	{
>> 		f2();
>> 	}
>>
>> 	int main (void)
>> 	{
>> 		f1();
>> 		return 0;
>> 	}
>>
>> with the following compilation flags:
>> 	gcc -g -fno-omit-frame-pointer -fno-inline -O1
>>
>> The compiler omits the frame pointer for f2 on arm. This is a problem
>> with any leaf call, for example an application with many different
>> calls to malloc() would always omit the calling frame, even if it
>> can be determined.
>>
>> 	./perf record --call-graph fp ./a.out
>> 	./perf report
>>
>> currently gives the following stack:
>>
>> 0xffffea52f361
>> _start
>> __libc_start_main
>> main
>> f2
> 
> reproduced on x86 as well
> 
>> +static bool get_leaf_frame_caller_enabled(struct perf_sample *sample)
>> +{
>> +	return callchain_param.record_mode != CALLCHAIN_FP || !sample->user_regs.regs
>> +		|| sample->user_regs.mask != PERF_REGS_MASK;
>> +}
>> +
>> +static int add_entry(struct unwind_entry *entry, void *arg)
>> +{
>> +	struct entries *entries = arg;
>> +
>> +	entries->stack[entries->i++] = entry->ip;
>> +	return 0;
>> +}
>> +
>> +u64 get_leaf_frame_caller_aarch64(struct perf_sample *sample, struct thread *thread)
>> +{
>> +	u64 leaf_frame;
>> +	struct entries entries = {{0, 0}, 0};
>> +
>> +	if (get_leaf_frame_caller_enabled(sample))
> 
> the name suggest you'd want to continue if it's true
> 
>> +		return 0;
>> +
>> +	unwind__get_entries(add_entry, &entries, thread, sample, 2);
> 
> I'm scratching my head how this unwinds anything, you enabled just
> registers, not the stack right? so the unwind code would do just
> IP -> LR + 1 shift?

I think the idea about using libunwind is that the LR might not
be a valid return address. It could be used as a general purpose
register, or just not used at all.

Libunwind should be able to use the dwarf present in the binary to
unwind one frame, as long as nothing stored in the stack is needed.

But now I look at the disassembly for this example, I see that f2()
just has a single 'b' instruction, and not 'bl' so the link register
won't be set. And also 'f1' does store a few things on the stack.
Whether these are needed or not to unwind one frame I'm not sure.

It could be that libunwind is falling back to a frame pointer unwind
mode, which we don't want.

I think it needs further investigation.


James

> 
> thanks,
> jirka
> 
>> +	leaf_frame = callchain_param.order == ORDER_CALLER ?
>> +		entries.stack[0] : entries.stack[1];
>> +
>> +	if (leaf_frame + 1 == sample->user_regs.regs[PERF_REG_ARM64_LR])
>> +		return sample->user_regs.regs[PERF_REG_ARM64_LR];
>> +	return 0;
>> +}
> 
> SNIP
> 
