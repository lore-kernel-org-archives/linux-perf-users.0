Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A7D373C0C;
	Fri, 27 Mar 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774631143; cv=none; b=GkDvC3Gu5xTWU8iTr9nLhEvrlX5N2rVv3eHiSmF3/43jwRiYImYE2QrDW4A/wOkIFbJ0SQnrp63KaB0QJfkkd6TRlKatREdIlF6c/POqtyAoEPmWiBVWzmWVLuxagX+BPJTgJkSKkN9gT2p6oK4H58gFJDY7nxrdWCIroPgtezU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774631143; c=relaxed/simple;
	bh=re2qH/iKq7gw7n3d/e2H1mnXYP5UtGjZZ0t8FJYpQnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lCTaSpzptrJHshk8gm6+5Rixvjk/sSQCuFIbG5AYNmuBhVkgmKyJBTuhTxYeRp5+zga1nRiRz0rOuTNCrJ7Bjc/kef00oHUf6OWzLFSF/CdLaY30DAlr6NC7BJ2Eo1DooSmyimpf3N+tksxFTnEYlkIoCZdNtFB5CtaBk36X5cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FeulRE0a; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FeulRE0a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774631141; x=1806167141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=re2qH/iKq7gw7n3d/e2H1mnXYP5UtGjZZ0t8FJYpQnM=;
  b=FeulRE0aJvvkwe8qV25u1UzK4I36iufKanKMuEZJVAkGftvKtSdqHAzz
   BGijaUBRfNPIZfIZ+lkbElDtqbDu5dVdSirfLUu/OXPehbAdSB51x5wDr
   6DO+hKaneeQXzl4jXDcV9o8+JRN4aMa6KqkkHLGpKU/hFzoBt6HgP0+AH
   P+IhnqCpW3tlUK/l3uR8OlccsKSQan+jb1ddmkUu2fJuzyfu5rS7u1oWf
   F2xJ8yefmTKOkhLu1RT3QP9wEXV5PR+aCFxOo8uHv/+UhbW5Q35IniZXz
   gv9NDNGTrRLbf1r/WhXNrtjk3pIWi21LVZhDHsIWif1yR7z1o1tIghJiu
   w==;
X-CSE-ConnectionGUID: B3v6idPYR72HM0gkLobX2w==
X-CSE-MsgGUID: J8SO8SG+S6i+ywc1mROvdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75612715"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="75612715"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:05:39 -0700
X-CSE-ConnectionGUID: cmmKfPhbQtqZ8FLvE+o7Cw==
X-CSE-MsgGUID: d3ja/bTFRUaJ9Wl/WYvdfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="220973199"
Received: from unknown (HELO [10.241.240.169]) ([10.241.240.169])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:05:39 -0700
Message-ID: <b65adc63-edf2-4927-8913-a431290d673d@intel.com>
Date: Fri, 27 Mar 2026 10:05:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] perf/x86/msr: Make SMI and PPERF on by default
To: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andi Kleen <ak@linux.intel.com>, Eranian Stephane <eranian@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Falcon Thomas <thomas.falcon@intel.com>,
 Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
References: <20260327052844.818218-1-dapeng1.mi@linux.intel.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260327052844.818218-1-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/2026 10:28 PM, Dapeng Mi wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The MSRs, SMI_COUNT and PPERF, are model-specific MSRs. A very long
> CPU ID list is maintained to indicate the supported platforms. With more
> and more platforms being introduced, new CPU IDs have to be kept adding.
> Also, the old kernel has to be updated to apply the new CPU ID.
> 
> The MSRs have been introduced for a long time. There is no plan to
> change them in the near future. Furthermore, the current code utilizes
> rdmsr_safe() to check the availability of MSRs before using it.
> 
> Make them on by default. It should be good enough to only rely on the
> rdmsr_safe() to check their availability for both existing and future
> platforms.
> 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>

> 
> V2: Removed stale #include <asm/cpu_device_id.h>.
> 
> V1: https://lore.kernel.org/lkml/20240910192626.768146-1-kan.liang@linux.intel.com/
> 
>  arch/x86/events/msr.c | 82 ++-----------------------------------------
>  1 file changed, 3 insertions(+), 79 deletions(-)
> 
> diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
> index 8052596b8503..76d6418c5055 100644
> --- a/arch/x86/events/msr.c
> +++ b/arch/x86/events/msr.c
> @@ -2,7 +2,6 @@
>  #include <linux/perf_event.h>
>  #include <linux/sysfs.h>
>  #include <linux/nospec.h>
> -#include <asm/cpu_device_id.h>
>  #include <asm/msr.h>
>  
>  #include "probe.h"
> @@ -41,86 +40,11 @@ static bool test_therm_status(int idx, void *data)
>  
>  static bool test_intel(int idx, void *data)
>  {
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL ||
> -	    boot_cpu_data.x86 != 6)
> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>  		return false;
>  
> -	switch (boot_cpu_data.x86_vfm) {
> -	case INTEL_NEHALEM:
> -	case INTEL_NEHALEM_G:
> -	case INTEL_NEHALEM_EP:
> -	case INTEL_NEHALEM_EX:
> -
> -	case INTEL_WESTMERE:
> -	case INTEL_WESTMERE_EP:
> -	case INTEL_WESTMERE_EX:
> -
> -	case INTEL_SANDYBRIDGE:
> -	case INTEL_SANDYBRIDGE_X:
> -
> -	case INTEL_IVYBRIDGE:
> -	case INTEL_IVYBRIDGE_X:
> -
> -	case INTEL_HASWELL:
> -	case INTEL_HASWELL_X:
> -	case INTEL_HASWELL_L:
> -	case INTEL_HASWELL_G:
> -
> -	case INTEL_BROADWELL:
> -	case INTEL_BROADWELL_D:
> -	case INTEL_BROADWELL_G:
> -	case INTEL_BROADWELL_X:
> -	case INTEL_SAPPHIRERAPIDS_X:
> -	case INTEL_EMERALDRAPIDS_X:
> -	case INTEL_GRANITERAPIDS_X:
> -	case INTEL_GRANITERAPIDS_D:
> -
> -	case INTEL_ATOM_SILVERMONT:
> -	case INTEL_ATOM_SILVERMONT_D:
> -	case INTEL_ATOM_AIRMONT:
> -	case INTEL_ATOM_AIRMONT_NP:
> -
> -	case INTEL_ATOM_GOLDMONT:
> -	case INTEL_ATOM_GOLDMONT_D:
> -	case INTEL_ATOM_GOLDMONT_PLUS:
> -	case INTEL_ATOM_TREMONT_D:
> -	case INTEL_ATOM_TREMONT:
> -	case INTEL_ATOM_TREMONT_L:
> -
> -	case INTEL_XEON_PHI_KNL:
> -	case INTEL_XEON_PHI_KNM:
> -		if (idx == PERF_MSR_SMI)
> -			return true;
> -		break;
> -
> -	case INTEL_SKYLAKE_L:
> -	case INTEL_SKYLAKE:
> -	case INTEL_SKYLAKE_X:
> -	case INTEL_KABYLAKE_L:
> -	case INTEL_KABYLAKE:
> -	case INTEL_COMETLAKE_L:
> -	case INTEL_COMETLAKE:
> -	case INTEL_ICELAKE_L:
> -	case INTEL_ICELAKE:
> -	case INTEL_ICELAKE_X:
> -	case INTEL_ICELAKE_D:
> -	case INTEL_TIGERLAKE_L:
> -	case INTEL_TIGERLAKE:
> -	case INTEL_ROCKETLAKE:
> -	case INTEL_ALDERLAKE:
> -	case INTEL_ALDERLAKE_L:
> -	case INTEL_ATOM_GRACEMONT:
> -	case INTEL_RAPTORLAKE:
> -	case INTEL_RAPTORLAKE_P:
> -	case INTEL_RAPTORLAKE_S:
> -	case INTEL_METEORLAKE:
> -	case INTEL_METEORLAKE_L:
> -		if (idx == PERF_MSR_SMI || idx == PERF_MSR_PPERF)
> -			return true;
> -		break;
> -	}
> -
> -	return false;
> +	/* Rely on perf_msr_probe() to check the availability */
> +	return true;
>  }
>  
>  PMU_EVENT_ATTR_STRING(tsc,				attr_tsc,		"event=0x00"	);
> 
> base-commit: 6ee26b7a224b27aa7e8e1ee8a845a31664d2e97c

