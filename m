From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/44] perf/core improvements and fixes
Date: Fri, 22 Sep 2017 11:41:36 -0300
Message-ID: <20170922144220.9411-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbdIVOmw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 22 Sep 2017 10:42:52 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Fenghua Yu <fenghua.yu@intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Martin Kepplinger <martink@posteo.de>, Matt Fleming <matt@codeblueprint.co.uk>, Mike Kravetz <mike.kravetz@oracle.com>, Namhyung Kim <namhyung@kernel.org>, Pei P Jia <pei.p.jia@intel.com>, Peter Zijlstra <peterz@infradead.org>, Philip Li <philip.li@intel.com>, Rik van Riel <riel@redhat.com>, Taeung

Hi Ingo,

	Please consider pulling,

- Arnaldo


The following changes since commit b130a699c07155a1d6ef7d971a5f3bf0e3818d5a:

  Merge tag 'perf-urgent-for-mingo-4.14-20170912' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-09-13 09:25:10 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20170922

for you to fetch changes up to 0a7c74eae307894c6c95316c382f118aef8481e8:

  perf tools: Provide mutex wrappers for pthreads rwlocks (2017-09-21 13:28:06 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Support direct --user-regs arguments in 'perf record', previously the
  only way to sample PERF_SAMPLE_REGS_USER was implicitly selecting it
  when recording callchains (Andi Kleen)

- Support showing sampled user regs in 'perf script' (Andi Kleen)

- Introduce the concept of weak groups in 'perf stat': try to set up a
  group, but if it's not schedulable fallback to not using a group. That
  gives us the best of both worlds: groups if they work, but still a
  usable fallback if they don't. E.g: (Andi Kleen)

  % perf stat -e '{branches,branch-misses,l1d.replacement,l2_lines_in.all,l2_rqsts.all_code_rd}:W' -a sleep 1

    125,366,055  branches                                    (80.02%)
      9,208,402  branch-misses       # 7.35% of all branches (80.01%)
     24,560,249  l1d.replacement                             (80.00%)
     43,174,971  l2_lines_in.all                             (80.05%)
     31,891,457  l2_rqsts.all_code_rd                        (79.92%)

- Support metrics in 'stat' and 'list'. A metric is a formula that
  uses multiple events to compute a higher level result (e.g. IPC). (Andi Kleen)

- Add Intel processors vendor event metrics JSON files (Andi Kleen)

- Add 'pid' and 'tid' options to 'perf sched timehist' (David Ahern)

- Generate 'behavior' string table from kernel headers, helps getting
  new parameters when synchronizing kernel headers, like MADV_WIPEONFORK
  and MADV_KEEPONFORK, that are now beautied (Arnaldo Carvalho de Melo)

- Improve TUI progress bar by showing how many bytes from a total were
  processed (Jiri Olsa)

- Use scandir() to replace readdir(), prep work to have the synthesizing
  of PERF_RECORD_ entries for existing threads be multithreaded, making
  'perf top' bearable on high core count systems such as Intel's Knights
  Landing/Mill  (Kan Liang)

- Allow creating a ~/.perfconfig file when setting a variable to its
  default value, previously it would bail out and not write such a
  file (Taeung Song)

- Introduce wrapper for allowing purely single threaded apps to avoid
  the costs of locking (Arnaldo Carvalho de Melo)

- Introduce hashtable to reduce the cost of thread lookup

- Fix build C++ build wrt poison.h using void pointer arithmetic,
  affects only the embedded clang/llvm case, that is disabled by
  default (Arnaldo Carvalho de Melo)

- Fix leaking rec_argv in error cases (Martin Kepplinger)

- Remove Intel CQM perf test, that infrastructure was nuked (Xiaochen Shen)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (27):
      perf tools: Support weak groups in 'perf stat'
      perf vendor events: Support metric_group and no event name in JSON parser
      perf stat: Factor out generic metric printing
      perf stat: Print generic metric header even for failed expressions
      perf pmu: Extract function to get JSON alias map
      perf stat: Support JSON metrics in perf stat
      perf list: Add metric groups to perf list
      perf stat: Don't use ctx for saved values lookup
      perf stat: Support duration_time for metrics
      perf stat: Hide internal duration_time counter
      perf stat: Update walltime_nsecs_stats in interval mode
      perf record: Support direct --user-regs arguments
      perf script: Support user regs
      perf stat: Fall weak group back even for EBADF
      perf vendor events: Add JSON metrics for Broadwell
      perf vendor events: Add JSON metrics for Skylake
      perf vendor events: Add JSON metrics for Sandy Bridge
      perf vendor events: Add JSON metrics for Sandy Bridge EP
      perf vendor events: Add JSON metrics for Ivy Bridge
      perf vendor events: Add JSON metrics for Haswell
      perf vendor events: Add JSON metrics for Ivy Town
      perf vendor events: Add JSON metrics for Haswell EP
      perf vendor events: Add JSON metrics for Broadwell Server
      perf vendor events: Add JSON metrics for Broadwell DE
      perf vendor events: Add JSON metrics for Skylake server
      perf pmu: Improve error messages for missing PMUs
      perf stat: Fix adding multiple event groups

Arnaldo Carvalho de Melo (7):
      perf tools: Make copyfile_offset() static
      perf machine: Optimize a bit the machine__findnew_thread() methods
      perf trace beauty madvise: Generate 'behavior' string table from kernel headers
      tools: Update asm-generic/mman-common.h copy from the kernel
      perf tools: Get all of tools/{arch,include}/ in the MANIFEST
      tools include: Do not use poison with C++
      perf tools: Provide mutex wrappers for pthreads rwlocks

David Ahern (1):
      perf sched timehist: Add pid and tid options

Jiri Olsa (3):
      perf tools: Add python-clean target
      perf ui progress: Add ui specific init function
      perf ui progress: Add size info into progress bar

Kan Liang (2):
      perf tools: Use scandir() to replace readdir()
      perf machine: Use hashtable for machine threads

Martin Kepplinger (1):
      perf tools: Fix leaking rec_argv in error cases

Taeung Song (2):
      perf config: Write a config file just once
      perf config: Allow creating empty config set for config file autogeneration

Xiaochen Shen (1):
      perf tests: Remove Intel CQM perf test

 tools/include/linux/poison.h                       |   5 +
 tools/include/uapi/asm-generic/mman-common.h       |  14 +-
 tools/perf/Documentation/perf-list.txt             |   9 +-
 tools/perf/Documentation/perf-record.txt           |   2 +
 tools/perf/Documentation/perf-sched.txt            |   8 +
 tools/perf/Documentation/perf-script.txt           |   4 +-
 tools/perf/Documentation/perf-stat.txt             |   7 +
 tools/perf/MANIFEST                                |  87 +---
 tools/perf/Makefile.perf                           |  17 +-
 tools/perf/arch/x86/include/arch-tests.h           |   1 -
 tools/perf/arch/x86/tests/Build                    |   1 -
 tools/perf/arch/x86/tests/arch-tests.c             |   4 -
 tools/perf/arch/x86/tests/intel-cqm.c              | 127 ------
 tools/perf/builtin-c2c.c                           |   1 +
 tools/perf/builtin-config.c                        |  22 +-
 tools/perf/builtin-kvm.c                           |   1 -
 tools/perf/builtin-list.c                          |   7 +
 tools/perf/builtin-mem.c                           |   1 +
 tools/perf/builtin-record.c                        |   3 +
 tools/perf/builtin-sched.c                         |   4 +
 tools/perf/builtin-script.c                        |  32 +-
 tools/perf/builtin-stat.c                          |  82 +++-
 tools/perf/builtin-timechart.c                     |   4 +-
 tools/perf/builtin-trace.c                         |  20 +-
 tools/perf/perf.h                                  |   1 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json | 164 +++++++
 .../arch/x86/broadwellde/bdwde-metrics.json        | 164 +++++++
 .../arch/x86/broadwellx/bdx-metrics.json           | 164 +++++++
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   | 158 +++++++
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  | 158 +++++++
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json | 164 +++++++
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   | 164 +++++++
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  | 140 ++++++
 .../arch/x86/sandybridge/snb-metrics.json          | 140 ++++++
 .../pmu-events/arch/x86/skylake/skl-metrics.json   | 164 +++++++
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  | 182 ++++++++
 tools/perf/pmu-events/jevents.c                    |  24 +-
 tools/perf/pmu-events/jevents.h                    |   2 +-
 tools/perf/pmu-events/pmu-events.h                 |   1 +
 tools/perf/tests/builtin-test.c                    |   1 +
 tools/perf/trace/beauty/madvise_behavior.sh        |  10 +
 tools/perf/trace/beauty/mmap.c                     |  38 +-
 tools/perf/ui/progress.c                           |   6 +-
 tools/perf/ui/progress.h                           |  12 +-
 tools/perf/ui/tui/progress.c                       |  32 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/config.c                           |   5 +-
 tools/perf/util/data.c                             |   1 +
 tools/perf/util/dso.c                              |  13 +-
 tools/perf/util/dso.h                              |   4 +-
 tools/perf/util/event.c                            |  46 +-
 tools/perf/util/evlist.h                           |   1 +
 tools/perf/util/evsel.c                            |   7 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/machine.c                          | 155 ++++---
 tools/perf/util/machine.h                          |  24 +-
 tools/perf/util/map.c                              |  34 +-
 tools/perf/util/map.h                              |   3 +-
 tools/perf/util/metricgroup.c                      | 490 +++++++++++++++++++++
 tools/perf/util/metricgroup.h                      |  31 ++
 tools/perf/util/namespaces.c                       |   1 +
 tools/perf/util/parse-events.c                     |  29 +-
 tools/perf/util/parse-events.h                     |   3 +
 tools/perf/util/parse-events.l                     |   3 +-
 tools/perf/util/pmu.c                              |  55 ++-
 tools/perf/util/pmu.h                              |   2 +
 tools/perf/util/probe-file.c                       |   1 +
 tools/perf/util/rb_resort.h                        |   5 +-
 tools/perf/util/rwsem.c                            |  32 ++
 tools/perf/util/rwsem.h                            |  19 +
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/stat-shadow.c                      | 110 +++--
 tools/perf/util/stat.h                             |   4 +-
 tools/perf/util/symbol.c                           |   8 +-
 tools/perf/util/thread.c                           |   4 +-
 tools/perf/util/trace-event-info.c                 |   1 -
 tools/perf/util/trace-event-read.c                 |   1 -
 tools/perf/util/util.c                             |  16 +-
 tools/perf/util/util.h                             |   7 +-
 tools/perf/util/vdso.c                             |   4 +-
 tools/perf/util/zlib.c                             |   1 +
 81 files changed, 2988 insertions(+), 489 deletions(-)
 delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/bdw-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/bdwde-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/bdx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/hsw-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/hsx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/ivb-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/ivt-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/jkt-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/snb-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/skl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
 create mode 100755 tools/perf/trace/beauty/madvise_behavior.sh
 create mode 100644 tools/perf/util/metricgroup.c
 create mode 100644 tools/perf/util/metricgroup.h
 create mode 100644 tools/perf/util/rwsem.c
 create mode 100644 tools/perf/util/rwsem.h
