Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D83B1AB
	for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748465283; cv=none; b=PMgg2YdhBuhYuTyEGK1EpEr/+IjWv1JJKMA7u4tCFjQRtDMPSVKU/g83sgnTU1cC/SLboYe4+gBYD2zXm1gHjTTThSEXq7yhKud8aqfptrwCRO1Vx5RMNRzP+IXM8uN4Pz/wE/UiUWg+63hpXxcTnjg5VOYYkvBl45U6dvl66l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748465283; c=relaxed/simple;
	bh=hQ73FR3hq0hCGvlVAp2xTFtyYzbCKj2XRo/SHksFAOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dsav1Ji971VZzVV0dvK+LVqHmw39dIaMVb6Qsf7P6NvuCOfMBXsWwgp9YA4mkk4xtd8Sal7OEKVULtF+Go/KUhAKSenIAmKeMR3vKmSPasmWpXzq2PbTXePqmKAKYrGhEs8nVJ6vYY/jguOPu0kQdEPMvGeq/3tB9CnP4pmL8ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fRExIkr0; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fRExIkr0"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3dd89a85414so57395ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748465279; x=1749070079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rW6A/typb1/WqkNV5KapDKn/+vKZVe+x11bzbye/XTE=;
        b=fRExIkr00t1SCxmIykr+FP+ovjn3qTOu+nzeuMNEvHBGsAj3IJwFf+qvL5cLO0XsJZ
         T4Nys+aAqx0fInenBYxEetMvw+IEDMdORYIEX1qF4IYOWxI0iTXMJiJ7STApquCFHAXF
         zbhe3QE12u2YiY29RVTLhsScUxxJqwCdF6MjXtM1NcOt2djYZwXduyh4NDT5zUNwOfNm
         CmwQxmQ+9xBNgtZbfjkWFy5T1ETlYogo6ZydQVSdysfn9ooi/lW0bghNhrm/rNPtOg3E
         s37YlIv1ntllCEHXPWdFo9DkkcF59KEogJy6j2Ch7lf5bEVTUQvwBjuvD718VoxN4Zoy
         RUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748465279; x=1749070079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rW6A/typb1/WqkNV5KapDKn/+vKZVe+x11bzbye/XTE=;
        b=PXs8Ddr7s43izJNR0JTPswl2u2o8a1jhX6MPZwCxmN6vTbO+BRohLcgQI1lkaHonnR
         t8D2+InA4NbznIHSFbzAmgsayFX0W7Fx84Z3xJsvK5NiD7ysNKkQCAjC8pNDv3sO6ZJy
         D4IDg9QG2N24QT0TO0r/Om/m2H0GW7jyFnI1xGGUKY6K7DEQ+WhsgI2GoCmgOFofKv6U
         budraky7eAal6qyuQ+XYdDi3GZYd90FpqUhbNlFydt5X3uYTrEjiOB2VwpoS1w0lAwLY
         OQkkkulXG3WHZ7nuQgAh9QzZC46te/3rEy7TwP6W2BWV+OZBXYuvZqYSuQyvpXLnCBRi
         9t2w==
X-Forwarded-Encrypted: i=1; AJvYcCXAUDWE7nbOpSftrSmVRWqC7Bfk6sctLhAcfMC0TlmZfeklgv49Hh3/Rrc0tpkTJ479/y3bVGZX0dXUl5gAbugu@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rlKLmtWo2N9GsB1tSUM2lPbDKzSQVL7UY+b7Gga1ciWUof3i
	+2MSpZAAwzV/IGOSkeunEmWtdBr7qe63hbKBdQ/Dce4KBdouaE4fuVvN25inIe1DSCjvBR7vK/c
	CoT228BS9iKdGDDr8NaRzUUJUrd9T0cYYMkvgx0uz
X-Gm-Gg: ASbGncs/93n+xKrT9FFsjWfS+3P/U7BaA9MK8xmpwIr1RrwmJy0bVw66K+pWUCMX7FR
	RBTsJxJLbuEyZHi+zeIjwDBb6ZTDcC8V2D5OKY/ZtH4f9CINrK7d2nxvKCTJK6W2bs3qP48SpOG
	/B3jCxvqtuUqd87R8EameEfFvsQekRZvVF01E9Nn425MBqeUE/X5i3Upw7GW+IilB4CxBG0ZpR
X-Google-Smtp-Source: AGHT+IELbashPibpAWQ2a3S/meorEUAkC8EuZc+W+WWyW+DsC/MTNBdp4aPuVMQJe8OeY8Q2t6xQMn1EgWlVvt4OHBw=
X-Received: by 2002:a05:6e02:2303:b0:3dd:87c3:f04f with SMTP id
 e9e14a558f8ab-3dd920f7220mr951515ab.24.1748465279051; Wed, 28 May 2025
 13:47:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428213409.1417584-1-irogers@google.com> <20250428213409.1417584-10-irogers@google.com>
 <aDd0Wqy6yw6Tu0vg@google.com>
In-Reply-To: <aDd0Wqy6yw6Tu0vg@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 May 2025 13:47:47 -0700
X-Gm-Features: AX0GCFvsWXSbpnN1x4o2vBSoQfCUCsp4Q8xp8K-d0uIoBcOAKU9xIFUPXmRKox0
Message-ID: <CAP-5=fUMiWu5gSfBSTq+OnTRQ2E2gCw6gi7dmOxeTD-+UyYtFw@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] perf record: Make --buildid-mmap the default
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

On Wed, May 28, 2025 at 1:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Apr 28, 2025 at 02:34:08PM -0700, Ian Rogers wrote:
> > Support for build IDs in mmap2 perf events has been present since
> > Linux v5.12:
> > https://lore.kernel.org/lkml/20210219194619.1780437-1-acme@kernel.org/
> > Build ID mmap events don't avoid the need to inject build IDs for DSO
> > touched by samples as the build ID cache is populated by perf
> > record. They can avoid some cases of symbol mis-resolution caused by
> > the file system changing from when a sample occurred and when the DSO
> > is sought. To disable build ID scanning
> >
> > Unlike the --buildid-mmap option, this doesn't disable the build ID
> > cache but it does disable the processing of samples looking for DSOs
> > to inject build IDs for. To disable the build ID cache the -B
> > (--no-buildid) option should be used.
> >
> > Making this option the default was raised on the list in:
> > https://lore.kernel.org/linux-perf-users/CAP-5=3DfXP7jN_QrGUcd55_QH5J-Y=
-FCaJ6=3DNaHVtyx0oyNh8_-Q@mail.gmail.com/
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c        | 33 +++++++++++++++++++-----------
> >  tools/perf/util/symbol_conf.h      |  2 +-
> >  tools/perf/util/synthetic-events.c | 16 +++++++--------
> >  3 files changed, 30 insertions(+), 21 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index ba20bf7c011d..7b64013ba8c0 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -169,6 +169,7 @@ struct record {
> >       bool                    no_buildid_cache_set;
> >       bool                    buildid_all;
> >       bool                    buildid_mmap;
> > +     bool                    buildid_mmap_set;
> >       bool                    timestamp_filename;
> >       bool                    timestamp_boundary;
> >       bool                    off_cpu;
> > @@ -1795,6 +1796,7 @@ record__finish_output(struct record *rec)
> >                       data->dir.files[i].size =3D lseek(data->dir.files=
[i].fd, 0, SEEK_CUR);
> >       }
> >
> > +     /* Buildid scanning disabled or build ID in kernel and synthesize=
d map events. */
> >       if (!rec->no_buildid) {
> >               process_buildids(rec);
> >
> > @@ -2966,6 +2968,8 @@ static int perf_record_config(const char *var, co=
nst char *value, void *cb)
> >                       rec->no_buildid =3D true;
> >               else if (!strcmp(value, "mmap"))
> >                       rec->buildid_mmap =3D true;
> > +             else if (!strcmp(value, "no-mmap"))
> > +                     rec->buildid_mmap =3D false;
> >               else
> >                       return -1;
> >               return 0;
> > @@ -3349,6 +3353,7 @@ static struct record record =3D {
> >               .ctl_fd_ack          =3D -1,
> >               .synth               =3D PERF_SYNTH_ALL,
> >       },
> > +     .buildid_mmap =3D true,
> >  };
> >
> >  const char record_callchain_help[] =3D CALLCHAIN_RECORD_HELP
> > @@ -3514,8 +3519,8 @@ static struct option __record_options[] =3D {
> >                  "file", "vmlinux pathname"),
> >       OPT_BOOLEAN(0, "buildid-all", &record.buildid_all,
> >                   "Record build-id of all DSOs regardless of hits"),
> > -     OPT_BOOLEAN(0, "buildid-mmap", &record.buildid_mmap,
> > -                 "Record build-id in map events"),
> > +     OPT_BOOLEAN_SET(0, "buildid-mmap", &record.buildid_mmap, &record.=
buildid_mmap_set,
> > +                     "Legacy record build-id in map events option whic=
h is now the default. Behaves indentically to --no-buildid. Disable with --=
no-buildid-mmap"),
> >       OPT_BOOLEAN(0, "timestamp-filename", &record.timestamp_filename,
> >                   "append timestamp to output filename"),
> >       OPT_BOOLEAN(0, "timestamp-boundary", &record.timestamp_boundary,
> > @@ -4042,19 +4047,23 @@ int cmd_record(int argc, const char **argv)
> >               record.opts.record_switch_events =3D true;
> >       }
> >
> > +     if (!rec->buildid_mmap) {
> > +             pr_debug("Disabling build id in synthesized mmap2 events.=
\n");
> > +             symbol_conf.no_buildid_mmap2 =3D true;
> > +     } else if (rec->buildid_mmap_set) {
> > +             /*
> > +              * Explicitly passing --buildid-mmap disables buildid pro=
cessing
> > +              * and cache generation.
> > +              */
> > +             rec->no_buildid =3D true;
> > +     }
> > +     if (rec->buildid_mmap && !perf_can_record_build_id()) {
> > +             pr_warning("Missing support for build id in kernel mmap e=
vents. Disable this warning with --no-buildid-mmap\n");
> > +             rec->buildid_mmap =3D false;
> > +     }
> >       if (rec->buildid_mmap) {
> > -             if (!perf_can_record_build_id()) {
> > -                     pr_err("Failed: no support to record build id in =
mmap events, update your kernel.\n");
> > -                     err =3D -EINVAL;
> > -                     goto out_opts;
> > -             }
> > -             pr_debug("Enabling build id in mmap2 events.\n");
> > -             /* Enable mmap build id synthesizing. */
> > -             symbol_conf.buildid_mmap2 =3D true;
> >               /* Enable perf_event_attr::build_id bit. */
> >               rec->opts.build_id =3D true;
> > -             /* Disable build id cache. */
> > -             rec->no_buildid =3D true;
> >       }
> >
> >       if (rec->opts.record_cgroup && !perf_can_record_cgroup()) {
> > diff --git a/tools/perf/util/symbol_conf.h b/tools/perf/util/symbol_con=
f.h
> > index cd9aa82c7d5a..7a80d2c14d9b 100644
> > --- a/tools/perf/util/symbol_conf.h
> > +++ b/tools/perf/util/symbol_conf.h
> > @@ -43,7 +43,7 @@ struct symbol_conf {
> >                       report_individual_block,
> >                       inline_name,
> >                       disable_add2line_warn,
> > -                     buildid_mmap2,
> > +                     no_buildid_mmap2,
> >                       guest_code,
> >                       lazy_load_kernel_maps,
> >                       keep_exited_threads,
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index 69b98023ce74..638d7dd7fa4b 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -532,7 +532,7 @@ int perf_event__synthesize_mmap_events(const struct=
 perf_tool *tool,
> >               event->mmap2.pid =3D tgid;
> >               event->mmap2.tid =3D pid;
> >
> > -             if (symbol_conf.buildid_mmap2)
> > +             if (!symbol_conf.no_buildid_mmap2)
>
> I find the double negation confusing.  Can we keep it positive?

Agreed double negation is broadly bad. Here I changed buildid_mmap2 to
no_buildid_mmap2 to convey that using build ID with mmap2 events was
the default and needed opting out of. Getting rid of the 'no_' is of
course possible, it will mean all symbol_confs will need to initialize
the value to true (which has minor binary size implications), I also
think it makes the intention of the code harder to understand.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> >                       perf_record_mmap2__read_build_id(&event->mmap2, m=
achine, false);
> >
> >               if (perf_tool__process_synth_event(tool, event, machine, =
process) !=3D 0) {
> > @@ -690,7 +690,7 @@ static int perf_event__synthesize_modules_maps_cb(s=
truct map *map, void *data)
> >               return 0;
> >
> >       dso =3D map__dso(map);
> > -     if (symbol_conf.buildid_mmap2) {
> > +     if (!symbol_conf.no_buildid_mmap2) {
> >               size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof(u=
64));
> >               event->mmap2.header.type =3D PERF_RECORD_MMAP2;
> >               event->mmap2.header.size =3D (sizeof(event->mmap2) -
> > @@ -734,9 +734,9 @@ int perf_event__synthesize_modules(const struct per=
f_tool *tool, perf_event__han
> >               .process =3D process,
> >               .machine =3D machine,
> >       };
> > -     size_t size =3D symbol_conf.buildid_mmap2
> > -             ? sizeof(args.event->mmap2)
> > -             : sizeof(args.event->mmap);
> > +     size_t size =3D symbol_conf.no_buildid_mmap2
> > +             ? sizeof(args.event->mmap)
> > +             : sizeof(args.event->mmap2);
> >
> >       args.event =3D zalloc(size + machine->id_hdr_size);
> >       if (args.event =3D=3D NULL) {
> > @@ -1124,8 +1124,8 @@ static int __perf_event__synthesize_kernel_mmap(c=
onst struct perf_tool *tool,
> >                                               struct machine *machine)
> >  {
> >       union perf_event *event;
> > -     size_t size =3D symbol_conf.buildid_mmap2 ?
> > -                     sizeof(event->mmap2) : sizeof(event->mmap);
> > +     size_t size =3D symbol_conf.no_buildid_mmap2 ?
> > +                     sizeof(event->mmap) : sizeof(event->mmap2);
> >       struct map *map =3D machine__kernel_map(machine);
> >       struct kmap *kmap;
> >       int err;
> > @@ -1159,7 +1159,7 @@ static int __perf_event__synthesize_kernel_mmap(c=
onst struct perf_tool *tool,
> >               event->header.misc =3D PERF_RECORD_MISC_GUEST_KERNEL;
> >       }
> >
> > -     if (symbol_conf.buildid_mmap2) {
> > +     if (!symbol_conf.no_buildid_mmap2) {
> >               size =3D snprintf(event->mmap2.filename, sizeof(event->mm=
ap2.filename),
> >                               "%s%s", machine->mmap_name, kmap->ref_rel=
oc_sym->name) + 1;
> >               size =3D PERF_ALIGN(size, sizeof(u64));
> > --
> > 2.49.0.901.g37484f566f-goog
> >
