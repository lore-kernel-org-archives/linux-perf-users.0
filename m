Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730C43A1A5D;
	Tue, 11 Aug 2026 08:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438245; cv=none; b=Xdf+U16ABokvhv4SpSyqFzRAdvaaiquaPZFiVqyApggqEJT0HeURJOzwbZdgmKRtr/7Sd2FMLKd511OxFNewJgtW6vjdYJPyOhjpEXwoweJAtZ8pjkWtDtpiyoC3kpHmsum14ByZN++WWP4iy5XpABIiIliDlnz/SQwaQWeG8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438245; c=relaxed/simple;
	bh=bx7SIhw/MTSVFZeJn1pNLsvNZ/cwdWcSA/jaLegIAgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8/rDSmsrZrtysfo5F2ZbvUUcGrj6FUZhT4bzLJMWjZLA8AydDAqB/xdI14+a7CwVyXFajkheLYjlHi3LuLUmGLsD0hHsOpOus67F4f9/CwAcS+sR/6ln0td3NcG5krCR/InoQZCFYZ4TWXtjDV1pFBtKo0ax83jAGW3EocXbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=x6A9/aCt; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="x6A9/aCt"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786438239; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=O0eEOpLgH4h+JIdooWcKQDZlmONKvKL06M8Sj4nmDk0=;
	b=x6A9/aCtsRHNrqUnrqMJqMcN2uSDjLlXs3d82NYh/fJoE+XMoNYQFgZAnZUC/hwkyJ1CSMFFFqLsJ3X3ScFPpQrmEfb/79pL2pXdE/I2E2P96KSBKraxKjovy+hLJG1HXqiAj1qZxL4gsiFD4YVbtUezN8KjEnRxPFPFD1sBTv8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nvQDs_1786438236;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nvQDs_1786438236 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:50:37 +0800
Message-ID: <59b826f3-b3c9-4964-bf82-9e43913d80e2@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:50:36 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 21/23] perf annotate-arm64: Support 'adrp' instruction
 to track global variables
To: Tengda Wu <wutengda@huaweicloud.com>, Namhyung Kim <namhyung@kernel.org>,
 james.clark@linaro.org, Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-22-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-22-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to track global variable types
> calculated via page-relative addressing.
> 
> On arm64, global variables are typically accessed by first calculating
> the page address using 'adrp', followed by an 'add' or 'ldr' to get the
> specific symbol address. Without tracking 'adrp', the instruction
> tracker loses the base address, making it impossible to resolve
> global symbols and their associated DWARF types.
> 
> Introduce TSR_KIND_GLOBAL_ADDR to represent a partial global address
> state. When encountering 'adrp', store the page-aligned target address
> in the register's type state. Upon a subsequent 'add' or 'ldr'
> instruction that references a TSR_KIND_GLOBAL_ADDR register, combine
> the page address with the immediate offset.
> 
> A real-world example is shown below:
> 
>    ffff80008032e008 <folios_put_refs>:
>    ffff80008032e048:  adrp  x24, ffff80008202f000 <nr_cpu_ids>
>    ffff80008032e050:  add   x24, x24, #0xd40
> * ffff80008032e078:  ldr   x0, [x24]
> 
> Before this commit, x24 was unknown, leading to no type information:
> 
>    chk [70] reg24 offset=0 ok=0 kind=0 cfa : no type information
>    final result: no type information
> 
> After this commit, the tracker correctly follows the adrp/add flow:
> 
>    adrp [40] global addr=0xffff80008202f000 -> reg24
>    add [48] global 0xd40(reg24) -> reg24
>    chk [70] reg24 offset=0 ok=1 kind=7 global addr : Good!
>    final result: type='struct folio*'
> 
> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 82 +++++++++++++++++--
>   tools/perf/util/annotate-data.c               | 25 +++++-
>   tools/perf/util/annotate-data.h               |  1 +
>   3 files changed, 98 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index eaeb4433fc3a..7eb3bef26a64 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -408,7 +408,7 @@ static void adjust_reg_index_state(struct type_state *state,
>    * to the source struct's field offset.
>    */
>   static int propagate_load_reg_state(struct type_state *state,
> -				    struct data_loc_info *dloc,
> +				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>   				    struct disasm_line *dl, int dreg,
>   				    struct annotated_op_loc *src,
>   				    int reg_offset, const char *insn_name)
> @@ -500,6 +500,32 @@ static int propagate_load_reg_state(struct type_state *state,
>   		pr_debug_type_name(&tsr->type, tsr->kind);
>   		return 0;
>   	}
> +	/* Or check if it's a global variable */
> +	else if (src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {
> +		u64 ip = dloc->ms->sym->start + dl->al.offset;
> +		u64 addr = src_tsr.imm_value + reg_offset;
> +		int offset;
> +
> +		if (!get_global_var_type(cu_die, dloc, ip, addr, &offset, &type_die) ||
> +		    !die_get_member_type(&type_die, offset, &type_die))
> +			return -1;
> +
> +		tsr->type = type_die;
> +		tsr->kind = TSR_KIND_TYPE;
> +		tsr->offset = 0;
> +		tsr->imm_value = 0;
> +		tsr->ok = true;
> +
> +		if (src->multi_regs) {
> +			pr_debug_dtp("%s [%x] global (reg%d, reg%d) -> reg%d",
> +				     insn_name, insn_offset, src->reg1, src->reg2, dreg);
> +		} else {
> +			pr_debug_dtp("%s [%x] global (reg%d) -> reg%d",
> +				     insn_name, insn_offset, sreg, dreg);
> +		}
> +		pr_debug_type_name(&tsr->type, tsr->kind);
> +		return 0;
> +	}
>   	/* Or try another register if any */
>   	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>   		sreg = src->reg2;
> @@ -510,7 +536,7 @@ static int propagate_load_reg_state(struct type_state *state,
>   }
>   
>   static void update_load_insn_state(struct type_state *state,
> -				   struct data_loc_info *dloc,
> +				   struct data_loc_info *dloc, Dwarf_Die *cu_die,
>   				   struct disasm_line *dl,
>   				   struct annotated_op_loc *src,
>   				   struct annotated_op_loc *dst)
> @@ -523,7 +549,7 @@ static void update_load_insn_state(struct type_state *state,
>   		goto out_err_adjust;
>   
>   	/* Handle the first destination register */
> -	if (propagate_load_reg_state(state, dloc, dl, dst->reg1, src,
> +	if (propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg1, src,
>   				     reg_offset, insn_name))
>   		goto out_err_adjust;
>   
> @@ -532,7 +558,7 @@ static void update_load_insn_state(struct type_state *state,
>   		int reg_size = arm64__reg_size(dl->ops.target.raw);
>   
>   		if (reg_size < 0 ||
> -		    propagate_load_reg_state(state, dloc, dl, dst->reg2, src,
> +		    propagate_load_reg_state(state, dloc, cu_die, dl, dst->reg2, src,
>   					     reg_offset + reg_size, insn_name))
>   			goto out_err_adjust;
>   	}
> @@ -735,14 +761,16 @@ static void update_add_insn_state(struct type_state *state,
>   			imm_value = state->regs[reg2].imm_value;
>   	}
>   
> -	if (src_tsr.kind == TSR_KIND_CONST) {
> +	if (src_tsr.kind == TSR_KIND_CONST || src_tsr.kind == TSR_KIND_GLOBAL_ADDR) {


GLOBAL_ADDR inherits the two add-handler issues raised on patch 20:
a non-constant reg2 still propagates with an implicit addend of 0
(now producing a wrong global address), and the commutative
add rd, const_reg, global_reg case still drops the global side.
Fixes discussed there would cover both.

Thanks.
Shuai

