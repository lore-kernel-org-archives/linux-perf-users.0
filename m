Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD35493649;
	Fri, 21 Aug 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348248; cv=none; b=uCp+l+k2nShMShWRocN3g6RjjyA5kBfe8kPJ/eVrFFwpOP26XlACj4zMSRU0IvXYbG2iOvyeSgynBWlKGyK+seCiyK9y4/O/7PJtx687ExCsSa84LD0MCNNNTw0Dhjd2oAabd1ybaGyq2jP+2XZA2KwpDmI0EEN3dx1Hd1Bx11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348248; c=relaxed/simple;
	bh=soOu7PXjAEUX6m6qiPTkCsj9R0asv88pfYIATmgToFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iI4CxrYWgNY28dGrQPpAWzRFGMQMwWAKJrl/VxaRI3i7BhMyYGz0lBzeXTvp00TsuuLjzTkdTMEPt806jcyW+i7+yxO/GE2RteO85amqHQYaqeoez9Io0IWm8MSzBdA9aTHwzULOOc2GpWyeSyW3fMr43QDym9DrYxgtQN2TgIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5yPPIoI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5yPPIoI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E386D1F000E9;
	Fri, 21 Aug 2026 21:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787348246;
	bh=/XB2HdMQHfsbqEN0RoiA/usDlsdsIKFFEs1pX2wK8CI=;
	h=From:To:Cc:Subject:Date;
	b=k5yPPIoIqsUi60aZBC0dno5zccMQVLYizlXbXCzYZjsRiaF2lbZlUCQPl0vpXxYQm
	 tv7dhZg+E/q3XJ48atGlIbU7VcqmJufv5VdIT9slJ/PlmRdHEryu7SuPATCl6DBTxL
	 oP1ZdX0/M36iv1SsEZJaBA4Jk7rAVthniFBZwEodTED/Ll0CX/5ApW16L87wccH11d
	 mRxuCPel5Q2XngZubAO5NelFMJIwskrfI+cf9SFDMMDk+0rvesSB0Qac8twb+QwBNQ
	 +Nz/NTnRCp8jDC9LCf+SHkFDIWWKGuSdigy3ObjKgNDSeCCE++kbThqrqvIcclRKA4
	 UaXpUDLryBi9g==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools changes for v7.3
Date: Fri, 21 Aug 2026 14:37:24 -0700
Message-ID: <20260821213724.1315605-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v7.3.

Thanks,
Namhyung


The following changes since commit fac520e43a60230b24026f462a2b63e4d170566e:

  tools headers: Sync KVM headers with the kernel sources (2026-07-21 21:00:10 -0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.3-2026-08-21

for you to fetch changes up to 9453bc6a69ef43755f1c28d5688cacdd69fa16bd:

  perf vendor events arm64: Fix Tegra410 Olympus event 0x0197 (2026-08-18 14:31:18 -0700)

----------------------------------------------------------------
perf tools updates for v7.3

perf c2c:

 - Add 'function view' in perf c2c report TUI (switched by pressing 'TAB'
   in the cacheline view) to organize samples around functions rather than
   cachelines in 3-level hierarchy:

     Level 1: Read-side function (sorted by estimated Cycles %)
     Level 2:   Contending writer functions (sorted by Store count)
     Level 3:     Shared cacheline addresses

   Users can navigate the entries and fold/unfold using 'e' key.  An example
   output would look like below:

    Shared Data Functions Table     (19 entries, sorted on Cycles %)
       Cycles    Store
            %    count  Function / Contending function / Cacheline
    ----------------------------------------------------------------------
    +  35.67%      876  + [k] cpupri_set
    +  24.31%      424  + [k] pull_rt_task
    -  16.53%      555  - [k] dequeue_pushable_task
                   145    - [k] pull_rt_task
                   145        0xff2d0082809da080
                   139    - [k] enqueue_pushable_task
                    70        0xff2d00a2071f9640
                    69        0xff2d0082809da000

python module support:

 - Extend "perf" python module so that it can be fully functional.  The goal
   is to run scripts directly, not by 'perf script' command.  This would give
   better performance as well as more control to build standalone programs
   with UI.

 - Add LiveSession helper (perf_live.py) to enable live event collection
   directly from Python using perf.evlist and perf.parse_events.

perf stat:

 - Add --hide-zero-events option to suppress zero-count events.
 - Reject conflicting --field-separator and --json-output options.
 - Fix duplicate event output with --for-each-cgroup.

perf sched latency:

 - Add -H/--histogram and --hist-mode (log|linear) options to show scheduler
   wait latency histograms.
 - Add --time option to filter analysis by time span in 'perf sched latency'.

ARM CoreSight:

 - Synthesize callchains for instruction samples from CoreSight trace
   using thread stack ('--itrace=g...').
 - Support call indentation ('perf script -F +callindent') to display call
   depth hierarchy on branch samples.
 - Decode ETE (Embedded Trace Extension) exception packets.

Build system:

 - Add 'make install-build-deps' target to install required packages.
 - Parallelize JSON and metric pre-computation in jevents.py for faster builds.

Vendor event/metric updates:

 - Add Intel Nova Lake events and update tables for existing models.
 - Update AMD Zen 5 and Zen 6 core events.
 - Update Arm64 Tegra410 metrics and PowerPC hcalls.

Internal changes and fixes:

 - Harden trace-event and synthetic event parsing against corrupted data.
 - Fix unwinding of multi-threaded processes in libdw unwinder.
 - Fix memory leaks in various commands and python bindings.
 - Speed up 'perf test' shell tests.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Aaron Tomlin (9):
      perf stat: Add --hide-zero-events option to suppress zero-count events
      perf trace: Correct default cpumask formatting to hexadecimal
      perf trace: Add --bitmask-list command-line option
      perf trace: Format instruction pointer fields as hexadecimal
      perf trace: Format fields with hex specifiers in print_fmt as hexadecimal
      perf sched: Suppress latency table output when trace samples are missing
      perf sched: Handle missing trace samples in pipe mode
      perf sched latency: Auto-scale latency and runtime display units
      perf sched latency: Add histogram and time interval options

Alessio Podda (1):
      perf unwind-libdw: Fix unwinding of multi-threaded processes

Arnaldo Carvalho de Melo (31):
      perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
      perf machine: Fix NULL parent dereference in fork event processing
      perf machine: Guard against NULL strlist in machines__findnew()
      perf machine: Check snprintf truncation in machines__findnew()
      perf machine: Don't abort guest map creation on first inaccessible dir
      perf machine: Reset errno before strtol in guest kernel map creation
      perf machine: Free scandir entries in guest kernel map creation
      perf machine: Check snprintf truncation for guest kallsyms path
      perf thread-stack: Fix heap buffer overflow on branch stack wrap copy
      perf auxtrace: Fix queue grow overflow and old array leak
      perf intel-pt: Fix off-by-one in auxtrace_info minimum size check
      perf intel-bts: Fix off-by-one in auxtrace_info minimum size check
      perf arm-spe: Reject zero nr_cpu in metadata to prevent division by zero
      perf libbfd: Validate BPF prog info arrays before pointer cast
      perf header: Use write lock when translating BPF prog info pointers
      perf bpf: Add PROG_TAGS to required arrays in __bpf_event__print_bpf_prog_info()
      perf libbfd: Fix memory leaks and NULL fclose in BPF disassembly
      perf c2c: Fix error masking, OOM, and unchecked caller errors in hpp_list__parse()
      perf c2c: Clean up registered formats on c2c_hists__init() and c2c_hists__reinit() failure
      tools build: Only probe the compiler at parse time when it is installed
      perf build: Add install-build-deps framework to install devel packages
      perf build: install-build-deps: add Fedora devel package mapping
      perf build: install-build-deps: add Ubuntu devel package mapping
      perf build: install-build-deps: add Debian devel package mapping
      perf build: Remove leftover feature tests for removed cxx and clang support
      perf build: install-build-deps: add RHEL family devel package mapping
      perf dso: Guard against errno==0 when dso__get_filename() returns NULL
      perf dso: Guard close() against invalid fd in dso__decompress_kmodule_path()
      perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
      perf dso: Guard against cache underflow on short reads in dso_cache__memcpy()
      perf dso: Replace assert with runtime check in dso__read_symbol()

Athira Rajeev (1):
      tools/perf/sched: Update process names of processes in zombie state for both -s and -S options

Besar Wicaksono (1):
      perf vendor events arm64: Fix Tegra410 Olympus event 0x0197

Chen Ni (1):
      perf test: Remove duplicate include of util/term.h

Chun-Tse Shao (19):
      perf vendor events intel: Update arrowlake events from 1.17 to 1.19
      perf vendor events intel: Update emeraldrapids events from 1.23 to 1.24
      perf vendor events intel: Update graniterapids events from 1.18 to 1.19
      perf vendor events intel: Update lunarlake events from 1.22 to 1.25
      perf vendor events intel: Update pantherlake events from 1.05 to 1.06
      perf vendor events intel: Update tigerlake events from 1.18 to 1.19
      perf vendor events intel: Update alderlake events from 1.39 to 1.40
      perf vendor events intel: Update alderlaken events from 1.39 to 1.40
      perf vendor events intel: Update arrowlake events from 1.19 to 1.20
      perf vendor events intel: Update clearwaterforest events from 1.02 to 1.04
      perf vendor events intel: Update grandridge events from 1.12 to 1.13
      perf vendor events intel: Update graniterapids events from 1.19 to 1.20
      perf vendor events intel: Update lunarlake events from 1.25 to 1.26
      perf vendor events intel: Update meteorlake events from 1.21 to 1.22
      perf vendor events intel: Add novalake v1.00 events
      perf vendor events intel: Update pantherlake events from 1.06 to 1.07
      perf vendor events intel: Update sierraforest events from 1.17 to 1.18
      perf vendor events intel: Update emeraldrapids metrics
      perf vendor events intel: Fix Novalake CPUID regex in mapfile.csv

Dapeng Mi (2):
      perf tests: Add auto counter reload (ACR) sampling test
      perf jevents: Add Intel OMR MSR mappings

Dmitry Ilvokhin (2):
      perf record: Return the written size from process_comp_header()
      perf record: Fix multiple PERF_RECORD_COMPRESSED2 records per push

Gautam Menghani (3):
      perf script powerpc: Update the hcall list with new hcalls
      perf script powerpc: Fix a typo in the name of H_DISABLE_AND_GET
      perf kvm stat: Add missing mappings for PPC kvm exit reasons

Hongfu Li (1):
      perf doc: Fix mmap failure checks in topdown example

Hongling Zeng (1):
      perf: evsel: Fix error handling in tp_format lookup

Ian Rogers (76):
      perf util: Sort includes and add missed explicit dependencies
      perf python: Add missed explicit dependencies
      perf evsel/evlist: Avoid unnecessary #includes
      perf data: Add open flag
      perf evlist: Add reference count
      perf evsel: Add reference count
      perf evlist: Add reference count checking
      perf python: Use evsel in sample in pyrf_event
      perf python: Add wrapper for perf_data file abstraction
      perf python: Add python session abstraction wrapping perf's session
      perf python: Refactor and add accessors to sample event
      perf python: Add mmap2 event
      perf python: Add callchain support
      perf python: Extend API for stat events in python.c
      perf python: Expose brstack in sample event
      perf python: Add syscall name/id to convert syscall number and name
      perf python: Add config file access
      perf python: Handle Py_None for thread and cpu maps
      perf python: Add type checking for parse_events/parse_metrics
      perf python: Add perf.pyi stubs file
      perf python: Add LiveSession helper
      perf pmu: Recognize default_core as a core PMU in more places
      perf parse-events: Restrict core PMU bypass to --cputype option
      perf test: Truncate test description to fit terminal width
      perf tests workloads: Support sub-second durations in noploop and thloop
      perf tests: Add robust record retry helper and use subsecond workloads
      perf tests: Skip metrics validation if system-wide recording lacks permission
      perf tests: Fix Python JIT dump profiling test failure
      perf tests: Fix flakiness in trace record and replay test
      perf tests: Fix flakiness in BPF counters test on hybrid systems
      perf tests: Fix flakiness in branch stack sampling tests
      perf tests: Speed up off-cpu profiling tests
      perf tests: Speed up lock contention analysis shell test
      perf tests: Speed up metrics checking shell tests
      perf tests: Include error output for skipped tests in JUnit XML
      perf tests: Restore -p flag to lock contention test
      perf record: Fix teardown hang on system-wide multi-threaded sessions
      perf clang-format: Prioritize Python.h and expand other categories
      perf jevents: Add more components to the metric sorting order
      perf jevents: Add python type annotations
      perf jevents metric: Add python type annotations
      perf hists browser: Increase MAX_OPTIONS to prevent stack buffer overflow
      perf ui hists: Fix uninitialized stack memory free on pstack allocation failure
      perf ui hists: Include limits.h for PATH_MAX definition
      perf disasm: Fix potential NULL pointer dereference and use-after-free in arch__find()
      perf ui hists: Fix NULL pointer array gap in add_script_opt()
      perf cap: Remove used_root parameter and simplify capability checks
      perf python: Clean up and restructure setup.py
      perf pmu-events: Parallelize JSON and metric pre-computation in jevents.py
      perf ui hists: Fix stack use-after-return in symbol_filter_str
      perf ui hists: Guard against NULL hist_entry in add_script_opt()
      perf ui hists: In report UI ensure thread is set with reference counting
      perf ui hists: Fix dso_filter reference leak and exit zoom cleanup
      perf annotate: Be robust to annotating without a thread
      perf ui hists: Remove duplicated thread in popup_action
      perf find-map: Remove PATH_MAX 128-byte stack array restriction
      perf synthetic-events: Fix line synchronization, bounds, and truncation bugs in proc maps reader
      perf synthetic-events: Fix stack buffer overflow and bounds in cgroup synthesis
      perf synthetic-events: Fix bounds, stale state, and misc flags in kernel module synthesis
      perf synthetic-events: Fix bounds and union member access in mmap2 build_id synthesis
      perf script: Fix metric_evlist leak in script_find_metrics
      perf stat: Fix evsel_list leak in cmd_stat
      perf tools: Fix sb_evlist leaks in top and record
      perf python: Fix memory leak in pyrf_evlist__get_pollfd
      perf synthetic-events: Fix uninitialized pthread_join
      perf test: Fix skiplist leak in cmd_test
      perf python: Check counts_values size in set_values
      perf python: Validate CPU and thread maps in pyrf_evsel__open
      perf python: Validate attribute setters in pyrf_evsel
      perf python: Zero initialize perf_data in pyrf_data__init
      perf python: Add thread and PMU uninitialized checks
      perf python: Fix MetricGroup return type in perf.pyi
      perf python: Fix count_values memory leak in pyrf_evsel__read
      perf python: Fix memory leak in pyrf__metrics_cb
      perf synthetic-events: Fix divide by zero in perf_event__synthesize_threads
      perf evlist: Warn when 'sleep' workload is used without system-wide (-a) option

Ivan Lazaric (1):
      perf stat: reject --field-separator and --json-output combination

James Clark (4):
      tools/build: Allow versioning of all LLVM tools defined in Makefile.include
      tools/build: Indent if else blocks
      tools/build: Allow versioning LLVM readelf
      tools/build: selftests: Remove some duplicate toolchain definitions

Jiawei Sun (1):
      perf record: fix poll storm when monitored threads exit

Jiebin Sun (9):
      perf c2c: extract shared data structures into util/c2c.h
      perf c2c: add function view model skeleton
      perf c2c: add column rendering for function view
      perf c2c: add HPP list parsing for function view columns
      perf c2c: add function view stats merge and memory management
      perf c2c: add function view hierarchy entry creation
      perf c2c: build and finalize the function view hierarchy
      perf c2c: add function view browser UI and cacheline detail
      perf c2c: document function view in perf-c2c man page

Joe Lawrence (2):
      perf symbols: skip livepatch symbols when loading kallsyms
      perf symbols: skip livepatch symbols in kcore_copy kallsyms processing

Leo Yan (10):
      perf cs-etm: Fix thread leaks on trace queue init failure
      perf cs-etm: Filter synthesized branch samples
      perf cs-etm: Decode ETE exception packets
      perf cs-etm: Refactor instruction size handling
      perf cs-etm: Use thread-stack for last branch entries
      perf cs-etm: Flush thread stacks after decoder reset
      perf cs-etm: Support call indentation
      perf cs-etm: Synthesize callchains for instruction samples
      perf test: Add Arm CoreSight callchain test
      perf cs-etm: Avoid truncating AUX buffer sizes to int

Masami Hiramatsu (Google) (1):
      perf/probe: Ignore comment lines in dynamic_events/kprobe_events file

Michael Liang (1):
      perf libdw: Fix outer-frame name resolution and spurious "(inlined)" tag

Michail Tatas (1):
      perf ftrace: Fix leak in parse_filter_event

Michalis Niarchos (2):
      perf kvm: Fix memory leak in process_sample_event()
      perf kvm: Fix memory leak in cmd_kvm()

Namhyung Kim (28):
      perf timechart: Don't pass @event to cat_backtrace()
      perf timechart: Generate backtrace only if needed
      perf timechart: Remove unused backtrace in trace_handler
      perf timechart: Remove unnecessary copy of backtrace
      perf timechart: Release event samples at the end
      perf timechart: Fix memory leaks during record
      perf timechart: Fix memory leaks in draw_wakeups()
      perf test: Update perf timechart test
      perf kvm: Factor out kvm_need_default_arch_event()
      perf kvm: Check kvm_need_default_arch_event() early
      perf kvm: Kill STRDUP_FAIL_EXIT()
      perf kvm: Do not copy filename string
      perf kvm: Fix a memory leak in the usage string
      perf test: Extend perf kvm tests to check default event
      perf build: Do not pass -static to dlfilters
      perf sched: Add missing perf_session__delete()
      perf sched: Fix memory leaks in perf sched stats report
      perf sched: Free subcommand string after perf sched stats
      tools/lib/api: Fix potential double-free from fdarray__grow()
      perf stat: Do not open cgroups for BPF counters
      perf stat: Fix duplicate output with --for-each-cgroup
      perf evsel: Remove unused BPF related fields
      perf evsel: Arrange some fields that should be cloned
      perf test: Update test for --for-each-cgroup option
      perf build: Fix a compiler error in util/libbfd.c
      perf build: Fix compiler errors with old capstone
      Merge tag 'perf-tools-fixes-for-v7.2-1-2026-07-25' into perf-tools-next
      perf build: Fix a build error on 32-bit x86

Ondrej Mosnacek (1):
      perf test amd ibs: avoid using executable heap

PVS Narasimha Rao (1):
      perf test sample-parsing: Validate PERF_FORMAT_GROUP values without LOST

Pu Hu (1):
      perf pmu-events: Fix typo in idle-cycles-frontend description

Sandipan Das (3):
      perf vendor events amd: Update Zen 5 core events
      perf vendor events amd: Update Zen 6 core events
      perf vendor events amd: Reintroduce deprecated Zen 5 core events

Saurav Sachidanand (1):
      perf vendor events arm64: fix swapped MetricGroup for Tegra410 L1 prefetcher metrics

Shivani Nittor (1):
      perf scripts: Add configurable sorting option to powerpc-hcalls

Sizhe Liu (3):
      perf hisi-ptt: Fix PTT trace TLP header parsing
      perf hisi-ptt: Strengthen auxtrace event handling and packet type detection
      perf hisi-ptt: Fix spelling and abbreviation errors

Tanushree Shah (7):
      perf data convert json: Fix trace_seq memory leak in process_sample_event()
      perf dso: Fix kallsyms DSO detection with fallback logic
      perf trace-event: Fix buffer overflow in read_string()
      perf trace-event: Fix integer truncation in do_read() and skip()
      perf trace-event: Avoid double free and leak in trace_event__cleanup()/trace_event__init()
      perf trace-event: Fix heap overflows in read_ftrace_printk()/read_saved_cmdline()
      perf trace-event: Fix infinite loop in skip()

Tengda Wu (1):
      perf capstone: Fix kernel map reference count leak

Thomas Richter (1):
      perf test: Skip failing 'perf test aslr' test case

Trevor Allison (1):
      perf build: Add LDFLAGS to dlfilters .so link

Viktor Malik (2):
      perf trace: Factor out BPF loop body
      perf trace: Refactor augmented_raw_syscalls using bpf_for

Yu Peng (1):
      perf metricgroup: Fix metric expression copy leaks

Zhanpeng Zhang (1):
      perf symbols: Skip dynamic symbols with invalid section indexes

 Documentation/trace/hisi-ptt.rst                   |   28 +-
 tools/bpf/resolve_btfids/Makefile                  |    3 -
 tools/build/Makefile.feature                       |    2 -
 tools/build/feature/Makefile                       |   14 -
 tools/lib/api/Makefile                             |    4 -
 tools/lib/api/fd/array.c                           |   17 +-
 tools/lib/bpf/Makefile                             |    8 +-
 tools/lib/subcmd/Makefile                          |    4 -
 tools/lib/symbol/Makefile                          |    4 -
 tools/perf/.clang-format                           |    9 +-
 tools/perf/Documentation/perf-c2c.txt              |   71 +
 tools/perf/Documentation/perf-sched.txt            |    6 +
 tools/perf/Documentation/perf-stat.txt             |    3 +
 tools/perf/Documentation/perf-test.txt             |    6 +-
 tools/perf/Documentation/perf-trace.txt            |    4 +
 tools/perf/Documentation/topdown.txt               |    4 +-
 tools/perf/Makefile.perf                           |   37 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   10 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    8 +-
 tools/perf/arch/arm64/util/hisi-ptt.c              |    2 +-
 tools/perf/arch/x86/tests/amd-ibs-period.c         |   20 +-
 tools/perf/arch/x86/tests/hybrid.c                 |   22 +-
 tools/perf/arch/x86/tests/topdown.c                |    4 +-
 tools/perf/arch/x86/util/auxtrace.c                |    2 +-
 tools/perf/arch/x86/util/intel-bts.c               |    6 +-
 tools/perf/arch/x86/util/intel-pt.c                |    9 +-
 tools/perf/arch/x86/util/iostat.c                  |   14 +-
 tools/perf/bench/evlist-open-close.c               |   29 +-
 tools/perf/builtin-annotate.c                      |    7 +-
 tools/perf/builtin-c2c.c                           |  221 +-
 tools/perf/builtin-ftrace.c                        |   32 +-
 tools/perf/builtin-inject.c                        |    9 +-
 tools/perf/builtin-kvm.c                           |  130 +-
 tools/perf/builtin-kwork.c                         |    8 +-
 tools/perf/builtin-lock.c                          |    4 +-
 tools/perf/builtin-record.c                        |  148 +-
 tools/perf/builtin-report.c                        |   13 +-
 tools/perf/builtin-sched.c                         |  402 ++-
 tools/perf/builtin-script.c                        |   16 +-
 tools/perf/builtin-stat.c                          |  124 +-
 tools/perf/builtin-timechart.c                     |  212 +-
 tools/perf/builtin-top.c                           |  106 +-
 tools/perf/builtin-trace.c                         |  204 +-
 .../pmu-events/arch/arm64/nvidia/t410/metrics.json |   28 +-
 .../pmu-events/arch/arm64/nvidia/t410/misc.json    |    6 +-
 .../arch/common/common/legacy-hardware.json        |    2 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |   80 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |   36 +
 .../arch/x86/alderlake/metricgroups.json           |    2 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |    6 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |   32 +
 .../arch/x86/amdzen5/floating-point.json           |  160 +-
 .../pmu-events/arch/x86/amdzen5/load-store.json    |    8 +-
 .../arch/x86/amdzen6/floating-point.json           |   34 +-
 .../pmu-events/arch/x86/arrowlake/arl-metrics.json |  152 +-
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |   30 +-
 .../arch/x86/arrowlake/floating-point.json         |   45 +
 .../perf/pmu-events/arch/x86/arrowlake/memory.json |   18 +
 .../arch/x86/arrowlake/metricgroups.json           |    2 +-
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |  131 +-
 .../arch/x86/arrowlake/uncore-memory.json          |   84 +-
 .../arch/x86/clearwaterforest/memory.json          |   33 +
 .../arch/x86/clearwaterforest/pipeline.json        |   19 +
 .../x86/clearwaterforest/uncore-interconnect.json  |   10 +
 .../arch/x86/clearwaterforest/uncore-memory.json   |    2 +-
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |    9 +
 .../arch/x86/emeraldrapids/emr-metrics.json        |  135 +-
 .../arch/x86/emeraldrapids/metricgroups.json       |    2 +-
 .../perf/pmu-events/arch/x86/grandridge/cache.json |   25 +
 .../pmu-events/arch/x86/grandridge/counter.json    |   42 -
 .../arch/x86/grandridge/floating-point.json        |   56 +
 .../pmu-events/arch/x86/grandridge/memory.json     |   57 +
 .../pmu-events/arch/x86/grandridge/pipeline.json   |  140 +
 .../arch/x86/grandridge/uncore-memory.json         |    2 +-
 .../arch/x86/grandridge/virtual-memory.json        |    8 +
 .../arch/x86/graniterapids/gnr-metrics.json        |  102 +-
 .../arch/x86/graniterapids/metricgroups.json       |    2 +-
 .../arch/x86/graniterapids/pipeline.json           |    2 +-
 .../x86/graniterapids/uncore-interconnect.json     |   10 +
 .../arch/x86/graniterapids/uncore-memory.json      |    2 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |    2 +-
 .../pmu-events/arch/x86/lunarlake/lnl-metrics.json |  142 +-
 .../arch/x86/lunarlake/metricgroups.json           |    2 +-
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |   29 +-
 .../arch/x86/lunarlake/uncore-memory.json          |  208 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   25 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   11 +-
 .../arch/x86/meteorlake/metricgroups.json          |    2 +-
 .../arch/x86/meteorlake/mtl-metrics.json           |   88 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |    4 +-
 .../arch/x86/meteorlake/uncore-memory.json         |   84 +-
 tools/perf/pmu-events/arch/x86/novalake/cache.json |  749 +++++
 .../perf/pmu-events/arch/x86/novalake/counter.json |   17 +
 .../arch/x86/novalake/floating-point.json          |  452 +++
 .../pmu-events/arch/x86/novalake/frontend.json     |  600 ++++
 .../perf/pmu-events/arch/x86/novalake/memory.json  |  299 ++
 tools/perf/pmu-events/arch/x86/novalake/other.json |  144 +
 .../pmu-events/arch/x86/novalake/pipeline.json     | 1976 +++++++++++++
 .../arch/x86/novalake/uncore-memory.json           |   42 +
 .../arch/x86/novalake/virtual-memory.json          |  338 +++
 .../pmu-events/arch/x86/pantherlake/counter.json   |    5 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  |   31 +-
 .../arch/x86/pantherlake/uncore-interconnect.json  |   10 +
 .../arch/x86/pantherlake/uncore-memory.json        |  221 +-
 .../pmu-events/arch/x86/sierraforest/counter.json  |   77 -
 .../arch/x86/sierraforest/uncore-interconnect.json |   10 +
 .../arch/x86/sierraforest/uncore-memory.json       |    2 +-
 tools/perf/pmu-events/empty-pmu-events.c           |  362 +--
 tools/perf/pmu-events/jevents.py                   |  122 +-
 tools/perf/pmu-events/metric.py                    |   23 +-
 tools/perf/python/perf.pyi                         |  672 +++++
 tools/perf/python/perf_live.py                     |   59 +
 tools/perf/scripts/install-build-deps.sh           |  603 ++++
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |    9 +-
 tools/perf/scripts/python/powerpc-hcalls.py        |  137 +-
 tools/perf/tests/backward-ring-buffer.c            |   26 +-
 tools/perf/tests/builtin-test.c                    |  182 +-
 tools/perf/tests/code-reading.c                    |   14 +-
 tools/perf/tests/event-times.c                     |    6 +-
 tools/perf/tests/event_update.c                    |    4 +-
 tools/perf/tests/evsel-roundtrip-name.c            |    8 +-
 tools/perf/tests/evsel-tp-sched.c                  |    4 +-
 tools/perf/tests/expand-cgroup.c                   |   15 +-
 tools/perf/tests/hists_cumulate.c                  |    2 +-
 tools/perf/tests/hists_filter.c                    |    2 +-
 tools/perf/tests/hists_link.c                      |    2 +-
 tools/perf/tests/hists_output.c                    |    2 +-
 tools/perf/tests/hwmon_pmu.c                       |    7 +-
 tools/perf/tests/keep-tracking.c                   |   10 +-
 tools/perf/tests/mmap-basic.c                      |   24 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |    6 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   26 +-
 tools/perf/tests/openat-syscall.c                  |    6 +-
 tools/perf/tests/parse-events.c                    |  150 +-
 tools/perf/tests/parse-metric.c                    |   11 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    2 +-
 tools/perf/tests/perf-record.c                     |   38 +-
 tools/perf/tests/perf-time-to-tsc.c                |   12 +-
 tools/perf/tests/pfm.c                             |   12 +-
 tools/perf/tests/pmu-events.c                      |   21 +-
 tools/perf/tests/pmu.c                             |    4 +-
 tools/perf/tests/sample-parsing.c                  |   84 +-
 tools/perf/tests/shell/coresight/callchain.sh      |  172 ++
 .../shell/coresight/test_arm_coresight_disasm.sh   |    4 +-
 tools/perf/tests/shell/inject_aslr.sh              |   10 +-
 tools/perf/tests/shell/jitdump-python.sh           |   79 +-
 tools/perf/tests/shell/kvm.sh                      |   71 +-
 .../perf/tests/shell/lib/perf_metric_validation.py |   11 +-
 tools/perf/tests/shell/lib/perf_record.sh          |   58 +
 tools/perf/tests/shell/lib/setup_python.sh         |   13 +
 tools/perf/tests/shell/lock_contention.sh          |   33 +-
 tools/perf/tests/shell/pipe_test.sh                |    4 +-
 .../shell/record+zstd_comp_decomp_multi_record.sh  |   63 +
 tools/perf/tests/shell/record.sh                   |  216 +-
 tools/perf/tests/shell/record_lbr.sh               |   50 +-
 tools/perf/tests/shell/record_offcpu.sh            |   14 +-
 tools/perf/tests/shell/sched.sh                    |   29 +
 tools/perf/tests/shell/stat.sh                     |   58 +
 tools/perf/tests/shell/stat_all_metrics.sh         |   77 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   28 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |   15 +
 tools/perf/tests/shell/stat_metrics_values.sh      |    9 +-
 tools/perf/tests/shell/test_brstack.sh             |  107 +-
 .../tests/shell/test_dwarf_unwind_multithreaded.sh |   65 +
 tools/perf/tests/shell/timechart.sh                |   24 +-
 tools/perf/tests/shell/trace_record_replay.sh      |   38 +-
 tools/perf/tests/sw-clock.c                        |   20 +-
 tools/perf/tests/switch-tracking.c                 |   11 +-
 tools/perf/tests/task-exit.c                       |   20 +-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/tests/time-utils-test.c                 |   14 +-
 tools/perf/tests/tool_pmu.c                        |    7 +-
 tools/perf/tests/topology.c                        |    4 +-
 tools/perf/tests/uncore-event-sorting.c            |    6 +-
 tools/perf/tests/workloads/Build                   |    2 +
 tools/perf/tests/workloads/callchain.c             |   33 +
 tools/perf/tests/workloads/noploop.c               |   17 +-
 tools/perf/tests/workloads/thloop.c                |   16 +-
 tools/perf/ui/browsers/Build                       |    1 +
 tools/perf/ui/browsers/annotate.c                  |    4 +-
 tools/perf/ui/browsers/c2c-function.c              |  209 ++
 tools/perf/ui/browsers/hists.c                     |  201 +-
 tools/perf/util/Build                              |    3 +-
 tools/perf/util/amd-sample-raw.c                   |    2 +-
 tools/perf/util/annotate-data.c                    |    2 +-
 tools/perf/util/annotate.c                         |   61 +-
 tools/perf/util/annotate.h                         |    3 +-
 tools/perf/util/arm-spe.c                          |    4 +
 tools/perf/util/aslr.c                             |    1 +
 tools/perf/util/auxtrace.c                         |   29 +-
 tools/perf/util/block-info.c                       |    4 +-
 tools/perf/util/bpf-event.c                        |    3 +-
 tools/perf/util/bpf-filter.c                       |   22 +-
 tools/perf/util/bpf_counter.c                      |    2 +-
 tools/perf/util/bpf_counter_cgroup.c               |   14 +-
 tools/perf/util/bpf_ftrace.c                       |    9 +-
 tools/perf/util/bpf_lock_contention.c              |   12 +-
 tools/perf/util/bpf_off_cpu.c                      |   44 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |  155 +-
 tools/perf/util/bpf_trace_augment.c                |    8 +-
 tools/perf/util/c2c-function.c                     | 1642 +++++++++++
 tools/perf/util/c2c.c                              |   21 +
 tools/perf/util/c2c.h                              |  135 +
 tools/perf/util/cap.c                              |    4 +-
 tools/perf/util/cap.h                              |    3 +-
 tools/perf/util/capstone.c                         |   62 +-
 tools/perf/util/cgroup.c                           |   26 +-
 tools/perf/util/compress.h                         |    6 +-
 tools/perf/util/cs-etm.c                           |  418 +--
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/data-convert-json.c                |    1 +
 tools/perf/util/data.c                             |   27 +-
 tools/perf/util/data.h                             |    4 +-
 tools/perf/util/disasm.c                           |    8 +-
 tools/perf/util/dso.c                              |   48 +-
 tools/perf/util/dso.h                              |   57 +-
 tools/perf/util/evlist.c                           |  511 ++--
 tools/perf/util/evlist.h                           |  273 +-
 tools/perf/util/evsel.c                            |  163 +-
 tools/perf/util/evsel.h                            |   59 +-
 tools/perf/util/expr.c                             |    2 +-
 tools/perf/util/find-map.c                         |   10 +-
 tools/perf/util/header.c                           |   74 +-
 tools/perf/util/header.h                           |    2 +-
 .../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.c   |   63 +-
 .../util/hisi-ptt-decoder/hisi-ptt-pkt-decoder.h   |   14 +-
 tools/perf/util/hisi-ptt.c                         |   24 +-
 tools/perf/util/hist.c                             |    1 +
 tools/perf/util/intel-bts.c                        |    2 +-
 tools/perf/util/intel-pt.c                         |   10 +-
 tools/perf/util/intel-tpebs.c                      |    7 +-
 tools/perf/util/iostat.c                           |    2 +-
 tools/perf/util/iostat.h                           |    2 +-
 tools/perf/util/kvm-stat-arch/book3s_hv_exits.h    |    4 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c   |   31 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c       |   37 +-
 tools/perf/util/kvm-stat.c                         |   41 +
 tools/perf/util/kvm-stat.h                         |   20 +-
 tools/perf/util/libbfd.c                           |   27 +-
 tools/perf/util/libdw.c                            |   34 +-
 tools/perf/util/machine.c                          |   43 +-
 tools/perf/util/map.h                              |    9 +-
 tools/perf/util/metricgroup.c                      |   45 +-
 tools/perf/util/metricgroup.h                      |    4 +-
 tools/perf/util/parse-events.c                     |   40 +-
 tools/perf/util/parse-events.h                     |   17 +-
 tools/perf/util/parse-events.y                     |    2 +-
 tools/perf/util/perf_api_probe.c                   |   20 +-
 tools/perf/util/pfm.c                              |    4 +-
 tools/perf/util/pmu.c                              |    6 +-
 tools/perf/util/pmus.c                             |    2 +
 tools/perf/util/print-events.c                     |    2 +-
 tools/perf/util/probe-file.c                       |    2 +
 tools/perf/util/python.c                           | 2988 ++++++++++++++++----
 tools/perf/util/record.c                           |   11 +-
 tools/perf/util/s390-sample-raw.c                  |   20 +-
 tools/perf/util/sample-raw.c                       |    4 +-
 tools/perf/util/sample.c                           |   17 +-
 tools/perf/util/session.c                          |   69 +-
 tools/perf/util/session.h                          |    2 +
 tools/perf/util/setup.py                           |  259 +-
 tools/perf/util/sideband_evlist.c                  |   54 +-
 tools/perf/util/sort.c                             |   78 +-
 tools/perf/util/stat-display.c                     |    9 +-
 tools/perf/util/stat-shadow.c                      |   24 +-
 tools/perf/util/stat.c                             |   20 +-
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/stream.c                           |    4 +-
 tools/perf/util/symbol-elf.c                       |   11 +-
 tools/perf/util/symbol.c                           |    7 +-
 tools/perf/util/symbol.h                           |   12 +
 tools/perf/util/synthetic-events.c                 |  326 ++-
 tools/perf/util/thread-stack.c                     |    2 +-
 tools/perf/util/time-utils.c                       |   12 +-
 tools/perf/util/top.c                              |    4 +-
 tools/perf/util/trace-event-read.c                 |   54 +-
 tools/perf/util/trace-event.c                      |   11 +-
 tools/perf/util/unwind-libdw.c                     |   24 +-
 tools/perf/util/util.c                             |   12 +-
 tools/perf/util/zstd.c                             |   25 +-
 tools/scripts/Makefile.arch                        |    8 +-
 tools/scripts/Makefile.include                     |   85 +-
 tools/testing/selftests/bpf/Makefile               |    1 -
 283 files changed, 18172 insertions(+), 3984 deletions(-)
 delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-interconnect.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json
 create mode 100644 tools/perf/python/perf.pyi
 create mode 100755 tools/perf/python/perf_live.py
 create mode 100755 tools/perf/scripts/install-build-deps.sh
 create mode 100755 tools/perf/tests/shell/coresight/callchain.sh
 create mode 100644 tools/perf/tests/shell/lib/perf_record.sh
 create mode 100755 tools/perf/tests/shell/record+zstd_comp_decomp_multi_record.sh
 create mode 100755 tools/perf/tests/shell/test_dwarf_unwind_multithreaded.sh
 create mode 100644 tools/perf/tests/workloads/callchain.c
 create mode 100644 tools/perf/ui/browsers/c2c-function.c
 create mode 100644 tools/perf/util/c2c-function.c
 create mode 100644 tools/perf/util/c2c.c
 create mode 100644 tools/perf/util/c2c.h
