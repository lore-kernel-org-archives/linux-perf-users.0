Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3316C433ED
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 10:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9816F6186A
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 May 2021 10:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEKKB2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 May 2021 06:01:28 -0400
Received: from foss.arm.com ([217.140.110.172]:44258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhEKKBZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 May 2021 06:01:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C02F169C;
        Tue, 11 May 2021 03:00:19 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DC2C3F719;
        Tue, 11 May 2021 03:00:16 -0700 (PDT)
Subject: Re: [RFC PATCH] perf cs-etm: Handle valid-but-zero timestamps
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210507095814.17933-1-james.clark@arm.com>
 <3926c523-3fdb-66de-8b9c-b68290a5053e@arm.com>
 <20210510053904.GB4835@leoy-ThinkPad-X240s>
 <20210511080504.GC8273@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <35fbbead-167a-51d5-f781-a7b9890857b2@arm.com>
Date:   Tue, 11 May 2021 13:00:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210511080504.GC8273@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 11/05/2021 11:05, Leo Yan wrote:
> On Mon, May 10, 2021 at 01:39:04PM +0800, Leo Yan wrote:
>> On Fri, May 07, 2021 at 01:02:35PM +0300, James Clark wrote:
>>>
>>>
>>> On 07/05/2021 12:58, James Clark wrote:
>>>> There is an intermittent issue on Trogdor devices that
>>>> results in all Coresight timestamps having a value of zero.
>>>
>>> I've attached a file here that has the issue. From the dump you 
>>> can see the zero timestamps:
>>>
>>>         Idx:69; ID:10;  I_TIMESTAMP : Timestamp.; Updated val = 0x0
>>>         Idx:71; ID:10;  I_ATOM_F1 : Atom format 1.; E
>>>         Idx:72; ID:10;  I_ADDR_S_IS0 : Address, Short, IS0.; Addr=0xFFFFFFE723C65824 ~[0x5824]
>>>
>>> This doesn't have an impact on decoding as they end up being
>>> decoded in file order as in with timeless mode.
>>
>> Just remind, as Mike has mentioned that if the timestamp is zero, it
>> means the hardware setting for timestamp is not enabled properly.  So
>> for system wide or per CPU mode tracing, it's better to double check
>> what's the reason the timestamp is not enabled properly.
>>
>> IIUC, this patch breaks the existed rational in the code.  Let's think
>> about there have 4 CPUs, every CPU has its own AUX trace buffer, and
>> when decode the trace data, it will use 4 queues to track the packets
>> and every queue has its timestamp.
>>
>>   CPU0: cs_etm_queue -> ... -> packet_queue->timestamp
>>   CPU1: cs_etm_queue -> ... -> packet_queue->timestamp
>>   CPU2: cs_etm_queue -> ... -> packet_queue->timestamp
>>   CPU3: cs_etm_queue -> ... -> packet_queue->timestamp
>>
>> The issue is if all CPUs' timestamp are zero, it's impossible to find
>> a way to synthesize samples in the right time order.
> 
> I saw Denis's replying for the hardware issue for timestamp, wander if
> can add a new option "--force-aux-ts-zero" to override the hardware
> timestamp issue.  Without the option "--force-aux-ts-zero", the
> developers still have chance to observe the failure case caused by the
> abnormal timestamps.
> 

Hi Leo,

Now that you mention arguments, I remembered that you already can force something like that
with --disable-order.

There is also a recent commit "perf intel-pt: Support Z itrace option for timeless decoding"
which introduces this option:

	@@ -869,6 +869,7 @@ The letters are:
	     	L	synthesize last branch entries on existing event records
	 	s	skip initial number of events
	 	q	quicker (less detailed) decoding
	+	Z	prefer to ignore timestamps (so-called "timeless" decoding)

I will investigate if these are more relevant to fix this issue.


Thanks
James

> Thanks,
> Leo
> 
