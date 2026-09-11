Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807AD2F531B
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 02:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093359; cv=none; b=UJp9J9u799irXeo8w5oA3MsBtetHJI8r0Ac2G6jZ0Vepm7V6yp7qIOSl7l/pbKWvVRaF6zRF/tYH2UJ9hJWfd3U0PlllFAeDtbbul1l65j6y9BD29upQGcyPgt9qnuzKwbrKqpv5aHX1hSo7IoYvZZOS9Uk89uV4mM6eKyQluL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093359; c=relaxed/simple;
	bh=ym+/uOVfiIXlVv2yUGhT8bcMrrxsC1nH7WHzaFgd+DA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGb/ZkOIN0mq2KfLS4sUX22ll0XageRdW+wjhKQl43TNGFeo0wFrPDJpO5jyGWYoiUui4+UYneUzVjf2cuUDwy8gcypls+5BZAtaFhBY0121IVWCbDAvzAgIuIEHvzo4umGvWdl3D6o68BXEOQdgemO3UNy9rJzPvlQs3d2ICq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgyxB50PczKHLxw
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 10:22:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 333644057D
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Sep 2026 10:22:28 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgD3KwfiZaNqedIXBg--.6188S2;
	Fri, 11 Sep 2026 10:22:28 +0800 (CST)
Message-ID: <d4b23be7-1ad2-4be1-b789-053501908c4d@huaweicloud.com>
Date: Fri, 11 Sep 2026 10:22:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/26] perf annotate-arm64: Support 'mov' instruction
 tracking
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <6516a18b5618a169c2e180c296632e12c7f6697a.1788872630.git.wutengda@huaweicloud.com>
 <20260908132707.00E341F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908132707.00E341F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgD3KwfiZaNqedIXBg--.6188S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDWw48GFy7CF4xKrWfXwb_yoWrJFWrpa
	n5Cw1rJr4jqr4kWFsxZr4UXF9a9r1fKFs8urn8ta9IvF4akrn5KFZrtFWYvF45Jrn3Cr1j
	qw1vga15Za1UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UE-erUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:27, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Destination register's DWARF lifetime state is improperly preserved during register-to-register 'mov' instruction tracking.
> --
> 
> commit e7b1d4e72b07c94aacdc6e7221ef41f56b7b017c
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Support 'mov' instruction tracking
> 
> Extend update_insn_state_arm64() to support register-to-register and
> immediate-to-register 'mov' instructions. For register-to-register 'mov',
> it propagates data type information from the source to the destination.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index d520975c59363..2f8bedf583c1a 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -810,6 +812,58 @@ static void update_store_insn_state(struct type_state *state,
>>  	adjust_reg_index_state(state, dloc, dl, dst);
>>  }
>>  
>> +static void update_mov_insn_state(struct type_state *state,
>> +				  struct disasm_line *dl,
>> +				  struct annotated_op_loc *src,
>> +				  struct annotated_op_loc *dst)
>> +{
>> +	struct type_state_reg *tsr;
>> +	u32 insn_offset = dl->al.offset;
>> +	int sreg = src->reg1;
>> +	int dreg = dst->reg1;
>> +
>> +	if (!has_reg_type(state, dreg))
>> +		return;
>> +
>> +	tsr = &state->regs[dreg];
>> +	tsr->copied_from = -1;
> 
> [ ... ]
> 
>> +	tsr->type = state->regs[sreg].type;
>> +	tsr->kind = state->regs[sreg].kind;
>> +	tsr->imm_value = state->regs[sreg].imm_value;
>> +	tsr->offset = state->regs[sreg].offset;
>> +	tsr->ok = state->regs[sreg].ok;
>> +	/*
>> +	 * lifetime_active and lifetime_end represent DWARF variable lifetime
>> +	 * ranges tied to the source register. Copying them risks incorrectly
>> +	 * invalidating the destination register after a call instruction,
>> +	 * so intentionally omit them.
>> +	 */
> 
> [Severity: Medium]
> While avoiding copying the source's lifetime, does this leave the
> destination register's existing lifetime values stale?
> 
> If the destination register (dreg) previously had an active DWARF lifetime
> tracking state (lifetime_active = true), those fields are not cleared
> here since invalidate_reg_state() isn't called for this valid register
> transfer path.
> 
> Should lifetime_active be set to false and lifetime_end set to 0?
> 
> Otherwise, the destination register might falsely survive caller-saved
> register invalidations during subsequent call instructions and corrupt
> downstream type inference.
> 

It seems that the scenario I was originally worried about in my comment, where
dreg is incorrectly invalidated, does not exist.

Consider the following three consecutive instructions:

  mov dreg, x0
  call xxxx             // x0 lifetime end
  ldr x1, [dreg, #16]

1. If dreg is a callee-saved register, such as x20, then it is not affected
   by the call instruction, and setting its lifetime to any value will not matter.
2. If dreg is a caller-saved register, such as x1, then it is affected by
   the call instruction, and its lifetime needs to be cleared.

In practice, case 2 is very rare and looks more like undefined behavior, so
only case 1 needs to be considered. In that case, staying consistent with x86
may be the better choice:

  tsr->lifetime_active = state->regs[src->reg1].lifetime_active;
  tsr->lifetime_end = state->regs[src->reg1].lifetime_end;

Given the above, I think we can safely copy the lifetime fields and drop the
original concern.

Thanks,
Tengda

