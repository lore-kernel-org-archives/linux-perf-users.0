Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155FC001DF
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 15:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHAPy3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 11:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjHAPy2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 11:54:28 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553FCDC
        for <linux-perf-users@vger.kernel.org>; Tue,  1 Aug 2023 08:54:27 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so312501cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 01 Aug 2023 08:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690905266; x=1691510066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ednkhSFjqhneBIgGorXK+e4JTFLBif6NnYVr4qRSWqo=;
        b=K/nxQJJ7NrDCh0owo2uR5R2TZToXKipEn/noXY5MSDLDTZ01+8q1ZXqk3p1DQadQrV
         shtC9/uGBnZlU3tPLagrQo83HocoFB31YI28c20JXeH5NHUwYsebc3Y7ut3UkIGZyjQt
         Gpu/7QpdLfNEvsAdkOdh6TiRjUK62Jdagt6auqQArKIzwYjlbTele8rzU/7Vdg+XFoPm
         UEhMbxHd4iWubYhfk94uC1zmS/nJ+Ko+6AjFy7UdPSpMNNf02aspwnqC2JyQ/w8+H+M3
         W+VznIWpEJx6rWTo9v/TLEu8YiYNTfoWJ5ll5U7n76GnShRC+kfrjUYyGP9ewycLIGtP
         I0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690905266; x=1691510066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ednkhSFjqhneBIgGorXK+e4JTFLBif6NnYVr4qRSWqo=;
        b=FA8ZFI2ceDJOIhTvnf9osRu/7KgLAcfUOC6DbLl+T8GmyyLaQh/4uynG500Rb8QbDp
         Bwcm8Xs5CBwhptbIfZP5qiwoSwEzvhEjcZScCjbNPSivp8q3l+LxG0yHwvphdT+Vrstc
         GPTbg1vszGhntMGahoysANs5T0Y7Y2+OxFfxvG1wJKAzXL9IHQz23gt6O70NywEQndJH
         VeFCmZLohBk6dNWdjAR5NWU4d/FBJgnmTUPXot1TQXe2XWZ1oCIBIV9zuT0jgJcMQOiw
         kjyg4ktx9WyRwA7n9NktMmhw2Lwakf5UyAKL0+24O9GXxmVNR7WtRlM4jkApQUqBCXgX
         FvWA==
X-Gm-Message-State: ABy/qLb13NobU3beuqpUYoSOtRufVpIEUFuy10LP2dFRSCSoIBpOuj6f
        eTh5ko+J8ISDPzWhldjCk8Qjfj2VcloHZu4dSwZyqQ==
X-Google-Smtp-Source: APBJJlHg9mAAfHng4uHV1rIy3BBSPNZElzLssUj9kg/Vm+JaAoqdVvaByIgASgA3mJXM+z+EBPEwIkZUbQFjXpwSNec=
X-Received: by 2002:ac8:5954:0:b0:3de:1aaa:42f5 with SMTP id
 20-20020ac85954000000b003de1aaa42f5mr832900qtz.15.1690905266362; Tue, 01 Aug
 2023 08:54:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com> <20230801053634.1142634-2-irogers@google.com>
 <faca2b35-fdd6-7394-edea-32dd59d3a16f@linux.intel.com>
In-Reply-To: <faca2b35-fdd6-7394-edea-32dd59d3a16f@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 1 Aug 2023 08:54:14 -0700
Message-ID: <CAP-5=fU+KJCwxtS7RkBNqnECSrO4dqVeH9NHRP1oA7W6L3Rx4g@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] perf parse-events x86: Avoid sorting uops_retired.slots
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Aug 1, 2023 at 8:40=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2023-08-01 1:36 a.m., Ian Rogers wrote:
> > As topdown.slots may appear as slots it may get confused with
> > uops_retired.slots which is an invalid perf metric event group
> > leader. Special case uops_retired.slots to avoid this confusion.
> >
>
> Does any name with format "name.slots" cause the confusion? If so, I
> don't think we can stop others from naming like the above format.
>
> Is it better to hard code the topdown.slots/slots, rather than
> uops_retired.slots?

So firstly, yet more fringe perf metric event benefits with this silly
bit of complexity. The issue with "just" trying to pattern match
"topdown.slots" and "slots" is that there may be pmu names in there.
So (ignoring case) we get:

slots
topdown.slots
cpu/slots/
cpu/topdown.slots/
cpu_core/slots/
cpu_core/topdown.slots/

but the name can have other junk like modifiers in there and also
there's the name=3D config term, but let's just not think about that
breaking stuff. To avoid 6 searches I searched for the known
problematic uops_retired.slots, knowing if that's not there then one
of the 6 above is the match. Searching for just "slots" or
"topdown.slots" isn't good enough as "slots" will get a hit in
"uops_retired.slots", how we ended up with this patch in the 1st
place. So I ended up using the uops_retired.slots search to reduce
complexity in the code and to avoid writing an event parser just to
figure out what the name is... Ideally we'd be using the
perf_event_attr to do this comparison, but immediately after
parse-events when this code runs it hasn't been computed yet. Maybe I
can shuffle things around and make this true. Ideally I think
parse-events would just be a library that given some event description
gives back perf_event_attr and not evsels, but that's yet further
work...

Thanks,
Ian

>
> Thanks,
> Kan
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/x86/util/evlist.c | 7 ++++---
> >  tools/perf/arch/x86/util/evsel.c  | 7 +++----
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/ut=
il/evlist.c
> > index cbd582182932..b1ce0c52d88d 100644
> > --- a/tools/perf/arch/x86/util/evlist.c
> > +++ b/tools/perf/arch/x86/util/evlist.c
> > @@ -75,11 +75,12 @@ int arch_evlist__add_default_attrs(struct evlist *e=
vlist,
> >
> >  int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
> >  {
> > -     if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics=
(lhs)) {
> > +     if (topdown_sys_has_perf_metrics() &&
> > +         (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_=
group(rhs))) {
> >               /* Ensure the topdown slots comes first. */
> > -             if (strcasestr(lhs->name, "slots"))
> > +             if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->na=
me, "uops_retired.slots"))
> >                       return -1;
> > -             if (strcasestr(rhs->name, "slots"))
> > +             if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->na=
me, "uops_retired.slots"))
> >                       return 1;
> >               /* Followed by topdown events. */
> >               if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->=
name, "topdown"))
> > diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/uti=
l/evsel.c
> > index 81d22657922a..090d0f371891 100644
> > --- a/tools/perf/arch/x86/util/evsel.c
> > +++ b/tools/perf/arch/x86/util/evsel.c
> > @@ -40,12 +40,11 @@ bool evsel__sys_has_perf_metrics(const struct evsel=
 *evsel)
> >
> >  bool arch_evsel__must_be_in_group(const struct evsel *evsel)
> >  {
> > -     if (!evsel__sys_has_perf_metrics(evsel))
> > +     if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
> > +         strcasestr(evsel->name, "uops_retired.slots"))
> >               return false;
> >
> > -     return evsel->name &&
> > -             (strcasestr(evsel->name, "slots") ||
> > -              strcasestr(evsel->name, "topdown"));
> > +     return strcasestr(evsel->name, "topdown") || strcasestr(evsel->na=
me, "slots");
> >  }
> >
> >  int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
