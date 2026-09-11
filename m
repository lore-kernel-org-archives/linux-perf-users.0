Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7041B8C6
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121736; cv=none; b=g3ksOXyintwTxI5NOHKSo9mmRSYs4bbTb5xZ5RBuX2vTQ2LB4KOtVLE6mE3162SseQmDynE3jr54XXLx7ktNN0yGLG/tDOlivlC8nS3aAONfrjghn6oG6PUlzKyNYB2EwBfjszNbIphiK7MyH5OLvQH65lEXkEW0NM7khNfA+1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121736; c=relaxed/simple;
	bh=KzP/eeDfOqS2yjpWh+qwaya1FNL4hs0zQzK48YpH6bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BLrhfCkqZ10lxs+gjXN4hfM9Y1z84UcGFV8cPmZsoJ966autVNyrvMmwlw4tUpsOhexnU3tj94yoqIs0y+UjsLOXOmVaanp2SqyTcilhRB/xwXkMyx+JkqJV5fQUXmCOz1eLDVko6/ZH8ifF++GHX5vl9T91ZUmdkkTLTE9rDfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hh9Pv6MtMzYQtGs
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 18:14:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 585F240573
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 18:15:24 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDXPUq71KNqtWVMBg--.54653S2;
	Fri, 11 Sep 2026 18:15:24 +0800 (CST)
Message-ID: <05e0e407-c4d1-44e2-9d88-b170f57eb663@huaweicloud.com>
Date: Fri, 11 Sep 2026 18:15:23 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/26] perf annotate-arm64: Support per-cpu variable
 access tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <4cebb0f4d2db4d66c4ec19c4c007d6761e5aad8e.1788872630.git.wutengda@huaweicloud.com>
 <20260908133059.E85591F00AC4@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908133059.E85591F00AC4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDXPUq71KNqtWVMBg--.54653S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDuw4xAw4fAFyxXr1rXrb_yoWrXF1rpr
	9akFyrKr1jvrsYqanavr4rXF1ruw47tr4Y9ryrta1xArnIyw1rGa93KrWUGF48Gr9xCr17
	AwsYqa9xZa1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:30, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The newly added logic to track per-cpu base registers in 'add' and 'ldr' instructions is entirely unreachable dead code because `arch_get_reg_offset` prematurely aborts the tracking state.
> --
> 
> commit e3331fba4432f08f3db300129b5060bba477930c
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support per-cpu variable access tracking
> 
> This commit extends update_insn_state_arm64() to handle per-cpu variable
> addressing. It detects 'adrp + ldr' pairs that resolve to the
> '__per_cpu_offset' symbol, and attempts to propagate this type information
> through subsequent 'ldr' and 'add' instructions. However, the newly added
> logic is entirely unreachable dead code because arch_get_reg_offset()
> prematurely aborts the tracking state.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 9daf959055457..33fef3d153786 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -649,6 +660,12 @@ static int propagate_load_reg_state(struct type_state *state,
>>  		return 0;
>>  	}
>>  
>> +	/*
>> +	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
>> +	 * No special handling is needed here; just fall through to retry
>> +	 * and resolve the type from the second register.
>> +	 */
>> +
> 
> [Severity: Medium]
> Is this fall-through logic in propagate_load_reg_state() for intermediate
> Pattern A ('ldr') instructions actually reachable?
> 
> Earlier in propagate_load_reg_state(), arch_get_reg_offset() forces an early
> exit by returning -1 when evaluating a multi-register load where the second
> register isn't a constant. This happens before this new per-cpu fallback
> logic can be reached, making this dead code.
> 

Indeed. The return happens too early.

>>  	/* Or try another register if any */
>>  	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
>>  	    !(src->extend_type || src->shift_type)) {
> 
> [ ... ]
> 
>> @@ -949,6 +966,34 @@ static void update_add_insn_state(struct type_state *state,
>>  		return;
>>  	}
>>  
>> +	if (src_tsr.kind == TSR_KIND_PERCPU_BASE) {
>> +		int reg2;
>> +
>> +		if (!src->multi_regs) {
>> +			invalidate_reg_state(tsr);
>> +			return;
>> +		}
>> +
>> +		reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
>> +
>> +		if (!has_reg_type(state, reg2) || !state->regs[reg2].ok) {
>> +			invalidate_reg_state(tsr);
>> +			return;
>> +		}
>> +
>> +		/* Treat percpu as array: inherit type from reg2 */
>> +		tsr->type = state->regs[reg2].type;
>> +		tsr->kind = state->regs[reg2].kind;
>> +		tsr->offset = state->regs[reg2].offset;
>> +		tsr->imm_value = state->regs[reg2].imm_value;
>> +		tsr->ok = state->regs[reg2].ok;
>> +
>> +		pr_debug_dtp("add [%x] percpu (reg%d, reg%d) -> reg%d",
>> +			     insn_offset, src->reg1, src->reg2, dreg);
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +		return;
>> +	}
>> +
> 
> [Severity: Medium]
> Does this block ever execute when handling a per-cpu address calculation
> (Pattern B like 'add x0, x6, x5') in update_add_insn_state()?
> 
> When arch_get_reg_offset() executes earlier in update_add_insn_state(), it
> returns -1 for multi-register non-memory operations (like 'add') unless one
> register is a TSR_KIND_CONST or the base is a known TSR_KIND_POINTER.
> 
> Since the registers here are PERCPU_BASE and GLOBAL_ADDR, it returns -1
> and jumps to the try_other_reg label, permanently bypassing this new tracking
> logic.
> 

Agreed. This is the same issue as above. Will fix in v6.

>>  try_other_reg:
>>  	/* Try another register if any */
>>  	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
> 

