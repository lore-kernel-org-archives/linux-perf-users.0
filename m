From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL 00/18] perf/core improvements
Date: Tue,  1 Aug 2017 16:56:27 -0300
Message-ID: <20170801195645.16986-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbdHAT5D (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2017 15:57:03 -0400
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Daniel Borkmann <daniel@iogearbox.net>, David Ahern <dsahern@gmail.com>, David Carrillo-Cisneros <davidcc@google.com>, "David S . Miller" <davem@davemloft.net>, Francis Deslauriers <francis.deslauriers@efficios.com>, =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@redhat.com>, Julien Desfossez <jdesfossez@efficios.com>, Lawrence Brakmo <brakmo@fb.com>, =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Michae

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Ingo,

	Please consider pulling,

- Arnaldo

Test results at the end of this message, as usual.

The following changes since commit c3a3800fe46f00ceeeb181cc07cc4fdaed4574f1:

  Merge tag 'perf-core-for-mingo-4.14-20170728' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/core (2017-07-30 11:15:37 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-core-for-mingo-4.14-20170801

for you to fetch changes up to 81e3d8b2af2e7417f1d5164aab5c1a75955e8a5d:

  perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg (2017-08-01 13:33:50 -0300)

----------------------------------------------------------------
perf/core improvements:

User visible:

- Beautifiers for the 'cmd' arg of several ioctl types, including:
  sound, DRM, KVM, vhost virtio and perf_events.

  This was done by using scripts that extract the information from
  the UAPI headers, generating string tables that are then used in
  the 'perf trace' syscall argument ioctl beautifier.

  More work needed to further use it, for instance, to use the
  _IOC_DIR value where it is used sanely to suppress the third
  argument, to set formatters for non-pointer values and ultimately
  for using eBPF + pahole-like code to collect + beautify structs in
  the third arg.

  Using the current scheme of having tools/ copies of kernel headers
  we'll make sure tooling stays working when changes are made to the
  kernel ABI headers and will be notified when they get changed,
  reducing the time for 'perf trace' to support new ABIs and allowing
  the tools/perf/ codebase to have the definitions it needs to
  build in dozens of distros/versions, as routinely tested using
  containers for, at this time, 47 environments. (Arnaldo Carvalho de Melo)

Infrastructure

- Clarify header version warning message (Ingo Molnar)

- Sync kernel ABI headers with tooling headers (Ingo Molnar, Arnaldo Carvalho de Melo)

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (15):
      tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
      tools include uapi: Grab a copy of asm-generic/ioctls.h
      tools perf: Do not check spaces/blank lines when checking header file copy drift
      tools headers: Fixup tools/include/uapi/linux/bpf.h copy of kernel ABI header
      perf trace beauty ioctl: Improve 'cmd' beautifier
      tools include uapi: Grab copies of drm/{drm,i915_drm}.h
      perf trace beauty ioctl: Beautify DRM ioctl cmds
      tools include uapi: Grab a copy of sound/asound.h
      perf trace beautify ioctl: Beautify sound ioctl's 'cmd' arg
      tools include uapi: Grab a copy of linux/kvm.h
      perf trace beautify ioctl: Beautify KVM ioctl's 'cmd' arg
      perf trace beauty ioctl: Pass _IOC_DIR to the per _IOC_TYPE scnprintf
      tools include uapi: Grab a copy of linux/vhost.h
      perf trace beautify ioctl: Beautify vhost virtio ioctl's 'cmd' arg
      perf trace beautify ioctl: Beautify perf ioctl's 'cmd' arg

Ingo Molnar (3):
      perf build: Clarify header version warning message
      perf build: Clarify open-coded header version warning message
      tools headers: Sync kernel ABI headers with tooling headers

 tools/arch/arm/include/uapi/asm/kvm.h          |    8 +
 tools/arch/arm64/include/uapi/asm/kvm.h        |    3 +
 tools/arch/powerpc/include/uapi/asm/kvm.h      |    6 +
 tools/arch/s390/include/uapi/asm/kvm.h         |   12 +
 tools/arch/x86/include/asm/cpufeatures.h       |    2 +
 tools/arch/x86/include/asm/disabled-features.h |    4 +-
 tools/include/uapi/asm-generic/ioctls.h        |  118 ++
 tools/include/uapi/drm/drm.h                   |  933 +++++++++++++++
 tools/include/uapi/drm/i915_drm.h              | 1474 ++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h                 |   16 +-
 tools/include/uapi/linux/kvm.h                 | 1419 +++++++++++++++++++++++
 tools/include/uapi/linux/vhost.h               |  209 ++++
 tools/include/uapi/sound/asound.h              | 1026 +++++++++++++++++
 tools/lib/bpf/Makefile                         |    4 +-
 tools/perf/MANIFEST                            |    6 +
 tools/perf/Makefile.perf                       |   61 +-
 tools/perf/arch/x86/Makefile                   |    2 +-
 tools/perf/builtin-trace.c                     |   44 +-
 tools/perf/check-headers.sh                    |   18 +-
 tools/perf/trace/beauty/Build                  |    3 +
 tools/perf/trace/beauty/beauty.h               |    3 +
 tools/perf/trace/beauty/drm_ioctl.sh           |   13 +
 tools/perf/trace/beauty/ioctl.c                |  162 +++
 tools/perf/trace/beauty/kvm_ioctl.sh           |   11 +
 tools/perf/trace/beauty/perf_ioctl.sh          |   10 +
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh     |    8 +
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh     |    8 +
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh  |   17 +
 28 files changed, 5538 insertions(+), 62 deletions(-)
 create mode 100644 tools/include/uapi/asm-generic/ioctls.h
 create mode 100644 tools/include/uapi/drm/drm.h
 create mode 100644 tools/include/uapi/drm/i915_drm.h
 create mode 100644 tools/include/uapi/linux/kvm.h
 create mode 100644 tools/include/uapi/linux/vhost.h
 create mode 100644 tools/include/uapi/sound/asound.h
 create mode 100755 tools/perf/trace/beauty/drm_ioctl.sh
 create mode 100644 tools/perf/trace/beauty/ioctl.c
 create mode 100755 tools/perf/trace/beauty/kvm_ioctl.sh
 create mode 100755 tools/perf/trace/beauty/perf_ioctl.sh
 create mode 100755 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh
 create mode 100755 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh
 create mode 100755 tools/perf/trace/beauty/vhost_virtio_ioctl.sh

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
  26 fedora:rawhide: FAIL
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
  46 ubuntu:17.04: Ok
  47 ubuntu:17.10: Ok
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

  # perf-test.sh 
  1: Add vfs_getname probe to obtain filenames in syscall args: Ok
  2: perf trace backtrace: Ok
  3: Recording open file: Ok
  4: Filenames using perf script : Ok
  5: Checking open filename arg using perf trace + vfs_getname : Ok
  # 

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/linux/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
           make_no_libbionic_O: make NO_LIBBIONIC=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_no_libperl_O: make NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
                 make_static_O: make LDFLAGS=-static
              make_clean_all_O: make clean all
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                   make_pure_O: make
                make_install_O: make install
             make_util_map_o_O: make util/map.o
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_perf_o_O: make perf.o
           make_no_libpython_O: make NO_LIBPYTHON=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_no_newt_O: make NO_NEWT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                   make_help_O: make help
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
               make_no_slang_O: make NO_SLANG=1
                make_no_gtk2_O: make NO_GTK2=1
              make_no_libelf_O: make NO_LIBELF=1
                   make_tags_O: make tags
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_install_prefix_O: make install prefix=/tmp/krava
  OK
  make: Leaving directory '/home/acme/git/linux/tools/perf'
  $
