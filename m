Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78088C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 00:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F28060F91
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 00:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhHTAN7 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbhHTAN6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 20:13:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCAD1C061575
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Aug 2021 17:13:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id u15so4839130wmj.1
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Aug 2021 17:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rL6wbZkCi+kI1IpfH0htaN3P5mXzNSVzl3FCg4p7KhU=;
        b=YpOYkCg4UUxl8krJRUlZVaDNJlaoPJlcU2O4IqzZdDNGcRcmVYWevteDLz3OvsYdjy
         p+dhMg73Npf9WFhgU5CkpFJ8qAotsN7RmrAj7UQ5yMaEjiBrpKlA1dJOYKzXdmvNdcMX
         LIgQv6I3liYK/5JPFHMteQtD1fiTKUfE2zRz9mU9lnTD9YnruNDIcKBODujcgUvG/vtH
         rn9M3Zbsjhgy3E9TK27FzQOyPKuHkm4qPJvfzHTMrlH+vbc/v5UMZtY2c2sRGHqU6fcc
         7T0DBv6WuHWTAr08beBBYBCf7/6r7WYxDELhVkovTy3fW1orACLuxJ7X/SUlLtr4Bajf
         B+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rL6wbZkCi+kI1IpfH0htaN3P5mXzNSVzl3FCg4p7KhU=;
        b=Z9ylwMpqe8VWaCN03vEAb6tdzGBhdTnwJcq48aG59XQC27I0fDxiNP32UGIFSzj0Qx
         NXztfxPJomOMcHhodo3lyh8TlHktqfxHBi66L8CexPyb7qGTAX1n67IxQ8ngc9R6J4LJ
         7zT4a+R1GA/LE3T1Sj9tTrch/EQ7g3bAJvTuWMpMzYAaJkIVB1W22keJVRhnKznJX/fn
         QXhnvvKwzWNvGPTWIBDK5T7Vtgj0NIcvcCxJw1a1H21QsHibFm0XQbOQMd02Ez1xHatv
         QjLS/m/kfysVKvhDVJTGTdP1tViQqylo17n6yucqHdxvtwgBY6tUJf4xfzW3w54o/10A
         w1Bg==
X-Gm-Message-State: AOAM533gT1s+GTeTy/NDABBEtFIgWefGSr4XvUP4GW00lQPfIOHtQ5Wp
        YJ1tKM9N7qjyze/c4orfckTtMCjl5Ws/NRbHnMrHyA==
X-Google-Smtp-Source: ABdhPJwsAYkVwd2ie+vKlCZX33sCsyBvqq2P3MeajoG1ck/jMUdJLdUyFA19du3/QU6XCf0GJecxzAKOg5MvnJnZU2k=
X-Received: by 2002:a7b:cd10:: with SMTP id f16mr1063025wmj.104.1629418400060;
 Thu, 19 Aug 2021 17:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054707.1057819-1-irogers@google.com> <YR6pYoyov8ZGbAvJ@kernel.org>
 <CAM9d7cgBayQFwqW-=3sMYUOTuCQcWYCVy+P9J0bWJOohAn5gAA@mail.gmail.com>
In-Reply-To: <CAM9d7cgBayQFwqW-=3sMYUOTuCQcWYCVy+P9J0bWJOohAn5gAA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 19 Aug 2021 17:13:08 -0700
Message-ID: <CAP-5=fWHzg=Oh2uKm2CBEyE+evq7DoghQCSUsZoE6J5O5_A3hQ@mail.gmail.com>
Subject: Re: [PATCH] libperf evsel: Make use of FD robust.
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 19, 2021 at 4:30 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Ian,
>
> On Thu, Aug 19, 2021 at 11:56 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Aug 18, 2021 at 10:47:07PM -0700, Ian Rogers escreveu:
> > > FD uses xyarray__entry that may return NULL if an index is out of
> > > bounds. If NULL is returned then a segv happens as FD unconditionally
> > > dereferences the pointer. This was happening in a case of with perf
> > > iostat as shown below. The fix is to make FD an "int*" rather than an
> > > int and handle the NULL case as either invalid input or a closed fd.
> > >
> > > $ sudo gdb --args perf stat --iostat  list
> > > ...
> > > Breakpoint 1, perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> > > 50      {
> > > (gdb) bt
> > >  #0  perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> > >  #1  0x000055555585c188 in evsel__open_cpu (evsel=0x5555560951a0, cpus=0x555556093410,
> > >     threads=0x555556086fb0, start_cpu=0, end_cpu=1) at util/evsel.c:1792
> > >  #2  0x000055555585cfb2 in evsel__open (evsel=0x5555560951a0, cpus=0x0, threads=0x555556086fb0)
> > >     at util/evsel.c:2045
> > >  #3  0x000055555585d0db in evsel__open_per_thread (evsel=0x5555560951a0, threads=0x555556086fb0)
> > >     at util/evsel.c:2065
> > >  #4  0x00005555558ece64 in create_perf_stat_counter (evsel=0x5555560951a0,
> > >     config=0x555555c34700 <stat_config>, target=0x555555c2f1c0 <target>, cpu=0) at util/stat.c:590
> > >  #5  0x000055555578e927 in __run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> > >     at builtin-stat.c:833
> > >  #6  0x000055555578f3c6 in run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> > >     at builtin-stat.c:1048
> > >  #7  0x0000555555792ee5 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at builtin-stat.c:2534
> > >  #8  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
> > >     argv=0x7fffffffe4a0) at perf.c:313
> > >  #9  0x0000555555836154 in handle_internal_command (argc=3, argv=0x7fffffffe4a0) at perf.c:365
> > >  #10 0x000055555583629f in run_argv (argcp=0x7fffffffe2ec, argv=0x7fffffffe2e0) at perf.c:409
> > >  #11 0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539
>
> This callstack looks strange that 'perf iostat list' should not call
> run_perf_stat() for the IOSTAT_LIST mode.
>
> Hmm.. maybe it's because the --iostat option is declared
> with OPT_CALLBACK_OPTARG which requires the option
> to be specified like '--iostat=list' (not '--iostat list').
>
> Anyway it should not crash..
>
> Thanks,
> Namhyung
>
>
> > > ...
> > > (gdb) c
> > > Continuing.
> > > Error:
> > > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
> > > /bin/dmesg | grep -i perf may provide additional information.
> > >
> > > Program received signal SIGSEGV, Segmentation fault.
> > > 0x00005555559b03ea in perf_evsel__close_fd_cpu (evsel=0x5555560951a0, cpu=1) at evsel.c:166
> > > 166                     if (FD(evsel, cpu, thread) >= 0)
> >
> > Humm
> >
> > static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
> > {
> >         int thread;
> >
> >         for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> >                 if (FD(evsel, cpu, thread) >= 0)
> >                         close(FD(evsel, cpu, thread));
> >                 FD(evsel, cpu, thread) = -1;
> >         }
> > }
> >
> > void perf_evsel__close_fd(struct perf_evsel *evsel)
> > {
> >         int cpu;
> >
> >         for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
> >                 perf_evsel__close_fd_cpu(evsel, cpu);
> > }
> >
> > Isn't bounds checking being performed by the callers?

It looks like things have been confused. There is a default case where
number of CPUs is set to 1, the caller with the segv is using the
affinity CPU code:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/evlist.c?h=perf/core#n1287

and so values other than 1 are passed, yielding the out of range
index, NULL and then the segv. I meant to send the stack trace at the
point of the segv, it is:

#0  0x00005555559b03ea in perf_evsel__close_fd_cpu
(evsel=0x5555560951a0, cpu=1) at evsel.c:166
#1  0x00005555559b05d1 in perf_evsel__close_cpu (evsel=0x5555560951a0,
cpu=1) at evsel.c:200
#2  0x0000555555853eb2 in evlist__close (evlist=0x555555e9b5c0) at
util/evlist.c:1287
#3  0x0000555555850eb1 in evlist__delete (evlist=0x555555e9b5c0) at
util/evlist.c:160
#4  0x0000555555793143 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at
builtin-stat.c:2594
#5  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
    argv=0x7fffffffe4a0) at perf.c:313
#6  0x0000555555836154 in handle_internal_command (argc=3,
argv=0x7fffffffe4a0) at perf.c:365
#7  0x000055555583629f in run_argv (argcp=0x7fffffffe2ec,
argv=0x7fffffffe2e0) at perf.c:409
#8  0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539

Thanks,
Ian

> > - Arnaldo
> >
