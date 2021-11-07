Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BEAC433F5
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 20:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277F561374
	for <linux-perf-users@archiver.kernel.org>; Sun,  7 Nov 2021 20:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhKGUwn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 7 Nov 2021 15:52:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235254AbhKGUwm (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 7 Nov 2021 15:52:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E978B6137A;
        Sun,  7 Nov 2021 20:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636318199;
        bh=Sdz/Zzz1plw5eftIhaFjUpmTUl5VzrMlrPz8NPIrrW8=;
        h=From:To:Cc:Subject:Date:From;
        b=ETMsfaHdcI5UCNqf98GRpt4hH34gHO5xaA0dNY971Cer5mClIgy3zDsuAnCoJNwRf
         gb4bVaLt9OaAhIMXwFODiD3h6/R8qY3BXvbCF0g0iI6lp47K73XcTtrsavPNMiHr0K
         PqA+9mT1HHEVdUMkb0b/P2Lpxp3ufGyAbZZGptj9Ug1WDJXBMKS/hgx4B+1g3GGeEO
         PwreX6q0We75YQybFnfeUCy+kx7tOP7ajm4QuL25IPPylPzqSY2ozbvyLqrx19QdE6
         hXcENwB15StPljhZD0bWYGuUbxiOjTstIIEEEeSfTQX7xi814Dr0KwMCHRpqMZHlAL
         1SYXYHKEEMt7A==
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
        Denis Nikitin <denik@chromium.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        John Keeping <john@metanate.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Petlan <mpetlan@redhat.com>,
        Muhammad Falak R Wani <falakreyaz@gmail.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Tony Garnock-Jones <tonyg@leastfixedpoint.com>,
        William Cohen <wcohen@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.16
Date:   Sun,  7 Nov 2021 17:49:47 -0300
Message-Id: <20211107204947.1394255-1-acme@kernel.org>
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

Tests at the end of this message, as usual.

The following changes since commit fe91c4725aeed35023ba4f7a1e1adfebb6878c23:

  Merge tag 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi (2021-11-05 08:42:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.16-2021-11-07-without-bpftool-fix

for you to fetch changes up to 6b491a86b77c0dc323ca49f3a29a0f67178b75f8:

  perf build: Install libbpf headers locally when building (2021-11-07 15:39:28 -0300)

----------------------------------------------------------------
perf tools changes for v5.16:

perf annotate:

- Add riscv64 support.

- Add fusion logic for AMD microarchs.

perf record:

- Add an option to control the synthesizing behavior:

    --synth <no|all|task|mmap|cgroup>
                      Fine-tune event synthesis: default=all

core:

- Allow controlling synthesizing PERF_RECORD_ metadata events during record.

- perf.data reader prep work for multithreaded processing.

- Fix missing exclude_{host,guest} setting in PMUs that don't support it and
  that were causing the feature detection code to disable it for all events,
  even the ones in PMUs that support it.

- Fix the default use of precise events on AMD, that were always falling back
  to non-precise because perf_event_attr.exclude_guest=1 was set and IBS does
  not have filtering capability, refusing precise + exclude_guest.

- Add bitfield_swap() to handle branch_stack endian issue.

perf script:

- Show binary offsets for userspace addresses in callchains.

- Support instruction latency via new "ins_lat" selectable field.

- Add dlfilter-show-cycles

perf inject:

- Add vmlinux and ignore-vmlinux arguments, similar to other tools.

perf list:

- Display PMU prefix for partially supported hybrid cache events.

- Display hybrid PMU events with cpu type.

perf stat:

- Improve metrics documentation of data structures.

- Fix memory leaks in the metric code.

- Use NAN for missing event IDs.

- Don't compute unused events.

- Fix memory leak on error path.

- Encode and use metric-id as a metric qualifier.

- Allow metrics with no events.

- Avoid events for an 'if' constant result.

- Only add a referenced metric once.

- Simplify metric_refs calculation.

- Allow modifiers on metrics.

perf test:

- Add workload test of metric and metric groups.

- Workload test of all PMUs.

- vmlinux-kallsyms: Ignore hidden symbols.

- Add pmu-event test for event described as "config=".

- Verify more event members in pmu-events test.

- Add endian test for struct branch_flags on the sample-parsing test.

- Improve temp file cleanup in several tests.

perf daemon:

- Address MSAN warnings on send_cmd().

perf kmem:

- Improve man page for record options

perf srcline:

- Use long-running addr2line per DSO, greatly speeding up the 'srcline' sort order.

perf symbols:

- Ignore $a/$d symbols for ARM modules.

- Fix /proc/kcore access on 32 bit systems.

Kernel UAPI copies:

- Update copy of linux/socket.h with the kernel sources, no change in tooling output.

libbpf:

- Pull in bpf_program__get_prog_info_linear() from libbpf, too much specific to perf.

- Deprecate bpf_map__resize() in favor of bpf_map_set_max_entries()

- Install libbpf headers locally when building.

- Bump minimum LLVM C++ std to GNU++14.

libperf:

- Use binary search in perf_cpu_map__idx() as array are sorted.

libtracefs:

- Enable libtracefs dynamic linking.

libtraceevent:

- Increase logging when verbose.

Arch specific:

PowerPC:

- Add support to expose instruction and data address registers as part of
  extended regs.

Vendor events:

JSON parser:

- Support ConfigCode to set the config= in PMUs like:

  $ cat /sys/bus/event_source/devices/hisi_sccl1_ddrc3/events/act_cmd
  config=0x5

- Make the JSON parser more conformant when in strict mode.

All JSON files:

- Fix all remaining invalid JSON files.

ARM:

- Syntax corrections in Neoverse N1 json.

- Categorise the Neoverse V1 counters.

- Add new armv8 PMU events.

- Revise hip08 uncore events.

Hardware tracing:

auxtrace:

- Add missing Z option to ITRACE_HELP.

- Add itrace A option to approximate IPC.

- Add itrace d+o option to direct debug log to stdout.

Intel PT:

- Add support for PERF_RECORD_AUX_OUTPUT_HW_ID

- Support itrace A option to approximate IPC

- Support itrace d+o option to direct debug log to stdout.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (9):
      perf tools: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
      perf intel-pt: Add support for PERF_RECORD_AUX_OUTPUT_HW_ID
      perf build: Suppress 'rm dlfilter' build message
      perf auxtrace: Add missing Z option to ITRACE_HELP
      perf auxtrace: Add itrace A option to approximate IPC
      perf intel-pt: Support itrace A option to approximate IPC
      perf dlfilter: Add dlfilter-show-cycles
      perf auxtrace: Add itrace d+o option to direct debug log to stdout
      perf intel-pt: Support itrace d+o option to direct debug log to stdout

Alexey Bayduraev (8):
      perf session: Move all state items to reader object
      perf session: Introduce decompressor in reader object
      perf session: Move init/release code to separate functions
      perf session: Move reader map code to a separate function
      perf session: Move unmap code to reader__mmap
      perf session: Move the event read code to a separate function
      perf session: Introduce reader return codes
      perf session: Introduce reader EOF function

Alistair Francis (2):
      perf bench futex: Call the futex syscall from a function
      perf bench futex: Add support for 32-bit systems with 64-bit time_t

Andrew Kilroy (3):
      perf vendor events: Syntax corrections in Neoverse N1 json
      perf vendor events arm64: Add new armv8 pmu events
      perf vendor events arm64: Categorise the Neoverse V1 counters

Andrii Nakryiko (1):
      perf bpf: Ignore deprecation warning when using libbpf's btf__get_from_id()

Arnaldo Carvalho de Melo (9):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf jevents: Add __maybe_unused attribute to unused function arg
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Revert "perf bench futex: Add support for 32-bit systems with 64-bit time_t"
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf beauty: Update copy of linux/socket.h with the kernel sources
      perf MANIFEST: Add bpftool files to allow building with BUILD_BPF_SKEL=1

Athira Rajeev (2):
      perf powerpc: Refactor the code definition of perf reg extended mask in tools side header file
      perf powerpc: Add support to expose instruction and data address registers as part of extended regs

Dave Marchevsky (1):
      perf bpf: Pull in bpf_program__get_prog_info_linear()

Guo Zhengkui (1):
      perf daemon: Remove duplicate sys/file.h include

Ian Rogers (51):
      perf parse-events: Avoid enum forward declaration.
      perf daemon: Avoid msan warnings on send_cmd
      perf parse-events: Remove unnecessary #includes
      perf test: Workload test of metric and metricgroups
      perf test: Workload test of all PMUs
      perf tools: Enable libtracefs dynamic linking
      perf tools: Add define for libtraceevent version
      perf tools: Add define for libtracefs version
      libtraceevent: Increase libtraceevent logging when verbose
      perf metric: Restructure struct expr_parse_ctx.
      perf metric: Use NAN for missing event IDs.
      perf expr: Remove unused headers and inline d_ratio
      perf expr: Separate token declataion from type
      perf expr: Use macros for operators
      perf expr: Move actions to the left.
      perf metric: Rename expr__find_other.
      perf metric: Add utilities to work on ids map.
      perf metric: Allow metrics with no events
      perf expr: Merge find_ids and regular parsing
      perf expr: Propagate constants for binary operations
      perf metric: Don't compute unused events
      perf metric: Avoid events for an 'if' constant result
      perf kmem: Improve man page for record options
      tools lib: Adopt list_sort() from the kernel sources
      perf pmu: Add const to pmu_events_map.
      perf pmu: Make pmu_sys_event_tables const.
      perf pmu: Make pmu_event tables const.
      perf metric: Move runtime value to the expr context
      perf metric: Add documentation and rename a variable.
      perf metric: Add metric new() and free() methods
      perf metric: Only add a referenced metric once
      perf metric: Modify resolution and recursion check
      perf metric: Comment data structures
      perf metric: Document the internal 'struct metric'
      perf metric: Simplify metric_refs calculation
      perf parse-events: Add const to evsel name
      perf parse-events: Add new "metric-id" term
      perf parse-events: Allow config on kernel PMU events
      perf metric: Encode and use metric-id as qualifier
      perf expr: Add subset_of_ids() utility
      perf metrics: Modify setup and deduplication
      perf metric: Switch fprintf() to pr_err()
      perf parse-events: Identify broken modifiers
      perf metric: Allow modifiers on metrics
      tools: Bump minimum LLVM C++ std to GNU++14
      perf clang: Fixes for more recent LLVM/clang
      perf bpf: Add missing free to bpf_event__print_bpf_prog_info()
      perf stat: Fix memory leak on error path
      perf parse-events: Rename parse_events_error functions
      perf parse-event: Add init and exit to parse_event_error
      perf metric: Fix memory leaks

Ilya Leoshkevich (1):
      perf tools: Use __BYTE_ORDER__

James Clark (10):
      perf vendor-events: Fix all remaining invalid JSON files
      perf tools: Make the JSON parser more conformant when in strict mode
      perf tools: Enable strict JSON parsing
      perf dso: Fix /proc/kcore access on 32 bit systems
      perf test: Fix record+script_probe_vfs_getname.sh /tmp cleanup
      perf tests: Fix trace+probe_vfs_getname.sh /tmp cleanup
      perf tests: Improve temp file cleanup in test_arm_coresight.sh
      perf tools: Refactor out kernel symbol argument sanity checking
      perf tools: Check vmlinux/kallsyms arguments in all tools
      perf inject: Add vmlinux and ignore-vmlinux arguments

Jin Yao (2):
      perf list: Display pmu prefix for partially supported hybrid cache events
      perf list: Display hybrid PMU events with cpu type

John Garry (6):
      perf parse-events: Set numeric term config
      perf jevents: Support ConfigCode
      perf test: Verify more event members in pmu-events test
      perf test: Add pmu-event test for event described as "config="
      perf vendor events arm64: Revise hip08 uncore events
      perf jevents: Fix some would-be warnings

John Keeping (1):
      tools build: Drop needless slang include path in test-all

Kan Liang (1):
      perf script: Support instruction latency

Lexi Shao (2):
      perf script: Show binary offsets for userspace addr
      perf symbols: Ignore $a/$d symbols for ARM modules

Madhavan Srinivasan (2):
      perf evsel: Add bitfield_swap() to handle branch_stack endian issue
      perf test sample-parsing: Add endian test for struct branch_flags

Michael Petlan (1):
      perf tests vmlinux-kallsyms: Ignore hidden symbols

Muhammad Falak R Wani (1):
      perf bpf: Deprecate bpf_map__resize() in favor of bpf_map_set_max_entries()

Namhyung Kim (3):
      perf tools: Allow controlling synthesizing PERF_RECORD_ metadata events during record
      perf record: Add --synth option
      perf evsel: Fix missing exclude_{host,guest} setting

Quentin Monnet (1):
      perf build: Install libbpf headers locally when building

Ravi Bangoria (2):
      perf annotate: Add fusion logic for AMD microarchs
      perf evsel: Don't set exclude_guest by default

Riccardo Mancini (3):
      libperf cpumap: Use binary search in perf_cpu_map__idx() as array are sorted
      perf mmap: Introduce mmap_cpu_mask__duplicate()
      perf test evlist-open-close: Use inline func to convert timeval to usec

Tony Garnock-Jones (1):
      perf srcline: Use long-running addr2line per DSO

William Cohen (1):
      perf annotate: Add riscv64 support

 tools/arch/powerpc/include/uapi/asm/perf_regs.h    |   28 +-
 tools/build/Makefile.feature                       |    1 +
 tools/build/feature/Makefile                       |   12 +-
 tools/build/feature/test-libtracefs.c              |   10 +
 tools/include/linux/list_sort.h                    |   14 +
 tools/include/uapi/linux/perf_event.h              |   15 +
 tools/lib/list_sort.c                              |  252 ++++
 tools/lib/perf/cpumap.c                            |   16 +-
 tools/lib/perf/include/perf/event.h                |    6 +
 tools/perf/Documentation/itrace.txt                |    2 +
 tools/perf/Documentation/perf-inject.txt           |    7 +
 tools/perf/Documentation/perf-intel-pt.txt         |   35 +-
 tools/perf/Documentation/perf-kmem.txt             |   13 +-
 tools/perf/Documentation/perf-list.txt             |    4 +
 tools/perf/Documentation/perf-record.txt           |   16 +
 tools/perf/Documentation/perf-script.txt           |    2 +-
 tools/perf/Documentation/perf.data-file-format.txt |    2 +-
 tools/perf/MANIFEST                                |    4 +
 tools/perf/Makefile.config                         |   23 +-
 tools/perf/Makefile.perf                           |   36 +-
 tools/perf/arch/arm64/util/pmu.c                   |    2 +-
 tools/perf/arch/powerpc/include/perf_regs.h        |    2 +
 tools/perf/arch/powerpc/util/header.c              |    2 +-
 tools/perf/arch/powerpc/util/kvm-stat.c            |    5 +-
 tools/perf/arch/powerpc/util/perf_regs.c           |    2 +
 tools/perf/arch/riscv64/annotate/instructions.c    |   34 +
 tools/perf/arch/x86/annotate/instructions.c        |   28 +-
 tools/perf/arch/x86/util/evsel.c                   |   23 +
 tools/perf/bench/evlist-open-close.c               |   15 +-
 tools/perf/bench/futex.h                           |   43 +-
 tools/perf/bench/synthesize.c                      |    4 +-
 tools/perf/builtin-annotate.c                      |    4 +
 tools/perf/builtin-c2c.c                           |    4 +
 tools/perf/builtin-daemon.c                        |   15 +-
 tools/perf/builtin-inject.c                        |   11 +-
 tools/perf/builtin-kvm.c                           |    2 +-
 tools/perf/builtin-list.c                          |   42 +-
 tools/perf/builtin-probe.c                         |    5 +
 tools/perf/builtin-record.c                        |   52 +-
 tools/perf/builtin-report.c                        |   13 +-
 tools/perf/builtin-sched.c                         |    4 +
 tools/perf/builtin-script.c                        |   17 +-
 tools/perf/builtin-stat.c                          |   46 +-
 tools/perf/builtin-top.c                           |    6 +-
 tools/perf/builtin-trace.c                         |   23 +-
 tools/perf/check-headers.sh                        |    2 +
 tools/perf/dlfilters/dlfilter-show-cycles.c        |  144 ++
 .../pmu-events/arch/arm64/ampere/emag/bus.json     |    2 +-
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |   20 +-
 .../pmu-events/arch/arm64/ampere/emag/clock.json   |    2 +-
 .../arch/arm64/ampere/emag/exception.json          |    4 +-
 .../arch/arm64/ampere/emag/instruction.json        |   10 +-
 .../pmu-events/arch/arm64/ampere/emag/memory.json  |    4 +-
 .../arch/arm64/arm/cortex-a76-n1/branch.json       |    4 +-
 .../arch/arm64/arm/cortex-a76-n1/bus.json          |   12 +-
 .../arch/arm64/arm/cortex-a76-n1/cache.json        |   34 +-
 .../arch/arm64/arm/cortex-a76-n1/exception.json    |    4 +-
 .../arch/arm64/arm/cortex-a76-n1/instruction.json  |   18 +-
 .../arch/arm64/arm/cortex-a76-n1/memory.json       |    2 +-
 .../arch/arm64/arm/cortex-a76-n1/other.json        |    2 +-
 .../arch/arm64/arm/cortex-a76-n1/pipeline.json     |    4 +-
 .../arch/arm64/arm/neoverse-v1/branch.json         |    8 +
 .../pmu-events/arch/arm64/arm/neoverse-v1/bus.json |   20 +
 .../arch/arm64/arm/neoverse-v1/cache.json          |  155 +++
 .../arch/arm64/arm/neoverse-v1/exception.json      |   47 +
 .../arch/arm64/arm/neoverse-v1/instruction.json    |   89 ++
 .../arch/arm64/arm/neoverse-v1/memory.json         |   20 +
 .../arch/arm64/arm/neoverse-v1/other.json          |    5 +
 .../arch/arm64/arm/neoverse-v1/pipeline.json       |   23 +
 .../arch/arm64/armv8-common-and-microarch.json     |   72 +
 .../arch/arm64/hisilicon/hip08/metrics.json        |    2 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |   32 +-
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |  120 +-
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |   52 +-
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |    1 +
 tools/perf/pmu-events/arch/nds32/n13/atcpmu.json   |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z10/basic.json  |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z10/crypto.json |    2 +-
 .../perf/pmu-events/arch/s390/cf_z10/extended.json |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z13/basic.json  |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z13/crypto.json |    2 +-
 .../perf/pmu-events/arch/s390/cf_z13/extended.json |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z14/basic.json  |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z14/crypto.json |    2 +-
 .../perf/pmu-events/arch/s390/cf_z14/extended.json |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/basic.json  |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z15/crypto.json |    2 +-
 .../perf/pmu-events/arch/s390/cf_z15/crypto6.json  |    2 +-
 .../perf/pmu-events/arch/s390/cf_z15/extended.json |    2 +-
 tools/perf/pmu-events/arch/s390/cf_z196/basic.json |    2 +-
 .../perf/pmu-events/arch/s390/cf_z196/crypto.json  |    2 +-
 .../pmu-events/arch/s390/cf_z196/extended.json     |    2 +-
 .../perf/pmu-events/arch/s390/cf_zec12/basic.json  |    2 +-
 .../perf/pmu-events/arch/s390/cf_zec12/crypto.json |    2 +-
 .../pmu-events/arch/s390/cf_zec12/extended.json    |    2 +-
 .../pmu-events/arch/test/test_soc/cpu/uncore.json  |    2 +-
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |    7 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |    2 +-
 tools/perf/pmu-events/jevents.c                    |   32 +-
 tools/perf/pmu-events/jsmn.c                       |   43 +-
 tools/perf/pmu-events/pmu-events.h                 |    8 +-
 tools/perf/tests/backward-ring-buffer.c            |    3 +-
 tools/perf/tests/bpf.c                             |    3 +-
 tools/perf/tests/code-reading.c                    |    3 +-
 tools/perf/tests/expand-cgroup.c                   |    6 +-
 tools/perf/tests/expr.c                            |  163 ++-
 tools/perf/tests/mmap-thread-lookup.c              |    4 +-
 tools/perf/tests/parse-events.c                    |   14 +-
 tools/perf/tests/parse-metric.c                    |    2 +-
 tools/perf/tests/pmu-events.c                      |  206 ++-
 tools/perf/tests/sample-parsing.c                  |   43 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    6 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   12 +
 tools/perf/tests/shell/stat_all_metrics.sh         |   22 +
 tools/perf/tests/shell/stat_all_pmu.sh             |   22 +
 tools/perf/tests/shell/test_arm_coresight.sh       |   11 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    4 +-
 tools/perf/tests/topology.c                        |    2 +
 tools/perf/tests/vmlinux-kallsyms.c                |  102 ++
 tools/perf/trace/beauty/include/linux/socket.h     |    2 +
 tools/perf/util/Build                              |    6 +
 tools/perf/util/annotate.c                         |    9 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |    2 +-
 tools/perf/util/auxtrace.c                         |    3 +
 tools/perf/util/auxtrace.h                         |    6 +
 tools/perf/util/bpf-event.c                        |   45 +-
 tools/perf/util/bpf-event.h                        |    2 +-
 tools/perf/util/bpf-utils.c                        |  261 ++++
 tools/perf/util/bpf-utils.h                        |   76 +
 tools/perf/util/bpf_counter.c                      |   14 +-
 tools/perf/util/bpf_counter_cgroup.c               |    8 +-
 tools/perf/util/c++/clang.cpp                      |   21 +-
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/debug.c                            |   19 +
 tools/perf/util/dso.c                              |    1 +
 tools/perf/util/dso.h                              |    2 +-
 tools/perf/util/env.c                              |    1 +
 tools/perf/util/event.c                            |   18 +
 tools/perf/util/event.h                            |    5 +
 tools/perf/util/evsel.c                            |  133 +-
 tools/perf/util/evsel.h                            |   20 +
 tools/perf/util/evsel_fprintf.c                    |   12 +-
 tools/perf/util/expr.c                             |  159 ++-
 tools/perf/util/expr.h                             |   34 +-
 tools/perf/util/expr.l                             |   15 +-
 tools/perf/util/expr.y                             |  325 +++--
 tools/perf/util/genelf.h                           |    2 +-
 tools/perf/util/header.c                           |   13 +-
 tools/perf/util/intel-bts.c                        |    2 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |    1 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |    1 +
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    2 +-
 tools/perf/util/intel-pt-decoder/intel-pt-log.c    |    8 +-
 .../util/intel-pt-decoder/intel-pt-pkt-decoder.c   |    2 +-
 tools/perf/util/intel-pt.c                         |  106 +-
 tools/perf/util/machine.c                          |   10 +
 tools/perf/util/machine.h                          |    2 +
 tools/perf/util/metricgroup.c                      | 1454 ++++++++++++--------
 tools/perf/util/metricgroup.h                      |   37 +-
 tools/perf/util/mmap.c                             |   11 +
 tools/perf/util/mmap.h                             |    3 +
 tools/perf/util/parse-events-hybrid.c              |   34 +-
 tools/perf/util/parse-events-hybrid.h              |    6 +-
 tools/perf/util/parse-events.c                     |  392 ++++--
 tools/perf/util/parse-events.h                     |   27 +-
 tools/perf/util/parse-events.l                     |   19 +-
 tools/perf/util/parse-events.y                     |   27 +-
 tools/perf/util/pfm.c                              |    3 +-
 tools/perf/util/pmu.c                              |   59 +-
 tools/perf/util/pmu.h                              |   16 +-
 tools/perf/util/python-ext-sources                 |    1 +
 tools/perf/util/python.c                           |   12 +
 tools/perf/util/record.h                           |    1 +
 tools/perf/util/s390-cpumsf.c                      |    8 +-
 tools/perf/util/s390-sample-raw.c                  |    6 +-
 tools/perf/util/session.c                          |  198 ++-
 tools/perf/util/session.h                          |   10 +-
 tools/perf/util/srcline.c                          |  338 +++--
 tools/perf/util/stat-shadow.c                      |   76 +-
 tools/perf/util/symbol.c                           |   26 +
 tools/perf/util/symbol.h                           |    2 +
 tools/perf/util/synthetic-events.c                 |   73 +-
 tools/perf/util/synthetic-events.h                 |   20 +-
 tools/perf/util/tool.h                             |    1 +
 184 files changed, 5083 insertions(+), 1705 deletions(-)
 create mode 100644 tools/build/feature/test-libtracefs.c
 create mode 100644 tools/include/linux/list_sort.h
 create mode 100644 tools/lib/list_sort.c
 create mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
 create mode 100644 tools/perf/dlfilters/dlfilter-show-cycles.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/instruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/other.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/neoverse-v1/pipeline.json
 create mode 100755 tools/perf/tests/shell/stat_all_metricgroups.sh
 create mode 100755 tools/perf/tests/shell/stat_all_metrics.sh
 create mode 100755 tools/perf/tests/shell/stat_all_pmu.sh
 create mode 100644 tools/perf/util/bpf-utils.c
 create mode 100644 tools/perf/util/bpf-utils.h

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

There is also a strange one with openmandriva:cooker, where on the feature build
test it doesn't manage to find libpthread, looks like a distro problem, will keep
it there to see if a refreshed container cures this soon.

The tests were performed with a patch that will get upstream via the bpf tree:

  "bpftool: Install libbpf headers for the bootstrap version, too"

There is a new problem with the use of some new functions in the bpf codebase
that isn't present in the libbpf present in distros, so the LIBBPF_DYNAMIC=1
build is broken, will check how to resolve this with an upcoming fix.

Ubuntu 21.10 is failing with the newly added BUILD_BPF_SKEL=1, where clang is used
to generate BPF bytecode, this is being done with other flagship distro versions
and working, except on this case, to be investigated.

  # export BUILD_TARBALL=http://192.168.100.2/perf/perf-5.15.0.tar.xz
  $ grep -m1 "model name" /proc/cpuinfo 
  model name	: AMD Ryzen 9 5950X 16-Core Processor
  # dm 
   1    81.86 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
   2    56.58 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3    61.00 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4    58.50 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5    63.71 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6    64.72 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7    65.76 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8    91.30 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9   103.61 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10    97.45 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11   105.24 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12    90.80 alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13    91.91 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210921) 10.3.1 20210921 , Alpine clang version 12.0.1
  14    52.08 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  15    66.63 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  16    65.21 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 11.2.1 20210911 (ALT Sisyphus 11.2.1-alt1) , ALT Linux Team clang version 12.0.1
  17    53.37 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  18    76.15 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  19    82.77 centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+587+5187cac0)
  20    97.02 centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.1 (Red Hat 12.0.1-2.module_el8.6.0+937+1cafe22c)
  21    50.92 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20211027 releases/gcc-11.2.0-389-g5782bacaca , clang version 11.1.0
  22    65.73 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  23    61.51 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  24    75.05 debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  25    61.51 debian:experimental           : Ok   gcc (Debian 11.2.0-10) 11.2.0 , Debian clang version 11.1.0-4
  26    24.37 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  27    19.46 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  28    21.65 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  29    22.66 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 11.2.0-9) 11.2.0 
  30    22.04 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  31    57.48 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  32    68.03 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  33    18.03 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  34    69.11 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  35    80.34 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  36    81.45 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  37    93.49 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  38    97.70 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  39   108.42 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  40   100.50 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  41    85.28 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  42    85.06 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  43   101.61 fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
  44    20.15 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  45    18.54 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  46    90.19 fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
  47    90.40 fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20211019 (Red Hat 11.2.1-6) , clang version 13.0.0 (Fedora 13.0.0-4.fc36)
  48    29.78 gentoo-stage3:latest          : Ok   gcc (Gentoo 11.2.0 p1) 11.2.0 
  49    70.13 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  50    39.52 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.15.0/tools/build/Makefile.build:139: util] Error 2
  51    18.01 openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
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
    file: Compiled magic version [540] does not match with shared library magic version [539]
    
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
    file: Compiled magic version [540] does not match with shared library magic version [539]
    
    ld: warning: -r and --gc-sections may not be used together, disabling --gc-sections
    ld: warning: -r and --icf may not be used together, disabling --icf
  52   104.00 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  53   109.01 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  54   101.69 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1
  55    92.90 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  56    97.59 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.2.1 20210816 [revision 056e324ce46a7924b5cf10f61010cf9dd2ca10e9] , clang version 13.0.0
  57    82.17 oraclelinux:8                 : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1.0.4) , clang version 11.0.0 (Red Hat 11.0.0-1.0.1.module+el8.4.0+20046+39fed697)
  58    83.05 rockylinux:8                  : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+412+05cf643f)
  59    70.63 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  60    19.14 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  61    19.35 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  62    18.64 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  63    19.36 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  64    19.44 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  65    19.24 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  66    76.43 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  67    20.35 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  68    20.56 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  69    16.73 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  70    20.25 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71    27.57 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72    21.56 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73    99.43 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  74    18.34 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  75    20.13 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  76    18.44 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  77    28.11 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
  78    80.54 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
  79    86.86 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.2
  80    32.29 ubuntu:21.10                  : FAIL gcc version 11.2.0 (Ubuntu 11.2.0-7ubuntu2) 
    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bpf_prog_profiler.bpf.o
    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_leader.bpf.o
    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_follower.bpf.o
    CLANG   /tmp/build/perf/util/bpf_skel/.tmp/bperf_cgroup.bpf.o
  In file included from In file included from In file included from util/bpf_skel/bperf_leader.bpf.cutil/bpf_skel/bperf_follower.bpf.cutil/bpf_skel/bpf_prog_profiler.bpf.c:::333:
  :
  :
  In file included from In file included from In file included from /usr/include/linux/bpf.h/usr/include/linux/bpf.h/usr/include/linux/bpf.h:::111111:
      :
      /usr/include/linux/types.h/usr/include/linux/types.h/usr/include/linux/types.h:::555::10:10:10: :  fatal error: fatal error: fatal error: 'asm/types.h' file not found'asm/types.h' file not found'asm/types.h' file not found

  $ uname -a
  Linux quaco 5.13.13-200.fc34.x86_64 #1 SMP Thu Aug 26 17:06:39 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  $ git log --oneline -5
  2f63c8e8def8fc50 (HEAD -> perf/core, seventh/perf/core, five/perf/core) bpftool: Install libbpf headers for the bootstrap version, too
  6b491a86b77c0dc3 perf build: Install libbpf headers locally when building
  f174940488dd7409 perf MANIFEST: Add bpftool files to allow building with BUILD_BPF_SKEL=1
  aba8c5e38075fa0e perf metric: Fix memory leaks
  07eafd4e053a41d7 perf parse-event: Add init and exit to parse_event_error
  $ perf -v
  perf version 5.15.g2f63c8e8def8
  $ sudo su -
  [sudo] password for acme: 
  [root@quaco ~]# perf -vv
  perf version 5.15.g2f63c8e8def8
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
  [root@quaco ~]# perf test
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
  72: dlfilter C API                                                  : Ok
  73: x86 rdpmc                                                       : Ok
  74: DWARF unwind                                                    : Ok
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
  93: Check open filename arg using perf trace + vfs_getname          : Ok
  [root@quaco ~]# 

  $ git log --oneline -5
  2f63c8e8def8fc50 (HEAD -> perf/core) bpftool: Install libbpf headers for the bootstrap version, too
  6b491a86b77c0dc3 perf build: Install libbpf headers locally when building
  f174940488dd7409 perf MANIFEST: Add bpftool files to allow building with BUILD_BPF_SKEL=1
  aba8c5e38075fa0e perf metric: Fix memory leaks
  07eafd4e053a41d7 perf parse-event: Add init and exit to parse_event_error
  
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j32  DESTDIR=/tmp/tmp.6DELxcjdXI
                make_with_gtk2: make GTK2=1 -j32  DESTDIR=/tmp/tmp.Scg4WuMdit
             make_util_map_o_O: make util/map.o
                make_install_O: make install
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_clean_all_O: make clean all
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
                make_no_gtk2_O: make NO_GTK2=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
            make_install_bin_O: make install-bin
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
                  make_debug_O: make DEBUG=1
                    make_doc_O: make doc
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
         make_install_prefix_O: make install prefix=/tmp/krava
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
             make_no_libperl_O: make NO_LIBPERL=1
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
                 make_perf_o_O: make perf.o
                   make_pure_O: make
              make_no_libelf_O: make NO_LIBELF=1
           make_with_libpfm4_O: make LIBPFM4=1
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
                   make_help_O: make help
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
            make_no_demangle_O: make NO_DEMANGLE=1
               make_no_slang_O: make NO_SLANG=1
                 make_no_sdt_O: make NO_SDT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
           make_no_libpython_O: make NO_LIBPYTHON=1
           make_no_backtrace_O: make NO_BACKTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
         make_with_coresight_O: make CORESIGHT=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1

            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `bpf__probe':
            /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:639: undefined reference to `bpf_object__next_program'
            /usr/bin/ld: /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:639: undefined reference to `bpf_object__next_program'
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `bpf__unprobe':
            /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:692: undefined reference to `bpf_object__next_program'
            /usr/bin/ld: /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:692: undefined reference to `bpf_object__next_program'
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `bpf__foreach_event':
            /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:748: undefined reference to `bpf_object__next_program'
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o:/var/home/acme/git/perf/tools/perf/util/bpf-loader.c:748: more undefined references to `bpf_object__next_program' follow
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `apply_obj_config_object':
            /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:1488: undefined reference to `bpf_object__next_map'
            /usr/bin/ld: /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:1488: undefined reference to `bpf_object__next_map'
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `bpf__setup_output_event':
            /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:1529: undefined reference to `bpf_object__next_map'
            /usr/bin/ld: /var/home/acme/git/perf/tools/perf/util/bpf-loader.c:1565: undefined reference to `bpf_object__next_map'
            /usr/bin/ld: /tmp/tmp.jyOMbF90Eb/perf-in.o: in function `perf_env__fetch_btf':
            /var/home/acme/git/perf/tools/perf/util/bpf-event.c:112: undefined reference to `btf__raw_data'
            /usr/bin/ld: /var/home/acme/git/perf/tools/perf/util/bpf-event.c:112: undefined reference to `btf__raw_data'
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  $
