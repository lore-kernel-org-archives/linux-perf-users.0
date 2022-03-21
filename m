Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F87C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 21 Mar 2022 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245549AbiCULMg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Mar 2022 07:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbiCULMf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Mar 2022 07:12:35 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4E14FBBB
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 04:11:06 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k6so5242713plg.12
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Mar 2022 04:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RPwweG7806X5qZn4WMYFAM6UEvOeIAIa+TUx0gcZXAo=;
        b=KNvYPZYqJpYJuJx/yLP6D8+i3V66L6kyy6ICoyZ/k0p/ejfBMyyHR+NVf/yH/CiBeU
         I2dmlAIj1gM/5D6r4UDW0mLkWQs7qFUSbTRGCGUu9+jTzknKYeVLAf6Hj+/hSUgEGDkH
         80gJ1OingTwncEgePhLTaOT48xFvN3qUFMhZ4IALSJqJ3YT+EP3KkmG8KEsVaUO1ByML
         szkKy4uTnTAq3FdLMCK9Z7WKJVsHSa1FRXtE3uD8zlORKu0zhQiNuzCoJYiB4dAjwOTt
         qYrMy4cMsVn5mgwhT9Qm/dq5d21NmypIfnSdgJWLSGJ1Movd4dUZQ3DIJkEYvf93cfgO
         bKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RPwweG7806X5qZn4WMYFAM6UEvOeIAIa+TUx0gcZXAo=;
        b=Udx9tgC9Bjf3QEz70aoJxBRR+cxqgSU8AnaK+/+LZshE0PpClMfQKKkITp6XXIe3g9
         ZoFAkCT53VpRJYOmdha71wSaazNXiESlgDKv1zSq7YeDS7W4obMvlA135e54ezv7/Q4I
         E6gm7GhpLN3rp75gUppMtgHptw+iPBT0XyVSVOFk9ZHXOCQaByaV5EnX+T4HU7G+V+cK
         OU1KMNBTEtH183Ly07whvw8KHmIJbd8U88PjfV/rMyeihOjxuTWlJbaSG0tV+OJ78jJa
         zNchTaxqrtADzjgQub26SzPfTJysmnBAA9Vay6hC4KDI1xAculjFrkoDvWmrnT9f2v2r
         pkjg==
X-Gm-Message-State: AOAM533s+WQBvxUam319GUKSYw73Jxeq90v4urFAk+WTpVAlotslx2J5
        ROZkOMHWlWKFI9WWSj1aYLUeedpFPm+oHOhB+pTRm9lvN3E=
X-Google-Smtp-Source: ABdhPJzKkqA/YazJ3KJ2xY4qg9i6zmLBz8cZYdkmhnenOKCnXtNygDUN7FL7BdiKT3l/TG2zV/F69b9gtvkWOPWsIhc=
X-Received: by 2002:a17:903:285:b0:154:6770:ea77 with SMTP id
 j5-20020a170903028500b001546770ea77mr2389673plr.85.1647861065768; Mon, 21 Mar
 2022 04:11:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220221102628.43904-1-tz.stoyanov@gmail.com> <YhPsKeK0UdjiDN1R@krava>
 <YhV+LpjwXw3mai16@kernel.org> <YhY3FV9s+pIJ4Z1v@krava> <YhZTH+l+JJ8E4O5C@kernel.org>
In-Reply-To: <YhZTH+l+JJ8E4O5C@kernel.org>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Mon, 21 Mar 2022 13:10:49 +0200
Message-ID: <CAPpZLN4Nov2XGE1FQ4FAU7JKSmUfDK0+VdZcnCO-WkTAE-LoBA@mail.gmail.com>
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Feb 23, 2022 at 5:30 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Feb 23, 2022 at 02:31:01PM +0100, Jiri Olsa escreveu:
> > On Tue, Feb 22, 2022 at 09:22:06PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Feb 21, 2022 at 08:46:49PM +0100, Jiri Olsa escreveu:
> > > > On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > > > The existing API perf_thread_map__new_dummy() allocates new thread map
> > > > > for one thread. I couldn't find a way to reallocate the map with more
> > > > > threads, or to allocate a new map for more than one thread. Having
> > > > > multiple threads in a thread map is essential for some use cases.
> > > > > That's why a new API is proposed, which allocates a new thread map
> > > > > for given number of threads:
> > > > >  perf_thread_map__new_array()
> > > > >
> > > > > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > > > ---
> > > > > v2 changes:
> > > > >  - Changed the new API as Arnaldo suggested - get number of threads in the
> > > > >    map and array with initial values (optional).
> > > >
> > > > looks good, would you also find useful in your use case the comm support
> > >
> > > Is that an Acked-by? :-)
> >
> > yes, I wasn't sure about the previous args name changes,
> > this one is fine
> >
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
>
> Ok, applying this one after applying the arg name changes one, please
> confirm if you agree with that one.
>
> - Arnaldo

ping
Please, can you merge this one, If there are no problems with the
code. We would like to use the new API perf_thread_map__new_array().
Thanks!


>
> > thanks,
> > jirka
> >
> > >
> > > - Arnaldo
> > >
> > > > in thread_map? the thread_map__read_comms function? we could move it from
> > > > perf to libperf
> > > >
> > > > thanks,
> > > > jirka
> > > >
> > > > >
> > > > >  tools/lib/perf/Documentation/libperf.txt |  1 +
> > > > >  tools/lib/perf/include/perf/threadmap.h  |  1 +
> > > > >  tools/lib/perf/libperf.map               |  1 +
> > > > >  tools/lib/perf/tests/test-threadmap.c    | 41 ++++++++++++++++++++++++
> > > > >  tools/lib/perf/threadmap.c               | 24 ++++++++++----
> > > > >  5 files changed, 61 insertions(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > > > index a21f733b95b1..a8f1a237931b 100644
> > > > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > > > @@ -62,6 +62,7 @@ SYNOPSIS
> > > > >    struct perf_thread_map;
> > > > >
> > > > >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> > > > > +  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> > > > >
> > > > >    void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > > > >    char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > > > > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > > > > index 58f7fbdce446..8b40e7777cea 100644
> > > > > --- a/tools/lib/perf/include/perf/threadmap.h
> > > > > +++ b/tools/lib/perf/include/perf/threadmap.h
> > > > > @@ -8,6 +8,7 @@
> > > > >  struct perf_thread_map;
> > > > >
> > > > >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> > > > > +LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> > > > >
> > > > >  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > > > >  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > > > > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > > > > index 6fa0d651576b..190b56ae923a 100644
> > > > > --- a/tools/lib/perf/libperf.map
> > > > > +++ b/tools/lib/perf/libperf.map
> > > > > @@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
> > > > >                 perf_cpu_map__empty;
> > > > >                 perf_cpu_map__max;
> > > > >                 perf_cpu_map__has;
> > > > > +               perf_thread_map__new_array;
> > > > >                 perf_thread_map__new_dummy;
> > > > >                 perf_thread_map__set_pid;
> > > > >                 perf_thread_map__comm;
> > > > > diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> > > > > index 5e2a0291e94c..f728ad7002bb 100644
> > > > > --- a/tools/lib/perf/tests/test-threadmap.c
> > > > > +++ b/tools/lib/perf/tests/test-threadmap.c
> > > > > @@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level level,
> > > > >         return vfprintf(stderr, fmt, ap);
> > > > >  }
> > > > >
> > > > > +static int test_threadmap_array(int nr, pid_t *array)
> > > > > +{
> > > > > +       struct perf_thread_map *threads;
> > > > > +       int i;
> > > > > +
> > > > > +       threads = perf_thread_map__new_array(nr, array);
> > > > > +       __T("Failed to allocate new thread map", threads);
> > > > > +
> > > > > +       __T("Unexpected number of threads", perf_thread_map__nr(threads) == nr);
> > > > > +
> > > > > +       for (i = 0; i < nr; i++) {
> > > > > +               __T("Unexpected initial value of thread",
> > > > > +                   perf_thread_map__pid(threads, i) == (array ? array[i] : -1));
> > > > > +       }
> > > > > +
> > > > > +       for (i = 1; i < nr; i++)
> > > > > +               perf_thread_map__set_pid(threads, i, i * 100);
> > > > > +
> > > > > +       __T("Unexpected value of thread 0",
> > > > > +           perf_thread_map__pid(threads, 0) == (array ? array[0] : -1));
> > > > > +
> > > > > +       for (i = 1; i < nr; i++) {
> > > > > +               __T("Unexpected thread value",
> > > > > +                   perf_thread_map__pid(threads, i) == i * 100);
> > > > > +       }
> > > > > +
> > > > > +       perf_thread_map__put(threads);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > > +#define THREADS_NR     10
> > > > >  int test_threadmap(int argc, char **argv)
> > > > >  {
> > > > >         struct perf_thread_map *threads;
> > > > > +       pid_t thr_array[THREADS_NR];
> > > > > +       int i;
> > > > >
> > > > >         __T_START;
> > > > >
> > > > > @@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
> > > > >         perf_thread_map__put(threads);
> > > > >         perf_thread_map__put(threads);
> > > > >
> > > > > +       test_threadmap_array(THREADS_NR, NULL);
> > > > > +
> > > > > +       for (i = 0; i < THREADS_NR; i++)
> > > > > +               thr_array[i] = i + 100;
> > > > > +
> > > > > +       test_threadmap_array(THREADS_NR, thr_array);
> > > > > +
> > > > >         __T_END;
> > > > >         return tests_failed == 0 ? 0 : -1;
> > > > >  }
> > > > > diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> > > > > index 84fa07c79d00..07968f3ea093 100644
> > > > > --- a/tools/lib/perf/threadmap.c
> > > > > +++ b/tools/lib/perf/threadmap.c
> > > > > @@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
> > > > >         return map->map[idx].comm;
> > > > >  }
> > > > >
> > > > > -struct perf_thread_map *perf_thread_map__new_dummy(void)
> > > > > +struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array)
> > > > >  {
> > > > > -       struct perf_thread_map *threads = thread_map__alloc(1);
> > > > > +       struct perf_thread_map *threads = thread_map__alloc(nr_threads);
> > > > > +       int i;
> > > > > +
> > > > > +       if (!threads)
> > > > > +               return NULL;
> > > > > +
> > > > > +       for (i = 0; i < nr_threads; i++)
> > > > > +               perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
> > > > > +
> > > > > +       threads->nr = nr_threads;
> > > > > +       refcount_set(&threads->refcnt, 1);
> > > > >
> > > > > -       if (threads != NULL) {
> > > > > -               perf_thread_map__set_pid(threads, 0, -1);
> > > > > -               threads->nr = 1;
> > > > > -               refcount_set(&threads->refcnt, 1);
> > > > > -       }
> > > > >         return threads;
> > > > >  }
> > > > >
> > > > > +struct perf_thread_map *perf_thread_map__new_dummy(void)
> > > > > +{
> > > > > +       return perf_thread_map__new_array(1, NULL);
> > > > > +}
> > > > > +
> > > > >  static void perf_thread_map__delete(struct perf_thread_map *threads)
> > > > >  {
> > > > >         if (threads) {
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo



--
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
