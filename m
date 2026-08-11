Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4082400995;
	Tue, 11 Aug 2026 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436684; cv=none; b=uJ5pPsyS2oDXKbsBFvOI0EXBG5hWXgO9Icw2WVz+M0LSLFEjoYFuS7s9bpWQzCWwMcR9XqfVcuZqpZbfOEWHmlOoptlj/XB4lGWy1o+U2tcOU9CRYWyLu7tkN4CIgVtXBMWZqV+z8CtJph/mnbCP3Xl5yfSnqlFqwse+UxQRxP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436684; c=relaxed/simple;
	bh=Supicr/KHkan9PvbNOIUUQ9+RRcBVArXkdMz8sT9LLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JSs8nIleC4qYiIP1fP2h3dwAgzM3Hmp6FgBwDrwBEhLhS34q0KxDD0sxotiMk6wrul0Ra2dH72B4KY96W4cRoTV/trbH/lY1HDkTY46Lkn79GA9THjSYSFOyObjSyUUC20hPu7+koZZhHyO4FjGv2EJKZKVHuGLgv5XA8umhnK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KrhNOxP4; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KrhNOxP4"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786436677; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7RrsrvCqKW3MQRhkDDJYC/2n6urqygYfLPAH0xl5hIQ=;
	b=KrhNOxP43+KmNk1vlcUoLPMkqgki6RiHbHQalGmLOp1lPh77Bnl/WfEwYQi/Y9m5NodbYZXeipwJTTUM6dR99ffXoTqRrcSULADkidJbB9gOR0KShNjFX3Cua5nWwhLvF/sLoSObbQvM0Nal3yD43rS4dBizgCDTP4ULHwS8qjA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8niHk5_1786436674;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8niHk5_1786436674 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:24:35 +0800
Message-ID: <1dfbb930-e8ef-4289-b443-f831251d4445@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:24:34 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/23] perf annotate-arm64: Support stack variable
 tracking
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
 james.clark@linaro.org, Li Huafei <lihuafei1@huawei.com>
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
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-19-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to track data types stored on the
> stack. This allows 'perf annotate' to maintain type information for
> local variables that are spilled to or loaded from stack slots.
> 
> The implementation handles:
> 
> 1. Stack Loads (LDR): Identify when a register is loaded from a stack
>     slot and update the register's type state based on the tracked
>     stack content or compound member types.
> 
> 2. Stack Stores (STR): Update or create new stack state entries when
>     a tracked register type is stored to the stack.
> 
> Similar to loads, stores also support saving one or two registers
> (in the case of 'stp'). Therefore, propagate_store_reg_state() is
> introduced. The overall offset calculation follows the same logic as
> the load implementation:
> 
>    src->reg1: reg_offset = get_reg_index_offset()
>    src->reg2: reg_offset = get_reg_index_offset() + reg_size(src->reg1)
> 
> With these changes, the instruction tracker can now follow data types
> as they move between registers and memory, specifically for function
> local variables and compiler-spilled values on arm64.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 161 ++++++++++++++++--
>   1 file changed, 148 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index ed0f0ef2877d..6e09e9707256 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -407,6 +407,7 @@ static void adjust_reg_index_state(struct type_state *state,
>    * to the source struct's field offset.
>    */
>   static int propagate_load_reg_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
>   				    struct disasm_line *dl, int dreg,
>   				    struct annotated_op_loc *src,
>   				    int reg_offset, const char *insn_name)
> @@ -416,6 +417,8 @@ static int propagate_load_reg_state(struct type_state *state,
>   	Dwarf_Die type_die;
>   	u32 insn_offset = dl->al.offset;
>   	int sreg = src->reg1;
> +	int fbreg = dloc->fbreg;
> +	int fboff = 0;
>   
>   	if (!has_reg_type(state, dreg))
>   		return -1;
> @@ -423,7 +426,52 @@ static int propagate_load_reg_state(struct type_state *state,
>   	tsr = &state->regs[dreg];
>   	tsr->copied_from = -1;
>   
> +	if (dloc->fb_cfa) {
> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg = -1;
> +	}
> +
>   retry:
> +	/* Check stack variables with offset */
> +	if (sreg == fbreg || sreg == state->stack_reg) {
> +		struct type_state_stack *stack;
> +		int offset = sreg == fbreg ? reg_offset - fboff : reg_offset;
> +
> +		stack = find_stack_state(state, offset);
> +		if (stack == NULL) {
> +			return -1;
> +		} else if (!stack->compound) {
> +			tsr->type = stack->type;
> +			tsr->kind = stack->kind;
> +			tsr->offset = stack->ptr_offset;
> +			tsr->imm_value = stack->imm_value;
> +			tsr->ok = true;
> +		} else if (die_get_member_type(&stack->type,
> +					       offset - stack->offset,
> +					       &type_die)) {
> +			tsr->type = type_die;
> +			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
> +			tsr->imm_value = 0;
> +			tsr->ok = true;
> +		} else {
> +			return -1;
> +		}
> +
> +		if (sreg == fbreg) {
> +			pr_debug_dtp("%s [%x] -%#x(stack) -> reg%d",
> +				     insn_name, insn_offset, -offset, dreg);
> +		} else {
> +			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
> +				     insn_name, insn_offset, offset, sreg, dreg);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
> +
>   	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
>   		return -1;
>   
> @@ -460,6 +508,7 @@ static int propagate_load_reg_state(struct type_state *state,
>   }
>   
>   static void update_load_insn_state(struct type_state *state,
> +				   struct data_loc_info *dloc,
>   				   struct disasm_line *dl,
>   				   struct annotated_op_loc *src,
>   				   struct annotated_op_loc *dst)
> @@ -472,7 +521,7 @@ static void update_load_insn_state(struct type_state *state,
>   		goto out_err_adjust;
>   
>   	/* Handle the first destination register */
> -	if (propagate_load_reg_state(state, dl, dst->reg1, src,
> +	if (propagate_load_reg_state(state, dloc, dl, dst->reg1, src,
>   				     reg_offset, insn_name))
>   		goto out_err_adjust;
>   
> @@ -481,7 +530,7 @@ static void update_load_insn_state(struct type_state *state,
>   		int reg_size = arm64__reg_size(dl->ops.target.raw);
>   
>   		if (reg_size < 0 ||
> -		    propagate_load_reg_state(state, dl, dst->reg2, src,
> +		    propagate_load_reg_state(state, dloc, dl, dst->reg2, src,
>   					     reg_offset + reg_size, insn_name))
>   			goto out_err_adjust;
>   	}
> @@ -498,6 +547,100 @@ static void update_load_insn_state(struct type_state *state,
>   	goto out_adjust;
>   }
>   
> +/*
> + * For store insns: propagate type from @sreg to the memory location
> + * referenced by @dreg, applying @reg_offset to the destination memory offset.
> + */
> +static int propagate_store_reg_state(struct type_state *state,
> +				     struct data_loc_info *dloc,
> +				     struct disasm_line *dl, int sreg, int dreg,
> +				     int reg_offset, const char *insn_name)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset = dl->al.offset;
> +	int fbreg = dloc->fbreg;
> +	int fboff = 0;
> +
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
> +		return -1;

If an untracked register is stored into a stack slot that already
has a tracked type, this leaves the stale entry in place - a later
load from that slot picks up the old type. The sequence is easy to
hit: store a tracked register, cross a call, then store a register
that the call invalidated. The right behaviour would be to drop the
stack entry when the source is unknown. I see x86 case 3 has the
exact same pattern, so this probably wants a cross-arch fix rather
than an arm64-only one.

Also, this function always returns 0 apart from that early check,
and the callers ignore the return value anyway. Either make it void
or return a real status and act on it.

> +
> +	if (dloc->fb_cfa) {
> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg = -1;
> +	}
> +
> +	/* Check stack variables with offset */
> +	if (dreg == fbreg || dreg == state->stack_reg) {
> +		struct type_state_stack *stack;
> +		int offset = dreg == fbreg ? reg_offset - fboff : reg_offset;
> +
> +		tsr = &state->regs[sreg];
> +
> +		stack = find_stack_state(state, offset);
> +		if (stack) {
> +			if (!stack->compound)
> +				set_stack_state(stack, offset, tsr->kind, &tsr->type,
> +						tsr->offset, tsr->imm_value);
> +			/*
> +			 * If it's a compound type, it means attempting to
> +			 * write to a member value of the compound type without
> +			 * changing the compound type itself, so do nothing.
> +			 */
> +		} else {
> +			findnew_stack_state(state, offset, tsr->kind, &tsr->type,
> +					    tsr->offset, tsr->imm_value);
> +		}
> +
> +		if (dreg == fbreg) {
> +			pr_debug_dtp("%s [%x] reg%d -> -%#x(stack)",
> +				     insn_name, insn_offset, sreg, -offset);
> +		} else {
> +			pr_debug_dtp("%s [%x] reg%d -> %#x(reg%d)",
> +				     insn_name, insn_offset, sreg, offset, dreg);
> +		}
> +		if (tsr->offset != 0) {
> +			pr_debug_dtp(" reg%d offset %#x ->",
> +				     sreg, tsr->offset);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +	}
> +	/*
> +	 * Ignore other transfers since it'd set a value in a struct
> +	 * and won't change the type.
> +	 */
> +
> +	return 0;
> +}
> +
> +static void update_store_insn_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl,
> +				    struct annotated_op_loc *src,
> +				    struct annotated_op_loc *dst)
> +{
> +	int reg_offset = get_reg_index_offset(dst);
> +	const char *insn_name = src->multi_regs ? "stp" : "str";

This misparses the exclusive stores. For stxr w2, x1, [x0] the left
operand is "w2, x1", so multi_regs is true and the handler treats it
as stp: it records w2's type (the status output, possibly stale) at
the base offset and the real data register x1 at offset + reg_size,
and w2 - which the instruction writes - is never invalidated. stxp
is worse since its third source register is dropped entirely.

Maybe restrict the propagation to str/stp explicitly and handle the
stxr/stlxr/stxp/stlxp family separately: their first source register
is actually a destination and should be invalidated, with only the
remaining register(s) propagated (or just skip propagation for them
if that's simpler).

> +	/* Handle the first source register */
> +	propagate_store_reg_state(state, dloc, dl, src->reg1, dst->reg1,
> +				  reg_offset, insn_name);
> +
> +	/* Handle the second source register (stp only) */
> +	if (src->multi_regs) {
> +		int reg_size = arm64__reg_size(dl->ops.source.raw);
> +
> +		if (reg_size >= 0)
> +			propagate_store_reg_state(state, dloc, dl, src->reg2,
> +						  dst->reg1, reg_offset + reg_size,
> +						  insn_name);


Same reg_size-from-first-register pattern as the load side, so the
element-size caveat from that patch applies here too.

Thanks.
Shuai
