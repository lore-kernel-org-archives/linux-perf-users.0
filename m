Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B503EFFDA
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896174; cv=none; b=qWNHzgNtIBTlfgdDpm2ejgY1dGuInJJscMsRVUkn9PfnTON9wZKiSoNrvvWfCfCCUGWf5ol2YNtxJRWwjkcV4DTOVhpWf2z4P5BddrLrzs89nQZoUs6Syoy/LUNqrQA+hyswYnJ65T2cKXe2P61r7Y/PbI1RuSMJpuTvF9isGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896174; c=relaxed/simple;
	bh=g124yqZ5EFLnNnJlPt2Gcywq38EklCpg/ihjICns+qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k+iKxsoHqBNOqxQkIq8wGH+Dvxv4E12iLbFMvskHGl6NST3mBkABbRqfuek1/3cKWwQi9MYlXXBc2c+sL7jnznK5vHCx3idto8Twg/BG75JcLh5y8uIT4EJ9ScSKjAhhWbKJhymdWcrIjkcB17KBVq4VHiMRBOM6lFc32JLuz7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqv4Y5rv3zKHMQN
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:55:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3A53E40592
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:56:07 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnqf0m1kRqYNLbAQ--.50329S2;
	Wed, 01 Jul 2026 16:56:07 +0800 (CST)
Message-ID: <9b181384-028e-4597-8dae-4416b43c940c@huaweicloud.com>
Date: Wed, 1 Jul 2026 16:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/21] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-22-wutengda@huaweicloud.com>
 <20260701041636.7FEDC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041636.7FEDC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnqf0m1kRqYNLbAQ--.50329S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykJrW3Wr4UuFy7AryDtrb_yoWrJFWrpa
	4vka90kF48JF40gwnxXrW8ZrySg397W3W5Kr9093Z2yFZa9rn7GFn7tw42kw4rJr1rCw17
	Zr4Dtr43Gw1kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Memory leak of the dynamically allocated `type_name` string obtained from `strbuf_detach()`.
> - [Medium] Cross-DSO contamination and potential type confusion due to globally caching a DWARF offset (`task_struct_dieoff`).
> --
> 
> commit 0f7d6f3c161448b3cb967b47ee3887be3d974dc1
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
> 
> This commit adds support for parsing the 'mrs' instruction on arm64 in
> 'perf annotate' to track the 'current' task pointer. It dynamically queries
> the DWARF debug information for the 'get_current()' inline function's
> return type to find 'struct task_struct', caching the DWARF offset for
> subsequent lookups.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index ec6fd59d51a27..89e3997f6721b 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -787,6 +789,81 @@ static void update_adrp_insn_state(struct type_state *state,
>>  		     insn_offset, tsr->addr, dreg);
>>  }
>>  
>> +static Dwarf_Off task_struct_dieoff;
>> +
>> +static void update_mrs_insn_state(struct type_state *state,
>> +				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
>> +				  struct disasm_line *dl,
>> +				  struct annotated_op_loc *dst)
>> +{
> [ ... ]
>> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
>> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
>> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
>> +		invalidate_reg_state(tsr);
>> +		return;
>> +	}
>> +
>> +	ip = dloc->ms->sym->start + dl->al.offset;
>> +	pc = map__rip_2objdump(dloc->ms->map, ip);
>> +
>> +	if (!task_struct_dieoff ||
>> +	    !dwarf_offdie(dloc->di->dbg, task_struct_dieoff, &type_die)) {
> 
> [Severity: Medium]
> Since DWARF offsets are local to their .debug_info section, if perf annotate
> processes a symbol in a different kernel module (where dso__kernel() is still
> true), couldn't this global task_struct_dieoff be applied to the module's
> Dwarf * handle?
> 
> Would this result in type confusion or returning an arbitrary, unrelated DIE
> across different DSOs?
> 
>> +		struct strbuf sb;
>> +		char *type_name;
>> +		/*
>> +		 * Find the inline function 'get_current()' Dwarf_Die
>> +		 * and obtain its return value data type, which should
>> +		 * be 'struct task_struct*'.
>> +		 */
>> +		if (!die_find_inlinefunc(cu_die, pc, &func_die) ||
>> +			!dwarf_attr_integrate(&func_die, DW_AT_type, &attr) ||
>> +			!dwarf_formref_die(&attr, &type_die)) {
>> +			invalidate_reg_state(tsr);
>> +			return;
>> +		}
>> +
>> +		strbuf_init(&sb, 32);
>> +		die_get_typename_from_type(&type_die, &sb);
>> +		type_name = strbuf_detach(&sb, NULL);
>> +
>> +		if (!type_name || strcmp(type_name, "struct task_struct*")) {
>> +			invalidate_reg_state(tsr);
>> +			return;
>> +		}
> 
> [Severity: Medium]
> Does this code leak the type_name string?
> 
> strbuf_detach() allocates and transfers ownership of the string to type_name,
> but it appears to never be freed on either the success path or the error path
> returning here.
> 

Agreed. Will fix it in next version.

>> +
>> +		/*
>> +		 * Cache the 'struct task_struct*' die offset globally.
>> +		 * This allows us to resolve stack canary accesses even
>> +		 * in CUs that lack a full task_struct definition (e.g.,
>> +		 * compiler-generated entry/exit code).
>> +		 */
>> +		task_struct_dieoff = dwarf_dieoffset(&type_die);
>> +	}
> 

