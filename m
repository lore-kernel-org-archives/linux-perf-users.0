Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F555505DA;
	Wed,  9 Sep 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965922; cv=none; b=qvp9+RuD1sF4+7f2TJYkICvLXQTO44g1/yHUWqIHPI9Kvwbs0oDyYA94IqWjGjdhWIB26GRdIOMge4XzgwC6di17Mh06/TOLHktgYOxOLLuDVL9yeaKi+X2rViLlV4hurvD5fux6jrKqfnrxM+TBfoWxz6qnefRwbNxP2CSgoaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965922; c=relaxed/simple;
	bh=0yaTXefau6y6rHVWH8usVQPIZ41fmlDXbOuXug6fu7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHdykptPIBVTYuWXKKg+CWZMcivz8Msqyr8ZZUjCzSpoOJq05MUizm+F76+xfnKxlzqQRmV10KTa1s1v2gp3jsqR0kthdtJJAZc3Qrw2STDJVtRFqPuMHBdeNY7Bq0mgNe5f0mmbvUxBP24mHmuQdVMS9i0DLzktjMuYHRoPjys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYgPN2yV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYgPN2yV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BAD11F00A3A;
	Wed,  9 Sep 2026 14:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965918;
	bh=mNvIpoPsF8qUmPCxd/oWc2+HrEn6dfVtI6P5Ayu0kdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VYgPN2yVLSQjzL4LOOyixO94Us0qj/b1yz29GnE+WR4Yo01qGGknaqZ4jhxL4kknI
	 lSbHOzXK8fg5ByWSHOfqTgyEuWTvYP7UOg0f8/ThWCzEi+Nwe/PMLWS6e1E/oFTfjo
	 FhAc3POB7NIdKhl1ltsdISTSqRnyrZlJRvP/sRhzNJ3jvmj3QzctnXOAqoTJT1dUxt
	 ZeTFGy08paQSG/psByoC65pAAGAVgwabSlBvRJA+8oiD4VWmkpqthMtgWSQbvAAp0D
	 1WRLct6tn4e8TbFDznKb5C3e/bYWAGs6AKrRJrPurUZDupVkYSaHaWUyGRvq3ptMtP
	 6ri0q9BnQRZUQ==
Date: Wed, 9 Sep 2026 10:58:34 -0400
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v5 04/26] perf annotate-arm64: Handle load and store
 instructions
Message-ID: <aqF0GuN0pJ83YAob@google.com>
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <37f13e322f75aa96f9cb8b71f401c9911523f8c5.1788872630.git.wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <37f13e322f75aa96f9cb8b71f401c9911523f8c5.1788872630.git.wutengda@huaweicloud.com>

On Tue, Sep 08, 2026 at 01:05:07PM +0000, Tengda Wu wrote:
> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> arm64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 140 ++++++++++++++++++
>  1 file changed, 140 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 151184210691..a7595a954cfa 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -14,6 +14,7 @@ struct arch_arm64 {
>  	struct arch arch;
>  	regex_t call_insn;
>  	regex_t jump_insn;
> +	regex_t ldst_insn; /* load and store instruction */
>  };
>  
>  static bool arm64__is_reg(const char *op)
> @@ -170,6 +171,130 @@ static const struct ins_ops arm64_mov_ops = {
>  	.scnprintf = arm64_mov__scnprintf,
>  };
>  
> +static bool arm64__insn_is_target_on_right(const char *ins_name)
> +{
> +	/*
> +	 * Store instructions write to the memory operand on the right,
> +	 * unlike standard syntax where the target is the left operand.
> +	 */
> +	return !strncmp(ins_name, "st", 2);
> +}
> +
> +/*
> + * This function is used to parse arm64 load/store instructions into
> + * instruction operands.
> + *
> + * Typical instructions and their parsing logic:
> + *
> + * 1. Immediate offset:
> + *    ldr   x2, [x0]                -> target="x2", source="[x0]"
> + *    ldr   x2, [x0, #24]           -> target="x2", source="[x0, #24]"
> + *    ldp   x19, x20, [sp, #16]     -> target="x19, x20", source="[sp, #16]"
> + *
> + * 2. Pre-index addressing:
> + *    stp   x29, x30, [sp, #-64]!   -> target="[sp, #-64]!", source="x29, x30"
> + *
> + * 3. Post-index addressing:
> + *    str   x1, [x0], #8            -> target="[x0], #8", source="x1"
> + *    ldr   w1, [x21], #4           -> target="w1", source="[x21], #4"
> + *    ldp   x29, x30, [sp], #32     -> target="x29, x30", source="[sp], #32"
> + *
> + * 4. Register offset / extension:
> + *    ldr   x0, [x1, w0, sxtw #3]   -> target="x0", source="[x1, w0, sxtw #3]"
> + *    ldr   x0, [x1, x0, lsl #3]    -> target="x0", source="[x1, x0, lsl #3]"
> + *
> + * 5. Atomic operations:
> + *    cas   w3, w1, [x0]            -> target="w3, w1", source="[x0]"
> + *    swp   x3, x0, [x2]            -> target="x3, x0", source="[x2]"
> + *
> + * 6. Prefetch memory:
> + *    prfm  pstl1strm, [x4]         -> target="pstl1strm", source="[x4]"
> + *
> + * 7. PC-relative loads (No bracket found):
> + *    ldr   x0, ffff800080f40c68 <__kvm_nvhe_$d>  -> Fallback to default parser
> + *
> + * Parsing strategy:
> + * Use the '[' bracket as the boundary to split the operands into left
> + * and right sides. For non-store instructions, the left side is the
> + * target and the right side is the source. For store instructions, the
> + * roles are reversed.
> + */
> +static int arm64_ldst__parse(const struct arch *arch, struct ins_operands *ops,
> +			     struct map_symbol *ms, struct disasm_line *dl)
> +{
> +	char *raw, *s, *left, *right;
> +	int ret = -1;
> +
> +	raw = rstrip_space_and_comment(ops->raw, arch->objdump.comment_char);
> +	if (!raw)
> +		return -1;
> +
> +	s = strchr(raw, arch->objdump.memory_ref_char);
> +	if (!s) {
> +		/* Fallback to default parser for PC-relative loads. */
> +		free(raw);
> +		return arm64_mov__parse(arch, ops, ms, dl);
> +	}
> +
> +	right = strdup(s);
> +	if (!right)
> +		goto out_free_raw;
> +
> +	while (s > raw && *s != ',')
> +		--s;
> +
> +	if (s == raw)
> +		goto out_free_right;
> +
> +	*s = '\0';
> +	left = strdup(raw);
> +	*s = ',';
> +	if (!left)
> +		goto out_free_right;
> +
> +	free(raw);
> +
> +	if (arm64__insn_is_target_on_right(dl->ins.name)) {
> +		ops->source.raw = left;
> +		ops->source.mem_ref = false;
> +
> +		ops->target.raw = right;
> +		ops->target.mem_ref = true;
> +	} else {
> +		ops->source.raw = right;
> +		ops->source.mem_ref = true;
> +
> +		ops->target.raw = left;
> +		ops->target.mem_ref = false;
> +	}
> +
> +	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
> +	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
> +
> +	return 0;
> +
> +out_free_right:
> +	free(right);
> +out_free_raw:
> +	free(raw);
> +	return ret;
> +}
> +
> +static int arm64_ldst__scnprintf(const struct ins *ins, char *bf, size_t size,
> +				 struct ins_operands *ops, int max_ins_name)
> +{
> +	if (arm64__insn_is_target_on_right(ins->name))
> +		return scnprintf(bf, size, "%-*s %s", max_ins_name, ins->name, ops->raw);
> +
> +	return scnprintf(bf, size, "%-*s %s, %s", max_ins_name, ins->name,
> +			 ops->target.raw, ops->source.name ?: ops->source.raw);
> +}
> +
> +static struct ins_ops arm64_ldst_ops = {
> +	.parse	   = arm64_ldst__parse,
> +	.scnprintf = arm64_ldst__scnprintf,
> +};
> +
>  static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
>  {
>  	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
> @@ -180,6 +305,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>  		ops = &jump_ops;
>  	else if (!regexec(&arm->call_insn, name, 2, match, 0))
>  		ops = &call_ops;
> +	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
> +		ops = &arm64_ldst_ops;
>  	else if (!strcmp(name, "ret"))
>  		ops = &ret_ops;
>  	else
> @@ -205,6 +332,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	arch->objdump.comment_char	  = '/';
>  	arch->objdump.skip_functions_char = '+';
>  	arch->objdump.memory_ref_char	  = '[';
> +	arch->objdump.imm_char		  = '#';
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>  
>  	/* bl, blr */
> @@ -218,8 +346,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	if (err)
>  		goto out_free_call;
>  
> +	/*
> +	 * The ARM64 architecture has many variants of load/store instructions.
> +	 * It is quite challenging to match all of them completely. Here, we
> +	 * only match the prefixes of these instructions.
> +	 */
> +	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
> +		      REG_EXTENDED);
> +	if (err)
> +		goto out_free_jump;
> +
>  	return arch;
>  
> +out_free_jump:
> +	regfree(&arm->jump_insn);
>  out_free_call:
>  	regfree(&arm->call_insn);
>  out_free_arm:
> -- 
> 2.34.1
> 
