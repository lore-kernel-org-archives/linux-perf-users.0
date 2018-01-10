From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/27] perf/core improvements and fixes
Date: Wed, 10 Jan 2018 18:28:17 -0300
Message-ID: <20180110212844.12441-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751366AbeAJV24 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Jan 2018 16:28:56 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 9128d3ed9de3882c83b927eb553d5d44c84505f5:

  perf/x86/msr: Clean up the code (2018-01-06 12:18:40 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.16-20180110

for you to fetch changes up to 5d64db2966e38bfd99114ecf0b54f97d33023dcd:

  tools headers: Synchronize kernel <-> tooling headers (2018-01-10 12:46:54 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- The 'perf test bpf' entry hooked a eBPF proggie to the
  SyS_epoll_wait() kernel function and expected it to be hit when calling
  the epoll_wait() libc wrapper, which changed recently, in systems such
  as Fedora 27, with the glibc wrapper calling instead the epoll_pwait()
  syscall, so switch to epoll_pwait() for both the kernel and libc
  function, getting it to work both in old and new systems (Arnaldo Carvalho de Melo)

- Beautify 'gettid' syscall result in 'perf trace', and in doing so
  noticed that we need to handle namespaces in 'perf trace', will be
  dealt with in follow up patches where we'll try to figure out if
  the recent support for namespace in tools/perf/ can be used for this
  purpose as well. (Arnaldo Carvalho de Melo)

- Introduce 'perf report --mmaps' and 'perf report --tasks' to show
  info present in 'perf.data' (Jiri Olsa, Arnaldo Carvalho de Melo)

- Synchronize kernel <-> tooling headers wrt meltdown/spectre changes
  (Arnaldo Carvalho de Melo)

- Fix a wrong offset issue when using /proc/kcore (Jin Yao)

- Fix bug that prevented annotating symbols in perf.data files
  generated with 'perf record --branch-any'  (Jin Yao)

- Add infrastructure to record first and last sample time to the
  perf.data file header, so that when processing all samples in
  a 'perf record' session, such as when doing build-id processing,
  or when specifically requesting that that info be recorded, use
  that in 'perf report --time', that also got support for percent
  slices in addition to absolute ones.

  I.e. now it is possible to ask for the samples in the 10%-20%
  time slice of a perf.data file (Jin Yao)

- Enable building with libbabeltrace by default (Jiri Olsa)

- Display perf_event_attr::namespaces when duping the attributes
  in verbose mode (Jiri Olsa)

- Allocate context task_ctx_data for child event (Jiri Olsa)

- Update comments for PERF_RECORD_ITRACE_START and PERF_RECORD_MISC_* (Jiri Olsa)

- Add support for showing PERF_RECORD_LOST events in 'perf script' (Jiri Olsa)

- Add 'perf report --stats' option to display quick statistics about
  metadata events (PERF_RECORD_*) i.e. what we get at the end of 'perf
  report -D' (Jiri Olsa)

- Fix compile error with libunwind x86 (Wang Nan)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (6):
      perf test bpf: Improve message about expected samples
      perf test bpf: Use designated struct field initializers
      perf test bpf: Hook on epoll_pwait()
      perf trace: Beautify 'gettid' syscall result
      perf report: Introduce --mmaps
      tools headers: Synchronize kernel <-> tooling headers

Jin Yao (8):
      perf report: Fix a wrong offset issue when using /proc/kcore
      perf report: Fix a no annotate browser displayed issue
      perf header: Add infrastructure to record first and last sample time
      perf record: Record the first and last sample time in the header
      perf tools: Create function to parse time percent
      perf tools: Create function to perform multiple time range checking
      perf report: Support time percent and multiple time ranges
      perf script: Support time percent and multiple time ranges

Jiri Olsa (12):
      perf tools: Enable LIBBABELTRACE by default
      perf tools: Display perf_event_attr::namespaces debug info
      perf: Allocate context task_ctx_data for child event
      perf: Add sample_id to PERF_RECORD_ITRACE_START event comment
      perf: Make perf_callchain function static
      perf: Return empty callchain instead of NULL
      perf: Update PERF_RECORD_MISC_* comment for perf_event_header::misc bit 13
      perf script: Add support to display sample misc field
      perf script: Add support to display lost events
      perf tools: Make the tool's warning messages optional
      perf report: Add --stats option to display quick data statistics
      perf report: Add --tasks option to display monitored tasks

Wang Nan (1):
      perf tools: Fix compile error with libunwind x86

 include/uapi/linux/perf_event.h                    |  10 +-
 kernel/events/callchain.c                          |  15 --
 kernel/events/core.c                               |  54 +++--
 kernel/events/internal.h                           |   4 -
 tools/arch/x86/include/asm/cpufeatures.h           |   4 +-
 tools/arch/x86/include/asm/disabled-features.h     |   8 +-
 tools/include/uapi/linux/perf_event.h              |  10 +-
 tools/perf/Documentation/perf-record.txt           |   3 +
 tools/perf/Documentation/perf-report.txt           |  37 ++-
 tools/perf/Documentation/perf-script.txt           |  39 +++-
 tools/perf/Documentation/perf.data-file-format.txt |   4 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/x86/util/unwind-libunwind.c        |   2 +-
 tools/perf/builtin-record.c                        |  18 +-
 tools/perf/builtin-report.c                        | 249 ++++++++++++++++++++-
 tools/perf/builtin-script.c                        | 136 +++++++++--
 tools/perf/builtin-trace.c                         |   1 +
 tools/perf/tests/bpf-script-example.c              |   4 +-
 tools/perf/tests/bpf.c                             |  65 +++---
 tools/perf/util/annotate.c                         |   3 +-
 tools/perf/util/event.c                            |   8 +
 tools/perf/util/event.h                            |   1 +
 tools/perf/util/evlist.h                           |   2 +
 tools/perf/util/evsel.c                            |   2 +
 tools/perf/util/header.c                           |  60 +++++
 tools/perf/util/header.h                           |   1 +
 tools/perf/util/machine.c                          |   2 +-
 tools/perf/util/map.c                              |   2 +-
 tools/perf/util/session.c                          |   6 +-
 tools/perf/util/sort.c                             |  16 +-
 tools/perf/util/srcline.c                          |   9 +-
 tools/perf/util/srcline.h                          |   5 +-
 tools/perf/util/time-utils.c                       | 233 ++++++++++++++++++-
 tools/perf/util/time-utils.h                       |   6 +
 tools/perf/util/tool.h                             |   1 +
 36 files changed, 884 insertions(+), 140 deletions(-)

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
   1 36.42 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 43.36 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 42.02 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 39.44 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 34.12 amazonlinux:1                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-11)
   6 43.12 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   7 25.83 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 27.52 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   9 21.87 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  10 31.57 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  11 37.87 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  12 35.19 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  13 36.66 debian:8                      : Ok   gcc (Debian 4.9.2-10) 4.9.2
  14 60.91 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  15 63.71 debian:experimental           : Ok   gcc (Debian 7.2.0-18) 7.2.0
  16 41.01 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17 37.53 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  18 35.28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  19 38.06 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  20 37.48 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  21 40.09 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  22 38.66 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 38.56 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  24 40.34 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  25 33.60 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  26 76.30 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  27 83.91 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28 76.94 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  29 84.12 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-4)
  30 39.65 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0 p1.1) 6.4.0
  31 40.31 mageia:5                      : Ok   gcc (GCC) 4.9.2
  32 40.96 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  33 40.56 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  34 44.99 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  35 39.41 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  36 82.57 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.2.1 20171020 [gcc-7-branch revision 253932]
  37 31.39 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  38 37.82 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  39 29.52 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  40 35.32 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  41 31.84 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
  42 59.60 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  43 32.43 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 30.82 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 30.35 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 32.15 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  47 31.77 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 31.49 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49 62.81 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  50 64.87 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  51 63.93 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  52 64.43 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-18ubuntu2) 7.2.0
  # 

  # uname -a
  Linux seventh 4.15.0-rc7+ #2 SMP Wed Jan 10 11:53:43 -03 2018 x86_64 x86_64 x86_64 GNU/Linux
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
  61: Check open filename arg using perf trace + vfs_getname: Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                 make_perf_o_O: make perf.o
                 make_static_O: make LDFLAGS=-static
                    make_doc_O: make doc
             make_no_libperl_O: make NO_LIBPERL=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                   make_tags_O: make tags
       make_util_pmu_bison_o_O: make util/pmu-bison.o
         make_install_prefix_O: make install prefix=/tmp/krava
              make_clean_all_O: make clean all
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_util_map_o_O: make util/map.o
                  make_debug_O: make DEBUG=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_help_O: make help
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_install_O: make install
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_pure_O: make
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
            make_install_bin_O: make install-bin
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
