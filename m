Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3477AC636C8
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095C6613E0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhGOX7Z (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:59:25 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:34406 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhGOX7W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 19:59:22 -0400
Received: by mail-lf1-f43.google.com with SMTP id f30so12997134lfj.1;
        Thu, 15 Jul 2021 16:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=37Ab3kpTrPgzmm618oRObyRk2nJWR4HT2Rg5TXVHbr4=;
        b=EOiuZvioNYu4kzK74PBwSm+P3UOFLKi0N/8j3ep8HMbLa2NI+HbpzDXfPpZzdNCaCx
         vQpqMZ7W53EKdu3kVRbZPyneqVDXMS2W/O8+WpOglVtE3/dTyzVhTR98z3aq0s5sU20n
         2fra7ICdyt+vzd1yPH29GuKv/OJgOPhQW4+6txXKDEN06Zi0e/4oSDJi+vNivuRwPnlm
         ca+95x3klKUbizoro5CYRU2DUby4dQzHhkj9DVqKbi/Mx5w9YaQOL1vIXVrbISIKDn3R
         D5V2iXXI2tjoKFJ7GwQKBKa+TfAGmk8BhePu+fILezYGkVjiFVM54U9r+9doOe7ivAZ9
         PRcA==
X-Gm-Message-State: AOAM533H6gHk8jIlYcmsDV9vykGztS/PK3c/dipLsozjjYeKeVWWnz1c
        S4fEyCH4PfRDzuLx0cct4hC9x4ztkojKLa9mnzw=
X-Google-Smtp-Source: ABdhPJxhngnreCpXX97I+6aPbURCKOaUSJ8uNwHI/uIu3lfgqnZaIkJV9NrqcXHFcx9UDXC4Nb87s8diI7srLd/mlxU=
X-Received: by 2002:a19:8c0f:: with SMTP id o15mr5387368lfd.509.1626393381332;
 Thu, 15 Jul 2021 16:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626177381.git.rickyman7@gmail.com> <a5fee5068f9630f14f1f5c259434badf43d451c4.1626177381.git.rickyman7@gmail.com>
In-Reply-To: <a5fee5068f9630f14f1f5c259434badf43d451c4.1626177381.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 15 Jul 2021 16:56:10 -0700
Message-ID: <CAM9d7ci9vCBsyYAj6kXUAtEufG9PW0D=1-7PP-VrA_PPU6wbkA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] perf workqueue: add threadpool execute and wait functions
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jul 13, 2021 at 5:11 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> This patch adds:
>  - execute_in_threadpool: assigns a task to the threads to execute
>    asynchronously.
>  - wait_threadpool: waits for the task to complete on all threads.
> Furthermore, testing for these new functions is added.
>
> This patch completes the threadpool.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/tests/workqueue.c           |  86 ++++++++++++++++++++-
>  tools/perf/util/workqueue/threadpool.c | 103 +++++++++++++++++++++++++
>  tools/perf/util/workqueue/threadpool.h |   5 ++
>  3 files changed, 193 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> index be377e9897bab4e9..3c64db8203556847 100644
> --- a/tools/perf/tests/workqueue.c
> +++ b/tools/perf/tests/workqueue.c
> @@ -1,13 +1,59 @@
>  // SPDX-License-Identifier: GPL-2.0
> +#include <stdlib.h>
>  #include <linux/kernel.h>
> +#include <linux/zalloc.h>
>  #include "tests.h"
>  #include "util/debug.h"
>  #include "util/workqueue/threadpool.h"
>
> +#define DUMMY_FACTOR 100000
> +#define N_DUMMY_WORK_SIZES 7
> +
>  struct threadpool_test_args_t {
>         int pool_size;
>  };
>
> +struct test_task {
> +       struct task_struct task;
> +       int n_threads;
> +       int *array;
> +};
> +
> +/**
> + * dummy_work - calculates DUMMY_FACTOR * (idx % N_DUMMY_WORK_SIZES) inefficiently
> + *
> + * This function uses modulus to create work items of different sizes.
> + */
> +static void dummy_work(int idx)
> +{
> +       int prod = 0;

I'm not sure but having 'volatile' would prevent some kind of
possible compiler optimizations..

> +       int k = idx % N_DUMMY_WORK_SIZES;
> +       int i, j;
> +
> +       for (i = 0; i < DUMMY_FACTOR; i++)
> +               for (j = 0; j < k; j++)
> +                       prod ++;
> +
> +       pr_debug3("dummy: %d * %d = %d\n", DUMMY_FACTOR, k, prod);
> +}
> +
> +static void test_task_fn1(int tidx, struct task_struct *task)
> +{
> +       struct test_task *mtask = container_of(task, struct test_task, task);
> +
> +       dummy_work(tidx);
> +       mtask->array[tidx] = tidx+1;
> +}
> +
> +static void test_task_fn2(int tidx, struct task_struct *task)
> +{
> +       struct test_task *mtask = container_of(task, struct test_task, task);
> +
> +       dummy_work(tidx);
> +       mtask->array[tidx] = tidx*2;
> +}
> +
> +
>  static int __threadpool__prepare(struct threadpool_struct **pool, int pool_size)
>  {
>         int ret;
> @@ -38,21 +84,59 @@ static int __threadpool__teardown(struct threadpool_struct *pool)
>         return 0;
>  }
>
> +static int __threadpool__exec_wait(struct threadpool_struct *pool,
> +                               struct task_struct *task)
> +{
> +       int ret;
> +
> +       ret = execute_in_threadpool(pool, task);
> +       TEST_ASSERT_VAL("threadpool execute failure", ret == 0);
> +       TEST_ASSERT_VAL("threadpool is not executing", threadpool_is_busy(pool));
> +
> +       ret = wait_threadpool(pool);
> +       TEST_ASSERT_VAL("threadpool wait failure", ret == 0);
> +       TEST_ASSERT_VAL("waited threadpool is not ready", threadpool_is_ready(pool));
> +
> +       return 0;
> +}
>
>  static int __test__threadpool(void *_args)
>  {
>         struct threadpool_test_args_t *args = _args;
>         struct threadpool_struct *pool;
> -       int ret;
> +       int ret, i;
> +       struct test_task task;
> +
> +       task.task.fn = test_task_fn1;
> +       task.n_threads = args->pool_size;
> +       task.array = calloc(args->pool_size, sizeof(*task.array));

Need to check the return value.

>
>         ret = __threadpool__prepare(&pool, args->pool_size);
>         if (ret)
>                 return ret;
>
> +       ret = __threadpool__exec_wait(pool, &task.task);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < args->pool_size; i++)
> +               TEST_ASSERT_VAL("failed array check (1)", task.array[i] == i+1);
> +
> +       task.task.fn = test_task_fn2;
> +
> +       ret = __threadpool__exec_wait(pool, &task.task);
> +       if (ret)
> +               return ret;
> +
> +       for (i = 0; i < args->pool_size; i++)
> +               TEST_ASSERT_VAL("failed array check (2)", task.array[i] == 2*i);
> +
>         ret = __threadpool__teardown(pool);
>         if (ret)
>                 return ret;
>
> +       free(task.array);

All previous returns will leak it.

Thanks,
Namhyung
