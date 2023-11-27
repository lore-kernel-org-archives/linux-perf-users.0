Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t9mKuVfR"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C710D8
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 11:28:38 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50babb66dedso5377e87.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 11:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701113316; x=1701718116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emsUw2/bJXpid3wTNhP0ePyetslR3hOrktzFF6VS7Tk=;
        b=t9mKuVfRYSi11h4hMOeCOUqEwtrsSrLieu0r+Iw880q0KBobBe8KEzYRcTBKlf9RI3
         DekwH/ccmNl/UqUaBmFXIEsd01cbAsm75bNqGV5SmQbZgMvOr2RwQ6sGCbPwoUjZYha2
         VTQSfnqFw9gXGcUUS9iGQLNbksr+BEap9jBmNZaF5aA2xdgRp3/7QHmSgQC3EQ9owuz7
         DPHqWSrZ7aJ/1PgU+AQWfkPDhzRecUROp6gPJOLk9XrvdkdAo6HJ8kzS6juYs1Gwdpc2
         Lm4/P0WQHB0j+WNPYyEoq2Dzrxzahr1gpaldntzzmuMcWVP4pWg9Z7wHtvU4XMekpR7x
         9pgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113316; x=1701718116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emsUw2/bJXpid3wTNhP0ePyetslR3hOrktzFF6VS7Tk=;
        b=jhnIbEfO+QxLCUBN3jgCMZ2WZqSP1iD8LRNDty4VqnuqwQqwb+vwnjFGK0F1F9zjAb
         C3qV/STn1wxZF18yUWcO2lndrm+YUr8fx40311TlcLE/NPo36zzD+6MhgBpBBImeDMuw
         I3LWIlhgyNCXV7e+P+kBhicdyFMV5fh/0MdKWxJoavG/Ps00x+O9EHnCVCB5FPKQFXCT
         jED/UjIJVdXR6Zjqdt44YxY4bb/r/q5QKdd4Z5XRVDNHLev6aXJdP/XS1wMMQBdDI1Ut
         HDJqe7rrI2R7SyZ/c3YmMRr34+zGvdJ2zerO9Vyq9V4cnwTTIT6FhQ76VQmHz9xq4K+Z
         u+pA==
X-Gm-Message-State: AOJu0Yxo9R5UY1ZjvaX//AH5W6fhBVKYjkW/KuG5j9+d8UUj2PeFzOMT
	hpT8C9PAlo/yR5bYDRYwD6gBMFdi0v9Rmwp3XRualA==
X-Google-Smtp-Source: AGHT+IGqz5YV8saJWdO+etbO+UPSAP/D4OHFvMdJV3aIAzcmDHsaTLH1laau0c92fGE4K+1K5IgG18qww6GSfojHddI=
X-Received: by 2002:ac2:4c8e:0:b0:50a:a790:30b9 with SMTP id
 d14-20020ac24c8e000000b0050aa79030b9mr324468lfl.0.1701113315882; Mon, 27 Nov
 2023 11:28:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-4-irogers@google.com>
 <ZUSwOlsOyJdDT1ls@gentoo.org> <CAP-5=fVm5rmOTvXi1LZzSEc3wHv68HszOfZmBb-RG=eUj2UVHg@mail.gmail.com>
 <CAM9d7ciqPsR1DNnngZApwkyNd+6AQPtqxBvy=m_jsMnchHvr9w@mail.gmail.com>
In-Reply-To: <CAM9d7ciqPsR1DNnngZApwkyNd+6AQPtqxBvy=m_jsMnchHvr9w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 11:28:24 -0800
Message-ID: <CAP-5=fXFPnpOvYJeKTeDGDjDw4FD1KS22U+D0Aeffx3qaNW7MQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/53] libperf: Lazily allocate mmap event copy
To: Namhyung Kim <namhyung@kernel.org>
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

On Sun, Nov 5, 2023 at 10:12=E2=80=AFAM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Nov 3, 2023 at 8:49=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
> >
> > On Fri, Nov 3, 2023 at 1:33=E2=80=AFAM Guilherme Amadio <amadio@gentoo.=
org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, Nov 02, 2023 at 10:56:45AM -0700, Ian Rogers wrote:
> > > > The event copy in the mmap is used to have storage to a read
> > > > event. Not all users of mmaps read the events, such as perf record,=
 so
> > > > switch the allocation to being on first read rather than being
> > > > embedded within the perf_mmap.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/lib/perf/include/internal/mmap.h | 2 +-
> > > >  tools/lib/perf/mmap.c                  | 9 +++++++++
> > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/lib/perf/include/internal/mmap.h b/tools/lib/per=
f/include/internal/mmap.h
> > > > index 5a062af8e9d8..b11aaf5ed645 100644
> > > > --- a/tools/lib/perf/include/internal/mmap.h
> > > > +++ b/tools/lib/perf/include/internal/mmap.h
> > > > @@ -33,7 +33,7 @@ struct perf_mmap {
> > > >       bool                     overwrite;
> > > >       u64                      flush;
> > > >       libperf_unmap_cb_t       unmap_cb;
> > > > -     char                     event_copy[PERF_SAMPLE_MAX_SIZE] __a=
ligned(8);
> > > > +     void                    *event_copy;
> > > >       struct perf_mmap        *next;
> > > >  };
> > > >
> > > > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > > > index 2184814b37dd..91ae46aac378 100644
> > > > --- a/tools/lib/perf/mmap.c
> > > > +++ b/tools/lib/perf/mmap.c
> > > > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct=
 perf_mmap_param *mp,
> > > >
> > > >  void perf_mmap__munmap(struct perf_mmap *map)
> > > >  {
> > > > +     free(map->event_copy);
> > > > +     map->event_copy =3D NULL;
> > > >       if (map && map->base !=3D NULL) {
> > >
> > > If map can be NULL as the if statement above suggests, then there is =
a
> > > potential a null pointer dereference bug here. Suggestion:
> > >
> > >     if (!map)
> > >         return;
> > >
> > >     free(map->event_copy);
> > >     map->event_copy =3D NULL;
> > >     if (map->base !=3D NULL) {
> > >
> > >     ...
> >
> > Makes sense, will fix in v5. Waiting to get additional feedback to
> > avoid too much email.
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
>
> But I have another concern (not related to this change).
>
> > >
> > > >               munmap(map->base, perf_mmap__mmap_len(map));
> > > >               map->base =3D NULL;
> > > > @@ -226,6 +228,13 @@ static union perf_event *perf_mmap__read(struc=
t perf_mmap *map,
> > > >                       unsigned int len =3D min(sizeof(*event), size=
), cpy;
>
> I'm not sure if it's ok to read less than the actual size, IOW
> it seems to assume 'size' is smaller than sizeof(*event).
> I guess it's true for most cases as union perf_event has
> perf_record_mmap2 (among others) which contains a
> filename array of size PATH_MAX.
>
> But the SAMPLE record can be larger than that when it has
> PERF_SAMPLE_AUX IIRC.  It'd happen only if it crossed the mmap
> boundary and I'm afraid it'd corrupt the data.

Thanks, I was thinking this would just be a drop in change but I think
given this feedback it would be better to switch from allocating once
a PERF_SAMPLE_MAX_SIZE buffer to allocating or reallocating one based
on size. This potentially saves memory when size is less than
PERF_SAMPLE_MAX_SIZE and by removing the min calculation for the
amount copied (len) we can potentially exceed it and fix a potential
bug. I'll add this in v5.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > >                       void *dst =3D map->event_copy;
> > > >
> > > > +                     if (!dst) {
> > > > +                             dst =3D malloc(PERF_SAMPLE_MAX_SIZE);
> > > > +                             if (!dst)
> > > > +                                     return NULL;
> > > > +                             map->event_copy =3D dst;
> > > > +                     }
> > > > +
> > > >                       do {
> > > >                               cpy =3D min(map->mask + 1 - (offset &=
 map->mask), len);
> > > >                               memcpy(dst, &data[offset & map->mask]=
, cpy);
> > > > --
> > > > 2.42.0.869.gea05f2083d-goog
> > > >
> > > >
