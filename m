Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2863CB;
	Wed, 26 Mar 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018738; cv=none; b=VnO6ggO+c4Kgi0b+ab3fPR/rLR2GMPfaF7mIMXIjFEuoPdi97QZKOWUzmwaYSTEBrEIEvwbxmGuDn0dGthoOxoZXv1I2ICWzB/hUujXjI3vriRilmLbjaUDchql/V16mWP/wiM6VnxKL8Q6XFpA2epiFgU5fyWztNmRP4L7Jv/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018738; c=relaxed/simple;
	bh=CPuFfzVeIhlkyMWiI/9xY4iRTrwxRccvN+haIaYX/nw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6lc4ytVbMdiTZCAEUR/1z6R60qQOvzTTnbAW5PzvHj3QjHJKqPkBnC3esTxpUYTovVi8rMZGS7SZI32FKfCAzyginTpsRc2ToorOOZ9KJl+aay1QHEVwO84pldoOaG25FomaKpOvnLPx5+2Czt7K/E0fFpahvdvvzd9LQSfLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5fAo7U5; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5fAo7U5"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e63c966fe37so232865276.0;
        Wed, 26 Mar 2025 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743018736; x=1743623536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TOTsap/6W6leMw5tfK0HHvDtFAAN+8slmLSduLz/a7I=;
        b=m5fAo7U5bpdda1Pi2wuWEf7eEv4xGuS/0mxA/WOvT16ESohKYfsRRyjp2wvRX/w+aZ
         ok2RiKU17zlixdcvve6s8DkPPAWFllDdqB++aoUwINg6IoFvR6zSVrjN61zowNSPt0fq
         Dr1LkoJDBGeDWvuZxeKSjO+BgPWbxAZ5l0mjKu5jeVeI28tOVQxH+X+tK3keNu8x08tM
         iMruofhwsIDAkQJXHzsBVji2Kb/5eMMMKVwmh32zGZUU+tB1jaRv4L0jMztkrWi1PonL
         FDZuRNAhZQGZZG4tx4Z2b9mPG9mX6oxR8nif8udwCwamJxJD8Vjh+PpiHNe6m8AdqR3D
         84vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018736; x=1743623536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TOTsap/6W6leMw5tfK0HHvDtFAAN+8slmLSduLz/a7I=;
        b=g6uPjBVLZCUdbCrdOX1n1cnEbgu3SHINJHTTPv2mhKF32+o2ed2liTTkz7Y1tmXSW5
         vv0br3s4gu3D2UuMv3QEAqQpWCGEjr4r4mRGDorE3It2Xkc8oI/wgSzfc8t+ZXe3I3sr
         iAq9E8Egm9l1s5mSl3eibgOw0mmfUPi9FcdIH5qXLCPKXFmoN9uKm6im4tgVz20m2XPH
         ikGUa2Vn0KdiUwRZPUCztltRDwQpwLmwlEy06KCz5TOcmbnVauDpqrkjHX1wBWpeD+Zl
         06nTWUuDrK7UvkmZ+gMY6jH4iatWqBYOi7MhnsvcBeywOmqTM+0aPK4OlV/S3wtZVFs6
         Bywg==
X-Forwarded-Encrypted: i=1; AJvYcCV5WY5+ixTtLiAh56ENcbkpihvj3qlLllbxEDWWzGTcKlZy+qXM2/fNM7647NwK+WSBvbdoEJAbBQFzt3w=@vger.kernel.org, AJvYcCWtrOb3CS2WL2i21tL4sbcm9Ndsg+Ar3ARnT0n4Yenw0eQ0PrT3jTihph+8wwsoll9dsXJmlTjX4yF4PU3clyMokA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxNYtJ/xO5igesV7ncbjn4Xlqa+MO8QY4yv5Wo5SFrO2UGuPN
	wVmkrr6s8f3+HNp9JKlEgSfEOl8tXNnrm3t9hm8p4r++yrYnUaJDi8Yvi0nw2BgRq270ExxnY35
	PvovrL3I9DzFahF/3wyoQlyLUrLQ=
X-Gm-Gg: ASbGnctq7FN3ezcKRXAhpPK/b8gUJIXkT8VdUt7VmR/o/UGzkDMC07m5zhRgbS48n+Q
	TOHbCp4gHyjPbs8VVv+pt3SIWKmlVl1Wy/f/qP3srP2fe9fxRYiG1s+gO97Z2+K8541+9qyU1fI
	ToSGHFRo5hparaJzPjaOE0aDoZ
X-Google-Smtp-Source: AGHT+IFsRkpNyRdE1OYNC3KWakM70vLpWNGTGN8ecp+nDlUO5DnWanJpEWTRVzJdbBYiBIEsIff3uFV/vntxIu7yb58=
X-Received: by 2002:a05:6902:2412:b0:e69:371d:6849 with SMTP id
 3f1490d57ef6-e69430b0aadmr1243866276.0.1743018735841; Wed, 26 Mar 2025
 12:52:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324235245.613063-1-howardchu95@gmail.com>
 <Z-RFu_PLmKMq8YFU@google.com> <CAH0uvoi-uxLNOoZ8P1g--jBZUnax_1vCu42SjFCNS7mdAH6Ozg@mail.gmail.com>
 <Z-RZM7X_XCSCxpJV@google.com>
In-Reply-To: <Z-RZM7X_XCSCxpJV@google.com>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 26 Mar 2025 12:52:03 -0700
X-Gm-Features: AQ5f1Jqp6EnPWFLkqNiucvMODf4-xc-3UC-nld-hmyCxxeMPEGiwEcSmoUzlItM
Message-ID: <CAH0uvogMRnMVO=7169kSWJzFuTTTJ_r2uUTH6vaFuJDgvN8Q6g@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix possible insufficient allocation of
 argument formats
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Wed, Mar 26, 2025 at 12:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Wed, Mar 26, 2025 at 11:30:11AM -0700, Howard Chu wrote:
> > Hello Namhyung,
> >
> > LGTM. This is better. :)
>
> Great, can you please resend it with my Suggested-by?

Sure.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> >
> > On Wed, Mar 26, 2025 at 11:21=E2=80=AFAM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Mon, Mar 24, 2025 at 04:52:45PM -0700, Howard Chu wrote:
> > > > In my previous fix of runtime error(Link:
> > > > https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-ho=
wardchu95@gmail.com/),
> > > > I made a mistake of decrementing one unconditionally, regardless of
> > > > whether an extra 'syscall_nr' or 'nr' field was present in
> > > > libtraceevent's tp_format. This may cause perf trace to allocate on=
e
> > > > fewer arg_fmt entry than needed for the accurate representation of =
syscall
> > > > arguments.
> > > >
> > > > This patch corrects the mistake by checking the presence of'syscall=
_nr' or
> > > > 'nr', and adjusting the length of arg_fmt[] accordingly.
> > >
> > > Thanks for the fix.  I've noticed this too but I feel like we can mak=
e
> > > syscall__alloc_arg_fmts() a bit simpler.
> > >
> > > How about this?
> > >
> > > Thanks,
> > > Namhyung
> > >
> > >
> > > ---8<---
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 6ac51925ea4249c2..b9bdab52f5801c3a 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct sysca=
ll *sc, int nr_args)
> > >  {
> > >         int idx;
> > >
> > > -       if (nr_args =3D=3D RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt=
->nr_args !=3D 0)
> > > -               nr_args =3D sc->fmt->nr_args;
> > > -
> > >         sc->arg_fmt =3D calloc(nr_args, sizeof(*sc->arg_fmt));
> > >         if (sc->arg_fmt =3D=3D NULL)
> > >                 return -1;
> > > @@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct sysca=
ll *sc, int nr_args)
> > >                         sc->arg_fmt[idx] =3D sc->fmt->arg[idx];
> > >         }
> > >
> > > -       sc->nr_args =3D nr_args;
> > >         return 0;
> > >  }
> > >
> > > @@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *=
sc, struct trace *trace)
> > >                 return err;
> > >         }
> > >
> > > -       /*
> > > -        * The tracepoint format contains __syscall_nr field, so it's=
 one more
> > > -        * than the actual number of syscall arguments.
> > > -        */
> > > -       if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fiel=
ds - 1))
> > > -               return -ENOMEM;
> > > -
> > >         sc->args =3D sc->tp_format->format.fields;
> > > +       sc->nr_args =3D sc->tp_format->format.nr_fields;
> > > +
> > >         /*
> > >          * We need to check and discard the first variable '__syscall=
_nr'
> > >          * or 'nr' that mean the syscall number. It is needless here.
> > > @@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *s=
c, struct trace *trace)
> > >                 --sc->nr_args;
> > >         }
> > >
> > > +       if (syscall__alloc_arg_fmts(sc, sc->nr_args))
> > > +               return -ENOMEM;
> > > +
> > >         sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, =
"exit");
> > >         sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "opena=
t");
> > >
> > > --
> > > 2.49.0.395.g12beb8f557-goog
> > >
