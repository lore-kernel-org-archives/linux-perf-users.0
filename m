Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665A37CD28;
	Fri, 10 Apr 2026 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775816834; cv=none; b=jgMHyBB4h0DD/Wev8Cx9pNj0FwAuuL2eacjnm3CjhkI8YhhGMFuUgiXuWCwqfMoL77fIQpZp0/kN6VntvlOPuwfStdf1lnA31RslBPvxBMat978/+Gs3oMqrL/Glds0zl5x/5SGtnWNU0BP9Rmne7kiXVRGzUNi7PIkgI0HVLHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775816834; c=relaxed/simple;
	bh=4YpmGLYVUXmjed9rvR3DXRxCQhRe2rt3ugbaCmzEE3Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKq1s9/1EQvnvcgyX1fRM9gv0EyhVgwSilX4knmeLQe9bOGYrE07rBmKyC2tBj/sDwewJQQC8NzHgWdGAi4z728zkPxbhRIOMu+38JaAhXbE9KLSLM8C6J+FnPAXP5Ky4p0903K9lB3PtODVNKo+11gtiKww+C75KGDWRd/4GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsXyv3nCPzYQtqS;
	Fri, 10 Apr 2026 18:26:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id DEEC94058D;
	Fri, 10 Apr 2026 18:27:08 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgBHcAV70NhpRGU2EA--.34973S2;
	Fri, 10 Apr 2026 18:27:08 +0800 (CST)
Message-ID: <58fcc07f-9263-4b82-a995-05e7b353cd58@huaweicloud.com>
Date: Fri, 10 Apr 2026 18:27:07 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/16] perf annotate-arm64: Implement
 extract_op_location() callback
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
 <20260403094800.1418825-8-wutengda@huaweicloud.com> <adSxsFF2OyDUfOeS@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adSxsFF2OyDUfOeS@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBHcAV70NhpRGU2EA--.34973S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFyDtw45ArWUWry3Zw17GFg_yoWxJw48pw
	4j9a43tr17tr4jq3WfXFs3WFy3Kw1fGF1Y93yxt3ZrAFn7urn3G3WfKF1a9a4rJrnxur1j
	vF4jqrWUury5CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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



On 2026/4/7 15:26, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:51AM +0000, Tengda Wu wrote:
>> Implement the extract_op_location() callback for the arm64 architecture
>> to handle its specific assembly syntax and addressing modes.
>>
>> The extractor handles:
>> 1. Standalone immediate operands (e.g., #0x10).
>> 2. Memory references with diverse addressing modes:
>>    - Signed offset: [base, #imm]
>>    - Pre-index: [base, #imm]!
>>    - Post-index: [base], #imm
>> 3. Multi-register operands and primary/secondary register extraction.
>>
>> This enables 'perf annotate' to resolve memory locations and registers
>> required for data type profiling on arm64.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  .../perf/util/annotate-arch/annotate-arm64.c  | 64 +++++++++++++++++++
>>  tools/perf/util/annotate.c                    | 12 ++--
>>  tools/perf/util/annotate.h                    | 10 +++
>>  3 files changed, 81 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/perf/util/annotate-arch/annotate-arm64.c b/tools/perf/util/annotate-arch/annotate-arm64.c
>> index 8209faaa6086..1fe4c503431b 100644
>> --- a/tools/perf/util/annotate-arch/annotate-arm64.c
>> +++ b/tools/perf/util/annotate-arch/annotate-arm64.c
>> @@ -191,6 +191,69 @@ static const struct ins_ops *arm64__associate_instruction_ops(struct arch *arch,
>>  	return ops;
>>  }
>>  
>> +static int extract_op_location_arm64(const struct arch *arch,
>> +				     struct disasm_line *dl __maybe_unused,
>> +				     const char *op_str, int op_idx __maybe_unused,
>> +				     struct annotated_op_loc *op_loc)
>> +{
>> +	const char *s = op_str;
>> +	char *p = NULL;
>> +
>> +	if (op_str == NULL)
>> +		return 0;
>> +
>> +	/* Handle standalone immediate operands (e.g., #0x10) */
>> +	if (*s == arch->objdump.imm_char) {
>> +		op_loc->offset = strtol(s + 1, &p, 0);
>> +		if (p && p != s + 1)
>> +			op_loc->imm = true;
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Handle memory references (e.g., [x0, #8]), identify
>> +	 * arm64 specific addressing modes
>> +	 */
>> +	if (*s == arch->objdump.memory_ref_char) {
>> +		op_loc->mem_ref = true;
>> +
>> +		p = strchr(s, ']');
>> +		if (p == NULL)
>> +			return -1;
>> +
>> +		/* Pre-index: [base, #imm]! */
>> +		if (p[1] == '!')
>> +			op_loc->addr_mode = INSN_ADDR_PRE_INDEX;
>> +		/* Post-index: [base], #imm */
>> +		else if (p[1] == ',' && strchr(p + 1, arch->objdump.imm_char))
>> +			op_loc->addr_mode = INSN_ADDR_POST_INDEX;
>> +		/* Signed offset: [base{, #imm}] */
>> +		else
>> +			op_loc->addr_mode = INSN_ADDR_SIGNED_OFFSET;
>> +
>> +		s++;
>> +	}
>> +
>> +	/* Extract the primary register */
>> +	op_loc->reg1 = arch__dwarf_regnum(arch, s);
>> +	if (op_loc->reg1 == -1)
>> +		return -1;
>> +
>> +	/* Move to the next symbol of the operand, if any */
>> +	s = strchr(s, ',');
>> +	if (s == NULL)
>> +		return 0;
>> +	s = skip_spaces(s + 1);
>> +
>> +	/* Parse secondary register or immediate offset */
>> +	if (op_loc->multi_regs)
>> +		op_loc->reg2 = arch__dwarf_regnum(arch, s);
>> +	else if (*s == arch->objdump.imm_char)
>> +		op_loc->offset = strtol(s + 1, &p, 0);
>> +
>> +	return 0;
>> +}
>> +
>>  const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  				   const char *cpuid __maybe_unused)
>>  {
>> @@ -209,6 +272,7 @@ const struct arch *arch__new_arm64(const struct e_machine_and_e_flags *id,
>>  	arch->objdump.memory_ref_char	  = '[';
>>  	arch->objdump.imm_char		  = '#';
>>  	arch->associate_instruction_ops   = arm64__associate_instruction_ops;
>> +	arch->extract_op_location	  = extract_op_location_arm64;
>>  
>>  	/* bl, blr */
>>  	err = regcomp(&arm->call_insn, "^blr?$", REG_EXTENDED);
>> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
>> index 1bf69e00d76d..c4d1cb3a7ae4 100644
>> --- a/tools/perf/util/annotate.c
>> +++ b/tools/perf/util/annotate.c
>> @@ -2452,19 +2452,21 @@ int annotate_check_args(void)
>>  
>>  int arch__dwarf_regnum(const struct arch *arch, const char *str)
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
>>  	if (q)
>>  		*q = '\0';
>>  
> 
> I think it's better to split changes in this function into a separate
> commit earlier in the series.  Please add description about arm64 asm
> format about register prefix and different memory reference delimiters.
> Probably you want to merge the change to remove 'static' scope here.
> 

Okay.

> 
>> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
>> index 71195a27d38f..0391c6a9f011 100644
>> --- a/tools/perf/util/annotate.h
>> +++ b/tools/perf/util/annotate.h
>> @@ -496,12 +496,21 @@ int annotate_check_args(void);
>>  
>>  int arch__dwarf_regnum(const struct arch *arch, const char *str);
>>  
>> +enum annotated_addr_mode {
>> +	INSN_ADDR_NONE = 0,
>> +
>> +	INSN_ADDR_SIGNED_OFFSET,
>> +	INSN_ADDR_PRE_INDEX,
>> +	INSN_ADDR_POST_INDEX,
> 
> Probably better to have "PERF" prefix.  Maybe PERF_AAM_SIGNED_OFFSET
> (AAM from annotated_addr_mode) or PERF_ADDR_MODE_SIGNED_OFFSET?
> 
> Thanks,
> Namhyung
> 

I vote for 'PERF_ADDR_MODE_'. It's more explicit and readable than the
abbreviated version.

-- Tengda

> 
>> +};
>> +
>>  /**
>>   * struct annotated_op_loc - Location info of instruction operand
>>   * @reg1: First register in the operand
>>   * @reg2: Second register in the operand
>>   * @offset: Memory access offset in the operand
>>   * @segment: Segment selector register
>> + * @addr_mode: Addressing mode, only valid if @mem_ref is true
>>   * @mem_ref: Whether the operand accesses memory
>>   * @multi_regs: Whether the second register is used
>>   * @imm: Whether the operand is an immediate value (in offset)
>> @@ -511,6 +520,7 @@ struct annotated_op_loc {
>>  	int reg2;
>>  	int offset;
>>  	u8 segment;
>> +	u8 addr_mode;
>>  	bool mem_ref;
>>  	bool multi_regs;
>>  	bool imm;
>> -- 
>> 2.34.1
>>

