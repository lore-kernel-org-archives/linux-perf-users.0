Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339F9C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Feb 2022 13:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiBWNbd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbiBWNbc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Feb 2022 08:31:32 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02ECAB463
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:31:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a23so52235564eju.3
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Feb 2022 05:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8iVq8An9mJIIB2HQfMzx57QvfPZe3XbMYoOVLkI60zs=;
        b=P1Qm0Ib3/pR5whvWQs9Wqlehc/cSXXoss3lriFr434mo8U5VjOWDLRUwn1qXOg1rJ5
         MYjJd6/ix/YD6vuPLFAGqnzSI1FPgq9l/NrnY0OVq7I/1b0QXOKFwXHJa4wFvebBuChO
         Oa6949D/6h29pUD7V3MZ57ejBpAlvwDOiRYQSKC7ibAyctDwWan4jAuxlKaCWftZjpEb
         qvFJuPHuwTX+vv2pMwFSUqtKZQpAHfQ1f1BYkrY5/K6Xpz0kISoLKNXWTGKkR7ovZMZX
         UghRqbezTgt+0UlvkCaABa8qCL/MmijFH8I7wmuPtNLzT+UjFvTi4HunfB+CB6VH2OTX
         sy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8iVq8An9mJIIB2HQfMzx57QvfPZe3XbMYoOVLkI60zs=;
        b=CrIpy8/eP4gHFwx96jPP/3Y6w//qU2pWr8A39b//1fEUiu2NDYn/N24vD2mHiRQD8E
         jpaoYSn0pB3hoy4v+E/GWVm/iwgl/IeSTIJdYJvIVJHNSjVskhr2PMP5l1QzFF9hte39
         GmFr/KgFcEEv8tyviXjpVivnS8nwuz8cL7BJWur0zhY+jeRNvZWQMV5Y4MUvNWn9HAl9
         EuKZmb0BK6SmnLAWgGyKI7BQbGcLLUA2JttN03fIx3urAUgQYS77UN+R6q8oRbC0Q1BY
         CfwsXaNz6YHVzpEZdHu/zFp3QBOLt7oAILyii48RHYsNuRgCL8XZ81X7FHmblL0Vvh7E
         aWZg==
X-Gm-Message-State: AOAM530EzXDaISzx69/Rt1fu8NFJRHozJxcmEool3mhaXyl/v1nev4D/
        6/dfRLbRs5/GtC1YxYaBORL5dByh8tgcNQ==
X-Google-Smtp-Source: ABdhPJwcF+pr96/AFNU1DLP23DKvIPl3kB8fLanRd+P9ouPaWZ0VI6YvvPBaeI+OZfjE+qbKD29eVg==
X-Received: by 2002:a17:906:d205:b0:6d1:4446:d950 with SMTP id w5-20020a170906d20500b006d14446d950mr11991013ejz.702.1645623063183;
        Wed, 23 Feb 2022 05:31:03 -0800 (PST)
Received: from krava ([83.240.63.118])
        by smtp.gmail.com with ESMTPSA id c5sm11546648edk.43.2022.02.23.05.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:31:02 -0800 (PST)
Date:   Wed, 23 Feb 2022 14:31:01 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>,
        irogers@google.com, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] libperf: Add API for allocating new thread map
Message-ID: <YhY3FV9s+pIJ4Z1v@krava>
References: <20220221102628.43904-1-tz.stoyanov@gmail.com>
 <YhPsKeK0UdjiDN1R@krava>
 <YhV+LpjwXw3mai16@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhV+LpjwXw3mai16@kernel.org>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Feb 22, 2022 at 09:22:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Feb 21, 2022 at 08:46:49PM +0100, Jiri Olsa escreveu:
> > On Mon, Feb 21, 2022 at 12:26:28PM +0200, Tzvetomir Stoyanov (VMware) wrote:
> > > The existing API perf_thread_map__new_dummy() allocates new thread map
> > > for one thread. I couldn't find a way to reallocate the map with more
> > > threads, or to allocate a new map for more than one thread. Having
> > > multiple threads in a thread map is essential for some use cases.
> > > That's why a new API is proposed, which allocates a new thread map
> > > for given number of threads:
> > >  perf_thread_map__new_array()
> > > 
> > > Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
> > > ---
> > > v2 changes:
> > >  - Changed the new API as Arnaldo suggested - get number of threads in the
> > >    map and array with initial values (optional).
> > 
> > looks good, would you also find useful in your use case the comm support
> 
> Is that an Acked-by? :-)

yes, I wasn't sure about the previous args name changes,
this one is fine

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> - Arnaldo
> 
> > in thread_map? the thread_map__read_comms function? we could move it from
> > perf to libperf
> > 
> > thanks,
> > jirka
> > 
> > > 
> > >  tools/lib/perf/Documentation/libperf.txt |  1 +
> > >  tools/lib/perf/include/perf/threadmap.h  |  1 +
> > >  tools/lib/perf/libperf.map               |  1 +
> > >  tools/lib/perf/tests/test-threadmap.c    | 41 ++++++++++++++++++++++++
> > >  tools/lib/perf/threadmap.c               | 24 ++++++++++----
> > >  5 files changed, 61 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
> > > index a21f733b95b1..a8f1a237931b 100644
> > > --- a/tools/lib/perf/Documentation/libperf.txt
> > > +++ b/tools/lib/perf/Documentation/libperf.txt
> > > @@ -62,6 +62,7 @@ SYNOPSIS
> > >    struct perf_thread_map;
> > >  
> > >    struct perf_thread_map *perf_thread_map__new_dummy(void);
> > > +  struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> > >  
> > >    void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > >    char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > > diff --git a/tools/lib/perf/include/perf/threadmap.h b/tools/lib/perf/include/perf/threadmap.h
> > > index 58f7fbdce446..8b40e7777cea 100644
> > > --- a/tools/lib/perf/include/perf/threadmap.h
> > > +++ b/tools/lib/perf/include/perf/threadmap.h
> > > @@ -8,6 +8,7 @@
> > >  struct perf_thread_map;
> > >  
> > >  LIBPERF_API struct perf_thread_map *perf_thread_map__new_dummy(void);
> > > +LIBPERF_API struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array);
> > >  
> > >  LIBPERF_API void perf_thread_map__set_pid(struct perf_thread_map *map, int idx, pid_t pid);
> > >  LIBPERF_API char *perf_thread_map__comm(struct perf_thread_map *map, int idx);
> > > diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
> > > index 6fa0d651576b..190b56ae923a 100644
> > > --- a/tools/lib/perf/libperf.map
> > > +++ b/tools/lib/perf/libperf.map
> > > @@ -12,6 +12,7 @@ LIBPERF_0.0.1 {
> > >  		perf_cpu_map__empty;
> > >  		perf_cpu_map__max;
> > >  		perf_cpu_map__has;
> > > +		perf_thread_map__new_array;
> > >  		perf_thread_map__new_dummy;
> > >  		perf_thread_map__set_pid;
> > >  		perf_thread_map__comm;
> > > diff --git a/tools/lib/perf/tests/test-threadmap.c b/tools/lib/perf/tests/test-threadmap.c
> > > index 5e2a0291e94c..f728ad7002bb 100644
> > > --- a/tools/lib/perf/tests/test-threadmap.c
> > > +++ b/tools/lib/perf/tests/test-threadmap.c
> > > @@ -11,9 +11,43 @@ static int libperf_print(enum libperf_print_level level,
> > >  	return vfprintf(stderr, fmt, ap);
> > >  }
> > >  
> > > +static int test_threadmap_array(int nr, pid_t *array)
> > > +{
> > > +	struct perf_thread_map *threads;
> > > +	int i;
> > > +
> > > +	threads = perf_thread_map__new_array(nr, array);
> > > +	__T("Failed to allocate new thread map", threads);
> > > +
> > > +	__T("Unexpected number of threads", perf_thread_map__nr(threads) == nr);
> > > +
> > > +	for (i = 0; i < nr; i++) {
> > > +		__T("Unexpected initial value of thread",
> > > +		    perf_thread_map__pid(threads, i) == (array ? array[i] : -1));
> > > +	}
> > > +
> > > +	for (i = 1; i < nr; i++)
> > > +		perf_thread_map__set_pid(threads, i, i * 100);
> > > +
> > > +	__T("Unexpected value of thread 0",
> > > +	    perf_thread_map__pid(threads, 0) == (array ? array[0] : -1));
> > > +
> > > +	for (i = 1; i < nr; i++) {
> > > +		__T("Unexpected thread value",
> > > +		    perf_thread_map__pid(threads, i) == i * 100);
> > > +	}
> > > +
> > > +	perf_thread_map__put(threads);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +#define THREADS_NR	10
> > >  int test_threadmap(int argc, char **argv)
> > >  {
> > >  	struct perf_thread_map *threads;
> > > +	pid_t thr_array[THREADS_NR];
> > > +	int i;
> > >  
> > >  	__T_START;
> > >  
> > > @@ -27,6 +61,13 @@ int test_threadmap(int argc, char **argv)
> > >  	perf_thread_map__put(threads);
> > >  	perf_thread_map__put(threads);
> > >  
> > > +	test_threadmap_array(THREADS_NR, NULL);
> > > +
> > > +	for (i = 0; i < THREADS_NR; i++)
> > > +		thr_array[i] = i + 100;
> > > +
> > > +	test_threadmap_array(THREADS_NR, thr_array);
> > > +
> > >  	__T_END;
> > >  	return tests_failed == 0 ? 0 : -1;
> > >  }
> > > diff --git a/tools/lib/perf/threadmap.c b/tools/lib/perf/threadmap.c
> > > index 84fa07c79d00..07968f3ea093 100644
> > > --- a/tools/lib/perf/threadmap.c
> > > +++ b/tools/lib/perf/threadmap.c
> > > @@ -42,18 +42,28 @@ char *perf_thread_map__comm(struct perf_thread_map *map, int idx)
> > >  	return map->map[idx].comm;
> > >  }
> > >  
> > > -struct perf_thread_map *perf_thread_map__new_dummy(void)
> > > +struct perf_thread_map *perf_thread_map__new_array(int nr_threads, pid_t *array)
> > >  {
> > > -	struct perf_thread_map *threads = thread_map__alloc(1);
> > > +	struct perf_thread_map *threads = thread_map__alloc(nr_threads);
> > > +	int i;
> > > +
> > > +	if (!threads)
> > > +		return NULL;
> > > +
> > > +	for (i = 0; i < nr_threads; i++)
> > > +		perf_thread_map__set_pid(threads, i, array ? array[i] : -1);
> > > +
> > > +	threads->nr = nr_threads;
> > > +	refcount_set(&threads->refcnt, 1);
> > >  
> > > -	if (threads != NULL) {
> > > -		perf_thread_map__set_pid(threads, 0, -1);
> > > -		threads->nr = 1;
> > > -		refcount_set(&threads->refcnt, 1);
> > > -	}
> > >  	return threads;
> > >  }
> > >  
> > > +struct perf_thread_map *perf_thread_map__new_dummy(void)
> > > +{
> > > +	return perf_thread_map__new_array(1, NULL);
> > > +}
> > > +
> > >  static void perf_thread_map__delete(struct perf_thread_map *threads)
> > >  {
> > >  	if (threads) {
> > > -- 
> > > 2.34.1
> > > 
> 
> -- 
> 
> - Arnaldo
