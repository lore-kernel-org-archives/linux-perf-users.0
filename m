Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E52233936
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791967806; cv=none; b=d/M7LBnh4oPtIHF11q+tPxfNbVMjw6lZ7G/qr6r82nlQoqoWPA7bcKjtKmORARDmH+w1VBIMpFf6llcpC3I1QjLi0AKkaLtH/9C9CUUULYvdbtE4c9X8U2i8380pkpHL+UTn/0ew8TAc3XZ/x/rc483+k8vnaVrsD1+tTrsRxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791967806; c=relaxed/simple;
	bh=KvFKHfqFV+5ISK8Sy/EfB9jKmh86Ren2blvG613txhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uKwzHnRj3JftQWS+hEC8uJJVM8Wce8QhPXjFBnkeKevzqMDXUdTXLXfHnE6z2RS7RIAgos1GeWmc1iaSqbEbqMSpJNDXIENFegLyhHPbfLdYAInpnwBKd58nqP+ZibS1osTJ6C9ehBRHHCfPXipbQvFVNza4AdcGudzeWxrZOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j4Py44Y9CzKHLwp
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:49:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AA6AA40595
	for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 16:50:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAXS+o4Qs9qAI2VAQ--.24749S2;
	Wed, 14 Oct 2026 16:50:00 +0800 (CST)
Message-ID: <4154959f-8202-4abd-8f1e-4f3643e5eefc@huaweicloud.com>
Date: Wed, 14 Oct 2026 16:50:00 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 15/15] perf annotate-arm64: Support 'mrs' instruction
 to track 'current' pointer
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1791629326.git.wutengda@huaweicloud.com>
 <0615c314accfce4f3db561db1b1e02efcc5fd66b.1791629326.git.wutengda@huaweicloud.com>
 <sashiko-outbox-169878@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <sashiko-outbox-169878@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXS+o4Qs9qAI2VAQ--.24749S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykuw1xJFyrZw15KF4kWFg_yoW5Cw4xpa
	95u395Ka17Xr42qrsxXFWxZr9Ygw4xGr1DCrn0yF4IyFZFkr1fKas2gFW7uF4rGr95Cr1U
	Aw1DtFZrZw48CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUwmhFDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/10/13 22:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] perf annotate-arm64: missing lifetime cleanup in update_mrs_insn_state()
> --
> 
> commit 084f7875323701c8124c43b96de264a478df7634
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'mrs' instruction to track 'current' pointer
> 
> This patch extends update_insn_state_arm64() to handle the mrs instruction.
> It enables tracking the current task pointer in the kernel, which is
> typically accessed via the sp_el0 system register.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 5683215f07708..6da558f7e8648 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -1030,6 +1032,71 @@ static void update_adrp_insn_state(struct type_state *state,
>>  		     insn_offset, tsr->imm_value, dreg);
>>  }
>>  
>> +static void update_mrs_insn_state(struct type_state *state,
>> +				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
>> +				  struct disasm_line *dl,
>> +				  struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg *tsr;
>> +	Dwarf_Die type_die;
>> +	u32 insn_offset = dl->al.offset;
>> +	int dreg = dst->reg1;
>> +	Dwarf_Die func_die;
>> +	Dwarf_Attribute attr;
>> +	u64 ip, pc;
>> +	struct strbuf sb;
>> +	char *type_name;
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		return;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
>> +
>> +	/* Handle case difference: LLVM (SP_EL0) vs objdump (sp_el0) */
>> +	if (!dso__kernel(map__dso(dloc->ms->map)) ||
>> +	    strcasecmp(dl->ops.source.raw, "sp_el0")) {
>> +		invalidate_reg_state(tsr);
>> +		return;
>> +	}
> [ ... ]
>> +	if (!type_name || strcmp(type_name, "struct task_struct*")) {
>> +		invalidate_reg_state(tsr);
>> +		goto out_free;
>> +	}
>> +
>> +	tsr->type = type_die;
>> +	tsr->kind = TSR_KIND_TYPE;
>> +	tsr->offset = 0;
>> +	tsr->imm_value = 0;
>> +	tsr->ok = true;
> 
> [Severity: Medium]
> Are we missing a cleanup of the previous lifetime state for the destination
> register here?
> 
> If the target register previously held a variable with an active Dwarf
> lifetime, the lifetime_active flag remains true. Upon a subsequent function
> call, the register tracking logic skips invalidating caller-saved registers
> that have an active lifetime.
> 
> This could cause the target register (e.g., x0 holding current) to
> incorrectly survive the function call in the analysis state, even though
> the hardware register is clobbered by the callee.
> 
> Should this path clear tsr->lifetime_active and tsr->lifetime_end, or
> perhaps call invalidate_reg_state() earlier before assigning the new
> properties?
> 

OK, this patch has the same issue. I missed that too. Will fix it.

Tengda

>> +
>> +	pr_debug_dtp("mrs [%x] sp_el0 -> reg%d", insn_offset, dreg);
>> +	pr_debug_type_name(&type_die, tsr->kind);
>> +
>> +out_free:
>> +	free(type_name);
>> +}
> 

