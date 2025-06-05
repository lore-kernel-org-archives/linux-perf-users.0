Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E841DFF8;
	Thu,  5 Jun 2025 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144094; cv=none; b=Kyf+JIBjse1wuPelIgBK7hFiou29JyB/ObB8bDHrNpYvGo5uU1qee+qMil5U9DON01WVXtJQkKZc5o6f8pbkIgABCZZOPDhLxbO22iOPL40lED6UFXT+iGnA6/kTmp+zIdiqw8/+HvupmyguwhqeAHStvWE1caHrQemXutcD1+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144094; c=relaxed/simple;
	bh=GTyfTFDpQ/QXc5ClJokHVK49buVYWxHthMCjuGsSSuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/Qg5XdrqlXEUyptRlz3nQVoyfXoHZFCGi+0YpAG/pVO8ZjlRD/fYnD34Zxw0vKziYfl7OVKjRZVlEcUkOzXgiDAyqukFGT+m/wcGm4FNl6cqRpqu1y4bfQhlyu/tql4tyCl+Tq0FVHWFBmdROtq4HfqtMjxJf80r68vBBuFSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5671F12FC;
	Thu,  5 Jun 2025 10:21:13 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 76A7F3F5A1;
	Thu,  5 Jun 2025 10:21:30 -0700 (PDT)
Date: Thu, 5 Jun 2025 18:21:26 +0100
From: Leo Yan <leo.yan@arm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, mingo@redhat.com, mingo@kernel.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Wang <00107082@163.com>
Subject: Re: [PATCH 1/1] perf/core: fix dangling cgroup pointer in cpuctx
Message-ID: <20250605172126.GG8020@e132581.arm.com>
References: <20250602184049.4010919-1-yeoreum.yun@arm.com>
 <20250603140040.GB8020@e132581.arm.com>
 <20250603144414.GC38114@noisy.programming.kicks-ass.net>
 <20250604080339.GB35970@noisy.programming.kicks-ass.net>
 <20250604101821.GC8020@e132581.arm.com>
 <20250604141640.GL38114@noisy.programming.kicks-ass.net>
 <20250604154639.GE8020@e132581.arm.com>
 <20250605112921.GR39944@noisy.programming.kicks-ass.net>
 <20250605123343.GD35970@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250605123343.GD35970@noisy.programming.kicks-ass.net>

On Thu, Jun 05, 2025 at 02:33:43PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 05, 2025 at 01:29:21PM +0200, Peter Zijlstra wrote:
> 
> > But yes, slightly confusing. Let me see if I can make a less confusing
> > patch, and if not, sprinkle comments.
> 
> I've settled on the below.
> 
> ---
> Subject: perf: Fix cgroup state vs ERROR
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Thu Jun 5 12:37:11 CEST 2025
> 
> While chasing down a missing perf_cgroup_event_disable() elsewhere,
> Leo Yan found that both perf_put_aux_event() and
> perf_remove_sibling_event() were also missing one.
> 
> Specifically, the rule is that events that switch to OFF,ERROR need to
> call perf_cgroup_event_disable().
> 
> Unify the disable paths to ensure this.
> 
> Fixes: ab43762ef010 ("perf: Allow normal events to output AUX data")
> Fixes: 9f0c4fa111dc ("perf/core: Add a new PERF_EV_CAP_SIBLING event capability")
> Reported-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |   51 ++++++++++++++++++++++++++++++---------------------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2149,8 +2149,9 @@ perf_aux_output_match(struct perf_event
>  }
>  
>  static void put_event(struct perf_event *event);
> -static void event_sched_out(struct perf_event *event,
> -			    struct perf_event_context *ctx);
> +static void __event_disable(struct perf_event *event,
> +			    struct perf_event_context *ctx,
> +			    enum perf_event_state state);
>  
>  static void perf_put_aux_event(struct perf_event *event)
>  {
> @@ -2183,8 +2184,7 @@ static void perf_put_aux_event(struct pe
>  		 * state so that we don't try to schedule it again. Note
>  		 * that perf_event_enable() will clear the ERROR status.
>  		 */
> -		event_sched_out(iter, ctx);
> -		perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> +		__event_disable(iter, ctx, PERF_EVENT_STATE_ERROR);
>  	}
>  }
>  
> @@ -2242,18 +2242,6 @@ static inline struct list_head *get_even
>  				    &event->pmu_ctx->flexible_active;
>  }
>  
> -/*
> - * Events that have PERF_EV_CAP_SIBLING require being part of a group and
> - * cannot exist on their own, schedule them out and move them into the ERROR
> - * state. Also see _perf_event_enable(), it will not be able to recover
> - * this ERROR state.
> - */
> -static inline void perf_remove_sibling_event(struct perf_event *event)
> -{
> -	event_sched_out(event, event->ctx);
> -	perf_event_set_state(event, PERF_EVENT_STATE_ERROR);
> -}
> -
>  static void perf_group_detach(struct perf_event *event)
>  {
>  	struct perf_event *leader = event->group_leader;
> @@ -2289,8 +2277,15 @@ static void perf_group_detach(struct per
>  	 */
>  	list_for_each_entry_safe(sibling, tmp, &event->sibling_list, sibling_list) {
>  
> +		/*
> +		 * Events that have PERF_EV_CAP_SIBLING require being part of
> +		 * a group and cannot exist on their own, schedule them out
> +		 * and move them into the ERROR state. Also see
> +		 * _perf_event_enable(), it will not be able to recover this
> +		 * ERROR state.
> +		 */
>  		if (sibling->event_caps & PERF_EV_CAP_SIBLING)
> -			perf_remove_sibling_event(sibling);
> +			__event_disable(sibling, ctx, PERF_EVENT_STATE_ERROR);
>  
>  		sibling->group_leader = sibling;
>  		list_del_init(&sibling->sibling_list);
> @@ -2562,6 +2557,15 @@ static void perf_remove_from_context(str
>  	event_function_call(event, __perf_remove_from_context, (void *)flags);
>  }
>  
> +static void __event_disable(struct perf_event *event,
> +			    struct perf_event_context *ctx,
> +			    enum perf_event_state state)
> +{
> +	event_sched_out(event, ctx);
> +	perf_cgroup_event_disable(event, ctx);
> +	perf_event_set_state(event, state);
> +}
> +
>  /*
>   * Cross CPU call to disable a performance event
>   */
> @@ -2576,13 +2580,18 @@ static void __perf_event_disable(struct
>  	perf_pmu_disable(event->pmu_ctx->pmu);
>  	ctx_time_update_event(ctx, event);
>  
> +	/*
> +	 * When disabling a group leader, the whole group becomes ineligible
> +	 * to run, so schedule out the full group.
> +	 */
>  	if (event == event->group_leader)
>  		group_sched_out(event, ctx);
> -	else
> -		event_sched_out(event, ctx);
>  
> -	perf_event_set_state(event, PERF_EVENT_STATE_OFF);
> -	perf_cgroup_event_disable(event, ctx);
> +	/*
> +	 * But only mark the leader OFF; the siblings will remain
> +	 * INACTIVE.
> +	 */
> +	__event_disable(event, ctx, PERF_EVENT_STATE_OFF);

Here, a group lead will invoke event_sched_out() twice: one is in
group_sched_out() (above) andin __event_disable(). This would be fine,
as the second call to event_sched_out() will directly bail out due to
the following condition:

  if (event->state != PERF_EVENT_STATE_ACTIVE)
      return;

I think you have already noticed this minor redundancy.

Reviewed-by: Leo Yan <leo.yan@arm.com>

And thanks for the explaination in your another reply, it makes sense to
me.

Leo

>  	perf_pmu_enable(event->pmu_ctx->pmu);
>  }
