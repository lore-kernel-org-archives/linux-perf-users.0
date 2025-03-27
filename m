Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB1945C14;
	Thu, 27 Mar 2025 07:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743060848; cv=none; b=a6SIT6F/1TEpbhdh13Rov4Utl2TH8W6AOibIxzZwQmYlZ48Y4Xe6/gfHlgnYaiU5sezDyZJDAt1CCaQaYqU2P+i0bvPpngO/sLl4LqTbIUh3B/xa8ftyASYCtT15vVJcixorNd4yXdh7cRPev839nIPvXvj1KqU+FhVYUR1eY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743060848; c=relaxed/simple;
	bh=aj6iZHMC8pA4NBrO0VwTJakVZIBwnLeZucTptt8Sk7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsdxkJ6319GtGIz7sRRZZhWe4YJ+dHHT6y9u3Ch8zR8V+ziWngWlZc1x+8kzylHGt6mKaopdbnjL9o/NqpMo20Fj0aCVF5EUOYewIA/bWg4goSD7pj19C4djRp5GseNibXK79eQr8RwLuKIt2Vty7FpVRZbdNmSAmg3KmAOEqck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nN3BcNWL; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nN3BcNWL"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e63a159525bso526131276.2;
        Thu, 27 Mar 2025 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743060846; x=1743665646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaHukZbpk2uBPZGm9oxHGMqN7B3c8n4VXxa90Vwwjm8=;
        b=nN3BcNWLIsEkMk6L/VHZpvSTm662HJ77duwoEov11QOtc3TwljZBq/Z3D+jQfa0ji/
         OAiOIbWR8RvMiFlOWqejDMP9B2vdI/xLRXRdmJuQgRD8aWj1xkKf90lKuW4lffnMKBuI
         gDF5lDjNw/mKYYSE0jTMI7u03SIwzFodE+AdvnCkgVl130WScJTwOUMzfVlxLCMCf4Id
         36Dqu2cTe0bfGnkzVPzsYQ4E+3tlwAyP5xaOr+leJx1wSC24Rab4BVIrptA0JNGNrujX
         hK0qjkcYxjStYqjdNoqO4oj4LrTABvuwfsbBYfw6yww1kElIuaWg9v3QZVMv7bBthP1t
         begQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743060846; x=1743665646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaHukZbpk2uBPZGm9oxHGMqN7B3c8n4VXxa90Vwwjm8=;
        b=AKd2zhp239Q1uIhyVUD/RvWhgQZE2VGYslGfWbzZuYG7xlYdckT+WXVCc0fjRSjanE
         7pwLGqyNBOaCuh3rFF4t9Q0MBsdIAKHGvtW/OKc0rmDbW4Ak6x5chzA8oP+ATRr7r4Yx
         1WNVj3YyAsoA93X1pgBRgAAZj9wCzyyrD6gQyCQvHHsQZ7ZlRDVF529WezGxssYDeS7I
         1q6+bweNuQZ5npahSQsXHfHlQfNUfhRnHLf7ED31a7y7npIk7dvkzX1AHvogGKjyJIkg
         aBFMvC++jvlLJwMf5zkPaOP2YUoduFt/vF7X25WAiDicrVTjZPPNYlB92I1FJKheEjDV
         UWWA==
X-Forwarded-Encrypted: i=1; AJvYcCVYXzGSYF3mpMgWrtqWVJMb0GEtiIzWKoV8RSQXobEjD0HEQgCWma5nGKiiLfbDXP/KLh92KD5WlLsYITw=@vger.kernel.org, AJvYcCWd7w6vrbbPrh0ZwgvpkfW/b65usV0SLSP+OekGZ5651wbNndI0Qd/mM20oF96vDwGAzOzqBlVQCBgkTDv7Nf9uaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhp2CizWVTrI4NI+D+tDGMh69gSCTh+tKyiFFkBOS0+B6z/yOa
	zRFfbmZbz3SiJcuijUMVKD+ZZ1bM+AXfiJp01BIebO3R9rWponDB2F/5gxQjrmBeZkT4FR8nG2F
	yuQVQNiGkTZoc+v2zK4pqoBHkSvc=
X-Gm-Gg: ASbGncuz8CHaAI/5a+k+1kocOSm3dDKlsZO7F2aRf4j0A10AF2+kNAqmWPW5V1vk9Tx
	3hz4nHbP6rhsXbh7tDMgCsaUXN1zzadturClwddacKqKW78E5sIsxmOUzcNoc+Fj7D8aM4OfbHo
	p5DRdraAxDYZaFASf3gssOetlx
X-Google-Smtp-Source: AGHT+IFYuNs7V8Ha1++n5F/xYUmZvB04ik3CC1XzUNqzM7hOrNX9wABOR/jxvQ8+PDzw3H9Ho0/984bNd5aU9s9vUwE=
X-Received: by 2002:a05:6902:168f:b0:e64:417c:dbe4 with SMTP id
 3f1490d57ef6-e69435833cemr3625043276.21.1743060845746; Thu, 27 Mar 2025
 00:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326200540.1843856-1-howardchu95@gmail.com> <Z-T7VohMjkNolhCi@z2>
In-Reply-To: <Z-T7VohMjkNolhCi@z2>
From: Howard Chu <howardchu95@gmail.com>
Date: Thu, 27 Mar 2025 00:33:53 -0700
X-Gm-Features: AQ5f1JqHtMXWo1lUWKr9VOXioVzlJ0SD5497yl1rAp1RvU4MvjF4vvYOj6oW3R8
Message-ID: <CAH0uvohKRhT3H1v4ipD=OSOz8qG9aJL6fc-ecaJ+Ax7nK_+y4A@mail.gmail.com>
Subject: Re: [PATCH v2] perf trace: Fix possible insufficient allocation of
 argument formats
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, mingo@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
	adrian.hunter@intel.com, peterz@infradead.org, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Namhyung,

On Thu, Mar 27, 2025 at 12:16=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Wed, Mar 26, 2025 at 01:05:40PM -0700, Howard Chu wrote:
> > Changes in v2:
> > * Simplify the code (written by Namhyung)
>
> Please move this below "---" after S-o-b tags so that it can be ignored
> when applying.

Sorry I missed this, you mean this one before the diff stat?

---
tools/perf/builtin-trace.c | 16 +++++-----------
1 file changed, 5 insertions(+), 11 deletions(-)


>
> >
> > In my previous fix of runtime error(Link:
> > https://lore.kernel.org/linux-perf-users/20250122025519.361873-1-howard=
chu95@gmail.com/),
> > I made a mistake of decrementing one unconditionally, regardless of
> > whether an extra 'syscall_nr' or 'nr' field was present in
> > libtraceevent's tp_format. This may cause perf trace to allocate one
> > fewer arg_fmt entry than needed for the accurate representation of sysc=
all
> > arguments.
> >
> > This patch corrects the mistake by checking the presence of'syscall_nr'=
 or
> > 'nr', and adjusting the length of arg_fmt[] accordingly.
> >
> > Signed-off-by: Howard Chu <howardchu95@gmail.com>
> > Suggested-by: Namhyung Kim <namhyung@kernel.org>
>
> Also please add the Fixes tag.

np.

Thanks,
Howard
>
> Thanks,
> Namhyung
>
> > ---
> >  tools/perf/builtin-trace.c | 16 +++++-----------
> >  1 file changed, 5 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index a102748bd0c9..439e152186da 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -2022,9 +2022,6 @@ static int syscall__alloc_arg_fmts(struct syscall=
 *sc, int nr_args)
> >  {
> >       int idx;
> >
> > -     if (nr_args =3D=3D RAW_SYSCALL_ARGS_NUM && sc->fmt && sc->fmt->nr=
_args !=3D 0)
> > -             nr_args =3D sc->fmt->nr_args;
> > -
> >       sc->arg_fmt =3D calloc(nr_args, sizeof(*sc->arg_fmt));
> >       if (sc->arg_fmt =3D=3D NULL)
> >               return -1;
> > @@ -2034,7 +2031,6 @@ static int syscall__alloc_arg_fmts(struct syscall=
 *sc, int nr_args)
> >                       sc->arg_fmt[idx] =3D sc->fmt->arg[idx];
> >       }
> >
> > -     sc->nr_args =3D nr_args;
> >       return 0;
> >  }
> >
> > @@ -2176,14 +2172,9 @@ static int syscall__read_info(struct syscall *sc=
, struct trace *trace)
> >               return err;
> >       }
> >
> > -     /*
> > -      * The tracepoint format contains __syscall_nr field, so it's one=
 more
> > -      * than the actual number of syscall arguments.
> > -      */
> > -     if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields -=
 1))
> > -             return -ENOMEM;
> > -
> >       sc->args =3D sc->tp_format->format.fields;
> > +     sc->nr_args =3D sc->tp_format->format.nr_fields;
> > +
> >       /*
> >        * We need to check and discard the first variable '__syscall_nr'
> >        * or 'nr' that mean the syscall number. It is needless here.
> > @@ -2194,6 +2185,9 @@ static int syscall__read_info(struct syscall *sc,=
 struct trace *trace)
> >               --sc->nr_args;
> >       }
> >
> > +     if (syscall__alloc_arg_fmts(sc, sc->nr_args))
> > +             return -ENOMEM;
> > +
> >       sc->is_exit =3D !strcmp(name, "exit_group") || !strcmp(name, "exi=
t");
> >       sc->is_open =3D !strcmp(name, "open") || !strcmp(name, "openat");
> >
> > --
> > 2.45.2
> >
