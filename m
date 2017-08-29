From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/18] perf/core improvements and fixes
Date: Tue, 29 Aug 2017 16:42:36 -0300
Message-ID: <20170829194254.1338-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexis Berlemont <alexis.berlemont@gmail.com>, Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, David Tolnay <dtolnay@gmail.com>, Hanjun Guo <guohanjun@huawei.com>, Hemant Kumar <hemant@linux.vnet.ibm.com>, Jack Henschel <jackdev@mailbox.org>, Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>, Jiri Olsa <jolsa@kernel.org>, Joe Mario <jmario@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit b00233b5306512a09e339d69ef5e390a77f2d302:

  perf/x86: Export some PMU attributes in caps/ directory (2017-08-25 11:04:20 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170829

for you to fetch changes up to b2f7605076d6cdd68162c42c34caadafbbe4c69f:

  perf symbols: Fix plt entry calculation for ARM and AARCH64 (2017-08-29 11:41:27 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Fix remote HITM detection for Skylake in 'perf c2c' (Jiri Olsa)

- Fixes for the handling of PERF_RECORD_READ records (Jiri Olsa)

- Fix kprobes blackist symbol lookup in 'perf probe' (Li Bin)

- The PLT header and entry sizes are not the same in !x86, fix it for ARM and
  AARCH64 (Li Bin)

- Beautify pkey_{alloc,free,mprotect} arguments in 'perf trace' (Arnaldo Carvalho de Melo)

- Fix CC, AR, LD external definition, allow flex and bison to be
  externally defined and other related Makefile fixes (David Carrillo-Cisneros)

- Sync cpu features kernel ABI headers with tooling headers (Arnaldo Carvalho de Melo)

- Fix path to PMU formats in 'perf stat' documentation (Jack Henschel)

- Fix static build with newer toolchains (Jiri Olsa)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      tools headers: Sync cpu features kernel ABI headers with tooling headers
      perf trace beauty: Beautify pkey_{alloc,free,mprotect} arguments

David Carrillo-Cisneros (5):
      tools build tests: Don't hardcode gcc name
      perf tools: Allow external definition of flex and bison binary names
      tools lib: Allow external definition of CC, AR and LD
      perf tools: Robustify detection of clang binary
      perf tools: Pass full path of FEATURES_DUMP

Jack Henschel (1):
      perf stat: Fix path to PMU formats in documentation

Jiri Olsa (8):
      perf tools: Fix static build with newer toolchains
      perf c2c: Fix remote HITM detection for Skylake
      perf record: Set read_format for inherit_stat
      perf report: Add dump_read function
      perf values: Fix thread index bug
      perf values: Fix allocation check
      perf values: Zero value buffers
      perf report: Group stat values on global event id

Li Bin (2):
      perf probe: Fix kprobe blacklist checking condition
      perf symbols: Fix plt entry calculation for ARM and AARCH64

 tools/arch/x86/include/asm/cpufeatures.h           |  5 +--
 tools/arch/x86/include/asm/disabled-features.h     |  4 +-
 tools/build/tests/ex/Makefile                      |  2 +-
 tools/lib/api/Makefile                             |  8 ++--
 tools/lib/subcmd/Makefile                          |  2 +-
 tools/perf/Documentation/perf-stat.txt             |  4 +-
 tools/perf/Makefile.config                         |  4 +-
 tools/perf/Makefile.perf                           | 26 ++++++++---
 tools/perf/builtin-report.c                        |  6 +--
 tools/perf/builtin-trace.c                         |  8 ++++
 tools/perf/trace/beauty/Build                      |  1 +
 tools/perf/trace/beauty/beauty.h                   |  3 ++
 tools/perf/trace/beauty/pkey_alloc.c               | 50 ++++++++++++++++++++++
 .../perf/trace/beauty/pkey_alloc_access_rights.sh  | 10 +++++
 tools/perf/util/evsel.c                            |  7 ++-
 tools/perf/util/intel-pt-decoder/Build             |  2 +-
 tools/perf/util/mem-events.c                       | 11 ++++-
 tools/perf/util/probe-event.c                      |  2 +-
 tools/perf/util/session.c                          | 25 +++++++++++
 tools/perf/util/symbol-elf.c                       | 27 +++++++++---
 tools/perf/util/values.c                           | 17 +++++---
 tools/scripts/Makefile.include                     |  4 +-
 22 files changed, 185 insertions(+), 43 deletions(-)
 create mode 100644 tools/perf/trace/beauty/pkey_alloc.c
 create mode 100755 tools/perf/trace/beauty/pkey_alloc_access_rights.sh

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

Several are cross builds, the ones with -x-ARCH, and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf
commands with a variety of command line event specifications to then
intercept the sys_perf_event syscall to check that the perf_event_attr
fields are set up as expected, among a variety of other unit tests.

The 'perf test'  also runs shell scripts exercising the tools, checking
if they affect the system in certain ways, like setting up kprobes and
uprobes, request callchains for well known programs and check that they
are the expected ones, see if 'perf trace' beautifies system call
arguments correctly, etc.

Additionally, a new set of tests, script based, runs the tools in a live system,
setting probes in place that then gets used by 'perf trace', with its output
compared against expected results.

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
   6 archlinux:latest: Ok
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
  23 fedora:24-x-ARC-uClibc: Ok
  24 fedora:25: Ok
  25 fedora:26: Ok
  26 fedora:rawhide: Ok
  27 mageia:5: Ok
  28 opensuse:13.2: Ok
  29 opensuse:42.1: Ok
  30 opensuse:42.2: Ok
  31 opensuse:42.3: Ok
  32 opensuse:tumbleweed: Ok
  33 oraclelinux:6: Ok
  34 oraclelinux:7: Ok
  35 ubuntu:12.04.5: Ok
  36 ubuntu:14.04.4: Ok
  37 ubuntu:14.04.4-x-linaro-arm64: Ok
  38 ubuntu:15.10: Ok
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
  Linux jouet 4.13.0-rc4+ #2 SMP Fri Aug 11 12:39:09 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  60: Intel cqm nmi context read                            : Skip
  61: Use vfs_getname probe to get syscall args filenames   : Ok
  62: probe libc's inet_pton & backtrace it with ping       : Ok
  63: Check open filename arg using perf trace + vfs_getname: Ok
  64: Add vfs_getname probe to get syscall args filenames   : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_debug_O: make DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_tags_O: make tags
         make_install_prefix_O: make install prefix=/tmp/krava
                make_no_gtk2_O: make NO_GTK2=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_static_O: make LDFLAGS=-static
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
                   make_pure_O: make
             make_no_libperl_O: make NO_LIBPERL=1
                 make_perf_o_O: make perf.o
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
                make_no_newt_O: make NO_NEWT=1
                    make_doc_O: make doc
              make_no_libbpf_O: make NO_LIBBPF=1
              make_clean_all_O: make clean all
                   make_help_O: make help
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libnuma_O: make NO_LIBNUMA=1
               make_no_slang_O: make NO_SLANG=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
