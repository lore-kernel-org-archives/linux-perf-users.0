Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D4746E;
	Mon, 24 Mar 2025 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845689; cv=none; b=KSoqXeNDeHfHG9jyKE3Lh/3SvtVSQkoHvprOKnnhZAd2oyFYZIqikTqD3QkLyrgBxOZj9gqpiaf+UC0OpoJBG0jMk9kRcqhlERb172lbGeX3a6pr7ydJ+nYEhg0zr0L5p4vRVShkn2KEOoy+ncrCVodwvZIngU3pMyrk27ZvGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845689; c=relaxed/simple;
	bh=E56yXudRMn4CnBQsOnMzIwpbSLLijU+XGcqTLunaYcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5nfa8+fUvNC8SfPnUoTgV2KMqwvtx9lLF/HJ7uqA+/i843AQ1QPaOKIFpuiglbkXz2Gb1LDfXTZCdqOuZXSBOY1PBdZpFOuaSNz4HAayYu0NdFd5i1fBjVTcQ2c15NpJCgdGiGe5WqbhsPAPvlyyaZhy6Onzbt/W/3WNEXnbEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FCAD16F3;
	Mon, 24 Mar 2025 12:48:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B31D3F694;
	Mon, 24 Mar 2025 12:48:04 -0700 (PDT)
Date: Mon, 24 Mar 2025 19:47:58 +0000
From: Leo Yan <leo.yan@arm.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: mingo@kernel.org, peterz@infradead.org, acme@kernel.org,
	namhyung@kernel.org, Mark.Rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, james.clark@linaro.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] events/core: fix acoount failure for event's
 child_total_enable_time at task exit
Message-ID: <20250324194758.GB604566@e132581.arm.com>
References: <20250306123350.1650114-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306123350.1650114-1-yeoreum.yun@arm.com>

Hi Levi,

I tested this patch and it works for me.

I would suggestion to improve a bit commit log for easier understanding.
And a minor comment for the code, otherwise, LGTM.

On Thu, Mar 06, 2025 at 12:33:50PM +0000, Yeoreum Yun wrote:
> The perf core code fails to account for total_enable_time of event
> when its state is inactive.
> 
> Here is the error case for failure to account for total_enable_time for
> core event:

Here is a failure case for accouting total_enable_time for CPU PMU
events:

> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 2s
> ...
> 
> /*
>  * three number represetns each
>  *   scaled count / total_enable_time / total_total_running_time
>  */
> armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
>                                       ^^^^^^^^^^
> armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
>                                       ^^^^^^^^^^

You could use below syntax like:

  armv8_pmuv3_0/event=0x08/: 1138698008 2289429840 2174835740
  armv8_pmuv3_1/event=0x08/: 1826791390 1950025700 847648440
                              `          `          `> child_total_time_running
                               `          `> child_total_time_enabled
                                `> child_count
> 
>  Performance counter stats for 'stress-ng --pthread=2 -t 2s':
> 
>      1,138,698,008      armv8_pmuv3_0/event=0x08/                                               (94.99%)
>      1,826,791,390      armv8_pmuv3_1/event=0x08/                                               (43.47%)
> 
> Since above two events are belong to the same task context and
> mutually-exclusive per cpu (they couldn't be active at the same time on the same cpu),
> the total_enable_time should be the same (marked with ^^^^^^^^^^^)
> and the summation of ratio should be 100%.

The two events above are opened on two different CPU PMUs, for example,
each event is opened for a cluster in an Arm big.LITTLE system, they
will never run on the same CPU.  In theory, the total enabled time should
be same for both events, as two events are opened and closed together.

> This account failure of total_enable_time because of
> account failure of child_total_enable_time of child event when
> child task exit.

As the result show, the two events' child total enabled time are
different (2289429840 vs 1950025700).  This is because child events
are not accounted properly if a event is INACTIVE state when the
task exits.

> Below table explains how the child_total_enable_time is failed to account at
> exiting child task which switch cpus as time passes by (CPU0 -> CPU1 -> CPU0)
> 
>  - in means sched_in.
>  - out means sched_out.
>  - exit means at the exit of child task.
>    NOTE: the value is before calling list_del_event(). which mean
>          the value at exit column will be added at parent event's
>           child_total_enable_time when child task exit.
>  - ctx is the child_task_ctx,
>  - e0 is the child_event which set with cpu == -1 and opened with pmu0 only
>    added in CPU0,
>  - e1 is the child_event which set with cpu == -1 and opened with pmu1 only
>    added in CPU1,
>  - e0 and e1 belongs to same child_task_ctx.
> 
>           CPU0 (run t1)        CPU1 (run t2)          CPU0 (run t3)
>           |  in | out |       | in  | out     |       | in      | exit        |
> ------------------------------------------------------------------------------
> ctx->time |  0  | t1  |       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2 + t3|
> ------------------------------------------------------------------------------
> e0->ena   |  0  | t1  |       | t1  | t1     *|       | t1 + t2 | t1 + t2 + t3|
> ------------------------------------------------------------------------------
> e0->run   |  0  | t1  |       | t1  | t1     *|       | t1      | t1 + t3     |
> ------------------------------------------------------------------------------
> e1->ena   |  0  | 0  *|       | t1  | t1 + t2 |       | t1 + t2 | t1 + t2    X|
> ------------------------------------------------------------------------------
> e1->run   |  0  | 0  *|       | 0   | t2      |       | t2      | t2         X|
> ------------------------------------------------------------------------------
> 
> The value marked with * means it doesn't updates since event->state was
> INACTIVE.
> 
> Please see the last CPU0's column with exit (marked with X).
> Since e1's state is INACTIVE its total_enable_time doesn't update
> and it remains with former value without accounting t3 time.
> 
> In this situation, at __perf_remove_from_context() while exit child_task,
> sync_child_event() where adds child_event's total_enable_time to
> parent event's child_total_enable_time in perf_child_detach() is called
> before list_del_event() in which event time is updated by setting
> the event state as OFF.

In this case, the call sequence is:

  perf_event_exit_event()
    `> perf_remove_from_context()
         `> __perf_remove_from_context()
              `> perf_child_detach()   -> Accumulate child_total_time_enabled
              `> list_del_event()      -> Update child event's time

The problem is the time accumulation happens prior to child event's time
updating.  Thus, it misses to account the last period's time when event
exits.

> That means child_total_enable_time is added with missing
> amount of last enable time -- t3.
> 
> In case of parent event's total_enable_time is updated properly in
> list_del_event() when the task exit.
> However, the child_total_enable_time is missed when child_task exited,
> the perf prints error amount of enable_time (which is summation of
> total_enable_time + child_total_enable_time).
> 
> To address this, update event state via perf_event_state() in
> __perf_remove_from_context() and call it before perf_child_detach()
> where parent's total_enable_time is updated.
> 

The perf core layer follows the rule that timekeeping is tied to state
change.  To address the issue, invokes perf_event_state() for updating
state alongside with accouting the time.  Then, perf_child_detach()
populates the time into parent's time metrics.

> After this patch, this problem is gone like:
> 
> sudo ./perf stat -vvv -e armv8_pmuv3_0/event=0x08/ -e armv8_pmuv3_1/event=0x08/ -- stress-ng --pthread=2 -t 10s
> ...
> armv8_pmuv3_0/event=0x08/: 15396770398 32157963940 21898169000
> armv8_pmuv3_1/event=0x08/: 22428964974 32157963940 10259794940
> 
>  Performance counter stats for 'stress-ng --pthread=2 -t 10s':
> 
>     15,396,770,398      armv8_pmuv3_0/event=0x08/                                               (68.10%)
>     22,428,964,974      armv8_pmuv3_1/event=0x08/                                               (31.90%)
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Suggsted-by: Peter Zijlstra <peterz@infradead.org>

/Suggsted-by/Suggested-by/

> ---
>  kernel/events/core.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 6364319e2f88..058533a50493 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2407,6 +2407,7 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
>  #define DETACH_GROUP	0x01UL
>  #define DETACH_CHILD	0x02UL
>  #define DETACH_DEAD	0x04UL
> +#define DETACH_EXIT	0x08UL
> 
>  /*
>   * Cross CPU call to remove a performance event
> @@ -2421,6 +2422,7 @@ __perf_remove_from_context(struct perf_event *event,
>  			   void *info)
>  {
>  	struct perf_event_pmu_context *pmu_ctx = event->pmu_ctx;
> +	enum perf_event_state state = PERF_EVENT_STATE_OFF;
>  	unsigned long flags = (unsigned long)info;
> 
>  	ctx_time_update(cpuctx, ctx);
> @@ -2429,16 +2431,19 @@ __perf_remove_from_context(struct perf_event *event,
>  	 * Ensure event_sched_out() switches to OFF, at the very least
>  	 * this avoids raising perf_pending_task() at this time.
>  	 */
> -	if (flags & DETACH_DEAD)
> +	if (flags & DETACH_EXIT)
> +		state = PERF_EVENT_STATE_EXIT;
> +	if (flags & DETACH_DEAD) {
>  		event->pending_disable = 1;
> +		state = PERF_EVENT_STATE_DEAD;
> +	}
>  	event_sched_out(event, ctx);
> +	perf_event_set_state(event, min(event->state, state));

Nitpick: can we move perf_event_set_state() before event_sched_out()?

So the function handles the state machine ahead, then proceed for
other operations.

Thanks,
Leo

>  	if (flags & DETACH_GROUP)
>  		perf_group_detach(event);
>  	if (flags & DETACH_CHILD)
>  		perf_child_detach(event);
>  	list_del_event(event, ctx);
> -	if (flags & DETACH_DEAD)
> -		event->state = PERF_EVENT_STATE_DEAD;
> 
>  	if (!pmu_ctx->nr_events) {
>  		pmu_ctx->rotate_necessary = 0;
> @@ -13424,12 +13429,7 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
>  		mutex_lock(&parent_event->child_mutex);
>  	}
> 
> -	perf_remove_from_context(event, detach_flags);
> -
> -	raw_spin_lock_irq(&ctx->lock);
> -	if (event->state > PERF_EVENT_STATE_EXIT)
> -		perf_event_set_state(event, PERF_EVENT_STATE_EXIT);
> -	raw_spin_unlock_irq(&ctx->lock);
> +	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
> 
>  	/*
>  	 * Child events can be freed.
> --
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 
