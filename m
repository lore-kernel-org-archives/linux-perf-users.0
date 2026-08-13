Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90861481AAD
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786632272; cv=none; b=a2W1zOSh3MsnbibiWPB5j+cPK5gtaui1dwBud99plwRT5kQaYtnGMF/GlI8tQrMd6WhKEMtNKx6WJoo3CLBX+cKQ1yUhWaJsL6lpbmzLaDECj2l3Cb+gUSdzc0pBOb6Vb21+PHmpv6clojW/z8BdmhpEnKWazMyP4/yK7sFcl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786632272; c=relaxed/simple;
	bh=OAYqWj4gRrCLy7ak9V72r7VrOAlGFn0jjLe4KezteLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C9LV4ibK66jxcz0Jj7S3Vom2zw12DQ7hHkG5cN+Wo9uqW48HZZgO4JWjWP1fxTSKogKnvGK15J4yg65GElrQ8rz0ej3dcPrKlC88GfliOUt462+uPdR7eekYCz/TO9GPM/FwOTGkX3HKhHFmmVKLBfI0k2g6uHFKeN5E7NNlUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hLSmY5b8nzYQtp7
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 22:44:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id A170D4058C
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 22:44:20 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgC3IYlD2H1q6DLDCA--.32881S2;
	Thu, 13 Aug 2026 22:44:20 +0800 (CST)
Message-ID: <1be21704-c1bd-46de-8dc8-935a792e6402@huaweicloud.com>
Date: Thu, 13 Aug 2026 22:44:19 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/23] perf annotate-arm64: Support load instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-15-wutengda@huaweicloud.com>
 <20260808130849.500291F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808130849.500291F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgC3IYlD2H1q6DLDCA--.32881S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFWrWr13KryrXr43ur13CFg_yoW3Gw4rpa
	98Kw45GF40qr4Fgrs7XF47trya9a1fGF45uryUA3WfKrnIyr1kKFs3KFW3uFW5CrZ5Zw4Y
	qr4jv3yDZFWUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:08, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Medium] `update_load_insn_state` incorrectly uses the newly loaded type as the base pointer for the second register in `ldp` instructions when the base register overlaps with the first destination register (e.g., `ldp x0, x1, [x0]`).
> - [Medium] `update_insn_state_arm64` blindly invalidates the base pointer type state for store instructions because it fails to check `!dst->mem_ref` before invalidating `dst->reg1` for non-load instructions.
> - [Medium] Incorrect memory offset calculation for the second register in `LDPSW` (Load Pair of Signed Words) instructions due to reliance on the destination register prefix for size calculation.
> - [Medium] Incomplete register recognition in `arm64__is_reg()` prevents processing or defensive invalidation of the second destination register in `ldp` instructions involving zero registers (`xzr`) or SIMD registers.
> - [Medium] `arm64_ldst__parse` incorrectly parses PC-relative memory loads if an end-of-line comment contains a bracket (`[`), improperly interpreting the comment as the memory operand.
> --
> 
> --- Patch [14]: [PATCH v4 14/23] perf annotate-arm64: Support load instruction tracking ---
> commit d3c58ddf95c5da043aecdd1f99723182e79fd318
> Author: Tengda Wu <wutengda@huaweicloud.com>
> Subject: perf annotate-arm64: Support load instruction tracking
> 
> This commit extends update_insn_state_arm64() to handle LDR and LDP
> instructions. It tracks register state changes when data is loaded from
> memory into registers by propagating the data type of the base register
> to the destination register, handling various addressing modes.
> 
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -358,11 +358,152 @@ static int extract_op_location_arm64(const struct arch *arch,
>>  }
>>  
>>  #ifdef HAVE_LIBDW_SUPPORT
>> +static int arm64__reg_size(const char *reg)
>> +{
>> +	if (!reg || !*reg || !arm64__is_reg(reg))
> 
> [Severity: Medium]
> Since arm64__is_reg() does not recognize zero registers like xzr or SIMD
> registers, can this cause us to incorrectly skip processing the second
> destination register in ldp instructions?
> 
> If the first register is unrecognized (for example, in ldp xzr, x19, [sp]),
> arm64__check_multi_regs() might evaluate multi_regs to false. This would
> cause update_load_insn_state() to skip the second register entirely, leaving
> its stale type state intact.
> 
>> +		return -1;
> 

Agreed. I will add xzr/wzr register recognition to arm64__is_reg(). SIMD registers
are not supported for now.


> [ ... ]
> 
>> +static void update_load_insn_state(struct type_state *state,
>> +				   struct disasm_line *dl,
>> +				   struct annotated_op_loc *src,
>> +				   struct annotated_op_loc *dst)
>> +{
>> +	int reg_offset = get_reg_index_offset(src);
>> +	const char *insn_name = dst->multi_regs ? "ldp" : "ldr";
>> +
>> +	if (!has_reg_type(state, dst->reg1) ||
>> +	    (dst->multi_regs && !has_reg_type(state, dst->reg2)))
>> +		goto out_err_adjust;
>> +
>> +	/* Handle the first destination register */
>> +	if (propagate_load_reg_state(state, dl, dst->reg1, src,
>> +				     reg_offset, insn_name))
>> +		goto out_err_adjust;
> 
> [Severity: Medium]
> Can this inadvertently corrupt the type tracking state when the base register
> and the first destination register overlap?
> 
> If we process an instruction like ldp x0, x1, [x0], the first call to
> propagate_load_reg_state() updates state->regs[dst->reg1] (which is x0).
> 
> When the second call to propagate_load_reg_state() runs for the second
> destination register:
> 
> 	if (dst->multi_regs) {
> 		int reg_size = arm64__reg_size(dl->ops.target.raw);
> 		...
> 		propagate_load_reg_state(state, dl, dst->reg2, src,
> 
> it will read from src->reg1 (which is also x0). Because the state for x0
> was already overwritten in the first call, the second call would use the
> newly loaded type as the base pointer instead of the original base pointer
> type.
> 

Agreed. I need to snapshot the source register state beforehand.

>> +
>> +	/* Handle the second destination register (ldp only) */
>> +	if (dst->multi_regs) {
>> +		int reg_size = arm64__reg_size(dl->ops.target.raw);
> 
> [Severity: Medium]
> Does arm64__reg_size() return the correct memory offset for ldpsw
> instructions?
> 
> For a Load Pair of Signed Words (ldpsw), the instruction loads two 32-bit
> values from memory into 64-bit registers. Using arm64__reg_size() on the
> destination register (which starts with 'x') returns 8, but the memory
> spacing should be 4 bytes. 
> 
> This would result in passing reg_offset + 8 instead of reg_offset + 4 to
> propagate_load_reg_state() for the second register, leading to an incorrect
> struct field offset lookup.
> 

Agreed. I missed ldpsw (from the architecture reference manual, it appears to
be the only special case among load-pair instructions).

>> +
>> +		if (reg_size < 0 ||
>> +		    propagate_load_reg_state(state, dl, dst->reg2, src,
>> +					     reg_offset + reg_size, insn_name))
>> +			goto out_err_adjust;
>> +	}
> 
> [ ... ]
> 
>> @@ -418,7 +559,8 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	 * Invalidate destination register(s) for unsupported instructions to
>>  	 * prevent stale type info from propagating to subsequent instructions.
>>  	 */
>> -	if (has_reg_type(state, dst->reg1)) {
>> +	if (has_reg_type(state, dst->reg1) &&
>> +	    strncmp(dl->ins.name, "ld", 2)) {
> 
> [Severity: Medium]
> Should we check if the destination is actually a memory reference before
> invalidating the register?
> 
> For store instructions (like str x0, [x1, #16]), arm64_ldst__parse() reverses
> the operands so that dst becomes the memory operand and dst->reg1 is the
> base pointer (x1). 
> 
> By unconditionally invalidating dst->reg1 for any instruction that doesn't
> start with "ld", we would erroneously destroy the type state of the base
> pointer used in the store.
> 

Agreed.

>>  		pr_debug_dtp("%s [%x] invalidate reg%d",
>>  			     dl->ins.name, insn_offset, dst->reg1);
>>  		invalidate_reg_state(&state->regs[dst->reg1]);
> 
> [ ... ]
> 
>> +	/* Memory to register transfers */
>> +	if (!strncmp(dl->ins.name, "ld", 2))
>> +		update_load_insn_state(state, dl, src, dst);
>>  }
>>  #endif
> 
> [Severity: Medium]
> Could PC-relative memory loads end up with missing operands here if their
> end-of-line comments contain a bracket?
> 
> In arm64_ldst__parse(), which runs before we reach this point, strchr()
> searches for a bracket. If a PC-relative load lacks brackets in its operands
> but contains one in the comment (for example, ldr x0, 1234 <sym> // [foo]),
> the parser matches the comment bracket and parses backwards.
> 
> This drops the actual PC-relative target entirely, which would prevent
> update_load_insn_state() from successfully tracking the type when evaluated
> here.
> 

The comment issue in arm64_ldst__parse() has already been mentioned previously
and will be fixed. PC-relative loads (ldr) themselves generally do not
carry type information; they are typically used to load a label address
for branching:

  ffff800081d0c0a4: 58000068 ldr x8, ffff800081d0c0b0 <cpu_resume+0x28>
  ffff800081d0c0a8: d61f0100 br x8

So I think this case can be ignored.

Thanks,
Tengda

