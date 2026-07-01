Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7703B27EE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 08:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895080; cv=none; b=sCD2htq7gIbs3SDk/WgGVr3vwtMUGSZIAHLOUHoSiFexj9KPPsxlFtcUA1F3RV9TosnIWzUKs6BjMCESLRvSJNEzO2XRs2k2crCC+GBRCN3wxi8wEAe42XX4mJ/LoWAESYqp+ZcuIK/o6yCt6myOb/POuz2JiyykR2eRuoLQkhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895080; c=relaxed/simple;
	bh=HhmKo9sSqrvi8le29ytHh6PvTyfKOHbwZT6tJUgPDxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUZ8XBCr3wWx699etzMVCSN60NLWoECYcsTiBrwUQqyjRPXPLU/FZNIX5alPZaOevu2HNw2HEjS/sflIBsrNyCd9+4FFPh6oghKnxgtx8o+nhepkT2MPPTYU6D0zMn5AKfucvWzjomKSX8X1ST7bKiKc2+I1W4jcmPmhCc+Vd0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gqtfg1LtjzYQtJ0
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:36:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 635A84056B
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 16:37:53 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDnqf3g0URqAkfaAQ--.45240S2;
	Wed, 01 Jul 2026 16:37:53 +0800 (CST)
Message-ID: <93084002-9ae9-4f8f-a17d-9f580a2d3f2c@huaweicloud.com>
Date: Wed, 1 Jul 2026 16:37:52 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] perf annotate-arm64: Support load instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-15-wutengda@huaweicloud.com>
 <20260701041445.091681F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701041445.091681F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnqf3g0URqAkfaAQ--.45240S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDWr48WryDWw13Zry8AFb_yoW5Kr1fpa
	93Kay5KFy7Xr4agFsaqF45WrySgr4xXr1UCr98A3WayF9Fyrn5Ka93KrW2kayrGF9xCr4U
	Zwn0qr9rZws5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVWxJr0_GcJvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:14, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] Missing invalidation of the destination register on type resolution failure during load instruction tracking.
> - [Medium] The data type profiling logic ignores the second destination register of load pair (ldp) instructions, leading to stale state retention.
> --
> 
> commit 579f01582f34ef50d993c4cb489f025353f8dbcc
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support load instruction tracking
> 
> This commit extends update_insn_state_arm64() to handle LDR instructions.
> It tracks register state changes when data is loaded from memory to registers,
> supporting signed offset, pre-index, and post-index addressing modes.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 48b1c94273eb6..b48545f35620c 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> +static void update_load_insn_state(struct type_state *state,
>> +				   struct disasm_line *dl,
>> +				   struct annotated_op_loc *src,
>> +				   struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg *tsr;
>> +	struct type_state_reg src_tsr;
>> +	Dwarf_Die type_die;
>> +	u32 insn_offset = dl->al.offset;
>> +	int reg_offset;
>> +	int sreg = src->reg1;
>> +	int dreg = dst->reg1;
> 
> [Severity: Medium]
> Does this ignore the second destination register for load pair (ldp)
> instructions?
> 
> If the instruction writes to two destination registers (e.g.,
> ldp x0, x1, [x2]), it seems dst->reg2 is not checked or invalidated here,
> which could leave it with stale type information. Does the parsing logic in
> arm64_ldst__parse() also need to set ops->target.multi_regs for this to be
> properly tracked?
> 
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		goto out_adjust;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
>> +
>> +retry:
>> +	if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
>> +		invalidate_reg_state(tsr);
>> +		return;
>> +	}
>> +
>> +	src_tsr = state->regs[sreg];
>> +	reg_offset = get_reg_index_offset(src);
>> +
>> +	/* Dereference the pointer if it has one */
>> +	if (src_tsr.kind == TSR_KIND_TYPE &&
>> +	    die_deref_ptr_type(&src_tsr.type,
>> +			       src_tsr.offset + reg_offset, &type_die)) {
>> +		tsr->type = type_die;
>> +		tsr->kind = TSR_KIND_TYPE;
>> +		tsr->offset = 0;
>> +		tsr->ok = true;
>> +
>> +		if (src->multi_regs) {
>> +			pr_debug_dtp("ldr [%x] %#x(reg%d, reg%d) -> reg%d",
>> +				     insn_offset, reg_offset, src->reg1,
>> +				     src->reg2, dreg);
>> +		} else {
>> +			pr_debug_dtp("ldr [%x] %#x(reg%d) -> reg%d",
>> +				     insn_offset, reg_offset, sreg, dreg);
>> +		}
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +	}
>> +	/* Or try another register if any */
>> +	else if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2) {
>> +		sreg = src->reg2;
>> +		goto retry;
>> +	}
> 
> [Severity: Medium]
> If the type resolution fails and execution bypasses both of these if/else
> blocks, it falls through to out_adjust.
> 
> Should the destination register be invalidated here?
> 
> It looks like tsr->ok could remain true from its previous state, leaving it
> with incorrect type information.
> 

Agreed.

>> +
>> +out_adjust:
>> +	adjust_reg_index_state(state, src, "ldr", insn_offset);
>> +}
> 

