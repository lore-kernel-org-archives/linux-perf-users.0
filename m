Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC06C4338F
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 10:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A66360F93
	for <linux-perf-users@archiver.kernel.org>; Mon,  9 Aug 2021 10:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhHIKfl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 9 Aug 2021 06:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbhHIKfl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 9 Aug 2021 06:35:41 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2871CC0613D3;
        Mon,  9 Aug 2021 03:35:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y7so23799039eda.5;
        Mon, 09 Aug 2021 03:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SKTI8cjqZvGaYJnPY8jnuaW9ah64OdLf3fUo/l7ct00=;
        b=TfenVWIqPBiRbTpFziCcxykJK56ccf1R4JGLMI0ILMS33NQCmBJIfs8mL7LFNGVsgS
         yD9Or9J66tEZlt2cGVg/DhoqIN+LIyByfOg3teCWEtkvIZ8hbtrdxGF9GWim3GAZkAKA
         8baEcoOyjpJF2HMqel3EdB1W2NjZYNM0lBdPFyJZsuhPnE/iJ8azLGkA+kKlltuZwAMd
         OVZyGaALIx1gs/X/EEz3yer+BA1tuaoNabO1TCWjxgNZTeX4hIIXJzoKRyIfjHEzkf94
         j3o7UR4PHslJ0+bfVHlEWr85hFiss1aE9Bt3/F059GIt+qQhB3Iv6QBlcItXgFrdv2uA
         j0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SKTI8cjqZvGaYJnPY8jnuaW9ah64OdLf3fUo/l7ct00=;
        b=djmIo1JdOv+0QbzjVOCHAyYxdaSSnWu9rwmM4JMJnCuie6a6lRNjTk/ffEFktWKvb/
         QE8iX36aVHgkoHvvZEW5/fixD+Vhohd5ejFCso1eyHvUtZJbvqb1DpSfUJHuTy2M180k
         SEH7t7Xb89B0zNg+Z043UhLBnNsdJ9Rlo9B08tWjw7DSrinmBbN6YycQ0JhUgdhhlzgF
         pJtqdW1F47BNYJ8qwVkw1dXEOm3bpt/rThYDDiQ7YcxfWZW2ghzarWbYBgEHU1nNau6c
         N+OCOBxZJFYxI7Inl2s0pkemjRXkED2VH0F/uIRx3Xr8/Jy2QXGa9oXUFbss3+bRQVmC
         i7iQ==
X-Gm-Message-State: AOAM531X8UIFLgsbbb0B8MTFqe/CHAHyB+ZJc6w74UdJc/vztCGj6ycA
        RUkxMtsVJ4zYbXHUBfEvSrg=
X-Google-Smtp-Source: ABdhPJzHgyUaOgyK3TkrXhD2brcploK19GajRQQqDthhZyUDNXZk1ecHKiNR2JHDy33anOjmbPwXXA==
X-Received: by 2002:aa7:cb0f:: with SMTP id s15mr18484171edt.190.1628505317655;
        Mon, 09 Aug 2021 03:35:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id bx11sm5777534ejb.107.2021.08.09.03.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 03:35:17 -0700 (PDT)
Message-ID: <cf825a794602de80fb0d7fc006ccbdf7c29f2644.camel@gmail.com>
Subject: Re: [RFC PATCH v2 03/10] perf workqueue: add threadpool start and
 stop functions
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Date:   Mon, 09 Aug 2021 12:35:16 +0200
In-Reply-To: <CAM9d7cg-AF4u=MPJwBs5QSbT_RgEFXYyum97yu3gy0+2w16d6g@mail.gmail.com>
References: <cover.1627657061.git.rickyman7@gmail.com>
         <6b18cd4441733f487b45bdf1e6f507b45be3bfbf.1627657061.git.rickyman7@gmail.com>
         <CAM9d7cg-AF4u=MPJwBs5QSbT_RgEFXYyum97yu3gy0+2w16d6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, 2021-08-06 at 19:43 -0700, Namhyung Kim wrote:
> On Fri, Jul 30, 2021 at 8:34 AM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > 
> > This patch adds the start and stop functions, alongside the thread
> > function.
> > Each thread will run until a stop signal is received.
> > Furthermore, start and stop are added to the test.
> > 
> > Thread management is based on the prototype from Alexey:
> > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> > 
> > Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > ---
> 
> [SNIP]
> > @@ -93,6 +134,130 @@ static void threadpool_entry__close_pipes(struct
> > threadpool_entry *thread)
> >         }
> >  }
> > 
> > +/**
> > + * threadpool__wait_thread - receive ack from thread
> > + *
> > + * NB: call only from main thread!
> > + */
> > +static int threadpool__wait_thread(struct threadpool_entry *thread)
> 
> If you wanted to differentiate APIs for main thread, I think it's better
> to pass the pool struct (according to the name) and the index like:
> 
>   int threadpool__wait_thread(struct threadpool *pool, int idx)
> 
> Then it can get a pointer to the entry easily.

Agree. 
I also need to more clearly separate those APIs too.

> 
> > +{
> > +       int res;
> > +       enum threadpool_msg msg = THREADPOOL_MSG__UNDEFINED;
> > +
> > +       res = readn(thread->pipes.ack[0], &msg, sizeof(msg));
> > +       if (res < 0) {
> > +               pr_debug2("threadpool: failed to recv msg from tid=%d:
> > %s\n",
> > +                      thread->tid, strerror(errno));
> > +               return -THREADPOOL_ERROR__READPIPE;
> > +       }
> > +       if (msg != THREADPOOL_MSG__ACK) {
> > +               pr_debug2("threadpool: received unexpected msg from tid=%d:
> > %s\n",
> > +                      thread->tid, threadpool_msg_tags[msg]);
> > +               return -THREADPOOL_ERROR__INVALIDMSG;
> > +       }
> > +
> > +       pr_debug2("threadpool: received ack from tid=%d\n", thread->tid);
> > +
> > +       return 0;
> > +}
> > +
> > +/**
> > + * threadpool__terminate_thread - send stop signal to thread and wait for
> > ack
> > + *
> > + * NB: call only from main thread!
> > + */
> > +static int threadpool__terminate_thread(struct threadpool_entry *thread)
> 
> Ditto.

ack

> 
> > +{
> > +       int res;
> > +       enum threadpool_msg msg = THREADPOOL_MSG__STOP;
> > +
> > +       res = writen(thread->pipes.cmd[1], &msg, sizeof(msg));
> > +       if (res < 0) {
> > +               pr_debug2("threadpool: error sending stop msg to tid=%d:
> > %s\n",
> > +                       thread->tid, strerror(errno));
> > +               return -THREADPOOL_ERROR__WRITEPIPE;
> > +       }
> > +
> > +       return threadpool__wait_thread(thread);
> > +}
> > +
> 
> [SNIP]
> > @@ -161,12 +326,30 @@ struct threadpool *threadpool__new(int n_threads)
> >   *
> >   * Buffer size should be at least THREADPOOL_STRERR_BUFSIZE bytes.
> >   */
> > -int threadpool__strerror(struct threadpool *pool __maybe_unused, int err,
> > char *buf, size_t size)
> > +int threadpool__strerror(struct threadpool *pool, int err, char *buf,
> > size_t size)
> >  {
> >         char sbuf[STRERR_BUFSIZE], *emsg;
> > +       const char *status_str, *errno_str;
> > 
> > -       emsg = str_error_r(err, sbuf, sizeof(sbuf));
> > -       return scnprintf(buf, size, "Error: %s.\n", emsg);
> > +       status_str = IS_ERR_OR_NULL(pool) ? "error" :
> > threadpool_status_tags[pool->status];
> > +
> > +       switch (err) {
> > +       case -THREADPOOL_ERROR__SIGPROCMASK:
> > +       case -THREADPOOL_ERROR__READPIPE:
> > +       case -THREADPOOL_ERROR__WRITEPIPE:
> > +               emsg = str_error_r(errno, sbuf, sizeof(sbuf));
> > +               errno_str = threadpool_errno_str[-err-
> > THREADPOOL_ERROR__OFFSET];
> > +               return scnprintf(buf, size, "%s: %s.\n", errno_str, emsg);
> > +       case -THREADPOOL_ERROR__INVALIDMSG:
> > +               errno_str = threadpool_errno_str[-err-
> > THREADPOOL_ERROR__OFFSET];
> > +               return scnprintf(buf, size, "%s.\n", errno_str);
> > +       case -THREADPOOL_ERROR__NOTALLOWED:
> > +               return scnprintf(buf, size, "%s (%s).\n",
> > +                       threadpool_errno_str[-err], status_str);
> 
> s/-err/-err-THREADPOOL_ERROR__OFFSET/ ?
> 
> It'd be nice if you calculate the index once.

agreed

> 
> > +       default:
> > +               emsg = str_error_r(err, sbuf, sizeof(sbuf));
> 
> I'm confused whether the 'err' is negative or positive?

It's negative, so it needs to be inverted in this case.

Thanks,
Riccardo

> 
> Thanks,
> Namhyung
> 
> 
> > +               return scnprintf(buf, size, "Error: %s", emsg);
> > +       }
> >  }
> > 


