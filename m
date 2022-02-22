Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E2FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Feb 2022 02:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiBVCVv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:21:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBVCVv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 21:21:51 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD66A25C50
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 18:21:26 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id i1so534946plr.2
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 18:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Efp9ZkrLJGA2nfuCwz6ZqMPeoLDGcAMe7CbB3pc+p2g=;
        b=QPl3947dNmqjiQUEGA09sPKw74ro9D8FY/RSkP1Y0mapv7mdJ16BWA3KIpDC59LT64
         lJp+oBIj/6rxw1xRCUmdAwyU/W2QL8fgQyO9Idf8FEuiWkDVIB4RvOhUEM/KdMTFA+a7
         5QR7IFSrlY7Mrj6ABgtPrOd4OVgG26T6+nHqFpDNrZPPQH1VJY6vVjm6OAhANwKc8TJA
         PqCWyrIygrPYEt7Fzd7m0jSQaAAadtElhtGOwQhwJFFn/FIXCCprKGH1d7srvbD3QwtG
         PzQXPybuBmfYVVSHGATPXOyrsWxklRnkMf8L+Nn7A0vc47G5Ri4DfGod4Vej5khDzMcp
         36Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Efp9ZkrLJGA2nfuCwz6ZqMPeoLDGcAMe7CbB3pc+p2g=;
        b=flpktRp2dyjN9h6zK7/TzbKYliMWCQFnRmF3bM2xWsq9qi34yYJyPUMD0adDwcMb9d
         FEE4olNC5jWEir2nOT+raTaSdkt9VuevNC0+fmONMLnELef3SEo0onRWXozVOoODzXGV
         knJBD+V+ABU34bPjqqK45xISMbsmr03y+9ifP80llo5BfkrfNFUIrugZiV0uVy4RNYZe
         q5U+pVutNrMFmD+0KAl47maMUU+uyYEHaE4O+hAFiN0WFeOqPafB1cLEwAle47dUdNOn
         ydObeulSmOXGWv6sh+56G/YU5V2y9e2NCoqPmXkSVGQVLnsXPbMYkjAPyDyb9vianr29
         fjSw==
X-Gm-Message-State: AOAM533g4MCNl4vw7mrQJ+5KpTDbAujBZhrqE63IzPTWQk99NBs/e40H
        RPV6mq7FEiquhN4EOD3M2GmEklmJkSHeBXlxiB0=
X-Google-Smtp-Source: ABdhPJwwZIgXdAaL7UvJbJsU+zMrOuh5UpLbW2nwmX/pPZGk2jTdfWKRl7+sb/EvrGMCkv8SFpxEfMBWHoVIIA38SHg=
X-Received: by 2002:a17:90b:789:b0:1bc:293c:1445 with SMTP id
 l9-20020a17090b078900b001bc293c1445mr1773062pjz.111.1645496486250; Mon, 21
 Feb 2022 18:21:26 -0800 (PST)
MIME-Version: 1.0
References: <20220221102628.43904-1-tz.stoyanov@gmail.com> <YhPsKeK0UdjiDN1R@krava>
In-Reply-To: <YhPsKeK0UdjiDN1R@krava>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Tue, 22 Feb 2022 04:21:10 +0200
Message-ID: <CAPpZLN6ZVXQmjig-EUT_vVrNO6WgXouf_bnhNCBk8TVnR0du8Q@mail.gmail.com>
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 21, 2022 at 9:46 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > The existing API perf_thread_map__new_dummy() allocates new thread map
> > for one thread. I couldn't find a way to reallocate the map with more
> > threads, or to allocate a new map for more than one thread. Having
> > multiple threads in a thread map is essential for some use cases.
> > That's why a new API is proposed, which allocates a new thread map
> > for given number of threads:
> >  perf_thread_map__new_array()
> >
> > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > ---
> > v2 changes:
> >  - Changed the new API as Arnaldo suggested - get number of threads in the
> >    map and array with initial values (optional).
>
> looks good, would you also find useful in your use case the comm support
> in thread_map? the thread_map__read_comms function? we could move it from
> perf to libperf
>

Yes, we definitely need that functionality. I implemented that in our
code, but if there is support in libperf - I prefer to use it.
Thanks!

> thanks,
> jirka
>
> >
> >  tools/lib/perf/Documentation/libperf.txt |  1 +
> >  tools/lib/perf/include/perf/threadmap.h  |  1 +
> >  tools/lib/perf/libperf.map               |  1 +
> >  tools/lib/perf/tests/test-threadmap.c    | 41 ++++++++++++++++++++++++
> >  tools/lib/perf/threadmap.c               | 24 ++++++++++----
> >  5 files changed, 61 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > index a21f733b95b1..a8f1a237931b 100644
> > --- a/tools/lib/perf/Documentation/libperf.txt
> > +++ b/tools/lib/perf/Documentation/libperf.txt
> > @@ -62,6 +62,7 @@ SYNOPSIS
> >    struct perf_thread_map;
> >
> >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> > +  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> >
> >    void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> >    char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > index 58f7fbdce446..8b40e7777cea 100644
> > --- a/tools/lib/perf/include/perf/threadmap.h
> > +++ b/tools/lib/perf/include/perf/threadmap.h
> > @@ -8,6 +8,7 @@
> >  struct perf_thread_map;
> >
> >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> > +LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> >
> >  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> >  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > index 6fa0d651576b..190b56ae923a 100644
> > --- a/tools/lib/perf/libperf.map
> > +++ b/tools/lib/perf/libperf.map
> > @@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
> >               perf_cpu_map__empty;
> >               perf_cpu_map__max;
> >               perf_cpu_map__has;
> > +             perf_thread_map__new_array;
> >               perf_thread_map__new_dummy;
> >               perf_thread_map__set_pid;
> >               perf_thread_map__comm;
> > diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> > index 5e2a0291e94c..f728ad7002bb 100644
> > --- a/tools/lib/perf/tests/test-threadmap.c
> > +++ b/tools/lib/perf/tests/test-threadmap.c
> > @@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level level,
> >       return vfprintf(stderr, fmt, ap);
> >  }
> >
> > +static int test_threadmap_array(int nr, pid_t *array)
> > +{
> > +     struct perf_thread_map *threads;
> > +     int i;
> > +
> > +     threads = perf_thread_map__new_array(nr, array);
> > +     __T("Failed to allocate new thread map", threads);
> > +
> > +     __T("Unexpected number of threads", perf_thread_map__nr(threads) == nr);
> > +
> > +     for (i = 0; i < nr; i++) {
> > +             __T("Unexpected initial value of thread",
> > +                 perf_thread_map__pid(threads, i) == (array ? array[i] : -1));
> > +     }
> > +
> > +     for (i = 1; i < nr; i++)
> > +             perf_thread_map__set_pid(threads, i, i * 100);
> > +
> > +     __T("Unexpected value of thread 0",
> > +         perf_thread_map__pid(threads, 0) == (array ? array[0] : -1));
> > +
> > +     for (i = 1; i < nr; i++) {
> > +             __T("Unexpected thread value",
> > +                 perf_thread_map__pid(threads, i) == i * 100);
> > +     }
> > +
> > +     perf_thread_map__put(threads);
> > +
> > +     return 0;
> > +}
> > +
> > +#define THREADS_NR   10
> >  int test_threadmap(int argc, char **argv)
> >  {
> >       struct perf_thread_map *threads;
> > +     pid_t thr_array[THREADS_NR];
> > +     int i;
> >
> >       __T_START;
> >
> > @@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
> >       perf_thread_map__put(threads);
> >       perf_thread_map__put(threads);
> >
> > +     test_threadmap_array(THREADS_NR, NULL);
> > +
> > +     for (i = 0; i < THREADS_NR; i++)
> > +             thr_array[i] = i + 100;
> > +
> > +     test_threadmap_array(THREADS_NR, thr_array);
> > +
> >       __T_END;
> >       return tests_failed == 0 ? 0 : -1;
> >  }
> > diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> > index 84fa07c79d00..07968f3ea093 100644
> > --- a/tools/lib/perf/threadmap.c
> > +++ b/tools/lib/perf/threadmap.c
> > @@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
> >       return map->map[idx].comm;
> >  }
> >
> > -struct perf_thread_map *perf_thread_map__new_dummy(void)
> > +struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array)
> >  {
> > -     struct perf_thread_map *threads = thread_map__alloc(1);
> > +     struct perf_thread_map *threads = thread_map__alloc(nr_threads);
> > +     int i;
> > +
> > +     if (!threads)
> > +             return NULL;
> > +
> > +     for (i = 0; i < nr_threads; i++)
> > +             perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
> > +
> > +     threads->nr = nr_threads;
> > +     refcount_set(&threads->refcnt, 1);
> >
> > -     if (threads != NULL) {
> > -             perf_thread_map__set_pid(threads, 0, -1);
> > -             threads->nr = 1;
> > -             refcount_set(&threads->refcnt, 1);
> > -     }
> >       return threads;
> >  }
> >
> > +struct perf_thread_map *perf_thread_map__new_dummy(void)
> > +{
> > +     return perf_thread_map__new_array(1, NULL);
> > +}
> > +
> >  static void perf_thread_map__delete(struct perf_thread_map *threads)
> >  {
> >       if (threads) {
> > --
> > 2.34.1
> >



-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
