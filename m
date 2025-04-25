Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9182040A8
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 18:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745606817; cv=none; b=Fd2jhL2lft7blD0vAK8EYjvKWWYjnXP1BNEllc+oygSPxdrpKXxN4uijGapF/4KB/PUIQZBt1exUZSMNzcl9WVfhtG8z17xjzUsRMYyeUvH+02A74GPmMiGqWVNuAp6Ln66yXfXktzeFNivdbo4C+MeXuSQiLwGxJSU8JDV56mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745606817; c=relaxed/simple;
	bh=4fOSyc0szY3l9eE0DnGjcpYao22vp3HCivsfW5/8YEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wjrd+HEIJKGGcrAEj8bNumkXY7g+Y9roTVWnaxUbkNKCqUXrJwhw51rYDUdFjG36wFBB1gJG501YnigqqTmGUSc/O/lkl4qCSjmRom/sTZHvQaf8VqGzCdBLZyhexHUctWDMT5jKz4MvfuOupDLzh/uuJ+AeGwBDyGo2rRUrLbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e4dFCaGq; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e4dFCaGq"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d91a45d148so18635ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Apr 2025 11:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745606812; x=1746211612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2SgAnX6JQ0l39jsBpyHzdUYJgOEASVqPMnGwWB6/JA=;
        b=e4dFCaGq5ginsr5KRA6vKa4U8M4HuMLA0fyU1mbGIXqTmTpgjhLFDl3TDRoKoLBFHc
         XHX4DAcswIrZBiAl4F4kZfcKJOUK2kxVjNxkCvlnHdi5GIcInxcFqQf5H1UQXAV+/uaL
         OlaTZzoYGwnaWxQyK/ry/H7K4FRvibXhW/ucjKFrkhFm54PTLG4wN8wR9B0cjS7VqRax
         ARFJeJmPCIaZ8HecLv5vmoWiGxjKeKmfOgcsLGnO2TYGLcZWCuuVXvdRCs9D9ioi5zWd
         mbrSPOGqeAT68O+unUVcnB4smodjXwa/RqQjXuDPTmhOlPSJwxdQfMPHWNCi41qochdg
         EYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745606812; x=1746211612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2SgAnX6JQ0l39jsBpyHzdUYJgOEASVqPMnGwWB6/JA=;
        b=I7hSYtd+Lx+dLInGfoes4dSEZcrShtugGEoHjBbbZzhL4SbMO/8MVLevDzta1g7nlV
         4fujxqiuPWecSQgVH8HnK2HKiv3CpX/SzWhnDhx0F6OovmUcoJwiTM6iEm7jvxt3LQOs
         Kz74dmQ/ZRBWb/o4mna8AqeSpFyyXtFr4ia3Oh3CVm9QZXUaU3EY1D7qJK/Z8DQQdIHb
         qr/ud7RV2k2j7c0l7IuJDMN+0TtRW/sTTs/CCrOoHH4eM50F1ow34STA74kVfKfMvNZi
         6DPSXJu0cEFWadqAL7FwEIG9gVfCGeDLgaTtGDp45vmPa26j5q1W3vQ4YavCL3eouYcl
         DDPg==
X-Forwarded-Encrypted: i=1; AJvYcCXBlS+3UtrEjkdW4QspzSePHL9frmHtZT4lOp6xq2yeFIKBYV1XcKuYkdnUAFUIeR3gVgnB5uOwfsefIaze3PzR@vger.kernel.org
X-Gm-Message-State: AOJu0YwErC7AL4oamp//Vft5m61e9pJM4x/3LfVDk9C/BDhoh6C0yfJn
	nxd5KcWut/lBvOz42aUsYl6TnWe6hoEyuBhqYiHyLeQe925zWtDL03jTOnqhcHaD9wTrLI7H/DP
	oOAQC9EUToJ0gG6LmtnqmgZ+WYaEvDp+hg1t0
X-Gm-Gg: ASbGncskWhsZNIHMEYpULGhOghHru9TYRduwJHLImUX6/xBVnHerxn6xfbvO/DKKu0d
	AfYgNg85UWY5Uj/+QWWD8rP4z6U6fEmel7EiQ7xqHhBytL4N5ELaD/Z0Rmi6bH8Yq+koed7HtZp
	gpDNPSN9Hln0IgsB8LhA2t7j1zacTXKn834A==
X-Google-Smtp-Source: AGHT+IFyUE6L5+sRdgcxmoduWEfIHDDCvWHYCd3f1uVuiwOwK5YIf11OWbGLpK/L6oFDjQZcaAdUlt2AAGFT+3uFYXk=
X-Received: by 2002:a92:6905:0:b0:3d3:f16a:545f with SMTP id
 e9e14a558f8ab-3d943a1f18dmr260935ab.19.1745606811877; Fri, 25 Apr 2025
 11:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424195831.1767457-1-irogers@google.com> <20250424195831.1767457-8-irogers@google.com>
 <aAvDStpWjwC7grya@google.com>
In-Reply-To: <aAvDStpWjwC7grya@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Apr 2025 11:46:40 -0700
X-Gm-Features: ATxdqUHHOwUHA5pu9quzmnCCuluz3deDSnFP2oQvWNBf9H0mDDNh8kURztBUu28
Message-ID: <CAP-5=fXcTssH=bGQLDmPeT=fGf270B1-ocsP2Y7EP_RV=M838A@mail.gmail.com>
Subject: Re: [PATCH v2 7/8] perf dso: Move build_id to dso_id
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	James Clark <james.clark@linaro.org>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	=?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Martin Liska <martin.liska@hey.com>, 
	=?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>, 
	Song Liu <song@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 10:15=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hi Ian,
>
> On Thu, Apr 24, 2025 at 12:58:30PM -0700, Ian Rogers wrote:
> > The dso_id previously contained the major, minor, inode and inode
> > generation information from a mmap2 event - the inode generation would
> > be zero when reading from /proc/pid/maps. The build_id was in the
> > dso. With build ID mmap2 events these fields wouldn't be initialized
> > which would largely mean the special empty case where any dso would
> > match for equality. This isn't desirable as if a dso is replaced we
> > want the comparison to yield a difference.
> >
> > To support detecting the difference between DSOs based on build_id,
> > move the build_id out of the DSO and into the dso_id. The dso_id is
> > also stored in the DSO so nothing is lost. Capture in the dso_id what
> > parts have been initialized and rename dso_id__inject to
> > dso_id__improve_id so that it is clear the dso_id is being improved
> > upon with additional information. With the build_id in the dso_id, use
> > memcmp to compare for equality.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-buildid-list.c       |   2 +-
> >  tools/perf/builtin-inject.c             |  32 ++++---
> >  tools/perf/builtin-report.c             |  11 ++-
> >  tools/perf/include/perf/perf_dlfilter.h |   2 +-
> >  tools/perf/tests/symbols.c              |   4 +-
> >  tools/perf/util/build-id.c              |   4 +-
> >  tools/perf/util/dso.c                   | 109 +++++++++++++-----------
> >  tools/perf/util/dso.h                   |  75 ++++++++--------
> >  tools/perf/util/dsos.c                  |  18 ++--
> >  tools/perf/util/machine.c               |  28 +++---
> >  tools/perf/util/map.c                   |  13 ++-
> >  tools/perf/util/map.h                   |   5 +-
> >  tools/perf/util/sort.c                  |  27 +++---
> >  tools/perf/util/synthetic-events.c      |  18 ++--
> >  14 files changed, 194 insertions(+), 154 deletions(-)
> >
> > diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-bui=
ldid-list.c
> > index ba8ba0303920..151cd84b6dfe 100644
> > --- a/tools/perf/builtin-buildid-list.c
> > +++ b/tools/perf/builtin-buildid-list.c
> > @@ -31,7 +31,7 @@ static int buildid__map_cb(struct map *map, void *arg=
 __maybe_unused)
> >
> >       memset(bid_buf, 0, sizeof(bid_buf));
> >       if (dso__has_build_id(dso))
> > -             build_id__snprintf(dso__bid_const(dso), bid_buf, sizeof(b=
id_buf));
> > +             build_id__snprintf(dso__bid(dso), bid_buf, sizeof(bid_buf=
));
>
> Can you please split this kind of interface changes?

Agreed. Done in this case as DSO is changed removing bid, a
convenience routine that only gives a const access to the dso_id was
added. The whole purpose of the change is moving bid to the dso_id,
and so an interim dso_bid_const -> dso_bid change would (1) not match
the dso code at that time (2) add to the churn in what is a small-ish
change.

> >       printf("%s %16" PRIx64 " %16" PRIx64, bid_buf, map__start(map), m=
ap__end(map));
> >       if (dso_long_name !=3D NULL)
> >               printf(" %s", dso_long_name);
> > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> > index 11e49cafa3af..e74a3a70ff6f 100644
> > --- a/tools/perf/builtin-inject.c
> > +++ b/tools/perf/builtin-inject.c
> > @@ -587,15 +587,17 @@ static int perf_event__repipe_mmap2(const struct =
perf_tool *tool,
> >                               struct perf_sample *sample,
> >                               struct machine *machine)
> >  {
> > -     struct dso_id id;
> > -     struct dso_id *dso_id =3D NULL;
> > +     struct dso_id id =3D dso_id_empty;
> >
> > -     if (!(event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID)) {
> > +     if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
> > +             build_id__init(&id.build_id, event->mmap2.build_id, event=
->mmap2.build_id_size);
> > +     } else {
> >               id.maj =3D event->mmap2.maj;
> >               id.min =3D event->mmap2.min;
> >               id.ino =3D event->mmap2.ino;
> >               id.ino_generation =3D event->mmap2.ino_generation;
> > -             dso_id =3D &id;
> > +             id.mmap2_valid =3D true;
> > +             id.mmap2_ino_generation_valid =3D true;
> >       }
> >
> >       return perf_event__repipe_common_mmap(
> > @@ -603,7 +605,7 @@ static int perf_event__repipe_mmap2(const struct pe=
rf_tool *tool,
> >               event->mmap2.pid, event->mmap2.tid,
> >               event->mmap2.start, event->mmap2.len, event->mmap2.pgoff,
> >               event->mmap2.flags, event->mmap2.prot,
> > -             event->mmap2.filename, dso_id,
> > +             event->mmap2.filename, &id,
> >               perf_event__process_mmap2);
> >  }
> >
> > @@ -671,19 +673,20 @@ static int perf_event__repipe_tracing_data(struct=
 perf_session *session,
> >  static int dso__read_build_id(struct dso *dso)
> >  {
> >       struct nscookie nsc;
> > +     struct build_id bid;
> >
> >       if (dso__has_build_id(dso))
> >               return 0;
> >
> >       mutex_lock(dso__lock(dso));
> >       nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> > -     if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) >=
 0)
> > -             dso__set_has_build_id(dso);
> > +     if (filename__read_build_id(dso__long_name(dso), &bid) > 0)
> > +             dso__set_build_id(dso, &bid);
> >       else if (dso__nsinfo(dso)) {
> >               char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
> >
> > -             if (new_name && filename__read_build_id(new_name, dso__bi=
d(dso)) > 0)
> > -                     dso__set_has_build_id(dso);
> > +             if (new_name && filename__read_build_id(new_name, &bid) >=
 0)
> > +                     dso__set_build_id(dso, &bid);
> >               free(new_name);
> >       }
> >       nsinfo__mountns_exit(&nsc);
> > @@ -732,10 +735,11 @@ static bool perf_inject__lookup_known_build_id(st=
ruct perf_inject *inject,
> >                                              struct dso *dso)
> >  {
> >       struct str_node *pos;
> > -     int bid_len;
> > +     struct build_id bid;
> >
> >       strlist__for_each_entry(pos, inject->known_build_ids) {
> >               const char *build_id, *dso_name;
> > +             int bid_len;
> >
> >               build_id =3D skip_spaces(pos->s);
> >               dso_name =3D strchr(build_id, ' ');
> > @@ -744,11 +748,11 @@ static bool perf_inject__lookup_known_build_id(st=
ruct perf_inject *inject,
> >               if (strcmp(dso__long_name(dso), dso_name))
> >                       continue;
> >               for (int ix =3D 0; 2 * ix + 1 < bid_len; ++ix) {
> > -                     dso__bid(dso)->data[ix] =3D (hex(build_id[2 * ix]=
) << 4 |
> > -                                               hex(build_id[2 * ix + 1=
]));
> > +                     bid.data[ix] =3D (hex(build_id[2 * ix]) << 4 |
> > +                                     hex(build_id[2 * ix + 1]));
> >               }
> > -             dso__bid(dso)->size =3D bid_len / 2;
> > -             dso__set_has_build_id(dso);
> > +             bid.size =3D bid_len / 2;
> > +             dso__set_build_id(dso, &bid);
> >               return true;
> >       }
> >       return false;
> > diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> > index f0299c7ee025..98b1f73c28da 100644
> > --- a/tools/perf/builtin-report.c
> > +++ b/tools/perf/builtin-report.c
> > @@ -858,17 +858,24 @@ static int maps__fprintf_task_cb(struct map *map,=
 void *data)
> >       struct maps__fprintf_task_args *args =3D data;
> >       const struct dso *dso =3D map__dso(map);
> >       u32 prot =3D map__prot(map);
> > +     const struct dso_id *dso_id =3D dso__id_const(dso);
> >       int ret;
> > +     char buf[SBUILD_ID_SIZE];
> > +
> > +     if (dso_id->mmap2_valid)
> > +             snprintf(buf, sizeof(buf), "%" PRIu64, dso_id->ino);
> > +     else
> > +             build_id__snprintf(&dso_id->build_id, buf, sizeof(buf));
> >
> >       ret =3D fprintf(args->fp,
> > -             "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %" P=
RIu64 " %s\n",
> > +             "%*s  %" PRIx64 "-%" PRIx64 " %c%c%c%c %08" PRIx64 " %s %=
s\n",
> >               args->indent, "", map__start(map), map__end(map),
> >               prot & PROT_READ ? 'r' : '-',
> >               prot & PROT_WRITE ? 'w' : '-',
> >               prot & PROT_EXEC ? 'x' : '-',
> >               map__flags(map) ? 's' : 'p',
> >               map__pgoff(map),
> > -             dso__id_const(dso)->ino, dso__name(dso));
> > +             buf, dso__name(dso));
> >
> >       if (ret < 0)
> >               return ret;
> > diff --git a/tools/perf/include/perf/perf_dlfilter.h b/tools/perf/inclu=
de/perf/perf_dlfilter.h
> > index 16fc4568ac53..2d3540ed3c58 100644
> > --- a/tools/perf/include/perf/perf_dlfilter.h
> > +++ b/tools/perf/include/perf/perf_dlfilter.h
> > @@ -87,7 +87,7 @@ struct perf_dlfilter_al {
> >       __u8  is_64_bit; /* Only valid if dso is not NULL */
> >       __u8  is_kernel_ip; /* True if in kernel space */
> >       __u32 buildid_size;
> > -     __u8 *buildid;
> > +     const __u8 *buildid;
> >       /* Below members are only populated by resolve_ip() */
> >       __u8 filtered; /* True if this sample event will be filtered out =
*/
> >       const char *comm;
> > diff --git a/tools/perf/tests/symbols.c b/tools/perf/tests/symbols.c
> > index ee20a366f32f..b07fdf831868 100644
> > --- a/tools/perf/tests/symbols.c
> > +++ b/tools/perf/tests/symbols.c
> > @@ -96,8 +96,8 @@ static int create_map(struct test_info *ti, char *fil=
ename, struct map **map_p)
> >       dso__put(dso);
> >
> >       /* Create a dummy map at 0x100000 */
> > -     *map_p =3D map__new(ti->machine, 0x100000, 0xffffffff, 0, NULL,
> > -                       PROT_EXEC, 0, NULL, filename, ti->thread);
> > +     *map_p =3D map__new(ti->machine, 0x100000, 0xffffffff, 0, &dso_id=
_empty,
> > +                       PROT_EXEC, /*flags=3D*/0, filename, ti->thread)=
;
> >       if (!*map_p) {
> >               pr_debug("Failed to create map!");
> >               return TEST_FAIL;
> > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > index 3386fa8e1e7e..b8d784120f20 100644
> > --- a/tools/perf/util/build-id.c
> > +++ b/tools/perf/util/build-id.c
> > @@ -251,7 +251,7 @@ char *__dso__build_id_filename(const struct dso *ds=
o, char *bf, size_t size,
> >       if (!dso__has_build_id(dso))
> >               return NULL;
> >
> > -     build_id__snprintf(dso__bid_const(dso), sbuild_id, sizeof(sbuild_=
id));
> > +     build_id__snprintf(dso__bid(dso), sbuild_id, sizeof(sbuild_id));
> >       linkname =3D build_id_cache__linkname(sbuild_id, NULL, 0);
> >       if (!linkname)
> >               return NULL;
> > @@ -334,7 +334,7 @@ static int machine__write_buildid_table_cb(struct d=
so *dso, void *data)
> >       }
> >
> >       in_kernel =3D dso__kernel(dso) || is_kernel_module(name, PERF_REC=
ORD_MISC_CPUMODE_UNKNOWN);
> > -     return write_buildid(name, name_len, dso__bid(dso), args->machine=
->pid,
> > +     return write_buildid(name, name_len, &dso__id(dso)->build_id, arg=
s->machine->pid,
> >                            in_kernel ? args->kmisc : args->umisc, args-=
>fd);
> >  }
> >
> > diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> > index 776506b93b8b..493750142de7 100644
> > --- a/tools/perf/util/dso.c
> > +++ b/tools/perf/util/dso.c
> > @@ -217,7 +217,7 @@ int dso__read_binary_type_filename(const struct dso=
 *dso,
> >                       break;
> >               }
> >
> > -             build_id__snprintf(dso__bid_const(dso), build_id_hex, siz=
eof(build_id_hex));
> > +             build_id__snprintf(dso__bid(dso), build_id_hex, sizeof(bu=
ild_id_hex));
> >               len =3D __symbol__join_symfs(filename, size, "/usr/lib/de=
bug/.build-id/");
> >               snprintf(filename + len, size - len, "%.2s/%s.debug",
> >                        build_id_hex, build_id_hex + 2);
> > @@ -1379,64 +1379,76 @@ static void dso__set_long_name_id(struct dso *d=
so, const char *name, bool name_a
> >
> >  static int __dso_id__cmp(const struct dso_id *a, const struct dso_id *=
b)
> >  {
> > -     if (a->maj > b->maj) return -1;
> > -     if (a->maj < b->maj) return 1;
> > +     if (a->mmap2_valid && b->mmap2_valid) {
> > +             if (a->maj > b->maj) return -1;
> > +             if (a->maj < b->maj) return 1;
> >
> > -     if (a->min > b->min) return -1;
> > -     if (a->min < b->min) return 1;
> > +             if (a->min > b->min) return -1;
> > +             if (a->min < b->min) return 1;
> >
> > -     if (a->ino > b->ino) return -1;
> > -     if (a->ino < b->ino) return 1;
> > -
> > -     /*
> > -      * Synthesized MMAP events have zero ino_generation, avoid compar=
ing
> > -      * them with MMAP events with actual ino_generation.
> > -      *
> > -      * I found it harmful because the mismatch resulted in a new
> > -      * dso that did not have a build ID whereas the original dso did =
have a
> > -      * build ID. The build ID was essential because the object was no=
t found
> > -      * otherwise. - Adrian
> > -      */
> > -     if (a->ino_generation && b->ino_generation) {
> > +             if (a->ino > b->ino) return -1;
> > +             if (a->ino < b->ino) return 1;
> > +     }
> > +     if (a->mmap2_ino_generation_valid && b->mmap2_ino_generation_vali=
d) {
> >               if (a->ino_generation > b->ino_generation) return -1;
> >               if (a->ino_generation < b->ino_generation) return 1;
> >       }
> > -
> > +     if (build_id__is_defined(&a->build_id) && build_id__is_defined(&b=
->build_id)) {
> > +             if (a->build_id.size !=3D b->build_id.size)
> > +                     return a->build_id.size < b->build_id.size ? -1 :=
 1;
> > +             return memcmp(a->build_id.data, b->build_id.data, a->buil=
d_id.size);
> > +     }
> >       return 0;
> >  }
> >
> > -bool dso_id__empty(const struct dso_id *id)
> > -{
> > -     if (!id)
> > -             return true;
> > -
> > -     return !id->maj && !id->min && !id->ino && !id->ino_generation;
> > -}
> > +const struct dso_id dso_id_empty =3D {
> > +     {
> > +             .maj =3D 0,
> > +             .min =3D 0,
> > +             .ino =3D 0,
> > +             .ino_generation =3D 0,
> > +     },
> > +     .mmap2_valid =3D false,
> > +     .mmap2_ino_generation_valid =3D false,
> > +     {
> > +             .size =3D 0,
> > +     }
> > +};
> >
> > -void __dso__inject_id(struct dso *dso, const struct dso_id *id)
> > +void __dso__improve_id(struct dso *dso, const struct dso_id *id)
> >  {
> >       struct dsos *dsos =3D dso__dsos(dso);
> >       struct dso_id *dso_id =3D dso__id(dso);
> > +     bool changed =3D false;
> >
> >       /* dsos write lock held by caller. */
> >
> > -     dso_id->maj =3D id->maj;
> > -     dso_id->min =3D id->min;
> > -     dso_id->ino =3D id->ino;
> > -     dso_id->ino_generation =3D id->ino_generation;
> > -
> > -     if (dsos)
> > +     if (id->mmap2_valid && !dso_id->mmap2_valid) {
> > +             dso_id->maj =3D id->maj;
> > +             dso_id->min =3D id->min;
> > +             dso_id->ino =3D id->ino;
> > +             dso_id->mmap2_valid =3D true;
> > +             changed =3D true;
> > +     }
> > +     if (id->mmap2_ino_generation_valid && !dso_id->mmap2_ino_generati=
on_valid) {
> > +             dso_id->ino_generation =3D id->ino_generation;
> > +             dso_id->mmap2_ino_generation_valid =3D true;
> > +             changed =3D true;
> > +     }
> > +     if (build_id__is_defined(&id->build_id) && !build_id__is_defined(=
&dso_id->build_id)) {
> > +             dso_id->build_id =3D id->build_id;
> > +             changed =3D true;
> > +     }
> > +     if (changed && dsos)
> >               dsos->sorted =3D false;
> >  }
> >
> >  int dso_id__cmp(const struct dso_id *a, const struct dso_id *b)
> >  {
> > -     /*
> > -      * The second is always dso->id, so zeroes if not set, assume pas=
sing
> > -      * NULL for a means a zeroed id
> > -      */
> > -     if (dso_id__empty(a) || dso_id__empty(b))
> > +     if (a =3D=3D &dso_id_empty || b =3D=3D &dso_id_empty) {
> > +             /* There is no valid data to compare so the comparison al=
ways returns identical. */
> >               return 0;
> > +     }
> >
> >       return __dso_id__cmp(a, b);
> >  }
> > @@ -1533,7 +1545,6 @@ struct dso *dso__new_id(const char *name, const s=
truct dso_id *id)
> >               dso->loaded =3D 0;
> >               dso->rel =3D 0;
> >               dso->sorted_by_name =3D 0;
> > -             dso->has_build_id =3D 0;
> >               dso->has_srcline =3D 1;
> >               dso->a2l_fails =3D 1;
> >               dso->kernel =3D DSO_SPACE__USER;
> > @@ -1638,15 +1649,14 @@ int dso__swap_init(struct dso *dso, unsigned ch=
ar eidata)
> >       return 0;
> >  }
> >
> > -void dso__set_build_id(struct dso *dso, struct build_id *bid)
> > +void dso__set_build_id(struct dso *dso, const struct build_id *bid)
> >  {
> > -     RC_CHK_ACCESS(dso)->bid =3D *bid;
> > -     RC_CHK_ACCESS(dso)->has_build_id =3D 1;
> > +     dso__id(dso)->build_id =3D *bid;
> >  }
> >
> > -bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
> > +bool dso__build_id_equal(const struct dso *dso, const struct build_id =
*bid)
> >  {
> > -     const struct build_id *dso_bid =3D dso__bid_const(dso);
> > +     const struct build_id *dso_bid =3D dso__bid(dso);
> >
> >       if (dso_bid->size > bid->size && dso_bid->size =3D=3D BUILD_ID_SI=
ZE) {
> >               /*
> > @@ -1665,18 +1675,20 @@ bool dso__build_id_equal(const struct dso *dso,=
 struct build_id *bid)
> >  void dso__read_running_kernel_build_id(struct dso *dso, struct machine=
 *machine)
> >  {
> >       char path[PATH_MAX];
> > +     struct build_id bid;
> >
> >       if (machine__is_default_guest(machine))
> >               return;
> >       sprintf(path, "%s/sys/kernel/notes", machine->root_dir);
> > -     if (sysfs__read_build_id(path, dso__bid(dso)) =3D=3D 0)
> > -             dso__set_has_build_id(dso);
> > +     sysfs__read_build_id(path, &bid);
> > +     dso__set_build_id(dso, &bid);
>
> Why not check the return value anymore?

Checking the return value was a mistake. For example if we have
libc.so with a build ID and then it is replaced with a libc.so without
a build ID then build ID wouldn't be updated previously as reading the
build ID had failed - no value found.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >  }
> >
> >  int dso__kernel_module_get_build_id(struct dso *dso,
> >                                   const char *root_dir)
> >  {
> >       char filename[PATH_MAX];
> > +     struct build_id bid;
> >       /*
> >        * kernel module short names are of the form "[module]" and
> >        * we need just "module" here.
> > @@ -1687,9 +1699,8 @@ int dso__kernel_module_get_build_id(struct dso *d=
so,
> >                "%s/sys/module/%.*s/notes/.note.gnu.build-id",
> >                root_dir, (int)strlen(name) - 1, name);
> >
> > -     if (sysfs__read_build_id(filename, dso__bid(dso)) =3D=3D 0)
> > -             dso__set_has_build_id(dso);
> > -
> > +     sysfs__read_build_id(filename, &bid);
> > +     dso__set_build_id(dso, &bid);
> >       return 0;
> >  }
> >
> > diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> > index c87564471f9b..3457d713d3c5 100644
> > --- a/tools/perf/util/dso.h
> > +++ b/tools/perf/util/dso.h
> > @@ -185,14 +185,33 @@ enum dso_load_errno {
> >  #define DSO__DATA_CACHE_SIZE 4096
> >  #define DSO__DATA_CACHE_MASK ~(DSO__DATA_CACHE_SIZE - 1)
> >
> > -/*
> > - * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta e=
vents
> > +/**
> > + * struct dso_id
> > + *
> > + * Data about backing storage DSO, comes from PERF_RECORD_MMAP2 meta e=
vents,
> > + * reading from /proc/pid/maps or synthesis of build_ids from DSOs. Po=
ssibly
> > + * incomplete at any particular use.
> >   */
> >  struct dso_id {
> > -     u32     maj;
> > -     u32     min;
> > -     u64     ino;
> > -     u64     ino_generation;
> > +     /* Data related to the mmap2 event or read from /proc/pid/maps. *=
/
> > +     struct {
> > +             u32     maj;
> > +             u32     min;
> > +             u64     ino;
> > +             u64     ino_generation;
> > +     };
> > +     /** @mmap2_valid: Are the maj, min and ino fields valid? */
> > +     bool    mmap2_valid;
> > +     /**
> > +      * @mmap2_ino_generation_valid: Is the ino_generation valid? Gene=
rally
> > +      * false for /proc/pid/maps mmap event.
> > +      */
> > +     bool    mmap2_ino_generation_valid;
> > +     /**
> > +      * @build_id: A possibly populated build_id. build_id__is_defined=
 checks
> > +      * whether it is populated.
> > +      */
> > +     struct build_id build_id;
> >  };
> >
> >  struct dso_cache {
> > @@ -243,7 +262,6 @@ DECLARE_RC_STRUCT(dso) {
> >               u64             addr;
> >               struct symbol   *symbol;
> >       } last_find_result;
> > -     struct build_id  bid;
> >       u64              text_offset;
> >       u64              text_end;
> >       const char       *short_name;
> > @@ -276,7 +294,6 @@ DECLARE_RC_STRUCT(dso) {
> >       enum dso_swap_type      needs_swap:2;
> >       bool                    is_kmod:1;
> >       u8               adjust_symbols:1;
> > -     u8               has_build_id:1;
> >       u8               header_build_id:1;
> >       u8               has_srcline:1;
> >       u8               hit:1;
> > @@ -292,6 +309,9 @@ DECLARE_RC_STRUCT(dso) {
> >  };
> >
> >  extern struct mutex _dso__data_open_lock;
> > +extern const struct dso_id dso_id_empty;
> > +
> > +int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
> >
> >  /* dso__for_each_symbol - iterate over the symbols of given type
> >   *
> > @@ -362,31 +382,11 @@ static inline void dso__set_auxtrace_cache(struct=
 dso *dso, struct auxtrace_cach
> >       RC_CHK_ACCESS(dso)->auxtrace_cache =3D cache;
> >  }
> >
> > -static inline struct build_id *dso__bid(struct dso *dso)
> > -{
> > -     return &RC_CHK_ACCESS(dso)->bid;
> > -}
> > -
> > -static inline const struct build_id *dso__bid_const(const struct dso *=
dso)
> > -{
> > -     return &RC_CHK_ACCESS(dso)->bid;
> > -}
> > -
> >  static inline struct dso_bpf_prog *dso__bpf_prog(struct dso *dso)
> >  {
> >       return &RC_CHK_ACCESS(dso)->bpf_prog;
> >  }
> >
> > -static inline bool dso__has_build_id(const struct dso *dso)
> > -{
> > -     return RC_CHK_ACCESS(dso)->has_build_id;
> > -}
> > -
> > -static inline void dso__set_has_build_id(struct dso *dso)
> > -{
> > -     RC_CHK_ACCESS(dso)->has_build_id =3D true;
> > -}
> > -
> >  static inline bool dso__has_srcline(const struct dso *dso)
> >  {
> >       return RC_CHK_ACCESS(dso)->has_srcline;
> > @@ -462,6 +462,16 @@ static inline const struct dso_id *dso__id_const(c=
onst struct dso *dso)
> >       return &RC_CHK_ACCESS(dso)->id;
> >  }
> >
> > +static inline const struct build_id *dso__bid(const struct dso *dso)
> > +{
> > +     return &dso__id_const(dso)->build_id;
> > +}
> > +
> > +static inline bool dso__has_build_id(const struct dso *dso)
> > +{
> > +     return build_id__is_defined(dso__bid(dso));
> > +}
> > +
> >  static inline struct rb_root_cached *dso__inlined_nodes(struct dso *ds=
o)
> >  {
> >       return &RC_CHK_ACCESS(dso)->inlined_nodes;
> > @@ -699,9 +709,6 @@ static inline void dso__set_text_offset(struct dso =
*dso, u64 val)
> >       RC_CHK_ACCESS(dso)->text_offset =3D val;
> >  }
> >
> > -int dso_id__cmp(const struct dso_id *a, const struct dso_id *b);
> > -bool dso_id__empty(const struct dso_id *id);
> > -
> >  struct dso *dso__new_id(const char *name, const struct dso_id *id);
> >  struct dso *dso__new(const char *name);
> >  void dso__delete(struct dso *dso);
> > @@ -709,7 +716,7 @@ void dso__delete(struct dso *dso);
> >  int dso__cmp_id(struct dso *a, struct dso *b);
> >  void dso__set_short_name(struct dso *dso, const char *name, bool name_=
allocated);
> >  void dso__set_long_name(struct dso *dso, const char *name, bool name_a=
llocated);
> > -void __dso__inject_id(struct dso *dso, const struct dso_id *id);
> > +void __dso__improve_id(struct dso *dso, const struct dso_id *id);
> >
> >  int dso__name_len(const struct dso *dso);
> >
> > @@ -739,8 +746,8 @@ void dso__sort_by_name(struct dso *dso);
> >
> >  int dso__swap_init(struct dso *dso, unsigned char eidata);
> >
> > -void dso__set_build_id(struct dso *dso, struct build_id *bid);
> > -bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
> > +void dso__set_build_id(struct dso *dso, const struct build_id *bid);
> > +bool dso__build_id_equal(const struct dso *dso, const struct build_id =
*bid);
> >  void dso__read_running_kernel_build_id(struct dso *dso,
> >                                      struct machine *machine);
> >  int dso__kernel_module_get_build_id(struct dso *dso, const char *root_=
dir);
> > diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> > index b2172632b3cd..ad919ed28ba4 100644
> > --- a/tools/perf/util/dsos.c
> > +++ b/tools/perf/util/dsos.c
> > @@ -72,6 +72,7 @@ static int dsos__read_build_ids_cb(struct dso *dso, v=
oid *data)
> >  {
> >       struct dsos__read_build_ids_cb_args *args =3D data;
> >       struct nscookie nsc;
> > +     struct build_id bid;
> >
> >       if (args->with_hits && !dso__hit(dso) && !dso__is_vdso(dso))
> >               return 0;
> > @@ -80,15 +81,15 @@ static int dsos__read_build_ids_cb(struct dso *dso,=
 void *data)
> >               return 0;
> >       }
> >       nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> > -     if (filename__read_build_id(dso__long_name(dso), dso__bid(dso)) >=
 0) {
> > +     if (filename__read_build_id(dso__long_name(dso), &bid) > 0) {
> > +             dso__set_build_id(dso, &bid);
> >               args->have_build_id =3D true;
> > -             dso__set_has_build_id(dso);
> >       } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
> >               char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
> >
> > -             if (new_name && filename__read_build_id(new_name, dso__bi=
d(dso)) > 0) {
> > +             if (new_name && filename__read_build_id(new_name, &bid) >=
 0) {
> > +                     dso__set_build_id(dso, &bid);
> >                       args->have_build_id =3D true;
> > -                     dso__set_has_build_id(dso);
> >               }
> >               free(new_name);
> >       }
> > @@ -284,7 +285,7 @@ struct dso *dsos__find(struct dsos *dsos, const cha=
r *name, bool cmp_short)
> >       struct dso *res;
> >
> >       down_read(&dsos->lock);
> > -     res =3D __dsos__find_id(dsos, name, NULL, cmp_short, /*write_lock=
ed=3D*/false);
> > +     res =3D __dsos__find_id(dsos, name, &dso_id_empty, cmp_short, /*w=
rite_locked=3D*/false);
> >       up_read(&dsos->lock);
> >       return res;
> >  }
> > @@ -341,8 +342,8 @@ static struct dso *__dsos__findnew_id(struct dsos *=
dsos, const char *name, const
> >  {
> >       struct dso *dso =3D __dsos__find_id(dsos, name, id, false, /*writ=
e_locked=3D*/true);
> >
> > -     if (dso && dso_id__empty(dso__id(dso)) && !dso_id__empty(id))
> > -             __dso__inject_id(dso, id);
> > +     if (dso)
> > +             __dso__improve_id(dso, id);
> >
> >       return dso ? dso : __dsos__addnew_id(dsos, name, id);
> >  }
> > @@ -433,7 +434,8 @@ struct dso *dsos__findnew_module_dso(struct dsos *d=
sos,
> >
> >       down_write(&dsos->lock);
> >
> > -     dso =3D __dsos__find_id(dsos, m->name, NULL, /*cmp_short=3D*/true=
, /*write_locked=3D*/true);
> > +     dso =3D __dsos__find_id(dsos, m->name, &dso_id_empty, /*cmp_short=
=3D*/true,
> > +                           /*write_locked=3D*/true);
> >       if (dso) {
> >               up_write(&dsos->lock);
> >               return dso;
> > diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> > index b048165b10c1..04062148a9ec 100644
> > --- a/tools/perf/util/machine.c
> > +++ b/tools/perf/util/machine.c
> > @@ -1696,21 +1696,21 @@ int machine__process_mmap2_event(struct machine=
 *machine,
> >  {
> >       struct thread *thread;
> >       struct map *map;
> > -     struct dso_id dso_id =3D {
> > -             .maj =3D event->mmap2.maj,
> > -             .min =3D event->mmap2.min,
> > -             .ino =3D event->mmap2.ino,
> > -             .ino_generation =3D event->mmap2.ino_generation,
> > -     };
> > -     struct build_id __bid, *bid =3D NULL;
> > +     struct dso_id dso_id =3D dso_id_empty;
> >       int ret =3D 0;
> >
> >       if (dump_trace)
> >               perf_event__fprintf_mmap2(event, stdout);
> >
> >       if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
> > -             bid =3D &__bid;
> > -             build_id__init(bid, event->mmap2.build_id, event->mmap2.b=
uild_id_size);
> > +             build_id__init(&dso_id.build_id, event->mmap2.build_id, e=
vent->mmap2.build_id_size);
> > +     } else {
> > +             dso_id.maj =3D event->mmap2.maj;
> > +             dso_id.min =3D event->mmap2.min;
> > +             dso_id.ino =3D event->mmap2.ino;
> > +             dso_id.ino_generation =3D event->mmap2.ino_generation;
> > +             dso_id.mmap2_valid =3D true;
> > +             dso_id.mmap2_ino_generation_valid =3D true;
> >       }
> >
> >       if (sample->cpumode =3D=3D PERF_RECORD_MISC_GUEST_KERNEL ||
> > @@ -1722,7 +1722,7 @@ int machine__process_mmap2_event(struct machine *=
machine,
> >               };
> >
> >               strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
> > -             ret =3D machine__process_kernel_mmap_event(machine, &xm, =
bid);
> > +             ret =3D machine__process_kernel_mmap_event(machine, &xm, =
&dso_id.build_id);
> >               if (ret < 0)
> >                       goto out_problem;
> >               return 0;
> > @@ -1736,7 +1736,7 @@ int machine__process_mmap2_event(struct machine *=
machine,
> >       map =3D map__new(machine, event->mmap2.start,
> >                       event->mmap2.len, event->mmap2.pgoff,
> >                       &dso_id, event->mmap2.prot,
> > -                     event->mmap2.flags, bid,
> > +                     event->mmap2.flags,
> >                       event->mmap2.filename, thread);
> >
> >       if (map =3D=3D NULL)
> > @@ -1794,8 +1794,8 @@ int machine__process_mmap_event(struct machine *m=
achine, union perf_event *event
> >               prot =3D PROT_EXEC;
> >
> >       map =3D map__new(machine, event->mmap.start,
> > -                     event->mmap.len, event->mmap.pgoff,
> > -                     NULL, prot, 0, NULL, event->mmap.filename, thread=
);
> > +                    event->mmap.len, event->mmap.pgoff,
> > +                    &dso_id_empty, prot, /*flags=3D*/0, event->mmap.fi=
lename, thread);
> >
> >       if (map =3D=3D NULL)
> >               goto out_problem_map;
> > @@ -3157,7 +3157,7 @@ struct dso *machine__findnew_dso_id(struct machin=
e *machine, const char *filenam
> >
> >  struct dso *machine__findnew_dso(struct machine *machine, const char *=
filename)
> >  {
> > -     return machine__findnew_dso_id(machine, filename, NULL);
> > +     return machine__findnew_dso_id(machine, filename, &dso_id_empty);
> >  }
> >
> >  char *machine__resolve_kernel_addr(void *vmachine, unsigned long long =
*addrp, char **modp)
> > diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> > index 8858520c16f4..41cdddc987ee 100644
> > --- a/tools/perf/util/map.c
> > +++ b/tools/perf/util/map.c
> > @@ -120,8 +120,8 @@ static void map__init(struct map *map, u64 start, u=
64 end, u64 pgoff,
> >  }
> >
> >  struct map *map__new(struct machine *machine, u64 start, u64 len,
> > -                  u64 pgoff, struct dso_id *id,
> > -                  u32 prot, u32 flags, struct build_id *bid,
> > +                  u64 pgoff, const struct dso_id *id,
> > +                  u32 prot, u32 flags,
> >                    char *filename, struct thread *thread)
> >  {
> >       struct map *result;
> > @@ -132,7 +132,7 @@ struct map *map__new(struct machine *machine, u64 s=
tart, u64 len,
> >       map =3D zalloc(sizeof(*map));
> >       if (ADD_RC_CHK(result, map)) {
> >               char newfilename[PATH_MAX];
> > -             struct dso *dso, *header_bid_dso;
> > +             struct dso *dso;
> >               int anon, no_dso, vdso, android;
> >
> >               android =3D is_android_lib(filename);
> > @@ -189,16 +189,15 @@ struct map *map__new(struct machine *machine, u64=
 start, u64 len,
> >               dso__set_nsinfo(dso, nsi);
> >               mutex_unlock(dso__lock(dso));
> >
> > -             if (build_id__is_defined(bid)) {
> > -                     dso__set_build_id(dso, bid);
> > -             } else {
> > +             if (!build_id__is_defined(&id->build_id)) {
> >                       /*
> >                        * If the mmap event had no build ID, search for =
an existing dso from the
> >                        * build ID header by name. Otherwise only the ds=
o loaded at the time of
> >                        * reading the header will have the build ID set =
and all future mmaps will
> >                        * have it missing.
> >                        */
> > -                     header_bid_dso =3D dsos__find(&machine->dsos, fil=
ename, false);
> > +                     struct dso *header_bid_dso =3D dsos__find(&machin=
e->dsos, filename, false);
> > +
> >                       if (header_bid_dso && dso__header_build_id(header=
_bid_dso)) {
> >                               dso__set_build_id(dso, dso__bid(header_bi=
d_dso));
> >                               dso__set_header_build_id(dso, 1);
> > diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> > index 768501eec70e..979b3e11b9bc 100644
> > --- a/tools/perf/util/map.h
> > +++ b/tools/perf/util/map.h
> > @@ -173,11 +173,10 @@ struct thread;
> >       __map__for_each_symbol_by_name(map, sym_name, (pos), idx)
> >
> >  struct dso_id;
> > -struct build_id;
> >
> >  struct map *map__new(struct machine *machine, u64 start, u64 len,
> > -                  u64 pgoff, struct dso_id *id, u32 prot, u32 flags,
> > -                  struct build_id *bid, char *filename, struct thread =
*thread);
> > +                  u64 pgoff, const struct dso_id *id, u32 prot, u32 fl=
ags,
> > +                  char *filename, struct thread *thread);
> >  struct map *map__new2(u64 start, struct dso *dso);
> >  void map__delete(struct map *map);
> >  struct map *map__clone(struct map *map);
> > diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
> > index 594b75ca95bf..d20b980d5052 100644
> > --- a/tools/perf/util/sort.c
> > +++ b/tools/perf/util/sort.c
> > @@ -1709,22 +1709,27 @@ sort__dcacheline_cmp(struct hist_entry *left, s=
truct hist_entry *right)
> >       if (rc)
> >               return rc;
> >       /*
> > -      * Addresses with no major/minor numbers are assumed to be
> > +      * Addresses with no major/minor numbers or build ID are assumed =
to be
> >        * anonymous in userspace.  Sort those on pid then address.
> >        *
> >        * The kernel and non-zero major/minor mapped areas are
> >        * assumed to be unity mapped.  Sort those on address.
> >        */
> > +     if (left->cpumode !=3D PERF_RECORD_MISC_KERNEL && (map__flags(l_m=
ap) & MAP_SHARED) =3D=3D 0) {
> > +             const struct dso_id *dso_id =3D dso__id_const(l_dso);
> >
> > -     if ((left->cpumode !=3D PERF_RECORD_MISC_KERNEL) &&
> > -         (!(map__flags(l_map) & MAP_SHARED)) && !dso__id(l_dso)->maj &=
& !dso__id(l_dso)->min &&
> > -          !dso__id(l_dso)->ino && !dso__id(l_dso)->ino_generation) {
> > -             /* userspace anonymous */
> > +             if (!dso_id->mmap2_valid)
> > +                     dso_id =3D dso__id_const(r_dso);
> >
> > -             if (thread__pid(left->thread) > thread__pid(right->thread=
))
> > -                     return -1;
> > -             if (thread__pid(left->thread) < thread__pid(right->thread=
))
> > -                     return 1;
> > +             if (!build_id__is_defined(&dso_id->build_id) &&
> > +                 (!dso_id->mmap2_valid || (dso_id->maj =3D=3D 0 && dso=
_id->min =3D=3D 0))) {
> > +                     /* userspace anonymous */
> > +
> > +                     if (thread__pid(left->thread) > thread__pid(right=
->thread))
> > +                             return -1;
> > +                     if (thread__pid(left->thread) < thread__pid(right=
->thread))
> > +                             return 1;
> > +             }
> >       }
> >
> >  addr:
> > @@ -1749,6 +1754,7 @@ static int hist_entry__dcacheline_snprintf(struct=
 hist_entry *he, char *bf,
> >       if (he->mem_info) {
> >               struct map *map =3D mem_info__daddr(he->mem_info)->ms.map=
;
> >               struct dso *dso =3D map ? map__dso(map) : NULL;
> > +             const struct dso_id *dso_id =3D dso ? dso__id_const(dso) =
: &dso_id_empty;
> >
> >               addr =3D cl_address(mem_info__daddr(he->mem_info)->al_add=
r, chk_double_cl);
> >               ms =3D &mem_info__daddr(he->mem_info)->ms;
> > @@ -1757,8 +1763,7 @@ static int hist_entry__dcacheline_snprintf(struct=
 hist_entry *he, char *bf,
> >               if ((he->cpumode !=3D PERF_RECORD_MISC_KERNEL) &&
> >                    map && !(map__prot(map) & PROT_EXEC) &&
> >                    (map__flags(map) & MAP_SHARED) &&
> > -                  (dso__id(dso)->maj || dso__id(dso)->min || dso__id(d=
so)->ino ||
> > -                   dso__id(dso)->ino_generation))
> > +                  (!dso_id->mmap2_valid || (dso_id->maj =3D=3D 0 && ds=
o_id->min =3D=3D 0)))
> >                       level =3D 's';
> >               else if (!map)
> >                       level =3D 'X';
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 68bb7c5fe1b1..8fb2ea544d3a 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -372,7 +372,7 @@ static void perf_record_mmap2__read_build_id(struct=
 perf_record_mmap2 *event,
> >       struct nsinfo *nsi;
> >       struct nscookie nc;
> >       struct dso *dso =3D NULL;
> > -     struct dso_id id;
> > +     struct dso_id dso_id =3D dso_id_empty;
> >       int rc;
> >
> >       if (is_kernel) {
> > @@ -380,12 +380,18 @@ static void perf_record_mmap2__read_build_id(stru=
ct perf_record_mmap2 *event,
> >               goto out;
> >       }
> >
> > -     id.maj =3D event->maj;
> > -     id.min =3D event->min;
> > -     id.ino =3D event->ino;
> > -     id.ino_generation =3D event->ino_generation;
> > +     if (event->header.misc & PERF_RECORD_MISC_MMAP_BUILD_ID) {
> > +             build_id__init(&dso_id.build_id, event->build_id, event->=
build_id_size);
> > +     } else {
> > +             dso_id.maj =3D event->maj;
> > +             dso_id.min =3D event->min;
> > +             dso_id.ino =3D event->ino;
> > +             dso_id.ino_generation =3D event->ino_generation;
> > +             dso_id.mmap2_valid =3D true;
> > +             dso_id.mmap2_ino_generation_valid =3D true;
> > +     };
> >
> > -     dso =3D dsos__findnew_id(&machine->dsos, event->filename, &id);
> > +     dso =3D dsos__findnew_id(&machine->dsos, event->filename, &dso_id=
);
> >       if (dso && dso__has_build_id(dso)) {
> >               bid =3D *dso__bid(dso);
> >               rc =3D 0;
> > --
> > 2.49.0.850.g28803427d3-goog
> >
