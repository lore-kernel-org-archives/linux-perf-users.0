Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA2395AF2;
	Thu,  9 Jul 2026 07:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783583357; cv=none; b=EHAGQOH6nVZdPbqtFN+21NNxRm2F3ok0YXy/1HtYwmImuiiVsPpgA2nkEOVL/4elAGzRbM2E0STrdlE/YjmRXDHSFlnxo32Gt6x7c2lc53WAeIAzpEfI1EOWCQM+nRWGiJfg4cYdzWlRtS5zL4iVhUaUHPnNwf7oYGms3dnX3X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783583357; c=relaxed/simple;
	bh=O7QBDW9Zkh1L58j6bU3woZ9V6ZfaPjO090CvphD3CJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hcXlIpna1hunMht5TbF4FXow3UfsjD5FH8wJ0qctmfY4QZouXK9m8S2aQgd25lEeF2HTD2WquVQwLk7HIMrsKfGBL5hhLKcBT1S3n3FxGX0sdxT27nBPfNKws3agmgP8oVQaj/LgBomXlONCWBdN6nd9P3YIWi38zURi5BUTq9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gwnCK53hVzKHMSS;
	Thu,  9 Jul 2026 15:48:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id ECE3A40A6F;
	Thu,  9 Jul 2026 15:49:07 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgAnWVpyUk9qy9JgAg--.22944S2;
	Thu, 09 Jul 2026 15:49:07 +0800 (CST)
Message-ID: <8812e4e2-3a3b-4f32-bdb8-b963bc21b301@huaweicloud.com>
Date: Thu, 9 Jul 2026 15:49:06 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/21] perf llvm: Fix arm64 adrp instruction
 disassembly mismatch with objdump
To: Namhyung Kim <namhyung@kernel.org>
Cc: james.clark@linaro.org, xueshuai@linux.alibaba.com,
 Li Huafei <lihuafei1@huawei.com>, Peter Zijlstra <peterz@infradead.org>,
 leo.yan@linux.dev, Ian Rogers <irogers@google.com>,
 Kim Phillips <kim.phillips@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Bill Wendling <morbo@google.com>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Zecheng Li <zli94@ncsu.edu>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260701035355.752944-1-wutengda@huaweicloud.com>
 <20260701035355.752944-4-wutengda@huaweicloud.com> <ak89Hg1SWnn0DHCk@z2>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <ak89Hg1SWnn0DHCk@z2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnWVpyUk9qy9JgAg--.22944S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFyrZr4rWr13GrykWw4fuFg_yoWrCF4Upr
	WDGayfGF4UJr1fuwsI9r4UuF90krWktrW5Kr43Jw4Ikrs3Cas3C34xGrW293W7Xryqvw15
	Zr4Y9FW7WF1DJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0
	bAw3UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/9 14:18, Namhyung Kim wrote:
> On Wed, Jul 01, 2026 at 03:53:37AM +0000, Tengda Wu wrote:
>> The operands of 'adrp' instructions parsed by libllvm are currently
>> represented as raw immediates rather than the "address <symbol+offset>"
>> format used by objdump. This inconsistency causes arm64_mov__parse()
>> to fail when parsing these instructions during post-processing.
>>
>> Example of the mismatch:
>>   Current: adrp x18, 8014
>>   Fix:     adrp x18, ffff800081f5f000 <this_cpu_vector>
>>
>> Fix this by manually extracting the target address from the raw adrp
>> instruction via symbol_lookup_callback(). The address is then converted
>> to a specific symbol during symbol__disassemble_llvm() and formatted
>> to match objdump's output, ensuring compatibility with existing
>> parsers.
>>
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  tools/perf/util/llvm.c | 50 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>
>> diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
>> index a0deb742a733..533d47e8084d 100644
>> --- a/tools/perf/util/llvm.c
>> +++ b/tools/perf/util/llvm.c
>> @@ -94,6 +94,7 @@ static void init_llvm(void)
>>  struct symbol_lookup_storage {
>>  	u64 branch_addr;
>>  	u64 pcrel_load_addr;
>> +	u64 pcrel_adrp_addr;
>>  };
>>  
>>  static const char *
>> @@ -108,6 +109,18 @@ symbol_lookup_callback(void *disinfo, uint64_t value,
>>  		storage->branch_addr = value;
>>  	else if (*ref_type == LLVMDisassembler_ReferenceType_In_PCrel_Load)
>>  		storage->pcrel_load_addr = value;
> 
> Is this used by arm64?  If not, would be possible to reuse
> pcrel_load_addr unless it'd complicate the code significantly?
> 
> I think it's the common concept of PC-relative addressing while it
> requires two instructions to set up the final address on arm64.
> 
> Thanks,
> Namhyung
> 
> 

I initially tried to reuse it directly, but it didn't seem to work properly
in some cases. After checking the LLVM interface implementation, I came up
with this change. I'll take another look at the details. If reuse is feasible,
I'll optimize this patch.

Thanks,
Tengda


>> +	else if (*ref_type == LLVMDisassembler_ReferenceType_In_ARM64_ADRP) {
>> +		uint64_t adrp_imm;
>> +
>> +		/* immhi (bits 23:5) and immlo (bits 30:29) */
>> +		adrp_imm = ((value & 0x00ffffe0) >> 3) | ((value >> 29) & 0x3);
>> +		/* Sign-extend the 21-bit immediate to 64-bit */
>> +		if (adrp_imm & (1ULL << 20))
>> +			adrp_imm |= ~((1ULL << 21) - 1);
>> +
>> +		/* Calculate the target page address */
>> +		storage->pcrel_adrp_addr = (address & ~0xFFFLL) + (adrp_imm << 12);
>> +	}
>>  	*ref_type = LLVMDisassembler_ReferenceType_InOut_None;
>>  	return NULL;
>>  }
>> @@ -204,6 +217,7 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>>  
>>  		storage.branch_addr = 0;
>>  		storage.pcrel_load_addr = 0;
>> +		storage.pcrel_adrp_addr = 0;
>>  
>>  		/*
>>  		 * LLVM's API has the code be disassembled as non-const, cast
>> @@ -227,6 +241,42 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
>>  				free(name);
>>  			}
>>  		}
>> +		if (storage.pcrel_adrp_addr != 0) {
>> +			/*
>> +			 * ADRP (Address Page) instructions encode a 21-bit signed
>> +			 * immediate offset relative to the current PC's page.
>> +			 *
>> +			 * To maintain consistency with standard objdump output,
>> +			 * we truncate the raw encoded immediate at the comma
>> +			 * and replace it with the resolved absolute page address.
>> +			 *
>> +			 * Example conversion:
>> +			 * From: adrp x18, 8014
>> +			 * To:   adrp x18, ffff800081f5f000 <this_cpu_vector>
>> +			 */
>> +			char *name;
>> +			char *s = strchr(disasm_buf, ',');
>> +
>> +			if (s == NULL)
>> +				goto err;
>> +
>> +			s++;
>> +			*s = '\0';
>> +			disasm_len = strlen(disasm_buf);
>> +			disasm_len += scnprintf(disasm_buf + disasm_len,
>> +						sizeof(disasm_buf) - disasm_len,
>> +						" %"PRIx64,
>> +						storage.pcrel_adrp_addr);
>> +			name = llvm_name_for_data(dso, filename,
>> +						  storage.pcrel_adrp_addr);
>> +			if (name) {
>> +				disasm_len += scnprintf(disasm_buf + disasm_len,
>> +							sizeof(disasm_buf) -
>> +							disasm_len,
>> +							" <%s>", name);
>> +				free(name);
>> +			}
>> +		}
>>  		if (storage.pcrel_load_addr != 0) {
>>  			char *name = llvm_name_for_data(dso, filename,
>>  							storage.pcrel_load_addr);
>> -- 
>> 2.34.1
>>

