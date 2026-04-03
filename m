Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA99A2F8BC3;
	Fri,  3 Apr 2026 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775209734; cv=none; b=G54ZSlaw8sZckmoh5bOBEWf+jWUw/plwhSbRGT3lVwtX9sbYBjkjdEDvvqhYzHTddWG4C9kHrjf3H/qUUhHXIbOi/3ziYWbxQJ7kjTG3TPhPlIuvPUYZvGaHFlJUQHFNTIyvjDvuATu19A42oe7GzwtU76V+bF6vQl/GZsnVqiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775209734; c=relaxed/simple;
	bh=3/Fg+g7WYNbO7097jar1RZcnmLXYfNQkQCBM0h6enO8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnIYY+mSDtQZUedUUFejUOk15zjt/J5vre5m2F7QdFKSWKhRmGGKKfCtY//k1gaGyYwprXwVyYrqNNRWXTzbDWbhxxrzMvoB9RLalXdmv3x6CyjSBPrUOUDsZXreWQQmh0bgfeTruC9bbpU/2b7AaNdWIf6+osfR6imiiEd5f+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fnDS74VdbzYQtrY;
	Fri,  3 Apr 2026 17:48:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1081340574;
	Fri,  3 Apr 2026 17:48:49 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with SMTP id _Ch0CgAnB1TwjM9p8K_UDA--.49742S2;
	Fri, 03 Apr 2026 17:48:46 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Namhyung Kim <namhyung@kernel.org>,
	leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 00/16] perf arm64: Support data type profiling
Date: Fri,  3 Apr 2026 09:47:44 +0000
Message-Id: <20260403094800.1418825-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnB1TwjM9p8K_UDA--.49742S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF1fGr1UWr4fXw43GFW8Crg_yoW7CF15pF
	sxC3yfJr4UJrWFkwnxZrWxXrW3Kw4fJayfKryrt3ySkF429F95tFyxtF1SyFWrCr9xZw47
	Aw1qqr1UWF18CFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc7CjxVAKzI0EY4vE52x082I5MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sR_DUUUUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

This patch series implements data type profiling support for arm64,
building upon the foundational work previously contributed by Huafei [1].
While the initial version laid the groundwork for arm64 data type analysis,
this series iterates on that work by refining instruction parsing and
extending support for core architectural features.

The series is organized as follows:

1. Fix disassembly mismatches (Patches 01-02)
   Current perf annotate supports three disassembly backends: llvm,
   capstone, and objdump. On arm64, inconsistencies between the output
   of these backends (specifically llvm/capstone vs. objdump) often
   prevent the tracker from correctly identifying registers and offsets.
   These patches resolve these mismatches, ensuring consistent instruction
   parsing across all supported backends.

2. Infrastructure for arm64 operand parsing (Patches 03-07)
   These patches establish the necessary infrastructure for arm64-specific
   operand handling. This includes implementing new callbacks and data
   structures to manage arm64's unique addressing modes and register sets.
   This foundation is essential for the subsequent type-tracking logic.

3. Core instruction tracking (Patches 08-16)
   These patches implement the core logic for type tracking on arm64,
   covering a wide range of instructions including:

   * Memory Access: ldr/str variants (including stack-based access).
   * Arithmetic & Data Processing: mov, add, and adrp.
   * Special Access: System register access (mrs) and per-cpu variable
     tracking.

The implementation draws inspiration from the existing x86 logic while
adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
perf annotate can successfully resolve memory locations and register
types, enabling comprehensive data type profiling on arm64 platforms.

Example Result
==============

# perf mem record -a -K -- sleep 1
# perf annotate --data-type --type-stat --stdio
Annotate data type stats:
total 6204, ok 5091 (82.1%), bad 1113 (17.9%)
-----------------------------------------------------------
        29 : no_sym
       196 : no_var
       806 : no_typeinfo
        82 : bad_offset
      1370 : insn_track

Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
============================================================================
 Percent     offset       size  field
  100.00          0       0x40  struct page      {
    9.95          0        0x8      long unsigned int   flags;
   52.83        0x8       0x28      union        {
   52.83        0x8       0x28          struct   {
   37.21        0x8       0x10              union        {
   37.21        0x8       0x10                  struct list_head        lru {
   37.21        0x8        0x8                      struct list_head*   next;
    0.00       0x10        0x8                      struct list_head*   prev;
                                                };
   37.21        0x8       0x10                  struct   {
   37.21        0x8        0x8                      void*       __filler;
    0.00       0x10        0x4                      unsigned int        mlock_count;
   ...

Changes since v1: (reworked from Huafei's series):

 - Fix inconsistencies in arm64 instruction output across llvm, capstone,
   and objdump disassembly backends.
 - Support arm64-specific addressing modes and operand formats. (Leo Yan)
 - Extend instruction tracking to support mov and add instructions,
   along with per-cpu and stack variables.
 - Include real-world examples in commit messages to demonstrate
   practical effects. (Namhyung Kim)
 - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
   https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/

Please let me know if you have any feedback.

Thanks,
Tengda

[1] https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
[2] https://developer.arm.com/documentation/102374/0103
[3] https://github.com/flynd/asmsheets/releases/tag/v8

---

Tengda Wu (16):
  perf llvm: Fix arm64 adrp instruction disassembly mismatch with
    objdump
  perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
  perf annotate-arm64: Generalize arm64_mov__parse to support standard
    operands
  perf annotate-arm64: Handle load and store instructions
  perf annotate: Introduce extract_op_location callback for
    arch-specific parsing
  perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
  perf annotate-arm64: Implement extract_op_location() callback
  perf annotate-arm64: Enable instruction tracking support
  perf annotate-arm64: Support load instruction tracking
  perf annotate-arm64: Support store instruction tracking
  perf annotate-arm64: Support stack variable tracking
  perf annotate-arm64: Support 'mov' instruction tracking
  perf annotate-arm64: Support 'add' instruction tracking
  perf annotate-arm64: Support 'adrp' instruction to track global
    variables
  perf annotate-arm64: Support per-cpu variable access tracking
  perf annotate-arm64: Support 'mrs' instruction to track 'current'
    pointer

 .../perf/util/annotate-arch/annotate-arm64.c  | 642 +++++++++++++++++-
 .../util/annotate-arch/annotate-powerpc.c     |  10 +
 tools/perf/util/annotate-arch/annotate-x86.c  |  88 ++-
 tools/perf/util/annotate-data.c               |  72 +-
 tools/perf/util/annotate-data.h               |   7 +-
 tools/perf/util/annotate.c                    | 108 +--
 tools/perf/util/annotate.h                    |  12 +
 tools/perf/util/capstone.c                    | 107 ++-
 tools/perf/util/disasm.c                      |   5 +
 tools/perf/util/disasm.h                      |   5 +
 .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
 tools/perf/util/dwarf-regs.c                  |   2 +-
 tools/perf/util/include/dwarf-regs.h          |   1 +
 tools/perf/util/llvm.c                        |  50 ++
 14 files changed, 984 insertions(+), 145 deletions(-)


base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
-- 
2.34.1

