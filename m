Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DA3A935
	for <linux-perf-users@vger.kernel.org>; Sat,  1 Feb 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394778; cv=none; b=tJ7YGYvwP/zEGT330NHe20CKqkOWCvTN7WPJ1sCUCTU9vwONimqAlaERajOhAZdAMDXC53lI8L1EGDsRDtM2PXqf9yEHI+K1Dhrztgd204UMlI42Mtoa02yaEfePDs3yeyJeX5+2bTgqxLo9uCoMifiZ7vVO0yET/gkfo9UtQNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394778; c=relaxed/simple;
	bh=OzRFvH6dX3ZDYOR1kCoI/27ihgInrvKzLfxTrSJtCJQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mXc6GiX1fq6lKwpDj5QP2REELDIIvIlw0di7ntRqxfVp9qtC5MDliSTIpuq5g7j9aL8mhUkuDwCkgcv/OIVnWjVKbU6e+KpifESG/hHZVsG6+HJ3YOg+tPZn1AZQjSddZNS0GMINIUUFkF6A2pmsuUBoCmll4J/2n0NQukV6ijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbnb1/ar; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbnb1/ar"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so81325ab.0
        for <linux-perf-users@vger.kernel.org>; Fri, 31 Jan 2025 23:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738394774; x=1738999574; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rux43aa/DTem+yepz3mKs1gCKlwGfSPEvQiGocgr7AQ=;
        b=qbnb1/arXE4XrDonIZNxqvSMPDF4hUUQUrbkp/YzYvIJdNSR5bvT6KAMX5gWEZpGnX
         lSPZLHrim92rDHdLStISptStXLVblniE0efyl01RBpa8lXfImqU7ToftzLmWSHO87OYs
         +FhCEEFi3bczQx5JfuTV/r2/oQwpOhsEYHIYfpx7XYDsTJo+fGcuLz+ro2/UpzyYtq/U
         GwW3zl4AADoCiEpGgEck3OUbSGalvqdh4mJUv92rNiD663iUBagTH9gYHqIWd+nZj/0U
         M05N1jvoo63rDqW51B9coYgCc3eppDmvJHPYWumjc/fwlvgozhE21eiETKdOnbvNPZLA
         8JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738394774; x=1738999574;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rux43aa/DTem+yepz3mKs1gCKlwGfSPEvQiGocgr7AQ=;
        b=CBYcDdAawBf/FRHSkdNI6JHolKsOZPe+3BxI1haIERGVp5nM8XPdFAVt23oRs+ONbY
         jNeqGfy+bQWTbtwj7Yi3qX7Por22zn+cA9XsoGO8lr+oY/mX7Su/1JBHoAsPIZS4yRq7
         nSCAPPHNOosgpFfZkpA9K8Ycp+yF5DHNvuYQAQuF/AC/2A71UxblH2TByJJPmU6j1JgD
         0L/9dIqCbiGs6BgwQz/5BLPvm/H2G7c73Z+kOEDOlRGB+0uzgsepf3Kh1sfmlNVXeXft
         P4DaxfojH4BOArNoEI5LvjvYUnTG3UNeE+C9ugEqB51KYZRNDgMLbJLz4xtKxWqscyVr
         M51A==
X-Forwarded-Encrypted: i=1; AJvYcCXPGz4JpEzKfretK5x/gO4c41F41SoFk/YMq7zdNPeZBLp0w1UlB3TPw5wRiKWd4xcZ0HVWn/ByS2HkXIPpACNX@vger.kernel.org
X-Gm-Message-State: AOJu0YxO33QiVxQLJiJ2qA5X5nG3etP0kQpZbQ+JK6yg3H/sA0mV6pgz
	6BgMVOQL9KqRpBNTEYtIAMDtLa2pxLAkHdY3HIhUxLYmMcpCn5xvIneRzrfDd5/fB0DUVJczf60
	m/uO5+n/8NzXx1YWWVO//w09GMo/wdYqJ+ufQ
X-Gm-Gg: ASbGncuzSjoJy60lvii/9kyPjHZvCLTYcmdYUEcr5rYQzm6kToaxmMTEl6/DsWkpBMq
	/6VRu3ka9tlV5EgHTR/glPNi8uZLckIm3/czhqbdwhHVXaCGvEAvKB0kc2TUa17zv40MO/c1iQw
	==
X-Google-Smtp-Source: AGHT+IEDBdollJUgNSeH4FxdqnN1fjXQBSz3pqxWx9cxWDQky66sKbdbOod/UoGCyNvBa3LCKGHDSRxtLRW2F5dhnFw=
X-Received: by 2002:a05:6e02:1a48:b0:3a7:c962:95d1 with SMTP id
 e9e14a558f8ab-3d021f92aa0mr1290945ab.5.1738394773697; Fri, 31 Jan 2025
 23:26:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123074659.698123-1-irogers@google.com> <20250123074659.698123-3-irogers@google.com>
 <2763b783-c316-46e8-b4db-469d1ba55ac4@linux.intel.com>
In-Reply-To: <2763b783-c316-46e8-b4db-469d1ba55ac4@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 31 Jan 2025 23:26:02 -0800
X-Gm-Features: AWEUYZl1JQd9Z9f4tlbIeVkd3Oa4u1Fq8jhNEUf7qYUss8N5aYCbd1-RZYmEE8c
Message-ID: <CAP-5=fU2sGSS+OsKmn8C+Y7Msm-5qUFpotRc2rfgprhGpsroew@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] perf pmus: Restructure pmu_read_sysfs to scan
 fewer PMUs
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 11:24=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.=
com> wrote:
>
>
>
> On 2025-01-23 2:46 a.m., Ian Rogers wrote:
> > Rather than scanning core or all PMUs, allow pmu_read_sysfs to read
> > some combination of core, other, hwmon and tool PMUs. The PMUs that
> > should be read and are already read are held as bitmaps. It is known
> > that a "hwmon_" prefix is necessary for a hwmon PMU's name, similarly
> > with "tool", so only scan those PMUs in situations the PMU name or the
> > PMU's type number make sense to.
> >
> > The number of openat system calls reduces from 276 to 98 for a hwmon
> > event. The number of openats for regular perf events isn't changed.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/pmu.h  |   2 +
> >  tools/perf/util/pmus.c | 144 ++++++++++++++++++++++++++---------------
> >  2 files changed, 95 insertions(+), 51 deletions(-)
> >
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index dbed6c243a5e..edd36c20aedc 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -37,6 +37,8 @@ struct perf_pmu_caps {
> >  };
> >
> >  enum {
> > +     PERF_PMU_TYPE_PE_START    =3D 0,
> > +     PERF_PMU_TYPE_PE_END      =3D 0xFFFEFFFF,
> >       PERF_PMU_TYPE_HWMON_START =3D 0xFFFF0000,
> >       PERF_PMU_TYPE_HWMON_END   =3D 0xFFFFFFFD,
> >       PERF_PMU_TYPE_TOOL =3D 0xFFFFFFFE,
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index b493da0d22ef..3e3ffafcad71 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -37,10 +37,23 @@
> >   */
> >  static LIST_HEAD(core_pmus);
> >  static LIST_HEAD(other_pmus);
> > -static bool read_sysfs_core_pmus;
> > -static bool read_sysfs_all_pmus;
> > +enum perf_tool_pmu_type {
> > +     PERF_TOOL_PMU_TYPE_PE_CORE,
> > +#define PERF_TOOL_PMU_TYPE_PE_CORE_MASK (1 << PERF_TOOL_PMU_TYPE_PE_CO=
RE)
> > +     PERF_TOOL_PMU_TYPE_PE_OTHER,
>
> What is the PE short for?

Perf event, rather than type numbers being used for things like the fake PM=
U.

> The terminology "other" confused me at first glance.

Agreed. It corresponds to the other list immediately above this code.

> I think the PE_OTHER means the PMUs not core, hwmon or tool.
> There is a "other_pmus" nearby, which means the PMUs not core, but
> include hwmon and tool.
>
> Please add some comments to explain the scope of the TYPE_PE_OTHER.

This is already this immediately above:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/pmus.c?h=3Dperf-tools-next#n31
```
 * other_pmus: All other PMUs which are not part of core_pmus list. It does=
n't
*             matter whether PMU is present per SMT-thread or outside of th=
e
*             core in the hw. For e.g., an instance of AMD ibs_fetch// and
*             ibs_op// PMUs is present in each hw SMT thread, however they
*             are captured under other_pmus. PMUs belonging to other_pmus
*             must have pmu->is_core=3D0 but pmu->is_uncore could be 0 or 1=
.
```

> > +#define PERF_TOOL_PMU_TYPE_PE_OTHER_MASK (1 << PERF_TOOL_PMU_TYPE_PE_O=
THER)
> > +     PERF_TOOL_PMU_TYPE_TOOL,
> > +#define PERF_TOOL_PMU_TYPE_TOOL_MASK (1 << PERF_TOOL_PMU_TYPE_TOOL)
> > +     PERF_TOOL_PMU_TYPE_HWMON,
> > +#define PERF_TOOL_PMU_TYPE_HWMON_MASK (1 << PERF_TOOL_PMU_TYPE_HWMON)
> > +#define PERF_TOOL_PMU_TYPE_ALL_MASK (PERF_TOOL_PMU_TYPE_PE_CORE_MASK |=
       \
> > +                                     PERF_TOOL_PMU_TYPE_PE_OTHER_MASK =
| \
> > +                                     PERF_TOOL_PMU_TYPE_TOOL_MASK |  \
> > +                                     PERF_TOOL_PMU_TYPE_HWMON_MASK)
> > +};
>
> Nit: Maybe it's better to split the enum perf_tool_pmu_type and #define.
> It's a little bit hard for me to locate how many types there are at
> first glance.

Ok, will do in v3.

> > +static unsigned int read_pmu_types;
> >
> > -static void pmu_read_sysfs(bool core_only);
> > +static void pmu_read_sysfs(unsigned int to_read_pmus);
> >
> >  size_t pmu_name_len_no_suffix(const char *str)
> >  {
> > @@ -102,8 +115,7 @@ void perf_pmus__destroy(void)
> >
> >               perf_pmu__delete(pmu);
> >       }
> > -     read_sysfs_core_pmus =3D false;
> > -     read_sysfs_all_pmus =3D false;
> > +     read_pmu_types =3D 0;
> >  }
> >
> >  static struct perf_pmu *pmu_find(const char *name)
> > @@ -129,6 +141,7 @@ struct perf_pmu *perf_pmus__find(const char *name)
> >       struct perf_pmu *pmu;
> >       int dirfd;
> >       bool core_pmu;
> > +     unsigned int to_read_pmus =3D 0;
> >
> >       /*
> >        * Once PMU is loaded it stays in the list,
> > @@ -139,11 +152,11 @@ struct perf_pmu *perf_pmus__find(const char *name=
)
> >       if (pmu)
> >               return pmu;
> >
> > -     if (read_sysfs_all_pmus)
> > +     if (read_pmu_types =3D=3D PERF_TOOL_PMU_TYPE_ALL_MASK)
> >               return NULL;
> >
> >       core_pmu =3D is_pmu_core(name);
> > -     if (core_pmu && read_sysfs_core_pmus)
> > +     if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK=
))
> >               return NULL;
> >
> >       dirfd =3D perf_pmu__event_source_devices_fd();
> > @@ -151,15 +164,27 @@ struct perf_pmu *perf_pmus__find(const char *name=
)
> >                              /*eager_load=3D*/false);
> >       close(dirfd);
> >
> > -     if (!pmu) {
> > -             /*
> > -              * Looking up an inidividual PMU failed. This may mean na=
me is
> > -              * an alias, so read the PMUs from sysfs and try to find =
again.
> > -              */
> > -             pmu_read_sysfs(core_pmu);
> > +     if (pmu)
> > +             return pmu;
> > +
> > +     /* Looking up an individual perf event PMU failed, check if a too=
l PMU should be read. */
> > +     if (!strncmp(name, "hwmon_", 6))
> > +             to_read_pmus |=3D PERF_TOOL_PMU_TYPE_HWMON_MASK;
> > +     else if (!strcmp(name, "tool"))
> > +             to_read_pmus |=3D PERF_TOOL_PMU_TYPE_TOOL_MASK;
> > +
> > +     if (to_read_pmus) {
> > +             pmu_read_sysfs(to_read_pmus);
> >               pmu =3D pmu_find(name);
> > +             if (pmu)
> > +                     return pmu;
> >       }
> > -     return pmu;
> > +     /* Read all necessary PMUs from sysfs and see if the PMU is found=
. */
> > +     to_read_pmus =3D PERF_TOOL_PMU_TYPE_PE_CORE_MASK;
> > +     if (!core_pmu)
> > +             to_read_pmus |=3D PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> > +     pmu_read_sysfs(to_read_pmus);
> > +     return pmu_find(name);
> >  }
> >
> >  static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
> > @@ -176,11 +201,11 @@ static struct perf_pmu *perf_pmu__find2(int dirfd=
, const char *name)
> >       if (pmu)
> >               return pmu;
> >
> > -     if (read_sysfs_all_pmus)
> > +     if (read_pmu_types =3D=3D PERF_TOOL_PMU_TYPE_ALL_MASK)
> >               return NULL;
> >
> >       core_pmu =3D is_pmu_core(name);
> > -     if (core_pmu && read_sysfs_core_pmus)
> > +     if (core_pmu && (read_pmu_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK=
))
> >               return NULL;
> >
> >       return perf_pmu__lookup(core_pmu ? &core_pmus : &other_pmus, dirf=
d, name,
> > @@ -197,52 +222,60 @@ static int pmus_cmp(void *priv __maybe_unused,
> >  }
> >
> >  /* Add all pmus in sysfs to pmu list: */
> > -static void pmu_read_sysfs(bool core_only)
> > +static void pmu_read_sysfs(unsigned int to_read_types)
> >  {
> > -     int fd;
> > -     DIR *dir;
> > -     struct dirent *dent;
> >       struct perf_pmu *tool_pmu;
> >
> > -     if (read_sysfs_all_pmus || (core_only && read_sysfs_core_pmus))
> > +     if ((read_pmu_types & to_read_types) =3D=3D to_read_types) {
> > +             /* All requested PMU types have been read. */
> >               return;
> > +     }
> >
> > -     fd =3D perf_pmu__event_source_devices_fd();
> > -     if (fd < 0)
> > -             return;
> > +     if (to_read_types & (PERF_TOOL_PMU_TYPE_PE_CORE_MASK | PERF_TOOL_=
PMU_TYPE_PE_OTHER_MASK)) {
> > +             int fd =3D perf_pmu__event_source_devices_fd();
> > +             DIR *dir;
> > +             struct dirent *dent;
> > +             bool core_only =3D (to_read_types & PERF_TOOL_PMU_TYPE_PE=
_OTHER_MASK) =3D=3D 0;
> >
> > -     dir =3D fdopendir(fd);
> > -     if (!dir) {
> > -             close(fd);
> > -             return;
> > -     }
> > +             if (fd < 0)
> > +                     goto skip_pe_pmus;
> >
> > -     while ((dent =3D readdir(dir))) {
> > -             if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, "=
.."))
> > -                     continue;
> > -             if (core_only && !is_pmu_core(dent->d_name))
> > -                     continue;
> > -             /* add to static LIST_HEAD(core_pmus) or LIST_HEAD(other_=
pmus): */
> > -             perf_pmu__find2(fd, dent->d_name);
> > -     }
> > +             dir =3D fdopendir(fd);
> > +             if (!dir) {
> > +                     close(fd);
> > +                     goto skip_pe_pmus;
> > +             }
> >
> > -     closedir(dir);
> > -     if (list_empty(&core_pmus)) {
> > +             while ((dent =3D readdir(dir))) {
> > +                     if (!strcmp(dent->d_name, ".") || !strcmp(dent->d=
_name, ".."))
> > +                             continue;
> > +                     if (core_only && !is_pmu_core(dent->d_name))
> > +                             continue;
> > +                     /* add to static LIST_HEAD(core_pmus) or LIST_HEA=
D(other_pmus): */
> > +                     perf_pmu__find2(fd, dent->d_name);
> > +             }
> > +
> > +             closedir(dir);
> > +     }
> > +skip_pe_pmus:
> > +     if ((to_read_types & PERF_TOOL_PMU_TYPE_PE_CORE_MASK) && list_emp=
ty(&core_pmus)) {
> >               if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
> >                       pr_err("Failure to set up any core PMUs\n");
> >       }
> >       list_sort(NULL, &core_pmus, pmus_cmp);
> > -     if (!core_only) {
> > +
> > +     if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) !=3D 0 &&
> > +         (read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) =3D=3D 0) {
>
> Nit: Maybe
>
>         if ((to_read_types & PERF_TOOL_PMU_TYPE_TOOL_MASK) &&
>             !(read_pmu_types & PERF_TOOL_PMU_TYPE_TOOL_MASK))

Thanks. I'm not convinced on the readability, which was why I was
being a bit more verbose in what I wrote. I worrited the & reads like
an && and the ! is hard to miss.

Thanks,
Ian

> >               tool_pmu =3D perf_pmus__tool_pmu();
> >               list_add_tail(&tool_pmu->list, &other_pmus);
> > -             perf_pmus__read_hwmon_pmus(&other_pmus);
> >       }
> > +     if ((to_read_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) !=3D 0 &&
> > +         (read_pmu_types & PERF_TOOL_PMU_TYPE_HWMON_MASK) =3D=3D 0)
>
> ditto
>
> Thanks,
> Kan
> > +             perf_pmus__read_hwmon_pmus(&other_pmus);
> > +
> >       list_sort(NULL, &other_pmus, pmus_cmp);
> > -     if (!list_empty(&core_pmus)) {
> > -             read_sysfs_core_pmus =3D true;
> > -             if (!core_only)
> > -                     read_sysfs_all_pmus =3D true;
> > -     }
> > +
> > +     read_pmu_types |=3D to_read_types;
> >  }
> >
> >  static struct perf_pmu *__perf_pmus__find_by_type(unsigned int type)
> > @@ -263,12 +296,21 @@ static struct perf_pmu *__perf_pmus__find_by_type=
(unsigned int type)
> >
> >  struct perf_pmu *perf_pmus__find_by_type(unsigned int type)
> >  {
> > +     unsigned int to_read_pmus;
> >       struct perf_pmu *pmu =3D __perf_pmus__find_by_type(type);
> >
> > -     if (pmu || read_sysfs_all_pmus)
> > +     if (pmu || (read_pmu_types =3D=3D PERF_TOOL_PMU_TYPE_ALL_MASK))
> >               return pmu;
> >
> > -     pmu_read_sysfs(/*core_only=3D*/false);
> > +     if (type >=3D PERF_PMU_TYPE_PE_START && type <=3D PERF_PMU_TYPE_P=
E_END) {
> > +             to_read_pmus =3D PERF_TOOL_PMU_TYPE_PE_CORE_MASK |
> > +                     PERF_TOOL_PMU_TYPE_PE_OTHER_MASK;
> > +     } else if (type >=3D PERF_PMU_TYPE_HWMON_START && type <=3D PERF_=
PMU_TYPE_HWMON_END) {
> > +             to_read_pmus =3D PERF_TOOL_PMU_TYPE_HWMON_MASK;
> > +     } else {
> > +             to_read_pmus =3D PERF_TOOL_PMU_TYPE_TOOL_MASK;
> > +     }
> > +     pmu_read_sysfs(to_read_pmus);
> >       pmu =3D __perf_pmus__find_by_type(type);
> >       return pmu;
> >  }
> > @@ -282,7 +324,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *p=
mu)
> >       bool use_core_pmus =3D !pmu || pmu->is_core;
> >
> >       if (!pmu) {
> > -             pmu_read_sysfs(/*core_only=3D*/false);
> > +             pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
> >               pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> >       }
> >       if (use_core_pmus) {
> > @@ -300,7 +342,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *p=
mu)
> >  struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
> >  {
> >       if (!pmu) {
> > -             pmu_read_sysfs(/*core_only=3D*/true);
> > +             pmu_read_sysfs(PERF_TOOL_PMU_TYPE_PE_CORE_MASK);
> >               return list_first_entry_or_null(&core_pmus, typeof(*pmu),=
 list);
> >       }
> >       list_for_each_entry_continue(pmu, &core_pmus, list)
> > @@ -316,7 +358,7 @@ static struct perf_pmu *perf_pmus__scan_skip_duplic=
ates(struct perf_pmu *pmu)
> >       const char *last_pmu_name =3D (pmu && pmu->name) ? pmu->name : ""=
;
> >
> >       if (!pmu) {
> > -             pmu_read_sysfs(/*core_only=3D*/false);
> > +             pmu_read_sysfs(PERF_TOOL_PMU_TYPE_ALL_MASK);
> >               pmu =3D list_prepare_entry(pmu, &core_pmus, list);
> >       } else
> >               last_pmu_name_len =3D pmu_name_len_no_suffix(pmu->name ?:=
 "");
>
