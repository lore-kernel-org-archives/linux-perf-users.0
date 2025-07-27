Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1EE8F6E;
	Sun, 27 Jul 2025 00:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753576379; cv=none; b=pWFfELk6u+AHhtraUEYvnen5FWmTy8RSkLnX+MK6ufxTFqyt2qBgeEIyM1kYz1PFtZ8PX5TiZZh64xAeRhb+2W2zRKcI8szDfglE+pwRU/fpZbMkpjy1+1eHS6G08S4cqRFkSQ7IU6uFUBQF1NUhrjOQTQ/+dEJ1UCB40lRvIeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753576379; c=relaxed/simple;
	bh=D3mfNsWwLzNw4RKH7gD+3bEZhoGiXBvaoS6jwOI8/h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBKzHmqX5HxGgnT0JvGW/T78v6PtF1GbmZa74cWiQwJiceq/MlKP6n70sJIG2XVXc0HmGub/RvfIEZxPSEbcrUYat/jErnSdc9OFNjkPoNWNFKpuVioQOPM+dNTIoWp8NbQ3bzKpPtW4F04jg55Paqd5LPl8jXKfp9inDshEngc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS1EWWYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS1EWWYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC8CC4CEED;
	Sun, 27 Jul 2025 00:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753576378;
	bh=D3mfNsWwLzNw4RKH7gD+3bEZhoGiXBvaoS6jwOI8/h8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AS1EWWYvy6yRud7e4XewHlVqWbqPAsE5VjS7uPvcnmlK0AthKeFwF7Ohpm2RFQGsN
	 UZ7/EiKxW5kNRjBhxZhqRzZ83S7q1GWXJJibwwRpl80e3E/Emh9/g2vdHv5+fzd2a3
	 yHaGO6DL41iHffT5xDnDC7HbIqheJAOEtg7iYHf8iBVUeS4Wu97YWmgay17/3nMkIw
	 Eu9AbJZqFEqLjZfhQFrxVhhYeUr662I8hB0I7mSnoyUkZqpGsB69cIM6aj4jSibB+2
	 c8lFky6HMHeQV6aO+QjDoSAbS7kQyC6HOURLtDu9WO9aOlIHfVdBVJm2J6Nol6CFt+
	 uLxlHB0rc/BpQ==
Date: Sat, 26 Jul 2025 17:32:56 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, Zecheng Li <zli94@ncsu.edu>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 6/6] perf annotate: Track arithmetic instructions on
 pointers
Message-ID: <aIVzuLiQEXzysKgJ@google.com>
References: <20250725202809.1230085-1-zecheng@google.com>
 <20250725202809.1230085-7-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725202809.1230085-7-zecheng@google.com>

On Fri, Jul 25, 2025 at 08:28:09PM +0000, Zecheng Li wrote:
> Track the arithmetic operations on registers with pointer types. We
> handle only add and lea instructions. The original pointer information

I'm afraid of possible inaccuracy due to incompleteness.  While I think
'add' is the common case, but it may have 'sub', 'mul', 'div' or other
arith operations too.  In general, I think it's better not to report
rather then incorrect result.

Maybe we can invalidate the state once it's used by any unsupported
arith instruction?

Thanks,
Namhyung


> needs to be preserved for getting outermost struct types. For example,
> reg0 points to a struct cfs_rq, when we add 0x10 to reg0, it should
> preserve the information of struct cfs_rq + 0x10 in the register instead
> of a pointer type to the child field at 0x10.
> 
> Details:
> 
> 1.  struct type_state_reg now includes an offset, indicating if the
>     register points to the start or an internal part of its associated
>     type. This offset is used in mem to reg and reg to stack mem
>     transfers, and also applied to the final type offset.
> 
> 2.  lea offset(%sp/%fp), reg is now treated as taking the address of a
>     stack variable. It worked fine in most cases, but an issue with this
>     approach is the pointer type may not exist.
> 
> 3.  lea offset(%base), reg is handled by moving the type from %base and
>     adding an offset, similar to an add operation followed by a mov reg
>     to reg.
> 
> 4.  Non-stack variables from DWARF with non-zero offsets in their
>     location expressions are now accepted with register offset tracking.
> 
> Limitation: Offset tracking for register moved to the stack is not yet
> implemented. Currently, moving an register with offset to the stack
> resolves to the member type, which worked in some of the cases. Strictly
> it should be a pointer to the immediate child member. Multi-register
> addressing modes in LEA are not supported.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 109 +++++++++++++++++++-
>  tools/perf/util/annotate-data.c             |  14 ++-
>  tools/perf/util/annotate-data.h             |   6 ++
>  3 files changed, 120 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index c6d403eae744..82fc0106a4de 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -248,6 +248,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			tsr = &state->regs[state->ret_reg];
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("call [%x] return -> reg%d",
> @@ -284,6 +285,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			    !strcmp(var_name, "this_cpu_off") &&
>  			    tsr->kind == TSR_KIND_CONST) {
>  				tsr->kind = TSR_KIND_PERCPU_BASE;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  				imm_value = tsr->imm_value;
>  			}
> @@ -291,6 +293,15 @@ static void update_insn_state_x86(struct type_state *state,
>  		else
>  			return;
>  
> +		/* Ignore add to non-pointer types like int */
> +		if (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
> +		    src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref) {
> +			tsr->offset += imm_value;
> +			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
> +				     insn_offset, imm_value, dst->reg1);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +
>  		if (tsr->kind != TSR_KIND_PERCPU_BASE)
>  			return;
>  
> @@ -302,6 +313,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			 */
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_POINTER;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
> @@ -311,6 +323,68 @@ static void update_insn_state_x86(struct type_state *state,
>  		return;
>  	}
>  
> +	if (!strncmp(dl->ins.name, "lea", 3)) {
> +		struct type_state_reg *src_tsr;
> +		int sreg = src->reg1;
> +
> +		if (!has_reg_type(state, sreg) ||
> +		    !has_reg_type(state, dst->reg1) ||
> +		    !src->mem_ref)
> +			return;
> +
> +		src_tsr = &state->regs[sreg];
> +		tsr = &state->regs[dst->reg1];
> +
> +		tsr->copied_from = -1;
> +		tsr->ok = false;
> +
> +		/* Case 1: Based on stack pointer or frame pointer */
> +		if (sreg == fbreg || sreg == state->stack_reg) {
> +			struct type_state_stack *stack;
> +			int offset = src->offset - fboff;
> +
> +			stack = find_stack_state(state, offset);
> +			if (!stack)
> +				return;
> +
> +			/* TODO: the pointer type may not exist */
> +			/* Now the register becomes a pointer to the stack variable */
> +			if (!die_find_pointer_to_type(cu_die, &stack->type, &type_die))
> +				return;
> +
> +			tsr->type = type_die;
> +			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("lea [%x] -> reg%d points to %s + %#x on stack\n",
> +					insn_offset, dst->reg1,
> +					(sreg == fbreg) ? "fbreg" : "sp", offset);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +		/* Case 2: Based on a register holding a typed pointer */
> +		else if (has_reg_type(state, sreg) &&
> +			 state->regs[sreg].ok &&
> +			 state->regs[sreg].kind == TSR_KIND_TYPE) {
> +
> +			/* Check if the target type has a member at the new offset */
> +			if (__die_get_real_type(&state->regs[sreg].type, &type_die) == NULL ||
> +			    !die_get_member_type(&type_die,
> +						 src->offset + src_tsr->offset, &type_die))
> +				return;
> +
> +			tsr->type = src_tsr->type;
> +			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = src->offset + src_tsr->offset;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("lea [%x] -> reg%d points to reg%d + %#x\n",
> +					insn_offset, dst->reg1, sreg, src->offset);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +		return;
> +	}
> +
>  	if (strncmp(dl->ins.name, "mov", 3))
>  		return;
>  
> @@ -345,6 +419,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			if (var_addr == 40) {
>  				tsr->kind = TSR_KIND_CANARY;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  
>  				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
> @@ -361,6 +436,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
> @@ -372,6 +448,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		if (src->imm) {
>  			tsr->kind = TSR_KIND_CONST;
>  			tsr->imm_value = src->offset;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
> @@ -388,6 +465,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		tsr->type = state->regs[src->reg1].type;
>  		tsr->kind = state->regs[src->reg1].kind;
>  		tsr->imm_value = state->regs[src->reg1].imm_value;
> +		tsr->offset = 0;
>  		tsr->ok = true;
>  
>  		/* To copy back the variable type later (hopefully) */
> @@ -421,12 +499,14 @@ static void update_insn_state_x86(struct type_state *state,
>  			} else if (!stack->compound) {
>  				tsr->type = stack->type;
>  				tsr->kind = stack->kind;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  			} else if (die_get_member_type(&stack->type,
>  						       offset - stack->offset,
>  						       &type_die)) {
>  				tsr->type = type_die;
>  				tsr->kind = TSR_KIND_TYPE;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  			} else {
>  				tsr->ok = false;
> @@ -446,9 +526,10 @@ static void update_insn_state_x86(struct type_state *state,
>  		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
>  			 state->regs[sreg].kind == TSR_KIND_TYPE &&
>  			 die_deref_ptr_type(&state->regs[sreg].type,
> -					    src->offset, &type_die)) {
> +					    src->offset + state->regs[sreg].offset, &type_die)) {
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
> @@ -473,6 +554,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
> @@ -504,6 +586,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			    die_get_member_type(&type_die, offset, &type_die)) {
>  				tsr->type = type_die;
>  				tsr->kind = TSR_KIND_TYPE;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  
>  				if (src->multi_regs) {
> @@ -526,6 +609,7 @@ static void update_insn_state_x86(struct type_state *state,
>  					     src->offset, &type_die)) {
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
> @@ -548,6 +632,7 @@ static void update_insn_state_x86(struct type_state *state,
>  							&var_name, &offset) &&
>  				    !strcmp(var_name, "__per_cpu_offset")) {
>  					tsr->kind = TSR_KIND_PERCPU_BASE;
> +					tsr->offset = 0;
>  					tsr->ok = true;
>  
>  					pr_debug_dtp("mov [%x] percpu base reg%d\n",
> @@ -571,6 +656,22 @@ static void update_insn_state_x86(struct type_state *state,
>  			int offset = dst->offset - fboff;
>  
>  			tsr = &state->regs[src->reg1];
> +			type_die = tsr->type;
> +
> +			/* The register is derived from a pointer to the type */
> +			if (tsr->offset != 0) {
> +				/*
> +				 * deref gets the innermost field, but we actually want direct
> +				 * child field and take a pointer to it.
> +				 * However array type like unsigned long[] is already a pointer
> +				 * and is the most common case for this kind of stack variable.
> +				 */
> +				if (die_deref_ptr_type(&tsr->type, tsr->offset, &type_die)) {
> +					pr_debug_dtp("find member: tsr->offset: %d", tsr->offset);
> +					pr_debug_type_name(&type_die, tsr->kind);
> +				} else
> +					return;
> +			}
>  
>  			stack = find_stack_state(state, offset);
>  			if (stack) {
> @@ -583,10 +684,10 @@ static void update_insn_state_x86(struct type_state *state,
>  				 */
>  				if (!stack->compound)
>  					set_stack_state(stack, offset, tsr->kind,
> -							&tsr->type);
> +							&type_die);
>  			} else {
>  				findnew_stack_state(state, offset, tsr->kind,
> -						    &tsr->type);
> +						    &type_die);
>  			}
>  
>  			if (dst->reg1 == fbreg) {
> @@ -596,7 +697,7 @@ static void update_insn_state_x86(struct type_state *state,
>  				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
>  					     insn_offset, src->reg1, offset, dst->reg1);
>  			}
> -			pr_debug_type_name(&tsr->type, tsr->kind);
> +			pr_debug_type_name(&type_die, tsr->kind);
>  		}
>  		/*
>  		 * Ignore other transfers since it'd set a value in a struct
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 1ef2edbc71d9..9cb215e499ef 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -887,7 +887,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  					     insn_offset, -offset);
>  			}
>  			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
> -		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
> +		} else if (has_reg_type(state, var->reg)) {
>  			struct type_state_reg *reg;
>  			Dwarf_Die orig_type;
>  
> @@ -898,13 +898,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  				continue;
>  
>  			orig_type = reg->type;
> -
> +			/*
> +			 * var->offset + reg value is the beginning of the struct
> +			 * reg->offset is the offset the reg points
> +			 */
> +			reg->offset = -var->offset;
>  			reg->type = mem_die;
>  			reg->kind = TSR_KIND_TYPE;
>  			reg->ok = true;
>  
> -			pr_debug_dtp("var [%"PRIx64"] reg%d",
> -				     insn_offset, var->reg);
> +			pr_debug_dtp("var [%"PRIx64"] reg%d at offset %d",
> +				     insn_offset, var->reg, var->offset);
>  			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
>  
>  			/*
> @@ -1092,7 +1096,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
>  			return PERF_TMR_NO_POINTER;
>  
> -		dloc->type_offset = dloc->op->offset;
> +		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
>  
>  		if (dwarf_tag(type_die) == DW_TAG_typedef)
>  			die_get_real_type(type_die, &sized_type);
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index 541fee1a5f0a..a6df0491eebf 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -173,6 +173,12 @@ extern struct annotated_data_stat ann_data_stat;
>  struct type_state_reg {
>  	Dwarf_Die type;
>  	u32 imm_value;
> +        /*
> +         * The offset within the struct that the register points to.
> +         * A value of 0 means the register points to the beginning.
> +	 * type_offset = op->offset + reg->offset
> +         */
> +	s32 offset;
>  	bool ok;
>  	bool caller_saved;
>  	u8 kind;
> -- 
> 2.50.1.470.g6ba607880d-goog
> 
