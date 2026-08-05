Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D283E51FF
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Aug 2026 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916823; cv=none; b=qMoKm7iw2ycfOJp6jFp4zXk3SioeHXRHbXV1vdOLG6v0H4R/Df9fvoAFWESfYzDaHc53QMQ1AkNiGOgp6Uijl9ihwKLNgDLgkqBy4QwF/5db9RKcDzjQl+pib/Z2p52fvPZbnVJEg8Z3RHLOLGwW1U5bfBcCt3TqyD74LWcmN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916823; c=relaxed/simple;
	bh=DghxUaFEo4H5drbY0nnJ1+G88E7CNu0hlkt7vJw4M2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=esN+eJphlUGAzNaKFKyUv0/NmzRk7i1pUEoz5+AzMZBeFWdGyfHovTbk9rQc8MyT9JBfC00XAa54zNQ/Y0aVTqEuCGSrmQFvWas4uBO8O2N2yokjpUUyPfcHIR197QKsyOSpDfZogJcG+2bXxNaJQrZSKeeR7KBe1Yxu2IZkp1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WcAGkTiL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WcAGkTiL"
Message-ID: <920aee80-5297-4d70-a1ea-616976db7f70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785916819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=db+v0NPIIndwhHMGIyL/nfOie4gWWsSLJbxQZ/GJglw=;
	b=WcAGkTiLyA/FOQnCkP705/KPLwXshGh5+z9mBuv6t97IY7n5FtK+a0rGEXw9mvzc/LMO0t
	YkSKmqCCvu4J//sHlBq/n/KtKAvRPzLH6nDJx+IgjxuEj1IjBqbwH9T/kmrywRIdrcsyov
	lsStOIycl8jtq/nhm92s03Bq1YXmn/Q=
Date: Wed, 5 Aug 2026 00:59:45 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 05/22] RISC-V: Define indirect CSR access helpers
To: Paul Walmsley <pjw@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh@kernel.org>, Anup Patel <anup@brainfault.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com>
 <20260701-counter_delegation-v8-5-7909f863a645@meta.com>
 <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <1b20aa77-0f0f-08c7-9439-972983adf709@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/4/26 5:39 PM, Paul Walmsley wrote:
> On Wed, 1 Jul 2026, Atish Patra wrote:
> 
>> From: Atish Patra <atishp@rivosinc.com>
>>
>> The indirect CSR requires multiple instructions to read/write CSR.
>> Add a few helper functions for ease of usage.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> 
> Thanks.  These macros seem better implemented as static inline functions.
> That also nicely aligns the code with what you write in the patch
> description.

I don't think inlining these macros in the following way will work 
because of the following reason. It won't build once anything calls it.

csr_read()/csr_write() stringify the CSR argument straight into the 
inline asm template:

#define csr_read(csr)                                         \
({                                                            \
       register unsigned long __v;                             \
       __asm__ __volatile__ ("csrr %0, " __ASM_STR(csr)        \
                             : "=r" (__v) :                    \
                             : "memory");                      \
       __v;                                                    \
})

so the CSR operand has to be a literal token. With iregcsr as a function
parameter the template becomes "csrr %0, iregcsr", which will result in 
the following compilation error

Error: unknown CSR `iregcsr'

The patch description should be fixed to indicate that these are macros.>
> Also, I renamed this file to change the abbreviation "ind" to "indirect",
> along the lines of this feedback here:
> 
>     https://lore.kernel.org/linux-riscv/CAHk-=whhSLGZAx3N5jJpb4GLFDqH_QvS07D+6BnkPWmCEzTAgw@mail.gmail.com/
> 
> This case is even worse since there are already uses of "csr_index" in
> the codebase, so it's even more unclear what "ind" is supposed to mean.
> 

Agreed on the expanding the abbreviation part and we should change it.

> Updated patch follows.  Please let me know if you have any objections,
> 
> 
> - Paul
> 
> From: Atish Patra <atishp@rivosinc.com>
> 
> RISC-V: Define indirect CSR access helpers
> 
> The indirect CSR requires multiple instructions to read/write CSR.
> Add a few helper functions for ease of usage.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Link: https://patch.msgid.link/20260701-counter_delegation-v8-5-7909f863a645@meta.com
> [pjw@kernel.org: expand "ind" abbreviation; use static inline functions rather than macros]
> Signed-off-by: Paul Walmsley <pjw@kernel.org>
> ---
>   arch/riscv/include/asm/csr_indirect.h | 51 +++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
>   create mode 100644 arch/riscv/include/asm/csr_indirect.h
> 
> diff --git a/arch/riscv/include/asm/csr_indirect.h b/arch/riscv/include/asm/csr_indirect.h
> new file mode 100644
> index 000000000000..3cd6a9059455
> --- /dev/null
> +++ b/arch/riscv/include/asm/csr_indirect.h
> @@ -0,0 +1,51 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_RISCV_CSR_INDIRECT_H
> +#define _ASM_RISCV_CSR_INDIRECT_H
> +
> +#include <linux/types.h>
> +#include <linux/irqflags.h>
> +
> +#include <asm/csr.h>
> +
> +static inline unsigned long csr_indirect_read(u16 iregcsr, u32 iselbase, u32 iseloff)
> +{
> +	unsigned long __value = 0;
> +	unsigned long __flags;
> +
> +	local_irq_save(__flags);
> +	csr_write(CSR_ISELECT, iselbase + iseloff);
> +	__value = csr_read(iregcsr);
> +	local_irq_restore(__flags);
> +
> +	return __value;
> +}
> +
> +static inline void csr_indirect_write(u16 iregcsr, u32 iselbase, u32 iseloff, unsigned long value)
> +{
> +	unsigned long __flags;
> +
> +	local_irq_save(__flags);
> +	csr_write(CSR_ISELECT, iselbase + iseloff);
> +	csr_write(iregcsr, (value));
> +	local_irq_restore(__flags);
> +}
> +
> +static inline unsigned long csr_indirect_warl(u16 iregcsr, u32 iselbase, u32 iseloff,
> +					      unsigned long warl_val)
> +{
> +	unsigned long __old_val = 0, __value = 0;
> +	unsigned long __flags;
> +
> +	local_irq_save(__flags);
> +	csr_write(CSR_ISELECT, iselbase + iseloff);
> +	__old_val = csr_read(iregcsr);
> +	csr_write(iregcsr, warl_val);
> +	__value = csr_read(iregcsr);
> +	csr_write(iregcsr, __old_val);
> +	local_irq_restore(__flags);
> +
> +	return __value;
> +}
> +
> +#endif

