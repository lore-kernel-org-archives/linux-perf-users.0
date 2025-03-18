Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB124C7C;
	Tue, 18 Mar 2025 01:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261566; cv=none; b=LSRaMM3hCyOJCLTzmPDvmTwQIYZ1zII4FWWzTeg9TtmSLCPdhwKiXprefF5V/CxwoMALI9Ci8Y5C4iIzo9pwPTKD5zBksdGG5dPtazPJ8Q/uFywS77RfejAmxQnediwsuzfwjKRkR+E8lUJhIh6/Rt9SIq0y5LknojJTr1huHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261566; c=relaxed/simple;
	bh=I4iPKp8yRcIiMxB58gWCtiaL8IYeA1sBlvQ8GEEr2ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mBTl6kJO4Hc//7IQD6N5pcxVVfDrhBz2bQo0WF9Uo4AFQF0oMWMWYCSRVdJaIauMmVszjn59ISG2gTTkiv1USSpxfM9U/TQkXfXT/UV5bu1PiLwtVSiWwGivwZ203e1XwebUjfroCokK0PxYP19FL5a0/cqr6YiE5TEdphT460g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz+WNGpy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz+WNGpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C7C4CEE3;
	Tue, 18 Mar 2025 01:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742261565;
	bh=I4iPKp8yRcIiMxB58gWCtiaL8IYeA1sBlvQ8GEEr2ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bz+WNGpy3DiqOcNSNNKSA8b38dxVYc3AKHHXKeGHvmFuRzrqfemSycGz7KKUSarTu
	 u/yEXl5UzRCGGcEZjurrDvFelS2yZHF0eGW1mjjPO61Pi39MW7RAruySMk4E95xlA+
	 fvMaJ9ZTWMeVjN2dJs9OZ0EcStk5etqcreSsdrL1CE/ff+lnK4k70cY2T/MwxZnU0B
	 ysNJlm+C1Xu91XE/hAQjiVNBQlKLMF26+SMreJsmd0gkwHC0LSVSCB9LDiv8a5zpqC
	 fSy5qnQ+yagTYcbh4n/WUdcxNg03iFQrumm6gfExut7KVL6YxkcIwcPhEBZq2NraBr
	 5lnxwxvYIX0hQ==
Date: Mon, 17 Mar 2025 18:32:42 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: acme@kernel.org, leo.yan@linux.dev, james.clark@linaro.org,
	mark.rutland@arm.com, john.g.garry@oracle.com, will@kernel.org,
	irogers@google.com, mike.leach@linaro.org, peterz@infradead.org,
	mingo@redhat.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, kjain@linux.ibm.com, mhiramat@kernel.org,
	atrajeev@linux.vnet.ibm.com, sesse@google.com,
	adrian.hunter@intel.com, kan.liang@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/7] perf annotate: Handle arm64 load and store
 instructions
Message-ID: <Z9jNOgbZj_ZCx-9-@google.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
 <20250314162137.528204-2-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-2-lihuafei1@huawei.com>

On Sat, Mar 15, 2025 at 12:21:31AM +0800, Li Huafei wrote:
> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. There are many variants of load and store instructions in
> ARM64, making it difficult to match all of these instruction names
> completely. Therefore, only the instruction prefixes are matched. The
> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
> matches atomic instructions, and 'prf' matches memory prefetch
> instructions.
> 
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
> +
> +	while (s > ops->raw && *s != ',')
> +		--s;
> +
> +	if (s == ops->raw)
> +		return -1;
> +
> +	*s = '\0';
> +	ops->source.raw = strdup(ops->raw);
> +
> +	*s = ',';
> +	if (!ops->source.raw)
> +		return -1;
> +
> +	ops->target.raw = strdup(target);
> +	if (!ops->target.raw) {
> +		zfree(ops->source.raw);

I think you need 'zfree(&ops->source.raw)' instead.


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

It seems we leak these on the success path.  Probably we need arch
annotate_exit() to free the resources.

Thanks,
Namhyung


>  out_free_arm:
> -- 
> 2.25.1
> 
