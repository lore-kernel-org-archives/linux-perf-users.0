Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F5C4C77B6E
	for <linux-perf-users@archiver.kernel.org>; Wed, 12 Apr 2023 16:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDLQIL (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 12 Apr 2023 12:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjDLQIK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 12 Apr 2023 12:08:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5686193
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 09:08:08 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso67165e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Apr 2023 09:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681315687; x=1683907687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sa4yFzdjjGn2e/RiqU7MEomskuYncePCa62ILKKhyN4=;
        b=0aC9r5Ny+bXegjtt2nq2rKJq19avcWEYNXuXZeXF4qPtU9NJKBdHTV9eRiPGjCyM8Y
         Z2XmfADbl9xpQ5KklX3LEHOhmkWYCi1sMtbjT9yrvQaL5Z6DxvIXgD5sZn9wpnxONzCy
         38+eIYBNuk6eTEv+H9ud/87yHq93v3bVFXIhpVB8a8AGbSq52DF7R9SvUUJymnU9RDXm
         4yxRvq63JD5owr7cq8M7Mypyz4g/nmkbMzZvK4/41X1/1FMoXe4SIfc4BgHwGt9q2Hbo
         0XPxvh1yfpR2aR+2wttDtc4exzz71Bwmk7wB+3Wh/8zm2nBE4GvO8roQ1YwuDkeMIGhN
         QBGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681315687; x=1683907687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sa4yFzdjjGn2e/RiqU7MEomskuYncePCa62ILKKhyN4=;
        b=zlwPfX1cYX5RU8IXxhg4usDWrNJ4DaH/iBjHY8lE8uFPTKaiBPJr2f/IeyBlaIf+f/
         4EHaeQukyMTZLu13OMxJW79HLMzHiOMp73jH3/tGPNBfYvjbYfuvMvp0CGgA+1g7O8Ir
         9xB6UerRGZIyNhs3yvdS7LzoPYOsvD/e4tDN2V989X0/MVZRLIYD5Fsy6oX36Kfu4STs
         O5J0J1HqesVfGXfVSbSyIZt9XgDEioj7p62mCATlwT1VB53+fXWB2LwEaqMztn7nZW4l
         mt5fttrpr39wUHU8jvpRh/aSw3+LdCHlb6KnK0uw+KxRk075pZENyL0cE2rQlWvFoi2h
         OO+g==
X-Gm-Message-State: AAQBX9fpWijq+Yx3Yb+L3joPFw72Rtb2+oaJgWJPoJu8VvGalL7EUSKf
        yN7Fxg3/zDjwt1xja+pRh7sn/8I5hwevipw4SyuICg==
X-Google-Smtp-Source: AKy350ajky0Kgbx4L6sIKdzh6xkLxgXezsfTh937gjXR8+ul3I3cjCb0NjvpUIgDmDx+Z/GdvCoBkrGtoHAj2QGgygo=
X-Received: by 2002:a05:600c:3550:b0:3f0:9e0e:e429 with SMTP id
 i16-20020a05600c355000b003f09e0ee429mr171331wmq.4.1681315687284; Wed, 12 Apr
 2023 09:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230407230405.2931830-1-irogers@google.com> <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org> <ZDbTLbjtJ8mVET8N@kernel.org>
In-Reply-To: <ZDbTLbjtJ8mVET8N@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Apr 2023 09:07:54 -0700
Message-ID: <CAP-5=fXxtdqPEdZDacRRrubQ2+rA4MiGGzGeDLQ2TYvWFsZpDA@mail.gmail.com>
Subject: Re: [PATCH v7 2/5] perf cpumap: Add reference count checking
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, Apr 12, 2023 at 8:50=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Tue, Apr 11, 2023 at 03:19:06PM -0300, Arnaldo Carvalho de Melo escrev=
eu:
> > Em Fri, Apr 07, 2023 at 04:04:02PM -0700, Ian Rogers escreveu:
> > > This change is intended to catch:
> > >  - use after put: using a cpumap after you have put it will cause a
> > >    segv.
> > >  - unbalanced puts: two puts for a get will result in a double free
> > >    that can be captured and reported by tools like address sanitizer,
> > >    including with the associated stack traces of allocation and frees=
.
> > >  - missing puts: if a put is missing then the get turns into a memory
> > >    leak that can be reported by leak sanitizer, including the stack
> > >    trace at the point the get occurs.
>
> > I think this should be further split into self contained patches as it
> > does:
>
> > These are missing convertions that should be in a separate patch, no?
> >
> > > @@ -239,7 +236,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const stru=
ct perf_cpu_map *cpus,
> > >  {
> > >       int idx;
> > >       struct perf_cpu cpu;
> > > -     struct cpu_aggr_map *c =3D cpu_aggr_map__empty_new(cpus->nr);
> > > +     struct cpu_aggr_map *c =3D cpu_aggr_map__empty_new(perf_cpu_map=
__nr(cpus));
> > >
> > >       if (!c)
> > >               return NULL;
>
> Extracted this from your larger patch:
>
> From f8a23fce48400168be0cc078a0b0bd0e7d4a889f Mon Sep 17 00:00:00 2001
> From: Ian Rogers <irogers@google.com>
> Date: Wed, 12 Apr 2023 12:45:45 -0300
> Subject: [PATCH 1/1] perf cpumap: Use perf_cpu_map__nr(cpus) to access
>  cpus->nr
>
> So that we can have a single point where to refcount check 'struct perf_c=
pu_map'
> instances for use after free, etc.

Thanks! In one of your previous messages you mentioned adding some
setters for cpu_map to bury the macro usage. As cpu maps are
immutable, can we make these internal APIs? Other than that, thanks
for helping to get this landed!

Ian

> Signed-off-by: Ian Rogers <irogers@google.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> Cc: Dmitriy Vyukov <dvyukov@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Riccardo Mancini <rickyman7@gmail.com>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
> Link: https://lore.kernel.org/lkml/
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/cpumap.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 5e564974fba4ffab..c8484b75413ef709 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -239,7 +239,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct p=
erf_cpu_map *cpus,
>  {
>         int idx;
>         struct perf_cpu cpu;
> -       struct cpu_aggr_map *c =3D cpu_aggr_map__empty_new(cpus->nr);
> +       struct cpu_aggr_map *c =3D cpu_aggr_map__empty_new(perf_cpu_map__=
nr(cpus));
>
>         if (!c)
>                 return NULL;
> @@ -263,7 +263,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct p=
erf_cpu_map *cpus,
>                 }
>         }
>         /* Trim. */
> -       if (c->nr !=3D cpus->nr) {
> +       if (c->nr !=3D perf_cpu_map__nr(cpus)) {
>                 struct cpu_aggr_map *trimmed_c =3D
>                         realloc(c,
>                                 sizeof(struct cpu_aggr_map) + sizeof(stru=
ct aggr_cpu_id) * c->nr);
> @@ -582,9 +582,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, cha=
r *buf, size_t size)
>
>  #define COMMA first ? "" : ","
>
> -       for (i =3D 0; i < map->nr + 1; i++) {
> +       for (i =3D 0; i < perf_cpu_map__nr(map) + 1; i++) {
>                 struct perf_cpu cpu =3D { .cpu =3D INT_MAX };
> -               bool last =3D i =3D=3D map->nr;
> +               bool last =3D i =3D=3D perf_cpu_map__nr(map);
>
>                 if (!last)
>                         cpu =3D map->map[i];
> @@ -633,7 +633,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map=
, char *buf, size_t size)
>         int i, cpu;
>         char *ptr =3D buf;
>         unsigned char *bitmap;
> -       struct perf_cpu last_cpu =3D perf_cpu_map__cpu(map, map->nr - 1);
> +       struct perf_cpu last_cpu =3D perf_cpu_map__cpu(map, perf_cpu_map_=
_nr(map) - 1);
>
>         if (buf =3D=3D NULL)
>                 return 0;
> @@ -644,7 +644,7 @@ size_t cpu_map__snprint_mask(struct perf_cpu_map *map=
, char *buf, size_t size)
>                 return 0;
>         }
>
> -       for (i =3D 0; i < map->nr; i++) {
> +       for (i =3D 0; i < perf_cpu_map__nr(map); i++) {
>                 cpu =3D perf_cpu_map__cpu(map, i).cpu;
>                 bitmap[cpu / 8] |=3D 1 << (cpu % 8);
>         }
> --
> 2.39.2
>
