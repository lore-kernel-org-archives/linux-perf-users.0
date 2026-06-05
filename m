Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32643B42F3;
	Fri,  5 Jun 2026 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676274; cv=none; b=kVHLBadjq0wNgKYaejL8ET4a+X/dn1iDxty18X2DRMnwDUf/6xWqN2Z3VHaiEbq5QaTK+WsV3nIW5f7CrgA0iuEPNfLlUDbjUXmO6auhg7px5TF6zFrGvD5M6mj2ssx0lu4XGt0DqkiYkxuV30GAN8/6rLqVjq3Ampe8PeGV1j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676274; c=relaxed/simple;
	bh=ZFF3LzL7GAx1OpUonDbdkuDrIwtGeyUdXwmuBI+QZSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EuO/lwB72LT3PEvaUpggCKcyK2JoOVk4aOD6jQLrk1n8ng336M7TIYbcniGbLqhFy1uj+OD876/vOyQ8llduVSLQ8vpUSTfDCAxoL3nirk8pUxOhiik6olKaTzhRCE6/IrtdHAkMRK/9kwdV2WZal6tuqFxefZK5tMFAU68u2bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLT4JvJ3; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLT4JvJ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780676273; x=1812212273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZFF3LzL7GAx1OpUonDbdkuDrIwtGeyUdXwmuBI+QZSE=;
  b=VLT4JvJ3ow3GpI9iarSbwl2SRrvZ60eXSKx1RvgHokKi8ViNVsg8SdsU
   WmpLQCOF5ISkKNP6OhbniSRVtSaHlbfAQAQBMmTmEVunA2giKQKjRHg7/
   3PbEnoqmSs6VHNfEH3UdxwN46RIWLTs7VqsilAMBTkSzC+22GFbvwaMP1
   TiZyQA/3jrY3WV5D/EsDntPpKJuyhq7S69Ngrh6Y+9KFE1Mcle99/hxTY
   9SzFFN5jy3nIdY6fR3vZtsY+onA+oVXYWMIUhGWwb4LSGk5W7p3l9w0vo
   ZIWUNp5PpZOmPezosBv3OsVqcDp/Fyi3cTKdABbG2JbJ4/iy2WFD76B8F
   A==;
X-CSE-ConnectionGUID: 52O1ScrLSxq55t8hSMODSQ==
X-CSE-MsgGUID: 4O/BPWEPQXCVRxwQ3OoOqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="81548043"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="81548043"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 09:17:52 -0700
X-CSE-ConnectionGUID: DiiT6IQMTlqiwPHlvBJTAg==
X-CSE-MsgGUID: Lhq1QOovQZuklFKiYPnyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="249214843"
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 09:17:51 -0700
Message-ID: <14b678b1-822a-46c2-8bb5-913622a77cac@intel.com>
Date: Fri, 5 Jun 2026 11:17:49 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260605011136.2043393-7-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/2026 8:11 PM, Dapeng Mi wrote:
> The memory allocation for the x86_pmu.hybrid_pmu[] array in
> intel_pmu_init_hybrid() can theoretically fail due to memory shortages.
> If this occurs, the initialization of the x86 hybrid PMU would fail.
> 
> Currently, the code does not check the return value of the
> intel_pmu_init_hybrid() function, which could lead to attempts to access
> the uninitialized x86_pmu.hybrid_pmu[] array, potentially causing a
> system panic.
> 
> So, adds a check for the return value of intel_pmu_init_hybrid() to

typo: adds -> add.

> prevent invalid memory access in such scenarios. Besides, free the
> created kmem cache when error occurs.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>


>  arch/x86/events/intel/core.c | 33 ++++++++++++++++++++++++++-------
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index ea3ab3050a3b..efd9caa3502c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7870,6 +7870,7 @@ __init int intel_pmu_init(void)
>  	int version, i;
>  	char *name;
>  	struct x86_hybrid_pmu *pmu;
> +	int ret;
>  
>  	/* Architectural Perfmon was introduced starting with Core "Yonah" */
>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
> @@ -8539,7 +8540,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		x86_pmu.pebs_latency_data = grt_latency_data;
>  		x86_pmu.get_event_constraints = adl_get_event_constraints;
> @@ -8597,7 +8600,9 @@ __init int intel_pmu_init(void)
>  	case INTEL_METEORLAKE:
>  	case INTEL_METEORLAKE_L:
>  	case INTEL_ARROWLAKE_U:
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		x86_pmu.pebs_latency_data = cmt_latency_data;
>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
> @@ -8628,7 +8633,9 @@ __init int intel_pmu_init(void)
>  		pr_cont("Pantherlake Hybrid events, ");
>  		name = "pantherlake_hybrid";
>  
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		/* Initialize big core specific PerfMon capabilities.*/
>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> @@ -8643,7 +8650,9 @@ __init int intel_pmu_init(void)
>  		pr_cont("Arrowlake Hybrid events, ");
>  		name = "arrowlake_hybrid";
>  
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		/* Initialize big core specific PerfMon capabilities.*/
>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> @@ -8660,7 +8669,9 @@ __init int intel_pmu_init(void)
>  		pr_cont("Lunarlake Hybrid events, ");
>  		name = "lunarlake_hybrid";
>  
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		/* Initialize big core specific PerfMon capabilities.*/
>  		pmu = &x86_pmu.hybrid_pmu[X86_HYBRID_PMU_CORE_IDX];
> @@ -8685,7 +8696,9 @@ __init int intel_pmu_init(void)
>  		break;
>  
>  	case INTEL_ARROWLAKE_H:
> -		intel_pmu_init_hybrid(hybrid_big_small_tiny);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
> +		if (ret < 0)
> +			goto err;
>  
>  		x86_pmu.pebs_latency_data = arl_h_latency_data;
>  		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
> @@ -8720,7 +8733,9 @@ __init int intel_pmu_init(void)
>  	case INTEL_NOVALAKE_L:
>  		pr_cont("Novalake Hybrid events, ");
>  		name = "novalake_hybrid";
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret < 0)
> +			goto err;
>  
>  		x86_pmu.pebs_latency_data = nvl_latency_data;
>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
> @@ -8885,6 +8900,10 @@ __init int intel_pmu_init(void)
>  	intel_aux_output_init();
>  
>  	return 0;
> +
> +err:
> +	kmem_cache_destroy(x86_get_pmu(smp_processor_id())->task_ctx_cache);
> +	return ret;
>  }
>  
>  /*

