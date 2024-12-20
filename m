Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E36221E0AD
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 18:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734719583; cv=none; b=nkub0YK2db0EfKBiVGTgUrKewEXwv8+Jy8wvvTBsUXHHxoHUOIG+HrHTfQ4vk5SpO05uPDtP2XSQ3yviUHvQXCoTVyz9z4FzXE56oVLykbZ04ZAGRNZGrR/j9y5eUOtA7IUknQOp8iSuK0pxfLFNmTGGBjRWGIoukTUPHgrwmpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734719583; c=relaxed/simple;
	bh=Grm62tos6i3FigCupBk/L6wgZFjSLA6xTIJ7CQ0Q2ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1yBcp8WMNiXeZWNOir0d9GLNXoymEAsoyrIH8U9NQu50s+bk4EKoF+lGRCzLdD27t+PaK1Aj1UmtUvAhoraHFm53xF0TGY7kNMvvgP+GJv/9JDF6dRbOP6IsLPpz9OS2QOm0OZdGhpzsKSWO64KbMi6efzzxGOUAw43NC1I07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xtT2/6kM; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xtT2/6kM"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so195165ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 10:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734719580; x=1735324380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oy2aVGNmg/aK4TAflgpkY8BpDlTK3XTRivYTghB1Otc=;
        b=xtT2/6kM9+f4s+YbrZPQ7YToUgxzRs/7tI6RUVC5IpvfLcEt7V6/QUBC8jmTorXa/Z
         lx4b+EF+QsEzYUYgmSkX+/cW63jd4ZktWixLhzwmLRY22bqDaPfgm51DFDwVNhWcOqI+
         8Gso5AEMk7xOTH6hXhL0G1AU1Gz9rKZ+B8+0F6buMlV15NeZWEA09NN/LdShKJ620PW8
         Bo/0S/3KBo3WvpCU68Bnw0K2SUF6thRyVK5z569nt0HCSf5rcXYidEJBhDDSHFRwr0St
         WGSxCVxvt5wgblpQVsRz0hhklS9Ec9i9GLivjvUNl0ETJypPYo+1GemCjN0IRHGnozOD
         igBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734719580; x=1735324380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oy2aVGNmg/aK4TAflgpkY8BpDlTK3XTRivYTghB1Otc=;
        b=EKpJ4XWm8jOUJ7y+98XX5n4soQqW43muSxEKU6eRKeDIK1obhxe4hu2edd7YuCwV9Z
         0XW/TNU5Vo9qjX0BcW2nB2ckwMQo4EnNzF+8hH4gZndWb0ciNGwOipE1eSz4kPmdGI2C
         r5/Ae8Cu5H6ZoFUIgXP4ONGjSN7fuH1AdZqihqMj9/M1YbGsSRLQQBggn3QAG2DnB3Ww
         pi71Hb6SCJvFy3lY227/e88St9baDFHo7VE8Q+TnVI1z4h957XtJ6QN7UOSDQ5NRpRjA
         JqEtM72wJQEOwoLnkwW005LilFmU5S3QqfQlzUJYnITYvoQhzHTvKmVJMBndA8zscKMn
         xk3g==
X-Forwarded-Encrypted: i=1; AJvYcCVfFGGhHkyFRGE805v6hBacKuSZzsIq9AXhiS5n456xtlKJwDs32LuqH4tzwv1qP790lRBCdPz4WebYjC6TO+rQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzjRz+htxAtdOrXM9oLUrbrdsUoXy6is+OKt3+fRLZJ9CJUBTJf
	noRaV8uAMpBqrf3RSPnMwRva0CioBSDXaCJxaS66VPQ5+CGlb6q6tmp7pQSPzNbkBcjSIQ+t0un
	0ynpZ9vMm7RaOv4BOnxXNkxjEMA5zOTAH/Hd0
X-Gm-Gg: ASbGnctHNnHy4Pn3cBScnzcPioQczEikclelr7nVC4MsXJxrDCZkiWMbO795iCqvThZ
	sON7yPOinaj3Ug6J2Ai45jLxS1zzGbEk/tsYxwSc=
X-Google-Smtp-Source: AGHT+IE1bvC3oYEFkVFrjaF1C0lsTaVab9ObGSew/WLCHOCten4Gxxr9bF0aYFBnhaR3107vlNXmIZdty3882m9hopA=
X-Received: by 2002:a92:d7c2:0:b0:3a7:c721:57e2 with SMTP id
 e9e14a558f8ab-3c3324f33cemr2793205ab.21.1734719580457; Fri, 20 Dec 2024
 10:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207052133.102829-1-irogers@google.com> <86ed629f736bcad8ffcb636182442b541b2f8daa.camel@linux.intel.com>
In-Reply-To: <86ed629f736bcad8ffcb636182442b541b2f8daa.camel@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Dec 2024 10:32:49 -0800
Message-ID: <CAP-5=fVw3h8Nud2EjZwE15g7gd7Rh1h+O-CfsUaEjhYa77v8CQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf cpumap: Reduce cpu size from int to int16_t
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Leo Yan <leo.yan@arm.com>, 
	Kyle Meyer <kyle.meyer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 10:16=E2=80=AFAM Tim Chen <tim.c.chen@linux.intel.co=
m> wrote:
>
> On Fri, 2024-12-06 at 21:21 -0800, Ian Rogers wrote:
> > Fewer than 32k CPUs are currently supported by perf.
> >
> Minor suggestions for the commit log. Perhaps it is clearer to say
>
> Perf does not support more than 32k CPUs.
>
> > A cpumap stores
> > an int per CPU, so its size is 4 times the number of CPUs in the
> > cpumap.
> >
> Perf cpumap currently uses a 4 byte int to index CPU, where
> a 2 byte int is sufficient to cover the CPU range needed.
>
> Otherwise
>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

Thanks for the review. The commit message tweak you provide is
confusing. A cpumap doesn't use an int, a cpumap has an array of
perf_cpus that are ints, these are the things being sized reduced
here. The index into a cpumap is regularly used as a way of densely
encoding accesses into things like counters into uncore PMUs, so an
index is a distinct thing from a CPU and a cpumap. I'll see what I can
do to the commit message given both your and Leo's feedback but what
was originally written was the most technically accurate so it'll end
up likely rhyming with it.

Thanks,
Ian

> Tim
> > We can reduce the size of the int to an int16_t, saving 2
> > bytes per CPU in the map.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > This change is on top of:
> > https://lore.kernel.org/lkml/20241206044035.1062032-1-irogers@google.co=
m/
> > ---
> >  tools/lib/perf/include/perf/cpumap.h |  3 ++-
> >  tools/perf/util/cpumap.c             | 13 ++++++++-----
> >  tools/perf/util/env.c                |  2 +-
> >  3 files changed, 11 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/incl=
ude/perf/cpumap.h
> > index cbb65e55fc67..760a9aae9884 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -4,10 +4,11 @@
> >
> >  #include <perf/core.h>
> >  #include <stdbool.h>
> > +#include <stdint.h>
> >
> >  /** A wrapper around a CPU to avoid confusion with the perf_cpu_map's =
map's indices. */
> >  struct perf_cpu {
> > -     int cpu;
> > +     int16_t cpu;
> >  };
> >
> >  struct perf_cache {
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 27094211edd8..85e224d8631b 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
> >  {
> >       const char *mnt;
> >       char path[PATH_MAX];
> > -     int ret =3D -1;
> > +     int max, ret =3D -1;
> >
> >       /* set up default */
> >       max_cpu_num.cpu =3D 4096;
> > @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
> >               goto out;
> >       }
> >
> > -     ret =3D get_max_num(path, &max_cpu_num.cpu);
> > +     ret =3D get_max_num(path, &max);
> >       if (ret)
> >               goto out;
> >
> > +     max_cpu_num.cpu =3D max;
> > +
> >       /* get the highest present cpu number for a sparse allocation */
> >       ret =3D snprintf(path, PATH_MAX, "%s/devices/system/cpu/present",=
 mnt);
> >       if (ret >=3D PATH_MAX) {
> > @@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
> >               goto out;
> >       }
> >
> > -     ret =3D get_max_num(path, &max_present_cpu_num.cpu);
> > -
> > +     ret =3D get_max_num(path, &max);
> > +     if (!ret)
> > +             max_present_cpu_num.cpu =3D max;
> >  out:
> >       if (ret)
> >               pr_err("Failed to read max cpus, using default of %d\n", =
max_cpu_num.cpu);
> > @@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, c=
har *buf, size_t size)
> >  #define COMMA first ? "" : ","
> >
> >       for (i =3D 0; i < perf_cpu_map__nr(map) + 1; i++) {
> > -             struct perf_cpu cpu =3D { .cpu =3D INT_MAX };
> > +             struct perf_cpu cpu =3D { .cpu =3D INT16_MAX };
> >               bool last =3D i =3D=3D perf_cpu_map__nr(map);
> >
> >               if (!last)
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index e2843ca2edd9..f1d7d22e7e98 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -531,7 +531,7 @@ int perf_env__numa_node(struct perf_env *env, struc=
t perf_cpu cpu)
> >
> >               for (i =3D 0; i < env->nr_numa_nodes; i++) {
> >                       nn =3D &env->numa_nodes[i];
> > -                     nr =3D max(nr, perf_cpu_map__max(nn->map).cpu);
> > +                     nr =3D max(nr, (int)perf_cpu_map__max(nn->map).cp=
u);
> >               }
> >
> >               nr++;
>
