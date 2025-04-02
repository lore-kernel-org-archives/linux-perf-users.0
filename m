Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30DA1DFF0
	for <linux-perf-users@vger.kernel.org>; Wed,  2 Apr 2025 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608971; cv=none; b=XU2v47cxGbrrDU74P97an/ADi3Y0nSy0AuYUEjM5v8GNKD2BfuK6nNb3no331XGERSAuSSIjwrE9kzwn6wGs5wAlwz9d1JqrfoQ+yN1k+sUvgU5m0mBjh3WI66f5uLVTiAGMfWJt0PqC5gDfxdZc7udow1455fgR7MVZjv8fo5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608971; c=relaxed/simple;
	bh=6Ut/cxV+1k+mMg16QR1xNb0eR0mJR8T1x3alISxrsuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qC6nBIA7JonfizdY47H2qPAZgP+ViEtmMfo31QSbN+dDFdMSNKBgGv95SbMe1sQ6X6mKB35FmLZ8SxSUZREqdX8e+cYv5UenZk/x5PzfWQs6xWc8PorWkt4tej8m4fP/ZtxZBSMHWaK/+6JKHKgwPlIpQcgmDTu/0BrYOM3yPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MpYc9hYC; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpYc9hYC"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2240aad70f2so279605ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Apr 2025 08:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743608969; x=1744213769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+IHTKGBDG1tL7KtJr5lbczP6OiCQttkkS8rRMUhy8do=;
        b=MpYc9hYCWv1rbSMrz+YC9x63GJf0EOLkY8/Vk73jaArkh+p1bj3Wfoxg7dDz+wblVc
         Mf7sPqxVYqbVNx0IJxcfT+hhEYwb/2fd2b6Jm6gppupdDiaUcODulHzVUwpEvvfqkuGb
         FlhTgjkTH91eIs/S+09SEBQTCbYDvUyZLOxs7mtMLip6ikW07QQCp9FD26KCbCvgSKRd
         RAnJ6uhZ8mAq0oxv6bxuCfgtoEZ1VVV0CEOlZC8yaZHnFs5onRaTLiOs7tGfR/nlXlad
         0uzI/lgeDlUUs/0QdiH1TmOsx7gbWJoauMgWoPnTfukDTrkGQq5YBYWiObSV+NvwQzMG
         geBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608969; x=1744213769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+IHTKGBDG1tL7KtJr5lbczP6OiCQttkkS8rRMUhy8do=;
        b=TbUFetuYMcs9KoORJo1L/jumAjVabspgaTcUuVjDhyp/IBvqagjURjQmSVM06sjRMP
         4Q2JJQ9bjFgV2CMwTHg1vsNiE7QJE3tUaWmcGByQfJY1bqwqjJSIW9ZF99dRvgYOX5Ry
         xecQ7A8+CrhnsWupHDGiuBovcKJLa78moyP4+GYxRfXm/GhJgps9LvL/Yp2lYfPRjR3A
         OyLngBbrls2c9dK/TplGnnGmg5uBCBNy61TiXZzJiqLXBfLM/tjfvnKaq3K1FJkRKDDq
         GNju3uLJ7Jd7L/rIL1K7Bcf08L6rsNlBbStGQIasFs8wjpD770r8xzdQ/qjthrLJgHwT
         5QvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlDtt3GnLLYh8p2hIjVLSZJFi6nQB3gYBj46H9cpdIETAhqrNkiS367W9XBHIqRyu8hwFORPsReNsf5vU3sQZR@vger.kernel.org
X-Gm-Message-State: AOJu0YxGT5+IgsYgwvt3sN/vDH7YqmTIb3mWm1DavAeR1eTv0+8lXX71
	2AvIt7FPNb7lPF0OUfCXwdtGV8keG8Kq3wgz1arcDuUAc6OIhAZncsokXpWyd31jPiF/CvcaP8A
	uoO7BnSmMIBWsI1hjOLm43o2XPgHEUmdmmqQz
X-Gm-Gg: ASbGncv3JPkUbvH/tltqLYr/7egx+bDGLGqQ9Rs6YJcEQ4nstcrwWJpFZG1tozqnlLt
	12fvccaDViDaAc/iTMdLJiccZpQX3qNhtRPDV8DOEsfg+HbWV+gVVU8nFMzupucCSoSIC/q5hVD
	J9pQyV6PBlTyGtns6wrvAWY8zXGJSzB8GAmyouNJg8AQcVRQukktfNyg==
X-Google-Smtp-Source: AGHT+IExsoUmdM23Q1D/YLx8O4wuDufR1G6fK8eyvYNjtBDUzTicQjnkOegdTzdtcaUf/k57Fsc+dCi/WVW1TekL2jo=
X-Received: by 2002:a17:902:d2c8:b0:216:21cb:2e14 with SMTP id
 d9443c01a7336-2296bdaea5dmr2668875ad.21.1743608968491; Wed, 02 Apr 2025
 08:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318041442.321230-1-irogers@google.com> <20250318041442.321230-2-irogers@google.com>
 <28016335-385c-48b9-8767-9b087a0ec4cc@linux.intel.com>
In-Reply-To: <28016335-385c-48b9-8767-9b087a0ec4cc@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 2 Apr 2025 08:49:17 -0700
X-Gm-Features: AQ5f1Jq796U52_aSe_Kn7pKTK2dssVS2u53PYYYmR2NIr6w3FH4-0stY0FgCoDY
Message-ID: <CAP-5=fXJ9pi+B_ppA93mE6gd8XYP4TDJThUreZeZxQtGwQ7Fug@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] perf stat: Better hybrid support for the NMI
 watchdog warning
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andi Kleen <ak@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 8:23=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
>
>
> On 2025-03-18 12:14 a.m., Ian Rogers wrote:
> > Prior to this patch evlist__has_hybrid would return false if the
> > processor wasn't hybrid or the evlist didn't contain any core
> > events. If the only PMU used by events was cpu_core then it would
> > true even though there are no cpu_atom events. For example:
> >
> > ```
> > $ perf stat --cputype=3Dcpu_core -e '{cycles,cycles,cycles,cycles,cycle=
s,cycles,cycles,cycles,cycles}' true
> >
> >  Performance counter stats for 'true':
> >
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >      <not counted>      cpu_core/cycles/                               =
                         (0.00%)
> >
> >        0.001981900 seconds time elapsed
> >
> >        0.002311000 seconds user
> >        0.000000000 seconds sys
> > ```
> >
> > This patch changes evlist__has_hybrid to return true only if the
> > evlist contains events from >1 core PMU. This means the NMI watchdog
> > warning is shown for the case above.
>
> Nit:
> The function name may still bring confusions.
> It may be better to change the function name as well, e.g.,
> evlist__has_hybrid_pmus()? It implies more than one PMU.

Thanks, I'll change in v2.

Ian

> Thanks,
> Kan>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index e852ac0d9847..f311f1960e29 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -825,13 +825,25 @@ static bool is_mixed_hw_group(struct evsel *count=
er)
> >  static bool evlist__has_hybrid(struct evlist *evlist)
> >  {
> >       struct evsel *evsel;
> > +     struct perf_pmu *last_core_pmu =3D NULL;
> >
> >       if (perf_pmus__num_core_pmus() =3D=3D 1)
> >               return false;
> >
> >       evlist__for_each_entry(evlist, evsel) {
> > -             if (evsel->core.is_pmu_core)
> > +             if (evsel->core.is_pmu_core) {
> > +                     struct perf_pmu *pmu =3D evsel__find_pmu(evsel);
> > +
> > +                     if (pmu =3D=3D last_core_pmu)
> > +                             continue;
> > +
> > +                     if (last_core_pmu =3D=3D NULL) {
> > +                             last_core_pmu =3D pmu;
> > +                             continue;
> > +                     }
> > +                     /* A distinct core PMU. */
> >                       return true;
> > +             }
> >       }
> >
> >       return false;
>
