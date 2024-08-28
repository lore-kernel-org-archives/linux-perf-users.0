Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5713C3D5
	for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 15:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724858126; cv=none; b=V1BNcYftaYj2woPsUGE9WQ6A6ra7aqX9A9Wk2MFwPr+CgoioauK6WDa26FZ2VTIBCrhvRek0zTpfE7S829B7fjlHM4H3rG9Quwy9J/A6jM9xI7MHmOa0zrpAvczGSY+I/HwRAKRO2Smoi/Rg79uyefYCYgaMtfUqLUbY/Qe3ZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724858126; c=relaxed/simple;
	bh=2CgU5sNSlHwxgOUF+Z6FbnJ4jQ4DOyKW0TWFfNRWEE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHMXbiIqI/RGiT7qPTeDoZT7EBfMqT1IYRO41ZyqGcoqX4XQb8ytvbvgYOlQPoAWFEtgfwUJNQy/UzYBrKUM4yVvqrjfu/dYOw59yZiNOMNbuXq7Up9gWVLvIvwsKew1fUU41pcOJZIyu1EkKKjJP69kq8u/lYaJ1vVTyXwIyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DIUGRv1B; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIUGRv1B"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20353e5de9cso232185ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Aug 2024 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724858124; x=1725462924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cU3vn+baMa/vILJwWHdiC4D40C7FTx3TGwhNerEKT0=;
        b=DIUGRv1Bc4fR51h1Yv5c/3iySxMZ7hAY8YulrdSiq76Viwx4Rke0e7evwDqpH+CRos
         yTdde4wB+Rb0LL10GaeLB8KuP9XKNFCBUk25eoHvqeGtYxkxQzHXBQ8QEg6oBK6gipr/
         b+Nr2tdyxFTrjlyLnJjvr6M8qNZh15s2l8os7FYFqasAEMAsC6hCH5GSggBvFlXBC7rl
         5W9Zfi2KrZwzJ8kYBlC+WuG2XuO3mm/kEwi22tT8zCJ/hioQQuNdjUOfjll/8CqJj5eo
         FG9iD6kccxVv3MHbOBfBE3pj8OvtlbQaGG9bPo3oABQ5t9IjumWgXG8juW8xKkE4Kima
         aDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724858124; x=1725462924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cU3vn+baMa/vILJwWHdiC4D40C7FTx3TGwhNerEKT0=;
        b=abLebjeaOMZ/yUpQZFzRW2o7v64682MQBurEw3Aru3hHWdTVqNHUBlj9pvU62d2/NF
         E3+rPXFb1Sr0Zb0KREdgY5TN0xv0AQhRP5dQgzPVvIFiwlZBbhURSwp7bCTuDzKiNson
         Ks+quc5cXN7wwZPLxIywZ4ePX0yZWJybEt/riYYSWb4QUfUOgKNwV2CkTYwjJaIjfMyP
         gbCbGaNOnabzFS51dYV09wsuTfv/uOZ3C8IGw18R8aZl7rrwjlwmBdN+vnnnLk30fb+5
         gGd9xU82fDptndGLdlNWcbb7DsIPzogVgGa098aGRUlETY1K6I4CP99AqtkwbMS98juR
         pyhA==
X-Forwarded-Encrypted: i=1; AJvYcCV3oM6tI28Vpr39NaE/gnjkaWOyqpmmELxMtFguNyvDLDaMV3Ykrq061pe0kYYd6z0URi7EeN63ZRlZnrD4/wdY@vger.kernel.org
X-Gm-Message-State: AOJu0Yywo/S3Bzf9Q4CjkX5dt/8gvopG0PMzzYjxl/cFvxjOXr5UFEmY
	21sYiOM4lF8UUlM1mYpeeJiHskTqDmTPcptxpIywGtqzGI0kkHlgm0EvbW0vna9ouGz0KHCCqAj
	qqoS2vG+nl8G0/GSYY6uXlp2MZNmQn1nuZYN5
X-Google-Smtp-Source: AGHT+IG8FUJbmya+l8T5NvberrpqbM0Hy+f18cvSqQIMt4pN9Cp9MWlSJX8wvDXYCEfCDNLqE/RlWFDFfVAkTFjBHYw=
X-Received: by 2002:a17:903:32c1:b0:1fa:9627:d363 with SMTP id
 d9443c01a7336-204f95e4c5amr2863235ad.11.1724858122985; Wed, 28 Aug 2024
 08:15:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817064442.2152089-1-irogers@google.com> <20240817064442.2152089-11-irogers@google.com>
 <ZsOIkMEf3l6e-mdX@x1> <CAP-5=fVqkR7Xd8GXw31MPNSsfvkiPVavQjQSieWUpKasHcLVQQ@mail.gmail.com>
In-Reply-To: <CAP-5=fVqkR7Xd8GXw31MPNSsfvkiPVavQjQSieWUpKasHcLVQQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 28 Aug 2024 08:15:10 -0700
Message-ID: <CAP-5=fX9bmzn51DPHoeGVMbY=LLux2_JKGwFHNek7Je1h8qPBg@mail.gmail.com>
Subject: Re: [PATCH v1 10/13] perf inject: Fix build ID injection
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Casey Chen <cachen@purestorage.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yunseong Kim <yskelg@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Anne Macedo <retpolanne@posteo.net>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 12:54=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Aug 19, 2024 at 11:01=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Fri, Aug 16, 2024 at 11:44:39PM -0700, Ian Rogers wrote:
> > > Build ID injection wasn't inserting a sample ID and aligning events t=
o
> > > 64 bytes rather than 8. No sample ID means events are unordered and
> > > two different build_id events for the same path, as happens when a
> > > file is replaced, can't be differentiated.
> > >
> > > Add in sample ID insertion for the build_id events alongside some
> > > refactoring. The refactoring better aligns the function arguments for
> > > different use cases, such as synthesizing build_id events without
> > > needing to have a dso. The misc bits are explicitly passed as with
> > > callchains the maps/dsos may span user and kernel land, so using
> > > sample->cpumode isn't good enough.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-inject.c        | 170 ++++++++++++++++++++++-----=
--
> > >  tools/perf/util/build-id.c         |   6 +-
> > >  tools/perf/util/synthetic-events.c |  44 ++++++--
> > >  tools/perf/util/synthetic-events.h |  10 +-
> > >  4 files changed, 175 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.=
c
> > > index a7c859db2e15..84a4bdb5cb0a 100644
> > > --- a/tools/perf/builtin-inject.c
> > > +++ b/tools/perf/builtin-inject.c
> > > @@ -131,6 +131,7 @@ struct perf_inject {
> > >       struct perf_file_section secs[HEADER_FEAT_BITS];
> > >       struct guest_session    guest_session;
> > >       struct strlist          *known_build_ids;
> > > +     const struct evsel      *mmap_evsel;
> > >  };
> > >
> > >  struct event_entry {
> > > @@ -139,8 +140,13 @@ struct event_entry {
> > >       union perf_event event[];
> > >  };
> > >
> > > -static int dso__inject_build_id(struct dso *dso, const struct perf_t=
ool *tool,
> > > -                             struct machine *machine, u8 cpumode, u3=
2 flags);
> > > +static int dso__inject_build_id(const struct perf_tool *tool,
> > > +                             struct perf_sample *sample,
> > > +                             struct machine *machine,
> > > +                             const struct evsel *evsel,
> > > +                             __u16 misc,
> > > +                             const char *filename,
> > > +                             struct dso *dso, u32 flags);
> >
> > So in the end the dso was needed, the name of the function remains
> > dso__something(), so first arg would be a 'struct dso *'
> >
> > I processed the patches up to 9/13, so that they can get tested now.
>
> Maybe we should rename the function? We can get the build ID from
> mmap2 events now, not just stored away in the dso by build_id events.
> Reordering the arguments isn't a problem, I was just aiming for
> consistency between the caller, perf_event__synthesize_build_id and
> eventually the call to process that all take the arguments in this
> order.

Arnaldo, did you have any more thoughts on this?

Thanks,
Ian

>
> > - Arnaldo
> >
> > >
> > >  static int output_bytes(struct perf_inject *inject, void *buf, size_=
t sz)
> > >  {
> > > @@ -422,6 +428,28 @@ static struct dso *findnew_dso(int pid, int tid,=
 const char *filename,
> > >       return dso;
> > >  }
> > >
> > > +/*
> > > + * The evsel used for the sample ID for mmap events. Typically stash=
ed when
> > > + * processing mmap events. If not stashed, search the evlist for the=
 first mmap
> > > + * gathering event.
> > > + */
> > > +static const struct evsel *inject__mmap_evsel(struct perf_inject *in=
ject)
> > > +{
> > > +     struct evsel *pos;
> > > +
> > > +     if (inject->mmap_evsel)
> > > +             return inject->mmap_evsel;
> > > +
> > > +     evlist__for_each_entry(inject->session->evlist, pos) {
> > > +             if (pos->core.attr.mmap) {
> > > +                     inject->mmap_evsel =3D pos;
> > > +                     return pos;
> > > +             }
> > > +     }
> > > +     pr_err("No mmap events found\n");
> > > +     return NULL;
> > > +}
> > > +
> > >  static int perf_event__repipe_common_mmap(const struct perf_tool *to=
ol,
> > >                                         union perf_event *event,
> > >                                         struct perf_sample *sample,
> > > @@ -469,12 +497,28 @@ static int perf_event__repipe_common_mmap(const=
 struct perf_tool *tool,
> > >               }
> > >
> > >               if (dso && !dso__hit(dso)) {
> > > -                     dso__set_hit(dso);
> > > -                     dso__inject_build_id(dso, tool, machine, sample=
->cpumode, flags);
> > > +                     struct evsel *evsel =3D evlist__event2evsel(inj=
ect->session->evlist, event);
> > > +
> > > +                     if (evsel) {
> > > +                             dso__set_hit(dso);
> > > +                             dso__inject_build_id(tool, sample, mach=
ine, evsel,
> > > +                                                  /*misc=3D*/sample-=
>cpumode,
> > > +                                                  filename, dso, fla=
gs);
> > > +                     }
> > >               }
> > >       } else {
> > > +             int err;
> > > +
> > > +             /*
> > > +              * Remember the evsel for lazy build id generation. It =
is used
> > > +              * for the sample id header type.
> > > +              */
> > > +             if (inject->build_id_style =3D=3D BID_RWS__INJECT_HEADE=
R_LAZY &&
> > > +                 !inject->mmap_evsel)
> > > +                     inject->mmap_evsel =3D evlist__event2evsel(inje=
ct->session->evlist, event);
> > > +
> > >               /* Create the thread, map, etc. Not done for the unorde=
red inject all case. */
> > > -             int err =3D perf_event_process(tool, event, sample, mac=
hine);
> > > +             err =3D perf_event_process(tool, event, sample, machine=
);
> > >
> > >               if (err) {
> > >                       dso__put(dso);
> > > @@ -667,16 +711,20 @@ static bool perf_inject__lookup_known_build_id(=
struct perf_inject *inject,
> > >       return false;
> > >  }
> > >
> > > -static int dso__inject_build_id(struct dso *dso, const struct perf_t=
ool *tool,
> > > -                             struct machine *machine, u8 cpumode, u3=
2 flags)
> > > +static int dso__inject_build_id(const struct perf_tool *tool,
> > > +                             struct perf_sample *sample,
> > > +                             struct machine *machine,
> > > +                             const struct evsel *evsel,
> > > +                             __u16 misc,
> > > +                             const char *filename,
> > > +                             struct dso *dso, u32 flags)
> > >  {
> > > -     struct perf_inject *inject =3D container_of(tool, struct perf_i=
nject,
> > > -                                               tool);
> > > +     struct perf_inject *inject =3D container_of(tool, struct perf_i=
nject, tool);
> > >       int err;
> > >
> > > -     if (is_anon_memory(dso__long_name(dso)) || flags & MAP_HUGETLB)
> > > +     if (is_anon_memory(filename) || flags & MAP_HUGETLB)
> > >               return 0;
> > > -     if (is_no_dso_memory(dso__long_name(dso)))
> > > +     if (is_no_dso_memory(filename))
> > >               return 0;
> > >
> > >       if (inject->known_build_ids !=3D NULL &&
> > > @@ -684,24 +732,65 @@ static int dso__inject_build_id(struct dso *dso=
, const struct perf_tool *tool,
> > >               return 1;
> > >
> > >       if (dso__read_build_id(dso) < 0) {
> > > -             pr_debug("no build_id found for %s\n", dso__long_name(d=
so));
> > > +             pr_debug("no build_id found for %s\n", filename);
> > >               return -1;
> > >       }
> > >
> > > -     err =3D perf_event__synthesize_build_id(tool, dso, cpumode,
> > > -                                           perf_event__repipe, machi=
ne);
> > > +     err =3D perf_event__synthesize_build_id(tool, sample, machine,
> > > +                                           perf_event__repipe,
> > > +                                           evsel, misc, dso__bid(dso=
),
> > > +                                           filename);
> > >       if (err) {
> > > -             pr_err("Can't synthesize build_id event for %s\n", dso_=
_long_name(dso));
> > > +             pr_err("Can't synthesize build_id event for %s\n", file=
name);
> > >               return -1;
> > >       }
> > >
> > >       return 0;
> > >  }
> > >
> > > +static int mark_dso_hit(const struct perf_tool *tool,
> > > +                     struct perf_sample *sample,
> > > +                     struct machine *machine,
> > > +                     const struct evsel *mmap_evsel,
> > > +                     struct map *map, bool sample_in_dso)
> > > +{
> > > +     struct dso *dso;
> > > +     u16 misc =3D sample->cpumode;
> > > +
> > > +     if (!map)
> > > +             return 0;
> > > +
> > > +     if (!sample_in_dso) {
> > > +             u16 guest_mask =3D PERF_RECORD_MISC_GUEST_KERNEL |
> > > +                     PERF_RECORD_MISC_GUEST_USER;
> > > +
> > > +             if ((misc & guest_mask) !=3D 0) {
> > > +                     misc &=3D PERF_RECORD_MISC_HYPERVISOR;
> > > +                     misc |=3D __map__is_kernel(map)
> > > +                             ? PERF_RECORD_MISC_GUEST_KERNEL
> > > +                             : PERF_RECORD_MISC_GUEST_USER;
> > > +             } else {
> > > +                     misc &=3D PERF_RECORD_MISC_HYPERVISOR;
> > > +                     misc |=3D __map__is_kernel(map)
> > > +                             ? PERF_RECORD_MISC_KERNEL
> > > +                             : PERF_RECORD_MISC_USER;
> > > +             }
> > > +     }
> > > +     dso =3D map__dso(map);
> > > +     if (dso && !dso__hit(dso)) {
> > > +             dso__set_hit(dso);
> > > +             dso__inject_build_id(tool, sample, machine,
> > > +                             mmap_evsel, misc, dso__long_name(dso), =
dso,
> > > +                             map__flags(map));
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > >  struct mark_dso_hit_args {
> > >       const struct perf_tool *tool;
> > > +     struct perf_sample *sample;
> > >       struct machine *machine;
> > > -     u8 cpumode;
> > > +     const struct evsel *mmap_evsel;
> > >  };
> > >
> > >  static int mark_dso_hit_callback(struct callchain_cursor_node *node,=
 void *data)
> > > @@ -709,16 +798,8 @@ static int mark_dso_hit_callback(struct callchai=
n_cursor_node *node, void *data)
> > >       struct mark_dso_hit_args *args =3D data;
> > >       struct map *map =3D node->ms.map;
> > >
> > > -     if (map) {
> > > -             struct dso *dso =3D map__dso(map);
> > > -
> > > -             if (dso && !dso__hit(dso)) {
> > > -                     dso__set_hit(dso);
> > > -                     dso__inject_build_id(dso, args->tool, args->mac=
hine,
> > > -                                          args->cpumode, map__flags(=
map));
> > > -             }
> > > -     }
> > > -     return 0;
> > > +     return mark_dso_hit(args->tool, args->sample, args->machine,
> > > +                         args->mmap_evsel, map, /*sample_in_dso=3D*/=
false);
> > >  }
> > >
> > >  int perf_event__inject_buildid(const struct perf_tool *tool, union p=
erf_event *event,
> > > @@ -728,10 +809,16 @@ int perf_event__inject_buildid(const struct per=
f_tool *tool, union perf_event *e
> > >  {
> > >       struct addr_location al;
> > >       struct thread *thread;
> > > +     struct perf_inject *inject =3D container_of(tool, struct perf_i=
nject, tool);
> > >       struct mark_dso_hit_args args =3D {
> > >               .tool =3D tool,
> > > +             /*
> > > +              * Use the parsed sample data of the sample event, whic=
h will
> > > +              * have a later timestamp than the mmap event.
> > > +              */
> > > +             .sample =3D sample,
> > >               .machine =3D machine,
> > > -             .cpumode =3D sample->cpumode,
> > > +             .mmap_evsel =3D inject__mmap_evsel(inject),
> > >       };
> > >
> > >       addr_location__init(&al);
> > > @@ -743,13 +830,8 @@ int perf_event__inject_buildid(const struct perf=
_tool *tool, union perf_event *e
> > >       }
> > >
> > >       if (thread__find_map(thread, sample->cpumode, sample->ip, &al))=
 {
> > > -             struct dso *dso =3D map__dso(al.map);
> > > -
> > > -             if (!dso__hit(dso)) {
> > > -                     dso__set_hit(dso);
> > > -                     dso__inject_build_id(dso, tool, machine,
> > > -                                          sample->cpumode, map__flag=
s(al.map));
> > > -             }
> > > +             mark_dso_hit(tool, sample, machine, args.mmap_evsel, al=
.map,
> > > +                          /*sample_in_dso=3D*/true);
> > >       }
> > >
> > >       sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX=
_STACK_DEPTH,
> > > @@ -1159,17 +1241,27 @@ static int process_build_id(const struct perf=
_tool *tool,
> > >  static int synthesize_build_id(struct perf_inject *inject, struct ds=
o *dso, pid_t machine_pid)
> > >  {
> > >       struct machine *machine =3D perf_session__findnew_machine(injec=
t->session, machine_pid);
> > > -     u8 cpumode =3D dso__is_in_kernel_space(dso) ?
> > > -                     PERF_RECORD_MISC_GUEST_KERNEL :
> > > -                     PERF_RECORD_MISC_GUEST_USER;
> > > +     struct perf_sample synth_sample =3D {
> > > +             .pid       =3D -1,
> > > +             .tid       =3D -1,
> > > +             .time      =3D -1,
> > > +             .stream_id =3D -1,
> > > +             .cpu       =3D -1,
> > > +             .period    =3D 1,
> > > +             .cpumode   =3D dso__is_in_kernel_space(dso)
> > > +             ? PERF_RECORD_MISC_GUEST_KERNEL
> > > +             : PERF_RECORD_MISC_GUEST_USER,
> > > +     };
> > >
> > >       if (!machine)
> > >               return -ENOMEM;
> > >
> > >       dso__set_hit(dso);
> > >
> > > -     return perf_event__synthesize_build_id(&inject->tool, dso, cpum=
ode,
> > > -                                            process_build_id, machin=
e);
> > > +     return perf_event__synthesize_build_id(&inject->tool, &synth_sa=
mple, machine,
> > > +                                            process_build_id, inject=
__mmap_evsel(inject),
> > > +                                            /*misc=3D*/synth_sample.=
cpumode,
> > > +                                            dso__bid(dso), dso__long=
_name(dso));
> > >  }
> > >
> > >  static int guest_session__add_build_ids_cb(struct dso *dso, void *da=
ta)
> > > diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> > > index 451d145fa4ed..8982f68e7230 100644
> > > --- a/tools/perf/util/build-id.c
> > > +++ b/tools/perf/util/build-id.c
> > > @@ -277,8 +277,8 @@ static int write_buildid(const char *name, size_t=
 name_len, struct build_id *bid
> > >       struct perf_record_header_build_id b;
> > >       size_t len;
> > >
> > > -     len =3D name_len + 1;
> > > -     len =3D PERF_ALIGN(len, NAME_ALIGN);
> > > +     len =3D sizeof(b) + name_len + 1;
> > > +     len =3D PERF_ALIGN(len, sizeof(u64));
> > >
> > >       memset(&b, 0, sizeof(b));
> > >       memcpy(&b.data, bid->data, bid->size);
> > > @@ -286,7 +286,7 @@ static int write_buildid(const char *name, size_t=
 name_len, struct build_id *bid
> > >       misc |=3D PERF_RECORD_MISC_BUILD_ID_SIZE;
> > >       b.pid =3D pid;
> > >       b.header.misc =3D misc;
> > > -     b.header.size =3D sizeof(b) + len;
> > > +     b.header.size =3D len;
> > >
> > >       err =3D do_write(fd, &b, sizeof(b));
> > >       if (err < 0)
> > > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/syn=
thetic-events.c
> > > index 0a7f93ae76fb..6bb62e4e2d5d 100644
> > > --- a/tools/perf/util/synthetic-events.c
> > > +++ b/tools/perf/util/synthetic-events.c
> > > @@ -2225,28 +2225,48 @@ int perf_event__synthesize_tracing_data(const=
 struct perf_tool *tool, int fd, st
> > >  }
> > >  #endif
> > >
> > > -int perf_event__synthesize_build_id(const struct perf_tool *tool, st=
ruct dso *pos, u16 misc,
> > > -                                 perf_event__handler_t process, stru=
ct machine *machine)
> > > +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> > > +                                 struct perf_sample *sample,
> > > +                                 struct machine *machine,
> > > +                                 perf_event__handler_t process,
> > > +                                 const struct evsel *evsel,
> > > +                                 __u16 misc,
> > > +                                 const struct build_id *bid,
> > > +                                 const char *filename)
> > >  {
> > >       union perf_event ev;
> > >       size_t len;
> > >
> > > -     if (!dso__hit(pos))
> > > -             return 0;
> > > +     len =3D sizeof(ev.build_id) + strlen(filename) + 1;
> > > +     len =3D PERF_ALIGN(len, sizeof(u64));
> > >
> > > -     memset(&ev, 0, sizeof(ev));
> > > +     memset(&ev, 0, len);
> > >
> > > -     len =3D dso__long_name_len(pos) + 1;
> > > -     len =3D PERF_ALIGN(len, NAME_ALIGN);
> > > -     ev.build_id.size =3D min(dso__bid(pos)->size, sizeof(dso__bid(p=
os)->data));
> > > -     memcpy(&ev.build_id.build_id, dso__bid(pos)->data, ev.build_id.=
size);
> > > +     ev.build_id.size =3D min(bid->size, sizeof(ev.build_id.build_id=
));
> > > +     memcpy(ev.build_id.build_id, bid->data, ev.build_id.size);
> > >       ev.build_id.header.type =3D PERF_RECORD_HEADER_BUILD_ID;
> > >       ev.build_id.header.misc =3D misc | PERF_RECORD_MISC_BUILD_ID_SI=
ZE;
> > >       ev.build_id.pid =3D machine->pid;
> > > -     ev.build_id.header.size =3D sizeof(ev.build_id) + len;
> > > -     memcpy(&ev.build_id.filename, dso__long_name(pos), dso__long_na=
me_len(pos));
> > > +     ev.build_id.header.size =3D len;
> > > +     strcpy(ev.build_id.filename, filename);
> > > +
> > > +     if (evsel) {
> > > +             void *array =3D &ev;
> > > +             int ret;
> > >
> > > -     return process(tool, &ev, NULL, machine);
> > > +             array +=3D ev.header.size;
> > > +             ret =3D perf_event__synthesize_id_sample(array, evsel->=
core.attr.sample_type, sample);
> > > +             if (ret < 0)
> > > +                     return ret;
> > > +
> > > +             if (ret & 7) {
> > > +                     pr_err("Bad id sample size %d\n", ret);
> > > +                     return -EINVAL;
> > > +             }
> > > +
> > > +             ev.header.size +=3D ret;
> > > +     }
> > > +     return process(tool, &ev, sample, machine);
> > >  }
> > >
> > >  int perf_event__synthesize_stat_events(struct perf_stat_config *conf=
ig, const struct perf_tool *tool,
> > > diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/syn=
thetic-events.h
> > > index 31df7653677f..795bf3e18396 100644
> > > --- a/tools/perf/util/synthetic-events.h
> > > +++ b/tools/perf/util/synthetic-events.h
> > > @@ -9,6 +9,7 @@
> > >  #include <perf/cpumap.h>
> > >
> > >  struct auxtrace_record;
> > > +struct build_id;
> > >  struct dso;
> > >  struct evlist;
> > >  struct evsel;
> > > @@ -45,7 +46,14 @@ typedef int (*perf_event__handler_t)(const struct =
perf_tool *tool, union perf_ev
> > >
> > >  int perf_event__synthesize_attrs(const struct perf_tool *tool, struc=
t evlist *evlist, perf_event__handler_t process);
> > >  int perf_event__synthesize_attr(const struct perf_tool *tool, struct=
 perf_event_attr *attr, u32 ids, u64 *id, perf_event__handler_t process);
> > > -int perf_event__synthesize_build_id(const struct perf_tool *tool, st=
ruct dso *pos, u16 misc, perf_event__handler_t process, struct machine *mac=
hine);
> > > +int perf_event__synthesize_build_id(const struct perf_tool *tool,
> > > +                                 struct perf_sample *sample,
> > > +                                 struct machine *machine,
> > > +                                 perf_event__handler_t process,
> > > +                                 const struct evsel *evsel,
> > > +                                 __u16 misc,
> > > +                                 const struct build_id *bid,
> > > +                                 const char *filename);
> > >  int perf_event__synthesize_cpu_map(const struct perf_tool *tool, con=
st struct perf_cpu_map *cpus, perf_event__handler_t process, struct machine=
 *machine);
> > >  int perf_event__synthesize_event_update_cpus(const struct perf_tool =
*tool, struct evsel *evsel, perf_event__handler_t process);
> > >  int perf_event__synthesize_event_update_name(const struct perf_tool =
*tool, struct evsel *evsel, perf_event__handler_t process);
> > > --
> > > 2.46.0.184.g6999bdac58-goog
