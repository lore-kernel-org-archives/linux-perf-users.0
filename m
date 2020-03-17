From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf/core improvements and fixes
Date: Tue, 17 Mar 2020 18:32:36 -0300
Message-ID: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, disconnect3d <dominik.b.czarnota@gmail.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>, Michael Petlan <mpetlan@redhat.com>, Mike Leach <mike.leach@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit f787feff69c466dfc6f261c9632627e383b49187:

  perf block-info: Support color ops to print block percents in color (2020-03-09 21:43:25 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.7-20200317

for you to fetch changes up to 59a08b4b3b1a9374adacd13cd7544c03e5582e0e:

  perf expr: Fix copy/paste mistake (2020-03-17 18:01:40 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

perf record:

  Alexey Budankov:

  - Fix binding of AIO user space buffers to nodes

maps:

  Dominik b. Czarnota:

  - Fix off by one in strncpy() size argument.

  Arnaldo Carvalho de Melo:

  - Use strstarts() to look for Android libraries.

  Ian Rogers:

  - Give synthetic mmap events an inode generation.

man pages:

  Ian Rogers:

  - Set man page date to last git commit.

perf test:

  Ian Rogers:

  - Print if shell directory isn't present.

perf report:

  Jin Yao:

  - Fix no branch type statistics report issue.

perf expr:

  Jiri Olsa:

  - Fix copy/paste mistake

vendor events:

  Kan Liang:

  - Support metric constraints.

vendor events intel:

  Kan Liang:

  - Add NO_NMI_WATCHDOG metric constraint.

vendor events s390:

  Thomas Richter:

 - Add new deflate counters for IBM z15.

ARM cs-etm:

  Leo Yan:

  - Last branch improvements.

intel-pt:

  Adrian Hunter:

  - Update intel-pt.txt file with new location of the documentation.

  - Add Intel PT man page references.

  - Rename intel-pt.txt and put it in man page format.

perl scripting:

  Michael Petlan:

 - Add common_callchain to fix argument order.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf intel-pt: Rename intel-pt.txt and put it in man page format
      perf intel-pt: Add Intel PT man page references
      perf intel-pt: Update intel-pt.txt file with new location of the documentation

Alexey Budankov (1):
      perf record: Fix binding of AIO user space buffers to nodes

Arnaldo Carvalho de Melo (1):
      perf map: Use strstarts() to look for Android libraries

Ian Rogers (3):
      perf doc: Set man page date to last git commit
      perf test: Print if shell directory isn't present
      perf tools: Give synthetic mmap events an inode generation

Jin Yao (1):
      perf report: Fix no branch type statistics report issue

Jiri Olsa (1):
      perf expr: Fix copy/paste mistake

Kan Liang (5):
      perf jevents: Support metric constraint
      perf metricgroup: Factor out metricgroup__add_metric_weak_group()
      perf util: Factor out sysctl__nmi_watchdog_enabled()
      perf metricgroup: Support metric constraint
      perf vendor events intel: Add NO_NMI_WATCHDOG metric constraint

Leo Yan (5):
      perf cs-etm: Swap packets for instruction samples
      perf cs-etm: Continuously record last branch
      perf cs-etm: Correct synthesizing instruction samples
      perf cs-etm: Optimize copying last branches
      perf cs-etm: Fix unsigned variable comparison to zero

Michael Petlan (1):
      perf scripting perl: Add common_callchain to fix argument order

Thomas Richter (1):
      perf vendor events s390: Add new deflate counters for IBM z15

disconnect3d (1):
      perf map: Fix off by one in strncpy() size argument

 tools/perf/Documentation/Makefile                  |    5 +-
 tools/perf/Documentation/intel-pt.txt              |  992 +------------------
 tools/perf/Documentation/perf-inject.txt           |    3 +-
 tools/perf/Documentation/perf-intel-pt.txt         | 1007 ++++++++++++++++++++
 tools/perf/Documentation/perf-record.txt           |    2 +-
 tools/perf/Documentation/perf-report.txt           |    3 +-
 tools/perf/Documentation/perf-script.txt           |    2 +-
 tools/perf/builtin-report.c                        |    9 +-
 .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |    8 +-
 .../perf/pmu-events/arch/s390/cf_z15/extended.json |   30 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |    3 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |    3 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |    3 +-
 tools/perf/pmu-events/jevents.c                    |   19 +-
 tools/perf/pmu-events/jevents.h                    |    2 +-
 tools/perf/pmu-events/pmu-events.h                 |    1 +
 tools/perf/scripts/perl/check-perf-trace.pl        |    6 +-
 tools/perf/scripts/perl/failed-syscalls.pl         |    2 +-
 tools/perf/scripts/perl/rw-by-file.pl              |    6 +-
 tools/perf/scripts/perl/rw-by-pid.pl               |   10 +-
 tools/perf/scripts/perl/rwtop.pl                   |   10 +-
 tools/perf/scripts/perl/wakeup-latency.pl          |    6 +-
 tools/perf/tests/builtin-test.c                    |    5 +-
 tools/perf/util/cs-etm.c                           |  157 ++-
 tools/perf/util/expr.l                             |    4 +-
 tools/perf/util/map.c                              |    8 +-
 tools/perf/util/metricgroup.c                      |  109 ++-
 tools/perf/util/mmap.c                             |   21 +-
 tools/perf/util/stat-display.c                     |    6 +-
 tools/perf/util/synthetic-events.c                 |    1 +
 tools/perf/util/util.c                             |   18 +
 tools/perf/util/util.h                             |    2 +
 32 files changed, 1340 insertions(+), 1123 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-intel-pt.txt

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

Clearlinux and debian:experimental are failing when due to:

  `.gnu.debuglto_.debug_macro' referenced in section `.gnu.debuglto_.debug_macro' of /tmp/build/perf/util/scripting-engines/perf-in.o: defined in discarded section `.gnu.debuglto_.debug_macro[wm4.stdcpredef.h.19.8dc41bed5d9037ff9622e015fb5f0ce3]' of /tmp/build/perf/util/scripting-engines/perf-in.o

Ubuntu 19.10 is failing when linking against libllvm, which isn't the default,
needs to be investigated, haven't tested with CC=gcc, but should be the same problem:

+ make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBCLANGLLVM=1 -C /git/linux/tools/perf O=/tmp/build/perf CC=clang

...
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_ignoringImpCasts0Matcher::matches(clang::Expr const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal32matcher_ignoringImpCasts0Matcher7matchesERKNS_4ExprEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x43): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
/usr/bin/ld: /usr/lib/llvm-9/lib/libclangAnalysis.a(ExprMutationAnalyzer.cpp.o): in function `clang::ast_matchers::internal::matcher_hasLoopVariable0Matcher::matches(clang::CXXForRangeStmt const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const':
(.text._ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE[_ZNK5clang12ast_matchers8internal31matcher_hasLoopVariable0Matcher7matchesERKNS_15CXXForRangeStmtEPNS1_14ASTMatchFinderEPNS1_21BoundNodesTreeBuilderE]+0x48): undefined reference to `clang::ast_matchers::internal::DynTypedMatcher::matches(clang::ast_type_traits::DynTypedNode const&, clang::ast_matchers::internal::ASTMatchFinder*, clang::ast_matchers::internal::BoundNodesTreeBuilder*) const'
...

  It builds ok with the default set of options.

  # export PERF_TARBALL=http://192.168.122.1/perf/perf-5.6.0-rc4.tar.xz
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
  12 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 9.2.1 20200123 (ALT Sisyphus 9.2.1-alt3), clang version 9.0.1 
  13 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  14 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  15 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  16 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
  18 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39)
  20 centos:8                      : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4), clang version 8.0.1 (Red Hat 8.0.1-1.module_el8.1.0+215+a01033fb)
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.2.1 20200305 gcc_9_2_0_release-738-ge50627ff8c, clang version 9.0.1 
  22 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25 debian:experimental           : FAIL gcc (Debian 9.2.1-31) 9.2.1 20200306, clang version 9.0.1-9 
  26 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 9.2.1-28) 9.2.1 20200203
  27 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 9.2.1-24) 9.2.1 20200117
  28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 9.2.1-24) 9.2.1 20200117
  29 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  30 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  31 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  32 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  33 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  34 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  35 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  36 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  37 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  38 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  39 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  40 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  41 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  42 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.1 (Fedora 9.0.1-2.fc31)
  43 fedora:32                     : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.1.rc2.fc32)
  44 fedora:rawhide                : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.5.rc3.fc33)
  45 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  46 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  47 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  48 mageia:7                      : Ok   gcc (Mageia 8.4.0-1.mga7) 8.4.0, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  49 manjaro:latest                : Ok   gcc (Arch Linux 9.2.1+20200130-2) 9.2.1 20200130, clang version 9.0.1 
  50 openmandriva:cooker           : Ok   gcc (GCC) 10.0.0 20200301 (OpenMandriva), clang version 10.0.0 
  51 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  52 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5, clang version 3.8.0 (tags/RELEASE_380/final 262553)
  53 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 9.2.1 20200128 [revision 83f65674e78d97d27537361de1a9d74067ff228d], clang version 9.0.1 
  54 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  55 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-39.0.3)
  56 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20190507 (Red Hat 8.3.1-4.5.0.5), clang version 8.0.1 (Red Hat 8.0.1-1.0.1.module+el8.1.0+5428+345cee14)
  57 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3, Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  58 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  59 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609, clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  60 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  61 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  62 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  63 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  64 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0, clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  67 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  68 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  69 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  70 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  71 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  72 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  73 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  74 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  75 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  76 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  77 ubuntu:19.04                  : Ok   gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0, clang version 8.0.0-3 (tags/RELEASE_800/final)
  78 ubuntu:19.04-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  79 ubuntu:19.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 8.3.0-6ubuntu1) 8.3.0
  80 ubuntu:19.04-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 8.3.0-6ubuntu1) 8.3.0
  81 ubuntu:19.10                  : FAIL gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008, clang version 9.0.0-2 (tags/RELEASE_900/final)
  $

  # uname -a
  Linux five 5.5.8-200.fc31.x86_64 #1 SMP Thu Mar 5 21:28:03 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  59a08b4b3b1a perf expr: Fix copy/paste mistake
  # perf version --build-options
  perf version 5.6.rc4.g59a08b4b3b1a
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
  21: Breakpoint accounting                                 : Ok
  22: Watchpoint                                            :
  22.1: Read Only Watchpoint                                : Skip
  22.2: Write Only Watchpoint                               : Ok
  22.3: Read / Write Watchpoint                             : Ok
  22.4: Modify Watchpoint                                   : Ok
  23: Number of exit events of a simple workload            : Ok
  24: Software clock events period values                   : Ok
  25: Object code reading                                   : Ok
  26: Sample parsing                                        : Ok
  27: Use a dummy software event to keep tracking           : Ok
  28: Parse with no sample_id_all bit set                   : Ok
  29: Filter hist entries                                   : Ok
  30: Lookup mmap thread                                    : Ok
  31: Share thread maps                                     : Ok
  32: Sort output of hist entries                           : Ok
  33: Cumulate child hist entries                           : Ok
  34: Track with sched_switch                               : Ok
  35: Filter fds with revents mask in a fdarray             : Ok
  36: Add fd to a fdarray, making it autogrow               : Ok
  37: kmod_path__parse                                      : Ok
  38: Thread map                                            : Ok
  39: LLVM search and compile                               :
  39.1: Basic BPF llvm compile                              : Ok
  39.2: kbuild searching                                    : Ok
  39.3: Compile source for BPF prologue generation          : Ok
  39.4: Compile source for BPF relocation                   : Ok
  40: Session topology                                      : Ok
  41: BPF filter                                            :
  41.1: Basic BPF filtering                                 : Ok
  41.2: BPF pinning                                         : Ok
  41.3: BPF prologue generation                             : Ok
  41.4: BPF relocation checker                              : Ok
  42: Synthesize thread map                                 : Ok
  43: Remove thread map                                     : Ok
  44: Synthesize cpu map                                    : Ok
  45: Synthesize stat config                                : Ok
  46: Synthesize stat                                       : Ok
  47: Synthesize stat round                                 : Ok
  48: Synthesize attr update                                : Ok
  49: Event times                                           : Ok
  50: Read backward ring buffer                             : Ok
  51: Print cpu map                                         : Ok
  52: Merge cpu map                                         : Ok
  53: Probe SDT events                                      : Ok
  54: is_printable_array                                    : Ok
  55: Print bitmap                                          : Ok
  56: perf hooks                                            : Ok
  57: builtin clang support                                 : Skip (not compiled in)
  58: unit_number__scnprintf                                : Ok
  59: mem2node                                              : Ok
  60: time utils                                            : Ok
  61: Test jit_write_elf                                    : Ok
  62: maps__merge_in                                        : Ok
  63: x86 rdpmc                                             : Ok
  64: Convert perf time to TSC                              : Ok
  65: DWARF unwind                                          : Ok
  66: x86 instruction decoder - new instructions            : Ok
  67: Intel PT packet decoder                               : Ok
  68: x86 bp modify                                         : Ok
  69: probe libc's inet_pton & backtrace it with ping       : Ok
  70: Use vfs_getname probe to get syscall args filenames   : Ok
  71: Check open filename arg using perf trace + vfs_getname: Ok
  72: Zstd perf.data compression/decompression              : Ok
  73: Add vfs_getname probe to get syscall args filenames   : Ok

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_help_O: make help
                    make_doc_O: make doc
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
               make_no_slang_O: make NO_SLANG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_tags_O: make tags
            make_no_demangle_O: make NO_DEMANGLE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_pure_O: make
                 make_perf_o_O: make perf.o
                make_no_gtk2_O: make NO_GTK2=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_clean_all_O: make clean all
                make_no_newt_O: make NO_NEWT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
              make_no_libbpf_O: make NO_LIBBPF=1
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
