Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DC43CE52;
	Tue, 18 Aug 2026 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043551; cv=none; b=BgSnDH/5xURDcH3EnFV0aIcLbaHw4Rhel7m6Bo0OZwXDy2VGcxq8UkUTeGoYWwd/vQYmEPFVPzWFHC0kEYurWFCtmfL0ZU99rNpRW8DozAGOnGpyiVXs25WtHgh8NlrJAoZUaCcQlBRtW7PsuJTvxfJmI0yWxnjPvt0A5FjmUJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043551; c=relaxed/simple;
	bh=9ZXcpc5AMOQ2M5KgGoTzMH841o9B2VbYuzxmRYkb3xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDy3dSgCb7+ibO9myapwhzeOAwQE/X2Rrv24OhqVaG4K9JIOUuZ6/fC1VQZbu6hjiplrCIpPFbfDUAoVLIzcUt6IDJM0bDn0gefSRrBMFsNFJslVM7c02VFn+wzseMg6TYJzQLnzPzEKHrgTYyq3kz8Wb8Nmwuqrx76OOZ3g+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hPNsj162czYQv5y;
	Tue, 18 Aug 2026 16:58:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 34E5C4058C;
	Tue, 18 Aug 2026 16:59:04 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDHAUHWHoRqb30BCw--.26985S2;
	Tue, 18 Aug 2026 16:59:03 +0800 (CST)
Message-ID: <d53b15a6-e735-45fc-b9cd-4815b7484f6f@huaweicloud.com>
Date: Tue, 18 Aug 2026 16:59:02 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/23] perf annotate-arm64: Support 'mov' instruction
 tracking
To: Shuai Xue <xueshuai@linux.alibaba.com>, Namhyung Kim
 <namhyung@kernel.org>, james.clark@linaro.org,
 Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-20-wutengda@huaweicloud.com>
 <960b490f-42da-4a9e-8734-62f9c3773b2d@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <960b490f-42da-4a9e-8734-62f9c3773b2d@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHAUHWHoRqb30BCw--.26985S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xr4DZrW8Cw4UJFWrCrWDCFg_yoWfur47pF
	Z5C3yUGrW7Grs7WrnxtrWDJF95Cr1xt3WDCry0q3WayF43Kr1FgF42qrW29Fy5Jr4rAr17
	Jr1jqr9rZw17A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/11 16:37, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to support register-to-register and
>> immediate-to-register 'mov' instructions.
>>
>> For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
>> information from the source register to the destination register.
>>
>> For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immediate
>> value in the destination register's imm_value field and set its kind to
>> TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
>> constant.
>>
>> A real-world example is shown below:
>>
>>    ffff8000803eebf8 <get_vma_policy>:
>>    ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*) -> x21
>>    ffff8000803eec28:  ldr  x2, [x0, #112]
>>    ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
>> * ffff8000803eec94:  ldr  x0, [x21, #152]
>>
>> Before this commit, the type of x21 was unknown, causing the subsequent
>> inference to fail:
>>
>>    var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>>    chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
>>    final result: no type information
>>
>> After this commit, the type of x21 is correctly inferred as 'vm_area_struct':
>>
>>    var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>>    mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
>>    chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
>>    found by insn track: 0x98(reg21) type-offset=0x98
>>    final result:  type='struct vm_area_struct' size=0xb0
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 53 ++++++++++++++++++-
>>   1 file changed, 52 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 6e09e9707256..7b780bad8c07 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -1,6 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>   #include <linux/compiler.h>
>>   #include <errno.h>
>> +#include <inttypes.h>
>>   #include <stdlib.h>
>>   #include <string.h>
>>   #include <linux/ctype.h>
>> @@ -484,6 +485,7 @@ static int propagate_load_reg_state(struct type_state *state,
>>           tsr->type = type_die;
>>           tsr->kind = TSR_KIND_TYPE;
>>           tsr->offset = 0;
>> +        tsr->imm_value = 0;
>>           tsr->ok = true;
>>             if (src->multi_regs) {
>> @@ -641,6 +643,51 @@ static void update_store_insn_state(struct type_state *state,
>>       adjust_reg_index_state(state, dst, insn_name, dl->al.offset);
>>   }
>>   +static void update_mov_insn_state(struct type_state *state,
>> +                  struct disasm_line *dl,
>> +                  struct annotated_op_loc *src,
>> +                  struct annotated_op_loc *dst)
>> +{
>> +    struct type_state_reg *tsr;
>> +    u32 insn_offset = dl->al.offset;
>> +    int sreg = src->reg1;
>> +    int dreg = dst->reg1;
>> +
>> +    if (!has_reg_type(state, dreg))
>> +        return;
>> +
>> +    tsr = &state->regs[dreg];
>> +    tsr->copied_from = -1;
>> +
>> +    if (src->imm) {
>> +        tsr->kind = TSR_KIND_CONST;
>> +        tsr->imm_value = src->offset;
>> +        tsr->offset = 0;
>> +        tsr->ok = true;
> 
> This overwrites only part of the register state: if the destination
> previously held a variable with an active DWARF lifetime, the stale
> lifetime_active/lifetime_end survive, and the call-invalidation
> exemption then protects a plain constant across calls. Same gap as
> the return-type block discussed earlier - clearing the register state
> (invalidate_reg_state()) before filling it in would cover both.
> 

Agreed.

> 
>> +
>> +        pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
>> +                 insn_offset, tsr->imm_value, dreg);
>> +        return;
>> +    }
>> +
>> +    if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
>> +        invalidate_reg_state(tsr);
>> +        return;
>> +    }
>> +
>> +    tsr->type = state->regs[sreg].type;
>> +    tsr->kind = state->regs[sreg].kind;
>> +    tsr->imm_value = state->regs[sreg].imm_value;
>> +    tsr->offset = state->regs[sreg].offset;
>> +    tsr->ok = state->regs[sreg].ok;
> 
> onversely, the register-to-register path drops the lifetime fields
> that the x86 handler explicitly copies. Not copying is arguably more
> correct - the DWARF location range describes the variable living in
> the source register - but it also means a value moved into a
> callee-saved register gets invalidated by the first call, losing the
> tracking. Is the omission intentional? If so, a comment would help;
> either way the two archs should probably converge on one behaviour.
> 

The lifetime field is only meaningful within the context of the DWARF
information it was parsed from, and it specifically describes the source
register itself. Therefore, it __cannot__ be blindly copied over to the
destination register. Here is an example to illustrate this:

find data type for 0(reg19) at flush_ptrace_hw_breakpoint+0x28
CU for arch/arm64/kernel/ptrace.c (die:0x1026b9)
frame base: cfa=1 fbreg=31
scope: [1/1] (die:125362) [function] flush_ptrace_hw_breakpoint
bb: [0 - 28]
var [0] reg0 offset 0 type='struct task_struct*' size=0x8 (die:0x1042d6)
mov [18] reg0 -> reg20 type='struct task_struct*' size=0x8 (die:0x1042d6)

0x001253a6:   DW_TAG_variable
                DW_AT_name	("t")
                DW_AT_decl_file	("debian/build/build_arm64_none_arm64/arch/arm64/kernel/ptrace.c")
                DW_AT_decl_line	(209)
                DW_AT_decl_column	(24)
                DW_AT_type	(0x001253d3 "thread_struct *")
                DW_AT_location	(0x000237ff: 
                   [0xffff80008001c9b0, 0xffff80008001c9d0): DW_OP_breg0 W0+3024, DW_OP_stack_value

ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
ffff80008001c9a8:       d503201f        nop
ffff80008001c9ac:       d503201f        nop
ffff80008001c9b0:       d503233f        paciasp  // lifetime_active
ffff80008001c9b4:       a9bd7bfd        stp     x29, x30, [sp, #-48]!
ffff80008001c9b8:       910003fd        mov     x29, sp
ffff80008001c9bc:       a90153f3        stp     x19, x20, [sp, #16]
ffff80008001c9c0:       aa0003f4        mov     x20, x0
ffff80008001c9c4:       913ae013        add     x19, x0, #0xeb8
ffff80008001c9c8:       f90013f5        str     x21, [sp, #32]
ffff80008001c9cc:       913ce015        add     x21, x0, #0xf38
ffff80008001c9d0:       f9400260        ldr     x0, [x19]  // lifetime_end
ffff80008001c9d4:       b4000060        cbz     x0, ffff80008001c9e0 <flush_ptrace_hw_breakpoint+0x38>
ffff80008001c9d8:       940bbd6c        bl      ffff80008030bf88 <unregister_hw_breakpoint>
// x0's lifetime expires here and becomes invalid, but x20 is callee-saved
// and should NOT be invalidated
...
ffff80008001c9ec:       913ee294        add     x20, x20, #0xfb8

I agree with your point. I will add a comment here to explain the rationale.

>> +
>> +    if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
>> +        tsr->copied_from = sreg;
>> +
>> +    pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
>> +    pr_debug_type_name(&tsr->type, tsr->kind);
>> +}
>> +
>>   static void update_insn_state_arm64(struct type_state *state,
>>                       struct data_loc_info *dloc, Dwarf_Die *cu_die,
>>                       struct disasm_line *dl)
>> @@ -703,6 +750,7 @@ static void update_insn_state_arm64(struct type_state *state,
>>        * prevent stale type info from propagating to subsequent instructions.
>>        */
>>       if (has_reg_type(state, dst->reg1) &&
>> +        strcmp(dl->ins.name, "mov") &&
>>           strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
> 
> Comparison and test instructions get killed by this: for cmp x5, x6
> the first operand ends up as the target (reg1 = x5), and since cmp
> matches none of the exemptions above, a read-only register is
> invalidated. Same for cmn and tst, and for the tested register of
> cbz/cbnz/tbz/tbnz. Since comparisons sit between the tracked load and
> the sampled access in almost every hot path, this silently drops a
> lot of type resolution.
> 
> The x86 side avoids this by using a whitelist of instructions that
> actually clobber pointer registers; here an exemption for the
> read-only compares/tests would do:
> 
>     if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
>         strcmp(dl->ins.name, "mov") && strcmp(dl->ins.name, "cmp") &&
>         strcmp(dl->ins.name, "cmn") && strcmp(dl->ins.name, "tst") &&
>         ...)
> 

Yes, I missed these instructions. I will add them.

Thanks,
Tengda

