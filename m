Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BEC4338F
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1710361181
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhHGC4m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:56:42 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:41532 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbhHGC4m (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 22:56:42 -0400
Received: by mail-lf1-f53.google.com with SMTP id y34so21694844lfa.8;
        Fri, 06 Aug 2021 19:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZA1Bl+ATZQNgry7pTGV5hph7QyuNHAexwAUe0LexzI=;
        b=MrBd715sDF9tIz5p1LZDDzMRxAgEiDGtwFI5jigm2+2u4QnCyglvVMzAcg2I+nIKM5
         P63mU04ldG4g7n3NBlIWe/H2E2MhylTczHGk+fvbiBVKDP+7Aqz3eceoI4N7N0bpbQEO
         8f5A1F2JK89iOjwz6fDJiVYFJcXNaPAO+T8F5aK3MCh8RwsSLA4zwwLhCam/FDe288Bl
         +BroqvPj7EffdonQdx4LR3IkYW51JCJcnh8cbadWXCOg/fGsHQtLfMMjRypogktni9W4
         F8GfUsE7Y9CvQIdhpZpOckGG0xkqei+dRFZic69sGzSv6AoXMkP8Xi89NlCA9AsVz152
         DbGQ==
X-Gm-Message-State: AOAM532AsHrxHDigrBdThl5pFkWtEIpJtTP0GxgA+9a19b9uutngejM3
        AfQxyMKgD7+OBpi4jU2OTXT6xtsdsRTQipz3cBs=
X-Google-Smtp-Source: ABdhPJz/t91QTCZCzTWtWAcjHFEIzJup0lUfnN7hVKllPSdszu2/NKGVQCpjd7pUDk+5nOMqL1NLHYkyCVTHclQYQMs=
X-Received: by 2002:a05:6512:3456:: with SMTP id j22mr9411396lfr.635.1628304984230;
 Fri, 06 Aug 2021 19:56:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627657061.git.rickyman7@gmail.com> <2b55c73f1c1738361d80349f1c67e5fe9cce7174.1627657061.git.rickyman7@gmail.com>
In-Reply-To: <2b55c73f1c1738361d80349f1c67e5fe9cce7174.1627657061.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Aug 2021 19:56:12 -0700
Message-ID: <CAM9d7chTQG0QxntYArWdAOz1aCqyaxZecYszo2YTgS1yVC2NdA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 04/10] perf workqueue: add threadpool execute and
 wait functions
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

On Fri, Jul 30, 2021 at 8:34 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> This patch adds:
>  - threadpool__execute: assigns a task to the threads to execute
>    asynchronously.
>  - threadpool__wait: waits for the task to complete on all threads.
> Furthermore, testing for these new functions is added.
>
> This patch completes the threadpool.
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---

[SNIP]
> +/**
> + * threadpool__wake_thread - send wake msg to @thread
> + *
> + * This function does not wait for the thread to actually wake
> + * NB: call only from main thread!
> + */
> +static int threadpool__wake_thread(struct threadpool_entry *thread)

Same here.  You can pass pool and idx instead.

Thanks,
Namhyung


> +{
> +       int res;
> +       enum threadpool_msg msg = THREADPOOL_MSG__WAKE;
> +
> +       res = writen(thread->pipes.cmd[1], &msg, sizeof(msg));
> +       if (res < 0) {
> +               pr_debug2("threadpool: error sending wake msg: %s\n", strerror(errno));
> +               return -THREADPOOL_ERROR__WRITEPIPE;
> +       }
> +
> +       pr_debug2("threadpool: sent wake msg %s to tid=%d\n",
> +               threadpool_msg_tags[msg], thread->tid);
> +       return 0;
> +}
> +
