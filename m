Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E67C472772
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046404; cv=none; b=SK1JkV3vDMjYXsTVSS5tivfG3FF6yETe2CWllmuOih1Hp/+zDz6VJ2U5fZ5cC3GgpUmQoCAWkKP0qL6dt5U/kWPvoE76qR3G3S1q5X97cUopXrfuAncqXrVzH9AEL8FAoReWHfN2NbCFLeQmiCCyYSaZxkurd5bN3FmzOruxzLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046404; c=relaxed/simple;
	bh=77gnxKwz5I5zeC5JQQSJW3M6o/EvVLmsqw12CIkM2V0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FGuJkD9YVJ/PvZPFOy2tYT7LYiTxUHAD3d2uACXPMb1D35AgWVXYu6qsQJVr6fFg8idMJ1vLnvowuOcZa2yJpXcTycrMqJlBLDY44JTacujUI2jKwyZNbinsTO34++YChQgR3ja6B5v7drCNplOMHZOrn/s4eFFSZymsW0b9Ylk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hgdYK4nv0zYQvZ8
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:19:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 9AAD640576
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:19:56 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgC3crB7rqJqfqXQBQ--.17854S2;
	Thu, 10 Sep 2026 21:19:56 +0800 (CST)
Message-ID: <9b4cc536-fafa-4d3c-811c-4f443da321a9@huaweicloud.com>
Date: Thu, 10 Sep 2026 21:19:55 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 16/26] perf annotate-arm64: Support load instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <a30c739f6462865d2ce4f8a780a12ec28bac707d.1788872630.git.wutengda@huaweicloud.com>
 <20260908132348.079CC1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908132348.079CC1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgC3crB7rqJqfqXQBQ--.17854S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFyrXw4xCw4DWrWUAFyUGFg_yoWrAF4xpF
	ZxCay5GFWUXrWagrnFqF45uF909w1xGa45ury5AFn3tFnFvrnYka93tayagayUGrZYyw4U
	Zw1jvrnrZ3y8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:23, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Unintended rollback of valid type state for the first destination register in a multi-register load (e.g., ldp) if the second register's type cannot be resolved.
> - [Medium] Missing support for `TSR_KIND_POINTER` in `propagate_load_reg_state` causes type tracking to silently fail for variables whose addresses are held in registers.
> --
> 
> commit 6913b761b417f151400c62773b3dd0ee4dcddbf2
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support load instruction tracking
> 
> Extend update_insn_state_arm64() to handle load instructions, tracking
> register state changes when data is loaded from memory to registers. Introduces
> propagate_load_reg_state() and update_load_insn_state() to handle standard
> loads and load pairs.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 9a32265265223..c239ad9473dcc 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -455,11 +455,206 @@ static bool is_readonly_branch_or_cmp(const char *name)
> 
> [ ... ]
> 
>> +static int propagate_load_reg_state(struct type_state *state,
>> +				    struct data_loc_info *dloc,
>> +				    struct disasm_line *dl, int dreg,
>> +				    struct annotated_op_loc *src,
>> +				    struct type_state_reg **src_states,
>> +				    int mem_offset)
>> +{
> 
> [ ... ]
> 
>> +	if (!src_tsr || !src_tsr->ok)
>> +		return -1;
>> +
>> +	/* Dereference the pointer if it has one */
>> +	if (src_tsr->kind == TSR_KIND_TYPE &&
>> +	    die_deref_ptr_type(&src_tsr->type,
>> +			       src_tsr->offset + reg_offset, &type_die)) {
> 
> [Severity: Medium]
> Will this silently fail to propagate types for pointers since it restricts
> dereferencing strictly to TSR_KIND_TYPE?
> 
> If the source register state is TSR_KIND_POINTER (e.g., from an earlier address
> calculation), it appears the pointer dereference will fail type propagation
> here, reducing data type profiling coverage.
> 

Agreed. It is necessary to add a check for TSR_KIND_POINTER similar to what x86 does.

>> +		tsr->type = type_die;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = 0;
>> +		tsr->ok = true;
> 
> [ ... ]
> 
>> +static void update_load_insn_state(struct type_state *state,
>> +				   struct data_loc_info *dloc,
>> +				   struct disasm_line *dl,
>> +				   struct annotated_op_loc *src,
>> +				   struct annotated_op_loc *dst)
>> +{
> 
> [ ... ]
> 
>> +	/* Handle the first destination register */
>> +	if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
>> +				     src, src_states, /*mem_offset=*/0))
>> +		goto out_err_adjust;
>> +
>> +	/* Handle the second destination register (if any) */
>> +	if (dst->multi_regs) {
>> +		int mem_offset;
>> +
>> +		/*
>> +		 * ldpsw loads two 32-bit signed words into 64-bit registers.
>> +		 * Memory spacing between elements is 4 bytes, not the register size.
>> +		 */
>> +		if (!strcmp(dl->ins.name, "ldpsw"))
>> +			mem_offset = 4;
>> +		else
>> +			mem_offset = arm64__reg_size(dl->ops.target.raw);
>> +
>> +		if (mem_offset < 0 ||
>> +		    propagate_load_reg_state(state, dloc, dl, dst->reg2,
>> +					     src, src_states, mem_offset))
>> +			goto out_err_adjust;
>> +	}
>> +
>> +out_adjust:
>> +	adjust_reg_index_state(state, dloc, dl, src);
>> +	return;
>> +
>> +out_err_adjust:
>> +	if (has_reg_type(state, dst->reg1))
>> +		invalidate_reg_state(&state->regs[dst->reg1]);
>> +	if (dst->multi_regs && has_reg_type(state, dst->reg2))
>> +		invalidate_reg_state(&state->regs[dst->reg2]);
>> +	goto out_adjust;
>> +}
> 
> [Severity: Medium]
> Does this unintentionally discard valid type state for the first destination
> register if the second destination register's type cannot be resolved?
> 
> If an arm64 ldp instruction is analyzed where the first member is trackable,
> but the second member cannot be resolved, this error path seems to
> unconditionally invalidate the successfully resolved state of dst->reg1.
> 

Agreed.

Thanks,
Tengda

