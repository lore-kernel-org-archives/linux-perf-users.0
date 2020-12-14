Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6E1C4361B
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CD022A85
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Dec 2020 08:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407260AbgLNIwI (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Dec 2020 03:52:08 -0500
Received: from foss.arm.com ([217.140.110.172]:44602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgLNIwH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Dec 2020 03:52:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F3A121FB;
        Mon, 14 Dec 2020 00:51:21 -0800 (PST)
Received: from [10.57.30.226] (unknown [10.57.30.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E26373F66E;
        Mon, 14 Dec 2020 00:51:19 -0800 (PST)
Subject: Re: [PATCH] drivers/perf: Enable PID_IN_CONTEXTIDR with SPE
To:     Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Al Grant <al.grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20201130162454.28255-1-james.clark@arm.com>
 <20201130164650.GA25187@willie-the-truck>
 <20201201041040.GC28939@leoy-ThinkPad-X240s>
 <20201201230935.GD28496@willie-the-truck>
From:   James Clark <james.clark@arm.com>
Message-ID: <eec66e26-f0eb-9926-fdbd-995907e8fe48@arm.com>
Date:   Mon, 14 Dec 2020 10:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201201230935.GD28496@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 02/12/2020 01:09, Will Deacon wrote:
> On Tue, Dec 01, 2020 at 12:10:40PM +0800, Leo Yan wrote:
>> On Mon, Nov 30, 2020 at 04:46:51PM +0000, Will Deacon wrote:
>>> On Mon, Nov 30, 2020 at 06:24:54PM +0200, James Clark wrote:
>>>> Enable PID_IN_CONTEXTIDR by default when Arm SPE is enabled.
>>>> This flag is required to get PID data in the SPE trace. Without
>>>> it the perf tool will report 0 for PID which isn't very useful,
>>>> especially when doing system wide profiling or profiling
>>>> applications that fork.
>>>
>>> Can perf not figure out the pid some other way? (e.g. by tracing context
>>> switches and correlating that with the SPE data?).
>>
>> For perf 'per-thread' mode, we can use context switch trace event as
>> assisted info to select thread context.  But for "system wide" mode and
>> "snapshot" mode in perf tool, since the trace data is continuous, I
>> think we cannot use context switch trace event to correlate the SPE
>> trace data.
> 
> Is there no way to correlate them with something like CNTVCT?
> 
>>> Also, how does this work with pid namespaces?
>>
>> Here we are studying the implemetation of Intel-PT and Arm CoreSight.
>>
>> The context ID is stored into the hardware trace data when record;
>> afterwards when perf tool decodes the trace data and detects the
>> packet for context ID, it will select the machine's thread context in
>> perf [1].  Since the perf tool gathers all the threads infomation in
>> perf data file, based on the context ID, it can find the corresponding
>> thread pointer with function machine__find_thread() [2].
>>
>> Since your question is for "pid namespace", to be honest, I don't know
>> how perf tool to handle any confliction for differrent processes share
>> the same PID, and I am not sure if you are asking CGroup related stuff
>> or not.  If this cannot answer your question, please let me know.
> 
> My point was that the pid value written to CONTEXTIDR is a global pid
> and does not take namespacing into account. If perf is run inside a pid
> namespace, it will therefore not work.

That's an interesting point, but I think we should improve this for the simple
use case without namespaces first just to improve the user experience, so I've
sent v2 of the patch with the change you suggested about using "default y".

One other thing that is an issue that I'd like to ask about is this line in
arm_spe_pmu.c:

	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR) && perfmon_capable())
		reg |= BIT(SYS_PMSCR_EL1_CX_SHIFT);

This means that the user has to be root to get the context saved with SPE.
Is this a necessary security feature? I thought that PIDs are viewable by
all users anyway? Do you think there is any way we could remove the perfmon_capable()
requirement?

James
