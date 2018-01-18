From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH] perf/core: Fix installing cgroup event into cpu
Date: Thu, 18 Jan 2018 09:57:40 +0800
Message-ID: <CALPjY3k3NQv0_VtgcOR86kchDxMQuJoWMDuzzw7QTQbQ5c8-1g@mail.gmail.com>
References: <20180111030958.8627-1-linxiulei@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:40322 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752965AbeARB5l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 17 Jan 2018 20:57:41 -0500
In-Reply-To: <20180111030958.8627-1-linxiulei@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>

Hi Peter

Could you please have a look of this

thanks

2018-01-11 11:09 GMT+08:00  <linxiulei@gmail.com>:
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
>         struct perf_event_context *ctx = event->ctx;
>         struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
>         struct perf_event_context *task_ctx = cpuctx->task_ctx;
> +       struct perf_cgroup *cgrp;
>         bool reprogram = true;
>         int ret = 0;
>
> @@ -2311,6 +2312,19 @@ static int  __perf_install_in_context(void *info)
>                 raw_spin_lock(&task_ctx->lock);
>         }
>
> +       if (event->cgrp) {
> +               /*
> +                * Only care about cgroup events.
> +                *
> +                * If only the task belongs to cgroup of this event,
> +                * we will continue the installment
> +                */
> +               cgrp = perf_cgroup_from_task(current, ctx);
> +               if (!cgroup_is_descendant(cgrp->css.cgroup,
> +                                       event->cgrp->css.cgroup))
> +                       goto unlock;
> +       }
> +
>         if (reprogram) {
>                 ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>                 add_event_to_ctx(event, ctx);
> --
> 2.8.4.31.g9ed660f
>
