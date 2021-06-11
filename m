Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3135EC48BE6
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 13:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1F061400
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 13:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhFKN6G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:58:06 -0400
Received: from foss.arm.com ([217.140.110.172]:59066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232064AbhFKN5h (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 09:57:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D5DC1FB;
        Fri, 11 Jun 2021 06:55:39 -0700 (PDT)
Received: from [10.57.8.45] (unknown [10.57.8.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB9653F73D;
        Fri, 11 Jun 2021 06:55:36 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] coresight: etm-perf: Correct buffer syncing for
 snapshot
From:   James Clark <james.clark@arm.com>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20210528161552.654907-1-leo.yan@linaro.org>
 <20210528161552.654907-2-leo.yan@linaro.org>
 <f29d2d68-2735-dddf-b872-6163d1dbc8f0@arm.com>
 <20210601103504.GC10026@leoy-ThinkPad-X240s>
 <71158b94-863d-97d3-323a-e2406b708db7@arm.com>
Message-ID: <706158b9-5a4f-8bca-5dc2-000df8989f1c@arm.com>
Date:   Fri, 11 Jun 2021 14:55:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <71158b94-863d-97d3-323a-e2406b708db7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 10/06/2021 17:54, James Clark wrote:
> 
> 
> On 01/06/2021 13:35, Leo Yan wrote:
>> Hi James,
>>
>> On Tue, Jun 01, 2021 at 12:53:16PM +0300, James Clark wrote:
>>
>> [...]
>>
>>> Hi Leo,
>>>
>>> I was testing out snapshot mode (without your patch) and I noticed that it
>>> only ever collects from the last CPU. For example on a 4 core system,
>>> the CPU ID of the AUX records and the AUXTRACE buffers is always 3.
>>>
>>> This is with systemwide tracing, and running "stress -m 2 -c 2".
>>> Is this something that your patch fixes, or am I doing something wrong, or
>>> is it just a coincidence?
>>
>> No, I think it's quite likely caused by blow code:
>>
>> static unsigned long
>> tmc_update_etr_buffer(struct coresight_device *csdev,
>>                       struct perf_output_handle *handle,
>>                       void *config)
>> {
>>     unsigned long flags, offset, size = 0;
>>
>>     ...
>>
>>     /* Don't do anything if another tracer is using this sink */
>>     if (atomic_read(csdev->refcnt) != 1) {
>>         spin_unlock_irqrestore(&drvdata->spinlock, flags);
>>         goto out;
>>     }
>>
>>     ...
>>
>>     return size;
>> }
>>
>> When using the system wide tracing, it updates the AUX ring buffer
>> until the last tracer is stopped.  Thus whis is why it only records
>> AUX ring buffer for the last CPU.
>>
>> But this makes sense for me, this is because the last CPU is used to
>> copy trace data to AUX ring buffer (so the perf event PERF_RECORD_AUX
>> occurs on CPU3), but when you decode the trace data, you should can
>> see the activities from other CPUs.
>>
>> Thanks,
>> Leo
>>
> 
> I have one more issue around snapshot mode which I'd like to check if it's
> related to this patchset.
> 
> In "[PATCH v5 0/1] perf cs-etm: Split Coresight decode by aux records",
> I added the warning for a missing AUXTRACE buffer as you suggested.
> Now this warning gets triggered on the last AUX record when using
> snapshot mode. I don't know if you are able to reproduce this.
> 

Hi Leo,

So I tested this set with my aux split patch, and I still get the warning about the
last AUX record not being found, so this is an independent issue. Whether
it could be (or needs to be fixed) at the same time, I'm not sure.

One thing seems to have improved with your set is the number of aux records
produced. For each SIGUSR2, I now get one aux record. Previously I got a random
number that didn't seem to match up, which didn't seem right to me.

But one thing that could be worse is the offsets and sizes. Now the size of the
aux records is always 0x100000, no matter what the -m arguments are, and the size
of the AUX record exceeds the size of the buffer. This makes the split patchset
fall back to processing the whole buffer because it never finds a buffer that the
AUX record fits in. For example:

	0 0 0xad0 [0x30]: PERF_RECORD_AUXTRACE size: 0x20000  offset: 0xe0000  ref: 0x406971eb0346c919  idx: 2  tid: 6794  cpu: 2
	2 5644375601060 0xa88 [0x40]: PERF_RECORD_AUX offset: 0x100000 size: 0x100000 flags: 0x2 [O]

The buffer is only 0x20000 long, but the aux record is 0x100000.

Another issue is that now the offsets don't match up:
	0 0 0xad0 [0x30]: PERF_RECORD_AUXTRACE size: 0x20000
  offset: 0xe0000  ref: 0x406971eb0346c919  idx: 2  tid: 6794  cpu: 2
	2 5644375601060 0xa88 [0x40]: PERF_RECORD_AUX offset: 0x100000 size: 0x100000 flags: 0x2 [O]
	0 0 0x20bb0 [0x30]: PERF_RECORD_AUXTRACE size: 0x20000  offset: 0x1e0000  ref: 0x1a3abb5c2407536a  idx: 2  tid: 6794  cpu: 2
	2 5644942278600 0x20b68 [0x40]: PERF_RECORD_AUX offset: 0x200000 size: 0x100000 flags: 0x2 [O]
	0 0 0x40c90 [0x30]: PERF_RECORD_AUXTRACE size: 0x20000  offset: 0x2e0000  ref: 0x7477d3d43d0a2ac7  idx: 2  tid: 6794  cpu: 2
	2 5645263266480 0x40c48 [0x40]: PERF_RECORD_AUX offset: 0x300000 size: 0x100000 flags: 0x2 [O]
	0 0 0x60d70 [0x30]: PERF_RECORD_AUXTRACE size: 0x20000  offset: 0x3e0000  ref: 0x202b939740c4f041  idx: 2  tid: 6794  cpu: 2
	2 5645569318020 0x60d28 [0x40]: PERF_RECORD_AUX offset: 0x400000 size: 0x100000 flags: 0x2 [O]

The buffers are offset by 0xe0000, but the aux records are on round 0x100000 offsets.

Maybe we need to re-think the aux split patchset, do we not need to split in snapshot mode? Or can we fix this
set to produce aux records that match up?

James
