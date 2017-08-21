From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/13] perf/core improvements and fixes
Date: Mon, 21 Aug 2017 16:25:36 -0300
Message-ID: <20170821192549.17251-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, =?UTF-8?q?Daniel=20D=C3=ADaz?= <daniel.diaz@linaro.org>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@redhat.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Taeung Song <treeze.taeung@gmail.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 9881223c6cc0644cc3aeea41e1f19ea7e3041f33:

  Merge tag 'perf-core-for-mingo-4.14-20170816' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-08-17 09:41:56 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170821

for you to fetch changes up to 3a555c7799de69d73826eccc9a21948a5775d4d3:

  perf annotate browser: Circulate percent, total-period and nr-samples view (2017-08-18 11:23:20 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Support --show-nr-samples in annotate's --stdio and --tui, using
  the existing 't' toggle to circulate 'percent', 'total-period' and
  'nr-samples' as the first column (Taeung Song)

- Support FCMask and PortMask in JSON vendor events (Andi Kleen)

- Fix off by one string allocation problem in 'perf trace' (Arnaldo Carvalho de Melo)

- Use just one parse events state struct in yyparse(), fixing one
  reported segfault when a routine received a different data struct,
  smaller than the one it expected to use (Arnaldo Carvalho de Melo)

- Remove unused cpu_relax() macros, they stopped being used when
  tools/perf lived in Documentation/ (Arnaldo Carvalho de Melo)

- Fix double file test in libbpf's Makefile (Daniel Díaz):

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (1):
      perf jevents: Support FCMask and PortMask

Arnaldo Carvalho de Melo (7):
      perf trace: Fix off by one string allocation problem
      perf events parse: Remove some needless local variables
      perf events parse: Rename parsing state struct to clearer name
      perf events parse: Use just one parse events state struct
      perf events parse: Rename parse_events_parse arguments
      perf tools: Remove unused cpu_relax() macros
      perf tools: Use default CPUINFO_PROC where it fits

Daniel Díaz (1):
      tools lib bpf: Fix double file test in Makefile

Taeung Song (4):
      perf annotate stdio: Support --show-nr-samples option
      perf annotate: Document --show-total-period option
      perf annotate browser: Support --show-nr-samples option
      perf annotate browser: Circulate percent, total-period and nr-samples view

 tools/lib/bpf/Makefile                     |  4 +-
 tools/perf/Documentation/perf-annotate.txt |  6 ++
 tools/perf/builtin-annotate.c              | 16 ++++-
 tools/perf/builtin-trace.c                 |  2 +-
 tools/perf/perf-sys.h                      | 28 +--------
 tools/perf/pmu-events/jevents.c            |  2 +
 tools/perf/tests/bpf.c                     | 16 ++---
 tools/perf/ui/browsers/annotate.c          | 25 ++++++--
 tools/perf/util/annotate.c                 |  6 +-
 tools/perf/util/header.c                   |  3 -
 tools/perf/util/parse-events.c             | 96 +++++++++++++++---------------
 tools/perf/util/parse-events.h             | 19 +++---
 tools/perf/util/parse-events.y             | 94 ++++++++++++++---------------
 13 files changed, 159 insertions(+), 158 deletions(-)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf
commands with a variety of command line event specifications to then
intercept the sys_perf_event syscall to check that the perf_event_attr
fields are set up as expected, among a variety of other unit tests.

The 'perf test'  also runs shell scripts exercising the tools, checking
if they affect the system in certain ways, like setting up kprobes and
uprobes, request callchains for well known programs and check that they
are the expected ones, see if 'perf trace' beautifies system call
arguments correctly, etc.

Additionally, a new set of tests, script based, runs the tools in a live system,
setting probes in place that then gets used by 'perf trace', with its output
compared against expected results.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one. It is planned to have it run on each
of the containers mentioned above, using some container orchestration
infrastructure. Get in contact if interested in helping having this in place.

  # dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:3.6: Ok
   4 alpine:edge: Ok
   5 android-ndk:r12b-arm: Ok
   6 archlinux:latest: Ok
   7 centos:5: Ok
   8 centos:6: Ok
   9 centos:7: Ok
  10 debian:7: Ok
  11 debian:8: Ok
  12 debian:9: Ok
  13 debian:experimental: Ok
  14 debian:experimental-x-arm64: Ok
  15 debian:experimental-x-mips: Ok
  16 debian:experimental-x-mips64: Ok
  17 debian:experimental-x-mipsel: Ok
  18 fedora:20: Ok
  19 fedora:21: Ok
  20 fedora:22: Ok
  21 fedora:23: Ok
  22 fedora:24: Ok
  23 fedora:24-x-ARC-uClibc: Ok
  24 fedora:25: Ok
  25 fedora:26: Ok
  26 fedora:rawhide: Ok
  27 mageia:5: Ok
  28 opensuse:13.2: Ok
  29 opensuse:42.1: Ok
  30 opensuse:42.2: Ok
  31 opensuse:tumbleweed: Ok
  32 oraclelinux:6: Ok
  33 oraclelinux:7: Ok
  34 ubuntu:12.04.5: Ok
  35 ubuntu:14.04.4: Ok
  36 ubuntu:14.04.4-x-linaro-arm64: Ok
  37 ubuntu:15.10: Ok
  38 ubuntu:16.04: Ok
  39 ubuntu:16.04-x-arm: Ok
  40 ubuntu:16.04-x-arm64: Ok
  41 ubuntu:16.04-x-powerpc: Ok
  42 ubuntu:16.04-x-powerpc64: Ok
  43 ubuntu:16.04-x-powerpc64el: Ok
  44 ubuntu:16.04-x-s390: Ok
  45 ubuntu:16.10: Ok
  46 ubuntu:17.04: Ok
  47 ubuntu:17.10: Ok
  #

  # uname -a
  Linux jouet 4.13.0-rc4+ #2 SMP Fri Aug 11 12:39:09 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms                       : Ok
   2: Detect openat syscall event                           : Ok
   3: Detect openat syscall event on all cpus               : Ok
   4: Read samples using the mmap interface                 : Ok
   5: Parse event definition strings                        : Ok
   6: Simple expression parser                              : Ok
   7: PERF_RECORD_* events & perf_sample fields             : Ok
   8: Parse perf pmu format                                 : Ok
   9: DSO data read                                         : Ok
  10: DSO data cache                                        : Ok
  11: DSO data reopen                                       : Ok
  12: Roundtrip evsel->name                                 : Ok
  13: Parse sched tracepoints fields                        : Ok
  14: syscalls:sys_enter_openat event fields                : Ok
  15: Setup struct perf_event_attr                          : Ok
  16: Match and link multiple hists                         : Ok
  17: 'import perf' in python                               : Ok
  18: Breakpoint overflow signal handler                    : Ok
  19: Breakpoint overflow sampling                          : Ok
  20: Number of exit events of a simple workload            : Ok
  21: Software clock events period values                   : Ok
  22: Object code reading                                   : Ok
  23: Sample parsing                                        : Ok
  24: Use a dummy software event to keep tracking           : Ok
  25: Parse with no sample_id_all bit set                   : Ok
  26: Filter hist entries                                   : Ok
  27: Lookup mmap thread                                    : Ok
  28: Share thread mg                                       : Ok
  29: Sort output of hist entries                           : Ok
  30: Cumulate child hist entries                           : Ok
  31: Track with sched_switch                               : Ok
  32: Filter fds with revents mask in a fdarray             : Ok
  33: Add fd to a fdarray, making it autogrow               : Ok
  34: kmod_path__parse                                      : Ok
  35: Thread map                                            : Ok
  36: LLVM search and compile                               :
  36.1: Basic BPF llvm compile                              : Ok
  36.2: kbuild searching                                    : Ok
  36.3: Compile source for BPF prologue generation          : Ok
  36.4: Compile source for BPF relocation                   : Ok
  37: Session topology                                      : Ok
  38: BPF filter                                            :
  38.1: Basic BPF filtering                                 : Ok
  38.2: BPF pinning                                         : Ok
  38.3: BPF prologue generation                             : Ok
  38.4: BPF relocation checker                              : Ok
  39: Synthesize thread map                                 : Ok
  40: Remove thread map                                     : Ok
  41: Synthesize cpu map                                    : Ok
  42: Synthesize stat config                                : Ok
  43: Synthesize stat                                       : Ok
  44: Synthesize stat round                                 : Ok
  45: Synthesize attr update                                : Ok
  46: Event times                                           : Ok
  47: Read backward ring buffer                             : Ok
  48: Print cpu map                                         : Ok
  49: Probe SDT events                                      : Ok
  50: is_printable_array                                    : Ok
  51: Print bitmap                                          : Ok
  52: perf hooks                                            : Ok
  53: builtin clang support                                 : Skip (not compiled in)
  54: unit_number__scnprintf                                : Ok
  55: x86 rdpmc                                             : Ok
  56: Convert perf time to TSC                              : Ok
  57: DWARF unwind                                          : Ok
  58: x86 instruction decoder - new instructions            : Ok
  59: Intel cqm nmi context read                            : Skip
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_util_map_o_O: make util/map.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_install_O: make install
                   make_tags_O: make tags
                   make_pure_O: make
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                    make_doc_O: make doc
              make_no_libelf_O: make NO_LIBELF=1
               make_no_slang_O: make NO_SLANG=1
                   make_help_O: make help
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
                  make_debug_O: make DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_install_bin_O: make install-bin
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
                make_no_gtk2_O: make NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
              make_clean_all_O: make clean all
            make_no_demangle_O: make NO_DEMANGLE=1
                make_no_newt_O: make NO_NEWT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
