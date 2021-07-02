Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-28.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B54C11F67
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F05261416
	for <linux-perf-users@archiver.kernel.org>; Fri,  2 Jul 2021 00:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhGBAD6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jul 2021 20:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234063AbhGBAD6 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jul 2021 20:03:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AA3161409;
        Fri,  2 Jul 2021 00:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625184087;
        bh=WCw4iPZtl7+OxxVsmV4NKD2w//wOS5W/PPDpFDCuBAM=;
        h=From:To:Cc:Subject:Date:From;
        b=lc18YMvS+Qjwn3HRwMKN9KL43tZQIVX0QBZmQyoX3STPrzQ00a9WRT28/bZRqB2Fl
         qne5oJoE7ajlJ7ltIkqEMeVEAMOL73g/LRiNdtgtXHd+3SKJ9QHlsCcXsDWTT+teJu
         JVjzqjf4IyN0RCAL1wS65b1E21kmeJOfhX6fFh7i04FPesgwxnxjpjTDcA/5nXWzV/
         i/EiMGOlkV44ztTOWoPn4lMhsdsGan1L33Yz6D7wMi/HIwRCvMB3YkW0Z0rC42VQk6
         8duK6Be8KxnLQcUhNtHFmZECBCaxL8I9uXAIB5Wmr9Zk/pAparBDxFQG2MN5YM4e0q
         1wHDzQfrg18yg==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Denys Zagorui <dzagorui@cisco.com>,
        Hulk Robot <hulkci@huawei.com>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joshua Martinez <joshuamart@google.com>,
        Lei Zhao <zhaolei27@baidu.com>, Leo Yan <leo.yan@linaro.org>,
        Li Huafei <lihuafei1@huawei.com>,
        Li RongQing <lirongqing@baidu.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Rob Herring <robh@kernel.org>, Song Liu <song@kernel.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        Zou Wei <zou_wei@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [GIT PULL] perf tools changes for v5.14
Date:   Thu,  1 Jul 2021 21:01:10 -0300
Message-Id: <20210702000110.1179766-1-acme@kernel.org>
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

The following changes since commit 007b350a58754a93ca9fe50c498cc27780171153:

  Merge tag 'dlm-5.14' of git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm (2021-06-29 20:30:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-tools-for-v5.14-2021-07-01

for you to fetch changes up to cf96b8e45a9bf74d2a6f1e1f88a41b10e9357c6b:

  perf session: Add missing evlist__delete when deleting a session (2021-07-01 16:14:38 -0300)

----------------------------------------------------------------
perf tools changes for v5.14:

Tools:

- Add cgroup support for 'perf top' (-G).

- Add support for KVM MSRs in 'perf kvm stat'

- Support probes on init functions in 'perf probe', to support the
  bootconfig format.

- Improve error reporting in 'perf probe'.

- No need to synthesize BUILD_ID records in 'perf inject' if the MMAP2
  records have build ids already.

- Allow toggling source code ('s' hotkey) in 'perf annotate' in all
  lines.

- Add itrace options support to 'perf annotate'.

- Support to custom DSO filters for 'perf script'.

Hardware enablement:

- Support the HYBRID_TOPOLOGY and HYBRID_CPU_PMU_CAPS features in the
  perf.data file header.

- Support PMU prefix for mem-load and mem-store events, to support
  hybrid (BIG little) CPUs such as Intel's Alderlake.

- Support hybrid CPUs in 'perf mem' and 'perf c2c'.

Hardware tracing:

- Intel PT now supports tracing KVM guests.

- Timestamp improvements for ARM's Coresight.

Build:

- Add 'make -C tools/perf build-test' entries for libopencsd/CORESIGHT=1
  and libbpf/LIBBPF_DYNAMIC=1.

- Use bison's --file-prefix-map option to avoid storing full paths when
  using O= in the perf build.

Tests:

- Improve the 'perf test' entries for libpfm4 and BPF counters.

Misc:

- Sync msr-index.h, mount.h, kvm headers with the kernel originals.

- Add vendor events and metrics for Intel's Icelake Server & Client.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

----------------------------------------------------------------
Adrian Hunter (50):
      perf auxtrace: Add Z itrace option for timeless decoding
      perf intel-pt: Move synth_opts initialization earlier
      perf intel-pt: Support Z itrace option for timeless decoding
      perf inject: Add facility to do in place update
      perf inject: Add --vm-time-correlation option
      perf auxtrace: Allow buffers to be mapped read / write
      perf intel-pt: Let overlap detection handle VM timestamps
      perf intel-pt: Add a tree for VMCS information
      perf intel-pt: Pass the first timestamp to the decoder
      perf intel-pt: Better 7-byte timestamp wraparound logic
      perf intel-pt: Add VM Time Correlation to decoder
      perf intel-pt: Parse VM Time Correlation options and set up decoding
      perf record: Set timestamp boundary for AUX area events
      perf script: Find script file relative to exec path
      perf scripting python: Fix tuple_set_u64()
      perf scripting python: Factor out set_sym_in_dict()
      perf scripting python: Add 'addr_location' for 'addr'
      perf script: Factor out perf_sample__sprintf_flags()
      perf scripting python: Add sample flags
      perf scripting python: Add IPC
      perf scripting python: Add cpumode
      perf scripting python: Add context switch
      perf scripting python: Add auxtrace error
      perf scripts python: intel-pt-events.py: Add branches to script
      perf scripting python: Remove unnecessary 'static'
      perf scripting python: Simplify perf-trace-context module functions
      perf scripting: Add scripting_context__update()
      perf scripting: Add perf_session to scripting_context
      perf scripting python: Assign perf_script_context
      perf script: Factor out script_fetch_insn()
      perf scripting python: Add perf_sample_insn()
      perf auxtrace: Factor out itrace_do_parse_synth_opts()
      perf scripting python: Add perf_set_itrace_options()
      perf scripting python: Add perf_sample_srcline() and perf_sample_srccode()
      perf scripting python: Update documentation for srcline etc
      perf scripting python: exported-sql-viewer.py: Factor out libxed.py
      perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace
      perf script: Move filter_cpu() earlier
      perf script: Move filtering before scripting
      perf script: Share addr_al between functions
      perf script: Add API for filtering via dynamically loaded shared object
      perf script: Add dlfilter__filter_event_early()
      perf script: Add option to list dlfilters
      perf script: Add option to pass arguments to dlfilters
      perf build: Install perf_dlfilter.h
      perf dlfilter: Add resolve_address() to perf_dlfilter_fns
      perf dlfilter: Add insn() to perf_dlfilter_fns
      perf dlfilter: Add srcline() to perf_dlfilter_fns
      perf dlfilter: Add attr() to perf_dlfilter_fns
      perf dlfilter: Add object_code() to perf_dlfilter_fns

Alexey Bayduraev (1):
      tools lib: Adopt bitmap_intersects() operation from the kernel sources

Arnaldo Carvalho de Melo (15):
      perf tools: Test build with libopencsd/CORESIGHT=1
      perf tools: Test build with libbpf/LIBBPF_DYNAMIC=1
      Merge remote-tracking branch 'torvalds/master' into perf/core
      perf auxtrace: Make perf_event__process_auxtrace*() callable
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Revert "perf vendor events intel: Add metrics for Icelake Server"
      Merge remote-tracking branch 'torvalds/master' into perf/core
      Merge remote-tracking branch 'torvalds/master' into perf/core
      tools arch x86: Sync the msr-index.h copy with the kernel sources
      tools include UAPI: Update linux/mount.h copy
      tools headers cpufeatures: Sync with the kernel sources
      tools headers UAPI: Sync linux/kvm.h with the kernel sources
      tools kvm headers arm64: Update KVM headers from the kernel sources
      tools headers UAPI: Synch KVM's svm.h header with the kernel
      perf llvm: Return -ENOMEM when asprintf() fails

Denys Zagorui (1):
      perf parse-events: Add bison --file-prefix-map option

Ian Rogers (4):
      perf test: Test 2 libpfm4 error cases
      perf test: Add verbose skip output for bpf counters
      perf test: Make stat bpf counters test more robust
      perf test: Pass the verbose option to shell tests

James Clark (6):
      perf cs-etm: Refactor timestamp variable names
      perf cs-etm: Set time on synthesised samples to preserve ordering
      perf cs-etm: Move synth_opts initialisation
      perf cs-etm: Start reading 'Z' --itrace option
      perf cs-etm: Prevent and warn on underflows during timestamp calculation.
      perf cs-etm: Delay decode of non-timeless data until cs_etm__flush_events()

Jin Yao (15):
      perf header: Support HYBRID_TOPOLOGY feature
      perf header: Support HYBRID_CPU_PMU_CAPS feature
      perf vendor events intel: Add core event list for Icelake Server
      perf vendor events intel: Add uncore event list for Icelake Server
      perf vendor events intel: Add metrics for Icelake Server
      perf vendor events intel: Update event list for Icelake Client
      perf tools: Check mem-loads auxiliary event
      perf tools: Support pmu prefix for mem-load event
      perf tools: Support pmu prefix for mem-store event
      perf tools: Check if mem_events is supported for hybrid platform
      perf mem: Support record for hybrid platform
      perf mem: Fix wrong verbose output for recording events
      perf mem: Disable 'mem-loads-aux' group before reporting
      perf c2c: Support record for hybrid platform
      perf evsel: Adjust hybrid event and global event mixed group

Joshua Martinez (1):
      perf top: Add cgroup support for perf top (-G)

Lei Zhao (1):
      perf x86 kvm-stat: Support to analyze kvm MSR

Leo Yan (11):
      perf arm-spe: Correct sample flags for SPE event
      perf arm-spe: Correct sample flags for dummy event
      perf arm-spe: Enable timestamp for per-cpu mode
      perf arm-spe: Remove redundant checking for "full_auxtrace"
      perf auxtrace: Change to use SMP memory barriers
      perf cs-etm: Remove callback cs_etm_find_snapshot()
      perf arm-spe: Save clock parameters from TIME_CONV event
      perf arm-spe: Convert event kernel time to counter value
      perf arm-spe: Assign kernel time to synthesized event
      perf arm-spe: Bail out if the trace is later than perf event
      perf arm-spe: Don't wait for PERF_RECORD_EXIT event

Li Huafei (1):
      perf mem-events: Remove duplicate #undef

Masami Hiramatsu (6):
      perf probe: Add permission and sysctl notice to man page
      perf probe: Report possible permission error for map__load() failure
      perf probe: Provide clearer message permission error for tracefs access
      perf probe: Support probes on init functions for offline kernel
      perf probe: Cleanup synthesize_probe_trace_command()
      perf probe: Add --bootconfig to output definition in bootconfig format

Namhyung Kim (6):
      perf stat: Use aggregated counts directly
      perf inject: Call dso__put() even if dso->hit is set
      perf inject: Do not inject BUILD_ID record if MMAP2 has it
      perf tools: Add read_cgroup_id() function
      perf tools: Add cgroup_is_v2() helper
      perf bpf_counter: Move common functions to bpf_counter.h

Ravi Bangoria (1):
      perf probe: Provide more detail with relocation warning

Riccardo Mancini (3):
      perf test: Iterate over shell tests in alphabetical order
      perf annotate: Allow 's' on source code lines
      perf session: Add missing evlist__delete when deleting a session

Rob Herring (2):
      perf tests: Consolidate test__arch_unwind_sample declaration
      perf tests: Drop __maybe_unused on x86 test declarations

Song Liu (1):
      perf build: Improve error message for old/missing clang

Yang Jihong (1):
      perf annotate: Add itrace options support

Zou Wei (1):
      perf srccode: Use list_move() instead of equivalent list_del() + list_add() sequence

 tools/arch/arm64/include/uapi/asm/kvm.h            |   11 +
 tools/arch/x86/include/asm/cpufeatures.h           |    3 +-
 tools/arch/x86/include/asm/msr-index.h             |    4 +
 tools/arch/x86/include/uapi/asm/kvm.h              |   13 +
 tools/arch/x86/include/uapi/asm/svm.h              |    3 +
 tools/include/linux/bitmap.h                       |   11 +
 tools/include/uapi/linux/kvm.h                     |  105 +
 tools/include/uapi/linux/mount.h                   |    1 +
 tools/lib/bitmap.c                                 |   14 +
 tools/perf/Documentation/itrace.txt                |    1 +
 tools/perf/Documentation/perf-annotate.txt         |    7 +
 tools/perf/Documentation/perf-dlfilter.txt         |  251 ++
 tools/perf/Documentation/perf-inject.txt           |   10 +
 tools/perf/Documentation/perf-intel-pt.txt         |  119 +-
 tools/perf/Documentation/perf-probe.txt            |   19 +-
 tools/perf/Documentation/perf-script-python.txt    |   46 +-
 tools/perf/Documentation/perf-script.txt           |   15 +-
 tools/perf/Documentation/perf-top.txt              |   12 +
 tools/perf/Documentation/perf.data-file-format.txt |   33 +
 tools/perf/Makefile.config                         |   14 +-
 tools/perf/Makefile.perf                           |    4 +-
 tools/perf/arch/arm/include/arch-tests.h           |    5 -
 tools/perf/arch/arm/util/cs-etm.c                  |  133 --
 tools/perf/arch/arm64/include/arch-tests.h         |    5 -
 tools/perf/arch/arm64/util/arm-spe.c               |   45 +-
 tools/perf/arch/arm64/util/mem-events.c            |    2 +-
 tools/perf/arch/powerpc/include/arch-tests.h       |    7 -
 tools/perf/arch/powerpc/tests/dwarf-unwind.c       |    1 -
 tools/perf/arch/powerpc/util/mem-events.c          |    2 +-
 tools/perf/arch/x86/include/arch-tests.h           |   12 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |    1 -
 tools/perf/arch/x86/util/kvm-stat.c                |   46 +
 tools/perf/arch/x86/util/mem-events.c              |   54 +-
 tools/perf/builtin-annotate.c                      |   11 +
 tools/perf/builtin-c2c.c                           |   40 +-
 tools/perf/builtin-inject.c                        |   98 +-
 tools/perf/builtin-mem.c                           |   51 +-
 tools/perf/builtin-probe.c                         |   12 +-
 tools/perf/builtin-record.c                        |   27 +-
 tools/perf/builtin-report.c                        |    2 +
 tools/perf/builtin-script.c                        |  235 +-
 tools/perf/builtin-top.c                           |    8 +
 tools/perf/pmu-events/arch/x86/icelake/cache.json  |  724 +++---
 .../arch/x86/icelake/floating-point.json           |  101 +-
 .../perf/pmu-events/arch/x86/icelake/frontend.json |  610 ++---
 .../pmu-events/arch/x86/icelake/icl-metrics.json   |  273 +++
 tools/perf/pmu-events/arch/x86/icelake/memory.json |  654 ++++--
 tools/perf/pmu-events/arch/x86/icelake/other.json  | 1089 ++++++++-
 .../perf/pmu-events/arch/x86/icelake/pipeline.json | 1169 +++++----
 .../arch/x86/icelake/virtual-memory.json           |  251 +-
 tools/perf/pmu-events/arch/x86/icelakex/cache.json |  706 ++++++
 .../arch/x86/icelakex/floating-point.json          |   95 +
 .../pmu-events/arch/x86/icelakex/frontend.json     |  469 ++++
 .../perf/pmu-events/arch/x86/icelakex/memory.json  |  291 +++
 tools/perf/pmu-events/arch/x86/icelakex/other.json |  181 ++
 .../pmu-events/arch/x86/icelakex/pipeline.json     |  972 ++++++++
 .../arch/x86/icelakex/uncore-memory.json           |  333 +++
 .../pmu-events/arch/x86/icelakex/uncore-other.json | 2476 ++++++++++++++++++++
 .../pmu-events/arch/x86/icelakex/uncore-power.json |   10 +
 .../arch/x86/icelakex/virtual-memory.json          |  245 ++
 tools/perf/pmu-events/arch/x86/mapfile.csv         |    2 +
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |  168 +-
 .../perf/scripts/python/bin/intel-pt-events-record |    4 +-
 .../perf/scripts/python/bin/intel-pt-events-report |    4 +-
 tools/perf/scripts/python/exported-sql-viewer.py   |   89 +-
 tools/perf/scripts/python/intel-pt-events.py       |  283 ++-
 tools/perf/scripts/python/libxed.py                |  107 +
 tools/perf/tests/builtin-test.c                    |   43 +-
 tools/perf/tests/dwarf-unwind.c                    |    4 -
 tools/perf/tests/make                              |    7 +
 tools/perf/tests/pfm.c                             |   10 +
 tools/perf/tests/shell/stat_bpf_counters.sh        |   16 +-
 tools/perf/tests/tests.h                           |    2 -
 tools/perf/ui/browsers/annotate.c                  |   32 +-
 tools/perf/util/Build                              |    7 +-
 tools/perf/util/arm-spe.c                          |   73 +-
 tools/perf/util/auxtrace.c                         |   18 +-
 tools/perf/util/auxtrace.h                         |   53 +-
 tools/perf/util/bpf_counter.c                      |   52 -
 tools/perf/util/bpf_counter.h                      |   52 +
 tools/perf/util/cgroup.c                           |   44 +
 tools/perf/util/cgroup.h                           |   12 +
 tools/perf/util/cputopo.c                          |   80 +
 tools/perf/util/cputopo.h                          |   13 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |   61 +-
 tools/perf/util/cs-etm.c                           |   83 +-
 tools/perf/util/cs-etm.h                           |    4 +-
 tools/perf/util/data.c                             |    3 +-
 tools/perf/util/data.h                             |    1 +
 tools/perf/util/db-export.c                        |   12 +-
 tools/perf/util/db-export.h                        |    2 +-
 tools/perf/util/dlfilter.c                         |  615 +++++
 tools/perf/util/dlfilter.h                         |   97 +
 tools/perf/util/env.c                              |   12 +
 tools/perf/util/env.h                              |   16 +
 tools/perf/util/evlist.c                           |   25 +
 tools/perf/util/evlist.h                           |    1 +
 tools/perf/util/evsel.c                            |   25 +
 tools/perf/util/header.c                           |  254 +-
 tools/perf/util/header.h                           |    2 +
 .../perf/util/intel-pt-decoder/intel-pt-decoder.c  |  723 +++++-
 .../perf/util/intel-pt-decoder/intel-pt-decoder.h  |   20 +-
 tools/perf/util/intel-pt-decoder/intel-pt-log.h    |    5 +
 tools/perf/util/intel-pt.c                         |  224 +-
 tools/perf/util/llvm-utils.c                       |    2 +
 tools/perf/util/mem-events.c                       |  103 +-
 tools/perf/util/mem-events.h                       |    4 +-
 tools/perf/util/perf_dlfilter.h                    |  150 ++
 tools/perf/util/pmu-hybrid.h                       |   11 +
 tools/perf/util/probe-event.c                      |  203 +-
 tools/perf/util/probe-event.h                      |    2 +
 tools/perf/util/probe-file.c                       |   95 +-
 .../perf/util/scripting-engines/trace-event-perl.c |   13 +-
 .../util/scripting-engines/trace-event-python.c    |  359 ++-
 tools/perf/util/session.c                          |   11 +-
 tools/perf/util/srccode.c                          |    3 +-
 tools/perf/util/stat-display.c                     |    8 +-
 tools/perf/util/stat.c                             |   12 -
 tools/perf/util/trace-event-scripting.c            |   32 +-
 tools/perf/util/trace-event.h                      |   29 +-
 120 files changed, 14120 insertions(+), 2419 deletions(-)
 create mode 100644 tools/perf/Documentation/perf-dlfilter.txt
 create mode 100644 tools/perf/pmu-events/arch/x86/icelake/icl-metrics.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/frontend.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-other.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/uncore-power.json
 create mode 100644 tools/perf/pmu-events/arch/x86/icelakex/virtual-memory.json
 create mode 100644 tools/perf/scripts/python/libxed.py
 create mode 100644 tools/perf/util/dlfilter.c
 create mode 100644 tools/perf/util/dlfilter.h
 create mode 100644 tools/perf/util/perf_dlfilter.h

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

  # export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0.tar.xz
  # dm 
   1 almalinux:8                   : Ok   gcc (GCC) 8.4.1 20200928 (Red Hat 8.4.1-1) , clang version 11.0.0 (Red Hat 11.0.0-1.module_el8.4.0+2107+39fed697)
   2 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0 , clang version 3.8.0 (tags/RELEASE_380/final)
   3 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822 , clang version 3.8.1 (tags/RELEASE_381/final)
   4 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0 , clang version 4.0.0 (tags/RELEASE_400/final)
   5 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   6 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0 , Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   7 alpine:3.9                    : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
   8 alpine:3.10                   : Ok   gcc (Alpine 8.3.0) 8.3.0 , Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
   9 alpine:3.11                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
  10 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0 , Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  11 alpine:3.13                   : Ok   gcc (Alpine 10.2.1_pre1) 10.2.1 20201203 , Alpine clang version 10.0.1 
  12 alpine:edge                   : Ok   gcc (Alpine 10.3.1_git20210424) 10.3.1 20210424 , Alpine clang version 11.1.0
  13 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1) , clang version 3.8.0 (tags/RELEASE_380/final)
  14 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1) , clang version 10.0.0 
  15 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20210313 (ALT Sisyphus 10.2.1-alt3) , clang version 10.0.1 
  16 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2) , clang version 3.6.2 (tags/RELEASE_362/final)
  17 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-13) , clang version 11.1.0 (Amazon Linux 2 11.1.0-1.amzn2.0.2)
  18 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5) , clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  19 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 11.1.1 20210624 releases/gcc-11.1.0-356-gf19b20de1b , clang version 11.1.0
  20 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2 , Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)
  21 debian:9                      : Ok   gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516 , clang version 3.8.1-24 (tags/RELEASE_381/final)
  22 debian:10                     : Ok   gcc (Debian 8.3.0-6) 8.3.0 , clang version 7.0.1-8+deb10u2 (tags/RELEASE_701/final)
  23 debian:experimental           : Ok   gcc (Debian 10.2.1-6) 10.2.1 20210110 , Debian clang version 11.0.1-2
  24 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  25 debian:experimental-x-mips    : Ok   mips-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  26 debian:experimental-x-mips64  : Ok   mips64-linux-gnuabi64-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  27 debian:experimental-x-mipsel  : Ok   mipsel-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110 
  28 fedora:22                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.5.0 (tags/RELEASE_350/final)
  29 fedora:23                     : Ok   gcc (GCC) 5.3.1 20160406 (Red Hat 5.3.1-6) , clang version 3.7.0 (tags/RELEASE_370/final)
  30 fedora:24                     : Ok   gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1) , clang version 3.8.1 (tags/RELEASE_381/final)
  31 fedora:24-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCompact ISA Linux uClibc toolchain 2017.09-rc2) 7.1.1 20170710 
  32 fedora:25                     : Ok   gcc (GCC) 6.4.1 20170727 (Red Hat 6.4.1-1) , clang version 3.9.1 (tags/RELEASE_391/final)
  33 fedora:26                     : Ok   gcc (GCC) 7.3.1 20180130 (Red Hat 7.3.1-2) , clang version 4.0.1 (tags/RELEASE_401/final)
  34 fedora:27                     : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-6) , clang version 5.0.2 (tags/RELEASE_502/final)
  35 fedora:28                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 6.0.1 (tags/RELEASE_601/final)
  36 fedora:29                     : Ok   gcc (GCC) 8.3.1 20190223 (Red Hat 8.3.1-2) , clang version 7.0.1 (Fedora 7.0.1-6.fc29)
  37 fedora:30                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 8.0.0 (Fedora 8.0.0-3.fc30)
  38 fedora:31                     : Ok   gcc (GCC) 9.3.1 20200408 (Red Hat 9.3.1-2) , clang version 9.0.1 (Fedora 9.0.1-4.fc31)
  39 fedora:32                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 10.0.1 (Fedora 10.0.1-3.fc32)
  40 fedora:33                     : Ok   gcc (GCC) 10.3.1 20210422 (Red Hat 10.3.1-1) , clang version 11.0.0 (Fedora 11.0.0-3.fc33)
  41 fedora:34                     : Ok   gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3) , clang version 12.0.0 (Fedora 12.0.0-2.fc34)
  42 fedora:34-x-ARC-glibc         : Ok   arc-linux-gcc (ARC HS GNU/Linux glibc toolchain 2019.03-rc1) 8.3.1 20190225 
  43 fedora:34-x-ARC-uClibc        : Ok   arc-linux-gcc (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1) 8.3.1 20190225 
  44 fedora:rawhide                : Ok   gcc (GCC) 11.1.1 20210623 (Red Hat 11.1.1-6) , clang version 12.0.1 (Fedora 12.0.1~rc1-3.fc35)
  45 gentoo-stage3:latest          : Ok   gcc (Gentoo 10.3.0 p1) 10.3.0 
  46 mageia:6                      : Ok   gcc (Mageia 5.5.0-1.mga6) 5.5.0 , clang version 3.9.1 (tags/RELEASE_391/final)
  47 mageia:7                      : FAIL clang version 8.0.0 (Mageia 8.0.0-1.mga7)

          yychar = yylex (&yylval, &yylloc, scanner);
                   ^
    #define yylex           parse_events_lex
                            ^
    1 error generated.
    make[3]: *** [/git/perf-5.13.0/tools/build/Makefile.build:139: util] Error 2

  48 openmandriva:cooker           : Ok   gcc (GCC) 11.1.0 20210427 (OpenMandriva) , OpenMandriva 12.0.0-1 clang version 12.0.0 (/builddir/build/BUILD/llvm-project-llvmorg-12.0.0/clang b3a1e025e0452bb54d01ab5281bbf509ac4e3c72)
  49 opensuse:15.0                 : Ok   gcc (SUSE Linux) 7.4.1 20190905 [gcc-7-branch revision 275407] , clang version 5.0.1 (tags/RELEASE_501/final 312548)
  50 opensuse:15.1                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 7.0.1 (tags/RELEASE_701/final 349238)
  51 opensuse:15.2                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 9.0.1 
  52 opensuse:15.3                 : Ok   gcc (SUSE Linux) 7.5.0 , clang version 11.0.1
  53 opensuse:tumbleweed           : Ok   gcc (SUSE Linux) 11.1.1 20210510 [revision 23855a176609fe8dda6abaf2b21846b4517966eb] , clang version 12.0.0
  54 oraclelinux:8                 : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5.0.2) , clang version 10.0.1 (Red Hat 10.0.1-1.0.1.module+el8.3.0+7827+89335dbf)
  55 ubuntu:16.04                  : Ok   gcc (Ubuntu 5.4.0-6ubuntu1~16.04.12) 5.4.0 20160609 , clang version 3.8.0-2ubuntu4 (tags/RELEASE_380/final)
  56 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  57 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  58 ubuntu:16.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  59 ubuntu:16.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  60 ubuntu:16.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu/IBM 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  61 ubuntu:16.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609 
  62 ubuntu:18.04                  : Ok   gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 , clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)
  63 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  64 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 7.5.0 
  65 ubuntu:18.04-x-m68k           : Ok   m68k-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  66 ubuntu:18.04-x-powerpc        : Ok   powerpc-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  67 ubuntu:18.04-x-powerpc64      : Ok   powerpc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  68 ubuntu:18.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  69 ubuntu:18.04-x-riscv64        : Ok   riscv64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  70 ubuntu:18.04-x-s390           : Ok   s390x-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  71 ubuntu:18.04-x-sh4            : Ok   sh4-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  72 ubuntu:18.04-x-sparc64        : Ok   sparc64-linux-gnu-gcc (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0 
  73 ubuntu:20.04                  : Ok   gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0 , clang version 10.0.0-4ubuntu1 
  74 ubuntu:20.04-x-powerpc64el    : Ok   powerpc64le-linux-gnu-gcc (Ubuntu 10.2.0-5ubuntu1~20.04) 10.2.0 
  75 ubuntu:20.10                  : Ok   gcc (Ubuntu 10.2.0-13ubuntu1) 10.2.0 , Ubuntu clang version 11.0.0-2
  76 ubuntu:21.04                  : Ok   gcc (Ubuntu 10.3.0-1ubuntu1) 10.3.0 , Ubuntu clang version 12.0.0-1ubuntu1

  # cd ~acme/git/perf
  # git log --oneline -1
  cf96b8e45a9b (HEAD -> perf/core, five/perf/core, acme.korg/tmp.perf/core) perf session: Add missing evlist__delete when deleting a session
  # uname -a
  Linux quaco 5.12.5-200.fc33.x86_64 #1 SMP Wed May 19 18:06:33 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
  # perf -vv
  perf version 5.13.gcf96b8e45a9b
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
  72: x86 rdpmc                                                       : Ok
  73: DWARF unwind                                                    : Ok
  74: x86 instruction decoder - new instructions                      : Ok
  75: Intel PT packet decoder                                         : Ok
  76: x86 bp modify                                                   : Ok
  77: x86 Sample parsing                                              : Ok
  78: build id cache operations                                       : Ok
  79: daemon operations                                               : Ok
  80: Add vfs_getname probe to get syscall args filenames             : Ok
  81: probe libc's inet_pton & backtrace it with ping                 : Ok
  82: Use vfs_getname probe to get syscall args filenames             : Ok
  83: Zstd perf.data compression/decompression                        : Ok
  84: perf stat csv summary test                                      : Ok
  85: perf stat metrics (shadow stat) test                            : Ok
  86: perf stat --bpf-counters test                                   : Ok
  87: Check Arm CoreSight trace data recording and synthesized samples: Skip
  88: Check open filename arg using perf trace + vfs_getname          : Ok
  #

  $ git log --oneline -1
  cf96b8e45a9bf74d (HEAD -> perf/core) perf session: Add missing evlist__delete when deleting a session
  $ time make -C tools/perf build-test
  make: Entering directory '/var/home/acme/git/perf/tools/perf'
  - tarpkg: ./tests/perf-targz-src-pkg .
                   make_static: make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 -j24  DESTDIR=/tmp/tmp.pTyCyQvfo4
                make_with_gtk2: make GTK2=1 -j24  DESTDIR=/tmp/tmp.4YodIv6c6D
  make FEATURE_DUMP_COPY=/var/home/acme/git/perf/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
                make_minimal_O: make NO_LIBPERL=1 NO_LIBPYTHON=1 NO_NEWT=1 NO_GTK2=1 NO_DEMANGLE=1 NO_LIBELF=1 NO_LIBUNWIND=1 NO_BACKTRACE=1 NO_LIBNUMA=1 NO_LIBAUDIT=1 NO_LIBBIONIC=1 NO_LIBDW_DWARF_UNWIND=1 NO_AUXTRACE=1 NO_LIBBPF=1 NO_LIBCRYPTO=1 NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1 NO_LIBCAP=1 NO_SYSCALL_TABLE=1
            make_no_libaudit_O: make NO_LIBAUDIT=1
             make_util_map_o_O: make util/map.o
             make_no_libnuma_O: make NO_LIBNUMA=1
         make_no_syscall_tbl_O: make NO_SYSCALL_TABLE=1
                   make_help_O: make help
              make_no_libelf_O: make NO_LIBELF=1
        make_with_babeltrace_O: make LIBBABELTRACE=1
           make_no_backtrace_O: make NO_BACKTRACE=1
              make_clean_all_O: make clean all
  make_no_libdw_dwarf_unwind_O: make NO_LIBDW_DWARF_UNWIND=1
           make_no_libunwind_O: make NO_LIBUNWIND=1
              make_no_libbpf_O: make NO_LIBBPF=1
                  make_debug_O: make DEBUG=1
             make_no_scripts_O: make NO_LIBPYTHON=1 NO_LIBPERL=1
   make_install_prefix_slash_O: make install prefix=/tmp/krava/
           make_no_libbionic_O: make NO_LIBBIONIC=1
           make_with_libpfm4_O: make LIBPFM4=1
            make_install_bin_O: make install-bin
                 make_perf_o_O: make perf.o
            make_no_demangle_O: make NO_DEMANGLE=1
               make_no_slang_O: make NO_SLANG=1
                make_install_O: make install
         make_with_coresight_O: make CORESIGHT=1
         make_libbpf_dynamic_O: make LIBBPF_DYNAMIC=1
                    make_doc_O: make doc
        make_no_libbpf_DEBUG_O: make NO_LIBBPF=1 DEBUG=1
       make_util_pmu_bison_o_O: make util/pmu-bison.o
                make_no_gtk2_O: make NO_GTK2=1
                 make_no_sdt_O: make NO_SDT=1
           make_no_libcrypto_O: make NO_LIBCRYPTO=1
            make_no_auxtrace_O: make NO_AUXTRACE=1
                   make_tags_O: make tags
                  make_no_ui_O: make NO_NEWT=1 NO_SLANG=1 NO_GTK2=1
         make_install_prefix_O: make install prefix=/tmp/krava
         make_with_clangllvm_O: make LIBCLANGLLVM=1
                make_no_newt_O: make NO_NEWT=1
             make_no_libperl_O: make NO_LIBPERL=1
                   make_pure_O: make
           make_no_libpython_O: make NO_LIBPYTHON=1
  OK
  make: Leaving directory '/var/home/acme/git/perf/tools/perf'
  $
