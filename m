Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AEA30AAD8;
	Fri, 17 Apr 2026 21:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461928; cv=none; b=d0z3cHqTgrqDLhDZx99PQh5wtRf0J/MLdXboSY+FTt56CvNvXhaBiRNZDsLewmkJpd+y2Rgr2pP4fcZb2R1BgLcZn5e3WGQzaPcdGT5Dn79NzxYL+up8yNWraV1TEQtxlbainMLBhUe2Vgm6uEdQ+zqPt5xv0y9vcRXmgRSu/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461928; c=relaxed/simple;
	bh=rx3X+85rau+c9sxmXMKg2F4zP9TJs7dVI33gvneLasw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gzTbbjyWmH3Tn5j+84yX6Btp03dY1mETxGhRCCyIZNRQVkFS+WMp3sytKf7aGYzfoLMJrNIS6FcclignLVHGukkm5x/Gbcg5rcdgpDmZyREvFpDKcmrRRH5Dn48uj/P/ZGqBgRNELfqNFx5nBmJjoXWbNIYm5UU8eQehDIZOBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1Dd8nDW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1Dd8nDW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9FBC19425;
	Fri, 17 Apr 2026 21:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776461927;
	bh=rx3X+85rau+c9sxmXMKg2F4zP9TJs7dVI33gvneLasw=;
	h=From:To:Cc:Subject:Date:From;
	b=P1Dd8nDWCnRe0a9EAfvhLeQmIU+ZSWGhWxSNt24PxxS/TRy+N7FQELC3lCTJAiTfK
	 Vl3rStd51irEX56Vx5v7/gswHLaa/YTRDYAc38g08Ipm6/UYMxx1hk2p4fhvRidH4k
	 3KGhog6d9k2S7NwUVoFb5guRKoseKunFZlIvNP993lKjA6WSYMDSrN6MZFihDedsCc
	 2ZHtw2JURS8LS4vidfCtFeFkqnd7ZfdPQcjsTK3k5puwHe6Mioy1cvXZ+DB+yxpsdo
	 8yLs0knhvUOXv+yWdpORRUPjqCwB4FxoGsAG/llPz9i/30T+huN0HL7fZ9UeX4HvE1
	 FUvLxUSwe68Qg==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tool updates for v7.1
Date: Fri, 17 Apr 2026 14:38:44 -0700
Message-ID: <20260417213844.667501-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v7.1.

Thanks,
Namhyung


The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-for-v7.1-2026-04-17

for you to fetch changes up to 9a683fe0a00d2684ae874fd9eb58e6c1864fdf36:

  Merge tag 'v7.0-rc6' into perf-tools (2026-04-15 22:44:00 -0700)

----------------------------------------------------------------
perf tools updates for 7.1

perf report:

 - Add 'comm_nodigit' sort key to combine similar threads that only have
   different numbers in the comm.  In the following example, the
   'comm_nodigit' will have samples from all threads starting with
   "bpfrb/" into an entry "bpfrb/<N>".

    $ perf report -s comm_nodigit,comm -H
    ...
    #
    #    Overhead  CommandNoDigit / Command
    # ...........  ........................
    #
        20.30%     swapper
           20.30%     swapper
        13.37%     chrome
           13.37%     chrome
        10.07%     bpfrb/<N>
            7.47%     bpfrb/0
            0.70%     bpfrb/1
            0.47%     bpfrb/3
            0.46%     bpfrb/2
            0.25%     bpfrb/4
            0.23%     bpfrb/5
            0.20%     bpfrb/6
            0.14%     bpfrb/10
            0.07%     bpfrb/7

 - Support flat layout for symfs.  The --symfs option is to specify the
   location of debugging symbol files.  The default 'hierarchy' layout
   would search the symbol file using the same path of the original file
   under the symfs root.  The new 'flat' layout would search only in the
   root directory.

 - Update 'simd' sort key for ARM SIMD flags to cover ASE/SME and more
   predicate flags.

perf stat:

 - Add --pmu-filter option to select specific PMUs.  This would be
   useful when you measure metrics from multiple instance of uncore PMUs
   with similar names.

    # perf stat -M cpa_p0_avg_bw
     Performance counter stats for 'system wide':

        19,417,779,115      hisi_sicl0_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                     0      hisi_sicl0_cpa0/cpa_p0_wr_dat/
                     0      hisi_sicl0_cpa0/cpa_p0_rd_dat_64b/
                     0      hisi_sicl0_cpa0/cpa_p0_rd_dat_32b/
        19,417,751,103      hisi_sicl10_cpa0/cpa_cycles/     #     0.00 cpa_p0_avg_bw
                     0      hisi_sicl10_cpa0/cpa_p0_wr_dat/
                     0      hisi_sicl10_cpa0/cpa_p0_rd_dat_64b/
                     0      hisi_sicl10_cpa0/cpa_p0_rd_dat_32b/
        19,417,730,679      hisi_sicl2_cpa0/cpa_cycles/      #     0.31 cpa_p0_avg_bw
            75,635,749      hisi_sicl2_cpa0/cpa_p0_wr_dat/
            18,520,640      hisi_sicl2_cpa0/cpa_p0_rd_dat_64b/
                     0      hisi_sicl2_cpa0/cpa_p0_rd_dat_32b/
        19,417,674,227      hisi_sicl8_cpa0/cpa_cycles/      #     0.00 cpa_p0_avg_bw
                     0      hisi_sicl8_cpa0/cpa_p0_wr_dat/
                     0      hisi_sicl8_cpa0/cpa_p0_rd_dat_64b/
                     0      hisi_sicl8_cpa0/cpa_p0_rd_dat_32b/

          19.417734480 seconds time elapsed

   With --pmu-filter, users can select only hisi_sicl2_cpa0 PMU.

    # perf stat --pmu-filter hisi_sicl2_cpa0 -M cpa_p0_avg_bw
     Performance counter stats for 'system wide':

         6,234,093,559      cpa_cycles                       #     0.60 cpa_p0_avg_bw
            50,548,465      cpa_p0_wr_dat
             7,552,182      cpa_p0_rd_dat_64b
                     0      cpa_p0_rd_dat_32b

           6.234139320 seconds time elapsed

Data type profiling:

 - Quality improvements by tracking register state more precisely.
 - Ensure array members to get the type.
 - Handle more cases for global variables.

Vendor event/metric updates:

 - Update various Intel events and metrics
 - Add NVIDIA Tegra 410 Olympus events

Internal changes:

 - Verify perf.data header for maliciously crafted files.
 - Update perf test to cover more usages and make them robust.
 - Move a couple of copied kernel headers not to annoy objtool build.
 - Fix a bug in map sorting in name order.
 - Remove some unused codes.

Misc:

 - Fix module symbol resolution with non-zero text address.
 - Add -t/--threads option to `perf bench mem mmap`.
 - Track duration of exit*() syscall by `perf trace -s`.
 - Add core.addr2line-timeout and core.addr2line-disable-warn config
   items.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Andi Kleen (1):
      perf script: Fix brcntr output with --xed

Anubhav Shelat (1):
      perf tools: prevent null dsos from being added

Arnaldo Carvalho de Melo (22):
      perf beauty: Move tools/include/uapi/drm to tools/perf/trace/beauty/include/uapi
      perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
      perf symbols: Make variable receiving result strrchr() const
      perf util: Kill die() prototype, dead for a long time
      perf bench: Constify tables
      perf header: Use a max number of command line args
      perf header: Do validation of perf.data HEADER_CPU_DOMAIN_INFO
      perf tools: Use calloc() where applicable
      perf tools: Replace basename() calls with perf_basename()
      perf header: Validate nr_domains when reading HEADER_CPU_DOMAIN_INFO
      perf header: Bump up the max number of command line args allowed
      perf header: Sanity check HEADER_NRCPUS and HEADER_CPU_DOMAIN_INFO
      perf header: Sanity check HEADER_CPU_TOPOLOGY
      perf header: Sanity check HEADER_NUMA_TOPOLOGY
      perf header: Sanity check HEADER_MEM_TOPOLOGY
      perf header: Sanity check HEADER_PMU_MAPPINGS
      perf header: Sanity check HEADER_GROUP_DESC
      perf header: Sanity check HEADER_CACHE
      perf header: Sanity check HEADER_HYBRID_TOPOLOGY
      perf header: Sanity check HEADER_PMU_CAPS
      perf header: Sanity check HEADER_BPF_PROG_INFO
      perf header: Add sanity checks to HEADER_BPF_BTF processing

Besar Wicaksono (1):
      perf vendor events arm64: Add Tegra410 Olympus PMU events

Breno Leitao (1):
      perf stat: Fix crash on arm64

Changbin Du (1):
      perf tools: Add layout support for --symfs option

Chen Ni (2):
      perf tools: Remove duplicate include of debug.h
      perf tools: Remove duplicate include of stat.h

Chen Pei (1):
      perf symbol: Add RISCV case in get_plt_sizes

Chuck Lever (1):
      perf tools: Fix module symbol resolution for non-zero .text sh_addr

Ian Rogers (54):
      perf metricgroup: Fix metricgroup__has_metric_or_groups
      perf vendor events intel: Update alderlake events from 1.35 to 1.37
      perf vendor events intel: Update arrowlake events from 1.14 to 1.16
      perf vendor events intel: Update emeraldrapid events from 1.20 to 1.21
      perf vendor events intel: Update grandridge events from 1.10 to 1.11
      perf vendor events intel: Update graniterapids events from 1.16 to 1.17
      perf vendor events intel: Update lunarlake events from 1.19 to 1.21
      perf vendor events intel: Update meteorlake events from 1.18 to 1.20
      perf vendor events intel: Update pantherlake events from 1.02 to 1.04
      perf vendor events intel: Update sapphirerapids events from 1.35 to 1.36
      perf vendor events intel: Update sierraforest events from 1.13 to 1.15
      perf trace: Avoid an ERR_PTR in syscall_stats
      perf pmu: Replace starts_with with strstarts
      perf test type profiling: Remote typedef on struct
      perf disasm: Fix potential use-after-free on fileloc
      perf branch: Avoid incrementing NULL
      perf symbol: Reduce scope of elf__needs_adjust_symbols
      perf dump-insn: Remove dump-insn.c
      perf tool: Constify the command and option arrays
      perf bpf_map: Remove unused code
      perf record: Remove unused cpu-set-sched.h
      perf evsel: Improve falling back from cycles
      perf target: Constify simple check functions
      perf evsel: Constify option arguments to config functions
      perf callchain: Refactor callchain option parsing
      perf evlist: Improve default event for s390
      perf lock: Fix option value type in parse_max_stack
      perf stat: Fix opt->value type for parse_cache_level
      perf build: Add -funsigned-char to default CFLAGS
      libperf cpumap: Make index and nr types unsigned
      perf tests: Write test files to tmpdir
      perf clockid: Add missing include
      perf header: Add utility to convert feature number to a string
      perf header: Properly warn/print when libtraceevent/libbpf support is missing
      perf session: Extra logging for failed to process events
      perf header: Refactor pipe mode end marker handling
      perf ordered-events: Event processing consistency with the regular reader
      perf evsel: Make unknown event names more unique
      perf data convert ctf: Pipe mode improvements
      perf tests kwork: Add basic kwork coverage tests
      perf metrics: Make common stalled metrics conditional on having the event
      perf tests sched stats: Write output to temp file
      perf sample: Document struct perf_sample
      perf sample: Make sure perf_sample__init/exit are used
      perf sample: Add evsel to struct perf_sample
      perf cgroup: Update metric leader in evlist__expand_cgroup
      perf maps: Move getting debug_file to verbose path
      perf maps: Fix fixup_overlap_and_insert that can break sorted by name order
      perf maps: Fix copy_from that can break sorted by name order
      perf tools: Make more global variables static
      perf data: Clean up use_stdio and structures
      perf sample: Fix documentation typo
      perf test: Fix inet_pton probe failure and unroll call graph
      perf test: Fixes for check branch stack sampling

Leo Yan (9):
      perf kvm stat: Fix relative paths for including headers
      tools build: Correct link flags for libopenssl
      perf expr: Return -EINVAL for syntax error in expr__find_ids()
      perf expr: Add '\n' in literal parse errors
      perf metricgroup: Refine error logs
      perf sort: Support sort ASE and SME
      perf sort: Sort disabled and full predicated flags
      perf report: Update document for SIMD flags
      perf arm_spe: Improve SIMD flags setting

Markus Mayer (1):
      perf build: fix "argument list too long" in second location

Michael Petlan (1):
      perf trace: Fix potential u64 underflow in duration calculation

Mike Leach (2):
      perf: tools: cs-etm: Fix print issue for Coresight debug in ETE/TRBE trace
      perf: tools: cs-etm: Enhance raw Coresight trace debug display

Namhyung Kim (8):
      perf trace: Handle task exit in BPF syscall summary
      perf bench: Add -t/--threads option to perf bench mem mmap
      Merge tag 'perf-tools-fixes-for-v7.0-2-2026-03-23' into perf-tools-next
      perf test: Fix perf stat --bpf-counters on hybrid machines
      perf trace: Skip unnecessary synthesis for summary-only mode
      perf sched: Avoid crash for unexpected perf sched stats report
      perf test: Skip sched stats test for !root
      Merge tag 'v7.0-rc6' into perf-tools

Peter Collingbourne (1):
      perf annotate: Specify llvm features="+all" for aarch64

Qinxin Xia (1):
      perf tools: Add --pmu-filter option for filtering PMUs

Ricky Ringler (1):
      perf tools: Save cln_size header

Rong Bao (1):
      perf annotate: Use jump__delete when freeing LoongArch jumps

SeungJu Cheon (1):
      perf header: Validate build_id filename length to prevent buffer overflow

Stephen Brennan (1):
      perf report: Add comm_nodigit sort key

Thomas Falcon (1):
      perf test: Fix ratio_to_prev event parsing test

Thomas Richter (7):
      perf parse-events: Fix big-endian 'overwrite' by writing correct union member
      perf record: Add support for arch_sdt_arg_parse_op() on s390
      perf test: Skip perf data type profiling tests for s390
      perf config: Rename symbol_conf::disable_add2line_warn
      perf config: Make symbol_conf::addr2line_disable_warn configurable
      perf addr2line: Remove global variable addr2line_timeout_ms
      perf test: Make perf trace BTF general tests exclusive

WANG Rui (1):
      perf loongarch: Fix build failure with CONFIG_LIBDW_DWARF_UNWIND

Zecheng Li (11):
      perf dwarf-aux: Add die_get_pointer_type to get pointer types
      perf dwarf-aux: Preserve typedefs in match_var_offset
      perf dwarf-aux: Skip check_variable for variable lookup
      perf annotate-data: Improve type comparison from different scopes
      perf dwarf-aux: Handle array types in die_get_member_type
      perf annotate-data: Collect global variables without name
      perf annotate-data: Handle global variable access with const register
      perf annotate-data: Add invalidate_reg_state() helper for x86
      perf annotate-data: Invalidate caller-saved regs for all calls
      perf annotate-data: Use DWARF location ranges to preserve reg state
      perf dwarf-aux: Collect all variable locations for insn tracking

wangguangju (1):
      perf trace: Fix IS_ERR() vs NULL check bug

 tools/build/feature/Makefile                       |  10 +-
 tools/lib/perf/cpumap.c                            |  49 +-
 tools/lib/perf/evsel.c                             |  10 +-
 tools/lib/perf/include/internal/cpumap.h           |   6 +-
 tools/lib/perf/include/perf/cpumap.h               |   4 +-
 tools/perf/Documentation/perf-annotate.txt         |   7 +-
 tools/perf/Documentation/perf-bench.txt            |   4 +
 tools/perf/Documentation/perf-config.txt           |   6 +
 tools/perf/Documentation/perf-diff.txt             |   7 +-
 tools/perf/Documentation/perf-kwork.txt            |   7 +-
 tools/perf/Documentation/perf-probe.txt            |   6 +
 tools/perf/Documentation/perf-report.txt           |  15 +-
 tools/perf/Documentation/perf-sched.txt            |   7 +-
 tools/perf/Documentation/perf-script.txt           |   7 +-
 tools/perf/Documentation/perf-stat.txt             |   4 +
 tools/perf/Documentation/perf-timechart.txt        |   7 +-
 tools/perf/Documentation/tips.txt                  |   2 +-
 tools/perf/Makefile.config                         |   1 +
 tools/perf/Makefile.perf                           |   6 +-
 tools/perf/arch/arm/util/auxtrace.c                |   6 +-
 tools/perf/arch/arm/util/cs-etm.c                  |   7 +-
 tools/perf/arch/arm64/util/arm-spe.c               |   3 +-
 tools/perf/arch/arm64/util/header.c                |   2 +-
 tools/perf/arch/common.c                           |  22 +-
 tools/perf/arch/loongarch/util/Build               |   1 -
 tools/perf/arch/powerpc/util/auxtrace.c            |   1 +
 tools/perf/arch/sh/include/dwarf-regs-table.h      |   2 +-
 tools/perf/arch/x86/tests/amd-ibs-period.c         |   3 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c           |  11 +-
 tools/perf/arch/x86/util/pmu.c                     |  16 +-
 tools/perf/bench/breakpoint.c                      |   4 +-
 tools/perf/bench/mem-functions.c                   | 111 +++-
 tools/perf/bench/numa.c                            |  15 +-
 tools/perf/bench/sched-messaging.c                 |   2 +-
 tools/perf/bench/uprobe.c                          |   2 +-
 tools/perf/builtin-annotate.c                      |  15 +-
 tools/perf/builtin-bench.c                         |  42 +-
 tools/perf/builtin-c2c.c                           |  19 +-
 tools/perf/builtin-config.c                        |   2 +-
 tools/perf/builtin-daemon.c                        |   4 +-
 tools/perf/builtin-data.c                          |   8 +-
 tools/perf/builtin-diff.c                          |  13 +-
 tools/perf/builtin-ftrace.c                        |   1 +
 tools/perf/builtin-inject.c                        |  69 +-
 tools/perf/builtin-kmem.c                          |   2 +-
 tools/perf/builtin-kwork.c                         |  18 +-
 tools/perf/builtin-lock.c                          |   2 +-
 tools/perf/builtin-probe.c                         |   4 +-
 tools/perf/builtin-record.c                        | 106 ++-
 tools/perf/builtin-report.c                        |  30 +-
 tools/perf/builtin-sched.c                         |  12 +-
 tools/perf/builtin-script.c                        |  45 +-
 tools/perf/builtin-stat.c                          |  92 ++-
 tools/perf/builtin-timechart.c                     |   3 +-
 tools/perf/builtin-top.c                           |  51 +-
 tools/perf/builtin-trace.c                         |  34 +-
 tools/perf/check-headers.sh                        |   6 +-
 tools/perf/jvmti/libjvmti.c                        |   5 +-
 tools/perf/perf.c                                  |  12 +-
 tools/perf/pmu-events/Build                        |   4 +-
 .../arch/arm64/common-and-microarch.json           |  85 +++
 tools/perf/pmu-events/arch/arm64/mapfile.csv       |   1 +
 .../pmu-events/arch/arm64/nvidia/t410/branch.json  |  45 ++
 .../pmu-events/arch/arm64/nvidia/t410/brbe.json    |   6 +
 .../pmu-events/arch/arm64/nvidia/t410/bus.json     |  48 ++
 .../arch/arm64/nvidia/t410/exception.json          |  62 ++
 .../arch/arm64/nvidia/t410/fp_operation.json       |  78 +++
 .../pmu-events/arch/arm64/nvidia/t410/general.json |  15 +
 .../arch/arm64/nvidia/t410/l1d_cache.json          | 122 ++++
 .../arch/arm64/nvidia/t410/l1i_cache.json          | 114 ++++
 .../arch/arm64/nvidia/t410/l2d_cache.json          | 134 ++++
 .../arch/arm64/nvidia/t410/ll_cache.json           | 107 +++
 .../pmu-events/arch/arm64/nvidia/t410/memory.json  |  46 ++
 .../pmu-events/arch/arm64/nvidia/t410/metrics.json | 722 +++++++++++++++++++++
 .../pmu-events/arch/arm64/nvidia/t410/misc.json    | 642 ++++++++++++++++++
 .../pmu-events/arch/arm64/nvidia/t410/retired.json |  94 +++
 .../pmu-events/arch/arm64/nvidia/t410/spe.json     |  42 ++
 .../arch/arm64/nvidia/t410/spec_operation.json     | 230 +++++++
 .../pmu-events/arch/arm64/nvidia/t410/stall.json   | 145 +++++
 .../pmu-events/arch/arm64/nvidia/t410/tlb.json     | 158 +++++
 .../pmu-events/arch/common/common/metrics.json     |   6 +-
 .../perf/pmu-events/arch/x86/alderlake/cache.json  |  27 +-
 .../pmu-events/arch/x86/alderlake/frontend.json    |  18 +
 .../pmu-events/arch/x86/alderlake/pipeline.json    |  66 +-
 .../perf/pmu-events/arch/x86/alderlaken/cache.json |  27 +-
 .../pmu-events/arch/x86/alderlaken/pipeline.json   |  60 +-
 .../perf/pmu-events/arch/x86/arrowlake/cache.json  | 103 ++-
 .../pmu-events/arch/x86/arrowlake/frontend.json    |  18 +
 .../pmu-events/arch/x86/arrowlake/pipeline.json    |  40 +-
 .../pmu-events/arch/x86/emeraldrapids/cache.json   |   4 +-
 .../arch/x86/emeraldrapids/frontend.json           |  16 +
 .../arch/x86/emeraldrapids/uncore-cache.json       |   4 +-
 .../arch/x86/emeraldrapids/uncore-io.json          |  17 +-
 .../perf/pmu-events/arch/x86/grandridge/cache.json |  42 +-
 .../pmu-events/arch/x86/grandridge/pipeline.json   |  42 +-
 .../arch/x86/graniterapids/frontend.json           |  16 +
 .../arch/x86/graniterapids/gnr-metrics.json        |  27 +
 .../perf/pmu-events/arch/x86/lunarlake/cache.json  |  36 +-
 .../pmu-events/arch/x86/lunarlake/frontend.json    |  27 +
 .../pmu-events/arch/x86/lunarlake/pipeline.json    |  10 +-
 tools/perf/pmu-events/arch/x86/mapfile.csv         |  22 +-
 .../perf/pmu-events/arch/x86/meteorlake/cache.json |  67 +-
 .../pmu-events/arch/x86/meteorlake/frontend.json   |  18 +
 .../pmu-events/arch/x86/meteorlake/pipeline.json   |  46 +-
 .../pmu-events/arch/x86/pantherlake/cache.json     | 159 ++++-
 .../arch/x86/pantherlake/floating-point.json       |  28 +
 .../pmu-events/arch/x86/pantherlake/frontend.json  |  36 +
 .../pmu-events/arch/x86/pantherlake/memory.json    |  27 +
 .../pmu-events/arch/x86/pantherlake/other.json     |  10 +
 .../pmu-events/arch/x86/pantherlake/pipeline.json  | 200 +++++-
 .../arch/x86/pantherlake/virtual-memory.json       |  30 +
 .../pmu-events/arch/x86/sapphirerapids/cache.json  |   4 +-
 .../arch/x86/sapphirerapids/frontend.json          |  16 +
 .../arch/x86/sapphirerapids/uncore-cache.json      |   4 +-
 .../arch/x86/sapphirerapids/uncore-io.json         |  17 +-
 .../pmu-events/arch/x86/sierraforest/cache.json    |  22 +-
 .../pmu-events/arch/x86/sierraforest/pipeline.json |  42 +-
 tools/perf/pmu-events/empty-pmu-events.c           | 108 +--
 tools/perf/tests/bitmap.c                          |   2 +-
 tools/perf/tests/bp_signal.c                       |   2 +-
 tools/perf/tests/code-reading.c                    |   1 +
 tools/perf/tests/cpumap.c                          |   6 +-
 tools/perf/tests/dso-data.c                        |   2 +-
 tools/perf/tests/event_update.c                    |   4 +-
 tools/perf/tests/expand-cgroup.c                   |   4 +-
 tools/perf/tests/hists_cumulate.c                  |   2 +-
 tools/perf/tests/hists_filter.c                    |   1 +
 tools/perf/tests/hists_output.c                    |   2 +-
 tools/perf/tests/mem2node.c                        |   2 +-
 tools/perf/tests/openat-syscall-all-cpus.c         |   3 +-
 tools/perf/tests/parse-events.c                    |  49 +-
 tools/perf/tests/perf-record.c                     |   8 +-
 tools/perf/tests/shell/data_type_profiling.sh      |   6 +-
 tools/perf/tests/shell/kwork.sh                    |  79 +++
 tools/perf/tests/shell/perf_sched_stats.sh         |  42 +-
 .../tests/shell/record+probe_libc_inet_pton.sh     |   8 +-
 tools/perf/tests/shell/stat_bpf_counters.sh        |  20 +-
 tools/perf/tests/shell/test_brstack.sh             | 146 +++--
 tools/perf/tests/shell/test_task_analyzer.sh       |  42 +-
 tools/perf/tests/shell/trace_btf_general.sh        |   2 +-
 tools/perf/tests/switch-tracking.c                 |   2 +
 tools/perf/tests/thread-map.c                      |   1 -
 tools/perf/tests/topology.c                        |  11 +-
 tools/perf/tests/workloads/datasym.c               |   6 +-
 tools/perf/tests/wp.c                              |   6 +-
 tools/perf/trace/beauty/drm_ioctl.sh               |   2 +-
 tools/perf/trace/beauty/fadvise.sh                 |   2 +-
 .../{ => perf/trace/beauty}/include/uapi/drm/drm.h |   0
 .../trace/beauty}/include/uapi/drm/i915_drm.h      |   0
 .../trace/beauty}/include/uapi/linux/fadvise.h     |   0
 tools/perf/util/Build                              |   2 -
 tools/perf/util/addr2line.c                        |  17 +-
 tools/perf/util/addr2line.h                        |   2 -
 tools/perf/util/affinity.c                         |   2 +-
 tools/perf/util/annotate-arch/annotate-loongarch.c |   1 +
 tools/perf/util/annotate-arch/annotate-x86.c       |  70 +-
 tools/perf/util/annotate-data.c                    | 119 ++--
 tools/perf/util/annotate-data.h                    |   3 +
 tools/perf/util/annotate.c                         |   3 +-
 tools/perf/util/arm-spe.c                          |  26 +-
 tools/perf/util/block-info.c                       |   2 +-
 tools/perf/util/block-range.c                      |   2 +-
 tools/perf/util/bpf-event.c                        |   2 +-
 tools/perf/util/bpf_counter.c                      |  28 +-
 tools/perf/util/bpf_counter_cgroup.c               |   9 +-
 tools/perf/util/bpf_kwork.c                        |   3 +-
 tools/perf/util/bpf_kwork_top.c                    |   3 +-
 tools/perf/util/bpf_map.c                          |  70 --
 tools/perf/util/bpf_map.h                          |  23 -
 tools/perf/util/bpf_off_cpu.c                      |   4 +-
 tools/perf/util/bpf_skel/syscall_summary.bpf.c     |  18 +-
 tools/perf/util/bpf_trace_augment.c                |   2 +-
 tools/perf/util/branch.h                           |   3 +
 tools/perf/util/callchain.c                        |  83 ++-
 tools/perf/util/callchain.h                        |  12 +-
 tools/perf/util/cgroup.c                           |  30 +-
 tools/perf/util/clockid.h                          |   3 +-
 tools/perf/util/config.c                           |   6 +-
 tools/perf/util/cpu-set-sched.h                    |  50 --
 tools/perf/util/cpumap.c                           |  10 +-
 tools/perf/util/cputopo.c                          |   2 +-
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c    |  56 +-
 tools/perf/util/data-convert-bt.c                  |  74 ++-
 tools/perf/util/data-convert-json.c                |  16 +-
 tools/perf/util/data.c                             | 101 ++-
 tools/perf/util/data.h                             |  52 +-
 tools/perf/util/db-export.c                        |   1 -
 tools/perf/util/debug.c                            |   2 +-
 tools/perf/util/debuginfo.c                        |  19 +-
 tools/perf/util/disasm.c                           |  11 +-
 tools/perf/util/disasm.h                           |   2 +
 tools/perf/util/drm_pmu.c                          |  36 +-
 tools/perf/util/dsos.c                             |  35 +-
 tools/perf/util/dump-insn.c                        |  23 -
 tools/perf/util/dwarf-aux.c                        | 145 +++--
 tools/perf/util/dwarf-aux.h                        |   9 +-
 tools/perf/util/env.c                              |   2 +-
 tools/perf/util/env.h                              |   1 +
 tools/perf/util/event.c                            |   1 -
 tools/perf/util/evlist.c                           |  40 +-
 tools/perf/util/evlist.h                           |   2 +-
 tools/perf/util/evsel.c                            | 112 ++--
 tools/perf/util/evsel.h                            |  10 +-
 tools/perf/util/expr.c                             |   7 +-
 tools/perf/util/header.c                           | 436 +++++++++++--
 tools/perf/util/header.h                           |   9 +-
 tools/perf/util/hist.c                             |   5 +-
 tools/perf/util/hist.h                             |   2 +
 tools/perf/util/intel-tpebs.c                      |  12 +-
 tools/perf/util/libbfd.c                           |   2 +-
 tools/perf/util/llvm.c                             |  10 +-
 tools/perf/util/maps.c                             |  24 +-
 tools/perf/util/mem2node.c                         |   2 +-
 tools/perf/util/metricgroup.c                      |  29 +-
 tools/perf/util/ordered-events.c                   |   2 +-
 tools/perf/util/parse-events.c                     |   2 +-
 tools/perf/util/perf-regs-arch/perf_regs_s390.c    |  78 +++
 tools/perf/util/perf_regs.c                        |   3 +
 tools/perf/util/perf_regs.h                        |   1 +
 tools/perf/util/pmus.c                             |   2 +-
 tools/perf/util/powerpc-vpadtl.c                   |  11 +-
 tools/perf/util/probe-event.c                      |  20 +-
 tools/perf/util/probe-file.c                       |   2 +-
 tools/perf/util/probe-finder.c                     |   8 +-
 tools/perf/util/sample.c                           |  11 +-
 tools/perf/util/sample.h                           | 140 +++-
 .../util/scripting-engines/trace-event-python.c    |   2 +-
 tools/perf/util/session.c                          |  83 ++-
 tools/perf/util/sort.c                             | 276 ++++++--
 tools/perf/util/sort.h                             |   2 +
 tools/perf/util/srcline.c                          |  12 +-
 tools/perf/util/stat-display.c                     |   4 +-
 tools/perf/util/stat-shadow.c                      |   1 -
 tools/perf/util/stat.c                             |   8 +-
 tools/perf/util/svghelper.c                        |   3 +-
 tools/perf/util/symbol-elf.c                       |  20 +-
 tools/perf/util/symbol.c                           |  40 +-
 tools/perf/util/symbol.h                           |  11 +-
 tools/perf/util/symbol_conf.h                      |   4 +-
 tools/perf/util/synthetic-events.c                 |   2 +-
 tools/perf/util/target.h                           |  12 +-
 tools/perf/util/unwind-libunwind-local.c           |   1 -
 tools/perf/util/util.c                             |  10 +-
 tools/perf/util/util.h                             |   3 +-
 tools/perf/util/values.c                           |   8 +-
 245 files changed, 6797 insertions(+), 1676 deletions(-)
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/branch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/brbe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/bus.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/exception.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/fp_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/general.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l1i_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/l2d_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/ll_cache.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/memory.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/metrics.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/misc.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/retired.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spe.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/spec_operation.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/stall.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/nvidia/t410/tlb.json
 create mode 100755 tools/perf/tests/shell/kwork.sh
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/drm.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/drm/i915_drm.h (100%)
 rename tools/{ => perf/trace/beauty}/include/uapi/linux/fadvise.h (100%)
 delete mode 100644 tools/perf/util/bpf_map.c
 delete mode 100644 tools/perf/util/bpf_map.h
 delete mode 100644 tools/perf/util/cpu-set-sched.h
 delete mode 100644 tools/perf/util/dump-insn.c
