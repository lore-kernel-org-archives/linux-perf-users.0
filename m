Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE00EC433EF
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Jun 2022 12:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234225AbiFIMX5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Jun 2022 08:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245363AbiFIMXv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Jun 2022 08:23:51 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718B62ED7D
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Jun 2022 05:23:49 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id a29so9209704lfk.2
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jun 2022 05:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=llootBNvnKzlHSo7HBVwmmGvWmrZUKeALsskuPp9oY4=;
        b=PFIHGY61X8JnRhWtvwXV3fYxBQkbuMhPZHdKbAHE3ATwSdFXTvNH4TNE3BWhkVLrTA
         RnsJwyyJcVEHEP9Nw5e+K1ihE7iH0Xfit/DfK0NPMl9vttkwJvauVBNABZvteYYsIhEh
         yv7YZ//OcOg7qT5bGswpxjgt+Kfvd6LF7haJGNsBalV56ROiZBUrZdj6zL22RcMJkqIQ
         ZwIeIB/NPCZGcTqz0av+IrXgk4syOGa6CvDK6t6N2/4LjyIeWwkjxghkYiKyEOOhAR+U
         5CXFKlE07dNhpOd0idZE212zOSd6eDxZHxCwrE/ZsdVg350SfgcYq6bDbib5CToscZpb
         i6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=llootBNvnKzlHSo7HBVwmmGvWmrZUKeALsskuPp9oY4=;
        b=XmneC54ZkGX7hbv/YkjG4xcX7scr6SrKnF0xSljdn65LtZe0KubsKifk9mksujjWUe
         enlnMR6s5L8RvfWgAev1gtU3Gapt9kXIxs2VtA715mW+dx0d3jXKlYRt4f+1HVkVcAf8
         AIo6IVYYui7tFkcewIbE9tNVGcc+IsnPumgkJT6KgQB2kmZYHW6Bj0WfPmZEo851an1Y
         MN3T3ztjl7lPcWKMoOlqvFrX6dYNMne8MlwTU5xnRmAdk3IxSr0k0zPO3nlHq0T/0YhN
         hRP5s/X5TvVN0vncfN7fjhF2K3GmdmJTcdEd7rrwhfNgFEgya7ZIAUFQgBFUrnZ15GQi
         Lkbw==
X-Gm-Message-State: AOAM530lBkSMLsWHLW//HZmca/XzZyeBZi07TMJ1UDohYlbnIsy9g79R
        SpacdFKHAtujDTngYJQdj+7+aksVfEOfzECU9tGNIA==
X-Google-Smtp-Source: ABdhPJwDpiUpaZytilZz3A9LwfP5rEpTlz66NiST1TJCSJiNj11xLM4RNAU6bTosWzRJ6AUHgpeR9/FZ2okUFaMrfLU=
X-Received: by 2002:a05:6512:1085:b0:479:478b:d2cc with SMTP id
 j5-20020a056512108500b00479478bd2ccmr12747169lfg.540.1654777427515; Thu, 09
 Jun 2022 05:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220609113046.780504-1-elver@google.com> <20220609113046.780504-5-elver@google.com>
 <CACT4Y+YHp1mxxGNuGke42qcph0ibZb+6Ri_7fNJ+jg11NL-z8g@mail.gmail.com> <CANpmjNMA=UKzpURckHh_Ss14oRoTQ7nZ4yqcb=nV1kBtEcEkdw@mail.gmail.com>
In-Reply-To: <CANpmjNMA=UKzpURckHh_Ss14oRoTQ7nZ4yqcb=nV1kBtEcEkdw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jun 2022 14:23:36 +0200
Message-ID: <CACT4Y+ayhGH253WA_zXYJjfOK=YxGLDZLzkyyqLHW+EZzJYpEg@mail.gmail.com>
Subject: Re: [PATCH 4/8] perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
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

On Thu, 9 Jun 2022 at 14:08, Marco Elver <elver@google.com> wrote:
> > > Due to being a __weak function, hw_breakpoint_weight() will cause the
> > > compiler to always emit a call to it. This generates unnecessarily bad
> > > code (register spills etc.) for no good reason; in fact it appears in
> > > profiles of `perf bench -r 100 breakpoint thread -b 4 -p 128 -t 512`:
> > >
> > >     ...
> > >     0.70%  [kernel]       [k] hw_breakpoint_weight
> > >     ...
> > >
> > > While a small percentage, no architecture defines its own
> > > hw_breakpoint_weight() nor are there users outside hw_breakpoint.c,
> > > which makes the fact it is currently __weak a poor choice.
> > >
> > > Change hw_breakpoint_weight()'s definition to follow a similar protocol
> > > to hw_breakpoint_slots(), such that if <asm/hw_breakpoint.h> defines
> > > hw_breakpoint_weight(), we'll use it instead.
> > >
> > > The result is that it is inlined and no longer shows up in profiles.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > >  include/linux/hw_breakpoint.h | 1 -
> > >  kernel/events/hw_breakpoint.c | 4 +++-
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > > index 78dd7035d1e5..9fa3547acd87 100644
> > > --- a/include/linux/hw_breakpoint.h
> > > +++ b/include/linux/hw_breakpoint.h
> > > @@ -79,7 +79,6 @@ extern int dbg_reserve_bp_slot(struct perf_event *bp);
> > >  extern int dbg_release_bp_slot(struct perf_event *bp);
> > >  extern int reserve_bp_slot(struct perf_event *bp);
> > >  extern void release_bp_slot(struct perf_event *bp);
> > > -int hw_breakpoint_weight(struct perf_event *bp);
> > >  int arch_reserve_bp_slot(struct perf_event *bp);
> > >  void arch_release_bp_slot(struct perf_event *bp);
> > >  void arch_unregister_hw_breakpoint(struct perf_event *bp);
> > > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > > index 8e939723f27d..5f40c8dfa042 100644
> > > --- a/kernel/events/hw_breakpoint.c
> > > +++ b/kernel/events/hw_breakpoint.c
> > > @@ -125,10 +125,12 @@ static __init int init_breakpoint_slots(void)
> > >  }
> > >  #endif
> > >
> > > -__weak int hw_breakpoint_weight(struct perf_event *bp)
> >
> > Humm... this was added in 2010 and never actually used to return
> > anything other than 1 since then (?). Looks like over-design. Maybe we
> > drop "#ifndef" and add a comment instead?
>
> Then there's little reason for the function either and we can just
> directly increment/decrement 1 everywhere. If we drop the ability for
> an arch to override, I feel that'd be cleaner.
>
> Either way, codegen won't change though.
>
> Preferences?

I don't have strong preferences either way.
Can also be:
#define HW_BREAKPOINT_WEIGHT 1
