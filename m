Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF154C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD11613C7
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhGOQpO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbhGOQpO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:45:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA9BC06175F;
        Thu, 15 Jul 2021 09:42:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f17so8636301wrt.6;
        Thu, 15 Jul 2021 09:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UjnH7JFTdfMTc0/hWrQFgZ71PCIq4Fc621eK7BI7/00=;
        b=eCVo/eNkepVwO96hm0mx42fBP1HO0hFxfMFyJtZcHi+qU7BhmZbJELj4HjEt7WdlTs
         8MoWmigDQxOq4cwWFvlmfVw/1Ms1NsdFtZLIks68p7BmdJ5hV5S+gw6m6THGcNobt0Dp
         QP32Svv2O1JsoJGwuGaLYgsGah2TePjWHbwiOYz1TDFyiop2DtIHpIDbyLaYNbSAPq6X
         sVx1PkigH2a2r6000I7YB5+sMY062FXjBussghiB7cGRwhHtJFCSqQywS7ikzpNmoJ3a
         RjkyLcFpN55zMiL1Mhv024lAqUFdphy1bhBZG2O/MrdAIzTNKNYBHjUoFge2jmH580/b
         nNkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UjnH7JFTdfMTc0/hWrQFgZ71PCIq4Fc621eK7BI7/00=;
        b=THf75vUhA6VqKvJhCTMkF6jUZBIS8EzAzU6U3qw+TSvH/RZEnIrkYUcuEotVOJbafy
         vLlNSaKbLCVaMuhaZHeUkgdwigqZ3ehm3IfF2skLPHU76Qlo0bUpVVTFWWzcXZDNLE2B
         0OHRTAgs0wbdZedyjkUx0WIhu4br7HVOFxfwPN6tOlykXpfbD36AlHdfXvJ+qTEdCe6O
         cJnbI1qOnJ+K0KpLEnF9UniRl2SmDGlhMbxcKNNV1IuZetEQ+6zPni0Fc/AHsSqqVGmC
         mXAnRQO308qr7e3ALf7trFSYTMKa+JuHgKfcmQOfdP3A+9YwdCjSu7lRMA7H5vSDY3eo
         wUzA==
X-Gm-Message-State: AOAM531mqfpFy1zzcm/qdtM+xPqeZSWqr1pKN2mHMqvBCx8K0r9Lf69b
        FocMQTsIlswcp8LL5O5MP+0=
X-Google-Smtp-Source: ABdhPJxPm/5IJKkHB+pTEWRRjDBELQ80aPXQfTG/P2W2rt66uxjWdqPh4rOII0Eu3lpuYRUHjxZWBw==
X-Received: by 2002:a5d:5271:: with SMTP id l17mr6641712wrc.239.1626367338270;
        Thu, 15 Jul 2021 09:42:18 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id n2sm6924870wrx.40.2021.07.15.09.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:42:17 -0700 (PDT)
Message-ID: <b758e519c0fe1336ce01d741b2340734faac7af2.camel@gmail.com>
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop
 functions
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
Date:   Thu, 15 Jul 2021 18:42:16 +0200
In-Reply-To: <YO7/n4YAy/R08Wss@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
         <YO7/n4YAy/R08Wss@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,

On Wed, 2021-07-14 at 12:15 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 13, 2021 at 02:11:14PM +0200, Riccardo Mancini escreveu:
> > This patch adds the start and stop functions, alongside the thread
> > function.
> > Each thread will run until a stop signal is received.
> > Furthermore, start and stop are added to the test.
> > 
> > Thread management is based on the prototype from Alexey:
> > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> > 
> > Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
<SNIP>
> >  
> >  static int __threadpool__teardown(struct threadpool_struct *pool)
> >  {
> > +       int ret;
> > +
> > +       ret = stop_threadpool(pool);
> 
>         int ret = stop_threadpool(pool);

ok

> 
> > +       TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> > +       TEST_ASSERT_VAL("stopped threadpool is ready",
> > +                       !threadpool_is_ready(pool));
> > +
> >         destroy_threadpool(pool);
> >  
> >         return 0;
> > diff --git a/tools/perf/util/workqueue/threadpool.c
> > b/tools/perf/util/workqueue/threadpool.c
> > index 70c67569f956a3e2..f4635ff782b9388e 100644
> > --- a/tools/perf/util/workqueue/threadpool.c
> > +++ b/tools/perf/util/workqueue/threadpool.c
> > @@ -4,12 +4,23 @@
> >  #include <unistd.h>
> >  #include <errno.h>
> >  #include <string.h>
> > +#include <pthread.h>
> > +#include <signal.h>
> > +#include <syscall.h>
> >  #include "debug.h"
> >  #include "asm/bug.h"
> >  #include "threadpool.h"
> >  
> > +#ifndef HAVE_GETTID
> > +static inline pid_t gettid(void)
> > +{
> > +       return (pid_t)syscall(__NR_gettid);
> > +}
> > +#endif
> 
> Isn't this defined elsewhere? Yeah, when we decide to move it to
> tools/lib/workqueue/ we'll need it, but for now, reduce patch size.

No, it's just statically defined in tools/perf/jvmti/jvmti_agent.c.
I saw there is a libc_compat.h header in tools/include/tools, I could put this
definition there, and remove the one from jvmti_agent.c.

<SNIP>
> > +/**
> > + * wait_thread - receive ack from thread
> > + *
> > + * NB: call only from main thread!
> > + */
> > +static int wait_thread(struct thread_struct *thread)
> > +{
> > +       int res;
> > +       enum thread_msg msg = THREAD_MSG__UNDEFINED;
> > +
> > +       res = read(thread->pipes.from[0], &msg, sizeof(msg));
> 
>         int res = read(thread->pipes.from[0], &msg, sizeof(msg));

ok

<SNIP>
> > +/**
> > + * threadpool_thread - function running on thread
> > + *
> > + * This function waits for a signal from main thread to start executing
> > + * a task.
> > + * On completion, it will go back to sleep, waiting for another signal.
> > + * Signals are delivered through pipes.
> > + */
> > +static void *threadpool_thread(void *args)
> 
>    threadpool_function()
> 
>  ETOMANY 'thread' in a name.

Agreed :)

<SNIP>

> > +/**
> > + * start_threadpool - start all threads in the pool.
> > + *
> > + * The function blocks until all threads are up and running.
> > + */
> > +int start_threadpool(struct threadpool_struct *pool)
> 
> int threadpool__start(struct threadpool *pool)

ok

> 
> > +{
> > +       int err;
> > +
> > +       if (pool->status != THREADPOOL_STATUS__STOPPED) {
> > +               pr_err("threadpool: starting not stopped pool\n");
> > +               return -1;
> > +       }
> > +
> > +       err = __start_threadpool(pool);
> > +       pool->status = err ? THREADPOOL_STATUS__ERROR :
> > THREADPOOL_STATUS__READY;
> > +       return err;
> > +}
> > +
> > +/**
> > + * stop_threadpool - stop all threads in the pool.
> > + *
> > + * This function blocks waiting for ack from all threads.
> > + */
> > +int stop_threadpool(struct threadpool_struct *pool)
> 
> int threadpool__stop(struct threadpool *pool)

ok

> 
> > +{
> > +       int t, ret, err = 0;
> > +
> > +       if (pool->status != THREADPOOL_STATUS__READY) {
> > +               pr_err("threadpool: stopping not ready pool\n");
> > +               return -1;
> > +       }
> > +
> > +       for (t = 0; t < pool->nr_threads; t++) {
> > +               ret = terminate_thread(&pool->threads[t]);
> > +               if (ret && !err)
> > +                       err = -1;
> > +       }
> > +
> > +       pool->status = err ? THREADPOOL_STATUS__ERROR :
> > THREADPOOL_STATUS__STOPPED;
> > +
> > +       return err;
> > +}
> > +
> > +/**
> > + * threadpool_is_ready - check if the threads are running
> > + */
> > +bool threadpool_is_ready(struct threadpool_struct *pool)
> 
> bool threadpool__is_ready(struct threadpool *pool)

ok

Thanks,
Riccardo

> 
> > +{
> > +       return pool->status == THREADPOOL_STATUS__READY;
> > +}
> > diff --git a/tools/perf/util/workqueue/threadpool.h
> > b/tools/perf/util/workqueue/threadpool.h
> > index 2b9388c768a0b588..b62cad2b2c5dd331 100644
> > --- a/tools/perf/util/workqueue/threadpool.h
> > +++ b/tools/perf/util/workqueue/threadpool.h
> > @@ -14,6 +14,11 @@ struct task_struct {
> >  extern struct threadpool_struct *create_threadpool(int n_threads);
> >  extern void destroy_threadpool(struct threadpool_struct *pool);
> >  
> > +extern int start_threadpool(struct threadpool_struct *pool);
> > +extern int stop_threadpool(struct threadpool_struct *pool);
> > +
> >  extern int threadpool_size(struct threadpool_struct *pool);
> >  
> > +extern bool threadpool_is_ready(struct threadpool_struct *pool);
> > +
> >  #endif /* __WORKQUEUE_THREADPOOL_H */
> > -- 
> > 2.31.1
> > 
> 


