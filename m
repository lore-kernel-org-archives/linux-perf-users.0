From: Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [RFC PATCH 0/3] perf tools: Add support for "report" for some spe events
Date: Fri, 2 Aug 2019 17:40:10 +0800
Message-ID: <1564738813-10944-1-git-send-email-tanxiaojun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, ak@linux.intel.com, adrian.hunter@intel.com, yao.jin@linux.intel.com, tmricht@linux.ibm.com, brueckner@linux.ibm.com, songliubraving@fb.com, gregkh@linuxfoundation.org, kim.phillips@arm.com
Cc: gengdongjiu@huawei.com, wxf.wang@hisilicon.com, liwei391@huawei.com, tanxiaojun@huawei.com, huawei.libin@huawei.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

After the commit ffd3d18c20b8 ("perf tools: Add ARM Statistical
Profiling Extensions (SPE) support") is merged, "perf record" and
"perf report --dump-raw-trace" have been supported. However, the
raw data that is dumped cannot be used without parsing.

This patchset is to improve the "perf report" support for spe, and
further process the data. Currently, support for the three events
of llc-miss, tlb-miss, and branch-miss is added.

More details in [2/3].

Tan Xiaojun (3):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf tools: Add support for "report" for some spe events
  perf report: add --spe options for arm-spe

 tools/perf/Documentation/perf-report.txt           |   9 +
 tools/perf/builtin-report.c                        |   5 +
 tools/perf/util/Build                              |   2 +-
 tools/perf/util/arm-spe-decoder/Build              |   1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  | 214 ++++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |  51 ++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     | 462 +++++++++++++
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  45 ++
 tools/perf/util/arm-spe-pkt-decoder.c              | 462 -------------
 tools/perf/util/arm-spe-pkt-decoder.h              |  43 --
 tools/perf/util/arm-spe.c                          | 717 ++++++++++++++++++++-
 tools/perf/util/auxtrace.c                         |  45 ++
 tools/perf/util/auxtrace.h                         |  27 +
 tools/perf/util/session.h                          |   2 +
 14 files changed, 1544 insertions(+), 541 deletions(-)
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
 delete mode 100644 tools/perf/util/arm-spe-pkt-decoder.c
 delete mode 100644 tools/perf/util/arm-spe-pkt-decoder.h

-- 
2.7.4
