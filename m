Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A8136F425
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Feb 2026 16:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770653563; cv=none; b=ksugu/+AfcZRHbFVXF1GP5Rda3OMPhLXu5TGUx3IFD1BdrlY1GiJMP50+PtLZ2KT7betpRSIPKRSXX1Og7vIIiu/tuYixQff0bSe2+MnNwJJeRsFN+iFME01cMfM7fgaZoZYXq139qOjoNkh6AQRc2jNwMWPPATyLxAgIgT8O2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770653563; c=relaxed/simple;
	bh=7PZqfJGgR6T/VkpTeUyvTVaInvQKPOQ4hiVFib0k9E8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TLMw/SD2gZ1EjHoei37x+mi9gPIaPpknEwo+j7Jl+O4qaB0UJMM9wmeSquISaKX5kTdDkrYDfGifb0GXWUof5+vttxbgdohogG3mfyoRuTM8hNnU2AxbZmracMO6XqloWDzMs+htbdA2hv53whGYz3hR+Toahgr51c/WSBkFd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pVzwAn5/; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pVzwAn5/"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4359249bbacso3217110f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Feb 2026 08:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770653561; x=1771258361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U6vGUIfOMPLQOWxD28cEZmBTRpAwCIFraiBSmkF3Rq0=;
        b=pVzwAn5/OLwyiDf0iwnwHAZsboPHrjeCch7pntyhoXIGcoKVcz42ijZ/DYw+/H12sY
         gRcON8jVqJ//a49jRsBbwqyUc5/6E4XB1GPjyJCZqIOOQrmfFCNFdjRAv2y0dwZ8vE7L
         t2wKZVjhHrZu7UWXaOFNv2lT2Xf8JI9RKEJMOHO3TX1Wv9V6b7rlWvvbRk3bTmyqvnzS
         kImnD/DxKdYTFt/T3Ym1q3sonIzmHy0+w9E8jWShNkms0XgNjc17uUGQsgjcTw1T70jz
         SK8gjk/UiSoVQ3+sats/YAMn/GpwptANtILnumCS/Qi22T5K78nyD2cPtIDOWLV015Zv
         8JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770653561; x=1771258361;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6vGUIfOMPLQOWxD28cEZmBTRpAwCIFraiBSmkF3Rq0=;
        b=o97KZZdqG1yzHjUgvfFA3mtlRA52z0UzUcGrONapteEu/G6Yr65ZHUGVAUVwGB74E7
         chW+7oDZgnZu2qVUq/JTJiXt2TeFIqIVkXE7HON2gFRWA0/+7NBCGUjs45D911jHKnzq
         h3nJb70Sdn53EExNOLHS6OGHwfenVc+eoMTz0PyT7EboBthK52MdarSA6U9v6own/EzF
         mQHaywNBCkShaxE9i6y1boohpZ0SSNm0lve1oaBxQKJcYfK1xBVzaM3A0WiAlt+ZpJpW
         PnkFei9TNPkwSp+/QnYVKwJqIr6E5m1dL1ft576EdlNMwf9ITXRRkRusyMfkYU7Vd542
         cA2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUYujhPPMznchi1FWriP/PG4KCERVOBkOQurqQ7NNC50ZHySliW6vuoB+cZWaJmiQseytE6IObQ66yrbo4vrcLa@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuzs8wfY6+5C/DkL/1V2aZYOt4jP2F20q4ZKAW4utltKoA+uqc
	p3rTlS6YPwSMZObodwcliT/gLHzlaMLk7jMO5AuPmK3+sod+NfY5sElClnkEM1p2rdQ=
X-Gm-Gg: AZuq6aIPtQ1Ve69055DhFAnwLwnX+niegn8sLwzH6xOxRwUjcb280RWeBC87YxGLM6H
	f9iM3GrNpyrEEbuZ3ZsDTKekTLP6Opx7svNz0owR/cBIihs3MR/HEMQk0HtAaTbISNNBJQQZ9Z3
	0DqebwZ7YH5oEMhAdxSJFszGC3rBenJsfuJVDIv8BUx3zBLjsTA83dA5Hwer/Rg2ZM3kN6YyfuD
	GA9HlwXQM254AX0TgzOE8gQGMYTBtMQ0eHNwLyyJZKilxmsAWE15MAZiQp9n6Ommu7nQNZgY9fK
	se9MQDXd8B8XJjKP+qzBf7PLnBUxcONEsGKJb47tQkFMsmVNXLSYrZCFl2GNfNkszGaDTNlS8GW
	sgMP081ZhfcgUiyZsk6UwkrQinql9i7KtaYsCytQIEoioexeCrmHYNmxYZprc2SoeEMj1SuLlBa
	58pCJZNVrAUy8fSRbk
X-Received: by 2002:a05:6000:613:b0:437:7010:1cfd with SMTP id ffacd0b85a97d-43770101ec3mr5121628f8f.4.1770653561339;
        Mon, 09 Feb 2026 08:12:41 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fc26sm25708937f8f.22.2026.02.09.08.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 08:12:40 -0800 (PST)
Message-ID: <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
Date: Mon, 9 Feb 2026 16:12:39 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thaumy Cheng <thaumy.love@gmail.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Mike Leach <mike.leach@linaro.org>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
 <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
 <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260206152907.GQ1395266@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06/02/2026 3:29 pm, Peter Zijlstra wrote:
> On Fri, Feb 06, 2026 at 11:21:19AM +0000, James Clark wrote:
> 
>> I've been looking into a regression caused by this commit and didn't manage
>> to come up with a fix. But shouldn't this be something more like:
>>
>>    if (attach_state & PERF_ATTACH_CHILD && event_filter_match(event))
>>        sync_child_event(event, task);
>>
>> As in, you only want to call sync_child_event() and write stuff to the ring
>> buffer for the CPU that is currently running this exit handler? Although
>> this change affects the 'total_time_enabled' tracking as well, but I'm not
>> 100% sure if we're not double counting it anyway.
>>
>>  From perf_event_exit_task_context(), perf_event_exit_event() is called on
>> all events, which includes events on other CPUs:
>>
>>    list_for_each_entry_safe(child_event, next, &ctx->event_list, ...)
>>      perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
>>
>> Then we write into those other CPU's ring buffers, which don't support
>> concurrency.
>>
>> The reason I found this is because we have a tracing test that spawns some
>> threads and then looks for PERF_RECORD_AUX events. When there are concurrent
>> writes into the ring buffers, rb->nest tracking gets messed up leaving the
>> count positive even after all nested writers have finished. Then all future
>> writes don't copy the data_head pointer to the user page (because it thinks
>> someone else is writing), so Perf doesn't copy out any data anymore leaving
>> records missing.
>>
>> An easy reproducer is to put a warning that the ring buffer being written to
>> is the correct one:
>>
>>    @@ -41,10 +41,11 @@ static void perf_output_get_handle(struct
>>    perf_output_handle *handle)
>>    {
>>   	struct perf_buffer *rb = handle->rb;
>>
>>   	preempt_disable();
>>
>>    +	WARN_ON(handle->event->cpu != smp_processor_id());
>>
>>
>> And then record:
>>
>>    perf record -s -- stress -c 8 -t 1
>>
>> Which results in:
>>
>>    perf_output_begin+0x320/0x480 (P)
>>    perf_event_exit_event+0x178/0x2c0
>>    perf_event_exit_task_context+0x214/0x2f0
>>    perf_event_exit_task+0xb0/0x3b0
>>    do_exit+0x1bc/0x808
>>    __arm64_sys_exit+0x28/0x30
>>    invoke_syscall+0x4c/0xe8
>>    el0_svc_common+0x9c/0xf0
>>    do_el0_svc+0x28/0x40
>>    el0_svc+0x50/0x240
>>    el0t_64_sync_handler+0x78/0x130
>>    el0t_64_sync+0x198/0x1a0
>>
>> I suppose there is a chance that this is only an issue when also doing
>> perf_aux_output_begin()/perf_aux_output_end() from start/stop because that's
>> where I saw the real race? Maybe without that, accessing the rb from another
>> CPU is ok because there is some locking, but I think this might be a more
>> general issue.
> 
> I *think* something like so.
> 
> Before the patch in question this would never happen, because of calling
> things too late and always hitting that TASK_TOMBSTONE.
> 
> But irrespective of emitting that event, we do want to propagate the
> count and runtime numbers.
> 
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 5b5cb620499e..f566ad55b4fb 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -14086,7 +14086,7 @@ static void sync_child_event(struct perf_event *child_event,
>   	u64 child_val;
>   
>   	if (child_event->attr.inherit_stat) {
> -		if (task && task != TASK_TOMBSTONE)
> +		if (task && task != TASK_TOMBSTONE && event_filter_match(child_event))
>   			perf_event_read_event(child_event, task);
>   	}
>   

Turns out I tested this before with "child_event->cpu == 
raw_smp_processor_id()" rather than using event_filter_match() so I 
missed that the loop over all the events needs to be wrapped with 
preempt_disable(). But that can't be done because 
perf_event_exit_event() takes a mutex.

I don't think the preempt_disable() can be on any smaller region than 
outside the entire loop otherwise you can get rescheduled between 
event_filter_match() checks and end up failing them all and not writing 
any event out at all.

While debugging I also noticed another issue with these per-thread count 
records. perf_event_exit_event() only does anything if the event has a 
parent. But the context switch optimization means that sometimes threads 
re-use the original event which has no parent. So randomly you get 
threads that are missing from the output.

There is a comment that mentions this under the parent check:

   if (parent_event) {
     /*
      * Do not destroy the 'original' grouping; because of the
      * context switch optimization the original events could've
      * ended up in a random child task.

But I'm not sure if that was supposed to be worked around some other way 
and it's now broken, or it was a known limitation of the implementation 
from the beginning? But right now it randomly misses one of the threads 
and includes the main thread counts, or includes all the threads and 
doesn't include the main thread counts if no context switch optimisation 
was done.

The perf record docs don't say anything that you wouldn't expect all 
threads to be there:

     -s, --stat            per thread counts

