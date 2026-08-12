Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDE8350D7D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 01:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499106; cv=none; b=hw2aiq4UiBT/4DBbyJ4UGCpJOZtFEdMsO2gplKsDpbK5Ps80UDfRU5M7Py8/Jt1lclabblyG+8bPLmkDDQvkOXobY8yjBWZWQEyOLgxrQEQSaN03vQDAXmaJ8FQvCAL8r65i8lxM3hw3P+GbO8Vyldrx6FlqTdBAq3YdE1NLLHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499106; c=relaxed/simple;
	bh=UrMq7Y66WkGrtLYAG5K4sJB9H6S3tcijVZXetAdOE4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oATM2w2/GkZ6Hw3JIDD8ApX1YFynyUvPtUpze8YF6AoFZ4YY5142yteD3E+HPasa2Gf618a5NvubW0l0gwV7ycIwY8l7/nexrTb2T3lHMFw5NjcuwW0TRSQMTlsdxFw4rNCfXMTbMKIa8ExkUSxkr2N2ev+QBCAo2mvO45Jf/I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hKWWd2mPMzYQtlr
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 09:44:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 905284058D
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 09:44:49 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnUooQ0HtqKzYECA--.31294S2;
	Wed, 12 Aug 2026 09:44:49 +0800 (CST)
Message-ID: <96bfc0eb-6a4d-4d39-9501-ebb30f7ee88c@huaweicloud.com>
Date: Wed, 12 Aug 2026 09:44:48 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/23] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-8-wutengda@huaweicloud.com>
 <20260808131116.3BE021F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808131116.3BE021F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnUooQ0HtqKzYECA--.31294S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykKF18ur1fCw15Kr47CFg_yoWrCF43pa
	1q934UJ3WUJr4UKwnxJayruFyS9w1xGF4rurn8K392yFnxurn5XFZ2gF4a9ayrArZxAw4j
	vw4qqryDZw1vkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
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



On 2026/8/8 21:11, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Propagating errors from extract_reg_offset aborts instruction state processing, breaking register invalidation, and uses a flawed condition.
> --
> 
> --- Patch [7]: [PATCH v4 07/23] perf annotate: Introduce extract_op_location callback for arch-specific parsing ---
> commit ea4cc06c47d3d877b7277db8368241769c5b60d3
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate: Introduce extract_op_location callback for arch-specific parsing
> 
> Assembly syntax for operands varies significantly across different
> architectures, which prevents the operand location (op_loc) parsing
> logic in annotate_get_insn_location() from being directly reused.
> 
> To simplify the core logic and improve maintainability, move the
> operand parsing inside the for_each_insn_op_loc loop into arch-specific
> extract_op_location callbacks.
> 
>> This refactoring is primarily a cleanup,
>> but includes a minor x86-specific change: errors from extract_reg_offset()
>> are now propagated, so unrecognized operands are correctly rejected
>> instead of being silently ignored, , and testing confirms no functional
>> regression from this change.
> 
> [Severity: Medium]
> Are we certain this change does not introduce functional regressions?
> 
> Propagating errors out of extract_reg_offset() appears to break type state
> tracking for absolute memory references.
> 

This has been validated through local testing, and all statistical metrics
remain unchanged.
I noticed there are two commas in the commit message and will correct that.


>> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
>> index 7e61365363938..6044a68966f14 100644
>> --- a/tools/perf/util/annotate-arch/annotate-x86.c
>> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
> [ ... ]
>> @@ -809,6 +811,85 @@ static void update_insn_state_x86(struct type_state *state,
> [ ... ]
>> +static int extract_reg_offset(const struct arch *arch, const char *str,
>> +			      struct annotated_op_loc *op_loc)
>> +{
> [ ... ]
>> +	op_loc->reg1 = arch__dwarf_regnum(arch, p);
>> +	if (op_loc->reg1 == -1)
>> +		return -1;
> 
> [Severity: Medium]
> Will this error check correctly identify unrecognized registers?
> 
> If an instruction contains an unrecognized register like '%zmm0',
> arch__dwarf_regnum() returns -2 (-ENOENT). The check for -1 will miss
> unrecognized registers, but it will trigger for absolute memory references
> like 'mov (0x1234), %rax' which lack a '%' character entirely.
> 

Shuai raised this point as well. The fix will be to normalize
arch__dwarf_regnum() to return -1.

>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 9d8b4d6b859b8..20be609ebed24 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
> [ ... ]
>> @@ -2572,6 +2527,7 @@ int annotate_get_insn_location(const struct arch *arch, struct disasm_line *dl,
> [ ... ]
>> +		if (arch->extract_op_location) {
>> +			ret = arch->extract_op_location(arch, dl, insn_str, i, op_loc);
>> +			if (ret)
>> +				return ret;
>>  		}
>>  	}
> 
> [Severity: Medium]
> Does propagating this failure cause issues in update_insn_state_x86()?
> 
> When absolute memory references return -1 and trigger this early return,
> annotate_get_insn_location() will fail.
> 
> If update_insn_state_x86() bails out early because of this failure:
> 
> tools/perf/util/annotate-arch/annotate-x86.c:update_insn_state_x86() {
>     ...
> 	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
> 		return;
>     ...
> }
> 
> Won't this bypass the fallback logic that invalidates the destination register?
> This could cause the analyzer to incorrectly assume the destination register
> retains its previous type state, when it actually contains unknown data.
> 

Indeed, the return value should not be handled directly; instead, the op_loc
information should be resolved as completely as possible.
This was also the approach before the change, and I will keep it consistent
by removing the ret value check.

