Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25B937C0FA;
	Fri, 10 Apr 2026 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815573; cv=none; b=WXHn/nIa8xmec7PNzHOUxHiE2Qbxzol7zmUpfduKlE7DGCtDwLhjTKirlQ8G7m83P6b8f0jwcep6yN4L+Nw8zC5Zr8bjNuxJuMXc1ip5pJmiVHhbE+UmHt7uRCYxYqOV5d997Jwl8GFGvFhcM9TUAWV0W6nUm+jFJbBK0FnvGrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815573; c=relaxed/simple;
	bh=rh9fL/nAkhFCpcLjNMoyr+9oHMrRy9l4qTjAXEOZCfc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJBUmN//NZwxy25bkJi2X43qr48p8MW24RGOFEsrivry1yusTU4JnvmDUos6ELTqtHk5moYSkzOsIDC66xxRFjfXVC83rptO5/m3RkchmyxD1HZ/+bZWaxenY5YTE9dCc/Na5IjHLKSVhl5wvxlJj4Y3/JJMFkZptJIN7S976mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsXWK4nJXzKHMSf;
	Fri, 10 Apr 2026 18:06:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4A9BD40575;
	Fri, 10 Apr 2026 18:06:07 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgCXmtqNy9hpevo1EA--.235S2;
	Fri, 10 Apr 2026 18:06:07 +0800 (CST)
Message-ID: <a94a11c8-2614-4dac-8d87-94a7f9e2e157@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:06:05 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] perf annotate-arm64: Generalize arm64_mov__parse
 to support standard operands
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, leo.yan@linux.dev,
 Li Huafei <lihuafei1@huawei.com>, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260403094800.1418825-1-wutengda@huaweicloud.com>
 <20260403094800.1418825-4-wutengda@huaweicloud.com> <adSrL-iZna3pyDrY@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adSrL-iZna3pyDrY@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgCXmtqNy9hpevo1EA--.235S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFWxAr1DWFyrKw4fuF45Wrg_yoW7Gr48pw
	4qka45KF48trZ5Kw4aqa10qFy3Wwn2g3y7CF1xt3WrA3ZIkFyrKF43Kr12kFs3CFyxC3y8
	AFnYvr1UGrs8GFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	s2-5UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/7 14:58, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:47AM +0000, Tengda Wu wrote:
>> The current arm64_mov__parse() implementation strictly requires the
>> operand to contain a symbol suffix in the "<symbol>" format. This
>> causes the parser to fail for standard instructions that only contain
>> raw immediates or registers without symbolic annotations.
>>
>> Refactor the function to make symbol matching optional. The parser now
>> correctly extracts the target operand and only attempts to parse the
>> "<symbol>" suffix if it exists. This change also introduces better
>> handling for whitespace and comments, and adds support for multi-register
>> check via arm64__check_multi_regs(), ensuring compatibility with a
>> wider range of arm64 instruction formats.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 85 ++++++++++++++-----
>>  1 file changed, 65 insertions(+), 20 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 33080fdca125..4c42323b0c18 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -14,12 +14,38 @@ struct arch_arm64 {
>>  	regex_t jump_insn;
>>  };
>>  
>> +static bool arm64__check_multi_regs(const char *op)
>> +{
>> +	char *comma = strchr(op, ',');
>> +
>> +	while (comma) {
>> +		char *next = comma + 1;
>> +
>> +		next = skip_spaces(next);
>> +
>> +		/*
>> +		 * Check the first valid character after the comma:
>> +		 * - If it is '#', it indicates an immediate offset (e.g., [x1, #16]).
>> +		 * - If it is an alphabetic character, it is highly likely a
>> +		 *   register name (e.g., x, w, s, d, q, v, p, z).
>> +		 * - Special cases: Alias and control registers like sp, xzr,
>> +		 *   and wzr all start with an alphabetic character.
>> +		 */
>> +		if (*next && *next != '#' && isalpha(*next))
>> +			return true;
> 
> It seems you check any alphabet charactor after a comma for multi-regs.
> Does that mean the first component before the comma should be another
> register?
> 

I referred to the manual, and theoretically, that is the case. However,
it might be more robust to add a check for the register before the comma as well?

>> +
>> +		comma = strchr(next, ',');
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>>  			    struct ins_operands *ops,
>>  			    struct map_symbol *ms __maybe_unused,
>>  			    struct disasm_line *dl __maybe_unused)
>>  {
>> -	char *s = strchr(ops->raw, ','), *target, *endptr;
>> +	char *s = strchr(ops->raw, ','), *target, *endptr, *comment, prev;
>>  
>>  	if (s == NULL)
>>  		return -1;
>> @@ -31,29 +57,48 @@ static int arm64_mov__parse(const struct arch *arch __maybe_unused,
>>  	if (ops->source.raw == NULL)
>>  		return -1;
>>  
>> -	target = ++s;
>> +	target = skip_spaces(++s);
>> +	comment = strchr(s, arch->objdump.comment_char);
>> +
>> +	if (comment != NULL)
>> +		s = comment - 1;
>> +	else
>> +		s = strchr(s, '\0') - 1;
> 
> An interesting use of strchr().  Oh, I found the strchr(3) man page
> also mentions that it's a supported use case.  TIL.
> 

Haha, TIL as well when I first encountered it.

> 
>> +
>> +	while (s > target && isspace(s[0]))
>> +		--s;
>> +	s++;
>> +	prev = *s;
>> +	*s = '\0';
>>  	ops->target.raw = strdup(target);
>> +	*s = prev;
>> +
>>  	if (ops->target.raw == NULL)
>>  		goto out_free_source;
>>  
>> -	ops->target.addr = strtoull(target, &endptr, 16);
>> -	if (endptr == target)
>> -		goto out_free_target;
>> -
>> -	s = strchr(endptr, '<');
>> -	if (s == NULL)
>> -		goto out_free_target;
>> -	endptr = strchr(s + 1, '>');
>> -	if (endptr == NULL)
>> -		goto out_free_target;
>> -
>> -	*endptr = '\0';
>> -	*s = ' ';
>> -	ops->target.name = strdup(s);
>> -	*s = '<';
>> -	*endptr = '>';
>> -	if (ops->target.name == NULL)
>> -		goto out_free_target;
>> +	ops->target.multi_regs = arm64__check_multi_regs(ops->target.raw);
>> +
>> +	/* Parse address followed by symbol name, e.g. "addr <symbol>" */
>> +	if (strchr(target, '<') != NULL) {
>> +		ops->target.addr = strtoull(target, &endptr, 16);
>> +		if (endptr == target)
>> +			goto out_free_target;
> 
> Hmm.. shouldn't this part be executed regardless of presence of a symbol
> name?
> 

Agreed.

>> +
>> +		s = strchr(endptr, '<');
>> +		if (s == NULL)
>> +			goto out_free_target;
> 
> It'd be safer to check `if (*skip_spaces(endptr) == '<')` rather than
> strchr().

Agreed.

> 
> 
>> +		endptr = strchr(s + 1, '>');
>> +		if (endptr == NULL)
>> +			goto out_free_target;
> 
> I'm afraid C++ programs can have symbols with <> for templates.
> Probably strrchr() would work.
> 
> Thanks,
> Namhyung
> 

And thanks for the reminder about C++ templates! I completely overlooked the nested <> case.

-- Tengda

>> +
>> +		*endptr = '\0';
>> +		*s = ' ';
>> +		ops->target.name = strdup(s);
>> +		*s = '<';
>> +		*endptr = '>';
>> +		if (ops->target.name == NULL)
>> +			goto out_free_target;
>> +	}
>>  
>>  	return 0;
>>  
>> -- 
>> 2.34.1
>>

