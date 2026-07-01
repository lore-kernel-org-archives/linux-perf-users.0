Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095331A9F97
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889426; cv=none; b=Re3tYKuFBl2eStxJIcklqgMqTPODqH6suYUOSIep3Ky1VrzJD5laBrTLcC165pJ0KyyNX+OP0VZP3U6W3zRi0PoJqc2aHEgVa5kzYR4eMfDtzvqaST73Ep9/XNhh1xGBLAJVfkfrOQC+pECtsDgUshZcCamU3QxQdn2Dy+UiyRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889426; c=relaxed/simple;
	bh=Th5KTdau7VLuHn2llC/qGKznEk8TdDw/UlVxSUSlgvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q4g56LiYCFds3cX46QlAcpakZF/3PIPyVRxcZYtBH/AzAeKyFXOiM7c7M8/bWKV2/1Ul6AcSaDqxOUyVs8+nt4ZZRQ6GEx0L0ERJnuBzwL97ThNZs2x0Ii4AZC4m22lpmVgJLKDOC64ofiLTyAwXqUXGVIqMhYQ4GeULHLp4tiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqrZr09JTzKHLxJ
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:03:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4BDF54058F
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 15:03:41 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCHuyXNu0RqJzfNAQ--.55984S2;
	Wed, 01 Jul 2026 15:03:41 +0800 (CST)
Message-ID: <5ce1e9d8-9958-47c8-80b6-776cfcd29d81@huaweicloud.com>
Date: Wed, 1 Jul 2026 15:03:40 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/21] perf annotate-arm64: Handle load and store
 instructions
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-6-wutengda@huaweicloud.com>
 <20260701040736.886DD1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040736.886DD1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCHuyXNu0RqJzfNAQ--.55984S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDZr4rJFyrCrWfKFyDZFb_yoW5uFyxpa
	yvya45JF1Utr4Ig3Z3Ar4fWF9agw47Aa45C348tasakrnY9F4rGF97KrW7CFWrGry5u3yU
	Zr4qvr15AF1kCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUglb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVF
	xhVjvjDU0xZFpf9x07UWHqcUUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] arm64_ldst__parse fails to parse PC-relative load instructions, breaking operand extraction for literal pool loads.
> - [Medium] Failure to strip inline comments before parsing operands allows comments to corrupt `multi_regs` evaluation.
> --
> 
> commit 9939a67ebc615cf049eb33c68f83aa3646abb3f0
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Handle load and store instructions
> 
> This commit adds ldst_ops to parse data types and offsets for ARM64 memory
> access instructions using regex prefix matching.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index a1667237114a6..451500def8c12 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -141,6 +142,104 @@ static const struct ins_ops arm64_mov_ops = {
> [ ... ]
>> +static int arm64_ldst__parse(const struct arch *arch,
>> +			     struct ins_operands *ops,
>> +			     struct map_symbol *ms __maybe_unused,
>> +			     struct disasm_line *dl)
>> +{
>> +	char *s, *left, *right;
>> +
>> +	right = s = strchr(ops->raw, arch->objdump.memory_ref_char);
>> +	if (!s)
>> +		return -1;
> 
> [Severity: Medium]
> Will this fail to parse PC-relative load instructions?
> 
> When processing a PC-relative load instruction (e.g., ldr x0, 4005c0 <sym>),
> the 'ld' prefix matches the new ldst_insn regex in arch__new_arm64() and
> routes it to arm64_ldst__parse().
> 
> Since PC-relative loads lack a bracket ('['), strchr() will return NULL,
> causing the function to immediately return -1. Does this leave operands
> unpopulated and break annotation features like data type tracking for
> literal pool loads?
> 

Agreed. I overlooked this type of PC-relative load:
  ldr     x0, ffff800080f40c68 <__kvm_nvhe_$d>

>> +
>> +	while (s > ops->raw && *s != ',')
>> +		--s;
>> +
>> +	if (s == ops->raw)
>> +		return -1;
>> +
>> +	*s = '\0';
>> +	left = strdup(ops->raw);
>> +
>> +	*s = ',';
>> +	if (!left)
>> +		return -1;
>> +
>> +	right = strdup(right);
>> +	if (!right) {
>> +		zfree(&left);
>> +		return -1;
>> +	}
>> +
>> +	if (arm64__insn_is_source_first(dl)) {
>> +		ops->source.raw = left;
>> +		ops->source.mem_ref = false;
>> +
>> +		ops->target.raw = right;
>> +		ops->target.mem_ref = true;
>> +		ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
> 
> [Severity: Medium]
> Does this code incorrectly include inline comments when evaluating multi_regs?
> 
> The string duplicated into 'right' includes trailing comments from the raw
> operand string because they are not stripped prior to parsing.
> 
> If objdump outputs an inline comment containing a comma and a string
> resembling a register name (for example: // read, x2), could
> arm64__check_multi_regs() wrongly flag the operand as having multiple
> registers and corrupt data type profiling?
> 

Agreed.

>> +	} else {
>> +		ops->source.raw = right;
>> +		ops->source.mem_ref = true;
>> +		ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
>> +
>> +		ops->target.raw = left;
>> +		ops->target.mem_ref = false;
>> +	}
>> +
>> +	return 0;
>> +}
> 

