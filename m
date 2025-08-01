Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC645009;
	Fri,  1 Aug 2025 17:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754070332; cv=none; b=jmwiAh3UtdklZXpfw8TefBfDeZmC/iqeZMi4/wRtbQ2GxNDjN2iXw7yZ+ho12fHZTviy3m+KwgXr0ooeM+ZAnHKJwV1DzlaSN9kbGxpuGOUPg3ilQPe2XWK//HqveS3L+6BolxRxuKev0oMlwUUHmmxn+o8BOTQG5dCi86zWb3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754070332; c=relaxed/simple;
	bh=SdWN+O4b2vnfirm3wbF79t7++nO9Ixg9XRPWG6xdRvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z6Yaep+VxQSsw+k2mJXvnEtHcjqkd7kYyzwqPeN7Af+BSP2xMK2BnUcY7EKUMWcWlvUk3qbWMBE5WiVYYkKEEvb2H9R5veTucIfT7J/zhAdr5NsSHLpqC7z5UhVU7SnnyzgQwqYSuNv6Hx50SjGV+loef5yrXIQb1Xmqg0lvd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC6CMpjL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC6CMpjL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DDCC4CEE7;
	Fri,  1 Aug 2025 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754070332;
	bh=SdWN+O4b2vnfirm3wbF79t7++nO9Ixg9XRPWG6xdRvQ=;
	h=From:To:Cc:Subject:Date:From;
	b=bC6CMpjL/Tl/MiTFPlXHqvbqJqAtftvyfCbDV/7TOq33xYFd1TBF78Z2euaf2sROy
	 e8GNTRFqbC0X+h8RddRdCYSaqcQFI62n1AfwK7vaVQmnPdUam/XURlLaytx8NzsEZV
	 B+TOSfd/4Gb219fh48zh5fFeZzPRBn3L8bnSB0aWvXZMnpofVZi/WklRR1zd/XdpWw
	 ZvrcBIT8WvS5X+RFWIRZ9HMleVzUqJXke6SJ/EdmebOjMgN1RV4LaL6h0T3WE9axLh
	 u7MuwZ6masoC7mks9hy78u2DC6AyLGLibbSvvE2foBvRYlFRQcM/UdYtGx26IxDctr
	 yJ5nEY9GucVjQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools updates for v6.17
Date: Fri,  1 Aug 2025 10:45:27 -0700
Message-ID: <20250801174527.1479322-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.17.

Thanks,
Namhyung


The following changes since commit 86731a2a651e58953fc949573895f2fa6d456841:

  Linux 6.16-rc3 (2025-06-22 13:30:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.17-2025-08-01

for you to fetch changes up to 6235ce77749f45cac27f630337e2fdf04e8a6c73:

  perf record: Cache build-ID of hit DSOs only (2025-07-31 10:46:46 -0700)

----------------------------------------------------------------
[GIT PULL] perf tools changes for v6.17

Build-ID processing goodies
---------------------------
Build-IDs are content based hashes to link regions of memory to ELF files
in post processing. They have been available in distros for quite a while:

    $ file /bin/bash
    /bin/bash: ELF 64-bit LSB pie executable, x86-64, version 1 (SYSV),
    dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2,
    BuildID[sha1]=707a1c670cd72f8e55ffedfbe94ea98901b7ce3a,
    for GNU/Linux 3.2.0, stripped

It is possible to ask the kernel to get it from mmap executable backing
storage at time they are being put in place and send it as metadata at
that moment to have in perf.data.

Prefer that across the board to speed up 'record' time - it post processes
the samples to find binaries touched by any samples and to save them with
build-ID.  It can skip reading build-ID in userspace if it comes from the
kernel.

perf record
-----------
* Make --buildid-mmap default.  The kernel can generate MMAP2 events
  with a build-ID from ELF header.  Use that by default instead of using
  inode and device ID to identify binaries.  It also can be disabled
  with --no-buildid-mmap.

* Use BPF for -u/--uid option to sample processes belong to a user.
  BPF can track user processes more accurately and the existing logic
  often fails to get the list of processes due to race with reading the
  /proc filesystem.

* Generate PERF_RECORD_BPF_METADATA when it profiles BPF programs and
  they have variables starting with "bpf_metadata_".  This will help to
  identify BPF objects used in the profile.  This has been supported in
  bpftool for some time and allows the recording of metadata such as
  commit hashes, versions, etc, that now gets recorded in perf.data as
  well.

* Collect list of DSOs touched in the sample callchains as well as in
  the sample itself.  This would increase the processing time at the end
  of record, but can improve the data quality.

perf stat
---------
* Add a new 'drm' pseudo-PMU support like in 'hwmon'.  It can collect
  DRM usage stats using fdinfo in /proc.

  On my Intel laptop, it shows like below:

    $ perf list drm
    ...

    drm:
      drm-active-stolen-system0
           [Total memory active in one or more engines. Unit: drm_i915]
      drm-active-system0
           [Total memory active in one or more engines. Unit: drm_i915]
      drm-engine-capacity-video
           [Engine capacity. Unit: drm_i915]
      drm-engine-copy
           [Utilization in ns. Unit: drm_i915]
      drm-engine-render
           [Utilization in ns. Unit: drm_i915]
      drm-engine-video
           [Utilization in ns. Unit: drm_i915]
      ...

    $ sudo perf stat -a -e drm-engine-render,drm-engine-video,drm-engine-capacity-video sleep 1

     Performance counter stats for 'system wide':

    48,137,316,988,873 ns       drm-engine-render
        34,452,696,746 ns       drm-engine-video
                    20 capacity drm-engine-capacity-video

           1.002086194 seconds time elapsed

perf list
---------
* Add description for software events.  The description is in JSON format
  and the event parser now can handle the software events like others
  (for example, it's case-insensitive and subject to wildcard matching).

    $ perf list software

    List of pre-defined events (to be used in -e or -M):

    software:
      alignment-faults
           [Number of kernel handled memory alignment faults. Unit: software]
      bpf-output
           [An event used by BPF programs to write to the perf ring buffer. Unit: software]
      cgroup-switches
           [Number of context switches to a task in a different cgroup. Unit: software]
      context-switches
           [Number of context switches [This event is an alias of cs]. Unit: software]
      cpu-clock
           [Per-CPU high-resolution timer based event. Unit: software]
      cpu-migrations
           [Number of times a process has migrated to a new CPU [This event is an alias of migrations]. Unit: software]
      cs
           [Number of context switches [This event is an alias of context-switches]. Unit: software]
      dummy
           [A placeholder event that doesn't count anything. Unit: software]
      emulation-faults
           [Number of kernel handled unimplemented instruction faults handled through emulation. Unit: software]
      faults
           [Number of page faults [This event is an alias of page-faults]. Unit: software]
      major-faults
           [Number of major page faults. Major faults require I/O to handle. Unit: software]
      migrations
           [Number of times a process has migrated to a new CPU [This event is an alias of cpu-migrations]. Unit: software]
      minor-faults
           [Number of minor page faults. Minor faults don't require I/O to handle. Unit: software]
      page-faults
           [Number of page faults [This event is an alias of faults]. Unit: software]
      task-clock
           [Per-task high-resolution timer based event. Unit: software]

perf ftrace
-----------
* Add -e/--events option to perf ftrace latency to measure latency
  between the two events instead of a function.

    $ sudo perf ftrace latency -ab -e i915_request_wait_begin,i915_request_wait_end --hide-empty -- sleep 1
    #   DURATION     |      COUNT | GRAPH                                |
       256 -  512 us |          4 | ######                               |
         2 -    4 ms |          2 | ###                                  |
         4 -    8 ms |         12 | ###################                  |
         8 -   16 ms |         10 | ################                     |

    # statistics  (in usec)
      total time:               194915
        avg time:                 6961
        max time:                12855
        min time:                  373
           count:                   28

* Add new function graph tracer options (--graph-opts) to display more
  info like arguments and return value.  They will be passed to the
  kernel ftrace directly.

    $ sudo perf ftrace -G vfs_write --graph-opts retval,retaddr
    # tracer: function_graph
    #
    # CPU  DURATION                  FUNCTION CALLS
    # |     |   |                     |   |   |   |
    ...
    5)               |  mutex_unlock() { /* <-rb_simple_write+0xda/0x150 */
    5)   0.188 us    |    local_clock(); /* <-lock_release+0x2ad/0x440 ret=0x3bf2a3cf90e */
    5)               |    rt_mutex_slowunlock() { /* <-rb_simple_write+0xda/0x150 */
    5)               |      _raw_spin_lock_irqsave() { /* <-rt_mutex_slowunlock+0x4f/0x200 */
    5)   0.123 us    |        preempt_count_add(); /* <-_raw_spin_lock_irqsave+0x23/0x90 ret=0x0 */
    5)   0.128 us    |        local_clock(); /* <-__lock_acquire.isra.0+0x17a/0x740 ret=0x3bf2a3cfc8b */
    5)   0.086 us    |        do_raw_spin_trylock(); /* <-_raw_spin_lock_irqsave+0x4a/0x90 ret=0x1 */
    5)   0.845 us    |      } /* _raw_spin_lock_irqsave ret=0x292 */
    ...

misc
----
* Add perf archive --exclude-buildids <FILE> option to skip some binaries.
  The format of the FILE should be same as an output of perf buildid-list.

* Get rid of dependency of libcrypto.  It was just to get SHA-1 hash so
  implement it directly like in the kernel.  A side effect is that it
  needs -fno-strict-aliasing compiler option (again, like in the kernel).

* Convert all shell script tests to use bash.

Reviewed-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Aditya Bodkhe (1):
      perf script: perf script tests fails with segfault

Anubhav Shelat (2):
      perf header: remove unecessary core id test
      perf sched timehist: decode process names of processes in zombie state

Arnaldo Carvalho de Melo (4):
      perf build: Suggest java-latest-openjdk-devel instead of old 1.8.0 one
      perf build: Add the libpfm devel fedora package name to the hint
      perf build: The bfd features are opt-in, stop testing for them by default
      perf python: Stop using deprecated PyUnicode_AsString()

Bhaskar Chowdhury (1):
      perf tools: Remove excess variable declarations

Blake Jones (6):
      perf build: detect support for libbpf's emit_strings option
      perf record: collect BPF metadata from existing BPF programs
      perf record: collect BPF metadata from new programs
      perf tools: display the new PERF_RECORD_BPF_METADATA event
      perf test: add test for BPF metadata collection
      perf test: Fix comment ordering

Changbin Du (1):
      perf: ftrace: add graph tracer options args/retval/retval-hex/retaddr

Chen Pei (1):
      perf tools: Remove libtraceevent in .gitignore

Chun-Tse Shao (2):
      perf test: Replace grep perl regexp with awk
      perf stat: Fix uncore aggregation number

Colin Ian King (1):
      perf drm_pmu: Fix spelling mistake "bufers" -> "buffers"

Collin Funk (1):
      perf build: Specify shellcheck should use bash

Eric Biggers (2):
      perf build: enable -fno-strict-aliasing
      perf util: add a basic SHA-1 implementation

Federico Pellegrin (1):
      perf build: Always disable stack protection for BPF skeleton objects

Howard Chu (7):
      perf trace: Remove --map-dump documentation
      perf test trace: Use shell's -f flag to check if vmlinux exists
      perf test trace: Remove set -e and print trace test's error messages
      perf test trace: Stop tracing hrtimer_setup event in trace enum test
      perf test trace: Remove set -e for BTF general tests
      perf test trace: Use --sort-events in BTF general tests
      perf test trace: Change the regex pattern in the struct test

Ian Rogers (113):
      perf parse-events filter: Use evsel__find_pmu
      perf target: Separate parse_uid into its own function
      perf parse-events: Add parse_uid_filter helper
      perf record: Switch user option to use BPF filter
      perf tests record: Add basic uid filtering test
      perf top: Switch user option to use BPF filter
      perf trace: Switch user option to use BPF filter
      perf bench evlist-open-close: Switch user option to use BPF filter
      perf target: Remove uid from target
      perf thread_map: Remove uid options
      tools/build: Remove some unused libbpf pre-1.0 feature test logic
      perf thread: Ensure comm_lock held for comm_list
      perf test: Expand user space event reading (rdpmc) tests
      perf test: Add header shell test
      perf srcline: Lower verbosity on addr2line debug messages
      perf trace: Add missed freeing of ordered events and thread
      libperf evsel: Add missed puts and asserts
      perf debug: Add function symbols to dump_stack
      perf parse-events: Avoid scanning PMUs that can't contain events
      perf drm_pmu: Add a tool like PMU to expose DRM information
      perf tests: Add a DRM PMU test
      perf header: In pipe mode dump features without --header/-I
      perf header: Allow tracing of attr events
      perf header: Display message if BPF/BTF info is empty
      perf header: Don't write empty BPF/BTF info
      perf test: Add basic callgraph test to record testing
      perf test annotate: Use --percent-limit rather than head to reduce output
      perf test: Name the noploop process
      perf test: Add sched latency and script shell tests
      perf genelf: Fix NO_LIBDW=1 build
      perf dso: Add missed dso__put to dso__load_kcore
      perf test code-reading: Avoid a leak of cpus and threads
      perf hwmon_pmu: Hold path rather than fd
      perf dso: With ref count checking, avoid dso_data holding dso live
      perf test: In forked mode add check that fds aren't leaked
      perf header: Fix pipe mode header dumping
      perf tests make: Add NO_LIBDW=1 to minimal and add standalone test
      perf vendor events: Update Alderlake events
      perf vendor events: Update AlderlakeN events
      perf vendor events: Update Arrowlake events
      perf vendor events: Update CascadelakeX events
      perf vendor events: Update EmeraldRapids events
      perf vendor events: Update GrandRidge events
      perf vendor events: Update GraniteRapids events
      perf vendor events: Update IcelakeX events
      perf vendor events: Update LunarLake events
      perf vendor events: Update MeteorLake events
      perf vendor events: Add PantherLake events
      perf vendor events: Update SapphireRapids events
      perf vendor events: Update SierraForest events
      perf vendor events: Update SkylakeX events
      perf vendor events: Update TigerLake events
      perf hwmon_pmu: Avoid shortening hwmon PMU name
      perf parse-events: Minor tidy up of event_type helper
      perf spark: Fix includes and add SPDX
      perf pmu: Tolerate failure to read the type for wellknown PMUs
      perf metricgroup: Factor out for-each function and move out printing
      perf stat: Move metric list from config to evlist
      perf expr: Accumulate rather than replace in the context counts
      perf jevents: If the long_desc and desc are identical then drop the long_desc
      perf python: In str(evsel) use the evsel__pmu_name helper
      perf python: Fix thread check in pyrf_evsel__read
      perf python: Correct pyrf_evsel__read for tool PMUs
      perf python: Improve leader copying from evlist
      perf python: Set index error for invalid thread/cpu map items
      perf flamegraph: Fix minor pylint/type hint issues
      tools subcmd: Tighten the filename size in check_if_command_finished
      perf pmu: Switch FILENAME_MAX to NAME_MAX
      perf ui scripts: Switch FILENAME_MAX to NAME_MAX
      perf pfm: Don't force loading of all PMUs
      perf parse-events: Warn if a cpu term is unsupported by a CPU
      perf stat: Avoid buffer overflow to the aggregation map
      perf stat: Don't size aggregation ids from user_requested_cpus
      perf parse-events: Allow the cpu term to be a PMU or CPU range
      perf tool_pmu: Allow num_cpus(_online) to be specific to a cpumask
      libperf evsel: Rename own_cpus to pmu_cpus
      libperf evsel: Factor perf_evsel__exit out of perf_evsel__delete
      perf evsel: Use libperf perf_evsel__exit
      perf pmus: Factor perf_pmus__find_by_attr out of evsel__find_pmu
      perf parse-events: Minor __add_event refactoring
      perf evsel: Add evsel__open_per_cpu_and_thread
      perf parse-events: Support user CPUs mixed with threads/processes
      perf topdown: Use attribute to see an event is a topdown metic or slots
      perf parse-events: Fix missing slots for Intel topdown metric events
      perf metricgroups: Add NO_THRESHOLD_AND_NMI constraint
      perf build-id: Reduce size of "size" variable
      perf build-id: Truncate to avoid overflowing the build_id data
      perf build-id: Change sprintf functions to snprintf
      perf build-id: Mark DSO in sample callchains
      perf build-id: Ensure struct build_id is empty before use
      perf dso: Move build_id to dso_id
      perf jitdump: Directly mark the jitdump DSO
      perf record: Make --buildid-mmap the default
      perf session: Add accessor for session->header.env
      perf evlist: Change env variable to session
      perf header: Clean up use of perf_env
      perf test: Avoid use perf_env
      perf session: Add host_env argument to perf_session__new
      perf top: Make perf_env locally scoped
      perf bench synthesize: Avoid use of global perf_env
      perf machine: Explicitly pass in host perf_env
      perf auxtrace: Pass perf_env from session through to mmap read
      perf trace: Avoid global perf_env with evsel__env
      perf env: Remove global perf_env
      perf sample: Remove arch notion of sample parsing
      perf test: Move PERF_SAMPLE_WEIGHT_STRUCT parsing to common test
      perf sort: Use perf_env to set arch sort keys and header
      perf jevents: Add common software event json
      perf parse-events: Remove non-json software events
      perf tp_pmu: Factor existing tracepoint logic to new file
      perf tp_pmu: Add event APIs
      perf list: Remove tracepoint printing code
      perf list: Skip ABI PMUs when printing pmu values

James Clark (1):
      perf test: Change all remaining #!/bin/sh to #!/bin/bash

Jan Polensky (1):
      perf test: Ensure lock contention using pipe mode

Kotaro, Tokai (1):
      perf vendor events arm64: Update FUJITSU-MONAKA pmu event

Leo Yan (1):
      perf tests bp_account: Fix leaked file descriptor

Namhyung Kim (20):
      perf bpf-filter: Improve error messages
      perf parse-events: Set default GH modifier properly
      Merge tag 'v6.16-rc3' into perf-tools-next
      perf trace: Show zero value in STRARRAY
      perf trace: Split BPF skel code to util/bpf_trace_augment.c
      perf annotate: Fix source code annotate with objdump
      perf build: Fix a build error on REFCNT_CHECKING=1
      perf test: Check test suite description properly
      perf test: Add libsubcmd help tests
      perf tools: Fix use-after-free in help_unknown_cmd()
      perf sched: Make sure it frees the usage string
      perf sched: Free thread->priv using priv_destructor
      perf sched: Fix memory leaks in 'perf sched map'
      perf sched: Fix thread leaks in 'perf sched timehist'
      perf sched: Fix memory leaks for evsel->priv in timehist
      perf sched: Use RC_CHK_EQUAL() to compare pointers
      perf sched: Fix memory leaks in 'perf sched latency'
      perf test: Add more test cases to sched test
      perf ftrace latency: Add -e option to measure time between two events
      perf record: Cache build-ID of hit DSOs only

Sergei Trofimovich (1):
      perf unwind-libdw: skip non-regular files

Thomas Falcon (2):
      perf tools: move perf_pmus__find_core_pmu() prototype to pmus.h
      perf top: populate PMU capabilities data in perf_env

Thomas Richter (3):
      perf test: perf header test fails on s390
      perf list: Add IBM z17 event descriptions
      perf list: Remove trailing A in PAI crypto event 4210

Tianyou Li (3):
      perf script: Handle -i option for perf script flamegraph
      perf script: Add -e option to flamegraph script
      tools/perf: Add --exclude-buildids option to perf archive command

Yang Li (1):
      perf stat: Remove duplicated include in stat-shadow.c

Yuzhuo Jing (3):
      perf: Fix libjvmti.c sign compare error
      perf genelf: Remove libcrypto dependency and use built-in sha1()
      tools: Remove libcrypto dependency

 tools/build/Makefile.feature                       |    9 +-
 tools/build/feature/Makefile                       |   27 +-
 tools/build/feature/test-all.c                     |   24 -
 tools/build/feature/test-libbpf-strings.c          |   10 +
 tools/build/feature/test-libcrypto.c               |   25 -
 tools/lib/perf/evlist.c                            |  119 +-
 tools/lib/perf/evsel.c                             |   11 +
 tools/lib/perf/include/internal/evsel.h            |    3 +-
 tools/lib/perf/include/perf/event.h                |   18 +
 tools/lib/subcmd/help.c                            |   12 +-
 tools/lib/subcmd/run-command.c                     |   15 +-
 tools/perf/.gitignore                              |    2 -
 tools/perf/Build                                   |    2 +-
 tools/perf/Documentation/perf-check.txt            |    2 +-
 tools/perf/Documentation/perf-ftrace.txt           |   10 +
 tools/perf/Documentation/perf-list.txt             |   25 +-
 tools/perf/Documentation/perf-record.txt           |    4 +-
 tools/perf/Documentation/perf-stat.txt             |    6 +-
 tools/perf/Documentation/perf-trace.txt            |    8 -
 tools/perf/Makefile.config                         |   34 +-
 tools/perf/Makefile.perf                           |   12 +-
 tools/perf/arch/powerpc/util/Build                 |    1 -
 tools/perf/arch/powerpc/util/event.c               |   60 -
 tools/perf/arch/x86/Build                          |    2 +-
 tools/perf/arch/x86/include/arch-tests.h           |    5 +-
 tools/perf/arch/x86/tests/Build                    |    4 +-
 tools/perf/arch/x86/tests/arch-tests.c             |    3 +-
 tools/perf/arch/x86/tests/sample-parsing.c         |  125 --
 tools/perf/arch/x86/tests/topdown.c                |   76 ++
 tools/perf/arch/x86/util/event.c                   |   46 -
 tools/perf/arch/x86/util/evlist.c                  |   24 +
 tools/perf/arch/x86/util/evsel.c                   |   46 +-
 tools/perf/arch/x86/util/topdown.c                 |   59 +-
 tools/perf/arch/x86/util/topdown.h                 |    6 +
 tools/perf/bench/evlist-open-close.c               |   36 +-
 tools/perf/bench/inject-buildid.c                  |    2 +-
 tools/perf/bench/synthesize.c                      |   27 +-
 tools/perf/builtin-annotate.c                      |    6 +-
 tools/perf/builtin-buildid-cache.c                 |   22 +-
 tools/perf/builtin-buildid-list.c                  |   11 +-
 tools/perf/builtin-c2c.c                           |   69 +-
 tools/perf/builtin-check.c                         |    2 +-
 tools/perf/builtin-diff.c                          |    2 +-
 tools/perf/builtin-ftrace.c                        |  111 +-
 tools/perf/builtin-inject.c                        |   42 +-
 tools/perf/builtin-kallsyms.c                      |   21 +-
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-kvm.c                           |    6 +-
 tools/perf/builtin-kwork.c                         |    2 +-
 tools/perf/builtin-list.c                          |   65 +-
 tools/perf/builtin-lock.c                          |    4 +-
 tools/perf/builtin-mem.c                           |    2 +-
 tools/perf/builtin-record.c                        |  101 +-
 tools/perf/builtin-report.c                        |   27 +-
 tools/perf/builtin-sched.c                         |  160 ++-
 tools/perf/builtin-script.c                        |   36 +-
 tools/perf/builtin-stat.c                          |   61 +-
 tools/perf/builtin-timechart.c                     |    2 +-
 tools/perf/builtin-top.c                           |   88 +-
 tools/perf/builtin-trace.c                         |  268 ++---
 tools/perf/check-headers.sh                        |    9 +-
 tools/perf/include/perf/perf_dlfilter.h            |    2 +-
 tools/perf/jvmti/libjvmti.c                        |    4 +-
 tools/perf/perf-archive.sh                         |   35 +-
 tools/perf/perf.c                                  |    3 -
 .../arch/arm64/common-and-microarch.json           |   70 ++
 .../arch/arm64/fujitsu/monaka/core-imp-def.json    |    2 +-
 .../arm64/fujitsu/monaka/cycle_accounting.json     |    4 +-
 .../arch/arm64/fujitsu/monaka/exception.json       |    2 +-
 .../arch/arm64/fujitsu/monaka/fp_operation.json    |   98 +-
 .../arch/arm64/fujitsu/monaka/l1d_cache.json       |   10 +-
 .../arch/arm64/fujitsu/monaka/l1i_cache.json       |    8 +-
 .../arch/arm64/fujitsu/monaka/l2_cache.json        |   28 +-
 .../arch/arm64/fujitsu/monaka/l3_cache.json        |   63 +-
 .../arch/arm64/fujitsu/monaka/ll_cache.json        |    2 +-
 .../arch/arm64/fujitsu/monaka/pipeline.json        |    6 +-
 .../arch/arm64/fujitsu/monaka/spec_operation.json  |   12 +-
 .../arch/arm64/fujitsu/monaka/stall.json           |    4 +-
 .../pmu-events/arch/arm64/fujitsu/monaka/sve.json  |   44 +-
 .../pmu-events/arch/arm64/fujitsu/monaka/tlb.json  |   56 +-
 .../pmu-events/arch/common/common/software.json    |   92 ++
 .../pmu-events/arch/s390/cf_z16/pai_crypto.json    |   14 +-
 tools/perf/pmu-events/arch/s390/cf_z17/basic.json  |   58 +
 .../perf/pmu-events/arch/s390/cf_z17/crypto6.json  |  142 +++
 .../perf/pmu-events/arch/s390/cf_z17/extended.json |  541 +++++++++
 .../pmu-events/arch/s390/cf_z17/pai_crypto.json    | 1213 ++++++++++++++++++++
 .../perf/pmu-events/arch/s390/cf_z17/pai_ext.json  |  261 +++++
 .../pmu-events/arch/s390/cf_z17/transaction.json   |   72 ++
 tools/perf/pmu-events/arch/s390/mapfile.csv        |    1 +
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |   56 +-
 .../arch/x86/alderlake/floating-point.json         |    1 -
 .../perf/pmu-events/arch/x86/alderlake/other.json  |    1 -
 .../pmu-events/arch/x86/alderlake/pipeline.json    |   44 +-
 .../arch/x86/alderlake/virtual-memory.json         |    3 -
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |   52 +-
 .../arch/x86/alderlaken/floating-point.json        |    1 -
 .../perf/pmu-events/arch/x86/alderlaken/other.json |    1 -
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |   42 +-
 .../arch/x86/alderlaken/virtual-memory.json        |    3 -
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  |   13 +-
 .../pmu-events/arch/x86/arrowlake/frontend.json    |  135 +++
 .../arch/x86/cascadelakex/floating-point.json      |    6 +-
 .../pmu-events/arch/x86/cascadelakex/pipeline.json |    2 +-
 .../arch/x86/emeraldrapids/pipeline.json           |    2 +-
 .../arch/x86/emeraldrapids/uncore-io.json          |   12 +
 .../arch/x86/emeraldrapids/uncore-memory.json      |   20 +
 .../arch/x86/grandridge/grr-metrics.json           |   30 +-
 .../arch/x86/grandridge/uncore-interconnect.json   |   10 +
 .../pmu-events/arch/x86/grandridge/uncore-io.json  |   12 +
 .../pmu-events/arch/x86/graniterapids/cache.json   |    9 +
 .../pmu-events/arch/x86/graniterapids/counter.json |   10 +-
 .../arch/x86/graniterapids/gnr-metrics.json        |   36 +
 .../arch/x86/graniterapids/pipeline.json           |    2 +-
 .../x86/graniterapids/uncore-interconnect.json     |   19 -
 .../arch/x86/graniterapids/uncore-io.json          |   27 +-
 .../pmu-events/arch/x86/icelakex/pipeline.json     |    2 +-
 .../pmu-events/arch/x86/icelakex/uncore-cache.json |    2 -
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |   11 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |   18 +-
 .../arch/x86/lunarlake/virtual-memory.json         |   18 -
 tools/perf/pmu-events/arch/x86/mapfile.csv         |   29 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |    2 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |   72 ++
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |    2 +-
 .../pmu-events/arch/x86/pantherlake/cache.json     |  278 +++++
 .../pmu-events/arch/x86/pantherlake/counter.json   |   12 +
 .../pmu-events/arch/x86/pantherlake/frontend.json  |   30 +
 .../pmu-events/arch/x86/pantherlake/memory.json    |  215 ++++
 .../pmu-events/arch/x86/pantherlake/pipeline.json  |  325 ++++++
 .../arch/x86/pantherlake/virtual-memory.json       |   62 +
 .../arch/x86/sapphirerapids/pipeline.json          |    2 +-
 .../arch/x86/sapphirerapids/uncore-io.json         |   12 +
 .../arch/x86/sapphirerapids/uncore-memory.json     |   20 +
 .../pmu-events/arch/x86/sierraforest/frontend.json |   64 ++
 .../pmu-events/arch/x86/sierraforest/pipeline.json |    8 +
 .../arch/x86/sierraforest/srf-metrics.json         |   48 +
 .../arch/x86/sierraforest/uncore-cache.json        |    6 +-
 .../arch/x86/sierraforest/uncore-interconnect.json |   53 +-
 .../arch/x86/sierraforest/uncore-io.json           |   27 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     |    2 +-
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |    2 +-
 tools/perf/pmu-events/empty-pmu-events.c           |  266 +++--
 tools/perf/pmu-events/jevents.py                   |   19 +-
 tools/perf/pmu-events/pmu-events.h                 |   14 +-
 tools/perf/scripts/python/flamegraph.py            |   82 +-
 tools/perf/tests/Build                             |    3 +-
 tools/perf/tests/backward-ring-buffer.c            |    1 -
 tools/perf/tests/bp_account.c                      |    1 +
 tools/perf/tests/builtin-test.c                    |   92 +-
 tools/perf/tests/code-reading.c                    |   13 +-
 tools/perf/tests/dlfilter-test.c                   |   51 +-
 tools/perf/tests/dwarf-unwind.c                    |   10 +-
 tools/perf/tests/event-times.c                     |    8 +-
 tools/perf/tests/event_update.c                    |    4 +-
 tools/perf/tests/expand-cgroup.c                   |   24 +-
 tools/perf/tests/hists_cumulate.c                  |    8 +-
 tools/perf/tests/hists_filter.c                    |    8 +-
 tools/perf/tests/hists_link.c                      |    8 +-
 tools/perf/tests/hists_output.c                    |   10 +-
 tools/perf/tests/hwmon_pmu.c                       |   11 +-
 tools/perf/tests/keep-tracking.c                   |    2 +-
 tools/perf/tests/make                              |    8 +-
 tools/perf/tests/mmap-basic.c                      |  291 +++--
 tools/perf/tests/mmap-thread-lookup.c              |    6 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |    2 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |    1 -
 tools/perf/tests/openat-syscall.c                  |    2 +-
 tools/perf/tests/parse-events.c                    |   24 +-
 tools/perf/tests/parse-metric.c                    |   16 +-
 tools/perf/tests/pe-file-parsing.c                 |    2 +-
 tools/perf/tests/perf-record.c                     |    1 -
 tools/perf/tests/perf-targz-src-pkg                |    2 +-
 tools/perf/tests/perf-time-to-tsc.c                |    2 +-
 tools/perf/tests/pmu-events.c                      |   30 +-
 tools/perf/tests/sample-parsing.c                  |   14 +
 tools/perf/tests/sdt.c                             |    4 +-
 tools/perf/tests/shell/amd-ibs-swfilt.sh           |    2 +-
 tools/perf/tests/shell/annotate.sh                 |   15 +-
 tools/perf/tests/shell/buildid.sh                  |    2 +-
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |    2 +-
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |    2 +-
 .../shell/coresight/thread_loop_check_tid_10.sh    |    2 +-
 .../shell/coresight/thread_loop_check_tid_2.sh     |    2 +-
 .../tests/shell/coresight/unroll_loop_thread_10.sh |    2 +-
 tools/perf/tests/shell/diff.sh                     |    2 +-
 tools/perf/tests/shell/drm_pmu.sh                  |   78 ++
 tools/perf/tests/shell/ftrace.sh                   |    2 +-
 tools/perf/tests/shell/header.sh                   |   74 ++
 tools/perf/tests/shell/lib/perf_has_symbol.sh      |    2 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    4 +-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    2 +-
 tools/perf/tests/shell/lib/setup_python.sh         |    2 +-
 tools/perf/tests/shell/lib/waiting.sh              |    2 +-
 tools/perf/tests/shell/list.sh                     |    2 +-
 tools/perf/tests/shell/lock_contention.sh          |   28 +-
 tools/perf/tests/shell/perf-report-hierarchy.sh    |    2 +-
 tools/perf/tests/shell/probe_vfs_getname.sh        |    2 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    7 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    2 +-
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |    2 +-
 tools/perf/tests/shell/record.sh                   |   56 +
 tools/perf/tests/shell/record_bpf_filter.sh        |    2 +-
 tools/perf/tests/shell/record_offcpu.sh            |    2 +-
 tools/perf/tests/shell/record_sideband.sh          |    2 +-
 tools/perf/tests/shell/sched.sh                    |  116 ++
 tools/perf/tests/shell/script.sh                   |    2 +-
 tools/perf/tests/shell/stat+csv_summary.sh         |    2 +-
 tools/perf/tests/shell/stat+shadow_stat.sh         |    2 +-
 tools/perf/tests/shell/stat_all_pfm.sh             |    2 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |    2 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |    2 +-
 tools/perf/tests/shell/test_arm_callgraph_fp.sh    |    2 +-
 tools/perf/tests/shell/test_arm_coresight.sh       |    2 +-
 .../perf/tests/shell/test_arm_coresight_disasm.sh  |    2 +-
 tools/perf/tests/shell/test_arm_spe.sh             |    2 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh        |    2 +-
 tools/perf/tests/shell/test_bpf_metadata.sh        |   76 ++
 tools/perf/tests/shell/test_intel_pt.sh            |    2 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    2 +-
 tools/perf/tests/shell/trace_btf_enum.sh           |   19 +-
 tools/perf/tests/shell/trace_btf_general.sh        |   19 +-
 tools/perf/tests/shell/trace_exit_race.sh          |    2 +-
 tools/perf/tests/shell/trace_record_replay.sh      |    2 +-
 tools/perf/tests/shell/trace_summary.sh            |    2 +-
 tools/perf/tests/subcmd-help.c                     |  108 ++
 tools/perf/tests/switch-tracking.c                 |    2 +-
 tools/perf/tests/symbols.c                         |   12 +-
 tools/perf/tests/task-exit.c                       |    1 -
 tools/perf/tests/tests-scripts.c                   |    2 +-
 tools/perf/tests/tests.h                           |   11 +
 tools/perf/tests/thread-map.c                      |    2 +-
 tools/perf/tests/topology.c                        |   39 +-
 tools/perf/tests/util.c                            |   45 +-
 tools/perf/tests/workloads/noploop.c               |    2 +
 tools/perf/trace/beauty/Build                      |    2 +-
 tools/perf/ui/browser.h                            |    4 +-
 tools/perf/ui/browsers/annotate.c                  |   86 +-
 tools/perf/ui/browsers/header.c                    |    4 +-
 tools/perf/ui/browsers/hists.c                     |    2 +-
 tools/perf/ui/browsers/scripts.c                   |    2 +-
 tools/perf/ui/tui/setup.c                          |    2 +-
 tools/perf/util/Build                              |    6 +-
 tools/perf/util/affinity.c                         |   18 +
 tools/perf/util/affinity.h                         |    2 +
 tools/perf/util/amd-sample-raw.c                   |    2 +-
 tools/perf/util/annotate.c                         |    2 +
 tools/perf/util/annotate.h                         |    1 +
 tools/perf/util/arm-spe.c                          |    2 +-
 tools/perf/util/auxtrace.c                         |   13 +-
 tools/perf/util/auxtrace.h                         |    6 +-
 tools/perf/util/bpf-event.c                        |  380 +++++-
 tools/perf/util/bpf-event.h                        |   13 +
 tools/perf/util/bpf-filter.c                       |   30 +-
 tools/perf/util/bpf-filter.h                       |    3 +
 tools/perf/util/bpf_ftrace.c                       |   75 +-
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c     |    3 +-
 tools/perf/util/bpf_skel/func_latency.bpf.c        |  148 ++-
 tools/perf/util/bpf_skel/perf_version.h            |   17 +
 tools/perf/util/bpf_trace_augment.c                |  143 +++
 tools/perf/util/branch.c                           |    2 +-
 tools/perf/util/build-id.c                         |   65 +-
 tools/perf/util/build-id.h                         |    8 +-
 tools/perf/util/cap.c                              |    1 -
 tools/perf/util/cap.h                              |    5 +
 tools/perf/util/cgroup.c                           |   23 +-
 tools/perf/util/cgroup.h                           |    3 +-
 tools/perf/util/comm.c                             |    2 +
 tools/perf/util/data-convert-bt.c                  |   16 +-
 tools/perf/util/data-convert-json.c                |   36 +-
 tools/perf/util/db-export.c                        |   11 +-
 tools/perf/util/debug.c                            |   75 +-
 tools/perf/util/debug.h                            |    1 +
 tools/perf/util/debuginfo.c                        |    2 +-
 tools/perf/util/disasm.c                           |    9 +-
 tools/perf/util/dlfilter.c                         |    2 +-
 tools/perf/util/drm_pmu.c                          |  686 +++++++++++
 tools/perf/util/drm_pmu.h                          |   39 +
 tools/perf/util/dso.c                              |  115 +-
 tools/perf/util/dso.h                              |   75 +-
 tools/perf/util/dsos.c                             |   20 +-
 tools/perf/util/env.c                              |  132 ++-
 tools/perf/util/env.h                              |    9 +-
 tools/perf/util/event.c                            |   23 +-
 tools/perf/util/event.h                            |    6 +-
 tools/perf/util/evlist.c                           |   21 +-
 tools/perf/util/evlist.h                           |    9 +-
 tools/perf/util/evsel.c                            |  125 +-
 tools/perf/util/evsel.h                            |    8 +
 tools/perf/util/expr.c                             |    8 +-
 tools/perf/util/ftrace.h                           |    5 +
 tools/perf/util/genelf.c                           |   87 +-
 tools/perf/util/header.c                           |  256 +++--
 tools/perf/util/header.h                           |    1 +
 tools/perf/util/hist.c                             |    4 +-
 tools/perf/util/hist.h                             |    3 +-
 tools/perf/util/hwmon_pmu.c                        |   40 +-
 tools/perf/util/hwmon_pmu.h                        |    4 +-
 tools/perf/util/intel-tpebs.c                      |    4 +-
 tools/perf/util/jitdump.c                          |   21 +-
 tools/perf/util/machine.c                          |   44 +-
 tools/perf/util/machine.h                          |    6 +-
 tools/perf/util/map.c                              |   15 +-
 tools/perf/util/map.h                              |    5 +-
 tools/perf/util/metricgroup.c                      |  277 +----
 tools/perf/util/metricgroup.h                      |   10 +-
 tools/perf/util/parse-events.c                     |  438 +++----
 tools/perf/util/parse-events.h                     |    5 +-
 tools/perf/util/parse-events.l                     |   38 +-
 tools/perf/util/parse-events.y                     |   29 +-
 tools/perf/util/pfm.c                              |    6 +-
 tools/perf/util/pmu.c                              |   63 +-
 tools/perf/util/pmu.h                              |    5 +-
 tools/perf/util/pmus.c                             |  134 ++-
 tools/perf/util/pmus.h                             |    7 +-
 tools/perf/util/print-events.c                     |  233 ++--
 tools/perf/util/print-events.h                     |    4 +-
 tools/perf/util/probe-event.c                      |   12 +-
 tools/perf/util/probe-file.c                       |    4 +-
 tools/perf/util/probe-finder.c                     |    5 +-
 tools/perf/util/python.c                           |  145 ++-
 tools/perf/util/s390-cpumsf.c                      |    2 +-
 tools/perf/util/sample-raw.c                       |    7 +-
 tools/perf/util/sample-raw.h                       |    2 +-
 tools/perf/util/sample.h                           |    6 +-
 .../util/scripting-engines/trace-event-python.c    |    9 +-
 tools/perf/util/session.c                          |   23 +-
 tools/perf/util/session.h                          |    7 +-
 tools/perf/util/sha1.c                             |   97 ++
 tools/perf/util/sha1.h                             |    6 +
 tools/perf/util/sort.c                             |   95 +-
 tools/perf/util/sort.h                             |    5 +-
 tools/perf/util/spark.c                            |    8 +-
 tools/perf/util/spark.h                            |    1 +
 tools/perf/util/srcline.c                          |   10 +-
 tools/perf/util/stat-display.c                     |   50 +-
 tools/perf/util/stat-shadow.c                      |   12 +-
 tools/perf/util/stat.c                             |    8 +-
 tools/perf/util/stat.h                             |   12 +-
 tools/perf/util/symbol-minimal.c                   |    2 +-
 tools/perf/util/symbol.c                           |   10 +-
 tools/perf/util/symbol_conf.h                      |    2 +-
 tools/perf/util/synthetic-events.c                 |   58 +-
 tools/perf/util/synthetic-events.h                 |    2 +
 tools/perf/util/target.c                           |   54 +-
 tools/perf/util/target.h                           |   15 +-
 tools/perf/util/thread.c                           |   26 +-
 tools/perf/util/thread.h                           |    9 +-
 tools/perf/util/thread_map.c                       |   32 +-
 tools/perf/util/thread_map.h                       |    6 +-
 tools/perf/util/tool.c                             |   16 +-
 tools/perf/util/tool.h                             |    3 +-
 tools/perf/util/tool_pmu.c                         |   56 +-
 tools/perf/util/tool_pmu.h                         |    2 +-
 tools/perf/util/top.c                              |    4 +-
 tools/perf/util/top.h                              |    1 +
 tools/perf/util/tp_pmu.c                           |  210 ++++
 tools/perf/util/tp_pmu.h                           |   19 +
 tools/perf/util/trace_augment.h                    |   62 +-
 tools/perf/util/unwind-libdw.c                     |    7 +-
 359 files changed, 10612 insertions(+), 3324 deletions(-)
 create mode 100644 tools/build/feature/test-libbpf-strings.c
 delete mode 100644 tools/build/feature/test-libcrypto.c
 delete mode 100644 tools/perf/arch/powerpc/util/event.c
 delete mode 100644 tools/perf/arch/x86/tests/sample-parsing.c
 create mode 100644 tools/perf/arch/x86/tests/topdown.c
 create mode 100644 tools/perf/pmu-events/arch/common/common/software.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/basic.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/crypto6.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/extended.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/pai_crypto.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/pai_ext.json
 create mode 100644 tools/perf/pmu-events/arch/s390/cf_z17/transaction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/counter.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/pantherlake/virtual-memory.json
 create mode 100755 tools/perf/tests/shell/drm_pmu.sh
 create mode 100755 tools/perf/tests/shell/header.sh
 create mode 100755 tools/perf/tests/shell/sched.sh
 create mode 100755 tools/perf/tests/shell/test_bpf_metadata.sh
 create mode 100644 tools/perf/tests/subcmd-help.c
 create mode 100644 tools/perf/util/bpf_skel/perf_version.h
 create mode 100644 tools/perf/util/bpf_trace_augment.c
 create mode 100644 tools/perf/util/drm_pmu.c
 create mode 100644 tools/perf/util/drm_pmu.h
 create mode 100644 tools/perf/util/sha1.c
 create mode 100644 tools/perf/util/sha1.h
 create mode 100644 tools/perf/util/tp_pmu.c
 create mode 100644 tools/perf/util/tp_pmu.h
