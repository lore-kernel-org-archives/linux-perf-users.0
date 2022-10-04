Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BA7C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Oct 2022 17:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiJDRfc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Oct 2022 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJDRel (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Oct 2022 13:34:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA766716A
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Oct 2022 10:34:32 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-358bf076f1fso72902367b3.9
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Oct 2022 10:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=uB+xgYQO/9hSmh+whT13wcnQWr/VgecN0kcqIDAF7KU=;
        b=Ymg9ZZ0rCYV004hey+X5aunoJoXTYWqOvGNKWxWo5DRhFGqJUg9aUXCzdJG7oM0nK5
         x1flcyWuH7k1XXAK97h8X2z/zA95xE8LK1zwD8b1gdQhEWAiyuPUBVhi6gISkcpgb0IZ
         E+b3Bs8+19zioI4NXvSzRdEQvSVuBRuWGVbNr7X/Vt9tRwrp65pPvrK2FSrfXX57I6qA
         s0a8NVaBewxbts/ybeZK11cjIDivdxB18zAQPXNX7mCeUqYnSGqNO8t5XZYTAaiMc/J/
         BKrbs2rnkUvi9KGIzxgl9UpM6IqsLz9EGhuxtCx5wMIoqr0txEY0tqMaFlmloS9hBuGe
         dsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=uB+xgYQO/9hSmh+whT13wcnQWr/VgecN0kcqIDAF7KU=;
        b=3aPDq3yCylNqrY+9EJ6GG0YRrwtcuc5LJHA+Xe+oeotwLuIwIqLYWQJK3f3tRTrETF
         0nPr7xPs5c5uz34ecLmL4AJkgKSx3+By+eomWRi3JigQKb+UZsclDf6zgSRo3uUPJKxE
         1ZGTpXroQurx/GUB4/7jgEb+dUCpQjpe9VOA+3gbcFw1SbHtOTxOuEo9Lg34vm4V3GeY
         Dhjia/K3F7wgHZuivA3OfntGIg77SxxXZHXfBBTKo0hJ+bgEWbUB1B4pH29Z1O0L1ElX
         EFiDss+DfvYGqJdWX2+CAl8aglDok4iwZ5PHn6P+5YATaXvANLyzBqb6rshlGlP2WBg4
         dCXA==
X-Gm-Message-State: ACrzQf3sSyX07a9pycJXPR3EP0QTo9EzD0YLIQWGDNSgARtGY0VOe40g
        0pkAp61s6nLMBZbtjHM/qImKejyRaEG41m5DQM28sQ==
X-Google-Smtp-Source: AMsMyM5cQoPLva6xEYl1WBGOv5wxv8efRmpjaJLhMkW737wvZJYkDmrHkr+gKzfeU4pE55muGoMdbmSytcAvqax2XNg=
X-Received: by 2002:a81:6dc5:0:b0:358:6a18:b73d with SMTP id
 i188-20020a816dc5000000b003586a18b73dmr14847990ywc.267.1664904871847; Tue, 04
 Oct 2022 10:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220927121322.1236730-1-elver@google.com> <YzM/BUsBnX18NoOG@hirez.programming.kicks-ass.net>
 <YzNu5bgASbuVi0S3@elver.google.com> <YzQcqe9p9C5ZbjZ1@elver.google.com>
 <YzRgcnMXWuUZ4rlt@elver.google.com> <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
In-Reply-To: <Yzxou9HB/1XjMXWI@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 4 Oct 2022 19:33:55 +0200
Message-ID: <CANpmjNPwiL279B5id5dPF821aXYdTUqsfDNAtB4q7jXX+41Qgg@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix missing SIGTRAPs due to pending_disable abuse
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, 4 Oct 2022 at 19:09, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Sep 28, 2022 at 04:55:46PM +0200, Marco Elver wrote:
> > On Wed, Sep 28, 2022 at 12:06PM +0200, Marco Elver wrote:
> >
> > > My second idea about introducing something like irq_work_raw_sync().
> > > Maybe it's not that crazy if it is actually safe. I expect this case
> > > where we need the irq_work_raw_sync() to be very very rare.
> >
> > The previous irq_work_raw_sync() forgot about irq_work_queue_on(). Alas,
> > I might still be missing something obvious, because "it's never that
> > easy". ;-)
> >
> > And for completeness, the full perf patch of what it would look like
> > together with irq_work_raw_sync() (consider it v1.5). It's already
> > survived some shorter stress tests and fuzzing.
>
> So.... I don't like it. But I cooked up the below, which _almost_ works :-/
>
> For some raisin it sometimes fails with 14999 out of 15000 events
> delivered and I've not yet figured out where it goes sideways. I'm
> currently thinking it's that sigtrap clear on OFF.
>
> Still, what do you think of the approach?

It looks reasonable, but obviously needs to pass tests. :-)
Also, see comment below (I think you're still turning signals
asynchronous, which we shouldn't do).

> ---
>  include/linux/perf_event.h |  8 ++--
>  kernel/events/core.c       | 92 +++++++++++++++++++++++++---------------------
>  2 files changed, 55 insertions(+), 45 deletions(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index ee8b9ecdc03b..c54161719d37 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -736,9 +736,11 @@ struct perf_event {
>         struct fasync_struct            *fasync;
>
>         /* delayed work for NMIs and such */
> -       int                             pending_wakeup;
> -       int                             pending_kill;
> -       int                             pending_disable;
> +       unsigned int                    pending_wakeup  :1;
> +       unsigned int                    pending_disable :1;
> +       unsigned int                    pending_sigtrap :1;
> +       unsigned int                    pending_kill    :3;
> +
>         unsigned long                   pending_addr;   /* SIGTRAP */
>         struct irq_work                 pending;
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 2621fd24ad26..8e5dbe971d9e 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2268,11 +2268,15 @@ event_sched_out(struct perf_event *event,
>         event->pmu->del(event, 0);
>         event->oncpu = -1;
>
> -       if (READ_ONCE(event->pending_disable) >= 0) {
> -               WRITE_ONCE(event->pending_disable, -1);
> +       if (event->pending_disable) {
> +               event->pending_disable = 0;
>                 perf_cgroup_event_disable(event, ctx);
>                 state = PERF_EVENT_STATE_OFF;
>         }
> +
> +       if (event->pending_sigtrap && state == PERF_EVENT_STATE_OFF)
> +               event->pending_sigtrap = 0;
> +
>         perf_event_set_state(event, state);
>
>         if (!is_software_event(event))
> @@ -2463,8 +2467,7 @@ EXPORT_SYMBOL_GPL(perf_event_disable);
>
>  void perf_event_disable_inatomic(struct perf_event *event)
>  {
> -       WRITE_ONCE(event->pending_disable, smp_processor_id());
> -       /* can fail, see perf_pending_event_disable() */
> +       event->pending_disable = 1;
>         irq_work_queue(&event->pending);
>  }
>
> @@ -2527,6 +2530,9 @@ event_sched_in(struct perf_event *event,
>         if (event->attr.exclusive)
>                 cpuctx->exclusive = 1;
>
> +       if (event->pending_disable || event->pending_sigtrap)
> +               irq_work_queue(&event->pending);
> +
>  out:
>         perf_pmu_enable(event->pmu);
>
> @@ -6440,47 +6446,40 @@ static void perf_sigtrap(struct perf_event *event)
>                       event->attr.type, event->attr.sig_data);
>  }
>
> -static void perf_pending_event_disable(struct perf_event *event)
> +/*
> + * Deliver the pending work in-event-context or follow the context.
> + */
> +static void __perf_pending_event(struct perf_event *event)
>  {
> -       int cpu = READ_ONCE(event->pending_disable);
> +       int cpu = READ_ONCE(event->oncpu);
>
> +       /*
> +        * If the event isn't running; we done. event_sched_in() will restart
> +        * the irq_work when needed.
> +        */
>         if (cpu < 0)
>                 return;
>
> +       /*
> +        * Yay, we hit home and are in the context of the event.
> +        */
>         if (cpu == smp_processor_id()) {
> -               WRITE_ONCE(event->pending_disable, -1);
> -
> -               if (event->attr.sigtrap) {
> +               if (event->pending_sigtrap) {
> +                       event->pending_sigtrap = 0;
>                         perf_sigtrap(event);
> -                       atomic_set_release(&event->event_limit, 1); /* rearm event */
> -                       return;
>                 }
> -
> -               perf_event_disable_local(event);
> -               return;
> +               if (event->pending_disable) {
> +                       event->pending_disable = 0;
> +                       perf_event_disable_local(event);
> +               }
>         }
>
>         /*
> -        *  CPU-A                       CPU-B
> -        *
> -        *  perf_event_disable_inatomic()
> -        *    @pending_disable = CPU-A;
> -        *    irq_work_queue();
> -        *
> -        *  sched-out
> -        *    @pending_disable = -1;
> -        *
> -        *                              sched-in
> -        *                              perf_event_disable_inatomic()
> -        *                                @pending_disable = CPU-B;
> -        *                                irq_work_queue(); // FAILS
> -        *
> -        *  irq_work_run()
> -        *    perf_pending_event()
> -        *
> -        * But the event runs on CPU-B and wants disabling there.
> +        * Requeue if there's still any pending work left, make sure to follow
> +        * where the event went.
>          */
> -       irq_work_queue_on(&event->pending, cpu);
> +       if (event->pending_disable || event->pending_sigtrap)
> +               irq_work_queue_on(&event->pending, cpu);

I considered making the irq_work "chase" the right CPU but it doesn't
work for sigtrap. This will make the signal asynchronous (it should be
synchronous), and the reason why I had to do irq_work_raw_sync().

Thanks,
-- Marco
