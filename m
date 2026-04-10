Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3B8331205;
	Fri, 10 Apr 2026 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803381; cv=none; b=oFinkqHCNAWYXWshvI410trHULH+uM7WEr/o+O4DI9uZA3c77OynVqJv/mUDlJgCBtQ5d016I5kIWUbryMnc3Lqlfij7VsMS+ELIyhkIuCxG1IzKRL6Y4O2sGJNQxt2D295zw8pjcg9IQV6AZrPVAjUXPDIu+Iv0x6hxLbvMJzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803381; c=relaxed/simple;
	bh=6AfwHIyjMoUJbdRY1JtZt0Zc+eudAwAKsKzHuGXmnQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezgAhiBZQNQUo8iH+4HbHc17l7ufe3z6Ct1GeEthnJAErf/unViK9lM5B+zY27nd9BSWScrGEEYGx+LuEKg2DLNMF6Km1kvfbUidt1acAVd4iO0n+Y7LfOFOUlzSDe6FOi21K6HAsJ9dqIo40pfFHHCZZTGpJ0WMEQvs/cJxJqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnvmT562; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnvmT562"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA0AC19421;
	Fri, 10 Apr 2026 06:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775803381;
	bh=6AfwHIyjMoUJbdRY1JtZt0Zc+eudAwAKsKzHuGXmnQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnvmT562Hd5cUywf+X6Rwi+Ig5xO4PBHmHKvLmZ6o21tXNG10PIf0qzEGb2JFLM/w
	 wsvcDe69qGeJeWQx9/nvDwQKTvyJSKpf0haoV2YshRNTMbnV0mF4pU8r4jncLjKc2X
	 CHx8Y7UIDTAScRzeq90eSu/0FT29JFuxADXq3hUGu/2nLdADQ6ZyKtNsFbrRd0LVM/
	 TnhjSv6jssIA+Fr/tiHTBA178R9bl7QtZ2ASwTlEGDamUiniEBqyi8PE65zNv77TMT
	 ziqVXnoXeJMGSRETTfWZL5R1gbKBvaNb8GhOIEVMqBfeqITQ59CHqRXlKKtVGvoH9g
	 eTqJ6+Jyt+doQ==
Date: Thu, 9 Apr 2026 23:42:59 -0700
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
Subject: Re: [PATCH v2 13/16] perf annotate-arm64: Support 'add' instruction
 tracking
Message-ID: <adib8wD8NPtxpQEL@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-14-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-14-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:47:57AM +0000, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to track pointer arithmetic and
> member address calculations.
> 
> The arm64 'add' instruction frequently calculates structure member
> addresses, such as 'add x0, x1, #offset'. Tracking this is essential
> to maintain the connection between a base pointer and its derived
> member addresses.

What about other arithmetic instructions?  Can 'sub' be used in a
similar manner?  Maybe we want to invalidate the target register state
for all(?) other instructions.

Thanks,
Namhyung

> 
> The implementation checks if the base register contains a pointer
> or a structure type. When an immediate offset is added, use
> die_get_member_type() to verify that the resulting offset points to
> a valid member within the data type. If valid, update the target
> register's type state with the new offset while preserving the base
> type information.
> 
> A real-world example is shown below:
> 
>   ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>   ffff80008001c9c4:  add  x19, x0, #0xeb8 // x0 (task_struct*) + 0xeb8 -> x19
>   ffff80008001c9d0:  ldr  x0, [x19]       // PMU sample
> 
> Before this commit, the type flow broke at the 'add' instruction,
> leaving the subsequent load with no type information:
> 
>   chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
>   final result: no type information
> 
> After this commit, the tracker correctly follows the member address
> calculation:
> 
>   var [0] reg0 offset 0 type='struct task_struct*'
>   add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
>   chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
>   found by insn track: 0(reg19) type-offset=0xeb8
>   final result: type='struct task_struct'
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 013b673f4861..d2557b9d6909 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -7,6 +7,7 @@
>  #include <linux/zalloc.h>
>  #include <linux/string.h>
>  #include <regex.h>
> +#include <inttypes.h>
>  #include "../annotate.h"
>  #include "../disasm.h"
>  #include "../annotate-data.h"
> @@ -308,6 +309,50 @@ static void update_insn_state_arm64(struct type_state *state,
>  	sreg = src->reg1;
>  	dreg = dst->reg1;
>  
> +	if (!strcmp(dl->ins.name, "add")) {
> +		struct type_state_reg dst_tsr;
> +
> +		if (!has_reg_type(state, sreg) ||
> +		    !has_reg_type(state, dreg) ||
> +		    !state->regs[dreg].ok)
> +			return;
> +
> +		tsr = &state->regs[sreg];
> +		tsr->copied_from = -1;
> +		dst_tsr = state->regs[dreg];
> +
> +		/* Handle calculation of a register holding a typed pointer */
> +		if (dst_tsr.kind == TSR_KIND_POINTER ||
> +		    (dst_tsr.kind == TSR_KIND_TYPE &&
> +		    dwarf_tag(&dst_tsr.type) == DW_TAG_pointer_type)) {
> +			s32 offset;
> +
> +			if (dst_tsr.kind == TSR_KIND_TYPE &&
> +			    __die_get_real_type(&dst_tsr.type, &type_die) == NULL)
> +				return;
> +
> +			if (dst_tsr.kind == TSR_KIND_POINTER)
> +				type_die = dst_tsr.type;
> +
> +			/* Check if the target type has a member at the new offset */
> +			offset = dst->offset + dst_tsr.offset;
> +			if (die_get_member_type(&type_die, offset, &type_die) == NULL)
> +				return;
> +
> +			tsr->type = dst_tsr.type;
> +			tsr->kind = dst_tsr.kind;
> +			tsr->offset = offset;
> +			tsr->ok = true;
> +
> +			pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
> +				     insn_offset, dst->offset < 0 ? "-" : "",
> +				     abs(dst->offset), dreg, sreg);
> +
> +			pr_debug_type_name(&tsr->type, tsr->kind);
> +		}
> +		return;
> +	}
> +
>  	/* Register to register transfers */
>  	if (!strcmp(dl->ins.name, "mov")) {
>  		if (!has_reg_type(state, sreg))
> -- 
> 2.34.1
> 
