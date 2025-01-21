Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EA4187FE4;
	Tue, 21 Jan 2025 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498944; cv=none; b=FbgEFpEHffjwVfT9o7sBruieghIcNZtHRFsBnyhta53b5VIlf2QJSv5h3tynmwPjy8LAA7IBFtks/c5QbPZjp0lkNoWVt71D2dpP5nqT7iD9Yudfsh7O7q3IwPzCzYGZc3EyCL8vnnHPc7D3gyH1+OF/AhJeoFx7ijw+x/45Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498944; c=relaxed/simple;
	bh=EX4BlLKaQ/hCEkFlCOodG34MQtFOaELh0sH6iyH9f9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q3wOYOXomPTzgjww3Jms9fuvAwnFhht6oKk4q2BVCRbySRJLegcaiAuqJxRCTP542l2hYaHkIys1gS+JmQ9PywiTlp3Pi+TKrZJj2uf6BxZIIuwsbNGuLi9adAPZcFpL/+VGe0CehzUvgoE4YpTe4pJCl0FEXRwow2wXDUB1bs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiE3S0A0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiE3S0A0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E4BC4CEDF;
	Tue, 21 Jan 2025 22:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737498942;
	bh=EX4BlLKaQ/hCEkFlCOodG34MQtFOaELh0sH6iyH9f9U=;
	h=From:To:Cc:Subject:Date:From;
	b=AiE3S0A0BgTDsrxW91nOhJetCdmP2p6zCwj9+XgvvSJ3HmYBkiViHw+HuHH94FWzA
	 9x7ILQ9f07N49DO55hcpnhEmYc0ooOMSLTxpm6yoTf3UIeLeFY5CllPWT8QHvGUhRN
	 E0WMCh3SJhWEow7kLPBmhvHG9IwDCdpU5UVF0J6K3rw5B1FeITiZD4YcOq7m90WHlc
	 t4u/qjtxG4WLzSPvrIKFY7xHWFoEhUSrtC7hKRBsF2yg/Rn7i0JXsK00dwfkxB91yk
	 JeCT0O9bJaqSdyEJc5QXnlzcBvFABkRHeWOi3mvv4DwjTdQjDojp84WD/AAvmB+Ajv
	 awN4eKmk0Jx9w==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools for v6.14
Date: Tue, 21 Jan 2025 14:35:39 -0800
Message-ID: <20250121223539.358798-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.48.0.rc2.279.g1de40edade-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.14.

Thanks,
Namhyung


The following changes since commit f932fb9b40749d1c9a539d89bb3e288c077aafe5:

  Merge tag 'v6.13-rc2-ksmbd-server-fixes' of git://git.samba.org/ksmbd (2024-12-12 17:33:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.14-2025-01-21

for you to fetch changes up to 91b7747dc70d64b5ec56ffe493310f207e7ffc99:

  perf test: Update event_groups test to use instructions (2025-01-18 10:32:57 -0800)

----------------------------------------------------------------
perf-tools changes for v6.14

There are a lot of changes in the perf tools in this cycle.

build
-----
* Use generic syscall table to generate syscall numbers on supported archs.
* This also enables to get rid of libaudit which was used for syscall numbers.
* Remove python2 support as it's deprecated for years.
* Fix issues on static build with libzstd.

perf record
-----------
* Intel-PT supports "aux-action" config term to pause or resume tracing in
  the aux-buffer.  Users can start the intel_pt event as "started-paused" and
  configure other events to control the Intel-PT tracing.

    # perf record --kcore -e intel_pt/aux-action=start-paused/   \
        -e syscalls:sys_enter_newuname/aux-action=resume/        \
        -e syscalls:sys_exit_newuname/aux-action=pause/ -- uname

  This requires the kernel support (which was added in v6.13).

perf lock
---------
* 'perf lock contention' command has an ability to symbolize locks in
  dynamically allocated objects using slab cache name when it runs with BPF.
  Those dynamic locks would have "&" prefix in the name to distinguish them
  from ordinary (static) locks.

    # perf lock con -abl -E 5 sleep 1
       contended   total wait     max wait     avg wait            address   symbol

               2      1.95 us      1.77 us       975 ns   ffff9d5e852d3498   &task_struct (mutex)
               1      1.18 us      1.18 us      1.18 us   ffff9d5e852d3538   &task_struct (mutex)
               4      1.12 us       354 ns       279 ns   ffff9d5e841ca800   &kmalloc-cg-512 (mutex)
               2       859 ns       617 ns       429 ns   ffffffffa41c3620   delayed_uprobe_lock (mutex)
               3       691 ns       388 ns       230 ns   ffffffffa41c0940   pack_mutex (mutex)

  This also requires the kernel/BPF support (which was added in v6.13).

perf ftrace
-----------
* 'perf ftrace latency' command gets a couple of options to support linear
  buckets instead of exponential.  Also it's possible to specify max and
  min latency for the linear buckets.

    # perf ftrace latency -abn -T switch_mm_irqs_off --bucket-range=100   \
        --min-latency=200 --max-latency=800 -- sleep 1
    #   DURATION     |      COUNT | GRAPH                                  |
         0 -  200 ns |        186 | ###                                    |
       200 -  300 ns |        256 | #####                                  |
       300 -  400 ns |        364 | #######                                |
       400 -  500 ns |        223 | ####                                   |
       500 -  600 ns |        111 | ##                                     |
       600 -  700 ns |         41 |                                        |
       700 -  800 ns |        141 | ##                                     |
       800 -  ... ns |        169 | ###                                    |

    # statistics  (in nsec)
      total time:              2162212
        avg time:                  967
        max time:                16817
        min time:                  132
           count:                 2236

* As you can see in the above example, it nows shows the statistics at the
  end so that users can see the avg/max/min latencies easily.

* 'perf ftrace profile' command has --graph-opts option like 'perf ftrace
  trace' so that it can control the tracing behaviors in the same way.
  For example, it can limit the function call depth or threshold.

perf script
-----------
* Improve physical memory resolution in 'mem-phys-addr' script by parsing
  /proc/iomem file.

    # perf script mem-phys-addr -- find /
    ...
    Event: mem_inst_retired.all_loads:P
    Memory type                                    count  percentage
    ----------------------------------------  ----------  ----------
    100000000-85f7fffff : System RAM                8929        69.7
      547600000-54785d23f : Kernel data             1240         9.7
      546a00000-5474bdfff : Kernel rodata            490         3.8
      5480ce000-5485fffff : Kernel bss               121         0.9
    0-fff : Reserved                                3860        30.1
    100000-89c01fff : System RAM                      18         0.1
    8a22c000-8df6efff : System RAM                     5         0.0

Others
------
* 'perf test' gets --runs-per-test option to run the test cases repeatedly.
  This would be helpful to see if it's flaky.

* Add 'parse_events' method to Python perf extension module, so that users
  can use the same event parsing logic in the python code.  One more step
  towards implementing perf tools in Python. :)

* Support opening tracepoint events without libtraceevent.  This will be
  helpful if it won't use the tracing data like in 'perf stat'.

* Update ARM Neoverse N2/V2 JSON events and metrics

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Adrian Hunter (7):
      perf tools: Add aux_start_paused, aux_pause and aux_resume
      perf tools: Add aux-action config term
      perf tools: Parse aux-action
      perf tools: Add missing_features for aux_start_paused, aux_pause, aux_resume
      perf intel-pt: Improve man page format
      perf intel-pt: Add documentation for pause / resume
      perf intel-pt: Add a test for pause / resume

Arnaldo Carvalho de Melo (23):
      tools features: Don't check for libunwind devel files by default
      perf disasm: Return a proper error when not determining the file type
      perf config: Fix trival typo 'an' -> 'can'
      perf btf: Make the sigtrap test helper to find a member by name widely available
      perf ftrace latency: Pass ftrace pointer to histogram routines to pass more args
      perf ftrace latency: Introduce --bucket-range to ask for linear bucketing
      perf ftrace latency: Introduce --min-latency to narrow down into a latency range
      tools build: Remove the libunwind feature tests from the ones detected when test-all.o builds
      tools build feature: Add some comments to explain the FEATURE_TESTS logic
      tools build feature: Don't set feature-libcap=1 if libcap-devel isn't available
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf tests switch-tracking: Set this test to run exclusively
      tools build feature: Don't set feature-libslang-include-subdir=1 if test-all.c builds
      tools build: Test for presence of libtraceevent and libtracefs in test-all.c
      perf script: Cache the output type
      perf top: Don't complain about lack of vmlinux when not resolving some kernel samples
      perf tests shell task_analyzer: Run this test exclusively
      perf jitdump: Accept jitdump mmaps emitted from inside containers
      perf namespaces: Introduce nsinfo__set_in_pidns()
      perf jitdump: Fixup in_pidns member when java agent and 'perf record' are not in the same pidns
      perf namespaces: Fixup the nsinfo__in_pidns() return type, its bool
      perf MANIFEST: Add arch/*/include/uapi/asm/bpf_perf_event.h to the perf tarball
      perf config: Add a function to set one variable in .perfconfig

Athira Rajeev (6):
      perf tools arch powerpc: Add register mask for power11 PVR in extended regs
      perf tools tests shell base_probe: Enhance print_overall_results to print summary information
      perf tests base_probe: Fix check for the count of existing probes in test_adding_kernel
      perf record: Fix segfault with --off-cpu when debuginfo is not enabled
      perf lock: Fix return code for functions in __cmd_contention
      perf test: Update event_groups test to use instructions

Charlie Jenkins (19):
      perf tests code-reading: Handle change in objdump output from binutils >= 2.41 on riscv
      perf tools: Create generic syscall table support
      perf tools arc: Support generic syscall headers
      perf tools csky: Support generic syscall headers
      perf tools arm: Support syscall headers
      perf tools sh: Support syscall headers
      perf tools sparc: Support syscall headers
      perf tools xtensa: Support syscall header
      perf tools x86: Use generic syscall scripts
      perf tools alpha: Support syscall header
      perf tools parisc: Support syscall header
      perf tools arm64: Use syscall table
      perf tools loongarch: Use syscall table
      perf tools mips: Use generic syscall scripts
      perf tools powerpc: Use generic syscall table scripts
      perf tools s390: Use generic syscall table scripts
      perf tools: Remove dependency on libaudit
      perf tools mips: Fix mips syscall generation
      perf tools: Expose quiet/verbose variables in Makefile.perf

Christophe Leroy (2):
      perf maps: Fix display of kernel symbols
      perf machine: Don't ignore _etext when not a text symbol

Chun-Tse Shao (3):
      perf lock: Fix parse_lock_type which only retrieve one lock flag
      perf lock: Add percpu-rwsem for type filter
      perf lock: Rename fields in lock_type_table

Dmitry Vyukov (4):
      perf llvm-add2line: Remove unused symbol_conf.h include
      perf hist: Deduplicate cmp/sort/collapse code
      perf hist: Fix bogus profiles when filters are enabled
      perf hist: Fix width calculation in hpp__fmt()

Dr. David Alan Gilbert (1):
      perf path: Remove unused is_executable_file()

Gabriele Monaco (1):
      perf ftrace latency: Add --max-latency option

Howard Chu (2):
      perf trace: Add tests for BTF general augmentation
      perf docs: Add documentation for --force-btf option

Ian Rogers (56):
      perf script python: Improve physical mem type resolution
      perf cpumap: Reduce transitive dependencies on libperf MAX_NR_CPUS
      libperf cpumap: Hide/reduce scope of MAX_NR_CPUS
      libperf cpumap: Be tolerant of newline at the end of a cpumask
      perf pmu: Remove use of perf_cpu_map__read()
      libperf cpumap: Remove use of perf_cpu_map__read()
      libperf cpumap: Remove perf_cpu_map__read()
      libperf cpumap: Grow array of read CPUs in smaller increments
      perf env: Ensure failure broken topology file reads are always -1 encoded
      tool api fs: Correctly encode errno for read/write open failures
      perf trace-event: Constify print arguments
      perf trace-event: Always build trace-event-info.c
      perf evsel: Add/use accessor for tp_format
      perf evsel: Allow evsel__newtp without libtraceevent
      perf tests: Enable tests disabled due to tracepoint parsing
      perf hwmon_pmu: Use openat rather than dup to refresh directory
      perf test hwmon_pmu: Fix event file location
      perf jevents: Fix build issue in '*/' in event descriptions
      perf string: Avoid undefined NULL+1
      perf python: Remove python 2 scripting support
      perf python: Constify variables and parameters
      perf python: Remove unused #include
      perf script: Move scripting_max_stack out of builtin
      perf kvm: Move functions used in util out of builtin
      perf script: Use openat for directory iteration
      perf script: Move find_scripts to browser/scripts.c
      perf stat: Move stat_config into config.c
      perf script: Move script_spec code to trace-event-scripting.c
      perf script: Move script_fetch_insn to trace-event-scripting.c
      perf script: Move perf_sample__sprintf_flags to trace-event-scripting.c
      perf x86: Define arch_fetch_insn in NO_AUXTRACE builds
      perf intel-pt: Remove stale build comment
      perf env: Move arch errno function to only use in env
      perf lock: Move common lock contention code to new file
      perf bench: Remove reference to cmd_inject
      perf kwork: Make perf_kwork_add_work a callback
      perf build: Remove test library from python shared object
      perf python: Add parse_events function
      perf python: Add __str__ and __repr__ functions to evlist
      perf python: Add __str__ and __repr__ functions to evsel
      perf python: Correctly throw IndexError
      perf jevents: Provide better path information for broken JSON
      perf Documentation: Describe the PMU naming convention
      perf stream: Use evsel rather than evsel->idx
      perf values: Use evsel rather than evsel->idx
      perf evsel: Improve the evsel__open_strerror() for EBUSY
      perf test cpumap: Avoid use-after-free following merge
      perf symbol-elf: Avoid a weak cxx_demangle_sym function
      perf test stat: Avoid hybrid assumption when virtualized
      perf inject: Fix use without initialization of local variables
      perf test: Rename functions and variables for better clarity
      perf test: Send list output to stdout rather than stderr
      perf test: Fix parallel/sequential option documentation
      perf test: Add a runs-per-test flag
      perf test: Improve verbose documentation
      perf annotate: Prefer passing evsel to evsel->core.idx

Ilkka Koskinen (2):
      perf arm-spe: Prepare for adding data source packet implementations for other cores
      perf arm-spe: Add support for SPE Data Source packet on AmpereOne

James Clark (13):
      perf vendor events arm64: Update N2/V2 events from source
      perf stat: Fix trailing comma when there is no metric unit
      perf stat: Also hide metric-units from JSON when event didn't run
      perf stat: Remove empty new_line_metric function
      perf stat: Document and simplify interval timestamps
      perf stat: Document and clarify outstate members
      perf test trace_btf_general: Fix shellcheck warning
      perf test: Mark remaining probe tests as exclusive
      perf tools arm-spe: Pull out functions for aux buffer and tracking setup
      perf tools arm-spe: Don't allocate buffer or tracking event in discard mode
      perf tests arm_spe: Add test for discard mode
      perf test brstack: Speed up running test by using tr -s instead of xargs
      perf probe: Rename err label

Jiachen Zhang (1):
      perf report: Fix misleading help message about --demangle

Jiapeng Chong (1):
      perf tests: Fix an incorrect type in append_script()

Kuan-Wei Chiu (1):
      perf bench: Fix undefined behavior in cmpworker()

Kyle Meyer (1):
      perf: Increase MAX_NR_CPUS to 4096

Leo Yan (7):
      libperf cpumap: Refactor perf_cpu_map__merge()
      perf cpumap: Add more tests for CPU map merging
      perf cpumap: Add checking for reference counter
      tools build: Add feature test for libelf with ZSTD
      perf build: Minor improvement for linking libzstd
      bpftool: Link zstd lib required by libelf
      perf test record+probe_libc_inet_pton: Make test resilient

Levi Yun (1):
      perf expr: Initialize is_test value in expr__ctx_new()

Masami Hiramatsu (Google) (1):
      perf probe: Replace unacceptable characters when generating event name

Michel Lind (1):
      perf MANIFEST: Add license files

Namhyung Kim (14):
      perf tools: Avoid unaligned pointer operations
      perf ftrace latency: Fix compiler error for clang 12
      perf lock contention: Add and use LCB_F_TYPE_MASK
      perf lock contention: Run BPF slab cache iterator
      perf lock contention: Resolve slab object name using BPF
      perf lock contention: Handle slab objects in -L/--lock-filter option
      perf ftrace: Display latency statistics at the end
      perf ftrace profile: Add --graph-opts option
      perf test: Update ftrace test to use --graph-opts
      perf trace: Fix unaligned access for augmented args
      perf symbol: Prefer non-label symbols with same address
      perf tools: Fixup end address of modules
      perf ftrace: Check min/max latency only with bucket range
      perf ftrace: Fix display for range of the first bucket

Randy Dunlap (1):
      perf Documentation: Clarify sysfs event names characters

Ravi Bangoria (1):
      perf test: Introduce DEFINE_SUITE_EXCLUSIVE()

Ruffalo Lavoisier (1):
      perf test: Remove duplicate word

Veronika Molnarova (3):
      perf test: Parse 'perf stat' Topdown events for aarch64
      perf test perftool_testsuite: Add missing description
      perf test perftool_testsuite: Return correct value for skipping

Yoshihiro Furudera (1):
      perf vendor events arm64: Add FUJITSU-MONAKA PMU event

Zhongqiu Han (3):
      perf header: Fix one memory leakage in process_bpf_btf()
      perf header: Fix one memory leakage in process_bpf_prog_info()
      perf bpf: Fix two memory leakages when calling perf_env__insert_bpf_prog_info()

 .../ABI/testing/sysfs-bus-event_source-devices     |  24 +
 .../testing/sysfs-bus-event_source-devices-events  |  10 +-
 Documentation/admin-guide/workload-tracing.rst     |   2 +-
 tools/bpf/bpftool/Makefile                         |   7 +
 tools/build/Build.include                          |   2 +
 tools/build/Makefile.build                         |  20 -
 tools/build/Makefile.feature                       |  46 +-
 tools/build/feature/Makefile                       |  10 +-
 tools/build/feature/test-all.c                     |  15 +-
 tools/build/feature/test-libaudit.c                |  11 -
 tools/build/feature/test-libelf-zstd.c             |   9 +
 tools/lib/api/fs/fs.c                              |   6 +-
 tools/lib/perf/Documentation/libperf.txt           |   1 -
 tools/lib/perf/cpumap.c                            | 131 ++--
 tools/lib/perf/evlist.c                            |   2 +-
 tools/lib/perf/include/internal/cpumap.h           |   4 -
 tools/lib/perf/include/perf/cpumap.h               |   6 +-
 tools/lib/perf/libperf.map                         |   1 -
 tools/perf/Documentation/perf-check.txt            |   2 -
 tools/perf/Documentation/perf-config.txt           |   2 +-
 tools/perf/Documentation/perf-ftrace.txt           |  19 +
 tools/perf/Documentation/perf-intel-pt.txt         | 596 ++++++++++-------
 tools/perf/Documentation/perf-lock.txt             |   4 +-
 tools/perf/Documentation/perf-record.txt           |   4 +
 tools/perf/Documentation/perf-test.txt             |  20 +-
 tools/perf/Documentation/perf-trace.txt            |   5 +
 tools/perf/MANIFEST                                |   3 +
 tools/perf/Makefile.config                         | 132 ++--
 tools/perf/Makefile.perf                           |  56 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 +++++++++++++++
 tools/perf/arch/alpha/include/syscall_table.h      |   2 +
 tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
 .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
 tools/perf/arch/arc/include/syscall_table.h        |   2 +
 tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 ++++++++++++++
 tools/perf/arch/arm/include/syscall_table.h        |   2 +
 tools/perf/arch/arm64/Makefile                     |  22 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
 .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 ++++++++++++++
 .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/arm64/include/syscall_table.h      |   8 +
 tools/perf/arch/arm64/util/arm-spe.c               |  90 ++-
 tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
 .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
 tools/perf/arch/csky/include/syscall_table.h       |   2 +
 tools/perf/arch/loongarch/Makefile                 |  22 -
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
 tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
 tools/perf/arch/mips/Makefile                      |  18 -
 tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
 .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 -
 tools/perf/arch/mips/include/syscall_table.h       |   2 +
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++
 tools/perf/arch/parisc/include/syscall_table.h     |   8 +
 tools/perf/arch/powerpc/Makefile                   |  25 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
 tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
 tools/perf/arch/powerpc/util/perf_regs.c           |   3 +-
 tools/perf/arch/riscv/Makefile                     |  22 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/arch/s390/Makefile                      |  21 -
 tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
 .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 -
 tools/perf/arch/s390/include/syscall_table.h       |   2 +
 tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 ++++++++++++++
 tools/perf/arch/sh/include/syscall_table.h         |   2 +
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/arch/x86/Build                          |   1 -
 tools/perf/arch/x86/Makefile                       |  25 -
 tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
 tools/perf/arch/x86/include/syscall_table.h        |   8 +
 tools/perf/arch/x86/util/Build                     |   2 +-
 tools/perf/arch/x86/util/iostat.c                  |   4 +
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 +++++++++++++
 tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
 tools/perf/bench/epoll-wait.c                      |   7 +-
 tools/perf/bench/inject-buildid.c                  |  13 +-
 tools/perf/builtin-annotate.c                      |   1 +
 tools/perf/builtin-check.c                         |   2 -
 tools/perf/builtin-config.c                        |  38 ++
 tools/perf/builtin-diff.c                          |   5 +-
 tools/perf/builtin-ftrace.c                        | 149 ++++-
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-inject.c                        |   8 +-
 tools/perf/builtin-kmem.c                          |  12 +-
 tools/perf/builtin-kvm.c                           |  61 --
 tools/perf/builtin-kwork.c                         |   7 +-
 tools/perf/builtin-lock.c                          | 281 +++-----
 tools/perf/builtin-mem.c                           |   1 +
 tools/perf/builtin-record.c                        |   6 +-
 tools/perf/builtin-report.c                        |   6 +-
 tools/perf/builtin-sched.c                         |   1 +
 tools/perf/builtin-script.c                        | 404 ++----------
 tools/perf/builtin-stat.c                          |  27 -
 tools/perf/builtin-top.c                           |   6 +-
 tools/perf/builtin-trace.c                         | 131 ++--
 tools/perf/builtin.h                               |   6 -
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/perf.h                                  |   2 +-
 .../arch/arm64/arm/neoverse-n2-v2/exception.json   |   2 +-
 .../arch/arm64/arm/neoverse-n2-v2/general.json     |   2 +-
 .../arch/arm64/arm/neoverse-n2-v2/l1d_cache.json   |   6 +-
 .../arch/arm64/arm/neoverse-n2-v2/l2_cache.json    |  14 +-
 .../arch/arm64/arm/neoverse-n2-v2/l3_cache.json    |   4 +-
 .../arch/arm64/arm/neoverse-n2-v2/ll_cache.json    |   4 +-
 .../arch/arm64/arm/neoverse-n2-v2/memory.json      |   2 +-
 .../arch/arm64/arm/neoverse-n2-v2/metrics.json     |  93 +--
 .../arch/arm64/arm/neoverse-n2-v2/retired.json     |   4 +-
 .../arm64/arm/neoverse-n2-v2/spec_operation.json   |  14 +-
 .../arch/arm64/arm/neoverse-n2-v2/stall.json       |   8 +-
 .../arch/arm64/arm/neoverse-n2-v2/tlb.json         |   4 +-
 .../arch/arm64/common-and-microarch.json           | 715 +++++++++++++++++++++
 .../arch/arm64/fujitsu/monaka/core-imp-def.json    |   6 +
 .../arm64/fujitsu/monaka/cycle_accounting.json     | 122 ++++
 .../arch/arm64/fujitsu/monaka/energy.json          |  17 +
 .../arch/arm64/fujitsu/monaka/exception.json       |  42 ++
 .../arch/arm64/fujitsu/monaka/fp_operation.json    | 209 ++++++
 .../arch/arm64/fujitsu/monaka/gcycle.json          |  97 +++
 .../arch/arm64/fujitsu/monaka/general.json         |  10 +
 .../pmu-events/arch/arm64/fujitsu/monaka/hwpf.json |  52 ++
 .../arch/arm64/fujitsu/monaka/l1d_cache.json       | 113 ++++
 .../arch/arm64/fujitsu/monaka/l1i_cache.json       |  52 ++
 .../arch/arm64/fujitsu/monaka/l2_cache.json        | 160 +++++
 .../arch/arm64/fujitsu/monaka/l3_cache.json        | 159 +++++
 .../arch/arm64/fujitsu/monaka/ll_cache.json        |  10 +
 .../arch/arm64/fujitsu/monaka/memory.json          |  10 +
 .../arch/arm64/fujitsu/monaka/pipeline.json        | 208 ++++++
 .../pmu-events/arch/arm64/fujitsu/monaka/pmu.json  |  10 +
 .../arch/arm64/fujitsu/monaka/retired.json         |  30 +
 .../arch/arm64/fujitsu/monaka/spec_operation.json  | 171 +++++
 .../arch/arm64/fujitsu/monaka/stall.json           |  94 +++
 .../pmu-events/arch/arm64/fujitsu/monaka/sve.json  | 254 ++++++++
 .../pmu-events/arch/arm64/fujitsu/monaka/tlb.json  | 362 +++++++++++
 .../arch/arm64/fujitsu/monaka/trace.json           |  18 +
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 tools/perf/pmu-events/arch/arm64/recommended.json  |   5 +
 tools/perf/pmu-events/jevents.py                   |  16 +-
 tools/perf/scripts/Makefile.syscalls               |  61 ++
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |  20 +-
 tools/perf/scripts/python/mem-phys-addr.py         | 177 ++---
 tools/perf/scripts/syscalltbl.sh                   |  86 +++
 tools/perf/tests/Build                             |   6 +-
 tools/perf/tests/builtin-test.c                    | 225 +++----
 tools/perf/tests/code-reading.c                    |  92 ++-
 tools/perf/tests/cpumap.c                          |  62 +-
 tools/perf/tests/event_groups.c                    |  31 +-
 tools/perf/tests/make                              |   7 +-
 tools/perf/tests/parse-events.c                    |  25 +-
 .../shell/base_probe/test_adding_blacklisted.sh    |   4 +-
 .../tests/shell/base_probe/test_adding_kernel.sh   |   8 +-
 tools/perf/tests/shell/base_probe/test_basic.sh    |   4 +-
 .../tests/shell/base_probe/test_invalid_options.sh |   9 +-
 .../tests/shell/base_probe/test_line_semantics.sh  |   9 +-
 tools/perf/tests/shell/base_report/setup.sh        |   2 +-
 tools/perf/tests/shell/base_report/test_basic.sh   |   2 +-
 tools/perf/tests/shell/common/init.sh              |   7 +-
 tools/perf/tests/shell/coresight/Makefile          |   2 +-
 tools/perf/tests/shell/ftrace.sh                   |   5 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |  14 +-
 tools/perf/tests/shell/perftool-testsuite_probe.sh |   2 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |  36 +-
 tools/perf/tests/shell/stat+std_output.sh          |   2 +-
 tools/perf/tests/shell/stat.sh                     |   6 +-
 tools/perf/tests/shell/test_arm_spe.sh             |  30 +
 tools/perf/tests/shell/test_brstack.sh             |   4 +-
 tools/perf/tests/shell/test_intel_pt.sh            |  28 +
 tools/perf/tests/shell/test_task_analyzer.sh       |   2 +-
 tools/perf/tests/shell/trace_btf_general.sh        |  94 +++
 tools/perf/tests/sigtrap.c                         |  20 +-
 tools/perf/tests/stat.c                            |  16 +-
 tools/perf/tests/switch-tracking.c                 |   2 +-
 tools/perf/tests/tests-scripts.c                   |   2 +-
 tools/perf/tests/tests.h                           |  10 +
 tools/perf/tests/workloads/landlock.c              |   2 +-
 tools/perf/trace/beauty/arch_errno_names.sh        |   3 +-
 tools/perf/ui/browsers/annotate.c                  |   2 +-
 tools/perf/ui/browsers/scripts.c                   | 177 ++++-
 tools/perf/ui/gtk/annotate.c                       |  16 +-
 tools/perf/ui/hist.c                               |   2 +-
 tools/perf/util/Build                              |   7 +-
 tools/perf/util/annotate.c                         |  32 +-
 tools/perf/util/annotate.h                         |  21 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   9 +
 tools/perf/util/arm-spe.c                          |  86 ++-
 tools/perf/util/auxtrace.c                         |  67 +-
 tools/perf/util/auxtrace.h                         |   6 +-
 tools/perf/util/bpf-event.c                        |  10 +-
 tools/perf/util/bpf_ftrace.c                       |  15 +-
 tools/perf/util/bpf_kwork.c                        |   2 +-
 tools/perf/util/bpf_kwork_top.c                    |   2 +-
 tools/perf/util/bpf_lock_contention.c              | 142 +++-
 tools/perf/util/bpf_off_cpu.c                      |   5 +
 tools/perf/util/bpf_skel/func_latency.bpf.c        |  46 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c           |   4 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |  95 ++-
 tools/perf/util/bpf_skel/lock_data.h               |  15 +-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |   8 +
 tools/perf/util/btf.c                              |  27 +
 tools/perf/util/btf.h                              |  10 +
 tools/perf/util/cgroup.c                           |   2 +-
 tools/perf/util/config.c                           |  27 +
 tools/perf/util/config.h                           |   1 +
 tools/perf/util/data-convert-bt.c                  |  10 +-
 tools/perf/util/data-convert-json.c                |   8 +-
 tools/perf/util/disasm.c                           |   5 +-
 tools/perf/util/dlfilter.c                         |   3 +-
 tools/perf/util/env.c                              |  30 +-
 tools/perf/util/env.h                              |   6 +-
 tools/perf/util/evsel.c                            | 310 +++++++--
 tools/perf/util/evsel.h                            |  13 +-
 tools/perf/util/evsel_config.h                     |   1 +
 tools/perf/util/evsel_fprintf.c                    |   4 +-
 tools/perf/util/expr.c                             |   5 +-
 tools/perf/util/ftrace.h                           |   9 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/header.c                           |   8 +-
 tools/perf/util/hist.c                             | 114 ++--
 tools/perf/util/hist.h                             |  14 +-
 tools/perf/util/intel-pt-decoder/Build             |  18 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   3 -
 tools/perf/util/jitdump.c                          |  15 +-
 tools/perf/util/kvm-stat.c                         |  70 ++
 tools/perf/util/kvm-stat.h                         |   3 +
 tools/perf/util/kwork.h                            |   7 +-
 tools/perf/util/llvm-c-helpers.cpp                 |   1 -
 tools/perf/util/lock-contention.c                  | 143 +++++
 tools/perf/util/lock-contention.h                  |  20 +-
 tools/perf/util/machine.c                          |   4 +-
 tools/perf/util/maps.c                             |   7 +-
 tools/perf/util/mem-events.c                       |   5 +-
 tools/perf/util/namespaces.c                       |   7 +-
 tools/perf/util/namespaces.h                       |   3 +-
 tools/perf/util/parse-events.c                     |  26 +-
 tools/perf/util/parse-events.h                     |   1 +
 tools/perf/util/parse-events.l                     |   1 +
 tools/perf/util/path.c                             |   8 +-
 tools/perf/util/path.h                             |   2 +-
 tools/perf/util/perf_event_attr_fprintf.c          |   7 +-
 tools/perf/util/pmu.c                              |  31 +-
 tools/perf/util/probe-event.c                      |  50 +-
 tools/perf/util/probe-event.h                      |   1 +
 tools/perf/util/probe-finder.c                     |  15 +
 tools/perf/util/probe-finder.h                     |   5 +
 tools/perf/util/python.c                           | 341 +++++-----
 .../perf/util/scripting-engines/trace-event-perl.c |   3 +-
 .../util/scripting-engines/trace-event-python.c    |  66 +-
 tools/perf/util/session.c                          |   1 +
 tools/perf/util/sort.c                             |  33 +-
 tools/perf/util/stat-display.c                     | 242 +++----
 tools/perf/util/stat-shadow.c                      |   5 +-
 tools/perf/util/stat.h                             |   3 +-
 tools/perf/util/stream.c                           |   7 +-
 tools/perf/util/stream.h                           |  10 +-
 tools/perf/util/string.c                           |  15 +-
 tools/perf/util/svghelper.c                        |   1 +
 tools/perf/util/symbol-elf.c                       |   6 +-
 tools/perf/util/symbol.c                           |   9 +-
 tools/perf/util/synthetic-events.c                 |  14 +-
 tools/perf/util/syscalltbl.c                       |  90 +--
 tools/perf/util/syscalltbl.h                       |   1 -
 tools/perf/util/trace-event-parse.c                |   2 +-
 tools/perf/util/trace-event-scripting.c            | 187 +++++-
 tools/perf/util/trace-event.h                      |   7 +-
 tools/perf/util/values.c                           | 106 ++-
 tools/perf/util/values.h                           |   9 +-
 tools/scripts/syscall.tbl                          | 409 ++++++++++++
 293 files changed, 11043 insertions(+), 2975 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-event_source-devices
 delete mode 100644 tools/build/feature/test-libaudit.c
 create mode 100644 tools/build/feature/test-libelf-zstd.c
 create mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/alpha/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 create mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/arc/include/syscall_table.h
 create mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/arm/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/arm/include/syscall_table.h
 create mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
 create mode 120000 tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl
 create mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 create mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/csky/include/syscall_table.h
 create mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/Makefile
 create mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
 delete mode 100644 tools/perf/arch/mips/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/mips/include/syscall_table.h
 create mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/parisc/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 create mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/powerpc/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 create mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 create mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/s390/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/s390/include/syscall_table.h
 create mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/sh/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/sh/include/syscall_table.h
 create mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/sparc/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 create mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
 delete mode 100755 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh
 create mode 100644 tools/perf/arch/x86/include/syscall_table.h
 create mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
 create mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
 create mode 100644 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
 create mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/core-imp-def.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/cycle_accounting.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/energy.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/gcycle.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/hwpf.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l2_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/l3_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/sve.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/tlb.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/trace.json
 create mode 100644 tools/perf/scripts/Makefile.syscalls
 create mode 100755 tools/perf/scripts/syscalltbl.sh
 create mode 100755 tools/perf/tests/shell/trace_btf_general.sh
 create mode 100644 tools/perf/util/btf.c
 create mode 100644 tools/perf/util/btf.h
 create mode 100644 tools/perf/util/kvm-stat.c
 create mode 100644 tools/perf/util/lock-contention.c
 create mode 100644 tools/scripts/syscall.tbl
