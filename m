Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB8C636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AB97613D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGOXdG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:33:06 -0400
Received: from mail-lj1-f169.google.com ([209.85.208.169]:42591 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhGOXdG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 19:33:06 -0400
Received: by mail-lj1-f169.google.com with SMTP id r16so11408657ljk.9;
        Thu, 15 Jul 2021 16:30:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kFLF5dLDMFQXulu+4BY8SRF+bEZjlT/AnQcVLaG0zZM=;
        b=kwGEhig21M6NS6b6uMbmWiXCv2/8Bv4C1Y1QCxQpBbMksh6cMZx5GDwiHBpQr79rej
         R739QH0da742B82EPy1SI4CPR29wmQPvCpIBFId5jv8QLTRwCrVbOnkCxLZXoQ+AlRRR
         dFflQ3fgGVhh1SVAoBn2xJyy04EOxGCx1yZUvUS7+YRJO1rUuMAelcAHFKRANOlVvgWh
         s663nkVVoheuFKzzhcgkOvbuyf7ou6lElwhEm1Sc30bjj/XaOKG4K3mSdLRYamGGJhQn
         LxiDavSB8TH5bkO0ptQwvazlgnc845WufvqMBje1uUuVaqeKqrp3iHKQYSkEwY+vzet0
         5gqA==
X-Gm-Message-State: AOAM531c9AIO6lDnNNH2Y1JLrZpEq0vW4JNXULmPFB5pRmixqoFkhN0r
        GPvTPEhOlpYZaN6VdJzfymRm5Y4WPDatEZXt7XA=
X-Google-Smtp-Source: ABdhPJy6BnS7zq3FhGZ3NpsswN8kcyMi2+woNPayUrTzGJi+Nqxr0BIX4W8HzboK+Yqme+0tPMNPOHcyWSxoDnuhmCA=
X-Received: by 2002:a2e:9a4a:: with SMTP id k10mr6271585ljj.52.1626391810237;
 Thu, 15 Jul 2021 16:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626177381.git.rickyman7@gmail.com> <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
 <YO7xpFg0F5Fv/7sI@kernel.org>
In-Reply-To: <YO7xpFg0F5Fv/7sI@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Jul 2021 16:29:59 -0700
Message-ID: <CAM9d7chhjRhif=1+Sjjwrc2p+mLN+Lv4LY8dFZZpk5z5VG-+Pw@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and destruction
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
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

Hi Riccardo and Arnaldo,

On Wed, Jul 14, 2021 at 7:16 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Jul 13, 2021 at 02:11:12PM +0200, Riccardo Mancini escreveu:
> > The workqueue library is made up by two components:
> >  - threadpool: handles the lifetime of the threads
> >  - workqueue: handles work distribution among the threads
> >
> > This first patch introduces the threadpool, starting from its creation
> > and destruction functions.
> > Thread management is based on the prototype from Alexey:
> > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> >
> > Each thread in the threadpool executes the same function (aka task)
> > with a different argument tidx.
> > Threads use a pair of pipes to communicate with the main process.
> > The threadpool is static (all threads will be spawned at the same time).
> > Future work could include making it resizable and adding affinity support
> > (as in Alexey prototype).
> >
> > Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/util/Build                  |   1 +
> >  tools/perf/util/workqueue/Build        |   1 +
> >  tools/perf/util/workqueue/threadpool.c | 175 +++++++++++++++++++++++++
> >  tools/perf/util/workqueue/threadpool.h |  19 +++
> >  4 files changed, 196 insertions(+)
> >  create mode 100644 tools/perf/util/workqueue/Build
> >  create mode 100644 tools/perf/util/workqueue/threadpool.c
> >  create mode 100644 tools/perf/util/workqueue/threadpool.h
> >
> > diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> > index 2d4fa13041789cd6..c7b09701661c869d 100644
> > --- a/tools/perf/util/Build
> > +++ b/tools/perf/util/Build
> > @@ -180,6 +180,7 @@ perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
> >  perf-y += data-convert-json.o
> >
> >  perf-y += scripting-engines/
> > +perf-y += workqueue/
> >
> >  perf-$(CONFIG_ZLIB) += zlib.o
> >  perf-$(CONFIG_LZMA) += lzma.o
> > diff --git a/tools/perf/util/workqueue/Build b/tools/perf/util/workqueue/Build
> > new file mode 100644
> > index 0000000000000000..8b72a6cd4e2cba0d
> > --- /dev/null
> > +++ b/tools/perf/util/workqueue/Build
> > @@ -0,0 +1 @@
> > +perf-y += threadpool.o
> > diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
> > new file mode 100644
> > index 0000000000000000..70c67569f956a3e2
> > --- /dev/null
> > +++ b/tools/perf/util/workqueue/threadpool.c
> > @@ -0,0 +1,175 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <unistd.h>
> > +#include <errno.h>
> > +#include <string.h>
> > +#include "debug.h"
> > +#include "asm/bug.h"
> > +#include "threadpool.h"
> > +
> > +enum threadpool_status {
> > +     THREADPOOL_STATUS__STOPPED,             /* no threads */
> > +     THREADPOOL_STATUS__ERROR,               /* errors */
> > +     THREADPOOL_STATUS__MAX
> > +};
> > +
> > +struct threadpool_struct {
>
> Can this be just 'struct threadpool'? I think its descriptive enough:
>
> > +     int                     nr_threads;     /* number of threads in the pool */
> > +     struct thread_struct    *threads;       /* array of threads in the pool */
> > +     struct task_struct      *current_task;  /* current executing function */

Does this mean it can only have a single function to run?
Why do we need it?


> > +     enum threadpool_status  status;         /* current status of the pool */
> > +};
> > +
> > +struct thread_struct {
> > +     int                             idx;    /* idx of thread in pool->threads */
> > +     pid_t                           tid;    /* tid of thread */
> > +     struct threadpool_struct        *pool;  /* parent threadpool */
> > +     struct {
> > +             int from[2];                    /* messages from thread (acks) */
> > +             int to[2];                      /* messages to thread (commands) */

It can be confusing if you think from the main thread.
Maybe 'ack' and 'cmd' would be better.


> > +     } pipes;
> > +};
>
> This one, since we have already a 'struct thread' in tools/perf, to
> represent a PERF_RECORD_FORK, perhaps we can call it 'struct threadpool_entry'?

I think we can even use 'worker' instead of 'thread' but it requires
huge renaming and conflicts so I won't insist on it strongly.  :)

Thanks,
Namhyung
