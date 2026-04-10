Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14D4261B92;
	Fri, 10 Apr 2026 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803162; cv=none; b=Kx6vBtK9rWvZZmpX7jfCeW+HTC7+MXSjjKYhAT8jW7Ag7bC8dHbrqdHAhYtEPhmWPZ76nIgCa9UXXoieftaMnDD15/l9TKpNw/9HPj29rINLppSaTPCNQtJizTK2zi5KB3nVMJfBCz46rOMilGyNh2497j7uyk/Q923CPGZFgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803162; c=relaxed/simple;
	bh=2dJERKr+mp2TGfuWCFWrxNT+5Kd3HQjiEmfMx63zO4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCJyx8dp+uWkolawms9P0lPsyw3VLcNAgmDap+ElkRWQHcyDsK0g7wIYMxBM4bXWogd4RUiMSg0W+AjxDAnclVgUTGR3LfmM1TR/O5GOcLJ0+lILV9gLabLlXimXTA+h5EJxqjp/dVSxPEcL/mp7MBsXSi9dOLYWyjJNIBWoFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIDoSOjd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIDoSOjd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7166C2BC9E;
	Fri, 10 Apr 2026 06:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775803162;
	bh=2dJERKr+mp2TGfuWCFWrxNT+5Kd3HQjiEmfMx63zO4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIDoSOjdBBGL7fhziaywXI8ieKmQMorZuT71rZOPo8RSiyza2YAqgW6P8fzNXNSYD
	 Y8e1QZb4c4n0bQN0CjkFXovjM9Z6hX1OXKnVObjpGQaJWVRrpoflohiz9tgEXV2P0U
	 FM0MpS//+uVpU3J3QACaoQ02kYXSz1ci4HMu42gmm7w+POrfd1U2VdbuBhA1tvF6bQ
	 IAM+ynR7ONn8qBRe95VNoApxKcop1cLjdDsDEj72dCiNoF83qJGRXVAj0GA55C64UM
	 fMLivxSLherLZWecJX7f42Sjl9yiEmnOe39CJIKt0W0rUcTL5ULFRxia76aqTCNMxi
	 yw22NMv30Ffyw==
Date: Thu, 9 Apr 2026 23:39:20 -0700
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
Subject: Re: [PATCH v2 12/16] perf annotate-arm64: Support 'mov' instruction
 tracking
Message-ID: <adibGCaruYl4i9f8@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-13-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-13-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:56AM +0000, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to handle register-to-register
> 'mov' instructions.
> 
> When a 'mov' instruction occurs between two registers, the data type
> information (DWARF type, kind, and offset) needs to be propagated from
> the source register to the destination register. This ensures that if
> a pointer or a structure was previously identified in one register,
> the tracker continues to recognize it after it is moved.
> 
> A real-world example is shown below:
> 
>   ffff8000803eebf8 <get_vma_policy>:
>   ffff8000803eec20:  mov  x21, x0  // x0 (struct vm_area_struct*) -> x21
>   ffff8000803eec28:  ldr  x2, [x0, #112]
>   ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
>   ffff8000803eec94:  ldr  x0, [x21, #152]  // PMU sample
> 
> Before this commit, the type of x21 was unknown, causing the subsequent
> inference to fail:
> 
>   var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>   chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
>   final result: no type information
> 
> After this commit, the type of x21 is correctly inferred as 'vm_area_struct':
> 
>   var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>   mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
>   chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
>   found by insn track: 0x98(reg21) type-offset=0x98
>   final result:  type='struct vm_area_struct' size=0xb0
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index f9100230c2f6..013b673f4861 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -308,6 +308,34 @@ static void update_insn_state_arm64(struct type_state *state,
>  	sreg = src->reg1;
>  	dreg = dst->reg1;
>  
> +	/* Register to register transfers */
> +	if (!strcmp(dl->ins.name, "mov")) {
> +		if (!has_reg_type(state, sreg))
> +			return;
> +
> +		tsr = &state->regs[sreg];
> +		tsr->copied_from = -1;
> +
> +		if (!has_reg_type(state, dreg) ||
> +		    !state->regs[dreg].ok) {
> +			tsr->ok = false;
> +			return;
> +		}

Does this handle an immediate value?

> +
> +		tsr->type = state->regs[dreg].type;
> +		tsr->kind = state->regs[dreg].kind;
> +		tsr->offset = state->regs[dreg].offset;
> +		tsr->ok = true;

Probably safe to use 'state->regs[dreg].ok'.

Anyway, the same concern.  The src and dst are reversed.

Thanks,
Namhyung

> +
> +		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
> +			tsr->copied_from = dreg;
> +
> +		pr_debug_dtp("mov [%x] reg%d -> reg%d",
> +			     insn_offset, dreg, sreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return;
> +	}
> +
>  	if (dloc->fb_cfa) {
>  		u64 ip = dloc->ms->sym->start + dl->al.offset;
>  		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
> -- 
> 2.34.1
> 
