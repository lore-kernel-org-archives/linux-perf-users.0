Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2728E14EC73;
	Sun,  7 Dec 2025 06:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765090188; cv=none; b=GcUVsARadw2B/ufQWeRRBfRGg6zitgCEToFn/5pC8vSPxxeHgUnr2FKtTuwlGKsSGVlYhw/dJQAWl2MqbDohBidB9RzQZ31gRvf4cOAhZRanf9/FQnz0hL8QkjBXcbInaBnywJuVpTc2onqn04pvcYUucolaBi+MuGjAWN/t1O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765090188; c=relaxed/simple;
	bh=PlvkK0aC/4vm6R+iEGGoaBOyExbM+aox2g/PvvOWJb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8s45MdtK6AbJbI39hHSW7ieOy5LeyyBEFPQXx3Zxc7teMpYau7zGkT83sw9AVx8TMldMXgFTs8HjNAy8sZsTQ2jZkgfitVXU9n/pKB64A8c4DwnUtD2oA0UCrQnkKxob445lp6VDFq2WdecX49gsDypW/aqNPVFk6Wx1rDOwEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3jt3GdP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3jt3GdP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CBEC4CEFB;
	Sun,  7 Dec 2025 06:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765090187;
	bh=PlvkK0aC/4vm6R+iEGGoaBOyExbM+aox2g/PvvOWJb0=;
	h=From:To:Cc:Subject:Date:From;
	b=I3jt3GdPYvWwAkBQFpcW78oFNIAEFVi5iT89yjH8Lign8IUMU/qqlLGVeCc0K0Gjk
	 GrLalDPyPeMLDOKx5KNGJ4qLUDBZZvCtLO93BRPU+Ndiyp6GFf3IfZyhQsOigfqBef
	 8Nr+Gss4I0w7TD81QbQ6RVwVPWrEYMUn4YbNbtf3BcafkSNkn9Sm+jbTFEeLrJTNMf
	 FDaRvCQ4oVZh1l6EqNNa2kgARVtEWc3Obwnm3ZaPdLKN/7N9pTtDk3asKuwlK2QNdT
	 x2drP/FieV8jFMNVI544lbYs0sFphd+1aDc5wWGupli4n1QD8h87dpYTcfS2k0fgTD
	 A1lCCxAc2o0eQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools changes for v6.19
Date: Sat,  6 Dec 2025 22:49:43 -0800
Message-ID: <20251207064943.798877-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.52.0.223.gf5cc29aaa4-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.19.

Thanks,
Namhyung


The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.19-2025-12-06

for you to fetch changes up to 2eeb09fe1c5173b659929f92fee4461796ca8c14:

  libperf: Use 'extern' in LIBPERF_API visibility macro (2025-12-05 10:31:32 -0800)

----------------------------------------------------------------
[GIT PULL] perf tools changes for v6.19

Perf event/metric description
-----------------------------
Unify all event and metric descriptions in JSON format.
Now event parsing and handling is greatly simplified by that.

From users point of view, perf list will provide richer
information about hardware events like the following.

    $ perf list hw

    List of pre-defined events (to be used in -e or -M):

    legacy hardware:
      branch-instructions
           [Retired branch instructions [This event is an alias of branches]. Unit: cpu]
      branch-misses
           [Mispredicted branch instructions. Unit: cpu]
      branches
           [Retired branch instructions [This event is an alias of branch-instructions]. Unit: cpu]
      bus-cycles
           [Bus cycles,which can be different from total cycles. Unit: cpu]
      cache-misses
           [Cache misses. Usually this indicates Last Level Cache misses; this is intended to be used in conjunction with the
            PERF_COUNT_HW_CACHE_REFERENCES event to calculate cache miss rates. Unit: cpu]
      cache-references
           [Cache accesses. Usually this indicates Last Level Cache accesses but this may vary depending on your CPU. This may include
            prefetches and coherency messages; again this depends on the design of your CPU. Unit: cpu]
      cpu-cycles
           [Total cycles. Be wary of what happens during CPU frequency scaling [This event is an alias of cycles]. Unit: cpu]
      cycles
           [Total cycles. Be wary of what happens during CPU frequency scaling [This event is an alias of cpu-cycles]. Unit: cpu]
      instructions
           [Retired instructions. Be careful,these can be affected by various issues,most notably hardware interrupt counts. Unit: cpu]
      ref-cycles
           [Total cycles; not affected by CPU frequency scaling. Unit: cpu]

But most notable changes would be in the perf stat.  On the right side,
the default metrics are better named and aligned. :)

    $ perf stat -- perf test -w noploop

     Performance counter stats for 'perf test -w noploop':

                    11      context-switches                 #     10.8 cs/sec  cs_per_second
                     0      cpu-migrations                   #      0.0 migrations/sec  migrations_per_second
                 3,612      page-faults                      #   3532.5 faults/sec  page_faults_per_second
              1,022.51 msec task-clock                       #      1.0 CPUs  CPUs_utilized
               110,466      branch-misses                    #      0.0 %  branch_miss_rate         (88.66%)
         6,934,452,104      branches                         #   6781.8 M/sec  branch_frequency     (88.66%)
         4,657,032,590      cpu-cycles                       #      4.6 GHz  cycles_frequency       (88.65%)
        27,755,874,218      instructions                     #      6.0 instructions  insn_per_cycle  (89.03%)
                            TopdownL1                        #      0.3 %  tma_backend_bound
                                                             #      9.3 %  tma_bad_speculation      (89.05%)
                                                             #      9.7 %  tma_frontend_bound       (77.86%)
                                                             #     80.7 %  tma_retiring             (88.81%)

           1.025318171 seconds time elapsed

           1.013248000 seconds user
           0.012014000 seconds sys

Deferred unwinding support
--------------------------
With the kernel support [1], perf can use deferred callchains for
userspace stack trace with frame pointers like below:

    $ perf record --call-graph fp,defer ...

This will be transparent to users when it comes to other commands like
perf report and perf script.  They will merge the deferred callchains to
the previous samples as if they were collected together.

[1] https://git.kernel.org/torvalds/c/c69993ecdd4dfde2b7da08b022052a33b203da07

ARM SPE updates
---------------
* Extensive enhancements to support various kinds of memory operations
  including GCS, MTE allocation tags, memcpy/memset, register access,
  and SIMD operations.

* Add inverted data source filter (inv_data_src_filter) support to
  exclude certain data sources.

* Improve documentation.

Vendor event updates
--------------------
* Intel: Updated event files for Sierra Forest, Panther Lake, Meteor Lake,
         Lunar Lake, Granite Rapids, and others.

* Arm64: Added metrics for i.MX94 DDR PMU and Cortex-A720AE definitions.

* RISC-V: Added JSON support for T-HEAD C920V2.

Misc
----
* Improve pointer tracking in data type profiling.  It'd give better
  output when the variable is using container_of() to convert type.

* Annotation support for perf c2c report in TUI.  Press 'a' key to
  enter annotation view from cacheline browser window.  This will show
  which instruction is causing the cacheline contention.

* Lots of fixes and test coverage improvements!

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Anubhav Shelat (1):
      perf pmu: fix duplicate conditional statement

Arnaldo Carvalho de Melo (2):
      perf auxtrace: Include sys/types.h for pid_t
      libperf: Use 'extern' in LIBPERF_API visibility macro

Chen Ni (1):
      perf symbol: Remove unneeded semicolon

Chu Guangqing (2):
      perf vendor events arm64: Fix typo in Ampere eMag json file
      perf vendor events AmpereOneX: Fix spelling typo in the metrics file

Hrishikesh Suresh (1):
      perf: replace strcpy() with strncpy() in util/jitdump.c

Ian Rogers (136):
      perf stat: Additional verbose details for <not supported> events
      perf build python: Don't leave a.out file when building with clang
      perf bpf_counter: Fix opening of "any"(-1) CPU events
      perf parse-events: Fix legacy cache events if event is duplicated in a PMU
      perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
      perf stat: Avoid wildcarding PMUs for default events
      perf record: Skip don't fail for events that don't open
      perf jevents: Support copying the source json files to OUTPUT
      perf pmu: Don't eagerly parse event terms
      perf parse-events: Remove unused FILE input argument to scanner
      perf pmu: Use fd rather than FILE from new_alias
      perf pmu: Factor term parsing into a perf_event_attr into a helper
      perf parse-events: Add terms for legacy hardware and cache config values
      perf jevents: Add legacy json terms and default_core event table helper
      perf pmu: Add and use legacy_terms in alias information
      perf jevents: Add legacy-hardware and legacy-cache json
      perf print-events: Remove print_hwcache_events
      perf print-events: Remove print_symbol_events
      perf parse-events: Remove hard coded legacy hardware and cache parsing
      perf record: Use evlist__new_default when no events specified
      perf top: Use evlist__new_default when no events specified
      perf evlist: Avoid scanning all PMUs for evlist__new_default
      perf evsel: Improvements to __evsel__match
      perf test parse-events: Use evsel__match for legacy events
      perf test parse-events: Without a PMU use cpu-cycles rather than cycles
      perf test parse-events: Remove cpu PMU requirement
      perf test: Switch cycles event to cpu-cycles
      perf test: Clean up test_..config helpers
      perf test parse-events: Add evlist test helper
      perf test parse-events: Add evsel test helper
      perf trace: Don't synthesize mmaps unless callchains are enabled
      perf ilist: Don't display deprecated events
      perf python: Add PMU argument to parse_metrics
      perf ilist: Add PMU information to metrics
      perf stat bperf cgroup: Increase MAX_EVENTS from 32 to 1024
      perf parse-events: Make X modifier more respectful of groups
      perf stat: Add/fix bperf cgroup max events workarounds
      perf test workload: Add thread count argument to thloop
      perf tools: Cache counter names for raw samples on s390
      perf evsel: Remove unused metric_events variable
      perf metricgroup: Update comment on location of metric_event list
      perf metricgroup: Missed free on error path
      perf metricgroup: When copy metrics copy default information
      perf jevents: Make all tables static
      perf tool: Add the perf_tool argument to all callbacks
      perf tool: Add a delegate_tool that just delegates actions to another tool
      perf pmu: Make pmu_alias_terms weak again
      perf test: Add test that command line period overrides sysfs/json values
      perf metricgroup: Add care to picking the evsel for displaying a metric
      perf expr: Add #target_cpu literal
      perf jevents: Add set of common metrics based on default ones
      perf jevents: Add metric DefaultShowEvents
      perf stat: Add detail -d,-dd,-ddd metrics
      perf script: Change metric format to use json metrics
      perf stat: Remove hard coded shadow metrics
      perf stat: Fix default metricgroup display on hybrid
      perf stat: Sort default events/metrics
      perf stat: Remove "unit" workarounds for metric-only
      perf test stat+json: Improve metric-only testing
      perf test stat: Ignore failures in Default[234] metricgroups
      perf test stat: Update std_output testing metric expectations
      perf test metrics: Update all metrics for possibly failing default metrics
      perf test stat: Update shadow test to use metrics
      perf test stat: Update test expectations and events
      perf test stat csv: Update test expectations and events
      perf tool_pmu: Make core_wide and target_cpu json events
      perf intel-pt: Use the perf provided "cpuid.h"
      perf build: Don't add NO_AUXTRACE if missing feature-get_cpuid
      tool build: Remove __get_cpuid feature test
      perf build: Remove NO_AUXTRACE build option
      perf auxtrace: Remove errno.h from auxtrace.h and fix transitive dependencies
      perf vendor metrics s390: Avoid has_event(INSTRUCTIONS)
      perf test: Be tolerant of missing json metric none value
      perf parse-events: Add debug logging to perf_event
      perf test: Don't fail if user rdpmc returns 0 when disabled
      perf stat: Display metric-only for 0 counters
      libperf cpumap: Reduce allocations and sorting in intersect
      perf pmu: perf_cpu_map__new_int to avoid parsing a string
      perf tool_pmu: Use old_count when computing count values for time events
      perf stat-shadow: Read tool events directly
      perf stat: Reduce scope of ru_stats
      perf stat: Reduce scope of walltime_nsecs_stats
      perf tool_pmu: More accurately set the cpus for tool events
      perf stat: Read tool events last
      perf maps: Avoid RC_CHK use after free
      perf test maps: Additional maps__fixup_overlap_and_insert tests
      perf header: Switch "cpu" for find_core_pmu in caps feature writing
      perf pmu: Add PMU kind to simplify differentiating
      perf evsel: Skip store_evsel_ids for non-perf-event PMUs
      perf test all metrics: Fully ignore Default metric failures
      perf test: Fix hybrid testing of event fallback test
      perf python: Correct copying of metric_leader in an evsel
      perf ilist: Be tolerant of reading a metric on the wrong CPU
      perf jevents: Allow multiple metricgroups.json files
      perf jevents: Update metric constraint support
      perf jevents: Add descriptions to metricgroup abstraction
      perf jevents: Allow metric groups not to be named
      perf jevents: Support parsing negative exponents
      perf jevents: Term list fix in event parsing
      perf jevents: Add threshold expressions to Metric
      perf jevents: Move json encoding to its own functions
      perf jevents: Drop duplicate pending metrics
      perf jevents: Skip optional metrics in metric group list
      perf vendor events intel: Update alderlake events from 1.34 to 1.35
      perf vendor events intel: Update arrowlake events from 1.13 to 1.14
      perf vendor events intel: Update cascadelakex metric units
      perf vendor events intel: Update graniterapids events from 1.15 to 1.16
      perf vendor events intel: Update icelakex events from 1.28 to 1.30
      perf vendor events intel: Update lunarlake events from 1.18 to 1.19
      perf vendor events intel: Update meteorlake events from 1.17 to 1.18
      perf vendor events intel: Update pantherlake events from 1.00 to 1.02
      perf vendor events intel: Update sierraforest events from 1.12 to 1.13
      perf kvm: Fix debug assertion
      perf timechart: Add record support for output perf.data path
      perf symbol-elf: Add missing puts on error path
      perf symbol: Add missed dso__put
      perf probe-event: Ensure probe event nsinfo is always cleared
      perf hist: In init, ensure mem_info is put on error paths
      perf mem-events: Don't leak online CPU map
      perf jitdump: Fix missed dso__put
      perf c2c: Clean up some defensive gets and make asan clean
      perf tests c2c: Add a basic c2c
      perf tests buildid: Add purge and remove testing
      perf tests top: Add basic perf top coverage test
      perf tests timechart: Add a perf timechart test
      perf tests kallsyms: Add basic kallsyms test
      perf tests script dlfilter: Add a dlfilter test
      perf tests evlist: Add basic evlist test
      perf test kvm: Add some basic perf kvm test coverage
      perf stat: Allow no events to open if this is a "--null" run
      libperf cpumap: Fix perf_cpu_map__max for an empty/NULL map
      perf cpumap: Add "any" CPU handling to cpu_map__snprint_mask
      perf tests stat: Add "--null" coverage
      perf stat: When no events, don't report an error if there is none
      perf tests stat: Add test for error for an offline CPU
      perf stat: Improve handling of termination by signal

Inochi Amaoto (1):
      perf vendor events riscv: add T-HEAD C920V2 JSON support

James Clark (10):
      perf tests: use strdup() in "Object code reading"
      perf jevents: Fix build when there are other json files in the tree
      perf jevents: Remove unused makefile variable
      perf jevents: Suppress circular dependency warnings
      perf annotate: Fix Clang build by adding block in switch case
      perf script: Fix build by removing unused evsel_script()
      tools headers UAPI: Sync linux/perf_event.h with the kernel sources
      perf tools: Add support for perf_event_attr::config4
      perf docs: arm-spe: Document new SPE filtering features
      perf tools: Don't read build-ids from non-regular files

Kuninori Morimoto (1):
      tools: arm64: Add Cortex-A720AE definitions

Leo Yan (19):
      perf cs-etm: Mute enumeration value warning
      perf arm_spe: Fix memset subclass in operation
      perf arm_spe: Unify operation naming
      perf arm_spe: Decode GCS operation
      perf arm_spe: Rename SPE_OP_PKT_IS_OTHER_SVE_OP macro
      perf arm_spe: Decode ASE and FP fields in other operation
      perf arm_spe: Decode SME data processing packet
      perf arm_spe: Remove unused operation types
      perf arm_spe: Consolidate operation types
      perf arm_spe: Introduce data processing macro for SVE operations
      perf arm_spe: Report register access in record
      perf arm_spe: Report MTE allocation tag in record
      perf arm_spe: Report extended memory operations in records
      perf arm_spe: Report associated info for SVE / SME operations
      perf arm_spe: Report memset and memcpy in records
      perf arm_spe: Report GCS in record
      perf arm_spe: Expose SIMD information in other operations
      perf arm_spe: Synthesize memory samples for SIMD operations
      perf arm_spe: Add CPU variants supporting common data source packet

Michal Suchanek (1):
      perf hwmon_pmu: Fix uninitialized variable warning

Namhyung Kim (25):
      perf annotate: Fix build with NO_SLANG=1
      perf lock contention: Load kernel map before lookup
      perf trace: Increase syscall handler map size to 1024
      perf record: Make sure to update build-ID cache
      perf stat: Add ScaleUnit to {cpu,task}-clock JSON description
      perf tools: Fix missing feature check for inherit + SAMPLE_READ
      perf stat: Align metric output without events
      perf list: Print matching PMU events for --unit
      perf list: Share print state with JSON output
      perf list: Support filtering in JSON output
      perf trace: Skip internal syscall arguments
      perf tools: Remove a trailing newline in the event terms
      perf jitdump: Add sym/str-tables to build-ID generation
      perf test: Add python JIT dump test
      tools headers UAPI: Sync linux/perf_event.h for deferred callchains
      perf tools: Minimal DEFERRED_CALLCHAIN support
      perf record: Add --call-graph fp,defer option for deferred callchains
      perf script: Display PERF_RECORD_CALLCHAIN_DEFERRED
      perf tools: Merge deferred user callchains
      perf tools: Flush remaining samples w/o deferred callchains
      perf tools: Mark split kallsyms DSOs as loaded
      perf tools: Fix split kallsyms DSO counting
      perf tools: Fallback to initial kernel map properly
      perf tools: Use machine->root_dir to find /proc/kallsyms
      perf test: Add kallsyms split test

Shuai Xue (1):
      perf record: skip synthesize event when open evsel failed

Tianyou Li (4):
      perf c2c: Add annotation support to perf c2c report
      perf c2c annotate: Start from the contention line
      perf annotate: fix a crash when annotate the same symbol with 's' and 'T'
      perf annotate: Check return value of evsel__get_arch() properly

Xu Yang (1):
      perf vendor events arm64:: Add i.MX94 DDR Performance Monitor metrics

Zecheng Li (5):
      perf annotate: Skip annotating data types to lea instructions
      perf annotate: Track address registers via TSR_KIND_POINTER
      perf annotate: Track arithmetic instructions on pointers
      perf annotate: Save pointer offset in stack state
      perf annotate: Invalidate register states for untracked instructions

Zide Chen (1):
      perf test: Add a perf event fallback test

liujing (1):
      perf sample: Fix the wrong format specifier

tanze (1):
      perf auxtrace: Add auxtrace_synth_id_range_start() helper

 tools/arch/arm64/include/asm/cputype.h             |    2 +
 tools/build/Makefile.feature                       |    2 -
 tools/build/feature/Makefile                       |    4 -
 tools/build/feature/test-all.c                     |    5 -
 tools/build/feature/test-get_cpuid.c               |    8 -
 tools/include/uapi/linux/perf_event.h              |   23 +-
 tools/lib/perf/cpumap.c                            |   39 +-
 tools/lib/perf/include/perf/core.h                 |    2 +-
 tools/lib/perf/include/perf/event.h                |   13 +
 tools/perf/Documentation/perf-arm-spe.txt          |  104 +-
 tools/perf/Documentation/perf-c2c.txt              |    7 +
 tools/perf/Documentation/perf-check.txt            |    1 -
 tools/perf/Documentation/perf-config.txt           |    3 +
 tools/perf/Documentation/perf-record.txt           |    4 +
 tools/perf/Documentation/perf-script.txt           |    5 +
 tools/perf/Documentation/perf-timechart.txt        |    3 +
 tools/perf/Makefile.config                         |   13 -
 tools/perf/Makefile.perf                           |   23 +-
 tools/perf/arch/arm/annotate/instructions.c        |    1 +
 tools/perf/arch/arm/util/Build                     |    2 +-
 tools/perf/arch/arm/util/auxtrace.c                |    1 +
 tools/perf/arch/arm/util/pmu.c                     |    2 -
 tools/perf/arch/arm64/annotate/instructions.c      |    1 +
 tools/perf/arch/arm64/util/Build                   |   19 +-
 tools/perf/arch/arm64/util/arm-spe.c               |    1 +
 tools/perf/arch/arm64/util/hisi-ptt.c              |    1 +
 tools/perf/arch/powerpc/util/Build                 |    2 +-
 tools/perf/arch/powerpc/util/auxtrace.c            |    2 +-
 tools/perf/arch/s390/util/Build                    |    2 +-
 tools/perf/arch/s390/util/auxtrace.c               |    1 +
 tools/perf/arch/x86/annotate/instructions.c        |  183 +-
 tools/perf/arch/x86/tests/Build                    |    4 +-
 tools/perf/arch/x86/tests/arch-tests.c             |    4 -
 tools/perf/arch/x86/tests/intel-pt-test.c          |    6 +-
 tools/perf/arch/x86/tests/topdown.c                |    1 +
 tools/perf/arch/x86/util/Build                     |    6 +-
 tools/perf/arch/x86/util/intel-pt.c                |    6 +-
 tools/perf/arch/x86/util/pmu.c                     |    2 -
 tools/perf/arch/x86/util/topdown.c                 |    1 +
 tools/perf/bench/evlist-open-close.c               |    1 +
 tools/perf/bench/futex.c                           |    1 +
 tools/perf/bench/inject-buildid.c                  |    2 +-
 tools/perf/bench/pmu-scan.c                        |    1 +
 tools/perf/bench/synthesize.c                      |    1 +
 tools/perf/builtin-annotate.c                      |    5 +-
 tools/perf/builtin-buildid-cache.c                 |    8 +-
 tools/perf/builtin-c2c.c                           |  195 +-
 tools/perf/builtin-check.c                         |    1 -
 tools/perf/builtin-evlist.c                        |    3 +-
 tools/perf/builtin-inject.c                        |   52 +-
 tools/perf/builtin-kvm.c                           |    2 +-
 tools/perf/builtin-list.c                          |  169 +-
 tools/perf/builtin-mem.c                           |    1 +
 tools/perf/builtin-record.c                        |  161 +-
 tools/perf/builtin-report.c                        |    6 +-
 tools/perf/builtin-script.c                        |  392 ++-
 tools/perf/builtin-stat.c                          |  297 +-
 tools/perf/builtin-timechart.c                     |   15 +-
 tools/perf/builtin-top.c                           |    8 +-
 tools/perf/builtin-trace.c                         |   25 +-
 tools/perf/pmu-events/Build                        |   27 +-
 .../arch/arm64/ampere/ampereonex/metrics.json      |   16 +-
 .../pmu-events/arch/arm64/ampere/emag/cache.json   |    2 +-
 .../arch/arm64/freescale/imx94/sys/ddrc.json       |    9 +
 .../arch/arm64/freescale/imx94/sys/metrics.json    |  450 +++
 .../arch/common/common/legacy-hardware.json        |   72 +
 .../pmu-events/arch/common/common/metrics.json     |  151 ++
 .../pmu-events/arch/common/common/software.json    |    6 +-
 tools/perf/pmu-events/arch/common/common/tool.json |   12 +
 tools/perf/pmu-events/arch/riscv/mapfile.csv       |    1 +
 .../pmu-events/arch/s390/cf_z16/transaction.json   |    8 +-
 .../pmu-events/arch/s390/cf_z17/transaction.json   |    8 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |   16 +-
 .../pmu-events/arch/x86/alderlake/pipeline.json    |    6 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |   16 +-
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |    6 +-
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |  337 ++-
 .../arch/x86/arrowlake/floating-point.json         |   73 +
 .../pmu-events/arch/x86/arrowlake/frontend.json    |   72 +
 .../perf/pmu-events/arch/x86/arrowlake/memory.json |   64 +
 .../perf/pmu-events/arch/x86/arrowlake/other.json  |  119 +
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |  350 +++
 .../arch/x86/arrowlake/virtual-memory.json         |  113 +
 .../arch/x86/cascadelakex/uncore-cache.json        |    2 +-
 .../arch/x86/cascadelakex/uncore-memory.json       |   12 +-
 .../pmu-events/arch/x86/graniterapids/cache.json   |    4 +-
 .../arch/x86/graniterapids/uncore-cache.json       |    9 +
 .../pmu-events/arch/x86/icelakex/uncore-cache.json |    4 +-
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |   20 +-
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |    1 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |   26 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   18 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |   20 +-
 .../pmu-events/arch/x86/pantherlake/cache.json     |   38 +
 .../arch/x86/pantherlake/floating-point.json       |   73 +
 .../pmu-events/arch/x86/pantherlake/memory.json    |    9 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  |  305 ++-
 .../pmu-events/arch/x86/sierraforest/cache.json    |   20 +-
 .../arch/x86/sierraforest/uncore-cache.json        |    9 +
 tools/perf/pmu-events/empty-pmu-events.c           | 2854 +++++++++++++++++++-
 tools/perf/pmu-events/jevents.py                   |   73 +-
 tools/perf/pmu-events/make_legacy_cache.py         |  129 +
 tools/perf/pmu-events/metric.py                    |   85 +-
 tools/perf/pmu-events/metric_test.py               |    4 +
 tools/perf/pmu-events/pmu-events.h                 |    3 +
 tools/perf/python/ilist.py                         |   32 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |    3 +-
 tools/perf/tests/code-reading.c                    |   11 +-
 tools/perf/tests/hwmon_pmu.c                       |    1 +
 tools/perf/tests/kallsyms-split.c                  |  156 ++
 tools/perf/tests/keep-tracking.c                   |    2 +-
 tools/perf/tests/make                              |    4 +-
 tools/perf/tests/maps.c                            |   82 +-
 tools/perf/tests/mmap-basic.c                      |    2 +-
 tools/perf/tests/parse-events.c                    | 2034 +++++++-------
 tools/perf/tests/parse-metric.c                    |    3 +-
 tools/perf/tests/pe-file-parsing.c                 |    4 +-
 tools/perf/tests/perf-time-to-tsc.c                |    4 +-
 tools/perf/tests/pfm.c                             |    1 +
 tools/perf/tests/pmu-events.c                      |   26 +-
 tools/perf/tests/pmu.c                             |    3 +-
 tools/perf/tests/sdt.c                             |    2 +-
 tools/perf/tests/shell/buildid.sh                  |  203 +-
 tools/perf/tests/shell/c2c.sh                      |   62 +
 tools/perf/tests/shell/evlist.sh                   |   79 +
 tools/perf/tests/shell/jitdump-python.sh           |   81 +
 tools/perf/tests/shell/kallsyms.sh                 |   56 +
 tools/perf/tests/shell/kvm.sh                      |  154 ++
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    9 +-
 tools/perf/tests/shell/lib/stat_output.sh          |    2 +-
 tools/perf/tests/shell/record_weak_term.sh         |   37 +
 tools/perf/tests/shell/script_dlfilter.sh          |  107 +
 tools/perf/tests/shell/stat+csv_output.sh          |    2 +-
 tools/perf/tests/shell/stat+json_output.sh         |    2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |    4 +-
 tools/perf/tests/shell/stat+std_output.sh          |    4 +-
 tools/perf/tests/shell/stat.sh                     |   45 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |    3 +
 tools/perf/tests/shell/stat_all_metrics.sh         |   30 +-
 tools/perf/tests/shell/test_event_open_fallback.sh |   71 +
 tools/perf/tests/shell/timechart.sh                |   67 +
 tools/perf/tests/shell/top.sh                      |   74 +
 tools/perf/tests/switch-tracking.c                 |    2 +-
 tools/perf/tests/tests.h                           |    3 +-
 tools/perf/tests/workloads/thloop.c                |   45 +-
 tools/perf/ui/browsers/annotate.c                  |   74 +-
 tools/perf/ui/browsers/hists.c                     |    2 +-
 tools/perf/ui/hist.c                               |    1 +
 tools/perf/util/Build                              |   24 +-
 tools/perf/util/annotate-data.c                    |   92 +-
 tools/perf/util/annotate-data.h                    |   14 +-
 tools/perf/util/annotate.c                         |   24 +-
 tools/perf/util/annotate.h                         |    2 +
 tools/perf/util/arm-spe-decoder/Build              |    2 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c  |   56 +-
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   61 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |   53 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.h     |   40 +-
 tools/perf/util/arm-spe.c                          |   32 +-
 tools/perf/util/auxtrace.c                         |   25 +-
 tools/perf/util/auxtrace.h                         |  227 +-
 tools/perf/util/bpf-filter.h                       |    2 +
 tools/perf/util/bpf-trace-summary.c                |    1 +
 tools/perf/util/bpf_counter.c                      |    7 +-
 tools/perf/util/bpf_counter_cgroup.c               |   80 +-
 tools/perf/util/bpf_ftrace.c                       |    3 +-
 tools/perf/util/bpf_lock_contention.c              |    6 +-
 tools/perf/util/bpf_map.c                          |    1 +
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |    4 +-
 tools/perf/util/bpf_skel/bperf_cgroup.bpf.c        |   18 +-
 tools/perf/util/bpf_skel/bperf_cgroup.h            |   15 +
 tools/perf/util/build-id.c                         |    4 +-
 tools/perf/util/callchain.c                        |   51 +-
 tools/perf/util/callchain.h                        |    4 +
 tools/perf/util/cgroup.c                           |    1 +
 tools/perf/util/config.c                           |    3 +-
 tools/perf/util/cpumap.c                           |    9 +-
 tools/perf/util/cs-etm-decoder/Build               |    2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   44 +-
 tools/perf/util/cs-etm.c                           |    7 +-
 tools/perf/util/debuginfo.c                        |    2 +-
 tools/perf/util/drm_pmu.c                          |    3 +-
 tools/perf/util/dsos.c                             |    4 +-
 tools/perf/util/event.c                            |    1 +
 tools/perf/util/evlist.c                           |   19 +-
 tools/perf/util/evlist.h                           |    2 +
 tools/perf/util/evsel.c                            |   79 +-
 tools/perf/util/evsel.h                            |    3 +-
 tools/perf/util/evsel_fprintf.c                    |    5 +-
 tools/perf/util/evswitch.c                         |    1 +
 tools/perf/util/expr.c                             |    8 +-
 tools/perf/util/genelf.c                           |   32 +-
 tools/perf/util/header.c                           |    9 +-
 tools/perf/util/header.h                           |    6 +-
 tools/perf/util/hisi-ptt-decoder/Build             |    2 +-
 tools/perf/util/hist.c                             |    6 +-
 tools/perf/util/hist.h                             |   12 +-
 tools/perf/util/hwmon_pmu.c                        |    5 +-
 tools/perf/util/intel-bts.c                        |    4 +-
 tools/perf/util/intel-pt-decoder/Build             |    8 +-
 tools/perf/util/intel-pt.c                         |    4 +-
 tools/perf/util/intel-tpebs.c                      |    4 +-
 tools/perf/util/jitdump.c                          |    5 +-
 tools/perf/util/kvm-stat.h                         |    1 +
 tools/perf/util/libbfd.c                           |    9 +-
 tools/perf/util/libbfd.h                           |    5 +-
 tools/perf/util/machine.c                          |    1 +
 tools/perf/util/maps.c                             |   22 +-
 tools/perf/util/mem-events.c                       |    5 +-
 tools/perf/util/metricgroup.c                      |   95 +-
 tools/perf/util/metricgroup.h                      |    2 +-
 tools/perf/util/mmap.c                             |    1 +
 tools/perf/util/parse-events.c                     |  320 +--
 tools/perf/util/parse-events.h                     |   23 +-
 tools/perf/util/parse-events.l                     |   55 +-
 tools/perf/util/parse-events.y                     |  114 +-
 tools/perf/util/perf_api_probe.c                   |   27 +-
 tools/perf/util/perf_event_attr_fprintf.c          |    2 +
 tools/perf/util/pfm.c                              |    1 +
 tools/perf/util/pmu.c                              |  319 ++-
 tools/perf/util/pmu.h                              |   33 +
 tools/perf/util/powerpc-vpadtl.c                   |    5 +-
 tools/perf/util/print-events.c                     |  112 -
 tools/perf/util/print-events.h                     |    4 -
 tools/perf/util/probe-event.c                      |   12 +-
 tools/perf/util/python.c                           |   88 +-
 tools/perf/util/s390-sample-raw.c                  |   55 +-
 tools/perf/util/sample.h                           |    2 +
 tools/perf/util/session.c                          |  182 +-
 tools/perf/util/session.h                          |    3 +-
 tools/perf/util/setup.py                           |   13 +-
 tools/perf/util/stat-display.c                     |   68 +-
 tools/perf/util/stat-shadow.c                      |  547 +---
 tools/perf/util/stat.c                             |    3 +-
 tools/perf/util/stat.h                             |   28 +-
 tools/perf/util/symbol-elf.c                       |   18 +-
 tools/perf/util/symbol-minimal.c                   |   11 +-
 tools/perf/util/symbol.c                           |   22 +-
 tools/perf/util/symbol.h                           |    2 +-
 tools/perf/util/synthetic-events.c                 |    4 +-
 tools/perf/util/synthetic-events.h                 |   15 -
 tools/perf/util/tool.c                             |  222 +-
 tools/perf/util/tool.h                             |   23 +-
 tools/perf/util/tool_pmu.c                         |  102 +-
 tools/perf/util/tool_pmu.h                         |   10 +-
 246 files changed, 11150 insertions(+), 3671 deletions(-)
 delete mode 100644 tools/build/feature/test-get_cpuid.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/common/common/legacy-hardware.json
 create mode 100644 tools/perf/pmu-events/arch/common/common/metrics.json
 create mode 100755 tools/perf/pmu-events/make_legacy_cache.py
 create mode 100644 tools/perf/tests/kallsyms-split.c
 create mode 100755 tools/perf/tests/shell/c2c.sh
 create mode 100755 tools/perf/tests/shell/evlist.sh
 create mode 100755 tools/perf/tests/shell/jitdump-python.sh
 create mode 100755 tools/perf/tests/shell/kallsyms.sh
 create mode 100755 tools/perf/tests/shell/kvm.sh
 create mode 100755 tools/perf/tests/shell/record_weak_term.sh
 create mode 100755 tools/perf/tests/shell/script_dlfilter.sh
 create mode 100755 tools/perf/tests/shell/test_event_open_fallback.sh
 create mode 100755 tools/perf/tests/shell/timechart.sh
 create mode 100755 tools/perf/tests/shell/top.sh
 create mode 100644 tools/perf/util/bpf_skel/bperf_cgroup.h
