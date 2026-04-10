Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4B2DC767;
	Fri, 10 Apr 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817451; cv=none; b=O+CJG4peaIT++l4Fz3P2yLCUvy72lbCvpeCMOfbDz1wzqbAdQRyBZihAyRv1pU/2OYewlR6H77P9gAEaCLrj+/YSXQijXelKhw16GldD6y6jsUPrdsdeoLvTcvSonrFbR7qNgQSBZ8zTFTfl2P9SasL7FHVt3iCZTMuR1yr4tTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817451; c=relaxed/simple;
	bh=tOh4lNR7oHvWvB6lRJ7hUoazIX1+4iwuB4y9QLFjWAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGwBVBd51Jx11FjZzxXUy1LqKtI75QQDm5PjWz2CI/8nR/eFhee2OMBAYNBpiRNhZ/RNUII25LLzSYfKZby6lFKNJFEOJhkH7Pom1WM6WOn4fFQE6gBI/g/AGlH+4YWX6JpxNiDUfM96QSbXu5rVzPzlFXbK2O1r/LirF0/o2qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsYBl5dPpzYQtth;
	Fri, 10 Apr 2026 18:36:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2B3484058D;
	Fri, 10 Apr 2026 18:37:25 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgC3j0rj0thpG2BfEA--.28710S2;
	Fri, 10 Apr 2026 18:37:24 +0800 (CST)
Message-ID: <4fd9c0ca-42ed-4969-b09f-f4a0e7eb77e2@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:37:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] perf annotate-arm64: Support load instruction
 tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-10-wutengda@huaweicloud.com>
 <adiXYBhkEpbBR0ZA@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adiXYBhkEpbBR0ZA@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3j0rj0thpG2BfEA--.28710S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyDWFW7tr4Dtr1xXF4rGrg_yoWxXFy8pa
	yDCas8Kr47Xr4agFsaqrZrur9agw1kWr1jkrZ0k3WayF92yr1rKa1kKrya9FWrJrZxCr12
	vF1Utry3Ww1DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIbyZUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 14:23, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:53AM +0000, Tengda Wu wrote:
>> Implement update_insn_state() for arm64 to track register state changes
>> during load (LDR) instructions. This is essential for maintaining accurate
>> type information when data is moved from memory to registers.
>>
>> The implementation handles the three primary arm64 addressing modes:
>> 1. Signed offset: [base, #imm]
>> 2. Pre-index: [base, #imm]!
>> 3. Post-index: [base], #imm
>>
>> Introduce adjust_reg_index_state() to handle the side effects of pre-index
>> and post-index addressing, where the base register is updated with the
>> offset after or before the memory access. This ensures that the register's
>> offset within a structure is correctly tracked across sequential
>> instructions.
>>
>> A real-world example is shown below:
>>
>>   ffff80008011f5b0 <pick_task_stop>:
>>   ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
>>   ffff80008011f5c0:  ldr  w1, [x0, #104]  // PMU sample at offset 0x68
>>
>> Before this commit, the type of x0 was incorrectly inferred as 'struct rq':
>>
>>   find data type for 0x68(reg0) at pick_task_stop+0x10
>>   var [8] reg0 offset 0 type='struct rq*'
>>   chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
>>   final result:  type='struct rq'
>>
>> After this commit, the type of x0 is correctly inferred as 'struct task_struct':
>>
>>   find data type for 0x68(reg0) at pick_task_stop+0x10
>>   var [8] reg0 offset 0 type='struct rq*'
>>   ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
>>   chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
>>   final result: type='struct task_struct'
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 87 +++++++++++++++++++
>>  1 file changed, 87 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 1fe4c503431b..cac2bf0021c9 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -9,6 +9,8 @@
>>  #include <regex.h>
>>  #include "../annotate.h"
>>  #include "../disasm.h"
>> +#include "../annotate-data.h"
>> +#include "../debug.h"
>>  
>>  struct arch_arm64 {
>>  	struct arch arch;
>> @@ -254,6 +256,88 @@ static int extract_op_location_arm64(const struct arch *arch,
>>  	return 0;
>>  }
>>  
>> +#ifdef HAVE_LIBDW_SUPPORT
>> +static int get_mem_offset(struct annotated_op_loc *op_loc, int type_offset)
>> +{
>> +	if (op_loc->addr_mode == INSN_ADDR_POST_INDEX)
>> +		return type_offset;
>> +
>> +	return op_loc->offset + type_offset;
>> +}
>> +
>> +static void adjust_reg_index_state(struct type_state *state, int reg,
>> +				   struct annotated_op_loc *op_loc,
>> +				   const char *insn_name, u32 insn_offset)
>> +{
>> +	struct type_state_reg *tsr;
>> +
>> +	if (!has_reg_type(state, reg) ||
>> +	    (op_loc->addr_mode != INSN_ADDR_PRE_INDEX &&
>> +	    op_loc->addr_mode != INSN_ADDR_POST_INDEX))
>> +		return;
>> +
>> +	tsr = &state->regs[reg];
>> +	tsr->offset = op_loc->offset + tsr->offset;
>> +	tsr->ok = true;
> 
> Maybe we can skip setting 'ok' here?
> 
> 
>> +
>> +	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
>> +		     insn_offset, op_loc->addr_mode == INSN_ADDR_PRE_INDEX ?
>> +		     "pre" : "post", op_loc->offset, reg, reg);
>> +	pr_debug_type_name(&tsr->type, tsr->kind);
>> +}
>> +
>> +static void update_insn_state_arm64(struct type_state *state,
>> +				    struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
>> +				    struct disasm_line *dl)
>> +{
>> +	struct annotated_insn_loc loc;
>> +	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
>> +	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
>> +	struct type_state_reg *tsr;
>> +	Dwarf_Die type_die;
>> +	u32 insn_offset = dl->al.offset;
>> +	int sreg, dreg;
>> +
>> +	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
>> +		return;
>> +
>> +	sreg = src->reg1;
>> +	dreg = dst->reg1;
>> +
>> +	/* Memory to register transfers */
>> +	if (!strncmp(dl->ins.name, "ld", 2)) {
>> +		struct type_state_reg dst_tsr;
>> +
>> +		if (!has_reg_type(state, sreg) ||
>> +		    !has_reg_type(state, dreg) ||
>> +		    !state->regs[dreg].ok)
>> +			return;
> 
> I think we should set state->regs[sreg].ok to false if sreg is valid.
> 
>> +
>> +		tsr = &state->regs[sreg];
>> +		tsr->copied_from = -1;
>> +		dst_tsr = state->regs[dreg];
>> +
>> +		/* Dereference the pointer if it has one */
>> +		if (dst_tsr.kind == TSR_KIND_TYPE &&
>> +		    die_deref_ptr_type(&dst_tsr.type,
>> +				       get_mem_offset(dst, dst_tsr.offset),
>> +				       &type_die)) {
>> +			tsr->type = type_die;
>> +			tsr->kind = TSR_KIND_TYPE;
>> +			tsr->offset = 0;
>> +			tsr->ok = true;
>> +
>> +			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
>> +				     insn_offset, dst->offset, dreg, sreg);
> 
> It could confuse people since src and dst are opposite.  Maybe you can
> change the parse function to set the source and target (destination)
> properly for each instruction.
> 

Indeed. I kept the v1 definitions to keep things simple, but I agree it
makes the code less readable and potentially confusing. I’ll be extra
careful when refactoring the source and target logic in the next version.
Haha.

> 
>> +			pr_debug_type_name(&tsr->type, tsr->kind);
>> +
>> +			adjust_reg_index_state(state, dreg, dst, "ldr", insn_offset);
>> +		}
> 
> Also you will need to update index offset and set the 'ok' state
> properly.
> 
> Thanks,
> Namhyung
>
Okay. I'll go over the 'ok' state handling again.

-- Tengda

>> +		return;
>> +	}
>> +}
>> +#endif
>> +
>>  const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  				   const char *cpuid __maybe_unused)
>>  {
>> @@ -273,6 +357,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  	arch->objdump.imm_char		  = '#';
>>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>>  	arch->extract_op_location	  = extract_op_location_arm64;
>> +#ifdef HAVE_LIBDW_SUPPORT
>> +	arch->update_insn_state		  = update_insn_state_arm64;
>> +#endif
>>  
>>  	/* bl, blr */
>>  	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
>> -- 
>> 2.34.1
>>

