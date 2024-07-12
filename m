Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572DD4965D
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720821259; cv=none; b=YRuLlsfWm5vnDFYRZ6HE7Ddu1Vuh319kaEADzUpmGoPIxuN9M9jlUW5ya3KD+S0rA09G8SR4g2rU6n1x9oRf2RYCBAIkclOJAQMMmMnoYADDVxXBB/vzOMvKO3NlHXEAU9CACqOKtABGSO1coYDk2SoR7lAgwQ1D0rC9XQQhaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720821259; c=relaxed/simple;
	bh=tsQDgZkmsplkNgwMoqa2heFr1bgikIskwvqiDYTOghA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sydEErRhokTIvAOF+M5YzVBMzTdfgiR6cRxRv8bpwW/b43Awi1CXw5wM8wQzBUO7Ypz/4KFFnF0CV81aoklFSN4V7xw69j0ALcX4FbtbUdqfSP5rpPLu+KIxdaSr5GuDkkQT6ipCm56wd4BB2ausR2KtNHEdx/fBt9phSfjGl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYjiurWy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYjiurWy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fb67f59805so21675ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720821258; x=1721426058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YlmUbz8j1/lbJax8GeWhLbj2yGs75ISpC4OOkpQ7cY=;
        b=RYjiurWyxrN/3kZ47P8D+3fsnwc5oRUz19ZxqHN/45jxA5nc4V+6zZxpyRhoIyFI3R
         68JkH39sddd9irM1qCcGlz1taKxvOt/w6fOzlRCSL+14BsgBSerhOu64IQonc43Z7OMm
         qrI/h08iWN9OIcY/LFa3jT71T2c+Zf1U0LEN02Exf072j8jqx7MvWF4WwzmAb8VTiuug
         QMM25X5Kw887L04Dv2xdyi7aqWaavaNDgGm5VVcVA0oFrDwPA77dzoiKS6Q1dmhjZvIA
         ZBM9uRONAWOjSw8z4BOAVmVRayyd+PbKd1UiIR85whpTZsTpHbz/eOUQEILhWkl0RpoD
         PVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720821258; x=1721426058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YlmUbz8j1/lbJax8GeWhLbj2yGs75ISpC4OOkpQ7cY=;
        b=wgdbFfmRUtvrh0oX1FhwJj0dK8PTVQ//Rjydbcao1NlTCXRnrSowzsDxGsevUuN9XD
         qQUU+UrHe5x5H9vZCIsketk0KbMF3EvV0yxziMCwIeyOnJpT5n7ga2cRXvryf/ZzBfV0
         8Yzl7NOySFMhGUlGIaBpb+pxuBkZG/uEvnI2kmG7RSo2G9AoYuy2mchFqcJhGhsIRwfm
         WbtsOGubXEKXJlUb8k9P/XFwnIXN1v9MmRAafqI8+0NH0UJGBionoyX8C18lGNCGMvaQ
         6cO3mr8MugLHdJsd5KlIoFj2obT6eKBej1uXzCXihE4UXotKiDUens4pxuctKnUseIdv
         esLA==
X-Forwarded-Encrypted: i=1; AJvYcCVgp9/+gvrAcg0HxN3fepJlHTOPPt0YHspOLQJVJKOudkPVNoDmpdCLyhjbKVvcLEnNkwIpOJekXPZALBy5m43Hw3JFSE5mhuSLYh67Ab6Q/g==
X-Gm-Message-State: AOJu0Yw5V8Vw86hgFhy3J1b1PYqGC6dA8bPf9Q0h2TJ4a1zSV2/0mRji
	L50MDo2PlwhFOKs9GYHLa5pkL3y24M1JxCVJG1kA7Hg/dtdZH9m6eLmwecNFBQjSvGKnzw3dNaw
	UZszQA5560e6lNC0la7t8zTdM69vv7Cjp9ami
X-Google-Smtp-Source: AGHT+IHRPpWrjj2VHcLDX0ZFmAdcPcTmoCmhUHbzOxMGi3ywkPYFJ/M6ecUH4CBQQrp0wjaZ14KFG8zFIF/AO9vFRsY=
X-Received: by 2002:a17:902:e749:b0:1fb:d79:fe1f with SMTP id
 d9443c01a7336-1fc05a6f6b9mr830715ad.24.1720821257244; Fri, 12 Jul 2024
 14:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531194414.1849270-1-l.stach@pengutronix.de>
 <8b31bc0823df42e1ef4c22eac159fa58694887c7.camel@pengutronix.de> <ZoXRr9wcE98ijyFA@google.com>
In-Reply-To: <ZoXRr9wcE98ijyFA@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 12 Jul 2024 14:54:05 -0700
Message-ID: <CAP-5=fWxuPW1WGSOV-wqYXJ-4kiwefujprnGn3YfVzO+62-i-Q@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: return potentially empty metrics table
To: Namhyung Kim <namhyung@kernel.org>, Lucas Stach <l.stach@pengutronix.de>, 
	Leo Yan <leo.yan@linux.dev>, James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, patchwork-lst@pengutronix.de, 
	linux-perf-users@vger.kernel.org, kernel@pengutronix.de, 
	Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 3:33=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> Hello,
>
> On Mon, Jul 01, 2024 at 07:19:55PM +0200, Lucas Stach wrote:
> > Hi,
> >
> > has this patch fallen through the cracks? It fixes a functional
> > regression where the DDR controller metrics are completely unavailable
> > on all i.MX8M* systems and thus would be nice if someone could have a
> > look.
> >
> > Regards,
> > Lucas
> >
> > Am Freitag, dem 31.05.2024 um 21:44 +0200 schrieb Lucas Stach:
> > > Don't return NULL when a empty (num_pmus =3D 0) metrics table is enco=
untered,
> > > as this causes many of the users to bail out, which will skip matchin=
g any
> > > potentially existing sys metrics later on. Instead return the empty t=
able
> > > which will be handled properly by the iterators and allows matching t=
o
> > > continue.
> > >
> > > This fixes metrics reporting on systems where only the sys, but not t=
he
> > > core PMUs have metrics defined.
> > >
> > > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map f=
or a PMU")
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>
> Looks ok to me.  Ian?

Sorry I missed this, I expect to see patches on LKML and so my email
filters placed this elsewhere.

The change doesn't make sense. A search is requested with a PMU and
you return success (the table) when there is no PMU match. If this
behavior were expected then NULL should be passed as a PMU - this is
the behavior in util/pmu.c and ARM is the only architecture to pass a
PMU. The ARM pmu_metrics_table__find also specifically breaks
heterogeneous (BIG.little) systems and this change won't impact/fix
that. Perhaps there is some context I lack.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > ---
> > >  tools/perf/pmu-events/jevents.py | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events=
/jevents.py
> > > index e42efc16723e..0a1ed9ee1429 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -1081,7 +1081,7 @@ const struct pmu_metrics_table *perf_pmu__find_=
metrics_table(struct perf_pmu *pm
> > >          if (!map)
> > >                  return NULL;
> > >
> > > -        if (!pmu)
> > > +        if (!pmu || !map->metric_table.num_pmus)
> > >                  return &map->metric_table;
> > >
> > >          for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> >
