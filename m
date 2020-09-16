From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools fixes for v5.9: 3rd batch
Date: Wed, 16 Sep 2020 14:44:33 -0300
Message-ID: <20200916174433.1328420-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, David Sharp <dhsharp@google.com>, Henry Burns <henrywolfeburns@gmail.com>, Ian Rogers <irogers@google.com>, Qi Liu <liuqi115@huawei.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.9-2020-09-16

for you to fetch changes up to ce9c13f31b10560d4e4d801f9f94895f595756aa:

  perf stat: Fix the ratio comments of miss-events (2020-09-16 10:54:02 -0300)

Best regards,

- Arnaldo

P.S.: Test results in the signed tag.

----------------------------------------------------------------

perf tools fixes for v5.9: 3rd batch

- Set PERF_SAMPLE_PERIOD if attr->freq is set.

- Remove trailing commas from AMD JSON vendor event files.

- Don't clear event's period if set by a event definition term.

- Leader sampling shouldn't clear sample period in 'perf test'.

- Fix the "signal" test inline assembly when built with DEBUG=1.

- Fix memory leaks detected by ASAN, some in normal paths, some in error
  paths.

- Fix 2 memory sanitizer warnings in 'perf bench'.

- Fix the ratio comments of miss-events in 'perf stat'.

- Prevent override of attr->sample_period for libpfm4 events.

- Sync kvm.h and in.h headers with the kernel sources.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Arnaldo Carvalho de Melo (2):
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers UAPI: update linux/in.h copy

David Sharp (1):
      perf record: Set PERF_RECORD_PERIOD if attr->freq is set.

Henry Burns (1):
      perf vendor events amd: Remove trailing commas

Ian Rogers (3):
      perf bench: Fix 2 memory sanitizer warnings
      perf record: Don't clear event's period if set by a term
      perf test: Leader sampling shouldn't clear sample period

Jiri Olsa (1):
      perf test: Fix the "signal" test inline assembly

Namhyung Kim (10):
      perf test: Free aliases for PMU event map aliases test
      perf metric: Fix some memory leaks
      perf metric: Fix some memory leaks - part 2
      perf evlist: Fix cpu/thread map leak
      perf parse-event: Fix memory leak in evsel->unit
      perf test: Fix memory leaks in parse-metric test
      perf metric: Release expr_parse_ctx after testing
      perf metric: Free metric when it failed to resolve
      perf metric: Do not free metric when failed to resolve
      perf test: Free formats for perf pmu parse test

Qi Liu (1):
      perf stat: Fix the ratio comments of miss-events

Stephane Eranian (1):
      perf record: Prevent override of attr->sample_period for libpfm4 events

 tools/include/uapi/linux/in.h                    |  2 +-
 tools/include/uapi/linux/kvm.h                   |  6 ++--
 tools/perf/bench/sched-messaging.c               |  4 +--
 tools/perf/pmu-events/arch/x86/amdzen1/core.json |  2 +-
 tools/perf/pmu-events/arch/x86/amdzen2/core.json |  2 +-
 tools/perf/tests/attr/README                     |  1 +
 tools/perf/tests/attr/test-record-group2         | 29 ++++++++++++++++++++
 tools/perf/tests/bp_signal.c                     |  5 +++-
 tools/perf/tests/parse-metric.c                  | 14 ++++++----
 tools/perf/tests/pmu-events.c                    |  5 ++++
 tools/perf/tests/pmu.c                           |  1 +
 tools/perf/util/evlist.c                         | 11 ++++++--
 tools/perf/util/evsel.c                          | 10 +++++--
 tools/perf/util/metricgroup.c                    | 35 +++++++++++++++++-------
 tools/perf/util/parse-events.c                   |  2 +-
 tools/perf/util/pmu.c                            | 13 ++++++++-
 tools/perf/util/pmu.h                            |  2 ++
 tools/perf/util/record.c                         | 34 +++++++++++++++++------
 tools/perf/util/stat-shadow.c                    | 28 ++++++++++---------
 19 files changed, 154 insertions(+), 52 deletions(-)
 create mode 100644 tools/perf/tests/attr/test-record-group2
