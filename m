Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22521773C
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Feb 2025 06:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740637309; cv=none; b=pOlUHHgSqRgNp60gYYrbgow1vz0RJkvn4320u9HCcTz53eo5yvglA262HN0lf/Z0nHKp80lbIAslWDPZQx7fyRZC6EXE4wC4qZkIRi57NEVIBiCigCsGzzBW/pPSsR4IeNCmSf4IPWqKgRTs5LfN9byTMfxVP2miMZazk8d9sdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740637309; c=relaxed/simple;
	bh=9BQwvYLFuyKz8+vOPc/7vB9NDt1wrVlSjQz/uL+F0iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KZC7lTS+lhhUom4JIyyix9/+0DHgKmWI9g+dGPFwVPYqCLMI61MxZ5jMFAF63wZll1MkeNzyxzWk07Bwx1kDQOPHB1I36jNRPgT4FrGrb6p/XVfCqN/BYqmoQSilCtwEwbC6KffXApKqmd+LDa6acP+BjYXFNlQbkjmGtRLFEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C5E79zdB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C5E79zdB"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22117c396baso86795ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 26 Feb 2025 22:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740637307; x=1741242107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLGPv8wfagepaDcd3kRNoXQJFGOdNe+csTfwazr/hns=;
        b=C5E79zdBts/WekRaOqTBW4NUd7jNOx26K33t+64WyuwT5g0zYwEiNR4DqGHuqZ/ZLj
         1kY8Jxtf9jBOp2c/SNYSSXI4gbHj++an0Yey9cDM5kvtwMD4FTn5EDJcd3UwLbkUw6p2
         rk+RA/KjjppJ7slmUr6F9vj+FjBLCviuqdr7rrGwrZXKPJ6pRzq90fKCErrgV9oGZrta
         teNty+Mw2iXcuNeiIMoxuNwFrj9KW1Bs+HM+sCDQmD6FbYWLWpi2TkcMGz3fgrTyexa1
         5bphDqUWu16jV3EGpYRFluLfVbOuRDUdV464diDhiSfQIgcUpdZ4Yk7A42tOPPct9GUG
         A6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740637307; x=1741242107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLGPv8wfagepaDcd3kRNoXQJFGOdNe+csTfwazr/hns=;
        b=mz5gv/z6aN21yLujZ6yy3rSTI/GYGA8GOxHMT304GMeRoMkzDVzENRwDzzoPKE1MGr
         5+BXEdXPYTlCt17b5ROI9I0gQlm4qQC85Yo02E8dansPHOrm0IPxuJObxDcYACZK2wi6
         bbfqTWzp4OZ4uVP1HBJ5gehiipdXIxkH+M6wnfIWTT9JsLuwFnH2PG/3XTibn82RFeYH
         6/OtIgIcRhBPvfESynYOTNqGdmLoOIuPm5KGXZmmV+xMNeY9Was4SdsCzA95gckNKmtj
         rEx2kee9Tly92PtCkWhfYEd94CxOWRKBUPpAte8xPqe5ISg0qJ8cSoi+3y7LQ8Ew/9wZ
         VaKg==
X-Forwarded-Encrypted: i=1; AJvYcCUjcaXIuAsJ4sjg4GSYrkJUwB3CkRg8Z+1DAA0VUPB8Ay6nsC6T65+OtVIOYqy4Nzsqu5jMoa178wm1QYT+x81U@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgs4tNvmuyksYHhuYxuds43CgueXAGhn6et4YSuUauL779fiJi
	9B/thNCXSRUTuYS3AP/pkAFfYVUaT6Fisz/fu1ynkoVLeiK89qGL0r/9/ErY1uUzfW3SuuS3eIz
	u20RAo4ZMfE27WR9RXZbbZxaC5hFoAte4EsHs
X-Gm-Gg: ASbGnctdgylZoDIg3LZA8sknCMYe5DCYTh4A0NaDVar+idRVenMfILj6+TiiZpma4WF
	Yw1im7NZppoerqnC0IXH9dxLZWCAYYUi5fzJ4IS44uj5LRo+iZii7NvCOsGUmpPDZM1x4JtfrSf
	RqqvNMRgHq
X-Google-Smtp-Source: AGHT+IFEuuEK6gaJuEGoSW8v3ux9ytfx/BKpe7Ddlphni4oexNX3FSPoLq0aEXkLj+RhJyqZhVf2g6IeAdF1OYoSh3c=
X-Received: by 2002:a17:902:f802:b0:215:8232:5596 with SMTP id
 d9443c01a7336-2234d5c9a54mr1849385ad.16.1740637306890; Wed, 26 Feb 2025
 22:21:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109075108.7651-1-irogers@google.com> <20250109075108.7651-11-irogers@google.com>
 <CAH0uvoj=PJMbOR_iQDFxRsGN+Q04tkkHdAceReHoZANOtv3uCA@mail.gmail.com>
In-Reply-To: <CAH0uvoj=PJMbOR_iQDFxRsGN+Q04tkkHdAceReHoZANOtv3uCA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 22:21:35 -0800
X-Gm-Features: AQ5f1Jq9EUr_I848tMwfXYm17qUq1MvC7vt3jNKL1cfdGcj5Bzyn94grIV-BDHM
Message-ID: <CAP-5=fXpfBJCENkHGd=mDKCBOhCmVr0ieF5-MvUbbV03DSA_hg@mail.gmail.com>
Subject: Re: [PATCH v1 10/11] perf python: Add evlist.config to set up record options
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, James Clark <james.clark@linaro.org>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 9:46=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Hello,
>
> On Wed, Jan 8, 2025 at 11:51=E2=80=AFPM Ian Rogers <irogers@google.com> w=
rote:
> >
> > Add access to evlist__config that is used to configure an evlist with
> > record options.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/python.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
>
> <SNIP>
>
> > +               .user_interval       =3D ULLONG_MAX,
> > +               .freq                =3D 4000,
> > +               .target              =3D {
> > +                       .uses_mmap   =3D true,
> > +                       .default_per_cpu =3D true,
> > +               },
> > +               .nr_threads_synthesize =3D 1,
> > +               .ctl_fd              =3D -1,
> > +               .ctl_fd_ack          =3D -1,
> > +                       .no_buffering =3D true,
> > +                       .no_inherit =3D true,
>
> Are these indentations intentional?

Nope, not sure what happened. I'll fix it in v2.

Thanks and thanks for the tags!
Ian

>
> Thanks,
> Howard
