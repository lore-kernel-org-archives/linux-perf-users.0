Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667F741D234;
	Tue, 11 Aug 2026 08:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437915; cv=none; b=euz3N5CQAtAU8rwPXKiNG3lrB760/arm+vZw2JSPEQMVdJodTuiXY1hXYuNPCcvVvQvlYklr95iCF40MlcCwEl+4v/+kG5QiKD0InT8Yek8n8tYYnuG522uQJlx/fjtCoSHMdamDZI7a7FUyGbJhKTKLJNOJ5mcM0cQx8pZwO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437915; c=relaxed/simple;
	bh=XHAy90IfX5N9WQAuZQhOnzdqFKIxEoblW4+ZRxeshkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8bkxFEROWCPFiBgw18IR9246XO/SmgdJP4iQJ4Ecnk0qFXgmnBqwF1DNJM3U0EBjo9IYaHqVh6+d41NFTuwHA/JwNtPuAZ13qfQJU7wH6Sdo2AENBe2uilAnpCZqdJRLs1WJit5wBN+NVE9JoUSMS8tJ+AcLCiop7O9nxQR22E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CqQLEFUF; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CqQLEFUF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786437910; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kPZQc8ApE1iI5YePnhnnz/tryvTLMAYB9P9vn7r+k5s=;
	b=CqQLEFUFLZEmNvVzWdrH3eSO+P3wadOA8N3rtUDflUuIkoP4KDAGnghplYs9CtMo23iXHGj3bhzJOXX4A2OjWEtKtxgUMKGQ7TEsfF4Zp5X/RNCy4uiCgcXqt7WVHRo5GEsLWcUnvDN7n93MSlrEtIGsynMbPGlfwz0xn7Qukr4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nwuPr_1786437907;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nwuPr_1786437907 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:45:08 +0800
Message-ID: <89e66d40-5f9f-4147-beda-00623797cd04@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:45:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 20/23] perf annotate-arm64: Support 'add' instruction
 tracking
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
 <20260808122400.2961238-21-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-21-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to track 'add' instructions for
> structure member address calculation, which commonly appear as:
> 
>    add  dreg, base, #offset
>    add  dreg, base, reg2     (reg2 holds a constant)
> 
> Unlike x86, the arm64 'add' instruction has an extra base register among
> its source operands. Therefore, in terms of propagating the data type,
> it is essentially performing a 'mov', except that before the 'mov', it
> first needs to be updated by adding the offset or reg2.
> 
> A real-world example is shown below:
> 
>    ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>    ffff80008001c9c4:  add  x19, x0, #0xeb8   // x0 (task_struct*) + 0xeb8 -> x19
> * ffff80008001c9d0:  ldr  x0, [x19]
> 
> Before this commit, the type flow broke at the 'add' instruction,
> leaving the subsequent load with no type information:
> 
>    chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
>    final result: no type information
> 
> After this commit, the tracker correctly follows the member address
> calculation:
> 
>    var [0] reg0 offset 0 type='struct task_struct*'
>    add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
>    chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
>    found by insn track: 0(reg19) type-offset=0xeb8
>    final result: type='struct task_struct'
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 87 ++++++++++++++++++-
>   1 file changed, 85 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 7b780bad8c07..eaeb4433fc3a 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -688,6 +688,87 @@ static void update_mov_insn_state(struct type_state *state,
>   	pr_debug_type_name(&tsr->type, tsr->kind);
>   }
>   
> +static void update_add_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	struct type_state_reg src_tsr;
> +	u32 insn_offset = dl->al.offset;
> +	int sreg = src->reg1;
> +	int dreg = dst->reg1;
> +	u64 imm_value;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr = &state->regs[dreg];
> +	tsr->copied_from = -1;
> +
> +retry:
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	src_tsr = state->regs[sreg];
> +
> +	/*
> +	 * Handle 'add' instructions of the form:
> +	 *   add  dreg, base, #offset     (immediate offset)
> +	 *   add  dreg, base, reg2        (reg2 holds a constant)
> +	 *
> +	 * For case 2, retrieve the constant value from reg2
> +	 * and use it as the offset.
> +	 */
> +	imm_value = src->offset;
> +	if (src->multi_regs) {
> +		int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
> +
> +		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
> +			/* Unable to resolve type for dst, bail out */
> +			invalidate_reg_state(tsr);
> +			return;
> +		}
> +		if (state->regs[reg2].kind == TSR_KIND_CONST)
> +			imm_value = state->regs[reg2].imm_value;

First, when reg2 is valid but not TSR_KIND_CONST - say a pointer
freshly loaded from memory - the addend is unknown at analysis time,
yet imm_value silently stays 0 and propagation continues, tracking
the destination as base + 0. Note the asymmetry: no state at all
invalidates, but state that doesn't yield a value pretends the
addend is zero. Unknown addend should invalidate as well:

         if (state->regs[reg2].kind != TSR_KIND_CONST) {
             invalidate_reg_state(tsr);
             return;
         }

Second, the shifted/extended forms still break even with a constant
reg2: extract_op_location_arm64() drops the "lsl #3" (or uxtw/sxtw)
modifier, so add x0, x1, x2, lsl #3 contributes the unshifted value
and maps later accesses to the wrong field. Maybe flag such operands
during extraction (or fail the reg2 extraction) so the handler can
skip them.

> +	}
> +
> +	if (src_tsr.kind == TSR_KIND_CONST) {
> +		tsr->kind = src_tsr.kind;
> +		tsr->imm_value = src_tsr.imm_value + imm_value;
> +		tsr->offset = 0;
> +		tsr->ok = src_tsr.ok;
> +
> +		pr_debug_dtp("add [%x] imm %#"PRIx64"(reg%d) -> reg%d\n",
> +			     insn_offset, imm_value, sreg, dreg);

And since add is commutative, this early return drops the pointer
side for add rd, const_reg, ptr_reg: sreg starts as reg1, hits the
CONST case and returns before the goto retry at the bottom ever gets
a chance to evaluate the pointer register. The result should be the
pointer with the constant applied as an offset, not a plain constant.
Maybe check the other register for a pointer type before falling into
the CONST case (or move the CONST handling after the retry).

Thanks,
Shuai
