Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09142C07E95
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BA6613F7
	for <linux-perf-users@archiver.kernel.org>; Fri, 16 Jul 2021 13:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbhGPNjt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 16 Jul 2021 09:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPNjs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 16 Jul 2021 09:39:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1C4C06175F;
        Fri, 16 Jul 2021 06:36:53 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id a23-20020a05600c2257b0290236ec98bebaso3430681wmm.1;
        Fri, 16 Jul 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=bh1fbgJJAMRpo0ekrWYMDCML1c7hFhd4x7I0H+rROSA=;
        b=XieeVH9m6fo2f4pksEiZjb/iyejbJOlbaprxVWUXjDlm8PCZjXfopGJiD6eHzvSxEk
         jG5rEosltYX5q9aM33EEYIsnfENP38wh0648zAfPlHSHX0zmkqrbuJ7gKYWX+5qOYKBS
         f+t/cB2c7r1s38mnayITXdqy+c8nb9cSK8PdGTi7+azbGZQ2wyxHf1CA0TigNDinfnEj
         qpEnHZ3wDOqchZA+gdFkjutkV7Ke43RH5h4XnJaK/Mop4/JWe8CE1vf6GLFBak7SeuZr
         +X8kGTgu/DAbcwN2JmgYVDCRxJoWpEvDDoKASJutDp25z4DXIOAWcOrLRfGiAwzmorb9
         ONig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=bh1fbgJJAMRpo0ekrWYMDCML1c7hFhd4x7I0H+rROSA=;
        b=WYi37/B6nD8eVT7sSUjo3fzs828ObEVKWp0GwXosLM6T3pkNOXqajviqgiUpCCxkmH
         JiqiTPQT5n3hJNJsk9wM8dcp38pQa8Z+UT0LbLn+5r4VwBb7XmRZ4o8WIjBCgxaXlrMz
         CkFi/pH2e6X9Mu1+7/Aw9pc49iwpWPQfY1g/CRvmZzjF3d8W1cTp9qzgEefHbMof4e4n
         zv4GVCe52NZJLrdJEXhkbbkKpfqzez7ajxAiao0x0zaq70s//fFoiWg/Uj1LcZKUdvWl
         xIyWqoZJ+NSUKRQ398eMkdEahsqcsdUj02ELZZUpJ3coMpbeCLV0rf94vmRVBr1Qo1Qw
         eOPA==
X-Gm-Message-State: AOAM530zjFa8LdBl1/1YzODNeVRviJJLQacdIueasTWVPrmuzhFjxRNZ
        FjqxM5zBtpxlGD9Vt23RqFc=
X-Google-Smtp-Source: ABdhPJzShu+P0l9GZrJEM3xUNj9X7LLIMhLllB9nymJUuteMScFsOqN05ZkU0YGFUSgRSLd+t6NQVQ==
X-Received: by 2002:a05:600c:4ed3:: with SMTP id g19mr10349248wmq.145.1626442611548;
        Fri, 16 Jul 2021 06:36:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6456:fd99:ced0:db1c:53e1:191e? ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.gmail.com with ESMTPSA id m6sm13142854wrw.9.2021.07.16.06.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 06:36:50 -0700 (PDT)
Message-ID: <b7aa58d750f5919f30877fe2f9878698f3cddbc4.camel@gmail.com>
Subject: Re: [RFC PATCH 01/10] perf workqueue: threadpool creation and
 destruction
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
Date:   Fri, 16 Jul 2021 15:36:49 +0200
In-Reply-To: <CAM9d7chhjRhif=1+Sjjwrc2p+mLN+Lv4LY8dFZZpk5z5VG-+Pw@mail.gmail.com>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <46f9e291af3d87c212d279717d56eeab4cbfde68.1626177381.git.rickyman7@gmail.com>
         <YO7xpFg0F5Fv/7sI@kernel.org>
         <CAM9d7chhjRhif=1+Sjjwrc2p+mLN+Lv4LY8dFZZpk5z5VG-+Pw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Namhyung,
thanks for the review.

On Thu, 2021-07-15 at 16:29 -0700, Namhyung Kim wrote:
> Hi Riccardo and Arnaldo,
> 
> On Wed, Jul 14, 2021 at 7:16 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > 
> > Em Tue, Jul 13, 2021 at 02:11:12PM +0200, Riccardo Mancini escreveu:
> > > The workqueue library is made up by two components:
> > >  - threadpool: handles the lifetime of the threads
> > >  - workqueue: handles work distribution among the threads
> > > 
> > > This first patch introduces the threadpool, starting from its creation
> > > and destruction functions.
> > > Thread management is based on the prototype from Alexey:
> > > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> > > 
> > > Each thread in the threadpool executes the same function (aka task)
> > > with a different argument tidx.
> > > Threads use a pair of pipes to communicate with the main process.
> > > The threadpool is static (all threads will be spawned at the same time).
> > > Future work could include making it resizable and adding affinity support
> > > (as in Alexey prototype).
> > > 
> > > Suggested-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > > ---
> > >  tools/perf/util/Build                  |   1 +
> > >  tools/perf/util/workqueue/Build        |   1 +
> > >  tools/perf/util/workqueue/threadpool.c | 175 +++++++++++++++++++++++++
> > >  tools/perf/util/workqueue/threadpool.h |  19 +++
> > >  4 files changed, 196 insertions(+)
> > >  create mode 100644 tools/perf/util/workqueue/Build
> > >  create mode 100644 tools/perf/util/workqueue/threadpool.c
> > >  create mode 100644 tools/perf/util/workqueue/threadpool.h
<SNIP>
> > > +
> > > +struct threadpool_struct {
> > 
> > Can this be just 'struct threadpool'? I think its descriptive enough:
> > 
> > > +     int                     nr_threads;     /* number of threads in the
> > > pool */
> > > +     struct thread_struct    *threads;       /* array of threads in the
> > > pool */
> > > +     struct task_struct      *current_task;  /* current executing
> > > function */
> 
> Does this mean it can only have a single function to run?

Yes.

> Why do we need it?

My idea is to separate the workqueue from the actual implementation of the
threads. This way, when the function executing on the threadpool ends, the
threads are kept alive to execute new work. 
By adding this additional layer of abstraction, we can achieve more flexibility.
For example, the use-case I have in mind is to recycle the same threadpool for
both Alexey's threaded trace and the workqueue.
I don't think this could be easily achieved with just the workqueue since the
perf-record threads are not just a task that needs to be executed by they have
specific affinities to be respected.

What are your thoughts?

> 
> 
> > > +     enum threadpool_status  status;         /* current status of the
> > > pool */
> > > +};
> > > +
> > > +struct thread_struct {
> > > +     int                             idx;    /* idx of thread in pool-
> > > >threads */
> > > +     pid_t                           tid;    /* tid of thread */
> > > +     struct threadpool_struct        *pool;  /* parent threadpool */
> > > +     struct {
> > > +             int from[2];                    /* messages from thread
> > > (acks) */
> > > +             int to[2];                      /* messages to thread
> > > (commands) */
> 
> It can be confusing if you think from the main thread.
> Maybe 'ack' and 'cmd' would be better.

Agreed.

> 
> 
> > > +     } pipes;
> > > +};
> > 
> > This one, since we have already a 'struct thread' in tools/perf, to
> > represent a PERF_RECORD_FORK, perhaps we can call it 'struct
> > threadpool_entry'?
> 
> I think we can even use 'worker' instead of 'thread' but it requires
> huge renaming and conflicts so I won't insist on it strongly.  :)

Also, worker internally conflicts with the workqueue's worker, which runs on a
(threadpool-)thread.
Another name I had in mind is pool_thread to prevent having too many 'thread' in
the name, but it might be confusing.
I think threadpool_entry is fine.

I have another question.
In general, when should I use zfree instead of free?

Thanks,
Riccardo

> 
> Thanks,
> Namhyung


