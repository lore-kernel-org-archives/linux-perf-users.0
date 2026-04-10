Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23619342514;
	Fri, 10 Apr 2026 10:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775818428; cv=none; b=vEKR+mEJZtLTg73B2L4RVl5l5eowAwXahNY7Y8PS3zMJAHiW0T82z1b6s3jYLFPKPwaD9ukZ4C6ZHyZcXUCNbmcKlB57A17+9AcYZ8IWImQeyTJChPKZEYYPBkQ6Jn2bAmUyyKuIBD8dUqTM1uKichM1axppWool+Nxy1m5WRTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775818428; c=relaxed/simple;
	bh=BRbrhMG0BID4yVcXbHkqRzCGgZVffk85Z2MRnAu4HdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgbG3TWn30ld+bomAr/jfjBQPet6CL7R3hh+vmmaIY9HDhKdz00fRiAMg+ySl2AVjNYCi21L+uU2LP6cwyaX660b9xqKMqPESNx0pz5ZRAuhuBa6YwgQBIjE7vsaVFOwxvXQXFw5BNzah1mKQxnWduk0zAMQYaG04J86Hq3s9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fsYZF4NTVzKHMSl;
	Fri, 10 Apr 2026 18:53:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 4B38440575;
	Fri, 10 Apr 2026 18:53:43 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP3 (Coremail) with SMTP id _Ch0CgBXNVK21thpZuwkEA--.63083S2;
	Fri, 10 Apr 2026 18:53:43 +0800 (CST)
Message-ID: <7dd0cb46-086a-4d3e-9f07-ff62cc95da2a@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:53:42 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/16] perf annotate-arm64: Support 'mov' instruction
 tracking
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
 <20260403094800.1418825-13-wutengda@huaweicloud.com>
 <adibGCaruYl4i9f8@google.com>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adibGCaruYl4i9f8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXNVK21thpZuwkEA--.63083S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrykGF4kAF1DuFW7tw1rtFb_yoW5KFW7pa
	n8Ga45Kw4qgr13KrnIqFWrXa4Sgrn3Kw1q93s0qa4ayryakr4ftF93Kay3ua15Xry8Cr47
	Jw1Utry3Ww1DCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUsfMaUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/4/10 14:39, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:56AM +0000, Tengda Wu wrote:
>> Extend update_insn_state() for arm64 to handle register-to-register
>> 'mov' instructions.
>>
>> When a 'mov' instruction occurs between two registers, the data type
>> information (DWARF type, kind, and offset) needs to be propagated from
>> the source register to the destination register. This ensures that if
>> a pointer or a structure was previously identified in one register,
>> the tracker continues to recognize it after it is moved.
>>
>> A real-world example is shown below:
>>
>>   ffff8000803eebf8 <get_vma_policy>:
>>   ffff8000803eec20:  mov  x21, x0  // x0 (struct vm_area_struct*) -> x21
>>   ffff8000803eec28:  ldr  x2, [x0, #112]
>>   ffff8000803eec2c:  cbz  x2, ffff8000803eec94 <get_vma_policy+0x9c>
>>   ffff8000803eec94:  ldr  x0, [x21, #152]  // PMU sample
>>
>> Before this commit, the type of x21 was unknown, causing the subsequent
>> inference to fail:
>>
>>   var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>>   chk [9c] reg21 offset=0x98 ok=0 kind=0 cfa : no type information
>>   final result: no type information
>>
>> After this commit, the type of x21 is correctly inferred as 'vm_area_struct':
>>
>>   var [0] reg0 offset 0 type='struct vm_area_struct*' size=0x8
>>   mov [28] reg0 -> reg21 type='struct vm_area_struct*' size=0x8
>>   chk [9c] reg21 offset=0x98 ok=1 kind=1 (struct vm_area_struct*) : Good!
>>   found by insn track: 0x98(reg21) type-offset=0x98
>>   final result:  type='struct vm_area_struct' size=0xb0
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 28 +++++++++++++++++++
>>  1 file changed, 28 insertions(+)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index f9100230c2f6..013b673f4861 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -308,6 +308,34 @@ static void update_insn_state_arm64(struct type_state *state,
>>  	sreg = src->reg1;
>>  	dreg = dst->reg1;
>>  
>> +	/* Register to register transfers */
>> +	if (!strcmp(dl->ins.name, "mov")) {
>> +		if (!has_reg_type(state, sreg))
>> +			return;
>> +
>> +		tsr = &state->regs[sreg];
>> +		tsr->copied_from = -1;
>> +
>> +		if (!has_reg_type(state, dreg) ||
>> +		    !state->regs[dreg].ok) {
>> +			tsr->ok = false;
>> +			return;
>> +		}
> 
> Does this handle an immediate value?
> 

I actually had immediate value support in an earlier draft, but I removed it
because the introduction of a new TSR_KIND_CONST type made state maintenance
a bit complex, and I hadn't fully thought through the logic at that time.

However, supporting it is definitely better for completeness. I'll try to
implement it properly.

Thanks,
Tengda

>> +
>> +		tsr->type = state->regs[dreg].type;
>> +		tsr->kind = state->regs[dreg].kind;
>> +		tsr->offset = state->regs[dreg].offset;
>> +		tsr->ok = true;
> 
> Probably safe to use 'state->regs[dreg].ok'.
> 
> Anyway, the same concern.  The src and dst are reversed.
> 
> Thanks,
> Namhyung
> 
>> +
>> +		if (tsr->kind == TSR_KIND_TYPE || tsr->kind == TSR_KIND_POINTER)
>> +			tsr->copied_from = dreg;
>> +
>> +		pr_debug_dtp("mov [%x] reg%d -> reg%d",
>> +			     insn_offset, dreg, sreg);
>> +		pr_debug_type_name(&tsr->type, tsr->kind);
>> +		return;
>> +	}
>> +
>>  	if (dloc->fb_cfa) {
>>  		u64 ip = dloc->ms->sym->start + dl->al.offset;
>>  		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
>> -- 
>> 2.34.1
>>

