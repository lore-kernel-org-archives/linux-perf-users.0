Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18067C433E9
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Feb 2021 19:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1FC64EBD
	for <linux-perf-users@archiver.kernel.org>; Fri, 19 Feb 2021 19:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhBSTrV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 14:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhBSTrS (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 19 Feb 2021 14:47:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8072C64D99;
        Fri, 19 Feb 2021 19:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613763995;
        bh=/DuhIBueX1KHxxqemp+sQygNJuo+hVbvb2/YJ0g6YXQ=;
        h=From:To:Cc:Subject:Date:From;
        b=HCvUQsTGRMxQCUUt4HpuzL0ic1aYxEKYf7E3fAFgsll8VC9SFsEE8oXtpmw9EaL4j
         aH2NYBsjfEl5Cx+GaIMR8dKBdslpA2Tw7zAtpN+TgyK6xZSB/9N5iaZ18TmvxjYmdU
         A0rELElGsnNKdZILdFZ1Qw6O5MpjM7BSWeP0PsmUIJ5hLvP27mP7999xlF6vmvp/fo
         q/+QtMg3+NbBBr5xSkVzDK9pPx24EzQXQ7luLcg8YX9kDn7TGQqtxc8U9bMoAa1AMz
         0626kY8XgWtPGLBBEVLoQSg9kmYusyEbvEdTyjoahS4+0R4PY/ZOW1UuOMZXUYlFxV
         IXRxuicWk8tWQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Dmitry Safonov <dima@arista.com>,
        Hans-Peter Nilsson <hp@axis.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jianlin Lv <Jianlin.Lv@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kees Kook <keescook@chromium.org>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Mike Leach <mike.leach@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.12
Date:   Fri, 19 Feb 2021 16:46:19 -0300
Message-Id: <20210219194619.1780437-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
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

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.12-2020-02-19

for you to fetch changes up to 3027ce36ccbae74f2e7c1afbfc3f69fee0c2a996:

  perf buildid-cache: Don't skip 16-byte build-ids (2021-02-18 16:41:40 -0300)

----------------------------------------------------------------
New features:

- Support instruction latency in 'perf report', with both memory latency
  (weight) and instruction latency information, users can locate expensive load
  instructions and understand time spent in different stages.

- Extend 'perf c2c' to display the number of loads which were blocked by data
  or address conflict.

- Add 'perf stat' support for L2 topdown events in systems such as Intel's
  Sapphire rapids server.

- Add support for PERF_SAMPLE_CODE_PAGE_SIZE in various tools, as a sort key, for instance:

    perf report --stdio --sort=comm,symbol,code_page_size

- New 'perf daemon' command to run long running sessions while providing a way to control
  the enablement of events without restarting a traditional 'perf record' session.

- Enable counting events for BPF programs in 'perf stat' just like for other
  targets (tid, cgroup, cpu, etc), e.g.:

      # perf stat -e ref-cycles,cycles -b 254 -I 1000
         1.487903822            115,200      ref-cycles
         1.487903822             86,012      cycles
         2.489147029             80,560      ref-cycles
         2.489147029             73,784      cycles
      ^C#

  The example above counts 'cycles' and 'ref-cycles' of BPF program of id 254.
  It is similar to bpftool-prog-profile command, but more flexible.

- Support the new layout for PERF_RECORD_MMAP2 to carry the DSO build-id using infrastructure
  generalised from the eBPF subsystem, removing the need for traversing the perf.data file
  to collect build-ids at the end of 'perf record' sessions and helping with long running
  sessions where binaries can get replaced in updates, leading to possible mis-resolution
  of symbols.

- Support filtering by hex address in 'perf script'.

- Support DSO filter in 'perf script', like in other perf tools.

- Add namespaces support to 'perf inject'

- Add support for SDT (Dtrace Style Markers) events on ARM64.

perf record:

- Fix handling of eventfd() when draining a buffer in 'perf record'.

- Improvements to the generation of metadata events for pre-existing threads (mmaps, comm, etc),
  speeding up the work done at the start of system wide or per CPU 'perf record' sessions.

Hardware tracing:

- Initial support for tracing KVM with Intel PT.

- Intel PT fixes for IPC

- Support Intel PT PSB (synchronization packets) events.

- Automatically group aux-output events to overcome --filter syntax.

- Enable PERF_SAMPLE_DATA_SRC on ARMs SPE.

- Update ARM's CoreSight hardware tracing OpenCSD library to v1.0.0.

perf annotate TUI:

- Fix handling of 'k' ("show line number") hotkey

- Fix jump parsing for C++ code.

perf probe:

- Add protection to avoid endless loop.

cgroups:

- Avoid reading cgroup mountpoint multiple times, caching it.

- Fix handling of cgroup v1/v2 in mixed hierarchy.

Symbol resolving:

- Add OCaml symbol demangling.

- Further fixes for handling PE executables when using perf with Wine and .exe/.dll files.

- Fix 'perf unwind' DSO handling.

- Resolve symbols against debug file first, to deal with artifacts related to LTO.

- Fix gap between kernel end and module start on powerpc.

Reporting tools:

- The DSO filter shouldn't show samples in unresolved maps.

- Improve debuginfod support in various tools.

build ids:

- Fix 16-byte build ids in 'perf buildid-cache', add a 'perf test' entry for that case.

perf test:

- Support for PERF_SAMPLE_WEIGHT_STRUCT.

- Add test case for PERF_SAMPLE_CODE_PAGE_SIZE.

- Shell based tests for 'perf daemon's commands ('start', 'stop, 'reconfig', 'list', etc).

- ARM cs-etm 'perf test' fixes.

- Add parse-metric memory bandwidth testcase.

Compiler related:

- Fix 'perf probe' kretprobe issue caused by gcc 11 bug when used with -fpatchable-function-entry.

- Fix ARM64 build with gcc 11's -Wformat-overflow.

- Fix unaligned access in sample parsing test.

- Fix printf conversion specifier for IP addresses on arm64, s390 and powerpc.

Arch specific:

- Support exposing Performance Monitor Counter SPRs as part of extended regs on powerpc.

- Add JSON 'perf stat' metrics for ARM64's imx8mp, imx8mq and imx8mn DDR, fix imx8mm ones.

- Fix common and uarch events for ARM64's A76 and Ampere eMag

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (16):
      perf intel-pt: Fix missing CYC processing in PSB
      perf intel-pt: Fix premature IPC
      perf intel-pt: Fix IPC with CYC threshold
      perf intel-pt: Add PSB events
      perf auxtrace: Automatically group aux-output events
      perf script: Add branch types for VM-Entry and VM-Exit
      perf intel_pt: Add vmlaunch and vmresume as branches
      perf intel-pt: Retain the last PIP packet payload as is
      perf intel-pt: Amend decoder to track the NR flag
      perf machine: Factor out machines__find_guest()
      perf machine: Factor out machine__idle_thread()
      perf intel-pt: Support decoding of guest kernel
      perf intel-pt: Allow for a guest kernel address filter
      perf intel-pt: Adjust sample flags for VM-Exit
      perf intel-pt: Split VM-Entry and VM-Exit branches
      perf intel-pt: Add documentation for tracing virtual machines

Arnaldo Carvalho de Melo (9):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf tools: Fix DSO filtering when not finding a map for a sampled address
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf powerpc: Fix printf conversion specifier for IP addresses
      perf arm64/s390: Fix printf conversion specifier for IP addresses
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      Merge branch 'perf/urgent' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core

Athira Rajeev (2):
      perf powerpc: Fix gap between kernel end and module start
      perf powerpc: Support exposing Performance Monitor Counter SPRs as part of extended regs

Dave Rigby (1):
      perf unwind: Set userdata for all __report_module() paths

Dmitry Safonov (1):
      perf symbols: Use (long) for iterator for bfd symbols

Fabian Hemmer (1):
      perf tools: Add OCaml demangling

Hans-Peter Nilsson (1):
      perf record: Tweak "Lowering..." warning in record_opts__config_freq

Ian Rogers (3):
      perf trace-event-info: Rename for_each_event.
      perf tools: Remove unused xyarray.c as it was moved to tools/lib/perf
      perf env: Remove unneeded internal/cpumap inclusions

James Clark (1):
      perf cs-etm: Update ARM's CoreSight hardware tracing OpenCSD library to v1.0.0

Jianlin Lv (3):
      perf probe: Add protection to avoid endless loop
      perf probe: Fix kretprobe issue caused by GCC bug
      perf tools: Fix arm64 build error with gcc-11

Jiapeng Chong (1):
      perf tools: Simplify the calculation of variables

Jin Yao (3):
      perf script: Support DSO filter like in other perf tools
      perf intlist: Change 'struct intlist' int member to 'unsigned long'
      perf script: Support filtering by hex address

Jiri Olsa (44):
      tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
      perf tools: Do not swap mmap2 fields in case it contains build id
      perf tools: Store build id when available in PERF_RECORD_MMAP2 metadata events
      perf tools: Allow using PERF_RECORD_MMAP2 to synthesize the kernel map
      perf tools: Allow using PERF_RECORD_MMAP2 to synthesize the kernel modules maps
      perf tools: Allow synthesizing the build id for kernel/modules/tasks in PERF_RECORD_MMAP2
      perf record: Add --buildid-mmap option to enable PERF_RECORD_MMAP2's build id
      perf tools: Add support to display build ids when available in PERF_RECORD_MMAP2 events
      perf buildid-cache: Add --debuginfod option to specify a server to fetch debug files
      perf buildid-list: Add support for mmap2's buildid events
      perf config: Make perf_config_from_file() static
      perf config: Add config set interface
      perf debug: Add debug_set_display_time function
      perf config: Add perf_home_perfconfig function
      perf config: Make perf_config_system() global
      perf config: Make perf_config_global() global
      perf tools: Allow to enable/disable events via control file
      perf tools: Add 'evlist' control command
      perf tools: Add 'stop' control command
      perf tools: Add 'ping' control command
      perf daemon: Add daemon command
      perf daemon: Add config option
      perf daemon: Add base option
      perf daemon: Add server socket support
      perf daemon: Add client socket support
      perf daemon: Add config file support
      perf daemon: Add config file change check
      perf daemon: Add background support
      perf daemon: Add signalfd support
      perf daemon: Add 'list' command
      perf daemon: Add 'signal' command
      perf daemon: Add 'stop' command
      perf daemon: Allow only one daemon over base directory
      perf daemon: Set control fifo for session
      perf daemon: Add 'ping' command
      perf daemon: Use control to stop session
      perf daemon: Add up time for daemon/session list
      perf daemon: Add examples to man page
      perf tests: Add daemon 'list' command test
      perf tests: Add daemon reconfig test
      perf tests: Add daemon 'stop' command test
      perf tests: Add daemon 'signal' command test
      perf tests: Add daemon 'ping' command test
      perf tests: Add daemon 'lock' test

Jiri Slaby (1):
      perf symbols: Resolve symbols against debug file first

Joakim Zhang (4):
      perf vendor events arm64: Fix indentation of brackets in imx8mm metrics
      perf vendor events arm64: Add JSON metrics for imx8mn DDR Perf
      perf vendor events arm64: Add JSON metrics for imx8mq DDR Perf
      perf vendor events arm64: Add JSON metrics for imx8mp DDR Perf

John Garry (5):
      perf test: Add parse-metric memory bandwidth testcase
      perf vendor events arm64: Fix Ampere eMag event typo
      perf vendor events arm64: Add common and uarch event JSON
      perf vendor events arm64: Reference common and uarch events for Ampere eMag
      perf vendor events arm64: Reference common and uarch events for A76

Kan Liang (14):
      perf mem: Clean up output format
      perf mem: Support data page size
      perf record: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
      perf stat: Add Topdown metrics events as default events
      tools headers uapi: Update tools's copy of linux/perf_event.h
      perf tools: Support the auxiliary event
      perf tools: Support data block and addr block
      perf c2c: Support data block and addr block
      perf tools: Support PERF_SAMPLE_WEIGHT_STRUCT
      perf report: Support instruction latency
      perf test: Support PERF_SAMPLE_WEIGHT_STRUCT
      perf stat: Support L2 Topdown events
      perf tools: Update topdown documentation for Sapphire Rapids
      perf tools: Support arch specific PERF_SAMPLE_WEIGHT_STRUCT processing

Kees Cook (1):
      perf tools: Replace lkml.org links with lore

Leo Yan (16):
      perf probe: Fixup Arm64 SDT arguments
      perf arm64: Add argument support for SDT
      perf c2c: Rename for shared cache line stats
      perf c2c: Refactor hist entry validation
      perf c2c: Refactor display filter
      perf c2c: Fix argument type for percent()
      perf c2c: Refactor node display
      perf c2c: Add local variables for output metrics
      perf arm-spe: Enable sample type PERF_SAMPLE_DATA_SRC
      perf arm-spe: Store memory address in packet
      perf arm-spe: Store operation type in packet
      perf arm-spe: Fill address info for samples
      perf arm-spe: Synthesize memory event
      perf arm-spe: Set sample's data source field
      perf test: Suppress logs in cs-etm testing
      perf test: Output the sub testing result in cs-etm

Martin Liška (2):
      perf annotate: Fix jump parsing for C++ code.
      perf annotate: Do not jump after 'k' is pressed

Namhyung Kim (7):
      perf tools: Use /proc/<PID>/task/<TID>/status for PERF_RECORD_ event synthesis
      perf tools: Skip PERF_RECORD_MMAP event synthesis for kernel threads
      perf tools: Use scandir() to iterate threads when synthesizing PERF_RECORD_ events
      tools api fs: Prefer cgroup v1 path in cgroupfs_find_mountpoint()
      tools api fs: Diet cgroupfs_find_mountpoint()
      tools api fs: Cache cgroupfs mount point
      perf test: Fix unaligned access in sample parsing test

Nicholas Fraser (5):
      perf symbols: Make dso__load_bfd_symbols() load PE files from debug cache only
      perf symbols: Fix return value when loading PE DSO
      perf symbol: Remove redundant libbfd checks
      perf buildid-cache: Add test for 16-byte build-id
      perf buildid-cache: Don't skip 16-byte build-ids

Paul Cercueil (1):
      perf stat: Use nftw() instead of ftw()

Song Liu (3):
      bpftool: Add Makefile target bootstrap
      perf build: Support build BPF skeletons with perf
      perf stat: Enable counting events for BPF programs

Stephane Eranian (3):
      perf script: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
      perf report: Add support for PERF_SAMPLE_CODE_PAGE_SIZE
      perf test: Add test case for PERF_SAMPLE_CODE_PAGE_SIZE

Yang Jihong (1):
      perf record: Fix continue profiling after draining the buffer

Yang Li (2):
      perf script: Simplify bool conversion
      perf metricgroup: Remove unneeded semicolon

Yonatan Goldschmidt (2):
      perf namespaces: Add 'in_pidns' to nsinfo struct
      perf inject jit: Add namespaces support

 tools/arch/powerpc/include/uapi/asm/perf_regs.h    |   28 +-
 tools/bpf/bpftool/Makefile                         |    2 +
 tools/build/Makefile.feature                       |    4 +-
 tools/build/feature/test-libopencsd.c              |    4 +-
 tools/include/uapi/linux/perf_event.h              |   96 +-
 tools/include/uapi/linux/prctl.h                   |    3 +
 tools/lib/api/fs/cgroup.c                          |   95 +-
 tools/lib/perf/include/perf/event.h                |   18 +-
 tools/perf/Build                                   |    1 +
 tools/perf/Documentation/examples.txt              |    2 +-
 tools/perf/Documentation/itrace.txt                |    2 +-
 tools/perf/Documentation/perf-buildid-cache.txt    |    6 +
 tools/perf/Documentation/perf-config.txt           |   24 +-
 tools/perf/Documentation/perf-daemon.txt           |  208 +++
 tools/perf/Documentation/perf-intel-pt.txt         |   89 +-
 tools/perf/Documentation/perf-mem.txt              |    3 +
 tools/perf/Documentation/perf-record.txt           |   21 +-
 tools/perf/Documentation/perf-report.txt           |   10 +-
 tools/perf/Documentation/perf-script.txt           |   25 +-
 tools/perf/Documentation/perf-stat.txt             |   32 +-
 tools/perf/Documentation/topdown.txt               |   78 +-
 tools/perf/Makefile.config                         |    9 +
 tools/perf/Makefile.perf                           |   49 +-
 tools/perf/arch/arm/include/perf_regs.h            |    2 +-
 tools/perf/arch/arm64/include/perf_regs.h          |    2 +-
 tools/perf/arch/arm64/util/machine.c               |    3 +-
 tools/perf/arch/arm64/util/perf_regs.c             |   94 ++
 tools/perf/arch/csky/include/perf_regs.h           |    2 +-
 tools/perf/arch/powerpc/include/perf_regs.h        |    8 +-
 tools/perf/arch/powerpc/util/Build                 |    1 +
 tools/perf/arch/powerpc/util/machine.c             |   25 +
 tools/perf/arch/powerpc/util/perf_regs.c           |    6 +
 tools/perf/arch/riscv/include/perf_regs.h          |    2 +-
 tools/perf/arch/s390/include/perf_regs.h           |    2 +-
 tools/perf/arch/s390/util/machine.c                |    3 +-
 tools/perf/arch/x86/include/perf_regs.h            |    2 +-
 tools/perf/arch/x86/tests/insn-x86.c               |    1 +
 .../arch/x86/tests/intel-pt-pkt-decoder-test.c     |    4 +-
 tools/perf/arch/x86/util/Build                     |    3 +
 tools/perf/arch/x86/util/event.c                   |   25 +
 tools/perf/arch/x86/util/evlist.c                  |   15 +
 tools/perf/arch/x86/util/evsel.c                   |    8 +
 tools/perf/arch/x86/util/mem-events.c              |   44 +
 tools/perf/bench/epoll-ctl.c                       |    1 -
 tools/perf/bench/epoll-wait.c                      |    1 -
 tools/perf/bench/futex-hash.c                      |    1 -
 tools/perf/bench/futex-lock-pi.c                   |    1 -
 tools/perf/bench/futex-requeue.c                   |    1 -
 tools/perf/bench/futex-wake-parallel.c             |    1 -
 tools/perf/bench/futex-wake.c                      |    1 -
 tools/perf/builtin-buildid-cache.c                 |   28 +-
 tools/perf/builtin-buildid-list.c                  |    3 +
 tools/perf/builtin-c2c.c                           |  171 ++-
 tools/perf/builtin-daemon.c                        | 1521 ++++++++++++++++++++
 tools/perf/builtin-inject.c                        |    4 +-
 tools/perf/builtin-mem.c                           |  113 +-
 tools/perf/builtin-record.c                        |   39 +-
 tools/perf/builtin-script.c                        |   37 +-
 tools/perf/builtin-stat.c                          |  124 +-
 tools/perf/builtin.h                               |    1 +
 tools/perf/command-list.txt                        |    1 +
 tools/perf/perf.c                                  |    1 +
 .../pmu-events/arch/arm64/ampere/emag/branch.json  |    8 +-
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |    5 +-
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |   58 +-
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |    4 +-
 .../arch/arm64/ampere/emag/exception.json          |   10 +-
 .../arch/arm64/ampere/emag/instruction.json        |   34 +-
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |   11 +-
 .../arch/arm64/arm/cortex-a76-n1/branch.json       |   12 +-
 .../arch/arm64/arm/cortex-a76-n1/bus.json          |   19 +-
 .../arch/arm64/arm/cortex-a76-n1/cache.json        |  118 +-
 .../arch/arm64/arm/cortex-a76-n1/exception.json    |   10 +-
 .../arch/arm64/arm/cortex-a76-n1/instruction.json  |   45 +-
 .../arch/arm64/arm/cortex-a76-n1/memory.json       |    6 +-
 .../arch/arm64/arm/cortex-a76-n1/other.json        |    4 +-
 .../arch/arm64/arm/cortex-a76-n1/pipeline.json     |   12 +-
 .../arch/arm64/armv8-common-and-microarch.json     |  248 ++++
 .../arch/arm64/freescale/imx8mm/sys/metrics.json   |    4 +-
 .../arch/arm64/freescale/imx8mn/sys/ddrc.json      |   37 +
 .../arch/arm64/freescale/imx8mn/sys/metrics.json   |   18 +
 .../arch/arm64/freescale/imx8mp/sys/ddrc.json      |   37 +
 .../arch/arm64/freescale/imx8mp/sys/metrics.json   |  466 ++++++
 .../arch/arm64/freescale/imx8mq/sys/ddrc.json      |   37 +
 .../arch/arm64/freescale/imx8mq/sys/metrics.json   |   18 +
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |    4 +
 tools/perf/tests/code-reading.c                    |   10 +-
 tools/perf/tests/demangle-ocaml-test.c             |   43 +
 tools/perf/tests/openat-syscall-all-cpus.c         |    1 -
 tools/perf/tests/parse-metric.c                    |   24 +
 tools/perf/tests/sample-parsing.c                  |   20 +-
 tools/perf/tests/shell/buildid.sh                  |    6 +
 tools/perf/tests/shell/daemon.sh                   |  475 ++++++
 tools/perf/tests/shell/test_arm_coresight.sh       |   45 +-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/ui/browsers/annotate.c                  |    2 +-
 tools/perf/util/Build                              |    2 +
 tools/perf/util/annotate.c                         |    8 +
 tools/perf/util/annotate.h                         |    1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   10 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |    8 +
 tools/perf/util/arm-spe.c                          |  133 +-
 tools/perf/util/auxtrace.c                         |   15 +
 tools/perf/util/auxtrace.h                         |    6 +
 tools/perf/util/bpf_counter.c                      |  314 ++++
 tools/perf/util/bpf_counter.h                      |   72 +
 tools/perf/util/bpf_skel/.gitignore                |    3 +
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c   |   93 ++
 tools/perf/util/build-id.c                         |    5 +-
 tools/perf/util/build-id.h                         |    4 +-
 tools/perf/util/cgroup.c                           |    8 +-
 tools/perf/util/config.c                           |  123 +-
 tools/perf/util/config.h                           |    7 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   15 +-
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/db-export.c                        |    2 +
 tools/perf/util/debug.c                            |   34 +-
 tools/perf/util/debug.h                            |    1 +
 tools/perf/util/demangle-ocaml.c                   |   80 +
 tools/perf/util/demangle-ocaml.h                   |    7 +
 tools/perf/util/event.c                            |   67 +-
 tools/perf/util/event.h                            |   18 +-
 tools/perf/util/evlist.c                           |  125 +-
 tools/perf/util/evlist.h                           |   12 +
 tools/perf/util/evsel.c                            |   63 +-
 tools/perf/util/evsel.h                            |    9 +
 tools/perf/util/evsel_fprintf.c                    |    2 +
 tools/perf/util/header.c                           |    2 +-
 tools/perf/util/hist.c                             |   15 +-
 tools/perf/util/hist.h                             |    4 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  334 ++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    7 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   15 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.h  |    1 +
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |   12 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.h   |    2 +
 tools/perf/util/intel-pt.c                         |  214 ++-
 tools/perf/util/intlist.c                          |   27 +-
 tools/perf/util/intlist.h                          |   10 +-
 tools/perf/util/jit.h                              |    2 +-
 tools/perf/util/jitdump.c                          |   84 +-
 tools/perf/util/machine.c                          |   51 +-
 tools/perf/util/machine.h                          |    2 +
 tools/perf/util/map.c                              |    8 +-
 tools/perf/util/map.h                              |    3 +-
 tools/perf/util/mem-events.c                       |   36 +
 tools/perf/util/mem-events.h                       |    5 +
 tools/perf/util/metricgroup.c                      |    2 +-
 tools/perf/util/namespaces.c                       |   23 +-
 tools/perf/util/namespaces.h                       |    3 +
 tools/perf/util/parse-events.l                     |    1 +
 tools/perf/util/perf_api_probe.c                   |   10 +
 tools/perf/util/perf_api_probe.h                   |    1 +
 tools/perf/util/perf_event_attr_fprintf.c          |    5 +-
 tools/perf/util/perf_regs.h                        |    7 +
 tools/perf/util/probe-event.c                      |   12 +-
 tools/perf/util/probe-file.c                       |   38 +-
 tools/perf/util/probe-finder.c                     |    8 +-
 tools/perf/util/python-ext-sources                 |    1 +
 tools/perf/util/python.c                           |   21 +
 tools/perf/util/record.c                           |    9 +-
 tools/perf/util/record.h                           |    2 +
 tools/perf/util/session.c                          |   54 +-
 tools/perf/util/setup.py                           |    2 +-
 tools/perf/util/sort.c                             |  109 +-
 tools/perf/util/sort.h                             |    6 +
 tools/perf/util/stat-display.c                     |    4 +-
 tools/perf/util/stat-shadow.c                      |   92 ++
 tools/perf/util/stat.c                             |    6 +-
 tools/perf/util/stat.h                             |    9 +
 tools/perf/util/string.c                           |    9 +
 tools/perf/util/string2.h                          |    2 +
 tools/perf/util/symbol-elf.c                       |   25 +-
 tools/perf/util/symbol.c                           |   73 +-
 tools/perf/util/symbol_conf.h                      |    7 +-
 tools/perf/util/synthetic-events.c                 |  225 ++-
 tools/perf/util/target.c                           |   34 +-
 tools/perf/util/target.h                           |   10 +
 tools/perf/util/trace-event-info.c                 |   10 +-
 tools/perf/util/unwind-libdw.c                     |   11 +-
 tools/perf/util/xyarray.c                          |   33 -
 tools/scripts/Makefile.include                     |    1 +
 183 files changed, 6938 insertions(+), 974 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-daemon.txt
 create mode 100644 tools/perf/arch/powerpc/util/machine.c
 create mode 100644 tools/perf/arch/x86/util/evlist.c
 create mode 100644 tools/perf/arch/x86/util/evsel.c
 create mode 100644 tools/perf/arch/x86/util/mem-events.c
 create mode 100644 tools/perf/builtin-daemon.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/armv8-common-and-microarch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mn/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mp/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mq/sys/metrics.json
 create mode 100644 tools/perf/tests/demangle-ocaml-test.c
 create mode 100755 tools/perf/tests/shell/daemon.sh
 create mode 100644 tools/perf/util/bpf_counter.c
 create mode 100644 tools/perf/util/bpf_counter.h
 create mode 100644 tools/perf/util/bpf_skel/.gitignore
 create mode 100644 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
 create mode 100644 tools/perf/util/demangle-ocaml.c
 create mode 100644 tools/perf/util/demangle-ocaml.h
 delete mode 100644 tools/perf/util/xyarray.c

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
  # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.11.0.tar.xz
  # dm
   1    73.63 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   2    73.59 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   3    77.58 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   4    83.69 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5    86.68 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6    90.15 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7   110.53 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8   121.67 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9   115.84 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10   121.27 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  11   122.67 alpine:edge                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1
  12    71.67 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  13    86.70 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0
  14    86.06 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20201125 (ALT Sisyphus 10.2.1-alt2) , clang version 10.0.1
  15    68.45 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  16   102.83 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12) , clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  17    22.29 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  18    22.54 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  19    27.98 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  20    33.10 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
  21   100.60 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  22    67.18 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc , clang version 10.0.1
  23    79.83 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  24    84.31 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  25    79.70 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  26    79.22 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  27    34.14 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110
  28    30.51 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-3) 10.2.1 20201224
  29    13.77 debian:experimental-x-mipsel  : FAIL gcc version 10.2.1 20201224 (Debian 10.2.1-3)
    util/map.c: In function 'map__new':
    util/map.c:109:5: error: '%s' directive output may be truncated writing between 1 and 2147483645 bytes into a region of size 4096 [-Werror=format-truncation=]
      109 |    "%s/platforms/%s/arch-%s/usr/lib/%s",
          |     ^~
    In file included from /usr/mipsel-linux-gnu/include/stdio.h:867,
                     from util/symbol.h:11,
                     from util/map.c:2:
    /usr/mipsel-linux-gnu/include/bits/stdio2.h:67:10: note: '__builtin___snprintf_chk' output 32 or more bytes (assuming 4294967321) into a destination of size 4096
       67 |   return __builtin___snprintf_chk (__s, __n, __USE_FORTIFY_LEVEL - 1,
          |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
       68 |        __bos (__s), __fmt, __va_arg_pack ());
          |        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    cc1: all warnings being treated as errors
  30    31.97 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7)
  31    31.53 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  32    72.76 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  33    85.16 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  34    25.99 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710
  35    87.96 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  36    98.33 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  37    98.51 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  38   110.63 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  39   115.91 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  40   119.29 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  41    25.64 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225
  42   122.83 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  43   100.53 fedora:32                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  44    99.71 fedora:33                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
  45   103.42 fedora:34                     : Ok   gcc (GCC) 11.0.0 20210210 (Red Hat 11.0.0-0) , clang version 11.1.0 (Fedora 11.1.0-0.4.rc2.fc34)
  46   103.92 fedora:rawhide                : Ok   gcc (GCC) 11.0.0 20210210 (Red Hat 11.0.0-0) , clang version 11.1.0 (Fedora 11.1.0-0.4.rc2.fc34)
  47    36.54 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.3.0-r1 p3) 9.3.0
  48    72.08 mageia:5                      : Ok   gcc (GCC) 4.9.2 , clang version 3.5.2 (tags/RELEASE_352/final)
  49    88.91 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  50   105.01 manjaro:latest                : Ok   gcc (GCC) 10.2.0 , clang version 10.0.1
  51   229.77 openmandriva:cooker           : Ok   gcc (GCC) 10.2.0 20200723 (OpenMandriva) , OpenMandriva 11.0.0-1 clang version 11.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-11.0.0/clang 63e22714ac938c6b537bd958f70680d3331a2030)
  52   122.13 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53   130.80 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54   120.16 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1
  55   133.31 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  56   117.89 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5 , clang version 3.8.0 (tags/RELEASE_380/final 262553)
  57   113.02 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f55b3d993b32e5c] , clang version 10.0.1
  58    29.08 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1)
  59    33.18 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44.0.3)
  60    98.44 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.1) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  61    29.46 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3 , Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  62    32.20 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
  63    82.96 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  64    27.29 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  65    27.78 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  66    26.32 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  67    26.45 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  68    27.18 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  69    26.76 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
  70    92.98 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  71    29.00 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  72    28.70 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0
  73    24.05 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  74    27.77 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  75    30.24 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  76    30.59 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  77   168.17 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  78    26.74 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  79    28.08 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  80    27.81 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0
  81    76.84 ubuntu:19.10                  : Ok   gcc (Ubuntu 9.2.1-9ubuntu2) 9.2.1 20191008 , clang version 8.0.1-3build1 (tags/RELEASE_801/final)
  82    27.96 ubuntu:19.10-x-alpha          : Ok   alpha-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008
  83    25.33 ubuntu:19.10-x-hppa           : Ok   hppa-linux-gnu-gcc (Ubuntu 9.2.1-9ubuntu1) 9.2.1 20191008
  84    78.19 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1
  85    31.78 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0
  86    79.86 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  87    77.41 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.2.1-6ubuntu1) 10.2.1 20210110 , Ubuntu clang version 11.0.1-2
  $

  # uname -a
  Linux quaco 5.10.7-100.fc32.x86_64 #1 SMP Tue Jan 12 20:25:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  3027ce36ccba perf buildid-cache: Don't skip 16-byte build-ids
  # perf version --build-options
  perf version 5.11.g3027ce36ccba
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
  77: probe libc's inet_pton & backtrace it with ping                 : Ok
  78: Use vfs_getname probe to get syscall args filenames             : Ok
  79: Check Arm CoreSight trace data recording and synthesized samples: Skip
  80: perf stat metrics (shadow stat) test                            : Ok
  81: build id cache operations                                       : Ok
  82: daemon operations                                               : Ok
  83: Add vfs_getname probe to get syscall args filenames             : Ok
  84: Check open filename arg using perf trace + vfs_getname          : Ok
  85: Zstd perf.data compression/decompression                        : Ok

  $ git log --oneline -1
  3027ce36ccbae74f (HEAD -> perf/core) perf buildid-cache: Don't skip 16-byte build-ids
  $ time make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                make_no_newt_O: make NO_NEWT=1
                  make_debug_O: make DEBUG=1
                    make_doc_O: make doc
             make_util_map_o_O: make util/map.o
                   make_help_O: make help
            make_install_bin_O: make install-bin
                make_no_gtk2_O: make NO_GTK2=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_demangle_O: make NO_DEMANGLE=1
              make_with_gtk2_O: make GTK2=1
                 make_perf_o_O: make perf.o
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_clean_all_O: make clean all
               make_no_slang_O: make NO_SLANG=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_libperl_O: make NO_LIBPERL=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                 make_no_sdt_O: make NO_SDT=1
              make_no_libbpf_O: make NO_LIBBPF=1
         make_install_prefix_O: make install prefix=/tmp/krava
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_with_libpfm4_O: make LIBPFM4=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_no_libelf_O: make NO_LIBELF=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                make_install_O: make install
                   make_tags_O: make tags
         make_with_clangllvm_O: make LIBCLANGLLVM=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
           make_no_libpython_O: make NO_LIBPYTHON=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                   make_pure_O: make
                 make_static_O: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
