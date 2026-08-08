Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322CA3B47F3;
	Sat,  8 Aug 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786191870; cv=none; b=ZbEOo9KbOvhzmAH0ZO2CPjFieXCp0qrJH0kNemmR/RVFnt34aUxQYdvb6U3BRFBv/vVAoxeNU9Iv0z9IX72rMRt2eqowozWpFNieCJ4SCWCwvQU74jneGMzQo2VxesETHL6KE8/5KgGBPamQdVKXOCp7Rhefs4GMdS1QP8LMF88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786191870; c=relaxed/simple;
	bh=rCtzi09dUDL1ROZsshWgZCWHuHdqxulxJd+oC8kXa9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d5Oln3CFFtWiH+CsNk/3jS32iGevOiT7sFFgQzTwyUZ5LARhvQAnzuW+DCnv+YmvW3AFtsHs5M8gw9owEYErQ1KdVPc05VGuGW8acv4qgJoG44KbcYSA3qsBkvRUdVCuOuqqvbtHMAob/ZfDNJ+Qt5dK2ovor61L/Z7xt10q9HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hHKtH1Rl0zYQv7C;
	Sat,  8 Aug 2026 20:23:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 5D69040590;
	Sat,  8 Aug 2026 20:24:17 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgB34YjkH3dqbrhMBg--.41805S2;
	Sat, 08 Aug 2026 20:24:14 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Namhyung Kim <namhyung@kernel.org>,
	james.clark@linaro.org,
	xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v4 00/23] perf arm64: Support data type profiling
Date: Sat,  8 Aug 2026 12:23:37 +0000
Message-Id: <20260808122400.2961238-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgB34YjkH3dqbrhMBg--.41805S2
X-Coremail-Antispam: 1UD129KBjvAXoW3trWftFWftw1DXrW8tFy8uFg_yoW8JryfCo
	WS9FZ8ur18Jr1rGayq9ryrCFyUZws7urn3Jr43Wwn5u3WUJa1agw1Ikw47W3WfCF4YqFn5
	A34Dt34UtFy7G3Z3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY_7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402
	YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY1x0264kExVAvwVAq07x20x
	yl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRQ2-0DUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

This patch series implements data type profiling support for arm64,
enabling 'perf annotate --data-type' to resolve memory locations and
variable types on arm64 platforms.

The main changes since v3 include:
v3: https://lore.kernel.org/all/20260701035355.752944-1-wutengda@huaweicloud.com/

* Enhanced Instruction Analysis & Type Tracking: Added dual-register type
  tracking for load/store pair instructions, register tracking for function
  calls, and extended parsing for ARM64 PC-relative load and post-index
  addressing modes.

* Internal Refactoring & Simplification: Reused existing fields (imm_value
  for 'adrp' instruction tracking) instead of introducing redundant structures
  like addr. The TSR_KIND_GLOBAL_ADDR kind was retained because we still
  need it to distinguish whether imm_value is an ordinary constant or an
  address derived from an adrp instruction.

* ARM SPE Optimization & Bug Fixes: Improved --itrace=i1i to deduplicate
  early during arm_spe_process_auxtrace_info, scoped the default period
  logic to ARM SPE, and fixed critical issues including memory leaks, Capstone
  compilation, stale type resolution, and stack variable offset calculations.

Patch organization
==================

The series is organized as follows:

1. Fix disassembly mismatches (Patches 01-02)
   Current perf annotate supports three disassembly backends: llvm,
   capstone, and objdump. On arm64, inconsistencies between the output
   of these backends (specifically llvm/capstone vs. objdump) often
   prevent the tracker from correctly identifying registers and offsets.
   These patches resolve these mismatches, ensuring consistent instruction
   parsing across all supported backends.

2. Infrastructure for arm64 operand parsing (Patches 03-08)
   These patches establish the necessary infrastructure for arm64-specific
   operand handling. This includes implementing new callbacks and data
   structures to manage arm64's unique addressing modes and register sets.
   This foundation is essential for the subsequent type-tracking logic.

3. ARM SPE event handling (Patches 09-10)
   Patch 09 automatically deduplicates overlapping ARM SPE events (e.g.,
   l1d-miss, tlb-access) in 'perf annotate' by retaining only the
   "instructions" event when data type profiling is enabled. Patch 10
   defaults  the synthesized event period to 1 for ARM SPE to fix zero
   'Percent' values in annotate output.

5. Core instruction tracking (Patches 11-23)
   These patches implement the core logic for type tracking on arm64,
   covering several key types of instructions, including:
   * Memory Access: ldr/str variants (including stack-based access).
   * Arithmetic & Data Processing: mov, add, and adrp.
   * Special Access: System register access (mrs) and per-cpu variable
     tracking.

The implementation draws inspiration from the existing x86 logic while
adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
perf annotate can successfully resolve memory locations and register types,
providing basic support for data type profiling on arm64 platforms.

Example Result
==============

# perf mem record -a -K -- sleep 1
# perf annotate --data-type --stdio --type-stat
Annotate data type stats:
total 1138, ok 846 (74.3%), bad 292 (25.7%)
-----------------------------------------------------------
         6 : no_sym
        42 : no_var
       239 : no_typeinfo
         5 : bad_offset
       207 : insn_track

Annotate type: 'struct page' in [kernel.kallsyms] (66948 samples):
============================================================================
 Percent     offset       size  field
  100.00          0       0x40  struct page      {
    9.01          0        0x8      long unsigned int   flags;
   57.99        0x8       0x28      union        {
   57.99        0x8       0x28          struct   {
   33.00        0x8       0x10              union        {
   33.00        0x8       0x10                  struct list_head        lru {
   33.00        0x8        0x8                      struct list_head*   next;
    0.00       0x10        0x8                      struct list_head*   prev;
                                                };
   33.00        0x8       0x10                  struct   {
   33.00        0x8        0x8                      void*       __filler;
    0.00       0x10        0x4                      unsigned int        mlock_count;
   ...

Each patch's type profiling results are as follows:

Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
------+----------------------------+--------+--------+-------------+------------+------------+------
0010  | base (default spe period)  | 6      | 493    | -           | -          | -          | 56.2%
0012  | enable insn tracking       | 6      | 42     | 438         | 2          | 11         | 57.1%
0014  | support 'load' insn        | 6      | 42     | 399         | 1          | 51         | 60.6%
0015  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
0018  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
0019  | support 'mov' insn         | 6      | 42     | 373         | 3          | 75         | 62.7%
0020  | support 'add' insn         | 6      | 42     | 335         | 4          | 112        | 66.0%
0021  | support 'adrp' insn        | 6      | 42     | 250         | 5          | 196        | 73.4%
0022  | support per-cpu variable   | 6      | 42     | 250         | 5          | 196        | 73.4%
0023  | support 'mrs' insn         | 6      | 42     | 239         | 5          | 207        | 74.3%

Limitations
===========

* SIMD/FP & SVE Vector Support:
  Data type profiling currently focuses on General-Purpose (GP) register
  operations. Vector/SIMD registers (v0-v31, d0-d31, q0-q31) and Scalable
  Vector Extension (SVE/SME) instructions are not tracked yet.

* Complex Addressing Modes & Bitwise Pointer Manipulation:
  Register-shifted offset modes (e.g., [base, reg, lsl #scale]) and bitfield
  manipulations (e.g., ubfx, masking) on pointers are not fully parsed,
  limiting offset resolution for certain dynamic array index accesses.

* Compiler Prologue/Epilogue Code:
  As shown by the previous test results, approximately 14% of the failed
  type profiling results originate from compiler-generated prologue or
  epilogue code (e.g., ldp  x19, x20, [sp, #16]). These instructions manage
  callee-saved registers across function boundaries, propagating type
  context through these operations requires inter-procedural (cross-function)
  instruction analysis, which is currently unsupported by the local backward
  instruction tracker.

Testing
=======

Tested on arm64 (all passed):

  # perf test -v "perf data type profiling tests"
  81: perf data type profiling tests                                                                  : Ok

  === Test Summary ===
  Passed main tests : 1
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 0

Tested on x86. The profiling results show no change before/after applying
this patch series:

  before : total 880, ok 711 (80.8%), bad 169 (19.2%)
  after  : total 880, ok 711 (80.8%), bad 169 (19.2%)

Changelog
=========
v3 -> v4:
  - v3: https://lore.kernel.org/all/20260701035355.752944-1-wutengda@huaweicloud.com/
  - Fix Capstone compilation failure.
  - Stop adding new pcrel_adrp_addr in LLVM; reuse pcrel_load_addr instead.
  - Fix parsing issue in arm64_mov__parse.
  - Add PC-relative load instruction parsing logic to arm64_ldst__parse,
    and introduce rstrip_space_and_comment to strip comments.
  - Remove wzr/xzr register parsing (not planning to handle this yet).
  - Add post-index addressing mode parsing for the '[base], reg' format.
  - Update built-in implementation of --itrace=i1i to deduplicate early
    during arm_spe_process_auxtrace_info.
  - Restrict the "default period to 1" behavior to ARM SPE, instead of
    applying it to all architectures.
  - Add register type tracking for function call instructions.
  - Add dual-register type tracking for load pair and store pair instructions.
  - Correct stack variable offset calculations.
  - Add type invalidation upon retry failure.
  - Reuse imm_value instead of introducing addr for 'adrp' instruction tracking.
  - Fix potential stale type resolution errors caused by TSR_KIND_GLOBAL_ADDR
    and TSR_KIND_CONST during stack passing.
  - Fix a strbuf memory leak during 'mrs' instruction tracking.
  - Fix stale dieoff issue when debug info changes.
  - Simplify add type propagation: only propagate offset/imm updates, leave
    type parsing to chk.
v2 -> v3:
  - v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
  - Instead of always parsing the left operand as src and the right operand as
    dst, set them based on the actual instruction definition. (Namhyung Kim)
  - Fix refcount leak in print_capstone_detail().
  - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov__parse().
  - Add example comments in arm64_ldst__parse().
  - Split arch__dwarf_regnum() changes into a separate commit.
  - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*.
  - Set caller-saved registers in init_type_state().
  - For instructions with addressing mode, always goto adjust_reg_index_state()
    at the end to update the src register state.
  - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions.
  - Invalidate dst register for all other unsupported instructions.
  - Verify type DIE is task_struct pointer before caching globally.
  - Enable --itrace=i1i by default for ARM SPE data type profiling in 'perf annotate'
    to avoid overlapping event counting for the same instruction. (James Clark)
  - Fix global variable type resolving error in check_matching_type(). (James Clark)
  - Address review comments from sashiko [1]:
    - Fix unconditional call to arch->extract_op_location()
    - Handle multi_regs correctly
    - Fix invalid register state in error path
    - Other misc fixes
v1 -> v2:
  - v1: https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
  - Fix inconsistencies in arm64 instruction output across llvm, capstone,
    and objdump disassembly backends.
  - Support arm64-specific addressing modes and operand formats. (Leo Yan)
  - Extend instruction tracking to support mov and add instructions,
    along with per-cpu and stack variables.
  - Include real-world examples in commit messages to demonstrate
    practical effects. (Namhyung Kim)
  - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.

Please let me know if you have any feedback.

Thanks,
Tengda

[1] https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com
[2] https://developer.arm.com/documentation/102374/0103
[3] https://github.com/flynd/asmsheets/releases/tag/v8

Tengda Wu (23):
  perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
  perf llvm: Fix arm64 adrp instruction disassembly mismatch with
    objdump
  perf annotate-arm64: Generalize arm64_mov__parse to support more
    instructions
  perf annotate-arm64: Handle load and store instructions
  perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
  perf annotate: Adapt arch__dwarf_regnum() for arm64
  perf annotate: Introduce extract_op_location callback for
    arch-specific parsing
  perf annotate-arm64: Implement extract_op_location() callback
  perf annotate: Deduplicate overlapping ARM SPE events for data type
    profiling
  perf arm-spe: Set default synthesized event period to 1
  perf annotate-data: Extract invalidate_reg_state() as a common helper
  perf annotate-arm64: Enable instruction tracking support
  perf annotate-arm64: Track return type after call instructions
  perf annotate-arm64: Support load instruction tracking
  perf annotate-arm64: Support store instruction tracking
  perf annotate-data: Expand type_state_reg imm_value to u64
  perf annotate-data: Track imm_value for stack variables
  perf annotate-arm64: Support stack variable tracking
  perf annotate-arm64: Support 'mov' instruction tracking
  perf annotate-arm64: Support 'add' instruction tracking
  perf annotate-arm64: Support 'adrp' instruction to track global
    variables
  perf annotate-arm64: Support per-cpu variable access tracking
  perf annotate-arm64: Support 'mrs' instruction to track 'current'
    pointer

 tools/perf/builtin-annotate.c                 |    8 +
 .../perf/util/annotate-arch/annotate-arm64.c  | 1066 ++++++++++++++++-
 .../util/annotate-arch/annotate-powerpc.c     |   10 +
 tools/perf/util/annotate-arch/annotate-x86.c  |  101 +-
 tools/perf/util/annotate-data.c               |   80 +-
 tools/perf/util/annotate-data.h               |    9 +-
 tools/perf/util/annotate.c                    |  108 +-
 tools/perf/util/annotate.h                    |   12 +
 tools/perf/util/arm-spe.c                     |   28 +
 tools/perf/util/auxtrace.h                    |    2 +
 tools/perf/util/capstone.c                    |  136 ++-
 tools/perf/util/disasm.c                      |    5 +
 tools/perf/util/disasm.h                      |    5 +
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |   22 +
 tools/perf/util/dwarf-regs.c                  |    2 +-
 tools/perf/util/include/dwarf-regs.h          |    1 +
 tools/perf/util/llvm.c                        |   50 +-
 17 files changed, 1481 insertions(+), 164 deletions(-)


base-commit: 1701fda2f58e345c050f4309971bdc07cd6146ba
-- 
2.34.1

