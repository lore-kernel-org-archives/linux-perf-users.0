Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85273C4338F
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD3B611C3
	for <linux-perf-users@archiver.kernel.org>; Sat,  7 Aug 2021 02:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhHGCnj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 6 Aug 2021 22:43:39 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:43914 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhHGCnj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 6 Aug 2021 22:43:39 -0400
Received: by mail-lf1-f48.google.com with SMTP id b6so5355587lff.10;
        Fri, 06 Aug 2021 19:43:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWBnCJz8G1J9T8EioAp/RGSDXIJQ17sacS81KY8oUeE=;
        b=NGNU0lMZ71M6YiMSO9QPetMOvTqAKksDrff6fT4TdThg0Ad1yMvjIq4xR3+zSZgdPw
         jl0M1+Xi6QGCoKMHz9mOSkbf0MEu6cgNrtSfxxqaHLv8+NpzC5IBnjz0+SazkJcQt5Sw
         D1ZOW3p4wvh0b7HReV+vkHgPujUfGM19FCdjAl+oI/B9RKBg/N9rgbJVyT8B86qij4gw
         g9D7/1zvSMQGZQNN+CqLJdP+ki9TOwVh8P/4e82g3KiIl57KHIpUScjwPM3ywAp91yh4
         0IlStIt3WzDrrvS2l3rnz5dCMpnoG9S4s0lFCChIYzWZFBrpbJcP9Je88OesRZ+CWtGt
         3YBw==
X-Gm-Message-State: AOAM5331lq8igFZ2C7n8qlJ5vw9xc+mlOiAft+pBaFNTIxpHaZV+TIzX
        XVpiXaOB16R4j9IXGbs9u25/O3I3fxKp9hSMQY0=
X-Google-Smtp-Source: ABdhPJzONCoAp8toY31R0IUb8lg1hMLr64qP4dzmrVaKncKUUa0AtJFtTimhELMqBP6KJz6uCXLxUwFIutxhuTSsRj4=
X-Received: by 2002:ac2:57d5:: with SMTP id k21mr7618156lfo.509.1628304200790;
 Fri, 06 Aug 2021 19:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1627657061.git.rickyman7@gmail.com> <6b18cd4441733f487b45bdf1e6f507b45be3bfbf.1627657061.git.rickyman7@gmail.com>
In-Reply-To: <6b18cd4441733f487b45bdf1e6f507b45be3bfbf.1627657061.git.rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 6 Aug 2021 19:43:09 -0700
Message-ID: <CAM9d7cg-AF4u=MPJwBs5QSbT_RgEFXYyum97yu3gy0+2w16d6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/10] perf workqueue: add threadpool start and
 stop functions
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

[SNIP]
> @@ -93,6 +134,130 @@ static void threadpool_entry__close_pipes(struct threadpool_entry *thread)
>         }
>  }
>
> +/**
> + * threadpool__wait_thread - receive ack from thread
> + *
> + * NB: call only from main thread!
> + */
> +static int threadpool__wait_thread(struct threadpool_entry *thread)

If you wanted to differentiate APIs for main thread, I think it's better
to pass the pool struct (according to the name) and the index like:

  int threadpool__wait_thread(struct threadpool *pool, int idx)

Then it can get a pointer to the entry easily.

> +{
> +       int res;
> +       enum threadpool_msg msg = THREADPOOL_MSG__UNDEFINED;
> +
> +       res = readn(thread->pipes.ack[0], &msg, sizeof(msg));
> +       if (res < 0) {
> +               pr_debug2("threadpool: failed to recv msg from tid=%d: %s\n",
> +                      thread->tid, strerror(errno));
> +               return -THREADPOOL_ERROR__READPIPE;
> +       }
> +       if (msg != THREADPOOL_MSG__ACK) {
> +               pr_debug2("threadpool: received unexpected msg from tid=%d: %s\n",
> +                      thread->tid, threadpool_msg_tags[msg]);
> +               return -THREADPOOL_ERROR__INVALIDMSG;
> +       }
> +
> +       pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
> +
> +       return 0;
> +}
> +
> +/**
> + * threadpool__terminate_thread - send stop signal to thread and wait for ack
> + *
> + * NB: call only from main thread!
> + */
> +static int threadpool__terminate_thread(struct threadpool_entry *thread)

Ditto.

> +{
> +       int res;
> +       enum threadpool_msg msg = THREADPOOL_MSG__STOP;
> +
> +       res = writen(thread->pipes.cmd[1], &msg, sizeof(msg));
> +       if (res < 0) {
> +               pr_debug2("threadpool: error sending stop msg to tid=%d: %s\n",
> +                       thread->tid, strerror(errno));
> +               return -THREADPOOL_ERROR__WRITEPIPE;
> +       }
> +
> +       return threadpool__wait_thread(thread);
> +}
> +

[SNIP]
> @@ -161,12 +326,30 @@ struct threadpool *threadpool__new(int n_threads)
>   *
>   * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
>   */
> -int threadpool__strerror(struct threadpool *pool __maybe_unused, int err, char *buf, size_t size)
> +int threadpool__strerror(struct threadpool *pool, int err, char *buf, size_t size)
>  {
>         char sbuf[STRERR_BUFSIZE], *emsg;
> +       const char *status_str, *errno_str;
>
> -       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> -       return scnprintf(buf, size, "Error: %s.\n", emsg);
> +       status_str = IS_ERR_OR_NULL(pool) ? "error" : threadpool_status_tags[pool->status];
> +
> +       switch (err) {
> +       case -THREADPOOL_ERROR__SIGPROCMASK:
> +       case -THREADPOOL_ERROR__READPIPE:
> +       case -THREADPOOL_ERROR__WRITEPIPE:
> +               emsg = str_error_r(errno, sbuf, sizeof(sbuf));
> +               errno_str = threadpool_errno_str[-err-THREADPOOL_ERROR__OFFSET];
> +               return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
> +       case -THREADPOOL_ERROR__INVALIDMSG:
> +               errno_str = threadpool_errno_str[-err-THREADPOOL_ERROR__OFFSET];
> +               return scnprintf(buf, size, "%s.\n", errno_str);
> +       case -THREADPOOL_ERROR__NOTALLOWED:
> +               return scnprintf(buf, size, "%s (%s).\n",
> +                       threadpool_errno_str[-err], status_str);

s/-err/-err-THREADPOOL_ERROR__OFFSET/ ?

It'd be nice if you calculate the index once.

> +       default:
> +               emsg = str_error_r(err, sbuf, sizeof(sbuf));

I'm confused whether the 'err' is negative or positive?

Thanks,
Namhyung


> +               return scnprintf(buf, size, "Error: %s", emsg);
> +       }
>  }
>
