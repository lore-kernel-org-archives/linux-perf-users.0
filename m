From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH RESEND v4] perf/core: Fix installing cgroup event into cpu
Date: Sat, 10 Feb 2018 20:28:00 +0800
Message-ID: <CALPjY3mtVfWOqGRZ6gnrJ76wQmgtHfH2TXfKMDFfAQqwDLU0LA@mail.gmail.com>
References: <20180208033344.71933-1-linxiulei@gmail.com> <20180209101128.GF25181@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:39793 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeBJM2C (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 10 Feb 2018 07:28:02 -0500
In-Reply-To: <20180209101128.GF25181@hirez.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, Brendan Gregg <brendan.d.gregg@gmail.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

2018-02-09 18:11 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Thu, Feb 08, 2018 at 11:33:44AM +0800, linxiulei@gmail.com wrote:
>> From: "leilei.lin" <leilei.lin@alibaba-inc.com>
>>
>> Do not install cgroup event into the CPU context and schedule it
>> if the cgroup is not running on this CPU
>>
>> While there is no task of cgroup running specified CPU, current
>> kernel still install cgroup event into CPU context that causes
>> another cgroup event can't be installed into this CPU.
>>
>> This patch prevent scheduling events at __perf_install_in_context()
>> and installing events at list_update_cgroup_event() if cgroup isn't
>> running on specified CPU.
>>
>> Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
>> ---
>>  v2: Set cpuctx->cgrp only if the same cgroup is running on this
>>    CPU otherwise following events couldn't be activated immediately
>>  v3: Enhance the comments and commit message
>>  v4: Adjust to config
>>
>>  kernel/events/core.c | 50 +++++++++++++++++++++++++++++++++++++-------------
>>  1 file changed, 37 insertions(+), 13 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4df5b69..fd28d61 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -933,31 +933,41 @@ list_update_cgroup_event(struct perf_event *event,
>>  {
>>       struct perf_cpu_context *cpuctx;
>>       struct list_head *cpuctx_entry;
>> +     struct perf_cgroup *cgrp;
>>
>>       if (!is_cgroup_event(event))
>>               return;
>>
>>       /*
>>        * Because cgroup events are always per-cpu events,
>>        * this will always be called from the right CPU.
>>        */
>>       cpuctx = __get_cpu_context(ctx);
>> +     cgrp = perf_cgroup_from_task(current, ctx);
>>
>> +     /*
>> +      * if only the cgroup is running on this cpu,
>> +      * we put/remove this cgroup into cpu context.
>> +      * Or it would case mismatch in following cgroup
>> +      * events at event_filter_match()
>> +      */
>> +     if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
>> +             if (add)
>>                       cpuctx->cgrp = cgrp;
>> +             else
>> +                     cpuctx->cgrp = NULL;
>>       }
>
> I am still not convinced this is correct.
>
> Suppose we have
>
>    R
>   / \
>  A   B
>     / \
>    C
>
> And our current task is of B, and B has an event.
>
> We then install an event in C, if we then destroy our event in C, it
> would clear cpuctx->cgrp, which is wrong, since there is still an event
> in B.
>
> Simpler still, if B were to have 2 events, and we'd remove one, that
> would still clear cpuctx->cgrp, even though there is an event left.
>
> This is the exact issue I pointed out last time, and I still don't see
> how it would now be correct.
>
> Northing explains why its ok to have NULL cpuctx->cgrp when there are in
> fact still cgroup events on the CPU.

I got your point now, sorry for misunderstanding it last time. I wanna
confirm it
that logic in __add__ is correct and I'd like to make a slight improvement

```
/* We only have to care about the first time of initiating cpuctx->cgrp,
 * which is when cpuctx->cgrp == NULL, otherwise cpuctx->cgrp was set
 * in perf_cgroup_switch() correctly.
 */
if (add && !cpuctx->cgrp &&
     cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
    cpuctx->cgrp = cgrp;
```

And logic in __del__ should be rolled back to previous code that once
ctx->nr_cgroups == 0, set cpuctx->cgrp to NULL.

thanks
