Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E434C6C;
	Wed,  8 Oct 2025 20:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759955318; cv=none; b=mXvdZUM0O9HZAKcBBCJvYzttLI/PXZMdUjjl/aLviZ/dffwwhOW0G4iylrSTNA3KWFSfWbo+FXy0ySSTSjTP/bXEizswONJclzQMxhtiQxkPFLEvfY2ZvXqtLqQFuLrqG7A8OYsFbthOXADfh+wOZMPSi+H5HenYnlOECvJlF3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759955318; c=relaxed/simple;
	bh=F729APzXr8ACy05uR1C2C6JPx94rKeLMfiT7NQxPmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OjozppuVrHypfM9EK3zVdRkFkx8jJPy3rmANzrU0yJ8FyaW55VLQdYK6+tJClMPJpPKgGD9Mut2MFFpwmGW7YRNGmnt6U3YAFWBfznBCJsHwhHX/a/1RjU3lOLKfo7ksgZOrxgPYRqr62/lIdpsskhyFgf2/J9oKtpmG/nIZgjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJjiDOEZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJjiDOEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AB3C4CEE7;
	Wed,  8 Oct 2025 20:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759955317;
	bh=F729APzXr8ACy05uR1C2C6JPx94rKeLMfiT7NQxPmQQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XJjiDOEZJJ3c8dHsjYshi1VbUgnibt+C/Ykbi4P3j9BghvjaRMlTm5TZq/+kzuIjx
	 eoRLNZKdi22bh/7X72gmUFJQpaFFo0qxDi8zu5A/schmh8ZA/Aq/ad/2t2NCh03Zp3
	 bzb+jfrcESDvUtlSLnNI983pybp72/VrS2mSgnKgv3WvlZ8qlQiSNBbOC6Sd7m5Ip0
	 FAb8iPS+9UM8RX+A+pwAxtd365yO3GyHWPPxZX+vF7dn3KSb1E3ChAECH6JCYlzXU9
	 oo7xlC7L2dXJ1KzpKKPLISe/yxA5KU9GqGAgGn5RxO8lyJExVbYZRibZblZac3zdSz
	 nq3b+p7a71xOw==
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
	Ankur Arora <ankur.a.arora@oracle.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Colin Ian King <colin.i.king@gmail.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	David Binderman <dcb314@hotmail.com>,
	Fushuai Wang <wangfushuai@baidu.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	GuoHan Zhao <zhaoguohan@kylinos.cn>,
	Howard Chu <howardchu95@gmail.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Tejas Manhas <tejas05@linux.ibm.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Trevor Allison <tallison@redhat.com>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Xudong Hao <xudong.hao@intel.com>,
	Yunseong Kim <ysk@kzalloc.com>,
	Zecheng Li <zecheng@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v6.18
Date: Wed,  8 Oct 2025 17:28:04 -0300
Message-ID: <20251008202804.852200-1-acme@kernel.org>
X-Mailer: git-send-email 2.51.0
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

The following changes since commit e8442d5b7bc6338d553040f5b1f7bd43f5ab30e0:

  Merge tag 'sound-6.17-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound (2025-09-19 08:22:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.18-1-2025-10-08

for you to fetch changes up to f3b601f900902ab80902c44f820a8985384ac021:

  perf tools: Fix arm64 libjvmti build by generating unistd_64.h (2025-10-06 17:16:52 -0300)

----------------------------------------------------------------
perf tools improvements and fixes for Linux v6.18:

- Extended 'perf annotate' with DWARF type information (--code-with-type)
  integration in the TUI, including a 'T' hotkey to toggle it.

- Enhanced 'perf bench mem' with new mmap() workloads and control over
  page/chunk sizes.

- Fix 'perf stat' error handling to correctly display unsupported events.

- Improved support for Clang cross-compilation.

- Refactored LLVM and Capstone disasm for modularity.

- Introduced the :X modifier to exclude an event from automatic regrouping.

- Adjusted KVM sampling defaults to use the "cycles" event to prevent failures.

- Added comprehensive support for decoding PowerPC Dispatch Trace Log (DTL).

- Updated Arm SPE tracing logic for better analysis of memory and snoop
  details.

- Synchronized Intel PMU events and metrics with TMA 5.1 across multiple
  processor generations.

- Converted dependencies like libperl and libtracefs to be opt-in.

- Handle more Rust symbols in kallsyms ('N', debugging).

- Improve the python binding to allow for python based tools to use more
  of the libraries, add a 'ilist' utility to test those new bindings.

- Various 'perf test' fixes.

- Kan Liang no longer a perf tools reviewer.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Ankur Arora (9):
      perf bench mem: Remove repetition around time measurement
      perf bench mem: Defer type munging of size to float
      perf bench mem: Move mem op parameters into a structure
      perf bench mem: Pull out init/fini logic
      perf bench mem: Switch from zalloc() to mmap()
      perf bench mem: Allow mapping of hugepages
      perf bench mem: Allow chunking on a memory region
      perf bench mem: Refactor mem_options
      perf bench mem: Add mmap() workloads

Arnaldo Carvalho de Melo (6):
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf symbols: Handle 'N' symbols in /proc/kallsyms
      Merge remote-tracking branch 'torvalds/master' into perf-tools-next
      perf bpf: Move the LIBBPF_CURRENT_VERSION_GEQ macro to bpf-utils.h
      perf bpf: Check libbpf version to use btf_dump_type_data_opts.emit_strings
      tools build: Don't assume libtracefs-devel is always available

Athira Rajeev (7):
      perf tests record: Update testcase to fix usage of affinity for machines with #CPUs > 1K
      perf powerpc: Add basic CONFIG_AUXTRACE support for VPA pmu on powerpc
      perf powerpc: Process auxtrace events and display in 'perf report -D'
      perf powerpc: Add event name as vpa-dtl of PERF_TYPE_SYNTH type to present DTL samples
      perf powerpc: Allocate and setup aux buffer queue to help co-relate with other events across CPU's
      perf powerpc: Process the DTL entries in queue and deliver samples
      perf script: Enable to present DTL entries

Christophe Leroy (1):
      perf: Completely remove possibility to override MAX_NR_CPUS

Colin Ian King (1):
      perf python: Fix spelling mistake "metics" -> "metrics"

Dapeng Mi (6):
      perf tools kvm: Add missed memory allocation check and free
      perf tools kwork: Add missed memory allocation check and free
      perf tools kvm: Fix the potential out of range memory access issue
      perf tools: Add helper x86__is_intel_cpu()
      perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
      perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel

Fushuai Wang (1):
      perf trace: Fix IS_ERR() vs NULL check bug

Gautam Menghani (1):
      perf auxtrace: Avoid redundant NULL check in auxtrace_mmap_params__set_idx()

GuoHan Zhao (1):
      perf drm_pmu: Fix fd_dir leaks in for_each_drm_fdinfo_in_dir()

Ian Rogers (93):
      perf disasm: Avoid undefined behavior in incrementing NULL
      perf test trace_btf_enum: Skip if permissions are insufficient
      perf evsel: Avoid container_of on a NULL leader
      perf test shell lock_contention: Extra debug diagnostics
      libperf event: Ensure tracing data is multiple of 8 sized
      perf python: Add more exceptions on error paths
      perf python: Improve the tracepoint function if no libtraceevent
      perf python: Add basic PMU abstraction and pmus sequence
      perf python: Add function returning dictionary of all events on a PMU
      perf ilist: Add new python ilist command
      perf python: Add parse_metrics function
      perf python: Add evlist metrics function
      perf python: Add evlist compute_metric
      perf python: Add metrics function
      perf ilist: Add support for metrics
      perf tp_pmu: Remove unnecessary check
      perf parse-events: Handle fake PMUs in CPU terms
      perf vendor events: Update alderlake events/metrics
      perf vendor events: Update arrowlake events/metrics
      perf vendor events: Update broadwell metrics
      perf vendor events: Update cascadelakex metrics
      perf vendor events: Update emeraldrapids events/metrics
      perf vendor events: Update grandridge metrics
      perf vendor events: Update graniterapids events/metrics
      perf vendor events: Update haswell metrics
      perf vendor events: Update icelake metrics
      perf vendor events: Update ivybridge/ivytown metrics
      perf vendor events: Update jaketown metrics
      perf vendor events: Update lunarlake events/metrics
      perf vendor events: Update meteorlake events/metrics
      perf vendor events: Update rocketlake metrics
      perf vendor events: Update sandybridge metrics
      perf vendor events: Update sapphirerapids events/metrics
      perf vendor events: Update sierraforest metrics
      perf vendor events: Update skylake metrics
      perf vendor events: Update tigerlake metrics
      perf evsel: Give warning for broken Intel topdown event grouping
      perf stat: Don't skip failing group events
      perf parse-events: Add 'X' modifier to exclude an event from being regrouped
      perf test: AMD IBS swfilt skip kernel tests if paranoia is >1
      perf test shell lbr: Avoid failures with perf event paranoia
      tools build: Make libperl opt-in rather than opt-out, deprecate
      perf test: Don't leak workload gopipe in PERF_RECORD_*
      perf evsel: Fix uniquification when PMU given without suffix
      perf test: Avoid uncore_imc/clockticks in uniquification test
      perf evsel: Ensure the fallback message is always written to
      perf build-id: Ensure snprintf string is empty when size is 0
      perf bpf-filter: Fix opts declaration on older libbpfs
      perf vendor events intel: Update alderlake events to v1.34
      perf vendor events intel: Update arrowlake events to v1.13
      perf vendor events intel: Update emeraldrapids events to v1.20
      perf vendor events intel: Update grandridge events to v1.10
      perf vendor events intel: Update graniterapids events to v1.15
      perf vendor events intel: Update lunarlake events to v1.18
      perf vendor events intel: Update meteorlake events to v1.17
      perf vendor events intel: Update pantherlake events to v1.00
      perf vendor events intel: Update sapphirerapids events to v1.35
      perf vendor events intel: Update sierraforest events to v1.12
      perf sched: Avoid union type punning undefined behavior
      perf bpf_counter: Move header declarations into C code
      perf bpf_counter: Fix handling of cpumap fixing hybrid
      perf test: Add an 'import perf' test shell script
      perf test: Remove C python_use test
      perf build: Remove libtracefs configuration
      perf symbol-minimal: Be more defensive when reading build IDs
      libperf mmap: In user mmap rdpmc avoid undefined behavior
      perf test: Stat std output don't fail metric only
      perf bench futex: Add missing stdbool.h
      tools bitmap: Add missing asm-generic/bitsperlong.h include
      tools include: Replace tools linux/gfp_types.h with kernel version
      tools include: Add headers to make tools builds more hermetic
      perf map: Constify objdump offset/address conversion APIs
      perf capstone: Move capstone functionality into its own file
      perf llvm: Move llvm functionality into its own file
      perf libbfd: Move libbfd functionality to its own file
      perf capstone: Remove open_capstone_handle
      perf namespaces: Avoid get_current_dir_name dependency
      tools build: Remove get_current_dir_name feature check
      perf stat: Move create_perf_stat_counter() to builtin-stat.c
      perf stat: Refactor retry/skip/fatal error handling
      tools build: Remove feature-libslang-include-subdir
      perf build: Move libopcode disasm tests to BUILD_NONDISTRO
      perf bpf-event: Use libbpf version rather than feature check
      tools build: Remove libbpf-strings feature test
      perf parse-events: Fix parsing of >30kb event strings
      perf check: Add libLLVM feature
      perf llvm: Reduce LLVM initialization
      perf dso: Move read_symbol() from llvm/capstone to dso
      perf dso: Support BPF programs in dso__read_symbol()
      perf dso: Clean up read_symbol() error handling
      perf disasm: Make ins__scnprintf() and ins__is_nop() static
      perf srcline: Fallback between addr2line implementations
      perf disasm: Remove unused evsel from 'struct annotate_args'

Ilkka Koskinen (2):
      perf vendor events arm64 AmpereOneX: Fix typo - should be l1d_cache_access_prefetches
      perf vendor events arm64 AmpereOne: Fix typos in metrics' descriptions

James Clark (11):
      perf arm-spe: Show instruction sample types by default
      perf arm-spe: Downsample all sample types equally
      perf arm-spe: Display --itrace period warnings for all sample types
      perf docs: Update SPE doc to include default instructions group
      tools headers: Remove unused kvm_perf.h copies
      tools headers: Remove unused arm32 asm/kvm.h copy
      perf arm_spe: Use full type for data_src
      perf test: Refactor brstack test
      perf test: Add syscall and address tests to brstack test
      perf test: Extend branch stack sampling test for Arm64 BRBE
      perf tests: Don't retest sections in "Object code reading"

Kan Liang (1):
      MAINTAINERS: Remove myself from perf_events subsystem

Leo Yan (21):
      perf arm_spe: Correct setting remote access
      perf arm_spe: Correct memory level for remote access
      perf arm_spe: Directly propagate raw event
      perf arm_spe: Decode event types for new features
      perf arm_spe: Add "event_filter" entry in meta data
      perf arm_spe: Refine memory level filling
      perf arm_spe: Separate setting of memory levels for loads and stores
      perf arm_spe: Fill memory levels for FEAT_SPEv1p4
      perf arm_spe: Refactor arm_spe__get_metadata_by_cpu()
      perf arm_spe: Set HITM flag
      perf arm_spe: Allow parsing both data source and events
      perf session: Fix handling when buffer exceeds 2 GiB
      tools build: Align warning options with perf
      perf python: split Clang options when invoking Popen
      perf build: Correct CROSS_ARCH for clang
      perf build: Disable thread safety analysis for perl header
      perf test coresight: Dismiss clang warning for memcpy thread
      perf test coresight: Dismiss clang warning for thread loop
      perf test coresight: Dismiss clang warning for unroll loop thread
      perf build: Support build with clang
      perf docs: Document building with Clang

Markus Heidelberg (1):
      perf tools: Fix duplicated words in documentation and comments

Namhyung Kim (17):
      perf annotate: Rename to __hist_entry__tui_annotate()
      perf annotate: Remove annotation_print_data.start
      perf annotate: Remove __annotation_line__write()
      perf annotate: Pass annotation_print_data to annotation_line__write()
      perf annotate: Simplify width calculation in annotation_line__write()
      perf annotate: Return printed number from disasm_line__write()
      perf annotate: Add --code-with-type support for TUI
      perf annotate: Add 'T' hot key to toggle data type display
      perf annotate: Show warning when debuginfo is not available
      perf annotate: Hide data-type for stack operation and canary
      perf annotate: Add dso__debuginfo() helper
      perf annotate: Use a hashmap to save type data
      perf annotate: Fix signature of annotate_browser__show()
      perf annotate: Factor out annotate_browser__show_function_title()
      perf annotate: Fix title line after return from call
      perf trace: Add --max-summary option
      perf tools: Remove a pointless check

Sam James (1):
      perf bpf: Use __builtin_preserve_field_info for GCC compatibility

Suchit Karunakaran (1):
      perf annotate: Use architecture-agnostic register limit

Thomas Falcon (2):
      perf record: Add ratio-to-prev term
      perf record: Add auto counter reload parse and regression tests

Thomas Richter (1):
      perf tools: Update header documentation on BPF_PROG_INFO

Trevor Allison (1):
      perf test attr: Add missing int_mist.uop_dropping event to test-stat files

Veronika Molnarova (1):
      perf test perftool_testsuite: Use absolute paths

Vincent Minet (1):
      perf tools: Fix arm64 libjvmti build by generating unistd_64.h

Yunseong Kim (2):
      perf arm64: Sync ESR_ELx_EC_* macros in arm64_exception_types.h with esr.h
      perf util: Fix compression checks returning -1 as bool

Zecheng Li (5):
      perf dwarf-aux: Use signed variable types in match_var_offset
      perf dwarf-aux: More accurate variable type match for breg
      perf dwarf-aux: Better variable collection for insn tracking
      perf dwarf-aux: Fix __die_find_scope_cb() for namespaces
      perf annotate: Rename TSR_KIND_POINTER to TSR_KIND_PERCPU_POINTER

 MAINTAINERS                                        |    1 -
 tools/arch/arm/include/uapi/asm/kvm.h              |  315 ----
 tools/arch/s390/include/uapi/asm/kvm_perf.h        |   22 -
 tools/arch/x86/include/uapi/asm/kvm_perf.h         |   17 -
 tools/build/Makefile.feature                       |    6 +-
 tools/build/feature/Makefile                       |   18 +-
 tools/build/feature/test-all.c                     |   19 +-
 tools/build/feature/test-get_current_dir_name.c    |   11 -
 tools/build/feature/test-libbpf-strings.c          |   10 -
 tools/build/feature/test-libslang-include-subdir.c |    7 -
 tools/include/linux/bitmap.h                       |    1 +
 tools/include/linux/gfp_types.h                    |  393 ++++-
 tools/include/uapi/linux/genetlink.h               |  103 ++
 tools/include/uapi/linux/if_addr.h                 |   79 +
 tools/include/uapi/linux/neighbour.h               |  229 +++
 tools/include/uapi/linux/netfilter.h               |   80 +
 tools/include/uapi/linux/netfilter_arp.h           |   23 +
 tools/include/uapi/linux/rtnetlink.h               |  848 ++++++++++
 tools/lib/perf/include/perf/event.h                |    1 +
 tools/lib/perf/mmap.c                              |    2 +-
 tools/perf/Documentation/Build.txt                 |   15 +
 tools/perf/Documentation/android.txt               |   80 +-
 tools/perf/Documentation/intel-acr.txt             |   53 +
 tools/perf/Documentation/perf-annotate.txt         |    1 -
 tools/perf/Documentation/perf-arm-spe.txt          |   14 +-
 tools/perf/Documentation/perf-bench.txt            |   58 +-
 tools/perf/Documentation/perf-check.txt            |    1 +
 tools/perf/Documentation/perf-diff.txt             |    2 +-
 tools/perf/Documentation/perf-list.txt             |    3 +
 tools/perf/Documentation/perf-trace.txt            |    4 +
 tools/perf/Documentation/perf.data-file-format.txt |   10 +
 tools/perf/Makefile.config                         |   96 +-
 tools/perf/Makefile.perf                           |    8 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    5 +
 tools/perf/arch/arm64/util/arm64_exception_types.h |   15 +-
 tools/perf/arch/powerpc/util/Build                 |    1 +
 tools/perf/arch/powerpc/util/auxtrace.c            |  103 ++
 tools/perf/arch/x86/annotate/instructions.c        |    4 +-
 tools/perf/arch/x86/util/evsel.c                   |  114 +-
 tools/perf/arch/x86/util/kvm-stat.c                |   51 +
 tools/perf/bench/bench.h                           |    1 +
 tools/perf/bench/futex.h                           |    1 +
 tools/perf/bench/mem-functions.c                   |  390 +++--
 tools/perf/bench/mem-memcpy-arch.h                 |    2 +-
 tools/perf/bench/mem-memcpy-x86-64-asm-def.h       |    4 +
 tools/perf/bench/mem-memset-arch.h                 |    2 +-
 tools/perf/bench/mem-memset-x86-64-asm-def.h       |    4 +
 tools/perf/builtin-annotate.c                      |    5 -
 tools/perf/builtin-bench.c                         |    1 +
 tools/perf/builtin-check.c                         |    4 +-
 tools/perf/builtin-kvm.c                           |  130 +-
 tools/perf/builtin-kwork.c                         |   27 +-
 tools/perf/builtin-record.c                        |    2 -
 tools/perf/builtin-sched.c                         |   19 +-
 tools/perf/builtin-script.c                        |   34 +-
 tools/perf/builtin-stat.c                          |  185 +-
 tools/perf/builtin-trace.c                         |   14 +-
 tools/perf/check-headers.sh                        |   12 +-
 tools/perf/perf.h                                  |    2 -
 .../arch/arm64/ampere/ampereone/metrics.json       |    8 +-
 .../arch/arm64/ampere/ampereonex/metrics.json      |   10 +-
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  104 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  135 +-
 .../arch/x86/alderlake/floating-point.json         |   28 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |   42 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   12 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |    8 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |  163 +-
 .../arch/x86/alderlake/uncore-interconnect.json    |    2 -
 .../arch/x86/alderlake/virtual-memory.json         |   40 +-
 .../arch/x86/alderlaken/adln-metrics.json          |   20 +-
 .../arch/x86/alderlaken/uncore-interconnect.json   |    2 -
 .../pmu-events/arch/x86/arrowlake/arl-metrics.json |  180 +-
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |  168 +-
 .../pmu-events/arch/x86/arrowlake/frontend.json    |   40 +-
 .../perf/pmu-events/arch/x86/arrowlake/memory.json |   28 +-
 .../perf/pmu-events/arch/x86/arrowlake/other.json  |    2 +-
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |   94 +-
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   30 +-
 .../arch/x86/broadwellde/bdwde-metrics.json        |   30 +-
 .../arch/x86/broadwellx/bdx-metrics.json           |   33 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  139 +-
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |  163 +-
 .../arch/x86/emeraldrapids/emr-metrics.json        |  143 +-
 .../arch/x86/emeraldrapids/floating-point.json     |   43 +-
 .../arch/x86/emeraldrapids/frontend.json           |   42 +-
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |   30 +-
 .../pmu-events/arch/x86/emeraldrapids/other.json   |   28 +-
 .../arch/x86/emeraldrapids/pipeline.json           |  167 +-
 .../arch/x86/emeraldrapids/uncore-cache.json       |   11 +
 .../arch/x86/emeraldrapids/uncore-memory.json      |  104 ++
 .../arch/x86/emeraldrapids/uncore-power.json       |    2 -
 .../arch/x86/emeraldrapids/virtual-memory.json     |   40 +-
 .../perf/pmu-events/arch/x86/grandridge/cache.json |   20 +-
 .../arch/x86/grandridge/grr-metrics.json           |   20 +-
 .../pmu-events/arch/x86/graniterapids/cache.json   |  227 ++-
 .../arch/x86/graniterapids/floating-point.json     |   43 +-
 .../arch/x86/graniterapids/frontend.json           |   42 +-
 .../arch/x86/graniterapids/gnr-metrics.json        |  131 +-
 .../pmu-events/arch/x86/graniterapids/memory.json  |   33 +-
 .../pmu-events/arch/x86/graniterapids/other.json   |   30 +-
 .../arch/x86/graniterapids/pipeline.json           |  167 +-
 .../x86/graniterapids/uncore-interconnect.json     |   10 +-
 .../arch/x86/graniterapids/uncore-io.json          |    1 -
 .../arch/x86/graniterapids/uncore-memory.json      |  143 +-
 .../arch/x86/graniterapids/virtual-memory.json     |   40 +-
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   32 +-
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |   35 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |   96 +-
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  155 +-
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   30 +-
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   33 +-
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   20 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |  150 +-
 .../pmu-events/arch/x86/lunarlake/frontend.json    |   40 +-
 .../pmu-events/arch/x86/lunarlake/lnl-metrics.json |  216 +--
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |   28 +-
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |    2 +-
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |   85 +-
 .../arch/x86/lunarlake/uncore-interconnect.json    |   10 +
 .../arch/x86/lunarlake/uncore-memory.json          |    8 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   20 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  165 +-
 .../arch/x86/meteorlake/floating-point.json        |   28 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   42 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   15 +-
 .../arch/x86/meteorlake/mtl-metrics.json           |  103 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |    5 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  173 +-
 .../arch/x86/meteorlake/virtual-memory.json        |   40 +-
 .../pmu-events/arch/x86/pantherlake/cache.json     | 1207 ++++++++++++-
 .../pmu-events/arch/x86/pantherlake/counter.json   |    9 +-
 .../arch/x86/pantherlake/floating-point.json       |  286 ++++
 .../pmu-events/arch/x86/pantherlake/frontend.json  |  535 ++++++
 .../pmu-events/arch/x86/pantherlake/memory.json    |  106 +-
 .../pmu-events/arch/x86/pantherlake/other.json     |   44 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  | 1776 ++++++++++++++++++--
 .../arch/x86/pantherlake/uncore-memory.json        |   26 +
 .../arch/x86/pantherlake/virtual-memory.json       |  248 +++
 .../arch/x86/rocketlake/rkl-metrics.json           |   97 +-
 .../arch/x86/sandybridge/snb-metrics.json          |   19 +-
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |  163 +-
 .../arch/x86/sapphirerapids/floating-point.json    |   43 +-
 .../arch/x86/sapphirerapids/frontend.json          |   42 +-
 .../pmu-events/arch/x86/sapphirerapids/memory.json |   30 +-
 .../pmu-events/arch/x86/sapphirerapids/other.json  |   28 +-
 .../arch/x86/sapphirerapids/pipeline.json          |  167 +-
 .../arch/x86/sapphirerapids/spr-metrics.json       |  165 +-
 .../arch/x86/sapphirerapids/uncore-cache.json      |   11 +
 .../arch/x86/sapphirerapids/uncore-memory.json     |  104 ++
 .../arch/x86/sapphirerapids/uncore-power.json      |    2 -
 .../arch/x86/sapphirerapids/virtual-memory.json    |   40 +-
 .../pmu-events/arch/x86/sierraforest/cache.json    |   61 +-
 .../arch/x86/sierraforest/srf-metrics.json         |   20 +-
 .../arch/x86/sierraforest/uncore-interconnect.json |   10 +-
 .../arch/x86/sierraforest/uncore-io.json           |    1 -
 .../arch/x86/sierraforest/uncore-memory.json       |  103 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  101 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  101 +-
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |   97 +-
 tools/perf/python/ilist.py                         |  495 ++++++
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
 tools/perf/tests/Build                             |    2 -
 tools/perf/tests/builtin-test.c                    |    2 +-
 tools/perf/tests/code-reading.c                    |  119 +-
 tools/perf/tests/make                              |    8 +-
 tools/perf/tests/parse-events.c                    |   54 +
 tools/perf/tests/perf-record.c                     |   40 +-
 tools/perf/tests/python-use.c                      |   27 -
 tools/perf/tests/shell/amd-ibs-swfilt.sh           |   51 +-
 tools/perf/tests/shell/attr/test-stat-default      |    7 +
 tools/perf/tests/shell/attr/test-stat-detailed-1   |    7 +
 tools/perf/tests/shell/attr/test-stat-detailed-2   |    7 +
 tools/perf/tests/shell/attr/test-stat-detailed-3   |    7 +
 .../shell/base_probe/test_adding_blacklisted.sh    |   20 +-
 .../tests/shell/base_probe/test_adding_kernel.sh   |   97 +-
 tools/perf/tests/shell/base_probe/test_basic.sh    |   31 +-
 .../tests/shell/base_probe/test_invalid_options.sh |   14 +-
 .../tests/shell/base_probe/test_line_semantics.sh  |    7 +-
 tools/perf/tests/shell/base_report/setup.sh        |   10 +-
 tools/perf/tests/shell/base_report/test_basic.sh   |  103 +-
 tools/perf/tests/shell/common/init.sh              |    4 +-
 .../shell/coresight/memcpy_thread/memcpy_thread.c  |    2 +
 .../shell/coresight/thread_loop/thread_loop.c      |    4 +-
 .../unroll_loop_thread/unroll_loop_thread.c        |    4 +-
 tools/perf/tests/shell/lock_contention.sh          |    7 +-
 tools/perf/tests/shell/python-use.sh               |   36 +
 tools/perf/tests/shell/record.sh                   |   40 +
 tools/perf/tests/shell/record_lbr.sh               |   26 +-
 tools/perf/tests/shell/stat+event_uniquifying.sh   |  109 +-
 tools/perf/tests/shell/stat+std_output.sh          |    6 +-
 tools/perf/tests/shell/test_brstack.sh             |  106 +-
 tools/perf/tests/shell/trace_btf_enum.sh           |   11 +
 tools/perf/tests/tests.h                           |    2 +-
 tools/perf/tests/workloads/Build                   |    2 +
 tools/perf/tests/workloads/traploop.c              |   31 +
 tools/perf/ui/browsers/annotate.c                  |  169 +-
 tools/perf/ui/browsers/hists.c                     |    2 +-
 tools/perf/ui/libslang.h                           |    4 -
 tools/perf/util/Build                              |    7 +-
 tools/perf/util/addr2line.c                        |  439 +++++
 tools/perf/util/addr2line.h                        |   20 +
 tools/perf/util/annotate-data.c                    |   15 +-
 tools/perf/util/annotate-data.h                    |   15 +-
 tools/perf/util/annotate.c                         |  181 +-
 tools/perf/util/annotate.h                         |   29 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   37 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   33 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |   14 +
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |    7 +
 tools/perf/util/arm-spe.c                          |  263 ++-
 tools/perf/util/arm-spe.h                          |    2 +
 tools/perf/util/auxtrace.c                         |    9 +-
 tools/perf/util/auxtrace.h                         |    1 +
 tools/perf/util/bpf-filter.c                       |    5 +
 tools/perf/util/bpf-trace-summary.c                |   40 +-
 tools/perf/util/bpf-utils.h                        |   10 +
 tools/perf/util/bpf_counter.c                      |   88 +-
 tools/perf/util/bpf_counter.h                      |   74 +-
 tools/perf/util/bpf_counter_cgroup.c               |    4 +-
 tools/perf/util/bpf_ftrace.c                       |    1 +
 tools/perf/util/bpf_off_cpu.c                      |    1 +
 tools/perf/util/bpf_skel/kwork_top.bpf.c           |    2 -
 tools/perf/util/bpf_skel/sample_filter.bpf.c       |    2 +-
 tools/perf/util/build-id.c                         |    7 +
 tools/perf/util/capstone.c                         |  471 ++++++
 tools/perf/util/capstone.h                         |   24 +
 tools/perf/util/config.c                           |    2 +-
 tools/perf/util/disasm.c                           |  652 +------
 tools/perf/util/disasm.h                           |    6 +-
 tools/perf/util/disasm_bpf.c                       |  195 ---
 tools/perf/util/disasm_bpf.h                       |   12 -
 tools/perf/util/drm_pmu.c                          |    4 +-
 tools/perf/util/dso.c                              |  112 ++
 tools/perf/util/dso.h                              |   25 +
 tools/perf/util/dwarf-aux.c                        |   69 +-
 tools/perf/util/dwarf-aux.h                        |    2 +
 tools/perf/util/env.c                              |   22 +
 tools/perf/util/env.h                              |    2 +
 tools/perf/util/event.h                            |   20 +
 tools/perf/util/evsel.c                            |  165 +-
 tools/perf/util/evsel.h                            |    5 +-
 tools/perf/util/evsel_config.h                     |    1 +
 tools/perf/util/get_current_dir_name.c             |   18 -
 tools/perf/util/get_current_dir_name.h             |    8 -
 tools/perf/util/hist.h                             |   12 +-
 tools/perf/util/hwmon_pmu.h                        |    2 +-
 tools/perf/util/kvm-stat.h                         |   10 +
 tools/perf/util/libbfd.c                           |  600 +++++++
 tools/perf/util/libbfd.h                           |   83 +
 tools/perf/util/llvm.c                             |  273 +++
 tools/perf/util/llvm.h                             |   21 +
 tools/perf/util/lzma.c                             |    2 +-
 tools/perf/util/map.c                              |   19 +-
 tools/perf/util/map.h                              |    6 +-
 tools/perf/util/namespaces.c                       |    7 +-
 tools/perf/util/parse-events.c                     |  143 +-
 tools/perf/util/parse-events.h                     |    4 +-
 tools/perf/util/parse-events.l                     |   23 +-
 tools/perf/util/pmu.c                              |    3 +-
 tools/perf/util/powerpc-vpadtl.c                   |  734 ++++++++
 tools/perf/util/powerpc-vpadtl.h                   |   23 +
 tools/perf/util/print_insn.c                       |  117 +-
 tools/perf/util/python.c                           |  522 +++++-
 tools/perf/util/scripting-engines/Build            |    2 +-
 tools/perf/util/session.c                          |    2 +-
 tools/perf/util/setup.py                           |    5 +-
 tools/perf/util/srcline.c                          |  772 +--------
 tools/perf/util/srcline.h                          |    9 +-
 tools/perf/util/stat.c                             |   56 -
 tools/perf/util/stat.h                             |    4 -
 tools/perf/util/symbol-elf.c                       |  100 +-
 tools/perf/util/symbol-minimal.c                   |    2 +-
 tools/perf/util/symbol.c                           |  138 +-
 tools/perf/util/tool_pmu.c                         |    3 -
 tools/perf/util/tp_pmu.c                           |    2 -
 tools/perf/util/trace.h                            |    4 +-
 tools/perf/util/zlib.c                             |    2 +-
 278 files changed, 16149 insertions(+), 6185 deletions(-)
 delete mode 100644 tools/arch/arm/include/uapi/asm/kvm.h
 delete mode 100644 tools/arch/s390/include/uapi/asm/kvm_perf.h
 delete mode 100644 tools/arch/x86/include/uapi/asm/kvm_perf.h
 delete mode 100644 tools/build/feature/test-get_current_dir_name.c
 delete mode 100644 tools/build/feature/test-libbpf-strings.c
 delete mode 100644 tools/build/feature/test-libslang-include-subdir.c
 create mode 100644 tools/include/uapi/linux/genetlink.h
 create mode 100644 tools/include/uapi/linux/if_addr.h
 create mode 100644 tools/include/uapi/linux/neighbour.h
 create mode 100644 tools/include/uapi/linux/netfilter.h
 create mode 100644 tools/include/uapi/linux/netfilter_arp.h
 create mode 100644 tools/include/uapi/linux/rtnetlink.h
 create mode 100644 tools/perf/Documentation/intel-acr.txt
 create mode 100644 tools/perf/arch/powerpc/util/auxtrace.c
 create mode 100644 tools/perf/pmu-events/arch/x86/lunarlake/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/uncore-memory.json
 create mode 100755 tools/perf/python/ilist.py
 delete mode 100644 tools/perf/tests/python-use.c
 create mode 100755 tools/perf/tests/shell/python-use.sh
 create mode 100644 tools/perf/tests/workloads/traploop.c
 create mode 100644 tools/perf/util/addr2line.c
 create mode 100644 tools/perf/util/addr2line.h
 create mode 100644 tools/perf/util/capstone.c
 create mode 100644 tools/perf/util/capstone.h
 delete mode 100644 tools/perf/util/disasm_bpf.c
 delete mode 100644 tools/perf/util/disasm_bpf.h
 delete mode 100644 tools/perf/util/get_current_dir_name.c
 delete mode 100644 tools/perf/util/get_current_dir_name.h
 create mode 100644 tools/perf/util/libbfd.c
 create mode 100644 tools/perf/util/libbfd.h
 create mode 100644 tools/perf/util/llvm.c
 create mode 100644 tools/perf/util/llvm.h
 create mode 100644 tools/perf/util/powerpc-vpadtl.c
 create mode 100644 tools/perf/util/powerpc-vpadtl.h
