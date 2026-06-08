Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F782EEE95;
	Mon,  8 Jun 2026 02:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780886903; cv=none; b=DVGhIs9Z5WCAXBUaIEyiwHFJKguiKff6RNmRixYR8FXWVbVD9XhE6OrBpQrOSOEYWr4SziVe6YHKeOl20kIwTnR4oPFXlrr5yNK9K51LRmyM2o24e3dYsAJQvq1LIGCXwaCSFBbIz1aLpL678sg4ItYm+/WyVmPUgzoQicSplno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780886903; c=relaxed/simple;
	bh=IqmV+9cbIijJV5OP0c+lMA5/3eE0HQdbhxXWAPNZd5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzcPPHwz0LEhZIgRkx/oo2NU7hPRdoP1qqHgUSvhhGU4DF4rfqUBCK9wpVEivI7ZkR7SGz7VzprTN9AskrVBaBj5H+KHS5kwBlhVtYlDEguQ+w24vZRmcQzCP4vS0XruU1lBqIkaZkheEqz7atsl/+vw8ACjiqU2y/klF4px9Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UXdoZ3Eo; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UXdoZ3Eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780886902; x=1812422902;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IqmV+9cbIijJV5OP0c+lMA5/3eE0HQdbhxXWAPNZd5Q=;
  b=UXdoZ3EoRG8HQhpoCX8vta0Ypa94Wkn2LguI2253d7LwKBOnHfALvmb9
   YHJ/48XWVguKSIDTy8j88liL4o0Hw4Ds8nR7Ey7BKH1rP1GNlPZLpa9l5
   IPGYVTOxAX18tMliCRh1UhET+XZx/PVO3AoThZZjEcoSIIvWzGE1tf9YD
   AV6GOetjR/IjI6L/DoxBu6zBVYmjliNTIfc7I/xK1NEch5FGpx5ZYxgtz
   frbTP3pPM2dsDf28ueuefUJazsGC6H57MiUeSp00kRyf0KVIzLKKHj7LF
   uXrbdDiatd3QyIefuIAqVwG6pXhs2kwmCkttvJg8Qp4nwv/sosw/kt4PF
   Q==;
X-CSE-ConnectionGUID: iCO3DPHtQfWtWL0NKoEjpw==
X-CSE-MsgGUID: PW4WkvsATrGYeARye1ck+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="81737733"
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="81737733"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:48:21 -0700
X-CSE-ConnectionGUID: pthRf32/QKiqq+APwipXrg==
X-CSE-MsgGUID: 9NFeLclGT4G4pAn5wnQfVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,193,1774335600"; 
   d="scan'208";a="249338040"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 19:48:18 -0700
Message-ID: <e758f607-83e8-48a3-88b3-a5cae5b897bd@linux.intel.com>
Date: Mon, 8 Jun 2026 10:48:15 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20260605011136.2043393-1-dapeng1.mi@linux.intel.com>
 <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
 <14b678b1-822a-46c2-8bb5-913622a77cac@intel.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <14b678b1-822a-46c2-8bb5-913622a77cac@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/6/2026 12:17 AM, Chen, Zide wrote:
>
> On 6/4/2026 8:11 PM, Dapeng Mi wrote:
>> The memory allocation for the x86_pmu.hybrid_pmu[] array in
>> intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
>> If this occurs, the initialization of the x86 hybrid PMU would fail.
>>
>> Currently, the code does not check the return value of the
>> intel_pmu_init_hybrid() function, which could lead to attempts to access
>> the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
>> system panic.
>>
>> So, adds a check for the return value of intel_pmu_init_hybrid() to
> typo: adds -> add.

Sure. Thanks.


>
>> prevent invalid memory access in such scenarios. Besides, free the
>> created kmem cache when error occurs.
>>
>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>> ---
> Reviewed-by: Zide Chen <zide.chen@intel.com>
>
>
>>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++-------
>>  1 file changed, 26 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index ea3ab3050a3b..efd9caa3502c 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
>>  	int version, i;
>>  	char *name;
>>  	struct x86_hybrid_pmu *pmu;
>> +	int ret;
>>  
>>  	/* Architectural Perfmon was introduced starting with Core "Yonah" */
>>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
>> @@ -8539,7 +8540,9 @@ __init int intel_pmu_init(void)
>>  		 *
>>  		 * Initialize the common PerfMon capabilities here.
>>  		 */
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		x86_pmu.pebs_latency_data = grt_latency_data;
>>  		x86_pmu.get_event_constraints = adl_get_event_constraints;
>> @@ -8597,7 +8600,9 @@ __init int intel_pmu_init(void)
>>  	case INTEL_METEORLAKE:
>>  	case INTEL_METEORLAKE_L:
>>  	case INTEL_ARROWLAKE_U:
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		x86_pmu.pebs_latency_data = cmt_latency_data;
>>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
>> @@ -8628,7 +8633,9 @@ __init int intel_pmu_init(void)
>>  		pr_cont("Pantherlake Hybrid events, ");
>>  		name = "pantherlake_hybrid";
>>  
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		/* Initialize big core specific PerfMon capabilities.*/
>>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>> @@ -8643,7 +8650,9 @@ __init int intel_pmu_init(void)
>>  		pr_cont("Arrowlake Hybrid events, ");
>>  		name = "arrowlake_hybrid";
>>  
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		/* Initialize big core specific PerfMon capabilities.*/
>>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>> @@ -8660,7 +8669,9 @@ __init int intel_pmu_init(void)
>>  		pr_cont("Lunarlake Hybrid events, ");
>>  		name = "lunarlake_hybrid";
>>  
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		/* Initialize big core specific PerfMon capabilities.*/
>>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
>> @@ -8685,7 +8696,9 @@ __init int intel_pmu_init(void)
>>  		break;
>>  
>>  	case INTEL_ARROWLAKE_H:
>> -		intel_pmu_init_hybrid(hybrid_big_small_tiny);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		x86_pmu.pebs_latency_data = arl_h_latency_data;
>>  		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
>> @@ -8720,7 +8733,9 @@ __init int intel_pmu_init(void)
>>  	case INTEL_NOVALAKE_L:
>>  		pr_cont("Novalake Hybrid events, ");
>>  		name = "novalake_hybrid";
>> -		intel_pmu_init_hybrid(hybrid_big_small);
>> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
>> +		if (ret < 0)
>> +			goto err;
>>  
>>  		x86_pmu.pebs_latency_data = nvl_latency_data;
>>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
>> @@ -8885,6 +8900,10 @@ __init int intel_pmu_init(void)
>>  	intel_aux_output_init();
>>  
>>  	return 0;
>> +
>> +err:
>> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
>> +	return ret;
>>  }
>>  
>>  /*
>
