Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85721791F
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Oct 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728430730; cv=none; b=tLlprDgnDr0THi26Z8xLAiG7kO5fuBf2jE0kcpn8uKRi10wyHpRzHhPQTsj6et0LCxPXR0C5w0VnIfOVsUTQffRcoCKgxTvC3yfbhoKpXc12nzDUpx4zndxeq+uV9gu60Q2qnPCBXtEFHnKgAsbiTc+d7tEI7DSSRCHXXMyo8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728430730; c=relaxed/simple;
	bh=oUjhuh0m3i8RgOTrYtsfvXtmndX3wABUgKfm7URsTdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UpuScs/OR3dzjxCJQ9kpSkdkwjY0tolFSTvgmo4g+VHEG0UxeXGX6eXOjt9jb139VVMcYUr+D0ZXNN2tnJfXCMx/DELVw6+HTraUnu3KOAEscD+X5vLlc6lBqW0jou8su3cmKFCYy2QVOKEd5JozmOrkBp+iwNUICJsZx/oofNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EkQMY+ar; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EkQMY+ar"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a391fdd53fso52075ab.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Oct 2024 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728430727; x=1729035527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SHj9uIC0swgJ4C4niINoMHMUrPFl+whV9rsACB8aKtY=;
        b=EkQMY+arcoSlMXOnE6IHy9PklfS7nAtmJwzFjiXNiKLDjeWJCewq3a/wNW0O5BRdwF
         tLPxYpDeuvGG8C8kyKQDdlYdSov+RnIs5sQ+Zr46oQvtHGRTqIKb58FzoSSOZpmYjZmr
         ZkwNnfrdr0MvfyLpAgbyNkbbgklXPKSUgfsHJEoZ2EKz26X1qs3KqSj/PulIHh6YZO2d
         oMGgWxMvWTal15WMEhXteEGAw6DkCTrHCR3VmF1+CSokSkhM4zGQxlSti8zFzWH/iz6Q
         qtYGksbtkhzJakxjtffiTPnV5ZVUInWFyxvLSbcbW7L4lN5AJO+k0AKVcN79IcT0vWvx
         6fbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728430727; x=1729035527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHj9uIC0swgJ4C4niINoMHMUrPFl+whV9rsACB8aKtY=;
        b=MiYfRQtoYZGBzKzUIAgTO0hx9pqnwh5isoJi1WxsdRxwUDc8Homx1IlPalWXKEipQB
         DNRbETaRlElBx+ogpEr34Eceg/ruoYWVkg2l5e56n0P133/3uv5Aq9Hrod4bWxRAYoV9
         ebX20MR8ICVq94L/pGK2H2WU1DwOUqsQQWVAieDsM1qCNpmBtcm3n9uEwTb1lgY309/P
         HLYp8nJAmJCxgqBPzwN8hZ3Nb4ZaCjzXF7+C4ypd0PSlSdV2fBUUZYE+jP3RykwEY4jn
         5P2B0aMPASGGOxuW7QWQDD9pgqAbI/Rg//QzFontOp53lpsh3eiHUukacKo0fNejirfg
         sM5g==
X-Forwarded-Encrypted: i=1; AJvYcCXyvpJNO7iah1LR9eSUBAYHIiF9TwFsmAXqqEYFKqlwZVsryrB1X6X1/oia3tYZMwHnm0lKwNquEfCkboAoQWTo@vger.kernel.org
X-Gm-Message-State: AOJu0YzQfszgs+tzEXUCZSPKj6+CQp7O9BktymRkqV7UjnonQan27SbY
	it2AA2Hrv+2aUgXR88c5mFl+viMJf43ZWA3DRWZDA4hhbOugrNLxcTilqtsf1ZEU9HiEC1kIHaP
	IWQ3Yh1F5/BoHxjAQE8cMoXHBNrly1PD4YRhv
X-Google-Smtp-Source: AGHT+IGvm5mnDB6DWZj6bA268J+u+U3ZlPi+fXdRCd2hqT9nIdqdxX+YeP1jgiw4HyN8d8ya2CF5ZGmt+dUAB2g3Gxk=
X-Received: by 2002:a05:6e02:170d:b0:3a0:aa15:3491 with SMTP id
 e9e14a558f8ab-3a398090d54mr917195ab.23.1728430726922; Tue, 08 Oct 2024
 16:38:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004234120.1495209-1-irogers@google.com> <20241004234120.1495209-4-irogers@google.com>
 <ZwW0b8km5DnaOETr@google.com>
In-Reply-To: <ZwW0b8km5DnaOETr@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 8 Oct 2024 16:38:35 -0700
Message-ID: <CAP-5=fW0QQSwEAxK11bt8a8uPA+M=PyOUb=Y2+se+15peDqwPQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/8] perf stat: Display "none" for NaN with metric only json
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Yicong Yang <yangyicong@hisilicon.com>, 
	Weilin Wang <weilin.wang@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 3:38=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> On Fri, Oct 04, 2024 at 04:41:15PM -0700, Ian Rogers wrote:
> > Return earlier for an empty unit case. If snprintf of the fmt doesn't
> > produce digits between vals and ends, as happens with NaN, make the
> > value "none" as happens in print_metric_end.
>
> Then it could be "NaN" or is there any other case?  But probably "none"
> would be more generic.

We use "none" here in print_metric_end as mentioned in the commit message:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/stat-display.c?h=3Dperf-tools-next#n1090
If we used NaN then it'd be another case for users to parse, hence
trying to be consistent and using "none".

Thanks,
Ian

> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/stat-display.c | 11 +++++++----
> >  1 file changed, 7 insertions(+), 4 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-disp=
lay.c
> > index 5402998881c4..e392ee5efb45 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -609,19 +609,22 @@ static void print_metric_only_json(struct perf_st=
at_config *config __maybe_unuse
> >  {
> >       struct outstate *os =3D ctx;
> >       FILE *out =3D os->fh;
> > -     char buf[64], *vals, *ends;
> > +     char buf[64], *ends;
> >       char tbuf[1024];
> > +     const char *vals;
> >
> >       if (!valid_only_metric(unit))
> >               return;
> >       unit =3D fixunit(tbuf, os->evsel, unit);
> > +     if (!unit[0])
> > +             return;
> >       snprintf(buf, sizeof(buf), fmt ?: "", val);
> > -     ends =3D vals =3D skip_spaces(buf);
> > +     vals =3D ends =3D skip_spaces(buf);
> >       while (isdigit(*ends) || *ends =3D=3D '.')
> >               ends++;
> >       *ends =3D 0;
> > -     if (!unit[0] || !vals[0])
> > -             return;
> > +     if (!vals[0])
> > +             vals =3D "none";
> >       fprintf(out, "%s\"%s\" : \"%s\"", os->first ? "" : ", ", unit, va=
ls);
> >       os->first =3D false;
> >  }
> > --
> > 2.47.0.rc0.187.ge670bccf7e-goog
> >
