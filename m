Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2B236920F
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Jul 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783475478; cv=none; b=pdv1GgAxHCe9s90LIxD1OkFHB1hKw5O9ZJMUOd5EwxfNksO2m0kW58FB9JnyxnjZ6W9/lVaVmcZStgQfBFqF8PZru2EUqvt9UkpGPxN6HotY0xQiz2JlfbHQsaNvZzvygn19nh6Tq3Pddj/EwlMqjAP/qEmvGRmvOnSJ2QwJMIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783475478; c=relaxed/simple;
	bh=M6J9xy0+BOKRoXol88eKK2psXnvNYIqRGJqjhaGVl6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SeJBWWk9pwtaT7LhVdPIVaXtTUU55T3HdZc146Dbm3HWscKf0YPxmzwP0lEKzkfGIOqmDVKfCAElvuwlmCx9SvTYqlo3pG3xK0AE3Gy649swLN76XMGbiq1HgrdhX49/v/UAVUUzrO6hYWUcRiDIHVU43L+LChda1jH09iHyoyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GKJIdMUO; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GKJIdMUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783475475; x=1815011475;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M6J9xy0+BOKRoXol88eKK2psXnvNYIqRGJqjhaGVl6c=;
  b=GKJIdMUOVMVZ3nUu3N+i4FwUJI59hO+iu8n+VDdvrk/WuLp45Abk7qYp
   gsGlhnelg8Idy05uUZDfttxT4PVgveHe+U09bJtiARjQqvXOO2EaxlfNK
   M3GwLPM4C7sseanur6Zhh4q36SOLq6s5ldnzhPGj1fVu6vrtcxA5sg+xW
   YYb/KPrbo17MXz/aDfs2H8ba9bnG/Zhl7TE84Y7yI0Bllu7l4eZtFdcn4
   oNWEI1g/Dkv1ZAppxnLNGKZZHOFI0M7TxIiaeqqNkkLSrrUvWY8aq9BEu
   mTJYVvhwSL3cwIxp5GZ5se8w6YIHlwOQbMY4f8f3EzxFdFr1Zv7vlw6qQ
   A==;
X-CSE-ConnectionGUID: Q1h3xW7uRjWn/BdBdk8dsA==
X-CSE-MsgGUID: RZF5PH8ySMemdg+h+A99Ww==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="84189913"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="84189913"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:51:15 -0700
X-CSE-ConnectionGUID: lJE46sNtQc+oqHDJ343utg==
X-CSE-MsgGUID: /P03KBX6TtiFBucEjkvu9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="277358627"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.232.65]) ([10.124.232.65])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 18:51:13 -0700
Message-ID: <d7dc7222-04ae-445b-a609-0811214b9e32@linux.intel.com>
Date: Wed, 8 Jul 2026 09:51:11 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v9 22/24] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260706015439.3040804-1-dapeng1.mi@linux.intel.com>
 <20260706015439.3040804-23-dapeng1.mi@linux.intel.com>
 <20260706025721.A7D231F000E9@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260706025721.A7D231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 7/6/2026 10:57 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
>
> New issues:
> - [Critical] The `XSAVES` instruction writes PMU extended register state out-of-bounds due to incorrect buffer sizing in `reserve_ext_regs_buffers()`.
> - [Low] Fragile bitmask comparison using the strictly greater-than operator (`>`).
>
> Pre-existing issues:
> - [High] Pre-existing type confusion in `perf_reg_value` allowing out-of-bounds stack memory read/dereference via software PMUs.
> --
>
> commit 9750372940712500ad29f87f143032cba6ffbe36
> Author: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
>
> This commit enables the PERF_PMU_CAP_SIMD_REGS capability when XSAVES support
> is available for extended registers. It simplifies validation logic by tying
> the capability to XSAVES and architectural PEBS support.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 15962a3457eeb..56997731dc83a 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
> [ ... ]
>
>> @@ -6303,14 +6303,37 @@ static inline void __intel_update_pmu_xregs_caps(struct pmu *pmu)
>>  	 */
>>  	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
>>  
>> +	if (boot_cpu_has(X86_FEATURE_AVX) &&
>> +	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
>> +		x86_pmu.ext_regs_mask |= XFEATURE_MASK_YMM;
>> +	if (boot_cpu_has(X86_FEATURE_APX) &&
>> +	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
>> +		x86_pmu.ext_regs_mask |= XFEATURE_MASK_APX;
> [Severity: Critical]
> Can modifying this mask cause an out-of-bounds write during an NMI?
>
> When extended registers like APX are requested, the PMU allocates ext_regs_buf
> using xstate_calculate_size(x86_pmu.ext_regs_mask, compacted) in
> arch/x86/events/core.c:reserve_ext_regs_buffers(). This calculation omits the
> sizes of non-PMU active states like AMX.
>
> However, when xsaves_nmi() executes the XSAVES instruction in
> x86_pmu_sample_xregs(), the hardware determines compacted offsets based on ALL
> active CPU features (XCR0 | IA32_XSS). For a CPU with AMX enabled, XSAVES will
> write the APX state at an offset exceeding the allocated buffer size.
>
> Does this mismatch lead to a heap buffer overflow when XSAVES executes?

This is not true. xsaves_nmi() would take an argument. If the argument
doesn't contain AMX flag, AMX registers won't be really read. Since
currently perf doesn't support AMX sampling, so there would be on
out-of-bounds write.


>
>> +	if (boot_cpu_has(X86_FEATURE_AVX512F)) {
>> +		if (cpu_has_xfeatures(XFEATURE_MASK_OPMASK, NULL))
>> +			x86_pmu.ext_regs_mask |= XFEATURE_MASK_OPMASK;
>> +		if (cpu_has_xfeatures(XFEATURE_MASK_ZMM_Hi256, NULL))
>> +			x86_pmu.ext_regs_mask |= XFEATURE_MASK_ZMM_Hi256;
>> +		if (cpu_has_xfeatures(XFEATURE_MASK_Hi16_ZMM, NULL))
>> +			x86_pmu.ext_regs_mask |= XFEATURE_MASK_Hi16_ZMM;
>> +	}
>> +	if (cpu_feature_enabled(X86_FEATURE_USER_SHSTK))
>> +		x86_pmu.ext_regs_mask |= XFEATURE_MASK_CET_USER;
>> +
>>  	/* PEBS supported case */
>> -	if ((x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_XMM)) ||
>> -	    (x86_pmu.intel_cap.pebs_format >= 4 && x86_pmu.intel_cap.pebs_baseline))
>> +	if (x86_pmu.intel_cap.pebs_format >= 4 && x86_pmu.intel_cap.pebs_baseline)
>>  		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>> +	if (x86_pmu.arch_pebs && (caps & ARCH_PEBS_VECR_EXT)) {
>> +		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS |
>> +					  PERF_PMU_CAP_SIMD_REGS;
>> +	}
> [Severity: High]
> This is a pre-existing issue, but does enabling these capabilities expose a
> type confusion bug in software PMUs?
>
> In arch/x86/kernel/perf_regs.c:perf_reg_validate(), the PERF_REG_X86_RESERVED
> mask only covers bits 16-31. When simd_enabled is false, this allows a user
> requesting extended register bits (>= 32) to bypass validation.
>
> When a tracepoint fires, perf_output_sample_regs() passes a raw
> stack-allocated pt_regs pointer to perf_reg_value(). The perf_reg_value()
> function incorrectly casts it to a larger struct x86_perf_regs using
> container_of(), which reads the abi and xmm_regs fields from uninitialized
> adjacent stack memory and dereferences them.
>
> Can a user trigger this out-of-bounds stack read by creating a tracepoint or
> software PMU event with PERF_SAMPLE_REGS_INTR and requesting extended bits?

This would not really happen. The below code would check if
PERF_PMU_CAP_EXTENDED_REGS is set if  extended register bits are set.
Obviously, software PMU has no such cap PERF_PMU_CAP_EXTENDED_REG.

    if (!(pmu->capabilities & PERF_PMU_CAP_EXTENDED_REGS) &&
        event_has_extended_regs(event)) {
        ret = -EOPNOTSUPP;
        goto err_destroy;
    }



>
>>  
>>  	/* PEBS unsupported case (e.g., guest) */
>> -	if (!x86_pmu.intel_cap.pebs_format)
>> +	if (!x86_pmu.intel_cap.pebs_format) {
>>  		dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
>> +		if (x86_pmu.ext_regs_mask > XFEATURE_MASK_SSE)
> [Severity: Low]
> Is it safe to use a strictly greater-than operator here?
>
> If a new feature using bit 0 is ever added to ext_regs_mask, the mask
> value would become 3. The condition 3 > 2 evaluates to true, incorrectly
> enabling PERF_PMU_CAP_SIMD_REGS even if no SIMD extended features are
> supported.
>
> Could this use a bitwise comparison like (mask & ~XFEATURE_MASK_SSE) != 0
> instead?

Sure.


>
>> +			dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
>> +	}
>>  }
