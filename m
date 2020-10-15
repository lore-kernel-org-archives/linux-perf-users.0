From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [GIT PULL] perf tools changes for v5.10
Date: Thu, 15 Oct 2020 17:26:40 -0300
Message-ID: <20201015202640.2165631-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Alexey Budankov <alexey.budankov@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, Barry Song <song.bao.hua@hisilicon.com>, Ben Hutchings <ben@decadent.org.uk>, Changbin Du <changbin.du@gmail.com>, Hagen Paul Pfeifer <hagen@jauu.net>, Ian Rogers <irogers@google.com>, James Clark <james.clark@arm.com>, Jin Yao <yao.jin@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Joel Fernandes <joel@joelfernandes.org>, Kajol Jain <kjain@linux.ibm.com>, Kan Liang <kan.liang@lin>
List-Id: linux-perf-users.vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

The following changes since commit fb0155a09b0224a7147cb07a4ce6034c8d29667f:

  Merge tag 'nfs-for-5.9-3' of git://git.linux-nfs.org/projects/trondmy/linux-nfs (2020-09-28 11:05:56 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.10-2020-10-15

for you to fetch changes up to 744aec4df2c5b4d12af26a57d8858af2f59ef3d0:

  perf c2c: Update documentation for metrics reorganization (2020-10-15 12:02:12 -0300)

----------------------------------------------------------------
perf tools changes for v5.10: 1st batch

- cgroup improvements for 'perf stat', allowing for compact specification of events
  and cgroups in the command line.

- Support per thread topdown metrics in 'perf stat'.

- Support sample-read topdown metric group in 'perf record'

- Show start of latency in addition to its start in 'perf sched latency'.

- Add min, max to 'perf script' futex-contention output, in addition to avg.

- Allow usage of 'perf_event_attr->exclusive' attribute via the new ':e' event
  modifier.

- Add 'snapshot' command to 'perf record --control', using it with Intel PT.

- Support FIFO file names as alternative options to 'perf record --control'.

- Introduce branch history "streams", to compare 'perf record' runs with
  'perf diff' based on branch records and report hot streams.

- Support PE executable symbol tables using libbfd, to profile, for instance, wine binaries.

- Add filter support for option 'perf ftrace -F/--funcs'.

- Allow configuring the 'disassembler_style' 'perf annotate' knob via 'perf config'

- Update CascadelakeX and SkylakeX JSON vendor events files.

- Add support for parsing perchip/percore JSON vendor events.

- Add power9 hv_24x7 core level metric events.

- Add L2 prefetch, ITLB instruction fetch hits JSON events for AMD zen1.

- Enable Family 19h users by matching Zen2 AMD vendor events.

- Use debuginfod in 'perf probe' when required debug files not found locally.

- Display negative tid in non-sample events in 'perf script'.

- Make GTK2 support opt-in

- Add build test with GTK+

- Add missing -lzstd to the fast path feature detection

- Add scripts to auto generate 'mmap', 'mremap' string<->id tables for use in 'perf trace'.

- Show python test script in verbose mode.

- Fix uncore metric expressions

- Msan uninitialized use fixes.

- Use condition variables in 'perf bench numa'

- Autodetect python3 binary in systems without python2.

- Support md5 build ids in addition to sha1.

- Add build id 'perf test' regression test.

- Fix printable strings in python3 scripts.

- Fix off by ones in 'perf trace' in arches using libaudit.

- Fix JSON event code for events referencing std arch events.

- Introduce 'perf test' shell script for Arm CoreSight testing.

- Add rdtsc() for Arm64 for used in the PERF_RECORD_TIME_CONV metadata
  event and in 'perf test tsc'.

- 'perf c2c' improvements: Add "RMT Load Hit" metric, "Total Stores", fixes
  and documentation update.

- Fix usage of reloc_sym in 'perf probe' when using both kallsyms and debuginfo files.

- Do not print 'Metric Groups:' unnecessarily in 'perf list'

- Refcounting fixes in the event parsing code.

- Add expand cgroup event 'perf test' entry.

- Fix out of bounds CPU map access when handling armv8_pmu events in 'perf stat'.

- Add build-id injection 'perf bench' benchmark.

- Enter namespace when reading build-id in 'perf inject'.

- Do not load map/dso when injecting build-id speeding up the 'perf inject' process.

- Add --buildid-all option to avoid processing all samples, just the mmap metadata events.

- Add feature test to check if libbfd has buildid support

- Add 'perf test' entry for PE binary format support.

- Fix typos in power8 PMU vendor events JSON files.

- Hide libtraceevent non API functions.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Test results in the signed tag.

Adrian Hunter (9):
      perf tools: Consolidate --control option parsing into one function
      perf tools: Handle read errors from ctl_fd
      perf tools: Use AsciiDoc formatting for --control option documentation
      perf tools: Add FIFO file names as alternative options to --control
      perf record: Add 'snapshot' control command
      perf intel-pt: Document snapshot control command
      perf tools: Consolidate close_control_option()'s into one function
      perf script: Display negative tid in non-sample events
      perf intel-pt: Fix "context_switch event has no tid" error

Andi Kleen (4):
      perf stat: Support new per thread TopDown metrics
      perf tools: Add documentation for topdown metrics
      perf tools: Add support for exclusive groups/events
      perf intel-pt: Improve PT documentation slightly

Arnaldo Carvalho de Melo (16):
      tools features: Add feature test to check if libbfd has buildid support
      perf annotate: Allow configuring the 'disassembler_style' knob via 'perf config'
      perf annotate: Add 'ret' (intel disasm style) as an alias for 'retq'
      perf tools: Make GTK2 support opt-in
      tools feature: Add missing -lzstd to the fast path feature detection
      perf tools: Add build test with GTK+
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf tools: Separate the checking of headers only used to build beautification tables
      perf trace beauty: Add script to autogenerate mremap's flags args string/id table
      perf beauty mmap_flags: Conditionaly define the mmap flags
      tools beauty: Add script to generate table of mmap's 'prot' argument
      perf trace: Use the autogenerated mmap 'prot' string/id table
      Merge branch 'perf/urgent' into perf/core
      perf tests: Show python test script in verbose mode
      perf config: Export the perf_config_from_file() function

Changbin Du (1):
      perf: ftrace: Add filter support for option -F/--funcs

Hagen Paul Pfeifer (2):
      perf script: Autopep8 futex-contention
      perf script: Add min, max to futex-contention output, in addition to avg

Ian Rogers (6):
      perf stat: Remove dead code: no need to set os.evsel twice
      perf metricgroup: Fix typo in comment.
      perf metricgroup: Fix uncore metric expressions
      perf parse-events: Reduce casts around bp_addr
      perf test: Fix msan uninitialized use.
      perf bench: Use condition variables in numa.

James Clark (1):
      perf python: Autodetect python3 binary

Jin Yao (10):
      perf stat: Skip duration_time in setup_system_wide
      perf vendor events intel: Update CascadelakeX events to v1.08
      perf vendor events: Update SkylakeX events to v1.21
      perf streams: Introduce branch history "streams"
      perf streams: Get the evsel_streams by evsel_idx
      perf streams: Compare two streams
      perf streams: Link stream pair
      perf streams: Calculate the sum of total streams hits
      perf streams: Report hot streams
      perf diff: Support hot streams comparison

Jiri Olsa (12):
      perf tests: Call test_attr__open() directly
      perf machine: Add machine__for_each_dso() function
      perf python scripting: Fix printable strings in python3 scripts
      perf tools: Use build_id object in dso
      perf tools: Pass build_id object to filename__read_build_id()
      perf tools: Pass build id object to sysfs__read_build_id()
      perf tools: Pass build_id object to build_id__sprintf()
      perf tools: Pass build_id object to dso__set_build_id()
      perf tools: Pass build_id object to dso__build_id_equal()
      perf tools: Add size to 'struct perf_record_header_build_id'
      perf tools: Align buildid list output for short build ids
      perf test: Add build id shell test

Jiri Slaby (1):
      perf trace: Fix off by ones in memset() after realloc() in arches using libaudit

Joel Fernandes (Google) (1):
      perf sched: Show start of latency as well

John Garry (1):
      perf jevents: Fix event code for events referencing std arch events

Kajol Jain (5):
      perf jevents: Make json_events() static and ditch jevents.h file
      perf jevents: Add new structure to pass json fields.
      perf jevents: Add support for parsing perchip/percore events
      perf metricgroup: Pass pmu_event structure as a parameter for arch_get_runtimeparam()
      perf vendor events power9: Add hv_24x7 core level metric events

Kan Liang (2):
      perf tools: Rename group to topdown
      perf record: Support sample-read topdown metric group

Kim Phillips (4):
      perf vendor events amd: Add L2 Prefetch events for zen1
      perf vendor events amd: Add ITLB Instruction Fetch Hits event for zen1
      perf vendor events amd: Add recommended events
      perf vendor events amd: Enable Family 19h users by matching Zen2 events

Leo Yan (15):
      perf test: Introduce script for Arm CoreSight testing
      perf tsc: Move out common functions from x86
      perf tsc: Add rdtsc() for Arm64
      perf tsc: Calculate timestamp with cap_user_time_short
      perf tsc: Support cap_user_time_short for event TIME_CONV
      perf c2c: Update usage for showing memory events
      perf c2c: Display the total numbers continuously
      perf c2c: Display "Total Stores" as a standalone metrics
      perf c2c: Organize metrics based on memory hierarchy
      perf c2c: Change header from "LLC Load Hitm" to "Load Hitm"
      perf c2c: Use more explicit headers for HITM
      perf c2c: Change header for LLC local hit
      perf c2c: Correct LLC load hit metrics
      perf c2c: Add metrics "RMT Load Hit"
      perf c2c: Update documentation for metrics reorganization

Masami Hiramatsu (2):
      perf probe: Fix to adjust symbol address with correct reloc_sym address
      perf probe: Fall back to debuginfod query if debuginfo and source not found locally

Namhyung Kim (16):
      perf list: Remove dead code in argument check
      perf list: Do not print 'Metric Groups:' unnecessarily
      perf parse-event: Fix cpu map refcounting
      perf parse-event: Release cpu_map refcount if evsel alloc failed
      perf evsel: Add evsel__clone() function
      perf stat: Add --for-each-cgroup option
      perf tools: Copy metric events properly when expand cgroups
      perf tools: Allow creation of cgroup without open
      perf test: Add expand cgroup event test
      perf stat: Fix out of bounds CPU map access when handling armv8_pmu events
      perf bench: Add build-id injection benchmark
      perf inject: Add missing callbacks in perf_tool
      perf inject: Enter namespace when reading build-id
      perf inject: Do not load map/dso when injecting build-id
      perf inject: Add --buildid-all option
      perf bench: Run inject-build-id with --buildid-all option too

Remi Bernon (3):
      perf dso: Use libbfd to read build_id and .gnu_debuglink section
      perf symbols: Try reading the symbol table with libbfd
      perf tests: Add test for PE binary format support

Sandipan Das (1):
      perf vendor events: Fix typos in power8 PMU events

Tzvetomir Stoyanov (VMware) (1):
      tools lib traceevent: Hide non API functions

Vasily Gorbik (1):
      perf build: Allow nested externs to enable BUILD_BUG() usage

YueHaibing (1):
      perf metric: Remove duplicate include

Zejiang Tang (1):
      perf docs: Improve help information in perf.txt

 tools/build/Makefile.feature                       |    7 +-
 tools/build/feature/Makefile                       |    6 +-
 tools/build/feature/test-all.c                     |   15 +-
 tools/build/feature/test-libbfd-buildid.c          |    8 +
 tools/lib/perf/evlist.c                            |    3 +
 tools/lib/perf/include/perf/event.h                |   16 +-
 tools/lib/traceevent/event-parse-api.c             |    8 +-
 tools/lib/traceevent/event-parse-local.h           |   24 +-
 tools/lib/traceevent/event-parse.c                 |  125 +-
 tools/lib/traceevent/event-parse.h                 |    8 -
 tools/lib/traceevent/event-plugin.c                |    2 +-
 tools/lib/traceevent/parse-filter.c                |   23 +-
 tools/perf/Documentation/perf-c2c.txt              |   34 +-
 tools/perf/Documentation/perf-config.txt           |    5 +
 tools/perf/Documentation/perf-diff.txt             |    4 +
 tools/perf/Documentation/perf-ftrace.txt           |    3 +-
 tools/perf/Documentation/perf-inject.txt           |    6 +-
 tools/perf/Documentation/perf-intel-pt.txt         |   53 +-
 tools/perf/Documentation/perf-list.txt             |    1 +
 tools/perf/Documentation/perf-record.txt           |   56 +-
 tools/perf/Documentation/perf-stat.txt             |   60 +-
 tools/perf/Documentation/perf.txt                  |   69 +-
 tools/perf/Documentation/topdown.txt               |  256 +++
 tools/perf/Makefile.config                         |   27 +-
 tools/perf/Makefile.perf                           |   24 +-
 tools/perf/arch/arm64/util/Build                   |    1 +
 tools/perf/arch/arm64/util/tsc.c                   |   21 +
 tools/perf/arch/powerpc/util/header.c              |    7 +-
 tools/perf/arch/x86/annotate/instructions.c        |    1 +
 tools/perf/arch/x86/util/Build                     |    2 +-
 tools/perf/arch/x86/util/group.c                   |   28 -
 tools/perf/arch/x86/util/topdown.c                 |   63 +
 tools/perf/arch/x86/util/tsc.c                     |   73 +-
 tools/perf/bench/Build                             |    1 +
 tools/perf/bench/bench.h                           |    1 +
 tools/perf/bench/inject-buildid.c                  |  476 ++++
 tools/perf/bench/numa.c                            |   67 +-
 tools/perf/builtin-bench.c                         |    1 +
 tools/perf/builtin-buildid-cache.c                 |   25 +-
 tools/perf/builtin-c2c.c                           |   85 +-
 tools/perf/builtin-diff.c                          |  119 +-
 tools/perf/builtin-ftrace.c                        |   84 +-
 tools/perf/builtin-inject.c                        |  203 +-
 tools/perf/builtin-list.c                          |    7 -
 tools/perf/builtin-record.c                        |   68 +-
 tools/perf/builtin-sched.c                         |   24 +-
 tools/perf/builtin-script.c                        |   10 +-
 tools/perf/builtin-stat.c                          |  136 +-
 tools/perf/builtin-trace.c                         |    6 +-
 tools/perf/builtin-version.c                       |    1 -
 tools/perf/check-headers.sh                        |   22 +-
 tools/perf/perf-sys.h                              |   22 +-
 .../perf/pmu-events/arch/powerpc/power8/cache.json |   10 +-
 .../pmu-events/arch/powerpc/power8/frontend.json   |   12 +-
 .../pmu-events/arch/powerpc/power8/marked.json     |   10 +-
 .../perf/pmu-events/arch/powerpc/power8/other.json |   16 +-
 .../arch/powerpc/power8/translation.json           |    2 +-
 .../arch/powerpc/power9/nest_metrics.json          |   35 +-
 tools/perf/pmu-events/arch/x86/amdzen1/branch.json |    5 +
 tools/perf/pmu-events/arch/x86/amdzen1/cache.json  |   41 +
 .../pmu-events/arch/x86/amdzen1/data-fabric.json   |   98 +
 .../pmu-events/arch/x86/amdzen1/recommended.json   |  178 ++
 tools/perf/pmu-events/arch/x86/amdzen2/cache.json  |   23 +
 .../pmu-events/arch/x86/amdzen2/data-fabric.json   |   98 +
 .../pmu-events/arch/x86/amdzen2/recommended.json   |  178 ++
 .../pmu-events/arch/x86/cascadelakex/cache.json    |   28 +-
 .../arch/x86/cascadelakex/clx-metrics.json         |  153 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   34 +
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  704 +++---
 .../pmu-events/arch/x86/cascadelakex/other.json    | 1100 ++++-----
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |   10 -
 .../arch/x86/cascadelakex/uncore-memory.json       |   12 +-
 .../arch/x86/cascadelakex/uncore-other.json        |   21 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    1 +
 tools/perf/pmu-events/arch/x86/skylakex/cache.json | 2348 ++++++++++----------
 .../arch/x86/skylakex/floating-point.json          |   96 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |  656 +++---
 .../perf/pmu-events/arch/x86/skylakex/memory.json  | 1977 ++++++++--------
 tools/perf/pmu-events/arch/x86/skylakex/other.json |  172 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     | 1206 +++++-----
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  141 +-
 .../arch/x86/skylakex/uncore-memory.json           |   26 +-
 .../pmu-events/arch/x86/skylakex/uncore-other.json |  730 +++++-
 .../arch/x86/skylakex/virtual-memory.json          |  358 +--
 tools/perf/pmu-events/jevents.c                    |  237 +-
 tools/perf/pmu-events/jevents.h                    |   23 -
 tools/perf/pmu-events/pmu-events.h                 |    6 +
 tools/perf/scripts/python/futex-contention.py      |   51 +-
 tools/perf/tests/Build                             |    2 +
 tools/perf/tests/attr.c                            |    2 +-
 tools/perf/tests/builtin-test.c                    |    8 +
 tools/perf/tests/expand-cgroup.c                   |  241 ++
 tools/perf/tests/make                              |    2 +
 tools/perf/tests/parse-events.c                    |   58 +-
 tools/perf/tests/parse-metric.c                    |    4 +-
 tools/perf/tests/pe-file-parsing.c                 |   98 +
 tools/perf/tests/pe-file.c                         |   14 +
 tools/perf/tests/pe-file.exe                       |  Bin 0 -> 75595 bytes
 tools/perf/tests/pe-file.exe.debug                 |  Bin 0 -> 141644 bytes
 tools/perf/tests/python-use.c                      |    1 +
 tools/perf/tests/sdt.c                             |    6 +-
 tools/perf/tests/shell/buildid.sh                  |  101 +
 tools/perf/tests/shell/test_arm_coresight.sh       |  183 ++
 tools/perf/tests/tests.h                           |    2 +
 tools/perf/trace/beauty/mmap.c                     |   74 +-
 tools/perf/trace/beauty/mmap_flags.sh              |   16 +-
 tools/perf/trace/beauty/mmap_prot.sh               |   30 +
 tools/perf/trace/beauty/mremap_flags.sh            |   18 +
 tools/perf/util/Build                              |    2 +
 tools/perf/util/annotate.c                         |    5 +-
 tools/perf/util/build-id.c                         |   48 +-
 tools/perf/util/build-id.h                         |   12 +-
 tools/perf/util/callchain.c                        |   99 +
 tools/perf/util/callchain.h                        |    9 +
 tools/perf/util/cgroup.c                           |  115 +-
 tools/perf/util/cgroup.h                           |    3 +
 tools/perf/util/config.c                           |    2 +-
 tools/perf/util/config.h                           |    2 +
 tools/perf/util/dso.c                              |   23 +-
 tools/perf/util/dso.h                              |    7 +-
 tools/perf/util/dsos.c                             |    9 +-
 tools/perf/util/event.c                            |    2 +-
 tools/perf/util/evlist.c                           |  123 +-
 tools/perf/util/evlist.h                           |    8 +-
 tools/perf/util/evsel.c                            |  109 +
 tools/perf/util/evsel.h                            |   93 +-
 tools/perf/util/group.h                            |    8 -
 tools/perf/util/header.c                           |   15 +-
 tools/perf/util/intel-pt.c                         |    8 +-
 tools/perf/util/jitdump.c                          |   14 +-
 tools/perf/util/machine.c                          |   12 +
 tools/perf/util/machine.h                          |    4 +
 tools/perf/util/map.c                              |   21 +-
 tools/perf/util/map.h                              |   14 +
 tools/perf/util/metricgroup.c                      |  177 +-
 tools/perf/util/metricgroup.h                      |    9 +-
 tools/perf/util/parse-events.c                     |   23 +-
 tools/perf/util/parse-events.h                     |    2 +-
 tools/perf/util/parse-events.l                     |    2 +-
 tools/perf/util/parse-events.y                     |    8 +-
 tools/perf/util/print_binary.c                     |    2 +-
 tools/perf/util/probe-event.c                      |   69 +-
 tools/perf/util/probe-finder.c                     |   63 +-
 tools/perf/util/probe-finder.h                     |    7 +-
 tools/perf/util/python.c                           |   21 +-
 tools/perf/util/record.c                           |    3 +-
 tools/perf/util/record.h                           |    1 +
 .../util/scripting-engines/trace-event-python.c    |    2 +-
 tools/perf/util/stat-display.c                     |    1 -
 tools/perf/util/stat-shadow.c                      |   89 +
 tools/perf/util/stat.c                             |    4 +
 tools/perf/util/stat.h                             |   10 +
 tools/perf/util/stream.c                           |  342 +++
 tools/perf/util/stream.h                           |   41 +
 tools/perf/util/symbol-elf.c                       |  107 +-
 tools/perf/util/symbol-minimal.c                   |   31 +-
 tools/perf/util/symbol.c                           |  155 +-
 tools/perf/util/symbol.h                           |    9 +-
 tools/perf/util/synthetic-events.c                 |   10 +-
 tools/perf/util/topdown.c                          |   58 +
 tools/perf/util/topdown.h                          |   12 +
 tools/perf/util/tsc.c                              |   81 +
 tools/perf/util/tsc.h                              |    5 +
 tools/perf/util/util.h                             |    6 +
 164 files changed, 10450 insertions(+), 5720 deletions(-)
 create mode 100644 tools/build/feature/test-libbfd-buildid.c
 create mode 100644 tools/perf/Documentation/topdown.txt
 create mode 100644 tools/perf/arch/arm64/util/tsc.c
 delete mode 100644 tools/perf/arch/x86/util/group.c
 create mode 100644 tools/perf/arch/x86/util/topdown.c
 create mode 100644 tools/perf/bench/inject-buildid.c
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
 delete mode 100644 tools/perf/pmu-events/jevents.h
 create mode 100644 tools/perf/tests/expand-cgroup.c
 create mode 100644 tools/perf/tests/pe-file-parsing.c
 create mode 100644 tools/perf/tests/pe-file.c
 create mode 100644 tools/perf/tests/pe-file.exe
 create mode 100644 tools/perf/tests/pe-file.exe.debug
 create mode 100755 tools/perf/tests/shell/buildid.sh
 create mode 100755 tools/perf/tests/shell/test_arm_coresight.sh
 create mode 100755 tools/perf/trace/beauty/mmap_prot.sh
 create mode 100755 tools/perf/trace/beauty/mremap_flags.sh
 delete mode 100644 tools/perf/util/group.h
 create mode 100644 tools/perf/util/stream.c
 create mode 100644 tools/perf/util/stream.h
 create mode 100644 tools/perf/util/topdown.c
 create mode 100644 tools/perf/util/topdown.h
