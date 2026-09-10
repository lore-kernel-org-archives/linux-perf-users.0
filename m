Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B9473C66;
	Thu, 10 Sep 2026 13:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046903; cv=none; b=Q/n2ohk0OKnt5GpZyew7M12AYm7M+XvtR2JcgQHcjP+WkWq6p90xUCYrctvjGEl/2p4ZId7mVb8JqoJTwH/0qtWB3crYarxQpTaTEAwmeYTQJi882P8inutizV4gyZFTwhmfuaTxIBCyB4w6ZI09+lqFXZ1TR2TyuZrAiTK+MMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046903; c=relaxed/simple;
	bh=is4y/Wbig/+hIcGa3/uG22FoYUrdv+wHRiftcB9BI+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UjQWduxGiaBnXBvmsc5Jf3pmpcr/TxlKs7Gx8psyaQR5rgGLcWTyUxD28xwKnYPKDHCjIZe/xCWCuwuJm3HrEJQ+16pmFkD9Kf942KJXqHMKsopJO5hiJOpt4g+L0fiIQfrjlwoXHuFtINz8O9qKcJywapH5MXt7M0EyWNBCJB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hgdkw5DdgzYQvJB;
	Thu, 10 Sep 2026 21:27:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B069740561;
	Thu, 10 Sep 2026 21:28:15 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC3c7FusKJqGV3RBQ--.22169S2;
	Thu, 10 Sep 2026 21:28:15 +0800 (CST)
Message-ID: <994b292f-6d18-4023-8dcc-4370248c0b64@huaweicloud.com>
Date: Thu, 10 Sep 2026 21:28:14 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/26] perf annotate-arm64: Support load instruction
 tracking
To: Namhyung Kim <namhyung@kernel.org>, james.clark@linaro.org,
 xueshuai@linux.alibaba.com, Adrian Hunter <adrian.hunter@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a30c739f6462865d2ce4f8a780a12ec28bac707d.1788872630.git.wutengda@huaweicloud.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <a30c739f6462865d2ce4f8a780a12ec28bac707d.1788872630.git.wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3c7FusKJqGV3RBQ--.22169S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Zr48Gr4rKw1DGw1UJw1rXrb_yoWDAw13pF
	WDC343GrW2qr43WrsIqF48Wr9xuws2gr15uryUZa47tFsFyr1rKa95K3y2vF45GrWDuw13
	Xa1qkrnrXw42yaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxo
	7KDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:05, Tengda Wu wrote:
> Extend update_insn_state_arm64() to handle load instructions, tracking
> register state changes when data is loaded from memory to registers.
> 
> Two main categories are considered: standard load (e.g, ldr variants)
> and load pair (ldp), for example:
> 
>   ldr dst, [src, #imm]
>   ldp dst1, dst2, [src, #imm]
> 
> For data type propagation, a load pair can be treated as two standard
> loads combined, first loading dst1 and then dst2. The difference is
> that when loading dst2, an additional memory offset 'mem_offset' after
> the first load must be added. This mem_offset can be derived from the
> instruction mnemonic and the size of the dst register. Each load operation
> is handled by introducing propagate_load_reg_state().
> 
> When processing a load pair, the case where dst and src registers are
> the same (e.g., ldp x0, x1, [x0]) also needs to be considered. Therefore,
> before propagating data types, a snapshot of the src register's state
> must be saved and then passed to propagate_load_reg_state().
> 
> Finally, handle the side effects of pre-index and post-index addressing
> via adjust_reg_index_state().
> 
> A real-world example is shown below:
> 
>   ffff80008011f5b0 <pick_task_stop>:
>   ffff80008011f5b8:  ldr  x0, [x0, #2712] // x0: struct rq* -> task_struct*
> * ffff80008011f5c0:  ldr  w1, [x0, #104]
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
>  .../perf/util/annotate-arch/annotate-arm64.c  | 202 +++++++++++++++++-
>  1 file changed, 201 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 9a3226526522..c239ad9473dc 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -455,11 +455,206 @@ static bool is_readonly_branch_or_cmp(const char *name)
>  	       !strcmp(name, "ccmp") || !strcmp(name, "ccmn");
>  }
>  
> +static int arm64__reg_size(const char *reg)
> +{
> +	if (!reg || !*reg || !arm64__is_reg(reg))
> +		return -1;
> +
> +	if (reg[0] == 'w')
> +		return 4;
> +
> +	if (reg[0] == 'x' || !strncmp(reg, "sp", 2))
> +		return 8;
> +
> +	return -1;
> +}
> +
> +/* Apply addressing mode (pre-index, post-index) to register state */
> +static void adjust_reg_index_state(struct type_state *state,
> +				   struct data_loc_info *dloc,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *op_loc)
> +{
> +	struct type_state_reg *tsr;
> +	int reg = op_loc->reg1;
> +	int offset;
> +
> +	if (op_loc->addr_mode != PERF_AAM_PRE_INDEX &&
> +	    op_loc->addr_mode != PERF_AAM_POST_INDEX)
> +		return;
> +
> +	if (!has_reg_type(state, reg) || !state->regs[reg].ok)
> +		return;
> +
> +	tsr = &state->regs[reg];
> +	tsr->copied_from = -1;
> +
> +	if (arch_get_reg_offset(dloc->arch, op_loc, reg, state, true, &offset)) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	tsr->offset += offset;
> +
> +	pr_debug_dtp("%s [%x] %s-index %#x(reg%d) -> reg%d", dl->ins.name,
> +		     (u32) dl->al.offset, op_loc->addr_mode == PERF_AAM_PRE_INDEX ?
> +		     "pre" : "post", offset, reg, reg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}
> +
> +/*
> + * Match standard load variants (ldr, ldur, ldar, ldp) that follow
> + * straightforward load semantics: memory source on the right
> + * and target registers on the left (written). Excludes exclusive loads
> + * (ldxr, ldxp, etc.) and acquire/exclusive combination variants.
> + */
> +static bool is_standard_load_insn(const char *name)
> +{
> +	return !strncmp(name, "ldr", 3)  ||  /* ldr, ldrb, ldrh, ldrsb, ldrsh, ldrsw */
> +	       !strncmp(name, "ldur", 4) ||  /* ldur, ldurb, ldurh, ldursb, ldursh, ldursw */
> +	       !strncmp(name, "ldar", 4) ||  /* ldar, ldarb, ldarh */
> +	       !strncmp(name, "ldp", 3);     /* ldp, ldpsw */
> +}
> +
> +/*
> + * For load insns: propagate type from source reg state @src_states to @dreg.
> + *
> + * @mem_offset accounts for additional memory byte offset when handling multi-reg
> + * loads (e.g. second target reg in 'ldp'), which is added to the reg offset.
> + */
> +static int propagate_load_reg_state(struct type_state *state,
> +				    struct data_loc_info *dloc,
> +				    struct disasm_line *dl, int dreg,
> +				    struct annotated_op_loc *src,
> +				    struct type_state_reg **src_states,
> +				    int mem_offset)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg *src_tsr = src_states[0];
> +	Dwarf_Die type_die;
> +	u32 insn_offset = dl->al.offset;
> +	int sreg = src->reg1;
> +	int reg_offset;
> +
> +	if (!has_reg_type(state, dreg))
> +		return -1;
> +
> +	tsr = &state->regs[dreg];
> +	tsr->copied_from = -1;
> +
> +retry:
> +	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
> +		return -1;
> +
> +	reg_offset += mem_offset;
> +
> +	if (!src_tsr || !src_tsr->ok)
> +		return -1;
> +
> +	/* Dereference the pointer if it has one */
> +	if (src_tsr->kind == TSR_KIND_TYPE &&
> +	    die_deref_ptr_type(&src_tsr->type,
> +			       src_tsr->offset + reg_offset, &type_die)) {
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->offset = 0;
> +		tsr->ok = true;
> +
> +		if (src->multi_regs) {
> +			pr_debug_dtp("%s [%x] %#x(reg%d, reg%d) -> reg%d",
> +				     dl->ins.name, insn_offset, reg_offset,
> +				     src->reg1, src->reg2, dreg);
> +		} else {
> +			pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
> +				     dl->ins.name, insn_offset, reg_offset,
> +				     sreg, dreg);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
> +
> +	/* Or try another register if any */
> +	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
> +	    !(src->extend_type || src->shift_type)) {
> +		sreg = src->reg2;
> +		src_tsr = src_states[1];
> +		goto retry;
> +	}
> +
> +	return -1;
> +}
> +
> +static void update_load_insn_state(struct type_state *state,
> +				   struct data_loc_info *dloc,
> +				   struct disasm_line *dl,
> +				   struct annotated_op_loc *src,
> +				   struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg snapshots[2];
> +	struct type_state_reg *src_states[2] = {};
> +
> +	if (!src->mem_ref ||  /* exclude PC-relative loads */
> +	    !has_reg_type(state, dst->reg1) ||
> +	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
> +		goto out_err_adjust;
> +

Just realized the condition here is not quite right -- rejecting too early
here leaves no chance for the type of dst->reg1 to be propagated. For example,
consider the following instruction:

  ldp x1, xzr, [x2]

It would be more appropriate to change it to a check on src->reg1:

	if (!src->mem_ref ||  /* exclude PC-relative loads */
	    !has_reg_type(state, src->reg1))
		goto out_invalidate_all;

After changing it to this, the issue raised by Sashiko in the subsequent
patch 0021, where both sreg and fbreg are -1, can also be resolved.

Thanks,
Tengda

> +	/*
> +	 * Snapshot source register states before updating destination registers.
> +	 * This avoids state corruption in aliased instructions (e.g., ldp x0, x1, [x0]),
> +	 * ensuring the second destination load still uses the original base
> +	 * register state.
> +	 */
> +	if (has_reg_type(state, src->reg1)) {
> +		snapshots[0] = state->regs[src->reg1];
> +		src_states[0] = &snapshots[0];
> +	}
> +	if (src->multi_regs && has_reg_type(state, src->reg2)) {
> +		snapshots[1] = state->regs[src->reg2];
> +		src_states[1] = &snapshots[1];
> +	}
> +
> +	/* Handle the first destination register */
> +	if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
> +				     src, src_states, /*mem_offset=*/0))
> +		goto out_err_adjust;
> +
> +	/* Handle the second destination register (if any) */
> +	if (dst->multi_regs) {
> +		int mem_offset;
> +
> +		/*
> +		 * ldpsw loads two 32-bit signed words into 64-bit registers.
> +		 * Memory spacing between elements is 4 bytes, not the register size.
> +		 */
> +		if (!strcmp(dl->ins.name, "ldpsw"))
> +			mem_offset = 4;
> +		else
> +			mem_offset = arm64__reg_size(dl->ops.target.raw);
> +
> +		if (mem_offset < 0 ||
> +		    propagate_load_reg_state(state, dloc, dl, dst->reg2,
> +					     src, src_states, mem_offset))
> +			goto out_err_adjust;
> +	}
> +
> +out_adjust:
> +	adjust_reg_index_state(state, dloc, dl, src);
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
>  static void update_insn_state_arm64(struct type_state *state,
>  				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				    struct disasm_line *dl)
>  {
>  	struct annotated_insn_loc loc;
> +	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
>  	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
>  	u32 insn_offset = dl->al.offset;
>  
> @@ -519,7 +714,8 @@ static void update_insn_state_arm64(struct type_state *state,
>  	 * Invalidate destination register(s) for unsupported instructions to
>  	 * prevent stale type info from propagating to subsequent instructions.
>  	 */
> -	if (has_reg_type(state, dst->reg1) && !dst->mem_ref) {
> +	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
> +	    !is_standard_load_insn(dl->ins.name)) {
>  		pr_debug_dtp("%s [%x] invalidate reg%d",
>  			     dl->ins.name, insn_offset, dst->reg1);
>  		invalidate_reg_state(&state->regs[dst->reg1]);
> @@ -530,6 +726,10 @@ static void update_insn_state_arm64(struct type_state *state,
>  		pr_debug_dtp("\n");
>  		return;
>  	}
> +
> +	/* Memory to register transfers */
> +	if (is_standard_load_insn(dl->ins.name))
> +		update_load_insn_state(state, dloc, dl, src, dst);
>  }
>  #endif
>  

