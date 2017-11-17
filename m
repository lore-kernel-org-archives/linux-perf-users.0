From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/83] perf/core improvements and fixes
Date: Fri, 17 Nov 2017 17:14:38 -0300
Message-ID: <20171117201601.24110-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751515AbdKQUQS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Nov 2017 15:16:18 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Andrei Vagin <avagin@openvz.org>, Bram Stolk <b.stolk@gmail.com>, David Ahern <dsahern@gmail.com>, Donald Stence <dstence@us.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Kan Liang <kan.liang@intel.com>, kernel-team@lge.com, Kim Phillips <kim.phillips@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 7862edc4191123f9c7e7ec0a7b356d332a61c41e:

  Merge remote-tracking branch 'torvalds/master' into perf/core (2017-11-13 09:39:12 -0300)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.15-20171117

for you to fetch changes up to 05d3f1a1d5a3d37ca4b591d5524f5a5b159d0564:

  perf tools: Move symbol__calc_percent() call to outside symbol__disassemble() (2017-11-17 12:16:26 -0300)

----------------------------------------------------------------
perf/core improvements and fixes:

- Optimize sample parsing for ordering events, where we don't need to parse
  all the PERF_SAMPLE_ bits, just the ones leading to the timestamp needed
  to reorder events (Jiri Olsa)

- Use a dummy event to ask for PERF_RECORD_{MMAP,COMM,EXEC} with
  'perf record --delay', when the events asked by the user will only be
  enabled after the workload is started and the requested delay passes,
  so we need to add the dummy event and have it .enabled_on_exec. This
  then allows us to resolve symbols for the DSO executable MMAPs setup
  while we wait for the delay (Arnaldo Carvalho de Melo)

- Synchronize kcmp.h and prctl.h ABI headers wrt SPDX tags (Arnaldo Carvalho de Melo)

- Generalize the annotation code to support other source information
  besides objdump/DWARF obtained ones, starting with python scripts,
  that will is slated to be merged soon (Jiri Olsa)

- Advance the source code lines to right after the column with the
  address in asm lines (Jiri Olsa)

- Fix terminal dimensions resizing signal handling in 'perf top --stdio' (Jiri Olsa)

- Improve error messages for PMU events (Kim Phillips)

- Fix 'perf record' -c/-F options for cpu event aliases (Andi Kleen)

- Enable type checking for perf_evsel_config_term types (Andi Kleen)

- Call machine__exit() at 'perf trace' exit, so as to remove temporary
  files related to VDSO (Andrei Vagin)

- Add "reject" option to parse-events.l, fixing the build with newer
  flex releases. Noticed with flex 2.6.4 on Alpine Linux 3.6 and Edge (Jiri Olsa)

- Document some missing perf.data headers (Andi Kleen)

- Allow printing period for non freq mod groups (Andi Kleen)

- Do not warn the user about kernel.kptr_restrict when not sampling the
  kernel (Arnaldo Carvalho de Melo)

- Fix bug in 'perf help' introduced during conversion to strstart() (Namhyung Kim)

- Do not truncate ASM instruction mnemonics at 6 characters in the annotation
  output, PowerPC has long ones (Ravi Bangoria)

- Document some missing command line options (Sihyeon Jang)

- Update POWER9 vendor event tables (Sukadev Bhattiprolu)

- Fix 'perf test' shell entries on s390x, where the 'openat' syscall
  is used instead of 'open' in one of the tests and

- No need to use overwrite mmap mode in 'perf test', those tests
  do not generate massive amount of events to fill the ring buffer (Wang Nan)

- Add missing command line options (mostly --force/-f) to the man pages (Sihyeon Jang)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andi Kleen (4):
      perf record: Fix -c/-F options for cpu event aliases
      perf evsel: Enable type checking for perf_evsel_config_term types
      perf tools: Document some missing perf.data headers
      perf script: Allow printing period for non freq mode groups

Andrei Vagin (1):
      perf trace: Fix an exit code of trace__symbols_init

Arnaldo Carvalho de Melo (10):
      perf evlist: Set the correct idx when adding dummy events
      perf record: Generate PERF_RECORD_{MMAP,COMM,EXEC} with --delay
      tools headers: Synchronize kernel ABI headers wrt SPDX tags
      perf evsel: Fix up leftover perf_evsel_stat usage via evsel->priv
      perf script: Fix --per-event-dump for auxtrace synth evsels
      perf machine: Guard against NULL in machine__exit()
      perf evlist: Add helper to check if attr.exclude_kernel is set in all evsels
      perf report: Ignore kptr_restrict when not sampling the kernel
      perf record: Ignore kptr_restrict when not sampling the kernel
      perf top: Ignore kptr_restrict when not sampling the kernel

Jiri Olsa (46):
      perf annotate: Add annotation_line struct
      perf annotate: Move line/offset into annotation_line struct
      perf annotate: Move ipc/cycles into annotation_line struct
      perf annotate: Add symbol__annotate function
      perf annotate: Add struct annotate_args
      perf annotate: Add arch into struct annotate_args
      perf annotate: Add map into struct annotate_args
      perf annotate: Add offset/line/line_nr into struct annotate_args
      perf annotate: Add evsel into struct annotation_line_args
      perf annotate: Add annotation_line__next function
      perf annotate: Add annotation_line__add function
      perf annotate: Move rb_node to struct annotation_line
      perf annotate: Add annotation_line__(new|delete) functions
      perf annotate: Add annotated_source__purge function
      perf annotate: Add samples into struct annotation_line
      perf annotate: Add symbol__calc_percent function
      perf annotate: Add symbol__calc_lines function
      perf annotate: Remove disasm__calc_percent() from disasm_line__print()
      perf annotate: Remove disasm__calc_percent() from annotate_browser__calc_percent()
      perf annotate: Remove disasm__calc_percent function
      perf annotate: Remove struct source_line
      perf annotate: Add annotation_line__print function
      perf annotate: Factor annotation_line__print from disasm_line__print
      perf annotate browser: Use samples data from struct annotation_line
      perf annotate browser: Do not pass nr_events in disasm_rb_tree__insert
      perf annotate browser: Rename struct browser_disasm_line to browser_line
      perf annotate browser: Rename disasm_line__browser to browser_line
      perf annotate browser: Change selection to struct annotation_line
      perf annotate browser: Change offsets to struct annotation_line
      perf annotate browser: Use struct annotation_line in browser_line
      perf annotate browser: Use struct annotation_line in find functions
      perf annotate browser: Use struct annotation_line in browser top
      perf annotate browser: Add disasm_line__write function
      perf annotate: Align source and offset lines
      perf tools: Use shell function for perl cflags retrieval
      perf: Fix header.size for namespace events
      perf callchain: Reset cursor arg instead of callchain_cursor
      perf evsel: Centralize perf_sample initialization
      perf evlist: Add perf_evlist__parse_sample_timestamp function
      perf ordered_events: Pass timestamp arg in perf_session__queue_event
      perf tools: Optimize sample parsing for ordered events
      perf top: Fix window dimensions change handling
      perf top: Use signal interface for SIGWINCH handler
      perf top: Fix crash when annotating symbol
      perf tools: Change (symbol|annotation)__calc_percent return type to void
      perf tools: Move symbol__calc_percent() call to outside symbol__disassemble()

Kim Phillips (2):
      perf c2c: Fix spelling mistakes in browser help text
      perf evsel: Say which PMU Hardware event doesn't support sampling/overflow-interrupts

Namhyung Kim (1):
      perf help: Fix a bug during strstart() conversion

Ravi Bangoria (1):
      perf annotate: Do not truncate instruction names at 6 chars

Seonghyun Park (1):
      perf tests: Add missing WRITE_ASS for new fields of perf_event_attr

Sihyeon Jang (9):
      perf top: Document missing options
      perf top: Remove a duplicate word
      perf lock: Document missing options
      perf inject: Document missing options
      perf trace: Document missing option, colons
      perf timechart: Document missing --force option
      perf sched: Document missing --force option
      perf evlist: Document missing --force option
      perf buildid-cache: Document missing --force option

Sukadev Bhattiprolu (1):
      perf vendor events powerpc: Update POWER9 events

Thomas Richter (2):
      perf test shell: Fix check open filename arg using 'perf trace' on s390x
      perf test shell: Fix test case probe libc's inet_pton on s390x

Thomas-Mich Richter (1):
      perf buildid-cache: Update help text for purge command

Wang Nan (4):
      perf tests: Set evlist of test__backward_ring_buffer() to !overwrite
      perf tests: Set evlist of test__sw_clock_freq() to !overwrite
      perf tests: Set evlist of test__basic_mmap() to !overwrite
      perf tests: Set evlist of test__task_exit() to !overwrite

 kernel/events/core.c                               |   5 +-
 tools/include/uapi/linux/kcmp.h                    |   1 +
 tools/include/uapi/linux/prctl.h                   |   1 +
 tools/perf/Documentation/perf-buildid-cache.txt    |   3 +
 tools/perf/Documentation/perf-evlist.txt           |   4 +
 tools/perf/Documentation/perf-inject.txt           |   4 +
 tools/perf/Documentation/perf-lock.txt             |   4 +
 tools/perf/Documentation/perf-sched.txt            |   4 +
 tools/perf/Documentation/perf-timechart.txt        |   4 +-
 tools/perf/Documentation/perf-top.txt              |   6 +
 tools/perf/Documentation/perf-trace.txt            |  16 +-
 tools/perf/Documentation/perf.data-file-format.txt |  23 +
 tools/perf/Makefile.config                         |   2 +-
 tools/perf/builtin-buildid-cache.c                 |   4 +-
 tools/perf/builtin-c2c.c                           |   8 +-
 tools/perf/builtin-help.c                          |   4 +-
 tools/perf/builtin-kvm.c                           |   8 +-
 tools/perf/builtin-record.c                        |  42 +-
 tools/perf/builtin-report.c                        |   3 +
 tools/perf/builtin-script.c                        |  36 +-
 tools/perf/builtin-top.c                           |  44 +-
 tools/perf/builtin-trace.c                         |   6 +-
 .../perf/pmu-events/arch/powerpc/power9/cache.json |   5 -
 .../pmu-events/arch/powerpc/power9/frontend.json   |   7 +-
 .../pmu-events/arch/powerpc/power9/marked.json     |  27 +-
 .../perf/pmu-events/arch/powerpc/power9/other.json | 276 +++------
 .../pmu-events/arch/powerpc/power9/pipeline.json   |  14 +-
 tools/perf/pmu-events/arch/powerpc/power9/pmc.json |   2 +-
 .../arch/powerpc/power9/translation.json           |   5 -
 tools/perf/tests/attr.c                            |   6 +
 tools/perf/tests/backward-ring-buffer.c            |   2 +-
 tools/perf/tests/mmap-basic.c                      |   2 +-
 .../perf/tests/shell/trace+probe_libc_inet_pton.sh |   7 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |   6 +-
 tools/perf/tests/sw-clock.c                        |   2 +-
 tools/perf/tests/task-exit.c                       |   2 +-
 tools/perf/ui/browsers/annotate.c                  | 401 +++++++------
 tools/perf/ui/gtk/annotate.c                       |  25 +-
 tools/perf/util/annotate.c                         | 651 +++++++++++----------
 tools/perf/util/annotate.h                         |  76 +--
 tools/perf/util/evlist.c                           |  25 +-
 tools/perf/util/evlist.h                           |   6 +
 tools/perf/util/evsel.c                            |  92 ++-
 tools/perf/util/evsel.h                            |  10 +-
 tools/perf/util/machine.c                          |   5 +-
 tools/perf/util/ordered-events.c                   |   3 +-
 tools/perf/util/ordered-events.h                   |   2 +-
 tools/perf/util/parse-events.c                     |   2 +
 tools/perf/util/parse-events.h                     |   3 +
 tools/perf/util/pmu.c                              |   5 +
 tools/perf/util/session.c                          |  45 +-
 tools/perf/util/session.h                          |   2 +-
 52 files changed, 1028 insertions(+), 920 deletions(-)

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
   1 alpine:3.4: Ok                    gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5: Ok                    gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6: Ok                    gcc (Alpine 6.3.0) 6.3.0
   4 alpine:edge: Ok                   gcc (Alpine 6.4.0) 6.4.0
   5 android-ndk:r12b-arm: Ok          arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   6 android-ndk:r15c-arm: Ok          arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   7 centos:5: Ok                      gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
   8 centos:6: Ok                      gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
   9 centos:7: Ok                      gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  10 debian:7: Ok                      gcc (Debian 4.7.2-5) 4.7.2
  11 debian:8: Ok                      gcc (Debian 4.9.2-10) 4.9.2
  12 debian:9: Ok                      gcc (Debian 6.3.0-18) 6.3.0 20170516
  13 debian:experimental: Ok           gcc (Debian 7.2.0-16) 7.2.0
  14 debian:experimental-x-arm64: Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  15 debian:experimental-x-mips: Ok    mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  16 debian:experimental-x-mips64: Ok  mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  17 fedora:20: Ok                     gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  18 fedora:21: Ok                     gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  19 fedora:22: Ok                     gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  20 fedora:23: Ok                     gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  21 fedora:24: Ok                     gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  22 fedora:24-x-ARC-uClibc: Ok        arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  23 fedora:25: Ok                     gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  24 fedora:26: Ok                     gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  25 fedora:27: FAIL                   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)

    /usr/bin/ld: /tmp/build/perf/perf-in.o: relocation R_X86_64_32 against `.rodata.str1.1' can not be used when making a shared object; recompile with -fPIC
    /usr/bin/ld: /tmp/build/perf/libperf.a(libperf-in.o): relocation R_X86_64_32S against `.text' can not be used when making a shared object; recompile with -fPIC
    /usr/bin/ld: final link failed: Nonrepresentable section on output
    collect2: error: ld returned 1 exit status

    Jiri is working on a fix for this hardened build situation, where some CFLAGS
    used for perl/python are incompatible with what we use for the rest of the tools.

  26 fedora:rawhide: Ok                gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  27 gentoo-stage3-amd64:latest: Ok    gcc (Gentoo 5.4.0-r3 p1.7, pie-0.6.5) 5.4.0
  28 mageia:5: Ok                      gcc (GCC) 4.9.2
  29 mageia:6: Ok                      gcc (Mageia 5.4.0-5.mga6) 5.4.0
  30 opensuse:42.1: Ok                 gcc (SUSE Linux) 4.8.5
  31 opensuse:42.2: Ok                 gcc (SUSE Linux) 4.8.5
  32 opensuse:42.3: Ok                 gcc (SUSE Linux) 4.8.5
  33 opensuse:tumbleweed: Ok           gcc (SUSE Linux) 7.2.1 20170901 [gcc-7-branch revision 251580]
  34 oraclelinux:6: Ok                 gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  35 oraclelinux:7: Ok                 gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  36 ubuntu:12.04.5: Ok                gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  37 ubuntu:14.04.4: Ok                gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  38 ubuntu:14.04.4-x-linaro-arm64: Ok aarch64-linux-gnu-gcc
  39 ubuntu:15.04: Ok                  gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  40 ubuntu:16.04: Ok                  gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  41 ubuntu:16.04-x-arm: Ok            arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  42 ubuntu:16.04-x-arm64: Ok          aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  43 ubuntu:16.04-x-powerpc: Ok        powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 ubuntu:16.04-x-powerpc64: Ok      powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  45 ubuntu:16.04-x-powerpc64el: Ok    powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-s390: Ok           s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  47 ubuntu:16.10: Ok                  gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  48 ubuntu:17.04: Ok                  gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  49 ubuntu:17.10: Ok                  gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0

  # uname -a
  Linux jouet 4.14.0+ #2 SMP Thu Nov 16 12:09:19 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
            make_no_auxtrace_O: make NO_AUXTRACE=1
                 make_perf_o_O: make perf.o
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_util_map_o_O: make util/map.o
                make_no_gtk2_O: make NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
                    make_doc_O: make doc
                   make_pure_O: make
            make_no_demangle_O: make NO_DEMANGLE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
                 make_static_O: make LDFLAGS=-static
              make_no_libbpf_O: make NO_LIBBPF=1
                make_install_O: make install
              make_no_libelf_O: make NO_LIBELF=1
                   make_help_O: make help
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                   make_tags_O: make tags
               make_no_slang_O: make NO_SLANG=1
                  make_debug_O: make DEBUG=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_clean_all_O: make clean all
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
  
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
