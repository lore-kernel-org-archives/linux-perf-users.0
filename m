Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F2FC636C9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7DBE613D9
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 20:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGOUt6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 16:49:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230165AbhGOUt6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 16:49:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B080613D4;
        Thu, 15 Jul 2021 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626382024;
        bh=DzOqBO0a1W1oxkZNxSUywrONmNC/88IWEjkZxmu9HJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8OUzu2YqoVlSZW4AQjc1EXlvWAhIBK2xn8WaPhW1KOVC7PkRNaPtDR9AMtKW9MMd
         1xDpqqxoMd40KuGOZzUX7Hm0LNwPPO9icMROhvhzBJWF/obENSHxfM7VQERqIn77vO
         41cSjpAZss7ZE3La05U9EFSRGRpuORtvJUDS5+ywUnO0LJ/+e8x3VUZZtCiAWx8i1O
         /LcbDtwRycsykCWYszYunyk6SuWy7IhUaOcRo9b+lbqeOivq/PA8n0yzBJskb6CUW+
         sb00eoV2ITvuXLV4nljPgAa+gSvUNtdPgSprhgxOq/XEruKPq7zqaTlaM7YVGun2Fu
         MEkcUjPETWg5Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D24F403F2; Thu, 15 Jul 2021 17:47:01 -0300 (-03)
Date:   Thu, 15 Jul 2021 17:47:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 06/10] perf workqueue: introduce workqueue struct
Message-ID: <YPCexbV0O1PoNCJF@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <efda4e29da6f6aa8c34a3751ed676c7ee0506cf8.1626177381.git.rickyman7@gmail.com>
 <YO8BUfFe4iNo/awZ@kernel.org>
 <d39def9e5c3edd6292d86c90036fd79a2406db1d.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d39def9e5c3edd6292d86c90036fd79a2406db1d.camel@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Jul 15, 2021 at 06:49:57PM +0200, Riccardo Mancini escreveu:
> Hi Arnaldo,
> thanks again for having a look at this patchset!
> 
> On Wed, 2021-07-14 at 12:22 -0300, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Jul 13, 2021 at 02:11:17PM +0200, Riccardo Mancini escreveu:
> > > This patch adds the workqueue definition, along with simple creation and
> > > destruction functions.
> > > Furthermore, a simple subtest is added.
> > > 
> > > A workqueue is attached to a pool, on which it executes its workers.
> > > Next patches will introduce workers.
> > > 
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > 
> <SNIP>
> > > +
> > > +/**
> > > + * create_workqueue - create a workqueue associated to @pool
> > > + *
> > > + * Only one workqueue can execute on a pool at a time.
> > > + */
> > > +struct workqueue_struct *create_workqueue(struct threadpool_struct *pool)
> > 
> > I wonder if we should use the exact same kernel signature and not pass a
> > threadpool, essentially having just one threadpool in tools/perf/ that
> > is used by create_workqueue(void)?
> 
> I wondered the same thing, but I thought that we'd need it to be dynamically
> created to prevent spawning threads at the beginning that might not even be
> used.
> I think this could be a follow-up patch.

I see your point.

My practice is to use the perf convention for things that don't come
from the kernel, and if we do as I suggested, tooling will probably not
even see this threadpool struct, i.e. just the workqueue APIs are
exposed and workqueue_create() will notice that a threadpool is not yet
created, doing its creation behind tooling's back.

- Arnaldo
 
> Thanks,
> Riccardo
> 
> > 
> > > +{
> > > +       int err;
> > > +       struct workqueue_struct *wq = malloc(sizeof(struct
> > > workqueue_struct));
> > > +
> > > +
> > > +       err = pthread_mutex_init(&wq->lock, NULL);
> > > +       if (err)
> > > +               goto out_free_wq;
> > > +
> > > +       err = pthread_cond_init(&wq->idle_cond, NULL);
> > > +       if (err)
> > > +               goto out_destroy_mutex;
> > > +
> > > +       wq->pool = NULL;
> > > +       INIT_LIST_HEAD(&wq->busy_list);
> > > +       INIT_LIST_HEAD(&wq->idle_list);
> > > +
> > > +       INIT_LIST_HEAD(&wq->pending);
> > > +
> > > +       err = pipe(wq->msg_pipe);
> > > +       if (err)
> > > +               goto out_destroy_cond;
> > > +
> > > +       wq->task.fn = worker_thread;
> > > +
> > > +       err = attach_threadpool_to_workqueue(wq, pool);
> > > +       if (err)
> > > +               goto out_destroy_cond;
> > > +
> > > +       wq->status = WORKQUEUE_STATUS__READY;
> > > +
> > > +       return wq;
> > > +
> > > +out_destroy_cond:
> > > +       pthread_cond_destroy(&wq->idle_cond);
> > > +out_destroy_mutex:
> > > +       pthread_mutex_destroy(&wq->lock);
> > > +out_free_wq:
> > > +       free(wq);
> > > +       return NULL;
> > > +}
> > > +
> > > +/**
> > > + * destroy_workqueue - stop @wq workers and destroy @wq
> > > + */
> > > +int destroy_workqueue(struct workqueue_struct *wq)
> > > +{
> > > +       int err = 0, ret;
> > > +
> > > +       ret = detach_threadpool_from_workqueue(wq);
> > > +       if (ret) {
> > > +               pr_err("workqueue: error detaching from threadpool.\n");
> > > +               err = -1;
> > > +       }
> > > +
> > > +       ret = pthread_mutex_destroy(&wq->lock);
> > > +       if (ret) {
> > > +               err = -1;
> > > +               pr_err("workqueue: error pthread_mutex_destroy: %s\n",
> > > +                       strerror(errno));
> > > +       }
> > > +
> > > +       ret = pthread_cond_destroy(&wq->idle_cond);
> > > +       if (ret) {
> > > +               err = -1;
> > > +               pr_err("workqueue: error pthread_cond_destroy: %s\n",
> > > +                       strerror(errno));
> > > +       }
> > > +
> > > +       ret = close(wq->msg_pipe[0]);
> > > +       if (ret) {
> > > +               err = -1;
> > > +               pr_err("workqueue: error close msg_pipe[0]: %s\n",
> > > +                       strerror(errno));
> > > +       }
> > > +
> > > +       ret = close(wq->msg_pipe[1]);
> > > +       if (ret) {
> > > +               err = -1;
> > > +               pr_err("workqueue: error close msg_pipe[1]: %s\n",
> > > +                       strerror(errno));
> > > +       }
> > > +
> > > +       free(wq);
> > > +
> > > +       return err;
> > > +}
> > > +
> > > +/**
> > > + * workqueue_nr_threads - get size of threadpool underlying @wq
> > > + */
> > > +int workqueue_nr_threads(struct workqueue_struct *wq)
> > > +{
> > > +       return threadpool_size(wq->pool);
> > > +}
> > > diff --git a/tools/perf/util/workqueue/workqueue.h
> > > b/tools/perf/util/workqueue/workqueue.h
> > > new file mode 100644
> > > index 0000000000000000..86ec1d69274f41db
> > > --- /dev/null
> > > +++ b/tools/perf/util/workqueue/workqueue.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef __WORKQUEUE_WORKQUEUE_H
> > > +#define __WORKQUEUE_WORKQUEUE_H
> > > +
> > > +#include <stdlib.h>
> > > +#include <sys/types.h>
> > > +#include <linux/list.h>
> > > +#include "threadpool.h"
> > > +
> > > +struct work_struct;
> > > +typedef void (*work_func_t)(struct work_struct *work);
> > > +
> > > +struct work_struct {
> > > +       struct list_head entry;
> > > +       work_func_t func;
> > > +};
> > > +
> > > +struct workqueue_struct;
> > > +
> > > +extern struct workqueue_struct *create_workqueue(struct threadpool_struct
> > > *pool);
> > > +extern int destroy_workqueue(struct workqueue_struct *wq);
> > > +
> > > +extern int workqueue_nr_threads(struct workqueue_struct *wq);
> > > +#endif /* __WORKQUEUE_WORKQUEUE_H */
> > > -- 
> > > 2.31.1
> > > 
> > 
> 
> 

-- 

- Arnaldo
