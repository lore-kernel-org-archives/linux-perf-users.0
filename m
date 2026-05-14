Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12675390C85
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778780364; cv=pass; b=W9yXJfiCdKN+o33h4bBmXqaSOZUjRvZr0Ll1AhOy6FIiQ/LIUo6Uff8xmTT6lTzEhNwk5ZhuczfqPpC/JMBqgtXk3LPLkS/fAJxplBsaH40TlY2F93JsCT2sgyBpt539fo9YeSRNnyYkJCsMf48UqB1oHtWVWcOe8NMKGdKWe70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778780364; c=relaxed/simple;
	bh=gjmta0x1qFhJ4QOa2GYKSFG8Vgssq4CiZaim2XAJvW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/VD7glECuCMHjp3XcIzbSpFkGnRmh623nAbZau2/+igvrDi0NWUHVXONg2R+yGlXyx25fYUOqeEgTc3E9Nv9xArjffFQv6SYE7onkhVnGhcw4ytMEYjrn1dF/DUCD8mD0nXH5W6VM+0KBEDdMuiI4MeMgqWg0ovINJ4ePf9Spg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVG11SO4; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVG11SO4"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-133362c30cfso55c88.0
        for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 10:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778780362; cv=none;
        d=google.com; s=arc-20240605;
        b=bB2VLBcP/ntyGDmP20280/BC6ozHOcT1d94zaHppsqPnbYweSTofAhkAeuUhYrb1A6
         3zja39884EXYX4rLIRF8DJ/grewYtSgUmYN6MvX/OEO4aM9qGPSSOdRrs1bPx5EB4kjK
         FvetByX2i1sepYUfFSi1PtGxDA+AYfky37k9/xzNbArTiH5vg3ycTDKV2K433ZRx4khR
         m7Bze0ZulQvDtcmG7V4UxKoNlFTEWIKrirTeY+4oWuSkfhn8ALHt7FnZO30qXDqfrkmw
         R7IrWPmkyHHEnF4hADK7ZXCtzTiaOPf7rfNYiqc1v5aRwPbG2DrA95r0IIU2CDuILmZQ
         PmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=flbnqlPmdt6RF8kSIPKQawkbETZpD93IRThriGAsKbI=;
        fh=Sj34cdNnE5QGGFe440zDT3IBAu54O6faxlcRTnlVIXw=;
        b=We0tSFca2wuRyyUYCmB2M6CjyO+ea96/++XtEDr/zUb3WUe7y3ETNUOjqKYEZbVjHs
         pIhN3hMBiyRs6BzosLACDDg7YT/4m6nddPBIDuD3kv0tvBHTNZIJiJR6Djo6VeTRFybi
         im0IIOkh6mNBa6hlXW+7a0jFxmXPJBYmnBGeAUZ+mTTr/s1B2K0pr0ExLQLvUn6prZd8
         rcZypGu/AuquyQKf03pwtP6shX+w/De2MGcyRzX0C4r6A+rwiexL7tlhMQopfXAxSxts
         F3nr2RkYRvL8l/oKrqMhq1UDH0rBAOQOW2DebfVwkK0iwghKXolR2r39xYOIlxw51xfG
         AFRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778780362; x=1779385162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flbnqlPmdt6RF8kSIPKQawkbETZpD93IRThriGAsKbI=;
        b=eVG11SO4+aqjWIMf3L9rZ7/FNne+WikofHa9MUZ1bWPrpp2l7PNi93OAPsSFkUbUkV
         OZ99c+//JPjq8syVIqR9+AidaWX9DvnGIth8yTerIYQG2SuQCAnvX3eDipcLfwchT0tS
         fWBDFa1lN1/1XlfG2DUMF1vqjJXZpC4WybOrcJRbJCSXVqQ1QlbvoM8wecz1eLT/3wPn
         7cGyXdnHTSGmdCzMcYt7Mm2M0yMnjhxmdNUh/7BN8G7JcGbtKoYugMSkx1vqiqonmf3b
         m/pZk/uev30z2E0AEVuK5svTQUwde/hvtyFxbJw1ma4LHMFE/P8xGtuDadTD0+zsTeTE
         okIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778780362; x=1779385162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=flbnqlPmdt6RF8kSIPKQawkbETZpD93IRThriGAsKbI=;
        b=Sw3CvF9hNmJbTgbEp6RIY173fZVsVHUBxbJ2yXWhw2PshfwZsEGwAacQ5L4xmtdxDh
         HtiRdvJJMAlYuzsBRGJHOD5qOZopi5zyf46VwpLNVffGMOEkFDp6i9A4mFYovg8+CeIh
         7th0vbTEtavSu4MsD86aGxUGCWr73gJh+D1B7rdrB1mBX7yF8D1y9ICVy5Sox1P4GIYB
         rcAW9G2J/kpd5Vjl2mUdRCcASNPvQmCXV0oruu8Zzy9sUhzfRKv755lloMFW5D97QX9Z
         EwhFntfKP43IbzspyPYTIeNuvpXSXdbC47RNpZz1oBCRTc1WlCYGp+IEgZm9vnUkdK/c
         d5sA==
X-Forwarded-Encrypted: i=1; AFNElJ8khAO4pg5dNmzA//htORtO2V/WCdsd8UEQNYP0HsfWot4RckJ3e6ZhZGwIGZrFDTRbGVDl9mh0ieOEK4e43grv@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/VfdRWTMDkUt3orkFCbxodVqaxm3IbVAa/QjZ5TyAc7r1S6/
	Akhy6js50Nlu+EOAHC8UHB/6ugxHwgBQHpK2ajwLhWZc712ztCW6GA+UorsxdcXKtJbU6TaPUcV
	T1TmVv4VH1VDhKH9EIDXM71USZ+C6BRn7ZTWzWy7v+iJlTmVZlyWkBMm+
X-Gm-Gg: Acq92OEJ4EZWovqQ8qP+7FhZY2T0ycD8Evd0EugpEUwH335BV2jjn4R6mXFqM7EWLYc
	SKzA/onSi99craijea1q/hUxNIUYFFSOyKHEQZh0C5IBbizV19tNcF8idZxi+DIGryhQDnIM5iP
	dK1818J5PjR1rSN14LBRYEPS3TZY3Z4fQ21pYEYh+MD6RqgfxuFtk/nQ2rRSfohCNuaKmAyiTGL
	81lgWcRq/UjHs6b3Qm86/fE1lIbGLmHCeKaUiWsR4YdkHc0JjzVp8oejaojJub8GhLMXLGd5Ci/
	EpBXWmrSZmnU/JuXHKb/sXnLm0/StFRo0R9bdTnUSr4h8tc=
X-Received: by 2002:a05:7022:1286:b0:12c:8f55:cd0d with SMTP id
 a92af1059eb24-13503ce1652mr6171c88.8.1778780361406; Thu, 14 May 2026 10:39:21
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acyWR2GAWIY7TKyD@google.com> <20260430161725.3131665-1-irogers@google.com>
 <8c5343a3-a110-420b-9b61-3e4dd0e3c902@linaro.org>
In-Reply-To: <8c5343a3-a110-420b-9b61-3e4dd0e3c902@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 May 2026 10:39:08 -0700
X-Gm-Features: AVHnY4IUf_QXR50I7XtQShSrMP9yh7fdyDmX3WMopqOF1j6oDT21aTqOKZqFNM4
Message-ID: <CAP-5=fXRjQKaHQWvNXiDyNZmDvtC=uYujgFsz7wmC5AJVK9d-w@mail.gmail.com>
Subject: Re: [PATCH v2] perf metricgroup: Avoid scanning unnecessary PMUs for
 identifier match
To: James Clark <james.clark@linaro.org>, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 2:12=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 30/04/2026 5:17 pm, Ian Rogers wrote:
> > Only uncore PMUs can have an identifier, so add an optimized
> > perf_pmus__scan routine for that case to avoid all PMU types being
> > created.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   tools/perf/util/metricgroup.c | 11 +++--------
> >   tools/perf/util/pmus.c        | 18 +++++++++++++++++-
> >   tools/perf/util/pmus.h        |  1 +
> >   3 files changed, 21 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 4db9578efd81..5a489e97c413 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -415,14 +415,9 @@ static int metricgroup__sys_event_iter(const struc=
t pmu_metric *pm,
> >       if (!pm->metric_expr || !pm->compat)
> >               return 0;
> >
> > -     while ((pmu =3D perf_pmus__scan(pmu))) {
> > -
> > -             if (!pmu->id || !pmu_uncore_identifier_match(pm->compat, =
pmu->id))
> > -                     continue;
> > -
> > -             return d->fn(pm, table, d->data);
> > -     }
> > -     return 0;
> > +     /* Only process with the iterator if there is a a PMU that matche=
s the ID. */
> > +     pmu =3D perf_pmus__scan_for_uncore_id(pmu, pm->compat);
> > +     return pmu ? d->fn(pm, table, d->data) : 0;
> >   }
> >
> >   int metricgroup__for_each_metric(const struct pmu_metrics_table *tabl=
e, pmu_metric_iter_fn fn,
> > diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
> > index 9a2023ceeefd..5e3f571450fe 100644
> > --- a/tools/perf/util/pmus.c
> > +++ b/tools/perf/util/pmus.c
> > @@ -409,7 +409,7 @@ struct perf_pmu *perf_pmus__scan_matching_wildcard(=
struct perf_pmu *pmu, const c
> >       if (!pmu) {
> >               /*
> >                * Core PMUs, other sysfs PMUs and tool PMU can have any =
name or
> > -              * aren't wother optimizing for.
> > +              * aren't worth optimizing for.
> >                */
> >               unsigned int to_read_pmus =3D  PERF_TOOL_PMU_TYPE_PE_CORE=
_MASK |
> >                       PERF_TOOL_PMU_TYPE_PE_OTHER_MASK |
> > @@ -486,6 +486,22 @@ static struct perf_pmu *perf_pmus__scan_skip_dupli=
cates(struct perf_pmu *pmu)
> >       return NULL;
> >   }
> >
> > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, c=
onst char *compat)
> > +{
> > +     if (!pmu) {
> > +             /* Only uncore PMUs can have identifiers. */
> > +             unsigned int to_read_pmus =3D PERF_TOOL_PMU_TYPE_PE_OTHER=
_MASK;
> > +
> > +             pmu_read_sysfs(to_read_pmus);
> > +             pmu =3D list_prepare_entry(pmu, &other_pmus, list);
> > +     }
> > +     list_for_each_entry_continue(pmu, &other_pmus, list) {
> > +             if (pmu->id && pmu_uncore_identifier_match(compat, pmu->i=
d))
> > +                     return pmu;
> > +     }
> > +     return NULL;
> > +}
> > +
> >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
> >   {
> >       struct perf_pmu *pmu =3D NULL;
> > diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
> > index 7cb36863711a..0d55edb3f2fc 100644
> > --- a/tools/perf/util/pmus.h
> > +++ b/tools/perf/util/pmus.h
> > @@ -23,6 +23,7 @@ struct perf_pmu *perf_pmus__scan(struct perf_pmu *pmu=
);
> >   struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu);
> >   struct perf_pmu *perf_pmus__scan_for_event(struct perf_pmu *pmu, cons=
t char *event);
> >   struct perf_pmu *perf_pmus__scan_matching_wildcard(struct perf_pmu *p=
mu, const char *wildcard);
> > +struct perf_pmu *perf_pmus__scan_for_uncore_id(struct perf_pmu *pmu, c=
onst char *compat);
> >
> >   const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)=
;
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>

Ping.

Thanks,
Ian
