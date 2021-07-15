Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B713C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC5C8613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbhGOQeE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhGOQeE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:34:04 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7244FC06175F;
        Thu, 15 Jul 2021 09:31:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id w13so4092891wmc.3;
        Thu, 15 Jul 2021 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=VIGlNohesPyZovg0nZZcz5+kmHfu4ux+1Kmisqf7/3w=;
        b=Ljdle4IvRA3NB7DUbAjuEedye1YL8RD2LdcN/LIwiXXR7UsuvzbPOZJ+uzPxmWJt/7
         mGtNWneZT4c8oPi2tpAtLxeHyu8BHSNoIsGB8tNq+pfwjlE8irWQQS+n8FvrLku1JQJ8
         RGT3N6j1QRhepnrzsY9+1DcNqeDfVxFHzYeumU/I3lnP6JIvGTh55yDi4kVJH5UUAcoz
         B6NiuIsd6alq7WM2IIckz5rEyzdNxrWbis2F5xT43jrvhvsCriHNkJHMt9hCXSg0dWO7
         ROAaQye2a3zlYKW67l7gmRLW8jnxuYqKMUeFUN6sLz8whMEcBOC/pD7A08Sn03QbUW0e
         cYuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=VIGlNohesPyZovg0nZZcz5+kmHfu4ux+1Kmisqf7/3w=;
        b=iRzuVgOU1WFeDyt3+LcGtJa9NTOVQfJia/VDXeP5w8OQaWMqBiQ2pa166+XtQOdIQo
         32GTsfF8JFE2eFOlV6zn4KrbnMGDL8COrTzTGF+XiGm633GY26HWRBHOpFJmDe2kfZmO
         s5Wm2P1FNJHdJ9BBiK/l4hJNedqJU2jXjOXWtdnTtIRkeLUkxVwKYEkwej9TMzj4jTDs
         RWZh6hNg5Cqo6PTUn+pTxJJT631aJ4ZKKPjssWP2lScqBWTfe1FPR76xg2DpmYT+N/NF
         fdsZW/YTbrLa/95085eVG4xrgcXXOit1avHlyAgfAiDb5FjdJ6NZF6kBchCcNpuJccF6
         BB0w==
X-Gm-Message-State: AOAM532Y5aTlcMe0Imvg9AtApEoWa0kyN6f5rUWsOHCnIluzHaUXUwiU
        xamUQaZr+nHUa/MKQIz4DpQ=
X-Google-Smtp-Source: ABdhPJyXN/I1pnxa9CrFGz4Z8Ru6sM8v3GCut2B5jTkWPuahfKk6Kx/cck2R//55yX6SxUvZBcN/Tg==
X-Received: by 2002:a1c:f616:: with SMTP id w22mr5460327wmc.131.1626366668921;
        Thu, 15 Jul 2021 09:31:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id 139sm6584824wma.32.2021.07.15.09.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:31:08 -0700 (PDT)
Message-ID: <cf0067475311633b91fc22eeb7215c5dac79031e.camel@gmail.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and
 destruction
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Thu, 15 Jul 2021 18:31:07 +0200
In-Reply-To: <YO7xpFg0F5Fv/7sI@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
         <YO7xpFg0F5Fv/7sI@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

thanks for reviewing the patch!

On Wed, 2021-07-14 at 11:16 -0300, Arnaldo Carvalho de Melo wrote:
<SNIP>
> > +
> > +enum threadpool_status {
> > +       THREADPOOL_STATUS__STOPPED,             /* no threads */
> > +       THREADPOOL_STATUS__ERROR,               /* errors */
> > +       THREADPOOL_STATUS__MAX
> > +};
> > +
> > +struct threadpool_struct {
> 
> Can this be just 'struct threadpool'? I think its descriptive enough:

I agree, but I wanted to keep the naming consistent between workqueue.c and
threadpool.c.

> 
> > +       int                     nr_threads;     /* number of threads in the
> > pool */
> > +       struct thread_struct    *threads;       /* array of threads in the
> > pool */
> > +       struct task_struct      *current_task;  /* current executing
> > function
> > */
> > +       enum threadpool_status  status;         /* current status of the
> > pool
> > */
> > +};
> > +
> > +struct thread_struct {
> > +       int                             idx;    /* idx of thread in pool-
> > > threads */
> > +       pid_t                           tid;    /* tid of thread */
> > +       struct threadpool_struct        *pool;  /* parent threadpool */
> > +       struct {
> > +               int from[2];                    /* messages from thread
> > (acks)
> > */
> > +               int to[2];                      /* messages to thread
> > (commands) */
> > +       } pipes;
> > +};
> 
> This one, since we have already a 'struct thread' in tools/perf, to
> represent a PERF_RECORD_FORK, perhaps we can call it 'struct
> threadpool_entry'?

Agreed.

> 
> > +
> > +/**
> > + * init_pipes - initialize all pipes of @thread
> > + */
> > +static void init_pipes(struct thread_struct *thread)
> > +{
> > +       thread->pipes.from[0] = -1;
> > +       thread->pipes.from[1] = -1;
> > +       thread->pipes.to[0] = -1;
> > +       thread->pipes.to[1] = -1;
> > +}
> > +
> > +/**
> > + * open_pipes - open all pipes of @thread
> > + */
> > +static int open_pipes(struct thread_struct *thread)
> 
> Here please:
> 
> threadpool_entry__open_pipes()
> 
> Its longer, but helps with ctags/cscope navigation and we can go
> directly to it via:
> 
> :ta threadpool_entry__open_p<TAB>
> 
> While 'ta: open_pipes' may bo to various places where this idiom is
> used.

Agreed.

<SNIP>
> > +/**
> > + * create_threadpool - create a fixed threadpool with @n_threads threads
> > + */
> > +struct threadpool_struct *create_threadpool(int n_threads)
> 
> 
> Is this already something the kernel has and thus we should keep the
> naming? I couldn't find it in the kernel, so please name it:
> 
> struct threadpool *threadpool__new(int nthreads)

As before, I did this to keep consistency with workqueue.
Since this threadpool+workqueue can be a standalone library, I preferred to keep
the naming consistent inside it, instead of making it consistent with perf (this
is what I was referring to in the cover letter, not just the workqueue API).
What do you think?
I also prefer perf's naming conventions, but it'd feel strange to use two
different naming conventions inside the same library.

> 
> > +{
> > +       int ret, t;
> > +       struct threadpool_struct *pool = malloc(sizeof(*pool));
> > +
> > +       if (!pool) {
> > +               pr_err("threadpool: cannot allocate pool: %s\n",
> > +                       strerror(errno));o
> 
> Humm, pr_err() at this level isn't appropriate, please make callers
> complain.

ok.

> 
> > +               return NULL;
> > +       }
> > +
> > +       if (n_threads <= 0) {
> > +               pr_err("threadpool: invalid number of threads: %d\n",
> > +                       n_threads);
> 
> pr_debug()

ok

> 
> > +               goto out_free_pool;
> > +       }
> > +
> > +       pool->nr_threads = n_threads;
> > +       pool->current_task = NULL;
> > +
> > +       pool->threads = malloc(n_threads * sizeof(*pool->threads));
> > +       if (!pool->threads) {
> > +               pr_err("threadpool: cannot allocate threads: %s\n",
> > +                       strerror(errno));
> > +               goto out_free_pool;
> > +       }
> > +
> > +       for (t = 0; t < n_threads; t++) {
> > +               pool->threads[t].idx = t;
> > +               pool->threads[t].tid = -1;
> > +               pool->threads[t].pool = pool;
> > +               init_pipes(&pool->threads[t]);
> > +       }
> > +
> > +       for (t = 0; t < n_threads; t++) {
> > +               ret = open_pipes(&pool->threads[t]);
> > +               if (ret)
> > +                       goto out_close_pipes;
> > +       }
> > +
> > +       pool->status = THREADPOOL_STATUS__STOPPED;
> > +
> > +       return pool;
> > +
> > +out_close_pipes:
> > +       for (t = 0; t < n_threads; t++)
> > +               close_pipes(&pool->threads[t]);
> > +
> > +       free(pool->threads);
> > +out_free_pool:
> > +       free(pool);
> > +       return NULL;
> 
> Here we can use ERR_PTR()/PTR_ERR() to let the caller know what was the
> problem, i.e. we can ditch all the pr_err/pr_debug(), etc and instead
> have a threadpool__strerror(struct threadpool *pool, int err) like we
> have for 'struct evsel', please take a look at evsel__open_strerror().

Thanks, I'll have a look at it.
So, what I sould do is not use pr_* higher than debug inside library code and
return meaningful errors through PR_ERR, right?

> 
> 
> > +}
> > +
> > +/**
> > + * destroy_threadpool - free the @pool and all its resources
> > + */
> > +void destroy_threadpool(struct threadpool_struct *pool)
> 
> 
> void threadpool__delete(struct threadpool *pool)
> > +{
> > +       int t;
> > +
> > +       if (!pool)
> > +               return;
> > +
> > +       WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
> > +               && pool->status != THREADPOOL_STATUS__ERROR);
> > +
> > +       for (t = 0; t < pool->nr_threads; t++)
> > +               close_pipes(&pool->threads[t]);
> 
> reset pool->threads[t] to -1

already inside close_pipes. I agree it might be confusing without the
threadpool_entry__ prefix.

> 
> > +
> > +       free(pool->threads);
> 
> zfree

In general, when should I use zfree instead of free?

> 
> > +       free(pool);
> > +}
> > +
> > +/**
> > + * threadpool_size - get number of threads in the threadpool
> > + */
> > +int threadpool_size(struct threadpool_struct *pool)
>   
> threadpool__size()

ok

Thanks,
Riccardo

> 
> > +{
> > +       return pool->nr_threads;
> > +}
> > diff --git a/tools/perf/util/workqueue/threadpool.h
> > b/tools/perf/util/workqueue/threadpool.h
> > new file mode 100644
> > index 0000000000000000..2b9388c768a0b588
> > --- /dev/null
> > +++ b/tools/perf/util/workqueue/threadpool.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __WORKQUEUE_THREADPOOL_H
> > +#define __WORKQUEUE_THREADPOOL_H
> > +
> > +struct threadpool_struct;
> > +struct task_struct;
> > +
> > +typedef void (*task_func_t)(int tidx, struct task_struct *task);
> > +
> > +struct task_struct {
> > +       task_func_t fn;
> > +};
> > +
> > +extern struct threadpool_struct *create_threadpool(int n_threads);
> > +extern void destroy_threadpool(struct threadpool_struct *pool);
> > +
> > +extern int threadpool_size(struct threadpool_struct *pool);
> > +
> > +#endif /* __WORKQUEUE_THREADPOOL_H */
> > -- 
> > 2.31.1
> > 
> 



