Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7EC168D5
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Nov 2023 18:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987CFBB;
	Sun,  5 Nov 2023 10:12:55 -0800 (PST)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3151117b3a.0;
        Sun, 05 Nov 2023 10:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699207975; x=1699812775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE6CsEAM2XNQiggqUIgiyV/o4aLtXLLS/EW3cW4NJuE=;
        b=mKigFjFsKfrEgw/vzLxYwNOAWtnusM9E2V5gKRnELE4qVhY/uY2anE5Qm639Z5QebJ
         GbCtnnZrG9zqk60+vIFAPKEngU4FxyDZT50deuxlhfX7XZyExkA/6p1eWg5kRTW3a/hl
         BfM0Awh1e0Fqy+wGQkDqKLaHx3FUzFW6/DKDOBFxGlsSVEzdjrw+7RpQY8QU+CkWYJxJ
         CnhDjXTGzOZTj9ej6ox+q0nIlitkj6aMWvRlJRGOuyrgbQ8T/vAs0NLd/k2Tc6Flwnc+
         oCDmsnVZp5zjhjaUS8hY7QYoARYDee2vnCrI+tqaLJQndaG2ZbxL+LwoBTnJF6X11BfI
         J1Qw==
X-Gm-Message-State: AOJu0Yx4TQFehD+Zl8hOJbT4RLzImZO3CyC7PoOacmRy1N0UtGOs/E0X
	Gt7/tMdX3ozM53DS5dId2S+PrhNWvHaMotCOig0=
X-Google-Smtp-Source: AGHT+IHympg3nfu1Mj3SQjxVcMt+svmGnNODRbXu9dsVrBzaVHbEV/oXBz5fZs6GNNWJlV1n+WJxKd2Gr7BKZRPXnzw=
X-Received: by 2002:a05:6a21:66c5:b0:180:febc:8ed5 with SMTP id
 ze5-20020a056a2166c500b00180febc8ed5mr16760379pzb.52.1699207974972; Sun, 05
 Nov 2023 10:12:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-4-irogers@google.com>
 <ZUSwOlsOyJdDT1ls@gentoo.org> <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
In-Reply-To: <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Sun, 5 Nov 2023 10:12:43 -0800
Message-ID: <CAM9d7ciqPsR1DNnngZApwkyNd+6AQPtqxBvy=m_jsMnchHvr9w@mail.gmail.com>
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
To: Ian Rogers <irogers@google.com>
Cc: Guilherme Amadio <amadio@gentoo.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 8:49=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, Nov 3, 2023 at 1:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.or=
g> wrote:
> >
> > Hi,
> >
> > On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> > > The event copy in the mmap is used to have storage to a read
> > > event. Not all users of mmaps read the events, such as perf record, s=
o
> > > switch the allocation to being on first read rather than being
> > > embedded within the perf_mmap.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/lib/perf/include/internal/mmap.h | 2 +-
> > >  tools/lib/perf/mmap.c                  | 9 +++++++++
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/=
include/internal/mmap.h
> > > index 5a062af8e9d8..b11aaf5ed645 100644
> > > --- a/tools/lib/perf/include/internal/mmap.h
> > > +++ b/tools/lib/perf/include/internal/mmap.h
> > > @@ -33,7 +33,7 @@ struct perf_mmap {
> > >       bool                     overwrite;
> > >       u64                      flush;
> > >       libperf_unmap_cb_t       unmap_cb;
> > > -     char                     event_copy[PERF_SAMPLE_MAX_SIZE] __ali=
gned(8);
> > > +     void                    *event_copy;
> > >       struct perf_mmap        *next;
> > >  };
> > >
> > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > index 2184814b37dd..91ae46aac378 100644
> > > --- a/tools/lib/perf/mmap.c
> > > +++ b/tools/lib/perf/mmap.c
> > > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct p=
erf_mmap_param *mp,
> > >
> > >  void perf_mmap__munmap(struct perf_mmap *map)
> > >  {
> > > +     free(map->event_copy);
> > > +     map->event_copy =3D NULL;
> > >       if (map && map->base !=3D NULL) {
> >
> > If map can be NULL as the if statement above suggests, then there is a
> > potential a null pointer dereference bug here. Suggestion:
> >
> >     if (!map)
> >         return;
> >
> >     free(map->event_copy);
> >     map->event_copy =3D NULL;
> >     if (map->base !=3D NULL) {
> >
> >     ...
>
> Makes sense, will fix in v5. Waiting to get additional feedback to
> avoid too much email.

Acked-by: Namhyung Kim <namhyung@kernel.org>


But I have another concern (not related to this change).

> >
> > >               munmap(map->base, perf_mmap__mmap_len(map));
> > >               map->base =3D NULL;
> > > @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct =
perf_mmap *map,
> > >                       unsigned int len =3D min(sizeof(*event), size),=
 cpy;

I'm not sure if it's ok to read less than the actual size, IOW
it seems to assume 'size' is smaller than sizeof(*event).
I guess it's true for most cases as union perf_event has
perf_record_mmap2 (among others) which contains a
filename array of size PATH_MAX.

But the SAMPLE record can be larger than that when it has
PERF_SAMPLE_AUX IIRC.  It'd happen only if it crossed the mmap
boundary and I'm afraid it'd corrupt the data.

Thanks,
Namhyung


> > >                       void *dst =3D map->event_copy;
> > >
> > > +                     if (!dst) {
> > > +                             dst =3D malloc(PERF_SAMPLE_MAX_SIZE);
> > > +                             if (!dst)
> > > +                                     return NULL;
> > > +                             map->event_copy =3D dst;
> > > +                     }
> > > +
> > >                       do {
> > >                               cpy =3D min(map->mask + 1 - (offset & m=
ap->mask), len);
> > >                               memcpy(dst, &data[offset & map->mask], =
cpy);
> > > --
> > > 2.42.0.869.gea05f2083d-goog
> > >
> > >
