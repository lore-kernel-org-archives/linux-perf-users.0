Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8A38E120;
	Fri, 10 Apr 2026 10:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817691; cv=none; b=ggUItOfpPJQzW7XSvynF84HZCDM1m0s2kC4X4zDF5OcSKls1vssg6RwMIX119g7Tz6nz/u57egmFTA97+yfVnNyXqAS5sCfvBTDeYF5VpZao723fI1qhQYO0ekD1qb0CjaxbTs29OM8BNVt3P1BO5UoF7K1l2Hq7sTrIQnnj/po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817691; c=relaxed/simple;
	bh=Vy8dKw9pfndnSFM5cJz/o/sVF7d1p/rIB/FdfMe0vSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jj0k82XUc5r/kDSUsa51M2DRqvAUMWDfJE/Khp2Yj0wnn05G1iwf1F7El+mHjCDOFMGSjdDOcZQOls00qkO/n8QW6Q6rUFWeWcZDYKdu+VP/X0KSNEg6axcVnw0enPH5hEerEt04oG58vsIJ2O3Fd7joMFz3aT4eLuMBzIjFvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsYHP0gS0zYQtlh;
	Fri, 10 Apr 2026 18:40:49 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 45C2B40570;
	Fri, 10 Apr 2026 18:41:26 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgCHs1DV09hpneYjEA--.13331S2;
	Fri, 10 Apr 2026 18:41:26 +0800 (CST)
Message-ID: <ccce822c-043c-4c1c-84fc-5ea33b7c24de@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:41:25 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/16] perf annotate-arm64: Support stack variable
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
 <20260403094800.1418825-12-wutengda@huaweicloud.com>
 <adiY4xJ9269L70mM@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adiY4xJ9269L70mM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCHs1DV09hpneYjEA--.13331S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyfuw17Zw15uw4Utr4fXwb_yoW7Xr4kpr
	yDAFy3KF42gr47KFs3XFs8Xr92gws2gr1DC34Yq3WIyF9a9r1Skas5KFW29ay8Jr9rAw18
	Aw1UtrsxWwsFkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/4/10 14:29, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:55AM +0000, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to track data types stored on the
>> stack. This allows 'perf annotate' to maintain type information for
>> local variables that are spilled to or loaded from stack slots.
>>
>> The implementation handles:
>> 1. Stack Loads (LDR): Identify when a register is loaded from a stack
>>    slot and update the register's type state based on the tracked
>>    stack content or compound member types.
>> 2. Stack Stores (STR): Update or create new stack state entries when
>>    a tracked register type is stored to the stack.
>>
>> This enables the instruction tracker to follow data types as they move
>> between registers and memory, specifically for function local variables
>> and compiler-spilled values on arm64.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 83 ++++++++++++++++++-
>>  1 file changed, 80 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 28647a778802..f9100230c2f6 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -11,6 +11,8 @@
>>  #include "../disasm.h"
>>  #include "../annotate-data.h"
>>  #include "../debug.h"
>> +#include "../map.h"
>> +#include "../symbol.h"
>>  
>>  struct arch_arm64 {
>>  	struct arch arch;
>> @@ -297,6 +299,8 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	Dwarf_Die type_die;
>>  	u32 insn_offset = dl->al.offset;
>>  	int sreg, dreg;
>> +	int fbreg = dloc->fbreg;
>> +	int fboff = 0;
>>  
>>  	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
>>  		return;
>> @@ -304,17 +308,59 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	sreg = src->reg1;
>>  	dreg = dst->reg1;
>>  
>> +	if (dloc->fb_cfa) {
>> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
>> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
>> +			fbreg = -1;
>> +	}
>> +
>>  	/* Memory to register transfers */
>>  	if (!strncmp(dl->ins.name, "ld", 2)) {
>>  		struct type_state_reg dst_tsr;
>>  
>> -		if (!has_reg_type(state, sreg) ||
>> -		    !has_reg_type(state, dreg) ||
>> -		    !state->regs[dreg].ok)
>> +		if (!has_reg_type(state, sreg))
>>  			return;
>>  
>>  		tsr = &state->regs[sreg];
>>  		tsr->copied_from = -1;
>> +
>> +		/* Check stack variables with offset */
>> +		if (sreg == fbreg || sreg == state->stack_reg) {
>> +			struct type_state_stack *stack;
>> +			int offset = src->offset - fboff;
>> +
>> +			stack = find_stack_state(state, offset);
>> +			if (stack == NULL) {
>> +				tsr->ok = false;
>> +				return;
>> +			} else if (!stack->compound) {
>> +				tsr->type = stack->type;
>> +				tsr->kind = stack->kind;
>> +				tsr->offset = stack->ptr_offset;
>> +				tsr->ok = true;
>> +			} else if (die_get_member_type(&stack->type,
>> +						       offset - stack->offset,
>> +						       &type_die)) {
>> +				tsr->type = type_die;
>> +				tsr->kind = TSR_KIND_TYPE;
>> +				tsr->offset = 0;
>> +				tsr->ok = true;
>> +			} else {
>> +				tsr->ok = false;
>> +				return;
>> +			}
>> +
>> +			pr_debug_dtp("ldr [%x] -%#x(stack) -> reg%d",
>> +				     insn_offset, -offset, sreg);
>> +			pr_debug_type_name(&tsr->type, tsr->kind);
>> +			return;
> 
> Any chance the stack register changes the offset with the addressing
> mode?  I think it should be updated regardless of the result of this
> operation.
> 
>> +		}
>> +
>> +		if (!has_reg_type(state, dreg) || !state->regs[dreg].ok)
>> +			return;
>> +
>>  		dst_tsr = state->regs[dreg];
>>  
>>  		/* Dereference the pointer if it has one */
>> @@ -338,6 +384,37 @@ static void update_insn_state_arm64(struct type_state *state,
>>  
>>  	/* Register to memory transfers */
>>  	if (!strncmp(dl->ins.name, "st", 2)) {
>> +		/* Check stack variables with offset */
>> +		if (dreg == fbreg || dreg == state->stack_reg) {
>> +			struct type_state_stack *stack;
>> +			int offset = dst->offset - fboff;
>> +
>> +			if (!has_reg_type(state, sreg) ||
>> +			    !state->regs[sreg].ok)
>> +				return;
>> +
>> +			tsr = &state->regs[sreg];
>> +
>> +			stack = find_stack_state(state, offset);
>> +			if (stack) {
>> +				if (!stack->compound)
>> +					set_stack_state(stack, offset, tsr->kind,
>> +							&tsr->type, tsr->offset);
>> +			} else {
>> +				findnew_stack_state(state, offset, tsr->kind,
>> +						    &tsr->type, tsr->offset);
>> +			}
>> +
>> +			pr_debug_dtp("str [%x] reg%d -> -%#x(stack)",
>> +				     insn_offset, sreg, -offset);
>> +			if (tsr->offset != 0) {
>> +				pr_debug_dtp(" reg%d offset %#x ->",
>> +					     sreg, tsr->offset);
>> +			}
>> +			pr_debug_type_name(&tsr->type, tsr->kind);
>> +			return;
> 
> Ditto.
> 
> Thanks,
> Namhyung
> 

Indeed. Pre/post-index addressing modes are very common for stack operations
in arm64. It’s definitely necessary to update the offset regardless of the
lookup result.

-- Tengda

> 
>> +		}
>> +
>>  		/*
>>  		 * Store instructions do not change the register type,
>>  		 * but the base register must be updated for pre/post-index
>> -- 
>> 2.34.1
>>

