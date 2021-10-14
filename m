Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A438C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D648611ED
	for <linux-perf-users@archiver.kernel.org>; Thu, 14 Oct 2021 19:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhJNT1I (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 14 Oct 2021 15:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231502AbhJNT1I (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 14 Oct 2021 15:27:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1987611EE;
        Thu, 14 Oct 2021 19:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634239503;
        bh=s095ztIWjecF3ddp7VnVfu5GS0zxosPq1G0pSlcsoMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TCGAU6+Keu5NRrHBXgxIFXWm4vlKCE5VtKhHndzLC+5HUOnUciAffY/P2JETfd6B5
         PJYfXuKZDKUEXyiMEYjHaHPc9wLv4X+C4AFH07hvmUF9wvDkr4/S1t7k6tc7m/o29y
         pocV7F9j794m5HZju+c0O8DhazY06EaYJlvEZgHQ4+cF12dqAZHZkMeO9Mb02mywZj
         rjGPRwjqrG6psjZNcKrYC8BbJTG2bNqos7LMbw0K4ejIifnzIKmXpeXecFdDOYVhZd
         GgM5lxXnM/Eu3ZmfWK61WELIpl5GSBaQvGDDV0REC5kaI0MiUx0jqZscXVcuTNHDGI
         ENrJjRlX6g8ew==
Received: by mail-ed1-f41.google.com with SMTP id d9so28198221edh.5;
        Thu, 14 Oct 2021 12:25:02 -0700 (PDT)
X-Gm-Message-State: AOAM530TQcg2XsPTvZ5cLHfxpLaU0kjF+qD1nqKlouJh1aLA/1m3YR5C
        SQdySLNKrac8+89AUcx3vMU1RaXMGxHnLr3AYg==
X-Google-Smtp-Source: ABdhPJwq5Gw19dFATrpLDxluwWqjderxG4Ya3bA/fI1vwkp5fudHXwIbdew6OpN5lb0JrUV6CX6syazxJPHY8rbiA5s=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr1039085ejx.363.1634239501233;
 Thu, 14 Oct 2021 12:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210914204800.3945732-1-robh@kernel.org> <20210914204800.3945732-5-robh@kernel.org>
 <20211014165810.GA39276@lakrids.cambridge.arm.com>
In-Reply-To: <20211014165810.GA39276@lakrids.cambridge.arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 Oct 2021 14:24:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+OO3cbnsX6OdgKSL+3c8mn=KzanTJBePk-eA1J304uFA@mail.gmail.com>
Message-ID: <CAL_Jsq+OO3cbnsX6OdgKSL+3c8mn=KzanTJBePk-eA1J304uFA@mail.gmail.com>
Subject: Re: [PATCH v10 4/5] arm64: perf: Enable PMU counter userspace access
 for perf event
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Oct 14, 2021 at 11:58 AM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Rob,
>
> This looks pretty good!
>
> I have one largish query below, and otherwise only trivialities that I'm
> happy to fix up.
>
> On Tue, Sep 14, 2021 at 03:47:59PM -0500, Rob Herring wrote:
> > Arm PMUs can support direct userspace access of counters which allows for
> > low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
> > exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
> > enabled for thread bound events. This could be extended if needed, but
> > simplifies the implementation and reduces the chances for any
> > information leaks (which the x86 implementation suffers from).
> >
> > PMU EL0 access will be enabled when an event with userspace access is
> > part of the thread's context. This includes when the event is not
> > scheduled on the PMU. There's some additional overhead clearing
> > dirty counters when access is enabled in order to prevent leaking
> > disabled counter data from other tasks.
> >
> > Unlike x86, enabling of userspace access must be requested with a new
> > attr bit: config1:1. If the user requests userspace access and 64-bit
> > counters, then chaining will be disabled and the user will get the
> > maximum size counter the underlying h/w can support. The modes for
> > config1 are as follows:
> >
> > config1 = 0 : user access disabled and always 32-bit
> > config1 = 1 : user access disabled and always 64-bit (using chaining if needed)
> > config1 = 2 : user access enabled and always 32-bit
> > config1 = 3 : user access enabled and counter size matches underlying counter.
>
> We probably need to note somewhere (i.e. in the next patch) that we mean
> *logically* 32-bit, and this could be a biased 64-bit counter, so
> userspace needs to treat the upper 32-bits of counters as UNKNOWN.

Okay, though this detail doesn't matter if the user uses the correct
read loop (now in libperf).

> For the `config1 = 3` case (potentially) overriding the usual long
> semantic, I'm struggling to understand why we need that rather than
> forcing the use of a 64-bit counter, because in that case:
>
> * For a CPU_CYCLES event:
>   __armv8_pmuv3_map_event() will always pick 64-bits
>   get_event_idx() may fail to allocate a 64-bit counter.
>
> * For other events:
>   __armv8_pmuv3_map_event() will pick 32/64 based on long counter
>   support
>   get_event_idx() will only fail if there are no counters free.
>
> Whereas if __armv8_pmuv3_map_event() returned an error for the latter
> when long counter support is not implemented, we'd have consistent
> `long` semantics, and the CPU_CYCLES behaviour would be identical.
>
> What's the rationale for `3` leaving the choice to the kernel?

It's the give me the maximum sized counter the h/w can support choice.
That's easier for userspace to implement. Bit 1 is more of a hint that
the user wants userspace access rather than a requirement.

> If the problem is discoverability, I'd be happy to add something to
> sysfs to describe whether the PMU has long event support.

Checking sysfs or a try for 64-bit support then fall back to 32-bit
support isn't much difference.

Keep in mind that x86 always succeeds here. Every userspace user will
have to add whatever dance we create here. For example, each libperf
test with user access (there's only 2 in my tree, but there's a series
adding more) has to have an '#ifdef __aarch64__' for whatever we do
here. I was seeking to minimize that. Right now, that's just a set
config1 to 0x3. Also, note that libperf will opportunistically use a
userspace read instead of read(). The user just has to mmap the event
and libperf will use a userspace read when enabled which ultimately
depends on what the mmapped page says.

[...]

> > @@ -995,9 +1050,23 @@ static int __armv8_pmuv3_map_event(struct perf_event *event,
> >                                      &armv8_pmuv3_perf_cache_map,
> >                                      ARMV8_PMU_EVTYPE_EVENT);
> >
> > -     if (armv8pmu_event_is_64bit(event))
> > +     /*
> > +      * At this point, the counter is not assigned. If a 64-bit counter is
> > +      * requested, we must make sure the h/w has 64-bit counters if we set
> > +      * the event size to 64-bit because chaining is not supported with
> > +      * userspace access. This may still fail later on if the CPU cycle
> > +      * counter is in use.
> > +      */
> > +     if (armv8pmu_event_is_64bit(event) &&
> > +         (!armv8pmu_event_want_user_access(event) ||
> > +          armv8pmu_has_long_event(armpmu) || (hw_event_id == ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
> >               event->hw.flags |= ARMPMU_EVT_64BIT;
>
> If we can follow my suggestion in reply to the cover text, we can make
> this:
>
>         if (armv8pmu_event_is_64bit(event))
>                 event->hw.flags |= ARMPMU_EVT_64BIT;
>
>         /*
>          * User events must be allocated into a single counter, and so
>          * must not be chained.
>          *
>          * Most 64-bit events require long counter support, but 64-bit
>          * CPU_CYCLES events can be placed into the dedicated cycle
>          * counter when this is free.
>          *
>         if (armv8pmu_event_want_user_access()) {
>                 if (armv8pmu_event_is_64bit(event) &&
>                     (hw_event_id != ARMV8_PMUV3_PERFCTR_CPU_CYCLES) &&
>                     !armv8pmu_has_long_event(armpmu))
>                         return -EINVAL;
>         }
>
> > +     /* Userspace counter access only enabled if requested and a per task event */
> > +     if (sysctl_perf_user_access && armv8pmu_event_want_user_access(event) &&
> > +         (event->attach_state & PERF_ATTACH_TASK))
> > +             event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
>
> Can we please explicitly reject !PERF_ATTACH_TASK case?
>
> If the user requested something we don't intend to support, I'd rather
> return -EINVAL here, rather than continue on.

This is similar to the 64-bit case though I'm somewhat less concerned
here given per cpu events aren't too useful in this case and the setup
is a bit different already.

Rob
