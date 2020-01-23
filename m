From: James Clark <james.clark@arm.com>
Subject: [PATCH v2 0/7] perf tools: Add support for some spe events and precise ip
Date: Thu, 23 Jan 2020 16:07:27 +0000
Message-ID: <20200123160734.3775-1-james.clark@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: suzuki.poulose@arm.com, gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, liuqi115@hisilicon.com, huawei.libin@huawei.com, nd@arm.com, linux-perf-users@vger.kernel.org, James Clark <james.clark@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Tan Xiaojun <tanxiaojun@huawei.com>, Al Grant <al.grant@arm.com>, Namhyung Kim <namhyung@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
Profiling Extensions (SPE) support") was merged, "perf record" and
"perf report --dump-raw-trace" are supported. However, the
raw data that is dumped cannot be used without parsing.

This patchset is to improve the "perf report" support for SPE, and
further process the data. Currently, support for the three events
of llc-miss, tlb-miss, branch-miss and remote-access is added.

The macro definition was modified under Jeremy's suggestion, and
the "event:pp" approach was used under James' suggestion to achieve
the precise ip of some events on arm64. Currently, only branch-misses
are implemented, and other event support will be added later.

In addition, we also found that when recording large multi-threaded
programs, ctrl + c could not end recording, so it was fixed and two
patches were added.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Al Grant <al.grant@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>

James Clark (1):
  perf tools: Unset precise_ip when using SPE

Tan Xiaojun (4):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: Add --spe options for arm-spe
  perf tools: Support "branch-misses:pp" on arm64

Wei Li (2):
  perf tools: add perf_evlist__terminate() for terminate
  perf tools: arm-spe: fix record hang after being terminated

 tools/perf/Documentation/perf-report.txt      |  10 +
 tools/perf/arch/arm64/util/arm-spe.c          |  10 +-
 tools/perf/builtin-record.c                   |   1 +
 tools/perf/builtin-report.c                   |   5 +
 tools/perf/util/Build                         |   2 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 225 +++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  66 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |   2 +
 tools/perf/util/arm-spe.c                     | 789 +++++++++++++++++-
 tools/perf/util/arm-spe.h                     |   3 +
 tools/perf/util/auxtrace.c                    |  49 ++
 tools/perf/util/auxtrace.h                    |  29 +
 tools/perf/util/evlist.c                      |  16 +
 tools/perf/util/evlist.h                      |   1 +
 tools/perf/util/evsel.h                       |   1 +
 tools/perf/util/session.h                     |   2 +
 18 files changed, 1170 insertions(+), 42 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (96%)

-- 
2.25.0
