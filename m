Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A180B395254
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 07:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786432068; cv=none; b=CUPERo3wKNBiPhh97iU3E/aQjFT3rvtKq3sY07mG4F5uwTYgnecdU97uAM3oGcnU0PTVHO3FonknOTqqyA4VGKPS4iTrc+bWNgRYDoZwjIdskQbhUeSl96eXQX52XKdsrRv01wfAAIW3qqEjHh8fML5Uw8yu9p+stpA7YyHSiM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786432068; c=relaxed/simple;
	bh=d78qSzYRSD06L5dH8dKaGICQIUleLAJ8r+ArZk+eYNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PNlGJEjoX5aQxdcaSPSzXqy9F3F3HG+yArEBEaEabkJsv2Ctk096WnGcsoRyKO+1bvAIHkfIyHHJD6cF7PR4jiIexxbDFn5By3C80XbP/fu3VAj6vyLAXX4AcHpI/mwZiCM4Z82IjxdIjkj+zjB9phD3i8Urr/HWxN9dB2p1qlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hK2kP4QdrzKHMXR
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:07:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 420F84058C
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 15:07:41 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgAnkok7ynpqFUqkBw--.27793S2;
	Tue, 11 Aug 2026 15:07:41 +0800 (CST)
Message-ID: <5ff620e2-3763-4dda-bac8-fefb686b69df@huaweicloud.com>
Date: Tue, 11 Aug 2026 15:07:39 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/23] perf annotate-arm64: Handle load and store
 instructions
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260808122400.2961238-1-wutengda@huaweicloud.com>
 <20260808122400.2961238-5-wutengda@huaweicloud.com>
 <20260808130701.DF40E1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260808130701.DF40E1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnkok7ynpqFUqkBw--.27793S2
X-Coremail-Antispam: 1UD129KBjvJXoWxurWUZry5tr1xCr1kXF1UWrg_yoW5KrW7pa
	1Ykw45Jr1Utr1Fg3Z2qrZxWFySga17Za13Gry8J3ZIkF4S9r1xKF93KF12ka15GrnYyw42
	yFy8tr15AF1kCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
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
> - [Medium] PC-relative loads can be incorrectly parsed and truncated if their associated symbol name or trailing comment contains a bracket '[' (e.g., C++ operator[]).
> - [Medium] The arm64_ldst_ops struct omits a .scnprintf callback, breaking UI formatting for PC-relative loads and discarding resolved symbols.
> --
> 
> --- Patch [4]: [PATCH v4 04/23] perf annotate-arm64: Handle load and store instructions ---
> commit e23857fdcfc409dfdff0cd84b9fe8f31c4283050
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Handle load and store instructions
> 
> Add ldst_ops to handle load and store instructions in order to parse
> the data types and offsets associated with PMU events for memory access
> instructions. Matches instruction prefixes to handle arm64 variants.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 5e824fd617ee5..32752a3bc756b 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> [ ... ]
>> @@ -163,6 +164,108 @@ static const struct ins_ops arm64_mov_ops = {
>>  	.scnprintf = arm64_mov__scnprintf,
>>  };
>>  
>> +static bool arm64__insn_is_source_on_left(struct disasm_line *dl)
>> +{
> [ ... ]
>> +static int arm64_ldst__parse(const struct arch *arch,
>> +			     struct ins_operands *ops,
>> +			     struct map_symbol *ms,
>> +			     struct disasm_line *dl)
>> +{
>> +	char *s, *left, *right;
>> +
>> +	right = s = strchr(ops->raw, arch->objdump.memory_ref_char);
>> +	if (!s) {
>> +		/* Fallback to default parser for PC-relative loads. */
>> +		return arm64_mov__parse(arch, ops, ms, dl);
>> +	}
> 
> [Severity: Medium]
> For PC-relative loads, if the associated symbol name contains a bracket '['
> (such as a C++ operator[] or Objective-C method) or if there is an unstripped
> comment containing a bracket, will this strchr() incorrectly match it instead
> of falling back to arm64_mov__parse()?
> 
> If so, it appears the subsequent string manipulation would use this incorrect
> bracket position, dropping the characters in between and potentially corrupting
> the operands.
> 

Indeed, it appears I need to move rstrip_space_and_comment to the beginning of
the function, processing ops->raw first.

> [ ... ]
>> +	ops->source.multi_regs = arm64__check_multi_regs(arch, ops->source.raw);
>> +	ops->target.multi_regs = arm64__check_multi_regs(arch, ops->target.raw);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct ins_ops arm64_ldst_ops = {
>> +	.parse	   = arm64_ldst__parse,
>> +};
> 
> [Severity: Medium]
> Does omitting a .scnprintf callback here break UI formatting for PC-relative
> loads?
> 
> Because this structure lacks .scnprintf, it will fall back to
> ins__raw_scnprintf(). For PC-relative loads that successfully fall back to
> arm64_mov__parse() and resolve the symbol into ops->source.name, the raw
> formatter will ignore the resolved symbol and just print ops->raw. Could this
> result in the UI discarding the resolved symbol and displaying raw hex
> addresses instead?
> 

Yes, this only affects the display of ldr PC-relative loads, for example:

Expected: ldr x0, <__kvm_nvhe_$d>
Current : ldr x0, ffff800080f40c68 <__kvm_nvhe_$d>

This is not a serious issue, but I will still add the .scnprintf callback
as a follow-up.

