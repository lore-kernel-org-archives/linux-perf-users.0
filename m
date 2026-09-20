Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770232DB78C
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 01:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789868728; cv=none; b=s2rlgobwwu38+I9oSgNBZnep4ObgDrgVqQO5BrvkrWk8wjw7+NhpmJf2InqdCsJf1ye3IwzeL55RpTzSiBwevPwyt22d/1GN+qXr1GhKsbtTzYOg99jkJEF/8dkKi5fvM3Bf54pslVvKs23spkoduY0sJMPhmGQoW14p7v8HhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789868728; c=relaxed/simple;
	bh=eywU9HvzmU28w3afgciwlFLtoo5XnWaSyqQTwuk2Ur8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ArPSMsSydrbbFXUtpMUgVXArEmuWvzUVTEwUHQdQbowD0JGkO2/IU7oqr7Trm6Z5a1VNoMqeGP+sfxhyrr/rIpetLJRDJuvzQwXg0tiDMkQaRi/hVkSrbv6qB0XQ3t0YzcN3PlzDya7iRhU891kGRRncQfLI9ais4zJkFO76Leg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hnTh75GvYzYQv4f
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 09:45:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id BE8BE40561
	for <linux-perf-users@vger.kernel.org>; Sun, 20 Sep 2026 09:45:22 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAn6W2yOq9qTY7FAw--.6195S2;
	Sun, 20 Sep 2026 09:45:22 +0800 (CST)
Message-ID: <0c0c6282-efd6-4baf-9b98-3a5bb72b5067@huaweicloud.com>
Date: Sun, 20 Sep 2026 09:45:22 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 25/26] perf annotate-arm64: Support per-cpu variable
 access tracking
From: Tengda Wu <wutengda@huaweicloud.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1789521520.git.wutengda@huaweicloud.com>
 <735c23b4a55db2c67be4920792922550ff4f6409.1789521520.git.wutengda@huaweicloud.com>
 <20260916015348.2114B1F000FF@smtp.kernel.org>
 <65994196-8dd9-4477-9c4b-3fa485ad3071@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <65994196-8dd9-4477-9c4b-3fa485ad3071@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgAn6W2yOq9qTY7FAw--.6195S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr48Ww17JFW7AF1ruw18Grg_yoW5tr4rp3
	9Yka48Gw10qr4Fg3Zava1Yqa4F9w17WayS9ryrtw17ZFyIkrn3GFZrKr4YkF4UXFZ3Cw4U
	twsYqrWDXw1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02
	F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4I
	kC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/17 10:16, Tengda Wu wrote:
> 
> 
> On 2026/9/16 9:53, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] perf: retry mechanism fails for per-cpu variable loads
>> --
>>
>> commit 0a8000b94df79930832d6fd4535fbe42f682b339
>> Author: Tengda Wu <wutengda@huaweicloud.com>
>>
>> perf annotate-arm64: Support per-cpu variable access tracking
>>
>> This commit extends update_insn_state_arm64() to handle per-cpu variable
>> addressing. It detects pairs resolving to the '__per_cpu_offset' symbol
>> and marks the destination register as TSR_KIND_PERCPU_BASE to propagate
>> type information during subsequent instructions.
>>
>>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>>> index b25a3c70675c1..f4b7b0eb44f42 100644
>>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> [ ... ]
>>> @@ -666,6 +677,12 @@ static int propagate_load_reg_state(struct type_state *state,
>>>  	}
>>>  
>>>  load_non_regoff:
>>> +	/*
>>> +	 * If src_tsr->kind is TSR_KIND_PERCPU_BASE, treat it as an array.
>>> +	 * No special handling is needed here; just fall through to retry
>>> +	 * and resolve the type from the second register.
>>> +	 */
>>> +
>>>  	/* Try another register if any */
>>>  	if (src->multi_regs && src->reg1 != src->reg2 && sreg != src->reg2 &&
>>>  	    !(src->extend_type || src->shift_type)) {
>>
>> [Severity: Medium]
>> Will this retry logic actually succeed for per-cpu variable loads?
>>
>> Since both registers in the per-cpu load are non-constant
>> (TSR_KIND_PERCPU_BASE and TSR_KIND_GLOBAL_ADDR), arch_get_reg_offset()
>> returns -1 for both the initial attempt and the retry pass because it
>> requires the 'other' register in a multi-register operand to be
>> TSR_KIND_CONST.
>>
>> Does this break the intended fallback logic here in
>> propagate_load_reg_state(), resulting in an unhandled -1 return and
>> silent type propagation failure?
>>
> 
> It looks like arch_get_reg_offset needs to be extended to recognize when
> reg2 is TSR_KIND_PERCPU_BASE and set the offset to 0.
> 

I might change it to something like this:

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index cfdebd50fb0d..ab86037aa527 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1188,13 +1188,17 @@ int arch_get_reg_offset(const struct arch *arch, struct annotated_op_loc *op_loc
 
 		/*
 		 * For register-based addressing without shift/extension,
-		 * reg2 may be a constant offset. Use its value as the offset
-		 * from the base register.
+		 * derive the offset from the type of reg2.
 		 */
 		reg2 = op_loc->reg1 == breg ? op_loc->reg2 : op_loc->reg1;
-		if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
-			state->regs[reg2].kind == TSR_KIND_CONST) {
-			*offset = (s64)state->regs[reg2].imm_value;
+		if (has_reg_type(state, reg2) && state->regs[reg2].ok) {
+			if (state->regs[reg2].kind == TSR_KIND_CONST)
+				*offset = (s64)state->regs[reg2].imm_value;
+			else if (state->regs[reg2].kind == TSR_KIND_PERCPU_BASE)
+				*offset = 0;  /* it does not contribute to the offset */
+			else
+				return -1;
+
 			return 0;
 		}

Thanks,
Tengda

