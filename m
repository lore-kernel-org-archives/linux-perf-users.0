Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F125B2FD
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752595186; cv=none; b=QeMb+Z2Gh3/GGqa0De/jlfK1yMN6536gCQNbvIiWIaIUTpRyO/sY00fdmLJKRMzBi+bFgHE42V63RIHVNfqsBUnSmurY4ITU4X6e92S0vP9l7ENqCBO27h15DCBNRtmsianUrNqORm9NOw0JmiOtArpxcnOPm/qKcC++fY+a5uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752595186; c=relaxed/simple;
	bh=SO+6g7o/ZjbM2rcFnIpi+V/EETHH7Usu17xarsd/Rmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZeVlb/2qOIq27zPwRGFzqdmUTIm+nO3BdIGPX/fJBHxQjjwYvKHF8iJQtuFFcIvv9/FVckJ8HcYynUqAMrhF1o/rMUa+3nU0UkxVb9H/NDvHIFByLpYSb/7SmEZfY/WsCLiCJ+RxbFgBj9gV4FtnSuh05OwxdM21aqAms/beXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hlcr0scC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hlcr0scC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752595184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/s/ADGtvXMWewI0r7M3gOb6jNBFn+F6nkxyg2k3MFVo=;
	b=hlcr0scCNdkekOSNlmyro0zf3QxgCHFjnU8L4m1pcMZ2/Hb3o5neX2i82guL0MqZrJj5GV
	PlqDGTRSsyFVcJvJ4l37Zk4gDxmCwN2IZz3Wa0khimOYHxq84zmIn7l7QD9YN1YPiZ/0AL
	XB2FQp5oh9Rrc4/6t6CGnurgQ+YPt7Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-tJ9bYPr9PqyNHJlMyFbm-w-1; Tue, 15 Jul 2025 11:59:42 -0400
X-MC-Unique: tJ9bYPr9PqyNHJlMyFbm-w-1
X-Mimecast-MFC-AGG-ID: tJ9bYPr9PqyNHJlMyFbm-w_1752595181
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-558fb43d03dso4205180e87.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Jul 2025 08:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752595181; x=1753199981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/s/ADGtvXMWewI0r7M3gOb6jNBFn+F6nkxyg2k3MFVo=;
        b=QY3Gv6+GL+fVO4MwJjHOhtXMkNWrx/CZpugH8Sf3S3lbVYYL6BMKvKwzjKgJvULztq
         P3bfMeK228oXVhtoeX6TSXo8Nd+FyX85QvVT13jY/Km4rJ2F6ys5Sve9Oel4wk8HG7cN
         kjp78MR6c37DxSmrmRWP79n05qApQ92NEDQCphqU0d5Z4Pv9Km8wklA3oC8wXw8LPL/1
         4B/ifmsu727JZqnfe+oN4Aw4bzHGMdMxBitWSX6NHjHMYuWnn4rEHZ4nepuWVfBbCjDI
         ryS1cozGRYNgxxAW822fq+rkOvooABFPXIMWm0WNxfwFW33JRFG4FXVXMikW1U9OdU+s
         h+HA==
X-Forwarded-Encrypted: i=1; AJvYcCUJqNiYhpGplhLKUgcz+DtY31+UV9vcEG3D6pqw1WlsNrsFZvwgm3UuYdgssMzbd1zRH+1iHX9sw+Tk3o7bZf2X@vger.kernel.org
X-Gm-Message-State: AOJu0YxUUdp6e5NnrFLiUWv+BbNLT/TQQNCrhVctr7Ae6cET2fZ3vSk8
	rLIz2a4hhra9JxkAA36dpV3nxdfnD8TO8Z5az4FNlvpKZJVlUBMlKDBAUSmGaEZQrrGnmyuSyp1
	pSFtOkab4G6M9WBrjmPFcvpYsoIBu8oedV2tMYcApaHh+tmU6B9nHKjyIsG/UvNG8kNlQLI/rZd
	FV2HFiefjoH/3FYdeH2TKemzLPUjB+f6gCuFslhfx4rkOu+Q==
X-Gm-Gg: ASbGncsk9liTQL0XqDOMrhd2DdJrP/r++2D7d3FcnQF6wQYiQLtkhiCrM7qx9asm89c
	TIVhwpM8RHjmXzHD9AlevAO9TGNmG8rEdmKmu7S6JZ1dvzXeqSBV2VjtcJFMhitzoYYA2zUASQx
	mJWMrG4JAnqzJTQZHPV7j5Vf4=
X-Received: by 2002:a05:651c:544:b0:30b:edfc:5d8a with SMTP id 38308e7fff4ca-33052f6db47mr55543301fa.0.1752595181211;
        Tue, 15 Jul 2025 08:59:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHAIUjE6HYuipOWojOY7zHmEgFQRfACN8Mr4nyVrw1NmqxT0s4SK2nIbyT92KLlmwFf0M6mNsAGV1cM7Rp/u4=
X-Received: by 2002:a05:651c:544:b0:30b:edfc:5d8a with SMTP id
 38308e7fff4ca-33052f6db47mr55543141fa.0.1752595180744; Tue, 15 Jul 2025
 08:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709143119.91147-2-ashelat@redhat.com> <aHFtzFZEvCp0B6V2@google.com>
In-Reply-To: <aHFtzFZEvCp0B6V2@google.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Tue, 15 Jul 2025 11:59:29 -0400
X-Gm-Features: Ac12FXy6KQ9PQGac-kJbGG9O75wlVCphCY4NUYxbw2Rp7Cp_HAYZjkqN-WOlcr0
Message-ID: <CA+G8DhKB3H-nNyKNmgOd_uj-YnfBTS8pSz6dFqZ5+gnxf-z7oQ@mail.gmail.com>
Subject: Re: [PATCH] perf sched timehist: decode process names of processes in
 zombie state
To: Namhyung Kim <namhyung@kernel.org>
Cc: mpetlan@redhat.com, acme@kernel.org, irogers@google.com, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When I tried to build, it threw the error:

builtin-sched.c: In function =E2=80=98timehist_print_sample=E2=80=99:
builtin-sched.c:2186:29: error: declaration of =E2=80=98prev_comm=E2=80=99 =
shadows a
previous local [-Werror=3Dshadow]
 2186 |                 const char *prev_comm =3D evsel__strval(evsel,
sample, "prev_comm");
      |                             ^~~~~~~~~
builtin-sched.c:2154:21: note: shadowed declaration is here
 2154 |         const char *prev_comm =3D evsel__strval(evsel, sample,
"prev_comm");
      |                     ^~~~~~~~~
builtin-sched.c:2154:21: error: unused variable =E2=80=98prev_comm=E2=80=99
[-Werror=3Dunused-variable]


Anubhav

On Fri, Jul 11, 2025 at 4:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, Jul 09, 2025 at 10:31:20AM -0400, Anubhav Shelat wrote:
> > Previously when running perf trace timehist --state, when recording
> > processes in the zombie state the process name would not be decoded
> > properly and appears with just the PID:
> >
> > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0=
.019      0.041      S
> > 1140057.412222 [0012]  :1248612[1248612]                   0.000      0=
.000      0.332      Z
> > 1140057.412275 [0004]  <idle>                              0.052      0=
.052      0.953      I
> > 1140057.412284 [0008]  <idle>                              0.070      0=
.070      0.932      I
> > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0=
.112      0.058      S
> >
> > Now some extra processing has been added to decode the process name:
> >
> > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956      0=
.019      0.041      S
> > 1140057.412222 [0012]  sleep[1248612]                      0.000      0=
.000      0.332      Z
> > 1140057.412275 [0004]  <idle>                              0.052      0=
.052      0.953      I
> > 1140057.412284 [0008]  <idle>                              0.070      0=
.070      0.932      I
> > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953      0=
.112      0.058      S
>
> Thanks for the fix.  A nitpick below.
>
> >
> > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > ---
> >  tools/perf/builtin-sched.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> > index 26ece6e9bfd1..e1a931341bc8 100644
> > --- a/tools/perf/builtin-sched.c
> > +++ b/tools/perf/builtin-sched.c
> > @@ -2023,11 +2023,15 @@ static int comm_width =3D 30;
> >  static char *timehist_get_commstr(struct thread *thread)
> >  {
> >       static char str[32];
> > -     const char *comm =3D thread__comm_str(thread);
> > +     char *comm =3D (char *) thread__comm_str(thread);
> > +     char *empty =3D (char *) "";
> >       pid_t tid =3D thread__tid(thread);
> >       pid_t pid =3D thread__pid(thread);
> >       int n;
> >
> > +     if (*comm =3D=3D ':')
> > +             comm =3D empty;
> > +
> >       if (pid =3D=3D 0)
> >               n =3D scnprintf(str, sizeof(str), "%s", comm);
> >
> > @@ -2147,6 +2151,8 @@ static void timehist_print_sample(struct perf_sch=
ed *sched,
> >       struct thread_runtime *tr =3D thread__priv(thread);
> >       const char *next_comm =3D evsel__strval(evsel, sample, "next_comm=
");
> >       const u32 next_pid =3D evsel__intval(evsel, sample, "next_pid");
> > +     const char *prev_comm =3D evsel__strval(evsel, sample, "prev_comm=
");
> > +     char *comm_str =3D timehist_get_commstr(thread);
> >       u32 max_cpus =3D sched->max_cpu.cpu + 1;
> >       char tstr[64];
> >       char nstr[30];
> > @@ -2173,8 +2179,15 @@ static void timehist_print_sample(struct perf_sc=
hed *sched,
> >               }
> >               printf(" ");
> >       }
> > -
> > -     printf(" %-*s ", comm_width, timehist_get_commstr(thread));
> > +
> > +     /* if a process is in zombie state commstr will start with a '[' =
and
> > +      * we need to do extra processing to decode the process name */
> > +     if (*comm_str =3D=3D '[') {
> > +             printf(" %s", evsel__strval(evsel, sample, "prev_comm"));
> > +             printf("%-*s ", comm_width - (int) strlen(prev_comm), com=
m_str);
> > +     }
> > +     else
> > +             printf(" %-*s ", comm_width, comm_str);
>
> What about just updating thread comm if it's missing?
>
>         if (!thread__comm_set(thread)) {
>                 const char *prev_comm =3D evsel__strval(evsel, sample, "p=
rev_comm");
>                 thread__set_comm(thread, prev_comm, sample->time);
>         }
>
>         printf(" %-%s ", comm_width, timehist_get_commstr(thread));
>
> Thanks,
> Namhyung
>
> >
> >       if (sched->show_prio)
> >               printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(e=
vsel, thread, sample));
> > --
> > 2.50.0
> >
>

