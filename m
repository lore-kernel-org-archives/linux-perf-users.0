From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools changes for v5.9
Date: Mon, 10 Aug 2020 13:16:18 -0300
Message-ID: <20200810161618.5768-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andi Kleen <andi@firstfloor.org>, Davidlohr Bueso <dbueso@suse.de>, Ian Rogers <irogers@google.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Yan <yanaijie@huawei.com>, Jin Yao <yao.jin@linux.intel.com>, Johannes Berg <johannes@sipsolutions.net>, John Garry <john.garry@huawei.com>, Julia Cartwright <julia@ni.com>, Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit 47ec5303d73ea344e84f46660fff693c57641386:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2020-08-05 20:13:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-08-10

for you to fetch changes up to 1101c872c8c7869c78dc106ae820040f36807eda:

  perf record: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set (2020-08-07 09:27:03 -0300)

----------------------------------------------------------------
perf tools changes for v5.9

New features:

- Introduce controlling how 'perf stat' and 'perf record' works via a
  control file descriptor, allowing starting with events configured but
  disabled until commands are received via the control file descriptor.
  This allows, for instance for tools such as Intel VTune to make further
  use of perf as its Linux platform driver.

- Improve 'perf record' to to register in a perf.data file header the clockid
  used to help later correlate things like syslog files and perf events
  recorded.

- Add basic syscall and find_next_bit benchmarks to 'perf bench'.

- Allow using computed metrics in calculating other metrics. For instance:

  {
    .metric_expr    = "l2_rqsts.demand_data_rd_hit + l2_rqsts.pf_hit + l2_rqsts.rfo_hit",
    .metric_name    = "DCache_L2_All_Hits",
  },
  {
    .metric_expr    = "max(l2_rqsts.all_demand_data_rd - l2_rqsts.demand_data_rd_hit, 0) + l2_rqsts.pf_miss + l2_rqsts.rfo_miss",
    .metric_name    = "DCache_L2_All_Miss",
  },
  {
     .metric_expr    = "dcache_l2_all_hits + dcache_l2_all_miss",
     .metric_name    = "DCache_L2_All",
  }

- Add suport for 'd_ratio', '>' and '<' operators to the expression resolver used
  in calculating metrics in 'perf stat'.

Support for new kernel features:

- Support TEXT_POKE and KSYMBOL_TYPE_OOL perf metadata events to cope with
  things like ftrace, trampolines, i.e. changes in the kernel text that gets
  in the way of properly decoding Intel PT hardware traces, for instance.

Intel PT:

- Add various knobs to reduce the volume of Intel PT traces by reducing the
  level of details such as decoding just some types of packets (e.g., FUP/TIP,
  PSB+), also filtering by time range.

- Add new itrace options (log flags to the 'd' option, error flags to the 'e'
  one, etc), controlling how Intel PT is transformed into perf events, document
  some missing options (e.g., how to synthesize callchains).

BPF:

- Properly report BPF errors when parsing events.

- Do not setup side-band events if LIBBPF is not linked, fixing a segfault.

Libraries:

- Improvements on the libtraceevent plugin mechanism.

- Improve libtracevent support for KVM trace events SVM exit reasons.

- Add a libtracevent plugins for decoding syscalls/sys_enter_futex and for tlb_flush.

- Ensure sample_period is set libpfm4 events in 'perf test'.

- Fixup libperf namespacing, to make sure what is in libperf has the perf_
  namespace while what is now only in tools/perf/ doesn't use that prefix.

Arch specific:

- Improve the testing of vendor events and metrics in 'perf test'.

- Allow no ARM CoreSight hardware tracer sink to be specified on command line.

- Fix arm_spe_x recording when mixed with other perf events.

- Add s390 idle functions 'psw_idle' and 'psw_idle_exit' to list of idle symbols.

- List kernel supplied event aliases for arm64 in 'perf list'.

- Add support for extended register capability in PowerPC 9 and 10.

- Added nest IMC power9 metric events.

Miscellaneous:

- No need to setup sample_regs_intr/sample_regs_user for dummy events.

- Update various copies of kernel headers, some causing perf to handle new
  syscalls, MSRs, etc.

- Improve usage of flex and yacc, enabling warnings and addressing the fallout.

- Add missing '--output' option to 'perf kmem' so that it can pass it along to 'perf record'.

- 'perf probe' fixes related to adding multiple probes on the same address for
  the same event.

- Make 'perf probe' warn if the target function is a GNU indirect function.

- Remove //anon mmap events from 'perf inject jit' to fix supporting both using
  ELF files for generated functions and the perf-PID.map approaches.

Adrian Hunter (17):
      perf tools: Add support for PERF_RECORD_TEXT_POKE
      perf tools: Add support for PERF_RECORD_KSYMBOL_TYPE_OOL
      perf intel-pt: Add support for text poke events
      perf script: Add option --show-text-poke-events
      perf script: Show text poke address symbol
      perf intel-pt: Fix FUP packet state
      perf intel-pt: Fix duplicate branch after CBR
      perf tools: Improve aux_output not supported error
      perf auxtrace: Add missing itrace options to help text
      perf auxtrace: Add optional error flags to the itrace 'e' option
      perf intel-pt: Use itrace error flags to suppress some errors
      perf auxtrace: Add optional log flags to the itrace 'd' option
      perf intel-pt: Use itrace debug log flags to suppress some messages
      perf intel-pt: Time filter logged perf events
      perf auxtrace: Add itrace 'q' option for quicker, less detailed decoding
      perf intel-pt: Add support for decoding FUP/TIP only
      perf intel-pt: Add support for decoding PSB+ only

Alexey Budankov (16):
      libperf: Avoid internal moving of fdarray fds
      libperf: Add flags to fdarray fds objects
      libperf: Avoid counting of nonfilterable fdarray fds
      perf evlist: Introduce control file descriptors
      perf evlist: Implement control command handling functions
      perf stat: Factor out body of event handling loop for system wide
      perf stat: Move target check to loop control statement
      perf stat: Factor out body of event handling loop for fork case
      perf stat: Factor out event handling loop into dispatch_events()
      perf stat: extend -D,--delay option with -1 value
      perf stat: Implement control commands handling
      perf stat: Introduce --control fd:ctl-fd[,ack-fd] options
      perf record: Extend -D,--delay option with -1 value
      perf record: Implement control commands handling
      perf record: Introduce --control fd:ctl-fd[,ack-fd] options
      perf evsel: Extend message to mention CAP_SYS_PTRACE and perf security doc link

Anju T Sudhakar (1):
      perf tools powerpc: Add support for extended register capability

Arnaldo Carvalho de Melo (17):
      perf parse: Provide a way to pass a fake_pmu to parse_events()
      perf pmu: Add a perf_pmu__fake object to use with __parse_events()
      perf script: Fixup some evsel/evlist method names
      perf evlist: Fix the class prefix for 'struct evlist' 'add' evsel methods
      perf evlist: Fix the class prefix for 'struct evlist' strerror methods
      perf evlist: Fix the class prefix for 'struct evlist' sample_type methods
      perf evlist: Fix the class prefix for 'struct evlist' sample_id_all methods
      perf evlist: Fix the class prefix for 'struct evlist' branch_type methods
      perf expr: Add missing headers noticed when building with NO_LIBBPF=1
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Mgerge remote-tracking branch 'torvalds/master' into perf/core
      tools headers API: Update close_range affected files
      tools headers UAPI: update linux/in.h copy
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools arch x86: Sync asm/cpufeatures.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources

Athira Rajeev (1):
      perf tools powerpc: Add support for extended regs in power10

Davidlohr Bueso (1):
      perf bench: Add basic syscall benchmark

Ian Rogers (14):
      perf expr: Add d_ratio operation
      perf expr: Add < and > operators
      perf parse-events: Use automatic variable for flex input
      perf parse-events: Use automatic variable for yacc input
      perf pmu: Add bison debug build flag
      perf pmu: Add flex debug build flag
      perf parse-events: Declare flex header file output
      perf parse-events: Declare bison header file output
      perf parse-events: Disable a subset of flex warnings
      perf parse-events: Disable a subset of bison warnings
      perf parse-events: Report BPF errors
      perf kmem: Pass additional arguments to 'perf record'
      perf test: Ensure sample_period is set libpfm4 events
      perf bench: Add benchmark of find_next_bit

Jan Kiszka (2):
      tools lib traceevent: Add more SVM exit reasons
      tools lib traceevent: Fix reporting of unknown SVM exit reasons

Jason Yan (1):
      perf annotate: Remove unneeded conversion to bool

Jin Yao (2):
      perf evsel: Don't set sample_regs_intr/sample_regs_user for dummy event
      perf record: Skip side-band event setup if HAVE_LIBBPF_SUPPORT is not set

Jiri Olsa (42):
      perf tools: Add fake pmu support
      perf tests: Factor check_parse_id function
      perf tests: Add another metric parsing test
      perf parse: Factor out parse_groups() function
      perf tools: Add fake_pmu to parse_group() function
      perf tools: Add map to parse_groups() function
      perf tools: Add metricgroup__parse_groups_test function
      perf tools: Factor out prepare_metric function
      perf tools: Release metric_events rblist
      perf tools: Add test_generic_metric function
      perf tests: Add parse metric test for ipc metric
      perf tests: Add parse metric test for frontend metric
      perf metric: Rename expr__add_id() to expr__add_val()
      perf metric: Add 'struct expr_id_data' to keep expr value
      perf tools: Allow r0x<HEX> event syntax
      perf tools: Fix term parsing for raw syntax
      perf metric: Fix memory leak in expr__add_id function
      perf metric: Add expr__add_id function
      perf metric: Change expr__get_id to return struct expr_id_data
      perf metric: Add expr__del_id function
      perf metric: Add macros for iterating map events
      perf metric: Add add_metric function
      perf metric: Rename __metricgroup__add_metric to __add_metric
      perf metric: Collect referenced metrics in struct metric_ref_node
      perf metric: Collect referenced metrics in struct metric_expr
      perf metric: Add referenced metrics to hash data
      perf metric: Compute referenced metrics
      perf metric: Add events for the current list
      perf metric: Add cache_miss_cycles to metric parse test
      perf metric: Add DCache_L2 to metric parse test
      perf metric: Add recursion check when processing nested metrics
      perf metric: Make compute_single function more precise
      perf metric: Add metric group test
      perf metric: Rename struct egroup to metric
      perf metric: Rename group_list to metric_list
      perf clockid: Move parse_clockid() to new clockid object
      perf tools: Add clockid_name function
      perf header: Store clock references for -k/--clockid option
      perf tools: Move clockid_res_ns under clock struct
      perf data: Add support to store time of day in CTF data conversion
      perf script: Change the 'enum perf_output_field' enumerators to be 64 bits
      perf script: Add 'tod' field to display time of day

John Garry (2):
      perf pmu: List kernel supplied event aliases for arm64
      perf pmu: Improve CPU core PMU HW event list ordering

Julia Cartwright (1):
      tools lib traceevent: Add plugin for decoding syscalls/sys_enter_futex

Kajol Jain (1):
      perf vendor events power9: Added nest imc metric events

Masami Hiramatsu (4):
      perf probe: Avoid setting probes on the same address for the same event
      perf probe: Fix wrong variable warning when the probe point is not found
      perf probe: Fix memory leakage when the probe point is not found
      perf probe: Warn if the target function is a GNU indirect function

Mike Leach (1):
      perf cs-etm: Allow no CoreSight sink to be specified on command line

Numfor Mbiziwo-Tiapo (1):
      perf annotate: Fix non-null terminated buffer returned by readlink()

Steve MacLean (1):
      perf inject jit: Remove //anon mmap events

Steven Rostedt (Red Hat) (1):
      tools lib traceevent: Add plugin for tlb_flush

Steven Rostedt (VMware) (3):
      tools lib traceevent: Add offset option for function plugin
      tools lib traceevent: Add builtin handler for trace_marker_raw
      tools lib traceevent: Change to SPDX License format

Sven Schnelle (1):
      perf symbols: Add s390 idle functions 'psw_idle' and 'psw_idle_exit' to list of idle symbols

Thomas Hebb (1):
      tools build feature: Use CC and CXX from parent

Tzvetomir Stoyanov (VMware) (14):
      tools lib traceevent: Add tep_load_plugins_hook() API
      tools lib traceevent: Add interface for options to plugins
      tools lib traceevent: Introduced new traceevent API, for adding new plugins directories.
      tools lib traceevent: Add support for more printk format specifiers
      tools lib traceevent: Optimize pretty_print() function
      tools lib traceevent: Move kernel_stack event handler to "function" plugin.
      libtraceevent: Document tep_load_plugins_hook()
      libtraceevent: Handle strdup() error in parse_option_name()
      libtraceevent: Fix typo in tep_plugin_add_option() description
      libtraceevent: Improve error handling of tep_plugin_add_option() API
      libtraceevent: Fixed broken indentation in parse_ip4_print_args()
      libtraceevent: Fixed type in PRINT_FMT_STING
      libtraceevent: Fixed description of tep_add_plugin_path() API
      tools lib traceevent: Handle possible strdup() error in tep_add_plugin_path() API

Wei Li (2):
      perf tools: Fix record failure when mixed with ARM SPE event
      perf tools: No need to cache the PMUs in ARM SPE auxtrace init routine

 tools/arch/powerpc/include/uapi/asm/perf_regs.h    |   20 +-
 tools/arch/x86/include/asm/cpufeatures.h           |    4 +
 tools/arch/x86/include/asm/msr-index.h             |   26 +-
 tools/build/Makefile.feature                       |    2 +-
 tools/build/feature/Makefile                       |    2 -
 tools/include/uapi/asm-generic/unistd.h            |    2 +
 tools/include/uapi/drm/i915_drm.h                  |    4 +-
 tools/include/uapi/linux/in.h                      |    1 +
 tools/include/uapi/linux/perf_event.h              |   26 +-
 tools/lib/api/fd/array.c                           |   23 +-
 tools/lib/api/fd/array.h                           |   16 +-
 tools/lib/perf/evlist.c                            |    6 +-
 tools/lib/perf/include/internal/evlist.h           |    2 +-
 tools/lib/perf/include/perf/event.h                |    9 +
 .../Documentation/libtraceevent-plugins.txt        |   25 +-
 tools/lib/traceevent/event-parse-local.h           |   22 +-
 tools/lib/traceevent/event-parse.c                 | 1004 +++++++++++++++-----
 tools/lib/traceevent/event-parse.h                 |   34 +-
 tools/lib/traceevent/event-plugin.c                |  285 +++++-
 tools/lib/traceevent/kbuffer.h                     |   17 +-
 tools/lib/traceevent/plugins/Build                 |    2 +
 tools/lib/traceevent/plugins/Makefile              |    2 +
 tools/lib/traceevent/plugins/plugin_function.c     |  123 ++-
 tools/lib/traceevent/plugins/plugin_futex.c        |  123 +++
 tools/lib/traceevent/plugins/plugin_hrtimer.c      |   17 +-
 tools/lib/traceevent/plugins/plugin_jbd2.c         |   17 +-
 tools/lib/traceevent/plugins/plugin_kmem.c         |   17 +-
 tools/lib/traceevent/plugins/plugin_kvm.c          |   42 +-
 tools/lib/traceevent/plugins/plugin_mac80211.c     |   17 +-
 tools/lib/traceevent/plugins/plugin_sched_switch.c |   17 +-
 tools/lib/traceevent/plugins/plugin_tlb.c          |   66 ++
 tools/perf/Documentation/itrace.txt                |   14 +
 tools/perf/Documentation/perf-bench.txt            |   11 +
 tools/perf/Documentation/perf-data.txt             |    3 +
 tools/perf/Documentation/perf-intel-pt.txt         |   63 +-
 tools/perf/Documentation/perf-list.txt             |    1 +
 tools/perf/Documentation/perf-record.txt           |   44 +-
 tools/perf/Documentation/perf-script.txt           |    4 +
 tools/perf/Documentation/perf-stat.txt             |   44 +-
 tools/perf/Documentation/perf.data-file-format.txt |   13 +
 tools/perf/arch/arm/util/auxtrace.c                |    9 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    6 +-
 tools/perf/arch/powerpc/include/perf_regs.h        |    8 +-
 tools/perf/arch/powerpc/util/header.c              |    9 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |   55 ++
 tools/perf/arch/powerpc/util/utils_header.h        |   15 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |    1 +
 tools/perf/arch/x86/util/intel-pt.c                |    4 +
 tools/perf/bench/Build                             |    2 +
 tools/perf/bench/bench.h                           |    2 +
 tools/perf/bench/find-bit-bench.c                  |  135 +++
 tools/perf/bench/syscall.c                         |   81 ++
 tools/perf/builtin-bench.c                         |    9 +
 tools/perf/builtin-c2c.c                           |    2 +-
 tools/perf/builtin-data.c                          |    1 +
 tools/perf/builtin-inject.c                        |    4 +-
 tools/perf/builtin-kmem.c                          |    3 +-
 tools/perf/builtin-kvm.c                           |    2 +-
 tools/perf/builtin-record.c                        |  265 +++---
 tools/perf/builtin-report.c                        |    9 +-
 tools/perf/builtin-script.c                        |  233 +++--
 tools/perf/builtin-stat.c                          |  200 +++-
 tools/perf/builtin-top.c                           |    2 +-
 tools/perf/builtin-trace.c                         |    9 +-
 .../arch/powerpc/power9/nest_metrics.json          |   35 +
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/attr/README                       |    1 +
 tools/perf/tests/attr/test-record-pfm-period       |    9 +
 tools/perf/tests/builtin-test.c                    |    4 +
 tools/perf/tests/code-reading.c                    |    2 +-
 tools/perf/tests/expr.c                            |   15 +-
 tools/perf/tests/fdarray.c                         |   22 +-
 tools/perf/tests/parse-events.c                    |   42 +-
 tools/perf/tests/parse-metric.c                    |  352 +++++++
 tools/perf/tests/perf-record.c                     |    4 +-
 tools/perf/tests/pmu-events.c                      |  133 ++-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/ui/browsers/annotate.c                  |    2 +-
 tools/perf/util/Build                              |   63 +-
 tools/perf/util/annotate.c                         |   15 +-
 tools/perf/util/auxtrace.c                         |   50 +
 tools/perf/util/auxtrace.h                         |   31 +-
 tools/perf/util/clockid.c                          |  119 +++
 tools/perf/util/clockid.h                          |   11 +
 tools/perf/util/data-convert-bt.c                  |   57 +-
 tools/perf/util/data-convert.h                     |    1 +
 tools/perf/util/dso.c                              |    3 +
 tools/perf/util/dso.h                              |    1 +
 tools/perf/util/env.h                              |   14 +-
 tools/perf/util/event.c                            |   60 +-
 tools/perf/util/event.h                            |    7 +-
 tools/perf/util/evlist.c                           |  183 +++-
 tools/perf/util/evlist.h                           |   59 +-
 tools/perf/util/evsel.c                            |   23 +-
 tools/perf/util/expr.c                             |  156 ++-
 tools/perf/util/expr.h                             |   34 +-
 tools/perf/util/expr.l                             |    3 +
 tools/perf/util/expr.y                             |   33 +-
 tools/perf/util/header.c                           |  121 ++-
 tools/perf/util/header.h                           |    1 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  214 ++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    1 +
 tools/perf/util/intel-pt.c                         |  122 ++-
 tools/perf/util/jitdump.c                          |   31 +-
 tools/perf/util/machine.c                          |   49 +
 tools/perf/util/machine.h                          |    3 +
 tools/perf/util/map.c                              |    5 +
 tools/perf/util/map.h                              |    3 +-
 tools/perf/util/metricgroup.c                      |  549 +++++++++--
 tools/perf/util/metricgroup.h                      |   16 +
 tools/perf/util/parse-events.c                     |   87 +-
 tools/perf/util/parse-events.h                     |   16 +-
 tools/perf/util/parse-events.l                     |   28 +-
 tools/perf/util/parse-events.y                     |   41 +-
 tools/perf/util/perf_api_probe.c                   |   10 +
 tools/perf/util/perf_api_probe.h                   |    1 +
 tools/perf/util/perf_event_attr_fprintf.c          |    1 +
 tools/perf/util/pmu.c                              |   11 +-
 tools/perf/util/pmu.h                              |    2 +
 tools/perf/util/probe-event.c                      |   18 +-
 tools/perf/util/probe-finder.c                     |    5 +-
 tools/perf/util/record.h                           |    5 +-
 tools/perf/util/session.c                          |   39 +-
 tools/perf/util/stat-shadow.c                      |   81 +-
 tools/perf/util/stat.h                             |    7 +-
 tools/perf/util/symbol.c                           |    3 +
 tools/perf/util/tool.h                             |    3 +-
 127 files changed, 5164 insertions(+), 1091 deletions(-)
 create mode 100644 tools/lib/traceevent/plugins/plugin_futex.c
 create mode 100644 tools/lib/traceevent/plugins/plugin_tlb.c
 create mode 100644 tools/perf/arch/powerpc/util/utils_header.h
 create mode 100644 tools/perf/bench/find-bit-bench.c
 create mode 100644 tools/perf/bench/syscall.c
 create mode 100644 tools/perf/tests/attr/test-record-pfm-period
 create mode 100644 tools/perf/tests/parse-metric.c
 create mode 100644 tools/perf/util/clockid.c
 create mode 100644 tools/perf/util/clockid.h
