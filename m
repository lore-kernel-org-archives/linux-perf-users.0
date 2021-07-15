Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0FCC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983EB6127C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237350AbhGOUvT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhGOUvR (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:51:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EB37E6127C;
        Thu, 15 Jul 2021 20:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626382103;
        bh=SNvc7furajCl8AgLzbWQacVUx5gPJQY9sRhAV4UgYkg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDGgDJdCI9jdKQjWfNKAC0Qn9AOJU4caBJxjVWCfZRz8KBdRwt2ln5Suye2fd/041
         XSV9+Gua/acSc8+S2pm0kOpOyC5gvFpAgn0B5tRIMISlBoLMBkBkK3PWdhUNMZmqas
         6nkxVZdWTNZA7nhnkw+ROZzXn0BBhi9fj/Z8towXuJjbiyyVkb5Rwkr2InNeOCv/oo
         NwDMbrDKgbV0X/9KkL4poDKjNuHr7j4GaxhY3aOY96KlFtfVA0EdWgbG+pS7WEoyaj
         5wSySgKe2NLk6PZVx1Oe000ULd/0NbX6KXL8xQ1JMKXKNeXd8uu83PiJXierz2GtDf
         K4gJgtL3Cs26w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A7983403F2; Thu, 15 Jul 2021 17:48:20 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:48:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and
 destruction
Message-ID: <YPCfFHJgo7axvm1/@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
 <YO7xpFg0F5Fv/7sI@kernel.org>
 <cf0067475311633b91fc22eeb7215c5dac79031e.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cf0067475311633b91fc22eeb7215c5dac79031e.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:31:07PM +0200, Riccardo Mancini escreveu:
> Hi Arnaldo,
> 
> thanks for reviewing the patch!
> 
> On Wed, 2021-07-14 at 11:16 -0300, Arnaldo Carvalho de Melo wrote:
> <SNIP>
> > > +
> > > +enum threadpool_status {
> > > +       THREADPOOL_STATUS__STOPPED,             /* no threads */
> > > +       THREADPOOL_STATUS__ERROR,               /* errors */
> > > +       THREADPOOL_STATUS__MAX
> > > +};
> > > +
> > > +struct threadpool_struct {
> > 
> > Can this be just 'struct threadpool'? I think its descriptive enough:
> 
> I agree, but I wanted to keep the naming consistent between workqueue.c and
> threadpool.c.
> 
> > 
> > > +       int                     nr_threads;     /* number of threads in the
> > > pool */
> > > +       struct thread_struct    *threads;       /* array of threads in the
> > > pool */
> > > +       struct task_struct      *current_task;  /* current executing
> > > function
> > > */
> > > +       enum threadpool_status  status;         /* current status of the
> > > pool
> > > */
> > > +};
> > > +
> > > +struct thread_struct {
> > > +       int                             idx;    /* idx of thread in pool-
> > > > threads */
> > > +       pid_t                           tid;    /* tid of thread */
> > > +       struct threadpool_struct        *pool;  /* parent threadpool */
> > > +       struct {
> > > +               int from[2];                    /* messages from thread
> > > (acks)
> > > */
> > > +               int to[2];                      /* messages to thread
> > > (commands) */
> > > +       } pipes;
> > > +};
> > 
> > This one, since we have already a 'struct thread' in tools/perf, to
> > represent a PERF_RECORD_FORK, perhaps we can call it 'struct
> > threadpool_entry'?
> 
> Agreed.
> 
> > 
> > > +
> > > +/**
> > > + * init_pipes - initialize all pipes of @thread
> > > + */
> > > +static void init_pipes(struct thread_struct *thread)
> > > +{
> > > +       thread->pipes.from[0] = -1;
> > > +       thread->pipes.from[1] = -1;
> > > +       thread->pipes.to[0] = -1;
> > > +       thread->pipes.to[1] = -1;
> > > +}
> > > +
> > > +/**
> > > + * open_pipes - open all pipes of @thread
> > > + */
> > > +static int open_pipes(struct thread_struct *thread)
> > 
> > Here please:
> > 
> > threadpool_entry__open_pipes()
> > 
> > Its longer, but helps with ctags/cscope navigation and we can go
> > directly to it via:
> > 
> > :ta threadpool_entry__open_p<TAB>
> > 
> > While 'ta: open_pipes' may bo to various places where this idiom is
> > used.
> 
> Agreed.
> 
> <SNIP>
> > > +/**
> > > + * create_threadpool - create a fixed threadpool with @n_threads threads
> > > + */
> > > +struct threadpool_struct *create_threadpool(int n_threads)
> > 
> > 
> > Is this already something the kernel has and thus we should keep the
> > naming? I couldn't find it in the kernel, so please name it:
> > 
> > struct threadpool *threadpool__new(int nthreads)
> 
> As before, I did this to keep consistency with workqueue.
> Since this threadpool+workqueue can be a standalone library, I preferred to keep
> the naming consistent inside it, instead of making it consistent with perf (this
> is what I was referring to in the cover letter, not just the workqueue API).
> What do you think?
> I also prefer perf's naming conventions, but it'd feel strange to use two
> different naming conventions inside the same library.

See my comment on the other message about this naming dilemma :-)
 
> > 
> > > +{
> > > +       int ret, t;
> > > +       struct threadpool_struct *pool = malloc(sizeof(*pool));
> > > +
> > > +       if (!pool) {
> > > +               pr_err("threadpool: cannot allocate pool: %s\n",
> > > +                       strerror(errno));o
> > 
> > Humm, pr_err() at this level isn't appropriate, please make callers
> > complain.
> 
> ok.
> 
> > 
> > > +               return NULL;
> > > +       }
> > > +
> > > +       if (n_threads <= 0) {
> > > +               pr_err("threadpool: invalid number of threads: %d\n",
> > > +                       n_threads);
> > 
> > pr_debug()
> 
> ok
> 
> > 
> > > +               goto out_free_pool;
> > > +       }
> > > +
> > > +       pool->nr_threads = n_threads;
> > > +       pool->current_task = NULL;
> > > +
> > > +       pool->threads = malloc(n_threads * sizeof(*pool->threads));
> > > +       if (!pool->threads) {
> > > +               pr_err("threadpool: cannot allocate threads: %s\n",
> > > +                       strerror(errno));
> > > +               goto out_free_pool;
> > > +       }
> > > +
> > > +       for (t = 0; t < n_threads; t++) {
> > > +               pool->threads[t].idx = t;
> > > +               pool->threads[t].tid = -1;
> > > +               pool->threads[t].pool = pool;
> > > +               init_pipes(&pool->threads[t]);
> > > +       }
> > > +
> > > +       for (t = 0; t < n_threads; t++) {
> > > +               ret = open_pipes(&pool->threads[t]);
> > > +               if (ret)
> > > +                       goto out_close_pipes;
> > > +       }
> > > +
> > > +       pool->status = THREADPOOL_STATUS__STOPPED;
> > > +
> > > +       return pool;
> > > +
> > > +out_close_pipes:
> > > +       for (t = 0; t < n_threads; t++)
> > > +               close_pipes(&pool->threads[t]);
> > > +
> > > +       free(pool->threads);
> > > +out_free_pool:
> > > +       free(pool);
> > > +       return NULL;
> > 
> > Here we can use ERR_PTR()/PTR_ERR() to let the caller know what was the
> > problem, i.e. we can ditch all the pr_err/pr_debug(), etc and instead
> > have a threadpool__strerror(struct threadpool *pool, int err) like we
> > have for 'struct evsel', please take a look at evsel__open_strerror().
> 
> Thanks, I'll have a look at it.
> So, what I sould do is not use pr_* higher than debug inside library code and
> return meaningful errors through PR_ERR, right?

Right.
 
> > 
> > 
> > > +}
> > > +
> > > +/**
> > > + * destroy_threadpool - free the @pool and all its resources
> > > + */
> > > +void destroy_threadpool(struct threadpool_struct *pool)
> > 
> > 
> > void threadpool__delete(struct threadpool *pool)
> > > +{
> > > +       int t;
> > > +
> > > +       if (!pool)
> > > +               return;
> > > +
> > > +       WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
> > > +               && pool->status != THREADPOOL_STATUS__ERROR);
> > > +
> > > +       for (t = 0; t < pool->nr_threads; t++)
> > > +               close_pipes(&pool->threads[t]);
> > 
> > reset pool->threads[t] to -1
> 
> already inside close_pipes. I agree it might be confusing without the
> threadpool_entry__ prefix.
> 
> > 
> > > +
> > > +       free(pool->threads);
> > 
> > zfree
> 
> In general, when should I use zfree instead of free?
> 
> > 
> > > +       free(pool);
> > > +}
> > > +
> > > +/**
> > > + * threadpool_size - get number of threads in the threadpool
> > > + */
> > > +int threadpool_size(struct threadpool_struct *pool)
> >   
> > threadpool__size()
> 
> ok
> 
> Thanks,
> Riccardo
> 
> > 
> > > +{
> > > +       return pool->nr_threads;
> > > +}
> > > diff --git a/tools/perf/util/workqueue/threadpool.h
> > > b/tools/perf/util/workqueue/threadpool.h
> > > new file mode 100644
> > > index 0000000000000000..2b9388c768a0b588
> > > --- /dev/null
> > > +++ b/tools/perf/util/workqueue/threadpool.h
> > > @@ -0,0 +1,19 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __WORKQUEUE_THREADPOOL_H
> > > +#define __WORKQUEUE_THREADPOOL_H
> > > +
> > > +struct threadpool_struct;
> > > +struct task_struct;
> > > +
> > > +typedef void (*task_func_t)(int tidx, struct task_struct *task);
> > > +
> > > +struct task_struct {
> > > +       task_func_t fn;
> > > +};
> > > +
> > > +extern struct threadpool_struct *create_threadpool(int n_threads);
> > > +extern void destroy_threadpool(struct threadpool_struct *pool);
> > > +
> > > +extern int threadpool_size(struct threadpool_struct *pool);
> > > +
> > > +#endif /* __WORKQUEUE_THREADPOOL_H */
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
> 
> 

-- 

- Arnaldo
