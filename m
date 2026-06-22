Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3C9283FE6;
	Mon, 22 Jun 2026 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782156131; cv=none; b=LKP+bdhw2HU9cjYvGxxFm4w4RLvDUzEsjwMR635IBDLipmnzDjfjTzwCkID0pkZjHNrPGOvvhMrZECuWLcSHzHmKzKS6dJf5fwhVA9EmUkSIib9gebOJTlHrqkibqk0Yaqq89IyK0F7h6Uk1XasM4Q3ZFSifkTdDVGhr0hTNPQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782156131; c=relaxed/simple;
	bh=TxSJI0dtQpmL/GH6JPAXPHl73b3DwoHSGozOQKZh7cs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ChGfzQ7fRg2/sDjg2cdgvj1DlKjR3eJnPjcMAoNu2O6U+4qIWNiTSaA+C8d52V5Tp6lNBCLIKRc7LG/AzIsjELn7q6QYXq/2MdIrl5bBhOQ+kuFz/3EULCqlkeL5I3U/N7YZ8xU/J9TI/BntdjdRn4NyuHIF+IIi1B4g/Bb/Yqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K12Nf3Pq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K12Nf3Pq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2671F00A3A;
	Mon, 22 Jun 2026 19:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782156127;
	bh=kw6AY9IMlc0w8el//8Be9PjZ1QgvSNCG8XAUuPyEt5Y=;
	h=From:To:Cc:Subject:Date;
	b=K12Nf3Pq01krKYPI0trXWWPaxOge9Az7vJ2RDFfz+JDMKQMvAuga7K025OjliwTJP
	 DUGjwM3X/bJ/LupVde9WS+/W5ATXiUiQaHWOZU47yXYEeiTxmNznktnjEg0XePL0Zw
	 oeX8PegAp2PweT6z+1omCC4f6grPeuKJhhtgZhcy8pCwWsiL7T2YfB048z153hby21
	 rRNaZlE+lRTYKfB4TPWv/veN6ZTwyI8KiFnV1GVJy8wYyuyaUHo9t6LwrcddqR7RDX
	 EcUooT13x5bH97HxK6MOhH1qtMPRjOQRi/d9/kc3Ovbz3ubX+D+w1nyFct1Ab09biZ
	 lvWnO6iat6ouw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCHES 000/343] perf tools improvements and fixes for v7.2
Date: Mon, 22 Jun 2026 16:21:58 -0300
Message-ID: <20260622192158.12927-1-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Linus,

	Please consider pulling,

- Arnaldo

The following changes since commit e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7:

  Merge tag 'for-7.1/hpfs-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2026-05-25 12:49:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.2-1-2026-06-22

for you to fetch changes up to 3287a1881ca528b89b964d9fa6d28880d277d9e2:

  perf bpf: Fix up build failure due to change of btf_vlen() return type (2026-06-22 15:53:34 -0300)

----------------------------------------------------------------
perf tools changes for v7.2:

- Introduce 'perf inject --aslr' to remap ASLR-randomized
  addresses in perf.data files, enabling reproducible analysis
  across runs with different address space layouts.

- Refactor evsel out of sample processing paths: store evsel in
  struct perf_sample and remove the redundant evsel parameter from
  tool APIs, tracepoint handlers, hist entry iterators, and
  db-export, simplifying the entire tool callback chain.

- Switch architecture detection from string-based perf_env__arch()
  comparisons to the numeric ELF e_machine field across the
  codebase (capstone, print_insn, c2c, lock-contention, sort,
  sample-raw, machine, header), making cross-analysis more robust.

- Overhaul ARM CoreSight ETM tests: add deterministic and
  named_threads workloads, speed up basic and disassembly tests,
  add process attribution and concurrent threads tests, remove
  unused workloads and duplicate tests, queue context packets for
  the frontend decoder.

- Add ARM SPE IMPDEF event decoding for Arm Neoverse N1, store
  MIDR in arm_spe_pkt for per-CPU event mapping, handle missing
  CPU IDs gracefully.

- Refactor libunwind support: remove the libunwind-local backend,
  make register reading cross-platform, add RISC-V libunwind
  support, allow dynamic selection between libdw and libunwind
  unwinding at runtime.

- Extensive hardening of perf.data parsing against crafted files:
  add bounds checks and byte-swap validation for session records,
  feature sections, header attributes, BPF metadata, auxtrace
  errors, compressed events, CPU maps, build ID notes, and ELF
  program headers. Add minimum event size validation and file
  offset diagnostics.

- Fix libdw API contract violations across dwarf-aux, libdw,
  probe-finder, annotate-data, and debuginfo subsystems. Fix
  callchain parent update in ORDER_CALLER mode, support DWARF line
  0 in inline lists, handle multiple address spaces in callchains.

- Fix numerous 'perf sched' bugs: thread reference leaks, memory
  leaks, heap overflows with cross-machine recordings, NULL
  dereferences, replace BUG_ON assertions with graceful error
  handling, bounds-check CPU indices, fix SIGCHLD vs pause() races
  in sched stats.

- Overhaul the build system: move BPF skeleton generation out of
  Makefile.perf into bpf_skel.mak, decouple pmu-events from the
  prepare target, make beauty generated C code standalone .o files,
  compile BPF skeletons with -mcpu=v3, fix continuous rebuilds,
  various cleanups.

- Add 'perf test' JUnit XML reporting with -j/--junit option, split
  monolithic test suites into sub-tests, add summary reporting,
  refactor parallel poll loop, fix test failures on musl-based
  systems.

- Fix 'perf c2c' memory leaks in hist entry and format list
  handling, use-after-free in error paths, bounds-check CPU and
  node IDs.

- Fix 'perf bpf' metadata leaks on duplicate insert and alloc
  failure, bounds-check array offsets, validate event sizes and
  func_info fields, add NULL checks.

- Fix hwmon PMU: off-by-one null termination on sysfs reads,
  strlcpy buffer overflow in parse_hwmon_filename(), fd 0 check,
  empty label reads, scnprintf usage.

- Fix symbols subsystem: bounds-check ELF and sysfs build ID note
  iteration, validate p_filesz, fix 32-bit ELF bswap error, fix
  signed overflow in size checks, bounds-check .gnu_debuglink
  section.

- Fix tools lib api: null termination in filename__read_int/ull(),
  uninitialized stack data in filename__write_int(), snprintf
  truncation in mount_overload().

- Replace libbabeltrace with babeltrace2-ctf-writer for CTF
  conversion in 'perf data'.

- Add RISC-V SDT argument parsing for static tracepoints.

- Add 'perf trace --show-cpu' option to display CPU id.

- Add 'perf bench sched pipe --write-size' option.

- Add a perf-specific .clang-format that overrides some kernel
  style behaviors.

- Update Intel vendor events for Alder Lake, Arrow Lake, Clearwater
  Forest, Emerald Rapids, Granite Rapids, Grand Ridge, Lunar Lake,
  Meteor Lake, Panther Lake, Sapphire Rapids, Sierra Forest.

- Add IOMMU metrics for AMD and Intel.

- Fix AMD event: switch l2_itlb_misses to
  bp_l1_tlb_miss_l2_tlb_miss.all.

- Add AMD IBS improvements: decode Streaming-store and
  Remote-Socket flags, suppress bogus fields on Zen4+, skip
  privilege test on Zen6+.

- Fix 'perf lock contention' SIGCHLD vs pause() race, allow
  'mmap_lock' in -L filter, enable end-timestamp for cgroup
  aggregation, fix non-atomic data updates.

- Fix 'perf stat' false NMI watchdog warning in aggregation modes,
  bounds-check CPU index in topology callbacks, add aggr_nr metric
  parser support for uncore scaling.

- Fix 'perf timechart' memory leaks, CPU bounds checking,
  use-after-free on corrupted callchains.

- Fix 'perf inject' itrace branch stack synthesis, fix synthesized
  sample size with branch stacks.

- Fix DSO heap overflow on decompressed paths, uninitialized
  pathname on fallback, set proper error codes.

- Fix various snprintf/scnprintf usages to prevent buffer overflows
  and truncation across the codebase.

- Fix off-by-one stack buffer overflow in kallsyms__parse().

- Fix 'perf kwork' memory management, address sanitizer issues,
  bounds check work->cpu.

- Fix 'perf tpebs' concurrent stop races and PID reuse hazards.

- Add O_CLOEXEC to open() calls and use mkostemp() for temporary
  files to prevent file descriptor leaks to child processes.

- Fix s390 Python extension TEXTREL by compiling as PIC.

- Fix build with ASAN for jitdump.

- Fix build failure due to btf_vlen() return type change.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Aaron Tomlin (2):
      perf trace: Introduce --show-cpu option to display cpu id
      perf trace: Fix noise and signed formatting of __probe_ip in bare dynamic probes

Andi Kleen (1):
      perf stat: Make metric only column line up with header

Arnaldo Carvalho de Melo (123):
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf tests hwmon_pmu: Use PRIu64 + (uint64_t) cast for a __u64 field to work more widely
      perf session: Add minimum event size and alignment validation
      perf session: Bounds-check one_mmap event pointer in peek_event
      perf tools: Fix event_contains() macro to verify full field extent
      perf zstd: Fix compression error path in zstd_compress_stream_to_records()
      perf zstd: Fix multi-iteration decompression and error handling
      perf session: Fix PERF_RECORD_READ swap and dump for variable-length events
      perf session: Fix swap_sample_id_all() crash on crafted events
      perf session: Add validated swap infrastructure with null-termination checks
      perf session: Use bounded copy for PERF_RECORD_TIME_CONV
      perf session: Validate HEADER_ATTR attr.size before swapping
      perf session: Validate nr fields against event size on both swap and common paths
      perf header: Byte-swap build ID event pid and bounds check section entries
      perf cpumap: Reject RANGE_CPUS with start_cpu > end_cpu
      perf auxtrace: Harden auxtrace_error event handling
      perf session: Add byte-swap and bounds check for PERF_RECORD_BPF_METADATA events
      perf header: Validate null-termination in PERF_RECORD_EVENT_UPDATE string fields
      perf tools: Bounds check perf_event_attr fields against attr.size before printing
      perf header: Propagate feature section processing errors
      perf header: Validate f_attr.ids section before use in perf_session__read_header()
      perf header: Validate feature section size and add read path bounds checking
      perf header: Sanity check HEADER_EVENT_DESC attr.size before swap
      perf header: Validate bitmap size before allocating in do_read_bitmap()
      perf session: Add byte-swap handler for PERF_RECORD_COMPRESSED2
      perf tools: Harden compressed event processing
      perf session: Check for decompression buffer size overflow
      perf session: Bound nr_cpus_avail and validate sample CPU
      perf kwork: Bounds check work->cpu before indexing cpus_runtime[]
      perf session: Snapshot event->header.size in process_user_event()
      perf test: Add truncated perf.data robustness test
      perf sample: Add file_offset field to struct perf_sample
      perf session: Include file offset in event skip/stop messages
      perf sched: Include file offset in event skip messages
      perf timechart: Include file offset in CPU bounds check messages
      perf tools: Include file offset and event type name in skip messages
      perf timechart: Fix cat_backtrace() use-after-free on corrupted callchain
      perf sched: Replace BUG_ON on invalid CPU with graceful skip
      perf test: Add file offset diagnostic test for corrupted perf.data
      perf tools: Guard test_bit from out-of-bounds sample CPU
      perf sched: Fix thread reference leak in latency_switch_event
      perf sched: Fix NULL dereference in latency_runtime_event
      perf sched: Fix comp_cpus heap overflow with cross-machine recordings
      perf tools: Guard remaining test_bit calls from OOB sample CPU
      perf tools: Add bounds check to cpu__get_node()
      perf sched: Fix thread reference leaks in timehist_get_thread()
      perf sched: Cap max_cpu at MAX_CPUS in timehist sample processing
      perf sched: Fix register_pid() overflow, strcpy, and BUG_ON
      perf mmap: Guard cpu__get_node() return in aio_bind()
      perf stat: Bounds-check CPU index in topology aggregation callbacks
      perf c2c: Bounds-check CPU and node IDs before bitmap and array access
      perf c2c: Bounds-check CPU IDs in setup_nodes() topology loop
      perf sched: Clean up idle_threads entry on init failure
      perf sched: Use is_idle_sample() for idle thread runtime cast guard
      perf sched: Fix thread reference leak in idle hist processing
      perf sched: Use thread__put() in free_idle_threads()
      perf sched: Replace BUG_ON and add NULL checks in replay event helpers
      perf mmap: Fix NULL deref in aio cleanup on alloc failure
      perf stat: Introduce perf_env__get_cpu_topology() to guard NULL env->cpu
      perf c2c: Fix use-after-free in he__get_c2c_hists() error path
      perf timechart: Fix cpu2y() OOB read on untrusted CPU index
      perf tools: Fix int16_t truncation of max_cpu_num in set_max_cpu_num()
      perf sched: Free callchain nodes in idle thread cleanup
      libperf: Document struct perf_cpu int16_t ABI limitation
      perf tools: Fix get_max_num() size_t underflow on empty sysfs file
      perf tools: Use scnprintf() in cpu_map__snprint() to prevent overflow
      perf tools: Use perf_env__get_cpu_topology() in machine__resolve()
      perf tools: NULL bitmap pointers after bitmap_free()
      perf sched: Bounds-check prio before test_bit() in timehist
      perf sched: Fix idle-hist callchain display using wrong rb_first variant
      perf tools: Add O_CLOEXEC to open() calls in DSO and ELF code
      perf bpf: Use scnprintf() in snprintf_hex() and synthesize_bpf_prog_name()
      perf hists: Fix snprintf() in hists__scnprintf_title() UID filter path
      perf tools: Use scnprintf() in build_id__snprintf() and hwmon read_events()
      libperf: Document code simplification case for widening struct perf_cpu
      perf pmu: Fix pmu_id() heap underwrite on empty identifier file
      perf pmu: Fix perf_pmu__parse_scale/unit() OOB access on empty sysfs file
      tools lib api: Fix missing null termination in filename__read_int/ull()
      perf symbols: Fix signed overflow in sysfs__read_build_id() size check
      perf symbols: Bounds-check .gnu_debuglink section data
      perf tools: Use mkostemp() for O_CLOEXEC on temporary files
      perf intel-pt: Fix snprintf size tracking bug in insn decoder
      perf tools: Fix thread__set_comm_from_proc() on empty comm file
      perf hwmon: Fix off-by-one null termination on sysfs reads
      perf hwmon: Use scnprintf() in hwmon_pmu__for_each_event()
      perf hwmon: Fix parse_hwmon_filename() strlcpy buffer overflow
      perf symbols: Bounds-check descsz in sysfs__read_build_id() GNU fallback
      perf tools: Fix uninitialized pathname on uncompressed fallback in filename__decompress()
      perf hwmon: Guard label read against empty or failed reads
      perf tools: Use snprintf() in dso__read_running_kernel_build_id()
      tools lib api: Fix filename__write_int() writing uninitialized stack data
      tools lib api: Fix mount_overload() snprintf truncation and toupper range
      perf bpf: Add NULL check for btf__type_by_id() in synthesize_bpf_prog_name()
      perf bpf: Fix map data leak in bpf_metadata_create() on alloc failure
      perf bpf: Fix metadata leak in perf_env__add_bpf_info() on duplicate insert
      perf symbols: Add bounds checks to elf_read_build_id() note iteration
      perf symbols: Add bounds checks to read_build_id() note iteration in minimal build
      perf symbols: Fix bswap copy-paste error for 32-bit ELF p_filesz
      perf symbols: Validate p_filesz before use in filename__read_build_id()
      perf symbols: Break infinite loop on zero-filled notes in sysfs__read_build_id()
      perf dso: Fix heap overflow in dso__get_filename() on decompressed path
      perf dso: Set error code when open() fails on uncompressed fallback path
      perf tools: Use snprintf() for root_dir path construction
      perf hwmon: Fix fd check to accept fd 0 in hwmon_pmu__describe_items()
      perf sched: Replace (void*)1 sentinel with proper runtime allocation
      perf bpf: Validate func_info_rec_size and sub_id in synthesize_bpf_prog_name()
      perf bpf: Reject oversized BPF metadata events that truncate header.size
      perf bpf: Bounds-check array offsets in bpil_offs_to_addr()
      perf c2c: Free format list entries when releasing c2c hist entries
      perf cs-etm: Reject CPU IDs that would overflow signed comparison
      perf evsel: Add no-libtraceevent stubs for evsel__field() and evsel__common_field()
      perf evsel: Add lazy-initialized probe type detection helpers
      perf trace: Guard __probe_ip suppression with evsel__is_probe()
      perf machine: Propagate machine__init() error to callers
      perf machine: Use snprintf() for guestmount path construction
      perf cs-etm: Validate num_cpu before metadata allocation
      perf cs-etm: Require full global header in auxtrace_info size check
      perf cs-etm: Bounds-check CPU in cs_etm__get_queue()
      perf c2c: Free format list entries when c2c_hists__init() fails
      perf c2c: Fix hist entry and format list leaks in c2c_he_free()
      perf bpf: Validate array presence before casting BPF prog info pointers
      perf dso: Set standard errno on decompression failure

Athira Rajeev (4):
      powerpc tools perf: Initialize error code in auxtrace_record_init function
      perf auxtrace: Add kernel-doc comment to auxtrace_record__init() function
      perf tools: Fix the check for parameterized field in event term
      perf pmu: Use scnprintf in buffer offset calculations

Breno Leitao (1):
      perf bench: Add --write-size option to sched pipe

Chen Pei (1):
      perf riscv: Add SDT argument parsing for RISC-V

Chun-Tse Shao (5):
      perf jevents: Add IOMMU metrics for AMD
      perf jevents: Add IOMMU metrics for Intel
      perf stat: Add aggr_nr metric parser support
      perf stat: Use aggr_nr scaling for Intel uncore miss latency metrics
      perf stat: Fix false NMI watchdog warning in aggregation modes

Dapeng Mi (1):
      perf script: Fix missing '+' indicator when branch counter reaches upper limit

Florian Fainelli (1):
      perf trace beauty fcntl: Fix build with older kernel headers

Ian Rogers (137):
      perf dwarf-aux: Fix libdw segmentation fault in cu_walk_functions_at
      perf dwarf-aux: Fix libdw API contract violations
      perf srcline: Introduce inline_node__clear_frames()
      perf libdw: Fix callchain parent update in ORDER_CALLER mode
      perf libdw: Support DWARF line 0 in inline list
      perf libdw: Fix libdw API contract violations and memory leaks
      perf probe-finder: Fix libdw API contract violations
      perf annotate-data: Fix libdw API contract violations
      perf debuginfo: Fix libdw API contract violations
      perf sched stats: Fix segmentation faults, memory leaks, and stale pointers in diff mode
      perf sched: Add missing mmap2 handler in timehist
      perf tool: Fix missing schedstat delegates and dont_split_sample_group in delegate_tool
      perf record: Refactor ARM64 leaf caller setup out of arch
      perf pmu-events AMD: Switch l2_itlb_misses to bp_l1_tlb_miss_l2_tlb_miss.all
      perf metricgroup: Avoid scanning unnecessary PMUs for identifier match
      perf unwind: Refactor get_entries to allow dynamic libdw/libunwind selection
      tools build: Deduplicate test-libunwind for different architectures
      perf build: Be more programmatic when setting up libunwind variables
      perf unwind-libunwind: Make libunwind register reading cross platform
      perf unwind-libunwind: Move flush/finish access out of local
      perf unwind-libunwind: Remove libunwind-local
      perf unwind-libunwind: Add RISC-V libunwind support
      perf clang-format: Add a perf clang-format that overrides some kernel behaviors
      perf event: Fix size of synthesized sample with branch stacks
      perf inject: Fix itrace branch stack synthesis
      perf tool: Remove evsel from tool APIs that pass the sample
      perf kvm: Don't pass evsel with sample
      perf evsel: Refactor evsel tracepoint sample accessors perf_sample
      perf trace: Don't pass evsel with sample
      perf callchain: Don't pass evsel and sample
      perf lock: Only pass sample to handlers
      perf hist: Remove evsel parameter from inc samples functions
      perf db-export: Remove evsel from struct export_sample
      perf hist: Remove evsel from struct hist_entry_iter
      perf report: Directly use sample->evsel to avoid computing from sample->id
      perf annotate: Don't pass evsel to add_sample
      perf inject: Don't pass evsel with sample
      perf kmem: Don't pass evsel with sample
      perf kwork: Don't pass evsel with sample
      perf sched: Don't pass evsel with sample
      perf timechart: Don't pass evsel with sample
      perf trace: Don't pass evsel with sample
      perf evlist: Try to avoid computing evsel from sample
      perf script: Don't pass evsel with sample
      perf s390-sample-raw: Don't pass evsel or its PMU with sample
      perf evsel: Don't pass evsel with sample
      perf lock: Constify trace_lock_handler variables
      perf lock: Avoid segv if event is missing a callchain
      perf timechart: Fix memory leaks
      perf kmem: Fix memory leaks on error path and when skipping
      perf synthetic-events: Bound check when synthesizing mmap2 and build_id events
      perf kmem: Add bounds checks to tracepoint read values
      perf sched: Bounds check CPU in sched switch events
      perf timechart: Bounds check CPU
      perf evsel: Add bounds checking to trace point raw data accessors
      perf trace beauty: Make beauty generated C code standalone .o files
      perf build: Decouple pmu-events from prepare umbrella target
      perf build: Remove empty archheaders target
      perf build: Move BPF skeleton generation out of Makefile.perf
      perf build: Encapsulate vmlinux.h and bpftool in bpf_skel.mak
      perf build: Pre-generate BPF skeleton tooling during umbrella prepare phase
      perf build: Move libsymbol dependency out of prepare step
      perf build: Remove redundant libbpf feature check for static builds
      perf pmu-events: Split big_c_string storage into standalone compilation unit
      perf pmu-events: Convert recursive shell assignments and macros to Make built-ins
      perf build: Convert llvm-config shell queries to simply expanded variables
      perf tests: Add test for uncore event sorting
      perf arch x86 tests: Add test for topdown event sorting
      perf build: Prefix SCRIPTS with output directory to fix continuous rebuilds
      perf build: Fix fsmount.o build
      perf build: Unconditionally set up libunwind feature build flags
      perf kwork: Fix address sanitizer issues
      perf kwork: Fix memory management of kwork_work
      perf tool_pmu: Make tool PMU events respect enable/disable
      perf tests: Add test for stat delay option with duration_time
      perf stat: Propagate supported flag to follower cgroup BPF events
      perf test: Add stat metrics --for-each-cgroup test
      perf arch arm: Sort includes and add missed explicit dependencies
      perf arch x86: Sort includes and add missed explicit dependencies
      perf tests: Sort includes and add missed explicit dependencies
      perf script: Sort includes and add missed explicit dependencies
      perf vendor events intel: Update alderlake events from 1.37 to 1.39
      perf vendor events intel: Update alderlaken events from 1.37 to 1.39
      perf vendor events intel: Update arrowlake events from 1.16 to 1.17
      perf vendor events intel: Update clearwaterforest events and metrics from 1.00 to 1.02
      perf vendor events intel: Update emeraldrapids events from 1.21 to 1.23
      perf vendor events intel: Update grandridge events from 1.11 to 1.12
      perf vendor events intel: Update graniterapids events from 1.17 to 1.18
      perf vendor events intel: Update lunarlake events from 1.21 to 1.22
      perf vendor events intel: Update meteorlake events from 1.20 to 1.21
      perf vendor events intel: Update pantherlake events from 1.04 to 1.05
      perf vendor events intel: Update sapphirerapids events from 1.36 to 1.39
      perf vendor events intel: Update sierraforest events from 1.15 to 1.17
      perf env: Add perf_env__e_machine helper and use in perf_env__arch
      perf tests topology: Switch env->arch use to env->e_machine
      perf env, dso, thread: Add _endian variants for e_machine helpers
      perf capstone: Determine architecture from e_machine
      perf print_insn: Use e_machine for fallback IP length check
      perf symbol: Avoid use of machine__is
      perf machine: Use perf_env e_machine rather than arch
      perf sample-raw: Use perf_env e_machine rather than arch
      perf sort: Use perf_env e_machine rather than arch
      perf arch common: Use perf_env e_machine rather than arch
      perf header: In print_pmu_caps use perf_env e_machine
      perf c2c: Use perf_env e_machine rather than arch
      perf lock-contention: Use perf_env e_machine rather than arch
      perf env: Refactor perf_env__arch_strerrno
      perf env: Remove unused perf_env__raw_arch
      perf env: Add mutex to protect lazy environment initialization
      perf env: Add helper to lazily compute the os_release
      perf symbol: Add setters for bitfields sharing a byte to avoid concurrent update issues
      perf symbol: Lazily compute idle
      tools build: Fix feature checks to touch target files on success
      perf tools: Ensure event leader stays at head of evlist after sorting
      perf tpebs: Fix concurrent stop races and PID reuse hazards in tpebs_stop
      perf jevents.py: Make generated C code more kernel style
      perf pmu-events: Add API to get metric table name and iterate tables
      perf test: Drain pipe after child finishes to avoid losing output
      perf test: Support dynamic test suites with setup callback and private data
      perf test pmu-events: A sub-test per metric table
      tools subcmd: Robust fallback and existence checks for process reaping
      perf test: Refactor parallel poll loop to drain all pipes simultaneously
      perf test: Show snippet failure output for verbose=1
      perf test: Add summary reporting
      perf test: Fix subtest status alignment for multi-digit indexes
      perf test: Skip shebang and SPDX comments in shell test descriptions
      perf test: Split monolithic 'util' test suite into sub-tests
      perf test: Add -j/--junit option for JUnit XML test reports
      perf test: Add shell test to validate JUnit XML reporting output
      perf test: Remove /usr/bin/cc dependency from Intel PT shell test
      perf pmu: Recognize 'default_core' as a core PMU and document matching
      perf test: Truncate printed test descriptions dynamically to avoid terminal wrapping
      perf maps: Add maps__mutate_mapping
      perf inject/aslr: Add ASLR tool infrastructure and MMAP tracking
      perf inject/aslr: Implement sample address remapping
      perf aslr: Strip sample registers
      perf test: Add inject ASLR test

James Clark (29):
      perf arm_spe: Make a function to get the MIDR
      perf arm_spe: Handle missing CPU IDs
      perf arm_spe: Store MIDR in arm_spe_pkt
      perf arm_spe: Turn event name mappings into an array
      perf arm_spe: Decode Arm N1 IMPDEF events
      perf arm_spe: Print remaining IMPDEF event numbers
      perf test: Make leafloop workload immune to compiler options
      perf arm-spe: Don't warn about the discard bit if it doesn't exist
      perf annotate: Fix crashes on empty annotate windows
      perf cs-etm: Queue context packets for frontend
      perf test: Add workload-ctl option
      perf test: Add a workload that forces context switches
      perf test cs-etm: Test process attribution
      perf test: Add deterministic workload
      perf test cs-etm: Replace unroll loop thread with deterministic decode test
      perf test cs-etm: Remove asm_pure_loop test
      perf test cs-etm: Replace memcpy test with raw dump stress test
      perf test: Add named_threads workload
      perf test cs-etm: Test decoding for concurrent threads test
      perf test cs-etm: Remove duplicate branch tests
      perf test cs-etm: Skip if not root
      perf test cs-etm: Reduce snapshot size
      perf test cs-etm: Speed up basic test
      perf test cs-etm: Remove unused Coresight workloads
      perf test cs-etm: Make disassembly test use kcore
      perf test cs-etm: Add all branch instructions to test
      perf test cs-etm: Speed up disassembly test
      perf test cs-etm: Move existing tests to coresight folder
      perf test: Compile named_threads workload with -O0

Jens Remus (3):
      perf build: Respect V=1 for Python extension builds
      perf build: Do not duplicate CFLAGS in Python extension builds
      perf s390: Fix TEXTREL in Python extension by compiling as PIC

Leo Yan (1):
      perf pmu: Skip test on Arm64 when #slots is zero

Li Guan (1):
      perf riscv: Fix discarded const qualifier in _get_field()

Mark Brown (1):
      perf bpf: Fix up build failure due to change of btf_vlen() return type

Martin Kaiser (5):
      perf test: Fix nanosleep check in the ftrace test
      perf test: Fix sys_enter_openat event test for musl
      perf test: Fix "trace summary" test for musl-based systems
      perf dwarf: Avoid redefinition warnings for REG_DWARFNUM_NAME
      perf riscv: fix register name strings

Michael Jeanson (1):
      perf data ctf: replace libbabeltrace with babeltrace2-ctf-writer

Michael Petlan (1):
      perf build-id: Fix off-by-one bug when printing kernel/module build-id

Miguel Martín Gil (1):
      perf util: Fix perf_exe() buffer write past end

Namhyung Kim (5):
      perf build: Update error message for BUILD_NONDISTRO=1
      perf build: Add -fms-extensions for GEN_VMLINUX_H=1
      perf build: Remove NO_GTK2 build test
      perf lock contention: Allow 'mmap_lock' in -L/--lock-filter
      perf jitdump: Fix a build error with ASAN

Ravi Bangoria (8):
      perf test amd ibs: Fix incorrect kernel version check
      perf tool ibs: Sync AMD IBS header file
      perf test ibs: Skip privilege test on Zen6 and newer platforms
      perf amd ibs: Suppress bogus TlbRefillLat and DCPhysAd on Zen4+
      perf amd ibs: Make Fetch status bits dependent on PhyAddrValid for newer platforms
      perf amd ibs: Decode Remote-Socket flag in IBS OP raw dump
      perf amd ibs: Decode Streaming-store flag in IBS OP raw dump
      perf doc: Document new IBS capabilities in man page

Rui Qi (3):
      perf: Extract is_ignored_kernel_symbol() for kernel mapping symbol filtering
      perf: Apply is_ignored_kernel_symbol() filter in ELF loading path for kernel DSOs
      perf: Fix off-by-one stack buffer overflow in kallsyms__parse()

Suchit Karunakaran (3):
      perf lock: Fix non-atomic max/time and min_time updates in contention_data
      perf build: Compile BPF skeletons with -mcpu=v3
      perf lock contention: Enable end-timestamp accounting for cgroup aggregation

Swapnil Sapkal (3):
      perf sched stats: Fix SIGCHLD vs pause() race in schedstat_record()
      perf sched stats: Fix SIGCHLD vs pause() race in schedstat_live()
      perf lock contention: Fix SIGCHLD vs pause() race in __cmd_contention()

Tanushree Shah (1):
      perf data convert json: Fix addr_location leak on time-filtered samples

Thomas Falcon (2):
      perf annotate: Fix missing branch counter column in TUI mode
      perf tools: Document recent additions to the perf.data file header

Thomas Richter (1):
      perf callchain: Handle multiple address spaces

 Documentation/trace/coresight/coresight-perf.rst   |   78 +-
 MAINTAINERS                                        |    2 -
 tools/arch/x86/include/asm/amd/ibs.h               |    4 +-
 tools/build/Makefile.feature                       |   17 +-
 tools/build/feature/Makefile                       |   59 +-
 tools/build/feature/test-all.c                     |    6 +-
 ...bbabeltrace.c => test-babeltrace2-ctf-writer.c} |    3 +-
 tools/build/feature/test-libunwind-aarch64.c       |   27 -
 tools/build/feature/test-libunwind-arm.c           |   28 -
 .../feature/test-libunwind-debug-frame-aarch64.c   |   17 -
 .../build/feature/test-libunwind-debug-frame-arm.c |   17 -
 tools/build/feature/test-libunwind-debug-frame.c   |    1 -
 tools/build/feature/test-libunwind-x86.c           |   28 -
 tools/build/feature/test-libunwind-x86_64.c        |   28 -
 tools/build/feature/test-libunwind.c               |    1 -
 tools/lib/api/fs/fs.c                              |   19 +-
 tools/lib/perf/TODO                                |   30 +
 tools/lib/perf/include/perf/cpumap.h               |    8 +-
 tools/lib/perf/include/perf/event.h                |    9 +-
 tools/lib/subcmd/run-command.c                     |   69 +-
 tools/lib/symbol/kallsyms.c                        |    5 +-
 tools/perf/.clang-format                           |   20 +
 tools/perf/.gitignore                              |    1 +
 tools/perf/Build                                   |    2 +
 tools/perf/Documentation/perf-amd-ibs.txt          |   39 +
 tools/perf/Documentation/perf-test.txt             |   24 +-
 tools/perf/Documentation/perf-trace.txt            |    3 +
 tools/perf/Documentation/perf.data-file-format.txt |   16 +-
 tools/perf/Makefile.config                         |  266 +-
 tools/perf/Makefile.perf                           |  455 +-
 tools/perf/arch/arm/util/Build                     |    2 -
 tools/perf/arch/arm/util/cs-etm.c                  |   26 +-
 tools/perf/arch/arm/util/unwind-libunwind.c        |   50 -
 tools/perf/arch/arm64/util/Build                   |    2 -
 tools/perf/arch/arm64/util/arm-spe.c               |    3 +-
 tools/perf/arch/arm64/util/machine.c               |   12 -
 tools/perf/arch/arm64/util/unwind-libunwind.c      |   17 -
 tools/perf/arch/common.c                           |   92 +-
 tools/perf/arch/loongarch/util/Build               |    2 -
 tools/perf/arch/loongarch/util/unwind-libunwind.c  |   82 -
 tools/perf/arch/mips/Build                         |    1 -
 tools/perf/arch/mips/util/Build                    |    1 -
 tools/perf/arch/mips/util/unwind-libunwind.c       |   22 -
 tools/perf/arch/powerpc/include/dwarf-regs-table.h |    1 +
 tools/perf/arch/powerpc/util/Build                 |    1 -
 tools/perf/arch/powerpc/util/auxtrace.c            |    6 +
 tools/perf/arch/powerpc/util/unwind-libunwind.c    |   92 -
 tools/perf/arch/riscv/include/dwarf-regs-table.h   |    3 +-
 tools/perf/arch/riscv/util/header.c                |    2 +-
 tools/perf/arch/s390/include/dwarf-regs-table.h    |    1 +
 tools/perf/arch/x86/tests/amd-ibs-period.c         |    2 +-
 tools/perf/arch/x86/tests/topdown.c                |  166 +-
 tools/perf/arch/x86/util/Build                     |    3 -
 tools/perf/arch/x86/util/intel-bts.c               |   20 +-
 tools/perf/arch/x86/util/intel-pt.c                |   29 +-
 tools/perf/arch/x86/util/unwind-libunwind.c        |  115 -
 tools/perf/bench/Build                             |    6 +
 .../{util => bench}/bpf_skel/bench_uprobe.bpf.c    |    0
 tools/perf/bench/inject-buildid.c                  |    9 +-
 tools/perf/bench/sched-pipe.c                      |  129 +-
 tools/perf/bench/uprobe.c                          |    2 +-
 tools/perf/bpf_skel.mak                            |  109 +
 tools/perf/builtin-annotate.c                      |   45 +-
 tools/perf/builtin-buildid-list.c                  |    4 +-
 tools/perf/builtin-c2c.c                           |   79 +-
 tools/perf/builtin-check.c                         |    2 +-
 tools/perf/builtin-data.c                          |   18 +-
 tools/perf/builtin-diff.c                          |   16 +-
 tools/perf/builtin-inject.c                        |  335 +-
 tools/perf/builtin-kmem.c                          |  101 +-
 tools/perf/builtin-kvm.c                           |   31 +-
 tools/perf/builtin-kwork.c                         |  300 +-
 tools/perf/builtin-lock.c                          |  146 +-
 tools/perf/builtin-mem.c                           |    1 -
 tools/perf/builtin-record.c                        |   22 +-
 tools/perf/builtin-report.c                        |   56 +-
 tools/perf/builtin-sched.c                         |  585 +-
 tools/perf/builtin-script.c                        |  157 +-
 tools/perf/builtin-stat.c                          |   50 +-
 tools/perf/builtin-timechart.c                     |  209 +-
 tools/perf/builtin-top.c                           |   26 +-
 tools/perf/builtin-trace.c                         |  238 +-
 tools/perf/pmu-events/Build                        |   26 +-
 tools/perf/pmu-events/amd_metrics.py               |   59 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |   85 +
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   64 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   54 +
 .../arch/x86/alderlake/virtual-memory.json         |    9 +
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |   50 +
 .../pmu-events/arch/x86/alderlaken/memory.json     |   57 +
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   48 +
 .../arch/x86/alderlaken/virtual-memory.json        |    8 +
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |   53 +
 .../arch/x86/arrowlake/floating-point.json         |    9 +
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |   48 +-
 .../arch/x86/clearwaterforest/cache.json           |  525 +-
 .../arch/x86/clearwaterforest/counter.json         |   79 +-
 .../arch/x86/clearwaterforest/cwf-metrics.json     |  310 +
 .../arch/x86/clearwaterforest/floating-point.json  |  191 +
 .../arch/x86/clearwaterforest/frontend.json        |  226 +
 .../arch/x86/clearwaterforest/memory.json          |   92 +
 .../arch/x86/clearwaterforest/other.json           |   20 +
 .../arch/x86/clearwaterforest/pipeline.json        |  829 +-
 .../arch/x86/clearwaterforest/uncore-cache.json    | 3413 ++++++++
 .../arch/x86/clearwaterforest/uncore-cxl.json      |   31 +
 .../x86/clearwaterforest/uncore-interconnect.json  | 1625 ++++
 .../arch/x86/clearwaterforest/uncore-io.json       | 1925 +++++
 .../arch/x86/clearwaterforest/uncore-memory.json   |  883 ++
 .../arch/x86/clearwaterforest/uncore-power.json    |  109 +
 .../arch/x86/clearwaterforest/virtual-memory.json  |   94 +
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |   18 +
 .../perf/pmu-events/arch/x86/grandridge/cache.json |   56 +
 .../arch/x86/grandridge/floating-point.json        |    8 +
 .../pmu-events/arch/x86/grandridge/frontend.json   |   64 +
 .../pmu-events/arch/x86/grandridge/pipeline.json   |   15 +
 .../pmu-events/arch/x86/grandridge/uncore-io.json  |   15 +-
 .../arch/x86/grandridge/uncore-memory.json         |   32 +-
 .../pmu-events/arch/x86/graniterapids/cache.json   |    9 +
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |   20 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |    9 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   24 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   55 +
 .../arch/x86/meteorlake/floating-point.json        |   63 +
 .../pmu-events/arch/x86/meteorlake/memory.json     |   64 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  158 +
 .../arch/x86/meteorlake/virtual-memory.json        |    9 +
 .../pmu-events/arch/x86/pantherlake/cache.json     |  152 +-
 .../pmu-events/arch/x86/pantherlake/frontend.json  |   60 +
 .../pmu-events/arch/x86/pantherlake/memory.json    |   29 +
 .../pmu-events/arch/x86/pantherlake/other.json     |   10 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  |  231 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |   27 +
 .../pmu-events/arch/x86/sierraforest/cache.json    |   49 +
 .../arch/x86/sierraforest/floating-point.json      |   64 +
 .../pmu-events/arch/x86/sierraforest/memory.json   |   57 +
 .../pmu-events/arch/x86/sierraforest/pipeline.json |  156 +
 .../arch/x86/sierraforest/virtual-memory.json      |    8 +
 tools/perf/pmu-events/empty-pmu-events.c           | 8821 +++++++++++++-------
 tools/perf/pmu-events/intel_metrics.py             |   68 +-
 tools/perf/pmu-events/jevents.py                   |  870 +-
 tools/perf/pmu-events/metric.py                    |   10 +-
 tools/perf/pmu-events/pmu-events.h                 |    5 +
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |   20 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |  979 ++-
 tools/perf/tests/code-reading.c                    |    7 +-
 tools/perf/tests/dlfilter-test.c                   |    8 +-
 tools/perf/tests/hists_cumulate.c                  |    6 +-
 tools/perf/tests/hists_filter.c                    |    6 +-
 tools/perf/tests/hists_link.c                      |    5 +-
 tools/perf/tests/hists_output.c                    |    6 +-
 tools/perf/tests/hwmon_pmu.c                       |   19 +-
 tools/perf/tests/kallsyms-split.c                  |    7 +-
 tools/perf/tests/make                              |   10 +-
 tools/perf/tests/mmap-basic.c                      |   22 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    7 +-
 tools/perf/tests/parse-no-sample-id-all.c          |    6 +
 tools/perf/tests/pmu-events.c                      |  180 +-
 tools/perf/tests/pmu.c                             |   11 +-
 tools/perf/tests/sample-parsing.c                  |    5 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh           |   37 +-
 tools/perf/tests/shell/coresight/Makefile          |   29 -
 .../perf/tests/shell/coresight/Makefile.miniconfig |   14 -
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |   22 -
 .../tests/shell/coresight/asm_pure_loop/.gitignore |    1 -
 .../tests/shell/coresight/asm_pure_loop/Makefile   |   34 -
 .../shell/coresight/asm_pure_loop/asm_pure_loop.S  |   30 -
 .../tests/shell/coresight/concurrent_threads.sh    |   45 +
 .../tests/shell/coresight/context_switch_thread.sh |   69 +
 tools/perf/tests/shell/coresight/deterministic.sh  |   72 +
 .../tests/shell/coresight/memcpy_thread/.gitignore |    1 -
 .../tests/shell/coresight/memcpy_thread/Makefile   |   33 -
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |   80 -
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |   22 -
 .../perf/tests/shell/coresight/raw_dump_stress.sh  |   65 +
 .../shell/{ => coresight}/test_arm_coresight.sh    |   43 +-
 .../{ => coresight}/test_arm_coresight_disasm.sh   |   23 +-
 .../tests/shell/coresight/thread_loop/.gitignore   |    1 -
 .../tests/shell/coresight/thread_loop/Makefile     |   33 -
 .../shell/coresight/thread_loop/thread_loop.c      |   85 -
 .../shell/coresight/thread_loop_check_tid_10.sh    |   23 -
 .../shell/coresight/thread_loop_check_tid_2.sh     |   23 -
 .../shell/coresight/unroll_loop_thread/.gitignore  |    1 -
 .../shell/coresight/unroll_loop_thread/Makefile    |   33 -
 .../unroll_loop_thread/unroll_loop_thread.c        |   75 -
 .../tests/shell/coresight/unroll_loop_thread_10.sh |   22 -
 .../tests/shell/data_file_offset_diagnostics.sh    |   91 +
 tools/perf/tests/shell/data_validation.sh          |   86 +
 tools/perf/tests/shell/ftrace.sh                   |    7 +-
 tools/perf/tests/shell/inject_aslr.sh              |  533 ++
 tools/perf/tests/shell/lib/coresight.sh            |  134 -
 tools/perf/tests/shell/lock_contention.sh          |   11 +
 tools/perf/tests/shell/stat.sh                     |   53 +
 tools/perf/tests/shell/stat_metrics_cgrp.sh        |  200 +
 tools/perf/tests/shell/test_intel_pt.sh            |  169 +-
 .../tests/shell/test_perf_data_converter_ctf.sh    |    8 +-
 tools/perf/tests/shell/test_test_junit_output.sh   |   63 +
 tools/perf/tests/shell/trace_summary.sh            |    2 +-
 tools/perf/tests/switch-tracking.c                 |    9 +-
 tools/perf/tests/symbols.c                         |    2 +-
 tools/perf/tests/tests-scripts.c                   |   82 +-
 tools/perf/tests/tests.h                           |    7 +
 tools/perf/tests/thread-maps-share.c               |    2 +-
 tools/perf/tests/topology.c                        |    8 +-
 tools/perf/tests/uncore-event-sorting.c            |  176 +
 tools/perf/tests/util.c                            |   20 +-
 tools/perf/tests/vmlinux-kallsyms.c                |   10 +-
 tools/perf/tests/workloads/Build                   |    6 +
 tools/perf/tests/workloads/context_switch_loop.c   |  110 +
 tools/perf/tests/workloads/deterministic.c         |   39 +
 tools/perf/tests/workloads/jitdump.c               |  210 +
 tools/perf/tests/workloads/leafloop.c              |   40 +-
 tools/perf/tests/workloads/named_threads.c         |  109 +
 tools/perf/trace/beauty/Build                      |  284 +
 tools/perf/trace/beauty/arch_errno_names.c         |    2 +
 tools/perf/trace/beauty/arch_errno_names.sh        |   53 +-
 tools/perf/trace/beauty/beauty.h                   |   60 +
 tools/perf/trace/beauty/eventfd.c                  |    6 +-
 tools/perf/trace/beauty/fcntl.c                    |   16 +
 tools/perf/trace/beauty/fsconfig.c                 |    5 +
 tools/perf/trace/beauty/futex_op.c                 |    5 +-
 tools/perf/trace/beauty/futex_val3.c               |    5 +-
 tools/perf/trace/beauty/mmap.c                     |   24 +-
 tools/perf/trace/beauty/mode_t.c                   |    6 +-
 tools/perf/trace/beauty/msg_flags.c                |    8 +-
 tools/perf/trace/beauty/open_flags.c               |    2 +
 tools/perf/trace/beauty/perf_event_open.c          |   42 +-
 tools/perf/trace/beauty/pid.c                      |    5 +-
 tools/perf/trace/beauty/sched_policy.c             |    8 +-
 tools/perf/trace/beauty/seccomp.c                  |   12 +-
 tools/perf/trace/beauty/signum.c                   |    6 +-
 tools/perf/trace/beauty/socket_type.c              |    6 +-
 tools/perf/{util => trace/beauty}/syscalltbl.c     |    0
 tools/perf/{util => trace/beauty}/syscalltbl.h     |    0
 tools/perf/trace/beauty/tracepoints/Build          |   21 +
 tools/perf/trace/beauty/waitid_options.c           |    8 +-
 tools/perf/ui/browser.c                            |    3 +
 tools/perf/ui/browsers/annotate.c                  |    7 +-
 tools/perf/ui/browsers/map.c                       |    4 +-
 tools/perf/util/Build                              |   25 +-
 tools/perf/util/amd-sample-raw.c                   |   87 +-
 tools/perf/util/annotate-data.c                    |   27 +-
 tools/perf/util/annotate.c                         |   24 +-
 tools/perf/util/annotate.h                         |    6 +-
 tools/perf/util/arm-spe-decoder/Build              |    2 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   17 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |    3 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |  144 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |    5 +-
 tools/perf/util/arm-spe.c                          |   92 +-
 .../perf/util/arm64-frame-pointer-unwind-support.c |    6 +
 .../perf/util/arm64-frame-pointer-unwind-support.h |    2 +
 tools/perf/util/aslr.c                             | 1409 ++++
 tools/perf/util/aslr.h                             |   44 +
 tools/perf/util/auxtrace.c                         |   48 +-
 tools/perf/util/bpf-event.c                        |   52 +-
 tools/perf/util/bpf-event.h                        |    4 +-
 tools/perf/util/bpf-trace-summary.c                |    2 +-
 tools/perf/util/bpf-utils.c                        |   16 +
 tools/perf/util/bpf_counter_cgroup.c               |   20 +
 tools/perf/util/bpf_kwork.c                        |   14 +-
 tools/perf/util/bpf_lock_contention.c              |   13 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   79 +-
 tools/perf/util/bpf_skel/lock_data.h               |    1 +
 tools/perf/util/btf.c                              |    2 +-
 tools/perf/util/build-id.c                         |   15 +-
 tools/perf/util/build-id.h                         |    7 +-
 tools/perf/util/callchain.c                        |   27 +-
 tools/perf/util/callchain.h                        |    9 +-
 tools/perf/util/capstone.c                         |  132 +-
 tools/perf/util/config.c                           |    4 +
 tools/perf/util/cpumap.c                           |  111 +-
 tools/perf/util/cs-etm-base.c                      |    4 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   21 +-
 tools/perf/util/cs-etm.c                           |  312 +-
 tools/perf/util/cs-etm.h                           |    8 +-
 tools/perf/util/data-convert-bt.c                  |   37 +-
 tools/perf/util/data-convert-json.c                |   12 +-
 tools/perf/util/data-convert.h                     |    4 +-
 tools/perf/util/db-export.c                        |   13 +-
 tools/perf/util/db-export.h                        |    3 +-
 tools/perf/util/debuginfo.c                        |    9 +-
 tools/perf/util/disasm.c                           |    7 +-
 tools/perf/util/dlfilter.c                         |    2 +-
 tools/perf/util/dso.c                              |   67 +-
 tools/perf/util/dso.h                              |   14 +-
 tools/perf/util/dwarf-aux.c                        |   39 +-
 tools/perf/util/dwarf-aux.h                        |    5 +
 tools/perf/util/env.c                              |  378 +-
 tools/perf/util/env.h                              |   27 +-
 tools/perf/util/event.c                            |   15 +-
 tools/perf/util/evlist.c                           |   10 +-
 tools/perf/util/evsel.c                            |  399 +-
 tools/perf/util/evsel.h                            |   57 +-
 tools/perf/util/evsel_fprintf.c                    |    6 +-
 tools/perf/util/expr.c                             |   26 +-
 tools/perf/util/expr.h                             |    6 +-
 tools/perf/util/expr.l                             |    1 +
 tools/perf/util/expr.y                             |   24 +-
 tools/perf/util/header.c                           |  683 +-
 tools/perf/util/hist.c                             |   35 +-
 tools/perf/util/hist.h                             |    4 +-
 tools/perf/util/hwmon_pmu.c                        |   36 +-
 tools/perf/util/intel-bts.c                        |    3 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |   11 +-
 tools/perf/util/intel-pt.c                         |   39 +-
 tools/perf/util/intel-tpebs.c                      |   95 +-
 tools/perf/util/jitdump.c                          |    6 +-
 tools/perf/util/jitdump.h                          |    3 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-arm64.c     |   19 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-loongarch.c |   17 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-powerpc.c   |   17 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-riscv.c     |   17 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-s390.c      |   20 +-
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c       |   70 +-
 tools/perf/util/kvm-stat.c                         |   19 +-
 tools/perf/util/kvm-stat.h                         |   18 +-
 tools/perf/util/kwork.h                            |   19 +-
 tools/perf/util/libdw.c                            |   72 +-
 tools/perf/util/libunwind-arch/Build               |   11 +
 tools/perf/util/libunwind-arch/libunwind-arch.c    |  319 +
 tools/perf/util/libunwind-arch/libunwind-arch.h    |  296 +
 tools/perf/util/libunwind-arch/libunwind-arm.c     |  290 +
 tools/perf/util/libunwind-arch/libunwind-arm64.c   |  289 +
 tools/perf/util/libunwind-arch/libunwind-i386.c    |  312 +
 .../perf/util/libunwind-arch/libunwind-loongarch.c |  297 +
 tools/perf/util/libunwind-arch/libunwind-mips.c    |  299 +
 tools/perf/util/libunwind-arch/libunwind-ppc32.c   |  303 +
 tools/perf/util/libunwind-arch/libunwind-ppc64.c   |  303 +
 tools/perf/util/libunwind-arch/libunwind-riscv.c   |  297 +
 tools/perf/util/libunwind-arch/libunwind-s390.c    |  299 +
 tools/perf/util/libunwind-arch/libunwind-x86_64.c  |  320 +
 tools/perf/util/libunwind/arm64.c                  |   40 -
 tools/perf/util/libunwind/x86_32.c                 |   41 -
 tools/perf/util/lock-contention.c                  |    6 +-
 tools/perf/util/machine.c                          |  135 +-
 tools/perf/util/machine.h                          |    7 +-
 tools/perf/util/maps.c                             |  182 +-
 tools/perf/util/maps.h                             |    7 +-
 tools/perf/util/metricgroup.c                      |   14 +-
 tools/perf/util/mmap.c                             |   20 +-
 tools/perf/util/parse-events.c                     |   27 +
 tools/perf/util/perf-regs-arch/perf_regs_riscv.c   |  128 +
 tools/perf/util/perf_event_attr_fprintf.c          |  141 +-
 tools/perf/util/perf_regs.c                        |    3 +
 tools/perf/util/perf_regs.h                        |    1 +
 tools/perf/util/pmu.c                              |   71 +-
 tools/perf/util/pmus.c                             |   18 +-
 tools/perf/util/pmus.h                             |    1 +
 tools/perf/util/print_insn.c                       |   23 +-
 tools/perf/util/print_insn.h                       |    7 +-
 tools/perf/util/probe-event.c                      |    4 +-
 tools/perf/util/probe-finder.c                     |  102 +-
 tools/perf/util/s390-sample-raw.c                  |   31 +-
 tools/perf/util/sample-raw.c                       |   21 +-
 tools/perf/util/sample-raw.h                       |    6 +-
 tools/perf/util/sample.h                           |    2 +
 .../perf/util/scripting-engines/trace-event-perl.c |   25 +-
 .../util/scripting-engines/trace-event-python.c    |   79 +-
 tools/perf/util/session.c                          | 1441 +++-
 tools/perf/util/session.h                          |    2 +
 tools/perf/util/setup.py                           |   13 +-
 tools/perf/util/sort.c                             |   66 +-
 tools/perf/util/srcline.c                          |   19 +-
 tools/perf/util/srcline.h                          |    1 +
 tools/perf/util/stat-display.c                     |   26 +-
 tools/perf/util/stat-shadow.c                      |    6 +-
 tools/perf/util/svghelper.c                        |   10 +-
 tools/perf/util/symbol-elf.c                       |  136 +-
 tools/perf/util/symbol-minimal.c                   |   16 +-
 tools/perf/util/symbol.c                           |  261 +-
 tools/perf/util/symbol.h                           |   95 +-
 tools/perf/util/symbol_conf.h                      |   10 +
 tools/perf/util/symbol_fprintf.c                   |    4 +-
 tools/perf/util/synthetic-events.c                 |   99 +-
 tools/perf/util/synthetic-events.h                 |    8 +-
 tools/perf/util/thread.c                           |   95 +-
 tools/perf/util/thread.h                           |   23 +-
 tools/perf/util/tool.c                             |   61 +-
 tools/perf/util/tool.h                             |    4 +-
 tools/perf/util/tool_pmu.c                         |  250 +-
 tools/perf/util/tool_pmu.h                         |    4 +
 tools/perf/util/trace-event-scripting.c            |    5 +-
 tools/perf/util/trace-event.h                      |    3 -
 tools/perf/util/tsc.c                              |    2 +-
 tools/perf/util/unwind-libdw.c                     |   20 +-
 tools/perf/util/unwind-libunwind-local.c           |  831 --
 tools/perf/util/unwind-libunwind.c                 |  699 +-
 tools/perf/util/unwind.c                           |  104 +
 tools/perf/util/unwind.h                           |   73 +-
 tools/perf/util/util.c                             |   12 +-
 tools/perf/util/zstd.c                             |   47 +-
 392 files changed, 36587 insertions(+), 9669 deletions(-)
 rename tools/build/feature/{test-libbabeltrace.c => test-babeltrace2-ctf-writer.c} (59%)
 delete mode 100644 tools/build/feature/test-libunwind-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-aarch64.c
 delete mode 100644 tools/build/feature/test-libunwind-debug-frame-arm.c
 delete mode 100644 tools/build/feature/test-libunwind-x86.c
 delete mode 100644 tools/build/feature/test-libunwind-x86_64.c
 create mode 100644 tools/lib/perf/TODO
 create mode 100644 tools/perf/.clang-format
 delete mode 100644 tools/perf/arch/arm/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/arm64/util/machine.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/mips/Build
 delete mode 100644 tools/perf/arch/mips/util/Build
 delete mode 100644 tools/perf/arch/mips/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libunwind.c
 rename tools/perf/{util => bench}/bpf_skel/bench_uprobe.bpf.c (100%)
 create mode 100644 tools/perf/bpf_skel.mak
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/cwf-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/clearwaterforest/uncore-power.json
 delete mode 100644 tools/perf/tests/shell/coresight/Makefile
 delete mode 100644 tools/perf/tests/shell/coresight/Makefile.miniconfig
 delete mode 100755 tools/perf/tests/shell/coresight/asm_pure_loop.sh
 delete mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/.gitignore
 delete mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/Makefile
 delete mode 100644 tools/perf/tests/shell/coresight/asm_pure_loop/asm_pure_loop.S
 create mode 100755 tools/perf/tests/shell/coresight/concurrent_threads.sh
 create mode 100755 tools/perf/tests/shell/coresight/context_switch_thread.sh
 create mode 100755 tools/perf/tests/shell/coresight/deterministic.sh
 delete mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/.gitignore
 delete mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/Makefile
 delete mode 100644 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
 delete mode 100755 tools/perf/tests/shell/coresight/memcpy_thread_16k_10.sh
 create mode 100755 tools/perf/tests/shell/coresight/raw_dump_stress.sh
 rename tools/perf/tests/shell/{ => coresight}/test_arm_coresight.sh (83%)
 rename tools/perf/tests/shell/{ => coresight}/test_arm_coresight_disasm.sh (65%)
 delete mode 100644 tools/perf/tests/shell/coresight/thread_loop/.gitignore
 delete mode 100644 tools/perf/tests/shell/coresight/thread_loop/Makefile
 delete mode 100644 tools/perf/tests/shell/coresight/thread_loop/thread_loop.c
 delete mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_10.sh
 delete mode 100755 tools/perf/tests/shell/coresight/thread_loop_check_tid_2.sh
 delete mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/.gitignore
 delete mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/Makefile
 delete mode 100644 tools/perf/tests/shell/coresight/unroll_loop_thread/unroll_loop_thread.c
 delete mode 100755 tools/perf/tests/shell/coresight/unroll_loop_thread_10.sh
 create mode 100755 tools/perf/tests/shell/data_file_offset_diagnostics.sh
 create mode 100755 tools/perf/tests/shell/data_validation.sh
 create mode 100755 tools/perf/tests/shell/inject_aslr.sh
 delete mode 100644 tools/perf/tests/shell/lib/coresight.sh
 create mode 100755 tools/perf/tests/shell/stat_metrics_cgrp.sh
 create mode 100755 tools/perf/tests/shell/test_test_junit_output.sh
 create mode 100644 tools/perf/tests/uncore-event-sorting.c
 create mode 100644 tools/perf/tests/workloads/context_switch_loop.c
 create mode 100644 tools/perf/tests/workloads/deterministic.c
 create mode 100644 tools/perf/tests/workloads/jitdump.c
 create mode 100644 tools/perf/tests/workloads/named_threads.c
 create mode 100644 tools/perf/trace/beauty/fsconfig.c
 rename tools/perf/{util => trace/beauty}/syscalltbl.c (100%)
 rename tools/perf/{util => trace/beauty}/syscalltbl.h (100%)
 create mode 100644 tools/perf/util/aslr.c
 create mode 100644 tools/perf/util/aslr.h
 create mode 100644 tools/perf/util/libunwind-arch/Build
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arch.h
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-arm64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-i386.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-loongarch.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-mips.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc32.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-ppc64.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-riscv.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-s390.c
 create mode 100644 tools/perf/util/libunwind-arch/libunwind-x86_64.c
 delete mode 100644 tools/perf/util/libunwind/arm64.c
 delete mode 100644 tools/perf/util/libunwind/x86_32.c
 delete mode 100644 tools/perf/util/unwind-libunwind-local.c
 create mode 100644 tools/perf/util/unwind.c
