From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/14] perf/core clang fixes
Date: Wed, 15 Feb 2017 16:04:10 -0300
Message-ID: <20170215190424.18687-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Davidlohr Bueso <dbueso@suse.de>, Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, Jakub Jelen <jjelen@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Here is a bunch of changes to allow buildint tools/perf/ with CC=clang,
there are a few more to allow building the python code, but I already manage to
finish the build without it.

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 277d6f1dcae09aed63cd4c7900a280b0e18cf2ca:

  Merge tag 'perf-core-for-mingo-4.11-20170213' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-02-14 07:29:38 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.11-20170215

for you to fetch changes up to 34a0548f01626b01c9e98d9627812c3c9f6b6f7d:

  perf tools: Add missing parse_events_error() prototype (2017-02-15 11:20:49 -0300)

----------------------------------------------------------------
perf/core clang fixes:

Changes to make tools/{perf,lib/{bpf,traceevent,api}} build with
CC=clang, to, for instance, take advantage of warnings (Arnaldo Carvalho de Melo):

- Conditionally request some warning options not available on clang

- Set the maximum optimization level to -O3 when using CC=clang, leave
  the previous setting of -O6 otherwise.

- Make it an error to pass a signed value to OPTION_UINTEGER, so that
  we can remove abs(unsigned int) calls in 'perf bench futex'.

- Make sure dprintf() is not defined before using that name in 'perf bench numa'

- Avoid using field after variable sized type, its a GNU extension, use
  equivalent code.

- Fix some bugs where some variables could be used unitialized,
  something not caught by gcc.

- Fix some spots where we were testing struct->array[] members against
  NULL, it will always evaluate to 'true'.

- Add missing parse_events_error() prototype in the bison file.

There are still one problem when trying to build the python support, but
this are the 'size' outputs for 'make -C tools/perf NO_LIBPYTHON' for
gcc and clang builds:

  DW_AT_producer: clang version 4.0.0 (http://llvm.org/git/clang.git f5be8ba13adc4ba1011a7ccd60c844bd60427c1c) (ht

  $ size ~/bin/perf
     text    data     bss     dec     hex     filename
  3447514  831320 23901696  28180530  1ae0032 /home/acme/bin/perf

  DW_AT_producer: GNU C99 6.3.1 20161221 (Red Hat 6.3.1-1) -mtune=generic -march=x86-64 -ggdb3 -O6 -std=gnu99
+-fno-omit-frame-pointer -funwind-tables -fstack-protector-all

  $ size ~/bin/perf
     text    data     bss     dec     hex     filename
  3671662  836480 23902752  28410894  1b1840e /home/acme/bin/perf

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (14):
      tools: Suppress request for warning options not existent in clang
      tools: Set the maximum optimization level according to the compiler being used
      tools lib subcmd: Make it an error to pass a signed value to OPTION_UINTEGER
      Revert "perf bench futex: Sanitize numeric parameters"
      perf bench numa: Make sure dprintf() is not defined
      perf tests: Synthesize struct instead of using field after variable sized type
      perf record: Do not put a variable sized type not at the end of a struct
      perf tools: Do not put a variable sized type not at the end of a struct
      perf probe: Avoid accessing uninitialized 'map' variable
      perf evsel: Do not put a variable sized type not at the end of a struct
      perf intel pt decoder: clang has no -Wno-override-init
      perf tools: Be consistent on the type of map->symbols[] interator
      perf pmu: Fix check for unset alias->unit array
      perf tools: Add missing parse_events_error() prototype

 tools/lib/api/Makefile                    |  8 +++-
 tools/lib/subcmd/Makefile                 |  8 +++-
 tools/lib/subcmd/parse-options.c          |  4 ++
 tools/perf/Makefile.config                |  4 ++
 tools/perf/bench/futex-hash.c             |  4 --
 tools/perf/bench/futex-lock-pi.c          |  3 --
 tools/perf/bench/futex-requeue.c          |  2 -
 tools/perf/bench/futex-wake-parallel.c    |  4 --
 tools/perf/bench/futex-wake.c             |  3 --
 tools/perf/bench/futex.h                  |  4 --
 tools/perf/bench/numa.c                   |  1 +
 tools/perf/builtin-record.c               | 17 +++++----
 tools/perf/tests/parse-no-sample-id-all.c | 19 ++++------
 tools/perf/util/evsel.c                   | 62 ++++++++++++++-----------------
 tools/perf/util/intel-pt-decoder/Build    |  6 ++-
 tools/perf/util/machine.c                 |  4 +-
 tools/perf/util/parse-events.c            | 15 +++-----
 tools/perf/util/parse-events.y            |  2 +
 tools/perf/util/pmu.c                     |  4 +-
 tools/perf/util/probe-event.c             |  2 +-
 tools/perf/util/session.c                 |  2 +-
 tools/scripts/Makefile.include            |  5 ++-
 22 files changed, 91 insertions(+), 92 deletions(-)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.

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

  # time dm
   1 alpine:3.4: Ok
   2 android-ndk:r12b-arm: Ok
   3 archlinux:latest: Ok
   4 centos:5: Ok
   5 centos:6: Ok
   6 centos:7: Ok
   7 debian:7: Ok
   8 debian:8: Ok
   9 debian:experimental: Ok
  10 debian:experimental-x-arm64: Ok
  11 debian:experimental-x-mips: Ok
  12 debian:experimental-x-mips64: Ok
  13 debian:experimental-x-mipsel: Ok
  14 fedora:20: Ok
  15 fedora:21: Ok
  16 fedora:22: Ok
  17 fedora:23: Ok
  18 fedora:24: Ok
  19 fedora:24-x-ARC-uClibc: Ok
  20 fedora:25: Ok
  21 fedora:rawhide: Ok
  22 mageia:5: Ok
  23 opensuse:13.2: Ok
  24 opensuse:42.1: Ok
  25 opensuse:tumbleweed: Ok
  26 ubuntu:12.04.5: Ok
  27 ubuntu:14.04.4-x-linaro-arm64: Ok
  28 ubuntu:15.10: Ok
  29 ubuntu:16.04: Ok
  30 ubuntu:16.04-x-arm: Ok
  31 ubuntu:16.04-x-arm64: Ok
  32 ubuntu:16.04-x-powerpc: Ok
  33 ubuntu:16.04-x-powerpc64: Ok
  34 ubuntu:16.04-x-powerpc64el: Ok
  35 ubuntu:16.04-x-s390: Ok
  36 ubuntu:16.10: Ok
  #
  # uname -a
  Linux jouet 4.10.0-rc8 #2 SMP Wed Feb 15 15:26:36 BRT 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: PERF_RECORD_* events & perf_sample fields  : Ok
   7: Parse perf pmu format                      : Ok
   8: DSO data read                              : Ok
   9: DSO data cache                             : Ok
  10: DSO data reopen                            : Ok
  11: Roundtrip evsel->name                      : Ok
  12: Parse sched tracepoints fields             : Ok
  13: syscalls:sys_enter_openat event fields     : Ok
  14: Setup struct perf_event_attr               : Ok
  15: Match and link multiple hists              : Ok
  16: 'import perf' in python                    : Ok
  17: Breakpoint overflow signal handler         : Ok
  18: Breakpoint overflow sampling               : Ok
  19: Number of exit events of a simple workload : Ok
  20: Software clock events period values        : Ok
  21: Object code reading                        : Ok
  22: Sample parsing                             : Ok
  23: Use a dummy software event to keep tracking: Ok
  24: Parse with no sample_id_all bit set        : Ok
  25: Filter hist entries                        : Ok
  26: Lookup mmap thread                         : Ok
  27: Share thread mg                            : Ok
  28: Sort output of hist entries                : Ok
  29: Cumulate child hist entries                : Ok
  30: Track with sched_switch                    : Ok
  31: Filter fds with revents mask in a fdarray  : Ok
  32: Add fd to a fdarray, making it autogrow    : Ok
  33: kmod_path__parse                           : Ok
  34: Thread map                                 : Ok
  35: LLVM search and compile                    :
  35.1: Basic BPF llvm compile                    : Ok
  35.2: kbuild searching                          : Ok
  35.3: Compile source for BPF prologue generation: Ok
  35.4: Compile source for BPF relocation         : Ok
  36: Session topology                           : Ok
  37: BPF filter                                 :
  37.1: Basic BPF filtering                      : Ok
  37.2: BPF pinning                              : Ok
  37.3: BPF prologue generation                  : Ok
  37.4: BPF relocation checker                   : Ok
  38: Synthesize thread map                      : Ok
  39: Remove thread map                          : Ok
  40: Synthesize cpu map                         : Ok
  41: Synthesize stat config                     : Ok
  42: Synthesize stat                            : Ok
  43: Synthesize stat round                      : Ok
  44: Synthesize attr update                     : Ok
  45: Event times                                : Ok
  46: Read backward ring buffer                  : Ok
  47: Print cpu map                              : Ok
  48: Probe SDT events                           : Ok
  49: is_printable_array                         : Ok
  50: Print bitmap                               : Ok
  51: perf hooks                                 : Ok
  52: builtin clang support                      : Skip (not compiled in)
  53: unit_number__scnprintf                     : Ok
  54: x86 rdpmc                                  : Ok
  55: Convert perf time to TSC                   : Ok
  56: DWARF unwind                               : Ok
  57: x86 instruction decoder - new instructions : Ok
  58: Intel cqm nmi context read                 : Skip
  #  
  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
         make_install_prefix_O: make install prefix=/tmp/krava
               make_no_slang_O: make NO_SLANG=1
                   make_help_O: make help
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
                make_no_gtk2_O: make NO_GTK2=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_util_map_o_O: make util/map.o
                 make_perf_o_O: make perf.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
                   make_pure_O: make
                  make_debug_O: make DEBUG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libpython_O: make NO_LIBPYTHON=1
  make FEATURE_DUMP_COPY=/home/acme/git/linux/tools/perf/BUILD_TEST_FEATURE_DUMP_STATIC LDFLAGS='-static' feature-dump
                 make_static_O: make LDFLAGS=-static
           make_no_backtrace_O: make NO_BACKTRACE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_install_O: make install
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
              make_no_libelf_O: make NO_LIBELF=1
                make_no_newt_O: make NO_NEWT=1
              make_clean_all_O: make clean all
                   make_tags_O: make tags
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $ perf stat make -C tools/perf build-test
