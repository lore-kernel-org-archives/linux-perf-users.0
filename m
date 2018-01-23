From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RESEND] perf/core: Fix installing cgroup event into cpu
Date: Tue, 23 Jan 2018 17:37:37 +0100
Message-ID: <20180123163737.GJ2269@hirez.programming.kicks-ass.net>
References: <20180123041306.15431-1-linxiulei@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:47062 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751254AbeAWQhx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 11:37:53 -0500
Content-Disposition: inline
In-Reply-To: <20180123041306.15431-1-linxiulei@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linxiulei@gmail.com
Cc: jolsa@redhat.com, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, brendan.d.gregg@gmail.com, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

On Tue, Jan 23, 2018 at 12:13:06PM +0800, linxiulei@gmail.com wrote:
> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
> 
> Do not install cgroup event into the CPU context if the cgroup
> is not running on this CPU
> 
> While there is no task of cgroup running specified CPU, current
> kernel still install cgroup event into CPU context, that causes
> another cgroup event can't be installed into this CPU.
> 
> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
> ---
>  kernel/events/core.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 4df5b69..19c587b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2284,6 +2284,7 @@ static int  __perf_install_in_context(void *info)
>  	struct perf_event_context *ctx = event->ctx;
>  	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
>  	struct perf_event_context *task_ctx = cpuctx->task_ctx;
> +	struct perf_cgroup *cgrp;
>  	bool reprogram = true;
>  	int ret = 0;
>  
> @@ -2311,6 +2312,19 @@ static int  __perf_install_in_context(void *info)
>  		raw_spin_lock(&task_ctx->lock);
>  	}
>  
> +	if (event->cgrp) {
> +		/*
> +		 * Only care about cgroup events.
> +		 *
> +		 * If only the task belongs to cgroup of this event,
> +		 * we will continue the installment
> +		 */
> +		cgrp = perf_cgroup_from_task(current, ctx);
> +		if (!cgroup_is_descendant(cgrp->css.cgroup,
> +					event->cgrp->css.cgroup))
> +			goto unlock;
> +	}
> +
>  	if (reprogram) {
>  		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>  		add_event_to_ctx(event, ctx);

I think this is wrong. You're right in that we need not schedule it not,
but the above also completely fails to add it to the context, leading to
it never being scheduled ever.

At the very least we should do add_event_to_ctx() on it.

So the only thing you can do is pick 'reprogram' or not based on if the
current cgrp is related to the event->ctx.
