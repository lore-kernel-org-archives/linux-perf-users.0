Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B032C43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 16:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344847AbiFIQxh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 12:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344863AbiFIQxe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 12:53:34 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777136147
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 09:53:26 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id j20so3213552ljg.8
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RnnI75MEx4lNy+rx7v/bh01lvj2FiAMBVy1u9JepGfo=;
        b=rMqG2WJPOlD4LQ8ZwCDsf+vQZC1NKtoCU+xmI1t5RCDuq2ySS5PmrgARG1EiNn2RX+
         Eb7iTRgP8sGNIcNEEbi/NqOM+lt0qQYV3x20KYp6V3al+e/KQpw781+9fEqSMJLW8QQL
         20IkhuMCuZJYN9Mkw+boqnomMUpkNCuxDQJRX4oHUyoHLAu9PhTI7GnGIVNI83TXU+2V
         s2RSR2OCyAZYiNcCreJt9MQV8dckZhtArxQ5dwqQ8HrdYsQLCNqSkoHlGsdfmBv8KFon
         edHyjyy7pby2JLfCK4aGFphbGZtKtnNEcQy2CvuqiDcVI9dQCu5kQ0FzK2THigolw0or
         gtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RnnI75MEx4lNy+rx7v/bh01lvj2FiAMBVy1u9JepGfo=;
        b=y4DDRa2b3gc9BICMI6SQXoPHF5jn+6JaaQgaoLxu5cK+6Vd1YiwvST2ZnQzHhtQVu9
         WIgPGsNy8GCAVHcc9IRzhcNfrSzU0Q5zSz7+PqOxJMMZDisjUXaZMliLAqHjE/xgsh+G
         fjXjT9ljZb+vAPUNA69iDJVJvTwePhGryVsA9UDZdIzEZoRKIyRHbbgYo9E8h53meQBo
         zTutEQCxxG8xVzJJbh7oknF+QEKdkPxwnNSW/vnwRfsmMKehIulCaeBGRbDR2ZM0C21u
         DWdYkt3G9Xrqsg60fRCqY6VrGHERoXXy7UXlxKbXO2hyqmxgrAxW9u3QEb3v+krgYeTV
         URGg==
X-Gm-Message-State: AOAM531yug1jEHkhQW/ceE+sAAJ74TmIw8iGvXdIKveoW9W9jrhuSWss
        wqRNWj+B56JfhHh7ZNmzDMA1AQrZEyb84ZOl6nEjTQ==
X-Google-Smtp-Source: ABdhPJyi2BGKP0TSiPLfQzJczezSNvtxChlMABNaZCpY+QmT5gtvD0zJ+kJ1pH2lKvTQ2wpVF3jpFgpjN+ph+PALAb8=
X-Received: by 2002:a2e:b0fc:0:b0:255:6f92:f9d4 with SMTP id
 h28-20020a2eb0fc000000b002556f92f9d4mr22608060ljl.92.1654793604135; Thu, 09
 Jun 2022 09:53:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com> <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com>
In-Reply-To: <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 18:53:12 +0200
Message-ID: <CACT4Y+Zq-1nczM2JH7Sr4mZo84gsCRd83RAwwnHwmap-wCOLTQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

.
/On Thu, 9 Jun 2022 at 16:56, Marco Elver <elver@google.com> wrote:
> > > On a machine with 256 CPUs, running the recently added perf breakpoint
> > > benchmark results in:
> > >
> > >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> > >  | # Running 'breakpoint/thread' benchmark:
> > >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> > >  |      Total time: 236.418 [sec]
> > >  |
> > >  |   123134.794271 usecs/op
> > >  |  7880626.833333 usecs/op/cpu
> > >
> > > The benchmark tests inherited breakpoint perf events across many
> > > threads.
> > >
> > > Looking at a perf profile, we can see that the majority of the time is
> > > spent in various hw_breakpoint.c functions, which execute within the
> > > 'nr_bp_mutex' critical sections which then results in contention on that
> > > mutex as well:
> > >
> > >     37.27%  [kernel]       [k] osq_lock
> > >     34.92%  [kernel]       [k] mutex_spin_on_owner
> > >     12.15%  [kernel]       [k] toggle_bp_slot
> > >     11.90%  [kernel]       [k] __reserve_bp_slot
> > >
> > > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > > O(#tasks) due to storing all task breakpoints in the same list and
> > > iterating through that list looking for a matching task. Clearly, this
> > > does not scale to thousands of tasks.
> > >
> > > While one option would be to make task_struct a breakpoint list node,
> > > this would only further bloat task_struct for infrequently used data.
> >
> > task_struct already has:
> >
> > #ifdef CONFIG_PERF_EVENTS
> >   struct perf_event_context *perf_event_ctxp[perf_nr_task_contexts];
> >   struct mutex perf_event_mutex;
> >   struct list_head perf_event_list;
> > #endif
> >
> > Wonder if it's possible to use perf_event_mutex instead of the task_sharded_mtx?
> > And possibly perf_event_list instead of task_bps_ht? It will contain
> > other perf_event types, so we will need to test type as well, but on
> > the positive side, we don't need any management of the separate
> > container.
>
> Hmm, yes, I looked at that but then decided against messing the
> perf/core internals. The main issue I have with using perf_event_mutex
> is that we might interfere with perf/core's locking rules as well as
> interfere with other concurrent perf event additions. Using
> perf_event_list is very likely a no-go because it requires reworking
> perf/core as well.
>
> I can already hear Peter shouting, but maybe I'm wrong. :-)

Let's wait for Peter to shout then :)
A significant part of this change is having per-task data w/o having
per-task data.

The current perf-related data in task_struct is already multiple words
and it's also not used in lots of production cases.
Maybe we could have something like:

  struct perf_task_data* lazily_allocated_perf_data;

that's lazily allocated on first use instead of the current
perf_event_ctxp/perf_event_mutex/perf_event_list.
This way we could both reduce task_size when perf is not used and have
more perf-related data (incl breakpoints) when it's used.
