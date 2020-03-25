From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf/core improvements and fixes
Date: Wed, 25 Mar 2020 09:41:00 -0300
Message-ID: <20200325124124.32648-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Laight <David.Laight@ACULAB.COM>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, John Garry <john.garry@huawei.com>, Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>, Mike Leach <mike.leach@linaro.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Ravi Bangoria <ravi.bangoria@linux.ibm.com>, Vijay Thakkar <vijaythakkar@me.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 3442a9ecb8e72a33c28a2b969b766c659830e410:

  perf/x86/intel/uncore: Factor out __snr_uncore_mmio_init_box (2020-03-20 13:06:23 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.7-20200325

for you to fetch changes up to 0d33b34352531ff7029c58eda2321340c0ea3f5f:

  perf dso: Fix dso comparison (2020-03-24 10:57:38 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf report/top:

  Jin Yao:

  - Support annotation of unresolved symbols, just using its addresses.

  - Print addr_location.al_addr when finding a map but not a symbol, so
    that we have the address relative to the map which is what objdump
    produces, then we can match the output of perf and objdump for such
    unresolved addresses.

  - Allow sorting by non-group leaders when working with multiple events,
    be it in a explicit group, i.e. an event list surrounded by {} (e.g.
    'perf record -e '{cycles,instructions,cache-misses}', or without,
    using --group in 'perf report', e.g.:

        perf record -e cycles,instructions,cache-misses
	perf report --group --group-sort-idx 1

     That '1' will ask for the output to be sorted by 'instructions', not
     the default 'cycles'.

  - Add hotkeys to interactively resort the output when using multiple
    events, '0', '1', ... '9' to resort by the nth event, just like when
    using --group-sort-idx, as explained above.

perf stat:

  Jin Yao:

  - Align the output for interval aggregation mode.

event parsing:

  Ian Rogers:

  - Fix 3 use after frees found with clang ASAN.

perf tools:

  Jiri Olsa:

  - Unify a bit the build directory output.

perf tests:

  John Garry:

  - Add PMU events tests, checking that JSON files are properly parsed.

perf stat:

  Kajol Jain:

  - Fix printing event names of metric group with multiple events incase of overlapping events.

perf symbols:

  Leo Yan:

  - Consolidate symbol fixup issue.

vendor events AMD:

  Vijay Thakkar:

  - Restrict model detection for zen1 based processors

  - Add Zen2 events.

  - Update Zen1 events to V2.

perf cpumap:

  Christophe JAILLET:

 - Fix snprintf overflow check

DSOs:

  Ravi Bangoria:

  - Fix dso comparison wrt IDs (maj, min, etc), that had made 'perf archive'
    stop working when build-ids were not being collected.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      tools headers uapi: Update linux/in.h copy

Christophe JAILLET (1):
      perf cpumap: Fix snprintf overflow check

Ian Rogers (1):
      perf parse-events: Fix 3 use after frees found with clang ASAN

Jin Yao (7):
      perf report: Print al_addr when symbol is not found
      perf report: Support interactive annotation of code without symbols
      perf report/top TUI: Support hotkey 'a' for annotation of unresolved addresses
      perf report: Allow specifying event to be used as sort key in --group output
      perf report: Support a new key to reload the browser
      perf report/top TUI: Support hotkeys to let user select any event for sorting
      perf stat: Align the output for interval aggregation mode

Jiri Olsa (1):
      perf tools: Unify a bit the build directory output

John Garry (7):
      perf jevents: Add some test events
      perf jevents: Support test events folder
      perf pmu: Refactor pmu_add_cpu_aliases()
      perf test: Add pmu-events test
      perf pmu: Add is_pmu_core()
      perf pmu: Make pmu_uncore_alias_match() public
      perf test: Test pmu-events aliases

Kajol Jain (1):
      perf metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events

Leo Yan (1):
      perf symbols: Consolidate symbol fixup issue

Ravi Bangoria (1):
      perf dso: Fix dso comparison

Vijay Thakkar (3):
      perf vendor events amd: Restrict model detection for zen1 based processors
      perf vendor events amd: Add Zen2 events
      perf vendor events amd: Update Zen1 events to V2

 tools/include/uapi/linux/in.h                      |   2 +
 tools/perf/Documentation/perf-report.txt           |   5 +
 tools/perf/Makefile.perf                           |   9 +-
 tools/perf/arch/arm64/util/Build                   |   1 -
 tools/perf/arch/arm64/util/sym-handling.c          |  19 --
 tools/perf/arch/powerpc/util/Build                 |   1 -
 tools/perf/arch/powerpc/util/sym-handling.c        |  10 -
 tools/perf/builtin-report.c                        |  16 +-
 .../{x86/amdfam17h => test/test_cpu}/branch.json   |   0
 .../perf/pmu-events/arch/test/test_cpu/other.json  |  26 ++
 .../perf/pmu-events/arch/test/test_cpu/uncore.json |  21 ++
 .../perf/pmu-events/arch/x86/amdfam17h/cache.json  | 329 ------------------
 .../perf/pmu-events/arch/x86/amdfam17h/other.json  |  65 ----
 tools/perf/pmu-events/arch/x86/amdzen1/branch.json |  23 ++
 tools/perf/pmu-events/arch/x86/amdzen1/cache.json  | 294 ++++++++++++++++
 .../arch/x86/{amdfam17h => amdzen1}/core.json      |  15 +-
 .../x86/{amdfam17h => amdzen1}/floating-point.json |  64 +++-
 .../arch/x86/{amdfam17h => amdzen1}/memory.json    |  82 +++--
 tools/perf/pmu-events/arch/x86/amdzen1/other.json  |  56 +++
 tools/perf/pmu-events/arch/x86/amdzen2/branch.json |  52 +++
 tools/perf/pmu-events/arch/x86/amdzen2/cache.json  | 338 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/amdzen2/core.json   | 130 +++++++
 .../arch/x86/amdzen2/floating-point.json           | 140 ++++++++
 tools/perf/pmu-events/arch/x86/amdzen2/memory.json | 341 ++++++++++++++++++
 tools/perf/pmu-events/arch/x86/amdzen2/other.json  | 115 +++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   3 +-
 tools/perf/pmu-events/jevents.c                    |  30 ++
 tools/perf/tests/Build                             |   1 +
 tools/perf/tests/builtin-test.c                    |   4 +
 tools/perf/tests/pmu-events.c                      | 379 +++++++++++++++++++++
 tools/perf/tests/tests.h                           |   1 +
 tools/perf/ui/browsers/hists.c                     | 118 ++++++-
 tools/perf/ui/hist.c                               |  93 ++++-
 tools/perf/ui/keysyms.h                            |   1 +
 tools/perf/util/annotate.h                         |   1 +
 tools/perf/util/cpumap.c                           |  10 +-
 tools/perf/util/dsos.c                             |  22 +-
 tools/perf/util/evsel.c                            |   1 +
 tools/perf/util/hist.h                             |   1 +
 tools/perf/util/metricgroup.c                      |  49 +--
 tools/perf/util/parse-events.c                     |   6 +-
 tools/perf/util/pmu.c                              |  28 +-
 tools/perf/util/pmu.h                              |   5 +
 tools/perf/util/sort.c                             |   6 +-
 tools/perf/util/stat-display.c                     |   6 +-
 tools/perf/util/symbol-elf.c                       |  10 +-
 tools/perf/util/symbol_conf.h                      |   1 +
 47 files changed, 2374 insertions(+), 556 deletions(-)
 delete mode 100644 tools/perf/arch/arm64/util/sym-handling.c
 rename tools/perf/pmu-events/arch/{x86/amdfam17h => test/test_cpu}/branch.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/cache.json
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/core.json (87%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/floating-point.json (61%)
 rename tools/perf/pmu-events/arch/x86/{amdfam17h => amdzen1}/memory.json (63%)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/other.json
 create mode 100644 tools/perf/tests/pmu-events.c

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

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

Ubuntu 19.10 is failing when linking against libllvm, which isn't the default,
needs to be investigated, haven't tested with CC=gcc, but should be the same
problem:

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBCLANGLLVM=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang

...
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_ignoringImpCasts0Matcher::matches(clang::Expr const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x43): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_hasLoopVariable0Matcher::matches(clang::CXXForRangeStmt const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x48): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
...

  It builds ok with the default set of options.

  # export PERF_TARBALL=http://192.168.124.1/perf/perf-5.6.0-rc6.tar.xz
  # dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:3.11                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.1 (git://git.alpinelinux.org/aports 7c78441134e54efbb34618f457d88c783c913361) (based on LLVM 9.0.1)
  10 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
  11 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.3.1 20190507 (ALT p9 8.3.1-alt5), clang version 7.0.1 
  12 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.2.1 20190827 (ALT Sisyphus 9.2.1-alt2), clang version 7.0.1 
  13 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  14 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  15 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  16 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  18 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  20 centos:8                      : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20200214 gcc_9_2_0_release-615-g7866f9ebf1, clang version 9.0.1 
  22 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25 debian:experimental           : Ok   gcc (Debian 9.2.1-28) 9.2.1 20200203, clang version 8.0.1-7 (tags/RELEASE_801/final)
  26 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  27 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 8.3.0-19) 8.3.0
  28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-24) 9.2.1 20200117
  29 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 9.2.1-8) 9.2.1 20190909
  30 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  31 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  32 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  33 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  34 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  35 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  36 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  37 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  38 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  39 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  42 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  43 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.1 (Fedora 9.0.1-2.fc31)
  44 fedora:32                     : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.1.rc2.fc32)
  45 fedora:rawhide                : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.3.rc2.fc33)
  46 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  47 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  48 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  49 mageia:7                      : Ok   gcc (Mageia 8.3.1-0.20190524.1.mga7) 8.3.1 20190524, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  50 manjaro:latest                : Ok   gcc (GCC) 9.2.0, clang version 9.0.0 (tags/RELEASE_900/final)
  51 openmandriva:cooker           : Ok   gcc (GCC) 10.0.0 20200216 (OpenMandriva), clang version 10.0.0 
  52 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190424 [gcc-7-branch revision 270538], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  56 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d], clang version 9.0.1 
  57 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  58 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  59 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4.5.0.5), clang version 8.0.1 (Red Hat 8.0.1-1.0.1.module+el8.1.0+5428+345cee14)
  60 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  61 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  62 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  63 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  67 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  68 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  69 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  70 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  71 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.4.0-1ubuntu1~18.04.1) 7.4.0
  72 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  73 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  74 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  75 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  76 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  77 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  78 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  79 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0
  80 ubuntu:18.10                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1~18.10.1) 8.3.0, clang version 7.0.0-3 (tags/RELEASE_700/final)
  81 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  82 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  83 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  84 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  85 ubuntu:19.10                  : FAIL gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  #

  # uname -a
  Linux five 5.5.10-200.fc31.x86_64 #1 SMP Wed Mar 18 14:21:38 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  0d33b3435253 perf dso: Fix dso comparison
  # perf version --build-options
  perf version 5.6.rc6.g9a13a0215c8d
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
                    gtk2: [ on  ]  # HAVE_GTK2_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
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
  10: PMU events                                            : Ok
  11: DSO data read                                         : Ok
  12: DSO data cache                                        : Ok
  13: DSO data reopen                                       : Ok
  14: Roundtrip evsel->name                                 : Ok
  15: Parse sched tracepoints fields                        : Ok
  16: syscalls:sys_enter_openat event fields                : Ok
  17: Setup struct perf_event_attr                          : Ok
  18: Match and link multiple hists                         : Ok
  19: 'import perf' in python                               : Ok
  20: Breakpoint overflow signal handler                    : Ok
  21: Breakpoint overflow sampling                          : Ok
  22: Breakpoint accounting                                 : Ok
  23: Watchpoint                                            :
  23.1: Read Only Watchpoint                                : Skip
  23.2: Write Only Watchpoint                               : Ok
  23.3: Read / Write Watchpoint                             : Ok
  23.4: Modify Watchpoint                                   : Ok
  24: Number of exit events of a simple workload            : Ok
  25: Software clock events period values                   : Ok
  26: Object code reading                                   : Ok
  27: Sample parsing                                        : Ok
  28: Use a dummy software event to keep tracking           : Ok
  29: Parse with no sample_id_all bit set                   : Ok
  30: Filter hist entries                                   : Ok
  31: Lookup mmap thread                                    : Ok
  32: Share thread maps                                     : Ok
  33: Sort output of hist entries                           : Ok
  34: Cumulate child hist entries                           : Ok
  35: Track with sched_switch                               : Ok
  36: Filter fds with revents mask in a fdarray             : Ok
  37: Add fd to a fdarray, making it autogrow               : Ok
  38: kmod_path__parse                                      : Ok
  39: Thread map                                            : Ok
  40: LLVM search and compile                               :
  40.1: Basic BPF llvm compile                              : Ok
  40.2: kbuild searching                                    : Ok
  40.3: Compile source for BPF prologue generation          : Ok
  40.4: Compile source for BPF relocation                   : Ok
  41: Session topology                                      : Ok
  42: BPF filter                                            :
  42.1: Basic BPF filtering                                 : Ok
  42.2: BPF pinning                                         : Ok
  42.3: BPF prologue generation                             : Ok
  42.4: BPF relocation checker                              : Ok
  43: Synthesize thread map                                 : Ok
  44: Remove thread map                                     : Ok
  45: Synthesize cpu map                                    : Ok
  46: Synthesize stat config                                : Ok
  47: Synthesize stat                                       : Ok
  48: Synthesize stat round                                 : Ok
  49: Synthesize attr update                                : Ok
  50: Event times                                           : Ok
  51: Read backward ring buffer                             : Ok
  52: Print cpu map                                         : Ok
  53: Merge cpu map                                         : Ok
  54: Probe SDT events                                      : Ok
  55: is_printable_array                                    : Ok
  56: Print bitmap                                          : Ok
  57: perf hooks                                            : Ok
  58: builtin clang support                                 : Skip (not compiled in)
  59: unit_number__scnprintf                                : Ok
  60: mem2node                                              : Ok
  61: time utils                                            : Ok
  62: Test jit_write_elf                                    : Ok
  63: maps__merge_in                                        : Ok
  64: x86 rdpmc                                             : Ok
  65: Convert perf time to TSC                              : Ok
  66: DWARF unwind                                          : Ok
  67: x86 instruction decoder - new instructions            : Ok
  68: Intel PT packet decoder                               : Ok
  69: x86 bp modify                                         : Ok
  70: probe libc's inet_pton & backtrace it with ping       : Ok
  71: Use vfs_getname probe to get syscall args filenames   : Ok
  72: Check open filename arg using perf trace + vfs_getname: Ok
  73: Zstd perf.data compression/decompression              : Ok
  74: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_tags_O: make tags
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
                  make_debug_O: make DEBUG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_install_bin_O: make install-bin
                   make_help_O: make help
                   make_pure_O: make
               make_no_slang_O: make NO_SLANG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_util_map_o_O: make util/map.o
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                    make_doc_O: make doc
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_no_libbpf_O: make NO_LIBBPF=1
                 make_perf_o_O: make perf.o
              make_clean_all_O: make clean all
                make_install_O: make install
        make_with_babeltrace_O: make LIBBABELTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
