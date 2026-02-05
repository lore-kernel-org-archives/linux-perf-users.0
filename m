Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B42F3C3A
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Feb 2026 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770315760; cv=pass; b=t0nMUcpRhM2q/3Qi2FPIYRIoRRMdp+oDIHFv4DhmCTyNtSvY2dDjay4VgsCbRBrqTSvkTn4QW/dby61DinOikhvmF2Ie16OoHgVpTYufu5XzrMi0Qn4tVtNnaxHZGTo383oUduB1Ec8XXuhH/sG7i2aIkBVg1VZb694Q4+iQv9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770315760; c=relaxed/simple;
	bh=fzjgilcdJW/3rBtVXqoH2FFhfPUH8AVZkWTRylTFiHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSBQaHS1YQ+9XuQEamFiul1JFj6BH4w0QleSCsfQPfQYc6ELb7JrLbDwef1Nfx0nPCCsytn2jLVylnhJ7spPShdH3EjYggWJoiAKM+22qXTx6fT6YYTnHilbnbRb8Fw345lPhs3MRy2xmXF/8H1SngLklZd2uduj1WtbuZytAIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PU9Vw0JT; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PU9Vw0JT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a885af8ee7so5455ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 10:22:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770315759; cv=none;
        d=google.com; s=arc-20240605;
        b=OahmFyWD8e+J9iQRkpDcIZ/izUFBTMtDm5wAZc6BwJO/Q8XXouX+RZwIgkg7I2Dl5d
         nKM5OynjtOOF1b8copdcwIr4lXxbwMFvQqff3R19knFsm5jHa3WGH5iW/loGwS9M+gZv
         /NymNVJkcMeR912dudtWS27JavBjksekivJWkEC5YMAJ4E/zJfUjbMTGIoRgpXednAHd
         04xW+Vl3toLFKPOaXNkkUN3J2JcjC/lDLpm048geREN5XRk5Ec6obbgJPwYRm+XFqeDz
         jxU8R8QVF2SaAoAegaGtUFC0p3dacZR3OJch2+tJaVCwQXVqhGMRSoicXlPAtbDQXbos
         kXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UwX72Q2ZVx+EDB0dMgH3lJHnkq9yXib2z0vmNGbMOZE=;
        fh=7GaxZgItKJT+wEkXTjroiEJahKDIrNcQHTQjPCo28Bo=;
        b=EnlxsDRnyb/p0eq1C3t1yB5IOlbNI5x7gTWmMayWtcgDJBwo/WZ2XRc9L1EC+uyWuS
         G+GtfpQUptrjln8vEzovJcl1AuHlZXL3BZ2kczSzT/rzV+qMsUx20cLhjYBgESxGPQ5n
         /o/kDXwlp0CT0s1r1eR9h0DLsHVKT74UI1M9viudQYHg0fXD18meHzDFU1Ha2sGKqcTZ
         w/6hbuW4uynReW8HXbl86dFNA9d8B1e1IzQ8DgqGt8z+e3WmFA64WgyVj6TE6T6/lnNd
         HluopZ6chMmbCRmXgwAEb77q84s/CFT/291Vynu+6DqpKOMDC6rrtMFUnYNF/ATnKpHq
         xOnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770315759; x=1770920559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwX72Q2ZVx+EDB0dMgH3lJHnkq9yXib2z0vmNGbMOZE=;
        b=PU9Vw0JTjPxd2jWJ/ExYK4mTHEu5o5AkMY1kXDMtQ0zoZRRzkpFgKwUOfLagSDJtNR
         4wpeQiIoSFAZZH9lS/HNP7IwrZCyTXTmbN7LwQWN4OdaWK5Ift0LDFyqRzDq5SWdbJmA
         vlXOgaT7Tvi7d7qmPTCa7F5AAI7+O8xI6/AqzQ21OxyymXMrdCCIMX0qHvp9GEbz5CM3
         hVHGLAhrInIN/oh5rAxBI8j2NoR3biQwoYfoD4sOzjokVxlWLAkUcczDkA0+Ox7NWUy9
         +vX1AKG1xSrZq8rhEj90pXG7l8q1Fv6Z3MNASy6X90TmIx3KSlesu+RMNSrOAPQ7/N5G
         xdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770315759; x=1770920559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UwX72Q2ZVx+EDB0dMgH3lJHnkq9yXib2z0vmNGbMOZE=;
        b=TN+w2HgQN1IEBTfG2Xl3MwUZL4ob/AmmzZG3ye3wjvibOaiqnlRQh9Mmu/vJMH5wPW
         iHIub9p1skoNOLHQijkTs5tizzaymVS+v19ZiGgnRJJjEAh84GV4HaggCxsbe+coIzNE
         F3w8mh2KK9QjdvWnRbkbGjDedtO73J34VUz7UQjLFRmboZ3YeKjPX94ifzjgyEwzA8xf
         XVeJ796kBm6Q+bTAX/E/YOrbBD4obAB4lyFP0+yXpidmip7DaQh22ZmRyXejXdOw9ZU2
         pi1NzJsAG3o9RX3tYnXVRYyCr1G5LU9Tw5tXOc7DkcHfnAeEC/yhCl9xqg25emKH3owW
         cY5A==
X-Forwarded-Encrypted: i=1; AJvYcCWYAAaTF1XDo1T9MLxfTndnlwCfNvO0vYp+4/IZTuJ14pqVLiakJVssmEhhOSIUCBiErgzeqS9P0L5u9F5L5lFj@vger.kernel.org
X-Gm-Message-State: AOJu0YyTvEwTnBuzebe/GeE5N2WIDPrVadOFILZqJxbDXa7o9ZuMucaL
	w49MruEVERu+YqXS72GHViKJAARTr4mKg1w5EEvWeofBxI301z3qdyUMx0NBZTHrOxQfTAYL07F
	2+27TzXPrsC2FR7xaoNYELFnhPBRwrIz56d7uIR1mWWRxj2t02c1B5IyJw9s=
X-Gm-Gg: AZuq6aIeN5smg/Yb+JDYBWC6Yk/v7s+4IbmqnVMpOf//UDR90wCWP4ezWo4BFv1e6mR
	bjb41e6wpZ1QX12mY53xlA41Qpot+MqcAXxWfy3ZuCibAjPbTzk6rFpYX0SUx5cCh40xuQcQanH
	UACV0jcH/6k3LILNx5YprrLvDstw5gvnJ4LAIcCl6nNDi5pqk3c603b26wP5AtzmX+fry/R4n1p
	pu8T3SzmPHYU98xwQ1crxy3pwY75j7bKfOZeyNuK/BQPry+vXiOJDHPJqOgl8MW2nGb8y4FPgD7
	OB5eJrLC96CVXz6l9K1W7TUKlg==
X-Received: by 2002:a17:903:4b48:b0:2a7:9532:1a2b with SMTP id
 d9443c01a7336-2a952377080mr102815ad.20.1770315759054; Thu, 05 Feb 2026
 10:22:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205-perf_stat-v1-1-e433b0c918af@debian.org>
 <CAP-5=fW2iUbaZRX789SaJNGXk1VhGg0igLukb6SAosKiA-f1tA@mail.gmail.com>
 <20260205173918.GB3529712@e132581.arm.com> <20260205175250.GC3529712@e132581.arm.com>
In-Reply-To: <20260205175250.GC3529712@e132581.arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 5 Feb 2026 10:22:27 -0800
X-Gm-Features: AZwV_QikvqaY0szaiJ71VmbFovhz8KOTNdA3CV36hhVVmpBd4_bsLINUUddq8jA
Message-ID: <CAP-5=fUY8dYzwKu-g3-HER4ji9ZeGmPQo9DeORW0w9ocW1qnMw@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Fix crash on arm64
To: Leo Yan <leo.yan@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Denis Yaroshevskiy <dyaroshev@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 9:52=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> On Thu, Feb 05, 2026 at 05:39:18PM +0000, Leo Yan wrote:
>
> > > > The sorting function introduced by commit a745c0831c15c ("perf stat=
:
> > > > Sort default events/metrics") compares events based on their indivi=
dual
> > > > properties. This can cause events from different groups to be
> > > > interleaved, resulting in group members appearing before their lead=
ers
> > > > in the sorted evlist.
> > >
> > > Hi, sorry for the issue. I can see what you're saying but why is this
> > > an arm64 issue? The legacy Default metrics are common to all
> > > architectures:
> > > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/pmu-events/arch/common/common/metrics.json?h=3Dperf=
-tools-next
> >
> > Since you are mentioning common metrics, I found the common metrics doe=
s
> > not work on Arm64 platform (I built with NO_JEVENTS=3D1 or enabled jevn=
ts
> > but both don't work).
> >
> > The latest perf will have no any output if the CPU type is missed in
> > json and rallback to common metrics. The failure path is:
> >
> >   add_default_events()
> >     metricgroup__parse_groups()
> >       pmu_metrics_table__find()  =3D> return NULL
> >

The return is correct but the early return is wrong, the metric code
was updated to always consider the default table and skip a NULL
table:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/metricgroup.c?h=3Dperf-tools-next#n430
I'll send a patch for the early return.

> > In my case, pmu_metrics_table__find() always return NULL, as a result,
> > `perf stat sleep 1` directly bail out without any output.
> >
> > I expect Breno's env might have the corresponding CPU json files, this
> > is possible different from my test machine.
>
> On my local env, I need a fix:
>
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-ev=
ents/empty-pmu-events.c
> index e4d00f6b2b5d..f74acc206856 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -3237,14 +3237,6 @@ const struct pmu_events_table *perf_pmu__default_c=
ore_events_table(void)
>          return NULL;
>  }
>
> -const struct pmu_metrics_table *pmu_metrics_table__find(void)
> -{
> -        struct perf_cpu cpu =3D {-1};
> -        const struct pmu_events_map *map =3D map_for_cpu(cpu);
> -
> -        return map ? &map->metric_table : NULL;
> -}
> -
>  const struct pmu_metrics_table *pmu_metrics_table__default(void)
>  {
>          int i =3D 0;
> @@ -3261,6 +3253,17 @@ const struct pmu_metrics_table *pmu_metrics_table_=
_default(void)
>          return NULL;
>  }
>
> +const struct pmu_metrics_table *pmu_metrics_table__find(void)
> +{
> +        struct perf_cpu cpu =3D {-1};
> +        const struct pmu_events_map *map =3D map_for_cpu(cpu);
> +
> +       if (map)
> +               return &map->metric_table;
> +
> +       return pmu_metrics_table__default();
> +}
> +
>
> I have no deep understanding for jevents, seems to me, Breno's issue is
> a different one from me.  Please kindly confirm.

I think it is a different issue, they have metrics while you don't.
Your report does highlight we're missing a NO_JEVENTS=3D1 build-test,
but the build is working for me. I'll send out two patches for these
issues.

Thanks,
Ian

> Thanks,
> Leo
