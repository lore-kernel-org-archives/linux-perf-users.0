Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D5EC433DB
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Feb 2021 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 156EF64EBA
	for <linux-perf-users@archiver.kernel.org>; Tue,  9 Feb 2021 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232010AbhBIPhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 9 Feb 2021 10:37:05 -0500
Received: from foss.arm.com ([217.140.110.172]:53356 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231366AbhBIPhE (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 9 Feb 2021 10:37:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C2E101E;
        Tue,  9 Feb 2021 07:36:17 -0800 (PST)
Received: from [10.57.44.191] (unknown [10.57.44.191])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62093F73D;
        Tue,  9 Feb 2021 07:36:13 -0800 (PST)
Subject: Re: [PATCH 8/8] perf arm-spe: Set thread TID
To:     Leo Yan <leo.yan@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
References: <20210119144658.793-1-james.clark@arm.com>
 <20210119144658.793-8-james.clark@arm.com>
 <20210131120156.GB230721@leoy-ThinkPad-X240s>
 <cb7c6deb-e4a1-95fa-b0d2-e4405f644e63@arm.com>
 <20210204102734.GA4737@leoy-ThinkPad-X240s>
From:   James Clark <james.clark@arm.com>
Message-ID: <258ff186-7be0-7b83-fb29-e8223e780f73@arm.com>
Date:   Tue, 9 Feb 2021 17:36:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210204102734.GA4737@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 04/02/2021 12:27, Leo Yan wrote:
> On Mon, Feb 01, 2021 at 07:40:45PM +0200, James Clark wrote:
>>
>> On 31/01/2021 14:01, Leo Yan wrote:
>>> Option 1: by merging patches 07/08 and 08/08, we can firstly support PID
>>> tracing for root namespace, and later we can extend to support PID
>>> tracing in container (and in VMs).
>>>
> Arm SPE has the problem for step2, due to the trace uses statistical
> approach, it doesn't trace the complete branch instructions, so it
> cannot promise to capture all branches for the symbol "__switch_to".
> If we only use the events PERF_RECORD_SWITCH /
> PERF_RECORD_SWITCH_CPU_WIDE, then it will lead to the coarse result
> for PID tracing.
> 
> For this reason, seems to me it's pragmatic to use CONTEXTIDR for
> PID tracing at current stage, at least it can allow the root domain
> tracing works accurately.  But this will leave the issue for tracing
> PID in non root namespace, we need to figure out solution later.
> 
> Hi Mark.R, Al, do you have any comments for this?

Hi Leo,

I spoke with Al and his suggestion is to clear the PID value if the event
was opened outside of the root namespace.

I think that's not a bad idea as it gets us PIDs in most cases but also
doesn't show any incorrect data. Do you know if it's possible to determine
that from a perf.data file? Unfortunately it doesn't seem to be possible
to disable CONTEXTIDR tracing when opening the event as it's compile time
only and can't be disabled dynamically.

James

> 
> Thanks,
> Leo
> 
>>>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>>>> Signed-off-by: James Clark <james.clark@arm.com>
>>>
>>> Besides for techinical question, you could add your "Co-developed-by"
>>> tags for patches 06, 07, 08/08, which you have took time to refin them.
>>>
>>> Thanks you for kindly efforts.
>>>
>>> [1] https://lore.kernel.org/patchwork/patch/1353286/
>>>
>>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>>> Cc: Ingo Molnar <mingo@redhat.com>
>>>> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
>>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>>> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>>>> Cc: Jiri Olsa <jolsa@redhat.com>
>>>> Cc: Namhyung Kim <namhyung@kernel.org>
>>>> Cc: John Garry <john.garry@huawei.com>
>>>> Cc: Will Deacon <will@kernel.org>
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Al Grant <al.grant@arm.com>
>>>> Cc: Andre Przywara <andre.przywara@arm.com>
>>>> Cc: Wei Li <liwei391@huawei.com>
>>>> Cc: Tan Xiaojun <tanxiaojun@huawei.com>
>>>> Cc: Adrian Hunter <adrian.hunter@intel.com>
>>>> ---
>>>>  tools/perf/util/arm-spe.c | 75 ++++++++++++++++++++++++++-------------
>>>>  1 file changed, 50 insertions(+), 25 deletions(-)
>>>>
>>>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
>>>> index 27a0b9dfe22d..9828fad7e516 100644
>>>> --- a/tools/perf/util/arm-spe.c
>>>> +++ b/tools/perf/util/arm-spe.c
>>>> @@ -223,6 +223,46 @@ static inline u8 arm_spe_cpumode(struct arm_spe *spe, u64 ip)
>>>>  		PERF_RECORD_MISC_USER;
>>>>  }
>>>>  
>>>> +static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>>>> +				    struct auxtrace_queue *queue)
>>>> +{
>>>> +	struct arm_spe_queue *speq = queue->priv;
>>>> +	pid_t tid;
>>>> +
>>>> +	tid = machine__get_current_tid(spe->machine, speq->cpu);
>>>> +	if (tid != -1) {
>>>> +		speq->tid = tid;
>>>> +		thread__zput(speq->thread);
>>>> +	} else
>>>> +		speq->tid = queue->tid;
>>>> +
>>>> +	if ((!speq->thread) && (speq->tid != -1)) {
>>>> +		speq->thread = machine__find_thread(spe->machine, -1,
>>>> +						    speq->tid);
>>>> +	}
>>>> +
>>>> +	if (speq->thread) {
>>>> +		speq->pid = speq->thread->pid_;
>>>> +		if (queue->cpu == -1)
>>>> +			speq->cpu = speq->thread->cpu;
>>>> +	}
>>>> +}
>>>> +
>>>> +static int arm_spe_set_tid(struct arm_spe_queue *speq, pid_t tid)
>>>> +{
>>>> +	int err;
>>>> +	struct arm_spe *spe = speq->spe;
>>>> +	struct auxtrace_queue *queue;
>>>> +
>>>> +	err = machine__set_current_tid(spe->machine, speq->cpu, tid, tid);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	queue = &speq->spe->queues.queue_array[speq->queue_nr];
>>>> +	arm_spe_set_pid_tid_cpu(speq->spe, queue);
>>>> +	return 0;
>>>> +}
>>>> +
>>>>  static void arm_spe_prep_sample(struct arm_spe *spe,
>>>>  				struct arm_spe_queue *speq,
>>>>  				union perf_event *event,
>>>> @@ -431,6 +471,7 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
>>>>  static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>>>>  {
>>>>  	struct arm_spe *spe = speq->spe;
>>>> +	const struct arm_spe_record *record;
>>>>  	int ret;
>>>>  
>>>>  	if (!spe->kernel_start)
>>>> @@ -450,6 +491,11 @@ static int arm_spe_run_decoder(struct arm_spe_queue *speq, u64 *timestamp)
>>>>  		if (ret < 0)
>>>>  			continue;
>>>>  
>>>> +		record = &speq->decoder->record;
>>>> +		ret = arm_spe_set_tid(speq, record->context_id);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>>  		ret = arm_spe_sample(speq);
>>>>  		if (ret)
>>>>  			return ret;
>>>> @@ -500,6 +546,10 @@ static int arm_spe__setup_queue(struct arm_spe *spe,
>>>>  
>>>>  		record = &speq->decoder->record;
>>>>  
>>>> +		ret = arm_spe_set_tid(speq, record->context_id);
>>>> +		if (ret)
>>>> +			return ret;
>>>> +
>>>>  		speq->timestamp = record->timestamp;
>>>>  		ret = auxtrace_heap__add(&spe->heap, queue_nr, speq->timestamp);
>>>>  		if (ret)
>>>> @@ -552,31 +602,6 @@ static bool arm_spe__is_timeless_decoding(struct arm_spe *spe)
>>>>  	return timeless_decoding;
>>>>  }
>>>>  
>>>> -static void arm_spe_set_pid_tid_cpu(struct arm_spe *spe,
>>>> -				    struct auxtrace_queue *queue)
>>>> -{
>>>> -	struct arm_spe_queue *speq = queue->priv;
>>>> -	pid_t tid;
>>>> -
>>>> -	tid = machine__get_current_tid(spe->machine, speq->cpu);
>>>> -	if (tid != -1) {
>>>> -		speq->tid = tid;
>>>> -		thread__zput(speq->thread);
>>>> -	} else
>>>> -		speq->tid = queue->tid;
>>>> -
>>>> -	if ((!speq->thread) && (speq->tid != -1)) {
>>>> -		speq->thread = machine__find_thread(spe->machine, -1,
>>>> -						    speq->tid);
>>>> -	}
>>>> -
>>>> -	if (speq->thread) {
>>>> -		speq->pid = speq->thread->pid_;
>>>> -		if (queue->cpu == -1)
>>>> -			speq->cpu = speq->thread->cpu;
>>>> -	}
>>>> -}
>>>> -
>>>>  static int arm_spe_process_queues(struct arm_spe *spe, u64 timestamp)
>>>>  {
>>>>  	unsigned int queue_nr;
>>>> -- 
>>>> 2.28.0
>>>>
