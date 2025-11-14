Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BDF2C11CC
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139474; cv=none; b=DMPjq6pAk6JJYr9by+yidht4jSU/COxwgMDYU0U7XEe9FBrfGOYUUwJzI6uUnBR1mlyRm9fyd1xi643EjRkfWxg0WT++sp4Uiao++alhDmj83E8qLH8e7plY4sOrWQxawRwE90HTEQr4lkHa68K85hRwoUzhbBqxUoydCHBykHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139474; c=relaxed/simple;
	bh=GQashG3toz2FVcGijfvFBXWJNk3uB0AZ7h2dZ4On+nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSxM+8oFkp1mBKuu2EVKv4pTwO9ynOR6c1rOM1u+emuORaN9Dp2XI1lP2aPwCUyiOJDZFK09pNXUPJtYDsNtBsPir5rvROLbXh9nUbQdPmmSxVERrXHa30ngTNRnvDUK7Qs+e0oQjgWmXnjZXgMjQqa50LzuMFFStco/3oPZxaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ifZZ3JMM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ifZZ3JMM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297e13bf404so224275ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 08:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763139471; x=1763744271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fETBNF3un3Mf35C6aHJqj3AgGCJLpgbUVYLV7DwsEkA=;
        b=ifZZ3JMM0h1KF0lhA0N0jRNOaJBoLvp9ewsIecEccPRcKurUENQL7xg0obXrHR34Br
         /EDP5ZmKafYq4y4jTMMr5Mx0Xj242nf72SvTYXcCX9uqukonedR/uISdIH3i3tDENfLw
         67CSQtYmHG3TqjbDHckaZ3GHV1iQEWNJse+zkRPUZscKXJb4lEq6zE7h2nfDmvmRMXNX
         yOKVNJZQ1I08YL2lVBjH7f2AWk1+vdIDvsF/d0uXPpWP1jl7mPULQ5eaLyDziZU4VIzZ
         jHcZiurwm9Yagr3476fcVgmfflSOYAUhpr7prGfnp7lb9G5xcpfwFOhfs0F4QeAGQjTs
         hICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763139471; x=1763744271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fETBNF3un3Mf35C6aHJqj3AgGCJLpgbUVYLV7DwsEkA=;
        b=gB8L7VsZZ9WMbKiotqNQvsOI+DgCUC7V3bSJCy6LZN/2wicHiooy3o4R7mYpC7rOV4
         xaQIVhZMS9G1nTXBPCvD+/742ZcfCpT85+dBng6XBijgwEhLlIE/81H+VRzzfHQT0rAT
         xWoYIk0KPZPBymMYuxTHdgREDe4TWa+FkUltIiiOwzyzKkgtuPjoagin8B8LGLs6NMCd
         LY4pg+nlnJ6FBGU0QIcsyYvcpIzdJn+QG7CisVBfL/1mADayFGn1xIjP1Sjge+yuEFyl
         kYDBVjQ4Agbye38JCXK6rgQQNSK6bz2prK5961Lxp901ahstYP8Y9quw7PRebaT/4Jrc
         nX1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWH3NW0rXisYEYQGQlBz+IlUxjJ7WAz4oyU3hprUltqIq1ma5tBnLlXuo1J4MHb0sXd7EaXJLCXDF6XqSgORVAT@vger.kernel.org
X-Gm-Message-State: AOJu0YyheuP0TyrJQcSW4D4wT5QiIMvlVrEZ6jYJw4bYgEo2wuGkq2C5
	MM2m0JN+s3A7fFok4xf2/h+6+hOz/Q4gTOpkz9JhVqcU/o47F1+m+XTZDJUokZwu5xPAjVx5mPl
	ykEQZzKcWoGJcky9mgedXLRVG1sirTbsTbvg+t860
X-Gm-Gg: ASbGncvxISCek0eWUsArvGbuf1u0r8efm4+N3AwtLsbLOgNOw9UhtVfNjfZxgQAKdyl
	9x3Ryb5aXHb5t+Q9+cIAo62fgh4RBI4ddNlNKdhpr1TKjEpHsm3kc8Hu4nU+OR9ZHcREIvskVMd
	JqyX0G9SENYzKFeh5ZFKLAKE8kWcVynSBCfL8CuGaHLlsplcebOPefA0Ntx7OaGeJ32TYsT0un8
	tPt9yJvxFeq66FXZJXmaG/nmurj5Gf5qzabduRo6uFu+n5gg7Jfstf4byhJW/IZoWwFwGm78RRl
	P5HRFc4fzEacgPsLPR8=
X-Google-Smtp-Source: AGHT+IHmxxUH+48uCzwPWd7E+lG8MDhLgqmV0Kn+M24Vjbj9oneKmiyYJaNPObMIoZ1c2zEoXW73QhseqORQkeKvJko=
X-Received: by 2002:a05:7022:7a7:b0:11a:4c75:a45b with SMTP id
 a92af1059eb24-11b47b9958cmr160628c88.10.1763139470772; Fri, 14 Nov 2025
 08:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com> <20251111212206.631711-4-irogers@google.com>
 <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org>
In-Reply-To: <ca0f0cd3-7335-48f9-8737-2f70a75b019a@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 08:57:39 -0800
X-Gm-Features: AWmQ_blim7kZMjpN-rTvYWYvA8TJmuTReDw_CQ28eFc_Dd7PK0UM9O20ynja0eQ
Message-ID: <CAP-5=fWNr9oaxWy3PyqbeH-sjsPpSt9g=8vP0drbb_e+ijpWkw@mail.gmail.com>
Subject: Re: [PATCH v4 03/18] perf jevents: Add set of common metrics based on
 default ones
To: James Clark <james.clark@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 8:28=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 11/11/2025 9:21 pm, Ian Rogers wrote:
> > Add support to getting a common set of metrics from a default
> > table. It simplifies the generation to add json metrics at the same
> > time. The metrics added are CPUs_utilized, cs_per_second,
> > migrations_per_second, page_faults_per_second, insn_per_cycle,
> > stalled_cycles_per_instruction, frontend_cycles_idle,
> > backend_cycles_idle, cycles_frequency, branch_frequency and
> > branch_miss_rate based on the shadow metric definitions.
> >
> > Following this change the default perf stat output on an alderlake
> > looks like:
> > ```
> > $ perf stat -a -- sleep 2
> >
> >   Performance counter stats for 'system wide':
> >
> >                0.00 msec cpu-clock                        #    0.000 CP=
Us utilized
> >              77,739      context-switches
> >              15,033      cpu-migrations
> >             321,313      page-faults
> >      14,355,634,225      cpu_atom/instructions/           #    1.40  in=
sn per cycle              (35.37%)
> >     134,561,560,583      cpu_core/instructions/           #    3.44  in=
sn per cycle              (57.85%)
> >      10,263,836,145      cpu_atom/cycles/                              =
                          (35.42%)
> >      39,138,632,894      cpu_core/cycles/                              =
                          (57.60%)
> >       2,989,658,777      cpu_atom/branches/                            =
                          (42.60%)
> >      32,170,570,388      cpu_core/branches/                            =
                          (57.39%)
> >          29,789,870      cpu_atom/branch-misses/          #    1.00% of=
 all branches             (42.69%)
> >         165,991,152      cpu_core/branch-misses/          #    0.52% of=
 all branches             (57.19%)
> >                         (software)                 #      nan cs/sec  c=
s_per_second
> >               TopdownL1 (cpu_core)                 #     11.9 %  tma_ba=
d_speculation
> >                                                    #     19.6 %  tma_fr=
ontend_bound       (63.97%)
> >               TopdownL1 (cpu_core)                 #     18.8 %  tma_ba=
ckend_bound
> >                                                    #     49.7 %  tma_re=
tiring             (63.97%)
> >                         (software)                 #      nan faults/se=
c  page_faults_per_second
> >                                                    #      nan GHz  cycl=
es_frequency       (42.88%)
> >                                                    #      nan GHz  cycl=
es_frequency       (69.88%)
> >               TopdownL1 (cpu_atom)                 #     11.7 %  tma_ba=
d_speculation
> >                                                    #     29.9 %  tma_re=
tiring             (50.07%)
> >               TopdownL1 (cpu_atom)                 #     31.3 %  tma_fr=
ontend_bound       (43.09%)
> >                         (cpu_atom)                 #      nan M/sec  br=
anch_frequency     (43.09%)
> >                                                    #      nan M/sec  br=
anch_frequency     (70.07%)
> >                                                    #      nan migration=
s/sec  migrations_per_second
> >               TopdownL1 (cpu_atom)                 #     27.1 %  tma_ba=
ckend_bound        (43.08%)
> >                         (software)                 #      0.0 CPUs  CPU=
s_utilized
> >                                                    #      1.4 instructi=
ons  insn_per_cycle  (43.04%)
> >                                                    #      3.5 instructi=
ons  insn_per_cycle  (69.99%)
> >                                                    #      1.0 %  branch=
_miss_rate         (35.46%)
> >                                                    #      0.5 %  branch=
_miss_rate         (65.02%)
> >
> >         2.005626564 seconds time elapsed
> > ```
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >   .../arch/common/common/metrics.json           |  86 +++++++++++++
> >   tools/perf/pmu-events/empty-pmu-events.c      | 115 +++++++++++++----=
-
> >   tools/perf/pmu-events/jevents.py              |  21 +++-
> >   tools/perf/pmu-events/pmu-events.h            |   1 +
> >   tools/perf/util/metricgroup.c                 |  31 +++--
> >   5 files changed, 212 insertions(+), 42 deletions(-)
> >   create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.j=
son
> >
> > diff --git a/tools/perf/pmu-events/arch/common/common/metrics.json b/to=
ols/perf/pmu-events/arch/common/common/metrics.json
> > new file mode 100644
> > index 000000000000..d915be51e300
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/common/common/metrics.json
> > @@ -0,0 +1,86 @@
> > +[
> > +    {
> > +        "BriefDescription": "Average CPU utilization",
> > +        "MetricExpr": "(software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ i=
f #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock@) / (durat=
ion_time * 1e9)",
>
> Hi Ian,
>
> I noticed that this metric is making "perf stat tests" fail.
> "duration_time" is a tool event and they don't work with "perf stat
> record" anymore. The test tests the record command with the default args
> which results in this event being used and a failure.
>
> I suppose there are three issues. First two are unrelated to this change:
>
>   - Perf stat record continues to write out a bad perf.data file even
>     though it knows that tool events won't work.
>
>     For example 'status' ends up being -1 in cmd_stat() but it's ignored
>     for some of the writing parts. It does decide to not print any stdout
>     though:
>
>     $ perf stat record -e "duration_time"
>     <blank>
>
>   - The other issue is obviously that tool events don't work with perf
>     stat record which seems to be a regression from 6828d6929b76 ("perf
>     evsel: Refactor tool events")
>
>   - The third issue is that this change adds a broken tool event to the
>     default output of perf stat
>
> I'm not actually sure what "perf stat record" is for? It's possible that
> it's not used anymore, expecially if nobody noticed that tool events
> haven't been working in it for a while.
>
> I think we're also supposed to have json output for perf stat (although
> this is also broken in some obscure scenarios), so maybe perf stat
> record isn't needed anymore?

Hi James,

Thanks for the report. I think this is also an overlap with perf stat
metrics don't work with perf stat record, and because these changes
made that the default. Let me do some follow up work as the perf
script work shows we can do useful things with metrics while not being
on a live perf stat - there's the obstacle that the CPUID of the host
will be used :-/

Anyway, I'll take a look and we should add a test on this. There is
one that the perf stat json output is okay, to some definition. One
problem is that the stat-display code is complete spaghetti. Now that
stat-shadow only handles json metrics, and perf script isn't trying to
maintain a set of shadow counters, that is a little bit improved.

Thanks,
Ian

> Thanks
> James
>
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
> > +        "ScaleUnit": "1000M/sec",
> > +        "MetricConstraint": "NO_GROUP_EVENTS"
> > +    },
> > +    {
> > +        "BriefDescription": "Branch miss rate",
> > +        "MetricExpr": "branch\\-misses / branches",
> > +        "MetricGroup": "Default",
> > +        "MetricName": "branch_miss_rate",
> > +        "MetricThreshold": "branch_miss_rate > 0.05",
> > +        "ScaleUnit": "100%"
> > +    }
> > +]
> > diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-=
events/empty-pmu-events.c
> > index 2fdf4fbf36e2..e4d00f6b2b5d 100644
> > --- a/tools/perf/pmu-events/empty-pmu-events.c
> > +++ b/tools/perf/pmu-events/empty-pmu-events.c
> > @@ -1303,21 +1303,32 @@ static const char *const big_c_string =3D
> >   /* offset=3D127519 */ "sys_ccn_pmu.read_cycles\000uncore\000ccn read-=
cycles event\000config=3D0x2c\0000x01\00000\000\000\000\000\000"
> >   /* offset=3D127596 */ "uncore_sys_cmn_pmu\000"
> >   /* offset=3D127615 */ "sys_cmn_pmu.hnf_cache_miss\000uncore\000Counts=
 total cache misses in first lookup result (high priority)\000eventid=3D1,t=
ype=3D5\000(434|436|43c|43a).*\00000\000\000\000\000\000"
> > -/* offset=3D127758 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\=
00000"
> > -/* offset=3D127780 */ "IPC\000group1\000inst_retired.any / cpu_clk_unh=
alted.thread\000\000\000\000\000\000\000\00000"
> > -/* offset=3D127843 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivere=
d.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thre=
ad_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128009 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / i=
nst_retired.any\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128073 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses =
/ inst_retired.any\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128140 */ "cache_miss_cycles\000group1\000dcache_miss_cpi =
+ icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128211 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_=
rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000=
00"
> > -/* offset=3D128305 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_dema=
nd_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.=
rfo_miss\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128439 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCach=
e_L2_All_Miss\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128503 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hit=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128571 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_M=
iss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > -/* offset=3D128641 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\=
00000"
> > -/* offset=3D128663 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\=
00000"
> > -/* offset=3D128685 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00=
000"
> > -/* offset=3D128705 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement /=
 1e9 / duration_time\000\000\000\000\000\000\000\00000"
> > +/* offset=3D127758 */ "CPUs_utilized\000Default\000(software@cpu\\-clo=
ck\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name=
\\=3Dtask\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\=
000\0001CPUs\000\000\000\00001"
> > +/* offset=3D127943 */ "cs_per_second\000Default\000software@context\\-=
switches\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\0=
00\00001"
> > +/* offset=3D128175 */ "migrations_per_second\000Default\000software@cp=
u\\-migrations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\=
,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=
=3Dtask\\-clock@)\000\000Process migrations to a new CPU per CPU second\000=
\0001migrations/sec\000\000\000\00001"
> > +/* offset=3D128434 */ "page_faults_per_second\000Default\000software@p=
age\\-faults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name=
\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask=
\\-clock@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000=
\00001"
> > +/* offset=3D128664 */ "insn_per_cycle\000Default\000instructions / cpu=
\\-cycles\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructi=
ons\000\000\000\00000"
> > +/* offset=3D128776 */ "stalled_cycles_per_instruction\000Default\000ma=
x(stalled\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\0=
00\000Max front or backend stalls per instruction\000\000\000\000\000\00000=
"
> > +/* offset=3D128939 */ "frontend_cycles_idle\000Default\000stalled\\-cy=
cles\\-frontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend st=
alls per cycle\000\000\000\000\000\00000"
> > +/* offset=3D129068 */ "backend_cycles_idle\000Default\000stalled\\-cyc=
les\\-backend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls=
 per cycle\000\000\000\000\000\00000"
> > +/* offset=3D129193 */ "cycles_frequency\000Default\000cpu\\-cycles / (=
software@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@t=
ask\\-clock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001=
GHz\000\000\000\00001"
> > +/* offset=3D129368 */ "branch_frequency\000Default\000branches / (soft=
ware@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\=
\-clock\\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\000100=
0M/sec\000\000\000\00001"
> > +/* offset=3D129547 */ "branch_miss_rate\000Default\000branch\\-misses =
/ branches\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\0=
00\000\00000"
> > +/* offset=3D129650 */ "CPI\000\0001 / IPC\000\000\000\000\000\000\000\=
00000"
> > +/* offset=3D129672 */ "IPC\000group1\000inst_retired.any / cpu_clk_unh=
alted.thread\000\000\000\000\000\000\000\00000"
> > +/* offset=3D129735 */ "Frontend_Bound_SMT\000\000idq_uops_not_delivere=
d.core / (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thre=
ad_active / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000"
> > +/* offset=3D129901 */ "dcache_miss_cpi\000\000l1d\\-loads\\-misses / i=
nst_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D129965 */ "icache_miss_cycles\000\000l1i\\-loads\\-misses =
/ inst_retired.any\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130032 */ "cache_miss_cycles\000group1\000dcache_miss_cpi =
+ icache_miss_cycles\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130103 */ "DCache_L2_All_Hits\000\000l2_rqsts.demand_data_=
rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\000=
00"
> > +/* offset=3D130197 */ "DCache_L2_All_Miss\000\000max(l2_rqsts.all_dema=
nd_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.=
rfo_miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130331 */ "DCache_L2_All\000\000DCache_L2_All_Hits + DCach=
e_L2_All_Miss\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130395 */ "DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hit=
s, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130463 */ "DCache_L2_Misses\000\000d_ratio(DCache_L2_All_M=
iss, DCache_L2_All)\000\000\000\000\000\000\000\00000"
> > +/* offset=3D130533 */ "M1\000\000ipc + M2\000\000\000\000\000\000\000\=
00000"
> > +/* offset=3D130555 */ "M2\000\000ipc + M1\000\000\000\000\000\000\000\=
00000"
> > +/* offset=3D130577 */ "M3\000\0001 / M3\000\000\000\000\000\000\000\00=
000"
> > +/* offset=3D130597 */ "L1D_Cache_Fill_BW\000\00064 * l1d.replacement /=
 1e9 / duration_time\000\000\000\000\000\000\000\00000"
> >   ;
> >
> >   static const struct compact_pmu_event pmu_events__common_default_core=
[] =3D {
> > @@ -2603,6 +2614,29 @@ static const struct pmu_table_entry pmu_events__=
common[] =3D {
> >   },
> >   };
> >
> > +static const struct compact_pmu_event pmu_metrics__common_default_core=
[] =3D {
> > +{ 127758 }, /* CPUs_utilized\000Default\000(software@cpu\\-clock\\,nam=
e\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtas=
k\\-clock@) / (duration_time * 1e9)\000\000Average CPU utilization\000\0001=
CPUs\000\000\000\00001 */
> > +{ 129068 }, /* backend_cycles_idle\000Default\000stalled\\-cycles\\-ba=
ckend / cpu\\-cycles\000backend_cycles_idle > 0.2\000Backend stalls per cyc=
le\000\000\000\000\000\00000 */
> > +{ 129368 }, /* branch_frequency\000Default\000branches / (software@cpu=
\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\=
\,name\\=3Dtask\\-clock@)\000\000Branches per CPU second\000\0001000M/sec\0=
00\000\000\00001 */
> > +{ 129547 }, /* branch_miss_rate\000Default\000branch\\-misses / branch=
es\000branch_miss_rate > 0.05\000Branch miss rate\000\000100%\000\000\000\0=
0000 */
> > +{ 127943 }, /* cs_per_second\000Default\000software@context\\-switches=
\\,name\\=3Dcontext\\-switches@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcp=
u\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-cloc=
k@)\000\000Context switches per CPU second\000\0001cs/sec\000\000\000\00001=
 */
> > +{ 129193 }, /* cycles_frequency\000Default\000cpu\\-cycles / (software=
@cpu\\-clock\\,name\\=3Dcpu\\-clock@ if #target_cpu else software@task\\-cl=
ock\\,name\\=3Dtask\\-clock@)\000\000Cycles per CPU second\000\0001GHz\000\=
000\000\00001 */
> > +{ 128939 }, /* frontend_cycles_idle\000Default\000stalled\\-cycles\\-f=
rontend / cpu\\-cycles\000frontend_cycles_idle > 0.1\000Frontend stalls per=
 cycle\000\000\000\000\000\00000 */
> > +{ 128664 }, /* insn_per_cycle\000Default\000instructions / cpu\\-cycle=
s\000insn_per_cycle < 1\000Instructions Per Cycle\000\0001instructions\000\=
000\000\00000 */
> > +{ 128175 }, /* migrations_per_second\000Default\000software@cpu\\-migr=
ations\\,name\\=3Dcpu\\-migrations@ * 1e9 / (software@cpu\\-clock\\,name\\=
=3Dcpu\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\=
-clock@)\000\000Process migrations to a new CPU per CPU second\000\0001migr=
ations/sec\000\000\000\00001 */
> > +{ 128434 }, /* page_faults_per_second\000Default\000software@page\\-fa=
ults\\,name\\=3Dpage\\-faults@ * 1e9 / (software@cpu\\-clock\\,name\\=3Dcpu=
\\-clock@ if #target_cpu else software@task\\-clock\\,name\\=3Dtask\\-clock=
@)\000\000Page faults per CPU second\000\0001faults/sec\000\000\000\00001 *=
/
> > +{ 128776 }, /* stalled_cycles_per_instruction\000Default\000max(stalle=
d\\-cycles\\-frontend, stalled\\-cycles\\-backend) / instructions\000\000Ma=
x front or backend stalls per instruction\000\000\000\000\000\00000 */
> > +
> > +};
> > +
> > +static const struct pmu_table_entry pmu_metrics__common[] =3D {
> > +{
> > +     .entries =3D pmu_metrics__common_default_core,
> > +     .num_entries =3D ARRAY_SIZE(pmu_metrics__common_default_core),
> > +     .pmu_name =3D { 0 /* default_core\000 */ },
> > +},
> > +};
> > +
> >   static const struct compact_pmu_event pmu_events__test_soc_cpu_defaul=
t_core[] =3D {
> >   { 126205 }, /* bp_l1_btb_correct\000branch\000L1 BTB Correction\000ev=
ent=3D0x8a\000\00000\000\000\000\000\000 */
> >   { 126267 }, /* bp_l2_btb_correct\000branch\000L2 BTB Correction\000ev=
ent=3D0x8b\000\00000\000\000\000\000\000 */
> > @@ -2664,21 +2698,21 @@ static const struct pmu_table_entry pmu_events_=
_test_soc_cpu[] =3D {
> >   };
> >
> >   static const struct compact_pmu_event pmu_metrics__test_soc_cpu_defau=
lt_core[] =3D {
> > -{ 127758 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> > -{ 128439 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All=
_Miss\000\000\000\000\000\000\000\00000 */
> > -{ 128211 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit +=
 l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > -{ 128305 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_=
rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss=
\000\000\000\000\000\000\000\00000 */
> > -{ 128503 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> > -{ 128571 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000 */
> > -{ 127843 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core /=
 (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_activ=
e / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > -{ 127780 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.th=
read\000\000\000\000\000\000\000\00000 */
> > -{ 128705 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / d=
uration_time\000\000\000\000\000\000\000\00000 */
> > -{ 128641 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> > -{ 128663 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> > -{ 128685 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > -{ 128140 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache=
_miss_cycles\000\000\000\000\000\000\000\00000 */
> > -{ 128009 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_reti=
red.any\000\000\000\000\000\000\000\00000 */
> > -{ 128073 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etired.any\000\000\000\000\000\000\000\00000 */
> > +{ 129650 }, /* CPI\000\0001 / IPC\000\000\000\000\000\000\000\00000 */
> > +{ 130331 }, /* DCache_L2_All\000\000DCache_L2_All_Hits + DCache_L2_All=
_Miss\000\000\000\000\000\000\000\00000 */
> > +{ 130103 }, /* DCache_L2_All_Hits\000\000l2_rqsts.demand_data_rd_hit +=
 l2_rqsts.pf_hit + l2_rqsts.rfo_hit\000\000\000\000\000\000\000\00000 */
> > +{ 130197 }, /* DCache_L2_All_Miss\000\000max(l2_rqsts.all_demand_data_=
rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss=
\000\000\000\000\000\000\000\00000 */
> > +{ 130395 }, /* DCache_L2_Hits\000\000d_ratio(DCache_L2_All_Hits, DCach=
e_L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 130463 }, /* DCache_L2_Misses\000\000d_ratio(DCache_L2_All_Miss, DCa=
che_L2_All)\000\000\000\000\000\000\000\00000 */
> > +{ 129735 }, /* Frontend_Bound_SMT\000\000idq_uops_not_delivered.core /=
 (4 * (cpu_clk_unhalted.thread / 2 * (1 + cpu_clk_unhalted.one_thread_activ=
e / cpu_clk_unhalted.ref_xclk)))\000\000\000\000\000\000\000\00000 */
> > +{ 129672 }, /* IPC\000group1\000inst_retired.any / cpu_clk_unhalted.th=
read\000\000\000\000\000\000\000\00000 */
> > +{ 130597 }, /* L1D_Cache_Fill_BW\000\00064 * l1d.replacement / 1e9 / d=
uration_time\000\000\000\000\000\000\000\00000 */
> > +{ 130533 }, /* M1\000\000ipc + M2\000\000\000\000\000\000\000\00000 */
> > +{ 130555 }, /* M2\000\000ipc + M1\000\000\000\000\000\000\000\00000 */
> > +{ 130577 }, /* M3\000\0001 / M3\000\000\000\000\000\000\000\00000 */
> > +{ 130032 }, /* cache_miss_cycles\000group1\000dcache_miss_cpi + icache=
_miss_cycles\000\000\000\000\000\000\000\00000 */
> > +{ 129901 }, /* dcache_miss_cpi\000\000l1d\\-loads\\-misses / inst_reti=
red.any\000\000\000\000\000\000\000\00000 */
> > +{ 129965 }, /* icache_miss_cycles\000\000l1i\\-loads\\-misses / inst_r=
etired.any\000\000\000\000\000\000\000\00000 */
> >
> >   };
> >
> > @@ -2759,7 +2793,10 @@ static const struct pmu_events_map pmu_events_ma=
p[] =3D {
> >               .pmus =3D pmu_events__common,
> >               .num_pmus =3D ARRAY_SIZE(pmu_events__common),
> >       },
> > -     .metric_table =3D {},
> > +     .metric_table =3D {
> > +             .pmus =3D pmu_metrics__common,
> > +             .num_pmus =3D ARRAY_SIZE(pmu_metrics__common),
> > +     },
> >   },
> >   {
> >       .arch =3D "testarch",
> > @@ -3208,6 +3245,22 @@ const struct pmu_metrics_table *pmu_metrics_tabl=
e__find(void)
> >           return map ? &map->metric_table : NULL;
> >   }
> >
> > +const struct pmu_metrics_table *pmu_metrics_table__default(void)
> > +{
> > +        int i =3D 0;
> > +
> > +        for (;;) {
> > +                const struct pmu_events_map *map =3D &pmu_events_map[i=
++];
> > +
> > +                if (!map->arch)
> > +                        break;
> > +
> > +                if (!strcmp(map->cpuid, "common"))
> > +                        return &map->metric_table;
> > +        }
> > +        return NULL;
> > +}
> > +
> >   const struct pmu_events_table *find_core_events_table(const char *arc=
h, const char *cpuid)
> >   {
> >           for (const struct pmu_events_map *tables =3D &pmu_events_map[=
0];
> > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/j=
events.py
> > index 786a7049363f..5d3f4b44cfb7 100755
> > --- a/tools/perf/pmu-events/jevents.py
> > +++ b/tools/perf/pmu-events/jevents.py
> > @@ -755,7 +755,10 @@ static const struct pmu_events_map pmu_events_map[=
] =3D {
> >   \t\t.pmus =3D pmu_events__common,
> >   \t\t.num_pmus =3D ARRAY_SIZE(pmu_events__common),
> >   \t},
> > -\t.metric_table =3D {},
> > +\t.metric_table =3D {
> > +\t\t.pmus =3D pmu_metrics__common,
> > +\t\t.num_pmus =3D ARRAY_SIZE(pmu_metrics__common),
> > +\t},
> >   },
> >   """)
> >       else:
> > @@ -1237,6 +1240,22 @@ const struct pmu_metrics_table *pmu_metrics_tabl=
e__find(void)
> >           return map ? &map->metric_table : NULL;
> >   }
> >
> > +const struct pmu_metrics_table *pmu_metrics_table__default(void)
> > +{
> > +        int i =3D 0;
> > +
> > +        for (;;) {
> > +                const struct pmu_events_map *map =3D &pmu_events_map[i=
++];
> > +
> > +                if (!map->arch)
> > +                        break;
> > +
> > +                if (!strcmp(map->cpuid, "common"))
> > +                        return &map->metric_table;
> > +        }
> > +        return NULL;
> > +}
> > +
> >   const struct pmu_events_table *find_core_events_table(const char *arc=
h, const char *cpuid)
> >   {
> >           for (const struct pmu_events_map *tables =3D &pmu_events_map[=
0];
> > diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events=
/pmu-events.h
> > index e0535380c0b2..559265a903c8 100644
> > --- a/tools/perf/pmu-events/pmu-events.h
> > +++ b/tools/perf/pmu-events/pmu-events.h
> > @@ -127,6 +127,7 @@ int pmu_metrics_table__find_metric(const struct pmu=
_metrics_table *table,
> >   const struct pmu_events_table *perf_pmu__find_events_table(struct per=
f_pmu *pmu);
> >   const struct pmu_events_table *perf_pmu__default_core_events_table(vo=
id);
> >   const struct pmu_metrics_table *pmu_metrics_table__find(void);
> > +const struct pmu_metrics_table *pmu_metrics_table__default(void);
> >   const struct pmu_events_table *find_core_events_table(const char *arc=
h, const char *cpuid);
> >   const struct pmu_metrics_table *find_core_metrics_table(const char *a=
rch, const char *cpuid);
> >   int pmu_for_each_core_event(pmu_event_iter_fn fn, void *data);
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgrou=
p.c
> > index 76092ee26761..e67e04ce01c9 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -424,10 +424,18 @@ int metricgroup__for_each_metric(const struct pmu=
_metrics_table *table, pmu_metr
> >               .fn =3D fn,
> >               .data =3D data,
> >       };
> > +     const struct pmu_metrics_table *tables[2] =3D {
> > +             table,
> > +             pmu_metrics_table__default(),
> > +     };
> > +
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
> > +             int ret;
> >
> > -     if (table) {
> > -             int ret =3D pmu_metrics_table__for_each_metric(table, fn,=
 data);
> > +             if (!tables[i])
> > +                     continue;
> >
> > +             ret =3D pmu_metrics_table__for_each_metric(tables[i], fn,=
 data);
> >               if (ret)
> >                       return ret;
> >       }
> > @@ -1581,19 +1589,22 @@ static int metricgroup__has_metric_or_groups_ca=
llback(const struct pmu_metric *p
> >
> >   bool metricgroup__has_metric_or_groups(const char *pmu, const char *m=
etric_or_groups)
> >   {
> > -     const struct pmu_metrics_table *table =3D pmu_metrics_table__find=
();
> > +     const struct pmu_metrics_table *tables[2] =3D {
> > +             pmu_metrics_table__find(),
> > +             pmu_metrics_table__default(),
> > +     };
> >       struct metricgroup__has_metric_data data =3D {
> >               .pmu =3D pmu,
> >               .metric_or_groups =3D metric_or_groups,
> >       };
> >
> > -     if (!table)
> > -             return false;
> > -
> > -     return pmu_metrics_table__for_each_metric(table,
> > -                                               metricgroup__has_metric=
_or_groups_callback,
> > -                                               &data)
> > -             ? true : false;
> > +     for (size_t i =3D 0; i < ARRAY_SIZE(tables); i++) {
> > +             if (pmu_metrics_table__for_each_metric(tables[i],
> > +                                                     metricgroup__has_=
metric_or_groups_callback,
> > +                                                     &data))
> > +                     return true;
> > +     }
> > +     return false;
> >   }
> >
> >   static int metricgroup__topdown_max_level_callback(const struct pmu_m=
etric *pm,
>
