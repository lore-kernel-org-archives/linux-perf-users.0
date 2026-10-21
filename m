Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792547928;
	b=GciQDWOR26vK6MM7YntfcKTfGpwRpTNU9cn2QxnGa+lr3lAFLRoqn0ylysl58YAsNZcz
	 3PEoDnyeXrsAM12bVH7ep6mF9ENO4bYaPeRvlHJPs1DGZetE62FzSDeWSBvKOKpvOpe8a
	 2eQw9ZqG6n9sZYcgirUylGb0F5XBO4W1mDNBkvLC0Ao93ahqxct+yoo7wyyll98/xtLwg
	 ZMtyWywInXPv1E/zdMQ774PDSP8/a+WSJpWlhPjNv3A5O+MPbob3MQT+YWDgOApnmyjXS
	 PQNw7u5NFB7dnyZn1r9ObEZnxlqVY0KxoYoVPuZply5CNFMpR6lJLXpRaVmdMR+XoUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792547928;
	h=DMARC-Filter:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=QqjFGGnFG6TPnVy9+6VBpXIM5ds0Ve0VY/HafKIxOyo=;
	b=SmDioXIRMidNugVfAD4lqPktxbKwhGfZHpKxrLI8Q+2eslxnTlx97r3Ik5i1jBmxAONM
	 /YkKqKvPy2Pn+H4yQbv2A0eMMO7gpMS+kDgUirlq6eMz2QTsfDhKTuR7eDmpioL6hISYV
	 oCkMKnwZTe45X1kGYFrEuzO9AsX6BNLNOyyz0dlrIKQBI69GLk6fSpYH9o+7i1WmFEdJl
	 nKMhlRPsHbrO0WUfXctW+3sYSyoYJKjuQ4CM0001a5XRn27UMNenUFB/PbjhUflHq++SV
	 wocfelAQOOoeAVaXNAXdhH7hPeSxZjswNjp2XAKdDXRC31NeHMaHZOp4KijqYmwzNeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1CD606A330
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 01:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F1CD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8XWD35fVzKHLvP
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 09:58:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3939740561
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Oct 2026 09:58:43 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXCelSHNhqIXfsBA--.22166S2;
	Wed, 21 Oct 2026 09:58:43 +0800 (CST)
Message-ID: <bf6719dd-7166-4b9f-91ac-bc7e266d6565@huaweicloud.com>
Date: Wed, 21 Oct 2026 09:58:41 +0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/15] perf annotate-arm64: Support load instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1792411435.git.wutengda@huaweicloud.com>
 <a6085b6f08ba2ed533208ebe9227968770cd58ca.1792411435.git.wutengda@huaweicloud.com>
 <sashiko-outbox-179159@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-179159@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXCelSHNhqIXfsBA--.22166S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GF1DWw1rZF4xWFWrAFyxZrb_yoWfGr18pF
	WkCay5Ka17Xr4IgrsIqr4rWry3Ww1xWr1xCry5Za1SyFnFvr1rKa93KrW3WFWrGrZxAr1U
	Xw4jyrnxXw4jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/20 22:36, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf annotate-arm64: unused type_die in propagate_load_reg_state()
> - [Medium] perf annotate-arm64: missing reg2 extraction in ldp when reg1 is xzr/wzr
> --
> 
> commit d4331cee155820a433821da388de2a7297699e0e
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support load instruction tracking
> 
> This commit extends update_insn_state_arm64() to track register state
> changes across standard load and load-pair instructions, including
> pre-index and post-index addressing modes.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index c4cc8bca85cc0..0b5d1abbc5755 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -527,11 +527,212 @@ static void invalidate_unhandled_insn_regs(struct type_state *state,
>>  	/* TODO: Extend invalidation support to more special instructions. */
>>  }
>>  
>> +static int arm64__reg_size(const char *reg)
>> +{
>> +	if (!reg || !*reg || !arm64__is_reg(reg))
>> +		return -1;
>> +
>> +	if (reg[0] == 'w')
>> +		return 4;
>> +
>> +	if (reg[0] == 'x' || !strncmp(reg, "sp", 2))
>> +		return 8;
>> +
>> +	return -1;
>> +}
> 
> [ ... ]
> 
>> +static int propagate_load_reg_state(struct type_state *state,
>> +				    struct data_loc_info *dloc,
>> +				    struct disasm_line *dl, int dreg,
>> +				    struct annotated_op_loc *src,
>> +				    struct type_state_reg **src_states,
>> +				    int mem_spacing)
>> +{
>> +	struct type_state_reg *tsr;
>> +	struct type_state_reg *src_tsr = src_states[0];
>> +	Dwarf_Die type_die;
>> +	u32 insn_offset = dl->al.offset;
>> +	int sreg = src->reg1;
>> +	int reg_offset;
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		return -1;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
>> +	tsr->lifetime_active = false;
>> +	tsr->lifetime_end = 0;
>> +
>> +retry:
>> +	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
>> +		goto load_non_regoff;
>> +
>> +	reg_offset += mem_spacing;
>> +
>> +	if (!src_tsr || !src_tsr->ok)
>> +		return -1;
>> +
>> +	/* Dereference the pointer if it has one */
>> +	if (src_tsr->kind == TSR_KIND_TYPE &&
>> +	    die_deref_ptr_type(&src_tsr->type,
>> +			       src_tsr->offset + reg_offset, &type_die)) {
>> +		tsr->type = type_die;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = 0;
>> +		tsr->ok = true;
>> +
>> +		pr_debug_dtp("%s [%x] %#x(reg%d) -> reg%d",
>> +			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +		return 0;
>> +	}
>> +
>> +	/* Handle dereference of TSR_KIND_POINTER registers */
>> +	if (src_tsr->kind == TSR_KIND_POINTER &&
>> +	    die_get_member_type(&src_tsr->type,
>> +				src_tsr->offset + reg_offset, &type_die)) {
>> +		tsr->type = src_tsr->type;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = src_tsr->offset + reg_offset;
> 
> [Severity: Medium]
> Should tsr->type be assigned type_die and tsr->offset set to 0 here?
> 
> When DWARF describes a struct variable via a register-based memory
> location (where var->is_reg_var_addr is true), update_var_state() sets
> the base register to TSR_KIND_POINTER with reg->type set to the struct
> DIE.
> 
> When a load instruction reads a member from that struct into dreg,
> update_insn_state_arm64() -> update_load_insn_state() ->
> propagate_load_reg_state() calls die_get_member_type() to resolve the
> loaded member's type into type_die.
> 
> However, type_die is left unused, and tsr->type is set to src_tsr->type
> (the outer struct DIE) with tsr->offset set to src_tsr->offset +
> reg_offset and tsr->kind set to TSR_KIND_TYPE. When a subsequent
> instruction dereferences dreg, check_matching_type() or
> die_deref_ptr_type() inspects dreg->type, sees the outer struct type
> instead of the member's pointer type, and fails with PERF_TMR_NO_POINTER.
> 

A similar issue was already clarified in v6 [1], and this part of the code
has been confirmed during actual debugging to resolve the data type
correctly, so I will keep it consistent with x86 and not modify it.

[1] https://lore.kernel.org/all/228cf99e-2b8a-42a8-aab6-45cc4823d3b7@huaweicloud.com/#t

>> +		tsr->imm_value = 0;
>> +		tsr->ok = true;
>> +
>> +		pr_debug_dtp("%s [%x] addr %#x(reg%d) -> reg%d",
>> +			     dl->ins.name, insn_offset, reg_offset, sreg, dreg);
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +		return 0;
>> +	}
>> +
>> +load_non_regoff:
>> +	/* Try another register if any */
>> +	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
>> +	    !(src->extend_type || src->shift_type)) {
>> +		sreg = src->reg2;
>> +		src_tsr = src_states[1];
>> +		goto retry;
>> +	}
>> +
>> +	return -1;
>> +}
>> +
>> +static void update_load_insn_state(struct type_state *state,
>> +				   struct data_loc_info *dloc,
>> +				   struct disasm_line *dl,
>> +				   struct annotated_op_loc *src,
>> +				   struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg snapshots[2];
>> +	struct type_state_reg *src_states[2] = {};
>> +	int mem_spacing = 0;
>> +
>> +	if (!src->mem_ref ||  /* exclude PC-relative loads */
>> +	    !has_reg_type(state, src->reg1)) {
>> +		/* Invalidate tracked destination registers */
>> +		if (has_reg_type(state, dst->reg1))
>> +			invalidate_reg_state(&state->regs[dst->reg1]);
>> +		if (dst->multi_regs && has_reg_type(state, dst->reg2))
>> +			invalidate_reg_state(&state->regs[dst->reg2]);
>> +		goto out_adjust;
>> +	}
>> +
>> +	/*
>> +	 * Snapshot source register states before updating destination registers.
>> +	 * This preserves the original source state for aliased loads (e.g.,
>> +	 * ldp x0, x1, [x0]), where updating the first destination may overwrite
>> +	 * the source register.
>> +	 */
>> +	snapshots[0] = state->regs[src->reg1];
>> +	src_states[0] = &snapshots[0];
>> +	if (src->multi_regs && has_reg_type(state, src->reg2)) {
>> +		snapshots[1] = state->regs[src->reg2];
>> +		src_states[1] = &snapshots[1];
>> +	}
>> +
>> +	/* Handle the first destination register */
>> +	if (has_reg_type(state, dst->reg1)) {
>> +		if (propagate_load_reg_state(state, dloc, dl, dst->reg1,
>> +					     src, src_states, mem_spacing))
>> +			invalidate_reg_state(&state->regs[dst->reg1]);
>> +	}
>> +
>> +	if (!dst->multi_regs || !has_reg_type(state, dst->reg2))
>> +		goto out_adjust;
> 
> [Severity: Medium]
> What happens here when an ldp instruction uses the zero register (xzr or
> wzr) as its first destination operand, such as "ldp xzr, x19, [sp], #16"
> or "ldp xzr, x1, [x0]"?
> 
> In update_load_insn_state(), dst->reg1 is guarded by has_reg_type(state,
> dst->reg1) without returning early, and arm64__reg_size() recognizes
> xzr/wzr via arm64__is_reg() so dst->reg2 can still be updated or
> invalidated.
> 
> However, when update_insn_state_arm64() calls
> annotate_get_insn_location() -> extract_op_location_arm64(),
> arch__dwarf_regnum() returns -1 for xzr and wzr, and
> extract_op_location_arm64() returns before parsing reg2:
> 
> tools/perf/util/annotate-arch/annotate-arm64.c:extract_op_location_arm64() {
> 	...
> 	/* Extract the primary register */
> 	op_loc->reg1 = arch__dwarf_regnum(arch, s);
> 	if (op_loc->reg1 == -1)
> 		return;
> 
> 	s = next_operand_field(s);
> 	if (s == NULL)
> 		return;
> 
> 	/* Extract secondary register or immediate offset */
> 	if (op_loc->multi_regs) {
> 		op_loc->reg2 = arch__dwarf_regnum(arch, s);
> 	...
> }
> 
> Doesn't this leave dst->reg2 as -1, causing update_load_insn_state() (and
> invalidate_unhandled_insn_regs()) to skip the second register instead of
> propagating its type or invalidating its previous state?
> 

So the root cause is that arch__dwarf_regnum does not currently support xzr/wzr;
it is not a problem with this patch.

I will take a targeted look at how to handle xzr/wzr in the future.

Thanks,
Tengda

>> +
>> +	/* Handle the second destination register */
>> +	if (!strcmp(dl->ins.name, "ldpsw"))
>> +		mem_spacing = 4;  /* ldpsw loads two 32-bit signed words (4-byte spacing) */
>> +	else
>> +		mem_spacing = arm64__reg_size(dl->ops.target.raw);
>> +
>> +	if (mem_spacing < 0 ||
>> +	    propagate_load_reg_state(state, dloc, dl, dst->reg2,
>> +				     src, src_states, mem_spacing))
>> +		invalidate_reg_state(&state->regs[dst->reg2]);
>> +
>> +out_adjust:
>> +	adjust_reg_index_state(state, dloc, dl, src);
>> +}
> 
> [ ... ]
> 
>>
> 

