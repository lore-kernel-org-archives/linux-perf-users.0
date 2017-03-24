From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/20] perf/core improvements and fixes
Date: Fri, 24 Mar 2017 11:57:11 -0300
Message-ID: <20170324145731.29350-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexis Berlemont <alexis.berlemont@gmail.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, John Shortt <jshortt@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vne>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 267dd0a07eefbb37264fcfad984fffc8856898ad:

  Merge tag 'perf-core-for-mingo-4.12-20170320' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-21 07:41:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170324

for you to fetch changes up to bf874fcf9f2fed58510dc83abcee388cee2b427e:

  perf list: Move extra details printing to new option (2017-03-23 11:42:31 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

User visible:

- Allow suppressing 'uncore_' when specifying PMU events (Andi Kleen)

- Collapse identically named PMU events in 'perf stat', allow
  not merging it via --no-merge (Andi Kleen)

Fixes:

- Use more precise 'grep -v' to suppress unwanted 'objdump -dS'
  disassembly output to not ditch line:number lines needed by
  'perf annotate --print-lines' logic (Taeung Song)

Infrastructure:

- SDT (Statically Defined Tracing)/uprobes_events arguments improvements
  (Alexis Berlemont, Ravi Bangoria)

- Improvements for the handling of JSON described vendor events,
  including having an expression parser to calculate metrics
  from multiple vendor events (Andi Kleen)

- Update Intel JSON vendor event files (Andi Kleen)

- Restore error reporting in 'perf probe -d' when none of the events
  requested to be deleted exist. (Kefeng Wang)

- Bump MAX_CMDLEN in 'perf probe' to match what the kernel accepts
  (Ravi Bangoria)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexis Berlemont (2):
      perf sdt: Add scanning of sdt probes arguments
      perf probe: Add sdt probes arguments into the uprobe cmd string

Andi Kleen (13):
      perf stat: Factor out callback for collecting event values
      perf stat: Collapse identically named events
      perf stat: Handle partially bad results with merging
      perf tools: Factor out PMU matching in parser
      perf pmu: Expand PMU events by prefix match
      perf pmu: Special case uncore_ prefix
      perf tools: Add a simple expression parser for JSON
      perf vendor events intel: Update Intel uncore JSON event files
      perf pmu: Support MetricExpr header in JSON event list
      perf stat: Output JSON MetricExpr metric
      perf list: Support printing MetricExpr with --debug
      perf pmu: Add support for MetricName JSON attribute
      perf list: Move extra details printing to new option

Arnaldo Carvalho de Melo (1):
      perf annotate: Add comment clarifying how the source code line is parsed

Kefeng Wang (1):
      perf probe: Return errno when not hitting any event

Ravi Bangoria (2):
      perf probe: Change MAX_CMDLEN
      perf sdt x86: Add renaming logic for rNN and other registers

Taeung Song (1):
      perf annotate: More exactly grep -v of the objdump command

 tools/perf/Documentation/perf-list.txt             |   4 +
 tools/perf/Documentation/perf-stat.txt             |   3 +
 tools/perf/arch/x86/util/perf_regs.c               | 103 +++++++++++
 tools/perf/builtin-list.c                          |  14 +-
 tools/perf/builtin-probe.c                         |   6 +-
 tools/perf/builtin-stat.c                          | 146 ++++++++++++---
 .../arch/x86/broadwellde/uncore-cache.json         |  28 +--
 .../arch/x86/broadwellde/uncore-memory.json        |  26 ++-
 .../arch/x86/broadwellde/uncore-power.json         |  26 ++-
 .../arch/x86/broadwellx/uncore-cache.json          |  28 +--
 .../arch/x86/broadwellx/uncore-interconnect.json   |   6 +-
 .../arch/x86/broadwellx/uncore-memory.json         |  21 ++-
 .../arch/x86/broadwellx/uncore-power.json          |  26 ++-
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |  28 +--
 .../arch/x86/haswellx/uncore-interconnect.json     |   6 +-
 .../arch/x86/haswellx/uncore-memory.json           |  21 ++-
 .../pmu-events/arch/x86/haswellx/uncore-power.json |  26 ++-
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |  22 +--
 .../arch/x86/ivytown/uncore-interconnect.json      |  12 +-
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |  19 +-
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |  53 ++++--
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |  13 +-
 .../arch/x86/jaketown/uncore-interconnect.json     |  12 +-
 .../arch/x86/jaketown/uncore-memory.json           |  21 ++-
 .../pmu-events/arch/x86/jaketown/uncore-power.json |  53 ++++--
 tools/perf/pmu-events/jevents.c                    |  26 ++-
 tools/perf/pmu-events/jevents.h                    |   3 +-
 tools/perf/pmu-events/pmu-events.h                 |   2 +
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/expr.c                            |  56 ++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/util/Build                              |   6 +
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/evsel.c                            |   4 +
 tools/perf/util/evsel.h                            |   5 +
 tools/perf/util/expr.h                             |  25 +++
 tools/perf/util/expr.y                             | 173 ++++++++++++++++++
 tools/perf/util/parse-events.c                     |  78 +++++++-
 tools/perf/util/parse-events.h                     |  10 +-
 tools/perf/util/parse-events.y                     |  73 ++++----
 tools/perf/util/perf_regs.c                        |   6 +
 tools/perf/util/perf_regs.h                        |   6 +
 tools/perf/util/pmu.c                              |  32 +++-
 tools/perf/util/pmu.h                              |   6 +-
 tools/perf/util/probe-event.c                      |   1 -
 tools/perf/util/probe-file.c                       | 173 +++++++++++++++++-
 tools/perf/util/stat-shadow.c                      | 197 +++++++++++++++++++++
 tools/perf/util/stat.h                             |   2 +
 tools/perf/util/symbol-elf.c                       |  25 ++-
 tools/perf/util/symbol.h                           |   1 +
 51 files changed, 1370 insertions(+), 277 deletions(-)
 create mode 100644 tools/perf/tests/expr.c
 create mode 100644 tools/perf/util/expr.h
 create mode 100644 tools/perf/util/expr.y

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
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

  # dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:edge: Ok
   4 android-ndk:r12b-arm: Ok
   5 archlinux:latest: Ok
   6 centos:5: Ok
   7 centos:6: Ok
   8 centos:7: Ok
   9 debian:7: Ok
  10 debian:8: Ok
  11 debian:experimental: Ok
  12 debian:experimental-x-arm64: Ok
  13 debian:experimental-x-mips: Ok
  14 debian:experimental-x-mips64: Ok
  15 debian:experimental-x-mipsel: Ok
  16 fedora:20: Ok
  17 fedora:21: Ok
  18 fedora:22: Ok
  19 fedora:23: Ok
  20 fedora:24: Ok
  21 fedora:24-x-ARC-uClibc: Ok
  22 fedora:25: Ok
  23 fedora:rawhide: Ok
  24 mageia:5: Ok
  25 opensuse:13.2: Ok
  26 opensuse:42.1: Ok
  27 opensuse:tumbleweed: Ok
  28 ubuntu:12.04.5: Ok
  29 ubuntu:14.04.4: Ok
  30 ubuntu:14.04.4-x-linaro-arm64: Ok
  31 ubuntu:15.10: Ok
  32 ubuntu:16.04: Ok
  33 ubuntu:16.04-x-arm: Ok
  34 ubuntu:16.04-x-arm64: Ok
  35 ubuntu:16.04-x-powerpc: Ok
  36 ubuntu:16.04-x-powerpc64: Ok
  37 ubuntu:16.04-x-s390: Ok
  38 ubuntu:16.10: Ok
  39 ubuntu:17.04: Ok
  #

  # uname -a
  Linux felicio.ghostprotocols.net 4.11.0-rc3+ #1 SMP Thu Mar 23 14:32:00 BRT 2017 x86_64 x86_64 x86_64 GNU/Linux
  # Has peterz's fix for 'perf test tsc'
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: Simple expression parser                   : Ok
   7: PERF_RECORD_* events & perf_sample fields  : Ok
   8: Parse perf pmu format                      : Ok
   9: DSO data read                              : Ok
  10: DSO data cache                             : Ok
  11: DSO data reopen                            : Ok
  12: Roundtrip evsel->name                      : Ok
  13: Parse sched tracepoints fields             : Ok
  14: syscalls:sys_enter_openat event fields     : Ok
  15: Setup struct perf_event_attr               : Ok
  16: Match and link multiple hists              : Ok
  17: 'import perf' in python                    : Ok
  18: Breakpoint overflow signal handler         : Ok
  19: Breakpoint overflow sampling               : Ok
  20: Number of exit events of a simple workload : Ok
  21: Software clock events period values        : Ok
  22: Object code reading                        : Ok
  23: Sample parsing                             : Ok
  24: Use a dummy software event to keep tracking: Ok
  25: Parse with no sample_id_all bit set        : Ok
  26: Filter hist entries                        : Ok
  27: Lookup mmap thread                         : Ok
  28: Share thread mg                            : Ok
  29: Sort output of hist entries                : Ok
  30: Cumulate child hist entries                : Ok
  31: Track with sched_switch                    : Ok
  32: Filter fds with revents mask in a fdarray  : Ok
  33: Add fd to a fdarray, making it autogrow    : Ok
  34: kmod_path__parse                           : Ok
  35: Thread map                                 : Ok
  36: LLVM search and compile                    :
  36.1: Basic BPF llvm compile                    : Ok
  36.2: kbuild searching                          : Ok
  36.3: Compile source for BPF prologue generation: Ok
  36.4: Compile source for BPF relocation         : Ok
  37: Session topology                           : Ok
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  39: Synthesize thread map                      : Ok
  40: Remove thread map                          : Ok
  41: Synthesize cpu map                         : Ok
  42: Synthesize stat config                     : Ok
  43: Synthesize stat                            : Ok
  44: Synthesize stat round                      : Ok
  45: Synthesize attr update                     : Ok
  46: Event times                                : Ok
  47: Read backward ring buffer                  : Ok
  48: Print cpu map                              : Ok
  49: Probe SDT events                           : Ok
  50: is_printable_array                         : Ok
  51: Print bitmap                               : Ok
  52: perf hooks                                 : Ok
  53: builtin clang support                      : Skip (not compiled in)
  54: unit_number__scnprintf                     : Ok
  55: x86 rdpmc                                  : Ok
  56: Convert perf time to TSC                   : Ok
  57: DWARF unwind                               : Ok
  58: x86 instruction decoder - new instructions : Ok
  59: Intel cqm nmi context read                 : Skip
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_install_O: make install 
            make_install_bin_O: make install-bin 
         make_with_clangllvm_O: make LIBCLANGLLVM=1 
                   make_pure_O: make 
           make_no_libbionic_O: make NO_LIBBIONIC=1 
           make_no_backtrace_O: make NO_BACKTRACE=1 
                make_no_newt_O: make NO_NEWT=1 
                  make_debug_O: make DEBUG=1 
                    make_doc_O: make doc 
               make_no_slang_O: make NO_SLANG=1 
                 make_static_O: make LDFLAGS=-static 
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 
              make_no_libbpf_O: make NO_LIBBPF=1 
       make_util_pmu_bison_o_O: make util/pmu-bison.o 
                 make_perf_o_O: make perf.o 
             make_no_libnuma_O: make NO_LIBNUMA=1 
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1 
            make_no_demangle_O: make NO_DEMANGLE=1 
            make_no_auxtrace_O: make NO_AUXTRACE=1 
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1 
                   make_help_O: make help 
             make_util_map_o_O: make util/map.o 
             make_no_libperl_O: make NO_LIBPERL=1 
                make_no_gtk2_O: make NO_GTK2=1 
         make_install_prefix_O: make install prefix=/tmp/krava 
              make_clean_all_O: make clean all 
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1 
           make_no_libunwind_O: make NO_LIBUNWIND=1 
           make_no_libpython_O: make NO_LIBPYTHON=1 
            make_no_libaudit_O: make NO_LIBAUDIT=1 
                   make_tags_O: make tags 
        make_with_babeltrace_O: make LIBBABELTRACE=1 
              make_no_libelf_O: make NO_LIBELF=1 
   make_install_prefix_slash_O: make install prefix=/tmp/krava/ 
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
