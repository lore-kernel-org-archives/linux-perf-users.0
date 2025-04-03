Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42945223708
	for <linux-perf-users@vger.kernel.org>; Thu,  3 Apr 2025 15:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743695069; cv=none; b=JWZEGK9R5cjch7+RXhWT3mDZYUPByTEvaMc2LuQguYD9UCiU0iCK8IJ0wR0Pbu++UjGT+gaKtzaPJ1DQne8X0RxXPhegTOy7rzL+F01kxBM8YIs0wP4n7NO6kMNGfSg7qyltmBjxLNphNcu6auf8c1DyZgYREtUoBmr6xJEvF9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743695069; c=relaxed/simple;
	bh=Yyd/ed5MMi60QGFdrAdj3VAxV/SgI8NOXxsuylawCw4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jti0pb46Gign0HdzRU3+mWxiEfKNC99GlEex3SF+ykXaFYLfId+0ea9AumGDglgEjoEFM5IyEUrmhDx+IjCD4zKsLCIX6Gs++Ybe9p1kAhhUkore67cvq3OeghocUgAar1J1nOhhJvi6CvM8QZXX8RjSc5UqN7irkzmb4eAiCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e5DmTfts; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e5DmTfts"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2263428c8baso446835ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 03 Apr 2025 08:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743695067; x=1744299867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRSsOtJbLuqCXK/bn2iwJ7kzAyxalKjfc0jwC9PmH0E=;
        b=e5DmTftsY1JPC8l8qk2BdZd7FoC2opFVyXmh2jwBUiO7iHT5DmYjXjdENty6lduDtf
         aNXR7L+2RhuOQCkOEeoN4pfC8IBghm6UjrhLfspJKjRPcWnoIyUe52d1SYG4Xm3jywEB
         breYUWtkVpeAZUEb483xhy0tPUAsTOgpHgWBw7CKxZ0Hiphluq/YaVC+g5xMFCFLgGXy
         yrdf5Ba6hlxVyBF/F4YNTUzZcFA6R8jJNSGFG9TOGxhdqZfQP35i6m61uIz2pid4bADA
         iFyzpyifvMauGuz0+hLE2td2YEtTK54PBtDIXBDdjoxHVngUgN/FDVyD/LWrNkbno/d1
         6DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743695067; x=1744299867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRSsOtJbLuqCXK/bn2iwJ7kzAyxalKjfc0jwC9PmH0E=;
        b=UMUN+4J2dqpWcyf7GuBz2TixZGGxXxTA4uLPK3EaZle55SoXiB7qxYc+2kH1juavne
         xLmzTwBcTPOTVp7tQJ4lJ6IhQa+Xm4sc1pDV9oKTpowtySaF7tIOur7VA8Ix/NnBnVg3
         FzTy5/sT3XEfqfyJgUuVqtfoKEtvrNx9zxKPCABjYcxnuL2DneX5bxruW+GmXdAZ68Bp
         QAFBkhlGgGXsexRw2KLbdMJ4AO6P9pbKCGw536JsZa1yCIWyvS4HzmerL+UW4rcznQn7
         d2p5jLGuByfos7tWdsPnfufXXWBk9ETB/ExzxAdTDb1CIRAkzYK3eqy8sCCSpEWqLbte
         krzw==
X-Forwarded-Encrypted: i=1; AJvYcCWSNerQfHTVOpCF4tos2USVuL6WSzbfe75OxZWzNJOYJA7FlkXzN2MQUlwJVMiBLOm7mMwam/8oLOvvh3bvteJP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3r24qYjLmBLljVSU76hzWgzwTMLpWUi+aaxb1I8czZWcTiHxx
	qsYZpbPTeZFmOvF0DDHyRne3RRZcsd+VGuccLtEMG1JeH6CydA9yOCMKC9o/igX8NGrFNA274l8
	uC+fyCEWKOmeO392AfratwFXThtvVkNLdvUlI
X-Gm-Gg: ASbGnct+z/9Q9pUmpZdvUHv5QnPNHzBgF1jhD8I35aQEvShJrorPgFhWDIWc604FqCU
	T0qzHE4BXSieowMyOtRLARYs4oFsp1YPrFiWbMs8vBKDNowuRIXfdnFFKWqgXkpWit0ANXh5cH+
	xnp9Zk+HrLwEeMYVABgTDLuRBvUAI4e27J5gbW+3QUkfqussEaVonG
X-Google-Smtp-Source: AGHT+IH1OdpqAVIacr6SreqhmQIb5Gyz1kDthHsyWP+8fBn7wfz4hYn2ND1JF//5xT5witqTgGYCFp2tsSYtL9c8LT4=
X-Received: by 2002:a17:902:7288:b0:223:37ec:63be with SMTP id
 d9443c01a7336-22977510221mr2961035ad.4.1743695066631; Thu, 03 Apr 2025
 08:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210183808.130522-1-irogers@google.com> <20250210183808.130522-4-irogers@google.com>
 <0924de97-67ec-4c8a-8c5c-66264bdd2748@linux.intel.com>
In-Reply-To: <0924de97-67ec-4c8a-8c5c-66264bdd2748@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 3 Apr 2025 08:44:15 -0700
X-Gm-Features: AQ5f1JpG2arv6ejbPWf41WWNLCaRuWta19Ou2Q1F6cdO7-CMAV62aBVNOfR_PEo
Message-ID: <CAP-5=fVU1A+faRRCJjNsZuO5-0ifpT1C=846qpL_fjfUgVO1bw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] perf parse-events: Set is_pmu_core for legacy
 hardware events
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Weilin Wang <weilin.wang@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 8:17=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2025-02-10 1:38 p.m., Ian Rogers wrote:
> > Also set the CPU map to all online CPU maps. This is done so the
> > behavior of legacy hardware and hardware cache events better matches
> > that of sysfs and json events during
> > __perf_evlist__propagate_maps. Fix missing cpumap put in "Synthesize
> > attr update" test.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/event_update.c |  1 +
> >  tools/perf/util/parse-events.c  | 37 ++++++++++++++++++++-------------
> >  2 files changed, 24 insertions(+), 14 deletions(-)
> >
> > diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_u=
pdate.c
> > index d6b4ce3ef4ee..9301fde11366 100644
> > --- a/tools/perf/tests/event_update.c
> > +++ b/tools/perf/tests/event_update.c
> > @@ -109,6 +109,7 @@ static int test__event_update(struct test_suite *te=
st __maybe_unused, int subtes
> >       TEST_ASSERT_VAL("failed to synthesize attr update name",
> >                       !perf_event__synthesize_event_update_name(&tmp.to=
ol, evsel, process_event_name));
> >
> > +     perf_cpu_map__put(evsel->core.own_cpus);
> >       evsel->core.own_cpus =3D perf_cpu_map__new("1,2,3");
> >
> >       TEST_ASSERT_VAL("failed to synthesize attr update cpus",
> > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-eve=
nts.c
> > index 6c36b98875bc..8cccf1e22cdf 100644
> > --- a/tools/perf/util/parse-events.c
> > +++ b/tools/perf/util/parse-events.c
> > @@ -231,21 +231,30 @@ __add_event(struct list_head *list, int *idx,
> >           struct perf_cpu_map *cpu_list, u64 alternate_hw_config)
> >  {
> >       struct evsel *evsel;
> > -     struct perf_cpu_map *cpus =3D perf_cpu_map__is_empty(cpu_list) &&=
 pmu ? pmu->cpus : cpu_list;
> > +     bool is_pmu_core;
> > +     struct perf_cpu_map *cpus;
> >
> > -     cpus =3D perf_cpu_map__get(cpus);
> > -     if (pmu)
> > +     if (pmu) {
> > +             is_pmu_core =3D pmu->is_core;
> > +             cpus =3D perf_cpu_map__get(perf_cpu_map__is_empty(cpu_lis=
t) ? pmu->cpus : cpu_list);
> >               perf_pmu__warn_invalid_formats(pmu);
> > -
> > -     if (pmu && (attr->type =3D=3D PERF_TYPE_RAW || attr->type >=3D PE=
RF_TYPE_MAX)) {
> > -             perf_pmu__warn_invalid_config(pmu, attr->config, name,
> > -                                           PERF_PMU_FORMAT_VALUE_CONFI=
G, "config");
> > -             perf_pmu__warn_invalid_config(pmu, attr->config1, name,
> > -                                           PERF_PMU_FORMAT_VALUE_CONFI=
G1, "config1");
> > -             perf_pmu__warn_invalid_config(pmu, attr->config2, name,
> > -                                           PERF_PMU_FORMAT_VALUE_CONFI=
G2, "config2");
> > -             perf_pmu__warn_invalid_config(pmu, attr->config3, name,
> > -                                           PERF_PMU_FORMAT_VALUE_CONFI=
G3, "config3");
> > +             if (attr->type =3D=3D PERF_TYPE_RAW || attr->type >=3D PE=
RF_TYPE_MAX) {
> > +                     perf_pmu__warn_invalid_config(pmu, attr->config, =
name,
> > +                                             PERF_PMU_FORMAT_VALUE_CON=
FIG, "config");
> > +                     perf_pmu__warn_invalid_config(pmu, attr->config1,=
 name,
> > +                                             PERF_PMU_FORMAT_VALUE_CON=
FIG1, "config1");
> > +                     perf_pmu__warn_invalid_config(pmu, attr->config2,=
 name,
> > +                                             PERF_PMU_FORMAT_VALUE_CON=
FIG2, "config2");
> > +                     perf_pmu__warn_invalid_config(pmu, attr->config3,=
 name,
> > +                                             PERF_PMU_FORMAT_VALUE_CON=
FIG3, "config3");
> > +             }
> > +     } else {
> > +             is_pmu_core =3D (attr->type =3D=3D PERF_TYPE_HARDWARE ||
> > +                            attr->type =3D=3D PERF_TYPE_HW_CACHE);
> > +             if (perf_cpu_map__is_empty(cpu_list))
> > +                     cpus =3D is_pmu_core ? perf_cpu_map__new_online_c=
pus() : NULL;
>
> All online CPUs? Is there a problem for hybrid?

For hybrid if you do cpu_atom/cycles/ then the PMU is found by
perf_pmus__find here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n1651

The wildcard case (e.g. perf stat -e cycles ...) scans all the PMUs
passing the respective pmu into __add_event:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/parse-events.c?h=3Dperf-tools-next#n1382

For non-hybrid the PMU is given by perf_pmus__find_by_type which only
returns a PMU if there is an exact match on the type, ie it won't
return perf_pmus__find_core_pmu  when asked to lookup the PMU for a
legacy type, evsel__find_pmu will do this though.

Anyway, the assumption in this legacy configuration no PMU case is
that the event is heading to all CPUs, which is true for software and
tracepoint. For hybrid we could get into this kind of problem is sysfs
isn't mounted, but I think we're pretty generally broken in that case
anyway.

Fwiw, I'm carrying these changes in google's tree and test it on my
hybrid desktop:
https://github.com/googleprodkernel/linux-perf

Thanks,
Ian

> Thanks,
> Kan> +          else
> > +                     cpus =3D perf_cpu_map__get(cpu_list);
> >       }
> >       if (init_attr)
> >               event_attr_init(attr);
> > @@ -260,7 +269,7 @@ __add_event(struct list_head *list, int *idx,
> >       evsel->core.cpus =3D cpus;
> >       evsel->core.own_cpus =3D perf_cpu_map__get(cpus);
> >       evsel->core.requires_cpu =3D pmu ? pmu->is_uncore : false;
> > -     evsel->core.is_pmu_core =3D pmu ? pmu->is_core : false;
> > +     evsel->core.is_pmu_core =3D is_pmu_core;
> >       evsel->auto_merge_stats =3D auto_merge_stats;
> >       evsel->pmu =3D pmu;
> >       evsel->alternate_hw_config =3D alternate_hw_config;
>
