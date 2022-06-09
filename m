Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40239CCA473
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 14:56:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344044AbiFIO40 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbiFIO4Z (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 10:56:25 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270F339182A
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 07:56:24 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3137c877092so43737557b3.13
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 07:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+SkCjGgZBFq5wRCXTYfFTyaGhOAcbR2Sdoh6LQhmUA=;
        b=deUfDUG4RR9z3kerucIqTXhqCeGsbHnfHtdvw5TsJVYFknetJ/w80Mv9kBz5l4wex9
         TssewgR73O/IyB/u1mxjbxvVfqyOyYF82MCbjOeauw6zFo7MJimse2lx811joMZtXTdC
         uT5XfiXo74nBdAcht78tvAUnApid/SMJhbV+Nr+EedCSPzCr3MTOd8EP9AmTLlsnhGck
         znW1PntgjNv4SDv5OQvubmFMVhj/M7k5WoovioAqVoC/pkPL9GeBmYIXDknX5bKByQzG
         isj398VB6w8UihJLCkMJNEXGeGaR/Pfe/bXeUjDzdAAissGD1HmQ0PWrAQE6T2NwCeIX
         Z0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+SkCjGgZBFq5wRCXTYfFTyaGhOAcbR2Sdoh6LQhmUA=;
        b=IScpGoPGTE8Y/rrvTutpFcsO4v6etYuqNV9FtJOdrgzNNUyhyCNXM7EkRhELW8VpBC
         kLP/r7XVOnCeieReL1+mgfbgyPIsLHBwDC9bRrKNq/20dpZ+UjgD0O9BPq04eBzLvGgz
         NZhC2SSf4HJjRVTHq8RFFHVbU0qlXzXMvOs132/tsALWLhzvwVYwFwswXHu2mJIeXs1l
         VgJVkRhJooD3cSY0OjQwg7qcs/OpW37TjN7qUBoJJzNftwfxNHhV8to0qWpdieLbV9Ss
         4VEIcUmwon8gnU5gNG69S2Pl4H1KW99hzbEcZW+6+IxL3NlOqRuXYsxdKY70ulYTCXh0
         ZtmA==
X-Gm-Message-State: AOAM532BYvhOdaoasvPhDD4M/FfJcwQCeT/Hnyd+s7F5GHwtrUk7BU8e
        yTysJj1lGSSq6HgVvEd0WD8Dh9eqBjVvdGXqDenMgQ==
X-Google-Smtp-Source: ABdhPJz3Thrnbg4dSqU+BoOQp4IJma6lc3JBLsyl9Q3m01mIrlVWxB4SwxkTgcDQXsBg4R1HBpAR8UmcfdarMxR1wx8=
X-Received: by 2002:a0d:c0c6:0:b0:2ff:bb2:1065 with SMTP id
 b189-20020a0dc0c6000000b002ff0bb21065mr44984991ywd.512.1654786583034; Thu, 09
 Jun 2022 07:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 16:55:46 +0200
Message-ID: <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com>
Subject: Re: [PATCH 1/8] perf/hw_breakpoint: Optimize list of per-task breakpoints
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, 9 Jun 2022 at 16:29, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> >
> > On a machine with 256 CPUs, running the recently added perf breakpoint
> > benchmark results in:
> >
> >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> >  | # Running 'breakpoint/thread' benchmark:
> >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> >  |      Total time: 236.418 [sec]
> >  |
> >  |   123134.794271 usecs/op
> >  |  7880626.833333 usecs/op/cpu
> >
> > The benchmark tests inherited breakpoint perf events across many
> > threads.
> >
> > Looking at a perf profile, we can see that the majority of the time is
> > spent in various hw_breakpoint.c functions, which execute within the
> > 'nr_bp_mutex' critical sections which then results in contention on that
> > mutex as well:
> >
> >     37.27%  [kernel]       [k] osq_lock
> >     34.92%  [kernel]       [k] mutex_spin_on_owner
> >     12.15%  [kernel]       [k] toggle_bp_slot
> >     11.90%  [kernel]       [k] __reserve_bp_slot
> >
> > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > O(#tasks) due to storing all task breakpoints in the same list and
> > iterating through that list looking for a matching task. Clearly, this
> > does not scale to thousands of tasks.
> >
> > While one option would be to make task_struct a breakpoint list node,
> > this would only further bloat task_struct for infrequently used data.
>
> task_struct already has:
>
> #ifdef CONFIG_PERF_EVENTS
>   struct perf_event_context *perf_event_ctxp[perf_nr_task_contexts];
>   struct mutex perf_event_mutex;
>   struct list_head perf_event_list;
> #endif
>
> Wonder if it's possible to use perf_event_mutex instead of the task_sharded_mtx?
> And possibly perf_event_list instead of task_bps_ht? It will contain
> other perf_event types, so we will need to test type as well, but on
> the positive side, we don't need any management of the separate
> container.

Hmm, yes, I looked at that but then decided against messing the
perf/core internals. The main issue I have with using perf_event_mutex
is that we might interfere with perf/core's locking rules as well as
interfere with other concurrent perf event additions. Using
perf_event_list is very likely a no-go because it requires reworking
perf/core as well.

I can already hear Peter shouting, but maybe I'm wrong. :-)
