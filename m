Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC1C07E95
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27AB61166
	for <linux-perf-users@archiver.kernel.org>; Mon, 19 Jul 2021 23:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243682AbhGSWfn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:35:43 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:38478 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385401AbhGSS7I (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jul 2021 14:59:08 -0400
Received: by mail-lf1-f52.google.com with SMTP id q16so32158902lfa.5;
        Mon, 19 Jul 2021 12:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HEN45b6Z8/uL9/GqjJXBg1/MFSQ0qCbwqikBovitQAc=;
        b=JJSC/fU/GibSIuZWhDvEwEUqvHxdtNU+897ZQXGFCTJg7ZX3lVaTnsWyHvQodhQy9F
         qzWTlP8gs6OpccbeTWUddMtm6QkACK/KDWtevrxuQYdMrSf+1XS/uLDMhVZIsZNlVPPy
         qpbj8WDjZuAWqSTD+6e1CP1vhNX7JA6V1p8NyWcbukqbZIJh+iEOwK81tw3v+ShVfpYi
         Yp4bbySLKYAgFFA3bPh2qK6xGIyZGefJ7i78YXH+iycpA9ylwruvhccu5dxvfUMB/QJN
         gUKZRJxKPQFqs6oR10t3u3ENhPHgmGYXa3vvvy9mqIz55JOvN1V/uwz2Fz36hztphfw+
         YNRw==
X-Gm-Message-State: AOAM530PMFc86ImzfdC6iBdE3svp2uKA0xGBrp1fw0L2j3Fix8k60NV0
        JMrWgjyD5ebf4BajXRJkPZ3/9PDu+zjnIQgm9xI=
X-Google-Smtp-Source: ABdhPJzNM0u5QF31yqgj84U19qrNo1gyB2UXEM01Jim9YrGvQw4twO6u3HY+sg0mXHk1ZOTZXOTRxSoa+7SMtBiU/vs=
X-Received: by 2002:a05:6512:3125:: with SMTP id p5mr18772177lfd.635.1626723584586;
 Mon, 19 Jul 2021 12:39:44 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626177381.git.rickyman7@gmail.com> <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
 <YO7xpFg0F5Fv/7sI@kernel.org> <CAM9d7chhjRhif=1+Sjjwrc2p+mLN+Lv4LY8dFZZpk5z5VG-+Pw@mail.gmail.com>
 <b7aa58d750f5919f30877fe2f9878698f3cddbc4.camel@gmail.com>
In-Reply-To: <b7aa58d750f5919f30877fe2f9878698f3cddbc4.camel@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 19 Jul 2021 12:39:33 -0700
Message-ID: <CAM9d7cggQkX=LpaOu+zJCJfPqsj0RUvECTDiU2dJpW-XqY5D8g@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and destruction
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 16, 2021 at 6:36 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> Hi Namhyung,
> thanks for the review.
>
> On Thu, 2021-07-15 at 16:29 -0700, Namhyung Kim wrote:
> > Hi Riccardo and Arnaldo,
> >
> > On Wed, Jul 14, 2021 at 7:16 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Tue, Jul 13, 2021 at 02:11:12PM +0200, Riccardo Mancini escreveu:
> > > > The workqueue library is made up by two components:
> > > >  - threadpool: handles the lifetime of the threads
> > > >  - workqueue: handles work distribution among the threads
> > > >
> > > > This first patch introduces the threadpool, starting from its creation
> > > > and destruction functions.
> > > > Thread management is based on the prototype from Alexey:
> > > > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> > > >
> > > > Each thread in the threadpool executes the same function (aka task)
> > > > with a different argument tidx.
> > > > Threads use a pair of pipes to communicate with the main process.
> > > > The threadpool is static (all threads will be spawned at the same time).
> > > > Future work could include making it resizable and adding affinity support
> > > > (as in Alexey prototype).
> > > >
> > > > Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > > ---
> > > >  tools/perf/util/Build                  |   1 +
> > > >  tools/perf/util/workqueue/Build        |   1 +
> > > >  tools/perf/util/workqueue/threadpool.c | 175 +++++++++++++++++++++++++
> > > >  tools/perf/util/workqueue/threadpool.h |  19 +++
> > > >  4 files changed, 196 insertions(+)
> > > >  create mode 100644 tools/perf/util/workqueue/Build
> > > >  create mode 100644 tools/perf/util/workqueue/threadpool.c
> > > >  create mode 100644 tools/perf/util/workqueue/threadpool.h
> <SNIP>
> > > > +
> > > > +struct threadpool_struct {
> > >
> > > Can this be just 'struct threadpool'? I think its descriptive enough:
> > >
> > > > +     int                     nr_threads;     /* number of threads in the
> > > > pool */
> > > > +     struct thread_struct    *threads;       /* array of threads in the
> > > > pool */
> > > > +     struct task_struct      *current_task;  /* current executing
> > > > function */
> >
> > Does this mean it can only have a single function to run?
>
> Yes.
>
> > Why do we need it?
>
> My idea is to separate the workqueue from the actual implementation of the
> threads. This way, when the function executing on the threadpool ends, the
> threads are kept alive to execute new work.
> By adding this additional layer of abstraction, we can achieve more flexibility.
> For example, the use-case I have in mind is to recycle the same threadpool for
> both Alexey's threaded trace and the workqueue.
> I don't think this could be easily achieved with just the workqueue since the
> perf-record threads are not just a task that needs to be executed by they have
> specific affinities to be respected.
>
> What are your thoughts?

I'm fine with the separation of work(queue) and thread-pool.

I thought the backing thread-pool is general and can handle
multiple works at the same time.

The work queue should keep track of works it submitted
and their status.  We can have multiple workqueues
sharing a single thread pool.


>
> >
> >
> > > > +     enum threadpool_status  status;         /* current status of the
> > > > pool */
> > > > +};
> > > > +
> > > > +struct thread_struct {
> > > > +     int                             idx;    /* idx of thread in pool-
> > > > >threads */
> > > > +     pid_t                           tid;    /* tid of thread */
> > > > +     struct threadpool_struct        *pool;  /* parent threadpool */
> > > > +     struct {
> > > > +             int from[2];                    /* messages from thread
> > > > (acks) */
> > > > +             int to[2];                      /* messages to thread
> > > > (commands) */
> >
> > It can be confusing if you think from the main thread.
> > Maybe 'ack' and 'cmd' would be better.
>
> Agreed.
>
> >
> >
> > > > +     } pipes;
> > > > +};
> > >
> > > This one, since we have already a 'struct thread' in tools/perf, to
> > > represent a PERF_RECORD_FORK, perhaps we can call it 'struct
> > > threadpool_entry'?
> >
> > I think we can even use 'worker' instead of 'thread' but it requires
> > huge renaming and conflicts so I won't insist on it strongly.  :)
>
> Also, worker internally conflicts with the workqueue's worker, which runs on a
> (threadpool-)thread.
> Another name I had in mind is pool_thread to prevent having too many 'thread' in
> the name, but it might be confusing.
> I think threadpool_entry is fine.
>
> I have another question.
> In general, when should I use zfree instead of free?

I think the zfree is generally preferable to free.
Especially if the pointer can be accessed after free.

Thanks,
Namhyung
