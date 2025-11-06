Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E74D2DC328
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470942; cv=none; b=jX3G6r1NzSzEJU3rnWTGgGJWIAnswz4SQKIpkSIEC5/7wXbLQ4m3Xow7XpCF0oFs+2tLDDKJlFnHR5zmbY2ca9+ez3FIpaywjODudxAIEGob+4M5PGUeOKZ7TDJPlNdYZIkWC3rR1k9UIlEI5uO4aU+9FzB+OoQU/4rd8Uj3o9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470942; c=relaxed/simple;
	bh=8aCdLloTz/t3BojhCp+mmRF3NEYyUU7GJs7cta9e7sg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=StJ0ONnUb/I7oRJKuH0qvCJdHKbutGQpFuglga7ZDiZ6Wfa+Fy6W9SdFoZ0cg0mYBtITsxvI3UN2GJRo1kYizRYJtZk1X1YwSqUgs4ct+sgIK7sqJ5t2NY8XUPMjwoZlCMzX3P7i5yJKTqPmZ8HSq16+PP5NdFBZQ0kpTQQtWfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yfFq3X5J; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yfFq3X5J"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b609c0f6522so301767a12.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470939; x=1763075739; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/XT3ZjgJNZ2AXY2aHWzO3eK40WFYsHQBaK/r9kuz9k4=;
        b=yfFq3X5JPClkCCE6S/lFh+gojPexoV/ejVNGFkn+pB9contP0cPXz2F9XEMQCePMyP
         p4RaFEMs9akWFxOdGrV8OWCT6+XibGJsnruNxkMpg2TM1cP8JudhS2TMOzT1FjQ5nyLl
         nozk1TkIo3Pi3nZy+czWL/euQzlC59xjXMsVgVCZQvURJJGgNEV+IxTRKa546R44Ta0F
         xSFV/9xL7MutfCy0p5zLCNMZFbJc+cu+XVfvLOC5YBI4/VDn1Bb44zAwVB/V8p09WGk9
         sac7Yydzbe5QAiv7VITgfzsZ+szY5+NM5Vathd0ql79Af2V7MW0qeyEj89p+jjAqwnEH
         UjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470939; x=1763075739;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XT3ZjgJNZ2AXY2aHWzO3eK40WFYsHQBaK/r9kuz9k4=;
        b=EAL2/xRMrZsCJGL5jq0bp3bzK5LU+gRjPE/GXMlWvSY96DrgucrZHTH1vSTYZ+LDZT
         2CR0SkIs6eyDjsJcZZbVMx9JOhTIiTyn4jO7eEeZHJDvaqa3RBrKa0sBOZ6i/4bRS6pm
         HgAs2VaxTLiUcaVTUNUflckczcw1id/dQoz3VqqrEcjBnWxcNloedDvD50EmZr7HHULD
         HbS+bWheuIPaqW+OmXhFEGVkrH2s2TeCZerq0NBYuNsXlfyrOcmYahyXNKkXCPXA+S09
         P8dLwyVOnKv+V/hUUtYrk01Pwg9jtB3tD/RYUUZzYIY+h0ogyLwobL4e5ig21omxGytr
         3nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFBvfxtwKUd07kztIAaLFQ6vgufuWoMI5hdTcl5B8IhbVASnyQ+FVM5LbrmShGrd8/z8FPzojpQpxZref7bZnV@vger.kernel.org
X-Gm-Message-State: AOJu0YxXu9ApYd82Hs38JEpljq1Z3fV8TLIkOU3puqarDzDEVTw8CrTt
	//MoP/lhajS0rPk2qtLEhPz4eYlA1UqUWjnPIHBi5+fyojD5rXFlnMvOgI4PyG0vsTzwJEnBpLD
	dtf4Me8tVAA==
X-Google-Smtp-Source: AGHT+IFAnYRThxcTSwYAfES/JdjNBEucxhflaMx9acjC6Ty1fvWpL9aUy+/lD1w+un+82GdxyfbmTVQGTyPt
X-Received: from dlbrx9.prod.google.com ([2002:a05:7022:1709:b0:119:78ff:fe16])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cecb:b0:24e:3cf2:2453
 with SMTP id d9443c01a7336-297c048f41cmr14757195ad.61.1762470939302; Thu, 06
 Nov 2025 15:15:39 -0800 (PST)
Date: Thu,  6 Nov 2025 15:14:50 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-1-irogers@google.com>
Subject: [PATCH v2 00/18] Switch the default perf stat metrics to json
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
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
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
work for me (I was testing `perf record -e instructions,cycles`
with/without leader sampling and then `perf script -F metric` but saw
nothing but empty lines) but anyway I decided to fix it to the best of
my ability in this series. So the script side counters were removed
and the regular ones associated with the evsel used. The json metrics
were all searched looking for ones that have a subset of events
matching those in the perf script session, and all metrics are
printed. This is kind of weird as the counters are being set by the
period of samples, but I carried the behavior forward. I suspect there
needs to be follow up work to make this better, but what is in the
series is superior to what is currently in the tree. Follow up work
could include finding metrics for the machine in the perf.data rather
than using the host, allowing multiple metrics even if the metric ids
of the events differ, fixing pre-existing `perf stat record/report`
issues, etc.

There is a lot of stat tests that, for example, assume '-e
instructions,cycles' will produce an IPC metric. These things needed
tidying as now the metric must be explicitly asked for and when doing
this ones using software events were preferred to increase
compatibility. As the test updates were numerous they are distinct to
the patches updating the functionality causing periods in the series
where not all tests are passing. If this is undesirable the test fixes
can be squashed into the functionality updates, but this will be kind
of messy, especially as at some points in the series both the old
metrics and the new metrics will be displayed.

v2: Drop merged patches, add json to document target_cpu/core_wide and
    example to "Add care to picking the evsel for displaying a metric"
    commit message (Namhyung).

v1: https://lore.kernel.org/lkml/20251024175857.808401-1-irogers@google.com/

Ian Rogers (18):
  perf metricgroup: Add care to picking the evsel for displaying a
    metric
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
  perf tool_pmu: Make core_wide and target_cpu json events

 tools/perf/builtin-script.c                   | 238 ++++++++++-
 tools/perf/builtin-stat.c                     | 154 ++-----
 .../arch/common/common/metrics.json           | 151 +++++++
 .../pmu-events/arch/common/common/tool.json   |  12 +
 tools/perf/pmu-events/empty-pmu-events.c      | 229 ++++++----
 tools/perf/pmu-events/jevents.py              |  28 +-
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
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/expr.c                        |   8 +-
 tools/perf/util/metricgroup.c                 |  92 +++-
 tools/perf/util/stat-display.c                |  55 +--
 tools/perf/util/stat-shadow.c                 | 404 +-----------------
 tools/perf/util/stat.h                        |   2 +-
 tools/perf/util/tool_pmu.c                    |  24 +-
 tools/perf/util/tool_pmu.h                    |   9 +-
 24 files changed, 756 insertions(+), 687 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json

-- 
2.51.2.1041.gc1ab5b90ca-goog

