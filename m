Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru8s6rf4"
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF51BFC
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:24:11 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1006a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701123850; x=1701728650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmP8GOI7JkkxmTyMBdqzQqt4c8PGieST5QFR6LpGVHM=;
        b=ru8s6rf4SdyDiakiI3lU93uyo4VZAa/8Q9SBt6XqX8PE5M5TsuLBYV0TvlPOYI2UaE
         pFirz2fti3dHqs74fAw7fdZY3WDG5ds+qYF9+oIY7CYEOQJJ20TbplF6JgshVqYmFEpd
         Ve5UBxRGeVQqLhLLT+oa7nsRLFXRev/xYP+vQxtLYC+UO4rPIFl6ZZwK+wj86+dBE7ry
         hYuLP0gbAbPc9zA6QR1SJxskYU1ahtZH+mJtlFi/AFoixsdNCygnQjxmmTjgAsVxcTTC
         FIFkuaRFa2ApX/2ESmawViq380AeBqLsFYRNBm6QUL9DlMQbO79soEcVYQ3H6E2ph6rO
         fzRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701123850; x=1701728650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YmP8GOI7JkkxmTyMBdqzQqt4c8PGieST5QFR6LpGVHM=;
        b=Qu3q6Cz2q0pMvurEyWFFBqHEpmPyJ/jpkKs1lFEdzS4xI4N6cHKIqIY4NNt8trvt3u
         rePvvGTeJOpnWZzQfcX3eiRBpNe9x830rmiIsXWuAeTPIYY/02XhqYJvsU5re3QIwXsm
         Eo+WafaGg715tUCF7VTc3FQVVigqa2DSZr1+iHOqqhn425HfY7fvosLosHwQI3XHMkU/
         mW7/CTiuVrJCPqbF5535SfBCQN3jD3u8ymCAnGrU7/09d4VxsP7wOCm88n9wBRdi5mfs
         2v9sPWlG0Qx+Syv0a5o0OZTLMwgol8fY3F4gUcHY1oQ68uSKYKT1x1TNPyj/CDD1Z00l
         kC5Q==
X-Gm-Message-State: AOJu0Yyi7v9ZgUj5yj1hLDjLptDaYXTtIL2+IC7j7qzBuOG/ofNX2N04
	gMt/TQja/a+anAGPuzpE7TK1S8w5wIMXWXBpqexBZA==
X-Google-Smtp-Source: AGHT+IFPGQQLLsmn5pSHaDD7xCHGkPLfyC9s84L46POWLo93bm155s8MDJGxkGQUW+f0egAGpZ7TKp/p+A+fz9+xN5k=
X-Received: by 2002:aa7:d983:0:b0:54b:8f42:e3dc with SMTP id
 u3-20020aa7d983000000b0054b8f42e3dcmr143243eds.2.1701123849509; Mon, 27 Nov
 2023 14:24:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com> <20231102175735.2272696-11-irogers@google.com>
 <ZWUSNLmApMByu94B@kernel.org>
In-Reply-To: <ZWUSNLmApMByu94B@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 14:23:57 -0800
Message-ID: <CAP-5=fVfYR2xCi=ZiT-xmcRzq2y6L6gZg8i_DWMPzhzWyeLsgQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/53] perf record: Be lazier in allocating lost
 samples buffer
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

On Mon, Nov 27, 2023 at 2:03=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Nov 02, 2023 at 10:56:52AM -0700, Ian Rogers escreveu:
> > Wait until a lost sample occurs to allocate the lost samples buffer,
> > often the buffer isn't necessary. This saves a 64kb allocation and
> > 5.3kb of peak memory consumption.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9b4f3805ca92..b6c8c1371b39 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct =
record *rec, struct evsel *evsel,
> >  static void record__read_lost_samples(struct record *rec)
> >  {
> >       struct perf_session *session =3D rec->session;
> > -     struct perf_record_lost_samples *lost;
> > +     struct perf_record_lost_samples *lost =3D NULL;
> >       struct evsel *evsel;
> >
> >       /* there was an error during record__open */
> >       if (session->evlist =3D=3D NULL)
> >               return;
> >
> > -     lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > -     if (lost =3D=3D NULL) {
> > -             pr_debug("Memory allocation failed\n");
> > -             return;
> > -     }
>
> Shouldn't we take the time here and instead improve this error message
> and then propagate the error?
>
> For instance, we may want to still get some perf.data file without these
> records but inform the user at this point how many records were lost
> (count.lost)?

Sounds like a follow-up, the messages here are just moving the
existing message and the point of the patch is to postpone/avoid a
memory allocation when possible.

Thanks,
Ian

> - Arnaldo
>
> > -
> > -     lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> > -
> >       evlist__for_each_entry(session->evlist, evsel) {
> >               struct xyarray *xy =3D evsel->core.sample_id;
> >               u64 lost_count;
> > @@ -1961,6 +1953,14 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >                               }
> >
> >                               if (count.lost) {
> > +                                     if (!lost) {
> > +                                             lost =3D zalloc(PERF_SAMP=
LE_MAX_SIZE);
> > +                                             if (!lost) {
> > +                                                     pr_debug("Memory =
allocation failed\n");
> > +                                                     return;
> > +                                             }
> > +                                             lost->header.type =3D PER=
F_RECORD_LOST_SAMPLES;
> > +                                     }
> >                                       __record__save_lost_samples(rec, =
evsel, lost,
> >                                                                   x, y,=
 count.lost, 0);
> >                               }
> > @@ -1968,9 +1968,18 @@ static void record__read_lost_samples(struct rec=
ord *rec)
> >               }
> >
> >               lost_count =3D perf_bpf_filter__lost_count(evsel);
> > -             if (lost_count)
> > +             if (lost_count) {
> > +                     if (!lost) {
> > +                             lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> > +                             if (!lost) {
> > +                                     pr_debug("Memory allocation faile=
d\n");
> > +                                     return;
> > +                             }
> > +                             lost->header.type =3D PERF_RECORD_LOST_SA=
MPLES;
> > +                     }
> >                       __record__save_lost_samples(rec, evsel, lost, 0, =
0, lost_count,
> >                                                   PERF_RECORD_MISC_LOST=
_SAMPLES_BPF);
> > +             }
> >       }
> >  out:
> >       free(lost);
> > --
> > 2.42.0.869.gea05f2083d-goog
> >
>
> --
>
> - Arnaldo
