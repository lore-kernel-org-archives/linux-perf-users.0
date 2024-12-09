Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D6213D638
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Dec 2024 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733761759; cv=none; b=Jv1b4l0kJZjUuxINkxjDFYmGKtAYVF3hVejHlBiT1DSIoav12hler5rnxFlYn5UPuXYmLxahXPFuwBi9GVXp0QUq809+AN0JwVNVqk7VRovtWmDlqUDhb+42f1KYCJSNnhMcxyHBW4O2PDxbgA9qaOchPZCSs6GGe0vgwtGOjD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733761759; c=relaxed/simple;
	bh=gmjS14hA2s687atteaXweUpy0wHlB7D9vqJ540Uf2LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X14ciePWWvLpWF71XG3upfOkuRt2sE4wd2oYOCZLk2PyEgRxDG61H5srtvREaCEPDMWfYBzPwDghr6pxPjnPODyJI8rw9ybbTyaCOnsk+06oKuDeKwdYhXh+I80M40unI8jA0vPRLGYRYl2UTxY13mVgK4oUm9M8qLJZsrj3+nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uPwXyOSY; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPwXyOSY"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so266575ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Dec 2024 08:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733761757; x=1734366557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvRq5a6zxXos6Rz5YUig1cP5GwRsqaHoYLxf5hiCDuI=;
        b=uPwXyOSY4jrNSJX1kg3dsT4LPLrChLPgnWzRr/EufyMbAwsKoLwMNZh5rhIf98zbXI
         9Ibo5W13D4B49Zd7mbWr7NJePQZBkqZSqj4BRoXRvTs2lPOB9zTUER8NzkeP+VU1MWCv
         abk/DLHKurnDfnUsGn13yBmgE7jUHCDpKJU6QVHZkfvvGdprSpY/euNy1BZMGWmt+qnn
         dRe+JPBgQGkyz0OkKuzAqHCQHrwoG4goxXSu7Gg2hbKLpXu9Rus36cHK2gbuj7EGQ8C9
         txFJogE4ZX9MmYpxyaPiJzu7sCUD74oiW6vAjBEiYjnf5PZpX9c2lmGVBkAgx5rZVgZo
         vbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733761757; x=1734366557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvRq5a6zxXos6Rz5YUig1cP5GwRsqaHoYLxf5hiCDuI=;
        b=qM2ymmRmkVa6vfIRY55jbofk3ALWnYWx6R5CnfDZ8+7yi0L2TQpoh6x583MiiMSVbg
         j3+s1IAR3ojVxgTRIuPUF4ymq3qKNgnCghYbQgGGKbnUszBKj4bTb7c0MiEet7U8U5wF
         tRRpFPQvmBpXibTaOHjUBm0VAh44y4B1rRUHduoSAwoFFFVJ7VZ7UsVQK8Sv+YYeue/8
         CAC1fTscpHAyJUxQPQ5ZA2eI/5JRFXxVJB4qrVDIJlvFxIg/8oxXz0m4i/h57Ox3A3mZ
         FeUQxctTiNfUxUtJTq0jgl0UkTLJrs+alWOvoVc4dG/1JTmiNkWCWhuN9ew9op4U0DEN
         oaMA==
X-Forwarded-Encrypted: i=1; AJvYcCWnigtWktE/XWUjeUGJMmsNTmynGELioOmNIQdneX+AxjRoz0KlzlgHklu30GgNgdWtmGfRIFe5h543b+0pb3uJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYb3L+Um7Bt6Aqp0m0StTvtzk2c/YxAaNIVP0iytreM+TAB6H
	0q8uLiHOA9uYXVrvaMSmTnXgnPDLFRLWPZNYYcJHmGN4BQlGmZwWnGHwr7z1Fv84gXetu4IJ9pQ
	qG3z9/0iO7cNNwBerHJk4LwbVOyxvPTpuBTMhT3Uf4/wXAokkDooJ
X-Gm-Gg: ASbGncvPUYb3lW8MgCjsHtE6GZ+b/cEqGIHKvEdCb7oxDczbnu+v440+4vB5Ef+gynn
	3ZUb6ikKTEmZQ6J64qsdwECEANRo2yU6b
X-Google-Smtp-Source: AGHT+IHeDuQL1h5b5O07aVct9NA0v3r9beK0WOSIOeYJj9olXFQBCTlovvpXe5dqWTemnfZqSWPaxcelhIG9D4It394=
X-Received: by 2002:a05:6e02:32c9:b0:3a0:a459:8eca with SMTP id
 e9e14a558f8ab-3a868519748mr5937415ab.10.1733761756550; Mon, 09 Dec 2024
 08:29:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241207052133.102829-1-irogers@google.com> <20241209085524.GC5430@e132581.arm.com>
In-Reply-To: <20241209085524.GC5430@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 9 Dec 2024 08:29:04 -0800
Message-ID: <CAP-5=fXYQ0ANtpK521jy3vP516+tp42EtKvCJMaK9H1brgB9BA@mail.gmail.com>
Subject: Re: [PATCH v1] perf cpumap: Reduce cpu size from int to int16_t
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kyle Meyer <kyle.meyer@hpe.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 12:55=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi Ian,
>
> On Fri, Dec 06, 2024 at 09:21:33PM -0800, Ian Rogers wrote:
> >
> > Fewer than 32k CPUs are currently supported by perf. A cpumap stores
> > an int per CPU, so its size is 4 times the number of CPUs in the
> > cpumap.
>
> Maybe I have a stupid question.  An int value has 4 bytes, on the other
> hand, we needs 2 bytes to store a 32k value (even 4096 needs 2 bytes
> for storing the value).
>
> How can conclude "its size is 4 times the number of CPUs"?

I'm just trying to say "sizeof(int) =3D=3D 4" and we have as many of them
as we have logical CPUs.

> > We can reduce the size of the int to an int16_t, saving 2
> > bytes per CPU in the map.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
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
> > -       int cpu;
> > +       int16_t cpu;
> >  };
> >
> >  struct perf_cache {
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index 27094211edd8..85e224d8631b 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -427,7 +427,7 @@ static void set_max_cpu_num(void)
> >  {
> >         const char *mnt;
> >         char path[PATH_MAX];
> > -       int ret =3D -1;
> > +       int max, ret =3D -1;
> >
> >         /* set up default */
> >         max_cpu_num.cpu =3D 4096;
> > @@ -444,10 +444,12 @@ static void set_max_cpu_num(void)
> >                 goto out;
> >         }
> >
> > -       ret =3D get_max_num(path, &max_cpu_num.cpu);
> > +       ret =3D get_max_num(path, &max);
> >         if (ret)
> >                 goto out;
> >
> > +       max_cpu_num.cpu =3D max;
> > +
> >         /* get the highest present cpu number for a sparse allocation *=
/
> >         ret =3D snprintf(path, PATH_MAX, "%s/devices/system/cpu/present=
", mnt);
> >         if (ret >=3D PATH_MAX) {
> > @@ -455,8 +457,9 @@ static void set_max_cpu_num(void)
> >                 goto out;
> >         }
> >
> > -       ret =3D get_max_num(path, &max_present_cpu_num.cpu);
> > -
> > +       ret =3D get_max_num(path, &max);
> > +       if (!ret)
> > +               max_present_cpu_num.cpu =3D max;
>
> This is an improvement for max CPU number, but it is irrevelant to
> changing the CPU type to int16_t.  It is better to split it into a new
> patch.

The change is done this way as passing an int16_t* to a function
expecting an int* causes compiler warnings.

> If get an error for max present CPU number, should we rollback to 4096
> for both max_cpu_num and max_present_cpu_num?

We could. It is probably safest to keep the existing behavior.

Thanks,
Ian

> Thanks,
> Leo
>
> >  out:
> >         if (ret)
> >                 pr_err("Failed to read max cpus, using default of %d\n"=
, max_cpu_num.cpu);
> > @@ -606,7 +609,7 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, c=
har *buf, size_t size)
> >  #define COMMA first ? "" : ","
> >
> >         for (i =3D 0; i < perf_cpu_map__nr(map) + 1; i++) {
> > -               struct perf_cpu cpu =3D { .cpu =3D INT_MAX };
> > +               struct perf_cpu cpu =3D { .cpu =3D INT16_MAX };
> >                 bool last =3D i =3D=3D perf_cpu_map__nr(map);
> >
> >                 if (!last)
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index e2843ca2edd9..f1d7d22e7e98 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -531,7 +531,7 @@ int perf_env__numa_node(struct perf_env *env, struc=
t perf_cpu cpu)
> >
> >                 for (i =3D 0; i < env->nr_numa_nodes; i++) {
> >                         nn =3D &env->numa_nodes[i];
> > -                       nr =3D max(nr, perf_cpu_map__max(nn->map).cpu);
> > +                       nr =3D max(nr, (int)perf_cpu_map__max(nn->map).=
cpu);
> >                 }
> >
> >                 nr++;
> > --
> > 2.47.0.338.g60cca15819-goog
> >
