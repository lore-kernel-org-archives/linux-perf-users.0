Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29C370;
	Wed, 17 Jul 2024 01:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721178226; cv=none; b=uROOeYsiCb0mnAyTcQ3QKOD2ekjKWUnSWOnXIsjWEp8bVysMKXG7iDk+MtoTmF93cJkoJ735QR0iRY5knXVlMihRRSQ+Gb2ffR18Jl8mYykSmJ1JfozQyx7eiUHDQLLgrW2hFQaEYsmgDdWQ5AOGNlXQeYlrybqV77sxjrSHp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721178226; c=relaxed/simple;
	bh=EcpEfl1SGEN/uFLbTePLIewuBbfgDa/OgnPRu1onWtE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CaMy5fBiFkVgHjnpOPhGUW3ZFPuzTJNnmMwLLQ+E3NH8Ul+rKIQ2k606iLmzX7HIzEKWeiKuEL5uHnGgZOUu3nDj6CiJKpINjQL3ZnD6RhqpeQIhxsOU9UV2qVG+ERN/LajY0WZj9DQXsfbXr/hoxIWJMGcQwTYnHfXsTN2U+V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=attx4WDj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="attx4WDj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C245C116B1;
	Wed, 17 Jul 2024 01:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721178225;
	bh=EcpEfl1SGEN/uFLbTePLIewuBbfgDa/OgnPRu1onWtE=;
	h=From:To:Cc:Subject:Date:From;
	b=attx4WDjwVPaO3UB9ZmSjjaD0jQ1UqoB4fAU0xxCS3nZVRF7RAxRzFr/jOXBnaB3i
	 rfkX0/2AwSedx6b3wTFx6CW962+JWTQOwdnzpEd2nw2ta0Kfdhco34Nwqa95FWeeZY
	 wJxQE7hs9v3sXim15p9kHnOQyRNcnT3cOVBHkyX5RJqe3sMwTcag/rHDg7j5fV/vwM
	 uV1JbjFxVDse/oslPb345rt6NYNrFACwqHPGJS1jRyzUjbk1kVWYduxDISCfK2Y2Da
	 YPk1pZfAh5SirUV2vbrzYQuKdYe/b4iS3d3/4BeueCS+t3DoBOay9sj7LvZ7wlE6mO
	 PEnt8834Pju3g==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools for v6.11
Date: Tue, 16 Jul 2024 18:03:40 -0700
Message-ID: <20240717010342.900344-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.11.

Thanks,
Namhyung


The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.11-2024-07-16

for you to fetch changes up to 7a2fb5619cc1fb53cb8784154d5ef2bd99997436:

  perf trace: Fix iteration of syscall ids in syscalltbl->entries (2024-07-12 09:49:02 -0700)

----------------------------------------------------------------
perf tools changes for v6.11

Build
-----
* Build each directory as a library so that depedency check for the
  python extension module can be automatic.  But it also introduces
  some trivial merge conflicts with other trees that touched perf tools
  codes.  Basically it changes perf-y to perf-util-y or similar and you
  can find the resolution in the perf-next tree here.

  - https://lore.kernel.org/r/Zn8HeRRX3JV2IcxQ@sirena.org.uk
  - https://lore.kernel.org/r/20240709100536.238f4d12@canb.auug.org.au

* Use pkg-config to check libtraceevent and libtracefs.

perf sched
----------
* Add --task-name and --fuzzy-name options for `perf sched map`.  It's
  to focus on selected tasks only by removing unrelated tasks in the
  output.  It matches the task comm with the given string and the
  --fuzzy-name option allows the partial matching.

    $ sudo perf sched record -a sleep 1

    $ sudo perf sched map --task-name kworker --fuzzy-name
       .   .   .   .   -  *A0  .   .    481065.315131 secs A0 => kworker/5:2-i91:438521
       .   .   .   .   -  *-   .   .    481065.315160 secs
      *B0  .   .   .   -   .   .   .    481065.316435 secs B0 => kworker/0:0-i91:437860
      *-   .   .   .   .   .   .   .    481065.316441 secs
       .   .   .   .   .  *A0  .   .    481065.318703 secs
       .   .   .   .   .  *-   .   .    481065.318717 secs
       .   .  *C0  .   .   .   .   .    481065.320544 secs C0 => kworker/u16:30-:430186
       .   .  *-   .   .   .   .   .    481065.320555 secs
       .   .  *D0  .   .   .   .   .    481065.328524 secs D0 => kworker/2:0-kdm:429654
      *B0  .   D0  .   -   .   .   .    481065.328527 secs
      *-   .   D0  .   -   .   .   .    481065.328535 secs
       .   .  *-   .   .   .   .   .    481065.328535 secs

* Fix -r/--repeat option of perf sched replay.  The documentation said
  -1 will work as infinity but it didn't accept the value.  Update the
  code and document to use 0 instead.

* Fix perf sched timehist to account the delay time for preempted tasks.

Perf event filtering
--------------------
* perf top gained filtering support on regular events using BPF like
  perf record.  Previously it was able to use it for tracepoints only.

* The BPF filter now supports filtering by UID/GID.  This should be
  preferred than -u <UID> option as it's racy to scan /proc to check
  tasks for the user and fails to open an event for the task if it's
  already gone.

    $ sudo perf top -e cycles --filter "uid == $(id -u)"

perf report
-----------
* Skip dummy events in the group output by default.  The --skip-empty
  option controls display of empty events without samples.  But perf
  report can force display all events in a group.  In this case, auto-
  added a dummy event (for a system-wide record) ends up in the output.
  Now it can skip those empty events even in the group display mode.
  To preserve the old behavior, run this:

    $ perf report --group --no-skip-empty

perf stat
---------
* Choose the most disaggregate option when multiple aggregation options
  are given.  It used to pick the last option in the command line but
  it can be confusing and not consistent.  Now it'll choose the smallest
  unit.

  For example, it'd aggregate the result per-core when the user gave
  both --per-socket and --per-core options at the same time.

Internals
---------
* Fix `perf bench` when some CPUs are offline.

* Fix handling of JIT symbol mappings to accept "/tmp/perf-${PID}.map
  patterns only so that it can not be confused by other /tmp/perf-*
  files.

* Many improvements and fixes for `perf test`.

Others
------
* Support some new instructions for Intel-PT.
* Fix syscall ID mapping in perf trace.
* Document AMD IBS PMU usages.
* Change `perf lock info` to show map and thread info by default.

Vendor JSON events
------------------
* Update Intel events and metrics
* Add i.MX9[35] DDR metrics

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Abhishek Dubey (1):
      perf report: Calling available function for stats printing

Adrian Hunter (4):
      perf intel pt: Add new JMPABS instruction to the Intel PT instruction decoder
      perf tests: Add APX and other new instructions to x86 instruction decoder test
      perf intel-pt: Fix aux_watermark calculation for 64-bit size
      perf intel-pt: Fix exclude_guest setting

Athira Rajeev (7):
      tools/perf: Fix perf bench futex to enable the run when some CPU's are offline
      tools/perf: Fix perf bench epoll to enable the run when some CPU's are offline
      tools/perf: Fix timing issue with parallel threads in perf bench wake-up-parallel
      tools/perf: Handle perftool-testsuite_probe testcases fail when kernel debuginfo is not present
      tools/perf: Fix the string match for "/tmp/perf-$PID.map" files in dso__load
      tools/perf: Use is_perf_pid_map_name helper function to check dso's of pattern /tmp/perf-%d.map
      tools/perf: Fix parallel-perf python script to replace new python syntax ":=" usage

Breno Leitao (1):
      perf list: Fix the --no-desc option

Chaitanya S Prakash (1):
      perf test: Check output of the probe ... --funcs command

Changbin Du (2):
      perf trace beauty: Always show param if show_zero is set
      perf trace beauty: Always show mmap prot even though PROT_NONE

Clément Le Goffic (1):
      perf: parse-events: Fix compilation error while defining DEBUG_PARSER

Dr. David Alan Gilbert (2):
      perf genelf: remove unused struct 'options'
      perf hisi-ptt: remove unused struct 'hisi_ptt_queue'

Fernand Sieber (2):
      perf: sched map skips redundant lines with cpu filters
      perf: Timehist account sch delay for scheduled out running

Guilherme Amadio (3):
      perf build: Use pkg-config for feature check for libtrace{event,fs}
      perf build: Ensure libtraceevent and libtracefs versions have 3 components
      perf build: Conditionally add feature check flags for libtrace{event,fs}

Haoze Xie (2):
      perf record: Fix memset out-of-range error
      perf build x86: Fix SC2034 error in syscalltbl.sh

Howard Chu (1):
      perf trace: Fix iteration of syscall ids in syscalltbl->entries

Ian Rogers (65):
      perf pmus: Sort/merge/aggregate PMUs like mrvl_ddr_pmu
      perf tests: Add some pmu core functionality tests
      perf arm-spe: Unaligned pointer work around
      perf docs: Fix typos
      tools api io: Move filling the io buffer to its own function
      perf bpf filter: Give terms their own enum
      perf bpf filter: Add uid and gid terms
      perf top: Allow filters on events
      perf maps: Fix use after free in __maps__fixup_overlap_and_insert
      perf maps: Reduce sorting for overlapping mappings
      perf maps: Add/use a sorted insert for fixup overlap and insert
      perf stat: Make options local
      perf stat: Choose the most disaggregate command line option
      perf evsel: Refactor tool events
      perf record: Ensure space for lost samples
      perf test pmu: Warn don't fail for legacy mixed case event names
      perf vendor events: Update alderlake events/metrics
      perf vendor events: Update alderlaken events/metrics
      perf vendor events: Add bonnell counter information
      perf vendor events: Update broadwell metrics add event counter information
      perf vendor events: Update broadwellde metrics add event counter information
      perf vendor events: Update broadwellx metrics add event counter information
      perf vendor events: Update cascadelakex events/metrics
      perf vendor events: Update elkhartlake events
      perf vendor events: Add/update emeraldrapids events/metrics
      perf vendor events: Add goldmont counter information
      perf vendor events: Add goldmontplus counter information
      perf vendor events: Update/add grandridge events/metrics
      perf vendor events: Update graniterapids events and add counter information
      perf vendor events: Add haswell counter information
      perf vendor events: Update haswellx metrics add event counter information
      perf vendor events: Add/update icelake events/metrics
      perf vendor events: Add/update icelakex events/metrics
      perf vendor events: Update ivybridge metrics add event counter information
      perf vendor events: Update ivytown metrics add event counter information
      perf vendor events: Update jaketown metrics add event counter information
      perf vendor events: Add knightslanding counter information
      perf vendor events: Add lunarlake counter information
      perf vendor events: Update meteorlake events and add counter information
      perf vendor events: Add nehalemep counter information
      perf vendor events: Add nehalemex counter information
      perf vendor events: Add/update rocketlake events/metrics
      perf vendor events: Update sandybridge metrics add event counter information
      perf vendor events: Add/update sapphirerapids events/metrics
      perf vendor events: Add/update sierraforest events/metrics
      perf vendor events: Add silvermont counter information
      perf vendor events: Add/update skylake events/metrics
      perf vendor events: Add/update skylakex events/metrics
      perf vendor events: Add snowridgex counter information
      perf vendor events: Add/update tigerlake events/metrics
      perf vendor events: Add westmereep-dp counter information
      perf vendor events: Add westmereep-sp counter information
      perf vendor events: Add westmereex counter information
      perf arm: Workaround ARM PMUs cpu maps having offline cpus
      perf build: Add '*.a' to clean targets
      perf ui: Make ui its own library
      perf pmu-events: Make pmu-events a library
      perf test: Make tests its own library
      perf bench: Make bench its own library
      perf util: Make util its own library
      perf python: Switch module to linking libraries from building source
      perf python: Clean up build dependencies
      perf comm str: Avoid sort during insert
      perf dsos: When adding a dso into sorted dsos maintain the sort order
      perf dso: Fix address sanitizer build

James Clark (3):
      perf test: Make test_arm_callgraph_fp.sh more robust
      perf pmu: Restore full PMU name wildcard support
      perf pmu: Don't de-duplicate core PMUs

Junhao He (1):
      perf pmus: Fixes always false when compare duplicates aliases

Kan Liang (1):
      perf stat: Fix the hard-coded metrics calculation on the hybrid

Leo Yan (2):
      perf arm-spe: Support multiple Arm SPE PMUs
      perf mem: Warn if memory events are not supported on all CPUs

Lucas Stach (1):
      perf script: netdev-times: add location parameter to consume_skb

Madadi Vineeth Reddy (4):
      perf sched replay: Fix -r/--repeat command line option for infinity
      perf sched map: Add task-name option to filter the output map
      perf sched map: Add support for multiple task names using CSV
      perf sched map: Add --fuzzy-name option for fuzzy matching in task names

Namhyung Kim (12):
      perf hist: Factor out __hpp__fmt_print()
      perf hist: Simplify __hpp_fmt() using hpp_fmt_data
      perf hist: Add symbol_conf.skip_empty
      perf hist: Honor symbol_conf.skip_empty
      perf report: Fix condition in sort__sym_cmp()
      perf symbol: Simplify kernel module checking
      perf tools: Fix a compiler warning of NULL pointer
      perf mem: Fix a segfault with NULL event->name
      perf report: Display pregress bar on redirected pipe data
      perf stat: Fix a segfault with --per-cluster --metric-only
      perf stat: Use field separator in the metric header
      Merge remote-tracking branch 'perf-tools' into perf-tools-next

Nick Forrington (1):
      perf lock info: Display both map and thread by default

Nicolas Schier (1):
      perf install: Don't propagate subdir to Documentation submake

Ravi Bangoria (1):
      perf doc: Add AMD IBS usage document

Thomas Richter (1):
      perf test: Speed up test case 70 annotate basic tests

Veronika Molnarova (1):
      perf test stat_bpf_counter.sh: Stabilize the test results

Xu Yang (2):
      perf vendor events arm64:: Add i.MX93 DDR Performance Monitor metrics
      perf vendor events arm64:: Add i.MX95 DDR Performance Monitor metrics

Yang Li (1):
      perf: pmus: Remove unneeded semicolon

Yunseong Kim (2):
      util: constant -1 with expression of type char
      perf unwind-libunwind: Add malloc() failure handling

 tools/build/feature/test-libtracefs.c              |    2 +-
 tools/lib/api/io.h                                 |   69 +-
 tools/lib/perf/include/perf/event.h                |    6 +
 tools/perf/Build                                   |   14 +-
 tools/perf/Documentation/perf-amd-ibs.txt          |  189 +
 tools/perf/Documentation/perf-kwork.txt            |    4 +-
 tools/perf/Documentation/perf-lock.txt             |    4 +-
 tools/perf/Documentation/perf-mem.txt              |    2 +-
 tools/perf/Documentation/perf-record.txt           |    4 +-
 tools/perf/Documentation/perf-sched.txt            |   21 +-
 tools/perf/Documentation/perf-top.txt              |    4 +
 tools/perf/Documentation/perf.txt                  |    3 +-
 tools/perf/Makefile.config                         |   46 +-
 tools/perf/Makefile.perf                           |   85 +-
 tools/perf/arch/Build                              |    5 +-
 tools/perf/arch/arm/Build                          |    4 +-
 tools/perf/arch/arm/tests/Build                    |    8 +-
 tools/perf/arch/arm/util/Build                     |   10 +-
 tools/perf/arch/arm/util/pmu.c                     |   12 +-
 tools/perf/arch/arm64/Build                        |    4 +-
 tools/perf/arch/arm64/tests/Build                  |    8 +-
 tools/perf/arch/arm64/util/Build                   |   20 +-
 tools/perf/arch/csky/Build                         |    2 +-
 tools/perf/arch/csky/util/Build                    |    6 +-
 tools/perf/arch/loongarch/Build                    |    2 +-
 tools/perf/arch/loongarch/util/Build               |    8 +-
 tools/perf/arch/mips/Build                         |    2 +-
 tools/perf/arch/mips/util/Build                    |    6 +-
 tools/perf/arch/powerpc/Build                      |    4 +-
 tools/perf/arch/powerpc/tests/Build                |    6 +-
 tools/perf/arch/powerpc/util/Build                 |   24 +-
 tools/perf/arch/powerpc/util/skip-callchain-idx.c  |    8 +-
 tools/perf/arch/riscv/Build                        |    2 +-
 tools/perf/arch/riscv/util/Build                   |    8 +-
 tools/perf/arch/s390/Build                         |    2 +-
 tools/perf/arch/s390/util/Build                    |   16 +-
 tools/perf/arch/sh/Build                           |    2 +-
 tools/perf/arch/sh/util/Build                      |    2 +-
 tools/perf/arch/sparc/Build                        |    2 +-
 tools/perf/arch/sparc/util/Build                   |    2 +-
 tools/perf/arch/x86/Build                          |    6 +-
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |    4 +-
 tools/perf/arch/x86/tests/Build                    |   20 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c        |  116 +
 tools/perf/arch/x86/tests/insn-x86-dat-64.c        | 1026 ++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c       |  597 ++++
 tools/perf/arch/x86/util/Build                     |   42 +-
 tools/perf/arch/x86/util/intel-pt.c                |   15 +-
 tools/perf/arch/xtensa/Build                       |    2 +-
 tools/perf/bench/Build                             |   46 +-
 tools/perf/bench/epoll-ctl.c                       |    2 +-
 tools/perf/bench/epoll-wait.c                      |    2 +-
 tools/perf/bench/futex-hash.c                      |    2 +-
 tools/perf/bench/futex-lock-pi.c                   |    2 +-
 tools/perf/bench/futex-requeue.c                   |    2 +-
 tools/perf/bench/futex-wake-parallel.c             |    4 +-
 tools/perf/bench/futex-wake.c                      |    2 +-
 tools/perf/builtin-annotate.c                      |    4 +-
 tools/perf/builtin-list.c                          |   23 +-
 tools/perf/builtin-lock.c                          |   27 +-
 tools/perf/builtin-record.c                        |   32 +-
 tools/perf/builtin-report.c                        |   11 +-
 tools/perf/builtin-sched.c                         |  189 +-
 tools/perf/builtin-stat.c                          |  399 ++-
 tools/perf/builtin-top.c                           |    9 +
 tools/perf/builtin-trace.c                         |   49 +-
 .../arch/arm64/freescale/imx93/sys/ddrc.json       |    9 +
 .../arch/arm64/freescale/imx93/sys/metrics.json    |   26 +
 .../arch/arm64/freescale/imx95/sys/ddrc.json       |    9 +
 .../arch/arm64/freescale/imx95/sys/metrics.json    |  874 +++++
 .../pmu-events/arch/x86/alderlake/adl-metrics.json |  988 +++---
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  184 +-
 .../arch/x86/alderlake/floating-point.json         |   20 +
 .../pmu-events/arch/x86/alderlake/frontend.json    |   56 +-
 .../perf/pmu-events/arch/x86/alderlake/memory.json |   44 +
 .../arch/x86/alderlake/metricgroups.json           |   23 +-
 .../perf/pmu-events/arch/x86/alderlake/other.json  |   37 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |  214 ++
 .../arch/x86/alderlake/uncore-interconnect.json    |   19 +
 .../arch/x86/alderlake/uncore-memory.json          |   25 +
 .../arch/x86/alderlake/uncore-other.json           |    1 +
 .../arch/x86/alderlake/virtual-memory.json         |   26 +
 .../arch/x86/alderlaken/adln-metrics.json          |  658 ++--
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |   50 +-
 .../arch/x86/alderlaken/floating-point.json        |    2 +
 .../pmu-events/arch/x86/alderlaken/frontend.json   |    3 +
 .../pmu-events/arch/x86/alderlaken/memory.json     |   11 +
 .../arch/x86/alderlaken/metricgroups.json          |   21 +-
 .../perf/pmu-events/arch/x86/alderlaken/other.json |   13 +
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   80 +
 .../arch/x86/alderlaken/uncore-interconnect.json   |   19 +
 .../arch/x86/alderlaken/uncore-memory.json         |   25 +
 .../arch/x86/alderlaken/uncore-other.json          |    1 +
 .../arch/x86/alderlaken/virtual-memory.json        |    6 +
 tools/perf/pmu-events/arch/x86/bonnell/cache.json  |   93 +
 .../perf/pmu-events/arch/x86/bonnell/counter.json  |    7 +
 .../arch/x86/bonnell/floating-point.json           |   32 +
 .../perf/pmu-events/arch/x86/bonnell/frontend.json |   11 +
 tools/perf/pmu-events/arch/x86/bonnell/memory.json |   19 +
 tools/perf/pmu-events/arch/x86/bonnell/other.json  |   56 +
 .../perf/pmu-events/arch/x86/bonnell/pipeline.json |   44 +
 .../arch/x86/bonnell/virtual-memory.json           |   15 +
 .../pmu-events/arch/x86/broadwell/bdw-metrics.json |   80 +-
 .../perf/pmu-events/arch/x86/broadwell/cache.json  |  275 ++
 .../pmu-events/arch/x86/broadwell/counter.json     |   22 +
 .../arch/x86/broadwell/floating-point.json         |   22 +
 .../pmu-events/arch/x86/broadwell/frontend.json    |   28 +
 .../perf/pmu-events/arch/x86/broadwell/memory.json |  240 ++
 .../arch/x86/broadwell/metricgroups.json           |   11 +
 .../perf/pmu-events/arch/x86/broadwell/other.json  |    4 +
 .../pmu-events/arch/x86/broadwell/pipeline.json    |  137 +
 .../arch/x86/broadwell/uncore-cache.json           |   24 +
 .../arch/x86/broadwell/uncore-interconnect.json    |    7 +
 .../arch/x86/broadwell/uncore-other.json           |   10 -
 .../arch/x86/broadwell/virtual-memory.json         |   38 +
 .../arch/x86/broadwellde/bdwde-metrics.json        |   80 +-
 .../pmu-events/arch/x86/broadwellde/cache.json     |   76 +
 .../pmu-events/arch/x86/broadwellde/counter.json   |   42 +
 .../arch/x86/broadwellde/floating-point.json       |   22 +
 .../pmu-events/arch/x86/broadwellde/frontend.json  |   28 +
 .../pmu-events/arch/x86/broadwellde/memory.json    |   39 +
 .../arch/x86/broadwellde/metricgroups.json         |   11 +
 .../pmu-events/arch/x86/broadwellde/other.json     |    4 +
 .../pmu-events/arch/x86/broadwellde/pipeline.json  |  137 +
 .../arch/x86/broadwellde/uncore-cache.json         |  382 ++
 .../arch/x86/broadwellde/uncore-interconnect.json  |   70 +
 .../pmu-events/arch/x86/broadwellde/uncore-io.json |   62 +
 .../arch/x86/broadwellde/uncore-memory.json        |  322 ++
 .../arch/x86/broadwellde/uncore-power.json         |   57 +
 .../arch/x86/broadwellde/virtual-memory.json       |   38 +
 .../arch/x86/broadwellx/bdx-metrics.json           |  128 +-
 .../perf/pmu-events/arch/x86/broadwellx/cache.json |   88 +
 .../pmu-events/arch/x86/broadwellx/counter.json    |   57 +
 .../arch/x86/broadwellx/floating-point.json        |   22 +
 .../pmu-events/arch/x86/broadwellx/frontend.json   |   28 +
 .../pmu-events/arch/x86/broadwellx/memory.json     |   58 +
 .../arch/x86/broadwellx/metricgroups.json          |   11 +
 .../perf/pmu-events/arch/x86/broadwellx/other.json |    4 +
 .../pmu-events/arch/x86/broadwellx/pipeline.json   |  137 +
 .../arch/x86/broadwellx/uncore-cache.json          |  399 +++
 .../arch/x86/broadwellx/uncore-interconnect.json   |  454 +++
 .../pmu-events/arch/x86/broadwellx/uncore-io.json  |   62 +
 .../arch/x86/broadwellx/uncore-memory.json         |  326 ++
 .../arch/x86/broadwellx/uncore-power.json          |   57 +
 .../arch/x86/broadwellx/virtual-memory.json        |   38 +
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 1245 +++++++
 .../arch/x86/cascadelakex/clx-metrics.json         |  310 +-
 .../pmu-events/arch/x86/cascadelakex/counter.json  |   52 +
 .../arch/x86/cascadelakex/floating-point.json      |   16 +
 .../pmu-events/arch/x86/cascadelakex/frontend.json |   49 +
 .../pmu-events/arch/x86/cascadelakex/memory.json   |  743 ++++
 .../arch/x86/cascadelakex/metricgroups.json        |   13 +
 .../pmu-events/arch/x86/cascadelakex/other.json    |  168 +
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |  104 +-
 .../arch/x86/cascadelakex/uncore-cache.json        | 2293 ++++++++++++
 .../arch/x86/cascadelakex/uncore-interconnect.json | 2536 ++++++++++++++
 .../arch/x86/cascadelakex/uncore-io.json           |  703 ++++
 .../arch/x86/cascadelakex/uncore-memory.json       |  985 ++++++
 .../arch/x86/cascadelakex/uncore-power.json        |   50 +
 .../arch/x86/cascadelakex/virtual-memory.json      |   28 +
 .../pmu-events/arch/x86/elkhartlake/cache.json     |  101 +
 .../pmu-events/arch/x86/elkhartlake/counter.json   |    7 +
 .../arch/x86/elkhartlake/floating-point.json       |    3 +
 .../pmu-events/arch/x86/elkhartlake/frontend.json  |    9 +
 .../pmu-events/arch/x86/elkhartlake/memory.json    |   40 +
 .../pmu-events/arch/x86/elkhartlake/other.json     |   61 +
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |   60 +
 .../arch/x86/elkhartlake/virtual-memory.json       |   31 +
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |  159 +-
 .../pmu-events/arch/x86/emeraldrapids/counter.json |   82 +
 .../arch/x86/emeraldrapids/emr-metrics.json        | 2186 ++++++++++++
 .../arch/x86/emeraldrapids/floating-point.json     |   28 +
 .../arch/x86/emeraldrapids/frontend.json           |   50 +
 .../pmu-events/arch/x86/emeraldrapids/memory.json  |   50 +
 .../arch/x86/emeraldrapids/metricgroups.json       |  137 +
 .../pmu-events/arch/x86/emeraldrapids/other.json   |   43 +
 .../arch/x86/emeraldrapids/pipeline.json           |  133 +
 .../arch/x86/emeraldrapids/uncore-cache.json       | 1288 +++++++
 .../arch/x86/emeraldrapids/uncore-cxl.json         |  110 +
 .../x86/emeraldrapids/uncore-interconnect.json     | 1427 ++++++++
 .../arch/x86/emeraldrapids/uncore-io.json          |  743 ++++
 .../arch/x86/emeraldrapids/uncore-memory.json      |  742 ++++
 .../arch/x86/emeraldrapids/uncore-power.json       |   49 +
 .../arch/x86/emeraldrapids/virtual-memory.json     |   20 +
 tools/perf/pmu-events/arch/x86/goldmont/cache.json |  103 +
 .../perf/pmu-events/arch/x86/goldmont/counter.json |    7 +
 .../arch/x86/goldmont/floating-point.json          |    3 +
 .../pmu-events/arch/x86/goldmont/frontend.json     |    8 +
 .../perf/pmu-events/arch/x86/goldmont/memory.json  |    3 +
 tools/perf/pmu-events/arch/x86/goldmont/other.json |    5 +
 .../pmu-events/arch/x86/goldmont/pipeline.json     |   40 +
 .../arch/x86/goldmont/virtual-memory.json          |    7 +
 .../pmu-events/arch/x86/goldmontplus/cache.json    |  101 +
 .../pmu-events/arch/x86/goldmontplus/counter.json  |    7 +
 .../arch/x86/goldmontplus/floating-point.json      |    3 +
 .../pmu-events/arch/x86/goldmontplus/frontend.json |    8 +
 .../pmu-events/arch/x86/goldmontplus/memory.json   |    3 +
 .../pmu-events/arch/x86/goldmontplus/other.json    |    5 +
 .../pmu-events/arch/x86/goldmontplus/pipeline.json |   42 +
 .../arch/x86/goldmontplus/virtual-memory.json      |   18 +
 .../perf/pmu-events/arch/x86/grandridge/cache.json |   97 +-
 .../pmu-events/arch/x86/grandridge/counter.json    |   42 +
 .../arch/x86/grandridge/floating-point.json        |   54 +-
 .../pmu-events/arch/x86/grandridge/frontend.json   |    5 +-
 .../arch/x86/grandridge/grr-metrics.json           |  849 +++++
 .../pmu-events/arch/x86/grandridge/memory.json     |   13 +-
 .../arch/x86/grandridge/metricgroups.json          |   23 +
 .../perf/pmu-events/arch/x86/grandridge/other.json |   15 +-
 .../pmu-events/arch/x86/grandridge/pipeline.json   |   97 +-
 .../arch/x86/grandridge/uncore-cache.json          |  267 ++
 .../arch/x86/grandridge/uncore-interconnect.json   |   30 +
 .../pmu-events/arch/x86/grandridge/uncore-io.json  |  181 +
 .../arch/x86/grandridge/uncore-memory.json         |   66 +
 .../arch/x86/grandridge/uncore-power.json          |    1 +
 .../arch/x86/grandridge/virtual-memory.json        |   17 +
 .../pmu-events/arch/x86/graniterapids/cache.json   |  825 +++++
 .../pmu-events/arch/x86/graniterapids/counter.json |   77 +
 .../arch/x86/graniterapids/floating-point.json     |  242 ++
 .../arch/x86/graniterapids/frontend.json           |  469 ++-
 .../pmu-events/arch/x86/graniterapids/memory.json  |  175 +-
 .../pmu-events/arch/x86/graniterapids/other.json   |  150 +-
 .../arch/x86/graniterapids/pipeline.json           | 1009 +++++-
 .../arch/x86/graniterapids/uncore-cache.json       | 3674 ++++++++++++++++++++
 .../arch/x86/graniterapids/uncore-cxl.json         |   31 +
 .../x86/graniterapids/uncore-interconnect.json     | 1849 ++++++++++
 .../arch/x86/graniterapids/uncore-io.json          | 1901 ++++++++++
 .../arch/x86/graniterapids/uncore-memory.json      |  449 +++
 .../arch/x86/graniterapids/uncore-power.json       |   11 +
 .../arch/x86/graniterapids/virtual-memory.json     |  159 +
 tools/perf/pmu-events/arch/x86/haswell/cache.json  |   94 +
 .../perf/pmu-events/arch/x86/haswell/counter.json  |   22 +
 .../arch/x86/haswell/floating-point.json           |   10 +
 .../perf/pmu-events/arch/x86/haswell/frontend.json |   29 +
 .../pmu-events/arch/x86/haswell/hsw-metrics.json   |   66 +-
 tools/perf/pmu-events/arch/x86/haswell/memory.json |   60 +
 .../pmu-events/arch/x86/haswell/metricgroups.json  |   11 +
 tools/perf/pmu-events/arch/x86/haswell/other.json  |    4 +
 .../perf/pmu-events/arch/x86/haswell/pipeline.json |  130 +
 .../pmu-events/arch/x86/haswell/uncore-cache.json  |   33 +
 .../arch/x86/haswell/uncore-interconnect.json      |    6 +
 .../pmu-events/arch/x86/haswell/uncore-other.json  |    1 +
 .../arch/x86/haswell/virtual-memory.json           |   49 +
 tools/perf/pmu-events/arch/x86/haswellx/cache.json |   97 +
 .../perf/pmu-events/arch/x86/haswellx/counter.json |   57 +
 .../arch/x86/haswellx/floating-point.json          |   10 +
 .../pmu-events/arch/x86/haswellx/frontend.json     |   29 +
 .../pmu-events/arch/x86/haswellx/hsx-metrics.json  |  114 +-
 .../perf/pmu-events/arch/x86/haswellx/memory.json  |   67 +
 .../pmu-events/arch/x86/haswellx/metricgroups.json |   11 +
 tools/perf/pmu-events/arch/x86/haswellx/other.json |    4 +
 .../pmu-events/arch/x86/haswellx/pipeline.json     |  130 +
 .../pmu-events/arch/x86/haswellx/uncore-cache.json |  398 +++
 .../arch/x86/haswellx/uncore-interconnect.json     |  448 +++
 .../pmu-events/arch/x86/haswellx/uncore-io.json    |   59 +
 .../arch/x86/haswellx/uncore-memory.json           |  325 ++
 .../pmu-events/arch/x86/haswellx/uncore-power.json |   62 +
 .../arch/x86/haswellx/virtual-memory.json          |   49 +
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |  109 +
 .../perf/pmu-events/arch/x86/icelake/counter.json  |   17 +
 .../arch/x86/icelake/floating-point.json           |   13 +
 .../perf/pmu-events/arch/x86/icelake/frontend.json |   41 +-
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  308 +-
 tools/perf/pmu-events/arch/x86/icelake/memory.json |   44 +
 .../pmu-events/arch/x86/icelake/metricgroups.json  |   13 +
 tools/perf/pmu-events/arch/x86/icelake/other.json  |   27 +
 .../perf/pmu-events/arch/x86/icelake/pipeline.json |   94 +
 .../arch/x86/icelake/uncore-interconnect.json      |   34 +-
 .../pmu-events/arch/x86/icelake/uncore-other.json  |    1 +
 .../arch/x86/icelake/virtual-memory.json           |   20 +
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |  106 +
 .../perf/pmu-events/arch/x86/icelakex/counter.json |   57 +
 .../arch/x86/icelakex/floating-point.json          |   13 +
 .../pmu-events/arch/x86/icelakex/frontend.json     |   38 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  340 +-
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |   45 +
 .../pmu-events/arch/x86/icelakex/metricgroups.json |   13 +
 tools/perf/pmu-events/arch/x86/icelakex/other.json |   52 +
 .../pmu-events/arch/x86/icelakex/pipeline.json     |   92 +
 .../pmu-events/arch/x86/icelakex/uncore-cache.json | 2149 +++++++++++-
 .../arch/x86/icelakex/uncore-interconnect.json     | 3344 ++++++++++++++++++
 .../pmu-events/arch/x86/icelakex/uncore-io.json    | 1829 ++++++++++
 .../arch/x86/icelakex/uncore-memory.json           |  338 ++
 .../pmu-events/arch/x86/icelakex/uncore-power.json |   51 +
 .../arch/x86/icelakex/virtual-memory.json          |   22 +
 .../perf/pmu-events/arch/x86/ivybridge/cache.json  |  104 +
 .../pmu-events/arch/x86/ivybridge/counter.json     |   17 +
 .../arch/x86/ivybridge/floating-point.json         |   17 +
 .../pmu-events/arch/x86/ivybridge/frontend.json    |   30 +
 .../pmu-events/arch/x86/ivybridge/ivb-metrics.json |   68 +-
 .../perf/pmu-events/arch/x86/ivybridge/memory.json |   19 +
 .../arch/x86/ivybridge/metricgroups.json           |   11 +
 .../perf/pmu-events/arch/x86/ivybridge/other.json  |    4 +
 .../pmu-events/arch/x86/ivybridge/pipeline.json    |  126 +
 .../arch/x86/ivybridge/uncore-cache.json           |   25 +
 .../arch/x86/ivybridge/uncore-interconnect.json    |    9 +
 .../arch/x86/ivybridge/virtual-memory.json         |   18 +
 tools/perf/pmu-events/arch/x86/ivytown/cache.json  |  118 +
 .../perf/pmu-events/arch/x86/ivytown/counter.json  |   52 +
 .../arch/x86/ivytown/floating-point.json           |   17 +
 .../perf/pmu-events/arch/x86/ivytown/frontend.json |   30 +
 .../pmu-events/arch/x86/ivytown/ivt-metrics.json   |   68 +-
 tools/perf/pmu-events/arch/x86/ivytown/memory.json |   41 +
 .../pmu-events/arch/x86/ivytown/metricgroups.json  |   11 +
 tools/perf/pmu-events/arch/x86/ivytown/other.json  |    4 +
 .../perf/pmu-events/arch/x86/ivytown/pipeline.json |  126 +
 .../pmu-events/arch/x86/ivytown/uncore-cache.json  |  349 ++
 .../arch/x86/ivytown/uncore-interconnect.json      |  385 ++
 .../pmu-events/arch/x86/ivytown/uncore-io.json     |   61 +
 .../pmu-events/arch/x86/ivytown/uncore-memory.json |  198 ++
 .../pmu-events/arch/x86/ivytown/uncore-power.json  |   74 +
 .../arch/x86/ivytown/virtual-memory.json           |   20 +
 tools/perf/pmu-events/arch/x86/jaketown/cache.json |  123 +
 .../perf/pmu-events/arch/x86/jaketown/counter.json |   52 +
 .../arch/x86/jaketown/floating-point.json          |   15 +
 .../pmu-events/arch/x86/jaketown/frontend.json     |   32 +
 .../pmu-events/arch/x86/jaketown/jkt-metrics.json  |   24 +-
 .../perf/pmu-events/arch/x86/jaketown/memory.json  |   35 +
 .../pmu-events/arch/x86/jaketown/metricgroups.json |   11 +
 tools/perf/pmu-events/arch/x86/jaketown/other.json |    6 +
 .../pmu-events/arch/x86/jaketown/pipeline.json     |  127 +
 .../pmu-events/arch/x86/jaketown/uncore-cache.json |  205 ++
 .../arch/x86/jaketown/uncore-interconnect.json     |  207 ++
 .../pmu-events/arch/x86/jaketown/uncore-io.json    |   36 +
 .../arch/x86/jaketown/uncore-memory.json           |   51 +
 .../pmu-events/arch/x86/jaketown/uncore-power.json |   39 +
 .../arch/x86/jaketown/virtual-memory.json          |   16 +
 .../pmu-events/arch/x86/knightslanding/cache.json  |  213 ++
 .../arch/x86/knightslanding/counter.json           |   37 +
 .../arch/x86/knightslanding/floating-point.json    |    3 +
 .../arch/x86/knightslanding/frontend.json          |    7 +
 .../pmu-events/arch/x86/knightslanding/memory.json |  101 +
 .../arch/x86/knightslanding/pipeline.json          |   45 +
 .../arch/x86/knightslanding/uncore-cache.json      |  421 +++
 .../arch/x86/knightslanding/uncore-io.json         |   24 +
 .../arch/x86/knightslanding/uncore-memory.json     |   14 +
 .../arch/x86/knightslanding/virtual-memory.json    |    7 +
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |   20 +
 .../pmu-events/arch/x86/lunarlake/frontend.json    |    3 +
 .../perf/pmu-events/arch/x86/lunarlake/memory.json |   15 +
 .../perf/pmu-events/arch/x86/lunarlake/other.json  |    6 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |   36 +
 .../arch/x86/lunarlake/virtual-memory.json         |    6 +
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   34 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  223 +-
 .../arch/x86/meteorlake/floating-point.json        |   86 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   69 +-
 .../pmu-events/arch/x86/meteorlake/memory.json     |   62 +-
 .../perf/pmu-events/arch/x86/meteorlake/other.json |   19 +-
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  300 +-
 .../arch/x86/meteorlake/uncore-cache.json          |    2 +
 .../arch/x86/meteorlake/uncore-interconnect.json   |    8 +
 .../arch/x86/meteorlake/uncore-memory.json         |   16 +
 .../arch/x86/meteorlake/uncore-other.json          |    1 +
 .../arch/x86/meteorlake/virtual-memory.json        |   37 +
 .../perf/pmu-events/arch/x86/nehalemep/cache.json  |  320 ++
 .../pmu-events/arch/x86/nehalemep/counter.json     |    7 +
 .../arch/x86/nehalemep/floating-point.json         |   28 +
 .../pmu-events/arch/x86/nehalemep/frontend.json    |    3 +
 .../perf/pmu-events/arch/x86/nehalemep/memory.json |   67 +
 .../perf/pmu-events/arch/x86/nehalemep/other.json  |   18 +
 .../pmu-events/arch/x86/nehalemep/pipeline.json    |  109 +
 .../arch/x86/nehalemep/virtual-memory.json         |   13 +
 .../perf/pmu-events/arch/x86/nehalemex/cache.json  |  315 ++
 .../pmu-events/arch/x86/nehalemex/counter.json     |    7 +
 .../arch/x86/nehalemex/floating-point.json         |   28 +
 .../pmu-events/arch/x86/nehalemex/frontend.json    |    3 +
 .../perf/pmu-events/arch/x86/nehalemex/memory.json |   67 +
 .../perf/pmu-events/arch/x86/nehalemex/other.json  |   18 +
 .../pmu-events/arch/x86/nehalemex/pipeline.json    |  109 +
 .../arch/x86/nehalemex/virtual-memory.json         |   13 +
 .../perf/pmu-events/arch/x86/rocketlake/cache.json |  109 +
 .../pmu-events/arch/x86/rocketlake/counter.json    |   17 +
 .../arch/x86/rocketlake/floating-point.json        |   13 +
 .../pmu-events/arch/x86/rocketlake/frontend.json   |   41 +-
 .../pmu-events/arch/x86/rocketlake/memory.json     |   44 +
 .../arch/x86/rocketlake/metricgroups.json          |   13 +
 .../perf/pmu-events/arch/x86/rocketlake/other.json |   27 +
 .../pmu-events/arch/x86/rocketlake/pipeline.json   |   94 +
 .../arch/x86/rocketlake/rkl-metrics.json           |  308 +-
 .../arch/x86/rocketlake/uncore-interconnect.json   |   28 +-
 .../arch/x86/rocketlake/uncore-other.json          |    1 +
 .../arch/x86/rocketlake/virtual-memory.json        |   20 +
 .../pmu-events/arch/x86/sandybridge/cache.json     |  173 +
 .../pmu-events/arch/x86/sandybridge/counter.json   |   17 +
 .../arch/x86/sandybridge/floating-point.json       |   15 +
 .../pmu-events/arch/x86/sandybridge/frontend.json  |   32 +
 .../pmu-events/arch/x86/sandybridge/memory.json    |   37 +
 .../arch/x86/sandybridge/metricgroups.json         |   11 +
 .../pmu-events/arch/x86/sandybridge/other.json     |    6 +
 .../pmu-events/arch/x86/sandybridge/pipeline.json  |  128 +
 .../arch/x86/sandybridge/snb-metrics.json          |   24 +-
 .../arch/x86/sandybridge/uncore-cache.json         |   25 +
 .../arch/x86/sandybridge/uncore-interconnect.json  |    9 +
 .../arch/x86/sandybridge/virtual-memory.json       |   16 +
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |  161 +-
 .../arch/x86/sapphirerapids/counter.json           |   82 +
 .../arch/x86/sapphirerapids/floating-point.json    |   28 +
 .../arch/x86/sapphirerapids/frontend.json          |   50 +
 .../pmu-events/arch/x86/sapphirerapids/memory.json |   50 +
 .../arch/x86/sapphirerapids/metricgroups.json      |   13 +
 .../pmu-events/arch/x86/sapphirerapids/other.json  |   48 +
 .../arch/x86/sapphirerapids/pipeline.json          |  133 +
 .../arch/x86/sapphirerapids/spr-metrics.json       |  411 +--
 .../arch/x86/sapphirerapids/uncore-cache.json      | 1244 +++++++
 .../arch/x86/sapphirerapids/uncore-cxl.json        |  110 +
 .../x86/sapphirerapids/uncore-interconnect.json    | 1427 ++++++++
 .../arch/x86/sapphirerapids/uncore-io.json         |  679 ++++
 .../arch/x86/sapphirerapids/uncore-memory.json     |  742 ++++
 .../arch/x86/sapphirerapids/uncore-power.json      |   49 +
 .../arch/x86/sapphirerapids/virtual-memory.json    |   20 +
 .../pmu-events/arch/x86/sierraforest/cache.json    |   97 +-
 .../pmu-events/arch/x86/sierraforest/counter.json  |   77 +
 .../arch/x86/sierraforest/floating-point.json      |   54 +-
 .../pmu-events/arch/x86/sierraforest/frontend.json |    5 +-
 .../pmu-events/arch/x86/sierraforest/memory.json   |   13 +-
 .../arch/x86/sierraforest/metricgroups.json        |   23 +
 .../pmu-events/arch/x86/sierraforest/other.json    |   15 +-
 .../pmu-events/arch/x86/sierraforest/pipeline.json |   97 +-
 .../arch/x86/sierraforest/srf-metrics.json         |  927 +++++
 .../arch/x86/sierraforest/uncore-cache.json        |  549 ++-
 .../arch/x86/sierraforest/uncore-cxl.json          |   21 +
 .../arch/x86/sierraforest/uncore-interconnect.json |  267 ++
 .../arch/x86/sierraforest/uncore-io.json           |  267 ++
 .../arch/x86/sierraforest/uncore-memory.json       |   66 +
 .../arch/x86/sierraforest/uncore-power.json        |    1 +
 .../arch/x86/sierraforest/virtual-memory.json      |   17 +
 .../perf/pmu-events/arch/x86/silvermont/cache.json |   77 +
 .../pmu-events/arch/x86/silvermont/counter.json    |    7 +
 .../arch/x86/silvermont/floating-point.json        |    1 +
 .../pmu-events/arch/x86/silvermont/frontend.json   |    8 +
 .../pmu-events/arch/x86/silvermont/memory.json     |    1 +
 .../perf/pmu-events/arch/x86/silvermont/other.json |    2 +
 .../pmu-events/arch/x86/silvermont/pipeline.json   |   34 +
 .../arch/x86/silvermont/virtual-memory.json        |    7 +
 tools/perf/pmu-events/arch/x86/skylake/cache.json  |  250 ++
 .../perf/pmu-events/arch/x86/skylake/counter.json  |   22 +
 .../arch/x86/skylake/floating-point.json           |   10 +
 .../perf/pmu-events/arch/x86/skylake/frontend.json |   49 +
 tools/perf/pmu-events/arch/x86/skylake/memory.json |  131 +
 .../pmu-events/arch/x86/skylake/metricgroups.json  |   13 +
 tools/perf/pmu-events/arch/x86/skylake/other.json  |    2 +
 .../perf/pmu-events/arch/x86/skylake/pipeline.json |  103 +-
 .../pmu-events/arch/x86/skylake/skl-metrics.json   |  196 +-
 .../pmu-events/arch/x86/skylake/uncore-cache.json  |   23 +
 .../arch/x86/skylake/uncore-interconnect.json      |    8 +
 .../pmu-events/arch/x86/skylake/uncore-other.json  |   10 -
 .../arch/x86/skylake/virtual-memory.json           |   28 +
 tools/perf/pmu-events/arch/x86/skylakex/cache.json |  155 +
 .../perf/pmu-events/arch/x86/skylakex/counter.json |   52 +
 .../arch/x86/skylakex/floating-point.json          |   13 +
 .../pmu-events/arch/x86/skylakex/frontend.json     |   49 +
 .../perf/pmu-events/arch/x86/skylakex/memory.json  |  115 +
 .../pmu-events/arch/x86/skylakex/metricgroups.json |   13 +
 tools/perf/pmu-events/arch/x86/skylakex/other.json |   15 +
 .../pmu-events/arch/x86/skylakex/pipeline.json     |  104 +-
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  310 +-
 .../pmu-events/arch/x86/skylakex/uncore-cache.json | 2274 ++++++++++++
 .../arch/x86/skylakex/uncore-interconnect.json     | 2521 ++++++++++++++
 .../pmu-events/arch/x86/skylakex/uncore-io.json    |  703 ++++
 .../arch/x86/skylakex/uncore-memory.json           |  804 +++++
 .../pmu-events/arch/x86/skylakex/uncore-power.json |   50 +
 .../arch/x86/skylakex/virtual-memory.json          |   28 +
 .../perf/pmu-events/arch/x86/snowridgex/cache.json |  101 +
 .../pmu-events/arch/x86/snowridgex/counter.json    |   47 +
 .../arch/x86/snowridgex/floating-point.json        |    3 +
 .../pmu-events/arch/x86/snowridgex/frontend.json   |    9 +
 .../pmu-events/arch/x86/snowridgex/memory.json     |   40 +
 .../perf/pmu-events/arch/x86/snowridgex/other.json |   61 +
 .../pmu-events/arch/x86/snowridgex/pipeline.json   |   60 +
 .../arch/x86/snowridgex/uncore-cache.json          | 1548 ++++++++-
 .../arch/x86/snowridgex/uncore-interconnect.json   | 1403 ++++++++
 .../pmu-events/arch/x86/snowridgex/uncore-io.json  | 1743 ++++++++++
 .../arch/x86/snowridgex/uncore-memory.json         |  103 +
 .../arch/x86/snowridgex/uncore-power.json          |   51 +
 .../arch/x86/snowridgex/virtual-memory.json        |   31 +
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |   73 +
 .../pmu-events/arch/x86/tigerlake/counter.json     |   17 +
 .../arch/x86/tigerlake/floating-point.json         |   13 +
 .../pmu-events/arch/x86/tigerlake/frontend.json    |   41 +-
 .../perf/pmu-events/arch/x86/tigerlake/memory.json |   24 +
 .../arch/x86/tigerlake/metricgroups.json           |   13 +
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |    4 +
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |   95 +
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  198 +-
 .../arch/x86/tigerlake/uncore-interconnect.json    |   19 +
 .../arch/x86/tigerlake/uncore-memory.json          |    6 +
 .../arch/x86/tigerlake/uncore-other.json           |    1 +
 .../arch/x86/tigerlake/virtual-memory.json         |   20 +
 .../pmu-events/arch/x86/westmereep-dp/cache.json   |  282 ++
 .../pmu-events/arch/x86/westmereep-dp/counter.json |    7 +
 .../arch/x86/westmereep-dp/floating-point.json     |   28 +
 .../arch/x86/westmereep-dp/frontend.json           |    3 +
 .../pmu-events/arch/x86/westmereep-dp/memory.json  |   69 +
 .../pmu-events/arch/x86/westmereep-dp/other.json   |   28 +
 .../arch/x86/westmereep-dp/pipeline.json           |  111 +
 .../arch/x86/westmereep-dp/virtual-memory.json     |   21 +
 .../pmu-events/arch/x86/westmereep-sp/cache.json   |  321 ++
 .../pmu-events/arch/x86/westmereep-sp/counter.json |    7 +
 .../arch/x86/westmereep-sp/floating-point.json     |   28 +
 .../arch/x86/westmereep-sp/frontend.json           |    3 +
 .../pmu-events/arch/x86/westmereep-sp/memory.json  |   67 +
 .../pmu-events/arch/x86/westmereep-sp/other.json   |   28 +
 .../arch/x86/westmereep-sp/pipeline.json           |  111 +
 .../arch/x86/westmereep-sp/virtual-memory.json     |   18 +
 .../perf/pmu-events/arch/x86/westmereex/cache.json |  320 ++
 .../pmu-events/arch/x86/westmereex/counter.json    |    7 +
 .../arch/x86/westmereex/floating-point.json        |   28 +
 .../pmu-events/arch/x86/westmereex/frontend.json   |    3 +
 .../pmu-events/arch/x86/westmereex/memory.json     |   68 +
 .../perf/pmu-events/arch/x86/westmereex/other.json |   28 +
 .../pmu-events/arch/x86/westmereex/pipeline.json   |  111 +
 .../arch/x86/westmereex/virtual-memory.json        |   21 +
 tools/perf/pmu-events/jevents.py                   |    1 +
 tools/perf/scripts/Build                           |    4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build      |    2 +-
 tools/perf/scripts/python/Perf-Trace-Util/Build    |    2 +-
 tools/perf/scripts/python/netdev-times.py          |    3 +-
 tools/perf/scripts/python/parallel-perf.py         |    3 +-
 tools/perf/tests/Build                             |  140 +-
 tools/perf/tests/pmu.c                             |  199 +-
 tools/perf/tests/shell/annotate.sh                 |   10 +-
 .../tests/shell/base_probe/test_adding_kernel.sh   |   31 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |   36 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |   27 +-
 .../tests/shell/test_uprobe_from_different_cu.sh   |    2 +-
 tools/perf/tests/workloads/Build                   |   12 +-
 tools/perf/tests/workloads/leafloop.c              |   20 +-
 tools/perf/ui/Build                                |   18 +-
 tools/perf/ui/browsers/Build                       |   14 +-
 tools/perf/ui/gtk/annotate.c                       |    5 +-
 tools/perf/ui/hist.c                               |  144 +-
 tools/perf/ui/stdio/hist.c                         |    5 +-
 tools/perf/ui/tui/Build                            |    8 +-
 tools/perf/util/Build                              |  394 +--
 tools/perf/util/arm-spe-decoder/Build              |    2 +-
 .../util/arm-spe-decoder/arm-spe-pkt-decoder.c     |   23 +-
 tools/perf/util/bpf-filter.c                       |   33 +-
 tools/perf/util/bpf-filter.h                       |    5 +-
 tools/perf/util/bpf-filter.l                       |   66 +-
 tools/perf/util/bpf-filter.y                       |    7 +-
 tools/perf/util/bpf_skel/sample-filter.h           |   40 +-
 tools/perf/util/bpf_skel/sample_filter.bpf.c       |   73 +-
 tools/perf/util/comm.c                             |   29 +-
 tools/perf/util/cs-etm-decoder/Build               |    2 +-
 tools/perf/util/cs-etm.c                           |   10 +-
 tools/perf/util/disasm.c                           |   10 +-
 tools/perf/util/dso.c                              |   12 +
 tools/perf/util/dso.h                              |   14 +
 tools/perf/util/dsos.c                             |   31 +-
 tools/perf/util/events_stats.h                     |    3 +-
 tools/perf/util/evsel.c                            |  239 +-
 tools/perf/util/evsel.h                            |   14 +
 tools/perf/util/expr.c                             |    4 -
 tools/perf/util/genelf.c                           |    5 -
 tools/perf/util/hisi-ptt-decoder/Build             |    2 +-
 tools/perf/util/hisi-ptt.c                         |    5 -
 tools/perf/util/hist.c                             |    6 +-
 tools/perf/util/hist.h                             |    3 +-
 tools/perf/util/intel-pt-decoder/Build             |    2 +-
 .../util/intel-pt-decoder/intel-pt-insn-decoder.c  |    9 +
 tools/perf/util/maps.c                             |  113 +-
 tools/perf/util/mem-events.c                       |   16 +-
 tools/perf/util/parse-events.c                     |   10 +-
 tools/perf/util/perf-regs-arch/Build               |   18 +-
 tools/perf/util/pmu.c                              |   54 +-
 tools/perf/util/pmus.c                             |   72 +-
 tools/perf/util/pmus.h                             |    7 +-
 tools/perf/util/python-ext-sources                 |   53 -
 tools/perf/util/python.c                           |  271 +-
 tools/perf/util/scripting-engines/Build            |    4 +-
 tools/perf/util/session.c                          |   25 +-
 tools/perf/util/session.h                          |    3 +-
 tools/perf/util/setup.py                           |   33 +-
 tools/perf/util/sort.c                             |    2 +-
 tools/perf/util/srcline.c                          |   14 +-
 tools/perf/util/stat-display.c                     |   20 +-
 tools/perf/util/stat-shadow.c                      |    7 +
 tools/perf/util/symbol.c                           |   23 +-
 tools/perf/util/symbol_conf.h                      |    3 +-
 tools/perf/util/syscalltbl.c                       |    7 +
 tools/perf/util/syscalltbl.h                       |    1 +
 tools/perf/util/unwind-libdw.c                     |   12 +-
 tools/perf/util/unwind-libunwind-local.c           |   23 +-
 583 files changed, 81325 insertions(+), 4396 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-amd-ibs.txt
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx93/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx95/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/bonnell/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwell/counter.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/broadwell/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellde/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/broadwellx/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/cascadelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/emr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/emeraldrapids/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmont/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/goldmontplus/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/grr-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/grandridge/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-cxl.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-interconnect.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-io.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswell/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/haswellx/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivybridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/ivytown/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/jaketown/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/knightslanding/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/nehalemep/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/nehalemex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/rocketlake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sandybridge/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sapphirerapids/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/metricgroups.json
 create mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/srf-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/silvermont/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylake/counter.json
 delete mode 100644 tools/perf/pmu-events/arch/x86/skylake/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/skylakex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/snowridgex/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/westmereep-dp/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/westmereep-sp/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/westmereex/counter.json
 delete mode 100644 tools/perf/util/python-ext-sources
