Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B563AD23;
	Tue,  3 Jun 2025 20:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748982913; cv=none; b=PjwjfKAaSin8ViMLTh8SN7uL0T0DMjV6s9YGJoYtdhNNjTsadwK8cjgxCN1hP2fkVomaGhj+ej46oVg2SFRUXj58V8BogRH9aU3c86tVK4+UK3ZU74VRAQNPCmAFe8ueK5NZ9w8z2DK90aDgRN4MYZIlwlZesJLeQim1NcMvY+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748982913; c=relaxed/simple;
	bh=TJL2KUxvBkbktvbT6t4qD7pNueXKyvcojBYN0heniHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UlRKMZHpjYcfmZI3Lop8v0vSZlGCXp84kq/TbQ0uO0y5kE4C/zv31vBTVFmRqXgemb2Ag3IaSTxi0NpgG66qCRXjOLNadge8px2gLDzvEtZN1LlaZmU1l/a+SuaScwBtht7VVMUyTcUgy0h9kCPF3FjI2+iJknkYV6RBj3F+B1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=An01hdLx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="An01hdLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C05FC4CEED;
	Tue,  3 Jun 2025 20:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748982912;
	bh=TJL2KUxvBkbktvbT6t4qD7pNueXKyvcojBYN0heniHg=;
	h=From:To:Cc:Subject:Date:From;
	b=An01hdLxUBWIFcDIM5YISBOsVNtOj3/wp/CtS7U2pXMNJEKPsJ8XPzrExrH5hwcRe
	 QI6929O/RdKngDx/1kvGuRVh8lTGUq5gAJMvI6eYE7EG/XDplYSrMMwVM2h0MT+B0A
	 0MqsqdKiHrveloo8QYV92arAjktubBd4b/Krz8G7tbTVEpwSH4mk1LHcM74QNarWtA
	 r3qtpILsIsiw0pAB/+84drgUPIL2fo1Icr+E44fkXB0wkN2AMEgUqMRDY2QOGf6qld
	 s/NjktYJQHpFYqRP9U2HvRM/WgJnNhFMjFZQP8+cRJ+E5mAigd0pAQuLlNj85MIyaS
	 TYx9488YXGxNg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chun-Tse Shao <ctshao@google.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Jakub Brnak <jbrnak@redhat.com>,
	Junhao He <hejunhao3@huawei.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Stephane Eranian <eranian@google.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.16
Date: Tue,  3 Jun 2025 17:35:01 -0300
Message-ID: <20250603203501.1961487-1-acme@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling the perf tools changes and improvements
for v6.16.

	There is a conflict detected by linux-next on a copy of a kernel
header, tools/arch/x86/include/asm/cpufeatures.h.

Best regards,

- Arnaldo

The following changes since commit a5806cd506af5a7c19bcd596e4708b5c464bfd21:

  Linux 6.15-rc7 (2025-05-18 13:57:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.16-1-2025-06-03

for you to fetch changes up to a913ef6fd883c05bd6538ed21ee1e773f0d750b7:

  perf callchain: Always populate the addr_location map when adding IP (2025-05-31 08:58:30 -0300)

----------------------------------------------------------------
perf tools improvements and fixes for Linux v6.16:

perf report/top/annotate TUI:

- Accept the left arrow key as a Zoom out if done on the first column.

- Show if source code toggle status in title, to help spotting bugs with
  the various disassemblers (capstone, llvm, objdump).

- Provide feedback on unhandled hotkeys.

Build:

- Better inform when certain features are not available with warnings in the
  build process and in 'perf version --build-options' or 'perf -vv'.

perf record:

- Improve the --off-cpu code by synthesizing events for switch-out -> switch-in
  intervals using a BPF program. This can be fine tuned using a --off-cpu-thresh
  knob.

perf report:

- Add 'tgid' sort key.

perf mem/c2c:

- Add 'op', 'cache', 'snoop', 'dtlb' output fields.

- Add support for 'ldlat' on AMD IBS (Instruction Based Sampling).

perf ftrace:

- Use process/session specific trace settings instead of messing with
  the global ftrace knobs.

perf trace:

- Implement syscall summary in BPF.

- Support --summary-mode=cgroup.

- Always print return value for syscalls returning a pid.

- The rseq and set_robust_list don't return a pid, just -errno.

perf lock contention:

-  Symbolize zone->lock using BTF.

- Add -J/--inject-delay option to estimate impact on application performance by
  optimization of kernel locking behavior.

perf stat:

- Improve hybrid support for the NMI watchdog warning.

Symbol resolution:

- Handle 'u' and 'l' symbols in /proc/kallsyms, resolving some Rust symbols.

- Improve Rust demangler.

Hardware tracing:

Intel PT:

- Fix PEBS-via-PT data_src.

- Do not default to recording all switch events.

- Fix pattern matching with python3 on the SQL viewer script.

arm64:

- Fixups for the hip08 hha PMU.

Vendor events:

- Update Intel events/metrics files for alderlake, alderlaken, arrowlake,
  bonnell, broadwell, broadwellde, broadwellx, cascadelakex, clearwaterforest,
  elkhartlake, emeraldrapids, grandridge, graniterapids, haswell, haswellx,
  icelake, icelakex, ivybridge, ivytown, jaketown, lunarlake, meteorlake,
  nehalemep, nehalemex, rocketlake, sandybridge, sapphirerapids, sierraforest,
  skylake, skylakex, snowridgex, tigerlake, westmereep-dp, westmereep-sp,
  westmereep-sx.

python support:

- Add support for event counts in the python binding, add a counting.py example.

perf list:

- Display the PMU name associated with a perf metric in JSON.

perf test:

- Hybrid improvements for metric value validation test.

- Fix LBR test by ignoring idle task.

- Add AMD IBS sw filter ana d'ldlat' tests.

- Add 'perf trace --summary-mode=cgroup' test.

- Add tests for the various language symbol demanglers.

Miscellaneous.

- Allow specifying the cpu an event will be tied using '-e event/cpu=N/'.

- Sync various headers with the kernel sources.

- Add annotations to use clang's -Wthread-safety and fix some problems
  it detected.

- Make dump_stack() use perf's symbol resolution to provide better backtraces.

- Intel TPEBS support cleanups and fixes. TPEBS stands for Timed PEBS
  (Precision Event-Based Sampling), that adds timing info, the retirement
  latency of instructions.

- Various memory allocation (some detected by ASAN) and reference counting
  fixes.

- Add a 8-byte aligned PERF_RECORD_COMPRESSED2 to replace PERF_RECORD_COMPRESSED.

- Skip unsupported event types in perf.data files, don't stop when finding one.

- Improve lookups using hashmaps and binary searches.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (3):
      perf intel-pt: Fix PEBS-via-PT data_src
      perf intel-pt: Do not default to recording all switch events
      perf scripts python: exported-sql-viewer.py: Fix pattern matching with Python 3

Anubhav Shelat (2):
      perf trace: Always print return value for syscalls returning a pid
      perf trace: Set errpid to false for rseq and set_robust_list

Arnaldo Carvalho de Melo (34):
      tools build: Don't set libunwind as available if test-all.c build succeeds
      perf check: Share the feature status printing routine with 'perf version'
      perf check: Move the FEATURE_STATUS() macro to its only user source file
      perf check: Allow showing a tip for opt-in features not built into perf
      tools build: Don't show libunwind build status as it is opt-in
      perf build: Warn when libdebuginfod devel files are not available
      perf check: Add tip about building with libbfd using BUILD_NONDISTRO=1
      tools build: Don't show libbfd build status as it is opt-in
      perf ui browser: Add key_name() helper
      perf ui browser: Add a warn on unhandled hotkey helper
      perf ui browser annotate-data: Provide feedback on unhandled hotkeys
      perf ui browser annotate: Provide feedback on unhandled hotkeys
      perf ui browser header: Provide feedback on unhandled hotkeys
      perf ui browser hists: Provide feedback on unhandled hotkeys
      perf ui browser map: Provide feedback on unhandled hotkeys
      perf ui browser annotate: Show in the title the source code view toggle
      perf ui browser annotate: Don't show the source code view status initially
      perf ui browser: Accept the left arrow key as a Zoom out if done on the first column
      perf ui browser hists: Simplify the routines that add entries to the popup menu
      perf ui browser hists: Set actions->thread before calling do_zoom_thread()
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf symbols: Handle 'u' and 'l' symbols in /proc/kallsyms
      perf test perf-report-hierarchy: Add new test
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools headers x86 cpufeatures: Sync with the kernel sources to pick ZEN6 and Indirect Target Selection (ITS) bits
      tools headers: Sync the linux/unaligned.h copy with the kernel sources
      tools headers: Synchronize uapi/linux/bits.h with the kernel sources
      tools headers compiler: Pick the const_true() define from the kernel sources
      tools headers: Synchronize linux/bits.h with the kernel sources
      perf tests trace_summary.sh: Run in exclusive mode
      Revert "perf thread: Ensure comm_lock held for comm_list"

Chun-Tse Shao (5):
      perf session: Skip unsupported new event types
      perf test: Add stat uniquifying test
      perf test: Allow tolerance for leader sampling test
      perf record: Add 8-byte aligned event type PERF_RECORD_COMPRESSED2
      perf record: Fix a asan runtime error in util/maps.c

Colin Ian King (1):
      perf test amd ibs: Fix spelling mistake "Asssuming" -> "Assuming"

Dapeng Mi (1):
      perf record: Fix incorrect --user-regs comments

Gautam Menghani (4):
      perf python: Add support for 'struct perf_counts_values' to return counter data
      perf python: Add evsel read method
      perf python: Add evlist close support
      perf python: Add counting.py as example for counting perf events

Howard Chu (10):
      perf evsel: Expose evsel__is_offcpu_event() for future use
      perf record --off-cpu: Parse off-cpu event
      perf record --off-cpu: Preparation of off-cpu BPF program
      perf record --off-cpu: Dump off-cpu samples in BPF
      perf evsel: Assemble off-cpu samples
      perf record --off-cpu: Disable perf_event's callchain collection
      perf script: Display off-cpu samples correctly
      perf record --off-cpu: Dump the remaining PERF_SAMPLE_ in sample_type from BPF's stack trace map
      perf record --off-cpu: Add --off-cpu-thresh option
      perf test: Add direct off-cpu tests

Ian Rogers (99):
      perf vendor events: Update alderlake events/metrics
      perf vendor events: Update AlderlakeN events/metrics
      perf vendor events: Update arrowlake events/metrics
      perf vendor events: Update bonnell events
      perf vendor events: Update broadwell metrics
      perf vendor events: Update broadwellde metrics
      perf vendor events: Update broadwellx metrics
      perf vendor events: Update cascadelakex events/metrics
      perf vendor events: Update clearwaterforest events
      perf vendor events: Update elkhartlake events
      perf vendor events: Update emeraldrapids events/metrics
      perf vendor events: Update grandridge events/metrics
      perf vendor events: Add graniterapids retirement latencies
      perf vendor events: Update haswell metrics
      perf vendor events: Update haswellx metrics
      perf vendor events: Update icelake events/metrics
      perf vendor events: Update icelakex events/metrics
      perf vendor events: Update ivybridge metrics
      perf vendor events: Update ivytown metrics
      perf vendor events: Update jaketown metrics
      perf vendor events: Update lunarlake events/metrics
      perf vendor events: Update meteorlake events/metrics
      perf vendor events: Update nehalemep events
      perf vendor events: Update nehalemex events
      perf vendor events: Update rocketlake events/metrics
      perf vendor events: Update sandybridge metrics
      perf vendor events: Update sapphirerapids events/metrics
      perf vendor events: Update sierraforest events/metrics
      perf vendor events: Update skylake metrics
      perf vendor events: Update skylakex events/metrics
      perf vendor events: Update snowridgex events
      perf vendor events: Update tigerlake metrics
      perf vendor events: Update westmereep-dp events
      perf vendor events: Update westmereep-dp events
      perf vendor events: Update westmereep-dp events
      perf intel-tpebs: Cleanup header
      perf intel-tpebs: Simplify tpebs_cmd
      perf intel-tpebs: Rename tpebs_start to evsel__tpebs_open
      perf intel-tpebs: Separate evsel__tpebs_prepare() out of evsel__tpebs_open()
      perf intel-tpebs: Move the cpumap_buf variable out of evsel__tpebs_open()
      perf intel-tpebs: Reduce scope of the tpebs_events_size variable
      perf intel-tpebs: Inline get_perf_record_args
      perf intel-tpebs: Ensure events are opened, factor out finding
      perf intel-tpebs: Refactor tpebs_results list
      perf intel-tpebs: Add support for updating counts in evsel__tpebs_read
      perf intel-tpebs: Add mutex for tpebs_results
      perf intel-tpebs: Don't close record on read
      perf intel-tpebs: Use stats for retirement latency statistics
      perf stat: Add mean, min, max and last --tpebs-mode options
      perf pmu-events: Add retirement latency to JSON events inside of perf
      perf record: Retirement latency cleanup in evsel__config
      perf tool_pmu: Fix aggregation on duration_time
      perf tests record: Cleanup improvements
      perf bench evlist-open-close: Reduce scope of 2 variables
      perf symbol-minimal: Fix double free in filename__read_build_id
      perf trace: Free the files.max entry in files->table
      perf trace: Add missing thread__put() in thread__e_machine()
      perf stat: Better hybrid support for the NMI watchdog warning
      perf stat: Remove print_mixed_hw_group_error
      perf evlist: Refactor evlist__scnprintf_evsels()
      perf evlist: Make groups visible in evlist__format_evsels() output
      perf parse-events: Add debug dump of evlist if reordered
      perf demangle-rust: Add rustc-demangle C demangler
      perf symbol-elf: Integrate rust-v0 demangling
      perf demangle-rust: Remove previous legacy rust decoder
      perf test demangle-rust: Add Rust demangling test
      perf test demangle-java: Switch to using dso__demangle_sym()
      perf test demangle-ocaml: Switch to using dso__demangle_sym()
      perf evsel: Add per-thread warning for EOPNOTSUPP open failues
      perf tests metrics: Permission related fixes
      libperf cpumap: Add ability to create CPU from a single CPU number
      perf stat: Use counter cpumask to skip zero values
      perf parse-events: Set is_pmu_core for legacy hardware events
      perf parse-events: Add "cpu" term to set the CPU an event is recorded on
      perf tests: Harden branch stack sampling test
      perf fncache: Switch to using hashmap
      perf pmu: Change aliases from list to hashmap
      perf metricgroup: Binary search when resolving referred to metrics
      perf list: Display the PMU name associated with a perf metric in JSON
      perf test: Hybrid improvements for metric value validation test
      perf evlist: Make uniquifying counter names consistent
      perf parse-events: Use wildcard processing to set an event to merge into
      perf intel-tpebs: Filter non-workload samples
      perf dso: Minor refactor to allow clang's Wthread-safety analysis
      perf rwsem: Add clang's -Wthread-safety annotations
      perf thread: Ensure comm_lock held for comm_list
      libperf threadmap: Don't segv for index 0 for the NULL 'struct perf_thread_map' pointer
      libperf threadmap: Add perf_thread_map__idx()
      perf python: Add evsel cpus and threads functions
      perf pmu intel: Adjust cpumaks for sub-NUMA clusters on graniterapids
      perf machine: Factor creating a "live" machine out of dwarf-unwind
      perf pmu: Avoid segv for missing name/alias_name in wildcarding
      perf symbol: Fix use-after-free in filename__read_build_id
      perf test demangle-java: Don't segv if demangling fails
      perf intel-tpebs: Avoid race when evlist is being deleted
      perf test intel-pt: Skip jitdump test if no libelf
      perf test trace_summary: Skip --bpf-summary tests if no libbpf
      perf symbol: Move demangling code out of symbol-elf.c
      perf callchain: Always populate the addr_location map when adding IP

Jakub Brnak (1):
      perf test probe_vfs_getname: Skip if no suitable line detected

James Clark (1):
      perf tools: Fix arm64 source package build

Junhao He (3):
      perf vendor events arm64: Fill up Desc field for Hisi hip08 hha pmu
      perf vendor events arm64: Drop hip08 PublicDescription if same as BriefDescription
      MAINTAINERS: Add hisilicon PMU JSON events under its entry

Leo Yan (3):
      perf test probe_vfs_getname: Add regex for searching probe line
      perf tests switch-tracking: Fix timestamp comparison
      perf script: Print PERF_AUX_FLAG_COLLISION flag

Michael Petlan (1):
      perf tests: Fix 'perf report' tests installation

Namhyung Kim (31):
      perf hist: Remove formats in hierarchy when cancel children
      perf hist: Remove formats in hierarchy when cancel latency
      perf hist: Set levels in output_field_add()
      perf hist: Allow custom output fields in hierarchy mode
      perf trace: Implement syscall summary in BPF
      perf test: Add perf trace summary test
      perf lock contention: Symbolize zone->lock using BTF
      perf hist: Remove output field from sort-list properly
      perf record: Add --sample-mem-info option
      perf hist: Support multi-line header
      perf hist: Add struct he_mem_stat
      perf hist: Basic support for mem_stat accounting
      perf hist: Implement output fields for mem stats
      perf mem: Add 'op' output field
      perf hist: Hide unused mem stat columns
      perf mem: Add 'cache' and 'memory' output fields
      perf mem: Add 'snoop' output field
      perf mem: Add 'dtlb' output field
      perf trace: Fix leaks of 'struct thread' in fprintf_sys_enter()
      perf trace: Fix leaks of 'struct thread' in set_filter_loop_pids()
      perf lock contention: Add -J/--inject-delay option
      perf pmu: Use available core PMU for raw events
      perf test: Fix LBR test by ignoring idle task
      perf test: Update sysfs path for core PMU caps
      perf report: Add 'tgid' sort key
      perf trace: Support --summary-mode=cgroup
      perf test: Add cgroup summary test case for 'perf trace'
      perf test: Add AMD IBS sw filter test
      perf mem: Display sort order only if it's available
      perf mem: Show absolute percent in mem_stat output
      perf lock contention: Reject more than 10ms delays for safety

Ravi Bangoria (6):
      perf amd ibs: Add Load Latency bits in raw dump
      perf amd ibs: Incorporate Zen5 DTLB and PageSize information
      perf mem/c2c amd: Add ldlat support
      perf test amd ibs: Add sample period unit test
      perf test amd: Skip amd-ibs-period test on kernel < v6.15
      perf mem: Describe overhead calculation in brief

Thomas Richter (2):
      perf tests metric-only perf stat: Fix tests 84 and 86 s390
      perf ftrace: Use process/session specific trace settings

Yicong Yang (2):
      perf arm-spe: Add support for SPE Data Source packet on HiSilicon HIP12
      perf mem: Count L2 HITM for c2c statistic

 MAINTAINERS                                        |    1 +
 tools/arch/arm64/include/asm/cputype.h             |    2 +
 tools/arch/x86/include/asm/cpufeatures.h           |    5 +-
 tools/arch/x86/include/asm/msr-index.h             |    8 +
 tools/build/Makefile.feature                       |    4 -
 tools/include/linux/bits.h                         |    5 +-
 tools/include/linux/compiler.h                     |   22 +
 tools/include/uapi/linux/bits.h                    |    8 +-
 tools/include/vdso/unaligned.h                     |   12 +-
 tools/lib/perf/Documentation/libperf.txt           |    1 +
 tools/lib/perf/cpumap.c                            |   10 +
 tools/lib/perf/include/perf/cpumap.h               |    2 +
 tools/lib/perf/include/perf/event.h                |   12 +
 tools/lib/perf/include/perf/threadmap.h            |    1 +
 tools/lib/perf/threadmap.c                         |   17 +
 tools/perf/Documentation/perf-amd-ibs.txt          |    9 +
 tools/perf/Documentation/perf-c2c.txt              |   11 +-
 tools/perf/Documentation/perf-config.txt           |    4 +
 tools/perf/Documentation/perf-list.txt             |    9 +
 tools/perf/Documentation/perf-lock.txt             |   15 +
 tools/perf/Documentation/perf-mem.txt              |   32 +-
 tools/perf/Documentation/perf-record.txt           |   16 +-
 tools/perf/Documentation/perf-report.txt           |    1 +
 tools/perf/Documentation/perf-stat.txt             |    7 +
 tools/perf/Documentation/perf-trace.txt            |    9 +-
 tools/perf/Documentation/perf.data-file-format.txt |   24 +-
 tools/perf/MANIFEST                                |    6 +
 tools/perf/Makefile.config                         |    6 +-
 tools/perf/Makefile.perf                           |    5 +-
 tools/perf/arch/x86/include/arch-tests.h           |    1 +
 tools/perf/arch/x86/tests/Build                    |    1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c         | 1032 ++++++++++
 tools/perf/arch/x86/tests/arch-tests.c             |    2 +
 tools/perf/arch/x86/util/intel-pt.c                |   16 +-
 tools/perf/arch/x86/util/mem-events.c              |    6 +
 tools/perf/arch/x86/util/mem-events.h              |    1 +
 tools/perf/arch/x86/util/pmu.c                     |  288 ++-
 tools/perf/bench/evlist-open-close.c               |   42 +-
 tools/perf/builtin-c2c.c                           |    3 +-
 tools/perf/builtin-check.c                         |   38 +-
 tools/perf/builtin-ftrace.c                        |  101 +-
 tools/perf/builtin-list.c                          |   12 +-
 tools/perf/builtin-lock.c                          |   79 +
 tools/perf/builtin-record.c                        |   80 +-
 tools/perf/builtin-report.c                        |   21 +-
 tools/perf/builtin-script.c                        |    4 +-
 tools/perf/builtin-stat.c                          |   37 +-
 tools/perf/builtin-top.c                           |    9 +-
 tools/perf/builtin-trace.c                         |   78 +-
 tools/perf/builtin-version.c                       |   30 +-
 tools/perf/builtin.h                               |    9 +-
 .../arch/arm64/hisilicon/hip08/uncore-ddrc.json    |    8 -
 .../arch/arm64/hisilicon/hip08/uncore-hha.json     |   26 +-
 .../arch/arm64/hisilicon/hip08/uncore-l3c.json     |   13 -
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  489 ++---
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  284 ++-
 .../arch/x86/alderlake/floating-point.json         |   29 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |   78 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   82 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |  209 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |  308 ++-
 .../arch/x86/alderlake/virtual-memory.json         |   43 +-
 .../arch/x86/alderlaken/adln-metrics.json          |   54 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |  107 +-
 .../arch/x86/alderlaken/floating-point.json        |    1 +
 .../pmu-events/arch/x86/alderlaken/memory.json     |   50 +
 .../perf/pmu-events/arch/x86/alderlaken/other.json |  102 +-
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   55 +-
 .../arch/x86/alderlaken/virtual-memory.json        |    3 +
 .../pmu-events/arch/x86/arrowlake/arl-metrics.json |  566 +++---
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |  200 +-
 .../pmu-events/arch/x86/arrowlake/frontend.json    |   39 +-
 .../perf/pmu-events/arch/x86/arrowlake/memory.json |   36 +-
 .../perf/pmu-events/arch/x86/arrowlake/other.json  |  197 +-
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |  230 ++-
 tools/perf/pmu-events/arch/x86/bonnell/other.json  |    8 -
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |    8 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |  256 ++-
 .../arch/x86/broadwellde/bdwde-metrics.json        |  180 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |  268 ++-
 .../pmu-events/arch/x86/cascadelakex/cache.json    |  404 ++++
 .../arch/x86/cascadelakex/clx-metrics.json         |  389 ++--
 .../pmu-events/arch/x86/cascadelakex/other.json    |  404 ----
 .../arch/x86/clearwaterforest/cache.json           |   35 +
 .../arch/x86/clearwaterforest/memory.json          |    2 +
 .../arch/x86/clearwaterforest/other.json           |   22 -
 .../arch/x86/clearwaterforest/pipeline.json        |    6 +-
 .../pmu-events/arch/x86/elkhartlake/cache.json     |  296 ++-
 .../arch/x86/elkhartlake/floating-point.json       |    1 +
 .../pmu-events/arch/x86/elkhartlake/memory.json    |  261 +++
 .../pmu-events/arch/x86/elkhartlake/other.json     |  404 +---
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   31 +-
 .../arch/x86/elkhartlake/virtual-memory.json       |    4 +
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |  284 ++-
 .../arch/x86/emeraldrapids/emr-metrics.json        |  475 ++---
 .../arch/x86/emeraldrapids/floating-point.json     |   43 +-
 .../arch/x86/emeraldrapids/frontend.json           |   78 +-
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |  231 ++-
 .../pmu-events/arch/x86/emeraldrapids/other.json   |  332 +---
 .../arch/x86/emeraldrapids/pipeline.json           |  259 ++-
 .../arch/x86/emeraldrapids/virtual-memory.json     |   40 +-
 .../perf/pmu-events/arch/x86/grandridge/cache.json |  155 +-
 .../pmu-events/arch/x86/grandridge/counter.json    |    2 +-
 .../pmu-events/arch/x86/grandridge/frontend.json   |    8 +
 .../arch/x86/grandridge/grr-metrics.json           |  204 +-
 .../pmu-events/arch/x86/grandridge/memory.json     |    2 +
 .../perf/pmu-events/arch/x86/grandridge/other.json |   29 +-
 .../pmu-events/arch/x86/grandridge/pipeline.json   |   52 +-
 .../arch/x86/grandridge/uncore-cache.json          |   45 +-
 .../arch/x86/grandridge/uncore-memory.json         |  338 ++++
 .../pmu-events/arch/x86/graniterapids/cache.json   |  305 ++-
 .../pmu-events/arch/x86/graniterapids/counter.json |    5 +
 .../arch/x86/graniterapids/floating-point.json     |   43 +-
 .../arch/x86/graniterapids/frontend.json           |  105 +-
 .../arch/x86/graniterapids/gnr-metrics.json        |  487 ++---
 .../pmu-events/arch/x86/graniterapids/memory.json  |  206 +-
 .../pmu-events/arch/x86/graniterapids/other.json   |  243 +--
 .../arch/x86/graniterapids/pipeline.json           |  261 ++-
 .../arch/x86/graniterapids/uncore-cache.json       |   42 +
 .../x86/graniterapids/uncore-interconnect.json     |   90 +-
 .../arch/x86/graniterapids/uncore-memory.json      |  240 +++
 .../arch/x86/graniterapids/virtual-memory.json     |   40 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |  206 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  222 ++-
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |   60 +
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  385 ++--
 tools/perf/pmu-events/arch/x86/icelake/memory.json |  160 ++
 tools/perf/pmu-events/arch/x86/icelake/other.json  |  220 ---
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |  273 +++
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  399 ++--
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |  190 ++
 tools/perf/pmu-events/arch/x86/icelakex/other.json |  463 -----
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   76 +-
 .../arch/x86/ivybridge/metricgroups.json           |    5 +
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   80 +-
 .../pmu-events/arch/x86/ivytown/metricgroups.json  |    5 +
 .../pmu-events/arch/x86/jaketown/frontend.json     |    8 +
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   40 +-
 .../pmu-events/arch/x86/jaketown/metricgroups.json |    5 +
 tools/perf/pmu-events/arch/x86/jaketown/other.json |    8 -
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |  182 +-
 .../pmu-events/arch/x86/lunarlake/frontend.json    |   39 +-
 .../pmu-events/arch/x86/lunarlake/lnl-metrics.json |  560 +++---
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |   75 +-
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |  358 +---
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |  253 ++-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   14 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  352 +++-
 .../arch/x86/meteorlake/floating-point.json        |   28 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   82 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   90 +-
 .../arch/x86/meteorlake/mtl-metrics.json           |  553 +++---
 .../perf/pmu-events/arch/x86/meteorlake/other.json |  149 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  252 ++-
 .../arch/x86/meteorlake/uncore-memory.json         |   18 +
 .../arch/x86/meteorlake/virtual-memory.json        |   40 +-
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  |   32 +
 .../perf/pmu-events/arch/x86/nehalemep/other.json  |   40 -
 .../arch/x86/nehalemep/virtual-memory.json         |    8 +
 .../perf/pmu-events/arch/x86/nehalemex/cache.json  |   32 +
 .../perf/pmu-events/arch/x86/nehalemex/other.json  |   40 -
 .../arch/x86/nehalemex/virtual-memory.json         |    8 +
 .../perf/pmu-events/arch/x86/rocketlake/cache.json |   60 +
 .../pmu-events/arch/x86/rocketlake/memory.json     |  160 ++
 .../perf/pmu-events/arch/x86/rocketlake/other.json |  220 ---
 .../arch/x86/rocketlake/rkl-metrics.json           |  385 ++--
 .../pmu-events/arch/x86/sandybridge/frontend.json  |    8 +
 .../arch/x86/sandybridge/metricgroups.json         |    5 +
 .../pmu-events/arch/x86/sandybridge/other.json     |    8 -
 .../arch/x86/sandybridge/snb-metrics.json          |   36 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |  343 +++-
 .../arch/x86/sapphirerapids/floating-point.json    |   43 +-
 .../arch/x86/sapphirerapids/frontend.json          |   78 +-
 .../pmu-events/arch/x86/sapphirerapids/memory.json |  231 ++-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |  382 +---
 .../arch/x86/sapphirerapids/pipeline.json          |  259 ++-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  469 ++---
 .../arch/x86/sapphirerapids/virtual-memory.json    |   40 +-
 .../pmu-events/arch/x86/sierraforest/cache.json    |   25 +
 .../pmu-events/arch/x86/sierraforest/memory.json   |   24 +
 .../pmu-events/arch/x86/sierraforest/other.json    |   49 +-
 .../pmu-events/arch/x86/sierraforest/pipeline.json |    9 +
 .../arch/x86/sierraforest/srf-metrics.json         |  204 +-
 .../arch/x86/sierraforest/uncore-cache.json        |   32 +
 .../arch/x86/sierraforest/uncore-memory.json       |  240 +++
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  367 ++--
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |   74 +
 tools/perf/pmu-events/arch/x86/skylakex/other.json |   74 -
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  385 ++--
 .../perf/pmu-events/arch/x86/snowridgex/cache.json |  296 ++-
 .../arch/x86/snowridgex/floating-point.json        |    1 +
 .../pmu-events/arch/x86/snowridgex/memory.json     |  261 +++
 .../perf/pmu-events/arch/x86/snowridgex/other.json |  404 +---
 .../pmu-events/arch/x86/snowridgex/pipeline.json   |   31 +-
 .../arch/x86/snowridgex/virtual-memory.json        |    4 +
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  383 ++--
 .../pmu-events/arch/x86/westmereep-dp/cache.json   |   32 +
 .../pmu-events/arch/x86/westmereep-dp/other.json   |   40 -
 .../arch/x86/westmereep-dp/virtual-memory.json     |    8 +
 .../pmu-events/arch/x86/westmereep-sp/cache.json   |   32 +
 .../pmu-events/arch/x86/westmereep-sp/other.json   |   40 -
 .../arch/x86/westmereep-sp/virtual-memory.json     |    8 +
 .../perf/pmu-events/arch/x86/westmereex/cache.json |   32 +
 .../perf/pmu-events/arch/x86/westmereex/other.json |   40 -
 .../arch/x86/westmereex/virtual-memory.json        |    8 +
 tools/perf/pmu-events/empty-pmu-events.c           |  282 ++-
 tools/perf/pmu-events/jevents.py                   |   72 +-
 tools/perf/pmu-events/pmu-events.h                 |   26 +-
 tools/perf/python/counting.py                      |   36 +
 tools/perf/scripts/python/exported-sql-viewer.py   |    5 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |    1 +
 tools/perf/tests/demangle-java-test.c              |   22 +-
 tools/perf/tests/demangle-ocaml-test.c             |    7 +-
 tools/perf/tests/demangle-rust-v0-test.c           |   74 +
 tools/perf/tests/dwarf-unwind.c                    |   35 +-
 tools/perf/tests/pmu-events.c                      |  129 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh           |   67 +
 .../perf/tests/shell/lib/perf_metric_validation.py |   12 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   20 +-
 tools/perf/tests/shell/lib/stat_output.sh          |    5 +
 tools/perf/tests/shell/perf-report-hierarchy.sh    |   43 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |    8 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    8 +-
 tools/perf/tests/shell/record.sh                   |   41 +-
 tools/perf/tests/shell/record_lbr.sh               |    5 +-
 tools/perf/tests/shell/record_offcpu.sh            |   71 +
 tools/perf/tests/shell/stat+event_uniquifying.sh   |   69 +
 tools/perf/tests/shell/stat+json_output.sh         |    5 +
 tools/perf/tests/shell/stat_all_metrics.sh         |  118 +-
 tools/perf/tests/shell/stat_metrics_values.sh      |   17 +-
 tools/perf/tests/shell/test_brstack.sh             |   72 +-
 tools/perf/tests/shell/test_data_symbol.sh         |   29 +-
 tools/perf/tests/shell/test_intel_pt.sh            |    5 +
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    9 +-
 tools/perf/tests/shell/trace_summary.sh            |   77 +
 tools/perf/tests/switch-tracking.c                 |    2 +-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/trace/beauty/include/uapi/linux/vhost.h |    4 +-
 tools/perf/ui/Build                                |    1 +
 tools/perf/ui/browser.c                            |   10 +
 tools/perf/ui/browser.h                            |    1 +
 tools/perf/ui/browsers/annotate-data.c             |    1 +
 tools/perf/ui/browsers/annotate.c                  |   24 +-
 tools/perf/ui/browsers/header.c                    |    1 +
 tools/perf/ui/browsers/hists.c                     |  123 +-
 tools/perf/ui/browsers/map.c                       |    4 +-
 tools/perf/ui/hist.c                               |  307 ++-
 tools/perf/ui/keysyms.c                            |   44 +
 tools/perf/ui/keysyms.h                            |    2 +
 tools/perf/ui/stdio/hist.c                         |   57 +-
 tools/perf/util/Build                              |   11 +-
 tools/perf/util/amd-sample-raw.c                   |   77 +-
 tools/perf/util/annotate.c                         |    1 +
 tools/perf/util/annotate.h                         |    1 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   17 +
 tools/perf/util/arm-spe.c                          |   96 +
 tools/perf/util/bpf-trace-summary.c                |  458 +++++
 tools/perf/util/bpf_lock_contention.c              |  116 +-
 tools/perf/util/bpf_off_cpu.c                      |  119 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |  107 +
 tools/perf/util/bpf_skel/lock_data.h               |    1 +
 tools/perf/util/bpf_skel/off_cpu.bpf.c             |   98 +-
 tools/perf/util/bpf_skel/syscall_summary.bpf.c     |  153 ++
 tools/perf/util/bpf_skel/syscall_summary.h         |   27 +
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |    9 +
 tools/perf/util/demangle-cxx.h                     |    2 +
 tools/perf/util/demangle-rust-v0.c                 | 2042 ++++++++++++++++++++
 tools/perf/util/demangle-rust-v0.h                 |   88 +
 tools/perf/util/demangle-rust.c                    |  269 ---
 tools/perf/util/demangle-rust.h                    |    8 -
 tools/perf/util/dso.c                              |   45 +-
 tools/perf/util/dsos.c                             |    3 +
 tools/perf/util/event.c                            |    6 +-
 tools/perf/util/evlist.c                           |  101 +-
 tools/perf/util/evlist.h                           |    6 +-
 tools/perf/util/evsel.c                            |  188 +-
 tools/perf/util/evsel.h                            |   19 +-
 tools/perf/util/evsel_config.h                     |    1 +
 tools/perf/util/fncache.c                          |   69 +-
 tools/perf/util/fncache.h                          |    1 -
 tools/perf/util/hist.c                             |   78 +
 tools/perf/util/hist.h                             |   27 +-
 tools/perf/util/hwmon_pmu.c                        |   43 +-
 tools/perf/util/intel-pt.c                         |  205 +-
 tools/perf/util/intel-tpebs.c                      |  731 ++++---
 tools/perf/util/intel-tpebs.h                      |   40 +-
 tools/perf/util/lock-contention.h                  |    9 +
 tools/perf/util/machine.c                          |   59 +-
 tools/perf/util/machine.h                          |    1 +
 tools/perf/util/maps.c                             |    9 +-
 tools/perf/util/mem-events.c                       |  188 +-
 tools/perf/util/mem-events.h                       |   57 +
 tools/perf/util/metricgroup.c                      |  107 +-
 tools/perf/util/metricgroup.h                      |    2 +-
 tools/perf/util/mutex.h                            |   11 +
 tools/perf/util/off_cpu.h                          |    3 +-
 tools/perf/util/parse-events.c                     |  213 +-
 tools/perf/util/parse-events.h                     |    3 +-
 tools/perf/util/parse-events.l                     |    1 +
 tools/perf/util/pmu.c                              |  236 ++-
 tools/perf/util/pmu.h                              |    9 +-
 tools/perf/util/pmus.c                             |   21 +-
 tools/perf/util/print-events.h                     |    3 +-
 tools/perf/util/python.c                           |  178 +-
 tools/perf/util/record.h                           |    2 +
 tools/perf/util/rwsem.c                            |    4 +
 tools/perf/util/rwsem.h                            |   10 +-
 tools/perf/util/session.c                          |   18 +-
 tools/perf/util/sort.c                             |  116 +-
 tools/perf/util/sort.h                             |    3 +-
 tools/perf/util/srccode.c                          |    4 +-
 tools/perf/util/stat-display.c                     |  230 +--
 tools/perf/util/stat.c                             |   40 +-
 tools/perf/util/stat.h                             |    1 -
 tools/perf/util/symbol-elf.c                       |   71 +-
 tools/perf/util/symbol-minimal.c                   |  167 +-
 tools/perf/util/symbol.c                           |   90 +-
 tools/perf/util/thread.c                           |    9 +-
 tools/perf/util/thread.h                           |    2 +-
 tools/perf/util/tool.c                             |   11 +-
 tools/perf/util/tool_pmu.c                         |   25 +-
 tools/perf/util/trace.h                            |   38 +
 323 files changed, 22088 insertions(+), 11905 deletions(-)
 create mode 100644 tools/perf/arch/x86/tests/amd-ibs-period.c
 delete mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
 create mode 100755 tools/perf/python/counting.py
 create mode 100644 tools/perf/tests/demangle-rust-v0-test.c
 create mode 100755 tools/perf/tests/shell/amd-ibs-swfilt.sh
 create mode 100755 tools/perf/tests/shell/perf-report-hierarchy.sh
 create mode 100755 tools/perf/tests/shell/stat+event_uniquifying.sh
 create mode 100755 tools/perf/tests/shell/trace_summary.sh
 create mode 100644 tools/perf/ui/keysyms.c
 create mode 100644 tools/perf/util/bpf-trace-summary.c
 create mode 100644 tools/perf/util/bpf_skel/syscall_summary.bpf.c
 create mode 100644 tools/perf/util/bpf_skel/syscall_summary.h
 create mode 100644 tools/perf/util/demangle-rust-v0.c
 create mode 100644 tools/perf/util/demangle-rust-v0.h
 delete mode 100644 tools/perf/util/demangle-rust.c
 delete mode 100644 tools/perf/util/demangle-rust.h
 create mode 100644 tools/perf/util/trace.h
