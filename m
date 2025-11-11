Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF235CBD1
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896140; cv=none; b=PvkrPOYrnu8StKxaGzXj+1MuAJ2oSXo8kXKFGbQkiIOw6uG04gEzE+OkmEH0Pz2Y3VK5bHcYXKBKx4T+4yY7y1JKNj1tXt604NBGzNjhDq/FEx1beCuKc8w37sZ1S21H7D22uU67ibfe5JJ55w5mYgl2mLnL4XdMjxpqUpzDPV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896140; c=relaxed/simple;
	bh=lA7jtuLvLmQCo1beIsppsxSDg5isC9yU9XPL/XSrjIg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=TLZdlQjLgJMJTnVVQs3P3SJdtvg/f7jq5QFEARDHKFTYz2vC9Yz4f9144HzqHMN4h4s6VJqfu3ChXvzKVV0LhtsKxINQ5B/TC4rKdhDYsjaiC6fWGSqPSS+1XxK0r8VpHFVbQnO5/d4yoMXkXMrszIMVVK5WAPo/X5jdqU34jy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m+MI/B1O; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m+MI/B1O"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295915934bfso2404625ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896138; x=1763500938; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=59UchP3aTFkfV2j0PGUqNhm800BgyEu/QEs9y2VWJa8=;
        b=m+MI/B1OGqhQmES5/7XXnRczuLeRPByATLt/Occ7wnSJmxjf3a3IwaiwcxXPIu5Q97
         LNgQ52+T2ri2zbL8tzaT/R/WfqLVp52e9m7IbYgtPo9csYrH7SiTbEb8F8jtr1FypW3k
         fp9tDa98bJ4/hMz6/f7NzPOFwskBSKV5FkT/Awe1s4xJL+vIDmPPbsY6pDRTmhM4iRXB
         fIjktEhnUBwCRraiulY/TExjyThL3eabJ8NLPUhp865Q7SwGXoOmbxUn2O4ySE0OKoPV
         2phzCEwQ6wiBKG84XazkHi4aO/xTXmg9uM4X7YbPA02DXC7DvAJ3bZPpj5f3rhFJ3FWd
         H4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896138; x=1763500938;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=59UchP3aTFkfV2j0PGUqNhm800BgyEu/QEs9y2VWJa8=;
        b=OW35XAT0zJKkqOLQWSQS9+2VyQu1gWws9CWiJrhJ4F9PXBCzTnFc0k+4DvUK6WxqjM
         yxACAhxVG4cjPQAOihPhWduKfOCAYzCeNKieLYEkoimTxERB+cdL0fJsvCISN+l9NnMA
         3IVRNO37Z5pThqYgy4UAKORcxPwaZPDzNZLmFdbYKjED6kaLzAY4MovnUD4nAMmpNcBm
         wT9kvFECOuN+hDXiTikbxHxX0+/g9k+rOLK7e18QZ2uWVknQg2jjPlo+uzR55+c1suJS
         qp6nfkVK5k0ltmMT7aRNaTvAoThzKX8Cq5JPxIDeAuDrDEfna6pPEC7ctkVkOMmOTaqe
         us9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWejXvvAQ+3UkXqyvvtwRVjTymzyU/XGkuLhCzOHJIiy7aZOndh6zz/dKkpE1BJSjmjWYVfM7APkngjUAA6vXzq@vger.kernel.org
X-Gm-Message-State: AOJu0Yz70Z1ZSBqYebSndDidpZOnbSJzedS2Q3spbKXm+HY2f32iu0NG
	r/eNooAz9ANRVfZ28UGePhXqpVvVV4ymZsU5DRG6JozdK/tXmF2/AlFkwsZOqq3gKk4FdnU1h7+
	/8UreGoqIbg==
X-Google-Smtp-Source: AGHT+IFNZOSSZeEsk7yuX/W3guyaVZHOYNjNPEH/bes1XMLs3WiqdyuB57SKPAtWaQJwW0+Qr059xhN2zA6F
X-Received: from dlbay37.prod.google.com ([2002:a05:7022:6625:b0:11a:51f9:d69])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:286:b0:295:1e50:e7cb
 with SMTP id d9443c01a7336-2984ed490a5mr9396395ad.23.1762896138009; Tue, 11
 Nov 2025 13:22:18 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:48 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-1-irogers@google.com>
Subject: [PATCH v4 00/18]
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
       429,978,120      branches                         #     26.8 M/sec  branch_frequency     (88.85%)
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

v4: K/sec to M/sec on branch frequency (Namhyung), perf script -F
    metric to-done a system-wide calculation (Namhyung) and don't
    crash because of the CPU map index couldn't be found. Regenerate
    commit messages but the cpu-clock was always yielding 0 on my
    machine leading to a lot of nan metric values.

v3: Rebase resolving merge conflicts in
    tools/perf/pmu-events/empty-pmu-events.c by just regenerating it
    (Dapeng Mi).
    https://lore.kernel.org/lkml/20251111040417.270945-1-irogers@google.com/

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

 tools/perf/builtin-script.c                   | 251 ++++++++++-
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
 24 files changed, 769 insertions(+), 687 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json

-- 
2.51.2.1041.gc1ab5b90ca-goog

