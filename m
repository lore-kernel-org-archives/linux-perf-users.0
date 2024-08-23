Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9135C47A7C;
	Fri, 23 Aug 2024 04:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724385925; cv=none; b=KpFBgwG37r2yOWb6wkACEQSMfB09RuKXN9x/xmKknEVft7dCS3+7CbR39UF/SB4s+QezQZnwbVlaIOJZyEsfNoQDlasEIh638t4WJ4Y5LxBPQj+wyVrSJMWSbbn8Bk6I7jqJv0LFhLSA3cLbjc1KbGY2pWMCfaffzzKcxg81pUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724385925; c=relaxed/simple;
	bh=unFcSoRafG2tQZVIb3XLQD5IIG3f0AZYTrwVmRgmU9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nl0DEz6cD6sUPWtXSYecnzpD7ysAWnThr/7YmUraDTFkIiQvS/U7hisrghBeMJojr2Rwc9ggqCqnyUJETW3vdgG/E904M27wWAuZASCUhtnVqISoZilEoWn+eLzk14FL9wKA2KSkievs7ID6eJLKkSlW5vjsrK0KtbueC2x5DMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pk2Ccgwr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pk2Ccgwr"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c32daf0797so15939787b3.0;
        Thu, 22 Aug 2024 21:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724385922; x=1724990722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=007om7FbnVA1/sSaH1/Z0H7IlWO16A2yApr1RpemrwM=;
        b=Pk2CcgwrOoG9TULKQ3rSM7e5W+87xnYcU2Rx21/5D+O8Ycrd1MpCvKAgfTXtVBzQVb
         hBaM9eKiGB3A84S45rAouI3UplaDs0GkhpJo23Pa1CrdDC1GZSMP/7lIj67juymrw81A
         SUIB0d027VCrwP/qHn+6sttWLxUaBol0BsEq2rXCfu44jzfJEDD2dfSpxHvyY4SktxS4
         sc0lMxUKOmnC8YTNfNf8h8YmRZvpFN6Pfxt/7NyKhpMBGgAKLUi1uLc1r6tYTjWFmR0h
         wuMl3XiBMfHoVtWe6fQSXMh294N5/hNKmdTekqsJOzZYxmMdXZj32/R3EfFWAeo/K6Mp
         eBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724385922; x=1724990722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=007om7FbnVA1/sSaH1/Z0H7IlWO16A2yApr1RpemrwM=;
        b=Pw8Peg45wMavMRuoNRgXFveAK3Eq7HEI10WLhnqDz0ISbsd/GnfCNFhoZz2znYnHU4
         9+b4GocuhzrIv7rrxxAlCNwA8AzrUlrc33dFQmZTealq3gN9KrqB3kM1gK+nJyjcAYru
         meQnH3EtjrBb9kAROhZ2eD5QMHHHtFQ++lJe1nzmABDnrN0Cbdn+lqt9YE5nBDNVgfx6
         +Zdh81ecw6umSV01o4snAxWOWFRzCVYIRtPYJArJ/M0dmtwd0Zpb2LWKnngDrQ2SZ2vc
         luLoIdiYjpfzMKG8F+KRkfg7qnVZLpHoXeUHUlHTr/g7GXdenlBfPhvnAE+WHl+Zmx1N
         bGYg==
X-Forwarded-Encrypted: i=1; AJvYcCUKNzlGc795PpL6KGxDTY0uPrgH7Z+7wF4SOtzuPU5qsIDhAA8KPf26L0VBT32lPzUzDMZYyjDQeHd3vxQ=@vger.kernel.org, AJvYcCVuA5WJihZRkvQAQtYfsNQymrqB27WvT+oVA7YnwWaPrqa6aOVisac9M6rT8JGkdTga8swVKKL28ST1+z6SFXgjFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfgkk4mkrAKJKcegMKAwfuCEKVEefa3rh6BMme4Dp1BkcYpor
	SC5zzA3XrNhRrUJhwVJB1NfOPA1FxzMN8vYseBugZSyKCC8iHLulRilnKVOHKhw2xJCunluq/4C
	VQWXJXMTU9db7OsScgExJY61TgjQ=
X-Google-Smtp-Source: AGHT+IG5A4QgseUEyX+ceIYYIhxwSO6f3o/ON96XDMe77yLSaK64HR/0DEXBgCmXabw0+kKmEeg7LMlxzcbqfhz63hk=
X-Received: by 2002:a05:690c:4288:b0:650:858c:9b9c with SMTP id
 00721157ae682-6c62962718bmr9082827b3.29.1724385922411; Thu, 22 Aug 2024
 21:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-6-howardchu95@gmail.com> <Zsd8vqCrTh5h69rp@x1> <Zsd_278bECAXUzmC@x1>
In-Reply-To: <Zsd_278bECAXUzmC@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Fri, 23 Aug 2024 12:05:11 +0800
Message-ID: <CAH0uvoia0ewN+KomxwUEYDvsLyLXCO4_0+jzCc=HZkB_Sz1+OQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] perf trace: Add a new argument to trace__btf_scnprintf()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Aug 23, 2024 at 2:13=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Thu, Aug 22, 2024 at 03:00:30PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Thu, Aug 15, 2024 at 09:36:21AM +0800, Howard Chu wrote:
> > > Pass the struct syscall_arg, so that we can use the augmented_arg lat=
er
> > > in the struct augmentation.
> >
> > Breaks the build with:
> >
> > builtin-trace.c: In function =E2=80=98trace__btf_scnprintf=E2=80=99:
> > builtin-trace.c:1011:78: error: unused parameter =E2=80=98arg=E2=80=99 =
[-Werror=3Dunused-parameter]
> >  1011 |                                    size_t size, int val, struct=
 syscall_arg *arg, char *type)
> >       |                                                          ~~~~~~=
~~~~~~~~~~~~~~^~~
> >   LD      /tmp/build/perf-tools-next/util/perf-util-in.o
> >   LD      /tmp/build/perf-tools-next/perf-util-in.o
> >   AR      /tmp/build/perf-tools-next/libperf-util.a
> >   GEN     /tmp/build/perf-tools-next/python/perf.cpython-312-x86_64-lin=
ux-gnu.so
> > cc1: all warnings being treated as errors
> >
> > So we either use __maybe_unused at this point or combine it with the
> > patch where it really gets used. I think the later is better, will do.
>
> So here what I think we should do is to use the patch below, ok? I'm
> continuing...
>
> - Arnaldo
>
> ---
>
> From 2c1ea68ac3d18109d96bd16e2860e076d2e0d61e Mon Sep 17 00:00:00 2001
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date: Thu, 22 Aug 2024 15:10:27 -0300
> Subject: [PATCH 1/1] perf trace: Pass the richer 'struct syscall_arg' poi=
nter
>  to trace__btf_scnprintf()
>
> Since we'll need it later in the current patch series and we can get the
> syscall_arg_fmt from syscall_arg->fmt.
>
> Based-on-a-patch-by: Howard Chu <howardchu95@gmail.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Link: https://lore.kernel.org/lkml/Zsd8vqCrTh5h69rp@x1
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/builtin-trace.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 37ca96e130a5862d..a909880bd25e51d1 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -1007,9 +1007,11 @@ static size_t btf_enum_scnprintf(const struct btf_=
type *type, struct btf *btf, c
>         return 0;
>  }
>
> -static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_a=
rg_fmt *arg_fmt, char *bf,
> +static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_a=
rg *arg, char *bf,
>                                    size_t size, int val, char *type)
>  {
> +       struct syscall_arg_fmt *arg_fmt =3D arg->fmt;
> +
>         if (trace->btf =3D=3D NULL)
>                 return 0;
>
> @@ -1029,7 +1031,7 @@ static size_t trace__btf_scnprintf(struct trace *tr=
ace, struct syscall_arg_fmt *
>  }
>
>  #else // HAVE_LIBBPF_SUPPORT
> -static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, s=
truct syscall_arg_fmt *arg_fmt __maybe_unused,
> +static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, s=
truct syscall_arg *arg __maybe_unused,
>                                    char *bf __maybe_unused, size_t size _=
_maybe_unused, int val __maybe_unused,
>                                    char *type __maybe_unused)
>  {
> @@ -2284,7 +2286,7 @@ static size_t syscall__scnprintf_args(struct syscal=
l *sc, char *bf, size_t size,
>                         if (trace->show_arg_names)
>                                 printed +=3D scnprintf(bf + printed, size=
 - printed, "%s: ", field->name);
>
> -                       btf_printed =3D trace__btf_scnprintf(trace, &sc->=
arg_fmt[arg.idx], bf + printed,
> +                       btf_printed =3D trace__btf_scnprintf(trace, &arg,=
 bf + printed,
>                                                            size - printed=
, val, field->type);
>                         if (btf_printed) {
>                                 printed +=3D btf_printed;
> @@ -2987,7 +2989,7 @@ static size_t trace__fprintf_tp_fields(struct trace=
 *trace, struct evsel *evsel,
>                 if (trace->show_arg_names)
>                         printed +=3D scnprintf(bf + printed, size - print=
ed, "%s: ", field->name);
>
> -               btf_printed =3D trace__btf_scnprintf(trace, arg, bf + pri=
nted, size - printed, val, field->type);
> +               btf_printed =3D trace__btf_scnprintf(trace, &syscall_arg,=
 bf + printed, size - printed, val, field->type);
>                 if (btf_printed) {
>                         printed +=3D btf_printed;
>                         continue;
> --
> 2.46.0

We pass the syscall_arg to get both format and augmented args, I think
that's the best way to do it.

LGTM, thank you.

Thanks,
Howard

>
