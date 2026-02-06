Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7352378D7E
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770376883; cv=none; b=cdTP/vD0/wgVIEnkWFYTqKBH27jTaSuHaOOOqDfkIS2X8C7qnLaIZyt6CN/GRs6Z+Z/w9r+ICx7rVBxAoGuzfzL6NYrZQcfts7HQwvulqGE0RyPe5LPDi5dblLoBThLoedBokOI0SiPLqrh0rAg5ZWBYoFt252PTZYQa1nrtYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770376883; c=relaxed/simple;
	bh=kyjAZ7ptnjDgfiQMtgIyufRrqBRSUlAdt6onQIjHw9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B3LbJ2RrGfveE1OjCPlZAcU+awaVonb2n0CA0LVgxkiG6R7CdVjAKRfMeyX4vTU2cza0uef+c7VJax9iNrwcsXDLxQrlG8dHJh/Mjgrcio8AdVNT+DUtNoqbVRIzzHx1OCJ/Ib9ufiN0IZ5ejcMalsFin1EE79w+GISW1StmQIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tBZY1x7b; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tBZY1x7b"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso17304215e9.1
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 03:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770376881; x=1770981681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6uKEaP0lVPUAhKZXv5kiloZrMG9TcJ44mU/KajbPFvI=;
        b=tBZY1x7bzSV3aXo4c9MAUgSHLUvmQ/zUf4MmcrUNe0q25IwLopSGQ//WPB31VCY+k7
         SwwUpgPo2gVBzhwKiSl/Wli3XpQC+gG6DL93aba2gAdx7Ej3XvV0oBbFiXokkyhAY5CN
         FT9j15jmgSlKvotNW/rbfHz7/Rmw4Wh9dHJGXgwsC/VvYJPvnAqxa2WHt4WaO4iOLpgS
         HRMTeh9ZPNmUyhICFuIXpuoZ9GLhk9kX7QGJiV7WdxIcQ2OgRhKXF09n40V3OOcVNmEV
         aYAzxs4PIEW9plbVjSlLlbRX6twDHqD1l44yAezF6DHlq88RjVE2Ijn7OubsThxEwzCn
         etPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770376881; x=1770981681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6uKEaP0lVPUAhKZXv5kiloZrMG9TcJ44mU/KajbPFvI=;
        b=OUjSXd4JCz7Ilzdrc7JNjKWnmtMMrNt7ktCNYdyzGHl2+PH6uF2Q2EqumiG8eT/yF/
         KF2JIA9mOjhQ2kSLWO4KeK5v+bgAA9l/9DifkI4lCNQI/ukPLSjkPqsW3tXSNLwo36TJ
         ofCMxKIa4HfXfWRttYxrFOIvBBMcegGZGI7U3aPDVsgWofGUGzO7qd63CN2tuEv/n20Y
         lqg7RSjEjv6eJycijAydGgozsVA/J5XdYpteBsDmuTBrJDDF7QFPc/2Aeo7v3e1sFywu
         OSx2McsC9q9vWFRqO8OUDQ4uqJOFl9fRazHuoCuLECbu4IwEZycN7BGyjmCnH7k5SGmz
         Ve6Q==
X-Gm-Message-State: AOJu0YyxAtNgNiABKgIAKTJq2yGgmakou9iVp54v7nRzKcvuZBVO77Bz
	klWV7veh7OIT/LHuhk0HXpnEQnuK/WN5yAhrB4hw51HCKEUEqXAvBnCpFEirJqPJ6ds=
X-Gm-Gg: AZuq6aIhbeP9snZ3QbvjoyBBEkBdU3JdlxHTMVSZ6g/w12Q4xIGjK285CwYqqH0/iv1
	x+m4zhr8HBYNlOdO5EcMZAT8KTGc05A0uwTD/03FJgiEdRRefb40zR4hjkT80b1aXkJlaNi8hAs
	yzRC8vWj94EZQkL9ELrAsDlgYCxBUSrJgdXL/Hrn2gqVSruZYjyyd5Ez1LMqPDJZgfp7kTdNw8d
	hGGSR8Z6UXy8D3GK/TSldAYxOvggMI4mKT2yxH9Vo1bmj3MtQjIULSmZqym/M3aWfwBc6zqHdmI
	+A38YYCg5/IlT20eVylwEKq+0G27zPGLGxX/Ydvn5hUaksCx4T2Zo9NRKZ6/mxC5GwUuaF5xhwa
	HGWM0jOXqn2iRD61sIovmeOlJW+YEm+faQyphIie6E3z4cYF4RR/2foAxqq9M87oetta6vE13h4
	7Oa6uomxhVO34HF28d
X-Received: by 2002:a05:600c:4f81:b0:480:3a71:92b2 with SMTP id 5b1f17b1804b1-4832097d2famr28132715e9.26.1770376881016;
        Fri, 06 Feb 2026 03:21:21 -0800 (PST)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209e0857sm15464375e9.16.2026.02.06.03.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 03:21:20 -0800 (PST)
Message-ID: <1e6337ec-d4a0-420b-bd7b-0fd2b6fee620@linaro.org>
Date: Fri, 6 Feb 2026 11:21:19 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf/core: Fix missing read event generation on task
 exit
To: Thaumy Cheng <thaumy.love@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>,
 Mike Leach <mike.leach@linaro.org>
References: <20251024170543.11201-1-thaumy.love@gmail.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20251024170543.11201-1-thaumy.love@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/10/2025 6:05 pm, Thaumy Cheng wrote:
> For events with inherit_stat enabled, a "read" event will be generated
> to collect per task event counts on task exit.
> 
> The call chain is as follows:
> 
> do_exit
>    -> perf_event_exit_task
>      -> perf_event_exit_task_context
>        -> perf_event_exit_event
>          -> perf_remove_from_context
>            -> perf_child_detach
>              -> sync_child_event
>                -> perf_event_read_event
> 
> However, the child event context detaches the task too early in
> perf_event_exit_task_context, which causes sync_child_event to never
> generate the read event in this case, since child_event->ctx->task is
> always set to TASK_TOMBSTONE. Fix that by moving context lock section
> backward to ensure ctx->task is not set to TASK_TOMBSTONE before
> generating the read event.
> 
> Because perf_event_free_task calls perf_event_exit_task_context with
> exit = false to tear down all child events from the context, and the
> task never lived, accessing the task PID can lead to a use-after-free.
> 
> To fix that, let sync_child_event read task from argument and move the
> call to the only place it should be triggered to avoid the effect of
> setting ctx->task to TASK_TOMESTONE, and add a task parameter to
> perf_event_exit_event to trigger the sync_child_event properly when
> needed.
> 
> This bug can be reproduced by running "perf record -s" and attaching to
> any program that generates perf events in its child tasks. If we check
> the result with "perf report -T", the last line of the report will leave
> an empty table like "# PID  TID", which is expected to contain the
> per-task event counts by design.
> 
> Fixes: ef54c1a476ae ("perf: Rework perf_event_exit_event()")
> Signed-off-by: Thaumy Cheng <thaumy.love@gmail.com>
> ---
> Changes in v3:
> - Fix the bug in a more direct way by moving the call to
>    sync_child_event and bring back the task param to
>    perf_event_exit_event.
>    This approach avoids the event unscheduling issue in v2.
> 
> Changes in v2:
> - Only trigger read event on task exit.
> - Rename perf_event_exit_event to perf_event_detach_event.
> - Link to v2: https://lore.kernel.org/all/20250817132742.85154-1-thaumy.love@gmail.com/
> 
> Changes in v1:
> - Set TASK_TOMBSTONE after the read event is tirggered.
> - Link to v1: https://lore.kernel.org/all/20250720000424.12572-1-thaumy.love@gmail.com/
> 
>   kernel/events/core.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 177e57c1a362..618e7947c358 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2316,7 +2316,8 @@ static void perf_group_detach(struct perf_event *event)
>   	perf_event__header_size(leader);
>   }
> 
> -static void sync_child_event(struct perf_event *child_event);
> +static void sync_child_event(struct perf_event *child_event,
> +			     struct task_struct *task);
> 
>   static void perf_child_detach(struct perf_event *event)
>   {
> @@ -2336,7 +2337,6 @@ static void perf_child_detach(struct perf_event *event)
>   	lockdep_assert_held(&parent_event->child_mutex);
>   	 */
> 
> -	sync_child_event(event);
>   	list_del_init(&event->child_list);
>   }
> 
> @@ -4587,6 +4587,7 @@ static void perf_event_enable_on_exec(struct perf_event_context *ctx)
>   static void perf_remove_from_owner(struct perf_event *event);
>   static void perf_event_exit_event(struct perf_event *event,
>   				  struct perf_event_context *ctx,
> +				  struct task_struct *task,
>   				  bool revoke);
> 
>   /*
> @@ -4614,7 +4615,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
> 
>   		modified = true;
> 
> -		perf_event_exit_event(event, ctx, false);
> +		perf_event_exit_event(event, ctx, ctx->task, false);
>   	}
> 
>   	raw_spin_lock_irqsave(&ctx->lock, flags);
> @@ -12437,7 +12438,7 @@ static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
>   	/*
>   	 * De-schedule the event and mark it REVOKED.
>   	 */
> -	perf_event_exit_event(event, ctx, true);
> +	perf_event_exit_event(event, ctx, ctx->task, true);
> 
>   	/*
>   	 * All _free_event() bits that rely on event->pmu:
> @@ -13994,14 +13995,13 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
>   }
>   EXPORT_SYMBOL_GPL(perf_pmu_migrate_context);
> 
> -static void sync_child_event(struct perf_event *child_event)
> +static void sync_child_event(struct perf_event *child_event,
> +			     struct task_struct *task)
>   {
>   	struct perf_event *parent_event = child_event->parent;
>   	u64 child_val;
> 
>   	if (child_event->attr.inherit_stat) {
> -		struct task_struct *task = child_event->ctx->task;
> -
>   		if (task && task != TASK_TOMBSTONE)
>   			perf_event_read_event(child_event, task);
>   	}
> @@ -14020,7 +14020,9 @@ static void sync_child_event(struct perf_event *child_event)
> 
>   static void
>   perf_event_exit_event(struct perf_event *event,
> -		      struct perf_event_context *ctx, bool revoke)
> +		      struct perf_event_context *ctx,
> +		      struct task_struct *task,
> +		      bool revoke)
>   {
>   	struct perf_event *parent_event = event->parent;
>   	unsigned long detach_flags = DETACH_EXIT;
> @@ -14043,6 +14045,9 @@ perf_event_exit_event(struct perf_event *event,
>   		mutex_lock(&parent_event->child_mutex);
>   		/* PERF_ATTACH_ITRACE might be set concurrently */
>   		attach_state = READ_ONCE(event->attach_state);
> +
> +		if (attach_state & PERF_ATTACH_CHILD)
> +			sync_child_event(event, task);

Hi Thaumy and Peter,

I've been looking into a regression caused by this commit and didn't 
manage to come up with a fix. But shouldn't this be something more like:

   if (attach_state & PERF_ATTACH_CHILD && event_filter_match(event))
       sync_child_event(event, task);

As in, you only want to call sync_child_event() and write stuff to the 
ring buffer for the CPU that is currently running this exit handler? 
Although this change affects the 'total_time_enabled' tracking as well, 
but I'm not 100% sure if we're not double counting it anyway.

 From perf_event_exit_task_context(), perf_event_exit_event() is called 
on all events, which includes events on other CPUs:

   list_for_each_entry_safe(child_event, next, &ctx->event_list, ...)
     perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);

Then we write into those other CPU's ring buffers, which don't support 
concurrency.

The reason I found this is because we have a tracing test that spawns 
some threads and then looks for PERF_RECORD_AUX events. When there are 
concurrent writes into the ring buffers, rb->nest tracking gets messed 
up leaving the count positive even after all nested writers have 
finished. Then all future writes don't copy the data_head pointer to the 
user page (because it thinks someone else is writing), so Perf doesn't 
copy out any data anymore leaving records missing.

An easy reproducer is to put a warning that the ring buffer being 
written to is the correct one:

   @@ -41,10 +41,11 @@ static void perf_output_get_handle(struct
   perf_output_handle *handle)
   {
  	struct perf_buffer *rb = handle->rb;

  	preempt_disable();

   +	WARN_ON(handle->event->cpu != smp_processor_id());


And then record:

   perf record -s -- stress -c 8 -t 1

Which results in:

   perf_output_begin+0x320/0x480 (P)
   perf_event_exit_event+0x178/0x2c0
   perf_event_exit_task_context+0x214/0x2f0
   perf_event_exit_task+0xb0/0x3b0
   do_exit+0x1bc/0x808
   __arm64_sys_exit+0x28/0x30
   invoke_syscall+0x4c/0xe8
   el0_svc_common+0x9c/0xf0
   do_el0_svc+0x28/0x40
   el0_svc+0x50/0x240
   el0t_64_sync_handler+0x78/0x130
   el0t_64_sync+0x198/0x1a0

I suppose there is a chance that this is only an issue when also doing 
perf_aux_output_begin()/perf_aux_output_end() from start/stop because 
that's where I saw the real race? Maybe without that, accessing the rb 
from another CPU is ok because there is some locking, but I think this 
might be a more general issue.

Thanks
James


>   	}
> 
>   	if (revoke)
> @@ -14134,7 +14139,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
>   		perf_event_task(task, ctx, 0);
> 
>   	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
> -		perf_event_exit_event(child_event, ctx, false);
> +		perf_event_exit_event(child_event, ctx, exit ? task : NULL, false);
> 
>   	mutex_unlock(&ctx->mutex);
> 
> --
> 2.51.0
> 

