Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B87C2B9FE
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA1161C83
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 May 2021 15:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhELPWC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 May 2021 11:22:02 -0400
Received: from foss.arm.com ([217.140.110.172]:41812 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233409AbhELPSQ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 May 2021 11:18:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CE2D31B;
        Wed, 12 May 2021 08:17:06 -0700 (PDT)
Received: from [10.57.81.122] (unknown [10.57.81.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E2DA3F718;
        Wed, 12 May 2021 08:17:04 -0700 (PDT)
Subject: Re: [PATCH v1 2/3] perf arm-spe: Correct sample flags for dummy event
From:   James Clark <james.clark@arm.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Grant <Al.Grant@arm.com>
References: <20210429150100.282180-1-leo.yan@linaro.org>
 <20210429150100.282180-3-leo.yan@linaro.org>
 <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
Message-ID: <95d93dcb-e930-a1c7-08e1-be8885d19f64@arm.com>
Date:   Wed, 12 May 2021 18:17:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f4e483ae-acbb-7afa-c215-cb4244c2e820@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 12/05/2021 17:39, James Clark wrote:
> 
> 
> On 29/04/2021 18:00, Leo Yan wrote:
>> The dummy event is mainly used for mmap, the TIME sample is only needed
[...]
>> -	tracking_evsel->core.attr.freq = 0;
>> -	tracking_evsel->core.attr.sample_period = 1;
>> -	evsel__set_sample_bit(tracking_evsel, TIME);
>> -	evsel__set_sample_bit(tracking_evsel, CPU);
>> -	evsel__reset_sample_bit(tracking_evsel, BRANCH_STACK);
>> +	if (opts->full_auxtrace) {
>> +		struct evsel *tracking_evsel;
> 
> Hi Leo,
> 
> I know the "if (opts->full_auxtrace)" pattern is copied from other auxtrace
> files, but I don't think it does anything because there is this at the top
> of the function:
> 
>    	if (!opts->full_auxtrace)
> 		return 0;
> 
> The same applies for other usages of "full_auxtrace" in the same function.
> They are all always true. I'm also not sure if it's ever defined what
> full_auxtrace means.
> 
> James

Apart from this issue above, I've tested the full patchset with various combinations
of --per-thread, -a and --timestamp and don't see any issues like missing command names
or decode issues. (Apart from -a where Command is reported as '-1', but this issue is
present before and after this patchset so is unrelated.)

I think it makes sense to unify the behaviour to make it more like Coresight and others
so this is a good change.

Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>

> 
>> +
>> +		err = parse_events(evlist, "dummy:u", NULL);
>> +		if (err)
>> +			return err;
>> +
>> +		tracking_evsel = evlist__last(evlist);
>> +		evlist__set_tracking_event(evlist, tracking_evsel);
>> +
>> +		tracking_evsel->core.attr.freq = 0;
>> +		tracking_evsel->core.attr.sample_period = 1;
>> +
>> +		/* In per-cpu case, always need the time of mmap events etc */
>> +		if (!perf_cpu_map__empty(cpus))
>> +			evsel__set_sample_bit(tracking_evsel, TIME);
>> +	}
>>  
>>  	return 0;
>>  }
>>
