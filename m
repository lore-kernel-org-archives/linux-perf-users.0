Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26F34EEF1;
	Fri, 10 Apr 2026 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816188; cv=none; b=CcN0HG7NBi1UOHiz8joQVZ9TT2JsQMBpSYp9AOZTVbMFUIEHsgM1IWsYachXMcGcteC8C5dTm0fKfAIzRqGIh94INwUW7e5BBogfihfqKz2crBIX38zpogpH+Y4Xl4+eC8cDBMltTi7r3ZFD97cO90eMTnCxQ5dhYcSImzgWYNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816188; c=relaxed/simple;
	bh=PdDbI/SCGQzmh42OBbIAbpGkXIr66DUm0k7jmQY1nZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFYP2mcvKPzEfQMhtmHLasHMdFRQePGx+TqACeGAwqg0O5Vi6hp4826WPJFLuALvx5NtSAmrnYAav3bSsmh9ggdosSKWQ/cpMIllzpc4Bs3xG86aaT8ssX+aRUOAiqy+tLyVTCQGcMgEpxOJKE2Cf7KOlyVcWnBT/NMmCs8pMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsXl92WFyzKHMRb;
	Fri, 10 Apr 2026 18:16:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id F325D4057B;
	Fri, 10 Apr 2026 18:16:22 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgA3YAX1zdhp6nw1EA--.50015S2;
	Fri, 10 Apr 2026 18:16:22 +0800 (CST)
Message-ID: <17d3b815-c730-41cc-bb56-e17b833fb829@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:16:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] perf annotate-arm64: Handle load and store
 instructions
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
 <20260403094800.1418825-5-wutengda@huaweicloud.com> <adStnrfA6IxkOfRN@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adStnrfA6IxkOfRN@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgA3YAX1zdhp6nw1EA--.50015S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyfKw48Aryftr1UXw1kXwb_yoW7AFW3pa
	nrCa15JF4UXr18W3WSqFZrZFyfKw48JwnFk348Ja4ak3savr97tF1kKr1akF1rCrWkuw47
	ZFn0vry8uF98ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/7 15:09, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:48AM +0000, Tengda Wu wrote:
>> Add ldst_ops to handle load and store instructions in order to parse
>> the data types and offsets associated with PMU events for memory access
>> instructions. There are many variants of load and store instructions in
>> ARM64, making it difficult to match all of these instruction names
>> completely. Therefore, only the instruction prefixes are matched. The
>> prefix 'ld|st' covers most of the memory access instructions, 'cas|swp'
>> matches atomic instructions, and 'prf' matches memory prefetch
>> instructions.
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 72 +++++++++++++++++++
>>  1 file changed, 72 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 4c42323b0c18..8209faaa6086 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -3,7 +3,9 @@
>>  #include <errno.h>
>>  #include <stdlib.h>
>>  #include <string.h>
>> +#include <ctype.h>
>>  #include <linux/zalloc.h>
>> +#include <linux/string.h>
>>  #include <regex.h>
>>  #include "../annotate.h"
>>  #include "../disasm.h"
>> @@ -12,6 +14,7 @@ struct arch_arm64 {
>>  	struct arch arch;
>>  	regex_t call_insn;
>>  	regex_t jump_insn;
>> +	regex_t ldst_insn; /* load and store instruction */
>>  };
>>  
>>  static bool arm64__check_multi_regs(const char *op)
>> @@ -114,6 +117,59 @@ static const struct ins_ops arm64_mov_ops = {
>>  	.scnprintf = mov__scnprintf,
>>  };
>>  
>> +static int arm64_ldst__parse(const struct arch *arch __maybe_unused,
> 
> The 'arch' is used. :)
> 

Oh, will fix it.

> 
>> +			     struct ins_operands *ops,
>> +			     struct map_symbol *ms __maybe_unused,
>> +			     struct disasm_line *dl __maybe_unused)
>> +{
>> +	char *s, *target;
>> +
>> +	/*
>> +	 * The part starting from the memory access annotation '[' is parsed
>> +	 * as 'target', while the part before it is parsed as 'source'.
> 
> It'd be nice if you can show some examples.  So it always looks like:
> 
> 	LDR  x1, [x2, #4]
> 	STR  x1, [x3], #8
> 
> Right?  What about other instructions?
> 

Yeah. Here are some representative examples that this patch handles:

ldr     x1, [x2]
ldr     x2, [x0, #968]
ldr     w3, [x25], #4
ldp     x29, x30, [sp], #16
ldr     x0, [x1, #16]!
ldr     x6, [x23, w25, sxtw #3]

It might be better to add these examples as a block comment above
the arm64_ldst__parse().

> 
>> +	 */
>> +	target = s = strchr(ops->raw, arch->objdump.memory_ref_char);
>> +	if (!s)
>> +		return -1;
>> +
>> +	while (s > ops->raw && *s != ',')
>> +		--s;
>> +
>> +	if (s == ops->raw)
>> +		return -1;
>> +
>> +	*s = '\0';
>> +	ops->source.raw = strdup(ops->raw);
>> +
>> +	*s = ',';
>> +	if (!ops->source.raw)
>> +		return -1;
>> +
>> +	ops->source.multi_regs = arm64__check_multi_regs(ops->source.raw);
> 
> Probably it's better to set ops->source.mem_ref to false.  Then you
> won't need to set multi_regs.
> 
> Thanks,
> Namhyung

Agreed.

-- Tengda

> 
>> +
>> +	ops->target.raw = strdup(target);
>> +	if (!ops->target.raw) {
>> +		zfree(&ops->source.raw);
>> +		return -1;
>> +	}
>> +	ops->target.mem_ref = true;
>> +	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
>> +
>> +	return 0;
>> +}
>> +
>> +static int arm64_ldst__scnprintf(const struct ins *ins, char *bf, size_t size,
>> +				 struct ins_operands *ops, int max_ins_name)
>> +{
>> +	return scnprintf(bf, size, "%-*s %s,%s", max_ins_name, ins->name,
>> +			 ops->source.raw, ops->target.raw);
>> +}
>> +
>> +static struct ins_ops arm64_ldst_ops = {
>> +	.parse	   = arm64_ldst__parse,
>> +	.scnprintf = arm64_ldst__scnprintf,
>> +};
>> +
>>  static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch, const char *name)
>>  {
>>  	struct arch_arm64 *arm = container_of(arch, struct arch_arm64, arch);
>> @@ -124,6 +180,8 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>>  		ops = &jump_ops;
>>  	else if (!regexec(&arm->call_insn, name, 2, match, 0))
>>  		ops = &call_ops;
>> +	else if (!regexec(&arm->ldst_insn, name, 2, match, 0))
>> +		ops = &arm64_ldst_ops;
>>  	else if (!strcmp(name, "ret"))
>>  		ops = &ret_ops;
>>  	else
>> @@ -148,6 +206,8 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  	arch->id = *id;
>>  	arch->objdump.comment_char	  = '/';
>>  	arch->objdump.skip_functions_char = '+';
>> +	arch->objdump.memory_ref_char	  = '[';
>> +	arch->objdump.imm_char		  = '#';
>>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>>  
>>  	/* bl, blr */
>> @@ -161,8 +221,20 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  	if (err)
>>  		goto out_free_call;
>>  
>> +	/*
>> +	 * The ARM64 architecture has many variants of load/store instructions.
>> +	 * It is quite challenging to match all of them completely. Here, we
>> +	 * only match the prefixes of these instructions.
>> +	 */
>> +	err = regcomp(&arm->ldst_insn, "^(ld|st|cas|prf|swp)",
>> +		      REG_EXTENDED);
>> +	if (err)
>> +		goto out_free_jump;
>> +
>>  	return arch;
>>  
>> +out_free_jump:
>> +	regfree(&arm->jump_insn);
>>  out_free_call:
>>  	regfree(&arm->call_insn);
>>  out_free_arm:
>> -- 
>> 2.34.1
>>

