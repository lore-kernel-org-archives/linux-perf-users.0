Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CF2F3B
	for <linux-perf-users@vger.kernel.org>; Sun,  2 Feb 2025 06:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738479435; cv=none; b=kCm3OzqA+6FlzOmGtUrf4XkcDHSFdx0ost0v1lwQ+s5N8agoDEtezIKj2lQY3O7gEZO+nQg/J6BZN9ni4ZH1mHb/JsJZbiAKtsiwOYFmtnZTJRYocpzMagenB3WsEdrSDB8SykdqC+y7jPdDoD1PrTmsjJbfpxuVwkSWKWBT+6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738479435; c=relaxed/simple;
	bh=5teypsgM7KPW8wWLWYbC6E6LDTEAvO58nbAX0sShsYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tRLwtCRmccoFOedWxCBQGNIkQCbKWeQHA5pxqzicU7SlZsJnFo1JxYuUJ78YT4RLc3iMViffIImJ04grZCQf5sU+PMxZUa8BdHN1umao2uktRH2xv6IwhT6xSJquL0uYaeGAAKWiytQ34mF50ab7F2ivczuuNUeeQ1533J/heXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5A0+Pat; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5A0+Pat"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso154685ab.1
        for <linux-perf-users@vger.kernel.org>; Sat, 01 Feb 2025 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738479432; x=1739084232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f4IJ2VWGSsCYGlLun85YbmIwAy0c5JB+K75XIx659PY=;
        b=Z5A0+PatQgAzKF6nOsQWIUn3cBmcN7KMd1xy562CbXMETnpf9tYBRL4DNfRIrGDzOU
         EEvdairN9YRcebSiGh6+6ffLuceVrjg+YGUuj5VqpzsyxQo3kK9sWQQ/t1Dyt5wRoK9J
         34wgKPFMxwN1+AEG4mxGglO4xlEnO6jM94yDepglaZQTB1zso9HA5Qi4n2xh4Rlw+vqY
         XiC07YSt7OerM8sI9zI9VvrStdusTMyhMK/qK4UngXegcEu2hUxffsWsQpRF3Mhj1JPj
         /jpKeoMFWfvi9lf1ZBE5F1tEKmZsUM1Bwd1eRKB0xVTapNKDmPFUmFgyXGtye70zke5s
         K08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738479432; x=1739084232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f4IJ2VWGSsCYGlLun85YbmIwAy0c5JB+K75XIx659PY=;
        b=SSyMo9T7E1modxOPfs6Gl+cVgnOmyT7+9Vtq/c3EllKWgekwc0qImXNNeq7EvzSXI8
         eXjV1Wos2i/UZO3fKFg0jzvRtB+EIln0G+FR5zMr+DwdmNUaYR6r+kjw6UXig99SGCpl
         1fPteMtTHU3itqqOTtjqmTmDwD/butaW7sG1iF1hG7pJEWt3s/yA7IHU0ZY0u75wubJY
         mtY4kCyHyXcEOiQCd/PR0nVX92qIEjWiGO2NJExqOMZEiNtQ7Bh9rhBLvgY4qjD8H5GR
         UyVN4WHg+dbjUDTR5MRgs4A2kRfmz4/qN/QU9Tpa/Mb8abKeOZ1uUygguzYOr6Hv2K4Y
         pXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVBraQtOCByABmDwAMIkAc8Sjh2GY5jkbttGHvdOCHohxIQ7ehFf9qxjeJarrfDP3oNCmoEhBmAkQIy6SqgN6AC@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdfr15DwLQmcFticO4N5yUAUX0dntXqCVo1gRNUqxvMWZ7WFHX
	IntH2XatXFec/aAJ8k2kKr8TmC0yPHcDuvdqDNlYwgzJNCZ9g+Cz/Zv3eZjKjNJeQZ800S80JCT
	zWQcc6FQxQHhG3WXpXAPqYUhWZ1s28x5K2ILl
X-Gm-Gg: ASbGncutiCytnHyPNoSD3CHo34ovG6ddJjkAZsHDtLHBMaUFKq4pUBtVilQvR6kmBOi
	mAUPw3MlnDiA/pwcu7geOlXG7m4ZLLDgTI4SIEgF7etUwUoXuET8278Ox7SFQ0hDRsZUerF7HWA
	==
X-Google-Smtp-Source: AGHT+IEMCGMsEyNaEz5vqStfpqcfIbTu0nLBbJusx3hcdEWYef+1X6P/IiWKbJv1IMaDw0Zpbbp1fMZ4G1/qJFnSb0c=
X-Received: by 2002:a05:6e02:1fe7:b0:3cf:fcc5:793c with SMTP id
 e9e14a558f8ab-3d02029d2dcmr2933215ab.16.1738479432379; Sat, 01 Feb 2025
 22:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250130030525.1482498-1-namhyung@kernel.org> <20250130030525.1482498-2-namhyung@kernel.org>
In-Reply-To: <20250130030525.1482498-2-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 22:57:00 -0800
X-Gm-Features: AWEUYZlW-7ky4mflKVsXFwM9ET-AgsQ7PYMTYeOtFujoP5P6CP1MThqpCgJWl1c
Message-ID: <CAP-5=fVJDi2UuhTYk5g-QaLqZC29tAprKWs_0PKNmd+y=iugjA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf trace: Allocate syscall stats only if summary
 is on
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Howard Chu <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The syscall stats are used only when summary is requested.  Let's avoid
> unnecessary operations.  Pass 'trace' pointer to check summary and give
> output file together.

I don't think this last sentence makes sense.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/builtin-trace.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index ac97632f13dc8f7c..7e0324a2e9182088 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1522,13 +1522,14 @@ struct thread_trace {
>         struct intlist *syscall_stats;
>  };
>
> -static struct thread_trace *thread_trace__new(void)
> +static struct thread_trace *thread_trace__new(struct trace *trace)
>  {
>         struct thread_trace *ttrace =3D  zalloc(sizeof(struct thread_trac=
e));
>
>         if (ttrace) {
>                 ttrace->files.max =3D -1;
> -               ttrace->syscall_stats =3D intlist__new(NULL);
> +               if (trace->summary)
> +                       ttrace->syscall_stats =3D intlist__new(NULL);
>         }
>
>         return ttrace;
> @@ -1550,7 +1551,7 @@ static void thread_trace__delete(void *pttrace)
>         free(ttrace);
>  }
>
> -static struct thread_trace *thread__trace(struct thread *thread, FILE *f=
p)
> +static struct thread_trace *thread__trace(struct thread *thread, struct =
trace *trace)
>  {
>         struct thread_trace *ttrace;
>
> @@ -1558,7 +1559,7 @@ static struct thread_trace *thread__trace(struct th=
read *thread, FILE *fp)
>                 goto fail;
>
>         if (thread__priv(thread) =3D=3D NULL)
> -               thread__set_priv(thread, thread_trace__new());
> +               thread__set_priv(thread, thread_trace__new(trace));
>
>         if (thread__priv(thread) =3D=3D NULL)
>                 goto fail;
> @@ -1568,7 +1569,7 @@ static struct thread_trace *thread__trace(struct th=
read *thread, FILE *fp)
>
>         return ttrace;
>  fail:
> -       color_fprintf(fp, PERF_COLOR_RED,
> +       color_fprintf(trace->output, PERF_COLOR_RED,
>                       "WARNING: not enough memory, dropping samples!\n");
>         return NULL;
>  }
> @@ -2622,7 +2623,7 @@ static int trace__sys_enter(struct trace *trace, st=
ruct evsel *evsel,
>                 return -1;
>
>         thread =3D machine__findnew_thread(trace->host, sample->pid, samp=
le->tid);
> -       ttrace =3D thread__trace(thread, trace->output);
> +       ttrace =3D thread__trace(thread, trace);
>         if (ttrace =3D=3D NULL)
>                 goto out_put;
>
> @@ -2699,7 +2700,7 @@ static int trace__fprintf_sys_enter(struct trace *t=
race, struct evsel *evsel,
>                 return -1;
>
>         thread =3D machine__findnew_thread(trace->host, sample->pid, samp=
le->tid);
> -       ttrace =3D thread__trace(thread, trace->output);
> +       ttrace =3D thread__trace(thread, trace);
>         /*
>          * We need to get ttrace just to make sure it is there when sysca=
ll__scnprintf_args()
>          * and the rest of the beautifiers accessing it via struct syscal=
l_arg touches it.
> @@ -2771,7 +2772,7 @@ static int trace__sys_exit(struct trace *trace, str=
uct evsel *evsel,
>                 return -1;
>
>         thread =3D machine__findnew_thread(trace->host, sample->pid, samp=
le->tid);
> -       ttrace =3D thread__trace(thread, trace->output);
> +       ttrace =3D thread__trace(thread, trace);
>         if (ttrace =3D=3D NULL)
>                 goto out_put;
>
> @@ -2960,7 +2961,7 @@ static int trace__sched_stat_runtime(struct trace *=
trace, struct evsel *evsel,
>         struct thread *thread =3D machine__findnew_thread(trace->host,
>                                                         sample->pid,
>                                                         sample->tid);
> -       struct thread_trace *ttrace =3D thread__trace(thread, trace->outp=
ut);
> +       struct thread_trace *ttrace =3D thread__trace(thread, trace);
>
>         if (ttrace =3D=3D NULL)
>                 goto out_dump;
> @@ -3214,7 +3215,7 @@ static int trace__pgfault(struct trace *trace,
>                 }
>         }
>
> -       ttrace =3D thread__trace(thread, trace->output);
> +       ttrace =3D thread__trace(thread, trace);
>         if (ttrace =3D=3D NULL)
>                 goto out_put;
>
> --
> 2.48.1.262.g85cc9f2d1e-goog
>
