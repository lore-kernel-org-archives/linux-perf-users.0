Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8D8411689
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 08:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786435827; cv=none; b=KoxtZBtPQDZN7MssVZKBYGJS6ZqYY0/HW0V2KhM9rYEaPFX4yXlXBH92a/rqYEnITpTzU/kh3MHSyxJ2RUThHznw9b/rg1ezHUWQ+ThxyOfrShh9URznFz8Wx9R3nYB4bceRHn5y60CfUxzlLh+TDHZaRI5EHr9xJK8Zgn7wUUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786435827; c=relaxed/simple;
	bh=5p+navuV7D6IYh3+/liSGmyyN6jCn+Kbnk5GDF6fHJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fa9AqYWumVAgVTqlnmf7QHvfjGR8ttCKrE87RZotU3aZepy6ktL5hXehGBEzEwkEXz7tckmV+RYoXiFE59KvfkByfeo89p+HOPUBxBTf3ec/uVx3i1GkOELy9A7b0wK31iFt4T9g+l5cEvhK888O8ZBU/vf5zbJrtAONTZxnCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hK46w5CjwzYQtpW
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:10:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id A46B440561
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 16:10:18 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgBH2R3p2Hpq5iawBw--.5771S2;
	Tue, 11 Aug 2026 16:10:18 +0800 (CST)
Message-ID: <54a84f96-8ce8-4288-b0e1-dbbe2d8edce3@huaweicloud.com>
Date: Tue, 11 Aug 2026 16:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-7-wutengda@huaweicloud.com>
 <20260808130708.749031F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808130708.749031F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBH2R3p2Hpq5iawBw--.5771S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurykXFW5CrykCF17Gw4fGrg_yoWrJFWrpa
	1fu3W3JF1UtrW8KwsxXw4rWFy5Kw4fGF1rZr4kG3W2krZrur9Yya1ftF4Y9a4rJrs8Gw40
	yw4jqF18ur1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/8 21:07, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] The patch's fix to enable arm64 register parsing is unreachable and ineffective because the callers still unconditionally require a register prefix.
> - [Medium] The new optional prefix logic in `arch__dwarf_regnum()` fails to strip the opening bracket from memory operands.
> --
> 
> --- Patch [6]: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for arm64 ---
> commit 1ed2e0e5199a9033fdb64817a106aecaa0871796
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate: Adapt arch__dwarf_regnum() for arm64
> 
> This commit makes the register prefix check in arch__dwarf_regnum() optional
> to support arm64 assembly syntax. It also extends the delimiter set in
> strpbrk() to handle bracketed memory operands and removes the static
> qualifier from arch__dwarf_regnum().
> 
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index df70e95a84704..9d8b4d6b859b8 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
> 
> [ ... ]
> 
>> @@ -2472,21 +2472,23 @@ int annotate_check_args(void)
>>  	return 0;
>>  }
>>  
>> -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
>> +int arch__dwarf_regnum(const struct arch *arch, const char *str)
> 
> [Severity: Medium]
> Does this change fully enable arm64 register parsing?
> 
> Looking at the callers of arch__dwarf_regnum(), they appear to still
> unconditionally enforce the presence of a register prefix character.
> 
> For example, extract_reg_offset() checks:
> 
>     if (arch->objdump.register_char == 0)
>         return -1;
> 
> And annotate_get_insn_location() strictly requires a match:
> 
>     if (*s == arch->objdump.register_char) {
>         op_loc->reg1 = arch__dwarf_regnum(arch, s);
>     }
> 
> Will these un-updated callers prevent arm64 registers from actually being
> parsed?
> 

This seems to be a patch ordering problem. I performed arm64 adaptation
for the above functions too early, before exporting the arch-specific
extract_op_location callback. As a result, sashiko flagged those call
sites which are only used by x86 logic. If I reorder the patches by
moving the current 0007 patch earlier, it should avoid these warnings:

Reorder: 0007 => 0005 => 0006 => 0008
Where:
  0005 perf annotate: Adapt arch__dwarf_regnum() for arm64
  0006 perf dwarf-regs: Adapt get_dwarf_regnum() for arm64
  0007 perf annotate: Introduce extract_op_location callback for arch-specific parsing
  0008 perf annotate-arm64: Implement extract_op_location() callback

>>  {
>> -	const char *p;
>> +	const char *p = str;
>>  	char *regname, *q;
>>  	int reg;
>>  
>> -	p = strchr(str, arch->objdump.register_char);
>> -	if (p == NULL)
>> -		return -1;
>> +	if (arch->objdump.register_char) {
>> +		p = strchr(str, arch->objdump.register_char);
>> +		if (p == NULL)
>> +			return -1;
>> +	}
>>  
>>  	regname = strdup(p);
>>  	if (regname == NULL)
>>  		return -1;
>>  
>> -	q = strpbrk(regname, ",) ");
>> +	q = strpbrk(regname, ",)] ");
> 
> [Severity: Medium]
> Since the prefix check is now optional, will p point to the opening bracket
> for arm64 memory operands like [x2, #8]?
> 
> This strpbrk() strips the closing bracket ], but is there logic to strip the
> leading [ before the string is passed to get_dwarf_regnum()? Can this pass
> [x2 as the register name and cause it to be rejected?
> 
>>  	if (q)
>>  		*q = '\0';
>>
> 

I don't consider this an issue. Even if '[x2' is mistakenly passed as
the register name, get_dwarf_regnum() will reject the invalid register
string, which prevents the problem from spreading further.

