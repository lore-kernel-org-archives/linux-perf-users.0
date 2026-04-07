Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A63947BC;
	Tue,  7 Apr 2026 07:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546802; cv=none; b=sCNz9gCZBN2JvkNopYHfiMBJFBVBZ6aFX9QXrf6WKUuY0lPCl0pPkiO82cgrLlrenKxvi/VHV68S/tXNekjkpP63e1YnTkGjx5soAGpmOlfZbEDbKQA0YFEKKSbNGa0Gb6FkNqHA4dbVJuIsnAGDpG7VywcCREv3TrS3Uwu3hAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546802; c=relaxed/simple;
	bh=XfRNF+DoYsTGffSQlu94Z4XoHs0TKWxiUo1KHt0BQwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEubAj7ft5Gg2DI3vhWh5PfchfZ1bouhiRYWmewDYBXAsc1l4wHSbMRMYTBBdxfJ3TpemHdpSQyYaExeJZmKZ2uGWDY+e0BwFkj6iFAH/vYmAkay8wy95w3S+TpJMAsZBIj8M6HnQ72D+SsLLRw+17zV+9sIW3ggai+ZEiCClbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAsgg9TD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAsgg9TD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4948C116C6;
	Tue,  7 Apr 2026 07:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775546802;
	bh=XfRNF+DoYsTGffSQlu94Z4XoHs0TKWxiUo1KHt0BQwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAsgg9TDoe0VvKaoMAj6roEcxEqIAFnqPN6LdcVxzzCleRyoiE03fsUjNeMvPLFx9
	 Zn/DEzCZJnKEh0kjMBC3aEhgeymH39kEZnQeEARsRiErEPhFpJlfdUKaeaSoipYIZY
	 G8J7milotwMP77Aa3JGIP/VplnUvdONvzAsN5VK9qOsN59/FAzd5Hf9sWjktH0a02M
	 X6FyVwSDOWJsVQNoVu9w/T0Nrx/l4n13nSfdrkUqli71WhyXECbf6fbb3PNw8if3G5
	 HFOWalWKrauiyrI7KyF8hayCnKPWHF7ifX5lRsWUJE8gIu04RlFR6AUded1BCM8MCM
	 pFU+ezwvFYsBg==
Date: Tue, 7 Apr 2026 00:26:40 -0700
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
Subject: Re: [PATCH v2 07/16] perf annotate-arm64: Implement
 extract_op_location() callback
Message-ID: <adSxsFF2OyDUfOeS@z2>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-8-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-8-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:51AM +0000, Tengda Wu wrote:
> Implement the extract_op_location() callback for the arm64 architecture
> to handle its specific assembly syntax and addressing modes.
> 
> The extractor handles:
> 1. Standalone immediate operands (e.g., #0x10).
> 2. Memory references with diverse addressing modes:
>    - Signed offset: [base, #imm]
>    - Pre-index: [base, #imm]!
>    - Post-index: [base], #imm
> 3. Multi-register operands and primary/secondary register extraction.
> 
> This enables 'perf annotate' to resolve memory locations and registers
> required for data type profiling on arm64.
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 64 +++++++++++++++++++
>  tools/perf/util/annotate.c                    | 12 ++--
>  tools/perf/util/annotate.h                    | 10 +++
>  3 files changed, 81 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 8209faaa6086..1fe4c503431b 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -191,6 +191,69 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>  	return ops;
>  }
>  
> +static int extract_op_location_arm64(const struct arch *arch,
> +				     struct disasm_line *dl __maybe_unused,
> +				     const char *op_str, int op_idx __maybe_unused,
> +				     struct annotated_op_loc *op_loc)
> +{
> +	const char *s = op_str;
> +	char *p = NULL;
> +
> +	if (op_str == NULL)
> +		return 0;
> +
> +	/* Handle standalone immediate operands (e.g., #0x10) */
> +	if (*s == arch->objdump.imm_char) {
> +		op_loc->offset = strtol(s + 1, &p, 0);
> +		if (p && p != s + 1)
> +			op_loc->imm = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Handle memory references (e.g., [x0, #8]), identify
> +	 * arm64 specific addressing modes
> +	 */
> +	if (*s == arch->objdump.memory_ref_char) {
> +		op_loc->mem_ref = true;
> +
> +		p = strchr(s, ']');
> +		if (p == NULL)
> +			return -1;
> +
> +		/* Pre-index: [base, #imm]! */
> +		if (p[1] == '!')
> +			op_loc->addr_mode = INSN_ADDR_PRE_INDEX;
> +		/* Post-index: [base], #imm */
> +		else if (p[1] == ',' && strchr(p + 1, arch->objdump.imm_char))
> +			op_loc->addr_mode = INSN_ADDR_POST_INDEX;
> +		/* Signed offset: [base{, #imm}] */
> +		else
> +			op_loc->addr_mode = INSN_ADDR_SIGNED_OFFSET;
> +
> +		s++;
> +	}
> +
> +	/* Extract the primary register */
> +	op_loc->reg1 = arch__dwarf_regnum(arch, s);
> +	if (op_loc->reg1 == -1)
> +		return -1;
> +
> +	/* Move to the next symbol of the operand, if any */
> +	s = strchr(s, ',');
> +	if (s == NULL)
> +		return 0;
> +	s = skip_spaces(s + 1);
> +
> +	/* Parse secondary register or immediate offset */
> +	if (op_loc->multi_regs)
> +		op_loc->reg2 = arch__dwarf_regnum(arch, s);
> +	else if (*s == arch->objdump.imm_char)
> +		op_loc->offset = strtol(s + 1, &p, 0);
> +
> +	return 0;
> +}
> +
>  const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  				   const char *cpuid __maybe_unused)
>  {
> @@ -209,6 +272,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>  	arch->objdump.memory_ref_char	  = '[';
>  	arch->objdump.imm_char		  = '#';
>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
> +	arch->extract_op_location	  = extract_op_location_arm64;
>  
>  	/* bl, blr */
>  	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 1bf69e00d76d..c4d1cb3a7ae4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2452,19 +2452,21 @@ int annotate_check_args(void)
>  
>  int arch__dwarf_regnum(const struct arch *arch, const char *str)
>  {
> -	const char *p;
> +	const char *p = str;
>  	char *regname, *q;
>  	int reg;
>  
> -	p = strchr(str, arch->objdump.register_char);
> -	if (p == NULL)
> -		return -1;
> +	if (arch->objdump.register_char) {
> +		p = strchr(str, arch->objdump.register_char);
> +		if (p == NULL)
> +			return -1;
> +	}
>  
>  	regname = strdup(p);
>  	if (regname == NULL)
>  		return -1;
>  
> -	q = strpbrk(regname, ",) ");
> +	q = strpbrk(regname, ",)] ");
>  	if (q)
>  		*q = '\0';
>  

I think it's better to split changes in this function into a separate
commit earlier in the series.  Please add description about arm64 asm
format about register prefix and different memory reference delimiters.
Probably you want to merge the change to remove 'static' scope here.


> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 71195a27d38f..0391c6a9f011 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -496,12 +496,21 @@ int annotate_check_args(void);
>  
>  int arch__dwarf_regnum(const struct arch *arch, const char *str);
>  
> +enum annotated_addr_mode {
> +	INSN_ADDR_NONE = 0,
> +
> +	INSN_ADDR_SIGNED_OFFSET,
> +	INSN_ADDR_PRE_INDEX,
> +	INSN_ADDR_POST_INDEX,

Probably better to have "PERF" prefix.  Maybe PERF_AAM_SIGNED_OFFSET
(AAM from annotated_addr_mode) or PERF_ADDR_MODE_SIGNED_OFFSET?

Thanks,
Namhyung


> +};
> +
>  /**
>   * struct annotated_op_loc - Location info of instruction operand
>   * @reg1: First register in the operand
>   * @reg2: Second register in the operand
>   * @offset: Memory access offset in the operand
>   * @segment: Segment selector register
> + * @addr_mode: Addressing mode, only valid if @mem_ref is true
>   * @mem_ref: Whether the operand accesses memory
>   * @multi_regs: Whether the second register is used
>   * @imm: Whether the operand is an immediate value (in offset)
> @@ -511,6 +520,7 @@ struct annotated_op_loc {
>  	int reg2;
>  	int offset;
>  	u8 segment;
> +	u8 addr_mode;
>  	bool mem_ref;
>  	bool multi_regs;
>  	bool imm;
> -- 
> 2.34.1
> 
