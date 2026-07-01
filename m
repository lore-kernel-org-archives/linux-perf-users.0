Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5602E3F8236
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895746; cv=none; b=NyfPjDm3YFvdmUtjuwQFp8z+KIkDzTew7r0pGAq1RxiWB0/VfxvthLO5nVt4uFdWd65OWQ5AjFfvyci/DXNGIYpepRRoz5mXmryT5jercXYS5omgo/xRvNp/smEccnPM4tmarvO4tpw0vnAmDemawvJHSzRjU+sZgBd7SEn5x5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895746; c=relaxed/simple;
	bh=9xrOQPuzVe/1usloYaiGTzp0w+9/6wDHdg3F1miHeWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+sxjyranwCVzuxHsFBnMwDAAqfnGBQQw2rOzy17UhDuVSUI04KxFsCr3NBWZkiFGCEvsWog3ZNd8ZgxywEfS5qTzefVo7yIh1bZ7pKlrX2YPAB749w2zM+3Ca+K/VDCqhRwpf251lzGTlBijCx8oto5Nr/kbcJalmXzUYFWCnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqtwL6fpdzKHLw2
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:48:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 53DBD4057E
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:49:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAXh_R71ERqfvfZAQ--.26018S2;
	Wed, 01 Jul 2026 16:49:00 +0800 (CST)
Message-ID: <87063437-8200-4672-aed7-9ac50344bb9c@huaweicloud.com>
Date: Wed, 1 Jul 2026 16:48:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/21] perf annotate-arm64: Support 'adrp' instruction
 to track global variables
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-20-wutengda@huaweicloud.com>
 <20260701041517.585EF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041517.585EF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXh_R71ERqfvfZAQ--.26018S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDXF1xZF1kZFW7tr4rAFb_yoW5Wrykpr
	yDAay5Gr4UJr4vgFsIqr4rXa4Sgw4fX3WUCr90qFs7KF9FkrnakF92krW3uFWrJr93Cw1U
	Zw4qvrZ8Zw40ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2
	KfnxnUUI43ZEXa7IU8oGQDUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Stale `type` field in register state causes `TSR_KIND_GLOBAL_ADDR` to be corrupted across stack spills.
> --
> 
> commit ddfb698eef878cf476210d72e082d8b79c811ecd
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'adrp' instruction to track global variables
> 
> This patch extends update_insn_state() for arm64 to track global variable
> types calculated via page-relative addressing. It introduces
> TSR_KIND_GLOBAL_ADDR to represent the partial page-aligned target address
> produced by adrp instructions. The address is later combined with the offset
> from a subsequent add or ldr instruction to resolve the variable's type.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 1fed188117192..6f96e75d313dd 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -656,8 +700,37 @@ static void update_add_insn_state(struct type_state *state,
>>  	}
>>  }
>>  
>> +static void update_adrp_insn_state(struct type_state *state,
>> +				   struct disasm_line *dl,
>> +				   struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg *tsr;
>> +	u32 insn_offset = dl->al.offset;
>> +	int dreg = dst->reg1;
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		return;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
>> +
>> +	if (!dl->ops.source.addr) {
>> +		invalidate_reg_state(tsr);
>> +		return;
>> +	}
>> +
>> +	tsr->kind = TSR_KIND_GLOBAL_ADDR;
>> +	/* Partial page-relative address, finalized in next 'add/ldr' */
>> +	tsr->addr = dl->ops.source.addr;
>> +	tsr->offset = 0;
>> +	tsr->ok = true;
> 
> [Severity: Medium]
> Does this leave tsr->type containing a stale Dwarf_Die?
> 
> If the register previously held a structure or union type, the type field
> isn't cleared here when switching to TSR_KIND_GLOBAL_ADDR.
> 
> If this register is later spilled to the stack, set_stack_state() will
> evaluate the stale type_die. Since the type_die tag is DW_TAG_structure_type,
> it will erroneously set stack->compound = true.
> 
> When the register is loaded back via ldr, update_load_insn_state() will then
> branch into the compound type handling (die_get_member_type()) instead of
> restoring the TSR_KIND_GLOBAL_ADDR state. 
> 
> Could this destroy the tracking state and cause perf annotate to fail resolving
> the global variable's type?
> 

Agreed. Need to clear the type explicitly.

>> +
>> +	pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d\n",
>> +		     insn_offset, tsr->addr, dreg);
>> +}
> 

