Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2915D4A2A66
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967767; cv=none; b=EO3AU69m9aUlnEMNdDzDfq9m+UOayqd92j1v8jbTG0Evn+rHdwcw+4kAvoF14pzPkuQiL8a7kq7DKbvp/Q+gVlnLFH6GrF2X3GhiPvy9eCpuHRsh3d5KZ2vD2RchjnrUim6dpJzlIqrqtLDeNWy1SwP6SPgopLxvM6HcPVHO2d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967767; c=relaxed/simple;
	bh=A4mcGxbrzJGXHeLHAZl4dgAFdrM+43qU/xnAwLz7b4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L1KiDg9+fPW8Ec2DD6kR7NtbQfBhjKHVxvN8zwx2UODrckrrhPt5mf/rAf4NTwaY5frUx8QBOHS6ayH46XWqc/lYS0myFooS9uHMS4pKlufG4nhRmJbUaS+dLHy2GKZcMd3CwQlKJjdTcO8bhoaq+Xgcch9zOqUgbr5ny93TKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j4PxP3Y72zYQtrg
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:48:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2F62E40574
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:49:18 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBXYdYNQs9q93KQAQ--.42776S2;
	Wed, 14 Oct 2026 16:49:18 +0800 (CST)
Message-ID: <dac9ce90-4044-47ce-bd1f-5cbef00ea162@huaweicloud.com>
Date: Wed, 14 Oct 2026 16:49:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/15] perf annotate-arm64: Support 'adrp' instruction
 to track global variables
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <b4fd436fc48e085ae95e06f0cc41107b99a62df7.1791629326.git.wutengda@huaweicloud.com>
 <sashiko-outbox-169874@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-169874@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXYdYNQs9q93KQAQ--.42776S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUCr1fur4kCr4rJFyfCrg_yoW5Wr18pF
	WkG3yrKFWjqr4qqrsIvrZ7Z3sagw1SqF17Crn8tanayF12kwnak3Z7tFW3uF47Xr95Cr1U
	Zw4vvF4DZr40kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUrNtxDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/13 21:57, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf: Stale DWARF lifetime metadata preserved in update_adrp_insn_state
> --
> 
> commit e2010b4bef31520f5bbfd7a86530f7efd90eacaa
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'adrp' instruction to track global variables
> 
> Extend update_insn_state_arm64() to track global variable types calculated
> via page-relative addressing by introducing TSR_KIND_GLOBAL_ADDR.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index e27ba26f3b8ab..f34b944dd285d 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -945,6 +974,39 @@ static void update_add_insn_state(struct type_state *state,
>>  	invalidate_reg_state(tsr);
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
>> +	/*
>> +	 * Stores a partial page-relative address. The full absolute address
>> +	 * of the global variable will be resolved when a subsequent 'add' or
>> +	 * 'ldr' instruction consumes this register.
>> +	 */
>> +	tsr->imm_value = dl->ops.source.addr;
>> +	tsr->offset = 0;
>> +	tsr->ok = true;
> 
> [Severity: Medium]
> When assigning the new state to the target register, does this code leak
> stale DWARF lifetime metadata?
> 
> If the register was previously tracking a local variable with an active DWARF
> lifetime, the new global address state inherits this stale metadata because
> lifetime_active and lifetime_end are not cleared.
> 
> When a subsequent function call instruction is encountered, caller-saved
> registers are incorrectly preserved if the stale metadata evaluates to true for
> reg->lifetime_active and call_addr < reg->lifetime_end. This can poison type
> propagation if the register is accidentally reused in subsequent instructions.
> 
> Should invalidate_reg_state() be called before assigning the new state, or
> should the lifetime fields be manually cleared?
> 

OK, I missed that.

Tengda

>> +
>> +	pr_debug_dtp("adrp [%x] global addr=%#"PRIx64" -> reg%d\n",
>> +		     insn_offset, tsr->imm_value, dreg);
>> +}
>> +
> 

