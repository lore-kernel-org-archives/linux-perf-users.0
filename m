From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/15] perf/core inlining improvements
Date: Wed, 25 Oct 2017 12:59:58 -0300
Message-ID: <20171025160013.11136-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750974AbdJYQAa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 25 Oct 2017 12:00:30 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Milian Wolff <milian.wolff@kdab.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling, this is Milian's v7 plus some fixes
acked by Namhyung after some discussion among the three of us, I
probably need to pick some more patches that are related to this area,
but lets make some progress and merge this kit,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 9b7c85473cc2fa6fc4a7f87636ff2b69742b82b7:

  Merge tag 'perf-core-for-mingo-4.15-20171023' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-10-24 10:53:04 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171025

for you to fetch changes up to d8a88dd243a170a226aba33e7c53704db2f82aa6:

  perf util: Enable handling of inlined frames by default (2017-10-25 10:50:47 -0300)

----------------------------------------------------------------
perf/core inline improvements:

From Milian's cover letter: (Milian Wolff)

This series of patches completely reworks the way inline frames are
handled.  Instead of querying for the inline nodes on-demand in the
individual tools, we now create proper callchain nodes for inlined
frames. The advantages this approach brings are numerous:

- Less duplicated code in the individual browser

- Aggregated cost for inlined frames for the --children top-down list

- Various bug fixes that arose from querying for a srcline/symbol based on
  the IP of a sample, which will always point to the last inlined frame
  instead of the corresponding non-inlined frame

- Overall much better support for visualizing cost for heavily-inlined C++
  code, which simply was confusing and unreliable before

- srcline honors the global setting as to whether full paths or basenames
  should be shown

- Caches for inlined frames and srcline information, which allow us to
  enable inline frame handling by default

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Milian Wolff (15):
      perf report: Remove code to handle inline frames from browsers
      perf callchain: Store srcline in callchain_cursor_node
      perf callchain: Refactor inline_list to operate on symbols
      perf callchain: Refactor inline_list to store srcline string directly
      perf callchain: Create real callchain entries for inlined frames
      perf report: Fall-back to function name comparison for -g srcline
      perf callchain: Mark inlined frames in output by " (inlined)" suffix
      perf script: Mark inlined frames and do not print DSO for them
      perf callchain: Compare symbol name for inlined frames when matching
      perf report: Compare symbol name for inlined frames when sorting
      perf report: Properly handle branch count in match_chain()
      perf report: Cache failed lookups of inlined frames
      perf report: Cache srclines for callchain nodes
      perf report: Use srcline from callchain for hist entries
      perf util: Enable handling of inlined frames by default

 tools/perf/Documentation/perf-report.txt |   3 +-
 tools/perf/Documentation/perf-script.txt |   3 +-
 tools/perf/ui/browsers/hists.c           | 180 ++-------------------
 tools/perf/ui/stdio/hist.c               |  77 +--------
 tools/perf/util/callchain.c              | 174 +++++++++++---------
 tools/perf/util/callchain.h              |   6 +-
 tools/perf/util/dso.c                    |   7 +
 tools/perf/util/dso.h                    |   2 +
 tools/perf/util/event.c                  |   1 +
 tools/perf/util/evsel_fprintf.c          |  37 +----
 tools/perf/util/hist.c                   |   7 +-
 tools/perf/util/machine.c                |  65 +++++++-
 tools/perf/util/sort.c                   |   6 +
 tools/perf/util/sort.h                   |   1 -
 tools/perf/util/srcline.c                | 268 +++++++++++++++++++++++++------
 tools/perf/util/srcline.h                |  26 ++-
 tools/perf/util/symbol.c                 |   1 +
 tools/perf/util/symbol.h                 |   2 +
 18 files changed, 443 insertions(+), 423 deletions(-)

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


[root@seventh fedora]# cd ..
[root@seventh linux-perf-tools-build]# time dm
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
  29 mageia:6: Ok
  30 opensuse:42.1: Ok
  31 opensuse:42.2: Ok
  32 opensuse:42.3: Ok
  33 opensuse:tumbleweed: Ok
  34 oraclelinux:6: Ok
  35 ubuntu:12.04.5: Ok
  36 ubuntu:14.04.4: Ok
  37 ubuntu:14.04.4-x-linaro-arm64: Ok
  38 ubuntu:15.04: Ok
  39 ubuntu:16.04: Ok
  40 ubuntu:16.04-x-arm: Ok
  41 ubuntu:16.04-x-arm64: Ok
  42 ubuntu:16.04-x-powerpc: Ok
  43 ubuntu:16.04-x-powerpc64: Ok
  44 ubuntu:16.04-x-powerpc64el: Ok
  45 ubuntu:16.04-x-s390: Ok
  46 ubuntu:16.10: Ok
  47 ubuntu:17.04: Ok
  48 ubuntu:17.10: Ok
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
                   make_tags_O: make tags
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
               make_no_slang_O: make NO_SLANG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_perf_o_O: make perf.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_util_map_o_O: make util/map.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                    make_doc_O: make doc
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_static_O: make LDFLAGS=-static
            make_install_bin_O: make install-bin
                   make_pure_O: make
              make_no_libbpf_O: make NO_LIBBPF=1
                   make_help_O: make help
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_clean_all_O: make clean all
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_newt_O: make NO_NEWT=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                  make_debug_O: make DEBUG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_install_O: make install
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
