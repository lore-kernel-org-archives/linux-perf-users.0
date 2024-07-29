Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C83C15A87C
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722268443; cv=none; b=Fe1ZFZcIjOpD5NH+cKg2dbfOWlYfRhu+MewMqLZ42rBA5N/9a6AXjofOu7Er0pAPlV3+m+EG6uUpK+YN8Z4CEJ13IBGyxJrjUxZsJLiNVQwDl5Q+VFadMvnmv/I/WdeZK0mo17niO6wI/73J/VmZbDCB/iQX79Wk19CRGzT8qt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722268443; c=relaxed/simple;
	bh=vit//5frB+Bxo4uCQ9TaphFpIjNsNOImUZUDRYyDM/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X2czSC44Gh3wckhUTElAcp5S01oVYVCaOGAocwnTANjDP4rM7yHSTSA9VufpLDcCmgHHS3fCOw9W4KI2ZQXIdw+1yMQSja9Dfd31unuNcF0L63m6JK39CwQQYJxRVuP2tqrKRKlq5/MEKTLdy/hgtjWM1RvB3sawR6fU+31mMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxv/F4LL; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxv/F4LL"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fe76fa0b8so402861cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 08:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722268440; x=1722873240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7NVQIGmQXJU9zMY7yOvP9B85E2qvUl+m8Pl4MaC7co=;
        b=oxv/F4LLxy+vbJLTZDaX/oqMNYAmd9nPH/gfq/uEWK4IW/BDclXna8qBS8gsmmkWAD
         9DXQH7/J8cS2NLjAAcg6NyyPPVd45ucO/z1f425miSfV7CLxCsA1h+zXvRLDBoV0TaG0
         tZ2JpbvrbFV57Z0xIV5lAOCV2BQKxhdbmMTSegslJ8XLMS52hgtMwChQkc7pd8GojCoD
         EZ6C1lgtWh2V7IHhpJ+oqpn3/Xtl015AmqHtAypmrgJ6yAg2Re3CnIVBkQ/ySvN+ts3b
         9/F9N9STfw1lP0k3HGfNITP7Nc4WKMubSuIBNPSG+/Wo5z/hOhTmeXQK9tuevDESEUK+
         kE3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722268440; x=1722873240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7NVQIGmQXJU9zMY7yOvP9B85E2qvUl+m8Pl4MaC7co=;
        b=ElA4FwXZQrdu1jgLFQJqVGiY+ZgECrBN8Ds+AW0+6/Ee0h50+NPBznGMKnUtFMXrDc
         aEpHhMAnoA7GZCQqWsM2pxwEyLFjial+IQ+qo1FyqDgD+S5mTpEwAKiQh3UQvPlgFSTW
         gX28O4xIlWileEBYzdI6UdNiL6xXN+M6mq83YNbVtmRg8wSbA/96O0C+aB9FdoeZgYJh
         syU8ixxrB51E9hxYNf16QIYJl+5pOXLREVoBB+yuMA6JMElrMT1Prs6HOFCXF4wVB5PD
         ZXcNflaQRkzAdWpwBn80rioquikJgcEo0RaJs1uIl6bTY+iyoELaNtOVKIAVEvXA77Cm
         utcA==
X-Forwarded-Encrypted: i=1; AJvYcCW5PTUZEvtBQo49Luz15k7qttWtgRzF3HyKaYKR6SrFmYReD3H1gBdHQK/kqEu8+zH8enLnm+eiKe/5QaPK/hbvaSKquC1Jt1SnloSx3CNRFQ==
X-Gm-Message-State: AOJu0YzGWbYtYznAqAbSgdJxARyW1Kuq2nU6btX2aYvGdjDkZGRChZZf
	qfrgARSld79LKEzmlSITMvFp18w92GgY35PWNVfvvMkjNFby+kniIeXrWgFwFscsIxSfU1om+u+
	MsprOVjZAc1cv1HkXsVLhGt+Y5hAOy+i7xa/0
X-Google-Smtp-Source: AGHT+IGtbd0iBqee7SwSoc94TJ7CIzVF+bo02bFcdiIhIU5AVsKcZ+YG/U7J2gyGGtrfLKplipYfybTILWWzXf+wdc0=
X-Received: by 2002:a05:622a:303:b0:44f:e12e:3015 with SMTP id
 d75a77b69052e-450329acd26mr220951cf.25.1722268439856; Mon, 29 Jul 2024
 08:53:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727175919.1041468-1-linux@treblig.org> <CAP-5=fW+VbDaFV+YQCMMKYzrraMLLuVqb=BChL0o=-D5Y=4N_w@mail.gmail.com>
 <ZqewJ6oIprdRY8C5@gallifrey>
In-Reply-To: <ZqewJ6oIprdRY8C5@gallifrey>
From: Ian Rogers <irogers@google.com>
Date: Mon, 29 Jul 2024 08:53:48 -0700
Message-ID: <CAP-5=fUHVZDS9y4Bm=OesD5qpHHv7qqo2ALU70EPdS5WiQs1-w@mail.gmail.com>
Subject: Re: [PATCH] perf test pmu: Remove unused test_pmus
To: "Dr. David Alan Gilbert" <linux@treblig.org>, Nick Desaulniers <ndesaulniers@google.com>, llvm@lists.linux.dev
Cc: kan.liang@linux.intel.com, acme@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 8:07=E2=80=AFAM Dr. David Alan Gilbert
<linux@treblig.org> wrote:
>
> * Ian Rogers (irogers@google.com) wrote:
> > On Sat, Jul 27, 2024 at 10:59=E2=80=AFAM <linux@treblig.org> wrote:
> > >
> > > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > >
> > > Commit aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > > test APIs") added the 'test_pmus' list, but didn't use it.
> > > (It seems to put them on the other_pmus list?)
> > >
> > > Remove it.
> > >
> > > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> >
> > Strange that the compiler doesn't warn about unused stuff like this,
> > we get unused variables within a function and unused static
> > functions...
>
> The problem is that LIST_HEAD initialises the list to point to itself;
> so it *is* used - but only in it's own initialiser.
> I did file:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D115027

Nice, the bug already has a fix - good work! Hopefully clang can follow sui=
t.

> > Reviewed-by: Ian Rogers <irogers@google.com>
>
> Thanks,
>
> > Possibly:
> > Fixes: aa1551f299ba ("perf test pmu: Refactor format test and exposed
> > test APIs")
>
> Given it's got no actual effect other than a few bytes
> saved, I'm not sure it's worth the Fixes.

Ack. I mention it so the maintainers can make a decision about fixing
in 6.11 (still in rc stage) or whether to hold for 6.12. It seems
pretty safe either way, but for 6.11 probably better to have a fixes
tag. If the GCC warning becomes a thing there's a chance the code
won't build without the fix :-)

Thanks,
Ian

> Dave
>
> > Thanks,
> > Ian
> >
> > > ---
> > >  tools/perf/tests/pmu.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > >
> > > diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> > > index 40132655ccd1..0b2f04a55d7b 100644
> > > --- a/tools/perf/tests/pmu.c
> > > +++ b/tools/perf/tests/pmu.c
> > > @@ -18,9 +18,6 @@
> > >  #include <sys/stat.h>
> > >  #include <sys/types.h>
> > >
> > > -/* Fake PMUs created in temp directory. */
> > > -static LIST_HEAD(test_pmus);
> > > -
> > >  /* Cleanup test PMU directory. */
> > >  static int test_pmu_put(const char *dir, struct perf_pmu *pmu)
> > >  {
> > > --
> > > 2.45.2
> > >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
