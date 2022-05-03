Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD7C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 14:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbiECOH3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbiECOHT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 10:07:19 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88551EAD3
        for <linux-perf-users@vger.kernel.org>; Tue,  3 May 2022 07:03:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e24so23492520wrc.9
        for <linux-perf-users@vger.kernel.org>; Tue, 03 May 2022 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4yiLw/VEdaYl/NlOASUjlFdrhZcltSNhm4gz6dSd34k=;
        b=kCtauluC6RPbNDvBY/JRShpAYoymIwgUaaCYj9BWRXXiDuSIf815m2lptCT+0twyJN
         X4OB7viRH2mwmEUlxrFWYCtI9+2svNvzxoIR3GJPkMGlaeyd1pssEWQ2N//CeWRcYzvA
         0JBUfSyzB7M6zvr8T+fT6HLcpFP1uJ4hL92VDWdFWZzB623LS1Uqvn3mXeH5MhvrDaDG
         5cPmHZUfOd8THiO3Re830/MRm8rHK1nY9fEGJiq7uw4JN7EXPGRuN8jQBitKt/YDjzAU
         ZwcIXfUnN7qeNVhXUSKi3QdJJc7JWbobyEF9Te24ClW2Ok8MDJW+1Daa+WBHTIByn3xS
         QVeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4yiLw/VEdaYl/NlOASUjlFdrhZcltSNhm4gz6dSd34k=;
        b=ILD2trEvRld8LdFpxALlQ9fH1lqkGA5NpppZFPf01nKCwg+0VBKgytXlSLKVlXpFET
         /fTKWRsq5IRBOZTZ7sk46QBN5D8naiUH0oWdeksqJSO2y2fAwGPNesraedilZlCHceZo
         xnaBR+rfCCYDNj7SToYVkV5pH53r0dQMQXJ/LKo94+ViqYG6txhguh76EI6JtSM9o++1
         RHujnTk59AXR7Fveg4eIYziWmiWFtVD+7PYp0NX8IfeNpzeZ+N9j0KbweCa1zNyjr4x/
         6XOtqEXQGs2kPy50YGWOEFcHReVmuLOG+lFfCJveyAHb95yPEl1LNyjuaCRgpHAf6YMk
         3zdw==
X-Gm-Message-State: AOAM532eeY8iB5sFPjvnHW4Btjw+yi11IK6WAUtplOQ0JFQGL9FC5FzD
        k8kMLFF6u5IadgXd14GNfIWlBeMhmLmx+S29+DwrOQ==
X-Google-Smtp-Source: ABdhPJxIIXls0cRITSkASA+TT9aqYlg/XlcuvPUcKW+mcEfUrgFZ/oTWBOFcSD7nbqFc8D8kKLu+Cze+GzwbCbeog/c=
X-Received: by 2002:adf:f30a:0:b0:20a:e193:6836 with SMTP id
 i10-20020adff30a000000b0020ae1936836mr13028706wro.654.1651586623927; Tue, 03
 May 2022 07:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com> <20220503041757.2365696-5-irogers@google.com>
 <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
In-Reply-To: <b94f3863-c690-e0f7-5cde-18fbf24143e5@intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 3 May 2022 07:03:31 -0700
Message-ID: <CAP-5=fWfs2td9nZLGdEBD+C5s=upa_7SORab8tQ7qH=jX--F7w@mail.gmail.com>
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

On Tue, May 3, 2022 at 12:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 3/05/22 07:17, Ian Rogers wrote:
> > perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
> > respect that.
>
> As I wrote before, I am not keen on this because it prevents -1, as a
> valid 3rd parameter to perf_event_open(), from being represented
> in merged evsel cpu maps.
>
> Why do you want this?

Thanks Adrian, could you give me a test case (command line) where the
differing dummy and empty behavior matters? Normally cpus/own_cpus are
set to null during parsing. They may get replaced with
user_requested_cpus:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n44
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evlist.c?h=perf/core#n45
(should it be on line 45 that !empty is expected?)

During merge the null/empty all_cpus drops this value, which doesn't
matter as the behavior with empty is the same as dummy:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/evsel.c?h=perf/core#n119

What's concerning me is the definition of empty:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/lib/perf/cpumap.c?h=perf/core#n279
```
return map ? map->map[0].cpu == -1 : true;
```
If the first entry can be -1 and there can be other CPUs merged after
then that cpu map will be empty by the definition above. Perhaps it
should be:
```
return map ? (map->nr == 1 && map->map[0].cpu == -1) : true;
```
but it seems you prefer:
```
return (map == NULL) ? true : false;
```

You'd asked what the behavior with a dummy is and clearly it is
somewhat muddy. That is what this patch and unit test is trying to
clean up.

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c   |  4 ++--
> >  tools/perf/tests/cpumap.c | 10 +++++++++-
> >  2 files changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 384d5e076ee4..9c83675788c2 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
> >  /** Is 'b' a subset of 'a'. */
> >  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
> >  {
> > -     if (a == b || !b)
> > +     if (a == b || perf_cpu_map__empty(b))
> >               return true;
> > -     if (!a || b->nr > a->nr)
> > +     if (perf_cpu_map__empty(a) || b->nr > a->nr)
> >               return false;
> >
> >       for (int i = 0, j = 0; i < a->nr; i++) {
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index f94929ebb54b..d52b58395385 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
> >       struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
> >       struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
> >       struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
> > +     struct perf_cpu_map *d = perf_cpu_map__dummy_new();
> > +     struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
> >       char buf[100];
> >
> >       TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
> >       cpu_map__snprint(c, buf, sizeof(buf));
> >       TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
> > -     perf_cpu_map__put(b);
> > +
> > +     TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
> > +     cpu_map__snprint(e, buf, sizeof(buf));
> > +     TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
> > +
> >       perf_cpu_map__put(c);
> > +     perf_cpu_map__put(d);
> > +     perf_cpu_map__put(e);
> >       return 0;
> >  }
> >
>
