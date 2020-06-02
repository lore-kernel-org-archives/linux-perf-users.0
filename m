From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tooling changes for v5.8
Date: Tue,  2 Jun 2020 15:24:23 -0300
Message-ID: <20200602182423.2451-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Anand K Mistry <amistry@google.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@gmail.com>, "Gustavo A . R . Silva" <gustavoars@kernel.org>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Joakim Zhang <qiangqing.zhang@nxp.com>, Kajol Jain <kjain@linux.ibm.com>, Li Bin <huawei.libin@huawei.com>, Masami Hiramatsu <mhiramat@kernel.org>, Nick Gasson <nick.gasson@arm.com>, Paul
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Linus,

	These are additional changes to the perf tools, on top of what
Ingo has already submitted and you merged, please let me know if I made
any mistake,

	Available from:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-tools-2020-06-02

  # HEAD: 3e9b26dc2268cfbeef85bee095f883264c18425c Remove some duplicated includes

	A summary of what is here:

 - Further Intel PT call-trace fixes

 - Improve SELinux docs and tool warnings

 - Fix race at exit in 'perf record' using eventfd.

 - Add missing build tests to the default set of 'make -C tools/perf build-test'

 - Sync msr-index.h getting new AMD MSRs to decode and filter in 'perf trace'.

 - Fix fallback to libaudit in 'perf trace' for arches not using per-arch *.tbl files.

 - Fixes for 'perf ftrace'.

 - Fixes and improvements for the 'perf stat' metrics.

 - Use dummy event to get PERF_RECORD_{FORK,MMAP,etc} while synthesizing
   those metadata events for pre-existing threads.

 - Fix leaks detected using clang tooling.

 - Improvements to PMU event metric testing.

 - Report summary for 'perf stat' interval mode at the end, summing up
   all the intervals.

 - Improve pipe mode, i.e. this now works as expected, continuously
   dumping samples:

    # perf record -g -e raw_syscalls:sys_enter | perf --no-pager script

 - Fixes for event grouping, detecting incompatible groups such as:

     # perf stat -e '{cycles,power/energy-cores/}' -v
     WARNING: group events cpu maps do not match, disabling group:
       anon group { power/energy-cores/, cycles }
         power/energy-cores/: 0
         cycles: 0-7

 - Fixes for 'perf probe': blacklist address checking, number of
   kretprobe instances, etc.

 - JIT processing improvements and fixes plus the addition of a 'perf
   test' entry for the java demangler.

 - Add support for synthesizing first/last level cache, TLB and remove
   access events from HW tracing in the auxtrace code, first to use is
   ARM SPE.

 - Vendor events updates and fixes, including for POWER9 and Intel.

 - Allow using ~/.perfconfig for removing the ',' separators in 'perf
   stat' output.

 - Opt-in support for libpfm4.

Best Regards,

- Arnaldo

Adrian Hunter (8):
  perf intel-pt: Use allocated branch stack for PEBS sample
  perf symbols: Fix debuginfo search for Ubuntu
  perf kcore_copy: Fix module map when there are no modules loaded
  perf evlist: Disable 'immediate' events last
  perf script: Fix --call-trace for Intel PT
  perf record: Respect --no-switch-events
  perf intel-pt: Refine kernel decoding only warning message
  perf symbols: Fix kernel maps for kcore and eBPF

Alexey Budankov (3):
  perf docs: Extend CAP_SYS_ADMIN with CAP_PERFMON where needed
  perf tool: Make perf tool aware of SELinux access control
  perf docs: Introduce security.txt file to document related issues

Anand K Mistry (1):
  perf record: Use an eventfd to wakeup when done

Andi Kleen (1):
  perf script: Don't force less for non tty output with --xed

Arnaldo Carvalho de Melo (21):
  perf evsel: Rename perf_evsel__object_config() to evsel__object_config()
  perf evsel: Rename perf_evsel__resort*() to evsel__resort*()
  perf evsel: Rename perf_evsel__fprintf() to evsel__fprintf()
  perf evsel: Rename *perf_evsel__get_config_term() & friends to evsel__env()
  perf evsel: Rename perf_evsel__new*() to evsel__new*()
  perf evsel: Rename perf_evsel__[hs]w_cache* to evsel__[hs]w_cache*
  perf counts: Rename perf_evsel__*counts() to evsel__*counts()
  perf parse-events: Fix incorrect conversion of 'if () free()' to 'zfree()'
  perf evsel: Initialize evsel->per_pkg_mask to NULL in evsel__init()
  tools feature: Rename HAVE_EVENTFD to HAVE_EVENTFD_SUPPORT
  perf build: Group the NO_SYSCALL_TABLE logic
  perf build: Allow explicitely disabling the NO_SYSCALL_TABLE variable
  perf trace: Remove union from syscalltbl, all the fields are needed
  perf trace: Use zalloc() to make sure all fields are zeroed in the syscalltbl constructor
  perf trace: Grow the syscall table as needed when using libaudit
  perf build: Remove libaudit from the default feature checks
  perf build: Add NO_SYSCALL_TABLE=1 to the build tests
  perf build: Add NO_LIBCRYPTO=1 to the default set of build tests
  perf build: Add NO_SDT=1 to the default set of build tests
  perf build: Add a LIBPFM4=1 build test entry
  tools arch x86: Sync the msr-index.h copy with the kernel sources

Changbin Du (2):
  perf ftrace: Trace system wide if no target is given
  perf ftrace: Detect workload failure

Ed Maste (1):
  perf tools: Correct license on jsmn JSON parser

Gustavo A. R. Silva (2):
  perf tools: Replace zero-length array with flexible-array
  perf branch: Replace zero-length array with flexible-array

Ian Rogers (38):
  perf expr: Allow for unlimited escaped characters in a symbol
  perf metrics: Fix parse errors in cascade lake metrics
  perf metrics: Fix parse errors in skylake metrics
  perf expr: Allow ',' to be an other token
  perf expr: Increase max other
  perf expr: Parse numbers as doubles
  perf expr: Debug lex if debugging yacc
  perf metrics: Fix parse errors in power8 metrics
  perf metrics: Fix parse errors in power9 metrics
  perf expr: Print a debug message for division by zero
  perf evsel: Dummy events never triggers, no need to ask for PERF_SAMPLE_BRANCH_STACK
  perf record: Add dummy event during system wide synthesis
  perf c2c: Fix 'perf c2c record -e list' to show the default events used
  perf evsel: Fix 2 memory leaks
  perf expr: Test parsing of floating point numbers
  perf expr: Fix memory leaks in metric bison
  perf parse-events: Make add PMU verbose output clearer
  perf test: Provide a subtest callback to ask for the reason for skipping a subtest
  perf test: Improve pmu event metric testing
  perf trace: Fix the selection for architectures to generate the errno name tables
  perf beauty: Allow the CC used in the arch errno names script to acccept CFLAGS
  perf tools: Grab a copy of libbpf's hashmap
  perf expr: Migrate expr ids table to a hashmap
  perf metricgroup: Make 'evlist_used' variable a bitmap instead of array of bools
  perf expr: Allow numbers to be followed by a dot
  perf metricgroup: Free metric_events on error
  perf metricgroup: Always place duration_time last
  perf metricgroup: Use early return in add_metric
  perf metricgroup: Delay events string creation
  perf metricgroup: Order event groups by size
  perf metricgroup: Remove duped metric group events
  perf metricgroup: Add options to not group or merge
  perf metricgroup: Remove unnecessary ',' from events
  perf list: Add metrics to command line usage
  tools compiler.h: Add attribute to disable tail calls
  perf tests: Don't tail call optimize in unwind test
  perf test: Initialize memory in dwarf-unwind
  perf libdw: Fix off-by 1 relative directory includes

Jin Yao (6):
  perf parse-events: Use strcmp() to compare the PMU name
  perf stat: Fix wrong per-thread runtime stat for interval mode
  perf counts: Reset prev_raw_counts counts
  perf stat: Copy counts from prev_raw_counts to evsel->counts
  perf stat: Save aggr value to first member of prev_raw_counts
  perf stat: Report summary for interval mode

Jiri Olsa (13):
  perf tools: Do not display extra info when there is nothing to build
  perf tools: Do not seek in pipe fd during tracing data processing
  perf session: Try to read pipe data from file
  perf callchain: Setup callchain properly in pipe mode
  perf script: Enable IP fields for callchains
  perf tools: Fix is_bpf_image function logic
  perf trace: Fix compilation error for make NO_LIBBPF=1 DEBUG=1
  perf stat: Fix duration_time value for higher intervals
  perf stat: Fail on extra comma while parsing events
  perf tests: Consider subtests when searching for user specified tests
  perf stat: Do not pass avg to generic_metric
  perf parse: Add 'struct parse_events_state' pointer to scanner
  perf stat: Ensure group is defined on top of the same cpu mask

Li Bin (1):
  perf util: Fix potential SEGFAULT in put_tracepoints_path error path

Masami Hiramatsu (4):
  perf probe: Accept the instance number of kretprobe event
  perf probe: Fix to check blacklist address correctly
  perf probe: Check address correctness by map instead of _etext
  perf probe: Do not show the skipped events

Nick Gasson (6):
  perf jvmti: Fix jitdump for methods without debug info
  perf jvmti: Do not report error when missing debug information
  perf tests: Add test for the java demangler
  perf jvmti: Fix demangling Java symbols
  perf jvmti: Remove redundant jitdump line table entries
  perf jit: Fix inaccurate DWARF line table

Paul A. Clarke (5):
  perf stat: Increase perf metric output resolution
  perf vendor events power9: Add missing metrics to POWER9 'cpi_breakdown'
  perf stat: POWER9 metrics: expand "ICT" acronym
  perf script: Better align register values in dump
  perf config: Add stat.big-num support

Ravi Bangoria (1):
  perf powerpc: Don't ignore sym-handling.c file

Stephane Eranian (1):
  perf tools: Add optional support for libpfm4

Tan Xiaojun (3):
  perf tools: Move arm-spe-pkt-decoder.h/c to the new dir
  perf auxtrace: Add four itrace options
  perf arm-spe: Support synthetic events

Tiezhu Yang (1):
  perf tools: Remove some duplicated includes

Wang ShaoBo (1):
  perf bpf-loader: Add missing '*' for key_scan_pos

Xie XiuQi (1):
  perf util: Fix memory leak of prefix_if_not_in

 tools/arch/x86/include/asm/msr-index.h        |   3 +
 tools/build/Makefile.feature                  |   2 -
 tools/build/feature/Makefile                  |   2 +-
 tools/build/feature/test-all.c                |   5 -
 tools/include/linux/compiler-gcc.h            |  12 +
 tools/include/linux/compiler.h                |   3 +
 tools/perf/Documentation/itrace.txt           |   6 +-
 tools/perf/Documentation/perf-c2c.txt         |   2 +-
 tools/perf/Documentation/perf-config.txt      |   5 +
 tools/perf/Documentation/perf-intel-pt.txt    |   2 +-
 tools/perf/Documentation/perf-record.txt      |  15 +-
 tools/perf/Documentation/perf-stat.txt        |  33 +-
 tools/perf/Documentation/perf-top.txt         |  11 +
 tools/perf/Documentation/security.txt         | 237 +++++
 tools/perf/Makefile.config                    |  43 +-
 tools/perf/Makefile.perf                      |  14 +-
 tools/perf/arch/arm/util/cs-etm.c             |   7 +-
 tools/perf/arch/arm64/util/unwind-libdw.c     |   6 +-
 tools/perf/arch/powerpc/util/Build            |   1 +
 tools/perf/arch/powerpc/util/unwind-libdw.c   |   6 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   8 +
 tools/perf/arch/x86/util/intel-pt.c           |  41 +-
 tools/perf/arch/x86/util/unwind-libdw.c       |   6 +-
 tools/perf/bench/epoll-ctl.c                  |   4 +-
 tools/perf/bench/epoll-wait.c                 |   4 +-
 tools/perf/bench/sched-messaging.c            |   2 +-
 tools/perf/builtin-annotate.c                 |   2 +-
 tools/perf/builtin-bench.c                    |   6 +-
 tools/perf/builtin-c2c.c                      |   9 +-
 tools/perf/builtin-evlist.c                   |   2 +-
 tools/perf/builtin-ftrace.c                   |  15 +-
 tools/perf/builtin-inject.c                   |   2 +-
 tools/perf/builtin-list.c                     |   2 +-
 tools/perf/builtin-mem.c                      |  24 +-
 tools/perf/builtin-probe.c                    |   3 +
 tools/perf/builtin-record.c                   |  69 +-
 tools/perf/builtin-report.c                   |  37 +-
 tools/perf/builtin-script.c                   |  41 +-
 tools/perf/builtin-stat.c                     | 181 +++-
 tools/perf/builtin-timechart.c                |   2 +-
 tools/perf/builtin-top.c                      |  12 +-
 tools/perf/builtin-trace.c                    |  92 +-
 tools/perf/check-headers.sh                   |   4 +
 tools/perf/jvmti/libjvmti.c                   |  92 +-
 .../arch/powerpc/power8/metrics.json          |   2 +-
 .../arch/powerpc/power9/metrics.json          | 149 ++--
 .../arch/x86/cascadelakex/clx-metrics.json    |  10 +-
 .../arch/x86/skylakex/skx-metrics.json        |   4 +-
 tools/perf/pmu-events/jsmn.h                  |   2 +-
 tools/perf/tests/Build                        |   2 +
 tools/perf/tests/attr/system-wide-dummy       |  50 ++
 tools/perf/tests/attr/test-record-C0          |  12 +-
 tools/perf/tests/builtin-test.c               |  65 +-
 tools/perf/tests/demangle-java-test.c         |  42 +
 tools/perf/tests/dwarf-unwind.c               |  11 +-
 tools/perf/tests/evsel-roundtrip-name.c       |   5 +-
 tools/perf/tests/evsel-tp-sched.c             |   8 +-
 tools/perf/tests/expr.c                       |  46 +-
 tools/perf/tests/hists_cumulate.c             |   2 +-
 tools/perf/tests/hists_filter.c               |   2 +-
 tools/perf/tests/hists_output.c               |  10 +-
 tools/perf/tests/make                         |  10 +-
 tools/perf/tests/mmap-basic.c                 |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c    |   8 +-
 tools/perf/tests/openat-syscall-tp-fields.c   |   4 +-
 tools/perf/tests/openat-syscall.c             |   2 +-
 tools/perf/tests/pfm.c                        | 203 +++++
 tools/perf/tests/pmu-events.c                 | 173 +++-
 tools/perf/tests/pmu.c                        |   4 +-
 tools/perf/tests/sw-clock.c                   |   2 +-
 tools/perf/tests/tests.h                      |   8 +
 tools/perf/trace/beauty/arch_errno_names.sh   |   4 +-
 tools/perf/util/Build                         |   8 +-
 tools/perf/util/annotate.c                    |   1 -
 tools/perf/util/annotate.h                    |   4 +-
 tools/perf/util/arm-spe-decoder/Build         |   1 +
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 219 +++++
 .../util/arm-spe-decoder/arm-spe-decoder.h    |  82 ++
 .../arm-spe-pkt-decoder.c                     |   0
 .../arm-spe-pkt-decoder.h                     |  16 +
 tools/perf/util/arm-spe.c                     | 823 +++++++++++++++++-
 tools/perf/util/auxtrace.c                    |  22 +-
 tools/perf/util/auxtrace.h                    |  15 +-
 tools/perf/util/bpf-loader.c                  |   2 +-
 tools/perf/util/branch.h                      |   2 +-
 tools/perf/util/callchain.c                   |  14 +
 tools/perf/util/callchain.h                   |   1 +
 tools/perf/util/cloexec.c                     |   4 +-
 tools/perf/util/config.c                      |  14 +-
 tools/perf/util/counts.c                      |  10 +-
 tools/perf/util/counts.h                      |   7 +-
 tools/perf/util/cputopo.h                     |   2 +-
 tools/perf/util/demangle-java.c               |  13 +-
 tools/perf/util/dso.c                         |  16 +
 tools/perf/util/dso.h                         |   5 +-
 tools/perf/util/event.h                       |   2 +-
 tools/perf/util/evlist.c                      |  39 +-
 tools/perf/util/evsel.c                       | 156 ++--
 tools/perf/util/evsel.h                       |  34 +-
 tools/perf/util/evsel_config.h                |  43 +-
 tools/perf/util/evsel_fprintf.c               |   3 +-
 tools/perf/util/evsel_fprintf.h               |   3 +-
 tools/perf/util/expr.c                        | 130 +--
 tools/perf/util/expr.h                        |  29 +-
 tools/perf/util/expr.l                        |  16 +-
 tools/perf/util/expr.y                        |  41 +-
 tools/perf/util/genelf_debug.c                |   4 +-
 tools/perf/util/hashmap.c                     | 238 +++++
 tools/perf/util/hashmap.h                     | 176 ++++
 tools/perf/util/header.c                      |  34 +-
 tools/perf/util/hist.c                        |  13 +-
 tools/perf/util/hist.h                        |   6 +-
 tools/perf/util/intel-pt.c                    |  31 +-
 tools/perf/util/jitdump.c                     |   2 +-
 tools/perf/util/jitdump.h                     |   6 +-
 tools/perf/util/machine.c                     |   4 +-
 tools/perf/util/mem-events.c                  |  15 +
 tools/perf/util/mem-events.h                  |   2 +
 tools/perf/util/metricgroup.c                 | 316 ++++---
 tools/perf/util/metricgroup.h                 |   6 +-
 tools/perf/util/ordered-events.h              |   2 +-
 tools/perf/util/parse-events.c                | 111 ++-
 tools/perf/util/parse-events.h                |   5 +
 tools/perf/util/parse-events.l                |  12 +-
 tools/perf/util/pfm.c                         | 281 ++++++
 tools/perf/util/pfm.h                         |  37 +
 tools/perf/util/pmu.c                         |  33 +-
 tools/perf/util/pmu.h                         |   4 +-
 tools/perf/util/probe-event.c                 |  49 +-
 tools/perf/util/probe-finder.c                |   1 +
 tools/perf/util/pstack.c                      |   2 +-
 tools/perf/util/record.h                      |   6 +
 tools/perf/util/session.c                     |  12 +-
 tools/perf/util/sideband_evlist.c             |   2 +-
 tools/perf/util/sort.c                        |   2 +-
 tools/perf/util/stat-shadow.c                 |  53 +-
 tools/perf/util/stat.c                        |  90 +-
 tools/perf/util/stat.h                        |   7 +
 tools/perf/util/symbol-elf.c                  |   7 +
 tools/perf/util/symbol.c                      |   4 +
 tools/perf/util/symbol.h                      |   2 +-
 tools/perf/util/syscalltbl.c                  |   4 +-
 tools/perf/util/syscalltbl.h                  |  14 +-
 tools/perf/util/trace-event-info.c            |   2 +-
 tools/perf/util/unwind-libunwind-local.c      |   2 +-
 145 files changed, 4311 insertions(+), 982 deletions(-)
 create mode 100644 tools/perf/Documentation/security.txt
 create mode 100644 tools/perf/tests/attr/system-wide-dummy
 create mode 100644 tools/perf/tests/demangle-java-test.c
 create mode 100644 tools/perf/tests/pfm.c
 create mode 100644 tools/perf/util/arm-spe-decoder/Build
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
 create mode 100644 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.c (100%)
 rename tools/perf/util/{ => arm-spe-decoder}/arm-spe-pkt-decoder.h (64%)
 create mode 100644 tools/perf/util/hashmap.c
 create mode 100644 tools/perf/util/hashmap.h
 create mode 100644 tools/perf/util/pfm.c
 create mode 100644 tools/perf/util/pfm.h

-- 
2.21.3
