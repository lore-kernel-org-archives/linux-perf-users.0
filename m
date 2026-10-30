Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397977;
	b=zbGK5Z7ZK8czVEuEPPeVnD9ZvpddBQTY1cUj2eAOjy/k/AhuP3sH3brBsxPmfZCddJPE
	 vFtdplsre1xIHVe/tWWDxuQbN+psLPdC8HOWAEEeT0yx0pb/Pacy3ONBff2NUhQADn0Nl
	 FZEi6I8ZjEZ/MbTh+gyxR/qyhCAIRlEo7xjQ9WhlnrgXKzvqqkJUtahzg8vi+0Z5HsC2d
	 ZltNKEMWHnfysekF/448VF7RNkbv5XWOVKipt4/0d5/IA4SHBdgUH1xPDHQYBty9C7Qz6
	 q9UBrbWSlmiEtroq9KwK5mi6L5umXeWJNleSYXs9RVtTtQFov5q0lIqjPzHNI30N0VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397977;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3N/9xU2P3a2P9WsBFLKvNe/mLFWl7DQOGazmMSO+3CI=;
	b=2UnRicL4A1CF/ocOU1vzFVLTsFZhWK5odKSpUkT34Ak1+jLzyQBprp+r8WinkdHiojJe
	 ZVY7xPKkTpLUSiQhMh4lS+XnozaUT+dHg+kljhvUjPr7y1y5Bg5kOoGHq2y6WEtNmAiqb
	 4JtePkpMxL6C2/dNxs/77q7+9JQXhW4Ji1HDL7xCVjpFUSsEXyMNotw4wzg91cI3XzFKO
	 4zq+yE1QB5au1GYD6GviBY9hi5Rm5wHRLFeF8ce9KlLgCRbuKbd//mqBKFGM7GjdjYwIf
	 GAaSpz4q+OvgmK1gX3IVBV+y5sdLiUYQ15xivcRTDlN0pAm7Od2HjF1jzqyZinCkxtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRPJfAQF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA56E606A31C;
	Fri, 30 Oct 2026 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FRPJfAQF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A09C1F00A18;
	Fri, 30 Oct 2026 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397975;
	bh=3N/9xU2P3a2P9WsBFLKvNe/mLFWl7DQOGazmMSO+3CI=;
	h=From:To:Cc:Subject:Date;
	b=FRPJfAQFN2/ih1R16Nyz5/zPUbw1UCB/LZYJlvusZbHo5AZph6NSbbwJ8zKyK0Ia4
	 Pfc1gd0Uq1xDJn6cjqqQfTI6R+NFhMSmB0qaD7UZnALBPravUP/NiQr1UWkcUV3ErC
	 oi84MSEykko2nAycEzYM0WThmNjmTZUIlO1KHBjXIyxjvksvXz515sGWE1vCZ+1u4g
	 8Wp7HUbCaD/tBKdaGg3sZvyopEW30K4kpO8T0uJksAA7MxrJ8O5PW9WS5VQj6Jyps1
	 SfXUbhOo86hWJKXe7DuPXzowV0WoPCcwXnxv1Gg7xoKb6AM0Y2zTt4Sjx+VWe67DaK
	 jWUX5o/hOMXyg==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Alice Rogers <alice.mei.rogers@gmail.com>,
	Andi Kleen <ak@linux.intel.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	liujing <liujing@cmss.chinamobile.com>,
	Mark Amirkan <markdamirkan@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Nylon Chen <nylon.chen@sifive.com>,
	Qerogram <qerogram@naver.com>,
	sashiko-bot <sashiko-bot@kernel.org>,
	Tengda Wu <wutengda@huaweicloud.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Triet Hoang <triet.hoang.dev@gmail.com>,
	Wang Yan <wangyan01@kylinos.cn>,
	Zide Chen <zide.chen@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL update] perf tools changes for v7.4
Date: Fri, 30 Oct 2026 19:06:03 -0300
Message-ID: <20261030220603.27617-1-acme@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling, updating machines, sorry about previous
message without the needed urls...

Best regards,

- Arnaldo

The following changes since commit f47d223627f80cb7a1eb14c585fe6cb35de5e984:

  Merge tag 'vfs-7.4-rc1.sync_close' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2026-10-19 21:03:21 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tags/perf-tools-for-v7.4-1-2026-10-30

for you to fetch changes up to 4626d370ae89b8af4d46a45372b269f926ec662d:

  perf machine: Fix NULL deref in thread__resolve_callchain_sample() (2026-10-27 17:45:34 -0300)

----------------------------------------------------------------
perf tools changes for v7.4

- Support instruction tracking on arm64 for data type profiling, resolving
  stack, global, per-CPU and 'current' variable accesses, so that 'perf
  annotate --data-type' resolves types on arm64 the way it does on x86.

- Port the Python scripts to the perf module and standalone execution, and
  improve the module: lazy sample callchains and event copies, GIL
  handling, better session/thread lookup, new treport, flamegraph and
  sqlite/postgres exporters.

- Reenable and fix the attribute expectation test suite: per-PMU bit
  masks, other core PMUs' events, dummy tracking events, group checks
  and spelled out skip reasons.

- perf trace: filter the target's tasks in BPF, open the BPF output event
  on every CPU, add an option to disable syscall augmentation and raise
  TRACE_AUG_MAX_BUF.

- perf jitdump: harden record parsing, validating unwinding sizes and
  symbol names, byte-swapping debug entries via safe accessors and fixing
  frees on error paths.

- perf annotate-data fixes: bound the member nesting recursion, resolve
  type DIEs in the debug file they came from, adjust the offset for
  flex-arrays and show the sample count in the data-type browser.

- perf symbol and debug info: try linked debug files for DSOs, avoid
  repeated failing searches, set binary/symtab types for split kallsyms,
  JIT maps and the build-id cache, fix libbfd symbol loading.

- perf config: serialize config file access with a mutex, add the
  DEFINE_MUTEX() and DO_ONCE() primitives and a robust process shared
  mutex, add the core.hybrid-merge option.

- perf report: add --progress and --no-progress options.

- perf mem: add a false sharing workload to 'perf test', request
  PERF_SAMPLE_CPU by default, use the IBS swfilt filter when available
  and decode L0 in the memory level.

- perf test: take turns using the perf mlock budget in the mmaping tests,
  add the 'needs_mlock' suite flag, scope the probe based tests to their
  PID and make more tests non-exclusive.

- perf vendor events intel: update events and metrics to TMA 5.2, refresh
  the event tables and fix umask encodings.

- perf build: run shellcheck, mypy and pylint in parallel, make pylint
  opt-out with NO_PYLINT=1, fix clean and install dependencies.

- Add a script and a 'make sync-headers' target to sync the tools/ copies
  of kernel headers with the kernel sources, plus the resulting syncs of
  the cpufeatures, KVM, fs, mount, fcntl, socket, rtnetlink, if_addr and
  sound headers.

- Fix cs-etm HW_ID mapping synthesis for raw trace, queue teardown leaks
  and duplicate v0 global mappings.

- Add a 'perf bench atomic' benchmark for atomic operations.

- Filter events before creating lock_stat in 'perf lock contention'.

- Add a 'perf test' case for events re-armed with PERF_EVENT_IOC_REFRESH.

- Fix memory leaks on 'perf c2c' output fields and add function view
  stdio coverage to its test.

- Fix a NULL dereference resolving callchains in 'perf machine'.

- Optimize the libdw fallback when DWARF is missing and try the symbol
  file first when checking for debuginfo.

- Don't call eprintf() in pr_debugN() when not verbose.

- Don't delete cumulative caller entries before the stat_acc decays in
  'perf report'.

- Fix ring buffer cursor handling: keep the consumed cursor in forward
  mode and use the head selected by read_init.

- Fix 'perf test mmap-basic' user rdpmc detection and only test userspace
  reading on supported platforms.

- Build fixes: include sys/types.h for ssize_t, errno.h before kernel
  headers and fix jevents.py type annotations for mypy 2.x.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Aaron Tomlin (6):
      perf trace: Fix error checking in btf_struct_scnprintf()
      perf trace: Introduce kernel symbol beautifier for virtual addresses
      perf trace: Auto-assign kernel symbol beautifier to function pointer fields
      perf trace: Enhance BTF type formatting to symbolise kernel function pointers
      perf tests: Add shell test for kernel symbol beautifier
      perf trace: Add upper bound checks for augmented BTF struct printing

Adrian Hunter (1):
      perf test waiting.sh: Replace timestamp polling with sleep

Alice Rogers (6):
      perf python: New treport script
      perf python: Add flamegraph support to treport
      perf treport: Show the profile while it loads
      perf test: Add a test for the treport script
      perf timechart: Add an interactive --tui mode
      perf test: Add a test for perf timechart --tui

Alireza Haghdoost (1):
      perf symbols: Don't let a module's last symbol overlap the next module

Andi Kleen (4):
      perf tools record: Modernize -W man page
      perf tools top: Add --weight option
      perf tools: Add support for displaying weights in annotate
      perf tools: Add test for weight annotation

Arnaldo Carvalho de Melo (73):
      perf jitdump: Fix extended header read that always fails
      perf jitdump: Fix debug_data and unwinding_data leaks
      perf jitdump: Validate code_size against total_size in code load
      perf jitdump: Prevent integer underflow in debug info size calculation
      perf jitdump: Bounds-check debug entry byte-swap loop
      perf jitdump: Check snprintf return before computing header size
      perf jitdump: Fix funlockfile on unlocked stream in jit_open() error path
      perf jitdump: Free event in jit_repipe_code_move()
      perf jitdump: Use dirname() return value in jit_open()
      perf jitdump: Validate debug entries on native (non-swap) path
      perf jitdump: Validate sym string NUL-termination in code load
      perf jitdump: Validate unwinding sizes against record payload
      perf jitdump: Byte-swap debug entries via unaligned-safe accessors
      perf genelf: Use unaligned-safe accessors for debug entries
      perf jitdump: Free unwinding data even when eh_frame_hdr_size is zero
      perf jitdump: Write sample id fields in the order used by evsel__id_hdr_size()
      perf jitdump: Size code_move event allocation with idr_size
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      tools build: Add zstd to the binutils library feature tests
      perf test: Skip data_type_profiling when the PMU cannot record memory events
      perf annotate-data: Show the sample count in the data-type browser
      perf test workload: Use unsigned int in code_with_type instead of uint
      perf dwarf-aux: Bound the type chases for broken debug info
      perf dwarf-aux: Add die_same_file() and die_get_type_die()
      perf annotate-data: Resolve type DIEs in the debug file they came from
      perf annotate-data: Bound the member nesting recursion
      perf mem record: Request PERF_SAMPLE_CPU by default
      perf mem record: Use the IBS swfilt filter when available
      perf tools: Bump the minimum Python version to 3.9
      perf timechart: Remove the unused use_old_power_events variable
      tools feature gettid: Undef _GNU_SOURCE before defining it
      perf config: Move perf_config__set_variable() to util/config.c
      perf config: Make perf_etc_perfconfig() never return NULL
      perf mutex: Add DEFINE_MUTEX() static initializer
      perf mutex: Add DO_ONCE() for one-time initialization
      perf config: Serialize config file access with a mutex
      perf report: Add --progress option
      perf report: Add --no-progress option
      perf test: Add false_sharing workload exhibiting cross-CPU false sharing
      perf test attr: Source setup_python.sh instead of calling python
      perf test attr: Fix record dwarf sample_type expectation
      perf python: Free the parse error entries when parsing fails
      perf test attr: Allow tests to require a core PMU
      perf test attr: Fix legacy event encodings in group tests
      perf test attr: Fix default stat metrics expectations
      perf test attr: Relax group checking for ungrouped expectations
      perf evsel: Mark the event as supported when retrying an open
      perf test attr: Ignore the core PMU type perf puts in 'config'
      perf evsel: Don't dump probe events to PERF_TEST_ATTR
      perf evsel: Close the fds opened so far when disabling missing features
      perf test attr: Introduce mask_bits(), generalizing hide_core_pmu_type()
      perf test attr: Accept either sample id bit perf asks for
      perf test attr: Ignore the dummy tracking event and the terms it carries
      perf test attr: Leave out the events of the other core PMUs
      perf test attr: Ignore the group read_format bit the PMU count can remove
      perf test attr: State, spelled out in a line, why a test is skipped
      perf tests: Introduce a 'needs_mlock' suite flag
      perf tests: Mark the C tests mapping perf ring buffers
      perf tests: Mark the shell tests not mapping perf ring buffers
      perf mutex: Add a robust, process-shared mutex initializer
      perf test: Take turns using the perf mlock budget in the mmaping tests
      perf kvm: Cast tv_usec to long to fix build on MIPS 32-bits
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf tools: Add script and make target to sync the header copies with the kernel
      tools headers UAPI: Sync linux/if_addr.h with the kernel sources
      tools headers UAPI: Sync linux/rtnetlink.h with the kernel sources
      tools arch x86: Sync the cpufeatures.h copy with the kernel sources
      tools headers: Sync linux/socket.h with the kernel sources
      tools headers: Sync UAPI linux/fcntl.h with the kernel sources
      tools headers: Sync UAPI linux/fs.h with the kernel sources
      tools headers: Sync UAPI linux/mount.h with the kernel sources
      tools headers: Sync UAPI sound/asound.h with the kernel sources
      tools headers: Sync KVM headers with the kernel sources

Ben Hutchings (2):
      perf tools: Put Python egg info in output directory
      perf tools: Put Python bytecode in output directory

Benoît Monin (1):
      perf build: Improve fix for "argument list too long" error

Changbin Du (1):
      perf bench: Add atomic operations benchmark

Chen Pei (2):
      perf test: Fix a leaked map reference in the arch dwarf unwind tests
      perf riscv: Add perf_regs_load and enable the dwarf unwind test

Christian Melendez (1):
      perf stat: Document task-clock/cpu-clock in TIMINGS

Chun-Tse Shao (3):
      perf pmu intel: Generalize SNC cpumask adjustment for multiple platforms
      perf pmu intel: Adjust cpumasks for sub-NUMA clusters on Sapphire Rapids and Emerald Rapids
      perf evsel: Find process with busy PMUs for EBUSY

Dapeng Mi (16):
      perf dwarf-regs: Fix DWARF register index bounds check
      perf util: Add missed fields in _attr__fprintf() and __attr_swap()
      tools headers: Sync x86 headers with kernel sources
      perf headers: Sync perf_event.h/perf_regs.h with the kernel headers
      perf regs: Support x86 eGPRs/SSP sampling
      perf regs: Support x86 SIMD registers sampling
      perf regs: Enable dumping of SIMD registers
      perf dwarf-regs: Add SIMD/eGPRs support for x86 DWARF registers
      perf tests: Add x86 eGPRs/SSP registers sampling test
      perf tests: Add SIMD registers sampling test
      perf aslr: Add missing SIMD handling in aslr_tool__process_sample()
      perf util: Explicitly include required headers
      perf mem: Add support for printing PERF_MEM_LVLNUM_L0
      perf tools: Show memory region in perf-c2c subcommand
      perf tools: Show memory region in perf-script subcommand
      perf jevents: Rename OMR offcore_rsp attribute to offmodule_rsp

Ethan Nelson-Moore (1):
      perf tools: Remove unused empty help-unknown-cmd.h header

Florian Fainelli (2):
      perf print_insn: Include sys/types.h for ssize_t
      perf parse-events: Include errno.h before kernel headers

Francesco Nigro (1):
      perf test: Add test for events re-armed with PERF_EVENT_IOC_REFRESH

Hemanth Selam (2):
      perf synthetic-events: Fix repeated word in log message
      perf tools: Fix typos in comments

Hui Su (3):
      perf evsel: Restrict incremental open error unwind
      perf synthetic-events: Fix schedstat event lifetime handling
      perf synthetic-events: Check schedstat domain allocation failure

Ian Rogers (178):
      perf tool: Remove util/cache.h
      perf tool: Tidy up util/cache.h header file users
      perf tool: Remove unused includes in perf.c
      perf tool: Move usage strings and functions to perf.c
      perf tool: Add fallback stubs for missing dependencies
      perf hist: Remove keysym.h include from hist.h
      perf test: Avoid call to missing cleanup function
      perf stat: Avoid uninitialized memory read on error
      perf tests: Improvements to build-test performance
      perf tool: Align structs in arrays in .clang-format
      perf test x86: Fix missing __msan_unpoison
      tools build: Fix timerfd feature detection with clang
      perf python: Fix ilist TreeNode string type drift
      perf header: Fix HEADER_COMPRESSED validation for comp_mmap_len
      perf header: Fix potential memory corruption in cpu_cache_level__read
      perf header: Transition WARN macros to debug.h equivalents
      perf jevents: Add mesh bandwidth saturation for CWF, EMR, GRR, SNR, SPR, SRF
      perf record: Fix unhandled POLLHUP on non_perf_event descriptors
      perf libdw: Fix Dwfl discovery with split files
      perf dso: Separate libbfd and cmd addr2line caches to fix confusion
      perf libbfd: Report success when an address is found
      perf evlist: Implement evlist__can_merge_hybrid using first_wildcard_match
      perf ui hist: Add support for aggregated total_period and merging entries
      perf tools: Expose opt-in --hybrid-merge
      perf Documentation: Add tip for hybrid event merging
      perf evlist: Toggle merged_hybrid_group properly in enable/disable
      perf tools: Add TUI hints for --hybrid-merge
      perf config: Add core.hybrid-merge to configure event merging
      perf test: Expand tests for --hybrid-merge
      perf test: Isolate test suite from user .perfconfig natively
      perf libbfd: Fix the clang -Wthread-safety build failure
      perf symbol: Fix the build when demangling with libbfd
      perf libbfd: Include the headers that are used
      perf pmu: Include the headers that are used
      perf build: Only pass clang flags to CXX when CXX is clang
      perf build: Use the given CC rather than clang in clang builds
      perf build: Check the version of the compiler that is used
      perf build: Remove leftovers of removed build options
      perf test: Add build tests for clang and libbfd demangling
      perf trace: Include the headers declaring pid_t, strcmp and assert
      perf trace: Free the whole evsel_trace in evsel__put_and_free_priv
      perf evsel: Report an allocation failure as ENOMEM when setting filters
      perf test: Fix PMU metric parsing tests for unknown literals
      perf machine: Add session back pointer to fix out of bounds read
      perf trace-event: Report tracepoint format errors with NULL and errno
      perf trace-event: Reuse an already parsed tracepoint format
      perf trace-event: Free the global trace_event when a command ends
      perf trace: Free the host machine allocation
      perf thread: Free the comm read from procfs
      tools include: Add missing stdarg.h include
      perf test stat metrics cgroup: Strip possible slash from cgroup name
      perf python: Update syscall helpers and expose arch_strerrno
      perf python: Update callchain stubs and session thread lookup
      perf python: Clean up pylint warnings in ilist.py
      perf python: Clean up pylint warnings in treport.py
      perf python: Clean up pylint warnings in tracepoint.py
      perf python: Clean up pylint warnings in twatch.py
      perf python: Improve perf script -l descriptions
      perf python: Expose addr location, transaction, and context_switch
      perf python: Add Intel PT call_return and itrace capability
      perf python: Allow KeyboardInterrupt to propagate in LiveSession
      perf pmu-events: Clean up mypy and pylint issues
      perf test: Clean up mypy and pylint issues in shell test libraries
      perf build: Make mypy build test opt-out (NO_MYPY=1)
      perf build: Make pylint build test opt-out (NO_PYLINT=1)
      perf Makefile: Install standalone Python scripts during transition
      perf python: Port stat-cpi to perf module
      perf python: Port mem-phys-addr to perf module
      perf python: Port stackcollapse to perf module
      perf python: Port flamegraph to perf module
      perf python: Port gecko to perf module
      perf python: Port event_analyzing_sample to perf module
      perf python: Port syscall-counts to perf module
      perf python: Port syscall-counts-by-pid to perf module
      perf python: Port failed-syscalls-by-pid to perf module
      perf python: Port failed-syscalls from Perl to perf module
      perf python: Port sctop to perf module
      perf python: Port rw-by-file from Perl to perf module
      perf python: Port rw-by-pid from Perl to perf module
      perf python: Port rwtop from Perl to perf module
      perf python: Port futex-contention to perf module
      perf python: Port task-analyzer to perf module
      perf python: Port sched-migration and SchedGui to perf module
      perf python: Port wakeup-latency from Perl to perf module
      perf python: Port compaction-times to perf module
      perf python: Port net_dropmonitor to perf module
      perf python: Port netdev-times to perf module
      perf python: Port check-perf-trace to perf module
      perf python: Port arm-cs-trace-disasm to perf module
      perf python: Port powerpc-hcalls to perf module
      perf python: Port intel-pt-events and libxed to perf module
      perf test: Migrate Intel PT virtual LBR test to Python API
      perf python: Port export-to-sqlite to perf module
      perf python: Port export-to-postgresql to perf module
      perf python: Move and clean up exported-sql-viewer.py
      perf python: Move and clean up parallel-perf.py
      perf: Remove libpython support and legacy Python scripts
      perf Makefile: Update Python script installation path
      perf script: Support standalone scripts and remove embedded scripting
      perf Documentation: Update for standalone Python scripts
      perf test code-reading: Fix duplicate kernel maps and machine leak
      perf build: Clean libperf-gtk.so in 'make clean'
      perf vendor events intel: Update alderlake events from 1.40 to 1.41
      perf vendor events intel: Update alderlaken events from 1.40 to 1.41
      perf vendor events intel: Update arrowlake events from 1.20 to 1.21
      perf vendor events intel: Update broadwell metrics to TMA 5.2
      perf vendor events intel: Update cascadelakex metrics to TMA 5.2
      perf vendor events intel: Update emeraldrapids events from 1.24 to 1.25
      perf vendor events intel: Update graniterapids events from 1.20 to 1.21
      perf vendor events intel: Update haswell metrics to TMA 5.2
      perf vendor events intel: Update icelake events to 1.25 and TMA metrics to 5.2
      perf vendor events intel: Update icelakex events to 1.31 and TMA metrics to 5.2
      perf vendor events intel: Update ivybridge metrics to TMA 5.2
      perf vendor events intel: Update ivytown metrics to TMA 5.2
      perf vendor events intel: Update jaketown metrics to TMA 5.2
      perf vendor events intel: Update meteorlake events from 1.22 to 1.23
      perf vendor events intel: Update novalake events from 1.00 to 1.04
      perf vendor events intel: Update pantherlake events from 1.07 to 1.08
      perf vendor events intel: Update rocketlake events from 1.04 to 1.06
      perf vendor events intel: Update sandybridge metrics to TMA 5.2
      perf vendor events intel: Update sapphirerapids events from 1.39 to 1.40
      perf vendor events intel: Update skylake metrics to TMA 5.2
      perf vendor events intel: Update tigerlake events to 1.20 and TMA metrics to 5.2
      perf vendor events intel: Fix clearwaterforest umask encoding.
      perf vendor events intel: Fix lunarlake umask encoding.
      perf vendor events intel: Fix sierraforest umask encoding.
      perf vendor events intel: Fix skylakex umask encoding.
      perf vendor events intel: Fix snowridgex umask encoding.
      perf test probe_vfs_getname: Also look for the probe line in do_getname()
      perf evsel: Clamp sample_id size for ksymbol, bpf, and text_poke events
      perf python sctop: Fix offline interval printing and test flakiness
      perf python stat-cpi: Fix live mode signal races and test flakiness
      perf test: Deflake Intel PT Python shell tests under load
      perf test: Deflake failed-syscalls Python shell tests under load
      perf test: Reduce overhead and contention in Python shell tests
      perf python event_analyzing_sample: Default to in-memory SQLite database
      perf python: Initialize debug output on module load
      perf pmu: Fix race with concurrent tracepoint creation and removal in perf list
      perf trace: Set the augmented arg header in the augmenters that omit it
      perf trace: Include the augmented arg header in nanosleep's payload length
      perf trace: Don't read sample padding as an augmented argument
      perf trace: Bounds check augmented arguments before reading them
      perf trace: Bound the fixed size augmented argument beautifiers
      perf trace: Copy sockaddr arguments by their length
      perf trace: Start BPF summary before starting workload
      perf trace: Stop at internal fields when walking syscall arguments
      perf trace: Don't allocate syscall arg formats for internal fields
      perf trace: Only take augmented arguments from the BPF output event
      perf trace: Use the CPU map index for the BPF output event's fds
      perf trace: Destroy the BPF skeleton if it fails to load
      perf thread_map: Add thread_map__tgid()
      perf trace: Filter the target's tasks in BPF
      perf trace: Open the BPF output event on every CPU for task targets
      perf trace: Add an option to disable syscall augmentation
      perf test common: Only disable probes in clear_all_probes
      perf test probe_vfs_getname: Scope probe name to PID and make non-exclusive
      perf test record+probe_libc_inet_pton: Scope event to PID and make non-exclusive
      perf test trace_summary: Improve error diagnostics
      perf test trace_btf_general: Drop --max-events=1 and make non-exclusive
      perf test uprobe_from_different_cu: Scope probe name to PID
      perf test: Update attr.py to use argparse
      perf build: Run shellcheck, mypy, and remaining pylint checks in parallel
      perf build: Clear GTK4 instead of setting unused NO_GTK4 when gtk4 is missing
      perf build: Fix clean and install target dependencies
      perf trace: Only call bpf_get_current_pid_tgid() when filtering tasks
      perf trace: Increase TRACE_AUG_MAX_BUF to 128 and document beauty_map encoding
      perf session: Don't flush remaining events once processing is done
      perf python: Quietly stop processing events when a callback raises
      perf python: Lazily copy events and samples from process_events
      perf python: Lazily resolve sample callchains
      perf python: Release the GIL while processing session events
      perf list: Add a --tui option to launch ilist
      perf test: Add a test for the ilist script
      perf test: Avoid stack trace noise in verbose=1 failure snippets
      perf lock contention: Filter events before creating lock_stat
      perf libdw: Optimize fallback logic for missing DWARF
      perf debug: Avoid calling eprintf() in pr_debugN() when verbose < n
      perf hist: Do not delete cumulative caller entries before stat_acc decays

James Clark (12):
      perf buildid-list: Fix empty output for AUX data
      perf test: Remove redundant shellcheck source paths
      perf build: Follow sourced files when running shellcheck
      perf python: Fix arm-cs-trace-disasm type error
      perf python: Track linked libraries as extension dependencies
      perf timechart: Fix task row type narrowing in goto_task()
      perf treport: Fix profile builder type narrowing in progress callback
      perf cs-etm: Don't add global v0 HW_IDs to unformatted queues
      perf cs-etm: Free partially created queues
      perf cs-etm: Respect --no-itrace option
      perf tests mmap-basic: Only test userspace reading on supported platforms
      perf tests mmap-basic: Fix user rdpmc detection logic

Jens Remus (1):
      perf evsel: Improve callchain warning for s390

Jianping Liu (1):
      perf annotate: Fix NULL pointer dereference in loongarch_call__parse

Jiebin Sun (4):
      perf c2c: Fix documented default coalesce fields
      perf tests c2c: Report skip when the workload fails
      perf c2c: Add stdio support for the function view
      perf tests c2c: Add function view stdio coverage

John Garry (1):
      MAINTAINERS: Update John Garry's address for from arm64 perf tools

Lalit Maganti (1):
      perf pmu-events: Fix jevents.py type annotations for mypy 2.x

Leo Yan (6):
      perf test: Record kcore for the CoreSight callchain test
      perf arm-spe: Add Neoverse V3AE data source decoding
      perf build: Build the Python extension before pylint consumers
      perf build: Add the output Python directory to pylint's PYTHONPATH
      perf python: Avoid shadowing exception name in PostgreSQL exporter
      perf cs-etm: Synthesize missing HW_ID mappings for raw trace

Liu Jing (1):
      perf python: Fix redundant self-assignment in get_argument_count()

Mark Amirkan (2):
      perf evsel: Validate branch stack before byte swapping
      perf evsel: Validate RAW sample before byte swapping

Matt Turner (5):
      perf thread: Fix live-session detection in thread__e_machine()
      perf annotate: add Alpha instruction support
      tools: Port perf ui from GTK 2 to GTK 4
      perf tools: make the GTK4 report browser actually loadable at runtime
      perf tools gtk: Fix two hierarchy-view stack buffer overflows

Michael Petlan (2):
      perf test attr: Propagate the return value from the test to the wrapper
      perf test attr: Fix wrong size expectation for events

Michal Pluta (2):
      perf test demangle: Fail when demangling fails
      perf symbol: Don't return an unterminated Rust demangle buffer

Namhyung Kim (37):
      perf ftrace latency: Do not read trace files when BPF is used
      perf annotate-data: Convert type histogram to hashmap
      perf dwarf-aux: Add die_has_flex_array() helper
      perf annotate-data: A small cleanup in __add_member_cb()
      perf annotate-data: Allow out-of-size access for flex-array types
      perf annotate-data: Adjust type offset for flex-array
      perf test: Fix errors when deleting data in 'perf record' tests
      perf test: Fix record tests on Intel Broadwell
      perf test: Fix record tests on hybrid machines
      perf tools: Add dso->dbginfo_type field
      perf tools: Factor out dso__find_dbginfo_type()
      perf tools: Check system path when check debuginfo
      perf tools: Export dso__get_filename() with type argument
      perf tools: Add dso__put_filename()
      perf tools: Avoid repeated failing search for debuginfo
      perf tools: Looks symbol file first when check debuginfo
      perf debuginfo: Update debuginfo__new() to take DSO
      perf trace: Split unaugmented sys_exit program
      perf trace: Do not return 0 from syscall tracepoint BPF
      perf trace: Remove unused code
      perf test: Remove exclusive tag from 'perf trace' tests
      perf symbol: Fix symbol loading from libbfd
      perf symbol: Add missing symsrc__destroy() for libbfd
      perf symbol: Set dso symtab type for libbfd
      perf test: Update PE file test for other locations
      perf tools: Remove redundant dso data init
      perf tools: Check ELF section type with name
      perf tools: Try linked debug files for DSO debug info
      perf symbol: Update symtab type of vmlinux from build-id cache
      perf symbol: Set binary/symtab type for split kallsyms
      perf symbol: Get rid of machine_or_dso_e_machine()
      perf tools: Factor out dso__find_binary_type()
      perf symbol: Set binary type for JIT map DSOs
      perf symbol: Do not set binary type from symtab type
      perf annotate: Simplify symbol__disassemble() with dso binary_type
      perf test: Fix dso data tests
      perf c2c: Fix memory leaks on output fields

Nia Su (1):
      perf evlist: Don't restrict uncore events to PMU CPUs

Nylon Chen (1):
      perf bench futex: Define SYS_futex on 32-bit arches with 64-bit time_t

Paul Moses (2):
      perf mmap: Use the head selected by read_init
      perf mmap: Preserve the consumed cursor in forward mode

Qerogram (1):
      perf list: Avoid repeated strlen() when escaping JSON strings

Sandipan Das (1):
      perf jevents: Limit the number of JSON reading workers

Stian Halseth (1):
      perf unwind-libdw: Fix reading the stack of a 32-bit task

Tengda Wu (27):
      perf capstone: Symbolize address operands to match objdump on arm64
      perf llvm: Fix arm64 adrp instruction disassembly mismatch with objdump
      perf annotate-arm64: Generalize arm64_mov__parse to support more instructions
      perf annotate-arm64: Handle load and store instructions
      perf annotate: Normalize arch__dwarf_regnum() error return values
      perf annotate: Introduce extract_op_location callback for arch-specific parsing
      perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
      perf annotate: Adapt arch__dwarf_regnum() for arm64
      perf annotate-arm64: Implement extract_op_location() callback
      perf annotate: Default to --itrace=i1i for data type profiling
      perf arm-spe: Set default synthesized event period to 1
      perf llvm: Fix memory leak of args->fileloc in symbol__disassemble_llvm()
      perf annotate-data: Extract invalidate_reg_state() as a common helper
      perf annotate-arm64: Enable instruction tracking support
      perf annotate-data: Add arch_get_reg_offset helper
      perf annotate-arm64: Track return type after call instructions
      perf annotate-arm64: Support load instruction tracking
      perf annotate-arm64: Support store instruction tracking
      perf annotate-data: Expand type_state_reg imm_value to u64
      perf annotate-data: Track imm_value for stack variables
      perf annotate-x86: Delete stale stack state on store of untracked register
      perf annotate-arm64: Support stack variable tracking
      perf annotate-arm64: Support 'mov' instruction tracking
      perf annotate-arm64: Support 'add' instruction tracking
      perf annotate-arm64: Support 'adrp' instruction to track global variables
      perf annotate-arm64: Support per-cpu variable access tracking
      perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer

Thomas Falcon (3):
      perf mem: Fix size tracking for mem_lvl's in perf_script__meminfo_scnprintf()
      perf header: Support memory ranges
      perf c2c: Print memory region data with stdio output

Thomas Richter (1):
      perf test: perf stat tests fails on s390

Tianyi Chen (1):
      perf sched stats: Reject mismatched or incomplete snapshots

Tiezhu Yang (1):
      perf loongarch: Fix discarded const qualifier in _get_field()

Triet Hoang (1):
      perf unwind: Handle allocation failure in libdw__get_entries()

Wang Yan (1):
      perf powerpc-vpadtl: Fix off-by-one in auxtrace_info minimum size check

Zhan Xusheng (1):
      perf symbols: Apply the symfs flat layout to the composed filename

Zide Chen (1):
      perf topdown: Don't require config1==0 for a slots event

liujing (1):
      perf bench messaging: Fix the formatting issue when printing.

longlong yan (1):
      perf bench numa: Add NULL check after calloc()

lvyating (1):
      perf machine: Fix NULL deref in thread__resolve_callchain_sample()

nanshuaibo (1):
      perf sched: Make output_name variable static

 MAINTAINERS                                        |    2 +-
 tools/arch/arm64/include/uapi/asm/kvm.h            |    1 +
 tools/arch/powerpc/include/uapi/asm/kvm.h          |   18 +
 tools/arch/x86/include/asm/cpufeatures.h           |   15 +
 tools/arch/x86/include/asm/msr-index.h             |    7 +
 tools/arch/x86/include/uapi/asm/perf_regs.h        |   53 +
 tools/build/Makefile.feature                       |    9 +-
 tools/build/feature/Makefile                       |   46 +-
 tools/build/feature/test-all.c                     |   11 +-
 tools/build/feature/test-gettid.c                  |    1 +
 tools/build/feature/test-gtk2-infobar.c            |   12 -
 tools/build/feature/{test-gtk2.c => test-gtk4.c}   |    4 +-
 tools/build/feature/test-libdw.c                   |   10 +-
 tools/build/feature/test-libperl.c                 |   10 -
 tools/build/feature/test-libpython.c               |   10 -
 tools/build/feature/test-pthread-mutex-robust.c    |   18 +
 tools/build/feature/test-python-module.c           |   13 +
 tools/build/feature/test-timerfd.c                 |    2 +-
 tools/include/tools/dis-asm-compat.h               |    1 +
 tools/include/uapi/linux/if_addr.h                 |    1 +
 tools/include/uapi/linux/kvm.h                     |    4 +
 tools/include/uapi/linux/perf_event.h              |   49 +-
 tools/include/uapi/linux/rtnetlink.h               |   25 +
 tools/lib/api/fd/array.c                           |    4 +
 tools/lib/perf/evlist.c                            |    5 +-
 tools/lib/perf/include/internal/evsel.h            |    2 +
 tools/lib/perf/mmap.c                              |    2 +-
 tools/perf/.clang-format                           |    1 +
 tools/perf/Build                                   |   17 +-
 tools/perf/Documentation/build-docdep.perl         |    2 +-
 tools/perf/Documentation/db-export.txt             |   20 +-
 tools/perf/Documentation/perf-annotate.txt         |    3 +
 tools/perf/Documentation/perf-bench.txt            |   38 +
 tools/perf/Documentation/perf-c2c.txt              |   14 +-
 tools/perf/Documentation/perf-check.txt            |    3 +-
 tools/perf/Documentation/perf-config.txt           |   10 +
 tools/perf/Documentation/perf-list.txt             |   10 +
 tools/perf/Documentation/perf-mem.txt              |    4 +
 tools/perf/Documentation/perf-record.txt           |   27 +-
 tools/perf/Documentation/perf-report.txt           |   32 +-
 tools/perf/Documentation/perf-sched.txt            |    6 +-
 tools/perf/Documentation/perf-script-perl.txt      |  216 -
 tools/perf/Documentation/perf-script-python.txt    |  798 +--
 tools/perf/Documentation/perf-script.txt           |   82 +-
 tools/perf/Documentation/perf-stat.txt             |   12 +-
 tools/perf/Documentation/perf-test.txt             |   36 +-
 tools/perf/Documentation/perf-timechart.txt        |    8 +
 tools/perf/Documentation/perf-top.txt              |   11 +
 tools/perf/Documentation/perf-trace.txt            |    6 +
 tools/perf/Documentation/perf.data-file-format.txt |   13 +
 tools/perf/Documentation/tips.txt                  |    3 +-
 tools/perf/Makefile                                |   54 +-
 tools/perf/Makefile.config                         |  110 +-
 tools/perf/Makefile.perf                           |  200 +-
 tools/perf/arch/arm/tests/dwarf-unwind.c           |    1 +
 tools/perf/arch/arm64/tests/dwarf-unwind.c         |    1 +
 tools/perf/arch/loongarch/util/header.c            |    2 +-
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |    1 +
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    4 +-
 tools/perf/arch/riscv/Build                        |    1 +
 tools/perf/arch/riscv/include/arch-tests.h         |    9 +
 tools/perf/arch/riscv/include/perf_regs.h          |    2 +
 tools/perf/arch/riscv/tests/Build                  |    4 +
 tools/perf/arch/riscv/tests/arch-tests.c           |   10 +
 tools/perf/arch/riscv/tests/dwarf-unwind.c         |   64 +
 tools/perf/arch/riscv/tests/regs_load.S            |   58 +
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    4 +
 tools/perf/arch/x86/tests/topdown.c                |   30 +
 tools/perf/arch/x86/util/mem-events.c              |   17 +
 tools/perf/arch/x86/util/mem-events.h              |    2 +
 tools/perf/arch/x86/util/pmu.c                     |  218 +-
 tools/perf/arch/x86/util/topdown.c                 |    3 +-
 tools/perf/bench/Build                             |    1 +
 tools/perf/bench/atomic.c                          |  299 ++
 tools/perf/bench/bench.h                           |    2 +
 tools/perf/bench/futex.h                           |   11 +
 tools/perf/bench/numa.c                            |    2 +
 tools/perf/bench/sched-messaging.c                 |    4 +-
 tools/perf/builtin-annotate.c                      |   76 +-
 tools/perf/builtin-bench.c                         |    9 +
 tools/perf/builtin-buildid-list.c                  |   17 +-
 tools/perf/builtin-c2c.c                           |  245 +-
 tools/perf/builtin-check.c                         |    3 +-
 tools/perf/builtin-config.c                        |   88 +-
 tools/perf/builtin-ftrace.c                        |   28 +-
 tools/perf/builtin-help.c                          |   30 +-
 tools/perf/builtin-inject.c                        |    4 +
 tools/perf/builtin-kmem.c                          |    3 +-
 tools/perf/builtin-kvm.c                           |    3 +-
 tools/perf/builtin-list.c                          |   36 +-
 tools/perf/builtin-lock.c                          |   61 +-
 tools/perf/builtin-mem.c                           |    7 +-
 tools/perf/builtin-record.c                        |   15 +
 tools/perf/builtin-report.c                        |   52 +-
 tools/perf/builtin-sched.c                         |  196 +-
 tools/perf/builtin-script.c                        | 1122 +++--
 tools/perf/builtin-stat.c                          |    4 +-
 tools/perf/builtin-timechart.c                     |   49 +-
 tools/perf/builtin-top.c                           |   38 +-
 tools/perf/builtin-trace.c                         |  710 +--
 tools/perf/builtin.h                               |    3 +
 tools/perf/perf.c                                  |  120 +-
 tools/perf/pmu-events/Build                        |   72 +-
 tools/perf/pmu-events/amd_metrics.py               |   16 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |    4 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   13 +
 .../perf/pmu-events/arch/x86/alderlake/other.json  |   10 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |    6 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |    4 +-
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |    1 +
 .../perf/pmu-events/arch/x86/arrowlake/other.json  |   19 +
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |   10 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   51 +-
 .../arch/x86/broadwell/metricgroups.json           |    3 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |   49 +-
 .../arch/x86/broadwellde/metricgroups.json         |    3 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   63 +-
 .../arch/x86/broadwellx/metricgroups.json          |    3 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |   94 +-
 .../arch/x86/cascadelakex/metricgroups.json        |    3 +-
 .../arch/x86/cascadelakex/uncore-interconnect.json |    6 +
 .../arch/x86/clearwaterforest/pipeline.json        |    3 +-
 .../arch/x86/clearwaterforest/uncore-cache.json    |    5 +
 .../x86/clearwaterforest/uncore-interconnect.json  |    2 +
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |    2 +-
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |   35 +
 .../pmu-events/arch/x86/emeraldrapids/other.json   |    9 +
 .../arch/x86/emeraldrapids/pipeline.json           |   10 +-
 .../arch/x86/emeraldrapids/uncore-cache.json       |   42 +
 .../x86/emeraldrapids/uncore-interconnect.json     |   12 +
 .../arch/x86/emeraldrapids/uncore-io.json          |   54 +-
 .../arch/x86/emeraldrapids/uncore-memory.json      |   10 +
 .../pmu-events/arch/x86/graniterapids/other.json   |    9 +
 .../arch/x86/graniterapids/pipeline.json           |    6 +-
 .../arch/x86/graniterapids/uncore-cache.json       |   15 +
 .../x86/graniterapids/uncore-interconnect.json     |    2 +
 .../arch/x86/graniterapids/uncore-io.json          |   12 +
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   49 +-
 .../pmu-events/arch/x86/haswell/metricgroups.json  |    3 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   61 +-
 .../pmu-events/arch/x86/haswellx/metricgroups.json |    3 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   84 +-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |   24 +
 .../pmu-events/arch/x86/icelake/metricgroups.json  |    2 +-
 tools/perf/pmu-events/arch/x86/icelake/other.json  |    9 +
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |    9 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  101 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |   24 +
 .../pmu-events/arch/x86/icelakex/metricgroups.json |    2 +-
 tools/perf/pmu-events/arch/x86/icelakex/other.json |    9 +
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    7 +-
 .../pmu-events/arch/x86/icelakex/uncore-cache.json |   79 +
 .../arch/x86/icelakex/uncore-interconnect.json     |   22 +
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   51 +-
 .../arch/x86/ivybridge/metricgroups.json           |    3 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   63 +-
 .../pmu-events/arch/x86/ivytown/metricgroups.json  |    3 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   41 +-
 .../pmu-events/arch/x86/jaketown/metricgroups.json |    3 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |    3 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |    2 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   26 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   10 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |    6 +-
 tools/perf/pmu-events/arch/x86/novalake/cache.json |  500 +-
 .../arch/x86/novalake/floating-point.json          |  423 ++
 .../pmu-events/arch/x86/novalake/frontend.json     |  147 +-
 .../perf/pmu-events/arch/x86/novalake/memory.json  |   24 +
 tools/perf/pmu-events/arch/x86/novalake/other.json |  213 +
 .../pmu-events/arch/x86/novalake/pipeline.json     |  508 +-
 .../arch/x86/novalake/virtual-memory.json          |  173 +
 .../pmu-events/arch/x86/pantherlake/cache.json     |    3 +
 .../pmu-events/arch/x86/pantherlake/other.json     |   10 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  |   10 +-
 .../pmu-events/arch/x86/rocketlake/memory.json     |   24 +
 .../arch/x86/rocketlake/metricgroups.json          |    2 +-
 .../perf/pmu-events/arch/x86/rocketlake/other.json |    9 +
 .../pmu-events/arch/x86/rocketlake/pipeline.json   |    9 +-
 .../arch/x86/rocketlake/rkl-metrics.json           |   84 +-
 .../arch/x86/sandybridge/metricgroups.json         |    3 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   35 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |    2 +-
 .../pmu-events/arch/x86/sapphirerapids/memory.json |   35 +
 .../arch/x86/sapphirerapids/metricgroups.json      |    2 +-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |    9 +
 .../arch/x86/sapphirerapids/pipeline.json          |   10 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |   93 +-
 .../arch/x86/sapphirerapids/uncore-cache.json      |   42 +
 .../x86/sapphirerapids/uncore-interconnect.json    |   12 +
 .../arch/x86/sapphirerapids/uncore-io.json         |   54 +-
 .../arch/x86/sapphirerapids/uncore-memory.json     |   10 +
 .../arch/x86/sierraforest/uncore-cache.json        |    5 +
 .../arch/x86/sierraforest/uncore-interconnect.json |    2 +
 .../pmu-events/arch/x86/skylake/metricgroups.json  |    3 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |   59 +-
 .../pmu-events/arch/x86/skylakex/metricgroups.json |    3 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   94 +-
 .../arch/x86/skylakex/uncore-interconnect.json     |    6 +
 .../arch/x86/snowridgex/uncore-cache.json          |   68 +
 .../arch/x86/snowridgex/uncore-interconnect.json   |   10 +
 .../arch/x86/tigerlake/metricgroups.json           |    2 +-
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |    9 +
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |    7 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   82 +-
 tools/perf/pmu-events/intel_metrics.py             |  262 +-
 tools/perf/pmu-events/jevents.py                   |  116 +-
 tools/perf/pmu-events/make_legacy_cache.py         |   34 +-
 tools/perf/pmu-events/metric.py                    |   60 +-
 tools/perf/python/SchedGui.py                      |  246 +
 tools/perf/python/arm-cs-trace-disasm.py           |  440 ++
 tools/perf/python/check-perf-trace.py              |  223 +
 tools/perf/python/compaction-times.py              |  362 ++
 tools/perf/python/counting.py                      |    1 +
 tools/perf/python/event_analyzing_sample.py        |  317 ++
 tools/perf/python/export-to-postgresql.py          | 1328 +++++
 tools/perf/python/export-to-sqlite.py              |  946 ++++
 tools/perf/python/exported-sql-viewer.py           | 5103 ++++++++++++++++++++
 tools/perf/python/failed-syscalls-by-pid.py        |  161 +
 tools/perf/python/failed-syscalls.py               |   94 +
 tools/perf/python/flamegraph.py                    |  283 ++
 tools/perf/python/futex-contention.py              |  107 +
 tools/perf/python/gecko.py                         |  411 ++
 tools/perf/python/ilist.py                         |   86 +-
 tools/perf/python/intel-pt-events.py               |  632 +++
 tools/perf/python/libxed.py                        |  123 +
 tools/perf/python/mem-phys-addr.py                 |  136 +
 tools/perf/python/net_dropmonitor.py               |  173 +
 tools/perf/python/netdev-times.py                  |  494 ++
 tools/perf/python/parallel-perf.py                 | 1250 +++++
 tools/perf/python/perf.pyi                         |  122 +-
 tools/perf/python/perf_live.py                     |   10 +-
 tools/perf/{scripts => }/python/powerpc-hcalls.py  |  213 +-
 tools/perf/python/rw-by-file.py                    |  113 +
 tools/perf/python/rw-by-pid.py                     |  205 +
 tools/perf/python/rwtop.py                         |  256 +
 tools/perf/python/sched-migration.py               |  496 ++
 tools/perf/python/sctop.py                         |  253 +
 tools/perf/python/stackcollapse.py                 |  145 +
 tools/perf/python/stat-cpi.py                      |  231 +
 tools/perf/python/syscall-counts-by-pid.py         |  112 +
 tools/perf/python/syscall-counts.py                |   95 +
 tools/perf/python/task-analyzer.py                 |  908 ++++
 tools/perf/python/tracepoint.py                    |    5 +-
 tools/perf/python/treport.py                       |  807 ++++
 tools/perf/python/ttimechart.py                    | 1806 +++++++
 tools/perf/python/twatch.py                        |   81 +-
 tools/perf/python/wakeup-latency.py                |  103 +
 tools/perf/scripts/Build                           |   30 -
 tools/perf/scripts/install-build-deps.sh           |    8 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |    9 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.c  |  122 -
 tools/perf/scripts/perl/Perf-Trace-Util/Context.xs |   42 -
 .../perf/scripts/perl/Perf-Trace-Util/Makefile.PL  |   18 -
 tools/perf/scripts/perl/Perf-Trace-Util/README     |   59 -
 .../perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm |   55 -
 .../perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm    |  192 -
 .../perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm    |   94 -
 tools/perf/scripts/perl/Perf-Trace-Util/typemap    |    1 -
 .../perf/scripts/perl/bin/check-perf-trace-record  |    2 -
 tools/perf/scripts/perl/bin/failed-syscalls-record |    3 -
 tools/perf/scripts/perl/bin/failed-syscalls-report |   10 -
 tools/perf/scripts/perl/bin/rw-by-file-record      |    3 -
 tools/perf/scripts/perl/bin/rw-by-file-report      |   10 -
 tools/perf/scripts/perl/bin/rw-by-pid-record       |    2 -
 tools/perf/scripts/perl/bin/rw-by-pid-report       |    3 -
 tools/perf/scripts/perl/bin/rwtop-record           |    2 -
 tools/perf/scripts/perl/bin/rwtop-report           |   20 -
 tools/perf/scripts/perl/bin/wakeup-latency-record  |    6 -
 tools/perf/scripts/perl/bin/wakeup-latency-report  |    3 -
 tools/perf/scripts/perl/check-perf-trace.pl        |  106 -
 tools/perf/scripts/perl/failed-syscalls.pl         |   47 -
 tools/perf/scripts/perl/rw-by-file.pl              |  106 -
 tools/perf/scripts/perl/rw-by-pid.pl               |  184 -
 tools/perf/scripts/perl/rwtop.pl                   |  203 -
 tools/perf/scripts/perl/wakeup-latency.pl          |  107 -
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    4 -
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |  225 -
 .../python/Perf-Trace-Util/lib/Perf/Trace/Core.py  |  116 -
 .../Perf-Trace-Util/lib/Perf/Trace/EventClass.py   |   97 -
 .../Perf-Trace-Util/lib/Perf/Trace/SchedGui.py     |  184 -
 .../python/Perf-Trace-Util/lib/Perf/Trace/Util.py  |   92 -
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |  356 --
 .../scripts/python/bin/compaction-times-record     |    2 -
 .../scripts/python/bin/compaction-times-report     |    4 -
 .../python/bin/event_analyzing_sample-record       |    8 -
 .../python/bin/event_analyzing_sample-report       |    3 -
 .../scripts/python/bin/export-to-postgresql-record |    8 -
 .../scripts/python/bin/export-to-postgresql-report |   29 -
 .../scripts/python/bin/export-to-sqlite-record     |    8 -
 .../scripts/python/bin/export-to-sqlite-report     |   29 -
 .../python/bin/failed-syscalls-by-pid-record       |    3 -
 .../python/bin/failed-syscalls-by-pid-report       |   10 -
 tools/perf/scripts/python/bin/flamegraph-record    |    2 -
 tools/perf/scripts/python/bin/flamegraph-report    |    3 -
 .../scripts/python/bin/futex-contention-record     |    2 -
 .../scripts/python/bin/futex-contention-report     |    4 -
 tools/perf/scripts/python/bin/gecko-record         |    2 -
 tools/perf/scripts/python/bin/gecko-report         |    7 -
 .../perf/scripts/python/bin/intel-pt-events-record |   13 -
 .../perf/scripts/python/bin/intel-pt-events-report |    3 -
 tools/perf/scripts/python/bin/mem-phys-addr-record |   19 -
 tools/perf/scripts/python/bin/mem-phys-addr-report |    3 -
 .../perf/scripts/python/bin/net_dropmonitor-record |    2 -
 .../perf/scripts/python/bin/net_dropmonitor-report |    4 -
 tools/perf/scripts/python/bin/netdev-times-record  |    8 -
 tools/perf/scripts/python/bin/netdev-times-report  |    5 -
 .../perf/scripts/python/bin/powerpc-hcalls-record  |    2 -
 .../perf/scripts/python/bin/powerpc-hcalls-report  |    2 -
 .../perf/scripts/python/bin/sched-migration-record |    2 -
 .../perf/scripts/python/bin/sched-migration-report |    3 -
 tools/perf/scripts/python/bin/sctop-record         |    3 -
 tools/perf/scripts/python/bin/sctop-report         |   24 -
 tools/perf/scripts/python/bin/stackcollapse-record |    8 -
 tools/perf/scripts/python/bin/stackcollapse-report |    3 -
 .../python/bin/syscall-counts-by-pid-record        |    3 -
 .../python/bin/syscall-counts-by-pid-report        |   10 -
 .../perf/scripts/python/bin/syscall-counts-record  |    3 -
 .../perf/scripts/python/bin/syscall-counts-report  |   10 -
 tools/perf/scripts/python/bin/task-analyzer-record |    2 -
 tools/perf/scripts/python/bin/task-analyzer-report |    3 -
 tools/perf/scripts/python/check-perf-trace.py      |   84 -
 tools/perf/scripts/python/compaction-times.py      |  311 --
 .../perf/scripts/python/event_analyzing_sample.py  |  192 -
 tools/perf/scripts/python/export-to-postgresql.py  | 1114 -----
 tools/perf/scripts/python/export-to-sqlite.py      |  799 ---
 tools/perf/scripts/python/exported-sql-viewer.py   | 5030 -------------------
 .../perf/scripts/python/failed-syscalls-by-pid.py  |   79 -
 tools/perf/scripts/python/flamegraph.py            |  267 -
 tools/perf/scripts/python/futex-contention.py      |   57 -
 tools/perf/scripts/python/gecko.py                 |  395 --
 tools/perf/scripts/python/intel-pt-events.py       |  494 --
 tools/perf/scripts/python/libxed.py                |  107 -
 tools/perf/scripts/python/mem-phys-addr.py         |  127 -
 tools/perf/scripts/python/net_dropmonitor.py       |   78 -
 tools/perf/scripts/python/netdev-times.py          |  473 --
 tools/perf/scripts/python/parallel-perf.py         |  989 ----
 tools/perf/scripts/python/sched-migration.py       |  462 --
 tools/perf/scripts/python/sctop.py                 |   89 -
 tools/perf/scripts/python/stackcollapse.py         |  127 -
 tools/perf/scripts/python/stat-cpi.py              |   79 -
 tools/perf/scripts/python/syscall-counts-by-pid.py |   75 -
 tools/perf/scripts/python/syscall-counts.py        |   65 -
 tools/perf/scripts/python/task-analyzer.py         |  934 ----
 tools/perf/scripts/sync-headers.sh                 | 1676 +++++++
 tools/perf/tests/Build                             |   20 +-
 tools/perf/tests/backward-ring-buffer.c            |    2 +-
 tools/perf/tests/builtin-test.c                    |  330 +-
 tools/perf/tests/code-reading.c                    |   14 +-
 tools/perf/tests/demangle-java-test.c              |    1 +
 tools/perf/tests/demangle-rust-v0-test.c           |    1 +
 tools/perf/tests/dso-data.c                        |    7 +
 tools/perf/tests/event_refresh.c                   |  162 +
 tools/perf/tests/fdarray.c                         |   32 +
 tools/perf/tests/hists_cumulate.c                  |    2 +-
 tools/perf/tests/hists_filter.c                    |    2 +-
 tools/perf/tests/hists_link.c                      |    2 +-
 tools/perf/tests/hists_output.c                    |    2 +-
 tools/perf/tests/hybrid-merge.c                    |  206 +
 tools/perf/tests/keep-tracking.c                   |    2 +-
 tools/perf/tests/make                              |  114 +-
 tools/perf/tests/mmap-basic.c                      |  189 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    1 +
 tools/perf/tests/pe-file-parsing.c                 |   22 +-
 tools/perf/tests/perf-record.c                     |    1 +
 tools/perf/tests/perf-time-to-tsc.c                |    1 +
 tools/perf/tests/pmu-events.c                      |    5 +-
 tools/perf/tests/sample-parsing.c                  |  109 +
 tools/perf/tests/shell/annotate.sh                 |    1 -
 tools/perf/tests/shell/annotate_weight.sh          |   63 +
 tools/perf/tests/shell/attr.sh                     |    7 +-
 tools/perf/tests/shell/attr/README                 |   10 +-
 tools/perf/tests/shell/attr/base-record            |    2 +-
 tools/perf/tests/shell/attr/base-stat              |    2 +-
 tools/perf/tests/shell/attr/base-stat-group        |   45 +
 tools/perf/tests/shell/attr/system-wide-dummy      |    2 +-
 tools/perf/tests/shell/attr/test-record-dummy-C0   |    2 +-
 .../perf/tests/shell/attr/test-record-graph-dwarf  |    2 +-
 .../tests/shell/attr/test-record-group-sampling    |    5 +-
 .../tests/shell/attr/test-record-group-sampling1   |    5 +-
 .../tests/shell/attr/test-record-group-sampling2   |    5 +-
 tools/perf/tests/shell/attr/test-record-group1     |    3 +-
 tools/perf/tests/shell/attr/test-record-group2     |    3 +-
 tools/perf/tests/shell/attr/test-record-group3     |    3 +-
 tools/perf/tests/shell/attr/test-stat-C0           |    1 +
 tools/perf/tests/shell/attr/test-stat-basic        |    1 +
 tools/perf/tests/shell/attr/test-stat-default      |   91 +-
 tools/perf/tests/shell/attr/test-stat-detailed-1   |   99 +-
 tools/perf/tests/shell/attr/test-stat-detailed-2   |  111 +-
 tools/perf/tests/shell/attr/test-stat-detailed-3   |  115 +-
 tools/perf/tests/shell/attr/test-stat-group1       |    3 +-
 tools/perf/tests/shell/attr/test-stat-no-inherit   |    1 +
 .../tests/shell/base_probe/test_adding_kernel.sh   |    1 -
 tools/perf/tests/shell/c2c.sh                      |  114 +
 tools/perf/tests/shell/common/init.sh              |   21 +-
 tools/perf/tests/shell/coresight/callchain.sh      |    7 +-
 .../shell/coresight/test_arm_coresight_disasm.sh   |   15 +-
 tools/perf/tests/shell/data_type_profiling.sh      |   55 +-
 tools/perf/tests/shell/diff.sh                     |    1 -
 tools/perf/tests/shell/drm_pmu.sh                  |    2 +-
 tools/perf/tests/shell/ftrace.sh                   |    2 +-
 tools/perf/tests/shell/inject_aslr.sh              |    1 -
 tools/perf/tests/shell/jitdump-python.sh           |    1 -
 tools/perf/tests/shell/kallsyms.sh                 |    2 +-
 tools/perf/tests/shell/lib/attr.py                 |  584 ++-
 tools/perf/tests/shell/lib/perf_brstack_max.py     |   40 +
 .../perf/tests/shell/lib/perf_json_output_lint.py  |   36 +-
 .../perf/tests/shell/lib/perf_metric_validation.py |   53 +-
 tools/perf/tests/shell/lib/perf_record.sh          |    2 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   33 +-
 tools/perf/tests/shell/lib/setup_python.sh         |   29 +-
 tools/perf/tests/shell/lib/waiting.sh              |   34 +-
 tools/perf/tests/shell/list.sh                     |    3 +-
 tools/perf/tests/shell/perf_sched_stats.sh         |    2 +-
 tools/perf/tests/shell/pipe_test.sh                |    1 -
 tools/perf/tests/shell/probe_vfs_getname.sh        |    5 +-
 tools/perf/tests/shell/python-use.sh               |    3 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   87 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |   18 +-
 tools/perf/tests/shell/record.sh                   |  278 +-
 tools/perf/tests/shell/record_weak_term.sh         |    1 -
 tools/perf/tests/shell/report_hybrid_merge.sh      |  121 +
 tools/perf/tests/shell/schedstat_snapshots.sh      |  155 +
 tools/perf/tests/shell/script.sh                   |   46 +-
 tools/perf/tests/shell/script_dlfilter.sh          |    1 -
 tools/perf/tests/shell/script_perl.sh              |  102 -
 tools/perf/tests/shell/script_python.sh            |  113 -
 tools/perf/tests/shell/stat+csv_output.sh          |    3 +-
 tools/perf/tests/shell/stat+csv_summary.sh         |    2 +-
 tools/perf/tests/shell/stat+event_uniquifying.sh   |    2 +-
 tools/perf/tests/shell/stat+json_output.sh         |    3 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |    2 +-
 tools/perf/tests/shell/stat+std_output.sh          |    3 +-
 tools/perf/tests/shell/stat.sh                     |    7 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |    2 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |    2 +-
 tools/perf/tests/shell/stat_all_pfm.sh             |    2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |    2 +-
 tools/perf/tests/shell/stat_metrics_cgrp.sh        |    9 +-
 tools/perf/tests/shell/stat_metrics_values.sh      |    3 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |    1 -
 tools/perf/tests/shell/test_brstack.sh             |    1 -
 .../tests/shell/test_check_perf_trace_python.sh    |   87 +
 .../tests/shell/test_compaction_times_python.sh    |  129 +
 tools/perf/tests/shell/test_data_symbol.sh         |    7 +-
 .../shell/test_event_analyzing_sample_python.sh    |   70 +
 tools/perf/tests/shell/test_event_open_fallback.sh |    2 -
 .../shell/test_export_to_postgresql_python.sh      |  129 +
 .../tests/shell/test_export_to_sqlite_python.sh    |  115 +
 .../shell/test_failed_syscalls_by_pid_python.sh    |  106 +
 .../tests/shell/test_failed_syscalls_python.sh     |   90 +
 tools/perf/tests/shell/test_flamegraph_python.sh   |  123 +
 .../tests/shell/test_futex_contention_python.sh    |  116 +
 tools/perf/tests/shell/test_gecko_python.sh        |   96 +
 tools/perf/tests/shell/test_ilist_python.sh        |  181 +
 tools/perf/tests/shell/test_intel_pt.sh            |   44 +-
 .../tests/shell/test_intel_pt_events_python.sh     |   74 +
 .../perf/tests/shell/test_mem_phys_addr_python.sh  |  105 +
 .../tests/shell/test_net_dropmonitor_python.sh     |  103 +
 tools/perf/tests/shell/test_netdev_times_python.sh |  104 +
 .../tests/shell/test_perf_data_converter_json.sh   |    1 -
 .../perf/tests/shell/test_powerpc_hcalls_python.sh |   95 +
 tools/perf/tests/shell/test_rw_by_file_python.sh   |   69 +
 tools/perf/tests/shell/test_rw_by_pid_python.sh    |   75 +
 tools/perf/tests/shell/test_rwtop_python.sh        |   74 +
 .../tests/shell/test_sched_migration_python.sh     |   72 +
 tools/perf/tests/shell/test_sctop_python.sh        |   78 +
 .../perf/tests/shell/test_stackcollapse_python.sh  |   78 +
 tools/perf/tests/shell/test_stat_cpi_python.sh     |  121 +
 .../shell/test_syscall_counts_by_pid_python.sh     |   93 +
 .../perf/tests/shell/test_syscall_counts_python.sh |   82 +
 tools/perf/tests/shell/test_task_analyzer.sh       |   93 +-
 tools/perf/tests/shell/test_test_junit_output.sh   |    6 +-
 tools/perf/tests/shell/test_treport_python.sh      |  247 +
 tools/perf/tests/shell/test_ttimechart_python.sh   |  237 +
 .../tests/shell/test_uprobe_from_different_cu.sh   |   10 +-
 .../perf/tests/shell/test_wakeup_latency_python.sh |   83 +
 tools/perf/tests/shell/top.sh                      |   73 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    6 +-
 tools/perf/tests/shell/trace_btf_enum.sh           |    1 -
 tools/perf/tests/shell/trace_btf_general.sh        |    9 +-
 tools/perf/tests/shell/trace_exit_race.sh          |    1 -
 tools/perf/tests/shell/trace_ksym_beautifier.sh    |   38 +
 tools/perf/tests/shell/trace_record_replay.sh      |    2 -
 tools/perf/tests/shell/trace_summary.sh            |   16 +-
 tools/perf/tests/sw-clock.c                        |    2 +-
 tools/perf/tests/symbols.c                         |   96 +-
 tools/perf/tests/task-exit.c                       |    1 +
 tools/perf/tests/tests-scripts.c                   |   85 +-
 tools/perf/tests/tests.h                           |   20 +
 tools/perf/tests/thread-maps-share.c               |    3 +-
 tools/perf/tests/tool_pmu.c                        |   79 +
 tools/perf/tests/workloads/Build                   |    2 +
 tools/perf/tests/workloads/code_with_type.c        |    2 +-
 tools/perf/tests/workloads/false_sharing.c         |  251 +
 tools/perf/trace/beauty/arch_errno_names.sh        |    4 +-
 tools/perf/trace/beauty/beauty.h                   |   20 +
 tools/perf/trace/beauty/include/linux/socket.h     |   11 +-
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h |    1 +
 tools/perf/trace/beauty/include/uapi/linux/fs.h    |    3 +-
 tools/perf/trace/beauty/include/uapi/linux/mount.h |    1 +
 .../perf/trace/beauty/include/uapi/sound/asound.h  |  200 +-
 tools/perf/trace/beauty/perf_event_open.c          |   31 +-
 tools/perf/trace/beauty/sockaddr.c                 |   49 +-
 tools/perf/trace/beauty/syscalltbl.sh              |    2 +-
 tools/perf/trace/beauty/timespec.c                 |    2 +-
 tools/perf/ui/Build                                |    1 +
 tools/perf/ui/browsers/annotate-data.c             |   12 +-
 tools/perf/ui/browsers/annotate.c                  |   21 +-
 tools/perf/ui/browsers/hists.c                     |    8 +-
 tools/perf/ui/browsers/scripts.c                   |  220 +-
 tools/perf/ui/gtk/annotate.c                       |   36 +-
 tools/perf/ui/gtk/browser.c                        |   96 +-
 tools/perf/ui/gtk/gtk.h                            |   16 +-
 tools/perf/ui/gtk/hists.c                          |   72 +-
 tools/perf/ui/gtk/progress.c                       |   40 +-
 tools/perf/ui/gtk/setup.c                          |    5 +-
 tools/perf/ui/gtk/util.c                           |   97 +-
 tools/perf/ui/hist.c                               |  248 +-
 tools/perf/ui/libslang.h                           |    2 +
 tools/perf/ui/progress.c                           |    6 +
 tools/perf/ui/progress.h                           |    4 +
 tools/perf/ui/setup.c                              |    2 +-
 tools/perf/ui/stdio/progress.c                     |  170 +
 tools/perf/util/Build                              |   18 +-
 tools/perf/util/addr2line.c                        |   68 +-
 tools/perf/util/annotate-arch/Build                |    1 +
 tools/perf/util/annotate-arch/annotate-alpha.c     |  185 +
 tools/perf/util/annotate-arch/annotate-arm64.c     | 1211 ++++-
 tools/perf/util/annotate-arch/annotate-loongarch.c |    4 +
 tools/perf/util/annotate-arch/annotate-powerpc.c   |    9 +
 tools/perf/util/annotate-arch/annotate-x86.c       |  117 +-
 tools/perf/util/annotate-data.c                    |  510 +-
 tools/perf/util/annotate-data.h                    |   31 +-
 tools/perf/util/annotate.c                         |  240 +-
 tools/perf/util/annotate.h                         |  121 +-
 tools/perf/util/arm-spe.c                          |   17 +-
 tools/perf/util/aslr.c                             |   41 +-
 tools/perf/util/aslr.h                             |    2 +
 tools/perf/util/auxtrace.c                         |   21 +-
 tools/perf/util/auxtrace.h                         |    8 +-
 tools/perf/util/bpf-filter.c                       |   29 +-
 tools/perf/util/bpf-filter.l                       |    1 +
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |  220 +-
 tools/perf/util/bpf_skel/perf_trace_u.h            |   14 +
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |    9 +
 tools/perf/util/bpf_trace_augment.c                |   91 +-
 tools/perf/util/build-id.c                         |   12 +-
 tools/perf/util/c2c-function.c                     |    9 +-
 tools/perf/util/c2c.h                              |    2 +
 tools/perf/util/cache.h                            |   31 -
 tools/perf/util/capstone.c                         |  186 +-
 tools/perf/util/config.c                           |  214 +-
 tools/perf/util/config.h                           |    2 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   12 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |    2 +-
 tools/perf/util/cs-etm.c                           |  186 +-
 tools/perf/util/debug.c                            |    2 +-
 tools/perf/util/debug.h                            |    5 +-
 tools/perf/util/debuginfo.c                        |   51 +-
 tools/perf/util/debuginfo.h                        |   13 +-
 tools/perf/util/disasm.c                           |  140 +-
 tools/perf/util/disasm.h                           |    6 +
 tools/perf/util/dso.c                              |  333 +-
 tools/perf/util/dso.h                              |   72 +-
 tools/perf/util/dwarf-aux.c                        |  247 +-
 tools/perf/util/dwarf-aux.h                        |   16 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c |   25 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c  |    2 +-
 .../perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c |    2 +-
 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c  |    2 +-
 tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c   |  140 +-
 tools/perf/util/dwarf-regs.c                       |   11 +-
 tools/perf/util/env.c                              |    1 +
 tools/perf/util/env.h                              |   10 +
 tools/perf/util/evlist.c                           |  236 +-
 tools/perf/util/evlist.h                           |    3 +
 tools/perf/util/evsel.c                            |  317 +-
 tools/perf/util/evsel.h                            |   10 +
 tools/perf/util/expr.c                             |    5 +-
 tools/perf/util/genelf_debug.c                     |   28 +-
 tools/perf/util/header.c                           |  330 +-
 tools/perf/util/header.h                           |    1 +
 tools/perf/util/help-unknown-cmd.c                 |   15 +-
 tools/perf/util/help-unknown-cmd.h                 |    0
 tools/perf/util/hist.c                             |    6 +-
 tools/perf/util/hist.h                             |   21 +-
 tools/perf/util/hwmon_pmu.c                        |    2 +-
 tools/perf/util/include/dwarf-regs.h               |    8 +-
 tools/perf/util/intel-bts.c                        |    2 +-
 tools/perf/util/intel-pt.c                         |    3 +-
 tools/perf/util/jitdump.c                          |  204 +-
 tools/perf/util/libbfd.c                           |   96 +-
 tools/perf/util/libbfd.h                           |    9 +
 tools/perf/util/libdw.c                            |   54 +-
 tools/perf/util/libdw.h                            |    5 +-
 tools/perf/util/llvm-c-helpers.cpp                 |   66 +-
 tools/perf/util/llvm.c                             |   68 +-
 tools/perf/util/machine.c                          |    6 +-
 tools/perf/util/machine.h                          |   10 +-
 tools/perf/util/mem-events.c                       |   94 +-
 tools/perf/util/mem-events.h                       |    5 +-
 tools/perf/util/metricgroup.c                      |   37 +-
 tools/perf/util/mmap.c                             |    3 +-
 tools/perf/util/mutex.c                            |  101 +-
 tools/perf/util/mutex.h                            |   42 +
 tools/perf/util/ordered-events.c                   |   16 +-
 tools/perf/util/parse-events.c                     |    7 +-
 tools/perf/util/parse-regs-options.c               |  211 +-
 tools/perf/util/path.c                             |   10 +-
 tools/perf/util/path.h                             |    6 +-
 tools/perf/util/perf-regs-arch/perf_regs_x86.c     |  438 +-
 tools/perf/util/perf_event_attr_fprintf.c          |   13 +
 tools/perf/util/perf_regs.c                        |   84 +-
 tools/perf/util/perf_regs.h                        |   21 +-
 tools/perf/util/pfm.c                              |    1 +
 tools/perf/util/pmu.c                              |   48 +-
 tools/perf/util/pmu.h                              |    3 +
 tools/perf/util/pmus.c                             |   21 +-
 tools/perf/util/powerpc-vpadtl.c                   |    2 +-
 tools/perf/util/print-events.c                     |    1 +
 tools/perf/util/print_insn.h                       |    1 +
 tools/perf/util/probe-event.c                      |    4 +-
 tools/perf/util/python.c                           | 2019 ++++++--
 tools/perf/util/record.h                           |    7 +
 tools/perf/util/sample.h                           |    5 +
 tools/perf/util/scripting-engines/Build            |    9 -
 .../perf/util/scripting-engines/trace-event-perl.c |  770 ---
 .../util/scripting-engines/trace-event-python.c    | 2224 ---------
 tools/perf/util/session.c                          |  139 +-
 tools/perf/util/setup.py                           |    1 +
 tools/perf/util/srcline.c                          |   81 +-
 tools/perf/util/strbuf.c                           |   14 +-
 tools/perf/util/symbol-elf.c                       |    3 +-
 tools/perf/util/symbol.c                           |   92 +-
 tools/perf/util/symbol_conf.h                      |   16 +-
 tools/perf/util/synthetic-events.c                 |   56 +-
 tools/perf/util/thread.c                           |   18 +-
 tools/perf/util/thread_map.c                       |   26 +
 tools/perf/util/thread_map.h                       |    1 +
 tools/perf/util/tool_pmu.c                         |    2 +-
 tools/perf/util/tp_pmu.c                           |    8 +-
 tools/perf/util/trace-event-parse.c                |   65 -
 tools/perf/util/trace-event-scripting.c            |  407 --
 tools/perf/util/trace-event.c                      |   90 +-
 tools/perf/util/trace-event.h                      |   73 +-
 tools/perf/util/trace_augment.h                    |   35 +-
 tools/perf/util/unwind-libdw.c                     |   59 +-
 tools/perf/util/unwind-libunwind.c                 |   64 +-
 tools/perf/util/usage.c                            |   34 -
 tools/perf/util/util.h                             |    4 -
 650 files changed, 43377 insertions(+), 25530 deletions(-)
 delete mode 100644 tools/build/feature/test-gtk2-infobar.c
 rename tools/build/feature/{test-gtk2.c => test-gtk4.c} (76%)
 delete mode 100644 tools/build/feature/test-libperl.c
 delete mode 100644 tools/build/feature/test-libpython.c
 create mode 100644 tools/build/feature/test-pthread-mutex-robust.c
 create mode 100644 tools/build/feature/test-python-module.c
 delete mode 100644 tools/perf/Documentation/perf-script-perl.txt
 create mode 100644 tools/perf/arch/riscv/include/arch-tests.h
 create mode 100644 tools/perf/arch/riscv/tests/Build
 create mode 100644 tools/perf/arch/riscv/tests/arch-tests.c
 create mode 100644 tools/perf/arch/riscv/tests/dwarf-unwind.c
 create mode 100644 tools/perf/arch/riscv/tests/regs_load.S
 create mode 100644 tools/perf/bench/atomic.c
 create mode 100755 tools/perf/python/SchedGui.py
 create mode 100755 tools/perf/python/arm-cs-trace-disasm.py
 create mode 100755 tools/perf/python/check-perf-trace.py
 create mode 100755 tools/perf/python/compaction-times.py
 create mode 100755 tools/perf/python/event_analyzing_sample.py
 create mode 100755 tools/perf/python/export-to-postgresql.py
 create mode 100755 tools/perf/python/export-to-sqlite.py
 create mode 100755 tools/perf/python/exported-sql-viewer.py
 create mode 100755 tools/perf/python/failed-syscalls-by-pid.py
 create mode 100755 tools/perf/python/failed-syscalls.py
 create mode 100755 tools/perf/python/flamegraph.py
 create mode 100755 tools/perf/python/futex-contention.py
 create mode 100755 tools/perf/python/gecko.py
 create mode 100755 tools/perf/python/intel-pt-events.py
 create mode 100755 tools/perf/python/libxed.py
 create mode 100755 tools/perf/python/mem-phys-addr.py
 create mode 100755 tools/perf/python/net_dropmonitor.py
 create mode 100755 tools/perf/python/netdev-times.py
 create mode 100755 tools/perf/python/parallel-perf.py
 rename tools/perf/{scripts => }/python/powerpc-hcalls.py (54%)
 mode change 100644 => 100755
 create mode 100755 tools/perf/python/rw-by-file.py
 create mode 100755 tools/perf/python/rw-by-pid.py
 create mode 100755 tools/perf/python/rwtop.py
 create mode 100755 tools/perf/python/sched-migration.py
 create mode 100755 tools/perf/python/sctop.py
 create mode 100755 tools/perf/python/stackcollapse.py
 create mode 100755 tools/perf/python/stat-cpi.py
 create mode 100755 tools/perf/python/syscall-counts-by-pid.py
 create mode 100755 tools/perf/python/syscall-counts.py
 create mode 100755 tools/perf/python/task-analyzer.py
 create mode 100755 tools/perf/python/treport.py
 create mode 100755 tools/perf/python/ttimechart.py
 create mode 100755 tools/perf/python/wakeup-latency.py
 delete mode 100644 tools/perf/scripts/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Context.xs
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/Makefile.PL
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/README
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Context.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Core.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/lib/Perf/Trace/Util.pm
 delete mode 100644 tools/perf/scripts/perl/Perf-Trace-Util/typemap
 delete mode 100644 tools/perf/scripts/perl/bin/check-perf-trace-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-record
 delete mode 100644 tools/perf/scripts/perl/bin/failed-syscalls-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-file-report
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-record
 delete mode 100644 tools/perf/scripts/perl/bin/rw-by-pid-report
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-record
 delete mode 100644 tools/perf/scripts/perl/bin/rwtop-report
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-record
 delete mode 100644 tools/perf/scripts/perl/bin/wakeup-latency-report
 delete mode 100644 tools/perf/scripts/perl/check-perf-trace.pl
 delete mode 100644 tools/perf/scripts/perl/failed-syscalls.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-file.pl
 delete mode 100644 tools/perf/scripts/perl/rw-by-pid.pl
 delete mode 100644 tools/perf/scripts/perl/rwtop.pl
 delete mode 100644 tools/perf/scripts/perl/wakeup-latency.pl
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Build
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/Context.c
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Core.py
 delete mode 100755 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/EventClass.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/SchedGui.py
 delete mode 100644 tools/perf/scripts/python/Perf-Trace-Util/lib/Perf/Trace/Util.py
 delete mode 100755 tools/perf/scripts/python/arm-cs-trace-disasm.py
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-record
 delete mode 100644 tools/perf/scripts/python/bin/compaction-times-report
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-record
 delete mode 100644 tools/perf/scripts/python/bin/event_analyzing_sample-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-postgresql-report
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-record
 delete mode 100644 tools/perf/scripts/python/bin/export-to-sqlite-report
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/failed-syscalls-by-pid-report
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-record
 delete mode 100755 tools/perf/scripts/python/bin/flamegraph-report
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-record
 delete mode 100644 tools/perf/scripts/python/bin/futex-contention-report
 delete mode 100644 tools/perf/scripts/python/bin/gecko-record
 delete mode 100755 tools/perf/scripts/python/bin/gecko-report
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-record
 delete mode 100644 tools/perf/scripts/python/bin/intel-pt-events-report
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-record
 delete mode 100644 tools/perf/scripts/python/bin/mem-phys-addr-report
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-record
 delete mode 100755 tools/perf/scripts/python/bin/net_dropmonitor-report
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-record
 delete mode 100644 tools/perf/scripts/python/bin/netdev-times-report
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-record
 delete mode 100644 tools/perf/scripts/python/bin/powerpc-hcalls-report
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-record
 delete mode 100644 tools/perf/scripts/python/bin/sched-migration-report
 delete mode 100644 tools/perf/scripts/python/bin/sctop-record
 delete mode 100644 tools/perf/scripts/python/bin/sctop-report
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-record
 delete mode 100755 tools/perf/scripts/python/bin/stackcollapse-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-by-pid-report
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-record
 delete mode 100644 tools/perf/scripts/python/bin/syscall-counts-report
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-record
 delete mode 100755 tools/perf/scripts/python/bin/task-analyzer-report
 delete mode 100644 tools/perf/scripts/python/check-perf-trace.py
 delete mode 100644 tools/perf/scripts/python/compaction-times.py
 delete mode 100644 tools/perf/scripts/python/event_analyzing_sample.py
 delete mode 100644 tools/perf/scripts/python/export-to-postgresql.py
 delete mode 100644 tools/perf/scripts/python/export-to-sqlite.py
 delete mode 100755 tools/perf/scripts/python/exported-sql-viewer.py
 delete mode 100644 tools/perf/scripts/python/failed-syscalls-by-pid.py
 delete mode 100755 tools/perf/scripts/python/flamegraph.py
 delete mode 100644 tools/perf/scripts/python/futex-contention.py
 delete mode 100644 tools/perf/scripts/python/gecko.py
 delete mode 100644 tools/perf/scripts/python/intel-pt-events.py
 delete mode 100644 tools/perf/scripts/python/libxed.py
 delete mode 100644 tools/perf/scripts/python/mem-phys-addr.py
 delete mode 100755 tools/perf/scripts/python/net_dropmonitor.py
 delete mode 100644 tools/perf/scripts/python/netdev-times.py
 delete mode 100755 tools/perf/scripts/python/parallel-perf.py
 delete mode 100644 tools/perf/scripts/python/sched-migration.py
 delete mode 100644 tools/perf/scripts/python/sctop.py
 delete mode 100755 tools/perf/scripts/python/stackcollapse.py
 delete mode 100644 tools/perf/scripts/python/stat-cpi.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts-by-pid.py
 delete mode 100644 tools/perf/scripts/python/syscall-counts.py
 delete mode 100755 tools/perf/scripts/python/task-analyzer.py
 create mode 100755 tools/perf/scripts/sync-headers.sh
 create mode 100644 tools/perf/tests/event_refresh.c
 create mode 100644 tools/perf/tests/hybrid-merge.c
 create mode 100755 tools/perf/tests/shell/annotate_weight.sh
 create mode 100644 tools/perf/tests/shell/attr/base-stat-group
 create mode 100644 tools/perf/tests/shell/lib/perf_brstack_max.py
 create mode 100755 tools/perf/tests/shell/report_hybrid_merge.sh
 create mode 100755 tools/perf/tests/shell/schedstat_snapshots.sh
 delete mode 100755 tools/perf/tests/shell/script_perl.sh
 delete mode 100755 tools/perf/tests/shell/script_python.sh
 create mode 100755 tools/perf/tests/shell/test_check_perf_trace_python.sh
 create mode 100755 tools/perf/tests/shell/test_compaction_times_python.sh
 create mode 100755 tools/perf/tests/shell/test_event_analyzing_sample_python.sh
 create mode 100755 tools/perf/tests/shell/test_export_to_postgresql_python.sh
 create mode 100755 tools/perf/tests/shell/test_export_to_sqlite_python.sh
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_failed_syscalls_python.sh
 create mode 100755 tools/perf/tests/shell/test_flamegraph_python.sh
 create mode 100755 tools/perf/tests/shell/test_futex_contention_python.sh
 create mode 100755 tools/perf/tests/shell/test_gecko_python.sh
 create mode 100755 tools/perf/tests/shell/test_ilist_python.sh
 create mode 100755 tools/perf/tests/shell/test_intel_pt_events_python.sh
 create mode 100755 tools/perf/tests/shell/test_mem_phys_addr_python.sh
 create mode 100755 tools/perf/tests/shell/test_net_dropmonitor_python.sh
 create mode 100755 tools/perf/tests/shell/test_netdev_times_python.sh
 create mode 100755 tools/perf/tests/shell/test_powerpc_hcalls_python.sh
 create mode 100755 tools/perf/tests/shell/test_rw_by_file_python.sh
 create mode 100755 tools/perf/tests/shell/test_rw_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_rwtop_python.sh
 create mode 100755 tools/perf/tests/shell/test_sched_migration_python.sh
 create mode 100755 tools/perf/tests/shell/test_sctop_python.sh
 create mode 100755 tools/perf/tests/shell/test_stackcollapse_python.sh
 create mode 100755 tools/perf/tests/shell/test_stat_cpi_python.sh
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_by_pid_python.sh
 create mode 100755 tools/perf/tests/shell/test_syscall_counts_python.sh
 create mode 100755 tools/perf/tests/shell/test_treport_python.sh
 create mode 100755 tools/perf/tests/shell/test_ttimechart_python.sh
 create mode 100755 tools/perf/tests/shell/test_wakeup_latency_python.sh
 create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh
 create mode 100644 tools/perf/tests/workloads/false_sharing.c
 create mode 100644 tools/perf/ui/stdio/progress.c
 create mode 100644 tools/perf/util/annotate-arch/annotate-alpha.c
 create mode 100644 tools/perf/util/bpf_skel/perf_trace_u.h
 delete mode 100644 tools/perf/util/cache.h
 delete mode 100644 tools/perf/util/help-unknown-cmd.h
 delete mode 100644 tools/perf/util/scripting-engines/Build
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-perl.c
 delete mode 100644 tools/perf/util/scripting-engines/trace-event-python.c
 delete mode 100644 tools/perf/util/trace-event-scripting.c
 delete mode 100644 tools/perf/util/usage.c
