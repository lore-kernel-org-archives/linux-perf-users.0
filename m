From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH RESEND] perf/core: Fix installing cgroup event into cpu
Date: Wed, 24 Jan 2018 15:29:34 +0800
Message-ID: <CALPjY3npyVm50EpD_b_YMnj7gvFxx3SKyf5NV7t7HUBtFrgWWw@mail.gmail.com>
References: <20180123041306.15431-1-linxiulei@gmail.com> <20180123163737.GJ2269@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36680 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932192AbeAXH3f (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Jan 2018 02:29:35 -0500
In-Reply-To: <20180123163737.GJ2269@hirez.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

yes, you are right. In my cases, there also are some issues in
add_event_to_ctx(),
I am gonna fix it at v2

Thanks

2018-01-24 0:37 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Tue, Jan 23, 2018 at 12:13:06PM +0800, linxiulei@gmail.com wrote:
>> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
>>
>> Do not install cgroup event into the CPU context if the cgroup
>> is not running on this CPU
>>
>> While there is no task of cgroup running specified CPU, current
>> kernel still install cgroup event into CPU context, that causes
>> another cgroup event can't be installed into this CPU.
>>
>> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
>> ---
>>  kernel/events/core.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4df5b69..19c587b 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -2284,6 +2284,7 @@ static int  __perf_install_in_context(void *info)
>>       struct perf_event_context *ctx = event->ctx;
>>       struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
>>       struct perf_event_context *task_ctx = cpuctx->task_ctx;
>> +     struct perf_cgroup *cgrp;
>>       bool reprogram = true;
>>       int ret = 0;
>>
>> @@ -2311,6 +2312,19 @@ static int  __perf_install_in_context(void *info)
>>               raw_spin_lock(&task_ctx->lock);
>>       }
>>
>> +     if (event->cgrp) {
>> +             /*
>> +              * Only care about cgroup events.
>> +              *
>> +              * If only the task belongs to cgroup of this event,
>> +              * we will continue the installment
>> +              */
>> +             cgrp = perf_cgroup_from_task(current, ctx);
>> +             if (!cgroup_is_descendant(cgrp->css.cgroup,
>> +                                     event->cgrp->css.cgroup))
>> +                     goto unlock;
>> +     }
>> +
>>       if (reprogram) {
>>               ctx_sched_out(ctx, cpuctx, EVENT_TIME);
>>               add_event_to_ctx(event, ctx);
>
> I think this is wrong. You're right in that we need not schedule it not,
> but the above also completely fails to add it to the context, leading to
> it never being scheduled ever.
>
> At the very least we should do add_event_to_ctx() on it.
>
> So the only thing you can do is pick 'reprogram' or not based on if the
> current cgrp is related to the event->ctx.
