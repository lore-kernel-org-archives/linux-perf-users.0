Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793397671;
	b=NOajIywKxCdmet3pBUn8nzHnPjPUG/wZKkIiApDIxLcqgbndxExaXPDCh183lnkIHdwH
	 lZZgRC2IOmNUZmK7Hno49IjSDDyEyQ3sBxxiYOmyMAq2hjX+1C9c9JIRDGS5JIomBBFRI
	 JakSkStxABJW3CjkLDdTBAVnanLh2D9IBIEW0iBA0YI78Zhoh+3tUa562A457Pc/NQ2jh
	 IIzGEwADifVVygGdwSLjEj4KkX2ivQXd/fEJ0CpikeMjNVufrsodn8i3wx9QeuoYK+7me
	 ruaPvnPg4S35dK+hlk71l8LcUJX8fr4cQij5ZUiuzoLq2nJpZNzVAV55bLIKQ2KSIqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793397671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vAw5IBQN+viGaY22u8ozy3VZ8JQy1isoK+0b/ar7YfI=;
	b=zAP/LukORmKXDGuziGP9WmACkR3O4iJ3ogUkSCz1wahcqiBaB16uFhr2A7YO78Gs44nb
	 AHqojsrNMBfVWzeSmQR0A3YTqMs+zN4Ai76pEE1Wj64Scc6daUkowYK3iwuWqVI7odwn6
	 spNTqJFPMbZxxbl/xgtpHYk6fV4hrOlQZ1lD+kGj1bOteAysVe3GVFvKOS9tqO+QAzU1f
	 7EPMjDwyFMl4hv2WiYhFtPPJzllPgNnZQlqskBuxz23xCX3FwoESTchw4/Lzt7SUKRdC0
	 V9kQNq87KYLfH2Mztl26wqOiUe1ZwMutR6u7O022BDvDjb0gDXenSzY7AOZTxXAfFpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccH67ozK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF3606A324;
	Fri, 30 Oct 2026 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ccH67ozK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27A91F000C1;
	Fri, 30 Oct 2026 22:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793397670;
	bh=vAw5IBQN+viGaY22u8ozy3VZ8JQy1isoK+0b/ar7YfI=;
	h=From:To:Cc:Subject:Date;
	b=ccH67ozKo6fnGhLg3bIJql6KEySl7WEsfRUFJoz7xg06A0+GRhfehH1Gy1yqRn9Xy
	 2Xb/b5eIZUXdrj4ObcwKlQZigpjJVAa/N0C65SgxjvE/q0E28BK//KTLGbFLK0MGMo
	 YLS2Z47JjU+BfX+YpE74lbMUf1yl6S4glTs71LQ16g4G87zHAEMW529Yc67j8wIlLb
	 bbvo6DlOqzkIUAd6f1e5VuV+NDopSR4YWqVX4prrr2LDbPR/epGUEmMuvD8Iv9nLBu
	 B0ZBVuCeQ6WsoJvHuTXhoKDHT28SYAynZnLdTWSk9HEx1Y1IEGEeDNi7+NN7xDz4UV
	 CkEVK2VA3PhTg==
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
	Zide Chen <zide.chen@intel.com>
Subject: [GIT PULL] perf tools changes for v7.4
Date: Fri, 30 Oct 2026 19:00:59 -0300
Message-ID: <20261030220059.26955-1-acme@kernel.org>
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

	Please consider pulling,

Best regards,

- Arnaldo

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

Arnaldo Carvalho de Melo (71):
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
  perf pmu intel: Generalize SNC cpumask adjustment for multiple
    platforms
  perf pmu intel: Adjust cpumasks for sub-NUMA clusters on Sapphire
    Rapids and Emerald Rapids
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
  perf powerpc-vpadtl: Fix off-by-one in auxtrace_info minimum size
    check

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

-- 
2.56.0

