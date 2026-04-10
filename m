Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8691A5B8A;
	Fri, 10 Apr 2026 06:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802597; cv=none; b=rRbHofMn0C0cx5/ROXw9PkP1JmBpKY86x0qEM2Nhq13gsokdHabW1ukxe9vwXt8kvl1/BfIEEw/EejKxB0OPUPoPlm6Ldw81QD0Ox27Ad5hx0yh8kzF23wi5w+YcLDgy+gtoKpNKerjlkHR9XxuxZYAOkLT9aJSNVpe+gb8vAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802597; c=relaxed/simple;
	bh=Jf209jy2LDsgcZ7zir3N7eEGWXJlCBdNbzZVbtQLir4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVLPL1t6YyxZJ2/+CAW9W4+nu0ZJkJGd+5zpnEZNbXyCfPfjbn+c/MzqFo6Xis/Qd6JmDkR4uLizx0K1atScnW02/IUwkgfjoThABB9iLf5dOqJDzjLdcI1N8fohGcK0cYsM3I504gR/gWlWKgeOZ9zA3POIryBN4VVKlkjpkLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYLMIQjS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYLMIQjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E26ADC19421;
	Fri, 10 Apr 2026 06:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802597;
	bh=Jf209jy2LDsgcZ7zir3N7eEGWXJlCBdNbzZVbtQLir4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYLMIQjS1YSvI/UvJgXHVFLjyZr+Z4AHGj2NtNJdhb5eRMYzyGAHzLENK/RyA20i5
	 wiVMeqaXUgloNoDv2MZPmK76heEK27H288oZ3E+dW7/QOe3x3PkEkGTBTrhJzGjuJ2
	 CvL9ijvcdebBZ22OF8n4l7HTodpdRjRRL1XDlWnJNpA/jzvvAaBrYRVbddT+9RGpES
	 M6JfOTKIDJecUBjEx7LEBKa/zQ/OdFHUF/i15LWR8iMIPy1Bl65mhaXl+CJkOjOFeo
	 JlRmfF2Q8Myh+D4X57Muqs3B0g3wh226WBZbJfs2rr+JrTXY8ThtCPIQNiav7/IDW6
	 r68WZ8v17vE3g==
Date: Thu, 9 Apr 2026 23:29:55 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 11/16] perf annotate-arm64: Support stack variable
 tracking
Message-ID: <adiY4xJ9269L70mM@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-12-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-12-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:55AM +0000, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to track data types stored on the
> stack. This allows 'perf annotate' to maintain type information for
> local variables that are spilled to or loaded from stack slots.
> 
> The implementation handles:
> 1. Stack Loads (LDR): Identify when a register is loaded from a stack
>    slot and update the register's type state based on the tracked
>    stack content or compound member types.
> 2. Stack Stores (STR): Update or create new stack state entries when
>    a tracked register type is stored to the stack.
> 
> This enables the instruction tracker to follow data types as they move
> between registers and memory, specifically for function local variables
> and compiler-spilled values on arm64.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 83 ++++++++++++++++++-
>  1 file changed, 80 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 28647a778802..f9100230c2f6 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -11,6 +11,8 @@
>  #include "../disasm.h"
>  #include "../annotate-data.h"
>  #include "../debug.h"
> +#include "../map.h"
> +#include "../symbol.h"
>  
>  struct arch_arm64 {
>  	struct arch arch;
> @@ -297,6 +299,8 @@ static void update_insn_state_arm64(struct type_state *state,
>  	Dwarf_Die type_die;
>  	u32 insn_offset = dl->al.offset;
>  	int sreg, dreg;
> +	int fbreg = dloc->fbreg;
> +	int fboff = 0;
>  
>  	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
>  		return;
> @@ -304,17 +308,59 @@ static void update_insn_state_arm64(struct type_state *state,
>  	sreg = src->reg1;
>  	dreg = dst->reg1;
>  
> +	if (dloc->fb_cfa) {
> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> +		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
> +			fbreg = -1;
> +	}
> +
>  	/* Memory to register transfers */
>  	if (!strncmp(dl->ins.name, "ld", 2)) {
>  		struct type_state_reg dst_tsr;
>  
> -		if (!has_reg_type(state, sreg) ||
> -		    !has_reg_type(state, dreg) ||
> -		    !state->regs[dreg].ok)
> +		if (!has_reg_type(state, sreg))
>  			return;
>  
>  		tsr = &state->regs[sreg];
>  		tsr->copied_from = -1;
> +
> +		/* Check stack variables with offset */
> +		if (sreg == fbreg || sreg == state->stack_reg) {
> +			struct type_state_stack *stack;
> +			int offset = src->offset - fboff;
> +
> +			stack = find_stack_state(state, offset);
> +			if (stack == NULL) {
> +				tsr->ok = false;
> +				return;
> +			} else if (!stack->compound) {
> +				tsr->type = stack->type;
> +				tsr->kind = stack->kind;
> +				tsr->offset = stack->ptr_offset;
> +				tsr->ok = true;
> +			} else if (die_get_member_type(&stack->type,
> +						       offset - stack->offset,
> +						       &type_die)) {
> +				tsr->type = type_die;
> +				tsr->kind = TSR_KIND_TYPE;
> +				tsr->offset = 0;
> +				tsr->ok = true;
> +			} else {
> +				tsr->ok = false;
> +				return;
> +			}
> +
> +			pr_debug_dtp("ldr [%x] -%#x(stack) -> reg%d",
> +				     insn_offset, -offset, sreg);
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +			return;

Any chance the stack register changes the offset with the addressing
mode?  I think it should be updated regardless of the result of this
operation.

> +		}
> +
> +		if (!has_reg_type(state, dreg) || !state->regs[dreg].ok)
> +			return;
> +
>  		dst_tsr = state->regs[dreg];
>  
>  		/* Dereference the pointer if it has one */
> @@ -338,6 +384,37 @@ static void update_insn_state_arm64(struct type_state *state,
>  
>  	/* Register to memory transfers */
>  	if (!strncmp(dl->ins.name, "st", 2)) {
> +		/* Check stack variables with offset */
> +		if (dreg == fbreg || dreg == state->stack_reg) {
> +			struct type_state_stack *stack;
> +			int offset = dst->offset - fboff;
> +
> +			if (!has_reg_type(state, sreg) ||
> +			    !state->regs[sreg].ok)
> +				return;
> +
> +			tsr = &state->regs[sreg];
> +
> +			stack = find_stack_state(state, offset);
> +			if (stack) {
> +				if (!stack->compound)
> +					set_stack_state(stack, offset, tsr->kind,
> +							&tsr->type, tsr->offset);
> +			} else {
> +				findnew_stack_state(state, offset, tsr->kind,
> +						    &tsr->type, tsr->offset);
> +			}
> +
> +			pr_debug_dtp("str [%x] reg%d -> -%#x(stack)",
> +				     insn_offset, sreg, -offset);
> +			if (tsr->offset != 0) {
> +				pr_debug_dtp(" reg%d offset %#x ->",
> +					     sreg, tsr->offset);
> +			}
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +			return;

Ditto.

Thanks,
Namhyung


> +		}
> +
>  		/*
>  		 * Store instructions do not change the register type,
>  		 * but the base register must be updated for pre/post-index
> -- 
> 2.34.1
> 
