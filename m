Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E183B2FCC
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 06:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889063; cv=none; b=W8eRg5XhY6ox5nXXqFhbtGpRJKAP+jMlv5RHUM09k6X/wqYnBypysMaFJtP60naofqfJnkzFnUIvzhxYhBwFguRWuZ4yxvX/bCRl/LfSu4xM1lvlN4JYm07Gzd0e8pVAFQiG/ObTMO55DmPYi2yY4AmpUpvOv0A6JHodWnv+h6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889063; c=relaxed/simple;
	bh=QrzfUk9xgvcP+uM09kyibkhjt06rXvGK74nHVDv0wc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnwubxmaldITCItqi2IF8zI0ixc0LiOdjcosIvPkBWEa1cl0EsQO7T1KYzvcoctUfkcLFnRZORrJOc219oO0mII91Zs3l50PoM3Lz73Z5OkMJH4F2a/CfqtD7T5eKt2Y/cbhV4i7yWu0l1qLkO1Xh9Mppk9xI8y2M+2oW8P7Abw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gqrRq2dSNzKHLxy
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:57:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 9F82A4058C
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Jul 2026 14:57:36 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgCnFvRfukRqZqnQAQ--.63175S2;
	Wed, 01 Jul 2026 14:57:36 +0800 (CST)
Message-ID: <11bb365f-3e31-4d91-8be1-162dae1936a5@huaweicloud.com>
Date: Wed, 1 Jul 2026 14:57:35 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/21] perf annotate-arm64: Generalize arm64_mov__parse
 to support more instructions
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-5-wutengda@huaweicloud.com>
 <20260701040308.197B11F000E9@smtp.kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260701040308.197B11F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgCnFvRfukRqZqnQAQ--.63175S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW5WF48GFyDJF43GrWDXFb_yoW8KF4xpa
	yv93y5KF4IgrWkKw4fAr43ZFWfWw4fWayfur1rJwn29anFvF18tF97KF42ka15Grs7C3yU
	AanYyry5ZrykCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42
	IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU1QVy3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/1 12:03, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The parsing logic permanently corrupts the raw instruction string buffer (`ops->raw`) when restoring the `<` character after extracting a source symbol name.
> --
> 
> commit 13742d589ccf5a86dcfd0991f541a8f1d46f7e0f
> Author: Tengda Wu <wutengda@huaweicloud.com>
> 
> perf annotate-arm64: Generalize arm64_mov__parse to support more instructions
> 
> This commit generalizes arm64_mov__parse() to parse source and target operands
> for a wider variety of arm64 instructions. It utilizes arm64__check_multi_regs()
> to identify multiple registers while attempting to preserve parsing behavior for
> instructions containing the addr <symbol> suffix.
> 
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 33080fdca125f..a1667237114a6 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
> 
> [ ... ]
> 
>> @@ -14,59 +16,129 @@
>>  static int arm64_mov__parse(const struct arch *arch,
>>  			    struct ins_operands *ops,
>>  			    struct map_symbol *ms __maybe_unused,
>>  			    struct disasm_line *dl __maybe_unused)
>>  {
> 
> [ ... ]
> 
>> +	/* Parse a symbol followed by an address, if present */
>>  	s = strchr(endptr, '<');
>>  	if (s == NULL)
>> -		goto out_free_target;
>> -	endptr = strchr(s + 1, '>');
>> +		return 0;
>> +	endptr = strrchr(s + 1, '>');
>>  	if (endptr == NULL)
>> -		goto out_free_target;
>> +		return 0;
>>  
>>  	*endptr = '\0';
>>  	*s = ' ';
>> -	ops->target.name = strdup(s);
>> +	s = skip_spaces(++s);
>> +	ops->source.name = strdup(s);
>>  	*s = '<';
>>  	*endptr = '>';
> 
> [Severity: Medium]
> Does this code overwrite the first character of the symbol name?
> 
> Because s is advanced by skip_spaces(++s), s now points to the first character
> of the symbol name. When *s = '<' is executed immediately after, it appears to
> corrupt the ops->raw instruction string buffer instead of restoring the '<'
> character at its original position. 
> 
> This could result in a visual glitch in the fallback raw instruction view
> where the first character of the symbol name is overwritten (for example,
> 0x1000 <sym> becomes 0x1000  <ym>).
> 

Agreed.

