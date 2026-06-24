Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20092358367
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jun 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284411; cv=none; b=RbXZOBUz+BfA40HHVj4Fw/qYZ8EqbwZFxp7pPkRZO/mLLlowaItPVcvXvV+3SafVsW+O1dq065+uVbm5eyTmA7ej9DhDw7D3TUon3wdj4a8L7E4Oa85stQh8WkZmT0zG3mIENGrkBYZ0NuWmQggZc55QF8B25Cuf7g2/OQYNf3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284411; c=relaxed/simple;
	bh=pffaeaJ4G179rWWPKwwJFVgPNjYO2Ulg7w/Q+yMkdvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPx1hOL8patB6hQD3UVHnGHmHYbDwqPvJ5noQtK3FNrOa0H1IjX74A+1TJZZNzmA20ndwc9H7llIAE0Doz18MDgNO5rQFrMmryl9sUILqrvtM2LyiOrC97PtH85FPU2m7jTgtZUmum6eLMGY4826ZyVPmlRPws5B6r9SRb8phFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GCjf4y4G; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GCjf4y4G"
Message-ID: <c23bec7d-9571-4917-b23b-d6b08c2cc159@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782284407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GLWIFVQRHB5qd32LJSyZVW2YD4K906tt2u8jGkqFmSQ=;
	b=GCjf4y4G2cFqF2sb9SzQPMbGZ00TV7Isvch0xHsbC0kXWXnVhyj3D0TmXGNDbN8rAgLJT/
	ePYuWASdg1NFDZhlEXhW1GeGm8acBTbyUHj7wGiUqix5DPSY+wQ8QWagAXgQFz+O4qCTvm
	eNdJKVP7KC0FiRkQ+54md/XPjC6QTQ4=
Date: Wed, 24 Jun 2026 00:00:01 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 17/21] RISC-V: perf: Add Qemu virt machine events
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
 <20260608-counter_delegation-v6-17-285b72ed65a9@meta.com>
 <ajjZ5NljehUXERN1@blinky>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <ajjZ5NljehUXERN1@blinky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/21/26 11:44 PM, Charlie Jenkins wrote:
> On Mon, Jun 08, 2026 at 11:01:31PM -0700, Atish Patra wrote:
>> From: Atish Patra <atishp@rivosinc.com>
>>
>> Qemu virt machine supports a very minimal set of legacy perf events.
>> Add them to the vendor table so that users can use them when
>> counter delegation is enabled.
>>
>> Signed-off-by: Atish Patra <atishp@rivosinc.com>
>> ---
>>   arch/riscv/include/asm/vendorid_list.h |  4 ++++
>>   drivers/perf/riscv_pmu_sbi.c           | 36 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
>> index 7f5030ee1fcf..603aa2b21c0b 100644
>> --- a/arch/riscv/include/asm/vendorid_list.h
>> +++ b/arch/riscv/include/asm/vendorid_list.h
>> @@ -11,4 +11,8 @@
>>   #define SIFIVE_VENDOR_ID	0x489
>>   #define THEAD_VENDOR_ID		0x5b7
>>   
>> +#define QEMU_VIRT_VENDOR_ID		0x000
>> +#define QEMU_VIRT_IMPL_ID		0x000
>> +#define QEMU_VIRT_ARCH_ID		0x000
> Palmer proposed a change to this a while ago to set the archid for qemu
> as 42 but it looks like it was never merged in qemu, but it was merged
> into the riscv spec.
>
> Here is the spec PR: https://github.com/riscv/riscv-isa-manual/pull/1213
> Here is the current spec: https://github.com/riscv/riscv-isa-manual/blob/main/marchid.md
> Here is the QEMU patch: https://lore.kernel.org/all/20240131182430.20174-1-palmer@rivosinc.com/
>
> Should we follow up with this/maybe this should be accounted for here as
> an alternate id?

Ahh yes. I remember that thread now. Thanks for digging this.
Yes. We should resurrect that patch and use that archid as an alternate ID.

> - Charlie
>
>> +
>>   #endif
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 00b84b28117a..74acac54328e 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -26,6 +26,7 @@
>>   #include <asm/sbi.h>
>>   #include <asm/cpufeature.h>
>>   #include <asm/vendor_extensions.h>
>> +#include <asm/vendorid_list.h>
>>   #include <asm/vendor_extensions/andes.h>
>>   #include <asm/hwcap.h>
>>   #include <asm/csr_ind.h>
>> @@ -453,7 +454,42 @@ struct riscv_vendor_pmu_events {
>>   	  .hw_event_map = _hw_event_map, .cache_event_map = _cache_event_map, \
>>   	  .attrs_events = _attrs },
>>   
>> +/* QEMU virt PMU events */
>> +static const struct riscv_pmu_event qemu_virt_hw_event_map[PERF_COUNT_HW_MAX] = {
>> +	PERF_MAP_ALL_UNSUPPORTED,
>> +	[PERF_COUNT_HW_CPU_CYCLES]		= {0x01, 0xFFFFFFF8},
>> +	[PERF_COUNT_HW_INSTRUCTIONS]		= {0x02, 0xFFFFFFF8}
>> +};
>> +
>> +static const struct riscv_pmu_event qemu_virt_cache_event_map[PERF_COUNT_HW_CACHE_MAX]
>> +						[PERF_COUNT_HW_CACHE_OP_MAX]
>> +						[PERF_COUNT_HW_CACHE_RESULT_MAX] = {
>> +	PERF_CACHE_MAP_ALL_UNSUPPORTED,
>> +	[C(DTLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10019, 0xFFFFFFF8},
>> +	[C(DTLB)][C(OP_WRITE)][C(RESULT_MISS)]	= {0x1001B, 0xFFFFFFF8},
>> +
>> +	[C(ITLB)][C(OP_READ)][C(RESULT_MISS)]	= {0x10021, 0xFFFFFFF8},
>> +};
>> +
>> +RVPMU_EVENT_CMASK_ATTR(cycles, cycles, 0x01, 0xFFFFFFF8);
>> +RVPMU_EVENT_CMASK_ATTR(instructions, instructions, 0x02, 0xFFFFFFF8);
>> +RVPMU_EVENT_CMASK_ATTR(dTLB-load-misses, dTLB_load_miss, 0x10019, 0xFFFFFFF8);
>> +RVPMU_EVENT_CMASK_ATTR(dTLB-store-misses, dTLB_store_miss, 0x1001B, 0xFFFFFFF8);
>> +RVPMU_EVENT_CMASK_ATTR(iTLB-load-misses, iTLB_load_miss, 0x10021, 0xFFFFFFF8);
>> +
>> +static struct attribute *qemu_virt_event_group[] = {
>> +	RVPMU_EVENT_ATTR_PTR(cycles),
>> +	RVPMU_EVENT_ATTR_PTR(instructions),
>> +	RVPMU_EVENT_ATTR_PTR(dTLB_load_miss),
>> +	RVPMU_EVENT_ATTR_PTR(dTLB_store_miss),
>> +	RVPMU_EVENT_ATTR_PTR(iTLB_load_miss),
>> +	NULL,
>> +};
>> +
>>   static struct riscv_vendor_pmu_events pmu_vendor_events_table[] = {
>> +	RISCV_VENDOR_PMU_EVENTS(QEMU_VIRT_VENDOR_ID, QEMU_VIRT_ARCH_ID, QEMU_VIRT_IMPL_ID,
>> +				qemu_virt_hw_event_map, qemu_virt_cache_event_map,
>> +				qemu_virt_event_group)
>>   };
>>   
>>   static const struct riscv_pmu_event *current_pmu_hw_event_map;
>>
>> -- 
>> 2.53.0-Meta
>>
>>
