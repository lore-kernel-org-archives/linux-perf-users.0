Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4C81C680
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 15:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZKx1CqI"
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3CDD45
	for <linux-perf-users@vger.kernel.org>; Fri,  3 Nov 2023 08:49:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50931d0bb04so4507e87.0
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Nov 2023 08:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699026548; x=1699631348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=392tRVZxGtLzEQKNmN3YbTUmZB8ld747UCZRAgobKm8=;
        b=UZKx1CqInR3ZeR64N91T0FSZEPRZo1d1rEecXwYALVpexcC2FJwf91mbbc63ZOfcEY
         8X7OlfWW72Ux4QbdmuthKz7KYFyW/zKhWwbnOt6sZhpW7R3XoxPpE5jQuL/CYOzjLArx
         ColqZoYu3wXV1VN00nzqihQKVnVLWuy4jkSgXiRK2kSiO0do/6/OXb2PtuKPkijEnR2w
         H+d7ZTK8S2QQ8mPKIurYbjJHX2/YsasFcxl9BVuqQc4Y8ex+tARiBU1bEXsCvGW8b6jy
         +4l4yywj+D8+o8NO1qbUabZ9hXaydgqwBaSGrhQVaKsZtITueVoF2rwfwkR2Qs3NohX8
         8yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699026548; x=1699631348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=392tRVZxGtLzEQKNmN3YbTUmZB8ld747UCZRAgobKm8=;
        b=chLUpyf4a/OUdQF0oghB35GOcHUjTwJfmc6A2kYftNlQLb5BDhxi+LUUh1lDViFQiv
         tJk9or/w5p4gosHZVNoAgkjE+nRODN2XUdOLP9cCIWwl2zbLHA+nMiOF+UEPn47EQMCn
         aYPAvyAvt5+igmh4rly/T76zW/PpD57d9p8lmz1gpXTf/qSTlgBSvb5LsmG+4SbOsSDj
         /5FO4i0UWhxk3nMKv4DgTKKjtQcSRg0Mwc3yIUTCMIRDrP6Fn472yovB2HXLM0yHJEp+
         ve+SCYzYZq6S7SCp0lpB2nVVIDR0rce3SPsVqQSRWsU6BbXOAwE6ikikY6GovbqZrlgh
         glrA==
X-Gm-Message-State: AOJu0Yzt2hMwYvbTvO4XwLFeoJtQb3QvgRdalyMEKtt1xGwPrY59KFEW
	zFeH8mHFItDPaarV9OkoZ/TMisbDapVRw0YLO6h2kw==
X-Google-Smtp-Source: AGHT+IEU9qY8K6ePCFkLTQIgMKJOq3f4OTO41CbKsFGSamfOG3t42TUBCLCjTt0zydqgegKWmoCdQvuLKRyGEhr5cCM=
X-Received: by 2002:a19:9153:0:b0:501:b029:1a47 with SMTP id
 y19-20020a199153000000b00501b0291a47mr120339lfj.1.1699026548121; Fri, 03 Nov
 2023 08:49:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-4-irogers@google.com>
 <ZUSwOlsOyJdDT1ls@gentoo.org>
In-Reply-To: <ZUSwOlsOyJdDT1ls@gentoo.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 3 Nov 2023 08:48:56 -0700
Message-ID: <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
To: Guilherme Amadio <amadio@gentoo.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Vincent Whitchurch <vincent.whitchurch@axis.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 1:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.org>=
 wrote:
>
> Hi,
>
> On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> > The event copy in the mmap is used to have storage to a read
> > event. Not all users of mmaps read the events, such as perf record, so
> > switch the allocation to being on first read rather than being
> > embedded within the perf_mmap.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/lib/perf/include/internal/mmap.h | 2 +-
> >  tools/lib/perf/mmap.c                  | 9 +++++++++
> >  2 files changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/perf/in=
clude/internal/mmap.h
> > index 5a062af8e9d8..b11aaf5ed645 100644
> > --- a/tools/lib/perf/include/internal/mmap.h
> > +++ b/tools/lib/perf/include/internal/mmap.h
> > @@ -33,7 +33,7 @@ struct perf_mmap {
> >       bool                     overwrite;
> >       u64                      flush;
> >       libperf_unmap_cb_t       unmap_cb;
> > -     char                     event_copy[PERF_SAMPLE_MAX_SIZE] __align=
ed(8);
> > +     void                    *event_copy;
> >       struct perf_mmap        *next;
> >  };
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 2184814b37dd..91ae46aac378 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct per=
f_mmap_param *mp,
> >
> >  void perf_mmap__munmap(struct perf_mmap *map)
> >  {
> > +     free(map->event_copy);
> > +     map->event_copy =3D NULL;
> >       if (map && map->base !=3D NULL) {
>
> If map can be NULL as the if statement above suggests, then there is a
> potential a null pointer dereference bug here. Suggestion:
>
>     if (!map)
>         return;
>
>     free(map->event_copy);
>     map->event_copy =3D NULL;
>     if (map->base !=3D NULL) {
>
>     ...

Makes sense, will fix in v5. Waiting to get additional feedback to
avoid too much email.

Thanks,
Ian

> Cheers,
> -Guilherme
>
> >               munmap(map->base, perf_mmap__mmap_len(map));
> >               map->base =3D NULL;
> > @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struct pe=
rf_mmap *map,
> >                       unsigned int len =3D min(sizeof(*event), size), c=
py;
> >                       void *dst =3D map->event_copy;
> >
> > +                     if (!dst) {
> > +                             dst =3D malloc(PERF_SAMPLE_MAX_SIZE);
> > +                             if (!dst)
> > +                                     return NULL;
> > +                             map->event_copy =3D dst;
> > +                     }
> > +
> >                       do {
> >                               cpy =3D min(map->mask + 1 - (offset & map=
->mask), len);
> >                               memcpy(dst, &data[offset & map->mask], cp=
y);
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
> >
