Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FE43DB31B
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093757; cv=none; b=QWMB4zIymqjR3jNWDbbucoFKFApjMrRRHsW03hHtALf+QG9vMqffpWUZCb9CYWlBa6fpEfcOMA93QbxQ8qAhWeeHVgtrnRO10kxakUYT+8d47M3TKbJxm8N3Qlpm98pkieIuHTGO4nJuJMZ1uNi7jnq5Ns3PyeVYpIBUb60kfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093757; c=relaxed/simple;
	bh=aNIN9qF8cmNuKXuFpJU95B5VsidYrpe+jlE2SkXjrj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GyeOWpM+v7sHo9WXIMVCZm2aQ1jSLd4bZMxxSAnsHk04yfNoSFHWuzPJVoN30armQ6sxWSnOYi/8Z/3Vw74nILPD/q+hoM6Lu73r/gEGE8qirGaseb6SgVbkZqJLnawZse6iy0Pj1SjBO068VZ+rUanA3e8df3OlCzK2i7gv5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgz4w20RXzKHMJf
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 10:29:04 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id BDC444058D
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 10:29:09 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBHLwp1Z6NqXmcYBg--.47527S2;
	Fri, 11 Sep 2026 10:29:09 +0800 (CST)
Message-ID: <331033ad-6648-40e8-8b79-8e892b8af37b@huaweicloud.com>
Date: Fri, 11 Sep 2026 10:29:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 23/26] perf annotate-arm64: Support 'add' instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <f562a5e0bf612867a6ddcde891f1582b4fcf61eb.1788872630.git.wutengda@huaweicloud.com>
 <20260908132810.4DFEE1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908132810.4DFEE1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHLwp1Z6NqXmcYBg--.47527S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5AFy5Cr1fAFW8Zr4DCFg_yoW8tF1fpF
	4DC34rGw47Jrs7Krs3Zr4xX34Sgw4xGF15urn0qa1SvF1akrn5Kas7KF429FWrGrn3Cw4j
	vw1v9F4DZw40ka7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Failure to clear `lifetime_active` and `lifetime_end` in `update_add_insn_state` for the destination register.
> --
> 
> commit 1ca68e83139c25b5687ab59598c804f32ea92afb
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'add' instruction tracking
> 
> This commit extends update_insn_state_arm64() to track 'add'
> instructions for structure member address calculation. It enables the
> data type tracker to follow member address calculations and propagate
> types correctly instead of dropping type info on 'add'.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 2f8bedf583c1a..e237b91426849 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -864,6 +864,72 @@ static void update_mov_insn_state(struct type_state *state,
>>  	pr_debug_type_name(&tsr->type, tsr->kind);
>>  }
>>  
>> +static void update_add_insn_state(struct type_state *state,
>> +				  struct data_loc_info *dloc,
>> +				  struct disasm_line *dl,
>> +				  struct annotated_op_loc *src,
>> +				  struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg *tsr;
>> +	struct type_state_reg src_tsr;
>> +	u32 insn_offset = dl->al.offset;
>> +	int sreg = src->reg1;
>> +	int dreg = dst->reg1;
>> +	int reg_offset;
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		return;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
> 
> [Severity: Medium]
> Does this code need to clear lifetime_active and lifetime_end on the
> destination register?
> 
> When the add instruction overwrites a destination register that previously
> tracked a variable with an active DWARF lifetime, it looks like the stale
> DWARF lifetime bounds are incorrectly retained on the destination register.
> Could this cause caller-saved registers to incorrectly survive function call
> invalidation and corrupt data type tracking during profiling?
> 
> [ ... ]
> 

Agreed.

Thanks,
Tengda

