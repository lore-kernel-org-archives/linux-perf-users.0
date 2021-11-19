Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34801C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 13:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137FB61A89
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Nov 2021 13:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhKSNj0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:41350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229457AbhKSNjZ (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Nov 2021 08:39:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D25461A86;
        Fri, 19 Nov 2021 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637328984;
        bh=Zn915+lUOK3fArS3wAlNUdrwgJ2asXIDcOEprEx/SGc=;
        h=From:To:Cc:Subject:Date:From;
        b=J7xwxaTpVzoDb4YkUIt8FgIPHJzMJsM6J89v5d1bCuGBoOHGj51ZwvLJ1kKzl9Foi
         Xw7DfzJqW4XYbiNh5ml3UFiaGpUtDzouTNDONZ8zfyS8SGbK6OLR8NjxjRUEsspxrD
         djD/L601KZaeDSV++kgzqbflDpzlW9ulX1S+ZvHiXvIP19neiKSfBnEPaZks85iTKV
         mMxdQ0u1CDTUyJOadTon0xX8PIjCQrsHmapkh4eOeNpHkr9fjw8fJF05tiwQYFZF0b
         HTevHYdydkbV7Qc+XVEUvks0t3f+/ZlTSu8JAYSgcolP1QPVIxXhz21eCKDvAHPbw1
         1HJiUHXmHAs0g==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        German Gomez <german.gomez@arm.com>,
        Ian Rogers <irogers@google.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.16: 1st batch
Date:   Fri, 19 Nov 2021 10:36:15 -0300
Message-Id: <20211119133615.31727-1-acme@kernel.org>
X-Mailer: git-send-email 2.33.1
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

Tests at the end of this message.

The following changes since commit 42eb8fdac2fc5d62392dcfcf0253753e821a97b0:

  Merge tag 'gfs2-v5.16-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-11-17 15:55:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.16-2021-11-19

for you to fetch changes up to b194c9cd09dd98af76beaa32a041af674260d730:

  perf evsel: Fix memory leaks relating to unit (2021-11-18 10:19:14 -0300)

----------------------------------------------------------------
perf tools fixes for 5.16: 1st batch

- Fix the 'local_weight', 'weight' (memory access latency), 'local_ins_lat',
  'ins_lat' (instruction latency) and 'pstage_cyc' (pipeline stage cycles) sort
  key sample aggregation.

- Fix 'perf test' entry for watchpoints on s/390.

- Fix branch_stack entry endianness check in the 'perf test' sample parsing test.

- Fix ARM SPE handling on 'perf inject'.

- Fix memory leaks detected with ASan.

- Fix build on arm64 related to reallocarray() availability.

- Sync copies of kernel headers: cpufeatures, kvm, MIPS syscalltable (futex_waitv).

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (7):
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      perf tests wp: Remove unused functions on s390
      perf tools: Set COMPAT_NEED_REALLOCARRAY for CONFIG_AUXTRACE=1
      tools headers UAPI: Sync x86's asm/kvm.h with the kernel sources
      tools build: Fix removal of feature-sync-compare-and-swap feature detection
      tools headers UAPI: Sync MIPS syscall table file changed by new futex_waitv syscall

German Gomez (1):
      perf inject: Fix ARM SPE handling

Ian Rogers (3):
      perf hist: Fix memory leak of a perf_hpp_fmt
      perf report: Fix memory leaks around perf_tip()
      perf evsel: Fix memory leaks relating to unit

Namhyung Kim (3):
      perf sort: Fix the 'weight' sort key behavior
      perf sort: Fix the 'ins_lat' sort key behavior
      perf sort: Fix the 'p_stage_cyc' sort key behavior

Sohaib Mohamed (1):
      perf bench: Fix two memory leaks detected with ASan

Thomas Richter (1):
      perf test sample-parsing: Fix branch_stack entry endianness check

 tools/arch/x86/include/asm/cpufeatures.h           |  2 +
 tools/arch/x86/include/uapi/asm/kvm.h              |  4 ++
 tools/build/feature/test-all.c                     |  1 -
 tools/include/uapi/linux/kvm.h                     | 30 +++++++++++--
 tools/perf/Makefile.config                         |  3 ++
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  |  1 +
 tools/perf/bench/sched-messaging.c                 |  4 ++
 tools/perf/builtin-report.c                        | 15 ++++---
 tools/perf/tests/event_update.c                    |  5 +--
 tools/perf/tests/sample-parsing.c                  |  2 +-
 tools/perf/tests/wp.c                              |  2 +-
 tools/perf/ui/hist.c                               | 28 ++++++------
 tools/perf/util/arm-spe.c                          | 15 +++++++
 tools/perf/util/evsel.c                            | 18 ++++----
 tools/perf/util/header.c                           |  8 ++--
 tools/perf/util/hist.c                             | 23 +++-------
 tools/perf/util/hist.h                             |  1 -
 tools/perf/util/parse-events.c                     |  9 ++--
 tools/perf/util/sort.c                             | 52 +++++++---------------
 tools/perf/util/sort.h                             |  6 +--
 tools/perf/util/util.c                             | 14 +++---
 tools/perf/util/util.h                             |  2 +-
 22 files changed, 136 insertions(+), 109 deletions(-)

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

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

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:cooker, where on the feature build
test it doesn't manage to find libpthread, looks like a distro problem, will keep
it there to see if a refreshed container cures this soon. This has been the case
for quite a while, probably time to drop building for those distros?

Ubuntu 20.04 is failing on a corner case where perf links with libllvm and libclang,
which isn't the default perf build.

Ubuntu 21.10 is failing with the newly added BUILD_BPF_SKEL=1, where clang is used
to generate BPF bytecode, this is being done with other flagship distro versions
and working, except on this case, to be investigated.

The gentoo container needs some more work to be able to use clang, some more PATH
setup is needed. It builds ok for the default case, that doesn't enable BUILD_BPF_SKEL=1.

'perf test 91' is sometimes failing, this doesn't look related to the patches
in this series and is being investigated:

  https://lore.kernel.org/all/YZeYX305gA0ut9N8@kernel.org/

  $ grep -m1 'model name' /proc/cpuinfo 
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  # export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.16.0-rc1.tar.xz
  # dm 
     1    97.01 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.5.0+2598+6a7729ff)
     2    55.78 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
     3    54.49 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
     4    58.10 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
     5    63.43 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     6    64.32 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     7    65.43 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     8    88.68 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     9   101.81 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
    10    96.30 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
    11   104.42 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
    12    89.08 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
    13    90.39 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210921) 10.3.1 20210921 , Alpine clang version 12.0.1
    14    51.46 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    15    66.01 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    16    63.60 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
    17    52.56 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    18    74.83 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    19    81.56 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
    20    95.11 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
    21    49.20 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211111 releases/gcc-11.2.0-432-g7b6b46b648 , clang version 11.1.0
    22    65.02 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    23    60.60 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    24    73.03 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    25    59.69 debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang version 11.1.0-4
    26    23.97 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    27    19.45 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    28    21.35 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    29    21.95 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
    30    22.05 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    31    55.68 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    32    66.39 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    33    17.74 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    34    67.71 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    35    78.04 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    36    79.94 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    37    90.98 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    38    96.89 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    39   101.29 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    40    98.90 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    41    84.66 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    42    82.25 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    43    97.51 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    44    19.75 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    45    17.64 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    46    88.09 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    47    87.18 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211019 (Red Hat 11.2.1-6) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
    48    34.99 gentoo-stage3:latest          : FAIL clang version 13.0.0

        CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
      /bin/sh: line 2: llvm-strip: command not found
      /bin/sh: line 2: llvm-strip: command not found
      make[2]: *** [Makefile.perf:1072: /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o] Error 127
      make[2]: *** Waiting for unfinished jobs....
      make[2]: *** [Makefile.perf:1072: /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o] Error 127
      /bin/sh: line 2: llvm-strip: command not found
      make[2]: *** [Makefile.perf:1072: /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o] Error 127
      /bin/sh: line 2: llvm-strip: command not found
      make[2]: *** [Makefile.perf:1072: /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o] Error 127
      make[1]: *** [Makefile.perf:240: sub-make] Error 2
      make: *** [Makefile:70: all] Error 2
      make: Leaving directory '/git/perf-5.16.0-rc1/tools/perf'
  
    49    68.92 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    50    38.41 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.16.0-rc1/tools/build/Makefile.build:139: util] Error 2
    51     6.28 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
      In file included from builtin-bench.c:22:
      bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
         66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
            |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      In file included from bench/bench.h:64,
                       from builtin-bench.c:22:
      /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
        394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
            |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
      file: Compiled magic version [540] does not match with shared library magic version [539]
      
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
      file: Compiled magic version [540] does not match with shared library magic version [539]
      
      file: Compiled magic version [540] does not match with shared library magic version [539]
      
      ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
      ld: warning: -r and --icf may not be used together, disabling --icf
    52   102.28 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    53   109.41 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    54   101.38 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    55    95.38 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    56    98.68 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] , clang version 13.0.0
    57    80.75 oraclelinux:8                 : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1.0.4) , clang version 11.0.1 (Red Hat 11.0.1-1.0.1.module+el8.4.0+20397+f876858a)
    58    81.45 rockylinux:8                  : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module+el8.4.0+666+3effbf14)
    59    69.72 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    60    18.85 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    61    18.95 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    62    18.54 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    63    18.84 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    64    18.94 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    65    18.74 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    66    74.81 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    67    20.36 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    68    20.35 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    69    16.54 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    70    19.85 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    71    21.26 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    72    21.46 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    97.69 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    74    18.35 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75    19.24 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76    18.34 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    77    62.99 ubuntu:20.04                  : FAIL clang version 10.0.0-4ubuntu1 

      + make ARCH= CROSS_COMPILE= EXTRA_CFLAGS= LIBCLANGLLVM=1 -C tools/perf O=/tmp/build/perf CC=clang
      
      /usr/bin/ld: /usr/lib/llvm-10/lib/libclangCodeGen.a(BackendUtil.cpp.o): in function `(anonymous namespace)::EmitAssemblyHelper::EmitAssemblyWithNewPassManager(clang::BackendAction, std::unique_ptr<llvm::raw_pwrite_stream, std::default_delete<llvm::raw_pwrite_stream> >)':
      (.text._ZN12_GLOBAL__N_118EmitAssemblyHelper30EmitAssemblyWithNewPassManagerEN5clang13BackendActionESt10unique_ptrIN4llvm17raw_pwrite_streamESt14default_deleteIS5_EE+0x1f15): undefined reference to `getPollyPluginInfo()'
      clang: error: linker command failed with exit code 1 (use -v to see invocation)
      make[2]: *** [Makefile.perf:677: /tmp/build/perf/perf] Error 1
      make[1]: *** [Makefile.perf:240: sub-make] Error 2
      make: *** [Makefile:70: all] Error 2
      make: Leaving directory '/git/perf-5.16.0-rc1/tools/perf'

    78    22.07 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    79    72.42 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    80    73.23 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
    81    24.97 ubuntu:21.10                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-7ubuntu2) 
      :
      /usr/include/linux/types.h/usr/include/linux/types.h:/usr/include/linux/types.h:5:5:5:10:10:10: :  fatal error: fatal error: fatal error: 'asm/types.h' file not found'asm/types.h' file not found'asm/types.h' file not found
      
      
      #include <asm/types.h>#include <asm/types.h>#include <asm/types.h>
      
      
               ^~~~~~~~~~~~~         ^~~~~~~~~~~~~         ^~~~~~~~~~~~~
      
      
      1 error generated.
      1 error generated.
      1 error generated.
  real	81m25.531s
  user	2m4.266s
  sys	0m46.837s
  $

  $ git log --oneline -1
  b194c9cd09dd98af (HEAD -> perf/urgent, seventh/perf/urgent, quaco/perf/urgent, acme/tmp.perf/urgent, acme/perf/urgent) perf evsel: Fix memory leaks relating to unit
  $ time make -C tools/perf build-test
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32
                make_with_gtk2: make GTK2=1 -j32
               make_no_slang_O: make NO_SLANG=1
         make_install_prefix_O: make install prefix=/tmp/krava
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_install_bin_O: make install-bin
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_pure_O: make
                 make_perf_o_O: make perf.o
                make_no_gtk2_O: make NO_GTK2=1
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
            make_no_demangle_O: make NO_DEMANGLE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libpython_O: make NO_LIBPYTHON=1
                make_install_O: make install
                   make_tags_O: make tags
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                    make_doc_O: make doc
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_util_map_o_O: make util/map.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                 make_no_sdt_O: make NO_SDT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
              make_no_libbpf_O: make NO_LIBBPF=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_help_O: make help
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
           make_with_libpfm4_O: make LIBPFM4=1
              make_clean_all_O: make clean all
                  make_debug_O: make DEBUG=1
              make_no_libelf_O: make NO_LIBELF=1
         make_with_coresight_O: make CORESIGHT=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	4m26.978s
  user	55m30.650s
  sys	11m58.936s
  $ 

  $ uname -a
  Linux quaco 5.14.17-301.fc35.x86_64 #1 SMP Mon Nov 8 13:57:43 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  b194c9cd09dd98af (HEAD -> perf/urgent, seventh/perf/urgent, five/perf/urgent, acme/tmp.perf/urgent, acme/perf/urgent, acme.korg/tmp.perf/urgent, acme.korg/perf/urgent) perf evsel: Fix memory leaks relating to unit
  $ perf -v
  perf version 5.16.rc1.gb194c9cd09dd
  $ sudo su -
  # perf -vv
  perf version 5.16.rc1.gb194c9cd09dd
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
  58: builtin clang support                                           :
  58.1: builtin clang compile C source to IR                          : Skip (not compiled in)
  58.2: builtin clang compile C source to ELF object                  : Skip (not compiled in)
  59: unit_number__scnprintf                                          : Ok
  60: mem2node                                                        : Ok
  61: time utils                                                      : Ok
  62: Test jit_write_elf                                              : Ok
  63: Test libpfm4 support                                            :
  63.1: test of individual --pfm-events                               : Skip (not compiled in)
  63.2: test groups of --pfm-events                                   : Skip (not compiled in)
  64: Test api io                                                     : Ok
  65: maps__merge_in                                                  : Ok
  66: Demangle Java                                                   : Ok
  67: Demangle OCaml                                                  : Ok
  68: Parse and process metrics                                       : Ok
  69: PE file support                                                 : Ok
  70: Event expansion for cgroups                                     : Ok
  71: Convert perf time to TSC                                        : Ok
  72: dlfilter C API                                                  : Ok
  73: x86 rdpmc                                                       : Ok
  74: Test dwarf unwind                                               : Ok
  75: x86 instruction decoder - new instructions                      : Ok
  76: Intel PT packet decoder                                         : Ok
  77: x86 bp modify                                                   : Ok
  78: x86 Sample parsing                                              : Ok
  79: build id cache operations                                       : Ok
  80: daemon operations                                               : Ok
  81: perf pipe recording and injection test                          : Ok
  82: Add vfs_getname probe to get syscall args filenames             : Ok
  83: probe libc's inet_pton & backtrace it with ping                 : Ok
  84: Use vfs_getname probe to get syscall args filenames             : Ok
  85: Zstd perf.data compression/decompression                        : Ok
  86: perf stat csv summary test                                      : Ok
  87: perf stat metrics (shadow stat) test                            : Ok
  88: perf all metricgroups test                                      : FAILED!
  89: perf all metrics test                                           : Ok
  90: perf all PMU test                                               : Ok
  91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
  92: Check Arm CoreSight trace data recording and synthesized samples: Skip
  93: Check Arm SPE trace data recording and synthesized samples      : Skip
  94: Check open filename arg using perf trace + vfs_getname          : Ok
  #
  # perf test 91
  91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
  # perf test 91
  91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRR FAILED!
  # perf test 91
  91: perf stat --bpf-counters test                                   :RRRRRRRRRRRR FAILED!
  # perf test 91
  91: perf stat --bpf-counters test                                   :RRRRRRRRRRRRRRRRRR Ok
  
