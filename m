Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4913F3C5856
	for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237802; cv=pass; b=UFE+9Nk+ckCzj6bjTV1MS+w8iDeBVJb8MjaG00YBA8j92tSSXwhjEz02Y8YO+OY0YAFbIA4TF71+8yPF0oUIgK0mDtKxy+5VOxv1Ty+WalZwF3Ob+19XljJgEBVZ4nEU3gCf6aSHwTdSuD/WTMOuG5Dh6A06f8eBhHm642RszKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237802; c=relaxed/simple;
	bh=mhdhQThmDfBjD49P6QasrZ1dTB4gQYqhgCa3K4+ln2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TEtj5V2AYO5lCYgejZH/sc8TR64uS4UStpbnunJIPatwvjO8VyflGjfrrfXF8o5GMvQdx3kMRhlf19xxHBlO1T8msiurvp4bvfCOCjGIEY3Dyqbmm4QlwcpILwWsYCrPbabIlp58RobODQ36M0THWcCJ7zvcYkPfxiDbjdFMvw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FlViTAA/; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FlViTAA/"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cab97c86bdso81145ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 16 Jul 2026 14:36:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784237801; cv=none;
        d=google.com; s=arc-20260327;
        b=ie7E30dahwq35C4YEl7nkLcyICpO/pIpVcJ5rwNGpWVBZgUXazm+j9iKHTUmReR5pr
         rfJjiENZNCGadZETsDUx88Si7eVq6yKChji8moARSPYLF1lLexII9QFiJQ05Xf7ana83
         Z+eN//w4nHP0DIjemRuF7pRkAAqeo1XyTDAbpGNU2Co5ld2PSFIYvVKb7cKX/5bm6tFa
         mlmAHWd4aXLmr0Mujkohr2zhLsBaGKGj7vgaM2weDNzh095ziOyVFlcmvU65zzCDkPXp
         EYB5X0Pg0kf8l9fxpsjZhBK8Ae3WSsXRhlSTRST17SYjKH8VTM3SY5jPm6pK/MaQkHyB
         jrMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J+wjGJmD5Hu/7rsRe91yogqLas4U7NrEtiWw+gZ4RIk=;
        fh=wWRrWYX67x5X1HNewaIxEYf8ZahiC02aMA8clqUotUI=;
        b=AhPBJzXFrTMhLqFvft8yG+wJgUxpzIo7Xq92hddRvLOPesIx50P8oVQPlOdSvHUHwx
         cHW6nmZJleiarXqBCwRgk5M+yZjoAyjdaBNgudewfXB1yynGky8T9yyfzq/RLajRy3Xw
         /It2UzQkH297tmSvzrL3qWU5iiPmqwzASgFMZcOl3h0Cma5NZ3FEKTu/tQSpxd86GRtf
         6/v9+MSvgkmY17b+ksAQYl3oSZ8bNb6i/i5so67CcBKIqGc0l5DbZMRJJqQ9OBtCx9Zm
         PRCfq/dgih42WO7LUNkQBISwQNViRH2t79rA2K8pZdecZxojpepvlHt05U4gA1HPog31
         Qavw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784237801; x=1784842601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J+wjGJmD5Hu/7rsRe91yogqLas4U7NrEtiWw+gZ4RIk=;
        b=FlViTAA/GNOaOOXdGphEGd9ftNgseQrr4qvbr8dCNG6EDvOByflwggPpzDyuhLyzSH
         MQsZPJqvAOMpfEeO0ZUAPWYJL8l8Tkrb4swSbusprgNDJZef+r84LCjPGLqYIE6ceSdw
         FhWq+jRskZ10SwiUUQ7DkRJpSNGY7R98lcuuXAocYrGVxLdMeZDIbyfydO4NzKZ0FnyP
         3tucCoVDS4A+VPZp677o+EOYaKBmkiODMngwXojWSNxTBqcw8BuA+XKg0AqcPgCWrwK/
         bBoX9NYeog5JzEIBM1AYoT2kJK/naEY331YglpWlJ3+o8JdPBYInHH1O7Zb2Pa730+4Q
         Kz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784237801; x=1784842601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J+wjGJmD5Hu/7rsRe91yogqLas4U7NrEtiWw+gZ4RIk=;
        b=G5Xum6RFgqFE/gARYJqk+my0VgUpd7pb1E6vum5N9ZvrLdi2bdhJoB6vzCipBydwvb
         Boi0B78lwdMPmbQZRx4V/DxDXf6JjLhAqugK2OmBjHq9m89VxI2Qlo5gtixk+EMAbXad
         w4wNPNKeKwoAfVySdVNiO9H0CEgkYsjq/NqXaEWfc3vUeoirGcPX9zXdsEq/shdkozRZ
         zCAxBnsWECskNWAqtiCvqFf/2KKxftjZbK6iAiX69rthNavLH+hFdknvsuzvrw6Fsw3Z
         y/UmjY2Yb579WnnlnsXHsFaIk92Ll1lSnIMrtQknTmZXgjuK8DJZAxxUigdDQLSqRkUN
         xkmQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr17KqzC41LNY/GXkr4uZORi9O9/gCHine/WncVex7fL7HJHVLA0Nb80oD7l/FzbH2t1D/cTbqaunm+5L4FWDqn@vger.kernel.org
X-Gm-Message-State: AOJu0YyuhxF/K1klQUHKkgKRsln5VbZ0uJYRzIYOm6FaPlzI/7+jp3Oi
	bVc3TfAZ8DnapwgOngd/TLDwEag41y3cXuudjz6BFPZ7/xqXbt3/1zh2xbBF25So+MoOyxidsgB
	wGnGOyjd6XnL25jO7RlNHvb4b8tEQu10eK0AbVW6A
X-Gm-Gg: AfdE7clZVQnsUcQzf1YXW2HegR12DISbL2eU+KS3IKxm50UFy7PMicPZtZgrtI0L/xo
	g5HRu8pCGXdIc9qtOOGNWdordD+87XLVZiqFqR9l5eIaJzqzHRAnIZ74azV743YI4Iyd3cwGuOB
	1kMuYMqzy+im5DqkU2EYnZs7WphhelNtjNwYnU0e0T6+Sut5YIuSGCfhP07R+C68hTcRtryLAZe
	UxRCakzbXgqT2MadHiKjFc0+AMVosMM0gYL2RaG/ThoSUYFL+2iWtVQGHhqPrQ=
X-Received: by 2002:a17:902:f1cd:b0:2cc:f9b7:8c7c with SMTP id
 d9443c01a7336-2cf324531a9mr320255ad.21.1784237800180; Thu, 16 Jul 2026
 14:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707034019.241762-1-irogers@google.com> <20260707034019.241762-3-irogers@google.com>
 <alkNOWGqi5aD8HlE@google.com> <CAP-5=fW4Lze=nPvD0ycd4uJtTL0H=HjeXidZDya-FOt6jpD71Q@mail.gmail.com>
 <alkhqxR2VXfGOY4m@google.com>
In-Reply-To: <alkhqxR2VXfGOY4m@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 16 Jul 2026 14:36:28 -0700
X-Gm-Features: AUfX_mwy_3M83FyJ8ddBBALI5o0opWzT5oGX5PG37ExYXsEK3KtNl7qnlAYCs8Y
Message-ID: <CAP-5=fV52rTf1LyogP9zxMOj1YRKq6bYMCX8r+we-N=N2jjCeg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] perf jevents: Add python type annotations
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Sandipan Das <sandipan.das@amd.com>, Chun-Tse Shao <ctshao@google.com>, 
	John Garry <john.g.garry@oracle.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:23=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Thu, Jul 16, 2026 at 10:25:01AM -0700, Ian Rogers wrote:
> > On Thu, Jul 16, 2026 at 9:56=E2=80=AFAM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Mon, Jul 06, 2026 at 08:40:18PM -0700, Ian Rogers wrote:
> > > > Make mypy clean.
> > > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/pmu-events/jevents.py | 77 +++++++++++++++++++---------=
----
> > > >  1 file changed, 45 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-even=
ts/jevents.py
> > > > index 3c6cfeefbd5d..83a239dd69f5 100755
> > > > --- a/tools/perf/pmu-events/jevents.py
> > > > +++ b/tools/perf/pmu-events/jevents.py
> > > > @@ -14,27 +14,27 @@ import collections
> > > >  # Global command line arguments.
> > > >  _args =3D None
> > > >  # List of regular event tables.
> > > > -_event_tables =3D []
> > > > +_event_tables: list[str] =3D []
> > >
> > > I got this from one of my test setup.
> > >
> > >     GEN     /build/pmu-events/test-empty-pmu-events.c
> > >   Traceback (most recent call last):
> > >     File "pmu-events/jevents.py", line 17, in <module>
> > >       _event_tables: list[str] =3D []
> > >   TypeError: 'type' object is not subscriptable
> > >   make[3]: *** [pmu-events/Build:176: /build/pmu-events/test-empty-pm=
u-events.c] Error 1
> > >   make[2]: *** [Makefile.perf:550: /build/pmu-events/pmu-events-in.o]=
 Error 2
> > >   make[2]: *** Waiting for unfinished jobs....
> > >   make[1]: *** [Makefile.perf:288: sub-make] Error 2
> > >   make: *** [Makefile:76: all] Error 2
> > >
> > > Python version was 3.6.15.
> >
> > I believe the minimum Python version should be 3.9.x:
> > https://docs.kernel.org/process/changes.html
> > That version will resolve this issue.
>
> Hmm.. ok.  I'll re-add them then.

Thanks! Fwiw, Sashiko should also keep us honest here by checking the
minimum tool version as we instruct it to read that from the
documentation:
https://github.com/masoncl/review-prompts/blob/main/kernel/subsystem/build.=
md

Thanks,
Ian

> Thanks,
> Namhyung
>
