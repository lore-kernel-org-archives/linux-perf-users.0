Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75588396588;
	Thu,  9 Jul 2026 08:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584092; cv=none; b=RisLMRVjknHE6qbhKHIr2B8v6mSyfCOP1n+b2lwxNK1bJ8NpOc/7CvHlsDlvUWjorvZaejwNzWLSl6KXY/dW4jeUpjJZzV5Q8KlTM0r3XjVHp39Z27I9CbrKrVEzCrSJYlulCzS5loUPKmdheAKBoaT72YqUPxJwmXM6xKWO9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584092; c=relaxed/simple;
	bh=i0Kfr/xO1WjvEAE2BQmV7SEo8KCYE6pIyyyOMGcIdEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b2oWXfXCVJNvnv4Yw4jq2O/66j7++ZMkdnVtf1ai2pUa6GhoGly8Xbkw6rqv6KuTvbBXi5XlBtrOFrQdEkaVsSjH/lsUtYeHIrDE7dXDj0qCFiDBN87e2COiN67vNmtjO9aw2+Oz8VKYesD7K8Ve56JIPBGE2ZtZl3lTh2tegAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwnTm6SbfzYQtpm;
	Thu,  9 Jul 2026 16:01:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4F8504057D;
	Thu,  9 Jul 2026 16:01:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHIm9QVU9q6HdeAg--.28623S2;
	Thu, 09 Jul 2026 16:01:21 +0800 (CST)
Message-ID: <9bfa380f-eacc-4e31-a21e-603a0c43f137@huaweicloud.com>
Date: Thu, 9 Jul 2026 16:01:20 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/21] perf arm64: Support data type profiling
To: Namhyung Kim <namhyung@kernel.org>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
 Li Huafei <lihuafei1@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 leo.yan@linux.dev, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <ak83j6sZGGqwW8Ak@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ak83j6sZGGqwW8Ak@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHIm9QVU9q6HdeAg--.28623S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KFWUAFW5Zw4UXF43WF1DGFg_yoWDKFW8pF
	ZxCayfGr4UJrWYgwnxX3yxXFyagw4fJa48Gryrt34Skr1jyF95tFZ7tF1SkFWkGrZ8Cw12
	yr4qyF15Zr1rAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/9 13:54, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jul 01, 2026 at 03:53:34AM +0000, Tengda Wu wrote:
>> This patch series implements data type profiling support for arm64,
>> enabling 'perf annotate --data-type' to resolve memory locations and
>> variable types on arm64 platforms.
>>
>> The main changes since v2 include:
>> v2: https://lore.kernel.org/all/20260403094800.1418825-1-wutengda@huaweicloud.com/
>>
>> * Reworking operand parsing, where src/dst are now set based on the
>>   actual instruction definition rather than always treating the left
>>   operand as src and the right as dst (Namhyung Kim).
>>
>> * Register state handling has been improved, with better support for
>>   TSR_KIND_CONST and proper invalidation of dst for unsupported
>>   instructions.
>>
>> * Several bug fixes are included, such as fixing a refcount leak, a
>>   global type resolving error (James Clark), unconditional call to
>>   arch->extract_op_location() (sashiko [1]). --itrace=i1i is now enabled
>>   by default for ARM SPE data type profiling to avoid overlapping
>>   events (James Clark).
>>
>> Patch organization
>> ==================
>>
>> The series is organized as follows:
>>
>> 1. Fix refcount leak in print_capstone_detail(). (Patches 01)
>>
>> 2. Fix disassembly mismatches (Patches 02-03)
>>    Current perf annotate supports three disassembly backends: llvm,
>>    capstone, and objdump. On arm64, inconsistencies between the output
>>    of these backends (specifically llvm/capstone vs. objdump) often
>>    prevent the tracker from correctly identifying registers and offsets.
>>    These patches resolve these mismatches, ensuring consistent instruction
>>    parsing across all supported backends.
>>
>> 3. Infrastructure for arm64 operand parsing (Patches 04-09)
>>    These patches establish the necessary infrastructure for arm64-specific
>>    operand handling. This includes implementing new callbacks and data
>>    structures to manage arm64's unique addressing modes and register sets.
>>    This foundation is essential for the subsequent type-tracking logic.
>>
>> 4. ARM SPE even handling (Patches 10-11)
>>    Patch 10 automatically deduplicates overlapping ARM SPE events (e.g.,
>>    l1d-miss, tlb-access) in 'perf annotate' by retaining only the
>>    "instructions" event when data type profiling is enabled. Patch 11
>>    defaults the itrace period to 1 for PERF_ITRACE_PERIOD_INSTRUCTIONS
>>    to fix zero 'Percent' values in annotate output.
>>
>> 5. Core instruction tracking (Patches 12-21)
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
>> total 1138, ok 876 (77.0%), bad 262 (23.0%)
>> -----------------------------------------------------------
>>          6 : no_sym
>>         42 : no_var
>>        206 : no_typeinfo
>>          8 : bad_offset
>>        237 : insn_track
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
>> Patch | no_sym | no_var | no_typeinfo | bad_offset | insn_track | ok(%)
>> ------+--------+--------+-------------+------------+------------+------
>> 0010  | 6      | 493    | -           | -          | -          | 56.2%
>> 0013  | 6      | 42     | 438         | 2          | 11         | 57.1%
>> 0014  | 6      | 42     | 399         | 1          | 51         | 60.6%
>> 0015  | 6      | 42     | 398         | 1          | 52         | 60.7%
>> 0016  | 6      | 42     | 393         | 1          | 57         | 61.2%
>> 0017  | 6      | 42     | 376         | 3          | 72         | 62.5%
>> 0018  | 6      | 42     | 305         | 7          | 139        | 68.4%
>> 0019  | 6      | 42     | 218         | 8          | 225        | 75.9%
>> 0020  | 6      | 42     | 217         | 8          | 226        | 76.0%
>> 0021  | 6      | 42     | 206         | 8          | 237        | 77.0%
>>
>> A few notes:
>> * Capstone fails to build when rebased to the base-commit (known issue,
>>   not yet fixed [4]). I disabled it locally for testing.
>> * Among the remaining 23% bad annotation, about 14% comes from compiler
>>   generated prologue or epilogue code (e.g., stp	x21, x22, [sp, #32]).
>>   No solution has been identified for this so far.
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
>>
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
> Thanks for working on this!  The patchset looks well-organized and it's
> nice that you added some real world examples for better understanding.
> 
> I think Sashiko found many real issues that need to be handled.  Let's
> fix them first.  I'll leave comment on the patches separately.
> 
> Thanks,
> Namhyung
> 

Thanks! I'll incorporate all the feedback and work on the fixes. Looking forward
to sending the next revision.

Thanks,
Tengda

>>
>> [1] https://sashiko.dev/#/patchset/20260403094800.1418825-1-wutengda%40huaweicloud.com
>> [2] https://developer.arm.com/documentation/102374/0103
>> [3] https://github.com/flynd/asmsheets/releases/tag/v8
>> [4] https://lore.kernel.org/all/aiCgbmUtlMCM4Xzt@x1/#t
>>
>>
>> Tengda Wu (21):
>>   perf capstone: Fix kernel map reference count leak
>>   perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>>   perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>>     objdump
>>   perf annotate-arm64: Generalize arm64_mov__parse to support more
>>     instructions
>>   perf annotate-arm64: Handle load and store instructions
>>   perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>>   perf annotate: Adapt arch__dwarf_regnum() for arm64
>>   perf annotate: Introduce extract_op_location callback for
>>     arch-specific parsing
>>   perf annotate-arm64: Implement extract_op_location() callback
>>   perf annotate: Deduplicate overlapping ARM SPE events for data type
>>     profiling
>>   perf auxtrace: Set default period to 1 for
>>     PERF_ITRACE_PERIOD_INSTRUCTIONS type
>>   perf annotate-data: Extract invalidate_reg_state() as a common helper
>>   perf annotate-arm64: Enable instruction tracking support
>>   perf annotate-arm64: Support load instruction tracking
>>   perf annotate-arm64: Support store instruction tracking
>>   perf annotate-arm64: Support stack variable tracking
>>   perf annotate-arm64: Support 'mov' instruction tracking
>>   perf annotate-arm64: Support 'add' instruction tracking
>>   perf annotate-arm64: Support 'adrp' instruction to track global
>>     variables
>>   perf annotate-arm64: Support per-cpu variable access tracking
>>   perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>     pointer
>>
>>  tools/perf/builtin-annotate.c                 |  13 +
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 901 +++++++++++++++++-
>>  .../util/annotate-arch/annotate-powerpc.c     |  10 +
>>  tools/perf/util/annotate-arch/annotate-x86.c  |  97 +-
>>  tools/perf/util/annotate-data.c               |  77 +-
>>  tools/perf/util/annotate-data.h               |   8 +-
>>  tools/perf/util/annotate.c                    | 108 +--
>>  tools/perf/util/annotate.h                    |  12 +
>>  tools/perf/util/arm-spe.c                     |   1 +
>>  tools/perf/util/auxtrace.c                    |   6 +
>>  tools/perf/util/capstone.c                    | 144 ++-
>>  tools/perf/util/disasm.c                      |   5 +
>>  tools/perf/util/disasm.h                      |   5 +
>>  .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>>  tools/perf/util/dwarf-regs.c                  |   2 +-
>>  tools/perf/util/include/dwarf-regs.h          |   1 +
>>  tools/perf/util/llvm.c                        |  50 +
>>  17 files changed, 1307 insertions(+), 153 deletions(-)
>>
>>
>> base-commit: 7de6ae9e12207ec146f2f3f1e58d1a99317e88bc
>> -- 
>> 2.34.1
>>

