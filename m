Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kiTSkIrk"
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D0181
	for <linux-perf-users@vger.kernel.org>; Wed,  6 Dec 2023 15:52:13 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50bf1de91c6so696e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Dec 2023 15:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701906731; x=1702511531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JRy9QKnZQ2wD2vqqNpyfc7KXoHKfLLWhWrukAC+2vc=;
        b=kiTSkIrk08zMvTsY/u2jWGsb4ACBmhuqNYJ7P+bt3sZZ+9tBDbPdNXE0diGUi9w1Rd
         iImQV5tpwooNDJCrsbZG9t6eBglaDPHwKupm7Jw1oOiRMq+MRrqFRcj8Uf2STpPOOqU7
         RFbWnquS6wxX8cOe/0DntUN9vDfcEVdEM+Mquo8IdnK0fY8ordq1O4CnAb6esq+SbnKe
         q+pKqGbjdyQREF3RmJgnsCo7cpTsOHpYHaiLECl8l+bTp+wdbu0wjP4jt4a3SDIj7Ddp
         C+238cze1wKBTGdGGMJGDWKzPWLh3gwWfgbXdzxWDZTQ+hEx+0Ecg6e4JmJbqpNh27bD
         w9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701906731; x=1702511531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9JRy9QKnZQ2wD2vqqNpyfc7KXoHKfLLWhWrukAC+2vc=;
        b=RbTr7GLLyHnkuGm9AtxhOuhCoyaDPE7bn7CQEi/bplFtH/CNQc9/jNDjjn2hBUKPpM
         NhEFixmPqlvRrKe3n0QMONRK9lZELJksaFRO2BBkrG41cRTfSbOJhT5vT4QzvJwizZ8P
         JPvHoshpEgKLxxVC+C74yBDKhjLoSqpZvThW0FTlUDhdVjY5EORQasMQoB+KuaItlOge
         006oIVRmRLPtbv+bsTqHZtx2M0C43QUcimWi1Bpe7VR2mDwOwBUtlj2Ad0WtGBUz4X+u
         5PZO17ZyjcfVgntr5PDoucJGKunbNGZqHqj1H9YI4xj5+QdyvNK+vPC6NvmcT0DPyTPE
         14wg==
X-Gm-Message-State: AOJu0YzfFhBU9tff6cMxnDUWYUs8nMzhs6XgrPVi8vIWudGcS6bJTol5
	S9ShAv9JHM3yuRmimzaErywQeQCVcGjsbiKAWrcYag==
X-Google-Smtp-Source: AGHT+IEDRey9U3du+bRBThK7i4w3wyFbH5lEV2nlrBpZjYOyRO7V6GBFwWiWjqpwqCClU0Z30ZTp7oVV/W1E4MOwO/Y=
X-Received: by 2002:a05:6512:90e:b0:50b:e8ea:ad with SMTP id
 e14-20020a056512090e00b0050be8ea00admr93855lft.0.1701906731080; Wed, 06 Dec
 2023 15:52:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-20-irogers@google.com>
 <CAM9d7chpynqmnGpi+wpn0f3XvEtDNSisgdQcXQu_2LuHcLNuVA@mail.gmail.com>
In-Reply-To: <CAM9d7chpynqmnGpi+wpn0f3XvEtDNSisgdQcXQu_2LuHcLNuVA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Dec 2023 15:51:58 -0800
Message-ID: <CAP-5=fWGGmQWf7hH8Qqe01YNO3dc0DCDSqa3bHbKMSGioJnyTw@mail.gmail.com>
Subject: Re: [PATCH v5 19/50] perf maps: Do simple merge if given map doesn't overlap
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 4:06=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Simplify merge in for the simple case of a non-overlapping map.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
>
> A nitpick below.
>
> > ---
> >  tools/perf/util/maps.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
> > index 40df08dd9bf3..14e1a169433d 100644
> > --- a/tools/perf/util/maps.c
> > +++ b/tools/perf/util/maps.c
> > @@ -696,9 +696,20 @@ void maps__fixup_end(struct maps *maps)
> >  int maps__merge_in(struct maps *kmaps, struct map *new_map)
> >  {
> >         struct map_rb_node *rb_node;
> > +       struct rb_node *first;
> > +       bool overlaps;
> >         LIST_HEAD(merged);
> >         int err =3D 0;
> >
> > +       down_read(maps__lock(kmaps));
> > +       first =3D first_ending_after(kmaps, new_map);
> > +       overlaps =3D first &&
> > +               map__start(rb_entry(first, struct map_rb_node, rb_node)=
->map) < map__end(new_map);
>
> Can you please break this like below?
>
>     rb_node =3D first ? rb_entry(first, struct map_rb_node, rb_node) : NU=
LL;
>     overlap =3D rb_node && map__start(rb_node->map) < map_end(new_map);

Done in v6.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +       up_read(maps__lock(kmaps));
> > +
> > +       if (!overlaps)
> > +               return maps__insert(kmaps, new_map);
> > +
> >         maps__for_each_entry(kmaps, rb_node) {
> >                 struct map *old_map =3D rb_node->map;
> >
> > --
> > 2.43.0.rc1.413.gea7ed67945-goog
> >
