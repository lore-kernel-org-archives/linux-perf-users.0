Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FDA25DAF0
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328743; cv=none; b=hFz02hwk4u1B1ItyAOsphOdd77+3g6mSL7mLxOZq7qNMIyBVLmXzWmcc8UStGJEMl9lYoN2f3Swr8cZzI3LJd1ZJrSS5qo6WQfoqrvnxokotD5qY+ILsQuwffKgXHFcB0oKZKDzjb3ReamwCQU4p7Ofi5EYKmG3bNYdnZ/yFZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328743; c=relaxed/simple;
	bh=Crk8CTpd08KWCftkqr3kJuq5FAokhx59ciV+ljDj6BI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=AxcwovelDtzTQ16Ezsmiu1wfK8sgiVeGvE3wzWOPHCqBiIk4ZtNqsLhdG6JkEjBdUOZo8boLrRY2GOuPpa57vuqDxxxrMwp7iFchtNjr18dduYZrehjKOu+YNRphduo2rRMimgnkCIgRe/TBRaHel/ufWB0Qo3kqZkBN331abBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7z8PG8P; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7z8PG8P"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29085106b99so24432765ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328740; x=1761933540; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M6FG788WNKrt2YuSQqRoqntPq3sCKgDaC4SShSJk7Ok=;
        b=t7z8PG8PIlvunnPvQvM0R5d2VL/a8HtFaChOCAQxPPC4auUDkTitl7AYzP+BOKJA0V
         Tf3wuITmmcuxFEndW5KIvwGSnnwqnSD5N63OtuGr+3MPUK8N0yyulXZH1/dNsiX5thy1
         9+h2n4c0zGWaRw4G6U4jv7rdtjzdT8XdwEGnxJUrM219aySlH4wz1FYmwMN79s40vViG
         dke6FnTG6v8VYyo3io1krjc3mDRdvYCYeL5v1HoRvaJXCeCpiOZL++A66uHBeturHZZW
         t61EXxT22LeEf7BtVEnSwOTaVMTJaMxLO1eamf8m9EfX8DGoKcWK3cjxViIwCOxBY5Y1
         uVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328740; x=1761933540;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M6FG788WNKrt2YuSQqRoqntPq3sCKgDaC4SShSJk7Ok=;
        b=JjVsrw/O3n5udhS/ovd5Phh6/0edV51DDEHARY0wmVnSmYM5pj607X8hdEihDD1TEI
         hJRBAaJEB+2y40F27GAaQBLKxSQk+Do1oAupzwgAT46DVYm06eFT4p7eA8qkgkmeY+r3
         4kukqH3PK7ziJSsoCg7Rn+E5n5FoxBpM386mXOyi70Lt8c602wNNpouXMjJIFDvPTsTM
         FHgry46Y0zQj2E5nVnfG6XFtLms6vgdrer19NVjQXVRv8JIIkShBy4c5Diijd2jViJ9s
         +gIUey7EM0R9wz/XJWWx8Nn1by1mc2DEvnwjAPrBQ8PvzBzZ87jCJwElSdL2sw+7dggT
         aOEA==
X-Forwarded-Encrypted: i=1; AJvYcCUrBX28YlPg59DXiG+cxyzZlCLPddkbk9oP2YmGSU9UClWZhi7FdkAH0NteB7ygfF8StDAt9wI1PCYQttq5IZyR@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9a8w47CsqXR69PQLrAjn4R8+qYMjMNucgYpcjRKWHwisJnPZK
	SB05YcI+9A6itgrM1l5nbnXk1lh8MYDYeWnmpeK3vW+JQrvpHL6L6cTZtnibmR9yqTFo1zNJn1S
	RNHo39Vi2FQ==
X-Google-Smtp-Source: AGHT+IHp7Ea0p2UPKRz+HcoP7tb2owWmT2q1MmTFcCpt4eK8NPX6uU54zQVDO5dJfOtmFQxBaHZDnZ63p9Oi
X-Received: from pjtv19.prod.google.com ([2002:a17:90a:c913:b0:33b:dccb:b328])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2446:b0:26a:f6e6:ef4f
 with SMTP id d9443c01a7336-2946e29d5c3mr74487725ad.60.1761328740079; Fri, 24
 Oct 2025 10:59:00 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:35 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-1-irogers@google.com>
Subject: [PATCH v1 00/22] Switch the default perf stat metrics to json
From: Ian Rogers <irogers@google.com>
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
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Prior to this series stat-shadow would produce hard coded metrics if
certain events appeared in the evlist. This series produces equivalent
json metrics and cleans up the consequences in tests and display
output. A before and after of the default display output on a
tigerlake is:

Before:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

    16,041,816,418      cpu-clock                        #   15.995 CPUs utilized             
             5,749      context-switches                 #  358.376 /sec                      
               121      cpu-migrations                   #    7.543 /sec                      
             1,806      page-faults                      #  112.581 /sec                      
       825,965,204      instructions                     #    0.70  insn per cycle            
     1,180,799,101      cycles                           #    0.074 GHz                       
       168,945,109      branches                         #   10.532 M/sec                     
         4,629,567      branch-misses                    #    2.74% of all branches           
 #     30.2 %  tma_backend_bound      
                                                  #      7.8 %  tma_bad_speculation    
                                                  #     47.1 %  tma_frontend_bound     
 #     14.9 %  tma_retiring           
```

After:
```
$ perf stat -a sleep 1

 Performance counter stats for 'system wide':

             2,890      context-switches                 #    179.9 cs/sec  cs_per_second     
    16,061,923,339      cpu-clock                        #     16.0 CPUs  CPUs_utilized       
                43      cpu-migrations                   #      2.7 migrations/sec  migrations_per_second
             5,645      page-faults                      #    351.5 faults/sec  page_faults_per_second
         5,708,413      branch-misses                    #      1.4 %  branch_miss_rate         (88.83%)
       429,978,120      branches                         #     26.8 K/sec  branch_frequency     (88.85%)
     1,626,915,897      cpu-cycles                       #      0.1 GHz  cycles_frequency       (88.84%)
     2,556,805,534      instructions                     #      1.5 instructions  insn_per_cycle  (88.86%)
                        TopdownL1                 #     20.1 %  tma_backend_bound      
                                                  #     40.5 %  tma_bad_speculation      (88.90%)
                                                  #     17.2 %  tma_frontend_bound       (78.05%)
                                                  #     22.2 %  tma_retiring             (88.89%)

       1.002994394 seconds time elapsed
```

Having the metrics in json brings greater uniformity, allows events to
be shared by metrics, and it also allows descriptions like:
```
$ perf list cs_per_second
...
  cs_per_second
       [Context switches per CPU second]
```

A thorn in the side of doing this work was that the hard coded metrics
were used by perf script with '-F metric'. This functionality didn't
work for me (I was testing `perf record -e instructions,cycles` and
then `perf script -F metric` but saw nothing but empty lines) but
anyway I decided to fix it to the best of my ability in this
series. So the script side counters were removed and the regular ones
associated with the evsel used. The json metrics were all searched
looking for ones that have a subset of events matching those in the
perf script session, and all metrics are printed. This is kind of
weird as the counters are being set by the period of samples, but I
carried the behavior forward. I suspect there needs to be follow up
work to make this better, but what is in the series is superior to
what is currently in the tree. Follow up work could include finding
metrics for the machine in the perf.data rather than using the host,
allowing multiple metrics even if the metric ids of the events differ,
fixing pre-existing `perf stat record/report` issues, etc.

There is a lot of stat tests that, for example, assume '-e
instructions,cycles' will produce an IPC metric. These things needed
tidying as now the metric must be explicitly asked for and when doing
this ones using software events were preferred to increase
compatibility. As the test updates were numerous they are distinct to
the patches updating the functionality causing periods in the series
where not all tests are passing. If this is undesirable the test fixes
can be squashed into the functionality updates.

Ian Rogers (22):
  perf evsel: Remove unused metric_events variable
  perf metricgroup: Update comment on location of metric_event list
  perf metricgroup: Missed free on error path
  perf metricgroup: When copy metrics copy default information
  perf metricgroup: Add care to picking the evsel for displaying a
    metric
  perf jevents: Make all tables static
  perf expr: Add #target_cpu literal
  perf jevents: Add set of common metrics based on default ones
  perf jevents: Add metric DefaultShowEvents
  perf stat: Add detail -d,-dd,-ddd metrics
  perf script: Change metric format to use json metrics
  perf stat: Remove hard coded shadow metrics
  perf stat: Fix default metricgroup display on hybrid
  perf stat: Sort default events/metrics
  perf stat: Remove "unit" workarounds for metric-only
  perf test stat+json: Improve metric-only testing
  perf test stat: Ignore failures in Default[234] metricgroups
  perf test stat: Update std_output testing metric expectations
  perf test metrics: Update all metrics for possibly failing default
    metrics
  perf test stat: Update shadow test to use metrics
  perf test stat: Update test expectations and events
  perf test stat csv: Update test expectations and events

 tools/perf/builtin-script.c                   | 238 ++++++++++-
 tools/perf/builtin-stat.c                     | 154 ++-----
 .../arch/common/common/metrics.json           | 151 +++++++
 tools/perf/pmu-events/empty-pmu-events.c      | 139 ++++--
 tools/perf/pmu-events/jevents.py              |  34 +-
 tools/perf/pmu-events/pmu-events.h            |   2 +
 .../tests/shell/lib/perf_json_output_lint.py  |   4 +-
 tools/perf/tests/shell/lib/stat_output.sh     |   2 +-
 tools/perf/tests/shell/stat+csv_output.sh     |   2 +-
 tools/perf/tests/shell/stat+json_output.sh    |   2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh    |   4 +-
 tools/perf/tests/shell/stat+std_output.sh     |   4 +-
 tools/perf/tests/shell/stat.sh                |   6 +-
 .../perf/tests/shell/stat_all_metricgroups.sh |   3 +
 tools/perf/tests/shell/stat_all_metrics.sh    |   7 +-
 tools/perf/util/evsel.c                       |   2 -
 tools/perf/util/evsel.h                       |   2 +-
 tools/perf/util/expr.c                        |   3 +
 tools/perf/util/metricgroup.c                 |  95 ++++-
 tools/perf/util/metricgroup.h                 |   2 +-
 tools/perf/util/stat-display.c                |  55 +--
 tools/perf/util/stat-shadow.c                 | 402 +-----------------
 tools/perf/util/stat.h                        |   2 +-
 23 files changed, 672 insertions(+), 643 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json

-- 
2.51.1.821.gb6fe4d2222-goog

