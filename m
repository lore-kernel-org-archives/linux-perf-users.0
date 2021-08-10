Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2098C4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93C1F60EC0
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 18:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbhHJSy5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:54:57 -0400
Received: from mail-lj1-f172.google.com ([209.85.208.172]:38870 "EHLO
        mail-lj1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231789AbhHJSyy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 14:54:54 -0400
Received: by mail-lj1-f172.google.com with SMTP id u13so166209lje.5;
        Tue, 10 Aug 2021 11:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g2m9Db8eM0wZPkDtS4l8A8n22TL5TNtODzZR5QP0RwI=;
        b=fIAXCkWkudxdrisVEtrWOBeEP+v1L2YNopGUzKnE5YR5MdksMcXl7A6WOfjRNJ4kVG
         TOxTXmHxsuWiZqSMUKgQJ0mF+GP6nf9TEiFd2EZtV+qXTBJMFOPgGwHqaHGg2yiFaK4i
         ZpGkkeX4ETA82DSSUu0krX7IdSOLqHJmmUP9pDxv8NK/zMybZFV9eB4BAQzuZHK61lv5
         8VkUUOY+XHG1P4M4pr0yN3zxo4vhW1BFRJucomu3TvWG9X+dvbp6bAYUyLyL3fU584mC
         uH+9QqCM3spXJc5+oJh9zIYqt1JctJlTvQ/WclarHvJs9Pk7z4hjXP/NU5vq3gqSdXma
         1A4g==
X-Gm-Message-State: AOAM530DBl9MiA9/jv8Q+tpR2u4m4fG5b18mBXSV0bxPuQpARrlY0nhl
        PYlj/O6FYyNoASx7un2HU7F8cPM8VMysbVFOD+M=
X-Google-Smtp-Source: ABdhPJwKSWuu612Ca7osDBU6ysDRDAhcRPoOoroymaaKOC0vBR9MMW2FeMVVoS05twhPztEkIY0DC2w+scr6RoDESkQ=
X-Received: by 2002:a05:651c:1148:: with SMTP id h8mr10016795ljo.26.1628621670754;
 Tue, 10 Aug 2021 11:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627657061.git.rickyman7@gmail.com> <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
 <CAM9d7ci0LcdTZyDu5sxGkaS07Z-m4hvr2xU4TDK_aTRAJm7b7A@mail.gmail.com> <25278c08762593a5b0bd1873f6c0745c7ad97016.camel@gmail.com>
In-Reply-To: <25278c08762593a5b0bd1873f6c0745c7ad97016.camel@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Aug 2021 11:54:19 -0700
Message-ID: <CAM9d7chuFG+cYPx34abvmciN0afUDqJ3uWo9Bsh-9jjLtQmWqQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 01/10] perf workqueue: threadpool creation and destruction
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

On Mon, Aug 9, 2021 at 3:30 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> On Fri, 2021-08-06 at 19:24 -0700, Namhyung Kim wrote:
> > > +
> > > +/**
> > > + * threadpool__strerror - print message regarding given @err in @pool
> > > + *
> > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > + */
> > > +int threadpool__strerror(struct threadpool *pool __maybe_unused, int err,
> > > char *buf, size_t size)
> > > +{
> > > +       char sbuf[STRERR_BUFSIZE], *emsg;
> > > +
> > > +       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> > > +       return scnprintf(buf, size, "Error: %s.\n", emsg);
> > > +}
> > > +
> > > +/**
> > > + * threadpool__new_strerror - print message regarding @err_ptr
> > > + *
> > > + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> > > + */
> > > +int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t
> > > size)
> > > +{
> > > +       return threadpool__strerror(err_ptr, PTR_ERR(err_ptr), buf, size);
> > > +}
> >
> > Why two different functions?
>
> Since when new fails you don't have a err number, just an err_ptr so it's not
> very clear how to call threadpool__strerror. Therefore I made a wrapper to
> remove any ambiguity.

What do you mean by "when new fails"?

> >
> > > +
> > > +/**
> > > + * threadpool__delete - free the @pool and all its resources
> > > + */
> > > +void threadpool__delete(struct threadpool *pool)
> > > +{
> > > +       int t;
> > > +
> > > +       if (IS_ERR_OR_NULL(pool))
> > > +               return;
> > > +
> > > +       WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
> > > +               && pool->status != THREADPOOL_STATUS__ERROR);
> > > +
> > > +       for (t = 0; t < pool->nr_threads; t++)
> > > +               threadpool_entry__close_pipes(&pool->threads[t]);
> > > +
> > > +       zfree(&pool->threads);
> > > +       free(pool);
> > > +}
> > > +
> > > +/**
> > > + * threadpool__size - get number of threads in the threadpool
> > > + */
> > > +int threadpool__size(struct threadpool *pool)
> > > +{
> > > +       return pool->nr_threads;
> > > +}
> > > diff --git a/tools/perf/util/workqueue/threadpool.h
> > > b/tools/perf/util/workqueue/threadpool.h
> > > new file mode 100644
> > > index 0000000000000000..fb18aa32fb64f671
> > > --- /dev/null
> > > +++ b/tools/perf/util/workqueue/threadpool.h
> > > @@ -0,0 +1,30 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __WORKQUEUE_THREADPOOL_H
> > > +#define __WORKQUEUE_THREADPOOL_H
> > > +
> > > +struct threadpool;
> > > +struct task_struct;
> >
> > You can just move the definition here.
> >
> > > +
> > > +typedef void (*task_func_t)(int tidx, struct task_struct *task);
> > > +
> > > +struct task_struct {
> > > +       task_func_t fn;
> > > +};
>
> I thought it was not allowed, since task_func_t refers to task_struct and
> viceversa.
> I will try to remove it if possible.

Oh, I missed that, sorry for the noise.

Thanks,
namhyung
