Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D09DAC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 21:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC2C7613DB
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Aug 2021 21:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237418AbhHXV70 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237178AbhHXV7Z (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Aug 2021 17:59:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E249F613E8;
        Tue, 24 Aug 2021 21:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629842320;
        bh=1zGgGYmZ8ccSLcmu/js9bylshGYA4ts3mCpThSbDom8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qD3nNfmiDe3n91HmjSZ6A//76+yGIkE+KlLFtQwCy3ycXzwXfIDoUgiByPpP4arPl
         ZYTt4Or83NadBpr6tCxUZFjYcVhmRlbWGBQqZef5MPRe8mDlk/1Ds3bYJCvW5ebvB2
         VnMAvzkaXHxpchKZw//gwJtekzX5oW0AgyH8rq4SVWpKx57+2pii5qaWa8a58zQf1s
         znii1My/3Qj7JQ+YvlAZZ4JJv8YvSS1fRT8jhLPHwVsVL24zHHChCTAjSDGna7oJm9
         8crL2JhXp7nvvC5W+ifenAoAe+YJUZAmp9hPjYZKB/tETyUm6wPY33iR9y+zRJ0xZK
         6BfClbaZnTqGQ==
Received: by mail-ed1-f52.google.com with SMTP id g21so33860206edw.4;
        Tue, 24 Aug 2021 14:58:40 -0700 (PDT)
X-Gm-Message-State: AOAM5312MZGtSlp3Ugor+NJ6ktWaRU/4xu/kLhQXEK1LvpTTgelOogvC
        MeoDIyVInSHMxj62h5VyG+YetDvErWKTeDx+pg==
X-Google-Smtp-Source: ABdhPJyciSezk0bBOsszoGe9ly/QVi4Amhnl45pPcjy5tIWljewn/SUWcg8NAE4FTC5bS2EN5RFKASkUsfDDtNmNVWw=
X-Received: by 2002:aa7:c487:: with SMTP id m7mr25774343edq.62.1629842319421;
 Tue, 24 Aug 2021 14:58:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210806225123.1958497-1-robh@kernel.org> <20210806225123.1958497-3-robh@kernel.org>
 <20210824152720.GC23146@willie-the-truck>
In-Reply-To: <20210824152720.GC23146@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 24 Aug 2021 16:58:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+HY8o=DPf0Yhbjhu1=_yBwoV7rBL7gK2MJCpezwi7vwQ@mail.gmail.com>
Message-ID: <CAL_Jsq+HY8o=DPf0Yhbjhu1=_yBwoV7rBL7gK2MJCpezwi7vwQ@mail.gmail.com>
Subject: Re: [PATCH v9 2/3] arm64: perf: Enable PMU counter userspace access
 for perf event
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
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
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Aug 06, 2021 at 04:51:22PM -0600, Rob Herring wrote:
> > Arm PMUs can support direct userspace access of counters which allows for
> > low overhead (i.e. no syscall) self-monitoring of tasks. The same feature
> > exists on x86 called 'rdpmc'. Unlike x86, userspace access will only be
> > enabled for thread bound events. This could be extended if needed, but
> > simplifies the implementation and reduces the chances for any
> > information leaks (which the x86 implementation suffers from).
> >
> > When an event is capable of userspace access and has been mmapped, userspace
> > access is enabled when the event is scheduled on a CPU's PMU. There's some
> > additional overhead clearing counters when disabled in order to prevent
> > leaking disabled counter data from other tasks.
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
> >
> > Based on work by Raphael Gault <raphael.gault@arm.com>, but has been
> > completely re-written.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-perf-users@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > ---
> > v9:
> >  - Enabling/disabling of user access is now controlled in .start() and
> >    mmap hooks which are now called on CPUs that the event is on.
> >    Depends on rework of perf core and x86 RDPMC code posted here:
> >    https://lore.kernel.org/lkml/20210728230230.1911468-1-robh@kernel.org/
> >
> > v8:
> >  - Rework user access tracking and enabling to be done on task
> >    context changes using sched_task() hook. This avoids the need for any
> >    IPIs, mm_switch hooks or undef instr handler.
> >  - Only support user access when explicitly requested on open and
> >    only for a thread bound events. This avoids some of the information
> >    leaks x86 has and simplifies the implementation.
> >
> > v7:
> >  - Clear disabled counters when user access is enabled for a task to
> >    avoid leaking other tasks counter data.
> >  - Rework context switch handling utilizing sched_task callback
> >  - Add armv8pmu_event_can_chain() helper
> >  - Rework config1 flags handling structure
> >  - Use ARMV8_IDX_CYCLE_COUNTER_USER define for remapped user cycle
> >    counter index
> >
> > v6:
> >  - Add new attr.config1 rdpmc bit for userspace to hint it wants
> >    userspace access when also requesting 64-bit counters.
> >
> > v5:
> >  - Only set cap_user_rdpmc if event is on current cpu
> >  - Limit enabling/disabling access to CPUs associated with the PMU
> >    (supported_cpus) and with the mm_struct matching current->active_mm.
> >
> > v2:
> >  - Move mapped/unmapped into arm64 code. Fixes arm32.
> >  - Rebase on cap_user_time_short changes
> >
> > Changes from Raphael's v4:
> >   - Drop homogeneous check
> >   - Disable access for chained counters
> >   - Set pmc_width in user page
> > ---
> >  arch/arm64/kernel/perf_event.c | 137 +++++++++++++++++++++++++++++++--
> >  include/linux/perf/arm_pmu.h   |   6 ++
> >  2 files changed, 135 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 74f77b68f5f0..66d8bf62e99c 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -285,6 +285,7 @@ static const struct attribute_group armv8_pmuv3_events_attr_group = {
> >
> >  PMU_FORMAT_ATTR(event, "config:0-15");
> >  PMU_FORMAT_ATTR(long, "config1:0");
> > +PMU_FORMAT_ATTR(rdpmc, "config1:1");
> >
> >  static int sysctl_perf_user_access __read_mostly;
> >
> > @@ -306,9 +307,15 @@ static inline bool armv8pmu_event_is_64bit(struct perf_event *event)
> >       return event->attr.config1 & 0x1;
> >  }
> >
> > +static inline bool armv8pmu_event_want_user_access(struct perf_event *event)
> > +{
> > +     return event->attr.config1 & 0x2;
> > +}
> > +
> >  static struct attribute *armv8_pmuv3_format_attrs[] = {
> >       &format_attr_event.attr,
> >       &format_attr_long.attr,
> > +     &format_attr_rdpmc.attr,
> >       NULL,
> >  };
> >
> > @@ -377,7 +384,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
> >   */
> >  #define      ARMV8_IDX_CYCLE_COUNTER 0
> >  #define      ARMV8_IDX_COUNTER0      1
> > -
> > +#define      ARMV8_IDX_CYCLE_COUNTER_USER    32
> >
> >  /*
> >   * We unconditionally enable ARMv8.5-PMU long event counter support
> > @@ -389,6 +396,15 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
> >       return (cpu_pmu->pmuver >= ID_AA64DFR0_PMUVER_8_5);
> >  }
> >
> > +static inline bool armv8pmu_event_can_chain(struct perf_event *event)
> > +{
> > +     struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> > +
> > +     return !(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT) &&
> > +            armv8pmu_event_is_64bit(event) &&
> > +            !armv8pmu_has_long_event(cpu_pmu);
>
> Could check against ARMV8_IDX_CYCLE_COUNTER here...
>
> > +}
> > +
> >  /*
> >   * We must chain two programmable counters for 64 bit events,
> >   * except when we have allocated the 64bit cycle counter (for CPU
> > @@ -398,11 +414,9 @@ static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
> >  static inline bool armv8pmu_event_is_chained(struct perf_event *event)
> >  {
> >       int idx = event->hw.idx;
> > -     struct arm_pmu *cpu_pmu = to_arm_pmu(event->pmu);
> >
> >       return !WARN_ON(idx < 0) &&
> > -            armv8pmu_event_is_64bit(event) &&
> > -            !armv8pmu_has_long_event(cpu_pmu) &&
> > +            armv8pmu_event_can_chain(event) &&
> >              (idx != ARMV8_IDX_CYCLE_COUNTER);
>
> ... then we wouldn't need to here.

Hum, well armv8pmu_event_can_chain() is supposed to answer is there
any possibility that the event will ever be chained regardless of
whether it's assigned or not. Changing it would mostly work for idx<0,
but it could return the wrong answer if idx ==
ARMV8_IDX_CYCLE_COUNTER. However, that won't happen in the current
code (just as the WARN_ON won't). If we're going to smear the meaning,
then we only need one function here if we get rid of the WARN_ON. We
can call it armv8pmu_event_is_chained_or_might_be_chained() to make it
clear... JK (on the name)

>
> >  }
> >
> > @@ -733,6 +747,35 @@ static inline u32 armv8pmu_getreset_flags(void)
> >       return value;
> >  }
> >
> > +static void armv8pmu_disable_user_access(void)
> > +{
> > +     write_sysreg(0, pmuserenr_el0);
> > +}
> > +
> > +static void armv8pmu_enable_user_access(struct arm_pmu *cpu_pmu)
> > +{
> > +     struct pmu_hw_events *cpuc = this_cpu_ptr(cpu_pmu->hw_events);
> > +
> > +     if (!sysctl_perf_user_access)
> > +             return;
> > +
> > +     if (!bitmap_empty(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS)) {
> > +             int i;
> > +             /* Don't need to clear assigned counters. */
> > +             bitmap_xor(cpuc->dirty_mask, cpuc->dirty_mask, cpuc->used_mask, ARMPMU_MAX_HWEVENTS);
> > +
> > +             for_each_set_bit(i, cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS) {
> > +                     if (i == ARMV8_IDX_CYCLE_COUNTER)
> > +                             write_sysreg(0, pmccntr_el0);
> > +                     else
> > +                             armv8pmu_write_evcntr(i, 0);
> > +             }
>
> Given that we can't expose individual counters, why isn't this just:
>
>         for_each_clear_bit(i, cpuc->used_mask, ARMPMU_MAX_HWEVENTS)
>                 ...
>
> and we could get rid of the dirty_mask altogether? i.e. just zero everything
> that isn't assigned.

Sure. It's just an optimization following what x86 did.

Though we'd want to limit it to num_events, not ARMPMU_MAX_HWEVENTS.
No point in clearing nonexistent counters.

>
> > +             bitmap_zero(cpuc->dirty_mask, ARMPMU_MAX_HWEVENTS);
> > +     }
> > +
> > +     write_sysreg(ARMV8_PMU_USERENR_ER | ARMV8_PMU_USERENR_CR, pmuserenr_el0);
> > +}
> > +
> >  static void armv8pmu_enable_event(struct perf_event *event)
> >  {
> >       /*
> > @@ -776,6 +819,16 @@ static void armv8pmu_disable_event(struct perf_event *event)
> >
> >  static void armv8pmu_start(struct arm_pmu *cpu_pmu)
> >  {
> > +     if (sysctl_perf_user_access) {
>
> armv8pmu_enable_user_access() already checks this.

Yes, because not all callers (event_mapped) check it. I put it here so
we check it first and avoid checking all the subsequent conditions
when the feature is disabled. Though I guess the ordering here is not
guaranteed.

> > +             struct perf_cpu_context *cpuctx = this_cpu_ptr(cpu_pmu->pmu.pmu_cpu_context);
> > +             struct perf_event_context *task_ctx = cpuctx->task_ctx;
> > +             if (atomic_read(&cpuctx->ctx.nr_user) ||
>
> I thought we only enabled this for per-task events, so not sure why we need
> this check. But actually, I don't get why we need any extra logic in this
> function at all; why aren't the ->mapped/->unmapped functions sufficient?

Yes, checking cpuctx->ctx.nr_user can be dropped. I went back and
forth on this as this is now the only thing we have to do to allow per
cpu events. IOW, not supporting per cpu events doesn't simplify things
with this version. The main reason now is one less thing exposed to
user space, and user space reading of per cpu events is somewhat
pointless IMO.

The ->mapped/->unmapped functions are only called when we mmap/munmap
the event. In addition to enabling/disabling access at that point, we
need to enable/disable access every time the event's context is
scheduled on or off the PMU. This is replacing doing it in switch_mm()
which you didn't like. The sched_task() hook didn't work either as it
is not called at the right times. That could be fixed in the core as
that's what I did in v8, but doing it in enable() turns out to be
simpler.

Rob
