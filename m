From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf/core fixes and improvements
Date: Mon, 13 Apr 2020 13:51:37 -0300
Message-ID: <20200413165203.1816-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andreas Gerstmayr <agerstmayr@redhat.com>, Ian Rogers <irogers@google.com>, Jin Yao <yao.jin@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo/Thomas,

	Please consider pulling, the CAP_PERFMON got lots of reviewed-by
and acked-by from the relevant people, its just that it took more time
on my side to test everything, working less time than normal in the
current situation, delaying this lot more than I expected :-\

Best regards,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 7dc41b9b99cd0037a418ac47e342d56a438df649:

  Merge tag 'perf-urgent-for-mingo-5.7-20200403' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2020-04-04 10:35:15 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-5.7-20200413

for you to fetch changes up to 80af1ec0f23235271feda1436f1b5c74078a0453:

  perf script: Add flamegraph.py script (2020-04-13 11:03:08 -0300)

----------------------------------------------------------------
perf/core fixes and improvements:

kernel + tools/perf:

  Alexey Budankov:

  - Introduce CAP_PERFMON to kernel and user space.

perf stat:

  Jin Yao:

  - Fix no metric header if --per-socket and --metric-only set.

perf python:

  Arnaldo Carvalho de Melo:

  - Check if clang supports -fno-semantic-interposition, fixing the python
    binding when building with clang.

perf script:

  Andreas Gerstmayr:

  - Add flamegraph.py script

tools arch x86:

  Arnaldo Carvalho de Melo:

  - Sync the msr-index.h copy with the kernel sources.

perf bench:

  Ian Rogers:

  - Add event synthesis benchmark.

BPF:

  Jiri Olsa:

  - Synthesize bpf_trampoline/dispatcher ksymbol event.

tools api fs:

  Stephane Eranian:

 - Make xxx__mountpoint() more scalable

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf script: Simplify auxiliary event printing functions

Alexey Budankov (12):
      capabilities: Introduce CAP_PERFMON to kernel and user space
      perf/core: Open access to the core for CAP_PERFMON privileged process
      perf/core: open access to probes for CAP_PERFMON privileged process
      perf tools: Support CAP_PERFMON capability
      drm/i915/perf: Open access for CAP_PERFMON privileged process
      trace/bpf_trace: Open access for CAP_PERFMON privileged process
      powerpc/perf: open access for CAP_PERFMON privileged process
      parisc/perf: open access for CAP_PERFMON privileged process
      drivers/perf: Open access for CAP_PERFMON privileged process
      drivers/oprofile: Open access for CAP_PERFMON privileged process
      doc/admin-guide: Update perf-security.rst with CAP_PERFMON information
      doc/admin-guide: update kernel.rst with CAP_PERFMON information

Andreas Gerstmayr (1):
      perf script: Add flamegraph.py script

Arnaldo Carvalho de Melo (2):
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      perf python: Check if clang supports -fno-semantic-interposition

Ian Rogers (2):
      perf bench: Add event synthesis benchmark
      perf synthetic-events: save 4kb from 2 stack frames

Jin Yao (1):
      perf stat: Fix no metric header if --per-socket and --metric-only set

Jiri Olsa (5):
      perf tools: Synthesize bpf_trampoline/dispatcher ksymbol event
      perf machine: Set ksymbol dso as loaded on arrival
      perf annotate: Add basic support for bpf_image
      perf expr: Add expr_ prefix for parse_ctx and parse_id
      perf expr: Add expr_scanner_ctx object

Kajol Jain (1):
      perf metrictroup: Split the metricgroup__add_metric function

Stephane Eranian (1):
      tools api fs: Make xxx__mountpoint() more scalable

 Documentation/admin-guide/perf-security.rst     |  86 +++++--
 Documentation/admin-guide/sysctl/kernel.rst     |  16 +-
 arch/parisc/kernel/perf.c                       |   2 +-
 arch/powerpc/perf/imc-pmu.c                     |   4 +-
 drivers/gpu/drm/i915/i915_perf.c                |  13 +-
 drivers/oprofile/event_buffer.c                 |   2 +-
 drivers/perf/arm_spe_pmu.c                      |   4 +-
 include/linux/capability.h                      |   4 +
 include/linux/perf_event.h                      |   6 +-
 include/uapi/linux/capability.h                 |   8 +-
 kernel/events/core.c                            |   6 +-
 kernel/trace/bpf_trace.c                        |   2 +-
 security/selinux/include/classmap.h             |   4 +-
 tools/arch/x86/include/asm/msr-index.h          |   9 +
 tools/lib/api/fs/fs.c                           |  17 ++
 tools/lib/api/fs/fs.h                           |  12 +
 tools/perf/Documentation/perf-bench.txt         |   8 +
 tools/perf/bench/Build                          |   2 +-
 tools/perf/bench/bench.h                        |   2 +-
 tools/perf/bench/synthesize.c                   | 101 ++++++++
 tools/perf/builtin-bench.c                      |   6 +
 tools/perf/builtin-ftrace.c                     |   5 +-
 tools/perf/builtin-script.c                     | 304 +++++-------------------
 tools/perf/design.txt                           |   3 +-
 tools/perf/scripts/python/bin/flamegraph-record |   2 +
 tools/perf/scripts/python/bin/flamegraph-report |   3 +
 tools/perf/scripts/python/flamegraph.py         | 124 ++++++++++
 tools/perf/tests/expr.c                         |   4 +-
 tools/perf/util/annotate.c                      |  20 ++
 tools/perf/util/bpf-event.c                     |  93 ++++++++
 tools/perf/util/cap.h                           |   4 +
 tools/perf/util/dso.c                           |   1 +
 tools/perf/util/dso.h                           |   1 +
 tools/perf/util/evsel.c                         |  10 +-
 tools/perf/util/expr.c                          |  16 +-
 tools/perf/util/expr.h                          |  16 +-
 tools/perf/util/expr.l                          |  10 +-
 tools/perf/util/expr.y                          |   6 +-
 tools/perf/util/machine.c                       |  12 +
 tools/perf/util/metricgroup.c                   |  60 +++--
 tools/perf/util/setup.py                        |   2 +
 tools/perf/util/stat-shadow.c                   |   9 +-
 tools/perf/util/symbol.c                        |   1 +
 tools/perf/util/synthetic-events.c              |  22 +-
 tools/perf/util/util.c                          |   1 +
 45 files changed, 679 insertions(+), 364 deletions(-)
 create mode 100644 tools/perf/bench/synthesize.c
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 create mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 create mode 100755 tools/perf/scripts/python/flamegraph.py

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

  $ export PERF_TARBALL=http://192.168.122.1/perf/perf-5.6.0.tar.xz
  $ dm 
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8 alpine:3.11                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9 alpine:edge                   : Ok   gcc (Alpine 9.2.0) 9.2.0, Alpine clang version 9.0.1 (git://git.alpinelinux.org/aports 6c34b9a10bcdcdac04a11569c50b61fb50c4ea6e) (based on LLVM 9.0.1)
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
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 9.3.1 20200325 releases/gcc-9.3.0-55-gdff885cdc0, clang version 9.0.1 
  22 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  23 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516, clang version 3.8.1-24 (tags/RELEASE_381/final)
  24 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0, clang version 7.0.1-8 (tags/RELEASE_701/final)
  25 debian:experimental           : Ok   gcc (Debian 9.3.0-7) 9.3.0
  26 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 9.2.1-24) 9.2.1 20200117
  27 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  28 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.5.0 (tags/RELEASE_350/final)
  29 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6), clang version 3.7.0 (tags/RELEASE_370/final)
  30 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1), clang version 3.8.1 (tags/RELEASE_381/final)
  31 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  32 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1), clang version 3.9.1 (tags/RELEASE_391/final)
  33 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2), clang version 4.0.1 (tags/RELEASE_401/final)
  34 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6), clang version 5.0.2 (tags/RELEASE_502/final)
  35 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 6.0.1 (tags/RELEASE_601/final)
  36 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2), clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  37 fedora:30                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  38 fedora:30-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225
  39 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  40 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.1 (Fedora 9.0.1-2.fc31)
  41 fedora:32                     : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.1.rc2.fc32)
  42 fedora:33                     : Ok   gcc (GCC) 10.0.1 20200311 (Red Hat 10.0.1-0.9), clang version 10.0.0 (Fedora 10.0.0-0.9.rc5.fc33)
  43 fedora:rawhide                : Ok   gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8), clang version 10.0.0 (Fedora 10.0.0-0.5.rc3.fc33)
  44 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.2.0-r2 p3) 9.2.0
  45 mageia:5                      : Ok   gcc (GCC) 4.9.2, clang version 3.5.2 (tags/RELEASE_352/final)
  46 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0, clang version 3.9.1 (tags/RELEASE_391/final)
  47 mageia:7                      : Ok   gcc (Mageia 8.4.0-1.mga7) 8.4.0, clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  48 manjaro:latest                : Ok   gcc (Arch Linux 9.3.0-1) 9.3.0, clang version 9.0.1
  49 openmandriva:cooker           : Ok   gcc (GCC) 10.0.0 20200301 (OpenMandriva), clang version 10.0.0 
  50 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407], clang version 5.0.1 (tags/RELEASE_501/final 312548)
  51 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0, clang version 7.0.1 (tags/RELEASE_701/final 349238)
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
  82 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-8ubuntu1) 9.3.0, clang version 10.0.0-1ubuntu1 
  $

  # uname -a
  Linux seventh 5.5.16-100.fc30.x86_64 #1 SMP Wed Apr 8 17:09:38 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  80af1ec0f232 perf script: Add flamegraph.py script
  # perf version --build-options
  perf version 5.6.g80af1ec0f232
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
  70: Use vfs_getname probe to get syscall args filenames   : Ok
  71: Check open filename arg using perf trace + vfs_getname: Ok
  72: Zstd perf.data compression/decompression              : Ok
  73: probe libc's inet_pton & backtrace it with ping       : Ok
  74: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ git log --oneline -1 ; make -C tools/perf build-test
  80af1ec0f232 (HEAD -> perf/core, quaco/perf/core, five/perf/core) perf script: Add flamegraph.py script
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_pure_O: make
                  make_debug_O: make DEBUG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_util_map_o_O: make util/map.o
              make_no_libbpf_O: make NO_LIBBPF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                 make_perf_o_O: make perf.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
                make_install_O: make install
                 make_cscope_O: make cscope
           make_no_backtrace_O: make NO_BACKTRACE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
                    make_doc_O: make doc
              make_clean_all_O: make clean all
         make_install_prefix_O: make install prefix=/tmp/krava
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_tags_O: make tags
               make_no_slang_O: make NO_SLANG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_install_bin_O: make install-bin
                make_no_newt_O: make NO_NEWT=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
