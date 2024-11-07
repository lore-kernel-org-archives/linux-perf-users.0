Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39F195FEF
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Nov 2024 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730964035; cv=none; b=mSqojkiJa5yVPh61a4PCJIydO3zHVXG7iRW1ttnqQWJ99EPJ8k5lAc7HkQ/x3w36RWVZcHnPdB9MxTmsaMDcxbcNvmaCzV8p0S2uZecqHXyfsbZj/ryZRPi6WAdSjmawW/grgkB/sbSQEnM+39eXoOnQAxeBDvOu7djaqy2GAoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730964035; c=relaxed/simple;
	bh=wbe1PF0BN4FVlIpqOXW7w8fgR9sZ4Tte6sd0ZdzquXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBgH1m6ilZdB1NJou7AojBLM1jnh+jKTbTJRHkKomSQ/fUE98L8VgBY3Wa1MPQrWrYo0s7DivBKqCbVG7SUzapDAByFjfzxvO2DpnBcV4w+EovPTP9DKjYzX6ysN9OHsxpiGjviztqRN7kOMKC8KRzJRb/JmvvuxNYMibnzo+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fa1rarFX; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fa1rarFX"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so117065ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 06 Nov 2024 23:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730964033; x=1731568833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pp6KCmqs67mMr8WmGpbgbBC1WRXaVqkvwQ/Hvpxr73Q=;
        b=Fa1rarFX9oDqtXxVkMMsgVOn/AdI+OL9p0RUyzdkRg9Yd3fkR22/zYFtLaZlLJaRpK
         oOzzTWYvPQpCcDcCIhbPhx848zsAI3VDTB8uvNtxjSEfpXTm+N5g3whAaSPatayB5V/6
         gw2jiT5HS42LoHTzr0X2ZAuNMvgAQO6KVNSBTKiLWqmE4xNliEcpBaP1YnSTmapvcsuB
         p7b+yd9hnhz615LdL2laNggFqstsB9/UxrsKSLe1WTcEC9LEoVLmD6sUOKW/Rt725a1p
         62AhlMAix21T26F80I3o7GR9LUKo57jT6Yg57b9qU8aRohOf4Yaiv7vTl0gSfjeODue8
         cTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730964033; x=1731568833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pp6KCmqs67mMr8WmGpbgbBC1WRXaVqkvwQ/Hvpxr73Q=;
        b=Jkn6Ic4e6wzRI5gx7LT8fE9u66DJoFHqamaYXf8m1UyRZ3HYojTqFVOBDi/iTz56jt
         4o8GkBfR+0ZIL9+o9XJ+RIrpVZwnWxgx3WdpQ3avsTt5UK0OF8sj4mvIhdeBarLieXi6
         WE6aB8uTMw/CbMVdSIHu0oUA3Cp0MoWZ6zMC+pSy6weiCEdwdRODjtSzdVVMMuCpztuM
         KGjP1BvagOWM1cVeB//yL6ZvL8+e/4DU6AW5IkBXAVR4MIMiXZgxW5wGlHpjX+rdh0Wu
         7JeQ9Uki3ARjOgCladjEMIfbWF9IEXOL2gkaeaV3CpGhq54z+YG4SSlLg8lpjete/cOU
         k6/w==
X-Forwarded-Encrypted: i=1; AJvYcCWs0eIJ9h4jPbvRiIYn11jTjQtzpyZ2Tgn/4cM3N31+aTeQZyXzNH5UKoR3hbsGJeRBDICmkSKf7a3KQDukhwwq@vger.kernel.org
X-Gm-Message-State: AOJu0YzUCwcGBbOqsw/8WJ6cUXpY/kvz8yN2xr3LailGPyPpxstvyl6k
	EGjfboNSJjGK9oLWmexIZgfiSNk/AzCUfhRs2qfznHgr4nC3nbr1FoUdUIfcDJFvwOPaSrLMxPC
	4mmwLdRb2ANQQNyQFHBxjVA2j8PRSnKX+BwSP
X-Gm-Gg: ASbGncuqELsw4aEIOE6iKqsRdaRxkIIhHeFasrDSLwkcHl5RETCHCqQSbZU6xjAJaUp
	PluyH9QWFEQUhAS2gp4ylBZw/PW+55BlK
X-Google-Smtp-Source: AGHT+IEmnbwUn7FqMxub9oZeXmh8ZASmGcqQ4lXcaSpyo+2BFdeums39PMJ3VYjEqNSEV/VfORdrP+vT1QGSXpK8GTc=
X-Received: by 2002:a05:6e02:1582:b0:3a6:b318:3b99 with SMTP id
 e9e14a558f8ab-3a6e7a6df90mr3457845ab.27.1730964032587; Wed, 06 Nov 2024
 23:20:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106085441.3945502-1-xu.yang_2@nxp.com> <CAP-5=fVN93EJN9FqMmF6h2meiLbU_OWJ2=Vt0EVdZds6nZSKpA@mail.gmail.com>
 <20241107033853.bd57dmjszw2tqhvk@hippo>
In-Reply-To: <20241107033853.bd57dmjszw2tqhvk@hippo>
From: Ian Rogers <irogers@google.com>
Date: Wed, 6 Nov 2024 23:20:21 -0800
Message-ID: <CAP-5=fU2JvCduuvpSDzesr88GXac7z1Xmw_zt2eES2R7wWui3A@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: fix breakage when do perf stat on system metric
To: Xu Yang <xu.yang_2@nxp.com>
Cc: john.g.garry@oracle.com, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, sandipan.das@amd.com, bgray@linux.ibm.com, 
	linux-perf-users@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 7:41=E2=80=AFPM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> On Wed, Nov 06, 2024 at 10:06:24AM -0800, Ian Rogers wrote:
> > On Wed, Nov 6, 2024 at 12:55=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wro=
te:
> > >
> > > When do perf stat on sys metric, perf tool output nothing now:
> > > $ perf stat -a -M imx95_ddr_read.all -I 1000
> > > $
> > >
> > > This command runs on an arm64 machine and the Soc has one DDR hw pmu
> > > except one armv8_cortex_a55 pmu. Their maps show as follows:
> > >
> > > const struct pmu_events_map pmu_events_map[] =3D {
> > > {
> > >         .arch =3D "arm64",
> > >         .cpuid =3D "0x00000000410fd050",
> > >         .event_table =3D {
> > >                 .pmus =3D pmu_events__arm_cortex_a55,
> > >                 .num_pmus =3D ARRAY_SIZE(pmu_events__arm_cortex_a55)
> > >         },
> > >         .metric_table =3D {
> > >                 .pmus =3D NULL,
> > >                 .num_pmus =3D 0
> > >         }
> > > },
> > >
> > > static const struct pmu_sys_events pmu_sys_event_tables[] =3D {
> > > {
> > >         .event_table =3D {
> > >                 .pmus =3D pmu_events__freescale_imx95_sys,
> > >                 .num_pmus =3D ARRAY_SIZE(pmu_events__freescale_imx95_=
sys)
> > >         },
> > >         .metric_table =3D {
> > >                 .pmus =3D pmu_metrics__freescale_imx95_sys,
> > >                 .num_pmus =3D ARRAY_SIZE(pmu_metrics__freescale_imx95=
_sys)
> > >         },
> > >         .name =3D "pmu_events__freescale_imx95_sys",
> > > },
> > >
> > > Currently, pmu_metrics_table__find() will return NULL when only do pe=
rf
> > > stat on sys metric. Then parse_groups() will never be called to parse
> > > sys metric_name, finally perf tool will exit directly. This should be=
 a
> > > common problem. To fix the issue, this will keep the logic before com=
mit
> > > f20c15d13f01 ("perf pmu-events: Remember the perf_events_map for a PM=
U")
> > > to return a empty metric table rather than a NULL pointer. This shoul=
d
> > > be fine since the removed part just check if the table match provided
> > > metric_name. Without these code, the code in parse_groups() will also
> > > check the validity of metrci_name too.
> >
> > So we carry this code for ARM:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/arch/arm64/util/pmu.c?h=3Dperf-tools-next#n21
> >
> > On x86 and other architectures the PMU is always passed as NULL (the
> > effect of this change):
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.c?h=3Dperf-tools-next#n843
> >
> > The blame shows me as the author, but that's because I factored event
> > and metric tables to be separate things. When I did that I brought
> > over ARM's event table logic to the metric table.
> >
> > Why do we pass a PMU to this code anyway?
> > So on x86 the cpuid will give a different string for
> > heterogeneous/hybrid/BIG.little parts. On ARM you get a different
> > CPUID depending on which logical CPU you ask the question of. The CPUs
> > associated with a PMU are used to look up the CPUID string.
> >
> > This whole thing is spaghetti code (fwiw, I dislike the whole arch
> > directory plus weak symbols thing that is a by design breakage of at
> > least cross platform work - hopefully the maintainers will review [1]
> > so we can delete a sizeable chunk of it) and the ARM situation looks
>
> Yes, the logic seems like a little mess when parsing metrics because some
> system metrics don't bind to any core pmu. But I'm not familiar with the
> whole code, so I unable to make big changes on perf tool.
>
> > sub-optimal. We really need to scan a plurality of metric tables for
> > the heterogeneous parts on ARM. We're passing a PMU rather than just a
> > CPU, I think passing a CPU would be more intention revealing.
> >
> > Then there's the pleasure of system metrics, which are only loosely in
> > my mental model of things as John Garry did the heavy lifting for
> > these.
> >
> > So the problems I see:
> > 1) ARM needs multiple metric tables to be parsed in the metric group
> > logic as the invariant of 1 CPUID 1 table doesn't hold on ARM.
> > 2) The lack of a metric table causes an early exit from the metric pars=
ing code:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n1700
> > However, the system metrics pattern conceptually match PMU names and
> > aren't tied to CPUIDs. The iteration logic still uses the metric table
> > though:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n1283
> > 3) Crufty spaghetti from the use of arch/weak that means we aren't
> > testing the same code paths leading to divergence and rot.
> >
> > I'll try to pull something together. But for the sake of expediently
> > addressing your issue:
> > Acked-by: Ian Rogers <irogers@google.com>
>
> Okay, Thanks for your input!

I sent:
https://lore.kernel.org/linux-perf-users/20241107071600.9082-1-irogers@goog=
le.com/
but didn't get to my point about ignore the no table case and also the
>1 table case on heterogeneous systems. I didn't try to reproduce your
situation, if you could test the patches it would be appreciated.

Thanks,
Ian

> Thanks,
> Xu Yang
>
> >
> > Thanks,
> > Ian
> >
> >
> > [1] https://lore.kernel.org/lkml/20241017002520.59124-1-irogers@google.=
com/
> >
> >
> >
> > > Fixes: f20c15d13f01 ("perf pmu-events: Remember the perf_events_map f=
or a PMU")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > ---
> > >  tools/perf/pmu-events/empty-pmu-events.c | 12 +-----------
> > >  tools/perf/pmu-events/jevents.py         | 12 +-----------
> > >  2 files changed, 2 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pm=
u-events/empty-pmu-events.c
> > > index 2b7516946ded..b8719dab264d 100644
> > > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > > @@ -585,17 +585,7 @@ const struct pmu_metrics_table *perf_pmu__find_m=
etrics_table(struct perf_pmu *pm
> > >          if (!map)
> > >                  return NULL;
> > >
> > > -        if (!pmu)
> > > -                return &map->metric_table;
> > > -
> > > -        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> > > -                const struct pmu_table_entry *table_pmu =3D &map->me=
tric_table.pmus[i];
> > > -                const char *pmu_name =3D &big_c_string[table_pmu->pm=
u_name.offset];
> > > -
> > > -                if (pmu__name_match(pmu, pmu_name))
> > > -                           return &map->metric_table;
> > > -        }
> > > -        return NULL;
> > > +       return &map->metric_table;
> > >  }
> > >
> > >  const struct pmu_events_table *find_core_events_table(const char *ar=
ch, const char *cpuid)
> > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events=
/jevents.py
> > > index 6e71b09dbc2a..70f4fd5395fb 100755
> > > --- a/tools/perf/pmu-events/jevents.py
> > > +++ b/tools/perf/pmu-events/jevents.py
> > > @@ -1101,17 +1101,7 @@ const struct pmu_metrics_table *perf_pmu__find=
_metrics_table(struct perf_pmu *pm
> > >          if (!map)
> > >                  return NULL;
> > >
> > > -        if (!pmu)
> > > -                return &map->metric_table;
> > > -
> > > -        for (size_t i =3D 0; i < map->metric_table.num_pmus; i++) {
> > > -                const struct pmu_table_entry *table_pmu =3D &map->me=
tric_table.pmus[i];
> > > -                const char *pmu_name =3D &big_c_string[table_pmu->pm=
u_name.offset];
> > > -
> > > -                if (pmu__name_match(pmu, pmu_name))
> > > -                           return &map->metric_table;
> > > -        }
> > > -        return NULL;
> > > +       return &map->metric_table;
> > >  }
> > >
> > >  const struct pmu_events_table *find_core_events_table(const char *ar=
ch, const char *cpuid)
> > > --
> > > 2.34.1
> > >
