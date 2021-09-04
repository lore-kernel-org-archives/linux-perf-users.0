Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-29.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2BBC433EF
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 18:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B80A60E77
	for <linux-perf-users@archiver.kernel.org>; Sat,  4 Sep 2021 18:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhIDSul (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 4 Sep 2021 14:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229819AbhIDSuk (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 4 Sep 2021 14:50:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F47160E74;
        Sat,  4 Sep 2021 18:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630781378;
        bh=/O/5UNqV7N/pboCrQbV4swLlyqKc4VPK/8iKcZ29O/4=;
        h=From:To:Cc:Subject:Date:From;
        b=PYaoL+dJaYnG7QZ2uUt5/XIP0LKsc3CdsHWjM6vg+dPLAnbgwgELd0mAY6Dds6Ov8
         WOUUZsaQnyY9/Qfz4cGACjv4Avm2Nhi9vTO3jPgi3lWgbi3cgbfFpGti+35q3n7Blo
         qBa1knKlyi4U4kIo2qki5lDdUxCpRoQ4sl/QuwBYaw62DKSz0vmm5qALiniPRZPZ7A
         bnpPwita6skv1j7HdLYYRYIQlezeqmfERsE3N3BaNq5jGWm4pf6vQxhSnXM3NQSVxe
         vtbKnJh29UbcJhfhnUgB19WUeO2xET23gnZK0xDgI8bhYWLDCG/gjBrMTSaWF6fpp6
         oV5+Th9pRbyMA==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alyssa Ross <hi@alyssa.is>,
        Andreas Gerstmayr <agerstmayr@redhat.com>,
        Colin King <colin.king@canonical.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Eirik Fuller <efuller@redhat.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Joshua Martinez <joshuamart@google.com>,
        Leo Yan <leo.yan@linaro.org>, Li Huafei <lihuafei1@huawei.com>,
        Nghia Le <nghialm78@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Wei Li <liwei391@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.15
Date:   Sat,  4 Sep 2021 15:49:24 -0300
Message-Id: <20210904184924.16279-1-acme@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Linus,

	Please consider pulling,

Best regards,

- Arnaldo

Test results at the end of this message.

The following changes since commit 7d2a07b769330c34b4deabeed939325c77a7ec2f:

  Linux 5.14 (2021-08-29 15:04:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.15-2021-09-04

for you to fetch changes up to c7a3828d98db2730079265b5f51933dfcef8bb5f:

  perf tests: Add test for PMU aliases (2021-09-03 08:38:49 -0300)

----------------------------------------------------------------
perf tools changes for v5.15:

New features:

- Improvements for the flamegraph python script, including:

  - Display perf.data header
  - Display PIDs of user stacks
  - Added option to change color scheme
  - Default to blue/green color scheme to improve accessibility
  - Correctly identify kernel stacks when debuginfo is available

- Improvements for 'perf bench futex':
  - Add --mlockall parameter
  - Add --broadcast and --pi to the 'requeue' sub benchmark

- Add support for PMU aliases.

- Introduce an ARM Coresight ETE decoder.

- Add a 'perf bench' entry for evlist open/close operations, to help quantify
  improvements with multithreading 'perf record'.

- Allow reporting the [un]throttle PERF_RECORD_ meta event in 'perf script's
  python scripting.

- Add a 'perf test' entry for PMU aliases.

- Add a 'perf test' entry for 'perf record/perf report/perf script' pipe mode.

Fixes:

- perf script dlfilter (API for filtering via dynamically loaded shared object
  introduced in v5.14) fixes and a 'perf test' entry for it.

- Fix get_current_dir_name() compilation on Android.

- Fix issues with asciidoc and double dashes uses.

- Fix memory leaks in the BTF handling code.

- Fix leftover problems in the Documentation from the infrastructure originally
  lifted from the git codebase.

- Fix *probe_vfs_getname.sh 'perf test' failures.

- Handle fd gaps in 'perf test's test__dso_data_reopen().

- Make sure to show disasembly warnings for 'perf annotate --stdio'.

- Fix output from pipe to file and vice-versa in 'perf record/report/script'.

- Correct 'perf data -h' output.

- Fix wrong comm in system-wide mode with 'perf record --delay'.

- Do not allow --for-each-cgroup without cpu in 'perf stat'

- Make 'perf test --skip' work on shell tests.

- Fix libperf's verbose printing.

Misc improvements:

- Preparatory patches for multithreading varios 'perf record' phases
  (synthesizing, opening, recording, etc).

- Add sparse context/locking annotations in compiler-types.h, also to help with
  the multithreading effort.

- Optimize the generation of the arch specific erno tables used in 'perf trace'.

- Optimize libperf's perf_cpu_map__max().

- Improve ARM's CoreSight warnings.

- Report collisions in AUX records.

- Improve warnings for the LLVM 'perf test' entry.

- Improve the PMU events 'perf test' codebase.

- perf test: Do not compare overheads in the zstd comp test

- Better support annotation on ARM.

- Update 'perf trace's cmd string table to decode sys_bpf() first arg.

Vendor events:

- Add JSON events and metrics for Intel's Ice Lake, Tiger Lake and Elhart Lake.

- Update JSON eventsand metrics for Intel's Cascade Lake and Sky Lake servers.

Hardware tracing:

- Improvements for the ARM hardware tracing auxtrace support.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (6):
      perf script: Fix documented const'ness of perf_dlfilter_fns
      perf script: Fix unnecessary machine_resolve()
      perf script: Fix --list-dlfilters documentation
      perf dlfilter: Amend documentation wrt library dependencies
      perf build: Move perf_dlfilters.h in the source tree
      perf tests: Add dlfilter test

Alexey Dobriyan (1):
      perf tools: Fixup get_current_dir_name() compilation

Alyssa Ross (1):
      perf docs: Fix accidental em-dashes

Andreas Gerstmayr (1):
      perf flamegraph: flamegraph.py script improvements

Arnaldo Carvalho de Melo (6):
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf config: Fix caching and memory leak in perf_home_perfconfig()
      perf bench inject-buildid: Handle writen() errors
      perf bench evlist-open-close: Use PRIu64 with u64 to fix build on 32-bit architectures
      perf dlfilters: Fix build on environments with a --sysroot gcc arg

Colin Ian King (1):
      perf header: Fix spelling mistake "cant'" -> "can't"

Davidlohr Bueso (6):
      perf bench futex: Group test parameters cleanup
      perf bench futex: Remove bogus backslash from comment
      perf bench futex: Add --mlockall parameter
      perf bench futex, requeue: Add --broadcast option
      perf bench futex, requeue: Robustify futex_wait() handling
      perf bench futex, requeue: Add --pi parameter

Eirik Fuller (1):
      perf test: Handle fd gaps in test__dso_data_reopen

Ian Rogers (9):
      perf doc: Fix perfman.info build
      perf doc: Fix doc.dep
      perf doc: Remove references to user-manual
      perf doc: Add info pages to all target.
      perf doc: Remove cmd-list.perl references
      perf doc: Remove howto-index.sh related references.
      perf doc: Reorganize ARTICLES variables.
      perf beauty: Reuse the generic arch errno switch
      perf bpf: Fix memory leaks relating to BTF.

James Clark (26):
      perf cs-etm: Refactor initialisation of kernel start address
      perf cs-etm: Split setup and timestamp search functions
      perf cs-etm: Only setup queues when they are modified
      perf cs-etm: Suppress printing when resetting decoder
      perf cs-etm: Use existing decoder instead of resetting it
      perf cs-etm: Pass unformatted flag to decoder
      perf tools: Add WARN_ONCE equivalent for UI warnings
      perf annotate: Re-add annotate_warned functionality
      perf annotate: Add disassembly warnings for annotate --stdio
      perf tools: Add flag for tracking warnings of missing DSOs
      perf cs-etm: Improve Coresight zero timestamp warning
      perf cs-etm: Add warnings for missing DSOs
      perf tests: Fix *probe_vfs_getname.sh test failures
      perf tools: Refactor LLVM test warning for missing binary
      perf tools: Fix LLVM test failure when running in verbose mode
      perf tools: Fix LLVM download hint link
      tools build: Fix feature detect clean for out of source builds
      perf cs-etm: Refactor initialisation of decoder params.
      perf cs-etm: Initialise architecture based on TRCIDR1
      perf cs-etm: Refactor out ETMv4 header saving
      perf cs-etm: Save TRCDEVARCH register
      perf cs-etm: Fix typo
      perf cs-etm: Update OpenCSD decoder for ETE
      perf cs-etm: Create ETE decoder
      perf cs-etm: Print the decoder name
      perf cs-etm: Show a warning for an unknown magic number

Jin Yao (15):
      perf vendor events intel: Add core event list for Tigerlake
      perf vendor events: Add metrics for Tigerlake
      perf vendor events intel: Add core event list for Elkhartlake
      perf vendor events intel: Add basic metrics for Elkhartlake
      perf vendor events: Add metrics for Icelake Server
      perf vendor events intel: Update core event list for CascadeLake Server
      perf vendor events intel: Update uncore event list for CascadeLake Server
      perf vendor events: Update metrics for CascadeLake Server
      perf vendor events intel: Update core event list for SkyLake Server
      perf vendor events intel: Update uncore event list for SkyLake Server
      perf vendor events: Update metrics for SkyLake Server
      libperf: Add perf_cpu_map__default_new()
      perf tools: Create hybrid flag in target
      perf tools: Enable on a list of CPUs for hybrid
      perf tests: Add test for PMU aliases

John Garry (12):
      perf jevents: Make build dependency on test JSONs
      perf test: Factor out pmu-events event comparison
      perf jevents: Relocate test events to cpu folder
      perf test: Declare pmu-events test events separately
      perf test: Factor out pmu-events alias comparison
      perf test: Test pmu-events core aliases separately
      perf pmu: Check .is_uncore field in pmu_add_cpu_aliases_map()
      perf test: Re-add pmu-event uncore PMU alias test
      perf test: Add more pmu-events uncore aliases
      perf pmu: Make pmu_add_sys_aliases() public
      perf jevents: Print SoC name per system event table
      perf test: Add pmu-events sys event support

Joshua Martinez (1):
      perf data: Correct -h output

Kan Liang (1):
      perf pmu: Add PMU alias support

Leo Yan (9):
      perf auxtrace: Use WRITE_ONCE() for updating aux_tail
      perf auxtrace: Drop legacy __sync functions
      perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
      perf: Cleanup for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
      tools: Remove feature-sync-compare-and-swap feature detection
      perf env: Track kernel 64-bit mode in environment
      perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
      perf auxtrace arm: Support compat_auxtrace_mmap__{read_head|write_tail}
      perf build: Report failure for testing feature libopencsd

Li Huafei (3):
      perf env: Normalize aarch64.* and arm64.* to arm64 in normalize_arch()
      perf annotate: Add error log in symbol__annotate()
      perf unwind: Do not overwrite FEATURE_CHECK_LDFLAGS-libunwind-{x86,aarch64}

Namhyung Kim (8):
      perf tools: Remove repipe argument from perf_session__new()
      perf tools: Pass a fd to perf_file_header__read_pipe()
      perf inject: Fix output from a pipe to a file
      perf inject: Fix output from a file to a pipe
      perf tools: Add pipe_test.sh to verify pipe operations
      perf test: Do not compare overheads in the zstd comp test
      perf stat: Do not allow --for-each-cgroup without cpu
      perf record: Fix wrong comm in system-wide mode with delay

Nghia Le (1):
      perf tools: Add missing newline at the end of header file

Riccardo Mancini (19):
      perf bench: Add benchmark for evlist open/close operations
      perf test: Make --skip work on shell tests
      tools: Add sparse context/locking annotations in compiler-types.h
      perf tests dlfilter: Free desc and long_desc in check_filter_desc
      libsubcmd: add OPT_UINTEGER_OPTARG option type
      libperf cpumap: Take into advantage it is sorted to optimize perf_cpu_map__max()
      perf mmap: Add missing bitops.h header
      perf evsel: Remove retry_sample_id goto label
      perf evsel: Separate open preparation from open itself
      perf evsel: Save open flags in evsel in prepare_open()
      perf evsel: Separate missing feature disabling from evsel__open_cpu
      perf evsel: Add evsel__prepare_open()
      perf evsel: Separate missing feature detection from evsel__open_cpu()
      perf evsel: Separate rlimit increase from evsel__open_cpu()
      perf evsel: Move ignore_missing_thread() to fallback code
      perf evsel: Move test_attr__open() to success path in evsel__open_cpu()
      perf evsel: Move bpf_counter__install_pe() to success path in evsel__open_cpu()
      perf evsel: Handle precise_ip fallback in evsel__open_cpu()
      perf evlist: Add evlist__for_each_entry_from() macro

Shunsuke Nakamura (1):
      libperf tests: Fix verbose printing

Stephen Brennan (2):
      perf script python: Fix unintended underline
      perf script python: Allow reporting the [un]throttle PERF_RECORD_ meta event

Suzuki K Poulose (1):
      perf session: Report collisions in AUX records

Wei Li (1):
      perf trace: Update cmd string table to decode sys_bpf first arg

 tools/build/Makefile                               |    2 +-
 tools/build/Makefile.feature                       |    1 -
 tools/build/feature/Makefile                       |    4 -
 tools/build/feature/test-all.c                     |    4 -
 tools/build/feature/test-libopencsd.c              |    4 +-
 tools/build/feature/test-sync-compare-and-swap.c   |   15 -
 tools/include/linux/compiler_types.h               |   18 +
 tools/lib/perf/cpumap.c                            |   15 +-
 tools/lib/perf/include/internal/tests.h            |    2 +
 tools/lib/perf/include/perf/cpumap.h               |    1 +
 tools/lib/subcmd/parse-options.h                   |    1 +
 tools/perf/Documentation/Makefile                  |   74 +-
 tools/perf/Documentation/build-docdep.perl         |   46 +
 tools/perf/Documentation/cat-texi.perl             |   46 +
 tools/perf/Documentation/intel-hybrid.txt          |    2 +-
 tools/perf/Documentation/perf-c2c.txt              |    2 +-
 tools/perf/Documentation/perf-dlfilter.txt         |   12 +-
 tools/perf/Documentation/perf-iostat.txt           |    4 +-
 tools/perf/Documentation/perf-record.txt           |    2 +-
 tools/perf/Documentation/perf-script-python.txt    |    2 +-
 tools/perf/Documentation/perf-script.txt           |    2 +-
 tools/perf/Documentation/perf-stat.txt             |   14 +-
 tools/perf/Makefile.config                         |   14 +-
 tools/perf/Makefile.perf                           |   17 +-
 tools/perf/arch/arm/util/auxtrace.c                |   32 +
 tools/perf/arch/arm/util/cs-etm.c                  |   97 +-
 tools/perf/arch/x86/util/pmu.c                     |  155 +-
 tools/perf/bench/Build                             |    1 +
 tools/perf/bench/bench.h                           |    1 +
 tools/perf/bench/evlist-open-close.c               |  258 +
 tools/perf/bench/futex-hash.c                      |   62 +-
 tools/perf/bench/futex-lock-pi.c                   |   60 +-
 tools/perf/bench/futex-requeue.c                   |  159 +-
 tools/perf/bench/futex-wake-parallel.c             |   66 +-
 tools/perf/bench/futex-wake.c                      |   65 +-
 tools/perf/bench/futex.h                           |   52 +-
 tools/perf/bench/inject-buildid.c                  |   52 +-
 tools/perf/bench/synthesize.c                      |    4 +-
 tools/perf/builtin-annotate.c                      |    2 +-
 tools/perf/builtin-bench.c                         |    1 +
 tools/perf/builtin-buildid-cache.c                 |    2 +-
 tools/perf/builtin-buildid-list.c                  |    2 +-
 tools/perf/builtin-c2c.c                           |    2 +-
 tools/perf/builtin-data.c                          |   62 +-
 tools/perf/builtin-diff.c                          |    4 +-
 tools/perf/builtin-evlist.c                        |    2 +-
 tools/perf/builtin-inject.c                        |   38 +-
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-kvm.c                           |    4 +-
 tools/perf/builtin-lock.c                          |    2 +-
 tools/perf/builtin-mem.c                           |    3 +-
 tools/perf/builtin-record.c                        |   50 +-
 tools/perf/builtin-report.c                        |    2 +-
 tools/perf/builtin-sched.c                         |    4 +-
 tools/perf/builtin-script.c                        |   19 +-
 tools/perf/builtin-stat.c                          |   14 +-
 tools/perf/builtin-timechart.c                     |    3 +-
 tools/perf/builtin-top.c                           |    2 +-
 tools/perf/builtin-trace.c                         |   12 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c        |  336 ++
 tools/perf/{util => include/perf}/perf_dlfilter.h  |    0
 tools/perf/pmu-events/Build                        |    5 +-
 .../test/{test_cpu => test_soc/cpu}/branch.json    |    0
 .../test/{test_cpu => test_soc/cpu}/cache.json     |    0
 .../test/{test_cpu => test_soc/cpu}/other.json     |    0
 .../test/{test_cpu => test_soc/cpu}/uncore.json    |   23 +-
 .../pmu-events/arch/test/test_soc/sys/uncore.json  |    9 +
 .../pmu-events/arch/x86/cascadelakex/cache.json    | 5468 ++++++++++----------
 .../arch/x86/cascadelakex/clx-metrics.json         |  253 +-
 .../arch/x86/cascadelakex/floating-point.json      |   48 +-
 .../pmu-events/arch/x86/cascadelakex/frontend.json |  550 +-
 .../pmu-events/arch/x86/cascadelakex/memory.json   | 5444 +++++++++----------
 .../pmu-events/arch/x86/cascadelakex/other.json    | 4146 +++++++--------
 .../pmu-events/arch/x86/cascadelakex/pipeline.json | 1046 ++--
 .../arch/x86/cascadelakex/uncore-memory.json       |   21 +-
 .../arch/x86/cascadelakex/uncore-other.json        |  161 +-
 .../arch/x86/cascadelakex/virtual-memory.json      |  256 +-
 .../pmu-events/arch/x86/elkhartlake/cache.json     |  226 +
 .../arch/x86/elkhartlake/ehl-metrics.json          |   57 +
 .../arch/x86/elkhartlake/floating-point.json       |   24 +
 .../pmu-events/arch/x86/elkhartlake/frontend.json  |   93 +
 .../pmu-events/arch/x86/elkhartlake/memory.json    |   86 +
 .../pmu-events/arch/x86/elkhartlake/other.json     |  424 ++
 .../pmu-events/arch/x86/elkhartlake/pipeline.json  |  278 +
 .../arch/x86/elkhartlake/virtual-memory.json       |  273 +
 .../pmu-events/arch/x86/icelakex/icx-metrics.json  |  315 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    3 +-
 tools/perf/pmu-events/arch/x86/skylakex/cache.json | 1724 +++---
 .../arch/x86/skylakex/floating-point.json          |   56 +-
 .../pmu-events/arch/x86/skylakex/frontend.json     |  580 +--
 .../perf/pmu-events/arch/x86/skylakex/memory.json  | 1300 ++---
 tools/perf/pmu-events/arch/x86/skylakex/other.json |  104 +-
 .../pmu-events/arch/x86/skylakex/pipeline.json     | 1068 ++--
 .../pmu-events/arch/x86/skylakex/skx-metrics.json  |  247 +-
 .../arch/x86/skylakex/uncore-memory.json           |    9 -
 .../pmu-events/arch/x86/skylakex/uncore-other.json |  171 +-
 .../arch/x86/skylakex/virtual-memory.json          |  288 +-
 .../perf/pmu-events/arch/x86/tigerlake/cache.json  |  595 +++
 .../arch/x86/tigerlake/floating-point.json         |   94 +
 .../pmu-events/arch/x86/tigerlake/frontend.json    |  463 ++
 .../perf/pmu-events/arch/x86/tigerlake/memory.json |  295 ++
 .../perf/pmu-events/arch/x86/tigerlake/other.json  |  189 +
 .../pmu-events/arch/x86/tigerlake/pipeline.json    |  982 ++++
 .../pmu-events/arch/x86/tigerlake/tgl-metrics.json |  231 +
 .../arch/x86/tigerlake/virtual-memory.json         |  225 +
 tools/perf/pmu-events/jevents.c                    |    5 +-
 tools/perf/pmu-events/pmu-events.h                 |    1 +
 tools/perf/scripts/python/flamegraph.py            |  108 +-
 tools/perf/tests/Build                             |    1 +
 tools/perf/tests/builtin-test.c                    |   15 +-
 tools/perf/tests/dlfilter-test.c                   |  416 ++
 tools/perf/tests/dso-data.c                        |   14 +-
 tools/perf/tests/llvm.c                            |    7 +-
 tools/perf/tests/parse-events.c                    |   92 +
 tools/perf/tests/pmu-events.c                      |  699 ++-
 tools/perf/tests/shell/lib/probe_vfs_getname.sh    |    2 +-
 tools/perf/tests/shell/pipe_test.sh                |   69 +
 tools/perf/tests/shell/record+zstd_comp_decomp.sh  |    4 +-
 tools/perf/tests/tests.h                           |    1 +
 tools/perf/tests/topology.c                        |    4 +-
 tools/perf/trace/beauty/arch_errno_names.sh        |   11 +-
 tools/perf/ui/browsers/annotate.c                  |    1 +
 tools/perf/ui/gtk/annotate.c                       |    1 +
 tools/perf/util/annotate.c                         |   26 +-
 tools/perf/util/auxtrace.c                         |  104 +-
 tools/perf/util/auxtrace.h                         |   49 +-
 tools/perf/util/bpf-event.c                        |    4 +-
 tools/perf/util/config.c                           |    5 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  170 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h    |   13 +
 tools/perf/util/cs-etm.c                           |  238 +-
 tools/perf/util/cs-etm.h                           |   11 +
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/data-convert-json.c                |    2 +-
 tools/perf/util/debug.h                            |   14 +
 tools/perf/util/dlfilter.c                         |    6 +-
 tools/perf/util/dlfilter.h                         |    2 +
 tools/perf/util/dso.h                              |    1 +
 tools/perf/util/env.c                              |   26 +-
 tools/perf/util/env.h                              |    3 +
 tools/perf/util/events_stats.h                     |    1 +
 tools/perf/util/evlist-hybrid.c                    |   73 +
 tools/perf/util/evlist-hybrid.h                    |    1 +
 tools/perf/util/evlist.c                           |    3 +-
 tools/perf/util/evlist.h                           |   16 +
 tools/perf/util/evsel.c                            |  397 +-
 tools/perf/util/evsel.h                            |   14 +
 tools/perf/util/get_current_dir_name.c             |    3 +-
 tools/perf/util/header.c                           |   14 +-
 tools/perf/util/header.h                           |    2 +-
 tools/perf/util/llvm-utils.c                       |   40 +-
 tools/perf/util/mmap.h                             |    1 +
 tools/perf/util/parse-events.y                     |    3 +-
 tools/perf/util/parse-sublevel-options.h           |    2 +-
 tools/perf/util/pmu.c                              |   80 +-
 tools/perf/util/pmu.h                              |   10 +
 .../util/scripting-engines/trace-event-python.c    |   32 +
 tools/perf/util/session.c                          |   20 +-
 tools/perf/util/session.h                          |   12 +-
 tools/perf/util/synthetic-events.c                 |   53 +-
 tools/perf/util/synthetic-events.h                 |    6 +
 tools/perf/util/target.h                           |    1 +
 tools/perf/util/trace-event.h                      |    3 +
 163 files changed, 20109 insertions(+), 12571 deletions(-)
 delete mode 100644 tools/build/feature/test-sync-compare-and-swap.c
 create mode 100755 tools/perf/Documentation/build-docdep.perl
 create mode 100755 tools/perf/Documentation/cat-texi.perl
 create mode 100644 tools/perf/bench/evlist-open-close.c
 create mode 100644 tools/perf/dlfilters/dlfilter-test-api-v0.c
 rename tools/perf/{util => include/perf}/perf_dlfilter.h (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/branch.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/cache.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/other.json (100%)
 rename tools/perf/pmu-events/arch/test/{test_cpu => test_soc/cpu}/uncore.json (51%)
 create mode 100644 tools/perf/pmu-events/arch/test/test_soc/sys/uncore.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/tgl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/tigerlake/virtual-memory.json
 create mode 100644 tools/perf/tests/dlfilter-test.c
 create mode 100755 tools/perf/tests/shell/pipe_test.sh

Test results:

The first ones are container based builds of tools/perf with and without libelf
support.  Where clang is available, it is also used to build perf with/without
libelf, and building with LIBCLANGLLVM=1 (built-in clang) with gcc and clang
when clang and its devel libraries are installed.

The objtool and samples/bpf/ builds are disabled now that I'm switching from
using the sources in a local volume to fetching them from a http server to
build it inside the container, to make it easier to build in a container cluster.
Those will come back later.

Several are cross builds, the ones with -x-ARCH and the android one, and those
may not have all the features built, due to lack of multi-arch devel packages,
available and being used so far on just a few, like
debian:experimental-x-{arm64,mipsel}.

The 'perf test' one will perform a variety of tests exercising
tools/perf/util/, tools/lib/{bpf,traceevent,etc}, as well as run perf commands
with a variety of command line event specifications to then intercept the
sys_perf_event syscall to check that the perf_event_attr fields are set up as
expected, among a variety of other unit tests.

Then there is the 'make -C tools/perf build-test' ones, that build tools/perf/
with a variety of feature sets, exercising the build with an incomplete set of
features as well as with a complete one.

The following ones are now being run on all the containers, so far just with
gcc, clang will come later. All clear for this batch.

There is still the mageia:7 distro + clang 8 failure, seemingly unrelated to
the patches in this series, it'll be investigated. It builds just fine with gcc
8.4.

There is also a strange one with openmandriva:cooker, where on the feature build
test it doesn't manage to find libpthread, looks like a distro problem, will keep
it there to see if a refreshed container cures this soon.

     1	almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
     2	alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
     3	alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
     4	alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
     5	alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
     6	alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
     7	alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
     8	alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
     9	alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
    10	alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
    11	alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
    12	alpine:3.14                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
    13	alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210625) 10.3.1 20210625 , Alpine clang version 11.1.0
    14	alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
    15	alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
    16	alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
    17	amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
    18	amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
    19	android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
    20	android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease) 
    21	centos:8                      : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+587+5187cac0)
    22	centos:stream                 : Ok   gcc (GCC) 8.5.0 20210514 (Red Hat 8.5.0-3) , clang version 12.0.0 (Red Hat 12.0.0-1.module_el8.5.0+840+21214faf)
    23	clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.2.1 20210826 releases/gcc-11.2.0-129-gcb8593a3f2 , clang version 11.1.0
    24	debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
    25	debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
    26	debian:11                     : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    27	debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
    28	debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    29	debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    30	debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    31	debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
    32	fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
    33	fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
    34	fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
    35	fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
    36	fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
    37	fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
    38	fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
    39	fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
    40	fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
    41	fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
    42	fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
    43	fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
    44	fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
    45	fedora:34                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 12.0.1 (Fedora 12.0.1-1.fc34)
    46	fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
    47	fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
    48	fedora:35                     : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    49	fedora:rawhide                : Ok   gcc (GCC) 11.2.1 20210728 (Red Hat 11.2.1-1) , clang version 13.0.0 (Fedora 13.0.0~rc1-1.fc35)
    50	gentoo-stage3:latest          : Ok   gcc (Gentoo 10.3.0-r2 p3) 10.3.0 
    51	mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
    52	mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)
          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.14.0/tools/build/Makefile.build:139: util] Error 2
    53  openmandriva:cooker           : FAIL gcc version 11.2.0 20210728 (OpenMandriva) (GCC) 
    In file included from builtin-bench.c:22:
    bench/bench.h:66:19: error: conflicting types for 'pthread_attr_setaffinity_np'; have 'int(pthread_attr_t *, size_t,  cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  cpu_set_t *)'}
       66 | static inline int pthread_attr_setaffinity_np(pthread_attr_t *attr __maybe_unused,
          |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from bench/bench.h:64,
                     from builtin-bench.c:22:
    /usr/include/pthread.h:394:12: note: previous declaration of 'pthread_attr_setaffinity_np' with type 'int(pthread_attr_t *, size_t,  const cpu_set_t *)' {aka 'int(pthread_attr_t *, long unsigned int,  const cpu_set_t *)'}
      394 | extern int pthread_attr_setaffinity_np (pthread_attr_t *__attr,
          |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
    54	opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
    55	opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
    56	opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
    57	opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
    58	opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.1.1 20210721 [revision 076930b9690ac3564638636f6b13bbb6bc608aea] , clang version 12.0.1
    59	oraclelinux:8                 : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1.0.1) , clang version 11.0.0 (Red Hat 11.0.0-1.0.1.module+el8.4.0+20046+39fed697)
    60	rockylinux:8                  : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module+el8.4.0+412+05cf643f)
    61	ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
    62	ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    63	ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    64	ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    65	ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    66	ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    67	ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
    68	ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
    69	ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    70	ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
    71	ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    72	ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    73	ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    74	ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    75	ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    76	ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    77	ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    78	ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
    79	ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
    80	ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0 
    81	ubuntu:20.10                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1~20.10) 10.3.0 , Ubuntu clang version 11.0.0-2
    82	ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
    83	ubuntu:21.10                  : Ok   gcc (Ubuntu 11.2.0-1ubuntu2) 11.2.0 , Ubuntu clang version 12.0.1-1
  $

  # git log --oneline -1
  c7a3828d98db (HEAD -> perf/core, tag: perf-tools-for-v5.15-2021-09-04, five/perf/core, acme.korg/tmp.perf/core) perf tests: Add test for PMU aliases
  # uname -a
  Linux quaco 5.13.13-200.fc34.x86_64 #1 SMP Thu Aug 26 17:06:39 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # perf -vv
  perf version 5.14.gc7a3828d98db
                   dwarf: [ on  ]  # HAVE_DWARF_SUPPORT
      dwarf_getlocations: [ on  ]  # HAVE_DWARF_GETLOCATIONS_SUPPORT
                   glibc: [ on  ]  # HAVE_GLIBC_SUPPORT
           syscall_table: [ on  ]  # HAVE_SYSCALL_TABLE_SUPPORT
                  libbfd: [ on  ]  # HAVE_LIBBFD_SUPPORT
                  libelf: [ on  ]  # HAVE_LIBELF_SUPPORT
                 libnuma: [ on  ]  # HAVE_LIBNUMA_SUPPORT
  numa_num_possible_cpus: [ on  ]  # HAVE_LIBNUMA_SUPPORT
                 libperl: [ on  ]  # HAVE_LIBPERL_SUPPORT
               libpython: [ on  ]  # HAVE_LIBPYTHON_SUPPORT
                libslang: [ on  ]  # HAVE_SLANG_SUPPORT
               libcrypto: [ on  ]  # HAVE_LIBCRYPTO_SUPPORT
               libunwind: [ on  ]  # HAVE_LIBUNWIND_SUPPORT
      libdw-dwarf-unwind: [ on  ]  # HAVE_DWARF_SUPPORT
                    zlib: [ on  ]  # HAVE_ZLIB_SUPPORT
                    lzma: [ on  ]  # HAVE_LZMA_SUPPORT
               get_cpuid: [ on  ]  # HAVE_AUXTRACE_SUPPORT
                     bpf: [ on  ]  # HAVE_LIBBPF_SUPPORT
                     aio: [ on  ]  # HAVE_AIO_SUPPORT
                    zstd: [ on  ]  # HAVE_ZSTD_SUPPORT
                 libpfm4: [ OFF ]  # HAVE_LIBPFM
  # perf test
   1: vmlinux symtab matches kallsyms                                 : Ok
   2: Detect openat syscall event                                     : Ok
   3: Detect openat syscall event on all cpus                         : Ok
   4: Read samples using the mmap interface                           : Ok
   5: Test data source output                                         : Ok
   6: Parse event definition strings                                  : Ok
   7: Simple expression parser                                        : Ok
   8: PERF_RECORD_* events & perf_sample fields                       : Ok
   9: Parse perf pmu format                                           : Ok
  10: PMU events                                                      :
  10.1: PMU event table sanity                                        : Ok
  10.2: PMU event map aliases                                         : Ok
  10.3: Parsing of PMU event table metrics                            : Ok
  10.4: Parsing of PMU event table metrics with fake PMUs             : Ok
  11: DSO data read                                                   : Ok
  12: DSO data cache                                                  : Ok
  13: DSO data reopen                                                 : Ok
  14: Roundtrip evsel->name                                           : Ok
  15: Parse sched tracepoints fields                                  : Ok
  16: syscalls:sys_enter_openat event fields                          : Ok
  17: Setup struct perf_event_attr                                    : Ok
  18: Match and link multiple hists                                   : Ok
  19: 'import perf' in python                                         : Ok
  20: Breakpoint overflow signal handler                              : Ok
  21: Breakpoint overflow sampling                                    : Ok
  22: Breakpoint accounting                                           : Ok
  23: Watchpoint                                                      :
  23.1: Read Only Watchpoint                                          : Skip (missing hardware support)
  23.2: Write Only Watchpoint                                         : Ok
  23.3: Read / Write Watchpoint                                       : Ok
  23.4: Modify Watchpoint                                             : Ok
  24: Number of exit events of a simple workload                      : Ok
  25: Software clock events period values                             : Ok
  26: Object code reading                                             : Ok
  27: Sample parsing                                                  : Ok
  28: Use a dummy software event to keep tracking                     : Ok
  29: Parse with no sample_id_all bit set                             : Ok
  30: Filter hist entries                                             : Ok
  31: Lookup mmap thread                                              : Ok
  32: Share thread maps                                               : Ok
  33: Sort output of hist entries                                     : Ok
  34: Cumulate child hist entries                                     : Ok
  35: Track with sched_switch                                         : Ok
  36: Filter fds with revents mask in a fdarray                       : Ok
  37: Add fd to a fdarray, making it autogrow                         : Ok
  38: kmod_path__parse                                                : Ok
  39: Thread map                                                      : Ok
  40: LLVM search and compile                                         :
  40.1: Basic BPF llvm compile                                        : Ok
  40.2: kbuild searching                                              : Ok
  40.3: Compile source for BPF prologue generation                    : Ok
  40.4: Compile source for BPF relocation                             : Ok
  41: Session topology                                                : Ok
  42: BPF filter                                                      :
  42.1: Basic BPF filtering                                           : Ok
  42.2: BPF pinning                                                   : Ok
  42.3: BPF prologue generation                                       : Ok
  43: Synthesize thread map                                           : Ok
  44: Remove thread map                                               : Ok
  45: Synthesize cpu map                                              : Ok
  46: Synthesize stat config                                          : Ok
  47: Synthesize stat                                                 : Ok
  48: Synthesize stat round                                           : Ok
  49: Synthesize attr update                                          : Ok
  50: Event times                                                     : Ok
  51: Read backward ring buffer                                       : Ok
  52: Print cpu map                                                   : Ok
  53: Merge cpu map                                                   : Ok
  54: Probe SDT events                                                : Ok
  55: is_printable_array                                              : Ok
  56: Print bitmap                                                    : Ok
  57: perf hooks                                                      : Ok
  58: builtin clang support                                           : Skip (not compiled in)
  59: unit_number__scnprintf                                          : Ok
  60: mem2node                                                        : Ok
  61: time utils                                                      : Ok
  62: Test jit_write_elf                                              : Ok
  63: Test libpfm4 support                                            : Skip (not compiled in)
  64: Test api io                                                     : Ok
  65: maps__merge_in                                                  : Ok
  66: Demangle Java                                                   : Ok
  67: Demangle OCaml                                                  : Ok
  68: Parse and process metrics                                       : Ok
  69: PE file support                                                 : Ok
  70: Event expansion for cgroups                                     : Ok
  71: Convert perf time to TSC                                        : Ok
  72: dlfilter C API                                                  : Ok
  73: x86 rdpmc                                                       : Ok
  74: DWARF unwind                                                    : Ok
  75: x86 instruction decoder - new instructions                      : Ok
  76: Intel PT packet decoder                                         : Ok
  77: x86 bp modify                                                   : Ok
  78: x86 Sample parsing                                              : Ok
  79: build id cache operations                                       : Ok
  80: daemon operations                                               : Ok
  81: perf pipe recording and injection test                          : Ok
  82: Add vfs_getname probe to get syscall args filenames             : Ok
  83: probe libc's inet_pton & backtrace it with ping                 : Ok
  84: Use vfs_getname probe to get syscall args filenames             : Ok
  85: Zstd perf.data compression/decompression                        : Ok
  86: perf stat csv summary test                                      : Ok
  87: perf stat metrics (shadow stat) test                            : Ok
  88: perf stat --bpf-counters test                                   : Ok
  89: Check Arm CoreSight trace data recording and synthesized samples: Skip
  90: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ make -C tools/perf build-test
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.QpDPwOhiSH
                make_with_gtk2: make GTK2=1 -j24  DESTDIR=/tmp/tmp.rMpx3uqQea
  - /var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP: make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
            make_install_bin_O: make install-bin
         make_install_prefix_O: make install prefix=/tmp/krava
                   make_tags_O: make tags
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
           make_no_libpython_O: make NO_LIBPYTHON=1
                   make_pure_O: make
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
              make_clean_all_O: make clean all
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                make_no_newt_O: make NO_NEWT=1
           make_no_libbionic_O: make NO_LIBBIONIC=1
              make_no_libelf_O: make NO_LIBELF=1
                make_no_gtk2_O: make NO_GTK2=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
           make_with_libpfm4_O: make LIBPFM4=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
             make_no_libnuma_O: make NO_LIBNUMA=1
                    make_doc_O: make doc
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
                 make_no_sdt_O: make NO_SDT=1
               make_no_slang_O: make NO_SLANG=1
                   make_help_O: make help
                 make_perf_o_O: make perf.o
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                  make_debug_O: make DEBUG=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
             make_no_libperl_O: make NO_LIBPERL=1
             make_util_map_o_O: make util/map.o
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_with_coresight_O: make CORESIGHT=1
           make_no_backtrace_O: make NO_BACKTRACE=1
                make_install_O: make install
              make_no_libbpf_O: make NO_LIBBPF=1
            make_no_demangle_O: make NO_DEMANGLE=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  $
