Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2CC07E95
	for <linux-perf-users@archiver.kernel.org>; Sat, 10 Jul 2021 20:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C3661356
	for <linux-perf-users@archiver.kernel.org>; Sat, 10 Jul 2021 20:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhGJUzi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhGJUzi (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 10 Jul 2021 16:55:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C7FA61355;
        Sat, 10 Jul 2021 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625950372;
        bh=23WtqEyIZkrAITNdE8yuLYNzndc/mjnpXlc4QeQwGe4=;
        h=From:To:Cc:Subject:Date:From;
        b=MlwI3FS7Z+oDhgcp5yooIRFV2pSgKIuVo2VR2/l/NZZsKr0glSiwwVyG1AJsDE1m4
         3UmdZJwZy1Yu5GRus9aoq2/sqgdRhgi8VcyafigaIEIP8uYRcxfhCqDJCZGeLX8ITL
         y5ZbXl/pDyBiecBope5MPquz2jFuq0QAzgznXYHlAECwUAyScnvbzIgKNrjKwWvsFu
         qVYhGk5mz2+gWjg/JV8KpR61fTvFdwGfJi2cG/gBICqSgxo98sNr4XMPgFSmwGnxqg
         hYP9lXVER/+llntJ25wC235BPSlbwspGELL4e0nKSqa+mNOKTMMmn1qfgfDVYNTn8b
         AOkrEP5gDbsMw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Justin M . Forbes" <jforbes@fedoraproject.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nageswara R Sastry <rnsastry@linux.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.14: 2nd batch
Date:   Sat, 10 Jul 2021 17:52:40 -0300
Message-Id: <20210710205240.1343120-1-acme@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit a180bd1d7e16173d965b263c5a536aa40afa2a2a:

  iov_iter: remove uaccess_kernel() warning from iov_iter_init() (2021-07-04 16:12:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-10

for you to fetch changes up to eb7261f14e1a86f0fd299a2ec408990d349ce3d1:

  perf test: Add free() calls for scandir() returned dirent entries (2021-07-09 15:34:41 -0300)

----------------------------------------------------------------
perf tools changes for v5.14: 2nd batch

New features:

- Enable use of BPF counters with 'perf stat --for-each-cgroup', using per-CPU
  'cgroup-switch' events with an attached BPF program that does aggregation
  per-cgroup in the kernel instead of using per-cgroup perf events.

- Add Topdown metrics L2 events as default events in 'perf stat' for systems
  having those events.

Hardware tracing:

- Add a config for max loops without consuming a packet in the Intel PT packet
  decoder, set via 'perf config intel-pt.max-loops=N'

Hardware enablement:

- Disable misleading NMI watchdog message in 'perf stat' on hybrid systems
  such as Intel Alder Lake.

- Add a dummy event on hybrid systems to collect metadata records.

- Add 24x7 nest metric events for the Power10 platform.

Fixes:

- Fix event parsing for PMUs starting with the same prefix.

- Fix the 'perf trace' 'trace' alias installation dir.

- Fix buffer size to report iregs in perf script python scripts, supporting
  the extended registers in PowerPC.

- Fix overflow in elf_sec__is_text().

- Fix 's' on source line when disasm is empty in the annotation TUI, accessible
  via 'perf annotate', 'perf report' and 'perf top'.

- Plug leaks in scandir() returned dirent entries in 'perf test' when sorting
  the shell tests.

- Fix --task and --stat with pipe input in 'perf report'.

- Fix 'perf probe' use of debuginfo files by build id.

- If a DSO has both dynsym and symtab ELF sections, read from both when loading
  the symbol table, fixing a problem processing Fedora 32 glibc DSOs.

Libraries:

- Add grouping of events to libperf, from code in tools/perf, allowing
  libperf users to use that mode.

Misc:

- Filter plt stubs from the 'perf probe --functions' output.

- Update UAPI header copies for asound, DRM, mman-common.h and the ones
  affected by the quotactl_fd syscall.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (1):
      perf intel-pt: Add a config for max loops without consuming a packet

Arnaldo Carvalho de Melo (6):
      tools include UAPI: Sync sound/asound.h copy with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm/drm.h header
      tools headers UAPI: Sync asm-generic/mman-common.h with the kernel
      tools headers UAPI: Sync files changed by the quotactl_fd new syscall
      libperf: Remove BUG_ON() from library code in get_group_fd()

Jin Yao (2):
      perf stat: Disable the NMI watchdog message on hybrid
      perf tools: Fix pattern matching for same substring in different PMU type

Jiri Olsa (7):
      libperf: Change tests to single static and shared binaries
      libperf: Move 'idx' from tools/perf to perf_evsel::idx
      libperf: Move 'leader' from tools/perf to perf_evsel::leader
      libperf: Move 'nr_groups' from tools/perf to evlist::nr_groups
      libperf: Adopt evlist__set_leader() from tools/perf as perf_evlist__set_leader()
      libperf: Add group support to perf_evsel__open()
      libperf: Add tests for perf_evlist__set_leader()

Justin M. Forbes (1):
      perf trace: Fix the perf trace link location

Kajol Jain (2):
      perf script python: Fix buffer size to report iregs in perf script
      perf vendor events power10: Adds 24x7 nest metric events for power10 platform

Kan Liang (2):
      perf stat: Add Topdown metrics L2 events as default events
      perf record: Add a dummy event on hybrid systems to collect metadata records

Masami Hiramatsu (3):
      perf probe: Fix debuginfo__new() to enable build-id based debuginfo
      perf symbol-elf: Decode dynsym even if symtab exists
      perf probe: Do not show @plt function by default

Namhyung Kim (2):
      perf report: Fix --task and --stat with pipe input
      perf stat: Enable BPF counter with --for-each-cgroup

Riccardo Mancini (3):
      perf annotate: Fix 's' on source line when disasm is empty
      perf top: Fix overflow in elf_sec__is_text()
      perf test: Add free() calls for scandir() returned dirent entries

 tools/include/uapi/asm-generic/mman-common.h       |   3 +
 tools/include/uapi/asm-generic/unistd.h            |   3 +-
 tools/include/uapi/drm/drm.h                       |  28 +-
 tools/include/uapi/drm/i915_drm.h                  | 393 +++++++++++++++++--
 tools/include/uapi/sound/asound.h                  |  30 +-
 tools/lib/perf/Build                               |   2 +
 tools/lib/perf/Makefile                            |  30 +-
 tools/lib/perf/evlist.c                            |  22 ++
 tools/lib/perf/evsel.c                             |  42 +-
 tools/lib/perf/include/internal/evlist.h           |   2 +
 tools/lib/perf/include/internal/evsel.h            |   5 +-
 tools/lib/perf/include/internal/tests.h            |   4 +-
 tools/lib/perf/include/perf/evlist.h               |   1 +
 tools/lib/perf/libperf.map                         |   1 +
 tools/lib/perf/tests/Build                         |   5 +
 tools/lib/perf/tests/Makefile                      |  40 --
 tools/lib/perf/tests/main.c                        |  15 +
 tools/lib/perf/tests/test-cpumap.c                 |   3 +-
 tools/lib/perf/tests/test-evlist.c                 |  30 +-
 tools/lib/perf/tests/test-evsel.c                  |   3 +-
 tools/lib/perf/tests/test-threadmap.c              |   3 +-
 tools/lib/perf/tests/tests.h                       |  10 +
 tools/perf/Documentation/perf-config.txt           |   6 +
 tools/perf/Makefile.perf                           |  19 +-
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |   2 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |   2 +-
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   2 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   2 +-
 tools/perf/arch/x86/util/evlist.c                  |   6 +-
 tools/perf/arch/x86/util/iostat.c                  |   4 +-
 tools/perf/builtin-diff.c                          |   4 +-
 tools/perf/builtin-probe.c                         |   2 +-
 tools/perf/builtin-record.c                        |  13 +-
 tools/perf/builtin-report.c                        |  14 +-
 tools/perf/builtin-script.c                        |   9 +-
 tools/perf/builtin-stat.c                          |  15 +-
 tools/perf/builtin-top.c                           |  10 +-
 .../arch/powerpc/power10/nest_metrics.json         | 424 +++++++++++++++++++++
 tools/perf/tests/bpf.c                             |   2 +-
 tools/perf/tests/builtin-test.c                    |  15 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   6 +-
 tools/perf/tests/mmap-basic.c                      |   8 +-
 tools/perf/tests/parse-events.c                    |  74 ++--
 tools/perf/tests/pfm.c                             |   4 +-
 tools/perf/ui/browsers/annotate.c                  |   6 +-
 tools/perf/ui/gtk/annotate.c                       |   4 +-
 tools/perf/util/Build                              |   1 +
 tools/perf/util/annotate.c                         |   8 +-
 tools/perf/util/auxtrace.c                         |  12 +-
 tools/perf/util/bpf_counter.c                      |   7 +-
 tools/perf/util/bpf_counter_cgroup.c               | 307 +++++++++++++++
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c        | 191 ++++++++++
 tools/perf/util/cgroup.c                           |   4 +-
 tools/perf/util/cgroup.h                           |   1 +
 tools/perf/util/evlist.c                           |  44 +--
 tools/perf/util/evlist.h                           |   2 -
 tools/perf/util/evsel.c                            |  32 +-
 tools/perf/util/evsel.h                            |  14 +-
 tools/perf/util/header.c                           |  18 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  13 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   1 +
 tools/perf/util/intel-pt.c                         |   5 +
 tools/perf/util/metricgroup.c                      |  22 +-
 tools/perf/util/parse-events.c                     |   8 +-
 tools/perf/util/parse-events.y                     |   2 +-
 tools/perf/util/pfm.c                              |   2 +-
 tools/perf/util/pmu.c                              |  36 +-
 tools/perf/util/pmu.h                              |   1 +
 tools/perf/util/probe-finder.c                     |   5 +
 tools/perf/util/python.c                           |   2 +-
 tools/perf/util/record.c                           |   6 +-
 .../util/scripting-engines/trace-event-python.c    |  17 +-
 tools/perf/util/stat-display.c                     |   9 +-
 tools/perf/util/stat-shadow.c                      |   2 +-
 tools/perf/util/stat.c                             |   2 +-
 tools/perf/util/stream.c                           |   2 +-
 tools/perf/util/symbol-elf.c                       |  99 +++--
 77 files changed, 1872 insertions(+), 331 deletions(-)
 create mode 100644 tools/lib/perf/tests/Build
 delete mode 100644 tools/lib/perf/tests/Makefile
 create mode 100644 tools/lib/perf/tests/main.c
 create mode 100644 tools/lib/perf/tests/tests.h
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/nest_metrics.json
 create mode 100644 tools/perf/util/bpf_counter_cgroup.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c

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
features as well as with a complete one.

The following ones are now being run on all the containers, so far just with
gcc, clang will come later. All clear for this batch.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

   $ export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0.tar.xz
   $ dm
   1 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
   2 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  14 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  15 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
  16 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  17 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  18 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  19 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.1.1 20210624 releases/gcc-11.1.0-356-gf19b20de1b , clang version 11.1.0
  20 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  21 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  22 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  23 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  24 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  25 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  26 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  27 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  28 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  29 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  30 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  31 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  32 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  33 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  34 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  35 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  36 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  37 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  38 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  39 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  40 fedora:34                     : Ok   gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3) , clang version 12.0.0 (Fedora 12.0.0-2.fc34)
  41 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  42 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  43 fedora:rawhide                : Ok   gcc (GCC) 11.1.1 20210623 (Red Hat 11.1.1-6) , clang version 12.0.1 (Fedora 12.0.1~rc3-1.fc35)
  44 gentoo-stage3:latest          : Ok   gcc (Gentoo 10.3.0 p1) 10.3.0 
  45 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  46 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
  
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.13.0/tools/build/Makefile.build:139: util] Error 2
  
  47 openmandriva:cooker           : Ok   gcc (GCC) 11.1.0 20210427 (OpenMandriva) , OpenMandriva 12.0.0-1 clang version 12.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-12.0.0/clang b3a1e025e0452bb54d01ab5281bbf509ac4e3c72)
  48 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  49 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  50 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  51 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  52 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.1.1 20210510 [revision 23855a176609fe8dda6abaf2b21846b4517966eb] , clang version 12.0.0
  53 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.2) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  54 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  55 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  56 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  57 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  58 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  59 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  60 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  61 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  62 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  63 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  64 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  65 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  66 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  67 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  68 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  69 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  70 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
  73 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
  74 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  75 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-1ubuntu1
  $


  # git log --oneline -1
  eb7261f14e1a (HEAD -> perf/core, seventh/perf/core, five/perf/core, acme.korg/tmp.perf/core) perf test: Add free() calls for scandir() returned dirent entries
  # uname -a
  Linux quaco 5.12.5-200.fc33.x86_64 #1 SMP Wed May 19 18:06:33 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # perf -vv
  perf version 5.13.geb7261f14e1a
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
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
                 libpfm4: [ OFF ]  # HAVE_LIBPFM
  # perf test
   1: vmlinux symtab matches kallsyms                                 : Ok
   2: Detect openat syscall event                                     : Ok
   3: Detect openat syscall event on all cpus                         : Ok
   4: Read samples using the mmap interface                           : Ok
   5: Test data source output                                         : Ok
   6: Parse event definition strings                                  : Ok
   7: Simple expression parser                                        : Ok
   8: PERF_RECORD_* events & perf_sample fields                       : Ok
   9: Parse perf pmu format                                           : Ok
  10: PMU events                                                      :
  10.1: PMU event table sanity                                        : Ok
  10.2: PMU event map aliases                                         : Ok
  10.3: Parsing of PMU event table metrics                            : Ok
  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
  11: DSO data read                                                   : Ok
  12: DSO data cache                                                  : Ok
  13: DSO data reopen                                                 : Ok
  14: Roundtrip evsel->name                                           : Ok
  15: Parse sched tracepoints fields                                  : Ok
  16: syscalls:sys_enter_openat event fields                          : Ok
  17: Setup struct perf_event_attr                                    : Ok
  18: Match and link multiple hists                                   : Ok
  19: 'import perf' in python                                         : Ok
  20: Breakpoint overflow signal handler                              : Ok
  21: Breakpoint overflow sampling                                    : Ok
  22: Breakpoint accounting                                           : Ok
  23: Watchpoint                                                      :
  23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
  23.2: Write Only Watchpoint                                         : Ok
  23.3: Read / Write Watchpoint                                       : Ok
  23.4: Modify Watchpoint                                             : Ok
  24: Number of exit events of a simple workload                      : Ok
  25: Software clock events period values                             : Ok
  26: Object code reading                                             : Ok
  27: Sample parsing                                                  : Ok
  28: Use a dummy software event to keep tracking                     : Ok
  29: Parse with no sample_id_all bit set                             : Ok
  30: Filter hist entries                                             : Ok
  31: Lookup mmap thread                                              : Ok
  32: Share thread maps                                               : Ok
  33: Sort output of hist entries                                     : Ok
  34: Cumulate child hist entries                                     : Ok
  35: Track with sched_switch                                         : Ok
  36: Filter fds with revents mask in a fdarray                       : Ok
  37: Add fd to a fdarray, making it autogrow                         : Ok
  38: kmod_path__parse                                                : Ok
  39: Thread map                                                      : Ok
  40: LLVM search and compile                                         :
  40.1: Basic BPF llvm compile                                        : Ok
  40.2: kbuild searching                                              : Ok
  40.3: Compile source for BPF prologue generation                    : Ok
  40.4: Compile source for BPF relocation                             : Ok
  41: Session topology                                                : Ok
  42: BPF filter                                                      :
  42.1: Basic BPF filtering                                           : Ok
  42.2: BPF pinning                                                   : Ok
  42.3: BPF prologue generation                                       : Ok
  43: Synthesize thread map                                           : Ok
  44: Remove thread map                                               : Ok
  45: Synthesize cpu map                                              : Ok
  46: Synthesize stat config                                          : Ok
  47: Synthesize stat                                                 : Ok
  48: Synthesize stat round                                           : Ok
  49: Synthesize attr update                                          : Ok
  50: Event times                                                     : Ok
  51: Read backward ring buffer                                       : Ok
  52: Print cpu map                                                   : Ok
  53: Merge cpu map                                                   : Ok
  54: Probe SDT events                                                : Ok
  55: is_printable_array                                              : Ok
  56: Print bitmap                                                    : Ok
  57: perf hooks                                                      : Ok
  58: builtin clang support                                           : Skip (not compiled in)
  59: unit_number__scnprintf                                          : Ok
  60: mem2node                                                        : Ok
  61: time utils                                                      : Ok
  62: Test jit_write_elf                                              : Ok
  63: Test libpfm4 support                                            : Skip (not compiled in)
  64: Test api io                                                     : Ok
  65: maps__merge_in                                                  : Ok
  66: Demangle Java                                                   : Ok
  67: Demangle OCaml                                                  : Ok
  68: Parse and process metrics                                       : Ok
  69: PE file support                                                 : Ok
  70: Event expansion for cgroups                                     : Ok
  71: Convert perf time to TSC                                        : Ok
  72: x86 rdpmc                                                       : Ok
  73: DWARF unwind                                                    : Ok
  74: x86 instruction decoder - new instructions                      : Ok
  75: Intel PT packet decoder                                         : Ok
  76: x86 bp modify                                                   : Ok
  77: x86 Sample parsing                                              : Ok
  78: build id cache operations                                       : Ok
  79: daemon operations                                               : Ok
  80: Add vfs_getname probe to get syscall args filenames             : Ok
  81: probe libc's inet_pton & backtrace it with ping                 : Ok
  82: Use vfs_getname probe to get syscall args filenames             : Ok
  83: Zstd perf.data compression/decompression                        : Ok
  84: perf stat csv summary test                                      : Ok
  85: perf stat metrics (shadow stat) test                            : Ok
  86: perf stat --bpf-counters test                                   : Ok
  87: Check Arm CoreSight trace data recording and synthesized samples: Skip
  88: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ git log -1 --oneline
  eb7261f14e1a86f0 (HEAD -> perf/core) perf test: Add free() calls for scandir() returned dirent entries
  $ make -C tools/perf build-test
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.yETPwiHKAD
  make[1]: 'make_with_gtk2' is up to date.
                make_no_gtk2_O: make NO_GTK2=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
           make_with_libpfm4_O: make LIBPFM4=1
                make_no_newt_O: make NO_NEWT=1
               make_no_slang_O: make NO_SLANG=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
            make_no_demangle_O: make NO_DEMANGLE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
              make_clean_all_O: make clean all
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_tags_O: make tags
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_help_O: make help
         make_with_coresight_O: make CORESIGHT=1
              make_no_libbpf_O: make NO_LIBBPF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_install_O: make install
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_debug_O: make DEBUG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                    make_doc_O: make doc
                 make_no_sdt_O: make NO_SDT=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                 make_perf_o_O: make perf.o
             make_no_libperl_O: make NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
            make_install_bin_O: make install-bin
                   make_pure_O: make
         make_with_clangllvm_O: make LIBCLANGLLVM=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  $
