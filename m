Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F3BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 11:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8935960F14
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 11:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239255AbhKHLey (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 06:34:54 -0500
Received: from foss.arm.com ([217.140.110.172]:49284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237827AbhKHLey (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 06:34:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571852B;
        Mon,  8 Nov 2021 03:32:09 -0800 (PST)
Received: from [10.1.35.131] (e127744.cambridge.arm.com [10.1.35.131])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1452E3F800;
        Mon,  8 Nov 2021 03:32:06 -0800 (PST)
Subject: Re: [PATCH 1/3] perf arm-spe: Track task context switch for cpu-mode
 events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-2-german.gomez@arm.com>
 <20211106032907.GG477387@leoy-ThinkPad-X240s> <YYbcOmudBPDcLKMd@kernel.org>
From:   German Gomez <german.gomez@arm.com>
Message-ID: <2d6b41a0-2ded-d8c8-630a-d418a0ef285a@arm.com>
Date:   Mon, 8 Nov 2021 11:32:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YYbcOmudBPDcLKMd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org


On 06/11/2021 19:49, Arnaldo Carvalho de Melo wrote:
> Em Sat, Nov 06, 2021 at 11:29:07AM +0800, Leo Yan escreveu:
>> [...]
>> Reviewed-by: Leo Yan <leo.yan@linaro.org>
>>
>> Note for one thing, please keep "Namhyung Kim" as the author for this
>> patch, thanks.
> This merits a v2 submission, please do so.
>
> - Arnaldo
>  

Will do,

Also will fix the authorship of [2/3].

Thanks,
German

>> Leo
>>
>>> ---
>>>  tools/perf/arch/arm64/util/arm-spe.c |  6 +++++-
>>>  tools/perf/util/arm-spe.c            | 25 +++++++++++++++++++++++++
>>>  2 files changed, 30 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
>>> index a4420d4df..58ba8d15c 100644
>>> --- a/tools/perf/arch/arm64/util/arm-spe.c
>>> +++ b/tools/perf/arch/arm64/util/arm-spe.c
>>> @@ -166,8 +166,12 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
>>>  	tracking_evsel->core.attr.sample_period = 1;
>>>  
>>>  	/* In per-cpu case, always need the time of mmap events etc */
>>> -	if (!perf_cpu_map__empty(cpus))
>>> +	if (!perf_cpu_map__empty(cpus)) {
>>>  		evsel__set_sample_bit(tracking_evsel, TIME);
>>> +		evsel__set_sample_bit(tracking_evsel, CPU);
>>> +		/* also track task context switch */
>>> +		tracking_evsel->core.attr.context_switch = 1;
>>> +	}
>>>  
>>>  	return 0;
>>>  }
>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>> index 58b7069c5..230bc7ab2 100644
>>> --- a/tools/perf/util/arm-spe.c
>>> +++ b/tools/perf/util/arm-spe.c
>>> @@ -681,6 +681,25 @@ static int arm_spe_process_timeless_queues(struct arm_spe *spe, pid_t tid,
>>>  	return 0;
>>>  }
>>>  
>>> +static int arm_spe_context_switch(struct arm_spe *spe, union perf_event *event,
>>> +				  struct perf_sample *sample)
>>> +{
>>> +	pid_t pid, tid;
>>> +	int cpu;
>>> +
>>> +	if (!(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT))
>>> +		return 0;
>>> +
>>> +	pid = event->context_switch.next_prev_pid;
>>> +	tid = event->context_switch.next_prev_tid;
>>> +	cpu = sample->cpu;
>>> +
>>> +	if (tid == -1)
>>> +		pr_warning("context_switch event has no tid\n");
>>> +
>>> +	return machine__set_current_tid(spe->machine, cpu, pid, tid);
>>> +}
>>> +
>>>  static int arm_spe_process_event(struct perf_session *session,
>>>  				 union perf_event *event,
>>>  				 struct perf_sample *sample,
>>> @@ -718,6 +737,12 @@ static int arm_spe_process_event(struct perf_session *session,
>>>  		}
>>>  	} else if (timestamp) {
>>>  		err = arm_spe_process_queues(spe, timestamp);
>>> +		if (err)
>>> +			return err;
>>> +
>>> +		if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE ||
>>> +		    event->header.type == PERF_RECORD_SWITCH)
>>> +			err = arm_spe_context_switch(spe, event, sample);
>>>  	}
>>>  
>>>  	return err;
>>> -- 
>>> 2.25.1
>>>
