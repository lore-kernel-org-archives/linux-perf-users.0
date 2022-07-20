Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60ABCCA485
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Jul 2022 15:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbiGTPXO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237863AbiGTPXL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Jul 2022 11:23:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4D75B798
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:23:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h9so1531739wrm.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Jul 2022 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vOU8fNK31UdaRFTxZH7uUNE10MhT+gyU0GxNesrMTbk=;
        b=gJKMaw7OQwUE8Pl82nASUpBV4CsNQg2+F33xJj7v8amh288eCv9edv4bEuz5Ihf6zq
         Y1aZR7HfYF1dH9JYipjA7nh7IeXkWXwxfpZbzCLak3lfmkGNTBbq9zbzND9LvlhEJ0tw
         L7Cme0DFbAMsL+Km35Aq7T7mkyrZyjM3ejLCO1rACTQF2dGqR+2aT1yrne7DQtAZQ5nh
         l7FDfNdM+eaWlD01XQ3yzUFD91FtX5fidvr605rvCT2KxKPRdPBuQ9sjhmLrTbUrcs3f
         rgF+mmeeOlHYtIYYQyCKjUo0jSSu2lQOPc6mA6MlL03DQ9DndWc45505ylDGPpXPyp33
         GFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vOU8fNK31UdaRFTxZH7uUNE10MhT+gyU0GxNesrMTbk=;
        b=6hAa9xYFXC+5hyiIyB+5x/h/cn2FrvQ5ECE/K3cHGNAirEGe+WuBYmP/SRdRO7gcEV
         QJy1q8a431uZ6q9XsdbMfjWZC0XVYYJKAeA/b37ROBQgSj0kZE3EF6o29EvDMWoPmEsr
         A4WLVVSA5JTkFco+rlJ2XEIVzSb+oIPbFZUfndhbcH5ZlmyWZ1BmDMUHoJGTzfxwBqH4
         Xyse0CEjo8+usFTJklOXqAJ2yS0I32VszXsU2EUBPO+AlLO8V1U2rAfrdsucrdUiW/y6
         253ifqSN2Ck19zoPkt0LeNLPZjc+G56D3XlE2XuTtbeoFYSRcODl6yE2YPFGg/0CcLpC
         /TGA==
X-Gm-Message-State: AJIora9R5fvBNJdhd98NcYWjNNJr2mfCo9j3+zdKEC/xkJq0vJDJYZg5
        1UGDztDWh9gs/urg1rP3A2P6yqAUvtyvERXTjamgKg==
X-Google-Smtp-Source: AGRyM1tZmXjjuviW3um3Zs7KIJzIOIOdxEu1q/OkiLALO3+VsFJigpodFYG/Q1++/Z9jVmED5wEZC5v9q22r32zBYo8=
X-Received: by 2002:a05:6000:8e:b0:21d:7e97:67ed with SMTP id
 m14-20020a056000008e00b0021d7e9767edmr30017427wrx.343.1658330588252; Wed, 20
 Jul 2022 08:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220704150514.48816-1-elver@google.com> <20220704150514.48816-3-elver@google.com>
 <CACT4Y+aYCkTWu+vBdX2d5GNB9z8oZ+8=a330sK9s18FS8t+6=Q@mail.gmail.com>
In-Reply-To: <CACT4Y+aYCkTWu+vBdX2d5GNB9z8oZ+8=a330sK9s18FS8t+6=Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Jul 2022 08:22:56 -0700
Message-ID: <CAP-5=fWBVm08LetcyRUh6MK+_gQmyJYxR2sfeZ8LvXfeeJs=zg@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] perf/hw_breakpoint: Provide hw_breakpoint_is_used()
 and use in test
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Jul 4, 2022 at 8:10 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Mon, 4 Jul 2022 at 17:06, Marco Elver <elver@google.com> wrote:
> >
> > Provide hw_breakpoint_is_used() to check if breakpoints are in use on
> > the system.
> >
> > Use it in the KUnit test to verify the global state before and after a
> > test case.
> >
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> > ---
> > v3:
> > * New patch.
> > ---
> >  include/linux/hw_breakpoint.h      |  3 +++
> >  kernel/events/hw_breakpoint.c      | 29 +++++++++++++++++++++++++++++
> >  kernel/events/hw_breakpoint_test.c | 12 +++++++++++-
> >  3 files changed, 43 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index 78dd7035d1e5..a3fb846705eb 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -74,6 +74,7 @@ register_wide_hw_breakpoint(struct perf_event_attr *attr,
> >  extern int register_perf_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> > +extern bool hw_breakpoint_is_used(void);
> >
> >  extern int dbg_reserve_bp_slot(struct perf_event *bp);
> >  extern int dbg_release_bp_slot(struct perf_event *bp);
> > @@ -121,6 +122,8 @@ register_perf_hw_breakpoint(struct perf_event *bp)  { return -ENOSYS; }
> >  static inline void unregister_hw_breakpoint(struct perf_event *bp)     { }
> >  static inline void
> >  unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)        { }
> > +static inline bool hw_breakpoint_is_used(void)         { return false; }
> > +
> >  static inline int
> >  reserve_bp_slot(struct perf_event *bp)                 {return -ENOSYS; }
> >  static inline void release_bp_slot(struct perf_event *bp)              { }
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index f32320ac02fd..fd5cd1f9e7fc 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -604,6 +604,35 @@ void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events)
> >  }
> >  EXPORT_SYMBOL_GPL(unregister_wide_hw_breakpoint);
> >
> > +/**
> > + * hw_breakpoint_is_used - check if breakpoints are currently used
> > + *
> > + * Returns: true if breakpoints are used, false otherwise.
> > + */
> > +bool hw_breakpoint_is_used(void)
> > +{
> > +       int cpu;
> > +
> > +       if (!constraints_initialized)
> > +               return false;
> > +
> > +       for_each_possible_cpu(cpu) {
> > +               for (int type = 0; type < TYPE_MAX; ++type) {
> > +                       struct bp_cpuinfo *info = get_bp_info(cpu, type);
> > +
> > +                       if (info->cpu_pinned)
> > +                               return true;
> > +
> > +                       for (int slot = 0; slot < nr_slots[type]; ++slot) {
> > +                               if (info->tsk_pinned[slot])
> > +                                       return true;
> > +                       }
> > +               }
> > +       }
> > +
> > +       return false;
> > +}
> > +
> >  static struct notifier_block hw_breakpoint_exceptions_nb = {
> >         .notifier_call = hw_breakpoint_exceptions_notify,
> >         /* we need to be notified first */
> > diff --git a/kernel/events/hw_breakpoint_test.c b/kernel/events/hw_breakpoint_test.c
> > index 433c5c45e2a5..5ced822df788 100644
> > --- a/kernel/events/hw_breakpoint_test.c
> > +++ b/kernel/events/hw_breakpoint_test.c
> > @@ -294,7 +294,14 @@ static struct kunit_case hw_breakpoint_test_cases[] = {
> >  static int test_init(struct kunit *test)
> >  {
> >         /* Most test cases want 2 distinct CPUs. */
> > -       return num_online_cpus() < 2 ? -EINVAL : 0;
> > +       if (num_online_cpus() < 2)
> > +               return -EINVAL;
> > +
> > +       /* Want the system to not use breakpoints elsewhere. */
> > +       if (hw_breakpoint_is_used())
> > +               return -EBUSY;
> > +
> > +       return 0;
> >  }
> >
> >  static void test_exit(struct kunit *test)
> > @@ -308,6 +315,9 @@ static void test_exit(struct kunit *test)
> >                 kthread_stop(__other_task);
> >                 __other_task = NULL;
> >         }
> > +
> > +       /* Verify that internal state agrees that no breakpoints are in use. */
> > +       KUNIT_EXPECT_FALSE(test, hw_breakpoint_is_used());
> >  }
> >
> >  static struct kunit_suite hw_breakpoint_test_suite = {
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
> >
