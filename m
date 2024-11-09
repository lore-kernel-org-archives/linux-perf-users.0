Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1C6154449
	for <linux-perf-users@vger.kernel.org>; Sat,  9 Nov 2024 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731168636; cv=none; b=s/URSK3ms8+Qp6TIHQXEy707YBof0W2pM5e7H1PrRMC+v9+8sIDlWSk8yzYmO8Cs+1WKcKTT/+Ke5+1YnElFHqUSXEE6UQDuECaWIRhgJEHAnP1yRPb3SUZStlwrCEZs5HlI09MX7mAjQoILazRpayxWsprwakZ6qOsiAhXF+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731168636; c=relaxed/simple;
	bh=EjpQSjM560G/O6t1Tb6dej/LCNAFtY2t/dQQ35CPKZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNmoCoA8JziCkZxju9f1tcmUWshYXZyELVb/tpCaYFvT41qcsuw6wq+6UXDHTcBX96jYT3S1z6iViM/cTQwA3zHaxywSUgDmbRxbT/Yr46L8efjrC5gt58k34S2G7NFzMsvvjmRFxVruQCqHaJJ3U9+zqOlMG7lzYeCHpSwf7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fvNyVRCh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fvNyVRCh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c87b0332cso136655ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 09 Nov 2024 08:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731168634; x=1731773434; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUsRfOqzk+CxIITEqQ7Cd8HpiWsMwYdkJCFhMtBclG0=;
        b=fvNyVRChFX/M9696a3tqrXIlC0LRDcBzP2cdLX+Q7ETjxVKAxls9gGVcv/Gk4aRVDu
         HyyNIa3EfYpoi4r7uiMbLuVMm6mINBjXAM7cBBJPAEKgD2Ry92HZFM8Kjbgka9MZG2QE
         QZPutZXvy9yX4PbzV8UkhRsqBef0hTNtTtje4p4ghl9nC/EblfTBdDyMrVqy8k7+p+/o
         l6SKD1ouqhYpSUaHOlymqywd0KwU5p0fEC1x/mxcsUPaZngzh3XlpaMxGH002TlAPFte
         VAcwLI34TGYJmpvzL9Scj0G3nCqhZv+5Ukyd50d4x5b9c8QRSjUXzkiT59CgYvYAYWBj
         TqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731168634; x=1731773434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUsRfOqzk+CxIITEqQ7Cd8HpiWsMwYdkJCFhMtBclG0=;
        b=hF6qnSweq/Eb0O5zzNTojOX277cKX8QCn9Pz7zEn1oTHX1aWalrCVEJ9KxKFvc8+2g
         G4b8lC5dkXbpXFfsTgt/tCpsLFNX47a9ZI9CKbsCKkyN2lKMY4PCC248Wd9PPv4BZa82
         h4YBFH+kf9TKdVieOA7mh3YjuWFqsHiI6HT5yS8XgcxdZ89Rqk+rp3Oo6uM7biO2c9Lr
         5/fhajzEQh1TXbX9K6tkxbgnVaHZl2CDsHx6iik7cm9b3V3mpP3rSSYJGFkqMVh7on95
         ijioWl6liwfuI1ezsAKYz7evDAB/FDRR0Vx1/3rUbbXhpycU/x4VXp95+ALYzG8b301Z
         iApQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0khySUJ4jfBmEsmeuYoitydgdQhgBWoY2ao0cOr0jyzJngpZAxWXlQPQeJQA8ufywkjp1YgV+XRaMAfJr/G2j@vger.kernel.org
X-Gm-Message-State: AOJu0YyZe5soXKv+6mcB3wxkrjKJdL3Kv4xJPXtzIQYMVJDe3ClUe1wF
	gnwWTctvuLU0VRQnW2Gp/wxwmgz9qCTUEbxUJ7G41fAA6254uqmMqLa4dgf3a59AuUkdUNxpIlT
	361cpTDvdJF6eJFb1BQ2XVfPF96fA9Xf2CG3h
X-Gm-Gg: ASbGncvqo3nyhVxoeiM00zXF7ELijLZzzzzgDz+Y+mL7+4Vknvpq24z/E/usvpZlIER
	R3gQpXhodzGC5IFR3XeMgRK1LuSyegMjI
X-Google-Smtp-Source: AGHT+IEFahqbyg4ShZb8bLJQRctx82oVDw24lkFpnx3mxhwv7OQOUeemMadNRPSFS+4YbURaLpoe1k0Z9UZo+0sxOk8=
X-Received: by 2002:a17:902:d4cb:b0:20b:a6f5:2770 with SMTP id
 d9443c01a7336-2118dea0992mr2205275ad.6.1731168634033; Sat, 09 Nov 2024
 08:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107162035.52206-1-irogers@google.com> <20241107162035.52206-9-irogers@google.com>
 <5a57de7c-924e-ccd6-8981-b9fddc647465@huawei.com>
In-Reply-To: <5a57de7c-924e-ccd6-8981-b9fddc647465@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 9 Nov 2024 08:10:22 -0800
Message-ID: <CAP-5=fWw04Qi+3=y7M4uMrhgrFWpnF7mZ09yb4v0P0qFT1Gfnw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] perf pmu: Move pmu_metrics_table__find and remove
 ARM override
To: Yicong Yang <yangyicong@huawei.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Huacai Chen <chenhuacai@kernel.org>, 
	Bibo Mao <maobibo@loongson.cn>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Ben Zong-You Xie <ben717@andestech.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Sandipan Das <sandipan.das@amd.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, =?UTF-8?Q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Dima Kogan <dima@secretsauce.net>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Junhao He <hejunhao3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 9, 2024 at 2:54=E2=80=AFAM Yicong Yang <yangyicong@huawei.com> =
wrote:
>
> Hi,
>
> On 2024/11/8 0:20, Ian Rogers wrote:
> > Move pmu_metrics_table__find to the jevents.py generated pmu-events.c
> > and remove indirection override for ARM. The movement removes
> > perf_pmu__find_metrics_table that exists to enable the ARM
> > override. The ARM override isn't necessary as just the CPUID, not PMU,
> > is used in the metric table lookup. On non-ARM the CPU argument is
> > just ignored for the CPUID, for ARM -1 is passed so that the CPUID for
> > the first logical CPU is read.
>
> Since the logic here's already been touching, is it possible to step it f=
urther to just
> ignore the CPUID matching when finding the system metrics/events tables? =
It's may not be
> that reasonable for finding a system metrics/events from the CPUID, since=
 one system PMU may
> exists on different platforms with different CPU types.

The issue is for conciseness reasons we let metrics and metric
thresholds refer to other metrics, for example:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json#n78
```
    {
        "BriefDescription": "This category represents fraction of
slots where no uops are being delivered due to a lack of required
resources for accepting new uops in the Backend",
        "MetricExpr": "topdown\\-be\\-bound / (topdown\\-fe\\-bound +
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 5
* cpu@INT_MISC.RECOVERY_CYCLES\\,cmask\\=3D1\\,edge@ / tma_info_slots",
        "MetricGroup": "TmaL1;TopdownL1;tma_L1_group",
        "MetricName": "tma_backend_bound",
        "MetricThreshold": "tma_backend_bound > 0.2",
        "MetricgroupNoGroup": "TopdownL1",
        "PublicDescription": "This category represents fraction of
slots where no uops are being delivered due to a lack of required
resources for accepting new uops in the Backend. Backend is the
portion of the processor core where the out-of-order scheduler
dispatches ready uops into their respective execution units; and once
completed these uops get retired according to program order. For
example; stalls due to data-cache misses or stalls due to the divider
unit being overloaded are both categorized under Backend Bound.
Backend Bound is further divided into two main categories: Memory
Bound and Core Bound. Sample with: TOPDOWN.BACKEND_BOUND_SLOTS",
        "ScaleUnit": "100%"
    },
```

The system metrics were added on top of this and we never rethought
the design. For a metric to refer to another metric there needs to be
some kind of place we look up from and for that we use the CPUID
associated table. Perhaps the easiest thing is that if no CPUID table
is matched we have an empty table.

> FYI, there's a similiar problem when trying to count the system metrics b=
ut fails [1].
> I've tested with this series but the problem still exists.

Not sure what you are asking me for here.

Thanks,
Ian

> [1] https://lore.kernel.org/linux-perf-users/20241010074430.16685-1-hejun=
hao3@huawei.com/
>
> Thanks.
>
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/arch/arm64/util/pmu.c         | 20 --------------------
> >  tools/perf/pmu-events/empty-pmu-events.c | 10 ++++------
> >  tools/perf/pmu-events/jevents.py         | 10 ++++------
> >  tools/perf/pmu-events/pmu-events.h       |  2 +-
> >  tools/perf/util/pmu.c                    |  5 -----
> >  tools/perf/util/pmu.h                    |  1 -
> >  6 files changed, 9 insertions(+), 39 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/u=
til/pmu.c
> > index a0964b191fcb..895fb0d0610c 100644
> > --- a/tools/perf/arch/arm64/util/pmu.c
> > +++ b/tools/perf/arch/arm64/util/pmu.c
> > @@ -1,29 +1,9 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >
> > -#include <internal/cpumap.h>
> > -#include "../../../util/cpumap.h"
> > -#include "../../../util/header.h"
> >  #include "../../../util/pmu.h"
> >  #include "../../../util/pmus.h"
> >  #include "../../../util/tool_pmu.h"
> >  #include <api/fs/fs.h>
> > -#include <math.h>
> > -
> > -const struct pmu_metrics_table *pmu_metrics_table__find(void)
> > -{
> > -     struct perf_pmu *pmu;
> > -
> > -     /* Metrics aren't currently supported on heterogeneous Arm system=
s */
> > -     if (perf_pmus__num_core_pmus() > 1)
> > -             return NULL;
> > -
> > -     /* Doesn't matter which one here because they'll all be the same =
*/
> > -     pmu =3D perf_pmus__find_core_pmu();
> > -     if (pmu)
> > -             return perf_pmu__find_metrics_table(pmu);
> > -
> > -     return NULL;
> > -}
> >
> >  u64 tool_pmu__cpu_slots_per_cycle(void)
> >  {
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-=
events/empty-pmu-events.c
> > index 17306e316a3c..1c7a2cfa321f 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -587,14 +587,12 @@ const struct pmu_events_table *perf_pmu__find_eve=
nts_table(struct perf_pmu *pmu)
> >          return NULL;
> >  }
> >
> > -const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct pe=
rf_pmu *pmu)
> > +const struct pmu_metrics_table *pmu_metrics_table__find(void)
> >  {
> > -        const struct pmu_events_map *map =3D map_for_pmu(pmu);
> > -
> > -        if (!map)
> > -                return NULL;
> > +        struct perf_cpu cpu =3D {-1};
> > +        const struct pmu_events_map *map =3D map_for_cpu(cpu);
> >
> > -     return &map->metric_table;
> > +        return map ? &map->metric_table : NULL;
> >  }
> >
> >  const struct pmu_events_table *find_core_events_table(const char *arch=
, const char *cpuid)
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index e44b72e56ac3..d781a377757a 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -1103,14 +1103,12 @@ const struct pmu_events_table *perf_pmu__find_e=
vents_table(struct perf_pmu *pmu)
> >          return NULL;
> >  }
> >
> > -const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct pe=
rf_pmu *pmu)
> > +const struct pmu_metrics_table *pmu_metrics_table__find(void)
> >  {
> > -        const struct pmu_events_map *map =3D map_for_pmu(pmu);
> > -
> > -        if (!map)
> > -                return NULL;
> > +        struct perf_cpu cpu =3D {-1};
> > +        const struct pmu_events_map *map =3D map_for_cpu(cpu);
> >
> > -     return &map->metric_table;
> > +        return map ? &map->metric_table : NULL;
> >  }
> >
> >  const struct pmu_events_table *find_core_events_table(const char *arch=
, const char *cpuid)
> > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events=
/pmu-events.h
> > index 5435ad92180c..675562e6f770 100644
> > --- a/tools/perf/pmu-events/pmu-events.h
> > +++ b/tools/perf/pmu-events/pmu-events.h
> > @@ -103,7 +103,7 @@ int pmu_metrics_table__for_each_metric(const struct=
 pmu_metrics_table *table, pm
> >                                    void *data);
> >
> >  const struct pmu_events_table *perf_pmu__find_events_table(struct perf=
_pmu *pmu);
> > -const struct pmu_metrics_table *perf_pmu__find_metrics_table(struct pe=
rf_pmu *pmu);
> > +const struct pmu_metrics_table *pmu_metrics_table__find(void);
> >  const struct pmu_events_table *find_core_events_table(const char *arch=
, const char *cpuid);
> >  const struct pmu_metrics_table *find_core_metrics_table(const char *ar=
ch, const char *cpuid);
> >  int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
> > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > index 514cb865f57b..45838651b361 100644
> > --- a/tools/perf/util/pmu.c
> > +++ b/tools/perf/util/pmu.c
> > @@ -818,11 +818,6 @@ static int is_sysfs_pmu_core(const char *name)
> >       return file_available(path);
> >  }
> >
> > -__weak const struct pmu_metrics_table *pmu_metrics_table__find(void)
> > -{
> > -     return perf_pmu__find_metrics_table(NULL);
> > -}
> > -
> >  /**
> >   * Return the length of the PMU name not including the suffix for unco=
re PMUs.
> >   *
> > diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> > index fba3fc608b64..7b3e71194e49 100644
> > --- a/tools/perf/util/pmu.h
> > +++ b/tools/perf/util/pmu.h
> > @@ -260,7 +260,6 @@ void perf_pmu__arch_init(struct perf_pmu *pmu);
> >  void pmu_add_cpu_aliases_table(struct perf_pmu *pmu,
> >                              const struct pmu_events_table *table);
> >
> > -const struct pmu_metrics_table *pmu_metrics_table__find(void);
> >  bool pmu_uncore_identifier_match(const char *compat, const char *id);
> >
> >  int perf_pmu__convert_scale(const char *scale, char **end, double *sva=
l);
> >
