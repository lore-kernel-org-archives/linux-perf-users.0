Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671D830B529;
	Fri, 14 Aug 2026 01:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670816; cv=none; b=uzJdN1kkIrnjxl9vLDLOcuIFBRu0r2D0xbdy/GuQ+hwkUzPFS4gNCRTkwZJsqWiGQcgKniLt1yjSJJp6pN4lu81kte1Be7aFuloqq5V//nTdHx+joB9JK3ojnmYNaVs0l6l1WKlnJk4yPWNhoM+4vcCbrWWxYonIPzoLfOi5GI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670816; c=relaxed/simple;
	bh=V3rWI9jA0wMM8U1vUnTXGa5YoYwqLQySxK32mZpgqOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cY+9LDcA844TBMGDYAGDe0JXgqx+Pnicm6NF+dMhldXmbTgs3DxZe0JqtCgH4xU5Us4vv/eA1qFDlexoJLPqYTWC2Du6Fa1kFKmsNiOd6Iy4rJrKcd4bkX2o/mAWRkBkZLIjbf3xzpLdpqo+zVHSEs5ZTPRNbUwnF2+acuzVc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hLl1b2F7dzKHMVf;
	Fri, 14 Aug 2026 09:26:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 7882A4058F;
	Fri, 14 Aug 2026 09:26:47 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnUYnVbn5q0SL6CA--.26171S2;
	Fri, 14 Aug 2026 09:26:47 +0800 (CST)
Message-ID: <10c30d77-9104-4825-b581-6514a0ec5010@huaweicloud.com>
Date: Fri, 14 Aug 2026 09:26:45 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/23] perf annotate-arm64: Support store instruction
 tracking
To: Shuai Xue <xueshuai@linux.alibaba.com>, Namhyung Kim
 <namhyung@kernel.org>, james.clark@linaro.org,
 Li Huafei <lihuafei1@huawei.com>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Ian Rogers <irogers@google.com>, Kim Phillips <kim.phillips@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-16-wutengda@huaweicloud.com>
 <0b47de5a-b46a-4904-93a1-f6d315336a30@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <0b47de5a-b46a-4904-93a1-f6d315336a30@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgDnUYnVbn5q0SL6CA--.26171S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW8KFW5AFWkWw43ArW8WFg_yoWrWw1xpF
	Wvk3y5tFWjyr4kKrnxGF4UXFyakw1xJw1DGr18ta1UArW7trnYgF4qgF4jgFW3JrWxCr1U
	tr4qgr1DZr4UAw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/11 16:00, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to handle store (STR) instructions.
>>
>> Unlike load instructions, a store instruction sets a value in the struct
>> within the memory where the destination register resides, and does not
>> alter its type. Therefore, no processing is required for the transfer.
>>
>> The only point to note is that store instructions support pre-index and
>> post-index addressing modes, so calling adjust_reg_index_state() is still
>> necessary to handle their addressing.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   tools/perf/util/annotate-arch/annotate-arm64.c | 13 ++++++++++++-
>>   1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 6557c0ad11b2..ed0f0ef2877d 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -560,7 +560,7 @@ static void update_insn_state_arm64(struct type_state *state,
>>        * prevent stale type info from propagating to subsequent instructions.
>>        */
>>       if (has_reg_type(state, dst->reg1) &&
>> -        strncmp(dl->ins.name, "ld", 2)) {
>> +        strncmp(dl->ins.name, "ld", 2) && strncmp(dl->ins.name, "st", 2)) {
>>           pr_debug_dtp("%s [%x] invalidate reg%d",
>>                    dl->ins.name, insn_offset, dst->reg1);
>>           invalidate_reg_state(&state->regs[dst->reg1]);
>> @@ -575,6 +575,17 @@ static void update_insn_state_arm64(struct type_state *state,
>>       /* Memory to register transfers */
>>       if (!strncmp(dl->ins.name, "ld", 2))
>>           update_load_insn_state(state, dl, src, dst);
>> +    /* Register to memory transfers */
>> +    else if (!strncmp(dl->ins.name, "st", 2)) {
>> +        /*
>> +         * Ignore transfers since it'd set a value in a struct
>> +         * and won't change the type.
>> +         *
>> +         * Needs to update the pre-index and post-index addressing
>> +         * modes for the destination register.
>> +         */
>> +        adjust_reg_index_state(state, dst, "str", insn_offset);
>> +    }
> Two points on this call:
> 
> First, adjust_reg_index_state() gets post-index with a register
> writeback amount wrong, e.g. str x1, [x0], x2. There the memory
> operand has multi_regs set (x0 and x2), so reg2 gets the offset
> register and op_loc->offset stays 0. The adjustment then degenerates
> to offset += 0, and the base keeps its old type and offset while in
> reality it moved by an unknown amount - every later access through it
> resolves to the wrong struct field. Pre-index is fine since
> [base, reg]! isn't a valid encoding, but the post-index register form
> should fall back to invalidating the base:
> 
>     if (op_loc->multi_regs) {
>         invalidate_reg_state(tsr);
>         return;
>     }
> 

The manual says that "[base], reg" is only used in SIMD instructions,
and since SIMD is not currently supported, the impact is limited.
However, for the sake of accuracy, I will add this check. Thank you.

> This applies to the load path too since it shares
> adjust_reg_index_state().
> 
> Second, a nit: the insn name is hardcoded to "str", so stp/stlr and
> pre/post-indexed variants all print as "str" in the debug output.
> Pass dl->ins.name instead.
> 

I referred to the x86 approach here (x86 also does not distinguish specific
instruction names; for example, all mov* variants are printed as "mov").
Originally, I only intended to distinguish between the two categories, ldr
and str. Of course, using the specific instruction name is not a problem,
and I will fix it accordingly.

Thanks,
Tengda

