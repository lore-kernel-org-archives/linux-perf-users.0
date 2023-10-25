Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408EE1FD9
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 03:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tp7T40oX"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D191DA2
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 20:28:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a085efa7so1552e87.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Oct 2023 20:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698204498; x=1698809298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DCko5+DNPl5YusM8wx4UX9bq30OCtxNf7RBElMFnTtk=;
        b=tp7T40oX3P32yX/sFih4mfvleS95R8xZRAHgZmNzczX5OJjfMuoi/LMvnmPesHBtF+
         cISc96OazgIHlI0JwxArK3e7sySsaOCNGdhXS1jFbJct8D6pUKYCkfjeSQPSY5Xq7sJq
         nrBsW+JeLCn69GTrFf6ZzClZ+bMEiOsMG5oVfixGOl/3EofmNK+Di5cSrXg6sB8HV56m
         EjthGNUntYYLJkaCrQ1YSpUm5lE/iXfIXQIt5/18uSsn2SfNvMkX0xN9aMtGUPQo5tuQ
         UF9YezhT/c5v3PbP8nJSG6gKS2tbvA0K/2MeWi1aWPpRD0TWmh8Fd0T37GoJSXCHHyRp
         opnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698204498; x=1698809298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DCko5+DNPl5YusM8wx4UX9bq30OCtxNf7RBElMFnTtk=;
        b=OkLkSfH3d2uihh1X08fZ1CF6G2Vgcqj2TLKl2PpCSXhcDczdoRpStkQDA4FK6KDaB1
         bigZsQlisEfPLWy9HkJmbirxp1/dGM72UltCncoQMQVJelT73OEofN+i5YBG5jfPX+6+
         7Etzw17zFNpQqqIUTXttQjC5aho32cIPnvQ5S2pWSTniEeOKPfm8L8nZR64R0NwMeegK
         00opA+MfoR7unGTVnPSdSs2Nm2Z9+oVbTFIKBWuq9gUwpElGtGUdv2ikHC8fYu9WR809
         JHy57JR5Gqrs3F+JqN+SqgJzb+RGb98VhTzFsqfsL7qUyjfs2Aq+LTXVSKIq7jM8NfkH
         3dgA==
X-Gm-Message-State: AOJu0YzLANEpTz8jUur1vtR7W0JrYF9DO0V70IwwdlhgfyDiW/owLurY
	ZTmVfOzhyTQjVc9/Bm7OeItW/RgG5Zx6mRf/rMVKAA==
X-Google-Smtp-Source: AGHT+IFeLTh1yjfRikYLn5I7KOGB3atpEKVmC+SBw+D4qBEkHs0UKGbkCiL0qX0EM3uoMQFwAG3J59s+zr3L50i6xPs=
X-Received: by 2002:a05:6512:3582:b0:502:932e:2e36 with SMTP id
 m2-20020a056512358200b00502932e2e36mr25055lfr.2.1698204497691; Tue, 24 Oct
 2023 20:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-14-irogers@google.com>
 <4d275fcd-a102-662f-d9f7-3acd3586acf2@huawei.com>
In-Reply-To: <4d275fcd-a102-662f-d9f7-3acd3586acf2@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 24 Oct 2023 20:28:05 -0700
Message-ID: <CAP-5=fXej_aBnvtdYJvKFMVKtmm+xXSCxOR-pNkTfr_qHmjWLA@mail.gmail.com>
Subject: Re: [PATCH v3 13/50] libperf: Lazily allocate mmap event copy
To: Yang Jihong <yangjihong1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nick Terrell <terrelln@fb.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Song Liu <song@kernel.org>, 
	Sandipan Das <sandipan.das@amd.com>, James Clark <james.clark@arm.com>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Liam Howlett <liam.howlett@oracle.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Kajol Jain <kjain@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 24, 2023 at 7:39=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/10/25 6:23, Ian Rogers wrote:
> > The event copy in the mmap is used to have storage to a read
> > event. Not all users of mmaps read the events, such as perf record, so
> > switch the allocation to being on first read rather than being
> > embedded within the perf_mmap.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/lib/perf/include/internal/mmap.h | 2 +-
> >   tools/lib/perf/mmap.c                  | 9 +++++++++
> >   2 files changed, 10 insertions(+), 1 deletion(-)
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
> >   };
> >
> > diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
> > index 2184814b37dd..91ae46aac378 100644
> > --- a/tools/lib/perf/mmap.c
> > +++ b/tools/lib/perf/mmap.c
> > @@ -51,6 +51,8 @@ int perf_mmap__mmap(struct perf_mmap *map, struct per=
f_mmap_param *mp,
> >
> >   void perf_mmap__munmap(struct perf_mmap *map)
> >   {
> > +     free(map->event_copy);
> > +     map->event_copy =3D NULL;
> >       if (map && map->base !=3D NULL) {
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
> `event` is used as the return parameter of libperf API
> perf_mmap__read_event().
> Is `zalloc` better to avoid dirty data?

We could but I'd prefer not to zero unnecessarily. We've had similar
uninitialized memory being copied to perf.data file problems such as:
http://lore.kernel.org/lkml/20210309234945.419254-1-irogers@google.com
With the sanitizers help we can avoid the problem and do less work,
which I think is best.

Thanks,
Ian

> Thanks,
> Yang
