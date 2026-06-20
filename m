Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EA0230BDB
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jun 2026 23:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781997926; cv=none; b=QuhGlEUeclRKMwEjYB0WlxUiaZGDUpgoh9KxxrHRwq23mhgBu38WzKt6ftKO9X3Tz79doK0kHy5RInXBvLIS5+7nlIokfgeoJ3Wr8YZiedUCUnJ0E4fJ38Ono6ErP2ll0aDkqyotXX1b6rWzsosaJ1SgQIPmc9v4inj25rYdT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781997926; c=relaxed/simple;
	bh=/b064bdXZNhVy1mTk/DGXPpDf0YJDnbCJX2bGMqud6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j5KKXdNekBjffA+/krvAtG5/0aEFC1ZEvbaxAAgAwYLlXSoXJL1Z+OBO//bQPhxOUEy6mzx+E4OubANVZRsN2L1VInTnzNW5r/D0nKajFY66eLUe/x+68LU9611oUU9sI02wVUuSKe16iTdRQ/n8wI1U59aq0xf/C6oelCSuZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pudnV4hA; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pudnV4hA"
Message-ID: <8a7c775a-4c81-4ed1-ab1e-356fc85bbf78@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781997912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bvtjD6I2KZP/SWA/i5nXjLd4czU9+VHJ/6bCQtfPK+c=;
	b=pudnV4hATFs5d+Y5vngjQfZObx0prgcmnjcgnZ47nyyH/Osev1x+T/Kh6IUYrdX66fBIu2
	ygFhg9pHe+rP/og+hCl0Ar8NEVwtp1ZSGYdUGnUuvfWck8Yv06Jt9qhKGPGL5hsCuoS1Aa
	3WFWjnMdYJmo2xP8u1DfvyrR+ytvXjU=
Date: Sat, 20 Jun 2026 16:25:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v6 13/21] RISC-V: perf: Implement supervisor counter
 delegation support
To: sashiko-reviews@lists.linux.dev
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260608-counter_delegation-v6-13-285b72ed65a9@meta.com>
 <20260609062339.F223A1F00893@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Atish Patra <atish.patra@linux.dev>
In-Reply-To: <20260609062339.F223A1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/8/26 11:23 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [High] Bitwise shift of signed 32-bit integer causes overflow and corrupts SCOUNTINHIBIT on 64-bit systems.
> - [High] Non-sampling events are permanently inhibited from counting because HPMEVENT_OF is unconditionally set but never cleared.
> - [High] On 32-bit architectures, `rvpmu_deleg_ctr_enable_irq` writes modified event configuration to the wrong CSR (`CSR_SIREG4` instead of `CSR_SIREG5`).
> - [High] SBI PMU snapshot logic breaks supervisor counter delegation by unconditionally bypassing S-mode CSR writes and reading stale shared memory.
> --
>
> commit ff1e171673cfe94a12c443765bd5b68dacf3b687
> Author: Atish Patra <atishp@rivosinc.com>
>
> RISC-V: perf: Implement supervisor counter delegation support
>
> This patch adds support for RISC-V ISA extensions (ssccfg, sscsrind,
> smcntrpmf) that allow programming hpmcounters directly from S-mode.
> It falls back to the SBI PMU extension if the hardware extensions are
> unavailable or for firmware counters.
>
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 46a25979e95e9..1f16df9d0dd00 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
> [ ... ]
>
>> -static u64 rvpmu_sbi_ctr_read(struct perf_event *event)
>> +static u64 rvpmu_ctr_read(struct perf_event *event)
>>   {
>>   	struct hw_perf_event *hwc = &event->hw;
>>   	int idx = hwc->idx;
> [Severity: High]
> Does this function still read stale data from the SBI shared memory when
> using supervisor counter delegation?
>
> If a platform supports both SBI PMU snapshots and S-mode counter delegation,
That's not a likely scenario as S-mode counter delegation is not 
available for VS mode.
> the code unconditionally reads from the SBI shared memory for stopped
> hardware counters. Since S-mode counters are stopped via direct CSR writes,
> the SBI firmware is bypassed and the shared memory is never updated.
>
> [ ... ]
>
>> +static void rvpmu_deleg_ctr_enable_irq(struct perf_event *event)
>> +{
>> +	unsigned long hpmevent_curr;
>> +	unsigned long of_mask;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +	int counter_idx = hwc->idx;
>> +	unsigned long sip_val = csr_read(CSR_SIP);
>> +
>> +	if (!is_sampling_event(event) || (sip_val & SIP_LCOFIP))
>> +		return;
> [Severity: High]
> Will this early return cause non-sampling events to never be counted?
>
> In update_deleg_hpmevent(), the HPMEVENT_OF bit is unconditionally set for
> all events. The Sscofpmf specification states a counter does not increment
> while its OF bit is 1. If we return early here for non-sampling events
> (like perf stat), the OF bit is never cleared, which would leave these
> counters permanently inhibited.
N/A. Incorrect spec understanding.
Sscofpmf's OF bit gates the LCOFI interrupt only. it does NOT stop the 
counter.
>>   
>> -	/* Reinitialize and start all the counter that overflowed */
>> -	while (ctr_ovf_mask) {
>> -		if (ctr_ovf_mask & 0x01) {
>> -			event = cpu_hw_evt->events[idx];
>> -			hwc = &event->hw;
>> -			max_period = riscv_pmu_ctr_get_width_mask(event);
>> -			init_val = local64_read(&hwc->prev_count) & max_period;
>>   #if defined(CONFIG_32BIT)
>> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
>> -				  flag, init_val, init_val >> 32, 0);
>> +	hpmevent_curr = csr_ind_read(CSR_SIREG5, SISELECT_SSCCFG_BASE, counter_idx);
>> +	of_mask = (u32)~HPMEVENTH_OF;
>>   #else
>> -			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, idx, 1,
>> -				  flag, init_val, 0, 0);
>> +	hpmevent_curr = csr_ind_read(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx);
>> +	of_mask = ~HPMEVENT_OF;
>>   #endif
>> -			perf_event_update_userpage(event);
>> -		}
>> -		ctr_ovf_mask = ctr_ovf_mask >> 1;
>> -		idx++;
>> -	}
>> +
>> +	hpmevent_curr &= of_mask;
>> +#if defined(CONFIG_32BIT)
>> +	csr_ind_write(CSR_SIREG4, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_curr);
> [Severity: High]
> Is this writing the event configuration to the wrong CSR?
>
> The code reads the high 32 bits of the event configuration from CSR_SIREG5
> and clears the HPMEVENTH_OF bit, but it writes the modified value back to
> CSR_SIREG4. Since CSR_SIREG4 maps to hpmcounterh, this might overwrite the
> running counter's upper 32 bits with the event configuration value instead
> of clearing the OF bit in the hpmevent register.

Good catch. Fixed it in v7.


>> +#else
>> +	csr_ind_write(CSR_SIREG2, SISELECT_SSCCFG_BASE, counter_idx, hpmevent_curr);
>> +#endif
>> +}
>> +
>> +static void rvpmu_deleg_ctr_start(struct perf_event *event, u64 ival)
>> +{
>> +	unsigned long scountinhibit_val = 0;
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +#if defined(CONFIG_32BIT)
>> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival & 0xFFFFFFFF);
>> +	csr_ind_write(CSR_SIREG4, SISELECT_SSCCFG_BASE, hwc->idx, ival >> BITS_PER_LONG);
>> +#else
>> +	csr_ind_write(CSR_SIREG, SISELECT_SSCCFG_BASE, hwc->idx, ival);
>> +#endif
>> +
>> +	rvpmu_deleg_ctr_enable_irq(event);
>> +
>> +	scountinhibit_val = csr_read(CSR_SCOUNTINHIBIT);
>> +	scountinhibit_val &= ~(1 << hwc->idx);
> [Severity: High]
> Could this bitwise shift result in sign-extension and corrupt SCOUNTINHIBIT
> on 64-bit systems?
>
> Because 1 is a signed 32-bit integer, (1 << 31) results in -2147483648.
> When this is negated by a bitwise NOT or cast to an unsigned long on a
> 64-bit architecture, it gets sign-extended (e.g., 0x000000007FFFFFFF).
> This could erroneously clear bits 32-63 of the SCOUNTINHIBIT CSR.
There are only 32 bit counters defined by architecture.
> Should this use 1UL << hwc->idx or the BIT() macro instead?
It's better coding standard to use BIT anyways. Fixed in v7.
> [ ... ]
>
>> -static void rvpmu_sbi_start_overflow_mask(struct riscv_pmu *pmu,
>> -					  u64 ctr_ovf_mask)
>> +/*
>> + * This function starts all the used counters in two step approach.
>> + * Any counter that did not overflow can be start in a single step
>> + * while the overflowed counters need to be started with updated initialization
>> + * value.
>> + */
>> +static void rvpmu_start_overflow_mask(struct riscv_pmu *pmu, u64 ctr_ovf_mask)
>>   {
>> +	int idx = 0, i;
>> +	struct perf_event *event;
>> +	unsigned long ctr_start_mask = 0;
>> +	u64 max_period, init_val = 0;
>> +	struct hw_perf_event *hwc;
>>   	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
>>   
>>   	if (sbi_pmu_snapshot_available())
>> -		rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
>> -	else
>> -		rvpmu_sbi_start_ovf_ctrs_sbi(cpu_hw_evt, ctr_ovf_mask);
>> +		return rvpmu_sbi_start_ovf_ctrs_snapshot(cpu_hw_evt, ctr_ovf_mask);
> [Severity: High]
> Does this check bypass S-mode delegation when both snapshot and delegation
> are available?
N/A. Not a likely scenario.
> If a platform supports both, this unconditionally calls
> rvpmu_sbi_start_ovf_ctrs_snapshot(), which starts S-mode delegated hardware
> counters using SBI ECALLs rather than direct S-mode CSR writes.
>
> [ ... ]
>
>> +static void update_deleg_hpmevent(int counter_idx, uint64_t event_value, uint64_t filter_bits)
>> +{
>> +	u64 hpmevent_value = 0;
>> +
>> +	/* OF bit should be enable during the start if sampling is requested */
>> +	hpmevent_value = (event_value & ~HPMEVENT_MASK) | filter_bits | HPMEVENT_OF;
> [Severity: High]
> Are we unconditionally setting the HPMEVENT_OF bit here?
>
> Although the comment states it should be enabled if sampling is requested,
> the bit is added for all events. Combined with the early return in
> rvpmu_deleg_ctr_enable_irq(), this causes non-sampling events to remain
> inhibited permanently.
N/A OF bit is for IRQ overflow not for inhibition.
> [ ... ]
>
>>   static void rvpmu_ctr_stop(struct perf_event *event, unsigned long flag)
>>   {
>> -	rvpmu_sbi_ctr_stop(event, flag);
>> -	/* TODO: Counter delegation implementation */
>> +	struct hw_perf_event *hwc = &event->hw;
>> +
>> +	if ((hwc->flags & PERF_EVENT_FLAG_USER_ACCESS) &&
>> +	    (hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
>> +		rvpmu_reset_scounteren((void *)event);
>> +
>> +	if (riscv_pmu_cdeleg_available() && !pmu_sbi_is_fw_event(event)) {
>> +		/*
>> +		 * The counter is already stopped. No need to stop again. Counter
>> +		 * mapping will be reset in clear_idx function.
>> +		 */
>> +		if (flag != RISCV_PMU_STOP_FLAG_RESET)
>> +			rvpmu_deleg_ctr_stop_mask((1 << hwc->idx));
> [Severity: High]
> Can this 32-bit shift overflow and corrupt the upper 32 bits of SCOUNTINHIBIT?
>
> Passing (1 << 31) will sign-extend to 0xFFFFFFFF80000000 on 64-bit systems.
> When passed to rvpmu_deleg_ctr_stop_mask, it ORs this mask into SCOUNTINHIBIT,
> which erroneously sets bits 32-63 to 1.
>
> Consider using 1UL << hwc->idx or the BIT() macro to prevent overflow.
Yes. Changed to use BIT macro.
