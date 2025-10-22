Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3292EA146;
	Wed, 22 Oct 2025 05:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761110859; cv=none; b=LeAM+zcVNcAuFOywadkgbeU6jowXn9rjtKN1ZTnqT+lovglzGCWuteVi8g17w84ttByCva5XLp5LNyPDImtRW1nNEQn/YYYh9rQTr+eRiVB8WIuevuGThlO/33Yqgzz3Zac0dZJn1TNwWSrT7qxAeNBJ3KX6yaKk5YVcNKgrSL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761110859; c=relaxed/simple;
	bh=CMdKtjJakC4PRWfnRMn4BZN4cB1q58qD0lJeXy4UXwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7iOc+SyUeysLsMjUy4SlRY+10jjsuZHf2vg9eCm68vs4TwSIj77fIx/kNw0sqQfjA1pzL8BTHpInrFpIfA/AF6VoEfutJt8TdlXh6RBzsbnv7O/Pb+SKgOIyVj54WVX5dUMrzhISYYfJ24KXXqHj59KaOlulqVAMLWoee6ppjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSXqXM42; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSXqXM42"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761110857; x=1792646857;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CMdKtjJakC4PRWfnRMn4BZN4cB1q58qD0lJeXy4UXwQ=;
  b=SSXqXM42xEueGLuB2ts/yyU5pjxKV+qXm3p+KfcpAOMrRsb43MRy50XN
   7llFkDf+wYqoeGs8OdJBoCw35em6PTY/QuTPO6VeoVhfTNq2juJfCEjDi
   7vXe5PD471jHDvYMjNVxqEKAipLw+nlxUazUK66jDJsPTnlBR9Y97MtIt
   DkH/gXzQLVTcJ1+idtMVKK+JSFCWgSptIla6Ek36gXLhsG6353AxJKcSu
   OWeZrdNxTMcqb+xo028Zp8NgBXTek6Rc1M7woBUFESo46RnJQAdB8lzSU
   /fmaz0FzrbmbdVRV5YgdFSaXYMhUdfOloocO4Zt3cg+9nLErSmSyxg4BV
   A==;
X-CSE-ConnectionGUID: fmK903Z7SOqey51e6XhfxA==
X-CSE-MsgGUID: HL7KypReSTea4ik2mCj0yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62951365"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="62951365"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:27:37 -0700
X-CSE-ConnectionGUID: tGott0CCSv2MJ72NpdWhXg==
X-CSE-MsgGUID: ZFBdv2q9RyK8IGEXpwM0VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="182944771"
Received: from unknown (HELO [10.238.3.234]) ([10.238.3.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 22:27:34 -0700
Message-ID: <ba31c391-e703-4ff6-9742-4518d36bffa6@linux.intel.com>
Date: Wed, 22 Oct 2025 13:27:31 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v8 05/12] perf/x86/intel: Initialize architectural PEBS
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20251015064422.47437-1-dapeng1.mi@linux.intel.com>
 <20251015064422.47437-6-dapeng1.mi@linux.intel.com>
 <20251021154349.GR3245006@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20251021154349.GR3245006@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/21/2025 11:43 PM, Peter Zijlstra wrote:
> On Wed, Oct 15, 2025 at 02:44:15PM +0800, Dapeng Mi wrote:
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index c88bcd5d2bc4..bfb123ff7c9a 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -5273,34 +5273,58 @@ static inline bool intel_pmu_broken_perf_cap(void)
>>  
>>  static void update_pmu_cap(struct pmu *pmu)
>>  {
>> -	unsigned int cntr, fixed_cntr, ecx, edx;
>> -	union cpuid35_eax eax;
>> -	union cpuid35_ebx ebx;
>> +	unsigned int eax, ebx, ecx, edx;
>> +	union cpuid35_eax eax_0;
>> +	union cpuid35_ebx ebx_0;
>> +	u64 cntrs_mask = 0;
>> +	u64 pebs_mask = 0;
>> +	u64 pdists_mask = 0;
>>  
>> -	cpuid(ARCH_PERFMON_EXT_LEAF, &eax.full, &ebx.full, &ecx, &edx);
>> +	cpuid(ARCH_PERFMON_EXT_LEAF, &eax_0.full, &ebx_0.full, &ecx, &edx);
>>  
>> -	if (ebx.split.umask2)
>> +	if (ebx_0.split.umask2)
>>  		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_UMASK2;
>> -	if (ebx.split.eq)
>> +	if (ebx_0.split.eq)
>>  		hybrid(pmu, config_mask) |= ARCH_PERFMON_EVENTSEL_EQ;
>>  
>> -	if (eax.split.cntr_subleaf) {
>> +	if (eax_0.split.cntr_subleaf) {
>>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_NUM_COUNTER_LEAF,
>> -			    &cntr, &fixed_cntr, &ecx, &edx);
>> -		hybrid(pmu, cntr_mask64) = cntr;
>> -		hybrid(pmu, fixed_cntr_mask64) = fixed_cntr;
>> +			    &eax, &ebx, &ecx, &edx);
>> +		hybrid(pmu, cntr_mask64) = eax;
>> +		hybrid(pmu, fixed_cntr_mask64) = ebx;
>> +		cntrs_mask = (u64)ebx << INTEL_PMC_IDX_FIXED | eax;
>>  	}
>>  
>> -	if (eax.split.acr_subleaf) {
>> +	if (eax_0.split.acr_subleaf) {
>>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
>> -			    &cntr, &fixed_cntr, &ecx, &edx);
>> +			    &eax, &ebx, &ecx, &edx);
>>  		/* The mask of the counters which can be reloaded */
>> -		hybrid(pmu, acr_cntr_mask64) = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
>> +		hybrid(pmu, acr_cntr_mask64) = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
>>  
>>  		/* The mask of the counters which can cause a reload of reloadable counters */
>>  		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
>>  	}
>>  
>> +	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
>> +	if (eax_0.split.pebs_caps_subleaf && eax_0.split.pebs_cnts_subleaf) {
>> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_CAP_LEAF,
>> +			    &eax, &ebx, &ecx, &edx);
>> +		hybrid(pmu, arch_pebs_cap).caps = (u64)ebx << 32;
>> +
>> +		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
>> +			    &eax, &ebx, &ecx, &edx);
>> +		pebs_mask = ((u64)ecx << INTEL_PMC_IDX_FIXED) | eax;
>> +		pdists_mask = ((u64)edx << INTEL_PMC_IDX_FIXED) | ebx;
>> +		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
>> +		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;
>> +
>> +		if (WARN_ON((pebs_mask | pdists_mask) & ~cntrs_mask))
>> +			x86_pmu.arch_pebs = 0;
>> +	} else {
>> +		WARN_ON(x86_pmu.arch_pebs == 1);
>> +		x86_pmu.arch_pebs = 0;
>> +	}
>> +
>>  	if (!intel_pmu_broken_perf_cap()) {
>>  		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
>>  		rdmsrq(MSR_IA32_PERF_CAPABILITIES, hybrid(pmu, intel_cap).capabilities);
> I've stuck this on top.
>
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -5271,6 +5271,8 @@ static inline bool intel_pmu_broken_perf
>  	return false;
>  }
>  
> +#define counter_mask(_gp, _fixed) ((_gp) | ((u64)(_fixed) << INTEL_PMC_IDX_FIXED))
> +
>  static void update_pmu_cap(struct pmu *pmu)
>  {
>  	unsigned int eax, ebx, ecx, edx;
> @@ -5292,17 +5294,16 @@ static void update_pmu_cap(struct pmu *p
>  			    &eax, &ebx, &ecx, &edx);
>  		hybrid(pmu, cntr_mask64) = eax;
>  		hybrid(pmu, fixed_cntr_mask64) = ebx;
> -		cntrs_mask = (u64)ebx << INTEL_PMC_IDX_FIXED | eax;
> +		cntrs_mask = counter_mask(eax, ebx);
>  	}
>  
>  	if (eax_0.split.acr_subleaf) {
>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
>  			    &eax, &ebx, &ecx, &edx);
>  		/* The mask of the counters which can be reloaded */
> -		hybrid(pmu, acr_cntr_mask64) = eax | ((u64)ebx << INTEL_PMC_IDX_FIXED);
> -
> +		hybrid(pmu, acr_cntr_mask64) = counter_mask(eax, ebx);
>  		/* The mask of the counters which can cause a reload of reloadable counters */
> -		hybrid(pmu, acr_cause_mask64) = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
> +		hybrid(pmu, acr_cause_mask64) = counter_mask(ecx, edx);
>  	}
>  
>  	/* Bits[5:4] should be set simultaneously if arch-PEBS is supported */
> @@ -5313,8 +5314,8 @@ static void update_pmu_cap(struct pmu *p
>  
>  		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_PEBS_COUNTER_LEAF,
>  			    &eax, &ebx, &ecx, &edx);
> -		pebs_mask = ((u64)ecx << INTEL_PMC_IDX_FIXED) | eax;
> -		pdists_mask = ((u64)edx << INTEL_PMC_IDX_FIXED) | ebx;
> +		pebs_mask   = counter_mask(eax, ecx);
> +		pdists_mask = counter_mask(ebx, edx);
>  		hybrid(pmu, arch_pebs_cap).counters = pebs_mask;
>  		hybrid(pmu, arch_pebs_cap).pdists = pdists_mask;

Nice suggestion. Would do. Thanks.


>  
