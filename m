Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B51C37AA6A
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140404; cv=none; b=oycvjiTkl7ElPDPv7/Vp3GKAEbcmJ61UecaqtB82ynLy6feXx2f7ZdkmMwxzSp4D8Img0xxfHBntjJe5ZINLz4hSbCZgwg46tR8V7G9ra9VxuxO3vyFdRtOoF3dMX922j7kSVgrDWu41jg2jgvCmNoX0UaHchmrr3oEmOeAYjDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140404; c=relaxed/simple;
	bh=p45RwZPqiNcKfpcPPNkvg7ub76fDutRluO2NdMRX5Mc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s86YK59oLyfDZJ44lLz3G4A5qErr5cVFX+1BGveaQRPicdbxY5bMM6mX7BfRsgiIPZPy2PA32DeNLJsI3Y6g0dBO0324723lBi2HVCYaimXL+TwMEbgkaRgoWtV0dhA5rYPSh7uBBg2fennpqcvg9d6p2BhJlee7HgXs26pAeHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m0lKmvVE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m0lKmvVE"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso26693725e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2026 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773140400; x=1773745200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18Bemw2alydwh3BKjTiEd+US+xiv3ZYd4DOyRrClHe4=;
        b=m0lKmvVEW6Ne8u5t+65GPEy2m71UDIZuZJ4Akj0gWPrcbzbZEL1XB1PmzRycI6cSAX
         1tM+m2gcZRxGmyWVwpAxhJ8v1reJNUh6SO4ugaWg2oiitGqcqWmTVPMtAKI5q+jFdhoI
         /Dg8nIWdCK4kO8K9vos0IuB5QrU1rloW+eJ2myZJ7ETm2W6Lf9dUrcsHxkkziFj6uUr/
         op7aA3w1N1OfKQ3UZQqiEMlz0oNCUmKya6Z39Kku9DSCufouAUt22JxBAtRP2um0Tg5u
         6gAdkgVefU1Q+ZH5h8Z3vvXUDoXNz2wyQctwk5ynypuWvCQGsdKcT4dBb6CPDssGOTNv
         pDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773140400; x=1773745200;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=18Bemw2alydwh3BKjTiEd+US+xiv3ZYd4DOyRrClHe4=;
        b=VObA+gvK7pWzgAdB0CH4uCQUUndIMr+JmVuCcxJ66a9ySZF9xh70Y/A+qf7e5fmp/m
         v3FnYQUD/So36SlThtuRfS4bnY0C//uNDIDeuRASbt6FVwbs3UX2Qy11pcrq4rKDYojJ
         Xoys6juchkyP2U+6vMOVB4UHiLz90iRWvHxgCVSdlXnUEYsf6clAALUi1SMnTCe3D3o+
         U72p/3023BdxZhSyFTWasjCkVlS+z7twUhKL/5wGmtc9p9FYfQkGpOvvPo37usj2AOq3
         +wvaohvmrTu2UxW5+9y65h5cJhuqOTU1LZjrT/hfOiSKHutaFRdDSbB6YXd2CUBLvcUy
         h15A==
X-Forwarded-Encrypted: i=1; AJvYcCUi0n7Q1nvNNg4y52pPSnDDMXM+Q4CUNMPZrQe9goc66NpX+Wc7cjrop/LY1wzAGPP3otwW9JnZlk5cFsyVmZYm@vger.kernel.org
X-Gm-Message-State: AOJu0YwcNZiIMO+lUVqLRlcctlWPLFkY6pG7OpRR6R5KBDHtB5SmRnWn
	FbpzAuVpDqqk8Ee1R/+fLIpApa/6qlqmYpSOuVWi+NyC+3iNqgD9o1+wjtGHw7BsdZUva7DT+2J
	oeYwofr0=
X-Gm-Gg: ATEYQzzsZK0q4Vi8zuVK0A/ICedR5eFmQ5Bl9Z6LMzWSrJpAjeyQohcDEXGVEtGSb8x
	OPcEVTTobbgxBU9HZ1d9c2LAr1xQQpK0fhTBVFAZN8XT1ONmmzbWSvDLef/9cnYPU9Oqq9dzfr+
	CLR1vJFVZcuLKt8Z/DQ5F7px2FFcsE+c/YEj+qsQkKs1BBKcuHGC36DiJ4Xk89KLWeeAsAvxMGj
	qUp4xy1Px8p2/9o0Vz6NZ6+tLEiNDqBQ6BWAp2/GpR1dmZGFo4aW3qtKDC3o25WkapwwTn1j9Vt
	9gERv8KXytDY4aZHWUF9q9UEq+ksYajACb/2yRKv3WF/iDKSB6mX0//d7Z5P5B6lz2T0alRcKWl
	IzT15oC9uIa33AlY7gXh0LGLzEjBLkBLRpWyUc7Mo77cq4/Xm7szZk0A1u2JBh23wMGjt7ciLrQ
	0o2zKTCyMkY1E7AFgZgdNDVDuO435f9jo8vKTs7bA=
X-Received: by 2002:a05:600c:8b62:b0:485:309c:2984 with SMTP id 5b1f17b1804b1-48530bab0a8mr158261025e9.13.1773140400348;
        Tue, 10 Mar 2026 04:00:00 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ad1e4esm68707155e9.8.2026.03.10.03.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:59:59 -0700 (PDT)
Message-ID: <36451310-cf91-4e01-a343-f90bf6466fc4@linaro.org>
Date: Tue, 10 Mar 2026 10:59:58 +0000
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
 <61e544ab-d9b9-454e-9dd7-65625d9be126@linaro.org>
 <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260303142948.GA3698720@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/03/2026 2:29 pm, Peter Zijlstra wrote:
> 
> Sorry, things got lost again :-(
> 
> On Mon, Feb 09, 2026 at 04:12:39PM +0000, James Clark wrote:
> 
>>>>     @@ -41,10 +41,11 @@ static void perf_output_get_handle(struct
>>>>     perf_output_handle *handle)
>>>>     {
>>>>    	struct perf_buffer *rb = handle->rb;
>>>>
>>>>    	preempt_disable();
>>>>
>>>>     +	WARN_ON(handle->event->cpu != smp_processor_id());
>>>>
> 
>>> ---
>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>> index 5b5cb620499e..f566ad55b4fb 100644
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -14086,7 +14086,7 @@ static void sync_child_event(struct perf_event *child_event,
>>>    	u64 child_val;
>>>    	if (child_event->attr.inherit_stat) {
>>> -		if (task && task != TASK_TOMBSTONE)
>>> +		if (task && task != TASK_TOMBSTONE && event_filter_match(child_event))
>>>    			perf_event_read_event(child_event, task);
>>>    	}
>>
>> Turns out I tested this before with "child_event->cpu ==
>> raw_smp_processor_id()" rather than using event_filter_match() so I missed
>> that the loop over all the events needs to be wrapped with
>> preempt_disable(). But that can't be done because perf_event_exit_event()
>> takes a mutex.
>>
>> I don't think the preempt_disable() can be on any smaller region than
>> outside the entire loop otherwise you can get rescheduled between
>> event_filter_match() checks and end up failing them all and not writing any
>> event out at all.
> 
> Ooh, cute. That's annoying. This is specific to using per-task-per-cpu
> buffers afaict, nevertheless those ought to work.
> 
> Also, I suspect your WARN would trigger before c418d8b4d7a4 as well, if
> it wouldn't have been for that TOMBSTONE thing.
> 
> How to fix this mess... perhaps something like this, except now I worry
> about the revoke and remove_on_exec cases; do they want something?
> 
> 

So the fixes here seem to fix the two problems for me, didn't see any 
issues in the Perf tests either. Not sure about remove_on_exec though, I 
didn't test that.

> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 03ced7aad309..d0aae76cabf4 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -4727,7 +4727,6 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
>   static void perf_remove_from_owner(struct perf_event *event);
>   static void perf_event_exit_event(struct perf_event *event,
>   				  struct perf_event_context *ctx,
> -				  struct task_struct *task,
>   				  bool revoke);
>   
>   /*
> @@ -4755,7 +4754,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
>   
>   		modified = true;
>   
> -		perf_event_exit_event(event, ctx, ctx->task, false);
> +		perf_event_exit_event(event, ctx, false);
>   	}
>   
>   	raw_spin_lock_irqsave(&ctx->lock, flags);
> @@ -12863,7 +12862,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
>   	/*
>   	 * De-schedule the event and mark it REVOKED.
>   	 */
> -	perf_event_exit_event(event, ctx, ctx->task, true);
> +	perf_event_exit_event(event, ctx, true);
>   
>   	/*
>   	 * All _free_event() bits that rely on event->pmu:
> @@ -14424,17 +14423,11 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
>   }
>   EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
>   
> -static void sync_child_event(struct perf_event *child_event,
> -			     struct task_struct *task)
> +static void sync_child_event(struct perf_event *child_event)
>   {
>   	struct perf_event *parent_event = child_event->parent;
>   	u64 child_val;
>   
> -	if (child_event->attr.inherit_stat) {
> -		if (task && task != TASK_TOMBSTONE)
> -			perf_event_read_event(child_event, task);
> -	}
> -
>   	child_val = perf_event_count(child_event, false);
>   
>   	/*
> @@ -14450,7 +14443,6 @@ static void sync_child_event(struct perf_event *child_event,
>   static void
>   perf_event_exit_event(struct perf_event *event,
>   		      struct perf_event_context *ctx,
> -		      struct task_struct *task,
>   		      bool revoke)
>   {
>   	struct perf_event *parent_event = event->parent;
> @@ -14476,7 +14468,7 @@ perf_event_exit_event(struct perf_event *event,
>   		attach_state = READ_ONCE(event->attach_state);
>   
>   		if (attach_state & PERF_ATTACH_CHILD)
> -			sync_child_event(event, task);
> +			sync_child_event(event);
>   	}
>   
>   	if (revoke)
> @@ -14517,7 +14509,7 @@ perf_event_exit_event(struct perf_event *event,
>   static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>   {
>   	struct perf_event_context *ctx, *clone_ctx = NULL;
> -	struct perf_event *child_event, *next;
> +	struct perf_event *event, *next;
>   
>   	ctx = perf_pin_task_context(task);
>   	if (!ctx)
> @@ -14564,11 +14556,21 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>   	 * won't get any samples after PERF_RECORD_EXIT. We can however still
>   	 * get a few PERF_RECORD_READ events.
>   	 */
> -	if (exit)
> +	if (exit) {
>   		perf_event_task(task, ctx, 0);
>   
> -	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> -		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
> +		guard(raw_spinlock_irq)(&ctx->lock);
> +		list_for_each_entry(event, &ctx->event_list, event_entry) {
> +			if (event->attr.inherit_stat) {
> +				if (task && task != TASK_TOMBSTONE &&
> +				    event_filter_match(event))
> +					perf_event_read_event(event, task);
> +			}
> +		}
> +	}
> +
> +	list_for_each_entry_safe(event, next, &ctx->event_list, event_entry)
> +		perf_event_exit_event(event, ctx, false);
>   
>   	mutex_unlock(&ctx->mutex);
>   
> 
>> While debugging I also noticed another issue with these per-thread count
>> records. perf_event_exit_event() only does anything if the event has a
>> parent. But the context switch optimization means that sometimes threads
>> re-use the original event which has no parent. So randomly you get threads
>> that are missing from the output.
>>
>> There is a comment that mentions this under the parent check:
>>
>>    if (parent_event) {
>>      /*
>>       * Do not destroy the 'original' grouping; because of the
>>       * context switch optimization the original events could've
>>       * ended up in a random child task.
>>
>> But I'm not sure if that was supposed to be worked around some other way and
>> it's now broken, or it was a known limitation of the implementation from the
>> beginning? But right now it randomly misses one of the threads and includes
>> the main thread counts, or includes all the threads and doesn't include the
>> main thread counts if no context switch optimisation was done.
>>
>> The perf record docs don't say anything that you wouldn't expect all threads
>> to be there:
>>
>>      -s, --stat            per thread counts
> 
> Ha! So commit bfbd3381e63a ("perf_counter: Implement more accurate per
> task statistics") actually mentions that issue and tries to mitigate,
> but I think I indeed missed a case.
> 
> I suppose the easiest fix is this, but urgh...
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 03ced7aad309..c38acf1e2f43 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3664,6 +3664,9 @@ static int context_equiv(struct perf_event_context *ctx1,
>   	if (ctx1->pin_count || ctx2->pin_count)
>   		return 0;
>   
> +	if (ctx1->nr_stat || ctx2->nr_stat)
> +		return 0;
> +
>   	/* If ctx1 is the parent of ctx2 */
>   	if (ctx1 == ctx2->parent_ctx && ctx1->generation == ctx2->parent_gen)
>   		return 1;
> @@ -3677,76 +3680,13 @@ static int context_equiv(struct perf_event_context *ctx1,
>   	 * hierarchy, see perf_event_init_context().
>   	 */
>   	if (ctx1->parent_ctx && ctx1->parent_ctx == ctx2->parent_ctx &&
> -			ctx1->parent_gen == ctx2->parent_gen)
> +	    ctx1->parent_gen == ctx2->parent_gen)
>   		return 1;
>   
>   	/* Unmatched */
>   	return 0;
>   }
>   
> -static void __perf_event_sync_stat(struct perf_event *event,
> -				     struct perf_event *next_event)
> -{
> -	u64 value;
> -
> -	if (!event->attr.inherit_stat)
> -		return;
> -
> -	/*
> -	 * Update the event value, we cannot use perf_event_read()
> -	 * because we're in the middle of a context switch and have IRQs
> -	 * disabled, which upsets smp_call_function_single(), however
> -	 * we know the event must be on the current CPU, therefore we
> -	 * don't need to use it.
> -	 */
> -	perf_pmu_read(event);
> -
> -	perf_event_update_time(event);
> -
> -	/*
> -	 * In order to keep per-task stats reliable we need to flip the event
> -	 * values when we flip the contexts.
> -	 */
> -	value = local64_read(&next_event->count);
> -	value = local64_xchg(&event->count, value);
> -	local64_set(&next_event->count, value);
> -
> -	swap(event->total_time_enabled, next_event->total_time_enabled);
> -	swap(event->total_time_running, next_event->total_time_running);
> -
> -	/*
> -	 * Since we swizzled the values, update the user visible data too.
> -	 */
> -	perf_event_update_userpage(event);
> -	perf_event_update_userpage(next_event);
> -}
> -
> -static void perf_event_sync_stat(struct perf_event_context *ctx,
> -				   struct perf_event_context *next_ctx)
> -{
> -	struct perf_event *event, *next_event;
> -
> -	if (!ctx->nr_stat)
> -		return;
> -
> -	update_context_time(ctx);
> -
> -	event = list_first_entry(&ctx->event_list,
> -				   struct perf_event, event_entry);
> -
> -	next_event = list_first_entry(&next_ctx->event_list,
> -					struct perf_event, event_entry);
> -
> -	while (&event->event_entry != &ctx->event_list &&
> -	       &next_event->event_entry != &next_ctx->event_list) {
> -
> -		__perf_event_sync_stat(event, next_event);
> -
> -		event = list_next_entry(event, event_entry);
> -		next_event = list_next_entry(next_event, event_entry);
> -	}
> -}
> -
>   static void perf_ctx_sched_task_cb(struct perf_event_context *ctx,
>   				   struct task_struct *task, bool sched_in)
>   {
> @@ -3835,8 +3775,6 @@ perf_event_context_sched_out(struct task_struct *task, struct task_struct *next)
>   			RCU_INIT_POINTER(next->perf_event_ctxp, ctx);
>   
>   			do_switch = 0;
> -
> -			perf_event_sync_stat(ctx, next_ctx);
>   		}
>   		raw_spin_unlock(&next_ctx->lock);
>   		raw_spin_unlock(&ctx->lock);

