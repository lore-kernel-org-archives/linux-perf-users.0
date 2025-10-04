Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19461F0991;
	Sat,  4 Oct 2025 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759564663; cv=none; b=OcD1XWgNKBo966AUxKQ1rAoKBxbYbsdA+NuGsp7UDs+kk0G7+bFR5pTFX1RXX2Y9qp3zWRXMVXHAz9oNALWqehlV3HTKbLWbINzdSUZzqKEJfcInEBT3ztDGpQ2IMhr1ojnMVTac8XNItrY+gvX9GHJ0s6ismscQmYHfcZM9x4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759564663; c=relaxed/simple;
	bh=X6M10vuKkVkqfHM52VyS+2S/YevytPSBgzrd2u+1Zg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y7meemzrJMb3ZxFPhYsF/XaKrV6T4zOB3xVQERKSvGTQq01p0cpZ2su3hStO1GtTYBa/xla2a0B3cK4DWiEjzXwmwlqwh4Fqm8dutQ9qWky5sy2rqPnhnc/wvSqZko96et57VHSYnbeXL4G76mak1jODqf81YUGmbFxb5YIHQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ugtch/Jx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ugtch/Jx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67E57C4CEF1;
	Sat,  4 Oct 2025 07:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759564663;
	bh=X6M10vuKkVkqfHM52VyS+2S/YevytPSBgzrd2u+1Zg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ugtch/JxO7X679i7Wx+aP94M1RuRaEmRCTxXl1PoRsOqM2sjTgmCH4JZBRquE+Bsb
	 vQ6yNwKP4d1EGKVVKqebcZOMtrRszbcP6I5vMyMWg1fgxYiwRget9r9de04Y8z0fVu
	 PUqHTlFmzRFrF1yPVGJ//h2rkMJ6JUBv5zXLWM+UKgn9TYXzLQyokBSDla/Zinx1iI
	 VysoU3aHKulm5XqEpRmKaJjZAXryQCFlvwoA+HQAxPiG81s0WNYvDYrTs50Yc3P6CV
	 GV/rY6zIqE4WKAx9dzz6pjKKzoH56vTTJ5j8H6RUyqdUreU/Wcgtyf3Fkzq4T/UENv
	 nx/ahga2CcAgA==
Date: Sat, 4 Oct 2025 16:57:38 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/10] perf annotate: Track arithmetic instructions on
 pointers
Message-ID: <aODTcm00aEC3QR73@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-5-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-5-zecheng@google.com>

On Wed, Sep 17, 2025 at 07:58:02PM +0000, Zecheng Li wrote:
> Track the arithmetic operations on registers with pointer types. We
> handle only add, sub and lea instructions. The original pointer
> information needs to be preserved for getting outermost struct types.
> For example, reg0 points to a struct cfs_rq, when we add 0x10 to reg0,
> it should preserve the information of struct cfs_rq + 0x10 in the
> register instead of a pointer type to the child field at 0x10.
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
> Multi-register addressing modes in LEA are not supported.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 121 +++++++++++++++++++-
>  tools/perf/util/annotate-data.c             |  17 ++-
>  tools/perf/util/annotate-data.h             |   6 +
>  3 files changed, 136 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 698cbb299c6d..cfb07cff8fc8 100644
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
> @@ -291,6 +293,16 @@ static void update_insn_state_x86(struct type_state *state,
>  		else
>  			return;
>  
> +		/* Ignore add to non-pointer types like int */

Probably we want to update TSR_KIND_CONST imm_value as well.


> +		if (tsr->kind == TSR_KIND_POINTER ||
> +		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
> +		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
> +			tsr->offset += imm_value;
> +			pr_debug_dtp("add [%x] offset %#"PRIx64" to reg%d",
> +				     insn_offset, imm_value, dst->reg1);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +
>  		if (tsr->kind != TSR_KIND_PERCPU_BASE)
>  			return;
>  
> @@ -302,6 +314,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			 */
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_PERCPU_POINTER;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
> @@ -311,6 +324,93 @@ static void update_insn_state_x86(struct type_state *state,
>  		return;
>  	}
>  
> +	if (!strncmp(dl->ins.name, "sub", 3)) {
> +		u64 imm_value = -1ULL;
> +
> +		if (!has_reg_type(state, dst->reg1))
> +			return;
> +
> +		tsr = &state->regs[dst->reg1];
> +		tsr->copied_from = -1;
> +
> +		if (src->imm)
> +			imm_value = src->offset;
> +		else if (has_reg_type(state, src->reg1) &&
> +			 state->regs[src->reg1].kind == TSR_KIND_CONST)
> +			imm_value = state->regs[src->reg1].imm_value;
> +
> +		if (tsr->kind == TSR_KIND_POINTER ||

Ditto.


> +		    (dwarf_tag(&tsr->type) == DW_TAG_pointer_type &&
> +		     src->reg1 != DWARF_REG_PC && tsr->kind == TSR_KIND_TYPE && !dst->mem_ref)) {
> +			tsr->offset -= imm_value;
> +			pr_debug_dtp("sub [%x] offset %#"PRIx64" to reg%d",
> +				     insn_offset, imm_value, dst->reg1);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +	}
> +
> +	if (!strncmp(dl->ins.name, "lea", 3)) {
> +		int sreg = src->reg1;
> +		struct type_state_reg src_tsr;
> +
> +		if (!has_reg_type(state, sreg) ||
> +		    !has_reg_type(state, dst->reg1) ||
> +		    !src->mem_ref)
> +			return;
> +
> +		src_tsr = state->regs[sreg];
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
> +			tsr->type = stack->type;
> +			tsr->kind = TSR_KIND_POINTER;
> +			tsr->offset = offset - stack->offset;
> +			tsr->ok = true;
> +
> +			if (sreg == fbreg) {
> +				pr_debug_dtp("lea [%x] address of -%#x(stack) -> reg%d",
> +					     insn_offset, -src->offset, dst->reg1);
> +			} else {
> +				pr_debug_dtp("lea [%x] address of %#x(reg%d) -> reg%d",
> +					     insn_offset, src->offset, sreg, dst->reg1);
> +			}
> +
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +		/* Case 2: Based on a register holding a typed pointer */
> +		else if (src_tsr.ok && src_tsr.kind == TSR_KIND_TYPE) {
> +
> +			/* Check if the target type has a member at the new offset */
> +			if (__die_get_real_type(&state->regs[sreg].type, &type_die) == NULL ||
> +			    die_get_member_type(&type_die,
> +					src->offset + src_tsr.offset, &type_die) == NULL)
> +				return;
> +
> +			tsr->type = src_tsr.type;
> +			tsr->kind = TSR_KIND_TYPE;

Did you mean TSR_KIND_POINTER?


> +			tsr->offset = src->offset + src_tsr.offset;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("lea [%x] address of %s%#x(reg%d) -> reg%d",
> +						insn_offset, src->offset < 0 ? "-" : "",
> +						abs(src->offset), sreg, dst->reg1);
> +
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +		return;
> +	}
> +
>  	if (strncmp(dl->ins.name, "mov", 3))
>  		return;
>  
> @@ -345,6 +445,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			if (var_addr == 40) {
>  				tsr->kind = TSR_KIND_CANARY;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  
>  				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
> @@ -361,6 +462,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
> @@ -372,6 +474,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		if (src->imm) {
>  			tsr->kind = TSR_KIND_CONST;
>  			tsr->imm_value = src->offset;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
> @@ -388,6 +491,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		tsr->type = state->regs[src->reg1].type;
>  		tsr->kind = state->regs[src->reg1].kind;
>  		tsr->imm_value = state->regs[src->reg1].imm_value;
> +		tsr->offset = state->regs[src->reg1].offset;
>  		tsr->ok = true;
>  
>  		/* To copy back the variable type later (hopefully) */
> @@ -421,16 +525,19 @@ static void update_insn_state_x86(struct type_state *state,
>  			} else if (stack->kind == TSR_KIND_POINTER) {
>  				tsr->type = stack->type;
>  				tsr->kind = stack->kind;
> +				tsr->offset = 0;
>  				tsr->ok = true;
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
> @@ -450,9 +557,10 @@ static void update_insn_state_x86(struct type_state *state,
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
> @@ -463,9 +571,10 @@ static void update_insn_state_x86(struct type_state *state,
>  		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
>  			 state->regs[sreg].kind == TSR_KIND_POINTER &&
>  			 die_get_member_type(&state->regs[sreg].type,
> -					     src->offset, &type_die)) {
> +					     src->offset + state->regs[sreg].offset, &type_die)) {
>  			tsr->type = state->regs[sreg].type;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = src->offset + state->regs[sreg].offset;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] addr %#x(reg%d) -> reg%d",
> @@ -490,6 +599,7 @@ static void update_insn_state_x86(struct type_state *state,
>  
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
> @@ -521,6 +631,7 @@ static void update_insn_state_x86(struct type_state *state,
>  			    die_get_member_type(&type_die, offset, &type_die)) {
>  				tsr->type = type_die;
>  				tsr->kind = TSR_KIND_TYPE;
> +				tsr->offset = 0;
>  				tsr->ok = true;
>  
>  				if (src->multi_regs) {
> @@ -543,6 +654,7 @@ static void update_insn_state_x86(struct type_state *state,
>  					     src->offset, &type_die)) {
>  			tsr->type = type_die;
>  			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
>  			tsr->ok = true;
>  
>  			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
> @@ -565,6 +677,7 @@ static void update_insn_state_x86(struct type_state *state,
>  							&var_name, &offset) &&
>  				    !strcmp(var_name, "__per_cpu_offset")) {
>  					tsr->kind = TSR_KIND_PERCPU_BASE;
> +					tsr->offset = 0;
>  					tsr->ok = true;
>  
>  					pr_debug_dtp("mov [%x] percpu base reg%d\n",
> @@ -613,6 +726,10 @@ static void update_insn_state_x86(struct type_state *state,
>  				pr_debug_dtp("mov [%x] reg%d -> %#x(reg%d)",
>  					     insn_offset, src->reg1, offset, dst->reg1);
>  			}
> +			if (tsr->offset != 0)

Parentheses please.

Thanks,
Namhyung


> +				pr_debug_dtp(" reg%d offset %#x ->",
> +					src->reg1, tsr->offset);
> +
>  			pr_debug_type_name(&tsr->type, tsr->kind);
>  		}
>  		/*
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 31b5896276f1..6ca5489f3c4c 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -898,7 +898,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  					     insn_offset, -offset);
>  			}
>  			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
> -		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
> +		} else if (has_reg_type(state, var->reg)) {
>  			struct type_state_reg *reg;
>  			Dwarf_Die orig_type;
>  
> @@ -914,6 +914,7 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  				    !is_better_type(&reg->type, &mem_die))
>  					continue;
>  
> +				reg->offset = -var->offset;
>  				reg->type = mem_die;
>  				reg->kind = TSR_KIND_POINTER;
>  				reg->ok = true;
> @@ -925,13 +926,17 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  			}
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
> +			pr_debug_dtp("var [%"PRIx64"] reg%d offset %x",
> +				     insn_offset, var->reg, var->offset);
>  			pr_debug_type_name(&mem_die, TSR_KIND_TYPE);
>  
>  			/*
> @@ -1119,7 +1124,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		if (__die_get_real_type(&state->regs[reg].type, type_die) == NULL)
>  			return PERF_TMR_NO_POINTER;
>  
> -		dloc->type_offset = dloc->op->offset;
> +		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
>  
>  		if (dwarf_tag(type_die) == DW_TAG_typedef)
>  			die_get_real_type(type_die, &sized_type);
> @@ -1148,7 +1153,7 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		 */
>  		*type_die = state->regs[reg].type;
>  
> -		dloc->type_offset = dloc->op->offset;
> +		dloc->type_offset = dloc->op->offset + state->regs[reg].offset;
>  
>  		/* Get the size of the actual type */
>  		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index fd0d1084bc4e..20237e7e4e2f 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -174,6 +174,12 @@ extern struct annotated_data_stat ann_data_stat;
>  struct type_state_reg {
>  	Dwarf_Die type;
>  	u32 imm_value;
> +	/*
> +	 * The offset within the struct that the register points to.
> +	 * A value of 0 means the register points to the beginning.
> +	 * type_offset = op->offset + reg->offset
> +	 */
> +	s32 offset;
>  	bool ok;
>  	bool caller_saved;
>  	u8 kind;
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
