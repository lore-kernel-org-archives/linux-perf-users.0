Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE121A3A80;
	Tue, 11 Aug 2026 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436227; cv=none; b=iAafHALwVn4k2unQYltNFIJVpjwk73zROeEUT+LLY0qk/DK04nTu19gQh+PivXaPUbczH2E4Ipi9JKtiDCgg6CXu7crKWkvBE/og492o9sY+hF+20s1kvOw40PW21tSgANrlGMKFcoCOZCcJbjwoV/G5XSe+zUKgcpWqi3MEVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436227; c=relaxed/simple;
	bh=HPYuV9/y20qFcfCaewkIeB2c3K3drvIQoPWSo/TWQlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/hQ7VIu9jZj513rrtyVSiApIN9MXbnLnD1J5DnBGbR9LYr/T9M08CFIQntss4nQFujklc98LKyspBATAK9C7iUfHGSeLdeXKZZAFcfINhsUSWQWmzHGoWYa0Nw1uzLOjNgKSFPAzQwtjyxKxB8k4NtnuFMcX2wsdyR08Xh9Zng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hK4GN5c3XzKHMr0;
	Tue, 11 Aug 2026 16:16:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 865134056B;
	Tue, 11 Aug 2026 16:17:00 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgCX0UB72npqT8afBw--.16426S2;
	Tue, 11 Aug 2026 16:17:00 +0800 (CST)
Message-ID: <923626e1-28db-42aa-a6ac-f1d1012cea82@huaweicloud.com>
Date: Tue, 11 Aug 2026 16:16:59 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/23] perf annotate: Adapt arch__dwarf_regnum() for
 arm64
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
 <20260808122400.2961238-7-wutengda@huaweicloud.com>
 <1d2e807f-5ced-4af5-86c8-9cd3e89a7ba2@linux.alibaba.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <1d2e807f-5ced-4af5-86c8-9cd3e89a7ba2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgCX0UB72npqT8afBw--.16426S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArW3XrW3GFyrtF4DXr43KFg_yoW5Kw43pr
	4kC3y5GryUCr1rtrsxta1UWFy5Gw47J3W5Zrn5Ja4DAF47ury0qF4FqF109F17Cr4kJr1U
	tr4jqr1kZFnxAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxo
	7KDUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/8/11 14:33, Shuai Xue wrote:
> 
> 
> On 8/8/26 8:23 PM, Tengda Wu wrote:
>> Currently, arch__dwarf_regnum() assumes that all architectures use a
>> register prefix character (e.g., '%' for x86) defined by
>> arch->objdump.register_char, and uses it to match register names in
>> objdump output. However, this assumption does not hold for arm64,
>> where assembly syntax uses bare register names like 'x0', 'w1'
>> without any prefix.
>>
>> As a result, arm64 builds may fail to correctly recognize register
>> names from objdump disassembly, leading to incomplete or incorrect
>> annotation output.
>>
>> To address this:
>>
>> - Make the register prefix check optional, allowing architectures
>>    without a prefix character to be parsed correctly.
>>
>> - Extend the delimiter set in strpbrk() to include the closing square
>>    bracket ']'. In arm64 assembly, memory operands often use bracketed
>>    syntax such as '[x1, #16]' or '[x2]'. Adding ']' ensures clean
>>    extraction of register names like 'x2' without trailing characters.
>>
>> - Remove the 'static' qualifier from arch__dwarf_regnum() so that it
>>    can be reused by other architecture-specific profiling components
>>    in future changes.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>   tools/perf/util/annotate.c | 14 ++++++++------
>>   tools/perf/util/annotate.h |  2 ++
>>   2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index df70e95a8470..9d8b4d6b859b 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2472,21 +2472,23 @@ int annotate_check_args(void)
>>       return 0;
>>   }
>>   -static int arch__dwarf_regnum(const struct arch *arch, const char *str)
>> +int arch__dwarf_regnum(const struct arch *arch, const char *str)
>>   {
>> -    const char *p;
>> +    const char *p = str;
>>       char *regname, *q;
>>       int reg;
>>   -    p = strchr(str, arch->objdump.register_char);
>> -    if (p == NULL)
>> -        return -1;
>> +    if (arch->objdump.register_char) {
>> +        p = strchr(str, arch->objdump.register_char);
>> +        if (p == NULL)
>> +            return -1;
>> +    }
>>         regname = strdup(p);
>>       if (regname == NULL)
>>           return -1;
> 
> 
> Keeping the early -1 return here is correct, but it exposes an
> inconsistency in this function's failure values. This is the only path
> that returns -1; when the lookup itself fails the tail returns whatever
> get_dwarf_regnum() produced (-ENOENT on arm64, -EINVAL/-ENOENT on x86).
> The callers only check
> 
>     if (op_loc->reg1 == -1)
> 
> so the early return is caught while a real parse failure slips through
> with a negative reg1. Today that is harmless because every consumer
> guards with has_reg_type(), whose unsigned compare rejects negative
> values, but the error propagation is effectively broken and arm64 adds
> more inputs that fail parsing (prfm ops, PC-relative addresses).
> 
> Could you normalise the tail to keep the "success or -1" contract?
> 
>     reg = get_dwarf_regnum(regname, arch->id.e_machine,
>                    arch->id.e_flags);
>     free(regname);
>     return reg < 0 ? -1 : reg;
> 
> Thanks.
> Shuai

Sure. I'm also thinking about whether this change should be done as a
standalone patch, since it appears to be a pre-existing issue.

Thanks,
Tengda

