Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470B63BB9ED;
	Fri, 10 Apr 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775812113; cv=none; b=Fu2MY5Thx6ArRKi22YO67si3Wc7hHzfrehIkrC1WD8MHXndrwxujeyZxfSF2rrhshdZHt5MLM6PysO6kqp3le4a/SS2UhzvDiFRU7WDw7K7G2eL5KBa5gb9RbbVUgHUUJK4f+EtTPmNFA/bwwJSO9ijpTaouO6aFtcyfnz0vNtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775812113; c=relaxed/simple;
	bh=3dk6a/n5Gd8Q03nlTuhA9GomF95xRQbOqn9vRORgEqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN62tQW14YusQqB8ug85kQdDOnw0AM8seT3lDi1hrnYPf0+gcaC/YFJ4jLBJhVCQ7yt6Qd0cCajiO1WFoDA8wg+j8oyHTgH1DuryEvLpA8f95X4+yBOGEK1WntEMWm395zh0QDy6us3uy5iorzn9kdr2Tl0p765e7dG1nfYNvHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fsWD65Hd1zYQtr5;
	Fri, 10 Apr 2026 17:07:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 067E840570;
	Fri, 10 Apr 2026 17:08:28 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP1 (Coremail) with SMTP id cCh0CgAXGdkKvthpbCUxEA--.45882S2;
	Fri, 10 Apr 2026 17:08:27 +0800 (CST)
Message-ID: <95ffff3d-189f-4e86-98b8-83b255410196@huaweicloud.com>
Date: Fri, 10 Apr 2026 17:08:26 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] perf capstone: Fix arm64 jump/adrp disassembly
 mismatch with objdump
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
 <20260403094800.1418825-3-wutengda@huaweicloud.com> <adSnjABSDeeg-9O8@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <adSnjABSDeeg-9O8@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgAXGdkKvthpbCUxEA--.45882S2
X-Coremail-Antispam: 1UD129KBjvJXoW3WFykJF43Kr4xJry7Wr1fXrb_yoWxAr17p3
	4DC3W3Xa18Xr1Sgw1aqa1DXwnagrWrJF1Yk3yfKaySkrnavrn3GFyxKFya9F98CryDGw4I
	vF4jvF13Wrn5JrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2026/4/7 14:43, Namhyung Kim wrote:
> On Fri, Apr 03, 2026 at 09:47:46AM +0000, Tengda Wu wrote:
>> The jump and adrp instructions parsed by libcapstone currently lack
>> symbolic representation and use a '#' prefix for addresses. This
>> format is inconsistent with objdump's output, which causes subsequent
>> parsing in jump__parse() and arm64_mov__parse() to fail.
>>
>> Example mismatch:
>>   Current: b #0xffff8000800114c8
>>   Fix:     b ffff8000800114c8 <el0t_64_sync+0x108>
>>
>>   Current: adrp x18, #0xffff800081f5f000
>>   Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
>>
>> Fix this by implementing extended formatting for these arm64
>> instructions during symbol__disassemble_capstone(). This ensures
>> the output matches objdump's expected style, including the raw
>> address and the associated <symbol+offset> suffix.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/capstone.c | 107 ++++++++++++++++++++++++++++++++-----
>>  tools/perf/util/disasm.c   |   5 ++
>>  tools/perf/util/disasm.h   |   1 +
>>  3 files changed, 101 insertions(+), 12 deletions(-)
>>
>> diff --git a/tools/perf/util/capstone.c b/tools/perf/util/capstone.c
>> index 25cf6e15ec27..1d8421d2d98c 100644
>> --- a/tools/perf/util/capstone.c
>> +++ b/tools/perf/util/capstone.c
>> @@ -255,10 +255,6 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>  	struct map *map = args->ms->map;
>>  	struct symbol *sym;
>>  
>> -	/* TODO: support more architectures */
>> -	if (!arch__is_x86(args->arch))
>> -		return;
>> -
>>  	if (insn->detail == NULL)
>>  		return;
>>  
>> @@ -305,6 +301,98 @@ static void print_capstone_detail(struct cs_insn *insn, char *buf, size_t len,
>>  	}
>>  }
>>  
>> +static void format_capstone_insn_x86(struct cs_insn *insn, char *buf,
>> +				     size_t len, struct annotate_args *args,
>> +				     u64 addr)
>> +{
>> +	int printed;
>> +
>> +	printed = scnprintf(buf, len, "       %-7s %s",
>> +			    insn->mnemonic, insn->op_str);
>> +	buf += printed;
>> +	len -= printed;
>> +
>> +	print_capstone_detail(insn, buf, len, args, addr);
>> +}
>> +
>> +static void format_capstone_insn_arm64(struct cs_insn *insn, char *buf,
>> +				       size_t len, struct annotate_args *args,
>> +				       u64 addr)
>> +{
>> +	struct map *map = args->ms->map;
>> +	struct symbol *sym;
>> +	char *last_imm, *endptr;
>> +	u64 orig_addr;
>> +
>> +	scnprintf(buf, len, "       %-7s %s",
>> +		  insn->mnemonic, insn->op_str);
>> +	/*
>> +	 * Adjust instructions to keep the existing behavior with objdump.
>> +	 *
>> +	 * Example conversion:
>> +	 * From: b #0xffff8000800114c8
>> +	 * To:   b ffff8000800114c8 <el0t_64_sync+0x108>
>> +	 */
>> +	switch (insn->id) {
>> +	case ARM64_INS_B:
>> +	case ARM64_INS_BL:
>> +	case ARM64_INS_CBNZ:
>> +	case ARM64_INS_CBZ:
>> +	case ARM64_INS_TBNZ:
>> +	case ARM64_INS_TBZ:
>> +	case ARM64_INS_ADRP:
>> +		/* Extract last immediate value as address */
>> +		last_imm = strrchr(buf, '#');
>> +		if (!last_imm)
>> +			return;
>> +
>> +		orig_addr = strtoull(last_imm + 1, &endptr, 16);
>> +		if (endptr == last_imm + 1)
>> +			return;
>> +
>> +		/* Relocate map that contains the address */
>> +		if (dso__kernel(map__dso(map))) {
>> +			map = maps__find(map__kmaps(map), orig_addr);
>> +			if (map == NULL)
>> +				return;
> 
> I know you copied the logic from x86, but I've realized that it leaks a
> refcount for the new kernel map returned from maps__find().  This needs
> to be fixed separately.
> 
> Thanks,
> Namhyung
> 

Oh, right.
I will send a separate patch to fix this issue in the existing x86 logic and
will make sure the arm64 implementation follows the fix.

-- Tengda

> 
>> +		}
>> +
>> +		/* Convert it to map-relative address for search */
>> +		addr = map__map_ip(map, orig_addr);
>> +
>> +		sym = map__find_symbol(map, addr);
>> +		if (sym == NULL)
>> +			return;
>> +
>> +		/* Symbolize the resolved address */
>> +		len = len - (last_imm - buf);
>> +		if (addr == sym->start) {
>> +			scnprintf(last_imm, len, "%"PRIx64" <%s>",
>> +				  orig_addr, sym->name);
>> +		} else {
>> +			scnprintf(last_imm, len, "%"PRIx64" <%s+%#"PRIx64">",
>> +				  orig_addr, sym->name, addr - sym->start);
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>> +static void format_capstone_insn(struct cs_insn *insn, char *buf, size_t len,
>> +				 struct annotate_args *args, u64 addr)
>> +{
>> +	/* TODO: support more architectures */
>> +	if (arch__is_x86(args->arch))
>> +		format_capstone_insn_x86(insn, buf, len, args, addr);
>> +	else if (arch__is_arm64(args->arch))
>> +		format_capstone_insn_arm64(insn, buf, len, args, addr);
>> +	else {
>> +		scnprintf(buf, len, "       %-7s %s",
>> +			  insn->mnemonic, insn->op_str);
>> +	}
>> +}
>> +
>>  struct find_file_offset_data {
>>  	u64 ip;
>>  	u64 offset;
>> @@ -381,14 +469,9 @@ int symbol__disassemble_capstone(const char *filename __maybe_unused,
>>  
>>  	free_count = count = perf_cs_disasm(handle, buf, buf_len, start, buf_len, &insn);
>>  	for (i = 0, offset = 0; i < count; i++) {
>> -		int printed;
>> -
>> -		printed = scnprintf(disasm_buf, sizeof(disasm_buf),
>> -				    "       %-7s %s",
>> -				    insn[i].mnemonic, insn[i].op_str);
>> -		print_capstone_detail(&insn[i], disasm_buf + printed,
>> -				      sizeof(disasm_buf) - printed, args,
>> -				      start + offset);
>> +		format_capstone_insn(&insn[i], disasm_buf,
>> +				     sizeof(disasm_buf), args,
>> +				     start + offset);
>>  
>>  		args->offset = offset;
>>  		args->line = disasm_buf;
>> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
>> index 40fcaed5d0b1..988b2b748e11 100644
>> --- a/tools/perf/util/disasm.c
>> +++ b/tools/perf/util/disasm.c
>> @@ -202,6 +202,11 @@ bool arch__is_powerpc(const struct arch *arch)
>>  	return arch->id.e_machine == EM_PPC || arch->id.e_machine == EM_PPC64;
>>  }
>>  
>> +bool arch__is_arm64(const struct arch *arch)
>> +{
>> +	return arch->id.e_machine == EM_AARCH64;
>> +}
>> +
>>  static void ins_ops__delete(struct ins_operands *ops)
>>  {
>>  	if (ops == NULL)
>> diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
>> index a6e478caf61a..d3730ed86dba 100644
>> --- a/tools/perf/util/disasm.h
>> +++ b/tools/perf/util/disasm.h
>> @@ -111,6 +111,7 @@ struct annotate_args {
>>  const struct arch *arch__find(uint16_t e_machine, uint32_t e_flags, const char *cpuid);
>>  bool arch__is_x86(const struct arch *arch);
>>  bool arch__is_powerpc(const struct arch *arch);
>> +bool arch__is_arm64(const struct arch *arch);
>>  
>>  extern const struct ins_ops call_ops;
>>  extern const struct ins_ops dec_ops;
>> -- 
>> 2.34.1
>>

