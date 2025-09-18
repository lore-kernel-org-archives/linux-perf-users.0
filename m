Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F2A283FD0;
	Thu, 18 Sep 2025 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200058; cv=none; b=at6o+eOjxIb80N/xhEPeYOcRu5S0TxhmS+p/d6bKphmU8MwjzTSi+ZhB9u8uchGvayFOrE8HcFlE3nYA7JFVboHxpbrfRuZgf6q+PWkhghxZtB8FhtKh4MLcurFfDH+jll+/xfKgDzqW21+CRmshTSuHD1lo/sKJUFanuObg4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200058; c=relaxed/simple;
	bh=V2chHHku1fOFH/uCGvedeRp2kHAM7noiy4UoMokE1Lg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYASloupP3GOrzPziyp5wmF3iRA8Rrg4tAFKQDJzHcRS7o9AjWwkPw9Xd/JWEM2zNreHZNeGEW0Ies6OYjGskY3r5+0SulIrT2udA7Ka3ChGlaePHRDSvpEhutF+vFOf0wPQg0ANwH372SJOEVv9FpejRf8atk8HJ+HFxrlUeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24D61A25;
	Thu, 18 Sep 2025 05:54:05 -0700 (PDT)
Received: from [192.168.20.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 828843F66E;
	Thu, 18 Sep 2025 05:54:13 -0700 (PDT)
Message-ID: <90c78c6d-2e73-44a6-b933-779477d15745@arm.com>
Date: Thu, 18 Sep 2025 07:54:12 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/7] arm64: probes: Add GCS support to bl/blr/ret
To: linux-trace-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, mhiramat@kernel.org, oleg@redhat.com,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com,
 thiago.bauermann@linaro.org, broonie@kernel.org, yury.khrustalev@arm.com,
 kristina.martsenko@arm.com, liaochang1@huawei.com, catalin.marinas@arm.com,
 will@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250825033421.463669-1-jeremy.linton@arm.com>
 <20250825033421.463669-5-jeremy.linton@arm.com>
Content-Language: en-US
From: Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20250825033421.463669-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/24/25 10:34 PM, Jeremy Linton wrote:
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
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> ---
>   arch/arm64/kernel/probes/simulate-insn.c | 44 +++++++++++++++++++-----
>   1 file changed, 35 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/kernel/probes/simulate-insn.c b/arch/arm64/kernel/probes/simulate-insn.c
> index 09a0b36122d0..97ed4db75417 100644
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
> @@ -49,6 +50,21 @@ static inline u32 get_w_reg(struct pt_regs *regs, int reg)
>   	return lower_32_bits(pt_regs_read_reg(regs, reg));
>   }
>   
> +static inline int update_lr(struct pt_regs *regs, long addr)
> +{
> +	int err = 0;
> +
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		push_user_gcs(addr, &err);
> +		if (err) {
> +			force_sig(SIGSEGV);
> +			return err;
> +		}
> +	}
> +	procedure_link_pointer_set(regs, addr);
> +	return err;
> +}
> +
>   static bool __kprobes check_cbz(u32 opcode, struct pt_regs *regs)
>   {
>   	int xn = opcode & 0x1f;
> @@ -107,9 +123,9 @@ simulate_b_bl(u32 opcode, long addr, struct pt_regs *regs)
>   {
>   	int disp = bbl_displacement(opcode);
>   
> -	/* Link register is x30 */
>   	if (opcode & (1 << 31))
> -		set_x_reg(regs, 30, addr + 4);
> +		if (update_lr(regs, addr + 4))
> +			return;
>   
>   	instruction_pointer_set(regs, addr + disp);
>   }
> @@ -129,21 +145,31 @@ void __kprobes
>   simulate_br_blr(u32 opcode, long addr, struct pt_regs *regs)
>   {
>   	int xn = (opcode >> 5) & 0x1f;
> +	int b_target = get_x_reg(regs, xn);

Ugh, I was staring at this set and realized that this type is wrong, it 
should be 'long'. I will send a patch once I sanity check it on 
something that isn't a model.


>   
> -	/* update pc first in case we're doing a "blr lr" */
> -	instruction_pointer_set(regs, get_x_reg(regs, xn));
> -
> -	/* Link register is x30 */
>   	if (((opcode >> 21) & 0x3) == 1)
> -		set_x_reg(regs, 30, addr + 4);
> +		if (update_lr(regs, addr + 4))
> +			return;
> +
> +	instruction_pointer_set(regs, b_target);
>   }
>   
>   void __kprobes
>   simulate_ret(u32 opcode, long addr, struct pt_regs *regs)
>   {
> +	u64 ret_addr;
> +	int err = 0;
>   	int xn = (opcode >> 5) & 0x1f;
> -
> -	instruction_pointer_set(regs, get_x_reg(regs, xn));
> +	unsigned long r_target = get_x_reg(regs, xn);
> +
> +	if (user_mode(regs) && task_gcs_el0_enabled(current)) {
> +		ret_addr = pop_user_gcs(&err);
> +		if (err || ret_addr != r_target) {
> +			force_sig(SIGSEGV);
> +			return;
> +		}
> +	}
> +	instruction_pointer_set(regs, r_target);
>   }
>   
>   void __kprobes

