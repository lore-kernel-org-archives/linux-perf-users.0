Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6A13890EE;
	Fri, 10 Apr 2026 06:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775803958; cv=none; b=PrSYRGOxtw66AhUOOHxkfRSbUWl/YwlwV96pmqqfSh8t2c++JozswOaM4U23BcY1ZCheo+oLYqD4HHqZ6ui1liYTvyLqOT0WBKDA1bovN6P2QBooysJwIv3d+Wir4YlLHCCFZj4cTW+52O8HAIh6mPLjDDkjjoQ2hYk/yZCvwVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775803958; c=relaxed/simple;
	bh=aiACfwq8rozv6kKMfjy0IoWd/AnG6GonRnedk/djZ7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4qfufYz4IQZ5eg3dc9gDoDQ+IcwZ/88FMr1YgYyudTMKwN/T1Q4OW+4qpBj2FVAIil5s0sKRapktqezifOmHiJqc2M418K2zhmGQ/kXtbs1rf/GIGfYFH/UdGBu6WXeli/s461bZHGp0GJ31yaGcofEztcXMAdeGJH/IdAAcf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmEE2t3s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmEE2t3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2762C19421;
	Fri, 10 Apr 2026 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775803957;
	bh=aiACfwq8rozv6kKMfjy0IoWd/AnG6GonRnedk/djZ7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AmEE2t3sw51jHHgMh/bOKA64LRXRkdUTn5vubW/lNN0jZoi0k+vii12peYUv/sfYf
	 0bamjvmPXu+DOrxaA+HK9mX5GlYa3Qj4k8jB55ahWfxxtpuiXB9AFROSGNRQH3W28R
	 EmnEjWF+9AiCiEgw4kXqKlfMCzScGulyv5NRt+UBUh6S2f6TMuRUnXPW1rvQ1GJdBR
	 eDUmxYk5AeSCmqfV3irD3LuPobQBLV/evQLRPMaKnQvZlq0ydJ6E6bjZbtIxg7J9U8
	 +oG4fCn+r9F3t03BVoMXIw7XiLBOoQ3EzyEn7sCX1n1z2sxb2gTS+bheJIIhqDs6T0
	 bolUqYG84HHpg==
Date: Thu, 9 Apr 2026 23:52:35 -0700
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
Subject: Re: [PATCH v2 16/16] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
Message-ID: <adieMzY6o4yXGdFS@google.com>
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-17-wutengda@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403094800.1418825-17-wutengda@huaweicloud.com>

On Fri, Apr 03, 2026 at 09:48:00AM +0000, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to handle the 'mrs' instruction,
> enabling the tracking of the 'current' task pointer in the kernel.
> 
> On arm64, the kernel uses the 'sp_el0' system register to store the
> address of the currently executing 'struct task_struct'. This is
> typically accessed via the 'get_current()' inline function, resulting
> in the instruction 'mrs xN, sp_el0'.
> 
> To resolve the data type of the target register, first verify the
> access is to 'sp_el0' within a kernel DSO. Then, locate the
> 'get_current()' inline function's DWARF Die at the current PC and
> extract its return type (which is 'struct task_struct *').
> 
> Introduce a global 'task_struct_off' cache to store the DWARF offset
> of this type. This is particularly important because the compiler-generated
> stack canary check code (which loads from 'current') often exists in
> code sections or leaf functions where the local Compilation Unit (CU)
> lacks a full 'struct task_struct' definition. Caching the offset allows
> 'perf annotate' to consistently resolve task-related fields across the
> entire kernel binary.
> 
> A real-world example is shown below:
> 
>   ffff8000800deee8 <kthread_blkcg>:
>   ffff8000800deef0:  mrs  x0, sp_el0    // x0 = current
>   ffff8000800deef4:  ldr  w1, [x0, #44] // Access task_struct member
> 
> Before this commit, the type flow starts with no information:
> 
>   chk [c] reg0 offset=0x2c ok=0 kind=0 cfa : no type information
>   final result: no type information
> 
> After this commit, the tracker identifies the 'current' pointer
> from the system register:
> 
>   mrs [8] sp_el0 -> reg0 type='struct task_struct*'
>   chk [c] reg0 offset=0x2c ok=1 kind=1 (struct task_struct*) : Good!
>   found by insn track: 0x2c(reg0) type-offset=0x2c
>   final result: type='struct task_struct'
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  .../perf/util/annotate-arch/annotate-arm64.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 89b6b596f984..b03b12594260 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -14,6 +14,7 @@
>  #include "../debug.h"
>  #include "../map.h"
>  #include "../symbol.h"
> +#include "../dso.h"
>  
>  struct arch_arm64 {
>  	struct arch arch;
> @@ -289,6 +290,8 @@ static void adjust_reg_index_state(struct type_state *state, int reg,
>  	pr_debug_type_name(&tsr->type, tsr->kind);
>  }
>  
> +static Dwarf_Off task_struct_off;
> +
>  static void update_insn_state_arm64(struct type_state *state,
>  				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>  				    struct disasm_line *dl)
> @@ -309,6 +312,56 @@ static void update_insn_state_arm64(struct type_state *state,
>  	sreg = src->reg1;
>  	dreg = dst->reg1;
>  
> +	if (!strcmp(dl->ins.name, "mrs")) {
> +		Dwarf_Die func_die;
> +		Dwarf_Attribute attr;
> +		u64 ip, pc;
> +
> +		if (!has_reg_type(state, sreg))
> +			return;
> +
> +		/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
> +		if (!dso__kernel(map__dso(dloc->ms->map)) ||
> +		    strcasecmp(dl->ops.target.raw, "sp_el0"))
> +			return;
> +
> +		ip = dloc->ms->sym->start + dl->al.offset;
> +		pc = map__rip_2objdump(dloc->ms->map, ip);
> +
> +		if (!task_struct_off ||
> +		    !dwarf_offdie(dloc->di->dbg, task_struct_off, &type_die)) {
> +			/*
> +			 * Find the inline function 'get_current()' Dwarf_Die
> +			 * and obtain its return value data type, which should
> +			 * be 'struct task_struct *'.
> +			 */
> +			if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
> +			    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
> +			    !dwarf_formref_die(&attr, &type_die))
> +				return;

I think it's better to verify if it's really the function and type we
want.

Thanks,
Namhyung

> +
> +			/*
> +			 * Cache the 'struct task_struct *' die offset globally.
> +			 * This allows us to resolve stack canary accesses even
> +			 * in CUs that lack a full task_struct definition (e.g.,
> +			 * compiler-generated entry/exit code).
> +			 */
> +			task_struct_off = dwarf_dieoffset(&type_die);
> +		}
> +
> +		tsr = &state->regs[sreg];
> +		tsr->copied_from = -1;
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->offset = 0;
> +		tsr->addr = 0;
> +		tsr->ok = true;
> +
> +		pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, sreg);
> +		pr_debug_type_name(&type_die, tsr->kind);
> +		return;
> +	}
> +
>  	if (!strcmp(dl->ins.name, "adrp")) {
>  		if (!has_reg_type(state, sreg) || !dl->ops.target.addr)
>  			return;
> -- 
> 2.34.1
> 
