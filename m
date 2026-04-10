Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDFC38F649;
	Fri, 10 Apr 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818196; cv=none; b=VWcUaEadHww/SXSOzSkPyyXmfnYE8V5vpdos5cm+iSMcdqn7wbLwnS6UXzSiBvxwz4Ql4RCM8pq9HtI/XISoxL+T6DKdfK1caW+KdUt2u2cD67SRnw7gz5L15VzI8X1n6n8APQlW1+axbnvkhNN/s2OQMuxqDrC7e0Z5FX6ze+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818196; c=relaxed/simple;
	bh=fzooCiaJhwFmGIIp6QwM/1YCbrXY+5VNPVRPzyVLxOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsGMDo9pMekwbrEN2JV4PYb1dQHYd2aDsskdPO7WPuG6GKMIQsbMssCu61UY28YIunQvoKhpIck1WdVxJ+6BBLAdOLHvW0TFZLWHi0+s8BRd9wIH0GOLGRjAVsl6auhMOSDCsDrWjWRj9xsNDEfgxWzDrd6hEcYDxW9epcLZt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsYT33ftNzYQtrY;
	Fri, 10 Apr 2026 18:49:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E2C474056F;
	Fri, 10 Apr 2026 18:49:48 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgA3YAXL1dhpGUo4EA--.56530S2;
	Fri, 10 Apr 2026 18:49:48 +0800 (CST)
Message-ID: <a68d02a9-6a9d-4c36-9392-fcb2b0bcf538@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:49:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/16] perf annotate-arm64: Support 'add' instruction
 tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-14-wutengda@huaweicloud.com>
 <adib8wD8NPtxpQEL@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adib8wD8NPtxpQEL@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3YAXL1dhpGUo4EA--.56530S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDCr4ftw1fArykGrWxWFg_yoWrZrW8pa
	yqkFWUGw47Xr12gwsIqrZxZF1fKws3GF1jkryqg3Wakr9Iyr1xtas2krW3uayrJrZxAw4x
	Zr1Utr1fuw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsfMaUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 14:42, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:57AM +0000, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to track pointer arithmetic and
>> member address calculations.
>>
>> The arm64 'add' instruction frequently calculates structure member
>> addresses, such as 'add x0, x1, #offset'. Tracking this is essential
>> to maintain the connection between a base pointer and its derived
>> member addresses.
> 
> What about other arithmetic instructions?  Can 'sub' be used in a
> similar manner?  Maybe we want to invalidate the target register state
> for all(?) other instructions.
> 
> Thanks,
> Namhyung
> 

I need to investigate further if 'sub' is practically used for member address
calculation in arm64. As for other instructions, I completely agree with the
idea of invalidating the target register state to avoid any incorrect type matching.

Thanks,
Tengda

>>
>> The implementation checks if the base register contains a pointer
>> or a structure type. When an immediate offset is added, use
>> die_get_member_type() to verify that the resulting offset points to
>> a valid member within the data type. If valid, update the target
>> register's type state with the new offset while preserving the base
>> type information.
>>
>> A real-world example is shown below:
>>
>>   ffff80008001c9a8 <flush_ptrace_hw_breakpoint>:
>>   ffff80008001c9c4:  add  x19, x0, #0xeb8 // x0 (task_struct*) + 0xeb8 -> x19
>>   ffff80008001c9d0:  ldr  x0, [x19]       // PMU sample
>>
>> Before this commit, the type flow broke at the 'add' instruction,
>> leaving the subsequent load with no type information:
>>
>>   chk [28] reg19 offset=0 ok=0 kind=0 cfa : no type information
>>   final result: no type information
>>
>> After this commit, the tracker correctly follows the member address
>> calculation:
>>
>>   var [0] reg0 offset 0 type='struct task_struct*'
>>   add [1c] address of 0xeb8(reg0) -> reg19 type='struct task_struct*'
>>   chk [28] reg19 offset=0 ok=1 kind=1 (struct task_struct*) : Good!
>>   found by insn track: 0(reg19) type-offset=0xeb8
>>   final result: type='struct task_struct'
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 013b673f4861..d2557b9d6909 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -7,6 +7,7 @@
>>  #include <linux/zalloc.h>
>>  #include <linux/string.h>
>>  #include <regex.h>
>> +#include <inttypes.h>
>>  #include "../annotate.h"
>>  #include "../disasm.h"
>>  #include "../annotate-data.h"
>> @@ -308,6 +309,50 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	sreg = src->reg1;
>>  	dreg = dst->reg1;
>>  
>> +	if (!strcmp(dl->ins.name, "add")) {
>> +		struct type_state_reg dst_tsr;
>> +
>> +		if (!has_reg_type(state, sreg) ||
>> +		    !has_reg_type(state, dreg) ||
>> +		    !state->regs[dreg].ok)
>> +			return;
>> +
>> +		tsr = &state->regs[sreg];
>> +		tsr->copied_from = -1;
>> +		dst_tsr = state->regs[dreg];
>> +
>> +		/* Handle calculation of a register holding a typed pointer */
>> +		if (dst_tsr.kind == TSR_KIND_POINTER ||
>> +		    (dst_tsr.kind == TSR_KIND_TYPE &&
>> +		    dwarf_tag(&dst_tsr.type) == DW_TAG_pointer_type)) {
>> +			s32 offset;
>> +
>> +			if (dst_tsr.kind == TSR_KIND_TYPE &&
>> +			    __die_get_real_type(&dst_tsr.type, &type_die) == NULL)
>> +				return;
>> +
>> +			if (dst_tsr.kind == TSR_KIND_POINTER)
>> +				type_die = dst_tsr.type;
>> +
>> +			/* Check if the target type has a member at the new offset */
>> +			offset = dst->offset + dst_tsr.offset;
>> +			if (die_get_member_type(&type_die, offset, &type_die) == NULL)
>> +				return;
>> +
>> +			tsr->type = dst_tsr.type;
>> +			tsr->kind = dst_tsr.kind;
>> +			tsr->offset = offset;
>> +			tsr->ok = true;
>> +
>> +			pr_debug_dtp("add [%x] address of %s%#x(reg%d) -> reg%d",
>> +				     insn_offset, dst->offset < 0 ? "-" : "",
>> +				     abs(dst->offset), dreg, sreg);
>> +
>> +			pr_debug_type_name(&tsr->type, tsr->kind);
>> +		}
>> +		return;
>> +	}
>> +
>>  	/* Register to register transfers */
>>  	if (!strcmp(dl->ins.name, "mov")) {
>>  		if (!has_reg_type(state, sreg))
>> -- 
>> 2.34.1
>>

