Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E03A3624AE;
	Tue, 11 Aug 2026 07:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786433792; cv=none; b=pMpDKTLBq/bKAAkg4W0jvQi0ULtaRdE+1JmcVFWHtoNpyDvo4E+whMOiRjWZrpMJ+88bwW/oEUh4FGfwQGUmk7se0J6j6Z9L6enNhUHr63hg9/QHjxXYHn67e+zPnv20+5OfP46pfpDul2tL4Q2vUXypimjGI/mwD1krY8mGIjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786433792; c=relaxed/simple;
	bh=fCi2gRhBxAu54qHmqn9S5KmIbGX2veFmQZ/5N5PeZjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuPO5JfHc2WGrIGcZmRL37yolIK9lF5GkNgWzUdupLCMlH0Yb5b7ISB/HYMr3l2aDmWYoc5mt3LUS5gZCeMO1j7/ZdwyR8jcYg7cwTxWFVuv+QND5neo8Zmk9QsuunUuUO6m71GaQwze/Wrc0qSFSDxPStaKVrB5DU11nv0FSII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=u0VbK2Ys; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="u0VbK2Ys"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786433783; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Z8/rGFypNworLnJxBufnGBTSLJTYGMtLBqHwVEDmcsQ=;
	b=u0VbK2Ysw0RB0yfBGcaSQ/PlV3Gt4RtgjY5MgYrnxgMIxBOwsEAaMl7mA9rrf+Uo+pwsWkQYu+3vmaUXcRNQhnvrny1xDODJ2ZUARLi62GbU0bRxaJ9Vqdidc0ZM1JhuU7Q0Y1p2iYC6MHgM148feFqqF/mgFIp8fGUGGgp+2uc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8ncpQQ_1786433780;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8ncpQQ_1786433780 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 15:36:21 +0800
Message-ID: <d61a0cbb-373f-4bc6-8493-889a76e27e87@linux.alibaba.com>
Date: Tue, 11 Aug 2026 15:36:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/23] perf annotate-arm64: Support load instruction
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
 <20260808122400.2961238-15-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-15-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state_arm64() to handle LDR instructions, tracking
> register state changes when data is loaded from memory to registers.
> 
> The implementation handles the three primary arm64 addressing modes:
> 1. Signed offset: [base, #imm|reg]
> 2. Pre-index: [base, #imm]!
> 3. Post-index: [base], #imm
> 
> Before updating, check the addressing mode via get_reg_index_offset() to
> obtain the actual source's reg_offset, and then propagate the type.
> 
> Since a load instruction may have two destination registers (in ldp cases),
> introduce propagate_load_reg_state() to propagate the type for a specified
> destination register using a given reg_offset. The respective reg_offset
> values for the two registers are as follows:
> 
>    dst->reg1: reg_offset = get_reg_index_offset()
>    dst->reg2: reg_offset = get_reg_index_offset() + reg_size(dst->reg1)
> 
> Finally, handle the side effects of pre-index and post-index addressing
> via adjust_reg_index_state().
> 
> A real-world example is shown below:
> 
>    ffff80008011f5b0 <pick_task_stop>:
>    ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
> * ffff80008011f5c0:  ldr  w1, [x0, #104]
> 
> Before this commit, the type of x0 was incorrectly inferred as 'struct rq':
> 
>    find data type for 0x68(reg0) at pick_task_stop+0x10
>    var [8] reg0 offset 0 type='struct rq*'
>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct rq*) : Good!
>    final result:  type='struct rq'
> 
> After this commit, the type of x0 is correctly inferred as 'struct task_struct':
> 
>    find data type for 0x68(reg0) at pick_task_stop+0x10
>    var [8] reg0 offset 0 type='struct rq*'
>    ldr [8] 0xa98(reg0) -> reg0 type='struct task_struct*'
>    chk [10] reg0 offset=0x68 ok=1 kind=1 (struct task_struct*) : Good!
>    final result: type='struct task_struct'
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 148 +++++++++++++++++-
>   1 file changed, 147 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index acff14ca01e0..6557c0ad11b2 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct arch *arch,
>   }
>   
>   #ifdef HAVE_LIBDW_SUPPORT
> +static int arm64__reg_size(const char *reg)
> +{
> +	if (!reg || !*reg || !arm64__is_reg(reg))
> +		return -1;

Since arm64__is_reg() rejects xzr and SIMD registers, something like
ldp xzr, x19, [sp] ends up with multi_regs = false and x19 never
invalidated or tracked. Admittedly a corner case - but maybe worth
handling if extending the register set is cheap.


> +	if (reg[0] == 'w')
> +		return 4;
> +
> +	if (reg[0] == 'x' || !strncmp(reg, "sp", 2))
> +		return 8;
> +
> +	return -1;
> +}
> +
> +static int get_reg_index_offset(struct annotated_op_loc *op_loc)
> +{
> +	return op_loc->addr_mode == PERF_ADDR_MODE_POST_INDEX ? 0 : op_loc->offset;
> +}
> +
> +/* Apply addressing mode (pre-index, post-index) to register state */
> +static void adjust_reg_index_state(struct type_state *state,
> +				   struct annotated_op_loc *op_loc,
> +				   const char *insn_name, u32 insn_offset)
> +{
> +	struct type_state_reg *tsr;
> +	int reg = op_loc->reg1;
> +
> +	if (op_loc->addr_mode != PERF_ADDR_MODE_PRE_INDEX &&
> +	    op_loc->addr_mode != PERF_ADDR_MODE_POST_INDEX)
> +		return;
> +
> +	if (!has_reg_type(state, reg) || !state->regs[reg].ok)
> +		return;
> +
> +	tsr = &state->regs[reg];
> +	tsr->copied_from = -1;
> +	tsr->offset = op_loc->offset + tsr->offset;
> +
> +	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", insn_name,
> +		     insn_offset, op_loc->addr_mode == PERF_ADDR_MODE_PRE_INDEX ?
> +		     "pre" : "post", op_loc->offset, reg, reg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}
> +
> +/*
> + * For load insns: propagate type from @src to @dreg, applying @reg_offset
> + * to the source struct's field offset.
> + */
> +static int propagate_load_reg_state(struct type_state *state,
> +				    struct disasm_line *dl, int dreg,
> +				    struct annotated_op_loc *src,
> +				    int reg_offset, const char *insn_name)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg src_tsr;
> +	Dwarf_Die type_die;
> +	u32 insn_offset = dl->al.offset;
> +	int sreg = src->reg1;
> +
> +	if (!has_reg_type(state, dreg))
> +		return -1;
> +
> +	tsr = &state->regs[dreg];
> +	tsr->copied_from = -1;
> +
> +retry:
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok)
> +		return -1;
> +
> +	src_tsr = state->regs[sreg];
> +
> +	/* Dereference the pointer if it has one */
> +	if (src_tsr.kind == TSR_KIND_TYPE &&
> +	    die_deref_ptr_type(&src_tsr.type,
> +			       src_tsr.offset + reg_offset, &type_die)) {
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->offset = 0;
> +		tsr->ok = true;
> +
> +		if (src->multi_regs) {
> +			pr_debug_dtp("%s [%x] %#x(reg%d, reg%d) -> reg%d",
> +				     insn_name, insn_offset, reg_offset,
> +				     src->reg1, src->reg2, dreg);
> +		} else {
> +			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
> +				     insn_name, insn_offset, reg_offset,
> +				     sreg, dreg);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
> +	/* Or try another register if any */
> +	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
> +		sreg = src->reg2;
> +		goto retry;
> +	}
> +
> +	return -1;
> +}
> +
> +static void update_load_insn_state(struct type_state *state,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{
> +	int reg_offset = get_reg_index_offset(src);
> +	const char *insn_name = dst->multi_regs ? "ldp" : "ldr";
> +
> +	if (!has_reg_type(state, dst->reg1) ||
> +	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
> +		goto out_err_adjust;
> +
> +	/* Handle the first destination register */
> +	if (propagate_load_reg_state(state, dl, dst->reg1, src,
> +				     reg_offset, insn_name))
> +		goto out_err_adjust;
> +
> +	/* Handle the second destination register (ldp only) */
> +	if (dst->multi_regs) {
> +		int reg_size = arm64__reg_size(dl->ops.target.raw);

Two issues here:

First, propagate_load_reg_state() snapshots state->regs[sreg] at call
time. For an aliased pair like ldp x0, x1, [x0], the first call
overwrites x0, and the second call then reads the freshly loaded type
as the base instead of the original one. Better snapshot the source
state once in update_load_insn_state() and pass it down.

Second, ldpsw loads two 32-bit words from memory (sign-extended into
x-registers), so the element spacing is 4, not the 8 that
arm64__reg_size() derives from the destination register. The element
size needs to come from the mnemonic.


> +
> +		if (reg_size < 0 ||
> +		    propagate_load_reg_state(state, dl, dst->reg2, src,
> +					     reg_offset + reg_size, insn_name))
> +			goto out_err_adjust;
> +	}
> +
> +out_adjust:
> +	adjust_reg_index_state(state, src, insn_name, dl->al.offset);
> +	return;
> +
> +out_err_adjust:
> +	if (has_reg_type(state, dst->reg1))
> +		invalidate_reg_state(&state->regs[dst->reg1]);
> +	if (dst->multi_regs && has_reg_type(state, dst->reg2))
> +		invalidate_reg_state(&state->regs[dst->reg2]);
> +	goto out_adjust;
> +}
> +
>   static void update_insn_state_arm64(struct type_state *state,
>   				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>   				    struct disasm_line *dl)
>   {
>   	struct annotated_insn_loc loc;
> +	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
>   	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
>   	u32 insn_offset = dl->al.offset;
>   
> @@ -418,7 +559,8 @@ static void update_insn_state_arm64(struct type_state *state,
>   	 * Invalidate destination register(s) for unsupported instructions to
>   	 * prevent stale type info from propagating to subsequent instructions.
>   	 */
> -	if (has_reg_type(state, dst->reg1)) {
> +	if (has_reg_type(state, dst->reg1) &&
> +	    strncmp(dl->ins.name, "ld", 2)) {

For stores the operands are reversed, so dst is the memory operand
and dst->reg1 is the base register. This then invalidates the base
pointer on every store, which is exactly the state we need to resolve
the memory access type. The x86 version guards this with
!dst->mem_ref; arm64 should too:

     if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
         strncmp(dl->ins.name, "ld", 2)) {


Thanks.
Shuai
