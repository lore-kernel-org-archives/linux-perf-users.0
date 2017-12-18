From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 0/5] perf/urgent fixes
Date: Mon, 18 Dec 2017 11:39:07 -0300
Message-ID: <20171218143912.6036-1-acme@kernel.org>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750916AbdLROj0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Dec 2017 09:39:26 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Potapenko <glider@google.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Ben Gainey <ben.gainey@arm.com>, Colin King <colin.king@canonical.com>, Daniel Borkmann <daniel@iogearbox.net>, Darren Hart <dvhart@infradead.org>, David Ahern <dsahern@gmail.com>, Dmitriy Vyukov <dvyukov@google.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Jiri Olsa <jolsa@redhat.com>, Josh

Hi Ingo,

	This was ready already before my short vacations, and get things
building on the recently released fedora 27 and make 'perf test' pass
all entries, so please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit 34c9ca37aaec2e307b837bb099d3b44f0ea04ddc:

  tooling/headers: Synchronize updated s390 and x86 UAPI headers (2017-12-06 22:45:24 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.15-20171218

for you to fetch changes up to 38ab834165924bf86fe7ee67bb5dbea56240b03f:

  x86/asm: Allow again using asm.h when building for the 'bpf' clang target (2017-12-15 12:30:16 -0300)

----------------------------------------------------------------
perf/urgent fixes:

- Fix up build in hardened environments, such as fedora 27 (Jiri Olsa)

- Do not include header files from the kernel sources for the s/390 arch,
  fixing the detached tarball building (Arnaldo Carvalho de Melo)

- Allow again using asm.h when building for the 'bpf' clang target,
  guarding x86 specific bits under ifndef __BPF__ (Arnaldo Carvalho de Melo)

- Generate correct debug information for inlined code when generating
  ELF images for JITted java programs (Ben Gainey)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (2):
      tools arch s390: Do not include header files from the kernel sources
      x86/asm: Allow again using asm.h when building for the 'bpf' clang target

Ben Gainey (1):
      perf jvmti: Generate correct debug information for inlined code

Jiri Olsa (2):
      perf tools: Use shell function for perl cflags retrieval
      perf tools: Fix up build in hardened environments

 arch/x86/include/asm/asm.h                   |   2 +
 tools/arch/s390/include/uapi/asm/perf_regs.h |  43 ++++++++
 tools/perf/Makefile.config                   |   9 +-
 tools/perf/arch/s390/include/perf_regs.h     |   2 +-
 tools/perf/check-headers.sh                  |   1 +
 tools/perf/jvmti/jvmti_agent.c               |  16 +--
 tools/perf/jvmti/jvmti_agent.h               |   7 +-
 tools/perf/jvmti/libjvmti.c                  | 147 ++++++++++++++++++++++-----
 8 files changed, 185 insertions(+), 42 deletions(-)
 create mode 100644 tools/arch/s390/include/uapi/asm/perf_regs.h

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

News: Amazon Linux 2 and Ubuntu 18.04 added.

  # dm
   1 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0
   2 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822
   3 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0
   4 alpine:edge                   : Ok   gcc (Alpine 6.4.0) 6.4.0
   5 amazonlinux:2                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
   6 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   7 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   8 centos:5                      : Ok   gcc (GCC) 4.1.2 20080704 (Red Hat 4.1.2-55)
   9 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  10 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  11 debian:7                      : Ok   gcc (Debian 4.7.2-5) 4.7.2
  12 debian:8                      : Ok   gcc (Debian 4.9.2-10) 4.9.2
  13 debian:9                      : Ok   gcc (Debian 6.3.0-18) 6.3.0 20170516
  14 debian:experimental           : Ok   gcc (Debian 7.2.0-17) 7.2.1 20171205
  15 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  16 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  17 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 7.2.0-11) 7.2.0
  18 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
  19 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  20 fedora:21                     : Ok   gcc (GCC) 4.9.2 20150212 (Red Hat 4.9.2-6)
  21 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  22 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6)
  23 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
  24 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  25 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1)
  26 fedora:26                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  27 fedora:27                     : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2)
  28 fedora:rawhide                : Ok   gcc (GCC) 7.2.1 20170829 (Red Hat 7.2.1-1)
  29 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 6.4.0 p1.1) 6.4.0
  30 mageia:5                      : Ok   gcc (GCC) 4.9.2
  31 mageia:6                      : Ok   gcc (Mageia 5.4.0-5.mga6) 5.4.0
  32 opensuse:42.1                 : Ok   gcc (SUSE Linux) 4.8.5
  33 opensuse:42.2                 : Ok   gcc (SUSE Linux) 4.8.5
  34 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5
  35 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 7.2.1 20171020 [gcc-7-branch revision 253932]
  36 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)
  37 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
  38 ubuntu:12.04.5                : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3
  39 ubuntu:14.04.4                : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4
  40 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.4-2017.05) 5.4.1 20170404
  41 ubuntu:15.04                  : Ok   gcc (Ubuntu 4.9.2-10ubuntu13) 4.9.2
  42 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609
  43 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  44 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  45 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  46 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.1) 5.4.0 20160609
  47 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  48 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.4) 5.4.0 20160609
  49 ubuntu:16.10                  : Ok   gcc (Ubuntu 6.2.0-5ubuntu12) 6.2.0 20161005
  50 ubuntu:17.04                  : Ok   gcc (Ubuntu 6.3.0-12ubuntu2) 6.3.0 20170406
  51 ubuntu:17.10                  : Ok   gcc (Ubuntu 7.2.0-8ubuntu3) 7.2.0
  52 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.2.0-16ubuntu1) 7.2.0

  # uname -a
  Linux jouet 4.15.0-rc3+ #3 SMP Wed Dec 13 10:14:18 -03 2017 x86_64 x86_64 x86_64 GNU/Linux
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
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
               make_no_slang_O: make NO_SLANG=1
                  make_debug_O: make DEBUG=1
                 make_perf_o_O: make perf.o
                    make_doc_O: make doc
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
             make_no_libperl_O: make NO_LIBPERL=1
                 make_static_O: make LDFLAGS=-static
                make_install_O: make install
                make_no_newt_O: make NO_NEWT=1
             make_util_map_o_O: make util/map.o
              make_clean_all_O: make clean all
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
            make_install_bin_O: make install-bin
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_help_O: make help
              make_no_libbpf_O: make NO_LIBBPF=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_tags_O: make tags
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_pure_O: make
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
