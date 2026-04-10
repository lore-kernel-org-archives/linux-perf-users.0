Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A62638A738;
	Fri, 10 Apr 2026 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775817882; cv=none; b=spl8QnT1MoYxPmjG8KDbgTrwX0OugHf8nsgN0CvnZTTBOJtVNtuPUJ+V5EibltIHTCCoFm6WeaMP6QRMoFp1wKFrZw/S1tOF+NkOupsRLznhmUHzqwE8cRRocXtjQGLzmkTitUks0wqob87Fj37ZSasgB6+KUbgYnAg00plKvjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775817882; c=relaxed/simple;
	bh=2glRAT3qMf+lYnYxeIWrm8veFdsUotq01HMekMYZUCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SmBhZ/EoEqaDOxJCVbRFoqoWwqnnpDoga5LM+iqwYU1hEnnvMY59ObBYcyBWh3D3C6uc+jq7A60z4l73iwcZvg9JVOebQZ92bBVAZGkvBTpEjmqz/ZDnyIFbG0MoSKzcQ4vOvZetD7YAhMXUBypsoStyX2U9Ax9/CdUCIUlXY/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsYMl1RdnzKHMNR;
	Fri, 10 Apr 2026 18:44:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D8FB540574;
	Fri, 10 Apr 2026 18:44:36 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgBHJVKU1NhpxyokEA--.48084S2;
	Fri, 10 Apr 2026 18:44:36 +0800 (CST)
Message-ID: <21ae482a-86de-45eb-bb47-decea664b438@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:44:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
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
 <20260403094800.1418825-17-wutengda@huaweicloud.com>
 <adieMzY6o4yXGdFS@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adieMzY6o4yXGdFS@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBHJVKU1NhpxyokEA--.48084S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryDCr4xGF4ruFyDtF15XFb_yoW7Gr15pa
	yvka45GF4kJr42gw4aqFWDZrySg397Ww15Cr98t3WSyFZakr1xtFn5K3y7uayrJry0kw1I
	vr4UtrW3Ww1DCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUIbyZUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 14:52, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:48:00AM +0000, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to handle the 'mrs' instruction,
>> enabling the tracking of the 'current' task pointer in the kernel.
>>
>> On arm64, the kernel uses the 'sp_el0' system register to store the
>> address of the currently executing 'struct task_struct'. This is
>> typically accessed via the 'get_current()' inline function, resulting
>> in the instruction 'mrs xN, sp_el0'.
>>
>> To resolve the data type of the target register, first verify the
>> access is to 'sp_el0' within a kernel DSO. Then, locate the
>> 'get_current()' inline function's DWARF Die at the current PC and
>> extract its return type (which is 'struct task_struct *').
>>
>> Introduce a global 'task_struct_off' cache to store the DWARF offset
>> of this type. This is particularly important because the compiler-generated
>> stack canary check code (which loads from 'current') often exists in
>> code sections or leaf functions where the local Compilation Unit (CU)
>> lacks a full 'struct task_struct' definition. Caching the offset allows
>> 'perf annotate' to consistently resolve task-related fields across the
>> entire kernel binary.
>>
>> A real-world example is shown below:
>>
>>   ffff8000800deee8 <kthread_blkcg>:
>>   ffff8000800deef0:  mrs  x0, sp_el0    // x0 = current
>>   ffff8000800deef4:  ldr  w1, [x0, #44] // Access task_struct member
>>
>> Before this commit, the type flow starts with no information:
>>
>>   chk [c] reg0 offset=0x2c ok=0 kind=0 cfa : no type information
>>   final result: no type information
>>
>> After this commit, the tracker identifies the 'current' pointer
>> from the system register:
>>
>>   mrs [8] sp_el0 -> reg0 type='struct task_struct*'
>>   chk [c] reg0 offset=0x2c ok=1 kind=1 (struct task_struct*) : Good!
>>   found by insn track: 0x2c(reg0) type-offset=0x2c
>>   final result: type='struct task_struct'
>>
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 53 +++++++++++++++++++
>>  1 file changed, 53 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 89b6b596f984..b03b12594260 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -14,6 +14,7 @@
>>  #include "../debug.h"
>>  #include "../map.h"
>>  #include "../symbol.h"
>> +#include "../dso.h"
>>  
>>  struct arch_arm64 {
>>  	struct arch arch;
>> @@ -289,6 +290,8 @@ static void adjust_reg_index_state(struct type_state *state, int reg,
>>  	pr_debug_type_name(&tsr->type, tsr->kind);
>>  }
>>  
>> +static Dwarf_Off task_struct_off;
>> +
>>  static void update_insn_state_arm64(struct type_state *state,
>>  				    struct data_loc_info *dloc, Dwarf_Die *cu_die,
>>  				    struct disasm_line *dl)
>> @@ -309,6 +312,56 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	sreg = src->reg1;
>>  	dreg = dst->reg1;
>>  
>> +	if (!strcmp(dl->ins.name, "mrs")) {
>> +		Dwarf_Die func_die;
>> +		Dwarf_Attribute attr;
>> +		u64 ip, pc;
>> +
>> +		if (!has_reg_type(state, sreg))
>> +			return;
>> +
>> +		/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
>> +		if (!dso__kernel(map__dso(dloc->ms->map)) ||
>> +		    strcasecmp(dl->ops.target.raw, "sp_el0"))
>> +			return;
>> +
>> +		ip = dloc->ms->sym->start + dl->al.offset;
>> +		pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +		if (!task_struct_off ||
>> +		    !dwarf_offdie(dloc->di->dbg, task_struct_off, &type_die)) {
>> +			/*
>> +			 * Find the inline function 'get_current()' Dwarf_Die
>> +			 * and obtain its return value data type, which should
>> +			 * be 'struct task_struct *'.
>> +			 */
>> +			if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
>> +			    !dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
>> +			    !dwarf_formref_die(&attr, &type_die))
>> +				return;
> 
> I think it's better to verify if it's really the function and type we
> want.
> 
> Thanks,
> Namhyung
> 

Agreed.

-- Tengda

>> +
>> +			/*
>> +			 * Cache the 'struct task_struct *' die offset globally.
>> +			 * This allows us to resolve stack canary accesses even
>> +			 * in CUs that lack a full task_struct definition (e.g.,
>> +			 * compiler-generated entry/exit code).
>> +			 */
>> +			task_struct_off = dwarf_dieoffset(&type_die);
>> +		}
>> +
>> +		tsr = &state->regs[sreg];
>> +		tsr->copied_from = -1;
>> +		tsr->type = type_die;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = 0;
>> +		tsr->addr = 0;
>> +		tsr->ok = true;
>> +
>> +		pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, sreg);
>> +		pr_debug_type_name(&type_die, tsr->kind);
>> +		return;
>> +	}
>> +
>>  	if (!strcmp(dl->ins.name, "adrp")) {
>>  		if (!has_reg_type(state, sreg) || !dl->ops.target.addr)
>>  			return;
>> -- 
>> 2.34.1
>>

