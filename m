Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463493368B0
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 07:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025959; cv=none; b=Vx5zvdHYcCpNbannFZe3xOOn9qibRxbU7SDgkM1uF2SKjkLTSFbB9/0KT/B/hg+SQIokOesUsbMFUguLlhmfI0wgH2oQKnQHX9b1c6wJpU/ld3cl/icAYHeQ48S5FOYrCN8bH3QUevamphl1nOVO8WtQRKvVaHXkOzgrVPwfwAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025959; c=relaxed/simple;
	bh=F9TeOrhs8zWU7OJL4SKWNgk761BL2GNbIUspakKg6dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kOwd5WtvV9nPGcndDcBeL7d6++HdikI01sOgHGEq/+vy3Pl0Qr5csU4kfhCfwcnH+psdqfKHlRCkqfeB4w9D5MPtpZcP1j+LzNc3V9qD7yLpf1Iq0hQ8pQUGDt7K4EdD09xW/ke0u5xeanFvlJKZS2Lc5y4mT4mJbvi3KzNJieM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hgV0q4phJzKHNCd
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 15:38:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E14AA4057D
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 15:38:55 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgBnlgGOXqJqlvu2BQ--.35459S2;
	Thu, 10 Sep 2026 15:38:55 +0800 (CST)
Message-ID: <b9c5348d-6935-426d-a680-702092a1d0d6@huaweicloud.com>
Date: Thu, 10 Sep 2026 15:38:54 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/26] perf capstone: Symbolize address operands to
 match objdump on arm64
To: Namhyung Kim <namhyung@kernel.org>, sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <cover.1788872630.git.wutengda@huaweicloud.com>
 <eb2510f336aace385e4b4ffa99281d61c89c1ad2.1788872630.git.wutengda@huaweicloud.com>
 <20260908131804.76F941F00A3A@smtp.kernel.org> <aqFx4Fia3SWTrVZu@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <aqFx4Fia3SWTrVZu@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBnlgGOXqJqlvu2BQ--.35459S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKF4fAr1xAw1xCFy8Jw15twb_yoW7KFWUp3
	97Ca15GF4kXr17Kw1kXa1YqrySgwn3WF4aqryDGa4Fkr9agrn7GFWxCFyjka45Ar48Gr40
	yF45Cr43ur9xtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/9/9 22:49, Namhyung Kim wrote:
> Hello,
> 
> On Tue, Sep 08, 2026 at 01:18:03PM +0000, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [Medium] Premature `map__put()` of `found_map` before the caller consumes `sym_name` creates a Use-After-Free vulnerability.
>> --
>>
>> commit ff403b9f1717375044e9b6fbb3f09210431e386b
>> Author: Tengda Wu <wutengda@huaweicloud.com>
>> perf capstone: Symbolize address operands to match objdump on arm64
>>
>> This commit extends Capstone disassembly support on arm64 to resolve target
>> addresses to symbols. It detects instructions with address operands, maps
>> them to symbols, and formats the output to match objdump's style.
>>
>>> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
>>> index 74213daf87862..7f82c33e3464a 100644
>>> --- a/tools/perf/util/capstone.c
>>> +++ b/tools/perf/util/capstone.c
>> [ ... ]
>>> @@ -292,16 +303,44 @@ ssize_t capstone__fprintf_insn_asm(struct machine *machine, struct thread *threa
>>>  	return printed;
>>>  }
>>>  
>>> +static int resolve_symbol_from_addr(struct map *map, u64 addr,
>>> +				    const char **sym_name, u64 *sym_offset)
>>> +{
>>> +	struct map *found_map = NULL;
>>> +	struct symbol *sym;
>>> +	u64 al_addr;
>>> +	u64 ip = map__objdump_2mem(map, addr);
>>> +
>>> +	if (dso__kernel(map__dso(map))) {
>>> +		/*
>>> +		 * The kernel maps can be split into sections, let's
>>> +		 * find the map first and then search the symbol.
>>> +		 */
>>> +		found_map = maps__find(map__kmaps(map), ip);
>>> +		if (found_map == NULL)
>>> +			return -1;
>>> +		map = found_map;
>>> +	}
>>> +
>>> +	/* convert it to map-relative address for search */
>>> +	al_addr = map__map_ip(map, ip);
>>> +
>>> +	sym = map__find_symbol(map, al_addr);
>>> +	map__put(found_map);
>>> +
>>> +	if (sym == NULL)
>>> +		return -1;
>>> +
>>> +	*sym_name = sym->name;
>>> +	*sym_offset = al_addr - sym->start;
>>> +	return 0;
>>> +}
>>
>> [Severity: Medium]
>> Is map__put(found_map) called prematurely here? If the map is concurrently
>> removed and the refcount drops to zero, the map and its symbols could be
>> freed. Does this leave sym->name pointing to freed memory when it is assigned
>> to *sym_name and returned to the caller?
> 
> Right, probably better to return a pointer to symbol instead and make
> the found_map as an out parameter.
> 
> Thanks,
> Namhyung
> 

Agreed. We probably also need to make sym_offset an out parameter, because
struct symbol does not contain offset information, and when printing we need
to use sym_offset to determine whether to append the '+offset' suffix. So
the function signature might be changed to something like this:

static struct symbol *find_symbol_from_addr(struct map *map, u64 addr,
					    struct map **found_map, u64 *sym_offset)

Is it okay to change it this way?

Thanks,
Tengda

>>
>>> +
>>>  static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>>  				  struct annotate_args *args, u64 addr)
>>>  {
>> [ ... ]
>>> @@ -320,40 +360,114 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>>  
>>>  		/* get the target address */
>>>  		orig_addr = addr + insn->size + op->mem.disp;
>>> -		addr = map__objdump_2mem(map, orig_addr);
>>> -
>>> -		if (dso__kernel(map__dso(map))) {
>>> -			/*
>>> -			 * The kernel maps can be split into sections, let's
>>> -			 * find the map first and then search the symbol.
>>> -			 */
>>> -			found_map = maps__find(map__kmaps(map), addr);
>>> -			if (found_map == NULL)
>>> -				continue;
>>> -			map = found_map;
>>> -		}
>>> -
>>> -		/* convert it to map-relative address for search */
>>> -		addr = map__map_ip(map, addr);
>>> -
>>> -		sym = map__find_symbol(map, addr);
>>> -		if (sym == NULL) {
>>> -			map__put(found_map);
>>> +		if (resolve_symbol_from_addr(map, orig_addr, &sym_name, &sym_offset))
>>>  			continue;
>>> -		}
>>>  
>>> -		if (addr == sym->start) {
>>> +		if (sym_offset == 0) {
>>>  			scnprintf(buf, len, "\t# %"PRIx64" <%s>",
>>> -				  orig_addr, sym->name);
>>> +				  orig_addr, sym_name);
>>
>> [Severity: Medium]
>> Can this result in a Use-After-Free? If resolve_symbol_from_addr() drops the
>> map reference too early, sym_name might point to freed memory by the time it
>> is dereferenced here in scnprintf().
>>
>>>  		} else {
>>>  			scnprintf(buf, len, "\t# %"PRIx64" <%s+%#"PRIx64">",
>>> -				  orig_addr, sym->name, addr - sym->start);
>>> +				  orig_addr, sym_name, sym_offset);
>>>  		}
>> [ ... ]
>>> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
>>> +				       size_t len, struct annotate_args *args)
>>> +{
>>> +	struct map *map = args->ms->map;
>>> +	char *last_imm, *endptr;
>>> +	u64 addr;
>>> +
>>> +	print_default_format(insn, buf, len);
>>> +	/*
>>> +	 * Adjust instructions to keep the existing behavior with objdump.
>>> +	 *
>>> +	 * Example conversion:
>>> +	 * From: b #0xffff8000800114c8
>>> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
>>> +	 */
>>> +	if (needs_symbolic_address(insn)) {
>>> +		const char *sym_name = NULL;
>>> +		u64 sym_offset;
>>> +
>>> +		/* Extract last immediate value as address */
>>> +		last_imm = strrchr(buf, '#');
>>> +		if (!last_imm)
>>> +			return;
>>> +
>>> +		addr = strtoull(last_imm + 1, &endptr, 16);
>>> +		if (endptr == last_imm + 1)
>>> +			return;
>>> +
>>> +		if (resolve_symbol_from_addr(map, addr, &sym_name, &sym_offset))
>>> +			return;
>>> +
>>> +		/* Symbolize the resolved address */
>>> +		len = len - (last_imm - buf);
>>> +		if (sym_offset == 0) {
>>> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
>>> +				  addr, sym_name);
>>
>> [Severity: Medium]
>> Does this also dereference the potentially dangling sym_name pointer if the
>> underlying map was freed in resolve_symbol_from_addr()?
>>
>>> +		} else {
>>> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
>>> +				  addr, sym_name, sym_offset);
>>> +		}
>>> +	}
>>> +}
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/cover.1788872630.git.wutengda@huaweicloud.com?part=1

