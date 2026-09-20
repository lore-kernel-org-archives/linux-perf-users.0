Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20ADF342C80
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 01:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868626; cv=none; b=TFSK59Q1tnAaK0/kV/w12Jwjif6vz6mnvXaj8EiDh3t0WxzA2Rfcp479j7W7aptczmyjNIoojHHE4bv/jLVAI9eleTv8AXAwb0X1Bc2PwLhq+da0bRp/BZE4B9DDmOhqKAgqqIhXJAbHVy8JCZm8Sj76qWus/8eEyoMcWYwk5+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868626; c=relaxed/simple;
	bh=JcLZFNI3VGRMF6PwrCtxFSiJyl1RlJD9oq+0wkj1+2M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u43OlcMqvslqKCjwAUZP7VhTdALxAwomCt0vAsyNcNrVRqKzAXFj7svFPG0tDO0LUqsWfb+IpVS32eJZMgj8mwu48YdfEE/sG4dobDvPsmaXedVpA9IGeVxsICOrxUR693o7fOhyNzdXtUjjcImCdU8BYUvlN5rNhLEgkJQVBNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hnTf22f9KzYQv6G
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 09:43:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 642184056B
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 09:43:33 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgD3KhJEOq9qRdrNAw--.56231S2;
	Sun, 20 Sep 2026 09:43:33 +0800 (CST)
Message-ID: <d63b72f8-0953-455a-b296-9eb599f00f25@huaweicloud.com>
Date: Sun, 20 Sep 2026 09:43:32 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 21/26] perf annotate-arm64: Support stack variable
 tracking
From: Tengda Wu <wutengda@huaweicloud.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <11bcde1a75d96b524cc5a7f6fa442025680e56a0.1789521520.git.wutengda@huaweicloud.com>
 <20260916014905.D44C91F000FF@smtp.kernel.org>
 <e1021204-6e4a-4767-889e-fd677409df1e@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <e1021204-6e4a-4767-889e-fd677409df1e@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgD3KhJEOq9qRdrNAw--.56231S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48Wr4kXFy5tF13Cw13twb_yoWrJw45pF
	WDCa45Wrs7Jr109FnrXr4xXr98uw1xKF1S9r98Xan7tFnFyrnIka93Kayj9FWUGrWkCw12
	yw4v9rs8XFZakaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/16 19:55, Tengda Wu wrote:
> 
> 
> On 2026/9/16 9:49, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] perf: stale stack state due to bypassed invalidation in update_store_insn_state
>> --
>>
>> commit 2ddb0f384d44eeb70844d8c3adc06f8d55101f68
>> Author: Tengda Wu <wutengda@huaweicloud.com>
>>
>> perf annotate-arm64: Support stack variable tracking
>>
>> Extend update_insn_state_arm64() to track data types stored on the stack. The
>> implementation handles stack loads and stores to follow data types as they
>> move between registers and memory.
>>
>>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>>> index a72c7703dd6b3..8339aab0d314f 100644
>>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> [ ... ]
>>> +/*
>>> + * For store insns: propagate type from @sreg to the memory location referenced
>>> + * by @dst, applying @mem_spacing to account for multi-regs stores (e.g. stp).
>>> + */
>>> +static void propagate_store_reg_state(struct type_state *state,
>>> +				      struct data_loc_info *dloc,
>>> +				      struct disasm_line *dl, int sreg,
>>> +				      struct annotated_op_loc *dst,
>>> +				      int mem_spacing)
>>> +{
>> [ ... ]
>>> +		if (!has_reg_type(state, sreg) || !state->regs[sreg].ok) {
>>> +			stack = find_stack_state(state, offset);
>>> +			/* Preserve compound states when only a member is overwritten. */
>>> +			if (stack && !stack->compound)
>>> +				delete_stack_state(state, offset);
>>> +
>>> +			return;
>>> +		}
>> [ ... ]
>>> +static void update_store_insn_state(struct type_state *state,
>>> +				    struct data_loc_info *dloc,
>>> +				    struct disasm_line *dl,
>>> +				    struct annotated_op_loc *src,
>>> +				    struct annotated_op_loc *dst)
>>> +{
>>> +	int mem_spacing = 0;
>>> +
>>> +	if (!has_reg_type(state, dst->reg1))
>>> +		return;
>>> +
>>> +	/* Handle the first source register */
>>> +	if (has_reg_type(state, src->reg1))
>>> +		propagate_store_reg_state(state, dloc, dl, src->reg1,
>>> +					  dst, mem_spacing);
>>> +
>>> +	if (!src->multi_regs || !has_reg_type(state, src->reg2))
>>> +		goto out_adjust;
>>
>> [Severity: Medium]
>> Does the has_reg_type() guard here inadvertently skip the stack state
>> invalidation logic?
>>
>> Looking at propagate_store_reg_state() above, there is logic to delete the
>> stack state if the source register is untracked. However, because
>> update_store_insn_state() completely bypasses the call to
>> propagate_store_reg_state() when the source register is untracked, this
>> cleanup is never reached.
>>
>> If an untracked register is stored into a stack slot previously used for a
>> tracked variable, could this leave stale tracking state on the stack, causing
>> subsequent loads from that slot to inherit the wrong type?
>>
> 
> Agreed.

I might change it to something like this:

+static void update_store_insn_state(struct type_state *state,
+				    struct data_loc_info *dloc,
+				    struct disasm_line *dl,
+				    struct annotated_op_loc *src,
+				    struct annotated_op_loc *dst)
+{
+	int mem_spacing = 0;
+
+	if (!has_reg_type(state, dst->reg1))
+		return;
+
+	/* Handle the first source register */
+	propagate_store_reg_state(state, dloc, dl, src->reg1, dst, mem_spacing);
+
+	/* Handle the second source register (if any) */
+	if (src->multi_regs) {
+		mem_spacing = arm64__reg_size(dl->ops.source.raw);
+
+		if (mem_spacing >= 0)
+			propagate_store_reg_state(state, dloc, dl, src->reg2,
+						  dst, mem_spacing);
+	}
+
+	adjust_reg_index_state(state, dloc, dl, dst);
+}

Thanks,
Tengda

