Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F32C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  7 Dec 2021 08:49:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbhLGIwa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 03:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhLGIwa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 03:52:30 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD3C061748
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 00:49:00 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id z18so16161877iof.5
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 00:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EwLAaq+CdYhTs6k2hGnNMtqsNVHBqeUIpo47LKyaTcA=;
        b=PV8MJZ36qERysBQhRg+IknDWj9Jj3NPsUDIBWw+pVDFlly9g41r39/KfzlPT7/LzUA
         +PGvpIS3SLZsCqVKE7JZvLfyktVL//8VBvLO1ioL+CdIqyjkjIw+SobjsTUTjv1er0wL
         PMIQaAatVTfkSmAmWj5D6jkYAKDnRA9U/53S80bje0mCFlevdxE+Cf8eFEf9JXy3n6fU
         eXxQmnWe6lodyTe6tUv50lA0JA5ULOXYOg9AvoGv7LBsK+mzc6JlB2dRwIoGgSg0JiQF
         8KQkAHGw/SatidPSuMJYfvF8aNiEyXNAECHaFUnCWNM+0AT5y3ty8IYmZq5BD1SEgd1H
         +zGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EwLAaq+CdYhTs6k2hGnNMtqsNVHBqeUIpo47LKyaTcA=;
        b=bnHr0jHgqHJXSTKRmUC88g4qyq6p6ZeJHE20krKLrqgCwxaEBWzzE9o2OyeOk1Ify+
         m5NDjp+vjU9DemlCs5GQd5G4IqlCBLcm6+B4Eja/wfjNHnh85N/vq0I9Wvhx1vrjSyaP
         SbG2OPhWUtrmquJb9RIZoc/rc8QpOlOMF4Ao6smEGhIvJ+ZUEaJ0PFwEEN63hUbH/dC8
         H9b6ogjZafjnuMx/lk5ja23X/LyneXYjPXMVtfuCXCTiLmSVPetETsYyGpATwtKB8C6W
         aIAa66/kQjbTejFRb8yWCqvC5KFXrMfxYTWK0sSJCkMOAuEM2smhYPuLd/G0EeZ7JJ5u
         hPFw==
X-Gm-Message-State: AOAM532XPVo5M+HKpIJPbSf62W/INCt6He2NK/Kig4hbgko1xMm+umpL
        zZyfuFH+O77gPkjpBkXiIFuOnuIW1gfsnYFOgSoyew==
X-Google-Smtp-Source: ABdhPJw+AVvYPwABXQWnTrKGl9scUly5Mng238k6iF0YZeDTkJRUQf/paaamDr7pTfWpcRdbq36A/Hpht3H8Irg5ws8=
X-Received: by 2002:a05:6638:144f:: with SMTP id l15mr48256794jad.21.1638866939332;
 Tue, 07 Dec 2021 00:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20211204023409.969668-1-irogers@google.com> <52237d2a-2be2-cb93-e29d-ac6eea82a2f9@arm.com>
 <CAP-5=fVn-uKs+_647D+O6r=n9N98iK=Z3U53WYkPm9NxMEz3gg@mail.gmail.com>
In-Reply-To: <CAP-5=fVn-uKs+_647D+O6r=n9N98iK=Z3U53WYkPm9NxMEz3gg@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 7 Dec 2021 00:48:47 -0800
Message-ID: <CAP-5=fXrJU1s_W9o5XXWk2-ch+mynq8VyN2e1kd_AZ2AZ5R=vQ@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix per socket shadow aggregation
To:     James Clark <james.clark@arm.com>
Cc:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>, eranian@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Dec 6, 2021 at 2:16 PM Ian Rogers <irogers@google.com> wrote:
>
> On Mon, Dec 6, 2021 at 2:44 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 04/12/2021 02:34, Ian Rogers wrote:
> > > An uncore device may have a CPU mask that specifies one CPU per socket:
> > > $ cat /sys/devices/uncore_imc_0/cpumask
> > > 0,18
> > > The perf_stat_config aggr_map will map a CPU to the socket and other
> > > aggregation values for it. Fix an error where the index into CPU mask
> > > was being used as the index into the aggr_map. For the cpumask above the
> > > indexes 0 and 1 are passed to aggr_map rather than the CPUs 0 and 18.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/stat-display.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 588601000f3f..7cfad5cfec38 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -516,7 +516,7 @@ static void printout(struct perf_stat_config *config, struct aggr_cpu_id id, int
> > >  static void aggr_update_shadow(struct perf_stat_config *config,
> > >                              struct evlist *evlist)
> > >  {
> > > -     int cpu, s;
> > > +     int idx, cpu, s;
> > >       struct aggr_cpu_id s2, id;
> > >       u64 val;
> > >       struct evsel *counter;
> > > @@ -525,11 +525,12 @@ static void aggr_update_shadow(struct perf_stat_config *config,
> > >               id = config->aggr_map->map[s];
> > >               evlist__for_each_entry(evlist, counter) {
> > >                       val = 0;
> > > -                     for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
> > > +                     for (idx = 0; idx < evsel__nr_cpus(counter); idx++) {
> > > +                             cpu = perf_cpu_map__cpu(evsel__cpus(counter), idx);
> > >                               s2 = config->aggr_get_id(config, evlist->core.cpus, cpu);
> >
> > Hi Ian,
> >
> > This same pattern of looping over the CPUs and calling aggr_get_id() is used a couple of
> > other times. For example in aggr_cb() and first_shadow_cpu(). Do you think these also
> > need updating?
>
> Thanks for the feedback James!
>
> For first_shadow_cpu the index is translated to the the cpu via the
> cpu map here:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n343
> so I think it is sound.
>
> aggr_cb looks to have the same bug as the index is being passed as the cpu:
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/util/stat-display.c?h=perf/core#n643
>
> > Or could we fix it in the aggr_get_id() functions so that they expect an index instead
> > of CPU ID and do the conversion themselves? The callbacks do say "idx" rather than "cpu"
> > so maybe there is still come confusion.
> >
> > For example:
> >
> >         perf_stat__get_die_cached(struct perf_stat_config *config,
> >                                         struct perf_cpu_map *map, int idx)
>
> Agreed on the naming confusion. I'm a fan of using single element
> structs to get type safety in code like this. I wonder here if a
> for_each_cpu on perf_cpu_map would clean this up best. I'll play with
> a v2 patch set that addresses this problem more widely.

So the real issue is the cpu map for the evlist (populated with all
CPUs) is being indexed from values from the uncore counter's cpu mask
in aggr_update_shadow. Given the easy confusion of index and cpu, I'm
pushing to eliminate the passing of the map and index in v2.

Thanks,
Ian

> Thanks,
> Ian
>
> > >                               if (!cpu_map__compare_aggr_cpu_id(s2, id))
> > >                                       continue;
> > > -                             val += perf_counts(counter->counts, cpu, 0)->val;
> > > +                             val += perf_counts(counter->counts, idx, 0)->val;
> > >                       }
> > >                       perf_stat__update_shadow_stats(counter, val,
> > >                                       first_shadow_cpu(config, counter, id),
> > >
