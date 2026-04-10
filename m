Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A981A6815;
	Fri, 10 Apr 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775802211; cv=none; b=mmVStmhVAXqImGa8xtDHzJ3LFNm9sLTGXdmo9AzBv7zbpfoi3qNCKzsg2q1Om7GqVODulv/QxLLKWMW4My59uFXJKOlHyQYDfdRc+zXEv31Dww175NZvpNARrs5VFWXzo1LJrJu0WaJ5eSu7aJdIbAn/hpNSP1BlW9Opp0v+38U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775802211; c=relaxed/simple;
	bh=X6atv7HzsPDdly2XaT790cPfkbDmQNxS5Z/c6U8JedY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sc1s/9NO2aRnvnXMUrBckwmi86g8B16JvYmjFFtzld+HfFh+aT/vESRAbnc3QOpDJIUc04kwMTmn6ANaALTkjt793fnNG+xc2BlK/jEIH1qe7/4wD1mHRCzqLh6dz19pppwfhIo4BsfMTdijQEc9hYSR8BYXaSJIwruONk9NLcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMT1vl5A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMT1vl5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4356BC19421;
	Fri, 10 Apr 2026 06:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775802211;
	bh=X6atv7HzsPDdly2XaT790cPfkbDmQNxS5Z/c6U8JedY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hMT1vl5AkY7QrA9XuXIlD7AcZKrl2q6GjgXVLFtErCvzL7NF73DeSRXPx1wCkVLuf
	 8OB0qPxD/DwgSEjAspqYhoL7rcHWiIDEuf2p3A2eI5t868G1MO1K6OAokQs1O1JOl/
	 mepUKaSmgrsRiMNjWqOIxIRqjEKveptGiAAO7lASURAAI+A4kHghApCGwNI4MDixeK
	 DXFBuojk96SX7mtMO/zfxjQetCQoKlc+BpuQpjjfsf81vv5GLVB/NsVLxRzEygBeH3
	 WNjJ2BMdyAmZTM6gTdgPCXl03E19SC4bCugEoB7MlHVVJ9vgdAY2YetdldhtTYeNWg
	 /IpQ5AJyfCjRQ==
Date: Thu, 9 Apr 2026 23:23:28 -0700
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
Subject: Re: [PATCH v2 09/16] perf annotate-arm64: Support load instruction
 tracking
Message-ID: <adiXYBhkEpbBR0ZA@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-10-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-10-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:53AM +0000, Tengda Wu wrote:
> Implement update_insn_state() for arm64 to track register state changes
> during load (LDR) instructions. This is essential for maintaining accurate
> type information when data is moved from memory to registers.
> 
> The implementation handles the three primary arm64 addressing modes:
> 1. Signed offset: [base, #imm]
> 2. Pre-index: [base, #imm]!
> 3. Post-index: [base], #imm
> 
> Introduce adjust_reg_index_state() to handle the side effects of pre-index
> and post-index addressing, where the base register is updated with the
> offset after or before the memory access. This ensures that the register's
> offset within a structure is correctly tracked across sequential
> instructions.
> 
> A real-world example is shown below:
> 
>   ffff80008011f5b0 <pick_task_stop>:
>   ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
>   ffff80008011f5c0:  ldr  w1, [x0, #104]  // PMU sample at offset 0x68
> 
> Before this commit, the type of x0 was incorrectly inferred as 'struct rq':
> 
>   find data type for 0x68(reg0) at pick_task_stop+0x10
>   var [8] reg0 offset 0 type='struct rq*'
>   chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
>   final result:  type='struct rq'
> 
> After this commit, the type of x0 is correctly inferred as 'struct task_struct':
> 
>   find data type for 0x68(reg0) at pick_task_stop+0x10
>   var [8] reg0 offset 0 type='struct rq*'
>   ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
>   chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
>   final result: type='struct task_struct'
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 1fe4c503431b..cac2bf0021c9 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -9,6 +9,8 @@
>  #include <regex.h>
>  #include "../annotate.h"
>  #include "../disasm.h"
> +#include "../annotate-data.h"
> +#include "../debug.h"
>  
>  struct arch_arm64 {
>  	struct arch arch;
> @@ -254,6 +256,88 @@ static int extract_op_location_arm64(const struct arch *arch,
>  	return 0;
>  }
>  
> +#ifdef HAVE_LIBDW_SUPPORT
> +static int get_mem_offset(struct annotated_op_loc *op_loc, int type_offset)
> +{
> +	if (op_loc->addr_mode == INSN_ADDR_POST_INDEX)
> +		return type_offset;
> +
> +	return op_loc->offset + type_offset;
> +}
> +
> +static void adjust_reg_index_state(struct type_state *state, int reg,
> +				   struct annotated_op_loc *op_loc,
> +				   const char *insn_name, u32 insn_offset)
> +{
> +	struct type_state_reg *tsr;
> +
> +	if (!has_reg_type(state, reg) ||
> +	    (op_loc->addr_mode != INSN_ADDR_PRE_INDEX &&
> +	    op_loc->addr_mode != INSN_ADDR_POST_INDEX))
> +		return;
> +
> +	tsr = &state->regs[reg];
> +	tsr->offset = op_loc->offset + tsr->offset;
> +	tsr->ok = true;

Maybe we can skip setting 'ok' here?


> +
> +	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
> +		     insn_offset, op_loc->addr_mode == INSN_ADDR_PRE_INDEX ?
> +		     "pre" : "post", op_loc->offset, reg, reg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}
> +
> +static void update_insn_state_arm64(struct type_state *state,
> +				    struct data_loc_info *dloc, Dwarf_Die * cu_die __maybe_unused,
> +				    struct disasm_line *dl)
> +{
> +	struct annotated_insn_loc loc;
> +	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
> +	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
> +	struct type_state_reg *tsr;
> +	Dwarf_Die type_die;
> +	u32 insn_offset = dl->al.offset;
> +	int sreg, dreg;
> +
> +	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
> +		return;
> +
> +	sreg = src->reg1;
> +	dreg = dst->reg1;
> +
> +	/* Memory to register transfers */
> +	if (!strncmp(dl->ins.name, "ld", 2)) {
> +		struct type_state_reg dst_tsr;
> +
> +		if (!has_reg_type(state, sreg) ||
> +		    !has_reg_type(state, dreg) ||
> +		    !state->regs[dreg].ok)
> +			return;

I think we should set state->regs[sreg].ok to false if sreg is valid.

> +
> +		tsr = &state->regs[sreg];
> +		tsr->copied_from = -1;
> +		dst_tsr = state->regs[dreg];
> +
> +		/* Dereference the pointer if it has one */
> +		if (dst_tsr.kind == TSR_KIND_TYPE &&
> +		    die_deref_ptr_type(&dst_tsr.type,
> +				       get_mem_offset(dst, dst_tsr.offset),
> +				       &type_die)) {
> +			tsr->type = type_die;
> +			tsr->kind = TSR_KIND_TYPE;
> +			tsr->offset = 0;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
> +				     insn_offset, dst->offset, dreg, sreg);

It could confuse people since src and dst are opposite.  Maybe you can
change the parse function to set the source and target (destination)
properly for each instruction.


> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +
> +			adjust_reg_index_state(state, dreg, dst, "ldr", insn_offset);
> +		}

Also you will need to update index offset and set the 'ok' state
properly.

Thanks,
Namhyung

> +		return;
> +	}
> +}
> +#endif
> +
>  const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  				   const char *cpuid __maybe_unused)
>  {
> @@ -273,6 +357,9 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	arch->objdump.imm_char		  = '#';
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>  	arch->extract_op_location	  = extract_op_location_arm64;
> +#ifdef HAVE_LIBDW_SUPPORT
> +	arch->update_insn_state		  = update_insn_state_arm64;
> +#endif
>  
>  	/* bl, blr */
>  	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
> -- 
> 2.34.1
> 
