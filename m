Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818537E5E5;
	Tue, 11 Aug 2026 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786437485; cv=none; b=Lf4/x0o2wB+te5T0Vn/GhU94R7naWz4UNscwgxQZwAcRNdAhVI4F6cNUeaKesPvTbOInef6SrKYXY3IwBEZ5v190V0vWYl5kC8F9B7lHgId9XV0eKVTqdKwPwZ8Ukz2E9JStiv9Zcf/KMb9s1WOtkUYnUdst0+1pClFaOgizJ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786437485; c=relaxed/simple;
	bh=edbAn165VORt52kLjmZY2kdDpedIqjtWTWhK68jHnxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfB3zaEMKeRcrF94balc8tOaQCHXeonra5h8m5R+Um3F9nqWnm24BYq67aySxgTboYlogo1vAJEWgZqUqznf6s+uaRIoYPGSa7sPbLbygSqWMBzG5+GrXoqZ1I/6OQrqS9WqkK+v2O+mvCgrGgt39H21Qso9wNtZxPI+YE8tH3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SihtIbnD; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SihtIbnD"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786437473; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=EYwayPwW3BAHajuYrGUPKQBCmkAknyyoHjvcu0yw+Y0=;
	b=SihtIbnDa0jkpN/VLYPuLluOBGtUJizmL6RurUyOp0ejL/F0pz3jLH2p1IA9bVAgfhATN9FRC7moc0DBBY04o7bVGWN9Ckwwzt7EiGKkat8YggWzoqw6LAvSFsBN33lUoavfcdhiOE3A8plTAyXqvFRn/v47AqhSP93Hah83ODs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X8nqWIz_1786437470;
Received: from 30.246.162.187(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0X8nqWIz_1786437470 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 16:37:51 +0800
Message-ID: <960b490f-42da-4a9e-8734-62f9c3773b2d@linux.alibaba.com>
Date: Tue, 11 Aug 2026 16:37:49 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/23] perf annotate-arm64: Support 'mov' instruction
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
 <20260808122400.2961238-20-wutengda@huaweicloud.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20260808122400.2961238-20-wutengda@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/8/26 8:23 PM, Tengda Wu wrote:
> Extend update_insn_state() for arm64 to support register-to-register and
> immediate-to-register 'mov' instructions.
> 
> For register-to-register 'mov' (e.g., mov dreg, sreg), propagate data type
> information from the source register to the destination register.
> 
> For immediate-to-register 'mov' (e.g., mov dreg, #imm), store the immediate
> value in the destination register's imm_value field and set its kind to
> TSR_KIND_CONST, allowing subsequent instructions to resolve it as a
> constant.
> 
> A real-world example is shown below:
> 
>    ffff8000803eebf8 <get_vma_policy>:
>    ffff8000803eec20:  mov  x21, x0          // x0 (struct vm_area_struct*) -> x21
>    ffff8000803eec28:  ldr  x2, [x0, #112]
>    ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
> * ffff8000803eec94:  ldr  x0, [x21, #152]
> 
> Before this commit, the type of x21 was unknown, causing the subsequent
> inference to fail:
> 
>    var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>    chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
>    final result: no type information
> 
> After this commit, the type of x21 is correctly inferred as 'vm_area_struct':
> 
>    var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>    mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
>    chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
>    found by insn track: 0x98(reg21) type-offset=0x98
>    final result:  type='struct vm_area_struct' size=0xb0
> 
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>   .../perf/util/annotate-arch/annotate-arm64.c  | 53 ++++++++++++++++++-
>   1 file changed, 52 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
> index 6e09e9707256..7b780bad8c07 100644
> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   #include <linux/compiler.h>
>   #include <errno.h>
> +#include <inttypes.h>
>   #include <stdlib.h>
>   #include <string.h>
>   #include <linux/ctype.h>
> @@ -484,6 +485,7 @@ static int propagate_load_reg_state(struct type_state *state,
>   		tsr->type = type_die;
>   		tsr->kind = TSR_KIND_TYPE;
>   		tsr->offset = 0;
> +		tsr->imm_value = 0;
>   		tsr->ok = true;
>   
>   		if (src->multi_regs) {
> @@ -641,6 +643,51 @@ static void update_store_insn_state(struct type_state *state,
>   	adjust_reg_index_state(state, dst, insn_name, dl->al.offset);
>   }
>   
> +static void update_mov_insn_state(struct type_state *state,
> +				  struct disasm_line *dl,
> +				  struct annotated_op_loc *src,
> +				  struct annotated_op_loc *dst)
> +{
> +	struct type_state_reg *tsr;
> +	u32 insn_offset = dl->al.offset;
> +	int sreg = src->reg1;
> +	int dreg = dst->reg1;
> +
> +	if (!has_reg_type(state, dreg))
> +		return;
> +
> +	tsr = &state->regs[dreg];
> +	tsr->copied_from = -1;
> +
> +	if (src->imm) {
> +		tsr->kind = TSR_KIND_CONST;
> +		tsr->imm_value = src->offset;
> +		tsr->offset = 0;
> +		tsr->ok = true;

This overwrites only part of the register state: if the destination
previously held a variable with an active DWARF lifetime, the stale
lifetime_active/lifetime_end survive, and the call-invalidation
exemption then protects a plain constant across calls. Same gap as
the return-type block discussed earlier - clearing the register state
(invalidate_reg_state()) before filling it in would cover both.


> +
> +		pr_debug_dtp("mov [%x] imm=%#"PRIx64" -> reg%d\n",
> +			     insn_offset, tsr->imm_value, dreg);
> +		return;
> +	}
> +
> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
> +		invalidate_reg_state(tsr);
> +		return;
> +	}
> +
> +	tsr->type = state->regs[sreg].type;
> +	tsr->kind = state->regs[sreg].kind;
> +	tsr->imm_value = state->regs[sreg].imm_value;
> +	tsr->offset = state->regs[sreg].offset;
> +	tsr->ok = state->regs[sreg].ok;

onversely, the register-to-register path drops the lifetime fields
that the x86 handler explicitly copies. Not copying is arguably more
correct - the DWARF location range describes the variable living in
the source register - but it also means a value moved into a
callee-saved register gets invalidated by the first call, losing the
tracking. Is the omission intentional? If so, a comment would help;
either way the two archs should probably converge on one behaviour.

> +
> +	if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
> +		tsr->copied_from = sreg;
> +
> +	pr_debug_dtp("mov [%x] reg%d -> reg%d", insn_offset, sreg, dreg);
> +	pr_debug_type_name(&tsr->type, tsr->kind);
> +}
> +
>   static void update_insn_state_arm64(struct type_state *state,
>   				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>   				    struct disasm_line *dl)
> @@ -703,6 +750,7 @@ static void update_insn_state_arm64(struct type_state *state,
>   	 * prevent stale type info from propagating to subsequent instructions.
>   	 */
>   	if (has_reg_type(state, dst->reg1) &&
> +	    strcmp(dl->ins.name, "mov") &&
>   	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {

Comparison and test instructions get killed by this: for cmp x5, x6
the first operand ends up as the target (reg1 = x5), and since cmp
matches none of the exemptions above, a read-only register is
invalidated. Same for cmn and tst, and for the tested register of
cbz/cbnz/tbz/tbnz. Since comparisons sit between the tracked load and
the sampled access in almost every hot path, this silently drops a
lot of type resolution.

The x86 side avoids this by using a whitelist of instructions that
actually clobber pointer registers; here an exemption for the
read-only compares/tests would do:

     if (has_reg_type(state, dst->reg1) && !dst->mem_ref &&
         strcmp(dl->ins.name, "mov") && strcmp(dl->ins.name, "cmp") &&
         strcmp(dl->ins.name, "cmn") && strcmp(dl->ins.name, "tst") &&
         ...)

Thanks,
Shuai
