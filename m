Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E250AC433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC44161260
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Sep 2021 19:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbhIQTVT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Sep 2021 15:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241734AbhIQTVS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Sep 2021 15:21:18 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0AFC061757
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:19:56 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id d18so1170039iof.13
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Sep 2021 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIJFSMRVH+L6Z8yhGu8t0mgSnf2lxBVl6BA3E6wdvZk=;
        b=OiRi6ACv1OcxeeJDeqkEFiQ3PBxgvR3PrTG/Qt4WCxzQpm86Ld8WZ0uLpgYRiLxPrq
         lE3SojTQLAWrryJq/EHGIWcYGW6cacamxsm/kaKAON3PLkm6dPyc9yfb/y3hekUXALiS
         JAYNI84zRjbG700oUbaXcLNXIeiyO52gIaPR9ruxQ24AJS0DpGufh3MzUa5/ras3Dyuw
         Alo6Vsu+1AW1aKWNKoAszgBiI5o6Jg6rVu5w73JrrXJoozk+486apP4o6Ky3/E2IZ90m
         DJ0OEyX+OYRmMHBl0EYGKYoGQFxucc0Soxgzznrh5hj8NZWR/SouSh0EIJDsPI02StSb
         1Phw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIJFSMRVH+L6Z8yhGu8t0mgSnf2lxBVl6BA3E6wdvZk=;
        b=WRkKX5RdNatC9cMDxMlNAknNidbqA7PFTe17iQ5QF+PZ/vruEOwKkIYitqbuScQYp0
         dvuGkqD2IHDTvO68sqc2K8N3yS22GUH/BThZmAZxMYydzX3Pp8Y4oIKPKOEWLguCAX72
         wrMBZtSDPNy1XUPPe0y8kB6o/2CSI6VBGVPT0BzE2qDtwv3XxBz5hfloUKbIg5OAnA3H
         WsHDkVtotQRiiZdDCEp8uOtfhkYEBtc1TtcDN5qq3meulcZJEd7h5cop8fYHPYdl9cEA
         40H9HZkLjxzy1OebBi/lGlb76ni/Jf+pRlWeL1Cj8FsRUhbuHd3RfS5zoYaUDpQjqhJo
         Hc/Q==
X-Gm-Message-State: AOAM530RH0O/gnckdYhJ2dVM8ZHjeaZYH6POw1609g8eCXNpMIuJXTml
        FQD/PtIWgfLzHcitc9QADYOwVb6HSC4SttETehwCRQ==
X-Google-Smtp-Source: ABdhPJx7zXzhNUDSsHLOxQ7GOpTVCEbL3GLUN3w26Mer5A0PojvlaBPIDXF+h44yvBECFBuAg8fbLg65vXEZ4y1g3EM=
X-Received: by 2002:a6b:5a08:: with SMTP id o8mr9813983iob.35.1631906395782;
 Fri, 17 Sep 2021 12:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210916062239.1894011-1-irogers@google.com> <YUL6NoeDwdZQ6gNz@krava>
In-Reply-To: <YUL6NoeDwdZQ6gNz@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 17 Sep 2021 12:19:44 -0700
Message-ID: <CAP-5=fUH6mKNgjWD1akHM5+o3yRbpkibir6=o9fjc0VRoJRgDw@mail.gmail.com>
Subject: Re: [PATCH v2] libperf evsel: Make use of FD robust.
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Sep 16, 2021 at 1:03 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Sep 15, 2021 at 11:22:39PM -0700, Ian Rogers wrote:
>
> SNIP
>
> > v2. is a rebase.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/evsel.c | 64 +++++++++++++++++++++++++++---------------
> >  1 file changed, 41 insertions(+), 23 deletions(-)
> >
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index d8886720e83d..ede7af4d183c 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -43,7 +43,7 @@ void perf_evsel__delete(struct perf_evsel *evsel)
> >       free(evsel);
> >  }
> >
> > -#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
> > +#define FD(e, x, y) (int *) xyarray__entry(e->fd, x, y)
> >  #define MMAP(e, x, y) (e->mmap ? ((struct perf_mmap *) xyarray__entry(e->mmap, x, y)) : NULL)
> >
> >  int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
> > @@ -54,7 +54,10 @@ int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
> >               int cpu, thread;
> >               for (cpu = 0; cpu < ncpus; cpu++) {
> >                       for (thread = 0; thread < nthreads; thread++) {
> > -                             FD(evsel, cpu, thread) = -1;
> > +                             int *fd = FD(evsel, cpu, thread);
> > +
> > +                             if (fd)
> > +                                      *fd = -1;
>
> so it's the perf_thread open that uses empty cpus and evlist__close
> will have more cpus to work on
>
> I'd expect some symetric fix on close path, but evlist__close is
> generic, so it's probably the best fix ;-)
>
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks! Arnaldo is there anything more to do on this? It'd be nice to
fix the crashes seen in:
https://lore.kernel.org/linux-perf-users/20210917184240.2181186-1-irogers@google.com/T/#t

Thanks!
Ian

> thanks,
> jirka
>
>
> >                       }
> >               }
> >       }
> > @@ -80,7 +83,7 @@ sys_perf_event_open(struct perf_event_attr *attr,
> >  static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *group_fd)
> >  {
> >       struct perf_evsel *leader = evsel->leader;
> > -     int fd;
> > +     int *fd;
> >
> >       if (evsel == leader) {
> >               *group_fd = -1;
> > @@ -95,10 +98,10 @@ static int get_group_fd(struct perf_evsel *evsel, int cpu, int thread, int *grou
> >               return -ENOTCONN;
> >
> >       fd = FD(leader, cpu, thread);
> > -     if (fd == -1)
> > +     if (fd == NULL || *fd == -1)
> >               return -EBADF;
> >
> > -     *group_fd = fd;
> > +     *group_fd = *fd;
> >
> >       return 0;
> >  }
> > @@ -138,7 +141,11 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >
> >       for (cpu = 0; cpu < cpus->nr; cpu++) {
> >               for (thread = 0; thread < threads->nr; thread++) {
> > -                     int fd, group_fd;
> > +                     int fd, group_fd, *evsel_fd;
> > +
> > +                     evsel_fd = FD(evsel, cpu, thread);
> > +                     if (evsel_fd == NULL)
> > +                             return -EINVAL;
> >
> >                       err = get_group_fd(evsel, cpu, thread, &group_fd);
> >                       if (err < 0)
> > @@ -151,7 +158,7 @@ int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
> >                       if (fd < 0)
> >                               return -errno;
> >
> > -                     FD(evsel, cpu, thread) = fd;
> > +                     *evsel_fd = fd;
> >               }
> >       }
> >
> > @@ -163,9 +170,12 @@ static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
> >       int thread;
> >
> >       for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> > -             if (FD(evsel, cpu, thread) >= 0)
> > -                     close(FD(evsel, cpu, thread));
> > -             FD(evsel, cpu, thread) = -1;
> > +             int *fd = FD(evsel, cpu, thread);
> > +
> > +             if (fd && *fd >= 0) {
> > +                     close(*fd);
> > +                     *fd = -1;
> > +             }
> >       }
> >  }
> >
> > @@ -209,13 +219,12 @@ void perf_evsel__munmap(struct perf_evsel *evsel)
> >
> >       for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> >               for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> > -                     int fd = FD(evsel, cpu, thread);
> > -                     struct perf_mmap *map = MMAP(evsel, cpu, thread);
> > +                     int *fd = FD(evsel, cpu, thread);
> >
> > -                     if (fd < 0)
> > +                     if (fd == NULL || *fd < 0)
> >                               continue;
> >
> > -                     perf_mmap__munmap(map);
> > +                     perf_mmap__munmap(MMAP(evsel, cpu, thread));
> >               }
> >       }
> >
> > @@ -239,15 +248,16 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> >
> >       for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> >               for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> > -                     int fd = FD(evsel, cpu, thread);
> > -                     struct perf_mmap *map = MMAP(evsel, cpu, thread);
> > +                     int *fd = FD(evsel, cpu, thread);
> > +                     struct perf_mmap *map;
> >
> > -                     if (fd < 0)
> > +                     if (fd == NULL || *fd < 0)
> >                               continue;
> >
> > +                     map = MMAP(evsel, cpu, thread);
> >                       perf_mmap__init(map, NULL, false, NULL);
> >
> > -                     ret = perf_mmap__mmap(map, &mp, fd, cpu);
> > +                     ret = perf_mmap__mmap(map, &mp, *fd, cpu);
> >                       if (ret) {
> >                               perf_evsel__munmap(evsel);
> >                               return ret;
> > @@ -260,7 +270,9 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
> >
> >  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
> >  {
> > -     if (FD(evsel, cpu, thread) < 0 || MMAP(evsel, cpu, thread) == NULL)
> > +     int *fd = FD(evsel, cpu, thread);
> > +
> > +     if (fd == NULL || *fd < 0 || MMAP(evsel, cpu, thread) == NULL)
> >               return NULL;
> >
> >       return MMAP(evsel, cpu, thread)->base;
> > @@ -295,17 +307,18 @@ int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
> >                    struct perf_counts_values *count)
> >  {
> >       size_t size = perf_evsel__read_size(evsel);
> > +     int *fd = FD(evsel, cpu, thread);
> >
> >       memset(count, 0, sizeof(*count));
> >
> > -     if (FD(evsel, cpu, thread) < 0)
> > +     if (fd == NULL || *fd < 0)
> >               return -EINVAL;
> >
> >       if (MMAP(evsel, cpu, thread) &&
> >           !perf_mmap__read_self(MMAP(evsel, cpu, thread), count))
> >               return 0;
> >
> > -     if (readn(FD(evsel, cpu, thread), count->values, size) <= 0)
> > +     if (readn(*fd, count->values, size) <= 0)
> >               return -errno;
> >
> >       return 0;
> > @@ -318,8 +331,13 @@ static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
> >       int thread;
> >
> >       for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
> > -             int fd = FD(evsel, cpu, thread),
> > -                 err = ioctl(fd, ioc, arg);
> > +             int err;
> > +             int *fd = FD(evsel, cpu, thread);
> > +
> > +             if (fd || *fd < 0)
> > +                     return -1;
> > +
> > +             err = ioctl(*fd, ioc, arg);
> >
> >               if (err)
> >                       return err;
> > --
> > 2.33.0.309.g3052b89438-goog
> >
>
