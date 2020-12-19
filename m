Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5CCC4361B
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Dec 2020 22:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398A923602
	for <linux-perf-users@archiver.kernel.org>; Sat, 19 Dec 2020 22:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgLSWrY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 19 Dec 2020 17:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgLSWrX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 19 Dec 2020 17:47:23 -0500
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Dengcheng Zhu <dzhu@wavecomp.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Peng Fan <fanpeng@loongson.cn>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Wei Li <liwei391@huawei.com>,
        Zheng Zengkai <zhengzengkai@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.11
Date:   Sat, 19 Dec 2020 19:46:48 -0300
Message-Id: <20201219224648.388804-1-acme@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit accefff5b547a9a1d959c7e76ad539bf2480e78b:

  Merge tag 'arm-soc-omap-genpd-5.11' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2020-12-16 16:53:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-2020-12-19

for you to fetch changes up to 2e7f545096f954a9726c9415763dd0bfbcac47e0:

  perf mem: Factor out a function to generate sort order (2020-12-19 17:53:29 -0300)

----------------------------------------------------------------
perf tools changes:

perf record:

  - Fix memory leak when using '--user-regs=?' to list registers.

aarch64 support:

  - Add aarch64 registers to 'perf record's' --user-regs command line option.

aarch64 hw tracing support:

  - Decode memory tagging properties.

  - Improve ARM's auxtrace support.

  - Add support for ARMv8.3-SPE.

perf kvm:

  - Add kvm-stat for arm64.

perf stat:

  - Add --quiet option.

Cleanups:

  - Fixup function names wrt what is in libperf and what is in tools/perf.

Build:

  - Allow building without libbpf in older systems.

New kernel features:

  - Initial support for data/code page size sample type, more to come.

perf annotate:

  - Support MIPS instruction extended support.

perf stack unwinding:

  - Fix separate debug info files when using elfutils' libdw's unwinder.

perf vendor events:

  - Update Intel's Skylake client events to v50.

  - Add JSON metrics for ARM's imx8mm DDR Perf.

  - Support printing metric groups for system PMUs.

perf build id:

  - Prep work for supporting having the build id provided by the
    kernel in PERF_RECORD_MMAP2 metadata events.

perf stat:

  - Support regex pattern in --for-each-cgroup.

pipe mode:

 -  Allow to use stdio functions for pipe mode.

  - Support 'perf report's' --header-only for pipe mode.

   - Support pipe mode display in 'perf evlist'.

Documentation:

  - Update information about CAP_PERFMON.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag at:

https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tag/?h=perf-tools-2020-12-19

Alexandre Truong (1):
      perf tools: Add aarch64 registers to --user-regs

Alexey Budankov (2):
      doc/admin-guide: Note credentials consolidation under CAP_PERFMON
      doc/admin-guide: Document creation of CAP_PERFMON privileged shell

Andi Kleen (1):
      perf stat: Add --quiet option

Andre Przywara (1):
      perf arm_spe: Decode memory tagging properties

Arnaldo Carvalho de Melo (50):
      perf bpf: Enclose libbpf.h include within HAVE_LIBBPF_SUPPORT
      perf tests: Skip the llvm and bpf tests if HAVE_LIBBPF_SUPPORT isn't defined
      perf annotate: Move bpf header inclusion to inside HAVE_LIBBPF_SUPPORT
      perf env: Conditionally compile BPF support code on having HAVE_LIBBPF_SUPPORT
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf evsel: Convert last 'struct evsel' methods to the right evsel__ prefix
      perf evlist: Use the right prefix for 'struct evlist' methods: evlist__set_leader()
      perf evlist: Use the right prefix for 'struct evlist' 'workload' methods
      perf evlist: Use the right prefix for 'struct evlist' stats methods
      perf evlist: Use the right prefix for 'struct evlist' 'toggle' methods
      perf evlist: Use the right prefix for 'struct evlist' 'filter' methods
      perf evlist: Use the right prefix for 'struct evlist' sideband thread methods
      perf evlist: Use the right prefix for 'struct evlist' sample parsing methods
      perf evlist: Use the right prefix for 'struct evlist' 'find' methods
      perf evlist: Ditch unused set/reset sample_bit methods
      perf evlist: Use the right prefix for 'struct evlist' sample id lookup  methods
      perf evlist: Use the right prefix for 'struct evlist' browser methods
      perf evlist: Use the right prefix for 'struct evlist' tracking event methods
      perf evlist: Use the right prefix for 'struct evlist' id_pos methods
      perf evlist: Use the right prefix for 'struct evlist' enable event methods
      perf evlist: Use the right prefix for 'struct evlist' pause/resume methods
      perf evlist: Use the right prefix for 'struct evlist' evsel list methods
      perf evlist: Use the right prefix for 'struct evlist' print methods
      perf evlist: Use the right prefix for 'struct evlist' create maps methods
      perf evlist: Use the right prefix for 'struct evlist' event group methods
      perf evlist: Use the right prefix for 'struct evlist' event selection methods
      perf evlist: Use the right prefix for alternative 'struct evlist' constructors
      perf evlist: Use the right prefix for 'struct evlist' event attribute config methods
      perf evlist: Use the right prefix for 'struct evlist' mmap pages parsing method
      perf evlist: Use the right prefix for 'struct evlist' raw samples methods
      perf evlist: Use the right prefix for 'struct evlist' header methods
      perf evlist: Use the right prefix for 'struct evlist' deliver event method
      perf evlist: Use the right prefix for 'struct evlist' nr_threads method
      perf evlist: Use the right prefix for 'struct evlist' diff methods
      perf evlist: Use the right prefix for 'struct evlist' record methods
      perf evsel: Emit warning about kernel not supporting the data page size sample_type bit
      perf test: Make sample-parsing test aware of PERF_SAMPLE_{CODE,DATA}_PAGE_SIZE
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools headers: Syncronize linux/build_bug.h with the kernel sources
      tools headers UAPI: Sync linux/stat.h with the kernel sources
      tools headers: Get tools's linux/compiler.h closer to the kernel's
      tools headers: Add conditional __has_builtin()
      tools headers: Update linux/ctype.h with the kernel sources
      perf trace beauty: Update copy of linux/socket.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers UAPI: Sync linux/const.h with the kernel headers
      tools headers UAPI: Sync linux/fscrypt.h with the kernel sources
      tools headers UAPI: Sync linux/prctl.h with the kernel sources
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Update asm-generic/unistd.h

Dengcheng Zhu (1):
      perf annotate mips: Add perf arch instructions annotate handlers

Ian Rogers (2):
      perf version: Add a feature for libpfm4
      perf expr: Force encapsulation on expr_id_data

Jan Kratochvil (1):
      perf unwind: Fix separate debug info files when using elfutils' libdw's unwinder

Jin Yao (1):
      perf vendor events: Update Skylake client events to v50

Jiri Olsa (15):
      tools lib: Adopt memchr_inv() from kernel
      perf tools: Add build_id__is_defined function
      perf tools: Add filename__decompress function
      perf build-id: Add check for existing link in buildid dir
      perf tools: Use struct extra_kernel_map in machine__process_kernel_mmap_event
      perf symbols: Try to load vmlinux from buildid database
      perf data: Add is_perf_data function
      perf build-id: Use machine__for_each_dso in perf_session__cache_build_ids
      perf build-id: Add __perf_session__cache_build_ids function
      perf build-id: Add build_id_cache__add function
      tools build: Add missing libcap to test-all.bin target
      perf tools: Add evlist__disable_evsel/evlist__enable_evsel
      perf debug: Add debug_set_file function
      perf tools: Add support to read build id from compressed elf
      perf tools: Reformat record's control fd man text

Joakim Zhang (1):
      perf vendor events: Add JSON metrics for imx8mm DDR Perf

John Garry (11):
      perf jevents: Tidy error handling
      perf jevents: Add test for arch std events
      perf jevents: Add support for an extra directory level
      perf jevents: Add support for system events tables
      perf pmu: Add pmu_id()
      perf pmu: Add pmu_add_sys_aliases()
      perf evlist: Change evlist__splice_list_tail() ordering
      perf metricgroup: Fix metrics using aliases covering multiple PMUs
      perf metricgroup: Split up metricgroup__print()
      perf metricgroup: Support printing metric groups for system PMUs
      perf metricgroup: Support adding metrics for system PMUs

Kajol Jain (1):
      perf test: Fix metric parsing test

Kan Liang (5):
      tools headers UAPI: Update tools's copy of linux/perf_event.h
      perf record: Support new sample type for data page size
      perf script: Support data page size
      perf sort: Add sort option for data page size
      perf mem: Factor out a function to generate sort order

Leo Yan (31):
      perf mem2node: Improve warning if detected no memory nodes
      perf tests tsc: Make tsc testing as a common testing
      perf tests tsc: Add checking helper is_supported()
      perf mem: Search event name with more flexible path
      perf mem: Introduce weak function perf_mem_events__ptr()
      perf mem: Support new memory event PERF_MEM_EVENTS__LOAD_STORE
      perf c2c: Support memory event PERF_MEM_EVENTS__LOAD_STORE
      perf mem: Only initialize memory event for recording
      perf auxtrace: Add itrace option '-M' for memory events
      perf mem: Support AUX trace
      perf c2c: Support AUX trace
      perf mem: Support ARM SPE events
      perf arm-spe: Include bitops.h for BIT() macro
      perf arm-spe: Fix a typo in comment
      perf arm-spe: Refactor payload size calculation
      perf arm-spe: Refactor arm_spe_get_events()
      perf arm-spe: Fix packet length handling
      perf arm-spe: Refactor printing string to buffer
      perf arm-spe: Refactor packet header parsing
      perf arm-spe: Add new function arm_spe_pkt_desc_addr()
      perf arm-spe: Refactor address packet handling
      perf arm_spe: Fixup top byte for data virtual address
      perf arm-spe: Refactor context packet handling
      perf arm-spe: Add new function arm_spe_pkt_desc_counter()
      perf arm-spe: Refactor counter packet handling
      perf arm-spe: Add new function arm_spe_pkt_desc_event()
      perf arm-spe: Refactor event type handling
      perf arm-spe: Remove size condition checking for events
      perf arm-spe: Add new function arm_spe_pkt_desc_op_type()
      perf arm-spe: Refactor operation packet handling
      perf arm-spe: Add more sub classes for operation packet

Namhyung Kim (7):
      perf test: Use generic event for expand_libpfm_events()
      perf stat: Support regex pattern in --for-each-cgroup
      perf trace beauty: Allow header files in a different path
      perf data: Allow to use stdio functions for pipe mode
      perf test: Add shadow stat test
      perf report: Support --header-only for pipe mode
      perf evlist: Support pipe mode display

Nick Thompson (1):
      perf config: Fix example command in manpage to conform to syntax specified in the SYNOPSIS section.

Sergey Senozhatsky (1):
      perf kvm: Add kvm-stat for arm64

Tommi Rantala (1):
      perf test: Implement skip_reason callback for watchpoint tests

Wei Li (1):
      perf arm-spe: Add support for ARMv8.3-SPE

Zheng Zengkai (1):
      perf record: Fix memory leak when using '--user-regs=?' to list registers

 Documentation/admin-guide/perf-security.rst        |   81 +-
 tools/arch/x86/include/asm/cpufeatures.h           |    2 +
 tools/arch/x86/include/asm/disabled-features.h     |    8 +-
 tools/arch/x86/include/asm/msr-index.h             |   12 +-
 tools/build/feature/Makefile                       |    2 +-
 tools/include/linux/build_bug.h                    |    5 +
 tools/include/linux/compiler.h                     |    4 +-
 tools/include/linux/compiler_types.h               |   21 +
 tools/include/linux/ctype.h                        |   17 +-
 tools/include/linux/string.h                       |    1 +
 tools/include/uapi/asm-generic/unistd.h            |    2 +-
 tools/include/uapi/linux/const.h                   |    5 +
 tools/include/uapi/linux/fscrypt.h                 |    5 +-
 tools/include/uapi/linux/perf_event.h              |    6 +-
 tools/include/uapi/linux/prctl.h                   |    5 +
 tools/include/uapi/linux/stat.h                    |    9 +-
 tools/lib/string.c                                 |   58 +
 tools/perf/Documentation/itrace.txt                |    1 +
 tools/perf/Documentation/perf-config.txt           |    2 +-
 tools/perf/Documentation/perf-record.txt           |   19 +-
 tools/perf/Documentation/perf-report.txt           |    1 +
 tools/perf/Documentation/perf-script.txt           |    5 +-
 tools/perf/Documentation/perf-stat.txt             |    9 +-
 tools/perf/arch/arm/util/cs-etm.c                  |    4 +-
 tools/perf/arch/arm64/Makefile                     |    1 +
 tools/perf/arch/arm64/util/Build                   |    3 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    4 +-
 tools/perf/arch/arm64/util/arm64_exception_types.h |   92 +
 tools/perf/arch/arm64/util/kvm-stat.c              |   85 +
 tools/perf/arch/arm64/util/mem-events.c            |   37 +
 tools/perf/arch/arm64/util/perf_regs.c             |   33 +
 tools/perf/arch/mips/Build                         |    2 +-
 tools/perf/arch/mips/annotate/instructions.c       |   46 +
 tools/perf/arch/x86/include/arch-tests.h           |    1 -
 tools/perf/arch/x86/tests/Build                    |    1 -
 tools/perf/arch/x86/tests/arch-tests.c             |    4 -
 tools/perf/arch/x86/tests/intel-cqm.c              |    2 +-
 tools/perf/arch/x86/util/intel-bts.c               |    4 +-
 tools/perf/arch/x86/util/intel-pt.c                |    6 +-
 tools/perf/builtin-annotate.c                      |    4 +-
 tools/perf/builtin-c2c.c                           |   39 +-
 tools/perf/builtin-diff.c                          |    4 +-
 tools/perf/builtin-evlist.c                        |   18 +-
 tools/perf/builtin-ftrace.c                        |   11 +-
 tools/perf/builtin-inject.c                        |    2 +
 tools/perf/builtin-kmem.c                          |    7 +-
 tools/perf/builtin-kvm.c                           |    9 +-
 tools/perf/builtin-mem.c                           |   97 +-
 tools/perf/builtin-record.c                        |   52 +-
 tools/perf/builtin-report.c                        |   34 +-
 tools/perf/builtin-sched.c                         |    6 +-
 tools/perf/builtin-script.c                        |   25 +-
 tools/perf/builtin-stat.c                          |   45 +-
 tools/perf/builtin-top.c                           |   34 +-
 tools/perf/builtin-trace.c                         |   43 +-
 tools/perf/builtin-version.c                       |    1 +
 .../arch/arm64/freescale/imx8mm/sys/ddrc.json      |   39 +
 .../arch/arm64/freescale/imx8mm/sys/metrics.json   |   18 +
 .../perf/pmu-events/arch/test/arch-std-events.json |    8 +
 .../perf/pmu-events/arch/test/test_cpu/cache.json  |    5 +
 tools/perf/pmu-events/arch/x86/skylake/cache.json  | 4100 ++++++++++----------
 .../arch/x86/skylake/floating-point.json           |   76 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |  644 +--
 tools/perf/pmu-events/arch/x86/skylake/memory.json | 2279 +++++------
 tools/perf/pmu-events/arch/x86/skylake/other.json  |   60 +-
 .../perf/pmu-events/arch/x86/skylake/pipeline.json | 1266 +++---
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  271 +-
 .../arch/x86/skylake/virtual-memory.json           |  374 +-
 tools/perf/pmu-events/jevents.c                    |  182 +-
 tools/perf/pmu-events/pmu-events.h                 |    6 +
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/backward-ring-buffer.c            |    4 +-
 tools/perf/tests/bpf.c                             |   12 +-
 tools/perf/tests/builtin-test.c                    |    6 +
 tools/perf/tests/code-reading.c                    |    8 +-
 tools/perf/tests/event-times.c                     |    6 +-
 tools/perf/tests/event_update.c                    |    3 +-
 tools/perf/tests/evsel-tp-sched.c                  |   25 +-
 tools/perf/tests/expand-cgroup.c                   |    9 +-
 tools/perf/tests/keep-tracking.c                   |    2 +-
 tools/perf/tests/llvm.c                            |   30 +-
 tools/perf/tests/mmap-basic.c                      |    6 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    6 +-
 tools/perf/tests/parse-events.c                    |   10 +-
 tools/perf/tests/parse-metric.c                    |    4 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    4 +-
 tools/perf/tests/perf-record.c                     |   18 +-
 tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c |   21 +-
 tools/perf/tests/pmu-events.c                      |   16 +-
 tools/perf/tests/sample-parsing.c                  |    6 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |   80 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    2 +-
 tools/perf/tests/sw-clock.c                        |    2 +-
 tools/perf/tests/switch-tracking.c                 |   18 +-
 tools/perf/tests/task-exit.c                       |   13 +-
 tools/perf/tests/tests.h                           |    3 +
 tools/perf/tests/topology.c                        |    2 +-
 tools/perf/tests/wp.c                              |   21 +-
 tools/perf/trace/beauty/include/linux/socket.h     |    1 +
 tools/perf/trace/beauty/mmap_flags.sh              |    4 +-
 tools/perf/trace/beauty/mmap_prot.sh               |    2 +-
 tools/perf/ui/browsers/hists.c                     |   61 +-
 tools/perf/ui/gtk/gtk.h                            |    5 +-
 tools/perf/ui/gtk/hists.c                          |    6 +-
 tools/perf/util/annotate.c                         |   16 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   59 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   17 -
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |  601 +--
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |  122 +-
 tools/perf/util/arm-spe.c                          |    2 +-
 tools/perf/util/auxtrace.c                         |   19 +-
 tools/perf/util/auxtrace.h                         |    2 +
 tools/perf/util/bpf-event.c                        |    2 +-
 tools/perf/util/bpf-loader.c                       |    3 +-
 tools/perf/util/bpf-loader.h                       |    3 +
 tools/perf/util/build-id.c                         |  127 +-
 tools/perf/util/build-id.h                         |    8 +
 tools/perf/util/cgroup.c                           |  202 +-
 tools/perf/util/data.c                             |   60 +-
 tools/perf/util/data.h                             |   12 +-
 tools/perf/util/debug.c                            |    9 +-
 tools/perf/util/debug.h                            |    2 +
 tools/perf/util/dso.c                              |   45 +-
 tools/perf/util/dso.h                              |    2 +
 tools/perf/util/env.c                              |   15 +-
 tools/perf/util/env.h                              |    4 +-
 tools/perf/util/event.h                            |    4 +
 tools/perf/util/evlist.c                           |  288 +-
 tools/perf/util/evlist.h                           |  136 +-
 tools/perf/util/evsel.c                            |   60 +-
 tools/perf/util/evsel.h                            |    1 +
 tools/perf/util/evswitch.c                         |    4 +-
 tools/perf/util/expr.c                             |   68 +-
 tools/perf/util/expr.h                             |   17 +-
 tools/perf/util/expr.y                             |    2 +-
 tools/perf/util/header.c                           |   56 +-
 tools/perf/util/hist.c                             |    5 +-
 tools/perf/util/hist.h                             |   26 +-
 tools/perf/util/intel-pt.c                         |    3 +-
 tools/perf/util/machine.c                          |   69 +-
 tools/perf/util/map_symbol.h                       |    1 +
 tools/perf/util/mem-events.c                       |   45 +-
 tools/perf/util/mem-events.h                       |    3 +-
 tools/perf/util/mem2node.c                         |    3 +-
 tools/perf/util/metricgroup.c                      |  258 +-
 tools/perf/util/parse-events.c                     |   29 +-
 tools/perf/util/parse-regs-options.c               |    2 +-
 tools/perf/util/perf_event_attr_fprintf.c          |    2 +-
 tools/perf/util/pmu.c                              |   96 +
 tools/perf/util/pmu.h                              |    3 +
 tools/perf/util/python.c                           |    4 +-
 tools/perf/util/record.c                           |    9 +-
 tools/perf/util/record.h                           |    1 +
 tools/perf/util/s390-cpumsf.c                      |    6 +-
 tools/perf/util/s390-sample-raw.c                  |    5 +-
 tools/perf/util/sample-raw.c                       |    4 +-
 tools/perf/util/sample-raw.h                       |    7 +-
 tools/perf/util/session.c                          |   57 +-
 tools/perf/util/sideband_evlist.c                  |   14 +-
 tools/perf/util/sort.c                             |   32 +-
 tools/perf/util/sort.h                             |    1 +
 tools/perf/util/stat-display.c                     |    8 +-
 tools/perf/util/stat.c                             |   20 +-
 tools/perf/util/stat.h                             |   21 +-
 tools/perf/util/symbol-elf.c                       |   37 +-
 tools/perf/util/symbol.c                           |   16 +
 tools/perf/util/synthetic-events.c                 |   10 +-
 tools/perf/util/unwind-libdw.c                     |   32 +-
 168 files changed, 7686 insertions(+), 5892 deletions(-)
 create mode 100644 tools/include/linux/compiler_types.h
 create mode 100644 tools/perf/arch/arm64/util/arm64_exception_types.h
 create mode 100644 tools/perf/arch/arm64/util/kvm-stat.c
 create mode 100644 tools/perf/arch/arm64/util/mem-events.c
 create mode 100644 tools/perf/arch/mips/annotate/instructions.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx8mm/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/test/arch-std-events.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/cache.json
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (91%)
 create mode 100755 tools/perf/tests/shell/stat+shadow_stat.sh
