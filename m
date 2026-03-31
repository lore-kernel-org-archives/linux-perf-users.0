Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1056E3FB04D
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 14:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774965978; cv=pass; b=BfMS9vi+xjgfcRD5tcaPv8RH47D+ZDa+fh4LpVxwtrT2MmMyQIQ4mc7kuu5xKWyOeK+vVa2hoXfyFnbcqk5zJyUhBpY4qoi5JBSs4kSIOBlrD+jDNrHwII0ZJiNZvGrfV21yjuD3Vgdjw1LEGvRI/l3jlkZuUYH4DGYFl1E3a9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774965978; c=relaxed/simple;
	bh=35knIS05r+0/zDDy6wAojCvHGYRDPNcejxc81KGSLIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJnpcEQUn/TIkUnbDlUWwggBbsHVX1odQ3FaJmxCf0JcdbPL0JZ2dSnxGOjmKg/SQjJEkoXrcCNhlDmLMncfYqqZGatE9G09LO3Ukja934dsCTxAXxSz6lOsnMeQvE3mXwKWXZXUcBKuPwpts9zCf97CJFYPiLvWyQAi4cQ3muk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KaJSlQD2; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KaJSlQD2"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b2591757fbso110615ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 07:06:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774965971; cv=none;
        d=google.com; s=arc-20240605;
        b=DI+BHnKDhmmSTc7iI7tGXjn55zGpQw7SavnXEmIhBbUOMASfXM6aC8JBdlTl/YEggG
         O2CCZr79ScJi4jXBnXWTuhLlZiNbylNvFXHbRKNrNGfh01rBwQIJZXDtVw1WVL20vKfz
         LF9y+pvW10/VMbV47Ez6Q/zTdFWaHiidtvvNnH2On+7ZUf01rMNk9FStEf5DNjoDBYrW
         Z/R1ylPsaiovwnYM7AqsSuSTRpxiqILb8qnAsXvQRfCdfdy+RLnnTRGsUDIjhlOW6hVp
         RobrBeylx4UpjwpyrXKXhub3fdDKAY2+fuG3USuRNcwou1KHw2ZClE+B7aIPfnW0eKvT
         OsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PDGsXaUl+myNwvEP+SvZyruG0MyrHpxc9v3bJYoOIbY=;
        fh=JaR3MQZU0PHfPXkFHJJcd2DIuI9ZYfn14VsXXo7Zlh4=;
        b=kUrmo1wB/lhOMyFW8KfkcoC8ZUvIU9lQCZONO2tJYnE+6PHz5LJ4mJdOJSa3AtIuMD
         BSD4Qay+FOfPxxNtrzZhtq1OT+GHUSHLhI+fJ6CFdkYgGAJ9fdjxCJeQq+oixc8FbNwh
         NC4e2IpYaNO2bPKUPuL2AxixobD3r1Qo3e0E4XVaImsFjqlU9Rgo/hJ7jFpUUtis8NuT
         CTFRCPgTGXX8FiQCVo9U1w2zZoZGunYHOZ3Ci1Gzhh8YUPSRvlTdc1iGDYiyirHCoHrS
         BzrgdDgQ09X6LuPbX0J7EStalFDnoS1AdE8b0k3nEERvZ8M9Fj/0y6d4SKptziwvluHv
         cIKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774965971; x=1775570771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PDGsXaUl+myNwvEP+SvZyruG0MyrHpxc9v3bJYoOIbY=;
        b=KaJSlQD2eUbDRS8eX+iGmUTzt+B38W3lUBtfVmm/8xStypI5zIGvslPegPf3D6Q3wC
         Uc/AQdL0SCAa30hTVvn8rFaCzWfsbkw0GktXv3jQT/ZOd/p94iLUkiJdabeue3JbWjLU
         eAooUlfBIVYOO6LbTBmHdbE+wAH2Y+1RX5T3OfIelBTNbeOn2ri1HCRicSdviQTi8Vtp
         z6lPJJWq8iaPy1pryfTKox6fbO+HlzgLwH5x5VgG7gfcsGziRv9281vADWu1Zm0COYfF
         T48oTYvRcW3ZzESfMY3kKZlMEBQjIHs64S6W5V/M293mTbD45b6z64XEMyjVeG+FNiaF
         jxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774965971; x=1775570771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PDGsXaUl+myNwvEP+SvZyruG0MyrHpxc9v3bJYoOIbY=;
        b=Fpi2jLnPGOW3xTaEwYWZp0CDkEBWPxVkrZo4vNvcS/ExOfF5RcNiamZtaIv0k48fTF
         i2KAuugwc677lNrS/dZuABlERRdF6lIYXgDkVbdiXtJCxilb9yDoc4BbSoQi9Zb951ss
         qyEpDYcNFxCaArEKNeZOhf3rBHPOzZ9BCM6u5YNYudazBPhu019ZxrneJwyamfa0OfQC
         zbv33LIRoBHNP5Hmm/AcbibIyoy+dUm4jDq6xjszUobO3OCKSdF6hk/FlKQjdWHxiT3y
         PXN8xR7Ll/hCWh5ixfQxgYjFR/1kAvgDibaH8Yv2xlgpcyKdx57lSgZ11tMAnDEqL1SF
         46rQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEygSCtkfGHy5dlYKhsY0COfFakCJ62niLWs2ITe1IhD8UsEGVImApCSTEqCOoHnzFcbEtNSmGzmBWi/Z22idB@vger.kernel.org
X-Gm-Message-State: AOJu0YzTAULxnyMYuB5vzeKfs7OZxgSEH/ZV+8tKNlzDfvuch4ceFFYL
	ty0gVBEheO7//r2g/BJRdPB7PPWD+tol1oZB3kX22mn8NXFhIMz0cqmjRH3kr4IkT3yqoIq6w/5
	iqhieI+FYukF63n+u4W6SZ9CzNaJ2ayvYdEaauz+e
X-Gm-Gg: ATEYQzyqWnhZYzxaMA48KUiWK+8COm5bWzp5WOfzodpLeselUqtOvBvFFLRmSdKabqV
	F5WKUfUo1Y+OdR8XvBdQfp1QzEfxayNqpcMPhYCPRRmTuqvcqOgONBS3nzRmCzGzyYQqiHxCz9y
	5QmkkTIP4n6cwx/l00kzRNl9Vr6BI2s4MkY/D+Fbe9yH1QuyszQJEB2UgNtqo8sVS7NT4GUE7fM
	fczMRPSfFfexzdJC72JJNypFR1eW/qGQB1aHQvJ9ss0A4y4n4iGZDd8p/P1JTVS68X1EzqwPQIP
	49VaaKOA
X-Received: by 2002:a17:902:d58e:b0:2b0:5193:1212 with SMTP id
 d9443c01a7336-2b25f6cd077mr3358735ad.4.1774965970525; Tue, 31 Mar 2026
 07:06:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326224454.2101190-1-irogers@google.com> <dcf5a92b-ef14-43d5-9f21-568252fd630b@linaro.org>
 <actqG7NHUWR8x7x_@google.com>
In-Reply-To: <actqG7NHUWR8x7x_@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 31 Mar 2026 07:05:58 -0700
X-Gm-Features: AQROBzB2QONtm85edap_zw31sApG9_yjOEbmg8Ss9M0M8kKJKa4B6ZX65SvPrfQ
Message-ID: <CAP-5=fVOtY8NYQnhwgyexyjDN+W4Vf2Yo+_Tm6chZSfYFx-OMQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Mon, Mar 30, 2026 at 03:44:21PM +0100, James Clark wrote:
> >
> >
> > On 26/03/2026 10:44 pm, Ian Rogers wrote:
> > > Only uncore PMUs can have an identifier, so add an optimized
> > > perf_pmus__scan routine for that case to avoid all PMU types being
> > > created.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Reviewed-by: James Clark <james.clark@linaro.org>
> >
> > > ---
> > >   tools/perf/util/metricgroup.c |  8 ++------
> > >   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
> > >   tools/perf/util/pmus.h        |  1 +
> > >   3 files changed, 20 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> > > index 7e39d469111b..769b38400832 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -410,13 +410,9 @@ static int metricgroup__sys_event_iter(const str=
uct pmu_metric *pm,
> > >     if (!pm->metric_expr || !pm->compat)
> > >             return 0;
> > > -   while ((pmu =3D perf_pmus__scan(pmu))) {
> > > -
> > > -           if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, =
pmu->id))
> > > -                   continue;
> > > -
> > > +   while ((pmu =3D perf_pmus__scan_for_uncore_id(pmu, pm->compat)))
> > >             return d->fn(pm, table, d->data);
>
> Sashiko review: it's natural to convert it to 'if'.

Yeah, I saw and disagreed. The pattern with the  "while ((pmu =3D
perf_pmus__scan...(pmu)))" functions is for them to be a while loop.
With an "if" it would read:
```
pmu =3D perf_pmus__scan...(pmu);
if (pmu)
   return ...
```
and we lose the consistency of having while loops in the code.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > > -   }
> > > +
> > >     return 0;
> > >   }
> > > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > > index 98be2eb8f1f0..9859d7056fb7 100644
> > > --- a/tools/perf/util/pmus.c
> > > +++ b/tools/perf/util/pmus.c
> > > @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcar=
d(struct perf_pmu *pmu, const c
> > >     if (!pmu) {
> > >             /*
> > >              * Core PMUs, other sysfs PMUs and tool PMU can have any =
name or
> > > -            * aren't wother optimizing for.
> > > +            * aren't worth optimizing for.
> > >              */
> > >             unsigned int to_read_pmus =3D  PERF_TOOL_PMU_TYPE_PE_CORE=
_MASK |
> > >                     PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> > > @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_dup=
licates(struct perf_pmu *pmu)
> > >     return NULL;
> > >   }
> > > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu,=
 const char *compat)
> > > +{
> > > +   if (!pmu) {
> > > +           /* Only uncore PMUs can have identifiers. */
> > > +           unsigned int to_read_pmus =3D PERF_TOOL_PMU_TYPE_PE_OTHER=
_MASK;
> > > +
> > > +           pmu_read_sysfs(to_read_pmus);
> > > +           pmu =3D list_prepare_entry(pmu, &other_pmus, list);
> > > +   }
> > > +   list_for_each_entry_continue(pmu, &other_pmus, list) {
> > > +           if (pmu->id && pmu_uncore_identifier_match(compat, pmu->i=
d))
> > > +                   return pmu;
> > > +   }
> > > +   return NULL;
> > > +}
> > > +
> > >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *st=
r)
> > >   {
> > >     struct perf_pmu *pmu =3D NULL;
> > > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > > index 7cb36863711a..0d55edb3f2fc 100644
> > > --- a/tools/perf/util/pmus.h
> > > +++ b/tools/perf/util/pmus.h
> > > @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *p=
mu);
> > >   struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
> > >   struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, co=
nst char *event);
> > >   struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu =
*pmu, const char *wildcard);
> > > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu,=
 const char *compat);
> > >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *st=
r);
> >
