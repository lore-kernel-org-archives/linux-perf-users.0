Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8A134BA50;
	Fri,  3 Oct 2025 05:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759470742; cv=none; b=BT+djmYcaXBHqwokd59TSaACt3gIxVLy5pQqhnjFNyAXUysHCRfEYVatv8po7pDyGXBkuclelkAJgWtbtL2R/E/coLK7gU4i6qa1tbcf0QXfwpt3HIJhaZagVkF7SCNjbcKSuapp1gZPCwZayCpGeJi+wpe1TCXRNv+YWFnkSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759470742; c=relaxed/simple;
	bh=m8QTSeBYc+9dw9PyAe4KBzJKyia/JpiSrRnm+m8PQs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9oTUUhas4LKUUQI8dKaHmgq8PRiDT4iXaxOtNPIS5IHTfiebV0GNjUv+2yLU9eNKs1q0KINU8ab2YsqdCf5qWz4II7k6cAY8LKdhdpUbLc80waJNuwpErCjbKx2mk8fWUPI9FYQT0EZnByCYcvkMaquiIGsJQBmpDMDfLYElBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVs72cRd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVs72cRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D10C4CEF5;
	Fri,  3 Oct 2025 05:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759470742;
	bh=m8QTSeBYc+9dw9PyAe4KBzJKyia/JpiSrRnm+m8PQs4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVs72cRdC6opnIh/wtYkpdHvXaP0/DuIz25R/eClezmdN0G6+mvtgiV9NICKMqsEx
	 DalwV+5MIu/RaxEVlHiAOKmEpUV5c1+tV2gzqBYFhiWMNxIP+FroSa7kvT4ZJd+Ygi
	 X6vok8zceSdxzcL6owHtFummbN4JwtW28Apy1wkn6IWzwx7jWKs+rxTvbiI+vqWQY2
	 5wS+OCkSmdBgnzu2hQBCLqq0HvVnlUmWj6xX5/KITBPTPJ0k09dyWdof71rZKHKWqv
	 2zgUbL0JKBEbQETP7djYuImdbarxlHkZh/3d+nP7FB5JGxuNBzN0ZmwgwlopqS2yng
	 oddBJrhJyYnnQ==
Date: Fri, 3 Oct 2025 14:52:14 +0900
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
Subject: Re: [PATCH v3 03/10] perf annotate: Track address registers via
 TSR_KIND_POINTER
Message-ID: <aN9kjm4cLV6mp8Ep@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-4-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-4-zecheng@google.com>

On Wed, Sep 17, 2025 at 07:58:01PM +0000, Zecheng Li wrote:
> Introduce TSR_KIND_POINTER to improve the data type profiler's ability
> to track pointer-based memory accesses and address register variables.
> 
> TSR_KIND_POINTER represents a register that holds the address of the
> type in the `type_state_reg`. The semantics match the `breg` registers
> that describe a memory location.
> 
> This change implements handling for this new kind in mov instructions
> and in the check_matching_type() function. When a TSR_KIND_POINTER is
> moved to the stack, the stack state size is set to the architecture's
> pointer size.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 19 +++++++-
>  tools/perf/util/annotate-data.c             | 52 +++++++++++++++++++--
>  tools/perf/util/annotate-data.h             |  1 +
>  3 files changed, 66 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index da98a4e3c52c..698cbb299c6d 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -391,7 +391,7 @@ static void update_insn_state_x86(struct type_state *state,
>  		tsr->ok = true;
>  
>  		/* To copy back the variable type later (hopefully) */
> -		if (tsr->kind == TSR_KIND_TYPE)
> +		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
>  			tsr->copied_from = src->reg1;
>  
>  		pr_debug_dtp("mov [%x] reg%d -> reg%d",
> @@ -418,6 +418,10 @@ static void update_insn_state_x86(struct type_state *state,
>  			if (stack == NULL) {
>  				tsr->ok = false;
>  				return;
> +			} else if (stack->kind == TSR_KIND_POINTER) {
> +				tsr->type = stack->type;
> +				tsr->kind = stack->kind;
> +				tsr->ok = true;
>  			} else if (!stack->compound) {

Looks like you can reues the !stack->compound block below.  But you need
to update set_stack_state() not to set it for POINTER types.


>  				tsr->type = stack->type;
>  				tsr->kind = stack->kind;
> @@ -455,6 +459,19 @@ static void update_insn_state_x86(struct type_state *state,
>  				     insn_offset, src->offset, sreg, dst->reg1);
>  			pr_debug_type_name(&tsr->type, tsr->kind);
>  		}
> +		/* Handle dereference of TSR_KIND_POINTER registers */
> +		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
> +			 state->regs[sreg].kind == TSR_KIND_POINTER &&
> +			 die_get_member_type(&state->regs[sreg].type,
> +					     src->offset, &type_die)) {
> +			tsr->type = state->regs[sreg].type;
> +			tsr->kind = TSR_KIND_TYPE;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("mov [%x] addr %#x(reg%d) -> reg%d",
> +				     insn_offset, src->offset, sreg, dst->reg1);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
>  		/* Or check if it's a global variable */
>  		else if (sreg == DWARF_REG_PC) {
>  			struct map_symbol *ms = dloc->ms;
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 903027a6fb7d..31b5896276f1 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -59,6 +59,10 @@ void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
>  		pr_info(" constant\n");
>  		return;
>  	case TSR_KIND_PERCPU_POINTER:
> +		pr_info(" percpu pointer");
> +		/* it also prints the type info */
> +		break;
> +	case TSR_KIND_POINTER:
>  		pr_info(" pointer");
>  		/* it also prints the type info */
>  		break;
> @@ -578,7 +582,9 @@ void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
>  	int tag;
>  	Dwarf_Word size;
>  
> -	if (dwarf_aggregate_size(type_die, &size) < 0)
> +	if (kind == TSR_KIND_POINTER)
> +		size = 8;

Maybe better to use 'sizeof(void *)'.  Later, we may support different
architectures with different pointer size, but that would need many more
work, I guess. :)

Thanks,
Namhyung


> +	else if (dwarf_aggregate_size(type_die, &size) < 0)
>  		size = 0;
>  
>  	tag = dwarf_tag(type_die);
> @@ -898,13 +904,25 @@ static void update_var_state(struct type_state *state, struct data_loc_info *dlo
>  
>  			reg = &state->regs[var->reg];
>  
> -			/* For gp registers, skip the address registers for now */
> -			if (var->is_reg_var_addr)
> +			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
> +			   (!is_better_type(&reg->type, &mem_die) || var->is_reg_var_addr))
>  				continue;
>  
> -			if (reg->ok && reg->kind == TSR_KIND_TYPE &&
> -			    !is_better_type(&reg->type, &mem_die))
> +			/* Handle address registers with TSR_KIND_POINTER */
> +			if (var->is_reg_var_addr) {
> +				if (reg->ok && reg->kind == TSR_KIND_POINTER &&
> +				    !is_better_type(&reg->type, &mem_die))
> +					continue;
> +
> +				reg->type = mem_die;
> +				reg->kind = TSR_KIND_POINTER;
> +				reg->ok = true;
> +
> +				pr_debug_dtp("var [%"PRIx64"] reg%d addr offset %x",
> +					     insn_offset, var->reg, var->offset);
> +				pr_debug_type_name(&mem_die, TSR_KIND_POINTER);
>  				continue;
> +			}
>  
>  			orig_type = reg->type;
>  
> @@ -1116,6 +1134,30 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  		return PERF_TMR_OK;
>  	}
>  
> +	if (state->regs[reg].kind == TSR_KIND_POINTER) {
> +		struct strbuf sb;
> +
> +		strbuf_init(&sb, 32);
> +		die_get_typename_from_type(&state->regs[reg].type, &sb);
> +		pr_debug_dtp("(ptr->%s)", sb.buf);
> +		strbuf_release(&sb);
> +
> +		/*
> +		 * Register holds a pointer (address) to the target variable.
> +		 * The type is the type of the variable it points to.
> +		 */
> +		*type_die = state->regs[reg].type;
> +
> +		dloc->type_offset = dloc->op->offset;
> +
> +		/* Get the size of the actual type */
> +		if (dwarf_aggregate_size(type_die, &size) < 0 ||
> +		    (unsigned)dloc->type_offset >= size)
> +			return PERF_TMR_BAD_OFFSET;
> +
> +		return PERF_TMR_OK;
> +	}
> +
>  	if (state->regs[reg].kind == TSR_KIND_PERCPU_POINTER) {
>  		pr_debug_dtp("percpu ptr");
>  
> diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
> index dd3807b55208..fd0d1084bc4e 100644
> --- a/tools/perf/util/annotate-data.h
> +++ b/tools/perf/util/annotate-data.h
> @@ -35,6 +35,7 @@ enum type_state_kind {
>  	TSR_KIND_PERCPU_BASE,
>  	TSR_KIND_CONST,
>  	TSR_KIND_PERCPU_POINTER,
> +	TSR_KIND_POINTER,
>  	TSR_KIND_CANARY,
>  };
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
