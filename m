Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0978D33CD2;
	Wed,  7 Aug 2024 15:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043845; cv=none; b=J9CFwCsvWmMRiRi3yYeLQfvXlEEfnomyHCKjDM/9LQ86aLYPrn9rGtwbwHJTXUxNg9+uye5xmbTJ2pHpXuK31w0rumBkNDCnoHywIxTt1v5CSJSofnWMnoAeNl43bajscEREW4asL1fwvrf3KWFjVKEoWE8XM269uv9B0lghLsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043845; c=relaxed/simple;
	bh=uK3eMVCO9lr4xJ4ncEL+z7nxBH9o1xcjKd+B8geHLFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNReqJkvAP/o52/pfHQnhwPtnIHJBV92t+BPeyR2ybkzG+CUsWCrZ7sPU40bktzYj2M0lT6tBQ8/+P2kpO2Lmbp0GBhl/SmKy7tdDq5I9tooBZqgoEhHE5cXboPejQNMLqZFLez7BxKxb1EgaJQRTOTHV3ftcpVXTJ2qjOQI7ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HBDf3MXC; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HBDf3MXC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723043843; x=1754579843;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uK3eMVCO9lr4xJ4ncEL+z7nxBH9o1xcjKd+B8geHLFo=;
  b=HBDf3MXCvplm0VrtfRdsSjBQgEQpTdx3nsRgGkQz8BFt4ue2MQmJoSrz
   QkuAnMJdjfCTGnamd8wMSD749GoRKLDbVdL2MAu1FTpfFFfG2elvU0hdO
   dHuTErSbojzKr0oNji7Jpyctj8z9qpvEj1MlmkoS5fMafYrAkoNRUMl7+
   tvLpI/ihBrf7N7QyDuo/09JFCiOSD4RPE9K36nG4MjLjkOmjopSX+aRyM
   hs2JWfjXs/oguBUH6hB9SaDBc5m8zNYE72ELJfBf1B+SRmmW0R8QOvbVF
   ELI84B1S9eS2Z56QKqxQPHAuu0Z3iosGFFwmDhBpZL20kKekPaDZ7xP61
   Q==;
X-CSE-ConnectionGUID: J/h4fC8OTEOBWqFob7x/GQ==
X-CSE-MsgGUID: 4EDE9KN9QX6I0owlU/xW4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="32511419"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="32511419"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 08:17:22 -0700
X-CSE-ConnectionGUID: KhtWx5ugTzSv9+F7VYJOkg==
X-CSE-MsgGUID: yAtXTmGRQ7iuFp3qgDJfQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57099236"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 08:17:21 -0700
Received: from [10.212.63.105] (kliang2-mobl1.ccr.corp.intel.com [10.212.63.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 465FC20CFED6;
	Wed,  7 Aug 2024 08:17:20 -0700 (PDT)
Message-ID: <b38cc358-8e46-48bd-88c0-ff4b8db6bd15@linux.intel.com>
Date: Wed, 7 Aug 2024 11:17:18 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] perf: Add context time freeze
To: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Cc: acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240807112924.448091402@infradead.org>
 <20240807115550.250637571@infradead.org>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20240807115550.250637571@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024-08-07 7:29 a.m., Peter Zijlstra wrote:
> Many of the the context reschedule users are of the form:
> 
>   ctx_sched_out(.type = EVENT_TIME);
>   ... modify context
>   ctx_resched();
> 
> With the idea that the whole reschedule happens with a single
> time-stamp, rather than with each ctx_sched_out() advancing time and
> ctx_sched_in() re-starting time, creating a non-atomic experience.
> 
> However, Kan noticed that since this completely stops time, it
> actually looses a bit of time between the stop and start. Worse, now
> that we can do partial (per PMU) reschedules, the PMUs that are not
> scheduled out still observe the time glitch.
> 
> Replace this with:
> 
>   ctx_time_freeze();
>   ... modify context
>   ctx_resched();
> 
> With the assumption that this happens in a perf_ctx_lock() /
> perf_ctx_unlock() pair.
> 
> The new ctx_time_freeze() will update time and sets EVENT_FROZEN, and
> ensures EVENT_TIME and EVENT_FROZEN remain set, this avoids
> perf_event_time_now() from observing a time wobble from not seeing
> EVENT_TIME for a little while.
> 
> Additionally, this avoids loosing time between
> ctx_sched_out(EVENT_TIME) and ctx_sched_in(), which would re-set the
> timestamp.
> 
> Reported-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |  128 ++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 86 insertions(+), 42 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -155,20 +155,55 @@ static int cpu_function_call(int cpu, re
>  	return data.ret;
>  }
>  
> +enum event_type_t {
> +	EVENT_FLEXIBLE	= 0x01,
> +	EVENT_PINNED	= 0x02,
> +	EVENT_TIME	= 0x04,
> +	EVENT_FROZEN	= 0x08,
> +	/* see ctx_resched() for details */
> +	EVENT_CPU	= 0x10,
> +	EVENT_CGROUP	= 0x20,
> +
> +	/* compound helpers */
> +	EVENT_ALL         = EVENT_FLEXIBLE | EVENT_PINNED,
> +	EVENT_TIME_FROZEN = EVENT_TIME | EVENT_FROZEN,
> +};
> +
> +static inline void __perf_ctx_lock(struct perf_event_context *ctx)
> +{
> +	raw_spin_lock(&ctx->lock);
> +	WARN_ON_ONCE(ctx->is_active & EVENT_FROZEN);
> +}
> +
>  static void perf_ctx_lock(struct perf_cpu_context *cpuctx,
>  			  struct perf_event_context *ctx)
>  {
> -	raw_spin_lock(&cpuctx->ctx.lock);
> +	__perf_ctx_lock(&cpuctx->ctx);
>  	if (ctx)
> -		raw_spin_lock(&ctx->lock);
> +		__perf_ctx_lock(ctx);
> +}
> +
> +static inline void __perf_ctx_unlock(struct perf_event_context *ctx)
> +{
> +	/*
> +	 * If ctx_sched_in() didn't again set any ALL flags, clean up
> +	 * after ctx_sched_out() by clearing is_active.
> +	 */
> +	if (ctx->is_active & EVENT_FROZEN) {
> +		if (!(ctx->is_active & EVENT_ALL))

Nit:
It may be better to add a macro/inline function to replace all the
(ctx->is_active & EVENT_ALL) check? For example,

+static inline bool perf_ctx_has_active_events(struct perf_event_context
*ctx)
+{
+	return ctx->is_active & EVENT_ALL;
+}
...
+	if (ctx->is_active & EVENT_FROZEN) {
+		if (!perf_ctx_has_active_events(ctx))
+			ctx->is_active = 0;
+		else
+			ctx->is_active &= ~EVENT_FROZEN;

It can tell very straightforwardly that we want to clear all flags if
there is no active event.
The EVENT_ALL may bring confusion. It actually means all events, not all
event types. The developer may have to go to the define and figure out
what exactly the EVENT_ALL includes.

Thanks,
Kan

> +			ctx->is_active = 0;
> +		else
> +			ctx->is_active &= ~EVENT_FROZEN;
> +	}
> +	raw_spin_unlock(&ctx->lock);
>  }
>  
>  static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
>  			    struct perf_event_context *ctx)
>  {
>  	if (ctx)
> -		raw_spin_unlock(&ctx->lock);
> -	raw_spin_unlock(&cpuctx->ctx.lock);
> +		__perf_ctx_unlock(ctx);
> +	__perf_ctx_unlock(&cpuctx->ctx);
>  }
>  
>  #define TASK_TOMBSTONE ((void *)-1L)
> @@ -370,16 +405,6 @@ static void event_function_local(struct
>  	(PERF_SAMPLE_BRANCH_KERNEL |\
>  	 PERF_SAMPLE_BRANCH_HV)
>  
> -enum event_type_t {
> -	EVENT_FLEXIBLE = 0x1,
> -	EVENT_PINNED = 0x2,
> -	EVENT_TIME = 0x4,
> -	/* see ctx_resched() for details */
> -	EVENT_CPU = 0x8,
> -	EVENT_CGROUP = 0x10,
> -	EVENT_ALL = EVENT_FLEXIBLE | EVENT_PINNED,
> -};
> -
>  /*
>   * perf_sched_events : >0 events exist
>   */
> @@ -2332,18 +2357,39 @@ group_sched_out(struct perf_event *group
>  }
>  
>  static inline void
> -ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
> +__ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx, bool final)
>  {
>  	if (ctx->is_active & EVENT_TIME) {
> +		if (ctx->is_active & EVENT_FROZEN)
> +			return;
>  		update_context_time(ctx);
> -		update_cgrp_time_from_cpuctx(cpuctx, false);
> +		update_cgrp_time_from_cpuctx(cpuctx, final);
>  	}
>  }
>  
>  static inline void
> +ctx_time_update(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
> +{
> +	__ctx_time_update(cpuctx, ctx, false);
> +}
> +
> +/*
> + * To be used inside perf_ctx_lock() / perf_ctx_unlock(). Lasts until perf_ctx_unlock().
> + */
> +static inline void
> +ctx_time_freeze(struct perf_cpu_context *cpuctx, struct perf_event_context *ctx)
> +{
> +	ctx_time_update(cpuctx, ctx);
> +	if (ctx->is_active & EVENT_TIME)
> +		ctx->is_active |= EVENT_FROZEN;
> +}
> +
> +static inline void
>  ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
>  {
>  	if (ctx->is_active & EVENT_TIME) {
> +		if (ctx->is_active & EVENT_FROZEN)
> +			return;
>  		update_context_time(ctx);
>  		update_cgrp_time_from_event(event);
>  	}
> @@ -2822,7 +2868,7 @@ static int  __perf_install_in_context(vo
>  #endif
>  
>  	if (reprogram) {
> -		ctx_sched_out(ctx, NULL, EVENT_TIME);
> +		ctx_time_freeze(cpuctx, ctx);
>  		add_event_to_ctx(event, ctx);
>  		ctx_resched(cpuctx, task_ctx, event->pmu_ctx->pmu,
>  			    get_event_type(event));
> @@ -2968,8 +3014,7 @@ static void __perf_event_enable(struct p
>  	    event->state <= PERF_EVENT_STATE_ERROR)
>  		return;
>  
> -	if (ctx->is_active)
> -		ctx_sched_out(ctx, NULL, EVENT_TIME);
> +	ctx_time_freeze(cpuctx, ctx);
>  
>  	perf_event_set_state(event, PERF_EVENT_STATE_INACTIVE);
>  	perf_cgroup_event_enable(event, ctx);
> @@ -2977,19 +3022,15 @@ static void __perf_event_enable(struct p
>  	if (!ctx->is_active)
>  		return;
>  
> -	if (!event_filter_match(event)) {
> -		ctx_sched_in(ctx, NULL, EVENT_TIME);
> +	if (!event_filter_match(event))
>  		return;
> -	}
>  
>  	/*
>  	 * If the event is in a group and isn't the group leader,
>  	 * then don't put it on unless the group is on.
>  	 */
> -	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE) {
> -		ctx_sched_in(ctx, NULL, EVENT_TIME);
> +	if (leader != event && leader->state != PERF_EVENT_STATE_ACTIVE)
>  		return;
> -	}
>  
>  	task_ctx = cpuctx->task_ctx;
>  	if (ctx->task)
> @@ -3263,7 +3304,7 @@ static void __pmu_ctx_sched_out(struct p
>  	struct perf_event *event, *tmp;
>  	struct pmu *pmu = pmu_ctx->pmu;
>  
> -	if (ctx->task && !ctx->is_active) {
> +	if (ctx->task && !(ctx->is_active & EVENT_ALL)) {
>  		struct perf_cpu_pmu_context *cpc;
>  
>  		cpc = this_cpu_ptr(pmu->cpu_pmu_context);
> @@ -3338,24 +3379,29 @@ ctx_sched_out(struct perf_event_context
>  	 *
>  	 * would only update time for the pinned events.
>  	 */
> -	if (is_active & EVENT_TIME) {
> -		/* update (and stop) ctx time */
> -		update_context_time(ctx);
> -		update_cgrp_time_from_cpuctx(cpuctx, ctx == &cpuctx->ctx);
> +	__ctx_time_update(cpuctx, ctx, ctx == &cpuctx->ctx);
> +
> +	/*
> +	 * CPU-release for the below ->is_active store,
> +	 * see __load_acquire() in perf_event_time_now()
> +	 */
> +	barrier();
> +	ctx->is_active &= ~event_type;
> +
> +	if (!(ctx->is_active & EVENT_ALL)) {
>  		/*
> -		 * CPU-release for the below ->is_active store,
> -		 * see __load_acquire() in perf_event_time_now()
> +		 * For FROZEN, preserve TIME|FROZEN such that perf_event_time_now()
> +		 * does not observe a hole. perf_ctx_unlock() will clean up.
>  		 */
> -		barrier();
> +		if (ctx->is_active & EVENT_FROZEN)
> +			ctx->is_active &= EVENT_TIME_FROZEN;
> +		else
> +			ctx->is_active = 0;
>  	}
>  
> -	ctx->is_active &= ~event_type;
> -	if (!(ctx->is_active & EVENT_ALL))
> -		ctx->is_active = 0;
> -
>  	if (ctx->task) {
>  		WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> -		if (!ctx->is_active)
> +		if (!(ctx->is_active & EVENT_ALL))
>  			cpuctx->task_ctx = NULL;
>  	}
>  
> @@ -3943,7 +3989,7 @@ ctx_sched_in(struct perf_event_context *
>  
>  	ctx->is_active |= (event_type | EVENT_TIME);
>  	if (ctx->task) {
> -		if (!is_active)
> +		if (!(is_active & EVENT_ALL))
>  			cpuctx->task_ctx = ctx;
>  		else
>  			WARN_ON_ONCE(cpuctx->task_ctx != ctx);
> @@ -4424,7 +4470,7 @@ static void perf_event_enable_on_exec(st
>  
>  	cpuctx = this_cpu_ptr(&perf_cpu_context);
>  	perf_ctx_lock(cpuctx, ctx);
> -	ctx_sched_out(ctx, NULL, EVENT_TIME);
> +	ctx_time_freeze(cpuctx, ctx);
>  
>  	list_for_each_entry(event, &ctx->event_list, event_entry) {
>  		enabled |= event_enable_on_exec(event, ctx);
> @@ -4437,8 +4483,6 @@ static void perf_event_enable_on_exec(st
>  	if (enabled) {
>  		clone_ctx = unclone_ctx(ctx);
>  		ctx_resched(cpuctx, ctx, NULL, event_type);
> -	} else {
> -		ctx_sched_in(ctx, NULL, EVENT_TIME);
>  	}
>  	perf_ctx_unlock(cpuctx, ctx);
>  
> 
> 
> 
