Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AA0236453;
	Thu, 23 Oct 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241067; cv=none; b=hxABUoBzH/gpe5j5oj1AHpVavihfHKARHDgXOuJx48DRiRzJHeKY3dG3BAB4ypHIpIe9eH3XLm2XGtZTDZrO3ulbDOMiIlenXtgipdlSaJluBaefujZGzlUjHhPEGYzSrfuge1XeqVDWejfKRqGPzqabskoTF9E5oOjaWgG4kfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241067; c=relaxed/simple;
	bh=lzcFnpcqKVPEICy/2QE1hnpva5jbOl2bOYeT8Uaf9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KAnmxUAW2xQzXKRb0PAe2TAJwhOrUmm+n0XF9VIDPH7PXjdptcq0KCKdrsFB1pe/+MhQ9gnx8FIIrzz+9Gh97phqC9d4hbGvkQRrn5zr8zPpuKpv0p2oJH8RlCUTuHys1S0JWLc1NnabUgG6s6ZZgO9BNz7C0TY7atXp8Tqp5T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMDL39t7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMDL39t7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761241066; x=1792777066;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lzcFnpcqKVPEICy/2QE1hnpva5jbOl2bOYeT8Uaf9Qw=;
  b=aMDL39t73nv21hpJLgmEOE24kBEzLeZWx3M1PxcG6+QWuXGzQqwMtdjs
   lwJOY3Y9/TRu9dQxT9NE+e+rdOlGoFG7awyjl2LarnzTqG/yG2vixyBdq
   8apshZvirQ0DOg1PPFd6/80i3eVp5SuDRxs1tfm3iEjEzhe4sSUSiJpd4
   lcejXhlxXtpX8NXB7TAS7y2YnXEGQX9rakQHTaD99+vIZmLjf61O7UgJW
   XnE8Vu8IHWJGlzWEowfsu3GC399nW8+ug4mFY/Q7XP9xeg5Wqz/LOhOD0
   2BOC2UBkPQFxF90OqWk4WIHW9Uww7sAuBXALDcCw5aCQiuSskURBRNOxo
   w==;
X-CSE-ConnectionGUID: z+hb8kxPTbaV8utc6Uv/9g==
X-CSE-MsgGUID: 7bN4UnRySkqgFhOzFwu6Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63459236"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63459236"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:37:45 -0700
X-CSE-ConnectionGUID: eZL2laQuT0W+6mnmBxoEXg==
X-CSE-MsgGUID: Fbsuxk7LRQ2lxB0shpB1BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183440547"
Received: from unknown (HELO [10.241.241.181]) ([10.241.241.181])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 10:37:44 -0700
Message-ID: <725ad7f4-f383-4dd8-8134-0ae2fc3d37b2@intel.com>
Date: Thu, 23 Oct 2025 10:37:42 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf/x86/intel: Add PMU support for WildcatLake
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>,
 Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20250908061639.938105-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/7/2025 11:16 PM, Dapeng Mi wrote:
> WildcatLake is a variant of PantherLake and shares same PMU features,
> so directly reuse Pantherlake's code to enable PMU features for
> WildcatLake.
> 
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

For the patch set:

Reviewed-by: Zide Chen <zide.chen@intel.com>

> ---
>  arch/x86/events/intel/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 28f5468a6ea3..fe65be0b9d9c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -7596,6 +7596,7 @@ __init int intel_pmu_init(void)
>  		break;
>  
>  	case INTEL_PANTHERLAKE_L:
> +	case INTEL_WILDCATLAKE_L:
>  		pr_cont("Pantherlake Hybrid events, ");
>  		name = "pantherlake_hybrid";
>  		goto lnl_common;
> 
> base-commit: 16ed389227651330879e17bd83d43bd234006722

