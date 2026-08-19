Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089EC35B62F;
	Wed, 19 Aug 2026 03:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787108693; cv=none; b=dQoZA7PC8n9QcqF5db9WPRuIWGP0mR0RP0M8ZLR2bvcZIDh5EAYm+52GkvjjiI6uHoLPmFSXdSuiUOWiDKlc6fRNAmLvxHYGTdcUzmZR8KzeaXbX2abDWkAg4Z/MQ7/xLJDASsHMJvjtrR/cfnTz70p3azS2TNT03UTSxp/eD18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787108693; c=relaxed/simple;
	bh=oFXt+KPb6+jAhaVlKCIH5PJmOEfJ9SVUxGJM/q2dNP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUgL1M8UEsNh1Z4Dz6Z6yAqpTKjUzQkQc8XSJO/Re4uGvXOBzHfcHZD2ufwbllz3aQxpcsD+NmI90cELXB+ESOTMYn8d7XME0FJvakF3a9mEamhuZsQ1Fbt/qOb+guVB8KYdjcV9smuwD5Se7iglxiSPHc2Zyiu3EPHct1kn1Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hPryF5qnpzYQtHN;
	Wed, 19 Aug 2026 11:04:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 2515E4058C;
	Wed, 19 Aug 2026 11:04:38 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDHtUREHYVqihVeCw--.32590S2;
	Wed, 19 Aug 2026 11:04:37 +0800 (CST)
Message-ID: <b5e4ef0d-cb11-45de-987a-226340b576ed@huaweicloud.com>
Date: Wed, 19 Aug 2026 11:04:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruction
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
 <20260808122400.2961238-21-wutengda@huaweicloud.com>
 <89e66d40-5f9f-4147-beda-00623797cd04@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <89e66d40-5f9f-4147-beda-00623797cd04@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgDHtUREHYVqihVeCw--.32590S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKFyfGF4xXw1Duw45JFy7Jrb_yoW3XFW8pr
	4kGrWUGry7JrnYgr13tr4UJFyrCr1xJ3WDCryFq3WayF4avr10gF12qr9F9FW5Jr4rJr17
	Jr1jqrsxZrnrGFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/8/11 16:45, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to track 'add' instructions for
>> structure member address calculation, which commonly appear as:
>>
>>    add  dreg, base, #offset
>>    add  dreg, base, reg2     (reg2 holds a constant)
>>
>> Unlike x86, the arm64 'add' instruction has an extra base register among
>> its source operands. Therefore, in terms of propagating the data type,
>> it is essentially performing a 'mov', except that before the 'mov', it
>> first needs to be updated by adding the offset or reg2.
>>
>> A real-world example is shown below:
>>
>>    ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>>    ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
>> * ffff80008001c9d0:  ldr  x0, [x19]
>>
>> Before this commit, the type flow broke at the 'add' instruction,
>> leaving the subsequent load with no type information:
>>
>>    chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
>>    final result: no type information
>>
>> After this commit, the tracker correctly follows the member address
>> calculation:
>>
>>    var [0] reg0 offset 0 type='struct task_struct*'
>>    add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
>>    chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
>>    found by insn track: 0(reg19) type-offset=0xeb8
>>    final result: type='struct task_struct'
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   .../perf/util/annotate-arch/annotate-arm64.c  | 87 ++++++++++++++++++-
>>   1 file changed, 85 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 7b780bad8c07..eaeb4433fc3a 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -688,6 +688,87 @@ static void update_mov_insn_state(struct type_state *state,
>>       pr_debug_type_name(&tsr->type, tsr->kind);
>>   }
>>   +static void update_add_insn_state(struct type_state *state,
>> +                  struct disasm_line *dl,
>> +                  struct annotated_op_loc *src,
>> +                  struct annotated_op_loc *dst)
>> +{
>> +    struct type_state_reg *tsr;
>> +    struct type_state_reg src_tsr;
>> +    u32 insn_offset = dl->al.offset;
>> +    int sreg = src->reg1;
>> +    int dreg = dst->reg1;
>> +    u64 imm_value;
>> +
>> +    if (!has_reg_type(state, dreg))
>> +        return;
>> +
>> +    tsr = &state->regs[dreg];
>> +    tsr->copied_from = -1;
>> +
>> +retry:
>> +    if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
>> +        invalidate_reg_state(tsr);
>> +        return;
>> +    }
>> +
>> +    src_tsr = state->regs[sreg];
>> +
>> +    /*
>> +     * Handle 'add' instructions of the form:
>> +     *   add  dreg, base, #offset     (immediate offset)
>> +     *   add  dreg, base, reg2        (reg2 holds a constant)
>> +     *
>> +     * For case 2, retrieve the constant value from reg2
>> +     * and use it as the offset.
>> +     */
>> +    imm_value = src->offset;
>> +    if (src->multi_regs) {
>> +        int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
>> +
>> +        if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
>> +            /* Unable to resolve type for dst, bail out */
>> +            invalidate_reg_state(tsr);
>> +            return;
>> +        }
>> +        if (state->regs[reg2].kind == TSR_KIND_CONST)
>> +            imm_value = state->regs[reg2].imm_value;
> 
> First, when reg2 is valid but not TSR_KIND_CONST - say a pointer
> freshly loaded from memory - the addend is unknown at analysis time,
> yet imm_value silently stays 0 and propagation continues, tracking
> the destination as base + 0. Note the asymmetry: no state at all
> invalidates, but state that doesn't yield a value pretends the
> addend is zero. Unknown addend should invalidate as well:
> 
>         if (state->regs[reg2].kind != TSR_KIND_CONST) {
>             invalidate_reg_state(tsr);
>             return;
>         }
> 

It might not be a direct invalidation, but rather swapping reg1/reg2 and
then retrying.

> Second, the shifted/extended forms still break even with a constant
> reg2: extract_op_location_arm64() drops the "lsl #3" (or uxtw/sxtw)
> modifier, so add x0, x1, x2, lsl #3 contributes the unshifted value
> and maps later accesses to the wrong field. Maybe flag such operands
> during extraction (or fail the reg2 extraction) so the handler can
> skip them.
>

Okay, so it seems shifted/extended forms are unavoidable. We may need to
introduce more fields into annotated_op_loc to record them, like this:

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 138d9258281c..b00e0ad96023 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -501,6 +501,8 @@ int arch__dwarf_regnum(const struct arch *arch, const char *str);
  * @offset: Memory access offset in the operand
  * @segment: Segment selector register
  * @addr_mode: Addressing mode, only valid if @mem_ref is true
+ * @extend_type: ARM64 register extend specifier (enum annotated_ext_type)
+ * @shift: ARM64 shift amount (e.g., 0 to 4)
  * @mem_ref: Whether the operand accesses memory
  * @multi_regs: Whether the second register is used
  * @imm: Whether the operand is an immediate value (in offset)
@@ -511,6 +513,8 @@ struct annotated_op_loc {
 	int offset;
 	u8 segment;
 	u8 addr_mode;
+	u8 extend_type;
+	u8 shift;
 	bool mem_ref;
 	bool multi_regs;
 	bool imm;
@@ -542,6 +546,19 @@ enum annotated_addr_mode {
 	PERF_ADDR_MODE_POST_INDEX,
 };
 
+enum annotated_ext_type {
+	PERF_EXT_NONE = 0,
+
+	PERF_EXT_UXTB,
+	PERF_EXT_SXTB,
+	PERF_EXT_UXTH,
+	PERF_EXT_SXTH,
+	PERF_EXT_UXTW,
+	PERF_EXT_SXTW,
+	PERF_EXT_UXTX,  /* LSL is equivalent to UXTX */
+	PERF_EXT_SXTX,
+};
+
 /**
  * struct annotated_insn_loc - Location info of instruction
  * @ops: Array of location info for source and target operands


>> +    }
>> +
>> +    if (src_tsr.kind == TSR_KIND_CONST) {
>> +        tsr->kind = src_tsr.kind;
>> +        tsr->imm_value = src_tsr.imm_value + imm_value;
>> +        tsr->offset = 0;
>> +        tsr->ok = src_tsr.ok;
>> +
>> +        pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
>> +                 insn_offset, imm_value, sreg, dreg);
> 
> And since add is commutative, this early return drops the pointer
> side for add rd, const_reg, ptr_reg: sreg starts as reg1, hits the
> CONST case and returns before the goto retry at the bottom ever gets
> a chance to evaluate the pointer register. The result should be the
> pointer with the constant applied as an offset, not a plain constant.
> Maybe check the other register for a pointer type before falling into
> the CONST case (or move the CONST handling after the retry).
> 

Yeah, this issue is a side effect of the previous incomplete handling and
will be fixed together.

Thanks,
Tengda

