Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2920F1F0E26
	for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174393; cv=none; b=eyYTGMWd/Y4DtvmJq9Q2VeTa72UsfA46Y6RmcvgarVlMU60olGO7ar+JFYDnU8DBdZ5b4wqSj3AK6Ts74fUqb0HkO4Gt4RnV/RV5iXyU4FLjIXAZxbEdSubGBsm/zmQbrplEbelP5Kl5Z1KIsq5ydJWjVZo2JLMaF1dQN2J1cA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174393; c=relaxed/simple;
	bh=m3X02wzS76njaqHsgqO80nusK2eJUCQH4uItF1eSpdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4YTKTMIAGpWlNWT1Rkpb3HjiCHB7knQB1fW/LtmFezvpcNVdXd4DX/bIgoYm8sBpxqM7CdgL52CYB6aN45dt+IcoTnedDaQobA6SMKnzyWkk+kalzAsCXC6v1YtQNMHbQdGI80HwCQ8svuP1YLcS3L47TmETKw66lTY5TUNhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDjgLvsW; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDjgLvsW"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fa47f295dso21305ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 May 2025 15:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747174391; x=1747779191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UvfAJHIRWnQ+p9ir6YwP0vx6pRTMTNkEvEBeEPzn4xw=;
        b=WDjgLvsWsqLecw5rebxCXlqlRtyBxbO4nQpBHh5i660RtBm1kBm3qqY3k7TEMIcRLW
         PSP7hhpDHYUtAiuTowYwRyCPhSR3KzYUEfU6h84BE4jTLEv222v/AcYXVYkJ0NbJgzRi
         GfWB81NtQV5g6+MbRflmCSOgZ8Av73J5oAOaEyiRKMIIWB+E6rI4Tvyb8McmlEApTVWH
         alna1C6kgMctCK3lrh4VWT+i65kpnmEz45WPBg0i5TkM/1y6sgxx7RMN4NgNmdbVc9EY
         LHccMAno8aASIH1MpH8YwY5Koxif6zUWux9zQAm3m3FbwSAOUMYARndTJezvzLRN5gh4
         6/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747174391; x=1747779191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvfAJHIRWnQ+p9ir6YwP0vx6pRTMTNkEvEBeEPzn4xw=;
        b=uRrab1ujNRANFup0ODSzh2hHfh7I/rinuka278NVVM3nm4Atv8YkuUWSwUKBw3Yyku
         H24B+WcAnkTZhyfuZtlvHcbredZPh2Ca+ymzmkORJ0M978jQufJ0CYUKiqEnqBOX15Ay
         +7ShCIFYUf1P9OtttiMlyI1+seEEdjcXe1T14RI3PoUOKIqbjRzqSsHUgIulytTZfKfM
         u7KikzotZ7djHo+2EBLgU4Dupq91wbOuJ3fnrR4/GZmyVP20pBNVQUREWW3ZY/GZcQSm
         qoQcWO2tcCF+DldxD1xQv3SZqnk0YkUB3u368v17ayWTVG3Bz2VmwaLoA60twWAdpHPn
         Q8DQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmFQ/c+wP1NTfaY5Gy/GONe4xaEMvQAOtsDC+ojecqhAml50EgiszFdJDAbKk5+mDtwQmMPt9q1FX3vyrhzWzL@vger.kernel.org
X-Gm-Message-State: AOJu0YyD5eFxX8/cN0D3RsUPShnNxHZPdbP3tisvEMRNLLBu73PXAEce
	lhFy5x/TvoFFEpo84DfEKB3Yh1+bpP1tIYV6mMbMO6A9L2Db2GVspWqnUe2hVvONFJkFeK7jFWT
	MPp46NcnaEBTqOK3osCOQ1d+O4tto/Knq13NIq6Cv
X-Gm-Gg: ASbGncs5vroqNlSKFdIZholRcWJYtWfOKJFbRCt7QSpti7dg25tuBzxlIiALOMhlLfs
	2cCT0h9V70rDoyh4vgdqSarrSFfAeMBy8S8KGmTpngkFHD/jbAuvN8bMjbIzXdVMAMU2MIgGiBP
	70TB67P1pQ3+Wx7xfJ/7Sle6Cj4Uqze72obEUwNwlO/T+Q6pN3lBAPRkT7nyR0
X-Google-Smtp-Source: AGHT+IGK13UC7ns0GMUYJcxFVWFi0VHg+7Om/jbLCrHNV0DH6pq+FfUGmtxXNX7onPvv9ImPoAH2vSu7Mu8WiaNMxZ0=
X-Received: by 2002:a17:903:18d:b0:21b:b3c4:7e0a with SMTP id
 d9443c01a7336-2319ab28443mr387825ad.13.1747174391151; Tue, 13 May 2025
 15:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250406163412.897313-1-likhitha@linux.ibm.com>
 <E58C5DCA-5F52-4B61-A816-DE932BA40FDA@linux.ibm.com> <baad9d65-07b1-4a19-aea6-5ba5d60da98e@linux.ibm.com>
 <1b1450a8-f091-4091-981d-76b27f61be24@linux.ibm.com> <D1C1E5D6-085A-41D1-85AB-52809C956BFB@linux.ibm.com>
 <aAvKg8K2fyrZ6zy4@x1> <wqewmdha3bx7pmxqwbna26qnl55fcejqsjs4b2zhuciddpb3b5@7ztolpf6erwo>
 <aCO156Qh5mbeR4Sk@x1>
In-Reply-To: <aCO156Qh5mbeR4Sk@x1>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 May 2025 15:12:58 -0700
X-Gm-Features: AX0GCFt2ZXiEO9TuXFPm0bKw1-QAm8lVQ3r6wPOHiSdsHNW8kwJjOrdLgaqNTTY
Message-ID: <CAP-5=fXtppSZZc=DxDRkdXgVmqFycaSsji-MVOvFK6go9GY=3A@mail.gmail.com>
Subject: Re: [PATCH] tools/lib/perf: Fix -Werror=alloc-size-larger-than in cpumap.c
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	Likhitha Korrapati <likhitha@linux.ibm.com>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Madhavan Srinivasan <maddy@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 2:13=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> On Fri, May 02, 2025 at 01:14:32PM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Fri, Apr 25, 2025 at 02:46:43PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > Maybe that max() call in perf_cpu_map__intersect() somehow makes the
> > > compiler happy.
>
> > > And in perf_cpu_map__alloc() all calls seems to validate it.
>
> > > Like:
>
> > > +++ b/tools/lib/perf/cpumap.c
> > > @@ -411,7 +411,7 @@ int perf_cpu_map__merge(struct perf_cpu_map **ori=
g, struct perf_cpu_map *other)
> > >         }
> > >
> > >         tmp_len =3D __perf_cpu_map__nr(*orig) + __perf_cpu_map__nr(ot=
her);
> > > -       tmp_cpus =3D malloc(tmp_len * sizeof(struct perf_cpu));
> > > +       tmp_cpus =3D calloc(tmp_len, sizeof(struct perf_cpu));
> > >         if (!tmp_cpus)
> > >                 return -ENOMEM;
>
> > > =E2=AC=A2 [acme@toolbx perf-tools-next]$
>
> > > And better, do the max size that the compiler is trying to help us
> > > catch?
>
> > Isn't it better to use perf_cpu_map__nr. That should fix this problem.
>
> Maybe, have you tried it?
>
> > One question I have, in perf_cpu_map__nr, the function is returning
> > 1 in case *cpus is NULL. Is it ok to do that? wouldn't it cause problem=
s?
>
> Indeed this better be documented, as by just looking at:
>
> int perf_cpu_map__nr(const struct perf_cpu_map *cpus)
> {
>         return cpus ? __perf_cpu_map__nr(cpus) : 1;
> }
>
> It really doesn't make much sense to say that a NULL map has one entry.
>
> But the next functions are:
>
> bool perf_cpu_map__has_any_cpu_or_is_empty(const struct perf_cpu_map *map=
)
> {
>         return map ? __perf_cpu_map__cpu(map, 0).cpu =3D=3D -1 : true;
> }
>
> bool perf_cpu_map__is_any_cpu_or_is_empty(const struct perf_cpu_map *map)
> {
>         if (!map)
>                 return true;
>
>         return __perf_cpu_map__nr(map) =3D=3D 1 && __perf_cpu_map__cpu(ma=
p, 0).cpu =3D=3D -1;
> }
>
> bool perf_cpu_map__is_empty(const struct perf_cpu_map *map)
> {
>         return map =3D=3D NULL;
> }
>
> So it seems that a NULL cpu map means "any/all CPU) and a map with just
> one entry would have as its content "-1" that would mean "any/all CPU".
>
> Ian did work on trying to simplify/clarify this, so maybe he can chime
> in :-)

So I've tried to improve the naming but not vary the implementation
greatly - initially I was in the code fixing reference count checking
issues. There is an important distinction between "all" meaning a
range of CPUs like 0-15 on a 16 core/hyperthread system, and "any"
meaning the special "-1" value. It is possible to have a perf_cpu_map
to both be "all" and "any", iterating an empty perf_cpu_map has
strangely also meant the "any" and so the code isn't specific but
relies on these odd properties.

Anyway, I'm not sure on the implication of this with
malloc/calloc/unsigned... It would seem reasonable to me for
__perf_cpu_map__nr to return an unsigned number and to propagate that
to fix the new GCC issue.

Thanks,
Ian


> - Arnaldo
