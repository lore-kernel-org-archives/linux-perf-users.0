From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/41] perf/core improvements and fixes
Date: Tue, 12 Sep 2017 12:09:48 -0300
Message-ID: <20170912151029.6612-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751404AbdILPKl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Sep 2017 11:10:41 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>, Yao Jin <yao.jin@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling, I'll try and be strict from now on wrt
new stuff versus fixes, which will got to a perf/urgent branch.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 770e96125515daf1c7bc179323f2e0d488dfe6ac:

  Merge tag 'perf-core-for-mingo-4.14-20170901' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2017-09-05 07:14:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170912

for you to fetch changes up to f94843e82778769422e7e6a02b9ce39d5eb882f6:

  perf vendor events: Add JSON metrics for Skylake server (2017-09-11 17:22:40 -0300)

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

- Improve TUI progress bar by showing how many bytes from a total were
  processed (Jiri Olsa)

- Make tools/lib/api make DEBUG=1 build use -D_FORTIFY_SOURCE=2 not
  to cripple debuginfo, just like tools/perf/ does (Jiri Olsa)

- Avoid leaking the 'perf.data' file to workloads started from the
  'perf record' command line by using the O_CLOEXEC open flag (Jiri Olsa)

- Add 'python-clean' make target (Jiri Olsa)

- Use scandir() to replace readdir(), prep work to have the synthesizing
  of PERF_RECORD_ entries for existing threads be multithreaded, making
  'perf top' bearable on high core count systems such as Intel's Knights
  Landing/Mill  (Kan Liang)

- Fix building when libunwind's 'unwind.h' file is present in the
  include path, clashing with tools/perf/util/unwind.h (Milian Wolff)

- Support running perf binaries with a dash in their name (Milian Wolff)

- Allow creating a ~/.perfconfig file when setting a variable to its
  default value, previously it would bail out and not write such a
  file (Taeung Song)

- Avoid writing ~/.perfconfig repeatedly when processing changes to
  multiple variables (Taeung Song)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (25):
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

Arnaldo Carvalho de Melo (2):
      tools include linux: Guard against redefinition of some macros
      perf tools: Make copyfile_offset() static

David Ahern (1):
      perf sched timehist: Add pid and tid options

Jiri Olsa (7):
      tools lib api: Fix make DEBUG=1 build
      perf tools: Open perf.data with O_CLOEXEC flag
      perf tools: Add python-clean target
      perf ui progress: Make sure we always define step value
      perf ui progress: Fix progress update
      perf ui progress: Add ui specific init function
      perf ui progress: Add size info into progress bar

Kan Liang (1):
      perf tools: Use scandir() to replace readdir()

Milian Wolff (2):
      perf tests: Fix compile when libunwind's unwind.h is available
      perf tools: Support running perf binaries with a dash in their name

Taeung Song (3):
      perf config: Check not only section->from_system_config but also item's
      perf config: Write a config file just once
      perf config: Allow creating empty config set for config file autogeneration

 tools/include/linux/compiler-gcc.h                 |   9 +-
 tools/lib/api/Makefile                             |   8 +-
 tools/perf/Documentation/perf-list.txt             |   9 +-
 tools/perf/Documentation/perf-record.txt           |   2 +
 tools/perf/Documentation/perf-sched.txt            |   8 +
 tools/perf/Documentation/perf-script.txt           |   4 +-
 tools/perf/Documentation/perf-stat.txt             |   7 +
 tools/perf/Makefile.perf                           |   8 +-
 tools/perf/builtin-config.c                        |  24 +-
 tools/perf/builtin-list.c                          |   7 +
 tools/perf/builtin-record.c                        |   3 +
 tools/perf/builtin-sched.c                         |   4 +
 tools/perf/builtin-script.c                        |  30 +-
 tools/perf/builtin-stat.c                          |  82 +++-
 tools/perf/perf.c                                  |  14 +-
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
 tools/perf/tests/dwarf-unwind.c                    |   2 +-
 tools/perf/ui/progress.c                           |  15 +-
 tools/perf/ui/progress.h                           |  12 +-
 tools/perf/ui/tui/progress.c                       |  32 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/config.c                           |   5 +-
 tools/perf/util/data.c                             |  14 +-
 tools/perf/util/dso.c                              |   1 +
 tools/perf/util/event.c                            |  46 +-
 tools/perf/util/evlist.h                           |   1 +
 tools/perf/util/evsel.c                            |   7 +-
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/metricgroup.c                      | 489 +++++++++++++++++++++
 tools/perf/util/metricgroup.h                      |  31 ++
 tools/perf/util/namespaces.c                       |   1 +
 tools/perf/util/parse-events.c                     |  11 +-
 tools/perf/util/parse-events.l                     |   3 +-
 tools/perf/util/pmu.c                              |  55 ++-
 tools/perf/util/pmu.h                              |   2 +
 tools/perf/util/probe-file.c                       |   1 +
 tools/perf/util/session.c                          |   2 +-
 tools/perf/util/stat-shadow.c                      | 110 +++--
 tools/perf/util/stat.h                             |   4 +-
 tools/perf/util/util.c                             |   3 +-
 tools/perf/util/util.h                             |   2 -
 tools/perf/util/zlib.c                             |   1 +
 57 files changed, 2734 insertions(+), 128 deletions(-)
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
 create mode 100644 tools/perf/util/metricgroup.c
 create mode 100644 tools/perf/util/metricgroup.h

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

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
Tue Sep 12 09:49:13 -03 2017

[root@jouet ~]# waitp 23628 ; time dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:3.6: Ok
   4 alpine:edge: Ok
   5 android-ndk:r12b-arm: Ok
   6 android-ndk:r15c-arm: Ok
   7 archlinux:latest: Ok
   8 centos:5: Ok
   9 centos:6: Ok
  10 centos:7: Ok
  11 debian:7: Ok
  12 debian:8: Ok
  13 debian:9: Ok
  14 debian:experimental: Ok
  15 debian:experimental-x-arm64: Ok
  16 debian:experimental-x-mips: Ok
  17 debian:experimental-x-mips64: Ok
  18 debian:experimental-x-mipsel: Ok
  19 fedora:20: Ok
  20 fedora:21: Ok
  21 fedora:22: Ok
  22 fedora:23: Ok
  23 fedora:24: Ok
  24 fedora:24-x-ARC-uClibc: Ok
  25 fedora:25: Ok
  26 fedora:26: Ok
  27 fedora:rawhide: Ok
  28 mageia:5: Ok
  29 opensuse:13.2: Ok
  30 opensuse:42.1: Ok
  31 opensuse:42.2: Ok
  32 opensuse:42.3: Ok
  33 opensuse:tumbleweed: Ok
  34 oraclelinux:6: Ok
  35 oraclelinux:7: Ok
  36 ubuntu:12.04.5: Ok
  37 ubuntu:14.04.4: Ok
  38 ubuntu:14.04.4-x-linaro-arm64: Ok
  39 ubuntu:15.10: Ok
  40 ubuntu:16.04: Ok
  41 ubuntu:16.04-x-arm: Ok
  42 ubuntu:16.04-x-arm64: Ok
  43 ubuntu:16.04-x-powerpc: Ok
  44 ubuntu:16.04-x-powerpc64: Ok
  45 ubuntu:16.04-x-powerpc64el: Ok
  46 ubuntu:16.04-x-s390: Ok
  47 ubuntu:16.10: Ok
  48 ubuntu:17.04: Ok
  49 ubuntu:17.10: Ok
  #

  # uname -a
  Linux jouet 4.13.0-rc7+ #3 SMP Sat Sep 2 09:04:44 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  10: DSO data read                                         : Ok
  11: DSO data cache                                        : Ok
  12: DSO data reopen                                       : Ok
  13: Roundtrip evsel->name                                 : Ok
  14: Parse sched tracepoints fields                        : Ok
  15: syscalls:sys_enter_openat event fields                : Ok
  16: Setup struct perf_event_attr                          : Ok
  17: Match and link multiple hists                         : Ok
  18: 'import perf' in python                               : Ok
  19: Breakpoint overflow signal handler                    : Ok
  20: Breakpoint overflow sampling                          : Ok
  21: Number of exit events of a simple workload            : Ok
  22: Software clock events period values                   : Ok
  23: Object code reading                                   : Ok
  24: Sample parsing                                        : Ok
  25: Use a dummy software event to keep tracking           : Ok
  26: Parse with no sample_id_all bit set                   : Ok
  27: Filter hist entries                                   : Ok
  28: Lookup mmap thread                                    : Ok
  29: Share thread mg                                       : Ok
  30: Sort output of hist entries                           : Ok
  31: Cumulate child hist entries                           : Ok
  32: Track with sched_switch                               : Ok
  33: Filter fds with revents mask in a fdarray             : Ok
  34: Add fd to a fdarray, making it autogrow               : Ok
  35: kmod_path__parse                                      : Ok
  36: Thread map                                            : Ok
  37: LLVM search and compile                               :
  37.1: Basic BPF llvm compile                              : Ok
  37.2: kbuild searching                                    : Ok
  37.3: Compile source for BPF prologue generation          : Ok
  37.4: Compile source for BPF relocation                   : Ok
  38: Session topology                                      : Ok
  39: BPF filter                                            :
  39.1: Basic BPF filtering                                 : Ok
  39.2: BPF pinning                                         : Ok
  39.3: BPF prologue generation                             : Ok
  39.4: BPF relocation checker                              : Ok
  40: Synthesize thread map                                 : Ok
  41: Remove thread map                                     : Ok
  42: Synthesize cpu map                                    : Ok
  43: Synthesize stat config                                : Ok
  44: Synthesize stat                                       : Ok
  45: Synthesize stat round                                 : Ok
  46: Synthesize attr update                                : Ok
  47: Event times                                           : Ok
  48: Read backward ring buffer                             : Ok
  49: Print cpu map                                         : Ok
  50: Probe SDT events                                      : Ok
  51: is_printable_array                                    : Ok
  52: Print bitmap                                          : Ok
  53: perf hooks                                            : Ok
  54: builtin clang support                                 : Skip (not compiled in)
  55: unit_number__scnprintf                                : Ok
  56: x86 rdpmc                                             : Ok
  57: Convert perf time to TSC                              : Ok
  58: DWARF unwind                                          : Ok
  59: x86 instruction decoder - new instructions            : Ok
  60: Intel cqm nmi context read                            : Skip
  61: Use vfs_getname probe to get syscall args filenames   : Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #
  
  [acme@jouet linux]$ time make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_static_O: make LDFLAGS=-static
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_help_O: make help
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_clean_all_O: make clean all
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                   make_tags_O: make tags
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                  make_debug_O: make DEBUG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_perf_o_O: make perf.o
                make_no_newt_O: make NO_NEWT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
                   make_pure_O: make
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_no_libbpf_O: make NO_LIBBPF=1
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
