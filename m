Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C854AF67A;
	Wed, 16 Sep 2026 11:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558596; cv=none; b=CTef4NQHsVmwgtazSDLOhLwb+fTZoalXDOh8wWMBgvr0r3QkANPpv7Ii1IluY7E3ZdBiEY2AOY+RIKNk9XrPgkQ0IIE1e83v309iVq8X3lj8O5/Grd/kQNP23/ihn6Fmp3EB15Ljy1T27r2HJUmBv1mLWDvoAkShQMMGT9xhsxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558596; c=relaxed/simple;
	bh=dlDYh7l6mEAamAjGZWKIHcXe5ju0oYI40ADbCBs4rP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hqf+Ffgv6U+SgJO83VQTF6tfHmfK0aixGXUORebvqdRhi7e4s3/OPoY0nUoC/Aycxlg+TAORjdI1frBcCSklmPjXwMk/i2/edcO7ullmMnWiknpp2rNM70Wb4s/Wsu44Hgg2nemc3GtlfdJQ9b+t5IC2XDvFKk1NxXWW4ObshMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hlGzw2ZwPzKHMnk;
	Wed, 16 Sep 2026 19:36:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A40C84058F;
	Wed, 16 Sep 2026 19:36:26 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgBndms5f6pq_CwHAg--.33851S2;
	Wed, 16 Sep 2026 19:36:26 +0800 (CST)
Message-ID: <2cb96f76-17c7-43a4-bfad-17f51b0193db@huaweicloud.com>
Date: Wed, 16 Sep 2026 19:36:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/26] perf arm64: Support data type profiling
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <CAP-5=fWUXwr3asB4HYdDdHCGV8wx+VMC8Xq-BRipU6175Roo7Q@mail.gmail.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <CAP-5=fWUXwr3asB4HYdDdHCGV8wx+VMC8Xq-BRipU6175Roo7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBndms5f6pq_CwHAg--.33851S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ur17Jw4xAF1kGFyfKryDWrg_yoWkCF13pF
	Z3CayfJF4UJrW8KwsrX39rur13ta1rJ3yUGr1rK34Skw1j9F1vyFs7tF1rZFyDCrWDCw1I
	qr4qy3Z8ZF1jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUxo
	7KDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/16 12:17, Ian Rogers wrote:
> On Tue, Sep 15, 2026 at 6:30 PM Tengda Wu <wutengda@huaweicloud.com> wrote:
>>
>> This patch series implements data type profiling support for arm64,
>> enabling 'perf annotate --data-type' to resolve memory locations and
>> variable types on arm64 platforms.
>>
>> The main changes since v5 include:
>> v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud.com/
>>
>> * __get_dwarf_regnum_arm64 optimization: compute directly based on character
>>   judgment, avoiding strtol calls. (Ian Rogers)
>>
>> * extract_op_location_arm64 issue fix: support parsing instructions such as
>>   'cmp x0, x1, lsl #3'.
>>
>> * Instruction tracking part, fixing issues pointed out by Sashiko, including:
>>   - adding TSR_KIND_POINTER handling for ldr.
>>   - premature returns in add and ldr causing percpu handling to be skipped.
>>   - adding a reg != -1 check for stack type propagation, etc.
>>
>> Patch organization
>> ==================
>>
>> The series is organized as follows:
>>
>> 1. Fix disassembly mismatches (Patches 01-02)
>>    Current perf annotate supports three disassembly backends: llvm,
>>    capstone, and objdump. On arm64, inconsistencies between the output
>>    of these backends (specifically llvm/capstone vs. objdump) often
>>    prevent the tracker from correctly identifying registers and offsets.
>>    These patches resolve these mismatches, ensuring consistent instruction
>>    parsing across all supported backends.
>>
>> 2. Infrastructure for arm64 operand parsing (Patches 03-09)
>>    These patches establish the necessary infrastructure for arm64-specific
>>    operand handling. This includes implementing new callbacks and data
>>    structures to manage arm64's unique addressing modes and register sets.
>>    This foundation is essential for the subsequent type-tracking logic.
>>
>> 3. ARM SPE event handling (Patches 10-11)
>>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
>>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>>    "instructions" event when data type profiling is enabled. Patch 11
>>    defaults  the synthesized event period to 1 for ARM SPE to fix zero
>>    'Percent' values in annotate output.
>>
>> 4. Core instruction tracking (Patches 12-26)
>>    These patches implement the core logic for type tracking on arm64,
>>    covering several key types of instructions, including:
>>    * Memory Access: ldr/str variants (including stack-based access).
>>    * Arithmetic & Data Processing: mov, add, and adrp.
>>    * Special Access: System register access (mrs) and per-cpu variable
>>      tracking.
>>
>> The implementation draws inspiration from the existing x86 logic while
>> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
>> perf annotate can successfully resolve memory locations and register types,
>> providing basic support for data type profiling on arm64 platforms.
>>
>> Example Result
>> ==============
>>
>> # perf mem record -a -K -- sleep 1
>> # perf annotate --data-type --stdio --type-stat
>> Annotate data type stats:
>> total 1138, ok 852 (74.9%), bad 286 (25.1%)
>> -----------------------------------------------------------
>>          6 : no_sym
>>         42 : no_var
>>        230 : no_typeinfo
>>          8 : bad_offset
>>        213 : insn_track
>>
>> Annotate type: 'struct page' in [kernel.kallsyms] (66948 samples):
>> ============================================================================
>>  Percent     offset       size  field
>>   100.00          0       0x40  struct page      {
>>     9.01          0        0x8      long unsigned int   flags;
>>    57.99        0x8       0x28      union        {
>>    57.99        0x8       0x28          struct   {
>>    33.00        0x8       0x10              union        {
>>    33.00        0x8       0x10                  struct list_head        lru {
>>    33.00        0x8        0x8                      struct list_head*   next;
>>     0.00       0x10        0x8                      struct list_head*   prev;
>>                                                 };
>>    33.00        0x8       0x10                  struct   {
>>    33.00        0x8        0x8                      void*       __filler;
>>     0.00       0x10        0x4                      unsigned int        mlock_count;
>>    ...
>>
>> Each patch's type profiling results are as follows:
>>
>> Patch | Feature                    | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
>> ------+----------------------------+--------+--------+-------------+------------+------------+------
>> 0011  | base (default spe period)  | 6      | 493    | -           | -          | -          | 56.2%
>> 0013  | enable insn tracking       | 6      | 42     | 437         | 2          | 12         | 57.2%
>> 0016  | support 'load' insn        | 6      | 42     | 398         | 1          | 52         | 60.7%
>> 0017  | support 'store' insn       | 6      | 42     | 398         | 1          | 52         | 60.7%
>> 0021  | support stack variable     | 6      | 42     | 391         | 1          | 59         | 61.3%
>> 0022  | support 'mov' insn         | 6      | 42     | 372         | 3          | 76         | 62.8%
>> 0023  | support 'add' insn         | 6      | 42     | 318         | 7          | 126        | 67.2%
>> 0024  | support 'adrp' insn        | 6      | 42     | 238         | 8          | 205        | 74.2%
>> 0025  | support per-cpu variable   | 6      | 42     | 233         | 8          | 210        | 74.6%
>> 0026  | support 'mrs' insn         | 6      | 42     | 230         | 8          | 213        | 74.9%
>>
>> Limitations
>> ===========
>>
>> * SIMD/FP & SVE Vector Support:
>>   Data type profiling currently focuses on General-Purpose (GP) register
>>   operations. Vector/SIMD registers (v0-v31, d0-d31, q0-q31) and Scalable
>>   Vector Extension (SVE/SME) instructions are not tracked yet.
>>
>> * Regular Instructions Only:
>>   Only regular instructions are currently supported. Instructions following
>>   special rules or non-standard patterns are not supported yet. For example,
>>   load/store tracking only matches standard variants (ldr/ldur/ldar/ldp and
>>   str/stur/stlr/stp) with straightforward semantics; exclusive loads/stores
>>   (ldxr, stxr, etc.) and acquire/exclusive combination variants are excluded.
>>
>> * Compiler Prologue/Epilogue Code:
>>   As shown by the previous test results, approximately 14% of the failed
>>   type profiling results originate from compiler-generated prologue or
>>   epilogue code (e.g., ldp  x19, x20, [sp, #16]). These instructions manage
>>   callee-saved registers across function boundaries, propagating type
>>   context through these operations requires inter-procedural (cross-function)
>>   instruction analysis, which is currently unsupported by the local backward
>>   instruction tracker.
>>
>> Testing
>> =======
>>
>> Tested on arm64 (all passed):
>>
>>   # perf test -v "perf data type profiling tests"
>>   81: perf data type profiling tests                                                                  : Ok
>>
>>   === Test Summary ===
>>   Passed main tests : 1
>>   Passed subtests   : 0
>>   Skipped tests     : 0
>>   Failed tests      : 0
>>
>> Tested on x86. The profiling results show no change before/after applying
>> this patch series:
>>
>>   before : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>   after  : total 880, ok 711 (80.8%), bad 169 (19.2%)
>>
>> Changelog
>> =========
>> v5 -> v6:
>>   - v5: https://lore.kernel.org/all/cover.1788872630.git.wutengda@huaweicloud.com/
>>   - Fix a potential UAF issue with capstone sym_name.
>>   - Optimize __get_dwarf_regnum_arm64 to compute directly based on character
>>     judgment, avoiding strtol calls. (Ian Rogers)
>>   - Fix an issue in extract_op_location_arm64 when parsing instructions such as
>>     'cmp x0, x1, lsl #3'.
>>   - Fix several minor issues in instruction tracking. (Sashiko)
>> v4 -> v5:
>>   - v4: https://lore.kernel.org/all/20260808122400.2961238-1-wutengda@huaweicloud.com/
>>   - Introduce arch_get_reg_offset() to uniformly handle reg offset.
>>   - Add support for parsing extension type and shift amount in arm64 instructions.
>>   - Refine which instructions to track or skip. (Shuai Xue)
>>   - Rename dont_overlap to default_single_event_per_ip and use it in
>>     itrace_synth_opts__set_default(). (Adrian Hunter)
>>   - Introduce delete_stack_state() to clean up obsolete stack state. (Shuai Xue)
>>   - Normalize arch__dwarf_regnum() error return values. (Shuai Xue)
>>   - Drop canary support due to unresolved bugs.
>>   - Fix various minor issues, such as name memory leaks and header includes.
>> v3 -> v4:
>>   - v3: https://lore.kernel.org/all/20260701035355.752944-1-wutengda@huaweicloud.com/
>>   - Fix Capstone compilation failure.
>>   - Stop adding new pcrel_adrp_addr in LLVM; reuse pcrel_load_addr instead.
>>   - Fix parsing issue in arm64_mov__parse.
>>   - Add PC-relative load instruction parsing logic to arm64_ldst__parse,
>>     and introduce rstrip_space_and_comment to strip comments.
>>   - Remove wzr/xzr register parsing (not planning to handle this yet).
>>   - Add post-index addressing mode parsing for the '[base], reg' format.
>>   - Update built-in implementation of --itrace=i1i to deduplicate early
>>     during arm_spe_process_auxtrace_info.
>>   - Restrict the "default period to 1" behavior to ARM SPE, instead of
>>     applying it to all architectures.
>>   - Add register type tracking for function call instructions.
>>   - Add dual-register type tracking for load pair and store pair instructions.
>>   - Correct stack variable offset calculations.
>>   - Add type invalidation upon retry failure.
>>   - Reuse imm_value instead of introducing addr for 'adrp' instruction tracking.
>>   - Fix potential stale type resolution errors caused by TSR_KIND_GLOBAL_ADDR
>>     and TSR_KIND_CONST during stack passing.
>>   - Fix a strbuf memory leak during 'mrs' instruction tracking.
>>   - Fix stale dieoff issue when debug info changes.
>>   - Simplify add type propagation: only propagate offset/imm updates, leave
>>     type parsing to chk.
>> v2 -> v3:
>>   - v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
>>   - Instead of always parsing the left operand as src and the right operand as
>>     dst, set them based on the actual instruction definition. (Namhyung Kim)
>>   - Fix refcount leak in print_capstone_detail().
>>   - Remove useless '<' check when parsing 'addr <symbol>' in arm64_mov__parse().
>>   - Add example comments in arm64_ldst__parse().
>>   - Split arch__dwarf_regnum() changes into a separate commit.
>>   - Rename annotated_addr_mode enum: INSN_ADDR_* -> PERF_ADDR_MODE_*.
>>   - Set caller-saved registers in init_type_state().
>>   - For instructions with addressing mode, always goto adjust_reg_index_state()
>>     at the end to update the src register state.
>>   - Handle TSR_KIND_CONST registers for 'mov' and 'add' instructions.
>>   - Invalidate dst register for all other unsupported instructions.
>>   - Verify type DIE is task_struct pointer before caching globally.
>>   - Enable --itrace=i1i by default for ARM SPE data type profiling in 'perf annotate'
>>     to avoid overlapping event counting for the same instruction. (James Clark)
>>   - Fix global variable type resolving error in check_matching_type(). (James Clark)
>>   - Address review comments from sashiko [1]:
>>     - Fix unconditional call to arch->extract_op_location()
>>     - Handle multi_regs correctly
>>     - Fix invalid register state in error path
>>     - Other misc fixes
>> v1 -> v2:
>>   - v1: https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>>     and objdump disassembly backends.
>>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>>   - Extend instruction tracking to support mov and add instructions,
>>     along with per-cpu and stack variables.
>>   - Include real-world examples in commit messages to demonstrate
>>     practical effects. (Namhyung Kim)
>>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>>
>> Please let me know if you have any feedback.
> 
> There's a sashiko finding on patch 21 that looks like it should be
> addressed. For the series:
> 
> Reviewed-by: Ian Rogers <irogers@google.com>
> 

Thanks Ian! Will address the patch 21 sashiko finding in next version.

Thanks,
Tengda

