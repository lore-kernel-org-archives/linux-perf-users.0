Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2C35F5E1
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302027; cv=none; b=i89++nRoylOouh6ByPrdD2xGqAaerCFqMnqEWTcAKsrqa/Uoh7k0mDgI4g7omMEIMlnL9zhoxLxs61bXfkgAip1DSX1tUGFE5sALnmiY3XEk/XPvkEa+vv913+CyPt+bYb8MC+SeZlzkmCag/VgWXwzC2JmT3n4qxSTvwURcoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302027; c=relaxed/simple;
	bh=Jv+tkOvsE9W+e0+h0T+6rSCtp1vy6Dq/oahWSVugIPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnX6buc+szhCSumxzrS8elY5Af1yYxhCczLZaQcvfFgDCMyP0dPQeAEt/oSGzRHVefF0Gaty3CdmEKcS2yxS5/VZXwliscGgkHioWqsaz2sivtCN/B6ztecwz193pX3qqEGZ4BEDDh6uv126xNBj8AEMbs8eCY3zFndnRCRkzfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXQ9Wp+1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXQ9Wp+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780302024; x=1811838024;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Jv+tkOvsE9W+e0+h0T+6rSCtp1vy6Dq/oahWSVugIPg=;
  b=PXQ9Wp+1j2RfQZHslueR/OQncbS2bZsvLq8Sed8BwI6gq48h4tZanTdi
   Simzu0rbGhyvahIxBLVa9oqShiN9ybsFEBPDqAsdoUCX0noP9dbpiKm1a
   Rj+l/zy0Ir6tUDDvWWR9T9pMMhF14s4isH8lv4mI/Em8/aRaedK5KEsEL
   dVpdCFfp6dVczjoEDqnVvhWl1IuF0QA9mLiYy2vp+oH4FxRHbNgVu0K1K
   u7nqaRtuYraxO2e3MPJ6TUf6MElWNdyYwI4W3O0eum858ycyoJ05tq1cw
   6pp3uyUaV3t3QrHqjOZzvu8vPMcfD9KjThZp4ENZkudVJd9+x9/Ti8fZW
   w==;
X-CSE-ConnectionGUID: NzrBloJGS2SShF6yL8zgwA==
X-CSE-MsgGUID: NDPIunvFRqyN+kJJU3cZfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80953274"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="80953274"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 01:20:24 -0700
X-CSE-ConnectionGUID: v7dnKO6OR3OdnUVciYeNSA==
X-CSE-MsgGUID: gMjjokPOQCOC9aO2Q91NzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="243607708"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 01:20:24 -0700
Message-ID: <9c3a798e-2f09-47c3-aa7d-aebead93a67b@linux.intel.com>
Date: Mon, 1 Jun 2026 16:20:21 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 18/23] perf/x86: Support eGPRs sampling using
 sample_regs_* fields
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-19-dapeng1.mi@linux.intel.com>
 <20260529093128.5E2681F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529093128.5E2681F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 5/29/2026 5:31 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
>
> New issues:
> - [Critical] The patch unconditionally rejects a mask of 0 when simd_enabled is false, breaking userspace ABI.
> - [High] The patch evaluates sample_regs_user and sample_regs_intr without verifying their respective flag gates are set.
> - [High] The 32-bit implementation of perf_reg_validate() is not updated to handle extended register masks, allowing a DoS via WARN_ON_ONCE.
>
> Pre-existing issues:
> - [Critical] perf_reg_value() blindly casts the raw pt_regs pointer to struct x86_perf_regs, leading to an out-of-bounds read for software events.
> - [Critical] perf_reg_validate() fails to mask out bits >= 32 when simd_enabled is false, allowing out-of-bounds register indices.
> --
>
> commit bffe5fdaa4de39f9a6532b899d96502d48077d9a
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86: Support eGPRs sampling using sample_regs_* fields
>
> This patch adds support for sampling APX eGPRs (R16 ~ R31) by reclaiming
> spare space in the sample_regs_* fields when sample_simd_regs_enabled is set.
> It updates perf_reg_value() and perf_reg_validate() to handle the new eGPRs
> bitmap alongside legacy XMM registers.
>
>> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
>> --- a/arch/x86/events/core.c
>> +++ b/arch/x86/events/core.c
> [ ... ]
>> @@ -708,26 +708,24 @@ int x86_pmu_hw_config(struct perf_event *event)
> [ ... ]
>>  		if (event_has_simd_regs(event)) {
>> +			u64 reserved = ~GENMASK_ULL(PERF_REG_MISC_MAX - 1, 0);
>> +
>>  			if (!(event->pmu->capabilities & PERF_PMU_CAP_SIMD_REGS))
>>  				return -EINVAL;
>>  			if (is_sampling_event(event) && !event->attr.precise_ip &&
>>  			    !this_cpu_has(X86_FEATURE_XSAVES))
>>  				return -EINVAL;
>> +			/*
>> +			 * The XMM space in the perf_event_x86_regs is reclaimed
>> +			 * for eGPRs and other general registers.
>> +			 */
>> +			if ((event->attr.sample_regs_user & reserved) ||
>> +			    (event->attr.sample_regs_intr & reserved))
>> +				return -EINVAL;
> [Severity: High]
> Is it safe to evaluate both sample_regs_user and sample_regs_intr here without
> first verifying their respective flag gates are set?
>
> If a user only sets one of the flags (e.g., PERF_SAMPLE_REGS_USER), does the
> other field contain uninitialized garbage from userspace? If that garbage
> happens to overlap with the reserved mask, it seems this could trigger
> validation failures and cause valid syscalls to randomly fail.

Sure. Would check this more accurately. 


>
> [ ... ]
>> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
>> --- a/arch/x86/events/perf_event.h
>> +++ b/arch/x86/events/perf_event.h
>> @@ -197,6 +197,16 @@ static inline bool event_needs_opmask(struct perf_event *event)
>>  	return false;
>>  }
>>  
>> +static inline bool event_needs_egprs(struct perf_event *event)
>> +{
>> +	if (event->attr.sample_simd_regs_enabled &&
>> +	    (event->attr.sample_regs_user & PERF_X86_EGPRS_MASK ||
>> +	     event->attr.sample_regs_intr & PERF_X86_EGPRS_MASK))
>> +		return true;
>> +
>> +	return false;
>> +}
> [Severity: High]
> Similarly to x86_pmu_hw_config(), does this evaluate sample_regs_user and
> sample_regs_intr without verifying their respective flag gates are set?
>
> Could uninitialized data from userspace falsely trigger this condition?

Sure. Would add more accurate check. 


>
> [ ... ]
>> diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
>> --- a/arch/x86/kernel/perf_regs.c
>> +++ b/arch/x86/kernel/perf_regs.c
>> @@ -61,14 +61,24 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
>>  {
>>  	struct x86_perf_regs *perf_regs;
>>  
>> -	if (idx >= PERF_REG_X86_XMM0 && idx < PERF_REG_X86_XMM_MAX) {
>> +	if (idx > PERF_REG_X86_R15) {
>>  		perf_regs = container_of(regs, struct x86_perf_regs, regs);
>> -		/* SIMD registers are moved to dedicated sample_simd_vec_reg */
>> -		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD)
>>  			return 0;
>> -		if (!perf_regs->xmm_regs)
>> -			return 0;
>> -		return perf_regs->xmm_regs[idx - PERF_REG_X86_XMM0];
>> +
>> +		if (perf_regs->abi & PERF_SAMPLE_REGS_ABI_SIMD) {
> [Severity: Critical]
> This is a pre-existing issue, but does casting the raw pt_regs pointer to
> struct x86_perf_regs lead to an out-of-bounds read for software events?
>
> For software events, the generic perf code passes a standard pt_regs pointer.
> Because the x86_perf_regs wrapper is not allocated for software events, using
> container_of() and reading perf_regs->abi appears to access memory past the
> end of the pt_regs struct.

No, software event won't really touch this part of code since it would lead
to event creation failure if a software event intends to sample the
registers which the software event doesn't support.


>
> [ ... ]
>>  #ifdef CONFIG_X86_32
>> -#define REG_NOSUPPORT ((1ULL << PERF_REG_X86_R8) | \
>> -		       (1ULL << PERF_REG_X86_R9) | \
>> -		       (1ULL << PERF_REG_X86_R10) | \
>> -		       (1ULL << PERF_REG_X86_R11) | \
>> -		       (1ULL << PERF_REG_X86_R12) | \
>> -		       (1ULL << PERF_REG_X86_R13) | \
>> -		       (1ULL << PERF_REG_X86_R14) | \
>> -		       (1ULL << PERF_REG_X86_R15))
>> +#define REG_NOSUPPORT GENMASK_ULL(PERF_REG_X86_R15, PERF_REG_X86_R8)
>>  
>>  int perf_reg_validate(u64 mask, bool simd_enabled)
> [Severity: High]
> Does the 32-bit implementation of perf_reg_validate() need to be updated to
> handle extended register masks?
>
> It looks like the 64-bit version was updated to reject bits 32-63 when
> simd_enabled is true, but the CONFIG_X86_32 block was missed. If a 32-bit
> user sets sample_simd_regs_enabled and requests bit 32, could this fall
> through to the WARN_ON_ONCE() in perf_reg_value() and allow a denial of
> service?

Yeah, the 32-bit corresponding support is missed, would add it. 


>
> [ ... ]
>> @@ -214,8 +218,13 @@ u64 perf_reg_abi(struct task_struct *task)
>>  
>>  int perf_reg_validate(u64 mask, bool simd_enabled)
>>  {
>> +	if (!simd_enabled &&
>> +	    (!mask || (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))))
>> +		return -EINVAL;
> [Severity: Critical]
> Does rejecting a mask of 0 when simd_enabled is false break the userspace ABI?
>
> Profiling tools sometimes set sample_regs_user = 0 to obtain the abi indicator
> field in the perf ring buffer without dumping any specific registers.

Actually this just follows the original behavior before this patchset. It's
an invalid behavior with the setting sample_regs_user = 0.


>
> [Severity: Critical]
> This is a pre-existing issue, but does this check fail to mask out bits >= 32
> when simd_enabled is false?
>
> PERF_REG_X86_RESERVED only covers bits 16-31. It appears to ignore bits 32-63.
> Could an unprivileged user request bit 63 for a software event, bypassing
> validation, and eventually hitting the WARN_ON_ONCE() and reading out of
> bounds in perf_reg_value()?

The bits [63:32] represents xmm0 - xmm15 when simd_enabled is false. As
previous comments said, software event can't sample these unsupported
registers. If a software event intends to sample these registers, then the
creation validation would fail.

Thanks.


>
>>  	/* The mask could be 0 if only the SIMD registers are interested */
>> -	if (mask & (REG_NOSUPPORT | PERF_REG_X86_RESERVED))
>> +	if (simd_enabled &&
>> +	    (mask & (REG_NOSUPPORT | PERF_REG_X86_EXT_RESERVED)))
>>  		return -EINVAL;
>>  
>>  	return 0;
