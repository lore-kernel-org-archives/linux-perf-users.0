Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F7F6ABC
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 17:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C8pRHVV7"
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0583137
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 10:01:04 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507a5edc2ebso15e87.1
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Oct 2023 10:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698253263; x=1698858063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CErK5br5TeZeV3yT6FzK4rCa2/wdScC7HtXwgBBWNM=;
        b=C8pRHVV7PGXgLbb7kecm58lrGzc2eZzwU4trhydekIrotjWlqhhxhJ9yfUXbduZPpL
         QOsKWUfpIIFWBtX9ZJQKvEyB4Eyhm3ICD3fJwnZIx2lPhuML5yMXT8OxOF1TlLy5hyLc
         DudxdWvkQ2Ef8MHLdC6BMWubiDwuaOkTZhFtYs6vYfQFuueJ6JsFqKDltiJjpDIT/5Py
         4oaWgr202I53viyE5nLQgsFRxsdszothuSzyR3lGmH8+FMCG4AQMTTDUlymgneStLRKo
         EmkHWmFeeM7rcoR2fJwwGaVzc+pVedsTa1QZfRxghI757DcpfN7B2VnKlcE5tjJY8glO
         kFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698253263; x=1698858063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CErK5br5TeZeV3yT6FzK4rCa2/wdScC7HtXwgBBWNM=;
        b=K6GjJi28RXpcndJFCvPbW88hxqXy5ZhtSGt2qxD25YdKrgoLGDL1C4oj4EunWml3u2
         CDe8TOTuYU9Zd8FinSE3AzCBAeKid87BMAnaOjHNEXf0KKQMW9kU1XQMebjzmLyKQUn9
         do3zrwCHGQW4NM+pw82/Xtc2vAsavtMkNIDyAKLqiEz0C+aWu+EAxTE/FR8xwrqOx/xm
         hWd5MO8MCQvh6+7pXH/PiP2SqCAuj5Or/sAfGhf7K9aSm927S8V70aGTDv5060AWV1ax
         K7421CHk/jWVP5r1dSFR5BSDPp1u6/hHQX6oKJvX1ZUdrVP7dRdjWtc3mZC5v/wI9Tbp
         aiaA==
X-Gm-Message-State: AOJu0YwLNubtTrJt76KbpwocDJN/zqEPTy3IUqvY6FSSJl3yY2mn+Kev
	8i8P5zBMnu+qFcVP0Bw8fLY3tKjni2Pzjoyvv4+euw==
X-Google-Smtp-Source: AGHT+IGe+Z5mxuVh5PNb8OXDmKV7m5nxvS6TySaRCJoW9fAIMA5Cv+Vg2c6I/ppQyoQ2RBZz4+bbaZsCPgXbmZlEV58=
X-Received: by 2002:a05:6512:202a:b0:507:968f:a6e7 with SMTP id
 s10-20020a056512202a00b00507968fa6e7mr73984lfs.5.1698253262469; Wed, 25 Oct
 2023 10:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com> <20231024222353.3024098-21-irogers@google.com>
 <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com>
In-Reply-To: <7516348d-fe6d-9768-049e-328cfcda89ee@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Oct 2023 10:00:50 -0700
Message-ID: <CAP-5=fX2Mk9uUfbnF75B=2xFjGy3HWtjPaM-B0-_KWaHjBW0qQ@mail.gmail.com>
Subject: Re: [PATCH v3 20/50] perf record: Be lazier in allocating lost
 samples buffer
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

On Tue, Oct 24, 2023 at 8:44=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> Hello,
>
> On 2023/10/25 6:23, Ian Rogers wrote:
> > Wait until a lost sample occurs to allocate the lost samples buffer,
> > often the buffer isn't necessary. This saves a 64kb allocation and
> > 5.3kb of peak memory consumption.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/builtin-record.c | 29 +++++++++++++++++++----------
> >   1 file changed, 19 insertions(+), 10 deletions(-)
> >
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 9b4f3805ca92..b6c8c1371b39 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -1924,21 +1924,13 @@ static void __record__save_lost_samples(struct =
record *rec, struct evsel *evsel,
> >   static void record__read_lost_samples(struct record *rec)
> >   {
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
>
> Can zalloc for `lost` be moved to __record__save_lost_samples?
> This simplifies the code.

Hmm.. seems marginal. This change makes the code not return in
record__read_lost_samples when the memory allocation fails, so I'm
50/50 on it.

Thanks,
Ian

>
>
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index dcf288a4fb9a..8d2eb746031a 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1888,14 +1888,25 @@ record__switch_output(struct record *rec, bool
> at_exit)
>   }
>
>   static void __record__save_lost_samples(struct record *rec, struct
> evsel *evsel,
> -                                       struct perf_record_lost_samples
> *lost,
> +                                       struct perf_record_lost_samples
> **plost,
>                                          int cpu_idx, int thread_idx,
> u64 lost_count,
>                                          u16 misc_flag)
>   {
>          struct perf_sample_id *sid;
>          struct perf_sample sample =3D {};
> +       struct perf_record_lost_samples *lost =3D *plost;
>          int id_hdr_size;
>
> +       if (!lost) {
> +               lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> +               if (!lost) {
> +                       pr_debug("Memory allocation failed\n");
> +                       return;
> +               }
> +               lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> +               *plost =3D lost;
> +       }
> +
>          lost->lost =3D lost_count;
>          if (evsel->core.ids) {
>                  sid =3D xyarray__entry(evsel->core.sample_id, cpu_idx,
> thread_idx);
> @@ -1912,21 +1923,13 @@ static void __record__save_lost_samples(struct
> record *rec, struct evsel *evsel,
>   static void record__read_lost_samples(struct record *rec)
>   {
>          struct perf_session *session =3D rec->session;
> -       struct perf_record_lost_samples *lost;
> +       struct perf_record_lost_samples *lost =3D NULL;
>          struct evsel *evsel;
>
>          /* there was an error during record__open */
>          if (session->evlist =3D=3D NULL)
>                  return;
>
> -       lost =3D zalloc(PERF_SAMPLE_MAX_SIZE);
> -       if (lost =3D=3D NULL) {
> -               pr_debug("Memory allocation failed\n");
> -               return;
> -       }
> -
> -       lost->header.type =3D PERF_RECORD_LOST_SAMPLES;
> -
>          evlist__for_each_entry(session->evlist, evsel) {
>                  struct xyarray *xy =3D evsel->core.sample_id;
>                  u64 lost_count;
> @@ -1949,7 +1952,7 @@ static void record__read_lost_samples(struct
> record *rec)
>                                  }
>
>                                  if (count.lost) {
> -                                       __record__save_lost_samples(rec,
> evsel, lost,
> +                                       __record__save_lost_samples(rec,
> evsel, &lost,
>                                                                      x,
> y, count.lost, 0);
>                                  }
>                          }
> @@ -1957,11 +1960,12 @@ static void record__read_lost_samples(struct
> record *rec)
>
>                  lost_count =3D perf_bpf_filter__lost_count(evsel);
>                  if (lost_count)
> -                       __record__save_lost_samples(rec, evsel, lost, 0,
> 0, lost_count,
> +                       __record__save_lost_samples(rec, evsel, &lost,
> 0, 0, lost_count,
>
> PERF_RECORD_MISC_LOST_SAMPLES_BPF);
>          }
>   out:
> -       free(lost);
> +       if (lost)
> +               free(lost);
>   }
>
>   static volatile sig_atomic_t workload_exec_errno;
>
>
> Thanks,
> Yang
>
