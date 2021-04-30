Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D606C433B4
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 18:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CD76145D
	for <linux-perf-users@archiver.kernel.org>; Fri, 30 Apr 2021 18:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhD3SyV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 14:54:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229954AbhD3SyU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 30 Apr 2021 14:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7BA69613B4;
        Fri, 30 Apr 2021 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619808812;
        bh=SX2BzthhR7//0R2ej6J9hWxQph+Qzd3WTK9EUTmA8Co=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XmNzmkjBRzqnHNFPL9YY3tAxsdgN8PNr6fh0uaPEhaXpgHeUM2VAdGjIkR/eHnbRA
         fOHct2p0cVHkKCharvXm5KnuuySv3I9Ydy25bsbFJgno9DfcbcAB2oAsljU3paefs7
         IRKjw4u/HUB+hzR4tJxRuR2JpSrnRuYaqU8LjN8lPSqsnUhrlK5bV9zB7AjeM2ux5h
         gmO9Mg3/PPfqwx0WUOP2NIqVc/5KlLyBaIY6qAEYHQzeo5D95UdR8wfa+NRjheSd5G
         VrOGt8D14gt1/IIff+nkD6+V6XqXbb292UmQsZeTQ1VPZABHr9PRaH4drEn5XLMjsY
         4zORF7vEPp7Rw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8E0814034C; Fri, 30 Apr 2021 15:53:27 -0300 (-03)
Date:   Fri, 30 Apr 2021 15:53:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
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
        Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
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
Subject: Re: [GIT PULL] perf tools changes for v5.13
Message-ID: <YIxSJ7bdtjv4wHok@kernel.org>
References: <20210429211516.2748106-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210429211516.2748106-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Apr 29, 2021 at 06:15:16PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Linus,
> 
> 	Please consider pulling,

Forgot to attach the test results to the end of the message, all passed,
so just for the record, they are at the end of _this_ message.

- Arnaldo
> 
> The following changes since commit 9f4ad9e425a1d3b6a34617b8ea226d56a119a717:
> 
>   Linux 5.12 (2021-04-25 13:49:08 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.13-2021-04-29
> 
> for you to fetch changes up to c6e3bf437184d41d885ba679eab0ddd43f95db56:
> 
>   perf build: Defer printing detected features to the end of all feature checks (2021-04-29 11:22:33 -0300)
> 
> ----------------------------------------------------------------
> perf tools changes for v5.13: 1st batch
> 
> perf stat:
> 
> - Add support for hybrid PMUs to support systems such as Intel Alderlake
>   and its BIG/little core/atom cpus.
> 
> - Introduce 'bperf' to share hardware PMCs with BPF.
> 
> - New --iostat option to collect and present IO stats on Intel hardware.
> 
>   This functionality is based on recently introduced sysfs attributes
>   for Intel® Xeon® Scalable processor family (code name Skylake-SP):
> 
>     commit bb42b3d39781d7fc ("perf/x86/intel/uncore: Expose an Uncore unit to IIO PMON mapping")
> 
>   It is intended to provide four I/O performance metrics in MB per each
>   PCIe root port:
> 
>    - Inbound Read: I/O devices below root port read from the host memory
>    - Inbound Write: I/O devices below root port write to the host memory
>    - Outbound Read: CPU reads from I/O devices below root port
>    - Outbound Write: CPU writes to I/O devices below root port
> 
> - Align CSV output for summary.
> 
> - Clarify --null use cases: Assess raw overhead of 'perf stat' or
>   measure just wall clock time.
> 
> - Improve readability of shadow stats.
> 
> perf record:
> 
> - Change the COMM when starting tha workload so that --exclude-perf
>   doesn't seem to be not honoured.
> 
> - Improve 'Workload failed' message printing events + what was exec'ed.
> 
> - Fix cross-arch support for TIME_CONV.
> 
> perf report:
> 
> - Add option to disable raw event ordering.
> 
> - Dump the contents of PERF_RECORD_TIME_CONV in 'perf report -D'.
> 
> - Improvements to --stat output, that shows information about PERF_RECORD_ events.
> 
> - Preserve identifier id in OCaml demangler.
> 
> perf annotate:
> 
> - Show full source location with 'l' hotkey in the 'perf annotate' TUI.
> 
> - Add line number like in TUI and source location at EOL to the 'perf annotate' --stdio mode.
> 
> - Add --demangle and --demangle-kernel to 'perf annotate'.
> 
> - Allow configuring annotate.demangle{,_kernel} in 'perf config'.
> 
> - Fix sample events lost in stdio mode.
> 
> perf data:
> 
> - Allow converting a perf.data file to JSON.
> 
> libperf:
> 
> - Add support for user space counter access.
> 
> - Update topdown documentation to permit rdpmc calls.
> 
> perf test:
> 
> - Add 'perf test' for 'perf stat' CSV output.
> 
> - Add 'perf test' entries to test the hybrid PMU support.
> 
> - Cleanup 'perf test daemon' if its 'perf test' is interrupted.
> 
> - Handle metric reuse in pmu-events parsing 'perf test' entry.
> 
> - Add test for PE executable support.
> 
> - Add timeout for wait for daemon start in its 'perf test' entries.
> 
> Build:
> 
> - Enable libtraceevent dynamic linking.
> 
> - Improve feature detection output.
> 
> - Fix caching of feature checks caching.
> 
> - First round of updates for tools copies of kernel headers.
> 
> - Enable warnings when compiling BPF programs.
> 
> Vendor specific events:
> 
> Intel:
> 
> - Add missing skylake & icelake model numbers.
> 
> arm64:
> 
> - Add Hisi hip08 L1, L2 and L3 metrics.
> 
> - Add Fujitsu A64FX PMU events.
> 
> PowerPC:
> 
> - Initial JSON/events list for power10 platform.
> 
> - Remove unsupported power9 metrics.
> 
> AMD:
> 
> - Add Zen3 events.
> 
> - Fix broken L2 Cache Hits from L2 HWPF metric.
> 
> - Use lowercases for all the eventcodes and umasks.
> 
> Hardware tracing:
> 
> arm64:
> 
> - Update CoreSight ETM metadata format.
> 
> - Fix bitmap for CS-ETM option.
> 
> - Support PID tracing in config.
> 
> - Detect pid in VMID for kernel running at EL2.
> 
> Arch specific:
> 
> MIPS:
> 
> - Support MIPS unwinding and dwarf-regs.
> 
> - Generate mips syscalls_n64.c syscall table.
> 
> PowerPC:
> 
> - Add support for PERF_SAMPLE_WEIGH_STRUCT on PowerPC.
> 
> - Support pipeline stage cycles for powerpc.
> 
> libbeauty:
> 
> - Fix fsconfig generator.
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Alexander Antonov (4):
>       perf stat: Basic support for iostat in perf
>       perf stat: Helper functions for PCIe root ports list in iostat mode
>       perf stat: Enable iostat mode for x86 platforms
>       perf: Update .gitignore file
> 
> Arnaldo Carvalho de Melo (20):
>       tools headers UAPI: Update tools's copy of drm.h headers
>       tools headers UAPI: Sync drm/i915_drm.h with the kernel sources
>       tools headers UAPI: Sync openat2.h with the kernel sources
>       perf arch powerpc: Sync powerpc syscall.tbl with the kernel sources
>       tools headers UAPI s390: Sync ptrace.h kernel headers
>       tools headers UAPI: Sync kvm.h headers with the kernel sources
>       Merge remote-tracking branch 'torvalds/master' into perf/core
>       perf symbols: Fix dso__fprintf_symbols_by_name() to return the number of printed chars
>       perf script: Fixup 'struct evsel_script' method prefix
>       perf stat: Fixup __perf_stat_evsel__is() prefix
>       perf evlist: Change the COMM when preparing the workload
>       perf stat: Elaborate use cases for the -n/--null command line option
>       Merge remote-tracking branch 'torvalds/master' into perf/core
>       Merge remote-tracking branch 'torvalds/master' into perf/core
>       perf evlist: Add a method to return the list of evsels as a string
>       perf record: Improve 'Workload failed' message printing events + what was exec'ed
>       perf tools: Add a build-test variant to use in builds from a tarball
>       Merge remote-tracking branch 'torvalds/master' into perf/core
>       tools build: Allow deferring printing the results of feature detection
>       perf build: Defer printing detected features to the end of all feature checks
> 
> Athira Rajeev (4):
>       perf sort: Add dynamic headers for perf report columns
>       perf powerpc: Add support for PERF_SAMPLE_WEIGHT_STRUCT
>       perf tools: Support pipeline stage cycles for powerpc
>       perf sort: Display sort dimension p_stage_cyc only on supported archs
> 
> Changbin Du (1):
>       perf stat: Improve readability of shadow stats
> 
> Fabian Hemmer (1):
>       perf tools: Preserve identifier id in OCaml demangler
> 
> Ian Rogers (9):
>       perf docs: Add man pages to see also
>       perf skel: Remove some unused variables.
>       perf tools: Enable warnings when compiling BPF programs
>       perf bpf: Minor whitespace cleanup.
>       tools include: Add __sum16 and __wsum definitions.
>       perf test: Remove unused argument
>       perf test: Cleanup daemon if test is interrupted.
>       perf test: Add 30s timeout for wait for daemon start.
>       perf arm64: Fix off-by-one directory paths.
> 
> Ingo Molnar (1):
>       perf tools: Fix various typos in comments
> 
> Jiapeng Chong (3):
>       perf metric: Remove unneeded semicolon
>       perf tools: use ARRAY_SIZE
>       perf machine: Assign boolean values to a bool variable
> 
> Jin Yao (30):
>       perf report: Create option to disable raw event ordering
>       perf stat: Align CSV output for summary mode
>       perf test: Add CSV summary test
>       perf vendor events intel: Add missing skylake & icelake model numbers
>       tools headers uapi: Update tools's copy of linux/perf_event.h
>       perf jevents: Support unit value "cpu_core" and "cpu_atom"
>       perf pmu: Simplify arguments of __perf_pmu__new_alias
>       perf pmu: Save pmu name
>       perf pmu: Save detected hybrid pmus to a global pmu list
>       perf pmu: Add hybrid helper functions
>       perf stat: Uniquify hybrid event name
>       perf parse-events: Create two hybrid hardware events
>       perf parse-events: Create two hybrid cache events
>       perf parse-events: Create two hybrid raw events
>       perf parse-events: Compare with hybrid pmu name
>       perf parse-events: Support event inside hybrid pmu
>       perf record: Create two hybrid 'cycles' events by default
>       perf stat: Add default hybrid events
>       perf stat: Filter out unmatched aggregation for hybrid event
>       perf stat: Warn group events from different hybrid PMU
>       perf record: Uniquify hybrid event name
>       perf tests: Add hybrid cases for 'Parse event definition strings' test
>       perf tests: Add hybrid cases for 'Roundtrip evsel->name' test
>       perf tests: Skip 'Setup struct perf_event_attr' test for hybrid
>       perf tests: Support 'Track with sched_switch' test for hybrid
>       perf tests: Support 'Parse and process metrics' test for hybrid
>       perf tests: Support 'Session topology' test for hybrid
>       perf tests: Support 'Convert perf time to TSC' test for hybrid
>       perf tests: Skip 'perf stat metrics (shadow stat) test' for hybrid
>       perf Documentation: Document intel-hybrid support
> 
> Jiri Olsa (1):
>       perf build: Regenerate the FEATURE_DUMP file after extra feature checks
> 
> John Garry (6):
>       perf metricgroup: Make find_metric() public with name change
>       perf test: Handle metric reuse in pmu-events parsing test
>       perf pmu: Add pmu_events_map__find() function to find the common PMU map for the system
>       perf vendor events arm64: Add Hisi hip08 L1 metrics
>       perf vendor events arm64: Add Hisi hip08 L2 metrics
>       perf vendor events arm64: Add Hisi hip08 L3 metrics
> 
> Kajol Jain (1):
>       perf vendor events: Initial JSON/events list for power10 platform
> 
> Leo Yan (6):
>       tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
>       perf cs-etm: Add helper cs_etm__get_pid_fmt()
>       perf tools: Change fields type in perf_record_time_conv
>       perf jit: Let convert_timestamp() to be backwards-compatible
>       perf session: Add swap operation for event TIME_CONV
>       perf session: Dump PERF_RECORD_TIME_CONV event
> 
> Martin Liska (2):
>       perf config: Add annotate.demangle{,_kernel}
>       perf annotate: Show full source location with 'l' hotkey
> 
> Martin Liška (2):
>       perf annotate: Add --demangle and --demangle-kernel
>       perf annotate: Add line number like in TUI and source location at EOL
> 
> Michael Petlan (1):
>       perf tools: Enable libtraceevent dynamic linking
> 
> Mike Leach (1):
>       perf cs-etm: Update ETM metadata format
> 
> Namhyung Kim (6):
>       perf top: Use evlist->events_stat to count events
>       perf hists: Split hists_stats from events_stats
>       perf report: Show event sample counts in --stat output
>       perf report: Add --skip-empty option to suppress 0 event stat
>       perf report: Make --skip-empty as default
>       perf report: Print percentage of each event statistics
> 
> Nicholas Fraser (2):
>       perf buildid-cache: Add test for PE executable
>       perf data: Add JSON export
> 
> Paul A. Clarke (1):
>       perf vendor events power9: Remove unsupported metrics
> 
> Ray Kinsella (1):
>       perf tools: Update topdown documentation to permit rdpmc calls
> 
> Rob Herring (5):
>       tools include: Add an initial math64.h
>       libperf: Add evsel mmap support
>       libperf tests: Add support for verbose printing
>       libperf: Add support for user space counter access
>       libperf xyarray: Add bounds checks to xyarray__entry()
> 
> Shunsuke Nakamura (2):
>       perf vendor events arm64: Add more common and uarch events
>       perf vendor events arm64: Add Fujitsu A64FX pmu event
> 
> Smita Koralahalli (4):
>       perf vendor events amd: Fix broken L2 Cache Hits from L2 HWPF metric
>       perf vendor events amd: Use lowercases for all the eventcodes and umasks
>       perf vendor events amd: Use 0x%02x format for event code and umask
>       perf vendor events amd: Add Zen3 events
> 
> Song Liu (8):
>       perf stat: Introduce 'bperf' to share hardware PMCs with BPF
>       perf stat: Measure 't0' and 'ref_time' after enable_counters()
>       perf test: Add a shell test for 'perf stat --bpf-counters' new option
>       perf util: Move bpf_perf definitions to a libperf header
>       perf bpf: check perf_attr_map is compatible with the perf binary
>       perf stat: Introduce config stat.bpf-counter-events
>       perf stat: Introduce ':b' modifier
>       perf stat: Introduce bpf_counter_ops->disable()
> 
> Suzuki K Poulose (3):
>       perf cs-etm: Fix bitmap for option
>       perf cs-etm: Support PID tracing in config
>       perf cs-etm: Detect pid in VMID for kernel running at EL2
> 
> Tiezhu Yang (3):
>       perf tools: Support MIPS unwinding and dwarf-regs
>       perf tools: Generate mips syscalls_n64.c syscall table
>       MAINTAINERS: Add Mailing list and Web-page for PERFORMANCE EVENTS SUBSYSTEM
> 
> Vitaly Chikunov (1):
>       perf beauty: Fix fsconfig generator
> 
> Wan Jiabing (4):
>       perf tools: Remove duplicate struct forward declarations
>       perf daemon: Remove duplicate includes
>       perf evsel: Remove duplicate 'struct target' forward declaration
>       perf mem-events: Remove unnecessary 'struct mem_info' forward declaration
> 
> Xiong Zhenwu (1):
>       perf bench: Fix misspellings using codespell
> 
> Yang Jihong (1):
>       perf annotate: Fix sample events lost in stdio mode
> 
> Zhen Lei (1):
>       perf data: Fix error return code in perf_data__create_dir()
> 
>  MAINTAINERS                                        |   2 +
>  tools/build/Makefile.feature                       |  28 +-
>  tools/build/feature/Makefile                       |   4 +
>  tools/build/feature/test-libtraceevent.c           |  12 +
>  tools/include/linux/math64.h                       |  75 +++
>  tools/include/linux/types.h                        |   3 +
>  tools/include/uapi/linux/perf_event.h              |  15 +
>  tools/lib/perf/Documentation/libperf.txt           |   3 +
>  tools/lib/perf/evsel.c                             |  80 +++
>  tools/lib/perf/include/internal/evsel.h            |   1 +
>  tools/lib/perf/include/internal/mmap.h             |   3 +
>  tools/lib/perf/include/internal/tests.h            |  32 ++
>  tools/lib/perf/include/internal/xyarray.h          |   9 +-
>  tools/lib/perf/include/perf/bpf_perf.h             |  31 ++
>  tools/lib/perf/include/perf/event.h                |   7 +-
>  tools/lib/perf/include/perf/evsel.h                |   3 +
>  tools/lib/perf/libperf.map                         |   3 +
>  tools/lib/perf/mmap.c                              |  88 ++++
>  tools/lib/perf/tests/Makefile                      |   6 +-
>  tools/lib/perf/tests/test-evsel.c                  |  66 +++
>  tools/perf/.gitignore                              |   1 +
>  tools/perf/Documentation/intel-hybrid.txt          | 214 ++++++++
>  tools/perf/Documentation/perf-annotate.txt         |   7 +
>  tools/perf/Documentation/perf-buildid-cache.txt    |   2 +-
>  tools/perf/Documentation/perf-config.txt           |  11 +
>  tools/perf/Documentation/perf-data.txt             |   5 +-
>  tools/perf/Documentation/perf-iostat.txt           |  88 ++++
>  tools/perf/Documentation/perf-record.txt           |   1 +
>  tools/perf/Documentation/perf-report.txt           |  10 +-
>  tools/perf/Documentation/perf-stat.txt             |  29 +-
>  tools/perf/Documentation/perf-top.txt              |   2 +-
>  tools/perf/Documentation/perf.txt                  |  12 +
>  tools/perf/Documentation/topdown.txt               |  18 +
>  tools/perf/Makefile                                |   5 +-
>  tools/perf/Makefile.config                         |  31 +-
>  tools/perf/Makefile.perf                           |  16 +-
>  tools/perf/arch/arm/util/cs-etm.c                  |  78 ++-
>  tools/perf/arch/arm64/util/Build                   |   1 +
>  tools/perf/arch/arm64/util/kvm-stat.c              |   4 +-
>  tools/perf/arch/arm64/util/machine.c               |   6 +-
>  tools/perf/arch/arm64/util/perf_regs.c             |   2 +-
>  tools/perf/arch/arm64/util/pmu.c                   |  25 +
>  tools/perf/arch/arm64/util/unwind-libunwind.c      |   4 +-
>  tools/perf/arch/mips/Makefile                      |  22 +
>  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 ++
>  .../perf/arch/mips/entry/syscalls/syscall_n64.tbl  | 358 ++++++++++++++
>  tools/perf/arch/mips/include/dwarf-regs-table.h    |  31 ++
>  tools/perf/arch/mips/include/perf_regs.h           |  84 ++++
>  tools/perf/arch/mips/util/Build                    |   3 +
>  tools/perf/arch/mips/util/dwarf-regs.c             |  38 ++
>  tools/perf/arch/mips/util/perf_regs.c              |   6 +
>  tools/perf/arch/mips/util/unwind-libunwind.c       |  22 +
>  tools/perf/arch/powerpc/util/Build                 |   2 +
>  tools/perf/arch/powerpc/util/event.c               |  53 ++
>  tools/perf/arch/powerpc/util/evsel.c               |   8 +
>  tools/perf/arch/powerpc/util/kvm-stat.c            |   2 +-
>  tools/perf/arch/powerpc/util/utils_header.h        |   2 +-
>  tools/perf/arch/x86/tests/bp-modify.c              |   2 +-
>  tools/perf/arch/x86/util/Build                     |   1 +
>  tools/perf/arch/x86/util/iostat.c                  | 470 ++++++++++++++++++
>  tools/perf/arch/x86/util/perf_regs.c               |   4 +-
>  tools/perf/bench/epoll-wait.c                      |   4 +-
>  tools/perf/bench/inject-buildid.c                  |   2 +-
>  tools/perf/bench/numa.c                            |   2 +-
>  tools/perf/builtin-annotate.c                      |  41 +-
>  tools/perf/builtin-daemon.c                        |   3 -
>  tools/perf/builtin-data.c                          |  26 +-
>  tools/perf/builtin-diff.c                          |   2 +-
>  tools/perf/builtin-lock.c                          |   2 +-
>  tools/perf/builtin-record.c                        |  55 ++-
>  tools/perf/builtin-report.c                        |  43 +-
>  tools/perf/builtin-sched.c                         |   2 +-
>  tools/perf/builtin-script.c                        |  22 +-
>  tools/perf/builtin-stat.c                          | 130 ++++-
>  tools/perf/builtin-top.c                           |  22 +-
>  tools/perf/check-headers.sh                        |   1 +
>  tools/perf/command-list.txt                        |   1 +
>  tools/perf/examples/bpf/augmented_raw_syscalls.c   |   4 +-
>  tools/perf/jvmti/jvmti_agent.c                     |   4 +-
>  tools/perf/perf-iostat.sh                          |  12 +
>  .../arch/arm64/armv8-common-and-microarch.json     | 228 +++++++++
>  .../arch/arm64/fujitsu/a64fx/branch.json           |   8 +
>  .../pmu-events/arch/arm64/fujitsu/a64fx/bus.json   |  62 +++
>  .../pmu-events/arch/arm64/fujitsu/a64fx/cache.json | 128 +++++
>  .../pmu-events/arch/arm64/fujitsu/a64fx/cycle.json |   5 +
>  .../arch/arm64/fujitsu/a64fx/exception.json        |  29 ++
>  .../arch/arm64/fujitsu/a64fx/instruction.json      | 131 +++++
>  .../arch/arm64/fujitsu/a64fx/memory.json           |   8 +
>  .../pmu-events/arch/arm64/fujitsu/a64fx/other.json | 188 +++++++
>  .../arch/arm64/fujitsu/a64fx/pipeline.json         | 194 ++++++++
>  .../pmu-events/arch/arm64/fujitsu/a64fx/sve.json   | 110 +++++
>  .../arch/arm64/hisilicon/hip08/metrics.json        | 233 +++++++++
>  tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
>  tools/perf/pmu-events/arch/powerpc/mapfile.csv     |   1 +
>  .../pmu-events/arch/powerpc/power10/cache.json     |  47 ++
>  .../arch/powerpc/power10/floating_point.json       |   7 +
>  .../pmu-events/arch/powerpc/power10/frontend.json  | 217 ++++++++
>  .../pmu-events/arch/powerpc/power10/locks.json     |  12 +
>  .../pmu-events/arch/powerpc/power10/marked.json    | 147 ++++++
>  .../pmu-events/arch/powerpc/power10/memory.json    | 192 ++++++++
>  .../pmu-events/arch/powerpc/power10/others.json    | 297 +++++++++++
>  .../pmu-events/arch/powerpc/power10/pipeline.json  | 297 +++++++++++
>  .../perf/pmu-events/arch/powerpc/power10/pmc.json  |  22 +
>  .../arch/powerpc/power10/translation.json          |  57 +++
>  .../pmu-events/arch/powerpc/power8/metrics.json    |  12 +-
>  .../pmu-events/arch/powerpc/power9/metrics.json    | 134 +----
>  tools/perf/pmu-events/arch/x86/amdzen1/cache.json  |  48 +-
>  tools/perf/pmu-events/arch/x86/amdzen1/core.json   |  12 +-
>  .../arch/x86/amdzen1/floating-point.json           |  42 +-
>  tools/perf/pmu-events/arch/x86/amdzen1/memory.json |  42 +-
>  tools/perf/pmu-events/arch/x86/amdzen1/other.json  |  12 +-
>  .../pmu-events/arch/x86/amdzen1/recommended.json   |   8 +-
>  tools/perf/pmu-events/arch/x86/amdzen2/branch.json |   8 +-
>  tools/perf/pmu-events/arch/x86/amdzen2/cache.json  |  60 +--
>  tools/perf/pmu-events/arch/x86/amdzen2/core.json   |  12 +-
>  .../arch/x86/amdzen2/floating-point.json           |  42 +-
>  tools/perf/pmu-events/arch/x86/amdzen2/memory.json |  86 ++--
>  tools/perf/pmu-events/arch/x86/amdzen2/other.json  |  20 +-
>  .../pmu-events/arch/x86/amdzen2/recommended.json   |   8 +-
>  tools/perf/pmu-events/arch/x86/amdzen3/branch.json |  53 ++
>  tools/perf/pmu-events/arch/x86/amdzen3/cache.json  | 402 +++++++++++++++
>  tools/perf/pmu-events/arch/x86/amdzen3/core.json   | 137 ++++++
>  .../pmu-events/arch/x86/amdzen3/data-fabric.json   |  98 ++++
>  .../arch/x86/amdzen3/floating-point.json           | 139 ++++++
>  tools/perf/pmu-events/arch/x86/amdzen3/memory.json | 428 ++++++++++++++++
>  tools/perf/pmu-events/arch/x86/amdzen3/other.json  | 103 ++++
>  .../pmu-events/arch/x86/amdzen3/recommended.json   | 214 ++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv         |   5 +-
>  tools/perf/pmu-events/jevents.c                    |   4 +-
>  tools/perf/scripts/python/netdev-times.py          |   2 +-
>  tools/perf/tests/attr.c                            |   4 +
>  tools/perf/tests/bp_signal.c                       |   6 +-
>  tools/perf/tests/code-reading.c                    |   2 +-
>  tools/perf/tests/demangle-ocaml-test.c             |   8 +-
>  tools/perf/tests/evsel-roundtrip-name.c            |  19 +-
>  tools/perf/tests/hists_cumulate.c                  |   4 +-
>  tools/perf/tests/hists_filter.c                    |  14 +-
>  tools/perf/tests/make                              |  22 +-
>  tools/perf/tests/parse-events.c                    | 173 ++++++-
>  tools/perf/tests/parse-metric.c                    |  12 +-
>  tools/perf/tests/perf-time-to-tsc.c                |  12 +
>  tools/perf/tests/pmu-events.c                      |  83 +++-
>  tools/perf/tests/shell/buildid.sh                  |  65 ++-
>  tools/perf/tests/shell/daemon.sh                   |  54 +-
>  tools/perf/tests/shell/stat+csv_summary.sh         |  31 ++
>  tools/perf/tests/shell/stat+shadow_stat.sh         |   3 +
>  tools/perf/tests/shell/stat_bpf_counters.sh        |  31 ++
>  tools/perf/tests/switch-tracking.c                 |   6 +-
>  tools/perf/tests/topology.c                        |  15 +-
>  tools/perf/trace/beauty/fsconfig.sh                |   7 +-
>  tools/perf/trace/beauty/include/linux/socket.h     |   2 +-
>  tools/perf/ui/browsers/annotate.c                  |  27 +-
>  tools/perf/ui/browsers/hists.c                     |  19 +-
>  tools/perf/ui/stdio/hist.c                         |  15 +-
>  tools/perf/util/Build                              |   5 +
>  tools/perf/util/annotate.c                         |  46 +-
>  tools/perf/util/annotate.h                         |   2 +
>  tools/perf/util/bpf-loader.c                       |   2 +-
>  tools/perf/util/bpf_counter.c                      | 544 ++++++++++++++++++++-
>  tools/perf/util/bpf_counter.h                      |   9 +-
>  tools/perf/util/bpf_skel/bperf.h                   |  14 +
>  tools/perf/util/bpf_skel/bperf_follower.bpf.c      |  69 +++
>  tools/perf/util/bpf_skel/bperf_leader.bpf.c        |  46 ++
>  tools/perf/util/bpf_skel/bperf_u.h                 |  14 +
>  tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c   |   3 +-
>  tools/perf/util/call-path.h                        |   2 +-
>  tools/perf/util/callchain.c                        |   2 +-
>  tools/perf/util/config.c                           |   9 +-
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  40 +-
>  tools/perf/util/cs-etm.c                           | 285 +++++++++--
>  tools/perf/util/cs-etm.h                           |  36 +-
>  tools/perf/util/data-convert-bt.c                  |   4 +-
>  tools/perf/util/data-convert-bt.h                  |  11 -
>  tools/perf/util/data-convert-json.c                | 384 +++++++++++++++
>  tools/perf/util/data-convert.h                     |  10 +
>  tools/perf/util/demangle-java.c                    |   4 +-
>  tools/perf/util/demangle-ocaml.c                   |  12 -
>  tools/perf/util/dso.h                              |   2 +-
>  tools/perf/util/dwarf-aux.c                        |   6 +-
>  tools/perf/util/dwarf-aux.h                        |   2 +-
>  tools/perf/util/dwarf-regs.c                       |   3 +
>  tools/perf/util/event.h                            |   3 +
>  tools/perf/util/events_stats.h                     |  15 +-
>  tools/perf/util/evlist-hybrid.c                    |  88 ++++
>  tools/perf/util/evlist-hybrid.h                    |  14 +
>  tools/perf/util/evlist.c                           |  38 +-
>  tools/perf/util/evlist.h                           |   2 +
>  tools/perf/util/evsel.c                            |  38 +-
>  tools/perf/util/evsel.h                            |  34 +-
>  tools/perf/util/expr.h                             |   2 +-
>  tools/perf/util/header.c                           |  18 +-
>  tools/perf/util/hist.c                             |  37 +-
>  tools/perf/util/hist.h                             |   8 +-
>  tools/perf/util/intel-pt.c                         |   2 +-
>  tools/perf/util/iostat.c                           |  53 ++
>  tools/perf/util/iostat.h                           |  47 ++
>  tools/perf/util/jitdump.c                          |  30 +-
>  tools/perf/util/levenshtein.c                      |   2 +-
>  tools/perf/util/libunwind/arm64.c                  |   2 +-
>  tools/perf/util/libunwind/x86_32.c                 |   2 +-
>  tools/perf/util/llvm-utils.c                       |   2 +-
>  tools/perf/util/machine.c                          |  12 +-
>  tools/perf/util/map.h                              |   4 +-
>  tools/perf/util/mem-events.h                       |   3 +-
>  tools/perf/util/metricgroup.c                      |  14 +-
>  tools/perf/util/metricgroup.h                      |   4 +-
>  tools/perf/util/parse-events-hybrid.c              | 178 +++++++
>  tools/perf/util/parse-events-hybrid.h              |  23 +
>  tools/perf/util/parse-events.c                     | 115 ++++-
>  tools/perf/util/parse-events.h                     |   9 +-
>  tools/perf/util/parse-events.l                     |   2 +-
>  tools/perf/util/parse-events.y                     |   9 +-
>  tools/perf/util/pmu-hybrid.c                       |  89 ++++
>  tools/perf/util/pmu-hybrid.h                       |  22 +
>  tools/perf/util/pmu.c                              |  73 ++-
>  tools/perf/util/pmu.h                              |   8 +
>  tools/perf/util/probe-event.c                      |   4 +-
>  tools/perf/util/probe-finder.c                     |   6 +-
>  tools/perf/util/python-ext-sources                 |   2 +
>  tools/perf/util/python.c                           |   6 +
>  tools/perf/util/s390-cpumsf.c                      |  10 +-
>  tools/perf/util/s390-sample-raw.c                  |   4 +-
>  .../util/scripting-engines/trace-event-python.c    |   2 +-
>  tools/perf/util/session.c                          |  41 +-
>  tools/perf/util/session.h                          |   3 +-
>  tools/perf/util/sort.c                             |  60 ++-
>  tools/perf/util/sort.h                             |   2 +
>  tools/perf/util/stat-display.c                     |  64 ++-
>  tools/perf/util/stat-shadow.c                      |  21 +-
>  tools/perf/util/stat.c                             |   3 +-
>  tools/perf/util/stat.h                             |   8 +-
>  tools/perf/util/strbuf.h                           |   2 +-
>  tools/perf/util/strfilter.h                        |   4 +-
>  tools/perf/util/symbol-elf.c                       |   2 +-
>  tools/perf/util/symbol_fprintf.c                   |   2 +-
>  tools/perf/util/synthetic-events.c                 |   4 +-
>  tools/perf/util/syscalltbl.c                       |   4 +
>  tools/perf/util/target.h                           |   7 +-
>  tools/perf/util/thread-stack.h                     |   1 -
>  tools/perf/util/tsc.c                              |  30 ++
>  tools/perf/util/tsc.h                              |   4 +
>  tools/perf/util/units.c                            |  21 +-
>  tools/perf/util/units.h                            |   1 +
>  tools/perf/util/unwind-libunwind-local.c           |   2 +-
>  244 files changed, 9952 insertions(+), 883 deletions(-)
>  create mode 100644 tools/build/feature/test-libtraceevent.c
>  create mode 100644 tools/include/linux/math64.h
>  create mode 100644 tools/lib/perf/include/perf/bpf_perf.h
>  create mode 100644 tools/perf/Documentation/intel-hybrid.txt
>  create mode 100644 tools/perf/Documentation/perf-iostat.txt
>  create mode 100644 tools/perf/arch/arm64/util/pmu.c
>  create mode 100644 tools/perf/arch/mips/Makefile
>  create mode 100644 tools/perf/arch/mips/entry/syscalls/mksyscalltbl
>  create mode 100644 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
>  create mode 100644 tools/perf/arch/mips/include/dwarf-regs-table.h
>  create mode 100644 tools/perf/arch/mips/include/perf_regs.h
>  create mode 100644 tools/perf/arch/mips/util/Build
>  create mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
>  create mode 100644 tools/perf/arch/mips/util/perf_regs.c
>  create mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
>  create mode 100644 tools/perf/arch/powerpc/util/event.c
>  create mode 100644 tools/perf/arch/powerpc/util/evsel.c
>  create mode 100644 tools/perf/arch/x86/util/iostat.c
>  create mode 100644 tools/perf/perf-iostat.sh
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/bus.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/cycle.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/exception.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/instruction.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/other.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/a64fx/sve.json
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/floating_point.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/locks.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/marked.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/others.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/pmc.json
>  create mode 100644 tools/perf/pmu-events/arch/powerpc/power10/translation.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/branch.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/core.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/data-fabric.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/amdzen3/recommended.json
>  create mode 100755 tools/perf/tests/shell/stat+csv_summary.sh
>  create mode 100755 tools/perf/tests/shell/stat_bpf_counters.sh
>  create mode 100644 tools/perf/util/bpf_skel/bperf.h
>  create mode 100644 tools/perf/util/bpf_skel/bperf_follower.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/bperf_leader.bpf.c
>  create mode 100644 tools/perf/util/bpf_skel/bperf_u.h
>  delete mode 100644 tools/perf/util/data-convert-bt.h
>  create mode 100644 tools/perf/util/data-convert-json.c
>  create mode 100644 tools/perf/util/evlist-hybrid.c
>  create mode 100644 tools/perf/util/evlist-hybrid.h
>  create mode 100644 tools/perf/util/iostat.c
>  create mode 100644 tools/perf/util/iostat.h
>  create mode 100644 tools/perf/util/parse-events-hybrid.c
>  create mode 100644 tools/perf/util/parse-events-hybrid.h
>  create mode 100644 tools/perf/util/pmu-hybrid.c
>  create mode 100644 tools/perf/util/pmu-hybrid.h

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

  $ grep "model name" -m1 /proc/cpuinfo 
  model name: AMD Ryzen 9 3900X 12-Core Processor
  # export PERF_TARBALL=http://192.168.86.5/perf/perf-5.12.0.tar.xz
  # dm 
   1    72.92 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   2    74.56 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   3    81.19 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   4    90.07 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5    83.40 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6    85.30 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   7   110.88 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   8   140.86 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
   9   127.60 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10   278.42 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  11   235.62 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  12   161.23 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  13   390.70 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  14    95.00 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
  15    77.78 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  16   103.23 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12) , clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  17    22.16 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  18    22.10 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
  19    25.74 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23) 
  20    31.40 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44) 
  21    97.31 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  22    60.94 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc , clang version 10.0.1 
  23    77.23 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  24    82.00 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  25    75.27 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  26    74.40 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  27    32.81 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  28    28.53 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  29    30.96 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  30    31.13 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-3) 10.2.1 20201224 
  31    29.13 fedora:20                     : Ok   gcc (GCC) 4.8.3 20140911 (Red Hat 4.8.3-7) 
  32    29.51 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  33    68.17 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  34    80.83 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  35    26.32 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  36    82.85 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  37    94.47 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  38    96.40 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  39   108.54 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  40   113.97 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  41   119.26 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  42    25.92 fedora:30-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  43   117.82 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  44    97.12 fedora:32                     : Ok   gcc (GCC) 10.2.1 20201125 (Red Hat 10.2.1-9) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  45    94.80 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-2.fc33)
  46    99.46 fedora:34                     : Ok   gcc (GCC) 11.0.1 20210324 (Red Hat 11.0.1-0) , clang version 12.0.0 (Fedora 12.0.0-0.3.rc1.fc34)
  47    98.91 fedora:rawhide                : Ok   gcc (GCC) 11.0.1 20210423 (Red Hat 11.0.1-0) , clang version 12.0.0 (Fedora 12.0.0-1.fc35)
  48    34.11 gentoo-stage3-amd64:latest    : Ok   gcc (Gentoo 9.3.0-r1 p3) 9.3.0 
  49    66.98 mageia:5                      : Ok   gcc (GCC) 4.9.2 , clang version 3.5.2 (tags/RELEASE_352/final)
  50    83.81 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  51    48.52 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.12.0/tools/build/Makefile.build:139: util] Error 2
  52   221.66 openmandriva:cooker           : Ok   gcc (GCC) 10.3.0 20210408 (OpenMandriva) , OpenMandriva 12.0.0-1 clang version 12.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-12.0.0/clang b3a1e025e0452bb54d01ab5281bbf509ac4e3c72)
  53   119.19 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  54   127.85 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  55   117.53 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  56   131.22 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  57   114.64 opensuse:42.3                 : Ok   gcc (SUSE Linux) 4.8.5 , clang version 3.8.0 (tags/RELEASE_380/final 262553)
  58   108.83 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 10.2.1 20200825 [revision c0746a1beb1ba073c7981eb09f55b3d993b32e5c] , clang version 10.0.1 
  59    25.02 oraclelinux:6                 : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23.0.1) 
  60    30.76 oraclelinux:7                 : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44.0.3) 
  61    95.29 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.2) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  62    25.85 ubuntu:12.04                  : Ok   gcc (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3 , Ubuntu clang version 3.0-6ubuntu3 (tags/RELEASE_30/final) (based on LLVM 3.0)
  63    29.09 ubuntu:14.04                  : Ok   gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4 
  64    81.27 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  65    27.09 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    27.59 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  67    26.25 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  68    26.87 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  69    27.69 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  70    26.58 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  71    88.21 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  72    28.46 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    29.25 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    23.59 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    27.97 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    29.83 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    30.41 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  78   172.25 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  79    26.09 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  80    28.18 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  81    26.43 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  82    76.46 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
  83    31.35 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
  84    74.85 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  85    71.63 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-1ubuntu1
  $

  # uname -a
  Linux five 5.11.14-200.fc33.x86_64 #1 SMP Wed Apr 14 15:25:53 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # git log --oneline -1
  c6e3bf437184 perf build: Defer printing detected features to the end of all feature checks
  # perf version --build-options
  perf version 5.12.gc6e3bf437184
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
  78: daemon operations                                               : Ok
  79: probe libc's inet_pton & backtrace it with ping                 : Ok
  80: Check Arm CoreSight trace data recording and synthesized samples: Skip
  81: perf stat metrics (shadow stat) test                            : Ok
  82: Use vfs_getname probe to get syscall args filenames             : Ok
  83: Check open filename arg using perf trace + vfs_getname          : Ok
  84: perf stat csv summary test                                      : Ok
  85: Zstd perf.data compression/decompression                        : Ok
  86: Add vfs_getname probe to get syscall args filenames             : Ok
  87: perf stat --bpf-counters test                                   : Ok
  88: build id cache operations                                       : Ok

The following ones are now being run on all the above containers, so far just
with gcc, clang will come later. All clear for this batch.

  $ make -C tools/perf build-test
  make: Entering directory '/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.vW5dd4wbxE
                make_with_gtk2: make GTK2=1 -j24  DESTDIR=/tmp/tmp.7Bkrn1WWBT
       make_util_pmu_bison_o_O: make util/pmu-bison.o
              make_clean_all_O: make clean all
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                  make_debug_O: make DEBUG=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
                make_no_newt_O: make NO_NEWT=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
             make_util_map_o_O: make util/map.o
            make_no_demangle_O: make NO_DEMANGLE=1
              make_no_libbpf_O: make NO_LIBBPF=1
                    make_doc_O: make doc
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                   make_tags_O: make tags
           make_no_libpython_O: make NO_LIBPYTHON=1
             make_no_libperl_O: make NO_LIBPERL=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_with_libpfm4_O: make LIBPFM4=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                 make_perf_o_O: make perf.o
                 make_no_sdt_O: make NO_SDT=1
                make_no_gtk2_O: make NO_GTK2=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
                   make_help_O: make help
              make_no_libelf_O: make NO_LIBELF=1
                make_install_O: make install
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
               make_no_slang_O: make NO_SLANG=1
                   make_pure_O: make
         make_install_prefix_O: make install prefix=/tmp/krava
            make_install_bin_O: make install-bin
             make_no_libnuma_O: make NO_LIBNUMA=1
  OK
  make: Leaving directory '/home/acme/git/perf/tools/perf'
  $
