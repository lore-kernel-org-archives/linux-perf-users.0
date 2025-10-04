Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD34A1C84A2;
	Sat,  4 Oct 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759565059; cv=none; b=Et93zX0ikQsd7DncnpfTTJ/b9lD/J25qWhH/froE7iF6BrdlNsF8afvliXdom6j6i0WjEgr16aERPa3hR/Hk/gOUC38H/f7IJbl/HpB0zFao/jKOnkrn2dL0dYccxQUrPff/5X/OCvMJ1RLRKxKa7FBEOcsRs4cTfBvUlbgFYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759565059; c=relaxed/simple;
	bh=VQ9HMpmOFzPq5iF01WXq3/IJhWsO7ShL4EUpojzV7JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLwFvk9mlESkEIKQ3uFXUWMs7CcAHMNQX+qLp3XYmzZJ0950q/zFlnJiJOssqzz9/Y+EluPrE8qPGwHDThG1RT9RAZkLlxuIqRcTGKFE/cB7nUmd1iP0yOrSTwExvAlxqF4U3rI9ZYzn3QLuqaJimDfAgmNJidfrEtST9ID7jFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGopU2F+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGopU2F+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D67C4CEF1;
	Sat,  4 Oct 2025 08:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759565059;
	bh=VQ9HMpmOFzPq5iF01WXq3/IJhWsO7ShL4EUpojzV7JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PGopU2F+w7XESdmr0EUjfUGyjhIU/Rx1y4IbBMZDzdcai1smadP9D+ROQMBRscWvt
	 j51nXurJ2EfvTHJOA4Fzchp2ljRBfoaKkNNjuj8uWACxwDycserWEJs8HYnpF1AJwq
	 h/iAXCeiZ1GtK9o1+al2AXGAaNCnL5WzgjI9jWVZWo4UwOp+Oc28VFy+V8cAp4DCpk
	 2/0ke4BHNzbutwwkniWV7xmSyfBDAkj0x6kdeJakwTvUL3JFlqKAkDgXkhCrr2pIw7
	 jeBUmXvFdDe4WNwjqnXHVi85A6FWSwj9omQpH9NIpDTRA9pk/2zR5VeTp1+8ybXz5h
	 qAFM4lUXtCQCA==
Date: Sat, 4 Oct 2025 17:04:14 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Zecheng Li <zecheng@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Xu Liu <xliuprof@google.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] perf annotate: Invalidate register states for
 untracked instructions
Message-ID: <aODU_uXKl_2ABcN6@google.com>
References: <20250917195808.2514277-1-zecheng@google.com>
 <20250917195808.2514277-7-zecheng@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250917195808.2514277-7-zecheng@google.com>

On Wed, Sep 17, 2025 at 07:58:04PM +0000, Zecheng Li wrote:
> When tracking variable types, instructions that modify a pointer value
> in an untracked way can lead to incorrect type propagation. To prevent
> this, invalidate the register state when encountering such instructions.
> 
> This change invalidates pointer types for various arithmetic and bitwise
> operations that current pointer offset tracking doesn't support, like
> imul, shl, and, inc, etc.
> 
> A special case is added for 'xor reg, reg', which is a common idiom for
> zeroing a register. For this, the register state is updated to be a
> constant with a value of 0.
> 
> This could introduce slight regressions if a variable is zeroed and then
> reused. This can be addressed in the future by using all DWARF locations
> for instruction tracking instead of only the first one.
> 
> Signed-off-by: Zecheng Li <zecheng@google.com>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 29 +++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arch/x86/annotate/instructions.c
> index 709c6f7efe82..3c98f72c423f 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -411,6 +411,35 @@ static void update_insn_state_x86(struct type_state *state,
>  		return;
>  	}
>  
> +	/* Invalidate register states for other ops which may change pointers */
> +	if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
> +	    dwarf_tag(&state->regs[dst->reg1].type) == DW_TAG_pointer_type) {
> +		if (!strncmp(dl->ins.name, "imul", 4) || !strncmp(dl->ins.name, "mul", 3) ||
> +		    !strncmp(dl->ins.name, "idiv", 4) || !strncmp(dl->ins.name, "div", 3) ||
> +		    !strncmp(dl->ins.name, "shl", 3)  || !strncmp(dl->ins.name, "shr", 3) ||
> +		    !strncmp(dl->ins.name, "sar", 3)  || !strncmp(dl->ins.name, "and", 3) ||
> +		    !strncmp(dl->ins.name, "or", 2)   || !strncmp(dl->ins.name, "neg", 3) ||
> +		    !strncmp(dl->ins.name, "inc", 3)  || !strncmp(dl->ins.name, "dec", 3)) {
> +			pr_debug_dtp("%s [%x] invalidate reg%d\n",
> +						dl->ins.name, insn_offset, dst->reg1);
> +			state->regs[dst->reg1].ok = false;
> +			state->regs[dst->reg1].copied_from = -1;
> +			return;
> +		}
> +
> +		if (!strncmp(dl->ins.name, "xor", 3) && dst->reg1 == src->reg1) {
> +			/* xor reg, reg clears the register */
> +			pr_debug_dtp("xor [%x] clear reg%d\n",
> +				     insn_offset, dst->reg1);
> +
> +			state->regs[dst->reg1].kind = TSR_KIND_CONST;
> +			state->regs[dst->reg1].imm_value = 0;
> +			state->regs[dst->reg1].ok = false;

I think .ok should be 'true'.

Thanks,
Namhyung


> +			state->regs[dst->reg1].copied_from = -1;
> +			return;
> +		}
> +	}
> +
>  	if (strncmp(dl->ins.name, "mov", 3))
>  		return;
>  
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 
