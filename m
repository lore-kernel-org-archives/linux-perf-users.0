Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8873AC4743C
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 19:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A84613F8
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 19:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhFDUAZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 16:00:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:48516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229982AbhFDUAY (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 16:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5501A613AD;
        Fri,  4 Jun 2021 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622836718;
        bh=F7uDRHB3+rR21J7VRL0d2qzaYZ+acKyNoZb8zrqMFuw=;
        h=From:To:Cc:Subject:Date:From;
        b=Xj9U8zpmc8oVDrmb4JE5HZhjGMKxrqBsd3OYFPunuz09yPcYHy1PZoFRSmaRAQdhc
         X9QZ7t6bKiJ5anYMRGDypkY0O7Qs268Pr8eutu60amb+mSWORrnuLKguh+4Xu040Sb
         GmL/uC4RdzqiXm9PVH+R/956nthPzPOovf+KM6pj0SxmcjvK4s20uV0T9kXZ2YfUYp
         geSDDg0wLHq9MDofgoNIr9cM3GZuE+ppPEA5R0VKf5U2AtBco1rSst02QQNJOG5whe
         kIl3HxzZq3rnTWzTYLv9GXGX2Aqyiak5xyeVd/syrtCS+A8wB8HcOrd9k0lvJC+6eM
         /Znq0YgWUYzLg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Li Huafei <lihuafei1@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Yu Kuai <yukuai3@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools fixes for v5.13: 4th batch
Date:   Fri,  4 Jun 2021 16:58:27 -0300
Message-Id: <20210604195827.517650-1-acme@kernel.org>
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

The following changes since commit c2131f7e73c9e9365613e323d65c7b9e5b910f56:

  Merge tag 'gfs2-v5.13-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2 (2021-05-31 05:57:22 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-fixes-for-v5.13-2021-06-04

for you to fetch changes up to 67069a1f0fe5f9eeca86d954fff2087f5542a008:

  perf env: Fix memory leak of bpf_prog_info_linear member (2021-06-04 10:26:20 -0300)

----------------------------------------------------------------
perf tools fixes for v5.13: 4th batch

- Fix NULL pointer dereference in 'perf probe' when handling
  DW_AT_const_value when looking for a variable, which is valid.

- Fix for capability querying of perf_event_attr.cgroup support in older
  kernels.

- Add missing cloning of evsel->use_config_name.

- Honor event config name on --no-merge in 'perf stat'.

- Fix some memory leaks found using ASAN.

- Fix the perf entry for perf_event_attr setup with make LIBPFM4=1 on
  s390 z/VM.

- Update MIPS UAPI perf_regs.h file.

- Fix 'perf stat' BPF counter load return check.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Li Huafei (1):
      perf probe: Fix NULL pointer dereference in convert_variable_location()

Namhyung Kim (3):
      perf record: Move probing cgroup sampling support
      perf evsel: Add missing cloning of evsel->use_config_name
      perf stat: Honor event config name on --no-merge

Riccardo Mancini (2):
      perf symbol-elf: Fix memory leak by freeing sdt_note.args
      perf env: Fix memory leak of bpf_prog_info_linear member

Thomas Richter (1):
      perf test: Test 17 fails with make LIBPFM4=1 on s390 z/VM

Tiezhu Yang (1):
      perf tools: Copy uapi/asm/perf_regs.h from the kernel for MIPS

Yu Kuai (1):
      perf stat: Fix error return code in bperf__load()

 tools/arch/mips/include/uapi/asm/perf_regs.h | 40 ++++++++++++++++++++++++++++
 tools/perf/Makefile.config                   |  1 -
 tools/perf/builtin-record.c                  |  6 +++++
 tools/perf/check-headers.sh                  |  1 +
 tools/perf/tests/attr/base-record            |  2 +-
 tools/perf/util/bpf_counter.c                |  6 +++--
 tools/perf/util/dwarf-aux.c                  |  8 ++++--
 tools/perf/util/env.c                        |  1 +
 tools/perf/util/evsel.c                      |  1 +
 tools/perf/util/evsel.h                      |  4 +--
 tools/perf/util/perf_api_probe.c             | 10 +++++++
 tools/perf/util/perf_api_probe.h             |  1 +
 tools/perf/util/probe-finder.c               |  3 +++
 tools/perf/util/stat-display.c               |  8 +++---
 tools/perf/util/symbol-elf.c                 |  1 +
 15 files changed, 80 insertions(+), 13 deletions(-)
 create mode 100644 tools/arch/mips/include/uapi/asm/perf_regs.h

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

There is a new failure, in the mageia:7 distro + clang 8, seemingly unrelated to the
patches in this series, it'll be investigated. It builds just fine with gcc 8.4.

  $ grep -m1 "^model name" /proc/cpuinfo 
  model name	: AMD Ryzen 9 3900X 12-Core Processor
  # export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0-rc4.tar.xz
  # dm 
     1    90.47 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
     2    66.12 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
     3    65.65 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
     4    70.94 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
     5    80.93 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     6    91.38 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     7    83.37 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     8   110.31 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     9   128.02 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
    10   123.81 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
    11   175.90 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
    12   166.89 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
    13    63.18 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    14    80.40 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    15    79.85 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
    16    59.41 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    17    83.81 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    18   124.03 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
    19    60.13 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.1.1 20210526 releases/gcc-11.1.0-176-g74c9a1e158 , clang version 11.1.0
    20    80.50 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
    21    79.34 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    22   174.06 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    23   228.18 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    24    32.04 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    25    24.09 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    26    27.85 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    27    85.45 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    28   126.30 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    29   289.45 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    30    84.90 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    31    21.12 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    32    86.52 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    33    93.79 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    34    93.17 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    35   109.31 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    36   112.89 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    37   116.05 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    38   114.81 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    39    93.59 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    40    91.25 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
    41    96.10 fedora:34                     : Ok   gcc (GCC) 11.1.1 20210428 (Red Hat 11.1.1-1) , clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)
    42    28.95 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    43    20.82 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    44    95.56 fedora:rawhide                : Ok   gcc (GCC) 11.1.1 20210512 (Red Hat 11.1.1-2) , clang version 12.0.0 (Fedora 12.0.0-2.fc35)
    45    30.30 gentoo-stage3:latest          : Ok   gcc (Gentoo 10.2.0-r5 p6) 10.2.0 
    46    80.12 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    47    44.18 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
            yychar = yylex (&yylval, &yylloc, scanner);
                     ^
      #define yylex           parse_events_lex
                              ^
      1 error generated.
      make[3]: *** [/git/perf-5.13.0-rc4/tools/build/Makefile.build:139: util] Error 2
    48   217.40 openmandriva:cooker           : Ok   gcc (GCC) 11.1.0 20210427 (OpenMandriva) , OpenMandriva 12.0.0-1 clang version 12.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-12.0.0/clang b3a1e025e0452bb54d01ab5281bbf509ac4e3c72)
    49   116.62 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    50   123.70 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    51   114.12 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    52   114.10 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    53   106.46 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.1.1 20210510 [revision 23855a176609fe8dda6abaf2b21846b4517966eb] , clang version 12.0.0
    54    91.46 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.2) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
    55    78.20 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    56    22.36 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    57    22.09 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    58    21.76 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    59    22.31 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    60    22.21 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    61    21.63 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    62    84.99 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    63    23.88 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    64    23.72 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    65    19.12 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    66    23.33 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    67    25.29 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    68    25.37 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    69   165.82 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    70    21.10 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    71    23.17 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    72    21.26 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    73    71.83 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
    74    26.23 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
    75    70.14 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
    76    66.98 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-1ubuntu1
  77 6151.9
  
  real	104m10.509s
  user	1m0.922s
  sys	1m8.316s
  $

  # git log --oneline -1
  67069a1f0fe5 (HEAD -> perf/urgent, five/perf/urgent, acme.korg/tmp.perf/urgent) perf env: Fix memory leak of bpf_prog_info_linear member
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
  78: probe libc's inet_pton & backtrace it with ping                 : Ok
  79: Use vfs_getname probe to get syscall args filenames             : Ok
  80: Check Arm CoreSight trace data recording and synthesized samples: Skip
  81: perf stat metrics (shadow stat) test                            : Ok
  82: build id cache operations                                       : Ok
  83: daemon operations                                               : Ok
  84: Add vfs_getname probe to get syscall args filenames             : Ok
  85: perf stat csv summary test                                      : Ok
  86: Check open filename arg using perf trace + vfs_getname          : Ok
  87: perf stat --bpf-counters test                                   : Ok
  88: Zstd perf.data compression/decompression                        : Ok
  #

  $ grep -m1 "^model name" /proc/cpuinfo 
  model name	: AMD Ryzen 9 3900X 12-Core Processor
  $ git log --oneline
  67069a1f0fe5f9ee (HEAD -> perf/urgent) perf env: Fix memory leak of bpf_prog_info_linear member
  $ time make -C tools/perf build-test
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
  make[1]: 'make_static' is up to date.
                make_with_gtk2: make GTK2=1 -j24  DESTDIR=/tmp/tmp.e3z8QNysGQ
  - /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_demangle_O: make NO_DEMANGLE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                   make_tags_O: make tags
                make_install_O: make install
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
           make_with_libpfm4_O: make LIBPFM4=1
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_pure_O: make
              make_clean_all_O: make clean all
              make_no_libelf_O: make NO_LIBELF=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                make_no_gtk2_O: make NO_GTK2=1
           make_no_libpython_O: make NO_LIBPYTHON=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libperl_O: make NO_LIBPERL=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
             make_util_map_o_O: make util/map.o
            make_install_bin_O: make install-bin
                  make_debug_O: make DEBUG=1
                   make_help_O: make help
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
                 make_perf_o_O: make perf.o
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
               make_no_slang_O: make NO_SLANG=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
                    make_doc_O: make doc
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                 make_no_sdt_O: make NO_SDT=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  
  real	4m18.866s
  user	49m44.152s
  sys	8m13.703s
  $
