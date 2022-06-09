Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A8EC43334
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 14:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiFIOA6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 10:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243975AbiFIOA4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 10:00:56 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9702A25E2
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 07:00:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id y188so12431959ybe.11
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 07:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jqhwYhya53Ub6ysqItH4y8unqJO0QhApIrC1/649j54=;
        b=fGOxnn0AqIvYwnlMzEqVt2e8++kIdmsh79Hl2DvxieLeED7eK+Cc6fsvF3UcIM7nvV
         U6qYnDICRLaiJkcwGKsasTPP4dcUwp7ITGHcGUdzJbJ8XAdlN+CfDvbYsEEYdhNCguKp
         qrmjHuQfrNYXGZI7AQQUGhB5jI3Ohh6mOo6mNsG6wFsuSMNQsColJNkAh9OU2W0FTQu9
         97lskwpM1QSWrTR6eivnxWbhCLpJWZiObbiCq9FVCyouTtaF/acGBdX0fS3Vud/WQuAj
         W7TsxsE+YptpX2ec1uuqVrpEk7dxtnqbEDCuGXPJTv/VSfFSwn5pcF4M2++C0viTCSTA
         xSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jqhwYhya53Ub6ysqItH4y8unqJO0QhApIrC1/649j54=;
        b=vQ76X+OL3RZysw/dbcAz8sEuzeOLZozhPtBsJMirSKkWDPxPLTcjDvlBJUFRSRcilV
         3Q8dsyO6nynS0Kw35Io6BVoiqcuPlvjKHr7AqRnNfGMwwZtTdQ0AJQvZy3L6kB573PzM
         OHswBnBoAwHmHgysErOeX025nTQEwNK4WR1/crP+irP9+RRS67WyU4vOlYFBJmQLfp8+
         oLPbcSz8JcV6Ahlu4QCVIz3WPeiVkCi5SfQ8P1cgevxuqUm3OTipGS3q8SkKLSkzhdAr
         kMgf2rtz3MJCyWdhkP7nKVdQsc512App6B4a11kGp0EjqR4mur72Lv3zEH3vP1JhZWRK
         C7IA==
X-Gm-Message-State: AOAM532rT3PaII6x5e7LrII+W8Y9bJbaoYmtcLc4n0GnJQB2p+JkeunM
        FL0rXZ/3M0NBiK1Fcyey1rQbA5FC2ocC04fA9A3P8g==
X-Google-Smtp-Source: ABdhPJzTt5jB8Al00H/AKfb9WPbMyvnzrSMN+GZ+fLZlVKzwpmwSjeqTtUGB58clLqpL/2r6TUP1/Fvy9ZWcKb1JHso=
X-Received: by 2002:a25:780b:0:b0:664:3e22:3368 with SMTP id
 t11-20020a25780b000000b006643e223368mr2020008ybc.625.1654783254347; Thu, 09
 Jun 2022 07:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-6-elver@google.com>
 <CACT4Y+Zd0Zd_66DZ-f2HG4tR6ZdraFe9b4iEBJmG9p72+7RMWQ@mail.gmail.com> <CACT4Y+appPi5YAdKFB-2caO6xkg89FmV1_4532u7Jx_5CAX9xw@mail.gmail.com>
In-Reply-To: <CACT4Y+appPi5YAdKFB-2caO6xkg89FmV1_4532u7Jx_5CAX9xw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 9 Jun 2022 16:00:16 +0200
Message-ID: <CANpmjNP7pUYY7T1pCOVCJ_WaomdeuQzcLin46VVtyEmT4pQ4iA@mail.gmail.com>
Subject: Re: [PATCH 5/8] perf/hw_breakpoint: Remove useless code related to
 flexible breakpoints
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

On Thu, 9 Jun 2022 at 15:41, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, 9 Jun 2022 at 14:04, Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, 9 Jun 2022 at 13:31, Marco Elver <elver@google.com> wrote:
> > >
> > > Flexible breakpoints have never been implemented, with
> > > bp_cpuinfo::flexible always being 0. Unfortunately, they still occupy 4
> > > bytes in each bp_cpuinfo and bp_busy_slots, as well as computing the max
> > > flexible count in fetch_bp_busy_slots().
> > >
> > > This again causes suboptimal code generation, when we always know that
> > > `!!slots.flexible` will be 0.
> > >
> > > Just get rid of the flexible "placeholder" and remove all real code
> > > related to it. Make a note in the comment related to the constraints
> > > algorithm but don't remove them from the algorithm, so that if in future
> > > flexible breakpoints need supporting, it should be trivial to revive
> > > them (along with reverting this change).
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Was added in 2009.
> >
> > Acked-by: Dmitry Vyukov <dvyukov@google.com>
> >
> > > ---
> > >  kernel/events/hw_breakpoint.c | 12 +++---------
> > >  1 file changed, 3 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > > index 5f40c8dfa042..afe0a6007e96 100644
> > > --- a/kernel/events/hw_breakpoint.c
> > > +++ b/kernel/events/hw_breakpoint.c
> > > @@ -46,8 +46,6 @@ struct bp_cpuinfo {
> > >  #else
> > >         unsigned int    *tsk_pinned;
> > >  #endif
> > > -       /* Number of non-pinned cpu/task breakpoints in a cpu */
> > > -       unsigned int    flexible; /* XXX: placeholder, see fetch_this_slot() */
> > >  };
> > >
> > >  static DEFINE_PER_CPU(struct bp_cpuinfo, bp_cpuinfo[TYPE_MAX]);
> > > @@ -71,7 +69,6 @@ static bool constraints_initialized __ro_after_init;
> > >  /* Gather the number of total pinned and un-pinned bp in a cpuset */
> > >  struct bp_busy_slots {
>
> Do we also want to remove this struct altogether? Now it becomes just
> an int counter.

Yes, that actually can simplify a bunch of things, including
fetch_bp_busy_slots() just returning an int and fetch_this_slot() can
be removed (it'll be even cleaner if we remove the overridable
weight).

I'll simplify unless I hear objections.
