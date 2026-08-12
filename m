Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7721D591
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786504190; cv=none; b=SHqSp9U1G+3zAtik/91CFSiScK75X9Vg0rNfTWeXk4rEGIiwAqeDN74fxClP5WjLpOlNZuIBzZi+r3B6pPZWh53FhDW1RiVqNiBmIQwx6DlowXrzhmGE+vD/ry67iQUKVo2ycyoCVM3smWzGlxP7WwUjdylSX3KV6xEGlp+PCF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786504190; c=relaxed/simple;
	bh=zLDK2FHVqgr8gJie0YetemI151sHcSgQYaHcbKkVr9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fa5ms/cCKdxBSKjRCoYP9uroMoldxtqf6qS7TllWzPy9bBoH7h76NwQ1uukns/8W6hiyY8pHgHC3NenI7G1ZINUnMFL/7YEs78sSsAYKWRMcOxFNteCmOCKJ4yq4djNvpEewbsU8g38JoRuHZfbkwwn8jKsI7cqVMvmYuxLhRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hKYPZ6HYLzYQtr7
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 11:09:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 320B540539
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 11:09:43 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgDn1UT243tqvlwACA--.17596S2;
	Wed, 12 Aug 2026 11:09:43 +0800 (CST)
Message-ID: <7822cf02-a1b2-488f-86ab-e3e3cc24acd9@huaweicloud.com>
Date: Wed, 12 Aug 2026 11:09:41 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/23] perf annotate-arm64: Enable instruction tracking
 support
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-13-wutengda@huaweicloud.com>
 <20260808132233.5A8D01F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808132233.5A8D01F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgDn1UT243tqvlwACA--.17596S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF47Zw4fWrWfur4UZw47Arb_yoW5XF1Dpa
	9Ikw45GFWUtr4DKrnrXr48X3y3uw1fX3WrCry5t3WIyr9Iyrn7tF93tFW2kFWrGr9xCw4j
	vw4jqFZrX34DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:22, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Missing bounds check on the secondary destination register (`dst->reg2`) leads to an out-of-bounds stack write in `update_insn_state_arm64()`.
> - [Medium] Incorrect invalidation of base pointer type information during memory store instructions in `update_insn_state_arm64()`.
> --
> 
> --- Patch [12]: [PATCH v4 12/23] perf annotate-arm64: Enable instruction tracking support ---
> commit f55f5ca2b14376eae146cdb6373ed5a53a114257
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Enable instruction tracking support
> 
> Enable basic instruction tracking for arm64 by implementing three
> essential functions in the find_data_type_block() call path.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 6b4f1228afa9b..44daa0176e512 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -353,6 +357,65 @@ static int extract_op_location_arm64(const struct arch *arch,
> 
> [ ... ]
> 
>> +	/*
>> +	 * Invalidate destination register(s) for unsupported instructions to
>> +	 * prevent stale type info from propagating to subsequent instructions.
>> +	 */
>> +	if (has_reg_type(state, dst->reg1)) {
>> +		pr_debug_dtp("%s [%x] invalidate reg%d",
>> +			     dl->ins.name, insn_offset, dst->reg1);
>> +		invalidate_reg_state(&state->regs[dst->reg1]);
> 
> [Severity: Medium]
> Does this incorrectly invalidate the base pointer type information during memory
> store instructions?
> 
> If dst->mem_ref is true (e.g., for a store instruction like str x1, [x0]),
> this fallback lacks a !dst->mem_ref check. Will it incorrectly invalidate the
> extracted base register (x0), assuming it is being overwritten?
> 

Agreed.

>> +		if (dst->multi_regs) {
>> +			pr_debug_dtp(" and reg%d", dst->reg2);
>> +			invalidate_reg_state(&state->regs[dst->reg2]);
> 
> [Severity: High]
> Can this cause an out-of-bounds write on the stack-allocated type_state
> structure?
> 
> If an instruction parses with multiple registers where the second is invalid
> (e.g., ldp x0, x99, [sp]), extract_op_location_arm64() sets op_loc->reg2
> to a negative error code since it cannot find the register name.
> 
> Because there is no check for dst->reg2 >= 0 here, does this result in a
> negative index being used for the regs array?
> 

Agreed, I need to add a has_reg_type(state, dst->reg2) check.

>> +		}
>> +		pr_debug_dtp("\n");
>> +		return;
>> +	}
>> +}
> 

