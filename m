Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FF34A774
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762452330; cv=none; b=YExPW8FQMkmipu4OUMSTKQhvHzPXcqnB9RZSEyFeW+i+Ng8Th8oooTcsi/753mI67eMgD7YabD7lqWIk4769o17NceT20KJCCZypU6lyO+6pJoTy4x3WvQEopnxnNkeJ6GjTxlbDEkfGxtHjgN6XEomZMgXA0x+7JOPUTkzjp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762452330; c=relaxed/simple;
	bh=G47cfKBtSfZeevthWSR31ey4bcEFvS7hwzCYBKn7lcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCsWcBssa7Jd4P5lgZJHpHNWgcnkJyjJ193lYoYUZqWI8JkueEfAssJBh9tCXPk1y0Ey5dQGxOQrNnEDiarwmJkqPZA3LUozZaU14omxVOZR1jP0AUPfZS0E6t8L9VMhGzGRoq/ARAJqkmULZhM91cm+lX0j12ZEEgEUIVP2reg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lobfpZOC; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lobfpZOC"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2959197b68eso6455ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 10:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762452328; x=1763057128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxC183go+CfSntXz4o3OVXMqZhSkssDjJAownxyD7QI=;
        b=lobfpZOC73i18KElFeGlZ4j4eSfgJy+qQY4Wows9VAjLIhaMxzIIxjXzogqhLQKs33
         QYYZxtsLORP+GnQaC79fogb3RPqxXABMtUd7UEJh6GnA+OKdTK/jsZYJkGs8nvxThs7Z
         Vxw461d8gEcAjx2+QLKvicdNykU0OZlBOAbHY+57pE1ZOObLXPdCEz5EALXAaGbds8ud
         LfK83FA5HGsqV11fPwD7TvBOOJ4N4GO/dw3m29JIShxRawQGSBjbc/1PUyolsRsiF56H
         pT+s8HOK9xABZ2udiYPKBHNnzB5wfG1VNHzE2Qmy79UIO4y1ick/eijldbO20AKQ3YLN
         AI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762452328; x=1763057128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rxC183go+CfSntXz4o3OVXMqZhSkssDjJAownxyD7QI=;
        b=j3tzd8jAHPTSsiaDRThJgFbEomsPA4pwNDpXYDr2/3VNzuGo1rGct83z68bGA8Ztfw
         lZElCRk3p+4HObn5qKkmCUNpT/cRqNfAcKRJmtuRKKjPGNibfKShQBQVKc00WhBnpBo6
         9lsPO2SjrvOawASNgsn+EpbSJ+ukKkXE0y1D3cRsWjZmRrRHqv7itTiH6Q2PBa0L2Cmd
         56oGn61SFO9EHsXzesiSfYAIhl0vI67LBbAxkaiIVM5yUoYV7KkKoRff2QaAea6tZmXu
         Tq8hd0OVcV8w2lcKzKaYO7VixPAJb0Dzk3Dfxn67cF905AnNnLpYok95hLzCDIVpgmfR
         IRDg==
X-Forwarded-Encrypted: i=1; AJvYcCWp6MQITDkTKQHpgLRG/goxZ10qGoEQqyJl4cmkoYrVFVCkMLbys9EjhJCjhsZWcljiUblWka9UNI8OoEJ/3/+l@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnJWcMasE+iigLq+9PGlhQkA7YdTQIXV+XP56TSj6ChQHP31o
	yMsMPY8WiH1WRpm0WYKDQpwrZEX1p8iXMXk6LhaXwmwVEvw1LGGHLxTEg1wkS270Z7xdjy8biK8
	KTpehOnGQEwbtrD/fRBcdS1hgd+u4MTJlqyNfYF3P
X-Gm-Gg: ASbGncutAgxDdshw0SOcIQXVG0ZcAz5K280w0/Xhd2K3yai46ha24jNjAPknl2XsmYT
	Oep9CLp1pdk3I25IbllaSXK/uLc5ZSTx2qwZSKA1OmmtVuRxnbsXIu2At/+EsplKz3YliGCSmpZ
	IDrHlOh0uI7u60hY3M7xrXV3CpXH6EGr7IxfbMzv9nHmqOVUqFz5CWOPh59JdSNB/SBhMCBvwKM
	2yFi1JUVLOGMzMSrXnTSLWkAserojZwr1HzGx5w/kcccFDujPihPqUvUe6Dj8pIPk8Hii93Wt38
	/kSiCQFHz0+9/Ks=
X-Google-Smtp-Source: AGHT+IEt3zVmqnMpB8NLx+TNlgsH2bLYgu655fL8Gu0bJ3DdI4KuqTrAFcNRX1jdNBZgaD3q4DilbxV89vWJ3zwGJ74=
X-Received: by 2002:a17:902:c405:b0:291:6488:5af5 with SMTP id
 d9443c01a7336-297c12ff719mr393215ad.1.1762452327318; Thu, 06 Nov 2025
 10:05:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com> <20251024175857.808401-9-irogers@google.com>
 <aQw-qsVuWf8IHUrL@google.com>
In-Reply-To: <aQw-qsVuWf8IHUrL@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 6 Nov 2025 10:05:15 -0800
X-Gm-Features: AWmQ_bmnHR5yZCN2N41QWYjWH64lVy0nNbdqLSAzzwWVEDb2cNmFAqTtrjMe-P0
Message-ID: <CAP-5=fWx6H9g1c63wmXHRsBfEYYQNQ3p1uBviAzMtchuGB7oog@mail.gmail.com>
Subject: Re: [PATCH v1 08/22] perf jevents: Add set of common metrics based on
 default ones
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 10:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Oct 24, 2025 at 10:58:43AM -0700, Ian Rogers wrote:
> > Add support to getting a common set of metrics from a default
> > table. It simplifies the generation to add json metrics at the same
> > time. The metrics added are CPUs_utilized, cs_per_second,
> > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > stalled_cycles_per_instruction, frontend_cycles_idle,
> > backend_cycles_idle, cycles_frequency, branch_frequency and
> > branch_miss_rate based on the shadow metric definitions.
> >
> > Following this change the default perf stat output on an alderlake look=
s like:
> > ```
> > $ perf stat -a -- sleep 1
> >
> >  Performance counter stats for 'system wide':
> >
> >     28,165,735,434      cpu-clock                        #   27.973 CPU=
s utilized
> >             23,220      context-switches                 #  824.406 /se=
c
> >                833      cpu-migrations                   #   29.575 /se=
c
> >             35,293      page-faults                      #    1.253 K/s=
ec
> >        997,341,554      cpu_atom/instructions/           #    0.84  ins=
n per cycle              (35.63%)
> >     11,197,053,736      cpu_core/instructions/           #    1.97  ins=
n per cycle              (58.21%)
> >      1,184,871,493      cpu_atom/cycles/                 #    0.042 GHz=
                         (35.64%)
> >      5,676,692,769      cpu_core/cycles/                 #    0.202 GHz=
                         (58.22%)
> >        150,525,309      cpu_atom/branches/               #    5.344 M/s=
ec                       (42.80%)
> >      2,277,232,030      cpu_core/branches/               #   80.851 M/s=
ec                       (58.21%)
> >          5,248,575      cpu_atom/branch-misses/          #    3.49% of =
all branches             (42.82%)
> >         28,829,930      cpu_core/branch-misses/          #    1.27% of =
all branches             (58.22%)
> >                        (software)                 #    824.4 cs/sec  cs=
_per_second
> >              TopdownL1 (cpu_core)                 #     12.6 %  tma_bad=
_speculation
> >                                                   #     28.8 %  tma_fro=
ntend_bound       (66.57%)
> >              TopdownL1 (cpu_core)                 #     25.8 %  tma_bac=
kend_bound
> >                                                   #     32.8 %  tma_ret=
iring             (66.57%)
> >                        (software)                 #   1253.1 faults/sec=
  page_faults_per_second
> >                                                   #      0.0 GHz  cycle=
s_frequency       (42.80%)
> >                                                   #      0.2 GHz  cycle=
s_frequency       (74.92%)
> >              TopdownL1 (cpu_atom)                 #     22.3 %  tma_bad=
_speculation
> >                                                   #     17.2 %  tma_ret=
iring             (49.95%)
> >              TopdownL1 (cpu_atom)                 #     30.6 %  tma_bac=
kend_bound
> >                                                   #     29.8 %  tma_fro=
ntend_bound       (49.94%)
> >                        (cpu_atom)                 #      6.9 K/sec  bra=
nch_frequency     (42.89%)
> >                                                   #     80.5 K/sec  bra=
nch_frequency     (74.93%)
> >                                                   #     29.6 migrations=
/sec  migrations_per_second
> >                                                   #     28.0 CPUs  CPUs=
_utilized
> >                        (cpu_atom)                 #      0.8 instructio=
ns  insn_per_cycle  (42.91%)
> >                                                   #      2.0 instructio=
ns  insn_per_cycle  (75.14%)
> >                        (cpu_atom)                 #      3.8 %  branch_=
miss_rate         (35.75%)
> >                                                   #      1.2 %  branch_=
miss_rate         (66.86%)
> >
> >        1.007063529 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/common/common/metrics.json           |  86 +++++++++++++
> >  tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++-----
> >  tools/perf/pmu-events/jevents.py              |  21 +++-
> >  tools/perf/pmu-events/pmu-events.h            |   1 +
> >  tools/perf/util/metricgroup.c                 |  31 +++--
> >  5 files changed, 212 insertions(+), 42 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.js=
on
> >
> > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/to=
ols/perf/pmu-events/arch/common/common/metrics.json
> > new file mode 100644
> > index 000000000000..d1e37db18dc6
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > @@ -0,0 +1,86 @@
> > +[
> > +    {
> > +        "BriefDescription": "Average CPU utilization",
> > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ i=
f #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (durat=
ion_time * 1e9)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "CPUs_utilized",
> > +        "ScaleUnit": "1CPUs",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Context switches per CPU second",
> > +        "MetricExpr": "(software@context\\-switches\\,name\\=3Dcontext=
\\-switches@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #tar=
get_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "cs_per_second",
> > +        "ScaleUnit": "1cs/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Process migrations to a new CPU per CPU s=
econd",
> > +        "MetricExpr": "(software@cpu\\-migrations\\,name\\=3Dcpu\\-mig=
rations@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_=
cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "migrations_per_second",
> > +        "ScaleUnit": "1migrations/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Page faults per CPU second",
> > +        "MetricExpr": "(software@page\\-faults\\,name\\=3Dpage\\-fault=
s@ * 1e9) / (software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu el=
se software@task\\-clock\\,name\\=3Dtask\\-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "page_faults_per_second",
> > +        "ScaleUnit": "1faults/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Instructions Per Cycle",
> > +        "MetricExpr": "instructions / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "insn_per_cycle",
> > +        "MetricThreshold": "insn_per_cycle < 1",
> > +        "ScaleUnit": "1instructions"
> > +    },
> > +    {
> > +        "BriefDescription": "Max front or backend stalls per instructi=
on",
> > +        "MetricExpr": "max(stalled\\-cycles\\-frontend, stalled\\-cycl=
es\\-backend) / instructions",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "stalled_cycles_per_instruction"
> > +    },
> > +    {
> > +        "BriefDescription": "Frontend stalls per cycle",
> > +        "MetricExpr": "stalled\\-cycles\\-frontend / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "frontend_cycles_idle",
> > +        "MetricThreshold": "frontend_cycles_idle > 0.1"
> > +    },
> > +    {
> > +        "BriefDescription": "Backend stalls per cycle",
> > +        "MetricExpr": "stalled\\-cycles\\-backend / cpu\\-cycles",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "backend_cycles_idle",
> > +        "MetricThreshold": "backend_cycles_idle > 0.2"
> > +    },
> > +    {
> > +        "BriefDescription": "Cycles per CPU second",
> > +        "MetricExpr": "cpu\\-cycles / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "cycles_frequency",
> > +        "ScaleUnit": "1GHz",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Branches per CPU second",
> > +        "MetricExpr": "branches / (software@cpu\\-clock\\,name\\=3Dcpu=
\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock=
@)",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "branch_frequency",
> > +        "ScaleUnit": "1000K/sec",
>
> Wouldn't it be "1000M/sec" ?

Agreed. Will fix in v2. The existing logic does multiple by 1e9 in one
place and then divide by 1e3 in another. It would be good if we could
do better units, based on metric value, but I'll leave that for
another day.

> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Branch miss rate",
> > +        "MetricExpr": "branch\\-misses / branches",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "branch_miss_rate",
> > +        "MetricThreshold": "branch_miss_rate > 0.05",
>
> Is MetricThreshold evaluated before scaling?

Yep. Primarily to help share most of the events/calculation with the
metric being created. Fwiw, the 5% here comes from the existing
stat-shadow metric threshold.

Thanks,
Ian

> Thanks,
> Namhyung
>
>
> > +        "ScaleUnit": "100%"
> > +    }
> > +]
