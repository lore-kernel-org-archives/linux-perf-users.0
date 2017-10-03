From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 0/8] perf/core improvements and fixes
Date: Tue,  3 Oct 2017 09:55:32 -0300
Message-ID: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexei Starovoitov <ast@kernel.org>, Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, He Kuang <hekuang@huawei.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Lukasz Odzioba <lukasz.odzioba@intel.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, Wang Nan <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	I pulled tip/perf/urgent to pick up fixes, please consider
pulling, I've been away for a while, so I'll be harvesting outstanding
patches in the next few days, as well as trying and reviewing more
complex patchkits,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit c976a7d6db215481261b63a89a408cb265a9812b:

  Merge remote-tracking branch 'tip/perf/urgent' into perf/core, to pick up fixes (2017-10-02 13:58:12 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171003

for you to fetch changes up to f6a9820d572bd8384d982357cbad214b3a6c04bb:

  perf tests attr: Fix group stat tests (2017-10-03 09:41:45 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Multithread the synthesizing of PERF_RECORD_ events for pre-existing
  threads in 'perf top', speeding up that phase, greatly improving the
  user experience in systems such as Intel's Knights Mill (Kan Liang)

- 'perf test' fixes for the perf_event_attr test case (Jiri Olsa, Thomas Richter)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Jiri Olsa (2):
      perf tests attr: Fix task term values
      perf tests attr: Fix group stat tests

Kan Liang (4):
      perf tools: Lock to protect namespaces and comm list
      perf tools: Lock to protect comm_str rb tree
      perf top: Implement multithreading for perf_event__synthesize_threads
      perf top: Add option to set the number of thread for event synthesize

Thomas Richter (2):
      perf test attr: Fix python error on empty result
      perf test attr: Fix ignored test case result

 tools/perf/Documentation/perf-top.txt            |   3 +
 tools/perf/builtin-kvm.c                         |   3 +-
 tools/perf/builtin-record.c                      |   2 +-
 tools/perf/builtin-top.c                         |  13 +-
 tools/perf/builtin-trace.c                       |   2 +-
 tools/perf/tests/attr.c                          |   2 +-
 tools/perf/tests/attr.py                         |   6 +-
 tools/perf/tests/attr/base-record                |   2 +-
 tools/perf/tests/attr/test-record-group          |   1 +
 tools/perf/tests/attr/test-record-group-sampling |   2 +-
 tools/perf/tests/attr/test-record-group1         |   1 +
 tools/perf/tests/attr/test-stat-group            |   2 +
 tools/perf/tests/attr/test-stat-group1           |   2 +
 tools/perf/tests/mmap-thread-lookup.c            |   2 +-
 tools/perf/util/comm.c                           |  18 ++-
 tools/perf/util/event.c                          | 163 ++++++++++++++++++-----
 tools/perf/util/event.h                          |   3 +-
 tools/perf/util/machine.c                        |   8 +-
 tools/perf/util/machine.h                        |   9 +-
 tools/perf/util/thread.c                         |  53 +++++++-
 tools/perf/util/thread.h                         |   3 +
 tools/perf/util/top.h                            |   1 +
 22 files changed, 249 insertions(+), 52 deletions(-)

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
  23 fedora:24-x-ARC-uClibc: FAIL

builtin-sched.c: In function 'timehist_sched_switch_event':
builtin-sched.c:2580:1: internal compiler error: in change_address_1, at emit-rtl.c:2150
 }
 ^
Please submit a full bug report,
with preprocessed source if appropriate.
See <https://github.com/foss-for-synopsys-dwc-arc-processors/toolchain/issues> for instructions.

  24 fedora:25: Ok
  25 fedora:26: Ok
  26 fedora:rawhide: Ok
  27 mageia:5: Ok
  28 opensuse:42.1: Ok
  29 opensuse:42.2: Ok
  30 opensuse:42.3: Ok
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

  # uname -a
  Linux jouet 4.13.0+ #3 SMP Mon Sep 25 11:51:22 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
