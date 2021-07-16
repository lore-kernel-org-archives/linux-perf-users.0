Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04675C12002
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C1D613DF
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240210AbhGPN6i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 09:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239738AbhGPN6i (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 09:58:38 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397D7C06175F;
        Fri, 16 Jul 2021 06:55:42 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id a13so12176356wrf.10;
        Fri, 16 Jul 2021 06:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=h6v+FDBeQnRoZ//cxoHOViS1xVmtQ5wKO8sbxgZ7IxQ=;
        b=Hs6+G709aR5jo6GSikZL4aOziKc92p+cipf5wI8YSlbK+qAYGKa6Qh1R6iuNTnVgRM
         9MapeAiGkmY36C3pgkL4FtMNb5r7a1BKNdCxgfs/02obR3IcRzulTPxIGLMM/A6pVSYI
         Sh8TH89Vf+nPJRlNaJHYo/vQEkzNBF03iuC7RcVRuNpzmHFOcYygkRko0DV0hMbE2aHL
         GtbywZRuj5pHT63OPXRYQzNHiIIy8OXOyteOgweFvBY76pysZTDmhqJv81CotPlukilf
         viSIzST9Fr+/IQF6JF8ppUKt7FyaBd5s1xy85G7aJ1YP+5mB5P5FtAFWy0AiDf2oyolJ
         5Bww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=h6v+FDBeQnRoZ//cxoHOViS1xVmtQ5wKO8sbxgZ7IxQ=;
        b=CuPhqesRSioxWIjkLuylRPSylulVKhqsHliBwNOBS71SucGTmN/RS9WIzoXi8RLbJB
         yg3o5g5mo6+bko0IT0ZLln1QgWd/qNc9GJesHYK1aoQbXo/rFttAza4ZX667f6HhCAQz
         zf6iY3HmPXgDHLHmAzlYy134XG7yuesc7iFrSFsCe8ACLgJLnDl0etvUD4z75PmqFJ3s
         WtMqSEtSIceYUXolZikeUAL4ZmFgbW3A0BrSsyHwu7Ph7FM+VkhL7Hdhf4YqmujBazLy
         oyd/pw1+HuwZ7g7CoEN0tOdJu2T6xfMrP199/mrO567yeWpsS6JBXeAs6m32j//+A46x
         FBxQ==
X-Gm-Message-State: AOAM533gw8uvASaJCOca0iIefZb6epOhsf7U8E3L8As69yRUH+YrGCz0
        uLWd9+AXA6Lt7SMG0C+5WjM=
X-Google-Smtp-Source: ABdhPJy+HfwxsgwfaNlyW/rpnYRJlNHnZVVTwk+wJw8wbW1cVlQZw9nBJrAsVOcTv7OyoRNLr+iWsw==
X-Received: by 2002:a5d:6302:: with SMTP id i2mr12587159wru.366.1626443740776;
        Fri, 16 Jul 2021 06:55:40 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id d15sm10110214wri.39.2021.07.16.06.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:55:40 -0700 (PDT)
Message-ID: <b82d7c8f1c1d48f9a79d30d2e76cf56b1f7c8ee0.camel@gmail.com>
Subject: Re: [RFC PATCH 04/10] perf workqueue: add threadpool execute and
 wait functions
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Date:   Fri, 16 Jul 2021 15:55:39 +0200
In-Reply-To: <CAM9d7ci9vCBsyYAj6kXUAtEufG9PW0D=1-7PP-VrA_PPU6wbkA@mail.gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <a5fee5068f9630f14f1f5c259434badf43d451c4.1626177381.git.rickyman7@gmail.com>
         <CAM9d7ci9vCBsyYAj6kXUAtEufG9PW0D=1-7PP-VrA_PPU6wbkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,
thanks again for the review.

On Thu, 2021-07-15 at 16:56 -0700, Namhyung Kim wrote:
> On Tue, Jul 13, 2021 at 5:11 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > This patch adds:
> >  - execute_in_threadpool: assigns a task to the threads to execute
> >    asynchronously.
> >  - wait_threadpool: waits for the task to complete on all threads.
> > Furthermore, testing for these new functions is added.
> > 
> > This patch completes the threadpool.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> >  tools/perf/tests/workqueue.c           |  86 ++++++++++++++++++++-
> >  tools/perf/util/workqueue/threadpool.c | 103 +++++++++++++++++++++++++
> >  tools/perf/util/workqueue/threadpool.h |   5 ++
> >  3 files changed, 193 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/tests/workqueue.c b/tools/perf/tests/workqueue.c
> > index be377e9897bab4e9..3c64db8203556847 100644
> > --- a/tools/perf/tests/workqueue.c
> > +++ b/tools/perf/tests/workqueue.c
> > @@ -1,13 +1,59 @@
> >  // SPDX-License-Identifier: GPL-2.0
> > +#include <stdlib.h>
> >  #include <linux/kernel.h>
> > +#include <linux/zalloc.h>
> >  #include "tests.h"
> >  #include "util/debug.h"
> >  #include "util/workqueue/threadpool.h"
> > 
> > +#define DUMMY_FACTOR 100000
> > +#define N_DUMMY_WORK_SIZES 7
> > +
> >  struct threadpool_test_args_t {
> >         int pool_size;
> >  };
> > 
> > +struct test_task {
> > +       struct task_struct task;
> > +       int n_threads;
> > +       int *array;
> > +};
> > +
> > +/**
> > + * dummy_work - calculates DUMMY_FACTOR * (idx % N_DUMMY_WORK_SIZES)
> > inefficiently
> > + *
> > + * This function uses modulus to create work items of different sizes.
> > + */
> > +static void dummy_work(int idx)
> > +{
> > +       int prod = 0;
> 
> I'm not sure but having 'volatile' would prevent some kind of
> possible compiler optimizations..

Agreed.

> 
> > +       int k = idx % N_DUMMY_WORK_SIZES;
> > +       int i, j;
> > +
> > +       for (i = 0; i < DUMMY_FACTOR; i++)
> > +               for (j = 0; j < k; j++)
> > +                       prod ++;
> > +
> > +       pr_debug3("dummy: %d * %d = %d\n", DUMMY_FACTOR, k, prod);
> > +}
> > +
> > +static void test_task_fn1(int tidx, struct task_struct *task)
> > +{
> > +       struct test_task *mtask = container_of(task, struct test_task,
> > task);
> > +
> > +       dummy_work(tidx);
> > +       mtask->array[tidx] = tidx+1;
> > +}
> > +
> > +static void test_task_fn2(int tidx, struct task_struct *task)
> > +{
> > +       struct test_task *mtask = container_of(task, struct test_task,
> > task);
> > +
> > +       dummy_work(tidx);
> > +       mtask->array[tidx] = tidx*2;
> > +}
> > +
> > +
> >  static int __threadpool__prepare(struct threadpool_struct **pool, int
> > pool_size)
> >  {
> >         int ret;
> > @@ -38,21 +84,59 @@ static int __threadpool__teardown(struct
> > threadpool_struct *pool)
> >         return 0;
> >  }
> > 
> > +static int __threadpool__exec_wait(struct threadpool_struct *pool,
> > +                               struct task_struct *task)
> > +{
> > +       int ret;
> > +
> > +       ret = execute_in_threadpool(pool, task);
> > +       TEST_ASSERT_VAL("threadpool execute failure", ret == 0);
> > +       TEST_ASSERT_VAL("threadpool is not executing",
> > threadpool_is_busy(pool));
> > +
> > +       ret = wait_threadpool(pool);
> > +       TEST_ASSERT_VAL("threadpool wait failure", ret == 0);
> > +       TEST_ASSERT_VAL("waited threadpool is not ready",
> > threadpool_is_ready(pool));
> > +
> > +       return 0;
> > +}
> > 
> >  static int __test__threadpool(void *_args)
> >  {
> >         struct threadpool_test_args_t *args = _args;
> >         struct threadpool_struct *pool;
> > -       int ret;
> > +       int ret, i;
> > +       struct test_task task;
> > +
> > +       task.task.fn = test_task_fn1;
> > +       task.n_threads = args->pool_size;
> > +       task.array = calloc(args->pool_size, sizeof(*task.array));
> 
> Need to check the return value.

Thanks.

> 
> > 
> >         ret = __threadpool__prepare(&pool, args->pool_size);
> >         if (ret)
> >                 return ret;
> > 
> > +       ret = __threadpool__exec_wait(pool, &task.task);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i = 0; i < args->pool_size; i++)
> > +               TEST_ASSERT_VAL("failed array check (1)", task.array[i] ==
> > i+1);
> > +
> > +       task.task.fn = test_task_fn2;
> > +
> > +       ret = __threadpool__exec_wait(pool, &task.task);
> > +       if (ret)
> > +               return ret;
> > +
> > +       for (i = 0; i < args->pool_size; i++)
> > +               TEST_ASSERT_VAL("failed array check (2)", task.array[i] ==
> > 2*i);
> > +
> >         ret = __threadpool__teardown(pool);
> >         if (ret)
> >                 return ret;
> > 
> > +       free(task.array);
> 
> All previous returns will leak it.

Oh, right.

Thanks,
Riccardo

> 
> Thanks,
> Namhyung


