Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD3F3B8BC6
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 07:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782891004; cv=none; b=Baad72h85LLzFeMxwsYE/4Cco6qU59S0Er9MOEJvdsCR9ZZA5N++Cn7r0G+iW5nKoZNKt8VESm7/cC65P2spj182GvFfD68pPqG2fZFEtrBeqoVVJmqK4fXLi+keNLrD5o2nixRC7Sv4NTjB2VpoCBNPqfXK+v03mPLbpHTUBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782891004; c=relaxed/simple;
	bh=9mG4Cj9NTYmMZbE5f5/CBWv6d3SbOGR2LH/IouNJRX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxzFAUbvtlX8naNMsHrLVyPgHl0HPfTPIs9sg0SVweQuM9oMij4A+HNHUTmNUJw7cxttjAuucpLYqFQpP2DmzjNrcdji7o+wt6mtM6/6J7PVH7DxB384ykhzOY7LJh5N0ekSBrhpF7OF/uF9P6YQjw0wwJkNCvhRk5/3SuYQWsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqs8J3dRRzYQtkk
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:29:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9CC00408E4
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:29:58 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnVfP1wURqHV3TAQ--.7907S2;
	Wed, 01 Jul 2026 15:29:58 +0800 (CST)
Message-ID: <2da387b1-ff15-4d7a-9cfe-062a9aa55368@huaweicloud.com>
Date: Wed, 1 Jul 2026 15:29:57 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/21] perf annotate: Introduce extract_op_location
 callback for arch-specific parsing
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-9-wutengda@huaweicloud.com>
 <20260701040647.A23771F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040647.A23771F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnVfP1wURqHV3TAQ--.7907S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDWrW7AF45Zw4ktFWrXwb_yoWrAFW8pa
	1vk34DAF45Jr4UKwnFvan5ZF1Skw4xGF15Wr1jgwnIkrsxurn5Jan29F12kF1rJrs3Cr1j
	vF4DKFsrZwn8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:06, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Refactoring changes the error propagation behavior for memory operands with unrecognized registers, causing valid instructions to be incorrectly marked as bad.
> - [Low] Missing explicit inclusion of `<stdlib.h>` for the POSIX libc function `strtol()`, breaking musl compatibility.
> --
> 
> commit a79e03a1004b442317df26b7478d0a1daed1e563
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate: Introduce extract_op_location callback for arch-specific parsing
> 
> This patch refactors operand parsing by moving it from the central
> annotate_get_insn_location() into architecture-specific callbacks. By
> introducing extract_op_location callbacks for PowerPC and x86, it aims to
> simplify the core logic and improve maintainability without making functional
> changes.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-x86.c b/tools/perf/util/annotate-arch/annotate-x86.c
>> index 7e61365363938..6a4b4bdcd7a7c 100644
>> --- a/tools/perf/util/annotate-arch/annotate-x86.c
>> +++ b/tools/perf/util/annotate-arch/annotate-x86.c
>> @@ -2,6 +2,7 @@
>>  #include <string.h>
>>  #include <linux/compiler.h>
>>  #include <linux/zalloc.h>
>> +#include <linux/ctype.h>
>>  #include <assert.h>
>>  #include <inttypes.h>
>>  #include "../annotate-data.h"
> 
> [Severity: Low]
> Does this file need an explicit include of <stdlib.h> for musl libc
> compatibility?
> 
> It appears strtol() is used later in extract_op_location_x86() without
> the required <stdlib.h> header being directly included here, which might
> lead to implicit function declaration errors on musl-based systems.
> 

Agreed.

> [ ... ]
> 
>> @@ -809,6 +810,86 @@ static void update_insn_state_x86(struct type_state *state,
>>  }
>>  #endif
>>  
>> +/*
>> + * Get register number and access offset from the given instruction.
>> + * It assumes AT&T x86 asm format like OFFSET(REG).  Maybe it needs
>> + * to revisit the format when it handles different architecture.
>> + * Fills @reg and @offset when return 0.
>> + */
>> +static int extract_reg_offset(const struct arch *arch, const char *str,
>> +			      struct annotated_op_loc *op_loc)
>> +{
> 
> [ ... ]
> 
>> +static int extract_op_location_x86(const struct arch *arch,
>> +				   struct disasm_line *dl __maybe_unused,
>> +				   const char *op_str, int op_idx __maybe_unused,
>> +				   struct annotated_op_loc *op_loc)
>> +{
>> +	const char *s = op_str;
>> +	char *p = NULL;
>> +
>> +	if (op_str == NULL)
>> +		return 0;
>> +
>> +	if (strchr(op_str, arch->objdump.memory_ref_char)) {
>> +		op_loc->mem_ref = true;
>> +		return extract_reg_offset(arch, op_str, op_loc);
> 
> [Severity: Medium]
> Does returning the result of extract_reg_offset() here alter the error
> propagation behavior?
> 
> In the previous annotate_get_insn_location() logic, the return value of
> extract_reg_offset() was safely ignored:
> 
>         } else if (strchr(insn_str, arch->objdump.memory_ref_char)) {
>                 op_loc->mem_ref = true;
>                 op_loc->multi_regs = multi_regs;
>                 extract_reg_offset(arch, insn_str, op_loc);
>         } else {
> 
> By returning it here, extract_op_location_x86() might return -1 if the
> register is unrecognized. This regression is now propagated back to the
> caller in annotate_get_insn_location():
> 
>         if (arch->extract_op_location) {
>                 ret = arch->extract_op_location(arch, dl, insn_str, i, op_loc);
>                 if (ret)
>                         return ret;
>         }
> 
> Could this cause valid instructions to be completely skipped and
> incorrectly marked as bad?
> 

I don't think this is a problem. If we don't return an error here,
extract_reg_offset() would continue with an uninitialized or invalid
offset, which would then cause update_insn_state() to make incorrect
judgments. Returning -1 and marking it as bad is actually safer than
silently propagating wrong information.

>> +	}
>> +
>> +	/* FIXME: Handle other segment registers */
>> +	if (!strncmp(op_str, "%gs:", 4)) {
>> +		op_loc->segment = INSN_SEG_X86_GS;
>> +		op_loc->offset = strtol(op_str + 4,
>> +					&p, 0);
> 

