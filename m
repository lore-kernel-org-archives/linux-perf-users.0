From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/40] perf/core improvements and fixes
Date: Wed, 26 Jul 2017 11:16:50 -0300
Message-ID: <20170726141730.30750-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Arun Kalyanasundaram <arunkaly@google.com>, Brendan Gregg <brendan.d.gregg@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Elena Reshetova <elena.reshetova@intel.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Kan Liang <kan.liang@intel.com>, Kees Cook <keescook@chromium.org>
List-Id: linux-perf-users.vger.kernel.org

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 510457ec9dc259b002879bcfe475f89d4514a0fc:

  Merge tag 'perf-core-for-mingo-4.13-20170718' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-07-20 10:31:52 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170725

for you to fetch changes up to 62e6039f02888efdd824e8c596c4927616a97ce3:

  perf tools: Add tools/include/uapi/asm-generic/fcntl.h to the MANIFEST (2017-07-25 22:46:37 -0300)

----------------------------------------------------------------
perf/core improvemends and fixes for v4.14:

New features:

- Filter out 'sshd' in the tracer ancestry in 'perf trace' syswide tracing,
  to elliminate tracing loops (Arnaldo Carvalho de Melo)

- Support lookup of symbols in other mount namespaces in 'perf top' (Krister Johansen)

- Initial 'clone' syscall args beautifier in 'perf trace' (Arnaldo Carvalho de Melo)

User visible:

- Ignore 'fd' and 'offset' args for MAP_ANONYMOUS in 'perf trace'
  (Arnaldo Carvalho de Melo)

- Process tracing data in 'perf annotate' pipe mode (David Carrillo-Cisneros)

- Make 'perf report --branch-history' work without callgraphs(-g) option
  in perf record (Jin Yao)

- Tag branch type/flag on "to" and tag cycles on "from" in 'perf report' (Jin Yao)

Fixes:

- Fix jvmti linker error when libelf config is disabled (Sudeep Holla)

- Fix cgroups refcount usage (Arnaldo Carvalho de Melo)

- Fix kernel symbol adjustment for s390x (Thomas Richter)

- Fix 'perf report --stdio --show-total-period', it was showing the
  number of samples, not the total period (Taeung Song)

Infrastructure:

- Add perf_sample dictionary to tracepoint handlers in 'perf script'
  python, which were already present for other types of events
  (hardware, etc) (Arun Kalyanasundaram)

- Make build fail on vendor events JSON parse error (Andi Kleen)

- Adopt strstarts() from the kernel (Arnaldo Carvalho de Melo)

Arch specific:

- Set no_aux_samples for the tracking event in Intel PT (Kan Liang)

- Always set no branch for Intel PT dummy event (Kan Liang)

Trivial:

- Simplify some error handlers in 'perf script' (Dan Carpenter)

- Add EXCLUDE_EXTLIBS and EXTRA_PERFLIBS to makefile (David Carrillo-Cisneros)

----------------------------------------------------------------
Andi Kleen (1):
      perf jevents: Make build fail on JSON parse error

Arnaldo Carvalho de Melo (16):
      perf trace: Add missing ' = ' in the default formatting of syscall returns
      perf trace beauty mmap: Ignore 'fd' and 'offset' args for MAP_ANONYMOUS
      perf trace: Allow allocating sc->arg_fmt even without the syscall tracepoint
      perf trace: Use the syscall_fmt formatters without a tracepoint
      perf trace: Ditch __syscall__arg_val() variant, not needed anymore
      perf trace: Allow specifying number of syscall args for tracepointless syscalls
      perf trace: Allow specifying names to syscall arguments formatters
      tools include uapi: Grab a copy of linux/sched.h
      perf trace beauty clone: Beautify syscall arguments
      perf trace beauty clone: Suppress unused args according to 'flags' arg
      perf trace: Introduce filter_loop_pids()
      perf trace: Filter out 'sshd' in the tracer ancestry in syswide tracing
      tools include: Adopt strstarts() from the kernel
      tools lib: Update copy of strtobool from the kernel sources
      perf cgroup: Fix refcount usage
      perf tools: Add tools/include/uapi/asm-generic/fcntl.h to the MANIFEST

Arun Kalyanasundaram (5):
      perf script python: Allocate memory only if handler exists
      perf script python: Refactor creation of perf sample dict
      perf script python: Add sample_read to dict
      perf script python: Add perf_sample dict to tracepoint handlers
      perf script python: Generate hooks with additional argument

Dan Carpenter (1):
      perf script: Remove some bogus error handling

David Carrillo-Cisneros (2):
      perf tools: Add EXCLUDE_EXTLIBS and EXTRA_PERFLIBS to makefile
      perf annotate: Process tracing data in pipe mode

Jin Yao (2):
      perf report: Make --branch-history work without callgraphs(-g) option in perf record
      perf report: Tag branch type/flag on "to" and tag cycles on "from"

Jiri Olsa (1):
      perf evsel: Add verbose output for sys_perf_event_open fallback

Kan Liang (2):
      perf intel-pt: Set no_aux_samples for the tracking event
      perf intel-pt: Always set no branch for dummy event

Krister Johansen (1):
      perf top: Support lookup of symbols in other mount namespaces.

Sudeep Holla (1):
      perf jvmti: Fix linker error when libelf config is disabled

Taeung Song (7):
      perf annotate: Introduce struct sym_hist_entry
      perf annotate: Rename 'sum' to 'nr_samples' in struct sym_hist
      perf hists: Pass perf_sample to __symbol__inc_addr_samples()
      perf annotate: Store the sample period in each histogram bucket
      perf annotate: Do not overwrite sample->period
      perf annotate stdio: Fix --show-total-period
      perf annotate stdio: Fix column header when using --show-total-period

Thomas Richter (1):
      perf report: Fix kernel symbol adjustment for s390x

 tools/include/linux/string.h                       |  12 +-
 tools/include/uapi/linux/sched.h                   |  52 +++++
 tools/lib/string.c                                 |  41 ++--
 tools/lib/subcmd/help.c                            |   2 +-
 tools/lib/subcmd/parse-options.c                   |  18 +-
 tools/perf/Documentation/perf-top.txt              |   4 +
 tools/perf/MANIFEST                                |   2 +
 tools/perf/Makefile.perf                           |  10 +-
 tools/perf/arch/s390/util/Build                    |   1 +
 tools/perf/arch/s390/util/sym-handling.c           |  22 ++
 tools/perf/arch/x86/util/intel-pt.c                |   3 +
 tools/perf/builtin-annotate.c                      |   4 +-
 tools/perf/builtin-config.c                        |   3 +-
 tools/perf/builtin-ftrace.c                        |   2 +-
 tools/perf/builtin-help.c                          |   6 +-
 tools/perf/builtin-report.c                        |  27 ++-
 tools/perf/builtin-script.c                        |   7 +-
 tools/perf/builtin-top.c                           |  20 +-
 tools/perf/builtin-trace.c                         | 140 ++++++++----
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/perf.c                                  |  16 +-
 tools/perf/pmu-events/README                       |   4 -
 tools/perf/pmu-events/jevents.c                    |  21 +-
 tools/perf/trace/beauty/Build                      |   1 +
 tools/perf/trace/beauty/beauty.h                   |   3 +
 tools/perf/trace/beauty/clone.c                    |  75 +++++++
 tools/perf/trace/beauty/mmap.c                     |   3 +
 tools/perf/ui/browser.c                            |   3 +-
 tools/perf/ui/browsers/annotate.c                  |   9 +-
 tools/perf/ui/gtk/annotate.c                       |   4 +-
 tools/perf/ui/stdio/hist.c                         |   3 +-
 tools/perf/util/annotate.c                         |  99 +++++----
 tools/perf/util/annotate.h                         |  18 +-
 tools/perf/util/bpf-loader.c                       |   2 +-
 tools/perf/util/branch.h                           |  11 +-
 tools/perf/util/callchain.c                        | 157 +++++++++----
 tools/perf/util/cgroup.c                           |   8 +-
 tools/perf/util/config.c                           |  13 +-
 tools/perf/util/evsel.c                            |   8 +
 tools/perf/util/hist.c                             |   2 +
 tools/perf/util/llvm-utils.c                       |   2 +-
 tools/perf/util/machine.c                          |  13 +-
 .../util/scripting-engines/trace-event-python.c    | 246 +++++++++++++++------
 43 files changed, 798 insertions(+), 300 deletions(-)
 create mode 100644 tools/include/uapi/linux/sched.h
 create mode 100644 tools/perf/arch/s390/util/sym-handling.c
 create mode 100644 tools/perf/trace/beauty/clone.c

Test results:

The first ones are container (docker) based builds of tools/perf with and
without libelf support, objtool where it is supported and samples/bpf/, ditto.
Where clang is available, it is also used to build perf with/without libelf.

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

[root@jouet ~]# waitp 7228 ; time dm
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
  26 fedora:rawhide: FAIL

/usr/bin/ld: /tmp/build/perf/perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: /tmp/build/perf/libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
/usr/bin/ld: final link failed: Nonrepresentable section on output
collect2: error: ld returned 1 exit status
make[2]: *** [Makefile.perf:426: /tmp/build/perf/perf] Error 1
make[1]: *** [Makefile.perf:210: sub-make] Error 2

  27 mageia:5: Ok
  28 opensuse:13.2: Ok
  29 opensuse:42.1: Ok
  30 opensuse:42.2: Ok
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
  45 ubuntu:16.10: Ok
  46  ubuntu:17.04: Ok
  47  ubuntu:17.10: Ok
  #

  # uname -a
  Linux jouet 4.12.0-rc6+ #3 SMP Tue Jun 27 15:12:38 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
  # perf test
   1: vmlinux symtab matches kallsyms            : Ok
   2: Detect openat syscall event                : Ok
   3: Detect openat syscall event on all cpus    : Ok
   4: Read samples using the mmap interface      : Ok
   5: Parse event definition strings             : Ok
   6: Simple expression parser                   : Ok
   7: PERF_RECORD_* events & perf_sample fields  : Ok
   8: Parse perf pmu format                      : Ok
   9: DSO data read                              : Ok
  10: DSO data cache                             : Ok
  11: DSO data reopen                            : Ok
  12: Roundtrip evsel->name                      : Ok
  13: Parse sched tracepoints fields             : Ok
  14: syscalls:sys_enter_openat event fields     : Ok
  15: Setup struct perf_event_attr               : Ok
  16: Match and link multiple hists              : Ok
  17: 'import perf' in python                    : Ok
  18: Breakpoint overflow signal handler         : Ok
  19: Breakpoint overflow sampling               : Ok
  20: Number of exit events of a simple workload : Ok
  21: Software clock events period values        : Ok
  22: Object code reading                        : Ok
  23: Sample parsing                             : Ok
  24: Use a dummy software event to keep tracking: Ok
  25: Parse with no sample_id_all bit set        : Ok
  26: Filter hist entries                        : Ok
  27: Lookup mmap thread                         : Ok
  28: Share thread mg                            : Ok
  29: Sort output of hist entries                : Ok
  30: Cumulate child hist entries                : Ok
  31: Track with sched_switch                    : Ok
  32: Filter fds with revents mask in a fdarray  : Ok
  33: Add fd to a fdarray, making it autogrow    : Ok
  34: kmod_path__parse                           : Ok
  35: Thread map                                 : Ok
  36: LLVM search and compile                    :
  36.1: Basic BPF llvm compile                    : Ok
  36.2: kbuild searching                          : Ok
  36.3: Compile source for BPF prologue generation: Ok
  36.4: Compile source for BPF relocation         : Ok
  37: Session topology                           : Ok
  38: BPF filter                                 :
  38.1: Basic BPF filtering                      : Ok
  38.2: BPF pinning                              : Ok
  38.3: BPF prologue generation                  : Ok
  38.4: BPF relocation checker                   : Ok
  39: Synthesize thread map                      : Ok
  40: Remove thread map                          : Ok
  41: Synthesize cpu map                         : Ok
  42: Synthesize stat config                     : Ok
  43: Synthesize stat                            : Ok
  44: Synthesize stat round                      : Ok
  45: Synthesize attr update                     : Ok
  46: Event times                                : Ok
  47: Read backward ring buffer                  : Ok
  48: Print cpu map                              : Ok
  49: Probe SDT events                           : Ok
  50: is_printable_array                         : Ok
  51: Print bitmap                               : Ok
  52: perf hooks                                 : Ok
  53: builtin clang support                      : Skip (not compiled in)
  54: unit_number__scnprintf                     : Ok
  55: x86 rdpmc                                  : Ok
  56: Convert perf time to TSC                   : Ok
  57: DWARF unwind                               : Ok
  58: x86 instruction decoder - new instructions : Ok
  59: Intel cqm nmi context read                 : Skip
  #

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libperl_O: make NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                   make_pure_O: make
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_util_map_o_O: make util/map.o
                   make_help_O: make help
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_install_O: make install
               make_no_slang_O: make NO_SLANG=1
                 make_static_O: make LDFLAGS=-static
                   make_tags_O: make tags
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                 make_perf_o_O: make perf.o
        make_with_babeltrace_O: make LIBBABELTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                    make_doc_O: make doc
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
              make_no_libelf_O: make NO_LIBELF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
              make_clean_all_O: make clean all
                  make_debug_O: make DEBUG=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_install_prefix_O: make install prefix=/tmp/krava
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
