Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B80C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 23:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A2F60E78
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Aug 2021 23:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbhHSXbF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Aug 2021 19:31:05 -0400
Received: from mail-lf1-f50.google.com ([209.85.167.50]:43735 "EHLO
        mail-lf1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhHSXbF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Aug 2021 19:31:05 -0400
Received: by mail-lf1-f50.google.com with SMTP id i9so16388044lfg.10;
        Thu, 19 Aug 2021 16:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4tFJhCFlYMqtmgoOPQJXeaT8OGo3ZXeM33Dc9cbYtEo=;
        b=MBfT/SSKpHnj/eNoutKAIEEKAif35/7X9/bNM6ASFh6sA0d/BxFaLhOxhy/0/fI53p
         VCvq+6CzuOOn37205pWijf6rTuJrHnnYvMHzsraRFw+c+NSXblPkWzAipQP0KDq2B9Ay
         KONDB+Tl8tFEH8wEPVlXhcd3Gn/al3KeBAnTSaAGovH/gSg292J+BlqTV9OhOf6ZSAwR
         ahIvgGDo4gcLs477bUoe4rw5BmsAGCYIqCkNOB++Jd5EzhDgVMDDkE6ghlmLRXaagd4L
         ZK5iZY7YRJZEOOKvsxehSqfkvWwC/4tAk9NnwnulUIr8SZ7RoggH+gBZB7JmwDiRHf2u
         Zjtw==
X-Gm-Message-State: AOAM531kBEuiKUYRZ5rTdBQE3u2+a/kEY5dPsco1kkhpikVzgUdpUCz3
        JhCjDCWjzGqQVc/CZNCGCHR9Oib041u/StRT/Wk=
X-Google-Smtp-Source: ABdhPJzusVbWyY9Rx4CKkllit3xFJpBqQ1RffUEkb/VEip5+dAKWkEwhTSATteT33U2lI271ZR9KlZLaZ8ohl00Zur4=
X-Received: by 2002:a05:6512:158b:: with SMTP id bp11mr4333269lfb.300.1629415827238;
 Thu, 19 Aug 2021 16:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210819054707.1057819-1-irogers@google.com> <YR6pYoyov8ZGbAvJ@kernel.org>
In-Reply-To: <YR6pYoyov8ZGbAvJ@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 19 Aug 2021 16:30:16 -0700
Message-ID: <CAM9d7cgBayQFwqW-=3sMYUOTuCQcWYCVy+P9J0bWJOohAn5gAA@mail.gmail.com>
Subject: Re: [PATCH] libperf evsel: Make use of FD robust.
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
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

Hi Ian,

On Thu, Aug 19, 2021 at 11:56 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Aug 18, 2021 at 10:47:07PM -0700, Ian Rogers escreveu:
> > FD uses xyarray__entry that may return NULL if an index is out of
> > bounds. If NULL is returned then a segv happens as FD unconditionally
> > dereferences the pointer. This was happening in a case of with perf
> > iostat as shown below. The fix is to make FD an "int*" rather than an
> > int and handle the NULL case as either invalid input or a closed fd.
> >
> > $ sudo gdb --args perf stat --iostat  list
> > ...
> > Breakpoint 1, perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> > 50      {
> > (gdb) bt
> >  #0  perf_evsel__alloc_fd (evsel=0x5555560951a0, ncpus=1, nthreads=1) at evsel.c:50
> >  #1  0x000055555585c188 in evsel__open_cpu (evsel=0x5555560951a0, cpus=0x555556093410,
> >     threads=0x555556086fb0, start_cpu=0, end_cpu=1) at util/evsel.c:1792
> >  #2  0x000055555585cfb2 in evsel__open (evsel=0x5555560951a0, cpus=0x0, threads=0x555556086fb0)
> >     at util/evsel.c:2045
> >  #3  0x000055555585d0db in evsel__open_per_thread (evsel=0x5555560951a0, threads=0x555556086fb0)
> >     at util/evsel.c:2065
> >  #4  0x00005555558ece64 in create_perf_stat_counter (evsel=0x5555560951a0,
> >     config=0x555555c34700 <stat_config>, target=0x555555c2f1c0 <target>, cpu=0) at util/stat.c:590
> >  #5  0x000055555578e927 in __run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> >     at builtin-stat.c:833
> >  #6  0x000055555578f3c6 in run_perf_stat (argc=1, argv=0x7fffffffe4a0, run_idx=0)
> >     at builtin-stat.c:1048
> >  #7  0x0000555555792ee5 in cmd_stat (argc=1, argv=0x7fffffffe4a0) at builtin-stat.c:2534
> >  #8  0x0000555555835ed3 in run_builtin (p=0x555555c3f540 <commands+288>, argc=3,
> >     argv=0x7fffffffe4a0) at perf.c:313
> >  #9  0x0000555555836154 in handle_internal_command (argc=3, argv=0x7fffffffe4a0) at perf.c:365
> >  #10 0x000055555583629f in run_argv (argcp=0x7fffffffe2ec, argv=0x7fffffffe2e0) at perf.c:409
> >  #11 0x0000555555836692 in main (argc=3, argv=0x7fffffffe4a0) at perf.c:539

This callstack looks strange that 'perf iostat list' should not call
run_perf_stat() for the IOSTAT_LIST mode.

Hmm.. maybe it's because the --iostat option is declared
with OPT_CALLBACK_OPTARG which requires the option
to be specified like '--iostat=list' (not '--iostat list').

Anyway it should not crash..

Thanks,
Namhyung


> > ...
> > (gdb) c
> > Continuing.
> > Error:
> > The sys_perf_event_open() syscall returned with 22 (Invalid argument) for event (uncore_iio_0/event=0x83,umask=0x04,ch_mask=0xF,fc_mask=0x07/).
> > /bin/dmesg | grep -i perf may provide additional information.
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x00005555559b03ea in perf_evsel__close_fd_cpu (evsel=0x5555560951a0, cpu=1) at evsel.c:166
> > 166                     if (FD(evsel, cpu, thread) >= 0)
>
> Humm
>
> static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
> {
>         int thread;
>
>         for (thread = 0; thread < xyarray__max_y(evsel->fd); ++thread) {
>                 if (FD(evsel, cpu, thread) >= 0)
>                         close(FD(evsel, cpu, thread));
>                 FD(evsel, cpu, thread) = -1;
>         }
> }
>
> void perf_evsel__close_fd(struct perf_evsel *evsel)
> {
>         int cpu;
>
>         for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++)
>                 perf_evsel__close_fd_cpu(evsel, cpu);
> }
>
> Isn't bounds checking being performed by the callers?
>
> - Arnaldo
>
