Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789A6C4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A236109F
	for <linux-perf-users@archiver.kernel.org>; Thu, 12 Aug 2021 18:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbhHLSRW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 14:17:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237425AbhHLSRW (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 12 Aug 2021 14:17:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F242E6108C;
        Thu, 12 Aug 2021 18:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628792217;
        bh=oLtrC58rdoMC0xs3g4iEEpKl1lyWBYmZLEZ7SZgb5vE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kz+R0+ydAdnR6mwEAL9hcrhF4tRVtIeGYhk/T0yO1EfZa91n3GWcGBnKR22614fuC
         nC4+95T1UHjoNoCs3NmJ0YObQRmJ6OFnkG57IMzlR6FHTNSFsruOHHTH0CfdddRuFY
         fbwdGHz5/t9V3uBhfbAWT2Y9FTqpRD/UmjGtTj7U9c4xo5v1vDrj2vBAlESRxxZqDP
         x93ykMuprlv51ZOIbhrmzyeTv2QTinuhM4VPKG64XebRG7Iag31j2FrqnMQBQp3UD8
         pI3ydVNaPBB3lOP1q7EFifG/5oI4o6u6I4UXa4RfYa4TE0FjgGtOMnKM/+UqJsIpMU
         AJUc8A0Ljl16w==
Received: by mail-ej1-f49.google.com with SMTP id z20so13292257ejf.5;
        Thu, 12 Aug 2021 11:16:56 -0700 (PDT)
X-Gm-Message-State: AOAM531tJlE4RF7QWaEgP3cVbP+gy4clSf7KS679BjILdgBxBYcD7Xa5
        yJSqgYYAayyddE93VrhtGT+5xpUXSADJFBOVjA==
X-Google-Smtp-Source: ABdhPJzhy0rgdcARCdwK95CS+69vv/dyWaAQUi31VoBNdIc9NcTmkEiHaWD1Pl+qsvz6YjxpQFSQb+fW6SEXr/7wZOo=
X-Received: by 2002:a17:906:519:: with SMTP id j25mr4793207eja.525.1628792215537;
 Thu, 12 Aug 2021 11:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210728230230.1911468-1-robh@kernel.org> <20210728230230.1911468-3-robh@kernel.org>
 <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
In-Reply-To: <d720903c-926e-f57a-0862-4e5d76db763a@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 12 Aug 2021 13:16:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
Message-ID: <CAL_JsqLRv9ugKJcn4dq_ps0JMt74Y7PKA=5yySYxvftdQWzzPA@mail.gmail.com>
Subject: Re: [RFC 2/3] perf/x86: Control RDPMC access from .enable() hook
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Aug 12, 2021 at 11:50 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> On 7/28/21 4:02 PM, Rob Herring wrote:
> > Rather than controlling RDPMC access behind the scenes from switch_mm(),
> > move RDPMC access controls to the PMU .enable() hook. The .enable() hook
> > is called whenever the perf CPU or task context changes which is when
> > the RDPMC access may need to change.
> >
> > This is the first step in moving the RDPMC state tracking out of the mm
> > context to the perf context.
>
> Is this series supposed to be a user-visible change or not?  I'm confused.

It should not be user-visible. Or at least not user-visible for what
any user would notice. If an event is not part of the perf context on
another thread sharing the mm, does that thread need rdpmc access? No
access would be a user-visible change, but I struggle with how that's
a useful scenario?

> If you intend to have an entire mm have access to RDPMC if an event is
> mapped, then surely access needs to be context switched for the whole
> mm.  If you intend to only have the thread to which the event is bound
> have access, then the only reason I see to use IPIs is to revoke access
> on munmap from the wrong thread.  But even that latter case could be
> handled with a more targeted approach, not a broadcast to all of mm_cpumask.

Right, that's what patch 3 does. When we mmap/munmap an event, then
the perf core invokes the callback only on the active contexts in
which the event resides.

> Can you clarify what the overall intent is and what this particular
> patch is trying to do?
>
> >
> >       if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
> > -             on_each_cpu_mask(mm_cpumask(mm), cr4_update_pce, NULL, 1);
> > +             on_each_cpu_mask(mm_cpumask(mm), x86_pmu_set_user_access_ipi, NULL, 1);
>
> Here you do something for the whole mm.

It's just a rename of the callback though.

>
> > -             on_each_cpu(cr4_update_pce, NULL, 1);
> > +             on_each_cpu(x86_pmu_set_user_access_ipi, NULL, 1);
>
> Here too.

It's not just the whole mm here as changing sysfs rdpmc permission is
a global state.

> >  void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >                       struct task_struct *tsk)
> >  {
> > @@ -581,10 +556,8 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
> >       this_cpu_write(cpu_tlbstate.loaded_mm, next);
> >       this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
> >
> > -     if (next != real_prev) {
> > -             cr4_update_pce_mm(next);
> > +     if (next != real_prev)
> >               switch_ldt(real_prev, next);
> > -     }
> >  }
>
> But if you remove this, then what handles context switching?

perf. On a context switch, perf is going to context switch the events
and set the access based on an event in the context being mmapped.
Though I guess if rdpmc needs to be enabled without any events opened,
this is not going to work. So maybe I need to keep the
rdpmc_always_available_key and rdpmc_never_available_key cases here.

The always available case is something we specifically don't want to
support for arm64. I'm trying to start with access more locked down,
rather than trying to lock it down after the fact as x86 is doing.

Rob
