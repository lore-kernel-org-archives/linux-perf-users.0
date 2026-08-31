Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569F30DD2F
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181638; cv=none; b=MtRaqIEISNvgtQ5cvs4cnONnszc2FffQ+88bEJ4Yqtv7qPDN8OT31xLw1g4UwFtsQ/vc5IvGkxY7EBDPhEzKJ9TEFV+3M+Vxwhgg0eF+Zen9sIbQHGMjmDcCyhjqVbKPPLctlzyWA5xSRNMRWgW7fpZxIGWhgXHinALa6B7kOBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181638; c=relaxed/simple;
	bh=ZPn8Y1cGxYriJLJHPvq8nupoqNdcrIK5QvTnEGmkvzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1egqp+Q/8pPVqCwjfVRFeaK6M4/F+wxyWYEbTcay0nomVRy+7/jk18sFn2GgOGbApCRl5lbwq3sw42ttkPlu71/1KiN2JJIdyvRJxMVO/lCncOAxx3YyW8wrdt/5LU3lV/TEtVKBwOyUEc7vIvjQATizhn8ZO7rDxGS9Rt1mMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hYTlZ2p2GzYQtqX
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:06:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2339F40539
	for <linux-perf-users@vger.kernel.org>; Mon, 31 Aug 2026 21:07:12 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgDXvwp+fJVqfc75AA--.63438S2;
	Mon, 31 Aug 2026 21:07:12 +0800 (CST)
Message-ID: <4acae7de-fdd7-4534-bb73-43502dc760a0@huaweicloud.com>
Date: Mon, 31 Aug 2026 21:07:10 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/23] perf annotate-arm64: Support per-cpu variable
 access tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-23-wutengda@huaweicloud.com>
 <20260808131848.43DEF1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808131848.43DEF1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXvwp+fJVqfc75AA--.63438S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDJw1UGw48GFyrAr4fZrb_yoW5WFy8pa
	95CayrGr1rXr4FganrZw4rXFyS9ws7WrWF9Fyqkr4avr9avr97KF97tay5KFW7Gr95Aa12
	qws8tr47Zw1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Incomplete offset calculation for multi-register memory operands causes inaccurate type resolution.
> --
> 
> --- Patch [22]: [PATCH v4 22/23] perf annotate-arm64: Support per-cpu variable access tracking ---
> commit d7e10ade80ba3983e6d311e1ab11f19b4af2d53e
> Author: Tengda Wu <wutengda@huaweicloud.com>
> Subject: perf annotate-arm64: Support per-cpu variable access tracking
> 
> This commit extends update_insn_state() for arm64 to handle per-cpu variable
> addressing. It identifies per-cpu base initialization and propagates type
> information to subsequent instructions. This allows the tracker to correctly
> resolve the actual variable type in per-cpu flows.
> 
>> diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
>> index 7fe5b979563f7..8b0584486cce9 100644
>> --- a/tools/perf/util/annotate-data.c
>> +++ b/tools/perf/util/annotate-data.c
>> @@ -1253,11 +1253,33 @@ static enum type_match_result check_matching_type(struct type_state *state,
>>  	}
>>  
>>  	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
>> -		u64 var_addr = dloc->op->offset;
>> +		u64 var_addr;
>>  		int var_offset;
> 
> [ ... ]
> 
>> +		var_addr = dloc->op->offset;
>> +
>>  		if (dloc->op->multi_regs) {
>>  			int reg2 = dloc->op->reg2;
> 
> [Severity: Medium]
> Does the TSR_KIND_GLOBAL_ADDR handling later in check_matching_type() need
> similar logic for multi-register operands to ensure accurate type resolution?
> 
> Currently, for TSR_KIND_GLOBAL_ADDR, the logic does not consider multi-register
> operands:
> 
> 	if (state->regs[reg].kind == TSR_KIND_GLOBAL_ADDR) {
> 		u64 var_addr = state->regs[reg].imm_value + dloc->op->offset;
> 		int var_offset;
> 
> This calculation omits adding state->regs[reg2].imm_value for multi-register
> operands, unlike the TSR_KIND_PERCPU_BASE logic in the same function. The
> omission also appears to apply to TSR_KIND_TYPE and TSR_KIND_POINTER.
> 
> Can this incomplete offset calculation cause incorrect type resolution in
> tools/perf/util/annotate-data.c:check_matching_type() when perf processes a
> memory instruction where op->multi_regs is true, the primary register is
> TSR_KIND_GLOBAL_ADDR (or TYPE/POINTER), and the secondary register is
> TSR_KIND_CONST?
> 

Perhaps we need a helper function at the beginning of check_matching_type() to
calculate the accurate offset value. I can see several cases:

1. single register addressing
   [reg, #offset]

2. post-index addressing
   [reg], #offset

3. SIB-like addressing
   [base, index, lsl #3]

4. multi-reg addressing with constant register.
   [base, reg2]  // reg2 is a const

Thanks,
Tengda

