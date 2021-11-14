Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4484BC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 01:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115F860F36
	for <linux-perf-users@archiver.kernel.org>; Sun, 14 Nov 2021 01:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbhKNB0C (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 13 Nov 2021 20:26:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:39334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229988AbhKNB0B (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 13 Nov 2021 20:26:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56A3D60C49;
        Sun, 14 Nov 2021 01:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636852988;
        bh=tMB6wmSdfjcN0ScLDKDjZW+Fh8c6EQwL1UaGaMrK598=;
        h=From:To:Cc:Subject:Date:From;
        b=PwN5fA8psRJMd81Jc90R2KQdAzffRfg2rxn8Oysbks42QkQ0zh7n/xJKZ5MpGWih+
         1zSYsWdU+FP4iypFi+UNImkMYhhAC6f6dj2IHnXnN6y/9oU5B+QTkhkweXAp2ApCbm
         VjWwTyC5begPJtwzIv3HF+MrEDHG6PN+5pvk0QI4+Yj7DQfF+Ah+xebiGWgev52W7K
         OmpSmOs84w/a8vCOJMvsD3S/5kvFSix/Rf++mmO08NfEnHeSBJv2eUVhjbGQHKA2za
         Y7OTWk4bxzU+oFauM3b7sr0gLcJXp5ZDSVSOu8NBgh+G57kOPNYVNe4Fj/s6NLrtKl
         E/BU2rpNmg8+A==
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
        Andrew Kilroy <andrew.kilroy@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>,
        Like Xu <likexu@tencent.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.16: 2nd batch
Date:   Sat, 13 Nov 2021 22:22:58 -0300
Message-Id: <20211114012258.33507-1-acme@kernel.org>
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


The following changes since commit 5833291ab6de9c3e2374336b51c814e515e8f3a5:

  Merge tag 'pci-v5.16-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci (2021-11-11 15:10:18 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-13

for you to fetch changes up to ac96f463cc9aebb00ca7bbee47efb0794dfd0f3f:

  perf tests: Remove bash constructs from stat_all_pmu.sh (2021-11-13 18:11:51 -0300)

----------------------------------------------------------------
perf tools changes for v5.16: 2nd batch

Hardware tracing:

ARM:

- Print the size of the buffer size consistently in hexadecimal in ARM Coresight.

- Add Coresight snapshot mode support.

- Update --switch-events docs in 'perf record'.

- Support hardware-based PID tracing.

- Track task context switch for cpu-mode events.

Vendor events:

- Add metric events JSON file for power10 platform

perf test:

- Get 'perf test' unit tests closer to kunit.

- Topology tests improvements.

- Remove bashisms from some tests.

perf bench:

- Fix memory leak of perf_cpu_map__new() in the futex benchmarks.

libbpf:

- Add some more weak libbpf functions o allow building with the libbpf versions, old ones,
  present in distros.

libbeauty:

- Translate [gs]setsockopt 'level' argument integer values to strings.

tools headers UAPI:

- Sync futex_waitv, arch prctl, sound, i195_drm and msr-index files with the kernel sources.

Documentation:

- Add documentation to 'struct symbol'.

- Synchronize the definition of enum perf_hw_id with code in tools/perf/design.txt.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Andrew Kilroy (2):
      perf cs-etm: Print size using consistent format
      perf arm-spe: Print size using consistent format

Arnaldo Carvalho de Melo (16):
      perf beauty: Make all sockaddr files use a common naming scheme
      perf beauty: Rename socket_ipproto.sh to socket.sh to hold more socket table generators
      perf beauty socket: Rename header_dir to uapi_header_dir
      perf beauty socket: Prep to receive more input header files
      perf beauty socket: Rename 'regex'  to 'ipproto_regex'
      perf beauty socket: Sort the ipproto array entries
      perf beauty socket: Add generator for socket level (SOL_*) string table
      perf trace: Beautify the 'level' argument of getsockopt
      perf trace: Beautify the 'level' argument of setsockopt
      perf beauty: Add socket level scnprintf that handles ARCH specific SOL_SOCKET
      tools headers UAPI: Sync files changed by new futex_waitv syscall
      tools headers UAPI: Sync arch prctl headers with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers UAPI: Sync sound/asound.h with the kernel sources
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources

German Gomez (6):
      perf arm-spe: Add snapshot mode support
      perf arm-spe: Implement find_snapshot callback
      perf arm-spe: Snapshot mode test
      perf arm-spe: Update --switch-events docs in 'perf record'
      perf arm-spe: Save context ID in record
      perf arm-spe: Support hardware-based PID tracing

Guo Zhengkui (1):
      perf test bpf: Use ARRAY_CHECK() instead of ad-hoc equivalent, addressing array_size.cocci warning

Ian Rogers (34):
      perf test: Use macro for "suite" declarations
      perf test: Use macro for "suite" definitions
      perf test: Make each test/suite its own struct.
      perf test: Move each test suite struct to its test
      perf test: Rename struct test to test_suite
      perf test: Add helper functions for abstraction.
      perf test: Add test case struct.
      perf test: Add skip reason to test case.
      perf test: Convert pfm tests to use test cases.
      perf test: Convert pmu event tests to test cases.
      perf test: Convert watch point tests to test cases.
      perf test: Convert clang tests to test cases.
      perf test: Convert bpf tests to test cases.
      perf test: Convert llvm tests to test cases.
      perf test: Remove now unused subtest helpers
      perf test: bp tests use test case
      perf test: Convert time to tsc test to test case.
      perf test: Remove non test case style support.
      perf test: BP tests, remove is_supported use
      perf test: TSC test, remove is_supported use
      perf test: Remove is_supported function
      perf test: Remove skip_if_fail
      perf test: Add expr test for events with hyphens
      perf cputopo: Update to use pakage_cpus
      perf cputopo: Match die_siblings to topology ABI name
      perf cputopo: Match thread_siblings to topology ABI name
      perf expr: Add literal values starting with #
      perf expr: Add metric literals for topology.
      perf expr: Move ID handling to its own function
      perf expr: Add source_count for aggregating events
      perf symbols: Add documentation to 'struct symbol'
      perf symbols: Bit pack to save a byte
      perf symbols: Factor out annotation init/exit
      perf bpf: Avoid memory leak from perf_env__insert_btf()

James Clark (3):
      perf test: Remove bash construct from stat_bpf_counters.sh test
      perf tests: Remove bash construct from record+zstd_comp_decomp.sh
      perf tests: Remove bash constructs from stat_all_pmu.sh

Jiri Olsa (1):
      perf tools: Add more weak libbpf functions

Kajol Jain (1):
      perf vendor events power10: Add metric events JSON file for power10 platform

Like Xu (1):
      perf design.txt: Synchronize the definition of enum perf_hw_id with code

Namhyung Kim (1):
      perf arm-spe: Track task context switch for cpu-mode events

Sohaib Mohamed (1):
      perf bench futex: Fix memory leak of perf_cpu_map__new()

 tools/arch/x86/include/asm/msr-index.h             |   2 +
 tools/arch/x86/include/uapi/asm/prctl.h            |   4 +
 tools/include/uapi/asm-generic/unistd.h            |   5 +-
 tools/include/uapi/drm/i915_drm.h                  | 242 +++++++-
 tools/include/uapi/linux/prctl.h                   |   3 +
 tools/include/uapi/sound/asound.h                  |   2 +-
 tools/perf/Documentation/perf-record.txt           |   2 +-
 tools/perf/Makefile.perf                           |  20 +-
 tools/perf/arch/arm/include/arch-tests.h           |   2 +-
 tools/perf/arch/arm/tests/arch-tests.c             |  16 +-
 tools/perf/arch/arm/tests/vectors-page.c           |   5 +-
 tools/perf/arch/arm64/include/arch-tests.h         |   2 +-
 tools/perf/arch/arm64/tests/arch-tests.c           |  11 +-
 tools/perf/arch/arm64/util/arm-spe.c               | 283 ++++++++-
 tools/perf/arch/powerpc/include/arch-tests.h       |   2 +-
 tools/perf/arch/powerpc/tests/arch-tests.c         |  12 +-
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/x86/include/arch-tests.h           |  14 +-
 tools/perf/arch/x86/tests/arch-tests.c             |  47 +-
 tools/perf/arch/x86/tests/bp-modify.c              |   2 +-
 tools/perf/arch/x86/tests/insn-x86.c               |   2 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |   2 +-
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |   2 +-
 tools/perf/arch/x86/tests/rdpmc.c                  |   2 +-
 tools/perf/arch/x86/tests/sample-parsing.c         |   2 +-
 tools/perf/bench/futex-lock-pi.c                   |   1 +
 tools/perf/bench/futex-requeue.c                   |   1 +
 tools/perf/bench/futex-wake-parallel.c             |   1 +
 tools/perf/bench/futex-wake.c                      |   1 +
 tools/perf/builtin-trace.c                         |   4 +
 tools/perf/design.txt                              |   3 +
 .../pmu-events/arch/powerpc/power10/metrics.json   | 676 +++++++++++++++++++++
 tools/perf/tests/api-io.c                          |   6 +-
 tools/perf/tests/attr.c                            |   4 +-
 tools/perf/tests/backward-ring-buffer.c            |   4 +-
 tools/perf/tests/bitmap.c                          |   4 +-
 tools/perf/tests/bp_account.c                      |  36 +-
 tools/perf/tests/bp_signal.c                       |  34 +-
 tools/perf/tests/bp_signal_overflow.c              |   9 +-
 tools/perf/tests/bpf.c                             |  71 ++-
 tools/perf/tests/builtin-test.c                    | 578 ++++++------------
 tools/perf/tests/clang.c                           |  54 +-
 tools/perf/tests/code-reading.c                    |   4 +-
 tools/perf/tests/cpumap.c                          |  10 +-
 tools/perf/tests/demangle-java-test.c              |   4 +-
 tools/perf/tests/demangle-ocaml-test.c             |   4 +-
 tools/perf/tests/dlfilter-test.c                   |   4 +-
 tools/perf/tests/dso-data.c                        |  10 +-
 tools/perf/tests/dwarf-unwind.c                    |   5 +-
 tools/perf/tests/event-times.c                     |   4 +-
 tools/perf/tests/event_update.c                    |   4 +-
 tools/perf/tests/evsel-roundtrip-name.c            |   5 +-
 tools/perf/tests/evsel-tp-sched.c                  |   5 +-
 tools/perf/tests/expand-cgroup.c                   |   6 +-
 tools/perf/tests/expr.c                            |  38 +-
 tools/perf/tests/fdarray.c                         |   7 +-
 tools/perf/tests/genelf.c                          |   6 +-
 tools/perf/tests/hists_cumulate.c                  |   4 +-
 tools/perf/tests/hists_filter.c                    |   4 +-
 tools/perf/tests/hists_link.c                      |   4 +-
 tools/perf/tests/hists_output.c                    |   4 +-
 tools/perf/tests/is_printable_array.c              |   4 +-
 tools/perf/tests/keep-tracking.c                   |   4 +-
 tools/perf/tests/kmod-path.c                       |   4 +-
 tools/perf/tests/llvm.c                            |  74 ++-
 tools/perf/tests/maps.c                            |   4 +-
 tools/perf/tests/mem.c                             |   4 +-
 tools/perf/tests/mem2node.c                        |   4 +-
 tools/perf/tests/mmap-basic.c                      |   4 +-
 tools/perf/tests/mmap-thread-lookup.c              |   4 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   5 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   5 +-
 tools/perf/tests/openat-syscall.c                  |   5 +-
 tools/perf/tests/parse-events.c                    |   4 +-
 tools/perf/tests/parse-metric.c                    |   4 +-
 tools/perf/tests/parse-no-sample-id-all.c          |   5 +-
 tools/perf/tests/pe-file-parsing.c                 |   6 +-
 tools/perf/tests/perf-hooks.c                      |   4 +-
 tools/perf/tests/perf-record.c                     |   4 +-
 tools/perf/tests/perf-time-to-tsc.c                |  30 +-
 tools/perf/tests/pfm.c                             |  63 +-
 tools/perf/tests/pmu-events.c                      |  73 +--
 tools/perf/tests/pmu.c                             |   4 +-
 tools/perf/tests/python-use.c                      |   4 +-
 tools/perf/tests/sample-parsing.c                  |   4 +-
 tools/perf/tests/sdt.c                             |   6 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |   2 +-
 tools/perf/tests/shell/stat_all_pmu.sh             |   4 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   2 +-
 tools/perf/tests/shell/test_arm_spe.sh             |  89 +++
 tools/perf/tests/stat.c                            |  11 +-
 tools/perf/tests/sw-clock.c                        |   4 +-
 tools/perf/tests/switch-tracking.c                 |   4 +-
 tools/perf/tests/task-exit.c                       |   4 +-
 tools/perf/tests/tests.h                           | 238 ++++----
 tools/perf/tests/thread-map.c                      |  10 +-
 tools/perf/tests/thread-maps-share.c               |   4 +-
 tools/perf/tests/time-utils-test.c                 |   4 +-
 tools/perf/tests/topology.c                        |   4 +-
 tools/perf/tests/unit_number__scnprintf.c          |   4 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   5 +-
 tools/perf/tests/wp.c                              | 124 ++--
 tools/perf/trace/beauty/beauty.h                   |   5 +
 tools/perf/trace/beauty/sockaddr.c                 |   2 +-
 tools/perf/trace/beauty/sockaddr.sh                |  24 +
 tools/perf/trace/beauty/socket.c                   |  21 +-
 tools/perf/trace/beauty/socket.sh                  |  38 +-
 tools/perf/trace/beauty/socket_ipproto.sh          |  12 -
 tools/perf/util/annotate.c                         |  13 +-
 tools/perf/util/annotate.h                         |   3 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   2 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   1 +
 tools/perf/util/arm-spe.c                          | 122 +++-
 tools/perf/util/bpf-event.c                        |  33 +-
 tools/perf/util/c++/clang-c.h                      |   8 +-
 tools/perf/util/c++/clang-test.cpp                 |   6 +-
 tools/perf/util/cputopo.c                          |  78 +--
 tools/perf/util/cputopo.h                          |  33 +-
 tools/perf/util/cs-etm.c                           |   2 +-
 tools/perf/util/env.c                              |   5 +-
 tools/perf/util/env.h                              |   2 +-
 tools/perf/util/evsel.c                            |  12 +
 tools/perf/util/evsel.h                            |   1 +
 tools/perf/util/expr.c                             |  65 +-
 tools/perf/util/expr.h                             |   4 +
 tools/perf/util/expr.l                             |  16 +-
 tools/perf/util/expr.y                             |  73 ++-
 tools/perf/util/header.c                           |  20 +-
 tools/perf/util/stat-shadow.c                      |   7 +-
 tools/perf/util/symbol.c                           |   9 +-
 tools/perf/util/symbol.h                           |  19 +-
 131 files changed, 2639 insertions(+), 1148 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/metrics.json
 create mode 100755 tools/perf/tests/shell/test_arm_spe.sh
 create mode 100755 tools/perf/trace/beauty/sockaddr.sh
 delete mode 100755 tools/perf/trace/beauty/socket_ipproto.sh

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
it there to see if a refreshed container cures this soon.

Ubuntu 21.10 is failing with the newly added BUILD_BPF_SKEL=1, where clang is used
to generate BPF bytecode, this is being done with other flagship distro versions
and working, except on this case, to be investigated.

There are some minor errors on the 'perf test' codebase when cross building to
arm64 on ubuntu and s390 that will be fixed shortly.

  # export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.15.0.tar.xz
  # dm 
   1 almalinux:8                   : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.5.0+2598+6a7729ff)
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
  12 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210921) 10.3.1 20210921 , Alpine clang version 12.0.1
  14 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  15 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  16 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
  17 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  18 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  19 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module_el8.4.0+966+2995ef20)
  20 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  21 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211027 releases/gcc-11.2.0-389-g5782bacaca , clang version 11.1.0
  22 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  23 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  24 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25 debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang version 11.1.0-4
  26 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  27 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  28 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  29 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  30 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  31 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  32 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  33 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  34 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  35 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  36 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  37 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  38 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  39 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  40 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  41 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  42 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  43 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  44 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  45 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  46 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
  47 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211019 (Red Hat 11.2.1-6) , clang version 13.0.0 (Fedora 13.0.0-5.fc36)
  48 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 
  49 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  50 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.15.0/tools/build/Makefile.build:139: util] Error 2
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
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    file: Compiled magic version [540] does not match with shared library magic version [539]
    
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    file: Compiled magic version [540] does not match with shared library magic version [539]
    
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  52 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54    99.59 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  55    91.26 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  56    93.88 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] , clang version 13.0.0
  57    79.75 oraclelinux:8                 : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1.0.4) , clang version 11.0.1 (Red Hat 11.0.1-1.0.1.module+el8.4.0+20397+f876858a)
  58    80.87 rockylinux:8                  : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.1 (Red Hat 11.0.1-1.module+el8.4.0+666+3effbf14)
  59    69.34 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  60    18.45 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  61     6.99 ubuntu:16.04-x-arm64          : FAIL gcc version 5.4.0 20160609 (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 
    arch/arm64/util/arm-spe.c: In function 'arm_spe_alloc_wrapped_array':
    arch/arm64/util/arm-spe.c:330:12: error: implicit declaration of function 'reallocarray' [-Werror=implicit-function-declaration]
      wrapped = reallocarray(ptr->wrapped, new_cnt, sizeof(bool));
                ^
    arch/arm64/util/arm-spe.c:330:10: error: assignment makes pointer from integer without a cast [-Werror=int-conversion]
      wrapped = reallocarray(ptr->wrapped, new_cnt, sizeof(bool));
              ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'util' failed
    make[5]: *** [util] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arm64' failed
    make[4]: *** [arm64] Error 2
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'arch' failed
    make[3]: *** [arch] Error 2
  62    18.14 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  63    18.64 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  64    18.64 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  65     6.40 ubuntu:16.04-x-s390           : FAIL gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.9) 
    tests/wp.c:24:12: error: 'wp_read' defined but not used [-Werror=unused-function]
     static int wp_read(int fd, long long *count, int size)
                ^
    tests/wp.c:35:13: error: 'get__perf_event_attr' defined but not used [-Werror=unused-function]
     static void get__perf_event_attr(struct perf_event_attr *attr, int wp_type,
                 ^
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2
  66    74.83 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  67    20.05 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  68    20.05 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  69    16.43 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  70    19.75 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71    21.25 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    21.16 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    95.82 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74     6.60 ubuntu:18.04-x-s390           : FAIL gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04) 
    tests/wp.c:35:13: error: 'get__perf_event_attr' defined but not used [-Werror=unused-function]
     static void get__perf_event_attr(struct perf_event_attr *attr, int wp_type,
                 ^~~~~~~~~~~~~~~~~~~~
    tests/wp.c:24:12: error: 'wp_read' defined but not used [-Werror=unused-function]
     static int wp_read(int fd, long long *count, int size)
                ^~~~~~~
    cc1: all warnings being treated as errors
    /git/perf-5.15.0/tools/build/Makefile.build:139: recipe for target 'tests' failed
    make[3]: *** [tests] Error 2
  75    19.24 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    17.83 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    21.76 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  78    76.34 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  79    79.35 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  80    30.18 ubuntu:21.10                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-7ubuntu2) 
    :11/usr/include/linux/types.h:
    /usr/include/linux/types.h::5/usr/include/linux/types.h5:::10510::: 10 : fatal error: fatal error: fatal error: 'asm/types.h' file not found'asm/types.h' file not found
    
    'asm/types.h' file not found
    #include <asm/types.h>#include <asm/types.h>
    #include <asm/types.h>
    
             ^~~~~~~~~~~~~         ^~~~~~~~~~~~~
             ^~~~~~~~~~~~~
    
    1 error generated.
    1 error generated.
    1 error generated.

  $ uname -a
  Linux quaco 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -1
  ac96f463cc9aebb0 (HEAD -> perf/core, tag: perf-tools-for-v5.16-2021-11-13, seventh/perf/core, five/perf/core) perf tests: Remove bash constructs from stat_all_pmu.sh
  $ perf -v
  perf version 5.15.gac96f463cc9a
  $ sudo su -
  # perf -vv
  perf version 5.15.gac96f463cc9a
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
  91: perf stat --bpf-counters test                                   : Ok
  92: Check Arm CoreSight trace data recording and synthesized samples: Skip
  93: Check Arm SPE trace data recording and synthesized samples      : Skip
  94: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ git log --oneline -1 ; make -C tools/perf build-test
  ac96f463cc9a (HEAD -> perf/core, tag: perf-tools-for-v5.16-2021-11-13, quaco/perf/core, five/perf/core) perf tests: Remove bash constructs from stat_all_pmu.sh
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j4  DESTDIR=/tmp/tmp.cu8uNpbo3B
                make_with_gtk2: make GTK2=1 -j4  DESTDIR=/tmp/tmp.3OL8DRZjg2
            make_no_libaudit_O: make NO_LIBAUDIT=1
               make_no_slang_O: make NO_SLANG=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_no_newt_O: make NO_NEWT=1
              make_no_libbpf_O: make NO_LIBBPF=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
             make_no_libnuma_O: make NO_LIBNUMA=1
           make_no_backtrace_O: make NO_BACKTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
                 make_no_sdt_O: make NO_SDT=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
         make_with_coresight_O: make CORESIGHT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
            make_install_bin_O: make install-bin
                   make_pure_O: make
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
            make_no_demangle_O: make NO_DEMANGLE=1
                 make_cscope_O: make cscope
                   make_help_O: make help
           make_no_libunwind_O: make NO_LIBUNWIND=1
                 make_perf_o_O: make perf.o
                   make_tags_O: make tags
            make_no_auxtrace_O: make NO_AUXTRACE=1
                    make_doc_O: make doc
        make_with_babeltrace_O: make LIBBABELTRACE=1
              make_clean_all_O: make clean all
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                  make_debug_O: make DEBUG=1
                make_no_gtk2_O: make NO_GTK2=1
                make_install_O: make install
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_no_libelf_O: make NO_LIBELF=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_util_map_o_O: make util/map.o
           make_with_libpfm4_O: make LIBPFM4=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
             make_no_libperl_O: make NO_LIBPERL=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
