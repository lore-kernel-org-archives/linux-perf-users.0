From: Lin Xiulei <linxiulei@gmail.com>
Subject: Re: [PATCH v2] perf/core: Fix installing cgroup event into cpu
Date: Wed, 24 Jan 2018 17:19:34 +0800
Message-ID: <CALPjY3mZYSs-8Bg0U0kq=jPz+TX8RxfpvBeVs6oxspfwLjOjfA@mail.gmail.com>
References: <20180124075010.83296-1-linxiulei@gmail.com> <20180124082036.GL2228@hirez.programming.kicks-ass.net>
 <CALPjY3mj7--oAmObtECYDw5GaJ3wLroBVrQ5eQztqmYMCm=8Cw@mail.gmail.com> <20180124091456.GN2228@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:35255 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932512AbeAXJTf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 Jan 2018 04:19:35 -0500
In-Reply-To: <20180124091456.GN2228@hirez.programming.kicks-ass.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, Stephane Eranian <eranian@gmail.com>, torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org, Brendan Gregg <brendan.d.gregg@gmail.com>, yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com, "leilei.lin" <leilei.lin@alibaba-inc.com>

2018-01-24 17:14 GMT+08:00 Peter Zijlstra <peterz@infradead.org>:
> On Wed, Jan 24, 2018 at 04:32:38PM +0800, Lin Xiulei wrote:
>> >>  kernel/events/core.c | 44 +++++++++++++++++++++++++++++++-------------
>> >>  1 file changed, 31 insertions(+), 13 deletions(-)
>> >>
>> >> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> >> index 4df5b69..f766b60 100644
>> >> --- a/kernel/events/core.c
>> >> +++ b/kernel/events/core.c
>> >> @@ -933,31 +933,36 @@ list_update_cgroup_event(struct perf_event *event,
>> >>  {
>> >>       struct perf_cpu_context *cpuctx;
>> >>       struct list_head *cpuctx_entry;
>> >> +     struct perf_cgroup *cgrp;
>> >>
>> >>       if (!is_cgroup_event(event))
>> >>               return;
>> >>
>> >>       /*
>> >>        * Because cgroup events are always per-cpu events,
>> >>        * this will always be called from the right CPU.
>> >>        */
>> >>       cpuctx = __get_cpu_context(ctx);
>> >> +     cgrp = perf_cgroup_from_task(current, ctx);
>> >>
>> >> +     /* cpuctx->cgrp is NULL unless a cgroup event is running in this CPU .*/
>> >> +     if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
>> >> +             if (add)
>> >>                       cpuctx->cgrp = cgrp;
>> >> +             else
>> >> +                     cpuctx->cgrp = NULL;
>> >>       }
>> >> +
>> >> +     if (add && ctx->nr_cgroups++)
>> >> +             return;
>> >> +     else if (!add && --ctx->nr_cgroups)
>> >> +             return;
>> >> +
>> >> +     cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
>> >> +     if (add)
>> >> +             list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
>> >> +     else
>> >> +             list_del(cpuctx_entry);
>> >>  }
>> >
>> > I'm a little confused; you unconditionally set cpuctx->cgrp for every
>> > add/delete.
>> >
>> > So if we have >1 cgroup events on, and we remove one, you still clear
>> > cpuctx->cgrp, that seems wrong.
>> >
>> > Why did you change that? The Changelog doesn't include enough clues for
>> > me to know what you were trying to do.
>>
>> if we have > 1 cgroup events on, whenever a cgroup was really to be
>> deleted, only if this cgroup is the same as the cgroup running on this
>> cpu, I would clear cpuctx->cgrp.
>
> But that might still be too early, we might still have more cgroup
> events active.
>
> What goes wrong if we leave it set?
>
>> Here is the problem, previous version didn't set cpuctx->cgrp anymore
>> if ctx->nr_cgroups > 1, which cases a second event would not be
>> activated immediately because cpuctx->cgrp isn't equal to event->cgrp
>> at event_filter_match()
>
> OK, I think I can see that happening. Please clarify the Changelog and
> maybe put a comment in the code as well.

Sure, and I consider this "OK" works for "What goes wrong if we leave
it set?". : )
