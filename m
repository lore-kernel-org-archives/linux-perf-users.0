Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7B224B0C;
	Thu, 29 May 2025 13:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526914; cv=none; b=DB/i6a6KpvzKbd/5yLjhmo+XlbwyYmPWp3SDqWKChd3CG5XVGnSfM+EXAFh26tTDGRnarCKt6xKLXW5rULpcdaIJB6/xEHhQhftXQ/UNmte+Z7McTLu3axVzHThyxel1tLQyaWRCXXbUHbhlRG91OU3C9nZIn/Wqtn1qmhOhB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526914; c=relaxed/simple;
	bh=G6MYj7tDlBG6ihRODDrMPrZswnb0XZ1sFLnRqkIKIrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bpCcJ2+PonuQ60rQDX9UsUA56BNfgkOg4KMg/K080ntANtQ9LrjXSqOqvqHd/emTOlSRDPpUAbyhvsCB2KPUyEU2z9s09L2WvuKnlBpa//3h3d47vZ5RdYjmm3XSbsMJtrodxdObUoxuYZlUofZ4AfO6AaqUg6jZQpWGqgxAMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BR1zPimQ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BR1zPimQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748526913; x=1780062913;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G6MYj7tDlBG6ihRODDrMPrZswnb0XZ1sFLnRqkIKIrc=;
  b=BR1zPimQCET2ERKMYJZwG7Y39b4PshVWZq28WCzKCtv7PeAnGdVZZvXE
   oRWC9GAjdZ2Yu+lufaiYz2DU1g+Hf7PN7HYLzMFr4Re+Q5JLEVNw5Bq8g
   z4SoW42znXyEDGxUZ5z9ThQBSVVxH7bzozoCgHjf5CXHbQyz7V7Ika13c
   0knPSyohL6EW7/sdLaIPxuyZ0Qx73fjWE5xih6Z/mPFBmZTSLLAhJ/Flh
   SgJIgUbP6a9QxIVFAtgIcROeSsAYHgJgX9pSBzN+17p/Jyg+WZg3bAn5G
   ToyiFm6zcIQg1NLuRG//+6h6sY/bveY/JspEd7uEPxpV5U0GQTU7zAYtD
   w==;
X-CSE-ConnectionGUID: yUJ/z+JBRxmvbh6smBtOHA==
X-CSE-MsgGUID: XaP0iFtvQj2hOPfSv0iTXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="61224170"
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="61224170"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 06:55:12 -0700
X-CSE-ConnectionGUID: H2SIpIScRGSZhF32/71SNw==
X-CSE-MsgGUID: 10CXz9OuStmoMkGtZkhBbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,193,1744095600"; 
   d="scan'208";a="144196127"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 06:55:12 -0700
Received: from [10.246.136.52] (kliang2-mobl1.ccr.corp.intel.com [10.246.136.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by linux.intel.com (Postfix) with ESMTPS id 2133F20B5736;
	Thu, 29 May 2025 06:55:10 -0700 (PDT)
Message-ID: <8f94b5b7-0552-4860-8ff1-bec83e3abb3e@linux.intel.com>
Date: Thu, 29 May 2025 09:55:09 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] perf/x86/intel: Fix wrong index calculation in
 intel_pmu_config_acr()
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250529080236.2552247-1-dapeng1.mi@linux.intel.com>
 <20250529080236.2552247-2-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20250529080236.2552247-2-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025-05-29 4:02 a.m., Dapeng Mi wrote:
> To calculate fixed counter MSR address, the HW counter index "idx" is
> subtracted by INTEL_PMC_IDX_FIXED. It leads to the ACR mask value of
> fixed counters is incorrectly saved to the positions of GP counters
> in acr_cfg_b[], e.g. For fixed counter 0, its ACR counter mask should be
> saved to acr_cfg_b[32], but it's saved to acr_cfg_b[0] incorrectly.
> 
> Fix this issue.
> 
> Fixes: ec980e4facef ("perf/x86/intel: Support auto counter reload")
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>

Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks,
Kan

> ---
>  arch/x86/events/intel/core.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 8d046b1a237e..b0fee684ec8c 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -2899,6 +2899,7 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
>  {
>  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>  	int msr_b, msr_c;
> +	int msr_offset;
>  
>  	if (!mask && !cpuc->acr_cfg_b[idx])
>  		return;
> @@ -2906,19 +2907,20 @@ static void intel_pmu_config_acr(int idx, u64 mask, u32 reload)
>  	if (idx < INTEL_PMC_IDX_FIXED) {
>  		msr_b = MSR_IA32_PMC_V6_GP0_CFG_B;
>  		msr_c = MSR_IA32_PMC_V6_GP0_CFG_C;
> +		msr_offset = x86_pmu.addr_offset(idx, false);
>  	} else {
>  		msr_b = MSR_IA32_PMC_V6_FX0_CFG_B;
>  		msr_c = MSR_IA32_PMC_V6_FX0_CFG_C;
> -		idx -= INTEL_PMC_IDX_FIXED;
> +		msr_offset = x86_pmu.addr_offset(idx - INTEL_PMC_IDX_FIXED, false);
>  	}
>  
>  	if (cpuc->acr_cfg_b[idx] != mask) {
> -		wrmsrl(msr_b + x86_pmu.addr_offset(idx, false), mask);
> +		wrmsrl(msr_b + msr_offset, mask);
>  		cpuc->acr_cfg_b[idx] = mask;
>  	}
>  	/* Only need to update the reload value when there is a valid config value. */
>  	if (mask && cpuc->acr_cfg_c[idx] != reload) {
> -		wrmsrl(msr_c + x86_pmu.addr_offset(idx, false), reload);
> +		wrmsrl(msr_c + msr_offset, reload);
>  		cpuc->acr_cfg_c[idx] = reload;
>  	}
>  }

