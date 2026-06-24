Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF322E736B
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782286593; cv=none; b=q5zB+ojHHCEMwagqoNeovtKcQg6KPTnfMxeE+qzKbHkADw6QOiHJrZwVEqAti+PrCAdMgjz6EmQmzrGw3SU9ZvJ0a+wnAwKcwk62LuIh3sdsOZLTn/8We1Zooeek7LzHeYnPZm+G5AsTzNE7tRy9dKvuV35ryF+lrVCM+hSRU18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782286593; c=relaxed/simple;
	bh=GORlTa1Wgra6WRKUL+MJ+MsIYPj7Gc8sihpxBAOTIMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pg5xABZYussAKaAnKeOPws1uGaOYqXgPbEJDx2Vdy5vdB+82XbVKEKzWksexqRNJA3bRxEAeIbsmKVPG9EVgt3Cju3xC+3+EBckiiv4PV+FgbZsHWS7oJOx080+RA3LnYfPDNgO3cwJ3ljqI3yWkS0UcYUJNJZEvpBszLiLPCS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Mn96eHRe; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Mn96eHRe"
Message-ID: <85b09fd7-f849-46e5-a04d-1e76524943b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782286587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9T0Fze3KpG06xnYvjmlUmzBODU53xtqtwO9Goa0J3Rc=;
	b=Mn96eHResPBSCyPsmN5dNm1kiNQkCTSsU33kbZpT8C88/niYY9SZETrVoJxvV+a+zTZQIC
	+YvG/pf77lfyNVlF2y2HVKLafVkhr5dbK5jEpC043M26er9EcAK98KijzhbYZyI+bDoG/p
	KKKDAelxFmIFAoDN70FKLxT6PT9CdjE=
Date: Wed, 24 Jun 2026 00:36:17 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 07/21] RISC-V: Add Sscfg extension CSR definition
To: Charlie Jenkins <thecharlesjenkins@gmail.com>
Cc: James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Conor Dooley <conor@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20260608-counter_delegation-v6-0-285b72ed65a9@meta.com>
 <20260608-counter_delegation-v6-7-285b72ed65a9@meta.com>
 <ajjZkRxoh2F3vUAS@blinky>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <ajjZkRxoh2F3vUAS@blinky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 6/21/26 11:43 PM, Charlie Jenkins wrote:
> On Mon, Jun 08, 2026 at 11:01:21PM -0700, Atish Patra wrote:
>> From: Kaiwen Xue <kaiwenx@rivosinc.com>
>>
>> This adds the scountinhibit CSR definition and S-mode accessible hpmevent
>> bits defined by smcdeleg/ssccfg. scountinhibit allows S-mode to start/stop
>> counters directly from S-mode without invoking SBI calls to M-mode. It is
>> also used to figure out the counters delegated to S-mode by the M-mode as
>> well.
>>
>> Signed-off-by: Kaiwen Xue <kaiwenx@rivosinc.com>
>> Reviewed-by: Clément Léger <cleger@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/csr.h | 26 ++++++++++++++++++++++++++
>>   1 file changed, 26 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
>> index b4551a6cf7cb..26cb78dee2fd 100644
>> --- a/arch/riscv/include/asm/csr.h
>> +++ b/arch/riscv/include/asm/csr.h
>> @@ -241,6 +241,31 @@
>>   #define SMSTATEEN0_HSENVCFG		(_ULL(1) << SMSTATEEN0_HSENVCFG_SHIFT)
>>   #define SMSTATEEN0_SSTATEEN0_SHIFT	63
>>   #define SMSTATEEN0_SSTATEEN0		(_ULL(1) << SMSTATEEN0_SSTATEEN0_SHIFT)
>> +/* HPMEVENT bits. These are accessible in S-mode via Smcdeleg/Ssccfg */
>> +#ifdef CONFIG_64BIT
>> +#define HPMEVENT_OF			(BIT_ULL(63))
>> +#define HPMEVENT_MINH			(BIT_ULL(62))
>> +#define HPMEVENT_SINH			(BIT_ULL(61))
>> +#define HPMEVENT_UINH			(BIT_ULL(60))
>> +#define HPMEVENT_VSINH			(BIT_ULL(59))
>> +#define HPMEVENT_VUINH			(BIT_ULL(58))
>> +#else
>> +#define HPMEVENTH_OF			(BIT_ULL(31))
>> +#define HPMEVENTH_MINH			(BIT_ULL(30))
>> +#define HPMEVENTH_SINH			(BIT_ULL(29))
>> +#define HPMEVENTH_UINH			(BIT_ULL(28))
>> +#define HPMEVENTH_VSINH			(BIT_ULL(27))
>> +#define HPMEVENTH_VUINH			(BIT_ULL(26))
> Since these are rv32 bits for a 32-bit register, I think these should be
> BIT() instead of BIT_ULL()
>
>> +
>> +#define HPMEVENT_OF			(HPMEVENTH_OF << 32)
>> +#define HPMEVENT_MINH			(HPMEVENTH_MINH << 32)
>> +#define HPMEVENT_SINH			(HPMEVENTH_SINH << 32)
>> +#define HPMEVENT_UINH			(HPMEVENTH_UINH << 32)
>> +#define HPMEVENT_VSINH			(HPMEVENTH_VSINH << 32)
>> +#define HPMEVENT_VUINH			(HPMEVENTH_VUINH << 32)
> These definitions are identical to the rv64 ones, can these be removed
> and can you move the rv64 definitions to be global?

Good catch. Will fix this and the above in v8.

> - Charlie
>
>> +#endif
>> +
>> +#define SISELECT_SSCCFG_BASE		0x40
>>   
>>   /* mseccfg bits */
>>   #define MSECCFG_PMM			ENVCFG_PMM
>> @@ -322,6 +347,7 @@
>>   #define CSR_SCOUNTEREN		0x106
>>   #define CSR_SENVCFG		0x10a
>>   #define CSR_SSTATEEN0		0x10c
>> +#define CSR_SCOUNTINHIBIT	0x120
>>   #define CSR_SSCRATCH		0x140
>>   #define CSR_SEPC		0x141
>>   #define CSR_SCAUSE		0x142
>>
>> -- 
>> 2.53.0-Meta
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
