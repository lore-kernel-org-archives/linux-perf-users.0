Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D42FC433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Feb 2022 02:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBVCcr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 21 Feb 2022 21:32:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231964AbiBVCcq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 21 Feb 2022 21:32:46 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F49D25C5E
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 18:32:22 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id ev16-20020a17090aead000b001bc3835fea8so1076458pjb.0
        for <linux-perf-users@vger.kernel.org>; Mon, 21 Feb 2022 18:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+KGj80P8TygVReXjyL4G9YJVv9T60uzqkOYpN0+bPk=;
        b=RVQqinLqHsZu3ztXRvCrMGfKIB6nIrB1E5du+NHkF3vPWsP18strWr8zodO53wLAKx
         neb69jnaqPfa6JLXOfJq3D6JCyk0GlLEYzOznWH7f8jTs+TdU2OWOhDXLx/wFgAlidBK
         hSepoxqjjkBvNUnqL6JIZAM+uUliMjDdoYHaOpZ/sDFdBpBi8AxbIe+Mbd5n75Hq+9bm
         BWd8tqWkswqnUNkTSy5t2OpOdWsyRVFQe0sN4EVfC0JHzpUUPoya+LBFIm+ftd7aIAne
         qHa8o4BqwiRlNbdVVgDWWbYXcQ36tQILl3Q8YbhYuaI0DS/MDJCceO8jrlndMlSE0vU9
         TG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+KGj80P8TygVReXjyL4G9YJVv9T60uzqkOYpN0+bPk=;
        b=QUslwOonW6nlAYWmWi1ULSNOIWgXw3inU9C3Q/XHxJ7d6wQrKn5SdpnjArAOmhElnL
         uYf0ZEQZzy9W/MFDgYHWNtdG0c213CRRCc5vl7tV9qfM0TXa7wviVHINhxQEX6L1X039
         PXvys5c64Sjghc3NdZGAUFKlyv57Qk1vI7WPsRD6upHwqt7Y8MGqHVZd2Ot2gX3cSSc3
         VhDx9gUiLU1Ul1D4F6MooJIM/jEpXu3o/Q8MEoOOw4wLzQRpEWK8RfvTPiNX+pJk9g5o
         pP3akKcU/YUraOGe0MYW8y9veAgXVxhmk5lmbjH+2SgQ1e4qsTINj+Ry3603Hq3bEoVe
         Fo2w==
X-Gm-Message-State: AOAM5317FMgtOOiReLKSasDR1VzyKoonCTSD5XJKiu99zWlptJVKnJ7e
        GRn/nMFcQQmcC06mc9SAH0GnAUV8xSie+rKKEm0=
X-Google-Smtp-Source: ABdhPJzmfVOYIoc1gJNbXtH3OS9bZ9CMoccWS4xsSVzBiskX2o9I0ZhCl3YxJk3OuO+0HwIXKBK6zvjNLgmDz6X+INs=
X-Received: by 2002:a17:902:ccc1:b0:14f:b686:e6ff with SMTP id
 z1-20020a170902ccc100b0014fb686e6ffmr7518118ple.45.1645497141440; Mon, 21 Feb
 2022 18:32:21 -0800 (PST)
MIME-Version: 1.0
References: <20220221102628.43904-1-tz.stoyanov@gmail.com> <YhPsKeK0UdjiDN1R@krava>
 <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
In-Reply-To: <C62503E3-B72B-4441-8900-1439CB7CAB04@gmail.com>
From:   Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Date:   Tue, 22 Feb 2022 04:32:05 +0200
Message-ID: <CAPpZLN7Qmgsm6ptthvsjgcqgMQd1tnuX=ohHBcPAQ4zu4VVkrw@mail.gmail.com>
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Feb 21, 2022 at 10:21 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On February 21, 2022 4:46:49 PM GMT-03:00, Jiri Olsa <olsajiri@gmail.com> wrote:
> >On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> >> The existing API perf_thread_map__new_dummy() allocates new thread map
> >> for one thread. I couldn't find a way to reallocate the map with more
> >> threads, or to allocate a new map for more than one thread. Having
> >> multiple threads in a thread map is essential for some use cases.
> >> That's why a new API is proposed, which allocates a new thread map
> >> for given number of threads:
> >>  perf_thread_map__new_array()
> >>
> >> Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> >> ---
> >> v2 changes:
> >>  - Changed the new API as Arnaldo suggested - get number of threads in the
> >>    map and array with initial values (optional).
> >
> >looks good, would you also find useful in your use case the comm support
> >in thread_map? the thread_map__read_comms function? we could move it from
> >perf to libperf
>
> IOW: we're happy that you're working on libperf, so feel encouraged to move things from tools/perf/util/ to tools/lib/perf/ if you find a supporting use case, brownie points if you also add an entry to tools/perf/tests/, AKA 'perf test'.
>

Thanks, I see that there is a lot of functionality that could be moved
from perf to libperf and which will be useful for the library users.
We are going to use libperf in trace-cruncher,
https://github.com/vmware/trace-cruncher, as an interface to perf.

> Thanks!
>
> - Arnaldo
>
> >
> >thanks,
> >jirka
> >
> >>
> >>  tools/lib/perf/Documentation/libperf.txt |  1 +
> >>  tools/lib/perf/include/perf/threadmap.h  |  1 +
> >>  tools/lib/perf/libperf.map               |  1 +
> >>  tools/lib/perf/tests/test-threadmap.c    | 41 ++++++++++++++++++++++++
> >>  tools/lib/perf/threadmap.c               | 24 ++++++++++----
> >>  5 files changed, 61 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> >> index a21f733b95b1..a8f1a237931b 100644
> >> --- a/tools/lib/perf/Documentation/libperf.txt
> >> +++ b/tools/lib/perf/Documentation/libperf.txt
> >> @@ -62,6 +62,7 @@ SYNOPSIS
> >>    struct perf_thread_map;
> >>
> >>    struct perf_thread_map *perf_thread_map__new_dummy(void);
> >> +  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> >>
> >>    void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> >>    char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> >> diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> >> index 58f7fbdce446..8b40e7777cea 100644
> >> --- a/tools/lib/perf/include/perf/threadmap.h
> >> +++ b/tools/lib/perf/include/perf/threadmap.h
> >> @@ -8,6 +8,7 @@
> >>  struct perf_thread_map;
> >>
> >>  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> >> +LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> >>
> >>  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> >>  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> >> diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> >> index 6fa0d651576b..190b56ae923a 100644
> >> --- a/tools/lib/perf/libperf.map
> >> +++ b/tools/lib/perf/libperf.map
> >> @@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
> >>              perf_cpu_map__empty;
> >>              perf_cpu_map__max;
> >>              perf_cpu_map__has;
> >> +            perf_thread_map__new_array;
> >>              perf_thread_map__new_dummy;
> >>              perf_thread_map__set_pid;
> >>              perf_thread_map__comm;
> >> diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> >> index 5e2a0291e94c..f728ad7002bb 100644
> >> --- a/tools/lib/perf/tests/test-threadmap.c
> >> +++ b/tools/lib/perf/tests/test-threadmap.c
> >> @@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level level,
> >>      return vfprintf(stderr, fmt, ap);
> >>  }
> >>
> >> +static int test_threadmap_array(int nr, pid_t *array)
> >> +{
> >> +    struct perf_thread_map *threads;
> >> +    int i;
> >> +
> >> +    threads = perf_thread_map__new_array(nr, array);
> >> +    __T("Failed to allocate new thread map", threads);
> >> +
> >> +    __T("Unexpected number of threads", perf_thread_map__nr(threads) == nr);
> >> +
> >> +    for (i = 0; i < nr; i++) {
> >> +            __T("Unexpected initial value of thread",
> >> +                perf_thread_map__pid(threads, i) == (array ? array[i] : -1));
> >> +    }
> >> +
> >> +    for (i = 1; i < nr; i++)
> >> +            perf_thread_map__set_pid(threads, i, i * 100);
> >> +
> >> +    __T("Unexpected value of thread 0",
> >> +        perf_thread_map__pid(threads, 0) == (array ? array[0] : -1));
> >> +
> >> +    for (i = 1; i < nr; i++) {
> >> +            __T("Unexpected thread value",
> >> +                perf_thread_map__pid(threads, i) == i * 100);
> >> +    }
> >> +
> >> +    perf_thread_map__put(threads);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +#define THREADS_NR  10
> >>  int test_threadmap(int argc, char **argv)
> >>  {
> >>      struct perf_thread_map *threads;
> >> +    pid_t thr_array[THREADS_NR];
> >> +    int i;
> >>
> >>      __T_START;
> >>
> >> @@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
> >>      perf_thread_map__put(threads);
> >>      perf_thread_map__put(threads);
> >>
> >> +    test_threadmap_array(THREADS_NR, NULL);
> >> +
> >> +    for (i = 0; i < THREADS_NR; i++)
> >> +            thr_array[i] = i + 100;
> >> +
> >> +    test_threadmap_array(THREADS_NR, thr_array);
> >> +
> >>      __T_END;
> >>      return tests_failed == 0 ? 0 : -1;
> >>  }
> >> diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> >> index 84fa07c79d00..07968f3ea093 100644
> >> --- a/tools/lib/perf/threadmap.c
> >> +++ b/tools/lib/perf/threadmap.c
> >> @@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
> >>      return map->map[idx].comm;
> >>  }
> >>
> >> -struct perf_thread_map *perf_thread_map__new_dummy(void)
> >> +struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array)
> >>  {
> >> -    struct perf_thread_map *threads = thread_map__alloc(1);
> >> +    struct perf_thread_map *threads = thread_map__alloc(nr_threads);
> >> +    int i;
> >> +
> >> +    if (!threads)
> >> +            return NULL;
> >> +
> >> +    for (i = 0; i < nr_threads; i++)
> >> +            perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
> >> +
> >> +    threads->nr = nr_threads;
> >> +    refcount_set(&threads->refcnt, 1);
> >>
> >> -    if (threads != NULL) {
> >> -            perf_thread_map__set_pid(threads, 0, -1);
> >> -            threads->nr = 1;
> >> -            refcount_set(&threads->refcnt, 1);
> >> -    }
> >>      return threads;
> >>  }
> >>
> >> +struct perf_thread_map *perf_thread_map__new_dummy(void)
> >> +{
> >> +    return perf_thread_map__new_array(1, NULL);
> >> +}
> >> +
> >>  static void perf_thread_map__delete(struct perf_thread_map *threads)
> >>  {
> >>      if (threads) {
> >> --
> >> 2.34.1
> >>



-- 
Tzvetomir (Ceco) Stoyanov
VMware Open Source Technology Center
