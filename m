Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB321CF7D5;
	Sat, 21 Feb 2026 18:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771698287; cv=none; b=RXfelNyVR9mM+I2akLXrdwMmOKlga4M8eJjJENz675AuZaFFv5NPrgXUEutoTroTixOSIQkoVu4VrgsUay6GWsrxAtzRnzpU/nJYqcrK3YIbpprgkd0tT3Ymf1ZiH0cHn9OcuERGfzarE35YtoLdV9MrdM85t1vqMrtYNVT3OhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771698287; c=relaxed/simple;
	bh=foxpZx8L5S+6qc9dU0LvWdQQaIHdbBakfw+oxhlabXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dNNb7eT9jkCX4XF5nZcxZJAdBpqWbcP5i3e08st9JmnR1IjhLVusz03BvMVdEhTFxxAn+R/c1yjY4Tfcp5lOviMo8OhCZ1lBqi1txyP1M/AfqKCR/Fuo8DjyXHpDjM/8b9HRk3LQGoaBP6+Bs/fECCsH2biLmrizz8oROTSef2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf0IErfn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf0IErfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08005C4CEF7;
	Sat, 21 Feb 2026 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771698287;
	bh=foxpZx8L5S+6qc9dU0LvWdQQaIHdbBakfw+oxhlabXI=;
	h=From:To:Cc:Subject:Date:From;
	b=Nf0IErfnXfm9T8vglv+XKdqSVKixBuMBsRCoP/JhNVr2aeexNLsyPI19uNe/87EMj
	 o9Fc/vxLAjrAliIW2hRSpk49SDmMoeYoaNSSJVqvX/w/AonisqZCMGhF+TOGWJZfYT
	 Fnxl2nYNFgdwU0ER5Bu6nZsQrkv2YqgNKvHpJyXA5OjtTqpuQw69kGA6ojeFsaqMVE
	 s+jKWag4Xlhy94t09uLzVZ6KOr+PTf9Psws98r7Ffln140bWUFFIadzNLCmOp4YGdU
	 teP2wpaW7ztFdP5MbZmoVGiBNAcV7h0XkylyzTCFy3/e228aC9RnCJ2f7Ha8x/udkI
	 t4F+NEA9g2Ahw==
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
	Al Grant <al.grant@arm.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Gabriel Marin <gmx@google.com>,
	Gary Guo <gary@garyguo.net>,
	Guilherme Amadio <amadio@gentoo.org>,
	Haiyue Wang <haiyuewa@163.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	kernel test robot <oliver.sang@intel.com>,
	Leo Yan <leo.yan@arm.com>,
	=?UTF-8?q?Manuel=20Hern=C3=A1ndez=20M=C3=A9ndez?= <manuel.hernandez@openchip.com>,
	Nicolas Schier <n.schier@avm.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Shimin Guo <shimin.guo@skydio.com>,
	Sri Jayaramappa <sjayaram@akamai.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v7.0
Date: Sat, 21 Feb 2026 15:24:35 -0300
Message-ID: <20260221182435.1221570-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The following changes since commit fcb70a56f4d81450114034b2c61f48ce7444a0e2:

  Merge tag 'vfs-6.19-rc8.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2026-01-26 09:30:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.0-1-2026-02-21

for you to fetch changes up to dbf0108347bdb5d4ccef8910555b16c1f1a505f8:

  perf test script: Add python script testing support (2026-02-12 17:45:23 -0300)

----------------------------------------------------------------
perf tools changes for v7.0:

- Introduce 'perf sched stats' tool with record/report/diff workflows
  using schedstat counters.

- Add a faster libdw based addr2line implementation and allow selecting
  it or its alternatives via 'perf config addr2line.style='.

- Data-type profiling fixes and improvements including the ability
  to select fields using 'perf report''s -F/-fields, e.g.:

    'perf report --fields overhead,type'

- Add 'perf test' regression tests for Data-type profiling with
  C and Rust workloads.

- Fix srcline printing with inlines in callchains, make sure this has
  coverage in 'perf test'.

- Fix printing of leaf IP in LBR callchains.

- Fix display of metrics without sufficient permission in 'perf stat'.

- Print all machines in 'perf kvm report -vvv', not just the host.

- Switch from SHA-1 to BLAKE2s for build ID generation, remove SHA-1
  code.

- Fix 'perf report's histogram entry collapsing with '-F' option.

- Use system's cacheline size instead of a hardcoded value in 'perf
  report'.

- Allow filtering conversion by time range in 'perf data'.

- Cover conversion to CTF using 'perf data' in 'perf test'.

- Address newer glibc const-correctness (-Werror=discarded-qualifiers)
  issues.

- Fixes and improvements for ARM's CoreSight support, simplify ARM SPE
  event config in 'perf mem', update docs for 'perf c2c' including the
  ARM events it can be used with.

- Build support for generating metrics from arch specific python script,
  add extra AMD, Intel, ARM64 metrics using it.

- Add AMD Zen 6 events and metrics.

- Add JSON file with OpenHW Risc-V CVA6 hardware counters.

- Add 'perf kvm' stats live testing.

- Add more 'perf stat' tests to 'perf test'.

- Fix segfault in `perf lock contention -b/--use-bpf`

- Fix various 'perf test' cases for s390.

- Build system cleanups, bump minimum shellcheck version to 0.7.2

- Support building the capstone based annotation routines as a plugin.

- Allow passing extra Clang flags via EXTRA_BPF_FLAGS.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (28):
      perf list: Remove unused 'sep' variable
      perf diff: Constify strchr() return variables
      perf tools: Use const for variables receiving str{str,r?chr}() returns
      perf trace: Don't change const char strings
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf tests sw-clock: Mark the volatile tmp variable as __maybe_unused
      perf trace: Deal with compiler const checks
      perf list: Signal changing const memory is ok
      perf list: Don't write to const memory
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf annotate: Fix BUILD_NONDISTRO=1 missing args->ms conversions to pointer
      perf disasm: Constify variables storing the result of bsearch() on const tables
      perf metricgroup: Constify variables storing the result of strchr() on const tables
      perf strlist: Don't write to const memory
      perf session: Don't write to memory pointed to a const pointer
      perf hwmon_pmu: Constify the variables returning bsearch() on const tables
      perf tp_pmu: Address const-correctness errors in recent glibcs
      perf trace-event: Constify variables storing the result of strchr() on const tables
      perf units: Constify variables storing the result of strchr() on const tables
      perf time-utils: Constify variables storing the result of strchr() on const tables
      perf demangle-java: Constify variables storing the result of strchr() on const tables
      perf bpf-event: Constify variables storing the result of strchr() on const tables
      perf jitdump: Constify variables storing the result of strchr() on const tables
      perf strlist: Remove dont_dupstr logic, used only once
      tools build: Fix rust feature detection
      perf test code_with_type.sh: Skip test if rust wasn't available at build time
      perf test data_type_profiling.sh: Skip just the Rust tests if code_with_type workload is missing

Chun-Tse Shao (1):
      perf stat: Ensure metrics are displayed even with failed events

Dapeng Mi (5):
      perf Documentation: Correct branch stack sampling call-stack option
      perf regs: Fix abort for "-I" or "--user-regs" options
      perf arch: Update arch headers to use relative UAPI paths
      perf regs: Remove __weak attributive arch__xxx_reg_mask() functions
      perf regs: Remove __weak attributive arch_sdt_arg_parse_op() function

Derek Foreman (2):
      perf data: Allow filtering conversion by time range
      perf data: Fix coding style

Dmitrii Dolgov (7):
      tools build: Add a feature test for rust compiler
      perf test workload: Add code_with_type test workload
      perf tests: Test annotate with data type profiling and rust
      perf tests: Test annotate with data type profiling and C
      perf tests workload: Formatting for code_with_type.rs
      tools build: Make test-rust.bin be removed by the 'clean' target
      tools build: Fix feature test for rust compiler

Dmitry Dolgov (1):
      tools build: Emit dependencies file for test-rust.bin

Eric Biggers (3):
      perf util: Add BLAKE2s support
      perf genelf: Switch from SHA-1 to BLAKE2s for build ID generation
      perf util: Remove SHA-1 code

Gary Guo (1):
      perf symbol: Remove Rust symbol workarounds

Haiyue Wang (1):
      perf tools: Add the legacy-cache.json to .gitignore

Hrishikesh Suresh (1):
      perf session: Print all machines in session dump

Ian Rogers (125):
      perf vendor power9 nest metrics: Correct unit from MB to MiB
      perf test java symbol: Additional libperf-jvmti.so path check
      perf stat display: Make %f precision consistent
      perf test subcmd help: Add exclude disjoint subcmd names
      perf unwind-libdw: Fix invalid reference counts
      perf test workload: Add inlineloop test workload
      perf addr2line: Add a libdw implementation
      perf addr2line.c: Rename a2l_style to cmd_a2l_style
      perf srcline: Add configuration support for the addr2line style
      perf callchain: Fix srcline printing with inlines
      perf test: Test addr2line unwinding works with inline functions
      perf help: Move common_cmds into builtin-help
      perf tools: Switch printf("...%s", strerror(errno)) to printf("...%m")
      perf symbol-elf: Fix leak of ELF files with GNU debugdata
      perf dso: Extra validity checks that e_machine is valid
      perf record: Disable inline frames when marking build IDs
      perf libdw_addr2line: Fixes to srcline memory allocation
      perf unwind-libdw: Correct argument to dwfl_attach_state()
      perf powerpc: Unify the skip-callchain-idx libdw with that for addr2line
      perf perf_regs: Switch from arch string to int e_machine
      perf dwarf-regs: Add util/dwarf-regs-arch for consistency with perf-regs
      perf dwarf-regs: Remove get_arch_regnum()
      perf dwarf-regs: Clean up x86 dwarf_regnum code
      perf dwarf-regs: Add get_dwarf_regnum_for_perf_regnum() and use for x86 unwinding
      perf dwarf-regs: Add basic get_dwarf_regnum() for most architectures
      perf dwarf-regs: Add ARM perf to dwarf register number mapping functions
      perf dwarf-regs: Add csky perf to dwarf register number mapping functions
      perf dwarf-regs: Add loongarch perf to DWARF register number mapping functions
      perf dwarf-regs: Add powerpc perf to DWARF register number mapping functions
      perf dwarf-regs: Add RISC-V perf to DWARF register number mapping functions
      perf dwarf-regs: Add S390 perf to DWARF register number mapping functions
      perf dwarf-regs: Add MIPS perf to DWARF register number mapping functions
      perf build: Remove NO_LIBDW_DWARF_UNWIND option
      perf unwind-libdw: Don't discard loaded ELF/DWARF after every unwind
      perf machine: Add inline information to frame pointer and LBR callchains
      perf tests kallsyms: Fix missed map__put()
      perf header: Fix memory leaks in process_cpu_domain_info()
      perf annotate: Fix args leak of map_symbol
      perf maps: Fix reference count leak in maps__find_ams()
      perf disasm: Constify use of 'struct arch'
      perf disasm: Constify use of 'struct ins_op'
      perf disasm: Constify use of 'struct ins'
      perf disasm: Rework the string arch__is to use the ELF machine
      perf disasm: Don't include C files from the arch directory
      perf disasm: Refactor ins__is_call/jump to avoid exposing arch ins_ops
      perf map_symbol: Switch from holding maps to holding thread
      perf disasm: Refactor arch__find and initialization of arch structs
      perf disasm: Minor layout tweaks for 'struct arch'
      perf inject: With --convert-callchain ignore the dummy event for dwarf stacks
      perf tests sched: Avoid error in cleanup on loaded machines
      perf regs: Refactor use of arch__sample_reg_masks() to perf_reg_name()
      perf dso: Factor out e_machine reading for use in thread
      perf thread: Add optional e_flags output argument to thread__e_machine
      perf perf_regs: Accurately compute register names for CSKY
      perf unwind-libdw: Wire up e_flags for CSKY
      perf script: Fix script_fetch_insn for more than just x86
      perf callchain: Switch callchain_param_setup from an arch to an e_machine
      perf thread-stack: Switch thread_stack__init() to use e_machine
      perf jevents: Build support for generating metrics from python
      perf jevents: Add load event JSON to verify and allow fallbacks
      perf jevents: Add RAPL event metric for AMD zen models
      perf jevents: Add idle metric for AMD zen models
      perf jevents: Add upc metric for uops per cycle for AMD
      perf jevents: Add br metric group for branch statistics on AMD
      perf jevents: Add itlb metric group for AMD
      perf jevents: Add dtlb metric group for AMD
      perf jevents: Add uncore l3 metric group for AMD
      perf jevents: Add load store breakdown metrics ldst for AMD
      perf jevents: Add context switch metrics for AMD
      perf jevents: Add RAPL metrics for all Intel models
      perf jevents: Add idle metric for Intel models
      perf jevents: Add CheckPmu to see if a PMU is in loaded JSON events
      perf jevents: Add smi metric group for Intel models
      perf jevents: Mark metrics with experimental events as experimental
      perf jevents: Add tsx metric group for Intel models
      perf jevents: Add br metric group for branch statistics on Intel
      perf jevents: Add software prefetch (swpf) metric group for Intel
      perf jevents: Add ports metric group giving utilization on Intel
      perf jevents: Add L2 metrics for Intel
      perf jevents: Add load store breakdown metrics ldst for Intel
      perf jevents: Add ILP metrics for Intel
      perf jevents: Add context switch metrics for Intel
      perf jevents: Add FPU metrics for Intel
      perf jevents: Add Miss Level Parallelism (MLP) metric for Intel
      perf jevents: Add mem_bw metric for Intel
      perf jevents: Add local/remote "mem" breakdown metrics for Intel
      perf jevents: Add dir breakdown metrics for Intel
      perf jevents: Add C-State metrics from the PCU PMU for Intel
      perf jevents: Add local/remote miss latency metrics for Intel
      perf jevents: Add upi_bw metric for Intel
      perf jevents: Add mesh bandwidth saturation metric for Intel
      perf jevents: Add cycles breakdown metric for arm64/AMD/Intel
      perf jevents: Validate that all names given an Event
      perf build: Remove NO_LIBCAP that controls nothing
      perf capstone: Support for dlopen-ing libcapstone.so
      perf test kvm: Add stat live testing
      libperf build: Always place libperf includes first
      perf kvm stat: Remove use of the arch directory
      perf kvm: Wire up e_machine
      perf session: Add e_flags to the e_machine helper
      perf header: Add e_machine/e_flags to the header
      perf thread: Don't require machine to compute the e_machine
      perf tests: Additional 'perf stat' tests
      perf tests: build-test coverage for NO_JEVENTS=1
      perf metricgroup: Don't early exit if no CPUID table exists
      perf callchain lbr: Make the leaf IP that of the sample
      perf test addr2line_inlines: Ensure inline information shows on LBR leaves
      perf build: Reduce pmu-events related copying and mkdirs
      perf test record.sh: Fix shellcheck warning
      perf test parse-metric: Ensure aggregate counts appear to have run
      Revert "perf tool_pmu: More accurately set the cpus for tool events"
      perf stat-shadow: In prepare_metric fix guard on reading NULL perf_stat_evsel
      perf evlist: Special map propagation for tool events that read on 1 CPU
      perf evlist: Missing TPEBS close in evlist__close()
      perf evlist: Reduce affinity use and move into iterator, fix no affinity
      perf stat: Add no-affinity flag
      perf libunwind: Fix calls to thread__e_machine()
      perf check: Add libbabeltrace to the listed features
      perf json: Pipe mode --to-json support
      perf json: Pipe mode --to-ctf support
      perf test: Test pipe mode with data conversion --to-json
      perf test: perf data --to-ctf testing
      perf script: Allow the generated script to be a path
      perf test script: Add perl script testing support
      perf test script: Add python script testing support

James Clark (25):
      perf build: Do all non-distro feature checks in one go
      perf build: Remove unused libbfd-buildid feature test
      perf build: Feature test for libbfd thread safety API
      perf build: Skip nondistro build test if libbfd is old
      perf vendor events arm64: Remove uncountable events
      perf tools: Dump callchain context marker names
      perf parse-events: Refactor get_config_terms() to remove macros
      perf evsel: Refactor evsel__set_config_if_unset() arguments
      perf evsel: Move evsel__* functions to evsel.c
      perf evsel: Support sparse fields in evsel__set_config_if_unset()
      perf parse-events: Track all user changed config bits
      perf evsel: apply evsel__set_config_if_unset() to all config fields
      perf evsel: Add a helper to get the value of a config field
      perf parse-events: Always track user config changes
      perf tests: Test evsel__set_config_if_unset() and config change tracking
      perf cs-etm: Make a helper to find the Coresight evsel
      perf cs-etm: Don't use hard coded config bits when setting up ETMCR
      perf cs-etm: Don't use hard coded config bits when setting up TRCCONFIGR
      perf cs-etm: Don't hard code config attribute when configuring the event
      perf arm-spe: Don't hard code config attribute
      perf tools: Always uniquify event names
      perf test: Add missing newlines in debug messages
      perf cs-etm: Fix decoding for sparse CPU maps
      perf cs-etm: Test sparse CPU maps
      perf jevents: Handle deleted JSONS in out of source builds

Julia Lawall (1):
      perf addr_location: Update outdated comment

Leo Yan (9):
      perf mem: Simplify Arm SPE event config
      perf c2c: Update documentation for adding memory event table
      tools headers: Go back to include asm-generic/unistd.h for arm64
      Revert "perf tools: Fix arm64 build by generating unistd_64.h"
      tools headers: Don't check arm64's unistd.h
      tools: Fix bitfield dependency failure
      perf: Remove redundant kernel.h include
      perf record: Make logs more readable for event open failures
      perf kvm stat: Fix build error

Manuel Hernández Méndez (1):
      perf vendor events riscv: Add CVA6 JSON file

Namhyung Kim (13):
      perf record: Split --data-mmap option
      perf report: Enable data-type profiling with -F option too
      perf report: Fix histogram entry collapsing for -F option
      perf report: Update sort key state from -F option
      perf inject: Keep build-ID data if no option is used
      perf test: Skip dlfilter test for build failures
      perf test: Use shelldir to refer perf source location
      perf test: Do not skip when some metrics tests succeeded
      perf test: Do not skip when some metric-group tests succeed
      perf inject: Add --convert-callchain option
      perf test: Add DWARF callchain conversion test
      perf tools: Get debug info of DSO properly
      perf annotate: Fix register usage in data type profiling

Nicolas Schier (1):
      perf build: Raise minimum shellcheck version to 0.7.2

Ricky Ringler (1):
      perf sort: Replace static cacheline size with sysconf cacheline size

Roberto Sassu (1):
      perf build: Remove FEATURE_CHECK_LDFLAGS-disassembler-{four-args,init-styled} setting

Sandipan Das (5):
      perf vendor events amd: Add Zen 6 mapping
      perf vendor events amd: Add Zen 6 core events
      perf vendor events amd: Add Zen 6 uncore events
      perf vendor events amd: Add Zen 6 metrics
      perf vendor events amd: Fix Zen 5 MAB allocation events

Shimin Guo (1):
      perf unwind-libdw: Fix a cross-arch unwinding bug

Sri Jayaramappa (1):
      libsubcmd: Fix null intersection case in exclude_cmds()

Suchit Karunakaran (1):
      perf annotate: Fix memcpy size in arch__grow_instructions()

Swapnil Sapkal (16):
      tools/lib: Add list_is_first()
      perf header: Support CPU DOMAIN relation info
      perf sched stats: Add record and rawdump support
      perf sched stats: Add schedstat v16 support
      perf sched stats: Add schedstat v17 support
      perf sched stats: Add support for report subcommand
      perf sched stats: Add support for live mode
      perf sched stats: Add support for diff subcommand
      perf sched stats: Add basic 'perf sched stats' test
      perf sched stats: Add details in man page
      perf header: Replace hardcoded max cpus by MAX_NR_CPUS
      perf util: Fix NULL check in cpumask_to_cpulist()
      perf sched stats: Add NULL check for cd_map
      perf sched stats: correct spelling of function name
      perf sched stats: Define macro for SEP_LEN
      perf sched stats: Fixes in man page

Thomas Richter (5):
      perf test: Fix test case perf evlist tests for s390x
      perf test stat tests: Fix for virtualized machines
      perf test: Fix test perf evlist for z/VM s390x
      perf test: Fix test case Leader sampling on s390
      perf test: Fix test case perftool-testsuite_report for s390

Tycho Andersen (AMD) (1):
      perf lock contention: fix segfault in `lock contention -b/--use-bpf`

hupu (1):
      perf build: Allow passing extra Clang flags via EXTRA_BPF_FLAGS

 tools/arch/arm64/include/uapi/asm/unistd.h         |   24 +-
 tools/build/Makefile.build                         |   14 +
 tools/build/Makefile.feature                       |    5 +-
 tools/build/feature/Makefile                       |   14 +-
 tools/build/feature/test-libbfd-buildid.c          |    8 -
 tools/build/feature/test-libbfd-threadsafe.c       |   18 +
 tools/include/linux/bitfield.h                     |    1 +
 tools/include/linux/list.h                         |   10 +
 tools/lib/perf/Documentation/libperf.txt           |    2 +
 tools/lib/perf/Makefile                            |   17 +-
 tools/lib/perf/evlist.c                            |   36 +-
 tools/lib/perf/include/internal/evsel.h            |    2 +
 tools/lib/perf/include/perf/event.h                |   69 ++
 tools/lib/perf/include/perf/schedstat-v15.h        |  146 +++
 tools/lib/perf/include/perf/schedstat-v16.h        |  146 +++
 tools/lib/perf/include/perf/schedstat-v17.h        |  164 +++
 tools/lib/subcmd/help.c                            |   10 +-
 tools/perf/.gitignore                              |    6 +
 tools/perf/Documentation/perf-c2c.txt              |   51 +-
 tools/perf/Documentation/perf-data.txt             |   28 +
 tools/perf/Documentation/perf-inject.txt           |    5 +
 tools/perf/Documentation/perf-record.txt           |   10 +-
 tools/perf/Documentation/perf-sched.txt            |  261 ++++-
 tools/perf/Documentation/perf-script.txt           |    6 +-
 tools/perf/Documentation/perf-stat.txt             |    5 +
 tools/perf/Documentation/perf.data-file-format.txt |   17 +
 tools/perf/Makefile.config                         |   98 +-
 tools/perf/Makefile.perf                           |   29 +-
 tools/perf/arch/arc/annotate/instructions.c        |   11 -
 tools/perf/arch/arm/include/perf_regs.h            |    2 +-
 tools/perf/arch/arm/util/Build                     |    3 -
 tools/perf/arch/arm/util/cs-etm.c                  |  201 ++--
 tools/perf/arch/arm/util/perf_regs.c               |   22 -
 tools/perf/arch/arm/util/unwind-libdw.c            |   39 -
 tools/perf/arch/arm64/Makefile                     |    1 -
 tools/perf/arch/arm64/include/perf_regs.h          |    2 +-
 tools/perf/arch/arm64/util/Build                   |    3 -
 tools/perf/arch/arm64/util/arm-spe.c               |   17 +-
 tools/perf/arch/arm64/util/header.c                |    1 -
 tools/perf/arch/arm64/util/machine.c               |   14 +-
 tools/perf/arch/arm64/util/mem-events.c            |    4 +-
 tools/perf/arch/arm64/util/perf_regs.c             |  182 ----
 tools/perf/arch/arm64/util/unwind-libdw.c          |   61 --
 tools/perf/arch/csky/Build                         |    1 -
 tools/perf/arch/csky/include/perf_regs.h           |    2 +-
 tools/perf/arch/csky/util/Build                    |    3 -
 tools/perf/arch/csky/util/perf_regs.c              |   22 -
 tools/perf/arch/csky/util/unwind-libdw.c           |   78 --
 tools/perf/arch/loongarch/Makefile                 |    1 -
 tools/perf/arch/loongarch/include/perf_regs.h      |    2 +-
 tools/perf/arch/loongarch/util/Build               |    2 -
 tools/perf/arch/loongarch/util/perf_regs.c         |   22 -
 tools/perf/arch/loongarch/util/unwind-libdw.c      |   57 -
 tools/perf/arch/mips/include/perf_regs.h           |    2 +-
 tools/perf/arch/mips/util/Build                    |    1 -
 tools/perf/arch/mips/util/perf_regs.c              |   22 -
 tools/perf/arch/powerpc/Makefile                   |    1 -
 tools/perf/arch/powerpc/include/perf_regs.h        |    2 +-
 tools/perf/arch/powerpc/util/Build                 |    3 -
 tools/perf/arch/powerpc/util/perf_regs.c           |  240 -----
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |   52 +-
 tools/perf/arch/powerpc/util/unwind-libdw.c        |   76 --
 tools/perf/arch/riscv/Makefile                     |    1 -
 tools/perf/arch/riscv/include/perf_regs.h          |    9 +-
 tools/perf/arch/riscv/util/Build                   |    4 -
 tools/perf/arch/riscv/util/perf_regs.c             |   22 -
 tools/perf/arch/riscv/util/unwind-libdw.c          |   58 -
 tools/perf/arch/riscv64/annotate/instructions.c    |   36 -
 tools/perf/arch/s390/Makefile                      |    1 -
 tools/perf/arch/s390/include/perf_regs.h           |    2 +-
 tools/perf/arch/s390/util/Build                    |    4 -
 tools/perf/arch/s390/util/perf_regs.c              |   22 -
 tools/perf/arch/s390/util/unwind-libdw.c           |   65 --
 tools/perf/arch/x86/Makefile                       |    1 -
 tools/perf/arch/x86/include/perf_regs.h            |    2 +-
 tools/perf/arch/x86/tests/bp-modify.c              |   30 +-
 tools/perf/arch/x86/util/Build                     |    4 -
 tools/perf/arch/x86/util/archinsn.c                |   27 -
 tools/perf/arch/x86/util/intel-pt.c                |    3 +-
 tools/perf/arch/x86/util/perf_regs.c               |  330 ------
 tools/perf/arch/x86/util/unwind-libdw.c            |   54 -
 tools/perf/bench/uprobe.c                          |    2 +-
 tools/perf/builtin-check.c                         |    2 +
 tools/perf/builtin-daemon.c                        |    8 +-
 tools/perf/builtin-data.c                          |    3 +
 tools/perf/builtin-diff.c                          |   12 +-
 tools/perf/builtin-help.c                          |   51 +-
 tools/perf/builtin-inject.c                        |  160 ++-
 tools/perf/builtin-kvm.c                           |   73 +-
 tools/perf/builtin-list.c                          |    4 +-
 tools/perf/builtin-probe.c                         |    3 +-
 tools/perf/builtin-record.c                        |   47 +-
 tools/perf/builtin-report.c                        |   19 +-
 tools/perf/builtin-sched.c                         | 1034 +++++++++++++++++-
 tools/perf/builtin-script.c                        |   85 +-
 tools/perf/builtin-stat.c                          |  123 +--
 tools/perf/builtin-trace.c                         |   40 +-
 tools/perf/check-headers.sh                        |    1 -
 tools/perf/command-list.txt                        |   36 -
 tools/perf/jvmti/libjvmti.c                        |    2 +-
 tools/perf/perf.c                                  |   18 +-
 tools/perf/pmu-events/Build                        |  243 ++++-
 tools/perf/pmu-events/amd_metrics.py               |  492 +++++++++
 .../pmu-events/arch/arm64/arm/cortex-a510/pmu.json |    8 -
 .../arch/arm64/common-and-microarch.json           |   12 -
 .../pmu-events/arch/arm64/fujitsu/monaka/pmu.json  |   10 -
 .../arch/powerpc/power9/nest_metrics.json          |    8 +-
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |    1 +
 .../arch/riscv/openhwgroup/cva6/firmware.json      |   68 ++
 .../arch/riscv/openhwgroup/cva6/instructions.json  |   47 +
 .../arch/riscv/openhwgroup/cva6/memory.json        |   42 +
 .../arch/riscv/openhwgroup/cva6/microarch.json     |   27 +
 .../pmu-events/arch/x86/amdzen5/load-store.json    |    6 +-
 .../arch/x86/amdzen6/branch-prediction.json        |   93 ++
 tools/perf/pmu-events/arch/x86/amdzen6/decode.json |  139 +++
 .../pmu-events/arch/x86/amdzen6/execution.json     |  192 ++++
 .../arch/x86/amdzen6/floating-point.json           | 1106 +++++++++++++++++++
 .../pmu-events/arch/x86/amdzen6/inst-cache.json    |  120 +++
 .../perf/pmu-events/arch/x86/amdzen6/l2-cache.json |  326 ++++++
 .../perf/pmu-events/arch/x86/amdzen6/l3-cache.json |  177 +++
 .../pmu-events/arch/x86/amdzen6/load-store.json    |  523 +++++++++
 .../arch/x86/amdzen6/memory-controller.json        |  101 ++
 .../perf/pmu-events/arch/x86/amdzen6/pipeline.json |   99 ++
 .../pmu-events/arch/x86/amdzen6/recommended.json   |  339 ++++++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    3 +-
 tools/perf/pmu-events/arm64_metrics.py             |   49 +
 tools/perf/pmu-events/common_metrics.py            |   19 +
 tools/perf/pmu-events/intel_metrics.py             | 1129 ++++++++++++++++++++
 tools/perf/pmu-events/metric.py                    |  171 ++-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |    2 +-
 tools/perf/tests/builtin-test.c                    |    5 +
 tools/perf/tests/dlfilter-test.c                   |    1 -
 tools/perf/tests/kallsyms-split.c                  |    1 +
 tools/perf/tests/make                              |   14 +-
 tools/perf/tests/parse-events.c                    |   10 +-
 tools/perf/tests/parse-metric.c                    |    2 +
 tools/perf/tests/pmu.c                             |   91 ++
 tools/perf/tests/shell/addr2line_inlines.sh        |   96 ++
 tools/perf/tests/shell/data_type_profiling.sh      |   89 ++
 tools/perf/tests/shell/evlist.sh                   |    9 +-
 tools/perf/tests/shell/inject-callchain.sh         |   45 +
 tools/perf/tests/shell/kvm.sh                      |   30 +-
 tools/perf/tests/shell/perf_sched_stats.sh         |   64 ++
 tools/perf/tests/shell/record.sh                   |   16 +-
 tools/perf/tests/shell/sched.sh                    |    2 +-
 tools/perf/tests/shell/script_dlfilter.sh          |   10 +-
 tools/perf/tests/shell/script_perl.sh              |  102 ++
 tools/perf/tests/shell/script_python.sh            |  113 ++
 tools/perf/tests/shell/stat.sh                     |  244 ++++-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   26 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |   29 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |   54 +
 tools/perf/tests/shell/test_java_symbol.sh         |    4 +
 .../tests/shell/test_perf_data_converter_ctf.sh    |  104 ++
 .../tests/shell/test_perf_data_converter_json.sh   |   33 +-
 tools/perf/tests/subcmd-help.c                     |   26 +
 tools/perf/tests/sw-clock.c                        |    3 +-
 tools/perf/tests/tests.h                           |    5 +
 tools/perf/tests/util.c                            |   85 +-
 tools/perf/tests/workloads/Build                   |    7 +
 tools/perf/tests/workloads/code_with_type.c        |   46 +
 tools/perf/tests/workloads/code_with_type.rs       |   27 +
 tools/perf/tests/workloads/inlineloop.c            |   52 +
 tools/perf/ui/browsers/annotate.c                  |    6 +-
 tools/perf/ui/browsers/hists.c                     |    3 +-
 tools/perf/util/Build                              |   29 +-
 tools/perf/util/addr2line.c                        |   24 +-
 tools/perf/util/addr_location.c                    |    6 +-
 tools/perf/util/addr_location.h                    |    1 -
 tools/perf/util/annotate-arch/Build                |   11 +
 tools/perf/util/annotate-arch/annotate-arc.c       |   18 +
 .../annotate-arch/annotate-arm.c}                  |   50 +-
 .../annotate-arch/annotate-arm64.c}                |   59 +-
 .../annotate-arch/annotate-csky.c}                 |   29 +-
 .../annotate-arch/annotate-loongarch.c}            |   71 +-
 .../annotate-arch/annotate-mips.c}                 |   29 +-
 .../annotate-arch/annotate-powerpc.c}              |  127 ++-
 tools/perf/util/annotate-arch/annotate-riscv64.c   |   41 +
 .../annotate-arch/annotate-s390.c}                 |   70 +-
 .../annotate-arch/annotate-sparc.c}                |   28 +-
 .../annotate-arch/annotate-x86.c}                  |   89 +-
 tools/perf/util/annotate-data.c                    |   12 +-
 tools/perf/util/annotate-data.h                    |    2 +-
 tools/perf/util/annotate.c                         |  140 ++-
 tools/perf/util/annotate.h                         |   10 +-
 tools/perf/util/archinsn.h                         |   12 -
 .../perf/util/arm64-frame-pointer-unwind-support.c |    3 +-
 tools/perf/util/blake2s.c                          |  151 +++
 tools/perf/util/blake2s.h                          |   73 ++
 tools/perf/util/bpf-event.c                        |   14 +-
 tools/perf/util/bpf-utils.c                        |    4 +-
 tools/perf/util/bpf_lock_contention.c              |    5 +-
 tools/perf/util/callchain.c                        |   16 +-
 tools/perf/util/callchain.h                        |    2 +-
 tools/perf/util/cap.c                              |    3 +-
 tools/perf/util/capstone.c                         |  194 +++-
 tools/perf/util/capstone.h                         |   33 +
 tools/perf/util/config.c                           |    4 +
 tools/perf/util/cs-etm.c                           |    4 +-
 tools/perf/util/data-convert-bt.c                  |   91 +-
 tools/perf/util/data-convert-json.c                |   58 +-
 tools/perf/util/data-convert.h                     |    1 +
 tools/perf/util/data.c                             |   29 +-
 tools/perf/util/db-export.c                        |    1 -
 tools/perf/util/demangle-java.c                    |    2 +-
 tools/perf/util/disasm.c                           |  435 +++-----
 tools/perf/util/disasm.h                           |   95 +-
 tools/perf/util/dlfilter.c                         |    3 +-
 tools/perf/util/dso.c                              |  212 +++-
 tools/perf/util/dso.h                              |   47 +-
 tools/perf/util/dwarf-regs-arch/Build              |    9 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-arm.c   |   12 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c |   12 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c  |  126 +++
 .../util/dwarf-regs-arch/dwarf-regs-loongarch.c    |   12 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c  |   14 +
 .../perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c |  136 +++
 tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c |   12 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c  |   53 +
 tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c   |  260 +++++
 tools/perf/util/dwarf-regs-csky.c                  |   50 -
 tools/perf/util/dwarf-regs-powerpc.c               |   61 --
 tools/perf/util/dwarf-regs-x86.c                   |   50 -
 tools/perf/util/dwarf-regs.c                       |  151 ++-
 tools/perf/util/env.c                              |   29 +
 tools/perf/util/env.h                              |   20 +
 tools/perf/util/event.c                            |   54 +-
 tools/perf/util/event.h                            |    2 +
 tools/perf/util/evlist.c                           |  190 ++--
 tools/perf/util/evlist.h                           |   27 +-
 tools/perf/util/evsel.c                            |  158 ++-
 tools/perf/util/evsel.h                            |    7 +-
 tools/perf/util/evsel_config.h                     |    7 +-
 tools/perf/util/evsel_fprintf.c                    |    8 +-
 tools/perf/util/genelf.c                           |   58 +-
 tools/perf/util/generate-cmdlist.sh                |   70 --
 tools/perf/util/header.c                           |  310 ++++++
 tools/perf/util/header.h                           |    5 +
 tools/perf/util/hist.c                             |   18 +-
 tools/perf/util/hwmon_pmu.c                        |    2 +-
 tools/perf/util/include/dwarf-regs.h               |   28 +-
 tools/perf/util/jitdump.c                          |    5 +-
 tools/perf/util/kvm-stat-arch/Build                |    6 +
 .../kvm-stat-arch}/arm64_exception_types.h         |    0
 .../util => util/kvm-stat-arch}/book3s_hcalls.h    |    0
 .../util => util/kvm-stat-arch}/book3s_hv_exits.h  |    0
 .../kvm-stat-arch/kvm-stat-arm64.c}                |   43 +-
 .../kvm-stat-arch/kvm-stat-loongarch.c}            |   49 +-
 .../kvm-stat-arch/kvm-stat-powerpc.c}              |   61 +-
 .../kvm-stat-arch/kvm-stat-riscv.c}                |   42 +-
 .../kvm-stat-arch/kvm-stat-s390.c}                 |   40 +-
 .../kvm-stat-arch/kvm-stat-x86.c}                  |   50 +-
 .../util => util/kvm-stat-arch}/riscv_trap_types.h |    2 +-
 tools/perf/util/kvm-stat.c                         |  215 +++-
 tools/perf/util/kvm-stat.h                         |   79 +-
 tools/perf/util/libbfd.c                           |    6 +-
 tools/perf/util/libdw.c                            |  172 +++
 tools/perf/util/libdw.h                            |   58 +
 tools/perf/util/llvm.c                             |    8 +-
 tools/perf/util/lzma.c                             |    6 +-
 tools/perf/util/machine.c                          |  135 ++-
 tools/perf/util/map_symbol.c                       |    5 +-
 tools/perf/util/map_symbol.h                       |    3 +-
 tools/perf/util/maps.c                             |   37 +-
 tools/perf/util/maps.h                             |    4 +
 tools/perf/util/metricgroup.c                      |   23 +-
 tools/perf/util/parse-events.c                     |  260 +++--
 tools/perf/util/parse-regs-options.c               |  119 ++-
 tools/perf/util/perf-regs-arch/perf_regs_aarch64.c |  139 ++-
 tools/perf/util/perf-regs-arch/perf_regs_arm.c     |    7 +-
 tools/perf/util/perf-regs-arch/perf_regs_csky.c    |   26 +-
 .../perf/util/perf-regs-arch/perf_regs_loongarch.c |    7 +-
 tools/perf/util/perf-regs-arch/perf_regs_mips.c    |    7 +-
 tools/perf/util/perf-regs-arch/perf_regs_powerpc.c |  183 +++-
 tools/perf/util/perf-regs-arch/perf_regs_riscv.c   |    7 +-
 tools/perf/util/perf-regs-arch/perf_regs_s390.c    |    7 +-
 tools/perf/util/perf-regs-arch/perf_regs_x86.c     |  281 ++++-
 tools/perf/util/perf_regs.c                        |  224 +++-
 tools/perf/util/perf_regs.h                        |   51 +-
 tools/perf/util/pmu.c                              |  118 +-
 tools/perf/util/pmu.h                              |   37 +-
 tools/perf/util/print-events.c                     |   13 +-
 tools/perf/util/probe-file.c                       |    3 +-
 tools/perf/util/record.h                           |    2 +
 tools/perf/util/sample.c                           |   77 ++
 tools/perf/util/sample.h                           |    7 +
 .../util/scripting-engines/trace-event-python.c    |   22 +-
 tools/perf/util/session.c                          |  180 +++-
 tools/perf/util/session.h                          |    1 +
 tools/perf/util/sha1.c                             |   97 --
 tools/perf/util/sha1.h                             |    6 -
 tools/perf/util/sort.c                             |  118 +-
 tools/perf/util/srcline.c                          |  116 +-
 tools/perf/util/srcline.h                          |    3 +
 tools/perf/util/stat-display.c                     |   85 +-
 tools/perf/util/stat-shadow.c                      |   30 +-
 tools/perf/util/stat.h                             |    2 +-
 tools/perf/util/strlist.c                          |   37 +-
 tools/perf/util/strlist.h                          |    2 -
 tools/perf/util/symbol-elf.c                       |    6 +-
 tools/perf/util/symbol.c                           |   19 +-
 tools/perf/util/symbol_conf.h                      |   10 +
 tools/perf/util/synthetic-events.c                 |  196 ++++
 tools/perf/util/synthetic-events.h                 |    3 +
 tools/perf/util/thread-stack.c                     |    4 +-
 tools/perf/util/thread.c                           |   67 +-
 tools/perf/util/thread.h                           |   16 +-
 tools/perf/util/thread_map.c                       |   18 +-
 tools/perf/util/time-utils.c                       |    4 +-
 tools/perf/util/tool.c                             |   20 +
 tools/perf/util/tool.h                             |    4 +-
 tools/perf/util/tool_pmu.c                         |   19 -
 tools/perf/util/tool_pmu.h                         |    1 -
 tools/perf/util/tp_pmu.c                           |    2 +-
 tools/perf/util/trace-event-info.c                 |    2 +-
 tools/perf/util/trace-event-scripting.c            |   16 -
 tools/perf/util/trace-event.h                      |    3 -
 tools/perf/util/units.c                            |    2 +-
 tools/perf/util/unwind-libdw.c                     |  162 ++-
 tools/perf/util/unwind-libdw.h                     |   11 +-
 tools/perf/util/unwind-libunwind-local.c           |   11 +-
 tools/perf/util/util.c                             |   49 +
 tools/perf/util/util.h                             |    5 +
 tools/scripts/Makefile.include                     |    2 +
 324 files changed, 15622 insertions(+), 4400 deletions(-)
 delete mode 100644 tools/build/feature/test-libbfd-buildid.c
 create mode 100644 tools/build/feature/test-libbfd-threadsafe.c
 create mode 100644 tools/lib/perf/include/perf/schedstat-v15.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v16.h
 create mode 100644 tools/lib/perf/include/perf/schedstat-v17.h
 delete mode 100644 tools/perf/arch/arc/annotate/instructions.c
 delete mode 100644 tools/perf/arch/arm/util/perf_regs.c
 delete mode 100644 tools/perf/arch/arm/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/arm64/util/perf_regs.c
 delete mode 100644 tools/perf/arch/arm64/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/csky/Build
 delete mode 100644 tools/perf/arch/csky/util/Build
 delete mode 100644 tools/perf/arch/csky/util/perf_regs.c
 delete mode 100644 tools/perf/arch/csky/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
 delete mode 100644 tools/perf/arch/loongarch/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/mips/util/perf_regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/perf_regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/riscv/util/perf_regs.c
 delete mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/riscv64/annotate/instructions.c
 delete mode 100644 tools/perf/arch/s390/util/perf_regs.c
 delete mode 100644 tools/perf/arch/s390/util/unwind-libdw.c
 delete mode 100644 tools/perf/arch/x86/util/archinsn.c
 delete mode 100644 tools/perf/arch/x86/util/perf_regs.c
 delete mode 100644 tools/perf/arch/x86/util/unwind-libdw.c
 delete mode 100644 tools/perf/command-list.txt
 create mode 100755 tools/perf/pmu-events/amd_metrics.py
 delete mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a510/pmu.json
 delete mode 100644 tools/perf/pmu-events/arch/arm64/fujitsu/monaka/pmu.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/firmware.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/instructions.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/memory.json
 create mode 100644 tools/perf/pmu-events/arch/riscv/openhwgroup/cva6/microarch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/load-store.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/memory-controller.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen6/recommended.json
 create mode 100755 tools/perf/pmu-events/arm64_metrics.py
 create mode 100644 tools/perf/pmu-events/common_metrics.py
 create mode 100755 tools/perf/pmu-events/intel_metrics.py
 create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh
 create mode 100755 tools/perf/tests/shell/data_type_profiling.sh
 create mode 100755 tools/perf/tests/shell/inject-callchain.sh
 create mode 100755 tools/perf/tests/shell/perf_sched_stats.sh
 create mode 100755 tools/perf/tests/shell/script_perl.sh
 create mode 100755 tools/perf/tests/shell/script_python.sh
 create mode 100755 tools/perf/tests/shell/test_perf_data_converter_ctf.sh
 create mode 100644 tools/perf/tests/workloads/code_with_type.c
 create mode 100644 tools/perf/tests/workloads/code_with_type.rs
 create mode 100644 tools/perf/tests/workloads/inlineloop.c
 create mode 100644 tools/perf/util/annotate-arch/Build
 create mode 100644 tools/perf/util/annotate-arch/annotate-arc.c
 rename tools/perf/{arch/arm/annotate/instructions.c => util/annotate-arch/annotate-arm.c} (59%)
 rename tools/perf/{arch/arm64/annotate/instructions.c => util/annotate-arch/annotate-arm64.c} (70%)
 rename tools/perf/{arch/csky/annotate/instructions.c => util/annotate-arch/annotate-csky.c} (67%)
 rename tools/perf/{arch/loongarch/annotate/instructions.c => util/annotate-arch/annotate-loongarch.c} (60%)
 rename tools/perf/{arch/mips/annotate/instructions.c => util/annotate-arch/annotate-mips.c} (59%)
 rename tools/perf/{arch/powerpc/annotate/instructions.c => util/annotate-arch/annotate-powerpc.c} (73%)
 create mode 100644 tools/perf/util/annotate-arch/annotate-riscv64.c
 rename tools/perf/{arch/s390/annotate/instructions.c => util/annotate-arch/annotate-s390.c} (66%)
 rename tools/perf/{arch/sparc/annotate/instructions.c => util/annotate-arch/annotate-sparc.c} (85%)
 rename tools/perf/{arch/x86/annotate/instructions.c => util/annotate-arch/annotate-x86.c} (93%)
 delete mode 100644 tools/perf/util/archinsn.h
 create mode 100644 tools/perf/util/blake2s.c
 create mode 100644 tools/perf/util/blake2s.h
 create mode 100644 tools/perf/util/dwarf-regs-arch/Build
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-arm.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-arm64.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-loongarch.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-mips.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-riscv.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
 delete mode 100644 tools/perf/util/dwarf-regs-csky.c
 delete mode 100644 tools/perf/util/dwarf-regs-powerpc.c
 delete mode 100644 tools/perf/util/dwarf-regs-x86.c
 delete mode 100755 tools/perf/util/generate-cmdlist.sh
 create mode 100644 tools/perf/util/kvm-stat-arch/Build
 rename tools/perf/{arch/arm64/util => util/kvm-stat-arch}/arm64_exception_types.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hcalls.h (100%)
 rename tools/perf/{arch/powerpc/util => util/kvm-stat-arch}/book3s_hv_exits.h (100%)
 rename tools/perf/{arch/arm64/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-arm64.c} (62%)
 rename tools/perf/{arch/loongarch/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-loongarch.c} (77%)
 rename tools/perf/{arch/powerpc/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-powerpc.c} (78%)
 rename tools/perf/{arch/riscv/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-riscv.c} (57%)
 rename tools/perf/{arch/s390/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-s390.c} (77%)
 rename tools/perf/{arch/x86/util/kvm-stat.c => util/kvm-stat-arch/kvm-stat-x86.c} (86%)
 rename tools/perf/{arch/riscv/util => util/kvm-stat-arch}/riscv_trap_types.h (96%)
 create mode 100644 tools/perf/util/libdw.c
 create mode 100644 tools/perf/util/libdw.h
 delete mode 100644 tools/perf/util/sha1.c
 delete mode 100644 tools/perf/util/sha1.h
