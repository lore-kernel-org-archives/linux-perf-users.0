Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044717E0;
	Sun, 18 May 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747595936; cv=none; b=bSKhVDpH8KRQjrVpPRUGuJcXr2xWXxzL25QzNN+uJZBr+DmBdAXG2Rh26P5lCYNKoOSdHys4m26WjTSYa1u0Qje2/7zbCY4HVR9Ekvn8ZSy8zLA04BIg6/60FebWYlGWBvXWVLfsvTbvJIq3RneUxENLGKn4IeRXRfANl3CMciA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747595936; c=relaxed/simple;
	bh=fRF3CpaQ3ZagL4PfcD5Ss7lAjLAo3ddXRCFd78Uxo0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lHRG16ZDDTbZKGSBBl90Sh+owyDeXrzUZiaTXyXPBzqcmye3eRiXByTHvR3MJouGLLtr18Osw6hiRGRe72vaK6xox2I01W+Eu6GmfHJOgU1oXoHX5/6bX8blD3tUl9+KduqIxn54fBU+qtAgUpsLpfIDfbeOjByV8WLoimgt/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDJ45YVL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDJ45YVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781FBC4CEE7;
	Sun, 18 May 2025 19:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747595935;
	bh=fRF3CpaQ3ZagL4PfcD5Ss7lAjLAo3ddXRCFd78Uxo0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lDJ45YVLzKQzlxEPHXoajXjbdqu88ca7c2Jt8gOVyv6CuBu8QoTOnxsRpdyRy1Wkp
	 CarUbjO5t2mcPFWPNlOiq7KAlu8wqZoGbxQLj4pmx5Bz92VTpeXUuIOfOjytVqmbWP
	 QmIgjRHeIkysxWkOajm2K0u4tTcQ4aOFPUXTsc3JOJBLk72CpTY4/YXrHIwUK1GjFD
	 tIU19PPppnTCA8vG96STx4Z8rq1E6dLfbFWbMQobqLg67u7zOancTPVrVgXiu9I4b6
	 aN1SR+8TNKCYPqYqhW71KYVFn6VrswbHb0FFkqJ/t7IfjhCGY8nW2YMLg9W3cP56CZ
	 E8IfBt7QIyBcw==
Date: Sun, 18 May 2025 12:18:54 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, irogers@google.com,
	mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, eranian@google.com,
	ctshao@google.com, tmricht@linux.ibm.com, leo.yan@arm.com
Subject: Re: [PATCH V3 02/16] perf: Fix the throttle logic for a group
Message-ID: <aCoynoKRbpnOZ7QE@google.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
 <20250516182853.2610284-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250516182853.2610284-3-kan.liang@linux.intel.com>

Hi Kan,

On Fri, May 16, 2025 at 11:28:39AM -0700, kan.liang@linux.intel.com wrote:
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

Thanks for working on this!

> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 60 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 44 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index af78ec118e8f..52490c2ce45b 100644
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

This will add more PERF_RECORD_THROTTLE records for sibling events.
Maybe we can generate it for the actual target event only?

Also the condition for skip_start_event is if it's a freq event.
I think we can skip pmu->start() if the sibling is also a freq event.
I remember KVM folks concern about the number of PMU accesses as it
can cause VM exits.

Thanks,
Namhyung

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
> @@ -4393,12 +4426,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
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
> @@ -6426,14 +6455,6 @@ static void __perf_event_period(struct perf_event *event,
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
> @@ -6441,6 +6462,14 @@ static void __perf_event_period(struct perf_event *event,
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
> @@ -10331,8 +10360,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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
