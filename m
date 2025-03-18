Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB2C199235;
	Tue, 18 Mar 2025 17:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318165; cv=none; b=HibVVmGYsSh2nS24aBZC8KU1QKajzDXtOFYaRd6FFnFGJgSqBLM8/KuxWKVa7lVCYsBFhiJiZLQx8yKK5XMWb2g1/OHi/5nfdv8dRtFIxOf48kyEikJFEfsG0OXHIHdQpg3YnqvIQfq1fsNAzYOiL5nsmTYaPeZhnsz83EJvcdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318165; c=relaxed/simple;
	bh=VP7iP0w8pYe4gFKC31cVKPEWIkG0F79bgmlPVBhf2Ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJUDZ/Cd0QcSwfJX/5xxJB71w4dHJV7rFm48DhfO+FuFZZZYG6CaRaOp59TA0a5nOdiVdxjFZsf/B8bEOPuv34kR/cgdfwrAR+mbY+jsX/ZIQ2feg7ko0l/N+mvRnexfuCSXcnT0Xa4u2eTYtY+eo8QIUj9ySCHsb7kv4q58JBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31080113E;
	Tue, 18 Mar 2025 10:16:11 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51F8E3F673;
	Tue, 18 Mar 2025 10:16:02 -0700 (PDT)
Date: Tue, 18 Mar 2025 17:15:57 +0000
From: Leo Yan <leo.yan@arm.com>
To: Li Huafei <lihuafei1@huawei.com>
Cc: namhyung@kernel.org, acme@kernel.org, leo.yan@linux.dev,
	james.clark@linaro.org, mark.rutland@arm.com,
	john.g.garry@oracle.com, will@kernel.org, irogers@google.com,
	mike.leach@linaro.org, peterz@infradead.org, mingo@redhat.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	kjain@linux.ibm.com, mhiramat@kernel.org,
	atrajeev@linux.vnet.ibm.com, sesse@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/7] perf annotate: Handle arm64 load and store
 instructions
Message-ID: <20250318171557.GA2860028@e132581.arm.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
 <20250314162137.528204-2-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-2-lihuafei1@huawei.com>

Hi Huafei,

On Sat, Mar 15, 2025 at 12:21:31AM +0800, Li Huafei wrote:
> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> ARM64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.

Thanks a lot for working on this!

> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/arch/arm64/annotate/instructions.c | 67 ++++++++++++++++++-
>  1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm64/annotate/instructions.c b/tools/perf/arch/arm64/annotate/instructions.c
> index d465d093e7eb..c212eb7341bd 100644
> --- a/tools/perf/arch/arm64/annotate/instructions.c
> +++ b/tools/perf/arch/arm64/annotate/instructions.c
> @@ -6,7 +6,8 @@
>  
>  struct arm64_annotate {
>  	regex_t call_insn,
> -		jump_insn;
> +		jump_insn,
> +		ldst_insn; /* load and store instruction */
>
>  };
>  
>  static int arm64_mov__parse(struct arch *arch __maybe_unused,
> @@ -67,6 +68,57 @@ static struct ins_ops arm64_mov_ops = {
>  	.scnprintf = mov__scnprintf,
>  };
>  
> +static int arm64_ldst__parse(struct arch *arch __maybe_unused,
> +			     struct ins_operands *ops,
> +			     struct map_symbol *ms __maybe_unused,
> +			     struct disasm_line *dl __maybe_unused)
> +{
> +	char *s, *target;
> +
> +	/*
> +	 * The part starting from the memory access annotation '[' is parsed
> +	 * as 'target', while the part before it is parsed as 'source'.
> +	 */
> +	target = s = strchr(ops->raw, '[');
> +	if (!s)
> +		return -1;

I am wandering if this is sufficient for handling different load /
store instructions.

A simple case is an instruction "ldr x1, [x2]", the handling above
should can work well.  How about instructions below with offsets:

    ldr     x2, [x0, #968]
    ldr     w3, [x25], #4

Could you also confirm if the parsing can fit the pattern for
load/store pair instructions?

    ldp     x29, x30, [sp], #16

The instruction loads paired 64-bit data into two registers.

> +	while (s > ops->raw && *s != ',')
> +		--s;
> +
> +	if (s == ops->raw)
> +		return -1;
> +
> +	*s = '\0';
> +	ops->source.raw = strdup(ops->raw);
>
> +
> +	*s = ',';
> +	if (!ops->source.raw)
> +		return -1;
> +
> +	ops->target.raw = strdup(target);
> +	if (!ops->target.raw) {
> +		zfree(ops->source.raw);
> +		return -1;
> +	}
> +	ops->target.mem_ref = true;
> +
> +	return 0;
> +}
> +
> +static int ldst__scnprintf(struct ins *ins, char *bf, size_t size,
> +			   struct ins_operands *ops, int max_ins_name)
> +{
> +	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
> +			 ops->source.name ?: ops->source.raw,
> +			 ops->target.name ?: ops->target.raw);
> +}
> +
> +static struct ins_ops arm64_ldst_ops = {
> +	.parse	   = arm64_ldst__parse,
> +	.scnprintf = ldst__scnprintf,
> +};
> +
>  static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
>  {
>  	struct arm64_annotate *arm = arch->priv;
> @@ -77,6 +129,8 @@ static struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const
>  		ops = &jump_ops;
>  	else if (!regexec(&arm->call_insn, name, 2, match, 0))
>  		ops = &call_ops;
> +	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
> +		ops = &arm64_ldst_ops;
>  	else if (!strcmp(name, "ret"))
>  		ops = &ret_ops;
>  	else
> @@ -107,6 +161,15 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  		      REG_EXTENDED);
>  	if (err)
>  		goto out_free_call;
> +	/*
> +	 * The ARM64 architecture has many variants of load/store instructions.
> +	 * It is quite challenging to match all of them completely. Here, we
> +	 * only match the prefixes of these instructions.
> +	 */
> +	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
> +		      REG_EXTENDED);

As a first step, it is fine for me to support these memory types.

After I review the whole series, I might go back to check if we can
support other memory instructions (e.g. SVE, Memory Copy and
Memory Set instructions, etc).  At least, we need to avoid any
barriers for extending these instructions.

Thanks,
Leo

> +	if (err)
> +		goto out_free_jump;
>  
>  	arch->initialized = true;
>  	arch->priv	  = arm;
> @@ -117,6 +180,8 @@ static int arm64__annotate_init(struct arch *arch, char *cpuid __maybe_unused)
>  	arch->e_flags = 0;
>  	return 0;
>  
> +out_free_jump:
> +	regfree(&arm->jump_insn);
>  out_free_call:
>  	regfree(&arm->call_insn);
>  out_free_arm:
> 
> -- 
> 2.25.1
> 
