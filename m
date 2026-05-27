Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD25136728C;
	Wed, 27 May 2026 15:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779896820; cv=none; b=J7Fm2QtgVieRW2Ctnfs9B4dWiEEa30L51MCIy4mE4y3NE5csRe4iFg8jezc+/yP/g48Z+1XYTe/WqbctgssO1aMW6QDwQnNfPW+skgXjwJzYekyfWA7D/9DaZJsAr92s8jSRkMe0P4Wyw2GSUXAmPnuFGYaYUPsw2k+XmxqxTwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779896820; c=relaxed/simple;
	bh=lw09ZA7asiQeMkEr1eOzW60Kb+ZgDUTPcAoisC7e5aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B1x1NKIk/i2cLJc3W5phWcDXykTsZJyJRpb0mMnh6BHu69Xdwg5mDv2aknB9F3kNutFKDvfutmueYfd3orrIRLltBwIj/choijluxJ6IIGqn261Sy5qux6jNkh+C2TzvPNMBZ0oiYBmArnVzznC1rOinhsbN1vrNaOaGE0zgAx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WwEXZkCR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WwEXZkCR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779896819; x=1811432819;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lw09ZA7asiQeMkEr1eOzW60Kb+ZgDUTPcAoisC7e5aU=;
  b=WwEXZkCRhHC0WNz2R0RX7BOJNCCmdKnnvjlCez2aD404YUk+h2HvvxxJ
   X/bTuzh0p/68crwimWvjk3r/qKU5KkqxGBmxrGLteXc50wO1vWhknGHTm
   TZLPFp81erLyJV79nB8ogIVx7lZ+MS95ueoDRRRVfb41iSJVTlaJB2/WH
   BJCzcpiUvoSWlmKDfg2go61d8pO/t3N92YVmxkd6uOR31jRk7tpfYR8+n
   XHrPh0U7FIxpWVkr9u0rOKFGVGezDvg4gWYSp6Y0lraZFZ/dppo62EMSP
   bNCxtt5ukEUULSJ5k7dP4KzsJ0eIsYl1I4NpIxUxn0o4/LJ0qXQrKxzDl
   Q==;
X-CSE-ConnectionGUID: K4PbgLyvRR6I5iLsjkvGKg==
X-CSE-MsgGUID: 518xojIrTxiGmtb4gXUzyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="91837815"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; 
   d="scan'208";a="91837815"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:46:59 -0700
X-CSE-ConnectionGUID: cvTRD3XkQAWQb9GSODB5NA==
X-CSE-MsgGUID: Z3/uBhh7St2PMGqtcabiIg==
X-ExtLoop1: 1
Received: from soc-cp83kr3.clients.intel.com (HELO [10.122.185.5]) ([10.122.185.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 08:46:57 -0700
Message-ID: <50bf1eb8-da2a-4df8-bd06-9dffb77b7e2b@intel.com>
Date: Wed, 27 May 2026 10:46:56 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] perf pmu intel: Generalize SNC cpumask adjustment
 for multiple platforms
To: Chun-Tse Shao <ctshao@google.com>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, james.clark@linaro.org,
 linux-perf-users@vger.kernel.org
References: <20260515172710.428474-1-ctshao@google.com>
Content-Language: en-US
From: "Chen, Zide" <zide.chen@intel.com>
In-Reply-To: <20260515172710.428474-1-ctshao@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/15/2026 12:26 PM, Chun-Tse Shao wrote:
> Prepare for supporting more Intel platforms with sub-NUMA clustering by
> generalizing the GNR specific logic.
> 
> Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> ---

Reviewed-by: Zide Chen <zide.chen@intel.com>


> v6:
>   Make string literal.
>   Add SPR into SNC2.
> 
> v5: lore.kernel.org/20260407203918.3178481-1-ctshao@google.com/
>   Split patch.
> 
> v4: lore.kernel.org/20260402205300.1953706-1-ctshao@google.com
>   Rebase.
> 
> v3: lore.kernel.org/20260212223942.3832857-1-ctshao@google.com
>   Fix a typo.
> 
> v2: lore.kernel.org/20260205232220.1980168-1-ctshao@google.com
>   Split EMR and GNR in the SNC2 IMC cpu map.
> 
> v1: lore.kernel.org/20260108184430.1210223-1-ctshao@google.com
> 
>  tools/perf/arch/x86/util/pmu.c | 46 +++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 7c9d238922a6..b8fab260c423 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -22,20 +22,30 @@
>  #include "util/env.h"
>  #include "util/header.h"
> 
> -static bool x86__is_intel_graniterapids(void)
> +#define GENUINE_INTEL_GNR "GenuineIntel-6-A[DE]"
> +
> +static bool x86__is_snc_supported(void)
>  {
> -	static bool checked_if_graniterapids;
> -	static bool is_graniterapids;
> +	static bool checked_if_snc_supported;
> +	static bool is_supported;
> +
> +	if (!checked_if_snc_supported) {
> 
> -	if (!checked_if_graniterapids) {
> -		const char *graniterapids_cpuid = "GenuineIntel-6-A[DE]";
> +		/* Graniterapids supports SNC configuration. */
> +		static const char *const supported_cpuids[] = {
> +			GENUINE_INTEL_GNR, /* Graniterapids */
> +		};
>  		char *cpuid = get_cpuid_str((struct perf_cpu){0});
> 
> -		is_graniterapids = cpuid && strcmp_cpuid_str(graniterapids_cpuid, cpuid) == 0;
> +		for (size_t i = 0; i < ARRAY_SIZE(supported_cpuids); i++) {
> +			is_supported = cpuid && strcmp_cpuid_str(supported_cpuids[i], cpuid) == 0;
> +			if (is_supported)
> +				break;
> +		}
>  		free(cpuid);
> -		checked_if_graniterapids = true;
> +		checked_if_snc_supported = true;
>  	}
> -	return is_graniterapids;
> +	return is_supported;
>  }
> 
>  static struct perf_cpu_map *read_sysfs_cpu_map(const char *sysfs_path)
> @@ -132,8 +142,8 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  	// Compute the IMC SNC using lookup tables.
>  	unsigned int imc_num;
>  	int snc_nodes = snc_nodes_per_l3_cache();
> -	const u8 snc2_map[] = {1, 1, 0, 0, 1, 1, 0, 0};
> -	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2, 1, 1, 0, 0, 2, 2};
> +	const u8 snc2_map[] = {1, 1, 0, 0};
> +	const u8 snc3_map[] = {1, 1, 0, 0, 2, 2};
>  	const u8 *snc_map;
>  	size_t snc_map_len;
> 
> @@ -156,11 +166,12 @@ static int uncore_imc_snc(struct perf_pmu *pmu)
>  		pr_warning("Unexpected: unable to compute IMC number '%s'\n", pmu->name);
>  		return 0;
>  	}
> -	if (imc_num >= snc_map_len) {
> +	if (imc_num >= snc_map_len * perf_cpu_map__nr(pmu->cpus)) {
>  		pr_warning("Unexpected IMC %d for SNC%d mapping\n", imc_num, snc_nodes);
>  		return 0;
>  	}
> -	return snc_map[imc_num];
> +
> +	return snc_map[imc_num % snc_map_len];
>  }
> 
>  static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
> @@ -200,7 +211,7 @@ static int uncore_cha_imc_compute_cpu_adjust(int pmu_snc)
>  	return cpu_adjust[pmu_snc];
>  }
> 
> -static void gnr_uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
> +static void uncore_cha_imc_adjust_cpumask_for_snc(struct perf_pmu *pmu, bool cha)
>  {
>  	// With sub-NUMA clustering (SNC) there is a NUMA node per SNC in the
>  	// topology. For example, a two socket graniterapids machine may be set
> @@ -300,11 +311,12 @@ void perf_pmu__arch_init(struct perf_pmu *pmu)
>  				pmu->mem_events = perf_mem_events_intel_aux;
>  			else
>  				pmu->mem_events = perf_mem_events_intel;
> -		} else if (x86__is_intel_graniterapids()) {
> +		} else if (x86__is_snc_supported()) {
>  			if (strstarts(pmu->name, "uncore_cha_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> -			else if (strstarts(pmu->name, "uncore_imc_"))
> -				gnr_uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/true);
> +			else if (strstarts(pmu->name, "uncore_imc_") &&
> +				 !strstarts(pmu->name, "uncore_imc_free_running"))
> +				uncore_cha_imc_adjust_cpumask_for_snc(pmu, /*cha=*/false);
>  		}
>  	}
>  }
> --
> 2.54.0.669.g59709faab0-goog
> 
> 

