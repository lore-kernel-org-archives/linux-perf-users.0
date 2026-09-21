Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081C367F25;
	Mon, 21 Sep 2026 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789974518; cv=none; b=U49DPTinm5jMhuYMvuETTQoK7ms3CNeNqxs6FEGe2ba5ZHTsE1kB9oe0p22vvtInyoWobkSxRWJlQawWHuJd83HY/oI4taN/U5jQbt0l32QhlqnNHitIRmNFJM65H+GG1sZG5j7wIYqqR8nFtiqcJZSlt8khS0Gpsek3SJShxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789974518; c=relaxed/simple;
	bh=7zrBWcZ3xozos4sVsadQL3CaVMoG2izERiVV7PZUOhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czc5Wqg/ahA05ghHFFqZ6aLQhi/LfFdcjimcSCGYOT4Cx4jK/SDV7tO+mP/qRm/uVzrR8u03o+8wl4Y6EbpuWmy7XUXx4vNGoODJFokPqv5AkIY1f7tj9wXp/JtKGq4MneqXGqmXyXLiU+rlVGdn2M9MK9peLr7GojbOwvLHOSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hpDpB0xkLzKHMhs;
	Mon, 21 Sep 2026 15:08:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 4F87440A22;
	Mon, 21 Sep 2026 15:08:24 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDHlyrj17Bq6kZyBA--.64269S2;
	Mon, 21 Sep 2026 15:08:20 +0800 (CST)
Message-ID: <fb6e2d61-7376-4006-ad87-0442c4e20e59@huaweicloud.com>
Date: Mon, 21 Sep 2026 15:08:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/26] perf arm64: Support data type profiling
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <aq41dlDILyJlw-77@z2> <846de1f4-6138-4548-ac44-c97e63b87c37@huaweicloud.com>
 <arDS7HeFy12HQYL1@x2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <arDS7HeFy12HQYL1@x2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDHlyrj17Bq6kZyBA--.64269S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Kr4rtFWxZw1rur1UGFy5CFg_yoW8WFW5to
	WSvFs3uw18JryrXa1jy34rAFy7Xws5uw13GrWUWwn8ua1Utay2gw1Ikw17WayfKr4FqF4k
	C3W8t3W7ZFyUJFn3n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUYc7kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6x
	kF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
	6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIa0PDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi Arnaldo,

On 2026/9/21 14:47, Arnaldo Carvalho de Melo wrote:
> On Sun, Sep 20, 2026 at 10:02:52AM +0800, Tengda Wu wrote:
>>
>>
>> On 2026/9/19 15:10, Namhyung Kim wrote:
>>> Hello,
>>>
>>> On Wed, Sep 16, 2026 at 01:29:14AM +0000, Tengda Wu wrote:
>>>> This patch series implements data type profiling support for arm64,
>>>> enabling 'perf annotate --data-type' to resolve memory locations and
>>>> variable types on arm64 platforms.
>>>>
>>>> The main changes since v5 include:
>>>> v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud.com/
>>>>
>>>> * __get_dwarf_regnum_arm64 optimization: compute directly based on character
>>>>   judgment, avoiding strtol calls. (Ian Rogers)
>>>>
>>>> * extract_op_location_arm64 issue fix: support parsing instructions such as
>>>>   'cmp x0, x1, lsl #3'.
>>>>
>>>> * Instruction tracking part, fixing issues pointed out by Sashiko, including:
>>>>   - adding TSR_KIND_POINTER handling for ldr.
>>>>   - premature returns in add and ldr causing percpu handling to be skipped.
>>>>   - adding a reg != -1 check for stack type propagation, etc.
>>>>
>>>> Patch organization
>>>> ==================
>>>>
>>>> The series is organized as follows:
>>>>
>>>> 1. Fix disassembly mismatches (Patches 01-02)
>>>>    Current perf annotate supports three disassembly backends: llvm,
>>>>    capstone, and objdump. On arm64, inconsistencies between the output
>>>>    of these backends (specifically llvm/capstone vs. objdump) often
>>>>    prevent the tracker from correctly identifying registers and offsets.
>>>>    These patches resolve these mismatches, ensuring consistent instruction
>>>>    parsing across all supported backends.
>>>>
>>>> 2. Infrastructure for arm64 operand parsing (Patches 03-09)
>>>>    These patches establish the necessary infrastructure for arm64-specific
>>>>    operand handling. This includes implementing new callbacks and data
>>>>    structures to manage arm64's unique addressing modes and register sets.
>>>>    This foundation is essential for the subsequent type-tracking logic.
>>>>
>>>> 3. ARM SPE event handling (Patches 10-11)
>>>>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
>>>>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>>>>    "instructions" event when data type profiling is enabled. Patch 11
>>>>    defaults  the synthesized event period to 1 for ARM SPE to fix zero
>>>>    'Percent' values in annotate output.
>>>
>>> Thanks for working on this!
>>>
>>> I think it's ready to merge up to this point.  The instruction tracking
>>> part needs more review.  I'll do that later but it'd be nice if ARM
>>> folks and Shuai could review it too.
>>>
>  
>> Yes, patches 01-11 are already ready.
> 
> I had to just do a minor fixup:
> 
> util/annotate-arch/annotate-arm64.c: In function ‘extract_op_location_arm64’:
> util/annotate-arch/annotate-arm64.c:385:19: error: assignment discards ‘const’ qualifier from pointer target type [-Werror=discarded-qualifiers]
>   385 |                 p = strchr(s, ']');
>       |                   ^
> cc1: all warnings being treated as errors
> 
> That 'p' var can't be made const so I casted the return of strchr
> instead, one-liner.
> 
> Thanks, applied to perf-tools-next, for v7.4.
> 
> - Arnaldo

Thanks for applying 01–11. Glad those are in.

Cheers,
Tengda

>  
>> For the instruction tracking part (patches 12-26), apart from the issues with
>> patches 21 and 25 mentioned by Sashiko, the rest is also ready for review.
>>
>> Regarding patches 21 and 25, I've posted the fixes I plan to make under the
>> respective patches. Please let me know if there are any concerns.
>>
>> Looking forward to your review.
>>
>> Best regards,
>> Tengda
>>
>>> Thanks,
>>> Namhyung
>>>
>>>>
>>>> 4. Core instruction tracking (Patches 12-26)
>>>>    These patches implement the core logic for type tracking on arm64,
>>>>    covering several key types of instructions, including:
>>>>    * Memory Access: ldr/str variants (including stack-based access).
>>>>    * Arithmetic & Data Processing: mov, add, and adrp.
>>>>    * Special Access: System register access (mrs) and per-cpu variable
>>>>      tracking.
>>>>
>>>> The implementation draws inspiration from the existing x86 logic while
>>>> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
>>>> perf annotate can successfully resolve memory locations and register types,
>>>> providing basic support for data type profiling on arm64 platforms.
>>>>
>>>> Example Result
>>>> ==============
>>>>
>>>> # perf mem record -a -K -- sleep 1
>>>> # perf annotate --data-type --stdio --type-stat
>>>> Annotate data type stats:
>>>> total 1138, ok 852 (74.9%), bad 286 (25.1%)
>>>> -----------------------------------------------------------
>>>>          6 : no_sym
>>>>         42 : no_var
>>>>        230 : no_typeinfo
>>>>          8 : bad_offset
>>>>        213 : insn_track
>>>>
>>>> Annotate type: 'struct page' in [kernel.kallsyms] (66948 samples):
>>>> ============================================================================
>>>>  Percent     offset       size  field
>>>>   100.00          0       0x40  struct page      {
>>>>     9.01          0        0x8      long unsigned int   flags;
>>>>    57.99        0x8       0x28      union        {
>>>>    57.99        0x8       0x28          struct   {
>>>>    33.00        0x8       0x10              union        {
>>>>    33.00        0x8       0x10                  struct list_head        lru {
>>>>    33.00        0x8        0x8                      struct list_head*   next;
>>>>     0.00       0x10        0x8                      struct list_head*   prev;
>>>>                                                 };
>>>>    33.00        0x8       0x10                  struct   {
>>>>    33.00        0x8        0x8                      void*       __filler;
>>>>     0.00       0x10        0x4                      unsigned int        mlock_count;
>>>>    ...
>>>>
>>>> Each patch's type profiling results are as follows:
>>>>
>>>> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
>>>> ------+----------------------------+--------+--------+-------------+------------+------------+------
>>>> 0011  | base (default spe period)  | 6      | 493    | -           | -          | -          | 56.2%
>>>> 0013  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
>>>> 0016  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
>>>> 0017  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
>>>> 0021  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
>>>> 0022  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
>>>> 0023  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
>>>> 0024  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
>>>> 0025  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
>>>> 0026  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%
>>>>
>>>> Limitations
>>>> ===========
>>>>
>>>> * SIMD/FP & SVE Vector Support:
>>>>   Data type profiling currently focuses on General-Purpose (GP) register
>>>>   operations. Vector/SIMD registers (v0-v31, d0-d31, q0-q31) and Scalable
>>>>   Vector Extension (SVE/SME) instructions are not tracked yet.
>>>>
>>>> * Regular Instructions Only:
>>>>   Only regular instructions are currently supported. Instructions following
>>>>   special rules or non-standard patterns are not supported yet. For example,
>>>>   load/store tracking only matches standard variants (ldr/ldur/ldar/ldp and
>>>>   str/stur/stlr/stp) with straightforward semantics; exclusive loads/stores
>>>>   (ldxr, stxr, etc.) and acquire/exclusive combination variants are excluded.
>>>>
>>>> * Compiler Prologue/Epilogue Code:
>>>>   As shown by the previous test results, approximately 14% of the failed
>>>>   type profiling results originate from compiler-generated prologue or
>>>>   epilogue code (e.g., ldp  x19, x20, [sp, #16]). These instructions manage
>>>>   callee-saved registers across function boundaries, propagating type
>>>>   context through these operations requires inter-procedural (cross-function)
>>>>   instruction analysis, which is currently unsupported by the local backward
>>>>   instruction tracker.
>>>>
>>>> Testing
>>>> =======
>>>>
>>>> Tested on arm64 (all passed):
>>>>
>>>>   # perf test -v "perf data type profiling tests"
>>>>   81: perf data type profiling tests                                                                  : Ok
>>>>
>>>>   === Test Summary ===
>>>>   Passed main tests : 1
>>>>   Passed subtests   : 0
>>>>   Skipped tests     : 0
>>>>   Failed tests      : 0
>>>>
>>>> Tested on x86. The profiling results show no change before/after applying
>>>> this patch series:
>>>>
>>>>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>>>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>>>
>>>> Changelog
>>>> =========
>>>> v5 -> v6:
>>>>   - v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud.com/
>>>>   - Fix a potential UAF issue with capstone sym_name.
>>>>   - Optimize __get_dwarf_regnum_arm64 to compute directly based on character
>>>>     judgment, avoiding strtol calls. (Ian Rogers)
>>>>   - Fix an issue in extract_op_location_arm64 when parsing instructions such as
>>>>     'cmp x0, x1, lsl #3'.
>>>>   - Fix several minor issues in instruction tracking. (Sashiko)
>>>> v4 -> v5:
>>>>   - v4: https://lore.kernel.org/all/20260808122400.2961238-1-wutengda@huaweicloud.com/
>>>>   - Introduce arch_get_reg_offset() to uniformly handle reg offset.
>>>>   - Add support for parsing extension type and shift amount in arm64 instructions.
>>>>   - Refine which instructions to track or skip. (Shuai Xue)
>>>>   - Rename dont_overlap to default_single_event_per_ip and use it in
>>>>     itrace_synth_opts__set_default(). (Adrian Hunter)
>>>>   - Introduce delete_stack_state() to clean up obsolete stack state. (Shuai Xue)
>>>>   - Normalize arch__dwarf_regnum() error return values. (Shuai Xue)
>>>>   - Drop canary support due to unresolved bugs.
>>>>   - Fix various minor issues, such as name memory leaks and header includes.
>>>> v3 -> v4:
>>>>   - v3: https://lore.kernel.org/all/20260701035355.752944-1-wutengda@huaweicloud.com/
>>>>   - Fix Capstone compilation failure.
>>>>   - Stop adding new pcrel_adrp_addr in LLVM; reuse pcrel_load_addr instead.
>>>>   - Fix parsing issue in arm64_mov__parse.
>>>>   - Add PC-relative load instruction parsing logic to arm64_ldst__parse,
>>>>     and introduce rstrip_space_and_comment to strip comments.
>>>>   - Remove wzr/xzr register parsing (not planning to handle this yet).
>>>>   - Add post-index addressing mode parsing for the '[base], reg' format.
>>>>   - Update built-in implementation of --itrace=i1i to deduplicate early
>>>>     during arm_spe_process_auxtrace_info.
>>>>   - Restrict the "default period to 1" behavior to ARM SPE, instead of
>>>>     applying it to all architectures.
>>>>   - Add register type tracking for function call instructions.
>>>>   - Add dual-register type tracking for load pair and store pair instructions.
>>>>   - Correct stack variable offset calculations.
>>>>   - Add type invalidation upon retry failure.
>>>>   - Reuse imm_value instead of introducing addr for 'adrp' instruction tracking.
>>>>   - Fix potential stale type resolution errors caused by TSR_KIND_GLOBAL_ADDR
>>>>     and TSR_KIND_CONST during stack passing.
>>>>   - Fix a strbuf memory leak during 'mrs' instruction tracking.
>>>>   - Fix stale dieoff issue when debug info changes.
>>>>   - Simplify add type propagation: only propagate offset/imm updates, leave
>>>>     type parsing to chk.
>>>> v2 -> v3:
>>>>   - v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
>>>>   - Instead of always parsing the left operand as src and the right operand as
>>>>     dst, set them based on the actual instruction definition. (Namhyung Kim)
>>>>   - Fix refcount leak in print_capstone_detail().
>>>>   - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov__parse().
>>>>   - Add example comments in arm64_ldst__parse().
>>>>   - Split arch__dwarf_regnum() changes into a separate commit.
>>>>   - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*.
>>>>   - Set caller-saved registers in init_type_state().
>>>>   - For instructions with addressing mode, always goto adjust_reg_index_state()
>>>>     at the end to update the src register state.
>>>>   - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions.
>>>>   - Invalidate dst register for all other unsupported instructions.
>>>>   - Verify type DIE is task_struct pointer before caching globally.
>>>>   - Enable --itrace=i1i by default for ARM SPE data type profiling in 'perf annotate'
>>>>     to avoid overlapping event counting for the same instruction. (James Clark)
>>>>   - Fix global variable type resolving error in check_matching_type(). (James Clark)
>>>>   - Address review comments from sashiko [1]:
>>>>     - Fix unconditional call to arch->extract_op_location()
>>>>     - Handle multi_regs correctly
>>>>     - Fix invalid register state in error path
>>>>     - Other misc fixes
>>>> v1 -> v2:
>>>>   - v1: https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>>>>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>>>>     and objdump disassembly backends.
>>>>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>>>>   - Extend instruction tracking to support mov and add instructions,
>>>>     along with per-cpu and stack variables.
>>>>   - Include real-world examples in commit messages to demonstrate
>>>>     practical effects. (Namhyung Kim)
>>>>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>>>>
>>>> Please let me know if you have any feedback.
>>>>
>>>> Thanks,
>>>> Tengda
>>>>
>>>> [1] https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com
>>>> [2] https://developer.arm.com/documentation/102374/0103
>>>> [3] https://github.com/flynd/asmsheets/releases/tag/v8
>>>>
>>>>
>>>> Tengda Wu (26):
>>>>   perf capstone: Symbolize address operands to match objdump on arm64
>>>>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>>>>     objdump
>>>>   perf annotate-arm64: Generalize arm64_mov__parse to support more
>>>>     instructions
>>>>   perf annotate-arm64: Handle load and store instructions
>>>>   perf annotate: Normalize arch__dwarf_regnum() error return values
>>>>   perf annotate: Introduce extract_op_location callback for
>>>>     arch-specific parsing
>>>>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>>>>   perf annotate: Adapt arch__dwarf_regnum() for arm64
>>>>   perf annotate-arm64: Implement extract_op_location() callback
>>>>   perf annotate: Default to --itrace=i1i for data type profiling
>>>>   perf arm-spe: Set default synthesized event period to 1
>>>>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>>>>   perf annotate-arm64: Enable instruction tracking support
>>>>   perf annotate-data: Add arch_get_reg_offset helper
>>>>   perf annotate-arm64: Track return type after call instructions
>>>>   perf annotate-arm64: Support load instruction tracking
>>>>   perf annotate-arm64: Support store instruction tracking
>>>>   perf annotate-data: Expand type_state_reg imm_value to u64
>>>>   perf annotate-data: Track imm_value for stack variables
>>>>   perf annotate-x86: Delete stale stack state on store of untracked
>>>>     register
>>>>   perf annotate-arm64: Support stack variable tracking
>>>>   perf annotate-arm64: Support 'mov' instruction tracking
>>>>   perf annotate-arm64: Support 'add' instruction tracking
>>>>   perf annotate-arm64: Support 'adrp' instruction to track global
>>>>     variables
>>>>   perf annotate-arm64: Support per-cpu variable access tracking
>>>>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>>>     pointer
>>>>
>>>>  tools/perf/builtin-annotate.c                 |    8 +
>>>>  .../perf/util/annotate-arch/annotate-arm64.c  | 1211 ++++++++++++++++-
>>>>  .../util/annotate-arch/annotate-powerpc.c     |    9 +
>>>>  tools/perf/util/annotate-arch/annotate-x86.c  |  117 +-
>>>>  tools/perf/util/annotate-data.c               |  205 ++-
>>>>  tools/perf/util/annotate-data.h               |   14 +-
>>>>  tools/perf/util/annotate.c                    |  108 +-
>>>>  tools/perf/util/annotate.h                    |   63 +
>>>>  tools/perf/util/arm-spe.c                     |   16 +-
>>>>  tools/perf/util/auxtrace.c                    |   12 +-
>>>>  tools/perf/util/auxtrace.h                    |    7 +-
>>>>  tools/perf/util/capstone.c                    |  186 ++-
>>>>  tools/perf/util/cs-etm.c                      |    2 +-
>>>>  tools/perf/util/disasm.c                      |    5 +
>>>>  tools/perf/util/disasm.h                      |    5 +
>>>>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |   25 +
>>>>  tools/perf/util/dwarf-regs.c                  |    2 +-
>>>>  tools/perf/util/include/dwarf-regs.h          |    1 +
>>>>  tools/perf/util/intel-bts.c                   |    2 +-
>>>>  tools/perf/util/intel-pt.c                    |    3 +-
>>>>  tools/perf/util/llvm.c                        |   52 +-
>>>>  21 files changed, 1831 insertions(+), 222 deletions(-)
>>>>
>>>>
>>>> base-commit: e6e35979777d646fe3c7c94dca7dd32fb25d45f4
>>>> -- 
>>>> 2.34.1
>>>>
>>

