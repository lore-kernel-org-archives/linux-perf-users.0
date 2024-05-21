Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECDC148858;
	Tue, 21 May 2024 19:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716319587; cv=none; b=PLced1WQ7OojwPncnjR8t2lATZgSLstK3KzF1Q99FioPh8CIbRPKm4QING4YRxzl2SCcDVRE36/ERp5ouw3YStWmRft/SUpqDIhyzD1ekDa82T7CtEGxeVgEl533/DOCJD0gDLIuoMNd+uwoIfn2rtIi7nDBTAX2FsQOLRfsDes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716319587; c=relaxed/simple;
	bh=mp5Y7ruh0ClXapgE7Z88NnAe9ZmdMyENiRm+VcduYYs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P94bhtzBRN8V/pye0AoxMK+kFYQ1TIagjDhX8kl5KQfY1ZxHm/5C8rMm83hI4VjkQ0A4V9vldcube8Hy4osSD/0QQBYtq75kbmXrydj8DoBtSkvKB+AqZ3pzlJUk3g4U2M9lOOSCg3sqvzS/8dX17ljshA6U7siuPRDJwa34A5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKjmi9Mf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKjmi9Mf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A85EC32786;
	Tue, 21 May 2024 19:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716319587;
	bh=mp5Y7ruh0ClXapgE7Z88NnAe9ZmdMyENiRm+VcduYYs=;
	h=From:To:Cc:Subject:Date:From;
	b=kKjmi9MfG2YGWpBTPm56umvzzJLvXYdP4fsQTcZL1D8xcB+k7H+4UVh6cOX1K5fH2
	 Lz5HEZLmXA6iCTmeEWYOZ1QyR4uyKxxnfGXIWLsb0imEnGZc2m6dv+F5r3diX7aSLR
	 6JcRVeWGVkSHjDe1Ofd3vWfJNq/uBPECmz6pl4U07kt9dxQ4Q8B3DBDgD9D4qrMgGR
	 FGZT8gstVvYHAo02qr55pAwuR+7sbGZNL4Bp1eb/NrlJdcFB16PmYOeOuoljZTpoMC
	 zeiC+vTUoo1O+asW6yoASfox3IQFMbMGjUSS/T2Cxv8mLjWLeHV3GvkQ371OHp54zi
	 19wmtqoerRCEQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Anne Macedo <retpolanne@posteo.net>,
	Bhaskar Chowdhury <unixbhaskar@gmail.com>,
	Ethan Adams <j.ethan.adams@gmail.com>,
	James Clark <james.clark@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Yang Jihong <yangjihong@bytedance.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.10
Date: Tue, 21 May 2024 16:26:14 -0300
Message-ID: <20240521192614.3937942-1-acme@kernel.org>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling, there is one patch for updating
the tools/lib/ (edited) copy of rbtree.c and rbtree_augmented.h that is
already in your tree, as I didn't notice that Andrew Morton had picked
it until Stephen Rothwell mentioned it to me, no biggie, I think.

Best regards,

- Arnaldo

The following changes since commit ed30a4a51bb196781c8058073ea720133a65596f:

  Linux 6.9-rc5 (2024-04-21 12:35:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.10-1-2024-05-21

for you to fetch changes up to ea558c86248b4955e5c5f3c0c921df450880605e:

  tools lib subcmd: Show parent options in help (2024-05-12 21:09:52 -0300)

----------------------------------------------------------------
perf tools fixes and improvements for v6.10:

- Add Kan Liang to MAINTAINERS as a perf tools reviewer.

- Add support for using the 'capstone' disassembler library in various tools,
  such as 'perf script' and 'perf annotate'. This is an alternative for the
  use of the 'xed' and 'objdump' disassemblers.

- Data-type profiling improvements:

  Resolve types for a->b->c by backtracking the assignments until it finds
  DWARF info for one of those members

  Support for global variables, keeping a cache to speed up lookups.

  Handle the 'call' instruction, dealing with effects on registers and handling
  its return when tracking register data types.

  Handle x86's segment based addressing like %gs:0x28, to support things like
  per CPU variables, the stack canary, etc.

  Data-type profiling got big speedups when using capstone for disassembling.
  The objdump outoput parsing method is left as a fallback when capstone fails or
  isn't available. There are patches posted for 6.11 that to use a LLVM
  disassembler.

  Support event group display in the TUI when annotating types with --data-type,
  for instance to show memory load and store events for the data type fields.

  Optimize the 'perf annotate' data structures, reducing memory usage.

  Add a initial 'perf test' for 'perf annotate', checking that a target symbol
  appears on the output, specifying objdump via the command line, etc.

- Integrate the shellcheck utility with the build of perf to allow catching
  shell problems early in areas such as 'perf test', 'perf trace' scrape
  scripts, etc.

- Add 'uretprobe' variant in the 'perf bench uprobe' tool.

- Add script to run instances of 'perf script' in parallel.

- Allow parsing tracepoint names that start with digits, such as
  9p/9p_client_req, etc. Make sure 'perf test' tests it even on systems
  where those tracepoints aren't available.

Vendor Events:

- Update Intel JSON files for Cascade Lake X, Emerald Rapids, Grand Ridge, Ice
  Lake X, Lunar Lake, Meteor Lake, Sapphire Rapids, Sierra Forest, Sky Lake X,
  Sky Lake and Snow Ridge X.  Remove info metrics erroneously in TopdownL1.

- Add AMD's Zen 5 core and uncore events and metrics. Those come from the
  "Performance Monitor Counters for AMD Family 1Ah Model 00h- 0Fh Processors"
  document, with events that capture information on op dispatch, execution and
  retirement, branch prediction, L1 and L2 cache activity, TLB activity, etc.

- Mark L1D_CACHE_INVAL impacted by errata for ARM64's AmpereOne/AmpereOneX.

Miscellaneous:

- Sync header copies with the kernel sources.

- Move some header copies used only for generating translation string tables
  for ioctl cmds and other syscall integer arguments to a new directory under
  tools/perf/beauty/, to separate from copies in tools/include/ that are used
  to build the tools.

- Introduce scrape script for several syscall 'flags'/'mask' arguments.

- Improve cpumap utilization, fixing up pairing of refcounts, using the right
  iterators (perf_cpu_map__for_each_cpu), etc.

- Give more details about raw event encodings in 'perf list', show tracepoint
  encoding in the detailed output.

- Refactor the DSOs handling code, reducing memory usage.

- Document the BPF event modifier and add a 'perf test' for it.

- Improve the event parser, better error messages and add further 'perf test's
  for it.

- Add reference count checking to 'struct comm_str' and 'struct mem_info'.

- Make ARM64's 'perf test' entries for the Neoverse N1 more robust.

- Tweak the ARM64's Coresight 'perf test's.

- Improve ARM64's CoreSight ETM version detection and error reporting.

- Fix handling of symbols when using kcore.

- Fix PAI (Processor Activity Instrumentation) counter names for s390 virtual
  machines in 'perf report'.

- Fix -g/--call-graph option failure in 'perf sched timehist'.

- Add LIBTRACEEVENT_DIR build option to allow building with libtraceevent
  installed in non-standard directories, such as when doing cross builds.

- Various 'perf test' and 'perf bench' fixes.

- Improve 'perf probe' error message for long C++ probe names.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (6):
      perf script: Show also errors for --insn-trace option
      perf auxtrace: Fix multiple use of --itrace option
      perf script: Consolidate capstone print functions
      perf record: Fix debug message placement for test consumption
      perf scripts python: Add a script to run instances of 'perf script' in parallel
      perf intel-pt: Fix unassigned instruction op (discovered by MemorySanitizer)

Andi Kleen (2):
      perf script: Support 32bit code under 64bit OS with capstone
      perf script: Add capstone support for '-F +brstackdisasm'

Anne Macedo (1):
      perf lock contention: Trim backtrace by skipping traceiter functions

Arnaldo Carvalho de Melo (36):
      perf trace: Collect sys_nanosleep first argument
      perf beauty: Fix dependency of tables using uapi/linux/mount.h
      perf beauty: Move uapi/linux/fs.h copy out of the directory used to build perf
      perf beauty: Don't include uapi/linux/mount.h, use sys/mount.h instead
      perf beauty: Move uapi/linux/mount.h copy out of the directory used to build perf
      perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory used to build perf
      perf beauty: Move uapi/sound/asound.h copy out of the directory used to build perf
      perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the directory used to build perf
      perf beauty: Stop using the copy of uapi/linux/prctl.h
      perf beauty: Move prctl.h files (uapi/linux and x86's) copy out of the directory used to build perf
      perf beauty: Use the system linux/fcntl.h instead of a copy from the kernel
      tools headers: Remove now unused copies of uapi/{fcntl,openat2}.h and asm/fcntl.h
      tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines
      perf beauty: Introduce scrape script for 'clone' syscall 'flags' argument
      perf beauty: Introduce scrape script for various fs syscalls 'flags' arguments
      perf beauty: Introduce scrape script for the 'statx' syscall 'mask' argument
      perf beauty: Introduce faccessat2 flags scnprintf routine
      perf trace: Beautify the 'flags' arg of unlinkat
      perf trace: Fix 'newfstatat'/'fstatat' argument pretty printing
      perf probe: Add missing libgen.h header needed for using basename()
      perf beauty: Move uapi/linux/vhost.h copy out of the directory used to build perf
      perf tools: Add Kan Liang to MAINTAINERS as a reviewer
      perf annotate: Initialize 'arch' variable not to trip some -Werror=maybe-uninitialized
      Revert "tools headers: Remove almost unused copy of uapi/stat.h, add few conditional defines"
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      tools include UAPI: Sync linux/vhost.h with the kernel sources
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      perf tests shell kprobes: Add missing description as used by 'perf test' output
      tools lib rbtree: Pick some improvements from the kernel rbtree code
      tools headers x86 cpufeatures: Sync with the kernel sources to pick BHI mitigation changes
      tools headers: Synchronize linux/bits.h with the kernel sources
      perf test: Reintroduce -p/--parallel and make -S/--sequential the default
      perf annotate: Use zfree() to avoid possibly accessing dangling pointers
      perf callchain: Use zfree() to avoid possibly accessing dangling pointers
      perf kwork: Use zfree() to avoid possibly accessing dangling pointers
      perf probe: Use zfree() to avoid possibly accessing dangling pointers

Athira Rajeev (1):
      perf annotate: Fix a comment about multi_regs in extract_reg_offset function

Bhaskar Chowdhury (1):
      perf c2c: Fix a punctuation

Chaitanya S Prakash (1):
      perf tools: Enable configs required for test_uprobe_from_different_cu.sh

Chen Pei (1):
      perf genelf: Fix compiling with libelf on rv32

Dima Kogan (2):
      perf probe-event: Un-hardcode sizeof(buf)
      perf probe-event: Better error message for a too-long probe name

Dominique Martinet (3):
      perf parse-events: pass parse_state to add_tracepoint
      perf parse-events: Add new 'fake_tp' parameter for tests
      perf parse: Allow tracepoint names to start with digits

Ethan Adams (1):
      perf build: Fix out of tree build related to installation of sysreg-defs

He Zhe (1):
      perf bench internals inject-build-id: Fix trap divide when collecting just one DSO

Howard Chu (1):
      perf record: Fix comment misspellings

Ian Rogers (100):
      libperf cpumap: Add any, empty and min helpers
      libperf cpumap: Ensure empty cpumap is NULL from alloc
      perf arm-spe/cs-etm: Directly iterate CPU maps
      perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty use
      perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
      perf arm64 header: Remove unnecessary CPU map get and put
      perf stat: Remove duplicate cpus_map_matched function
      perf cpumap: Use perf_cpu_map__for_each_cpu when possible
      perf list: Add tracepoint encoding to detailed output
      perf pmu: Drop "default_core" from alias names
      perf list: Allow wordwrap to wrap on commas
      perf list: Give more details about raw event encodings
      perf tools: Use pmus to describe type from attribute
      perf tools: Add/use PMU reverse lookup from config to name
      perf record: Delete session after stopping sideband thread
      perf test: Stat output per thread of just the parent process
      perf test: Use a single fd for the child process out/err
      perf test: Read child test 10 times a second rather than 1
      perf tools: Suggest inbuilt commands for unknown command
      perf help: Lower levenshtein penality for deleting character
      perf tests: Run tests in parallel by default
      perf vendor events intel: Update cascadelakex to 1.21
      perf vendor events intel: Update emeraldrapids to 1.06
      perf vendor events intel: Update grandridge to 1.02
      perf vendor events intel: Update icelakex to 1.24
      perf vendor events intel: Update lunarlake to 1.01
      perf vendor events intel: Update meteorlake to 1.08
      perf vendor events intel: Update sapphirerapids to 1.20
      perf vendor events intel: Update sierraforest to 1.02
      perf vendor events intel: Update skylakex to 1.33
      perf vendor events intel: Update skylake to v58
      perf vendor events intel: Update snowridgex to 1.22
      perf vendor events intel: Remove info metrics erroneously in TopdownL1
      perf dso: Reorder members to save space in 'struct dso'
      tools subcmd: Add check_if_command_finished()
      perf metrics: Remove the "No_group" metric group
      perf dsos: Attempt to better abstract DSOs internals
      perf dsos: Tidy reference counting and locking
      perf dsos: Introduce dsos__for_each_dso()
      perf dso: Move dso functions out of dsos.c
      perf dsos: Switch more loops to dsos__for_each_dso()
      perf list: Escape '\r' in JSON output
      perf build: Add shellcheck to tools/perf scripts
      perf arch x86: Add shellcheck to build
      perf util: Add shellcheck to generate-cmdlist.sh
      perf trace beauty: Add shellcheck to scripts
      perf bench uprobe: Remove lib64 from libc.so.6 binary path
      perf bench uprobe: Add uretprobe variant of uprobe benchmarks
      perf docs: Document bpf event modifier
      perf test bpf-counters: Add test for BPF event modifier
      perf parse-events: Factor out '<event_or_pmu>/.../' parsing
      perf parse-events: Directly pass PMU to parse_events_add_pmu()
      perf parse-events: Avoid copying an empty list
      perf pmu: Refactor perf_pmu__match()
      perf tests parse-events: Use "branches" rather than "cache-references"
      perf parse-events: Legacy cache names on all PMUs and lower priority
      perf parse-events: Handle PE_TERM_HW in name_or_raw
      perf parse-events: Constify parse_events_add_numeric
      perf parse-events: Prefer sysfs/JSON hardware events over legacy
      perf parse-events: Inline parse_events_update_lists
      perf parse-events: Improve error message for bad numbers
      perf parse-events: Inline parse_events_evlist_error
      perf parse-events: Improvements to modifier parsing
      perf parse-event: Constify event_symbol arrays
      perf parse-events: Minor grouping tidy up
      perf parse-events: Tidy the setting of the default event name
      perf build: Pretend scandirat is missing with msan
      perf test pmu-events: Make it clearer that pmu-events tests JSON events
      perf Document: Sysfs event names must be lower or upper case
      perf test pmu: Refactor format test and exposed test APIs
      perf test pmu: Add an eagerly loaded event test
      perf test pmu: Test all sysfs PMU event names are the same case
      perf pmu: Assume sysfs events are always the same case
      perf trace: Disable syscall augmentation with record
      perf dsos: Switch backing storage to array from rbtree/list
      perf dsos: Remove __dsos__addnew()
      perf dsos: Remove __dsos__findnew_link_by_longname_id()
      perf dsos: Switch hand crafted code to bsearch()
      perf dso: Add reference count checking and accessor functions
      perf map: Add missing dso__put() in map__new()
      perf symbol-elf: Ensure dso__put() in machine__process_ksymbol_register()
      perf symbol-elf: dso__load_sym_internal() reference count fixes
      perf dso: Use container_of() to avoid a pointer in 'struct dso_data'
      perf ui browser: Don't save pointer to stack memory
      perf annotate: Fix memory leak in annotated_source
      perf block-info: Remove unused refcount
      perf cpumap: Remove refcnt from 'struct cpu_aggr_map'
      perf comm: Add reference count checking to 'struct comm_str'
      perf mem-info: Move mem-info out of mem-events and symbol
      perf mem-info: Add reference count checking
      perf hist: Avoid 'struct hist_entry_iter' mem_info memory leak
      perf ui browser: Avoid SEGV on title
      perf comm: Fix comm_str__put() for reference count checking
      perf report: Avoid SEGV in report__setup_sample_type()
      perf thread: Fixes to thread__new() related to initializing comm
      perf tracepoint: Don't scan all tracepoints to test if one exists
      perf lock: Avoid memory leaks from strdup()
      libsubcmd: Fix parse-options memory leak
      perf stat: Don't display metric header for non-leader uncore events
      perf pmu: Count sys and cpuid JSON events separately

Ilkka Koskinen (1):
      perf vendor events arm64: AmpereOne/AmpereOneX: Mark L1D_CACHE_INVAL impacted by errata

James Clark (16):
      perf docs arm_spe: Clarify more SPE requirements related to KPTI
      perf tests: Make "test data symbol" more robust on Neoverse N1
      perf tests: Apply attributes to all events in object code reading test
      perf map: Remove kernel map before updating start and end addresses
      perf tests: Remove dependency on lscpu
      perf test shell arm_coresight: Increase buffer size for Coresight basic tests
      perf cs-etm: Use struct perf_cpu as much as possible
      perf cs-etm: Remove repeated fetches of the ETM PMU
      perf cs-etm: Improve version detection and error reporting
      perf cs-etm: Print error for new PERF_RECORD_AUX_OUTPUT_HW_ID versions
      perf auxtrace: Allow number of queues to be specified
      perf dwarf-aux: Fix build with HAVE_DWARF_CFI_SUPPORT
      perf symbols: Remove map from list before updating addresses
      perf maps: Re-use __maps__free_maps_by_name()
      perf symbols: Update kcore map before merging in remaining symbols
      perf symbols: Fix ownership of string in dso__load_vmlinux()

Madadi Vineeth Reddy (1):
      perf sched: Rename 'switches' column header to 'count' and add usage description, options for latency

Namhyung Kim (74):
      perf dwarf-aux: Remove unused pc argument
      perf dwarf-aux: Add die_collect_vars()
      perf dwarf-aux: Handle type transfer for memory access
      perf dwarf-aux: Add die_find_func_rettype()
      perf map: Add map__objdump_2rip()
      perf annotate-data: Introduce 'struct data_loc_info'
      perf annotate: Add annotate_get_basic_blocks()
      perf annotate-data: Add debug messages
      perf annotate-data: Maintain variable type info
      perf annotate-data: Add update_insn_state()
      perf annotate-data: Add get_global_var_type()
      perf annotate-data: Handle global variable access
      perf annotate-data: Handle call instructions
      perf annotate-data: Implement instruction tracking
      perf annotate-data: Check register state for type
      perf annotate: Parse x86 segment register location
      perf annotate-data: Handle this-cpu variables in kernel
      perf annotate-data: Track instructions with a this-cpu variable
      perf annotate-data: Support general per-cpu access
      perf annotate-data: Handle ADD instructions
      perf annotate-data: Add stack canary type
      perf annotate-data: Add a cache for global variable types
      perf annotate-data: Do not retry for invalid types
      perf annotate: Get rid of duplicate --group option item
      perf annotate: Honor output options with --data-type
      perf annotate: Use ins__is_xxx() if possible
      perf annotate: Add and use ins__is_nop()
      perf annotate: Split out util/disasm.c
      perf annotate: Use libcapstone to disassemble
      perf annotate: Add symbol name when using capstone
      perf annotate: Fix annotation_calc_lines() to pass correct address to get_srcline()
      perf annotate: Staticize some local functions
      perf annotate: Introduce annotated_source__get_line()
      perf annotate: Check annotation lines more efficiently
      perf annotate: Get rid of offsets array
      perf annotate: Move 'widths' struct to 'struct annotated_source'
      perf annotate: Move 'max_jump_sources' struct to 'struct annotated_source'
      perf annotate: Move nr_events struct to 'struct annotated_source'
      perf annotate: Move 'start' field struct to 'struct annotated_source'
      perf annotate-data: Fix global variable lookup
      perf annotate-data: Do not delete non-asm lines
      perf annotate: Get rid of symbol__ensure_annotate()
      perf annotate-data: Skip sample histogram for stack canary
      perf annotate: Show progress of sample processing
      perf annotate-data: Add hist_entry__annotate_data_tty()
      perf annotate-data: Add hist_entry__annotate_data_tui()
      perf annotate-data: Support event group display in TUI
      perf report: Add a menu item to annotate data type in TUI
      perf report: Do not collect sample histogram unnecessarily
      perf annotate: Skip DSOs not found
      perf annotate-data: Improve debug message with location info
      perf dwarf-aux: Check pointer offset when checking variables
      perf dwarf-aux: Check variable address range properly
      perf annotate-data: Handle RSP if it's not the FB register
      perf hist: Move histogram related code to hist.h
      perf hist: Add weight fields to hist entry stats
      perf report: Add weight[123] output fields
      perf test: Add a new test for 'perf annotate'
      perf annotate-data: Check if 'struct annotation_source' was allocated on 'perf report' TUI
      perf annotate: Fallback disassemble to objdump when capstone fails
      perf annotate: Update DSO binary type when trying build-id
      perf annotate: Fix data type profiling on stdio
      perf dwarf-aux: Add die_collect_global_vars()
      perf annotate-data: Collect global variables in advance
      perf annotate-data: Handle direct global variable access
      perf annotate-data: Check memory access with two registers
      perf annotate-data: Handle multi regs in find_data_type_block()
      perf annotate-data: Check kind of stack variables
      perf maps: Remove check_invariants() from maps__lock()
      perf dwarf-aux: Print array type name with "[]"
      perf tools: Ignore deleted cgroups
      perf annotate: Fix segfault on sample histogram
      perf annotate-data: Ensure the number of type histograms
      tools lib subcmd: Show parent options in help

Samasth Norway Ananda (1):
      perf daemon: Fix file leak in daemon_session__control

Sandipan Das (4):
      perf vendor events amd: Add Zen 5 core events
      perf vendor events amd: Add Zen 5 uncore events
      perf vendor events amd: Add Zen 5 metrics
      perf vendor events amd: Add Zen 5 mapping

Thomas Richter (2):
      perf report: Fix PAI counter names for s390 virtual machines
      perf stat: Do not fail on metrics on s390 z/VM systems

Weilin Wang (1):
      perf stat: Add new field in stat_config to enable hardware aware grouping

Yang Jihong (4):
      perf sched timehist: Fix -g/--call-graph option failure
      perf evsel: Use evsel__name_is() helper
      perf beauty: Fix AT_EACCESS undeclared build error for system with kernel versions lower than v5.8
      perf build: Add LIBTRACEEVENT_DIR build option

 .../testing/sysfs-bus-event_source-devices-events  |    6 +
 MAINTAINERS                                        |    1 +
 tools/arch/x86/include/asm/cpufeatures.h           |    7 +-
 tools/arch/x86/include/asm/msr-index.h             |    9 +-
 tools/include/linux/bits.h                         |    8 +-
 tools/include/linux/rbtree_augmented.h             |    4 +-
 tools/include/uapi/asm-generic/bitsperlong.h       |    4 +
 tools/include/uapi/asm-generic/fcntl.h             |  221 --
 tools/include/uapi/linux/bits.h                    |   15 +
 tools/include/uapi/linux/openat2.h                 |   43 -
 tools/lib/perf/cpumap.c                            |   33 +-
 tools/lib/perf/include/perf/cpumap.h               |   16 +
 tools/lib/perf/libperf.map                         |    4 +
 tools/lib/perf/mmap.c                              |    2 +-
 tools/lib/rbtree.c                                 |    2 +-
 tools/lib/subcmd/parse-options.c                   |   44 +-
 tools/lib/subcmd/run-command.c                     |   70 +-
 tools/lib/subcmd/run-command.h                     |    3 +
 tools/perf/Build                                   |   14 +
 tools/perf/Documentation/perf-arm-spe.txt          |   12 +-
 tools/perf/Documentation/perf-list.txt             |    1 +
 tools/perf/Documentation/perf-report.txt           |    9 +-
 tools/perf/Documentation/perf-sched.txt            |   36 +
 tools/perf/Documentation/perf-script.txt           |    7 +-
 tools/perf/Documentation/perf-test.txt             |   13 +-
 tools/perf/Makefile.config                         |   25 +-
 tools/perf/Makefile.perf                           |  100 +-
 tools/perf/arch/arm/util/cs-etm.c                  |  381 ++--
 tools/perf/arch/arm64/util/arm-spe.c               |    4 +-
 tools/perf/arch/arm64/util/header.c                |   13 +-
 tools/perf/arch/x86/Build                          |   14 +
 tools/perf/arch/x86/tests/Build                    |   14 +
 tools/perf/arch/x86/tests/gen-insn-x86-dat.sh      |    2 +-
 tools/perf/arch/x86/util/intel-bts.c               |    4 +-
 tools/perf/arch/x86/util/intel-pt.c                |   10 +-
 tools/perf/bench/bench.h                           |    2 +
 tools/perf/bench/inject-buildid.c                  |    2 +-
 tools/perf/bench/uprobe.c                          |   22 +-
 tools/perf/builtin-annotate.c                      |  128 +-
 tools/perf/builtin-bench.c                         |    2 +
 tools/perf/builtin-buildid-cache.c                 |    2 +-
 tools/perf/builtin-buildid-list.c                  |   18 +-
 tools/perf/builtin-c2c.c                           |   21 +-
 tools/perf/builtin-daemon.c                        |    4 +-
 tools/perf/builtin-inject.c                        |   96 +-
 tools/perf/builtin-kallsyms.c                      |    2 +-
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-kwork.c                         |    2 +-
 tools/perf/builtin-list.c                          |   24 +-
 tools/perf/builtin-lock.c                          |   18 +-
 tools/perf/builtin-mem.c                           |    4 +-
 tools/perf/builtin-probe.c                         |    2 +-
 tools/perf/builtin-record.c                        |   14 +-
 tools/perf/builtin-report.c                        |   18 +-
 tools/perf/builtin-sched.c                         |   13 +-
 tools/perf/builtin-script.c                        |   86 +-
 tools/perf/builtin-stat.c                          |   52 +-
 tools/perf/builtin-top.c                           |    4 +-
 tools/perf/builtin-trace.c                         |   35 +-
 tools/perf/builtin.h                               |    4 +-
 tools/perf/check-headers.sh                        |   23 +-
 tools/perf/perf-archive.sh                         |    2 +-
 tools/perf/perf-completion.sh                      |   23 +-
 tools/perf/perf.c                                  |   23 +-
 .../arch/arm64/ampere/ampereone/cache.json         |    4 +-
 .../arch/arm64/ampere/ampereonex/cache.json        |    4 +-
 .../pmu-events/arch/s390/cf_z16/transaction.json   |   28 +-
 tools/perf/pmu-events/arch/s390/mapfile.csv        |    2 +-
 .../arch/x86/amdzen5/branch-prediction.json        |   93 +
 tools/perf/pmu-events/arch/x86/amdzen5/decode.json |  115 +
 .../pmu-events/arch/x86/amdzen5/execution.json     |  174 ++
 .../arch/x86/amdzen5/floating-point.json           |  812 +++++++
 .../pmu-events/arch/x86/amdzen5/inst-cache.json    |   72 +
 .../perf/pmu-events/arch/x86/amdzen5/l2-cache.json |  266 +++
 .../perf/pmu-events/arch/x86/amdzen5/l3-cache.json |  177 ++
 .../pmu-events/arch/x86/amdzen5/load-store.json    |  451 ++++
 .../arch/x86/amdzen5/memory-controller.json        |  101 +
 .../perf/pmu-events/arch/x86/amdzen5/pipeline.json |   99 +
 .../pmu-events/arch/x86/amdzen5/recommended.json   |  345 +++
 .../arch/x86/broadwellx/bdx-metrics.json           |   35 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |   85 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   10 +-
 .../pmu-events/arch/x86/cascadelakex/memory.json   |    2 +-
 .../pmu-events/arch/x86/cascadelakex/other.json    |    2 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |    2 +-
 .../arch/x86/cascadelakex/uncore-interconnect.json |   14 +-
 .../arch/x86/cascadelakex/virtual-memory.json      |    2 +-
 .../arch/x86/emeraldrapids/frontend.json           |    2 +-
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |    1 +
 .../arch/x86/emeraldrapids/pipeline.json           |    3 +
 .../arch/x86/emeraldrapids/uncore-cache.json       |  112 +-
 .../x86/emeraldrapids/uncore-interconnect.json     |   26 +-
 .../pmu-events/arch/x86/grandridge/pipeline.json   |   43 +-
 .../arch/x86/grandridge/uncore-cache.json          |   28 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   35 +-
 .../pmu-events/arch/x86/icelakex/frontend.json     |    2 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |   95 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |    1 +
 .../pmu-events/arch/x86/icelakex/uncore-cache.json |   22 +-
 .../arch/x86/icelakex/uncore-interconnect.json     |   64 +-
 .../pmu-events/arch/x86/icelakex/uncore-io.json    |   11 -
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |   24 +-
 .../pmu-events/arch/x86/lunarlake/frontend.json    |    2 +-
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |    4 +-
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |    4 +-
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |  109 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   21 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   30 +
 .../pmu-events/arch/x86/meteorlake/frontend.json   |    4 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   20 +
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   42 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |   44 +-
 .../arch/x86/meteorlake/uncore-interconnect.json   |   22 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |    1 +
 .../arch/x86/sapphirerapids/frontend.json          |    2 +-
 .../pmu-events/arch/x86/sapphirerapids/memory.json |    1 +
 .../arch/x86/sapphirerapids/pipeline.json          |   19 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  119 +-
 .../arch/x86/sapphirerapids/uncore-cache.json      |  112 +-
 .../x86/sapphirerapids/uncore-interconnect.json    |   26 +-
 .../pmu-events/arch/x86/sierraforest/pipeline.json |   36 +-
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   10 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |    9 +
 .../pmu-events/arch/x86/skylakex/frontend.json     |   10 +-
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |    2 +-
 tools/perf/pmu-events/arch/x86/skylakex/other.json |    2 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |    2 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |   85 +-
 .../arch/x86/skylakex/uncore-interconnect.json     |   14 +-
 .../pmu-events/arch/x86/skylakex/uncore-io.json    |    2 +-
 .../arch/x86/skylakex/virtual-memory.json          |    2 +-
 .../arch/x86/snowridgex/uncore-cache.json          |    4 +-
 .../arch/x86/snowridgex/uncore-interconnect.json   |    6 +-
 .../pmu-events/arch/x86/snowridgex/uncore-io.json  |   11 -
 tools/perf/scripts/python/parallel-perf.py         |  988 ++++++++
 tools/perf/tests/bitmap.c                          |   13 +-
 tools/perf/tests/builtin-test.c                    |   62 +-
 tools/perf/tests/code-reading.c                    |   18 +-
 tools/perf/tests/config-fragments/config           |    3 +
 tools/perf/tests/dso-data.c                        |   67 +-
 tools/perf/tests/evsel-roundtrip-name.c            |    4 +-
 tools/perf/tests/hists_common.c                    |    6 +-
 tools/perf/tests/hists_cumulate.c                  |    4 +-
 tools/perf/tests/hists_output.c                    |    2 +-
 tools/perf/tests/maps.c                            |    4 +-
 tools/perf/tests/mem.c                             |   11 +-
 tools/perf/tests/parse-events.c                    |   58 +-
 tools/perf/tests/pmu-events.c                      |    4 +-
 tools/perf/tests/pmu.c                             |  467 ++--
 tools/perf/tests/shell/annotate.sh                 |   83 +
 .../tests/shell/base_probe/test_adding_kernel.sh   |    1 +
 tools/perf/tests/shell/lib/stat_output.sh          |    2 +-
 tools/perf/tests/shell/script.sh                   |   26 +-
 tools/perf/tests/shell/stat+json_output.sh         |    2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   75 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |    4 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    2 +-
 tools/perf/tests/symbols.c                         |    8 +-
 tools/perf/tests/topology.c                        |   46 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    6 +-
 tools/perf/tests/workloads/datasym.c               |   16 +
 tools/perf/trace/beauty/Build                      |   15 +
 .../beauty}/arch/x86/include/asm/irq_vectors.h     |    0
 .../beauty}/arch/x86/include/uapi/asm/prctl.h      |    0
 tools/perf/trace/beauty/arch_errno_names.sh        |    8 +-
 tools/perf/trace/beauty/beauty.h                   |    7 +-
 tools/perf/trace/beauty/clone.c                    |   46 +-
 tools/perf/trace/beauty/clone.sh                   |   17 +
 tools/perf/trace/beauty/fcntl.c                    |    2 +-
 tools/perf/trace/beauty/flock.c                    |    2 +-
 tools/perf/trace/beauty/fs_at_flags.c              |   58 +
 tools/perf/trace/beauty/fs_at_flags.sh             |   21 +
 tools/perf/trace/beauty/fsconfig.sh                |    6 +-
 tools/perf/trace/beauty/fsmount.c                  |    9 +-
 tools/perf/trace/beauty/fsmount.sh                 |    6 +-
 tools/perf/trace/beauty/fspick.sh                  |    6 +-
 .../trace/beauty}/include/uapi/linux/fcntl.h       |    0
 .../trace/beauty}/include/uapi/linux/fs.h          |    0
 .../trace/beauty}/include/uapi/linux/mount.h       |    0
 .../trace/beauty}/include/uapi/linux/prctl.h       |    0
 .../trace/beauty}/include/uapi/linux/sched.h       |    0
 tools/perf/trace/beauty/include/uapi/linux/stat.h  |  195 ++
 .../beauty}/include/uapi/linux/usbdevice_fs.h      |    0
 .../trace/beauty}/include/uapi/linux/vhost.h       |   20 +-
 .../trace/beauty}/include/uapi/sound/asound.h      |    0
 tools/perf/trace/beauty/mount_flags.sh             |    6 +-
 tools/perf/trace/beauty/move_mount_flags.sh        |    6 +-
 tools/perf/trace/beauty/prctl.c                    |    2 +-
 tools/perf/trace/beauty/prctl_option.sh            |    6 +-
 tools/perf/trace/beauty/rename_flags.sh            |    2 +-
 tools/perf/trace/beauty/sndrv_ctl_ioctl.sh         |    4 +-
 tools/perf/trace/beauty/sndrv_pcm_ioctl.sh         |    4 +-
 tools/perf/trace/beauty/statx.c                    |   67 +-
 tools/perf/trace/beauty/statx_mask.sh              |   23 +
 tools/perf/trace/beauty/sync_file_range.c          |   11 +-
 tools/perf/trace/beauty/sync_file_range.sh         |    2 +-
 .../trace/beauty/tracepoints/x86_irq_vectors.sh    |    6 +-
 tools/perf/trace/beauty/usbdevfs_ioctl.sh          |    6 +-
 tools/perf/trace/beauty/vhost_virtio_ioctl.sh      |    6 +-
 tools/perf/trace/beauty/x86_arch_prctl.sh          |    4 +-
 tools/perf/ui/browser.c                            |    6 +-
 tools/perf/ui/browser.h                            |    2 +-
 tools/perf/ui/browsers/Build                       |    1 +
 tools/perf/ui/browsers/annotate-data.c             |  313 +++
 tools/perf/ui/browsers/annotate.c                  |   21 +-
 tools/perf/ui/browsers/hists.c                     |   39 +-
 tools/perf/ui/browsers/map.c                       |    4 +-
 tools/perf/ui/hist.c                               |   92 +-
 tools/perf/util/Build                              |   16 +
 tools/perf/util/annotate-data.c                    | 1648 +++++++++++++-
 tools/perf/util/annotate-data.h                    |   74 +-
 tools/perf/util/annotate.c                         | 2378 +++++---------------
 tools/perf/util/annotate.h                         |  129 +-
 tools/perf/util/auxtrace.c                         |   19 +-
 tools/perf/util/auxtrace.h                         |    1 +
 tools/perf/util/block-info.c                       |   24 +-
 tools/perf/util/block-info.h                       |   15 +-
 tools/perf/util/bpf-event.c                        |    8 +-
 tools/perf/util/bpf_counter_cgroup.c               |    5 +-
 tools/perf/util/bpf_kwork.c                        |   16 +-
 tools/perf/util/bpf_kwork_top.c                    |   12 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |   21 +
 tools/perf/util/bpf_skel/bench_uprobe.bpf.c        |   16 +
 tools/perf/util/build-id.c                         |  136 +-
 tools/perf/util/build-id.h                         |    2 -
 tools/perf/util/callchain.c                        |    4 +-
 tools/perf/util/cgroup.c                           |    4 +-
 tools/perf/util/comm.c                             |  207 +-
 tools/perf/util/cpumap.c                           |   14 +-
 tools/perf/util/cpumap.h                           |    2 -
 tools/perf/util/cs-etm.c                           |    5 +-
 tools/perf/util/data-convert-json.c                |    2 +-
 tools/perf/util/db-export.c                        |    6 +-
 tools/perf/util/debug.c                            |    3 +
 tools/perf/util/debug.h                            |    1 +
 tools/perf/util/disasm.c                           | 1837 +++++++++++++++
 tools/perf/util/disasm.h                           |  112 +
 tools/perf/util/dlfilter.c                         |   12 +-
 tools/perf/util/dso.c                              |  472 ++--
 tools/perf/util/dso.h                              |  560 ++++-
 tools/perf/util/dsos.c                             |  529 +++--
 tools/perf/util/dsos.h                             |   40 +-
 tools/perf/util/dump-insn.h                        |    1 +
 tools/perf/util/dwarf-aux.c                        |  442 +++-
 tools/perf/util/dwarf-aux.h                        |   41 +-
 tools/perf/util/event.c                            |    8 +-
 tools/perf/util/evlist.c                           |    3 +-
 tools/perf/util/evsel.c                            |   20 +-
 tools/perf/util/evsel.h                            |    4 +-
 tools/perf/util/genelf.h                           |    3 +
 tools/perf/util/header.c                           |    8 +-
 tools/perf/util/help-unknown-cmd.c                 |   51 +-
 tools/perf/util/hist.c                             |   78 +-
 tools/perf/util/hist.h                             |  217 +-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |    2 +
 tools/perf/util/intel-pt.c                         |   24 +-
 tools/perf/util/machine.c                          |  227 +-
 tools/perf/util/machine.h                          |    4 +-
 tools/perf/util/map.c                              |   91 +-
 tools/perf/util/map.h                              |    3 +
 tools/perf/util/maps.c                             |   44 +-
 tools/perf/util/mem-events.c                       |   36 +-
 tools/perf/util/mem-events.h                       |   29 +-
 tools/perf/util/mem-info.c                         |   35 +
 tools/perf/util/mem-info.h                         |   54 +
 tools/perf/util/metricgroup.c                      |   10 +-
 tools/perf/util/metricgroup.h                      |    1 +
 tools/perf/util/parse-events.c                     |  522 ++---
 tools/perf/util/parse-events.h                     |   60 +-
 tools/perf/util/parse-events.l                     |  200 +-
 tools/perf/util/parse-events.y                     |  263 +--
 tools/perf/util/perf_event_attr_fprintf.c          |   26 +-
 tools/perf/util/pmu.c                              |  291 ++-
 tools/perf/util/pmu.h                              |   16 +-
 tools/perf/util/pmus.c                             |  110 +-
 tools/perf/util/pmus.h                             |    3 +
 tools/perf/util/print-events.c                     |   55 +-
 tools/perf/util/print_insn.c                       |   75 +-
 tools/perf/util/print_insn.h                       |    8 +-
 tools/perf/util/probe-event.c                      |   32 +-
 tools/perf/util/python.c                           |   10 +
 tools/perf/util/record.c                           |    2 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    6 +-
 .../util/scripting-engines/trace-event-python.c    |   45 +-
 tools/perf/util/session.c                          |   26 +-
 tools/perf/util/session.h                          |    2 +
 tools/perf/util/sort.c                             |  116 +-
 tools/perf/util/sort.h                             |  190 +-
 tools/perf/util/srcline.c                          |   65 +-
 tools/perf/util/stat-display.c                     |    3 +
 tools/perf/util/stat.c                             |    2 +-
 tools/perf/util/stat.h                             |    1 +
 tools/perf/util/svghelper.c                        |   20 +-
 tools/perf/util/symbol-elf.c                       |  145 +-
 tools/perf/util/symbol-minimal.c                   |    4 +-
 tools/perf/util/symbol.c                           |  261 +--
 tools/perf/util/symbol.h                           |   12 -
 tools/perf/util/symbol_fprintf.c                   |    4 +-
 tools/perf/util/synthetic-events.c                 |   24 +-
 tools/perf/util/thread.c                           |   18 +-
 tools/perf/util/tracepoint.c                       |   56 +-
 tools/perf/util/tracepoint.h                       |    3 +-
 tools/perf/util/unwind-libunwind-local.c           |   18 +-
 tools/perf/util/unwind-libunwind.c                 |    2 +-
 tools/perf/util/values.h                           |    1 +
 tools/perf/util/vdso.c                             |   56 +-
 306 files changed, 15214 insertions(+), 6278 deletions(-)
 delete mode 100644 tools/include/uapi/asm-generic/fcntl.h
 create mode 100644 tools/include/uapi/linux/bits.h
 delete mode 100644 tools/include/uapi/linux/openat2.h
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
 create mode 100755 tools/perf/scripts/python/parallel-perf.py
 create mode 100755 tools/perf/tests/shell/annotate.sh
 rename tools/{ => perf/trace/beauty}/arch/x86/include/asm/irq_vectors.h (100%)
 rename tools/{ => perf/trace/beauty}/arch/x86/include/uapi/asm/prctl.h (100%)
 create mode 100755 tools/perf/trace/beauty/clone.sh
 create mode 100644 tools/perf/trace/beauty/fs_at_flags.c
 create mode 100755 tools/perf/trace/beauty/fs_at_flags.sh
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fcntl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fs.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/mount.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/prctl.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/sched.h (100%)
 create mode 100644 tools/perf/trace/beauty/include/uapi/linux/stat.h
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/vhost.h (97%)
 rename tools/{ => perf/trace/beauty}/include/uapi/sound/asound.h (100%)
 create mode 100755 tools/perf/trace/beauty/statx_mask.sh
 create mode 100644 tools/perf/ui/browsers/annotate-data.c
 create mode 100644 tools/perf/util/disasm.c
 create mode 100644 tools/perf/util/disasm.h
 create mode 100644 tools/perf/util/mem-info.c
 create mode 100644 tools/perf/util/mem-info.h
