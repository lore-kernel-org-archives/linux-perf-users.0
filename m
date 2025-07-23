Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61B71798F;
	Wed, 23 Jul 2025 18:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753295670; cv=none; b=mL9ITYuJ6UltOF3sI0BuoM63SKyDYueDUU4Qw3vv1plJCevZwAW6XUgyi2vaekzOi6R+HE/n7vJowKODVKBiK3nxJFFmH/hjR1/r8obRGZCVl6AJ6G7NNxn5fs27Q2aGr1B6sat3yqQ1DWVfJHoEc1JZ8pP38wCrCNAiX9YPZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753295670; c=relaxed/simple;
	bh=vCo0hmqq5WKs37jfxtZIGwQg9Hihicu0bhutmDBec0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sn+QFaI4PP6qU3ABY4kTwFZn8daHRqjF6FeCsPgjDW0RLzdCOX7WEpf2/uReu0ChdJoHGcxrx55yvDRcw0uwQULx8ANy0iEBfy11TXi5ZudSe4zSoAJnz5pk9zP5gUC/B5qUF0tT37drbJxBnF2gjbRhbpv+lmq/RX/Rqwdzqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF5561A32;
	Wed, 23 Jul 2025 11:34:21 -0700 (PDT)
Received: from [192.168.20.57] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4A1E3F6A8;
	Wed, 23 Jul 2025 11:34:26 -0700 (PDT)
Message-ID: <f4b57ba9-826f-48c6-af80-14fa9ab22544@arm.com>
Date: Wed, 23 Jul 2025 13:34:24 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] arm64: probes: Add GCS support to bl/blr/ret
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250719043740.4548-1-jeremy.linton@arm.com>
 <20250719043740.4548-6-jeremy.linton@arm.com> <aICywZ55EKfSYSIY@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <aICywZ55EKfSYSIY@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,


Thanks for catching a bug!

On 7/23/25 5:00 AM, Catalin Marinas wrote:
> On Fri, Jul 18, 2025 at 11:37:37PM -0500, Jeremy Linton wrote:
>> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
>> index 09a0b36122d0..c75dce7bbe13 100644
>> --- a/arch/arm64/kernel/probes/simulate-insn.c
>> +++ b/arch/arm64/kernel/probes/simulate-insn.c
>> @@ -13,6 +13,7 @@
>>   #include <asm/traps.h>
>>   
>>   #include "simulate-insn.h"
>> +#include "asm/gcs.h"
>>   
>>   #define bbl_displacement(insn)		\
>>   	sign_extend32(((insn) & 0x3ffffff) << 2, 27)
>> @@ -49,6 +50,20 @@ static inline u32 get_w_reg(struct pt_regs *regs, int reg)
>>   	return lower_32_bits(pt_regs_read_reg(regs, reg));
>>   }
>>   
>> +static inline void update_lr(struct pt_regs *regs, long addr)
>> +{
>> +	int err = 0;
>> +
>> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
>> +		push_user_gcs(addr + 4,	 &err);
>> +		if (err) {
>> +			force_sig(SIGSEGV);
>> +			return;
>> +		}
>> +	}
>> +	procedure_link_pointer_set(regs, addr + 4);
>> +}
>> +
>>   static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
>>   {
>>   	int xn = opcode & 0x1f;
>> @@ -107,9 +122,8 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
>>   {
>>   	int disp = bbl_displacement(opcode);
>>   
>> -	/* Link register is x30 */
>>   	if (opcode & (1 << 31))
>> -		set_x_reg(regs, 30, addr + 4);
>> +		update_lr(regs, addr);
> 
> Why not pass (addr + 4) here and skip the addition in update_lr()?

Seemed to make more sense to do the adds in the function using the 
offset values.
> 
>>   
>>   	instruction_pointer_set(regs, addr + disp);
>>   }
>> @@ -133,17 +147,26 @@ simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
>>   	/* update pc first in case we're doing a "blr lr" */
>>   	instruction_pointer_set(regs, get_x_reg(regs, xn));
>>   
>> -	/* Link register is x30 */
>>   	if (((opcode >> 21) & 0x3) == 1)
>> -		set_x_reg(regs, 30, addr + 4);
>> +		update_lr(regs, addr);
>>   }
> 
> I can see why this function was originally updating PC (in case of a blr
> lr) but updating the LR was not supposed to fail. With GCS, I think we
> should follow similar logic to simulate_b_bl() and skip updating PC/LR
> if the write to the GCS failed (assuming that's what the hardware does,
> I haven't checked the spec).

Yes I 'fixed' this in simulate ret below, which is probably when I 
dropped the xn because I was just testing it with compiled code that was 
always using lr.


> 
>>   void __kprobes
>>   simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>>   {
>> -	int xn = (opcode >> 5) & 0x1f;
>> +	u64 ret_addr;
>> +	int err = 0;
>> +	unsigned long lr = procedure_link_pointer(regs);
>>   
>> -	instruction_pointer_set(regs, get_x_reg(regs, xn));
>> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
>> +		ret_addr = pop_user_gcs(&err);
>> +		if (err || ret_addr != lr) {
>> +			force_sig(SIGSEGV);
>> +			return;
>> +		}
>> +	}
>> +
>> +	instruction_pointer_set(regs, lr);
>>   }
> 
> What happened to the RET Xn case?
> 

I broke it because my testing code/app never generated it.



