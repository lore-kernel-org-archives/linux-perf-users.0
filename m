From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/11] perf/core improvements and fixes
Date: Mon, 20 Mar 2017 22:16:30 -0300
Message-ID: <20170321011641.25763-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>, Andi Kleen <ak@linux.intel.com>, Changbin Du <changbin.du@intel.com>, Clark Williams <williams@redhat.com>, David Ahern <dsahern@gmail.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Li Zhong <zhong@linux.vnet.ibm.com>, Marc Zyngier <marc.zyngier@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Namhyung Kim <namhyung@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>, Paul Mackerras <paulus@ozlabs.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 61f63e383784bd0ab6529cfc95ddc59c713afcc9:

  Merge tag 'perf-core-for-mingo-4.12-20170316' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-03-16 17:29:23 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.12-20170320

for you to fetch changes up to affa6c169bae8dc9cb1a2d070c7cd2fe1939c5b8:

  tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h (2017-03-20 15:02:29 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

Fixes:

- Fix concat_probe_trace_events() in 'perf probe', it should dereference a
  pointer, not test its value (Ravi Bangoria)

User visible:

- Handle partial AUX records, checking if 'kvm_intel.ko' is loaded and
  if its 'vmm_exclusive' parameter is set to 0, suggesting tweaking
  it to reduce gaps (Alexander Shishkin)

Infrastructure:

- Sync the kvm.h, cpufeatures.h and perf_event.h tools/ headers copies
  with the kernel (Arnaldo Carvalho de Melo, Alexander Shishkin)

- 'perf lock' subcommands should include common options, using
  OPT_PARENT() (Changbin Du)

- Ditto for 'perf timechart' (Arnaldo Carvalho de Melo)

Documentation:

  Correct 'perf stat --no-aggr' description (Ravi Bangoria)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexander Shishkin (3):
      tools lib api fs: Introduce sysfs__read_bool
      tools include: Sync {,tools/}include/uapi/linux/perf_event.h
      perf tools: Handle partial AUX records and print a warning

Arnaldo Carvalho de Melo (5):
      perf lock: Make 'f' part of the common 'lock_options'
      perf timechart: Use OPT_PARENT for common options
      tools headers: Sync {tools/,}arch/x86/include/asm/cpufeatures.h
      tools headers: Sync {tools/,}arch/arm{64}/include/uapi/asm/kvm.h
      tools headers: Sync {tools/,}arch/powerpc/include/uapi/asm/kvm.h

Changbin Du (1):
      perf lock: Subcommands should include common options

Ravi Bangoria (2):
      perf stat: Correct --no-aggr description
      perf probe: Fix concat_probe_trace_events

 tools/arch/arm/include/uapi/asm/kvm.h     | 13 +++++++++++++
 tools/arch/arm64/include/uapi/asm/kvm.h   | 13 +++++++++++++
 tools/arch/powerpc/include/uapi/asm/kvm.h | 22 ++++++++++++++++++++++
 tools/arch/x86/include/asm/cpufeatures.h  |  3 ++-
 tools/include/uapi/linux/perf_event.h     |  1 +
 tools/lib/api/fs/fs.c                     | 29 +++++++++++++++++++++++++++++
 tools/lib/api/fs/fs.h                     |  1 +
 tools/perf/Documentation/perf-stat.txt    |  3 +--
 tools/perf/builtin-lock.c                 | 22 ++++++++++++----------
 tools/perf/builtin-timechart.c            | 16 +++++++---------
 tools/perf/util/event.c                   |  5 +++--
 tools/perf/util/event.h                   |  1 +
 tools/perf/util/probe-event.c             |  2 +-
 tools/perf/util/session.c                 | 27 ++++++++++++++++++++++++---
 14 files changed, 130 insertions(+), 28 deletions(-)

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

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

  # dm
   1 alpine:3.4: Ok
   2 alpine:3.5: Ok
   3 alpine:edge: Ok
   4 android-ndk:r12b-arm: Ok
   5 archlinux:latest: Ok
   6 centos:5: Ok
   7 centos:6: Ok
   8 centos:7: Ok
   9 debian:7: Ok
  10 debian:8: Ok
  11 debian:experimental: Ok
  12 debian:experimental-x-arm64: Ok
  13 debian:experimental-x-mips: Ok
  14 debian:experimental-x-mips64: Ok
  15 debian:experimental-x-mipsel: Ok
  16 fedora:20: Ok
  17 fedora:21: Ok
  18 fedora:22: Ok
  19 fedora:23: Ok
  20 fedora:24: Ok
  21 fedora:24-x-ARC-uClibc: Ok
  22 fedora:25: Ok
  23 fedora:rawhide: Ok
  24 mageia:5: Ok
  25 opensuse:13.2: Ok
  26 opensuse:42.1: Ok
  27 opensuse:tumbleweed: Ok
  28 ubuntu:12.04.5: Ok
  29 ubuntu:14.04.4: Ok
  30 ubuntu:14.04.4-x-linaro-arm64: Ok
  31 ubuntu:15.10: Ok
  32 ubuntu:16.04: Ok
  33 ubuntu:16.04-x-arm: Ok
  34 ubuntu:16.04-x-arm64: Ok
  35 ubuntu:16.04-x-powerpc: Ok
  36 ubuntu:16.04-x-powerpc64: Ok
  37 ubuntu:16.04-x-s390: Ok
  38 ubuntu:16.10: Ok
  39 ubuntu:17.04: Ok

  # uname -a
  Linux felicio.ghostprotocols.net 4.11.0-rc2+ #30 SMP Mon Mar 20 09:47:16 BRT 2017 x86_64 x86_64 x86_64 GNU/Linux
  # Includes peterz's fix that makes "55: Convert perf time to TSC" pass,
  # That fix should go via his tree.
  
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
  37.1: Basic BPF filtering                      : FAILED!
  37.2: BPF pinning                              : Skip
  37.3: BPF prologue generation                  : Skip
  37.4: BPF relocation checker                   : Skip
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
                make_install_O: make install
                    make_doc_O: make doc
              make_no_libelf_O: make NO_LIBELF=1
            make_install_bin_O: make install-bin
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_perf_o_O: make perf.o
            make_no_auxtrace_O: make NO_AUXTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                   make_pure_O: make
           make_no_libpython_O: make NO_LIBPYTHON=1
                  make_debug_O: make DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                 make_static_O: make LDFLAGS=-static
               make_no_slang_O: make NO_SLANG=1
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_libperl_O: make NO_LIBPERL=1
              make_clean_all_O: make clean all
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_no_gtk2_O: make NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_tags_O: make tags
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_help_O: make help
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
