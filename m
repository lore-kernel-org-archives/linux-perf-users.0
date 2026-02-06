Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C444279FD
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770404289; cv=pass; b=Ft3ClvYWrGARr63xgPnAbafgIM42XdzoUnxAzkBbOhYZycXxDOXFdbWWenwb7OvPSubcm716CxTHuVAfiYfh9lUehjHexNaMXcm/mr7MmSR7zPgmaYZtL0HTFBqiVr6SRrr0meZSrPGbS67/JHTUVF4Bpr3EI7IExbefaDLfWwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770404289; c=relaxed/simple;
	bh=SXDttnRlbXRYNiEckdMWmKvijCfGiH55rqalRjEp49U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqfEKD1wWwo1TblJcQ2M3DIF7ZglUwrHMGztVYFr1XtX8fBY7YSCMtP3ox+mnBFCqrHSDejTQAyrY0SNsVVG6stcDZWTsQsBbdPSqXR8Wi5v6W/FBIA6N1gq/ztIoQWUiP6BL/ph+A05JJWbQwZ941gJd1+ZA9Tm5dLp6q+BBTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9iPrnNR; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9iPrnNR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1462573caso8785ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 06 Feb 2026 10:58:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770404289; cv=none;
        d=google.com; s=arc-20240605;
        b=MUiZBNQTL7Xzrt96Ife50rBUaVUXww+b4ra+t80Zm2Sw43RwtKpZ8Sw1DkMdGr5h02
         XbBZ/xkfpZ7mAECAaiRO0WHZqhK7FWQdYEv3g43XKOP7AOAKp2X2gwoaOkVk43cKjR8U
         Q5vyMM4j5zIyjYrUXHFkAkzKxdJ+wiV/ZcRsereAgym+JAyyH9OCwLEINdYvyeTOjftD
         IEWA4NNIE0pGe6j3RrPFyLl8Jq11rIvHpNYMzbERtnXBK6bNPNyi2JAqrEStQC13pqsp
         yyNFf1HryYeXCFU0GWqhA4DEjGQkKikyfmCTRNndItgMoEU1w9AvZOhLkvnuoClMYiW0
         1V0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=adwIcymTmhvsaT1R5OurQVqBF3H8HZu69mYo11ojbP0=;
        fh=nEIECAiO+yW9uZon1z0dQ9wA0/WIdPiDtrN/WPu/N1w=;
        b=QzRbFxNBvhl938JTMzUvDLSFQ9YCWDouu7HIytoqkAMw0DvehUT39pTk9s+wjQNDbb
         l7uw8WPQwFJ1igbg8HxiRufxdX4+f59d2tuBHi6Kr7+Z6s4sb7teewhEKM5pdFUHt4Kp
         5RrxF3Yt/RGKJwl+WAYI3kKhVMUCdetE/KmwjRRsXF+yiO5Do5V/njvm5e4mixpYKtgg
         6ADS28eEv9ST2Cr+ub4OcteFSH4wEiCX42aoXXXP4H6rolCMOafUGwRpc6ptJnE7ysl0
         exTFkdclaZqEFQ09a06XeuncbQ3NnpwyV/9FXhBMUxvPzYNdhsHAscv4dkVcKZvik/St
         /4Uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770404289; x=1771009089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adwIcymTmhvsaT1R5OurQVqBF3H8HZu69mYo11ojbP0=;
        b=y9iPrnNRWE3MLaZU5PSvs95yzCiTo9up1UPoio6sZNFxQJrh1g1Sncto4OCcjjWAwo
         B/ECDPLTEwPILPxQpnnEfGOIy1ps6HBIETUyQ/lFjbvtkiKad6joorP2JQF9Y1C9qCW3
         7MtgsGbeNh4hQCbIseKVB84lxoe1yuUgy4ZBsnNTW7KpqOEBJdZBJMUa+4jxfc9hK7ut
         H9bero9kCTwGcc2f9djRf871QRBX3pt3/ej9y5QI+t/KpXPtOvmg+DxA00NOXFMhYHxU
         AwHbPDe1xxVcwbppHc4/0gZAFpsLF2lDcDhUN58I+ewdGtrSVkzf4p9Sy6WYMI61QnTv
         8a1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770404289; x=1771009089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=adwIcymTmhvsaT1R5OurQVqBF3H8HZu69mYo11ojbP0=;
        b=dFKu63hvabOM50o1jkQ9FhvBGI3SDUegvznHPY3DMzexh0jJpqba4xgjjnLSKTkIdn
         CT2TpEuoJMn9xQyeTDO7KOT2RDOqW/bsArETGf7X+eiKKKhZE/ECWkkyh+ibk+kXQRTZ
         cF5vL3I3raMQ18filivSoX58Akq8yo3JhyhNo9EVsGp5jChYvnYqDgU2w4RUIKrlNw6N
         H5bnHVwpq8gZ3bqRuyk0XjHoxKpTpf3SiA5tjfaG9XqGFB4+yFyAnX5e3z3Kck5CSdjX
         Hh7jvgcWsjZ2LMtcTDDj4geG6i8Ub4riOtXNRpTY+JRmG+oDZQFgbMz5v5Lrwa4w1oFE
         oqmg==
X-Forwarded-Encrypted: i=1; AJvYcCXOaeParuMTwngvQ+MBas95USrU0TSzTyevzjSGejYBi0VmEFkOEJMLj9sLQY4rH1vrElh1YK3YBnzHElEFNwT2@vger.kernel.org
X-Gm-Message-State: AOJu0YwHmDbBGuZX7MFvHBOYYfj8LSpwWcNwulNcYnpdpbusi9aPfV7T
	TeTGlBQqO0TXpz1GinYbH6RstWpw0CrnLvTYvilcWmPT/znTrv8tAPIVqan8ne/mFtDdjgDIKVA
	YK/0klQ6a1zRn0e0n89AP9IRqFRdRPiBktdWGIoJc
X-Gm-Gg: AZuq6aKw8BeCQ6YUbQykKNDokkltK3SNqEIKce1UB3XZEbowM8uYxDzWPULfKUdgkTT
	Cmu9iAsCTmtldoJ2VlvrVejt7qu3dyVdXd0iXQKvoidpcVEucvfjJtKH0Orga+2YxO4/4WF+ds6
	hp/O/2BNEzcHC8B8TeuQqbogqmjvd3BO2HDrWr4Kndf2TN5GCddEC72pWu8vRPtmZIjC3C8nph0
	qD749O9ApVWNHO06259IgxeMhHuGXbdQ9Yh4rAP+u9vwJw1HW0j/GAF1QvIfxXsszVxxnl8
X-Received: by 2002:a17:902:dac3:b0:2a9:5bfa:54ef with SMTP id
 d9443c01a7336-2a961ec757cmr141855ad.10.1770404288231; Fri, 06 Feb 2026
 10:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205183603.459363-1-irogers@google.com> <20260205183603.459363-2-irogers@google.com>
 <20260206104543.GE3529712@e132581.arm.com> <20260206123310.GF3529712@e132581.arm.com>
In-Reply-To: <20260206123310.GF3529712@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 6 Feb 2026 10:57:54 -0800
X-Gm-Features: AZwV_QhO0PpyuC8oJ2_Dpy9BVKUFGALLzFlMwedTiIXhSyZ3DJohRTopO8CrXqA
Message-ID: <CAP-5=fV8ofWn2oYDip3pOX7+Cx0GyKckq_o0Q6qahuoqgydN7w@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf metricgroup: Don't early exit if no CPUID
 table exists
To: Leo Yan <leo.yan@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 4:33=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Fri, Feb 06, 2026 at 10:45:43AM +0000, Leo Yan wrote:
> > On Thu, Feb 05, 2026 at 10:36:03AM -0800, Ian Rogers wrote:
> > > The failure to find a table of metrics with a CPUID shouldn't early
> > > exit as the metric code will now also consider the default table.
> > > When searching for a metric or metric group,
> > > pmu_metrics_table__for_each_metric considers all tables and so the
> > > caller doesn't need to switch the table to do this.
> > >
> > > Fixes: c7adeb0974f1 ("perf jevents: Add set of common metrics based o=
n default ones")
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/metricgroup.c | 18 +++++-------------
> > >  1 file changed, 5 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgr=
oup.c
> > > index 40a1e14de418..46bf4dfeebc8 100644
> > > --- a/tools/perf/util/metricgroup.c
> > > +++ b/tools/perf/util/metricgroup.c
> > > @@ -1562,8 +1562,6 @@ int metricgroup__parse_groups(struct evlist *pe=
rf_evlist,
> > >  {
> > >     const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
> > >
> > > -   if (!table)
> > > -           return -EINVAL;
> > >     if (hardware_aware_grouping)
> > >             pr_debug("Use hardware aware grouping instead of traditio=
nal metric grouping method\n");
> > >
> > > @@ -1601,22 +1599,16 @@ static int metricgroup__has_metric_or_groups_=
callback(const struct pmu_metric *p
> > >
> > >  bool metricgroup__has_metric_or_groups(const char *pmu, const char *=
metric_or_groups)
> > >  {
> > > -   const struct pmu_metrics_table *tables[2] =3D {
> > > -           pmu_metrics_table__find(),
> > > -           pmu_metrics_table__default(),
> > > -   };
> > > +   const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
> >
> > Here should be:
> >
> >   const struct pmu_metrics_table *table =3D pmu_metrics_table__default(=
);
>
> Or, I think you should not change metricgroup__has_metric_or_groups().
> The change only in metricgroup__parse_groups() can fix my issue.

This is wrong and the patch I tested I believe to be correct. The
table here is CPUID associated table and all the metric code will
bottom out in metricgroup__for_each_metric where the CPUID table is
the table parameter (its a parameter because of testing where we force
the machine/model to "testarch"):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n430
```
int metricgroup__for_each_metric(const struct pmu_metrics_table
*table, pmu_metric_iter_fn fn, void *data)
{
...
const struct pmu_metrics_table *tables[2] =3D {
    table,
    pmu_metrics_table__default(),
};

for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
    int ret;

    if (!tables[i])
        continue;
```
If you make the table here the default table then you will process the
default table twice in metricgroup__for_each_metric which will mean
double metric look ups, etc. So I think the patch is correct and
passed my testing both with and without NO_JEVENTS=3D1.

Thanks,
Ian

> Thanks,
> Leo
