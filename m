Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3442B13CFA6;
	Mon, 25 Nov 2024 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519018; cv=none; b=ixI0iMZYHpKREimQpm+rZZe/arjz08KUT51V71LoGj9uTfaK26ibM9+0ZwUdPRqMqB5UN2VJN6wapRcCzRUqnZv2bzOCfIAgLyMP1HXsKRV2pcvqoqTcjlCYJdlDH0YoBj2GKBtzC+e3kO+7cKsQMDBZH3iujE+el9oKaxMj88k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519018; c=relaxed/simple;
	bh=vysisZKYHPEkxK0aTfxomoJDP8rORtZ+xMjPNDijLfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JiXGI7ICeOYEpeAgpxFsHldhbtDWk5+JYa269t4IAXWpcTYVy+6g6OM+acdSyUHbzklwJBlSCwFmUroQobkp96kIvUHbX+PiwcebrVrz6ZapMpnhGqyrhQlz6k9GnhUO07NDqe65yC/5m1ugMzPHm6s/elQlYRtUrNMdrfzOYuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XatKle9I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XatKle9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800EDC4CECE;
	Mon, 25 Nov 2024 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732519016;
	bh=vysisZKYHPEkxK0aTfxomoJDP8rORtZ+xMjPNDijLfQ=;
	h=From:To:Cc:Subject:Date:From;
	b=XatKle9In0plPdn+GpWUapNPQBni01i1xeKecv1Pu5xlGwlg9hvaJEEDQU3dSZquY
	 d8VuOfUynMdyrJYHLA1vl9OizHM7q7HC9dz75sB7fANCsi41KK4ealarmapEcLnBt+
	 aJAJtnsi/WjlFlNO7eHFqa/OLd2B5b0IPP7uJzcCYhNklIp7y8IjLoEcsnxNF8e41n
	 KLj8oZxl7LEZjgOczJNxM6lMLVah0N/oS6EecJh1KgMpa3dLVK6X0Vl7UbgyYt0I/L
	 iRcVidpgjwBihC6FowyjybDzUuTqZv+hmGnfJgFJyEouWtiXCC/nNh5ce54GH6Ky/d
	 Cqy46+8+yBxRw==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools changes for v6.13
Date: Sun, 24 Nov 2024 23:16:53 -0800
Message-ID: <20241125071653.1350621-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.13.

Thanks,
Namhyung


The following changes since commit 59b723cd2adbac2a34fc8e12c74ae26ae45bf230:

  Linux 6.12-rc6 (2024-11-03 14:05:52 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v6.13-2024-11-24

for you to fetch changes up to 6d78089da9805787a72e52604ad4b2ed7380be3f:

  perf tests: Fix hwmon parsing with PMU name test (2024-11-22 13:38:39 -0800)

----------------------------------------------------------------
perf tools changes for v6.13

perf record
-----------
* Enable leader sampling for inherited task events.  It was supported
  only for system-wide events but the kernel started to support such a
  setup since v6.12.

  This is to reduce the number of PMU interrupts.  The samples of the
  leader event will contain counts of other events and no samples will
  be generated for the other member events.

    $ perf record -e '{cycles,instructions}:S'  ${MYPROG}

perf report
-----------
* Fix --branch-history option to display more branch-related information
  like prediction, abort and cycles which is available on Intel machines.

    $ perf record -bg -- perf test -w brstack

    $ perf report --branch-history
    ...
    #
    # Overhead  Source:Line               Symbol          Shared Object         Predicted  Abort  Cycles  IPC   [IPC Coverage]
    # ........  ........................  ..............  ....................  .........  .....  ......  ....................
    #
         8.17%  copy_page_64.S:19         [k] copy_page   [kernel.kallsyms]     50.0%      0      5       -      -
                |
                ---xas_load xarray.h:171
                   |
                   |--5.68%--xas_load xarray.c:245 (cycles:1)
                   |          xas_load xarray.c:242
                   |          xas_load xarray.h:1260 (cycles:1)
                   |          xas_descend xarray.c:146
                   |          xas_load xarray.c:244 (cycles:2)
                   |          xas_load xarray.c:245
                   |          xas_descend xarray.c:218 (cycles:10)
    ...

perf stat
---------
* Add HWMON PMU support.  The HWMON provides various system information
  like CPU/GPU temperature, fan speed and so on.  Expose them as PMU
  events so that users can see the values using perf stat commands.

    $ perf stat -e temp_cpu,fan1 true

     Performance counter stats for 'true':

                 60.00 'C   temp_cpu
                     0 rpm  fan1

           0.000745382 seconds time elapsed

           0.000883000 seconds user
           0.000000000 seconds sys

* Display metric threshold in JSON output.  Some metrics define
  thresholds to classify value ranges.  It used to be in a different
  color but it won't work for JSON.  Add "metric-threshold" field to
  the JSON that can be one of "good", "less good", "nearly bad" and
  "bad".

    # perf stat -a -M TopdownL1 -j true
    {"counter-value" : "18693525.000000", "unit" : "", "event" : "TOPDOWN.SLOTS", "event-runtime" : 5552708, "pcnt-running" : 100.00, "metric-value" : "43.226002", "metric-unit" : "%  tma_backend_bound", "metric-threshold" : "bad"}
    {"metric-value" : "29.212267", "metric-unit" : "%  tma_frontend_bound", "metric-threshold" : "bad"}
    {"metric-value" : "7.138972", "metric-unit" : "%  tma_bad_speculation", "metric-threshold" : "good"}
    {"metric-value" : "20.422759", "metric-unit" : "%  tma_retiring", "metric-threshold" : "good"}
    {"counter-value" : "3817732.000000", "unit" : "", "event" : "topdown-retiring", "event-runtime" : 5552708, "pcnt-running" : 100.00, }
    {"counter-value" : "5472824.000000", "unit" : "", "event" : "topdown-fe-bound", "event-runtime" : 5552708, "pcnt-running" : 100.00, }
    {"counter-value" : "7984780.000000", "unit" : "", "event" : "topdown-be-bound", "event-runtime" : 5552708, "pcnt-running" : 100.00, }
    {"counter-value" : "1418181.000000", "unit" : "", "event" : "topdown-bad-spec", "event-runtime" : 5552708, "pcnt-running" : 100.00, }
    ...

perf sched
----------
* Add -P/--pre-migrations option for 'timehist' sub-command to track
  time a task waited on a run-queue before migrating to a different CPU.

    $ perf sched timehist -P
               time    cpu  task name                       wait time  sch delay   run time  pre-mig time
                            [tid/pid]                          (msec)     (msec)     (msec)     (msec)
    --------------- ------  ------------------------------  ---------  ---------  ---------  ---------
      585940.535527 [0000]  perf[584885]                        0.000      0.000      0.000      0.000
      585940.535535 [0000]  migration/0[20]                     0.000      0.002      0.008      0.000
      585940.535559 [0001]  perf[584885]                        0.000      0.000      0.000      0.000
      585940.535563 [0001]  migration/1[25]                     0.000      0.001      0.004      0.000
      585940.535678 [0002]  perf[584885]                        0.000      0.000      0.000      0.000
      585940.535686 [0002]  migration/2[31]                     0.000      0.002      0.008      0.000
      585940.535905 [0001]  <idle>                              0.000      0.000      0.342      0.000
      585940.535938 [0003]  perf[584885]                        0.000      0.000      0.000      0.000
      585940.537048 [0001]  sleep[584886]                       0.000      0.019      1.142      0.001
      585940.537749 [0002]  <idle>                              0.000      0.000      2.062      0.000
    ...

Build
-----
* Make libunwind opt-in (LIBUNWIND=1) rather than opt-out.  The perf
  tools are generally built with libelf and libdw which has unwinder
  functionality.  The libunwind support predates it and no need to
  have duplicate unwinders by default.

* Rename NO_DWARF=1 build option to NO_LIBDW=1 in order to clarify it's
  using libdw for handling DWARF information.

Internals
---------
* Do not set exclude_guest bit in the perf_event_attr by default.  This
  was causing a trouble in AMD IBS PMU as it doesn't support the bit.
  The bit will be set when it's needed later by the fallback logic.
  Also update the missing feature detection logic to make sure not clear
  supported bits unnecessarily.

* Run perf test in parallel by default and mark flaky tests "exclusive"
  to run them serially at the end.  Some test numbers are changed but
  the test can complete in less than half the time.

JSON vendor events
------------------
* Add AMD Zen 5 events and metrics.

* Add i.MX91 and i.MX95 DDR metrics

* Fix HiSilicon HIP08 Topdown metric name.

* Support compat events on PowerPC.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Akihiko Odaki (1):
      libperf: Explicitly specify install-html dependencies

Andrew Kreimer (1):
      perf tools: Fix typos Muliplier -> Multiplier

Arnaldo Carvalho de Melo (12):
      perf test: Introduce workloads__for_each()
      perf test: Introduce --list-workloads to list the available workloads
      perf test: Document the -w/--workload option
      perf probe: Fix retrieval of source files from a debuginfod server
      perf ftrace latency: Fix unit on histogram first entry when using --use-nsec
      perf test: Remove dangling CFLAGS for removed attr.o object
      perf disasm: Introduce symbol__disassemble_objdump()
      perf disasm: Define stubs for the LLVM and capstone disassemblers
      perf disasm: Allow configuring what disassemblers to use
      perf test shell trace_exit_race: Show what went wrong in verbose mode
      perf test shell trace_exit_race: Use --no-comm to avoid cases where COMM isn't resolved
      perf tests hwmon_pmu: Remove double evlist__delete()

Athira Rajeev (4):
      tools/perf/tests: Fix compilation error with strncpy in tests/tool_pmu
      tools/perf/tests: Remove duplicate evlist__delete in tests/tool_pmu.c
      tools/perf/pmu-events/powerpc: Add support for compat events in json
      tools/perf/powerpc/util: Add support to handle compatible mode PVR for perf json events

Ben Gainey (2):
      tools/perf: Correctly calculate sample period for inherited SAMPLE_READ values
      tools/perf: Allow inherit + PERF_SAMPLE_READ when opening events

Benjamin Peterson (4):
      perf trace: avoid garbage when not printing a trace event's arguments
      perf trace: Do not lose last events in a race
      perf trace: Avoid garbage when not printing a syscall's arguments
      perf tests: Add test for trace output loss

Besar Wicaksono (1):
      perf arm-spe: Add Neoverse-V2 to common data source encoding list

Björn Töpel (1):
      perf, riscv: Wire up perf trace support for RISC-V

Brian Geffon (1):
      perf tools: sched-pipe bench: add (-n) nonblocking benchmark

Charlie Jenkins (1):
      perf tools: Add all shellcheck_log to gitignore

Dapeng Mi (8):
      perf x86/topdown: Complete topdown slots/metrics events check
      perf x86/topdown: Correct leader selection with sample_read enabled
      perf x86/topdown: Don't move topdown metric events in group
      perf tests: Add leader sampling test in record tests
      perf tests: Add topdown events counting and sampling tests
      perf tests: Add more topdown events regroup tests
      perf x86/topdown: Make topdown metrics comparators be symmetric
      perf x86/topdown: Refine helper arch_is_topdown_metrics()

Dr. David Alan Gilbert (5):
      perf probe: Remove unused add_perf_probe_events
      perf tools: Remove unused color_fwrite_lines
      perf: event: Remove deadcode
      perf util: Remove kernel version deadcode
      perf: Remove unused del_perf_probe_events()

Graham Woodward (4):
      perf arm-spe: Set sample.addr to target address for instruction sample
      perf arm-spe: Use ARM_SPE_OP_BRANCH_ERET when synthesizing branches
      perf arm-spe: Correctly set sample flags
      perf arm-spe: Update --itrace help text

Haiyue Wang (1):
      perf tools: Add the empty-pmu-events build to .gitignore

Hao Ge (1):
      perf bpf-filter: Return -ENOMEM directly when pfi allocation fails

Howard Chu (2):
      perf test: Delete unused Intel CQM test
      perf trace: Fix tracing itself, creating feedback loops

Ian Rogers (96):
      perf test: Be more tolerant of metricgroup failures
      perf test: Ignore security failures in all PMU test
      perf evsel: Add alternate_hw_config and use in evsel__match
      perf stat: Uniquify event name improvements
      perf stat: Remove evlist__add_default_attrs use strings
      perf evsel x86: Make evsel__has_perf_metrics work for legacy events
      perf evsel: Remove pmu_name
      perf evsel: Reduce a variables scope
      perf stat: Fix affinity memory leaks on error path
      perf test: Fix memory leaks on event-times error paths
      perf test: Skip not fail tp fields test when insufficient permissions
      perf test: Skip not fail syscall tp fields test when insufficient permissions
      perf pmu: Simplify an asprintf error message
      perf pmu: Allow hardcoded terms to be applied to attributes
      perf parse-events: Expose/rename config_term_name
      perf tool_pmu: Factor tool events into their own PMU
      perf tool_pmu: Rename enum perf_tool_event to tool_pmu_event
      perf tool_pmu: Rename perf_tool_event__* to tool_pmu__*
      perf tool_pmu: Move expr literals to tool_pmu
      perf jevents: Add tool event json under a common architecture
      perf tool_pmu: Switch to standard pmu functions and json descriptions
      perf tests: Add tool PMU test
      perf tool_pmu: Remove duplicate io.h header
      perf disasm: Fix capstone memory leak
      perf probe: Fix libdw memory leak
      perf color: Add printf format checking and resolve issues
      perf stat: Fix/add parameter names for print_metric
      perf stat: Display "none" for NaN with metric only json
      perf stat: Drop metric-unit if unit is NULL
      perf stat: Change color to threshold in print_metric
      perf stat: Add metric-threshold to json output
      perf stat: Disable metric thresholds for CSV and JSON metric-only mode
      perf test: Add a shell wrapper for "Setup struct perf_event_attr"
      perf test: Remove C test wrapper for attr.py
      perf test: Move attr files into shell directory where they are used
      perf build: Fix LIBDW_DIR
      perf build: Rename NO_DWARF to NO_LIBDW
      perf build: Remove defined but never used variable
      perf build: Rename test-dwarf to test-libdw
      perf build: Combine libdw-dwarf-unwind into libdw feature tests
      perf build: Combine test-dwarf-getlocations into test-libdw
      perf build: Combine test-dwarf-getcfi into test-libdw
      perf probe: Move elfutils support check to libdw check
      perf libdw: Remove unnecessary defines
      perf build: Rename HAVE_DWARF_SUPPORT to HAVE_LIBDW_SUPPORT
      perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
      tools subcmd: Add non-waitpid check_if_command_finished()
      perf test: Display number of active running tests
      perf test: Reduce scope of parallel variable
      perf test: Avoid list test blocking on writing to stdout
      perf test: Tag parallel failing shell tests with "(exclusive)"
      perf test: Add a signal handler around running a test
      perf test: Run parallel tests in two passes
      perf test: Make parallel testing the default
      perf test: Add a signal handler to kill forked child processes
      perf test: Sort tests placing exclusive tests last
      perf build: Make libunwind opt-in rather than opt-out
      perf stat: Expand metric+unit buffer size
      tools api io: Ensure line_len_out is always initialized
      perf hwmon_pmu: Add hwmon filename parser
      perf test: Add hwmon filename parser test
      perf hwmon_pmu: Add a tool PMU exposing events from hwmon in sysfs
      perf pmu: Add calls enabling the hwmon_pmu
      perf test: Add hwmon "PMU" test
      perf docs: Document tool and hwmon events
      perf bpf-prologue: Remove unused file
      perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
      perf dwarf-regs: Add EM_HOST and EF_HOST defines
      perf disasm: Add e_machine/e_flags to struct arch
      perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
      perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
      perf dwarf-regs: Move x86 dwarf-regs out of arch
      perf arm64: Remove dwarf-regs.c
      perf arm: Remove dwarf-regs.c
      perf dwarf-regs: Move csky dwarf-regs out of arch
      perf loongarch: Remove dwarf-regs.c
      perf mips: Remove dwarf-regs.c
      perf dwarf-regs: Move powerpc dwarf-regs out of arch
      perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
      perf s390: Remove dwarf-regs.c
      perf sh: Remove dwarf-regs.c
      perf sparc: Remove dwarf-regs.c
      perf xtensa: Remove dwarf-regs.c
      perf dwarf-regs: Remove get_arch_regstr code
      perf build: Remove PERF_HAVE_DWARF_REGS
      perf test: Add missing __exit calls in tool/hwmon tests
      perf header: Move is_cpu_online to numa bench
      perf header: Refactor get_cpuid to take a CPU for ARM
      perf arm64 header: Use cpu argument in get_cpuid
      perf header: Avoid transitive PMU includes
      perf header: Pass a perf_cpu rather than a PMU to get_cpuid_str
      perf jevents: Add map_for_cpu()
      perf pmu: Move pmu_metrics_table__find and remove ARM override
      perf test: Correct hwmon test PMU detection
      perf hwmon_pmu: Ensure hwmon key union is zeroed before use
      perf tests: Fix hwmon parsing with PMU name test

James Clark (11):
      perf cs-etm: Don't flush when packet_queue fills up
      perf cs-etm: Use new OpenCSD consistency checks
      perf scripting python: Add function to get a config value
      perf scripts python cs-etm: Update to use argparse
      perf scripts python cs-etm: Improve arguments
      perf scripts python cs-etm: Add start and stop arguments
      perf test: cs-etm: Test Coresight disassembly script
      perf test: Make stat test work on DT devices
      perf test: Add a test for default perf stat command
      perf arm-spe: Use old behavior when opening old SPE files
      perf tests: Make leader sampling test work without branch event

Jean-Philippe Romain (1):
      perf list: Fix topic and pmu_name argument order

Jiapeng Chong (1):
      perf test: Use ARRAY_SIZE for array length

Kan Liang (1):
      perf jevents: Don't stop at the first matched pmu when searching a events table

Leo Yan (15):
      perf arm-spe: Define metadata header version 2
      perf arm-spe: Calculate meta data size
      perf arm-spe: Save per CPU information in metadata
      perf arm-spe: Support metadata version 2
      perf arm-spe: Dump metadata with version 2
      perf arm-spe: Rename arm_spe__synth_data_source_generic()
      perf arm-spe: Rename the common data source encoding
      perf arm-spe: Introduce arm_spe__is_homogeneous()
      perf arm-spe: Use metadata to decide the data source feature
      perf arm-spe: Remove the unused 'midr' field
      perf arm-spe: Add Cortex CPUs to common data source encoding list
      perf probe: Use the MAX_EVENT_NAME_LEN macro
      perf probe: Check group string length
      perf probe: Improve log for long event name failure
      perf probe: Correct demangled symbols in C++ program

Levi Yun (2):
      perf stat: Close cork_fd when create_perf_stat_counter() failed
      perf stat: Stop repeating when ref_perf_stat() returns -1

Li Huafei (3):
      perf disasm: Use disasm_line__free() to properly free disasm_line
      perf disasm: Use disasm_line__free() to properly free disasm_line
      perf disasm: Fix not cleaning up disasm_line in symbol__disassemble_raw()

Luo Yifan (2):
      perf timechart: Remove redundant variable assignment
      libsubcmd: Move va_end() before exit

Madadi Vineeth Reddy (2):
      perf sched replay: Remove unused parts of the code
      perf sched timehist: Add pre-migration wait time option

Masami Hiramatsu (Google) (5):
      perf probe: Fix error message for failing to find line range
      perf probe: Fix to ignore escaped characters in --lines option
      perf probe: Accept FUNC@* to specify function name explicitly
      perf string: Add strpbrk_esq() and strdup_esq() for escape and quote
      perf probe: Introduce quotation marks support

Masum Reza (1):
      perf evsel: display dmesg command of showing a hardcoded path

Michael Petlan (2):
      perf trace: Keep exited threads for summary
      perf test: Remove cpu-list BPF cgroup counter test

Namhyung Kim (19):
      perf symbol: Do not fixup end address of labels
      perf tools: Fix compiler error in util/tool_pmu.c
      Merge tag 'v6.12-rc3' into perf-tools-next
      perf tools: Fix possible compiler warnings in hashmap
      perf tools: Remove unnecessary parentheses
      perf evsel: Fix missing inherit + sample read check
      perf test: Speed up some tests using perf list
      perf test: Update all metrics test like metricgroups test
      perf tools: Add fallback for exclude_guest
      perf tools: Don't set attr.exclude_guest by default
      perf tools: Simplify evsel__add_modifier()
      perf tools: Do not set exclude_guest for precise_ip
      perf tools: Detect missing kernel features properly
      perf tools: Move x86__is_amd_cpu() to util/env.c
      perf tools: Check fallback error and order
      perf record: Just use "cycles:P" as the default event
      perf test: Add precise_max subtest to the perf record shell test
      Merge 'origin/master' into perf-tools-next
      perf test: Fix ftrace test with regex patterns

Sandipan Das (3):
      perf vendor events amd: Add Zen 5 data fabric events
      perf vendor events amd: Add Zen 5 data fabric metrics
      perf vendor events amd: Update Zen 5 data cache fill events

Steve Clevenger (2):
      perf script cs_etm: Add map_pgoff to python dictionary
      perf script python: Adjust objdump start/end per map pgoff parameter

Tengda Wu (2):
      perf stat: Support inherit events during fork() for bperf
      perf test: Use sqrtloop workload to test bperf event

Thomas Falcon (3):
      perf mem: Fix printing PERF_MEM_LVLNUM_{L2_MHB|MSC}
      perf test x86: Fix typo in intel-pt-test
      perf report: Display columns Predicted/Abort/Cycles in --branch-history

Thomas Richter (4):
      perf/test: Speed up test case perf annotate basic tests
      perf/test: perf test 86 fails on s390
      perf test: Fix perf test case 84 on s390
      perf/test: fix perf ftrace test on s390

Veronika Molnarova (3):
      perf test: Restore sample rate for perf_event_attr
      perf test attr: Add back missing topdown events
      perf dso: Fix symtab_type for kmod compression

Xu Yang (3):
      perf vendor events arm64: imx95: add imx95_bandwidth_usage.lpddr4x metric
      perf vendor events arm64: Add i.MX91 DDR Performance Monitor metrics
      perf jevents: fix breakage when do perf stat on system metric

Yicong Yang (3):
      perf vender events arm64: Use "Topdown" as topdown metric group name
      perf build: Add missing cflags when building with custom libtraceevent
      perf build: Include libtraceevent headers directly indicated by pkg-config

Yoshihiro Furudera (1):
      perf list: update option desc in man page

 tools/build/Makefile.feature                       |   11 +-
 tools/build/feature/Makefile                       |   24 +-
 tools/build/feature/test-all.c                     |   16 +-
 tools/build/feature/test-dwarf.c                   |   11 -
 tools/build/feature/test-dwarf_getcfi.c            |    9 -
 tools/build/feature/test-dwarf_getlocations.c      |   13 -
 tools/build/feature/test-libdw-dwarf-unwind.c      |   14 -
 tools/build/feature/test-libdw.c                   |   56 +
 tools/build/feature/test-libtraceevent.c           |    2 +-
 tools/lib/api/io.h                                 |    1 +
 tools/lib/perf/Documentation/Makefile              |    2 +-
 tools/lib/perf/evsel.c                             |   48 +
 tools/lib/perf/include/internal/evsel.h            |   63 +-
 tools/lib/subcmd/run-command.c                     |   33 +
 tools/lib/subcmd/subcmd-util.h                     |    2 +-
 tools/perf/.gitignore                              |    6 +-
 tools/perf/Documentation/itrace.txt                |    2 +-
 tools/perf/Documentation/perf-arm-spe.txt          |    2 +-
 tools/perf/Documentation/perf-check.txt            |    6 +-
 tools/perf/Documentation/perf-config.txt           |   13 +
 tools/perf/Documentation/perf-list.txt             |   17 +-
 tools/perf/Documentation/perf-report.txt           |    8 +
 tools/perf/Documentation/perf-sched.txt            |    8 +
 tools/perf/Documentation/perf-script-python.txt    |    2 +-
 tools/perf/Documentation/perf-test.txt             |   17 +
 tools/perf/Makefile.config                         |   70 +-
 tools/perf/Makefile.perf                           |    9 +-
 tools/perf/arch/arc/annotate/instructions.c        |    2 +
 tools/perf/arch/arm/Makefile                       |    3 -
 tools/perf/arch/arm/annotate/instructions.c        |    2 +
 tools/perf/arch/arm/util/Build                     |    2 -
 tools/perf/arch/arm/util/dwarf-regs.c              |   61 -
 tools/perf/arch/arm64/Makefile                     |    4 -
 tools/perf/arch/arm64/annotate/instructions.c      |    2 +
 tools/perf/arch/arm64/util/Build                   |    1 -
 tools/perf/arch/arm64/util/arm-spe.c               |  116 +-
 tools/perf/arch/arm64/util/dwarf-regs.c            |   92 --
 tools/perf/arch/arm64/util/header.c                |   73 +-
 tools/perf/arch/arm64/util/pmu.c                   |   25 +-
 tools/perf/arch/csky/Makefile                      |    4 -
 tools/perf/arch/csky/annotate/instructions.c       |    7 +-
 tools/perf/arch/csky/util/Build                    |    1 -
 tools/perf/arch/loongarch/Makefile                 |    4 -
 tools/perf/arch/loongarch/annotate/instructions.c  |    2 +
 tools/perf/arch/loongarch/util/Build               |    1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c        |   44 -
 tools/perf/arch/loongarch/util/header.c            |    4 +-
 tools/perf/arch/mips/Makefile                      |    4 -
 tools/perf/arch/mips/annotate/instructions.c       |    2 +
 tools/perf/arch/mips/util/Build                    |    1 -
 tools/perf/arch/mips/util/dwarf-regs.c             |   38 -
 tools/perf/arch/powerpc/Makefile                   |    5 -
 tools/perf/arch/powerpc/annotate/instructions.c    |    6 +-
 tools/perf/arch/powerpc/util/Build                 |    3 +-
 tools/perf/arch/powerpc/util/dwarf-regs.c          |  153 --
 tools/perf/arch/powerpc/util/header.c              |   36 +-
 tools/perf/arch/riscv/Makefile                     |   27 +-
 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |   47 +
 tools/perf/arch/riscv/include/dwarf-regs-table.h   |   42 +
 tools/perf/arch/riscv/util/Build                   |    1 -
 tools/perf/arch/riscv/util/dwarf-regs.c            |   72 -
 tools/perf/arch/riscv/util/header.c                |    4 +-
 tools/perf/arch/riscv64/annotate/instructions.c    |    2 +
 tools/perf/arch/s390/Makefile                      |    4 -
 tools/perf/arch/s390/annotate/instructions.c       |    2 +
 tools/perf/arch/s390/util/Build                    |    1 -
 tools/perf/arch/s390/util/dwarf-regs.c             |   43 -
 tools/perf/arch/s390/util/header.c                 |    6 +-
 tools/perf/arch/sh/Build                           |    1 -
 tools/perf/arch/sh/Makefile                        |    4 -
 tools/perf/arch/sh/util/Build                      |    1 -
 tools/perf/arch/sh/util/dwarf-regs.c               |   41 -
 tools/perf/arch/sparc/Build                        |    1 -
 tools/perf/arch/sparc/Makefile                     |    4 -
 tools/perf/arch/sparc/annotate/instructions.c      |    2 +
 tools/perf/arch/sparc/util/Build                   |    1 -
 tools/perf/arch/sparc/util/dwarf-regs.c            |   39 -
 tools/perf/arch/x86/Makefile                       |    4 -
 tools/perf/arch/x86/annotate/instructions.c        |    5 +-
 tools/perf/arch/x86/tests/intel-cqm.c              |  128 --
 tools/perf/arch/x86/tests/intel-pt-test.c          |    4 +-
 tools/perf/arch/x86/util/Build                     |    4 -
 tools/perf/arch/x86/util/auxtrace.c                |    3 +-
 tools/perf/arch/x86/util/dwarf-regs.c              |  153 --
 tools/perf/arch/x86/util/env.c                     |   19 -
 tools/perf/arch/x86/util/env.h                     |    7 -
 tools/perf/arch/x86/util/evlist.c                  |  147 +-
 tools/perf/arch/x86/util/evsel.c                   |   38 +-
 tools/perf/arch/x86/util/header.c                  |    5 +-
 tools/perf/arch/x86/util/intel-pt.c                |    3 +-
 tools/perf/arch/x86/util/iostat.c                  |    2 +-
 tools/perf/arch/x86/util/pmu.c                     |    2 +-
 tools/perf/arch/x86/util/topdown.c                 |   43 +-
 tools/perf/arch/x86/util/topdown.h                 |    2 +
 tools/perf/arch/x86/util/tsc.c                     |   18 +-
 tools/perf/arch/xtensa/Build                       |    1 -
 tools/perf/arch/xtensa/Makefile                    |    4 -
 tools/perf/arch/xtensa/util/Build                  |    1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c           |   21 -
 tools/perf/bench/numa.c                            |   53 +
 tools/perf/bench/sched-pipe.c                      |   43 +-
 tools/perf/builtin-annotate.c                      |    2 +-
 tools/perf/builtin-check.c                         |    6 +-
 tools/perf/builtin-diff.c                          |    6 +-
 tools/perf/builtin-ftrace.c                        |    2 +-
 tools/perf/builtin-kmem.c                          |    2 +-
 tools/perf/builtin-kvm.c                           |    5 +-
 tools/perf/builtin-kwork.c                         |    2 +-
 tools/perf/builtin-list.c                          |   17 +-
 tools/perf/builtin-probe.c                         |   14 +-
 tools/perf/builtin-record.c                        |    4 +-
 tools/perf/builtin-report.c                        |   12 +-
 tools/perf/builtin-sched.c                         |  116 +-
 tools/perf/builtin-script.c                        |    9 +-
 tools/perf/builtin-stat.c                          |  396 +++--
 tools/perf/builtin-timechart.c                     |    3 +-
 tools/perf/builtin-trace.c                         |   27 +-
 tools/perf/dlfilters/dlfilter-test-api-v0.c        |    2 +-
 tools/perf/dlfilters/dlfilter-test-api-v2.c        |    2 +-
 tools/perf/perf.c                                  |    2 -
 .../arch/arm64/freescale/imx91/sys/ddrc.json       |    9 +
 .../arch/arm64/freescale/imx91/sys/metrics.json    |   26 +
 .../arch/arm64/freescale/imx95/sys/metrics.json    |    8 +
 .../arch/arm64/hisilicon/hip08/metrics.json        |   74 +-
 tools/perf/pmu-events/arch/common/common/tool.json |   74 +
 .../arch/powerpc/compat/generic-events.json        |  117 ++
 tools/perf/pmu-events/arch/powerpc/mapfile.csv     |    1 +
 .../pmu-events/arch/x86/amdzen5/data-fabric.json   | 1634 ++++++++++++++++++++
 .../pmu-events/arch/x86/amdzen5/load-store.json    |   78 +-
 .../pmu-events/arch/x86/amdzen5/recommended.json   |  112 ++
 tools/perf/pmu-events/empty-pmu-events.c           |  249 +--
 tools/perf/pmu-events/jevents.py                   |   57 +-
 tools/perf/pmu-events/pmu-events.h                 |    2 +-
 .../perf/scripts/python/Perf-Trace-Util/Context.c  |   11 +
 tools/perf/scripts/python/arm-cs-trace-disasm.py   |  143 +-
 tools/perf/tests/Build                             |    4 +-
 tools/perf/tests/attr.c                            |  218 ---
 tools/perf/tests/builtin-test.c                    |  438 ++++--
 tools/perf/tests/demangle-java-test.c              |    3 +-
 tools/perf/tests/event-times.c                     |    5 +-
 tools/perf/tests/evsel-tp-sched.c                  |   42 +-
 tools/perf/tests/expr.c                            |    5 +-
 tools/perf/tests/hwmon_pmu.c                       |  342 ++++
 tools/perf/tests/make                              |    6 +-
 tools/perf/tests/openat-syscall-tp-fields.c        |   19 +-
 tools/perf/tests/parse-events.c                    |   32 +-
 tools/perf/tests/pmu.c                             |    3 +-
 tools/perf/tests/shell/annotate.sh                 |   10 +-
 tools/perf/tests/shell/attr.sh                     |   22 +
 tools/perf/tests/{ => shell}/attr/README           |    2 +
 tools/perf/tests/{ => shell}/attr/base-record      |    0
 tools/perf/tests/{ => shell}/attr/base-record-spe  |    0
 tools/perf/tests/{ => shell}/attr/base-stat        |    0
 .../perf/tests/{ => shell}/attr/system-wide-dummy  |    0
 tools/perf/tests/{ => shell}/attr/test-record-C0   |    2 +
 .../perf/tests/{ => shell}/attr/test-record-basic  |    0
 .../tests/{ => shell}/attr/test-record-branch-any  |    0
 .../{ => shell}/attr/test-record-branch-filter-any |    0
 .../attr/test-record-branch-filter-any_call        |    0
 .../attr/test-record-branch-filter-any_ret         |    0
 .../{ => shell}/attr/test-record-branch-filter-hv  |    0
 .../attr/test-record-branch-filter-ind_call        |    0
 .../{ => shell}/attr/test-record-branch-filter-k   |    0
 .../{ => shell}/attr/test-record-branch-filter-u   |    0
 .../perf/tests/{ => shell}/attr/test-record-count  |    0
 tools/perf/tests/{ => shell}/attr/test-record-data |    0
 .../tests/{ => shell}/attr/test-record-dummy-C0    |    4 +-
 tools/perf/tests/{ => shell}/attr/test-record-freq |    0
 .../{ => shell}/attr/test-record-graph-default     |    0
 .../attr/test-record-graph-default-aarch64         |    0
 .../tests/{ => shell}/attr/test-record-graph-dwarf |    0
 .../tests/{ => shell}/attr/test-record-graph-fp    |    0
 .../{ => shell}/attr/test-record-graph-fp-aarch64  |    0
 .../{ => shell}/attr/test-record-group-sampling    |    3 +-
 .../tests/shell/attr/test-record-group-sampling1   |   50 +
 .../tests/shell/attr/test-record-group-sampling2   |   61 +
 .../perf/tests/{ => shell}/attr/test-record-group1 |    0
 .../perf/tests/{ => shell}/attr/test-record-group2 |    1 +
 tools/perf/tests/shell/attr/test-record-group3     |   31 +
 .../{ => shell}/attr/test-record-no-buffering      |    0
 .../tests/{ => shell}/attr/test-record-no-inherit  |    0
 .../tests/{ => shell}/attr/test-record-no-samples  |    0
 .../perf/tests/{ => shell}/attr/test-record-period |    0
 .../tests/{ => shell}/attr/test-record-pfm-period  |    0
 tools/perf/tests/{ => shell}/attr/test-record-raw  |    0
 .../tests/{ => shell}/attr/test-record-spe-period  |    0
 .../{ => shell}/attr/test-record-spe-period-term   |    0
 .../attr/test-record-spe-physical-address          |    0
 .../attr/test-record-user-regs-no-sve-aarch64      |    0
 .../attr/test-record-user-regs-old-sve-aarch64     |    0
 .../attr/test-record-user-regs-sve-aarch64         |    0
 tools/perf/tests/{ => shell}/attr/test-stat-C0     |    0
 tools/perf/tests/{ => shell}/attr/test-stat-basic  |    0
 .../perf/tests/{ => shell}/attr/test-stat-default  |   90 +-
 .../tests/{ => shell}/attr/test-stat-detailed-1    |  106 +-
 .../tests/{ => shell}/attr/test-stat-detailed-2    |  130 +-
 .../tests/{ => shell}/attr/test-stat-detailed-3    |  138 +-
 tools/perf/tests/{ => shell}/attr/test-stat-group1 |    0
 .../tests/{ => shell}/attr/test-stat-no-inherit    |    0
 tools/perf/tests/shell/coresight/asm_pure_loop.sh  |    2 +-
 .../tests/shell/coresight/memcpy_thread_16k_10.sh  |    2 +-
 .../shell/coresight/thread_loop_check_tid_10.sh    |    2 +-
 .../shell/coresight/thread_loop_check_tid_2.sh     |    2 +-
 .../tests/shell/coresight/unroll_loop_thread_10.sh |    2 +-
 tools/perf/tests/shell/ftrace.sh                   |    4 +-
 tools/perf/tests/{ => shell/lib}/attr.py           |   18 +
 tools/perf/tests/shell/lib/coresight.sh            |    2 +-
 .../perf/tests/shell/lib/perf_json_output_lint.py  |    5 +-
 tools/perf/tests/shell/list.sh                     |    5 +-
 tools/perf/tests/shell/lock_contention.sh          |    2 +-
 .../perf/tests/shell/perftool-testsuite_report.sh  |    2 +-
 tools/perf/tests/shell/pipe_test.sh                |    1 +
 tools/perf/tests/shell/probe_vfs_getname.sh        |    2 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |    4 +-
 .../tests/shell/record+script_probe_vfs_getname.sh |    2 +-
 tools/perf/tests/shell/record.sh                   |   75 +-
 tools/perf/tests/shell/record_lbr.sh               |    2 +-
 tools/perf/tests/shell/record_offcpu.sh            |    2 +-
 tools/perf/tests/shell/stat.sh                     |   65 +-
 tools/perf/tests/shell/stat_all_metricgroups.sh    |   36 +-
 tools/perf/tests/shell/stat_all_metrics.sh         |   87 +-
 tools/perf/tests/shell/stat_all_pmu.sh             |   54 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |    4 +-
 tools/perf/tests/shell/stat_bpf_counters_cgrp.sh   |   13 -
 tools/perf/tests/shell/test_arm_coresight.sh       |    4 +-
 .../perf/tests/shell/test_arm_coresight_disasm.sh  |   65 +
 tools/perf/tests/shell/test_arm_spe.sh             |    4 +-
 tools/perf/tests/shell/test_arm_spe_fork.sh        |    2 +-
 tools/perf/tests/shell/test_data_symbol.sh         |    2 +-
 tools/perf/tests/shell/test_intel_pt.sh            |    4 +-
 tools/perf/tests/shell/test_stat_intel_tpebs.sh    |   13 +-
 tools/perf/tests/shell/trace+probe_vfs_getname.sh  |    4 +-
 tools/perf/tests/shell/trace_exit_race.sh          |   51 +
 tools/perf/tests/task-exit.c                       |    9 +-
 tools/perf/tests/tests-scripts.c                   |    7 +-
 tools/perf/tests/tests.h                           |   11 +
 tools/perf/tests/tool_pmu.c                        |  111 ++
 tools/perf/util/Build                              |   17 +-
 tools/perf/util/annotate-data.h                    |    8 +-
 tools/perf/util/annotate.c                         |   12 +-
 tools/perf/util/annotate.h                         |    6 +
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h  |   18 +-
 tools/perf/util/arm-spe.c                          |  321 +++-
 tools/perf/util/arm-spe.h                          |   38 +-
 tools/perf/util/auxtrace.h                         |    3 +-
 tools/perf/util/bpf-filter.c                       |    2 +-
 tools/perf/util/bpf-prologue.h                     |   37 -
 tools/perf/util/bpf_counter.c                      |   35 +-
 tools/perf/util/bpf_skel/bperf_follower.bpf.c      |   98 +-
 tools/perf/util/bpf_skel/bperf_u.h                 |    5 +
 tools/perf/util/color.c                            |   28 -
 tools/perf/util/color.h                            |   11 +-
 tools/perf/util/config.c                           |   22 +
 tools/perf/util/config.h                           |    1 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |    7 +-
 tools/perf/util/cs-etm.c                           |   25 +-
 tools/perf/util/data-convert-bt.c                  |    2 +-
 tools/perf/util/data-convert-json.c                |    2 +-
 tools/perf/util/debug.c                            |    2 +-
 tools/perf/util/debuginfo.h                        |    6 +-
 tools/perf/util/disasm.c                           |  298 ++--
 tools/perf/util/disasm.h                           |    8 +-
 tools/perf/util/dwarf-aux.c                        |    6 -
 tools/perf/util/dwarf-aux.h                        |   54 -
 .../util/dwarf-regs.c => util/dwarf-regs-csky.c}   |   19 +-
 tools/perf/util/dwarf-regs-powerpc.c               |   61 +
 tools/perf/util/dwarf-regs-x86.c                   |   50 +
 tools/perf/util/dwarf-regs.c                       |   38 +-
 tools/perf/util/env.c                              |   27 +-
 tools/perf/util/env.h                              |    4 +
 tools/perf/util/event.h                            |    1 +
 tools/perf/util/evlist.c                           |   83 +-
 tools/perf/util/evlist.h                           |   15 +-
 tools/perf/util/evsel.c                            |  886 ++++++-----
 tools/perf/util/evsel.h                            |   52 +-
 tools/perf/util/evsel_fprintf.c                    |    2 +-
 tools/perf/util/expr.c                             |   97 +-
 tools/perf/util/genelf.c                           |    4 +-
 tools/perf/util/genelf.h                           |    2 +-
 tools/perf/util/hashmap.h                          |   20 +-
 tools/perf/util/header.c                           |   84 +-
 tools/perf/util/header.h                           |   23 +-
 tools/perf/util/hist.c                             |    3 +
 tools/perf/util/hist.h                             |    3 +
 tools/perf/util/hwmon_pmu.c                        |  832 ++++++++++
 tools/perf/util/hwmon_pmu.h                        |  151 ++
 tools/perf/util/include/dwarf-regs.h               |  124 +-
 tools/perf/util/intel-bts.c                        |    4 +-
 tools/perf/util/intel-pt.c                         |    4 +-
 tools/perf/util/machine.c                          |    2 +-
 tools/perf/util/mem-events.c                       |    8 +-
 tools/perf/util/metricgroup.c                      |   39 +-
 tools/perf/util/parse-events.c                     |  125 +-
 tools/perf/util/parse-events.h                     |   13 +-
 tools/perf/util/parse-events.l                     |   11 -
 tools/perf/util/parse-events.y                     |   18 +-
 tools/perf/util/pfm.c                              |    4 +-
 tools/perf/util/pmu.c                              |  137 +-
 tools/perf/util/pmu.h                              |   18 +-
 tools/perf/util/pmus.c                             |   18 +-
 tools/perf/util/pmus.h                             |    3 +
 tools/perf/util/print-events.c                     |   36 +-
 tools/perf/util/print-events.h                     |    1 -
 tools/perf/util/probe-event.c                      |  182 ++-
 tools/perf/util/probe-event.h                      |    3 -
 tools/perf/util/probe-file.c                       |   19 -
 tools/perf/util/probe-file.h                       |    1 -
 tools/perf/util/probe-finder.c                     |   42 +-
 tools/perf/util/probe-finder.h                     |   13 +-
 tools/perf/util/python.c                           |    2 +-
 tools/perf/util/s390-cpumsf.c                      |    2 +-
 tools/perf/util/s390-sample-raw.c                  |    8 +-
 .../perf/util/scripting-engines/trace-event-perl.c |    2 +-
 .../util/scripting-engines/trace-event-python.c    |   11 +-
 tools/perf/util/session.c                          |   28 +-
 tools/perf/util/sort.c                             |  115 +-
 tools/perf/util/sort.h                             |    3 +
 tools/perf/util/stat-display.c                     |  196 ++-
 tools/perf/util/stat-shadow.c                      |  166 +-
 tools/perf/util/stat.c                             |    2 +-
 tools/perf/util/stat.h                             |   16 +-
 tools/perf/util/string.c                           |  100 ++
 tools/perf/util/string2.h                          |    2 +
 tools/perf/util/symbol.c                           |    2 +-
 tools/perf/util/syscalltbl.c                       |    4 +
 tools/perf/util/target.h                           |    1 +
 tools/perf/util/threads.c                          |    4 +-
 tools/perf/util/tool_pmu.c                         |  505 ++++++
 tools/perf/util/tool_pmu.h                         |   56 +
 tools/perf/util/trace-event-parse.c                |    8 +-
 tools/perf/util/trace-event-read.c                 |    2 +-
 tools/perf/util/trace-event-scripting.c            |    2 +-
 tools/perf/util/trace-event.c                      |    2 +-
 tools/perf/util/trace-event.h                      |    5 +-
 tools/perf/util/tsc.c                              |    2 +-
 tools/perf/util/tsc.h                              |    2 +-
 tools/perf/util/util.c                             |   95 +-
 tools/perf/util/util.h                             |   18 +-
 338 files changed, 9483 insertions(+), 4123 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf.c
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c
 delete mode 100644 tools/build/feature/test-dwarf_getlocations.c
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c
 create mode 100644 tools/build/feature/test-libdw.c
 delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
 create mode 100755 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
 delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/x86/tests/intel-cqm.c
 delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/x86/util/env.c
 delete mode 100644 tools/perf/arch/x86/util/env.h
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/Makefile
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/ddrc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/freescale/imx91/sys/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/common/common/tool.json
 create mode 100644 tools/perf/pmu-events/arch/powerpc/compat/generic-events.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/data-fabric.json
 delete mode 100644 tools/perf/tests/attr.c
 create mode 100644 tools/perf/tests/hwmon_pmu.c
 create mode 100755 tools/perf/tests/shell/attr.sh
 rename tools/perf/tests/{ => shell}/attr/README (95%)
 rename tools/perf/tests/{ => shell}/attr/base-record (100%)
 rename tools/perf/tests/{ => shell}/attr/base-record-spe (100%)
 rename tools/perf/tests/{ => shell}/attr/base-stat (100%)
 rename tools/perf/tests/{ => shell}/attr/system-wide-dummy (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-C0 (95%)
 rename tools/perf/tests/{ => shell}/attr/test-record-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-any_ret (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-hv (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-ind_call (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-k (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-branch-filter-u (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-count (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-data (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-dummy-C0 (96%)
 rename tools/perf/tests/{ => shell}/attr/test-record-freq (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-default-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-dwarf (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-graph-fp-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group-sampling (88%)
 create mode 100644 tools/perf/tests/shell/attr/test-record-group-sampling1
 create mode 100644 tools/perf/tests/shell/attr/test-record-group-sampling2
 rename tools/perf/tests/{ => shell}/attr/test-record-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-group2 (95%)
 create mode 100644 tools/perf/tests/shell/attr/test-record-group3
 rename tools/perf/tests/{ => shell}/attr/test-record-no-buffering (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-inherit (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-no-samples (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-pfm-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-raw (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-period-term (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-spe-physical-address (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-no-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-old-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-record-user-regs-sve-aarch64 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-C0 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-basic (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-default (81%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-1 (85%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-2 (88%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-detailed-3 (89%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-group1 (100%)
 rename tools/perf/tests/{ => shell}/attr/test-stat-no-inherit (100%)
 rename tools/perf/tests/{ => shell/lib}/attr.py (94%)
 create mode 100755 tools/perf/tests/shell/test_arm_coresight_disasm.sh
 create mode 100755 tools/perf/tests/shell/trace_exit_race.sh
 create mode 100644 tools/perf/tests/tool_pmu.c
 delete mode 100644 tools/perf/util/bpf-prologue.h
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
 create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
 create mode 100644 tools/perf/util/dwarf-regs-x86.c
 create mode 100644 tools/perf/util/hwmon_pmu.c
 create mode 100644 tools/perf/util/hwmon_pmu.h
 create mode 100644 tools/perf/util/tool_pmu.c
 create mode 100644 tools/perf/util/tool_pmu.h
