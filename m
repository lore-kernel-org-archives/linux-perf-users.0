Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5893E92BF
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774980572; cv=pass; b=o8DfaECZWGTRui1RtP5HV3+Hj5+rWxH2Bg6+WNgi4zzrY36HTerZThpM144xXaZv3BPxJSd8An/5b+HWCVvcIP7d4GFS72z0bZLkuxM3ol7Go2rfrDHZlSGpN2vt7d5GFZkXsrBN/+SqpKfIBHQRIWIwY0IWUqcNyytS1QRLp3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774980572; c=relaxed/simple;
	bh=HynOGTPeZQMVKW/aF2C7atAGX0smG+kSjHKmkmVP+jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z4LPYXKm3FDf3/1bZKuO4Ix0D/K0gOOcatKlXACCANZ9OYnmG8UcELtWab8KYHIL17omA7ynK72xlyWRJdu6NsEB33ODOgDYUHe1JM3hNxS9PCjg3j8pmTujDVkbVB1ilAAkC8VhhFDKaVSi4XBkuo84a/yjJTOQod76q1kSQB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B/Sm566x; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B/Sm566x"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b0b260d309so97875ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 11:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774980569; cv=none;
        d=google.com; s=arc-20240605;
        b=gYyfzQWXSXvzfcDu53S/CuVXwXmyWugFaSvRJBZiJ+e+BLWgndaXN7RsqOY24QnZ+L
         CJS4N8Ujdq9CyPF67nRteyPSmHLHhibjF8UxVrEKT2Ic6ATKSlIL/UuDvts0Xbiig04A
         8W3jJ6o4S05/lXgmd55DVK7YEKXYG2guSjo6IwwOI/Dje+b0Y5ptMQWZIEwPnSoQzBpN
         TySM/EpcwfI6I/4rLE+DVS4aM2cf9ruzYXMpvIauzUEACoi+rKXEi3uTNax2K0b4buX3
         EEc8wE+AdCKgFHOGU3pXpHNSNksiF2MCwwhrP3N5mc0CFuzvGb1Oxydc6Mo4P8Ju82x+
         6h/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I/dzmKcnAXexNEAheRvDF9lnuDwFf9z0BnFv3gqq3oA=;
        fh=7uVtmw2KPlsPLZle4i8pfzksRuvg597hXS5Jz4TTCxg=;
        b=KbT8IeAsMQWbsT6ygTyGQJCyRguexr7P7gmLjhi+H2R4QnTkyx40UY3+0xAgmEPnnc
         +ugAztEv9xyLFYYpQ5lq8HtuXQGM6aJMHfDB8I/lYLTzcgAgHTSQUOCz2B1Gy3Arz4U0
         viakvgJSRcpdz2BPQ8MUuKWo2wbUH1PF0jy3pDzdcn540xYu6Ylipb5CpxZKA9qQxlCn
         fShOha9fkuwBQQDK+rhOFC+gsXNEHyBHYONGJeFTBI3qbbBV0ELj+NWtXKK6M3ASzosM
         78iN9TDHnCeKx9fQ4/ECdhjXpqNFq4Iliu4TXTITrVW9KOstyT447th5II+wL5wL3+3f
         bKDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774980569; x=1775585369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/dzmKcnAXexNEAheRvDF9lnuDwFf9z0BnFv3gqq3oA=;
        b=B/Sm566xqqI36TPc7Yq8Zdd+S2sOpPwyUJqD/bs4pYbaGim+pavOJjuItLdyIZD4vm
         Qey6gWd7AOBCUdzvo8wv6I575oi9cjOGjRjeG8UL/FqmQSbSD1HWPb23FYv3LMKkmvV9
         XrI+1g0q2Gh0JJmikiXBvbj4VJl8fsczp0BIq/7VpiAXbplxW5m4i3L5aoUZSLY4+4XN
         GPOWclGY8VhSbHxL2U79X2+GyM84lrQtVLqQDi5xa6bLqCSHH816UtPcBKVaTGqYT7tF
         kCIgC2qg9dhNOFEYAOgWnD7dfIqinHzsFI3+khNJUTVjnpaRgmP46UVTPVPiek9Y6x/T
         tVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774980569; x=1775585369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I/dzmKcnAXexNEAheRvDF9lnuDwFf9z0BnFv3gqq3oA=;
        b=btiK9U6TmfM90xpUES+Q9ZKVYAmvpe9HdZQeJFSX2kiDSn8YlF7nSifNiJ1F1nwUIj
         EtHKe3EGaSurcYPOMK9+8aaj37blJnCigLCapceUUjLSUhmkdx6dOlSQLIy5IoDCwcBI
         27hr0IJVH+fhZRdLttR3nN5YYiiG3M3cC/PXvHRY5zJFVG1bFXPAhPTyFExhOh1zzSiK
         nZNxj2ifiL+ywCgbPcdu+NUEBQDnhaxI6lm0Ugis+PRnuHCf8xMKPXX/7oeAI9g0q0Ce
         srZm0KADo1L8wYsiRKthoRlFU+yrxjkjwWF+AKhx4yyo1GlFCXVWKsZ6hLbhFAcO4qWt
         yTrg==
X-Forwarded-Encrypted: i=1; AJvYcCWH5NTX3sM2HQkXfybUOAeZyG+mIpFeazh3wPs0lJP13GX0q+LDtBsGLRq5R2Pz9XxdVsOp7ItsVn/4MAkDtZnR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gIvMQSpyyREQ/tGl8FeR2K50PXrzbRsOG5EEk1aHVRoPaQ5k
	idycI0MJFvUkLFBt1quYDb7WcJkQc1aEdRio/PZcA5+NHjf0YH61P6tzTP+NVK3hPGt3vvF5y/2
	x29K5lqLqXRWiZzYO2xZat/p0Hwn4KNZmC+F86U7x
X-Gm-Gg: ATEYQzwiWzq6mZ3sF+mbhNrJtC5Daxv/Hq68hRDeokyFOl0zve57pewNt05EpUyYRgz
	DA1FrPDEXS6fCh22yVYwMZ3Wz0GtsBEzizHO3eXsAZ+9+9LxQjvulUcu5oKZf/zH2L5ypqQlIgH
	yRuSCIAVikQF7ihOSa/51GlEOWAGN145kdoABp3gYgqdpj45KfgJQ8a3wzFGMo5RlyhRQJe5ZPA
	LcvZrs/uHMLQb/qXQAiIbIlHYNHJStv50ysS7MtLT61ppA1441Afg0e5u/1pAWoEzmH6eDloZG7
	OXFWP3WF7PuVSrXBH8yF/5V9h3ayl6t0l8y75w==
X-Received: by 2002:a17:903:f86:b0:2ad:ab68:f2c3 with SMTP id
 d9443c01a7336-2b268eaa9edmr771065ad.13.1774980567819; Tue, 31 Mar 2026
 11:09:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fU9N_TB53NrN_gCOWoabQ9to41Hj4Wovv5n4t6=5ANHnw@mail.gmail.com>
 <20260319081843.1650640-1-irogers@google.com> <acbupFeqAMj0X9NU@google.com>
In-Reply-To: <acbupFeqAMj0X9NU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 11:09:16 -0700
X-Gm-Features: AQROBzCyLxXFgEKqnUviLDTbyGOPh5CW6PZRwRSZcOeEtfBVDyHd6ggtEPNvXv8
Message-ID: <CAP-5=fX_ckM5n1HncUD2NVk+SuddazuLNVQH6TS8Men8UQj43g@mail.gmail.com>
Subject: Re: [PATCH v1] libperf cpumap: Make index and nr types unsigned
To: Namhyung Kim <namhyung@kernel.org>
Cc: liqb365@163.com, haixiao.yan.cn@windriver.com, acme@kernel.org, 
	adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Thu, Mar 19, 2026 at 01:18:43AM -0700, Ian Rogers wrote:
> > The index into the cpumap array and the number of entries within the
> > array can never be negative, so let's make them unsigned. This is
> > prompted by reports that gcc 13 with -O6 is giving a
> > alloc-size-larger-than errors. The change makes the cpumap changes and
> > then updates the declaration of index variables throughout perf and
> > libperf to be unsigned. The two things are hard to separate as
> > compiler warnings about mixing signed and unsigned types breaks the
> > build.
> >
> > Reported-by: Chingbin Li <liqb365@163.com>
> > Closes: https://lore.kernel.org/lkml/20260212025127.841090-1-liqb365@16=
3.com/
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/cpumap.c                       | 49 +++++++++----------
> >  tools/lib/perf/evsel.c                        | 10 ++--
> >  tools/lib/perf/include/internal/cpumap.h      |  6 +--
> >  tools/lib/perf/include/perf/cpumap.h          |  4 +-
> >  tools/perf/arch/arm/util/cs-etm.c             |  7 +--
> >  tools/perf/arch/arm64/util/arm-spe.c          |  3 +-
> >  tools/perf/arch/arm64/util/header.c           |  2 +-
> >  tools/perf/arch/x86/util/pmu.c                |  3 +-
> >  tools/perf/builtin-c2c.c                      |  6 +--
> >  tools/perf/builtin-record.c                   |  2 +-
> >  tools/perf/builtin-script.c                   |  5 +-
> >  tools/perf/builtin-stat.c                     |  2 +-
> >  tools/perf/tests/bitmap.c                     |  2 +-
> >  tools/perf/tests/cpumap.c                     |  6 ++-
> >  tools/perf/tests/mem2node.c                   |  2 +-
> >  tools/perf/tests/openat-syscall-all-cpus.c    |  3 +-
> >  tools/perf/tests/topology.c                   |  4 +-
> >  tools/perf/util/affinity.c                    |  2 +-
> >  tools/perf/util/bpf_counter.c                 | 24 ++++-----
> >  tools/perf/util/bpf_counter_cgroup.c          |  8 +--
> >  tools/perf/util/bpf_kwork.c                   |  3 +-
> >  tools/perf/util/bpf_kwork_top.c               |  3 +-
> >  tools/perf/util/bpf_off_cpu.c                 |  2 +-
> >  tools/perf/util/bpf_trace_augment.c           |  2 +-
> >  tools/perf/util/cpumap.c                      | 10 ++--
> >  tools/perf/util/cputopo.c                     |  2 +-
> >  tools/perf/util/env.c                         |  2 +-
> >  .../scripting-engines/trace-event-python.c    |  2 +-
> >  tools/perf/util/session.c                     |  3 +-
> >  tools/perf/util/stat-display.c                |  4 +-
> >  tools/perf/util/stat.c                        |  8 +--
> >  tools/perf/util/svghelper.c                   |  3 +-
> >  tools/perf/util/symbol.c                      |  3 +-
> >  tools/perf/util/synthetic-events.c            |  2 +-
> >  34 files changed, 108 insertions(+), 91 deletions(-)
> >
> > diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
> > index 4160e7d2e120..b987b7c7cee2 100644
> > --- a/tools/lib/perf/cpumap.c
> > +++ b/tools/lib/perf/cpumap.c
> > @@ -15,12 +15,12 @@
> >
> >  #define MAX_NR_CPUS 4096
> >
> > -void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
> > +void perf_cpu_map__set_nr(struct perf_cpu_map *map, unsigned int nr_cp=
us)
> >  {
> >       RC_CHK_ACCESS(map)->nr =3D nr_cpus;
> >  }
> >
> > -struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
> > +struct perf_cpu_map *perf_cpu_map__alloc(unsigned int nr_cpus)
> >  {
> >       RC_STRUCT(perf_cpu_map) *cpus;
> >       struct perf_cpu_map *result;
> > @@ -78,7 +78,7 @@ void perf_cpu_map__put(struct perf_cpu_map *map)
> >  static struct perf_cpu_map *cpu_map__new_sysconf(void)
> >  {
> >       struct perf_cpu_map *cpus;
> > -     int nr_cpus, nr_cpus_conf;
> > +     long nr_cpus, nr_cpus_conf;
>
> Shouldn't it be unsigned int?

The value from sysconf is a long and we need to check for negative
values as an error condition.

> >
> >       nr_cpus =3D sysconf(_SC_NPROCESSORS_ONLN);
> >       if (nr_cpus < 0)
> > @@ -86,15 +86,13 @@ static struct perf_cpu_map *cpu_map__new_sysconf(vo=
id)
> >
> >       nr_cpus_conf =3D sysconf(_SC_NPROCESSORS_CONF);
> >       if (nr_cpus !=3D nr_cpus_conf) {
> > -             pr_warning("Number of online CPUs (%d) differs from the n=
umber configured (%d) the CPU map will only cover the first %d CPUs.",
> > +             pr_warning("Number of online CPUs (%ld) differs from the =
number configured (%ld) the CPU map will only cover the first %ld CPUs.",
> >                       nr_cpus, nr_cpus_conf, nr_cpus);
> >       }
> >
> >       cpus =3D perf_cpu_map__alloc(nr_cpus);
> >       if (cpus !=3D NULL) {
> > -             int i;
> > -
> > -             for (i =3D 0; i < nr_cpus; ++i)
> > +             for (unsigned int i =3D 0; i < nr_cpus; ++i)
> >                       RC_CHK_ACCESS(cpus)->map[i].cpu =3D i;
>
> I got this:
>
> cpumap.c: In function 'cpu_map__new_sysconf':
> cpumap.c:95:44: error: comparison of integer expressions of different sig=
nedness: 'unsigned int' and 'long int' [-Werror=3Dsign-compare]
>    95 |                 for (unsigned int i =3D 0; i < nr_cpus; ++i)
>       |                                            ^

Thanks, I'll take a look.

Ian

> Thanks,
> Namhyung
>
> >       }
> >
> > @@ -132,23 +130,23 @@ static int cmp_cpu(const void *a, const void *b)
> >       return cpu_a->cpu - cpu_b->cpu;
> >  }
> >
> > -static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *=
cpus, int idx)
> > +static struct perf_cpu __perf_cpu_map__cpu(const struct perf_cpu_map *=
cpus, unsigned int idx)
> >  {
> >       return RC_CHK_ACCESS(cpus)->map[idx];
> >  }
> >
> > -static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, const struc=
t perf_cpu *tmp_cpus)
> > +static struct perf_cpu_map *cpu_map__trim_new(unsigned int nr_cpus, co=
nst struct perf_cpu *tmp_cpus)
> >  {
> >       size_t payload_size =3D nr_cpus * sizeof(struct perf_cpu);
> >       struct perf_cpu_map *cpus =3D perf_cpu_map__alloc(nr_cpus);
> > -     int i, j;
> >
> >       if (cpus !=3D NULL) {
> > +             unsigned int j =3D 0;
> > +
> >               memcpy(RC_CHK_ACCESS(cpus)->map, tmp_cpus, payload_size);
> >               qsort(RC_CHK_ACCESS(cpus)->map, nr_cpus, sizeof(struct pe=
rf_cpu), cmp_cpu);
> >               /* Remove dups */
> > -             j =3D 0;
> > -             for (i =3D 0; i < nr_cpus; i++) {
> > +             for (unsigned int i =3D 0; i < nr_cpus; i++) {
> >                       if (i =3D=3D 0 ||
> >                           __perf_cpu_map__cpu(cpus, i).cpu !=3D
> >                           __perf_cpu_map__cpu(cpus, i - 1).cpu) {
> > @@ -167,9 +165,8 @@ struct perf_cpu_map *perf_cpu_map__new(const char *=
cpu_list)
> >       struct perf_cpu_map *cpus =3D NULL;
> >       unsigned long start_cpu, end_cpu =3D 0;
> >       char *p =3D NULL;
> > -     int i, nr_cpus =3D 0;
> > +     unsigned int nr_cpus =3D 0, max_entries =3D 0;
> >       struct perf_cpu *tmp_cpus =3D NULL, *tmp;
> > -     int max_entries =3D 0;
> >
> >       if (!cpu_list)
> >               return perf_cpu_map__new_online_cpus();
> > @@ -208,9 +205,10 @@ struct perf_cpu_map *perf_cpu_map__new(const char =
*cpu_list)
> >
> >               for (; start_cpu <=3D end_cpu; start_cpu++) {
> >                       /* check for duplicates */
> > -                     for (i =3D 0; i < nr_cpus; i++)
> > +                     for (unsigned int i =3D 0; i < nr_cpus; i++) {
> >                               if (tmp_cpus[i].cpu =3D=3D (int16_t)start=
_cpu)
> >                                       goto invalid;
> > +                     }
> >
> >                       if (nr_cpus =3D=3D max_entries) {
> >                               max_entries +=3D max(end_cpu - start_cpu =
+ 1, 16UL);
> > @@ -252,12 +250,12 @@ struct perf_cpu_map *perf_cpu_map__new_int(int cp=
u)
> >       return cpus;
> >  }
> >
> > -static int __perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> > +static unsigned int __perf_cpu_map__nr(const struct perf_cpu_map *cpus=
)
> >  {
> >       return RC_CHK_ACCESS(cpus)->nr;
> >  }
> >
> > -struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int=
 idx)
> > +struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_map *cpus, uns=
igned int idx)
> >  {
> >       struct perf_cpu result =3D {
> >               .cpu =3D -1
> > @@ -269,7 +267,7 @@ struct perf_cpu perf_cpu_map__cpu(const struct perf=
_cpu_map *cpus, int idx)
> >       return result;
> >  }
> >
> > -int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> > +unsigned int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> >  {
> >       return cpus ? __perf_cpu_map__nr(cpus) : 1;
> >  }
> > @@ -294,7 +292,7 @@ bool perf_cpu_map__is_empty(const struct perf_cpu_m=
ap *map)
> >
> >  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu=
 cpu)
> >  {
> > -     int low, high;
> > +     unsigned int low, high;
> >
> >       if (!cpus)
> >               return -1;
> > @@ -324,7 +322,7 @@ bool perf_cpu_map__has(const struct perf_cpu_map *c=
pus, struct perf_cpu cpu)
> >
> >  bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct =
perf_cpu_map *rhs)
> >  {
> > -     int nr;
> > +     unsigned int nr;
> >
> >       if (lhs =3D=3D rhs)
> >               return true;
> > @@ -336,7 +334,7 @@ bool perf_cpu_map__equal(const struct perf_cpu_map =
*lhs, const struct perf_cpu_m
> >       if (nr !=3D __perf_cpu_map__nr(rhs))
> >               return false;
> >
> > -     for (int idx =3D 0; idx < nr; idx++) {
> > +     for (unsigned int idx =3D 0; idx < nr; idx++) {
> >               if (__perf_cpu_map__cpu(lhs, idx).cpu !=3D __perf_cpu_map=
__cpu(rhs, idx).cpu)
> >                       return false;
> >       }
> > @@ -353,7 +351,7 @@ struct perf_cpu perf_cpu_map__min(const struct perf=
_cpu_map *map)
> >       struct perf_cpu cpu, result =3D {
> >               .cpu =3D -1
> >       };
> > -     int idx;
> > +     unsigned int idx;
> >
> >       perf_cpu_map__for_each_cpu_skip_any(cpu, idx, map) {
> >               result =3D cpu;
> > @@ -384,7 +382,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_=
map *a, const struct perf_cpu
> >       if (!a || __perf_cpu_map__nr(b) > __perf_cpu_map__nr(a))
> >               return false;
> >
> > -     for (int i =3D 0, j =3D 0; i < __perf_cpu_map__nr(a); i++) {
> > +     for (unsigned int i =3D 0, j =3D 0; i < __perf_cpu_map__nr(a); i+=
+) {
> >               if (__perf_cpu_map__cpu(a, i).cpu > __perf_cpu_map__cpu(b=
, j).cpu)
> >                       return false;
> >               if (__perf_cpu_map__cpu(a, i).cpu =3D=3D __perf_cpu_map__=
cpu(b, j).cpu) {
> > @@ -410,8 +408,7 @@ bool perf_cpu_map__is_subset(const struct perf_cpu_=
map *a, const struct perf_cpu
> >  int perf_cpu_map__merge(struct perf_cpu_map **orig, struct perf_cpu_ma=
p *other)
> >  {
> >       struct perf_cpu *tmp_cpus;
> > -     int tmp_len;
> > -     int i, j, k;
> > +     unsigned int tmp_len, i, j, k;
> >       struct perf_cpu_map *merged;
> >
> >       if (perf_cpu_map__is_subset(*orig, other))
> > @@ -455,7 +452,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **orig,=
 struct perf_cpu_map *other)
> >  struct perf_cpu_map *perf_cpu_map__intersect(struct perf_cpu_map *orig=
,
> >                                            struct perf_cpu_map *other)
> >  {
> > -     int i, j, k;
> > +     unsigned int i, j, k;
> >       struct perf_cpu_map *merged;
> >
> >       if (perf_cpu_map__is_subset(other, orig))
> > diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
> > index 13a307fc75ae..f747c0bc692d 100644
> > --- a/tools/lib/perf/evsel.c
> > +++ b/tools/lib/perf/evsel.c
> > @@ -127,7 +127,8 @@ int perf_evsel__open(struct perf_evsel *evsel, stru=
ct perf_cpu_map *cpus,
> >                    struct perf_thread_map *threads)
> >  {
> >       struct perf_cpu cpu;
> > -     int idx, thread, err =3D 0;
> > +     unsigned int idx;
> > +     int thread, err =3D 0;
> >
> >       if (cpus =3D=3D NULL) {
> >               static struct perf_cpu_map *empty_cpu_map;
> > @@ -460,7 +461,7 @@ int perf_evsel__enable_cpu(struct perf_evsel *evsel=
, int cpu_map_idx)
> >  int perf_evsel__enable_thread(struct perf_evsel *evsel, int thread)
> >  {
> >       struct perf_cpu cpu __maybe_unused;
> > -     int idx;
> > +     unsigned int idx;
> >       int err;
> >
> >       perf_cpu_map__for_each_cpu(cpu, idx, evsel->cpus) {
> > @@ -499,12 +500,13 @@ int perf_evsel__disable(struct perf_evsel *evsel)
> >
> >  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *fil=
ter)
> >  {
> > -     int err =3D 0, i;
> > +     int err =3D 0;
> >
> > -     for (i =3D 0; i < perf_cpu_map__nr(evsel->cpus) && !err; i++)
> > +     for (unsigned int i =3D 0; i < perf_cpu_map__nr(evsel->cpus) && !=
err; i++) {
> >               err =3D perf_evsel__run_ioctl(evsel,
> >                                    PERF_EVENT_IOC_SET_FILTER,
> >                                    (void *)filter, i);
> > +     }
> >       return err;
> >  }
> >
> > diff --git a/tools/lib/perf/include/internal/cpumap.h b/tools/lib/perf/=
include/internal/cpumap.h
> > index e2be2d17c32b..c19678188b17 100644
> > --- a/tools/lib/perf/include/internal/cpumap.h
> > +++ b/tools/lib/perf/include/internal/cpumap.h
> > @@ -16,16 +16,16 @@
> >  DECLARE_RC_STRUCT(perf_cpu_map) {
> >       refcount_t      refcnt;
> >       /** Length of the map array. */
> > -     int             nr;
> > +     unsigned int    nr;
> >       /** The CPU values. */
> >       struct perf_cpu map[];
> >  };
> >
> > -struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus);
> > +struct perf_cpu_map *perf_cpu_map__alloc(unsigned int nr_cpus);
> >  int perf_cpu_map__idx(const struct perf_cpu_map *cpus, struct perf_cpu=
 cpu);
> >  bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struc=
t perf_cpu_map *b);
> >
> > -void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus);
> > +void perf_cpu_map__set_nr(struct perf_cpu_map *map, unsigned int nr_cp=
us);
> >
> >  static inline refcount_t *perf_cpu_map__refcnt(struct perf_cpu_map *ma=
p)
> >  {
> > diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/incl=
ude/perf/cpumap.h
> > index 58cc5c5fa47c..a1dd25db65b6 100644
> > --- a/tools/lib/perf/include/perf/cpumap.h
> > +++ b/tools/lib/perf/include/perf/cpumap.h
> > @@ -49,7 +49,7 @@ LIBPERF_API void perf_cpu_map__put(struct perf_cpu_ma=
p *map);
> >   * perf_cpu_map__cpu - get the CPU value at the given index. Returns -=
1 if index
> >   *                     is invalid.
> >   */
> > -LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_ma=
p *cpus, int idx);
> > +LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const struct perf_cpu_ma=
p *cpus, unsigned int idx);
> >  /**
> >   * perf_cpu_map__nr - for an empty map returns 1, as perf_cpu_map__cpu=
 returns a
> >   *                    cpu of -1 for an invalid index, this makes an em=
pty map
> > @@ -57,7 +57,7 @@ LIBPERF_API struct perf_cpu perf_cpu_map__cpu(const s=
truct perf_cpu_map *cpus, i
> >   *                    the result is the number CPUs in the map plus on=
e if the
> >   *                    "any CPU"/dummy value is present.
> >   */
> > -LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> > +LIBPERF_API unsigned int perf_cpu_map__nr(const struct perf_cpu_map *c=
pus);
> >  /**
> >   * perf_cpu_map__has_any_cpu_or_is_empty - is map either empty or has =
the "any CPU"/dummy value.
> >   */
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/ut=
il/cs-etm.c
> > index dc3f4e86b075..cc880ab596fe 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -211,7 +211,8 @@ static struct perf_pmu *cs_etm_get_pmu(struct auxtr=
ace_record *itr)
> >  static int cs_etm_validate_config(struct perf_pmu *cs_etm_pmu,
> >                                 struct evsel *evsel)
> >  {
> > -     int idx, err =3D 0;
> > +     unsigned int idx;
> > +     int err =3D 0;
> >       struct perf_cpu_map *event_cpus =3D evsel->evlist->core.user_requ=
ested_cpus;
> >       struct perf_cpu_map *intersect_cpus;
> >       struct perf_cpu cpu;
> > @@ -560,7 +561,7 @@ static size_t
> >  cs_etm_info_priv_size(struct auxtrace_record *itr,
> >                     struct evlist *evlist)
> >  {
> > -     int idx;
> > +     unsigned int idx;
> >       int etmv3 =3D 0, etmv4 =3D 0, ete =3D 0;
> >       struct perf_cpu_map *event_cpus =3D evlist->core.user_requested_c=
pus;
> >       struct perf_cpu_map *intersect_cpus;
> > @@ -797,7 +798,7 @@ static int cs_etm_info_fill(struct auxtrace_record =
*itr,
> >                           struct perf_record_auxtrace_info *info,
> >                           size_t priv_size)
> >  {
> > -     int i;
> > +     unsigned int i;
> >       u32 offset;
> >       u64 nr_cpu, type;
> >       struct perf_cpu_map *cpu_map;
> > diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm=
64/util/arm-spe.c
> > index 17ced7bbbdda..f00d72d087fc 100644
> > --- a/tools/perf/arch/arm64/util/arm-spe.c
> > +++ b/tools/perf/arch/arm64/util/arm-spe.c
> > @@ -144,7 +144,8 @@ static int arm_spe_info_fill(struct auxtrace_record=
 *itr,
> >                            struct perf_record_auxtrace_info *auxtrace_i=
nfo,
> >                            size_t priv_size)
> >  {
> > -     int i, ret;
> > +     unsigned int i;
> > +     int ret;
> >       size_t offset;
> >       struct arm_spe_recording *sper =3D
> >                       container_of(itr, struct arm_spe_recording, itr);
> > diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm6=
4/util/header.c
> > index cbc0ba101636..95e71c4f6c78 100644
> > --- a/tools/perf/arch/arm64/util/header.c
> > +++ b/tools/perf/arch/arm64/util/header.c
> > @@ -43,7 +43,7 @@ static int _get_cpuid(char *buf, size_t sz, struct pe=
rf_cpu cpu)
> >  int get_cpuid(char *buf, size_t sz, struct perf_cpu cpu)
> >  {
> >       struct perf_cpu_map *cpus;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       if (cpu.cpu !=3D -1)
> >               return _get_cpuid(buf, sz, cpu);
> > diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/=
pmu.c
> > index 4ea4d022c9c3..0661e0f0b02d 100644
> > --- a/tools/perf/arch/x86/util/pmu.c
> > +++ b/tools/perf/arch/x86/util/pmu.c
> > @@ -221,7 +221,8 @@ static void gnr_uncore_cha_imc_adjust_cpumask_for_s=
nc(struct perf_pmu *pmu, bool
> >       static struct perf_cpu_map *cha_adjusted[MAX_SNCS];
> >       static struct perf_cpu_map *imc_adjusted[MAX_SNCS];
> >       struct perf_cpu_map **adjusted =3D cha ? cha_adjusted : imc_adjus=
ted;
> > -     int idx, pmu_snc, cpu_adjust;
> > +     unsigned int idx;
> > +     int pmu_snc, cpu_adjust;
> >       struct perf_cpu cpu;
> >       bool alloc;
> >
> > diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> > index d390ae4e3ec8..e60eea62c2fc 100644
> > --- a/tools/perf/builtin-c2c.c
> > +++ b/tools/perf/builtin-c2c.c
> > @@ -2310,7 +2310,6 @@ static int setup_nodes(struct perf_session *sessi=
on)
> >  {
> >       struct numa_node *n;
> >       unsigned long **nodes;
> > -     int node, idx;
> >       struct perf_cpu cpu;
> >       int *cpu2node;
> >       struct perf_env *env =3D perf_session__env(session);
> > @@ -2335,14 +2334,15 @@ static int setup_nodes(struct perf_session *ses=
sion)
> >       if (!cpu2node)
> >               return -ENOMEM;
> >
> > -     for (idx =3D 0; idx < c2c.cpus_cnt; idx++)
> > +     for (int idx =3D 0; idx < c2c.cpus_cnt; idx++)
> >               cpu2node[idx] =3D -1;
> >
> >       c2c.cpu2node =3D cpu2node;
> >
> > -     for (node =3D 0; node < c2c.nodes_cnt; node++) {
> > +     for (int node =3D 0; node < c2c.nodes_cnt; node++) {
> >               struct perf_cpu_map *map =3D n[node].map;
> >               unsigned long *set;
> > +             unsigned int idx;
> >
> >               set =3D bitmap_zalloc(c2c.cpus_cnt);
> >               if (!set)
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 40917a0be238..63a47820fd46 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -3695,7 +3695,7 @@ struct option *record_options =3D __record_option=
s;
> >  static int record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, stru=
ct perf_cpu_map *cpus)
> >  {
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       if (cpu_map__is_dummy(cpus))
> >               return 0;
> > diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> > index b80c406d1fc1..b005b23f9d8c 100644
> > --- a/tools/perf/builtin-script.c
> > +++ b/tools/perf/builtin-script.c
> > @@ -2572,7 +2572,6 @@ static struct scripting_ops     *scripting_ops;
> >  static void __process_stat(struct evsel *counter, u64 tstamp)
> >  {
> >       int nthreads =3D perf_thread_map__nr(counter->core.threads);
> > -     int idx, thread;
> >       struct perf_cpu cpu;
> >       static int header_printed;
> >
> > @@ -2582,7 +2581,9 @@ static void __process_stat(struct evsel *counter,=
 u64 tstamp)
> >               header_printed =3D 1;
> >       }
> >
> > -     for (thread =3D 0; thread < nthreads; thread++) {
> > +     for (int thread =3D 0; thread < nthreads; thread++) {
> > +             unsigned int idx;
> > +
> >               perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)=
) {
> >                       struct perf_counts_values *counts;
> >
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 73c2ba7e3076..46ef99f844dd 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -410,7 +410,7 @@ static int read_tool_counters(void)
> >       struct evsel *counter;
> >
> >       evlist__for_each_entry(evsel_list, counter) {
> > -             int idx;
> > +             unsigned int idx;
> >
> >               if (!evsel__is_tool(counter))
> >                       continue;
> > diff --git a/tools/perf/tests/bitmap.c b/tools/perf/tests/bitmap.c
> > index 98956e0e0765..e7adf60be721 100644
> > --- a/tools/perf/tests/bitmap.c
> > +++ b/tools/perf/tests/bitmap.c
> > @@ -16,7 +16,7 @@ static unsigned long *get_bitmap(const char *str, int=
 nbits)
> >       bm =3D bitmap_zalloc(nbits);
> >
> >       if (map && bm) {
> > -             int i;
> > +             unsigned int i;
> >               struct perf_cpu cpu;
> >
> >               perf_cpu_map__for_each_cpu(cpu, i, map)
> > diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
> > index 2354246afc5a..b051dce2cd86 100644
> > --- a/tools/perf/tests/cpumap.c
> > +++ b/tools/perf/tests/cpumap.c
> > @@ -156,7 +156,8 @@ static int test__cpu_map_print(struct test_suite *t=
est __maybe_unused, int subte
> >       return 0;
> >  }
> >
> > -static int __test__cpu_map_merge(const char *lhs, const char *rhs, int=
 nr, const char *expected)
> > +static int __test__cpu_map_merge(const char *lhs, const char *rhs, uns=
igned int nr,
> > +                              const char *expected)
> >  {
> >       struct perf_cpu_map *a =3D perf_cpu_map__new(lhs);
> >       struct perf_cpu_map *b =3D perf_cpu_map__new(rhs);
> > @@ -204,7 +205,8 @@ static int test__cpu_map_merge(struct test_suite *t=
est __maybe_unused,
> >       return ret;
> >  }
> >
> > -static int __test__cpu_map_intersect(const char *lhs, const char *rhs,=
 int nr, const char *expected)
> > +static int __test__cpu_map_intersect(const char *lhs, const char *rhs,=
 unsigned int nr,
> > +                                  const char *expected)
> >  {
> >       struct perf_cpu_map *a =3D perf_cpu_map__new(lhs);
> >       struct perf_cpu_map *b =3D perf_cpu_map__new(rhs);
> > diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
> > index a0e88c496107..7ce1ad7b6ce5 100644
> > --- a/tools/perf/tests/mem2node.c
> > +++ b/tools/perf/tests/mem2node.c
> > @@ -30,7 +30,7 @@ static unsigned long *get_bitmap(const char *str, int=
 nbits)
> >
> >       if (map && bm) {
> >               struct perf_cpu cpu;
> > -             int i;
> > +             unsigned int i;
> >
> >               perf_cpu_map__for_each_cpu(cpu, i, map)
> >                       __set_bit(cpu.cpu, bm);
> > diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/te=
sts/openat-syscall-all-cpus.c
> > index 3644d6f52c07..0be43f8db3bd 100644
> > --- a/tools/perf/tests/openat-syscall-all-cpus.c
> > +++ b/tools/perf/tests/openat-syscall-all-cpus.c
> > @@ -22,7 +22,8 @@
> >  static int test__openat_syscall_event_on_all_cpus(struct test_suite *t=
est __maybe_unused,
> >                                                 int subtest __maybe_unu=
sed)
> >  {
> > -     int err =3D TEST_FAIL, fd, idx;
> > +     int err =3D TEST_FAIL, fd;
> > +     unsigned int idx;
> >       struct perf_cpu cpu;
> >       struct perf_cpu_map *cpus;
> >       struct evsel *evsel;
> > diff --git a/tools/perf/tests/topology.c b/tools/perf/tests/topology.c
> > index ec01150d208d..9e6a0031e9ec 100644
> > --- a/tools/perf/tests/topology.c
> > +++ b/tools/perf/tests/topology.c
> > @@ -67,7 +67,7 @@ static int check_cpu_topology(char *path, struct perf=
_cpu_map *map)
> >               .path =3D path,
> >               .mode =3D PERF_DATA_MODE_READ,
> >       };
> > -     int i;
> > +     unsigned int i;
> >       struct aggr_cpu_id id;
> >       struct perf_cpu cpu;
> >       struct perf_env *env;
> > @@ -114,7 +114,7 @@ static int check_cpu_topology(char *path, struct pe=
rf_cpu_map *map)
> >
> >       TEST_ASSERT_VAL("Session header CPU map not set", env->cpu);
> >
> > -     for (i =3D 0; i < env->nr_cpus_avail; i++) {
> > +     for (i =3D 0; i < (unsigned int)env->nr_cpus_avail; i++) {
> >               cpu.cpu =3D i;
> >               if (!perf_cpu_map__has(map, cpu))
> >                       continue;
> > diff --git a/tools/perf/util/affinity.c b/tools/perf/util/affinity.c
> > index 4fe851334296..6c64b5f69a4e 100644
> > --- a/tools/perf/util/affinity.c
> > +++ b/tools/perf/util/affinity.c
> > @@ -90,7 +90,7 @@ void cpu_map__set_affinity(const struct perf_cpu_map =
*cpumap)
> >       int cpu_set_size =3D get_cpu_set_size();
> >       unsigned long *cpuset =3D bitmap_zalloc(cpu_set_size * 8);
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       if (!cpuset)
> >               return;
> > diff --git a/tools/perf/util/bpf_counter.c b/tools/perf/util/bpf_counte=
r.c
> > index a5882b582205..2ffd7aefb6eb 100644
> > --- a/tools/perf/util/bpf_counter.c
> > +++ b/tools/perf/util/bpf_counter.c
> > @@ -294,7 +294,8 @@ static int bpf_program_profiler__read(struct evsel =
*evsel)
> >       struct perf_counts_values *counts;
> >       int reading_map_fd;
> >       __u32 key =3D 0;
> > -     int err, idx, bpf_cpu;
> > +     int err, bpf_cpu;
> > +     unsigned int idx;
> >
> >       if (list_empty(&evsel->bpf_counter_list))
> >               return -EAGAIN;
> > @@ -318,11 +319,12 @@ static int bpf_program_profiler__read(struct evse=
l *evsel)
> >               }
> >
> >               for (bpf_cpu =3D 0; bpf_cpu < num_cpu_bpf; bpf_cpu++) {
> > -                     idx =3D perf_cpu_map__idx(evsel__cpus(evsel),
> > -                                             (struct perf_cpu){.cpu =
=3D bpf_cpu});
> > -                     if (idx =3D=3D -1)
> > +                     int i =3D perf_cpu_map__idx(evsel__cpus(evsel),
> > +                                               (struct perf_cpu){.cpu =
=3D bpf_cpu});
> > +
> > +                     if (i =3D=3D -1)
> >                               continue;
> > -                     counts =3D perf_counts(evsel->counts, idx, 0);
> > +                     counts =3D perf_counts(evsel->counts, i, 0);
> >                       counts->val +=3D values[bpf_cpu].counter;
> >                       counts->ena +=3D values[bpf_cpu].enabled;
> >                       counts->run +=3D values[bpf_cpu].running;
> > @@ -668,7 +670,7 @@ static int bperf__install_pe(struct evsel *evsel, i=
nt cpu_map_idx, int fd)
> >  static int bperf_sync_counters(struct evsel *evsel)
> >  {
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus)
> >               bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu.cp=
u);
> > @@ -695,13 +697,11 @@ static int bperf__read(struct evsel *evsel)
> >       struct bpf_perf_event_value values[num_cpu_bpf];
> >       struct perf_counts_values *counts;
> >       int reading_map_fd, err =3D 0;
> > -     __u32 i;
> > -     int j;
> >
> >       bperf_sync_counters(evsel);
> >       reading_map_fd =3D bpf_map__fd(skel->maps.accum_readings);
> >
> > -     for (i =3D 0; i < filter_entry_cnt; i++) {
> > +     for (__u32 i =3D 0; i < filter_entry_cnt; i++) {
> >               struct perf_cpu entry;
> >               __u32 cpu;
> >
> > @@ -709,9 +709,10 @@ static int bperf__read(struct evsel *evsel)
> >               if (err)
> >                       goto out;
> >               switch (evsel->follower_skel->bss->type) {
> > -             case BPERF_FILTER_GLOBAL:
> > -                     assert(i =3D=3D 0);
> > +             case BPERF_FILTER_GLOBAL: {
> > +                     unsigned int j;
> >
> > +                     assert(i =3D=3D 0);
> >                       perf_cpu_map__for_each_cpu(entry, j, evsel__cpus(=
evsel)) {
> >                               counts =3D perf_counts(evsel->counts, j, =
0);
> >                               counts->val =3D values[entry.cpu].counter=
;
> > @@ -719,6 +720,7 @@ static int bperf__read(struct evsel *evsel)
> >                               counts->run =3D values[entry.cpu].running=
;
> >                       }
> >                       break;
> > +             }
> >               case BPERF_FILTER_CPU:
> >                       cpu =3D perf_cpu_map__cpu(evsel__cpus(evsel), i).=
cpu;
> >                       assert(cpu >=3D 0);
> > diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf=
_counter_cgroup.c
> > index 17d7196c6589..5572ceccf860 100644
> > --- a/tools/perf/util/bpf_counter_cgroup.c
> > +++ b/tools/perf/util/bpf_counter_cgroup.c
> > @@ -98,7 +98,7 @@ static int bperf_load_program(struct evlist *evlist)
> >       struct bpf_link *link;
> >       struct evsel *evsel;
> >       struct cgroup *cgrp, *leader_cgrp;
> > -     int i, j;
> > +     unsigned int i;
> >       struct perf_cpu cpu;
> >       int total_cpus =3D cpu__max_cpu().cpu;
> >       int map_fd, prog_fd, err;
> > @@ -146,6 +146,8 @@ static int bperf_load_program(struct evlist *evlist=
)
> >
> >       evlist__for_each_entry(evlist, evsel) {
> >               if (cgrp =3D=3D NULL || evsel->cgrp =3D=3D leader_cgrp) {
> > +                     unsigned int j;
> > +
> >                       leader_cgrp =3D evsel->cgrp;
> >                       evsel->cgrp =3D NULL;
> >
> > @@ -234,7 +236,7 @@ static int bperf_cgrp__install_pe(struct evsel *evs=
el __maybe_unused,
> >  static int bperf_cgrp__sync_counters(struct evlist *evlist)
> >  {
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >       int prog_fd =3D bpf_program__fd(skel->progs.trigger_read);
> >
> >       perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
> > @@ -286,7 +288,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
> >
> >       evlist__for_each_entry(evlist, evsel) {
> >               __u32 idx =3D evsel->core.idx;
> > -             int i;
> > +             unsigned int i;
> >               struct perf_cpu cpu;
> >
> >               err =3D bpf_map_lookup_elem(reading_map_fd, &idx, values)=
;
> > diff --git a/tools/perf/util/bpf_kwork.c b/tools/perf/util/bpf_kwork.c
> > index 5cff755c71fa..d3a2e548f2b6 100644
> > --- a/tools/perf/util/bpf_kwork.c
> > +++ b/tools/perf/util/bpf_kwork.c
> > @@ -148,7 +148,8 @@ static bool valid_kwork_class_type(enum kwork_class=
_type type)
> >  static int setup_filters(struct perf_kwork *kwork)
> >  {
> >       if (kwork->cpu_list !=3D NULL) {
> > -             int idx, nr_cpus;
> > +             unsigned int idx;
> > +             int nr_cpus;
> >               struct perf_cpu_map *map;
> >               struct perf_cpu cpu;
> >               int fd =3D bpf_map__fd(skel->maps.perf_kwork_cpu_filter);
> > diff --git a/tools/perf/util/bpf_kwork_top.c b/tools/perf/util/bpf_kwor=
k_top.c
> > index b6f187dd9136..189a29d2bc96 100644
> > --- a/tools/perf/util/bpf_kwork_top.c
> > +++ b/tools/perf/util/bpf_kwork_top.c
> > @@ -123,7 +123,8 @@ static bool valid_kwork_class_type(enum kwork_class=
_type type)
> >  static int setup_filters(struct perf_kwork *kwork)
> >  {
> >       if (kwork->cpu_list) {
> > -             int idx, nr_cpus, fd;
> > +             unsigned int idx;
> > +             int nr_cpus, fd;
> >               struct perf_cpu_map *map;
> >               struct perf_cpu cpu;
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 88e0660c4bff..0891d9c73660 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -67,7 +67,7 @@ static void off_cpu_start(void *arg)
> >       struct evlist *evlist =3D arg;
> >       struct evsel *evsel;
> >       struct perf_cpu pcpu;
> > -     int i;
> > +     unsigned int i;
> >
> >       /* update task filter for the given workload */
> >       if (skel->rodata->has_task && skel->rodata->uses_tgid &&
> > diff --git a/tools/perf/util/bpf_trace_augment.c b/tools/perf/util/bpf_=
trace_augment.c
> > index 56ed17534caa..9e706f0fa53d 100644
> > --- a/tools/perf/util/bpf_trace_augment.c
> > +++ b/tools/perf/util/bpf_trace_augment.c
> > @@ -60,7 +60,7 @@ int augmented_syscalls__create_bpf_output(struct evli=
st *evlist)
> >  void augmented_syscalls__setup_bpf_output(void)
> >  {
> >       struct perf_cpu cpu;
> > -     int i;
> > +     unsigned int i;
> >
> >       if (bpf_output =3D=3D NULL)
> >               return;
> > diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> > index a80845038a5e..11922e1ded84 100644
> > --- a/tools/perf/util/cpumap.c
> > +++ b/tools/perf/util/cpumap.c
> > @@ -254,7 +254,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct=
 perf_cpu_map *cpus,
> >                                      aggr_cpu_id_get_t get_id,
> >                                      void *data, bool needs_sort)
> >  {
> > -     int idx;
> > +     unsigned int idx;
> >       struct perf_cpu cpu;
> >       struct cpu_aggr_map *c =3D cpu_aggr_map__empty_new(perf_cpu_map__=
nr(cpus));
> >
> > @@ -280,7 +280,7 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct=
 perf_cpu_map *cpus,
> >               }
> >       }
> >       /* Trim. */
> > -     if (c->nr !=3D perf_cpu_map__nr(cpus)) {
> > +     if (c->nr !=3D (int)perf_cpu_map__nr(cpus)) {
> >               struct cpu_aggr_map *trimmed_c =3D
> >                       realloc(c,
> >                               sizeof(struct cpu_aggr_map) + sizeof(stru=
ct aggr_cpu_id) * c->nr);
> > @@ -631,9 +631,9 @@ size_t cpu_map__snprint(struct perf_cpu_map *map, c=
har *buf, size_t size)
> >
> >  #define COMMA first ? "" : ","
> >
> > -     for (i =3D 0; i < perf_cpu_map__nr(map) + 1; i++) {
> > +     for (i =3D 0; i < (int)perf_cpu_map__nr(map) + 1; i++) {
> >               struct perf_cpu cpu =3D { .cpu =3D INT16_MAX };
> > -             bool last =3D i =3D=3D perf_cpu_map__nr(map);
> > +             bool last =3D i =3D=3D (int)perf_cpu_map__nr(map);
> >
> >               if (!last)
> >                       cpu =3D perf_cpu_map__cpu(map, i);
> > @@ -679,7 +679,7 @@ static char hex_char(unsigned char val)
> >
> >  size_t cpu_map__snprint_mask(struct perf_cpu_map *map, char *buf, size=
_t size)
> >  {
> > -     int idx;
> > +     unsigned int idx;
> >       char *ptr =3D buf;
> >       unsigned char *bitmap;
> >       struct perf_cpu c, last_cpu =3D perf_cpu_map__max(map);
> > diff --git a/tools/perf/util/cputopo.c b/tools/perf/util/cputopo.c
> > index 8bbeb2dc76fd..e0091804fe98 100644
> > --- a/tools/perf/util/cputopo.c
> > +++ b/tools/perf/util/cputopo.c
> > @@ -191,7 +191,7 @@ bool cpu_topology__core_wide(const struct cpu_topol=
ogy *topology,
> >               const char *core_cpu_list =3D topology->core_cpus_list[i]=
;
> >               struct perf_cpu_map *core_cpus =3D perf_cpu_map__new(core=
_cpu_list);
> >               struct perf_cpu cpu;
> > -             int idx;
> > +             unsigned int idx;
> >               bool has_first, first =3D true;
> >
> >               perf_cpu_map__for_each_cpu(cpu, idx, core_cpus) {
> > diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
> > index 93d475a80f14..1e54e2c86360 100644
> > --- a/tools/perf/util/env.c
> > +++ b/tools/perf/util/env.c
> > @@ -718,7 +718,7 @@ int perf_env__numa_node(struct perf_env *env, struc=
t perf_cpu cpu)
> >
> >               for (i =3D 0; i < env->nr_numa_nodes; i++) {
> >                       struct perf_cpu tmp;
> > -                     int j;
> > +                     unsigned int j;
> >
> >                       nn =3D &env->numa_nodes[i];
> >                       perf_cpu_map__for_each_cpu(tmp, j, nn->map)
> > diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/t=
ools/perf/util/scripting-engines/trace-event-python.c
> > index 2b0df7bd9a46..5a30caaec73e 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-python.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> > @@ -1701,7 +1701,7 @@ static void python_process_stat(struct perf_stat_=
config *config,
> >       struct perf_cpu_map *cpus =3D counter->core.cpus;
> >
> >       for (int thread =3D 0; thread < perf_thread_map__nr(threads); thr=
ead++) {
> > -             int idx;
> > +             unsigned int idx;
> >               struct perf_cpu cpu;
> >
> >               perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
> > diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> > index 4b465abfa36c..09de5288f9e1 100644
> > --- a/tools/perf/util/session.c
> > +++ b/tools/perf/util/session.c
> > @@ -2766,7 +2766,8 @@ struct evsel *perf_session__find_first_evtype(str=
uct perf_session *session,
> >  int perf_session__cpu_bitmap(struct perf_session *session,
> >                            const char *cpu_list, unsigned long *cpu_bit=
map)
> >  {
> > -     int i, err =3D -1;
> > +     unsigned int i;
> > +     int err =3D -1;
> >       struct perf_cpu_map *map;
> >       int nr_cpus =3D min(perf_session__env(session)->nr_cpus_avail, MA=
X_NR_CPUS);
> >       struct perf_cpu cpu;
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index dc2b66855f6c..993f4c4b8f44 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -897,7 +897,7 @@ static bool should_skip_zero_counter(struct perf_st=
at_config *config,
> >                                    const struct aggr_cpu_id *id)
> >  {
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       /*
> >        * Skip unsupported default events when not verbose. (default eve=
nts
> > @@ -1125,7 +1125,7 @@ static void print_no_aggr_metric(struct perf_stat=
_config *config,
> >                                struct evlist *evlist,
> >                                struct outstate *os)
> >  {
> > -     int all_idx;
> > +     unsigned int all_idx;
> >       struct perf_cpu cpu;
> >
> >       perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.user_reques=
ted_cpus) {
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 976a06e63252..14d169e22e8f 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -246,9 +246,11 @@ void evlist__reset_prev_raw_counts(struct evlist *=
evlist)
> >
> >  static void evsel__copy_prev_raw_counts(struct evsel *evsel)
> >  {
> > -     int idx, nthreads =3D perf_thread_map__nr(evsel->core.threads);
> > +     int nthreads =3D perf_thread_map__nr(evsel->core.threads);
> >
> >       for (int thread =3D 0; thread < nthreads; thread++) {
> > +             unsigned int idx;
> > +
> >               perf_cpu_map__for_each_idx(idx, evsel__cpus(evsel)) {
> >                       *perf_counts(evsel->counts, idx, thread) =3D
> >                               *perf_counts(evsel->prev_raw_counts, idx,=
 thread);
> > @@ -580,7 +582,7 @@ static void evsel__update_percore_stats(struct evse=
l *evsel, struct aggr_cpu_id
> >       struct perf_counts_values counts =3D { 0, };
> >       struct aggr_cpu_id id;
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       /* collect per-core counts */
> >       perf_cpu_map__for_each_cpu(cpu, idx, evsel->core.cpus) {
> > @@ -617,7 +619,7 @@ static void evsel__process_percore(struct evsel *ev=
sel)
> >       struct perf_stat_evsel *ps =3D evsel->stats;
> >       struct aggr_cpu_id core_id;
> >       struct perf_cpu cpu;
> > -     int idx;
> > +     unsigned int idx;
> >
> >       if (!evsel->percore)
> >               return;
> > diff --git a/tools/perf/util/svghelper.c b/tools/perf/util/svghelper.c
> > index b1d259f590e9..e360e7736c7b 100644
> > --- a/tools/perf/util/svghelper.c
> > +++ b/tools/perf/util/svghelper.c
> > @@ -726,7 +726,8 @@ static void scan_core_topology(int *map, struct top=
ology *t, int nr_cpus)
> >
> >  static int str_to_bitmap(char *s, cpumask_t *b, int nr_cpus)
> >  {
> > -     int idx, ret =3D 0;
> > +     unsigned int idx;
> > +     int ret =3D 0;
> >       struct perf_cpu_map *map;
> >       struct perf_cpu cpu;
> >
> > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > index bd811b2b7890..467517f4996a 100644
> > --- a/tools/perf/util/symbol.c
> > +++ b/tools/perf/util/symbol.c
> > @@ -2364,7 +2364,8 @@ static int setup_parallelism_bitmap(void)
> >  {
> >       struct perf_cpu_map *map;
> >       struct perf_cpu cpu;
> > -     int i, err =3D -1;
> > +     unsigned int i;
> > +     int err =3D -1;
> >
> >       if (symbol_conf.parallelism_list_str =3D=3D NULL)
> >               return 0;
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index ef79433ebc3a..912fd4414937 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -1261,7 +1261,7 @@ static void synthesize_cpus(struct synthesize_cpu=
_map_data *data)
> >
> >  static void synthesize_mask(struct synthesize_cpu_map_data *data)
> >  {
> > -     int idx;
> > +     unsigned int idx;
> >       struct perf_cpu cpu;
> >
> >       /* Due to padding, the 4bytes per entry mask variant is always sm=
aller. */
> > --
> > 2.53.0.851.ga537e3e6e9-goog
> >
