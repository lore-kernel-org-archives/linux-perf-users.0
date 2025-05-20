Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E6BA94F;
	Tue, 20 May 2025 22:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747778529; cv=none; b=WqfyXvlYYPLA66SfZ3yhJ1CB8/6SoTLasBItB7nKnT08onCyp8345yOtF8xje52072AjGzYAmsr5mxZBFdnpaL9zEHLOkc5EAVElkJ26Xe8Fc/A+fHetV6RvyUxrjuISI2wE4FnKDWdwCrovP5Jfh6VIbunxqrpTd4p1iaRHYH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747778529; c=relaxed/simple;
	bh=CoUqP5rlAmDvWEfnULnkH8M/gWmIMOD3n9lVCsSBof8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I4LN+a6p03V0MV/xgmaQ4XIyW0QPbgL3VgXhYmclmEpy1YiknzzaXUH2SI4uu6a9R+c/LTJxXr/YGBJz9KY3spbHFQjGug+0XzaD5zt0IlNBvkgoFMO5IUArpA6XMX4LFhwheXGBfgfefMEhtkrs+r9YfIleWIrZkjXcaODl7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbqS63+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbqS63+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD787C4CEE9;
	Tue, 20 May 2025 22:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747778529;
	bh=CoUqP5rlAmDvWEfnULnkH8M/gWmIMOD3n9lVCsSBof8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rbqS63+JPtb8ueKK9wwp4Dez4iOQfdfZNeWfUKUTy+0kgsLIOg46mUcPow0AEWoJN
	 +3+PNhDtF/2rTlnaIqDzbEEie8BhikdpF+nGz0ly20/gVFbaD30+/p9VSVKQjCGkYk
	 2bOE+1Ja8FLSJsxXQJe03pav34twXR3k1wowVEi9px2bGneGB+zqVk3pdYKMzy10sv
	 JpNYTYglTt0I3foP4Cj1KOUOQ1vzIPT6PLSjGUu4dT5Uy0BudFQYMNuqkgRV9+cswx
	 csGq8d39aiNCr2IJEeloTGgCqY75hlTZyBfBhL7ioRZV7p8cLWX3AiSIf/UyA2IQV4
	 yyOwn4N40zl8g==
Date: Tue, 20 May 2025 15:02:07 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com
Subject: Re: [PATCH V4 01/16] perf: Fix the throttle logic for a group
Message-ID: <aCz737AGOGzKDVhI@google.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
 <20250520181644.2673067-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250520181644.2673067-2-kan.liang@linux.intel.com>

On Tue, May 20, 2025 at 11:16:29AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The current throttle logic doesn't work well with a group, e.g., the
> following sampling-read case.
> 
> $ perf record -e "{cycles,cycles}:S" ...
> 
> $ perf report -D | grep THROTTLE | tail -2
>             THROTTLE events:        426  ( 9.0%)
>           UNTHROTTLE events:        425  ( 9.0%)
> 
> $ perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> 0 1020120874009167 0x74970 [0x68]: PERF_RECORD_SAMPLE(IP, 0x1):
> ... sample_read:
> .... group nr 2
> ..... id 0000000000000327, value 000000000cbb993a, lost 0
> ..... id 0000000000000328, value 00000002211c26df, lost 0
> 
> The second cycles event has a much larger value than the first cycles
> event in the same group.
> 
> The current throttle logic in the generic code only logs the THROTTLE
> event. It relies on the specific driver implementation to disable
> events. For all ARCHs, the implementation is similar. Only the event is
> disabled, rather than the group.
> 
> The logic to disable the group should be generic for all ARCHs. Add the
> logic in the generic code. The following patch will remove the buggy
> driver-specific implementation.
> 
> The throttle only happens when an event is overflowed. Stop the entire
> group when any event in the group triggers the throttle.
> The MAX_INTERRUPTS is set to all throttle events.
> 
> The unthrottled could happen in 3 places.
> - event/group sched. All events in the group are scheduled one by one.
>   All of them will be unthrottled eventually. Nothing needs to be
>   changed.
> - The perf_adjust_freq_unthr_events for each tick. Needs to restart the
>   group altogether.
> - The __perf_event_period(). The whole group needs to be restarted
>   altogether as well.
> 
> With the fix,
> $ sudo perf report -D | grep PERF_RECORD_SAMPLE -a4 | tail -n 5
> 0 3573470770332 0x12f5f8 [0x70]: PERF_RECORD_SAMPLE(IP, 0x2):
> ... sample_read:
> .... group nr 2
> ..... id 0000000000000a28, value 00000004fd3dfd8f, lost 0
> ..... id 0000000000000a29, value 00000004fd3dfd8f, lost 0
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  kernel/events/core.c | 66 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 46 insertions(+), 20 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index af78ec118e8f..915698f47682 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2739,6 +2739,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
>  static void perf_log_throttle(struct perf_event *event, int enable);
>  static void perf_log_itrace_start(struct perf_event *event);
>  
> +static void perf_event_unthrottle(struct perf_event *event, bool start)
> +{
> +	event->hw.interrupts = 0;
> +	if (start)
> +		event->pmu->start(event, 0);
> +	perf_log_throttle(event, 1);
> +}
> +
> +static void perf_event_throttle(struct perf_event *event)
> +{
> +	event->pmu->stop(event, 0);
> +	event->hw.interrupts = MAX_INTERRUPTS;
> +	perf_log_throttle(event, 0);
> +}
> +
> +static void perf_event_unthrottle_group(struct perf_event *event, bool skip_start_event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +
> +	perf_event_unthrottle(leader, skip_start_event ? leader != event : true);
> +	for_each_sibling_event(sibling, leader)
> +		perf_event_unthrottle(sibling, skip_start_event ? sibling != event : true);
> +}
> +
> +static void perf_event_throttle_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +
> +	perf_event_throttle(leader);
> +	for_each_sibling_event(sibling, leader)
> +		perf_event_throttle(sibling);
> +}
> +
>  static int
>  event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>  {
> @@ -2767,10 +2800,8 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
>  	 * ticks already, also for a heavily scheduling task there is little
>  	 * guarantee it'll get a tick in a timely manner.
>  	 */
> -	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS)) {
> -		perf_log_throttle(event, 1);
> -		event->hw.interrupts = 0;
> -	}
> +	if (unlikely(event->hw.interrupts == MAX_INTERRUPTS))
> +		perf_event_unthrottle(event, false);
>  
>  	perf_pmu_disable(event->pmu);
>  
> @@ -4393,12 +4424,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  
>  		hwc = &event->hw;
>  
> -		if (hwc->interrupts == MAX_INTERRUPTS) {
> -			hwc->interrupts = 0;
> -			perf_log_throttle(event, 1);
> -			if (!is_event_in_freq_mode(event))
> -				event->pmu->start(event, 0);
> -		}
> +		if (hwc->interrupts == MAX_INTERRUPTS)
> +			perf_event_unthrottle_group(event, is_event_in_freq_mode(event));
>  
>  		if (!is_event_in_freq_mode(event))
>  			continue;
> @@ -6426,14 +6453,6 @@ static void __perf_event_period(struct perf_event *event,
>  	active = (event->state == PERF_EVENT_STATE_ACTIVE);
>  	if (active) {
>  		perf_pmu_disable(event->pmu);
> -		/*
> -		 * We could be throttled; unthrottle now to avoid the tick
> -		 * trying to unthrottle while we already re-started the event.
> -		 */
> -		if (event->hw.interrupts == MAX_INTERRUPTS) {
> -			event->hw.interrupts = 0;
> -			perf_log_throttle(event, 1);
> -		}
>  		event->pmu->stop(event, PERF_EF_UPDATE);
>  	}
>  
> @@ -6441,6 +6460,14 @@ static void __perf_event_period(struct perf_event *event,
>  
>  	if (active) {
>  		event->pmu->start(event, PERF_EF_RELOAD);
> +		/*
> +		 * Once the period is force-reset, the event starts immediately.
> +		 * But the event/group could be throttled. Unthrottle the
> +		 * event/group now to avoid the next tick trying to unthrottle
> +		 * while we already re-started the event/group.
> +		 */
> +		if (event->hw.interrupts == MAX_INTERRUPTS)
> +			perf_event_unthrottle_group(event, true);
>  		perf_pmu_enable(event->pmu);
>  	}
>  }
> @@ -10331,8 +10358,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
>  	if (unlikely(throttle && hwc->interrupts >= max_samples_per_tick)) {
>  		__this_cpu_inc(perf_throttled_count);
>  		tick_dep_set_cpu(smp_processor_id(), TICK_DEP_BIT_PERF_EVENTS);
> -		hwc->interrupts = MAX_INTERRUPTS;
> -		perf_log_throttle(event, 0);
> +		perf_event_throttle_group(event);
>  		ret = 1;
>  	}
>  
> -- 
> 2.38.1
> 
