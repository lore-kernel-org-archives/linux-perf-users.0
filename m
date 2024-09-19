Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCE1DFF7;
	Thu, 19 Sep 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726756425; cv=none; b=hXxRHOQHuiVqJ8ivGXAHnchB0E/03ptxTKwG6KBhNZoSv2yr61A6dd1f9GVwvcgOQFNKpGHZdx/qIFF7aiEBWQ/C8v3+oypSehMEIc5jomfVuX/1e6G1lyluHzAWT+CzLaQiOZbE32nnpZlqnIYc5AdbEtErq3MwG992r+hGe08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726756425; c=relaxed/simple;
	bh=FFg/B61HY2yapQbcaRnwHNentoI2I1oJiOXwE5ZGEEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JAhGSeDfFFRzjUlmz9NDV21zqD81I0u37asUxCsdWuanG2QcQXUpACO9O/53tEdGoWGXTtQlSXLzTfODWfGWjFH3Pc/1vfVPYe1zyrUyfmFYWqNRIckxT0Z5RbeqXLj2Drm/M12wDVfn7qEXoYyndnVzsvjmAR9tGtER+TxKLFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnZIedEM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnZIedEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79306C4CEC4;
	Thu, 19 Sep 2024 14:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726756424;
	bh=FFg/B61HY2yapQbcaRnwHNentoI2I1oJiOXwE5ZGEEc=;
	h=From:To:Cc:Subject:Date:From;
	b=QnZIedEMcMn450op61Blg/iibaUzjHWmpxaohABjMTin5sZy+U0jFBom/sbCvFbZT
	 VDzbgxY6Iiq55oUL9EaakinVdGxMavFKtY5WX152u4/09E98QUWvrBy/EH9XfErHM1
	 peUCtco5+wcWi6tnezrUaWtyVJBwAus5keK2cGcspQRETt9xg5gcq8vRsMXzcMYm8p
	 QYHByh/u6hKzWRmDmTU+dyQjTUZLzd4PiK6ojERPNGFEpleGLKmah69rrf1X3/dI00
	 JZea7FhOANaMkYSwhcuAel9Mgnryycl0OPaqsO/gXMLY4IAYg0TdAuidQd4HreVYVJ
	 zTG7PsPrdcLsw==
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
	Andi Kleen <ak@linux.intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Brian Norris <briannorris@chromium.org>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Chen Ni <nichen@iscas.ac.cn>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Disha Goel <disgoel@linux.ibm.com>,
	"Dr . David Alan Gilbert" <linux@treblig.org>,
	Howard Chu <howardchu95@gmail.com>,
	James Clark <james.clark@linaro.org>,
	Kajol Jain <kjain@linux.ibm.com>,
	Leo Yan <leo.yan@arm.com>,
	Martin Liska <martin.liska@hey.com>,
	Song Liu <song@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Zixian Cai <fzczx123@gmail.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.12
Date: Thu, 19 Sep 2024 16:33:29 +0200
Message-ID: <20240919143330.492157-1-acme@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit b831f83e40a24f07c8dcba5be408d93beedc820f:

  Merge tag 'bpf-6.11-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf (2024-09-05 20:10:53 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.12-1-2024-09-19

for you to fetch changes up to 1de5b5dcb8353f36581c963df2d359a5f151a0be:

  perf trace: Mark the 'head' arg in the set_robust_list syscall as coming from user space (2024-09-11 17:25:45 -0300)

----------------------------------------------------------------
perf tools improvements and fixes for v6.12:

- Use BPF + BTF to collect and pretty print syscall and tracepoint arguments in
  'perf trace', done as an GSoC activity.

- Data-type profiling improvements:

  - Cache debuginfo to speed up data type resolution.

  - Add the 'typecln' sort order, to show which cacheline in a target is hot or
    cold. The following shows members in the cfs_rq's first cache line:

      $ perf report -s type,typecln,typeoff -H
      ...
      -    2.67%        struct cfs_rq
         +    1.23%        struct cfs_rq: cache-line 2
         +    0.57%        struct cfs_rq: cache-line 4
         +    0.46%        struct cfs_rq: cache-line 6
         -    0.41%        struct cfs_rq: cache-line 0
                 0.39%        struct cfs_rq +0x14 (h_nr_running)
                 0.02%        struct cfs_rq +0x38 (tasks_timeline.rb_leftmost)

  - When a typedef resolves to a unnamed struct, use the typedef name.

  - When a struct has just one basic type field (int, etc), resolve the type
    sort order to the name of the struct, not the type of the field.

  - Support type folding/unfolding in the data-type annotation TUI.

  - Fix bitfields offsets and sizes.

  - Initial support for PowerPC, using libcapstone and the usual objdump
    disassembly parsing routines.

- Add support for disassembling and addr2line using the LLVM libraries,
  speeding up those operations.

- Support --addr2line option in 'perf script' as with other tools.

- Intel branch counters (LBR event logging) support, only available in recent
  Intel processors, for instance, the new "brcntr" field can be asked from
  'perf script' to print the information collected from this feature:

  $ perf script -F +brstackinsn,+brcntr

  # Branch counter abbr list:
  # branch-instructions:ppp = A
  # branch-misses = B
  # '-' No event occurs
  # '+' Event occurrences may be lost due to branch counter saturated
      tchain_edit  332203 3366329.405674:  53030 branch-instructions:ppp:    401781 f3+0x2c (home/sdp/test/tchain_edit)
         f3+31:
      0000000000401774   insn: eb 04                  br_cntr: AA  # PRED 5 cycles [5]
      000000000040177a   insn: 81 7d fc 0f 27 00 00
      0000000000401781   insn: 7e e3                  br_cntr: A   # PRED 1 cycles [6] 2.00 IPC
      0000000000401766   insn: 8b 45 fc
      0000000000401769   insn: 83 e0 01
      000000000040176c   insn: 85 c0
      000000000040176e   insn: 74 06                  br_cntr: A   # PRED 1 cycles [7] 4.00 IPC
      0000000000401776   insn: 83 45 fc 01
      000000000040177a   insn: 81 7d fc 0f 27 00 00
      0000000000401781   insn: 7e e3                  br_cntr: A   # PRED 7 cycles [14] 0.43 IPC

- Support Timed PEBS (Precise Event-Based Sampling), a recent hardware feature
  in Intel processors.

- Add 'perf ftrace profile' subcommand, using ftrace's function-graph tracer so
  that users can see the total, average, max execution time as well as the
  number of invocations easily, for instance:

  $ sudo perf ftrace profile -G __x64_sys_perf_event_open -- \
    perf stat -e cycles -C1 true 2> /dev/null | head
  # Total (us)  Avg (us)  Max (us)  Count  Function
        65.611    65.611    65.611      1  __x64_sys_perf_event_open
        30.527    30.527    30.527      1  anon_inode_getfile
        30.260    30.260    30.260      1  __anon_inode_getfile
        29.700    29.700    29.700      1  alloc_file_pseudo
        17.578    17.578    17.578      1  d_alloc_pseudo
        17.382    17.382    17.382      1  __d_alloc
        16.738    16.738    16.738      1  kmem_cache_alloc_lru
        15.686    15.686    15.686      1  perf_event_alloc
        14.012     7.006    11.264      2  obj_cgroup_charge
  #

- 'perf sched timehist' improvements, including the addition of priority
  showing/filtering command line options.

- Varios improvements to the 'perf probe', including 'perf test' regression
  testings.

- Introduce the 'perf check', initially to check if some feature is in place,
  using it in 'perf test'.

- Various fixes for 32-bit systems.

- Address more leak sanitizer failures.

- Fix memory leaks (LBR, disasm lock ops, etc).

- More reference counting fixes (branch_info, etc).

- Constify 'struct perf_tool' parameters to improve code generation and reduce
  the chances of having its internals changed, which isn't expected.

- More constifications in various other places.

- Add more build tests, including for JEVENTS.

- Add more 'perf test' entries ('perf record LBR', pipe/inject, --setup-filter,
  'perf ftrace', 'cgroup sampling', etc).

- Inject build ids for all entries in a call chain in 'perf inject', not just
  for the main sample.

- Improve the BPF based sample filter, allowing root to setup filters in bpffs
  that then can be used by non-root users.

- Allow filtering by cgroups with the BPF based sample filter.

- Allow a more compact way for 'perf mem report' using the -T/--type-profile and
  also provide a --sort option similar to the one in 'perf report', 'perf top',
  to setup the sort order manually.

- Fix --group behavior in 'perf annotate' when leader has no samples, where it
  was not showing anything even when other events in the group had samples.

- Fix spinlock and rwlock accounting in 'perf lock contention'

- Fix libsubcmd fixdep Makefile dependencies.

- Improve 'perf ftrace' error message when ftrace isn't available.

- Update various Intel JSON vendor event files.

- ARM64 CoreSight hardware tracing infrastructure improvements, mostly not
  visible to users.

- Update power10 JSON events.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Aditya Gupta (5):
      libsubcmd: Don't free the usage string
      perf check: Introduce 'check' subcommand
      perf version: Update --build-options to use 'supported_features' array
      perf tools test_task_analyzer.sh: Update to use 'perf check feature'
      perf check: Fix inconsistencies in feature names

Adrian Hunter (2):
      perf tools: Enable evsel__is_aux_event() to work for ARM/ARM64
      perf tools: Enable evsel__is_aux_event() to work for S390_CPUMSF

Alexander Gordeev (1):
      tools build: Provide consistent build options for fixdep

Andi Kleen (4):
      perf tools: Create source symlink in perf object dir
      perf test: Support external tests for separate objdir
      perf script: Minimize "not reaching sample" for '-F +brstackinsn'
      perf script python: Avoid buffer overflow in python PEBS register interface

Andrew Kreimer (1):
      perf help: Fix a typo ("bellow")

Arnaldo Carvalho de Melo (33):
      perf trace: Introduce trace__btf_scnprintf()
      perf trace: Remove arg_fmt->is_enum, we can get that from the BTF type
      perf bpf: Move BPF disassembly routines to separate file to avoid clash with capstone bpf headers
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf tests ftrace: Add pattern check for time, count
      perf test shell lbr: Support hybrid x86 systems too
      perf debuginfo: Fix the build with !HAVE_DWARF_SUPPORT
      perf tests pmu: Initialize all fields of test_pmu variable
      perf build: Fix up broken capstone feature detection fast path
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf daemon: Fix the build on more 32-bit architectures
      perf python: Allow checking for the existence of warning options in clang
      perf python: Disable -Wno-cast-function-type-mismatch if present on clang
      perf test vfs_getname: Look for alternative line where to collect the pathname
      perf trace: Pass the richer 'struct syscall_arg' pointer to trace__btf_scnprintf()
      tools build: Remove leftover libcap tests that prevents fast path feature detection from working
      Revert "tools build: Remove leftover libcap tests that prevents fast path feature detection from working"
      perf tools: Build x86 32-bit syscall table from arch/x86/entry/syscalls/syscall_32.tbl
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf trace augmented_syscalls.bpf: Move the renameat aumenter to renameat2, temporarily
      perf trace: Use a common encoding for augmented arguments, with size + error + payload
      perf trace: Mark which syscall arguments go from user space to kernel space
      perf trace: Introduce SCA_PERF_ATTR_FROM_USER() to set .from_user = true
      perf trace: Introduce SCA_SOCKADDR_FROM_USER() to set .from_user = true
      perf trace: Introduce SCA_TIMESPEC_FROM_USER() to set .from_user = true
      perf trace: Mark bpf's attr as from_user
      perf trace: Support collecting 'union's with the BPF augmenter
      perf trace: Mark the rlim arg in the prlimit64 and setrlimit syscalls as coming from user space
      perf trace: If a syscall arg is marked as 'const', assume it is coming _from_ userspace
      perf build: Require at least clang 16.0.6 to build BPF skeletons
      perf test shell probe_vfs_getname: Remove extraneous '=' from probe line number regex
      perf trace: Mark the 'rseq' arg in the rseq syscall as coming from user space
      perf trace: Mark the 'head' arg in the set_robust_list syscall as coming from user space

Athira Rajeev (16):
      perf annotate: Move the data structures related to register type to header file
      perf annotate: Add "update_insn_state" callback function to handle arch specific instruction tracking
      perf annotate: Update TYPE_STATE_MAX_REGS to include max of regs in powerpc
      perf annotate: Add disasm_line__parse() to parse raw instruction for powerpc
      perf annotate: Add support to capture and parse raw instruction in powerpc using dso__data_read_offset utility
      perf annotate: Update parameters for reg extract functions to use raw instruction on powerpc
      perf annotate: Add parse function for memory instructions in powerpc
      perf annotate: Add support to identify memory instructions of opcode 31 in powerpc
      perf annotate: Add some of the arithmetic instructions to support instruction tracking in powerpc
      perf annotate: Add more instructions for instruction tracking
      perf annotate: Update instruction tracking for powerpc
      perf annotate: Make capstone_init non-static so that it can be used during symbol disassemble
      perf annotate: Use capstone_init and remove open_capstone_handle from disasm.c
      perf annotate: Add support to use libcapstone in powerpc
      perf annotate: Set instruction name to be used with insn-stat when using raw instruction
      perf tests probe_vfs_getname.sh: Update to use 'perf check feature'

Brian Norris (3):
      tools build: Correct libsubcmd fixdep dependencies
      tools build: Avoid circular .fixdep-in.o.cmd issues
      tools build: Correct bpf fixdep dependencies

Changbin Du (1):
      perf ftrace: Detect whether ftrace is enabled on system

Charlie Jenkins (1):
      libperf: Add gitignore

Chen Ni (3):
      perf annotate: Convert comma to semicolon
      perf daemon: Convert comma to semicolon
      perf inject: Convert comma to semicolon

Dr. David Alan Gilbert (1):
      perf test pmu: Remove unused test_pmus

Howard Chu (12):
      perf trace: BTF-based enum pretty printing for syscall args
      perf trace: Augment non-syscall tracepoints with enum arguments with BTF
      perf trace: Filter enum arguments with enum names
      perf test: Add landlock workload
      perf test trace_btf_enum: Add regression test for the BTF augmentation of enums in 'perf trace'
      perf evlist: Introduce method to find if there is a bpf-output event
      perf trace: Fix perf trace -p <PID>
      perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
      perf trace: Pretty print struct data
      perf trace: Pretty print buffer data
      perf trace: Collect augmented data using BPF
      perf trace: Add --force-btf for debugging

Ian Rogers (81):
      perf test: Avoid python leak sanitizer test failures
      perf jevents: Use name for special find value (PMU_EVENTS__NOT_FOUND)
      perf jevents: Autogenerate empty-pmu-events.c
      perf python: Remove PYTHON_PERF ifdefs
      perf test: Add build test for JEVENTS_ARCH=all
      perf pmu-events: Change dependencies for empty-pmu-events.c test
      perf pmu-events: Remove duplicated ampereone event
      perf jevents.py: Ensure event names aren't duplicated
      perf hist: Fix reference counting of branch_info
      perf callchain: Fix stitch LBR memory leaks
      perf test: Add set of perf record LBR tests
      perf vendor events: SKX, CLX, SNR uncore cache event fixes
      perf inject: Fix leader sampling inserting additional samples
      perf auxtrace: Remove dummy tools
      perf s390-cpumsf: Remove unused struct
      perf tool: Constify tool pointers
      perf tool: Move fill defaults into tool.c
      perf tool: Add perf_tool__init()
      perf kmem: Use perf_tool__init
      perf buildid-list: Use perf_tool__init
      perf kvm: Use perf_tool__init()
      perf lock: Use perf_tool__init()
      perf evlist: Use perf_tool__init()
      perf record: Use perf_tool__init()
      perf c2c: Use perf_tool__init()
      perf script: Use perf_tool__init()
      perf inject: Use perf_tool__init()
      perf report: Use perf_tool__init()
      perf stat: Use perf_tool__init()
      perf annotate: Use perf_tool__init()
      perf sched: Use perf_tool__init()
      perf mem: Use perf_tool__init()
      perf timechart: Use perf_tool__init()
      perf diff: Use perf_tool__init()
      perf data convert json: Use perf_tool__init()
      perf data convert ctf: Use perf_tool__init()
      perf test event_update: Ensure tools is initialized
      perf kwork: Use perf_tool__init()
      perf tool: Remove perf_tool__fill_defaults()
      perf session: Constify tool
      perf parse-events: Add a retirement latency modifier
      perf callchain: Add a for_each callback style API
      perf inject: Inject build ids for entire call chain
      perf disasm: Fix memory leak for locked operations
      perf test annotate: Dump trapping test in trap handler
      perf synthetic-events: Avoid unnecessary memset
      perf map: API clean up
      perf jit: Constify filename argument
      perf dso: Constify dso_id
      perf evsel: Constify evsel__id_hdr_size() argument
      perf test: Expand pipe/inject test
      perf inject: Combine build_ids and build_id_all into enum
      perf inject: Combine different mmap and mmap2 functions
      perf inject: Combine mmap and mmap2 handling
      perf cap: Tidy up and improve capability testing
      perf report: Name events in stats for pipe mode
      perf session: Document 'struct perf_session' and constify its 'auxtrace' member
      perf header: Add kerneldoc to 'struct perf_file_header'
      perf header: Fail read if header sections overlap
      perf header: Allow attributes to be written after data
      perf inject: Overhaul handling of pipe files
      perf header: Remove repipe option
      perf test: Additional pipe tests with pipe output written to a file
      perf pmus: Fix name comparisons on 32-bit systems
      perf time-utils: Fix 32-bit nsec parsing
      perf test: Skip uprobe test if probe command isn't present
      perf test: Make watchpoint data 32-bits on i386
      perf pmu: Merge boolean sysfs event option parsing
      perf parse-events: Pass cpu_list as a perf_cpu_map in __add_event()
      perf parse-events: Add default_breakpoint_len helper
      perf parse-events: Vary default_breakpoint_len on i386 and arm64
      perf jevents: Add cpuid to model lookup command
      perf jevents: Ignore sys when determining a model directory
      perf inject: Fix build ID injection
      perf inject: Add new mmap2-buildid-all option
      perf inject: Lazy build-id mmap2 event insertion
      perf callchain: Allow symbols to be optional when resolving a callchain
      perf list: Avoid potential out of bounds memory read
      perf pmus: Fake PMU clean up
      perf evsel: Add accessor for tool_event
      perf pmu: To info add event_type_desc

James Clark (12):
      perf cs-etm: Output 0 instead of 0xdeadbeef when exception packets are flushed
      perf scripts python cs-etm: Restore first sample log in verbose mode
      perf test trace_btf_enum: Fix shellcheck warning
      perf cs-etm: Create decoders after both AUX and HW_ID search passes
      perf: cs-etm: Allocate queues for all CPUs
      perf: cs-etm: Move traceid_list to each queue
      perf: cs-etm: Create decoders based on the trace ID mappings
      perf: cs-etm: Only save valid trace IDs into files
      perf: cs-etm: Support version 0.1 of HW_ID packets
      perf: cs-etm: Print queue number in raw trace dump
      perf build: Autodetect minimum required llvm-dev version
      perf build: Remove unused feature test target

Kajol Jain (4):
      perf vendor events power10: Update JSON/events
      perf vendor events power10: Update JSON/events
      perf vendor events power10: Move the JSON/events
      perf vendor events: Move PM_BR_MPRED_CMPL event for power10 platform

Kan Liang (15):
      perf report: Fix --total-cycles --stdio output error
      perf report: Remove the first overflow check for branch counters
      perf evlist: Save branch counters information
      perf annotate: Save branch counters for each block
      perf evsel: Assign abbr name for the branch counter events
      perf report: Display the branch counter histogram
      perf annotate: Display the branch counter histogram
      perf script: Add branch counters
      perf test: Add new test cases for the branch counter feature
      perf hist: Don't set hpp_fmt_value for members in --no-group
      perf mem: Check mem_events for all eligible PMUs
      perf mem: Fix missed p-core mem events on ADL and RPL
      perf mem: Fix the wrong reference in parse_record_events()
      perf evlist: Print hint for group
      perf env: Find correct branch counter info on hybrid

Leo Yan (5):
      perf arm-spe: Extract evsel setting up
      perf arm-spe: Support multiple Arm SPE events
      perf docs: Refine the description for the buffer size
      perf auxtrace: Use evsel__is_aux_event() for checking AUX event
      perf auxtrace: Remove unused 'pmu' pointer from struct auxtrace_record

Lucas Stach (1):
      perf vendor events arm64: Move Yitian 710 DDR PMU into T-Head directory

Martin Liška (1):
      perf script: add --addr2line option

Matt Fleming (1):
      perf hist: Update hist symbol when updating maps

Michael Petlan (2):
      perf tests shell: Skip base_* dirs in test script search
      perf testsuite: Install perf-report tests in the 'make install-tests -C tools/perf' target

Namhyung Kim (73):
      perf ftrace: Add 'tail' option to --graph-opts
      perf ftrace: Factor out check_ftrace_capable()
      perf ftrace: Add 'profile' command
      perf ftrace profile: Add -s/--sort option
      perf bpf-filter: Make filters map a single entry hashmap
      perf bpf-filter: Pass 'target' to perf_bpf_filter__prepare()
      perf bpf-filter: Split per-task filter use case
      perf bpf-filter: Support pin/unpin BPF object
      perf bpf-filter: Support separate lost counts for each filter
      perf record: Fix a potential error handling issue
      perf record: Add --setup-filter option
      perf test: Update sample filtering test
      perf hist: Correct hist_entry->mem_info refcounts
      perf mem: Free the allocated sort string, fixing a leak
      perf mem: Rework command option handling
      perf tools: Add mode argument to sort_help()
      perf mem: Add -s/--sort option
      perf mem: Add -T/--data-type option to report subcommand
      perf mem: Update documentation for new options
      perf annotate: Use al->data_nr if possible
      perf annotate: Set notes->src->nr_events early
      perf annotate: Use annotation__pcnt_width() consistently
      perf annotate: Set al->data_nr using the notes->src->nr_events
      perf annotate: Add --skip-empty option
      perf annotate: Cache debuginfo for data type profiling
      perf annotate-data: Show typedef names properly
      perf test: Add a new shell test for perf ftrace
      perf annotate: Fix --group behavior when leader has no samples
      perf annotate-data: Support --skip-empty option
      perf annotate-data: Fix a buffer overflow in TUI browser
      perf lock contention: Change stack_id type to s32
      perf annotate-data: Support folding in TUI browser
      perf annotate-data: Implement folding in TUI browser
      perf annotate-data: Show first-level children by default in TUI
      perf dwarf-aux: Check allowed location expressions when collecting variables
      perf annotate-data: Fix off-by-one in location range check
      perf annotate-data: Add 'enum type_match_result'
      perf annotate-data: Add variable_state_str()
      perf annotate-data: Change return type of find_data_type_block()
      perf annotate-data: Add is_pointer_type() helper
      perf annotate-data: Add is_better_type() helper
      perf annotate-data: Check variables in every scope
      perf annotate-data: Update type stat at the end of find_data_type_die()
      perf record: Fix sample cgroup & namespace tracking
      perf test: Add cgroup sampling test
      perf annotate-data: Set bitfield member offset and size properly
      perf annotate-data: Fix missing constant copy
      perf annotate-data: Prefer struct/union over base type
      perf annotate-data: Fix percpu pointer check
      perf annotate-data: Show offset and size in hex
      perf annotate-data: Add 'typecln' sort key
      perf dwarf-aux: Handle bitfield members from pointer access
      perf annotate-data: Update debug messages
      perf annotate-data: Update stack slot for the store
      perf annotate-data: Copy back variable types after move
      perf bpf-filter: Support multiple events properly
      perf tools: Print lost samples due to BPF filter
      perf test: Update sample filtering tests with multiple events
      perf report: Fix segfault when 'sym' sort key is not used
      perf bpf-filter: Add build dependency to header files
      perf bpf-filter: Support filtering on cgroups
      perf test: Add 'perf record cgroup' filtering test
      perf lock contention: Handle error in a single place
      perf lock contention: Simplify spinlock check
      perf lock contention: Do not fail EEXIST for update
      perf lock contention: Fix spinlock and rwlock accounting
      perf stat: Constify control data for BPF
      perf ftrace latency: Constify control data for BPF
      perf kwork: Constify control data for BPF
      perf lock contention: Constify control data for BPF
      perf record offcpu: Constify control data for BPF
      perf annotate: Treat 'call' instruction as stack operation
      perf annotate-data: Add pr_debug_scope()

Sam James (1):
      tools: Drop nonsensical -O6

Steinar H. Gunderson (3):
      perf report: Support LLVM for addr2line()
      perf annotate: Split out read_symbol()
      perf annotate: LLVM-based disassembler

Tiezhu Yang (2):
      perf tools: Fix wrong message when running "make JOBS=1"
      perf list: Give clues if failed to open tracing events directory

Veronika Molnarova (11):
      perf test pmu: Set uninitialized PMU alias to null
      perf test record.sh: Raise limit of open file descriptors
      perf testsuite: Merge settings files for shell tests
      perf testsuite: Fix shellcheck warnings
      perf testsuite probe: Add test for blacklisted kprobes handling
      perf testsuite probe: Add test for basic perf-probe options
      perf testsuite probe: Add test for invalid options
      perf testsuite probe: Add test for line semantics
      perf testsuite: Add common output checking helper
      perf testsuite report: Add test for perf-report basic functionality
      perf testsuite report: Add test case for perf report

Weilin Wang (7):
      perf test: make metric validation test return early when there is no metric supported on the test system
      perf data: Allow to use given fd in data->file.fd
      perf stat: Fork and launch 'perf record' when 'perf stat' needs to get retire latency value for a metric.
      perf vendor events intel: Add MTL metric JSON files
      perf stat: Add command line option for enabling TPEBS recording
      perf Document: Add TPEBS (Timed PEBS(Precise Event-Based Sampling)) to Documents
      perf test: Add test for Intel TPEBS counting mode

Xu Yang (1):
      perf python: Fix the build on 32-bit arm by including missing "util/sample.h"

Yang Jihong (6):
      perf sched timehist: Fix missing free of session in perf_sched__timehist()
      perf sched timehist: Fixed timestamp error when unable to confirm event sched_in time
      perf sched timehist: Skip print non-idle task samples when only show idle events
      perf sched timehist: Remove redundant BUG_ON in timehist_sched_change_event()
      perf sched timehist: Add --show-prio option
      perf sched timehist: Add --prio option

Yang Li (1):
      perf parse-events: Remove duplicated include in parse-events.c

Yang Ruibin (1):
      perf bpf: Remove redundant check that map is NULL

Yicong Yang (1):
      perf stat: Display iostat headers correctly

Zixian Cai (1):
      perf script python: Add the 'ins_lat' field to event handler

 tools/build/Build                                  |    3 -
 tools/build/Makefile                               |   11 +-
 tools/build/Makefile.feature                       |    2 +-
 tools/build/Makefile.include                       |   12 +-
 tools/build/feature/Makefile                       |   11 +-
 tools/build/feature/test-all.c                     |    4 -
 tools/build/feature/test-llvm-perf.cpp             |   14 +
 tools/include/linux/coresight-pmu.h                |   17 +-
 tools/include/linux/string.h                       |    2 +
 tools/lib/api/Makefile                             |    4 -
 tools/lib/api/fs/tracing_path.c                    |    2 +-
 tools/lib/bpf/.gitignore                           |    1 +
 tools/lib/bpf/Makefile                             |   13 +-
 tools/lib/perf/.gitignore                          |    5 +
 tools/lib/string.c                                 |   13 +
 tools/lib/subcmd/Makefile                          |    6 +-
 tools/lib/subcmd/parse-options.c                   |    8 +-
 tools/lib/symbol/Makefile                          |    4 -
 tools/perf/Build                                   |    1 +
 tools/perf/Documentation/perf-annotate.txt         |    3 +
 tools/perf/Documentation/perf-check.txt            |   82 +
 tools/perf/Documentation/perf-ftrace.txt           |   48 +-
 tools/perf/Documentation/perf-kvm.txt              |    6 +-
 tools/perf/Documentation/perf-list.txt             |    1 +
 tools/perf/Documentation/perf-mem.txt              |   94 +-
 tools/perf/Documentation/perf-record.txt           |   14 +-
 tools/perf/Documentation/perf-report.txt           |    1 +
 tools/perf/Documentation/perf-sched.txt            |    9 +
 tools/perf/Documentation/perf-script.txt           |    5 +-
 tools/perf/Documentation/perf-stat.txt             |    8 +
 tools/perf/Documentation/perf-top.txt              |    4 +-
 tools/perf/Documentation/perf-trace.txt            |    4 +-
 tools/perf/Documentation/topdown.txt               |   30 +
 tools/perf/Makefile                                |    8 +-
 tools/perf/Makefile.config                         |   51 +-
 tools/perf/Makefile.perf                           |    6 +
 tools/perf/arch/arm/util/cs-etm.c                  |   12 +-
 tools/perf/arch/arm/util/pmu.c                     |    3 +
 tools/perf/arch/arm64/annotate/instructions.c      |    3 +-
 tools/perf/arch/arm64/util/arm-spe.c               |  108 +-
 tools/perf/arch/arm64/util/hisi-ptt.c              |    1 -
 tools/perf/arch/loongarch/annotate/instructions.c  |    6 +-
 tools/perf/arch/powerpc/annotate/instructions.c    |  254 ++
 tools/perf/arch/powerpc/util/dwarf-regs.c          |   53 +
 tools/perf/arch/s390/annotate/instructions.c       |    5 +-
 tools/perf/arch/x86/Makefile                       |    6 +-
 tools/perf/arch/x86/annotate/instructions.c        |  389 +++
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl  |  470 ++++
 tools/perf/arch/x86/util/event.c                   |    4 +-
 tools/perf/arch/x86/util/evlist.c                  |    6 +
 tools/perf/arch/x86/util/intel-bts.c               |    1 -
 tools/perf/arch/x86/util/intel-pt.c                |    1 -
 tools/perf/bench/synthesize.c                      |    2 +-
 tools/perf/builtin-annotate.c                      |   77 +-
 tools/perf/builtin-buildid-list.c                  |   10 +
 tools/perf/builtin-c2c.c                           |   47 +-
 tools/perf/builtin-check.c                         |  180 ++
 tools/perf/builtin-daemon.c                        |    2 +-
 tools/perf/builtin-diff.c                          |   38 +-
 tools/perf/builtin-evlist.c                        |   18 +-
 tools/perf/builtin-ftrace.c                        |  462 +++-
 tools/perf/builtin-help.c                          |    2 +-
 tools/perf/builtin-inject.c                        |  739 +++---
 tools/perf/builtin-kmem.c                          |   22 +-
 tools/perf/builtin-kvm.c                           |   22 +-
 tools/perf/builtin-kwork.c                         |   36 +-
 tools/perf/builtin-list.c                          |    2 +-
 tools/perf/builtin-lock.c                          |   44 +-
 tools/perf/builtin-mem.c                           |  161 +-
 tools/perf/builtin-record.c                        |   79 +-
 tools/perf/builtin-report.c                        |  106 +-
 tools/perf/builtin-sched.c                         |  232 +-
 tools/perf/builtin-script.c                        |  184 +-
 tools/perf/builtin-stat.c                          |   42 +-
 tools/perf/builtin-timechart.c                     |   25 +-
 tools/perf/builtin-top.c                           |   10 +-
 tools/perf/builtin-trace.c                         |  497 +++-
 tools/perf/builtin-version.c                       |   43 +-
 tools/perf/builtin.h                               |   17 +
 tools/perf/check-headers.sh                        |    1 +
 tools/perf/perf.c                                  |    1 +
 tools/perf/pmu-events/Build                        |   12 +-
 .../arch/arm64/ampere/ampereone/instruction.json   |    3 -
 .../yitian710/sys/ali_drw.json                     |    0
 .../yitian710/sys/metrics.json                     |    0
 .../pmu-events/arch/powerpc/power10/cache.json     |   20 +-
 .../arch/powerpc/power10/datasource.json           |   40 +
 .../pmu-events/arch/powerpc/power10/frontend.json  |   30 +
 .../pmu-events/arch/powerpc/power10/locks.json     |   10 +
 .../pmu-events/arch/powerpc/power10/memory.json    |   30 +
 .../pmu-events/arch/powerpc/power10/others.json    |  106 +-
 .../pmu-events/arch/powerpc/power10/pipeline.json  |   45 +
 .../perf/pmu-events/arch/powerpc/power10/pmc.json  |   10 +
 .../arch/x86/cascadelakex/uncore-cache.json        |   60 +-
 .../arch/x86/meteorlake/metricgroups.json          |  142 ++
 .../arch/x86/meteorlake/mtl-metrics.json           | 2535 ++++++++++++++++++++
 .../pmu-events/arch/x86/skylakex/uncore-cache.json |   60 +-
 .../arch/x86/snowridgex/uncore-cache.json          |   57 -
 tools/perf/pmu-events/empty-pmu-events.c           |  894 ++++---
 tools/perf/pmu-events/jevents.py                   |   27 +-
 tools/perf/pmu-events/models.py                    |   73 +
 tools/perf/pmu-events/pmu-events.h                 |    9 +
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |    9 +-
 tools/perf/tests/bp_account.c                      |    4 +-
 tools/perf/tests/bp_signal.c                       |    3 +-
 tools/perf/tests/bp_signal_overflow.c              |    3 +-
 tools/perf/tests/builtin-test.c                    |    1 +
 tools/perf/tests/cpumap.c                          |    6 +-
 tools/perf/tests/dlfilter-test.c                   |    2 +-
 tools/perf/tests/dwarf-unwind.c                    |    2 +-
 tools/perf/tests/event_update.c                    |    9 +-
 tools/perf/tests/make                              |    4 +
 tools/perf/tests/parse-events.c                    |    6 +-
 tools/perf/tests/pmu-events.c                      |   12 +-
 tools/perf/tests/pmu.c                             |    9 +-
 tools/perf/tests/shell/annotate.sh                 |    3 +-
 tools/perf/tests/shell/base_probe/settings.sh      |   48 -
 .../shell/base_probe/test_adding_blacklisted.sh    |   67 +
 .../tests/shell/base_probe/test_adding_kernel.sh   |    3 -
 tools/perf/tests/shell/base_probe/test_basic.sh    |   80 +
 .../tests/shell/base_probe/test_invalid_options.sh |   79 +
 .../tests/shell/base_probe/test_line_semantics.sh  |   55 +
 tools/perf/tests/shell/base_report/setup.sh        |   32 +
 .../tests/shell/base_report/stderr-whitelist.txt   |    5 +
 tools/perf/tests/shell/base_report/test_basic.sh   |  190 ++
 .../tests/shell/common/check_errors_whitelisted.pl |   51 +
 tools/perf/tests/shell/common/init.sh              |   31 +-
 tools/perf/tests/shell/common/settings.sh          |   28 +-
 tools/perf/tests/shell/ftrace.sh                   |   89 +
 .../perf/tests/shell/lib/perf_metric_validation.py |   10 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |   11 +-
 .../perf/tests/shell/perftool-testsuite_report.sh  |   23 +
 tools/perf/tests/shell/pipe_test.sh                |  129 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    5 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    5 +-
 tools/perf/tests/shell/record.sh                   |   59 +-
 tools/perf/tests/shell/record_bpf_filter.sh        |   86 +-
 tools/perf/tests/shell/record_lbr.sh               |  161 ++
 tools/perf/tests/shell/script.sh                   |    3 +
 tools/perf/tests/shell/test_stat_intel_tpebs.sh    |   19 +
 tools/perf/tests/shell/test_task_analyzer.sh       |    7 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |    7 +
 tools/perf/tests/shell/trace_btf_enum.sh           |   62 +
 tools/perf/tests/stat.c                            |    6 +-
 tools/perf/tests/tests-scripts.c                   |   37 +-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/tests/thread-map.c                      |    2 +-
 tools/perf/tests/vmlinux-kallsyms.c                |    4 +-
 tools/perf/tests/workloads/Build                   |    1 +
 tools/perf/tests/workloads/landlock.c              |   66 +
 tools/perf/tests/wp.c                              |    5 +
 tools/perf/trace/beauty/beauty.h                   |   11 +
 tools/perf/trace/beauty/perf_event_open.c          |    6 +-
 tools/perf/trace/beauty/sockaddr.c                 |    2 +-
 tools/perf/trace/beauty/timespec.c                 |    2 +-
 tools/perf/ui/browsers/annotate-data.c             |  376 ++-
 tools/perf/ui/browsers/annotate.c                  |   20 +-
 tools/perf/ui/browsers/hists.c                     |   18 +-
 tools/perf/ui/hist.c                               |   10 +-
 tools/perf/ui/stdio/hist.c                         |    4 +-
 tools/perf/util/Build                              |   10 +-
 tools/perf/util/annotate-data.c                    | 1164 ++++-----
 tools/perf/util/annotate-data.h                    |   86 +-
 tools/perf/util/annotate.c                         |  360 ++-
 tools/perf/util/annotate.h                         |   33 +-
 tools/perf/util/arm-spe.c                          |   55 +-
 tools/perf/util/auxtrace.c                         |   16 +-
 tools/perf/util/auxtrace.h                         |   21 +-
 tools/perf/util/block-info.c                       |   66 +-
 tools/perf/util/block-info.h                       |    8 +-
 tools/perf/util/bpf-event.c                        |    4 +-
 tools/perf/util/bpf-filter.c                       |  631 ++++-
 tools/perf/util/bpf-filter.h                       |   19 +-
 tools/perf/util/bpf-filter.l                       |   28 +-
 tools/perf/util/bpf-filter.y                       |   28 +-
 tools/perf/util/bpf_counter_cgroup.c               |    6 +-
 tools/perf/util/bpf_ftrace.c                       |    8 +-
 tools/perf/util/bpf_kwork.c                        |    9 +-
 tools/perf/util/bpf_kwork_top.c                    |    7 +-
 tools/perf/util/bpf_lock_contention.c              |   45 +-
 tools/perf/util/bpf_map.c                          |    3 -
 tools/perf/util/bpf_off_cpu.c                      |   16 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |  222 +-
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c        |    2 +-
 tools/perf/util/bpf_skel/func_latency.bpf.c        |    7 +-
 tools/perf/util/bpf_skel/kwork_top.bpf.c           |    2 +-
 tools/perf/util/bpf_skel/kwork_trace.bpf.c         |    5 +-
 tools/perf/util/bpf_skel/lock_contention.bpf.c     |   53 +-
 tools/perf/util/bpf_skel/lock_data.h               |    4 +-
 tools/perf/util/bpf_skel/off_cpu.bpf.c             |    9 +-
 tools/perf/util/bpf_skel/sample-filter.h           |   13 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c       |  105 +-
 tools/perf/util/bpf_skel/vmlinux/vmlinux.h         |    7 +
 tools/perf/util/branch.h                           |    1 +
 tools/perf/util/build-id.c                         |   40 +-
 tools/perf/util/build-id.h                         |    8 +-
 tools/perf/util/callchain.c                        |   35 +
 tools/perf/util/callchain.h                        |    6 +
 tools/perf/util/cap.c                              |   63 +-
 tools/perf/util/cap.h                              |   23 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   36 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |    2 +-
 tools/perf/util/cs-etm.c                           |  675 +++---
 tools/perf/util/cs-etm.h                           |   12 +-
 tools/perf/util/data-convert-bt.c                  |   34 +-
 tools/perf/util/data-convert-json.c                |   47 +-
 tools/perf/util/data.c                             |    7 +-
 tools/perf/util/debuginfo.h                        |    2 +
 tools/perf/util/disasm.c                           |  852 +++++--
 tools/perf/util/disasm.h                           |   19 +-
 tools/perf/util/disasm_bpf.c                       |  195 ++
 tools/perf/util/disasm_bpf.h                       |   12 +
 tools/perf/util/dso.c                              |    4 +-
 tools/perf/util/dso.h                              |    4 +-
 tools/perf/util/dsos.c                             |   12 +-
 tools/perf/util/dsos.h                             |    2 +-
 tools/perf/util/dump-insn.c                        |    2 +-
 tools/perf/util/dump-insn.h                        |    2 +-
 tools/perf/util/dwarf-aux.c                        |   18 +-
 tools/perf/util/dwarf-aux.h                        |    2 +
 tools/perf/util/env.c                              |   15 +
 tools/perf/util/env.h                              |    3 +
 tools/perf/util/event.c                            |   54 +-
 tools/perf/util/event.h                            |   38 +-
 tools/perf/util/events_stats.h                     |   15 +-
 tools/perf/util/evlist.c                           |   89 +-
 tools/perf/util/evlist.h                           |    7 +-
 tools/perf/util/evsel.c                            |  122 +-
 tools/perf/util/evsel.h                            |   27 +-
 tools/perf/util/evsel_fprintf.c                    |    2 -
 tools/perf/util/ftrace.h                           |    3 +
 tools/perf/util/header.c                           |  157 +-
 tools/perf/util/header.h                           |   25 +-
 tools/perf/util/hisi-ptt.c                         |    6 +-
 tools/perf/util/hist.c                             |   63 +-
 tools/perf/util/hist.h                             |    4 +-
 tools/perf/util/include/dwarf-regs.h               |   11 +
 tools/perf/util/intel-bts.c                        |   37 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    5 +-
 tools/perf/util/intel-pt.c                         |   30 +-
 tools/perf/util/intel-tpebs.c                      |  432 ++++
 tools/perf/util/intel-tpebs.h                      |   35 +
 tools/perf/util/jit.h                              |    3 +-
 tools/perf/util/jitdump.c                          |   10 +-
 tools/perf/util/llvm-c-helpers.cpp                 |  197 ++
 tools/perf/util/llvm-c-helpers.h                   |   60 +
 tools/perf/util/machine.c                          |  120 +-
 tools/perf/util/machine.h                          |   36 +-
 tools/perf/util/map.c                              |   25 +-
 tools/perf/util/map.h                              |   22 +-
 tools/perf/util/map_symbol.c                       |   18 +
 tools/perf/util/map_symbol.h                       |    3 +
 tools/perf/util/mem-events.c                       |   20 +-
 tools/perf/util/mem-events.h                       |    4 +-
 tools/perf/util/mem-info.c                         |   13 +
 tools/perf/util/mem-info.h                         |    1 +
 tools/perf/util/metricgroup.c                      |   10 +-
 tools/perf/util/mmap.c                             |    4 -
 tools/perf/util/parse-events.c                     |   69 +-
 tools/perf/util/parse-events.h                     |   11 +-
 tools/perf/util/parse-events.l                     |    3 +-
 tools/perf/util/pmu.c                              |   75 +-
 tools/perf/util/pmu.h                              |    8 +-
 tools/perf/util/pmus.c                             |   22 +-
 tools/perf/util/pmus.h                             |    1 +
 tools/perf/util/print-events.c                     |    3 +-
 tools/perf/util/print_insn.c                       |   14 +-
 tools/perf/util/s390-cpumsf.c                      |   11 +-
 .../util/scripting-engines/trace-event-python.c    |   16 +-
 tools/perf/util/session.c                          |  394 +--
 tools/perf/util/session.h                          |   61 +-
 tools/perf/util/setup.py                           |    4 +-
 tools/perf/util/sort.c                             |   66 +-
 tools/perf/util/sort.h                             |    3 +-
 tools/perf/util/srcline.c                          |   59 +-
 tools/perf/util/stat-display.c                     |    3 +-
 tools/perf/util/stat-shadow.c                      |    2 +-
 tools/perf/util/symbol.c                           |    8 +-
 tools/perf/util/symbol_conf.h                      |    2 +-
 tools/perf/util/synthetic-events.c                 |  181 +-
 tools/perf/util/synthetic-events.h                 |   89 +-
 tools/perf/util/syscalltbl.c                       |    4 +
 tools/perf/util/thread.c                           |    4 +
 tools/perf/util/thread.h                           |    1 +
 tools/perf/util/time-utils.c                       |    4 +-
 tools/perf/util/tool.c                             |  294 +++
 tools/perf/util/tool.h                             |   19 +-
 tools/perf/util/trace_augment.h                    |    6 +
 tools/perf/util/tsc.c                              |    2 +-
 tools/perf/util/util.c                             |   12 +-
 290 files changed, 15177 insertions(+), 4249 deletions(-)
 delete mode 100644 tools/build/Build
 create mode 100644 tools/build/feature/test-llvm-perf.cpp
 create mode 100644 tools/lib/perf/.gitignore
 create mode 100644 tools/perf/Documentation/perf-check.txt
 create mode 100644 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
 create mode 100644 tools/perf/builtin-check.c
 rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/ali_drw.json (100%)
 rename tools/perf/pmu-events/arch/arm64/{freescale => thead}/yitian710/sys/metrics.json (100%)
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/meteorlake/mtl-metrics.json
 create mode 100755 tools/perf/pmu-events/models.py
 delete mode 100644 tools/perf/tests/shell/base_probe/settings.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_basic.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_invalid_options.sh
 create mode 100755 tools/perf/tests/shell/base_probe/test_line_semantics.sh
 create mode 100755 tools/perf/tests/shell/base_report/setup.sh
 create mode 100644 tools/perf/tests/shell/base_report/stderr-whitelist.txt
 create mode 100755 tools/perf/tests/shell/base_report/test_basic.sh
 create mode 100755 tools/perf/tests/shell/common/check_errors_whitelisted.pl
 create mode 100755 tools/perf/tests/shell/ftrace.sh
 create mode 100755 tools/perf/tests/shell/perftool-testsuite_report.sh
 create mode 100755 tools/perf/tests/shell/record_lbr.sh
 create mode 100755 tools/perf/tests/shell/test_stat_intel_tpebs.sh
 create mode 100755 tools/perf/tests/shell/trace_btf_enum.sh
 create mode 100644 tools/perf/tests/workloads/landlock.c
 create mode 100644 tools/perf/util/disasm_bpf.c
 create mode 100644 tools/perf/util/disasm_bpf.h
 create mode 100644 tools/perf/util/intel-tpebs.c
 create mode 100644 tools/perf/util/intel-tpebs.h
 create mode 100644 tools/perf/util/llvm-c-helpers.cpp
 create mode 100644 tools/perf/util/llvm-c-helpers.h
 create mode 100644 tools/perf/util/tool.c
 create mode 100644 tools/perf/util/trace_augment.h
