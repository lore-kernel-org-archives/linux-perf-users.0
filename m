Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438F1B043A;
	Thu, 15 May 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302188; cv=none; b=WaAcsIkrLcJp2LbN22N/cO6l7X8Kj3CkCn0uEl7D4f1YXA2dGnIjZTbzqDCfLS6JzNSWaepp7utoBtaX0k0eyjhnpeYCyQzPq2yUoY+Nv4yE1ZTtr/5QvhQHpPpVLSUEjkFBksYAGV+g8LGu7LeIhZkQ4QriOuYzOqD6VO0/dos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302188; c=relaxed/simple;
	bh=H4ELDb9y0+EqXm3nF7/j/Z0jw82RCViU9zBrxdD81cM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVgVuK9OXFl4y6X4zddd/eZHM+NWQkS2Ns7ymZJgVq3beyOEv/OXBwKIjWeNk3peVRdZ5MEqAkxQutww9jdD1UxQZCz0TANvrWfO4z83mredcH9tVKcTbfBCB/bKw37rYL/h7IdJXIJRq+9KR4nFUMqW5qabH9fuuLztAFFf/wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08AC714BF;
	Thu, 15 May 2025 02:42:54 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B0383F5A1;
	Thu, 15 May 2025 02:43:05 -0700 (PDT)
Date: Thu, 15 May 2025 10:43:00 +0100
From: Leo Yan <leo.yan@arm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com
Subject: Re: [PATCH V2 01/15] perf: Fix the throttle logic for a group
Message-ID: <20250515094300.GC412060@e132581.arm.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
 <20250514151401.2547932-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514151401.2547932-2-kan.liang@linux.intel.com>

On Wed, May 14, 2025 at 08:13:47AM -0700, kan.liang@linux.intel.com wrote:
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
> ---
> 
> Changes since V1:
> - Apply the suggested throttle/unthrottle functions from Peter.
>   The MAX_INTERRUPTS and throttle logs are applied to all events.
> - Update the description and comments accordingly
> 
>  kernel/events/core.c | 58 +++++++++++++++++++++++++++++++++-----------
>  1 file changed, 44 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index a84abc2b7f20..a270fcda766d 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2734,6 +2734,39 @@ void perf_event_disable_inatomic(struct perf_event *event)
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
> +static void perf_event_unthrottle_group(struct perf_event *event, bool start)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +
> +	perf_event_unthrottle(leader, leader != event || start);
> +	for_each_sibling_event(sibling, leader)
> +		perf_event_unthrottle(sibling, sibling != event || start);

Seems to me that the condition "leader != event || start" is bit tricky
(similarly for the check "sibling != event || start").

If a session sets the frequency (with option -F in perf tool), the
following flow is triggered:

  perf_adjust_freq_unthr_events()
    `> perf_event_unthrottle_group(event, false);

The argument "start" is false, so all sibling events will be enabled,
but the event pointed by the "event" argument remains disabled.  Though
the __perf_event_period() function will enables all events with adjusted
period, but it is still risky for counting discrepancy caused by the
flow described above.

Thanks,
Leo

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
> @@ -4389,10 +4422,8 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
>  		hwc = &event->hw;
>  
>  		if (hwc->interrupts == MAX_INTERRUPTS) {
> -			hwc->interrupts = 0;
> -			perf_log_throttle(event, 1);
> -			if (!event->attr.freq || !event->attr.sample_freq)
> -				event->pmu->start(event, 0);
> +			perf_event_unthrottle_group(event,
> +				!event->attr.freq || !event->attr.sample_freq);
>  		}
>  
>  		if (!event->attr.freq || !event->attr.sample_freq)
> @@ -6421,14 +6452,6 @@ static void __perf_event_period(struct perf_event *event,
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
> @@ -6436,6 +6459,14 @@ static void __perf_event_period(struct perf_event *event,
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
> +			perf_event_unthrottle_group(event, false);
>  		perf_pmu_enable(event->pmu);
>  	}
>  }
> @@ -10326,8 +10357,7 @@ __perf_event_account_interrupt(struct perf_event *event, int throttle)
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
> 
