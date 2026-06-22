Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE65342173
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782150846; cv=pass; b=cERvNeivpstqvh5sgY0vG2xhCf72WyBmxuv5F2aG6cSRmaB/stK8TsRPquGvZ2Z2Xtz6PBcnvp7HRnMvO183EoBmukVNkKxEtvzHZjf5s9/WJxjWUPKgfXRyOvFGvHVmDPs5IU3GU3QjRqXKSfqGz+o8EfdYgkRT69QBUCHnnQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782150846; c=relaxed/simple;
	bh=W7X4AUb3Et7sMWR1klAYzDvUIOZThnqlSXZOvunWVWU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FzDq5LChAdvdbf+kRPH5+Iyh5CAROAVNe1rBn01OsmTIgKOhfSQ9peJ/GrqJaVcG837znw26ZF/gD5c1VBtU3QmC9D8UyZY5mBGGzq/8BGFQPX8JlW2V4woUqYXMThaZ9G9hkQWtM/qdeDfao7jxT9KCUfAezKRjoAHrvBc7ZWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JfsTRYAO; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JfsTRYAO"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c69fa0b1f8so5435ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 10:54:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782150845; cv=none;
        d=google.com; s=arc-20260327;
        b=ZmSd97Vm71W9kvlXdZ6B0K8f2f3x+XLFiSU05LqMzXsNQDbG6F4gT21prg8QBNUTLo
         xF90tLzm5j8gUnWNjHIw88lG12jWU9zF2KpZL/8nvrsOzMwOUDxYc7IfABhaV6Z6QeLT
         6+qqHSGDGpIm2nlf7w8cUb7h7AfeBYuqzUMKdsGkOML0aRYV/FysMlVRfWDNcYBBvWHp
         OdrV7v7I29yMCXf+0lh0gjvjwNgxSTEJSrk0UQPXNEMzOguHh6G0MBDYBrKkvCrCKZWA
         2LxMpP1QZ3JFTqFtHMto1KGyIhRCl4on6Nub8TwgbQ5rlq5a5WgxDNcZ55ku7AqLK5LI
         YjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RZOtWvhAwu9tRqSHi8Z01QBD2QiiSEUjq5c3ZDPlik8=;
        fh=KPBQGabWmZB+TELdG99e5a1MxsHNy9WMlCjWHJoFIE0=;
        b=ddVf00DXOuffNjToaqrsyboJ0iS8rDVaR1JJ0RuBatowCikV+P6o+emA+vKRCFZP1L
         Lk0pnwtQjIymsqg2/tbrggbrFtj+T6gWNsleGqNkKvbyJqhwLn8tTRRbGGoHoGE8Ggnv
         aaV/X3AS66CD7ZFJzpAJYbaBiB7wmbaHi1t1kqEg7pD8QZQ4DRBXrM0Bh32JchWOOwYW
         7kVYPs3jOmxVQJuPZGbao56guTKj7YTTxdSh8oNQau/FD/VLK/EihM+SG7RPoMGO1NvY
         hRNWPQAgMqv3l1OE80yG1gUnQMiVpPCJ2VmeupEkeXcS8ZcxsjYZ++KNIW6HjNgeYSrV
         pJxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782150845; x=1782755645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RZOtWvhAwu9tRqSHi8Z01QBD2QiiSEUjq5c3ZDPlik8=;
        b=JfsTRYAO/+FCjVC1jLXxGvju671cbHgEbn9RwkUHAKLGelCBCzNTd89WKiiC/PeJ8j
         5EUblC10zmOrNhLiuSAMBFURPt1CT9csfKwgPw0Hw3xs1EGpHPu+EE9p18nNF/vW13y9
         0d+qZW0OuL1AZKxbX1lCoZPltaqsq8IOgagnujtmzbMDEKMkHDJZN9D1LfoZwmAYZAfz
         F7iuJb8+8tUPJ5ug7KU/xidWTBFSBd5wrLe0Puv2/RO/e8xfy1wIUXzkJIVQk/kaXlJX
         aJL5gEzWb2WOPAyua7R9hzy4EWOe6aCoE7OhiRzwsxQy5Gm/tHLAEllMtSUeQsOCtasu
         09sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782150845; x=1782755645;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RZOtWvhAwu9tRqSHi8Z01QBD2QiiSEUjq5c3ZDPlik8=;
        b=aHS5y/2YD5/wN/KbFrvmnEWYG/FBYJpNbS2X7vvOKeanQ9U1vi2n21YebJzLMdzssH
         6yH/aWX9Y0F5yCrJwIgN5LFX4zR+24sormaL06ZS5fzfQeKSK9z5ETysyN3fnDY1m/aP
         qcUYCYksr2+AIdOk+/P5Ts8JULMKwo3tKu10tF29KByF610SyKo+fjm6zPWHDKlkwNBd
         GaySg5TLbv3WcLdCIRzqI+WTX9ouJ/04yrst99KQnK+BlS0R2veonIOOpVUxY3gqMScE
         2puptoXIHMrIOMqWQz85y4Vw+eHaotOjVbNsmmQbFj7Zw5ER4wVhLx3/Zcko0Gb2PSYA
         bCFQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6H3N3fuQ92tfnwUdt2KslkDP4L1ACNAjBDGIbG08ipODwh+fUih5cnWR+E489m6jdYv88Mxa0ph6vMOlqTugL@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqb5GmGscW+z3wXnIanlnBhA6y6ED9sqO6+1OoOtS5cRjCWKr5
	ZhYcUwXkc38Vj5TZ+E1lbm/FmOA57wRU3HrjxCzSn1FahsNgRHOq9rhDg6wabDD+UJ/3kU2RKo+
	GSglgu/xg8JVt7b6j+k611hkVx/V9hpR0bCLvtw/G
X-Gm-Gg: AfdE7cmIf91FtP2Zvzd5B0LGfb01ax0goj/OHyxKwfY+SYtMBcLoyP9bDA1wx56m2sI
	uBe6B4B1WXjWGbYPV0H1A94GlOgkkDJteT5CyPzfmcoKSM1r4t3tRAGTwNYzuIKB7ptTANEXnkP
	V9rkitpOI7o0qIZUuTepRvgdgUbyC/vU+ozZEHG71wXcgm1wqEHy9D/BFbRwXOFClDhxvfZPYhZ
	Hq3t7N9hkBx5zA8ObGqbXMgovLTcG8hVPTZClKg/Wc84S0goWmSQ7qph7iGu6t/TlLuobOsQnVZ
	1buJ/fKO
X-Received: by 2002:a17:902:ebd1:b0:2c7:9e6a:1a8d with SMTP id
 d9443c01a7336-2c7c513e6f2mr214375ad.12.1782150844196; Mon, 22 Jun 2026
 10:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612012413.3253516-1-irogers@google.com> <26291bce-9be4-4edc-9dc5-4c685d9811c8@huawei.com>
In-Reply-To: <26291bce-9be4-4edc-9dc5-4c685d9811c8@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jun 2026 10:53:52 -0700
X-Gm-Features: AVVi8CfKGLu_QsQO_3I3w1dPwEJNp61fhexkDHwYkK88CU3ngqTCxUBhBLa54JQ
Message-ID: <CAP-5=fWY35hNSi8uNjX95TnDMmC3Pek9B7Yaf6Ax0ty_6ZtmCQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf pmu: Recognize default_core as a core PMU in more places
To: Qinxin Xia <xiaqinxin@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Athira Rajeev <atrajeev@linux.ibm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 2:11=E2=80=AFAM Qinxin Xia <xiaqinxin@huawei.com> w=
rote:
>
>
>
> On 2026/6/12 09:24:13, Ian Rogers <irogers@google.com> wrote:
> > The python metrics code used in places like ilist.py passes a
> > pmu-filter of "default_core" on non-hybrid x86/ARM/.. systems. As a
> > PMU like "cpu" isn't a literal name match then no PMU matches
> > "default_core" and the events fail to parse for the metric. Fix the
> > name matching and PMU lookup for "default_core" and check that it
> > fixes ilist.py.
> >
> > Fixes: 74e2dbe7be50 ("perf tools: Add --pmu-filter option for filtering=
 PMUs")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> > Note: this bug is in 7.1 but it is a little too late to send for the
> >        release. It should get picked up via the fixes tag.
> > ---
> >   tools/perf/util/pmu.c  | 6 +++++-
> >   tools/perf/util/pmus.c | 2 ++
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index a550f030b85d..836e3b5615cd 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -2660,8 +2660,12 @@ bool perf_pmu__wildcard_match(const struct perf_=
pmu *pmu, const char *wildcard_t
> >               pmu->name,
> >               pmu->alias_name,
> >       };
> > -     bool need_fnmatch =3D strisglob(wildcard_to_match);
> > +     bool need_fnmatch;
> >
> > +     if (pmu->is_core && !strcmp(wildcard_to_match, "default_core"))
> > +             return true;
> > +
> > +     need_fnmatch =3D strisglob(wildcard_to_match);
> >       if (!strncmp(wildcard_to_match, "uncore_", 7))
> >               wildcard_to_match +=3D 7;
> >
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 5e3f571450fe..e0a4cb2428ca 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -150,6 +150,8 @@ struct perf_pmu *perf_pmus__find(const char *name)
> >       bool core_pmu;
> >       unsigned int to_read_pmus =3D 0;
> >
> > +     if (!strcmp(name, "default_core"))
> > +             return perf_pmus__find_core_pmu();
> >       /*
> >        * Once PMU is loaded it stays in the list,
> >        * so we keep us from multiple reading/parsing
>
> Thank you for the fix, Ian.
> In the previous patch, I overlooked the handling of the "default_core"
> alias. Also, perhaps we can leave need_fnmatch as-is, since it doesn't
> seem to affect anything here.

Thanks. I moved need_fnmatch's initialization just to save some work
in the "default_core" case where the value is unused. While leaving it
in place would reduce the diff, I think the optimization is worth it
as we would otherwise call strisglob when say iterating all metrics.

Would it be okay to supply a Reviewed-by tag? I notice this fix is
missing from perf-tools-next.

Thanks!
Ian

> --
> Thanks,
> Qinxin
>
