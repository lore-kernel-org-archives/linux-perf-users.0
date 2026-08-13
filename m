Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C934440DB56;
	Thu, 13 Aug 2026 14:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632863; cv=none; b=KlKziudf70ImAZmwQ9PMQX2aTU4nMiXunsv9gGDRjiUT/VoD6yObhtJ77/ar6kMTGrErcz/nBHtvRkpDrI0vCXOQr6/PdZ+UIfGudoYCNIVbnV546DLxGKzlEMhjVNX0W1Q6/DRAv8MPiw1pRVU9lhiBghLIVE7ELsCRDb1fnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632863; c=relaxed/simple;
	bh=H4phoMYbLJxfSFfiH94/7usUsHy+rq8pXCChjbnVRhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DNv6r4+iYrarLMsIFsnz39e1BnRrdliE89Dq28eyrE+0h741X8sXlBIcVxmFLXaEh27k+1MafqfNmEtxXb7xEe9KS4frcFkZ2iCUZUy2mDg4HzohUuEXVRKfKGovIsbUuk4pzNecSvMt8rAml+AdcQxO3jEIaLTRLMU9jbXavlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLSzT4bF8zKHMgd;
	Thu, 13 Aug 2026 22:53:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E83D40574;
	Thu, 13 Aug 2026 22:54:01 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDHt9OI2n1qpde1CA--.25781S2;
	Thu, 13 Aug 2026 22:54:00 +0800 (CST)
Message-ID: <d3bce9bc-80c9-418a-b3a9-3e49dd82dd34@huaweicloud.com>
Date: Thu, 13 Aug 2026 22:54:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/23] perf annotate-arm64: Support load instruction
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
 <20260808122400.2961238-15-wutengda@huaweicloud.com>
 <d61a0cbb-373f-4bc6-8493-889a76e27e87@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <d61a0cbb-373f-4bc6-8493-889a76e27e87@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHt9OI2n1qpde1CA--.25781S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ur1xAw43XrWxWr17Xr1kKrg_yoWkWr17pr
	4kJrWUGryUJrn3Xr12qr1UJFyUCw1UJ3WUCry8X3W7tF42yr1FgF4UWr9FgF4UJr48Ar45
	Jr1UXrnrZr17JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
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



On 2026/8/11 15:36, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Extend update_insn_state_arm64() to handle LDR instructions, tracking
>> register state changes when data is loaded from memory to registers.
>>
>> The implementation handles the three primary arm64 addressing modes:
>> 1. Signed offset: [base, #imm|reg]
>> 2. Pre-index: [base, #imm]!
>> 3. Post-index: [base], #imm
>>
>> Before updating, check the addressing mode via get_reg_index_offset() to
>> obtain the actual source's reg_offset, and then propagate the type.
>>
>> Since a load instruction may have two destination registers (in ldp cases),
>> introduce propagate_load_reg_state() to propagate the type for a specified
>> destination register using a given reg_offset. The respective reg_offset
>> values for the two registers are as follows:
>>
>>    dst->reg1: reg_offset = get_reg_index_offset()
>>    dst->reg2: reg_offset = get_reg_index_offset() + reg_size(dst->reg1)
>>
>> Finally, handle the side effects of pre-index and post-index addressing
>> via adjust_reg_index_state().
>>
>> A real-world example is shown below:
>>
>>    ffff80008011f5b0 <pick_task_stop>:
>>    ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
>> * ffff80008011f5c0:  ldr  w1, [x0, #104]
>>
>> Before this commit, the type of x0 was incorrectly inferred as 'struct rq':
>>
>>    find data type for 0x68(reg0) at pick_task_stop+0x10
>>    var [8] reg0 offset 0 type='struct rq*'
>>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
>>    final result:  type='struct rq'
>>
>> After this commit, the type of x0 is correctly inferred as 'struct task_struct':
>>
>>    find data type for 0x68(reg0) at pick_task_stop+0x10
>>    var [8] reg0 offset 0 type='struct rq*'
>>    ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
>>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
>>    final result: type='struct task_struct'
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 148 +++++++++++++++++-
>>   1 file changed, 147 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index acff14ca01e0..6557c0ad11b2 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct arch *arch,
>>   }
>>     #ifdef HAVE_LIBDW_SUPPORT
>> +static int arm64__reg_size(const char *reg)
>> +{
>> +    if (!reg || !*reg || !arm64__is_reg(reg))
>> +        return -1;
> 
> Since arm64__is_reg() rejects xzr and SIMD registers, something like
> ldp xzr, x19, [sp] ends up with multi_regs = false and x19 never
> invalidated or tracked. Admittedly a corner case - but maybe worth
> handling if extending the register set is cheap.
> 

Agreed. But I'd propose that we first support recognizing xzr/wzr only,
and leave SIMD registers for a future extension when we properly add SIMD support.

There shouldn't be a case where SIMD registers and general-purpose registers
appear together within the same operands, right? If so, then skipping SIMD
support for now should be fine.

> 
>> +    if (reg[0] == 'w')
>> +        return 4;
>> +
>> +    if (reg[0] == 'x' || !strncmp(reg, "sp", 2))
>> +        return 8;
>> +
>> +    return -1;
>> +}
>> +
>> +static int get_reg_index_offset(struct annotated_op_loc *op_loc)
>> +{
>> +    return op_loc->addr_mode == PERF_ADDR_MODE_POST_INDEX ? 0 : op_loc->offset;
>> +}
>> +
>> +/* Apply addressing mode (pre-index, post-index) to register state */
>> +static void adjust_reg_index_state(struct type_state *state,
>> +                   struct annotated_op_loc *op_loc,
>> +                   const char *insn_name, u32 insn_offset)
>> +{
>> +    struct type_state_reg *tsr;
>> +    int reg = op_loc->reg1;
>> +
>> +    if (op_loc->addr_mode != PERF_ADDR_MODE_PRE_INDEX &&
>> +        op_loc->addr_mode != PERF_ADDR_MODE_POST_INDEX)
>> +        return;
>> +
>> +    if (!has_reg_type(state, reg) || !state->regs[reg].ok)
>> +        return;
>> +
>> +    tsr = &state->regs[reg];
>> +    tsr->copied_from = -1;
>> +    tsr->offset = op_loc->offset + tsr->offset;
>> +
>> +    pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
>> +             insn_offset, op_loc->addr_mode == PERF_ADDR_MODE_PRE_INDEX ?
>> +             "pre" : "post", op_loc->offset, reg, reg);
>> +    pr_debug_type_name(&tsr->type, tsr->kind);
>> +}
>> +
>> +/*
>> + * For load insns: propagate type from @src to @dreg, applying @reg_offset
>> + * to the source struct's field offset.
>> + */
>> +static int propagate_load_reg_state(struct type_state *state,
>> +                    struct disasm_line *dl, int dreg,
>> +                    struct annotated_op_loc *src,
>> +                    int reg_offset, const char *insn_name)
>> +{
>> +    struct type_state_reg *tsr;
>> +    struct type_state_reg src_tsr;
>> +    Dwarf_Die type_die;
>> +    u32 insn_offset = dl->al.offset;
>> +    int sreg = src->reg1;
>> +
>> +    if (!has_reg_type(state, dreg))
>> +        return -1;
>> +
>> +    tsr = &state->regs[dreg];
>> +    tsr->copied_from = -1;
>> +
>> +retry:
>> +    if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
>> +        return -1;
>> +
>> +    src_tsr = state->regs[sreg];
>> +
>> +    /* Dereference the pointer if it has one */
>> +    if (src_tsr.kind == TSR_KIND_TYPE &&
>> +        die_deref_ptr_type(&src_tsr.type,
>> +                   src_tsr.offset + reg_offset, &type_die)) {
>> +        tsr->type = type_die;
>> +        tsr->kind = TSR_KIND_TYPE;
>> +        tsr->offset = 0;
>> +        tsr->ok = true;
>> +
>> +        if (src->multi_regs) {
>> +            pr_debug_dtp("%s [%x] %#x(reg%d, reg%d) -> reg%d",
>> +                     insn_name, insn_offset, reg_offset,
>> +                     src->reg1, src->reg2, dreg);
>> +        } else {
>> +            pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
>> +                     insn_name, insn_offset, reg_offset,
>> +                     sreg, dreg);
>> +        }
>> +        pr_debug_type_name(&tsr->type, tsr->kind);
>> +        return 0;
>> +    }
>> +    /* Or try another register if any */
>> +    else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>> +        sreg = src->reg2;
>> +        goto retry;
>> +    }
>> +
>> +    return -1;
>> +}
>> +
>> +static void update_load_insn_state(struct type_state *state,
>> +                   struct disasm_line *dl,
>> +                   struct annotated_op_loc *src,
>> +                   struct annotated_op_loc *dst)
>> +{
>> +    int reg_offset = get_reg_index_offset(src);
>> +    const char *insn_name = dst->multi_regs ? "ldp" : "ldr";
>> +
>> +    if (!has_reg_type(state, dst->reg1) ||
>> +        (dst->multi_regs && !has_reg_type(state, dst->reg2)))
>> +        goto out_err_adjust;
>> +
>> +    /* Handle the first destination register */
>> +    if (propagate_load_reg_state(state, dl, dst->reg1, src,
>> +                     reg_offset, insn_name))
>> +        goto out_err_adjust;
>> +
>> +    /* Handle the second destination register (ldp only) */
>> +    if (dst->multi_regs) {
>> +        int reg_size = arm64__reg_size(dl->ops.target.raw);
> 
> Two issues here:
> 
> First, propagate_load_reg_state() snapshots state->regs[sreg] at call
> time. For an aliased pair like ldp x0, x1, [x0], the first call
> overwrites x0, and the second call then reads the freshly loaded type
> as the base instead of the original one. Better snapshot the source
> state once in update_load_insn_state() and pass it down.
> 

Yeah, should snapshot first.

> Second, ldpsw loads two 32-bit words from memory (sign-extended into
> x-registers), so the element spacing is 4, not the 8 that
> arm64__reg_size() derives from the destination register. The element
> size needs to come from the mnemonic.
> 

Agreed.

> 
>> +
>> +        if (reg_size < 0 ||
>> +            propagate_load_reg_state(state, dl, dst->reg2, src,
>> +                         reg_offset + reg_size, insn_name))
>> +            goto out_err_adjust;
>> +    }
>> +
>> +out_adjust:
>> +    adjust_reg_index_state(state, src, insn_name, dl->al.offset);
>> +    return;
>> +
>> +out_err_adjust:
>> +    if (has_reg_type(state, dst->reg1))
>> +        invalidate_reg_state(&state->regs[dst->reg1]);
>> +    if (dst->multi_regs && has_reg_type(state, dst->reg2))
>> +        invalidate_reg_state(&state->regs[dst->reg2]);
>> +    goto out_adjust;
>> +}
>> +
>>   static void update_insn_state_arm64(struct type_state *state,
>>                       struct data_loc_info *dloc, Dwarf_Die *cu_die,
>>                       struct disasm_line *dl)
>>   {
>>       struct annotated_insn_loc loc;
>> +    struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
>>       struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
>>       u32 insn_offset = dl->al.offset;
>>   @@ -418,7 +559,8 @@ static void update_insn_state_arm64(struct type_state *state,
>>        * Invalidate destination register(s) for unsupported instructions to
>>        * prevent stale type info from propagating to subsequent instructions.
>>        */
>> -    if (has_reg_type(state, dst->reg1)) {
>> +    if (has_reg_type(state, dst->reg1) &&
>> +        strncmp(dl->ins.name, "ld", 2)) {
> 
> For stores the operands are reversed, so dst is the memory operand
> and dst->reg1 is the base register. This then invalidates the base
> pointer on every store, which is exactly the state we need to resolve
> the memory access type. The x86 version guards this with
> !dst->mem_ref; arm64 should too:
> 
>     if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
>         strncmp(dl->ins.name, "ld", 2)) {
> 

Agreed.

Thanks,
Tengda

