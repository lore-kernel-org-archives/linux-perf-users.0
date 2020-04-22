From: Ian Rogers <irogers@google.com>
Subject: [PATCH 0/8] perf metric fixes and test
Date: Wed, 22 Apr 2020 00:48:01 -0700
Message-ID: <20200422074809.160248-1-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Haiyan Song <haiyanx.song@intel.com>, Jin Yao <yao.jin@linux.intel.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, John Garry <john.garry@huawei.com>, Leo Yan <leo.yan@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>, Ian Rogers <irogers@google.com>
List-Id: linux-perf-users.vger.kernel.org

Add a test that all perf metrics (for your architecture) are
parsable. Fix bugs in the expr parser and in x86 metrics. Untested on
architectures other than x86.

Ian Rogers (8):
  perf expr: unlimited escaped characters in a symbol
  perf metrics: fix parse errors in cascade lake metrics
  perf metrics: fix parse errors in skylake metrics
  perf expr: allow ',' to be an other token
  perf expr: increase max other
  perf expr: parse numbers as doubles
  perf expr: debug lex if debugging yaxx
  perf test: add expr test for pmu metrics

 .../arch/x86/cascadelakex/clx-metrics.json    | 10 +-
 .../arch/x86/skylakex/skx-metrics.json        |  4 +-
 tools/perf/tests/builtin-test.c               |  5 +
 tools/perf/tests/expr.c                       | 91 ++++++++++++++++++-
 tools/perf/tests/tests.h                      |  2 +
 tools/perf/util/expr.c                        |  1 +
 tools/perf/util/expr.h                        |  2 +-
 tools/perf/util/expr.l                        | 16 ++--
 tools/perf/util/expr.y                        |  2 +-
 9 files changed, 115 insertions(+), 18 deletions(-)

-- 
2.26.2.303.gf8c07b1a785-goog
