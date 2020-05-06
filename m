From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf/core improvements and fixes
Date: Wed,  6 May 2020 12:21:03 -0300
Message-ID: <20200506152234.21977-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>, He Zhe <zhe.he@windriver.com>, Hulk Robot <hulkci@huawei.com>, Ian Rogers <irogers@google.com>, Jagadeesh Pagadala <jagdsh.linux@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Stephane Eranian <eranian@google.com>, Thomas Backlund <tmb@mageia.org>Thomas
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 87cfeb1920f84f465a738d4c6589033eefa20b45:

  Merge tag 'perf-core-for-mingo-5.8-20200420' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2020-04-22 14:08:28 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.8-20200506

for you to fetch changes up to 19ce2321739da5fc27f6a5ed1e1cb15e384ad030:

  perf flamegraph: Use /bin/bash for report and record scripts (2020-05-05 16:35:32 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf record:

  - Introduce --switch-output-event to use arbitrary events to be setup
    and read from a side band thread and, when they take place a signal
    be sent to the main 'perf record' thread, reusing the --switch-output
    code to take perf.data snapshots from the --overwrite ring buffer, e.g.:

	# perf record --overwrite -e sched:* \
		      --switch-output-event syscalls:*connect* \
		      workload

    will take perf.data.YYYYMMDDHHMMSS snapshots up to around the
    connect syscalls.

  Stephane Eranian:

  - Add --num-synthesize-threads option to control degree of parallelism of the
    synthesize_mmap() code which is scanning /proc/PID/task/PID/maps and can be
    time consuming. This mimics pre-existing behaviour in 'perf top'.

Intel PT:

  Adrian Hunter:

  - Add support for synthesizing branch stacks for regular events (cycles,
    instructions, etc) from Intel PT data.

perf bench:

  Ian Rogers:

  - Add a multi-threaded synthesize benchmark.

  - Add kallsyms parsing benchmark.

  Tommi Rantala:

  - Fix div-by-zero if runtime is zero.

perf synthetic events:

  - Remove use of sscanf from /proc reading when parsing pre-existing
    threads to generate synthetic PERF_RECORD_{FORK,MMAP,COMM,etc} events.

tools api:

  - Add a lightweight buffered reading API.

libsymbols:

  - Parse kallsyms using new lightweight buffered reading io API.

perf parse-events:

  - Fix memory leaks found on parse_events.

perf mem2node:

  - Avoid double free related to realloc().

perf stat:

  Jin Yao:

  - Zero all the 'ena' and 'run' array slot stats for interval mode.

  - Improve runtime stat for interval mode

  Kajol Jain:

  - Enable Hz/hz printing for --metric-only option

  - Enhance JSON/metric infrastructure to handle "?".

perf tests:

  Kajol Jain:

  - Added test for runtime param in metric expression.

  Tommi Rantala:

  - Fix data path in the session topology test.

perf vendor events power9:

  Kajol Jain:

 - Add hv_24x7 socket/chip level metric events

Coresight:

  Leo Yan:

  - Move definition of 'traceid_list' global variable from header file.

  Mike Leach:

  - Update to build with latest opencsd version.

perf pmu:

  Shaokun Zhang:

  - Fix function name in comment, its get_cpuid_str(), not get_cpustr()

  Stephane Eranian:

  - Add perf_pmu__find_by_type() helper

perf script:

  Stephane Eranian:

  - Remove extraneous newline in perf_sample__fprintf_regs().

  Ian Rogers:

  - Avoid NULL dereference on symbol.

tools feature:

  Stephane Eranian:

  - Add support for detecting libpfm4.

perf symbol:

  Thomas Richter:

  - Fix kernel symbol address display in TUI verbose mode.

perf cgroup:

  Tommi Rantala:

  - Avoid needless closing of unopened fd

libperf:

  He Zhe:

  - Add NULL pointer check for cpu_map iteration and NULL
    assignment for all_cpus.

  Ian Rogers:

  - Fix a refcount leak in evlist method.

  Arnaldo Carvalho de Melo:

  - Rename the code in tools/perf/util, i.e. perf tooling specific, that
    operates on 'struct evsel' to evsel__, leaving the perf_evsel__
    namespace for the routines in tools/lib/perf/ that operate on
    'struct perf_evsel__'.

tools/perf specific libraries:

  Konstantin Khlebnikov:

  - Fix reading new topology attribute "core_cpus"

  - Simplify checking if SMT is active.

perf flamegraph:

  Arnaldo Carvalho de Melo:

  - Use /bin/bash for report and record scripts, just like all other
    such scripts, fixing a package dependency bug in a Linaro
    OpenEmbedded build checker.

perf evlist:

  Jagadeesh Pagadala:

  - Remove duplicate headers.

Miscelaneous:

  Zou Wei:

  - Remove unneeded semicolon in libtraceevent, 'perf c2c' and others.

  - Fix warning assignment of 0/1 to bool variable in 'perf report'

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf thread-stack: Add branch stack support
      perf intel-pt: Consolidate thread-stack use condition
      perf intel-pt: Change branch stack support to use thread-stacks
      perf auxtrace: Add option to synthesize branch stack for regular events
      perf evsel: Add support for synthesized branch stack sample type
      perf thread-stack: Add thread_stack__br_sample_late()
      perf intel-pt: Add support for synthesizing branch stacks for regular events
      perf intel-pt: Update documentation about itrace G and L options
      perf intel-pt: Update documentation about using /proc/kcore

Arnaldo Carvalho de Melo (44):
      perf tools: Move routines that probe for perf API features to separate file
      perf record: Move sb_evlist to 'struct record'
      perf top: Move sb_evlist to 'struct perf_top'
      perf bpf: Decouple creating the evlist from adding the SB event
      perf parse-events: Add parse_events_option() variant that creates evlist
      perf evlist: Move the sideband thread routines to separate object
      perf evlist: Allow reusing the side band thread for more purposes
      libsubcmd: Introduce OPT_CALLBACK_SET()
      perf record: Introduce --switch-output-event
      perf record: Move side band evlist setup to separate routine
      perf evsel: Rename 'struct perf_evsel__sb_cb_t' to 'struct evsel__sb_cb_t'
      perf evsel: Rename perf_evsel__nr_cpus() to evsel__nr_cpus()
      perf evsel: Rename perf_evsel__compute_deltas() to evsel__compute_deltas()
      perf evsel: Rename perf_evsel__find_pmu() to evsel__find_pmu()
      perf evsel: Rename perf_evsel__is_aux_event() to evsel__is_aux_event()
      perf evsel: Rename perf_evsel__exit() to evsel__exit()
      perf evsel: Rename perf_evsel__config*() to evsel__config*()
      perf evsel: Rename perf_evsel__calc_id_pos() to evsel__calc_id_pos()
      perf evsel: Rename __perf_evsel__sample_size() to __evsel__sample_size()
      perf evsel: Rename *perf_evsel__*name() to *evsel__*name()
      perf evsel: Rename perf_evsel__group_desc() to evsel__group_desc()
      perf evsel: Rename *perf_evsel__*set_sample_*() to *evsel__*set_sample_*()
      perf evsel: Rename perf_evsel__*filter*() to evsel__*filter*()
      perf evsel: Rename perf_evsel__open_per_*() to evsel__open_per_*()
      perf evsel: Rename perf_evsel__{str,int}val() and other tracepoint field metehods to to evsel__*()
      perf evsel: Rename perf_evsel__is_*() to evsel__is*()
      perf evsel: Ditch perf_evsel__cmp(), not used for quite a while
      perf evsel: Rename *perf_evsel__read*() to *evsel__read()
      perf evsel: Rename perf_evsel__parse_sample*() to evsel__parse_sample*()
      perf evsel: Rename perf_evsel__{prev,next}() to evsel__{prev,next}()
      perf evsel: Rename perf_evsel__has*() to evsel__has*()
      perf evsel: Rename perf_evsel__fallback() to evsel__fallback()
      perf evsel: Rename perf_evsel__group_idx() to evsel__group_idx()
      perf evsel: Rename perf_evsel__env() to evsel__env()
      perf evsel: Rename perf_evsel__store_ids() to evsel__store_id()
      perf stat: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf kmem: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf lock: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf sched: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf script: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf trace: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf annotate: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf inject: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()
      perf flamegraph: Use /bin/bash for report and record scripts

He Zhe (1):
      libperf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.

Ian Rogers (13):
      perf script: Avoid NULL dereference on symbol
      perf bench: Add a multi-threaded synthesize benchmark
      tools api: Add a lightweight buffered reading api
      perf synthetic events: Remove use of sscanf from /proc reading
      perf parse-events: Fix memory leaks found on parse_events
      perf parse-events: Fix memory leaks found on parse_events
      perf parse-events: Fix another memory leaks found on parse_events()
      libperf evlist: Fix a refcount leak
      perf mem2node: Avoid double free related to realloc
      perf doc: Pass ASCIIDOC_EXTRA as an argument
      perf bench: Add kallsyms parsing
      libsymbols kallsyms: Parse using io api
      libsymbols kallsyms: Move hex2u64 out of header

Jagadeesh Pagadala (1):
      perf evlist: Remove duplicate headers

Jin Yao (2):
      perf stat: Zero all the 'ena' and 'run' array slot stats for interval mode
      perf stat: Improve runtime stat for interval mode

Kajol Jain (4):
      perf metricgroups: Enhance JSON/metric infrastructure to handle "?"
      perf tests expr: Added test for runtime param in metric expression
      perf tools: Enable Hz/hz prinitg for --metric-only option
      perf vendor events power9: Add hv_24x7 socket/chip level metric events

Konstantin Khlebnikov (2):
      perf tools: Fix reading new topology attribute "core_cpus"
      perf tools: Simplify checking if SMT is active.

Leo Yan (1):
      perf cs-etm: Move definition of 'traceid_list' global variable from header file

Mike Leach (1):
      perf: cs-etm: Update to build with latest opencsd version.

Shaokun Zhang (1):
      perf pmu: Fix function name in comment, its get_cpuid_str(), not get_cpustr()

Stephane Eranian (4):
      perf record: Add num-synthesize-threads option
      perf script: Remove extraneous newline in perf_sample__fprintf_regs()
      tools feature: Add support for detecting libpfm4
      perf pmu: Add perf_pmu__find_by_type helper

Thomas Richter (1):
      perf symbol: Fix kernel symbol address display

Tommi Rantala (3):
      perf cgroup: Avoid needless closing of unopened fd
      perf bench: Fix div-by-zero if runtime is zero
      perf test session topology: Fix data path

Zou Wei (4):
      libtraceevent: Remove unneeded semicolon
      perf c2c: Remove unneeded semicolon
      perf tools: Remove unneeded semicolons
      perf report: Fix warning assignment of 0/1 to bool variable

 tools/build/Makefile.feature                       |   3 +-
 tools/build/feature/Makefile                       |   6 +-
 tools/build/feature/test-libopencsd.c              |   4 +-
 tools/build/feature/test-libpfm4.c                 |   9 +
 tools/lib/api/io.h                                 | 115 ++++++++
 tools/lib/perf/cpumap.c                            |   2 +-
 tools/lib/perf/evlist.c                            |   4 +-
 tools/lib/subcmd/parse-options.h                   |   2 +
 tools/lib/symbol/kallsyms.c                        |  86 +++---
 tools/lib/symbol/kallsyms.h                        |   2 -
 tools/lib/traceevent/kbuffer-parse.c               |   2 +-
 tools/perf/Documentation/itrace.txt                |   5 +
 tools/perf/Documentation/perf-intel-pt.txt         |  53 +++-
 tools/perf/Documentation/perf-record.txt           |  17 ++
 tools/perf/Documentation/perf-stat.txt             |   2 +
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
 tools/perf/arch/arm64/util/arm-spe.c               |  12 +-
 tools/perf/arch/powerpc/util/header.c              |   8 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +-
 tools/perf/arch/s390/util/kvm-stat.c               |   8 +-
 tools/perf/arch/x86/tests/perf-time-to-tsc.c       |   6 +-
 tools/perf/arch/x86/util/intel-bts.c               |   2 +-
 tools/perf/arch/x86/util/intel-pt.c                |  21 +-
 tools/perf/arch/x86/util/kvm-stat.c                |  12 +-
 tools/perf/bench/Build                             |   1 +
 tools/perf/bench/bench.h                           |   1 +
 tools/perf/bench/epoll-wait.c                      |   3 +-
 tools/perf/bench/futex-hash.c                      |   3 +-
 tools/perf/bench/futex-lock-pi.c                   |   3 +-
 tools/perf/bench/kallsyms-parse.c                  |  75 +++++
 tools/perf/bench/synthesize.c                      | 211 ++++++++++++--
 tools/perf/builtin-annotate.c                      |  15 +-
 tools/perf/builtin-bench.c                         |   1 +
 tools/perf/builtin-c2c.c                           |   9 +-
 tools/perf/builtin-diff.c                          |   8 +-
 tools/perf/builtin-inject.c                        |  19 +-
 tools/perf/builtin-kmem.c                          |  65 ++---
 tools/perf/builtin-kvm.c                           |  23 +-
 tools/perf/builtin-lock.c                          |  42 ++-
 tools/perf/builtin-mem.c                           |   2 +-
 tools/perf/builtin-record.c                        | 117 ++++++--
 tools/perf/builtin-report.c                        |  21 +-
 tools/perf/builtin-sched.c                         |  78 +++---
 tools/perf/builtin-script.c                        |  73 ++---
 tools/perf/builtin-stat.c                          |  31 +--
 tools/perf/builtin-timechart.c                     |  52 ++--
 tools/perf/builtin-top.c                           |  36 ++-
 tools/perf/builtin-trace.c                         | 115 ++++----
 .../arch/powerpc/power9/nest_metrics.json          |  19 ++
 tools/perf/pmu-events/pmu-events.h                 |   2 +-
 tools/perf/scripts/python/bin/flamegraph-record    |   2 +-
 tools/perf/scripts/python/bin/flamegraph-report    |   2 +-
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/api-io.c                          | 304 ++++++++++++++++++++
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/event-times.c                     |   8 +-
 tools/perf/tests/event_update.c                    |   2 +-
 tools/perf/tests/evsel-roundtrip-name.c            |  20 +-
 tools/perf/tests/evsel-tp-sched.c                  |   2 +-
 tools/perf/tests/expr.c                            |  16 +-
 tools/perf/tests/hists_cumulate.c                  |   8 +-
 tools/perf/tests/mmap-basic.c                      |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   6 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   6 +-
 tools/perf/tests/openat-syscall.c                  |   8 +-
 tools/perf/tests/parse-events.c                    | 138 ++++-----
 tools/perf/tests/perf-record.c                     |   6 +-
 tools/perf/tests/sample-parsing.c                  |   6 +-
 tools/perf/tests/switch-tracking.c                 |  14 +-
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/tests/topology.c                        |  12 +-
 tools/perf/ui/browsers/hists.c                     |  18 +-
 tools/perf/ui/gtk/annotate.c                       |   2 +-
 tools/perf/ui/gtk/hists.c                          |   6 +-
 tools/perf/ui/hist.c                               |  16 +-
 tools/perf/util/Build                              |   2 +
 tools/perf/util/annotate.c                         |  20 +-
 tools/perf/util/auxtrace.c                         |  33 ++-
 tools/perf/util/auxtrace.h                         |   2 +
 tools/perf/util/bpf-event.c                        |   3 +-
 tools/perf/util/bpf-event.h                        |   7 +-
 tools/perf/util/bpf-loader.c                       |   2 +-
 tools/perf/util/cgroup.c                           |   3 +-
 tools/perf/util/cloexec.c                          |   2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   2 +
 tools/perf/util/cs-etm.c                           |   3 +
 tools/perf/util/cs-etm.h                           |   3 -
 tools/perf/util/data-convert-bt.c                  |   6 +-
 tools/perf/util/event.c                            |   2 +-
 tools/perf/util/evlist.c                           | 153 +---------
 tools/perf/util/evlist.h                           |   9 +-
 tools/perf/util/evsel.c                            | 308 ++++++++++-----------
 tools/perf/util/evsel.h                            | 180 ++++++------
 tools/perf/util/evsel_config.h                     |   2 +-
 tools/perf/util/evsel_fprintf.c                    |   8 +-
 tools/perf/util/expr.c                             |  11 +-
 tools/perf/util/expr.h                             |   5 +-
 tools/perf/util/expr.l                             |  27 +-
 tools/perf/util/header.c                           |  13 +-
 tools/perf/util/hist.c                             |   8 +-
 tools/perf/util/intel-bts.c                        |   6 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   2 +-
 tools/perf/util/intel-pt.c                         | 215 +++++++-------
 tools/perf/util/machine.c                          |   4 +-
 tools/perf/util/mem2node.c                         |   3 +-
 tools/perf/util/metricgroup.c                      |  28 +-
 tools/perf/util/metricgroup.h                      |   2 +
 tools/perf/util/ordered-events.c                   |   2 +-
 tools/perf/util/parse-events.c                     |  39 ++-
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/parse-events.y                     |   3 +-
 tools/perf/util/perf_api_probe.c                   | 164 +++++++++++
 tools/perf/util/perf_api_probe.h                   |  14 +
 tools/perf/util/pmu.c                              |  17 +-
 tools/perf/util/pmu.h                              |   1 +
 tools/perf/util/python.c                           |   4 +-
 tools/perf/util/record.c                           | 173 +-----------
 tools/perf/util/record.h                           |   1 +
 tools/perf/util/s390-cpumsf.c                      |   3 +-
 .../util/scripting-engines/trace-event-python.c    |   6 +-
 tools/perf/util/session.c                          |   9 +-
 tools/perf/util/sideband_evlist.c                  | 148 ++++++++++
 tools/perf/util/smt.c                              |  10 +-
 tools/perf/util/sort.c                             |  10 +-
 tools/perf/util/stat-display.c                     |  23 +-
 tools/perf/util/stat-shadow.c                      |  53 ++--
 tools/perf/util/stat.c                             |  24 +-
 tools/perf/util/symbol.c                           |  14 +
 tools/perf/util/synthetic-events.c                 | 159 +++++++----
 tools/perf/util/thread-stack.c                     | 217 ++++++++++++++-
 tools/perf/util/thread-stack.h                     |   8 +-
 tools/perf/util/top.c                              |   2 +-
 tools/perf/util/top.h                              |   2 +-
 tools/perf/util/trace-event-read.c                 |   2 +-
 135 files changed, 2699 insertions(+), 1517 deletions(-)
 create mode 100644 tools/build/feature/test-libpfm4.c
 create mode 100644 tools/lib/api/io.h
 create mode 100644 tools/perf/bench/kallsyms-parse.c
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power9/nest_metrics.json
 create mode 100644 tools/perf/tests/api-io.c
 create mode 100644 tools/perf/util/perf_api_probe.c
 create mode 100644 tools/perf/util/perf_api_probe.h
 create mode 100644 tools/perf/util/sideband_evlist.c

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

Ubuntu 19.10 and debian experimental are failing when linking against
libllvm, which isn't the default, needs to be investigated, haven't
tested with CC=gcc, but should be the same problem:

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBCLANGLLVM=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang

...
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_ignoringImpCasts0Matcher::matches(clang::Expr const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x43): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_hasLoopVariable0Matcher::matches(clang::CXXForRangeStmt const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x48): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
...

  It builds ok with the default set of options.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.7.0-rc2.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:3.11                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.1 (git://git.alpinelinux.org/aports 7c78441134e54efbb34618f457d88c783c913361) (based on LLVM 9.0.1)
  10 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
  11 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.3.1 20190507 (ALT p9 8.3.1-alt5), clang version 7.0.1 
  12 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.2.1 20190827 (ALT Sisyphus 9.2.1-alt2), clang version 7.0.1 
  13 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  14 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  15 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  16 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  18 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  20 centos:8                      : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.3.1 20200501 releases/gcc-9.3.0-196-gcb2c76c8b1, clang version 10.0.0 
  22 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25 debian:experimental           : FAIL gcc (Debian 9.3.0-11) 9.3.0, clang version 9.0.1-12 
  26 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 9.3.0-8) 9.3.0
  27 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.3.0-8) 9.3.0
  29 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
  30 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  31 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  32 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  33 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  34 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  35 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  36 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  37 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  38 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  39 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  42 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  43 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.1 (Fedora 9.0.1-2.fc31)
  44 fedora:32                     : Ok   gcc (GCC) 10.0.1 20200430 (Red Hat 10.0.1-0.13), clang version 10.0.0 (Fedora 10.0.0-1.fc32)
  45 fedora:rawhide                : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.3.rc2.fc33)
  46 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  47 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  48 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  49 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  50 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  51 openmandriva:cooker           : Ok   gcc (GCC) 10.0.0 20200216 (OpenMandriva), clang version 10.0.0 
  52 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  56 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d], clang version 9.0.1 
  57 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  58 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  59 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4.5.0.7), clang version 8.0.1 (Red Hat 8.0.1-1.0.1.module+el8.1.0+5428+345cee14)
  60 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  61 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  62 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  63 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  67 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  68 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  69 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  70 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  71 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  72 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  73 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  76 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  77 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  78 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  79 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  80 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  81 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  82 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  83 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  84 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  85 ubuntu:19.10                  : FAIL gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  86 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-8ubuntu1) 9.3.0, clang version 10.0.0-1ubuntu1 
  #


  # uname -a
  Linux five 5.5.17-200.fc31.x86_64 #1 SMP Mon Apr 13 15:29:42 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  19ce2321739d perf flamegraph: Use /bin/bash for report and record scripts
  # perf version --build-options
  perf version 5.7.rc2.g19ce2321739d
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Test data source output                               : Ok
   6: Parse event definition strings                        : Ok
   7: Simple expression parser                              : Ok
   8: PERF_RECORD_* events & perf_sample fields             : Ok
   9: Parse perf pmu format                                 : Ok
  10: PMU events                                            : Ok
  11: DSO data read                                         : Ok
  12: DSO data cache                                        : Ok
  13: DSO data reopen                                       : Ok
  14: Roundtrip evsel->name                                 : Ok
  15: Parse sched tracepoints fields                        : Ok
  16: syscalls:sys_enter_openat event fields                : Ok
  17: Setup struct perf_event_attr                          : Ok
  18: Match and link multiple hists                         : Ok
  19: 'import perf' in python                               : Ok
  20: Breakpoint overflow signal handler                    : Ok
  21: Breakpoint overflow sampling                          : Ok
  22: Breakpoint accounting                                 : Ok
  23: Watchpoint                                            :
  23.1: Read Only Watchpoint                                : Skip
  23.2: Write Only Watchpoint                               : Ok
  23.3: Read / Write Watchpoint                             : Ok
  23.4: Modify Watchpoint                                   : Ok
  24: Number of exit events of a simple workload            : Ok
  25: Software clock events period values                   : Ok
  26: Object code reading                                   : Ok
  27: Sample parsing                                        : Ok
  28: Use a dummy software event to keep tracking           : Ok
  29: Parse with no sample_id_all bit set                   : Ok
  30: Filter hist entries                                   : Ok
  31: Lookup mmap thread                                    : Ok
  32: Share thread maps                                     : Ok
  33: Sort output of hist entries                           : Ok
  34: Cumulate child hist entries                           : Ok
  35: Track with sched_switch                               : Ok
  36: Filter fds with revents mask in a fdarray             : Ok
  37: Add fd to a fdarray, making it autogrow               : Ok
  38: kmod_path__parse                                      : Ok
  39: Thread map                                            : Ok
  40: LLVM search and compile                               :
  40.1: Basic BPF llvm compile                              : Ok
  40.2: kbuild searching                                    : Ok
  40.3: Compile source for BPF prologue generation          : Ok
  40.4: Compile source for BPF relocation                   : Ok
  41: Session topology                                      : Ok
  42: BPF filter                                            :
  42.1: Basic BPF filtering                                 : Ok
  42.2: BPF pinning                                         : Ok
  42.3: BPF prologue generation                             : Ok
  42.4: BPF relocation checker                              : Ok
  43: Synthesize thread map                                 : Ok
  44: Remove thread map                                     : Ok
  45: Synthesize cpu map                                    : Ok
  46: Synthesize stat config                                : Ok
  47: Synthesize stat                                       : Ok
  48: Synthesize stat round                                 : Ok
  49: Synthesize attr update                                : Ok
  50: Event times                                           : Ok
  51: Read backward ring buffer                             : Ok
  52: Print cpu map                                         : Ok
  53: Merge cpu map                                         : Ok
  54: Probe SDT events                                      : Ok
  55: is_printable_array                                    : Ok
  56: Print bitmap                                          : Ok
  57: perf hooks                                            : Ok
  58: builtin clang support                                 : Skip (not compiled in)
  59: unit_number__scnprintf                                : Ok
  60: mem2node                                              : Ok
  61: time utils                                            : Ok
  62: Test jit_write_elf                                    : Ok
  63: Test api io                                           : Ok
  64: maps__merge_in                                        : Ok
  65: x86 rdpmc                                             : Ok
  66: Convert perf time to TSC                              : Ok
  67: DWARF unwind                                          : Ok
  68: x86 instruction decoder - new instructions            : Ok
  69: Intel PT packet decoder                               : Ok
  70: x86 bp modify                                         : Ok
  71: probe libc's inet_pton & backtrace it with ping       : Ok
  72: Use vfs_getname probe to get syscall args filenames   : Ok
  73: Check open filename arg using perf trace + vfs_getname: Ok
  74: Zstd perf.data compression/decompression              : Ok
  75: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_no_gtk2_O: make NO_GTK2=1
              make_clean_all_O: make clean all
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_perf_o_O: make perf.o
                  make_debug_O: make DEBUG=1
                    make_doc_O: make doc
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
            make_no_demangle_O: make NO_DEMANGLE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
            make_install_bin_O: make install-bin
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                   make_pure_O: make
              make_no_libelf_O: make NO_LIBELF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
               make_no_slang_O: make NO_SLANG=1
             make_util_map_o_O: make util/map.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_no_newt_O: make NO_NEWT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_help_O: make help
        make_with_babeltrace_O: make LIBBABELTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
