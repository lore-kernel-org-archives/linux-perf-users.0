Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C443AEF2A;
	Mon, 27 Apr 2026 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777280605; cv=none; b=WBAvjZ+oI/XPUIkRbEaZ5r/c7epMYmCeq+qxGeaXbZ7gj0p2pmY6UPHWML2SeQGx/znJgtP5fHEf+HRJoWFHb5ydUSzh2ffkiV5XZVdaXF29/PeQCV2SLnkFL6oRWKTDZJQSjB6u0GQPtqz9HoCOTJdTa8Ew7AkaxA5CQM9quUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777280605; c=relaxed/simple;
	bh=1HAIqMulJlaX5pZPV4bvO2YclNifrs7VtonXR7h2EMw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F5ZUpclm9geZketO9N8IAyLJn0P34781HvJMk7dFKobSwTR/F0WievLiPeyVFOMPfYjDWDdm2THcJVaT3w26CP+OJT8fHqFLAg6JoeCFVRJyrRNYgTuY5/vAwpNyCSS3fHKrR/lGsTEhHMyFLU/7r/kT+upIIEZRuCLnYoBR/jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g3xt5543kzYQtGg;
	Mon, 27 Apr 2026 16:43:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 9D5D84056B;
	Mon, 27 Apr 2026 16:43:30 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgCHnFieIe9pYbPkAA--.50528S2;
	Mon, 27 Apr 2026 16:43:28 +0800 (CST)
Message-ID: <a2dbb903-b1cc-4216-a1ec-6d04a58cca3f@huaweicloud.com>
Date: Mon, 27 Apr 2026 16:43:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tengda Wu <wutengda@huaweicloud.com>
Subject: Re: [PATCH v2 00/16] perf arm64: Support data type profiling
To: James Clark <james.clark@linaro.org>
Cc: Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <eb00bda8-7ad7-4101-8fa6-1ecbb2f2fb82@linaro.org>
Content-Language: en-US
In-Reply-To: <eb00bda8-7ad7-4101-8fa6-1ecbb2f2fb82@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHnFieIe9pYbPkAA--.50528S2
X-Coremail-Antispam: 1UD129KBjvAXoW3KrW3Cry5WFWDuw4UKF1ftFb_yoW8GryUXo
	Wj9r15Cr15Jr45Kr1UAr18Jr15Xr1UJr1DJr1UGr13Gr18JF1UJ34UJryUG3y3Jr4rGF1U
	Jr1UJw1UJFyUJr18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY27kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi James,

Sorry for the late reply.

On 2026/4/22 17:50, James Clark wrote:
> 
> 
> On 03/04/2026 10:47, Tengda Wu wrote:
>> This patch series implements data type profiling support for arm64,
>> building upon the foundational work previously contributed by Huafei [1].
>> While the initial version laid the groundwork for arm64 data type analysis,
>> this series iterates on that work by refining instruction parsing and
>> extending support for core architectural features.
>>
>> The series is organized as follows:
>>
>> 1. Fix disassembly mismatches (Patches 01-02)
>>     Current perf annotate supports three disassembly backends: llvm,
>>     capstone, and objdump. On arm64, inconsistencies between the output
>>     of these backends (specifically llvm/capstone vs. objdump) often
>>     prevent the tracker from correctly identifying registers and offsets.
>>     These patches resolve these mismatches, ensuring consistent instruction
>>     parsing across all supported backends.
> 
> Did you try recording the Perf datasym workload? With llvm-objdump I only get hits on data1 and not data2. And with binutils I don't get any hits on that struct at all, although the rest of the samples in ld-linux-aarch64.so etc look roughly the same between binutils and llvm. I would have thought such a simple example like datasym would work with both.> 
>  $ perf record -e arm_spe_0/load_filter=1,store_filter=1,
>     min_latency=30/u -c 10000 -- perf test -w datasym
> 
>  $ perf annotate --data-type --type-stat --itrace=i1i --stdio
> 
> With llvm-objdump-14:
> 
>   Annotate data type stats:
>   total 25, ok 19 (76.0%), bad 6 (24.0%)
>   -----------------------------------------------------------
>          1 : no_sym
>          1 : no_mem_ops
>          3 : no_var
>          1 : no_typeinfo
>          9 : insn_track
> 
>   Annotate type: 'struct buf' in build/local/perf (6663 samples):
>   ===============================================================
>    Percent     offset       size  field
>     100.00          0       0x40  struct buf       {
>     100.00          0        0x1      char        data1;
>       0.00        0x1       0x37      char[]      reserved;
>       0.00       0x38        0x1      char        data2;
>                                 };
> 
> 
> 
> With binutils that entry is missing:
> 
>   Annotate data type stats:
>   total 25, ok 14 (56.0%), bad 11 (44.0%)
>   -----------------------------------------------------------
>          1 : no_sym
>          1 : no_cuinfo
>          3 : no_var
>          6 : no_typeinfo
>          4 : insn_track
> 
> ...
> 

To clarify, perf annotate currently supports three disassembly backends:

1) libllvm, 2) libcapstone, and 3) objdump.

When you compared LLVM and binutils, are you referring to switching the
backend from _libllvm_ to _objdump_?

If so, my local results are actually the opposite:

1. Using libllvm: the 'struct buf' entry is missing.
2. Using objdump: the entry is present, but it only hits data1, not data2.

For issue 1, the root cause is in llvm_name_for_data() within
tools/perf/util/llvm.c when parsing ADRP symbols. It seems these ADRP
address symbols in userspace consistently fail to resolve, preventing
the name from appearing in disasm_buf.

Subsequently, in arm64_mov__parse, an unnecessary '<' character check
(as noted by Namhyung) prevents the address in the ADRP instruction
from being extracted correctly. This ultimately causes the instruction
tracking to fail to identify the type. I will remove the '<' check
in arm64_mov__parse(), which should resolve this issue.

> 
> But with the following patch I get plausible output for datasym with llvm where both entries in the struct have hits. It looks like you need to add the offset when calling get_global_var_type() for TSR_KIND_GLOBAL_ADDR otherwise all entries point to the first member of the struct:
> 
>   Annotate data type stats:
>   total 4, ok 2 (50.0%), bad 2 (50.0%)
>   -----------------------------------------------------------
>          1 : no_sym
>          1 : no_typeinfo
>          2 : insn_track
> 
>   Annotate type: 'struct buf' in build/local/perf (35 samples):
>   =====================================================================
>    Percent     offset       size  field
>     100.00          0       0x39  struct buf       {
>      40.00          0        0x1      char        data1;
>       0.00        0x1       0x37      char[]      reserved;
>      60.00       0x38        0x1      char        data2;
>                                 };
> 
> 
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 7161417d1c76..0e5825121227 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1287,7 +1287,9 @@ static enum type_match_result check_matching_type(struct type_state *state,
>                  * The register holds the address of a global variable.  Try to
>                  * find the variable by the address and get its type.
>                  */
> -               if (get_global_var_type(cu_die, dloc, dloc->ip, state->regs[reg].addr,
> +               var_addr = state->regs[reg].addr + dloc->op->offset;
> +
> +               if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
>                                         &var_offset, type_die)) {
>                         dloc->type_offset = var_offset;
> 
> 

For issue 2 above, I checked with --code-with-type and found that the
instruction missing data2 is an LDR with an offset, which was indeed
overlooked. Thank you for providing the fix; I will include it in v3.

    0.00 :   1fc030: adrp    x0, 61e000 <fake_callchains+0xb90>
    0.00 :   1fc034: add     x0, x0, #0x440
    0.60 :   1fc038: ldrb    w0, [x0, #56]              # data-type: struct buf +0 (data1)

Best Regards,
Tengda

>>
>> 2. Infrastructure for arm64 operand parsing (Patches 03-07)
>>     These patches establish the necessary infrastructure for arm64-specific
>>     operand handling. This includes implementing new callbacks and data
>>     structures to manage arm64's unique addressing modes and register sets.
>>     This foundation is essential for the subsequent type-tracking logic.
>>
>> 3. Core instruction tracking (Patches 08-16)
>>     These patches implement the core logic for type tracking on arm64,
>>     covering a wide range of instructions including:
>>
>>     * Memory Access: ldr/str variants (including stack-based access).
>>     * Arithmetic & Data Processing: mov, add, and adrp.
>>     * Special Access: System register access (mrs) and per-cpu variable
>>       tracking.
>>
>> The implementation draws inspiration from the existing x86 logic while
>> adapting it to the nuances of the AArch64 ISA [2][3]. With these changes,
>> perf annotate can successfully resolve memory locations and register
>> types, enabling comprehensive data type profiling on arm64 platforms.
>>
>> Example Result
>> ==============
>>
>> # perf mem record -a -K -- sleep 1
>> # perf annotate --data-type --type-stat --stdio
>> Annotate data type stats:
>> total 6204, ok 5091 (82.1%), bad 1113 (17.9%)
>> -----------------------------------------------------------
>>          29 : no_sym
>>         196 : no_var
>>         806 : no_typeinfo
>>          82 : bad_offset
>>        1370 : insn_track
>>
>> Annotate type: 'struct page' in [kernel.kallsyms] (59208 samples):
>> ============================================================================
>>   Percent     offset       size  field
>>    100.00          0       0x40  struct page      {
>>      9.95          0        0x8      long unsigned int   flags;
>>     52.83        0x8       0x28      union        {
>>     52.83        0x8       0x28          struct   {
>>     37.21        0x8       0x10              union        {
>>     37.21        0x8       0x10                  struct list_head        lru {
>>     37.21        0x8        0x8                      struct list_head*   next;
>>      0.00       0x10        0x8                      struct list_head*   prev;
>>                                                  };
>>     37.21        0x8       0x10                  struct   {
>>     37.21        0x8        0x8                      void*       __filler;
>>      0.00       0x10        0x4                      unsigned int        mlock_count;
>>     ...
>>
>> Changes since v1: (reworked from Huafei's series):
>>
>>   - Fix inconsistencies in arm64 instruction output across llvm, capstone,
>>     and objdump disassembly backends.
>>   - Support arm64-specific addressing modes and operand formats. (Leo Yan)
>>   - Extend instruction tracking to support mov and add instructions,
>>     along with per-cpu and stack variables.
>>   - Include real-world examples in commit messages to demonstrate
>>     practical effects. (Namhyung Kim)
>>   - Improve type-tracking success rate (type stat) from 64.2% to 82.1%.
>>     https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>>
>> Please let me know if you have any feedback.
>>
>> Thanks,
>> Tengda
>>
>> [1] https://lore.kernel.org/all/20250314162137.528204-1-lihuafei1@huawei.com/
>> [2] https://developer.arm.com/documentation/102374/0103
>> [3] https://github.com/flynd/asmsheets/releases/tag/v8
>>
>> ---
>>
>> Tengda Wu (16):
>>    perf llvm: Fix arm64 adrp instruction disassembly mismatch with
>>      objdump
>>    perf capstone: Fix arm64 jump/adrp disassembly mismatch with objdump
>>    perf annotate-arm64: Generalize arm64_mov__parse to support standard
>>      operands
>>    perf annotate-arm64: Handle load and store instructions
>>    perf annotate: Introduce extract_op_location callback for
>>      arch-specific parsing
>>    perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
>>    perf annotate-arm64: Implement extract_op_location() callback
>>    perf annotate-arm64: Enable instruction tracking support
>>    perf annotate-arm64: Support load instruction tracking
>>    perf annotate-arm64: Support store instruction tracking
>>    perf annotate-arm64: Support stack variable tracking
>>    perf annotate-arm64: Support 'mov' instruction tracking
>>    perf annotate-arm64: Support 'add' instruction tracking
>>    perf annotate-arm64: Support 'adrp' instruction to track global
>>      variables
>>    perf annotate-arm64: Support per-cpu variable access tracking
>>    perf annotate-arm64: Support 'mrs' instruction to track 'current'
>>      pointer
>>
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 642 +++++++++++++++++-
>>   .../util/annotate-arch/annotate-powerpc.c     |  10 +
>>   tools/perf/util/annotate-arch/annotate-x86.c  |  88 ++-
>>   tools/perf/util/annotate-data.c               |  72 +-
>>   tools/perf/util/annotate-data.h               |   7 +-
>>   tools/perf/util/annotate.c                    | 108 +--
>>   tools/perf/util/annotate.h                    |  12 +
>>   tools/perf/util/capstone.c                    | 107 ++-
>>   tools/perf/util/disasm.c                      |   5 +
>>   tools/perf/util/disasm.h                      |   5 +
>>   .../util/dwarf-regs-arch/dwarf-regs-arm64.c   |  20 +
>>   tools/perf/util/dwarf-regs.c                  |   2 +-
>>   tools/perf/util/include/dwarf-regs.h          |   1 +
>>   tools/perf/util/llvm.c                        |  50 ++
>>   14 files changed, 984 insertions(+), 145 deletions(-)
>>
>>
>> base-commit: cf7c3c02fdd0dfccf4d6611714273dcb538af2cb
> 

