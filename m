Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C162FC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6A3613DC
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbhGOXvl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:51:41 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:46956 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhGOXvl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 19:51:41 -0400
Received: by mail-lf1-f47.google.com with SMTP id x25so12885796lfu.13;
        Thu, 15 Jul 2021 16:48:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XPTsKumlAARjlPirfMjxooUJNBnyyCY0ijQsxeU3HLI=;
        b=KEBvtiQb3NTcNAjLHvz5KmJXHiX3ga7Knf7jI+HuDP7KjiZfLcn/+bXP2wpeuCF0yJ
         gy9TJoUN+JzFyxge/GzgYE3BYXxc1+0XYQlREgIJV7QDsEhc39NiBNT7Lm8sMC8OM7tK
         3cikuzTGUOfmHjE+KeQLgBQnGr7+KH5dmGPQy7+UDLF6FrptWwfCVXRpEHG78+x5iBoo
         nHJeWdo5oYk243QvVCkRJdJD0hmSj4Dm3tFIGuBK7zhuwIBRlTmPY1F76Ng3otQaXFD5
         Q0RXYli0k+OCqdjXkhpLXjPNAtqwSRTFAe4ZV7dp2fzpe2/oP8NBtPYO1JTKkuxymHUa
         cFdg==
X-Gm-Message-State: AOAM530D3E4g0bwpHmknMd6OdIkPx0bt9DTgVCaGl8Wza7AGN/iBnySY
        ne2e/JKc7idBjZlmK0SPpGgpVuYSqR0hN1M541Y=
X-Google-Smtp-Source: ABdhPJw9ozxvAk4aI42aBe1fpJYqnJCNScSfW2z5/0s++UZrrONZX/Hoo0HxuHrxQ2hMD2zvrKjgx3pCIb1SI41NsL8=
X-Received: by 2002:a05:6512:3125:: with SMTP id p5mr5138762lfd.635.1626392925908;
 Thu, 15 Jul 2021 16:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626177381.git.rickyman7@gmail.com> <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
In-Reply-To: <118c988358322b9daf69aeb98ff8986748b0dad2.1626177381.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Jul 2021 16:48:34 -0700
Message-ID: <CAM9d7chvRswKLmRvW5rd4GApqngN8QeG+nPmVy4zxz_YR0MMxw@mail.gmail.com>
Subject: Re: [RFC PATCH 03/10] perf workqueue: add threadpool start and stop functions
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

On Tue, Jul 13, 2021 at 5:11 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
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
> +       int ret;
> +
>         *pool = create_threadpool(pool_size);
>         TEST_ASSERT_VAL("threadpool creation failure", *pool != NULL);
>         TEST_ASSERT_VAL("threadpool size is wrong",
>                         threadpool_size(*pool) == pool_size);
>
> +       ret = start_threadpool(*pool);
> +       TEST_ASSERT_VAL("threadpool start failure", ret == 0);
> +       TEST_ASSERT_VAL("threadpool is not ready", threadpool_is_ready(*pool));
> +
>         return 0;
>  }
>
>  static int __threadpool__teardown(struct threadpool_struct *pool)
>  {
> +       int ret;
> +
> +       ret = stop_threadpool(pool);
> +       TEST_ASSERT_VAL("threadpool start failure", ret == 0);

s/start/stop/

> +       TEST_ASSERT_VAL("stopped threadpool is ready",
> +                       !threadpool_is_ready(pool));
> +
>         destroy_threadpool(pool);
>
>         return 0;
> diff --git a/tools/perf/util/workqueue/threadpool.c b/tools/perf/util/workqueue/threadpool.c
> index 70c67569f956a3e2..f4635ff782b9388e 100644
> --- a/tools/perf/util/workqueue/threadpool.c
> +++ b/tools/perf/util/workqueue/threadpool.c
[SNIP]
> +/**
> + * wait_thread - receive ack from thread
> + *
> + * NB: call only from main thread!
> + */
> +static int wait_thread(struct thread_struct *thread)
> +{
> +       int res;
> +       enum thread_msg msg = THREAD_MSG__UNDEFINED;
> +
> +       res = read(thread->pipes.from[0], &msg, sizeof(msg));
> +       if (res < 0) {

Maybe it needs to handle -EINTR.


> +               pr_err("threadpool: failed to recv msg from tid=%d: %s\n",
> +                      thread->tid, strerror(errno));
> +               return -1;
> +       }
> +       if (msg != THREAD_MSG__ACK) {
> +               pr_err("threadpool: received unexpected msg from tid=%d: %s\n",
> +                      thread->tid, thread_msg_tags[msg]);
> +               return -1;
> +       }
> +
> +       pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
> +
> +       return 0;
> +}
> +
> +/**
> + * terminate_thread - send stop signal to thread and wait for ack
> + *
> + * NB: call only from main thread!
> + */
> +static int terminate_thread(struct thread_struct *thread)
> +{
> +       int res;
> +       enum thread_msg msg = THREAD_MSG__STOP;
> +
> +       res = write(thread->pipes.to[1], &msg, sizeof(msg));
> +       if (res < 0) {
> +               pr_err("threadpool: error sending stop msg to tid=%d: %s\n",
> +                       thread->tid, strerror(errno));
> +               return res;
> +       }
> +
> +       res = wait_thread(thread);
> +
> +       return res;
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
> +{
> +       struct thread_struct *thread = (struct thread_struct *) args;
> +       enum thread_msg msg;
> +       int err;
> +
> +       thread->tid = gettid();
> +
> +       pr_debug2("threadpool[%d]: started\n", thread->tid);
> +
> +       for (;;) {
> +               msg = THREAD_MSG__ACK;
> +               err = write(thread->pipes.from[1], &msg, sizeof(msg));
> +               if (err == -1) {
> +                       pr_err("threadpool[%d]: failed to send ack: %s\n",
> +                               thread->tid, strerror(errno));
> +                       break;
> +               }
> +
> +               msg = THREAD_MSG__UNDEFINED;
> +               err = read(thread->pipes.to[0], &msg, sizeof(msg));
> +               if (err < 0) {
> +                       pr_err("threadpool[%d]: error receiving msg: %s\n",
> +                               thread->tid, strerror(errno));
> +                       break;
> +               }
> +
> +               if (msg != THREAD_MSG__WAKE && msg != THREAD_MSG__STOP) {
> +                       pr_err("threadpool[%d]: received unexpected msg: %s\n",
> +                               thread->tid, thread_msg_tags[msg]);
> +                       break;
> +               }
> +
> +               if (msg == THREAD_MSG__STOP)
> +                       break;
> +       }
> +
> +       pr_debug2("threadpool[%d]: exit\n", thread->tid);
> +
> +       msg = THREAD_MSG__ACK;
> +       err = write(thread->pipes.from[1], &msg, sizeof(msg));
> +       if (err == -1) {
> +               pr_err("threadpool[%d]: failed to send ack: %s\n",
> +                       thread->tid, strerror(errno));
> +               return NULL;
> +       }
> +
> +       return NULL;
> +}
> +
>  /**
>   * create_threadpool - create a fixed threadpool with @n_threads threads
>   */
> @@ -173,3 +306,108 @@ int threadpool_size(struct threadpool_struct *pool)
>  {
>         return pool->nr_threads;
>  }
> +
> +/**
> + * __start_threadpool - start all threads in the pool.
> + *
> + * This function does not change @pool->status.
> + */
> +static int __start_threadpool(struct threadpool_struct *pool)
> +{
> +       int t, tt, ret = 0, nr_threads = pool->nr_threads;
> +       sigset_t full, mask;
> +       pthread_t handle;
> +       pthread_attr_t attrs;
> +
> +       sigfillset(&full);
> +       if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> +               pr_err("Failed to block signals on threads start: %s\n",
> +                       strerror(errno));
> +               return -1;
> +       }
> +
> +       pthread_attr_init(&attrs);
> +       pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +
> +       for (t = 0; t < nr_threads; t++) {
> +               struct thread_struct *thread = &pool->threads[t];
> +
> +               if (pthread_create(&handle, &attrs, threadpool_thread, thread)) {
> +                       for (tt = 1; tt < t; tt++)
> +                               terminate_thread(thread);
> +                       pr_err("Failed to start threads: %s\n", strerror(errno));
> +                       ret = -1;
> +                       goto out_free_attr;
> +               }
> +
> +               if (wait_thread(thread)) {
> +                       for (tt = 1; tt <= t; tt++)
> +                               terminate_thread(thread);
> +                       ret = -1;
> +                       goto out_free_attr;
> +               }
> +       }

Isn't it better doing this way?

for (t = 0; t < nr_threads; t++) {
    pthread_create(t)
}

for (t = 0; t < nr_threads; t++) {
    wait_thread(t)
}

Thanks,
Namhyung


> +
> +out_free_attr:
> +       pthread_attr_destroy(&attrs);
> +
> +       if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> +               pr_err("Failed to unblock signals on threads start: %s\n",
> +                       strerror(errno));
> +               ret = -1;
> +       }
> +
> +       return ret;
> +}
> +
