Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC4D4A261D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559753; cv=none; b=NXuwQabfq9GrDOSb6cBXIxSKuSD7rWNVIj/C2nOOJLhIzkmw7/MPI5S4ymNFMdKCNfSUX7QRC4QReKY2xrtLdkNnevYYyRat+dVX6eF4MSaEsJEvUrGcCV6kj9a6s6ax63oLuKT7d+/COFIQ6+k+yfyuMOjRtGwica9v/JR3hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559753; c=relaxed/simple;
	bh=fNugRSq9PmrzHIjwPfcQnXhaeAst/a0SfHH21Q8krfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LQYhlK+lbZdbG75TZ7F12taoqGMT3MOa2EnHq62UavSZSY/nUDWa7mWyqBPVNMNEHhdn2EAKAt3K3oqoX3N0RQlIZOALuiAtBCen/KNN0+LSQePnGlrezrm288IN7dM3x1lbB0UhEqAA4AQDXnUyqk71w5DYoVQqXje18ezg9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hlHQ56QhwzKHMq0
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 19:55:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3FA8E4056D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 19:55:40 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgCndim7g6pq0vsSAg--.59890S2;
	Wed, 16 Sep 2026 19:55:40 +0800 (CST)
Message-ID: <e1021204-6e4a-4767-889e-fd677409df1e@huaweicloud.com>
Date: Wed, 16 Sep 2026 19:55:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/26] perf annotate-arm64: Support stack variable
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <11bcde1a75d96b524cc5a7f6fa442025680e56a0.1789521520.git.wutengda@huaweicloud.com>
 <20260916014905.D44C91F000FF@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260916014905.D44C91F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCndim7g6pq0vsSAg--.59890S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDAryUXryrZFWUXFWkZwb_yoW5Zr4xpF
	98Cay5Wrs7Jw109FnrXr4xXr98Ww4xKF1S9r90qan7JFnFyrnYkas7Kay2qFWUCryvkw4j
	vw1q9r4DXrZakaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/16 9:49, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: stale stack state due to bypassed invalidation in update_store_insn_state
> --
> 
> commit 2ddb0f384d44eeb70844d8c3adc06f8d55101f68
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support stack variable tracking
> 
> Extend update_insn_state_arm64() to track data types stored on the stack. The
> implementation handles stack loads and stores to follow data types as they
> move between registers and memory.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index a72c7703dd6b3..8339aab0d314f 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> +/*
>> + * For store insns: propagate type from @sreg to the memory location referenced
>> + * by @dst, applying @mem_spacing to account for multi-regs stores (e.g. stp).
>> + */
>> +static void propagate_store_reg_state(struct type_state *state,
>> +				      struct data_loc_info *dloc,
>> +				      struct disasm_line *dl, int sreg,
>> +				      struct annotated_op_loc *dst,
>> +				      int mem_spacing)
>> +{
> [ ... ]
>> +		if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
>> +			stack = find_stack_state(state, offset);
>> +			/* Preserve compound states when only a member is overwritten. */
>> +			if (stack && !stack->compound)
>> +				delete_stack_state(state, offset);
>> +
>> +			return;
>> +		}
> [ ... ]
>> +static void update_store_insn_state(struct type_state *state,
>> +				    struct data_loc_info *dloc,
>> +				    struct disasm_line *dl,
>> +				    struct annotated_op_loc *src,
>> +				    struct annotated_op_loc *dst)
>> +{
>> +	int mem_spacing = 0;
>> +
>> +	if (!has_reg_type(state, dst->reg1))
>> +		return;
>> +
>> +	/* Handle the first source register */
>> +	if (has_reg_type(state, src->reg1))
>> +		propagate_store_reg_state(state, dloc, dl, src->reg1,
>> +					  dst, mem_spacing);
>> +
>> +	if (!src->multi_regs || !has_reg_type(state, src->reg2))
>> +		goto out_adjust;
> 
> [Severity: Medium]
> Does the has_reg_type() guard here inadvertently skip the stack state
> invalidation logic?
> 
> Looking at propagate_store_reg_state() above, there is logic to delete the
> stack state if the source register is untracked. However, because
> update_store_insn_state() completely bypasses the call to
> propagate_store_reg_state() when the source register is untracked, this
> cleanup is never reached.
> 
> If an untracked register is stored into a stack slot previously used for a
> tracked variable, could this leave stale tracking state on the stack, causing
> subsequent loads from that slot to inherit the wrong type?
> 

Agreed.

>> +
>> +	/* Handle the second source register */
>> +	mem_spacing = arm64__reg_size(dl->ops.source.raw);
>> +
>> +	if (mem_spacing >= 0)
>> +		propagate_store_reg_state(state, dloc, dl, src->reg2,
>> +					  dst, mem_spacing);
>> +
>> +out_adjust:
>> +	adjust_reg_index_state(state, dloc, dl, dst);
>> +}
> 

