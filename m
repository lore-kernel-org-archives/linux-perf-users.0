Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C726212E7E;
	Mon,  9 Jun 2025 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749472467; cv=none; b=oUroPPE9BHsE27VrBlHwWyvmpXUqTjto14/XWNxvaPZNxTppgjmbxKxLxqa3NCQrlEbrMa+BN8mZ+s5aDBgzl+1YKVzm6+2kGhi0sPHOMZGo1JdEdZZWI0jl59lvUPumdeMGu89hi4vdEwdbZ1jqB861O0mGIg32HMQ9BmG7wz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749472467; c=relaxed/simple;
	bh=HDFpx8Cc3xPi5mnpLaZZU6nEkfCGbZwZD/KbTCBU2dE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmhpYoHBtyOFOQX+nnqg0Yd1hiBU/x9xcl9DUHRetiZ2BTxcqrp9o7p39XKrPdGpAqo72QcYRPqe4V/Cgn2WCknFjfV8Tje8E680xGY/t4aIcstVQvqihJL8hXK0mpMqfpy12cok93QOX4hXYhTymOk7Vg8ShVE/b48mNiwv77c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5D21150C;
	Mon,  9 Jun 2025 05:34:04 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B7443F673;
	Mon,  9 Jun 2025 05:34:23 -0700 (PDT)
Date: Mon, 9 Jun 2025 13:34:15 +0100
From: Leo Yan <leo.yan@arm.com>
To: kan.liang@linux.intel.com
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org,
	irogers@google.com, mark.rutland@arm.com,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	eranian@google.com, ctshao@google.com, tmricht@linux.ibm.com,
	Aishwarya TCV <aishwarya.tcv@arm.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: [PATCH V4] perf: Fix the throttle error of some clock events
Message-ID: <20250609123415.GJ8020@e132581.arm.com>
References: <20250606192546.915765-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606192546.915765-1-kan.liang@linux.intel.com>

Hi Kan,

On Fri, Jun 06, 2025 at 12:25:46PM -0700, kan.liang@linux.intel.com wrote:

[...]

> There may be two ways to fix it.
> - Introduce a PMU flag to track the case. Avoid the event_stop in
>   perf_event_throttle() if the flag is detected.
>   It has been implemented in the
>   https://lore.kernel.org/lkml/20250528175832.2999139-1-kan.liang@linux.intel.com/
>   The new flag was thought to be an overkill for the issue.
> - Add a check in the event_stop. Return immediately if the throttle is
>   invoked in the hrtimer handler. Rely on the existing HRTIMER_NORESTART
>   method to stop the timer.
> 
> The latter is implemented here.
> 
> Move event->hw.interrupts = MAX_INTERRUPTS before the stop(). It makes
> the order the same as perf_event_unthrottle(). Except the patch, no one
> checks the hw.interrupts in the stop(). There is no impact from the
> order change.
> 
> When stops in the throttle, the event should not be updated,
> stop(event, 0).

I am confused for this conclusion. When a CPU or task clock event is
stopped by throttling, should it also be updated? Otherwise, we will
lose accouting for the period prior to the throttling.

I saw you exchanged with Alexei for a soft lockup issue, the reply [1]
shows that skipping event update on throttling does not help to
resolve the lockup issue.

Could you elaberate why we don't need to update clock events when
throttling?

Thanks,
Leo

[1] https://lore.kernel.org/linux-perf-users/CAADnVQKRJKsG08KkEriuBQop0LgDr+c9rkNE6MUh_n3rzZoXVQ@mail.gmail.com/

> But the cpu_clock_event_stop() doesn't handle the flag.
> In logic, it's wrong. But it didn't bring any problems with the old
> code, because the stop() was not invoked when handling the throttle.
> Checking the flag before updating the event.
> 
> Reported-by: Leo Yan <leo.yan@arm.com>
> Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
> Closes: https://lore.kernel.org/lkml/20250527161656.GJ2566836@e132581.arm.com/
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Closes: https://lore.kernel.org/lkml/djxlh5fx326gcenwrr52ry3pk4wxmugu4jccdjysza7tlc5fef@ktp4rffawgcw/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Closes: https://lore.kernel.org/lkml/8e8f51d8-af64-4d9e-934b-c0ee9f131293@linux.ibm.com/
> Reported-by: Vince Weaver <vincent.weaver@maine.edu>
> Closes: https://lore.kernel.org/lkml/4ce106d0-950c-aadc-0b6a-f0215cd39913@maine.edu/
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
> 
> The patch is to fix the issue introduced by
> 
>   9734e25fbf5a perf: Fix the throttle logic for a group
> 
> It is still in the tip.git, I'm not sure if the commit ID is valid. So
> the Fixes tag is not added.
> 
> There are some discussions regarding to a soft lockup issue.
> That is an existing issue, which are not introduced by the above change.
> It should be fixed separately.
> https://lore.kernel.org/lkml/CAADnVQ+Lx0HWEM8xdLC80wco3BTUPAD_2dQ-3oZFiECZMcw2aQ@mail.gmail.com/
> 
> Changes since V3:
> - Check before update in event_stop()
> - Add Reviewed-by from Ian
> 
>  kernel/events/core.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f34c99f8ce8f..cc77f127e11a 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2656,8 +2656,8 @@ static void perf_event_unthrottle(struct perf_event *event, bool start)
>  
>  static void perf_event_throttle(struct perf_event *event)
>  {
> -	event->pmu->stop(event, 0);
>  	event->hw.interrupts = MAX_INTERRUPTS;
> +	event->pmu->stop(event, 0);
>  	if (event == event->group_leader)
>  		perf_log_throttle(event, 0);
>  }
> @@ -11749,7 +11749,12 @@ static void perf_swevent_cancel_hrtimer(struct perf_event *event)
>  {
>  	struct hw_perf_event *hwc = &event->hw;
>  
> -	if (is_sampling_event(event)) {
> +	/*
> +	 * The throttle can be triggered in the hrtimer handler.
> +	 * The HRTIMER_NORESTART should be used to stop the timer,
> +	 * rather than hrtimer_cancel(). See perf_swevent_hrtimer()
> +	 */
> +	if (is_sampling_event(event) && (hwc->interrupts != MAX_INTERRUPTS)) {
>  		ktime_t remaining = hrtimer_get_remaining(&hwc->hrtimer);
>  		local64_set(&hwc->period_left, ktime_to_ns(remaining));
>  
> @@ -11804,7 +11809,8 @@ static void cpu_clock_event_start(struct perf_event *event, int flags)
>  static void cpu_clock_event_stop(struct perf_event *event, int flags)
>  {
>  	perf_swevent_cancel_hrtimer(event);
> -	cpu_clock_event_update(event);
> +	if (flags & PERF_EF_UPDATE)
> +		cpu_clock_event_update(event);
>  }
>  
>  static int cpu_clock_event_add(struct perf_event *event, int flags)
> @@ -11882,7 +11888,8 @@ static void task_clock_event_start(struct perf_event *event, int flags)
>  static void task_clock_event_stop(struct perf_event *event, int flags)
>  {
>  	perf_swevent_cancel_hrtimer(event);
> -	task_clock_event_update(event, event->ctx->time);
> +	if (flags & PERF_EF_UPDATE)
> +		task_clock_event_update(event, event->ctx->time);
>  }
>  
>  static int task_clock_event_add(struct perf_event *event, int flags)
> -- 
> 2.38.1
> 
