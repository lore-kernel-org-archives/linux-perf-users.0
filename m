Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52503C07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E7F5613C9
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232349AbhGNPZw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhGNPZw (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 11:25:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1637D600D1;
        Wed, 14 Jul 2021 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626276180;
        bh=ErxEyW8NtIlv3ONaJw/n1+m7LQJh/vqgQbCniL78/mU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWEZ9fA9tuPv07fut8CYaGphQQkxiVQ6mGarAcBae6gYRNGVteXAO1v4J83jDsf5Y
         IVEKsxbkeOF410Iz+/z5pMPsA2JDYVz92xhISiXrK5SK8dY/z5+mOratbvdKkDqKqc
         JzVfP6FXzuE9Lyt5pSHkIbNnUBHp7+EPtZAQ5nWUMHqO8rw6DcAjtgAixMsVUyUTuM
         HwuOX6+Nui/bs93j8Z6Ys/cEL0yXEYwC7PfKulBux9tARcYfRMPJUWNF2o5044FiCc
         qjXNQw9OoNmDJHW5GEtsMyN+vewTgI49xqSfqg4EnBqtJZe7dXMZqJEoJ335xjRH/R
         6B9R03NhhYajg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F615403F2; Wed, 14 Jul 2021 12:22:57 -0300 (-03)
Date:   Wed, 14 Jul 2021 12:22:57 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH 06/10] perf workqueue: introduce workqueue struct
Message-ID: <YO8BUfFe4iNo/awZ@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <efda4e29da6f6aa8c34a3751ed676c7ee0506cf8.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efda4e29da6f6aa8c34a3751ed676c7ee0506cf8.1626177381.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 02:11:17PM +0200, Riccardo Mancini escreveu:
> This patch adds the workqueue definition, along with simple creation and
> destruction functions.
> Furthermore, a simple subtest is added.
> 
> A workqueue is attached to a pool, on which it executes its workers.
> Next patches will introduce workers.
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/workqueue.c          |  92 +++++++++++++
>  tools/perf/util/workqueue/Build       |   1 +
>  tools/perf/util/workqueue/workqueue.c | 184 ++++++++++++++++++++++++++
>  tools/perf/util/workqueue/workqueue.h |  24 ++++
>  4 files changed, 301 insertions(+)
>  create mode 100644 tools/perf/util/workqueue/workqueue.c
>  create mode 100644 tools/perf/util/workqueue/workqueue.h
> 
> diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> index 3c64db8203556847..423dc8a92ca2563c 100644
> --- a/tools/perf/tests/workqueue.c
> +++ b/tools/perf/tests/workqueue.c
> @@ -5,6 +5,7 @@
>  #include "tests.h"
>  #include "util/debug.h"
>  #include "util/workqueue/threadpool.h"
> +#include "util/workqueue/workqueue.h"
>  
>  #define DUMMY_FACTOR 100000
>  #define N_DUMMY_WORK_SIZES 7
> @@ -13,6 +14,11 @@ struct threadpool_test_args_t {
>  	int pool_size;
>  };
>  
> +struct workqueue_test_args_t {
> +	int pool_size;
> +	int n_work_items;
> +};
> +
>  struct test_task {
>  	struct task_struct task;
>  	int n_threads;
> @@ -140,6 +146,58 @@ static int __test__threadpool(void *_args)
>  	return 0;
>  }
>  
> +
> +static int __workqueue__prepare(struct threadpool_struct **pool,
> +				struct workqueue_struct **wq,
> +				int pool_size)
> +{
> +	int ret;
> +
> +	ret = __threadpool__prepare(pool, pool_size);
> +	if (ret)
> +		return ret;
> +
> +	*wq = create_workqueue(*pool);
> +	TEST_ASSERT_VAL("workqueue creation failure", *wq);
> +	TEST_ASSERT_VAL("workqueue wrong size", workqueue_nr_threads(*wq) == pool_size);
> +	TEST_ASSERT_VAL("threadpool is not executing", threadpool_is_busy(*pool));
> +
> +	return 0;
> +}
> +
> +static int __workqueue__teardown(struct threadpool_struct *pool,
> +				struct workqueue_struct *wq)
> +{
> +	int ret;
> +
> +	ret = destroy_workqueue(wq);
> +	TEST_ASSERT_VAL("workqueue detruction failure", ret == 0);
> +
> +	ret = __threadpool__teardown(pool);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int __test__workqueue(void *_args)
> +{
> +	struct workqueue_test_args_t *args = _args;
> +	struct threadpool_struct *pool;
> +	struct workqueue_struct *wq;
> +	int ret;
> +
> +	ret = __workqueue__prepare(&pool, &wq, args->pool_size);
> +	if (ret)
> +		return ret;
> +
> +	ret = __workqueue__teardown(pool, wq);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static const struct threadpool_test_args_t threadpool_test_args[] = {
>  	{
>  		.pool_size = 1
> @@ -158,6 +216,33 @@ static const struct threadpool_test_args_t threadpool_test_args[] = {
>  	}
>  };
>  
> +static const struct workqueue_test_args_t workqueue_test_args[] = {
> +	{
> +		.pool_size = 1,
> +		.n_work_items = 1
> +	},
> +	{
> +		.pool_size = 1,
> +		.n_work_items = 10
> +	},
> +	{
> +		.pool_size = 2,
> +		.n_work_items = 1
> +	},
> +	{
> +		.pool_size = 2,
> +		.n_work_items = 100
> +	},
> +	{
> +		.pool_size = 16,
> +		.n_work_items = 7
> +	},
> +	{
> +		.pool_size = 16,
> +		.n_work_items = 2789
> +	}
> +};
> +
>  struct test_case {
>  	const char *desc;
>  	int (*func)(void *args);
> @@ -173,6 +258,13 @@ static struct test_case workqueue_testcase_table[] = {
>  		.args = (void *) threadpool_test_args,
>  		.n_args = (int)ARRAY_SIZE(threadpool_test_args),
>  		.arg_size = sizeof(struct threadpool_test_args_t)
> +	},
> +	{
> +		.desc = "Workqueue",
> +		.func = __test__workqueue,
> +		.args = (void *) workqueue_test_args,
> +		.n_args = (int)ARRAY_SIZE(workqueue_test_args),
> +		.arg_size = sizeof(struct workqueue_test_args_t)
>  	}
>  };
>  
> diff --git a/tools/perf/util/workqueue/Build b/tools/perf/util/workqueue/Build
> index 8b72a6cd4e2cba0d..4af721345c0a6bb7 100644
> --- a/tools/perf/util/workqueue/Build
> +++ b/tools/perf/util/workqueue/Build
> @@ -1 +1,2 @@
>  perf-y += threadpool.o
> +perf-y += workqueue.o
> diff --git a/tools/perf/util/workqueue/workqueue.c b/tools/perf/util/workqueue/workqueue.c
> new file mode 100644
> index 0000000000000000..5099252a0662e788
> --- /dev/null
> +++ b/tools/perf/util/workqueue/workqueue.c
> @@ -0,0 +1,184 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <pthread.h>
> +#include <linux/list.h>
> +#include "debug.h"
> +#include "workqueue.h"
> +
> +enum workqueue_status {
> +	WORKQUEUE_STATUS__READY,	/* wq is ready to receive work */
> +	WORKQUEUE_STATUS__ERROR,
> +	WORKQUEUE_STATUS__MAX
> +};
> +
> +struct workqueue_struct {
> +	pthread_mutex_t		lock;		/* locking of the thread_pool */
> +	pthread_cond_t		idle_cond;	/* all workers are idle cond */
> +	struct threadpool_struct *pool;		/* underlying pool */
> +	struct task_struct	task;		/* threadpool task */
> +	struct list_head	busy_list;	/* busy workers */
> +	struct list_head	idle_list;	/* idle workers */
> +	struct list_head	pending;	/* pending work items */
> +	int			msg_pipe[2];	/* main thread comm pipes */
> +	enum workqueue_status	status;
> +};
> +
> +/**
> + * worker_thread - worker function executed on threadpool
> + */
> +static void worker_thread(int tidx, struct task_struct *task)
> +{
> +	struct workqueue_struct *wq = container_of(task, struct workqueue_struct, task);
> +
> +	pr_debug("hi from worker %d. Pool is in status %d\n", tidx, wq->status);
> +}
> +
> +/**
> + * attach_threadpool_to_workqueue - start @wq workers on @pool
> + */
> +static int attach_threadpool_to_workqueue(struct workqueue_struct *wq,
> +					struct threadpool_struct *pool)
> +{
> +	int err;
> +
> +	if (!threadpool_is_ready(pool)) {
> +		pr_err("workqueue: cannot attach to pool: pool is not ready\n");
> +		return -1;
> +	}
> +
> +	wq->pool = pool;
> +
> +	err = execute_in_threadpool(pool, &wq->task);
> +	if (err)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/**
> + * detach_threadpool_from_workqueue - stop @wq workers on @pool
> + */
> +static int detach_threadpool_from_workqueue(struct workqueue_struct *wq)
> +{
> +	int ret, err = 0;
> +
> +	if (wq->status != WORKQUEUE_STATUS__READY) {
> +		pr_err("workqueue: cannot attach to pool: wq is not ready\n");
> +		return -1;
> +	}
> +
> +	ret = wait_threadpool(wq->pool);
> +	if (ret) {
> +		pr_err("workqueue: error waiting threadpool\n");
> +		err = -1;
> +	}
> +
> +	wq->pool = NULL;
> +	return err;
> +}
> +
> +/**
> + * create_workqueue - create a workqueue associated to @pool
> + *
> + * Only one workqueue can execute on a pool at a time.
> + */
> +struct workqueue_struct *create_workqueue(struct threadpool_struct *pool)

I wonder if we should use the exact same kernel signature and not pass a
threadpool, essentially having just one threadpool in tools/perf/ that
is used by create_workqueue(void)?

> +{
> +	int err;
> +	struct workqueue_struct *wq = malloc(sizeof(struct workqueue_struct));
> +
> +
> +	err = pthread_mutex_init(&wq->lock, NULL);
> +	if (err)
> +		goto out_free_wq;
> +
> +	err = pthread_cond_init(&wq->idle_cond, NULL);
> +	if (err)
> +		goto out_destroy_mutex;
> +
> +	wq->pool = NULL;
> +	INIT_LIST_HEAD(&wq->busy_list);
> +	INIT_LIST_HEAD(&wq->idle_list);
> +
> +	INIT_LIST_HEAD(&wq->pending);
> +
> +	err = pipe(wq->msg_pipe);
> +	if (err)
> +		goto out_destroy_cond;
> +
> +	wq->task.fn = worker_thread;
> +
> +	err = attach_threadpool_to_workqueue(wq, pool);
> +	if (err)
> +		goto out_destroy_cond;
> +
> +	wq->status = WORKQUEUE_STATUS__READY;
> +
> +	return wq;
> +
> +out_destroy_cond:
> +	pthread_cond_destroy(&wq->idle_cond);
> +out_destroy_mutex:
> +	pthread_mutex_destroy(&wq->lock);
> +out_free_wq:
> +	free(wq);
> +	return NULL;
> +}
> +
> +/**
> + * destroy_workqueue - stop @wq workers and destroy @wq
> + */
> +int destroy_workqueue(struct workqueue_struct *wq)
> +{
> +	int err = 0, ret;
> +
> +	ret = detach_threadpool_from_workqueue(wq);
> +	if (ret) {
> +		pr_err("workqueue: error detaching from threadpool.\n");
> +		err = -1;
> +	}
> +
> +	ret = pthread_mutex_destroy(&wq->lock);
> +	if (ret) {
> +		err = -1;
> +		pr_err("workqueue: error pthread_mutex_destroy: %s\n",
> +			strerror(errno));
> +	}
> +
> +	ret = pthread_cond_destroy(&wq->idle_cond);
> +	if (ret) {
> +		err = -1;
> +		pr_err("workqueue: error pthread_cond_destroy: %s\n",
> +			strerror(errno));
> +	}
> +
> +	ret = close(wq->msg_pipe[0]);
> +	if (ret) {
> +		err = -1;
> +		pr_err("workqueue: error close msg_pipe[0]: %s\n",
> +			strerror(errno));
> +	}
> +
> +	ret = close(wq->msg_pipe[1]);
> +	if (ret) {
> +		err = -1;
> +		pr_err("workqueue: error close msg_pipe[1]: %s\n",
> +			strerror(errno));
> +	}
> +
> +	free(wq);
> +
> +	return err;
> +}
> +
> +/**
> + * workqueue_nr_threads - get size of threadpool underlying @wq
> + */
> +int workqueue_nr_threads(struct workqueue_struct *wq)
> +{
> +	return threadpool_size(wq->pool);
> +}
> diff --git a/tools/perf/util/workqueue/workqueue.h b/tools/perf/util/workqueue/workqueue.h
> new file mode 100644
> index 0000000000000000..86ec1d69274f41db
> --- /dev/null
> +++ b/tools/perf/util/workqueue/workqueue.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __WORKQUEUE_WORKQUEUE_H
> +#define __WORKQUEUE_WORKQUEUE_H
> +
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <linux/list.h>
> +#include "threadpool.h"
> +
> +struct work_struct;
> +typedef void (*work_func_t)(struct work_struct *work);
> +
> +struct work_struct {
> +	struct list_head entry;
> +	work_func_t func;
> +};
> +
> +struct workqueue_struct;
> +
> +extern struct workqueue_struct *create_workqueue(struct threadpool_struct *pool);
> +extern int destroy_workqueue(struct workqueue_struct *wq);
> +
> +extern int workqueue_nr_threads(struct workqueue_struct *wq);
> +#endif /* __WORKQUEUE_WORKQUEUE_H */
> -- 
> 2.31.1
> 

-- 

- Arnaldo
