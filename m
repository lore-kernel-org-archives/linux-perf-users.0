Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC190C07E9A
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDADB613CC
	for <linux-perf-users@archiver.kernel.org>; Wed, 14 Jul 2021 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbhGNPSi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 14 Jul 2021 11:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232308AbhGNPSi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 14 Jul 2021 11:18:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 26D94613B6;
        Wed, 14 Jul 2021 15:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626275746;
        bh=vhN5DF8QG1sc2aWzww5O6JQxBp3WxOlMoOWjR8zyb5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBYCB0WQeOXvCXTpz2kNfwArhTY9CLyzUQUPnRA72DaRDwX98QdjX9kPy4+YADkw/
         y6S7ZpW7xYwQT878gZKZvO4mlC+9WR9oJ2ufWgljeuFq0qGan4T24Cv/3YQ7Jo0znn
         WzcfVdMBXHzXyRYcfMQ9e+X9QKH7M4Vn18p7v2ALzJemf66R6Z63/LKNmS/uSiyjmA
         riAr7Qt7ToCjiai8t9oxGF8HfMWLvwR5KHigB+e3A9tYFB5lujLhzG1/RCAE5rbO93
         +m9CnJgKB0ZZKFwXzvP2GuD7pTYf/TAGdxOiMTrqBNSmFDrtWdYiPmctTvsKHtUvbQ
         hMWM3CP3gFJHQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89F70403F2; Wed, 14 Jul 2021 12:15:43 -0300 (-03)
Date:   Wed, 14 Jul 2021 12:15:43 -0300
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
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop
 functions
Message-ID: <YO7/n4YAy/R08Wss@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
 <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 13, 2021 at 02:11:14PM +0200, Riccardo Mancini escreveu:
> This patch adds the start and stop functions, alongside the thread
> function.
> Each thread will run until a stop signal is received.
> Furthermore, start and stop are added to the test.
> 
> Thread management is based on the prototype from Alexey:
> https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> 
> Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/workqueue.c           |  13 ++
>  tools/perf/util/workqueue/threadpool.c | 238 +++++++++++++++++++++++++
>  tools/perf/util/workqueue/threadpool.h |   5 +
>  3 files changed, 256 insertions(+)
> 
> diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> index 1bd4d78c13eb3b14..be377e9897bab4e9 100644
> --- a/tools/perf/tests/workqueue.c
> +++ b/tools/perf/tests/workqueue.c
> @@ -10,16 +10,29 @@ struct threadpool_test_args_t {
>  
>  static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
>  {
> +	int ret;
> +
>  	*pool = create_threadpool(pool_size);
>  	TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
>  	TEST_ASSERT_VAL("threadpool size is wrong",
>  			threadpool_size(*pool) == pool_size);
>  
> +	ret = start_threadpool(*pool);
> +	TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> +	TEST_ASSERT_VAL("threadpool is not ready", threadpool_is_ready(*pool));
> +
>  	return 0;
>  }
>  
>  static int __threadpool__teardown(struct threadpool_struct *pool)
>  {
> +	int ret;
> +
> +	ret = stop_threadpool(pool);

	int ret = stop_threadpool(pool);

> +	TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> +	TEST_ASSERT_VAL("stopped threadpool is ready",
> +			!threadpool_is_ready(pool));
> +
>  	destroy_threadpool(pool);
>  
>  	return 0;
> diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
> index 70c67569f956a3e2..f4635ff782b9388e 100644
> --- a/tools/perf/util/workqueue/threadpool.c
> +++ b/tools/perf/util/workqueue/threadpool.c
> @@ -4,12 +4,23 @@
>  #include <unistd.h>
>  #include <errno.h>
>  #include <string.h>
> +#include <pthread.h>
> +#include <signal.h>
> +#include <syscall.h>
>  #include "debug.h"
>  #include "asm/bug.h"
>  #include "threadpool.h"
>  
> +#ifndef HAVE_GETTID
> +static inline pid_t gettid(void)
> +{
> +	return (pid_t)syscall(__NR_gettid);
> +}
> +#endif

Isn't this defined elsewhere? Yeah, when we decide to move it to
tools/lib/workqueue/ we'll need it, but for now, reduce patch size.

>  enum threadpool_status {
>  	THREADPOOL_STATUS__STOPPED,		/* no threads */
> +	THREADPOOL_STATUS__READY,		/* threads are ready but idle */
>  	THREADPOOL_STATUS__ERROR,		/* errors */
>  	THREADPOOL_STATUS__MAX
>  };
> @@ -31,6 +42,21 @@ struct thread_struct {
>  	} pipes;
>  };
>  
> +enum thread_msg {
> +	THREAD_MSG__UNDEFINED = 0,
> +	THREAD_MSG__ACK,		/* from th: create and exit ack */
> +	THREAD_MSG__WAKE,		/* to th: wake up */
> +	THREAD_MSG__STOP,		/* to th: exit */
> +	THREAD_MSG__MAX
> +};
> +
> +static const char * const thread_msg_tags[] = {
> +	"undefined",
> +	"ack",
> +	"wake",
> +	"stop"
> +};
> +
>  /**
>   * init_pipes - initialize all pipes of @thread
>   */
> @@ -89,6 +115,113 @@ static void close_pipes(struct thread_struct *thread)
>  	}
>  }
>  
> +/**
> + * wait_thread - receive ack from thread
> + *
> + * NB: call only from main thread!
> + */
> +static int wait_thread(struct thread_struct *thread)
> +{
> +	int res;
> +	enum thread_msg msg = THREAD_MSG__UNDEFINED;
> +
> +	res = read(thread->pipes.from[0], &msg, sizeof(msg));

	int res = read(thread->pipes.from[0], &msg, sizeof(msg));

> +	if (res < 0) {
> +		pr_err("threadpool: failed to recv msg from tid=%d: %s\n",
> +		       thread->tid, strerror(errno));
> +		return -1;
> +	}
> +	if (msg != THREAD_MSG__ACK) {
> +		pr_err("threadpool: received unexpected msg from tid=%d: %s\n",
> +		       thread->tid, thread_msg_tags[msg]);
> +		return -1;
> +	}
> +
> +	pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
> +
> +	return 0;
> +}
> +
> +/**
> + * terminate_thread - send stop signal to thread and wait for ack
> + *
> + * NB: call only from main thread!
> + */
> +static int terminate_thread(struct thread_struct *thread)
> +{
> +	int res;
> +	enum thread_msg msg = THREAD_MSG__STOP;
> +
> +	res = write(thread->pipes.to[1], &msg, sizeof(msg));
> +	if (res < 0) {
> +		pr_err("threadpool: error sending stop msg to tid=%d: %s\n",
> +			thread->tid, strerror(errno));
> +		return res;
> +	}
> +
> +	res = wait_thread(thread);
> +
> +	return res;
> +}
> +
> +/**
> + * threadpool_thread - function running on thread
> + *
> + * This function waits for a signal from main thread to start executing
> + * a task.
> + * On completion, it will go back to sleep, waiting for another signal.
> + * Signals are delivered through pipes.
> + */
> +static void *threadpool_thread(void *args)

   threadpool_function()

 ETOMANY 'thread' in a name.

> +{
> +	struct thread_struct *thread = (struct thread_struct *) args;
> +	enum thread_msg msg;
> +	int err;
> +
> +	thread->tid = gettid();
> +
> +	pr_debug2("threadpool[%d]: started\n", thread->tid);
> +
> +	for (;;) {
> +		msg = THREAD_MSG__ACK;
> +		err = write(thread->pipes.from[1], &msg, sizeof(msg));
> +		if (err == -1) {
> +			pr_err("threadpool[%d]: failed to send ack: %s\n",
> +				thread->tid, strerror(errno));
> +			break;
> +		}
> +
> +		msg = THREAD_MSG__UNDEFINED;
> +		err = read(thread->pipes.to[0], &msg, sizeof(msg));
> +		if (err < 0) {
> +			pr_err("threadpool[%d]: error receiving msg: %s\n",
> +				thread->tid, strerror(errno));
> +			break;
> +		}
> +
> +		if (msg != THREAD_MSG__WAKE && msg != THREAD_MSG__STOP) {
> +			pr_err("threadpool[%d]: received unexpected msg: %s\n",
> +				thread->tid, thread_msg_tags[msg]);
> +			break;
> +		}
> +
> +		if (msg == THREAD_MSG__STOP)
> +			break;
> +	}
> +
> +	pr_debug2("threadpool[%d]: exit\n", thread->tid);
> +
> +	msg = THREAD_MSG__ACK;
> +	err = write(thread->pipes.from[1], &msg, sizeof(msg));
> +	if (err == -1) {
> +		pr_err("threadpool[%d]: failed to send ack: %s\n",
> +			thread->tid, strerror(errno));
> +		return NULL;
> +	}
> +
> +	return NULL;
> +}
> +
>  /**
>   * create_threadpool - create a fixed threadpool with @n_threads threads
>   */
> @@ -173,3 +306,108 @@ int threadpool_size(struct threadpool_struct *pool)
>  {
>  	return pool->nr_threads;
>  }
> +
> +/**
> + * __start_threadpool - start all threads in the pool.
> + *
> + * This function does not change @pool->status.
> + */
> +static int __start_threadpool(struct threadpool_struct *pool)
> +{
> +	int t, tt, ret = 0, nr_threads = pool->nr_threads;
> +	sigset_t full, mask;
> +	pthread_t handle;
> +	pthread_attr_t attrs;
> +
> +	sigfillset(&full);
> +	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> +		pr_err("Failed to block signals on threads start: %s\n",
> +			strerror(errno));
> +		return -1;
> +	}
> +
> +	pthread_attr_init(&attrs);
> +	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +
> +	for (t = 0; t < nr_threads; t++) {
> +		struct thread_struct *thread = &pool->threads[t];
> +
> +		if (pthread_create(&handle, &attrs, threadpool_thread, thread)) {
> +			for (tt = 1; tt < t; tt++)
> +				terminate_thread(thread);
> +			pr_err("Failed to start threads: %s\n", strerror(errno));
> +			ret = -1;
> +			goto out_free_attr;
> +		}
> +
> +		if (wait_thread(thread)) {
> +			for (tt = 1; tt <= t; tt++)
> +				terminate_thread(thread);
> +			ret = -1;
> +			goto out_free_attr;
> +		}
> +	}
> +
> +out_free_attr:
> +	pthread_attr_destroy(&attrs);
> +
> +	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> +		pr_err("Failed to unblock signals on threads start: %s\n",
> +			strerror(errno));
> +		ret = -1;
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * start_threadpool - start all threads in the pool.
> + *
> + * The function blocks until all threads are up and running.
> + */
> +int start_threadpool(struct threadpool_struct *pool)

int threadpool__start(struct threadpool *pool)

> +{
> +	int err;
> +
> +	if (pool->status != THREADPOOL_STATUS__STOPPED) {
> +		pr_err("threadpool: starting not stopped pool\n");
> +		return -1;
> +	}
> +
> +	err = __start_threadpool(pool);
> +	pool->status = err ? THREADPOOL_STATUS__ERROR : THREADPOOL_STATUS__READY;
> +	return err;
> +}
> +
> +/**
> + * stop_threadpool - stop all threads in the pool.
> + *
> + * This function blocks waiting for ack from all threads.
> + */
> +int stop_threadpool(struct threadpool_struct *pool)

int threadpool__stop(struct threadpool *pool)

> +{
> +	int t, ret, err = 0;
> +
> +	if (pool->status != THREADPOOL_STATUS__READY) {
> +		pr_err("threadpool: stopping not ready pool\n");
> +		return -1;
> +	}
> +
> +	for (t = 0; t < pool->nr_threads; t++) {
> +		ret = terminate_thread(&pool->threads[t]);
> +		if (ret && !err)
> +			err = -1;
> +	}
> +
> +	pool->status = err ? THREADPOOL_STATUS__ERROR : THREADPOOL_STATUS__STOPPED;
> +
> +	return err;
> +}
> +
> +/**
> + * threadpool_is_ready - check if the threads are running
> + */
> +bool threadpool_is_ready(struct threadpool_struct *pool)

bool threadpool__is_ready(struct threadpool *pool)

> +{
> +	return pool->status == THREADPOOL_STATUS__READY;
> +}
> diff --git a/tools/perf/util/workqueue/threadpool.h b/tools/perf/util/workqueue/threadpool.h
> index 2b9388c768a0b588..b62cad2b2c5dd331 100644
> --- a/tools/perf/util/workqueue/threadpool.h
> +++ b/tools/perf/util/workqueue/threadpool.h
> @@ -14,6 +14,11 @@ struct task_struct {
>  extern struct threadpool_struct *create_threadpool(int n_threads);
>  extern void destroy_threadpool(struct threadpool_struct *pool);
>  
> +extern int start_threadpool(struct threadpool_struct *pool);
> +extern int stop_threadpool(struct threadpool_struct *pool);
> +
>  extern int threadpool_size(struct threadpool_struct *pool);
>  
> +extern bool threadpool_is_ready(struct threadpool_struct *pool);
> +
>  #endif /* __WORKQUEUE_THREADPOOL_H */
> -- 
> 2.31.1
> 

-- 

- Arnaldo
