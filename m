Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFD33C1414
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892610; cv=none; b=R0Zrvi6Al/oShtt7/VjRvPOlLRS0B+61zTEoqqa2saQX8y/HET5ta07j1KRuAwBj3uFuRZQ/BaneiGXGYbrleTGG+xupvdzyCi2ut7Ia46YUuvncPzqmzjniMUIXpmR6oGjqqpCY8c+oDZVVphu0031QBrutZDlP939G4DzRjJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892610; c=relaxed/simple;
	bh=/C45rPrmZNkarfg895z8v26zFs6Irq9VBapX1psmPgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AqsGVRXoUu9wW9Qp3fnKOjDvcZIlppQnsg3i37aeufHdcALu4Ma2xAwZJp31YZKAsR1Gk2u+EAIdhQw/5pV8E7tcH+nSS1eBC3B9/onY0LmwtYPr/wBXgkE3NeACEnBCrtp/E7EgeiKjgA/DBnh4Mmfc/jg3EacWvI5DFpygX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqsm264z8zKHMP9
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:56:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 3279140589
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:56:44 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAXhvM7yERqX5fVAQ--.13115S2;
	Wed, 01 Jul 2026 15:56:44 +0800 (CST)
Message-ID: <25c17675-1299-454e-baca-6c483975eb9c@huaweicloud.com>
Date: Wed, 1 Jul 2026 15:56:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/21] perf annotate-arm64: Enable instruction tracking
 support
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-14-wutengda@huaweicloud.com>
 <20260701041202.000111F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041202.000111F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXhvM7yERqX5fVAQ--.13115S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUWw4fWF4rGryUXrW5KFg_yoWrCF4fpa
	yYk345JFWjqr4IgrnrZF48XFy3Ga1fG3yUury5tw1SvrnIvryktFs3tFy2kFWrCry5Cw4U
	Xa1qqrWUA3yDCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:12, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> New issues:
> - [High] Missing function call register invalidation for ARM64 data type tracking.
> - [Medium] Failure to invalidate secondary destination registers (`reg2`) in multi-register instructions.
> 
> Pre-existing issues:
> - [High] Missing `multi_regs` evaluation for register operands in load/store instructions.
> --
> 
> commit a1f858405ccf3b88519235d7e08cb42762d969ac
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Enable instruction tracking support
> 
> Enable basic instruction tracking for arm64 by implementing three essential
> functions in the find_data_type_block() call path: arch_supports_insn_tracking,
> init_type_state, and update_insn_state.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 77b6f4841c849..48b1c94273eb6 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -324,6 +326,31 @@ static int extract_op_location_arm64(const struct arch *arch,
>>  	return 0;
>>  }
>>  
>> +#ifdef HAVE_LIBDW_SUPPORT
>> +static void update_insn_state_arm64(struct type_state *state,
>> +				    struct data_loc_info *dloc, Dwarf_Die *cu_die __maybe_unused,
>> +				    struct disasm_line *dl)
>> +{
>> +	struct annotated_insn_loc loc;
>> +	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
>> +	u32 insn_offset = dl->al.offset;
>> +
>> +	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
>> +		return;
>> +
> 
> [Severity: High]
> Does this function miss a check for function calls?
> 
> When an instruction is a function call (e.g., bl or blr), this code does not
> check ins__is_call(&dl->ins). As a result, it fails to invalidate the
> caller-saved registers (x0-x17) and update the return type in x0.
> 
> While init_type_state() correctly initializes the caller_saved flags for
> these registers, won't omitting the invalidation here cause subsequent
> accesses to inherit incorrect type states across function calls?
> 

Agreed.

>> +	/*
>> +	 * For unsupported instructions with a destination register, invalidate
>> +	 * the destination register itself to prevent incorrect type propagation.
>> +	 */
>> +	if (has_reg_type(state, dst->reg1)) {
>> +		pr_debug_dtp("%s [%x] invalidate reg%d\n",
>> +			     dl->ins.name, insn_offset, dst->reg1);
>> +		invalidate_reg_state(&state->regs[dst->reg1]);
>> +		return;
>> +	}
> 
> [Severity: Medium]
> Does this fallback logic need to handle secondary destination registers?
> 
> When an unsupported instruction modifies multiple registers (e.g., casp),
> this only checks and invalidates the primary destination register
> (dst->reg1). 
> 
> If the instruction has a secondary register (where dst->multi_regs is
> true), should we also invalidate dst->reg2 so it doesn't retain an
> incorrect type state?
> 

I'll leave it as-is. reg1 is enough for most cases, and multi-register
instructions are rare. We can revisit if needed.

> [Severity: High]
> This is a pre-existing issue, but I noticed a potential problem in
> arm64_ldst__parse() regarding multi-register instructions:
> 
> tools/perf/util/annotate-arch/annotate-arm64.c:arm64_ldst__parse() {
> ...
> 	if (arm64__insn_is_source_first(dl)) {
> 		ops->source.raw = left;
> 		ops->source.mem_ref = false;
> 		ops->target.raw = right;
> 		ops->target.mem_ref = true;
> 		ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
> 	}
> ...
> }
> 
> Here, arm64__check_multi_regs() is only applied to the memory operand side
> (ops->target in this case). The register operand side is left with
> multi_regs = false. 
> 
> Because of this, extract_op_location_arm64() fails to parse the second
> register (reg2) for instructions like ldp and stp, leaving it as -1. Won't
> this cause the data type tracking logic to silently miss type updates and
> queries for the secondary register?
> 

I'll leave it as-is. We only care about mem_ref cases. Multi-register
instructions without mem_ref are out of scope.

>> +}
>> +#endif
> 

