Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C599C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 28 Mar 2022 21:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiC1V1h (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 28 Mar 2022 17:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiC1V1h (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 28 Mar 2022 17:27:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7719139849
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 14:25:46 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so323830wme.2
        for <linux-perf-users@vger.kernel.org>; Mon, 28 Mar 2022 14:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1G+GATea/gEtUw/pWJqQ7Ixi4GCktSB1NgpSqf6SUpc=;
        b=ff3pbwSNU4OAWweoWrN7aL23MQscP4KSYMsHZHsOC017RgC7WbeViHy1tfJAFmN/lQ
         qFp8xCMw3u+dl/WdgmtmFbZqfFMl58je1HZUNky8io5xTnbaPRkXQ0p9+/bqFsnrV13e
         87CnLMXfFAyqOPugLMqgnQXA6f0hv+SOIMNb34gnrh6Uz6AI78Fkp4AuyeHzB0d6uLcG
         24glXp8ngdRF5tzOTnN1VkSFOoL4g8eAO23bcA6Az6CbvyuOLOjBzyYj9FiQnp3FzjIy
         Oa0ziPsOihA8dfCKzeX/IHsSZgFu39XCtQjS47BWtppn9IvP/uTn5PoEVWvC2O2FdHiy
         1q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1G+GATea/gEtUw/pWJqQ7Ixi4GCktSB1NgpSqf6SUpc=;
        b=lzoCso1a7arcrXeAcCq2jHF5gZnKds/Xpkm5k8SBZfHJjXdFg1Bs5i00cP4cfAr7qw
         IOtsLXxDh0hIqDNA588D6piUibCuMbpEETNKqOmIw0Fprf9C/qFRgD6iYjL34QvaC+PD
         ujawx/WPPrxEplKnowNMw5knY95bHX3gF4wHHpebobiOMmVQGBZGXBucOAmTOWCS9gyy
         jg2bQ+WneRKEW89ebFSjbb/t3duRaJS/axXmgiA62vjRTs5Tw/AOg7cvtask6E97odk9
         mT+JunIDdwrrofEj4aT6kmVq2YdPLauVVIkoZauCn289MTN18omxiqEVW9whwq477AHS
         34Jg==
X-Gm-Message-State: AOAM531nF7LmdzPxDjfyf2D0xDfqh0SVjtypxDUAFAyM/Y07iWfcprsa
        k5bdeJ/Wco0mNBXPFwq3hlSkUnbW3lXZQpTpK8YKNQ==
X-Google-Smtp-Source: ABdhPJxqDLS9Je1WTyYK6Q9CxOUbLtpYQHy7lZgCBXI5DykbKcNLXZhVSdUAPUvSuW//+FNsHKaW+O1uZ4s6yxxHfHY=
X-Received: by 2002:a05:600c:2905:b0:381:67e2:3992 with SMTP id
 i5-20020a05600c290500b0038167e23992mr1686003wmd.182.1648502734235; Mon, 28
 Mar 2022 14:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220328062414.1893550-1-irogers@google.com> <20220328062414.1893550-4-irogers@google.com>
 <YkIaYq2alnNUiIfr@kernel.org> <CAP-5=fVfYtu=wcfUQEzwuJMhxexi3d8hVqF5QFLkj_FWPHLK5Q@mail.gmail.com>
 <CE94B4BA-5073-4332-A13E-2CD20379AA19@gmail.com>
In-Reply-To: <CE94B4BA-5073-4332-A13E-2CD20379AA19@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 28 Mar 2022 14:25:21 -0700
Message-ID: <CAP-5=fV+DiB=_+R+g+FLgLOyY5q205OGjfsaZntVKFy4jM4rcg@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf cpumap: Add intersect function.
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, Mar 28, 2022 at 2:00 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
>
>
> On March 28, 2022 5:54:06 PM GMT-03:00, Ian Rogers <irogers@google.com> wrote:
> >On Mon, Mar 28, 2022 at 1:28 PM Arnaldo Carvalho de Melo
> ><acme@kernel.org> wrote:
> >>
> >> Em Sun, Mar 27, 2022 at 11:24:12PM -0700, Ian Rogers escreveu:
> >> > The merge function gives the union of two cpu maps. Add an intersect
> >> > function which will be used in the next change.
> >> >
> >> > Signed-off-by: Ian Rogers <irogers@google.com>
> >> > ---
> >> >  tools/lib/perf/cpumap.c              | 38 ++++++++++++++++++++++++++++
> >> >  tools/lib/perf/include/perf/cpumap.h |  2 ++
> >> >  2 files changed, 40 insertions(+)
> >> >
> >> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> >> > index 953bc50b0e41..56b4d213039f 100644
> >> > --- a/tools/lib/perf/cpumap.c
> >> > +++ b/tools/lib/perf/cpumap.c
> >> > @@ -393,3 +393,41 @@ struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >> >       perf_cpu_map__put(orig);
> >> >       return merged;
> >> >  }
> >> > +
> >> > +struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
> >> > +                                          struct perf_cpu_map *other)
> >> > +{
> >> > +     struct perf_cpu *tmp_cpus;
> >> > +     int tmp_len;
> >> > +     int i, j, k;
> >> > +     struct perf_cpu_map *merged = NULL;
> >> > +
> >> > +     if (perf_cpu_map__is_subset(other, orig))
> >> > +             return orig;
> >> > +     if (perf_cpu_map__is_subset(orig, other)) {
> >> > +             perf_cpu_map__put(orig);
> >>
> >> Why this put(orig)?
> >
> >As with merge, if orig isn't returned then it is put.
>
> For merge I can see it dropping a reference, i.e. get b and merge it into a, after that b was "consumed"
>
> But for intersect?

The current use case is the intersect of all online CPUs with the
merge of all CPU maps from evsels. So we can generally just reuse
all_cpus, or the common case of both maps contain every CPU. I think
the pattern makes code like:

evlist->cpus = perf_cpu_map__intersect(evlist->cpus, other);

not quite as messy, as without the put you need:

tmp = perf_cpu_map__intersect(evlist->cpus, other);
perf_cpu_map__put(evlist->cpus);
evlist->cpus = tmp;

I'm somewhat agnostic on what the API should be, but it'd be nice if
merge and intersect behaved in a similar way.

Thanks,
Ian

> >
> >> > +             return perf_cpu_map__get(other);
> >>
> >> And why the get here and not on the first if?
> >
> >The first argument orig is either put or returned while the second may
> >be returned only if the reference count is incremented. We could
> >change the API for merge and intersect to put both arguments, or to
> >not put either argument.
> >
> >Thanks,
> >Ian
> >
> >> > +     }
> >> > +
> >> > +     tmp_len = max(orig->nr, other->nr);
> >> > +     tmp_cpus = malloc(tmp_len * sizeof(struct perf_cpu));
> >> > +     if (!tmp_cpus)
> >> > +             return NULL;
> >> > +
> >> > +     i = j = k = 0;
> >> > +     while (i < orig->nr && j < other->nr) {
> >> > +             if (orig->map[i].cpu < other->map[j].cpu)
> >> > +                     i++;
> >> > +             else if (orig->map[i].cpu > other->map[j].cpu)
> >> > +                     j++;
> >> > +             else {
> >> > +                     j++;
> >> > +                     tmp_cpus[k++] = orig->map[i++];
> >> > +             }
> >> > +     }
> >> > +     if (k)
> >> > +             merged = cpu_map__trim_new(k, tmp_cpus);
> >> > +     free(tmp_cpus);
> >> > +     perf_cpu_map__put(orig);
> >> > +     return merged;
> >> > +}
> >> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
> >> > index 4a2edbdb5e2b..a2a7216c0b78 100644
> >> > --- a/tools/lib/perf/include/perf/cpumap.h
> >> > +++ b/tools/lib/perf/include/perf/cpumap.h
> >> > @@ -19,6 +19,8 @@ LIBPERF_API struct perf_cpu_map *perf_cpu_map__read(FILE *file);
> >> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__get(struct perf_cpu_map *map);
> >> >  LIBPERF_API struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> >> >                                                    struct perf_cpu_map *other);
> >> > +LIBPERF_API struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig,
> >> > +                                                      struct perf_cpu_map *other);
> >> >  LIBPERF_API void perf_cpu_map__put(struct perf_cpu_map *map);
> >> >  LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx);
> >> >  LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> >> > --
> >> > 2.35.1.1021.g381101b075-goog
> >>
> >> --
> >>
> >> - Arnaldo
