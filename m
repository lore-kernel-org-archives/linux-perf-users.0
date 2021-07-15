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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC074C07E96
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4A2B6136E
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhGOQwy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbhGOQwy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:52:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E83FC06175F;
        Thu, 15 Jul 2021 09:50:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f17so8664955wrt.6;
        Thu, 15 Jul 2021 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Ep2eMkNp2nRHtHvY85fIEvX7CnU3IX/8d7Feo7j4+0w=;
        b=UvcwkoTXYKTRmVgtSvhkZ5PFMhYp1BTRg79G5ABgnpZl3Zc9xDktEVMrnMuB5P8aoZ
         8Dk9wjEhMTEDKkidk5isRs1KAyQf5gpnFoUFDy4ZzsPBwxyXkQvzPKUZvLlHQlX0aLx2
         RMKtM6B8vYuN12tHUSJKuT9fh8nKY1OBOuA7pmvT3H3B0rh93F7AkkR4Ku2XcomqNvdt
         UgBtTMIZk5Fr+ZjK7RXzXGf6I/PsQXCgzMukXzXnsQ+dTYpjswpS5Xr8SMzvWgHv9O0I
         1yo4BP7Cwsa1sYm8NYUFjAa2iX+oB9F1xFp0TFMjOLs37Nlzlq9sEzk+BM7BnlCfwVwn
         7uHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Ep2eMkNp2nRHtHvY85fIEvX7CnU3IX/8d7Feo7j4+0w=;
        b=J8flYshOXlit7kTXo4PPoK1DiIwWibzqthfN3GW+A6OcIFbQV5G/thmZe+bbNVsHiq
         gWJRIKQmxIFAY7ktBo972yAFhdtxJObTV6THhGkzTC5kPT55t2vY2W76lC+k+AjyZsHv
         vcr16Yhrmvjsj5pZcx0/eTIQ7n0o8PYy+EgG1zOxshgESBjR2qDYcDM9E+W6sUtsh3g1
         gjaG2fYUwFUX49efFtABXM7bgj2i1XmBp2iLSa28ck4+2FxACZCgeU8dpWH1nuQdN+4o
         j6YR6tDMedp8dgTVx2XsM/FA8I/tORm9EGHXW7K/T6QYtpQJ2iJ0fMgDeUzffzzQkQm8
         wtcw==
X-Gm-Message-State: AOAM5324ZzmfUhdNkzi/FIdkLOgXEqjb74tOLS3gZj/kbyEWCCXmwdMy
        UX+WhkT3gBSvMEBw/LTzoM4=
X-Google-Smtp-Source: ABdhPJzcMjv9brYWn2+L33ASrZBGE9JbiumPLmqlCn3ClcXy2x83QIzhUkaHfwjdaPNzFguCmdpIog==
X-Received: by 2002:a05:6000:1841:: with SMTP id c1mr6585305wri.423.1626367799030;
        Thu, 15 Jul 2021 09:49:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id v15sm9231249wmj.39.2021.07.15.09.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:49:58 -0700 (PDT)
Message-ID: <d39def9e5c3edd6292d86c90036fd79a2406db1d.camel@gmail.com>
Subject: Re: [RFC PATCH 06/10] perf workqueue: introduce workqueue struct
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Date:   Thu, 15 Jul 2021 18:49:57 +0200
In-Reply-To: <YO8BUfFe4iNo/awZ@kernel.org>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <efda4e29da6f6aa8c34a3751ed676c7ee0506cf8.1626177381.git.rickyman7@gmail.com>
         <YO8BUfFe4iNo/awZ@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Arnaldo,
thanks again for having a look at this patchset!

On Wed, 2021-07-14 at 12:22 -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jul 13, 2021 at 02:11:17PM +0200, Riccardo Mancini escreveu:
> > This patch adds the workqueue definition, along with simple creation and
> > destruction functions.
> > Furthermore, a simple subtest is added.
> > 
> > A workqueue is attached to a pool, on which it executes its workers.
> > Next patches will introduce workers.
> > 
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > 
<SNIP>
> > +
> > +/**
> > + * create_workqueue - create a workqueue associated to @pool
> > + *
> > + * Only one workqueue can execute on a pool at a time.
> > + */
> > +struct workqueue_struct *create_workqueue(struct threadpool_struct *pool)
> 
> I wonder if we should use the exact same kernel signature and not pass a
> threadpool, essentially having just one threadpool in tools/perf/ that
> is used by create_workqueue(void)?

I wondered the same thing, but I thought that we'd need it to be dynamically
created to prevent spawning threads at the beginning that might not even be
used.
I think this could be a follow-up patch.

Thanks,
Riccardo

> 
> > +{
> > +       int err;
> > +       struct workqueue_struct *wq = malloc(sizeof(struct
> > workqueue_struct));
> > +
> > +
> > +       err = pthread_mutex_init(&wq->lock, NULL);
> > +       if (err)
> > +               goto out_free_wq;
> > +
> > +       err = pthread_cond_init(&wq->idle_cond, NULL);
> > +       if (err)
> > +               goto out_destroy_mutex;
> > +
> > +       wq->pool = NULL;
> > +       INIT_LIST_HEAD(&wq->busy_list);
> > +       INIT_LIST_HEAD(&wq->idle_list);
> > +
> > +       INIT_LIST_HEAD(&wq->pending);
> > +
> > +       err = pipe(wq->msg_pipe);
> > +       if (err)
> > +               goto out_destroy_cond;
> > +
> > +       wq->task.fn = worker_thread;
> > +
> > +       err = attach_threadpool_to_workqueue(wq, pool);
> > +       if (err)
> > +               goto out_destroy_cond;
> > +
> > +       wq->status = WORKQUEUE_STATUS__READY;
> > +
> > +       return wq;
> > +
> > +out_destroy_cond:
> > +       pthread_cond_destroy(&wq->idle_cond);
> > +out_destroy_mutex:
> > +       pthread_mutex_destroy(&wq->lock);
> > +out_free_wq:
> > +       free(wq);
> > +       return NULL;
> > +}
> > +
> > +/**
> > + * destroy_workqueue - stop @wq workers and destroy @wq
> > + */
> > +int destroy_workqueue(struct workqueue_struct *wq)
> > +{
> > +       int err = 0, ret;
> > +
> > +       ret = detach_threadpool_from_workqueue(wq);
> > +       if (ret) {
> > +               pr_err("workqueue: error detaching from threadpool.\n");
> > +               err = -1;
> > +       }
> > +
> > +       ret = pthread_mutex_destroy(&wq->lock);
> > +       if (ret) {
> > +               err = -1;
> > +               pr_err("workqueue: error pthread_mutex_destroy: %s\n",
> > +                       strerror(errno));
> > +       }
> > +
> > +       ret = pthread_cond_destroy(&wq->idle_cond);
> > +       if (ret) {
> > +               err = -1;
> > +               pr_err("workqueue: error pthread_cond_destroy: %s\n",
> > +                       strerror(errno));
> > +       }
> > +
> > +       ret = close(wq->msg_pipe[0]);
> > +       if (ret) {
> > +               err = -1;
> > +               pr_err("workqueue: error close msg_pipe[0]: %s\n",
> > +                       strerror(errno));
> > +       }
> > +
> > +       ret = close(wq->msg_pipe[1]);
> > +       if (ret) {
> > +               err = -1;
> > +               pr_err("workqueue: error close msg_pipe[1]: %s\n",
> > +                       strerror(errno));
> > +       }
> > +
> > +       free(wq);
> > +
> > +       return err;
> > +}
> > +
> > +/**
> > + * workqueue_nr_threads - get size of threadpool underlying @wq
> > + */
> > +int workqueue_nr_threads(struct workqueue_struct *wq)
> > +{
> > +       return threadpool_size(wq->pool);
> > +}
> > diff --git a/tools/perf/util/workqueue/workqueue.h
> > b/tools/perf/util/workqueue/workqueue.h
> > new file mode 100644
> > index 0000000000000000..86ec1d69274f41db
> > --- /dev/null
> > +++ b/tools/perf/util/workqueue/workqueue.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __WORKQUEUE_WORKQUEUE_H
> > +#define __WORKQUEUE_WORKQUEUE_H
> > +
> > +#include <stdlib.h>
> > +#include <sys/types.h>
> > +#include <linux/list.h>
> > +#include "threadpool.h"
> > +
> > +struct work_struct;
> > +typedef void (*work_func_t)(struct work_struct *work);
> > +
> > +struct work_struct {
> > +       struct list_head entry;
> > +       work_func_t func;
> > +};
> > +
> > +struct workqueue_struct;
> > +
> > +extern struct workqueue_struct *create_workqueue(struct threadpool_struct
> > *pool);
> > +extern int destroy_workqueue(struct workqueue_struct *wq);
> > +
> > +extern int workqueue_nr_threads(struct workqueue_struct *wq);
> > +#endif /* __WORKQUEUE_WORKQUEUE_H */
> > -- 
> > 2.31.1
> > 
> 


