Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29480CCA473
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 18:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345461AbiFIShp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 14:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233080AbiFIShn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 14:37:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D8931DD9
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 11:37:41 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-30c2f288f13so250331517b3.7
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Hj76BK0VwQ76C6uNuhyu2UOiDef16x6n+WhyTwiuL8=;
        b=RXSLJN2r52szX6Cnw+KXoRkm5vFEmwzfQJR7lJ/Ixw/a4O/IdfAI9SSV6dT03AzgUP
         M+w40EuKmIQpz0K5O7olO6ouYCrw/mP2EPuyvHUyotiJED4+hKPEman/oWmGeKfposGF
         f6kKJcrRXpk4J/dR2UPUa7/yG8CHSRZxUTXNVlVIIPc+byUzzS4AQN/5O7+S2DvEDWud
         Akol4RAuQgb/gL1FMVAcwaGcDgWS7ZBaFX4uIygMvU21K6SZvKJ24dIH42Yx/1lQrAG0
         FCrMbdbH+2ZPdt3SWlt9OlcSqzL2d7TxDky9DyGIsCv/5LTw/jdAwAOFTWKxRW1yl6jW
         y3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Hj76BK0VwQ76C6uNuhyu2UOiDef16x6n+WhyTwiuL8=;
        b=QMJl1fV/6uXMYFxHWTvRhss7YPGNemkhzJsmgoR61ORvq5k4qErMnISTbnYh6xedwy
         5RiXgfy1VwOcMqlwOuu8MXhg9n2KdTwLwN32Say7ATJo82p5a2zQZg4/IwyJjEvDOgS0
         iIIEiK15dc5indULik7UrOJzCHoKIdtPjU/mO2lh3h2JkZ/PunFbSPqY727dDWg5gz5T
         eldjgskjwoXOIvvLptPDkioBmPkFElBrlueZEHv0ca8X79aBnVrytUDyDF2RzbFBjjfO
         qJx+76EEIXGdjOY2A03YVzCVXmtPKFrGuYlEU7T4IUbWWs3yQJsXZuALT6PPRWOPdsTy
         ZvOg==
X-Gm-Message-State: AOAM532HnHdwqz949bzpPlj9CQ+L5EKjBPF6XGVJ/oYg1PkVVqJItgv2
        HBbOP4cIqlZXLZugmkUoid4/EpUVmMFhTyRmL2ZBgA==
X-Google-Smtp-Source: ABdhPJyPun0oORefCEO0LL2xiAgBLsvVeq0N5dshMTrTTvEQkgH3BMTQ7tdvm5AN6boSy1DBa7+bcxeIx+gFcsxeKbo=
X-Received: by 2002:a81:9b0c:0:b0:2f4:c522:7d3c with SMTP id
 s12-20020a819b0c000000b002f4c5227d3cmr44383963ywg.316.1654799860756; Thu, 09
 Jun 2022 11:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-2-elver@google.com>
 <CACT4Y+bOFmCyqfSgWS0b5xuwnPqP4V9v2ooJRmFCn0YAtOPmhQ@mail.gmail.com>
 <CANpmjNNtV_6kgoLv=VX3z_oM6ZEvWJNAOj9z4ADcymqmhc+crw@mail.gmail.com> <CACT4Y+Zq-1nczM2JH7Sr4mZo84gsCRd83RAwwnHwmap-wCOLTQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Zq-1nczM2JH7Sr4mZo84gsCRd83RAwwnHwmap-wCOLTQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 20:37:04 +0200
Message-ID: <CANpmjNNC7ry59OXsJrPMf56Xi63chexaDfnP4t8_4MG7S5ZgCg@mail.gmail.com>
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

On Thu, 9 Jun 2022 at 18:53, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> .
> /On Thu, 9 Jun 2022 at 16:56, Marco Elver <elver@google.com> wrote:
> > > > On a machine with 256 CPUs, running the recently added perf breakpoint
> > > > benchmark results in:
> > > >
> > > >  | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
> > > >  | # Running 'breakpoint/thread' benchmark:
> > > >  | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
> > > >  |      Total time: 236.418 [sec]
> > > >  |
> > > >  |   123134.794271 usecs/op
> > > >  |  7880626.833333 usecs/op/cpu
> > > >
> > > > The benchmark tests inherited breakpoint perf events across many
> > > > threads.
> > > >
> > > > Looking at a perf profile, we can see that the majority of the time is
> > > > spent in various hw_breakpoint.c functions, which execute within the
> > > > 'nr_bp_mutex' critical sections which then results in contention on that
> > > > mutex as well:
> > > >
> > > >     37.27%  [kernel]       [k] osq_lock
> > > >     34.92%  [kernel]       [k] mutex_spin_on_owner
> > > >     12.15%  [kernel]       [k] toggle_bp_slot
> > > >     11.90%  [kernel]       [k] __reserve_bp_slot
> > > >
> > > > The culprit here is task_bp_pinned(), which has a runtime complexity of
> > > > O(#tasks) due to storing all task breakpoints in the same list and
> > > > iterating through that list looking for a matching task. Clearly, this
> > > > does not scale to thousands of tasks.
> > > >
> > > > While one option would be to make task_struct a breakpoint list node,
> > > > this would only further bloat task_struct for infrequently used data.
> > >
> > > task_struct already has:
> > >
> > > #ifdef CONFIG_PERF_EVENTS
> > >   struct perf_event_context *perf_event_ctxp[perf_nr_task_contexts];
> > >   struct mutex perf_event_mutex;
> > >   struct list_head perf_event_list;
> > > #endif
> > >
> > > Wonder if it's possible to use perf_event_mutex instead of the task_sharded_mtx?
> > > And possibly perf_event_list instead of task_bps_ht? It will contain
> > > other perf_event types, so we will need to test type as well, but on
> > > the positive side, we don't need any management of the separate
> > > container.
> >
> > Hmm, yes, I looked at that but then decided against messing the
> > perf/core internals. The main issue I have with using perf_event_mutex
> > is that we might interfere with perf/core's locking rules as well as
> > interfere with other concurrent perf event additions. Using
> > perf_event_list is very likely a no-go because it requires reworking
> > perf/core as well.
> >
> > I can already hear Peter shouting, but maybe I'm wrong. :-)
>
> Let's wait for Peter to shout then :)
> A significant part of this change is having per-task data w/o having
> per-task data.
>
> The current perf-related data in task_struct is already multiple words
> and it's also not used in lots of production cases.
> Maybe we could have something like:
>
>   struct perf_task_data* lazily_allocated_perf_data;
>
> that's lazily allocated on first use instead of the current
> perf_event_ctxp/perf_event_mutex/perf_event_list.
> This way we could both reduce task_size when perf is not used and have
> more perf-related data (incl breakpoints) when it's used.

I don't mind either option, so keeping task_struct bloat in mind, we have:

  1. rhashtable option, no changes to task_struct.

  2. add the breakpoint mutex + list to task_struct.

  3. add something like hw_breakpoint_task_data* and allocate lazily.

  4. (your proposal) move all of perf data into a new struct (+add
hw_breakpoint things in there) that is lazily allocated.

I don't think perf is that infrequently used, and I can't estimate
performance impact, so I don't like #4 too much personally. My
preferred compromise would be #3, but at the same time I'd rather not
bloat task_struct even with 8 extra infrequently used bytes. Am I too
paranoid?

Preferences?
