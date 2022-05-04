Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E9C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  4 May 2022 13:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351061AbiEDOC5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 4 May 2022 10:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350862AbiEDOCx (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 4 May 2022 10:02:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7B24133F
        for <linux-perf-users@vger.kernel.org>; Wed,  4 May 2022 06:59:16 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id p189so918251wmp.3
        for <linux-perf-users@vger.kernel.org>; Wed, 04 May 2022 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFqD13h4DdEbrcwcMZezbebSSUTg4ODI3AEZjhdBnJo=;
        b=C3gJIISQGKpGwD5Uo4+zbm+rTWry5xThpDoIGPNlp5cbWX32T1RNUtN1amj3QDVh1B
         TCXS2oZJxLVDuAKZdB7JPd+jsuqFUraet3XEvALiNc3PUzb37XfAI/8F5Jc5TG7sTVkc
         lhZI5ESvf6mMWgoj9jtkABu0WCdcNgFZrbfuvryasULrHZGkiI+nqgLa8SoaBm8Zyyzs
         eu8ttQotSzZ+olfMRwXlzEcQIoo8h1e76N8Co88HyBPpa/FKHEOE8Pce0+4CRMxQR2qw
         9GSKy/bthfIHmvKrVPPcsN4L3VnYYKpMZSFYvSXKU2L5/Mdihghe8ByyPIVsWJ4gldla
         atSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFqD13h4DdEbrcwcMZezbebSSUTg4ODI3AEZjhdBnJo=;
        b=4d04xr0LxMvm1UNy8/hUl+bhVVwr7k4h5Bj0KsItuZEmpeqvvRHmWJs1AbN5GsZpS3
         CjuF/nkUiu2+PaL4ZB8kdUIMvNHUJ6nj4uvbq8V8InlpZVdSAOeRLg4ivslCBEndInyi
         oyPFkio8lkzyKMrFA/BAJ/vDF6ksVHPLA0YLbOUyVrq0b/Nj5qQ0MSz3ht6EcXNBcLxC
         NBq/zjBTj7O7G1DlUjyWkUbvEaQeATkOBSE4W/T73XHmGOw6FJM/GurKUeGdVzPC5EJa
         SFuFD/fRTVzNa8umznk1SWFhv2sMdV73zdA/vpA07d4kuxNz1tgm5WXRAPUeO67osIGR
         vIHA==
X-Gm-Message-State: AOAM531/Pe/IrxL56B6v/DX0WUW6F7gsWacDcNxpCcDtwVTH0dboKz+l
        KwrJxYr1Kruw+BBVSc/9/w46DFueD37x23foUC7POw==
X-Google-Smtp-Source: ABdhPJyl78M9m8Ok2I2KXHYCTWh5Tm0JqrbFxuW8XjLXJ+r+TmWyE1aOYBRGGrp5HAGImVd4KosxmdZIs3IshZNQqsY=
X-Received: by 2002:a1c:a301:0:b0:392:9bc5:203c with SMTP id
 m1-20020a1ca301000000b003929bc5203cmr7762038wme.67.1651672755125; Wed, 04 May
 2022 06:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com> <20220503041757.2365696-5-irogers@google.com>
 <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com> <CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com>
 <1e13c738-3460-ef7f-8b4b-5169e16b0b06@intel.com>
In-Reply-To: <1e13c738-3460-ef7f-8b4b-5169e16b0b06@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 4 May 2022 06:59:01 -0700
Message-ID: <CAP-5=fWEdLV6Jf5q=MSQyVSL0Q3-KxSvCWgXGjhexezx9AJAdA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, May 4, 2022 at 5:54 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/05/22 17:03, Ian Rogers wrote:
> > On Tue, May 3, 2022 at 12:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >>
> >> On 3/05/22 07:17, Ian Rogers wrote:
> >>> perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
> >>> respect that.
> >>
> >> As I wrote before, I am not keen on this because it prevents -1, as a
> >> valid 3rd parameter to perf_event_open(), from being represented
> >> in merged evsel cpu maps.
> >>
> >> Why do you want this?
> >
> > Thanks Adrian, could you give me a test case (command line) where the
> > differing dummy and empty behavior matters?
>
> perf record --per-thread -e intel_pt// uname
>
> With patchset "perf intel-pt: Better support for perf record --cpu"
> the above will have (assuming 8-CPUs):
>         user_requested_cpus = {-1}
>         intel_pt evsel->cpus = {-1}
>         text_poke dummy evsel->cpus = {0-7}
> which when merged would result in:
>         before this patch: all_cpus = {-1-7}
>         after this patch:  all_cpus = {0-7}
>
> The absence of -1 will mean that the intel_pt event does not get
> mmapped.

Thanks, so what's the right fix? To make this work we should:
 - remove language of dummy being a singular cpu_map
 - change perf_cpu_map__empty to be something like
perf_cpu_map__empty_or_just_dummy
 - change cpu_map__is_dummy to be something llike cpu_map__singular_dummy
 - add tests on cpu map code for things like the evlist affiinity
iterator as I'm not clear what will happen when it encounters a -1 CPU
Note, I'm proposing changing function names rather than implementation
behavior, as we don't have enough tests to give me confidence that
changing the existing behavior wouldn't break something. For example,
--per-thread mode was recently broken:
https://lore.kernel.org/lkml/e1ce0d93-88cc-af79-e67e-d3c79d166ca6@gmail.com/
Do we also need to fix up parse events for software events (e.g.
faults) where the cpu map is empty but really should be dummy? This
will likely need a propagate fix as during the parsing propagation
user_requested_cpus is empty and we want to keep dummy cpu maps, not
overwrite them with empty.

I see a fair amount of clean up here, which isn't bad. My assumed
alternative was that the intel_pt code could look for dummy cpu maps
on the evsels, but then why have dummy cpu maps at all and just use
empty throughout the code base? We could also add a flag to the evlist
to say whether any evsel cpu maps contain a dummy/empty map. API wise
I'm tempted to say that the dummy CPU map should be removed and empty
just used in its place (less is more, keep it simple).

Something that would help with clarity, I think, would be to land the fix in:
https://lore.kernel.org/lkml/20220503041757.2365696-3-irogers@google.com/
as currently all_cpus contains cpus not in the evsel cpu maps, but are
residue from when the evsels were parsed.

Thanks,
Ian

> >                                             Normally cpus/own_cpus are
> > set to null during parsing. They may get replaced with
> > user_requested_cpus:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n44
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n45
> > (should it be on line 45 that !empty is expected?)
> >
> > During merge the null/empty all_cpus drops this value, which doesn't
> > matter as the behavior with empty is the same as dummy:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evsel.c?h=perf/core#n119
> >
> > What's concerning me is the definition of empty:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
> > ```
> > return map ? map->map[0].cpu == -1 : true;
> > ```
> > If the first entry can be -1 and there can be other CPUs merged after
> > then that cpu map will be empty by the definition above. Perhaps it
> > should be:
> > ```
> > return map ? (map->nr == 1 && map->map[0].cpu == -1) : true;
> > ```
> > but it seems you prefer:
> > ```
> > return (map == NULL) ? true : false;
> > ```
> >
> > You'd asked what the behavior with a dummy is and clearly it is
> > somewhat muddy. That is what this patch and unit test is trying to
> > clean up.
> >
> > Thanks,
> > Ian
> >
> >>>
> >>> Signed-off-by: Ian Rogers <irogers@google.com>
> >>> ---
> >>>  tools/lib/perf/cpumap.c   |  4 ++--
> >>>  tools/perf/tests/cpumap.c | 10 +++++++++-
> >>>  2 files changed, 11 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> >>> index 384d5e076ee4..9c83675788c2 100644
> >>> --- a/tools/lib/perf/cpumap.c
> >>> +++ b/tools/lib/perf/cpumap.c
> >>> @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
> >>>  /** Is 'b' a subset of 'a'. */
> >>>  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
> >>>  {
> >>> -     if (a == b || !b)
> >>> +     if (a == b || perf_cpu_map__empty(b))
> >>>               return true;
> >>> -     if (!a || b->nr > a->nr)
> >>> +     if (perf_cpu_map__empty(a) || b->nr > a->nr)
> >>>               return false;
> >>>
> >>>       for (int i = 0, j = 0; i < a->nr; i++) {
> >>> diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> >>> index f94929ebb54b..d52b58395385 100644
> >>> --- a/tools/perf/tests/cpumap.c
> >>> +++ b/tools/perf/tests/cpumap.c
> >>> @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
> >>>       struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
> >>>       struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> >>>       struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
> >>> +     struct perf_cpu_map *d = perf_cpu_map__dummy_new();
> >>> +     struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
> >>>       char buf[100];
> >>>
> >>>       TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
> >>>       cpu_map__snprint(c, buf, sizeof(buf));
> >>>       TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> >>> -     perf_cpu_map__put(b);
> >>> +
> >>> +     TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
> >>> +     cpu_map__snprint(e, buf, sizeof(buf));
> >>> +     TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
> >>> +
> >>>       perf_cpu_map__put(c);
> >>> +     perf_cpu_map__put(d);
> >>> +     perf_cpu_map__put(e);
> >>>       return 0;
> >>>  }
> >>>
> >>
>
