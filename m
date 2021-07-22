Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC14DC6377D
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41C56128C
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhGVPfl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 11:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbhGVPfl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 11:35:41 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53609C061575;
        Thu, 22 Jul 2021 09:16:14 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n1so6507711wri.10;
        Thu, 22 Jul 2021 09:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=iQYWSnZ/6PjfGdSChJbuu3B34GWztbBSbniPKOWI1lk=;
        b=g9dzTxSs5GNB1pz/ITivhant+Q354d0+HbkjnTRF63imjYZa159rm0UTDf5wZoPZ/I
         LITgFTU8ALrCU4w5xhsRkDzXUFbfPfc8sbbPDjuLE+0Ki+wDogcnBv+qlXgGRvHmIrSF
         t8Pa20G30wDHG9R3IN4Da8dU4IsCwJWuVu7DXOBeSc3wtAJSX9SPkngQqittKN94tToi
         k87QNxPKcjbTU2teYezH/JIvxnpzfDSt22eLpadttBJC71we3FIP/02QWzDp1AJyYCes
         IslY0io8rdgX0uSRyuohkp/uIYgMD0k6VFNo8WBvK+3uFLUS9J5yYZu8L9L+BrGWIP7C
         0k7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=iQYWSnZ/6PjfGdSChJbuu3B34GWztbBSbniPKOWI1lk=;
        b=mqH6ziigmSmJ1odCcu1i7xuQC39yQxiCKPHrbfxZWhfZxrr2GBs+zWVihPBjGzSIrq
         W3hD3hXGUJfHsAOWw5K7tyoosilStVgpzsz8B1dasfuwz8Ph25PJ/Bb+GLCHZ17VED6Y
         S6AshMnR+y4B44gV55twoAR5f+h+pUp3MKTf+OrqaYXK5McMKieHgg4c8vsj+3qaUkos
         kUmhliUS2Zxokol3Q2/Ylciz178Rbh0Pjxe2Br0UEW5YvKQrv/B6NZkR87+OeqEAtG1b
         3g2DcdqtQc1vYd8uclN4mKhRPb4Vr0oVpqPymH6xiNfWwSMSQg0xeBY7+K17uWU09fPD
         r/Sg==
X-Gm-Message-State: AOAM532iUaDNcgk3NRYueya7zmLMrgwBivpcl9A/ErxjebP6XI1coGRK
        NlOmQml3dUpQjHSlbXTKsLY=
X-Google-Smtp-Source: ABdhPJw12V5yMpNOV1oISUFAqrKnm66M94Xodmpxhki2r08WGjWxMZ4ayRaaNDYpBKshRPacjvCkgA==
X-Received: by 2002:adf:f411:: with SMTP id g17mr784407wro.160.1626970572854;
        Thu, 22 Jul 2021 09:16:12 -0700 (PDT)
Received: from [192.168.1.75] ([185.91.190.155])
        by smtp.gmail.com with ESMTPSA id q81sm3528885wme.18.2021.07.22.09.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:16:12 -0700 (PDT)
Message-ID: <5fc68331f925419c26a01ff678c17339a4735e93.camel@gmail.com>
Subject: Re: [RFC PATCH 00/10] perf: add workqueue library and use it in
 synthetic-events
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Date:   Thu, 22 Jul 2021 18:15:19 +0200
In-Reply-To: <YPXq95yUYo+cH740@krava>
References: <cover.1626177381.git.rickyman7@gmail.com>
         <YPXq95yUYo+cH740@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Jiri,

On Mon, 2021-07-19 at 23:13 +0200, Jiri Olsa wrote:
> On Tue, Jul 13, 2021 at 02:11:11PM +0200, Riccardo Mancini wrote:
> > This patchset introduces a new utility library inside perf/util, which
> > provides a work queue abstraction, which loosely follows the Kernel
> > workqueue API.
> > 
> > The workqueue abstraction is made up by two components:
> >  - threadpool: which takes care of managing a pool of threads. It is
> >    inspired by the prototype for threaded trace in perf-record from Alexey:
> >   
> > https://lore.kernel.org/lkml/cover.1625227739.git.alexey.v.bayduraev@linux.intel.com/
> >  - workqueue: manages a shared queue and provides the workers
> > implementation.
> > 
> > On top of the workqueue, a simple parallel-for utility is implemented
> > which is then showcased in synthetic-events.c, replacing the previous
> > manual pthread-created threads.
> > 
> > Through some experiments with perf bench, I can see how the new 
> > workqueue has a higher overhead compared to manual creation of threads, 
> > but is able to more effectively partition work among threads, yielding 
> > a better result with more threads.
> > Furthermore, the overhead could be configured by changing the
> > `work_size` (currently 1), aka the number of dirents that are 
> > processed by a thread before grabbing a lock to get the new work item.
> > I experimented with different sizes but, while bigger sizes reduce overhead
> > as expected, they do not scale as well to more threads.
> > 
> > I tried to keep the patchset as simple as possible, deferring possible
> > improvements and features to future work.
> > Naming a few:
> >  - in order to achieve a better performance, we could consider using 
> >    work-stealing instead of a common queue.
> >  - affinities in the thread pool, as in Alexey prototype for
> >    perf-record. Doing so would enable reusing the same threadpool for
> >    different purposes (evlist open, threaded trace, synthetic threads),
> >    avoiding having to spin up threads multiple times.
> >  - resizable threadpool, e.g. for lazy spawining of threads.
> > 
> > @Arnaldo
> > Since I wanted the workqueue to provide a similar API to the Kernel's
> > workqueue, I followed the naming style I found there, instead of the
> > usual object__method style that is typically found in perf. 
> > Let me know if you'd like me to follow perf style instead.
> > 
> > Thanks,
> > Riccardo
> > 
> > Riccardo Mancini (10):
> >   perf workqueue: threadpool creation and destruction
> >   perf tests: add test for workqueue
> >   perf workqueue: add threadpool start and stop functions
> >   perf workqueue: add threadpool execute and wait functions
> >   perf workqueue: add sparse annotation header
> >   perf workqueue: introduce workqueue struct
> >   perf workqueue: implement worker thread and management
> >   perf workqueue: add queue_work and flush_workqueue functions
> >   perf workqueue: add utility to execute a for loop in parallel
> >   perf synthetic-events: use workqueue parallel_for
> 
> looks great, would it make sense to put this to libperf?

I don't know about libperf in particular. 
The idea is to start using it in perf and, if everything goes well, to put it in
lib/ so that everyone interested in it could just include it.
Since I'm looking for other parts where a workqueue could be useful, if you know
of some in libperf, I could try having a look at them too.

Riccardo

> 
> jirka
> 
> > 
> >  tools/perf/tests/Build                 |   1 +
> >  tools/perf/tests/builtin-test.c        |   9 +
> >  tools/perf/tests/tests.h               |   3 +
> >  tools/perf/tests/workqueue.c           | 453 +++++++++++++++++
> >  tools/perf/util/Build                  |   1 +
> >  tools/perf/util/synthetic-events.c     | 131 +++--
> >  tools/perf/util/workqueue/Build        |   2 +
> >  tools/perf/util/workqueue/sparse.h     |  21 +
> >  tools/perf/util/workqueue/threadpool.c | 516 ++++++++++++++++++++
> >  tools/perf/util/workqueue/threadpool.h |  29 ++
> >  tools/perf/util/workqueue/workqueue.c  | 642 +++++++++++++++++++++++++
> >  tools/perf/util/workqueue/workqueue.h  |  38 ++
> >  12 files changed, 1771 insertions(+), 75 deletions(-)
> >  create mode 100644 tools/perf/tests/workqueue.c
> >  create mode 100644 tools/perf/util/workqueue/Build
> >  create mode 100644 tools/perf/util/workqueue/sparse.h
> >  create mode 100644 tools/perf/util/workqueue/threadpool.c
> >  create mode 100644 tools/perf/util/workqueue/threadpool.h
> >  create mode 100644 tools/perf/util/workqueue/workqueue.c
> >  create mode 100644 tools/perf/util/workqueue/workqueue.h
> > 
> > -- 
> > 2.31.1
> > 
> 


