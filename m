Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24705C07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 14:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026B3613D0
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 14:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239449AbhGNOS7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 10:18:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232744AbhGNOS7 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 10:18:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6866561183;
        Wed, 14 Jul 2021 14:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626272167;
        bh=5IDQzlRZDLJVYxFYoYtmnzgVnGvBUgh5EN1MWgDyPP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EUhqb6feHAMW+laFoMRffVAICXg79+yk9WSLoTHUft13akoJVMaU5pS3PfImjjL91
         P5IEePb/4c1anzAJYVqUGobWVfVPbuCxBGlMfdCbsHtuY8X23PAad2iNdMhtabWLqM
         TZl5DKa4ganMNw6OUw88t/TYBESDBAapu4C0i4/ZA9DrtGD+43l0M+CYPNMfoypFUZ
         tswLjGUZs1ZWmKJE1NyNMx1HajFghG7acDTPvlmyZKpSVY1wwFnf3wFaBuvHSNIYAw
         425G4K89+DP6q//qV5sgPdLpcjulA0uTHPq+TzHN/jhkoblbimdJbnwpxLjkXUyI9s
         fDiy91pF5SySw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E052A403F2; Wed, 14 Jul 2021 11:16:04 -0300 (-03)
Date:   Wed, 14 Jul 2021 11:16:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and
 destruction
Message-ID: <YO7xpFg0F5Fv/7sI@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 02:11:12PM +0200, Riccardo Mancini escreveu:
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
>  tools/perf/util/workqueue/threadpool.c | 175 +++++++++++++++++++++++++
>  tools/perf/util/workqueue/threadpool.h |  19 +++
>  4 files changed, 196 insertions(+)
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
> index 0000000000000000..70c67569f956a3e2
> --- /dev/null
> +++ b/tools/perf/util/workqueue/threadpool.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include "debug.h"
> +#include "asm/bug.h"
> +#include "threadpool.h"
> +
> +enum threadpool_status {
> +	THREADPOOL_STATUS__STOPPED,		/* no threads */
> +	THREADPOOL_STATUS__ERROR,		/* errors */
> +	THREADPOOL_STATUS__MAX
> +};
> +
> +struct threadpool_struct {

Can this be just 'struct threadpool'? I think its descriptive enough:

> +	int			nr_threads;	/* number of threads in the pool */
> +	struct thread_struct	*threads;	/* array of threads in the pool */
> +	struct task_struct	*current_task;	/* current executing function */
> +	enum threadpool_status	status;		/* current status of the pool */
> +};
> +
> +struct thread_struct {
> +	int				idx;	/* idx of thread in pool->threads */
> +	pid_t				tid;	/* tid of thread */
> +	struct threadpool_struct	*pool;	/* parent threadpool */
> +	struct {
> +		int from[2];			/* messages from thread (acks) */
> +		int to[2];			/* messages to thread (commands) */
> +	} pipes;
> +};

This one, since we have already a 'struct thread' in tools/perf, to
represent a PERF_RECORD_FORK, perhaps we can call it 'struct threadpool_entry'?

> +
> +/**
> + * init_pipes - initialize all pipes of @thread
> + */
> +static void init_pipes(struct thread_struct *thread)
> +{
> +	thread->pipes.from[0] = -1;
> +	thread->pipes.from[1] = -1;
> +	thread->pipes.to[0] = -1;
> +	thread->pipes.to[1] = -1;
> +}
> +
> +/**
> + * open_pipes - open all pipes of @thread
> + */
> +static int open_pipes(struct thread_struct *thread)

Here please:

threadpool_entry__open_pipes()

Its longer, but helps with ctags/cscope navigation and we can go
directly to it via:

:ta threadpool_entry__open_p<TAB>

While 'ta: open_pipes' may bo to various places where this idiom is
used.

> +{
> +	if (pipe(thread->pipes.from)) {
> +		pr_err("threadpool: failed to create comm pipe 'from': %s\n",
> +			strerror(errno));
> +		return -ENOMEM;
> +	}
> +
> +	if (pipe(thread->pipes.to)) {
> +		pr_err("threadpool: failed to create comm pipe 'to': %s\n",
> +			strerror(errno));
> +		close(thread->pipes.from[0]);
> +		thread->pipes.from[0] = -1;
> +		close(thread->pipes.from[1]);
> +		thread->pipes.from[1] = -1;
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * close_pipes - close all communication pipes of @thread
> + */
> +static void close_pipes(struct thread_struct *thread)
> +{
> +	if (thread->pipes.from[0] != -1) {
> +		close(thread->pipes.from[0]);
> +		thread->pipes.from[0] = -1;
> +	}
> +	if (thread->pipes.from[1] != -1) {
> +		close(thread->pipes.from[1]);
> +		thread->pipes.from[1] = -1;
> +	}
> +	if (thread->pipes.to[0] != -1) {
> +		close(thread->pipes.to[0]);
> +		thread->pipes.to[0] = -1;
> +	}
> +	if (thread->pipes.to[1] != -1) {
> +		close(thread->pipes.to[1]);
> +		thread->pipes.to[1] = -1;
> +	}
> +}
> +
> +/**
> + * create_threadpool - create a fixed threadpool with @n_threads threads
> + */
> +struct threadpool_struct *create_threadpool(int n_threads)


Is this already something the kernel has and thus we should keep the
naming? I couldn't find it in the kernel, so please name it:

struct threadpool *threadpool__new(int nthreads)

> +{
> +	int ret, t;
> +	struct threadpool_struct *pool = malloc(sizeof(*pool));
> +
> +	if (!pool) {
> +		pr_err("threadpool: cannot allocate pool: %s\n",
> +			strerror(errno));o

Humm, pr_err() at this level isn't appropriate, please make callers
complain.

> +		return NULL;
> +	}
> +
> +	if (n_threads <= 0) {
> +		pr_err("threadpool: invalid number of threads: %d\n",
> +			n_threads);

pr_debug()

> +		goto out_free_pool;
> +	}
> +
> +	pool->nr_threads = n_threads;
> +	pool->current_task = NULL;
> +
> +	pool->threads = malloc(n_threads * sizeof(*pool->threads));
> +	if (!pool->threads) {
> +		pr_err("threadpool: cannot allocate threads: %s\n",
> +			strerror(errno));
> +		goto out_free_pool;
> +	}
> +
> +	for (t = 0; t < n_threads; t++) {
> +		pool->threads[t].idx = t;
> +		pool->threads[t].tid = -1;
> +		pool->threads[t].pool = pool;
> +		init_pipes(&pool->threads[t]);
> +	}
> +
> +	for (t = 0; t < n_threads; t++) {
> +		ret = open_pipes(&pool->threads[t]);
> +		if (ret)
> +			goto out_close_pipes;
> +	}
> +
> +	pool->status = THREADPOOL_STATUS__STOPPED;
> +
> +	return pool;
> +
> +out_close_pipes:
> +	for (t = 0; t < n_threads; t++)
> +		close_pipes(&pool->threads[t]);
> +
> +	free(pool->threads);
> +out_free_pool:
> +	free(pool);
> +	return NULL;

Here we can use ERR_PTR()/PTR_ERR() to let the caller know what was the
problem, i.e. we can ditch all the pr_err/pr_debug(), etc and instead
have a threadpool__strerror(struct threadpool *pool, int err) like we
have for 'struct evsel', please take a look at evsel__open_strerror().


> +}
> +
> +/**
> + * destroy_threadpool - free the @pool and all its resources
> + */
> +void destroy_threadpool(struct threadpool_struct *pool)


void threadpool__delete(struct threadpool *pool)
> +{
> +	int t;
> +
> +	if (!pool)
> +		return;
> +
> +	WARN_ON(pool->status != THREADPOOL_STATUS__STOPPED
> +		&& pool->status != THREADPOOL_STATUS__ERROR);
> +
> +	for (t = 0; t < pool->nr_threads; t++)
> +		close_pipes(&pool->threads[t]);

reset pool->threads[t] to -1

> +
> +	free(pool->threads);

zfree

> +	free(pool);
> +}
> +
> +/**
> + * threadpool_size - get number of threads in the threadpool
> + */
> +int threadpool_size(struct threadpool_struct *pool)
  
threadpool__size()

> +{
> +	return pool->nr_threads;
> +}
> diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
> new file mode 100644
> index 0000000000000000..2b9388c768a0b588
> --- /dev/null
> +++ b/tools/perf/util/workqueue/threadpool.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __WORKQUEUE_THREADPOOL_H
> +#define __WORKQUEUE_THREADPOOL_H
> +
> +struct threadpool_struct;
> +struct task_struct;
> +
> +typedef void (*task_func_t)(int tidx, struct task_struct *task);
> +
> +struct task_struct {
> +	task_func_t fn;
> +};
> +
> +extern struct threadpool_struct *create_threadpool(int n_threads);
> +extern void destroy_threadpool(struct threadpool_struct *pool);
> +
> +extern int threadpool_size(struct threadpool_struct *pool);
> +
> +#endif /* __WORKQUEUE_THREADPOOL_H */
> -- 
> 2.31.1
> 

-- 

- Arnaldo
