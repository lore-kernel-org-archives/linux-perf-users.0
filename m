Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D415329C60
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783581953; cv=none; b=POda/06QWq4Zq0jYByJpkYHBy3UJ058Drl2OxpL2xKGG/KEBf8+fB1xj/qC/X2q/EtXv2eshbz+BwfQvkZ6+xdEfNgl+h5t25KMStRd5Z45xEkaKyFH7L1gK8zd0+L4Fl64kJtClMil0OOS4AVxiytiEdmAPXdBq8QjJZFfTyCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783581953; c=relaxed/simple;
	bh=sUsm1a4JPT4mtZxbaX0+hnBbUeTHzi6FXTIhNkY3dfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fJZpkVKjxq2hGkA5/p2P7yREYgLMw8ZQl+D2mDCj1BilM/rK/2BUsELJALBTlXLLEBaWcnl3l1ZameOHQIRBMPb+uLUALDQSgQIaBLR5/N+FUUYWWijsf6atoa1Xfn/8BxmUYMzOk/Z5iAnG2ZC4e89p2AJXod7F7aVtbfntSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gwmhg21pTzYQthn
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 15:25:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A26084057B
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jul 2026 15:25:45 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3qlv4TE9qvNheAg--.16979S2;
	Thu, 09 Jul 2026 15:25:45 +0800 (CST)
Message-ID: <9bbf2ecc-7b3c-41d8-b80f-b7f9dbae6c4f@huaweicloud.com>
Date: Thu, 9 Jul 2026 15:25:44 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] perf annotate-arm64: Support load instruction
 tracking
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-15-wutengda@huaweicloud.com>
 <20260701041445.091681F000E9@smtp.kernel.org>
 <93084002-9ae9-4f8f-a17d-9f580a2d3f2c@huaweicloud.com> <ak9IUXwJdB2Tdfjb@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ak9IUXwJdB2Tdfjb@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3qlv4TE9qvNheAg--.16979S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry3tryUZFy3ZryUJFW5KFg_yoW5GFy3pa
	y7Ca4rGa1jqr4SgrnIqw4rZr9agw4xJF15Wrn8J3sFqFsFyFn3KF93tryakFWrXrWfCr1U
	Z3Wqq3y7Zr4DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/9 15:05, Namhyung Kim wrote:
> On Wed, Jul 01, 2026 at 04:37:52PM +0800, Tengda Wu wrote:
>>
>>
>> On 2026/7/1 12:14, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>>> - [Medium] Missing invalidation of the destination register on type resolution failure during load instruction tracking.
>>> - [Medium] The data type profiling logic ignores the second destination register of load pair (ldp) instructions, leading to stale state retention.
>>> --
>>>
>>> commit 579f01582f34ef50d993c4cb489f025353f8dbcc
>>> Author: Tengda Wu <wutengda@huaweicloud.com>
>>>
>>> perf annotate-arm64: Support load instruction tracking
>>>
>>> This commit extends update_insn_state_arm64() to handle LDR instructions.
>>> It tracks register state changes when data is loaded from memory to registers,
>>> supporting signed offset, pre-index, and post-index addressing modes.
>>>
>>>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>>>> index 48b1c94273eb6..b48545f35620c 100644
>>>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>>>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>>>
>>> [ ... ]
>>>
>>>> +static void update_load_insn_state(struct type_state *state,
>>>> +				   struct disasm_line *dl,
>>>> +				   struct annotated_op_loc *src,
>>>> +				   struct annotated_op_loc *dst)
>>>> +{
>>>> +	struct type_state_reg *tsr;
>>>> +	struct type_state_reg src_tsr;
>>>> +	Dwarf_Die type_die;
>>>> +	u32 insn_offset = dl->al.offset;
>>>> +	int reg_offset;
>>>> +	int sreg = src->reg1;
>>>> +	int dreg = dst->reg1;
>>>
>>> [Severity: Medium]
>>> Does this ignore the second destination register for load pair (ldp)
>>> instructions?
> 
> Right, I think it's better to check "ldr" for this function.  Maybe you
> can add another function for "ldp" to invalidate both registers for now.
> 
> Thanks,
> Namhyung

Yeah, I recently came across a real-world example that requires type annotation
for multiple registers in ldp instructions (from QEMU source code):

	struct KVMSlot {
		hwaddr                     start_addr;           /*     0     8 */
		ram_addr_t                 memory_size;          /*     8     8 */
		void *                     ram;                  /*    16     8 */
		int                        slot;                 /*    24     4 */
		int                        flags;                /*    28     4 */

	0000000000a0d0f0 <kvm_set_user_memory_region.isra.0>:
	a0d10c:       aa0103f3        mov     x19, x1             // x19: KVMSlot *slot
	a0d134:       29430666        ldp     w6, w1, [x19, #24]  // w6: slot->slot, w1: slot->flags

The same pattern also exists in stp (store pair) instructions. We should handle these
cases properly.

Thanks,
Tengda

