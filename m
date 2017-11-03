From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/19] perf/core improvements and fixes
Date: Fri,  3 Nov 2017 10:54:44 -0300
Message-ID: <20171103135503.4921-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Andrey Vagin <avagin@openvz.org>, Andy Lutomirski <luto@kernel.org>, Changbin Du <changbin.du@intel.com>, Cyrill Gorcunov <gorcunov@openvz.org>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, kernel-team@lge.com, Michael Ellerman <mpe@ellerman.id.au>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	A bit of trivia info is now automatically shown in the container
builds, the gcc version used to build the tools, that gets changed as
the distros update gcc and as I update the container build images :-)

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 0d3d73aac2ff05c78387aa9dcc2c8aa3804405e7:

  perf/core: Rewrite event timekeeping (2017-10-27 10:31:59 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171103

for you to fetch changes up to 7285cf3325b4a1dfb336d31eebc27dfbc30fb9aa:

  perf srcline: Show correct function name for srcline of callchains (2017-11-01 11:44:38 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Beautify the 'kcmp' and 'prctl' syscall arguments in 'perf trace'
  (Arnaldo Carvalho de Melo)

- Implement a way to print formatted output to per-event files in 'perf script'
  to facilitate generate flamegraphs, elliminating the need to write scripts to
  do that separation (yuzhoujian, Arnaldo Carvalho de Melo)

  Make 'perf stat --per-thread' update shadow stats to show metrics (Jiri Olsa)

- Fix double mapping al->addr in callchain processing for children without self
  period (Namhyung Kim)

- Fix memory leak in addr2inlines() when libbfd is not used (Namhyung Kim)

- Show correct function name for srcline of callchains when libbfd is not used
  (Namhyung Kim)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (11):
      perf script: Add a few missing conversions to fprintf style
      perf script: Use pr_debug where appropriate
      perf script: Use event_format__fprintf()
      perf evsel: Restore evsel->priv as a tool private area
      perf script: Allow creating per-event dump files
      tools include uapi: Grab a copy of linux/prctl.h
      perf trace beauty prctl: Generate 'option' string table from kernel headers
      perf script: Print information about per-event-dump files
      tools include uapi: Grab a copy of linux/kcmp.h
      perf trace beauty: Implement pid_fd beautifier
      perf trace beauty kcmp: Beautify arguments

Jiri Olsa (5):
      perf tools: Rename struct perf_data_file to perf_data
      perf tools: Add struct perf_data_file
      perf tools: Add perf_data_file__write function
      perf stat: Move the shadow stats scale computation in perf_stat__update_shadow_stats
      perf stat: Make --per-thread update shadow stats to show metrics

Namhyung Kim (3):
      perf callchain: Fix double mapping al->addr for children without self period
      perf srcline: Fix memory leak in addr2inlines()
      perf srcline: Show correct function name for srcline of callchains

 tools/include/uapi/linux/kcmp.h          |  27 +++++
 tools/include/uapi/linux/prctl.h         | 200 +++++++++++++++++++++++++++++++
 tools/perf/Documentation/perf-script.txt |   4 +
 tools/perf/Makefile.perf                 |  22 +++-
 tools/perf/builtin-annotate.c            |  10 +-
 tools/perf/builtin-buildid-cache.c       |   8 +-
 tools/perf/builtin-buildid-list.c        |  16 +--
 tools/perf/builtin-c2c.c                 |  10 +-
 tools/perf/builtin-diff.c                |  18 +--
 tools/perf/builtin-evlist.c              |  12 +-
 tools/perf/builtin-inject.c              |  36 +++---
 tools/perf/builtin-kmem.c                |   8 +-
 tools/perf/builtin-kvm.c                 |  14 ++-
 tools/perf/builtin-lock.c                |  12 +-
 tools/perf/builtin-mem.c                 |  12 +-
 tools/perf/builtin-record.c              |  50 ++++----
 tools/perf/builtin-report.c              |  14 +--
 tools/perf/builtin-sched.c               |  24 ++--
 tools/perf/builtin-script.c              | 169 ++++++++++++++++++++++----
 tools/perf/builtin-stat.c                |  39 +++---
 tools/perf/builtin-timechart.c           |  14 ++-
 tools/perf/builtin-trace.c               |  40 ++++++-
 tools/perf/check-headers.sh              |   2 +
 tools/perf/tests/topology.c              |  22 ++--
 tools/perf/trace/beauty/Build            |   2 +
 tools/perf/trace/beauty/beauty.h         |  18 +++
 tools/perf/trace/beauty/kcmp.c           |  44 +++++++
 tools/perf/trace/beauty/kcmp_type.sh     |  10 ++
 tools/perf/trace/beauty/prctl.c          |  82 +++++++++++++
 tools/perf/trace/beauty/prctl_option.sh  |  17 +++
 tools/perf/util/auxtrace.c               |   4 +-
 tools/perf/util/callchain.c              |   5 +-
 tools/perf/util/data-convert-bt.c        |  12 +-
 tools/perf/util/data.c                   |  94 ++++++++-------
 tools/perf/util/data.h                   |  38 +++---
 tools/perf/util/evsel.h                  |   3 +
 tools/perf/util/header.c                 |  20 ++--
 tools/perf/util/intel-bts.c              |   6 +-
 tools/perf/util/intel-pt.c               |   6 +-
 tools/perf/util/jit.h                    |   2 +-
 tools/perf/util/jitdump.c                |  10 +-
 tools/perf/util/session.c                |  44 +++----
 tools/perf/util/session.h                |   4 +-
 tools/perf/util/srcline.c                | 102 +++++++++-------
 tools/perf/util/stat-shadow.c            |  48 ++++----
 tools/perf/util/stat.c                   |  24 ++--
 tools/perf/util/stat.h                   |   2 +-
 47 files changed, 999 insertions(+), 381 deletions(-)
 create mode 100644 tools/include/uapi/linux/kcmp.h
 create mode 100644 tools/include/uapi/linux/prctl.h
 create mode 100644 tools/perf/trace/beauty/kcmp.c
 create mode 100755 tools/perf/trace/beauty/kcmp_type.sh
 create mode 100644 tools/perf/trace/beauty/prctl.c
 create mode 100755 tools/perf/trace/beauty/prctl_option.sh

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support.  Where clang is available, it is also used to build
perf with/without libelf.

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

  # dm
   1 alpine:3.4: Ok                       gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5: Ok                       gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6: Ok                       gcc (Alpine 6.3.0) 6.3.0
   4 alpine:edge: Ok                      gcc (Alpine 6.4.0) 6.4.0
   5 android-ndk:r12b-arm: Ok             arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   6 android-ndk:r15c-arm: Ok             arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   7 centos:5: Ok                         gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
   8 centos:6: Ok                         gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
   9 centos:7: Ok                         gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  10 debian:7: Ok                         gcc (Debian 4.7.2-5) 4.7.2
  11 debian:8: Ok                         gcc (Debian 4.9.2-10) 4.9.2
  12 debian:9: Ok                         gcc (Debian 6.3.0-18) 6.3.0 20170516
  13 debian:experimental: Ok              gcc (Debian 7.2.0-11) 7.2.0
  14 debian:experimental-x-arm64: Ok      aarch64-linux-gnu-gcc (Debian 7.2.0-6) 7.2.0
  15 debian:experimental-x-mips: Ok       mips-linux-gnu-gcc (Debian 7.2.0-6) 7.2.0
  16 debian:experimental-x-mips64: Ok     mips64-linux-gnuabi64-gcc (Debian 7.2.0-6) 7.2.0
  17 debian:experimental-x-mipsel: Ok     mipsel-linux-gnu-gcc (Debian 7.2.0-6) 7.2.0
  18 fedora:20: Ok                        gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  19 fedora:21: Ok                        gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  20 fedora:22: Ok                        gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  21 fedora:23: Ok                        gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  22 fedora:24: Ok                        gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  23 fedora:24-x-ARC-uClibc: Ok           arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  24 fedora:25: Ok                        gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  25 fedora:26: Ok                        gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  26 fedora:rawhide: Ok                   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  27 mageia:5: Ok                         gcc (GCC) 4.9.2
  28 mageia:6: Ok                         gcc (Mageia 5.4.0-5.mga6) 5.4.0
  29 opensuse:42.1: Ok                    gcc (SUSE Linux) 4.8.5
  30 opensuse:42.2: Ok                    gcc (SUSE Linux) 4.8.5
  31 opensuse:42.3: Ok                    gcc (SUSE Linux) 4.8.5
  32 opensuse:tumbleweed: Ok              gcc (SUSE Linux) 7.2.1 20170901 [gcc-7-branch revision 251580]
  33 oraclelinux:6: Ok                    gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  34 oraclelinux:7: Ok                    gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  35 ubuntu:12.04.5: Ok                   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  36 ubuntu:14.04.4: Ok                   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  37 ubuntu:14.04.4-x-linaro-arm64: Ok    aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  38 ubuntu:15.04: Ok                     gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  39 ubuntu:15.10: Ok                     gcc (Ubuntu 5.2.1-22ubuntu2) 5.2.1 20151010
  40 ubuntu:16.04: Ok                     gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  41 ubuntu:16.04-x-arm: Ok               arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  42 ubuntu:16.04-x-arm64: Ok             aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  43 ubuntu:16.04-x-powerpc: Ok           powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 ubuntu:16.04-x-powerpc64: Ok         powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  45 ubuntu:16.04-x-powerpc64el: Ok       powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-s390: Ok              s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.10: Ok                     gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  48 ubuntu:17.04: Ok                     gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  49 ubuntu:17.10: Ok                     gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  # 

  # uname -a
  Linux jouet 4.14.0-rc6+ #1 SMP Tue Oct 31 14:43:51 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  60: Use vfs_getname probe to get syscall args filenames   : Ok
  61: probe libc's inet_pton & backtrace it with ping       : Ok
  62: Check open filename arg using perf trace + vfs_getname: Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  # 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_clean_all_O: make clean all
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_no_demangle_O: make NO_DEMANGLE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_gtk2_O: make NO_GTK2=1
                 make_static_O: make LDFLAGS=-static
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_pure_O: make
            make_no_libaudit_O: make NO_LIBAUDIT=1
                  make_debug_O: make DEBUG=1
                make_no_newt_O: make NO_NEWT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
               make_no_slang_O: make NO_SLANG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libbionic_O: make NO_LIBBIONIC=1
                    make_doc_O: make doc
                   make_tags_O: make tags
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_help_O: make help
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_perf_o_O: make perf.o
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
