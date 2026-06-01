Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4F638F935
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 09:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780305592; cv=none; b=DVMEEpM8j/SDUXupEX/gOKqvjeVes30YqHn1xI829CMvRwW9j65riMPuOg9EmXptQGB7HUZhQQjTsVkLGk8I6l+H31ZOij3EA03YjX4OVdXHilZdo1XO8X8dG9g6OzaFFGknOCIkRW8fNQvLaodEDnD7nqdnYB5D2ly2LoORrwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780305592; c=relaxed/simple;
	bh=QwhucfDRYoWhSScz8XT81lIBqwPfUlqAX1rvYsnCZxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFq72F5kBogDw3n+9AAwkdakL2/sjcYu4p4JmU+yKlb1XkRE+FiW73HMyYM9YYgrYt8AxavGAMcMSlJl8RojfiCmX180d6mi597UUC5EDCWuTcAiAHGlsEA0RDzqXWu5lo5laeiOQERXOtnlxAXH61c7WCZWnNBBQidUbb2U4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nR5+J27U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nR5+J27U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780305591; x=1811841591;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QwhucfDRYoWhSScz8XT81lIBqwPfUlqAX1rvYsnCZxE=;
  b=nR5+J27U6Naf56JX8ulDjgaN1QKUuC+9ihT0bmA57PBLgAzwYcYPRj2C
   6gwnLcncElBuCqCedBVHLD5caTJy9Mbt25xpl8NlDmEhbd02ZWX2zFidq
   mX0TNjJ+qLatQwcOOs8obshYL4fV9O67NKfmSl9b4p5utF6rft2w6PCRJ
   Xf5kh0yGerFcJzPUo3r0HTQ0+shgUydTglKqRCn8ezP+wpQU7XvxzrCKb
   aVKPxMX74LEAZN2PLLWJDad+STm29nILDbfqm9awG3i+PwbTdllh7Qybx
   ZKCD9pikfaLN/61BVplm1FTVn9bm7Fb2/TIfiNh+uMX60xODDSvYed8j4
   Q==;
X-CSE-ConnectionGUID: Y9n9//3ZSxivydkTDBDefA==
X-CSE-MsgGUID: ogA8MeX/Qyyb1PLN6NgExQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="103730528"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="103730528"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:51 -0700
X-CSE-ConnectionGUID: YibmStLuRjusGKEiVD647w==
X-CSE-MsgGUID: R0y04k5JRyamkQlJszb6/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="239339653"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 02:19:50 -0700
Message-ID: <38e5536b-cd8f-4d3d-aee9-2eb622d942b3@linux.intel.com>
Date: Mon, 1 Jun 2026 17:19:47 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 21/23] perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS
 capability
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
References: <20260529075645.580362-22-dapeng1.mi@linux.intel.com>
 <20260529104309.C69DB1F00893@smtp.kernel.org>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260529104309.C69DB1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 5/29/2026 6:43 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] The new SIMD registers capability and mask initialization are skipped for older PEBS V4+ architectures (like Icelake, Sapphire Rapids, Alder Lake, and Raptor Lake), leaving them without support for YMM, ZMM, eGPRs, and SSP sampling.
> - [Medium] The logic to enable PERF_PMU_CAP_SIMD_REGS incorrectly couples the capability to the presence of non-SIMD extended features like CET_USER (SSP) and APX (eGPRs).
> --
>
> commit f179abf9419fef51aa84e8c413e619d7004c64c2
> Author: Kan Liang <kan.liang@linux.intel.com>
>
> perf/x86/intel: Enable PERF_PMU_CAP_SIMD_REGS capability
>
> Enable the PERF_PMU_CAP_SIMD_REGS capability if XSAVES support is
> available for YMM, ZMM, OPMASK, eGPRs, or SSP.
>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 679781519f8cf..eef5d116aa068 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6316,6 +6316,26 @@ static void intel_extended_regs_init(struct pmu *pmu)
>>  	 */
>>  	x86_pmu.ext_regs_mask |= XFEATURE_MASK_SSE;
>>  	dest_pmu->capabilities |= PERF_PMU_CAP_EXTENDED_REGS;
> [Severity: High]
> Does this skip the new SIMD capabilities on older PEBS V4+ architectures?
>
> The initialization for YMM, ZMM, eGPRs, and SSP is only added to
> intel_extended_regs_init(). Since intel_extended_regs_init() is called
> by update_pmu_cap(), which is guarded by X86_FEATURE_ARCH_PERFMON_EXT,
> architectures like Sapphire Rapids and Alder Lake appear to bypass this.
>
> Should this logic also be replicated in intel_ds_pebs_init(), or should
> intel_extended_regs_init() be called for those processors so they can
> also support the new SIMD capabilities?

As previous comments said, currently the setting of these 2 capabilities
has some kind of inconsistency. To mitigate this inconsistency, the 2
capabilities would be set by following below rules.

1. Only when both legacy PEBS and xsaves support XMM sampling, then
PERF_PMU_CAP_EXTENDED_REGS is set.

2. Only when both arch-PEBS and xsaves support XMM and other SIMD registers
sampling, then PERF_PMU_CAP_SIMD_REGS can be set.


>
>> +
>> +	if (boot_cpu_has(X86_FEATURE_AVX) &&
>> +	    cpu_has_xfeatures(XFEATURE_MASK_YMM, NULL))
>> +		x86_pmu.ext_regs_mask |= XFEATURE_MASK_YMM;
>> +	if (boot_cpu_has(X86_FEATURE_APX) &&
>> +	    cpu_has_xfeatures(XFEATURE_MASK_APX, NULL))
>> +		x86_pmu.ext_regs_mask |= XFEATURE_MASK_APX;
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
>> +	if (x86_pmu.ext_regs_mask != XFEATURE_MASK_SSE)
>> +		dest_pmu->capabilities |= PERF_PMU_CAP_SIMD_REGS;
> [Severity: Medium]
> Does this incorrectly couple the SIMD capability to non-SIMD features here?
>
> If a processor supports SSE and CET_USER (SSP), ext_regs_mask will not equal
> XFEATURE_MASK_SSE, and PERF_PMU_CAP_SIMD_REGS will be enabled.
>
> However, if a processor only supports SSE, this condition evaluates to false,
> and PERF_PMU_CAP_SIMD_REGS is omitted.
>
> Could this regression force userspace tools to fall back to a separate legacy
> path to sample XMM registers on SSE-only processors, rather than using the
> unified sample_simd_regs interface?

This issue would be resolved by follow above rules.

Thanks.


>
>>  }
>>  
>>  #define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
