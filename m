Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1B53C9EE4
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 08:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030161; cv=none; b=bAoOS3eskIBWRwG0nBck9ykihgIHDZNUlDZGTd9deH/hxCOq7edPy4JAW4JJ2f0k/VRmF7T0K92dVaKVae1tERyRXtBsFD3ZYNmi/lZeK2JUOCXeo+KgSzh+pxhK2MW3Ljfb7eno+8ENv5E9BfFkXQLQ4PIok/dxnTVNfusY4gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030161; c=relaxed/simple;
	bh=J033PCiMOxnV7knooqln9XgPiYoGqSr3IbjX/40RntM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rYflGmuA/syUGwU/vjNzgDoX2Vo3eLcG7seoeOi1+IQAdWJPzm++dMXlCp5CQ3TPi/616z7N7tCSUnTczK3fjgz2Ph/hWVQIBOH4ppj3LEYZlf0gNk7omqQkdC4uVMiN4SYhDQacoF/+JYgcIcsDI98LIfKQS75KveDuV23Vi5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hgWXw2WdzzYQwX1
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 16:48:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 036FF40576
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 16:49:11 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgDXgpAFb6JqcmrMBQ--.43634S2;
	Thu, 10 Sep 2026 16:49:10 +0800 (CST)
Message-ID: <b047409f-2132-4afd-9b0f-511d689fcba8@huaweicloud.com>
Date: Thu, 10 Sep 2026 16:49:09 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/26] perf annotate-arm64: Implement
 extract_op_location() callback
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <73c9999d6089cd754ec5df65d1cca97ce3797b8d.1788872630.git.wutengda@huaweicloud.com>
 <20260908131835.EB14B1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260908131835.EB14B1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXgpAFb6JqcmrMBQ--.43634S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDKr43Cry7CrW3tF15XFb_yoWrXF4xpF
	47u34jqF1UJw4DKa47X395Was3Kw4xWa4DKw15X3ZIyFsxZF4rJasxtw12gFy8Crn3uw4j
	yFsYqr17Xrn0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/9/8 21:18, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] Shift and extension modifiers are silently ignored for single-register operands in extract_op_location_arm64().
> --
> 
> commit e285d74ff460ca1f5c334760a2efdd0b26f56319
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Implement extract_op_location() callback
> 
> This commit implements the extract_op_location() callback for the arm64
> architecture to handle its specific assembly syntax and addressing modes.
> This enables perf annotate to resolve memory locations and register types
> for data type profiling.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index a7595a954cfae..d8a5904359b1a 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> +static void extract_op_location_arm64(const struct arch *arch,
>> +				      struct disasm_line *dl __maybe_unused,
>> +				      const char *op_str, int op_idx __maybe_unused,
>> +				      struct annotated_op_loc *op_loc)
>> +{
>> +	const char *s = op_str;
>> +	char *p = NULL;
>> +
>> +	if (op_str == NULL)
>> +		return;
>> +
>> +	/*
>> +	 * Handle immediate operand.
>> +	 * e.g., "#0xc600" -> offset = 0xc600, imm = true
>> +	 *
>> +	 * After parsing, check for post-modifiers like "lsl #16", which
>> +	 * typically occur in instructions such as movk, movz, movn, etc.
>> +	 */
>> +	if (*s == arch->objdump.imm_char) {
>> +		op_loc->offset = strtol(s + 1, &p, 0);
>> +		if (p && p != s + 1) {
>> +			op_loc->imm = true;
>> +			s = p;
>> +		}
>> +		goto check_modifiers;
>> +	}
>> +
> 
> [ ... ]
> 
>> +	/* Extract the primary register */
>> +	op_loc->reg1 = arch__dwarf_regnum(arch, s);
>> +	if (op_loc->reg1 == -1)
>> +		return;
>> +
>> +	/* Move to the next operand field, if present */
>> +	s = strchr(s, ',');
>> +	if (s == NULL)
>> +		return;
>> +	s = skip_spaces(s + 1);
>> +
>> +	/* Extract secondary register or immediate offset */
>> +	if (op_loc->multi_regs)
>> +		op_loc->reg2 = arch__dwarf_regnum(arch, s);
>> +	else if (*s == arch->objdump.imm_char)
>> +		op_loc->offset = strtol(s + 1, NULL, 0);
>> +
>> +check_modifiers:
>> +	/*
>> +	 * Look for a following shift or extension modifier:
>> +	 *   ", lsl #3"   -> extend_type = PERF_EXT_NONE,
>> +	 *                   shift_type = PERF_SHIFT_LSL, amount = 3
>> +	 *   ", uxtw #3"  -> extend_type = PERF_EXT_UXTW,
>> +	 *                   shift_type = PERF_SHIFT_LSL, amount = 3
>> +	 *   ", uxtw"     -> extend_type = PERF_EXT_UXTW,
>> +	 *                   shift_type = PERF_SHIFT_LSL, amount = 0
>> +	 */
>> +	s = strchr(s, ',');
>> +	if (s == NULL)
>> +		return;
> 
> [Severity: Medium]
> Will this silently ignore shift and extension modifiers for single-register
> operands in extract_op_location_arm64()?
> 
> When perf annotate processes an instruction like "cmp x0, x1, lsl #3", the
> source operand string is parsed as "x1, lsl #3". During primary register
> extraction, the pointer 's' is advanced past the first comma to point
> directly at "lsl #3".
> 
> Because multi_regs is false and the operand is not an immediate, execution
> falls through to the check_modifiers block. At this point, the string is
> just "lsl #3". The strchr(s, ',') search will fail and the function returns
> early without parsing the modifier.
> 
> Could this lead to missing annotations and incomplete statistics for these
> instructions during data type profiling?
> 

Yes, that's indeed a problem. It doesn't affect instruction tracking for now,
but it does need to be fixed. I'll fix it.

Thanks,
Tengda

>> +	s = skip_spaces(s + 1);
>> +
>> +	op_loc->extend_type = arm64__check_ext_type(s);
>> +	op_loc->shift_type = arm64__check_shift_type(s);
>> +	/* ARM64 extended operands are implicitly shifted by LSL. */
>> +	if (op_loc->extend_type != PERF_EXT_NONE)
>> +		op_loc->shift_type = PERF_SHIFT_LSL;
> 

