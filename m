From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/24] perf/core improvements and fixes
Date: Mon, 23 Oct 2017 20:47:12 -0300
Message-ID: <20171023234736.5335-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751116AbdJWXru (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 23 Oct 2017 19:47:50 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, yuzhoujian <yuzhoujian@didichuxing.com>Arnaldo

Hi Ingo,

	Please consider pulling, hopefully the next batch will have a
few other interesting patchkits, from Jin Yao, Kan Liang and Milian
Wolff.

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 8776fe75dc0e263ed2056ea9896c2267599dc447:

  lkdtm, kprobes: Convert from jprobes to kprobes (2017-10-23 13:52:45 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171023

for you to fetch changes up to 65db92e0965ab56e8031d5c804f26d5be0e47047:

  perf vendor events: Add Goldmont Plus V1 event file (2017-10-23 16:30:54 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Update vendor events JSON metrics for Intel's Broadwell, Broadwell
  Server, Haswell, Haswell Server, IvyBridge, IvyTown, JakeTown, Sandy
  Bridge, Skylake and SkyLake Server (Andi Kleen)

- Add vendor event file for Intel's Goldmont Plus V1 (Kan Liang)

- Move perf_mmap methods from 'perf record' and evlist.c to a separate
  mmap.[ch] pair, to better separate things and pave the way for further
  work on multithreading tools (Arnaldo Carvalho de Melo)

- Do not check ABI headers in a detached tarball build, as it the kernel
  headers from where we copied tools/include/ are by definition not
  available (Arnaldo Carvalho de Melo)

- Make 'perf script' use fprintf() like printing, i.e. receiving a FILE
  pointer so that it gets consistent with other tools/ code and allows
  for printing to per-event files (Arnaldo Carvalho de Melo)

- Error handling fixes (resource release on exit) for 'perf script'
  and 'perf kmem' (Christophe JAILLET)

- Make some 'perf event attr' tests optional on virtual machines, where
  tested counters are not available (Jiri Olsa)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (12):
      perf vendor events: Update JSON metrics for Broadwell
      perf vendor events: Update JSON metrics for Broadwell Server
      perf vendor events: Update JSON metrics for Haswell
      perf vendor events: Update JSON metrics for Haswell Server
      perf vendor events: Update JSON metrics for IvyBridge
      perf vendor events: Update JSON metrics for IvyTown
      perf vendor events: Update JSON metrics for JakeTown
      perf vendor events: Update JSON metrics for Sandy Bridge
      perf vendor events: Update JSON metrics for Skylake
      perf vendor events: Update JSON metrics for Skylake Server
      perf list: Fix group description in the man page
      perf vendor events: Fix incorrect cmask syntax for some Intel metrics

Arnaldo Carvalho de Melo (7):
      perf mmap: Move perf_mmap and methods to separate mmap.[ch] files
      perf record: Make record__mmap_read generic
      perf mmap: Adopt push method from builtin-record.c
      perf tools: Do not check ABI headers in a detached tarball build
      perf tools: Introduce binary__fprintf()
      perf script: Use fprintf like printing uniformly
      perf namespaces: Add more appropriate set of headers

Christophe JAILLET (2):
      perf script: Fix error handling path
      perf kmem: Perform some cleanup if '--time' is given an invalid value

Jiri Olsa (2):
      perf tests attr: Make hw events optional
      perf annotate: Remove arch::cpuid_parse callback

Kan Liang (1):
      perf vendor events: Add Goldmont Plus V1 event file

 tools/perf/Documentation/perf-list.txt             |    2 +-
 tools/perf/arch/arm/annotate/instructions.c        |    3 +-
 tools/perf/arch/arm64/annotate/instructions.c      |    3 +-
 tools/perf/arch/powerpc/annotate/instructions.c    |    4 +-
 tools/perf/arch/s390/annotate/instructions.c       |    4 +-
 tools/perf/arch/x86/annotate/instructions.c        |   14 +
 tools/perf/builtin-kmem.c                          |    3 +-
 tools/perf/builtin-record.c                        |  104 +-
 tools/perf/builtin-script.c                        |  527 +++----
 tools/perf/builtin-trace.c                         |   14 +-
 tools/perf/check-headers.sh                        |    5 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   18 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   18 +-
 .../pmu-events/arch/x86/goldmontplus/cache.json    | 1453 ++++++++++++++++++++
 .../pmu-events/arch/x86/goldmontplus/frontend.json |   62 +
 .../pmu-events/arch/x86/goldmontplus/memory.json   |   38 +
 .../pmu-events/arch/x86/goldmontplus/other.json    |   98 ++
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |  544 ++++++++
 .../arch/x86/goldmontplus/virtual-memory.json      |  218 +++
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   16 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   16 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   18 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   18 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   12 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    1 +
 .../arch/x86/sandybridge/snb-metrics.json          |   12 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   20 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   42 +-
 tools/perf/tests/attr/test-stat-C0                 |    1 +
 tools/perf/tests/attr/test-stat-basic              |    1 +
 tools/perf/tests/attr/test-stat-default            |    4 +
 tools/perf/tests/attr/test-stat-detailed-1         |    8 +
 tools/perf/tests/attr/test-stat-detailed-2         |   13 +
 tools/perf/tests/attr/test-stat-detailed-3         |   13 +
 tools/perf/tests/attr/test-stat-no-inherit         |    1 +
 tools/perf/util/Build                              |    1 +
 tools/perf/util/annotate.c                         |   10 +-
 tools/perf/util/debug.c                            |   31 +-
 tools/perf/util/evlist.c                           |  248 ----
 tools/perf/util/evlist.h                           |   76 +-
 tools/perf/util/mmap.c                             |  352 +++++
 tools/perf/util/mmap.h                             |   97 ++
 tools/perf/util/namespaces.h                       |    5 +-
 tools/perf/util/print_binary.c                     |   30 +-
 tools/perf/util/print_binary.h                     |   18 +-
 tools/perf/util/python-ext-sources                 |    1 +
 46 files changed, 3367 insertions(+), 830 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/virtual-memory.json
 create mode 100644 tools/perf/util/mmap.c
 create mode 100644 tools/perf/util/mmap.h

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

     Should finally be fixed with the rc2 toolchain + -matomic for
     atomic_cmpchg -> __sync_val_compare_and_swap_4

  25 fedora:25: Ok
  26 fedora:26: Ok
  27 fedora:rawhide: Ok
  28 mageia:5: Ok
  29 opensuse:42.1: Ok
  30 opensuse:42.2: Ok
  31 opensuse:42.3: Ok
  32 opensuse:tumbleweed: Ok
  33 oraclelinux:6: Ok
  34 ubuntu:12.04.5: Ok
  35 ubuntu:14.04.4: Ok
  36 ubuntu:14.04.4-x-linaro-arm64: Ok
  37 ubuntu:15.04: Ok
  38 ubuntu:16.04: Ok
  39 ubuntu:16.04-x-arm: Ok
  40 ubuntu:16.04-x-arm64: Ok
  41 ubuntu:16.04-x-powerpc: Ok
  42 ubuntu:16.04-x-powerpc64: Ok
  43 ubuntu:16.04-x-powerpc64el: Ok
  44 ubuntu:16.04-x-s390: Ok
  45 ubuntu:16.10: Ok
  46 ubuntu:17.10: Ok
  #

  # uname -a
  Linux jouet 4.14.0-rc3+ #1 SMP Fri Oct 13 12:21:12 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
              make_clean_all_O: make clean all
           make_no_libunwind_O: make NO_LIBUNWIND=1
                  make_debug_O: make DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
               make_no_slang_O: make NO_SLANG=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                 make_perf_o_O: make perf.o
           make_no_backtrace_O: make NO_BACKTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_pure_O: make
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_tags_O: make tags
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_install_bin_O: make install-bin
                 make_static_O: make LDFLAGS=-static
            make_no_demangle_O: make NO_DEMANGLE=1
         make_install_prefix_O: make install prefix=/tmp/krava
             make_util_map_o_O: make util/map.o
              make_no_libbpf_O: make NO_LIBBPF=1
                make_no_gtk2_O: make NO_GTK2=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
