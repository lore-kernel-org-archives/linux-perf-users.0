Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141DD29AB13
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698338; cv=none; b=Wkme/RcIAr9ZheHuV60mZOPGHyu1wKM5nLBhVy3hXKdh6AII/d5e8X/U2dHS9CraHlUjTGU6kmmcS2Hi6Oxa+ja1DtWxmDw8eKVavDw8DWmKWN1rBI9bhFxYbXlaNr2hvUHSxi9FM4PGIxMijS+Cbso4/gBce4xc8nz3Nf91Hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698338; c=relaxed/simple;
	bh=4b9dCB7uVA5w5RCtTnmunbPMHyI+fvfrqoVNlrbQTjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2pnexwaYE3kiaKCMLwX1TS8wMh4N7caO59BPbAFQO0HEANN0xXWhEg+PC3PpBFwENaz1+soOfgysNEqbwNu39IYDeMjnHoH3slcL5i8hqPrVQ0LHMnpNmW2D1Nf2qWuBqh8QSrIYPs4IV+y1Vp8LE7n0VCVf5jQN/OWtVuBEVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDHCdhez; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDHCdhez"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752698334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xY8gUnvpobKv4/aQ3mQ9PIXQV+nadZUVPTvlqujhXdk=;
	b=ZDHCdhezgiMGZrWpeBMzyI2qLMtYZjBWf7eT1USv+uZHaJAj93L4cjku4Zwep4i9hn0fMH
	jtNMPiK9yhD4q6K7iqUqHbBP81LmsycfsWpQJFXquYu5J+TWUs3UiTKmiUe5pDT8TdJoH+
	7ehLUo4PTloBt2WOjHJ0AkntFAa/wio=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-V2hBx-lXPGqBaNFeCS9bZw-1; Wed, 16 Jul 2025 16:38:53 -0400
X-MC-Unique: V2hBx-lXPGqBaNFeCS9bZw-1
X-Mimecast-MFC-AGG-ID: V2hBx-lXPGqBaNFeCS9bZw_1752698332
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-55629c3a5daso232281e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 13:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752698332; x=1753303132;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xY8gUnvpobKv4/aQ3mQ9PIXQV+nadZUVPTvlqujhXdk=;
        b=ontck9zmvxmT8OHs/ePO8uUR7uXH2jEZ7d8KqZp9qFId5ghWr8VgOeFC39lWBiX0I9
         yjtgOmYzM+460fZnK488DQlAK/fTwfz1mvw0W/omlCr7bnMHJgvsVO19LuYfxFM3hx5k
         0TIpntNZAYZUNYpnGLhtrVZ2CXobGlAKH0cCxibxdv92o67Ix5eYf7zViOwkm4V63hlk
         zOOpI3AM2nm82pAypDhyDbpvvMwGCjUNAG3BvJIZqdIVNeOr4EMtGG09RSGhHfOX0zPN
         oitl98Xc6ccSGYN+y0EQaHfdEjhTBHJHGn+oa4w18u637g0ciXYb4dgw7lpvsb1w37eH
         c69g==
X-Forwarded-Encrypted: i=1; AJvYcCXoASgUi/VllT2azdouF1sADtfvjExxHQliVbPTtcXBMegCNWOR4sbRZGpoyltBwYNHSg62lSnz6N6bWoj/bxB7@vger.kernel.org
X-Gm-Message-State: AOJu0YyuaeSgPV5/WyBGVqHA47J+QLCG84Q6PcaUXiJeGWM3ubN0n+nB
	QLHgMY+/vQFMln1Ylths8ugU1tC80jYbAw22FQmYy9zPYHbm8o06A6LfSgimL55EbK45NRcgwDk
	6eEh/ZmPqv71uExpYP0bVGUMGChC2X6aqtJGUbqms8qc+NhheIQsBl50plzZn6Hs1p7ZaZf5QyG
	1Xqyhu6rbCmyRBWV2qwJWHGYvuQfviS5RQDEGjV31ZSE+QGL9NvK+WMGkf
X-Gm-Gg: ASbGncsOeEfasebAqOLhJVNKCU3e1QVnVP4uXgiaE0Viid0uTq7i1BIxawO9BffrgSs
	OnhOerKqn0+SlxQYdm5fLjvdtzi56swR3tlYGks7wh6runU5VN7CtB5PmzjK/JDi/JoPXPkDm0I
	sHUh5qu8JGrGrt6fCwzUVKvi0=
X-Received: by 2002:a05:6512:3f08:b0:553:ad28:210a with SMTP id 2adb3069b0e04-55a233efa6emr1487421e87.51.1752698331913;
        Wed, 16 Jul 2025 13:38:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3d8ZErTr13ORmYwVRyQx6Xa3GyB551UCdAxVhh41hIYvatpT7Kym3S4YHqCfZ7R9jOU/FuQQTPDq78gckdKQ=
X-Received: by 2002:a05:6512:3f08:b0:553:ad28:210a with SMTP id
 2adb3069b0e04-55a233efa6emr1487406e87.51.1752698331420; Wed, 16 Jul 2025
 13:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709143119.91147-2-ashelat@redhat.com> <aHFtzFZEvCp0B6V2@google.com>
 <CA+G8DhKB3H-nNyKNmgOd_uj-YnfBTS8pSz6dFqZ5+gnxf-z7oQ@mail.gmail.com> <aHf_IDvsyOubNm24@google.com>
In-Reply-To: <aHf_IDvsyOubNm24@google.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Wed, 16 Jul 2025 16:38:40 -0400
X-Gm-Features: Ac12FXw7pPzxsqwpC1Udhmew_7U2dEUtTte3cEJyNgfjcV8YVIFxdqLfcjmvaTs
Message-ID: <CA+G8DhLPC59kokzJFajfhxu6g0n4sQC8odHoHeRp+MwPbf8Htg@mail.gmail.com>
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

Yep you're right. Sending it now.

Thanks,
Anubhav

On Wed, Jul 16, 2025 at 3:36=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Tue, Jul 15, 2025 at 11:59:29AM -0400, Anubhav Shelat wrote:
> > When I tried to build, it threw the error:
> >
> > builtin-sched.c: In function =E2=80=98timehist_print_sample=E2=80=99:
> > builtin-sched.c:2186:29: error: declaration of =E2=80=98prev_comm=E2=80=
=99 shadows a
> > previous local [-Werror=3Dshadow]
> >  2186 |                 const char *prev_comm =3D evsel__strval(evsel,
> > sample, "prev_comm");
> >       |                             ^~~~~~~~~
> > builtin-sched.c:2154:21: note: shadowed declaration is here
> >  2154 |         const char *prev_comm =3D evsel__strval(evsel, sample,
> > "prev_comm");
> >       |                     ^~~~~~~~~
> > builtin-sched.c:2154:21: error: unused variable =E2=80=98prev_comm=E2=
=80=99
> > [-Werror=3Dunused-variable]
>
> Yep, you need to delete the old code.
>
> Thanks,
> Namhyung
>
> >
> > On Fri, Jul 11, 2025 at 4:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > Hello,
> > >
> > > On Wed, Jul 09, 2025 at 10:31:20AM -0400, Anubhav Shelat wrote:
> > > > Previously when running perf trace timehist --state, when recording
> > > > processes in the zombie state the process name would not be decoded
> > > > properly and appears with just the PID:
> > > >
> > > > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956   =
   0.019      0.041      S
> > > > 1140057.412222 [0012]  :1248612[1248612]                   0.000   =
   0.000      0.332      Z
> > > > 1140057.412275 [0004]  <idle>                              0.052   =
   0.052      0.953      I
> > > > 1140057.412284 [0008]  <idle>                              0.070   =
   0.070      0.932      I
> > > > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953   =
   0.112      0.058      S
> > > >
> > > > Now some extra processing has been added to decode the process name=
:
> > > >
> > > > 1140057.412177 [0006]  Mutter Input Th[3139/3104]          0.956   =
   0.019      0.041      S
> > > > 1140057.412222 [0012]  sleep[1248612]                      0.000   =
   0.000      0.332      Z
> > > > 1140057.412275 [0004]  <idle>                              0.052   =
   0.052      0.953      I
> > > > 1140057.412284 [0008]  <idle>                              0.070   =
   0.070      0.932      I
> > > > 1140057.412333 [0004]  KMS thread[3126/3104]               0.953   =
   0.112      0.058      S
> > >
> > > Thanks for the fix.  A nitpick below.
> > >
> > > >
> > > > Signed-off-by: Anubhav Shelat <ashelat@redhat.com>
> > > > ---
> > > >  tools/perf/builtin-sched.c | 19 ++++++++++++++++---
> > > >  1 file changed, 16 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.=
c
> > > > index 26ece6e9bfd1..e1a931341bc8 100644
> > > > --- a/tools/perf/builtin-sched.c
> > > > +++ b/tools/perf/builtin-sched.c
> > > > @@ -2023,11 +2023,15 @@ static int comm_width =3D 30;
> > > >  static char *timehist_get_commstr(struct thread *thread)
> > > >  {
> > > >       static char str[32];
> > > > -     const char *comm =3D thread__comm_str(thread);
> > > > +     char *comm =3D (char *) thread__comm_str(thread);
> > > > +     char *empty =3D (char *) "";
> > > >       pid_t tid =3D thread__tid(thread);
> > > >       pid_t pid =3D thread__pid(thread);
> > > >       int n;
> > > >
> > > > +     if (*comm =3D=3D ':')
> > > > +             comm =3D empty;
> > > > +
> > > >       if (pid =3D=3D 0)
> > > >               n =3D scnprintf(str, sizeof(str), "%s", comm);
> > > >
> > > > @@ -2147,6 +2151,8 @@ static void timehist_print_sample(struct perf=
_sched *sched,
> > > >       struct thread_runtime *tr =3D thread__priv(thread);
> > > >       const char *next_comm =3D evsel__strval(evsel, sample, "next_=
comm");
> > > >       const u32 next_pid =3D evsel__intval(evsel, sample, "next_pid=
");
> > > > +     const char *prev_comm =3D evsel__strval(evsel, sample, "prev_=
comm");
> > > > +     char *comm_str =3D timehist_get_commstr(thread);
> > > >       u32 max_cpus =3D sched->max_cpu.cpu + 1;
> > > >       char tstr[64];
> > > >       char nstr[30];
> > > > @@ -2173,8 +2179,15 @@ static void timehist_print_sample(struct per=
f_sched *sched,
> > > >               }
> > > >               printf(" ");
> > > >       }
> > > > -
> > > > -     printf(" %-*s ", comm_width, timehist_get_commstr(thread));
> > > > +
> > > > +     /* if a process is in zombie state commstr will start with a =
'[' and
> > > > +      * we need to do extra processing to decode the process name =
*/
> > > > +     if (*comm_str =3D=3D '[') {
> > > > +             printf(" %s", evsel__strval(evsel, sample, "prev_comm=
"));
> > > > +             printf("%-*s ", comm_width - (int) strlen(prev_comm),=
 comm_str);
> > > > +     }
> > > > +     else
> > > > +             printf(" %-*s ", comm_width, comm_str);
> > >
> > > What about just updating thread comm if it's missing?
> > >
> > >         if (!thread__comm_set(thread)) {
> > >                 const char *prev_comm =3D evsel__strval(evsel, sample=
, "prev_comm");
> > >                 thread__set_comm(thread, prev_comm, sample->time);
> > >         }
> > >
> > >         printf(" %-%s ", comm_width, timehist_get_commstr(thread));
> > >
> > > Thanks,
> > > Namhyung
> > >
> > > >
> > > >       if (sched->show_prio)
> > > >               printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_prios=
tr(evsel, thread, sample));
> > > > --
> > > > 2.50.0
> > > >
> > >
> >
>

