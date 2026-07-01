Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8F73EFD14
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895658; cv=none; b=WMqYR9fTPS0SJQRg9Ltx9k1ljEwFUwMZ5DV0wZzpHOEUj6Kcu3AfSJFbmgtBf357/hFDG7l+W5X5cc+37KqffRQfx0q10yAAnmaLgks6ogTR1WdseJUsd8K0kW3OWFtxWkRIeT1uAaycM20lDlMFU2f83rqL4/sm9/ZXQP6ummY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895658; c=relaxed/simple;
	bh=OEGq8VWOTXEeIoo8x9SdtNhKfEs9mdbzK6Xw1R9Lh6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NPJnqfmmin5V2gbHNn6QfDV2cZNs+IXvEW62G9I5M5uxPIStEytDdVu5ldrHFGMOzWBM32HPZPpW/DoYpaUVdickMd4wo7X5NLEkLuNyNNmjOdfEd4X5Uo0Er7tRbj/UklCdxZwLpYv/ksv3NC0r80Y8fxIoyqv+41dDhEE4jPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqtsp3962zYQtgR
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:46:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A44E64058C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:47:32 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3iPwk1ERqHBnbAQ--.21225S2;
	Wed, 01 Jul 2026 16:47:32 +0800 (CST)
Message-ID: <da1cb02a-7a26-4866-af87-5a53b559dc2e@huaweicloud.com>
Date: Wed, 1 Jul 2026 16:47:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/21] perf annotate-arm64: Support 'add' instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-19-wutengda@huaweicloud.com>
 <20260701041654.AD6F41F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041654.AD6F41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3iPwk1ERqHBnbAQ--.21225S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUXr4kJF1xCw47Cw1UAwb_yoW5Xw4xpa
	43C34UGa17tr409Fn3tF48Zry7Cr4fJr909r98X39IyFsIvrn3Ka93KFW3KayrGr97Cw4j
	qw1qqrWDZw48CaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/7/1 12:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Missing register invalidation when source registers are known non-pointer types, causing the destination register to incorrectly retain stale type information.
> --
> 
> commit 5b1d520539dfc4b7d2f19958225cafb067fd8ce1
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'add' instruction tracking
> 
> Extend update_insn_state() for arm64 to track 'add' instructions for
> structure member address calculation, which commonly appear as:
> 
>   add  dreg, base, #offset
>   add  dreg, base, reg2     (reg2 holds a constant)
> 
> For such instructions, determine the final offset value from either the
> immediate or the constant in reg2.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index be07a85057c8c..1fed188117192 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> +static void update_add_insn_state(struct type_state *state,
>> +				  struct disasm_line *dl,
>> +				  struct annotated_op_loc *src,
>> +				  struct annotated_op_loc *dst)
>> +{
> [ ... ]
>> +	/* Handle calculation of a register holding a typed pointer */
>> +	if (src_tsr.kind == TSR_KIND_POINTER ||
>> +	    (src_tsr.kind == TSR_KIND_TYPE &&
>> +	     dwarf_tag(&src_tsr.type) == DW_TAG_pointer_type)) {
> [ ... ]
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +	}
>> +	/* Or try another register if any */
>> +	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>> +		sreg = src->reg2;
>> +		goto retry;
>> +	}
>> +}
> 
> [Severity: Medium]
> When the source registers are not tracked pointers or valid types, the code
> falls through the if/else if chain and returns implicitly here without calling
> invalidate_reg_state(tsr).
> 
> Since update_insn_state_arm64() specifically exempts "add" instructions from
> generic register invalidation (as seen below), won't dreg incorrectly retain
> its previous stale type information?
> 

Already covered in the earlier discussion. Will fix all in one go.

> [ ... ]
>> @@ -589,7 +673,7 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	 * the destination register itself to prevent incorrect type propagation.
>>  	 */
>>  	if (has_reg_type(state, dst->reg1) &&
>> -	    strcmp(dl->ins.name, "mov") &&
>> +	    strcmp(dl->ins.name, "add") && strcmp(dl->ins.name, "mov") &&
>>  	    strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
>>  		pr_debug_dtp("%s [%x] invalidate reg%d\n",
>>  			     dl->ins.name, insn_offset, dst->reg1);
> 


