Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238FCC433B4
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 21:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 042C26144E
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Apr 2021 21:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbhD2VQe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Apr 2021 17:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237247AbhD2VQV (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Apr 2021 17:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EDEC61441;
        Thu, 29 Apr 2021 21:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619730934;
        bh=C1uWWKg9+5wYEdyvVUnejZfItYLdX7BohXCB8f5Jmkg=;
        h=From:To:Cc:Subject:Date:From;
        b=cY2GtSq7DYBhryPenUgSc47myyJhGLocgTfJXi6Dd8e+dTO7DAHHXZ0UyhMDKocYT
         NYe5yo/s2CyiUJi28r3CFlpbGsSFVoOWNDylhiTGKNW2CfLqRpi7oge+8KLTL7cBpm
         3c6Bx6FQAmfIO1wqrdePn+p/RfI5TRM2ilcMw7RHtiJlCVmpwaoB2O2HroygUzmytn
         OSJnGt9vfqP3v/XYZHixc17VKm8S9J/eLpRVZ0MiVnuWrFrvHozmPLVX/pBq1PgqCy
         2Cip++NMhRp3Zw+9+me8oJgp3Y+6EqmieCbJEtokEzmo6i8CRyBV3viJP/2PYtp+3h
         wGHuARNFtQ6lQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Archer Yan <ayan@wavecomp.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Changbin Du <changbin.du@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Fabian Hemmer <copy@copy.sh>, Ian Rogers <irogers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>, Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        Mike Leach <mike.leach@linaro.org>,
        Nicholas Fraser <nfraser@codeweavers.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ray Kinsella <mdr@ashroe.eu>, Rob Herring <robh@kernel.org>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Song Liu <songliubraving@fb.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Vitaly Chikunov <vt@altlinux.org>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Xiong Zhenwu <xiong.zhenwu@zte.com.cn>,
        Yang Jihong <yangjihong1@huawei.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.13
Date:   Thu, 29 Apr 2021 18:15:16 -0300
Message-Id: <20210429211516.2748106-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.3
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


The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:

  Linux 5.12 (2021-04-25 13:49:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.13-2021-04-29

for you to fetch changes up to c6e3bf437184d41d885ba679eab0ddd43f95db56:

  perf build: Defer printing detected features to the end of all feature checks (2021-04-29 11:22:33 -0300)

----------------------------------------------------------------
perf tools changes for v5.13: 1st batch

perf stat:

- Add support for hybrid PMUs to support systems such as Intel Alderlake
  and its BIG/little core/atom cpus.

- Introduce 'bperf' to share hardware PMCs with BPF.

- New --iostat option to collect and present IO stats on Intel hardware.

  This functionality is based on recently introduced sysfs attributes
  for Intel® Xeon® Scalable processor family (code name Skylake-SP):

    commit bb42b3d39781d7fc ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")

  It is intended to provide four I/O performance metrics in MB per each
  PCIe root port:

   - Inbound Read: I/O devices below root port read from the host memory
   - Inbound Write: I/O devices below root port write to the host memory
   - Outbound Read: CPU reads from I/O devices below root port
   - Outbound Write: CPU writes to I/O devices below root port

- Align CSV output for summary.

- Clarify --null use cases: Assess raw overhead of 'perf stat' or
  measure just wall clock time.

- Improve readability of shadow stats.

perf record:

- Change the COMM when starting tha workload so that --exclude-perf
  doesn't seem to be not honoured.

- Improve 'Workload failed' message printing events + what was exec'ed.

- Fix cross-arch support for TIME_CONV.

perf report:

- Add option to disable raw event ordering.

- Dump the contents of PERF_RECORD_TIME_CONV in 'perf report -D'.

- Improvements to --stat output, that shows information about PERF_RECORD_ events.

- Preserve identifier id in OCaml demangler.

perf annotate:

- Show full source location with 'l' hotkey in the 'perf annotate' TUI.

- Add line number like in TUI and source location at EOL to the 'perf annotate' --stdio mode.

- Add --demangle and --demangle-kernel to 'perf annotate'.

- Allow configuring annotate.demangle{,_kernel} in 'perf config'.

- Fix sample events lost in stdio mode.

perf data:

- Allow converting a perf.data file to JSON.

libperf:

- Add support for user space counter access.

- Update topdown documentation to permit rdpmc calls.

perf test:

- Add 'perf test' for 'perf stat' CSV output.

- Add 'perf test' entries to test the hybrid PMU support.

- Cleanup 'perf test daemon' if its 'perf test' is interrupted.

- Handle metric reuse in pmu-events parsing 'perf test' entry.

- Add test for PE executable support.

- Add timeout for wait for daemon start in its 'perf test' entries.

Build:

- Enable libtraceevent dynamic linking.

- Improve feature detection output.

- Fix caching of feature checks caching.

- First round of updates for tools copies of kernel headers.

- Enable warnings when compiling BPF programs.

Vendor specific events:

Intel:

- Add missing skylake & icelake model numbers.

arm64:

- Add Hisi hip08 L1, L2 and L3 metrics.

- Add Fujitsu A64FX PMU events.

PowerPC:

- Initial JSON/events list for power10 platform.

- Remove unsupported power9 metrics.

AMD:

- Add Zen3 events.

- Fix broken L2 Cache Hits from L2 HWPF metric.

- Use lowercases for all the eventcodes and umasks.

Hardware tracing:

arm64:

- Update CoreSight ETM metadata format.

- Fix bitmap for CS-ETM option.

- Support PID tracing in config.

- Detect pid in VMID for kernel running at EL2.

Arch specific:

MIPS:

- Support MIPS unwinding and dwarf-regs.

- Generate mips syscalls_n64.c syscall table.

PowerPC:

- Add support for PERF_SAMPLE_WEIGH_STRUCT on PowerPC.

- Support pipeline stage cycles for powerpc.

libbeauty:

- Fix fsconfig generator.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Alexander Antonov (4):
      perf stat: Basic support for iostat in perf
      perf stat: Helper functions for PCIe root ports list in iostat mode
      perf stat: Enable iostat mode for x86 platforms
      perf: Update .gitignore file

Arnaldo Carvalho de Melo (20):
      tools headers UAPI: Update tools's copy of drm.h headers
      tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
      tools headers UAPI: Sync openat2.h with the kernel sources
      perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
      tools headers UAPI s390: Sync ptrace.h kernel headers
      tools headers UAPI: Sync kvm.h headers with the kernel sources
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf symbols: Fix dso__fprintf_symbols_by_name() to return the number of printed chars
      perf script: Fixup 'struct evsel_script' method prefix
      perf stat: Fixup __perf_stat_evsel__is() prefix
      perf evlist: Change the COMM when preparing the workload
      perf stat: Elaborate use cases for the -n/--null command line option
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf evlist: Add a method to return the list of evsels as a string
      perf record: Improve 'Workload failed' message printing events + what was exec'ed
      perf tools: Add a build-test variant to use in builds from a tarball
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools build: Allow deferring printing the results of feature detection
      perf build: Defer printing detected features to the end of all feature checks

Athira Rajeev (4):
      perf sort: Add dynamic headers for perf report columns
      perf powerpc: Add support for PERF_SAMPLE_WEIGHT_STRUCT
      perf tools: Support pipeline stage cycles for powerpc
      perf sort: Display sort dimension p_stage_cyc only on supported archs

Changbin Du (1):
      perf stat: Improve readability of shadow stats

Fabian Hemmer (1):
      perf tools: Preserve identifier id in OCaml demangler

Ian Rogers (9):
      perf docs: Add man pages to see also
      perf skel: Remove some unused variables.
      perf tools: Enable warnings when compiling BPF programs
      perf bpf: Minor whitespace cleanup.
      tools include: Add __sum16 and __wsum definitions.
      perf test: Remove unused argument
      perf test: Cleanup daemon if test is interrupted.
      perf test: Add 30s timeout for wait for daemon start.
      perf arm64: Fix off-by-one directory paths.

Ingo Molnar (1):
      perf tools: Fix various typos in comments

Jiapeng Chong (3):
      perf metric: Remove unneeded semicolon
      perf tools: use ARRAY_SIZE
      perf machine: Assign boolean values to a bool variable

Jin Yao (30):
      perf report: Create option to disable raw event ordering
      perf stat: Align CSV output for summary mode
      perf test: Add CSV summary test
      perf vendor events intel: Add missing skylake & icelake model numbers
      tools headers uapi: Update tools's copy of linux/perf_event.h
      perf jevents: Support unit value "cpu_core" and "cpu_atom"
      perf pmu: Simplify arguments of __perf_pmu__new_alias
      perf pmu: Save pmu name
      perf pmu: Save detected hybrid pmus to a global pmu list
      perf pmu: Add hybrid helper functions
      perf stat: Uniquify hybrid event name
      perf parse-events: Create two hybrid hardware events
      perf parse-events: Create two hybrid cache events
      perf parse-events: Create two hybrid raw events
      perf parse-events: Compare with hybrid pmu name
      perf parse-events: Support event inside hybrid pmu
      perf record: Create two hybrid 'cycles' events by default
      perf stat: Add default hybrid events
      perf stat: Filter out unmatched aggregation for hybrid event
      perf stat: Warn group events from different hybrid PMU
      perf record: Uniquify hybrid event name
      perf tests: Add hybrid cases for 'Parse event definition strings' test
      perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
      perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
      perf tests: Support 'Track with sched_switch' test for hybrid
      perf tests: Support 'Parse and process metrics' test for hybrid
      perf tests: Support 'Session topology' test for hybrid
      perf tests: Support 'Convert perf time to TSC' test for hybrid
      perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
      perf Documentation: Document intel-hybrid support

Jiri Olsa (1):
      perf build: Regenerate the FEATURE_DUMP file after extra feature checks

John Garry (6):
      perf metricgroup: Make find_metric() public with name change
      perf test: Handle metric reuse in pmu-events parsing test
      perf pmu: Add pmu_events_map__find() function to find the common PMU map for the system
      perf vendor events arm64: Add Hisi hip08 L1 metrics
      perf vendor events arm64: Add Hisi hip08 L2 metrics
      perf vendor events arm64: Add Hisi hip08 L3 metrics

Kajol Jain (1):
      perf vendor events: Initial JSON/events list for power10 platform

Leo Yan (6):
      tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
      perf cs-etm: Add helper cs_etm__get_pid_fmt()
      perf tools: Change fields type in perf_record_time_conv
      perf jit: Let convert_timestamp() to be backwards-compatible
      perf session: Add swap operation for event TIME_CONV
      perf session: Dump PERF_RECORD_TIME_CONV event

Martin Liska (2):
      perf config: Add annotate.demangle{,_kernel}
      perf annotate: Show full source location with 'l' hotkey

Martin Liška (2):
      perf annotate: Add --demangle and --demangle-kernel
      perf annotate: Add line number like in TUI and source location at EOL

Michael Petlan (1):
      perf tools: Enable libtraceevent dynamic linking

Mike Leach (1):
      perf cs-etm: Update ETM metadata format

Namhyung Kim (6):
      perf top: Use evlist->events_stat to count events
      perf hists: Split hists_stats from events_stats
      perf report: Show event sample counts in --stat output
      perf report: Add --skip-empty option to suppress 0 event stat
      perf report: Make --skip-empty as default
      perf report: Print percentage of each event statistics

Nicholas Fraser (2):
      perf buildid-cache: Add test for PE executable
      perf data: Add JSON export

Paul A. Clarke (1):
      perf vendor events power9: Remove unsupported metrics

Ray Kinsella (1):
      perf tools: Update topdown documentation to permit rdpmc calls

Rob Herring (5):
      tools include: Add an initial math64.h
      libperf: Add evsel mmap support
      libperf tests: Add support for verbose printing
      libperf: Add support for user space counter access
      libperf xyarray: Add bounds checks to xyarray__entry()

Shunsuke Nakamura (2):
      perf vendor events arm64: Add more common and uarch events
      perf vendor events arm64: Add Fujitsu A64FX pmu event

Smita Koralahalli (4):
      perf vendor events amd: Fix broken L2 Cache Hits from L2 HWPF metric
      perf vendor events amd: Use lowercases for all the eventcodes and umasks
      perf vendor events amd: Use 0x%02x format for event code and umask
      perf vendor events amd: Add Zen3 events

Song Liu (8):
      perf stat: Introduce 'bperf' to share hardware PMCs with BPF
      perf stat: Measure 't0' and 'ref_time' after enable_counters()
      perf test: Add a shell test for 'perf stat --bpf-counters' new option
      perf util: Move bpf_perf definitions to a libperf header
      perf bpf: check perf_attr_map is compatible with the perf binary
      perf stat: Introduce config stat.bpf-counter-events
      perf stat: Introduce ':b' modifier
      perf stat: Introduce bpf_counter_ops->disable()

Suzuki K Poulose (3):
      perf cs-etm: Fix bitmap for option
      perf cs-etm: Support PID tracing in config
      perf cs-etm: Detect pid in VMID for kernel running at EL2

Tiezhu Yang (3):
      perf tools: Support MIPS unwinding and dwarf-regs
      perf tools: Generate mips syscalls_n64.c syscall table
      MAINTAINERS: Add Mailing list and Web-page for PERFORMANCE EVENTS SUBSYSTEM

Vitaly Chikunov (1):
      perf beauty: Fix fsconfig generator

Wan Jiabing (4):
      perf tools: Remove duplicate struct forward declarations
      perf daemon: Remove duplicate includes
      perf evsel: Remove duplicate 'struct target' forward declaration
      perf mem-events: Remove unnecessary 'struct mem_info' forward declaration

Xiong Zhenwu (1):
      perf bench: Fix misspellings using codespell

Yang Jihong (1):
      perf annotate: Fix sample events lost in stdio mode

Zhen Lei (1):
      perf data: Fix error return code in perf_data__create_dir()

 MAINTAINERS                                        |   2 +
 tools/build/Makefile.feature                       |  28 +-
 tools/build/feature/Makefile                       |   4 +
 tools/build/feature/test-libtraceevent.c           |  12 +
 tools/include/linux/math64.h                       |  75 +++
 tools/include/linux/types.h                        |   3 +
 tools/include/uapi/linux/perf_event.h              |  15 +
 tools/lib/perf/Documentation/libperf.txt           |   3 +
 tools/lib/perf/evsel.c                             |  80 +++
 tools/lib/perf/include/internal/evsel.h            |   1 +
 tools/lib/perf/include/internal/mmap.h             |   3 +
 tools/lib/perf/include/internal/tests.h            |  32 ++
 tools/lib/perf/include/internal/xyarray.h          |   9 +-
 tools/lib/perf/include/perf/bpf_perf.h             |  31 ++
 tools/lib/perf/include/perf/event.h                |   7 +-
 tools/lib/perf/include/perf/evsel.h                |   3 +
 tools/lib/perf/libperf.map                         |   3 +
 tools/lib/perf/mmap.c                              |  88 ++++
 tools/lib/perf/tests/Makefile                      |   6 +-
 tools/lib/perf/tests/test-evsel.c                  |  66 +++
 tools/perf/.gitignore                              |   1 +
 tools/perf/Documentation/intel-hybrid.txt          | 214 ++++++++
 tools/perf/Documentation/perf-annotate.txt         |   7 +
 tools/perf/Documentation/perf-buildid-cache.txt    |   2 +-
 tools/perf/Documentation/perf-config.txt           |  11 +
 tools/perf/Documentation/perf-data.txt             |   5 +-
 tools/perf/Documentation/perf-iostat.txt           |  88 ++++
 tools/perf/Documentation/perf-record.txt           |   1 +
 tools/perf/Documentation/perf-report.txt           |  10 +-
 tools/perf/Documentation/perf-stat.txt             |  29 +-
 tools/perf/Documentation/perf-top.txt              |   2 +-
 tools/perf/Documentation/perf.txt                  |  12 +
 tools/perf/Documentation/topdown.txt               |  18 +
 tools/perf/Makefile                                |   5 +-
 tools/perf/Makefile.config                         |  31 +-
 tools/perf/Makefile.perf                           |  16 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  78 ++-
 tools/perf/arch/arm64/util/Build                   |   1 +
 tools/perf/arch/arm64/util/kvm-stat.c              |   4 +-
 tools/perf/arch/arm64/util/machine.c               |   6 +-
 tools/perf/arch/arm64/util/perf_regs.c             |   2 +-
 tools/perf/arch/arm64/util/pmu.c                   |  25 +
 tools/perf/arch/arm64/util/unwind-libunwind.c      |   4 +-
 tools/perf/arch/mips/Makefile                      |  22 +
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 ++
 .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  | 358 ++++++++++++++
 tools/perf/arch/mips/include/dwarf-regs-table.h    |  31 ++
 tools/perf/arch/mips/include/perf_regs.h           |  84 ++++
 tools/perf/arch/mips/util/Build                    |   3 +
 tools/perf/arch/mips/util/dwarf-regs.c             |  38 ++
 tools/perf/arch/mips/util/perf_regs.c              |   6 +
 tools/perf/arch/mips/util/unwind-libunwind.c       |  22 +
 tools/perf/arch/powerpc/util/Build                 |   2 +
 tools/perf/arch/powerpc/util/event.c               |  53 ++
 tools/perf/arch/powerpc/util/evsel.c               |   8 +
 tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +-
 tools/perf/arch/powerpc/util/utils_header.h        |   2 +-
 tools/perf/arch/x86/tests/bp-modify.c              |   2 +-
 tools/perf/arch/x86/util/Build                     |   1 +
 tools/perf/arch/x86/util/iostat.c                  | 470 ++++++++++++++++++
 tools/perf/arch/x86/util/perf_regs.c               |   4 +-
 tools/perf/bench/epoll-wait.c                      |   4 +-
 tools/perf/bench/inject-buildid.c                  |   2 +-
 tools/perf/bench/numa.c                            |   2 +-
 tools/perf/builtin-annotate.c                      |  41 +-
 tools/perf/builtin-daemon.c                        |   3 -
 tools/perf/builtin-data.c                          |  26 +-
 tools/perf/builtin-diff.c                          |   2 +-
 tools/perf/builtin-lock.c                          |   2 +-
 tools/perf/builtin-record.c                        |  55 ++-
 tools/perf/builtin-report.c                        |  43 +-
 tools/perf/builtin-sched.c                         |   2 +-
 tools/perf/builtin-script.c                        |  22 +-
 tools/perf/builtin-stat.c                          | 130 ++++-
 tools/perf/builtin-top.c                           |  22 +-
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/command-list.txt                        |   1 +
 tools/perf/examples/bpf/augmented_raw_syscalls.c   |   4 +-
 tools/perf/jvmti/jvmti_agent.c                     |   4 +-
 tools/perf/perf-iostat.sh                          |  12 +
 .../arch/arm64/armv8-common-and-microarch.json     | 228 +++++++++
 .../arch/arm64/fujitsu/a64fx/branch.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 +++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 128 +++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   5 +
 .../arch/arm64/fujitsu/a64fx/exception.json        |  29 ++
 .../arch/arm64/fujitsu/a64fx/instruction.json      | 131 +++++
 .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
 .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 +++++++
 .../arch/arm64/fujitsu/a64fx/pipeline.json         | 194 ++++++++
 .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 110 +++++
 .../arch/arm64/hisilicon/hip08/metrics.json        | 233 +++++++++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   1 +
 .../pmu-events/arch/powerpc/power10/cache.json     |  47 ++
 .../arch/powerpc/power10/floating_point.json       |   7 +
 .../pmu-events/arch/powerpc/power10/frontend.json  | 217 ++++++++
 .../pmu-events/arch/powerpc/power10/locks.json     |  12 +
 .../pmu-events/arch/powerpc/power10/marked.json    | 147 ++++++
 .../pmu-events/arch/powerpc/power10/memory.json    | 192 ++++++++
 .../pmu-events/arch/powerpc/power10/others.json    | 297 +++++++++++
 .../pmu-events/arch/powerpc/power10/pipeline.json  | 297 +++++++++++
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |  22 +
 .../arch/powerpc/power10/translation.json          |  57 +++
 .../pmu-events/arch/powerpc/power8/metrics.json    |  12 +-
 .../pmu-events/arch/powerpc/power9/metrics.json    | 134 +----
 tools/perf/pmu-events/arch/x86/amdzen1/cache.json  |  48 +-
 tools/perf/pmu-events/arch/x86/amdzen1/core.json   |  12 +-
 .../arch/x86/amdzen1/floating-point.json           |  42 +-
 tools/perf/pmu-events/arch/x86/amdzen1/memory.json |  42 +-
 tools/perf/pmu-events/arch/x86/amdzen1/other.json  |  12 +-
 .../pmu-events/arch/x86/amdzen1/recommended.json   |   8 +-
 tools/perf/pmu-events/arch/x86/amdzen2/branch.json |   8 +-
 tools/perf/pmu-events/arch/x86/amdzen2/cache.json  |  60 +--
 tools/perf/pmu-events/arch/x86/amdzen2/core.json   |  12 +-
 .../arch/x86/amdzen2/floating-point.json           |  42 +-
 tools/perf/pmu-events/arch/x86/amdzen2/memory.json |  86 ++--
 tools/perf/pmu-events/arch/x86/amdzen2/other.json  |  20 +-
 .../pmu-events/arch/x86/amdzen2/recommended.json   |   8 +-
 tools/perf/pmu-events/arch/x86/amdzen3/branch.json |  53 ++
 tools/perf/pmu-events/arch/x86/amdzen3/cache.json  | 402 +++++++++++++++
 tools/perf/pmu-events/arch/x86/amdzen3/core.json   | 137 ++++++
 .../pmu-events/arch/x86/amdzen3/data-fabric.json   |  98 ++++
 .../arch/x86/amdzen3/floating-point.json           | 139 ++++++
 tools/perf/pmu-events/arch/x86/amdzen3/memory.json | 428 ++++++++++++++++
 tools/perf/pmu-events/arch/x86/amdzen3/other.json  | 103 ++++
 .../pmu-events/arch/x86/amdzen3/recommended.json   | 214 ++++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   5 +-
 tools/perf/pmu-events/jevents.c                    |   4 +-
 tools/perf/scripts/python/netdev-times.py          |   2 +-
 tools/perf/tests/attr.c                            |   4 +
 tools/perf/tests/bp_signal.c                       |   6 +-
 tools/perf/tests/code-reading.c                    |   2 +-
 tools/perf/tests/demangle-ocaml-test.c             |   8 +-
 tools/perf/tests/evsel-roundtrip-name.c            |  19 +-
 tools/perf/tests/hists_cumulate.c                  |   4 +-
 tools/perf/tests/hists_filter.c                    |  14 +-
 tools/perf/tests/make                              |  22 +-
 tools/perf/tests/parse-events.c                    | 173 ++++++-
 tools/perf/tests/parse-metric.c                    |  12 +-
 tools/perf/tests/perf-time-to-tsc.c                |  12 +
 tools/perf/tests/pmu-events.c                      |  83 +++-
 tools/perf/tests/shell/buildid.sh                  |  65 ++-
 tools/perf/tests/shell/daemon.sh                   |  54 +-
 tools/perf/tests/shell/stat+csv_summary.sh         |  31 ++
 tools/perf/tests/shell/stat+shadow_stat.sh         |   3 +
 tools/perf/tests/shell/stat_bpf_counters.sh        |  31 ++
 tools/perf/tests/switch-tracking.c                 |   6 +-
 tools/perf/tests/topology.c                        |  15 +-
 tools/perf/trace/beauty/fsconfig.sh                |   7 +-
 tools/perf/trace/beauty/include/linux/socket.h     |   2 +-
 tools/perf/ui/browsers/annotate.c                  |  27 +-
 tools/perf/ui/browsers/hists.c                     |  19 +-
 tools/perf/ui/stdio/hist.c                         |  15 +-
 tools/perf/util/Build                              |   5 +
 tools/perf/util/annotate.c                         |  46 +-
 tools/perf/util/annotate.h                         |   2 +
 tools/perf/util/bpf-loader.c                       |   2 +-
 tools/perf/util/bpf_counter.c                      | 544 ++++++++++++++++++++-
 tools/perf/util/bpf_counter.h                      |   9 +-
 tools/perf/util/bpf_skel/bperf.h                   |  14 +
 tools/perf/util/bpf_skel/bperf_follower.bpf.c      |  69 +++
 tools/perf/util/bpf_skel/bperf_leader.bpf.c        |  46 ++
 tools/perf/util/bpf_skel/bperf_u.h                 |  14 +
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c   |   3 +-
 tools/perf/util/call-path.h                        |   2 +-
 tools/perf/util/callchain.c                        |   2 +-
 tools/perf/util/config.c                           |   9 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  40 +-
 tools/perf/util/cs-etm.c                           | 285 +++++++++--
 tools/perf/util/cs-etm.h                           |  36 +-
 tools/perf/util/data-convert-bt.c                  |   4 +-
 tools/perf/util/data-convert-bt.h                  |  11 -
 tools/perf/util/data-convert-json.c                | 384 +++++++++++++++
 tools/perf/util/data-convert.h                     |  10 +
 tools/perf/util/demangle-java.c                    |   4 +-
 tools/perf/util/demangle-ocaml.c                   |  12 -
 tools/perf/util/dso.h                              |   2 +-
 tools/perf/util/dwarf-aux.c                        |   6 +-
 tools/perf/util/dwarf-aux.h                        |   2 +-
 tools/perf/util/dwarf-regs.c                       |   3 +
 tools/perf/util/event.h                            |   3 +
 tools/perf/util/events_stats.h                     |  15 +-
 tools/perf/util/evlist-hybrid.c                    |  88 ++++
 tools/perf/util/evlist-hybrid.h                    |  14 +
 tools/perf/util/evlist.c                           |  38 +-
 tools/perf/util/evlist.h                           |   2 +
 tools/perf/util/evsel.c                            |  38 +-
 tools/perf/util/evsel.h                            |  34 +-
 tools/perf/util/expr.h                             |   2 +-
 tools/perf/util/header.c                           |  18 +-
 tools/perf/util/hist.c                             |  37 +-
 tools/perf/util/hist.h                             |   8 +-
 tools/perf/util/intel-pt.c                         |   2 +-
 tools/perf/util/iostat.c                           |  53 ++
 tools/perf/util/iostat.h                           |  47 ++
 tools/perf/util/jitdump.c                          |  30 +-
 tools/perf/util/levenshtein.c                      |   2 +-
 tools/perf/util/libunwind/arm64.c                  |   2 +-
 tools/perf/util/libunwind/x86_32.c                 |   2 +-
 tools/perf/util/llvm-utils.c                       |   2 +-
 tools/perf/util/machine.c                          |  12 +-
 tools/perf/util/map.h                              |   4 +-
 tools/perf/util/mem-events.h                       |   3 +-
 tools/perf/util/metricgroup.c                      |  14 +-
 tools/perf/util/metricgroup.h                      |   4 +-
 tools/perf/util/parse-events-hybrid.c              | 178 +++++++
 tools/perf/util/parse-events-hybrid.h              |  23 +
 tools/perf/util/parse-events.c                     | 115 ++++-
 tools/perf/util/parse-events.h                     |   9 +-
 tools/perf/util/parse-events.l                     |   2 +-
 tools/perf/util/parse-events.y                     |   9 +-
 tools/perf/util/pmu-hybrid.c                       |  89 ++++
 tools/perf/util/pmu-hybrid.h                       |  22 +
 tools/perf/util/pmu.c                              |  73 ++-
 tools/perf/util/pmu.h                              |   8 +
 tools/perf/util/probe-event.c                      |   4 +-
 tools/perf/util/probe-finder.c                     |   6 +-
 tools/perf/util/python-ext-sources                 |   2 +
 tools/perf/util/python.c                           |   6 +
 tools/perf/util/s390-cpumsf.c                      |  10 +-
 tools/perf/util/s390-sample-raw.c                  |   4 +-
 .../util/scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                          |  41 +-
 tools/perf/util/session.h                          |   3 +-
 tools/perf/util/sort.c                             |  60 ++-
 tools/perf/util/sort.h                             |   2 +
 tools/perf/util/stat-display.c                     |  64 ++-
 tools/perf/util/stat-shadow.c                      |  21 +-
 tools/perf/util/stat.c                             |   3 +-
 tools/perf/util/stat.h                             |   8 +-
 tools/perf/util/strbuf.h                           |   2 +-
 tools/perf/util/strfilter.h                        |   4 +-
 tools/perf/util/symbol-elf.c                       |   2 +-
 tools/perf/util/symbol_fprintf.c                   |   2 +-
 tools/perf/util/synthetic-events.c                 |   4 +-
 tools/perf/util/syscalltbl.c                       |   4 +
 tools/perf/util/target.h                           |   7 +-
 tools/perf/util/thread-stack.h                     |   1 -
 tools/perf/util/tsc.c                              |  30 ++
 tools/perf/util/tsc.h                              |   4 +
 tools/perf/util/units.c                            |  21 +-
 tools/perf/util/units.h                            |   1 +
 tools/perf/util/unwind-libunwind-local.c           |   2 +-
 244 files changed, 9952 insertions(+), 883 deletions(-)
 create mode 100644 tools/build/feature/test-libtraceevent.c
 create mode 100644 tools/include/linux/math64.h
 create mode 100644 tools/lib/perf/include/perf/bpf_perf.h
 create mode 100644 tools/perf/Documentation/intel-hybrid.txt
 create mode 100644 tools/perf/Documentation/perf-iostat.txt
 create mode 100644 tools/perf/arch/arm64/util/pmu.c
 create mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
 create mode 100644 tools/perf/arch/mips/include/dwarf-regs-table.h
 create mode 100644 tools/perf/arch/mips/include/perf_regs.h
 create mode 100644 tools/perf/arch/mips/util/Build
 create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/mips/util/perf_regs.c
 create mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 create mode 100644 tools/perf/arch/powerpc/util/event.c
 create mode 100644 tools/perf/arch/powerpc/util/evsel.c
 create mode 100644 tools/perf/arch/x86/util/iostat.c
 create mode 100644 tools/perf/perf-iostat.sh
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/cache.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/floating_point.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/locks.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/marked.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/memory.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/others.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/pmc.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/translation.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
 create mode 100755 tools/perf/tests/shell/stat+csv_summary.sh
 create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
 create mode 100644 tools/perf/util/bpf_skel/bperf.h
 create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/bperf_u.h
 delete mode 100644 tools/perf/util/data-convert-bt.h
 create mode 100644 tools/perf/util/data-convert-json.c
 create mode 100644 tools/perf/util/evlist-hybrid.c
 create mode 100644 tools/perf/util/evlist-hybrid.h
 create mode 100644 tools/perf/util/iostat.c
 create mode 100644 tools/perf/util/iostat.h
 create mode 100644 tools/perf/util/parse-events-hybrid.c
 create mode 100644 tools/perf/util/parse-events-hybrid.h
 create mode 100644 tools/perf/util/pmu-hybrid.c
 create mode 100644 tools/perf/util/pmu-hybrid.h
