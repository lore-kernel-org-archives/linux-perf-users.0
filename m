Return-Path: <SRS0=IjAq=IF=vger.kernel.org=linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F15EC433DB
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Mar 2021 12:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DF9365100
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Mar 2021 12:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbhCGM5k (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Mar 2021 07:57:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:49448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCGM5R (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Mar 2021 07:57:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8C0F1650FD;
        Sun,  7 Mar 2021 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615121837;
        bh=Iq7k36PRDKyMFZpppcnNv7D5zyPZW6ZyYhlA5/wGdlw=;
        h=From:To:Cc:Subject:Date:From;
        b=MyexBV/8NpOaw5vnIsSQtdVoybWqOge4Yi42Ofw1Ox0IaR+i2x9ej27ZU88vrOVvQ
         CnhADGv6BUXnybk11re21ihf2Pyc/iFCJV3W6Q0W3xIrRfrfo5H52rAJ6YQtsyXfA4
         VZ2kTg+3+SBCXBhz3B8ob07yShU4EzsH5UUpww2Aq/aTl/kunpgtDg8CF525GAyiDD
         1GK+Tu/vuV0V8uJ6fGDA8x7zfPo9J2gnfroVBhE15hWF2iQL4AobNmCd34j84610Of
         Gnhnda+MLLxiorbH3mZhKrOUyo528MxBDFpF5oOgRK78Qt1XfSKJlr6MoiFbY9ssNL
         /ZrY9NHMoBNUA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andreas Wendleder <andreas.wendleder@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        Pierre Gondois <Pierre.Gondois@arm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ying Huang <ying.huang@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.12: take 2
Date:   Sun,  7 Mar 2021 09:56:54 -0300
Message-Id: <20210307125654.3782021-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling, rebased over v5.12-rc2,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit a38fd8748464831584a19438cbb3082b5a2dab15:

  Linux 5.12-rc2 (2021-03-05 17:33:41 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.12-2020-03-07

for you to fetch changes up to 6fc5baf5471700fd613f0b4e52ab4563f1942b78:

  perf cs-etm: Fix bitmap for option (2021-03-06 16:54:33 -0300)

----------------------------------------------------------------
perf tools fixes for v5.12:

- Fix wrong skipping for per-die aggregation in 'perf stat'.

- Fix race in signal handling on large core count machines, setting up signal
  handlers earlier.

- Fix -F for branch & mem modes in 'perf report'.

- Fix the condition checks for max number of NUMA nodes in 'perf bench numa'.

- Fix crash in 'perf diff' error path.

- Fix filtering of empty build-ids in 'perf archive'.

- Ensure read cmdlines from libtraceevent are null terminated.

Recent regressions:

- Fix control fifo permissions in 'perf daemon'.

- Fix 'perf daemon' compile error with ASAN.

- Fix running 'perf daemon' test for non root user.

- Fix PERF_SAMPLE_WEIGHT_STRUCT 'perf test' failure on non-x86 arches.

- Fix event's PMU name parsing related to new drm/i915/gt
  software-gt-awake-time event.

Fixes from compiler instrumentation:

- Fix leaks in 'perf test' entries, found using ASAN.

- Fix use-after-free when 'perf stat -r' option is used.

Arch specific:

- Fix bitmap for option om ARM's CS-ETM.

Documentation:

- Fix documentation of verbose options.

Build:

- Clean 'generated' directory used for creating the syscall table on x86.

- Fix ccache usage in $(CC) when generating arch errno table.

- Cast (struct timeval).tv_sec when printing, fixing the build with MUSL libc.

- Tighten snprintf() string precision to pass gcc check on some 32-bit arches.

- Update UAPI copies from the kernel sources.

- Fix regression on feature detection 'make clean' target.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andreas Wendleder (1):
      perf tools: Clean 'generated' directory used for creating the syscall table on x86

Antonio Terceiro (1):
      perf build: Fix ccache usage in $(CC) when generating arch errno table

Arnaldo Carvalho de Melo (12):
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync openat2.h with the kernel sources
      perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
      tools headers UAPI s390: Sync ptrace.h kernel headers
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      tools headers: Update syscall.tbl files to support mount_setattr
      tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync KVM's kvm.h and vmx.h headers with the kernel sources
      perf tests x86: Move insn.h include to make sure it finds stddef.h
      perf map: Tighten snprintf() string precision to pass gcc check on some 32-bit arches

Athira Rajeev (1):
      perf bench numa: Fix the condition checks for max number of NUMA nodes

Dmitry Safonov (1):
      perf diff: Don't crash on freeing errno-session on the error path

Ian Rogers (2):
      perf traceevent: Ensure read cmdlines are null terminated.
      perf tools: Fix documentation of verbose options

Jin Yao (1):
      perf stat: Fix wrong skipping for per-die aggregation

Jiri Olsa (4):
      perf build: Move feature cleanup under tools/build
      perf daemon: Fix control fifo permissions
      perf daemon: Fix running test for non root user
      perf tools: Fix event's PMU name parsing

Kan Liang (2):
      perf test: Fix sample-parsing failure on non-x86 platforms
      perf test: Support the ins_lat check in the X86 specific test

Michael Petlan (1):
      perf trace: Fix race in signal handling

Namhyung Kim (14):
      perf test: Fix cpu and thread map leaks in basic mmap test
      perf test: Fix a memory leak in attr test
      perf test: Fix cpu and thread map leaks in task_exit test
      perf test: Fix cpu and thread map leaks in sw_clock_freq test
      perf test: Fix cpu and thread map leaks in code_reading test
      perf test: Fix cpu and thread map leaks in keep_tracking test
      perf test: Fix cpu and thread map leaks in switch_tracking test
      perf test: Fix a thread map leak in thread_map_synthesize test
      perf test: Fix a memory leak in thread_map_remove test
      perf test: Fix cpu map leaks in cpu_map_print test
      perf test: Fix cpu and thread map leaks in perf_time_to_tsc test
      libperf: Add perf_evlist__reset_id_hash()
      perf stat: Fix use-after-free when -r option is used
      perf daemon: Fix compile error with Asan

Nicholas Fraser (1):
      perf archive: Fix filtering of empty build-ids

Pierre Gondois (1):
      perf tools: Cast (struct timeval).tv_sec when printing

Ravi Bangoria (1):
      perf report: Fix -F for branch & mem modes

Suzuki K Poulose (1):
      perf cs-etm: Fix bitmap for option

 tools/arch/s390/include/uapi/asm/ptrace.h          |   5 +-
 tools/arch/x86/include/asm/cpufeatures.h           |  19 +++-
 tools/arch/x86/include/uapi/asm/kvm.h              |   1 +
 tools/arch/x86/include/uapi/asm/vmx.h              |   4 +-
 tools/build/Makefile                               |   8 +-
 tools/include/linux/coresight-pmu.h                |  20 +++-
 tools/include/uapi/drm/drm.h                       |  97 +++++++++--------
 tools/include/uapi/drm/i915_drm.h                  |   3 +-
 tools/include/uapi/linux/kvm.h                     |  73 +++++++++++++
 tools/include/uapi/linux/mount.h                   |  16 +++
 tools/include/uapi/linux/openat2.h                 |   4 +
 tools/lib/perf/evlist.c                            |  13 ++-
 tools/lib/perf/include/internal/evlist.h           |   2 +
 tools/perf/Documentation/perf-evlist.txt           |   2 +-
 tools/perf/Documentation/perf-ftrace.txt           |   4 +-
 tools/perf/Documentation/perf-kallsyms.txt         |   2 +-
 tools/perf/Documentation/perf-trace.txt            |   4 +-
 tools/perf/Makefile.perf                           |  12 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  12 +-
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl |  21 +---
 tools/perf/arch/s390/entry/syscalls/syscall.tbl    |   1 +
 tools/perf/arch/x86/Makefile                       |  11 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/x86/include/arch-tests.h           |   1 +
 tools/perf/arch/x86/tests/Build                    |   1 +
 tools/perf/arch/x86/tests/arch-tests.c             |   4 +
 tools/perf/arch/x86/tests/insn-x86.c               |   2 +-
 tools/perf/arch/x86/tests/sample-parsing.c         | 121 +++++++++++++++++++++
 tools/perf/arch/x86/util/archinsn.c                |   2 +-
 tools/perf/bench/numa.c                            |  42 ++++---
 tools/perf/bench/sched-messaging.c                 |   4 +-
 tools/perf/bench/sched-pipe.c                      |   4 +-
 tools/perf/bench/syscall.c                         |   4 +-
 tools/perf/builtin-daemon.c                        |   6 +-
 tools/perf/builtin-diff.c                          |   3 +-
 tools/perf/builtin-trace.c                         |   5 +-
 tools/perf/perf-archive.sh                         |   3 +-
 tools/perf/tests/attr.c                            |   8 +-
 tools/perf/tests/code-reading.c                    |  10 +-
 tools/perf/tests/cpumap.c                          |   2 +
 tools/perf/tests/keep-tracking.c                   |   5 +-
 tools/perf/tests/mmap-basic.c                      |   2 -
 tools/perf/tests/perf-time-to-tsc.c                |   2 +
 tools/perf/tests/sample-parsing.c                  |   4 -
 tools/perf/tests/shell/daemon.sh                   |  32 +++---
 tools/perf/tests/sw-clock.c                        |  12 +-
 tools/perf/tests/switch-tracking.c                 |   5 +-
 tools/perf/tests/task-exit.c                       |  10 +-
 tools/perf/tests/thread-map.c                      |   8 +-
 tools/perf/util/evlist.c                           |   1 +
 tools/perf/util/evsel.c                            |  18 ++-
 tools/perf/util/evsel.h                            |   4 +-
 tools/perf/util/header.c                           |   4 +-
 tools/perf/util/map.c                              |   7 +-
 tools/perf/util/parse-events.y                     |   6 +-
 tools/perf/util/python-ext-sources                 |   1 +
 tools/perf/util/sort.c                             |   4 +-
 tools/perf/util/stat-display.c                     |   2 +-
 tools/perf/util/stat.c                             |  47 ++++++--
 tools/perf/util/trace-event-read.c                 |   1 +
 60 files changed, 517 insertions(+), 215 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/sample-parsing.c
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

  $ grep "model name" -m1 /proc/cpuinfo 
  model name: AMD Ryzen 9 3900X 12-Core Processor
  $ dm
   1    80.82 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   2    78.88 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   3    83.59 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   4    91.39 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5    90.46 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6    98.96 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7   133.23 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8   144.00 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9   130.48 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10   137.33 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  11   154.14 alpine:edge                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12    80.19 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  13    97.04 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  14    96.18 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20201125 (ALT Sisyphus 10.2.1-alt2) , clang version 10.0.1 
  15    76.63 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  16   120.76 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12) , clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  17    26.53 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  18    24.71 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  19    29.09 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23) 
  20    35.32 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44) 
  21   113.01 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  22    70.48 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc , clang version 10.0.1 
  23    91.04 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  24    95.05 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  25    88.33 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  26    91.40 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  27    37.71 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  28    30.44 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  29    32.63 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  30    37.01 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  31    34.06 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7) 
  32    34.38 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  33    82.01 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  34    99.62 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  35    28.37 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  36   102.21 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  37   112.81 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  38   119.78 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  39   130.95 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  40   138.36 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  41   142.39 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  42    28.28 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  43   139.28 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  44   115.04 fedora:32                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  45   114.30 fedora:33                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
  46   120.27 fedora:34                     : Ok   gcc (GCC) 11.0.0 20210225 (Red Hat 11.0.0-0) , clang version 12.0.0 (Fedora 12.0.0-0.1.rc1.fc34)
  47   122.32 fedora:rawhide                : Ok   gcc (GCC) 11.0.0 20210210 (Red Hat 11.0.0-0) , clang version 12.0.0 (Fedora 12.0.0-0.1.rc1.fc35)
  48    39.06 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.3.0-r1 p3) 9.3.0 
  49    81.19 mageia:5                      : Ok   gcc (GCC) 4.9.2 , clang version 3.5.2 (tags/RELEASE_352/final)
  50   100.26 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  51   121.17 manjaro:latest                : Ok   gcc (GCC) 10.2.0 , clang version 10.0.1 
  52   278.89 openmandriva:cooker           : Ok   gcc (GCC) 10.2.0 20200723 (OpenMandriva) , OpenMandriva 11.0.0-1 clang version 11.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-11.0.0/clang 63e22714ac938c6b537bd958f70680d3331a2030)
  53   138.08 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  54   147.41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55   136.04 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  56   151.21 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  57   141.37 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5 , clang version 3.8.0 (tags/RELEASE_380/final 262553)
  58   125.81 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f55b3d993b32e5c] , clang version 10.0.1 
  59    28.93 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1) 
  60    35.94 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44.0.3) 
  61   113.10 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.1) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  62    30.38 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3 , Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  63    33.70 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4 
  64   100.52 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  65    29.19 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    28.94 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    29.16 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  68    29.33 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    29.45 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    31.77 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71   104.72 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  72    31.37 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    30.25 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    25.31 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    31.27 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    32.32 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    32.01 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78   170.01 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    27.30 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    29.10 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81    29.04 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    81.40 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008 , clang version 8.0.1-3build1 (tags/RELEASE_801/final)
  83    31.94 ubuntu:19.10-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008 
  84    26.67 ubuntu:19.10-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008 
  85    85.39 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
  86    33.99 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
  87    85.60 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  88    80.34 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.2.1-6ubuntu1) 10.2.1 20210110 , Ubuntu clang version 11.0.1-2

  # uname -a
  Linux quaco 5.10.7-100.fc32.x86_64 #1 SMP Tue Jan 12 20:25:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  6fc5baf54717 perf cs-etm: Fix bitmap for option
  # perf version --build-options
  perf version 5.12.rc2.g6fc5baf54717
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
  24: Number of exit events of a simple workload                      : FAILED!
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
  42.4: BPF relocation checker                                        : Ok
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
  78: probe libc's inet_pton & backtrace it with ping                 : Ok
  79: Use vfs_getname probe to get syscall args filenames             : Ok
  80: Check Arm CoreSight trace data recording and synthesized samples: Skip
  81: perf stat metrics (shadow stat) test                            : Ok
  82: build id cache operations                                       : Ok
  83: daemon operations                                               : Ok
  84: Add vfs_getname probe to get syscall args filenames             : Ok
  85: Check open filename arg using perf trace + vfs_getname          : Ok
  86: Zstd perf.data compression/decompression                        : Ok
  #

  $ git log --oneline -1
  6fc5baf5471700fd (HEAD -> perf/urgent, tag: perf-tools-fixes-for-v5.12-2020-03-07, five/perf/urgent, five/new-perf-urgent, acme.korg/tmp.perf/urgent, acme.korg/perf/urgent) perf cs-etm: Fix bitmap for option
  $ time make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
           make_with_libpfm4_O: make LIBPFM4=1
              make_clean_all_O: make clean all
              make_with_gtk2_O: make GTK2=1
                make_no_newt_O: make NO_NEWT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_tags_O: make tags
           make_no_backtrace_O: make NO_BACKTRACE=1
                  make_debug_O: make DEBUG=1
            make_install_bin_O: make install-bin
           make_no_libpython_O: make NO_LIBPYTHON=1
                 make_cscope_O: make cscope
               make_no_slang_O: make NO_SLANG=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_gtk2_O: make NO_GTK2=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
                   make_pure_O: make
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_no_demangle_O: make NO_DEMANGLE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_install_O: make install
                 make_perf_o_O: make perf.o
             make_util_map_o_O: make util/map.o
           make_no_libbionic_O: make NO_LIBBIONIC=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                    make_doc_O: make doc
                   make_help_O: make help
              make_no_libelf_O: make NO_LIBELF=1
                 make_no_sdt_O: make NO_SDT=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libperl_O: make NO_LIBPERL=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
