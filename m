Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C0749DBBA
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 11:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789558279; cv=none; b=tDVq0wC5v9m7rRu1CRYEWd49vXAtx1ezEVCxqJbd+ue/WQrD662I+Xvs4+t55Drrl7XaM2PCIqTX3LSOPkKjnT4VBfeWLopeJ/SOMgNrEk2yJzvVT4GTmy0Bq/MhLbLpd21bpTfFz2cD8hajmKhP39s08xlXteMuFEwsFgHlkIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789558279; c=relaxed/simple;
	bh=Wkx+M797dMS2uXHcLVB0w5jDzayTkLJxrXhEIkHK28s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RKDp8OD9QcnOltPUxLp1L61jEbafPMIE6OebQuOZaqqCXl1+hp/+kpvz3RTbmOGumc+aQ/ni60ZGJdJ17pu1zpisp7C3/g4mgFXVIKrNDct8kPupyykueZ5dbvYrHMHFlbvWBWOLjrSxS6SyO6fFVXbWOHV1dpefRG7BXEXJvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hlGsg5LSTzKHMmw
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 19:30:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 12E9B40561
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 19:31:02 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXpyr0fapqC8sQAg--.61767S2;
	Wed, 16 Sep 2026 19:31:02 +0800 (CST)
Message-ID: <228cf99e-2b8a-42a8-aab6-45cc4823d3b7@huaweicloud.com>
Date: Wed, 16 Sep 2026 19:31:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/26] perf annotate-arm64: Support load instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <f95afe942520e925f209a2cd20c5f55d28c272b9.1789521520.git.wutengda@huaweicloud.com>
 <20260916015146.B53C01F000FF@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260916015146.B53C01F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXpyr0fapqC8sQAg--.61767S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryktw43ZrW7Wr48Aw4rGrg_yoWrAw1xpF
	Z8G345Jw12qr4ftrsIvr4kuFyF9wn3WF1DCryqgFWSvFyjyrn3GFZ3KFWj9ay8GrWxCw17
	Zw1jyFZxXw4DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/9/16 9:51, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] perf annotate: stale lifetime metadata retained on load
> - [Medium] perf annotate: incorrect type propagation for TSR_KIND_POINTER loads
> --
> 
> commit 9763211f6135d1b6c3e44acf4ac681c34ac60395
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support load instruction tracking
>     
> Extend update_insn_state_arm64() to handle load instructions, tracking
> register state changes when data is loaded from memory to registers.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index d3d994a22cf92..11b2bdceaacb1 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -461,11 +461,210 @@ static bool is_readonly_branch_or_cmp(const char *name)
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
>> +
>> +retry:
>> +	if (arch_get_reg_offset(dloc->arch, src, sreg, state, false, &reg_offset))
> 
> [Severity: Medium]
> When acquiring the destination register state here, shouldn't the lifetime
> metadata be cleared (e.g., via tsr->lifetime_active = false;)?
> 
> If the register previously held a variable with an active DWARF lifetime, the
> newly loaded value inherits this stale lifetime. During function calls,
> caller-saved registers with active lifetimes are preserved rather than
> invalidated. This causes the register's new type to incorrectly survive the
> call, leading to stale type tracking downstream.
> 

Normally DWARF handles this lifetime quite well (DW_AT_ranges will mark the
lifetime end at the ldr instruction), but clearing it is fine too, and it will
also get sashiko to stop complaining.

>> +		goto load_non_regoff;
>> +
>> +	reg_offset += mem_spacing;
> 
> [ ... ]
> 
>> +	/* Handle dereference of TSR_KIND_POINTER registers */
>> +	if (src_tsr->kind == TSR_KIND_POINTER &&
>> +	    die_get_member_type(&src_tsr->type,
>> +				src_tsr->offset + reg_offset, &type_die)) {
>> +		tsr->type = src_tsr->type;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = src_tsr->offset + reg_offset;
>> +		tsr->imm_value = 0;
>> +		tsr->ok = true;
> 
> [Severity: Medium]
> Does this incorrectly assign the parent struct's type (src_tsr->type) instead
> of the member's type (type_die), corrupting type tracking for the loaded
> value?
> 
> If the destination register is subsequently used as a base address,
> check_matching_type() will fail because it expects a TSR_KIND_TYPE register
> to hold a pointer type, whereas it now holds a struct type. This breaks
> downstream type inference for the loaded value.
> 

This code is consistent with x86, and it doesn't look like a problem.

The purpose of die_get_member_type is only to determine whether the load offset
is valid, not to resolve the type.

TSR_KIND_POINTER is obtained from die_collect_vars() -> update_var_state(). Whether
it is marked as TSR_KIND_POINTER mainly depends on var->is_reg_var_addr, and
var->is_reg_var_addr is determined based on DW_OP_breg* or DW_OP_fbreg operations.
These operations already describe where the DIE type of the current variable comes
from (for example, DW_OP_breg26 W26+2920 describes that it is obtained by loading
from x26 + 2920 offset, and stores the DIE into the x26 register). So when the actual
load happens (for example, ldrsw x3, [x26, #2920]), it only needs to inherit the
type from breg.

So I will keep the TSR_KIND_POINTER handling unchanged.

Thanks,
Tengda

