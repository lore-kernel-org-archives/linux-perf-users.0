Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA63C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EFF161167
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:25:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhHGCZW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:25:22 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:35640 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhHGCZW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 22:25:22 -0400
Received: by mail-lf1-f41.google.com with SMTP id c16so21649721lfc.2;
        Fri, 06 Aug 2021 19:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO6Ft3x4wdD+Qi4/Mq7hzsh4s/CmEKiBMSvOY+GSzdI=;
        b=GyvxOr1a1hvllAK32IRzYJvbwmqJwKaH3RjhaYtIHwMIBBG52UJ8cCAskUm9HC6j9W
         cHeWAwBDe3fNx/S33BtsNKNKJKqjYpb2M7LRKyjSa4kQ+cQ8gFIQj9UZVxAX628+uAl6
         VX9HFA61ruNBWotd3mOiQjP74oX+Q/t8QvVrfmpn19Kqnrofb9huwIS8KUA2r/5oKxzu
         m70Wn+5cjS0uyA/Y1HTLfEfePKzvDdPo96b0lX6FpG6AXSmOy4aKlULPlrrbbh2QSwVo
         VeVfjA8HXoIiGclwcL1wE7GVWkmQFgsQTTYCzI0Tbzq0SdIuGW44wzkhPafvlo8MG54t
         9vJg==
X-Gm-Message-State: AOAM531+8pUirjSidMfazxD2CqKzX5+LXBpWCMDZ39TxWo2LGc2neIlQ
        vEJyA2uDkxqyhzEBwTSBBhH6+O7DUsf9R842bas=
X-Google-Smtp-Source: ABdhPJyhMplD2vQlCwu02dmFDSfmFeIwjqjnZ+i5plwVkN94lGOTufoaXDo5TnYacHSsMchbp9gjAxPXKCTOvU5mLLY=
X-Received: by 2002:a05:6512:3456:: with SMTP id j22mr9342820lfr.635.1628303103564;
 Fri, 06 Aug 2021 19:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627657061.git.rickyman7@gmail.com> <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
In-Reply-To: <4f0cd6c8e77c0b4f4d4b8d553a7032757b976e61.1627657061.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Aug 2021 19:24:52 -0700
Message-ID: <CAM9d7ci0LcdTZyDu5sxGkaS07Z-m4hvr2xU4TDK_aTRAJm7b7A@mail.gmail.com>
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

Hi Riccardo,

On Fri, Jul 30, 2021 at 8:34 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> The workqueue library is made up by two components:
>  - threadpool: handles the lifetime of the threads
>  - workqueue: handles work distribution among the threads
>
> This first patch introduces the threadpool, starting from its creation
> and destruction functions.
> Thread management is based on the prototype from Alexey:
> https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
>
> Each thread in the threadpool executes the same function (aka task)
> with a different argument tidx.
> Threads use a pair of pipes to communicate with the main process.
> The threadpool is static (all threads will be spawned at the same time).
> Future work could include making it resizable and adding affinity support
> (as in Alexey prototype).
>
> Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/Build                  |   1 +
>  tools/perf/util/workqueue/Build        |   1 +
>  tools/perf/util/workqueue/threadpool.c | 208 +++++++++++++++++++++++++
>  tools/perf/util/workqueue/threadpool.h |  30 ++++
>  4 files changed, 240 insertions(+)
>  create mode 100644 tools/perf/util/workqueue/Build
>  create mode 100644 tools/perf/util/workqueue/threadpool.c
>  create mode 100644 tools/perf/util/workqueue/threadpool.h
>
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 2d4fa13041789cd6..c7b09701661c869d 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -180,6 +180,7 @@ perf-$(CONFIG_LIBBABELTRACE) += data-convert-bt.o
>  perf-y += data-convert-json.o
>
>  perf-y += scripting-engines/
> +perf-y += workqueue/
>
>  perf-$(CONFIG_ZLIB) += zlib.o
>  perf-$(CONFIG_LZMA) += lzma.o
> diff --git a/tools/perf/util/workqueue/Build b/tools/perf/util/workqueue/Build
> new file mode 100644
> index 0000000000000000..8b72a6cd4e2cba0d
> --- /dev/null
> +++ b/tools/perf/util/workqueue/Build
> @@ -0,0 +1 @@
> +perf-y += threadpool.o
> diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
> new file mode 100644
> index 0000000000000000..0004ce606d5fa73d
> --- /dev/null
> +++ b/tools/perf/util/workqueue/threadpool.c
> @@ -0,0 +1,208 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include "debug.h"
> +#include <asm/bug.h>
> +#include <linux/zalloc.h>
> +#include <linux/string.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include "threadpool.h"
> +
> +enum threadpool_status {
> +       THREADPOOL_STATUS__STOPPED,             /* no threads */
> +       THREADPOOL_STATUS__ERROR,               /* errors */
> +       THREADPOOL_STATUS__MAX
> +};
> +
> +struct threadpool {
> +       int                     nr_threads;     /* number of threads in the pool */
> +       struct threadpool_entry *threads;       /* array of threads in the pool */
> +       struct task_struct      *current_task;  /* current executing function */
> +       enum threadpool_status  status;         /* current status of the pool */

Better to move to below the nr_threads for alignment.


> +};
> +
> +struct threadpool_entry {
> +       int                             idx;    /* idx of thread in pool->threads */
> +       pid_t                           tid;    /* tid of thread */
> +       struct threadpool               *pool;  /* parent threadpool */
> +       struct {
> +               int ack[2];                     /* messages from thread (acks) */
> +               int cmd[2];                     /* messages to thread (commands) */
> +       } pipes;
> +};
> +
> +/**
> + * threadpool_entry__init_pipes - initialize all pipes of @thread
> + */
> +static void threadpool_entry__init_pipes(struct threadpool_entry *thread)
> +{
> +       thread->pipes.ack[0] = -1;
> +       thread->pipes.ack[1] = -1;
> +       thread->pipes.cmd[0] = -1;
> +       thread->pipes.cmd[1] = -1;
> +}
> +
> +/**
> + * threadpool_entry__open_pipes - open all pipes of @thread
> + */
> +static int threadpool_entry__open_pipes(struct threadpool_entry *thread)
> +{
> +       if (pipe(thread->pipes.ack)) {
> +               pr_debug2("threadpool: failed to create comm pipe 'from': %s\n",
> +                       strerror(errno));
> +               return -ENOMEM;
> +       }
> +
> +       if (pipe(thread->pipes.cmd)) {
> +               pr_debug2("threadpool: failed to create comm pipe 'to': %s\n",
> +                       strerror(errno));
> +               close(thread->pipes.ack[0]);
> +               thread->pipes.ack[0] = -1;
> +               close(thread->pipes.ack[1]);
> +               thread->pipes.ack[1] = -1;

Maybe you don't need to do it here if the caller handles it already ...

> +               return -ENOMEM;
> +       }
> +
> +       return 0;
> +}
> +
> +/**
> + * threadpool_entry__close_pipes - close all communication pipes of @thread
> + */
> +static void threadpool_entry__close_pipes(struct threadpool_entry *thread)
> +{
> +       if (thread->pipes.ack[0] != -1) {
> +               close(thread->pipes.ack[0]);
> +               thread->pipes.ack[0] = -1;
> +       }
> +       if (thread->pipes.ack[1] != -1) {
> +               close(thread->pipes.ack[1]);
> +               thread->pipes.ack[1] = -1;
> +       }
> +       if (thread->pipes.cmd[0] != -1) {
> +               close(thread->pipes.cmd[0]);
> +               thread->pipes.cmd[0] = -1;
> +       }
> +       if (thread->pipes.cmd[1] != -1) {
> +               close(thread->pipes.cmd[1]);
> +               thread->pipes.cmd[1] = -1;
> +       }
> +}
> +
> +/**
> + * threadpool__new - create a fixed threadpool with @n_threads threads
> + */
> +struct threadpool *threadpool__new(int n_threads)
> +{
> +       int ret, err, t;
> +       struct threadpool *pool = malloc(sizeof(*pool));
> +
> +       if (!pool) {
> +               pr_debug2("threadpool: cannot allocate pool: %s\n",
> +                       strerror(errno));
> +               err = -ENOMEM;
> +               goto out_return;
> +       }
> +
> +       if (n_threads <= 0) {
> +               pr_debug2("threadpool: invalid number of threads: %d\n",
> +                       n_threads);
> +               err = -EINVAL;
> +               goto out_free_pool;

Isn't' it natural to check it before the allocation?

> +       }
> +
> +       pool->nr_threads = n_threads;
> +       pool->current_task = NULL;
> +
> +       pool->threads = calloc(n_threads, sizeof(*pool->threads));
> +       if (!pool->threads) {
> +               pr_debug2("threadpool: cannot allocate threads: %s\n",
> +                       strerror(errno));
> +               err = -ENOMEM;
> +               goto out_free_pool;
> +       }
> +
> +       for (t = 0; t < n_threads; t++) {
> +               pool->threads[t].idx = t;
> +               pool->threads[t].tid = -1;
> +               pool->threads[t].pool = pool;
> +               threadpool_entry__init_pipes(&pool->threads[t]);
> +       }
> +
> +       for (t = 0; t < n_threads; t++) {
> +               ret = threadpool_entry__open_pipes(&pool->threads[t]);
> +               if (ret) {
> +                       err = -ret;
> +                       goto out_close_pipes;

... like this.  But threadpool_entry__open_pipes() already
returns a negative.

> +               }
> +       }
> +
> +       pool->status = THREADPOOL_STATUS__STOPPED;
> +
> +       return pool;
> +
> +out_close_pipes:
> +       for (t = 0; t < n_threads; t++)
> +               threadpool_entry__close_pipes(&pool->threads[t]);
> +
> +       zfree(&pool->threads);
> +out_free_pool:
> +       free(pool);
> +out_return:
> +       return ERR_PTR(err);
> +}
> +
> +/**
> + * threadpool__strerror - print message regarding given @err in @pool
> + *
> + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> + */
> +int threadpool__strerror(struct threadpool *pool __maybe_unused, int err, char *buf, size_t size)
> +{
> +       char sbuf[STRERR_BUFSIZE], *emsg;
> +
> +       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> +       return scnprintf(buf, size, "Error: %s.\n", emsg);
> +}
> +
> +/**
> + * threadpool__new_strerror - print message regarding @err_ptr
> + *
> + * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> + */
> +int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t size)
> +{
> +       return threadpool__strerror(err_ptr, PTR_ERR(err_ptr), buf, size);
> +}

Why two different functions?

> +
> +/**
> + * threadpool__delete - free the @pool and all its resources
> + */
> +void threadpool__delete(struct threadpool *pool)
> +{
> +       int t;
> +
> +       if (IS_ERR_OR_NULL(pool))
> +               return;
> +
> +       WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
> +               && pool->status != THREADPOOL_STATUS__ERROR);
> +
> +       for (t = 0; t < pool->nr_threads; t++)
> +               threadpool_entry__close_pipes(&pool->threads[t]);
> +
> +       zfree(&pool->threads);
> +       free(pool);
> +}
> +
> +/**
> + * threadpool__size - get number of threads in the threadpool
> + */
> +int threadpool__size(struct threadpool *pool)
> +{
> +       return pool->nr_threads;
> +}
> diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
> new file mode 100644
> index 0000000000000000..fb18aa32fb64f671
> --- /dev/null
> +++ b/tools/perf/util/workqueue/threadpool.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __WORKQUEUE_THREADPOOL_H
> +#define __WORKQUEUE_THREADPOOL_H
> +
> +struct threadpool;
> +struct task_struct;

You can just move the definition here.

> +
> +typedef void (*task_func_t)(int tidx, struct task_struct *task);
> +
> +struct task_struct {
> +       task_func_t fn;
> +};
> +
> +extern struct threadpool *threadpool__new(int n_threads);
> +extern void threadpool__delete(struct threadpool *pool);
> +
> +extern int threadpool__start(struct threadpool *pool);
> +extern int threadpool__stop(struct threadpool *pool);
> +
> +extern int threadpool__execute(struct threadpool *pool, struct task_struct *task);
> +extern int threadpool__wait(struct threadpool *pool);

These are not defined yet.

> +
> +extern int threadpool__size(struct threadpool *pool);
> +
> +/* Error management */
> +#define THREADPOOL_STRERR_BUFSIZE (128+STRERR_BUFSIZE)
> +extern int threadpool__strerror(struct threadpool *pool, int err, char *buf, size_t size);
> +extern int threadpool__new_strerror(struct threadpool *err_ptr, char *buf, size_t size);
> +
> +#endif /* __WORKQUEUE_THREADPOOL_H */
> --
> 2.31.1
>
