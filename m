Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B9A2D29CF;
	Wed, 10 Jun 2026 08:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080477; cv=none; b=P1x10kNy0SvNAtCxqsH+IRahhU8BHFlpZuV3I/3fgzxuwihmT0NInSvPRTqvwLSDqYe5YqW0GsF2PSNECCvwVmclMo1ilHanDBlWFLc2mYXUSXFc+3LVrkQYprD62IpveyMQeo22plw+ek/ihvGkXOLehDfVTZM4vKz90sWlIBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080477; c=relaxed/simple;
	bh=y8hp8tmD6MUNyg4+xKsInJNdxF1n567Pck7YTXAvCt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvFea6q6q4HULCNDEHhKJahhFMcRjQ6WMA1JNJXphmYPDcrSsTotWko1jUMkITvShvi0Xxnm09MbEAXKf/nJIKhV05FDKGk9GOxt0dbO/C/BYPjE+c1sF/ika8B0Twlov6fwYDcjN8gzxUJ1zL13/CmDR4/ZLx3ap7koyBi+Mfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O7L5zOND; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O7L5zOND"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781080476; x=1812616476;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=y8hp8tmD6MUNyg4+xKsInJNdxF1n567Pck7YTXAvCt0=;
  b=O7L5zONDHDJ4so6B4NCVyGJMrtwBAvh9+0BrfSMavtFd+4PZj+6YPfbS
   wAoacSNiOD5ZmsuDDd+g4ZyyXzsSyGRfvxUROfH0UTUj/h+VRxU8bcBZS
   OIZ2kwc6/xBNZqUAs3yfCUPMOGgoAYdi9vj8U2BZm7CRiM5vkhxZzD+zq
   dQbWCYaDO/VzMua5uPrM6PqSZPREO9mnktUB8kdVPFBU68FIqBrpcNSaV
   FvUjK8Yj4qFFs8sfH5+d/dp99w0UXFHPltSJP82ZcFOmLZ+Vsm2eNwNcC
   chcwGbIkegCnnB2tvoktuI0pPQ+NqXVY6Xz7vavnp20li4M0rzeGXfUy3
   A==;
X-CSE-ConnectionGUID: hfrzpG+jQVaj1ft8/OTODQ==
X-CSE-MsgGUID: 7L36cqEnRiWlmiEOiaF5yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="85759439"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="85759439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:34:35 -0700
X-CSE-ConnectionGUID: pSHcTVRYQ1qvTDL0B/Sk8g==
X-CSE-MsgGUID: qE2Nm53pTvGa+CkWMEC6dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="243644995"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.241.147]) ([10.124.241.147])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 01:34:31 -0700
Message-ID: <95badf83-bbed-4d64-8808-243108fff841@linux.intel.com>
Date: Wed, 10 Jun 2026 16:34:29 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 6/9] perf/x86/intel: Validate return value of
 intel_pmu_init_hybrid()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Zide Chen <zide.chen@intel.com>,
 Falcon Thomas <thomas.falcon@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20260609050222.2458129-1-dapeng1.mi@linux.intel.com>
 <20260609050222.2458129-7-dapeng1.mi@linux.intel.com>
 <20260610081621.GE49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260610081621.GE49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/10/2026 4:16 PM, Peter Zijlstra wrote:
> Would not something like so work?
>
> I could not find a reason we *have* to init arch lbr that early -- but
> perhaps I didn't look hard enough?
>
> ---
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index d9488ade0f8e..4e551f240b2b 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7534,14 +7534,14 @@ __init int intel_pmu_init(void)
>  	struct attribute **td_attr    = &empty_attrs;
>  	struct attribute **mem_attr   = &empty_attrs;
>  	struct attribute **tsx_attr   = &empty_attrs;
> +	struct x86_hybrid_pmu *pmu;
> +	unsigned int fixed_mask;
>  	union cpuid10_edx edx;
>  	union cpuid10_eax eax;
>  	union cpuid10_ebx ebx;
> -	unsigned int fixed_mask;
> +	int version, i, ret;
>  	bool pmem = false;
> -	int version, i;
>  	char *name;
> -	struct x86_hybrid_pmu *pmu;
>  
>  	/* Architectural Perfmon was introduced starting with Core "Yonah" */
>  	if (!cpu_has(&boot_cpu_data, X86_FEATURE_ARCH_PERFMON)) {
> @@ -7611,9 +7611,6 @@ __init int intel_pmu_init(void)
>  		x86_pmu.lbr_read = intel_pmu_lbr_read_32;
>  	}
>  
> -	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
> -		intel_pmu_arch_lbr_init();
> -
>  	intel_pebs_init();
>  
>  	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
> @@ -8216,7 +8213,9 @@ __init int intel_pmu_init(void)
>  		 *
>  		 * Initialize the common PerfMon capabilities here.
>  		 */
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret)
> +			return ret;
>  
>  		x86_pmu.pebs_latency_data = grt_latency_data;
>  		x86_pmu.get_event_constraints = adl_get_event_constraints;
> @@ -8274,7 +8273,9 @@ __init int intel_pmu_init(void)
>  	case INTEL_METEORLAKE:
>  	case INTEL_METEORLAKE_L:
>  	case INTEL_ARROWLAKE_U:
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret)
> +			return ret;
>  
>  		x86_pmu.pebs_latency_data = cmt_latency_data;
>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
> @@ -8313,7 +8314,9 @@ __init int intel_pmu_init(void)
>  		name = "lunarlake_hybrid";
>  
>  	lnl_common:
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret)
> +			return ret;
>  
>  		x86_pmu.pebs_latency_data = lnl_latency_data;
>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
> @@ -8337,7 +8340,9 @@ __init int intel_pmu_init(void)
>  		break;
>  
>  	case INTEL_ARROWLAKE_H:
> -		intel_pmu_init_hybrid(hybrid_big_small_tiny);
> +		ret = intel_pmu_init_hybrid(hybrid_big_small_tiny);
> +		if (ret)
> +			return ret;
>  
>  		x86_pmu.pebs_latency_data = arl_h_latency_data;
>  		x86_pmu.get_event_constraints = arl_h_get_event_constraints;
> @@ -8371,7 +8376,9 @@ __init int intel_pmu_init(void)
>  	case INTEL_NOVALAKE_L:
>  		pr_cont("Novalake Hybrid events, ");
>  		name = "novalake_hybrid";
> -		intel_pmu_init_hybrid(hybrid_big_small);
> +		ret  = intel_pmu_init_hybrid(hybrid_big_small);
> +		if (ret)
> +			return ret;
>  
>  		x86_pmu.pebs_latency_data = nvl_latency_data;
>  		x86_pmu.get_event_constraints = mtl_get_event_constraints;
> @@ -8478,6 +8485,9 @@ __init int intel_pmu_init(void)
>  
>  	intel_pmu_check_event_constraints_all(NULL);
>  
> +	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
> +		intel_pmu_arch_lbr_init();

It looks fine to move the arch_lbr_init() after the model-specific
initialization, but need a double check. Let me run some tests on SPR and
NVL. Thanks.


> +
>  	/*
>  	 * Access LBR MSR may cause #GP under certain circumstances.
>  	 * Check all LBR MSR here.
