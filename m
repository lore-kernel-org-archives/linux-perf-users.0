Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE5AC433ED
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 10:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CD36117A
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Apr 2021 10:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhDPKRE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Apr 2021 06:17:04 -0400
Received: from foss.arm.com ([217.140.110.172]:38056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238871AbhDPKRE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Apr 2021 06:17:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3BEB106F;
        Fri, 16 Apr 2021 03:16:39 -0700 (PDT)
Received: from [10.57.57.112] (unknown [10.57.57.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74FB03FA35;
        Fri, 16 Apr 2021 03:16:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com> <20210415195416.GB937505@xps15>
From:   James Clark <james.clark@arm.com>
Message-ID: <0ca8c095-9165-bcd1-26bc-3e5d2191affb@arm.com>
Date:   Fri, 16 Apr 2021 13:16:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210415195416.GB937505@xps15>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 15/04/2021 22:54, Mathieu Poirier wrote:
> On Wed, Apr 14, 2021 at 05:39:19PM +0300, James Clark wrote:
>> The following attribute is set when synthesising samples in
>> timed decoding mode:
>>
>>     attr.sample_type |= PERF_SAMPLE_TIME;
>>
>> This results in new samples that appear to have timestamps but
>> because we don't assign any timestamps to the samples, when the
>> resulting inject file is opened again, the synthesised samples
>> will be on the wrong side of the MMAP or COMM events.
>>
> 
> I understand the problem.  Once again an issue caused by CS and the kernel
> having a different view of time. 
> 
>> For example this results in the samples being associated with
>> the perf binary, rather than the target of the record:
>>
>>     perf record -e cs_etm/@tmc_etr0/u top
>>     perf inject -i perf.data -o perf.inject --itrace=i100il
>>     perf report -i perf.inject
>>
>> Where 'Command' == perf should show as 'top':
>>
>>     # Overhead  Command  Source Shared Object  Source Symbol           Target Symbol           Basic Block Cycles
>>     # ........  .......  ....................  ......................  ......................  ..................
>>     #
>>         31.08%  perf     [unknown]             [.] 0x000000000040c3f8  [.] 0x000000000040c3e8  -
>>
>> If the perf.data file is opened directly with perf, without the
>> inject step, then this already works correctly because the
>> events are synthesised after the COMM and MMAP events and
>> no second sorting happens. Re-sorting only happens when opening
>> the perf.inject file for the second time so timestamps are
>> needed.
>>
>> Using the timestamp from the AUX record mirrors the current
>> behaviour when opening directly with perf, because the events
>> are generated on the call to cs_etm__process_queues().
>>
>> Signed-off-by: James Clark <james.clark@arm.com>
>> Co-developed-by: Al Grant <al.grant@arm.com>
>> Signed-off-by: Al Grant <al.grant@arm.com>
> 
> Suzuki is correct, your name has to appear after Al's.
> 
>> ---
>>  tools/perf/util/cs-etm.c | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
>> index c25da2ffa8f3..d0fa9dce47f1 100644
>> --- a/tools/perf/util/cs-etm.c
>> +++ b/tools/perf/util/cs-etm.c
>> @@ -54,6 +54,7 @@ struct cs_etm_auxtrace {
>>  	u8 sample_instructions;
>>  
>>  	int num_cpu;
>> +	u64 latest_kernel_timestamp;
>>  	u32 auxtrace_type;
>>  	u64 branches_sample_type;
>>  	u64 branches_id;
>> @@ -1192,6 +1193,8 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
>>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, addr);
>>  	event->sample.header.size = sizeof(struct perf_event_header);
>>  
>> +	if (!etm->timeless_decoding)
>> +		sample.time = etm->latest_kernel_timestamp;
>>  	sample.ip = addr;
>>  	sample.pid = tidq->pid;
>>  	sample.tid = tidq->tid;
>> @@ -1248,6 +1251,8 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
>>  	event->sample.header.misc = cs_etm__cpu_mode(etmq, ip);
>>  	event->sample.header.size = sizeof(struct perf_event_header);
>>  
>> +	if (!etm->timeless_decoding)
>> +		sample.time = etm->latest_kernel_timestamp;
>>  	sample.ip = ip;
>>  	sample.pid = tidq->pid;
>>  	sample.tid = tidq->tid;
>> @@ -2412,9 +2417,10 @@ static int cs_etm__process_event(struct perf_session *session,
>>  	else if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE)
>>  		return cs_etm__process_switch_cpu_wide(etm, event);
>>  
>> -	if (!etm->timeless_decoding &&
>> -	    event->header.type == PERF_RECORD_AUX)
>> +	if (!etm->timeless_decoding && event->header.type == PERF_RECORD_AUX) {
>> +		etm->latest_kernel_timestamp = sample_kernel_timestamp;
> 
> It will be fun to fix this when 8.4 comes out but for now it's the best we've
> got.
> 

Thanks for the reviews Leo, Mathieu and Suzuki. Yes I think for 8.4 we can also do something
very similar to Leo's "perf arm-spe: Bail out if the trace is later than perf event"
patch where decoding is paused until the other events with later timestamps
have been received. At the moment the CS decoding happens all at once.

I will submit a new set with the fixes and better variable name.

James

> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
>>  		return cs_etm__process_queues(etm);
>> +	}
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.28.0
>>
