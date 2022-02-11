Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA6AC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Feb 2022 19:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbiBKTfV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Feb 2022 14:35:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352904AbiBKTfU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Feb 2022 14:35:20 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3CD43
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 11:35:18 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v186so28035054ybg.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Feb 2022 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TPp6AoNDxBkfRCJSXj0qQyodttHS7zPVJ6Ce2h9Sr5U=;
        b=Qfvb7JOp+pwaBeEHLoBDGlG2iOb8GR8VEq0aONvJ4y5KQtA3rqFGfCXFYGfoKTyMOe
         tVvlKI4HbnxSn6bKMUPKL1/4JQL/cFr/MATcZJPvpz1qfqBoBphdHDwjWCQ+gobtHDso
         zkWip9egACspNUy0G6XMLSAuVVKWiO81fhGQbmA+JwXvAbFdRSfS3Quv8co7mXGJsE58
         fFsbm3/J3JjFJ16GgRjuHEJXe3Stm7ga1xpGxDoVxDixtEDEh0kow5/3JfDVeNyGrD0i
         sRwJOVHxui8WU88xlx22RxRlTBEpfMUgRs9YIpUeyGxhb8j0pVe04N5/7MYL/GFN6A0E
         +4pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TPp6AoNDxBkfRCJSXj0qQyodttHS7zPVJ6Ce2h9Sr5U=;
        b=vYz8fZBQc1PEQl7a50nje5IeMphbFZAT5klYwzW7N2GiYj7Yl2U0/aOP5KI2spJWYX
         nim7eGw0FiGYgOF5TY6ubKdXFIQB8mf0PRXLXFDXME0Snq2QlyJKA9Zug30YZPMTcA9V
         jAmPaOUoIFYMAA2UpaZaO3W+dWgq192E1vGzC1OHU75PnWSwHPRi5ba2zLEbZugguEkP
         SpW5cuf2VqFsN6pX6SOPoigdaSrQNf4iEWfoNV54lqbOSZwE6E42iCPLyJtLfZ/YNXqq
         vCoHpYdbvDqOlHixDqdjbltH3vvgyvXrKLkHsvTxfBe9SmHrjrGlCNvLHLlF1poDnuZz
         1Ftw==
X-Gm-Message-State: AOAM532R+FFae2zO5j8m5Hp9DLsLSqC0hq5Nz1WkJgh6qU4ZOLIito0J
        8PvcA7pS4vOE7T8gtoGkepzlqM177YalRkRMRI0+Lg==
X-Google-Smtp-Source: ABdhPJwNlALJbQ//piIdwmrWVEz0xwTOfNaKu+nly2Z1rkmZiv8cuZOUvv5dPWK2opDkixd6/xqweVo1GZRAfI07i9c=
X-Received: by 2002:a25:d7d0:: with SMTP id o199mr2840524ybg.34.1644608117621;
 Fri, 11 Feb 2022 11:35:17 -0800 (PST)
MIME-Version: 1.0
References: <20220211103415.2737789-1-irogers@google.com> <20220211103415.2737789-4-irogers@google.com>
 <YgaZSk8h6rQ6MgLy@kernel.org> <CAP-5=fWZTmbQpmoXRKt9HdMU-E_B2uo5b4BHOW6RC6w5VkQ0AQ@mail.gmail.com>
 <Yga3JNhTfSBR3btI@kernel.org>
In-Reply-To: <Yga3JNhTfSBR3btI@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 11 Feb 2022 11:35:05 -0800
Message-ID: <CAP-5=fVb=1prv6kkUzJRiPNSsudBhU1+YLBqnBrWiut3XQLJqg@mail.gmail.com>
Subject: Re: [PATCH v3 03/22] perf dso: Make lock error check and add BUG_ONs
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Feb 11, 2022 at 11:21 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Feb 11, 2022 at 09:43:19AM -0800, Ian Rogers escreveu:
> > On Fri, Feb 11, 2022 at 9:13 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Fri, Feb 11, 2022 at 02:33:56AM -0800, Ian Rogers escreveu:
> > > > Make the pthread mutex on dso use the error check type. This allows
> > > > deadlock checking via the return type. Assert the returned value from
> > > > mutex lock is always 0.
> > >
> > > I think this is too blunt/pervasive source code wise, perhaps we should
> > > wrap this like its done with rwsem in tools/perf/util/rwsem.h to get
> > > away from pthreads primitives and make the source code look more like
> > > a kernel one and then, taking advantage of the so far ideologic
> > > needless indirection, add this BUG_ON if we build with "DEBUG=1" or
> > > something, wdyt?
> >
>
> > My concern with semaphores is that they are a concurrency primitive
>
> I'm not suggesting we switch over to semaphores, just to use the same
> technique of wrapping pthread_mutex_t with some other API that then
> allows us to add these BUG_ON() calls without polluting the source code
> in many places.

Sounds simple enough and would ensure consistency too. I can add it to
the front of this set of changes. A different approach would be to
take what's here and then refactor and cleanup as a follow on patch
set. I'd prefer that as the size of this set of changes is already
larger than I like - albeit that most of it is just introducing the
use of functions to access struct variables. Perhaps I just remove the
BUG_ON and pthread changes here, we work to get this landed and in a
separate set of patches clean up the pthread mutex code to have better
bug checking.

Thanks,
Ian

> - Arnaldo
>
> > that has more flexibility and power than a mutex. I like a mutex as it
> > is quite obvious what is going on and that is good from a tooling
> > point of view. A deadlock with two mutexes is easy to understand. On a
> > semaphore, were we using it like a condition variable? There's more to
> > figure out. I also like the idea of compiling the perf command with
> > emscripten, we could then generate say perf annotate output in your
> > web browser. Emscripten has implementations of standard posix
> > libraries including pthreads, but we may need to have two approaches
> > in the perf code if we want to compile with emscripten and use
> > semaphores when targeting linux.
> >
> > Where this change comes from is that I worried that extending the
> > locked regions to cover the race that'd been found would then expose
> > the kind of recursive deadlock that pthread mutexes all too willingly
> > allow. With this code we at least see the bug and don't just hang. I
> > don't think we need the change to the mutexes for this change, but we
> > do need to extend the regions to fix the data race.
> >
> > Let me know how you prefer it and I can roll it into a v4 version.
> >
> > Thanks,
> > Ian
> >
> > > - Arnaldo
> > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/util/dso.c    | 12 +++++++++---
> > > >  tools/perf/util/symbol.c |  2 +-
> > > >  2 files changed, 10 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > > > index 9cc8a1772b4b..6beccffeef7b 100644
> > > > --- a/tools/perf/util/dso.c
> > > > +++ b/tools/perf/util/dso.c
> > > > @@ -784,7 +784,7 @@ dso_cache__free(struct dso *dso)
> > > >       struct rb_root *root = &dso->data.cache;
> > > >       struct rb_node *next = rb_first(root);
> > > >
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > >       while (next) {
> > > >               struct dso_cache *cache;
> > > >
> > > > @@ -830,7 +830,7 @@ dso_cache__insert(struct dso *dso, struct dso_cache *new)
> > > >       struct dso_cache *cache;
> > > >       u64 offset = new->offset;
> > > >
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > >       while (*p != NULL) {
> > > >               u64 end;
> > > >
> > > > @@ -1259,6 +1259,8 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
> > > >       struct dso *dso = calloc(1, sizeof(*dso) + strlen(name) + 1);
> > > >
> > > >       if (dso != NULL) {
> > > > +             pthread_mutexattr_t lock_attr;
> > > > +
> > > >               strcpy(dso->name, name);
> > > >               if (id)
> > > >                       dso->id = *id;
> > > > @@ -1286,8 +1288,12 @@ struct dso *dso__new_id(const char *name, struct dso_id *id)
> > > >               dso->root = NULL;
> > > >               INIT_LIST_HEAD(&dso->node);
> > > >               INIT_LIST_HEAD(&dso->data.open_entry);
> > > > -             pthread_mutex_init(&dso->lock, NULL);
> > > > +             pthread_mutexattr_init(&lock_attr);
> > > > +             pthread_mutexattr_settype(&lock_attr, PTHREAD_MUTEX_ERRORCHECK);
> > > > +             pthread_mutex_init(&dso->lock, &lock_attr);
> > > > +             pthread_mutexattr_destroy(&lock_attr);
> > > >               refcount_set(&dso->refcnt, 1);
> > > > +
> > > >       }
> > > >
> > > >       return dso;
> > > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > > index b2ed3140a1fa..43f47532696f 100644
> > > > --- a/tools/perf/util/symbol.c
> > > > +++ b/tools/perf/util/symbol.c
> > > > @@ -1783,7 +1783,7 @@ int dso__load(struct dso *dso, struct map *map)
> > > >       }
> > > >
> > > >       nsinfo__mountns_enter(dso->nsinfo, &nsc);
> > > > -     pthread_mutex_lock(&dso->lock);
> > > > +     BUG_ON(pthread_mutex_lock(&dso->lock) != 0);
> > > >
> > > >       /* check again under the dso->lock */
> > > >       if (dso__loaded(dso)) {
> > > > --
> > > > 2.35.1.265.g69c8d7142f-goog
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
