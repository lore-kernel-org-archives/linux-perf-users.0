Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349120B807;
	Tue, 18 Mar 2025 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742320971; cv=none; b=SKCoRvw+M3wkklW6vosNokjc2SHXHXaW98iHQP6WWzBHAQbJ0/Ss1dklX7Le83qagwfOB+J0hBQ1NCjfY1g66fpVr7Uz3Ef60gByECmkGR50PoFAjAe2RG5HSlySUyvnfqpmV+CW+eAnD+cS4dZljhbxHPYrZBJWDjrmxM/e/kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742320971; c=relaxed/simple;
	bh=frcqzSdEkrz6G5vNfij4PscpNZKJYre4fCO5e8Anz4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LD1t00peDtU1ffFTN5vfC/IZw5FfydL3gGM0k5n0aSZAvsTta6MFG+bHv3cN5jA8iNDJcyAroPYSAbrTt/Q8KEHiKZTo1rvP1q3B9R/cYxixJ+d80TPcKo2Lt015kAuUWp1EgvYkywWQRfV5bO+9+iFHJ49FrFzH1X0Xsh4R31I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8D2B13D5;
	Tue, 18 Mar 2025 11:02:52 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1715E3F694;
	Tue, 18 Mar 2025 11:02:44 -0700 (PDT)
Date: Tue, 18 Mar 2025 18:02:40 +0000
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
Subject: Re: [PATCH 2/7] perf annotate: Advance the mem_ref check to
 mov__parse()
Message-ID: <20250318180240.GB2860028@e132581.arm.com>
References: <20250314162137.528204-1-lihuafei1@huawei.com>
 <20250314162137.528204-3-lihuafei1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314162137.528204-3-lihuafei1@huawei.com>

On Sat, Mar 15, 2025 at 12:21:32AM +0800, Li Huafei wrote:
> Advance the mem_ref check on x86 to mov__parse(), along with the
> multi_reg check, to make annotate_get_insn_location() more concise.
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> ---
>  tools/perf/util/annotate.c | 9 ++++-----
>  tools/perf/util/disasm.c   | 8 ++++++++
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index 31bb326b07a6..860ea6c72411 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2442,18 +2442,17 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
>  				continue;
>  		}
>  
> +		op_loc->mem_ref = mem_ref;
> +		op_loc->multi_regs = multi_regs;
> +
>  		/*
>  		 * For powerpc, call get_powerpc_regs function which extracts the
>  		 * required fields for op_loc, ie reg1, reg2, offset from the
>  		 * raw instruction.
>  		 */
>  		if (arch__is(arch, "powerpc")) {
> -			op_loc->mem_ref = mem_ref;
> -			op_loc->multi_regs = multi_regs;
>  			get_powerpc_regs(dl->raw.raw_insn, !i, op_loc);
> -		} else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
> -			op_loc->mem_ref = true;
> -			op_loc->multi_regs = multi_regs;
> +		} else if (mem_ref) {
>  			extract_reg_offset(arch, insn_str, op_loc);
>  		} else {
>  			char *s, *p = NULL;
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 50c5c206b70e..d91526cff9df 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -607,6 +607,12 @@ static bool check_multi_regs(struct arch *arch, const char *op)
>  	return count > 1;
>  }
>  
> +/* Check whether the operand accesses memory. */
> +static bool check_memory_ref(struct arch *arch, const char *op)
> +{
> +	return strchr(op, arch->objdump.memory_ref_char) != NULL;
> +}

This patch looks fine for me.

However, I did not find the 'memory_ref_char' field is set for Arm64.
Later patches even remove the condition checking for mem_ref() and
unconditionally invoke extract_reg_offset().

This is a logic change for me.  Shouldn't the register offset be
extracted only for memory access instructions?


>  static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_symbol *ms __maybe_unused,
>  		struct disasm_line *dl __maybe_unused)
>  {
> @@ -635,6 +641,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
>  	if (ops->source.raw == NULL)
>  		return -1;
>  
> +	ops->source.mem_ref = check_memory_ref(arch, ops->source.raw);
>  	ops->source.multi_regs = check_multi_regs(arch, ops->source.raw);
>  
>  	target = skip_spaces(++s);
> @@ -657,6 +664,7 @@ static int mov__parse(struct arch *arch, struct ins_operands *ops, struct map_sy
>  	if (ops->target.raw == NULL)
>  		goto out_free_source;
>  
> +	ops->target.mem_ref = check_memory_ref(arch, ops->target.raw);
>  	ops->target.multi_regs = check_multi_regs(arch, ops->target.raw);
>  
>  	if (comment == NULL)
> 
> -- 
> 2.25.1
> 
