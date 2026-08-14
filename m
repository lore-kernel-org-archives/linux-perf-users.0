Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9A33C2B95;
	Fri, 14 Aug 2026 11:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786707898; cv=none; b=gbHCGIijBK3due1hvR27AdAl6fUdO2n3SSvEkxc+5mLuQIXKQNBRigy076bMGsC7RpN3mGf8pUWgGMRmHgk9rAXCIsGBmVFpxqZ+s8s4JoQwvjTqIPGpKErqFdBCta7shAgApmMK/thQZyg2UAPEVEVG+wF1y+qfuAXhqAyBYms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786707898; c=relaxed/simple;
	bh=cAOaa7R6N0tgk62TkTbDm4cndnyZWSC3PIB+HrGx2g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/P5IoqHEu0mmCUCAbNcYhqzWgG7iTYz0N1Kgjut+ojxfsM1t4hGh8W9l/rKW+K+t0JqmBacecuJbLniX3bq6tl+7fsXf3lzAQVnz9GH6lzIdj12TDgRcNYyoDS+Vg72vzS/fXEQjnhbMj2F3Gl3Vz5zgaAUmdJCsoyC9zzxO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hM0kk1WCWzKHMj8;
	Fri, 14 Aug 2026 19:44:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 166674058F;
	Fri, 14 Aug 2026 19:44:51 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgA3oYix_35qYE0vCQ--.4471S2;
	Fri, 14 Aug 2026 19:44:50 +0800 (CST)
Message-ID: <13dba899-4ff6-45a8-a360-0fcffdb1ac89@huaweicloud.com>
Date: Fri, 14 Aug 2026 19:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/23] perf annotate-arm64: Support stack variable
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
 <20260808122400.2961238-19-wutengda@huaweicloud.com>
 <1dfbb930-e8ef-4289-b443-f831251d4445@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <1dfbb930-e8ef-4289-b443-f831251d4445@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA3oYix_35qYE0vCQ--.4471S2
X-Coremail-Antispam: 1UD129KBjvAXoW3Cw48ZF15Zw4fWFy8ZrWDArb_yoW8Gr4kZo
	WUKr1rJr15Ar1jgr1UJr1UJr13JF1UtrnrtF4UGry7Aw1UAF1UJ3yxJry5t3y7Jr18GF1U
	Jr1UJryjyFyUAr1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUY77kC6x804xWl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK
	8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
	AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
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



On 2026/8/11 16:24, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to track data types stored on the
>> stack. This allows 'perf annotate' to maintain type information for
>> local variables that are spilled to or loaded from stack slots.
>>
>> The implementation handles:
>>
>> 1. Stack Loads (LDR): Identify when a register is loaded from a stack
>>     slot and update the register's type state based on the tracked
>>     stack content or compound member types.
>>
>> 2. Stack Stores (STR): Update or create new stack state entries when
>>     a tracked register type is stored to the stack.
>>
>> Similar to loads, stores also support saving one or two registers
>> (in the case of 'stp'). Therefore, propagate_store_reg_state() is
>> introduced. The overall offset calculation follows the same logic as
>> the load implementation:
>>
>>    src->reg1: reg_offset = get_reg_index_offset()
>>    src->reg2: reg_offset = get_reg_index_offset() + reg_size(src->reg1)
>>
>> With these changes, the instruction tracker can now follow data types
>> as they move between registers and memory, specifically for function
>> local variables and compiler-spilled values on arm64.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 161 ++++++++++++++++--
>>   1 file changed, 148 insertions(+), 13 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index ed0f0ef2877d..6e09e9707256 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -407,6 +407,7 @@ static void adjust_reg_index_state(struct type_state *state,
>>    * to the source struct's field offset.
>>    */
>>   static int propagate_load_reg_state(struct type_state *state,
>> +                    struct data_loc_info *dloc,
>>                       struct disasm_line *dl, int dreg,
>>                       struct annotated_op_loc *src,
>>                       int reg_offset, const char *insn_name)
>> @@ -416,6 +417,8 @@ static int propagate_load_reg_state(struct type_state *state,
>>       Dwarf_Die type_die;
>>       u32 insn_offset = dl->al.offset;
>>       int sreg = src->reg1;
>> +    int fbreg = dloc->fbreg;
>> +    int fboff = 0;
>>         if (!has_reg_type(state, dreg))
>>           return -1;
>> @@ -423,7 +426,52 @@ static int propagate_load_reg_state(struct type_state *state,
>>       tsr = &state->regs[dreg];
>>       tsr->copied_from = -1;
>>   +    if (dloc->fb_cfa) {
>> +        u64 ip = dloc->ms->sym->start + dl->al.offset;
>> +        u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +        if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
>> +            fbreg = -1;
>> +    }
>> +
>>   retry:
>> +    /* Check stack variables with offset */
>> +    if (sreg == fbreg || sreg == state->stack_reg) {
>> +        struct type_state_stack *stack;
>> +        int offset = sreg == fbreg ? reg_offset - fboff : reg_offset;
>> +
>> +        stack = find_stack_state(state, offset);
>> +        if (stack == NULL) {
>> +            return -1;
>> +        } else if (!stack->compound) {
>> +            tsr->type = stack->type;
>> +            tsr->kind = stack->kind;
>> +            tsr->offset = stack->ptr_offset;
>> +            tsr->imm_value = stack->imm_value;
>> +            tsr->ok = true;
>> +        } else if (die_get_member_type(&stack->type,
>> +                           offset - stack->offset,
>> +                           &type_die)) {
>> +            tsr->type = type_die;
>> +            tsr->kind = TSR_KIND_TYPE;
>> +            tsr->offset = 0;
>> +            tsr->imm_value = 0;
>> +            tsr->ok = true;
>> +        } else {
>> +            return -1;
>> +        }
>> +
>> +        if (sreg == fbreg) {
>> +            pr_debug_dtp("%s [%x] -%#x(stack) -> reg%d",
>> +                     insn_name, insn_offset, -offset, dreg);
>> +        } else {
>> +            pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
>> +                     insn_name, insn_offset, offset, sreg, dreg);
>> +        }
>> +        pr_debug_type_name(&tsr->type, tsr->kind);
>> +        return 0;
>> +    }
>> +
>>       if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
>>           return -1;
>>   @@ -460,6 +508,7 @@ static int propagate_load_reg_state(struct type_state *state,
>>   }
>>     static void update_load_insn_state(struct type_state *state,
>> +                   struct data_loc_info *dloc,
>>                      struct disasm_line *dl,
>>                      struct annotated_op_loc *src,
>>                      struct annotated_op_loc *dst)
>> @@ -472,7 +521,7 @@ static void update_load_insn_state(struct type_state *state,
>>           goto out_err_adjust;
>>         /* Handle the first destination register */
>> -    if (propagate_load_reg_state(state, dl, dst->reg1, src,
>> +    if (propagate_load_reg_state(state, dloc, dl, dst->reg1, src,
>>                        reg_offset, insn_name))
>>           goto out_err_adjust;
>>   @@ -481,7 +530,7 @@ static void update_load_insn_state(struct type_state *state,
>>           int reg_size = arm64__reg_size(dl->ops.target.raw);
>>             if (reg_size < 0 ||
>> -            propagate_load_reg_state(state, dl, dst->reg2, src,
>> +            propagate_load_reg_state(state, dloc, dl, dst->reg2, src,
>>                            reg_offset + reg_size, insn_name))
>>               goto out_err_adjust;
>>       }
>> @@ -498,6 +547,100 @@ static void update_load_insn_state(struct type_state *state,
>>       goto out_adjust;
>>   }
>>   +/*
>> + * For store insns: propagate type from @sreg to the memory location
>> + * referenced by @dreg, applying @reg_offset to the destination memory offset.
>> + */
>> +static int propagate_store_reg_state(struct type_state *state,
>> +                     struct data_loc_info *dloc,
>> +                     struct disasm_line *dl, int sreg, int dreg,
>> +                     int reg_offset, const char *insn_name)
>> +{
>> +    struct type_state_reg *tsr;
>> +    u32 insn_offset = dl->al.offset;
>> +    int fbreg = dloc->fbreg;
>> +    int fboff = 0;
>> +
>> +    if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
>> +        return -1;
> 
> If an untracked register is stored into a stack slot that already
> has a tracked type, this leaves the stale entry in place - a later
> load from that slot picks up the old type. The sequence is easy to
> hit: store a tracked register, cross a call, then store a register
> that the call invalidated. The right behaviour would be to drop the
> stack entry when the source is unknown. I see x86 case 3 has the
> exact same pattern, so this probably wants a cross-arch fix rather
> than an arm64-only one.
> 

Agreed. We may need to introduce a delete_stack_state() helper to drop
the stack entry when the source register is unknown.

> Also, this function always returns 0 apart from that early check,
> and the callers ignore the return value anyway. Either make it void
> or return a real status and act on it.
> 

Will do.

>> +
>> +    if (dloc->fb_cfa) {
>> +        u64 ip = dloc->ms->sym->start + dl->al.offset;
>> +        u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +        if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
>> +            fbreg = -1;
>> +    }
>> +
>> +    /* Check stack variables with offset */
>> +    if (dreg == fbreg || dreg == state->stack_reg) {
>> +        struct type_state_stack *stack;
>> +        int offset = dreg == fbreg ? reg_offset - fboff : reg_offset;
>> +
>> +        tsr = &state->regs[sreg];
>> +
>> +        stack = find_stack_state(state, offset);
>> +        if (stack) {
>> +            if (!stack->compound)
>> +                set_stack_state(stack, offset, tsr->kind, &tsr->type,
>> +                        tsr->offset, tsr->imm_value);
>> +            /*
>> +             * If it's a compound type, it means attempting to
>> +             * write to a member value of the compound type without
>> +             * changing the compound type itself, so do nothing.
>> +             */
>> +        } else {
>> +            findnew_stack_state(state, offset, tsr->kind, &tsr->type,
>> +                        tsr->offset, tsr->imm_value);
>> +        }
>> +
>> +        if (dreg == fbreg) {
>> +            pr_debug_dtp("%s [%x] reg%d -> -%#x(stack)",
>> +                     insn_name, insn_offset, sreg, -offset);
>> +        } else {
>> +            pr_debug_dtp("%s [%x] reg%d -> %#x(reg%d)",
>> +                     insn_name, insn_offset, sreg, offset, dreg);
>> +        }
>> +        if (tsr->offset != 0) {
>> +            pr_debug_dtp(" reg%d offset %#x ->",
>> +                     sreg, tsr->offset);
>> +        }
>> +        pr_debug_type_name(&tsr->type, tsr->kind);
>> +    }
>> +    /*
>> +     * Ignore other transfers since it'd set a value in a struct
>> +     * and won't change the type.
>> +     */
>> +
>> +    return 0;
>> +}
>> +
>> +static void update_store_insn_state(struct type_state *state,
>> +                    struct data_loc_info *dloc,
>> +                    struct disasm_line *dl,
>> +                    struct annotated_op_loc *src,
>> +                    struct annotated_op_loc *dst)
>> +{
>> +    int reg_offset = get_reg_index_offset(dst);
>> +    const char *insn_name = src->multi_regs ? "stp" : "str";
> 
> This misparses the exclusive stores. For stxr w2, x1, [x0] the left
> operand is "w2, x1", so multi_regs is true and the handler treats it
> as stp: it records w2's type (the status output, possibly stale) at
> the base offset and the real data register x1 at offset + reg_size,
> and w2 - which the instruction writes - is never invalidated. stxp
> is worse since its third source register is dropped entirely.
> 
> Maybe restrict the propagation to str/stp explicitly and handle the
> stxr/stlxr/stxp/stlxp family separately: their first source register
> is actually a destination and should be invalidated, with only the
> remaining register(s) propagated (or just skip propagation for them
> if that's simpler).
> 

Agreed. For now, we should restrict the propagation to only apply to
regular store instructions like str/stp. I'll strengthen the instruction
matching to ensure exclusive stores are excluded.

>> +    /* Handle the first source register */
>> +    propagate_store_reg_state(state, dloc, dl, src->reg1, dst->reg1,
>> +                  reg_offset, insn_name);
>> +
>> +    /* Handle the second source register (stp only) */
>> +    if (src->multi_regs) {
>> +        int reg_size = arm64__reg_size(dl->ops.source.raw);
>> +
>> +        if (reg_size >= 0)
>> +            propagate_store_reg_state(state, dloc, dl, src->reg2,
>> +                          dst->reg1, reg_offset + reg_size,
>> +                          insn_name);
> 
> 
> Same reg_size-from-first-register pattern as the load side, so the
> element-size caveat from that patch applies here too.
> 

For store instructions, there doesn't seem to be a special element-size
instruction like ldpsw on the load side, so using the register size
should be sufficient here (please correct me if I'm wrong). That said,
I agree that renaming "reg_size" to "elem_size" would make the code
more accurate and self-explanatory. I'll update it accordingly.

Thanks,
Tengda

