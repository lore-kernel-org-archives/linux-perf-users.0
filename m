Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA30C433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 09:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7224E61184
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 09:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhDPJ4L (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 05:56:11 -0400
Received: from foss.arm.com ([217.140.110.172]:37698 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240218AbhDPJ4L (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 05:56:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1BD106F;
        Fri, 16 Apr 2021 02:55:46 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DAE73FA35;
        Fri, 16 Apr 2021 02:55:43 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
To:     Leo Yan <leo.yan@linaro.org>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
 <06e1cc2e-1108-81cd-59e4-79277807b80c@arm.com>
 <20210415123953.GB1011890@leoy-ThinkPad-X240s>
 <4c173b86-b045-0514-b293-c39cc74d353d@arm.com>
 <20210415143329.GC1011890@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <476662dd-eddb-e537-9940-6bc5b3293d2b@arm.com>
Date:   Fri, 16 Apr 2021 12:55:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415143329.GC1011890@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/04/2021 17:33, Leo Yan wrote:
> Hi James,
> 
> On Thu, Apr 15, 2021 at 03:51:46PM +0300, James Clark wrote:
> 
> [...]
> 
>>> For the orignal perf data file with "--per-thread" option, the decoder
>>> runs into the condition for "etm->timeless_decoding"; and it doesn't
>>> contain ETM timestamp.
>>>
>>> Afterwards, the injected perf data file also misses ETM timestamp and
>>> hit the condition "etm->timeless_decoding".
>>>
>>> So I am confusing why the original perf data can be processed properly
>>> but fails to handle the injected perf data file.
>>
>> Hi Leo,
>>
>> My patch only deals with per-cpu mode. With per-thread mode everything is already working
>> because _none_ of the events have timestamps because they are not enabled by default:
>>
>> 	/* In per-cpu case, always need the time of mmap events etc */
>> 	if (!perf_cpu_map__empty(cpus))
>> 		evsel__set_sample_bit(tracking_evsel, TIME);
>>
>> When none of the events have timestamps, I think perf doesn't use the ordering code in
>> ordered-events.c. So when the inject file is opened, the events are read in file order.
> 
> The explination makes sense to me.  One thinking: if the original file
> doesn't use the ordered event, is it possible for the injected file to
> not use the ordered event as well?

Yes if you inject on a file with no timestamps and then open it, then the function queue_event()
in ordered_events.c is not hit.

If you create a file based on one with timestamps, then the queue_event() function is hit
even on the injected file.

The relevant bit of code is here:

	if (tool->ordered_events) {
		u64 timestamp = -1ULL;

		ret = evlist__parse_sample_timestamp(evlist, event, &timestamp);
		if (ret && ret != -1)
			return ret;

		ret = perf_session__queue_event(session, event, timestamp, file_offset);
		if (ret != -ETIME)
			return ret;
	}

	return perf_session__deliver_event(session, event, tool, file_offset);

If tool->ordered_events is set AND the timestamp for the sample parses to be non zero
and non -1:

	if (!timestamp || timestamp == ~0ULL)
		return -ETIME;

Then the event is added into the queue, otherwise it goes straight through to perf_session__deliver_event()
The ordering can be disabled manually with tool->ordered_events and --disable-order and is also disabled
with --dump-raw-trace.

It seems like processing the file only really works when all events are unordered but in the right order,
or ordered with the right timestamps set.

> 
> Could you confirm Intel-pt can work well for per-cpu mode for inject
> file?

Yes it seems like synthesised samples are assigned sensible timestamps.

	perf record -e intel_pt//u top
	perf inject -i perf.data -o perf-intel-per-cpu.inject.data --itrace=i100i --strip
	perf report -i perf-intel-per-cpu.inject.data -D

Results in the correct binary and DSO names and the SAMPLE timestamp is after the COMM:

	0 381165621595220 0x1200 [0x38]: PERF_RECORD_COMM exec: top:20173/20173
	
	...
	
	2 381165622169297 0x13b0 [0x38]: PERF_RECORD_SAMPLE(IP, 0x2): 20173/20173: 0x7fdaa14abf53 period: 100 addr: 0
 	... thread: top:20173
 	...... dso: /lib/x86_64-linux-gnu/ld-2.27.so

Per-thread also works, but no samples or events have timestamps.

> 
>> So it's not really about --per-thread vs per-cpu mode, it's actually about whether
>> PERF_SAMPLE_TIME is set, which is set as a by-product of per-cpu mode.
>>
>> I hope I understood your question properly.
> 
> Thanks for info, sorry if I miss any info you have elaborated.
> 
> Leo
> 
