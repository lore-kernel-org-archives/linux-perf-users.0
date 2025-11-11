Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC7C33987
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833868; cv=none; b=iHF3ZhicNmVJ4tWElKtwO/VoW0j/CtLgj4Yqb3/yFg1SofTQESbizWAErGlSzq9AWBcV8hvoRQdxQGAOF+OYgYA4XHyuB96xIZYQz/3B5YzlNZAIFzIDZoZOMNQyyagrU0iSnzVgd8TbuHuBYjQQR5o/V6aIKAKsEfg6b8Nr6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833868; c=relaxed/simple;
	bh=1mBjO8UR0M4ItBaJw5PUKuF0DR1PX8C67gBkX+zy+rs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=bT+c/mlm0JlRCtii/rV78Ii1VbsN0DOeAxwFbrEYqK3OZ4V1SavVkpNX8XgnJjhkTrv3gdP00qNNaKguMF0UeEmL8DziwibXZ31/O4e5anTNq6DNdPpKeJlzA1wv6CGdV+r07+flxwVGfpyCzQBOGBHQIequJSPNtJjs1fxTc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aJEKLo3b; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aJEKLo3b"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297f3710070so70931575ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833866; x=1763438666; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1PSFgP9VQsSqfbamt9NalTKm2hbaezrc1+diiPEJGbg=;
        b=aJEKLo3blPksvhbejht2gA7G+pP8Oe2mjaWtQNRF/VH/cCp2xl3TMV3rww6x7pTLoC
         5Ryqc6XdvF7/UaxvBeFRfmjnhXuV/BNwWDiuUTIL+4NmdcCj0xpWtAJfOeNAai9ePNwI
         pXjfFLKcbtin0my/m7q0hzIlqd3/oZm9Xt1mrtO6QtLNtD1mjiC1f34dVXrVje3VZPR7
         vvt8JyAXlwASS3ewEaP/L6J1sFocbyihrOJWoed/er4NUzguf/6RH86HBZfh7YexCn9h
         xNd/numZTcj3Gxz13pSy3wFP9bRfVTMYlSVRE5got6oTRpdvf8fCeOY8sPGYR0dRtYjV
         0G3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833866; x=1763438666;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1PSFgP9VQsSqfbamt9NalTKm2hbaezrc1+diiPEJGbg=;
        b=pE4osniVOFv4+fvKuR+Dbn/ROy2YWScuAQfmWIHLTi2AwD/xqK1UDbz6nOxbt2ryxT
         /1u3OAHFfe4K2dJc8qPBA5JFVSXHdxVTHOZWl4wH4t9LyOkL2zaJYNxid/2DNE0rozhn
         d6W5SjFbKjNXVrw/aX7dRFo4eH+fg/77nQfX5fGg4eWdODUQg9wsSv2T4rqjAo8qQQ1x
         atJQQcaw2YdGk+hAOee1lXzyCj20XSj3kejn5hTTnnGvjipMa5VjC7OZSfel4zd7l2UX
         lZ+lNj92kJjsSlRiZ271QKLcOapdLFYtPr1EF9Ku6bKeX0g99pqZyPD8TQ3JwieNkZXS
         PZVA==
X-Forwarded-Encrypted: i=1; AJvYcCXs8x2tZ84IRUcTr0c+la8cBi0HHDaEybZsr487mGF1u3dT7ncD/8lZ7tD0YiRkBrGnPaqb3uXr+cw+XJC1ewGC@vger.kernel.org
X-Gm-Message-State: AOJu0YxHRZJrhsfI64qwb0DRfoTeMv3js4wgZioyB7YLS47jq6HBCYZ/
	nLMFLzhtEI+9r8ozzIWZI29Vzw8TwLK/NGAL7diF/tjgqUpfAIht/tzlsYQt4g6Vh/V3CB2rtbK
	Uov/Doy/VKw==
X-Google-Smtp-Source: AGHT+IEAc6mZMUVxGYOLUE41zxOZxEn3pFmCRs08mmZRN2ivMJ/qXjwH5wtaQwCxWgfOdOzCulNph2du/HdU
X-Received: from dybmy9.prod.google.com ([2002:a05:7300:d489:b0:2a2:3f59:eef5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ebcb:b0:295:ac6f:c899
 with SMTP id d9443c01a7336-297e56ddbdcmr153595945ad.47.1762833865465; Mon, 10
 Nov 2025 20:04:25 -0800 (PST)
Date: Mon, 10 Nov 2025 20:03:59 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-1-irogers@google.com>
Subject: [PATCH v3 00/18] Switch the default perf stat metrics to json
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

v3: Rebase resolving merge conflicts in
    tools/perf/pmu-events/empty-pmu-events.c by just regenerating it
    (Dapeng Mi).

v2: Drop merged patches, add json to document target_cpu/core_wide and
    example to "Add care to picking the evsel for displaying a metric"
    commit message (Namhyung).
    https://lore.kernel.org/lkml/20251106231508.448793-1-irogers@google.com/

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

