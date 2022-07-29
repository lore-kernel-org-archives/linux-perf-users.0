Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C968C19F2A
	for <linux-perf-users@archiver.kernel.org>; Fri, 29 Jul 2022 17:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiG2R1i (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiG2R1h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 29 Jul 2022 13:27:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33744C637
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 10:27:35 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id h205-20020a1c21d6000000b003a34ac64bdfso1348716wmh.1
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p70W5DALEOG9SLhFgBtYzTJ5yCtC0YN1DUXpXgjKl8g=;
        b=AxMmTRCGvclAqvg60X4DSM4OgPj2VsXe1SIEWzECo9CRSmt9JjBvBPjetBjHChjQN8
         QuwV2BnDmH+jOjvK7zYYALdT0SVhDEJMHFX/4puIM1YA1SCTyZUOEDuFyv/bSItrw1Pk
         9VFGl1EGmVqa7skyLeKgwZCojYWtAm/ze+8h57UPtdctosvAroe5TefjMJqf9kPDFdDs
         SNKffuwfsn7GMsmMhOj6IhJ0t8gAd7bUfg86/l/ZLKdmBp4fACPjgh+U0RZzF7Z2cq8J
         cS8B907Qv+p7o01wm4bYaCp6MpQyaY1B4PWPs02YDwcDmDIZl7+/w2VJO2t7TgRNaNE6
         5rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p70W5DALEOG9SLhFgBtYzTJ5yCtC0YN1DUXpXgjKl8g=;
        b=a98/zx/OyqTIMsC1O6R5SvV1HcVVI+76OWmdSeNk76GALmKPpPs3D7Zi877fwoPGtH
         YTTkeuNhb+LcFxXJcw3CVmn/V/V/hi+MMMNPInqnLTVfDTrvAqqcTUWoerl7JjgeJ2O7
         SOFT/ilqKok4VpJtq07lr2Q5X60ikmbobHjYWECQk5K/skqZu/qGGRksQ8CiHtKGBUml
         ZioqrxE5PTbAocWNatHpMt/MsUSGune5dt8Z69GOHEZbRDViUWbREJg8AdSregKOZ52L
         6BIpL6t2Zacf2XcYcFPHL34868g0SO229cq0ytqZI2sDFvJgf6GNTGlZ1cZS0cQnr2/X
         rNeQ==
X-Gm-Message-State: AJIora/HMCQeUVR6fCBbryU7cE1SaU4NlOuf9hU2GWFIa42xI1umVeao
        5XWu2pk7uKfhFc6o59TvbNhWBJDmTUlKEnFePKPDWA==
X-Google-Smtp-Source: AGRyM1voLcR9SmYxVNNgUCcyd3Kdi6OPTUqqPDb2VqySb84vBHRv58HZ+n6YiwE9syedRYkNfL9ME0K3+UoYKfC4ZlI=
X-Received: by 2002:a05:600c:2854:b0:3a3:1551:d7d with SMTP id
 r20-20020a05600c285400b003a315510d7dmr3076822wmb.174.1659115654150; Fri, 29
 Jul 2022 10:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220729074351.138260-1-irogers@google.com> <d8356ddc-56e7-7324-5330-ff2bd54bcba4@huawei.com>
In-Reply-To: <d8356ddc-56e7-7324-5330-ff2bd54bcba4@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 10:27:21 -0700
Message-ID: <CAP-5=fV0CMpBGkNOBMRjbdZfdw1mQjrDhLVG38jLtpsdWXtQ_Q@mail.gmail.com>
Subject: Re: [PATCH v3 00/17] Compress the pmu_event tables
To:     John Garry <john.garry@huawei.com>
Cc:     Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, Jul 29, 2022 at 8:03 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/07/2022 08:43, Ian Rogers wrote:
> > jevents.py creates a number of large arrays from the json events. The
> > arrays contain pointers to strings that need relocating. The
> > relocations have file size, run time and memory costs. These changes
> > refactor the pmu_events API so that the storage of the pmu_event
> > struct isn't exposed. The format is then changed to an offset within a
> > combined big string, with adjacent pmu_event struct variables being
> > next to each other in the string separated by \0 - meaning only the
> > first variable of the struct needs its offset recording.
> >
> > Some related fixes are contained with the patches. The architecture
> > jevents.py creates tables for can now be set by the JEVENTS_ARCH make
> > variable, with a new 'all' that generates the events and metrics for
> > all architectures.
>
> Hi Ian,
>
> I am going through this series currently.
>
> But I just wanted to mention my idea again on how to compress the
> tables. Maybe you thought that there was no value in my idea or didn't
> get it, but I'll mention it again just in case...
>
> Background:
> There is much duplication in events between cores. And currently we have
> something like this:
>
> pmu-events/pmu-events.c:
> struct pmu_event core0[] {
> {
>         .name = event0,
>         .event = "event=0x0",
> },
> {
>         .name = event1,
>         .event = "event=0x1",
> },
> {
>         .name = event2,
>         .event = "event=0x2",
>         .desc = "event2 common desc",
> },
> ...
> };
>
> struct pmu_event core1[] {
> {
>         .name = event0,
>         .event = "event=0x0",
> },
> {
>         .name = event1,
>         .event = "event=0x1",
> },
> {
>         .name = event2,
>         .event = "event=0x2",
>         .desc = "event2 desc for core1",
> },
> ...
> };
>
>
> struct pmu_evenets_map map[] = {
> {
>         .cpuid = "0000",
>         .table = core0,
> },
> {
>         .cpuid = "0001",
>         .table = core1,
> },
> ...
> };
>
> If you check broadwell and broadwellde frontent.json you will notice
> that they are identical, which is an extreme example of duplication.
>
> Proposal for change:
> Make each event in the per-core pmu event table point to common event.
> Each common event is unique, and each event per-core will point to a
> common event. So if 2x cores have same event but small difference, then
> there would be still 2x common events.
>
> pmu-events/pmu-events.c:
> struct pmu_event common_events[] {
> {
>         .name = event0,
>         .event = "event=0x0",
> },
> {
>         .name = event1,
>         .event = "event=0x1",
> },
> {
>         .name = event2,
>         .event = "event=0x2",
>         .desc = "event2 common desc",
> },
> {
>         .name = event2,
>         .event = "event=0x2",
>         .desc = "event2 desc for core1",
> },
> ...
> };
>
> struct pmu_event_ptr {
>         struct pmu_event *pmu_event;
> }
>
> struct pmu_event_ptr core0[] {
> {
>         .pmu_event = &common_events[0],
> },
> {
>         .pmu_event = &common_events[1],
> },
> {
>         .pmu_event = &common_events[2],
> },
> ...
> };
>
> struct pmu_event_ptr core0[] {
> {
>         .pmu_event = &common_events[0],
> },
> {
>         .pmu_event = &common_events[1],
> },
> {
>         .pmu_event = &common_events[3],
> },
> ...
> };
>
> struct pmu_evenets_map map[] = {
> {
>         .cpuid = "0000",
>         .table = core0,
> },
> {
>         .cpuid = "0001",
>         .table = core1,
> },
> ...
> };
>
> For x86, first step in JSON parsing would be to go through the JSON
> files and compile a list of unique events. Then second step is to
> process each per-core JSON to create the pmu events table, using the
> common events. Using a per common event hash would make the lookup quicker.
>
> I'm not sure what you think. From figures below you seem to be saving
> ~20% at best - I would guess (with a capital G) that my method could
> save a lot more.
>
> This implementation would require core pmu.c to be changed, but there is
> ways that this could be done without needing to change core pmu.c
>
> Thanks,
> John

Thanks John!

You are right about broadwell, it is an extreme case of sharing. IIRC
BDX is the server core/uncore events, BDW is the consumer core/uncore
and BDW-DE is consumer core with server uncore - so the sharing is
inherent in this. Metrics become interesting as they may mix core and
uncore, but I'll ignore that here.

In the old code every event needs 15 char*s, with 64-bit that is 15*8
bytes per entry with 741 core and 23 uncore entries for BDW, and 372
core and 1284 uncore for BDX. I expect the strings themselves will be
shared by the C compiler, and so I just focus on the pointer sizes.
With the new code every event is just 1 32-bit int. So for BDW we go
from 15*8*(741+23)=91,680 to 4*(741+23)=3056, BDX is
15*8*(372+1284)=198720 to 4*(372+1284)=6624. This means we've gone
from 290,400bytes to 9,680bytes for BDW and BDX. BDW-DE goes from
243,000bytes to 8,100bytes - we can ignore the costs of the strings as
they should be fully shared, especially for BDW-DE.

If we added some kind of table sharing, so BDW-DE was core from BDW
and uncore from BDX and the tables shared, then in the old code you
could save nearly 0.25MB but with the new code the saving is only
around 8KB. I think we can go after that 8KB but it is less urgent
after this change which gets 96% of the benefit. We have 72
architectures for jevents at the moment and so I'd ball park (assuming
they all saved as much as BDW-DE) the max saving as about 0.5MB, which
is 12% of what is saved here.

Longer term I'd like to make the pmu-events.c logic look closer to the
sysfs API. Perhaps we can unify the uncore events for BDX and BDW-DE
with some notion of a common PMU, or PMUs with common events and
tables, and automate deduction of this. It also isn't clear to me the
advantage of storing the metrics inside the events, separate tables
feel cleaner. Anyway, there's lots of follow up.

Thanks,
Ian


> >
> > An example of the improvement to the file size on x86 is:
> > no jevents - the same 19,788,464bytes
> > x86 jevents - ~16.7% file size saving 23,744,288bytes vs 28,502,632bytes
> > all jevents - ~19.5% file size saving 24,469,056bytes vs 30,379,920bytes
> > default build options plus NO_LIBBFD=1.
> >
> > I originally suggested fixing this problem in:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fVB8G4bdb9T=FncRTh9oBVKCS=+=eowAO+YSgAhab+Dtg@mail.gmail.com/
> >
> > v3. Fix an ARM build issue with a missed weak symbol. Perform some
> >      pytype clean up.
> > v2. Split the substring folding optimization to its own patch and
> >      comment tweaks as suggested by Namhyung Kim
> >      <namhyung@kernel.org>. Recompute the file size savings with the
> >      latest json events and metrics.
> >
> > Ian Rogers (17):
> >    perf jevents: Clean up pytype warnings
> >    perf jevents: Simplify generation of C-string
> >    perf jevents: Add JEVENTS_ARCH make option
> >    perf jevent: Add an 'all' architecture argument
> >    perf jevents: Remove the type/version variables
> >    perf jevents: Provide path to json file on error
> >    perf jevents: Sort json files entries
> >    perf pmu-events: Hide pmu_sys_event_tables
> >    perf pmu-events: Avoid passing pmu_events_map
> >    perf pmu-events: Hide pmu_events_map
> >    perf test: Use full metric resolution
> >    perf pmu-events: Move test events/metrics to json
> >    perf pmu-events: Don't assume pmu_event is an array
> >    perf pmu-events: Hide the pmu_events
> >    perf metrics: Copy entire pmu_event in find metric
> >    perf jevents: Compress the pmu_events_table
> >    perf jevents: Fold strings optimization
> >
> >   tools/perf/arch/arm64/util/pmu.c              |   4 +-
> >   tools/perf/pmu-events/Build                   |   6 +-
> >   .../arch/test/test_soc/cpu/metrics.json       |  64 +++
> >   tools/perf/pmu-events/empty-pmu-events.c      | 204 +++++++-
> >   tools/perf/pmu-events/jevents.py              | 495 ++++++++++++++----
> >   tools/perf/pmu-events/pmu-events.h            |  40 +-
> >   tools/perf/tests/expand-cgroup.c              |  25 +-
> >   tools/perf/tests/parse-metric.c               |  77 +--
> >   tools/perf/tests/pmu-events.c                 | 466 +++++++----------
> >   tools/perf/util/metricgroup.c                 | 275 ++++++----
> >   tools/perf/util/metricgroup.h                 |   5 +-
> >   tools/perf/util/pmu.c                         | 139 ++---
> >   tools/perf/util/pmu.h                         |   8 +-
> >   tools/perf/util/s390-sample-raw.c             |  50 +-
> >   14 files changed, 1140 insertions(+), 718 deletions(-)
> >   create mode 100644 tools/perf/pmu-events/arch/test/test_soc/cpu/metrics.json
> >
>
