Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D7BC636CA
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80845613F8
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbhGPN47 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 09:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPN46 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 09:56:58 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01455C06175F;
        Fri, 16 Jul 2021 06:54:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j34so5882926wms.5;
        Fri, 16 Jul 2021 06:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=btgN7tUSP/yLaAouyGCSHQGvOMd/ZnNWc68W+rcJ3YQ=;
        b=JOCzVv4MLgKKHP4v6mJ5+ORzX855S7Sh94alQwCx3tzzoyu+aUY8jA9BgFTtGkxKhk
         JfTUd1oFUWE6xIR+1nMeWiEB7Wl8G909k4FAbBq3ZnmJGfmPM2KBC1J0FYCEVwmH9dLZ
         MsVa4fj8arUIy5Sm8jc7oPt0BR9NLz1T/58SC9FRAdKOsX5dKyd/tHIKe3sLYbnfbY7u
         UMoMYwJ7/Dpenuq6FujRuEG4R4VXkR1mhq8+xqDArHG4XV8QvGT/yyPcItbd3kWlyeva
         0PupMqEkgw4JOCtO+ut7Udzz5aVW+XEpMnzEJ4f7KcYTdIjOHNdbfrEj7Pgi4wxzh6X2
         TbRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=btgN7tUSP/yLaAouyGCSHQGvOMd/ZnNWc68W+rcJ3YQ=;
        b=c5w+nf43ee8hOvibFMyZSp780hTsuae3SYpKeiiPwLvSY/xAj7lyDipylsIH1968ak
         cuVar8F61CS6OX1uYWdGz6rsWJCI1NwU4zXDvpWzKJNIUUJavqQI5NAQTfzAGZQsltMj
         pXAA9v+3wbw1Xr9MUnlGhjgQRRLgqFdoZy4thp9KJHLEqLZvEEEbebPqB0eQC+l5wcdG
         e259NDpJD0yINfjlKfNgF9IDZbV03wbflM17zUKiwDtk4IGbdulJwTAtezjhNSO23Qgb
         oTwVXmf8Kme7dE2ZjUKXzT20zCg/s1EVpzphWQ8/1kzllTzH/m+kfXdGobpzo4lw3/JA
         +1jA==
X-Gm-Message-State: AOAM531tZQx8sIon3gCw/n+EdonCExy5mH1gMWZlySJIQG3Y49ZOnXsz
        Ar/M379Odp493exSWRQ/w2XxCDU/RDeUFe2hq3nXjA==
X-Google-Smtp-Source: ABdhPJwM1rTbOTCZhGtN9CeCQDbcumwffAnfw17P9wpcEJZN3DHDIGzwEuSGiwBrognwIlFC6U3r7g==
X-Received: by 2002:a1c:8083:: with SMTP id b125mr10833257wmd.132.1626443641356;
        Fri, 16 Jul 2021 06:54:01 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id q72sm2475284wme.14.2021.07.16.06.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:53:59 -0700 (PDT)
Message-ID: <5866e3456645659423030339f71f3461659ffe2d.camel@gmail.com>
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop
 functions
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Fri, 16 Jul 2021 15:53:58 +0200
In-Reply-To: <CAM9d7chvRswKLmRvW5rd4GApqngN8QeG+nPmVy4zxz_YR0MMxw@mail.gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
         <CAM9d7chvRswKLmRvW5rd4GApqngN8QeG+nPmVy4zxz_YR0MMxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,

On Thu, 2021-07-15 at 16:48 -0700, Namhyung Kim wrote:
> On Tue, Jul 13, 2021 at 5:11 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
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
> > ---
> >  tools/perf/tests/workqueue.c           |  13 ++
> >  tools/perf/util/workqueue/threadpool.c | 238 +++++++++++++++++++++++++
> >  tools/perf/util/workqueue/threadpool.h |   5 +
> >  3 files changed, 256 insertions(+)
> > 
> > diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> > index 1bd4d78c13eb3b14..be377e9897bab4e9 100644
> > --- a/tools/perf/tests/workqueue.c
> > +++ b/tools/perf/tests/workqueue.c
> > @@ -10,16 +10,29 @@ struct threadpool_test_args_t {
> > 
> >  static int __threadpool__prepare(struct threadpool_struct **pool, int
> > pool_size)
> >  {
> > +       int ret;
> > +
> >         *pool = create_threadpool(pool_size);
> >         TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
> >         TEST_ASSERT_VAL("threadpool size is wrong",
> >                         threadpool_size(*pool) == pool_size);
> > 
> > +       ret = start_threadpool(*pool);
> > +       TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> > +       TEST_ASSERT_VAL("threadpool is not ready",
> > threadpool_is_ready(*pool));
> > +
> >         return 0;
> >  }
> > 
> >  static int __threadpool__teardown(struct threadpool_struct *pool)
> >  {
> > +       int ret;
> > +
> > +       ret = stop_threadpool(pool);
> > +       TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> 
> s/start/stop/
Thanks.
> 
> > +       TEST_ASSERT_VAL("stopped threadpool is ready",
> > +                       !threadpool_is_ready(pool));
> > +
> >         destroy_threadpool(pool);
> > 
> >         return 0;
> > diff --git a/tools/perf/util/workqueue/threadpool.c
> > b/tools/perf/util/workqueue/threadpool.c
> > index 70c67569f956a3e2..f4635ff782b9388e 100644
> > --- a/tools/perf/util/workqueue/threadpool.c
> > +++ b/tools/perf/util/workqueue/threadpool.c
> [SNIP]
> > +/**
> > + * wait_thread - receive ack from thread
> > + *
> > + * NB: call only from main thread!
> > + */
> > +static int wait_thread(struct thread_struct *thread)
> > +{
> > +       int res;
> > +       enum thread_msg msg = THREAD_MSG__UNDEFINED;
> > +
> > +       res = read(thread->pipes.from[0], &msg, sizeof(msg));
> > +       if (res < 0) {
> 
> Maybe it needs to handle -EINTR.

Its behaviour should be retry, right?
Since these reads are used multiple times in the code, maybe I'm better off
writing a wrapper function handling also EINTR.

> 
> > +               pr_err("threadpool: failed to recv msg from tid=%d: %s\n",
> > +                      thread->tid, strerror(errno));
> > +               return -1;
> > +       }
> > +       if (msg != THREAD_MSG__ACK) {
> > +               pr_err("threadpool: received unexpected msg from tid=%d:
> > %s\n",
> > +                      thread->tid, thread_msg_tags[msg]);
> > +               return -1;
> > +       }
> > +
> > +       pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
> > +
> > +       return 0;
> > +}
> > 
<SNIP>
> > +static int __start_threadpool(struct threadpool_struct *pool)
> > +{
> > +       int t, tt, ret = 0, nr_threads = pool->nr_threads;
> > +       sigset_t full, mask;
> > +       pthread_t handle;
> > +       pthread_attr_t attrs;
> > +
> > +       sigfillset(&full);
> > +       if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> > +               pr_err("Failed to block signals on threads start: %s\n",
> > +                       strerror(errno));
> > +               return -1;
> > +       }
> > +
> > +       pthread_attr_init(&attrs);
> > +       pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> > +
> > +       for (t = 0; t < nr_threads; t++) {
> > +               struct thread_struct *thread = &pool->threads[t];
> > +
> > +               if (pthread_create(&handle, &attrs, threadpool_thread,
> > thread)) {
> > +                       for (tt = 1; tt < t; tt++)
> > +                               terminate_thread(thread);
> > +                       pr_err("Failed to start threads: %s\n",
> > strerror(errno));
> > +                       ret = -1;
> > +                       goto out_free_attr;
> > +               }
> > +
> > +               if (wait_thread(thread)) {
> > +                       for (tt = 1; tt <= t; tt++)
> > +                               terminate_thread(thread);
> > +                       ret = -1;
> > +                       goto out_free_attr;
> > +               }
> > +       }
> 
> Isn't it better doing this way?
> 
> for (t = 0; t < nr_threads; t++) {
>     pthread_create(t)
> }
> 
> for (t = 0; t < nr_threads; t++) {
>     wait_thread(t)
> }

I wondered the same thing, but I saw that it was done like that also in Alexey
patch, so I kept it like so.
To me, it also looks like it should be not a problem doing as you suggest. It
should also be more efficient.

Thanks,
Riccardo

> 
> Thanks,
> Namhyung
> 
> 
> > +
> > +out_free_attr:
> > +       pthread_attr_destroy(&attrs);
> > +
> > +       if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> > +               pr_err("Failed to unblock signals on threads start: %s\n",
> > +                       strerror(errno));
> > +               ret = -1;
> > +       }
> > +
> > +       return ret;
> > +}
> > +


