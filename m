Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE43438B9
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 03:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786418392; cv=none; b=osggcsn85Obq4YGEMiaKbTbjlg8PA7zLvxkE/4o81DCBuDlrVrLE9tpZRil51E+nOpsVWBqrpzKJK43juNPLldu9u32vPGK2xkRjEk5SNJ8wYi8Gv+CeiCn8gL59YDdVY9WHxFJ5Tjb06d7jkaGaIakbAcmkBRg3+9LzrazXV2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786418392; c=relaxed/simple;
	bh=Ts+vHWukKN8sUEb+E2XiHaq0mJtw5CebvNk7YyVa2H0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lOSIL23sWUN5BYa3d83X4u0AUCSxY7NCH89DWC07OTTHk+7Z0/P4CpKrTCWeVujH+kIDavV5BjAc+aedgmCp7H0Z3lfDOsMC2Fkvc6wsY2cKuJw31Vc5ck33QSZ/eVhDCunnBA2vsLXS/7sFsts8D/EfYxM34ogvMYumg9/IPTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hJxgH6f9kzKHMQW
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 11:19:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 561F940573
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 11:19:39 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBn+R3KlHpqvgCXBw--.2755S2;
	Tue, 11 Aug 2026 11:19:39 +0800 (CST)
Message-ID: <6a62c820-3317-4786-823d-50c0a0349a78@huaweicloud.com>
Date: Tue, 11 Aug 2026 11:19:38 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/23] perf annotate-arm64: Generalize arm64_mov__parse
 to support more instructions
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-4-wutengda@huaweicloud.com>
 <20260808130502.02EA31F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808130502.02EA31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBn+R3KlHpqvgCXBw--.2755S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDur4DJw47uF1rKr15urg_yoW5XF48pw
	47Cws8GF10gr4UKwn3Zrs7XF1S9w17Ja15KFyYy3Z7KrsxCFn7AFn3tF4a9a1rWrs8Cw4j
	vFnYvFyxXFn5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:05, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] arch->objdump.memory_ref_char is uninitialized (0) for ARM64, causing arm64__check_multi_regs() to fail parsing memory operands and creating an out-of-bounds read risk.
> --
> 
> --- Patch [3]: [PATCH v4 03/23] perf annotate-arm64: Generalize arm64_mov__parse to support more instructions ---
> commit 0546b270cb844bdab4fcf529e313bb0ead4fc3f8
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Generalize arm64_mov__parse to support more instructions
>     
> As the default parser for arm64 instructions, arm64_mov__parse()
> currently only supports parsing instructions with the 'addr <symbol>'
> suffix. Other instructions are not supported, causing a lack of
> source and target information for most regular instructions.
>     
> Generalize arm64_mov__parse to extend its parsing capabilities:
> 1. Parse 'ops->target.raw' and 'ops->source.raw' by default.
> 2. Utilize arm64__check_multi_regs() to identify if source and
>    target contain multiple registers.
> 3. Maintain backward compatibility for instructions containing the
>    'addr <symbol>' suffix.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 33080fdca125f..5e824fd617ee5 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> +static bool arm64__check_multi_regs(const struct arch *arch, const char *op)
>> +{
>> +	const char *p = op;
>> +	int reg_count = 0;
>> +
>> +	while (p && *p) {
>> +		p = skip_spaces(p);
>> +		if (*p == arch->objdump.memory_ref_char)
>> +			p++;
> 
> [Severity: Medium]
> Could this result in an out-of-bounds read?
> 
> Since arch->objdump.memory_ref_char is not explicitly initialized for ARM64,
> it defaults to 0. If the operand string contains trailing spaces,
> skip_spaces() will advance p to the null terminator. 
> 
> This would cause the following check to match:
> 
>     if (*p == arch->objdump.memory_ref_char) /* 0 == 0 */
>         p++;
> 
> This increments p past the null terminator, and the subsequent call to
> arm64__is_reg(p) would access unallocated memory:
> 
>     static bool arm64__is_reg(const char *op)
>     {
>         ...
>         if ((op[0] == 'x' || op[0] == 'w') && isdigit(op[1]))
>         ...
> 
> Should memory_ref_char be initialized to '[' for ARM64 so that memory
> operands are correctly parsed?
> 

Agreed. I need to move the initialization of memory_ref_char earlier in this patch.

>> +
>> +		if (arm64__is_reg(p))
>> +			reg_count++;
>> +
> 

