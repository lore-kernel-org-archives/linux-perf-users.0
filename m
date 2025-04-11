Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910FC1F8BDD;
	Fri, 11 Apr 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384167; cv=none; b=EPCiOLsJQkTBa138Wa4OYOgXOHYnoIQ/7WDqqXmrQTiMtu3ke1m+9RL0pc34Kl3W3L7zvyhqyteKimMOicZwbi1WVFUKUoCjwfKOqA0mY0jUPAiTrOmHHT1tYHHHsusMDA8Z9WGaxCCxT6jLkI+AW4B5uanNzNengNJhyK0OASU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384167; c=relaxed/simple;
	bh=xyb6zXpVTHYI5oHHidMO4UGACvo/hzgyyyMUVF8C+tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gnnEHG24k4RzJ+1RZMXZQfM8vOw2/Df4rD9dEdQRMKcHN8lowQ+C6VrScwi6/4DbCzsx/hpGy/EFEAuX6ZOxIO6oeWzPraE8fpMiTyemZpjLUBG/yGQbMLy1HFZeGWdBZP25nSUaoQHbGxpyARCHP46Sz29RZcUO9lCou+oG1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D13D153B;
	Fri, 11 Apr 2025 08:09:24 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24B0B3F59E;
	Fri, 11 Apr 2025 08:09:19 -0700 (PDT)
Message-ID: <cef3f3db-7dcc-4f0f-b6c9-c8336b4a9433@arm.com>
Date: Fri, 11 Apr 2025 10:09:18 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] arm64: probes: Add GCS support to bl/blr/ret
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250407161951.560865-1-jeremy.linton@arm.com>
 <20250407161951.560865-5-jeremy.linton@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250407161951.560865-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 4/7/25 11:19 AM, Jeremy Linton wrote:
> The arm64 probe simulation doesn't currently have logic in place
> to deal with GCS and this results in core dumps if probes are inserted
> at control flow locations. Fix-up bl, blr and ret to manipulate the
> shadow stack as needed.
> 
> While we manipulate and validate the shadow stack correctly, the
> hardware provides additional security by only allowing GCS operations
> against pages which are marked to support GCS. For writing there is
> gcssttr() which enforces this, but there isn't an equivalent for
> reading. This means that uprobe users should be aware that probing on
> control flow instructions which require reading the shadow stack (ex:
> ret) offers lower security guarantees than what is achieved without
> the uprobe active.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/probes/simulate-insn.c | 28 ++++++++++++++++++++----
>   1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 09a0b36122d0..1fc9bb69b1eb 100644
> --- a/arch/arm64/kernel/probes/simulate-insn.c
> +++ b/arch/arm64/kernel/probes/simulate-insn.c
> @@ -13,6 +13,7 @@
>   #include <asm/traps.h>
>   
>   #include "simulate-insn.h"
> +#include "asm/gcs.h"
>   
>   #define bbl_displacement(insn)		\
>   	sign_extend32(((insn) & 0x3ffffff) << 2, 27)
> @@ -49,6 +50,18 @@ static inline u32 get_w_reg(struct pt_regs *regs, int reg)
>   	return lower_32_bits(pt_regs_read_reg(regs, reg));
>   }
>   
> +static inline void update_lr(struct pt_regs *regs, long addr)
> +{
> +	int err = 0;
> +
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		push_user_gcs(addr + 4,	 &err);
> +		if (err)
> +			force_sig(SIGSEGV);
> +	}
> +	procedure_link_pointer_set(regs, addr + 4);
> +}
> +
>   static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
>   {
>   	int xn = opcode & 0x1f;
> @@ -107,9 +120,8 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
>   {
>   	int disp = bbl_displacement(opcode);
>   
> -	/* Link register is x30 */
>   	if (opcode & (1 << 31))
> -		set_x_reg(regs, 30, addr + 4);
> +		update_lr(regs, addr);
>   
>   	instruction_pointer_set(regs, addr + disp);
>   }
> @@ -133,17 +145,25 @@ simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
>   	/* update pc first in case we're doing a "blr lr" */
>   	instruction_pointer_set(regs, get_x_reg(regs, xn));
>   
> -	/* Link register is x30 */
>   	if (((opcode >> 21) & 0x3) == 1)
> -		set_x_reg(regs, 30, addr + 4);
> +		update_lr(regs, addr);
>   }
>   
>   void __kprobes
>   simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>   {
> +	u64 ret_addr;
> +	int err = 0;
>   	int xn = (opcode >> 5) & 0x1f;
>   
>   	instruction_pointer_set(regs, get_x_reg(regs, xn));
> +
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		ret_addr = pop_user_gcs(&err);
> +		if (err || ret_addr != procedure_link_pointer(regs))
> +			force_sig(SIGSEGV);
> +	}
> +
>   }

I was looking at this earlier this week and decided that this routine 
should have a return added following the force_sig(), and moving the 
instruction_pointer_set() below that. That syncs the behavior with what 
would happen without the uprobe active when ret_addr != LR. Then I 
dumped the 'xn' too.


