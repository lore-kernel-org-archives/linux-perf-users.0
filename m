Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3BF329E53
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761857514; cv=none; b=OclTwP34G+pt+lVttcQ63Nac9U22QFLlz3foy/UBlKSRPpCzGHp/SwYzxRX7RLzm3btNnDjLt7DHYW1bcsGxbVadana0pNS2/Gx3VHEWQLDno7tcBLKdnxEp+bVbeB25fQmict416sGmFafjxe1eS3TP18AybLGuJsOepup4CVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761857514; c=relaxed/simple;
	bh=+4uCcoAB+xZdEjfs2ZApcSKOkH2PY2XqjQCwslYmWEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bPDMwXdfSd8mqR9wuBIcFfyj+19J+pJfb2r0kAJQTK7YsKojd7TVBkUGC+NIODzdTu4z+Yw9/8RteYudmwOT2mlUCkki3dwtHJb6Pfv+E8QRWy5YZwvMMWLa/A3ZHJqmhiSFJH/v6teT9hrprSUo7IUJEGXXkN0/L8QJCUYCISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XqDP0IUG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XqDP0IUG"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-290da96b37fso15065ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761857512; x=1762462312; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtjYWo2Aq+FsK2pzMrNNRstbZ+nQ8feK/GRfWrcLRLA=;
        b=XqDP0IUGFp6ZdCmp7MhOuJ+rldW5olCFBdWAxZGcPgahJvEuesIcHyaOsjt+qZFsBE
         1RvmUpvO3EjUUFCVk0H/eDfsjWqE62eHojBpszxSHyOZk0bP/V4i4IrgPpVqms36NVwO
         61z06cq935EdVnEDEL6ustN6ggmFnsMp/jrol54oxUQwrxzfzXAR3D1Z5eq1z+bHdptO
         IgQHwD7XREPLd9q0H+JntIbkED40zi7vYmmXjkd4eRNBu75SrqiHDdq2gNBKqshjnVaT
         0ASj9LV17yNF+bmj9fvLiFhcL8xHlZ73hjQH+rHl90jEK+vqrOGrDQfvjj9JSB92V087
         f9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761857512; x=1762462312;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtjYWo2Aq+FsK2pzMrNNRstbZ+nQ8feK/GRfWrcLRLA=;
        b=WG7A2nUhCqPr+XsYEpeTYoefrUzasfKCezMGvWsRn9rEkUfZoG6/q+y4+oA1igxcbW
         X/QlSD/tfsoZy2snozIhBQb8LOuzlhzxq+OuybgSWjSOEKaJ/0TDcylVuLzs28WFj5TN
         Rsij8mOmPNsmk3V4a+jkgV0nD9a1/qEWKFYM6uDywZJZCJj8HDoPIf7EqnW5q2xVLiVM
         TuSjkedU8h9Uex37mbieZb7z+jRXDdYR2Vpcw+N6d4LWg+9LT6vwjH2YZLHU+QbaR0Bp
         9yIm3lJo6L+OKCMxpT09C+uurRteDLtzZshlpYWHpYXU/Xr6XgkahYKy9zb3Qqc4x7cd
         Emlg==
X-Forwarded-Encrypted: i=1; AJvYcCXezO902iLkYGoAKhFWKwJ2yz9U5YuIIWmxUDY3/5SWl++2JVL1r3vpbC2DBiNa0aqkZWLFjPcDKO2qUTGEniZu@vger.kernel.org
X-Gm-Message-State: AOJu0YwF45pV0C1ZIgHRbQXlL3hjzWPDnbr7bP9HOeWCnANRf2IEE0QI
	ukeOez+Jjl8diN8cXmFCYKnFl+ppBxy85mOFYG6kz/Mj4a13P2gn19F2MaH9b3rrAiy+nYIzCv8
	E0rxxSn9gZwEx+s1/vW8PE7PMiak6C0bIThf5Gql/
X-Gm-Gg: ASbGncswwVzj91iawwi+3N6HCl3b8Vb68aPLYZFxxxZuZiV2r4d2VfUWFGwL6meph2C
	J6/8gcciDzY0ZdsKItAWihll3RthZjGjtIa1cqa+Y4OqmcUQbhsFvWqYZPzJyQSK5DQjFamiJpX
	3KZwv+RaRYoBdAa/aLWWrzbb+67xMy5QhzYtI9X4F4LRxVxK6D93vsB1DYzRC5FF/AN8AYSfBdt
	Tmmmramqo9YI4I5/k/7e+4GrEypjkVKJ5liJFEXYM8b0Sbn3UM+d5xHcHg6uIFkg3otjCf0gGEL
	RhknHq98SZKw9w==
X-Google-Smtp-Source: AGHT+IE4QM/XLPpMzVEFWT1gvDrMSis269JF+oBhf07i0pA1gy8Rd4e/MLn8zSibOcsromZeIk3OudM2E6GeefspzI8=
X-Received: by 2002:a17:903:41ca:b0:290:b527:97ec with SMTP id
 d9443c01a7336-29522c8961emr376895ad.5.1761857511550; Thu, 30 Oct 2025
 13:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 30 Oct 2025 13:51:39 -0700
X-Gm-Features: AWmQ_bkC8i9E88AAEwMhkOTMnbvf9tzmo4D_FrV_a2KF2FWrDs2THu3mR_4I8lA
Message-ID: <CAP-5=fUsK9+d0=f2RuTQBfooVZ6qTPZ=XQZ_z7DaH08FG6tV9w@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Switch the default perf stat metrics to json
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 10:59=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> Prior to this series stat-shadow would produce hard coded metrics if
> certain events appeared in the evlist. This series produces equivalent
> json metrics and cleans up the consequences in tests and display
> output. A before and after of the default display output on a
> tigerlake is:
>
> Before:
> ```
> $ perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>     16,041,816,418      cpu-clock                        #   15.995 CPUs =
utilized
>              5,749      context-switches                 #  358.376 /sec
>                121      cpu-migrations                   #    7.543 /sec
>              1,806      page-faults                      #  112.581 /sec
>        825,965,204      instructions                     #    0.70  insn =
per cycle
>      1,180,799,101      cycles                           #    0.074 GHz
>        168,945,109      branches                         #   10.532 M/sec
>          4,629,567      branch-misses                    #    2.74% of al=
l branches
>  #     30.2 %  tma_backend_bound
>                                                   #      7.8 %  tma_bad_s=
peculation
>                                                   #     47.1 %  tma_front=
end_bound
>  #     14.9 %  tma_retiring
> ```
>
> After:
> ```
> $ perf stat -a sleep 1
>
>  Performance counter stats for 'system wide':
>
>              2,890      context-switches                 #    179.9 cs/se=
c  cs_per_second
>     16,061,923,339      cpu-clock                        #     16.0 CPUs =
 CPUs_utilized
>                 43      cpu-migrations                   #      2.7 migra=
tions/sec  migrations_per_second
>              5,645      page-faults                      #    351.5 fault=
s/sec  page_faults_per_second
>          5,708,413      branch-misses                    #      1.4 %  br=
anch_miss_rate         (88.83%)
>        429,978,120      branches                         #     26.8 K/sec=
  branch_frequency     (88.85%)
>      1,626,915,897      cpu-cycles                       #      0.1 GHz  =
cycles_frequency       (88.84%)
>      2,556,805,534      instructions                     #      1.5 instr=
uctions  insn_per_cycle  (88.86%)
>                         TopdownL1                 #     20.1 %  tma_backe=
nd_bound
>                                                   #     40.5 %  tma_bad_s=
peculation      (88.90%)
>                                                   #     17.2 %  tma_front=
end_bound       (78.05%)
>                                                   #     22.2 %  tma_retir=
ing             (88.89%)
>
>        1.002994394 seconds time elapsed
> ```
>
> Having the metrics in json brings greater uniformity, allows events to
> be shared by metrics, and it also allows descriptions like:
> ```
> $ perf list cs_per_second
> ...
>   cs_per_second
>        [Context switches per CPU second]
> ```
>
> A thorn in the side of doing this work was that the hard coded metrics
> were used by perf script with '-F metric'. This functionality didn't
> work for me (I was testing `perf record -e instructions,cycles` and
> then `perf script -F metric` but saw nothing but empty lines) but
> anyway I decided to fix it to the best of my ability in this
> series. So the script side counters were removed and the regular ones
> associated with the evsel used. The json metrics were all searched
> looking for ones that have a subset of events matching those in the
> perf script session, and all metrics are printed. This is kind of
> weird as the counters are being set by the period of samples, but I
> carried the behavior forward. I suspect there needs to be follow up
> work to make this better, but what is in the series is superior to
> what is currently in the tree. Follow up work could include finding
> metrics for the machine in the perf.data rather than using the host,
> allowing multiple metrics even if the metric ids of the events differ,
> fixing pre-existing `perf stat record/report` issues, etc.
>
> There is a lot of stat tests that, for example, assume '-e
> instructions,cycles' will produce an IPC metric. These things needed
> tidying as now the metric must be explicitly asked for and when doing
> this ones using software events were preferred to increase
> compatibility. As the test updates were numerous they are distinct to
> the patches updating the functionality causing periods in the series
> where not all tests are passing. If this is undesirable the test fixes
> can be squashed into the functionality updates.

Hi,

no comments on this series yet, please help! I'd like to land this
work and then rebase the python generating metric work [1] on it. The
metric generation work is largely independent of everything else but
there are collisions in the json Makefile/Build files.

Thanks,
Ian

[1]
* Foundations: https://lore.kernel.org/lkml/20240228175617.4049201-1-iroger=
s@google.com/
* AMD: https://lore.kernel.org/lkml/20240229001537.4158049-1-irogers@google=
.com/
* Intel: https://lore.kernel.org/lkml/20240229001806.4158429-1-irogers@goog=
le.com/
* ARM: https://lore.kernel.org/lkml/20240229001325.4157655-1-irogers@google=
.com/



> Ian Rogers (22):
>   perf evsel: Remove unused metric_events variable
>   perf metricgroup: Update comment on location of metric_event list
>   perf metricgroup: Missed free on error path
>   perf metricgroup: When copy metrics copy default information
>   perf metricgroup: Add care to picking the evsel for displaying a
>     metric
>   perf jevents: Make all tables static
>   perf expr: Add #target_cpu literal
>   perf jevents: Add set of common metrics based on default ones
>   perf jevents: Add metric DefaultShowEvents
>   perf stat: Add detail -d,-dd,-ddd metrics
>   perf script: Change metric format to use json metrics
>   perf stat: Remove hard coded shadow metrics
>   perf stat: Fix default metricgroup display on hybrid
>   perf stat: Sort default events/metrics
>   perf stat: Remove "unit" workarounds for metric-only
>   perf test stat+json: Improve metric-only testing
>   perf test stat: Ignore failures in Default[234] metricgroups
>   perf test stat: Update std_output testing metric expectations
>   perf test metrics: Update all metrics for possibly failing default
>     metrics
>   perf test stat: Update shadow test to use metrics
>   perf test stat: Update test expectations and events
>   perf test stat csv: Update test expectations and events
>
>  tools/perf/builtin-script.c                   | 238 ++++++++++-
>  tools/perf/builtin-stat.c                     | 154 ++-----
>  .../arch/common/common/metrics.json           | 151 +++++++
>  tools/perf/pmu-events/empty-pmu-events.c      | 139 ++++--
>  tools/perf/pmu-events/jevents.py              |  34 +-
>  tools/perf/pmu-events/pmu-events.h            |   2 +
>  .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
>  tools/perf/tests/shell/lib/stat_output.sh     |   2 +-
>  tools/perf/tests/shell/stat+csv_output.sh     |   2 +-
>  tools/perf/tests/shell/stat+json_output.sh    |   2 +-
>  tools/perf/tests/shell/stat+shadow_stat.sh    |   4 +-
>  tools/perf/tests/shell/stat+std_output.sh     |   4 +-
>  tools/perf/tests/shell/stat.sh                |   6 +-
>  .../perf/tests/shell/stat_all_metricgroups.sh |   3 +
>  tools/perf/tests/shell/stat_all_metrics.sh    |   7 +-
>  tools/perf/util/evsel.c                       |   2 -
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/expr.c                        |   3 +
>  tools/perf/util/metricgroup.c                 |  95 ++++-
>  tools/perf/util/metricgroup.h                 |   2 +-
>  tools/perf/util/stat-display.c                |  55 +--
>  tools/perf/util/stat-shadow.c                 | 402 +-----------------
>  tools/perf/util/stat.h                        |   2 +-
>  23 files changed, 672 insertions(+), 643 deletions(-)
>  create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
>
> --
> 2.51.1.821.gb6fe4d2222-goog
>
