Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFA53DEAC2;
	Thu,  9 Jul 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582163; cv=none; b=W3f0si2vdX0IzItC+Q67o2LZH4QN/dFmgtWX31CRB22BKpTP1AP2l8BeLvPnC//ZC/0ieszX1S1KeHseLMaSNFaogZXlZ93r5Tcwl2uUvWdaC1Nldq+JhFkcHq51EfgV3faNqtEflVy+kfgWDcu9rzH6D6lBJ9HrF80Il18K7V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582163; c=relaxed/simple;
	bh=0kLOC+UIG+bFCGsRdzZqW3Gx707UrW1K9ElI7OtGt8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBZaiOEnchN7DENXftuZBoBDOtAPPMCsNp6aenY2c1463vbBJSL8RiDbSECEsr47P/Bu5N6tZSDh+ylNaZLWXu4rxMD5KMCVpTYuKA6sTjL9u86X/bYGOHX1VsKUM6oRMAk6WBPbd1AK/Z5eIP3+0cFdTXYrzkmT0/RBLX09vhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VlZUlLoH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VlZUlLoH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8DB1F000E9;
	Thu,  9 Jul 2026 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783582162;
	bh=KGQuAhk10LWaLebUABuCXh5OhsVJ9SjezwduBax9Trs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VlZUlLoH15FffehIuYDuKPw4GpNHW94bi11wM5FsXNFwrIXlbGosfdHQGK07h55Zw
	 5CFKTdkCEnXUnmFhpQX45IAsyH+pISGIWpYYkmi3OwWPfG2dbz+g+/7OnvvUyGYOd5
	 CTQNKCJC13+FN01xniZ0h4WJL03Ae72Y/gdt4NGN0vF/0CJQ/gA1Vcj7ECm6Qe2FyW
	 wuxUxx8+wcYrWKvW3YnLCgsQdi57f5ZmZyLVP71bNBwFGzUoCxSrA3tqE2/xYk0zqu
	 uuLl9QAeGmESBb8MPmBloJTUmJP2bYFlXa41pedTTr9JIRg49C2bqmPj7kJ/KHED69
	 B/u+hWIGzZnBA==
Date: Thu, 9 Jul 2026 00:29:20 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
	Li Huafei <lihuafei1@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
	Ian Rogers <irogers@google.com>,
	Kim Phillips <kim.phillips@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Bill Wendling <morbo@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Zecheng Li <zli94@ncsu.edu>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 20/21] perf annotate-arm64: Support per-cpu variable
 access tracking
Message-ID: <ak9N0CY1sAtGt47I@z2>
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-21-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260701035355.752944-21-wutengda@huaweicloud.com>

On Wed, Jul 01, 2026 at 03:53:54AM +0000, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to handle per-cpu variable
> addressing.
> 
> On arm64, per-cpu variables are accessed by adding a per-cpu offset
> (typically from the '__per_cpu_offset' array) to the address of a global
> variable or a local variable with '__percpu' modifier(e.g.,
> 's32 __percpu *counters' in struct percpu_counter). This results in
> instruction patterns like:
> 
>   ldr   x0, [x6, x5]   // Pattern A: direct load per-cpu instance
>   add   x0, x6, x5     // Pattern B: compute per-cpu address
> 
> where x6 holds the per-cpu offset retrieved from:
> 
>   adrp  x4, <page>
>   add   x4, x4, #offset          // x4 = &__per_cpu_offset
>   ldr   x6, [x4, w0, sxtw #3]    // x6 = __per_cpu_offset[cpu]
> 
> and x5 is one of the following:
> 
>   case 1: global variable
>     adrp  x5, <page>
>     add   x5, x5, #offset        // x5 = &global_var
> 
>   case 2: local variable with '__percpu' modifier
>     ldr   x1, [x25, #32]         // x1 = local_percpu_ptr
> 
> To handle such cases:
> 
> 1. Identify per-cpu base initialization: Detect 'adrp+add' pairs that
>    resolve to the '__per_cpu_offset' symbol and mark the destination
>    register as TSR_KIND_PERCPU_BASE.
> 2. Propagate type information: During subsequent 'ldr' or 'add'
>    instructions, if one register is TSR_KIND_PERCPU_BASE, attempt to
>    resolve the type from the other register.
> 
> A real-world example is shown below:
> 
>   ffff8000808f2d28 <cppc_set_perf>:
>   ffff8000808f2d38:  adrp  x2, ffff800082033000
>   ffff8000808f2d3c:  add   x5, x2, #0x3f8         // x5 = &__per_cpu_offset
>   ffff8000808f2d44:  adrp  x2, ffff800081f73000
>   ffff8000808f2d48:  add   x2, x2, #0x6b8         // x2 = &cpu_pcc_subspace_idx
>   ffff8000808f2d6c:  ldr   x5, [x5, w0, sxtw #3]  // x5 = __per_cpu_offset[cpu]
> * ffff8000808f2d80:  ldr   w23, [x5, x2]          // per_cpu(cpu_pcc_subspace_idx, cpu)
> 
> Before this commit, the tracker could not link x5 back to a per-cpu
> context, resulting in an incorrect data type resolution:
> 
>   adrp [10] global addr=0xffff800082033000 -> reg2
>   add [14] global 0x3f8(reg2) -> reg5
>   adrp [1c] global addr=0xffff800081f73000 -> reg2
>   add [20] global 0x6b8(reg2) -> reg2
>   ldr [44] global (reg5, reg0) -> reg5 type='long unsigned int[]' size=0x1000
>   chk [58] reg5 offset=0 ok=1 kind=1 (long unsigned int[]) : Good!
>   found by insn track: 0(reg5, reg2) type-offset=0
>   final result:  type='long unsigned int' size=0x8
> 
> After this commit, the tracker correctly identifies the per-cpu flow and
> resolves the actual variable type:
> 
>   ldr [44] global (reg5, reg0) -> reg5 percpu base
>   chk [58] reg5 offset=0 ok=1 kind=2 percpu var : retry
>   chk [58] reg2 offset=0 ok=1 kind=7 global addr : Good!
>   found by insn track: 0(reg5, reg2) type-offset=0
>   final result:  type='int' size=0x4
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 60 ++++++++++++++++++-
>  tools/perf/util/annotate-data.c               | 24 +++++++-
>  2 files changed, 82 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 6f96e75d313d..ec6fd59d51a2 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -462,6 +462,15 @@ static void update_load_insn_state(struct type_state *state,
>  		u64 ip = dloc->ms->sym->start + dl->al.offset;
>  		u64 addr = src_tsr.addr + reg_offset;
>  		int offset;
> +		u8 kind;
> +		const char *var_name = NULL;
> +
> +		/* it might be per-cpu offset */
> +		if (get_global_var_info(dloc, addr, &var_name, &offset) &&
> +		    !strcmp(var_name, "__per_cpu_offset"))
> +			kind = TSR_KIND_PERCPU_BASE;

It seems you need to check if the target DSO is a kernel or a module by
calling `dso__kernel(map__dso(dloc->ms->map))` first.

Thanks,
Namhyung

> +		else
> +			kind = TSR_KIND_TYPE;
>  
>  		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
>  		    !die_get_member_type(&type_die, offset, &type_die)) {
> @@ -470,7 +479,7 @@ static void update_load_insn_state(struct type_state *state,
>  		}
>  
>  		tsr->type = type_die;
> -		tsr->kind = TSR_KIND_TYPE;
> +		tsr->kind = kind;
>  		tsr->offset = 0;
>  		tsr->addr = 0;
>  		tsr->ok = true;
> @@ -484,6 +493,28 @@ static void update_load_insn_state(struct type_state *state,
>  		}
>  		pr_debug_type_name(&tsr->type, tsr->kind);
>  	}
> +	/* Or check if it's a per-cpu access */
> +	else if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
> +		int reg2;
> +
> +		if (!src->multi_regs || src->reg1 == src->reg2 ||
> +		    sreg == src->reg2 /* retried */) {
> +			invalidate_reg_state(tsr);
> +			goto out_adjust;
> +		}
> +
> +		reg2 = src->reg2;
> +		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok ||
> +		    (state->regs[reg2].kind != TSR_KIND_GLOBAL_ADDR &&
> +		     state->regs[reg2].kind != TSR_KIND_TYPE)) {
> +			invalidate_reg_state(tsr);
> +			goto out_adjust;
> +		} else {
> +			/* Treat percpu as array: resolve type from reg2 */
> +			sreg = src->reg2;
> +			goto retry;
> +		}
> +	}
>  	/* Or try another register if any */
>  	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>  		sreg = src->reg2;
> @@ -693,6 +724,33 @@ static void update_add_insn_state(struct type_state *state,
>  		pr_debug_dtp("add [%x] global %#x(reg%d) -> reg%d\n",
>  			     insn_offset, reg_offset, sreg, dreg);
>  	}
> +	/* Handle per-cpu base address calculation for per-cpu variables */
> +	else if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
> +		/*
> +		 * A per-cpu base acts like an array index. Adding it to
> +		 * a global variable or typed register should preserve
> +		 * the original variable's type. Inherit the type from
> +		 * the typed register.
> +		 */
> +		if (!src->multi_regs || !has_reg_type(state, src->reg2) ||
> +		    !state->regs[src->reg2].ok ||
> +		    (state->regs[src->reg2].kind != TSR_KIND_GLOBAL_ADDR &&
> +		     state->regs[src->reg2].kind != TSR_KIND_TYPE)) {
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +
> +		tsr->type = state->regs[src->reg2].type;
> +		tsr->kind = state->regs[src->reg2].kind;
> +		tsr->offset = state->regs[src->reg2].offset;
> +		tsr->addr = state->regs[src->reg2].addr;
> +		tsr->ok = state->regs[src->reg2].ok;
> +
> +		pr_debug_dtp("add [%x] percpu (reg%d) -> reg%d",
> +			     insn_offset, sreg, dreg);
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return;
> +	}
>  	/* Or try another register if any */
>  	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>  		sreg = src->reg2;
> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
> index 6fa5cd373a46..b0bf0437168b 100644
> --- a/tools/perf/util/annotate-data.c
> +++ b/tools/perf/util/annotate-data.c
> @@ -1252,11 +1252,33 @@ static enum type_match_result check_matching_type(struct type_state *state,
>  	}
>  
>  	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
> -		u64 var_addr = dloc->op->offset;
> +		u64 var_addr;
>  		int var_offset;
>  
>  		pr_debug_dtp("percpu var");
>  
> +		if (arch__is_arm64(dloc->arch)) {
> +			int reg2;
> +
> +			if (!dloc->op->multi_regs ||
> +			    dloc->op->reg1 == dloc->op->reg2 || !retry)
> +				return PERF_TMR_BAIL_OUT;
> +
> +			reg2 = dloc->op->reg2;
> +			if (!has_reg_type(state, reg2) ||
> +			    !state->regs[reg2].ok ||
> +			    (state->regs[reg2].kind != TSR_KIND_GLOBAL_ADDR &&
> +			     state->regs[reg2].kind != TSR_KIND_TYPE))
> +				return PERF_TMR_NO_TYPE;
> +
> +			pr_debug_dtp(" : retry\n");
> +			retry = false;
> +			reg = reg2;
> +			goto again;
> +		}
> +
> +		var_addr = dloc->op->offset;
> +
>  		if (dloc->op->multi_regs) {
>  			int reg2 = dloc->op->reg2;
>  
> -- 
> 2.34.1
> 
