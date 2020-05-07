From: Ian Rogers <irogers@google.com>
Subject: [RFC PATCH v2 00/23] Share events between metrics
Date: Thu,  7 May 2020 07:07:56 -0700
Message-ID: <20200507140819.126960-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Kajol Jain <kjain@linux.ibm.com>, Andi Kleen <ak@linux.intel.com>, John Garry <john.garry@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Cong
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Metric groups contain metrics. Metrics create groups of events to
ideally be scheduled together. Often metrics refer to the same events,
for example, a cache hit and cache miss rate. Using separate event
groups means these metrics are multiplexed at different times and the
counts don't sum to 100%. More multiplexing also decreases the
accuracy of the measurement.

This change orders metrics from groups or the command line, so that
the ones with the most events are set up first. Later metrics see if
groups already provide their events, and reuse them if
possible. Unnecessary events and groups are eliminated.

RFC because:
 - without this change events within a metric may get scheduled
   together, after they may appear as part of a larger group and be
   multiplexed at different times, lowering accuracy - however, less
   multiplexing may compensate for this.
 - libbpf's hashmap is used, however, libbpf is an optional
   requirement for building perf.
 - other things I'm not thinking of.

Thanks!

v2. is the entire patch set based on acme's perf/core tree and includes a
cherry-picks. Patch 13 was sent for review to the bpf maintainers here:
https://lore.kernel.org/lkml/20200506205257.8964-2-irogers@google.com/
v1. was based on the perf metrics fixes and test sent here:
https://lore.kernel.org/lkml/20200501173333.227162-1-irogers@google.com/

Andrii Nakryiko (1):
  libbpf: Fix memory leak and possible double-free in hashmap__clear

Ian Rogers (22):
  perf expr: unlimited escaped characters in a symbol
  perf metrics: fix parse errors in cascade lake metrics
  perf metrics: fix parse errors in skylake metrics
  perf expr: allow ',' to be an other token
  perf expr: increase max other
  perf expr: parse numbers as doubles
  perf expr: debug lex if debugging yacc
  perf metrics: fix parse errors in power8 metrics
  perf metrics: fix parse errors in power9 metrics
  perf expr: print a debug message for division by zero
  perf parse-events: expand add PMU error/verbose messages
  perf test: improve pmu event metric testing
  lib/bpf hashmap: increase portability
  perf expr: fix memory leaks in bison
  perf evsel: fix 2 memory leaks
  perf expr: migrate expr ids table to libbpf's hashmap
  perf metricgroup: change evlist_used to a bitmap
  perf metricgroup: free metric_events on error
  perf metricgroup: always place duration_time last
  perf metricgroup: delay events string creation
  perf metricgroup: order event groups by size
  perf metricgroup: remove duped metric group events

 tools/lib/bpf/hashmap.c                       |   7 +
 tools/lib/bpf/hashmap.h                       |   3 +-
 tools/perf/arch/x86/util/intel-pt.c           |  32 ++-
 .../arch/powerpc/power8/metrics.json          |   2 +-
 .../arch/powerpc/power9/metrics.json          |   2 +-
 .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
 .../arch/x86/skylakex/skx-metrics.json        |   4 +-
 tools/perf/tests/builtin-test.c               |   5 +
 tools/perf/tests/expr.c                       |  33 ++-
 tools/perf/tests/pmu-events.c                 | 158 +++++++++++-
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/tests.h                      |   2 +
 tools/perf/util/evsel.c                       |   2 +
 tools/perf/util/expr.c                        | 126 ++++-----
 tools/perf/util/expr.h                        |  22 +-
 tools/perf/util/expr.l                        |  16 +-
 tools/perf/util/expr.y                        |  41 ++-
 tools/perf/util/metricgroup.c                 | 242 +++++++++++-------
 tools/perf/util/parse-events.c                |  29 ++-
 tools/perf/util/pmu.c                         |  33 ++-
 tools/perf/util/pmu.h                         |   2 +-
 tools/perf/util/stat-shadow.c                 |  46 ++--
 22 files changed, 545 insertions(+), 276 deletions(-)

-- 
2.26.2.526.g744177e7f7-goog
