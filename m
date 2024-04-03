Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0C53A7
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Apr 2024 18:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169113; cv=none; b=sbc7dulaWjNRTXe46Ay8mOA00r7dVUqZtT1XGGt57kQith4HceQgp4Z32wLi63BwcWY1qaCMQuvFPgM/tUxrUdzgquL2NA4LIDQex+m+N6r1P682ltMsCS1dNn1PIj1JSLA9/44aCMfPV7AAP6Bj8SJilqCVzJJP7TpBDHruXdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169113; c=relaxed/simple;
	bh=VZ5Lpg28bRGxX9u8+FU6dh/DzQK2KQ4a90DWVcKqgV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Laxti18cqoXAJ6hTVCCVRwNOh9DBTajOpzUzWINs1JlZimc14UOEdpKsxgxxJFJBpRYT375B0cod9E2D7gZNWf1zpftXQYDU/w0whJ5Ztz7lAvLXgNTB4EYsCG8gT5hZf21V7jmaEIY4l0zp7GNpxGi7Lvl1I3FyXxf/cDNutGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wUg0FBYi; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wUg0FBYi"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-36899c4e544so19495ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Apr 2024 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712169111; x=1712773911; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DavZa0Vn131W4AwpDx3XJiiYAXVAyTt4Vn1WSk/2RBw=;
        b=wUg0FBYiIaCHTzI16fW1hrLsqj+qYUAp/KuopK7qaz04sdU/r7a833Bk7HkX9m90vm
         nyft8M/U1OrqYDtIZi+fJGIZoZ8IHiZpy63FRj61EZmlsFS/LMZ8ZZST2QVlU6AnsFrq
         uNft4DbcDqlm0ouOBZn9hhmGJzVYM8y8Is2tXQR8CVzuB2sOLlEfpaSnZrSa8yWoiZws
         UgiiEhk4CB3+w+kNIJgzwt7Wdr6uCXe3JVI4x7lWLskcAEr4eQD6ywziyiqrpGQFuntC
         LHfKnVWMkst1bB23wugI3i/OuIITrogC6rQR3ami6p1/PmBV+a59z6pt6NIZJNiJqBPQ
         hZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712169111; x=1712773911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DavZa0Vn131W4AwpDx3XJiiYAXVAyTt4Vn1WSk/2RBw=;
        b=idols4PYVYEZjaFEu+WE+GHlVStH7DeYh82EPFtk/Q6aZhDo80k85wCdfAnpp7xxgI
         SIT56L6At+FdxDvTKFveNPbQsUOFINYHhxTjLNMIndNNDA6XxLiaBOvvRe4kNtAAii2V
         sOQji8Z5YvRRDZzyof3TecdZhWdyC59fa+DkfTTZn1r9yLgXi/JNizaPc8qvQ7VuAnQ0
         SuSLmfi8CFkfOU7Xu1SOpsB9/o6bh37YR7Fby4I/xhn6v5rT9OunlPzcn8H6ef0AunD1
         Mu8+rfC2mNR5nh2k5/KN8TGeibTpdxEkM3d6gbHBn1gPlXiSixjINTLX0vVGRtxeHh1u
         SkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3dLxLk7uSr4v5JIXDHdSCkM2t5uI4uqPS2SXLd2huAGHxklXg4m8Ut8v9BmYgOQQMpfWoYWzminGwEvnbFILNe/7hxZNZ2Yfb6prTEwyTDg==
X-Gm-Message-State: AOJu0YxON884+DmcMqO1amN8ldl+sLMqLsNnYwdT82x6uH3sHxxeRjeh
	c8Ia4AP8X6TpoMzMr5Zfur36Lbis60t3NPZRWoNE2s63k3V4ZTKD7yduPo/iVaROJkbMdljiPPY
	rbcIpaXBuPF5vvh8TkfjEDp7Oq+3fKGNqHM4m
X-Google-Smtp-Source: AGHT+IFSczYbfUmSrLqLilwtVGK/wXjsQZ0QwQoQ1RfLw9H4GIEwV1Ih4fz/tCxv28G5UcAZGFQ4gsbnTfiSnyHKs4Y=
X-Received: by 2002:a92:c750:0:b0:369:a2ae:2634 with SMTP id
 y16-20020a92c750000000b00369a2ae2634mr271505ilp.12.1712169111299; Wed, 03 Apr
 2024 11:31:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403164636.3429091-1-irogers@google.com> <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
In-Reply-To: <dcb0121f-611d-4104-80b9-941d535c5fd2@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Apr 2024 11:31:37 -0700
Message-ID: <CAP-5=fUgiafmLEKEUJ5r5_tK+jqv30P0TGFCMvR8DkW7J4qYsQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf metrics: Remove the "No_group" metric group
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 10:59=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-04-03 12:46 p.m., Ian Rogers wrote:
> > Rather than place metrics without a metric group in "No_group" place
> > them in a a metric group that is their name. Still allow such metrics
> > to be selected if "No_group" is passed, this change just impacts perf
> > list.
>
> So it looks like the "No_group" is not completely removed.
> They are just not seen in the perf list, but users can still use it via
> perf stat -M No_group, right?
>
> If so, why we want to remove it from perf list? Where can the end user
> know which metrics are included in the No_group?
>
> If the No_group is useless, why not completely remove it?

Agreed. For command line argument deprecation we usually keep the
option but hide it from help with PARSE_OPT_HIDDEN, so I was trying to
follow that pattern albeit that a metric group isn't a command line
option it's an option to an option.

Thanks,
Ian

> Thanks,
> Kan
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/metricgroup.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 79ef6095ab28..6ec083af14a1 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -455,7 +455,7 @@ static int metricgroup__add_to_mep_groups(const str=
uct pmu_metric *pm,
> >       const char *g;
> >       char *omg, *mg;
> >
> > -     mg =3D strdup(pm->metric_group ?: "No_group");
> > +     mg =3D strdup(pm->metric_group ?: pm->metric_name);
> >       if (!mg)
> >               return -ENOMEM;
> >       omg =3D mg;
> > @@ -466,7 +466,7 @@ static int metricgroup__add_to_mep_groups(const str=
uct pmu_metric *pm,
> >               if (strlen(g))
> >                       me =3D mep_lookup(groups, g, pm->metric_name);
> >               else
> > -                     me =3D mep_lookup(groups, "No_group", pm->metric_=
name);
> > +                     me =3D mep_lookup(groups, pm->metric_name, pm->me=
tric_name);
> >
> >               if (me) {
> >                       me->metric_desc =3D pm->desc;
